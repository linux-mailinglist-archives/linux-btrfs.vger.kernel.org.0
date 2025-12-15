Return-Path: <linux-btrfs+bounces-19755-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C71FCBF764
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 19:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BCDC3013EC4
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 18:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F42252EC0AA;
	Mon, 15 Dec 2025 18:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jw2+aOBG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tGgKYisC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RM3zaih+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k3mE5IbX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED735898
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765824240; cv=none; b=L/pF6s/FoI+8W2z0Mqcdjuu6rhqUrOQRgz3lkG+/6zY7njWRQmMJHgamkd2mcQuwKnEqjgcVnu6XE5fUiFaTsJkbsV5TggFpYJEn6L89iMw1fgtmzfJG/zTrLsaaWyg5RAlSUjIbYGpFV21ELcVMuS9WukFMn2TV04xHxa7R4dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765824240; c=relaxed/simple;
	bh=O0PBndzWo+yvVknlLly4DO0l1onGt/l2EsKv/YG00fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9NEWzwyRxw3wfH6mJ7WLq2/DQtvZ6af+4EP20D/WfMFAp5hBQFrgUes4bo6gWEzDaWSEaCyjPaS2kfkX1hHz7Xtr5pjU1Ku3BQENwa7apSveKWjdpl4EucMiqoU0c9ZaaCaYl8zaTFuLBhOUBRPHR+pdNv85T0sIbQhUNXTK7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jw2+aOBG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tGgKYisC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RM3zaih+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k3mE5IbX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC44F5BDB5;
	Mon, 15 Dec 2025 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765824237;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zEXJhfAzuMXSCkBeqp8kk7jZpcSaMMXv2FXZK15ozkI=;
	b=jw2+aOBG2iIPocEv8gH9zrpUozrU8wHtQi72/Jpcwc5c8AeDJDV37n9aQNsvCBln9m6oiB
	/HMFGxX4BUM5T8YGtQtijQS5ytjPMM3B6ZxFtWvf4GMDuCnFgjy63F8tDle8n+923lV+M3
	wSd3Eke/YtDOQokYe8L5MRcGdL/vIPw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765824237;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zEXJhfAzuMXSCkBeqp8kk7jZpcSaMMXv2FXZK15ozkI=;
	b=tGgKYisCu+tRYYABoJOiM6JEEmQT05ZwJnZx7D05vQ28sVsD7COWCK/QlEcglyFLlv9/cP
	cpJHoKQNNYP99MBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765824235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zEXJhfAzuMXSCkBeqp8kk7jZpcSaMMXv2FXZK15ozkI=;
	b=RM3zaih+sH9yc/x4BIa1cyVGGjkeSbpDpGTTOdStTv8pxK6UtVHv7L9QXGmY98T7tcIE3D
	hCxwx8GYuB3Hrut2Fb5fwamaCG8Jy3G+PAmx7bfH2scc/pMgxY68nDQH2rmcPmGWbXV+jP
	UWY39HBcn6l7J3PKzv/ksNUF7dMTcdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765824235;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zEXJhfAzuMXSCkBeqp8kk7jZpcSaMMXv2FXZK15ozkI=;
	b=k3mE5IbX/gL3qM9EbaF4dXQx7uZpM6g3CckdisMMxZwMAzs5Zwm3DksNnoLeEYP1u1nn3O
	DI3QvBVldUxFo5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3A043EA63;
	Mon, 15 Dec 2025 18:43:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dSuPL+tWQGlTBgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Dec 2025 18:43:55 +0000
Date: Mon, 15 Dec 2025 19:43:50 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/3] btrfs: fixes for inline extent fallback and error
 handling
Message-ID: <20251215184350.GE3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1765743479.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765743479.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.91 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.11)[-0.571];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.91

On Mon, Dec 15, 2025 at 09:38:24AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> A couple fixes and a cleanup in the inline extent creation path.
> Details in the changelogs.
> 
> Filipe Manana (3):
>   btrfs: do not free data reservation in fallback from inline due to -ENOSPC
>   btrfs: fix reservation leak in some error paths when inserting inline extent
>   btrfs: update stale comment in __cow_file_range_inline()

Reviewed-by: David Sterba <dsterba@suse.com>

