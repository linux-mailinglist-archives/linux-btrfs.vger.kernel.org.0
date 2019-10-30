Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF12AE9421
	for <lists+linux-btrfs@lfdr.de>; Wed, 30 Oct 2019 01:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfJ3AhI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Oct 2019 20:37:08 -0400
Received: from mout.gmx.net ([212.227.15.19]:38941 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbfJ3AhI (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Oct 2019 20:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1572395816;
        bh=pXX35o3qcWOx1ilwjSgkezu40k79oNrlt771j/gx970=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WDOlqExBY6+j9fKxxrfkTs6HBG75u0+kKFfu9EPoRRCjH9LEkAaUIWGIV7B9eRSHD
         GlO3tsqB3cdJp/JCCUC0UaHIpOPMiq6fT2QrpnK0NQkMCPZevpgvSJyYMgM6K3FLJG
         rpHbFlNRN68AUS8lfn1Cr2lIJ5vDU4eZ3MEEZlbc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([13.231.109.76]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mof5H-1hbA0F2XU1-00p688; Wed, 30
 Oct 2019 01:36:55 +0100
Subject: Re: [PATCH] btrfs: rename btrfs_block_group_cache
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
References: <07674c79220c9f8fdb4588ad339a0af9515640cd.1572373079.git.dsterba@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAU4EEwEIADgCGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1oQAKCRDC
 PZHzoSX+qCY6CACd+mWu3okGwRKXju6bou+7VkqCaHTdyXwWFTsr+/0ly5nUdDtT3yEVggPJ
 3VP70wjlrxUjNjFb6iIvGYxiPOrop1NGwGYvQktgRhaIhALG6rPoSSAhGNjwGVRw0km0PlIN
 D29BTj/lYEk+jVM1YL0QLgAE1AI3krihg/lp/fQT53wLhR8YZIF8ETXbClQG1vJ0cllPuEEv
 efKxRyiTSjB+PsozSvYWhXsPeJ+KKjFen7ebE5reQTPFzSHctCdPnoR/4jSPlnTlnEvLeqcD
 ZTuKfQe1gWrPeevQzgCtgBF/WjIOeJs41klnYzC3DymuQlmFubss0jShLOW8eSOOWhLRuQEN
 BFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcgaCbPEwhLj
 1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj/IrRUUka
 68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fNGSsRb+pK
 EKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0q1eW4Jrv
 0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEvABEBAAGJ
 ATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAKCRDCPZHz
 oSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gyfmtBnUai
 fnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsSoCEEynby
 72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAkZkA523JG
 ap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gGUO/iD/T5
 oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <9fc3597f-9c51-721d-ce41-b4bb57f36492@gmx.com>
Date:   Wed, 30 Oct 2019 08:36:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <07674c79220c9f8fdb4588ad339a0af9515640cd.1572373079.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GsqIG7DGv82rDCsviO+kwG2dzI8Jm34Cih8P2brHQ3Niz76sLwa
 Z/R8hEKpGTRVdXy9FmnWPQVDEUxTc1qCBCAIVcV9zqjymm+mqBBc9E0hyxbvLt/5zECwuud
 WskesbwKEZeUPi4qDWTGfvelQ7Mbk0QGyDuquyJQ3ntFDhp/lse6Sw8QIzyeSR4Mp4K0RI5
 3IMq+zrwQWzlz0l1alOlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2dBoxq95n/k=:EyiRHWaTFEAf/IY18g9ikv
 H/iA9dYpv9H1mJzmBoKp9RGgVOMX5Vj+z37QiR8EDufglf7bYEV+yyui2/lj78Cn1kgZH55zx
 LU6FVk+ZXKUj/2WBiVW/Do7Jo9r50D4irGNqdwaS4xi9LzkovwSFxzuMk+y7g9WTAmcnF/htO
 FUYFLsejTtGwI5Kppn+TOBf4HYyhNIWain9sLBq/6IjIuS3KWQP/NVqSRwVxasGg7RiBTgYCZ
 k1dcb0z0acCIVK+SriFboKcF0LmUpZktY+CxFtKb4ERIt0vB2PpuDt/p56IiDrz1Hkzchcz84
 g/27cfrb/zlvTJ1Zu/krSC+EmFhCTOo33p4fb83SVzL5tPh1A8R4ZmmyzUYRuK7vdoS7wTKTe
 whmRAz/6XOWjYiAU/kESSgyOb9P4uVeUEa0nUV2wi8slFqwzeVawzM8tdkyOMYhAYwY0bfK7o
 XrfFAuCQpwuZqzI1Gul87DFUP8/F0kzsz9lR7Gj3Qkb1c61El7ePAqP6xFi/mwZt0VKwO+fhE
 W/tsgKgduovWmXmtG744AYLSUGlqsM0HcwtNvQOZRL5z5+dPYrjeKoEXyCYgVsGuz/psxYG8T
 WWbMltzhckD6NRz4NPx3McHF89ero7gPjg7YSocOzNuH/ONTA8tII1zQwvXngneEr3bvUjTbQ
 eogRkNpDQWJn9RWUIVWLnu9+GsPIWDTopVmlRyDz+GpzVDTlReJ/H1OAMTRq+DSYIWrRVw+eZ
 ENQvz9QyLCvClxg4C4+WnKNnx6szMq53o60q52f/h6UY9WnluE8656X2bhgn80lUJCF6WrOGQ
 2uxDhLIdzkJk2LgrSz98p9C/dzfgblgufzRWnk56sT5LDBWTPlpf+saBjMnY69l8Nws4v0UCB
 uDUu9rHu4NCI+3lJlYOY2lbaJMY378FyxSncAIpKdXeVAOFLxCcxNkNYLmkOp6Yvw1HOKdcA1
 ry/H8yyfkR77YVBxNSQoHztzKi/VwrKpC1avZ1KRqXPsoalg1Rwab7Bvuj6iDNUCK7waToSlF
 plNj7YZOs1g7MZ+/NwZ5QTPAMkx37bsfaYiB8iaDQO/1Mvf3m+NMtOqiXjomHiUpvrYx5VYP5
 TBEvXFiqP/2oA2eth5yQwlRhw4hti4mzuiETQ8fM+OrDqlJPNXUB4fomfYrSWZbeM+Kwqng2t
 7DuAowsJW6Ek1sWc8KGkltgY6gPWcW/BjZMSlCh5mnMep7H8bbIhDLHMVQUnYDaMDeOpiSKEM
 FNSrcDMy3YoYtei86ssOoRYV1pXV2mkzmu8fgk1C/tXszGOjNOEW/DmSXTSw=
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2019/10/30 =E4=B8=8A=E5=8D=882:20, David Sterba wrote:
> The type name is misleading, a single entry is named 'cache' while this
> normally means a collection of objects. Rename that everywhere. Also the
> identifier was quite long, making function prototypes harder to format.

Looks good to me, the _cache suffix doesn't mean anything.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

>
> Suggested-by: Nikolay Borisov <nborisov@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>
> To avoid conflicts with patches pending for the upcoming merge window,
> I'm going to apply it among the last ones.
>
>  fs/btrfs/block-group.c                 | 126 ++++++++++++-------------
>  fs/btrfs/block-group.h                 |  45 +++++----
>  fs/btrfs/ctree.h                       |  14 +--
>  fs/btrfs/disk-io.c                     |   8 +-
>  fs/btrfs/extent-tree.c                 |  67 +++++++------
>  fs/btrfs/free-space-cache.c            |  71 +++++++-------
>  fs/btrfs/free-space-cache.h            |  39 ++++----
>  fs/btrfs/free-space-tree.c             |  50 +++++-----
>  fs/btrfs/free-space-tree.h             |  18 ++--
>  fs/btrfs/inode.c                       |   4 +-
>  fs/btrfs/ioctl.c                       |   2 +-
>  fs/btrfs/qgroup.c                      |   2 +-
>  fs/btrfs/qgroup.h                      |   2 +-
>  fs/btrfs/reada.c                       |   2 +-
>  fs/btrfs/relocation.c                  |  13 ++-
>  fs/btrfs/scrub.c                       |  11 +--
>  fs/btrfs/space-info.c                  |   2 +-
>  fs/btrfs/sysfs.c                       |   4 +-
>  fs/btrfs/sysfs.h                       |   2 +-
>  fs/btrfs/tests/btrfs-tests.c           |   6 +-
>  fs/btrfs/tests/btrfs-tests.h           |   4 +-
>  fs/btrfs/tests/free-space-tests.c      |  15 ++-
>  fs/btrfs/tests/free-space-tree-tests.c |  26 ++---
>  fs/btrfs/transaction.c                 |   6 +-
>  fs/btrfs/volumes.c                     |   6 +-
>  include/trace/events/btrfs.h           |  24 ++---
>  26 files changed, 277 insertions(+), 292 deletions(-)
>
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 1e521db3ef56..e5e03c151ea3 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -120,12 +120,12 @@ u64 btrfs_get_alloc_profile(struct btrfs_fs_info *=
fs_info, u64 orig_flags)
>  	return get_alloc_profile(fs_info, orig_flags);
>  }
>
> -void btrfs_get_block_group(struct btrfs_block_group_cache *cache)
> +void btrfs_get_block_group(struct btrfs_block_group *cache)
>  {
>  	atomic_inc(&cache->count);
>  }
>
> -void btrfs_put_block_group(struct btrfs_block_group_cache *cache)
> +void btrfs_put_block_group(struct btrfs_block_group *cache)
>  {
>  	if (atomic_dec_and_test(&cache->count)) {
>  		WARN_ON(cache->pinned > 0);
> @@ -149,19 +149,18 @@ void btrfs_put_block_group(struct btrfs_block_grou=
p_cache *cache)
>   * This adds the block group to the fs_info rb tree for the block group=
 cache
>   */
>  static int btrfs_add_block_group_cache(struct btrfs_fs_info *info,
> -				struct btrfs_block_group_cache *block_group)
> +				       struct btrfs_block_group *block_group)
>  {
>  	struct rb_node **p;
>  	struct rb_node *parent =3D NULL;
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>
>  	spin_lock(&info->block_group_cache_lock);
>  	p =3D &info->block_group_cache_tree.rb_node;
>
>  	while (*p) {
>  		parent =3D *p;
> -		cache =3D rb_entry(parent, struct btrfs_block_group_cache,
> -				 cache_node);
> +		cache =3D rb_entry(parent, struct btrfs_block_group, cache_node);
>  		if (block_group->start < cache->start) {
>  			p =3D &(*p)->rb_left;
>  		} else if (block_group->start > cache->start) {
> @@ -188,10 +187,10 @@ static int btrfs_add_block_group_cache(struct btrf=
s_fs_info *info,
>   * This will return the block group at or after bytenr if contains is 0=
, else
>   * it will return the block group that contains the bytenr
>   */
> -static struct btrfs_block_group_cache *block_group_cache_tree_search(
> +static struct btrfs_block_group *block_group_cache_tree_search(
>  		struct btrfs_fs_info *info, u64 bytenr, int contains)
>  {
> -	struct btrfs_block_group_cache *cache, *ret =3D NULL;
> +	struct btrfs_block_group *cache, *ret =3D NULL;
>  	struct rb_node *n;
>  	u64 end, start;
>
> @@ -199,8 +198,7 @@ static struct btrfs_block_group_cache *block_group_c=
ache_tree_search(
>  	n =3D info->block_group_cache_tree.rb_node;
>
>  	while (n) {
> -		cache =3D rb_entry(n, struct btrfs_block_group_cache,
> -				 cache_node);
> +		cache =3D rb_entry(n, struct btrfs_block_group, cache_node);
>  		end =3D cache->start + cache->length - 1;
>  		start =3D cache->start;
>
> @@ -232,7 +230,7 @@ static struct btrfs_block_group_cache *block_group_c=
ache_tree_search(
>  /*
>   * Return the block group that starts at or after bytenr
>   */
> -struct btrfs_block_group_cache *btrfs_lookup_first_block_group(
> +struct btrfs_block_group *btrfs_lookup_first_block_group(
>  		struct btrfs_fs_info *info, u64 bytenr)
>  {
>  	return block_group_cache_tree_search(info, bytenr, 0);
> @@ -241,14 +239,14 @@ struct btrfs_block_group_cache *btrfs_lookup_first=
_block_group(
>  /*
>   * Return the block group that contains the given bytenr
>   */
> -struct btrfs_block_group_cache *btrfs_lookup_block_group(
> +struct btrfs_block_group *btrfs_lookup_block_group(
>  		struct btrfs_fs_info *info, u64 bytenr)
>  {
>  	return block_group_cache_tree_search(info, bytenr, 1);
>  }
>
> -struct btrfs_block_group_cache *btrfs_next_block_group(
> -		struct btrfs_block_group_cache *cache)
> +struct btrfs_block_group *btrfs_next_block_group(
> +		struct btrfs_block_group *cache)
>  {
>  	struct btrfs_fs_info *fs_info =3D cache->fs_info;
>  	struct rb_node *node;
> @@ -266,8 +264,7 @@ struct btrfs_block_group_cache *btrfs_next_block_gro=
up(
>  	node =3D rb_next(&cache->cache_node);
>  	btrfs_put_block_group(cache);
>  	if (node) {
> -		cache =3D rb_entry(node, struct btrfs_block_group_cache,
> -				 cache_node);
> +		cache =3D rb_entry(node, struct btrfs_block_group, cache_node);
>  		btrfs_get_block_group(cache);
>  	} else
>  		cache =3D NULL;
> @@ -277,7 +274,7 @@ struct btrfs_block_group_cache *btrfs_next_block_gro=
up(
>
>  bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr)
>  {
> -	struct btrfs_block_group_cache *bg;
> +	struct btrfs_block_group *bg;
>  	bool ret =3D true;
>
>  	bg =3D btrfs_lookup_block_group(fs_info, bytenr);
> @@ -300,7 +297,7 @@ bool btrfs_inc_nocow_writers(struct btrfs_fs_info *f=
s_info, u64 bytenr)
>
>  void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr)
>  {
> -	struct btrfs_block_group_cache *bg;
> +	struct btrfs_block_group *bg;
>
>  	bg =3D btrfs_lookup_block_group(fs_info, bytenr);
>  	ASSERT(bg);
> @@ -314,7 +311,7 @@ void btrfs_dec_nocow_writers(struct btrfs_fs_info *f=
s_info, u64 bytenr)
>  	btrfs_put_block_group(bg);
>  }
>
> -void btrfs_wait_nocow_writers(struct btrfs_block_group_cache *bg)
> +void btrfs_wait_nocow_writers(struct btrfs_block_group *bg)
>  {
>  	wait_var_event(&bg->nocow_writers, !atomic_read(&bg->nocow_writers));
>  }
> @@ -322,7 +319,7 @@ void btrfs_wait_nocow_writers(struct btrfs_block_gro=
up_cache *bg)
>  void btrfs_dec_block_group_reservations(struct btrfs_fs_info *fs_info,
>  					const u64 start)
>  {
> -	struct btrfs_block_group_cache *bg;
> +	struct btrfs_block_group *bg;
>
>  	bg =3D btrfs_lookup_block_group(fs_info, start);
>  	ASSERT(bg);
> @@ -331,7 +328,7 @@ void btrfs_dec_block_group_reservations(struct btrfs=
_fs_info *fs_info,
>  	btrfs_put_block_group(bg);
>  }
>
> -void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache=
 *bg)
> +void btrfs_wait_block_group_reservations(struct btrfs_block_group *bg)
>  {
>  	struct btrfs_space_info *space_info =3D bg->space_info;
>
> @@ -357,7 +354,7 @@ void btrfs_wait_block_group_reservations(struct btrf=
s_block_group_cache *bg)
>  }
>
>  struct btrfs_caching_control *btrfs_get_caching_control(
> -		struct btrfs_block_group_cache *cache)
> +		struct btrfs_block_group *cache)
>  {
>  	struct btrfs_caching_control *ctl;
>
> @@ -392,7 +389,7 @@ void btrfs_put_caching_control(struct btrfs_caching_=
control *ctl)
>   * Callers of this must check if cache->cached =3D=3D BTRFS_CACHE_ERROR=
 before using
>   * any of the information in this block group.
>   */
> -void btrfs_wait_block_group_cache_progress(struct btrfs_block_group_cac=
he *cache,
> +void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *ca=
che,
>  					   u64 num_bytes)
>  {
>  	struct btrfs_caching_control *caching_ctl;
> @@ -401,13 +398,13 @@ void btrfs_wait_block_group_cache_progress(struct =
btrfs_block_group_cache *cache
>  	if (!caching_ctl)
>  		return;
>
> -	wait_event(caching_ctl->wait, btrfs_block_group_cache_done(cache) ||
> +	wait_event(caching_ctl->wait, btrfs_block_group_done(cache) ||
>  		   (cache->free_space_ctl->free_space >=3D num_bytes));
>
>  	btrfs_put_caching_control(caching_ctl);
>  }
>
> -int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *c=
ache)
> +int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache)
>  {
>  	struct btrfs_caching_control *caching_ctl;
>  	int ret =3D 0;
> @@ -416,7 +413,7 @@ int btrfs_wait_block_group_cache_done(struct btrfs_b=
lock_group_cache *cache)
>  	if (!caching_ctl)
>  		return (cache->cached =3D=3D BTRFS_CACHE_ERROR) ? -EIO : 0;
>
> -	wait_event(caching_ctl->wait, btrfs_block_group_cache_done(cache));
> +	wait_event(caching_ctl->wait, btrfs_block_group_done(cache));
>  	if (cache->cached =3D=3D BTRFS_CACHE_ERROR)
>  		ret =3D -EIO;
>  	btrfs_put_caching_control(caching_ctl);
> @@ -424,7 +421,7 @@ int btrfs_wait_block_group_cache_done(struct btrfs_b=
lock_group_cache *cache)
>  }
>
>  #ifdef CONFIG_BTRFS_DEBUG
> -static void fragment_free_space(struct btrfs_block_group_cache *block_g=
roup)
> +static void fragment_free_space(struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>  	u64 start =3D block_group->start;
> @@ -450,8 +447,7 @@ static void fragment_free_space(struct btrfs_block_g=
roup_cache *block_group)
>   * used yet since their free space will be released as soon as the tran=
saction
>   * commits.
>   */
> -u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
> -		       u64 start, u64 end)
> +u64 add_new_free_space(struct btrfs_block_group *block_group, u64 start=
, u64 end)
>  {
>  	struct btrfs_fs_info *info =3D block_group->fs_info;
>  	u64 extent_start, extent_end, size, total_added =3D 0;
> @@ -491,7 +487,7 @@ u64 add_new_free_space(struct btrfs_block_group_cach=
e *block_group,
>
>  static int load_extent_tree_free(struct btrfs_caching_control *caching_=
ctl)
>  {
> -	struct btrfs_block_group_cache *block_group =3D caching_ctl->block_gro=
up;
> +	struct btrfs_block_group *block_group =3D caching_ctl->block_group;
>  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>  	struct btrfs_root *extent_root =3D fs_info->extent_root;
>  	struct btrfs_path *path;
> @@ -626,7 +622,7 @@ static int load_extent_tree_free(struct btrfs_cachin=
g_control *caching_ctl)
>
>  static noinline void caching_thread(struct btrfs_work *work)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_fs_info *fs_info;
>  	struct btrfs_caching_control *caching_ctl;
>  	int ret;
> @@ -674,8 +670,7 @@ static noinline void caching_thread(struct btrfs_wor=
k *work)
>  	btrfs_put_block_group(block_group);
>  }
>
> -int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
> -			    int load_cache_only)
> +int btrfs_cache_block_group(struct btrfs_block_group *cache, int load_c=
ache_only)
>  {
>  	DEFINE_WAIT(wait);
>  	struct btrfs_fs_info *fs_info =3D cache->fs_info;
> @@ -858,7 +853,7 @@ int btrfs_remove_block_group(struct btrfs_trans_hand=
le *trans,
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>  	struct btrfs_root *root =3D fs_info->extent_root;
>  	struct btrfs_path *path;
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_free_cluster *cluster;
>  	struct btrfs_root *tree_root =3D fs_info->tree_root;
>  	struct btrfs_key key;
> @@ -1176,7 +1171,7 @@ struct btrfs_trans_handle *btrfs_start_trans_remov=
e_block_group(
>   * data in this block group. That check should be done by relocation ro=
utine,
>   * not this function.
>   */
> -static int inc_block_group_ro(struct btrfs_block_group_cache *cache, in=
t force)
> +static int inc_block_group_ro(struct btrfs_block_group *cache, int forc=
e)
>  {
>  	struct btrfs_space_info *sinfo =3D cache->space_info;
>  	u64 num_bytes;
> @@ -1242,7 +1237,7 @@ static int inc_block_group_ro(struct btrfs_block_g=
roup_cache *cache, int force)
>   */
>  void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_space_info *space_info;
>  	struct btrfs_trans_handle *trans;
>  	int ret =3D 0;
> @@ -1256,7 +1251,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info =
*fs_info)
>  		int trimming;
>
>  		block_group =3D list_first_entry(&fs_info->unused_bgs,
> -					       struct btrfs_block_group_cache,
> +					       struct btrfs_block_group,
>  					       bg_list);
>  		list_del_init(&block_group->bg_list);
>
> @@ -1404,7 +1399,7 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info =
*fs_info)
>  	spin_unlock(&fs_info->unused_bgs_lock);
>  }
>
> -void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg)
> +void btrfs_mark_bg_unused(struct btrfs_block_group *bg)
>  {
>  	struct btrfs_fs_info *fs_info =3D bg->fs_info;
>
> @@ -1512,7 +1507,7 @@ static void set_avail_alloc_bits(struct btrfs_fs_i=
nfo *fs_info, u64 flags)
>  	write_sequnlock(&fs_info->profiles_lock);
>  }
>
> -static int exclude_super_stripes(struct btrfs_block_group_cache *cache)
> +static int exclude_super_stripes(struct btrfs_block_group *cache)
>  {
>  	struct btrfs_fs_info *fs_info =3D cache->fs_info;
>  	u64 bytenr;
> @@ -1567,7 +1562,7 @@ static int exclude_super_stripes(struct btrfs_bloc=
k_group_cache *cache)
>  	return 0;
>  }
>
> -static void link_block_group(struct btrfs_block_group_cache *cache)
> +static void link_block_group(struct btrfs_block_group *cache)
>  {
>  	struct btrfs_space_info *space_info =3D cache->space_info;
>  	int index =3D btrfs_bg_flags_to_raid_index(cache->flags);
> @@ -1583,10 +1578,10 @@ static void link_block_group(struct btrfs_block_=
group_cache *cache)
>  		btrfs_sysfs_add_block_group_type(cache);
>  }
>
> -static struct btrfs_block_group_cache *btrfs_create_block_group_cache(
> +static struct btrfs_block_group *btrfs_create_block_group_cache(
>  		struct btrfs_fs_info *fs_info, u64 start, u64 size)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>
>  	cache =3D kzalloc(sizeof(*cache), GFP_NOFS);
>  	if (!cache)
> @@ -1631,7 +1626,7 @@ static int check_chunk_block_group_mappings(struct=
 btrfs_fs_info *fs_info)
>  {
>  	struct extent_map_tree *map_tree =3D &fs_info->mapping_tree;
>  	struct extent_map *em;
> -	struct btrfs_block_group_cache *bg;
> +	struct btrfs_block_group *bg;
>  	u64 start =3D 0;
>  	int ret =3D 0;
>
> @@ -1681,7 +1676,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
info)
>  {
>  	struct btrfs_path *path;
>  	int ret;
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	struct btrfs_space_info *space_info;
>  	struct btrfs_key key;
>  	struct btrfs_key found_key;
> @@ -1855,7 +1850,7 @@ int btrfs_read_block_groups(struct btrfs_fs_info *=
info)
>  void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans=
)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_root *extent_root =3D fs_info->extent_root;
>  	struct btrfs_block_group_item item;
>  	struct btrfs_key key;
> @@ -1866,7 +1861,7 @@ void btrfs_create_pending_block_groups(struct btrf=
s_trans_handle *trans)
>
>  	while (!list_empty(&trans->new_bgs)) {
>  		block_group =3D list_first_entry(&trans->new_bgs,
> -					       struct btrfs_block_group_cache,
> +					       struct btrfs_block_group,
>  					       bg_list);
>  		if (ret)
>  			goto next;
> @@ -1901,7 +1896,7 @@ int btrfs_make_block_group(struct btrfs_trans_hand=
le *trans, u64 bytes_used,
>  			   u64 type, u64 chunk_offset, u64 size)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	int ret;
>
>  	btrfs_set_log_full_commit(trans);
> @@ -2017,7 +2012,7 @@ static u64 update_block_group_flags(struct btrfs_f=
s_info *fs_info, u64 flags)
>  	return flags;
>  }
>
> -int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache)
> +int btrfs_inc_block_group_ro(struct btrfs_block_group *cache)
>
>  {
>  	struct btrfs_fs_info *fs_info =3D cache->fs_info;
> @@ -2087,7 +2082,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_gr=
oup_cache *cache)
>  	return ret;
>  }
>
> -void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache)
> +void btrfs_dec_block_group_ro(struct btrfs_block_group *cache)
>  {
>  	struct btrfs_space_info *sinfo =3D cache->space_info;
>  	u64 num_bytes;
> @@ -2108,7 +2103,7 @@ void btrfs_dec_block_group_ro(struct btrfs_block_g=
roup_cache *cache)
>
>  static int write_one_cache_group(struct btrfs_trans_handle *trans,
>  				 struct btrfs_path *path,
> -				 struct btrfs_block_group_cache *cache)
> +				 struct btrfs_block_group *cache)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>  	int ret;
> @@ -2143,7 +2138,7 @@ static int write_one_cache_group(struct btrfs_tran=
s_handle *trans,
>
>  }
>
> -static int cache_save_setup(struct btrfs_block_group_cache *block_group=
,
> +static int cache_save_setup(struct btrfs_block_group *block_group,
>  			    struct btrfs_trans_handle *trans,
>  			    struct btrfs_path *path)
>  {
> @@ -2307,7 +2302,7 @@ static int cache_save_setup(struct btrfs_block_gro=
up_cache *block_group,
>  int btrfs_setup_space_cache(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_block_group_cache *cache, *tmp;
> +	struct btrfs_block_group *cache, *tmp;
>  	struct btrfs_transaction *cur_trans =3D trans->transaction;
>  	struct btrfs_path *path;
>
> @@ -2345,7 +2340,7 @@ int btrfs_setup_space_cache(struct btrfs_trans_han=
dle *trans)
>  int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	struct btrfs_transaction *cur_trans =3D trans->transaction;
>  	int ret =3D 0;
>  	int should_put;
> @@ -2382,8 +2377,7 @@ int btrfs_start_dirty_block_groups(struct btrfs_tr=
ans_handle *trans)
>  	while (!list_empty(&dirty)) {
>  		bool drop_reserve =3D true;
>
> -		cache =3D list_first_entry(&dirty,
> -					 struct btrfs_block_group_cache,
> +		cache =3D list_first_entry(&dirty, struct btrfs_block_group,
>  					 dirty_list);
>  		/*
>  		 * This can happen if something re-dirties a block group that
> @@ -2508,7 +2502,7 @@ int btrfs_start_dirty_block_groups(struct btrfs_tr=
ans_handle *trans)
>  int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	struct btrfs_transaction *cur_trans =3D trans->transaction;
>  	int ret =3D 0;
>  	int should_put;
> @@ -2538,7 +2532,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_tr=
ans_handle *trans)
>  	spin_lock(&cur_trans->dirty_bgs_lock);
>  	while (!list_empty(&cur_trans->dirty_bgs)) {
>  		cache =3D list_first_entry(&cur_trans->dirty_bgs,
> -					 struct btrfs_block_group_cache,
> +					 struct btrfs_block_group,
>  					 dirty_list);
>
>  		/*
> @@ -2620,7 +2614,7 @@ int btrfs_write_dirty_block_groups(struct btrfs_tr=
ans_handle *trans)
>  	 * to use it without any locking
>  	 */
>  	while (!list_empty(io)) {
> -		cache =3D list_first_entry(io, struct btrfs_block_group_cache,
> +		cache =3D list_first_entry(io, struct btrfs_block_group,
>  					 io_list);
>  		list_del_init(&cache->io_list);
>  		btrfs_wait_cache_io(trans, cache, path);
> @@ -2635,7 +2629,7 @@ int btrfs_update_block_group(struct btrfs_trans_ha=
ndle *trans,
>  			     u64 bytenr, u64 num_bytes, int alloc)
>  {
>  	struct btrfs_fs_info *info =3D trans->fs_info;
> -	struct btrfs_block_group_cache *cache =3D NULL;
> +	struct btrfs_block_group *cache =3D NULL;
>  	u64 total =3D num_bytes;
>  	u64 old_val;
>  	u64 byte_in_group;
> @@ -2666,7 +2660,7 @@ int btrfs_update_block_group(struct btrfs_trans_ha=
ndle *trans,
>  		 * is because we need the unpinning stage to actually add the
>  		 * space back to the block group, otherwise we will leak space.
>  		 */
> -		if (!alloc && !btrfs_block_group_cache_done(cache))
> +		if (!alloc && !btrfs_block_group_done(cache))
>  			btrfs_cache_block_group(cache, 1);
>
>  		byte_in_group =3D bytenr - cache->start;
> @@ -2750,7 +2744,7 @@ int btrfs_update_block_group(struct btrfs_trans_ha=
ndle *trans,
>   * reservation and the block group has become read only we cannot make =
the
>   * reservation and return -EAGAIN, otherwise this function always succe=
eds.
>   */
> -int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
> +int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
>  			     u64 ram_bytes, u64 num_bytes, int delalloc)
>  {
>  	struct btrfs_space_info *space_info =3D cache->space_info;
> @@ -2786,7 +2780,7 @@ int btrfs_add_reserved_bytes(struct btrfs_block_gr=
oup_cache *cache,
>   * A and before transaction A commits you free that leaf, you call this=
 with
>   * reserve set to 0 in order to clear the reservation.
>   */
> -void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
> +void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
>  			       u64 num_bytes, int delalloc)
>  {
>  	struct btrfs_space_info *space_info =3D cache->space_info;
> @@ -3049,7 +3043,7 @@ void check_system_chunk(struct btrfs_trans_handle =
*trans, u64 type)
>
>  void btrfs_put_block_group_cache(struct btrfs_fs_info *info)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	u64 last =3D 0;
>
>  	while (1) {
> @@ -3089,7 +3083,7 @@ void btrfs_put_block_group_cache(struct btrfs_fs_i=
nfo *info)
>   */
>  int btrfs_free_block_groups(struct btrfs_fs_info *info)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_space_info *space_info;
>  	struct btrfs_caching_control *caching_ctl;
>  	struct rb_node *n;
> @@ -3106,7 +3100,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *=
info)
>  	spin_lock(&info->unused_bgs_lock);
>  	while (!list_empty(&info->unused_bgs)) {
>  		block_group =3D list_first_entry(&info->unused_bgs,
> -					       struct btrfs_block_group_cache,
> +					       struct btrfs_block_group,
>  					       bg_list);
>  		list_del_init(&block_group->bg_list);
>  		btrfs_put_block_group(block_group);
> @@ -3115,7 +3109,7 @@ int btrfs_free_block_groups(struct btrfs_fs_info *=
info)
>
>  	spin_lock(&info->block_group_cache_lock);
>  	while ((n =3D rb_last(&info->block_group_cache_tree)) !=3D NULL) {
> -		block_group =3D rb_entry(n, struct btrfs_block_group_cache,
> +		block_group =3D rb_entry(n, struct btrfs_block_group,
>  				       cache_node);
>  		rb_erase(&block_group->cache_node,
>  			 &info->block_group_cache_tree);
> diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
> index 2ea580352aff..4e7afc028791 100644
> --- a/fs/btrfs/block-group.h
> +++ b/fs/btrfs/block-group.h
> @@ -34,7 +34,7 @@ struct btrfs_caching_control {
>  	struct mutex mutex;
>  	wait_queue_head_t wait;
>  	struct btrfs_work work;
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	u64 progress;
>  	refcount_t count;
>  };
> @@ -42,7 +42,7 @@ struct btrfs_caching_control {
>  /* Once caching_thread() finds this much free space, it will wake up wa=
iters. */
>  #define CACHING_CTL_WAKE_UP SZ_2M
>
> -struct btrfs_block_group_cache {
> +struct btrfs_block_group {
>  	struct btrfs_fs_info *fs_info;
>  	struct inode *inode;
>  	spinlock_t lock;
> @@ -160,7 +160,7 @@ struct btrfs_block_group_cache {
>
>  #ifdef CONFIG_BTRFS_DEBUG
>  static inline int btrfs_should_fragment_free_space(
> -		struct btrfs_block_group_cache *block_group)
> +		struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>
> @@ -171,29 +171,29 @@ static inline int btrfs_should_fragment_free_space=
(
>  }
>  #endif
>
> -struct btrfs_block_group_cache *btrfs_lookup_first_block_group(
> +struct btrfs_block_group *btrfs_lookup_first_block_group(
>  		struct btrfs_fs_info *info, u64 bytenr);
> -struct btrfs_block_group_cache *btrfs_lookup_block_group(
> +struct btrfs_block_group *btrfs_lookup_block_group(
>  		struct btrfs_fs_info *info, u64 bytenr);
> -struct btrfs_block_group_cache *btrfs_next_block_group(
> -		struct btrfs_block_group_cache *cache);
> -void btrfs_get_block_group(struct btrfs_block_group_cache *cache);
> -void btrfs_put_block_group(struct btrfs_block_group_cache *cache);
> +struct btrfs_block_group *btrfs_next_block_group(
> +		struct btrfs_block_group *cache);
> +void btrfs_get_block_group(struct btrfs_block_group *cache);
> +void btrfs_put_block_group(struct btrfs_block_group *cache);
>  void btrfs_dec_block_group_reservations(struct btrfs_fs_info *fs_info,
>  					const u64 start);
> -void btrfs_wait_block_group_reservations(struct btrfs_block_group_cache=
 *bg);
> +void btrfs_wait_block_group_reservations(struct btrfs_block_group *bg);
>  bool btrfs_inc_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr)=
;
>  void btrfs_dec_nocow_writers(struct btrfs_fs_info *fs_info, u64 bytenr)=
;
> -void btrfs_wait_nocow_writers(struct btrfs_block_group_cache *bg);
> -void btrfs_wait_block_group_cache_progress(struct btrfs_block_group_cac=
he *cache,
> +void btrfs_wait_nocow_writers(struct btrfs_block_group *bg);
> +void btrfs_wait_block_group_cache_progress(struct btrfs_block_group *ca=
che,
>  				           u64 num_bytes);
> -int btrfs_wait_block_group_cache_done(struct btrfs_block_group_cache *c=
ache);
> -int btrfs_cache_block_group(struct btrfs_block_group_cache *cache,
> +int btrfs_wait_block_group_cache_done(struct btrfs_block_group *cache);
> +int btrfs_cache_block_group(struct btrfs_block_group *cache,
>  			    int load_cache_only);
>  void btrfs_put_caching_control(struct btrfs_caching_control *ctl);
>  struct btrfs_caching_control *btrfs_get_caching_control(
> -		struct btrfs_block_group_cache *cache);
> -u64 add_new_free_space(struct btrfs_block_group_cache *block_group,
> +		struct btrfs_block_group *cache);
> +u64 add_new_free_space(struct btrfs_block_group *block_group,
>  		       u64 start, u64 end);
>  struct btrfs_trans_handle *btrfs_start_trans_remove_block_group(
>  				struct btrfs_fs_info *fs_info,
> @@ -201,21 +201,21 @@ struct btrfs_trans_handle *btrfs_start_trans_remov=
e_block_group(
>  int btrfs_remove_block_group(struct btrfs_trans_handle *trans,
>  			     u64 group_start, struct extent_map *em);
>  void btrfs_delete_unused_bgs(struct btrfs_fs_info *fs_info);
> -void btrfs_mark_bg_unused(struct btrfs_block_group_cache *bg);
> +void btrfs_mark_bg_unused(struct btrfs_block_group *bg);
>  int btrfs_read_block_groups(struct btrfs_fs_info *info);
>  int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_=
used,
>  			   u64 type, u64 chunk_offset, u64 size);
>  void btrfs_create_pending_block_groups(struct btrfs_trans_handle *trans=
);
> -int btrfs_inc_block_group_ro(struct btrfs_block_group_cache *cache);
> -void btrfs_dec_block_group_ro(struct btrfs_block_group_cache *cache);
> +int btrfs_inc_block_group_ro(struct btrfs_block_group *cache);
> +void btrfs_dec_block_group_ro(struct btrfs_block_group *cache);
>  int btrfs_start_dirty_block_groups(struct btrfs_trans_handle *trans);
>  int btrfs_write_dirty_block_groups(struct btrfs_trans_handle *trans);
>  int btrfs_setup_space_cache(struct btrfs_trans_handle *trans);
>  int btrfs_update_block_group(struct btrfs_trans_handle *trans,
>  			     u64 bytenr, u64 num_bytes, int alloc);
> -int btrfs_add_reserved_bytes(struct btrfs_block_group_cache *cache,
> +int btrfs_add_reserved_bytes(struct btrfs_block_group *cache,
>  			     u64 ram_bytes, u64 num_bytes, int delalloc);
> -void btrfs_free_reserved_bytes(struct btrfs_block_group_cache *cache,
> +void btrfs_free_reserved_bytes(struct btrfs_block_group *cache,
>  			       u64 num_bytes, int delalloc);
>  int btrfs_chunk_alloc(struct btrfs_trans_handle *trans, u64 flags,
>  		      enum btrfs_chunk_alloc_enum force);
> @@ -240,8 +240,7 @@ static inline u64 btrfs_system_alloc_profile(struct =
btrfs_fs_info *fs_info)
>  	return btrfs_get_alloc_profile(fs_info, BTRFS_BLOCK_GROUP_SYSTEM);
>  }
>
> -static inline int btrfs_block_group_cache_done(
> -		struct btrfs_block_group_cache *cache)
> +static inline int btrfs_block_group_done(struct btrfs_block_group *cach=
e)
>  {
>  	smp_mb();
>  	return cache->cached =3D=3D BTRFS_CACHE_FINISHED ||
> diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> index 1c8f01eaf27c..f3cc3df5ab6b 100644
> --- a/fs/btrfs/ctree.h
> +++ b/fs/btrfs/ctree.h
> @@ -39,7 +39,7 @@ struct btrfs_transaction;
>  struct btrfs_pending_snapshot;
>  struct btrfs_delayed_ref_root;
>  struct btrfs_space_info;
> -struct btrfs_block_group_cache;
> +struct btrfs_block_group;
>  extern struct kmem_cache *btrfs_trans_handle_cachep;
>  extern struct kmem_cache *btrfs_bit_radix_cachep;
>  extern struct kmem_cache *btrfs_path_cachep;
> @@ -414,7 +414,7 @@ struct btrfs_free_cluster {
>  	/* We did a full search and couldn't create a cluster */
>  	bool fragmented;
>
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	/*
>  	 * when a cluster is allocated from a block group, we put the
>  	 * cluster onto a list in the block group so that it can
> @@ -477,8 +477,8 @@ struct btrfs_swapfile_pin {
>  	void *ptr;
>  	struct inode *inode;
>  	/*
> -	 * If true, ptr points to a struct btrfs_block_group_cache. Otherwise,
> -	 * ptr points to a struct btrfs_device.
> +	 * If true, ptr points to a struct btrfs_block_group. Otherwise, ptr
> +	 * points to a struct btrfs_device.
>  	 */
>  	bool is_block_group;
>  };
> @@ -2400,7 +2400,7 @@ static inline u64 btrfs_calc_metadata_size(struct =
btrfs_fs_info *fs_info,
>
>  int btrfs_add_excluded_extent(struct btrfs_fs_info *fs_info,
>  			      u64 start, u64 num_bytes);
> -void btrfs_free_excluded_extents(struct btrfs_block_group_cache *cache)=
;
> +void btrfs_free_excluded_extents(struct btrfs_block_group *cache);
>  int btrfs_run_delayed_refs(struct btrfs_trans_handle *trans,
>  			   unsigned long count);
>  void btrfs_cleanup_ref_head_accounting(struct btrfs_fs_info *fs_info,
> @@ -2456,8 +2456,8 @@ int btrfs_inc_extent_ref(struct btrfs_trans_handle=
 *trans,
>  			 struct btrfs_ref *generic_ref);
>
>  int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr);
> -void btrfs_get_block_group_trimming(struct btrfs_block_group_cache *cac=
he);
> -void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *cac=
he);
> +void btrfs_get_block_group_trimming(struct btrfs_block_group *cache);
> +void btrfs_put_block_group_trimming(struct btrfs_block_group *cache);
>  void btrfs_clear_space_info_full(struct btrfs_fs_info *info);
>
>  enum btrfs_reserve_flush_enum {
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 4b00eae0403c..e0edfdc9c82b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4406,7 +4406,7 @@ static int btrfs_destroy_pinned_extent(struct btrf=
s_fs_info *fs_info,
>  	return 0;
>  }
>
> -static void btrfs_cleanup_bg_io(struct btrfs_block_group_cache *cache)
> +static void btrfs_cleanup_bg_io(struct btrfs_block_group *cache)
>  {
>  	struct inode *inode;
>
> @@ -4423,12 +4423,12 @@ static void btrfs_cleanup_bg_io(struct btrfs_blo=
ck_group_cache *cache)
>  void btrfs_cleanup_dirty_bgs(struct btrfs_transaction *cur_trans,
>  			     struct btrfs_fs_info *fs_info)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>
>  	spin_lock(&cur_trans->dirty_bgs_lock);
>  	while (!list_empty(&cur_trans->dirty_bgs)) {
>  		cache =3D list_first_entry(&cur_trans->dirty_bgs,
> -					 struct btrfs_block_group_cache,
> +					 struct btrfs_block_group,
>  					 dirty_list);
>
>  		if (!list_empty(&cache->io_list)) {
> @@ -4456,7 +4456,7 @@ void btrfs_cleanup_dirty_bgs(struct btrfs_transact=
ion *cur_trans,
>  	 */
>  	while (!list_empty(&cur_trans->io_bgs)) {
>  		cache =3D list_first_entry(&cur_trans->io_bgs,
> -					 struct btrfs_block_group_cache,
> +					 struct btrfs_block_group,
>  					 io_list);
>
>  		list_del_init(&cache->io_list);
> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
> index b24d116eaf0b..2fa2fd888c09 100644
> --- a/fs/btrfs/extent-tree.c
> +++ b/fs/btrfs/extent-tree.c
> @@ -54,7 +54,7 @@ static int alloc_reserved_tree_block(struct btrfs_tran=
s_handle *trans,
>  static int find_next_key(struct btrfs_path *path, int level,
>  			 struct btrfs_key *key);
>
> -static int block_group_bits(struct btrfs_block_group_cache *cache, u64 =
bits)
> +static int block_group_bits(struct btrfs_block_group *cache, u64 bits)
>  {
>  	return (cache->flags & bits) =3D=3D bits;
>  }
> @@ -70,7 +70,7 @@ int btrfs_add_excluded_extent(struct btrfs_fs_info *fs=
_info,
>  	return 0;
>  }
>
> -void btrfs_free_excluded_extents(struct btrfs_block_group_cache *cache)
> +void btrfs_free_excluded_extents(struct btrfs_block_group *cache)
>  {
>  	struct btrfs_fs_info *fs_info =3D cache->fs_info;
>  	u64 start, end;
> @@ -2516,7 +2516,7 @@ int btrfs_dec_ref(struct btrfs_trans_handle *trans=
, struct btrfs_root *root,
>
>  int btrfs_extent_readonly(struct btrfs_fs_info *fs_info, u64 bytenr)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	int readonly =3D 0;
>
>  	block_group =3D btrfs_lookup_block_group(fs_info, bytenr);
> @@ -2546,7 +2546,7 @@ static u64 get_alloc_profile_by_root(struct btrfs_=
root *root, int data)
>
>  static u64 first_logical_byte(struct btrfs_fs_info *fs_info, u64 search=
_start)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	u64 bytenr;
>
>  	spin_lock(&fs_info->block_group_cache_lock);
> @@ -2566,7 +2566,7 @@ static u64 first_logical_byte(struct btrfs_fs_info=
 *fs_info, u64 search_start)
>  	return bytenr;
>  }
>
> -static int pin_down_extent(struct btrfs_block_group_cache *cache,
> +static int pin_down_extent(struct btrfs_block_group *cache,
>  			   u64 bytenr, u64 num_bytes, int reserved)
>  {
>  	struct btrfs_fs_info *fs_info =3D cache->fs_info;
> @@ -2593,7 +2593,7 @@ static int pin_down_extent(struct btrfs_block_grou=
p_cache *cache,
>  int btrfs_pin_extent(struct btrfs_fs_info *fs_info,
>  		     u64 bytenr, u64 num_bytes, int reserved)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>
>  	ASSERT(fs_info->running_transaction);
>
> @@ -2612,7 +2612,7 @@ int btrfs_pin_extent(struct btrfs_fs_info *fs_info=
,
>  int btrfs_pin_extent_for_log_replay(struct btrfs_fs_info *fs_info,
>  				    u64 bytenr, u64 num_bytes)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	int ret;
>
>  	cache =3D btrfs_lookup_block_group(fs_info, bytenr);
> @@ -2639,7 +2639,7 @@ static int __exclude_logged_extent(struct btrfs_fs=
_info *fs_info,
>  				   u64 start, u64 num_bytes)
>  {
>  	int ret;
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_caching_control *caching_ctl;
>
>  	block_group =3D btrfs_lookup_block_group(fs_info, start);
> @@ -2651,7 +2651,7 @@ static int __exclude_logged_extent(struct btrfs_fs=
_info *fs_info,
>
>  	if (!caching_ctl) {
>  		/* Logic error */
> -		BUG_ON(!btrfs_block_group_cache_done(block_group));
> +		BUG_ON(!btrfs_block_group_done(block_group));
>  		ret =3D btrfs_remove_free_space(block_group, start, num_bytes);
>  	} else {
>  		mutex_lock(&caching_ctl->mutex);
> @@ -2716,7 +2716,7 @@ int btrfs_exclude_logged_extents(struct extent_buf=
fer *eb)
>  }
>
>  static void
> -btrfs_inc_block_group_reservations(struct btrfs_block_group_cache *bg)
> +btrfs_inc_block_group_reservations(struct btrfs_block_group *bg)
>  {
>  	atomic_inc(&bg->reservations);
>  }
> @@ -2725,14 +2725,14 @@ void btrfs_prepare_extent_commit(struct btrfs_fs=
_info *fs_info)
>  {
>  	struct btrfs_caching_control *next;
>  	struct btrfs_caching_control *caching_ctl;
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>
>  	down_write(&fs_info->commit_root_sem);
>
>  	list_for_each_entry_safe(caching_ctl, next,
>  				 &fs_info->caching_block_groups, list) {
>  		cache =3D caching_ctl->block_group;
> -		if (btrfs_block_group_cache_done(cache)) {
> +		if (btrfs_block_group_done(cache)) {
>  			cache->last_byte_to_unpin =3D (u64)-1;
>  			list_del_init(&caching_ctl->list);
>  			btrfs_put_caching_control(caching_ctl);
> @@ -2784,7 +2784,7 @@ static int unpin_extent_range(struct btrfs_fs_info=
 *fs_info,
>  			      u64 start, u64 end,
>  			      const bool return_free_space)
>  {
> -	struct btrfs_block_group_cache *cache =3D NULL;
> +	struct btrfs_block_group *cache =3D NULL;
>  	struct btrfs_space_info *space_info;
>  	struct btrfs_block_rsv *global_rsv =3D &fs_info->global_block_rsv;
>  	struct btrfs_free_cluster *cluster =3D NULL;
> @@ -2879,7 +2879,7 @@ static int unpin_extent_range(struct btrfs_fs_info=
 *fs_info,
>  int btrfs_finish_extent_commit(struct btrfs_trans_handle *trans)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -	struct btrfs_block_group_cache *block_group, *tmp;
> +	struct btrfs_block_group *block_group, *tmp;
>  	struct list_head *deleted_bgs;
>  	struct extent_io_tree *unpin;
>  	u64 start;
> @@ -3261,7 +3261,7 @@ void btrfs_free_tree_block(struct btrfs_trans_hand=
le *trans,
>  	}
>
>  	if (last_ref && btrfs_header_generation(buf) =3D=3D trans->transid) {
> -		struct btrfs_block_group_cache *cache;
> +		struct btrfs_block_group *cache;
>
>  		if (root->root_key.objectid !=3D BTRFS_TREE_LOG_OBJECTID) {
>  			ret =3D check_ref_cleanup(trans, buf->start);
> @@ -3348,15 +3348,14 @@ enum btrfs_loop_type {
>  };
>
>  static inline void
> -btrfs_lock_block_group(struct btrfs_block_group_cache *cache,
> +btrfs_lock_block_group(struct btrfs_block_group *cache,
>  		       int delalloc)
>  {
>  	if (delalloc)
>  		down_read(&cache->data_rwsem);
>  }
>
> -static inline void
> -btrfs_grab_block_group(struct btrfs_block_group_cache *cache,
> +static inline void btrfs_grab_block_group(struct btrfs_block_group *cac=
he,
>  		       int delalloc)
>  {
>  	btrfs_get_block_group(cache);
> @@ -3364,12 +3363,12 @@ btrfs_grab_block_group(struct btrfs_block_group_=
cache *cache,
>  		down_read(&cache->data_rwsem);
>  }
>
> -static struct btrfs_block_group_cache *
> -btrfs_lock_cluster(struct btrfs_block_group_cache *block_group,
> +static struct btrfs_block_group *btrfs_lock_cluster(
> +		   struct btrfs_block_group *block_group,
>  		   struct btrfs_free_cluster *cluster,
>  		   int delalloc)
>  {
> -	struct btrfs_block_group_cache *used_bg =3D NULL;
> +	struct btrfs_block_group *used_bg =3D NULL;
>
>  	spin_lock(&cluster->refill_lock);
>  	while (1) {
> @@ -3403,7 +3402,7 @@ btrfs_lock_cluster(struct btrfs_block_group_cache =
*block_group,
>  }
>
>  static inline void
> -btrfs_release_block_group(struct btrfs_block_group_cache *cache,
> +btrfs_release_block_group(struct btrfs_block_group *cache,
>  			 int delalloc)
>  {
>  	if (delalloc)
> @@ -3474,12 +3473,12 @@ struct find_free_extent_ctl {
>   * Return >0 to inform caller that we find nothing
>   * Return 0 means we have found a location and set ffe_ctl->found_offse=
t.
>   */
> -static int find_free_extent_clustered(struct btrfs_block_group_cache *b=
g,
> +static int find_free_extent_clustered(struct btrfs_block_group *bg,
>  		struct btrfs_free_cluster *last_ptr,
>  		struct find_free_extent_ctl *ffe_ctl,
> -		struct btrfs_block_group_cache **cluster_bg_ret)
> +		struct btrfs_block_group **cluster_bg_ret)
>  {
> -	struct btrfs_block_group_cache *cluster_bg;
> +	struct btrfs_block_group *cluster_bg;
>  	u64 aligned_cluster;
>  	u64 offset;
>  	int ret;
> @@ -3578,7 +3577,7 @@ static int find_free_extent_clustered(struct btrfs=
_block_group_cache *bg,
>   * Return 0 when we found an free extent and set ffe_ctrl->found_offset
>   * Return -EAGAIN to inform caller that we need to re-search this block=
 group
>   */
> -static int find_free_extent_unclustered(struct btrfs_block_group_cache =
*bg,
> +static int find_free_extent_unclustered(struct btrfs_block_group *bg,
>  		struct btrfs_free_cluster *last_ptr,
>  		struct find_free_extent_ctl *ffe_ctl)
>  {
> @@ -3780,7 +3779,7 @@ static noinline int find_free_extent(struct btrfs_=
fs_info *fs_info,
>  {
>  	int ret =3D 0;
>  	struct btrfs_free_cluster *last_ptr =3D NULL;
> -	struct btrfs_block_group_cache *block_group =3D NULL;
> +	struct btrfs_block_group *block_group =3D NULL;
>  	struct find_free_extent_ctl ffe_ctl =3D {0};
>  	struct btrfs_space_info *space_info;
>  	bool use_cluster =3D true;
> @@ -3934,7 +3933,7 @@ static noinline int find_free_extent(struct btrfs_=
fs_info *fs_info,
>  		}
>
>  have_block_group:
> -		ffe_ctl.cached =3D btrfs_block_group_cache_done(block_group);
> +		ffe_ctl.cached =3D btrfs_block_group_done(block_group);
>  		if (unlikely(!ffe_ctl.cached)) {
>  			ffe_ctl.have_caching_bg =3D true;
>  			ret =3D btrfs_cache_block_group(block_group, 0);
> @@ -3950,7 +3949,7 @@ static noinline int find_free_extent(struct btrfs_=
fs_info *fs_info,
>  		 * lets look there
>  		 */
>  		if (last_ptr && use_cluster) {
> -			struct btrfs_block_group_cache *cluster_bg =3D NULL;
> +			struct btrfs_block_group *cluster_bg =3D NULL;
>
>  			ret =3D find_free_extent_clustered(block_group, last_ptr,
>  							 &ffe_ctl, &cluster_bg);
> @@ -4132,7 +4131,7 @@ static int __btrfs_free_reserved_extent(struct btr=
fs_fs_info *fs_info,
>  					u64 start, u64 len,
>  					int pin, int delalloc)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	int ret =3D 0;
>
>  	cache =3D btrfs_lookup_block_group(fs_info, start);
> @@ -4365,7 +4364,7 @@ int btrfs_alloc_logged_file_extent(struct btrfs_tr=
ans_handle *trans,
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>  	int ret;
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_space_info *space_info;
>
>  	/*
> @@ -5479,7 +5478,7 @@ int btrfs_drop_subtree(struct btrfs_trans_handle *=
trans,
>   */
>  u64 btrfs_account_ro_block_groups_free_space(struct btrfs_space_info *s=
info)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	u64 free_bytes =3D 0;
>  	int factor;
>
> @@ -5621,7 +5620,7 @@ static int btrfs_trim_free_extents(struct btrfs_de=
vice *device, u64 *trimmed)
>   */
>  int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *r=
ange)
>  {
> -	struct btrfs_block_group_cache *cache =3D NULL;
> +	struct btrfs_block_group *cache =3D NULL;
>  	struct btrfs_device *device;
>  	struct list_head *devices;
>  	u64 group_trimmed;
> @@ -5654,7 +5653,7 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, s=
truct fstrim_range *range)
>  		end =3D min(range_end, cache->start + cache->length);
>
>  		if (end - start >=3D range->minlen) {
> -			if (!btrfs_block_group_cache_done(cache)) {
> +			if (!btrfs_block_group_done(cache)) {
>  				ret =3D btrfs_cache_block_group(cache, 0);
>  				if (ret) {
>  					bg_failed++;
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> index 279c41c4ba50..3283da419200 100644
> --- a/fs/btrfs/free-space-cache.c
> +++ b/fs/btrfs/free-space-cache.c
> @@ -91,8 +91,7 @@ static struct inode *__lookup_free_space_inode(struct =
btrfs_root *root,
>  	return inode;
>  }
>
> -struct inode *lookup_free_space_inode(
> -		struct btrfs_block_group_cache *block_group,
> +struct inode *lookup_free_space_inode(struct btrfs_block_group *block_g=
roup,
>  		struct btrfs_path *path)
>  {
>  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
> @@ -190,7 +189,7 @@ static int __create_free_space_inode(struct btrfs_ro=
ot *root,
>  }
>
>  int create_free_space_inode(struct btrfs_trans_handle *trans,
> -			    struct btrfs_block_group_cache *block_group,
> +			    struct btrfs_block_group *block_group,
>  			    struct btrfs_path *path)
>  {
>  	int ret;
> @@ -224,7 +223,7 @@ int btrfs_check_trunc_cache_free_space(struct btrfs_=
fs_info *fs_info,
>  }
>
>  int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
> -				    struct btrfs_block_group_cache *block_group,
> +				    struct btrfs_block_group *block_group,
>  				    struct inode *inode)
>  {
>  	struct btrfs_root *root =3D BTRFS_I(inode)->root;
> @@ -820,7 +819,7 @@ static int __load_free_space_cache(struct btrfs_root=
 *root, struct inode *inode,
>  	goto out;
>  }
>
> -int load_free_space_cache(struct btrfs_block_group_cache *block_group)
> +int load_free_space_cache(struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>  	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
> @@ -919,7 +918,7 @@ int load_free_space_cache(struct btrfs_block_group_c=
ache *block_group)
>  static noinline_for_stack
>  int write_cache_extent_entries(struct btrfs_io_ctl *io_ctl,
>  			      struct btrfs_free_space_ctl *ctl,
> -			      struct btrfs_block_group_cache *block_group,
> +			      struct btrfs_block_group *block_group,
>  			      int *entries, int *bitmaps,
>  			      struct list_head *bitmap_list)
>  {
> @@ -1047,7 +1046,7 @@ update_cache_item(struct btrfs_trans_handle *trans=
,
>  }
>
>  static noinline_for_stack int write_pinned_extent_entries(
> -			    struct btrfs_block_group_cache *block_group,
> +			    struct btrfs_block_group *block_group,
>  			    struct btrfs_io_ctl *io_ctl,
>  			    int *entries)
>  {
> @@ -1146,7 +1145,7 @@ cleanup_write_cache_enospc(struct inode *inode,
>
>  static int __btrfs_wait_cache_io(struct btrfs_root *root,
>  				 struct btrfs_trans_handle *trans,
> -				 struct btrfs_block_group_cache *block_group,
> +				 struct btrfs_block_group *block_group,
>  				 struct btrfs_io_ctl *io_ctl,
>  				 struct btrfs_path *path, u64 offset)
>  {
> @@ -1215,7 +1214,7 @@ static int btrfs_wait_cache_io_root(struct btrfs_r=
oot *root,
>  }
>
>  int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
> -			struct btrfs_block_group_cache *block_group,
> +			struct btrfs_block_group *block_group,
>  			struct btrfs_path *path)
>  {
>  	return __btrfs_wait_cache_io(block_group->fs_info->tree_root, trans,
> @@ -1236,7 +1235,7 @@ int btrfs_wait_cache_io(struct btrfs_trans_handle =
*trans,
>   */
>  static int __btrfs_write_out_cache(struct btrfs_root *root, struct inod=
e *inode,
>  				   struct btrfs_free_space_ctl *ctl,
> -				   struct btrfs_block_group_cache *block_group,
> +				   struct btrfs_block_group *block_group,
>  				   struct btrfs_io_ctl *io_ctl,
>  				   struct btrfs_trans_handle *trans)
>  {
> @@ -1374,7 +1373,7 @@ static int __btrfs_write_out_cache(struct btrfs_ro=
ot *root, struct inode *inode,
>  }
>
>  int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
> -			  struct btrfs_block_group_cache *block_group,
> +			  struct btrfs_block_group *block_group,
>  			  struct btrfs_path *path)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> @@ -1652,7 +1651,7 @@ static int link_free_space(struct btrfs_free_space=
_ctl *ctl,
>
>  static void recalculate_thresholds(struct btrfs_free_space_ctl *ctl)
>  {
> -	struct btrfs_block_group_cache *block_group =3D ctl->private;
> +	struct btrfs_block_group *block_group =3D ctl->private;
>  	u64 max_bytes;
>  	u64 bitmap_bytes;
>  	u64 extent_bytes;
> @@ -1996,7 +1995,7 @@ static u64 add_bytes_to_bitmap(struct btrfs_free_s=
pace_ctl *ctl,
>  static bool use_bitmap(struct btrfs_free_space_ctl *ctl,
>  		      struct btrfs_free_space *info)
>  {
> -	struct btrfs_block_group_cache *block_group =3D ctl->private;
> +	struct btrfs_block_group *block_group =3D ctl->private;
>  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>  	bool forced =3D false;
>
> @@ -2048,7 +2047,7 @@ static int insert_into_bitmap(struct btrfs_free_sp=
ace_ctl *ctl,
>  			      struct btrfs_free_space *info)
>  {
>  	struct btrfs_free_space *bitmap_info;
> -	struct btrfs_block_group_cache *block_group =3D NULL;
> +	struct btrfs_block_group *block_group =3D NULL;
>  	int added =3D 0;
>  	u64 bytes, offset, bytes_added;
>  	int ret;
> @@ -2385,7 +2384,7 @@ int __btrfs_add_free_space(struct btrfs_fs_info *f=
s_info,
>  	return ret;
>  }
>
> -int btrfs_add_free_space(struct btrfs_block_group_cache *block_group,
> +int btrfs_add_free_space(struct btrfs_block_group *block_group,
>  			 u64 bytenr, u64 size)
>  {
>  	return __btrfs_add_free_space(block_group->fs_info,
> @@ -2393,7 +2392,7 @@ int btrfs_add_free_space(struct btrfs_block_group_=
cache *block_group,
>  				      bytenr, size);
>  }
>
> -int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group=
,
> +int btrfs_remove_free_space(struct btrfs_block_group *block_group,
>  			    u64 offset, u64 bytes)
>  {
>  	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
> @@ -2483,7 +2482,7 @@ int btrfs_remove_free_space(struct btrfs_block_gro=
up_cache *block_group,
>  	return ret;
>  }
>
> -void btrfs_dump_free_space(struct btrfs_block_group_cache *block_group,
> +void btrfs_dump_free_space(struct btrfs_block_group *block_group,
>  			   u64 bytes)
>  {
>  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
> @@ -2508,7 +2507,7 @@ void btrfs_dump_free_space(struct btrfs_block_grou=
p_cache *block_group,
>  		   "%d blocks of free space at or bigger than bytes is", count);
>  }
>
> -void btrfs_init_free_space_ctl(struct btrfs_block_group_cache *block_gr=
oup)
> +void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>  	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
> @@ -2537,7 +2536,7 @@ void btrfs_init_free_space_ctl(struct btrfs_block_=
group_cache *block_group)
>   */
>  static int
>  __btrfs_return_cluster_to_free_space(
> -			     struct btrfs_block_group_cache *block_group,
> +			     struct btrfs_block_group *block_group,
>  			     struct btrfs_free_cluster *cluster)
>  {
>  	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
> @@ -2603,7 +2602,7 @@ void __btrfs_remove_free_space_cache(struct btrfs_=
free_space_ctl *ctl)
>  	spin_unlock(&ctl->tree_lock);
>  }
>
> -void btrfs_remove_free_space_cache(struct btrfs_block_group_cache *bloc=
k_group)
> +void btrfs_remove_free_space_cache(struct btrfs_block_group *block_grou=
p)
>  {
>  	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
>  	struct btrfs_free_cluster *cluster;
> @@ -2625,7 +2624,7 @@ void btrfs_remove_free_space_cache(struct btrfs_bl=
ock_group_cache *block_group)
>
>  }
>
> -u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_gr=
oup,
> +u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
>  			       u64 offset, u64 bytes, u64 empty_size,
>  			       u64 *max_extent_size)
>  {
> @@ -2679,7 +2678,7 @@ u64 btrfs_find_space_for_alloc(struct btrfs_block_=
group_cache *block_group,
>   * cluster and remove the cluster from it.
>   */
>  int btrfs_return_cluster_to_free_space(
> -			       struct btrfs_block_group_cache *block_group,
> +			       struct btrfs_block_group *block_group,
>  			       struct btrfs_free_cluster *cluster)
>  {
>  	struct btrfs_free_space_ctl *ctl;
> @@ -2713,7 +2712,7 @@ int btrfs_return_cluster_to_free_space(
>  	return ret;
>  }
>
> -static u64 btrfs_alloc_from_bitmap(struct btrfs_block_group_cache *bloc=
k_group,
> +static u64 btrfs_alloc_from_bitmap(struct btrfs_block_group *block_grou=
p,
>  				   struct btrfs_free_cluster *cluster,
>  				   struct btrfs_free_space *entry,
>  				   u64 bytes, u64 min_start,
> @@ -2746,7 +2745,7 @@ static u64 btrfs_alloc_from_bitmap(struct btrfs_bl=
ock_group_cache *block_group,
>   * if it couldn't find anything suitably large, or a logical disk offse=
t
>   * if things worked out
>   */
> -u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_grou=
p,
> +u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
>  			     struct btrfs_free_cluster *cluster, u64 bytes,
>  			     u64 min_start, u64 *max_extent_size)
>  {
> @@ -2832,7 +2831,7 @@ u64 btrfs_alloc_from_cluster(struct btrfs_block_gr=
oup_cache *block_group,
>  	return ret;
>  }
>
> -static int btrfs_bitmap_cluster(struct btrfs_block_group_cache *block_g=
roup,
> +static int btrfs_bitmap_cluster(struct btrfs_block_group *block_group,
>  				struct btrfs_free_space *entry,
>  				struct btrfs_free_cluster *cluster,
>  				u64 offset, u64 bytes,
> @@ -2914,7 +2913,7 @@ static int btrfs_bitmap_cluster(struct btrfs_block=
_group_cache *block_group,
>   * extent of cont1_bytes, and other clusters of at least min_bytes.
>   */
>  static noinline int
> -setup_cluster_no_bitmap(struct btrfs_block_group_cache *block_group,
> +setup_cluster_no_bitmap(struct btrfs_block_group *block_group,
>  			struct btrfs_free_cluster *cluster,
>  			struct list_head *bitmaps, u64 offset, u64 bytes,
>  			u64 cont1_bytes, u64 min_bytes)
> @@ -3005,7 +3004,7 @@ setup_cluster_no_bitmap(struct btrfs_block_group_c=
ache *block_group,
>   * that we have already failed to find extents that will work.
>   */
>  static noinline int
> -setup_cluster_bitmap(struct btrfs_block_group_cache *block_group,
> +setup_cluster_bitmap(struct btrfs_block_group *block_group,
>  		     struct btrfs_free_cluster *cluster,
>  		     struct list_head *bitmaps, u64 offset, u64 bytes,
>  		     u64 cont1_bytes, u64 min_bytes)
> @@ -3055,7 +3054,7 @@ setup_cluster_bitmap(struct btrfs_block_group_cach=
e *block_group,
>   * returns zero and sets up cluster if things worked out, otherwise
>   * it returns -enospc
>   */
> -int btrfs_find_space_cluster(struct btrfs_block_group_cache *block_grou=
p,
> +int btrfs_find_space_cluster(struct btrfs_block_group *block_group,
>  			     struct btrfs_free_cluster *cluster,
>  			     u64 offset, u64 bytes, u64 empty_size)
>  {
> @@ -3146,7 +3145,7 @@ void btrfs_init_free_cluster(struct btrfs_free_clu=
ster *cluster)
>  	cluster->block_group =3D NULL;
>  }
>
> -static int do_trimming(struct btrfs_block_group_cache *block_group,
> +static int do_trimming(struct btrfs_block_group *block_group,
>  		       u64 *total_trimmed, u64 start, u64 bytes,
>  		       u64 reserved_start, u64 reserved_bytes,
>  		       struct btrfs_trim_range *trim_entry)
> @@ -3191,7 +3190,7 @@ static int do_trimming(struct btrfs_block_group_ca=
che *block_group,
>  	return ret;
>  }
>
> -static int trim_no_bitmap(struct btrfs_block_group_cache *block_group,
> +static int trim_no_bitmap(struct btrfs_block_group *block_group,
>  			  u64 *total_trimmed, u64 start, u64 end, u64 minlen)
>  {
>  	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
> @@ -3276,7 +3275,7 @@ static int trim_no_bitmap(struct btrfs_block_group=
_cache *block_group,
>  	return ret;
>  }
>
> -static int trim_bitmaps(struct btrfs_block_group_cache *block_group,
> +static int trim_bitmaps(struct btrfs_block_group *block_group,
>  			u64 *total_trimmed, u64 start, u64 end, u64 minlen)
>  {
>  	struct btrfs_free_space_ctl *ctl =3D block_group->free_space_ctl;
> @@ -3357,12 +3356,12 @@ static int trim_bitmaps(struct btrfs_block_group=
_cache *block_group,
>  	return ret;
>  }
>
> -void btrfs_get_block_group_trimming(struct btrfs_block_group_cache *cac=
he)
> +void btrfs_get_block_group_trimming(struct btrfs_block_group *cache)
>  {
>  	atomic_inc(&cache->trimming);
>  }
>
> -void btrfs_put_block_group_trimming(struct btrfs_block_group_cache *blo=
ck_group)
> +void btrfs_put_block_group_trimming(struct btrfs_block_group *block_gro=
up)
>  {
>  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>  	struct extent_map_tree *em_tree;
> @@ -3397,7 +3396,7 @@ void btrfs_put_block_group_trimming(struct btrfs_b=
lock_group_cache *block_group)
>  	}
>  }
>
> -int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
> +int btrfs_trim_block_group(struct btrfs_block_group *block_group,
>  			   u64 *trimmed, u64 start, u64 end, u64 minlen)
>  {
>  	int ret;
> @@ -3595,7 +3594,7 @@ int btrfs_write_out_ino_cache(struct btrfs_root *r=
oot,
>   * how the free space cache loading stuff works, so you can get really =
weird
>   * configurations.
>   */
> -int test_add_free_space_entry(struct btrfs_block_group_cache *cache,
> +int test_add_free_space_entry(struct btrfs_block_group *cache,
>  			      u64 offset, u64 bytes, bool bitmap)
>  {
>  	struct btrfs_free_space_ctl *ctl =3D cache->free_space_ctl;
> @@ -3663,7 +3662,7 @@ int test_add_free_space_entry(struct btrfs_block_g=
roup_cache *cache,
>   * just used to check the absence of space, so if there is free space i=
n the
>   * range at all we will return 1.
>   */
> -int test_check_exists(struct btrfs_block_group_cache *cache,
> +int test_check_exists(struct btrfs_block_group *cache,
>  		      u64 offset, u64 bytes)
>  {
>  	struct btrfs_free_space_ctl *ctl =3D cache->free_space_ctl;
> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
> index 39c32c8fc24f..ba9a23241101 100644
> --- a/fs/btrfs/free-space-cache.h
> +++ b/fs/btrfs/free-space-cache.h
> @@ -50,24 +50,23 @@ struct btrfs_io_ctl {
>  	unsigned check_crcs:1;
>  };
>
> -struct inode *lookup_free_space_inode(
> -		struct btrfs_block_group_cache *block_group,
> +struct inode *lookup_free_space_inode(struct btrfs_block_group *block_g=
roup,
>  		struct btrfs_path *path);
>  int create_free_space_inode(struct btrfs_trans_handle *trans,
> -			    struct btrfs_block_group_cache *block_group,
> +			    struct btrfs_block_group *block_group,
>  			    struct btrfs_path *path);
>
>  int btrfs_check_trunc_cache_free_space(struct btrfs_fs_info *fs_info,
>  				       struct btrfs_block_rsv *rsv);
>  int btrfs_truncate_free_space_cache(struct btrfs_trans_handle *trans,
> -				    struct btrfs_block_group_cache *block_group,
> +				    struct btrfs_block_group *block_group,
>  				    struct inode *inode);
> -int load_free_space_cache(struct btrfs_block_group_cache *block_group);
> +int load_free_space_cache(struct btrfs_block_group *block_group);
>  int btrfs_wait_cache_io(struct btrfs_trans_handle *trans,
> -			struct btrfs_block_group_cache *block_group,
> +			struct btrfs_block_group *block_group,
>  			struct btrfs_path *path);
>  int btrfs_write_out_cache(struct btrfs_trans_handle *trans,
> -			  struct btrfs_block_group_cache *block_group,
> +			  struct btrfs_block_group *block_group,
>  			  struct btrfs_path *path);
>  struct inode *lookup_free_ino_inode(struct btrfs_root *root,
>  				    struct btrfs_path *path);
> @@ -81,42 +80,40 @@ int btrfs_write_out_ino_cache(struct btrfs_root *roo=
t,
>  			      struct btrfs_path *path,
>  			      struct inode *inode);
>
> -void btrfs_init_free_space_ctl(struct btrfs_block_group_cache *block_gr=
oup);
> +void btrfs_init_free_space_ctl(struct btrfs_block_group *block_group);
>  int __btrfs_add_free_space(struct btrfs_fs_info *fs_info,
>  			   struct btrfs_free_space_ctl *ctl,
>  			   u64 bytenr, u64 size);
> -int btrfs_add_free_space(struct btrfs_block_group_cache *block_group,
> +int btrfs_add_free_space(struct btrfs_block_group *block_group,
>  			 u64 bytenr, u64 size);
> -int btrfs_remove_free_space(struct btrfs_block_group_cache *block_group=
,
> +int btrfs_remove_free_space(struct btrfs_block_group *block_group,
>  			    u64 bytenr, u64 size);
>  void __btrfs_remove_free_space_cache(struct btrfs_free_space_ctl *ctl);
> -void btrfs_remove_free_space_cache(struct btrfs_block_group_cache
> -				     *block_group);
> -u64 btrfs_find_space_for_alloc(struct btrfs_block_group_cache *block_gr=
oup,
> +void btrfs_remove_free_space_cache(struct btrfs_block_group *block_grou=
p);
> +u64 btrfs_find_space_for_alloc(struct btrfs_block_group *block_group,
>  			       u64 offset, u64 bytes, u64 empty_size,
>  			       u64 *max_extent_size);
>  u64 btrfs_find_ino_for_alloc(struct btrfs_root *fs_root);
> -void btrfs_dump_free_space(struct btrfs_block_group_cache *block_group,
> +void btrfs_dump_free_space(struct btrfs_block_group *block_group,
>  			   u64 bytes);
> -int btrfs_find_space_cluster(struct btrfs_block_group_cache *block_grou=
p,
> +int btrfs_find_space_cluster(struct btrfs_block_group *block_group,
>  			     struct btrfs_free_cluster *cluster,
>  			     u64 offset, u64 bytes, u64 empty_size);
>  void btrfs_init_free_cluster(struct btrfs_free_cluster *cluster);
> -u64 btrfs_alloc_from_cluster(struct btrfs_block_group_cache *block_grou=
p,
> +u64 btrfs_alloc_from_cluster(struct btrfs_block_group *block_group,
>  			     struct btrfs_free_cluster *cluster, u64 bytes,
>  			     u64 min_start, u64 *max_extent_size);
>  int btrfs_return_cluster_to_free_space(
> -			       struct btrfs_block_group_cache *block_group,
> +			       struct btrfs_block_group *block_group,
>  			       struct btrfs_free_cluster *cluster);
> -int btrfs_trim_block_group(struct btrfs_block_group_cache *block_group,
> +int btrfs_trim_block_group(struct btrfs_block_group *block_group,
>  			   u64 *trimmed, u64 start, u64 end, u64 minlen);
>
>  /* Support functions for running our sanity tests */
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
> -int test_add_free_space_entry(struct btrfs_block_group_cache *cache,
> +int test_add_free_space_entry(struct btrfs_block_group *cache,
>  			      u64 offset, u64 bytes, bool bitmap);
> -int test_check_exists(struct btrfs_block_group_cache *cache,
> -		      u64 offset, u64 bytes);
> +int test_check_exists(struct btrfs_block_group *cache, u64 offset, u64 =
bytes);
>  #endif
>
>  #endif
> diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
> index d3aa65a4c76f..258cb3fae17a 100644
> --- a/fs/btrfs/free-space-tree.c
> +++ b/fs/btrfs/free-space-tree.c
> @@ -13,10 +13,10 @@
>  #include "block-group.h"
>
>  static int __add_block_group_free_space(struct btrfs_trans_handle *tran=
s,
> -					struct btrfs_block_group_cache *block_group,
> +					struct btrfs_block_group *block_group,
>  					struct btrfs_path *path);
>
> -void set_free_space_tree_thresholds(struct btrfs_block_group_cache *cac=
he)
> +void set_free_space_tree_thresholds(struct btrfs_block_group *cache)
>  {
>  	u32 bitmap_range;
>  	size_t bitmap_size;
> @@ -44,7 +44,7 @@ void set_free_space_tree_thresholds(struct btrfs_block=
_group_cache *cache)
>  }
>
>  static int add_new_free_space_info(struct btrfs_trans_handle *trans,
> -				   struct btrfs_block_group_cache *block_group,
> +				   struct btrfs_block_group *block_group,
>  				   struct btrfs_path *path)
>  {
>  	struct btrfs_root *root =3D trans->fs_info->free_space_root;
> @@ -77,7 +77,7 @@ static int add_new_free_space_info(struct btrfs_trans_=
handle *trans,
>  EXPORT_FOR_TESTS
>  struct btrfs_free_space_info *search_free_space_info(
>  		struct btrfs_trans_handle *trans,
> -		struct btrfs_block_group_cache *block_group,
> +		struct btrfs_block_group *block_group,
>  		struct btrfs_path *path, int cow)
>  {
>  	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
> @@ -179,7 +179,7 @@ static void le_bitmap_set(unsigned long *map, unsign=
ed int start, int len)
>
>  EXPORT_FOR_TESTS
>  int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
> -				  struct btrfs_block_group_cache *block_group,
> +				  struct btrfs_block_group *block_group,
>  				  struct btrfs_path *path)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> @@ -319,7 +319,7 @@ int convert_free_space_to_bitmaps(struct btrfs_trans=
_handle *trans,
>
>  EXPORT_FOR_TESTS
>  int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
> -				  struct btrfs_block_group_cache *block_group,
> +				  struct btrfs_block_group *block_group,
>  				  struct btrfs_path *path)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
> @@ -452,7 +452,7 @@ int convert_free_space_to_extents(struct btrfs_trans=
_handle *trans,
>  }
>
>  static int update_free_space_extent_count(struct btrfs_trans_handle *tr=
ans,
> -					  struct btrfs_block_group_cache *block_group,
> +					  struct btrfs_block_group *block_group,
>  					  struct btrfs_path *path,
>  					  int new_extents)
>  {
> @@ -490,7 +490,7 @@ static int update_free_space_extent_count(struct btr=
fs_trans_handle *trans,
>  }
>
>  EXPORT_FOR_TESTS
> -int free_space_test_bit(struct btrfs_block_group_cache *block_group,
> +int free_space_test_bit(struct btrfs_block_group *block_group,
>  			struct btrfs_path *path, u64 offset)
>  {
>  	struct extent_buffer *leaf;
> @@ -512,7 +512,7 @@ int free_space_test_bit(struct btrfs_block_group_cac=
he *block_group,
>  	return !!extent_buffer_test_bit(leaf, ptr, i);
>  }
>
> -static void free_space_set_bits(struct btrfs_block_group_cache *block_g=
roup,
> +static void free_space_set_bits(struct btrfs_block_group *block_group,
>  				struct btrfs_path *path, u64 *start, u64 *size,
>  				int bit)
>  {
> @@ -580,7 +580,7 @@ static int free_space_next_bitmap(struct btrfs_trans=
_handle *trans,
>   * the bitmap.
>   */
>  static int modify_free_space_bitmap(struct btrfs_trans_handle *trans,
> -				    struct btrfs_block_group_cache *block_group,
> +				    struct btrfs_block_group *block_group,
>  				    struct btrfs_path *path,
>  				    u64 start, u64 size, int remove)
>  {
> @@ -693,7 +693,7 @@ static int modify_free_space_bitmap(struct btrfs_tra=
ns_handle *trans,
>  }
>
>  static int remove_free_space_extent(struct btrfs_trans_handle *trans,
> -				    struct btrfs_block_group_cache *block_group,
> +				    struct btrfs_block_group *block_group,
>  				    struct btrfs_path *path,
>  				    u64 start, u64 size)
>  {
> @@ -780,7 +780,7 @@ static int remove_free_space_extent(struct btrfs_tra=
ns_handle *trans,
>
>  EXPORT_FOR_TESTS
>  int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
> -				  struct btrfs_block_group_cache *block_group,
> +				  struct btrfs_block_group *block_group,
>  				  struct btrfs_path *path, u64 start, u64 size)
>  {
>  	struct btrfs_free_space_info *info;
> @@ -811,7 +811,7 @@ int __remove_from_free_space_tree(struct btrfs_trans=
_handle *trans,
>  int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
>  				u64 start, u64 size)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_path *path;
>  	int ret;
>
> @@ -845,7 +845,7 @@ int remove_from_free_space_tree(struct btrfs_trans_h=
andle *trans,
>  }
>
>  static int add_free_space_extent(struct btrfs_trans_handle *trans,
> -				 struct btrfs_block_group_cache *block_group,
> +				 struct btrfs_block_group *block_group,
>  				 struct btrfs_path *path,
>  				 u64 start, u64 size)
>  {
> @@ -973,7 +973,7 @@ static int add_free_space_extent(struct btrfs_trans_=
handle *trans,
>
>  EXPORT_FOR_TESTS
>  int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
> -			     struct btrfs_block_group_cache *block_group,
> +			     struct btrfs_block_group *block_group,
>  			     struct btrfs_path *path, u64 start, u64 size)
>  {
>  	struct btrfs_free_space_info *info;
> @@ -1004,7 +1004,7 @@ int __add_to_free_space_tree(struct btrfs_trans_ha=
ndle *trans,
>  int add_to_free_space_tree(struct btrfs_trans_handle *trans,
>  			   u64 start, u64 size)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_path *path;
>  	int ret;
>
> @@ -1042,7 +1042,7 @@ int add_to_free_space_tree(struct btrfs_trans_hand=
le *trans,
>   * through the normal add/remove hooks.
>   */
>  static int populate_free_space_tree(struct btrfs_trans_handle *trans,
> -				    struct btrfs_block_group_cache *block_group)
> +				    struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_root *extent_root =3D trans->fs_info->extent_root;
>  	struct btrfs_path *path, *path2;
> @@ -1139,7 +1139,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_i=
nfo *fs_info)
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_root *tree_root =3D fs_info->tree_root;
>  	struct btrfs_root *free_space_root;
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct rb_node *node;
>  	int ret;
>
> @@ -1158,7 +1158,7 @@ int btrfs_create_free_space_tree(struct btrfs_fs_i=
nfo *fs_info)
>
>  	node =3D rb_first(&fs_info->block_group_cache_tree);
>  	while (node) {
> -		block_group =3D rb_entry(node, struct btrfs_block_group_cache,
> +		block_group =3D rb_entry(node, struct btrfs_block_group,
>  				       cache_node);
>  		ret =3D populate_free_space_tree(trans, block_group);
>  		if (ret)
> @@ -1264,7 +1264,7 @@ int btrfs_clear_free_space_tree(struct btrfs_fs_in=
fo *fs_info)
>  }
>
>  static int __add_block_group_free_space(struct btrfs_trans_handle *tran=
s,
> -					struct btrfs_block_group_cache *block_group,
> +					struct btrfs_block_group *block_group,
>  					struct btrfs_path *path)
>  {
>  	int ret;
> @@ -1281,7 +1281,7 @@ static int __add_block_group_free_space(struct btr=
fs_trans_handle *trans,
>  }
>
>  int add_block_group_free_space(struct btrfs_trans_handle *trans,
> -			       struct btrfs_block_group_cache *block_group)
> +			       struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_fs_info *fs_info =3D trans->fs_info;
>  	struct btrfs_path *path =3D NULL;
> @@ -1311,7 +1311,7 @@ int add_block_group_free_space(struct btrfs_trans_=
handle *trans,
>  }
>
>  int remove_block_group_free_space(struct btrfs_trans_handle *trans,
> -				  struct btrfs_block_group_cache *block_group)
> +				  struct btrfs_block_group *block_group)
>  {
>  	struct btrfs_root *root =3D trans->fs_info->free_space_root;
>  	struct btrfs_path *path;
> @@ -1390,7 +1390,7 @@ static int load_free_space_bitmaps(struct btrfs_ca=
ching_control *caching_ctl,
>  				   struct btrfs_path *path,
>  				   u32 expected_extent_count)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_fs_info *fs_info;
>  	struct btrfs_root *root;
>  	struct btrfs_key key;
> @@ -1471,7 +1471,7 @@ static int load_free_space_extents(struct btrfs_ca=
ching_control *caching_ctl,
>  				   struct btrfs_path *path,
>  				   u32 expected_extent_count)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_fs_info *fs_info;
>  	struct btrfs_root *root;
>  	struct btrfs_key key;
> @@ -1531,7 +1531,7 @@ static int load_free_space_extents(struct btrfs_ca=
ching_control *caching_ctl,
>
>  int load_free_space_tree(struct btrfs_caching_control *caching_ctl)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	struct btrfs_free_space_info *info;
>  	struct btrfs_path *path;
>  	u32 extent_count, flags;
> diff --git a/fs/btrfs/free-space-tree.h b/fs/btrfs/free-space-tree.h
> index 360d50e1cdea..dc2463e4cfe3 100644
> --- a/fs/btrfs/free-space-tree.h
> +++ b/fs/btrfs/free-space-tree.h
> @@ -16,14 +16,14 @@ struct btrfs_caching_control;
>  #define BTRFS_FREE_SPACE_BITMAP_SIZE 256
>  #define BTRFS_FREE_SPACE_BITMAP_BITS (BTRFS_FREE_SPACE_BITMAP_SIZE * BI=
TS_PER_BYTE)
>
> -void set_free_space_tree_thresholds(struct btrfs_block_group_cache *blo=
ck_group);
> +void set_free_space_tree_thresholds(struct btrfs_block_group *block_gro=
up);
>  int btrfs_create_free_space_tree(struct btrfs_fs_info *fs_info);
>  int btrfs_clear_free_space_tree(struct btrfs_fs_info *fs_info);
>  int load_free_space_tree(struct btrfs_caching_control *caching_ctl);
>  int add_block_group_free_space(struct btrfs_trans_handle *trans,
> -			       struct btrfs_block_group_cache *block_group);
> +			       struct btrfs_block_group *block_group);
>  int remove_block_group_free_space(struct btrfs_trans_handle *trans,
> -				  struct btrfs_block_group_cache *block_group);
> +				  struct btrfs_block_group *block_group);
>  int add_to_free_space_tree(struct btrfs_trans_handle *trans,
>  			   u64 start, u64 size);
>  int remove_from_free_space_tree(struct btrfs_trans_handle *trans,
> @@ -32,21 +32,21 @@ int remove_from_free_space_tree(struct btrfs_trans_h=
andle *trans,
>  #ifdef CONFIG_BTRFS_FS_RUN_SANITY_TESTS
>  struct btrfs_free_space_info *
>  search_free_space_info(struct btrfs_trans_handle *trans,
> -		       struct btrfs_block_group_cache *block_group,
> +		       struct btrfs_block_group *block_group,
>  		       struct btrfs_path *path, int cow);
>  int __add_to_free_space_tree(struct btrfs_trans_handle *trans,
> -			     struct btrfs_block_group_cache *block_group,
> +			     struct btrfs_block_group *block_group,
>  			     struct btrfs_path *path, u64 start, u64 size);
>  int __remove_from_free_space_tree(struct btrfs_trans_handle *trans,
> -				  struct btrfs_block_group_cache *block_group,
> +				  struct btrfs_block_group *block_group,
>  				  struct btrfs_path *path, u64 start, u64 size);
>  int convert_free_space_to_bitmaps(struct btrfs_trans_handle *trans,
> -				  struct btrfs_block_group_cache *block_group,
> +				  struct btrfs_block_group *block_group,
>  				  struct btrfs_path *path);
>  int convert_free_space_to_extents(struct btrfs_trans_handle *trans,
> -				  struct btrfs_block_group_cache *block_group,
> +				  struct btrfs_block_group *block_group,
>  				  struct btrfs_path *path);
> -int free_space_test_bit(struct btrfs_block_group_cache *block_group,
> +int free_space_test_bit(struct btrfs_block_group *block_group,
>  			struct btrfs_path *path, u64 offset);
>  #endif
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 09118a0f82d1..f7f022a8a5ae 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -3029,7 +3029,7 @@ record_old_file_extents(struct inode *inode,
>  static void btrfs_release_delalloc_bytes(struct btrfs_fs_info *fs_info,
>  					 u64 start, u64 len)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>
>  	cache =3D btrfs_lookup_block_group(fs_info, start);
>  	ASSERT(cache);
> @@ -10803,7 +10803,7 @@ static int btrfs_swap_activate(struct swap_info_=
struct *sis, struct file *file,
>  	start =3D 0;
>  	while (start < isize) {
>  		u64 logical_block_start, physical_block_start;
> -		struct btrfs_block_group_cache *bg;
> +		struct btrfs_block_group *bg;
>  		u64 len =3D isize - start;
>
>  		em =3D btrfs_get_extent(BTRFS_I(inode), NULL, 0, start, len, 0);
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index b4ffa232479a..66611accc418 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4031,7 +4031,7 @@ static long btrfs_ioctl_default_subvol(struct file=
 *file, void __user *argp)
>  static void get_block_group_info(struct list_head *groups_list,
>  				 struct btrfs_ioctl_space_info *space)
>  {
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>
>  	space->total_bytes =3D 0;
>  	space->used_bytes =3D 0;
> diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> index f414fd914ddd..93aeb2e539a4 100644
> --- a/fs/btrfs/qgroup.c
> +++ b/fs/btrfs/qgroup.c
> @@ -3823,7 +3823,7 @@ void btrfs_qgroup_clean_swapped_blocks(struct btrf=
s_root *root)
>   */
>  int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
>  		struct btrfs_root *subvol_root,
> -		struct btrfs_block_group_cache *bg,
> +		struct btrfs_block_group *bg,
>  		struct extent_buffer *subvol_parent, int subvol_slot,
>  		struct extent_buffer *reloc_parent, int reloc_slot,
>  		u64 last_snapshot)
> diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
> index 46ba7bd2961c..236f12224d52 100644
> --- a/fs/btrfs/qgroup.h
> +++ b/fs/btrfs/qgroup.h
> @@ -408,7 +408,7 @@ void btrfs_qgroup_init_swapped_blocks(
>  void btrfs_qgroup_clean_swapped_blocks(struct btrfs_root *root);
>  int btrfs_qgroup_add_swapped_blocks(struct btrfs_trans_handle *trans,
>  		struct btrfs_root *subvol_root,
> -		struct btrfs_block_group_cache *bg,
> +		struct btrfs_block_group *bg,
>  		struct extent_buffer *subvol_parent, int subvol_slot,
>  		struct extent_buffer *reloc_parent, int reloc_slot,
>  		u64 last_snapshot);
> diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
> index 907c5d79a197..243a2e44526e 100644
> --- a/fs/btrfs/reada.c
> +++ b/fs/btrfs/reada.c
> @@ -227,7 +227,7 @@ static struct reada_zone *reada_find_zone(struct btr=
fs_device *dev, u64 logical,
>  	struct btrfs_fs_info *fs_info =3D dev->fs_info;
>  	int ret;
>  	struct reada_zone *zone;
> -	struct btrfs_block_group_cache *cache =3D NULL;
> +	struct btrfs_block_group *cache =3D NULL;
>  	u64 start;
>  	u64 end;
>  	int i;
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 8f57c086231d..9e03da45a5c4 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -147,7 +147,7 @@ struct file_extent_cluster {
>
>  struct reloc_control {
>  	/* block group to relocate */
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	/* extent tree */
>  	struct btrfs_root *extent_root;
>  	/* inode for moving data */
> @@ -1560,8 +1560,7 @@ static struct inode *find_next_inode(struct btrfs_=
root *root, u64 objectid)
>  	return NULL;
>  }
>
> -static int in_block_group(u64 bytenr,
> -			  struct btrfs_block_group_cache *block_group)
> +static int in_block_group(u64 bytenr, struct btrfs_block_group *block_g=
roup)
>  {
>  	if (bytenr >=3D block_group->start &&
>  	    bytenr < block_group->start + block_group->length)
> @@ -3542,7 +3541,7 @@ static int block_use_full_backref(struct reloc_con=
trol *rc,
>  }
>
>  static int delete_block_group_cache(struct btrfs_fs_info *fs_info,
> -				    struct btrfs_block_group_cache *block_group,
> +				    struct btrfs_block_group *block_group,
>  				    struct inode *inode,
>  				    u64 ino)
>  {
> @@ -4217,7 +4216,7 @@ static int __insert_orphan_inode(struct btrfs_tran=
s_handle *trans,
>   */
>  static noinline_for_stack
>  struct inode *create_reloc_inode(struct btrfs_fs_info *fs_info,
> -				 struct btrfs_block_group_cache *group)
> +				 struct btrfs_block_group *group)
>  {
>  	struct inode *inode =3D NULL;
>  	struct btrfs_trans_handle *trans;
> @@ -4281,7 +4280,7 @@ static struct reloc_control *alloc_reloc_control(s=
truct btrfs_fs_info *fs_info)
>   * Print the block group being relocated
>   */
>  static void describe_relocation(struct btrfs_fs_info *fs_info,
> -				struct btrfs_block_group_cache *block_group)
> +				struct btrfs_block_group *block_group)
>  {
>  	char buf[128] =3D {'\0'};
>
> @@ -4297,7 +4296,7 @@ static void describe_relocation(struct btrfs_fs_in=
fo *fs_info,
>   */
>  int btrfs_relocate_block_group(struct btrfs_fs_info *fs_info, u64 group=
_start)
>  {
> -	struct btrfs_block_group_cache *bg;
> +	struct btrfs_block_group *bg;
>  	struct btrfs_root *extent_root =3D fs_info->extent_root;
>  	struct reloc_control *rc;
>  	struct inode *inode;
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index 4a5a4e4ef707..d86a2f1b9ab5 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -389,8 +389,7 @@ static struct full_stripe_lock *search_full_stripe_l=
ock(
>   *
>   * Caller must ensure @cache is a RAID56 block group.
>   */
> -static u64 get_full_stripe_logical(struct btrfs_block_group_cache *cach=
e,
> -				   u64 bytenr)
> +static u64 get_full_stripe_logical(struct btrfs_block_group *cache, u64=
 bytenr)
>  {
>  	u64 ret;
>
> @@ -423,7 +422,7 @@ static u64 get_full_stripe_logical(struct btrfs_bloc=
k_group_cache *cache,
>  static int lock_full_stripe(struct btrfs_fs_info *fs_info, u64 bytenr,
>  			    bool *locked_ret)
>  {
> -	struct btrfs_block_group_cache *bg_cache;
> +	struct btrfs_block_group *bg_cache;
>  	struct btrfs_full_stripe_locks_tree *locks_root;
>  	struct full_stripe_lock *existing;
>  	u64 fstripe_start;
> @@ -470,7 +469,7 @@ static int lock_full_stripe(struct btrfs_fs_info *fs=
_info, u64 bytenr,
>  static int unlock_full_stripe(struct btrfs_fs_info *fs_info, u64 bytenr=
,
>  			      bool locked)
>  {
> -	struct btrfs_block_group_cache *bg_cache;
> +	struct btrfs_block_group *bg_cache;
>  	struct btrfs_full_stripe_locks_tree *locks_root;
>  	struct full_stripe_lock *fstripe_lock;
>  	u64 fstripe_start;
> @@ -3417,7 +3416,7 @@ static noinline_for_stack int scrub_chunk(struct s=
crub_ctx *sctx,
>  					  struct btrfs_device *scrub_dev,
>  					  u64 chunk_offset, u64 length,
>  					  u64 dev_offset,
> -					  struct btrfs_block_group_cache *cache)
> +					  struct btrfs_block_group *cache)
>  {
>  	struct btrfs_fs_info *fs_info =3D sctx->fs_info;
>  	struct extent_map_tree *map_tree =3D &fs_info->mapping_tree;
> @@ -3481,7 +3480,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
>  	struct extent_buffer *l;
>  	struct btrfs_key key;
>  	struct btrfs_key found_key;
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	struct btrfs_dev_replace *dev_replace =3D &fs_info->dev_replace;
>
>  	path =3D btrfs_alloc_path();
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 22b4968699e1..f09aa6ee9113 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -284,7 +284,7 @@ void btrfs_dump_space_info(struct btrfs_fs_info *fs_=
info,
>  			   struct btrfs_space_info *info, u64 bytes,
>  			   int dump_block_groups)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	int index =3D 0;
>
>  	spin_lock(&info->lock);
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 4a78bc4ec62e..f99b606d3066 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -405,7 +405,7 @@ static ssize_t raid_bytes_show(struct kobject *kobj,
>
>  {
>  	struct btrfs_space_info *sinfo =3D to_space_info(kobj->parent);
> -	struct btrfs_block_group_cache *block_group;
> +	struct btrfs_block_group *block_group;
>  	int index =3D btrfs_bg_flags_to_raid_index(to_raid_kobj(kobj)->flags);
>  	u64 val =3D 0;
>
> @@ -869,7 +869,7 @@ static void init_feature_attrs(void)
>   * Create a sysfs entry for a given block group type at path
>   * /sys/fs/btrfs/UUID/allocation/data/TYPE
>   */
> -void btrfs_sysfs_add_block_group_type(struct btrfs_block_group_cache *c=
ache)
> +void btrfs_sysfs_add_block_group_type(struct btrfs_block_group *cache)
>  {
>  	struct btrfs_fs_info *fs_info =3D cache->fs_info;
>  	struct btrfs_space_info *space_info =3D cache->space_info;
> diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
> index 610e9c36a94c..e10c3adfc30f 100644
> --- a/fs/btrfs/sysfs.h
> +++ b/fs/btrfs/sysfs.h
> @@ -32,7 +32,7 @@ int __init btrfs_init_sysfs(void);
>  void __cold btrfs_exit_sysfs(void);
>  int btrfs_sysfs_add_mounted(struct btrfs_fs_info *fs_info);
>  void btrfs_sysfs_remove_mounted(struct btrfs_fs_info *fs_info);
> -void btrfs_sysfs_add_block_group_type(struct btrfs_block_group_cache *c=
ache);
> +void btrfs_sysfs_add_block_group_type(struct btrfs_block_group *cache);
>  int btrfs_sysfs_add_space_info_type(struct btrfs_fs_info *fs_info,
>  				    struct btrfs_space_info *space_info);
>  void btrfs_sysfs_remove_space_info(struct btrfs_space_info *space_info)=
;
> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> index f4bb5e2a4ba5..a7aca4141788 100644
> --- a/fs/btrfs/tests/btrfs-tests.c
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -202,11 +202,11 @@ void btrfs_free_dummy_root(struct btrfs_root *root=
)
>  	kfree(root);
>  }
>
> -struct btrfs_block_group_cache *
> +struct btrfs_block_group *
>  btrfs_alloc_dummy_block_group(struct btrfs_fs_info *fs_info,
>  			      unsigned long length)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>
>  	cache =3D kzalloc(sizeof(*cache), GFP_KERNEL);
>  	if (!cache)
> @@ -232,7 +232,7 @@ btrfs_alloc_dummy_block_group(struct btrfs_fs_info *=
fs_info,
>  	return cache;
>  }
>
> -void btrfs_free_dummy_block_group(struct btrfs_block_group_cache *cache=
)
> +void btrfs_free_dummy_block_group(struct btrfs_block_group *cache)
>  {
>  	if (!cache)
>  		return;
> diff --git a/fs/btrfs/tests/btrfs-tests.h b/fs/btrfs/tests/btrfs-tests.h
> index ee277bbd939b..9e52527357d8 100644
> --- a/fs/btrfs/tests/btrfs-tests.h
> +++ b/fs/btrfs/tests/btrfs-tests.h
> @@ -41,9 +41,9 @@ struct inode *btrfs_new_test_inode(void);
>  struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 nodesize, u32 secto=
rsize);
>  void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info);
>  void btrfs_free_dummy_root(struct btrfs_root *root);
> -struct btrfs_block_group_cache *
> +struct btrfs_block_group *
>  btrfs_alloc_dummy_block_group(struct btrfs_fs_info *fs_info, unsigned l=
ong length);
> -void btrfs_free_dummy_block_group(struct btrfs_block_group_cache *cache=
);
> +void btrfs_free_dummy_block_group(struct btrfs_block_group *cache);
>  void btrfs_init_dummy_trans(struct btrfs_trans_handle *trans,
>  			    struct btrfs_fs_info *fs_info);
>  #else
> diff --git a/fs/btrfs/tests/free-space-tests.c b/fs/btrfs/tests/free-spa=
ce-tests.c
> index 43ec7060fcd2..aebdf23f0cdd 100644
> --- a/fs/btrfs/tests/free-space-tests.c
> +++ b/fs/btrfs/tests/free-space-tests.c
> @@ -17,7 +17,7 @@
>   * entry and remove space from either end and the middle, and make sure=
 we can
>   * remove space that covers adjacent extent entries.
>   */
> -static int test_extents(struct btrfs_block_group_cache *cache)
> +static int test_extents(struct btrfs_block_group *cache)
>  {
>  	int ret =3D 0;
>
> @@ -87,8 +87,7 @@ static int test_extents(struct btrfs_block_group_cache=
 *cache)
>  	return 0;
>  }
>
> -static int test_bitmaps(struct btrfs_block_group_cache *cache,
> -			u32 sectorsize)
> +static int test_bitmaps(struct btrfs_block_group *cache, u32 sectorsize=
)
>  {
>  	u64 next_bitmap_offset;
>  	int ret;
> @@ -156,7 +155,7 @@ static int test_bitmaps(struct btrfs_block_group_cac=
he *cache,
>  }
>
>  /* This is the high grade jackassery */
> -static int test_bitmaps_and_extents(struct btrfs_block_group_cache *cac=
he,
> +static int test_bitmaps_and_extents(struct btrfs_block_group *cache,
>  				    u32 sectorsize)
>  {
>  	u64 bitmap_offset =3D (u64)(BITS_PER_BITMAP * sectorsize);
> @@ -331,7 +330,7 @@ static bool test_use_bitmap(struct btrfs_free_space_=
ctl *ctl,
>
>  /* Used by test_steal_space_from_bitmap_to_extent(). */
>  static int
> -check_num_extents_and_bitmaps(const struct btrfs_block_group_cache *cac=
he,
> +check_num_extents_and_bitmaps(const struct btrfs_block_group *cache,
>  			      const int num_extents,
>  			      const int num_bitmaps)
>  {
> @@ -351,7 +350,7 @@ check_num_extents_and_bitmaps(const struct btrfs_blo=
ck_group_cache *cache,
>  }
>
>  /* Used by test_steal_space_from_bitmap_to_extent(). */
> -static int check_cache_empty(struct btrfs_block_group_cache *cache)
> +static int check_cache_empty(struct btrfs_block_group *cache)
>  {
>  	u64 offset;
>  	u64 max_extent_size;
> @@ -393,7 +392,7 @@ static int check_cache_empty(struct btrfs_block_grou=
p_cache *cache)
>   * requests.
>   */
>  static int
> -test_steal_space_from_bitmap_to_extent(struct btrfs_block_group_cache *=
cache,
> +test_steal_space_from_bitmap_to_extent(struct btrfs_block_group *cache,
>  				       u32 sectorsize)
>  {
>  	int ret;
> @@ -829,7 +828,7 @@ test_steal_space_from_bitmap_to_extent(struct btrfs_=
block_group_cache *cache,
>  int btrfs_test_free_space_cache(u32 sectorsize, u32 nodesize)
>  {
>  	struct btrfs_fs_info *fs_info;
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	struct btrfs_root *root =3D NULL;
>  	int ret =3D -ENOMEM;
>
> diff --git a/fs/btrfs/tests/free-space-tree-tests.c b/fs/btrfs/tests/fre=
e-space-tree-tests.c
> index 188f08bd44b0..1a846bf6e197 100644
> --- a/fs/btrfs/tests/free-space-tree-tests.c
> +++ b/fs/btrfs/tests/free-space-tree-tests.c
> @@ -18,7 +18,7 @@ struct free_space_extent {
>
>  static int __check_free_space_extents(struct btrfs_trans_handle *trans,
>  				      struct btrfs_fs_info *fs_info,
> -				      struct btrfs_block_group_cache *cache,
> +				      struct btrfs_block_group *cache,
>  				      struct btrfs_path *path,
>  				      const struct free_space_extent * const extents,
>  				      unsigned int num_extents)
> @@ -107,7 +107,7 @@ static int __check_free_space_extents(struct btrfs_t=
rans_handle *trans,
>
>  static int check_free_space_extents(struct btrfs_trans_handle *trans,
>  				    struct btrfs_fs_info *fs_info,
> -				    struct btrfs_block_group_cache *cache,
> +				    struct btrfs_block_group *cache,
>  				    struct btrfs_path *path,
>  				    const struct free_space_extent * const extents,
>  				    unsigned int num_extents)
> @@ -150,7 +150,7 @@ static int check_free_space_extents(struct btrfs_tra=
ns_handle *trans,
>
>  static int test_empty_block_group(struct btrfs_trans_handle *trans,
>  				  struct btrfs_fs_info *fs_info,
> -				  struct btrfs_block_group_cache *cache,
> +				  struct btrfs_block_group *cache,
>  				  struct btrfs_path *path,
>  				  u32 alignment)
>  {
> @@ -164,7 +164,7 @@ static int test_empty_block_group(struct btrfs_trans=
_handle *trans,
>
>  static int test_remove_all(struct btrfs_trans_handle *trans,
>  			   struct btrfs_fs_info *fs_info,
> -			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_block_group *cache,
>  			   struct btrfs_path *path,
>  			   u32 alignment)
>  {
> @@ -185,7 +185,7 @@ static int test_remove_all(struct btrfs_trans_handle=
 *trans,
>
>  static int test_remove_beginning(struct btrfs_trans_handle *trans,
>  				 struct btrfs_fs_info *fs_info,
> -				 struct btrfs_block_group_cache *cache,
> +				 struct btrfs_block_group *cache,
>  				 struct btrfs_path *path,
>  				 u32 alignment)
>  {
> @@ -208,7 +208,7 @@ static int test_remove_beginning(struct btrfs_trans_=
handle *trans,
>
>  static int test_remove_end(struct btrfs_trans_handle *trans,
>  			   struct btrfs_fs_info *fs_info,
> -			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_block_group *cache,
>  			   struct btrfs_path *path,
>  			   u32 alignment)
>  {
> @@ -231,7 +231,7 @@ static int test_remove_end(struct btrfs_trans_handle=
 *trans,
>
>  static int test_remove_middle(struct btrfs_trans_handle *trans,
>  			      struct btrfs_fs_info *fs_info,
> -			      struct btrfs_block_group_cache *cache,
> +			      struct btrfs_block_group *cache,
>  			      struct btrfs_path *path,
>  			      u32 alignment)
>  {
> @@ -255,7 +255,7 @@ static int test_remove_middle(struct btrfs_trans_han=
dle *trans,
>
>  static int test_merge_left(struct btrfs_trans_handle *trans,
>  			   struct btrfs_fs_info *fs_info,
> -			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_block_group *cache,
>  			   struct btrfs_path *path,
>  			   u32 alignment)
>  {
> @@ -292,7 +292,7 @@ static int test_merge_left(struct btrfs_trans_handle=
 *trans,
>
>  static int test_merge_right(struct btrfs_trans_handle *trans,
>  			   struct btrfs_fs_info *fs_info,
> -			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_block_group *cache,
>  			   struct btrfs_path *path,
>  			   u32 alignment)
>  {
> @@ -330,7 +330,7 @@ static int test_merge_right(struct btrfs_trans_handl=
e *trans,
>
>  static int test_merge_both(struct btrfs_trans_handle *trans,
>  			   struct btrfs_fs_info *fs_info,
> -			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_block_group *cache,
>  			   struct btrfs_path *path,
>  			   u32 alignment)
>  {
> @@ -373,7 +373,7 @@ static int test_merge_both(struct btrfs_trans_handle=
 *trans,
>
>  static int test_merge_none(struct btrfs_trans_handle *trans,
>  			   struct btrfs_fs_info *fs_info,
> -			   struct btrfs_block_group_cache *cache,
> +			   struct btrfs_block_group *cache,
>  			   struct btrfs_path *path,
>  			   u32 alignment)
>  {
> @@ -418,7 +418,7 @@ static int test_merge_none(struct btrfs_trans_handle=
 *trans,
>
>  typedef int (*test_func_t)(struct btrfs_trans_handle *,
>  			   struct btrfs_fs_info *,
> -			   struct btrfs_block_group_cache *,
> +			   struct btrfs_block_group *,
>  			   struct btrfs_path *,
>  			   u32 alignment);
>
> @@ -427,7 +427,7 @@ static int run_test(test_func_t test_func, int bitma=
ps, u32 sectorsize,
>  {
>  	struct btrfs_fs_info *fs_info;
>  	struct btrfs_root *root =3D NULL;
> -	struct btrfs_block_group_cache *cache =3D NULL;
> +	struct btrfs_block_group *cache =3D NULL;
>  	struct btrfs_trans_handle trans;
>  	struct btrfs_path *path =3D NULL;
>  	int ret;
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 6f133906c862..cfc08ef9b876 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -133,10 +133,10 @@ void btrfs_put_transaction(struct btrfs_transactio=
n *transaction)
>  		 * discard the physical locations of the block groups.
>  		 */
>  		while (!list_empty(&transaction->deleted_bgs)) {
> -			struct btrfs_block_group_cache *cache;
> +			struct btrfs_block_group *cache;
>
>  			cache =3D list_first_entry(&transaction->deleted_bgs,
> -						 struct btrfs_block_group_cache,
> +						 struct btrfs_block_group,
>  						 bg_list);
>  			list_del_init(&cache->bg_list);
>  			btrfs_put_block_group_trimming(cache);
> @@ -1937,7 +1937,7 @@ static void cleanup_transaction(struct btrfs_trans=
_handle *trans, int err)
>  static void btrfs_cleanup_pending_block_groups(struct btrfs_trans_handl=
e *trans)
>  {
>         struct btrfs_fs_info *fs_info =3D trans->fs_info;
> -       struct btrfs_block_group_cache *block_group, *tmp;
> +       struct btrfs_block_group *block_group, *tmp;
>
>         list_for_each_entry_safe(block_group, tmp, &trans->new_bgs, bg_l=
ist) {
>                 btrfs_delayed_refs_rsv_release(fs_info, 1);
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index f534a6a5553e..e6b2c578ae62 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2973,7 +2973,7 @@ static int btrfs_relocate_sys_chunks(struct btrfs_=
fs_info *fs_info)
>  static int btrfs_may_alloc_data_chunk(struct btrfs_fs_info *fs_info,
>  				      u64 chunk_offset)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	u64 bytes_used;
>  	u64 chunk_type;
>
> @@ -3182,7 +3182,7 @@ static int chunk_profiles_filter(u64 chunk_type,
>  static int chunk_usage_range_filter(struct btrfs_fs_info *fs_info, u64 =
chunk_offset,
>  			      struct btrfs_balance_args *bargs)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	u64 chunk_used;
>  	u64 user_thresh_min;
>  	u64 user_thresh_max;
> @@ -3215,7 +3215,7 @@ static int chunk_usage_range_filter(struct btrfs_f=
s_info *fs_info, u64 chunk_off
>  static int chunk_usage_filter(struct btrfs_fs_info *fs_info,
>  		u64 chunk_offset, struct btrfs_balance_args *bargs)
>  {
> -	struct btrfs_block_group_cache *cache;
> +	struct btrfs_block_group *cache;
>  	u64 chunk_used, user_thresh;
>  	int ret =3D 1;
>
> diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> index 070619891915..620bf1b38fba 100644
> --- a/include/trace/events/btrfs.h
> +++ b/include/trace/events/btrfs.h
> @@ -19,7 +19,7 @@ struct btrfs_delayed_ref_node;
>  struct btrfs_delayed_tree_ref;
>  struct btrfs_delayed_data_ref;
>  struct btrfs_delayed_ref_head;
> -struct btrfs_block_group_cache;
> +struct btrfs_block_group;
>  struct btrfs_free_cluster;
>  struct map_lookup;
>  struct extent_buffer;
> @@ -699,7 +699,7 @@ TRACE_EVENT(btrfs_sync_fs,
>  TRACE_EVENT(btrfs_add_block_group,
>
>  	TP_PROTO(const struct btrfs_fs_info *fs_info,
> -		 const struct btrfs_block_group_cache *block_group, int create),
> +		 const struct btrfs_block_group *block_group, int create),
>
>  	TP_ARGS(fs_info, block_group, create),
>
> @@ -1184,7 +1184,7 @@ TRACE_EVENT(find_free_extent,
>
>  DECLARE_EVENT_CLASS(btrfs__reserve_extent,
>
> -	TP_PROTO(const struct btrfs_block_group_cache *block_group, u64 start,
> +	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
>  		 u64 len),
>
>  	TP_ARGS(block_group, start, len),
> @@ -1214,7 +1214,7 @@ DECLARE_EVENT_CLASS(btrfs__reserve_extent,
>
>  DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_extent,
>
> -	TP_PROTO(const struct btrfs_block_group_cache *block_group, u64 start,
> +	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
>  		 u64 len),
>
>  	TP_ARGS(block_group, start, len)
> @@ -1222,7 +1222,7 @@ DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_=
extent,
>
>  DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_extent_cluster,
>
> -	TP_PROTO(const struct btrfs_block_group_cache *block_group, u64 start,
> +	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
>  		 u64 len),
>
>  	TP_ARGS(block_group, start, len)
> @@ -1230,7 +1230,7 @@ DEFINE_EVENT(btrfs__reserve_extent, btrfs_reserve_=
extent_cluster,
>
>  TRACE_EVENT(btrfs_find_cluster,
>
> -	TP_PROTO(const struct btrfs_block_group_cache *block_group, u64 start,
> +	TP_PROTO(const struct btrfs_block_group *block_group, u64 start,
>  		 u64 bytes, u64 empty_size, u64 min_bytes),
>
>  	TP_ARGS(block_group, start, bytes, empty_size, min_bytes),
> @@ -1263,7 +1263,7 @@ TRACE_EVENT(btrfs_find_cluster,
>
>  TRACE_EVENT(btrfs_failed_cluster_setup,
>
> -	TP_PROTO(const struct btrfs_block_group_cache *block_group),
> +	TP_PROTO(const struct btrfs_block_group *block_group),
>
>  	TP_ARGS(block_group),
>
> @@ -1280,7 +1280,7 @@ TRACE_EVENT(btrfs_failed_cluster_setup,
>
>  TRACE_EVENT(btrfs_setup_cluster,
>
> -	TP_PROTO(const struct btrfs_block_group_cache *block_group,
> +	TP_PROTO(const struct btrfs_block_group *block_group,
>  		 const struct btrfs_free_cluster *cluster,
>  		 u64 size, int bitmap),
>
> @@ -1844,7 +1844,7 @@ TRACE_EVENT(btrfs_inode_mod_outstanding_extents,
>  );
>
>  DECLARE_EVENT_CLASS(btrfs__block_group,
> -	TP_PROTO(const struct btrfs_block_group_cache *bg_cache),
> +	TP_PROTO(const struct btrfs_block_group *bg_cache),
>
>  	TP_ARGS(bg_cache),
>
> @@ -1868,19 +1868,19 @@ DECLARE_EVENT_CLASS(btrfs__block_group,
>  );
>
>  DEFINE_EVENT(btrfs__block_group, btrfs_remove_block_group,
> -	TP_PROTO(const struct btrfs_block_group_cache *bg_cache),
> +	TP_PROTO(const struct btrfs_block_group *bg_cache),
>
>  	TP_ARGS(bg_cache)
>  );
>
>  DEFINE_EVENT(btrfs__block_group, btrfs_add_unused_block_group,
> -	TP_PROTO(const struct btrfs_block_group_cache *bg_cache),
> +	TP_PROTO(const struct btrfs_block_group *bg_cache),
>
>  	TP_ARGS(bg_cache)
>  );
>
>  DEFINE_EVENT(btrfs__block_group, btrfs_skip_unused_block_group,
> -	TP_PROTO(const struct btrfs_block_group_cache *bg_cache),
> +	TP_PROTO(const struct btrfs_block_group *bg_cache),
>
>  	TP_ARGS(bg_cache)
>  );
>
