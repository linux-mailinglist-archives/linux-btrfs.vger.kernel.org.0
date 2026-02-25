Return-Path: <linux-btrfs+bounces-21922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F8oAEn6nmm+YAQAu9opvQ
	(envelope-from <linux-btrfs+bounces-21922-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 14:34:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 525061981FD
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 14:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2B693137795
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Feb 2026 13:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19753AE6E1;
	Wed, 25 Feb 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JsxVVq3g";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AQ/UX3pq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PaUIfwpX";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+HYvPD0L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89EA3B961F
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Feb 2026 13:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026286; cv=none; b=MmMHKxJUvLHmXRRAEe2Hn6PJ+5MecdbNVUtLOty6YTfn1OIPjt97srIF3GxMocKGoCN14SFBTfVwkiPFmc12XRYX0MVUc9gf4unoUQy0Czpxhc+Is7B6HTNI33kEx7U/Byft/BQjVY1EN75ljs1cPMxIvdjVyD1mLzwn69b0HsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026286; c=relaxed/simple;
	bh=rqJuVcdWAWq8Wjv6QjqFJwBjNgSHL792mU9UPaQij/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdoxFQGio44RNPXgR8towRbhpVIyIeeNZ88Q1RzGmyoF/xPLH0r/bhhuO6WaBdwe7+wXk6oj8f63vazb3DZ0K5mxb7m++8AtuIy65wTNDau9YpLo1eIQVPSznXyo0fa6/e7KHUKOsOTuRbRBvw67kJ6F4qcvtjJQ7PkV6cgOqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JsxVVq3g; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AQ/UX3pq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PaUIfwpX; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+HYvPD0L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E69B65C5C1;
	Wed, 25 Feb 2026 13:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772026283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn43QckhcZlwgxT+leFcbNBxL4cW/cLNXFJsfzwP3RU=;
	b=JsxVVq3g3Gy7XDo3D4y5TQ0ZQm/2Db2xco+PKPBiOxfUK9I0XXQ0icnMudY8nYyQNz/Dg4
	uuyK09Wd3/wN4y7HaJ52N8N4n8r/nyq5XGrlEC6eRHW1R9aphxbcKDDq262/2ZmjBq3zAg
	fKVbLjG+rA/9oxzWFMIHXv7pIlyBBUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772026283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn43QckhcZlwgxT+leFcbNBxL4cW/cLNXFJsfzwP3RU=;
	b=AQ/UX3pqeinN6EVmtuoDxQb3qfb1QJqkK4BwxQhKpyaakHirYd9RdDTQ8+oJhe4A4RHjrK
	cRitLRCkpYII6ICA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772026282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn43QckhcZlwgxT+leFcbNBxL4cW/cLNXFJsfzwP3RU=;
	b=PaUIfwpXgtztCLfrf/zns2XEwKqzI0puOC5Rc7LJP6/ltEeGEqFTqwTEqh7z5Ifviz1q8R
	tQaeRsaryKiKxk5w+HbRPI/BmDz2sDWIJe2wxLWauIKnjhzkHEJ7oxXnNNzQxb5CeIF5mm
	UmJs+3uFIfGd5PKbI5VtpClpT242QOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772026282;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cn43QckhcZlwgxT+leFcbNBxL4cW/cLNXFJsfzwP3RU=;
	b=+HYvPD0LC5vaDhYUIqBLYCS/5cCxuOXfjmX/BrQS8ScAq3vyLyhQL9kx088pfBRC+iW9Ef
	cSdudZTlTvSJ7NDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A18B13EA65;
	Wed, 25 Feb 2026 13:31:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lCw5Iar5nmliHAAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Wed, 25 Feb 2026 13:31:22 +0000
Date: Wed, 25 Feb 2026 08:31:17 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: Filipe Manana <fdmanana@kernel.org>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: trace use file_inode(file)->i_sb to calculate
 fs_info
Message-ID: <pfkdps2txsxkpjvbouoor3ytpxvcvn4emxoahqiadeah6qir37@5hcjqnvaji2c>
References: <apsgauiwdj2exslcb7wmy2womtf6suyzfwatnxk75tzseivm4q@e7wktzgzxmsd>
 <CAL3q7H4ctE3ULy3EqNmKO-dX=WSM0Mn9wvgUvDs5XHqu9EiamQ@mail.gmail.com>
 <CAL3q7H4TbRbvPSgFYTq6KJT2L663PCceyB-yz04cJGNYorgNoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H4TbRbvPSgFYTq6KJT2L663PCceyB-yz04cJGNYorgNoQ@mail.gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21922-lists,linux-btrfs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rgoldwyn@suse.de,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,suse.de:email,suse.de:dkim]
X-Rspamd-Queue-Id: 525061981FD
X-Rspamd-Action: no action

On 11:52 19/02, Filipe Manana wrote:
> On Thu, Feb 19, 2026 at 9:18 AM Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Thu, Feb 19, 2026 at 1:50 AM Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> > >
> > > If overlay is used on top of btrfs, dentry->d_sb translates to overlay's
> > > super block and fsid assignment will lead to a crash.
> > >
> > > Use file_inode(file)->i_sb to always get btrfs_sb.
> > >
> > > Changes since v1:
> > >   Changed subject to include trace
> > >   Use file_inode() to get inode pointer
> >
> > Information about what changes between patch versions doesn't go into
> > the change log, it goes below the line marked as "---", as that's
> > irrelevant information to have in git, it's only useful for patch
> > reviews.
> >
> > This subject:
> >
> > "btrfs: trace use file_inode(file)->i_sb to calculate fs_info"
> >
> > is also odd, using a C expression, not saying where (which trace
> > event) and not saying what problem are we fixing but rather how are we
> > fixing the problem.
> >
> > I suggest something much more clear and concise such as:
> >
> > "btrfs: fix a crash in the trace event btrfs_sync_file()"
> >

Understood.

> > One further comment below.

Response inline..

> >
> > >
> > > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > > Reviewed-by: Qu Wenruo <wqu@suse.com>
> > > Reviewed-by: Boris Burkov <boris@bur.io>
> > > ---
> > >  include/trace/events/btrfs.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
> > > index 125bdc166bfe..92118df217b4 100644
> > > --- a/include/trace/events/btrfs.h
> > > +++ b/include/trace/events/btrfs.h
> > > @@ -770,9 +770,9 @@ TRACE_EVENT(btrfs_sync_file,
> > >
> > >         TP_fast_assign(
> > >                 const struct dentry *dentry = file->f_path.dentry;
> >
> > Shouldn't we also use file_dentry(file) here?
> >
> > I think we should, otherwise we get the same bug that was fixed in:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=de17e793b104d690e1d007dfc5cb6b4f649598ca
> >

No. file_dentry() is obsolete now. Check the function implementation and
the comment before it.

> > > -               const struct inode *inode = d_inode(dentry);
> > > +               const struct inode *inode = file_inode(file);
> > >
> > > -               TP_fast_assign_fsid(btrfs_sb(file->f_path.dentry->d_sb));
> > > +               TP_fast_assign_fsid(btrfs_sb(inode->i_sb));
> > >                 __entry->ino            = btrfs_ino(BTRFS_I(inode));
> > >                 __entry->parent         = btrfs_ino(BTRFS_I(d_inode(dentry->d_parent)));
> >
> > And here, why didn't you replace d_inode() with file_inode() like above?
> 
> Actually I meant using dget_parent(dentry) to get the parent here, so
> it should be:
> 
> btrfs_ino(BTRFS_I(d_inode(dget_parent(dentry)))
> 
> After the following replacement at the top as mentioned before:
> 
> const struct dentry *dentry = file->f_path.dentry;
> 
> with
> 
> const struct dentry *dentry = file_dentry(file);

.. this would need to be followed with a dput().

This is quite a lot of computation for a ftrace function. Since we are
just printing the inode number of the parent, can we just assign
inode->i_ino as opposed to btrfs_ino()? I understand it would show the
overlayfs inode number as opposed to the BTRFS one, and may not be the
same, but isn't that you would look for when you are debugging?

-- 
Goldwyn

