Return-Path: <linux-btrfs+bounces-17466-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 708F8BBECE0
	for <lists+linux-btrfs@lfdr.de>; Mon, 06 Oct 2025 19:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3B1B3BEE2C
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Oct 2025 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3227243946;
	Mon,  6 Oct 2025 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ILJtI9wu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k01sfhYm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MqRDCRKl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="m4nf8Jbf"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7048233722
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Oct 2025 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759771433; cv=none; b=m/hrf+4/lFJHVQg7Fia++Zo7B6rsNM38BsjGex9xmq1qsCzqcP091PNYuuO7mHXn8OIkoX+WKFiklwcOxm9SgdA9nrJy7Wsv/KAQtQlvjRIgIycg/r0wl5hU9jD0J4w6JlQ1hSii7Oq6YyYKp6wvEKSSkcXxYMjMgiZ2yGWXmZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759771433; c=relaxed/simple;
	bh=ZeaGMx8w4FiIQan7pESD85thqMtxADdk5RzhM3lspTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDqoUd+kUurWazBrufrJaRyKBNsMyIfdRuNYQ6xXUkDbcMekiK0xtpCiK4iTxBdzqdsChJCDiEy+0OE7L0uj9YTuUQ7PF0t9Rij5/RM8TpcGuMxqfvig/9f+O/vZY5aThuZfbBsIN7SIQiXH5eqWMal6pkSD5IO6abcrAuTGuRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ILJtI9wu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k01sfhYm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MqRDCRKl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=m4nf8Jbf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E043F336C4;
	Mon,  6 Oct 2025 17:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759771428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHx8s6doP1vCz5xGqfXMd/mLDJcI1MG6Od/8Lre67DM=;
	b=ILJtI9wu6PdBZlYT7v16iaDUVK+5zwZ6+3/Ye57b2A1QpZk906PzR1t1EO9zdLBZ0jek3n
	h5y1Xf0Ph85YMK2qSkSAMIBXTm2uBe34NPtYMmGayl0dOCLcWFwPSR6dBk0OAQ4TRoXFxQ
	UssiAMzG2Zf3Cw/twULXpVHgi8nnEiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759771428;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHx8s6doP1vCz5xGqfXMd/mLDJcI1MG6Od/8Lre67DM=;
	b=k01sfhYmoVSERyxiV8cIfo4I5SdQXCfY+RhQMvvZvCjlxQSEmI71Qucw3I8aeDXoaA/QIM
	0/1CB9aaG/a5VyCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MqRDCRKl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=m4nf8Jbf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759771427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHx8s6doP1vCz5xGqfXMd/mLDJcI1MG6Od/8Lre67DM=;
	b=MqRDCRKlmkSUKj53DXzmSt5X9qnPsOjm6kGJLWsvq4FxSfln81EGHBpNXtB7rkNzokp5kI
	ZLBnqbWB5asKXWc/bN5FJAlqVgbSbHSoCuY6siXUiNlJvuanlGvs2KVzxGJLfGLlR5WOR3
	30BMuJfwMGNXw8YHfLsGalCjcETd2Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759771427;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KHx8s6doP1vCz5xGqfXMd/mLDJcI1MG6Od/8Lre67DM=;
	b=m4nf8Jbf2EAojKHVUsMi61tIE98fRXNQNw3DHaujSSU9UGrfiP4kC1xb/iJHoDdn4b8GJK
	+u0GZVHAe7hburDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C676C13995;
	Mon,  6 Oct 2025 17:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l9g/MCP742jKTgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Oct 2025 17:23:47 +0000
Date: Mon, 6 Oct 2025 19:23:38 +0200
From: David Sterba <dsterba@suse.cz>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] btrfs: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <20251006172338.GB4412@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <aN_Zeo7JH9nogwwq@kspp>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN_Zeo7JH9nogwwq@kspp>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: E043F336C4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Fri, Oct 03, 2025 at 03:11:06PM +0100, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Move the conflicting declaration to the end of the corresponding
> structure. Notice that `struct fs_path` is a flexible structure,
> this is a structure that contains a flexible-array member (`char
> inline_buf[];` in this case).
> 
> Fix the following warning:
> 
> fs/btrfs/send.c:181:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Added to for-next, with updated changelog. Thanks.

