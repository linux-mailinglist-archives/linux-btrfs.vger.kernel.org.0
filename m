Return-Path: <linux-btrfs+bounces-15015-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472D0AEAC3D
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 03:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E8B87B4A98
	for <lists+linux-btrfs@lfdr.de>; Fri, 27 Jun 2025 01:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D90978F2E;
	Fri, 27 Jun 2025 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3R5/5bX4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VALD8VoM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3R5/5bX4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VALD8VoM"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA8C144304
	for <linux-btrfs@vger.kernel.org>; Fri, 27 Jun 2025 01:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750986563; cv=none; b=oOiYJ0hSZ/J6r7OxWjsfoDgWYrlMrbSQCeSRXtTV5H3Uc04RIacV2j6VZ0IYqvWQizm7QSfN4rg+xFJoNaFB0t27UV/4IxG2yqqxzm85JneoTI1JWAxD4qqMQeit1Ke6DDX9fo9UQAUqFUBfhzqzgQOBdrKlDWO9lkdzo2vl05A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750986563; c=relaxed/simple;
	bh=PaibdnqxVHchma1AzJ+6ohxMq8Rwm5bRKgztAwwY5SU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lSUf2T7I3/rni65U7yWodhUEDhjwvMs1JkCfhMFE2BBN6xq2qyXzW8rAzn/qNHdA0uHAgsvhSVO6IbsBuDj6azJusUlIopo+cuZEnAN78HiC/aq9r+nOXjddQY75NtK7K0FMls+l6lARNTUtGCMX9irzhqxeEWBJcJXeIX4kXdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3R5/5bX4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VALD8VoM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3R5/5bX4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VALD8VoM; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 01FA61F387;
	Fri, 27 Jun 2025 01:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750986560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PaibdnqxVHchma1AzJ+6ohxMq8Rwm5bRKgztAwwY5SU=;
	b=3R5/5bX4AE9M56qawskei2RR13h/hEnuReOOj1Zr1BSbpkKiuCYb2KUZMpNgBALBAaWrVu
	U4jlJ+hqVZfMdFdxO2RmKPoyovn42uBwl/JgxnPaQVq/3a2vsK747j8KyQfz0D77unU0AJ
	BnXKdfLXAjc0GRwDsriGVGnXF8dv4lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750986560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PaibdnqxVHchma1AzJ+6ohxMq8Rwm5bRKgztAwwY5SU=;
	b=VALD8VoMbvgjVjtuy5K8lSsve+F3zWra3/kGYBlVwcMC1mH8xGghzD/OwJ0/YZXvN7SUsn
	yjhaQaXV3BjsX1CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1750986560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PaibdnqxVHchma1AzJ+6ohxMq8Rwm5bRKgztAwwY5SU=;
	b=3R5/5bX4AE9M56qawskei2RR13h/hEnuReOOj1Zr1BSbpkKiuCYb2KUZMpNgBALBAaWrVu
	U4jlJ+hqVZfMdFdxO2RmKPoyovn42uBwl/JgxnPaQVq/3a2vsK747j8KyQfz0D77unU0AJ
	BnXKdfLXAjc0GRwDsriGVGnXF8dv4lA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1750986560;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PaibdnqxVHchma1AzJ+6ohxMq8Rwm5bRKgztAwwY5SU=;
	b=VALD8VoMbvgjVjtuy5K8lSsve+F3zWra3/kGYBlVwcMC1mH8xGghzD/OwJ0/YZXvN7SUsn
	yjhaQaXV3BjsX1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0ED8138A7;
	Fri, 27 Jun 2025 01:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pXLIMj/vXWhaZgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 27 Jun 2025 01:09:19 +0000
Date: Fri, 27 Jun 2025 03:09:18 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org,
	syzbot+772bdfe41846e057fa83@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix a use-after-free race if btrfs_open_devices()
 failed
Message-ID: <20250627010918.GD31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1c173aadfc405763e3920e4d87c56992cae9e278.1750983699.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c173aadfc405763e3920e4d87c56992cae9e278.1750983699.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[772bdfe41846e057fa83];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri, Jun 27, 2025 at 09:52:58AM +0930, Qu Wenruo wrote:
> [BUG]
> With the latest v5 version patchset "btrfs: use fs_holder_ops for btrfs"
> merged into linux-next, syzbot reported an use-after-free:
...
> This will be folded into the patch "btrfs: delay btrfs_open_devices()
> until super block is created".

Thanks, patch added to linux-next branch on top of the series for
clarity, for the next iteration it can be folded.

