Return-Path: <linux-btrfs+bounces-10324-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFC69EF40D
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E316C16F2C4
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2024 16:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EDE235C41;
	Thu, 12 Dec 2024 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yg9ynLWi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DtpsOJix";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mdLJNk9d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q0mBfjkF"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DED235C29;
	Thu, 12 Dec 2024 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734021897; cv=none; b=aCrZt3NWU3JEAhtW4EsjlIOl4cJcU3R251z8/KGI9enfpI3BZRt1fYO2hun/lhfSP28O0o1uFTnz8CVWSokYktIDNf9Z1ZRz8eoMznZmtIdXcZmpaawm6JMTdbK/U92MufvkAXSWM9qC2dKNz4Gki04JRAcWDbCTDCLm/EfU364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734021897; c=relaxed/simple;
	bh=M72VblNMgFTZ3CuG79LsNFG2LpvwPzSu8Yd1nBf+duI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgJFH+Re6QBZz98ysZfpr/Riy3zObeB+jWao19VfXtEyBOeV7T/2bTp4qDYzDtX/SzNtk+zDwMTvuRJQNSQxmdZkvZ6eoOmpm5M6s0g3VuH4b1xahALtDxDJtGrMkvYvb8XllZSrNYflfWI2sx+OhT5vop2Wo5a0gLpppVu1ISM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yg9ynLWi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DtpsOJix; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mdLJNk9d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q0mBfjkF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E63671F37C;
	Thu, 12 Dec 2024 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734021888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uTVFn0xhIO+AubnukH/rRLnFWUvbRZjuWu6tEAGBRqc=;
	b=Yg9ynLWikTVIBUxcGs70KHzbOGvVHy45vXTfa7LwoyGMC8pXIC2hIWM9R315tJuoI7A9X6
	pg7p4uQVJHtrtkDHkpRAw2Xy0EO5fDQAANRYzhF1toL1d0WixEMndrZrqICf2Om+SQB8Od
	akQbl41TYRzdL612fW7zwILA3gZ0yKk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734021888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uTVFn0xhIO+AubnukH/rRLnFWUvbRZjuWu6tEAGBRqc=;
	b=DtpsOJix2zqVwUq63SfVCP8NHczUgnMW56MoMQ1QruYgjacTlw/r27MlgeIbdqPYZmh+wi
	r16BkxfiInIamDDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1734021887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uTVFn0xhIO+AubnukH/rRLnFWUvbRZjuWu6tEAGBRqc=;
	b=mdLJNk9dyRSnbBOqzuRFglI+4CKpZ+6KhUFFpwgZAZtAYCcG+e1G93nNgpMIQ9HzDc9tGA
	qVLe93TB4STlh++TEca1tUhk4FoN3/CrpmvM6Z9MnH870VKTKcC/+2sra6YfVSrhCPwHN+
	utIE183UHiexX9RP8t6iOjjVn9vu/Eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1734021887;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uTVFn0xhIO+AubnukH/rRLnFWUvbRZjuWu6tEAGBRqc=;
	b=Q0mBfjkFmfXjLqwEdNZBAkatL14xDh+nIpR2m8RggBoSkx3wUABDgy2qU75oCOWFApbrbe
	u0nb+JhWsmrAE3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C514A13939;
	Thu, 12 Dec 2024 16:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bnrdL/8SW2cZGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 12 Dec 2024 16:44:47 +0000
Date: Thu, 12 Dec 2024 17:44:46 +0100
From: David Sterba <dsterba@suse.cz>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
	Arnd Bergmann <arnd@arndb.de>, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix stack size warning in
 btrfs_test_delayed_refs()
Message-ID: <20241212164446.GW31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20241212153539.1192900-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212153539.1192900-1-arnd@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Thu, Dec 12, 2024 at 04:35:32PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The newly added code has a btrfs_transaction structure on the stack,
> which makes it somewhat too large for 32-bit kernels:
> 
> fs/btrfs/tests/delayed-refs-tests.c: In function 'btrfs_test_delayed_refs':
> fs/btrfs/tests/delayed-refs-tests.c:1012:1: error: the frame size of 1088 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>  1012 | }
>       | ^
> 
> Change this to a dynamic allocation instead.
> 
> Fixes: fa3dda44871b ("btrfs: selftests: add delayed ref self test cases")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, this was fixed last week but was not updated in the branch
pulled by linux-next.

