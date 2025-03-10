Return-Path: <linux-btrfs+bounces-12153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F80A5A3D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 20:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E7B43A5538
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Mar 2025 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA18231A3F;
	Mon, 10 Mar 2025 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c4KLgNlS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TUoypBIG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="euFXl8jG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bm/RZffC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE541CAA60
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Mar 2025 19:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635243; cv=none; b=YCQpwAHD8y+6oXv/6DAJgw8fyXkBe/7grWMBGIa+O3B9wMtkqNNm+EBgsEZIRnepgaWUjGRTCyXUeYsEqdQ0hRG2o+jQYMNNJku9HKlJ/hdG6jvvoDexjO+dm46VTegb9kTPfibDzA4AZbEAFSTcaNsuGDpO88bd1ndFacvqrqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635243; c=relaxed/simple;
	bh=CmBRflEd7/ENAGhb0Vxfil+4HL0DzklB53VFy3yL4/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J40MvmrHo+lH+NeOq8ij7kRZoBRYQAQbsV0nm97/+BNWqnCMUcJDzbvwP/kzH7ghjL61ckul8pNdwL5V1Syw9zqKsfRktbzT1js3UJ0Rshyg8N1KCjOMeVsAIMesIyjKYgzAr2oaGClwVw5qYuZLDrY0tk9lLyvGrLxfi6GBHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c4KLgNlS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TUoypBIG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=euFXl8jG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bm/RZffC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CBF1D1F387;
	Mon, 10 Mar 2025 19:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741635240;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVdVwiAU7INJHZH3388wA3BkDfb5Xq5w5qAiG843RnQ=;
	b=c4KLgNlS5qsa+KygaOBoGRIBVo+bCJ6AyI+oWQTLn99cqYLmFTLTyBVzBepm8iIMzf8eH9
	jh+xSIjYkvc3ZKl9lA3fyNm+VvZ5NrmzzPv02NfLcImF3H3pX3g/wQnIUNLQL4yiEKoxbM
	7bryR23Kl6B9n2/fxRkzG2/LL1Ie3sU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741635240;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVdVwiAU7INJHZH3388wA3BkDfb5Xq5w5qAiG843RnQ=;
	b=TUoypBIGJJzaJpf3oU05/cpEEW8KBFMN3iGLqf8ftQU6obVOtkN29Xx5ahEwG66lwIg+0Y
	dvBAFT2JqreZr8Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=euFXl8jG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="bm/RZffC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741635239;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVdVwiAU7INJHZH3388wA3BkDfb5Xq5w5qAiG843RnQ=;
	b=euFXl8jG7pFZ6L88Ho/708BCWGpIposy60vTDzIlLbVqTQnosJtCv/kNZaKVvjgQH5Jajr
	Ihs8OsSZpbBdYJ/AUsb4+rGhD58UQCpED2bUAkKM3DBgqqaoDRFAzVMqQJBc3zdiScDtt/
	NWhmukahh5LlE1r4w9hiBm72gntsgmg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741635239;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PVdVwiAU7INJHZH3388wA3BkDfb5Xq5w5qAiG843RnQ=;
	b=bm/RZffCJAWKa+qH3mfFKxJhtYHnoXQyTv9OkyvGjdhxjeZER2aYX/WzKkSDLp6Jm+Xo/p
	aXACb4msyQZaGEBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B272E1399F;
	Mon, 10 Mar 2025 19:33:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dDZQK6c+z2cFFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 10 Mar 2025 19:33:59 +0000
Date: Mon, 10 Mar 2025 20:33:58 +0100
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: random code cleanup
Message-ID: <20250310193358.GB32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250309075820.30999-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250309075820.30999-1-sunk67188@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: CBF1D1F387
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Sun, Mar 09, 2025 at 03:57:58PM +0800, Sun YangKai wrote:
> These patches are not intented to change any behavior of current code.
> Just trying to make the codes easier to read, and, maybe, perform better.
> I'm working on btrfs_search_forward(), trying to improve it and fix some
> misbehaviors. And I'll send some patches that will change the behavior of
> the code later.
> 
> I'm new to the maillist, trying to read the implements, and improve it from
> my perspective.
> If you have any feedback or questions, please let me know :)
> 
> Sun YangKai (3):
>   btrfs: improve readability in search_ioctl()
>   btrfs: remove unnecessary 'found_key' local variable in
>     btrfs_search_forward()
>   btrfs: avoid redundant slot assignment in btrfs_search_forward()

The cleanups look good to me, thanks. There are so minor style issues,
commented under the patches.

