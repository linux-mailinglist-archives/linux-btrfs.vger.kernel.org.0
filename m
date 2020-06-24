Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452B02073F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Jun 2020 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403913AbgFXNEJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 Jun 2020 09:04:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:55386 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403900AbgFXNEI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 Jun 2020 09:04:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F0178AE93;
        Wed, 24 Jun 2020 13:04:01 +0000 (UTC)
Subject: Re: btrfs dev sta not updating
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Russell Coker <russell@coker.com.au>, linux-btrfs@vger.kernel.org
References: <4857863.FCrPRfMyHP@liv> <5752066.y3qnG1rHMR@liv>
 <d4c28f49-f6fc-0fc7-0c4d-4fe8b3ce32a9@suse.com> <6248217.VoG1EAXHid@liv>
 <00ce925f-e8bb-be84-40bb-25fd215891e6@suse.com>
 <20200624113940.GQ10769@hungrycats.org>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <18a20558-332b-cb5f-7e18-5d048344537e@suse.com>
Date:   Wed, 24 Jun 2020 16:04:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624113940.GQ10769@hungrycats.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 24.06.20 г. 14:39 ч., Zygo Blaxell wrote:
> On Tue, Jun 23, 2020 at 02:13:04PM +0300, Nikolay Borisov wrote:
>>
>>
>> On 23.06.20 г. 12:48 ч., Russell Coker wrote:
>>> On Tuesday, 23 June 2020 6:17:00 PM AEST Nikolay Borisov wrote:
>>>>> In this case I'm getting application IO errors and lost data, so if the
>>>>> error count is designed to not count recovered errors then it's still not
>>>>> doing the right thing.
>>>>
>>>> In this case yes, however this was utterly not clear from your initial
>>>> email. In fact it seems you have omitted quite a lot of information. So
>>>> let's step back and start afresh. So first give information about your
>>>> current btrfs setup by giving the output of:
>>>>
>>>> btrfs fi usage /path/to/btrfs
>>>
>>> # btrfs fi usa .
>>> Overall:
>>>     Device size:                  62.50GiB
>>>     Device allocated:             19.02GiB
>>>     Device unallocated:           43.48GiB
>>>     Device missing:                  0.00B
>>>     Used:                         16.26GiB
>>>     Free (estimated):             44.25GiB      (min: 22.51GiB)
>>>     Data ratio:                       1.00
>>>     Metadata ratio:                   2.00
>>>     Global reserve:               17.06MiB      (used: 0.00B)
>>>
>>> Data,single: Size:17.01GiB, Used:16.23GiB (95.43%)
>>>    /dev/sdc1      17.01GiB
>>>
>>> Metadata,DUP: Size:1.00GiB, Used:17.19MiB (1.68%)
>>>    /dev/sdc1       2.00GiB
>>>
>>> System,DUP: Size:8.00MiB, Used:16.00KiB (0.20%)
>>>    /dev/sdc1      16.00MiB
>>>
>>> Unallocated:
>>>    /dev/sdc1      43.48GiB
>>
>> Do you use compression on this filesystem i.e have you mounted with
>> -ocompression= option ?
>>
>> Based on this data alone it's evident that you don't really have mirrors
>> of the data, in this case having experienced the checksum errors should
>> have indeed resulted in error counters being incremented. I'll look into
>> this.
> 
> In commit 0cc068e6ee59 "btrfs: don't report readahead errors and don't
> update statistics" we stopped counting errors if they occur during
> readahead.  If there's a mirror available, we do still correct errors
> in that case.  Errors in readahead are fairly common, e.g. there are
> usually a few during lvm pvmove operations, so it maybe makes sense
> not to count them; however, if the errors are not counted, they should
> also not be repaired.  Instead, they should be repaired only during
> non-readahead reads (i.e. when the repairs will be counted in dev stats).
> Repairing errors without counting is bad because it hides an important
> indicator of device failure.
> 
> This thread might be a different issue since there aren't any mirrors
> with single data, but if you're look at dev stats correctness anyway...

Turns out this is a genueine bug, namely errors stats are only ever
updated in btrfs_end_bio which  happens well before checksums are
checked. In fact at the time when we are checking checksums
end_bio_extent_readpage->readpage_end_io_hook
(btrfs_readpage_end_io_hook) we don't (currently) have enough context to
increment the errors. I'm currently testing a tentative fix for this.

> 
>> <snip>
> 
