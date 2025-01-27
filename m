Return-Path: <linux-btrfs+bounces-11086-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D503DA1DBDE
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 19:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AA218888EA
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jan 2025 18:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8CB18C011;
	Mon, 27 Jan 2025 18:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NCk8Lc1I";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B+4oXGmB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eqtMvT/n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QOgLW4kV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A02B142905
	for <linux-btrfs@vger.kernel.org>; Mon, 27 Jan 2025 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738001313; cv=none; b=UgrHE8ZHHlPo/BRf5kKR7fekK/hGXY6xuZmj4C4cGuXnDZfvaF1t1kxvaq/C+zygjbHMNtDhCMYvj/wkMRU3e4Gs+ZS191QaiVxdiFdzPq3aoQWpikCICe+LeXiN5seRYesj4rGmWiV5ZUQ/M5aK1tfgsogaNHgGzTx4h1yFdw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738001313; c=relaxed/simple;
	bh=SiYuobE+mOOa/enLr3MFmmVeUyEHlBiXYfFSOoAXSaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAHHJvgKmTwpXRJwJq/i8Te/oWYicQ5SwBydbp+rrf5zhVuEU9lTUl3RrRXrvBYBWHkEuNgm6LzhzAMQWRrQuIm+diNkm8EpekFEoZfk7AbHqpfXvoVhsj1y4h194YoLCLI/wI7dKDhUowPxP8MD1iJigaNlUWwKpFaO2LzvKOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NCk8Lc1I; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B+4oXGmB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eqtMvT/n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QOgLW4kV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F0E30210F3;
	Mon, 27 Jan 2025 18:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738001309;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXWNxhhm3m+dEwGBESAqDWOCAAf1KJ+NIQPtjY0F3gc=;
	b=NCk8Lc1I0UtaSmf8EVxA/CjQEKdd3s534ge6g7Ss+Rr5bxzH74iN34ONTtdhZTOZ73CEfA
	taKLFxhdRIiXvfJtIDiYtaOA+3efsq+/r9axlFv57WafV3/cA8WnntEuQCqsMyZ09PstT3
	GB38PpXk2n4XiFcYFOKnDwGL5vnTlus=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738001309;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXWNxhhm3m+dEwGBESAqDWOCAAf1KJ+NIQPtjY0F3gc=;
	b=B+4oXGmBHugdfX1dq/wqnBoj74L+176tgRHf6KBW5YqcSCS3FL6F1jZ2b6S3hFP4EHK3VJ
	cIlYiejsl/IVaSDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="eqtMvT/n";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QOgLW4kV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1738001308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXWNxhhm3m+dEwGBESAqDWOCAAf1KJ+NIQPtjY0F3gc=;
	b=eqtMvT/nGU3d4Pme5QehQ1GuVuuMxJispQnwBlIUELLHlwO/EG2p+OLnxzeJ/sSH+Qk1qA
	48dDU5BwD9ZaD0LizuNp38YiIAJYQAC4RxX2TSatURrQP3Y8K9pX09VCpK7Trxd3+gD1Xb
	aEdj4LMEVklDyepmRGGDK1ts9Tk9Ev4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1738001308;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FXWNxhhm3m+dEwGBESAqDWOCAAf1KJ+NIQPtjY0F3gc=;
	b=QOgLW4kVOoJ1iOe5jBG/PGVGfyg9NeMO+wwJVgDuH5eVewWOktGUWNhkaCgiW7bu8oxeb5
	gDspuO0ofHl/MjDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBA06137C0;
	Mon, 27 Jan 2025 18:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wtttMZzLl2cLDgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 27 Jan 2025 18:08:28 +0000
Date: Mon, 27 Jan 2025 19:08:27 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com
Subject: Re: [PATCH] btrfs: sysfs: accept size suffixes for read policy values
Message-ID: <20250127180827.GR5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8f77c6490a181cb0bb16c6b11131723e46c41108.1737566842.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f77c6490a181cb0bb16c6b11131723e46c41108.1737566842.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: F0E30210F3
X-Spam-Score: -4.21
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Jan 23, 2025 at 01:30:34AM +0800, Anand Jain wrote:
> We now parse human-friendly size values (e.g. '1G', '2M') when setting
> read policies.
> 
> Suggested-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
> Note that only read_policy accepts these suffixed values - show() displays
> values without suffixes, consistent with other sysfs knobs like chunk_size.

Yeah, the input format is for convenience, the output in sysfs files
shold be consistent as it's expected to be processed by scripts so the
formatting to suffixed values should be done there if needed.

Reviewed-by: David Sterba <dsterba@suse.com>

> 
>  fs/btrfs/sysfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 53b846d99ece..66aac3aae2e9 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1342,17 +1342,17 @@ int btrfs_read_policy_to_enum(const char *str, s64 *value_ret)
>  	/* Separate value from input in policy:value format. */
>  	value_str = strchr(param, ':');
>  	if (value_str) {
> -		int ret;
> +		char *retptr;
>  
>  		*value_str = 0;
>  		value_str++;
>  		if (!value_ret)
>  			return -EINVAL;
> -		ret = kstrtos64(value_str, 10, value_ret);
> -		if (ret)
> +
> +		*value_ret = memparse(value_str, &retptr);
> +		retptr = skip_spaces(retptr);

The other places that do skip_space() have a comment why it's there, so
also add it here.

