Return-Path: <linux-btrfs+bounces-8231-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16898986913
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Sep 2024 00:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0792284BFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Sep 2024 22:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8391547D5;
	Wed, 25 Sep 2024 22:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="MPxb/u06"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD78146A7A
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Sep 2024 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727302114; cv=none; b=UQzj2QAPv+AS9twANMhD2Q+BKnFv7Rp1pCddhx6CbhM8ip+tBbRn2RZea5mtJiRRemaD1po6Z75XMaji/BgFgnYx9XaUzXYBqozuLnAVGjE6IcUSu3D9kX6/AcYJllcsalzZPbBdIPyt1+CBCxSwr1nFvBgQl81E59Vz6jJaFV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727302114; c=relaxed/simple;
	bh=Z0Q3crQSoj4NJQr3IQlLwFMEjlEzTcnYGRJ5uuKUMgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pwkziW1LQ0loVOTzeOgVss9N5gWpGLI/t387MGPkyRKIDbdNMgcq5o7tcGXgFBbxhsG0pEgOlfMuQHfMFwT21HfggoBa1H5ztoO1GV/NlvTxVGI5DxxpirR6K2/dn9f6nDwp9/oliMn6jdKhQtoe6hUeA5JOmsqLfDqUQIeV3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=MPxb/u06; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1727302106; x=1727906906; i=quwenruo.btrfs@gmx.com;
	bh=OnWoY4u4XOo/Ub5KaJYZJmJtkWBk6uzgqoSyU0ikugQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MPxb/u06l3DsX+82S/w0Mwl1HF5lvA3gEQ8N12b7Iv4Tx0Au+3YHj0qYF3In4D+7
	 UvGXVJa7oxbMgetA4DilKNu/goF3Ab8JD38PJe+vhT0apARtkvglcjVAy4uFhlx1g
	 j/EOJ74rA1mNlBLcBg5lXPCwi6bueKKbChTv39fbeDLd3TgoxvCzUfo1rYpG4UBKd
	 PEsad5G6CU/MTeSk7rdS/gK8LML9CsG+teRMKzhsjBu/zGk7953gt6dI4QnavAPwz
	 o/07o3osBhk++As0Rioa950MjHOsv1Da4nj3Op7oaOIirATRmaGI8NB398Hg36R5V
	 53fhTPNLf8QDgF2BYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWzfl-1sRMzQ0omH-00UIyk; Thu, 26
 Sep 2024 00:08:25 +0200
Message-ID: <51c11bdd-cac9-4525-85e3-ce8da69dec1f@gmx.com>
Date: Thu, 26 Sep 2024 07:38:23 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] btrfs: make the extent map shrinker run
 asynchronously as a work queue job
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1727174151.git.fdmanana@suse.com>
 <1a3f817fc3c5a6e4267bcd56f2f0518a9d8e0e4e.1727174151.git.fdmanana@suse.com>
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
In-Reply-To: <1a3f817fc3c5a6e4267bcd56f2f0518a9d8e0e4e.1727174151.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:02hrqLaEv2VKhix7YR27WvJVxqyMv9CRUFNcB/XF/2CRN1XPfeo
 G159cCYEpfiYZMrcwjJqN3OZnr8NWSSD6UWz7aLyfAfkbi5xuekS64in767HT9tO08nBgTP
 X31YshCGgsMzyvDQslL2Z6EQPTTayUEbGEmvI40u4yfcdtHJcBYtiaVg3akrDi9phI2PV4z
 ty98aWDyI3yMtZIvgdKng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7AYhn2LoJYg=;M8+CJts1LslOsjsBw3djRGFCIhB
 OxB5ACJwUhiw4uFpAqaAwMelkyZBV9Ir7UjzKxlPelKpJ7S11jH5jJTUcuTULR5BW52Mt9eb/
 UTRvS87JNkk7N1H7BhJNpN8GG9vwD+r5qF0kZ7g2ck4/LRNjQQqqLg8KXOrz0KvooR0HSNs9S
 qbc+vK5eeAH1E5rGPtBUT1L5NQ8WNc+ZcLKqbQWmB8om5Kqu4PCgCoFYUA7PIOIjaW1j4ziKR
 hiJgonJqkahuwRWD2k1Nc+skgW99NZyqbr9o22trgLNHininexqGzflrp+SALDxVPfPzLGFI7
 imwGLQZJgSKy/p5od8z35l+9lla0MfcVrN44Zw+j+Upgsu4N1kpWc67qJPGbDI6Rg80fm1smE
 0Fn7GuoGVfysWG/ceVmR1hvbtNMwIPOurgOYbPwfpWtgoEivlasAnQRABPOICIbJM6BYMGyQ9
 5pwXDTh48VgMOzZrDbWBiI68qDEzLVzh7SWb1AuwZZhkhSdrxckxrzRfvruiEyL9HZ76NZcr6
 qMl8JcRCzBBGtEo0xgiCdsOBaVQFqCZV6+pBbqB5pVc7EjHpTMxjj3v5Zr/RWZIHYNzPa+540
 9RpTyLvyl4J6pHVNUCvhKEMEgXUBQ/10+1evf/Luo/iQ7z6tPZY9ErufxLTlQ05hAkWSsZ+Nr
 CBYcArnKeKwD8usUQk+d2mGvpVFTFrfl1OS0z/8ns0OpC9RzMrUTakKLA6gMI8UOXmgWN7nmr
 g17hN3Wq1ph9eWTcvpZ/IOkLlXJiRBndDXxKjzchTzsBg2GpFBdLd7QvnTNXRk0Rf5k6Wz9ld
 vJoSxCz/p+C6Jcq3WoycIfqg==



=E5=9C=A8 2024/9/24 20:15, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> Currently the extent map shrinker is run synchronously for kswapd tasks
> that end up calling the fs shrinker (fs/super.c:super_cache_scan()).
> This has some disadvantages and for some heavy workloads with memory
> pressure it can cause some delays and stalls that make a machine
> unresponsive for some periods. This happens because:
>
> 1) We can have several kswapd tasks on machines with multiple NUMA zones=
,
>     and running the extent map shrinker concurrently can cause high
>     contention on some spin locks, namely the spin locks that protect
>     the radix tree that tracks roots, the per root xarray that tracks
>     open inodes and the list of delayed iputs. This not only delays the
>     shrinker but also causes high CPU consumption and makes the task
>     running the shrinker monopolize a core, resulting in the symptoms
>     of an unresponsive system. This was noted in previous commits such a=
s
>     commit ae1e766f623f ("btrfs: only run the extent map shrinker from
>     kswapd tasks");
>
> 2) The extent map shrinker's iteration over inodes can often be slow, ev=
en
>     after changing the data structure that tracks open inodes for a root
>     from a red black tree (up to kernel 6.10) to an xarray (kernel 6.10+=
).
>     The transition to the xarray while it made things a bit faster, it's
>     still somewhat slow - for example in a test scenario with 10000 inod=
es
>     that have no extent maps loaded, the extent map shrinker took betwee=
n
>     5ms to 8ms, using a release, non-debug kernel. Iterating over the
>     extent maps of an inode can also be slow if have an inode with many
>     thousands of extent maps, since we use a red black tree to track and
>     search extent maps. So having the extent map shrinker run synchronou=
sly
>     adds extra delay for other things a kswapd task does.
>
> So make the extent map shrinker run asynchronously as a job for the
> system unbounded workqueue, just like what we do for data and metadata
> space reclaim jobs.
>
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/disk-io.c    |  2 ++
>   fs/btrfs/extent_map.c | 51 ++++++++++++++++++++++++++++++++++++-------
>   fs/btrfs/extent_map.h |  3 ++-
>   fs/btrfs/fs.h         |  2 ++
>   fs/btrfs/super.c      | 13 +++--------
>   5 files changed, 52 insertions(+), 19 deletions(-)
>
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 25d768e67e37..2148147c5257 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2786,6 +2786,7 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_i=
nfo)
>   	btrfs_init_scrub(fs_info);
>   	btrfs_init_balance(fs_info);
>   	btrfs_init_async_reclaim_work(fs_info);
> +	btrfs_init_extent_map_shrinker_work(fs_info);
>
>   	rwlock_init(&fs_info->block_group_cache_lock);
>   	fs_info->block_group_cache_tree =3D RB_ROOT_CACHED;
> @@ -4283,6 +4284,7 @@ void __cold close_ctree(struct btrfs_fs_info *fs_i=
nfo)
>   	cancel_work_sync(&fs_info->async_reclaim_work);
>   	cancel_work_sync(&fs_info->async_data_reclaim_work);
>   	cancel_work_sync(&fs_info->preempt_reclaim_work);
> +	cancel_work_sync(&fs_info->extent_map_shrinker_work);
>
>   	/* Cancel or finish ongoing discard work */
>   	btrfs_discard_cleanup(fs_info);
> diff --git a/fs/btrfs/extent_map.c b/fs/btrfs/extent_map.c
> index cb2a6f5dce2b..e2eeb94aa349 100644
> --- a/fs/btrfs/extent_map.c
> +++ b/fs/btrfs/extent_map.c
> @@ -1118,7 +1118,8 @@ struct btrfs_em_shrink_ctx {
>
>   static long btrfs_scan_inode(struct btrfs_inode *inode, struct btrfs_e=
m_shrink_ctx *ctx)
>   {
> -	const u64 cur_fs_gen =3D btrfs_get_fs_generation(inode->root->fs_info)=
;
> +	struct btrfs_fs_info *fs_info =3D inode->root->fs_info;
> +	const u64 cur_fs_gen =3D btrfs_get_fs_generation(fs_info);
>   	struct extent_map_tree *tree =3D &inode->extent_tree;
>   	long nr_dropped =3D 0;
>   	struct rb_node *node;
> @@ -1191,7 +1192,8 @@ static long btrfs_scan_inode(struct btrfs_inode *i=
node, struct btrfs_em_shrink_c
>   		 * lock. This is to avoid slowing other tasks trying to take the
>   		 * lock.
>   		 */
> -		if (need_resched() || rwlock_needbreak(&tree->lock))
> +		if (need_resched() || rwlock_needbreak(&tree->lock) ||
> +		    btrfs_fs_closing(fs_info))
>   			break;
>   		node =3D next;
>   	}
> @@ -1215,7 +1217,8 @@ static long btrfs_scan_root(struct btrfs_root *roo=
t, struct btrfs_em_shrink_ctx
>   		ctx->last_ino =3D btrfs_ino(inode);
>   		btrfs_add_delayed_iput(inode);
>
> -		if (ctx->scanned >=3D ctx->nr_to_scan)
> +		if (ctx->scanned >=3D ctx->nr_to_scan ||
> +		    btrfs_fs_closing(inode->root->fs_info))
>   			break;
>
>   		cond_resched();
> @@ -1244,16 +1247,19 @@ static long btrfs_scan_root(struct btrfs_root *r=
oot, struct btrfs_em_shrink_ctx
>   	return nr_dropped;
>   }
>
> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_s=
can)
> +static void btrfs_extent_map_shrinker_worker(struct work_struct *work)
>   {
> +	struct btrfs_fs_info *fs_info;
>   	struct btrfs_em_shrink_ctx ctx;
>   	u64 start_root_id;
>   	u64 next_root_id;
>   	bool cycled =3D false;
>   	long nr_dropped =3D 0;
>
> +	fs_info =3D container_of(work, struct btrfs_fs_info, extent_map_shrink=
er_work);
> +
>   	ctx.scanned =3D 0;
> -	ctx.nr_to_scan =3D nr_to_scan;
> +	ctx.nr_to_scan =3D atomic64_read(&fs_info->extent_map_shrinker_nr_to_s=
can);
>
>   	/*
>   	 * In case we have multiple tasks running this shrinker, make the nex=
t
> @@ -1271,12 +1277,12 @@ long btrfs_free_extent_maps(struct btrfs_fs_info=
 *fs_info, long nr_to_scan)
>   	if (trace_btrfs_extent_map_shrinker_scan_enter_enabled()) {
>   		s64 nr =3D percpu_counter_sum_positive(&fs_info->evictable_extent_ma=
ps);
>
> -		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, nr_to_scan,
> +		trace_btrfs_extent_map_shrinker_scan_enter(fs_info, ctx.nr_to_scan,
>   							   nr, ctx.last_root,
>   							   ctx.last_ino);
>   	}
>
> -	while (ctx.scanned < ctx.nr_to_scan) {
> +	while (ctx.scanned < ctx.nr_to_scan && !btrfs_fs_closing(fs_info)) {
>   		struct btrfs_root *root;
>   		unsigned long count;
>
> @@ -1334,5 +1340,34 @@ long btrfs_free_extent_maps(struct btrfs_fs_info =
*fs_info, long nr_to_scan)
>   							  ctx.last_ino);
>   	}
>
> -	return nr_dropped;
> +	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
> +}
> +
> +void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_s=
can)
> +{
> +	/*
> +	 * Do nothing if the shrinker is already running. In case of high memo=
ry
> +	 * pressure we can have a lot of tasks calling us and all passing the
> +	 * same nr_to_scan value, but in reality we may need only to free
> +	 * nr_to_scan extent maps (or less). In case we need to free more than
> +	 * that, we will be called again by the fs shrinker, so no worries abo=
ut
> +	 * not doing enough work to reclaim memory from extent maps.
> +	 * We can also be repeatedly called with the same nr_to_scan value
> +	 * simply because the shrinker runs asynchronously and multiple calls
> +	 * to this function are made before the shrinker does enough progress.
> +	 *
> +	 * That's why we set the atomic counter to nr_to_scan only if its
> +	 * current value is zero, instead of incrementing the counter by
> +	 * nr_to_scan.
> +	 */

Since the shrinker can be called frequently, even if we only keep one
shrink work running, will the shrinker be kept running for a long time?
(one queued work done, then immiedately be queued again)

The XFS is queuing the work with an delay, although their reason is that
the reclaim needs to be run more frequently than syncd interval (30s).

Do we also need some delay to prevent such too frequent reclaim work?

Thanks,
Qu

> +	if (atomic64_cmpxchg(&fs_info->extent_map_shrinker_nr_to_scan, 0, nr_t=
o_scan) !=3D 0)
> +		return;
> +
> +	queue_work(system_unbound_wq, &fs_info->extent_map_shrinker_work);
> +}
> +
> +void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info)
> +{
> +	atomic64_set(&fs_info->extent_map_shrinker_nr_to_scan, 0);
> +	INIT_WORK(&fs_info->extent_map_shrinker_work, btrfs_extent_map_shrinke=
r_worker);
>   }
> diff --git a/fs/btrfs/extent_map.h b/fs/btrfs/extent_map.h
> index 5154a8f1d26c..cd123b266b64 100644
> --- a/fs/btrfs/extent_map.h
> +++ b/fs/btrfs/extent_map.h
> @@ -189,6 +189,7 @@ void btrfs_drop_extent_map_range(struct btrfs_inode =
*inode,
>   int btrfs_replace_extent_map_range(struct btrfs_inode *inode,
>   				   struct extent_map *new_em,
>   				   bool modified);
> -long btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_s=
can);
> +void btrfs_free_extent_maps(struct btrfs_fs_info *fs_info, long nr_to_s=
can);
> +void btrfs_init_extent_map_shrinker_work(struct btrfs_fs_info *fs_info)=
;
>
>   #endif
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index 785ec15c1b84..a246d8dc0b20 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -638,6 +638,8 @@ struct btrfs_fs_info {
>   	spinlock_t extent_map_shrinker_lock;
>   	u64 extent_map_shrinker_last_root;
>   	u64 extent_map_shrinker_last_ino;
> +	atomic64_t extent_map_shrinker_nr_to_scan;
> +	struct work_struct extent_map_shrinker_work;
>
>   	/* Protected by 'trans_lock'. */
>   	struct list_head dirty_cowonly_roots;
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index e8a5bf4af918..e9e209dd8e05 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -28,7 +28,6 @@
>   #include <linux/btrfs.h>
>   #include <linux/security.h>
>   #include <linux/fs_parser.h>
> -#include <linux/swap.h>
>   #include "messages.h"
>   #include "delayed-inode.h"
>   #include "ctree.h"
> @@ -2416,16 +2415,10 @@ static long btrfs_free_cached_objects(struct sup=
er_block *sb, struct shrink_cont
>   	const long nr_to_scan =3D min_t(unsigned long, LONG_MAX, sc->nr_to_sc=
an);
>   	struct btrfs_fs_info *fs_info =3D btrfs_sb(sb);
>
> -	/*
> -	 * We may be called from any task trying to allocate memory and we don=
't
> -	 * want to slow it down with scanning and dropping extent maps. It wou=
ld
> -	 * also cause heavy lock contention if many tasks concurrently enter
> -	 * here. Therefore only allow kswapd tasks to scan and drop extent map=
s.
> -	 */
> -	if (!current_is_kswapd())
> -		return 0;
> +	btrfs_free_extent_maps(fs_info, nr_to_scan);
>
> -	return btrfs_free_extent_maps(fs_info, nr_to_scan);
> +	/* The extent map shrinker runs asynchronously, so always return 0. */
> +	return 0;
>   }
>
>   static const struct super_operations btrfs_super_ops =3D {


