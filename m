Return-Path: <linux-btrfs+bounces-5167-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF788CB11F
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 17:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22159281DA9
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 15:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627C0433A0;
	Tue, 21 May 2024 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pGuPl6u4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="asCLQvQT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pGuPl6u4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="asCLQvQT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98371FDD
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716304889; cv=none; b=PDphqtKR3sLACexrz1KDVd0nHdWca7GkRY86F65R6rXS8g8aTQRsxp9WevS//y17dfoEPT/ngMzasQV/Nc2npOvKZ3nX9ju1o9VwJqgK7XKMXDbP6Gv+StoQPbCSJzg5BYisshhLAAFamL9Jw+5dsUKtwC18LLnqcTIFnb3Xm84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716304889; c=relaxed/simple;
	bh=27L5fM7i1fMCr1OM63XZWSk3azATJmYaxayjuCmhb8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1yPTtnc2AjEF5A13xesdm9goG9E0atMev5gJNq70edxrjPTY2NUsyFrABvsOS+h1YuvNmSUjZQfAtdI+/F7w1H4Y6tojFjbgLkrVzCtH4WQ7pHlEatqf6mDxTsSw+6Zifmf47Bq2SZCmKU4K7niicoCQCRlu2bUCl/jFx5QhPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pGuPl6u4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=asCLQvQT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pGuPl6u4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=asCLQvQT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 22A5434810;
	Tue, 21 May 2024 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716304886;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBxZBat0GBUhR5vNh0iy9M7EWNxY35wKmrB0pLpAvtY=;
	b=pGuPl6u43x3Itf1pmoYjF17v9cIYRVCgcSVk1k5ASVryycNM8/XntevQeMCSAaMjNG0x0F
	LmrHbHMGVGarG9B+2cyl7ZSdeeiPzozoDgiKCdDVI3qzP1glwr9ZODFv7dLbdMMohmusup
	Dw/HSr3tWqGbXyY3la+kKn26qjxV6ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716304886;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBxZBat0GBUhR5vNh0iy9M7EWNxY35wKmrB0pLpAvtY=;
	b=asCLQvQT3V6lTXrOWNnj5N+YfftCfpkt7NzQMrkQOHPCpHxUd5XMHqKRXLcwHKpmRlWldP
	I5PXQnl73I0bKQDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716304886;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBxZBat0GBUhR5vNh0iy9M7EWNxY35wKmrB0pLpAvtY=;
	b=pGuPl6u43x3Itf1pmoYjF17v9cIYRVCgcSVk1k5ASVryycNM8/XntevQeMCSAaMjNG0x0F
	LmrHbHMGVGarG9B+2cyl7ZSdeeiPzozoDgiKCdDVI3qzP1glwr9ZODFv7dLbdMMohmusup
	Dw/HSr3tWqGbXyY3la+kKn26qjxV6ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716304886;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hBxZBat0GBUhR5vNh0iy9M7EWNxY35wKmrB0pLpAvtY=;
	b=asCLQvQT3V6lTXrOWNnj5N+YfftCfpkt7NzQMrkQOHPCpHxUd5XMHqKRXLcwHKpmRlWldP
	I5PXQnl73I0bKQDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C47013685;
	Tue, 21 May 2024 15:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wsi5Ava7TGbGAwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 21 May 2024 15:21:26 +0000
Date: Tue, 21 May 2024 17:21:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v3 0/6] part3 trivial adjustments for return variable
 coding style
Message-ID: <20240521152120.GQ17126@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1715783315.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1715783315.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, May 16, 2024 at 07:12:09PM +0800, Anand Jain wrote:
> This is part 3 of the series, containing renaming with optimization of the
> return variable.
> 
> Some of the patches are new it wasn't part of v1 or v2. The new patches follow
> verb-first format for titles. Older patches not renamed for backward reference.
> 
> Patchset passed tests -g quick without regressions, sending them first.
> 
> Patch 3/6 and 4/6 can be merged; they are separated for easier diff.

Splitting the patches like might seem strange but reviewing the changes
individually is indeed a bit easier so you can keep it like that.

> v2 part2:
>   https://lore.kernel.org/linux-btrfs/cover.1713370756.git.anand.jain@oracle.com/
> v1:
>   https://lore.kernel.org/linux-btrfs/cover.1710857863.git.anand.jain@oracle.com/
> 
> Anand Jain (6):
>   btrfs: btrfs_cleanup_fs_roots handle ret variable
>   btrfs: simplify ret in btrfs_recover_relocation
>   btrfs: rename ret in btrfs_recover_relocation
>   btrfs: rename err in btrfs_recover_relocation
>   btrfs: btrfs_drop_snapshot optimize return variable
>   btrfs: rename and optimize return variable in btrfs_find_orphan_roots

I've edited the subject lines from the previous series, please have a
look and copy the subjects when the kind of change is the same in the
patch. Also use the () when a function si mentioned in the subject.
Thanks.

