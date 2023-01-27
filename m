Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E64867F28A
	for <lists+linux-btrfs@lfdr.de>; Sat, 28 Jan 2023 00:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjA0X7T (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 27 Jan 2023 18:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjA0X7S (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 27 Jan 2023 18:59:18 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F03FA24D
        for <linux-btrfs@vger.kernel.org>; Fri, 27 Jan 2023 15:59:16 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MY68T-1p9eNv0Zav-00YUDh; Sat, 28
 Jan 2023 00:59:10 +0100
Message-ID: <d423a454-c44b-05bf-1e51-d944fac3cd7a@gmx.com>
Date:   Sat, 28 Jan 2023 07:59:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] btrfs: handle missing chunk mapping more gracefully
To:     Boris Burkov <boris@bur.io>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <7ff90508841683ca3aaeb5c84e27d7d823218146.1670389796.git.wqu@suse.com>
 <Y9QvpElwgi5+bjCv@zen>
Content-Language: en-US
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Y9QvpElwgi5+bjCv@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:gaITy4RycRjJGa1GmpI9jGI80IvTeohcnKQf3q5grW7TiugIBe+
 PQM4TFQkG0fbvmXmQHL8WPtQyADtd4l8ImyqEjBdDlHm3Et9wpQVDUNHm2QAF8eALXuObkD
 wnHN2HbTUxoqNuNkGzCcmdHNL0pfu3QLniLnxvUf0pr7ONCqeSHFL+6Fn319mWhyNk2dq37
 3zlYWwnSbvprW7of+DQHw==
UI-OutboundReport: notjunk:1;M01:P0:qRnzBHZfsuI=;zeHB78baxUEAPlxPJZVCa1/fWap
 jujdEUOddn1dpuSgqeuZhQ1tl2cT83ahGm9DX1tnw+gjF4dgASeUmZsxX9HnorSwvmJCtV9wn
 ZnXmWsEVTFSmCCaoRU32BrGi0uZOox/hjUFEpkDyaUlZ/AUrLGVNRtlcvhZTY8WzOSOdSCCsD
 mWOpNWYmiiBd0RdisB0dpFaGLzWwlhu6Pf2nzTHINbFXpusN8OUD9Z2cpqLSWqZwokOQm/w4v
 MkwTmlr2ZkBepQvG951lcet9tx3ijaCc5sTjc6pMvyq/H6jH3ILEq5WhIpgA5AzzngEEXzeat
 8D4RyA9U7dN95j/TVv5HkUjTIJ07ejIK2k4J1ZuvgUSACcpO6oMHYDockszAlh4rEKCdS7CN5
 G9vxc6aYs6SUAQHzj+bW9RWVkXwSeTZxdO4bGtJl9dAUGY+yKzCtLV9TsyVCtYa7xypVrU/QU
 DYGdDHQroNhlsCBMpghmjGd5Oez/o4QZomHKw4PUuOpYRFK3q0F5NCXwzfdHMJTT/jZZp9mGL
 RAxz/hZNloVrz7UHkilSbp9bqnZNA5KjQ2IxZZ8D5Ui5s5LL7M+laKIPAIjS+vc03wArhj3FG
 U27ig+USwM0657l2pwXJcABKDln185hGCIUnmMbF8XXulMet6tZSxagq7I/UEhqMoIG96Zq+p
 l2GyCtcx/2iK5WtusfddmTWZ1JInDQz0Wa44xu+1bX0zlsBN2fOzLRk40U/GRU4/6ijP09MSt
 jZBadhzjUTtiAQMIWh1uMUoN3SB9xTDFzzn5msJHHXr7SVm3TLG/Qhi/5tUjoVCF9XlBJPO1L
 G6+0nR+8i+57Z6i2A6Przj1fXx0zNaeKa1jA8rNCd+AWVLx3fBzpx2lNcDNrQjo+Cwofs92W7
 htvjnfsbYxAt56y2Vc4lrS97DGvuAmGQvJ4papQZV4JgBpQriwGIoKC5Ad+jo9mTE4sVDrJdS
 2Cgiq7d/Mycsqsi8zKzbkRdVhIo=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/1/28 04:10, Boris Burkov wrote:
> On Wed, Dec 07, 2022 at 01:09:59PM +0800, Qu Wenruo wrote:
>> [BUG]
>> During my scrub rework, I did a stupid thing like this:
>>
>>          bio->bi_iter.bi_sector = stripe->logical;
>>          btrfs_submit_bio(fs_info, bio, stripe->mirror_num);
>>
>> Above bi_sector assignment is using logical address directly, which
>> lacks ">> SECTOR_SHIFT".
>>
>> This results a read on a range which has no chunk mapping.
>>
>> This results the following crash:
>>
>>   BTRFS critical (device dm-1): unable to find logical 11274289152 length 65536
>>   assertion failed: !IS_ERR(em), in fs/btrfs/volumes.c:6387
>>   ------------[ cut here ]------------
>>
>> Sure this is all my fault, but this shows a possible problem in real
>> world, that some bitflip in file extents/tree block can point to
>> unmapped ranges, and trigger above ASSERT().
>>
>> [PROBLEMS]
>> In above call chain, there are 2 locations not properly handling the
>> errors:
>>
>> - __btrfs_map_block()
>>    If btrfs_get_chunk_map() returned error, we just trigger an ASSERT().
>>
>> - btrfs_submit_bio()
>>    If the returned mapped length is smaller than expected, we just BUG().
>>
>> [FIX]
>> This patch will fix the problems by:
>>
>> - Add extra WARN_ON() if btrfs_get_chunk_map() failed
>>    I know syzbot will complain, but it's better noisy for fstests.
>>
>> - Replace the ASSERT()
>>    By returning the error.
>>
>> - Handle the error when mapped length is smaller than expected length
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Looks good to me, you can add
> Reviewed-by: Boris Burkov <boris@bur.io>
> 
>> ---
>>   fs/btrfs/bio.c     | 6 +++++-
>>   fs/btrfs/volumes.c | 5 ++++-
>>   2 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
>> index b8fb7ef6b520..8f7b56a0290f 100644
>> --- a/fs/btrfs/bio.c
>> +++ b/fs/btrfs/bio.c
>> @@ -246,7 +246,11 @@ void btrfs_submit_bio(struct btrfs_fs_info *fs_info, struct bio *bio, int mirror
>>   		btrfs_crit(fs_info,
>>   			   "mapping failed logical %llu bio len %llu len %llu",
>>   			   logical, length, map_length);
> 
> nit: for these WARN_ON(1)s, how about changing them from
> if (cond) {
>          btrfs_crit(<msg>);
>          WARN_ON(1);
>          <return error>;
> }
> 
> to
> 
> if (WARN_ON(<cond>)) {
>          btrfs_crit(<msg>);
> 	<return err>
> }

In fact, the behavior is discouraged by David IIRC.

The problem is, one has to rely on the fact WARN_ON() has a return 
value, which is not straightforward by a first glance.

Thanks,
Qu
> 
>> -		BUG();
>> +		WARN_ON(1);
>> +		ret = -EINVAL;
>> +		btrfs_bio_counter_dec(fs_info);
>> +		btrfs_bio_end_io(btrfs_bio(bio), errno_to_blk_status(ret));
>> +		return;
>>   	}
>>   
>>   	if (!bioc) {
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index aa25fa335d3e..f69475fb1bc1 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -3012,6 +3012,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
>>   	if (!em) {
>>   		btrfs_crit(fs_info, "unable to find logical %llu length %llu",
>>   			   logical, length);
>> +		WARN_ON(1);
>>   		return ERR_PTR(-EINVAL);
>>   	}
>>   
>> @@ -3020,6 +3021,7 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
>>   			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
>>   			   logical, length, em->start, em->start + em->len);
>>   		free_extent_map(em);
>> +		WARN_ON(1);
>>   		return ERR_PTR(-EINVAL);
>>   	}
>>   
>> @@ -6384,7 +6386,8 @@ int __btrfs_map_block(struct btrfs_fs_info *fs_info, enum btrfs_map_op op,
>>   	ASSERT(op != BTRFS_MAP_DISCARD);
>>   
>>   	em = btrfs_get_chunk_map(fs_info, logical, *length);
>> -	ASSERT(!IS_ERR(em));
>> +	if (IS_ERR(em))
>> +		return PTR_ERR(em);
>>   
>>   	ret = btrfs_get_io_geometry(fs_info, em, op, logical, &geom);
>>   	if (ret < 0)
>> -- 
>> 2.38.1
