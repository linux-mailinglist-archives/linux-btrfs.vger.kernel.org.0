Return-Path: <linux-btrfs+bounces-22215-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNQeHszRp2l7kAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22215-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 07:31:40 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 150301FB2DD
	for <lists+linux-btrfs@lfdr.de>; Wed, 04 Mar 2026 07:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D54A3058E37
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2026 06:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82665351C1E;
	Wed,  4 Mar 2026 06:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="fTxfhkIR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009C18A92F
	for <linux-btrfs@vger.kernel.org>; Wed,  4 Mar 2026 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772605887; cv=none; b=LWpH56W46EhMcfMKv+Mb/FvJ/s3w0NmBvLgsQR+I7RVeMmmoQHyV78dLV1gCTEX2MUOkRtkULJ76PRvGnV/Ss8lH+dqYrUyQF80q/9FyY+bRwIqGTWQFfTPX9Iw5prNBYzjMLJF3/cHPicziLqYyX5yBlXULASUdicDigDvKSKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772605887; c=relaxed/simple;
	bh=oWcalOwV1+wWZR59J1Y5MQcWh9Djsdjvza+OXO9E1Yk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUw4afXmk7Dp3Oc0p3wDKcIDDWY8EcNkfr5EcPl0k0cz5HorG9g/SBoZYeMNWxMM3ortvbz1+1of4YJP1TrMZOPZXubW2HnjwYZUh0Dt61hgWdbKLOoKM+7JfifmuUVcYNuVtscMuZAQCm/fDt8w6Zbpep4nVInwzNZ4LY5TPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=fTxfhkIR; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1772605883; x=1773210683; i=quwenruo.btrfs@gmx.com;
	bh=Kn6JhPICb2PLDhdZSSPhOYNKzdBtUI0Tnpv5AEhbXyk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fTxfhkIRrxdLFMihwZQVDPUj3vdLVAjhqq8CeJU0sa6Ru0EPUmkzHYnOxmP5Jrtl
	 2M6HRlL16PSToOAoNhEyqBtObKpCZgz/woW1SlQjySkO1WgsCmeB54e1YglAEj140
	 HnkNvf8MRFcpb/gwRHdTkxbrbi87brpE+xT3YAf6jJKS5VvKgRaY49pFQtD89vk/I
	 Zk6ol9FZhDC5qi/WYXmg+ATt3/MwQFKFRtJSwpY3P74vHkXvBUieEDxGdH4SROzTO
	 R41t4vnnFuwrJK4bCmm1wGGx9jEAqH5u6KKqfVj7fU3PBnYm61gNZlV3mqXRw9KZY
	 eJjkqCV6cJTKvioO6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MyKHm-1vlMXO3dHw-014naV; Wed, 04
 Mar 2026 07:31:23 +0100
Message-ID: <3f85a632-d062-4006-8bd7-1048c60197ef@gmx.com>
Date: Wed, 4 Mar 2026 17:01:19 +1030
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] btrfs: skip COW for written extent buffers
 allocated in current transaction
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com
Cc: Filipe Manana <fdmanana@suse.com>, Sun YangKai <sunk67188@gmail.com>
References: <cover.1772097864.git.loemra.dev@gmail.com>
 <e8e4f5e396d821ba9ed6a4eee073ae8628d52aeb.1772097864.git.loemra.dev@gmail.com>
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
In-Reply-To: <e8e4f5e396d821ba9ed6a4eee073ae8628d52aeb.1772097864.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tcbzw1I/fUd8nwKIayNNR6j7QWFwmPGUo0HD2soSFJXNVtxa3O3
 xzVrCkh2toEC7OVDgh9IWBgcaqj9G/uSVLY8/b6x7XPCDY/snLDZ9008D2AZrNOO9y7KLHK
 /HQ99+UaIOwfnStco9sXeHIYl0UXcZk2SvtNXYkMUHUy/nYiLLE3pWmn+EgWqvN2mEroMaX
 FCZ0vb61BrxBgGulLBrYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S5C6hwn4mcA=;z2hCf6VcvB09S+52V//nsTdaqSw
 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
X-Rspamd-Queue-Id: 150301FB2DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gmx.com:s=s31663417];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22215-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,fb.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmx.com:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[quwenruo.btrfs@gmx.com,linux-btrfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[suse.com,gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,gmx.com:dkim,gmx.com:mid]
X-Rspamd-Action: no action



=E5=9C=A8 2026/2/26 20:21, Leo Martins =E5=86=99=E9=81=93:
> When memory pressure causes writeback of a recently COW'd buffer,
> btrfs sets BTRFS_HEADER_FLAG_WRITTEN on it. Subsequent
> btrfs_search_slot() restarts then see the WRITTEN flag and re-COW
> the buffer unnecessarily, causing COW amplification that can exhaust
> block reservations and degrade throughput.
>=20
> Overwriting in place is crash-safe because the committed superblock
> does not reference buffers allocated in the current (uncommitted)
> transaction, so no on-disk tree points to this block yet.
>=20
> When should_cow_block() encounters a WRITTEN buffer whose generation
> matches the current transaction, instead of requesting a COW, re-dirty
> the buffer and re-register its range in the transaction's dirty_pages.
>=20
> Both are necessary because btrfs tracks dirty metadata through two
> independent mechanisms. set_extent_buffer_dirty() sets the
> EXTENT_BUFFER_DIRTY flag and the buffer_tree xarray PAGECACHE_TAG_DIRTY
> mark, which is what background writeback (btree_write_cache_pages) uses
> to find and write dirty buffers. The transaction's dirty_pages io tree
> is a separate structure used by btrfs_write_and_wait_transaction() at
> commit time to ensure all buffers allocated during the transaction are
> persisted. The dirty_pages range was originally registered in
> btrfs_init_new_buffer() when the block was first allocated. Normally
> dirty_pages is only cleared at commit time by
> btrfs_write_and_wait_transaction(), but if qgroups are enabled and
> snapshots are being created, qgroup_account_snapshot() may have already
> called btrfs_write_and_wait_transaction() and released the range before
> the final commit-time call.
>=20
> Keep BTRFS_HEADER_FLAG_WRITTEN set so that btrfs_free_tree_block()
> correctly pins the block if it is freed later.
>=20
> Relax the lockdep assertion in btrfs_mark_buffer_dirty() from
> btrfs_assert_tree_write_locked() to lockdep_assert_held() so that it
> accepts either a read or write lock. should_cow_block() may be called
> from btrfs_search_slot() when only a read lock is held (nodes above
> write_lock_level are read-locked). The write lock assertion previously
> documented the caller convention that buffer content was being modified
> under exclusive access, but btrfs_mark_buffer_dirty() and
> set_extent_buffer_dirty() themselves only perform independently
> synchronized operations: atomic bit ops on bflags, folio_mark_dirty()
> (kernel-internal folio locking), xarray mark updates (xarray spinlock),
> and percpu counter updates. The read lock is sufficient because it
> prevents lock_extent_buffer_for_io() from acquiring the write lock and
> racing on the dirty state. Since rw_semaphore permits concurrent
> readers, multiple threads can enter btrfs_mark_buffer_dirty()
> simultaneously for the same buffer; this is safe because
> test_and_set_bit(EXTENT_BUFFER_DIRTY) ensures only one thread performs
> the full dirty state transition.
>=20
> Remove the CONFIG_BTRFS_DEBUG assertion in set_extent_buffer_dirty()
> that checked folio_test_dirty() after marking the buffer dirty. This
> assertion assumed exclusive access (only one thread in
> set_extent_buffer_dirty() at a time), which held when the only caller
> was btrfs_mark_buffer_dirty() under write lock. With concurrent readers
> calling through should_cow_block(), a thread that loses the
> test_and_set_bit race sees was_dirty=3Dtrue and skips the folio dirty
> marking, but the winning thread may not have called
> btrfs_meta_folio_set_dirty() yet, causing the assertion to fire. This
> is a benign race: the winning thread will complete the folio dirty
> marking, and no writeback can clear it while readers hold their locks.
>=20
> Hoist the EXTENT_BUFFER_WRITEBACK, BTRFS_HEADER_FLAG_RELOC, and
> BTRFS_ROOT_FORCE_COW checks before the WRITTEN block since they apply
> regardless of whether the buffer has been written back. This
> consolidates the exclusion logic and simplifies the WRITTEN path to
> only handle log trees and zoned devices. Moving the RELOC checks
> before the smp_mb__before_atomic() barrier is safe because both
> btrfs_root_id() (immutable) and BTRFS_HEADER_FLAG_RELOC (set at COW
> time under tree lock) are stable values not subject to concurrent
> modification; the barrier is only needed for BTRFS_ROOT_FORCE_COW
> which is set concurrently by create_pending_snapshot().
>=20
> Exclude cases where in-place overwrite is not safe:
>   - EXTENT_BUFFER_WRITEBACK: buffer is mid-I/O
>   - Zoned devices: require sequential writes
>   - Log trees: log blocks are immediately referenced by a committed
>     superblock via btrfs_sync_log(), so overwriting could corrupt the
>     committed log
>   - BTRFS_ROOT_FORCE_COW: snapshot in progress
>   - BTRFS_HEADER_FLAG_RELOC: block being relocated
>=20
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: Sun YangKai <sunk67188@gmail.com>

Unfortunately this patch is making btrfs/232 fail.
Bisection lead to this one.

I have hit the following errors during btrfs/232 run with this patch,=20
but not the commit before it:

- Write time tree-checker errors
   From first key mismatch to bad key order.

- Fsck errors
   From missing inode item other problems.
   AKA, on-disk corruption, which is never a good sign.

One thing to note is, that test case itself can lead to a false alerts=20
from DEBUG_WARN() inside btrfs_remove_qgroup(), thus you may need to=20
manually remove that DEBUG_WARN() or check the failure dmesg to be extra=
=20
sure.

Thanks,
Qu

> ---
>   fs/btrfs/ctree.c     | 87 ++++++++++++++++++++++++++++++++++----------
>   fs/btrfs/disk-io.c   |  2 +-
>   fs/btrfs/extent_io.c |  4 --
>   3 files changed, 69 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index 7267b2502665..ea7cfc3a9e89 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -599,29 +599,40 @@ int btrfs_force_cow_block(struct btrfs_trans_handl=
e *trans,
>   	return ret;
>   }
>  =20
> -static inline bool should_cow_block(const struct btrfs_trans_handle *tr=
ans,
> +/*
> + * Check if @buf needs to be COW'd.
> + *
> + * Returns true if COW is required, false if the block can be reused
> + * in place.
> + *
> + * We do not need to COW a block if:
> + * 1) the block was created or changed in this transaction;
> + * 2) the block does not belong to TREE_RELOC tree;
> + * 3) the root is not forced COW.
> + *
> + * Forced COW happens when we create a snapshot during transaction comm=
it:
> + * after copying the src root, we must COW the shared block to ensure
> + * metadata consistency.
> + *
> + * When returning false for a WRITTEN buffer allocated in the current
> + * transaction, re-dirties the buffer for in-place overwrite instead
> + * of requesting a new COW.
> + */
> +static inline bool should_cow_block(struct btrfs_trans_handle *trans,
>   				    const struct btrfs_root *root,
> -				    const struct extent_buffer *buf)
> +				    struct extent_buffer *buf)
>   {
>   	if (btrfs_is_testing(root->fs_info))
>   		return false;
>  =20
> -	/*
> -	 * We do not need to cow a block if
> -	 * 1) this block is not created or changed in this transaction;
> -	 * 2) this block does not belong to TREE_RELOC tree;
> -	 * 3) the root is not forced COW.
> -	 *
> -	 * What is forced COW:
> -	 *    when we create snapshot during committing the transaction,
> -	 *    after we've finished copying src root, we must COW the shared
> -	 *    block to ensure the metadata consistency.
> -	 */
> -
>   	if (btrfs_header_generation(buf) !=3D trans->transid)
>   		return true;
>  =20
> -	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN))
> +	if (test_bit(EXTENT_BUFFER_WRITEBACK, &buf->bflags))
> +		return true;
> +
> +	if (btrfs_root_id(root) !=3D BTRFS_TREE_RELOC_OBJECTID &&
> +	    btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
>   		return true;
>  =20
>   	/* Ensure we can see the FORCE_COW bit. */
> @@ -629,11 +640,49 @@ static inline bool should_cow_block(const struct b=
trfs_trans_handle *trans,
>   	if (test_bit(BTRFS_ROOT_FORCE_COW, &root->state))
>   		return true;
>  =20
> -	if (btrfs_root_id(root) =3D=3D BTRFS_TREE_RELOC_OBJECTID)
> -		return false;
> +	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_WRITTEN)) {
> +		/*
> +		 * The buffer was allocated in this transaction and has been
> +		 * written back to disk (WRITTEN is set). Normally we'd COW
> +		 * it again, but since the committed superblock doesn't
> +		 * reference this buffer (it was allocated in this transaction),
> +		 * we can safely overwrite it in place.
> +		 *
> +		 * We keep BTRFS_HEADER_FLAG_WRITTEN set. The block has been
> +		 * persisted at this bytenr and will be again after the
> +		 * in-place update. This is important so that
> +		 * btrfs_free_tree_block() correctly pins the block if it is
> +		 * freed later (e.g., during tree rebalancing or FORCE_COW).
> +		 *
> +		 * Log trees and zoned devices cannot use this optimization:
> +		 * - Log trees: log blocks are written and immediately
> +		 *   referenced by a committed superblock via
> +		 *   btrfs_sync_log(), bypassing the normal transaction
> +		 *   commit. Overwriting in place could corrupt the
> +		 *   committed log.
> +		 * - Zoned devices: require sequential writes.
> +		 */
> +		if (btrfs_root_id(root) =3D=3D BTRFS_TREE_LOG_OBJECTID ||
> +		    btrfs_is_zoned(root->fs_info))
> +			return true;
>  =20
> -	if (btrfs_header_flag(buf, BTRFS_HEADER_FLAG_RELOC))
> -		return true;
> +		/*
> +		 * Re-register this block's range in the current transaction's
> +		 * dirty_pages so that btrfs_write_and_wait_transaction()
> +		 * writes it. The range was originally registered when the
> +		 * block was allocated. Normally dirty_pages is only cleared
> +		 * at commit time by btrfs_write_and_wait_transaction(), but
> +		 * if qgroups are enabled and snapshots are being created,
> +		 * qgroup_account_snapshot() may have already called
> +		 * btrfs_write_and_wait_transaction() and released the range
> +		 * before the final commit-time call.
> +		 */
> +		btrfs_set_extent_bit(&trans->transaction->dirty_pages,
> +				     buf->start,
> +				     buf->start + buf->len - 1,
> +				     EXTENT_DIRTY, NULL);
> +		btrfs_mark_buffer_dirty(trans, buf);
> +	}
>  =20
>   	return false;
>   }
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 32fffb0557e5..bee8f76fbfea 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -4491,7 +4491,7 @@ void btrfs_mark_buffer_dirty(struct btrfs_trans_ha=
ndle *trans,
>   #endif
>   	/* This is an active transaction (its state < TRANS_STATE_UNBLOCKED).=
 */
>   	ASSERT(trans->transid =3D=3D fs_info->generation);
> -	btrfs_assert_tree_write_locked(buf);
> +	lockdep_assert_held(&buf->lock);
>   	if (unlikely(transid !=3D fs_info->generation)) {
>   		btrfs_abort_transaction(trans, -EUCLEAN);
>   		btrfs_crit(fs_info,
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index dfc17c292217..ff1fc699a6ca 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -3791,10 +3791,6 @@ void set_extent_buffer_dirty(struct extent_buffer=
 *eb)
>   					 eb->len,
>   					 eb->fs_info->dirty_metadata_batch);
>   	}
> -#ifdef CONFIG_BTRFS_DEBUG
> -	for (int i =3D 0; i < num_extent_folios(eb); i++)
> -		ASSERT(folio_test_dirty(eb->folios[i]));
> -#endif
>   }
>  =20
>   void clear_extent_buffer_uptodate(struct extent_buffer *eb)


