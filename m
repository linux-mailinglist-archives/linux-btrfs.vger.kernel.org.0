Return-Path: <linux-btrfs+bounces-2065-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3FB846FC6
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 13:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48631F275CE
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2AB13DB9B;
	Fri,  2 Feb 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1eHkpn4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wAySm1ma";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1eHkpn4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wAySm1ma"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3361B17C73
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875672; cv=none; b=BCAm25dYxQYE14tcXeDklbNSUA0am0aR44SBe+F/+TizmQb5kKsKGdEKw9gvAgyf6Ul4y8PeEvUTbj/5G6SGInjbnC5MFLsx33wZd0dqC/hb8gnobSTag1rWAZ49+H4Fyg5cKblv769zYETQj1pEcZLhRockK/xA2O/1rrXQc/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875672; c=relaxed/simple;
	bh=fY2xnrvW9WZYcmyQwhoO8IB/5Ht2RoDeP2kV5fKIht0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kt67jKS3AIaUCS/mNb9KNPIFCe+rx2q/yClBrsvLZob6ZQq6M0WRypOHjK8SqgIGJFhPXAfZy7aArgqOO9n8PmdqNnN0Tj13xKZXOEzeZELQ7vy1uoWrBHLiO6XwLST+Kn4fdIGU6WsbK8LQLeo/bJ0S93bquQ/M0aLXxYuOlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U1eHkpn4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wAySm1ma; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U1eHkpn4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wAySm1ma; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A78421E8B;
	Fri,  2 Feb 2024 12:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706875669;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8agqTb84f7XK9NGsVFBGFp6/nJ1I/YSgarjUYtsLuk=;
	b=U1eHkpn4WGqzfZqj16QKw+TxTotUX0D2ka9QZW7HbUcqlycWzB6B4soI0TeLSV0Fozlgxi
	/bFAugRQHieAsZnjjAMMiUakHD9jdOt+oo3y7xcFknpuTmfXxMsrqhTxjfse+gbv+f7MqY
	gTepxUQlSRF4vl52NniFsEz6+owCgMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706875669;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8agqTb84f7XK9NGsVFBGFp6/nJ1I/YSgarjUYtsLuk=;
	b=wAySm1makZbLx1USOUgLZNesOvub6jigVWQVYdkGKOBPCbvRHrpB0QSteKSiXcnH81yd3d
	Uj8AAxGwbvs2ZrCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706875669;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8agqTb84f7XK9NGsVFBGFp6/nJ1I/YSgarjUYtsLuk=;
	b=U1eHkpn4WGqzfZqj16QKw+TxTotUX0D2ka9QZW7HbUcqlycWzB6B4soI0TeLSV0Fozlgxi
	/bFAugRQHieAsZnjjAMMiUakHD9jdOt+oo3y7xcFknpuTmfXxMsrqhTxjfse+gbv+f7MqY
	gTepxUQlSRF4vl52NniFsEz6+owCgMM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706875669;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g8agqTb84f7XK9NGsVFBGFp6/nJ1I/YSgarjUYtsLuk=;
	b=wAySm1makZbLx1USOUgLZNesOvub6jigVWQVYdkGKOBPCbvRHrpB0QSteKSiXcnH81yd3d
	Uj8AAxGwbvs2ZrCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1798D133DC;
	Fri,  2 Feb 2024 12:07:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id lz5EBRXbvGXINQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 02 Feb 2024 12:07:49 +0000
Date: Fri, 2 Feb 2024 13:07:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode
 pointer
Message-ID: <20240202120722.GY31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706810422.git.dsterba@suse.com>
 <e25d9d750e5a753c5341d11356649f89f00a260d.1706810422.git.dsterba@suse.com>
 <9eab4581-ee07-4e03-a0df-635ae4f30716@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9eab4581-ee07-4e03-a0df-635ae4f30716@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.20 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[35.41%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20

On Fri, Feb 02, 2024 at 11:34:06AM +0000, Johannes Thumshirn wrote:
> On 01.02.24 19:08, David Sterba wrote:
> > diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
> > index ce1bfd9938b1..a8b3a8828162 100644
> > --- a/fs/btrfs/fs.h
> > +++ b/fs/btrfs/fs.h
> > @@ -836,6 +836,9 @@ struct btrfs_fs_info {
> >   #define page_to_fs_info(_page)	 (page_to_inode(_page)->root->fs_info)
> >   #define folio_to_fs_info(_folio) (folio_to_inode(_folio)->root->fs_info)
> >   
> > +#define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
> > +					   struct inode *: (_inode)))->root->fs_info)
> 
> Didn't that trip over a NULL-pointer in the last iteration?

It did in one particular case and it's been fixed. In general
inode->root->fs_info always exists.

