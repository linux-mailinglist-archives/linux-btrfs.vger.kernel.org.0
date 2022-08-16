Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE18595B93
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Aug 2022 14:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbiHPMRm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 16 Aug 2022 08:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiHPMRW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 16 Aug 2022 08:17:22 -0400
X-Greylist: delayed 1889 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Aug 2022 05:14:07 PDT
Received: from bosmailout10.eigbox.net (bosmailout10.eigbox.net [66.96.184.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F00F258092
        for <linux-btrfs@vger.kernel.org>; Tue, 16 Aug 2022 05:14:07 -0700 (PDT)
Received: from bosmailscan06.eigbox.net ([10.20.15.6])
        by bosmailout10.eigbox.net with esmtp (Exim)
        id 1oNuxx-0004uZ-4L
        for linux-btrfs@vger.kernel.org; Tue, 16 Aug 2022 07:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=livingrock.ca; s=dkim; h=Sender:Content-Transfer-Encoding:Content-Type:
        Message-ID:Subject:To:From:Date:MIME-Version:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I6BMqxRE+rw2p0Bavl8zsuvDP/NKX93D0HbwMx65BSg=; b=Fn2z9qAHk9Ayvci5zVjUJ0oRR4
        wobFLWXlGYkjiwQbpaOMg3yRlRiGyRjLo1OMmQlZ7w4UU9kFccrmbGaIdgDtv3t/ChSys4oM5JNt7
        R4PX6QZES+9sWWrudppfQyjZyA1Lwl/ZclnMLwAQf1eousGTo/MuWpMW/Ula4YCB3sgzwEzuPf0nJ
        GQc064mkQQIzC2l9ulR3NCBHTh+SwKGvlbehiPpUkWymQuWWFsdEvftSwZDZV4KMGWaUqPghhqhSq
        4VNGMEm5utUuSg8BM9vbO9LlLpf4dNlWHIV8grPqO1XGP5ds50d9zqhURdsZ0x4UD1/J1CRo8DnbX
        cVE3BlGQ==;
Received: from [10.115.3.33] (helo=bosimpout13)
        by bosmailscan06.eigbox.net with esmtp (Exim)
        id 1oNuxu-00053z-R8
        for linux-btrfs@vger.kernel.org; Tue, 16 Aug 2022 07:42:34 -0400
Received: from boswebmail16.eigbox.net ([10.20.16.16])
        by bosimpout13 with 
        id 8BiX2800F0Lne6201Bia9f; Tue, 16 Aug 2022 07:42:34 -0400
X-Authority-Analysis: v=2.3 cv=H7JAP9Qi c=1 sm=1 tr=0
 a=uPHUT7CEn0Da+Qm5h3+6qg==:117 a=Xo0g7jLAgYZNh8g4AH6wCw==:17
 a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=pYBh9BUqc8iRcud13BkA:9 a=CjuIK1q_8ugA:10
Received: from [127.0.0.1] (helo=ipage)
        by boswebmail16.eigbox.net with esmtp (Exim)
        id 1oNuxf-00052j-Ro
        for linux-btrfs@vger.kernel.org; Tue, 16 Aug 2022 07:42:19 -0400
Received: from [142.126.81.65]
 by emailmg.ipage.com
 with HTTP (HTTP/1.1 POST); Tue, 16 Aug 2022 07:42:19 -0400
MIME-Version: 1.0
Date:   Tue, 16 Aug 2022 07:42:19 -0400
From:   J <j@livingrock.ca>
To:     linux-btrfs@vger.kernel.org
Subject: Support Question: ERROR: cannot read chunk root ERROR: cannot open
 file system
Organization: Living Rock Ministries
Message-ID: <3b28d4fcb0eff4560993841781b1a20f@livingrock.ca>
X-Sender: j@livingrock.ca
User-Agent: Roundcube Webmail/1.3.14
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-EN-AuthUser: j@livingrock.ca
Sender:  J <j@livingrock.ca>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi All,

This one's a bit long, my apologies in advance...

EDIT: It's longer now - resending because the message didn't show up in 
the list - I re-read "restrictions" section and noticed some HTML 
originally - I'm also adding things I missed from the " What information 
to provide when asking a support question" section...

I had some server issues where my server drives became mounted 
read-only...

One part of the problem is that I had attempted to convert a regular 
install into a raid one [data and metadata DUP'd] to another drive but 
the copy quit part way.  I could *never* get it to complete the fully 
DUP'd data and I could *also* not convert it back to single [and remove 
the unneeded drive].

Everything was "working" at the time, albeit I *knew* this would be a 
problem if I didn't sit down and deal with it *eventually*...

Well dmesg shows me that on Saturday the second drive dropped off the 
face of the planet, so to speak... I *don't* have that dmesg log, 
unfortunately, because I can't access the remaining drive... (why I'm 
here).  They were ATA DID errors and such followed by BTRFS errors about 
the now missing drive.  That same disk now throws a bunch of errors and 
doesn't even show as a volume [no media found] when trying to fdisk -l / 
blkid / etc...

The server seems to have went into a "read-only" mode, ssh worked but 
samba/dns did not, for example.

I backed up a couple of important files, I did *not* try remounting in 
degraded,rw or anything [I read you can only do that once], and I 
decided to reboot and see where I was at.

Well, stuck at Grub> is where /sigh...

Anyway, I've taken the drive and threw it in another machine and ran:

     mount -o degraded,recovery,ro -t btrfs /dev/sdb2 /tmp/y

mount: /tmp/y: wrong fs type, bad option, bad superblock on /dev/sdb2, 
missing codepage or helper program, or other error.

dmesg shows:

[Mon Aug 15 14:57:25 2022] BTRFS info (device sdb2): flagging fs with 
big metadata feature
[Mon Aug 15 14:57:25 2022] BTRFS info (device sdb2): allowing degraded 
mounts
[Mon Aug 15 14:57:25 2022] BTRFS warning (device sdb2): 'recovery' is 
deprecated, use 'rescue=usebackuproot' instead
[Mon Aug 15 14:57:25 2022] BTRFS info (device sdb2): trying to use 
backup root at mount time
[Mon Aug 15 14:57:25 2022] BTRFS info (device sdb2): disk space caching 
is enabled
[Mon Aug 15 14:57:25 2022] BTRFS info (device sdb2): has skinny extents
[Mon Aug 15 14:57:25 2022] BTRFS warning (device sdb2): devid 2 uuid 
e4e5ecce-36cd-4156-9fe2-26b3e2467956 is missing
[Mon Aug 15 14:57:25 2022] BTRFS error (device sdb2): failed to read 
chunk root
[Mon Aug 15 14:57:25 2022] BTRFS error (device sdb2): open_ctree failed

I get "failed to read chunk root" and open_ctree" are *bad* /sigh...

> blkid /dev/sdb2

/dev/sdb2: LABEL="openSUSE" UUID="78ff13bd-3947-4364-ad7b-0557747c1da8" 
UUID_SUB="8d684877-1310-4642-911a-b0a576616678" BLOCK_SIZE="4096" 
TYPE="btrfs" PARTUUID="2cc0274e-4ad8-7c4e-b0d0-01e5a5c9e59a"

So it *looks* like I'm looking at the btrfs filesystem I want... at 
least.

Running 'btrfs check /dev/sdb2' gets me:

Opening filesystem to check...
warning, device 2 is missing
warning, device 2 is missing
bad tree block 713120808960, bytenr mismatch, want=713120808960, have=0
ERROR: cannot read chunk root
ERROR: cannot open file system

I saw a suggestion to use the backup chunk in a thread, but 
unfortunately, it seems like that's already being attempted because 
dmesg has the line:

BTRFS info (device sdb2): trying to use backup root at mount time

I retrieved the chunk root backups with:

> btrfs inspect-internal dump-super -f /dev/sdb2


superblock: bytenr=65536, device=/dev/sdb2
---------------------------------------------------------
csum_type        0 (crc32c)
csum_size        4
csum            0xfd163fbc [match]
bytenr            65536
flags            0x1
             ( WRITTEN )
magic            _BHRfS_M [match]
fsid            78ff13bd-3947-4364-ad7b-0557747c1da8
metadata_uuid        78ff13bd-3947-4364-ad7b-0557747c1da8
label            openSUSE
generation        3490692
root            472987779072
sys_array_size        129
chunk_root_generation    3474754
root_level        1
chunk_root        713120808960
chunk_root_level    0
log_root        473010618368
log_root_transid    0
log_root_level        0
total_bytes        479693250560
bytes_used        105214308352
sectorsize        4096
nodesize        16384
leafsize (deprecated)    16384
stripesize        4096
root_dir        6
num_devices        2
compat_flags        0x0
compat_ro_flags        0x0
incompat_flags        0x163
             ( MIXED_BACKREF |
               DEFAULT_SUBVOL |
               BIG_METADATA |
               EXTENDED_IREF |
               SKINNY_METADATA )
cache_generation    3490692
uuid_tree_generation    70
dev_item.uuid        8d684877-1310-4642-911a-b0a576616678
dev_item.fsid        78ff13bd-3947-4364-ad7b-0557747c1da8 [match]
dev_item.type        0
dev_item.total_bytes    239846625280
dev_item.bytes_used    53703868416
dev_item.io_align    4096
dev_item.io_width    4096
dev_item.sector_size    4096
dev_item.devid        1
dev_item.dev_group    0
dev_item.seek_speed    0
dev_item.bandwidth    0
dev_item.generation    0
sys_chunk_array[2048]:
     item 0 key (FIRST_CHUNK_TREE CHUNK_ITEM 713120808960)
         length 33554432 owner 2 stripe_len 65536 type SYSTEM|DUP
         io_align 65536 io_width 65536 sector_size 4096
         num_stripes 2 sub_stripes 1
             stripe 0 devid 2 offset 23690477568
             dev_uuid e4e5ecce-36cd-4156-9fe2-26b3e2467956
             stripe 1 devid 2 offset 23724032000
             dev_uuid e4e5ecce-36cd-4156-9fe2-26b3e2467956
backup_roots[4]:
     backup 0:
         backup_tree_root:    472974147584    gen: 3490691    level: 1
         backup_chunk_root:    713120808960    gen: 3474754    level: 0
         backup_extent_root:    472974000128    gen: 3490691    level: 2
         backup_fs_root:        206436401152    gen: 1791146    level: 0
         backup_dev_root:    473014091776    gen: 3474754    level: 0
         backup_csum_root:    472976818176    gen: 3490691    level: 2
         backup_total_bytes:    479693250560
         backup_bytes_used:    105214308352
         backup_num_devices:    2

     backup 1:
         backup_tree_root:    472987779072    gen: 3490692    level: 1
         backup_chunk_root:    713120808960    gen: 3474754    level: 0
         backup_extent_root:    472986746880    gen: 3490692    level: 2
         backup_fs_root:        206436401152    gen: 1791146    level: 0
         backup_dev_root:    473014091776    gen: 3474754    level: 0
         backup_csum_root:    472988975104    gen: 3490692    level: 2
         backup_total_bytes:    479693250560
         backup_bytes_used:    105214308352
         backup_num_devices:    2

     backup 2:
         backup_tree_root:    473518882816    gen: 3490689    level: 1
         backup_chunk_root:    713120808960    gen: 3474754    level: 0
         backup_extent_root:    473477480448    gen: 3490689    level: 2
         backup_fs_root:        206436401152    gen: 1791146    level: 0
         backup_dev_root:    473014091776    gen: 3474754    level: 0
         backup_csum_root:    473477398528    gen: 3490689    level: 2
         backup_total_bytes:    479693250560
         backup_bytes_used:    105214308352
         backup_num_devices:    2

     backup 3:
         backup_tree_root:    473900826624    gen: 3490690    level: 1
         backup_chunk_root:    713120808960    gen: 3474754    level: 0
         backup_extent_root:    473763954688    gen: 3490690    level: 2
         backup_fs_root:        206436401152    gen: 1791146    level: 0
         backup_dev_root:    473014091776    gen: 3474754    level: 0
         backup_csum_root:    472951717888    gen: 3490690    level: 2
         backup_total_bytes:    479693250560
         backup_bytes_used:    105214308352
         backup_num_devices:    2

I'm wondering if there's any suggestions anyone has to at least read the 
rest of my data [the stuff I didn't copy off before rebooting]?

My *data* backups are fine [snapshots + btrfs send/receive to offsite] 
(on different drives, not relevant here), but my server *configuration* 
[and keys, in hindsight] hasn't really properly been backed up [it was 
going to happen right after I fixed my "raid" issue]...

I saw a mention that the chunk tree may be able to be rebuilt if the 
underlying blocks are fine - I don't know if I misread that or not - and 
also if that becomes impossible because of missing one of the 
devices...?

Anyway - I'm going to work on rebuilding what I can and hopefully 
someone has suggestions to recover *this* data...

I can't *wait* to hear the "shoulda/woulda/coulda" backed everything up 
*before* this happened - lol /sigh...

EDIT: extra info for when asking a support question

> uname -a
Linux <hostname> 5.14.9-1-default #1 SMP Fri Oct 1 07:22:19 UTC 2021 
(d0ace7f) x86_64 x86_64 x86_64 GNU/Linux

> btrfs --version
btrfs-progs v5.14.1

I cannot provide ' btrfs fi show' because I can no longer mount to get 
that far.  Before reboot, I know that 'btrfs fi df /' showed around 
100GiB used out of 447GiB (actually 2 240GB drive in raid 1 - but there 
was ample unallocated space).

For the same reason (will not mount) I also cannot provide the dmesg.log 
from the formerly running drive.

Thank you for reading [if you got this far],



J
