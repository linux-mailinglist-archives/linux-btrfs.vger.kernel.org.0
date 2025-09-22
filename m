Return-Path: <linux-btrfs+bounces-17053-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C34B8FF97
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 12:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E7923BF6DA
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Sep 2025 10:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE0E2877D5;
	Mon, 22 Sep 2025 10:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TSpjbS0J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iNj8xbol";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TSpjbS0J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="iNj8xbol"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863B3EA8D
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Sep 2025 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536489; cv=none; b=KXjDa3npea/gBR0gfBtuFw2nQZtwZXZgatbPUxsy6QmTmZScV1mIq9UinqTCOvBQHSPrJ/gYnAF3elAL5WWU6bc6F4a/DN+5/3Idp1JNY8pqdBEo3dmB7VEtpYbNqyz39C76zmndVjjDKPidINi8nAvxbBHaSe0e/ib0IymB/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536489; c=relaxed/simple;
	bh=UVu32OlRoaIz0pOSGXoPsiuuuF00jqNY7+DGWHAoeTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at0f2fiQIlzOjzjvlOGkcqv50PvgunAF/PwVEXyEEmHNwjqEJi24dyzxxEdziGDPlZVgdWzLEEGOtI+ZgajgkwgQVgtt5HYismJG1BaF9lsGXqRlbl2ShiUkSYQ8UIJoKpw5UfMuIIrhHSCvzts7beaDQruoel9GTuC8aqNxM64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TSpjbS0J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iNj8xbol; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TSpjbS0J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=iNj8xbol; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B68E2258A;
	Mon, 22 Sep 2025 10:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758536486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V+L2NsH5f+qct2ris/ncnb0gjiDQuXUCZWpl93Xs6Bg=;
	b=TSpjbS0JVPxyVtThWtU4vVu/+9VgcR7JDeV39sN6SGVqHSF9mMsT91fAdNyrQPsNU2r5TJ
	dLqmLKB3iKaqnfqNUPW7i3wKkwzg0T49097rK/xsSuZry9InuAYFXxlWfLMZcCiJrOzMrJ
	Llzg4H7BUK17y+p+rrsFQnrlb/S3kCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758536486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V+L2NsH5f+qct2ris/ncnb0gjiDQuXUCZWpl93Xs6Bg=;
	b=iNj8xbolF1lpZRiJlGqGbFlMJBYuLem1tgrDjtXXKS9A7mKBW2xpgotasiR7oK0VcEgXet
	Zc78qKZAcuOrlrCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1758536486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V+L2NsH5f+qct2ris/ncnb0gjiDQuXUCZWpl93Xs6Bg=;
	b=TSpjbS0JVPxyVtThWtU4vVu/+9VgcR7JDeV39sN6SGVqHSF9mMsT91fAdNyrQPsNU2r5TJ
	dLqmLKB3iKaqnfqNUPW7i3wKkwzg0T49097rK/xsSuZry9InuAYFXxlWfLMZcCiJrOzMrJ
	Llzg4H7BUK17y+p+rrsFQnrlb/S3kCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1758536486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V+L2NsH5f+qct2ris/ncnb0gjiDQuXUCZWpl93Xs6Bg=;
	b=iNj8xbolF1lpZRiJlGqGbFlMJBYuLem1tgrDjtXXKS9A7mKBW2xpgotasiR7oK0VcEgXet
	Zc78qKZAcuOrlrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E7EF13A63;
	Mon, 22 Sep 2025 10:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sCsvCyYj0WjnOgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 22 Sep 2025 10:21:26 +0000
Date: Mon, 22 Sep 2025 12:21:25 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 9/9] btrfs: enable experimental bs > ps support
Message-ID: <20250922102124.GK5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1758494326.git.wqu@suse.com>
 <018a9a3216ac9a4d79562105ea10727cec23e8ed.1758494327.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <018a9a3216ac9a4d79562105ea10727cec23e8ed.1758494327.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Mon, Sep 22, 2025 at 08:10:51AM +0930, Qu Wenruo wrote:
> +	if (fs_info->sectorsize > PAGE_SIZE) {
> +		ret = -ENOTTY;

I did a minor fixup of the error code to -EOPNOTSUPP, which means the
ioctl exists but a particular mode or option combination is not
supported. The -ENOTTY is for the case wher the ioctl does not exist at
all, and for completeness -EINVAL is for a valid mode but invalid
parameters.

> +		goto out_acct;
> +	}

