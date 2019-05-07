Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 483E0168F6
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 19:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfEGRRw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 13:17:52 -0400
Received: from cloud.avgustinov.eu ([62.73.84.164]:58832 "EHLO
        cloud.avgustinov.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfEGRRw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 13:17:52 -0400
Received: from [192.168.29.36] (avgustinov.eu [87.140.63.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by cloud.avgustinov.eu (Postfix) with ESMTPSA id A032D50429F4;
        Tue,  7 May 2019 20:17:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=avgustinov.eu;
        s=default; t=1557249469;
        bh=gVlRcDMpo5LMUYKHNIrAGsW7MzOaWpkjdzinRAA5BTw=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=mfPQEIFmQuVzO6Zn/nfnsc3Jdg7TjBxB+6Z8siTy8fimxrLTcVsXf1CK6ugot6vkK
         loUHBKFaEKRZ08ondW2JAyt8pT5byY4NfxMAhSvqROE125QHuhHgyKBJIcNS29PqIl
         1ZH5gUQ6E/HUgGYlbGzOFgPGV4RXEuHW2pYBaZIDYsRN1L/8zTFMVHLA1v8hbQzx+m
         4Joc33AY/ecbmrn8QcBgGYuCRFadQQ56Dr9HmT0+IH5h2pvTbRoF/j9vObXjEDEAOZ
         gVWQj9hCqswXwaMMksr/vzBml9V3iW0z3cckdD1Vze1y/immxjJ7OLXu2VQ9rILV68
         +/V5Lzh4+WhNg==
Subject: Re: interest in post-mortem examination of a BTRFS system and
 improving the btrfs-code?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <aa81a49a-d5ca-0f1c-fa75-9ed3656cff55@avgustinov.eu>
 <e9720559-eff2-e88b-12b4-81defb8c29c5@avgustinov.eu>
 <a75981da-86f7-e0fb-d1dc-a2576b09c668@gmx.com>
 <039ec3eb-c44e-35e9-cf1b-f9f75849d873@avgustinov.eu>
 <c69778f5-a015-8b77-3fab-e41e49a0e0db@gmx.com>
 <51021dd7-b21b-b001-c3f9-9bc31205738b@avgustinov.eu>
 <00e3ddf1-cbd7-a65a-dee3-ca720cecc77d@gmx.com>
 <a6917f39-eeb4-5548-f346-a78972c7c3fe@avgustinov.eu>
 <6a592ffa-4a5a-81af-baef-8f1681accc87@gmx.com>
 <2c786019-646a-486f-1306-25a3df36e6b3@avgustinov.eu>
 <52b23bd7-108b-63f3-b958-2a5959c7ca6e@gmx.com>
 <f2b33d93-aa37-9fd3-6036-44e1e3f065eb@avgustinov.eu>
 <a9135dba-26fe-777f-048b-87052d5cbd14@gmx.com>
 <21ff2435-af15-573c-e897-05ceb4f42e0b@avgustinov.eu>
 <CAJCQCtQJkJwEyouCUzcV1MzPkcxhvtqxkWqmrwnB9txV=MUTXA@mail.gmail.com>
 <3f1f66d3-e04e-de16-e9a4-7c8a6238d5b8@gmx.com>
 <246c2330-acb6-3205-0468-051bacbfaeb5@avgustinov.eu>
 <24ab8eed-a790-bff2-cdad-0b091f7d0fe9@avgustinov.eu>
 <917e0530-7f68-a801-d87b-d00bb4e10287@gmx.com>
From:   "Nik." <btrfs@avgustinov.eu>
Message-ID: <00637d5e-b66f-7f87-b13b-7eea5a62fdfa@avgustinov.eu>
Date:   Tue, 7 May 2019 19:17:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <917e0530-7f68-a801-d87b-d00bb4e10287@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Finally found some time to finish the compilation of the requested 
kernel and accomplish the required test - s. below.

2019-04-12 12:50, Qu Wenruo:
> 
> 
> On 2019/4/12 下午6:44, Nik. wrote:
>>
>> 2019-04-08 23:22, Nik.:
>>>
>>>
>>> 2019-04-08 15:09, Qu Wenruo:
>>>> Unfortunately, I didn't receive the last mail from Nik.
>>>>
>>>> So I'm using the content from lore.kernel.org.
>>>>
>>>> [122293.101782] BTRFS critical (device md0): corrupt leaf: root=1
>>>> block=1894009225216 slot=82, bad key order, prev (2034321682432 168
>>>> 262144) current (2034318143488 168 962560)
>>>>
>>>> Root=1 means it's root tree, 168 means EXTENT_ITEM, which should only
>>>> occur in extent tree, not in root tree.
>>>>
>>>> This means either the leaf owner, or some tree blocks get totally
>>>> screwed up.
>>>>
>>>> This is not easy to fix, if possible.
>>>>
>>>> Would you please try this kernel branch and mount it with
>>>> "rescue=skip_bg,ro"?
>>>> https://github.com/adam900710/linux/tree/rescue_options

# uname -a
Linux bach 5.1.0-rc4_Bach_+ #2 SMP Sun May 5 22:28:03 CEST 2019 i686 
i686 i686 GNU/Linux

# mount -t btrfs -o rescue=skip_bg,ro /dev/md0 /mnt/tmp/
# dmesg |tail
[  265.410408] BTRFS info (device md0): skip mount time block group 
searching
[  265.410417] BTRFS info (device md0): disk space caching is enabled
[  265.763877] BTRFS info (device md0): bdev /dev/md0 errs: wr 0, rd 0, 
flush 0, corrupt 2181, gen 0

It took about 18 hours to compare the mounted volume with the backup 
(used rsync, without the "--checksum" option, because it was too slow; I 
can run it again with it, if you wish). Only about 300kB were not in my 
backup. Given the backup is also on a btrfs system, is there a more 
"intelligent" way to compare this huge tree with the backup? Optimally 
the fs would keep the check-sums and compare only them?
The thing which gave me tho think was the reported free space on the 
disk, I thought you should have a look at it, too:

# df -hT /mnt/*
Filesystem     Type   Size  Used Avail Use% Mounted on
/dev/sdb       btrfs  3.7T  3.2T  452G  88% /mnt/btraid	#backup
/dev/md0       btrfs  3.7T  3.1T   11P   1% /mnt/tmp	#original fs

I wish I had the reported disk space really :-D

Should I try something else (e.g., btrfs fsck) before reformat?

Best,
Nik.
[snip]
