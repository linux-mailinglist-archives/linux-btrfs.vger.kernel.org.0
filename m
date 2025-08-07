Return-Path: <linux-btrfs+bounces-15909-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1903B1DCFB
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 20:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7B7E18854A8
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 Aug 2025 18:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12523271453;
	Thu,  7 Aug 2025 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aNb1+gYd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wuScCrFa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aNb1+gYd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wuScCrFa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC4D26A1AC
	for <linux-btrfs@vger.kernel.org>; Thu,  7 Aug 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754591036; cv=none; b=CahEfm5MCnaCWgD2Gj3unh9wmX3S3jtGTVH+oPzwZtAruEcm7ov1j1uVBfcTSPyfpKhFKeBiTPwWp0YCoMSchzUxKs+6vuYL5y7P0Pcxc41rM87DlM+w9BVSDuCX+UsDdAPs2gg40cn61ZXGM73sFoT9AjSPUmSSNMcOTV93Ai0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754591036; c=relaxed/simple;
	bh=/p3x405F1tObt10wCeNN0cCPymwem0ERwTq+kaT5Oy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+2apBBzE5UVpx8dFTLLu2G5++ruM9MejBVy4wtBde9PE8itA07dB6pwOnkvRr/lLd4j3Y1vrNXCZKDQfiXtOCw0Vv6H3Nqj8MeFN0fhUQz+g+ssDk4QINpSLfU7K6NOynSncreq0+CDNzPugfsst1l7BoZT9ScqsZmnTse1Nr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aNb1+gYd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wuScCrFa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aNb1+gYd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wuScCrFa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E56B533DB0;
	Thu,  7 Aug 2025 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754591031;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jd3eYnz0J6tBBBGRHAOxXHwCc2e22uyw3dpT/+q4kQs=;
	b=aNb1+gYd8Ef5Z7AJHupCnMG64zpGLfXgnwNxFQpiwhQxQZyE+ix7szKxovodTQgMqYsdlq
	6jvcm6hdADfWL2cIQdlN8rVHIwGJhiarYgUzGpv7D+cVQm02GQatVNagMKFUzLOhjgm0ee
	S3qfcYTSUlglyuRgjLovLJcxSmy65tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754591031;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jd3eYnz0J6tBBBGRHAOxXHwCc2e22uyw3dpT/+q4kQs=;
	b=wuScCrFaq0gmidBB58UZQLTPR+YrML72ulrWVeQtHqyxdOiiIxpDJSkaI6aVt6w657W2kO
	dEYmdJkiwT9cAwBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1754591031;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jd3eYnz0J6tBBBGRHAOxXHwCc2e22uyw3dpT/+q4kQs=;
	b=aNb1+gYd8Ef5Z7AJHupCnMG64zpGLfXgnwNxFQpiwhQxQZyE+ix7szKxovodTQgMqYsdlq
	6jvcm6hdADfWL2cIQdlN8rVHIwGJhiarYgUzGpv7D+cVQm02GQatVNagMKFUzLOhjgm0ee
	S3qfcYTSUlglyuRgjLovLJcxSmy65tQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1754591031;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Jd3eYnz0J6tBBBGRHAOxXHwCc2e22uyw3dpT/+q4kQs=;
	b=wuScCrFaq0gmidBB58UZQLTPR+YrML72ulrWVeQtHqyxdOiiIxpDJSkaI6aVt6w657W2kO
	dEYmdJkiwT9cAwBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CFF2D136DC;
	Thu,  7 Aug 2025 18:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zrdhMjfvlGhVYgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 07 Aug 2025 18:23:51 +0000
Date: Thu, 7 Aug 2025 20:23:50 +0200
From: David Sterba <dsterba@suse.cz>
To: sawara04.o@gmail.com
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	johannes.thumshirn@wdc.com, brauner@kernel.org,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: restore mount option info messages during mount
Message-ID: <20250807182350.GO6704@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250728020719.37318-1-sawara04.o@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728020719.37318-1-sawara04.o@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.50

On Mon, Jul 28, 2025 at 11:07:18AM +0900, sawara04.o@gmail.com wrote:
> From: Kyoji Ogasawara <sawara04.o@gmail.com>
> 
> After the fsconfig migration, mount option info messages are no longer
> displayed during mount operations because btrfs_emit_options() is only
> called during remount, not during initial mount.

I see messages at first mount that I'd expect to see:

[625.459381] BTRFS info (device vda): first mount of filesystem bca4e1c1-9ca9-441c-8a6a-7004e31763bf
[625.460384] BTRFS info (device vda): using crc32c (crc32c-generic) checksum algorithm
[625.461192] BTRFS info (device vda): using free-space-tree

is there anything specific in your test other than mkfs and mount?

