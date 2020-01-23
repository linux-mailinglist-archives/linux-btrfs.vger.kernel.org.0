Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3D471463F2
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Jan 2020 09:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgAWIyY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Jan 2020 03:54:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:45188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgAWIyY (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Jan 2020 03:54:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 26E78AD7B;
        Thu, 23 Jan 2020 08:54:21 +0000 (UTC)
Subject: Re: [PATCH 11/11] btrfs: Use btrfs_transaction::pinned_extents
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <20200120140918.15647-1-nborisov@suse.com>
 <20200120140918.15647-12-nborisov@suse.com>
 <b98bb8f2-2f3f-748b-793a-b9772f9f3569@toxicpanda.com>
From:   Nikolay Borisov <nborisov@suse.com>
Autocrypt: addr=nborisov@suse.com; prefer-encrypt=mutual; keydata=
 xsFNBFiKBz4BEADNHZmqwhuN6EAzXj9SpPpH/nSSP8YgfwoOqwrP+JR4pIqRK0AWWeWCSwmZ
 T7g+RbfPFlmQp+EwFWOtABXlKC54zgSf+uulGwx5JAUFVUIRBmnHOYi/lUiE0yhpnb1KCA7f
 u/W+DkwGerXqhhe9TvQoGwgCKNfzFPZoM+gZrm+kWv03QLUCr210n4cwaCPJ0Nr9Z3c582xc
 bCUVbsjt7BN0CFa2BByulrx5xD9sDAYIqfLCcZetAqsTRGxM7LD0kh5WlKzOeAXj5r8DOrU2
 GdZS33uKZI/kZJZVytSmZpswDsKhnGzRN1BANGP8sC+WD4eRXajOmNh2HL4P+meO1TlM3GLl
 EQd2shHFY0qjEo7wxKZI1RyZZ5AgJnSmehrPCyuIyVY210CbMaIKHUIsTqRgY5GaNME24w7h
 TyyVCy2qAM8fLJ4Vw5bycM/u5xfWm7gyTb9V1TkZ3o1MTrEsrcqFiRrBY94Rs0oQkZvunqia
 c+NprYSaOG1Cta14o94eMH271Kka/reEwSZkC7T+o9hZ4zi2CcLcY0DXj0qdId7vUKSJjEep
 c++s8ncFekh1MPhkOgNj8pk17OAESanmDwksmzh1j12lgA5lTFPrJeRNu6/isC2zyZhTwMWs
 k3LkcTa8ZXxh0RfWAqgx/ogKPk4ZxOXQEZetkEyTFghbRH2BIwARAQABzSJOaWtvbGF5IEJv
 cmlzb3YgPG5ib3Jpc292QHN1c2UuZGU+wsF4BBMBAgAiBQJYijkSAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRBxvoJG5T8oV/B6D/9a8EcRPdHg8uLEPywuJR8URwXzkofT5bZE
 IfGF0Z+Lt2ADe+nLOXrwKsamhweUFAvwEUxxnndovRLPOpWerTOAl47lxad08080jXnGfYFS
 Dc+ew7C3SFI4tFFHln8Y22Q9075saZ2yQS1ywJy+TFPADIprAZXnPbbbNbGtJLoq0LTiESnD
 w/SUC6sfikYwGRS94Dc9qO4nWyEvBK3Ql8NkoY0Sjky3B0vL572Gq0ytILDDGYuZVo4alUs8
 LeXS5ukoZIw1QYXVstDJQnYjFxYgoQ5uGVi4t7FsFM/6ykYDzbIPNOx49Rbh9W4uKsLVhTzG
 BDTzdvX4ARl9La2kCQIjjWRg+XGuBM5rxT/NaTS78PXjhqWNYlGc5OhO0l8e5DIS2tXwYMDY
 LuHYNkkpMFksBslldvNttSNei7xr5VwjVqW4vASk2Aak5AleXZS+xIq2FADPS/XSgIaepyTV
 tkfnyreep1pk09cjfXY4A7qpEFwazCRZg9LLvYVc2M2eFQHDMtXsH59nOMstXx2OtNMcx5p8
 0a5FHXE/HoXz3p9bD0uIUq6p04VYOHsMasHqHPbsMAq9V2OCytJQPWwe46bBjYZCOwG0+x58
 fBFreP/NiJNeTQPOa6FoxLOLXMuVtpbcXIqKQDoEte9aMpoj9L24f60G4q+pL/54ql2VRscK
 d87BTQRYigc+ARAAyJSq9EFk28++SLfg791xOh28tLI6Yr8wwEOvM3wKeTfTZd+caVb9gBBy
 wxYhIopKlK1zq2YP7ZjTP1aPJGoWvcQZ8fVFdK/1nW+Z8/NTjaOx1mfrrtTGtFxVBdSCgqBB
 jHTnlDYV1R5plJqK+ggEP1a0mr/rpQ9dFGvgf/5jkVpRnH6BY0aYFPprRL8ZCcdv2DeeicOO
 YMobD5g7g/poQzHLLeT0+y1qiLIFefNABLN06Lf0GBZC5l8hCM3Rpb4ObyQ4B9PmL/KTn2FV
 Xq/c0scGMdXD2QeWLePC+yLMhf1fZby1vVJ59pXGq+o7XXfYA7xX0JsTUNxVPx/MgK8aLjYW
 hX+TRA4bCr4uYt/S3ThDRywSX6Hr1lyp4FJBwgyb8iv42it8KvoeOsHqVbuCIGRCXqGGiaeX
 Wa0M/oxN1vJjMSIEVzBAPi16tztL/wQtFHJtZAdCnuzFAz8ue6GzvsyBj97pzkBVacwp3/Mw
 qbiu7sDz7yB0d7J2tFBJYNpVt/Lce6nQhrvon0VqiWeMHxgtQ4k92Eja9u80JDaKnHDdjdwq
 FUikZirB28UiLPQV6PvCckgIiukmz/5ctAfKpyYRGfez+JbAGl6iCvHYt/wAZ7Oqe/3Cirs5
 KhaXBcMmJR1qo8QH8eYZ+qhFE3bSPH446+5oEw8A9v5oonKV7zMAEQEAAcLBXwQYAQIACQUC
 WIoHPgIbDAAKCRBxvoJG5T8oV1pyD/4zdXdOL0lhkSIjJWGqz7Idvo0wjVHSSQCbOwZDWNTN
 JBTP0BUxHpPu/Z8gRNNP9/k6i63T4eL1xjy4umTwJaej1X15H8Hsh+zakADyWHadbjcUXCkg
 OJK4NsfqhMuaIYIHbToi9K5pAKnV953xTrK6oYVyd/Rmkmb+wgsbYQJ0Ur1Ficwhp6qU1CaJ
 mJwFjaWaVgUERoxcejL4ruds66LM9Z1Qqgoer62ZneID6ovmzpCWbi2sfbz98+kW46aA/w8r
 7sulgs1KXWhBSv5aWqKU8C4twKjlV2XsztUUsyrjHFj91j31pnHRklBgXHTD/pSRsN0UvM26
 lPs0g3ryVlG5wiZ9+JbI3sKMfbdfdOeLxtL25ujs443rw1s/PVghphoeadVAKMPINeRCgoJH
 zZV/2Z/myWPRWWl/79amy/9MfxffZqO9rfugRBORY0ywPHLDdo9Kmzoxoxp9w3uTrTLZaT9M
 KIuxEcV8wcVjr+Wr9zRl06waOCkgrQbTPp631hToxo+4rA1jiQF2M80HAet65ytBVR2pFGZF
 zGYYLqiG+mpUZ+FPjxk9kpkRYz61mTLSY7tuFljExfJWMGfgSg1OxfLV631jV1TcdUnx+h3l
 Sqs2vMhAVt14zT8mpIuu2VNxcontxgVr1kzYA/tQg32fVRbGr449j1gw57BV9i0vww==
Message-ID: <3396ff95-dbc0-dd91-8c91-4509933e3a30@suse.com>
Date:   Thu, 23 Jan 2020 10:54:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b98bb8f2-2f3f-748b-793a-b9772f9f3569@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22.01.20 г. 22:21 ч., Josef Bacik wrote:
> On 1/20/20 9:09 AM, Nikolay Borisov wrote:
>> This commit flips the switch to start tracking/processing pinned
>> extents on a per-transaction basis. It mostly replaces all references
>> from btrfs_fs_info::(pinned_extents|freed_extents[]) to
>> btrfs_transaction::pinned_extents. Two notable modifications that
>> warrant explicit mention are changing clean_pinned_extents to get a
>> reference to the previously running transaction. The other one is
>> removal of call to btrfs_destroy_pinned_extent since transactions are
>> going to be cleaned in btrfs_cleanup_one_transaction.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> 
> I'd prefer if the excluded extent changes were separate from the pinned
> extent changes.
> 
>> ---
>>   fs/btrfs/block-group.c       | 38 ++++++++++++++++++++++++------------
>>   fs/btrfs/ctree.h             |  4 ++--
>>   fs/btrfs/disk-io.c           | 30 +++++-----------------------
>>   fs/btrfs/extent-io-tree.h    |  3 +--
>>   fs/btrfs/extent-tree.c       | 31 ++++++++---------------------
>>   fs/btrfs/free-space-cache.c  |  2 +-
>>   fs/btrfs/tests/btrfs-tests.c |  7 ++-----
>>   fs/btrfs/transaction.c       |  1 +
>>   fs/btrfs/transaction.h       |  1 +
>>   include/trace/events/btrfs.h |  3 +--
>>   10 files changed, 47 insertions(+), 73 deletions(-)
>>
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
>> index 48bb9e08f2e8..562dfb7dc77f 100644
>> --- a/fs/btrfs/block-group.c
>> +++ b/fs/btrfs/block-group.c
>> @@ -460,7 +460,7 @@ u64 add_new_free_space(struct btrfs_block_group
>> *block_group, u64 start, u64 end
>>       int ret;
>>         while (start < end) {
>> -        ret = find_first_extent_bit(info->pinned_extents, start,
>> +        ret = find_first_extent_bit(&info->excluded_extents, start,
>>                           &extent_start, &extent_end,
>>                           EXTENT_DIRTY | EXTENT_UPTODATE,
>>                           NULL);
> 
> We're no longer doing EXTENT_DIRTY in excluded_extents, so we don't need
> this part.
> 
>> @@ -1233,32 +1233,44 @@ static int inc_block_group_ro(struct
>> btrfs_block_group *cache, int force)
>>       return ret;
>>   }
>>   -static bool clean_pinned_extents(struct btrfs_block_group *bg)
>> +static bool clean_pinned_extents(struct btrfs_trans_handle *trans,
>> +                 struct btrfs_block_group *bg)
>>   {
>>       struct btrfs_fs_info *fs_info = bg->fs_info;
>> +    struct btrfs_transaction *prev_trans = NULL;
>>       u64 start = bg->start;
>>       u64 end = start + bg->length - 1;
>>       int ret;
>>   +    spin_lock(&fs_info->trans_lock);
>> +    if (trans->transaction->list.prev != &fs_info->trans_list) {
>> +        prev_trans = list_entry(trans->transaction->list.prev,
>> +                    struct btrfs_transaction, list);
>> +        refcount_inc(&prev_trans->use_count);
>> +    }
>> +    spin_unlock(&fs_info->trans_lock);
>> +
>>       /*
>>        * Hold the unused_bg_unpin_mutex lock to avoid racing with
>>        * btrfs_finish_extent_commit(). If we are at transaction N,
>>        * another task might be running finish_extent_commit() for the
>>        * previous transaction N - 1, and have seen a range belonging
>> -     * to the block group in freed_extents[] before we were able to
>> -     * clear the whole block group range from freed_extents[]. This
>> +     * to the block group in pinned_extents before we were able to
>> +     * clear the whole block group range from pinned_extents. This
>>        * means that task can lookup for the block group after we
>> -     * unpinned it from freed_extents[] and removed it, leading to
>> +     * unpinned it from pinned_extents[] and removed it, leading to
>>        * a BUG_ON() at unpin_extent_range().
>>        */
>>       mutex_lock(&fs_info->unused_bg_unpin_mutex);
>> -    ret = clear_extent_bits(&fs_info->freed_extents[0], start, end,
>> -              EXTENT_DIRTY);
>> -    if (ret)
>> -        goto failure;
>> +    if (prev_trans) {
>> +        ret = clear_extent_bits(&prev_trans->pinned_extents, start, end,
>> +                    EXTENT_DIRTY);
>> +        if (ret)
>> +            goto failure;
>> +    }
> 
> You are leaking a ref to prev_trans here.
> 
> <snip>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 9209c7b0997c..3cb786463eb2 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2021,10 +2021,8 @@ void btrfs_free_fs_roots(struct btrfs_fs_info
>> *fs_info)
>>               btrfs_drop_and_free_fs_root(fs_info, gang[i]);
>>       }
>>   -    if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state)) {
>> +    if (test_bit(BTRFS_FS_STATE_ERROR, &fs_info->fs_state))
>>           btrfs_free_log_root_tree(NULL, fs_info);
>> -        btrfs_destroy_pinned_extent(fs_info, fs_info->pinned_extents);
>> -    }
> 
> What about the excluded extents?  We may never cache the block group
> with one of the super mirrors in it, and thus we would leak the excluded
> extent for it.  Thanks,

btrfs_destroy_pinned_extent didn't touch EXTENT_UPDATE (excluded
extents) before so my removing this call doesn't change that. E.g. if
there is a bug here where excluded extents are not cleaned up then it's
not due to my code.

On the other hand I don't quite understand your concern w.r.t pinned
extents. Can you elaborate?

> 
> Josef
