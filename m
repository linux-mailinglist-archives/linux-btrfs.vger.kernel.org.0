Return-Path: <linux-btrfs+bounces-13488-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D78AA0424
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 09:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3321B632B2
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Apr 2025 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB71B26A1C2;
	Tue, 29 Apr 2025 07:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NZcCLTC+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPj1kDkL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ORKiomuy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3T5S8n0x"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53A313A3F7
	for <linux-btrfs@vger.kernel.org>; Tue, 29 Apr 2025 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745910859; cv=none; b=lyfHo7d4Hcw6B0MSMxj0ZDGgOe+WaK0C0UO/oeK/e+RlH1k3koXzlJ6m7F8GH5LZKhM/Q8fDTVUROJZ484W+a5k8JS7uvEVti7vzYgDwQKC1racNFrPKGICFDfJCaRFEXjPdy1FPOuUcf3vqHDZOyCAPIgU/2ZHGxqdQHpb8qEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745910859; c=relaxed/simple;
	bh=R1iEc6dlDjdwj99dlMF/yiHBlnDfG11d/dCI5LRcfeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCmd1ImKzh9awZlJhhx0oWmQorTpx9EMfHY37RQPA61GsQ9p9gpr0bQv6F+upJVfocdOvdgq21cAnqXS0wKzyA/YVRUHyIsbWK6yha5pZGTdxHCJr2tY2E5jig5p43tbzylhawPKNWj+B5aivN6aiPbE4wV+xRYQ947btG/YRkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NZcCLTC+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPj1kDkL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ORKiomuy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3T5S8n0x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C847421CD9;
	Tue, 29 Apr 2025 07:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745910856;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NKQ5Vy/2lL4biLB8Ln85qRNBNIjg7XN05639v86E3No=;
	b=NZcCLTC+kHQn+bg8Al8wiMQI/p+Fgbt0WWrwxGeNan/alW6NWaLVfbvnkhpqYv/hcUSzov
	DDOuej+0C3o4F2/WtvIjAUKTGg5Hb6YWyQH5IZcCL2n8TF3PwmAKk2kfLlBf7oHWWFKH//
	LdJqIamGSi5/sTolgsW3wBYi0y3e0ds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745910856;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NKQ5Vy/2lL4biLB8Ln85qRNBNIjg7XN05639v86E3No=;
	b=DPj1kDkLJQfWYCBdG6O3y89yD8BMidQdYTck4VhXYHEjLqNVIbWXCxUs0M3bNv61ZwNUIV
	VBDgShnrRNEIvdDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745910855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NKQ5Vy/2lL4biLB8Ln85qRNBNIjg7XN05639v86E3No=;
	b=ORKiomuyg+TO2kslGR2Rj4sOLUQA4sxwckTU0q1Cq7falx0I+HcfZH9N0+hOVzVIRnm6Wl
	U0U6fAZI44dRHPk5Ea0WbisVYlNSBCC7mmPKpQJ2IfaJdA28HFimX8J2mgE2RDc3qRP3Um
	1eMNp0E1qhxxHCjXBnOQoFZEQ+hvud8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745910855;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NKQ5Vy/2lL4biLB8Ln85qRNBNIjg7XN05639v86E3No=;
	b=3T5S8n0xXcJ9ssjkjkDD3zPM2wfV2grN8wEZTbqfJBwFd83e9sW+JARxA2gUT3MWbrh7yN
	PDcOddYonxI2iuAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5BB31340C;
	Tue, 29 Apr 2025 07:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XpaCK0d8EGgBbQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 29 Apr 2025 07:14:15 +0000
Date: Tue, 29 Apr 2025 09:14:10 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs: merge btrfs_read_dev_one_super() into
 btrfs_read_disk_super()
Message-ID: <20250429071410.GB18094@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1745802753.git.wqu@suse.com>
 <b251d716c8cd93ee8b9ee32fdd399bd0fff28669.1745802753.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b251d716c8cd93ee8b9ee32fdd399bd0fff28669.1745802753.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon, Apr 28, 2025 at 10:45:51AM +0930, Qu Wenruo wrote:
> We have two functions to read a super block from a block device:
> 
> - btrfs_read_dev_one_super()
>   Exported from disk-io.c
> 
> - btrfs_read_disk_super()
>   Local to volumes.c
> 
> And they have some minor differences:
> 
> - btrfs_read_dev_one_super() uses @copy_num
>   Meanwhile btrfs_read_disk_super() relies on the physical and expected
>   bytenr passed from the caller.
> 
>   To be hoest, the parameter list of btrfs_read_dev_one_super() is more
>   user friendly.
> 
> - btrfs_read_disk_super() makes sure the label is NUL terminated
> 
> We do not need two different functions doing the same job, so merge the
> behavior into btrfs_read_disk_super() by:
> 
> - Remove btrfs_read_dev_one_super()
> 
> - Export btrfs_read_disk_super()
>   The name pairs with btrfs_release_disk_super() perfectly
> 
> - Change the parameter list of btrfs_read_disk_super() to mimic
>   btrfs_read_dev_one_super()
>   All existing callers are calculating the physical address and expected
>   bytenr before calling btrfs_read_disk_super() already.

Nice, I've checked the history, the functions started as code factored
out of other functions and then updated (API and such) to the point when
they're almost the same.

