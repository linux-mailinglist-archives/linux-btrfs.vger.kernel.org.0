Return-Path: <linux-btrfs+bounces-1940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF7A842CCB
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 20:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4A181F26A90
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 19:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DB07B3E4;
	Tue, 30 Jan 2024 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A5xu3iA8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bYT2OZRG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A5xu3iA8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bYT2OZRG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A79A7B3D1
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 19:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643113; cv=none; b=GAg7CBb0ekzYlXNNI92FrxMAy/0PMjcprVHMYH0M3+/Yjbazk3PEl4ib9WBbi/kBsPGKPU4j5cC93HHccDNQOnkZNRRZ8jPuuAqzdudbYLKOTl0PY1z7UaBezeGdMNrgNxNEueZ31Whcicut1qjbmM45QHuRx0CkKbuhJDoObQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643113; c=relaxed/simple;
	bh=BDvX3s+oHRT97A7IJrDs1kvND55+VNNHBHYuU1qJO6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TB5rox7Y9wBHfLIrUwTqBHGCz3yNY2CLB2lgIcHoaepp3J3Z2jCcMvdDrgM6nqrGBaOok8JXol6cZCt8YBu5PHzbcjhEJ5alQijmOU++ZXavml67R+Cgaagye8Qacb4M0F8qt5sGaiyyrLcNde1DzeU4rItWSDFCBvVK+RFBGM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A5xu3iA8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bYT2OZRG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A5xu3iA8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bYT2OZRG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5F6822304;
	Tue, 30 Jan 2024 19:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706643109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfXRTRSl8iDgliGCWr8Yi/lBP8l2CmqtVDLYdCRC7vA=;
	b=A5xu3iA8lAJXSuj5EwWRc7AwuRLLSeaBVo3nNe9aP7SHZ/azSONeBRRZ+Rg2xDkdxDtELa
	1A5tvNeJP1w5P8zrWfd+kpvX8fgrbaCXKTbgDZL6tcfH7FckUmD5B0etLxko4yr2MhaYas
	hPohZhBbNp3u5xF+o0vVSPjQ2nVecw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706643109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfXRTRSl8iDgliGCWr8Yi/lBP8l2CmqtVDLYdCRC7vA=;
	b=bYT2OZRGmh387Ezk7mGGaoLV9JwVcioly1WCI8WOKmwIu/GVLpBp6MaEKPIIFyjnIqU35z
	5sjoHCmF6UoxreAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706643109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfXRTRSl8iDgliGCWr8Yi/lBP8l2CmqtVDLYdCRC7vA=;
	b=A5xu3iA8lAJXSuj5EwWRc7AwuRLLSeaBVo3nNe9aP7SHZ/azSONeBRRZ+Rg2xDkdxDtELa
	1A5tvNeJP1w5P8zrWfd+kpvX8fgrbaCXKTbgDZL6tcfH7FckUmD5B0etLxko4yr2MhaYas
	hPohZhBbNp3u5xF+o0vVSPjQ2nVecw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706643109;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LfXRTRSl8iDgliGCWr8Yi/lBP8l2CmqtVDLYdCRC7vA=;
	b=bYT2OZRGmh387Ezk7mGGaoLV9JwVcioly1WCI8WOKmwIu/GVLpBp6MaEKPIIFyjnIqU35z
	5sjoHCmF6UoxreAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 92BB713212;
	Tue, 30 Jan 2024 19:31:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HpibI6VOuWXpfwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 30 Jan 2024 19:31:49 +0000
Date: Tue, 30 Jan 2024 20:31:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode
 pointer
Message-ID: <20240130193124.GD31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706553080.git.dsterba@suse.com>
 <edd12dabd0ce57ba84a4c2b82c51becd64fd7a6f.1706553080.git.dsterba@suse.com>
 <da763ce1-dd25-4fe7-9bb7-138dc6350e04@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da763ce1-dd25-4fe7-9bb7-138dc6350e04@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.08
X-Spamd-Result: default: False [-1.08 / 50.00];
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
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.08)[63.91%]
X-Spam-Flag: NO

On Tue, Jan 30, 2024 at 11:49:48AM +0000, Johannes Thumshirn wrote:
> On 29.01.24 19:34, David Sterba wrote:
> > diff --git a/fs/btrfs/misc.h b/fs/btrfs/misc.h
> > index 9cb671ef136c..7fcbf9e115ca 100644
> > --- a/fs/btrfs/misc.h
> > +++ b/fs/btrfs/misc.h
> > @@ -12,6 +12,7 @@
> >   #define folio_to_inode(folio)	BTRFS_I((folio)->mapping->host)
> >   #define page_to_fs_info(page)	BTRFS_I((page)->mapping->host)->root->fs_info
> >   #define folio_to_fs_info(page)	BTRFS_I((folio)->mapping->host)->root->fs_info
> > +#define inode_to_fs_info(inode)	BTRFS_I(inode)->root->fs_info
> >   
> 
> If you'd switch patches 3 and 4 you could do
> #define page_to_fs_info(page)	inode_to_fs_info(page_to_inode(page))
> #define folio_to_fs_info(folio)	inode_to_fs_info(folio_to_inode(folio))

I see that it's shorter but also obfuscated by the macro indirection.

