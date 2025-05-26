Return-Path: <linux-btrfs+bounces-14238-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C6BAC3C76
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 11:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607041746FC
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 May 2025 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326721EB5E5;
	Mon, 26 May 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2lhuXCmG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5zJa6A5d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2lhuXCmG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5zJa6A5d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEAC5FEE6
	for <linux-btrfs@vger.kernel.org>; Mon, 26 May 2025 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748250881; cv=none; b=Lc+e0c5VPom1G/P2//2Hb43S0WAM1aMwGihQYgyYZQM54TWk/BqL8lKekWhp6VBG+4khgnBD0clcRPczl2ILu7hBAW/fie6ag9YRRKKgAT/fYQggmVOvrBeRK9h1VsR/BhQ8TjQVsVdFFEfcCGs2iF1wJyy18Oo/4rsMflymCxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748250881; c=relaxed/simple;
	bh=dDzfTvVGjO9MCRfTsqPL0bDnLIktuLMm31/WxXrjYU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ThQilii/uI0pz2EL0JejaFCUcXysBKhhwp/AH3LQlhfMUV306QkR47d3K3WNI7dS5pXA6nZz8FXdR1YxNk23Soihpd8+bpeHZgjq0VTjrxi+JuUEPJZSqa23IJS2bVCQtY8emmAKv+EHNw0ttmXG/Wj+tbb/+83AHUkrlRqsCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2lhuXCmG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5zJa6A5d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2lhuXCmG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5zJa6A5d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C55AF1F7B2;
	Mon, 26 May 2025 09:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748250877;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvbVO0NnUlToilSRp7ZX8+s9JGS6rd9YcaaSxCVVegI=;
	b=2lhuXCmGJOn4l52eV/b0L7LTi8zGJL1XiOagGnL+STfIUV8vvR00krbdG2tiFDLilDQlT/
	/yoqv5DpoAy6chrsRasE3QTLxJNf0KKNhMGJS0TyEDtk49hPYv/70+olvrQyrFQoQQp5vh
	fKTtKn3SsJK2G3IVb16GaUgQwlRGOhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748250877;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvbVO0NnUlToilSRp7ZX8+s9JGS6rd9YcaaSxCVVegI=;
	b=5zJa6A5dsPSJEEeOE9YcDJoksAfN2YwyrjJXUWAFr8sGo0KP1cfOgZ+w5kH0Bu5xP+CYpq
	zlEyvTboCsIG0YAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748250877;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvbVO0NnUlToilSRp7ZX8+s9JGS6rd9YcaaSxCVVegI=;
	b=2lhuXCmGJOn4l52eV/b0L7LTi8zGJL1XiOagGnL+STfIUV8vvR00krbdG2tiFDLilDQlT/
	/yoqv5DpoAy6chrsRasE3QTLxJNf0KKNhMGJS0TyEDtk49hPYv/70+olvrQyrFQoQQp5vh
	fKTtKn3SsJK2G3IVb16GaUgQwlRGOhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748250877;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zvbVO0NnUlToilSRp7ZX8+s9JGS6rd9YcaaSxCVVegI=;
	b=5zJa6A5dsPSJEEeOE9YcDJoksAfN2YwyrjJXUWAFr8sGo0KP1cfOgZ+w5kH0Bu5xP+CYpq
	zlEyvTboCsIG0YAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AECCF1397F;
	Mon, 26 May 2025 09:14:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d7t2Kv0wNGjRWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 26 May 2025 09:14:37 +0000
Date: Mon, 26 May 2025 11:14:28 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Kyoji Ogasawara <sawara04.o@gmail.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>, clm@fb.com,
	josef@toxicpanda.com, dsterba@suse.com, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: Raise nobarrier log level to warn
Message-ID: <20250526091428.GA4037@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250521032713.7552-1-sawara04.o@gmail.com>
 <20250521032713.7552-2-sawara04.o@gmail.com>
 <68a7d14b-913b-48e0-be12-5bba0d17ea2b@gmx.com>
 <CAKNDObChsMqFAYK-QT8DmFEitFX+Pmi7ifGDbYe2GfnPnUr1FQ@mail.gmail.com>
 <af00227c-c301-4311-b570-47f4d404c499@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af00227c-c301-4311-b570-47f4d404c499@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.50
X-Spamd-Result: default: False [0.50 / 50.00];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,gmx.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]

On Sat, May 24, 2025 at 01:18:58PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/5/24 11:51, Kyoji Ogasawara 写道:
> > Thanks for the explanation. I understand the issue with btrfs_parse_param()
> > being triggered multiple times.
> > 
> > If I move the log into btrfs_parse_param(), it would currently use
> > btrfs_info_if_set(),
> > resulting in an info level log.
> > 
> > Is an info level acceptable for this warning, or would you prefer a
> > warn level log?
> 
> I think info level is good enough.
> 
> As the main purpose of that message line is still just to show we're 
> using barrier or not, the extra "use with care" is just something good 
> to have.
> 
> Thus no need to go warning IMHO.

Agreed, info level is the right one. Warn messages are for user/admin
attention and some action may be needed. If somebody intentionally sets
the slightly dangerous options then info is to log that and "you get
what you ask for".

