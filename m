Return-Path: <linux-btrfs+bounces-10695-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A4E9FFE25
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 19:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FE30188356C
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jan 2025 18:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5417A1891AB;
	Thu,  2 Jan 2025 18:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g27u6M75";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u15KpZUn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g27u6M75";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u15KpZUn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A248F66
	for <linux-btrfs@vger.kernel.org>; Thu,  2 Jan 2025 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735842573; cv=none; b=B1495bwNOzwVlzhiC0h1me/GJ9IqQiRXyIFSZSc50RJhOZRz/TwQ0AIHCXu+GaVKJCsmo4GvpZM6nLkIBYkG3xzzr8dTjvn8cc7pn73Ct8uuKTlzQdRsQjcSPTj6qVZjJKo5vGSmS+TcY7rA/YrbEfLp3sbqKCcQs+a2ElZqXdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735842573; c=relaxed/simple;
	bh=vzLZCLXaL8zx1on/hRu+S8C0MUv1dNOx/jx3pMH5J6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBBFNI+NRvdbOyEYuQaRJhHg7uQZpyOX22Vzq7OryKtrjvCNIq1MRfQPLOdAl4VjyvgRk+9Myi/H9S2X5p07UKJjUr1QKBBoBg60+Cic6HjiBAui0ztMH+9o1EcY6W6VvQv0FczwQj4+po55u3azvxvBDGwUUAh52eA90WkmAxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g27u6M75; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u15KpZUn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g27u6M75; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u15KpZUn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 90C9421162;
	Thu,  2 Jan 2025 18:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735842569;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJgt4Xwqu7hox/2qTpb3iFGRzXP6ljF7ZUI6UBL9gSU=;
	b=g27u6M75Mc9SFHH7aDPI6158HBxYJV8C5yB1tuCrUCx7qSB2JsD0jdA6rIFzLYjToxvkoX
	z8+voCHxgc2jsA8sMy9tJdqQpmMk14hSX5bvn8y3+jwp9VPB21nfz5VJWufhPY8L/MwrQ/
	aokkKMYUTFKYjCG18Zr7indVlrOIe3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735842569;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJgt4Xwqu7hox/2qTpb3iFGRzXP6ljF7ZUI6UBL9gSU=;
	b=u15KpZUnJVHoGf/xtFW4Vwuim4EJ4Fon4nXxioL/QOVJu962T7Y70/xluKzD6pFQoAZ2hQ
	aTrX+eHh9fW4tJCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=g27u6M75;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=u15KpZUn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1735842569;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJgt4Xwqu7hox/2qTpb3iFGRzXP6ljF7ZUI6UBL9gSU=;
	b=g27u6M75Mc9SFHH7aDPI6158HBxYJV8C5yB1tuCrUCx7qSB2JsD0jdA6rIFzLYjToxvkoX
	z8+voCHxgc2jsA8sMy9tJdqQpmMk14hSX5bvn8y3+jwp9VPB21nfz5VJWufhPY8L/MwrQ/
	aokkKMYUTFKYjCG18Zr7indVlrOIe3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1735842569;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bJgt4Xwqu7hox/2qTpb3iFGRzXP6ljF7ZUI6UBL9gSU=;
	b=u15KpZUnJVHoGf/xtFW4Vwuim4EJ4Fon4nXxioL/QOVJu962T7Y70/xluKzD6pFQoAZ2hQ
	aTrX+eHh9fW4tJCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79F6E13418;
	Thu,  2 Jan 2025 18:29:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Lk6JHQnbdmdHSwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 02 Jan 2025 18:29:29 +0000
Date: Thu, 2 Jan 2025 19:29:20 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org, dsterba@suse.com, Naohiro.Aota@wdc.com,
	wqu@suse.com, hrx@bupt.moe, waxhead@dirtcellar.net
Subject: Re: [PATCH v5 04/10] btrfs: handle value associated with raid1
 balancing parameter
Message-ID: <20250102182920.GR31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1735748715.git.anand.jain@oracle.com>
 <6a303a3da8116c3743fa9be605dde540d8a60f1a.1735748715.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a303a3da8116c3743fa9be605dde540d8a60f1a.1735748715.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 90C9421162
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Thu, Jan 02, 2025 at 02:06:33AM +0800, Anand Jain wrote:
> This change enables specifying additional configuration values alongside
> the raid1 balancing / read policy in a single input string.
> 
> Updated btrfs_read_policy_to_enum() to parse and handle a value associated
> with the policy in the format `policy:value`, the value part if present is
> converted 64-bit integer. Update btrfs_read_policy_store() to accommodate
> the new parameter.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/sysfs.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 3b0325259c02..cf6e5322621f 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1307,15 +1307,26 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
>  
>  static const char * const btrfs_read_policy_name[] = { "pid" };
>  
> -static int btrfs_read_policy_to_enum(const char *str)
> +static int btrfs_read_policy_to_enum(const char *str, s64 *value)
>  {
>  	char param[32] = {'\0'};
> +	char *__maybe_unused value_str;
>  
>  	if (!str || strlen(str) == 0)
>  		return 0;
>  
>  	strncpy(param, str, sizeof(param) - 1);
>  
> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +	/* Separate value from input in policy:value format. */
> +	if ((value_str = strchr(param, ':'))) {
> +		*value_str = '\0';
> +		value_str++;
> +		if (value && kstrtou64(value_str, 10, value) != 0)
> +			return -EINVAL;

I think I've mentioned that before, this lacks validation of the
'value', there should be some lower and upper bound check. Minimum can
be the sectorsize and maximum maybe 1G or 2G, so the u32 type is
sufficient. The silent conversion from u64 to s64 should be avoided.

