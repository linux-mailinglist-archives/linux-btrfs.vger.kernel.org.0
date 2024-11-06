Return-Path: <linux-btrfs+bounces-9370-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EA29BF4B7
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 18:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C7D5B21CE7
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Nov 2024 17:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1402076DF;
	Wed,  6 Nov 2024 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9CFK4o9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMCZIB0C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="u9CFK4o9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MMCZIB0C"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7542076CD
	for <linux-btrfs@vger.kernel.org>; Wed,  6 Nov 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730915954; cv=none; b=YAo7UyMhV1K0drxDPG7A3HGC2LKywneWcvNkfo3+x5VRjRYEsiRjZSXOS504fysI1dm9v94sVshpg2B4THWIVJXEfSFSeUfcL5Faw7+WjfYchSw5VxUPcr5eQKEnY6DtFqGEGc2YHp7YQznzcpKIsvgIHFa3VdrKhYOVEuFlyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730915954; c=relaxed/simple;
	bh=5xZ9rR/XS4lrtpG7viNLHjLyVV6YlMwTM0IH5lkh7A0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LXRu+s7rqSiVHJ9lce/UzCco7FaEYBd+vNMwRALX8abFYqz+SZjOzrA7OcMXR+EOPgpVbEdZYeowkkZKbIwctrvwhiFtwBnrVWo7kkHj8kIXfUdZVaKGXBUE+SGN9Q5HU4rFWAoU3UGokVnXKfS/y6Lb8W4kH8NQd+S0Yx2k0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9CFK4o9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMCZIB0C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=u9CFK4o9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=MMCZIB0C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A859E1FB6B;
	Wed,  6 Nov 2024 17:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730915950;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4EwgZE+0CDONDXZ3iy+Ow1agHWW/jW7lv1Xo+T8MlVw=;
	b=u9CFK4o91vf8daxjrPneT02Kbh/3XfP4gsJ3WTwBwAGG7Z7jAstCiCi95Y127ER6WNacxj
	twfbOFlGYKJNlTbqOmUaDcODU6cpT6FWY6d5M+YYPu8pmmmXT4K8PZmRjwO3fQirmsMv3Q
	NnixogS5jiT4mpmEZk0pBz86NkYZFOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730915950;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4EwgZE+0CDONDXZ3iy+Ow1agHWW/jW7lv1Xo+T8MlVw=;
	b=MMCZIB0C1UvTtqB81sXwpmNPJfA4I6SmYqIFvJZulpfkiXXRUz2NQF+6sEMvH1BrwrxFHK
	o72W0Eaw1ptoW1AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730915950;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4EwgZE+0CDONDXZ3iy+Ow1agHWW/jW7lv1Xo+T8MlVw=;
	b=u9CFK4o91vf8daxjrPneT02Kbh/3XfP4gsJ3WTwBwAGG7Z7jAstCiCi95Y127ER6WNacxj
	twfbOFlGYKJNlTbqOmUaDcODU6cpT6FWY6d5M+YYPu8pmmmXT4K8PZmRjwO3fQirmsMv3Q
	NnixogS5jiT4mpmEZk0pBz86NkYZFOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730915950;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4EwgZE+0CDONDXZ3iy+Ow1agHWW/jW7lv1Xo+T8MlVw=;
	b=MMCZIB0C1UvTtqB81sXwpmNPJfA4I6SmYqIFvJZulpfkiXXRUz2NQF+6sEMvH1BrwrxFHK
	o72W0Eaw1ptoW1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 997F2137C4;
	Wed,  6 Nov 2024 17:59:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6dJEJW6uK2dWfQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 06 Nov 2024 17:59:10 +0000
Date: Wed, 6 Nov 2024 18:59:09 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix warning on PTR_ERR() against NULL device at
 btrfs_control_ioctl()
Message-ID: <20241106175909.GG31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5bbe65395fcb54fd561cc17a705ce6d50d0cc5c0.1730898948.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bbe65395fcb54fd561cc17a705ce6d50d0cc5c0.1730898948.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Nov 06, 2024 at 01:17:39PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Smatch complains about calling PTR_ERR() against a NULL pointer:
> 
>   fs/btrfs/super.c:2272 btrfs_control_ioctl() warn: passing zero to 'PTR_ERR'
> 
> Fix this by calling PTR_ERR() against the device pointer only if it
> contains an error.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

