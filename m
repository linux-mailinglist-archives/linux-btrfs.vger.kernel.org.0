Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2F935C17
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Jun 2019 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfFELyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Jun 2019 07:54:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:33994 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727381AbfFELyY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 5 Jun 2019 07:54:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 32739AC24;
        Wed,  5 Jun 2019 11:54:22 +0000 (UTC)
Subject: Re: [PATCH v2] fstests: generic/260: Make it handle btrfs more
 gracefully
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20190603064009.9891-1-wqu@suse.com>
 <261bff5e-c0c1-2a38-28d9-964a6c713745@suse.com>
 <88a52f0f-da5a-0097-afe1-c1a207f9a318@gmx.com>
From:   Nikolay Borisov <nborisov@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f173ae7b-08c8-8eac-f3df-a07a63e56157@suse.com>
Date:   Wed, 5 Jun 2019 14:54:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <88a52f0f-da5a-0097-afe1-c1a207f9a318@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 5.06.19 г. 14:53 ч., Qu Wenruo wrote:
> 
> 
> On 2019/6/5 下午7:16, Nikolay Borisov wrote:
>>
>>
>> On 3.06.19 г. 9:40 ч., Qu Wenruo wrote:
>>> If a filesystem doesn't map its logical address space (normally the
>>> bytenr/blocknr returned by fiemap) directly to its devices(s), the
>>> following assumptions used in the test case is no longer true:
>>> - trim range start beyond the end of fs should fail
>>> - trim range start beyond the end of fs with len set should fail
>>>
>>> Under the following example, even with just one device, btrfs can still
>>> trim the fs correctly while breaking above assumption:
>>>
>>> 0		1G		1.25G
>>> |---------------|///////////////|-----------------| <- btrfs logical
>>> 		   |				       address space
>>>         ------------  mapped as SINGLE
>>>         |
>>> 0	V	256M
>>> |///////////////|			<- device address space
>>>
>>> Thus trim range start=1G len=256M will cause btrfs to trim the 256M
>>> block group, thus return correct result.
>>>
>>> Furthermore, there is no cleared defined behavior for whether a fs should
>>> trim the unmapped space. (only for indirectly mapped fs)
>>>
>>> Btrfs currently will always trim the unmapped space, but the behavior
>>> can change as large trim can be very expensive.
>>>
>>> Despite the change to skip certain tests for btrfs, still run the
>>> following tests for btrfs:
>>> - trim start=U64_MAX with lenght set
>>>   This will expose a bug that btrfs doesn't check overflow of the range.
>>>   This bug will be fixed soon.
>>>
>>> - trim beyond the end of the fs
>>>   This will expose a bug where btrfs could send trim command beyond the
>>>   end of its device.
>>>   This bug is a regression, can be fixed by reverting c2d1b3aae336 ("btrfs:
>>>   Honour FITRIM range constraints during free space trim")
>>>
>>> With proper fixes for btrfs, this test case should pass on btrfs, ext4,
>>> xfs.
>>>
>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>> ---
>>> changelog:
>>> v2:
>>> - Return 0/1 instead of echo "1"/"0" for _is_fs_directly_mapped
>>>   Although it may be a little confusing, but make
>>>   "if _is_fs_directly_mapped; then" much cleaner.
>>> - Comment change.
>>> ---
>>
>> Nope, the output is rather unhelpful. Current misc-next of btrfs fails
>> and the output is:
> 
> This is not the output. This is seqres.full.
> 
> For output, using 5.2-rc2, btrfs would fail like:
> [+] Optional trim range test (fs dependent)
> [+] Default length (should succeed)
> [+] Default length with start set (should succeed)
> [+] Length beyond the end of fs (should succeed)
> [+] Length beyond the end of fs with start set (should succeed)
> Unexpected error happened during trim
> Test done
> 
> Which is already good enough to show what's wrong.
> 
>>
>> [+] Start = 2^64-1 and len is set (should fail)
>>
>> [+] Trim an empty fs
>>
>> 13554941952 trimed
>>
>> [+] Try to trim beyond the end of the fs
>>
>> [+] Try to trim the fs with large enough len
>>
>> 15727198208 trimed
> 
> For this full, try it on 5.2-rc2, then you would understand why it's here:
> 
> [+] Start = 2^64-1 and len is set (should fail)  << It doesn't fail
> [+] Trim an empty fs
> 0 trimed  << It trimmed 0 bytes, isn't it already a problem?
> [+] Try to trim beyond the end of the fs
> fstrim: /mnt/scratch: FITRIM ioctl failed: Input/output error  << Beyond
> device end bug
> [+] Try to trim the fs with large enough len
> 5367267328 trimed  << The only good result here.
> 
>>
>> generic/260	[failed, exit status 1]
>>
>>
>> There is no 260.out file which is supposed to contain some of the error
>> strings which in turn makes the test tedious to debug...
> 
> I'm afraid you're checking the wrong file.

I don't have an .out file produced!


> 
> Thanks,
> Qu
> 
>>
>>
>> <snip>
>>
> 
