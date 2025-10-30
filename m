Return-Path: <linux-btrfs+bounces-18419-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7397DC218D9
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 18:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B18918965EF
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Oct 2025 17:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E81C33EAEF;
	Thu, 30 Oct 2025 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VaSABHB5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tR6h0wNQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VaSABHB5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tR6h0wNQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095A437A3A6
	for <linux-btrfs@vger.kernel.org>; Thu, 30 Oct 2025 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846536; cv=none; b=Ou1WzXCVVFViXJeZShdLzM8BM5pSEI+voKAHlxSMNhJJfUBj/cB6CQQ06URg56/OHXDXkY773RySrk0bhFUIHtJF5UKKNRbregM4lFcv8u69kMcbx5nfn0uOMbLlnffUhbDIoUZKBdK/wdJyI+D4d543vPLM79XSwZQcwHHazIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846536; c=relaxed/simple;
	bh=nEfn+D2WOjq54jIe9/Hkqfgwz+AX+sT7DhQrDuo9Cg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBMHRPbX7rOt13XyEYrAAfkIR8PNx4TBtW2/E3zW1dUuC9I1iXw4AjP3HV/wwZ4KUiu1rLzjL9vp/bSqhz0UDxqJGFt8IpHWSKKNdgJyzG5VccSCK1uPfeONWMjyTO/KbMAAYcYlANy52xHAr4nP8nFqnCmDk7mV5FMRQPZWM4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VaSABHB5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tR6h0wNQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VaSABHB5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tR6h0wNQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B45C22BF6;
	Thu, 30 Oct 2025 17:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761846533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yp7OSbbw4bYj8GY+q/uWvRM3jPWGb7uppZXmCiqjV2M=;
	b=VaSABHB5xVrBvyUBwGUPyB8rn/93K3Q9vz0AP/4vkh+L2t6ep1IwSVeeFsQOvJrZH3apJc
	vasU86RoH14ko7t2TAPyRXYccmH4yqhEIDU5yd4cMuanS39+rzqL94EwaeV3Oo53bd5Sau
	9naRezfBwkKgb+g7wxytDUfZlSJIggQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761846533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yp7OSbbw4bYj8GY+q/uWvRM3jPWGb7uppZXmCiqjV2M=;
	b=tR6h0wNQspT/FcyHsptAJNN0vZkuM1tjp7Ufp57aikrvpvWYmTNkiC8eZ7P0opiwSJ797r
	f+940PEwxlIPoJDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1761846533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yp7OSbbw4bYj8GY+q/uWvRM3jPWGb7uppZXmCiqjV2M=;
	b=VaSABHB5xVrBvyUBwGUPyB8rn/93K3Q9vz0AP/4vkh+L2t6ep1IwSVeeFsQOvJrZH3apJc
	vasU86RoH14ko7t2TAPyRXYccmH4yqhEIDU5yd4cMuanS39+rzqL94EwaeV3Oo53bd5Sau
	9naRezfBwkKgb+g7wxytDUfZlSJIggQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1761846533;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yp7OSbbw4bYj8GY+q/uWvRM3jPWGb7uppZXmCiqjV2M=;
	b=tR6h0wNQspT/FcyHsptAJNN0vZkuM1tjp7Ufp57aikrvpvWYmTNkiC8eZ7P0opiwSJ797r
	f+940PEwxlIPoJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E1071396A;
	Thu, 30 Oct 2025 17:48:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7fv0DgWlA2nbZgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 30 Oct 2025 17:48:53 +0000
Date: Thu, 30 Oct 2025 18:48:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] fix zone capacity/alloc_offset calculation
Message-ID: <20251030174852.GA13846@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251027072758.1066720-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027072758.1066720-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

On Mon, Oct 27, 2025 at 04:27:56PM +0900, Naohiro Aota wrote:
> When a conventional zone is in a block group, we cannot know the
> alloc_offset from the write pointers. In that case, we use the last
> extent in the zone to know the last allocation offset. We calcualte the
> alloc_offset from it, but the current calculation is wrong in two ways.
> 
> First, the zone capacity is mistakenly set to the zone_size if there is
> at least one conventional zone in the block group. That should be
> calculated properly depending on the raid type.
> 
> Second, the stripe width is wrongly set to map->stripe_size, which is
> zone_size on the zoned setup.
> 
> This series fixes these two bugs.
> 
> Naohiro Aota (2):
>   btrfs: zoned: fix zone capacity calculation
>   btrfs: zoned: fix stripe width calculation

Please add the patches to for-next, with the fixed 64bit division.
Thanks.

