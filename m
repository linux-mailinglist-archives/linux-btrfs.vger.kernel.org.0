Return-Path: <linux-btrfs+bounces-18932-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6422CC5664A
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 09:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 074E234EC1F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Nov 2025 08:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB32F2DCF6E;
	Thu, 13 Nov 2025 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="01BSfI+s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yB3kJO9c";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="01BSfI+s";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yB3kJO9c"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBFC2C0F6F
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Nov 2025 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023737; cv=none; b=sEzNYtEO5mQOciIq76aLcYQtI9rUXatI5kOCU5E+fWXwQvROmK/Qepsrz32uOV0YGLMJyFiGtzcIybCaLB9IaM6otlq/pSW2JkEEbZ6k0cqttYrcHkYlZDe9aFD8GZqqXVIinQQMeGW8oHbYsS3KUGQYIuSt7RyxnAnylK98bMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023737; c=relaxed/simple;
	bh=QpRZSgRYd4rH/Xz6ygaw4c+/Y6fFLVpilRKRT4EasCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJHRy/thv9gkxSPiaQPHAhkJ7q1Wholb5m7IZIAeZXMi1zS5MrTQZ6/qCH3uMXAEsPkTuQzn/Rhaz82pzt5Oafi51o2cIdKJoolIL+ESCbizFnUn2DQffs+n6tzprdhmhgkxYlE3O2oOYtHweODRxVuelOlzHIoKav4M+uOM0Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=01BSfI+s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yB3kJO9c; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=01BSfI+s; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yB3kJO9c; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5675F216DF;
	Thu, 13 Nov 2025 08:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763023732;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sx93JUcv4qcmATAOJy9CUY8HmA2rQg/uUrgQFTjoQzc=;
	b=01BSfI+sq1wZ8KBFWMyZBVpp+XT48vzzdfIi+dmPEkzaGY9CKu65GZChEVyrOKbYlPNQ+v
	JAF1PcIJ3fydBwOoBdM0P3OA30nG7WZWdq+7fpVj+tC0BG2OYUj8XeCAFaxz6prvke56EI
	PpS0v0lqcuxvJQQe3TBwxicu00tuKu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763023732;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sx93JUcv4qcmATAOJy9CUY8HmA2rQg/uUrgQFTjoQzc=;
	b=yB3kJO9c+HOn9AX84X0NRkpNPR8ZCtGR7944MubFBhZFgVmmmbPYRJfcT5TDqBMHKvxwEN
	XUPicfBdOl9PDsAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=01BSfI+s;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yB3kJO9c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763023732;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sx93JUcv4qcmATAOJy9CUY8HmA2rQg/uUrgQFTjoQzc=;
	b=01BSfI+sq1wZ8KBFWMyZBVpp+XT48vzzdfIi+dmPEkzaGY9CKu65GZChEVyrOKbYlPNQ+v
	JAF1PcIJ3fydBwOoBdM0P3OA30nG7WZWdq+7fpVj+tC0BG2OYUj8XeCAFaxz6prvke56EI
	PpS0v0lqcuxvJQQe3TBwxicu00tuKu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763023732;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sx93JUcv4qcmATAOJy9CUY8HmA2rQg/uUrgQFTjoQzc=;
	b=yB3kJO9c+HOn9AX84X0NRkpNPR8ZCtGR7944MubFBhZFgVmmmbPYRJfcT5TDqBMHKvxwEN
	XUPicfBdOl9PDsAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46D583EA61;
	Thu, 13 Nov 2025 08:48:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tWUfEXSbFWl3SwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 13 Nov 2025 08:48:52 +0000
Date: Thu, 13 Nov 2025 09:48:47 +0100
From: David Sterba <dsterba@suse.cz>
To: Gladyshev Ilya <foxido@foxido.dev>
Cc: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 6/8] btrfs: simplify cleanup via scoped_guard()
Message-ID: <20251113084847.GH13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1762972845.git.foxido@foxido.dev>
 <b483e6140d82a068c332b3f15fc6ef11dd438695.1762972845.git.foxido@foxido.dev>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b483e6140d82a068c332b3f15fc6ef11dd438695.1762972845.git.foxido@foxido.dev>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 5675F216DF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Spam-Score: -4.21

On Wed, Nov 12, 2025 at 09:49:42PM +0300, Gladyshev Ilya wrote:
> Simplify cases with multiple unlock paths like
> 
> spin_lock(&lock);
> if (something) {
>         spin_unlock(&lock);
>         goto faraway; // or return
> }
> spin_unlock(&lock);
> 
> with scoped_guards() to improve readability and robustness.
> 
> Signed-off-by: Gladyshev Ilya <foxido@foxido.dev>
> ---
>  fs/btrfs/block-group.c      | 20 +++++-------
>  fs/btrfs/compression.c      | 13 ++++----
>  fs/btrfs/extent-tree.c      |  8 ++---
>  fs/btrfs/extent_io.c        | 33 +++++++++----------
>  fs/btrfs/free-space-cache.c | 63 +++++++++++++++----------------------
>  fs/btrfs/qgroup.c           | 38 +++++++++++-----------
>  fs/btrfs/send.c             | 37 ++++++++++------------
>  fs/btrfs/tree-log.c         | 13 +++-----

This is probably the best example of the worst case of the conversions.
8 files changed, many of them likely target of future fixes that would
need to be backported, churn in many lines besides locking, code flow
and error handling is supposed to be improved but each instance needs to
be verified anyway. So this is quite costly cleanup.

