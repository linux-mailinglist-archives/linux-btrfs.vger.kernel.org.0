Return-Path: <linux-btrfs+bounces-12436-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFCCA69BC4
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 23:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015F1983C41
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 22:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96A6219A8A;
	Wed, 19 Mar 2025 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pad9zzPJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VtSddqug";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pad9zzPJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VtSddqug"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3EA21579C
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421671; cv=none; b=bgnNODQ4M2vM3kGPdllAr9iQnGZuun9NRkcRWU6nIxlK4Oum/Nua0Nt9nqnTzqhRScqSIq4LlEDGCPKgKLgjLz6eh+TNVaA2eMZbgyQR/wASxLNX/DVeOXdVIvl+gVlPTOoKKQBamI12bK+Sk9j72h9eW36oA6jJYx6sylxWiIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421671; c=relaxed/simple;
	bh=9o/BAwRN1Ll28s9xlNDoBUngeXntIjJsqpyBBe4IOms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvyzNdPQds8UeZbwS+4rbjVWvAGTd2p+lRb9PdhEjlGjiuHiYqA+2V04Zdv/O3t48Zd5Pwmukxz15TpFCmPeQOp4zpnPlZrSWw4geFdAq+b9WAMCK8WDoxB7Z2d2Xj5INSM5E6StMn/f3WKltHxWeP+YhO48A8oj8XI4KjXHgX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pad9zzPJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VtSddqug; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pad9zzPJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VtSddqug; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1F5821DF7;
	Wed, 19 Mar 2025 22:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742421666;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+PWxFq9fyjniu0wGtwejaphpwCziDwjEK2QA60LStI=;
	b=Pad9zzPJEY/GDYUUYelC+gyRPyzJlcpJfS+ZDYpT+SSBehUsB8j2PLyifSRteq9mQtSPJN
	6dvQGc3maCocwRa5JW8o8aUkKX44FommyrAG32TeWMbqmuLnSlb65lhNizxkCH3uyejKQp
	hGtrQS0iyObofVvVBlb9eSuiz3iW2is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742421666;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+PWxFq9fyjniu0wGtwejaphpwCziDwjEK2QA60LStI=;
	b=VtSddqugZydekF3M0J5/pQiMqx3BAr71fOAP97Y1YzFtCR9/R2Njt+P9kJ8ip+KE11rq9w
	L/bPLlsY4BsWRRBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Pad9zzPJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VtSddqug
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742421666;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+PWxFq9fyjniu0wGtwejaphpwCziDwjEK2QA60LStI=;
	b=Pad9zzPJEY/GDYUUYelC+gyRPyzJlcpJfS+ZDYpT+SSBehUsB8j2PLyifSRteq9mQtSPJN
	6dvQGc3maCocwRa5JW8o8aUkKX44FommyrAG32TeWMbqmuLnSlb65lhNizxkCH3uyejKQp
	hGtrQS0iyObofVvVBlb9eSuiz3iW2is=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742421666;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U+PWxFq9fyjniu0wGtwejaphpwCziDwjEK2QA60LStI=;
	b=VtSddqugZydekF3M0J5/pQiMqx3BAr71fOAP97Y1YzFtCR9/R2Njt+P9kJ8ip+KE11rq9w
	L/bPLlsY4BsWRRBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 967F513726;
	Wed, 19 Mar 2025 22:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bzZuJKI+22dkPgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Mar 2025 22:01:06 +0000
Date: Wed, 19 Mar 2025 23:01:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Leo Martins <loemra.dev@gmail.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 1/1] btrfs-progs: add slack space for mkfs --shrink
Message-ID: <20250319220101.GO32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <121133b547f15980bd02280328bb04017c495ec9.1741890798.git.loemra.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <121133b547f15980bd02280328bb04017c495ec9.1741890798.git.loemra.dev@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: B1F5821DF7
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Mar 13, 2025 at 11:35:19AM -0700, Leo Martins wrote:
> This patch adds a flag `--shrink-slack-size SIZE` to the mkfs.btrfs
> allowing users to specify slack when shrinking the filesystem.
> Previously if you wanted to use --shrink and include extra space in the
> filesystem you would need to use btrfs resize, however, this requires
> mounting the filesystem which requires CAP_SYS_ADMIN.
> 
> The new syntax is:
> `mkfs.btrfs --shrink --shrink-slack-size SIZE`
> 
> Where slack size is an argument specifying the desired
> free space to add to a shrunk fs. If not provided, the default
> slack size is 0.
> 
> I have not added any upper bounds checking on SIZE as I'm not sure
> it's necessary.
> 
> The following command will succeed without warning even if `$DEVICE` is
> a block device smaller than 10T. However, mounting `$DEVICE` will fail.
> 
> `mkfs.btrfs -f $DEVICE --root $ROOT --shrink --shrink-slack-size 10T`
> 
> I don't know if this would be considered incorrect because $DEVICE could
> also be a regular file that can ftruncate up to the appropriate size.
> Should I add a warning message, or leave it to mount time to indicate
> that something is wrong?

A warning is probably a good idea, it does not need to be a fatal error
as any slack value will work on file images and shrinking is maybe not
that useful on fixed size block devices.

