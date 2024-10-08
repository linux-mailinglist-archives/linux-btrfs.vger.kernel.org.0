Return-Path: <linux-btrfs+bounces-8665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568B7995959
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 23:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831E9B237B3
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Oct 2024 21:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E15213EF1;
	Tue,  8 Oct 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SfUGEwkh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s6a+MKT2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SfUGEwkh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s6a+MKT2"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBFD2C859
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Oct 2024 21:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423570; cv=none; b=VSizEsBNZooyNcazLyZckbjqSqi/UroLnCaXG4b7SypRQa2AQmSmmFEDD/if9r99k5hDEwa/vUqHyyUDLTHTdbLZ8xp38ZWXDxE3wUGGUMpp26BD6+vu4+wZ8UkTJ8/Xv93a492QTe0xbjFrAYjPh9pfXCr1dD2Dn+EFi5bVpxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423570; c=relaxed/simple;
	bh=Nw/GaaWCsx9gvQoAePR34x+l4U06N9vR7IbSmhaeGu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjhHAYeEo/30R24JYSiLvt2KN58bOh4DkeLbd5115Sgl3pDWoX8MFlJiGxAJlX5ZmX45GuXCeaci8UOLAE0ElMX/cMqin8bmT3Rg82kP6sVfP0czaScKNDprfJ6/VmSK/CTDoDuhV8k/GoUIQ8egya/dfM0mwIA1E6sEUgq3/xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SfUGEwkh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s6a+MKT2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SfUGEwkh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s6a+MKT2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DA81021222;
	Tue,  8 Oct 2024 21:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728423566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQzKZofNSvCNhP3+5Rv+J/qN4ZrztK1w0EI/KixzFN0=;
	b=SfUGEwkhFsDSM6G8XNcdO/KmBHL/tOjyIKylS2hNeccb378QyADOVoIlxe2Vxts8xlqqzR
	/ExjGbyVAiDJD93tBEHiSns93wq+GpwIBuJ6q4P8uMhc4jB5hxCG/Y5XIwqcxgxDj1fTOC
	/i38m0afdfz7ZDBPolT4YKJSR8Yn+D4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728423566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQzKZofNSvCNhP3+5Rv+J/qN4ZrztK1w0EI/KixzFN0=;
	b=s6a+MKT2c1i+Y9N2tl1J+RA9DbjRCMbMBoLnW7fAmveyZxRMejAwZoYUUa3Bxrbif0g57T
	UpCU4fcFILTlrWBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728423566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQzKZofNSvCNhP3+5Rv+J/qN4ZrztK1w0EI/KixzFN0=;
	b=SfUGEwkhFsDSM6G8XNcdO/KmBHL/tOjyIKylS2hNeccb378QyADOVoIlxe2Vxts8xlqqzR
	/ExjGbyVAiDJD93tBEHiSns93wq+GpwIBuJ6q4P8uMhc4jB5hxCG/Y5XIwqcxgxDj1fTOC
	/i38m0afdfz7ZDBPolT4YKJSR8Yn+D4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728423566;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQzKZofNSvCNhP3+5Rv+J/qN4ZrztK1w0EI/KixzFN0=;
	b=s6a+MKT2c1i+Y9N2tl1J+RA9DbjRCMbMBoLnW7fAmveyZxRMejAwZoYUUa3Bxrbif0g57T
	UpCU4fcFILTlrWBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEEF913A6E;
	Tue,  8 Oct 2024 21:39:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cgxmLo6mBWe/HAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Oct 2024 21:39:26 +0000
Date: Tue, 8 Oct 2024 23:39:20 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: remove btrfs_set_range_writeback()
Message-ID: <20241008213920.GI1609@suse.cz>
Reply-To: dsterba@suse.cz
References: <2c53f7555d45d6697e836fa2bb7dce137ab04c99.1728175215.git.wqu@suse.com>
 <20241008164356.GC1609@twin.jikos.cz>
 <9de4892b-f1dc-4dc1-a63b-71564aaf1a94@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de4892b-f1dc-4dc1-a63b-71564aaf1a94@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Wed, Oct 09, 2024 at 07:26:36AM +1030, Qu Wenruo wrote:
> >> --- a/fs/btrfs/inode.c
> >> +++ b/fs/btrfs/inode.c
> >> @@ -8939,28 +8939,6 @@ static int btrfs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
> >>   	return finish_open_simple(file, ret);
> >>   }
> >>
> >> -void btrfs_set_range_writeback(struct btrfs_inode *inode, u64 start, u64 end)
> >> -{
> >> -	struct btrfs_fs_info *fs_info = inode->root->fs_info;
> >> -	unsigned long index = start >> PAGE_SHIFT;
> >> -	unsigned long end_index = end >> PAGE_SHIFT;
> >> -	struct folio *folio;
> >> -	u32 len;
> >> -
> >> -	ASSERT(end + 1 - start <= U32_MAX);
> >> -	len = end + 1 - start;
> >> -	while (index <= end_index) {
> >> -		folio = __filemap_get_folio(inode->vfs_inode.i_mapping, index, 0, 0);
> >> -		ASSERT(!IS_ERR(folio)); /* folios should be in the extent_io_tree */
> >> -
> >> -		/* This is for data, which doesn't yet support larger folio. */
> >> -		ASSERT(folio_order(folio) == 0);
> >> -		btrfs_folio_set_writeback(fs_info, folio, start, len);
> >
> > So the new code is just btrfs_folio_set_writeback(), with the removed
> > comment and assertion,
> 
> Firstly, the length check is already inside btrfs_folio_set_writeback()
> for the subpage cases.
> If it's not subpage, we do not even need to check the range (it's always
> page aligned).
> 
> Secondly for the folio, we do not need the ASSERT(), because this time
> we have the folio pointer already.
> 
> So for the assert part, there is no change.

Ok.

> > what's the status regarding large folios?
> 
> That stays the same, no larger folio support.
> 
> The larger folio support requires us to get rid of the per-fs
> sectors_per_page check, but using folio_size() to do the calculation.
> 
> That will still be a lot of work to do before we can support larger
> folios for data.

My question was about this specific place in the code, if we e.g. remove
various assertions making sure we don't accidentally get there with
large folios after they get enabled in the future. It's ok when other
code makes different checks that would prevent it, but that's what I did
not immediately see. Thanks.

