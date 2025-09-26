Return-Path: <linux-btrfs+bounces-17222-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC19BA39B4
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B553516AC26
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 12:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4D12EC57F;
	Fri, 26 Sep 2025 12:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xrEWlege";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yo9EjLZB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xrEWlege";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yo9EjLZB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EED52EBBB7
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889588; cv=none; b=dbk6tjYmFAY6B8teMU8zEggQZ0flNOTsS1BBQRiyTp97KJqQ/8M7Puo1PnAs3W5zTuJXWVyBXLGtb8avAPjRhvJ8PuzquyAG3zUev3+GG03Uw7oVhfSmDhOHwX45OKqzyC0vKDu91va4OV8T7WWoHF9eYExylzAiEVO1cAfY8yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889588; c=relaxed/simple;
	bh=/Ij32yEcg/AC/osmqdmeQLpoWAjiEPTZOQ0rn97nUWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dyDWf33yP/CtXwnAztsXdL4AFS1WSKbl0kH+mlSG3oTA3E+ocePJeGGOeYSLP8e7wKNTypT5UvVSYVzMJsS55KJThYCQGl8BAnD7Df2YNNk4Dk7udqpQG9FDntsfwggOeCu7DN1/BMxzhxANekQQR03FEsYdIGCAu6TI4YRbq+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xrEWlege; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yo9EjLZB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xrEWlege; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yo9EjLZB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF84E2419B;
	Fri, 26 Sep 2025 12:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758889584;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxtDJnF07kVzUhVncCOxlYbYQMGGKmD3xWHJjqcWS/Q=;
	b=xrEWlegeVoq6VkmoClettVPlvMKdXOkvfWwX0bdP/xWwoKgdDEyystC4LTgr/lKiGi2iUz
	zONy8PuTe0yZzECO65uZYYoJ+7cSaj4qx9TLI5D31w6Ja0/+MnvHNw60jfYMe09wVr3sj/
	PDfyDJAnpxyJyiCdeEmJwYopEkY9LwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758889584;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxtDJnF07kVzUhVncCOxlYbYQMGGKmD3xWHJjqcWS/Q=;
	b=Yo9EjLZBwSQslAxF+bYJCpqAhMkJi4p9MdTiS6KG1IruqpZpgrVTVhiHkyB4C9WqYiyXsJ
	dl6Bt7vTNwHokxBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758889584;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxtDJnF07kVzUhVncCOxlYbYQMGGKmD3xWHJjqcWS/Q=;
	b=xrEWlegeVoq6VkmoClettVPlvMKdXOkvfWwX0bdP/xWwoKgdDEyystC4LTgr/lKiGi2iUz
	zONy8PuTe0yZzECO65uZYYoJ+7cSaj4qx9TLI5D31w6Ja0/+MnvHNw60jfYMe09wVr3sj/
	PDfyDJAnpxyJyiCdeEmJwYopEkY9LwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758889584;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CxtDJnF07kVzUhVncCOxlYbYQMGGKmD3xWHJjqcWS/Q=;
	b=Yo9EjLZBwSQslAxF+bYJCpqAhMkJi4p9MdTiS6KG1IruqpZpgrVTVhiHkyB4C9WqYiyXsJ
	dl6Bt7vTNwHokxBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A382A1373E;
	Fri, 26 Sep 2025 12:26:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S3G7J3CG1mhGRAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Sep 2025 12:26:24 +0000
Date: Fri, 26 Sep 2025 14:26:23 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix trivial -Wshadow warnings
Message-ID: <20250926122623.GU5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250926094730.3598980-1-dsterba@suse.com>
 <e3e014fa-9987-47b4-9464-5cf78e9abf9a@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e3e014fa-9987-47b4-9464-5cf78e9abf9a@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Fri, Sep 26, 2025 at 07:54:09PM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/9/26 19:17, David Sterba 写道:
> > When compiling with -Wshadow (also in 'make W=2' build) there are
> > several reports of shadowed variables that seem to be harmless:
> > 
> > - btrfs_do_encoded_write() - we can reuse 'ordered', there's no previous
> > 			     value that would need to be preserved
> > 
> > - scrub_write_endio() - we need a standalone 'i' for bio iteration
> > 
> > - scrub_stripe() - duplicate ret2 for errors that must not overwrite 'ret'
> > 
> > - btrfs_subpage_set_writeback() - 'flags' is used for another irqsave lock
> >                                    but is not overwritten when reused for xarray
> > 				  due to scoping, but for clarity let's rename it
> > 
> > - process_dir_items_leaf() - duplicate 'ret', used only for immediate checks
> > 
> > Signed-off-by: David Sterba <dsterba@suse.com>
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> 
> Although I'm still not 100% sure if using the variable in the function 
> scope is really any safer.
> 
> The last call site is a good example, it's only safe to use @ret from 
> the function scope as we immediately return after an error.

Yes, either that or we 'goto out' and do not use 'ret' anymore other
than 'return ret'.

> If we use @ret to record some error but not immediately return, then we 
> can override the previous error code and cause problems.
> 
> I'd prefer to always use the local variable, and remove the one in the 
> larger scope, but unfortunately all call sites have directly usage 
> inside the function...

If we can't use the function scope ret then we've been using ret2,
otherwise one 'ret' for any use is way more common. I don't think we
should declare a shadowing ret in the nested scopes.

