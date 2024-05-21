Return-Path: <linux-btrfs+bounces-5157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B08CAF25
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 15:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70D991C2186E
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748D97711F;
	Tue, 21 May 2024 13:13:59 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE8757F7;
	Tue, 21 May 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716297239; cv=none; b=s5LN9qIxgW8e0sMXJWj8LWRIf1aA2kR2+iasWhYo/FznXo3yMR/s79HZGUAaZEFprrFsxyS91G5A9QuVJzqjBAXua/bG2cS55sjMh30ZTi4RW8w/HBvLzquuuOlWclD1156RKPzH0Xa15dbkMIkfFYlwZixxZfTpAdNKVBFyDdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716297239; c=relaxed/simple;
	bh=JbVX9rvaZard9FXijYblm8fThdLKSRqFG03mzpe8IwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtNQAb7DiyxCxfLAcpX04akTwsNIlHSTNBtDqBYgB1z5M/BBXrE1/tMeJpXIb8ztHEOHutAfVMNGCgUiGcSRqfpogBfTasLlljw9sTGXzHTJigqsrYb4ljisrlqOCOgFu5i4YUwVXJLXQpGxyDcC5by47xgz3csptYlZrGGHOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7F73221F50;
	Tue, 21 May 2024 13:13:55 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64F1213A1E;
	Tue, 21 May 2024 13:13:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sT96GBOeTGayGQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 13:13:55 +0000
Date: Tue, 21 May 2024 15:13:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	Lennart Poettering <lennart@poettering.net>,
	Jiri Slaby <jslaby@suse.com>, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: re-introduce 'norecovery' mount option
Message-ID: <20240521131350.GL17126@twin.jikos.cz>
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
X-Rspamd-Queue-Id: 7F73221F50

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

Reviewed-by: David Sterba <dsterba@suse.com>

