Return-Path: <linux-btrfs+bounces-9943-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA62A9DAAD4
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 16:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6268CB21B56
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Nov 2024 15:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C91FCCE5;
	Wed, 27 Nov 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+HHDLYi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y8ECb3NP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z+HHDLYi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y8ECb3NP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A162B9DD
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Nov 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732721547; cv=none; b=qdAOSozrROnPnaKcowW4KsuOFcF+kHbMWQQnta0+yV3d+3Gs1+9V5ahIVistqRvwYIUmpA3Es0bL1XPUsxw/Pgs1qHM+vRGaZq6dqxe2FTY8ZW56pXON0xdAHAiZgc2bnckf5dSMVTYWBM4H0MWRHAcWO7l3sVwMuwvMjHoXa1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732721547; c=relaxed/simple;
	bh=HJw9uBvmSFNkm3AitJiKf2/FymN6XTkrdeLSe1Bs1g8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YHJLH9bk91BGDFkv0L+P4Asrxo2eh1w6WylYVjm9DzB3/Ci9EMTtrS83f9m11ZyFPijCsfJPZjfASVf9z6i0TaDtxKQFUCYcP4mX9IU+EyoZ40W2sSulo/iXfQNcyjtzSCpDTvF423+Rt6ddU4eiFdKXHg9C66igwvNrGRvQ+HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+HHDLYi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y8ECb3NP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z+HHDLYi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y8ECb3NP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBBE821166;
	Wed, 27 Nov 2024 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732721543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySEx/10Vq0N/YZfD7pCQ5WljhcTax5Vzez1SnxgB3Us=;
	b=z+HHDLYicWCUWJ0srdMSnfxnSGesUftLT584+I3cR81WZ8q5riUG2IhQk9nXoi+Tdky9wt
	uoLmDTHfsi1MP12qjwIVysDta9gbKfkgQiaCukd1YOcJmbPm5BMyVKRUDw1MEf9vvdPxh+
	BlqKraGChWLHNhryEXklVjV8OLgDJEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732721543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySEx/10Vq0N/YZfD7pCQ5WljhcTax5Vzez1SnxgB3Us=;
	b=y8ECb3NPlKtWcpSJaUn1M10cSizAD+8jw5pgW4AOMLi7S7H5PqyJ9kHfI7rx70T5ZvN6OL
	jpcUJG3tWK1COSDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732721543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySEx/10Vq0N/YZfD7pCQ5WljhcTax5Vzez1SnxgB3Us=;
	b=z+HHDLYicWCUWJ0srdMSnfxnSGesUftLT584+I3cR81WZ8q5riUG2IhQk9nXoi+Tdky9wt
	uoLmDTHfsi1MP12qjwIVysDta9gbKfkgQiaCukd1YOcJmbPm5BMyVKRUDw1MEf9vvdPxh+
	BlqKraGChWLHNhryEXklVjV8OLgDJEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732721543;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySEx/10Vq0N/YZfD7pCQ5WljhcTax5Vzez1SnxgB3Us=;
	b=y8ECb3NPlKtWcpSJaUn1M10cSizAD+8jw5pgW4AOMLi7S7H5PqyJ9kHfI7rx70T5ZvN6OL
	jpcUJG3tWK1COSDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABDD313941;
	Wed, 27 Nov 2024 15:32:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hnvAKYc7R2fOLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 27 Nov 2024 15:32:23 +0000
Date: Wed, 27 Nov 2024 16:32:22 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: subpage: dump the involved bitmap when
 ASSERT() failed
Message-ID: <20241127153222.GP31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1732680197.git.wqu@suse.com>
 <8010687d79feebb04ba51427f94fa708f8dc1788.1732680197.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8010687d79feebb04ba51427f94fa708f8dc1788.1732680197.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-8.00 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Score: -8.00
X-Spam-Flag: NO

On Wed, Nov 27, 2024 at 02:36:37PM +1030, Qu Wenruo wrote:
> +#define subpage_dump_bitmap(fs_info, folio, name, start, len)		\
> +{									\
> +	struct btrfs_subpage *subpage = folio_get_private(folio);	\
> +	unsigned long bitmap;						\
> +									\
> +	GET_SUBPAGE_BITMAP(subpage, fs_info, name, &bitmap);		\
> +	btrfs_warn(fs_info,						\
> +	"dumpping bitmap start=%llu len=%u folio=%llu" #name "_bitmap=%*pbl", \

The stringified #name would be next to the folio=number, please add one " ".

> +		   start, len, folio_pos(folio),			\
> +		   fs_info->sectors_per_page, &bitmap);			\
> +}

