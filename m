Return-Path: <linux-btrfs+bounces-5850-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6129910F60
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 19:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DF8D1F229F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Jun 2024 17:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D364B1BC063;
	Thu, 20 Jun 2024 17:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQv6FYBy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hv+TbqTu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rQv6FYBy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Hv+TbqTu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A261BBBE0
	for <linux-btrfs@vger.kernel.org>; Thu, 20 Jun 2024 17:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718905243; cv=none; b=R3fEVsCIOW1iUjLGB2igAyh8F32MmoQ5tmLkJr4OIR/sCAeLjjvk/Y5LCeQSLAFSl93cLM2CJcfcDTdmj+vwgpxB2mSWaBDYGXL8Q9EniYohBQnGw7VbIHdSf6Iv1oFBKlNsgfHgqKq5ouK5INB0ZezJ4q/dLPrf+hqoaSXmlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718905243; c=relaxed/simple;
	bh=Z5jhlvzvTSm/H3Q81uyQm0nEN52Rl6I94hhv2El/ABI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kYFiAs8wqq+DDk8SaDwZiesVxSoTOX52+MdLLLyA4zXMQ9Oo0mq0L73IeyoITb+Q1dzFcLGjyqCbcvO0myPALlDI8xumnXlNRJAVwJP4Zb+IKOhIfnW2z6SjY7rBZCsiLFAcwFnzcj5PbtLalxgpDkPBzo/UZy5TjynhehNjllE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQv6FYBy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hv+TbqTu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rQv6FYBy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Hv+TbqTu; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C74A621B11;
	Thu, 20 Jun 2024 17:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718905238;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKnwbdQ2bFUkTEaI0ad97Bw57+h+ZWEWTWonzt+805w=;
	b=rQv6FYBySgnEPzG8oHov8cEzEEJVPiMkJrOTIMeawy75GcVno+19vjSlNB67/eS9j5y4Km
	enySaBvgf3jPQySH+uPbxGeYW0NxMLOs1TNhJAPG9AXvLjJMI7tTS5d2K1U1F0PWy/0e4U
	Zb1XusIOI8j3Cd1vHdcQZwLXiBVK4Vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718905238;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKnwbdQ2bFUkTEaI0ad97Bw57+h+ZWEWTWonzt+805w=;
	b=Hv+TbqTuT7FluwTLuctpHvjUO65iKwZ9265/yPHaToRGTzgSv8XcGxUvbJA4cK4TEwKPyP
	T/K+6U8iC9Hn9iDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718905238;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKnwbdQ2bFUkTEaI0ad97Bw57+h+ZWEWTWonzt+805w=;
	b=rQv6FYBySgnEPzG8oHov8cEzEEJVPiMkJrOTIMeawy75GcVno+19vjSlNB67/eS9j5y4Km
	enySaBvgf3jPQySH+uPbxGeYW0NxMLOs1TNhJAPG9AXvLjJMI7tTS5d2K1U1F0PWy/0e4U
	Zb1XusIOI8j3Cd1vHdcQZwLXiBVK4Vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718905238;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rKnwbdQ2bFUkTEaI0ad97Bw57+h+ZWEWTWonzt+805w=;
	b=Hv+TbqTuT7FluwTLuctpHvjUO65iKwZ9265/yPHaToRGTzgSv8XcGxUvbJA4cK4TEwKPyP
	T/K+6U8iC9Hn9iDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3E1313ACC;
	Thu, 20 Jun 2024 17:40:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kAfTJ5ZpdGaQIQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 20 Jun 2024 17:40:38 +0000
Date: Thu, 20 Jun 2024 19:40:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: qgroup: preallocate memory before adding a
 relation
Message-ID: <20240620174037.GL25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718816796.git.dsterba@suse.com>
 <950a5c2128b1ea79be6c7c438649b71201db00dc.1718816796.git.dsterba@suse.com>
 <5e580529-ca09-4ede-930e-d8ae5622c0cf@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5e580529-ca09-4ede-930e-d8ae5622c0cf@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Thu, Jun 20, 2024 at 11:29:22AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2024/6/20 02:39, David Sterba 写道:
> > There's a transaction joined in the qgroup relation add/remove ioctl and
> > any error will lead to abort/error. We could lift the allocation from
> > btrfs_add_qgroup_relation() and move it outside of the transaction
> > context. The relation deletion does not need that.
> >
> > The ownership of the structure is moved to the add relation handler.
> >
> > Signed-off-by: David Sterba <dsterba@suse.com>
> > ---
> >   fs/btrfs/ioctl.c  | 20 ++++++++++++++++----
> >   fs/btrfs/qgroup.c | 25 ++++++++-----------------
> >   fs/btrfs/qgroup.h | 11 ++++++++++-
> >   3 files changed, 34 insertions(+), 22 deletions(-)
> >
> > diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> > index d28ebabe3720..31c4aea8b93a 100644
> > --- a/fs/btrfs/ioctl.c
> > +++ b/fs/btrfs/ioctl.c
> > @@ -3829,6 +3829,7 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
> >   	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);
> >   	struct btrfs_root *root = BTRFS_I(inode)->root;
> >   	struct btrfs_ioctl_qgroup_assign_args *sa;
> > +	struct btrfs_qgroup_list *prealloc = NULL;
> >   	struct btrfs_trans_handle *trans;
> >   	int ret;
> >   	int err;
> > @@ -3849,17 +3850,27 @@ static long btrfs_ioctl_qgroup_assign(struct file *file, void __user *arg)
> >   		goto drop_write;
> >   	}
> >
> > +	prealloc = kzalloc(sizeof(*prealloc), GFP_KERNEL);
> > +	if (!prealloc) {
> > +		ret = -ENOMEM;
> > +		goto drop_write;
> > +	}
> > +
> >   	trans = btrfs_join_transaction(root);
> >   	if (IS_ERR(trans)) {
> >   		ret = PTR_ERR(trans);
> >   		goto out;
> >   	}
> >
> > -	if (sa->assign) {
> > -		ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst);
> > -	} else {
> > +	/*
> > +	 * Prealloc ownership is moved to the relation handler, there it's used
> > +	 * or freed on error.
> > +	 */
> > +	if (sa->assign)
> > +		ret = btrfs_add_qgroup_relation(trans, sa->src, sa->dst, prealloc);
> > +	else
> >   		ret = btrfs_del_qgroup_relation(trans, sa->src, sa->dst);
> > -	}
> > +	prealloc = NULL;
> 
> This leads to memory leak, as if we're doing relation deletion, we just
> do the preallocation, then reset prealloc to NULL, no way to release the
> preallocated memory.

Right, I should maybe also add the preallocation only when it's adding
the relation so it does not fail for deletion where it's not needed.

