Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63134D610E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Mar 2022 12:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344855AbiCKL4b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Mar 2022 06:56:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242969AbiCKL4a (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Mar 2022 06:56:30 -0500
Received: from out20-99.mail.aliyun.com (out20-99.mail.aliyun.com [115.124.20.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7D110708B
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Mar 2022 03:55:25 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.00302793-6.50674e-05-0.996907;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=1;RT=1;SR=0;TI=SMTPD_---.N28XJiU_1646999723;
Received: from 192.168.2.112(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.N28XJiU_1646999723)
          by smtp.aliyun-inc.com(33.37.71.62);
          Fri, 11 Mar 2022 19:55:23 +0800
Date:   Fri, 11 Mar 2022 19:55:27 +0800
From:   Wang Yugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Subject: fstests btrfs/232 trigger 'btrfs check' error 'errors 400, nbytes wrong'
Message-Id: <20220311195526.452D.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.75.04 [en]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

fstests btrfs/232 trigger 'btrfs check' error 'errors 400, nbytes wrong'

btrfs version: misc-next based on 5.17-rc7
frequency: not stable, but already 3 times

hardware: DELL PowerEdge T630, no  ECC error detected.

the output(232.full) of fstests btrfs/232:
wrote 943718400/943718400 bytes at offset 0
900 MiB, 230400 ops; 0.4709 sec (1.866 GiB/sec and 489201.0565 ops/sec)
quota rescan started
_check_btrfs_filesystem: filesystem on /dev/sdc2 is inconsistent
*** fsck.btrfs output ***
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space tree
[4/7] checking fs roots
root 5 inode 955 errors 400, nbytes wrong
ERROR: errors found in fs roots
Opening filesystem to check...
Checking filesystem on /dev/sdc2
UUID: 0658fa0d-e714-44c9-9078-2a87c8e32107
found 1447309312 bytes used, error(s) found
total csum bytes: 1143484
total tree bytes: 11714560
total fs tree bytes: 9142272
total extent tree bytes: 622592
btree space waste bytes: 6093520
file data blocks allocated: 2377723904
 referenced 1539444736
*** end fsck.btrfs output
*** mount output ***
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
devtmpfs on /dev type devtmpfs (rw,nosuid,size=264080408k,nr_inodes=66020102,mode=755,inode64)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,inode64)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755,inode64)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=755,inode64)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,release_agent=/usr/lib/systemd/systemd-cgroups-agent,name=systemd)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
efivarfs on /sys/firmware/efi/efivars type efivarfs (rw,nosuid,nodev,noexec,relatime)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,net_cls,net_prio)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,hugetlb)
cgroup on /sys/fs/cgroup/rdma type cgroup (rw,nosuid,nodev,noexec,relatime,rdma)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/misc type cgroup (rw,nosuid,nodev,noexec,relatime,misc)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset)
configfs on /sys/kernel/config type configfs (rw,relatime)
/dev/nvme0n1p4 on / type btrfs (rw,noatime,ssd,space_cache=v2,subvolid=257,subvol=/rhel77)
rpc_pipefs on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
mqueue on /dev/mqueue type mqueue (rw,relatime)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=26,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipe_ino=61124)
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
nfsd on /proc/fs/nfsd type nfsd (rw,relatime)
/dev/nvme0n1p4 on /nfs/ssd type btrfs (rw,noatime,ssd,space_cache=v2,subvolid=263,subvol=/ssd,x-systemd.mount-timeout=0)
/dev/nvme0n1p1 on /boot/efi type vfat (rw,relatime,fmask=0077,dmask=0077,codepage=437,iocharset=ascii,shortname=winnt,errors=remount-ro,x-systemd.mount-timeout=0)
tmpfs on /run/user/0 type tmpfs (rw,nosuid,nodev,relatime,size=52824052k,mode=700,inode64)
T640:/ssd on /ssd type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,nconnect=8,max_connect=32,timeo=600,retrans=2,sec=sys,clientaddr=10.40.1.63,local_lock=none,addr=10.40.1.64)
T640:/ssd/hpc-bio on /ssd/hpc-bio type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,nconnect=8,max_connect=32,timeo=600,retrans=2,sec=sys,clientaddr=10.40.1.63,local_lock=none,addr=10.40.1.64)
T640:/ssd/bio-ref on /usr/bio-ref type nfs4 (rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,nconnect=8,max_connect=32,timeo=600,retrans=2,sec=sys,clientaddr=10.40.1.63,local_lock=none,addr=10.40.1.64)
*** end mount output

Best Regards
Wang Yugui (wangyugui@e16-tech.com)
2022/03/11


