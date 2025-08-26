Return-Path: <linux-btrfs+bounces-16422-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE27B370C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 18:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3865C1619F6
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Aug 2025 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFE32D641A;
	Tue, 26 Aug 2025 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QqIAF69D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iv0WVkh8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QqIAF69D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iv0WVkh8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D9B2D5C92
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Aug 2025 16:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756227384; cv=none; b=Dn6xzIvHoGYjRbTsgjFusMe/v1NjJYWBityIqgAL8zrPBk+HW7Jl1eyGjCoLZh8a0BXch/KpHf1Ky29g1uwVcspyffgTMYMfgMfCZPF8v/9rjfI2UWAxaDYqjUc/LfguwdqEVPFkXs7RFIrpY3Ff3J7GjUg88KII21smDCL+O0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756227384; c=relaxed/simple;
	bh=j07oEU1Q18QMeDsOw7YGhgaN/Uijeh7VWpUfaQDX34c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLDrRRAoJXjSKl/GMcKCzi6XrvXfZG+WN05ifJEoy4E17Kz2mh56gWzGsetfYA7E8/QzbfCnZnkvh9253K05I/oBCl5PGSpHGydHpFfLJ3Lqv4inA+2vWKGABUds+i6Zfb7Xi8d3YOe9OUk3cYMM9clRhkx/VYXiRpSlOloVstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QqIAF69D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iv0WVkh8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QqIAF69D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iv0WVkh8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 67D311F78D;
	Tue, 26 Aug 2025 16:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756227380;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ynlTDJkeJP/TOaGt3T7xc/yX6oA6n0j1vtTUtbvFAso=;
	b=QqIAF69DzSJn7PAzDyRJ5PklOTOUA+yZT2+uYvaR7qbU0uYz8Fb4sb+vrPgOqAvGYPLTED
	FHOlXoBbDLrCKXizuy4J7pss7OJ/XavlmRDoQIYBt6smEUx5FE3LCWiuSU/hg2cTC9lv3O
	zAzf0xp80Ctg9620S51gE3RDJ+iWcjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756227380;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ynlTDJkeJP/TOaGt3T7xc/yX6oA6n0j1vtTUtbvFAso=;
	b=iv0WVkh8g58Dtpx+76Ac5zMc73umlDdBxnSVHzx+uRXwZGRRf82xlBggR+VzYm3Yt1HZ6K
	zVAf4arfmQd4JeBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756227380;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ynlTDJkeJP/TOaGt3T7xc/yX6oA6n0j1vtTUtbvFAso=;
	b=QqIAF69DzSJn7PAzDyRJ5PklOTOUA+yZT2+uYvaR7qbU0uYz8Fb4sb+vrPgOqAvGYPLTED
	FHOlXoBbDLrCKXizuy4J7pss7OJ/XavlmRDoQIYBt6smEUx5FE3LCWiuSU/hg2cTC9lv3O
	zAzf0xp80Ctg9620S51gE3RDJ+iWcjI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756227380;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ynlTDJkeJP/TOaGt3T7xc/yX6oA6n0j1vtTUtbvFAso=;
	b=iv0WVkh8g58Dtpx+76Ac5zMc73umlDdBxnSVHzx+uRXwZGRRf82xlBggR+VzYm3Yt1HZ6K
	zVAf4arfmQd4JeBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D22113A31;
	Tue, 26 Aug 2025 16:56:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m7YNEjTnrWgOeQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 26 Aug 2025 16:56:20 +0000
Date: Tue, 26 Aug 2025 18:56:19 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs: more trivial BTRFS_PATH_AUTO_FREE conversions
Message-ID: <20250826165619.GC29826@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250822130123.GV22430@twin.jikos.cz>
 <13839041.dW097sEU6C@saltykitkat>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13839041.dW097sEU6C@saltykitkat>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Fri, Aug 22, 2025 at 11:51:18PM +0800, Sun YangKai wrote:
> > Please split the patch to parts that have the described trivial changes,
> > and then one patch per function in case it's not trivial and needs some
> > adjustments.
> 
> After learning more about the auto-free/cleanup mechanism, I realized that its 
> only advantage is to eliminate the need for the goto out; pattern. Therefore, 
> it seems unnecessary to apply this conversion in non-trivial cases.

I wouldn't say it's the only advantage, the code readability is also
improved. The path is an auxiliary object and if the freeing is handled
automatically then it reduces the cognitive load and the error cleanup
paths.

> Moreover, if the cleanup code contains other logic, it might be better to 
> leave it unchanged even in trivial cases.

Depends on what we want. So far we've started with the path auto
cleaning but there are more possibilities like using the raw __free
cleanup with kfree. If this is combined and leads to simpler exit and
cleanup blocks I think it's worth. In the trivial cases it's clear it
does not interfere with the rest of the code and does not complicate any
logic there.

> > The freeing followed by other code can be still converted to auto
> > cleaning but there must be an explicit path = NULL after the free.
> 
> I'm sorry, I didn't understand. If the freeing is followed by other code, 
> maybe we could just leave them untouched?

Maybe yes, this is up to consideration on a per site basis, I've seen
examples where conversion to auto path cleaning would not hurt.

Let me know if you want to continue with this because I think you don't
seem to see the value in the conversions (which is fine of course).

