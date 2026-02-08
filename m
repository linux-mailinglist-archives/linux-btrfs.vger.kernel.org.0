Return-Path: <linux-btrfs+bounces-21489-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I266FBzViGnnwwQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21489-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:25:32 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7C6109DFB
	for <lists+linux-btrfs@lfdr.de>; Sun, 08 Feb 2026 19:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 134AD3008A65
	for <lists+linux-btrfs@lfdr.de>; Sun,  8 Feb 2026 18:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20AF2F83AE;
	Sun,  8 Feb 2026 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dO6Ad491"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA82D839B
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770575122; cv=none; b=q76Y7XuXlBNiKrfcJ7OeeY431nn+MQQPN+jDUyi3fLAvrDpUgskLGIWrjPfxn2t2Ignxfprfz+C29tuO2viPVXm038x8dD5GdxssDOgle/XFuvOsmqj1fqRZwXU3daf3ffy5VnnKnBfefyJr34Age2bS+KL+zCG3BppyHAoLVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770575122; c=relaxed/simple;
	bh=WMbC7h8S5DhILpgsq7NS1ALdIKeimVQwRo7EUECEaXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRZpE0Dj/DtenHcZXiREUvBNwL50Td2FvwY0B1Y9ms46d98dggqSHsGF1z2yYW0sTUOCZQdxASCZOU1+YS4xhsZvY3cBqlz8diIEewik/mpyX7qKw/SmJ+4M7EfwduCQ/mxpNAd5ursVLUIkBd+N31VONWT4dVPCR7zqvwbSmlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dO6Ad491; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0486C4CEF7
	for <linux-btrfs@vger.kernel.org>; Sun,  8 Feb 2026 18:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770575121;
	bh=WMbC7h8S5DhILpgsq7NS1ALdIKeimVQwRo7EUECEaXo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dO6Ad491R15OiVnlOfP1nNN92N4rwZzkwVV+MxWFvJPOdkfBHymaaMNv4I0A5geGN
	 qRSPIU00S5YJapXtYQh+03Qn95hskmcMcLtoti2BdutzED7wakr4DprJ2Bi9kzoucD
	 3ffFCfWgkYYMluNY7BIqeWOgMP19eD/utQt6jwz7/kCWw1mgsKGg1FK9ci/TPbbJ39
	 V8dQyWttCXt8g7Dsr8HOGONBOdepCqF9qbJ2UMk6q54xYCmxHAZfakzwYKemGZYkol
	 Cq/LL89ozGCxjFx15QhiSnGzZrCRgbwR078iXdlFlV7qBjshFn6hMEG5xtq4SS+7mA
	 qwcq/LxA527Fg==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65941c07e8dso3398814a12.1
        for <linux-btrfs@vger.kernel.org>; Sun, 08 Feb 2026 10:25:21 -0800 (PST)
X-Gm-Message-State: AOJu0YymDKQdcb9PpNsOvapAAcdysDgnPFYAF6txiRTa53WifN1TngAq
	+u1uTn8mxVTPEe3i9BjZYgRda49vjlyf/4Db+O/PtrqaHgC7ihaORKWcztnVMChT6BivrZLbcOy
	ffVzneoyths0Dw8wWjHdnKw1yPgw1898=
X-Received: by 2002:a17:907:940a:b0:b88:448c:be08 with SMTP id
 a640c23a62f3a-b8edf14f46dmr509845466b.5.1770575120256; Sun, 08 Feb 2026
 10:25:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770212626.git.fdmanana@suse.com> <a7a8b95c9c2f5d5c6a481aea277194fa615b8390.1770212626.git.fdmanana@suse.com>
 <20260208155148.3637328-1-clm@meta.com>
In-Reply-To: <20260208155148.3637328-1-clm@meta.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Sun, 8 Feb 2026 18:24:43 +0000
X-Gmail-Original-Message-ID: <CAL3q7H6K0Ve+G16Mk+nFyo_dTF0mMA07PQq63S6y7=tkvsiemw@mail.gmail.com>
X-Gm-Features: AZwV_QjrYNtAI6AjvqDNGCkXGgy5XKsWL65NVgQoX0hP2fO-ir5W56LuO8bk6Ho
Message-ID: <CAL3q7H6K0Ve+G16Mk+nFyo_dTF0mMA07PQq63S6y7=tkvsiemw@mail.gmail.com>
Subject: Re: [PATCH 6/7] btrfs: remove max_mirrors argument from write_all_supers()
To: Chris Mason <clm@meta.com>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21489-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7E7C6109DFB
X-Rspamd-Action: no action

On Sun, Feb 8, 2026 at 3:52=E2=80=AFPM Chris Mason <clm@meta.com> wrote:
>
> fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > There's no need to pass max_mirrors to write_all_supers() since from th=
e
> > given transaction handle we can infer if we are in a transaction commit
> > or fsync context, so we can determine how many mirrors we need to use.
> >
> > So remove the max_mirror argument from write_all_supers() and stop
> > adjusting it in the callees write_dev_supers() and wait_dev_supers(),
> > simplifying them besides the parameter list for write_all_supers().
>
> Hi everyone,
>
> I'm running the btrfs for-next branch, along with the encryption patch se=
t
> through my AI review prompts:
>
> https://github.com/masoncl/review-prompts
>
> I'm working on some btrfs specific instructions, but hopefully these revi=
ews
> are already useful.  I've kept the headers to make it easier to double ch=
eck
> that I'm actually replying to the right email, but please let me know if =
any
> parts of this are incorrect:
>
> commit a30345d606f40c870c69fb77195b3516a6dd6504
> Author: Filipe Manana <fdmanana@suse.com>
>
> btrfs: remove max_mirrors argument from write_all_supers()
>
> This commit removes the max_mirrors parameter from write_all_supers()
> and determines the mirror count from the transaction handle's in_fsync
> flag, claiming this simplifies the code while maintaining correctness.
>
> > diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> > index 19f7927a000d9..cf4ab067be72c 100644
> > --- a/fs/btrfs/disk-io.c
> > +++ b/fs/btrfs/disk-io.c
>
> [ ... ]
>
> > @@ -4018,13 +4011,14 @@ int btrfs_get_num_tolerated_disk_barrier_failur=
es(u64 flags)
> >       return min_tolerated;
> >  }
> >
> > -int write_all_supers(struct btrfs_trans_handle *trans, int max_mirrors=
)
> > +int write_all_supers(struct btrfs_trans_handle *trans)
> >  {
> >       struct btrfs_fs_info *fs_info =3D trans->fs_info;
> >       struct list_head *head;
> >       struct btrfs_device *dev;
> >       struct btrfs_super_block *sb;
> >       struct btrfs_dev_item *dev_item;
> > +     int max_mirrors;
> >       int ret;
> >       int do_barriers;
> >       int max_errors;
> > @@ -4033,13 +4027,13 @@ int write_all_supers(struct btrfs_trans_handle =
*trans, int max_mirrors)
> >
> >       do_barriers =3D !btrfs_test_opt(fs_info, NOBARRIER);
> >
> > -     /*
> > -      * max_mirrors =3D=3D 0 indicates we're from commit_transaction,
> > -      * not from fsync where the tree roots in fs_info have not
> > -      * been consistent on disk.
> > -      */
> > -     if (max_mirrors =3D=3D 0)
> > +     if (trans->in_fsync) {
> > +             max_mirrors =3D 1;
> > +     } else {
> > +             /* We are called from transaction commit. */
> > +             max_mirrors =3D BTRFS_SUPER_MIRROR_MAX;
> >               backup_super_roots(fs_info);
> > +     }
>
> Can this logic handle the case where btrfs_sync_file() falls through to
> btrfs_commit_transaction()? Looking at fs/btrfs/file.c, when a full_sync
> encounters a log sync failure or BTRFS_LOG_FORCE_COMMIT, the code flow is=
:
>
> btrfs_sync_file()
>    trans->in_fsync =3D true;  /* Set at file.c:1728 */
>    ...
>    btrfs_sync_log()  /* May fail or return BTRFS_LOG_FORCE_COMMIT */
>    ...
>    btrfs_commit_transaction(trans)  /* Fallthrough at file.c:1787-1816 */
>       write_all_supers(trans)
>          if (trans->in_fsync)  /* Still true here */
>             max_mirrors =3D 1;  /* But we're in transaction commit */
>
> The OLD code always passed max_mirrors=3D0 from btrfs_commit_transaction(=
)
> (transaction.c:2560), ensuring full superblock redundancy with
> BTRFS_SUPER_MIRROR_MAX=3D3 and calling backup_super_roots() regardless of
> how the transaction commit was triggered.
>
> The NEW code uses trans->in_fsync which remains true during the
> fsync-to-commit fallthrough path. This causes write_all_supers() to set
> max_mirrors=3D1 and skip backup_super_roots(), reducing superblock
> redundancy from 3 copies to 1 and skipping tree root backups during these
> commits.

Oh yes, it won't write the super block to all mirrors if a fsync falls
back to a transaction commit.

This fixup addresses the issue (which I'll fold into for-next):

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index e95c699a0bae..67117e7516bf 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4026,7 +4026,8 @@ int write_all_supers(struct btrfs_trans_handle *trans=
)

        do_barriers =3D !btrfs_test_opt(fs_info, NOBARRIER);

-       if (trans->in_fsync) {
+       if (trans->transaction->state < TRANS_STATE_UNBLOCKED) {
+               /* We are called from fsync. */
                max_mirrors =3D 1;
        } else {
                /* We are called from transaction commit. */


Thanks.

>
> Is the commit message claim that "from the given transaction handle we ca=
n
> infer if we are in a transaction commit or fsync context" accurate for
> this case?
>

