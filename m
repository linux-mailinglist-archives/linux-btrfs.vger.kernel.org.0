Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8029E217
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Oct 2020 03:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgJ2CFt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Oct 2020 22:05:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47080 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgJ1ViH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Oct 2020 17:38:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDJKtG078535;
        Wed, 28 Oct 2020 13:26:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=yhL5CAL9LT94yQPLBhueHOKKx2wAHjLKZizJaj+mDLg=;
 b=n/4BlmtqiAeTRoi4CFHsWwADHs35Iaq7skTXUhfNx5lNtt+Bp6eV+DQZ+JRrGkyITHrc
 Xij66g6oni+frgZTKdgk08fBzmdXdN8A8Tb4TXLoYgGYhoIwiqevgm84QEgFMtWz3vxV
 YcWKsQybPvIGvQdZX+FUdwRPqnIygxl/C6F5uCYx0grXNWuw1y8nHXBiV6XDqnLPkeDI
 YKFC+zGsC3FaFB7WH1rCuxoD0+AJPZVLZfX/lBbfdgFVLY08KvAbyIP4Wn06qP97p3OB
 TyTFAspVP3fY+XG3H50kGaofk836K+6IOap2pTakCHW5tdwv5c2/s6QW3ffmOB8DQKBp Ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 34cc7kych2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 28 Oct 2020 13:26:25 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09SDPMPo031122;
        Wed, 28 Oct 2020 13:26:25 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 34cx6x7t16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Oct 2020 13:26:25 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09SDQOQT011660;
        Wed, 28 Oct 2020 13:26:24 GMT
Received: from localhost.localdomain (/39.109.231.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 28 Oct 2020 06:26:23 -0700
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, josef@toxicpanda.com
Subject: [PATCH v1 0/4] btrfs: read_policy types latency, device and round-robin
Date:   Wed, 28 Oct 2020 21:25:59 +0800
Message-Id: <cover.1603884539.git.anand.jain@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010280091
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=1
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010280090
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Based on misc-next

Depends on the following 3 patches in the mailing list.
  btrfs: add btrfs_strmatch helper
  btrfs: create read policy framework
  btrfs: create read policy sysfs attribute, pid

v1:
Drop tracing patch
Drop factoring inflight command
  Here below is the performance differences, when inflight is used, it pushed
  few commands to the other device, so losing the potential merges.

  with inflight:
   READ: bw=195MiB/s (204MB/s), 195MiB/s-195MiB/s (204MB/s-204MB/s), io=15.6GiB (16.8GB), run=82203-82203msec
sda 256054
sdc 20

  without inflight:
   READ: bw=192MiB/s (202MB/s), 192MiB/s-192MiB/s (202MB/s-202MB/s), io=15.6GiB (16.8GB), run=83231-83231msec
sda 141006
sdc 0

Few C styles fixes.


RFC:
Patch 1-3 adds new read policy: latency.
Patch 4 adds tracing function.
Patch 5-6 were sent before they add read policy: device.
Patch 7 adds new read policy: round-robin.

I am sending this patchset to receive feedback, comments, and more test
results. Few cleanups, optimization, and broader performance test are
may be possible. This patchset does not alter the original default
read_policy that is PID.

This has been tested on VMs only, as my hardware based test host is
currently down.

This patchset adds read policies type latency, device, and round-robin.

These policies are for the mirrored raid profiles such as raid1, raid1c3,
raid1c4, and raid10 as they provide a choice to read from any one of the
given devices or any one pair of devices for raid10 for a given block.

Latency:

Latency read policy routes the read IO based on the historical average
wait time experienced by the read IOs on the individual device factored
by 1/10 of inflight commands in the queue. I need to add a factor of 1/10
because for most of the block devices the queue depth is more than 1, and
there can be commands in the queue even before the previous commands have
completed. However, the factor 1/10 for the inflight commands is yet to be
fine-tuned. Suggestions are welcome.

Device:

With the device read policy along with the read_preferred flag, you can
set the device to be used for reading manually. Useful to test mirrors in
a deterministic way and helps advance system administrations.

Round-robin:

When set picks the next device to read in the round-robin loop. To
achieve this first we put the stripes in an array, sort it by devid and
pick the next device.

The test results from my VM with 2 devices of type sata and 2 devices of 
type virtio, are as below.

Here below I have included a few scripts which were useful for testing.

-------------------8<--------------------------------
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


Here below are the performance results for raid1c4, raid10, and raid1.

The workload is fio read 32 threads, 500m random reads.

Fio is passed to the script readstat, which returns the number of read IOs
per device sent during the fio.

Few inferences:

1.
In some cases as mine, PID is also associated with the stripe 0 being
circulating among the devices at the chunk level before moving to the next
device. So PID is not a bad option for such configurations. However, it is
not a good choice if the devices are heterogeneous in terms of type, speed,
and size.

2.
Latency provides performance equal to PID on my test setup. But needs iostat
be enabled. And there is a cost of calculating the avg wait time. (If you
factor in the similar cost to PID using the test code [1] then latency's
performance is better than PID. So that proves that read IO distribution
as per latency is really working)

3.
Round robin is worst (unless there is a bug in my patch). As the total
number of new IOs issued was almost double compared to the PID and the
latency read_policy, that's because I think there was a fewer number of
merges due to constant switching of devices.

4.
Device read_policy is quite useful in testing and advance sysadmin
maintenance. When known how to use, this policy could help to avert
too many csum errors in midest of peak production.

Supporting fio logs are below. And readstat shows the number of read IOs
issued to devices (excluding the merges).

raid1c4
-------

pid:

$ readpolicyset /btrfs pid && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m
[pid] latency device roundrobin ( 0000)
 READ: bw=87.0MiB/s (91.2MB/s), 87.0MiB/s-87.0MiB/s (91.2MB/s-91.2MB/s), io=15.6GiB (16.8GB), run=183884-183884msec

vdb 64060
vdc 64053
sdb 64072
sda 64054


latency:  (All devices are non-rotational, but sda and sdb are of type
sata and vdb and vdc are of type virtio).

$ readpolicyset /btrfs latency && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

pid [latency] device roundrobin ( 0000)
 READ: bw=87.1MiB/s (91.3MB/s), 87.1MiB/s-87.1MiB/s (91.3MB/s-91.3MB/s), io=15.6GiB (16.8GB), run=183774-183774msec

vdb 255844
vdc 559
sdb 0
sda 93

roundrobin:

$ readpolicyset /btrfs roundrobin && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m

pid latency device [roundrobin] ( 0000)
 READ: bw=51.0MiB/s (54.5MB/s), 51.0MiB/s-51.0MiB/s (54.5MB/s-54.5MB/s), io=15.6GiB (16.8GB), run=307755-307755msec

vdb 866859
vdc 866651
sdb 864139
sda 865533


raid10
------

pid:

$ readpolicyset /btrfs pid && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m
[pid] latency device roundrobin ( 0000)
 READ: bw=85.2MiB/s (89.3MB/s), 85.2MiB/s-85.2MiB/s (89.3MB/s-89.3MB/s), io=15.6GiB (16.8GB), run=187864-187864msec


sdf 64053
sde 64036
sdd 64043
sdc 64038


latency:

$ readpolicyset /btrfs latency && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m
pid [latency] device roundrobin ( 0000)
 READ: bw=85.4MiB/s (89.5MB/s), 85.4MiB/s-85.4MiB/s (89.5MB/s-89.5MB/s), io=15.6GiB (16.8GB), run=187370-187370msec


sdf 117494
sde 10748
sdd 125247
sdc 2921

roundrobin:

$ readpolicyset /btrfs roundrobin && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m
pid latency device [roundrobin] ( 0000)
 READ: bw=55.4MiB/s (58.1MB/s), 55.4MiB/s-55.4MiB/s (58.1MB/s-58.1MB/s), io=15.6GiB (16.8GB), run=288701-288701msec

sdf 617593
sde 617381
sdd 618486
sdc 618633


raid1:

$ readpolicyset /btrfs pid && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m
[pid] latency device roundrobin ( 00)
 READ: bw=78.8MiB/s (82.6MB/s), 78.8MiB/s-78.8MiB/s (82.6MB/s-82.6MB/s), io=15.6GiB (16.8GB), run=203158-203158msec


sdb 128087
sda 128090

$ readpolicyset /btrfs latency && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m
pid [latency] device roundrobin ( 00)
 READ: bw=86.5MiB/s (90.7MB/s), 86.5MiB/s-86.5MiB/s (90.7MB/s-90.7MB/s), io=15.6GiB (16.8GB), run=185023-185023msec


sdb 567
sda 255942


From the latency test results we know sda is providing low latency read
IO. So set sda as read proffered device.

$ readpolicyset /btrfs device 1 && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m
pid latency [device] roundrobin ( 10)
 READ: bw=88.2MiB/s (92.5MB/s), 88.2MiB/s-88.2MiB/s (92.5MB/s-92.5MB/s), io=15.6GiB (16.8GB), run=181374-181374msec


sdb 0
sda 256191


$ readpolicyset /btrfs roundrobin && readpolicy /btrfs && dropcache && readstat /btrfs fioread /btrfs/largefile 500m
pid latency device [roundrobin] ( 00)
 READ: bw=54.1MiB/s (56.7MB/s), 54.1MiB/s-54.1MiB/s (56.7MB/s-56.7MB/s), io=15.6GiB (16.8GB), run=295693-295693msec


sdb 1252584
sda 1254258


Thanks, Anand


------------------
[1]
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
+ * iostat for testing.
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

 fs/btrfs/sysfs.c   |  59 +++++++++++++++++++++++-
 fs/btrfs/volumes.c | 111 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.h |   5 ++
 3 files changed, 173 insertions(+), 2 deletions(-)

-- 
2.25.1

