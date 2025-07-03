Return-Path: <linux-btrfs+bounces-15224-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0F2AF7B09
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71EFC1CA6B67
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Jul 2025 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A842F0032;
	Thu,  3 Jul 2025 15:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t3aB0RNQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4r8JsJti";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t3aB0RNQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4r8JsJti"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D607B2F0C40
	for <linux-btrfs@vger.kernel.org>; Thu,  3 Jul 2025 15:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555555; cv=none; b=ea7k/hy6E/aJW4miR5NOKDCLVKlJ3An+66K1sIpgcXFmAH2EhjR5OH4KB2igNnBIR8fIVld1jDhtLJ4rn1oG1Tqp1swW97F8Ft9p+QatbwTiFQD0y3sNr0kJaHFN/D/rIatVriq4YapUTnutM44eAdtejzVL5z70HUesdOU2Sjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555555; c=relaxed/simple;
	bh=qe1JM/9Edxr517BEh9k1qGxj4Z6LKzeE0S/ti1xkI9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrvuE5cMXcHMF+G+Il80XriEBucFRxcLa3dUdBPciVZUV/0KY2BostA6xF7FepkzV5QDzn2RlCZ9xAFS8FcO07/5+iz5t012QGrzsNXfNIplTLGbosBzkuJP682mQHa2r8EcKhazLoOw6Sr5ZGkWPhPs7N1ZyP/PMcCrMoaafzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t3aB0RNQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4r8JsJti; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t3aB0RNQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4r8JsJti; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2CC4A1F387;
	Thu,  3 Jul 2025 15:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751555552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlEXwrb7QIoZVzgJfIWUuvjzMFc9SONyRlwFyYMxNUs=;
	b=t3aB0RNQhtEzflNi71/qB5mzvvPShp5ybcO+aVcXRXyI+L5YfZ+koXlDow25etVBgP8aIi
	//c/RjUrsbQHGtQNchVuIPrraPposumEfvsMWLO8tQL1G/rhulFlmFA1V2bKA3GKWeUyQE
	BtIKyjDmMkwmQp/xA4X0xhXpw9sxiKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751555552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlEXwrb7QIoZVzgJfIWUuvjzMFc9SONyRlwFyYMxNUs=;
	b=4r8JsJtiCrCHxjfKDlDa27Ag+Kok5NOfv4rGc8Qdy853A5E8EmzT/jMvtuN5+3p8OqkHvA
	FjTckPJfYHYpysAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751555552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlEXwrb7QIoZVzgJfIWUuvjzMFc9SONyRlwFyYMxNUs=;
	b=t3aB0RNQhtEzflNi71/qB5mzvvPShp5ybcO+aVcXRXyI+L5YfZ+koXlDow25etVBgP8aIi
	//c/RjUrsbQHGtQNchVuIPrraPposumEfvsMWLO8tQL1G/rhulFlmFA1V2bKA3GKWeUyQE
	BtIKyjDmMkwmQp/xA4X0xhXpw9sxiKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751555552;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TlEXwrb7QIoZVzgJfIWUuvjzMFc9SONyRlwFyYMxNUs=;
	b=4r8JsJtiCrCHxjfKDlDa27Ag+Kok5NOfv4rGc8Qdy853A5E8EmzT/jMvtuN5+3p8OqkHvA
	FjTckPJfYHYpysAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 10E4C13721;
	Thu,  3 Jul 2025 15:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dX3kA+CdZmhdcgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 03 Jul 2025 15:12:32 +0000
Date: Thu, 3 Jul 2025 17:12:26 +0200
From: David Sterba <dsterba@suse.cz>
To: Brahmajit Das <listout@listout.xyz>
Cc: Nathan Chancellor <nathan@kernel.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	clm@fb.com, josef@toxicpanda.com, dsterba@suse.com, kees@kernel.org,
	ailiop@suse.com, mark@harmstone.com, Brahmajit Das <bdas@suse.de>
Subject: Re: [PATCH v4] btrfs: replace deprecated strcpy with strscpy
Message-ID: <20250703151226.GW31241@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250620164957.14922-1-listout@listout.xyz>
 <20250702182712.GA3453770@ax162>
 <25hcimtuueppt4w3ccvid3d7c3eots7nat4qspdr6t6minxfa2@zb4fmwz7qsyp>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25hcimtuueppt4w3ccvid3d7c3eots7nat4qspdr6t6minxfa2@zb4fmwz7qsyp>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Thu, Jul 03, 2025 at 06:08:24AM +0530, Brahmajit Das wrote:
> On 02.07.2025 11:27, Nathan Chancellor wrote:
> > Hi Brahmajit,
> > 
> > On Fri, Jun 20, 2025 at 10:19:57PM +0530, Brahmajit Das wrote:
> ...
> > 
> > This change is now in -next as commit d282edfe8850 ("btrfs: replace
> > strcpy() with strscpy()"), where this hunk appears to causes a slew of
> > warnings on my arm64 systems along the lines of:
> > 
> ...
> > 
> > It looks like the offset_in_page(buf) part of the WARN() in
> > sysfs_emit() gets triggered with this, presumably because kmalloc()
> > returns something that is not page aligned like sysfs_emit() requires?
>
> Nathan, can you help me with providing a bit more info to debug this. I
> set up qemu aarch64 env with btrfs but couldn't reproduce this issue by
> boot test. Basically trying to understand what workflow triggered this.
> 
> You can find my kernel config, dmesg log and boot logs here:
> https://gist.github.com/listout/de8b6efa6ddb02805b5886f35c3f73d4

sysfs_emit() is wrapper for scnprintf with implicit buffer length, so
we can use that instead. I'll fix it in for-next.

