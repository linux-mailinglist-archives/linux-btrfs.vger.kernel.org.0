Return-Path: <linux-btrfs+bounces-8826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EED9993C9
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 22:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FC25B23C36
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041991E1C15;
	Thu, 10 Oct 2024 20:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b/UnzDlh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqxbGS6T";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b/UnzDlh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lqxbGS6T"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7CC1D041A;
	Thu, 10 Oct 2024 20:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592739; cv=none; b=ENQy7sk493RewpcMyq+Rt0sPrJXUkDIWNwBJ+DyVk9FDyyAl+WCfD0JzUrPXzubVrdqbFEneTmrNjYnKefbtKJqXw94GVpSKePpPdYuov/L6NifzUHT30i6YDkLJRS+SEHPqKcYFA7qfXQ/dTKPLVUA08XQ8g/TV74ecYFSIRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592739; c=relaxed/simple;
	bh=tAzSba8fi0vSD9nfCa0OsDhhkMUxr+cxCTAKKbZbKAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3LISwWuA5bAyFduFYt+bvt1wOU5+bErziTtvcM/NJknQBClVeckKNdxkBR53vDoXOVa1VRewVjzqD6/yDlqL7Qnor4h/xcoVOGzrNrXWgC+yIuy3Bvbw51IVtsMluunmDO6/P5vlNjGnBDbnDlvKaokCUdZDeDSRENRIRjfNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b/UnzDlh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqxbGS6T; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b/UnzDlh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lqxbGS6T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ACFB521A90;
	Thu, 10 Oct 2024 20:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728592734;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ6HQ25L3Z5f5L0A1ffhLg/EnLPyof/1Rm2rAB6KxaA=;
	b=b/UnzDlhqh3WSFCPYWPJH5Oog6B/yTI3hunC97q2E05N7JWeukDOZjCZIHILDIDCMtGDOd
	F4HVQtP7i0MQGD1KTQhK76e4xgQUFb10PCtrBk95oRz4PAPuyKEbLgBWFqs9orZFjmiN3+
	vc9Yoats6htjaESCdzl7y35qKCpqG7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728592734;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ6HQ25L3Z5f5L0A1ffhLg/EnLPyof/1Rm2rAB6KxaA=;
	b=lqxbGS6TwHLVcnPweL/Q3mi1UTyQbUyPDxqcKeukBOGj+yMhMVirDt+WXiETmmg2O6l7df
	nyjfOr5UrKVZikBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="b/UnzDlh";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lqxbGS6T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728592734;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ6HQ25L3Z5f5L0A1ffhLg/EnLPyof/1Rm2rAB6KxaA=;
	b=b/UnzDlhqh3WSFCPYWPJH5Oog6B/yTI3hunC97q2E05N7JWeukDOZjCZIHILDIDCMtGDOd
	F4HVQtP7i0MQGD1KTQhK76e4xgQUFb10PCtrBk95oRz4PAPuyKEbLgBWFqs9orZFjmiN3+
	vc9Yoats6htjaESCdzl7y35qKCpqG7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728592734;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PQ6HQ25L3Z5f5L0A1ffhLg/EnLPyof/1Rm2rAB6KxaA=;
	b=lqxbGS6TwHLVcnPweL/Q3mi1UTyQbUyPDxqcKeukBOGj+yMhMVirDt+WXiETmmg2O6l7df
	nyjfOr5UrKVZikBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89DE01370C;
	Thu, 10 Oct 2024 20:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PqAZIV47CGefVQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 10 Oct 2024 20:38:54 +0000
Date: Thu, 10 Oct 2024 22:38:52 +0200
From: David Sterba <dsterba@suse.cz>
To: Ira Weiny <ira.weiny@intel.com>
Cc: David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] kernel/range: Const-ify range_contains parameters
Message-ID: <20241010203852.GU1609@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241010-const-range-v1-1-afb6e4bfd8ce@intel.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010-const-range-v1-1-afb6e4bfd8ce@intel.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: ACFB521A90
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,suse.cz:dkim,suse.cz:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Oct 10, 2024 at 10:24:42AM -0500, Ira Weiny wrote:
> range_contains() does not modify the range values.  David suggested it
> is safer to keep those parameters as const.[1]
> 
> Make range parameters const
> 
> Link: https://lore.kernel.org/all/20241008161032.GB1609@twin.jikos.cz/ [1]
> Suggested-by: David Sterba <dsterba@suse.cz>

You can drop the above line.

> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: David Sterba <dsterba@suse.com>

