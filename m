Return-Path: <linux-btrfs+bounces-1970-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080E884475A
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 19:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2DE3B2A21B
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 18:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75D01B268;
	Wed, 31 Jan 2024 18:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DG2/VeyA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AiR+4xK3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DG2/VeyA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AiR+4xK3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F82421350;
	Wed, 31 Jan 2024 18:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706726398; cv=none; b=gRD5g6etfskbRSsLMDfgm9x8iwTtfk9FJ4c7ay11EJu/3vnDoocmAPuYpfwqzhSipVjSnZYU3WyV89VIB9WDQKit08JBkZuRf/nU1OLKtrjEUg9OQwBxpwL+wK9Y6aCB1QOcrEBtUzX4wGf7fSuY1Aadsf2OJ1cVvMLAP3ecowg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706726398; c=relaxed/simple;
	bh=tR8S8BLovbyfqsOoLX2hLNVX7oCfCDqBCgKdYRUlmf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1yuDFkeQNzeyrE98btIDEH3UaxPIO5EvtJoPvsaa4ciXs+7oG+XaKRH82+INAwuttY/ijmLf5+Jzt9OOp3iTi+/bFBa8vfwUG/mtLEpM4ERl9w2UVN8PB4ytVZaFCjJazNA/xt7wePsYj/Ld5dqPSVI+yryLaVJoLtkJcAM4j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DG2/VeyA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AiR+4xK3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DG2/VeyA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AiR+4xK3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 409E821FA3;
	Wed, 31 Jan 2024 18:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706726395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIJOU6HTcBgHwBjBP3C0pRJdbDLmrIMs9Rbh8CmtGic=;
	b=DG2/VeyAAcCfMq33Cwc4sPaqaFaj3bxe+q3svt0FDo2BweW2lUOpHQRjzZMW+jmpAMM+t5
	hqyZ0fLl6vPVtFZJS18HVaxpuSxqkX/ZTMFqrUawSDI0IjtMV8Npq7Ce0uQ8YMfH4UZvm4
	jDWz6Itrb9/Z/Xuoa208dZbZentHERQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706726395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIJOU6HTcBgHwBjBP3C0pRJdbDLmrIMs9Rbh8CmtGic=;
	b=AiR+4xK3q2NAipZRYTNkkHSKy/cebNSoOtZU/+TakkgtdCdWjfO0LAPChSCj/Ws5XxCT+P
	sGKlSFzMunGYV1BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706726395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIJOU6HTcBgHwBjBP3C0pRJdbDLmrIMs9Rbh8CmtGic=;
	b=DG2/VeyAAcCfMq33Cwc4sPaqaFaj3bxe+q3svt0FDo2BweW2lUOpHQRjzZMW+jmpAMM+t5
	hqyZ0fLl6vPVtFZJS18HVaxpuSxqkX/ZTMFqrUawSDI0IjtMV8Npq7Ce0uQ8YMfH4UZvm4
	jDWz6Itrb9/Z/Xuoa208dZbZentHERQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706726395;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HIJOU6HTcBgHwBjBP3C0pRJdbDLmrIMs9Rbh8CmtGic=;
	b=AiR+4xK3q2NAipZRYTNkkHSKy/cebNSoOtZU/+TakkgtdCdWjfO0LAPChSCj/Ws5XxCT+P
	sGKlSFzMunGYV1BA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 30A98139D9;
	Wed, 31 Jan 2024 18:39:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id H3S8C/uTumVQKQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 18:39:55 +0000
Date: Wed, 31 Jan 2024 19:39:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Kunwu Chan <chentao@kylinos.cn>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"dsterba@suse.com" <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Simplify the allocation of slab caches in
 btrfs_delayed_inode_init
Message-ID: <20240131183929.GP31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240131061924.130083-1-chentao@kylinos.cn>
 <a31f7d10-3c07-44e3-ac28-f5d05507af50@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a31f7d10-3c07-44e3-ac28-f5d05507af50@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="DG2/VeyA";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AiR+4xK3
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.23 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[51.62%]
X-Spam-Score: -1.23
X-Rspamd-Queue-Id: 409E821FA3
X-Spam-Flag: NO

On Wed, Jan 31, 2024 at 10:20:35AM +0000, Johannes Thumshirn wrote:
> On 31.01.24 07:20, Kunwu Chan wrote:
> > commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
> > introduces a new macro.
> > Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
> 
> That commit is 17 years old. Why should we switch to it _now_? I 
> wouldn't call it a new macro.

I had the same reaction after checking the commit that added it.
> 
> Don't get me wrong, I don't oppose the patch, but I'd prefer a better 
> explanation why now and not 17 years ago when the macro got introduced.

We can add the macros where possible, at least it hides all the 0 or
NULL parameters, but yeah with a better changelog.

