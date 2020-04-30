Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F01BF916
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Apr 2020 15:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD3NSg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Apr 2020 09:18:36 -0400
Received: from forward103o.mail.yandex.net ([37.140.190.177]:55731 "EHLO
        forward103o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726841AbgD3NSg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Apr 2020 09:18:36 -0400
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 09:18:34 EDT
Received: from mxback29g.mail.yandex.net (mxback29g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:329])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id 5C1BA5F81686;
        Thu, 30 Apr 2020 16:12:45 +0300 (MSK)
Received: from sas8-6bf5c5d991b2.qloud-c.yandex.net (sas8-6bf5c5d991b2.qloud-c.yandex.net [2a02:6b8:c1b:2a1f:0:640:6bf5:c5d9])
        by mxback29g.mail.yandex.net (mxback/Yandex) with ESMTP id kwMaMc4Ucq-CjZOvOPE;
        Thu, 30 Apr 2020 16:12:45 +0300
Received: by sas8-6bf5c5d991b2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id bUWSzJjuHL-CieKeiXC;
        Thu, 30 Apr 2020 16:12:44 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: many csum warning/errors on qemu guests using btrfs
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>
References: <0ee3844d-830f-9f29-2cd5-61e3c9744979@yandex.pl>
 <76ec883b-3e44-fcda-d981-93a9e120f56d@yandex.pl>
 <CAJCQCtTxGRqA4SZFnC+G+=b0bK2ahpym+9eG31pRTv9FH1_-3w@mail.gmail.com>
 <cc0b6672-a65a-5c7b-d561-21cc585ead62@gmx.com>
From:   Michal Soltys <msoltyspl@yandex.pl>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Message-ID: <e531aed2-74f9-8eeb-4a56-9baadb782311@yandex.pl>
Date:   Thu, 30 Apr 2020 15:12:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cc0b6672-a65a-5c7b-d561-21cc585ead62@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/30/20 3:46 AM, Qu Wenruo wrote:
> 
> 
> On 2020/4/30 上午3:21, Chris Murphy wrote:
>> On Wed, Apr 29, 2020 at 9:45 AM Michal Soltys <msoltyspl@yandex.pl> wrote:
>>>
>>> Short update:
>>>
>>> 1) turned out to not be btrfs fault in any way or form, as we recreated
>>> the same issue with ext4 while manually checksumming the files; so if
>>> anything, btrfs told us we have actual issues somewhere =)
> 
> Is that related to mixing buffered write with DIO write?
> 
> If so, maybe changing the qemu cache mode may help?
> 
> Thanks,
> Qu
> 

Well, we initially thought the issue was with VMs only - but we also 
managed to hit the problem with host machine directly. As for VMs - they 
are all on separate lvm volumes (raw, not as images via filesystem - if 
that's what you meant in context of mixing writing modes).

The without-qemu stack looks like this:

- on the bottom 24 disk backplane connected to lsi 2308 controller (v20 
firwmare - for the record I found some tidbits, that this particular 
firmware versions proved problematic for some people)
- md raid5 - 4 mechanical disks using write-back journal (the journal 
device is md raid1 (2 ssds in the same backplane))
- the above raid device is added to lvm vg as a pv
- this pv is used for thin pool's data and 2 other ssds (mirrored on lvm 
level, physically not in backplane) are used for thin pool's metadata

Then it's a matter of simple mkfs.ext4 or mkfs.btrfs on a lv created in 
the above pool. Then a 16gb file created with e.g.:

dcfldd textpattern=$(hexdump -v -n 8192 -e '1/4 "%08X"' /dev/urandom) 
hash=md5 hashlog=./test.bin bs=262144 count=$((16*4096)) of=test.md5 
totalhashformat="#hash#"

Will usually (though not always) produce image that will read back 
(after dropping caches) with different checksum (ext4 case) or will have 
btrfs scrub complaining (btrfs case).

The culprits in the file will be one - few 4kb pieces with junk in them. 
This is also unlike any other sizes used across the stack (md raid - 
default 512kb chunk (1.5m stripe), lvm extents: 120m, thin-pool chunks: 
1.5m).

While trying to get the issue replicated, what didn't work:

- I put 4 other disks in the backlane and created another raid5 in the 
same way - using the same ssds as above for its journal - no issues
- used the new md raid as lvm linear volume - no issues either
- used the new md raid for lvm thin pool (using same ssds as earlier) - 
no issues either
- used the old (!?!) md raid (the one giving issues) but creating a 
linear volume on it - no issues

By "no issue" I mean the above dcfldd running in a loop for 3-6 hours, 
interleaved with sync/fstrim/drop_caches as appropriate.

By "issue" I mean 1-3 runs are enough to create file with silent 
corruptions.

What's worse, the "working" and "non-working" cases weirdly overlap with 
each other, making it hard to even reasonably pinpoint the reason (as 
for example, "it always happens if I use X").

While I realize it turned out not to be exactly btrfs mailing list 
material - I'll appreciate any suggestions. For now I'm planning to drop 
the firmware from 20 to 19 and update kernel - and see if that happens 
to help.


>>>
>>> 2) qemu/vm scenario is also not to be blamed, as we recreated the issue
>>> directly on the host as well
>>>
>>> So as far as I can see, both of the above narrows the potential culprits
>>> to either faulty/buggy hardware/firmware somewhere - or - some subtle
>>> lvm/md/kernel issues. Though so far pinpointing the issue is proving
>>> rather frustrating.
>>>
>>>
>>> Anyway, sorry for the noise.
>>
>> It's not noise. I think it's useful to see how Btrfs can help isolate
>> such cases.
>>
> 

