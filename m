Return-Path: <linux-btrfs+bounces-14287-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2915AAC7484
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 May 2025 01:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802F73A6022
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 May 2025 23:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F2D23506C;
	Wed, 28 May 2025 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vGxOCBMC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g7ss9x1k";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vGxOCBMC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g7ss9x1k"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABA9235059
	for <linux-btrfs@vger.kernel.org>; Wed, 28 May 2025 23:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748474933; cv=none; b=DBxEBQueKtgS/ONKiekYDgggsAHIAH8c2cB52P84YDt1cHeG1ndcikRxGPi8ist2TuUQizAUx2vDxeQELqI2kjo5r2gyTSDcRYb4HYEZas91STSPoI/GPB6+dxrnk5qr/OWydm1vko99rVdJyIbHasV8ephk1N65AuxK/1KiLM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748474933; c=relaxed/simple;
	bh=7a7fYDtj0dtJ7GJ5g+HYdLl+MsSUffIFJ1RyUxGkV2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePOB8o/9sUboc9ayDWOfXWyDIh6XfotqKBHGsmifIeZKJacw8aPFRYvU1J9LA9jEmfDjPC7rQ9+yVtp+T/rZzU1MYcwym2QStVkf54hVu6TA5QL/Z7JKmi7qy8/6UxzCls2AUc7scCoxrHTguFw+8ArRnPz2Dq5J7ab41rMPs+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vGxOCBMC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g7ss9x1k; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vGxOCBMC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g7ss9x1k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54FB4211D2;
	Wed, 28 May 2025 23:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748474930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6olg2zbth4Ly9vizF4n9EaCvDOSfCuec5+2SnUi6QcQ=;
	b=vGxOCBMCAyBQqlgxYTuzjA3oYL5O+qUqNf9voX8guKTvTbljRszGoECKDJYcEV1inDG0k5
	hc0JW92n0vCvmpvXKmgAfe7gE8mHd6EF5xqhrO+nqLfp4R1orDnW9a030/x2v2N486fjSS
	ejqCJeA1xsqLFAI0vnjMNDQLg51QWcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748474930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6olg2zbth4Ly9vizF4n9EaCvDOSfCuec5+2SnUi6QcQ=;
	b=g7ss9x1kZbyb0OcMWzCOBlqXG9tkAOjG+Ax+JypYGw3DzNCI6Z7V/SnXYuv9RdY4egr7W0
	W5jE77IDUKc54lDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748474930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6olg2zbth4Ly9vizF4n9EaCvDOSfCuec5+2SnUi6QcQ=;
	b=vGxOCBMCAyBQqlgxYTuzjA3oYL5O+qUqNf9voX8guKTvTbljRszGoECKDJYcEV1inDG0k5
	hc0JW92n0vCvmpvXKmgAfe7gE8mHd6EF5xqhrO+nqLfp4R1orDnW9a030/x2v2N486fjSS
	ejqCJeA1xsqLFAI0vnjMNDQLg51QWcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748474930;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6olg2zbth4Ly9vizF4n9EaCvDOSfCuec5+2SnUi6QcQ=;
	b=g7ss9x1kZbyb0OcMWzCOBlqXG9tkAOjG+Ax+JypYGw3DzNCI6Z7V/SnXYuv9RdY4egr7W0
	W5jE77IDUKc54lDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34364136E0;
	Wed, 28 May 2025 23:28:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HOxEDDKcN2gIXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 28 May 2025 23:28:50 +0000
Date: Thu, 29 May 2025 01:28:49 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Nick Terrell <terrelln@fb.com>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: harden parsing of compress mount option
Message-ID: <20250528232848.GM4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250423132220.4052042-1-neelx@suse.com>
 <20250424192956.GO3659@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424192956.GO3659@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: 1.00
X-Spam-Level: *
X-Spamd-Result: default: False [1.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]

On Thu, Apr 24, 2025 at 09:29:56PM +0200, David Sterba wrote:
> On Wed, Apr 23, 2025 at 03:22:19PM +0200, Daniel Vacek wrote:
> > Btrfs happily but incorrectly accepts the `-o compress=zlib+foo` and similar
> > options with any random suffix. Let's handle that correctly.
> 
> Please split the patch. Moving code and adding a fix obscures the fix.
> As we'll want to backport more than just the validation of ':' it
> makes more sense to do the full move first and then add the individual
> fixes on top of that. Thanks.

As we've discussed it, both ways how to split it are ok, so please first
factor out the code to a helper and the add the fix or any other
validation that would make sense. Thanks.

