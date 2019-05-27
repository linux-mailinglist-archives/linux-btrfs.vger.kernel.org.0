Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 537FF2B768
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 May 2019 16:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfE0OTX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 May 2019 10:19:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:40966 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbfE0OTX (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 May 2019 10:19:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57B3EAEF3
        for <linux-btrfs@vger.kernel.org>; Mon, 27 May 2019 14:19:21 +0000 (UTC)
Subject: Re: [PATCH] btrfs-progs: convert: Workaround delayed ref bug by
 limiting the size of a transaction
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20190527051054.533-1-wqu@suse.com>
 <eb2e9c3e-3b61-6c46-237d-c20b62092405@suse.com>
From:   Qu Wenruo <wqu@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=wqu@suse.de; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0F1F1IFdlbnJ1byA8d3F1QHN1c2UuZGU+iQFUBBMBCAA+AhsDBQsJCAcCBhUICQoLAgQW
 AgMBAh4BAheAFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVgp0FCQlmAm4ACgkQwj2R86El
 /qilmgf/cUq9kFQo577ku5gc6rFpVg68ublBwjYpwjw0b//xo+Wo1wm+RRbUGs+djSZAqw12
 D4F3r0mBTI7abUCNWAbFkYZSAIFVi0DMkjypIVS7PSaEt04rM9VBTToE+YqU6WENeJ57R2p2
 +hI0wZrBwxObdsdaOtxWtsp3bmhIbdqxSKrtXuRawy4KnQYcLuGzOce9okdlbAE0W3KHm1gQ
 oNAe6FX8nC9qo14m8LqEbThYH+qj4iCMlN8HIfbSx4F3e7nHZ+UAMW+E/lnMRkIB9Df+JyVd
 /NlXzIjZAggcWsqpx6D4wyAuexKWkiGQeUeArUNihAwXjmyqWPGmjVyIh+oC6LkBDQRZ1YGv
 AQgAqlPrYeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4K
 Xk/kHw5hieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T
 7RZwB69uVSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9
 fNN8e9c0MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD
 /dt76Kp/o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgB
 CAAmFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlnVga8CGwwFCQPCZwAACgkQwj2R86El/qgN
 8Qf+M0vM2Idwm5txZZSs+/kSgcPxEwYmxUinnUJGyc0ZWYQXPl0cBetZon9El0naijGzNWvf
 HxIPB+ZFehk6Otgc78p1a3/xck/s1myFRLrmbbTJNoFiyL25ljcq0J8z5Zp4yuABL2RiLdaZ
 Pt/jfwjBHwGR+QKp6dD2qMrUWf9b7TFzYDMZXzZ2/eoIgtyjEelNBPrIgOFe24iKMjaGjd97
 fJuRcBMHdhUAxvXQF1oRtd83JvYJ5OtwTd8MgkEfl+fo7HwWkuHbzc70L4fFKv2BowqFdaHy
 mId1ijGPGr46tuZ5a4cw/zbaPYx6fJ4sK9tSv/6V1QPNUdqml6hm6pfs6A==
Message-ID: <757a0b6b-864f-17f8-5332-74f82dee8a67@suse.de>
Date:   Mon, 27 May 2019 22:19:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <eb2e9c3e-3b61-6c46-237d-c20b62092405@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/5/27 下午10:16, Nikolay Borisov wrote:
> 
> 
> On 27.05.19 г. 8:10 ч., Qu Wenruo wrote:
>> In convert we use trans->block_reserved >= 4096 as a threshold to commit
>> transaction, where block_reserved is the number of new tree blocks
>> allocated inside a transaction.
>>
>> The problem is, we still have a hidden bug in delayed ref implementation
>> in btrfs-progs, when we have a large enough transaction, delayed ref may
>> failed to find certain tree blocks in extent tree and cause transaction
>> abort.
>>
> 
> Wouldn't it make more sense to actually debug that hidden bug?

Definitely, but some problem below makes it pretty tricky to pin down.

> Can it be
> reproduced by some synthetic test?

No tests can reproduce yet.

> Arguably, it should be a lot easier
> to debug that in user space with gdb and all that ?

The reporter is using an ext4 over 1TB used to reproduce this.
Not something we can easily reproduce.

But with that debug patch, we should have some clue soon.

Thanks,
Qu

> 
>> This workaround will workaround it by committing transaction at a much
>> lower threshold.
>>
>> The old 4096 means 4096 new tree blocks, when using default (16K)
>> nodesize, it's 64M, which can contain over 12k inlined data extent or
>> csum for around 60G, or over 800K file extents.
>>
>> The new threshold will limit the size of new tree blocks to 2M, aligning
>> with the chunk preallocator threshold, and reducing the possibility to
>> hit that delayed ref bug.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  convert/source-ext2.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/convert/source-ext2.c b/convert/source-ext2.c
>> index a136e5652898..63cf71fe10d5 100644
>> --- a/convert/source-ext2.c
>> +++ b/convert/source-ext2.c
>> @@ -829,7 +829,18 @@ static int ext2_copy_inodes(struct btrfs_convert_context *cctx,
>>  		pthread_mutex_unlock(&p->mutex);
>>  		if (ret)
>>  			return ret;
>> -		if (trans->blocks_used >= 4096) {
>> +		/*
>> +		 * blocks_used is the number of new tree blocks allocated in
>> +		 * current transaction.
>> +		 * Use a small amount of it to workaround a bug where delayed
>> +		 * ref may fail to locate tree blocks in extent tree.
>> +		 *
>> +		 * 2M is the threshold to kick chunk preallocator into work,
>> +		 * For default (16K) nodesize it will be 128 tree blocks,
>> +		 * large enough to contain over 300 inlined files or
>> +		 * around 26k file extents. Which should be good enough.
>> +		 */
>> +		if (trans->blocks_used >= SZ_2M / root->fs_info->nodesize) {
>>  			ret = btrfs_commit_transaction(trans, root);
>>  			BUG_ON(ret);
>>  			trans = btrfs_start_transaction(root, 1);
>>
