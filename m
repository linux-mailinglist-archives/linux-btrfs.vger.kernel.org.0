Return-Path: <linux-btrfs+bounces-2158-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0170984B6D5
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 14:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E65841C243A8
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45E0130E3C;
	Tue,  6 Feb 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o4SSmTZx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMZUTcl9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o4SSmTZx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nMZUTcl9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FB5130E30;
	Tue,  6 Feb 2024 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227266; cv=none; b=gocKXe0RtnHYUJkk7JubdVqCxpn3OfOQLtYbnjoGe8ZH3A2FjGwk56xpGtddfl1GhsuR/sPkRoFYmMbF0fzhm/eWNiKl7UPiDaUw6buVhKmU1JCPy2y4+892esBCiQpYmzIMO0NqjYjMzjidnAV7lEqpV5oQsu3lqFE5E3mhSRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227266; c=relaxed/simple;
	bh=SmS/68MMba+VYTby1hbfh6ONol/484n9SwL2PZ/o5ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONjG0XVz0PaXSRgaTkYdJvJaQB5DwNiLqtVuq/2r580YVmamOE8sYa6g92TOnZH9XzcePFTOtQPqmXy4H5KJI+Y17bXzOP77Bo127VFRAXs6/ltgJ1FOpYLspfg1mfq87QVABEZf058dTTJnRTmpcOhH51j3/yko9AncaVQpZHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o4SSmTZx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMZUTcl9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o4SSmTZx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nMZUTcl9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 491E0221D2;
	Tue,  6 Feb 2024 13:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707227262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lRxU4SWz8M5pbtTR6JuySEmMZEko7jP5m8QPqIxIOwA=;
	b=o4SSmTZxFQDhnU+bcbiU3rCCkSPKKEgsAeaZq7Z3RgYLonoKnomqV7pDyvbuIVOnts/+Sr
	cSm4EHmR1Y+w0KTLuqx5821+sjDeMxm4lgKRuywUjY8jai2byoyXA+7cZnPGJ+hrirmuot
	x8lWi6LdYzstKCAobIZzMGuZFFTd6nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707227262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lRxU4SWz8M5pbtTR6JuySEmMZEko7jP5m8QPqIxIOwA=;
	b=nMZUTcl91xses+lXDBuLppSRSIhM0+4GA0wlo83bpszqGa4aERTQOrrrGeE90GjmrOM0OB
	HX/dR5HijjDq9cDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707227262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lRxU4SWz8M5pbtTR6JuySEmMZEko7jP5m8QPqIxIOwA=;
	b=o4SSmTZxFQDhnU+bcbiU3rCCkSPKKEgsAeaZq7Z3RgYLonoKnomqV7pDyvbuIVOnts/+Sr
	cSm4EHmR1Y+w0KTLuqx5821+sjDeMxm4lgKRuywUjY8jai2byoyXA+7cZnPGJ+hrirmuot
	x8lWi6LdYzstKCAobIZzMGuZFFTd6nM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707227262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lRxU4SWz8M5pbtTR6JuySEmMZEko7jP5m8QPqIxIOwA=;
	b=nMZUTcl91xses+lXDBuLppSRSIhM0+4GA0wlo83bpszqGa4aERTQOrrrGeE90GjmrOM0OB
	HX/dR5HijjDq9cDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 28A38132DD;
	Tue,  6 Feb 2024 13:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +K23CX44wmWUQwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Feb 2024 13:47:42 +0000
Date: Tue, 6 Feb 2024 14:47:13 +0100
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: David Sterba <dsterba@suse.cz>, Yang Xu <xuyang2018.jy@fujitsu.com>,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Message-ID: <20240206134713.GO355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
 <20240205154907.GH355@twin.jikos.cz>
 <20240206101005.u2mrxlg4pg3cdoxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20240206120201.GL355@twin.jikos.cz>
 <20240206133235.rizvxggjnsv2ppcf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206133235.rizvxggjnsv2ppcf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=o4SSmTZx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nMZUTcl9
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 491E0221D2
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Tue, Feb 06, 2024 at 09:32:35PM +0800, Zorro Lang wrote:
> On Tue, Feb 06, 2024 at 01:02:01PM +0100, David Sterba wrote:
> > On Tue, Feb 06, 2024 at 06:10:05PM +0800, Zorro Lang wrote:
> > > On Mon, Feb 05, 2024 at 04:49:07PM +0100, David Sterba wrote:
> > > > On Wed, Jan 31, 2024 at 11:23:48PM -0500, Yang Xu wrote:
> > > > > @@ -20,11 +20,6 @@
> > > > >  #define BTRFS_IOCTL_MAGIC 0x94
> > > > >  #endif
> > > > >  
> > > > > -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> > > > > -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> > > > > -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> > > > > -#endif
> > > > > -
> > > > >  #ifndef BTRFS_IOC_SNAP_CREATE_V2
> > > > >  #define BTRFS_IOC_SNAP_CREATE_V2 \
> > > > >  	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> > > > > @@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
> > > > >  };
> > > > >  #endif
> > > > >  
> > > > > +#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2
> > > > 
> > > > This is right for AC_CHECK_DECLS. Other macros like AC_CHECK_HEADERS do
> > > > not define the HAVE_... in case it's not found so the #if !HAVE_...
> > > > would be wrong. Slightly confusing.
> > > 
> > > Won't AC_CHECK_HEADERS define the HAVE_... ? But how do we get the ...
> > > 
> > >   /* Define to 1 if you have the <linux/falloc.h> header file. */
> > >   #define HAVE_LINUX_FALLOC_H 1
> > > 
> > > in include/config.h file?
> > 
> > Yes the HAVE_ macros are defined, just that it actually also defines
> > 
> > #define HAVE_LINUX_FALLOC_H 0
> 
> Oh I didn't find that in my local fstests code (has been built), I got
> something likes this in include/config.h (for defined or un-defined):
> 
>   /* Define to 1 if you have the <cifs/ioctl.h> header file. */
>   /* #undef HAVE_CIFS_IOCTL_H */
> 
>   /* Define to 1 if you have the declaration of `BTRFS_IOC_SNAP_DESTROY_V2', and
>      to 0 if you don't. */
>   #define HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2 1
> 
> > 
> > if not found, unlike other macros result in
> > 
> > /* #undef HAVE_SOME_FUNCTION */
> > 
> > What you did will work, the inconsistency is in the autoconf macros.
> 
> But I'm not familar with these AC_CHECK things:) Maybe its behavior isn't
> sure, AC_CHECK_DECLS is sure to define HAVE_.... to 1, AC_CHECK_HEADERS is
> sure to have a definition but not sure what's defined. Do you mean that?
> 
> BTW, I think you're not nacking this patch, right? :)

No I'm not, sorry if this was confusing, it was a comment about the
autoconf macros and how are the defines supposed to be checked. We once
had a bug where

#ifdef MACRO

vs

#if MACRO

was not doing the same thing because of the sometimes/always defined
semantics.

