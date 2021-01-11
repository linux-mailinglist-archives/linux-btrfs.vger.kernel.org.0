Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAE22F0F50
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 10:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbhAKJmk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 04:42:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:33712 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbhAKJmk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 04:42:40 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9YxO7046400;
        Mon, 11 Jan 2021 09:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=iF4GXyIXKgNs5hnvy0J0/fcNjOQDJMoXkmMHtIZYmhw=;
 b=zo5pkPfvWLD9eJEyi3PCk6q0gUyDBa08ug4B+dcobZYTJWqsGWWlS/mOPQ5D8PMINAIL
 mc2l6X6FNtlimSeQ+Z5n7Mz6EjMsg/mGGJvAKBmuNrWCVsGhcpi6v4WBTCcqvPmqPSNz
 aMGBXcVmH0/dmezOP3jMlGs0Ej5gsZo5dkP4YnWlIeHGdKOT5vlUWUa8SwkLeecQ9del
 eNhyKMvN5GjLTkztdmRfahGiuFHOOIbMxURa8V3XgQhO5oCJtaF21a9wocgY6vQvdL/l
 3yYjopyvNmdSY3e7Msr4uoYguqobONNNaQLVx1Kg/+sPfJjGHZsJiLraTuviqNy3UQnp XA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 360kvjr4xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jan 2021 09:41:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10B9VKrt107713;
        Mon, 11 Jan 2021 09:41:49 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 360ke4t0pj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 09:41:49 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10B9fmVt012642;
        Mon, 11 Jan 2021 09:41:48 GMT
Received: from localhost.localdomain (/39.109.186.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 Jan 2021 01:41:47 -0800
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v3 0/4] btrfs: read_policy types latency, device and round-robin
Date:   Mon, 11 Jan 2021 17:41:33 +0800
Message-Id: <cover.1610324448.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101110057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9860 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101110057
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

v3:
The block layer commit 0d02129e76ed (block: merge struct block_device and
struct hd_struct) has changed the first argument in the function
part_stat_read_all() in 5.11-rc1. So trickle down its changes in the patch 1/4.

v2:
Fixes as per review comments, as in the individual patches.

v1:
Drop tracing patch
Drop factoring inflight command
  Here below is the performance differences, when inflight is used, it pushed
  few commands to the other device, so losing the potential merges.
Few C styles fixes.

-----

This patchset adds read policy types latency, device, and round-robin, for the
mirrored raid profiles such as raid1, raid1c3, raid1c4, and raid10. The default
read policy remains as PID, as of now.

Read policy types:
Latency:

Latency policy routes the read IO based on the historical average
wait time experienced by the read IOs on the individual device.

Device:

With the device policy along with the read_preferred flag, you can
set the device for reading manually. Useful to test mirrors in a
deterministic way and helps advance system administrations.

Round-robin (RFC patch):

Alternates striped device in a round-robin loop for reading. To achieve
this first we put the stripes in an array, sort it by devid and pick the
next device.

Test scripts:
=============

I have included a few scripts which were useful for testing.

-------------------8<--------------------------------
Set latency policy on the btrfs mounted at /mnt

Usage example:
  $ readpolicyset /mnt latency

$ cat readpolicyset
#!/bin/bash

: ${1?"arg1 <mnt> missing"}
: ${2?"arg2 <pid|latency|device|roundrobin> missing"}

mnt=$1
policy=$2
[ $policy == "device" ] && { : ${3?"arg3 <devid> missing"}; }
devid=$3

uuid=$(btrfs fi show -m /btrfs | grep uuid | awk '{print $4}')
p=/sys/fs/btrfs/$uuid/read_policy
q=/sys/fs/btrfs/$uuid/devinfo

[ $policy == "device" ] && { echo 1 > ${q}/$devid/read_preferred || exit $?; }

echo $policy > $p
exit $?

-------------------8<--------------------------------

Read policy type from the btrfs mounted at /mnt

Usage example:
  $ readpolicy /mnt

$ cat readpolicy
#!/bin/bash

: ${1?"arg1 <mnt> missing"}
mnt=$1

uuid=$(btrfs fi show -m /btrfs | grep uuid | awk '{print $4}')
p=/sys/fs/btrfs/$uuid/read_policy
q=/sys/fs/btrfs/$uuid/devinfo

policy=$(cat $p)
echo -n "$policy ( "

for i in $(find $q -type f -name read_preferred | xargs cat)
do
	echo -n "$i"
done
echo ")"
-------------------8<--------------------------------

Show the number of read IO per devices for the give command.

Usage example:
   $ readstat /mnt fioread

$ cat readstat 
#!/bin/bash

: ${1?"arg1 <mnt> is missing"}
: ${2?"arg2 <cmd-to-run> is missing"}

mnt=$1; shift
mountpoint -q $mnt || { echo "ERROR: $mnt is not mounted"; exit 1; }

declare -A devread

for dev in $(btrfs filesystem show -m $mnt | grep devid |awk '{print $8}')
do
	prefix=$(echo $dev | rev | cut -d"/" -f1 | rev)
	sysfs_path=$(find /sys | grep $prefix/stat$)

	devread[$sysfs_path]=$(cat $sysfs_path | awk '{print $1}')
done

"$@" | grep "READ: bw"

echo
echo
for sysfs_path in ${!devread[@]}
do
	dev=$(echo $sysfs_path | rev | cut -d"/" -f2 | rev)
	new=$(cat $sysfs_path | awk '{print $1}')
	old=${devread[$sysfs_path]}
	echo "$dev $((new - old))"
done
-------------------8<--------------------------------

Run fio read command 

Usage example:
    $ touch /mnt/largefile
    $ fioread /mnt/largefile 500m

$ cat fioread 
#!/bin/bash

: ${1?"arg1 </mnt/file> is missing"}
: ${2?"arg2 <1Gi|50Gi> is missing"}

tf=$1
sz=$2
mnt=$(stat -c '%m' $tf)

fio \
--filename=$tf \
--directory=$mnt \
--filesize=$sz \
--size=$sz \
--rw=randread \
--bs=64k \
--ioengine=libaio \
--direct=1 \
--numjobs=32 \
--group_reporting \
--thread \
--name iops-test-job
-------------------8<--------------------------------


Testing on guest VM
~~~~~~~~~~~~~~~~~~~

The test results from my VM with 2 devices of type sata and 2 devices of 
type virtio, are below. Performance results are for raid1c4, raid10, and raid1
are as below.

The workload is fio read 32 threads, 500m random reads.

Fio is passed to the script called readstat, which returns the number of read IOs
per device sent during the fio.

Supporting fio logs are below. And readstat shows the number of read IOs
to the devices (excluding the merges).

raid1c4
=======

pid
----

$ readpolicyset /btrfs pid && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

[pid] latency device roundrobin ( 0000)
 READ: bw=87.0MiB/s (91.2MB/s), 87.0MiB/s-87.0MiB/s (91.2MB/s-91.2MB/s), io=15.6GiB (16.8GB), run=183884-183884msec

vdb 64060
vdc 64053
sdb 64072
sda 64054


latency
-------

(All devices are non-rotational, but sda and sdb are of type sata and vdb and vdc are of type virtio).

$ readpolicyset /btrfs latency && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

pid [latency] device roundrobin ( 0000)
 READ: bw=87.1MiB/s (91.3MB/s), 87.1MiB/s-87.1MiB/s (91.3MB/s-91.3MB/s), io=15.6GiB (16.8GB), run=183774-183774msec

vdb 255844
vdc 559
sdb 0
sda 93


roundrobin
----------

$ readpolicyset /btrfs roundrobin && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

pid latency device [roundrobin] ( 0000)
 READ: bw=51.0MiB/s (54.5MB/s), 51.0MiB/s-51.0MiB/s (54.5MB/s-54.5MB/s), io=15.6GiB (16.8GB), run=307755-307755msec

vdb 866859
vdc 866651
sdb 864139
sda 865533


raid10
======

pid
---

$ readpolicyset /btrfs pid && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

[pid] latency device roundrobin ( 0000)
 READ: bw=85.2MiB/s (89.3MB/s), 85.2MiB/s-85.2MiB/s (89.3MB/s-89.3MB/s), io=15.6GiB (16.8GB), run=187864-187864msec


sdf 64053
sde 64036
sdd 64043
sdc 64038


latency
-------

$ readpolicyset /btrfs latency && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

pid [latency] device roundrobin ( 0000)
 READ: bw=85.4MiB/s (89.5MB/s), 85.4MiB/s-85.4MiB/s (89.5MB/s-89.5MB/s), io=15.6GiB (16.8GB), run=187370-187370msec


sdf 117494
sde 10748
sdd 125247
sdc 2921

roundrobin
----------

$ readpolicyset /btrfs roundrobin && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

pid latency device [roundrobin] ( 0000)
 READ: bw=55.4MiB/s (58.1MB/s), 55.4MiB/s-55.4MiB/s (58.1MB/s-58.1MB/s), io=15.6GiB (16.8GB), run=288701-288701msec

sdf 617593
sde 617381
sdd 618486
sdc 618633


raid1
=====

pid
----

$ readpolicyset /btrfs pid && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

[pid] latency device roundrobin ( 00)
 READ: bw=78.8MiB/s (82.6MB/s), 78.8MiB/s-78.8MiB/s (82.6MB/s-82.6MB/s), io=15.6GiB (16.8GB), run=203158-203158msec

sdb 128087
sda 128090


latency
--------

$ readpolicyset /btrfs latency && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

pid [latency] device roundrobin ( 00)
 READ: bw=86.5MiB/s (90.7MB/s), 86.5MiB/s-86.5MiB/s (90.7MB/s-90.7MB/s), io=15.6GiB (16.8GB), run=185023-185023msec

sdb 567
sda 255942


device
-------

(From the latency test results (above) we know sda is providing low latency read
IO. So set sda as read preferred device.)

$ readpolicyset /btrfs device 1 && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

pid latency [device] roundrobin ( 10)
 READ: bw=88.2MiB/s (92.5MB/s), 88.2MiB/s-88.2MiB/s (92.5MB/s-92.5MB/s), io=15.6GiB (16.8GB), run=181374-181374msec

sdb 0
sda 256191


roundrobin
-----------

$ readpolicyset /btrfs roundrobin && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

pid latency device [roundrobin] ( 00)
 READ: bw=54.1MiB/s (56.7MB/s), 54.1MiB/s-54.1MiB/s (56.7MB/s-56.7MB/s), io=15.6GiB (16.8GB), run=295693-295693msec

sdb 1252584
sda 1254258


Testing on real hardware:
~~~~~~~~~~~~~~~~~~~~~~~~

raid1 Read 500m
-----------------------------------------------------
            |nvme+ssd  nvme+ssd   all-nvme  all-nvme
            |random    sequential random    sequential
------------+------------------------------------------
pid         | 744MiB/s  809MiB/s  2225MiB/s 2155MiB/s
latency     |2072MiB/s 2008MiB/s  1999MiB/s 1961MiB/s
device(nvme)|2187MiB/s 2063MiB/s  2125MiB/s 2080MiB/s
roundrobin  | 527MiB/s  519MiB/s  2137MiB/s 1876MiB/s


raid10 Read 500m
-----------------------------------------------------
            | nvme+ssd  nvme+ssd  all-nvme  all-nvme
            | random    seq       random    seq
------------+-----------------------------------------
pid         | 1282MiB/s 1427MiB/s 2152MiB/s 1969MiB/s
latency     | 2073MiB/s 1871MiB/s 1975MiB/s 1984MiB/s
device(nvme)| 2447MiB/s 1873MiB/s 2184MiB/s 2015MiB/s
roundrobin  | 1117MiB/s 1076MiB/s 2020MiB/s 2030MiB/s


raid1c3 Read 500m
-----------------------------------------------------
            | nvme+ssd  nvme+ssd  all-nvme  all-nvme
            | random    seq       random    seq
------------+-----------------------------------------
pid         |  973MiB/s  955MiB/s 2144MiB/s 1962MiB/s
latency     | 2005MiB/s 1924MiB/s 2083MiB/s 1980MiB/s
device(nvme)| 2021MiB/s 2034MiB/s 1920MiB/s 2132MiB/s
roundrobin  |  707MiB/s  701MiB/s 1760MiB/s 1990MiB/s


raid1c4 Read 500m
-----------------------------------------------------
            | nvme+ssd  nvme+ssd  all-nvme  all-nvme
            | random    seq       random    seq
------------+----------------------------------------
pid         | 1204MiB/s 1221MiB/s 2065MiB/s 1878MiB/s
latency     | 1990MiB/s 1920MiB/s 1945MiB/s 1865MiB/s
device(nvme)| 2109MiB/s 1935MiB/s 2153MiB/s 1991MiB/s
roundrobin  |  887MiB/s  865MiB/s 1948MiB/s 1796MiB/s


Observations:
=============

1.
As our chunk allocation is based on the device's available size
at that time. So stripe 0 may be circulating among the devices.
So a single-threaded process running with a constant PID, may balance
the read IO among devices. But it is not guaranteed to work in all the
cases, and it might not work very well in the case of raid1c3/4. Further,
PID provides terrible performance if the devices are heterogeneous in
terms of either type, speed, or size.

2.
Latency provides performance equal to PID if all devices are of same
type. Latency needs iostat be enabled and includes cost of calculating
the avg. wait time. So if you factor in a similar cost of calculating the
avg. wait time in case of PID policy (using the debug code [2]) then the
Latency performance is better than PID. This proves that read IO
distribution as per latency is working, but there is a cost to it. And
moreover, latency works for any type of devices.

3.
Round robin is worst (unless there is a bug in my patch). The total
number of new IOs issued is almost double when compared with the PID and
Latency read_policy, that's because there were fewer number of IO merges
in the block layer due to constant switching of devices in the btrfs.

4.
4.
Device read_policy is useful in testing and provides advanced sysadmin
capabilities. When known how to use, the policy could help avert
performance degradation due to csum/IO errors at production.

Thanks, Anand

------------------
[2] Debug patch to factor the cost of calculating the latency per IO.

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d3023879bdf6..72ec633e9063 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5665,6 +5665,12 @@ static int find_live_mirror(struct btrfs_fs_info *fs_info,
 fs_info->fs_devices->read_policy = BTRFS_READ_POLICY_PID;
 fallthrough;
 case BTRFS_READ_POLICY_PID:
+ /*
+ * Just to factor in the cost of calculating the avg wait using
+ * iostat, call btrfs_find_best_stripe() here for the PID policy
+ * and drop its results on the floor.
+ */
+ btrfs_find_best_stripe(fs_info, map, first, num_stripes, log,
+ logsz);
 preferred_mirror = first + current->pid % num_stripes;
 scnprintf(log, logsz,
 "first %d num_stripe %d %s (%d) preferred %d",

Anand Jain (4):
  btrfs: add read_policy latency
  btrfs: introduce new device-state read_preferred
  btrfs: introduce new read_policy device
  btrfs: introduce new read_policy round-robin

 fs/btrfs/sysfs.c   |  57 ++++++++++++++++++++++-
 fs/btrfs/volumes.c | 110 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h |   8 ++++
 3 files changed, 174 insertions(+), 1 deletion(-)

-- 
2.30.0

