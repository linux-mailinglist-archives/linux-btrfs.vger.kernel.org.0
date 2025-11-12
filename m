Return-Path: <linux-btrfs+bounces-18894-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B4EC534E8
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 17:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7F89425EFB
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Nov 2025 15:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA2134DCFE;
	Wed, 12 Nov 2025 15:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aCHyYKpX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AWGTXV2Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aCHyYKpX";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AWGTXV2Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489AD34DB6E
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Nov 2025 15:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959652; cv=none; b=eetD+KYZrzwjwNTMA13CY2ATQWUZu01dMyI5h6Na2S7FxBz5d6qEtpWT/FGlg9Zq5YHY2J9VKC4y2Sv4mVIiN+2VhUcjRGpz91dHcAdRGBXEFTRhKVxBKdPeDfpmlbF9ed/vA832jtnzSgotJoMd85Wdp2GxoLrgk/Nobm6lCJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959652; c=relaxed/simple;
	bh=oBoSgACI7kTzgiuZOUfcC6peC/h5ao6YI9QMAgFa9DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+6aOJtzBFfCdS2jd9iNCSjVAoL1zuqi+Z+50QaRxvc9H/GwBQM2DUr499KdvWL6I4CXbM68H4c8Jjs8eKG2/byMTgitCPmr+S9t8oXeUACpR1DbHM3wrjdGDnN+nL6QPSXwjHG/G3NtjYWfJn+MNCD7uMVafh31LnHh7+mozTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aCHyYKpX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AWGTXV2Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aCHyYKpX; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AWGTXV2Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CC1421B87;
	Wed, 12 Nov 2025 15:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762959649;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YEWWuljiywKEZRIvKQV0IXO50ZG7wkcxh+Bh9p3dtU=;
	b=aCHyYKpXw5v+GMQTQYGsQhs9LcgEBlVVqiKFo7Xit4Q8ifOGJ9UpbD0wwUwRYz55cPnDoU
	LhuqB0RTJpB5vamtExFloc0OgWiSchkCnKwPay8aLLMQT/wWTmFjGF5gr94mjq0n6w6Tuw
	v9LeKDbr+GjmWQ5L0KmV9iK1OooLxQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762959649;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YEWWuljiywKEZRIvKQV0IXO50ZG7wkcxh+Bh9p3dtU=;
	b=AWGTXV2ZzolscRjbvujzBa4ibaB3yxTPvVuAlK/UIARF9x7fublOqOYzVGSdljVowdTns8
	X+hdLcARLgpNxjBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762959649;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YEWWuljiywKEZRIvKQV0IXO50ZG7wkcxh+Bh9p3dtU=;
	b=aCHyYKpXw5v+GMQTQYGsQhs9LcgEBlVVqiKFo7Xit4Q8ifOGJ9UpbD0wwUwRYz55cPnDoU
	LhuqB0RTJpB5vamtExFloc0OgWiSchkCnKwPay8aLLMQT/wWTmFjGF5gr94mjq0n6w6Tuw
	v9LeKDbr+GjmWQ5L0KmV9iK1OooLxQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762959649;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+YEWWuljiywKEZRIvKQV0IXO50ZG7wkcxh+Bh9p3dtU=;
	b=AWGTXV2ZzolscRjbvujzBa4ibaB3yxTPvVuAlK/UIARF9x7fublOqOYzVGSdljVowdTns8
	X+hdLcARLgpNxjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 160CC3EA61;
	Wed, 12 Nov 2025 15:00:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ww83BSGhFGmLUgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Nov 2025 15:00:49 +0000
Date: Wed, 12 Nov 2025 16:00:32 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] fstests: add kernel commit IDs to some tests that miss it
Message-ID: <20251112150032.GE13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <e167d491435cbb02c671c974d7a2f80613f1c487.1762952458.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e167d491435cbb02c671c974d7a2f80613f1c487.1762952458.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Wed, Nov 12, 2025 at 01:01:51PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Kernel patches for some tests are now in Linus' tree, so update their
> commit IDs and for btrfs/301 fix the commit subject since it was changed
> before being sent to Linus.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

