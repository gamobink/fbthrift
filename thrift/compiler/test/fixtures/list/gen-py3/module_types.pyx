#
# Autogenerated by Thrift
#
# DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
#  @generated
#

from libcpp.memory cimport shared_ptr, make_shared, unique_ptr, make_unique
from libcpp.string cimport string
from libcpp cimport bool as cbool
from libcpp.iterator cimport inserter as cinserter
from cpython cimport bool as pbool
from libc.stdint cimport int8_t, int16_t, int32_t, int64_t
from cython.operator cimport dereference as deref, preincrement as inc
from thrift.lib.py3.thrift_server cimport TException
cimport std_libcpp

from collections.abc import Sequence, Set, Mapping, Iterable
from enum import Enum




cdef class List__string:
    def __init__(self, items=None):
        if isinstance(items, List__string):
            self._vector = (<List__string> items)._vector
        else:
          self._vector = make_shared[vector[string]]()
          if items:
              for item in items:
                  deref(self._vector).push_back(item.encode('UTF-8'))

    @staticmethod
    cdef create(
            shared_ptr[vector[string]] c_items):
        inst = <List__string>List__string.__new__(List__string)
        inst._vector = c_items
        return inst

    def __getitem__(self, int index):
        cdef string citem = (
            deref(self._vector.get())[index])
        return bytes(citem).decode()

    def __len__(self):
        return deref(self._vector).size()

    def __richcmp__(self, other, op):
        cdef int cop = op
        if cop not in (2, 3):
            raise TypeError("unorderable types: {}, {}".format(type(self), type(other)))
        if not (isinstance(self, Iterable) and isinstance(other, Iterable)):
            return cop != 2
        if (len(self) != len(other)):
            return cop != 2

        for one, two in zip(self, other):
            if one != two:
                return cop != 2

        return cop == 2

    def __hash__(self):
        return hash(tuple(self))

    def __contains__(self, item):
        cdef string citem = item.encode('UTF-8')
        cdef vector[string] vec = deref(
            self._vector.get())
        return std_libcpp.find(vec.begin(), vec.end(), citem) != vec.end()

    def __iter__(self):
        cdef string citem
        for citem in deref(self._vector):
            yield bytes(citem).decode()

    def __reversed__(self):
        cdef string citem
        cdef vector[string] vec = deref(
            self._vector.get())
        cdef vector[string].reverse_iterator loc = vec.rbegin()
        while loc != vec.rend():
            citem = deref(loc)
            yield bytes(citem).decode()
            inc(loc)

    def index(self, item):
        cdef string citem = item.encode('UTF-8')
        cdef vector[string] vec = deref(self._vector.get())
        cdef vector[string].iterator loc = std_libcpp.find(vec.begin(), vec.end(), citem)
        if loc != vec.end():
            return <int64_t> std_libcpp.distance(vec.begin(), loc)
        raise ValueError("{} is not in list".format(item))

    def count(self, item):
        cdef string citem = item.encode('UTF-8')
        cdef vector[string] vec = deref(self._vector.get())
        return <int64_t> std_libcpp.count(vec.begin(), vec.end(), citem)


Sequence.register(List__string)

cdef class Map__i64_List__string:
    def __init__(self, items=None):
        if isinstance(items, Map__i64_List__string):
            self._map = (<Map__i64_List__string> items)._map
        else:
          self._map = make_shared[cmap[int64_t,vector[string]]]()
          if items:
              for key, item in items.items():
                  deref(self._map).insert(
                      cpair[int64_t,vector[string]](
                          key,
                          deref(List__string(item)._vector.get())))

    @staticmethod
    cdef create(shared_ptr[cmap[int64_t,vector[string]]] c_items):
        inst = <Map__i64_List__string>Map__i64_List__string.__new__(Map__i64_List__string)
        inst._map = c_items
        return inst

    def __getitem__(self, key):
        cdef int64_t ckey = key
        cdef cmap[int64_t,vector[string]].iterator iter = deref(
            self._map).find(ckey)
        if iter == deref(self._map).end():
            raise KeyError(str(key))
        cdef vector[string] citem = deref(iter).second
        return List__string.create(
    make_shared[vector[string]](citem))

    def __len__(self):
        return deref(self._map).size()

    def __iter__(self):
        cdef int64_t citem
        for pair in deref(self._map):
            citem = pair.first
            yield citem

    def __richcmp__(self, other, op):
        cdef int cop = op
        if cop not in (2, 3):
            raise TypeError("unorderable types: {}, {}".format(type(self), type(other)))
        if not (isinstance(self, Mapping) and isinstance(other, Mapping)):
            return cop != 2
        if (len(self) != len(other)):
            return cop != 2

        for key in self:
            if key not in other:
                return cop != 2
            if other[key] != self[key]:
                return cop != 2

        return cop == 2

    def __hash__(self):
        return hash(tuple((tuple(self), tuple(self[k] for k in self))))

    def __contains__(self, key):
        cdef int64_t ckey = key
        return deref(self._map).count(ckey) > 0

    def get(self, key, default=None):
        cdef int64_t ckey = key
        cdef cmap[int64_t,vector[string]].iterator iter = \
            deref(self._map).find(ckey)
        if iter == deref(self._map).end():
            return default
        cdef vector[string] citem = deref(iter).second
        return List__string.create(
    make_shared[vector[string]](citem))

    def keys(self):
        return self.__iter__()

    def values(self):
        cdef vector[string] citem
        for pair in deref(self._map):
            citem = pair.second
            yield List__string.create(
    make_shared[vector[string]](citem))

    def items(self):
        cdef int64_t ckey
        cdef vector[string] citem
        for pair in deref(self._map):
            ckey = pair.first
            citem = pair.second

            yield (ckey, List__string.create(
    make_shared[vector[string]](citem)))



Mapping.register(Map__i64_List__string)


TEST_MAP = Map__i64_List__string.create(make_shared[cmap[int64_t,vector[string]]](cTEST_MAP()))
