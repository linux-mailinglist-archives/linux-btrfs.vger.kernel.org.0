Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CE967C6B
	for <lists+linux-btrfs@lfdr.de>; Sun, 14 Jul 2019 01:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfGMXOk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Jul 2019 19:14:40 -0400
Received: from 11.mo1.mail-out.ovh.net ([188.165.48.29]:42409 "EHLO
        11.mo1.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728736AbfGMXOk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Jul 2019 19:14:40 -0400
X-Greylist: delayed 7801 seconds by postgrey-1.27 at vger.kernel.org; Sat, 13 Jul 2019 19:14:38 EDT
Received: from player714.ha.ovh.net (unknown [10.109.146.173])
        by mo1.mail-out.ovh.net (Postfix) with ESMTP id B24701842D3
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Jul 2019 22:48:59 +0200 (CEST)
Received: from awhome.eu (p4FF91F5A.dip0.t-ipconnect.de [79.249.31.90])
        (Authenticated sender: postmaster@awhome.eu)
        by player714.ha.ovh.net (Postfix) with ESMTPSA id 458427D534F0;
        Sat, 13 Jul 2019 20:48:58 +0000 (UTC)
To:     linux-btrfs@vger.kernel.org, wqu@suse.com
From:   Alexander Wetzel <alexander.wetzel@web.de>
Subject: [BUG] BTRFS critical corrupt leaf - bisected to 496245cac57e
Message-ID: <5a89e922-00af-51a9-390f-b0a6b1f6cfb6@web.de>
Date:   Sat, 13 Jul 2019 22:48:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 4880494623887666410
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrheefgddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecu
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,

After updating one of my VMs from 5.1.16 to 5.2 btrfs is acting up strange:
The system is using btrfs as root (also for /boot) and has compression 
enabled. (It's a gentoo virtual machine and not using an initrd.) 
Rebooting the system into 5.2 is able to bring up openssh, but not other 
services (like e.g. postfix).

Redirecting dmesg to a file also failed. The file was created but empty, 
even when checked immediately. Rebooting the system into the old kernel 
fully restores functionality and a btrfs srub shows no errors..

When running a bad kernel the system is partially ro, but since I'm 
using selinux in strict mode it could also by caused by selinux unable 
to read some data.

Here how a reboot via ssh looks for a broken kernel:
xar /home/alex # shutdown -r now
shutdown: warning: cannot open /var/run/shutdown.pid

But deleting the "bad" kernel and running "grub-mkconfig -o 
/boot/grub/grub.cfg" works as it should and the system is using the 
previous kernel... So it still can write some things...

I've bisected the problem to 496245cac57e (btrfs: tree-checker: Verify 
inode item)

filtering for btrfs and removing duplicate lines just shows three uniq 
error messages:
  BTRFS critical (device vda3): corrupt leaf: root=300 block=8645398528 
slot=4 ino=259223, invalid inode generation: has 139737289170944 expect 
[0, 1425224]
  BTRFS critical (device vda3): corrupt leaf: root=300 block=8645398528 
slot=4 ino=259223, invalid inode generation: has 139737289170944 expect 
[0, 1425225]
  BTRFS critical (device vda3): corrupt leaf: root=300 block=8645398528 
slot=4 ino=259223, invalid inode generation: has 139737289170944 expect 
[0, 1425227]
  BTRFS error (device vda3): block=8645398528 read time tree block 
corruption detected

All there errors are only there with commit 496245cac57e, booting a 
kernel without the patch after that just works normally again.

I tried to reproduce the issue transferring the fs with btrfs 
send/receive to another system. I was able to mount the migrated Fs with 
a 5.2 kernel and also btrfs scub was ok...

I tried to revert the commit but a simple revert is not working. So I've 
just verified that a kernel build on 496245cac57e shows the symptoms 
while using the commit before that is fine.

I've not tried more, so I still can reproduce the issue when needed and 
gather more data. (The system is now back running 5.1.16)

Now I guess I could have some corruption only detected/triggered with 
the patch and btrfs check may fix it... shall I try that next?

Here the dmesg from the affected system (the first few lines still in 
the log buffer when I checked):
[    8.963796] BTRFS critical (device vda3): corrupt leaf: root=300 
block=8645398528 slot=4 ino=259223, invalid inode generation: has 
139737289170944 expect [0, 1425224]
[    8.963799] BTRFS error (device vda3): block=8645398528 read time 
tree block corruption detected
[    8.967487] audit: type=1400 audit(1563023702.540:19): avc:  denied 
{ write } for  pid=2154 comm="cp" name="localtime" dev="vda3" 
ino=1061039 scontext=system_u:system_r:initrc_t 
tcontext=system_u:object_r:locale_t tclass=file permissive=0
[    9.023608] audit: type=1400 audit(1563023702.590:20): avc:  denied 
{ mounton } for  pid=2194 comm="mount" path="/chroot/dns/run/named" 
dev="vda3" ino=1061002 scontext=system_u:system_r:mount_t 
tcontext=system_u:object_r:named_var_run_t tclass=dir permissive=0
[    9.038235] audit: type=1400 audit(1563023702.610:21): avc:  denied 
{ getattr } for  pid=2199 comm="start-stop-daem" path="pid:[4026531836]" 
dev="nsfs" ino=4026531836 scontext=system_u:system_r:initrc_t 
tcontext=system_u:object_r:nsfs_t tclass=file permissive=0
[    9.100897] BTRFS critical (device vda3): corrupt leaf: root=300 
block=8645398528 slot=4 ino=259223, invalid inode generation: has 
139737289170944 expect [0, 1425224]
[    9.100900] BTRFS error (device vda3): block=8645398528 read time 
tree block corruption detected
[    9.137974] BTRFS critical (device vda3): corrupt leaf: root=300 
block=8645398528 slot=4 ino=259223, invalid inode generation: has 
139737289170944 expect [0, 1425224]
[    9.137976] BTRFS error (device vda3): block=8645398528 read time 
tree block corruption detected
[    9.138095] audit: type=1400 audit(1563023702.710:22): avc:  denied 
{ getattr } for  pid=2237 comm="start-stop-daem" path="pid:[4026531836]" 
dev="nsfs" ino=4026531836 scontext=system_u:system_r:initrc_t 
tcontext=system_u:object_r:nsfs_t tclass=file permissive=0
[    9.138477] BTRFS critical (device vda3): corrupt leaf: root=300 
block=8645398528 slot=4 ino=259223, invalid inode generation: has 
139737289170944 expect [0, 1425224]
[    9.138480] BTRFS error (device vda3): block=8645398528 read time 
tree block corruption detected
[    9.161866] BTRFS critical (device vda3): corrupt leaf: root=300 
block=8645398528 slot=4 ino=259223, invalid inode generation: has 
139737289170944 expect [0, 1425224]
[    9.161868] BTRFS error (device vda3): block=8645398528 read time 
tree block corruption detected
[    9.170228] BTRFS critical (device vda3): corrupt leaf: root=300 
block=8645398528 slot=4 ino=259223, invalid inode generation: has 
139737289170944 expect [0, 1425224]
[    9.170230] BTRFS error (device vda3): block=8645398528 read time 
tree block corruption detected
[    9.214491] BTRFS critical (device vda3): corrupt leaf: root=300 
block=8645398528 slot=4 ino=259223, invalid inode generation: has 
139737289170944 expect [0, 1425224]
[    9.214494] BTRFS error (device vda3): block=8645398528 read time 
tree block corruption detected


Alexander
