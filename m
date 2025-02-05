Return-Path: <linux-btrfs+bounces-11279-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4F6A2838F
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 06:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DA51886543
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2025 05:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B9F2135A2;
	Wed,  5 Feb 2025 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="aTAk2MnL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB792770B
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Feb 2025 05:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738732522; cv=none; b=Wb8nGDeXkBJKVU8RPPwfehUH4HWu82VRTZyk5qTgIT7PWA62AOuosjzw1XfO8OSgN4ne9AIQEWZi/OA3SS/7f3V7jk6lNqwCGCQbRTsuudG1bq2uysgmF18rKnaSbASVmNzjrw7ZhjXCAac3CnWowTOXrzhQz/28hXtdj+6tRZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738732522; c=relaxed/simple;
	bh=+kaGz2KvopJNhabfthxa9NnkX+N1Be0sOkVfjbSuoGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dNnsYT5swwQxiGND+ziUR8RKeEu6cMea8hBpncqn2Wwc2e/rVvliXrgst8lcnKZSufkbbQWchKDzcwEeJpVLhiN7cLq39fdQrnTz07p8+RFH9HFmr8DmqN/Quuw0Bmg1tLMvx/cmScdBGq1szwPk56q3xr/IFAk+gsCs/ne0aj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=aTAk2MnL; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1738732513; x=1739337313; i=quwenruo.btrfs@gmx.com;
	bh=J7oHHH85O1IXccaff2zI6oZKE7imA7yeX4m1tlZoJ+M=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aTAk2MnLRU+23Q7kXfj0Hj8MFkRmZ9nnneOQq7cDEEvErJAlbVCSRWOHSU4oFqHl
	 VtYUd/d7uXRTr1MnD2Md9ggH5/KweJfnZeqWSuOUS03zCQkKiqMARaiFjHlMp87It
	 eNYJ8usHN+9/nhC+pRcn42O3Am1jlSKUDL+a+Ow/6EQlimA6GlQoarRqZY7ExQTeS
	 xYHk5rCW0BoZqJZ1Gt5Mp5Revi4mbjc0bok6OyljAggtPgBx15T7wTVI8/RFGh882
	 +ulvu4AgDV4ml0zPlhZCo4NCE7chMn03zCirho5t4H7uP5gNU86NcOuXVaMOSFvCR
	 3Snii4lpKCPD3RyhAA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVvPD-1tpcLU0QSr-00UzMQ; Wed, 05
 Feb 2025 06:15:13 +0100
Message-ID: <a94fb3db-ac05-4fea-afda-df42cd9286b1@gmx.com>
Date: Wed, 5 Feb 2025 15:45:10 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix stale page cache after race between readahead
 and direct IO write
To: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <24617a89550bed4ef0e0db12d17187940de551b0.1738685146.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <24617a89550bed4ef0e0db12d17187940de551b0.1738685146.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a+/spoRBm8O131Cd561wOAUi9wT+mhbFjh4ogWSY7hpAQ7sH+zW
 RXTfChlNJb1rTNT3ImbgR0Ag4e6Nu/34hNf4xDW9Ep4l8g+HV0LLReGtSOkG4V8WP0MmsLa
 pgm5DmnzDwpvTG+DloO1sr13s7y4FlDmKRXOeWz//lC46rkCydhegi2qLekpkInLd+tNFUe
 7IXyRNI8GPDChz5mecBDQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qVtxXTHI6pY=;09I6xH5FhCHxgWf2o8n6k6utb7I
 tP/ARh+FnSHWt5gZR6Qbxd0QgYlhnngtuy29mxrRGzF0JPCq2XvJiNwwW+0OlD79KEXnvuzwj
 wUJKR+yUdaZ+vFUvjF2GgdRZsJOigjZOG/Pfkm9OgkQFdkdpQmyczMwORyApd5pL32qOWugQ5
 Yj8Ryf/Cul2DdLU93f5wg49kU/GW/ufVMh22Hi5GKzWJhMTHiJgbWba88CyGqqFv79EpXrI1j
 xD/JcFtbDMPc+ikK4fO54i7fjnFqmB6eFmRU5opoXa2WXKxvikxUupYdCnveZydZKfAIZAEGi
 MxLQHI3mCSzN79NputBzig+XeSY9Xo0PFRXievif8MlUffeK6gKP6W5HgKLVgGqrZZgdJnkMk
 UAHphJSt3WSBC/4nAkG9e+utbkTMmCfJPxxMLwm1XFTkyxARbXsLy2z/JdE6Wk5y7mjxwBFkv
 lwFCnFLLLseVzkeo2adhV/vSReajaVsXssHNREKn7Xs+gXPuy5ulaS2zFR18T8efwWNu8QuDQ
 NY7hdVMXEmp4n93J4CyvTvO/1qIA82Kk/cUvIzrgIn/zwqtRDJ6c5bu/fDdphZJrulTtFAb6z
 4/wBSUeFPIwbtL00G4pQ3DVg+Q5Qj1CZPEzFQ5KxtQdik1OS367/bzg7gONwM4h37f5/1EoDL
 40i9FGfQLM2FMaVq2g9BcKeYJwjkkZm9FJnVxpfj7VP2VnggmXOE1KOoelLsMDK9GYTPCAmup
 iGAk1Bw+Y+s80V4Iet9UWhYMwudAxsYr4/woZ38mRsHKD92AbVOdjV95vgrcvcIIqxFowN1MN
 NITq6eqwCJSBJyyzQVRyGMyFQv8M5l5z8Vu6koJwMZ6IZ7368GprtynV33xv71Ofvj/nXZond
 UfWrXLnhPe32ruRsSHHF2Lq9CjekL7DT83NZzv+bLdL1Hjp7CRNXWYv3yHm5rQAAWSDSGpzp7
 wdxJq+P8aKATLVqZ7fpE8+aAhcTwryMb2ws4ybBEL9mSJyq6NFDyvEGBnTWi0tqf5zNi5jOQ6
 KsP1f6PZA72Osrd6YGSi7VnXI781yL8qyTQ/aq1vmI2JECMhANFNdcro6yZS6zaV6MgZvi/AK
 5D0eC/NYfefQ8OWYd5qTCSGa5V2pQ9BhwyGwwL3GAZ29iB4Fjh1pwncJ8Sye+vYSTb8hPFSo3
 YcyR/EpOWuzlxYCSEmx0+odOdojJk/PLyCfVgy6HfO4M4gy7ImcjaNKBAOcygtSenD5Jama9c
 rLBe66aW9XSc9AodOkHITYC3neUK6S7L3p57gAgpHpU6QYhlkb/TEQRr4yGgdbgORtAIPRpKh
 ylDCO3xqf8ulrumhNDKZS7MWKqGKyokuQIKdcBFpzE1HOfzlqaxQyRolNFEyguEEInXrBMP0x
 M87BSQb5s2QRuniu993lGHf3SeSHich4VHFEZEkH+/6Fiu2JYahpLFC0GT



=E5=9C=A8 2025/2/5 02:46, fdmanana@kernel.org =E5=86=99=E9=81=93:
> From: Filipe Manana <fdmanana@suse.com>
>
> After commit ac325fc2aad5 ("btrfs: do not hold the extent lock for entir=
e
> read") we can now trigger a race between a task doing a direct IO write
> and readahead. When this race is triggered it results in tasks getting
> stale data when they attempt do a buffered read (including the task that
> did the direct IO write).
>
> This race can be sporadically triggered with test case generic/418, fail=
ing
> like this:
>
>     $ ./check generic/418
>     FSTYP         -- btrfs
>     PLATFORM      -- Linux/x86_64 debian0 6.13.0-rc7-btrfs-next-185+ #17=
 SMP PREEMPT_DYNAMIC Mon Feb  3 12:28:46 WET 2025
>     MKFS_OPTIONS  -- /dev/sdc
>     MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
>
>     generic/418 14s ... - output mismatch (see /home/fdmanana/git/hub/xf=
stests/results//generic/418.out.bad)
>         --- tests/generic/418.out	2020-06-10 19:29:03.850519863 +0100
>         +++ /home/fdmanana/git/hub/xfstests/results//generic/418.out.bad=
	2025-02-03 15:42:36.974609476 +0000
>         @@ -1,2 +1,5 @@
>          QA output created by 418
>         +cmpbuf: offset 0: Expected: 0x1, got 0x0
>         +[6:0] FAIL - comparison failed, offset 24576
>         +diotest -wp -b 4096 -n 8 -i 4 failed at loop 3
>          Silence is golden
>         ...
>         (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/generic/418.=
out /home/fdmanana/git/hub/xfstests/results//generic/418.out.bad'  to see =
the entire diff)
>     Ran: generic/418
>     Failures: generic/418
>     Failed 1 of 1 tests
>
> The race happens like this:
>
> 1) A file has a prealloc extent for the range [16K, 28K);
>
> 2) Task A starts a direct IO write against file range [24K, 28K).
>     At the start of the direct IO write it invalidates the page cache at
>     __iomap_dio_rw() with kiocb_invalidate_pages() for the 4K page at fi=
le
>     offset 24K;
>
> 3) Task A enters btrfs_dio_iomap_begin() and locks the extent range
>     [24K, 28K);
>
> 4) Task B starts a readahead for file range [16K, 28K), entering
>     btrfs_readahead().
>
>     First it attempts to read the page at offset 16K by entering
>     btrfs_do_readpage(), where it calls get_extent_map(), locks the rang=
e
>     [16K, 20K) and gets the extent map for the range [16K, 28K), caching
>     it into the 'em_cached' variable declared in the local stack of
>     btrfs_readahead(), and then unlocks the range [16K, 20K).
>
>     Since the extent map has the prealloc flag, at btrfs_do_readpage() w=
e
>     zero out the page's content and don't submit any bio to read the pag=
e
>     from the extent.
>
>     Then it attempts to read the page at offset 20K entering
>     btrfs_do_readpage() where we reuse the previously cached extent map
>     (decided by get_extent_map()) since it spans the page's range and
>     it's still in the inode's extent map tree.
>
>     Just like for the previous page, we zero out the page's content sinc=
e
>     the extent map has the prealloc flag set.
>
>     Then it attempts to read the page at offset 24K entering
>     btrfs_do_readpage() where we reuse the previously cached extent map
>     (decided by get_extent_map()) since it spans the page's range and
>     it's still in the inode's extent map tree.
>
>     Just like for the previous pages, we zero out the page's content sin=
ce
>     the extent map has the prealloc flag set. Note that we didn't lock t=
he
>     extent range [24K, 28K), so we didn't synchronize with the ongoig
>     direct IO write being performed by task A;
>
> 5) Task A enters btrfs_create_dio_extent() and creates an ordered extent
>     for the range [24K, 28K), with the flags BTRFS_ORDERED_DIRECT and
>     BTRFS_ORDERED_PREALLOC set;
>
> 6) Task A unlocks the range [24K, 28K) at btrfs_dio_iomap_begin();
>
> 7) The ordered extent enters btrfs_finish_one_ordered() and locks the
>     range [24K, 28K);
>
> 8) Task A enters fs/iomap/direct-io.c:iomap_dio_complete() and it tries
>     to invalidate the page at offset 24K by calling
>     kiocb_invalidate_post_direct_write(), resulting in a call chain that
>     ends up at btrfs_release_folio().
>
>     The btrfs_release_folio() call ends up returning false because the r=
ange
>     for the page at file offset 24K is currently locked by the task doin=
g
>     the ordered extent completion in the previous step (7), so we have:
>
>     btrfs_release_folio() ->
>        __btrfs_release_folio() ->
>           try_release_extent_mapping() ->
> 	     try_release_extent_state()
>
>     This last function checking that the range is locked and returning f=
alse
>     and propagating it up to btrfs_release_folio().
>
>     So this results in a failure to invalidate the page and
>     kiocb_invalidate_post_direct_write() triggers this message logged in
>     dmesg:
>
>       Page cache invalidation failure on direct I/O.  Possible data corr=
uption due to collision with buffered I/O!
>
>     After this we leave the page cache with stale data for the file rang=
e
>     [24K, 28K), filled with zeroes instead of the data written by direct=
 IO
>     write (all bytes with a 0x01 value), so any task attempting to read =
with
>     buffered IO, including the task that did the direct IO write, will g=
et
>     all bytes in the range with a 0x00 value instead of the written data=
.
>
> Fix this by locking the range, with btrfs_lock_and_flush_ordered_range()=
,
> at the two callers of btrfs_do_readpage() instead of doing it at
> get_extent_map(), just like we did before commit ac325fc2aad5 ("btrfs: d=
o
> not hold the extent lock for entire read"), and unlocking the range afte=
r
> all the calls to btrfs_do_readpage(). This way we never reuse a cached
> extent map without flushing any pending ordered extents from a concurren=
t
> direct IO write.
>
> Fixes: ac325fc2aad5 ("btrfs: do not hold the extent lock for entire read=
")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/extent_io.c | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 838ab2b6ed43..bdb9816bf125 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -898,7 +898,6 @@ static struct extent_map *get_extent_map(struct btrf=
s_inode *inode,
>   					 u64 len, struct extent_map **em_cached)
>   {
>   	struct extent_map *em;
> -	struct extent_state *cached_state =3D NULL;
>
>   	ASSERT(em_cached);
>
> @@ -914,14 +913,12 @@ static struct extent_map *get_extent_map(struct bt=
rfs_inode *inode,
>   		*em_cached =3D NULL;
>   	}
>
> -	btrfs_lock_and_flush_ordered_range(inode, start, start + len - 1, &cac=
hed_state);
>   	em =3D btrfs_get_extent(inode, folio, start, len);
>   	if (!IS_ERR(em)) {
>   		BUG_ON(*em_cached);
>   		refcount_inc(&em->refs);
>   		*em_cached =3D em;
>   	}
> -	unlock_extent(&inode->io_tree, start, start + len - 1, &cached_state);
>
>   	return em;
>   }
> @@ -1078,11 +1075,18 @@ static int btrfs_do_readpage(struct folio *folio=
, struct extent_map **em_cached,
>
>   int btrfs_read_folio(struct file *file, struct folio *folio)
>   {
> +	struct btrfs_inode *inode =3D folio_to_inode(folio);
> +	const u64 start =3D folio_pos(folio);
> +	const u64 end =3D start + folio_size(folio) - 1;

And great you're already taking larger data folio into consideration.

> +	struct extent_state *cached_state =3D NULL;
>   	struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ };
>   	struct extent_map *em_cached =3D NULL;
>   	int ret;
>
> +	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);

This change is going to conflict with the subpage + partial uptodate
page optimization (which will also be the foundation for larger data folio=
):
https://lore.kernel.org/linux-btrfs/1d230d53e92c4f4a7ea4ce036f226b8daa16e5=
ae.1736848277.git.wqu@suse.com/

I'm fine to update the patch on my side after yours got merged.

>   	ret =3D btrfs_do_readpage(folio, &em_cached, &bio_ctrl, NULL);
> +	unlock_extent(&inode->io_tree, start, end, &cached_state);
> +
>   	free_extent_map(em_cached);
>
>   	/*
> @@ -2377,12 +2381,20 @@ void btrfs_readahead(struct readahead_control *r=
ac)
>   {
>   	struct btrfs_bio_ctrl bio_ctrl =3D { .opf =3D REQ_OP_READ | REQ_RAHEA=
D };
>   	struct folio *folio;
> +	struct btrfs_inode *inode =3D BTRFS_I(rac->mapping->host);
> +	const u64 start =3D readahead_pos(rac);
> +	const u64 end =3D start + readahead_length(rac) - 1;
> +	struct extent_state *cached_state =3D NULL;
>   	struct extent_map *em_cached =3D NULL;
>   	u64 prev_em_start =3D (u64)-1;
>
> +	btrfs_lock_and_flush_ordered_range(inode, start, end, &cached_state);
> +

I'm not confident enough about this lock, as it can cross several pages.

E.g. if we have the following case, 4K page size 4K block size.

         0       4K      8K      12K     16K
         |       |///////|               |

And range [4K, 8K) is uptodate, and it has been submitted for writeback,
and finished writeback.
But it still have ordered extent, not yet finished.

Then we go into the following call chain:
btrfs_lock_and_write_flush()
|- btrfs_start_ordered_extent()
    |- filemap_fdatawrite_range()

Which will try to writeback the range [4K, 8K) again.
But since the folio at [4K, 8K) is going to be passed to
btrfs_do_readpage(), it should already have been locked.

Thus the writeback will never be able to lock the folio, thus causing a
deadlock.

Or did I miss something specific to readahead so it will avoid readahead
on already uptodate pages?


And even if it will not cause the above deadlock, I'm not confident the
mentioned subpage fix conflict can be proper fixed.
In the subpage fix, I can only add a folio parameter to
btrfs_lock_and_flush_ordered_range(), but in this case, we have multiple
folios, how can we avoid the same subpage dead lock then?

Thanks,
Qu

>   	while ((folio =3D readahead_folio(rac)) !=3D NULL)
>   		btrfs_do_readpage(folio, &em_cached, &bio_ctrl, &prev_em_start);
>
> +	unlock_extent(&inode->io_tree, start, end, &cached_state);
> +
>   	if (em_cached)
>   		free_extent_map(em_cached);
>   	submit_one_bio(&bio_ctrl);


