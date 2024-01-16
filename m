Return-Path: <linux-btrfs+bounces-1483-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3522682F3EE
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 19:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00F2D1C2385E
	for <lists+linux-btrfs@lfdr.de>; Tue, 16 Jan 2024 18:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C041CD2B;
	Tue, 16 Jan 2024 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ksPY8QZD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+QcB9Ak";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ksPY8QZD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y+QcB9Ak"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6A01CABF
	for <linux-btrfs@vger.kernel.org>; Tue, 16 Jan 2024 18:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429036; cv=none; b=Fp6rpNNNbfEKhtg55l7RupnTKWJmVrJ8GT9TshUdPkiW91qGoC4qMCKlfCdyeFSCwo7P2etFh5X1jEG4XF0zktfTn0JvbdWoTnFWkWenosWtJ1Gl0XofaZ+C2bpcGwswK3GphQIL755vuRGo8v3yFkk4gt/Tx63q9nX9shXYFdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429036; c=relaxed/simple;
	bh=jjie6v8SMWt8PiNw1uskBcQ+HICAWEzhW8qu/bRMNWw=;
	h=Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:Reply-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent:X-Spamd-Result:
	 X-Rspamd-Server:X-Spam-Score:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Spam-Flag:X-Spamd-Bar; b=qbAPinS42d4ZNABWTxB3qQe1urUVf6vt7hLJ7kxhToX6bxS73mEw2c7WQ7RMBQ8Jn1qqCpdl64WN6hHUHp1cuNAwdZiLpiyf8W4K+wrdPSEr0ofO/FMguu2AROtn4tqIGpYce6bmN5JQPWQCF1DU/Ikhv2dUfi1kXDU2rhY2FQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ksPY8QZD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+QcB9Ak; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ksPY8QZD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y+QcB9Ak; arc=none smtp.client-ip=195.135.223.130
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3951B21FEB;
	Tue, 16 Jan 2024 18:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705429033;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FacUWgeAW1k+EtbMiFZtn9Hh4cY6q20hMRXEGjDK8B8=;
	b=ksPY8QZDAxFRBUkspeUAn9S/8HcQOeViRJfVdS4zr0p4p6mSAyoSWPNX7tD3Mhtc5Ppp6Y
	CJgcJWHCmFQDOgtVkvEqCCmOthrlCdfNbXH66WxTFcQEIfd5LXAhGQr6IrxpHJB3RUyDZP
	QhKDOrwQjHN/rTcQgyhRMkBElf76Qnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705429033;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FacUWgeAW1k+EtbMiFZtn9Hh4cY6q20hMRXEGjDK8B8=;
	b=Y+QcB9AkzfJDpDS0PAups/RlOjqUPRi5x+vx92mZj7Mvdg6naNxQdQk0W82/E1sxwWvBmo
	bjmSO6IV8EFrKVDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705429033;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FacUWgeAW1k+EtbMiFZtn9Hh4cY6q20hMRXEGjDK8B8=;
	b=ksPY8QZDAxFRBUkspeUAn9S/8HcQOeViRJfVdS4zr0p4p6mSAyoSWPNX7tD3Mhtc5Ppp6Y
	CJgcJWHCmFQDOgtVkvEqCCmOthrlCdfNbXH66WxTFcQEIfd5LXAhGQr6IrxpHJB3RUyDZP
	QhKDOrwQjHN/rTcQgyhRMkBElf76Qnc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705429033;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FacUWgeAW1k+EtbMiFZtn9Hh4cY6q20hMRXEGjDK8B8=;
	b=Y+QcB9AkzfJDpDS0PAups/RlOjqUPRi5x+vx92mZj7Mvdg6naNxQdQk0W82/E1sxwWvBmo
	bjmSO6IV8EFrKVDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 18BBE133CF;
	Tue, 16 Jan 2024 18:17:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pQpaBSnIpmUSOAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 16 Jan 2024 18:17:13 +0000
Date: Tue, 16 Jan 2024 19:16:54 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs-progs: make convert to generate chunks aligned
 to stripe boundary
Message-ID: <20240116181654.GA31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705375819.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1705375819.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ksPY8QZD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y+QcB9Ak
X-Spamd-Result: default: False [-0.41 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.40)[77.64%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.41
X-Rspamd-Queue-Id: 3951B21FEB
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Tue, Jan 16, 2024 at 02:01:23PM +1030, Qu Wenruo wrote:
> There is a recent report about scrub use-after-free, which is caused by
> unaligned chunk length (only aligned to sectorsize, but not to
> BTRFS_STRIPE_LEN).
> 
> Although the bug would soon be fixed in kernel, there is no hard to make
> convert to generate data chunks with both start and length aligned to
> BTRFS_STRIPE_LEN.
> 
> Thankfully the start bytenr is already aligned to 64K, we only need to
> make the length aligned.
> 
> Furthermore, allow "btrfs check" to detect such unaligned chunks and
> gives a warning (but not consider it as an error).
> For selftests, we would utilize the debug environment variable,
> BTRFS_PROGS_DEBUG_STRICT_CHUNK_ALIGNMENT, to convert the warning to an
> error.
> 
> Qu Wenruo (3):
>   btrfs-progs: convert: make sure the length of data chunks are also
>     stripe aligned
>   btrfs-progs: add extra chunk alignment checks
>   btrfs-progs: tests: enable strict chunk alignment check

Added to devel, with some minor fixups, thanks. The environment variable
name is long but it's just for us and it's descriptive, so OK.

