Return-Path: <linux-btrfs+bounces-21779-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJi1F735lmn4swIAu9opvQ
	(envelope-from <linux-btrfs+bounces-21779-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 12:53:33 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B1315E6F1
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 12:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 793E83027950
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Feb 2026 11:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCF2334C05;
	Thu, 19 Feb 2026 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjK2nYZO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C89F23BD06
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771502004; cv=none; b=KjdaWwjcq7UqPiz00CtGVdGnyCr5snGxKfHpkjiKB0HFfrpIB68eAwakF59UwSJnia9PbHLMv/t9BEG4oIlT+tIxYwHTehhHFcvHfVFTt45b/ToCnBjKG7EoAq9p2Pio1q2MG+23nw9EZs1LsOZ5NknplgRR3K8xP0ww3Be3BVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771502004; c=relaxed/simple;
	bh=dUgJq90gWpAVwFAycAPxDApLFqFIeBLeqUq3SOLkjvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RED6VXQBkF9sE9vCIRaADrE1ADEjR/HDAEl9ysAZ0nGTOfiGzHKpSmlBshd0rUGSK9GCY7tGxAoNvRnl6BFxZfxYVzz+pmFF+dqiSMt+dM0JS/843SPGSQbKZxtJiWkr+XDmE8uOU++bPJa+8L+SEgXILfprXULMA+G/9QPfkhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjK2nYZO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2225C4CEF7
	for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 11:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771502003;
	bh=dUgJq90gWpAVwFAycAPxDApLFqFIeBLeqUq3SOLkjvQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=cjK2nYZONeQ4BVnpgCvWdZLFUQMMpBAw6aovp2f5skQ/yCiBLuI5+KjHoaz/0yLUY
	 /H+TsFCN+6o/qpVKzh3jqjfLlvb3gUfAijvhm6spJon3uobnrGsGx/RgQ2S5kga8Nv
	 3SDqSQfJT+efGyS16+PzpLIzvzHkUKHEzdGUb3QfJCancnm5ZqXTrJeiOCZhqAArUg
	 ALO2lPTCcHomW50+PLQQQBkid1MRFj7W3PS64zYjS5z6wT8NCKnbFysfILarUclJf1
	 YglfyzQqKGcoEDWzFK3Xsv7Ninj2lV20VCeTkn2YujIQKxkDEtFcI1i+zzPLPRy881
	 nV8UwAups+YYg==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b8876d1a39bso115092166b.1
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Feb 2026 03:53:23 -0800 (PST)
X-Gm-Message-State: AOJu0YxHZ6RxfOsQV7Oq8kloYAPygHnTuVcki9D10I/N7rBoOpUQloFU
	lZyH9SYrohpgQFxTDetCAJec/d8KzKmB4YSWrCmFqtU5fHpFxI0JK5br4O9WVWa4gk1sUznSY0R
	y/n2IEblLL7HQ68axVOp7YKAK3VYkJXQ=
X-Received: by 2002:a17:907:da17:b0:b8e:7e21:132c with SMTP id
 a640c23a62f3a-b8fc3d36d19mr913732966b.59.1771502002178; Thu, 19 Feb 2026
 03:53:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apsgauiwdj2exslcb7wmy2womtf6suyzfwatnxk75tzseivm4q@e7wktzgzxmsd> <CAL3q7H4ctE3ULy3EqNmKO-dX=WSM0Mn9wvgUvDs5XHqu9EiamQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4ctE3ULy3EqNmKO-dX=WSM0Mn9wvgUvDs5XHqu9EiamQ@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Thu, 19 Feb 2026 11:52:45 +0000
X-Gmail-Original-Message-ID: <CAL3q7H4TbRbvPSgFYTq6KJT2L663PCceyB-yz04cJGNYorgNoQ@mail.gmail.com>
X-Gm-Features: AZwV_QhCaxYDcclxV2C2xgFtubvkIl4vZobg6bVxBmTXGAbCdwis4t5H-d_K0Yg
Message-ID: <CAL3q7H4TbRbvPSgFYTq6KJT2L663PCceyB-yz04cJGNYorgNoQ@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: trace use file_inode(file)->i_sb to calculate fs_info
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21779-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: E2B1315E6F1
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 9:18=E2=80=AFAM Filipe Manana <fdmanana@kernel.org>=
 wrote:
>
> On Thu, Feb 19, 2026 at 1:50=E2=80=AFAM Goldwyn Rodrigues <rgoldwyn@suse.=
de> wrote:
> >
> > If overlay is used on top of btrfs, dentry->d_sb translates to overlay'=
s
> > super block and fsid assignment will lead to a crash.
> >
> > Use file_inode(file)->i_sb to always get btrfs_sb.
> >
> > Changes since v1:
> >   Changed subject to include trace
> >   Use file_inode() to get inode pointer
>
> Information about what changes between patch versions doesn't go into
> the change log, it goes below the line marked as "---", as that's
> irrelevant information to have in git, it's only useful for patch
> reviews.
>
> This subject:
>
> "btrfs: trace use file_inode(file)->i_sb to calculate fs_info"
>
> is also odd, using a C expression, not saying where (which trace
> event) and not saying what problem are we fixing but rather how are we
> fixing the problem.
>
> I suggest something much more clear and concise such as:
>
> "btrfs: fix a crash in the trace event btrfs_sync_file()"
>
> One further comment below.
>
> >
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > Reviewed-by: Boris Burkov <boris@bur.io>
> > ---
> >  include/trace/events/btrfs.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.=
h
> > index 125bdc166bfe..92118df217b4 100644
> > --- a/include/trace/events/btrfs.h
> > +++ b/include/trace/events/btrfs.h
> > @@ -770,9 +770,9 @@ TRACE_EVENT(btrfs_sync_file,
> >
> >         TP_fast_assign(
> >                 const struct dentry *dentry =3D file->f_path.dentry;
>
> Shouldn't we also use file_dentry(file) here?
>
> I think we should, otherwise we get the same bug that was fixed in:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dde17e793b104d690e1d007dfc5cb6b4f649598ca
>
> > -               const struct inode *inode =3D d_inode(dentry);
> > +               const struct inode *inode =3D file_inode(file);
> >
> > -               TP_fast_assign_fsid(btrfs_sb(file->f_path.dentry->d_sb)=
);
> > +               TP_fast_assign_fsid(btrfs_sb(inode->i_sb));
> >                 __entry->ino            =3D btrfs_ino(BTRFS_I(inode));
> >                 __entry->parent         =3D btrfs_ino(BTRFS_I(d_inode(d=
entry->d_parent)));
>
> And here, why didn't you replace d_inode() with file_inode() like above?

Actually I meant using dget_parent(dentry) to get the parent here, so
it should be:

btrfs_ino(BTRFS_I(d_inode(dget_parent(dentry)))

After the following replacement at the top as mentioned before:

const struct dentry *dentry =3D file->f_path.dentry;

with

const struct dentry *dentry =3D file_dentry(file);



>
> Thanks.
>
> >                 __entry->datasync       =3D datasync;
> > --
> > 2.53.0
> >
> >
> > --
> > Goldwyn
> >

