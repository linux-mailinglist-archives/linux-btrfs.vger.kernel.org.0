Return-Path: <linux-btrfs+bounces-9638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0349C8D96
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2FD01B2BDB0
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B179B13CA8D;
	Thu, 14 Nov 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uC4100/n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kfsZpMow";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r6TxvgaL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Bg0POdvE"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CF770FE
	for <linux-btrfs@vger.kernel.org>; Thu, 14 Nov 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731596805; cv=none; b=NSnJgtsTtkpQ18eeTWiG274O+WM0dTfnXdH4BQP99YNVaSA16HKUqwiNns4ood3iy63Z4FWml3YDNavlge+kDO4SqUVnC9YjA/WlIFXt6p+kU+Ho00w7fbAHp7cJziwBWFWGFDQ5BuzGAJE4iLsdGAbg+DV3Ion1FR4ZE9+SKas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731596805; c=relaxed/simple;
	bh=8DJvHqZS6ediJpHoAbQS5faj7t5aMwfBmNrf7J9FiKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmtFxaFqK9HX98daTJoDyWyayRTOV5qCKDvaqCcLRFPkWjolg+yXFvXpUBkPJHBBV4KI5QWuQUWCvMjqGQxSZEuWu61NDREvt4G2cmUfzWXZX4KKs+5RHM/j13QtAyu3aZoytT8wZiJzRmq8n3Qe9GGAuoBV/W4ZK0pior7EMMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uC4100/n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kfsZpMow; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r6TxvgaL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Bg0POdvE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1F115210ED;
	Thu, 14 Nov 2024 15:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731596802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbRgm+CtJJ0Wp1OY6Unre7dZ8QT8/5u6Vwi7XUObXAA=;
	b=uC4100/nqLp+baN6FPB4ZGzzPineuBRt+gHUwBizQpH/B3MTVAvZM/1l+oViHukZH1/r7q
	647hbXrL0JwTatWNtJ6ro+kYhXxiSzdUXfS2r8WsW2plCK9q2W4bRV9TfMIV3sdrBDk15Y
	O5z7qvEt/l9TruDRUcIWjsornveraxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731596802;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbRgm+CtJJ0Wp1OY6Unre7dZ8QT8/5u6Vwi7XUObXAA=;
	b=kfsZpMowOcL0xRcRYPGu2dLFMPLBfUPOvPL+cEASfQ+0PRuTPe57mMMzd7VgJSOtyyuwyf
	gqDevwpEVt8+mlBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r6TxvgaL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Bg0POdvE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731596800;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbRgm+CtJJ0Wp1OY6Unre7dZ8QT8/5u6Vwi7XUObXAA=;
	b=r6TxvgaLrK/s90b64LkIohTZBTdTJ6K6+RKQQLrMNirliNSRFq6PfDQuqm8Qqu8AnSsh32
	/DoeYjDTI03D+3Z4Z4ePAPdZYBGILBk9gsOj8HGvI3eU3/7QQDAlmmNNEc6iisMpix2luu
	Zwu5fFJEZFnoTcgluYoGe0c03X0Hl5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731596800;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KbRgm+CtJJ0Wp1OY6Unre7dZ8QT8/5u6Vwi7XUObXAA=;
	b=Bg0POdvEWH8fHf0oVsxv8j8IoDRovCRNC+1K7yvtCaFO3MthcQpOrDG1AWswG3sJ7ug+0J
	awq/Ufr8bvW47eCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09E8213721;
	Thu, 14 Nov 2024 15:06:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X3rCAQASNmdbAgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 14 Nov 2024 15:06:40 +0000
Date: Thu, 14 Nov 2024 16:06:30 +0100
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: fix lockdep warnings on io_uring encoded reads
Message-ID: <20241114150630.GT31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241112160055.1829361-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112160055.1829361-1-maharmstone@fb.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1F115210ED
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,fb.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,wdc.com:email,twin.jikos.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Tue, Nov 12, 2024 at 04:00:49PM +0000, Mark Harmstone wrote:
> Lockdep doesn't like the fact that btrfs_uring_read_extent() returns to
> userspace still holding the inode lock, even though we release it once
> the I/O finishes. Add calls to rwsem_release() and rwsem_acquire_read() to
> work round this.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/ioctl.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
> index 1fdeb216bf6c..6ea01e4f940e 100644
> --- a/fs/btrfs/ioctl.c
> +++ b/fs/btrfs/ioctl.c
> @@ -4752,6 +4752,11 @@ static void btrfs_uring_read_finished(struct io_uring_cmd *cmd, unsigned int iss
>  	size_t page_offset;
>  	ssize_t ret;
>  
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	/* The inode lock has already been acquired in btrfs_uring_read_extent.  */
> +	rwsem_acquire_read(&inode->vfs_inode.i_rwsem.dep_map, 0, 0, _THIS_IP_);
> +#endif

Please put that to a wrapper, we want to avoid #ifdefs in the middle of
functions (there are exceptions), especially when the macro is for lock
debugging.

The wrapper name can follow naming and syntax of the other
btrfs_lockde_* wrappers, so like btrfs_lockdep_inode_acquire(owner,
lock). There is only one rwsem in inode, but for clarity and consistency
I think it makes sense.

btrfs_lockdep_inode_acquire(inode, i_rwsem);

