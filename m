Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E07C5B5840
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Sep 2022 12:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiILK0V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Sep 2022 06:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbiILK0T (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Sep 2022 06:26:19 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34DA1AF1C
        for <linux-btrfs@vger.kernel.org>; Mon, 12 Sep 2022 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662978367;
        bh=wmjk2G6LHkGX4UQ2NRZNFCGzga62AA+/no5x7kdMQgw=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=YLvPZqvE45jGoY/f91iW2s/dT42P6aiStSaU5rGefyz+oLog2Uggsp8WekSLaSUcl
         eBc787ALMkFSLJmnNhxylfvCIqPrw8oo7l/bvkdk3QH1mXXiyiyYJDhqNM7FoB17fs
         0VJ4aoTM1C8HZdGuPft8PiN9rDRiG/aif8o/Wzfw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M72sJ-1oPAyv0Gn1-008ZLq; Mon, 12
 Sep 2022 12:26:06 +0200
Message-ID: <0a2ffcd7-148b-e64b-5c9c-dc901c968e10@gmx.com>
Date:   Mon, 12 Sep 2022 18:26:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <d1da73f6ed291d53d4cc7dcab142ebfb0541f06e.1662730491.git.josef@toxicpanda.com>
 <20220912095907.GA269395@falcondesktop>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH] btrfs: introduce BTRFS_RESERVE_FLUSH_EMERGENCY
In-Reply-To: <20220912095907.GA269395@falcondesktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2YZq6P58ZdCwx50JPAa31QS5q3g7Xq8ysa1ElZVqs2YAc/PdtPW
 bZ9+7Fqzl3FyiuCEUlnWnB9UMaR4E/7wAyyWoYByB8ik+Ed8cf+e62aNv8gS++lzAe2/RiF
 +vce7HU/ZAsQJaZSHZ5Cuc6AlE2fcWVYMavEwgsHkycgeUhjnfHAFGjgtFlN0WquEsrCGYR
 S46nuwwRPH86TTOxSwb5A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PNkYo83q/EQ=:qyCapucrFW6suv2Tu3oM1i
 6Gp08Hk0S0Cd6ddDZxUCovv9JTRwN8ORCY2ARd4IuUgM+3nJWgI7k5Re9gF3zor/rUVhchBz9
 QklyYOiLDSxFCnEBralR+skKPj4zl1d/KOBJ3SWc/5HN4IqupCfld5XW54lOEXecWOrJCsVd4
 k+PzstFfFTgxMT2QsjkA1T/hZ574+afGpyjn+GKFBpKGpYkRj5NUnfyIPX5qEaa9tCp47LMeu
 ikiTkoCMUXrAMBPvt3GuKKjFabI/iVg5UiTcndZWqrizgL2ZHMtAOOjMHRrVy0oKYHbr1QjIi
 oN7E2bQk/NizbCLw7OrInjaSuiu6JkeYf6ZtVZ/p6fjrrBWIGkTUmyN6lucS5OY6+EEdiK+wU
 3ik1DOp13ypUV7k7dO7t23bs5huiJijhQ78QM5uIs2CxzvoeueNK2kTrfM7XtusdNCqHLkZn0
 TF23g+W40NuO9HiIBbdFkmcgcSyz6pqm3JCB2VKnp9mY5z88woaZKPYPGF15j5jB/ayP+89h8
 JKsY5yQg2LVSE3u3tK2UimgW3oGf5jJOZeZKM9x+xxwhiLShk0dpbouSZ/Sj9RlMczm72Ow33
 56DvRzmE3e7Y52FM7Vm572dzCpkyXygR/5sZU+0Nv91Mg+3rRxqPIumEWSMxksx9MqAFMB+G0
 O/PZYXgXhq4G0fq0FkRETgrwu/nFF6PCk2hEGx6U0OthQkC3uQotE0gjHBanS/Nb3HVafFrNU
 IqOybjklDD72CNk+g3HXkppXCfbyQmAR8EpfZ9heBA2qFh8WNyf5glC27xmCuR7n6CKH9rp8r
 8z3eFrWyJAXWgwCyE4wtwe07918NfpGCCrzz3EUkHOXV2QHmrXLtHG9FfBWqk+HB0LTep5vJb
 d8OIxjFzaliWBadg3sbo8/qSI8IT5Dh+YG5dl611Bg6jzLy6encRrG6PWPmlCpByFnoNkSlCR
 E27j8o7UPc74CYYlDfH7XBeI/kJbibERmNLWAN6bbFzeZTpzlBl2Fs0Bd1eOWhU23keaMbLcx
 zupLlj3iaVqGX6Y28H2dP1iowx+OZLjI/6tB8Ni/yov36BOzIB8LGaGbgt0gVkkAqQ5Bc4FQS
 IHxXIpfEdIpzSJzIzOxDFy/Lqr7Acpu9dVm2BJqX+GHksL4Y2FXr9Lu6s5IxeAdPzA6SQBjDB
 auO8kazD+JvHfVE+tKx5GqPkMX
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/9/12 17:59, Filipe Manana wrote:
> On Fri, Sep 09, 2022 at 09:35:01AM -0400, Josef Bacik wrote:
>> Inside of FB, as well as some user reports, we've had a consistent
>> problem of occasional ENOSPC transaction aborts.  Inside FB we were
>> seeing ~100-200 ENOSPC aborts per day in the fleet, which is a really
>> low occurrence rate given the size of our fleet, but it's not nothing.
>>
>> There are two causes of this particular problem.
>>
>> First is delayed allocation.  The reservation system for delalloc
>> assumes that contiguous dirty ranges will result in 1 file extent item.
>> However if there is memory pressure that results in fragmented writeout=
,
>> or there is fragmentation in the block groups, this won't necessarily b=
e
>> true.  Consider the case where we do a single 256MiB write to a file an=
d
>> then close it.  We will have 1 reservation for the inode update, the
>> reservations for the checksum updates, and 1 reservation for the file
>> extent item.  At some point later we decide to write this entire range
>> out, but we're so fragmented that we break this into 100 different file
>> extents.  Since we've already closed the file and are no longer writing
>> to it there's nothing to trigger a refill of the delalloc block rsv to
>> satisfy the 99 new file extent reservations we need.  At this point we
>> exhaust our delalloc reservation, and we begin to steal from the global
>> reserve.  If you have enough of these cases going in parallel you can
>> easily exhaust the global reserve, get an ENOSPC at
>> btrfs_alloc_tree_block() time, and then abort the transaction.
>
> There's also another problem I pointed out in the past regarding delallo=
c
> reservations. The thing is that we assume for each ordered extent, the n=
ew
> file extent item will require changing only 1 leaf in the subvolume tree=
.
>
> If our new extent has a size of 128M and currently for that range we
> have 32768 extents each with a size of 4K, then we need to touch 157
> leaves in order to drop those file extent items before inserting the new
> one at ordered extent completion. And our reservation that happened at
> buffered write time only accounted for 1 leaf/path for file extent items
> (plus 1 for the inode item). This is assuming the default leaf size of 1=
6K,
> where we can have at most 208 file extent items per leaf.
>
> If we have just a single ordered extent triggering this case we probably
> won't reach -ENOSPC and a transaction abort, as we end up consuming from
> the global reserve and that may be able to satisfy our space needs.
> However with multiple ordered extents hitting such cases of insufficient
> reserved space, and other tasks doing other things and consuming from th=
e
> global reserve, then the chances of hitting -ENOSPC at btrfs_finish_orde=
red_io()
> become very high, leading to a transaction abort there.

In fact, I'm also considering these problems, and for the highly
fragmented free space case (and other cases like delayed refs generated
delayed refs case), can we let btrfs itself to learn from last (several)
delalloc (delayed refs) runs to generate an overall idea on how
fragmented the free space is.

Then round (down) that value for write/dirty time delalloc reservation?

The same can go to delayed refs reservation too.

If by somehow, the delayed refs are generating more than expected
delayed refs, we increase the pre-reserved space accordingly.



Another less dynamic method (but still the same idea) is to introduce a
doomsday mode.

In that mode, every time we need to reserve space for delalloc, we
consider the extent can only be at most 4K, double the pre-reserve for
delayed refs etc.

But I'm afraid this can only reduce, but not really eliminate the ENOSPC
at critical path.

>
>>
>> The other case is the delayed refs reserve.  The delayed refs reserve
>> updates its size based on outstanding delayed refs and dirty block
>> groups.  However we only refill this block reserve when returning
>> excess reservations and when we call btrfs_start_transaction(root, X).
>> We will reserve 2*X credits at transaction start time, and fill in X
>> into the delayed refs reserve to make sure it stays topped off.
>> Generally this works well, but clearly has downsides.  If we do a
>> particularly delayed ref heavy operation we may never catch up in our
>> reservations.  Additionally running delayed refs generates more delayed
>> refs, and at that point we may be committing the transaction and have n=
o
>> way to trigger a refill of our delayed refs rsv.  Then a similar thing
>> occurs with the delalloc reserve.
>>
>> Generally speaking we well over-reserve in all of our block rsvs.  If w=
e
>> reserve 1 credit we're usually reserving around 264k of space, but we'l=
l
>> often not use any of that reservation, or use a few blocks of that
>> reservation.  We can be reasonably sure that as long as you were able t=
o
>> reserve space up front for your operation you'll be able to find space
>> on disk for that reservation.
>
> That's another elephant in the room. We assume that if a task reserves
> space, it will be able to allocate that space later.
>
> There are several things that can happen which will result in not being
> able to allocate space we reserved before:
>
> 1) Discard/fitrim - it removes a free space entry, does the discard, and
>     after that it adds back the free space entry. If all the available s=
pace
>     is in such an entry being discarded, the task fails to allocate spac=
e;
>
> 2) fsync - it joins a transaction, doesn't reserve space and starts allo=
cating
>     space for tree blocks, without ever reserving space (because we want=
 it
>     to be fast and for most cases we don't know in advance, or can estim=
ate,
>     how many tree blocks we will need to allocate). So it can steal spac=
e that
>     was reserved by some other task;
>
> 3) Scrub - scrub temporarily turns a block group into RO mode - if all t=
he
>     available space was in that block group, than when the task tries to
>     allocate it will fail because the block group is now RO;

Yes, that's one concern of the existing per-dev scrub.
If we have 10 devices, all single profiles, then we may mark 10 block
groups RO at once, hugely increase the chance of ENOSPC.

>
> 4) During space reservation we only check if free space counters. There
>     may be block groups with plenty of free space but their profile is n=
ot
>     compatible, so when trying to allocate an extent we are forced to al=
locate
>     a new block group with the necessary profile, which will fail if the=
re's
>     not enough unallocated space.
>     This mostly affects degraded mode only (hopefully).

This is still pretty common, for RAID1 usage especially one device is
just slightly (like 10MiB) larger than the other.

The metadata over-reserve still believe we can allocate new metadata bg,
but nope, and hit a ENOSPC at critical path.

IIRC I had some very old patches for the problem, but haven't updated
for a long time.

Thanks,
Qu

>
> I documented these at btrfs_chunk_alloc() sometime ago, but there are a =
few
> more similar cases.
>
>>
>> So introduce a new flushing state, BTRFS_RESERVE_FLUSH_EMERGENCY.  This
>> gets used in the case that we've exhausted our reserve and the global
>> reserve.  It simply forces a reservation if we have enough actual space
>> on disk to make the reservation, which is almost always the case.  This
>> keeps us from hitting ENOSPC aborts in these odd occurrences where we'v=
e
>> not kept up with the delayed work.
>>
>> Fixing this in a complete way is going to be relatively complicated and
>> time consuming.  This patch is what I discussed with Filipe earlier thi=
s
>> year, and what I put into our kernels inside FB.  With this patch we're
>> down to 1-2 ENOSPC aborts per week, which is a significant reduction.
>> This is a decent stop gap until we can work out a more wholistic
>> solution to these two corner cases.
>
> Well, it's a lot more than 2 corner cases :)
>
> The change looks fine to me, it's simple and it should help reduce the
> frequency of several ENOSPC cases. So,
>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
>
> Thanks.
>
>>
>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> ---
>>   fs/btrfs/block-rsv.c  | 12 ++++++++++++
>>   fs/btrfs/ctree.h      | 18 ++++++++++++++++++
>>   fs/btrfs/space-info.c | 27 ++++++++++++++++++++++++++-
>>   3 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/block-rsv.c b/fs/btrfs/block-rsv.c
>> index ec96285357e0..89e3e7d1bff6 100644
>> --- a/fs/btrfs/block-rsv.c
>> +++ b/fs/btrfs/block-rsv.c
>> @@ -552,5 +552,17 @@ struct btrfs_block_rsv *btrfs_use_block_rsv(struct=
 btrfs_trans_handle *trans,
>>   		if (!ret)
>>   			return global_rsv;
>>   	}
>> +
>> +	/*
>> +	 * All hope is lost, but of course our reservations are overly
>> +	 * pessimistic, so instead of possibly having an ENOSPC abort here, t=
ry
>> +	 * one last time to force a reservation if there's enough actual spac=
e
>> +	 * on disk to make the reservation.
>> +	 */
>> +	ret =3D btrfs_reserve_metadata_bytes(fs_info, block_rsv, blocksize,
>> +					   BTRFS_RESERVE_FLUSH_EMERGENCY);
>> +	if (!ret)
>> +		return block_rsv;
>> +
>>   	return ERR_PTR(ret);
>>   }
>> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
>> index 0108585d838d..f221b3cb718d 100644
>> --- a/fs/btrfs/ctree.h
>> +++ b/fs/btrfs/ctree.h
>> @@ -2986,6 +2986,24 @@ enum btrfs_reserve_flush_enum {
>>   	 * Can be interrupted by a fatal signal.
>>   	 */
>>   	BTRFS_RESERVE_FLUSH_ALL_STEAL,
>> +
>> +	/*
>> +	 * This is for btrfs_use_block_rsv only.  We have exhausted our block
>> +	 * rsv and our global block rsv.  This can happen for things like
>> +	 * delalloc where we are overwriting a lot of extents with a single
>> +	 * extent and didn't reserve enough space.  Alternatively it can happ=
en
>> +	 * with delalloc where we reserve 1 extents worth for a large extent =
but
>> +	 * fragmentation leads to multiple extents being created.  This will
>> +	 * give us the reservation in the case of
>> +	 *
>> +	 * if (num_bytes < (space_info->total_bytes -
>> +	 *		    btrfs_space_info_used(space_info, false))
>> +	 *
>> +	 * Which ignores bytes_may_use.  This is potentially dangerous, but o=
ur
>> +	 * reservation system is generally pessimistic so is able to absorb t=
his
>> +	 * style of mistake.
>> +	 */
>> +	BTRFS_RESERVE_FLUSH_EMERGENCY,
>>   };
>>
>>   enum btrfs_flush_state {
>> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
>> index 2e06b7c422c7..a0abc6dd01c2 100644
>> --- a/fs/btrfs/space-info.c
>> +++ b/fs/btrfs/space-info.c
>> @@ -1583,6 +1583,16 @@ static inline bool can_steal(enum btrfs_reserve_=
flush_enum flush)
>>   		flush =3D=3D BTRFS_RESERVE_FLUSH_EVICT);
>>   }
>>
>> +/*
>> + * NO_FLUSH and FLUSH_EMERGENCY don't want to create a ticket, they ju=
st want to
>> + * fail as quickly as possible.
>> + */
>> +static inline bool can_ticket(enum btrfs_reserve_flush_enum flush)
>> +{
>> +	return (flush !=3D BTRFS_RESERVE_NO_FLUSH &&
>> +		flush !=3D BTRFS_RESERVE_FLUSH_EMERGENCY);
>> +}
>> +
>>   /**
>>    * Try to reserve bytes from the block_rsv's space
>>    *
>> @@ -1644,6 +1654,21 @@ static int __reserve_bytes(struct btrfs_fs_info =
*fs_info,
>>   		ret =3D 0;
>>   	}
>>
>> +	/*
>> +	 * Things are dire, we need to make a reservation so we don't abort. =
 We
>> +	 * will let this reservation go through as long as we have actual spa=
ce
>> +	 * left to allocate for the block.
>> +	 */
>> +	if (ret && unlikely(flush =3D=3D BTRFS_RESERVE_FLUSH_EMERGENCY)) {
>
> Does the unlikely() really makes any difference in this context?
>
>> +		used =3D btrfs_space_info_used(space_info, false);
>> +		if (used + orig_bytes <=3D
>> +		    writable_total_bytes(fs_info, space_info)) {
>> +			btrfs_space_info_update_bytes_may_use(fs_info, space_info,
>> +							      orig_bytes);
>> +			ret =3D 0;
>> +		}
>> +	}
>> +
>>   	/*
>>   	 * If we couldn't make a reservation then setup our reservation tick=
et
>>   	 * and kick the async worker if it's not already running.
>> @@ -1651,7 +1676,7 @@ static int __reserve_bytes(struct btrfs_fs_info *=
fs_info,
>>   	 * If we are a priority flusher then we just need to add our ticket =
to
>>   	 * the list and we will do our own flushing further down.
>>   	 */
>> -	if (ret && flush !=3D BTRFS_RESERVE_NO_FLUSH) {
>> +	if (ret && can_ticket(flush)) {
>>   		ticket.bytes =3D orig_bytes;
>>   		ticket.error =3D 0;
>>   		space_info->reclaim_size +=3D ticket.bytes;
>> --
>> 2.26.3
>>
