Return-Path: <linux-btrfs+bounces-4629-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B12948B603A
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 19:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 672E91F21255
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Apr 2024 17:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65858126F02;
	Mon, 29 Apr 2024 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AeeEHr0C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0TKt4z9a";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aqdH2hKs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o0e6uayZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10912839FD
	for <linux-btrfs@vger.kernel.org>; Mon, 29 Apr 2024 17:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714412235; cv=none; b=utlpVPUBhb9ijGsmeux2HdFyFA7BQeHhxPbBM23xIsaV4WtIynbA2kb0Gf8wK8KmNkypfVkfHu8eBLHy/d0Ye+hciMQjzl6k6sdn9oyXxdjPYPh9XF+BaZR9QN2OLF4ZM6fpBmJ8ePvVizNuCRcA302/KykMTxmumzUFxiz5lt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714412235; c=relaxed/simple;
	bh=kvSTEA3YcIL5ACnJalORPNh3Ks4QD/cWz0DjaRpIpYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s2uRyyf1CN1prBMu+WSr2O7/bylpGptrrq4YkzQrg8Dp28PmaYKEmJd3E0IB+6IeKXsVXGxjGKlfuW/UHONBWJZbe/Mku2AFlPeEbam5SrDggnQnwT2DouyU748zLAKn7xBejVyySEWSgcIjLPB7ldQz3lwWglDWzetOm2HyfOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=AeeEHr0C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0TKt4z9a; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aqdH2hKs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o0e6uayZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E0DD51F44B;
	Mon, 29 Apr 2024 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714412232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRyAeip/jaQnX+6lmA2827fdhU2ozpER+ru6KBrn0KI=;
	b=AeeEHr0CydV/K801kCvXXVGTZa4zG2Y8NWbdVGlICoPadxfhtsHDF+HtYTJmCX8EPepWGX
	bt5p791sRSQxPBicKTLWrsux4pIgAai4OekPIGQRXZjknyQVsoek62jhCo2gpaZcF5tlKX
	n3Qj2lODc9VLuwmUQs4JqK45V+hxWIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714412232;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRyAeip/jaQnX+6lmA2827fdhU2ozpER+ru6KBrn0KI=;
	b=0TKt4z9ap4I7gbJiPcCCRmYlbvzgivkI9G+ZNnJM9ijp6ik5fxfDVP1tlMdaqVX8mnvqt1
	2+DDmJ4gWO59BhCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aqdH2hKs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=o0e6uayZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1714412231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRyAeip/jaQnX+6lmA2827fdhU2ozpER+ru6KBrn0KI=;
	b=aqdH2hKs4G5mImgt0WD4MJMeuyyqqSZEyGfwqkakg6FBReVPDP1KFFaUkjOqxUymMpB40/
	ZyTyiWpJ5cdt1wTTw1eYvn+/OVUJb+CAcWEUDWs4TwZ0YXbpvGBqK0NRV7pErlGt33w01g
	lDqILm0frgmlleYbefAi5hlLYj0VpkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1714412231;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FRyAeip/jaQnX+6lmA2827fdhU2ozpER+ru6KBrn0KI=;
	b=o0e6uayZU61lqFUxYSEjLQ8a3EVR90+QRuYZdJSZE9Cu5c1YWlQtajjZun1X24sEFQWn81
	HSt+Kf6rud/3SUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CEE3C138A7;
	Mon, 29 Apr 2024 17:37:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nR8YMsfaL2Z/SQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 29 Apr 2024 17:37:11 +0000
Date: Mon, 29 Apr 2024 19:29:57 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: revert `btrfs subvolume delete
 --delete-qgroup` option
Message-ID: <20240429172957.GJ2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1714082499.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714082499.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.19
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E0DD51F44B
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.19 / 50.00];
	BAYES_HAM(-2.98)[99.90%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]

On Fri, Apr 26, 2024 at 07:35:51AM +0930, Qu Wenruo wrote:
> The introduction of `btrfs subvolume delete --delete-qgroup` would not
> work for a lot of real world cases.
> 
> This would leads to unnecessary errors, and can be very confusing for
> end users.
> 
> Furthermore the new options do not take the lifespan of a subvolume into
> consideration or the possible conflicts with other qgroup features.
> 
> Although it's already too late, we should revert it to prevent further
> confusion and damage.

The options have been there since 6.6.3 so it's about 2 full releases
but it better be removed now.

> Qu Wenruo (2):
>   Revert "btrfs-progs: subvol delete: add options to delete the qgroup"
>   btrfs: misc-tests: remove the subvol-delete-qgroup test case

Added to devel, thanks.

