Return-Path: <linux-btrfs+bounces-5675-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02103905C5C
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 21:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749051F2322F
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Jun 2024 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B136583CD3;
	Wed, 12 Jun 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sjZoTFWq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RyrvpOFy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sjZoTFWq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RyrvpOFy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640FC4F8BB
	for <linux-btrfs@vger.kernel.org>; Wed, 12 Jun 2024 19:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718222051; cv=none; b=pwZRofHiKIyK/u4nhDUw7ik4WA+2Iul8iQPJpfkLUCL57W2wWad778LOp3D/ghyDIKLojnKPyEdTiFcMYNsWz8vHvUX1cKcIa/j/gY9NoXCS4KyEzdF79/DJ3zBT5eOZIPFSzNytvhVz5F6G25RqDDRBVJFvTq8YHaRFRWlHMJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718222051; c=relaxed/simple;
	bh=m8HHVaRWYV3BCaVI5taDP8vFhYHeFXs5NoMQX/FlmZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QK319WWdQAccRAEzgbP4nC+df+t5NPmqe0aIteC56UbwWekR38lEa1Nj7/kNWOge1eaYh/IkMoGHj+jmMVfSFpYHIbYXX2l3qjMB/XgiZIGHFZTpoaUymnY9h+v6xLZne6MBPoZU456XsTzM3G2b7RM82P6zHn8nPXdn8y4DKHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sjZoTFWq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RyrvpOFy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sjZoTFWq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RyrvpOFy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D7213485A;
	Wed, 12 Jun 2024 19:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718222048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0h8oHSjbfGqMGDIDjd1mPOVGdQjDodIqb926BGOxGFc=;
	b=sjZoTFWqZ6J2iKhTWVaBuyxV0e6pEO0UTclISHSId8XfrF2kwbSp3dBqKHT0hDverX8Ad5
	Fahr7EuwKdKfoo+ew7rSQkpganBF9MDVUsajTOzh5D+ex1LF35XIAM0ug5nGSJnIlGyegn
	YLDeEThTaosLhX0nw0fYTGkc+V5hwDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718222048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0h8oHSjbfGqMGDIDjd1mPOVGdQjDodIqb926BGOxGFc=;
	b=RyrvpOFysvgo2IF1OQfXahG8X73fXjTk3tEaqbeQIdV2s37X/GIf8gojGX28oOARJEX7Tu
	PzH/E7lvK/QBcGDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sjZoTFWq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RyrvpOFy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718222048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0h8oHSjbfGqMGDIDjd1mPOVGdQjDodIqb926BGOxGFc=;
	b=sjZoTFWqZ6J2iKhTWVaBuyxV0e6pEO0UTclISHSId8XfrF2kwbSp3dBqKHT0hDverX8Ad5
	Fahr7EuwKdKfoo+ew7rSQkpganBF9MDVUsajTOzh5D+ex1LF35XIAM0ug5nGSJnIlGyegn
	YLDeEThTaosLhX0nw0fYTGkc+V5hwDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718222048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0h8oHSjbfGqMGDIDjd1mPOVGdQjDodIqb926BGOxGFc=;
	b=RyrvpOFysvgo2IF1OQfXahG8X73fXjTk3tEaqbeQIdV2s37X/GIf8gojGX28oOARJEX7Tu
	PzH/E7lvK/QBcGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79F4A1372E;
	Wed, 12 Jun 2024 19:54:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IACTHeD8aWYvIwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 12 Jun 2024 19:54:08 +0000
Date: Wed, 12 Jun 2024 21:54:07 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: do not use async discard for misc/004
Message-ID: <20240612195407.GP18508@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5a292583be11ae383e79aaca0fa79be2141ef6ca.1717732459.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a292583be11ae383e79aaca0fa79be2141ef6ca.1717732459.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9D7213485A
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, Jun 07, 2024 at 08:00:45PM +0930, Qu Wenruo wrote:
> [BUG]
> There is a long long existing failure in my local VM that with any newer
> kernel (6.x) the test case misc/004 would fail with ENOSPC during
> balance:
> 
>     [TEST]   misc-tests.sh
>     [TEST/misc]   004-shrink-fs
>  failed: /home/adam/btrfs-progs/btrfs balance start -mconvert=single -sconvert=single -f /home/adam/btrfs-progs/tests/mnt
>  test failed for case 004-shrink-fs
>  make: *** [Makefile:547: test-misc] Error 1
> 
> [CAUSE]
> With more testing, it turns out that just before the balance, the
> filesystem still have several empty data block groups.
> 
> The reason is the new default discard=async behavior, as it also changes
> the empty block groups to be async, this leave the empty block groups
> there, resulting no extra space for the convert balance.
> 
> [FIX]
> I do not understand why for loopback block devices we also enable
> discard, but at least disable discard for the test case so that we can
> ensure the empty block groups get cleaned up properly.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

