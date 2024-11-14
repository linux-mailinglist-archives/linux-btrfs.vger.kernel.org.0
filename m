Return-Path: <linux-btrfs+bounces-9660-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D0579C8F10
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 17:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D891F1F25908
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Nov 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C789418BBAA;
	Thu, 14 Nov 2024 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HFwexs+8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KVPWIlVq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HFwexs+8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="KVPWIlVq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE131420A8;
	Thu, 14 Nov 2024 16:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731600119; cv=none; b=Nw1h0CJb3hIKFFV/nf6K/QIO15M8/WEq7tHqL/YIsR4muhhfvM+2eDYfjAYfEvTL6xZWI4DKfkiPQZomIDuxDPSnSHBbW1/mWe3JtKLzNwjmtrCR6ptrLjCfS5AoeYEI/8ZxwIHOUM+tQOo2RU6SKkNAH+2nMY1pB4Lw+a6UsZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731600119; c=relaxed/simple;
	bh=ZOsVr3YzxdZ3WzJa686khP64hibUQOMPSNEzmGlaEAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bj1FngKIxXsA8GF1R9ixMx9+hfm3bSXLHhchNYxeZ6gFXyglDj/GuKOg0V5bSWXIsGWNIg5Rg3wJE1BDqqwehbBN82pFl7+DtA2XYEmYHleCTcewZJ+jb6gFwTzDvMfeXfjn3LsY11xWzankK0iusTpIGe51aS0cApeyg3A5KZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HFwexs+8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KVPWIlVq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HFwexs+8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=KVPWIlVq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 608351F395;
	Thu, 14 Nov 2024 16:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731600115;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YRJSZeaaPizV97gqakVtZ0iRAODmBijl2cqLU0n/OGo=;
	b=HFwexs+8H2s2U92s2MUaytNQuxcVUs6NYHoNuqSILR4j31DXXNaclDUrYHwOCWJrXIFRIT
	wZIDBZyGsiFwWPjXQ8xKMieIh+00Xfr8p6pV+u+MwHZLddLL4SvTJTTEBS5gByO/6JsTgM
	AXCj2cgkR7+h66IJeOW9I8jNE4FyfyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731600115;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YRJSZeaaPizV97gqakVtZ0iRAODmBijl2cqLU0n/OGo=;
	b=KVPWIlVqIEj/0HjRdiwPvbL25uPHmoPxZz1f3bQ1SaWT/kYZsdONWR+EfX0BbV0jNsdNyu
	uXCPC76zUbgv2qAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731600115;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YRJSZeaaPizV97gqakVtZ0iRAODmBijl2cqLU0n/OGo=;
	b=HFwexs+8H2s2U92s2MUaytNQuxcVUs6NYHoNuqSILR4j31DXXNaclDUrYHwOCWJrXIFRIT
	wZIDBZyGsiFwWPjXQ8xKMieIh+00Xfr8p6pV+u+MwHZLddLL4SvTJTTEBS5gByO/6JsTgM
	AXCj2cgkR7+h66IJeOW9I8jNE4FyfyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731600115;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YRJSZeaaPizV97gqakVtZ0iRAODmBijl2cqLU0n/OGo=;
	b=KVPWIlVqIEj/0HjRdiwPvbL25uPHmoPxZz1f3bQ1SaWT/kYZsdONWR+EfX0BbV0jNsdNyu
	uXCPC76zUbgv2qAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4151313794;
	Thu, 14 Nov 2024 16:01:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tktED/MeNmclFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 14 Nov 2024 16:01:55 +0000
Date: Thu, 14 Nov 2024 17:01:50 +0100
From: David Sterba <dsterba@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix incorrect comparison for delayed refs
Message-ID: <20241114160150.GU31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc61fb63e534111f5837c204ec341c876637af69.1731513908.git.josef@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Nov 13, 2024 at 11:05:13AM -0500, Josef Bacik wrote:
> When I reworked delayed ref comparison in cf4f04325b2b ("btrfs: move
> ->parent and ->ref_root into btrfs_delayed_ref_node"), I made a mistake
> and returned -1 for the case where ref1->ref_root was > than
> ref2->ref_root.  This is a subtle bug that can result in improper
> delayed ref running order, which can result in transaction aborts.
> 
> cc: stable@vger.kernel.org
> Fixes: cf4f04325b2b ("btrfs: move ->parent and ->ref_root into btrfs_delayed_ref_node")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Simple and serious fix, I'll send a pull request today. Thanks.

