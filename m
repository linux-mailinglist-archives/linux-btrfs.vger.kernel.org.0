Return-Path: <linux-btrfs+bounces-20178-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A51DBCF9A42
	for <lists+linux-btrfs@lfdr.de>; Tue, 06 Jan 2026 18:23:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 84ACF3030231
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Jan 2026 17:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5F7355042;
	Tue,  6 Jan 2026 17:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Bf4/C7X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7a4E3lTq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Bf4/C7X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7a4E3lTq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD46355034
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Jan 2026 17:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767720222; cv=none; b=UjSAO3+0zelQSlfAS2mwjLMUclWFhWUIc4+vcntswrPkbAOpdFnV3Pv62mRJAbaNg8SPQ2ZPyqp+Sp6RGpRedf5oMTquEKJcQJ8kd88CTQsH3xZzPiDvbcB1agXTCjlZIp5b3uohXbcyZlA8cCylDbkGEI4hjhdsdzu5h7dhJnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767720222; c=relaxed/simple;
	bh=cm8OJxAiDDvUJEpE4LX9BPkQ2VOq2KsemewWCGe5Um4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqDg74qADVTCPbR8zWPwivrLUjb7PB7kAeFbdAENcHjFEgSRKQm4djP8V/o23+6spiN/P8ZgFbRxhLuNRENLJmTdcxXBEkRrbLQMrkkc5D3aHyU2+wIQSQYsuhdgeb6fqaeOhFtV5hsMZXA28Z+b+yj0zOcmtMeUTD7X3eJ06UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Bf4/C7X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7a4E3lTq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Bf4/C7X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7a4E3lTq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC37B5BD01;
	Tue,  6 Jan 2026 17:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767720218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8aKrOWAH6E4iNYclv0DKhasVQR5pu9txavUnXWkKXeI=;
	b=2Bf4/C7X+J+o4sOK4LgEhyuBgN4MuyLpG22W3+Za59+uw/1ZTRJSMeduhOjSY1tHkmRb8J
	s3Z0dum8PsQMIpTbsiGVJtgdTT10zul12mlcQOA88DiJ/iKWveDep4DABTfsE2315WaQmV
	3iM113N+L8Jjqm/eb6AEP17Txhi/JTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767720218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8aKrOWAH6E4iNYclv0DKhasVQR5pu9txavUnXWkKXeI=;
	b=7a4E3lTqbPAhShGQDuChGz+Si5oyjn1F0nm55UhhO+8OJrpSZ0PIZZT+yWMB4XRr6bWRIl
	Dopj4RoU0GW0o9BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2Bf4/C7X";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7a4E3lTq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767720218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8aKrOWAH6E4iNYclv0DKhasVQR5pu9txavUnXWkKXeI=;
	b=2Bf4/C7X+J+o4sOK4LgEhyuBgN4MuyLpG22W3+Za59+uw/1ZTRJSMeduhOjSY1tHkmRb8J
	s3Z0dum8PsQMIpTbsiGVJtgdTT10zul12mlcQOA88DiJ/iKWveDep4DABTfsE2315WaQmV
	3iM113N+L8Jjqm/eb6AEP17Txhi/JTI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767720218;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8aKrOWAH6E4iNYclv0DKhasVQR5pu9txavUnXWkKXeI=;
	b=7a4E3lTqbPAhShGQDuChGz+Si5oyjn1F0nm55UhhO+8OJrpSZ0PIZZT+yWMB4XRr6bWRIl
	Dopj4RoU0GW0o9BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92BDA3EA63;
	Tue,  6 Jan 2026 17:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z6OlIxpFXWnBEwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Jan 2026 17:23:38 +0000
Date: Tue, 6 Jan 2026 18:23:29 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tests: fix return 0 on rmap test failure
Message-ID: <20260106172329.GE21071@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260105081905.993994-1-naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105081905.993994-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: AC37B5BD01
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Level: 

On Mon, Jan 05, 2026 at 05:19:05PM +0900, Naohiro Aota wrote:
> In test_rmap_blocks(), we have ret = 0 before checking the results. We need
> to set it to -EINVAL, so that a mismatching result will return -EINVAL not
> 0.
> 
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> ---
>  fs/btrfs/tests/extent-map-tests.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/btrfs/tests/extent-map-tests.c b/fs/btrfs/tests/extent-map-tests.c
> index 0b9f25dd1a68..6bad0c995177 100644
> --- a/fs/btrfs/tests/extent-map-tests.c
> +++ b/fs/btrfs/tests/extent-map-tests.c
> @@ -1057,6 +1057,8 @@ static int test_rmap_block(struct btrfs_fs_info *fs_info,
>  		goto out;
>  	}
>  
> +	ret = -EINVAL;

The pattern we use is to set the return right before the 'goto', so I've
changed it in for-next. Thanks.

