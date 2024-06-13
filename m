Return-Path: <linux-btrfs+bounces-5718-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10CC907DDC
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 23:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0F301C22911
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 21:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C254913CFB6;
	Thu, 13 Jun 2024 21:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m8UjVK2g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7CHS22E0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m8UjVK2g";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7CHS22E0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E6013BC0E
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 21:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718313046; cv=none; b=a7BXINJufb+FhG2oYoSfa+swYYifMRNBBrYvMiRNl0LR6mjgBTFHXMFSZkyqkTnsRygHvEblik6H2WNHlDWMZGttyR3L7ep7+FHXjEFg61en353FHb/elV6IZSavfGqTNMqVU6iGkdjLu2E/zfNpPjTp2ZzawrCWI73GF8RPne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718313046; c=relaxed/simple;
	bh=9ie+JurX4XyFTzVBtFEY0QZMW+DzbuHxxzsz1gXoc4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O0TdRtE5nEnxZh8qp9W/ihlFHZaN879poe4zCIGdNZYk2yigEqYcoU2qovZ0q2LlftNmjEvLyfSb45uTIWrnx0MxmsoFIJZgL2jd8+A0euWww+GhrM7fs1EThlPKzj9xmeB38n7Od+DZ1E9hCfUEFuMVP6odwbdLE2DT2EneU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m8UjVK2g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7CHS22E0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m8UjVK2g; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7CHS22E0; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1695A21B6F;
	Thu, 13 Jun 2024 21:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718313043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iW32GvfEi7pDDOqbFm92Tt+7ia5jbd5qo8Lq7goP2WQ=;
	b=m8UjVK2gmtVcfTE4L5QXNJCSbEqJ8cNPs9+IyPILsXFSeaJ2PmHv9D+/g8C9/LqDG67fnC
	sB5OGdjEqoV/TTgJvQHappQcfSMHyHVC9vIJUYAr0eeISZN8cSBFMvGFiaaLv7+lh4Oyvn
	qHeSCr9zAsFzNwC72hJRyBU9P4u+RTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718313043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iW32GvfEi7pDDOqbFm92Tt+7ia5jbd5qo8Lq7goP2WQ=;
	b=7CHS22E036WH/yNKBWFr5CPBkx32Bfi+mYeLetj6qBsT4gA+RmnCe+1jWpMOnXDmDccn2S
	QoSNF3KlLt3VDKCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=m8UjVK2g;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7CHS22E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718313043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iW32GvfEi7pDDOqbFm92Tt+7ia5jbd5qo8Lq7goP2WQ=;
	b=m8UjVK2gmtVcfTE4L5QXNJCSbEqJ8cNPs9+IyPILsXFSeaJ2PmHv9D+/g8C9/LqDG67fnC
	sB5OGdjEqoV/TTgJvQHappQcfSMHyHVC9vIJUYAr0eeISZN8cSBFMvGFiaaLv7+lh4Oyvn
	qHeSCr9zAsFzNwC72hJRyBU9P4u+RTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718313043;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iW32GvfEi7pDDOqbFm92Tt+7ia5jbd5qo8Lq7goP2WQ=;
	b=7CHS22E036WH/yNKBWFr5CPBkx32Bfi+mYeLetj6qBsT4gA+RmnCe+1jWpMOnXDmDccn2S
	QoSNF3KlLt3VDKCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0C6A13A7F;
	Thu, 13 Jun 2024 21:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l9WaOlJga2bDPwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Jun 2024 21:10:42 +0000
Date: Thu, 13 Jun 2024 23:10:41 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs: fix a deadlock with reclaim during
 logging/log replay
Message-ID: <20240613211041.GA25756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1718276261.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1718276261.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1695A21B6F
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, Jun 13, 2024 at 12:05:24PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fix a deadlock when opening an inode during inode logging and log replay
> due to a GFP_KERNEL allocation, reported by syzbot. The rest is just some
> trivial cleanups. Details in the change logs.
> 
> Filipe Manana (4):
>   btrfs: use NOFS context when getting inodes during logging and log replay
>   btrfs: remove super block argument from btrfs_iget()
>   btrfs: remove super block argument from btrfs_iget_path()
>   btrfs: remove super block argument from btrfs_iget_locked()

Reviewed-by: David Sterba <dsterba@suse.com>

