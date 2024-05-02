Return-Path: <linux-btrfs+bounces-4675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3285F8B9D17
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 17:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC01A2849D3
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 May 2024 15:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E8A159912;
	Thu,  2 May 2024 15:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XpumiAGT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukilrJ5L";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XpumiAGT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukilrJ5L"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8001586D5
	for <linux-btrfs@vger.kernel.org>; Thu,  2 May 2024 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662736; cv=none; b=uSuHXpDT0eHrdXKqCLMPTzTj59exyMdOJZBn9qmxlHHgY6SNRXWRPQ+nQ94IEQU3RcOtqvXuhoi7HCjSy3fBMoBrl3MPL3j8PJFHgjK1+qcH9a/b7SJSgEy3EQBPayVKJQqbaZTPQchpzvpdFD4yrkjyFDUPaQ6nrgjfMXEKUe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662736; c=relaxed/simple;
	bh=lVFnNENre1wqS/KsU2EQ5umjsRmnJah5Non3JNRlaKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C0K+8Zm9Tjqq2LPdKAH09H/1yxLEviFy2syIDtZGmsQQ8W/sNsLjIw9bUxeGG4JS96VfetYLrF/RhVjdIMI6oV9hWOfwROHNiXGuVeuj3+JubQUUH7DMefq7lpNa5PgV3F1VOIY9KyhNggvnYSH89pdfHUnFle4s9ShnMzTzciE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XpumiAGT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukilrJ5L; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XpumiAGT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukilrJ5L; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9886B371F3;
	Thu,  2 May 2024 15:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714662733;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wd6orolLMFBFkkneiFsVBHslRimch5YwiwfEYq+CWrY=;
	b=XpumiAGTaUeB7+E9wwLY9zu6G5wKU0RTHu+pKJU8meacfgEY6NkS+l4tIUqkgzt+9wl9rd
	lRboXJFCGwyPLvqUxIHoIgiTcwdbUMJulTjOF+DBqc3s9z0+DM4VaQySJcXJ+0XWYAzkV4
	fb8r7R6q58RiPweh0eMXJ/tIsNluoLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714662733;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wd6orolLMFBFkkneiFsVBHslRimch5YwiwfEYq+CWrY=;
	b=ukilrJ5LKOGlz3vUT1uKM+RYK3Oof6T5IwLQqFht/Gi3z7FQEbF+V2iptpMe6UHKbv+2Vt
	lbnRPp9NchN/EuDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XpumiAGT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ukilrJ5L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714662733;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wd6orolLMFBFkkneiFsVBHslRimch5YwiwfEYq+CWrY=;
	b=XpumiAGTaUeB7+E9wwLY9zu6G5wKU0RTHu+pKJU8meacfgEY6NkS+l4tIUqkgzt+9wl9rd
	lRboXJFCGwyPLvqUxIHoIgiTcwdbUMJulTjOF+DBqc3s9z0+DM4VaQySJcXJ+0XWYAzkV4
	fb8r7R6q58RiPweh0eMXJ/tIsNluoLA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714662733;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wd6orolLMFBFkkneiFsVBHslRimch5YwiwfEYq+CWrY=;
	b=ukilrJ5LKOGlz3vUT1uKM+RYK3Oof6T5IwLQqFht/Gi3z7FQEbF+V2iptpMe6UHKbv+2Vt
	lbnRPp9NchN/EuDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88A521386E;
	Thu,  2 May 2024 15:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aWYzIU2tM2b3cgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 May 2024 15:12:13 +0000
Date: Thu, 2 May 2024 17:04:58 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove the recursive include of btrfs_inode.h
 from itself
Message-ID: <20240502150457.GT2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6165f2c27b4d02fa4f94d8373cd3506e3028fc71.1714105096.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6165f2c27b4d02fa4f94d8373cd3506e3028fc71.1714105096.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.17 / 50.00];
	BAYES_HAM(-2.96)[99.83%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9886B371F3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.17

On Fri, Apr 26, 2024 at 01:48:27PM +0930, Qu Wenruo wrote:
> Inside btrfs_inode.h we include itself, although it's not causing any
> problem, it's still being reported by clangd, and is really unnecessary.
> 
> Just remove the recursive include.

For obvious changes like that you don't need to explain it that much.

> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

