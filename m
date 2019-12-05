Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653A6113CD5
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Dec 2019 09:09:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLEIJr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Dec 2019 03:09:47 -0500
Received: from mout.gmx.net ([212.227.15.19]:54257 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726096AbfLEIJr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 5 Dec 2019 03:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575533385;
        bh=33TTm3tj9Gb4to4kriRo/hUGGmo7ZxXknRAf99X9uf8=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=McoN6s8i13mnWU3n7Rw3mVg2Omhnncoy3gBZKFOn/uQ7CDyQGOcgWpXN+xYtApvTe
         i7B/yqcPQBpp1iLq7cISuebpMA2TRMYXquHZili84p9YCqpxvNvU+VmhJnEpfQ/7CL
         3iPU3dvhPKSDrHDoFNAThZO7DeC4DRWVHdQi5O/o=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.169] ([34.92.246.95]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1fis-1harxI2INU-011wBB; Thu, 05
 Dec 2019 09:09:45 +0100
Subject: Re: [PATCH 09/10] btrfs-progs: refrom block groups caches structure
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, damenly.su@gmail.com,
        linux-btrfs@vger.kernel.org
References: <20191205042921.25316-1-Damenly_Su@gmx.com>
 <20191205042921.25316-10-Damenly_Su@gmx.com>
 <ea48239e-3bba-beb7-8960-e847f70b4a6f@gmx.com>
From:   Su Yue <Damenly_Su@gmx.com>
Message-ID: <c60d03ec-6131-9271-6dd4-66b0b3729b79@gmx.com>
Date:   Thu, 5 Dec 2019 16:09:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:71.0)
 Gecko/20100101 Thunderbird/71.0
MIME-Version: 1.0
In-Reply-To: <ea48239e-3bba-beb7-8960-e847f70b4a6f@gmx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lqg65GoJfZSlTPgH7A3P22ZOOQ74WtKLYmrr65A96IbMXgu75ff
 07fM+9E27BPe4Z3OOBhnF8raOUMHxqSCq3A5RtIcXav/5v4Pqyf/xDAmH72Emf5KA8IhuKX
 UujHg89ks0Un01X77rWR8g3XPGYiRyTdVxmc3OIHkWEcMwNSeX8CejynRdQu1iXCtYm4vpl
 PO14h43vSvsV1vrqbaa2A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:z4oIGGZ+PXA=:hYDTYWWh+2piyMHdyH2QUD
 PeRF7R+QzHo0l5YgKXUtwZs+akB7VMKaVfguCtJyRhtS89H1h4Zajah94/cXy/RSyc3IjtfME
 b3PCHFxA0CLY0oUY82WqRs5bOL3UL7GRvStFHdsTEpVH1rpShA1bDJ6KP3mvusc0Y2EvCbq0N
 l4sOVf8VSCMIWBl7OdJc69zy9LjzkAz0m17Bl86GjRhdPh3ESuQ2+dHpAjs9bOMegqUF+ucly
 Bn7JsEG3F3NT+KSacuHC9AClVAsvadwzoQEU6h3OowoO28sf3PQYN3w4RicbJSn8aJHIluHpv
 LZLND+7gWuY8u3lkv3CYH7lTCUxY3XR9H4PKBEMfc0M4nxc70JHIG4e0CG7LnjUjyfZkW6qFB
 I9J2/t70LCE9flBA6QqXUrjn9qUizhl6SC9HK+EXhEpDzhCE0zk4p7rkw39Mkkway4Yuso3Mz
 gbsiq6WrVc5HJFAdjLmRLxevtXj9yxn/fSwYA54pMn8/GNgfNOG27s0fcjviqOG1ivS7KOi4e
 C4G5g6SypX5bQ29nkO3R/39BO3qcimbvoZIwNWvIQtHlD1t3u0mkkSA58qGjmkKfYilsQBAvp
 2FiOrKkH966CpXcmpy9HNPTGHEPNN+akq8Vmnmhc33h0FhTyzs0BHpELNUYve/CPeonVgwMLZ
 VGlc/4C1z+9MxczwbgYIwD0CiHkC44+YPeS526rVer2YU5+4TohueNL//xc2qxmGKZtuYwbJm
 0JxpGuJyg447QC9v+V8RWqqoREAea1O/UPwJC8Q3VR4cPx5CH7sVCVpPc14pDT0B0KYba+LW1
 UOEHGOG0sjtgJI2jSNUFsmwvQRjucvcBL+KssOU2IIO4ShoIRDSBK9dMfwf42ysbjVBnKjSre
 6TcYziUSsn1RkyL9gWB2jjtnLbwIVsJ6Mnt6wb74sFCG75dvTdRn9XpOXfCZMSreDMtzEB2f8
 o7aq5STZJov4Yp6EXnv2CmcDaCPNVRkmRXbtYleKTWe20SXt79qPkGjjAnATPwo6gRNS3cxUq
 AeW7vHYJI0WatHkpRbgdoVbV89uXWkn6dVDet3dT4Bhr9XoZDm3ZQ+fftN0jbEYVEm2NpermG
 AHeQMxyfoQn9/oeS1/9k9Rh9zDtgjdyBYfLrSfyQy4HcY0rGCcEkyvHHdtj9rj6CQNohlbkmL
 g67chvDJip0E2hr2wOB2v8dmlWslnCI2ek0JJFsyf8paiCVZSAUf6f/BLsVxi72xi1AxiXfrm
 GeLwwfWzOsFd06v7l1p88c0x/2HBjI1gvQIjC3u9/OMssWwuc8ypqAFjsRxs=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/12/5 3:51 PM, Qu Wenruo wrote:
>
>
> On 2019/12/5 =E4=B8=8B=E5=8D=8812:29, damenly.su@gmail.com wrote:
>> From: Su Yue <Damenly_Su@gmx.com>
>>
>> This commit organises block groups cache in
>> btrfs_fs_info::block_group_cache_tree. And any dirty block groups are
>> linked in transaction_handle::dirty_bgs.
>>
>> To keep coherence of bisect, it does almost replace in place:
>> 1. Replace the old btrfs group lookup functions with new functions
>> introduced in former commits.
>> 2. set_extent_bits(..., BLOCK_GROUP_DIRYT) things are replaced by linki=
ng
>> the block group cache into trans::dirty_bgs. Checking and clearing bits
>> are transformed too.
>> 3. set_extent_bits(..., bit | EXTENT_LOCKED) things are replaced by
>> new the btrfs_add_block_group_cache() which inserts caches into
>> btrfs_fs_info::block_group_cache_tree directly. Other operations are
>> converted to tree operations.
>
> Great cleanup and code unification.
>
> Overall looks good, just small nitpicks inlined below.
>>
>> Signed-off-by: Su Yue <Damenly_Su@gmx.com>
>> ---
>>   cmds/rescue-chunk-recover.c |   4 +-
>>   extent-tree.c               | 211 ++++++-----------------------------=
-
>>   image/main.c                |   5 +-
>>   transaction.c               |   3 +-
>>   4 files changed, 38 insertions(+), 185 deletions(-)
>>
>> diff --git a/cmds/rescue-chunk-recover.c b/cmds/rescue-chunk-recover.c
>> index 461b66c6e13b..a13acc015d11 100644
>
>> @@ -2699,25 +2571,22 @@ int btrfs_free_block_groups(struct btrfs_fs_inf=
o *info)
>>   	struct btrfs_block_group_cache *cache;
>>   	u64 start;
>>   	u64 end;
>> -	u64 ptr;
>>   	int ret;
>>
>> -	while(1) {
>> -		ret =3D find_first_extent_bit(&info->block_group_cache, 0,
>> -					    &start, &end, (unsigned int)-1);
>> -		if (ret)
>> +	while (rb_first(&info->block_group_cache_tree)) {
>> +		cache =3D btrfs_lookup_first_block_group(info, 0);
>> +		if (!cache)
>
> Since we're freeing all block groups, what about
> rbtree_postorder_for_each_entry_safe()?
>
> That would be faster than rb_first() as we don't need to balance the tre=
e.
>
Oh! Thanks a lot. Will use the one.

> Despite that, the patch looks great to me.
> Especially for that -185 part.
>
> Thanks,
> Qu
>
