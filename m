Return-Path: <linux-btrfs+bounces-22011-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AvqOrtooGm+jQQAu9opvQ
	(envelope-from <linux-btrfs+bounces-22011-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:37:31 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 583951A8D61
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 16:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 069E7345FB70
	for <lists+linux-btrfs@lfdr.de>; Thu, 26 Feb 2026 15:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCDD399032;
	Thu, 26 Feb 2026 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKWz7tE1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAA21B424F
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772119448; cv=none; b=rfgIUJmzQ1jBUFx+swpBnv1pEdieDPhm8w0woQjZNyufqOr7pgzBWZEDDkdkYKlmO6ldpgLs/ns17nfBkmya1ZpxMmOrP6zUZ6dyK1V8fBveBejeNgD/WGUM+8yxJw9VR2hGFFvo1H8OV0e+c1qUaSfZFW9AsXzymC8q3r1GIog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772119448; c=relaxed/simple;
	bh=yXgtme9Bkpt//mImZ/k5pXIQeb0TjhOk+Aow2qQg4RY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sMPyFuB20WpfQw5dnUl+VlZtWnqADdcL0fGwoUXAMj+Uqolywr2KvYzEVg1M5a92fjp8+IUO4X2wxHm5VJoUaGuDO5wjt6QmAbvkgBpkCef96jUyn4D4OogCtojnADM8Sbpu23O0qVY1leBb5ZoAEkGP4YHI5VNn7emDnCATV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKWz7tE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED86EC116C6
	for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 15:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772119448;
	bh=yXgtme9Bkpt//mImZ/k5pXIQeb0TjhOk+Aow2qQg4RY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DKWz7tE1oS8Vv6TjxM1gsJ+NNS+kzTRutkMoUBOfuxkpqXPwa+qmjDhtfwhBW0o0E
	 +2qAIGC9mFhj3Wh4m+JV4CMPEIZNsw8uKkMuXdPqqLyj6QB/OPYx3B4BXRl4yMg+xi
	 9ZuDZCfTWpkHS7x5q6WVVDSdEN0KPhAml6Vep/9XsU7IPorCPQTwNkM9n4IWhYez/A
	 2KvKwiIB0iFfbYp74TV3Y0THpTHlMZx7pWT00MGnsMzmPP2Zp4ZZCX1gqp00T7KRbY
	 tLxmJsjiSFZl3MQ47z5gT7RlWzNVBp2QRR2W0NCaGEFKdcZgKdgOuTr9f52h4if0A3
	 059VAvgBPiSqg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b936331787bso89556066b.3
        for <linux-btrfs@vger.kernel.org>; Thu, 26 Feb 2026 07:24:07 -0800 (PST)
X-Gm-Message-State: AOJu0YyRfjVPN1c1tKXIg3IA2quTVr9DNi7iDA4/UKJhTAMT7v+VznGZ
	NysUFmk0MX/STrMsF3eLIA9MLCH2sZStVcRxJBi4ByYi1diFjgE5hxdSY28/hlwWVNWlU58RiVA
	/OYaxFwiX4YFs7F9FYyhq1qwsI/pcA1o=
X-Received: by 2002:a17:906:f590:b0:b8e:a179:aa59 with SMTP id
 a640c23a62f3a-b9081c15939mr1496469866b.56.1772119446350; Thu, 26 Feb 2026
 07:24:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1772097864.git.loemra.dev@gmail.com> <9e49ee6ee946e6cabb6b691693a955dbd201055c.1772097864.git.loemra.dev@gmail.com>
In-Reply-To: <9e49ee6ee946e6cabb6b691693a955dbd201055c.1772097864.git.loemra.dev@gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 26 Feb 2026 15:23:29 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6ggs37j889cyOpczo-5-DKQUTaa6QLVuM9uq5O08HK6Q@mail.gmail.com>
X-Gm-Features: AaiRm51AeUmvt8-yHC2V5YkqfBNUEt1InZHPnmVIcYbDX5QRSW4W626yHft4338
Message-ID: <CAL3q7H6ggs37j889cyOpczo-5-DKQUTaa6QLVuM9uq5O08HK6Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] btrfs: inhibit extent buffer writeback to prevent
 COW amplification
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22011-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 583951A8D61
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 9:58=E2=80=AFAM Leo Martins <loemra.dev@gmail.com> =
wrote:
>
> Inhibit writeback on COW'd extent buffers for the lifetime of the
> transaction handle, preventing background writeback from setting
> BTRFS_HEADER_FLAG_WRITTEN and causing unnecessary re-COW.
>
> COW amplification occurs when background writeback flushes an extent
> buffer that a transaction handle is still actively modifying. When
> lock_extent_buffer_for_io() transitions a buffer from dirty to
> writeback, it sets BTRFS_HEADER_FLAG_WRITTEN, marking the block as
> having been persisted to disk at its current bytenr. Once WRITTEN is
> set, should_cow_block() must either COW the block again or overwrite
> it in place, both of which are unnecessary overhead when the buffer
> is still being modified by the same handle that allocated it. By
> inhibiting background writeback on actively-used buffers, WRITTEN is
> never set while a transaction handle holds a reference to the buffer,
> avoiding this overhead entirely.
>
> Add an atomic_t writeback_inhibitors counter to struct extent_buffer,
> which fits in an existing 6-byte hole without increasing struct size.
> When a buffer is COW'd in btrfs_force_cow_block(), call
> btrfs_inhibit_eb_writeback() to store the eb in the transaction
> handle's writeback_inhibited_ebs xarray (keyed by eb->start), take a
> reference, and increment writeback_inhibitors. The function handles
> dedup (same eb inhibited twice by the same handle) and replacement
> (different eb at the same logical address). Allocation failure is
> graceful: the buffer simply falls back to the pre-existing behavior
> where it may be written back and re-COW'd.
>
> Also inhibit writeback in should_cow_block() when COW is skipped,
> so that every transaction handle that reuses an already-COW'd buffer
> also inhibits its writeback. Without this, if handle A COWs a block
> and inhibits it, and handle B later reuses the same block without
> inhibiting, handle A's uninhibit on end_transaction leaves the buffer
> unprotected while handle B is still using it. This ensures all handles
> that access a COW'd buffer contribute to the inhibitor count, and the
> buffer remains protected until the last handle releases it.
>
> In lock_extent_buffer_for_io(), when writeback_inhibitors is non-zero
> and the writeback mode is WB_SYNC_NONE, skip the buffer. WB_SYNC_NONE
> is used by the VM flusher threads for background and periodic
> writeback, which are the only paths that cause COW amplification by
> opportunistically writing out dirty extent buffers mid-transaction.
> Skipping these is safe because the buffers remain dirty in the page
> cache and will be written out at transaction commit time.
>
> WB_SYNC_ALL must always proceed regardless of writeback_inhibitors.
> This is required for correctness in the fsync path: btrfs_sync_log()
> writes log tree blocks via filemap_fdatawrite_range() (WB_SYNC_ALL)
> while the transaction handle that inhibited those same blocks is still
> active. Without the WB_SYNC_ALL bypass, those inhibited log tree
> blocks would be silently skipped, resulting in an incomplete log on
> disk and corruption on replay. btrfs_write_and_wait_transaction()
> also uses WB_SYNC_ALL via filemap_fdatawrite_range(); for that path,
> inhibitors are already cleared beforehand, but the bypass ensures
> correctness regardless.
>
> Uninhibit in __btrfs_end_transaction() before atomic_dec(num_writers)
> to prevent a race where the committer proceeds while buffers are still
> inhibited. Also uninhibit in btrfs_commit_transaction() before writing
> and in cleanup_transaction() for the error path.
>
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>
> ---
>  fs/btrfs/ctree.c       |  9 ++++++
>  fs/btrfs/extent_io.c   | 63 +++++++++++++++++++++++++++++++++++++++++-
>  fs/btrfs/extent_io.h   |  6 ++++
>  fs/btrfs/transaction.c | 19 +++++++++++++
>  fs/btrfs/transaction.h |  3 ++
>  5 files changed, 99 insertions(+), 1 deletion(-)
>
> diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> index ea7cfc3a9e89..46a715c95bc8 100644
> --- a/fs/btrfs/ctree.c
> +++ b/fs/btrfs/ctree.c
> @@ -21,6 +21,7 @@
>  #include "fs.h"
>  #include "accessors.h"
>  #include "extent-tree.h"
> +#include "extent_io.h"
>  #include "relocation.h"
>  #include "file-item.h"
>
> @@ -590,6 +591,10 @@ int btrfs_force_cow_block(struct btrfs_trans_handle =
*trans,
>                 btrfs_tree_unlock(buf);
>         free_extent_buffer_stale(buf);
>         btrfs_mark_buffer_dirty(trans, cow);
> +
> +       /* Inhibit writeback on the COW'd buffer for this transaction han=
dle. */
> +       btrfs_inhibit_eb_writeback(trans, cow);

Btw, that comment is redundant. It's clear what we are doing, since
the function's name is clear about what it does and the eb is named
"cow".
Usually we add comments for things that are not obvious.

> +
>         *cow_ret =3D cow;
>         return 0;
>
> @@ -617,6 +622,9 @@ int btrfs_force_cow_block(struct btrfs_trans_handle *=
trans,
>   * When returning false for a WRITTEN buffer allocated in the current
>   * transaction, re-dirties the buffer for in-place overwrite instead
>   * of requesting a new COW.
> + *
> + * When returning false, inhibits background writeback on the buffer
> + * for the lifetime of the transaction handle.
>   */
>  static inline bool should_cow_block(struct btrfs_trans_handle *trans,
>                                     const struct btrfs_root *root,
> @@ -684,6 +692,7 @@ static inline bool should_cow_block(struct btrfs_tran=
s_handle *trans,
>                 btrfs_mark_buffer_dirty(trans, buf);
>         }
>
> +       btrfs_inhibit_eb_writeback(trans, buf);
>         return false;
>  }
>
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index ff1fc699a6ca..e04e42a81978 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -1940,7 +1940,9 @@ static noinline_for_stack bool lock_extent_buffer_f=
or_io(struct extent_buffer *e
>          * of time.
>          */
>         spin_lock(&eb->refs_lock);
> -       if (test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
> +       if ((wbc->sync_mode =3D=3D WB_SYNC_ALL ||
> +            atomic_read(&eb->writeback_inhibitors) =3D=3D 0) &&
> +           test_and_clear_bit(EXTENT_BUFFER_DIRTY, &eb->bflags)) {
>                 XA_STATE(xas, &fs_info->buffer_tree, eb->start >> fs_info=
->nodesize_bits);
>                 unsigned long flags;
>
> @@ -2999,6 +3001,64 @@ static inline void btrfs_release_extent_buffer(str=
uct extent_buffer *eb)
>         kmem_cache_free(extent_buffer_cache, eb);
>  }
>
> +/*
> + * btrfs_inhibit_eb_writeback - Inhibit writeback on buffer during trans=
action.
> + * @trans: transaction handle that will own the inhibitor
> + * @eb: extent buffer to inhibit writeback on
> + *
> + * Attempts to track this extent buffer in the transaction's inhibited s=
et.
> + * If memory allocation fails, the buffer is simply not tracked. It may
> + * be written back and need re-COW, which is the original behavior.
> + * This is acceptable since inhibiting writeback is an optimization.
> + */
> +void btrfs_inhibit_eb_writeback(struct btrfs_trans_handle *trans,
> +                               struct extent_buffer *eb)
> +{
> +       unsigned long index =3D eb->start >> trans->fs_info->nodesize_bit=
s;
> +       void *old;
> +
> +       /* Check if already inhibited by this handle. */
> +       old =3D xa_load(&trans->writeback_inhibited_ebs, index);
> +       if (old =3D=3D eb)
> +               return;
> +
> +       /* Take reference for the xarray entry. */
> +       refcount_inc(&eb->refs);
> +
> +       old =3D xa_store(&trans->writeback_inhibited_ebs, index, eb, GFP_=
NOFS);
> +       if (xa_is_err(old)) {
> +               /* Allocation failed, just skip inhibiting this buffer. *=
/
> +               free_extent_buffer(eb);
> +               return;
> +       }
> +
> +       /* Handle replacement of different eb at same index. */
> +       if (old && old !=3D eb) {
> +               struct extent_buffer *old_eb =3D old;
> +
> +               atomic_dec(&old_eb->writeback_inhibitors);
> +               free_extent_buffer(old_eb);
> +       }
> +
> +       atomic_inc(&eb->writeback_inhibitors);

Btw, at the top of this function we should assert the eb is locked.

Otherwise,

Reviewed-by: Filipe Manana <fdmanana@suse.com>

Thanks.

> +}
> +
> +/*
> + * btrfs_uninhibit_all_eb_writeback - Uninhibit writeback on all buffers=
.
> + * @trans: transaction handle to clean up
> + */
> +void btrfs_uninhibit_all_eb_writeback(struct btrfs_trans_handle *trans)
> +{
> +       struct extent_buffer *eb;
> +       unsigned long index;
> +
> +       xa_for_each(&trans->writeback_inhibited_ebs, index, eb) {
> +               atomic_dec(&eb->writeback_inhibitors);
> +               free_extent_buffer(eb);
> +       }
> +       xa_destroy(&trans->writeback_inhibited_ebs);
> +}
> +
>  static struct extent_buffer *__alloc_extent_buffer(struct btrfs_fs_info =
*fs_info,
>                                                    u64 start)
>  {
> @@ -3009,6 +3069,7 @@ static struct extent_buffer *__alloc_extent_buffer(=
struct btrfs_fs_info *fs_info
>         eb->len =3D fs_info->nodesize;
>         eb->fs_info =3D fs_info;
>         init_rwsem(&eb->lock);
> +       atomic_set(&eb->writeback_inhibitors, 0);
>
>         btrfs_leak_debug_add_eb(eb);
>
> diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
> index 73571d5d3d5a..fb68fbd4866c 100644
> --- a/fs/btrfs/extent_io.h
> +++ b/fs/btrfs/extent_io.h
> @@ -102,6 +102,8 @@ struct extent_buffer {
>         /* >=3D 0 if eb belongs to a log tree, -1 otherwise */
>         s8 log_index;
>         u8 folio_shift;
> +       /* Inhibits WB_SYNC_NONE writeback when > 0. */
> +       atomic_t writeback_inhibitors;
>         struct rcu_head rcu_head;
>
>         struct rw_semaphore lock;
> @@ -381,4 +383,8 @@ void btrfs_extent_buffer_leak_debug_check(struct btrf=
s_fs_info *fs_info);
>  #define btrfs_extent_buffer_leak_debug_check(fs_info)  do {} while (0)
>  #endif
>
> +void btrfs_inhibit_eb_writeback(struct btrfs_trans_handle *trans,
> +                              struct extent_buffer *eb);
> +void btrfs_uninhibit_all_eb_writeback(struct btrfs_trans_handle *trans);
> +
>  #endif
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index f4cc9e1a1b93..a9a22629b49d 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -15,6 +15,7 @@
>  #include "misc.h"
>  #include "ctree.h"
>  #include "disk-io.h"
> +#include "extent_io.h"
>  #include "transaction.h"
>  #include "locking.h"
>  #include "tree-log.h"
> @@ -688,6 +689,8 @@ start_transaction(struct btrfs_root *root, unsigned i=
nt num_items,
>                 goto alloc_fail;
>         }
>
> +       xa_init(&h->writeback_inhibited_ebs);
> +
>         /*
>          * If we are JOIN_NOLOCK we're already committing a transaction a=
nd
>          * waiting on this guy, so we don't need to do the sb_start_intwr=
ite
> @@ -1083,6 +1086,13 @@ static int __btrfs_end_transaction(struct btrfs_tr=
ans_handle *trans,
>         if (trans->type & __TRANS_FREEZABLE)
>                 sb_end_intwrite(info->sb);
>
> +       /*
> +        * Uninhibit extent buffer writeback before decrementing num_writ=
ers,
> +        * since the decrement wakes the committing thread which needs al=
l
> +        * buffers uninhibited to write them to disk.
> +        */
> +       btrfs_uninhibit_all_eb_writeback(trans);
> +
>         WARN_ON(cur_trans !=3D info->running_transaction);
>         WARN_ON(atomic_read(&cur_trans->num_writers) < 1);
>         atomic_dec(&cur_trans->num_writers);
> @@ -2110,6 +2120,7 @@ static void cleanup_transaction(struct btrfs_trans_=
handle *trans, int err)
>         if (!test_bit(BTRFS_FS_RELOC_RUNNING, &fs_info->flags))
>                 btrfs_scrub_cancel(fs_info);
>
> +       btrfs_uninhibit_all_eb_writeback(trans);
>         kmem_cache_free(btrfs_trans_handle_cachep, trans);
>  }
>
> @@ -2556,6 +2567,14 @@ int btrfs_commit_transaction(struct btrfs_trans_ha=
ndle *trans)
>             fs_info->cleaner_kthread)
>                 wake_up_process(fs_info->cleaner_kthread);
>
> +       /*
> +        * Uninhibit writeback on all extent buffers inhibited during thi=
s
> +        * transaction before writing them to disk. Inhibiting prevented
> +        * writeback while the transaction was building, but now we need
> +        * them written.
> +        */
> +       btrfs_uninhibit_all_eb_writeback(trans);
> +
>         ret =3D btrfs_write_and_wait_transaction(trans);
>         if (unlikely(ret)) {
>                 btrfs_err(fs_info, "error while writing out transaction: =
%d", ret);
> diff --git a/fs/btrfs/transaction.h b/fs/btrfs/transaction.h
> index 18ef069197e5..7d70fe486758 100644
> --- a/fs/btrfs/transaction.h
> +++ b/fs/btrfs/transaction.h
> @@ -12,6 +12,7 @@
>  #include <linux/time64.h>
>  #include <linux/mutex.h>
>  #include <linux/wait.h>
> +#include <linux/xarray.h>
>  #include "btrfs_inode.h"
>  #include "delayed-ref.h"
>
> @@ -162,6 +163,8 @@ struct btrfs_trans_handle {
>         struct btrfs_fs_info *fs_info;
>         struct list_head new_bgs;
>         struct btrfs_block_rsv delayed_rsv;
> +       /* Extent buffers with writeback inhibited by this handle. */
> +       struct xarray writeback_inhibited_ebs;
>  };
>
>  /*
> --
> 2.47.3
>
>

