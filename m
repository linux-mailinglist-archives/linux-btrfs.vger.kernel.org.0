Return-Path: <linux-btrfs+bounces-19112-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F29FC6BAA8
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 21:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 03BCF28EC5
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 20:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC32309F09;
	Tue, 18 Nov 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKjaIOKu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dJLGY0xf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="y5/jD4M8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="X/nxfcJ+"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FD522B5AC
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 20:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763498804; cv=none; b=qbK46GuXnyrSJHEx1xvs1c7kAV5KWp4BlDeJp/cY/cYrG1TztrRFbTynBSrORrm+oeIttM82lbtoAJvve5l5vlkEp7EVzmr4q1I2sAGBXhipwchpvoFFkxBXwhvCCxu4Jn9Q2KrKol5e5mdvrnDC3TtVccyfXM4MdOYw5agD6fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763498804; c=relaxed/simple;
	bh=ofrOqlDrfpn6INyU27MBzSTgx6Sr9iGS3sNIT9K09j8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YW6c65VGwIExxpZ/mkrOvf74wwWNj3+wlO3T++mwDy3wcyadmIibCva5lCfL9wJYSAs4CTnVRuAsNIu4gtOhjGua9websZ4/e0T7Xt/sPI2kvUWg1HuwyGvhOWViZvQirsHo5vprrxUFVfJnXHV6ME6cJDxEYX23sddNCHZh46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sKjaIOKu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dJLGY0xf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=y5/jD4M8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=X/nxfcJ+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0B652120F;
	Tue, 18 Nov 2025 20:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763498801;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AY9eyA1S7ImoXcnUW3UQqmdgi6kjQ7Eir/Ynz60K8E=;
	b=sKjaIOKumT7gxIExFxSyS0bSuX2LKTm5ZQ4+Lnm9G0VdLgpZm/L6Axtz75PSqcpmBrlWBk
	beHcICha8uQWADcheGmf/lEiOETGaA1E8n8TOnVDw6I5EAMZuv3AEiEdyWIP81qAr21+aU
	7G3LslwVfpUn33PCU9ByFc153UwA6KY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763498801;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AY9eyA1S7ImoXcnUW3UQqmdgi6kjQ7Eir/Ynz60K8E=;
	b=dJLGY0xf7wwU2C7EmKrwxDRondc7siBdUIMQBPQZoswiE5K6xC9LYClzjAIFIIO+g9GcCp
	1lsJ79FLShYqi8Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="y5/jD4M8";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="X/nxfcJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763498800;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AY9eyA1S7ImoXcnUW3UQqmdgi6kjQ7Eir/Ynz60K8E=;
	b=y5/jD4M8W/9ea2/ZbkRIQWplGQhLrhRIEb5NulhuaOmtXOSTXoRs3waDvJ5hZH/vn6TxME
	fwx5dOdVOjMlUzIYyLCD2K73zDhz3ES6nYH96UZMSk0VoaOmx6fTE/RKh3UZ6yYv7kSehV
	Yd+/tiXC6C6MTdYOxLbwFmzAbTy7i9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763498800;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0AY9eyA1S7ImoXcnUW3UQqmdgi6kjQ7Eir/Ynz60K8E=;
	b=X/nxfcJ+taG6jbP0XbWMXla1E1YiAqJFFO0r3GTVSY2mRqIKHGYP/7pjWjtG/AdVSQnYEq
	u0JBi6wal2/u0NCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEBFB3EA61;
	Tue, 18 Nov 2025 20:46:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u2bkMTDbHGlhagAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Nov 2025 20:46:40 +0000
Date: Tue, 18 Nov 2025 21:46:39 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: some code cleanups in ctree.c
Message-ID: <20251118204639.GA13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251114072532.13205-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114072532.13205-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: E0B652120F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, Nov 14, 2025 at 03:24:44PM +0800, Sun YangKai wrote:
> No functional change. Details in change logs.
> 
> *** BLURB HERE ***

You still might want to give an overall idea of the cleanups if they're
related. No big deal if it's terse or copies (parts of) changelog of the
most significant change. Cleanups that mix functional and non-functional
changes might focus only on the functional changes. This basically helps
to set up the level of review and expectations. As you touch code that's
fundamental to the whole b-tree operations I feel we're fine to have
less clean and optimal code rather than to introduce subtle bugs.

> Sun YangKai (4):
>   btrfs: extract root promotion logic into promote_child_to_root()
>   btrfs: optimize balance_level() path reference handling
>   btrfs: simplify leaf traversal after path release in
>     btrfs_next_old_leaf()
>   btrfs: remove redundant level reset in btrfs_del_items()

I've put the patches to linux-next a few days ago and reviewed them
today again. I'll put them to for-next soon, all seem good. If you send
more cleanups in the future please keep it to small incremental and
understandable changes like this patchset does. Thanks.

