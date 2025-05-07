Return-Path: <linux-btrfs+bounces-13762-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 255B8AADB7A
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 11:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD641BA891E
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 May 2025 09:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3FE1F417E;
	Wed,  7 May 2025 09:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="QnuqQBSj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2354C9D
	for <linux-btrfs@vger.kernel.org>; Wed,  7 May 2025 09:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746610284; cv=none; b=fPqDww9TQFrFbcuf+0UV/iGuPTSU4RgcwjydPse+8zR9ZI4YU9fd3tsNs+dCZ20CUcOYsKPI0UH7x8lLHaWE2Ly7AvxMnrYxG30gWFGIwqGrA/RSY2ffBrDmiRUsZLcnkyHszfQEAQbh8r2N34xUDF9jbNo9QHYW3lWKnGRARAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746610284; c=relaxed/simple;
	bh=p4uZvoDu1+M9QzEmIE/AHvb6FlDxL0yHH8TQnhmdM88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g2ssjUtpM1EZHQln1KWguoDBA41xlcKsuxFoueX6RqhBrfH3z3ywlQlxYV3IQ88uMiLrrCw9q2dwE+EzRUCJJ/l4fhoRlzDgqRhCkk3Ozw6Et5KluPXL5FXB8Ul/99hVCasUX0fhvaF/1E4By/CSonHNboTm/FVu9swxOJPhgjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=QnuqQBSj; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1746610274; x=1747215074; i=quwenruo.btrfs@gmx.com;
	bh=dobhGEFPAbtoFr5d1ntLnLJgnyyp7+BXQudsyTAqpLs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=QnuqQBSjdGr8ma74zVFvNMpmxo6YALGW4/PqlVje+bI/8wgaIahG+zNNv9Cd3Ig+
	 t9ZeKgonulPdjIpfJHzVCobFzhtnHJ9KCbY3+sfG9PIbT+vW/NdsCw256CZVUtwOO
	 HCA9zzkHWt8wJZwYTG6IbOfbD2HOMLZnDzb3fw6pmny2l6xHc6CAva+lNmbzkR/Y3
	 O/lhWRquTUFldQJuMIBHCkRCcfw8slL93QPVozcf7/XJzupQftclYvtHsh/9e0a+D
	 HCfBVtPoehwWLUImMNChkqAPzLIF1mWjHXBY8ZOXN9JW8334wO6HYffnqe/AYZqbx
	 QSjSYr2ravcTVO6g5A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.229] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQvD5-1uQAIY1m6h-00LZox; Wed, 07
 May 2025 11:31:14 +0200
Message-ID: <7ce4531e-7534-4aea-a70a-8955462f4280@gmx.com>
Date: Wed, 7 May 2025 19:01:05 +0930
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] btrfs: convert the buffer_radix to an xarray
To: Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>
References: <cover.1745851722.git.josef@toxicpanda.com>
 <b03b3a49255646818261cf5ce02cfdea656acffd.1745851722.git.josef@toxicpanda.com>
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
In-Reply-To: <b03b3a49255646818261cf5ce02cfdea656acffd.1745851722.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:csNx/3BHY1vZN0i2ck9ARP8GzW+nOBObpnHgwYYzTlUVY4YS+q8
 rlA9mFEYv+PUuanrxIykWzxcpnEEONYfojmjZOnNGbhpRCSaOLTLe/A+zasa42sV7O5wTJz
 sWDZq50Fwb5goXAt1EwPeJCtLK4Y3XxmNYgb5yY7tKDmCw1X1bk+yxWWRqGrv7WvPoZ4KNh
 SqQ70QeehBDRsAqnfM6Xw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FqMU6ZpmlOQ=;85of2bS0wGdTbVEZ4UMIIUzt6sU
 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
 vy0k=



=E5=9C=A8 2025/4/29 00:22, Josef Bacik =E5=86=99=E9=81=93:
> In order to fully utilize xarray tagging to improve writeback we need to
> convert the buffer_radix to a proper xarray.  This conversion is
> relatively straightforward as the radix code uses the xarray underneath.
> Using xarray directly allows for quite a lot less code.
>=20
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Unfortauntely this is causing problems for aarch64 subpage cases, where=20
the page size is 64K, and fs block size is 4K.

It's causing the extent buffer leak detector go crazy for every test case:

[ 1766.425913] BTRFS info (device dm-2): last unmount of filesystem=20
b15f2893-4948-4c0c-a380-03d8b88234a2
[ 1766.430207] BTRFS warning (device dm-2): folio private not zero on=20
folio 22020096
[ 1766.430224] BTRFS warning (device dm-2): folio private not zero on=20
folio 30408704
[ 1766.430241] BTRFS warning (device dm-2): folio private not zero on=20
folio 30539776
[ 1766.432235] ------------[ cut here ]------------
[ 1766.432298] WARNING: CPU: 3 PID: 27284 at extent_io.c:73=20
btrfs_extent_buffer_leak_debug_check+0x80/0x150 [btrfs]
[ 1766.437876] Modules linked in: btrfs(OE) nls_ascii nls_cp437 vfat fat=
=20
polyval_ce polyval_generic ghash_ce rtc_efi xor xor_neon raid6_pq=20
processor zstd_compress fuse loop nfnetlink qemu_fw_cfg ext4 crc16=20
mbcache jbd2 dm_mod xhci_pci xhci_hcd virtio_scsi virtio_blk=20
virtio_balloon virtio_net virtio_console net_failover failover virtio_mmio
[ 1766.437919] Unloaded tainted modules: btrfs(OE):14 [last unloaded:=20
btrfs(OE)]
[ 1766.443832] CPU: 3 UID: 0 PID: 27284 Comm: umount Tainted: G        W=
=20
  OE       6.15.0-rc5-custom+ #119 PREEMPT(voluntary)
[ 1766.445617] Tainted: [W]=3DWARN, [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODUL=
E
[ 1766.446621] Hardware name: QEMU KVM Virtual Machine, BIOS unknown=20
2/2/2022
[ 1766.447717] pstate: 20400005 (nzCv daif +PAN -UAO -TCO -DIT -SSBS=20
BTYPE=3D--)
[ 1766.448827] pc : btrfs_extent_buffer_leak_debug_check+0x80/0x150 [btrfs=
]
[ 1766.450093] lr : btrfs_free_fs_info+0x134/0x1a0 [btrfs]
[ 1766.451101] sp : ffff80008588fcc0
[ 1766.451654] x29: ffff80008588fcc0 x28: ffff03e6ffe31d80 x27:=20
0000000000000000
[ 1766.452827] x26: 0000000000000000 x25: 0000000000000000 x24:=20
0000000000000000
[ 1766.454001] x23: ffff03e6ffe3285c x22: ffff03e7c1446e00 x21:=20
ffff03e7c1446ef0
[ 1766.455174] x20: ffff03e7c1446000 x19: ffff03e7c1446000 x18:=20
0000000000000228
[ 1766.456354] x17: ffffffdfc0000000 x16: ffffcedfe8577f48 x15:=20
ffff03e70a3dc4c8
[ 1766.457522] x14: 0000000000000000 x13: ffff03e6e0075c10 x12:=20
ffff03e70a3dc430
[ 1766.458690] x11: 0000000000000012 x10: ffff03e6e0075c18 x9 :=20
ffffcedfcfd0babc
[ 1766.459860] x8 : ffff80008588fcd0 x7 : fefefefefefefefe x6 :=20
0000000000000000
[ 1766.461025] x5 : 0000000000000000 x4 : ffffffe0b9bb8a20 x3 :=20
000000008020001d
[ 1766.462189] x2 : 0000000000000000 x1 : 0000000000000000 x0 :=20
ffff03e6edc665b8
[ 1766.463360] Call trace:
[ 1766.463763]  btrfs_extent_buffer_leak_debug_check+0x80/0x150 [btrfs] (P=
)
[ 1766.465002]  btrfs_free_fs_info+0x134/0x1a0 [btrfs]
[ 1766.465938]  btrfs_kill_super+0x28/0x38 [btrfs]
[ 1766.466823]  deactivate_locked_super+0x4c/0x100
[ 1766.467577]  deactivate_super+0x8c/0xb0
[ 1766.468209]  cleanup_mnt+0xb4/0x150
[ 1766.468796]  __cleanup_mnt+0x1c/0x30
[ 1766.469391]  task_work_run+0x80/0x110
[ 1766.469997]  do_notify_resume+0x158/0x190
[ 1766.470665]  el0_svc+0xf4/0x148
[ 1766.471183]  el0t_64_sync_handler+0x10c/0x140
[ 1766.471898]  el0t_64_sync+0x198/0x1a0
[ 1766.472505] ---[ end trace 0000000000000000 ]---
[ 1766.473363] BTRFS: buffer leak start 30588928 len 16384 refs 1 bflags=
=20
5 owner 10

Thanks,
Qu

> ---
>   fs/btrfs/disk-io.c           |  15 ++-
>   fs/btrfs/extent_io.c         | 199 ++++++++++++++++-------------------
>   fs/btrfs/fs.h                |   4 +-
>   fs/btrfs/tests/btrfs-tests.c |  28 ++---
>   fs/btrfs/zoned.c             |  16 +--
>   5 files changed, 112 insertions(+), 150 deletions(-)
>=20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 59da809b7d57..24c08eb86b7b 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -2762,10 +2762,22 @@ static int __cold init_tree_roots(struct btrfs_f=
s_info *fs_info)
>   	return ret;
>   }
>  =20
> +/*
> + * lockdep gets confused between our buffer_tree which requires IRQ loc=
king
> + * because we modify marks in the IRQ context, and our delayed inode xa=
rray
> + * which doesn't have these requirements. Use a class key so lockdep do=
esn't get
> + * them mixed up.
> + */
> +static struct lock_class_key buffer_xa_class;
> +
>   void btrfs_init_fs_info(struct btrfs_fs_info *fs_info)
>   {
>   	INIT_RADIX_TREE(&fs_info->fs_roots_radix, GFP_ATOMIC);
> -	INIT_RADIX_TREE(&fs_info->buffer_radix, GFP_ATOMIC);
> +
> +	/* Use the same flags as mapping->i_pages. */
> +	xa_init_flags(&fs_info->buffer_tree, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ACCO=
UNT);
> +	lockdep_set_class(&fs_info->buffer_tree.xa_lock, &buffer_xa_class);
> +
>   	INIT_LIST_HEAD(&fs_info->trans_list);
>   	INIT_LIST_HEAD(&fs_info->dead_roots);
>   	INIT_LIST_HEAD(&fs_info->delayed_iputs);
> @@ -2777,7 +2789,6 @@ void btrfs_init_fs_info(struct btrfs_fs_info *fs_i=
nfo)
>   	spin_lock_init(&fs_info->delayed_iput_lock);
>   	spin_lock_init(&fs_info->defrag_inodes_lock);
>   	spin_lock_init(&fs_info->super_lock);
> -	spin_lock_init(&fs_info->buffer_lock);
>   	spin_lock_init(&fs_info->unused_bgs_lock);
>   	spin_lock_init(&fs_info->treelog_bg_lock);
>   	spin_lock_init(&fs_info->zone_active_bgs_lock);
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index 6cfd286b8bbc..bedcacaf809f 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1893,19 +1893,17 @@ static void set_btree_ioerr(struct extent_buffer=
 *eb)
>    * context.
>    */
>   static struct extent_buffer *find_extent_buffer_nolock(
> -		const struct btrfs_fs_info *fs_info, u64 start)
> +		struct btrfs_fs_info *fs_info, u64 start)
>   {
>   	struct extent_buffer *eb;
> +	unsigned long index =3D start >> fs_info->sectorsize_bits;
>  =20
>   	rcu_read_lock();
> -	eb =3D radix_tree_lookup(&fs_info->buffer_radix,
> -			       start >> fs_info->sectorsize_bits);
> -	if (eb && atomic_inc_not_zero(&eb->refs)) {
> -		rcu_read_unlock();
> -		return eb;
> -	}
> +	eb =3D xa_load(&fs_info->buffer_tree, index);
> +	if (eb && !atomic_inc_not_zero(&eb->refs))
> +		eb =3D NULL;
>   	rcu_read_unlock();
> -	return NULL;
> +	return eb;
>   }
>  =20
>   static void end_bbio_meta_write(struct btrfs_bio *bbio)
> @@ -2769,11 +2767,10 @@ static void detach_extent_buffer_folio(const str=
uct extent_buffer *eb, struct fo
>  =20
>   	if (!btrfs_meta_is_subpage(fs_info)) {
>   		/*
> -		 * We do this since we'll remove the pages after we've
> -		 * removed the eb from the radix tree, so we could race
> -		 * and have this page now attached to the new eb.  So
> -		 * only clear folio if it's still connected to
> -		 * this eb.
> +		 * We do this since we'll remove the pages after we've removed
> +		 * the eb from the xarray, so we could race and have this page
> +		 * now attached to the new eb.  So only clear folio if it's
> +		 * still connected to this eb.
>   		 */
>   		if (folio_test_private(folio) && folio_get_private(folio) =3D=3D eb)=
 {
>   			BUG_ON(test_bit(EXTENT_BUFFER_DIRTY, &eb->bflags));
> @@ -2938,9 +2935,9 @@ static void check_buffer_tree_ref(struct extent_bu=
ffer *eb)
>   {
>   	int refs;
>   	/*
> -	 * The TREE_REF bit is first set when the extent_buffer is added
> -	 * to the radix tree. It is also reset, if unset, when a new reference
> -	 * is created by find_extent_buffer.
> +	 * The TREE_REF bit is first set when the extent_buffer is added to th=
e
> +	 * xarray. It is also reset, if unset, when a new reference is created
> +	 * by find_extent_buffer.
>   	 *
>   	 * It is only cleared in two cases: freeing the last non-tree
>   	 * reference to the extent_buffer when its STALE bit is set or
> @@ -2952,13 +2949,12 @@ static void check_buffer_tree_ref(struct extent_=
buffer *eb)
>   	 * conditions between the calls to check_buffer_tree_ref in those
>   	 * codepaths and clearing TREE_REF in try_release_extent_buffer.
>   	 *
> -	 * The actual lifetime of the extent_buffer in the radix tree is
> -	 * adequately protected by the refcount, but the TREE_REF bit and
> -	 * its corresponding reference are not. To protect against this
> -	 * class of races, we call check_buffer_tree_ref from the codepaths
> -	 * which trigger io. Note that once io is initiated, TREE_REF can no
> -	 * longer be cleared, so that is the moment at which any such race is
> -	 * best fixed.
> +	 * The actual lifetime of the extent_buffer in the xarray is adequatel=
y
> +	 * protected by the refcount, but the TREE_REF bit and its correspondi=
ng
> +	 * reference are not. To protect against this class of races, we call
> +	 * check_buffer_tree_ref from the codepaths which trigger io. Note tha=
t
> +	 * once io is initiated, TREE_REF can no longer be cleared, so that is
> +	 * the moment at which any such race is best fixed.
>   	 */
>   	refs =3D atomic_read(&eb->refs);
>   	if (refs >=3D 2 && test_bit(EXTENT_BUFFER_TREE_REF, &eb->bflags))
> @@ -3022,23 +3018,26 @@ struct extent_buffer *alloc_test_extent_buffer(s=
truct btrfs_fs_info *fs_info,
>   		return ERR_PTR(-ENOMEM);
>   	eb->fs_info =3D fs_info;
>   again:
> -	ret =3D radix_tree_preload(GFP_NOFS);
> -	if (ret) {
> -		exists =3D ERR_PTR(ret);
> +	xa_lock_irq(&fs_info->buffer_tree);
> +	exists =3D __xa_cmpxchg(&fs_info->buffer_tree,
> +			      start >> fs_info->sectorsize_bits, NULL, eb,
> +			      GFP_NOFS);
> +	if (xa_is_err(exists)) {
> +		ret =3D xa_err(exists);
> +		xa_unlock_irq(&fs_info->buffer_tree);
> +		btrfs_release_extent_buffer(eb);
> +		return ERR_PTR(ret);
> +	}
> +	if (exists) {
> +		if (!atomic_inc_not_zero(&exists->refs)) {
> +			/* The extent buffer is being freed, retry. */
> +			xa_unlock_irq(&fs_info->buffer_tree);
> +			goto again;
> +		}
> +		xa_unlock_irq(&fs_info->buffer_tree);
>   		goto free_eb;
>   	}
> -	spin_lock(&fs_info->buffer_lock);
> -	ret =3D radix_tree_insert(&fs_info->buffer_radix,
> -				start >> fs_info->sectorsize_bits, eb);
> -	spin_unlock(&fs_info->buffer_lock);
> -	radix_tree_preload_end();
> -	if (ret =3D=3D -EEXIST) {
> -		exists =3D find_extent_buffer(fs_info, start);
> -		if (exists)
> -			goto free_eb;
> -		else
> -			goto again;
> -	}
> +	xa_unlock_irq(&fs_info->buffer_tree);
>   	check_buffer_tree_ref(eb);
>  =20
>   	return eb;
> @@ -3059,9 +3058,9 @@ static struct extent_buffer *grab_extent_buffer(st=
ruct btrfs_fs_info *fs_info,
>   	lockdep_assert_held(&folio->mapping->i_private_lock);
>  =20
>   	/*
> -	 * For subpage case, we completely rely on radix tree to ensure we
> -	 * don't try to insert two ebs for the same bytenr.  So here we always
> -	 * return NULL and just continue.
> +	 * For subpage case, we completely rely on xarray to ensure we don't t=
ry
> +	 * to insert two ebs for the same bytenr.  So here we always return NU=
LL
> +	 * and just continue.
>   	 */
>   	if (btrfs_meta_is_subpage(fs_info))
>   		return NULL;
> @@ -3194,7 +3193,7 @@ static int attach_eb_folio_to_filemap(struct exten=
t_buffer *eb, int i,
>   	/*
>   	 * To inform we have an extra eb under allocation, so that
>   	 * detach_extent_buffer_page() won't release the folio private when t=
he
> -	 * eb hasn't been inserted into radix tree yet.
> +	 * eb hasn't been inserted into the xarray yet.
>   	 *
>   	 * The ref will be decreased when the eb releases the page, in
>   	 * detach_extent_buffer_page().  Thus needs no special handling in th=
e
> @@ -3328,10 +3327,10 @@ struct extent_buffer *alloc_extent_buffer(struct=
 btrfs_fs_info *fs_info,
>  =20
>   		/*
>   		 * We can't unlock the pages just yet since the extent buffer
> -		 * hasn't been properly inserted in the radix tree, this
> -		 * opens a race with btree_release_folio which can free a page
> -		 * while we are still filling in all pages for the buffer and
> -		 * we could crash.
> +		 * hasn't been properly inserted in the xarray, this opens a
> +		 * race with btree_release_folio which can free a page while we
> +		 * are still filling in all pages for the buffer and we could
> +		 * crash.
>   		 */
>   	}
>   	if (uptodate)
> @@ -3340,23 +3339,25 @@ struct extent_buffer *alloc_extent_buffer(struct=
 btrfs_fs_info *fs_info,
>   	if (page_contig)
>   		eb->addr =3D folio_address(eb->folios[0]) + offset_in_page(eb->start=
);
>   again:
> -	ret =3D radix_tree_preload(GFP_NOFS);
> -	if (ret)
> +	xa_lock_irq(&fs_info->buffer_tree);
> +	existing_eb =3D __xa_cmpxchg(&fs_info->buffer_tree,
> +				   start >> fs_info->sectorsize_bits, NULL, eb,
> +				   GFP_NOFS);
> +	if (xa_is_err(existing_eb)) {
> +		ret =3D xa_err(existing_eb);
> +		xa_unlock_irq(&fs_info->buffer_tree);
>   		goto out;
> -
> -	spin_lock(&fs_info->buffer_lock);
> -	ret =3D radix_tree_insert(&fs_info->buffer_radix,
> -				start >> fs_info->sectorsize_bits, eb);
> -	spin_unlock(&fs_info->buffer_lock);
> -	radix_tree_preload_end();
> -	if (ret =3D=3D -EEXIST) {
> -		ret =3D 0;
> -		existing_eb =3D find_extent_buffer(fs_info, start);
> -		if (existing_eb)
> -			goto out;
> -		else
> -			goto again;
>   	}
> +	if (existing_eb) {
> +		if (!atomic_inc_not_zero(&existing_eb->refs)) {
> +			xa_unlock_irq(&fs_info->buffer_tree);
> +			goto again;
> +		}
> +		xa_unlock_irq(&fs_info->buffer_tree);
> +		goto out;
> +	}
> +	xa_unlock_irq(&fs_info->buffer_tree);
> +
>   	/* add one reference for the tree */
>   	check_buffer_tree_ref(eb);
>  =20
> @@ -3426,10 +3427,23 @@ static int release_extent_buffer(struct extent_b=
uffer *eb)
>  =20
>   		spin_unlock(&eb->refs_lock);
>  =20
> -		spin_lock(&fs_info->buffer_lock);
> -		radix_tree_delete_item(&fs_info->buffer_radix,
> -				       eb->start >> fs_info->sectorsize_bits, eb);
> -		spin_unlock(&fs_info->buffer_lock);
> +		/*
> +		 * We're erasing, theoretically there will be no allocations, so
> +		 * just use GFP_ATOMIC.
> +		 *
> +		 * We use cmpxchg instead of erase because we do not know if
> +		 * this eb is actually in the tree or not, we could be cleaning
> +		 * up an eb that we allocated but never inserted into the tree.
> +		 * Thus use cmpxchg to remove it from the tree if it is there,
> +		 * or leave the other entry if this isn't in the tree.
> +		 *
> +		 * The documentation says that putting a NULL value is the same
> +		 * as erase as long as XA_FLAGS_ALLOC is not set, which it isn't
> +		 * in this case.
> +		 */
> +		xa_cmpxchg_irq(&fs_info->buffer_tree,
> +			       eb->start >> fs_info->sectorsize_bits, eb, NULL,
> +			       GFP_ATOMIC);
>  =20
>   		btrfs_leak_debug_del_eb(eb);
>   		/* Should be safe to release folios at this point. */
> @@ -4260,44 +4274,6 @@ void memmove_extent_buffer(const struct extent_bu=
ffer *dst,
>   	}
>   }
>  =20
> -#define GANG_LOOKUP_SIZE	16
> -static struct extent_buffer *get_next_extent_buffer(
> -		const struct btrfs_fs_info *fs_info, struct folio *folio, u64 bytenr)
> -{
> -	struct extent_buffer *gang[GANG_LOOKUP_SIZE];
> -	struct extent_buffer *found =3D NULL;
> -	u64 folio_start =3D folio_pos(folio);
> -	u64 cur =3D folio_start;
> -
> -	ASSERT(in_range(bytenr, folio_start, PAGE_SIZE));
> -	lockdep_assert_held(&fs_info->buffer_lock);
> -
> -	while (cur < folio_start + PAGE_SIZE) {
> -		int ret;
> -		int i;
> -
> -		ret =3D radix_tree_gang_lookup(&fs_info->buffer_radix,
> -				(void **)gang, cur >> fs_info->sectorsize_bits,
> -				min_t(unsigned int, GANG_LOOKUP_SIZE,
> -				      PAGE_SIZE / fs_info->nodesize));
> -		if (ret =3D=3D 0)
> -			goto out;
> -		for (i =3D 0; i < ret; i++) {
> -			/* Already beyond page end */
> -			if (gang[i]->start >=3D folio_start + PAGE_SIZE)
> -				goto out;
> -			/* Found one */
> -			if (gang[i]->start >=3D bytenr) {
> -				found =3D gang[i];
> -				goto out;
> -			}
> -		}
> -		cur =3D gang[ret - 1]->start + gang[ret - 1]->len;
> -	}
> -out:
> -	return found;
> -}
> -
>   static int try_release_subpage_extent_buffer(struct folio *folio)
>   {
>   	struct btrfs_fs_info *fs_info =3D folio_to_fs_info(folio);
> @@ -4306,21 +4282,22 @@ static int try_release_subpage_extent_buffer(str=
uct folio *folio)
>   	int ret;
>  =20
>   	while (cur < end) {
> +		unsigned long index =3D cur >> fs_info->sectorsize_bits;
>   		struct extent_buffer *eb =3D NULL;
>  =20
>   		/*
>   		 * Unlike try_release_extent_buffer() which uses folio private
> -		 * to grab buffer, for subpage case we rely on radix tree, thus
> -		 * we need to ensure radix tree consistency.
> +		 * to grab buffer, for subpage case we rely on xarray, thus we
> +		 * need to ensure xarray tree consistency.
>   		 *
> -		 * We also want an atomic snapshot of the radix tree, thus go
> +		 * We also want an atomic snapshot of the xarray tree, thus go
>   		 * with spinlock rather than RCU.
>   		 */
> -		spin_lock(&fs_info->buffer_lock);
> -		eb =3D get_next_extent_buffer(fs_info, folio, cur);
> +		xa_lock_irq(&fs_info->buffer_tree);
> +		eb =3D xa_load(&fs_info->buffer_tree, index);
>   		if (!eb) {
>   			/* No more eb in the page range after or at cur */
> -			spin_unlock(&fs_info->buffer_lock);
> +			xa_unlock_irq(&fs_info->buffer_tree);
>   			break;
>   		}
>   		cur =3D eb->start + eb->len;
> @@ -4332,10 +4309,10 @@ static int try_release_subpage_extent_buffer(str=
uct folio *folio)
>   		spin_lock(&eb->refs_lock);
>   		if (atomic_read(&eb->refs) !=3D 1 || extent_buffer_under_io(eb)) {
>   			spin_unlock(&eb->refs_lock);
> -			spin_unlock(&fs_info->buffer_lock);
> +			xa_unlock_irq(&fs_info->buffer_tree);
>   			break;
>   		}
> -		spin_unlock(&fs_info->buffer_lock);
> +		xa_unlock_irq(&fs_info->buffer_tree);
>  =20
>   		/*
>   		 * If tree ref isn't set then we know the ref on this eb is a
> diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> index bcca43046064..ed02d276d908 100644
> --- a/fs/btrfs/fs.h
> +++ b/fs/btrfs/fs.h
> @@ -776,10 +776,8 @@ struct btrfs_fs_info {
>  =20
>   	struct btrfs_delayed_root *delayed_root;
>  =20
> -	/* Extent buffer radix tree */
> -	spinlock_t buffer_lock;
>   	/* Entries are eb->start / sectorsize */
> -	struct radix_tree_root buffer_radix;
> +	struct xarray buffer_tree;
>  =20
>   	/* Next backup root to be overwritten */
>   	int backup_root_index;
> diff --git a/fs/btrfs/tests/btrfs-tests.c b/fs/btrfs/tests/btrfs-tests.c
> index 02a915eb51fb..b576897d71cc 100644
> --- a/fs/btrfs/tests/btrfs-tests.c
> +++ b/fs/btrfs/tests/btrfs-tests.c
> @@ -157,9 +157,9 @@ struct btrfs_fs_info *btrfs_alloc_dummy_fs_info(u32 =
nodesize, u32 sectorsize)
>  =20
>   void btrfs_free_dummy_fs_info(struct btrfs_fs_info *fs_info)
>   {
> -	struct radix_tree_iter iter;
> -	void **slot;
>   	struct btrfs_device *dev, *tmp;
> +	struct extent_buffer *eb;
> +	unsigned long index;
>  =20
>   	if (!fs_info)
>   		return;
> @@ -169,25 +169,13 @@ void btrfs_free_dummy_fs_info(struct btrfs_fs_info=
 *fs_info)
>  =20
>   	test_mnt->mnt_sb->s_fs_info =3D NULL;
>  =20
> -	spin_lock(&fs_info->buffer_lock);
> -	radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter, 0) {
> -		struct extent_buffer *eb;
> -
> -		eb =3D radix_tree_deref_slot_protected(slot, &fs_info->buffer_lock);
> -		if (!eb)
> -			continue;
> -		/* Shouldn't happen but that kind of thinking creates CVE's */
> -		if (radix_tree_exception(eb)) {
> -			if (radix_tree_deref_retry(eb))
> -				slot =3D radix_tree_iter_retry(&iter);
> -			continue;
> -		}
> -		slot =3D radix_tree_iter_resume(slot, &iter);
> -		spin_unlock(&fs_info->buffer_lock);
> -		free_extent_buffer_stale(eb);
> -		spin_lock(&fs_info->buffer_lock);
> +	xa_lock_irq(&fs_info->buffer_tree);
> +	xa_for_each(&fs_info->buffer_tree, index, eb) {
> +		xa_unlock_irq(&fs_info->buffer_tree);
> +		free_extent_buffer(eb);
> +		xa_lock_irq(&fs_info->buffer_tree);
>   	}
> -	spin_unlock(&fs_info->buffer_lock);
> +	xa_unlock_irq(&fs_info->buffer_tree);
>  =20
>   	btrfs_mapping_tree_free(fs_info);
>   	list_for_each_entry_safe(dev, tmp, &fs_info->fs_devices->devices,
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index 7b30700ec930..4b59bc480663 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -2171,27 +2171,15 @@ static void wait_eb_writebacks(struct btrfs_bloc=
k_group *block_group)
>   {
>   	struct btrfs_fs_info *fs_info =3D block_group->fs_info;
>   	const u64 end =3D block_group->start + block_group->length;
> -	struct radix_tree_iter iter;
>   	struct extent_buffer *eb;
> -	void __rcu **slot;
> +	unsigned long index, start =3D block_group->start >> fs_info->sectorsi=
ze_bits;
>  =20
>   	rcu_read_lock();
> -	radix_tree_for_each_slot(slot, &fs_info->buffer_radix, &iter,
> -				 block_group->start >> fs_info->sectorsize_bits) {
> -		eb =3D radix_tree_deref_slot(slot);
> -		if (!eb)
> -			continue;
> -		if (radix_tree_deref_retry(eb)) {
> -			slot =3D radix_tree_iter_retry(&iter);
> -			continue;
> -		}
> -
> +	xa_for_each_start(&fs_info->buffer_tree, index, eb, start) {
>   		if (eb->start < block_group->start)
>   			continue;
>   		if (eb->start >=3D end)
>   			break;
> -
> -		slot =3D radix_tree_iter_resume(slot, &iter);
>   		rcu_read_unlock();
>   		wait_on_extent_buffer_writeback(eb);
>   		rcu_read_lock();


