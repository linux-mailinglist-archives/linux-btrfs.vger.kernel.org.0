Return-Path: <linux-btrfs+bounces-7567-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF859612F9
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 17:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780AA2816DF
	for <lists+linux-btrfs@lfdr.de>; Tue, 27 Aug 2024 15:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9941C7B61;
	Tue, 27 Aug 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFKwpdiw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h5+Lg4D2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aFKwpdiw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="h5+Lg4D2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289B19EEA2;
	Tue, 27 Aug 2024 15:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773069; cv=none; b=ljKjHQkGuu4uBoIaD0XI8hW5tyRuvj2YN7XrpPmqt4xmACJ4EZ4kaEO2sIduEOJLQ45hVPfB/5PunPy5GxQtFn+gxfurrod9va4EHp8tWt6iBTnFZJuaiUtlQDSiqhdY9rxn9Hvx+Tw/m3oxnauH+XthrW+ptPkSArPxVSQ6jH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773069; c=relaxed/simple;
	bh=ZVsyH+5BlaRKkuNNP3WObwiO6VxPzbzhqUi0aY/uRw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjX9QWrPeYruiFfAvlrJ9d7RFM119RW0nJCrSthtfHpbzpLxnyCM596psGA7SyB7U2KGiQ69Ij3Shfy/fx4ksazUunrLY94jLiV8//rDI7uyBRC2xO4VULaJPDkLncfuF0ZvxD/vvQrltvjEgOXjSitkP5nzQdeFpN3wndsn4YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFKwpdiw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h5+Lg4D2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aFKwpdiw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=h5+Lg4D2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B350B21AA6;
	Tue, 27 Aug 2024 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724773065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcCsuhIw7zwSosdhpQoFiQdYj2NYeJCTsIAoNY2Bd9E=;
	b=aFKwpdiwqCVvAFOwwmCQy5yCoPpzPJBJJZgVJzCr3CF9lHnOe53jKQuMYV3rg4n5SKy1Wd
	rd4QQWsCMeFznhDJ+KIARPwVUXFOXGbSKlm7EXKTkYTYXrPHd35hQsjXXoVfB00HRJ14N6
	aGd9K20fo84aMr/ew85gIte3qyXhxbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724773065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcCsuhIw7zwSosdhpQoFiQdYj2NYeJCTsIAoNY2Bd9E=;
	b=h5+Lg4D2PDf6XkoGom3NyBxfJmo49e/lVNL/yPLY0Act1IArjGY4dNXfy9DwEkl6MYGvfg
	JJ3IW8skZoCDAyDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724773065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcCsuhIw7zwSosdhpQoFiQdYj2NYeJCTsIAoNY2Bd9E=;
	b=aFKwpdiwqCVvAFOwwmCQy5yCoPpzPJBJJZgVJzCr3CF9lHnOe53jKQuMYV3rg4n5SKy1Wd
	rd4QQWsCMeFznhDJ+KIARPwVUXFOXGbSKlm7EXKTkYTYXrPHd35hQsjXXoVfB00HRJ14N6
	aGd9K20fo84aMr/ew85gIte3qyXhxbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724773065;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BcCsuhIw7zwSosdhpQoFiQdYj2NYeJCTsIAoNY2Bd9E=;
	b=h5+Lg4D2PDf6XkoGom3NyBxfJmo49e/lVNL/yPLY0Act1IArjGY4dNXfy9DwEkl6MYGvfg
	JJ3IW8skZoCDAyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95A4A13A44;
	Tue, 27 Aug 2024 15:37:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tecqJMnyzWZMKAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 27 Aug 2024 15:37:45 +0000
Date: Tue, 27 Aug 2024 17:37:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Li Zetao <lizetao1@huawei.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] btrfs: Fix reversed condition in
 copy_inline_to_page()
Message-ID: <20240827153739.GY25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <3a05145b-6c24-4101-948e-1a457b92ea3e@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a05145b-6c24-4101-948e-1a457b92ea3e@stanley.mountain>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.994];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Aug 27, 2024 at 01:21:08PM +0300, Dan Carpenter wrote:
> This if statement is reversed leading to locking issues.
> 
> Fixes: 8e603cfe05f0 ("btrfs: convert copy_inline_to_page() to use folio")

This is from series that appeared in linux-next for a short time and has
been removed due to problems, one if which might be the one you report.
Thanks.

