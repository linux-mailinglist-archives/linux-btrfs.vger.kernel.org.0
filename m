Return-Path: <linux-btrfs+bounces-14575-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A6AD263D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 20:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE983A1D4D
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Jun 2025 18:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0582921D3D6;
	Mon,  9 Jun 2025 18:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lrN14B9a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rfd8vAwe";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lrN14B9a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Rfd8vAwe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3421D3C0
	for <linux-btrfs@vger.kernel.org>; Mon,  9 Jun 2025 18:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749495340; cv=none; b=J5xktgYchwDod80wXZEGTnqvols2W5HQLa/V4gXiYBdKJlUB/5/aEHEb1NYKlK0wBnQEO7Hu9mn3VofPn0DFLjnCJw2XfnpbvvD/3ZrcIRg1Jsa02ynDsX5T55UK6OkN2qxCBw3hEORT7LAv0sPViHwcjk+n1mbjUuiV+zSOnuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749495340; c=relaxed/simple;
	bh=AioD6RMQEkpTX0EqSOuZCIVpXp771GvIf7xT2KZjZ50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeOGJblicypeXFAiXmpgeiYYksz9lTLSdqdY+E1Ae9MB+eaOTlMSrMcNPL7iQU0IWDBVRZ/gboZYwYttkwN07K/nGgXBv/LXpX8sDcLv4uXWnHTs9t4VYz71XO32+8MRFtTqjgkbC3Gjg1qVR1l3sXBiPxv17h/+tljK9GaIeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lrN14B9a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rfd8vAwe; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lrN14B9a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Rfd8vAwe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BFD9F1F46E;
	Mon,  9 Jun 2025 18:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749495336;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHPGhuVu0/HD5F0DlgIkjRcoudKH5A7enzJRcAefwJg=;
	b=lrN14B9afx+mXbyrDVRwHN+Kv3t+dPr8mq8p9YZ6djvbFY/E3CdRoPSE310QjiWCKYvobs
	g3pHgYHcr1/4NGzfedLnzScKdgFQaZHtKSKjuq5RbBe/J8Cxq0aNCEl+IfLLSkhytM16MJ
	c8h9v8azA1mW8NK7PI+rV0BzkNP0gD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749495336;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHPGhuVu0/HD5F0DlgIkjRcoudKH5A7enzJRcAefwJg=;
	b=Rfd8vAwemMQVWNx4KDFy1FizQkeuMFWnM5lDNbWTCSJCxp6u5ZEDADqGRFEyS0St4V1Sqt
	G7erlX8Prj9mCDAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lrN14B9a;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Rfd8vAwe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1749495336;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHPGhuVu0/HD5F0DlgIkjRcoudKH5A7enzJRcAefwJg=;
	b=lrN14B9afx+mXbyrDVRwHN+Kv3t+dPr8mq8p9YZ6djvbFY/E3CdRoPSE310QjiWCKYvobs
	g3pHgYHcr1/4NGzfedLnzScKdgFQaZHtKSKjuq5RbBe/J8Cxq0aNCEl+IfLLSkhytM16MJ
	c8h9v8azA1mW8NK7PI+rV0BzkNP0gD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1749495336;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WHPGhuVu0/HD5F0DlgIkjRcoudKH5A7enzJRcAefwJg=;
	b=Rfd8vAwemMQVWNx4KDFy1FizQkeuMFWnM5lDNbWTCSJCxp6u5ZEDADqGRFEyS0St4V1Sqt
	G7erlX8Prj9mCDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A638F137FE;
	Mon,  9 Jun 2025 18:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YYlcKCguR2hwOQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 09 Jun 2025 18:55:36 +0000
Date: Mon, 9 Jun 2025 20:55:35 +0200
From: David Sterba <dsterba@suse.cz>
To: Filipe Manana <fdmanana@kernel.org>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RESEND] btrfs: add extra warning when qgroup is marked
 inconsistent
Message-ID: <20250609185535.GA4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e4811c2208b00be4b3206f24db6b81691b3de74e.1749467712.git.wqu@suse.com>
 <CAL3q7H5MXb0QK02o39HWFS4CHVJ2ybD9SX7njzQbPYjTm5G7NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL3q7H5MXb0QK02o39HWFS4CHVJ2ybD9SX7njzQbPYjTm5G7NA@mail.gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BFD9F1F46E
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.com:email,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:replyto,twin.jikos.cz:mid]
X-Spam-Score: -4.21
X-Spam-Level: 

On Mon, Jun 09, 2025 at 01:17:30PM +0100, Filipe Manana wrote:
> On Mon, Jun 9, 2025 at 12:16 PM Qu Wenruo <wqu@suse.com> wrote:
> >
> > Unlike qgroup rescan, which always shows whether it cleared the
> > inconsistent flag, we do not have a proper way to show if qgroup is
> > marked inconsistent.
> >
> > This was not a big deal before as there aren't that many locations that
> > can mark qgroup  inconsistent.
> >
> > But with the introduction of drop_subtree_threshold, qgroup can be
> > marked inconsistent very frequently, especially for dropping large
> > subvolume.
> >
> > Although most user space tools relying on qgroup should do their own
> > checks and queue a rescan if needed, we have no idea when qgroup is
> > marked inconsistent, and will be much harder to debug.
> >
> > So this patch will add an extra warning (btrfs_warn_rl()) when the
> > qgroup flag is flipped into inconsistent for the first time.
> >
> > Combined with the existing qgroup rescan messages, it should provide
> > some clues for debugging.
> >
> > Signed-off-by: Qu Wenruo <wqu@suse.com>
> > ---
> > Pure resent, I thought it was already merged but it's not the case.
> > It will be very helpful for debugging qgroup related problems caused by
> > qgroup being marked inconsistent.
> > ---
> >  fs/btrfs/qgroup.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
> > index a1afc549c404..45f587bd9ce6 100644
> > --- a/fs/btrfs/qgroup.c
> > +++ b/fs/btrfs/qgroup.c
> > @@ -350,6 +350,8 @@ static void qgroup_mark_inconsistent(struct btrfs_fs_info *fs_info)
> >  {
> >         if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_SIMPLE)
> >                 return;
> > +       if (!(fs_info->qgroup_flags & BTRFS_QGROUP_STATUS_FLAG_INCONSISTENT))
> > +               btrfs_warn_rl(fs_info, "qgroup marked inconsistent");
> 
> About half the callers already log some message right before or right
> after calling this function.
> But this won't tell us much about why/where the qgroup was marked
> inconsistent for all the other callers.
> 
> Perhaps we can pass a string to this function and include it in the
> warning message? And then remove the logging from all callers that do
> it.
> Additionally turning this into a macro, and then printing __FILE__ and
> __LINE__ too, would make it a lot more useful for debugging.

If this is meant for debugging then the message level should be either
debug or info, but not warn. If it's for user information then the file
and line is not relevant.

Otherwise agreed about printing the reason why it's marked inconsistent.

