Return-Path: <linux-btrfs+bounces-5370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECDB8D5174
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 19:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551DE1C2347A
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 May 2024 17:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557CC47A40;
	Thu, 30 May 2024 17:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ELs1h3I+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yf1T6KIY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q+UC1+hF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GZw9v6+J"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A1187570
	for <linux-btrfs@vger.kernel.org>; Thu, 30 May 2024 17:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717091190; cv=none; b=tkj21zrZWFsdWKg9rlmYLwYg5/oPCS0IeiOHDAEpPFOnaQbnvmvIyQWtw77ZNCmsPVXFRH5Va7EwrBOe2hi1rRTim01IJ4lOgH4j2PWLvma8zpgQj2q+hiqEmt/n1+OQ8d73VrjhLoiHC7DyHHp3A1MoJvzCLt7gZ5ENcL6h9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717091190; c=relaxed/simple;
	bh=q2gjMzgeQWqYwc7+qmiCW5dpQnGxqoDY5SI4Rs5z0dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CGFAvwd/OfWjGCnDGKoYBpXKpI8kstI0pXocpAdzce7Wm3M0WiEa9+ObGCIwFOclQiaUdnjJGWBtiTNFt/X1BP8Mncq+azlK4pNUul5eBABR7dtSSx4V48Ha3ePlu13PCwPkoC8wtW1lQgNXdmccNjQI0Tc1gUA+iPFcQ+Apzyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ELs1h3I+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yf1T6KIY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q+UC1+hF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GZw9v6+J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED67F1F766;
	Thu, 30 May 2024 17:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717091187;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6RyWB2Vs3vYJJ9Q3KmaFUlr81LoZF1FO6Fi8S7Nvbzg=;
	b=ELs1h3I+Q4zKuTdEVLumZ8SPrJ1j/TZyZyuZA+NkSeQ3orSN5kzPYPTaIx5IRmXVkwoT9K
	h4dNJHHUbXiJrIds8Vu3AiDDYZt/ZplOZuozWmOjfqsmeC/aReOcfZCqKLS5jsl7SVGSJ5
	r7M2Dk9Abh5VgddevzKqIhKAXeq/IgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717091187;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6RyWB2Vs3vYJJ9Q3KmaFUlr81LoZF1FO6Fi8S7Nvbzg=;
	b=yf1T6KIY/ZaDltrByvK2zY3rcxdG0POn4xVqncQwv0IFlXivi6hPQtyAUl32PSUgCklmlu
	8KaEyDyyO1C5LvBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q+UC1+hF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GZw9v6+J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717091186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6RyWB2Vs3vYJJ9Q3KmaFUlr81LoZF1FO6Fi8S7Nvbzg=;
	b=q+UC1+hFYZ3G1m8hYtD1TFNUFh6UD80KuD7i71np81rlMXRLbW0LzqIgJFq1Trvm9C1EaZ
	33ym/plni2nzlM+Ta4r4BtiidS+9KSy0BIBckAuycDkl5OHj2B+a7XAz2aH6JEUC4txgHt
	1epaL2OPd0f5TNc67QgGQWEktQntMZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717091186;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6RyWB2Vs3vYJJ9Q3KmaFUlr81LoZF1FO6Fi8S7Nvbzg=;
	b=GZw9v6+JBGXEafHj3BAeCKDvH1+fEsXc9BxnkI8eE5pJ3DJvP8gX0/+xJ9F3o6p3ecKYnV
	tqH49UiCqojNVMBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3CE813A6C;
	Thu, 30 May 2024 17:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U3WRM3K7WGZuIQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 30 May 2024 17:46:26 +0000
Date: Thu, 30 May 2024 19:46:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Srivathsa Dara <srivathsa.d.dara@oracle.com>
Cc: linux-btrfs@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
	junxiao.bi@oracle.com, clm@fb.com, josef@toxicpanda.com,
	dsterba@suse.com
Subject: Re: [RESEND PATCH] btrfs-progs: convert: Add 64 bit block numbers
 support
Message-ID: <20240530174625.GD25460@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530053754.4115449-1-srivathsa.d.dara@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: ED67F1F766
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,rasivara-arm2:email,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu, May 30, 2024 at 05:37:54AM +0000, Srivathsa Dara wrote:
> In ext4, number of blocks can be greater than 2^32. Therefore, if
> btrfs-convert is used on filesystems greater than or equal to 16TiB
> (Staring from 16TiB, number of blocks overflow 32 bits), it fails to
> convert.
> 
> Example:
> 
> Here, /dev/sdc1 is 16TiB partition intitialized with an ext4 filesystem.
> 
> [root@rasivara-arm2 opc]# btrfs-convert -d -p /dev/sdc1
> btrfs-convert from btrfs-progs v5.15.1
> 
> convert/main.c:1164: do_convert: Assertion `cctx.total_bytes != 0` failed, value 0
> btrfs-convert(+0xfd04)[0xaaaaba44fd04]
> btrfs-convert(main+0x258)[0xaaaaba44d278]
> /lib64/libc.so.6(__libc_start_main+0xdc)[0xffffb962777c]
> btrfs-convert(+0xd4fc)[0xaaaaba44d4fc]
> Aborted (core dumped)
> 
> Fix it by considering 64 bit block numbers.
> 
> Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>

The current conver tests passed, can you please also send test case for
this fix? Thanks.

