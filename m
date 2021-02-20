Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D7932068D
	for <lists+linux-btrfs@lfdr.de>; Sat, 20 Feb 2021 18:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbhBTR4m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 12:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhBTR4m (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 12:56:42 -0500
X-Greylist: delayed 635 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 20 Feb 2021 09:55:52 PST
Received: from ns2.wdyn.eu (ns2.wdyn.eu [IPv6:2a03:4000:40:5b2::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46A9EC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 09:55:52 -0800 (PST)
From:   Alexander Wetzel <alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
        s=wetzel-home; t=1613843146;
        bh=ayOYTmUn+MOFFoghqAExQG84H2oYvpVexKmi16LWF9g=;
        h=From:Subject:To:Date;
        b=I5xJLNRuYnS9q9K/tDR1B4Cm97n1F1U7rOdgIInFAONkAkyzF5oIF2bkeDeopUKJn
         Ylsnol1eZcBwntQ9YCA1YBmX40sveOied4sQYwBx7MfC+pDeSBobFDNk9BBMgXwBgr
         mSVASJEWCiL0hXRfb9Z1ubBd40eP9vfclwKM97I8=
Subject: Unexpected "ERROR: clone: did not find source subvol" on btrfs
 receive
To:     linux-btrfs@vger.kernel.org
Message-ID: <41b096e1-5345-ae9c-810b-685499813183@wetzel-home.de>
Date:   Sat, 20 Feb 2021 18:45:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

I have a strange problem with btrfs send/receive.
While I can create incremental snaphosts but when I try to restore them
I reproducible get:

 > At snapshot 2021-02-20-TEMP
 > ERROR: clone: did not find source subvol

I've no "real" problem by that. Just want to report the issue so someone 
with more btrfs knowledge can dig into what went wrong here. After all 
that looks like a bug...

So I plan to keep it as it is for some more days and then play around to 
get incremental send/receive working again.

Here the procedure how I can reproduce the issue:

At start I have the following snapshots in the root of the affected file 
system. (Subvol "active is mounted as / and the btrfs root on 
/mnt/backup/backupdev):

active		<- the live RW filesystem
2021-02-14	<- a RO snapshot of the above from some days ago

And these steps reproducible are failing on btrfs recive:

1) create a new RO snapshot of active
# btrfs sub snap -r active/ 2021-02-20-TEMP
Create a readonly snapshot of 'active/' in './2021-02-20-TEMP'

2) btrfs send with 2021-02-14 as parent into test2
# btrfs send -p 2021-02-14 2021-02-20-TEMP -f test2
At subvol 2021-02-20-TEMP

3) remove the snapshot 2021-02-20-TEMP
# btrfs sub del 2021-02-20-TEMP
Delete subvolume (no-commit): '/mnt/backup/backupdev/2021-02-20-TEMP'

4) and try to import it again from test2
# btrfs receive -f test2 .
At snapshot 2021-02-20-TEMP
ERROR: clone: did not find source subvol

The same procedure is working for another btrfs filesystem on the same 
system.

The system is an Ubuntu 20.04 (kernel 5.4.0-65-generic, btrfs-progs v5.4.1).

And here some more information which may be useful:

# btrfs sub show active
active
         Name:                   active
         UUID:                   a2ff485b-9f8f-2543-ad03-dc7c917e143b
         Parent UUID:            6da3d5ab-4d9f-4805-b77e-0eab8ce2abc8
         Received UUID:          -
         Creation time:          2020-11-08 13:58:23 +0100
         Subvolume ID:           264
         Generation:             206432
         Gen at creation:        167
         Parent ID:              5
         Top level ID:           5
         Flags:                  -
         Snapshot(s):

# btrfs sub show 2021-02-14
2021-02-14
         Name:                   2021-02-14
         UUID:                   d31d553f-0917-3c48-b65c-ec51fd0c6d89
         Parent UUID:            a2ff485b-9f8f-2543-ad03-dc7c917e143b
         Received UUID:          -
         Creation time:          2021-02-14 21:46:26 +0100
         Subvolume ID:           358
         Generation:             206378
         Gen at creation:        195056
         Parent ID:              5
         Top level ID:           5
         Flags:                  readonly
         Snapshot(s):

# btrfs sub show 2021-02-20-TEMP
2021-02-20-TEMP
         Name:                   2021-02-20-TEMP
         UUID:                   120113e6-f83c-b240-ba27-259be4c92ea7
         Parent UUID:            a2ff485b-9f8f-2543-ad03-dc7c917e143b
         Received UUID:          -
         Creation time:          2021-02-20 18:06:29 +0100
         Subvolume ID:           375
         Generation:             206770
         Gen at creation:        206770
         Parent ID:              5
         Top level ID:           5
         Flags:                  readonly
         Snapshot(s):


# time btrfs receive -v -f test2 .
receiving snapshot 2021-02-20-TEMP 
uuid=120113e6-f83c-b240-ba27-259be4c92ea7, ctransid=206769 
parent_uuid=d31d553f-0917-3c48-b65c-ec51fd0c6d89, parent_ctransid=195056
write var/log/lastlog - offset=290816 length=4096
write var/log/wtmp - offset=122880 length=4096
write var/log/wtmp - offset=126976 length=4096
write var/log/wtmp - offset=131072 length=4096
write var/log/wtmp - offset=135168 length=384
write boot/grub/grubenv - offset=0 length=1024
write var/lib/systemd/random-seed - offset=0 length=512
write var/log/cloud-init.log - offset=1138688 length=49152
write var/log/cloud-init.log - offset=1187840 length=11555
write var/log/cloud-init-output.log - offset=53248 length=5329
write var/lib/cloud/instances/iid-datasource-none/datasource - offset=0 
length=31
write var/lib/cloud/data/previous-datasource - offset=0 length=31
write var/lib/cloud/data/instance-id - offset=0 length=20
write var/lib/cloud/data/previous-instance-id - offset=0 length=20
write var/lib/cloud/instances/iid-datasource-none/obj.pkl - offset=0 
length=8107
write var/lib/cloud/instances/iid-datasource-none/user-data.txt - 
offset=0 length=356
write var/lib/cloud/instances/iid-datasource-none/user-data.txt.i - 
offset=0 length=661
write var/lib/cloud/instances/iid-datasource-none/vendor-data.txt.i - 
offset=0 length=308
write var/lib/cloud/instances/iid-datasource-none/cloud-config.txt - 
offset=0 length=435
write var/cache/motd-news - offset=0 length=184
<removed 10200 lines>
write var/lib/mysql/mysql/innodb_index_stats.ibd - offset=393216 
length=16384
write var/lib/mysql/mysql/innodb_index_stats.ibd - offset=409600 
length=16384
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=0 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=8192 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=16384 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=24576 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=40960 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=49152 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=114688 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=155648 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=180224 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=212992 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=229376 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=253952 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=278528 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=294912 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=319488 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=385024 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=483328 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=516096 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=720896 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=729088 length=8192
write var/lib/mysql/nextcloud/oc_activity.ibd - offset=737280 length=8192
ERROR: clone: did not find source subvol
At snapshot 2021-02-20-TEMP

real    0m0.741s
user    0m0.246s
sys     0m0.127s


Noteworthy here is, that var/lib/mysql/ has set "chattr +C" set:

# lsattr 2021-02-20-TEMP/var/lib/mysql
---------------C---- 2021-02-20-TEMP/var/lib/mysql/aria_log.00000001
---------------C---- 2021-02-20-TEMP/var/lib/mysql/aria_log_control
---------------C---- 2021-02-20-TEMP/var/lib/mysql/debian-10.3.flag
---------------C---- 2021-02-20-TEMP/var/lib/mysql/ib_logfile0
---------------C---- 2021-02-20-TEMP/var/lib/mysql/ib_logfile1
---------------C---- 2021-02-20-TEMP/var/lib/mysql/ibdata1
---------------C---- 2021-02-20-TEMP/var/lib/mysql/multi-master.info
---------------C---- 2021-02-20-TEMP/var/lib/mysql/mysql_upgrade_info
---------------C---- 2021-02-20-TEMP/var/lib/mysql/mysql
---------------C---- 2021-02-20-TEMP/var/lib/mysql/nextcloud
---------------C---- 2021-02-20-TEMP/var/lib/mysql/performance_schema
---------------C---- 2021-02-20-TEMP/var/lib/mysql/roundcube
---------------C---- 2021-02-20-TEMP/var/lib/mysql/wordpress
---------------C---- 2021-02-20-TEMP/var/lib/mysql/mailserver
---------------C---- 2021-02-20-TEMP/var/lib/mysql/ib_buffer_pool
---------------C---- 2021-02-20-TEMP/var/lib/mysql/tc.log
---------------C---- 2021-02-20-TEMP/var/lib/mysql/ibtmp1

