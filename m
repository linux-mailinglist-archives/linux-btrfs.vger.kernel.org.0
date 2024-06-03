Return-Path: <linux-btrfs+bounces-5421-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 770298D8A42
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 21:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BED38B2259A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Jun 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CC3139D0B;
	Mon,  3 Jun 2024 19:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bxHpehWP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8KwSV2br";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bxHpehWP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8KwSV2br"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0493838F
	for <linux-btrfs@vger.kernel.org>; Mon,  3 Jun 2024 19:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717443424; cv=none; b=tTdO4CA58aF+Aop44Wg3mHmaVa8MtHJmMN0HuXQo5AKYRp/XCP4fCGs5wdP04Wsxq+nGxg4vih8bREe4lZGCU/djPKP0cRiLb1f+4knYAceNVaKUAakCDRgd9pALtBPP9LIiWTGcSLQP7x5SGp0I7KP27sRj7f8phpR3ReNwN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717443424; c=relaxed/simple;
	bh=TcBIGewpYDN0g2aebGYHdwiVqdRlxc6Q05YcpO3f8pE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB3OIZRiN8tdWZ9IX12QDTrdCoZ2Dy4JKc1RxVDf4BkiLXdm/SLpiKzc4j+5Htz6+FaVLu+V5OfCQMeE4BwJfMPZi6qiJs/PDMzk+kS4sLNjJ+ODif0TFkMF7pWeSBOxP3vbjrW35B1/+qZ9vv3eYjDI0J6LEdNDcgZxBaN9thk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bxHpehWP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8KwSV2br; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bxHpehWP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8KwSV2br; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B380D1F441;
	Mon,  3 Jun 2024 19:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717443420;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCOdZYPZFaBQjk6BMbnaA1da9ebcexPdwrk8KJ1G/LY=;
	b=bxHpehWPw3TOwZ5eYVmwvUhZxPqkVrv8Ek8zwNNpwaAT3nLo++UdkSxdf+c0xISmBR0NnD
	3+ZlGCQ+WqBuXvN1uVKm4/K13/qTvhIR54OpVJgizrljYqx8dn79pf3tX5GJ/pZFNzTO92
	nR8g2E2CYtRtpz7DhmWS/x7RrebHWLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717443420;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCOdZYPZFaBQjk6BMbnaA1da9ebcexPdwrk8KJ1G/LY=;
	b=8KwSV2br6cD2A3FsHYRvAJP2nLJNqxg2V4O6G2zz7zkRr8H3sw30LLMLNowpKvQOcLATub
	TxTyxOF3JI5Qt+AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bxHpehWP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8KwSV2br
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717443420;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCOdZYPZFaBQjk6BMbnaA1da9ebcexPdwrk8KJ1G/LY=;
	b=bxHpehWPw3TOwZ5eYVmwvUhZxPqkVrv8Ek8zwNNpwaAT3nLo++UdkSxdf+c0xISmBR0NnD
	3+ZlGCQ+WqBuXvN1uVKm4/K13/qTvhIR54OpVJgizrljYqx8dn79pf3tX5GJ/pZFNzTO92
	nR8g2E2CYtRtpz7DhmWS/x7RrebHWLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717443420;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WCOdZYPZFaBQjk6BMbnaA1da9ebcexPdwrk8KJ1G/LY=;
	b=8KwSV2br6cD2A3FsHYRvAJP2nLJNqxg2V4O6G2zz7zkRr8H3sw30LLMLNowpKvQOcLATub
	TxTyxOF3JI5Qt+AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0948139CB;
	Mon,  3 Jun 2024 19:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X8oFJ1wbXmbdRAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 03 Jun 2024 19:37:00 +0000
Date: Mon, 3 Jun 2024 21:36:59 +0200
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v4 00/10] btrfs-progs: zoned: proper "mkfs.btrfs -b"
 support
Message-ID: <20240603193659.GB12376@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240529071325.940910-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529071325.940910-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B380D1F441
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.21

On Wed, May 29, 2024 at 04:13:15PM +0900, Naohiro Aota wrote:
> mkfs.btrfs -b <byte_count> on a zoned device has several issues listed
> below.
> 
> - The FS size needs to be larger than minimal size that can host a btrfs,
>   but its calculation does not consider non-SINGLE profile
> - The calculation also does not ensure tree-log BG and data relocation BG
> - It allows creating a FS not aligned to the zone boundary
> - It resets all device zones beyond the specified length
> 
> This series fixes the issues with some cleanups.
> 
> This one passed CI workflow here:
> 
> Patches 1 to 3 are clean up patches, so they should not change the behavior.
> 
> Patches 4 to 6 address the issues.
> 
> Patches 7 to 10 add/modify the test cases. First, patch 7 adds nullb
> functions to use in later patches. Patch 8 adds a new test for
> zone resetting. And, patches 9 and 10 rewrites existing tests with the
> nullb helper.
> 
> Changes:
> - v4:
>   -  Fix source directory size alignment.
> - v3: https://lore.kernel.org/linux-btrfs/dfd8887b-a2cb-425f-8705-0d6a94cefb9c@gmx.com/
>   - Tweak minimum FS size calculation style.
>   - Round down the specified byte_count towards sectorsize and zone
>     size, instead of banning unaligned byte_count.
>   - Add active zone description in the commit log of patch 6.
>   - Add nullb test functions and use them in tests.
> - v2: https://lore.kernel.org/linux-btrfs/20240514182227.1197664-1-naohiro.aota@wdc.com/
>   - fix function declaration on older distro (non-ZONED setup)
>   - fix mkfs test failure
> - v1: https://lore.kernel.org/linux-btrfs/20240514005133.44786-1-naohiro.aota@wdc.com/
> 
> Naohiro Aota (10):
>   btrfs-progs: rename block_count to byte_count
>   btrfs-progs: mkfs: remove duplicated device size check
>   btrfs-progs: mkfs: unify zoned mode minimum size calc into
>     btrfs_min_dev_size()
>   btrfs-progs: mkfs: fix minimum size calculation for zoned mode
>   btrfs-progs: mkfs: align byte_count with sectorsize and zone size
>   btrfs-progs: support byte length for zone resetting
>   btrfs-progs: test: add nullb setup functions
>   btrfs-progs: test: add test for zone resetting
>   btrfs-progs: test: use nullb helper and smaller zone size
>   btrfs-progs: test: use nullb helpers in 031-zoned-bgt

Added to devel, thanks.

One thing that may be worth adding to the documentation is behaviour
regarding the active zones outside of the fs range. The error messages
are clear if this happens, for troubleshooting it may be useful to say
what to do or check if this happens.

