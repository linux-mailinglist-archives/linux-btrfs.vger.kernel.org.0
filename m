Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4220340A245
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 03:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236234AbhINBDR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Sep 2021 21:03:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:40417 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229460AbhINBDQ (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Sep 2021 21:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631581318;
        bh=dM9RGkne8rA56mnbRjOO0P4P5mkgfEZwjZwUQSqWedg=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=JmF8zeR8nBHTcmGa+b8B0zpgydqKOcMl1pSriwgkosXyoc3ztqQKcBxg0KlKczYqm
         SvLgno/4uvo9da2JBtCY/FLFmLGBzhIYzH8A7gwfSCR8rsGVG1bhatJA2d8MJvoX0j
         tUyJbwh/10F3WAzyN2e5L/C7950aI5FMXU5ZGsH0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MRCK6-1mbxPV0gdw-00NBIs; Tue, 14
 Sep 2021 03:01:57 +0200
Subject: Re: [PATCH 2/8] btrfs-progs: Remove root argument from
 btrfs_fixup_low_keys
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210913131729.37897-1-nborisov@suse.com>
 <20210913131729.37897-3-nborisov@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <dc29de3b-e813-4bca-548f-dac60c6f782c@gmx.com>
Date:   Tue, 14 Sep 2021 09:01:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210913131729.37897-3-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J+EVt61Im0dc4v7XXW2fe0UBxeadioPuVhis1s8+Nx9eJYPaV4V
 1W/ynLr64+HdXjm27fIczhOYyK2vcKiTvIXeI1YzGZwrKdGDkSMmrGp1IE9jznnx6spxvO9
 Q+SgaUSF+umzo0yYaVDYNhyRY1NwMUHyjs2sx5i6PqduMGia0XLgzglK3CFBhZQKPEVeolc
 7T7CFiO4LgoBtQbvkmKsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jBrC/G8elpk=:qDv+t3v5739RK3FH706X76
 aJw1q3ctSnQAanvesdgZBUXNFQ5J7vMLQt0e+1BlSdq45F3jtPzN6UMT87N7GbwDjbcXc7SXp
 jDS76Lj5JB76rxFL941lDMd466kf0M043cWqsTmHPLtHvkQDsegdUdHBZb/03vzZFSvLeHHgr
 v16IJSBIE03WnKhQrotJ3MJ7ZLpT1ryj/OgliCWOQCHYJ0th22o0azCTmTfChoDTuZsduk4NP
 neMwvadqmWRmCuYr6sWUcOpB9yZ83sXAi1ApzAMQZn97D7Ztxps73ADp8OArMR4pg4QrQBfm5
 8Q7K3U3nGqAvgoHAH+bPB559dC3yXoCpxImwBB/gHCeWAc77Iuy0YPK3NbwtqWLABUF+qchuq
 KnqG4FuoZdWdShrw9zBs7Jyb/m68U9s5UusVnP1jW3kmFpOOhHZjsEG4caOSrSDCxy6CiolVF
 qX1+oVEV6+/ab8JxanbJ2Fbv6SrKVZJGbNvOBzljbuDqal0MUTGMWH4yLmfbUhWlJqGpAwCT/
 Dbm8zBE7fxrdV2R/Hlxjir+7EA3WyUkEbdbAPX/0EvCHrGauApzfEuDD4Ck511dVL09owr3OW
 nVTCpI+xYXXW26AF2ykDZlV2WmepOaM2sVSqeaQZ3TG5uHVQ5IVNOCxlAHSvPLKKhQHzYo7aW
 GvtM1NF01skr2Ir1ELMOWWq4IHQBUh3U6Yq7btSEvMcwLZdJbMCtJgOhVkZQSfSfOqH3q7n4Q
 T9bam2lXwWUFs5gKKr7sPJYKTVIfZn1a1rCKiNnj1iR9mmzWe581+xyOj2+X/jGJLgl3aacbq
 pL5my8av+5oJsmNyN+Jck02UWyneRj0WEtVoOujnwE78IDM+22U4GvhtKvq7BReVMmLmcBI85
 uQ8uAGq893ztZE9QPVM9LwsgnC1KI6nT4yaK44Uq3Lu2kVhZurR/edr7O+ErPNOtkC3+FBiBx
 sHLe2C+fYC1kaIE2NnW8x8CoNjqewZ5shIN/wAi9pUUiytyIQH2lMPRJIdyKBQCted9FrTdB3
 +JvIDoAo8t5DUbuqxOcUP9b7ozqFo02/qc3LR+F3xef4m7hVi/O9DgMYxCDW9fL9ivv4AyAPu
 2j6nr0371KEazI=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/9/13 =E4=B8=8B=E5=8D=889:17, Nikolay Borisov wrote:
> It's not used, so just remove it.
>
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Just one unrelated topic inlined below.

> ---
>   check/main.c          |  5 ++---
>   kernel-shared/ctree.c | 24 +++++++++++-------------
>   kernel-shared/ctree.h |  4 ++--
>   3 files changed, 15 insertions(+), 18 deletions(-)
>
> diff --git a/check/main.c b/check/main.c
> index a88518159830..6369bdd90656 100644
> --- a/check/main.c
> +++ b/check/main.c
> @@ -4197,8 +4197,7 @@ static int swap_values(struct btrfs_root *root, st=
ruct btrfs_path *path,
>   			struct btrfs_disk_key key;
>
>   			btrfs_node_key(buf, &key, 0);
> -			btrfs_fixup_low_keys(root, path, &key,
> -					     btrfs_header_level(buf) + 1);
> +			btrfs_fixup_low_keys(path, &key, btrfs_header_level(buf) + 1);
>   		}
>   	} else {
>   		struct btrfs_item *item1, *item2;
> @@ -4302,7 +4301,7 @@ static int delete_bogus_item(struct btrfs_root *ro=
ot,
>   		struct btrfs_disk_key disk_key;
>
>   		btrfs_item_key(buf, &disk_key, 0);
> -		btrfs_fixup_low_keys(root, path, &disk_key, 1);
> +		btrfs_fixup_low_keys(path, &disk_key, 1);
>   	}
>   	btrfs_mark_buffer_dirty(buf);
>   	return 0;
> diff --git a/kernel-shared/ctree.c b/kernel-shared/ctree.c
> index 518718de04dd..02eb975338e5 100644
> --- a/kernel-shared/ctree.c
> +++ b/kernel-shared/ctree.c
> @@ -1437,8 +1437,8 @@ int btrfs_search_slot_for_read(struct btrfs_root *=
root,
>    * fixing up pointers when a given leaf/node is not in slot 0 of the
>    * higher levels
>    */
> -void btrfs_fixup_low_keys(struct btrfs_root *root, struct btrfs_path *p=
ath,
> -			  struct btrfs_disk_key *key, int level)

Isn't it recommended to use btrfs_key instead of btrfs_disk_key nowadays?

Maybe a good time to cleanup unnecessary btrfs_disk_key usage?

Thanks,
Qu

> +void btrfs_fixup_low_keys( struct btrfs_path *path, struct btrfs_disk_k=
ey *key,
> +		int level)
>   {
>   	int i;
>   	struct extent_buffer *t;
> @@ -1485,7 +1485,7 @@ int btrfs_set_item_key_safe(struct btrfs_root *roo=
t, struct btrfs_path *path,
>   	btrfs_set_item_key(eb, &disk_key, slot);
>   	btrfs_mark_buffer_dirty(eb);
>   	if (slot =3D=3D 0)
> -		btrfs_fixup_low_keys(root, path, &disk_key, 1);
> +		btrfs_fixup_low_keys(path, &disk_key, 1);
>   	return 0;
>   }
>
> @@ -1508,7 +1508,7 @@ void btrfs_set_item_key_unsafe(struct btrfs_root *=
root,
>   	btrfs_set_item_key(eb, &disk_key, slot);
>   	btrfs_mark_buffer_dirty(eb);
>   	if (slot =3D=3D 0)
> -		btrfs_fixup_low_keys(root, path, &disk_key, 1);
> +		btrfs_fixup_low_keys(path, &disk_key, 1);
>   }
>
>   /*
> @@ -2184,7 +2184,7 @@ static int push_leaf_left(struct btrfs_trans_handl=
e *trans, struct btrfs_root
>   		btrfs_mark_buffer_dirty(right);
>
>   	btrfs_item_key(right, &disk_key, 0);
> -	btrfs_fixup_low_keys(root, path, &disk_key, 1);
> +	btrfs_fixup_low_keys(path, &disk_key, 1);
>
>   	/* then fixup the leaf pointer in the path */
>   	if (path->slots[0] < push_items) {
> @@ -2415,10 +2415,8 @@ static noinline int split_leaf(struct btrfs_trans=
_handle *trans,
>   			free_extent_buffer(path->nodes[0]);
>   			path->nodes[0] =3D right;
>   			path->slots[0] =3D 0;
> -			if (path->slots[1] =3D=3D 0) {
> -				btrfs_fixup_low_keys(root, path,
> -						     &disk_key, 1);
> -			}
> +			if (path->slots[1] =3D=3D 0)
> +				btrfs_fixup_low_keys(path, &disk_key, 1);
>   		}
>   		btrfs_mark_buffer_dirty(right);
>   		return ret;
> @@ -2632,7 +2630,7 @@ int btrfs_truncate_item(struct btrfs_root *root, s=
truct btrfs_path *path,
>   		btrfs_set_disk_key_offset(&disk_key, offset + size_diff);
>   		btrfs_set_item_key(leaf, &disk_key, slot);
>   		if (slot =3D=3D 0)
> -			btrfs_fixup_low_keys(root, path, &disk_key, 1);
> +			btrfs_fixup_low_keys(path, &disk_key, 1);
>   	}
>
>   	item =3D btrfs_item_nr(slot);
> @@ -2809,7 +2807,7 @@ int btrfs_insert_empty_items(struct btrfs_trans_ha=
ndle *trans,
>   	ret =3D 0;
>   	if (slot =3D=3D 0) {
>   		btrfs_cpu_key_to_disk(&disk_key, cpu_key);
> -		btrfs_fixup_low_keys(root, path, &disk_key, 1);
> +		btrfs_fixup_low_keys(path, &disk_key, 1);
>   	}
>
>   	if (btrfs_leaf_free_space(leaf) < 0) {
> @@ -2882,7 +2880,7 @@ int btrfs_del_ptr(struct btrfs_root *root, struct =
btrfs_path *path,
>   		struct btrfs_disk_key disk_key;
>
>   		btrfs_node_key(parent, &disk_key, 0);
> -		btrfs_fixup_low_keys(root, path, &disk_key, level + 1);
> +		btrfs_fixup_low_keys(path, &disk_key, level + 1);
>   	}
>   	btrfs_mark_buffer_dirty(parent);
>   	return ret;
> @@ -2982,7 +2980,7 @@ int btrfs_del_items(struct btrfs_trans_handle *tra=
ns, struct btrfs_root *root,
>   			struct btrfs_disk_key disk_key;
>
>   			btrfs_item_key(leaf, &disk_key, 0);
> -			btrfs_fixup_low_keys(root, path, &disk_key, 1);
> +			btrfs_fixup_low_keys(path, &disk_key, 1);
>   		}
>
>   		/* delete the leaf if it is mostly empty */
> diff --git a/kernel-shared/ctree.h b/kernel-shared/ctree.h
> index f53436a7f38b..a17bf50e29b4 100644
> --- a/kernel-shared/ctree.h
> +++ b/kernel-shared/ctree.h
> @@ -2747,8 +2747,8 @@ static inline int btrfs_next_item(struct btrfs_roo=
t *root,
>
>   int btrfs_prev_leaf(struct btrfs_root *root, struct btrfs_path *path);
>   int btrfs_leaf_free_space(struct extent_buffer *leaf);
> -void btrfs_fixup_low_keys(struct btrfs_root *root, struct btrfs_path *p=
ath,
> -			  struct btrfs_disk_key *key, int level);
> +void btrfs_fixup_low_keys(struct btrfs_path *path, struct btrfs_disk_ke=
y *key,
> +		int level);
>   int btrfs_set_item_key_safe(struct btrfs_root *root, struct btrfs_path=
 *path,
>   			    struct btrfs_key *new_key);
>   void btrfs_set_item_key_unsafe(struct btrfs_root *root,
>
