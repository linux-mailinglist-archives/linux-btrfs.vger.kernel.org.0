Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5757206EF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 10:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389216AbgFXI1i (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 04:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387686AbgFXI1h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 04:27:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7393C061573
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 01:27:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y18so782416plr.4
        for <linux-btrfs@vger.kernel.org>; Wed, 24 Jun 2020 01:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Jm/UGDJObTZHkS+Leuy38shkMwCYkAtndgAZVjDhWaI=;
        b=YXOYrFZsM9fmjSSMHPw9BjKsCc1wTxOJGGWNGEhZ23rzbM8LGLIJVQS47qwiG70V/F
         m1WQOWRLmazNRX2BCwvs25KjLuxx/YGlaeU4vqfjN52SgVMWdmdsOA8gRQh3XQeASIiu
         AY/cmGmDFUEHmjTw7ywOUGK8hilz2HRZ2b4x3mpm4qYzIXkN/r5fOvOPhqb4VSJTQYBl
         zGr9KTwMuem+103+l85/B4SFZpqFKErHyxdLpWQbynqvDjs1QUgoZFXCs54fxn+yK3rs
         uS7F+uQOhPZHS/73P3CYhn05lY3CFSqfYHbnFCfWMe+OVUU5kZdFUCNuWeli6n9UKYmp
         VqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Jm/UGDJObTZHkS+Leuy38shkMwCYkAtndgAZVjDhWaI=;
        b=rxzsc1k+9/9Q2DHnyjUcLvSm5zVwG98TaTsIflYkxAOuslp41lMxLp+8Ama3CFfDhs
         z22eJQ2VP/3mVXMb+LgGty4lLrlihmoXwqWtqlK3yo2PQwrsNLnvhNy6jdioa35RsjTk
         vvqVxDY6j8jRbPAgr15wBuiHU0Mlhj0pM2JglHE1ubiSJhtstxY9V9N+h77Y8/azH46x
         CIPpjvxvTeAwGbMBSk3VpUGDoqJq5VxipNlzeZCPJPu4d1/r3DXU4CuBybcm4R2l4VaS
         dvZUoPLMuYKZXliRMa8iziWJFZS0F0ezw8KL9Hr4rYhPTrkaDEF4Y9/+q4+5sN57gAEe
         keVA==
X-Gm-Message-State: AOAM531mtyDDK54pg13bI2zQj2n8vK5wcPaskq4QCEVwV+p1wLeg9+0j
        rZ1yafD7cp3f1Mqm+sJxjFR5g/AW
X-Google-Smtp-Source: ABdhPJz+axiNTMo8rVpnKjh7qLtV+Q1DVDwQuU+HaAviGLjb63QkRsW7UTydGDSdLPOOl5PMo0MOkg==
X-Received: by 2002:a17:902:7689:: with SMTP id m9mr25103769pll.98.1592987256454;
        Wed, 24 Jun 2020 01:27:36 -0700 (PDT)
Received: from [10.10.55.3] ([133.1.243.7])
        by smtp.gmail.com with ESMTPSA id k28sm197503pfp.82.2020.06.24.01.27.35
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 01:27:36 -0700 (PDT)
To:     linux-btrfs@vger.kernel.org
From:   Jiachen YANG <farseerfc@gmail.com>
Subject: btrfs-convert results unmountable fs due to extent "beyond device
 boundary"
Message-ID: <525158ac-813a-d533-f516-5d2acf9c068f@gmail.com>
Date:   Wed, 24 Jun 2020 17:27:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I noticed in some cases using btrfs-convert to convert a existing ext4 
to btrfs will result a fs that is unmountable with the kernel error says 
something like:

BTRFS error (device loop0): dev extent devid 1 physical offset 993198080 
len 85786624 is beyond device boundary 1073741824

To understand the condition that leads to this situation, I wrote a 
small script that can reproduce this problem using a loop image, both 
the script and the result is pasted on gist:
https://gist.github.com/farseerfc/4bb173227f5147913ef5e5eaba582f7b 
<https://gist.github.com/farseerfc/4bb173227f5147913ef5e5eaba582f7b>

After the btrfs-convert, it is still possible to rollback to ext4 and 
passes e2fsck.

The test is run on Arch Linux with kernel 5.7.5-arch1-1
btrfs-progs: 5.6.1-3

========== Start of test-btrfs-convert.sh
#!/bin/sh
set -x

cleanup(){
   umount testmount
}

# remove test image and recreate it
rm -rf testimage testmount
mkdir testmount
fallocate -l 1G testimage
mkfs.ext4 testimage

mount testimage testmount
trap cleanup ERR
trap cleanup EXIT

fallocate -l 200M testmount/test1
fallocate -l 200M testmount/test2
fallocate -l 200M testmount/test3
fallocate -l 200M testmount/test4

fallocate -l 205M testmount/test1
fallocate -l 205M testmount/test2
fallocate -l 205M testmount/test3
fallocate -l 205M testmount/test4

sync testmount/* testmount

df testmount
# should remain some space for btrfs-convert to write metadata
umount testmount

btrfs-convert testimage
mount testimage testmount
dmesg | tail -n10
btrfs inspect-internal dump-tree -t CHUNK testimage
========== End of test-btrfs-convert.sh

The following is the result:
========== Start of result.txt
+ rm -rf testimage testmount
+ mkdir testmount
+ fallocate -l 1G testimage
+ mkfs.ext4 testimage
mke2fs 1.45.6 (20-Mar-2020)
Discarding device blocks:   4096/262144             done
Creating filesystem with 262144 4k blocks and 65536 inodes
Filesystem UUID: f4746471-fb36-4a46-8b05-258557c24a0c
Superblock backups stored on blocks:
32768, 98304, 163840, 229376

Allocating group tables: 0/8   done
Writing inode tables: 0/8   done
Creating journal (8192 blocks): done
Writing superblocks and filesystem accounting information: 0/8 done

+ mount testimage testmount
+ trap cleanup ERR
+ trap cleanup EXIT
+ fallocate -l 200M testmount/test1
+ fallocate -l 200M testmount/test2
+ fallocate -l 200M testmount/test3
+ fallocate -l 200M testmount/test4
+ fallocate -l 205M testmount/test1
+ fallocate -l 205M testmount/test2
+ fallocate -l 205M testmount/test3
+ fallocate -l 205M testmount/test4
+ sync testmount/lost+found testmount/test1 testmount/test2 
testmount/test3 testmount/test4 testmount
+ df testmount
Filesystem     1K-blocks   Used Available Use% Mounted on
/dev/loop0        999320 842244     88264  91% 
/home/farseerfc/tmp/testbtrfsconvert/testmount
+ umount testmount
+ btrfs-convert testimage
create btrfs filesystem:
blocksize: 4096
nodesize:  16384
features:  extref, skinny-metadata (default)
checksum:  crc32c
creating ext2 image file
creating btrfs metadata
copy inodes [o] [         0/        15]
conversion complete
+ mount testimage testmount
mount: /home/farseerfc/tmp/testbtrfsconvert/testmount: wrong fs type, 
bad option, bad superblock on /dev/loop0, missing codepage or helper 
program, or other error.
++ cleanup
++ umount testmount
umount: testmount: not mounted.
+ dmesg
+ tail -n10
[108720.796804] audit: type=1110 audit(1592986026.992:1462): pid=1223346 
uid=0 auid=1000 ses=2 msg='op=PAM:setcred 
grantors=pam_unix,pam_permit,pam_env acct="root" exe="/usr/bin/sudo" 
hostname=? addr=? terminal=/dev/pts/5 res=success'
[108720.797047] audit: type=1105 audit(1592986026.992:1463): pid=1223346 
uid=0 auid=1000 ses=2 msg='op=PAM:session_open 
grantors=pam_limits,pam_unix,pam_permit acct="root" exe="/usr/bin/sudo" 
hostname=? addr=? terminal=/dev/pts/5 res=success'
[108721.091932] EXT4-fs (loop0): mounted filesystem with ordered data 
mode. Opts: (null)
[108724.885590] BTRFS: device fsid 8c731320-4aed-40de-bdd7-c817217625dc 
devid 1 transid 5 /dev/loop0 scanned by systemd-udevd (1223354)
[108724.887288] BTRFS info (device loop0): disk space caching is enabled
[108724.887292] BTRFS info (device loop0): has skinny extents
[108724.887295] BTRFS info (device loop0): flagging fs with big metadata 
feature
[108724.891277] BTRFS error (device loop0): dev extent devid 1 physical 
offset 993198080 len 85786624 is beyond device boundary 1073741824
[108724.891279] BTRFS error (device loop0): failed to verify dev extents 
against chunks: -117
[108724.919813] BTRFS error (device loop0): open_ctree failed
+ btrfs inspect-internal dump-tree -t CHUNK testimage
btrfs-progs v5.6.1
chunk tree
leaf 33619968 items 14 free space 14795 generation 3 owner CHUNK_TREE
leaf 33619968 flags 0x1(WRITTEN) backref revision 1
fs uuid 8c731320-4aed-40de-bdd7-c817217625dc
chunk uuid a5a0638e-944a-4b92-989c-8cd252e427e8
item 0 key (DEV_ITEMS DEV_ITEM 1) itemoff 16185 itemsize 98
devid 1 total_bytes 1073741824 bytes_used 1023410176
io_align 4096 io_width 4096 sector_size 4096 type 0
generation 0 start_offset 0 dev_group 0
seek_speed 0 bandwidth 0
uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
fsid 8c731320-4aed-40de-bdd7-c817217625dc
item 1 key (FIRST_CHUNK_TREE CHUNK_ITEM 1048576) itemoff 16105 itemsize 80
length 32505856 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 1048576
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 2 key (FIRST_CHUNK_TREE CHUNK_ITEM 33619968) itemoff 16025 itemsize 80
length 4194304 owner 2 stripe_len 65536 type SYSTEM
io_align 4096 io_width 4096 sector_size 4096
num_stripes 1 sub_stripes 0
stripe 0 devid 1 offset 33619968
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 3 key (FIRST_CHUNK_TREE CHUNK_ITEM 67174400) itemoff 15945 itemsize 80
length 33554432 owner 2 stripe_len 65536 type METADATA
io_align 4096 io_width 4096 sector_size 4096
num_stripes 1 sub_stripes 0
stripe 0 devid 1 offset 67174400
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 4 key (FIRST_CHUNK_TREE CHUNK_ITEM 134217728) itemoff 15865 itemsize 80
length 107372544 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 134217728
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 5 key (FIRST_CHUNK_TREE CHUNK_ITEM 241590272) itemoff 15785 itemsize 80
length 107372544 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 241590272
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 6 key (FIRST_CHUNK_TREE CHUNK_ITEM 348962816) itemoff 15705 itemsize 80
length 107372544 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 348962816
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 7 key (FIRST_CHUNK_TREE CHUNK_ITEM 456335360) itemoff 15625 itemsize 80
length 107372544 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 456335360
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 8 key (FIRST_CHUNK_TREE CHUNK_ITEM 563707904) itemoff 15545 itemsize 80
length 107372544 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 563707904
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 9 key (FIRST_CHUNK_TREE CHUNK_ITEM 671080448) itemoff 15465 itemsize 80
length 107372544 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 671080448
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 10 key (FIRST_CHUNK_TREE CHUNK_ITEM 778452992) itemoff 15385 
itemsize 80
length 107372544 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 778452992
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 11 key (FIRST_CHUNK_TREE CHUNK_ITEM 885825536) itemoff 15305 
itemsize 80
length 107372544 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 885825536
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 12 key (FIRST_CHUNK_TREE CHUNK_ITEM 993198080) itemoff 15225 
itemsize 80
length 85786624 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 993198080
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
item 13 key (FIRST_CHUNK_TREE CHUNK_ITEM 1078984704) itemoff 15145 
itemsize 80
length 8388608 owner 2 stripe_len 65536 type DATA
io_align 65536 io_width 65536 sector_size 4096
num_stripes 1 sub_stripes 1
stripe 0 devid 1 offset 37814272
dev_uuid 6d4bcef2-cb79-4fe3-a63a-bb0fd07dea30
+ cleanup
+ umount testmount
umount: testmount: not mounted.
++ cleanup
++ umount testmount
umount: testmount: not mounted.
========== End of result.txt

Is this a known bug in btrfs-convert ?
I myself cannot fully understand why this happens
