Return-Path: <linux-btrfs+bounces-10747-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5EA02848
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 15:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598EC3A3029
	for <lists+linux-btrfs@lfdr.de>; Mon,  6 Jan 2025 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B670E35973;
	Mon,  6 Jan 2025 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JyGtjzOZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ciUuWVqH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JyGtjzOZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ciUuWVqH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D8923A6
	for <linux-btrfs@vger.kernel.org>; Mon,  6 Jan 2025 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174523; cv=none; b=LVYojrI0eAuIeI0HD0ab1Mu3mvz3ypB8AMa5IdiN0Oguh3s5qZGY0OTpS4oIULXabLDCPfdp3hWb3fI9nPI05/YVzAGQVJKK3vVdvs9nX9POXI5AeIyQ6+88ZJZTxlddngFh7Peoq9ATpWbuu8HToY3Tdeb7GxV0RfkmU/M+k3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174523; c=relaxed/simple;
	bh=dSPf9WFu3WOmkce0PfNWt+mu2Fw7FCjrknnxq6bFQQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzqwUTvYdw1hhErmMlf4GP3QyAo8Y7cEy60HL47fuN8ZjK4KzUuOFWWMwoRdhQ+VdF2xtMeg2xeZjiX10O4sftvHdI7C1fGP3kH5YNJVmRqSPwV9GTD/QU1HfSw4NAYs/XiZs3ZvP0CXEWdmBbrZ0dMJ5hUlylSvQbaIeGpf1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JyGtjzOZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ciUuWVqH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JyGtjzOZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ciUuWVqH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B2751F441;
	Mon,  6 Jan 2025 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736174520;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2bGZNT4qWeuorxTZmFSrNI6tozcWqUhPNndg1G7K9k=;
	b=JyGtjzOZlNZX8SR7Fby4NDa66RpIrHdSFRGrxmoB752f3YNalG8v3ndDwWsHA5WGdSW696
	l6OeAqas1MFkOb5jMAjpNtAoZQvcbmAxqf+TbLECYNcR3HgnynZTEUJxeqpK2t8j9Igu+F
	783iY+xiFPdaGK5gK9SOz5UhKJmzrCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736174520;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2bGZNT4qWeuorxTZmFSrNI6tozcWqUhPNndg1G7K9k=;
	b=ciUuWVqH34ud4pBS2KP6Wvy+C6sE0/Mq1oAsDORbxjEuIHQR3N4jnbfJHk/bl+/3GHptic
	SGJBqG9xj2M24XDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JyGtjzOZ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ciUuWVqH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736174520;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2bGZNT4qWeuorxTZmFSrNI6tozcWqUhPNndg1G7K9k=;
	b=JyGtjzOZlNZX8SR7Fby4NDa66RpIrHdSFRGrxmoB752f3YNalG8v3ndDwWsHA5WGdSW696
	l6OeAqas1MFkOb5jMAjpNtAoZQvcbmAxqf+TbLECYNcR3HgnynZTEUJxeqpK2t8j9Igu+F
	783iY+xiFPdaGK5gK9SOz5UhKJmzrCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736174520;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k2bGZNT4qWeuorxTZmFSrNI6tozcWqUhPNndg1G7K9k=;
	b=ciUuWVqH34ud4pBS2KP6Wvy+C6sE0/Mq1oAsDORbxjEuIHQR3N4jnbfJHk/bl+/3GHptic
	SGJBqG9xj2M24XDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 056A7137DA;
	Mon,  6 Jan 2025 14:42:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cS/OALjre2f2PQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 06 Jan 2025 14:42:00 +0000
Date: Mon, 6 Jan 2025 15:41:50 +0100
From: David Sterba <dsterba@suse.cz>
To: "Roger L. Beckermeyer III" <beckerlee3@gmail.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: implement percpu_counter for ENOSPC rework
Message-ID: <20250106144150.GZ31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <55bd9fed5b767365c633bf9aeaed49d335c9498e.1735508254.git.beckerlee3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55bd9fed5b767365c633bf9aeaed49d335c9498e.1735508254.git.beckerlee3@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 1B2751F441
X-Spam-Level: 
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21
X-Spam-Flag: NO

On Sun, Dec 29, 2024 at 03:40:20PM -0600, Roger L. Beckermeyer III wrote:
> implements percpu_counter bytes_may_use_percpu in btrfs_space_info. Adds
> 2 functions to DECLARE_SPACE_INFO_UPDATE as well as some logic, enabling
> the percpu counter to keep track of all bytes added to "bytes_may_use".
> Also catching any errors as they may occur.

This repeats what the code lines do, in this case it's not useful. We
need to know what changes in the ENOSPC logic, why the change is made
and/or anything else that explains the commmit.

> This commit is the first for this rework:
> https://github.com/btrfs/btrfs-todo/issues/53

You can keep the link but need to copy what's description or task
implemented. The commit should be standalone and self explanatory.
> 
> Signed-off-by: Roger L. Beckermeyer III <beckerlee3@gmail.com>
> ---
>  fs/btrfs/space-info.h | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/space-info.h b/fs/btrfs/space-info.h
> index a96efdb5e681..47e74db045d1 100644
> --- a/fs/btrfs/space-info.h
> +++ b/fs/btrfs/space-info.h
> @@ -11,6 +11,7 @@
>  #include <linux/wait.h>
>  #include <linux/rwsem.h>
>  #include "volumes.h"
> +#include <linux/percpu_counter.h>

Please move this before the "..." includes.

>  struct btrfs_fs_info;
>  struct btrfs_block_group;
> @@ -112,6 +113,7 @@ struct btrfs_space_info {
>  				   current allocations */
>  	u64 bytes_may_use;	/* number of bytes that may be used for
>  				   delalloc/allocations */
> +	struct percpu_counter bytes_may_use_percpu;

New members should come with comments.

>  	u64 bytes_readonly;	/* total bytes that are read only */
>  	u64 bytes_zone_unusable;	/* total bytes that are unusable until
>  					   resetting the device zone */
> @@ -228,6 +230,21 @@ static inline bool btrfs_mixed_space_info(const struct btrfs_space_info *space_i
>  		(space_info->flags & BTRFS_BLOCK_GROUP_DATA));
>  }
>  
> +static inline void bmu_counter_increment(struct btrfs_space_info *sinfo, s64 bytes)

This does not look like a small function that would should be 'static
inline'. The prefix "bmu_" has no meaning in btrfs so far, so please
rename the helper.

> +{
> +	u64 percpu_sum;
> +
> +	if (percpu_counter_initialized(&sinfo->bytes_may_use_percpu))
> +		percpu_counter_init(&sinfo->bytes_may_use_percpu, 0, GFP_KERNEL);
> +	percpu_counter_add(&sinfo->bytes_may_use_percpu, bytes);
> +	percpu_sum = percpu_counter_sum(&sinfo->bytes_may_use_percpu);
> +	if (percpu_sum != sinfo->bytes_may_use) {
> +		btrfs_err(sinfo->fs_info,
> +		       "btrfs: bytes_may_use counter not equal percpu_counter_sum: %llu regular_sum: %llu",

The btrfs_* message helpers add a prefix, so no need to write "btrfs: "

> +		       percpu_sum, sinfo->bytes_may_use);
> +	}
> +}
> +
>  /*
>   *
>   * Declare a helper function to detect underflow of various space info members
> @@ -239,6 +256,8 @@ btrfs_space_info_update_##name(struct btrfs_space_info *sinfo,		\
>  {									\
>  	struct btrfs_fs_info *fs_info = sinfo->fs_info;			\
>  	const u64 abs_bytes = (bytes < 0) ? -bytes : bytes;		\
> +	char *name = #name;						\
> +	char *name2 = "bytes_may_use";					\
>  	lockdep_assert_held(&sinfo->lock);				\
>  	trace_update_##name(fs_info, sinfo, sinfo->name, bytes);	\
>  	trace_btrfs_space_reservation(fs_info, trace_name,		\
> @@ -247,10 +266,16 @@ btrfs_space_info_update_##name(struct btrfs_space_info *sinfo,		\
>  	if (bytes < 0 && sinfo->name < -bytes) {			\
>  		WARN_ON(1);						\
>  		sinfo->name = 0;					\
> +		if (name == name2) {					\

Is this really meant to compare the raw pointers or should it be
strcmp()? Linker will most likely merge the strings to one so the
address will be the same in the end by writing it like that without any
explanation is quite confusing.

> +			percpu_counter_init(				\
> +			&sinfo->bytes_may_use_percpu, 0, GFP_KERNEL);   \
> +		}							\
>  		return;							\
>  	}								\
>  	sinfo->name += bytes;						\
> -}
> +	if (name == name2)						\

Same comment.

> +		bmu_counter_increment(sinfo, bytes);			\
> +}									\
>  
>  DECLARE_SPACE_INFO_UPDATE(bytes_may_use, "space_info");
>  DECLARE_SPACE_INFO_UPDATE(bytes_pinned, "pinned");
> -- 
> 2.45.2
> 

