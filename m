Return-Path: <linux-btrfs+bounces-7217-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 239B4953A56
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 20:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF763285CE5
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Aug 2024 18:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2657641C65;
	Thu, 15 Aug 2024 18:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NoKvCrpJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H9nY2vq6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NoKvCrpJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H9nY2vq6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF5138382
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Aug 2024 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723747582; cv=none; b=BS7BwrihX2MHp77a/EWqYVr7UH+QKe8hg7Fr+pr/lqfH/5HrgP8DvC7IEMFmqbQxu2VcihHQM0njg/7LL/Svc+kwDULxzPo59Bg4pKZtt8U1haolPPOiQe947ClOz/Qs4PPMkLhWLaSCy7JSfsxw62b8IVLfH2zfem6JCmg7nsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723747582; c=relaxed/simple;
	bh=qDWH7oyWcDfvffbfWVzY2E/ROecGpHkpR0e5dkHADX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4nyRZFHBRdvr4RsgpakqgQqJVzhY4JvUthTh8j7aJAJrYblx3zQ1w2b3BLJ4K3ZKlq8kTG2b5oVopPg4Q1vur3uyv0205Os+fWauddsB+u/eoofTFD05MFjD/MO2yNk09yOAu7bEG59j9hdOPnWmPGVnkHy/sj43ahY+Sae7oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NoKvCrpJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H9nY2vq6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NoKvCrpJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H9nY2vq6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 642192209A;
	Thu, 15 Aug 2024 18:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723747578;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7J1NtbxOKgFPN5UdN2QPhQt3IDzBvn1CmTEYmSKeeI=;
	b=NoKvCrpJqBUSkdSokjAgOJTcgHyYeR8e9gHmgVyouIhy2mYC1yOF5sQMDNbITva8rzR3qU
	vlojgE36M2+ypfAFOZYQFa/5fkM4LyqoAkSj+N2hyCkxwIBJ1nx/hRsjUIOqENsatfu95r
	IadHILtvc/PqDhZHVKJNmAm8E7kZ9Zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723747578;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7J1NtbxOKgFPN5UdN2QPhQt3IDzBvn1CmTEYmSKeeI=;
	b=H9nY2vq6ntmX8i/akp8mIRRhEaaiHVtIS2nK/zTsm+OqP7o1VA1kYDR6PMXmtcpXY2FtYK
	8FWngdJtiEuy3JBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NoKvCrpJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=H9nY2vq6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723747578;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7J1NtbxOKgFPN5UdN2QPhQt3IDzBvn1CmTEYmSKeeI=;
	b=NoKvCrpJqBUSkdSokjAgOJTcgHyYeR8e9gHmgVyouIhy2mYC1yOF5sQMDNbITva8rzR3qU
	vlojgE36M2+ypfAFOZYQFa/5fkM4LyqoAkSj+N2hyCkxwIBJ1nx/hRsjUIOqENsatfu95r
	IadHILtvc/PqDhZHVKJNmAm8E7kZ9Zs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723747578;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7J1NtbxOKgFPN5UdN2QPhQt3IDzBvn1CmTEYmSKeeI=;
	b=H9nY2vq6ntmX8i/akp8mIRRhEaaiHVtIS2nK/zTsm+OqP7o1VA1kYDR6PMXmtcpXY2FtYK
	8FWngdJtiEuy3JBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41AED13983;
	Thu, 15 Aug 2024 18:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GdWTD/pMvmYGRQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 15 Aug 2024 18:46:18 +0000
Date: Thu, 15 Aug 2024 20:46:17 +0200
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 0/2] btrfs: add __free attribute and improve xattr cleanup
Message-ID: <20240815184617.GF25962@suse.cz>
Reply-To: dsterba@suse.cz
References: <cover.1723245033.git.loemra.dev@gmail.com>
 <20240813212903.GS25962@twin.jikos.cz>
 <i9tc0.0f867os9viy6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i9tc0.0f867os9viy6@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 642192209A
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spam-Score: -4.21

On Thu, Aug 15, 2024 at 10:38:24AM -0700, Leo Martins wrote:
> On Tue, 13 Aug 2024 14:29, David Sterba <dsterba@suse.cz> wrote:
> >On Fri, Aug 09, 2024 at 04:11:47PM -0700, Leo Martins wrote:

> This makes sense, I will drop the xattr patch. Do you think there would
> be any benefit in using the __free pattern in situations where it
> is clear that btrfs_free_path is the last thing called before returning?
> For example:
> 
> 
> int btrfs_del_orphan_item(struct btrfs_trans_handle *trans,
> 			  struct btrfs_root *root, u64 offset)
> {
> 	struct btrfs_path *path;
> 	struct btrfs_key key;
> 	int ret = 0;
> 
> 	key.objectid = BTRFS_ORPHAN_OBJECTID;
> 	key.type = BTRFS_ORPHAN_ITEM_KEY;
> 	key.offset = offset;
> 
> 	path = btrfs_alloc_path();
> 	if (!path)
> 		return -ENOMEM;
> 
> 	ret = btrfs_search_slot(trans, root, &key, path, -1, 1);
> 	if (ret < 0)
> 		goto out;
> 	if (ret) { /* JDM: Really? */
> 		ret = -ENOENT;
> 		goto out;
> 	}
> 
> 	ret = btrfs_del_item(trans, root, path);
> 
> out:
> 	btrfs_free_path(path);
> 	return ret;
> }
> 
> 
> In this code the behavior would be the same except it would eliminate
> the need for goto out as the path is freed automatically on exit.

Yes, this is where I coudl be used, basically it's a pattern where the
lock/allocation is done early at the beginning of a function (after some
initial checks) and then right before a return and all exit paths lead
there.

For that I'd suggest to make it clear that the function uses the
automatic unlock/deletion so the declaration of the variable would be
done like

  BTRFS_PATH_AUTOCLEAN(name);

that declares it with the proper __free callback and initializes it to
NULL.

There's another thing that's a common pattern in btrfs and other kernel,
code, the single exit block. The __free callback allows to do a return
anywhere which is the opposite of that. As this is new we should look up
good examples that will be the patterns to follow or exceptions to
avoidd so we can declare it current best practice and recommended coding
style.

