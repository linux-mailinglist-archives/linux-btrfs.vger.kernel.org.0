Return-Path: <linux-btrfs+bounces-13486-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1391AA0388
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 08:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED0648276F
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 06:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7551D274FEC;
	Tue, 29 Apr 2025 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExOyA1XS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJPaCBWm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ExOyA1XS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJPaCBWm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7A274FE4
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 06:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745908686; cv=none; b=n/Wbd+/++nrX1DWeCgHzyakeT//qLCyXEcwlF4PSe+zrEHd9ro9np0hJMrKGW1nOpAxaAx6PrZp6Kdxaz1qf7Z+5XcGHiUbMv73tbYEAIh9KnLvsyJf29AccCBfHCaakQfD31LQDwl+UePYC1KodwOY/7XbwgNl1ZJTpbuZGtuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745908686; c=relaxed/simple;
	bh=8eas/4/AnYGINUxqMFFXYPgxi4CkzW0giq7AvI1HQ1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UR3ecqXAl6oWIB7+IyRJ+x3+4O8WFtowuFixRoTxs2Eu2h8T/6Qpm20004wAx4uOWBCENEA3oh7clti2Kv/PnotzBsANxIX+pziMSzpOR9nIKAe29d0o0UVOiDLmjgLn1bkcRBisnaKc+XCDl7BuV/CwRkvan8IiXxRSVWaAXRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExOyA1XS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJPaCBWm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ExOyA1XS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJPaCBWm; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 285D11FB5A;
	Tue, 29 Apr 2025 06:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745908682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkaaCo63sFcXfE3cMCVUk6B4ngYZXwCftcAwG1Ak+5g=;
	b=ExOyA1XSB6o9VSFoDQ99X20fq4CUf7kfwLb7vM12d3cz1b41vNMN1A7/tTOomM6S8JdWJP
	NIamUdaIACyndErk/NLzfnA/t5CItkn8wR/Xe0/H2VDyKSNKYarc/4kiVWXKQitYyq2dY/
	MNclgUW/AvnItu1IkZGNAAh2bA2yGks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745908682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkaaCo63sFcXfE3cMCVUk6B4ngYZXwCftcAwG1Ak+5g=;
	b=AJPaCBWmw0E+YCrKSg5Pvm6z23qKoQ5rSI/UmHIxu3EdWWpAPXeZSGL2JjvNGThHh02Z49
	Aps6+njkpZxuO1Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745908682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkaaCo63sFcXfE3cMCVUk6B4ngYZXwCftcAwG1Ak+5g=;
	b=ExOyA1XSB6o9VSFoDQ99X20fq4CUf7kfwLb7vM12d3cz1b41vNMN1A7/tTOomM6S8JdWJP
	NIamUdaIACyndErk/NLzfnA/t5CItkn8wR/Xe0/H2VDyKSNKYarc/4kiVWXKQitYyq2dY/
	MNclgUW/AvnItu1IkZGNAAh2bA2yGks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745908682;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TkaaCo63sFcXfE3cMCVUk6B4ngYZXwCftcAwG1Ak+5g=;
	b=AJPaCBWmw0E+YCrKSg5Pvm6z23qKoQ5rSI/UmHIxu3EdWWpAPXeZSGL2JjvNGThHh02Z49
	Aps6+njkpZxuO1Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12E3C13931;
	Tue, 29 Apr 2025 06:38:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VSVlBMpzEGh0YgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Apr 2025 06:38:02 +0000
Date: Tue, 29 Apr 2025 08:38:00 +0200
From: David Sterba <dsterba@suse.cz>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] btrfs: Fix use of GCC_VERSION in messages.h
Message-ID: <20250429063800.GA18094@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250428-btrfs-fix-messages-h-clang-v1-1-5ede51586a9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428-btrfs-fix-messages-h-clang-v1-1-5ede51586a9c@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Apr 28, 2025 at 03:01:35PM -0700, Nathan Chancellor wrote:
> Clang warns (or errors with CONFIG_WERROR=y):
> 
>   fs/btrfs/messages.h:188:5: error: 'GCC_VERSION' is not defined, evaluates to 0 [-Werror,-Wundef]
>     188 | #if GCC_VERSION >= 80000
>         |     ^
> 
> GCC_VERSION is defined in compiler-gcc.h, which is not included when
> building with clang. Use the always defined Kconfig symbol,
> CONFIG_GCC_VERSION, to do the comparison.
> 
> Additionally, as a comment above this #ifdef notes, clang supports
> __VA_OPT__, which is really what is needed for this block to function.
> Include a check for CONFIG_CC_IS_CLANG as well, since clang 13 is the
> minimum supported version for building the kernel.
> 
> Fixes: 14d740332aa0 ("btrfs: enhance ASSERT() to take optional format string")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks, back then I verified that the minimum clang version required for
kernel compiles the code and using just GCC_VERSION looked correct from
other code but apparently not. Folded to the patch, thanks.

