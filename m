Return-Path: <linux-btrfs+bounces-6157-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E11EC924583
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 19:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A561C20A70
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 17:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC8D1BF30F;
	Tue,  2 Jul 2024 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xh23G1vX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uzTKJX+L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xh23G1vX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uzTKJX+L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8415218A
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 17:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719940992; cv=none; b=UauSRto1mczq49eGSkJvF7z9+G9H+MTepCIDXsaA+IQlXvwDBaEpeYSUlehCN9+F3icteRFS30hezwT1QH/RxA93JJaQcdmujY6XaUqxu88xvE0gX374AwdCeysL0QQoQohBZyyw/b+hEwZWDod6LnpDzH614Dvxus2AyINyb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719940992; c=relaxed/simple;
	bh=IDt6P6qgAuj5Jk7hNZE78xpiUC5gtmehIIOzkMp3EH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+N73oqQwaFww/juICdveUQN52Mh6zJK44RXCxps3WuJew2BfBMWW769Xp0f2FZUCelI4N7k0Q3mnsmeNCnTJkzaMdoyDefU+ak09wDi3O8StCKO5TVEcElqhnf/4W3IW3WjnODikI3EtP3tXB1agdXUaHVgZmGjY+B2slubPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xh23G1vX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uzTKJX+L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xh23G1vX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uzTKJX+L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 584AF1FBB0;
	Tue,  2 Jul 2024 17:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719940988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wyPXTYMB6sRtG/7TG7UADY7ItV4yNh1/lAjNusWiVW8=;
	b=xh23G1vXmZAx6SlAGfp4BbRmzjvog3Rj4f5Judk4xgqTExV5Sm8t5AFi3ff95k8FTNuzIF
	eMGqhv9vrLi1Uqt9zxZZqCot3fGvyFCPBcMmih1vpJ4GoQhs6zTR+eBPUQbSpm0+mwOr9r
	6RrUy3Qv6Nq0WwKEb2rphoqRX5QB49M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719940988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wyPXTYMB6sRtG/7TG7UADY7ItV4yNh1/lAjNusWiVW8=;
	b=uzTKJX+LNurK8UJ3k8NaZyb5ZRiFd4c1ptsQZ2eV5TYiXRId+yZxG6eFxY/Jl46SPLIe92
	D14eYICDoxxSMgDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719940988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wyPXTYMB6sRtG/7TG7UADY7ItV4yNh1/lAjNusWiVW8=;
	b=xh23G1vXmZAx6SlAGfp4BbRmzjvog3Rj4f5Judk4xgqTExV5Sm8t5AFi3ff95k8FTNuzIF
	eMGqhv9vrLi1Uqt9zxZZqCot3fGvyFCPBcMmih1vpJ4GoQhs6zTR+eBPUQbSpm0+mwOr9r
	6RrUy3Qv6Nq0WwKEb2rphoqRX5QB49M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719940988;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wyPXTYMB6sRtG/7TG7UADY7ItV4yNh1/lAjNusWiVW8=;
	b=uzTKJX+LNurK8UJ3k8NaZyb5ZRiFd4c1ptsQZ2eV5TYiXRId+yZxG6eFxY/Jl46SPLIe92
	D14eYICDoxxSMgDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4870C1395F;
	Tue,  2 Jul 2024 17:23:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uZxrEXw3hGYhSwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jul 2024 17:23:08 +0000
Date: Tue, 2 Jul 2024 19:23:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 0/2] btrfs: fix __folio_put refcount errors
Message-ID: <20240702172307.GN21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1719930430.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1719930430.git.boris@bur.io>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]

On Tue, Jul 02, 2024 at 07:31:12AM -0700, Boris Burkov wrote:
> Switching from __free_page to __folio_put introduced a bug because
> __free_page called put_page_testzero while __folio_put does not. Fix the
> two affected callers by changing to folio_put which does call
> put_folio_testzero.
> --
> Changelog:
> v3:
> - split up patches for backporting
> v2:
> - add second callsite
> 
> Boris Burkov (2):
>   btrfs: fix __folio_put refcount in btrfs_do_encoded_write
>   btrfs: fix __folio_put refcount in __alloc_dummy_extent_buffer

Reviewed-by: David Sterba <dsterba@suse.com>

