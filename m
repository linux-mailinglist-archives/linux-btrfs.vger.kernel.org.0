Return-Path: <linux-btrfs+bounces-4782-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0ED68BD406
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 19:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 808211F22EBE
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 May 2024 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27C0197;
	Mon,  6 May 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hM9Ug9rK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HMILEJsY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hM9Ug9rK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HMILEJsY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0F815749A;
	Mon,  6 May 2024 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715017545; cv=none; b=hoWrSsAq/UkYx6A6p/pZ/OXJvX5xUWVBCDHE6HPHQ68B4JzyQC3QMbs8CjrX+5tlCfDx5XYh8kLYu9NwKuEr4D7R3fovtuEFE27ttJwKk1D4q8J0A8izRtB4UkCA6DHuMS5hyzXPohBZlO4pAfDLh+SfBnetTLbePwX30I9/Gdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715017545; c=relaxed/simple;
	bh=SnuVaKANezsK89xhLaJCVZPrBbMHyA1Px7Ry2U4l1t8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dt1mfcM944rRPyoW74bBq1aZVc3slSlBxY1wrCQ7x8wEgIXFUk6+azrBZkcTx94RKFxGwgJmK0zyNgpVJTB/U8sN+CbROrwLmMYgs90J4bmf94Ac/PN/RUMivKfJLMe2nIxZDP7NB3ytM/hVlg0x8iu5zq8XTfwMGde933/Be/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hM9Ug9rK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HMILEJsY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hM9Ug9rK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HMILEJsY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 874172197F;
	Mon,  6 May 2024 17:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715017542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=poHDJP5x9pFXKSGFxv6b+OoTvegRQpkqsTgZ4FwrCws=;
	b=hM9Ug9rKRsgNpYl++rSDDkd+Grp9WSTCevgoNZGR7+6H0MADW5ZcEylme6CgFuuFoGqmzr
	7ucZTjP4BTs0WIbMSFxm12cigm16aD8wCLSBgjor90gG9qxJrhTng28rUhJdB/GuUL7JnQ
	9Xec4kZ49hiDqnaYYhqYERd3taq96es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715017542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=poHDJP5x9pFXKSGFxv6b+OoTvegRQpkqsTgZ4FwrCws=;
	b=HMILEJsY4oEupbOF+SEgaWaJF+Qazyypsvqo1cgrKzHAarNlrSDGrZetTb8zL/GloYCmuL
	Uo94IpaLa3HZsGBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hM9Ug9rK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HMILEJsY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715017542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=poHDJP5x9pFXKSGFxv6b+OoTvegRQpkqsTgZ4FwrCws=;
	b=hM9Ug9rKRsgNpYl++rSDDkd+Grp9WSTCevgoNZGR7+6H0MADW5ZcEylme6CgFuuFoGqmzr
	7ucZTjP4BTs0WIbMSFxm12cigm16aD8wCLSBgjor90gG9qxJrhTng28rUhJdB/GuUL7JnQ
	9Xec4kZ49hiDqnaYYhqYERd3taq96es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715017542;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=poHDJP5x9pFXKSGFxv6b+OoTvegRQpkqsTgZ4FwrCws=;
	b=HMILEJsY4oEupbOF+SEgaWaJF+Qazyypsvqo1cgrKzHAarNlrSDGrZetTb8zL/GloYCmuL
	Uo94IpaLa3HZsGBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B17313A25;
	Mon,  6 May 2024 17:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nL2sFUYXOWZsNAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 May 2024 17:45:42 +0000
Date: Mon, 6 May 2024 19:38:24 +0200
From: David Sterba <dsterba@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Boris Burkov <boris@bur.io>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix array index in qgroup_auto_inherit()
Message-ID: <20240506173824.GG13977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <a90a6d6b-64c7-4340-9b3d-7735d7f56037@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90a6d6b-64c7-4340-9b3d-7735d7f56037@moroto.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -3.95
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 874172197F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.95 / 50.00];
	BAYES_HAM(-2.74)[98.88%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Sat, May 04, 2024 at 02:38:41PM +0300, Dan Carpenter wrote:
> The "i++" was accidentally left out so it just sets qgids[0] over and
> over.
> 
> Fixes: 5343cd9364ea ("btrfs: qgroup: simple quota auto hierarchy for nested subvolumes")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> >From static analysis.  Untested.

A real bug, thanks. Patch added to for-next.

