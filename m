Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ADC2CE92F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Dec 2020 09:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgLDIFe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Dec 2020 03:05:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:35847 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgLDIFe (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Dec 2020 03:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607069035;
        bh=BMaKL1sgC6LNGRWDrEWgRbo2dLxvP1KsWnps3PUoevw=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=jlm9JctRFiXIZc3blPl3vqmBirkdrKO4B2sdTbcdgRJdk/2sgwSIRwZ5cvf6JELjR
         naG2pWuQy4aG6FQGzDleMCWOvlW93cNdZp0oiPjVaQYO/6zuOzJ3BRpUem2kM93y2d
         JGtTSH41qmW6SNPVnJQTdtvKVuo6vYN2mgO+uD2Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MDQeU-1kvVeh2kxq-00AYMj; Fri, 04
 Dec 2020 09:03:55 +0100
Subject: Re: [PATCH v4 05/53] btrfs: keep track of the root owner for
 relocation reads
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1607019557.git.josef@toxicpanda.com>
 <d96c58dec2b3d3564d2c176814a5b04498db0f71.1607019557.git.josef@toxicpanda.com>
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
Message-ID: <e0a5b81c-1d61-3312-1e2a-47a4edd74774@gmx.com>
Date:   Fri, 4 Dec 2020 16:03:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d96c58dec2b3d3564d2c176814a5b04498db0f71.1607019557.git.josef@toxicpanda.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="yCdi7D8Un96Ao1ikEJaPtwMwhJMJxwzH4"
X-Provags-ID: V03:K1:AynQMgbprnwRbM3UL3Tyi/Awpc30zmoeudy0Xlh3KDQJQGyovEd
 9qwAgfZxQs1kTjkJDd+PoZ07yWTZvdJJ7aUZ0wDJhSI5W2uheLI3myWX2YKFuviaAl4cxgG
 3g5r5E8ZKJD/7odi3GR/S15l+xVOAmIW+OWNSLNLIkmjX7ngwlNUMxXy2Ax1p4d/eJupOi9
 pS0GcHuUEVKLAfKGAOswA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q5W1oiv3fWM=:jysFY8l4yn+S39KUbBCICl
 LUgO4h1BtdA96lUXUaM9p0mslbO/Hww01IvWEFmFVGF7y31xy/7p6pqB9poc5cahuJ899bzts
 umcO9ez/TjaenByctmcyYasVK9daPLEpJKwL7tceBlDJLdyXNYO4Imikf515pgUARkcQRFgYT
 EEpHvVvuZmarFNhlbhEnSrPUZiJmZY28XAJ1NQnCgFFiYdjuHTtm3RpK0ErKthx4u/7peY2CQ
 RRjiS5YsihDLQbH8SAlGMo2MwiO7yt1t+2Z+s820BQIv4jvU0tY7a5garQ+Wvs8MTn6WlUkhF
 Hh+P+s7ehWqsVXpztgvSL8zJcDxiab0x/AKW3sJ5bl8rNJWZTVz4l7DxUSpTKfSc5BllfQGjA
 riYl19mGRqEDCyyX503t6UKMbtkKrbaTxUlXvofz6atva4dVXfp3bpY1xSdR5I8OiFmKnpth8
 bRIm/DhHrK4rg65GnkijMuSVpT21zndfm21BtqeNkTzE2wMpEbYaGrbLPT3Ovhg9YgE1r2kxW
 vUwjEBI4PATkBim4POL7Qm16CkM3ekRK870vToxC6+2X79sMhevsLj7VnMkeSqwjPNneFP9/F
 Z6F6xK2bV6dybMQeVJoKqNyW4zKgdJbE+K8Oro4YX19Whg5lsz2pP/qKJb+vCGWvww/w/NdDT
 DEary743/QoDJTdpPxDUGCDQdEiZrn/Ga2XqsyuSYzNSUmufwLbloaXN9kH3o2somFTBm7iBa
 yq/E+0F6KxDs3kQseu2H6vC06yxcPriaxLgtkyOUXDvPsdR+3ST7eljQyGNsittOiT1SS5bKg
 nK6fcYu8BeNiz/RZ7iUBzUpp1GP4Vn+wIaRkapIXYb4inTa53GdrwDbI3rp0vS2EjigyZpK3h
 P+bqthKrETL2H4ctcdxw==
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yCdi7D8Un96Ao1ikEJaPtwMwhJMJxwzH4
Content-Type: multipart/mixed; boundary="w3AJoQIWfSE3FMAAAWn9XO6RsnytmHf1W"

--w3AJoQIWfSE3FMAAAWn9XO6RsnytmHf1W
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/12/4 =E4=B8=8A=E5=8D=882:22, Josef Bacik wrote:
> While testing the error paths in relocation, I hit the following lockde=
p
> splat
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 5.10.0-rc3+ #206 Not tainted
> ------------------------------------------------------
> btrfs-balance/1571 is trying to acquire lock:
> ffff8cdbcc8f77d0 (&head_ref->mutex){+.+.}-{3:3}, at: btrfs_lookup_exten=
t_info+0x156/0x3b0
>=20
> but task is already holding lock:
> ffff8cdbc54adbf8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_lock+0x2=
7/0x100
>=20
> which lock already depends on the new lock.
>=20
> the existing dependency chain (in reverse order) is:
>=20
> -> #2 (btrfs-tree-00){++++}-{3:3}:
>        down_write_nested+0x43/0x80
>        __btrfs_tree_lock+0x27/0x100
>        btrfs_search_slot+0x248/0x890
>        relocate_tree_blocks+0x490/0x650
>        relocate_block_group+0x1ba/0x5d0
>        kretprobe_trampoline+0x0/0x50
>=20
> -> #1 (btrfs-csum-01){++++}-{3:3}:
>        down_read_nested+0x43/0x130
>        __btrfs_tree_read_lock+0x27/0x100
>        btrfs_read_lock_root_node+0x31/0x40
>        btrfs_search_slot+0x5ab/0x890
>        btrfs_del_csums+0x10b/0x3c0
>        __btrfs_free_extent+0x49d/0x8e0
>        __btrfs_run_delayed_refs+0x283/0x11f0
>        btrfs_run_delayed_refs+0x86/0x220
>        btrfs_start_dirty_block_groups+0x2ba/0x520
>        kretprobe_trampoline+0x0/0x50
>=20
> -> #0 (&head_ref->mutex){+.+.}-{3:3}:
>        __lock_acquire+0x1167/0x2150
>        lock_acquire+0x116/0x3e0
>        __mutex_lock+0x7e/0x7b0
>        btrfs_lookup_extent_info+0x156/0x3b0
>        walk_down_proc+0x1c3/0x280
>        walk_down_tree+0x64/0xe0
>        btrfs_drop_subtree+0x182/0x260
>        do_relocation+0x52e/0x660
>        relocate_tree_blocks+0x2ae/0x650
>        relocate_block_group+0x1ba/0x5d0
>        kretprobe_trampoline+0x0/0x50
>=20
> other info that might help us debug this:
>=20
> Chain exists of:
>   &head_ref->mutex --> btrfs-csum-01 --> btrfs-tree-00
>=20
>  Possible unsafe locking scenario:
>=20
>        CPU0                    CPU1
>        ----                    ----
>   lock(btrfs-tree-00);
>                                lock(btrfs-csum-01);
>                                lock(btrfs-tree-00);
>   lock(&head_ref->mutex);
>=20
>  *** DEADLOCK ***
>=20
> 5 locks held by btrfs-balance/1571:
>  #0: ffff8cdb89749ff8 (&fs_info->delete_unused_bgs_mutex){+.+.}-{3:3}, =
at: btrfs_balance+0x563/0xf40
>  #1: ffff8cdb89748838 (&fs_info->cleaner_mutex){+.+.}-{3:3}, at: btrfs_=
relocate_block_group+0x156/0x300
>  #2: ffff8cdbc2c16650 (sb_internal#2){.+.+}-{0:0}, at: start_transactio=
n+0x413/0x5c0
>  #3: ffff8cdbc135f538 (btrfs-treloc-01){+.+.}-{3:3}, at: __btrfs_tree_l=
ock+0x27/0x100
>  #4: ffff8cdbc54adbf8 (btrfs-tree-00){++++}-{3:3}, at: __btrfs_tree_loc=
k+0x27/0x100
>=20
> stack backtrace:
> CPU: 1 PID: 1571 Comm: btrfs-balance Not tainted 5.10.0-rc3+ #206
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 =
04/01/2014
> Call Trace:
>  dump_stack+0x8b/0xb0
>  check_noncircular+0xcf/0xf0
>  ? trace_call_bpf+0x139/0x260
>  __lock_acquire+0x1167/0x2150
>  lock_acquire+0x116/0x3e0
>  ? btrfs_lookup_extent_info+0x156/0x3b0
>  __mutex_lock+0x7e/0x7b0
>  ? btrfs_lookup_extent_info+0x156/0x3b0
>  ? btrfs_lookup_extent_info+0x156/0x3b0
>  ? release_extent_buffer+0x124/0x170
>  ? _raw_spin_unlock+0x1f/0x30
>  ? release_extent_buffer+0x124/0x170
>  btrfs_lookup_extent_info+0x156/0x3b0
>  walk_down_proc+0x1c3/0x280
>  walk_down_tree+0x64/0xe0
>  btrfs_drop_subtree+0x182/0x260
>  do_relocation+0x52e/0x660
>  relocate_tree_blocks+0x2ae/0x650
>  ? add_tree_block+0x149/0x1b0
>  relocate_block_group+0x1ba/0x5d0
>  elfcorehdr_read+0x40/0x40
>  ? elfcorehdr_read+0x40/0x40
>  ? btrfs_balance+0x796/0xf40
>  ? __kthread_parkme+0x66/0x90
>  ? btrfs_balance+0xf40/0xf40
>  ? balance_kthread+0x37/0x50
>  ? kthread+0x137/0x150
>  ? __kthread_bind_mask+0x60/0x60
>  ? ret_from_fork+0x1f/0x30
>=20
> As you can see this is bogus, we never take another tree's lock under
> the csum lock.  This happens because sometimes we have to read tree
> blocks from disk without knowing which root they belong to during
> relocation.  We defaulted to an owner of 0, which translates to an fs
> tree.  This is fine as all fs trees have the same class, but obviously
> isn't fine if the block belongs to a cow only tree.
>=20
> Thankfully cow only trees only have their owners root as a reference to=

> them, and since we already look up the extent information during
> relocation, go ahead and check and see if this block might belong to a
> cow only tree, and if so save the owner in the struct tree_block.  This=

> allows us to read_tree_block with the proper owner, which gets rid of
> this lockdep splat.
>=20
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> ---
>  fs/btrfs/relocation.c | 47 ++++++++++++++++++++++++++++++++++++++++---=

>  1 file changed, 44 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
> index 19b7db8b2117..2b30e39e922a 100644
> --- a/fs/btrfs/relocation.c
> +++ b/fs/btrfs/relocation.c
> @@ -98,6 +98,7 @@ struct tree_block {
>  		u64 bytenr;
>  	}; /* Use rb_simple_node for search/insert */
>  	struct btrfs_key key;
> +	u64 owner;
>  	unsigned int level:8;
>  	unsigned int key_ready:1;
>  };
> @@ -2393,8 +2394,8 @@ static int get_tree_block_key(struct btrfs_fs_inf=
o *fs_info,
>  {
>  	struct extent_buffer *eb;
> =20
> -	eb =3D read_tree_block(fs_info, block->bytenr, 0, block->key.offset,
> -			     block->level, NULL);
> +	eb =3D read_tree_block(fs_info, block->bytenr, block->owner,
> +			     block->key.offset, block->level, NULL);
>  	if (IS_ERR(eb)) {
>  		return PTR_ERR(eb);
>  	} else if (!extent_buffer_uptodate(eb)) {
> @@ -2493,7 +2494,8 @@ int relocate_tree_blocks(struct btrfs_trans_handl=
e *trans,
>  	/* Kick in readahead for tree blocks with missing keys */
>  	rbtree_postorder_for_each_entry_safe(block, next, blocks, rb_node) {
>  		if (!block->key_ready)
> -			btrfs_readahead_tree_block(fs_info, block->bytenr, 0, 0,
> +			btrfs_readahead_tree_block(fs_info, block->bytenr,
> +						   block->owner, 0,
>  						   block->level);
>  	}
> =20
> @@ -2801,21 +2803,59 @@ static int add_tree_block(struct reloc_control =
*rc,
>  	u32 item_size;
>  	int level =3D -1;
>  	u64 generation;
> +	u64 owner =3D 0;
> =20
>  	eb =3D  path->nodes[0];
>  	item_size =3D btrfs_item_size_nr(eb, path->slots[0]);
> =20
>  	if (extent_key->type =3D=3D BTRFS_METADATA_ITEM_KEY ||
>  	    item_size >=3D sizeof(*ei) + sizeof(*bi)) {
> +		unsigned long ptr =3D 0, end;
> +
>  		ei =3D btrfs_item_ptr(eb, path->slots[0],
>  				struct btrfs_extent_item);
> +		end =3D (unsigned long)ei + item_size;
>  		if (extent_key->type =3D=3D BTRFS_EXTENT_ITEM_KEY) {
>  			bi =3D (struct btrfs_tree_block_info *)(ei + 1);
>  			level =3D btrfs_tree_block_level(eb, bi);
> +			ptr =3D (unsigned long)(bi + 1);
>  		} else {
>  			level =3D (int)extent_key->offset;
> +			ptr =3D (unsigned long)(ei + 1);
>  		}
>  		generation =3D btrfs_extent_generation(eb, ei);
> +
> +		/*
> +		 * We're reading random blocks without knowing their owner ahead
> +		 * of time.  This is ok most of the time, as all reloc roots and
> +		 * fs roots have the same lock type.  However normal trees do
> +		 * not, and the only way to know ahead of time is to read the
> +		 * inline ref offset.  We know it's an fs root if
> +		 *
> +		 * 1. There's more than one ref.
> +		 * 2. There's a SHARED_DATA_REF_KEY set.
> +		 * 3. FULL_BACKREF is set on the flags.
> +		 *
> +		 * Otherwise it's safe to assume that the ref offset =3D=3D the
> +		 * owner of this block, so we can use that when calling
> +		 * read_tree_block.
> +		 */
> +		if (btrfs_extent_refs(eb, ei) =3D=3D 1 &&
> +		    !(btrfs_extent_flags(eb, ei) &
> +		      BTRFS_BLOCK_FLAG_FULL_BACKREF) &&
> +		    ptr < end) {
> +			struct btrfs_extent_inline_ref *iref;
> +			int type;
> +
> +			iref =3D (struct btrfs_extent_inline_ref *)ptr;
> +			type =3D btrfs_get_extent_inline_ref_type(eb, iref,
> +							BTRFS_REF_TYPE_BLOCK);
> +			if (type =3D=3D BTRFS_REF_TYPE_INVALID)
> +				return -EINVAL;
> +			if (type =3D=3D BTRFS_TREE_BLOCK_REF_KEY)
> +				owner =3D btrfs_extent_inline_ref_offset(eb,
> +								       iref);
> +		}
>  	} else if (unlikely(item_size =3D=3D sizeof(struct btrfs_extent_item_=
v0))) {
>  		btrfs_print_v0_err(eb->fs_info);
>  		btrfs_handle_fs_error(eb->fs_info, -EINVAL, NULL);
> @@ -2837,6 +2877,7 @@ static int add_tree_block(struct reloc_control *r=
c,
>  	block->key.offset =3D generation;
>  	block->level =3D level;
>  	block->key_ready =3D 0;
> +	block->owner =3D owner;
> =20
>  	rb_node =3D rb_simple_insert(blocks, block->bytenr, &block->rb_node);=

>  	if (rb_node)
>=20


--w3AJoQIWfSE3FMAAAWn9XO6RsnytmHf1W--

--yCdi7D8Un96Ao1ikEJaPtwMwhJMJxwzH4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl/J7WUACgkQwj2R86El
/qi9RAf/fI5fxyXNw2fxfxSOQu188tAhlPQHZNm3iQ/VC282bKMulxvO2AgQYA/3
dwTL4b3bBC5/Uo0MO4WcBHmiWly3Xg1Mu5aXR6sEZxPUSsYIbvg/5+9ZSfzXRR7n
Y9MBcso1JXKTv6iXWwgc1Z+1mc1cJOjzdEwLNb4NWSlAZIHqPJoN/nA/+kEwKtaz
JBcm7nxD4KT1/PsZqltUb+X9tkY0bdQm3zfVC8PJWzGo9i6XdWOKp22f11nb1zco
ANNrYEV6T1Fo+TyrTeRwb2AZn99au6JPLlQoqautI2R3veu9gh6yQzrYZlYux4wY
Y8gtHbq8lB0i95SGAulzpi+KIMuKzA==
=iPXR
-----END PGP SIGNATURE-----

--yCdi7D8Un96Ao1ikEJaPtwMwhJMJxwzH4--
