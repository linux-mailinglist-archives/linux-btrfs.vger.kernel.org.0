Return-Path: <linux-btrfs+bounces-17630-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C2344BCD865
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 16:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A9DB4FD93A
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Oct 2025 14:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7202F60DB;
	Fri, 10 Oct 2025 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GZdokZo7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XVmDu9ns";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GZdokZo7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XVmDu9ns"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00642F5472
	for <linux-btrfs@vger.kernel.org>; Fri, 10 Oct 2025 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106401; cv=none; b=mOhgdYHtgtg9Kx6mnWvqchA2s6EWQLtf5dvue5eVXRXSxCiBs0PtKTRgks/irQfg8FIeM5hpkzDLHYHEM/G8C5/gs5X2jyuohyYxsgMdmXciMhnoEjvyhP3gFijiyGqhamc7Sb/f2+yaX0iC4+Uo8fdx6dUFJGbs26we9QT+tJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106401; c=relaxed/simple;
	bh=EAGKzeWFK6Rvla84CpgJ7TtxIMtU8eEVdzCirftxC7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAonyqiHNisuzH+MGt87X59XSaw6pLt3eTGgctuk/i5AuGLinN0oe4nNPHHIMKa1V/gOAr1UZMyfa7hdB3t/G/woR9axrvNPSjmVMuJ3dSnWzPUlkvxlZY/DTbTpCPvJQFnY4cp6iyv6n9yAS+QdzxVFMJrb/PeX5JM7ZzjtXKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GZdokZo7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XVmDu9ns; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GZdokZo7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XVmDu9ns; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 390A01F750;
	Fri, 10 Oct 2025 14:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760106397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9zgUyLtNUocIqfix1vBYQNDPaPx29iYiPdy/4thGBw=;
	b=GZdokZo7sbljF/OjKOz1p0+7d5P3n49wSmdUBt3MYIfuZxXYoifyYt561whm37vxf2dIrY
	IwgXQtKcELfEyGeOGPo+vkBf+iQg3lW8ejg58orc/kWMjo+SoWkyoniavk4aVwMIxS1ihk
	3Bcm2uoCAPCKdF9jhYrLDbXRkspwfm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760106397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9zgUyLtNUocIqfix1vBYQNDPaPx29iYiPdy/4thGBw=;
	b=XVmDu9nsXt+kGgNV8sJCIXhXk+vy9ibaReSXnmdftIhaIbIFTGkKk4Q9xBiQju7+awo4hx
	jDQL6DwICn+jq3Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760106397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9zgUyLtNUocIqfix1vBYQNDPaPx29iYiPdy/4thGBw=;
	b=GZdokZo7sbljF/OjKOz1p0+7d5P3n49wSmdUBt3MYIfuZxXYoifyYt561whm37vxf2dIrY
	IwgXQtKcELfEyGeOGPo+vkBf+iQg3lW8ejg58orc/kWMjo+SoWkyoniavk4aVwMIxS1ihk
	3Bcm2uoCAPCKdF9jhYrLDbXRkspwfm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760106397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9zgUyLtNUocIqfix1vBYQNDPaPx29iYiPdy/4thGBw=;
	b=XVmDu9nsXt+kGgNV8sJCIXhXk+vy9ibaReSXnmdftIhaIbIFTGkKk4Q9xBiQju7+awo4hx
	jDQL6DwICn+jq3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BC5A13A40;
	Fri, 10 Oct 2025 14:26:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RSfFBp0X6Wg3FQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Oct 2025 14:26:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47F36A0A58; Fri, 10 Oct 2025 16:26:36 +0200 (CEST)
Date: Fri, 10 Oct 2025 16:26:36 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com, 
	kernel-team@fb.com, amir73il@gmail.com, linux-btrfs@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org
Subject: Re: [PATCH v7 14/14] fs: make plain ->i_state access fail to compile
Message-ID: <bobilrgg7mzfjele6ylmlptpwhudmmqkienkqfknwmet3hdzwn@gwkzfvpjmum3>
References: <20251009075929.1203950-1-mjguzik@gmail.com>
 <20251009075929.1203950-15-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009075929.1203950-15-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,vger.kernel.org,toxicpanda.com,fb.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu 09-10-25 09:59:28, Mateusz Guzik wrote:
> ... to make sure all accesses are properly validated.
> 
> Merely renaming the var to __i_state still lets the compiler make the
> following suggestion:
> error: 'struct inode' has no member named 'i_state'; did you mean '__i_state'?
> 
> Unfortunately some people will add the __'s and call it a day.
> 
> In order to make it harder to mess up in this way, hide it behind a
> struct. The resulting error message should be convincing in terms of
> checking what to do:
> error: invalid operands to binary & (have 'struct inode_state_flags' and 'int')
> 
> Of course people determined to do a plain access can still do it, but
> nothing can be done for that case.
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/fs.h | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 77b6486dcae7..21c73df3ce75 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -785,6 +785,13 @@ enum inode_state_flags_enum {
>  #define I_DIRTY (I_DIRTY_INODE | I_DIRTY_PAGES)
>  #define I_DIRTY_ALL (I_DIRTY | I_DIRTY_TIME)
>  
> +/*
> + * Use inode_state_read() & friends to access.
> + */
> +struct inode_state_flags {
> +	enum inode_state_flags_enum __state;
> +};
> +
>  /*
>   * Keep mostly read-only and often accessed (especially for
>   * the RCU path lookup and 'stat' data) fields at the beginning
> @@ -843,7 +850,7 @@ struct inode {
>  #endif
>  
>  	/* Misc */
> -	enum inode_state_flags_enum i_state;
> +	struct inode_state_flags i_state;
>  	/* 32-bit hole */
>  	struct rw_semaphore	i_rwsem;
>  
> @@ -909,19 +916,19 @@ struct inode {
>   */
>  static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
>  {
> -	return READ_ONCE(inode->i_state);
> +	return READ_ONCE(inode->i_state.__state);
>  }
>  
>  static inline enum inode_state_flags_enum inode_state_read(struct inode *inode)
>  {
>  	lockdep_assert_held(&inode->i_lock);
> -	return inode->i_state;
> +	return inode->i_state.__state;
>  }
>  
>  static inline void inode_state_set_raw(struct inode *inode,
>  				       enum inode_state_flags_enum flags)
>  {
> -	WRITE_ONCE(inode->i_state, inode->i_state | flags);
> +	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state | flags);
>  }
>  
>  static inline void inode_state_set(struct inode *inode,
> @@ -934,7 +941,7 @@ static inline void inode_state_set(struct inode *inode,
>  static inline void inode_state_clear_raw(struct inode *inode,
>  					 enum inode_state_flags_enum flags)
>  {
> -	WRITE_ONCE(inode->i_state, inode->i_state & ~flags);
> +	WRITE_ONCE(inode->i_state.__state, inode->i_state.__state & ~flags);
>  }
>  
>  static inline void inode_state_clear(struct inode *inode,
> @@ -947,7 +954,7 @@ static inline void inode_state_clear(struct inode *inode,
>  static inline void inode_state_assign_raw(struct inode *inode,
>  					  enum inode_state_flags_enum flags)
>  {
> -	WRITE_ONCE(inode->i_state, flags);
> +	WRITE_ONCE(inode->i_state.__state, flags);
>  }
>  
>  static inline void inode_state_assign(struct inode *inode,
> @@ -962,7 +969,7 @@ static inline void inode_state_replace_raw(struct inode *inode,
>  					   enum inode_state_flags_enum setflags)
>  {
>  	enum inode_state_flags_enum flags;
> -	flags = inode->i_state;
> +	flags = inode->i_state.__state;
>  	flags &= ~clearflags;
>  	flags |= setflags;
>  	inode_state_assign_raw(inode, flags);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

