Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B70AA1AB692
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Apr 2020 06:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391733AbgDPESE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Apr 2020 00:18:04 -0400
Received: from magic.merlins.org ([209.81.13.136]:33196 "EHLO
        mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389455AbgDPESC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Apr 2020 00:18:02 -0400
Received: from svh-gw.merlins.org ([173.11.111.145]:33684 helo=saruman.merlins.org)
        by mail1.merlins.org with esmtps 
        (Cipher TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128) (Exim 4.92 #3)
        id 1jOvyK-0007UA-IA; Wed, 15 Apr 2020 21:17:55 -0700
Received: from merlin by saruman.merlins.org with local (Exim 4.80)
        (envelope-from <marc@merlins.org>)
        id 1jO9bK-0005I0-JS; Mon, 13 Apr 2020 17:38:54 -0700
Date:   Mon, 13 Apr 2020 17:38:54 -0700
From:   Marc MERLIN <marc@merlins.org>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Nikolay Borisov <nborisov@suse.com>, dsterba@suse.com,
        linux-btrfs@vger.kernel.org, kernel-team@fb.com
Message-ID: <20200414003854.GA6639@merlins.org>
References: <20200321202307.GA15906@merlins.org>
 <1aaae706-0029-be4f-9f6f-194b03087b35@suse.com>
 <20200325201455.GO29461@merlins.org>
 <a9dd1b1a-b38e-a0f4-91e1-b89063e8ae1e@oracle.com>
 <20200326013007.GS15123@merlins.org>
 <0d2ea8e2-cbe8-ca64-d0d4-fa70b8cad8b1@oracle.com>
 <20200326042624.GT15123@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200326042624.GT15123@merlins.org>
X-Sysadmin: BOFH
X-URL:  http://marc.merlins.org/
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 173.11.111.145
X-SA-Exim-Mail-From: marc@merlins.org
X-Spam-Checker-Version: SpamAssassin 3.4.4-rc1-mmrules_20121111 (2020-01-18)
        on magic.merlins.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=7.0 tests=GREYLIST_ISWHITE,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.4-rc1-mmrules_20121111
X-Spam-Report: *  2.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: merlins.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.0 SPF_SOFTFAIL SPF: sender does not match SPF record (softfail)
        *  1.0 KHOP_HELO_FCRDNS Relay HELO differs from its IP's reverse DNS
        * -1.5 GREYLIST_ISWHITE The incoming server has been whitelisted for
        *      this receipient and sender
Subject: Re: 5.4.20: cannot mount device that blipped off the bus: duplicate
 device fsid:devid for
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Anaud, I had this happen agin with 5.5.11, and it was impossible to do
anything to fix it, I had to reboot again.
btrfs device scan --forget 
did nothing.

See details:
BTRFS: device label btrfs_space devid 1 transid 35178413 /dev/sde1
BTRFS info (device sde1): use lzo compression, level 0
BTRFS info (device sde1): disk space caching is enabled
BTRFS info (device sde1): has skinny extents
BTRFS info (device sde1): enabling ssd optimizations
sd 6:1:3:0: [sde] tag#642 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s  
sd 6:1:3:0: [sde] tag#640 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
sd 6:1:3:0: [sde] tag#702 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
sd 6:1:3:0: [sde] tag#702 CDB: Write(16) 8a 00 00 00 00 00 f1 a7 3a 68 00 00 01 f0 00 00  
blk_update_request: I/O error, dev sde, sector 4054268520 op 0x1:(WRITE) flags 0x100000 phys_seg 62 prio class 0
sd 6:1:3:0: [sde] tag#701 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
sd 6:1:3:0: [sde] tag#701 CDB: Write(16) 8a 00 00 00 00 00 f1 a7 38 68 00 00 02 00 00 00  
blk_update_request: I/O error, dev sde, sector 4054268008 op 0x1:(WRITE) flags 0x104000 phys_seg 64 prio class 0
sd 6:1:3:0: [sde] tag#700 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=2s
sd 6:1:3:0: [sde] tag#700 CDB: Write(16) 8a 00 00 00 00 00 f1 a7 36 68 00 00 02 00 00 00  
blk_update_request: I/O error, dev sde, sector 4054267496 op 0x1:(WRITE) flags 0x104000 phys_seg 64 prio class 0
BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1, rd 0, flush 0, corrupt 0, gen 0
sd 6:1:3:0: [sde] tag#641 FAILED Result: hostbyte=DID_NO_CONNECT driverbyte=DRIVER_OK cmd_age=10s
sd 6:1:3:0: [sde] tag#641 CDB: Unmap/Read sub-channel 42 00 00 00 00 00 00 00 18 00  
BTRFS info (device sde1): forced readonly
BTRFS warning (device sde1): Skipping commit of aborted transaction.  
BTRFS: error (device sde1) in cleanup_transaction:1894: errno=-5 IO failure
BTRFS info (device sde1): delayed_refs has NO entry
btrfs_dev_stat_print_on_error: 244 callbacks suppressed


gargamel:~# dmtail 3
[1887142.765448] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4529, flush 0, corrupt 0, gen 0
[1887142.795820] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4530, flush 0, corrupt 0, gen 0
[1887142.826176] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4531, flush 0, corrupt 0, gen 0
gargamel:~# cat /proc/partitions  |grep sd[ep]
   8      240 3750738264 sdp
   8      241 3750737223 sdp1
gargamel:~# mount | grep sde
/dev/sde1 on /mnt/btrfs_space type btrfs (ro,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=5,subvol=/)
/dev/sde1 on /var/local/space type btrfs (ro,noexec,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=257,subvol=/varlocalspace)
/dev/sde1 on /var/cache/zoneminder type btrfs (ro,nosuid,nodev,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=257,subvol=/varlocalspace/zoneminder)
/dev/sde1 on /var/lib/mysql type btrfs (ro,nosuid,nodev,noatime,compress=lzo,ssd,discard,space_cache,skip_balance,subvolid=3648,subvol=/mysql)
gargamel:~# umount /mnt/btrfs_space; umount /var/local/space; umount /var/cache/zoneminder; umount /var/lib/mysql
gargamel:~# mount | grep sde

gargamel:~# mount /dev/sdp1 /mnt/mnt
mount: /mnt/mnt: mount(2) system call failed: File exists.
gargamel:~# dmtail 2
[1887142.826176] BTRFS error (device sde1): bdev /dev/sde1 errs: wr 1038, rd 4531, flush 0, corrupt 0, gen 0
[1887453.610947] BTRFS warning (device sde1): duplicate device fsid:devid for 727c7ba3-f6f9-462a-8472-453dd7d46d8a:1 old:/dev/sde1 new:/dev/sdp1

gargamel:/usr/local/bin# btrfs device scan --forget 
gargamel:/usr/local/bin# mount /dev/sdp1 /mnt/mnt
mount: /mnt/mnt: mount(2) system call failed: File exists.


After reboot, I made sure sde is not used by anything weird, just simple mounts:
gargamel:~# lsblk  | grep sde
sde                                 8:64   1 931.5G  0 disk  
├─sde1                              8:65   1 488.3M  0 part  
├─sde2                              8:66   1  14.9G  0 part  
├─sde3                              8:67   1    80G  0 part  
└─sde4                              8:68   1 836.1G  0 part 

Any ideas?

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
 
Home page: http://marc.merlins.org/                       | PGP 7F55D5F27AAF9D08
