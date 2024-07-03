Return-Path: <linux-btrfs+bounces-6185-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5007D926C6A
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jul 2024 01:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75C5B21C75
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Jul 2024 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CD5E194124;
	Wed,  3 Jul 2024 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dv/olrNP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0psKOKYt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qYGTZool";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dum7eEjR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA617838D
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Jul 2024 23:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720049193; cv=none; b=nvS0BgViGKkKoBD6CeCVM/X+OuEhWBb4tdHSAKktH/gW/kEuTz/Uoo4g+WHgZB2EezwiwjxIR3FdqjZbB8YMY14NJxF1MVYdLp4OAU9bKIk43+KbQN1YTp7Ccpu2C4oAim+6+zTPC4KNSpD75NVcYQ3+M4Rc29JnlHgJD4VWEnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720049193; c=relaxed/simple;
	bh=jDS6xEKqS3LHztamskypITzdcOG+kL/BVfeyGR8VZdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NuGj3XiSzOQuTj5zvLAywCkfw/asMOoEGJRlqMLOqRkH2jf4A4AkRd/LM5QiM5bhvfYIwsUm8sGzHbA7vulM9hk8al+vkbUpsaknvrKkVVGeOfYCrD4v2zBOPsbMVDZgFvbhLMKgQ6nHp+iisCOv+9RtEp2tw4w/2oIB+dTB0Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dv/olrNP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0psKOKYt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qYGTZool; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dum7eEjR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3DF321BBF;
	Wed,  3 Jul 2024 23:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720049190;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0GDbJnJ898tuZWilzIAcBb3pTsZQu8aDjGJgQ4KTQvk=;
	b=dv/olrNPD9prC/q37Kjk9DRO7ldSx4C+EIXdz9VW3s/c+7uX8mvPGw/ncuTWSKmZ3SFtl7
	BF5OWeDiqUAFT6AZe4remi7sHmzNBAdVGQD3La4CixzQK0EKVOqQvXygHrwYZ7DwK/SNJh
	zXDqHn5yTBmJz8rIv3kiyfny989/JNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720049190;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0GDbJnJ898tuZWilzIAcBb3pTsZQu8aDjGJgQ4KTQvk=;
	b=0psKOKYt33yGYx+ifjm7ZwDYqwVPOFd+JQagkbgpnXFpGSttuWGEhayFHOp/Yu8owH7+az
	ZNoh6xrXTRKw7ZCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qYGTZool;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=dum7eEjR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1720049189;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0GDbJnJ898tuZWilzIAcBb3pTsZQu8aDjGJgQ4KTQvk=;
	b=qYGTZoolvdHxsqHeV+NSf2LgHtAF0NmB+D5rBjMgepJvr/J9Q16FuQQc545Uznoi6YVQYn
	iOPS4VmQ5n2aDn4uKU0qZFh/ZQLIn36zjtabvGa4wemZUIQ8izUJccdiNMy8T8ju/1DZJV
	psqt/8zIRu0A1KM0dZBW1cRFfUc26ao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1720049189;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0GDbJnJ898tuZWilzIAcBb3pTsZQu8aDjGJgQ4KTQvk=;
	b=dum7eEjRxjZBA4b2z0pIkxY0IFJ2b8HjCgEj5oDluDI8ISeYbzmR3Obhr2o+Pkni46gZrv
	yjQKT1TBnnevNCCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C52CD13974;
	Wed,  3 Jul 2024 23:26:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vM2pLyXehWZkSQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 03 Jul 2024 23:26:29 +0000
Date: Thu, 4 Jul 2024 01:26:28 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix bitmap leak when loading free space cache on
 duplicate entry
Message-ID: <20240703232628.GT21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <548b562c2432cbc591b50fad1ea24ae87dd50627.1720017904.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548b562c2432cbc591b50fad1ea24ae87dd50627.1720017904.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: E3DF321BBF
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,suse.com:email];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Wed, Jul 03, 2024 at 03:45:45PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If we failed to link a free space entry because there's already a
> conflicting entry for the same offset, we free the free space entry but
> we don't free the associated bitmap that we had just allocated before.
> Fix that by freeing the bitmap before freeing the entry.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

