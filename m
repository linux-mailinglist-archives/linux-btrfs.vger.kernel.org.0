Return-Path: <linux-btrfs+bounces-8250-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A419870CC
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 11:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8D51C250B5
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E051AC437;
	Thu, 26 Sep 2024 09:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="hBk3dC+E"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187782745C
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Sep 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727344513; cv=none; b=Tpv1yYS6J5sU5/4J4f6zsZGpBNvR2dFD00Q3XviOAk6B5AWXmOPO5FfrXTyaexAvbUOL1jUGzDmqpdZZuN6du8DDCLgNkAJxvxBzri/TOwdT0DBqwjRwkSkQ3yxrzC5S9zMo4cNbVMaVHiWhN9DcuFBNG9kX+cnEdndCedcVty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727344513; c=relaxed/simple;
	bh=wmaZDiCbz8+O1Qd5IPgT7nxxqMFaQzf8vEBktUM7Iqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INUVEBdkCCxSyfaY9TgrbKxzL1EI9dFYWlagP98oSDK+SN2jfEeQlLhRRs+jK+HD2IqjcsmFEKrJIo7XCIb+veTAzkufpF8tz8h7SwBdwAtFD8teXrwXqFWF3MRbS00jHyADyzHtu18M33Q9nLFp9tdz5hgj2bXz8d6rG0EVLIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=hBk3dC+E; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727344504; x=1727949304; i=quwenruo.btrfs@gmx.com;
	bh=hYP3fJMEmgXBowuXdXrKUT33vyvNS3eajgk+vIEJ+x8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=hBk3dC+EcxtnXklGbjC7iUMERucAea4C0KBXdKygoXgNglQImjO16axXnqODpLoC
	 GOVwKJj26T3GuIP8x/niYNQ2KU3VTkPF0oY0Anx9noQJjm9ibPkdmd22LSP66lpiD
	 ZSZmQYbZPdqF+3d7p6fCfARLM8qhOsoPeQs7ETXcIvR2Gid0U56rDQLyOdJ5blZdK
	 bDp0uiUcGWfRI2XJzhL/vxGKd1JmXLIIzH5b/kqgKdhOkvHhWxstY2BW0Nsq+bsPI
	 0oVciDHDLPjQobdR6vSSfK9AtQD/RFP+vgDWaV8gIsaWdCyKWBwgolqW0e7RViAwY
	 IDm2EsKJwFJ+F0EQvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdNY8-1sKhVf0aC8-00eT3p; Thu, 26
 Sep 2024 11:55:03 +0200
Message-ID: <9323f10d-dab1-4826-a088-90b1c5bea38c@gmx.com>
Date: Thu, 26 Sep 2024 19:25:00 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs: make the extent map shrinker run
 asynchronously as a work queue job
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
References: <cover.1727174151.git.fdmanana@suse.com>
 <1a3f817fc3c5a6e4267bcd56f2f0518a9d8e0e4e.1727174151.git.fdmanana@suse.com>
 <51c11bdd-cac9-4525-85e3-ce8da69dec1f@gmx.com>
 <CAL3q7H76=i4+s0ntAbM1BL7JNv3A+TjdCprrY8AwoOuUswcNEQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <CAL3q7H76=i4+s0ntAbM1BL7JNv3A+TjdCprrY8AwoOuUswcNEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7wKsP1wd+ZAnjNUp7YwxlPrScRVQuhdv3pLXPTuDpexD1QJCNXK
 rPPtFIQrZv04vXYZCxTHko9K3l9/eu3WNwSq19iZ8/nmwAhhy5R6JC0uGI79gAh4kowpq05
 gsinLoZ6UsrZexfh7I50dAXPmwSmQdIpTgp/WAwNeFkLFiz0XjVYJ1AC4u6t1P6Gth8DzKC
 gXJnxfFsB+ehsoXDXx5WA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:V8riw8TAZj0=;bqBma/HYqa4HDcHNqCg2tr3HEMu
 fEjOnG/L8Ot+iHmfS4XYDB36f+I6BcjsZ6x0pPH8jkdFw3EdVzAdK0etxTSbqZEyxP+xqI5FI
 hUulVwnjBUz3WoIwatwV0ISXuQ8H6ULWIc3el3xT8Ylk+2p4yB1ZfW14dWRlSf00hFxM1nRm0
 rQCfL6Ro/bb5bp4j7vndTN7SC1phBZEiom4g23OdZaFfIpAoHjJNXtja5l4Mn2HlZ9MNN9/Q3
 PAQfoM1A/iNVJODGvzpKHOPacuXbBg8zjWsZEq3VcE6jzwsyOAX8p7mxzkK9iI5FaGS9E5Vud
 2rZsU/h1pR/6wU8okn74PpdNn6OYOucMhlDUgOkDHEIYBtxZQSEo3KC6Do8Y5vCQbaO+9McBY
 MHMR17MPN/kH5KO3CgfZa7Mwrvv0VpI7bD7kLsymK8G373OILHY7Pk2gh/GGT9tp3JjqKRTFn
 F6mXR/TN6aTpjEc68pfr3RWP0RztR2VMU/fKiCBzVPffgaOaXvueWZn8H3OpFS1Nbt4MZ3ijv
 2MZs5Ubwx2mXeOLURDDFmLRe/a8hB1eR+UvTgI1jlx5mDY+94PTJ7yJHWAKXmkX7RrXSUGqUO
 X8W96woUE4tmVcR3PvuZz8F9xieSLJmtmZuA3TWsg4Bn/t7wVDXagxI62ynjHQjDML/6rTbcN
 MJorWmMdPHvjI6Tgf5lXQMlUWxh4hWPxkRJA0NMjuK1DMIZQ+5wqr1hjlgThykgfiX0PecPCi
 0nGSTDbFFu+OnugVg9jXAeK6ldm/Y1i3OCdlBqXQ+/62TPHynnELb97RPl2aBtAZDJrw10sep
 5e7LedVXN3PGrgSiJQaTunjA==



=E5=9C=A8 2024/9/26 18:31, Filipe Manana =E5=86=99=E9=81=93:
> On Wed, Sep 25, 2024 at 11:08=E2=80=AFPM Qu Wenruo <quwenruo.btrfs@gmx.c=
om> wrote:
>>
>>
>>
>> =E5=9C=A8 2024/9/24 20:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
>>> From: Filipe Manana <fdmanana@suse.com>
>>>
>>> Currently the extent map shrinker is run synchronously for kswapd task=
s
>>> that end up calling the fs shrinker (fs/super.c:super_cache_scan()).
>>> This has some disadvantages and for some heavy workloads with memory
>>> pressure it can cause some delays and stalls that make a machine
>>> unresponsive for some periods. This happens because:
>>>
>>> 1) We can have several kswapd tasks on machines with multiple NUMA zon=
es,
>>>      and running the extent map shrinker concurrently can cause high
>>>      contention on some spin locks, namely the spin locks that protect
>>>      the radix tree that tracks roots, the per root xarray that tracks
>>>      open inodes and the list of delayed iputs. This not only delays t=
he
>>>      shrinker but also causes high CPU consumption and makes the task
>>>      running the shrinker monopolize a core, resulting in the symptoms
>>>      of an unresponsive system. This was noted in previous commits suc=
h as
>>>      commit ae1e766f623f ("btrfs: only run the extent map shrinker fro=
m
>>>      kswapd tasks");
>>>
>>> 2) The extent map shrinker's iteration over inodes can often be slow, =
even
>>>      after changing the data structure that tracks open inodes for a r=
oot
>>>      from a red black tree (up to kernel 6.10) to an xarray (kernel 6.=
10+).
>>>      The transition to the xarray while it made things a bit faster, i=
t's
>>>      still somewhat slow - for example in a test scenario with 10000 i=
nodes
>>>      that have no extent maps loaded, the extent map shrinker took bet=
ween
>>>      5ms to 8ms, using a release, non-debug kernel. Iterating over the
>>>      extent maps of an inode can also be slow if have an inode with ma=
ny
>>>      thousands of extent maps, since we use a red black tree to track =
and
>>>      search extent maps. So having the extent map shrinker run synchro=
nously
>>>      adds extra delay for other things a kswapd task does.
>>>
>>> So make the extent map shrinker run asynchronously as a job for the
>>> system unbounded workqueue, just like what we do for data and metadata
>>> space reclaim jobs.
>>>
>>> Signed-off-by: Filipe Manana <fdmanana@suse.com>
>>> ---
>>>    fs/btrfs/disk-io.c    |  2 ++
>>>    fs/btrfs/extent_map.c | 51 ++++++++++++++++++++++++++++++++++++----=
---
>>>    fs/btrfs/extent_map.h |  3 ++-
>>>    fs/btrfs/fs.h         |  2 ++
>>>    fs/btrfs/super.c      | 13 +++--------
>>>    5 files changed, 52 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>>> index 25d768e67e37..2148147c5257 100644
>>> --- a/fs/btrfs/disk-io.c
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -2786,6 +2786,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs=
_info)
>>>        btrfs_init_scrub(fs_info);
>>>        btrfs_init_balance(fs_info);
>>>        btrfs_init_async_reclaim_work(fs_info);
>>> +     btrfs_init_extent_map_shrinker_work(fs_info);
>>>
>>>        rwlock_init(&fs_info->block_group_cache_lock);
>>>        fs_info->block_group_cache_tree =3D RB_ROOT_CACHED;
>>> @@ -4283,6 +4284,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs=
_info)
>>>        cancel_work_sync(&fs_info->async_reclaim_work);
>>>        cancel_work_sync(&fs_info->async_data_reclaim_work);
>>>        cancel_work_sync(&fs_info->preempt_reclaim_work);
>>> +     cancel_work_sync(&fs_info->extent_map_shrinker_work);
>>>
>>>        /* Cancel or finish ongoing discard work */
>>>        btrfs_discard_cleanup(fs_info);
>>> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
>>> index cb2a6f5dce2b..e2eeb94aa349 100644
>>> --- a/fs/btrfs/extent_map.c
>>> +++ b/fs/btrfs/extent_map.c
>>> @@ -1118,7 +1118,8 @@ struct btrfs_em_shrink_ctx {
>>>
>>>    static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrf=
s_em_shrink_ctx *ctx)
>>>    {
>>> -     const u64 cur_fs_gen =3D btrfs_get_fs_generation(inode->root->fs=
_info);
>>> +     struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
>>> +     const u64 cur_fs_gen =3D btrfs_get_fs_generation(fs_info);
>>>        struct extent_map_tree *tree =3D &inode->extent_tree;
>>>        long nr_dropped =3D 0;
>>>        struct rb_node *node;
>>> @@ -1191,7 +1192,8 @@ static long btrfs_scan_inode(struct btrfs_inode =
*inode, struct btrfs_em_shrink_c
>>>                 * lock. This is to avoid slowing other tasks trying to=
 take the
>>>                 * lock.
>>>                 */
>>> -             if (need_resched() || rwlock_needbreak(&tree->lock))
>>> +             if (need_resched() || rwlock_needbreak(&tree->lock) ||
>>> +                 btrfs_fs_closing(fs_info))
>>>                        break;
>>>                node =3D next;
>>>        }
>>> @@ -1215,7 +1217,8 @@ static long btrfs_scan_root(struct btrfs_root *r=
oot, struct btrfs_em_shrink_ctx
>>>                ctx->last_ino =3D btrfs_ino(inode);
>>>                btrfs_add_delayed_iput(inode);
>>>
>>> -             if (ctx->scanned >=3D ctx->nr_to_scan)
>>> +             if (ctx->scanned >=3D ctx->nr_to_scan ||
>>> +                 btrfs_fs_closing(inode->root->fs_info))
>>>                        break;
>>>
>>>                cond_resched();
>>> @@ -1244,16 +1247,19 @@ static long btrfs_scan_root(struct btrfs_root =
*root, struct btrfs_em_shrink_ctx
>>>        return nr_dropped;
>>>    }
>>>
>>> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to=
_scan)
>>> +static void btrfs_extent_map_shrinker_worker(struct work_struct *work=
)
>>>    {
>>> +     struct btrfs_fs_info *fs_info;
>>>        struct btrfs_em_shrink_ctx ctx;
>>>        u64 start_root_id;
>>>        u64 next_root_id;
>>>        bool cycled =3D false;
>>>        long nr_dropped =3D 0;
>>>
>>> +     fs_info =3D container_of(work, struct btrfs_fs_info, extent_map_=
shrinker_work);
>>> +
>>>        ctx.scanned =3D 0;
>>> -     ctx.nr_to_scan =3D nr_to_scan;
>>> +     ctx.nr_to_scan =3D atomic64_read(&fs_info->extent_map_shrinker_n=
r_to_scan);
>>>
>>>        /*
>>>         * In case we have multiple tasks running this shrinker, make t=
he next
>>> @@ -1271,12 +1277,12 @@ long btrfs_free_extent_maps(struct btrfs_fs_in=
fo *fs_info, long nr_to_scan)
>>>        if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
>>>                s64 nr =3D percpu_counter_sum_positive(&fs_info->evicta=
ble_extent_maps);
>>>
>>> -             trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_t=
o_scan,
>>> +             trace_btrfs_extent_map_shrinker_scan_enter(fs_info, ctx.=
nr_to_scan,
>>>                                                           nr, ctx.last=
_root,
>>>                                                           ctx.last_ino=
);
>>>        }
>>>
>>> -     while (ctx.scanned < ctx.nr_to_scan) {
>>> +     while (ctx.scanned < ctx.nr_to_scan && !btrfs_fs_closing(fs_info=
)) {
>>>                struct btrfs_root *root;
>>>                unsigned long count;
>>>
>>> @@ -1334,5 +1340,34 @@ long btrfs_free_extent_maps(struct btrfs_fs_inf=
o *fs_info, long nr_to_scan)
>>>                                                          ctx.last_ino)=
;
>>>        }
>>>
>>> -     return nr_dropped;
>>> +     atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
>>> +}
>>> +
>>> +void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to=
_scan)
>>> +{
>>> +     /*
>>> +      * Do nothing if the shrinker is already running. In case of hig=
h memory
>>> +      * pressure we can have a lot of tasks calling us and all passin=
g the
>>> +      * same nr_to_scan value, but in reality we may need only to fre=
e
>>> +      * nr_to_scan extent maps (or less). In case we need to free mor=
e than
>>> +      * that, we will be called again by the fs shrinker, so no worri=
es about
>>> +      * not doing enough work to reclaim memory from extent maps.
>>> +      * We can also be repeatedly called with the same nr_to_scan val=
ue
>>> +      * simply because the shrinker runs asynchronously and multiple =
calls
>>> +      * to this function are made before the shrinker does enough pro=
gress.
>>> +      *
>>> +      * That's why we set the atomic counter to nr_to_scan only if it=
s
>>> +      * current value is zero, instead of incrementing the counter by
>>> +      * nr_to_scan.
>>> +      */
>>
>> Since the shrinker can be called frequently, even if we only keep one
>> shrink work running, will the shrinker be kept running for a long time?
>> (one queued work done, then immiedately be queued again)
>
> What's the problem?
> The use of the atomic and not incrementing it, as said in the comment,
> makes sure we don't do more work than necessary.
>
> It's also running in the system unbound queue and has plenty of
> explicit reschedule calls to ensure it doesn't monopolize a cpu and
> doesn't block other tasks for long.
>
> So how can it cause any problem?

Then it will be a workqueue taking CPU 100% (or near that).
Even there is only one running work.

The first one queued the X number to do, and the work got queued, after
freed X items, the next call triggered, queuing another Y number to reclai=
m.

The we get the same near-100% CPU usage, it may be rescheduled, but not
much difference.
We will always have one reclaim work item running at any moment.

>
>>
>> The XFS is queuing the work with an delay, although their reason is tha=
t
>> the reclaim needs to be run more frequently than syncd interval (30s).
>>
>> Do we also need some delay to prevent such too frequent reclaim work?
>
> See the comment above.
>
> Without the increment of the atomic counter, if it keeps getting
> scheduled it's because we're under memory pressure and need to free
> memory as quickly as possible.

Even the atomic stays the same until the current one finished, we just
get a new number of items to reclaim next.

Furthermore, from our existing experience, we didn't really hit a
realworld case where the em cache is causing a huge problem, so the
relaim for em should be a very low priority thing.

Thus I still believe a delayed work will be much safer, just like what
XFS is doing for decades, and also like our cleaner kthread.

Thanks,
Qu

>
> Thanks.
>
>>
>> Thanks,
>> Qu
>>
>>> +     if (atomic64_cmpxchg(&fs_info->extent_map_shrinker_nr_to_scan, 0=
, nr_to_scan) !=3D 0)
>>> +             return;
>>> +
>>> +     queue_work(system_unbound_wq, &fs_info->extent_map_shrinker_work=
);
>>> +}
>>> +
>>> +void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_inf=
o)
>>> +{
>>> +     atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
>>> +     INIT_WORK(&fs_info->extent_map_shrinker_work, btrfs_extent_map_s=
hrinker_worker);
>>>    }
>>> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
>>> index 5154a8f1d26c..cd123b266b64 100644
>>> --- a/fs/btrfs/extent_map.h
>>> +++ b/fs/btrfs/extent_map.h
>>> @@ -189,6 +189,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inod=
e *inode,
>>>    int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
>>>                                   struct extent_map *new_em,
>>>                                   bool modified);
>>> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to=
_scan);
>>> +void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to=
_scan);
>>> +void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_inf=
o);
>>>
>>>    #endif
>>> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
>>> index 785ec15c1b84..a246d8dc0b20 100644
>>> --- a/fs/btrfs/fs.h
>>> +++ b/fs/btrfs/fs.h
>>> @@ -638,6 +638,8 @@ struct btrfs_fs_info {
>>>        spinlock_t extent_map_shrinker_lock;
>>>        u64 extent_map_shrinker_last_root;
>>>        u64 extent_map_shrinker_last_ino;
>>> +     atomic64_t extent_map_shrinker_nr_to_scan;
>>> +     struct work_struct extent_map_shrinker_work;
>>>
>>>        /* Protected by 'trans_lock'. */
>>>        struct list_head dirty_cowonly_roots;
>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
>>> index e8a5bf4af918..e9e209dd8e05 100644
>>> --- a/fs/btrfs/super.c
>>> +++ b/fs/btrfs/super.c
>>> @@ -28,7 +28,6 @@
>>>    #include <linux/btrfs.h>
>>>    #include <linux/security.h>
>>>    #include <linux/fs_parser.h>
>>> -#include <linux/swap.h>
>>>    #include "messages.h"
>>>    #include "delayed-inode.h"
>>>    #include "ctree.h"
>>> @@ -2416,16 +2415,10 @@ static long btrfs_free_cached_objects(struct s=
uper_block *sb, struct shrink_cont
>>>        const long nr_to_scan =3D min_t(unsigned long, LONG_MAX, sc->nr=
_to_scan);
>>>        struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>>>
>>> -     /*
>>> -      * We may be called from any task trying to allocate memory and =
we don't
>>> -      * want to slow it down with scanning and dropping extent maps. =
It would
>>> -      * also cause heavy lock contention if many tasks concurrently e=
nter
>>> -      * here. Therefore only allow kswapd tasks to scan and drop exte=
nt maps.
>>> -      */
>>> -     if (!current_is_kswapd())
>>> -             return 0;
>>> +     btrfs_free_extent_maps(fs_info, nr_to_scan);
>>>
>>> -     return btrfs_free_extent_maps(fs_info, nr_to_scan);
>>> +     /* The extent map shrinker runs asynchronously, so always return=
 0. */
>>> +     return 0;
>>>    }
>>>
>>>    static const struct super_operations btrfs_super_ops =3D {
>>


