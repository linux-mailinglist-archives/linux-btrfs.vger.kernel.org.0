Return-Path: <linux-btrfs+bounces-19080-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D067DC69482
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 13:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id B4B822B06E
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Nov 2025 12:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3D43563E7;
	Tue, 18 Nov 2025 12:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QJUlCDv3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="egMuWLmb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wZwvCrDD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+OPSYVRi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D260F35505C
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Nov 2025 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763467641; cv=none; b=lD7Wj5q5drCx1VYDqUmliJwrqJ+5T0VP2Sk/i07PyQWULXRWkNNl3tm6EkQOxaHzFKDyvb4K0S0P+ctvjC5bBRSC5BRkjEvhwUinGUMGEYxIVgINlk5sgNM/a2OoHbf3ko8fH/m5mNDwLOmpKrUusd57rGlVsCAbuVClJkyHxO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763467641; c=relaxed/simple;
	bh=Sby6QUzhQ9SSY2ZOBxLrI9Y+lqGdW4X/gYLwS+jNYFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUKn+o+L3PRuPcker89w+d/2fVO/aie5NcQoTBRdP5/0BPEQVkDUQITtCGz9TLoSOm/jC4ce3JNH90e945Y+fCN9qlXDM85bOK1ylu8vUyS5cpujaIvicpGS82bLmqy+pEl2I08n16J1qeGPkU9wy4RCRPuC80E70inyq2xaNzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QJUlCDv3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=egMuWLmb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wZwvCrDD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+OPSYVRi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF55B211A8;
	Tue, 18 Nov 2025 12:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763467638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJzvpC/zQ3wmCC1HobAF+eT60t3MvB//DLNZ3VRt5I8=;
	b=QJUlCDv3sagqamauNXQVO8V7LIScOhkAyQbCMpbiCAs+vH6X2YtHY1j8LLo6xG0Pw+x8Wj
	j7kYgHC8JJfm/jFcROOaXBjf2wLe53ynZJBlubo6s/sX3swJRM9fA6Ywl5lKBj+03US6uN
	8Ll5ek/KO0GbrTEISJtlr0t/g/C1EYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763467638;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJzvpC/zQ3wmCC1HobAF+eT60t3MvB//DLNZ3VRt5I8=;
	b=egMuWLmbqG++YW9Y/JQRPeSONveFZCgMOJj1qvvdr++TuxXEuMZlfPWkufj30bF2W2+EH/
	05cbsT/cWbO2B4AQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1763467637;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJzvpC/zQ3wmCC1HobAF+eT60t3MvB//DLNZ3VRt5I8=;
	b=wZwvCrDDJSA/hYl4fdFUaqpDLArtX+r89Y1m03x09blDOOzifGyRlMmIYPi6MVBPR+ENO2
	X07x+OXPXDv7lNrYllTqWiICujJY+KKAlPfgt+/CEliud8FD6n1OjGtB4rcRHJa/9o7h40
	vUx9O8Sgv3Jhvcfk40NHpI9Qwdh+OrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1763467637;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eJzvpC/zQ3wmCC1HobAF+eT60t3MvB//DLNZ3VRt5I8=;
	b=+OPSYVRivZ3TijfTZMGglzM/DE0oJy4g5ulVnUWTtpsMKfpUsuq5J5sQTWwvj40HpBjayK
	deRMrqFQGT5m9WDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF4F03EA61;
	Tue, 18 Nov 2025 12:07:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5YdrMnVhHGnrdAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 18 Nov 2025 12:07:17 +0000
Date: Tue, 18 Nov 2025 13:07:16 +0100
From: David Sterba <dsterba@suse.cz>
To: Daniel Vacek <neelx@suse.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: simplify async csum synchronization
Message-ID: <20251118120716.GT13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251113101731.2624000-1-neelx@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113101731.2624000-1-neelx@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,twin.jikos.cz:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, Nov 13, 2025 at 11:17:30AM +0100, Daniel Vacek wrote:
> We don't need the redundant completion csum_done which marks the
> csum work has been executed. We can simply flush_work() instead.
> 
> This way we can slim down the btrfs_bio structure by 32 bytes matching
> it's size to what it used to be before introducing the async csums.
> Hence not making any change with respect to the structure size.
> ---
> This is a simple fixup for "btrfs: introduce btrfs_bio::async_csum" in
> for-next and can be squashed into it.
> 
> v2: metadata is not checksummed here so use the endio_workers workqueue
>     unconditionally. Thanks to Qu Wenruo.

This looks quite useful regarding the size reduction of btrfs_bio,
please fold it to the patch. Thanks.

