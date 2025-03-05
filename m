Return-Path: <linux-btrfs+bounces-12023-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99543A4FD0A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 12:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 322567A93BF
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 11:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FAF22D4E5;
	Wed,  5 Mar 2025 11:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W+RxEz40";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NrbpVajm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gQikiFSO";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sC9mKC9u"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C5C1F03C1
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741172500; cv=none; b=fkX9mtWCItLMFKASYUAnjLRo48hjVrVdEi8sMGRHTGoQcJe/WZORGAFA1sUWzvLZ8Kh0S4cdYhGgdl/2TkuCrT44lBzl8dCX3Bq7yQz5GDrvfB6W3V1popsg6B+TOy4yi4PC/5kopmNxYEchD0/9tLGyIcsy+dpgD5n0TR5xJ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741172500; c=relaxed/simple;
	bh=+5aorUHf4c6pczQRzbQPr07mMhubR8pJi9zJIJvKeUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=quRDSdcTszlvFVmyKPT0IE9UANIjV24eslVxDkP6VXMOp/yrsQq4u1wlJneOXMlf3uy88GA/4nW4yBNr5HaLVZIXyjvsB0KMwzaqqirOCbWraAmmT0JiaLJdfh10nFL8emoe/UwJ2TC6W0e7gnTOVRpXECXALfCGWZEklKnHWBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W+RxEz40; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NrbpVajm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gQikiFSO; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sC9mKC9u; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CCDE91F74C;
	Wed,  5 Mar 2025 11:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741172497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3q0n44daYNjBKnLEQNOFRxmyYWExSunmeItJCRJjR8w=;
	b=W+RxEz40lj93nfmndNkvmXcPO6VNjg/7IPeuDuNoL+4+TOSWRsAluv0ntG4FZHMp8TXLee
	MXO70wFeZxRKuMNTKxLSX82St0Cet5yfB7vXptU5JWosxEn0UQXtcyN6bDTMc3kua6Ur5/
	ZSA17tAuhq9XfAKSQh1AROsvmiqgCv4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741172497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3q0n44daYNjBKnLEQNOFRxmyYWExSunmeItJCRJjR8w=;
	b=NrbpVajm1jcKHgfLtdDTNLzLBHrO45DZe1hYj5WGmZeQfCU1GqP6uQ/xlNAX6L8KDplVYa
	+bKRDnsRBZEUoGAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gQikiFSO;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sC9mKC9u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741172496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3q0n44daYNjBKnLEQNOFRxmyYWExSunmeItJCRJjR8w=;
	b=gQikiFSOj/eOsZcZPgkcaQb5nOQ6/02TJXAFBBeilKBtjyNn/EtKxtejbpW4VlsJ/jFd0+
	WZ8PqEWjB6hM0c7Xb7pjuxCCa9TmEetkVoSn4YdUWdxmGUZaCyJT7KDIjcbXWxX87D3aq5
	8WPr8CButE8lntTPBPwRsrdfY8yHGS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741172496;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3q0n44daYNjBKnLEQNOFRxmyYWExSunmeItJCRJjR8w=;
	b=sC9mKC9u8ZffSzA+8t4784Um1knwjQZPYcIcCakIx+YNIJwgOzah/UFF9bhFEBj5SDDAm2
	jJPTsi71w3otqtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC98F13939;
	Wed,  5 Mar 2025 11:01:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K7bYLRAvyGeZCwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Mar 2025 11:01:36 +0000
Date: Wed, 5 Mar 2025 12:01:35 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/5] Ioctl to clear unused space in various ways
Message-ID: <20250305110135.GE5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740753608.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740753608.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: CCDE91F74C
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Feb 28, 2025 at 03:49:20PM +0100, David Sterba wrote:
> Add ioctl that is similar to FITRIM and in addition to trim can do also
> zeroing (either plain overwrite, or unmap the blocks if the device
> supports it) and secure erase.
> 
> This can be used to zero the unused space in e.g. VM images (when run
> from inside the guest, if fstrim is not supported) or free space on
> thin-provisioned devices.
> 
> The secure erase is provided by blkdiscard command but I'm not aware of
> equivalent that can be run on a filesystem, so this is for parity.

For current implementation of TRIM we have the in-memory cache that
tracks which chunks have been trimmed so it's not duplicating the IO.
As the CLEAR code builds on tre trim code the cache would apply to any
of the new modes, which is probably not what we want.

