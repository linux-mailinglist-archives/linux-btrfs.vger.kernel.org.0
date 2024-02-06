Return-Path: <linux-btrfs+bounces-2153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC62B84B468
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 13:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE821F21091
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 12:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DDB13173E;
	Tue,  6 Feb 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L36CB8d8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Itd4AIRZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L36CB8d8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Itd4AIRZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5179C131724;
	Tue,  6 Feb 2024 12:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707220956; cv=none; b=fJfqXRCjiYgghEHbH0PIueoj9r8QzOg4ya+CtX8RX+zaGUGryFO3T0tvtUjvKqsKnEvJ8a95ZQQCmVf18uPusNEd5C4X9whaTVpu3k36MBexGZoflugJSDgEvhgJOfVtkpSbqGunZN6SHs+PJtwfU+tKsacU4LCGACS1ac+JkG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707220956; c=relaxed/simple;
	bh=C/I/eGf+L8Pt2BrycK2NP2/IL0N6MH1S230xoJdN2g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oSfiGkbNQiFo5Hewdt7EbcroRDM2yp6Glqc2Sc3A4irBbRSWJxmA7vRuirXEtipDr9yI1Ozsz+WHjAbR3wJg+tcZfXcpn1THK/tTXPxg+fE45rRZRcIpnNmhyFBDbEWs9F5wltffqBHyBMcDtkrg9siIqx6i+BeHrj/sI/JyLVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L36CB8d8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Itd4AIRZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L36CB8d8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Itd4AIRZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4B22E220D8;
	Tue,  6 Feb 2024 12:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707220951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61CxVOLhSCRZoVF1+nZAuwZ/QbKRd5xQyGEDyxJmFlw=;
	b=L36CB8d8S/Wuh9nUxvODvtDX9poTQg73eedEwcyCJH/2TTVLkDtThlD0L67h81HiAHnCiT
	uH2s0Fb04JO1BvZUJRkm0dFIbiDJs0QJujqRljg6W0DHPdyRxJihaFt9V+F957oTLaJ3Te
	4EBIOyQL19lBk/Ciiy98oKbuOL7vWmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707220951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61CxVOLhSCRZoVF1+nZAuwZ/QbKRd5xQyGEDyxJmFlw=;
	b=Itd4AIRZZSIvidlvwuz08Zy6BuQnmWBJbVj3BUH/ONYjLZT32sYXoCW9ocPi0GnRXxO8f6
	ScG9sknBAe9irsCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707220951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61CxVOLhSCRZoVF1+nZAuwZ/QbKRd5xQyGEDyxJmFlw=;
	b=L36CB8d8S/Wuh9nUxvODvtDX9poTQg73eedEwcyCJH/2TTVLkDtThlD0L67h81HiAHnCiT
	uH2s0Fb04JO1BvZUJRkm0dFIbiDJs0QJujqRljg6W0DHPdyRxJihaFt9V+F957oTLaJ3Te
	4EBIOyQL19lBk/Ciiy98oKbuOL7vWmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707220951;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=61CxVOLhSCRZoVF1+nZAuwZ/QbKRd5xQyGEDyxJmFlw=;
	b=Itd4AIRZZSIvidlvwuz08Zy6BuQnmWBJbVj3BUH/ONYjLZT32sYXoCW9ocPi0GnRXxO8f6
	ScG9sknBAe9irsCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24E96139D8;
	Tue,  6 Feb 2024 12:02:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pCqZCNcfwmVaIAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Feb 2024 12:02:31 +0000
Date: Tue, 6 Feb 2024 13:02:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Zorro Lang <zlang@redhat.com>
Cc: David Sterba <dsterba@suse.cz>, Yang Xu <xuyang2018.jy@fujitsu.com>,
	fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] t_snapshot_deleted_subvolume: add check for
 BTRFS_IOC_SNAP_DESTROY_V2
Message-ID: <20240206120201.GL355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240201042348.147733-1-xuyang2018.jy@fujitsu.com>
 <20240205154907.GH355@twin.jikos.cz>
 <20240206101005.u2mrxlg4pg3cdoxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206101005.u2mrxlg4pg3cdoxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[99.99%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Tue, Feb 06, 2024 at 06:10:05PM +0800, Zorro Lang wrote:
> On Mon, Feb 05, 2024 at 04:49:07PM +0100, David Sterba wrote:
> > On Wed, Jan 31, 2024 at 11:23:48PM -0500, Yang Xu wrote:
> > > @@ -20,11 +20,6 @@
> > >  #define BTRFS_IOCTL_MAGIC 0x94
> > >  #endif
> > >  
> > > -#ifndef BTRFS_IOC_SNAP_DESTROY_V2
> > > -#define BTRFS_IOC_SNAP_DESTROY_V2 \
> > > -	_IOW(BTRFS_IOCTL_MAGIC, 63, struct btrfs_ioctl_vol_args_v2)
> > > -#endif
> > > -
> > >  #ifndef BTRFS_IOC_SNAP_CREATE_V2
> > >  #define BTRFS_IOC_SNAP_CREATE_V2 \
> > >  	_IOW(BTRFS_IOCTL_MAGIC, 23, struct btrfs_ioctl_vol_args_v2)
> > > @@ -58,6 +53,11 @@ struct btrfs_ioctl_vol_args_v2 {
> > >  };
> > >  #endif
> > >  
> > > +#if !HAVE_DECL_BTRFS_IOC_SNAP_DESTROY_V2
> > 
> > This is right for AC_CHECK_DECLS. Other macros like AC_CHECK_HEADERS do
> > not define the HAVE_... in case it's not found so the #if !HAVE_...
> > would be wrong. Slightly confusing.
> 
> Won't AC_CHECK_HEADERS define the HAVE_... ? But how do we get the ...
> 
>   /* Define to 1 if you have the <linux/falloc.h> header file. */
>   #define HAVE_LINUX_FALLOC_H 1
> 
> in include/config.h file?

Yes the HAVE_ macros are defined, just that it actually also defines

#define HAVE_LINUX_FALLOC_H 0

if not found, unlike other macros result in

/* #undef HAVE_SOME_FUNCTION */

What you did will work, the inconsistency is in the autoconf macros.

