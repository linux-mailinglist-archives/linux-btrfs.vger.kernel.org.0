Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6BA251EC8
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Aug 2020 20:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgHYSDN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Aug 2020 14:03:13 -0400
Received: from smtp-33.italiaonline.it ([213.209.10.33]:57802 "EHLO libero.it"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726119AbgHYSDM (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Aug 2020 14:03:12 -0400
Received: from venice.bhome ([94.37.192.142])
        by smtp-33.iol.local with ESMTPA
        id AdHpkjAKb8e2WAdHpkJYud; Tue, 25 Aug 2020 20:03:09 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2014;
        t=1598378589; bh=CU3zuMCoQTK7/uDJCgLgoBMF9Fz0asilvY/k3TbbXYw=;
        h=From;
        b=QGoa2/We4NF1C5D7VIlO472UlP92rhoVtmGpxN3OiRgabJgihMmZoo09PUlXEyDUo
         g1HGTW5+OQ/6h0HBMCrmKoB1/9qew1/SY2wAxi11ZKaucsqAHKDuQyccKnCMwPjNR3
         xwnLxkysq7sc87aqxOPAExPL9ewjRugIHKre5UkZOKKC7bZs+cbQAAnqXEp7SDtRe4
         i0a+VWgf4fuKojqtW3USHojFadK26yIM26Sw0YC2R0SexiS/TFEWUbZQFHTz6XIRBp
         ucJW20LLLrvpTuIbsIVvtrXDmJT62nr/PxsSfgATGgtSYf04r3r0OGZjBUR95mp8qS
         pkk+O4gBq89Xg==
X-CNFS-Analysis: v=2.4 cv=ZYejiuZA c=1 sm=1 tr=0 ts=5f45525d
 a=ppQ2YIgYQAGACouVZCsPPQ==:117 a=ppQ2YIgYQAGACouVZCsPPQ==:17
 a=IkcTkHD0fZMA:10 a=lViJMyulAAAA:8 a=d1H2eEJXnWd64cUTc3cA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=QEXdDO2ut3YA:10 a=x0L2op2tv_IA:10
 a=gb9IC-u5QvZuJU0a8fSk:22
From:   Goffredo Baroncelli <kreijack@libero.it>
Subject: cp --reflix between subvolume
Reply-To: kreijack@inwind.it
To:     David Sterba <dsterba@suse.cz>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>,
        Neal Gompa <ngompa13@gmail.com>
Message-ID: <7e39d6e5-f203-27fe-a357-f5c42e6f23ef@libero.it>
Date:   Tue, 25 Aug 2020 20:03:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfDc6I9GR2Z8fmHRAJSO331ULdOuxRoVfyKUJiVnzo9H8xINGEuJM0T0HqC50MznfgfmVa0ykq95NQH1eHi7715IC3CtPFDGQg9j7k1MwpfeT9KQt5VXG
 z9wWoxG03pVfne4N1UGNLzXWGWngb/Zx7vbTfffhmOpfr0dMSVRUFPGY8ZCk5bfhz30uBBor30WRQBQ0YKri6O18wLoqKdjL2BWEgwyzLms2bwGJop4tZ/Ek
 KUKBoeqKgV2yvimLKksjrw==
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looking at this page [1] I discovered that in BTRFS it is possible to do a cp --reflink between different subvolume *only* if these are from the same mountpoint. If the subvolumes are mounted with "subvol=" this is not possible even if these are from the same filesystem.

$ cd /var/btrfs/
$ sudo btrfs sub crea a
Create subvolume './a'
$ sudo btrfs sub crea b
Create subvolume './b'
$ sudo dd if=/dev/zero of=a/zero bs=1M count=1
1+0 records in
1+0 records out
1048576 bytes (1.0 MB, 1.0 MiB) copied, 0.0017188 s, 610 MB/s
$ sudo cp --reflink a/zero b/zero-1
$ ls b/
zero-1

$ # /dev/sde3 is the btrfs filesystem /var/btrfs
$ sudo mount -o subvol=b /dev/sde3 /mnt/other
$ ls /mnt/other
zero-1
$ sudo cp --reflink a/zero /mnt/other/zero-2
cp: failed to clone '/mnt/other/zero-2' from 'a/zero': Invalid cross-device link

@David,
it seems that the check that prevent 'cp --reflink' to work was inserted by you in the commit 362a20c5e27614739c46707d1c5f55c214d164ce:


$ git show 362a20c5e27614739c46707d1c5f55c214d164ce
commit 362a20c5e27614739c46707d1c5f55c214d164ce
Author: David Sterba <dsterba@suse.cz>
Date:   Mon Aug 1 18:11:57 2011 +0200

     btrfs: allow cross-subvolume file clone
     
     Lift the EXDEV condition and allow different root trees for files being
     cloned, then pass source inode's root when searching for extents.
     Cloning is not allowed to cross vfsmounts, ie. when two subvolumes from
     one filesystem are mounted separately.
     
     Signed-off-by: David Sterba <dsterba@suse.cz>

diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 0e92e5763005..7011871c45b8 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2340,6 +2340,10 @@ static noinline long btrfs_ioctl_clone(struct file *file, unsigned long srcfd,
  		goto out_drop_write;
  	}
  
+	ret = -EXDEV;
+	if (src_file->f_path.mnt != file->f_path.mnt)
+		goto out_fput;
+
[...]

Now the code is changed from the one above. But there is the same check (only in a different position)

What is the rationale behind this check ? I checked that also nfs4 does the same check.
But I don't understand what is the reason (for sure there is one reason :-) ). My understanding is that
a cp --reflink should be allowed with the only condition that the filesystem are the same; and this check (== the superblock are the same)  are in place.

As also described in [1], the use case that I am looking an easy way to replace the root filesystem
with an its snapshot. So every sub-subvolume (under root) have to be moved between the different
root subvolumes and the easy way is to mount it via fstab. However doing so it prevents cp --reflink
to work.


[1] https://pagure.io/fedora-btrfs/project/issue/8

BR
G.Baroncelli

-- 
gpg @keyserver.linux.it: Goffredo Baroncelli <kreijackATinwind.it>
Key fingerprint BBF5 1610 0B64 DAC6 5F7D  17B2 0EDA 9B37 8B82 E0B5
