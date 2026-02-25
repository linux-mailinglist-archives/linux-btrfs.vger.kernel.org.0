Return-Path: <linux-btrfs+bounces-21923-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MjjN1/9nmlAYgQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21923-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 14:47:11 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDE2198575
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 14:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B34C83026B5A
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 13:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC753D1CAD;
	Wed, 25 Feb 2026 13:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iulo+9Bw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8DE3AE6F2
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772027220; cv=none; b=UXFBBVdy3altQBEjUfo6qN/hYGAnjqeRdsh5KoS8IShYbfNSRZ0EpRuTOpLs15BX6nUccnfwIPczhKYMG6kzG0WUxAztKzdrUREZxhcrL+UMRw4giwIhCbLMeQSWUhQx45DOp12KXxAP1FbLfYlaG4xrFdw1rCFs4F3ySEhZzCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772027220; c=relaxed/simple;
	bh=gGePHXujOUgLoMcrkAYzYT+VgHd7v79RM/IRM7Q/T2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BlMOLfKdntjbHpy1YNdcTbLBRdQ1aj/8UPE6CKj7kwcroWBLiZjyKP1zKOAXShWCIzIQTCgMZISlFpn+XvlEoNAIeNLWjeZ0I/Bj2dGKnd0ZpOHE1uEAvgHrLsYu7f3au3TqBS/OPLDtFtgsHNsUfte1lSDwTGLm/928kqiTPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iulo+9Bw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F753C19421
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 13:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772027219;
	bh=gGePHXujOUgLoMcrkAYzYT+VgHd7v79RM/IRM7Q/T2g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Iulo+9BwrMcM3/vfW+bAVR/K28/Hu9uN1S9Ym6IP7D/J7yIERK6vZQwBxXPSaI9vq
	 hNTiaexxASSQXPiYV9e1/5DB3o4WxP6FS+OPQqx7C8uAYyb22z8utHHF13wRVEF7EM
	 VLtMvR5o7iL42FVIqJfCFfD60x+SAT5GPpksHLqf3whvYm0WlVuVrLGTulc9JbHxnT
	 S8JpdOm7KXAHGlAZhxKr8cuXEjdXa9I6ipQjxJnNO3CX/6T1+ZN9na7OEOVxyqHMIM
	 bwCucq4XT47SbfPLmRPehEl4AiQ8UO+gzkm0uu1fc6j5E2JG5hqWMYhyHKmLsZlsf3
	 M3kg9sqKv0HPA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b885e8c6727so169873566b.1
        for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 05:46:59 -0800 (PST)
X-Gm-Message-State: AOJu0YwiByTAFhaFdndfuXceZotMtNoIPNJGExWJO0r1aum9G0kAeKBn
	/AraNdzdyoDzkz3Wv0dGUec4Czwja1gKO5yikE+Z7e09eKfCEWhqEcFn1sA+smEfNkNeXBLeyI9
	6s9bN1dcuar0Ta9S/W0vUwKDhkrQOZ5Q=
X-Received: by 2002:a17:906:794a:b0:b8f:d2a0:c2a1 with SMTP id
 a640c23a62f3a-b933cb5a3cfmr270213466b.5.1772027217906; Wed, 25 Feb 2026
 05:46:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <apsgauiwdj2exslcb7wmy2womtf6suyzfwatnxk75tzseivm4q@e7wktzgzxmsd>
 <CAL3q7H4ctE3ULy3EqNmKO-dX=WSM0Mn9wvgUvDs5XHqu9EiamQ@mail.gmail.com>
 <CAL3q7H4TbRbvPSgFYTq6KJT2L663PCceyB-yz04cJGNYorgNoQ@mail.gmail.com> <pfkdps2txsxkpjvbouoor3ytpxvcvn4emxoahqiadeah6qir37@5hcjqnvaji2c>
In-Reply-To: <pfkdps2txsxkpjvbouoor3ytpxvcvn4emxoahqiadeah6qir37@5hcjqnvaji2c>
From: Filipe Manana <fdmanana@kernel.org>
Date: Wed, 25 Feb 2026 13:46:19 +0000
X-Gmail-Original-Message-ID: <CAL3q7H7Bvew2BeAa+F8xonLHqchQWqg46Xw2RZLHE2LX70enzg@mail.gmail.com>
X-Gm-Features: AaiRm51MkFn-bCjdlltLxs8sEP9nZiqa0NOLobDEmdiiOQVyhTMHsVJHxbBti54
Message-ID: <CAL3q7H7Bvew2BeAa+F8xonLHqchQWqg46Xw2RZLHE2LX70enzg@mail.gmail.com>
Subject: Re: [PATCH v2] btrfs: trace use file_inode(file)->i_sb to calculate fs_info
To: Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc: linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21923-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fdmanana@kernel.org,linux-btrfs@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-btrfs];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.de:email,mail.gmail.com:mid,bur.io:email]
X-Rspamd-Queue-Id: 8BDE2198575
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 1:31=E2=80=AFPM Goldwyn Rodrigues <rgoldwyn@suse.de=
> wrote:
>
> On 11:52 19/02, Filipe Manana wrote:
> > On Thu, Feb 19, 2026 at 9:18=E2=80=AFAM Filipe Manana <fdmanana@kernel.=
org> wrote:
> > >
> > > On Thu, Feb 19, 2026 at 1:50=E2=80=AFAM Goldwyn Rodrigues <rgoldwyn@s=
use.de> wrote:
> > > >
> > > > If overlay is used on top of btrfs, dentry->d_sb translates to over=
lay's
> > > > super block and fsid assignment will lead to a crash.
> > > >
> > > > Use file_inode(file)->i_sb to always get btrfs_sb.
> > > >
> > > > Changes since v1:
> > > >   Changed subject to include trace
> > > >   Use file_inode() to get inode pointer
> > >
> > > Information about what changes between patch versions doesn't go into
> > > the change log, it goes below the line marked as "---", as that's
> > > irrelevant information to have in git, it's only useful for patch
> > > reviews.
> > >
> > > This subject:
> > >
> > > "btrfs: trace use file_inode(file)->i_sb to calculate fs_info"
> > >
> > > is also odd, using a C expression, not saying where (which trace
> > > event) and not saying what problem are we fixing but rather how are w=
e
> > > fixing the problem.
> > >
> > > I suggest something much more clear and concise such as:
> > >
> > > "btrfs: fix a crash in the trace event btrfs_sync_file()"
> > >
>
> Understood.
>
> > > One further comment below.
>
> Response inline..
>
> > >
> > > >
> > > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > > > Reviewed-by: Boris Burkov <boris@bur.io>
> > > > ---
> > > >  include/trace/events/btrfs.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/include/trace/events/btrfs.h b/include/trace/events/bt=
rfs.h
> > > > index 125bdc166bfe..92118df217b4 100644
> > > > --- a/include/trace/events/btrfs.h
> > > > +++ b/include/trace/events/btrfs.h
> > > > @@ -770,9 +770,9 @@ TRACE_EVENT(btrfs_sync_file,
> > > >
> > > >         TP_fast_assign(
> > > >                 const struct dentry *dentry =3D file->f_path.dentry=
;
> > >
> > > Shouldn't we also use file_dentry(file) here?
> > >
> > > I think we should, otherwise we get the same bug that was fixed in:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3Dde17e793b104d690e1d007dfc5cb6b4f649598ca
> > >
>
> No. file_dentry() is obsolete now. Check the function implementation and
> the comment before it.
>
> > > > -               const struct inode *inode =3D d_inode(dentry);
> > > > +               const struct inode *inode =3D file_inode(file);
> > > >
> > > > -               TP_fast_assign_fsid(btrfs_sb(file->f_path.dentry->d=
_sb));
> > > > +               TP_fast_assign_fsid(btrfs_sb(inode->i_sb));
> > > >                 __entry->ino            =3D btrfs_ino(BTRFS_I(inode=
));
> > > >                 __entry->parent         =3D btrfs_ino(BTRFS_I(d_ino=
de(dentry->d_parent)));
> > >
> > > And here, why didn't you replace d_inode() with file_inode() like abo=
ve?
> >
> > Actually I meant using dget_parent(dentry) to get the parent here, so
> > it should be:
> >
> > btrfs_ino(BTRFS_I(d_inode(dget_parent(dentry)))
> >
> > After the following replacement at the top as mentioned before:
> >
> > const struct dentry *dentry =3D file->f_path.dentry;
> >
> > with
> >
> > const struct dentry *dentry =3D file_dentry(file);
>
> .. this would need to be followed with a dput().
>
> This is quite a lot of computation for a ftrace function. Since we are
> just printing the inode number of the parent, can we just assign
> inode->i_ino as opposed to btrfs_ino()? I understand it would show the
> overlayfs inode number as opposed to the BTRFS one, and may not be the
> same, but isn't that you would look for when you are debugging?

When I look at the trace, I only care about the btrfs inode number,
that's what helps me debug btrfs issues - the overlayfs inode number
is useless for what I need.


>
> --
> Goldwyn

