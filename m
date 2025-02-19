Return-Path: <linux-btrfs+bounces-11599-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB4DA3CC23
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 23:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D053BB2BC
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Feb 2025 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4624A2580FF;
	Wed, 19 Feb 2025 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1HjKe/NU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UiD5BuS3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CbwibeL8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+wJM+fIk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF832580ED
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Feb 2025 22:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740003220; cv=none; b=cqpvKhA641Mj4sbue6mRPpzvAEqh2kEHKOOrNwHhb+JMcBDsfBry3BDF/QycNABkN0fn0KxFydadjcYXl+W4+Q3AAcMxKdfAG56U0JJ5UKphBgnf3dMwFJ21OzseSs4QHLgZLSRBLM8OCIpExGiJppnUL4re3yx2KtuL+c2CnXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740003220; c=relaxed/simple;
	bh=qas4ElJ3/T+rj8l6STC0RoTJtNQd5/YdGSzzg+Fkkwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EX5bwRdgik3yy4u1dOmPzlxcs7ANF70b7obm/CxGfpOmBEoixjbsE2+4JrRST9haDVsea6qOuwwKWBEV1Ekc/sM8BG2gZcdDeHejEDVfvbN8ihMadeuzoTcfjcoIDGWJj5sZwvEKQ57VbzolfD6/fC0tyU1ZwzXDlMxOoq4w4D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1HjKe/NU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UiD5BuS3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CbwibeL8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+wJM+fIk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF3E7210F8;
	Wed, 19 Feb 2025 22:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740003217;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MygALCtNbZldASbrMQj7gYcvDbgNhwZWj2UgMk7DESw=;
	b=1HjKe/NUFAKacabEG1vpeWDjr+x0tR7fhXxe9QgFSiN0fPuYhA93mjQ3mHvpbRCRXaEVil
	UyZgQtpNEb2iW3U87leFKYWeWQLZpjxO2ycOFllPW7WNzs0zwYFqEP5LgzCb1q/ksyK81R
	OtxdZ6f5/AKNFbha4L6nQ42Hpdo37jY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740003217;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MygALCtNbZldASbrMQj7gYcvDbgNhwZWj2UgMk7DESw=;
	b=UiD5BuS3FDv6EmEHghq9TQxfKtFUCgpO8u4sgeN8Y9PHQiuSCojRQOJGrBFrHhIJI4xwFY
	4jinurrNNVYa4dAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740003215;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MygALCtNbZldASbrMQj7gYcvDbgNhwZWj2UgMk7DESw=;
	b=CbwibeL8tpp9gURAetmXIS75KIeWRsyP4eW08Mw6Bpk0RUezGhn3mshcy4xrq0F5sdzJh3
	Ukq/guuC7R4pGs7Ykqw3KI4AQS/QW7ndZ5R8DA/MrBfKsBZf80TuReYTB/0G0wA8doS5sk
	CS5CiZjgrs8y5osx19soL+7ybljD1ZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740003215;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MygALCtNbZldASbrMQj7gYcvDbgNhwZWj2UgMk7DESw=;
	b=+wJM+fIkmjn4fYrZnRY1BbfjFTHRxaGTmXWsW0vdwLvGeLW9hvZNovmmUIRlrFz1boLrQi
	jqVZEM6Er28I2IAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF27D13715;
	Wed, 19 Feb 2025 22:13:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xiFDNo9XtmdvMgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Feb 2025 22:13:35 +0000
Date: Wed, 19 Feb 2025 23:13:34 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH 0/2] fstests: a couple fixes for btrfs/254
Message-ID: <20250219221334.GG5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1739989076.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739989076.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Feb 19, 2025 at 06:19:13PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fixes for btrfs/254, details in the change logs.
> 
> Filipe Manana (2):
>   btrfs/254: don't leave mount on test fs in case of failure/interruption
>   btrfs/254: fix test failure in case scratch devices are larger than 50G

Reviewed-by: David Sterba <dsterba@suse.com>

