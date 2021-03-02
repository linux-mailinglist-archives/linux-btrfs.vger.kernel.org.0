Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B8A32B1E6
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Mar 2021 04:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239417AbhCCB5L (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Mar 2021 20:57:11 -0500
Received: from out20-85.mail.aliyun.com ([115.124.20.85]:34770 "EHLO
        out20-85.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382242AbhCBJIH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Mar 2021 04:08:07 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.04436282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0172881-0.000414947-0.982297;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047193;MF=wangyugui@e16-tech.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.JfLImVn_1614676043;
Received: from T640.e16-tech.com(mailfrom:wangyugui@e16-tech.com fp:SMTPD_---.JfLImVn_1614676043)
          by smtp.aliyun-inc.com(10.147.42.197);
          Tue, 02 Mar 2021 17:07:23 +0800
From:   wangyugui <wangyugui@e16-tech.com>
To:     linux-btrfs@vger.kernel.org
Cc:     wangyugui <wangyugui@e16-tech.com>
Subject: [PATCH] btrfs-progs: add error message when btrfs check failed
Date:   Tue,  2 Mar 2021 17:07:23 +0800
Message-Id: <20210302090723.19953-1-wangyugui@e16-tech.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

fstests btrfs/028 failed once, but there is no clear error message in
the output of 'btrfs check' [*1].

There is some places in 'btrfs check' where 'err' is set, but no error("")
message is outputed, so we add them.

[*1]

# cat /ssd/git/os/xfstests/results//btrfs/028.full
# /usr/sbin/btrfs quota enable /mnt/scratch
# /usr/sbin/btrfs quota rescan -w /mnt/scratch
quota rescan started
Run fsstress  -z -f write=10 -f unlink=10 -f creat=10 -f fsync=10 -f fsync=10 -n 100000 -p 2 -d /mnt/scratch/stress_dir
Start balance
Done, had to relocate 1 out of 3 chunks
*** Done, had to relocate 1 out of 3 chunks *** many times
Done, had to relocate 1 out of 3 chunks
# /usr/sbin/btrfs filesystem sync /mnt/scratch
_check_btrfs_filesystem: filesystem on /dev/sdb1 is inconsistent
*** fsck.btrfs output ***
[1/7] checking root items
[2/7] checking extents
WARNING: tree block [7979008, 7995392) crosses 64K page boudnary, may cause problem for 64K page system
WARNING: tree block [8830976, 8847360) crosses 64K page boudnary, may cause problem for 64K page system
WARNING: tree block [9093120, 9109504) crosses 64K page boudnary, may cause problem for 64K page system
WARNING: tree block [9158656, 9175040) crosses 64K page boudnary, may cause problem for 64K page system
WARNING: tree block [9224192, 9240576) crosses 64K page boudnary, may cause problem for 64K page system
WARNING: tree block [9289728, 9306112) crosses 64K page boudnary, may cause problem for 64K page system
WARNING: tree block [9486336, 9502720) crosses 64K page boudnary, may cause problem for 64K page system
WARNING: tree block [9682944, 9699328) crosses 64K page boudnary, may cause problem for 64K page system
[3/7] checking free space tree
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups
Opening filesystem to check...
Checking filesystem on /dev/sdb1
UUID: 40e72eb2-7e47-4d1d-a020-db2b441a3747
Counts for qgroup id: 0/5 are different
our:            referenced 33431552 referenced compressed 33431552
disk:           referenced 33558528 referenced compressed 33558528
diff:           referenced -126976 referenced compressed -126976
our:            exclusive 33431552 exclusive compressed 33431552
disk:           exclusive 33558528 exclusive compressed 33558528
diff:           exclusive -126976 exclusive compressed -126976
found 33693696 bytes used, error(s) found
total csum bytes: 32360
total tree bytes: 557056
total fs tree bytes: 311296
total extent tree bytes: 81920
btree space waste bytes: 256606
file data blocks allocated: 33411072
 referenced 32354304
*** end fsck.btrfs output
*** mount output ***
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
devtmpfs on /dev type devtmpfs (rw,nosuid,size=98960292k,nr_inodes=24740073,mode=755,inode64)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,inode64)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,gid=5,mode=620,ptmxmode=000)
tmpfs on /run type tmpfs (rw,nosuid,nodev,mode=755,inode64)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,mode=755,inode64)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,xattr,release_agent=/usr/lib/systemd/systmd-cgroups-agent,name=systemd)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime)
none on /sys/fs/bpf type bpf (rw,nosuid,nodev,noexec,relatime,mode=700)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cpuset)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,memory)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relatime,cpu,cpuacct)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,hugetlb)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,freezer)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blkio)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,devices)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,relatime,net_cls,net_prio)
cgroup on /sys/fs/cgroup/pids type cgroup (rw,nosuid,nodev,noexec,relatime,pids)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatime,perf_event)
none on /sys/kernel/tracing type tracefs (rw,relatime)
configfs on /sys/kernel/config type configfs (rw,relatime)
/dev/sda1 on / type xfs (rw,relatime,attr2,inode64,logbufs=8,logbsize=32k,noquota)
rpc_pipefs on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=28,pgrp=1,timeout=0,minproto=5,maxproto=5,direct,pipeino=56668)
mqueue on /dev/mqueue type mqueue (rw,relatime)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,pagesize=2M)
debugfs on /sys/kernel/debug type debugfs (rw,relatime)
T640:/ssd on /ssd type nfs4 (rw,noatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,timeo=600,retran=2,sec=sys,clientaddr=10.0.1.76,local_lock=none,addr=10.0.1.64)
T640:/ssd/bio-ref on /usr/bio-ref type nfs4 (rw,noatime,vers=4.2,rsize=1048576,wsize=1048576,namlen=255,hard,proto=tcp,imeo=600,retrans=2,sec=sys,clientaddr=10.0.1.76,local_lock=none,addr=10.0.1.64)
tmpfs on /run/user/0 type tmpfs (rw,nosuid,nodev,relatime,size=19800940k,mode=700,inode64)
*** end mount output

---
 check/main.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/check/main.c b/check/main.c
index 0c4eb3ca..97265d90 100644
--- a/check/main.c
+++ b/check/main.c
@@ -10423,20 +10423,24 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 	    !extent_buffer_uptodate(gfs_info->dev_root->node) ||
 	    !extent_buffer_uptodate(gfs_info->chunk_root->node)) {
 		error("critical roots corrupted, unable to check the filesystem");
-		err |= !!ret;
 		ret = -EIO;
+		err |= !!ret;
 		goto close_out;
 	}
 
 	if (clear_space_cache) {
 		ret = do_clear_free_space_cache(clear_space_cache);
+		if (ret)
+			error("failed to clear free space cache");
 		err |= !!ret;
 		goto close_out;
 	}
 
 	if (clear_ino_cache) {
 		ret = clear_ino_cache_items();
-		err = ret;
+		if (ret)
+			error("failed to clear inode cache");
+		err |= !!ret;
 		goto close_out;
 	}
 
@@ -10464,6 +10468,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		       uuidbuf);
 		ret = qgroup_verify_all(gfs_info);
 		err |= !!ret;
+		if (ret)
+			error("failed to verify all qgroup");
 		if (ret >= 0)
 			report_qgroups(1);
 		goto close_out;
@@ -10472,6 +10478,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		printf("Print extent state for subvolume %llu on %s\nUUID: %s\n",
 		       subvolid, argv[optind], uuidbuf);
 		ret = print_extent_state(gfs_info, subvolid);
+		if (ret)
+			error("failed to print extend state");
 		err |= !!ret;
 		goto close_out;
 	}
@@ -10493,8 +10501,10 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			ret = reinit_extent_tree(trans,
 					 check_mode == CHECK_MODE_ORIGINAL);
 			err |= !!ret;
-			if (ret)
+			if (ret) {
+				error("failed to create a new extent tree");
 				goto close_out;
+			}
 		}
 
 		if (init_csum_tree) {
@@ -10522,8 +10532,10 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		 */
 		ret = btrfs_commit_transaction(trans, gfs_info->extent_root);
 		err |= !!ret;
-		if (ret)
+		if (ret) {
+			error("failed to commit btrfs transaction: %d", ret);
 			goto close_out;
+		}
 	}
 	if (!extent_buffer_uptodate(gfs_info->extent_root->node)) {
 		error("critical: extent_root, unable to check the filesystem");
@@ -10558,7 +10570,6 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 			 */
 			if (repair)
 				goto close_out;
-			err |= 1;
 		} else {
 			if (repair) {
 				fprintf(stderr, "Fixed %d roots.\n", ret);
@@ -10591,7 +10602,10 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		"errors found in extent allocation tree or chunk allocation");
 
 	/* Only re-check super size after we checked and repaired the fs */
-	err |= !is_super_size_valid();
+	ret = !is_super_size_valid();
+	if (ret)
+		error("super size is not valid");
+	err |= !!ret;
 
 	is_free_space_tree = btrfs_fs_compat_ro(gfs_info, FREE_SPACE_TREE);
 
@@ -10607,6 +10621,8 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 
 	ret = validate_free_space_cache(root);
 	task_stop(ctx.info);
+	if (ret)
+		error("failed to validate free space cache");
 	err |= !!ret;
 
 	/*
@@ -10694,6 +10710,9 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
 		list_del_init(&bad->list);
 		if (repair) {
 			ret = delete_bad_item(root, bad);
+			if (ret) {
+				error("failed to delete orphan items");
+			}
 			err |= !!ret;
 		}
 		free(bad);
-- 
2.30.1

