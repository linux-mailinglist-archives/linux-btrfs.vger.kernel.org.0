Return-Path: <linux-btrfs+bounces-2089-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BEA84891B
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 23:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7EE51F23040
	for <lists+linux-btrfs@lfdr.de>; Sat,  3 Feb 2024 22:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AB0168AC;
	Sat,  3 Feb 2024 22:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bv92g1/O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L+2AG0Mt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kPYg5OXt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5BCr2q2S"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEBF13AE8
	for <linux-btrfs@vger.kernel.org>; Sat,  3 Feb 2024 22:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706998578; cv=none; b=Uq5vNu0qTTZvnFi0MNuuSQKdSF275XrdpfSMffioJpzzGcwtKYLyOYUnRe/Ev71AKY07jQIr0RTSZqluEd81EZK/Yel6LFVwl57EJ50IBxJW0gZ8ITq1NfRKrKAFiThBPaeIQ2Lpxxd3DqVWPVqGtUL2jLTKFXmIUhr38oOIAVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706998578; c=relaxed/simple;
	bh=kjTz3YYzcFXNbgteChdLv57OwQgdV4LTMfF4f0BmwJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+VpOgcsRFB0YE5VRlNNMa5YGUYCFu3oqJa5WssV1yDEwMb5PkGIwlklVxeVA/NAsrIpbjQv1ZJiAj9osz1jp1WpVEw01ASwFlAiFVVehuOuTY3jxKGkwli+fUj46D+1xQnLmLs7zY0YB9H8WSxH9IlKHXd+xyXG+Pm1Jj0ocSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bv92g1/O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L+2AG0Mt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kPYg5OXt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5BCr2q2S; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E4F7921E85;
	Sat,  3 Feb 2024 22:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706998573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IYLk5VnyLfm0QDNarQZzoKrKQw44nuDbOIB19huO3A=;
	b=bv92g1/OuGr2NnK9lyzK2qQoCPNvuBMw0ar8xZJ8+Ov32KSAaMbAJSZJwO8Xk7JQSHsGPE
	9BitwSiQRV4dl6TNS0hKHE61pqjTvE+vHXnProR5OwG/eAxiS4g/JjyOb2tT3V16+sRZtP
	7YixtDa0NgdUkScyRmQZBVKA3jbh310=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706998573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IYLk5VnyLfm0QDNarQZzoKrKQw44nuDbOIB19huO3A=;
	b=L+2AG0Mt9cg+NgEAF4b+GA8C6S+JnlNMc3ntVVHxcYgobY7y/Ok3Q13sxGxcXkOJaR7f25
	+GoTOrmt9aVVdUBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706998572;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IYLk5VnyLfm0QDNarQZzoKrKQw44nuDbOIB19huO3A=;
	b=kPYg5OXtpds+maz4AWaG/TQvmwUEDlCV7FqJ9IRqPh0MUnOkrL2QP8BwrsmghB6VzuO3pW
	ZXMYcoRIQPrZK5Mi7JQCWMKRg3DgcSmmJJPSre5NABCACzryZ+SbrJLbqUIG9joQCT+U7l
	YmK94myN6A9U3Msfuy/yfApfXugjjOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706998572;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/IYLk5VnyLfm0QDNarQZzoKrKQw44nuDbOIB19huO3A=;
	b=5BCr2q2S1bvvx3nZdk98lIGmG30VaE6eYbjCe9MAygKvVNbjrboMVyGhruCRCPhwQkQZzv
	hUXu2xqsbkUONgCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C23FD137FD;
	Sat,  3 Feb 2024 22:16:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NTI4Lyy7vmUeDAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 03 Feb 2024 22:16:12 +0000
Date: Sat, 3 Feb 2024 23:15:45 +0100
From: David Sterba <dsterba@suse.cz>
To: =?utf-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Message-ID: <20240203221545.GB355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kPYg5OXt;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5BCr2q2S
X-Spamd-Result: default: False [-3.60 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 DWL_DNSWL_HI(-3.50)[suse.cz:dkim];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.09)[64.60%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E4F7921E85
X-Spam-Level: 
X-Spam-Score: -3.60
X-Spam-Flag: NO

On Sat, Feb 03, 2024 at 06:18:09PM +0800, 韩于惟 wrote:
> When mkfs, I intentionally used "-s 4k" for better compatibility.
> And /sys/fs/btrfs/features/supported_sectorsizes is 4096 16384, which 
> should be ok.
> 
> btrfs-progs is 6.6.2-1, is this related?

No, this is something in kernel. You could test if same page and sector
size works, ie. mkfs.btrfs --sectorsize 16k. This avoids using the
subpage layer that transalates the 4k sectors <-> 16k pages. This has
the known interoperability issues with different page and sector sizes
but if it does not affect you, you can use it.

