Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A15B6C2E67
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 11:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjCUKHp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 06:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCUKHo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 06:07:44 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C927122C93
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 03:07:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5812241F98;
        Tue, 21 Mar 2023 10:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1679393254; bh=nKbwXbD33Z1mPw/E06xREmZBH1EqLRKDx6UZBSpBV9I=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To;
        b=gjXFbfzPudfKoCLiMHQdAZMg3FOzgSUUdKR6XR5/e83vDU6Y6cQN9hWKQN2dXCi9X
         +/2bM4KzrPwpZVBhpb46r1/EFhhbFOCNfqiQInONd+apXetM7CQKSlaWKeX6zF1mnS
         377cgHpNxypgLPCUqtmArc+gMU6JEpH9oGGFXYdKGU8mx9QGta596QJ8+Reu4QNK+v
         ax2YMSGCB4HQJhBMrrC1Hxd9Fx10OgUICN1IaXpeBm039/yX1IOAJAw+lct5OBzIkB
         l5O6rN6zFEmOLjTOSpgsTc59a4CBmD8Fc9HiqBmoZoN3nSWwrL4rkrgTW5dv+8doRz
         3ekTIHO1MljKg==
Message-ID: <8a52f55e-9b91-c6da-f2f6-eb8ccb87093d@marcan.st>
Date:   Tue, 21 Mar 2023 19:07:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Neal Gompa <neal@gompa.dev>,
        linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.cz>,
        Davide Cavalca <davide@cavalca.name>,
        Sven Peter <sven@svenpeter.dev>, "axboe@fb.com" <axboe@fb.com>,
        Asahi Linux <asahi@lists.linux.dev>
References: <20230321020320.2555362-1-neal@gompa.dev>
 <b4329200-650e-f46e-505a-e5248f187be6@gmx.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [RFC PATCH] btrfs-progs: mkfs: Enforce 4k sectorsize by default
In-Reply-To: <b4329200-650e-f46e-505a-e5248f187be6@gmx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,SPF_HELO_NONE,T_SPF_TEMPERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/03/2023 12.21, Qu Wenruo wrote:
> 
> 
> On 2023/3/21 10:03, Neal Gompa wrote:
>> We have had working subpage support in Btrfs for many cycles now.
>> Generally, we do not want people creating filesystems by default
>> with non-4k sectorsizes since it creates portability problems.
> 
> My biggest concern for now is, I haven't yet done any subpage testing 
> for a while.
> 
> The bottle neck is the lack of computing power.
> 
> I only have one decent (RK3588 based SBC, Rock5B) board available for 
> testing, but it's taken by my daily fstests runs, and it's still using 
> 4K page size for the aarc64 VM.
> 
> Although I have an backup SBC (the same Rock5B), it's reserved mostly 
> for upstreaming and testing for the RK3588 SoC.
> 
> Personally speaking, this change would bring a lot of more testing 
> feedback from Asahi guys, thus would be pretty awesome.

Note that we already have a bunch of people running Fedora Asahi, and as
far as I know those images are created on 4K systems and then used on
16K systems, so this should be already getting real-world testing (and
will get a lot more once we get to official announcement/release)
regardless of the default.

IOW, this change is mostly about people creating secondary btrfs
filesystems on Asahi directly, which is relatively niche in comparison.
So if you have a subpage bug it's going to hit Asahi users whether this
change happens or not :)

> 
> But on the other hand, I really don't want any big bug screwing up early 
> adopters, and further damage the reputation of btrfs.
> 
> 
> Would the Asahi guys gives us some early test results?
> (AKA, full fstests runs with 16K page size and 4K sectorsize).

Gave it a shot. Tested with options:

export TEST_DEV=/dev/nvme0n1p6
export TEST_DIR=/mnt/test
#export SCRATCH_DEV=/dev/nvme0n1p7
export SCRATCH_MNT=/mnt/scratch
export SCRATCH_DEV_POOL="/dev/nvme0n1p7 /dev/nvme0n1p8 /dev/nvme0n1p9
/dev/nvme0n1p10 /dev/nvme0n1p11"
export MKFS_OPTIONS="-s 4096"
export FSTYP=btrfs

btrfs/012 is broken, the converted FS fails to mount with:

[  784.588172] BTRFS warning (device nvme0n1p7): v1 space cache is not
supported for page size 16384 with sectorsize 4096
[  784.588199] BTRFS error (device nvme0n1p7): open_ctree failed

btrfs/131 and 136 have the same issue.

btrfs/106 has a size mismatch in the output, but I get the feeling
that's just a bad test that assumes 4K somewhere?

btrfs/140 is the first one that looks bad. Looks like the corruption
correction didn't work for some reason.

... and then btrfs/142 which is similar actually managed to log a bunch
of errors on our NVMe controller. Nice.

[ 1240.000104] nvme-apple 393cc0000.nvme: RTKit: syslog message:
host_ans2.c:1564: cmd parsing error for tag 12 fast decode err 0x1
[ 1240.000767] nvme0n1: Read(0x2) @ LBA 322753843, 0 blocks, Invalid
Field in Command (sct 0x0 / sc 0x2)
[ 1240.000771] nvme-apple 393cc0000.nvme: RTKit: syslog message:
host_ans2.c:1469: tag 12, completed with err BAD_CMD-
[ 1240.000775] operation not supported error, dev nvme0n1, sector
2582030751 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 2

Looks like it tried to read 0 blocks? I'm pretty sure that's not a valid
block device operation... and then that test hangs because the
_btrfs_direct_read_on_mirror() common function is completely broken, as
it infinite loops if the exec'd command fails (which it does here, with
ENOENT). Cc sven/axboe/asahi: I'm pretty sure we should catch
upper-layer badness like this before sending it to the controller.

Excluding that one and moving on, 143 is broken the same way, as are
btrfs/265, 266, 267, 269.

213 failed to balance with ENOSPC.

btrfs/246 has an output discrepancy, I don't know what's up with that.

generic/251 then failed too, with dmesg logs about failing to trim block
groups.

generic/520 failed with an EBUSY on umount, but I suspect this might be
some desktop/systemd stuff trying to use the mount?

generic/563 suggests there may be cgroup accounting issues

generic/619 seems known to be pathologically slow on arm64, so I killed
it (https://www.spinics.net/lists/linux-btrfs/msg131553.html).

generic/708 failed but that pointed to a known kernel bug that we don't
have the fix for yet (this is running on 6.2 + asahi patches).

Run output and some select dmesg sections:
https://gist.github.com/marcan/822a34266bcaf4f4cffaa6a198b4c616

Let me know if you need anything else.

> 
> If nothing wrong happened, I am very happy to this patch.
> 
> Thanks,
> Qu
>>
>> Signed-off-by: Neal Gompa <neal@gompa.dev>
>> ---
>>   Documentation/Subpage.rst    |  9 +++++----
>>   Documentation/mkfs.btrfs.rst | 11 +++++++----
>>   mkfs/main.c                  |  2 +-
>>   3 files changed, 13 insertions(+), 9 deletions(-)
>>
>> diff --git a/Documentation/Subpage.rst b/Documentation/Subpage.rst
>> index 21a495d5..d7e9b241 100644
>> --- a/Documentation/Subpage.rst
>> +++ b/Documentation/Subpage.rst
>> @@ -9,10 +9,11 @@ to the exactly same size of the block and page. On x86_64 this is typically
>>   pages, like 64KiB on 64bit ARM or PowerPC. This means filesystems created
>>   with 64KiB sector size cannot be mounted on a system with 4KiB page size.
>>   
>> -While with subpage support, systems with 64KiB page size can create (still needs
>> -"-s 4k" option for mkfs.btrfs) and mount filesystems with 4KiB sectorsize,
>> -allowing us to push 4KiB sectorsize as default sectorsize for all platforms in the
>> -near future.
>> +Since v6.3, filesystems are created with a 4KiB sectorsize by default,
>> +though it remains possible to create filesystems with other page sizes
>> +(such as 64KiB with the "-s 64k" option for mkfs.btrfs). This ensures that
>> +new filesystems are compatible across other architecture variants using
>> +larger page sizes.
>>   
>>   Requirements, limitations
>>   -------------------------
>> diff --git a/Documentation/mkfs.btrfs.rst b/Documentation/mkfs.btrfs.rst
>> index ba7227b3..af0b9c03 100644
>> --- a/Documentation/mkfs.btrfs.rst
>> +++ b/Documentation/mkfs.btrfs.rst
>> @@ -116,10 +116,13 @@ OPTIONS
>>   -s|--sectorsize <size>
>>           Specify the sectorsize, the minimum data block allocation unit.
>>   
>> -        The default value is the page size and is autodetected. If the sectorsize
>> -        differs from the page size, the created filesystem may not be mountable by the
>> -        running kernel. Therefore it is not recommended to use this option unless you
>> -        are going to mount it on a system with the appropriate page size.
>> +        The default value is 4KiB (4096). If larger page sizes (such as 64KiB [16384])
>> +        are used, the created filesystem will only mount on systems with a running kernel
>> +        running on a matching page size. Therefore it is not recommended to use this option
>> +        unless you are going to mount it on a system with the appropriate page size.
>> +
>> +        .. note::
>> +                Versions up to 6.3 set the sectorsize matching to the page size.
>>   
>>   -L|--label <string>
>>           Specify a label for the filesystem. The *string* should be less than 256
>> diff --git a/mkfs/main.c b/mkfs/main.c
>> index f5e34cbd..5e1834d7 100644
>> --- a/mkfs/main.c
>> +++ b/mkfs/main.c
>> @@ -1207,7 +1207,7 @@ int BOX_MAIN(mkfs)(int argc, char **argv)
>>   	}
>>   
>>   	if (!sectorsize)
>> -		sectorsize = (u32)sysconf(_SC_PAGESIZE);
>> +		sectorsize = (u32)SZ_4K;
>>   	if (btrfs_check_sectorsize(sectorsize))
>>   		goto error;
>>   
> 


- Hector
