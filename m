Return-Path: <linux-btrfs+bounces-5159-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 238228CAF62
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 15:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFDA01F23578
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 13:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6912E7D071;
	Tue, 21 May 2024 13:27:00 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749F7BB1A;
	Tue, 21 May 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298019; cv=none; b=Y/NrTLjiHoq6z2R+pB/1Y+WrfHx4aivUBTlzoHpPTe7B3g5opEnANc2VqDokNmGBwOtASdDD1puAXXsBUy53oCOqh/CPAU+sStrCRhGKJacr5Smvt6GQbGR95NrCSj1uH1r+ArfMH2tWE1FMWq0LNiKtZmoSSM7zQwZ3V7/ELW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298019; c=relaxed/simple;
	bh=5oa0JOPy+KGqTRzr7eK2HDhGt88cPAmHg6F36ABZMck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=etuoYnK6TC07UCePJgZvmnwiCLDoKY/Kpu5CPKz4BcAkYgShXcyardwXyLIXq2IU3K2tvQFFn7KQ9JBUwUOFGgWW13kH0kjHK4iiCqTykoTfYib/4Pir50Ig8mWqfewsxzz3GmRYL8Jr6EjN4dQ+uv6fzyuIwptIvgxI/Dzgnsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 98A375C19C;
	Tue, 21 May 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71C1913685;
	Tue, 21 May 2024 13:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MOTyGiChTGZwDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 13:26:56 +0000
Date: Tue, 21 May 2024 15:26:55 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>,
	Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: re-introduce 'norecovery' mount option
Message-ID: <20240521132655.GM17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <44c367eab0f3fbac9567f40da7b274f2125346f3.1716285322.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44c367eab0f3fbac9567f40da7b274f2125346f3.1716285322.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 98A375C19C

On Tue, May 21, 2024 at 07:27:31PM +0930, Qu Wenruo wrote:
> Although 'norecovery' mount option is marked deprecated for a long time
> and a warning message is introduced during the deprecation window, it's
> still actively utilized by several projects that need a safely way to
> mount a btrfs without any writes.
> 
> Furthermore this 'norecovery' mount option is supported by most major
> filesystems, which makes it harder to validate our motivation.
> 
> This patch would re-introduce the 'norecovery' mount option, and output
> a message to recommend 'rescue=nologreplay' option.
> 
> Link: https://lore.kernel.org/linux-btrfs/ZkxZT0J-z0GYvfy8@gardel-login/#t
> Link: https://github.com/systemd/systemd/pull/32892
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1222429
> Reported-by: Lennart Poettering <lennart@poettering.net>
> Reported-by: Jiri Slaby <jslaby@suse.com>
> Fixes: a1912f712188 ("btrfs: remove code for inode_cache and recovery mount options")
> Cc: stable@vger.kernel.org # 6.8+
> Signed-off-by: Qu Wenruo <wqu@suse.com>

I'll add it to for-next myself, there are a few more fixes that I
plan to send during merge window so this patch can be picked to stable
next week.

