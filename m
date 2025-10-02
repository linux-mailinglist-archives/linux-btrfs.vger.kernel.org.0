Return-Path: <linux-btrfs+bounces-17337-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0254CBB4699
	for <lists+linux-btrfs@lfdr.de>; Thu, 02 Oct 2025 17:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF6D91899EB4
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Oct 2025 15:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA39C8E6;
	Thu,  2 Oct 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="d8Kum9Hf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4wvXHUJO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VfMH3Hrs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Pm84hgKi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0249235063
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Oct 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420577; cv=none; b=Y4BJvvs4eO2902FbzXFfhEBTbFOUOaxuB7mEKa5Y6vR4JabWgyISH+gVoy/oJudwUtKC0g43kP3g0m96MGugVlB9XALc/rc+lRFA33Nt3IkGsLtraSo7OP9KuynbAkLUW+PdwaIP+q9aBsqBoi3mPKYZ9BMXwN5EA/9ZpHibM2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420577; c=relaxed/simple;
	bh=hJq7TDuT+H1PLUCPGmYEsbQgxesaakMScmRtq0KJ/Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhaeGihgBJ5yM9W3ZSQet3aI8pfJoloeavedu4RdfSkiFyg1g0Xxt/XAF7JQiLHq51+99gZTPg3LS2WmV556sYYyxg2J2WHIOM/EVulNIDKA/yqU0GTs0hdaP4mM2xbIR6tiWhin7pmUbu/dJALwF1sEyhMam0Q10uorn1PBaXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=d8Kum9Hf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4wvXHUJO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VfMH3Hrs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Pm84hgKi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0E0AD1F745;
	Thu,  2 Oct 2025 15:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759420574;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esyl62EkycqibOf3DAoQKb9yud5s4zDypMNyi/ZtCyo=;
	b=d8Kum9HfiniryaLVhx7z6l2jcQF3OsDaMc6ixqYUER8Siq0UOx+stmXpofN/7ZZQPQcGd1
	4ZEHHqVnhaM+yc3TaZFcn10hKbRGqX2Qv2yHmoMgMDS3EF76/IkvhfpUPqJLZicdNK97my
	woGNo6PNE1fizieZZuraTOEZEvZtd8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759420574;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esyl62EkycqibOf3DAoQKb9yud5s4zDypMNyi/ZtCyo=;
	b=4wvXHUJOas4Bbct5ymMNoYtax6CETyzhHQBEwUeW6mUZ2Olx/XizRylSekQW2Ojqg7+cJb
	GZWlplzE2ma8vZAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1759420573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esyl62EkycqibOf3DAoQKb9yud5s4zDypMNyi/ZtCyo=;
	b=VfMH3HrspyC1AhD23G3SwUhG5uFTp59xPhocDoCk5yD09iB2IMH4uoK+AlBdgqobzl7Uae
	4yZj7Q6n3yqIYk9pQjbHAXctg+LuzrI83kk17koOd/Vq4q/Hpj8JfOokgVud84mIZVpTUI
	+NmIsiWbZnjXnSGRaElKctWXh0dWY78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1759420573;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=esyl62EkycqibOf3DAoQKb9yud5s4zDypMNyi/ZtCyo=;
	b=Pm84hgKikN4hQFfeVCIYdyQYbB0IHJzrtx4ASxEcCxliU4i8qK3JQBM0NU4SlhaG/DHADx
	HBorY6AknHPiPRDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 013141395B;
	Thu,  2 Oct 2025 15:56:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m14YAJ2g3mh+awAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 Oct 2025 15:56:13 +0000
Date: Thu, 2 Oct 2025 17:56:11 +0200
From: David Sterba <dsterba@suse.cz>
To: Sun YangKai <sunk67188@gmail.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: goto out -> return conversions for previous patch
Message-ID: <20251002155611.GI4052@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251002133920.24528-1-sunk67188@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002133920.24528-1-sunk67188@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Thu, Oct 02, 2025 at 09:39:00PM +0800, Sun YangKai wrote:
> Tested with btrfs/auto group. Tests that require $SCRATCH_DEV_POOL,
> $LOGWRITES_DEV, zoned block devices and dm flakey support are skipped.

Is this a standalone patch or fixup to the path auto freeing? The
changelog should describe the change, not what you tested it on. This
may matter in some cases but this is better under the "---" line in the
patch.

> 
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---

(here)

>  fs/btrfs/uuid-tree.c | 102 +++++++++++++++----------------------------
>  fs/btrfs/verity.c    |  14 +++---
>  fs/btrfs/volumes.c   |  98 +++++++++++++++--------------------------
>  fs/btrfs/xattr.c     |  29 ++++--------
>  4 files changed, 86 insertions(+), 157 deletions(-)

