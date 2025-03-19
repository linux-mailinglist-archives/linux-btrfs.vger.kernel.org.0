Return-Path: <linux-btrfs+bounces-12433-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58858A69B31
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 22:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C597188B76C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 21:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F1D18E25;
	Wed, 19 Mar 2025 21:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1+JbIi5T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6XdUYujh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1+JbIi5T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6XdUYujh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EF14AD29
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742420962; cv=none; b=jU4q/OWziwjjKgsn5ZS9L9omhcRtRIMSkWgjfUj6h3DvG2kCwCkS3fEZ8LitRvFwr72+DEg6p/4TQNz/rlJFzNMrO4WryXxc2eEe8Awi8PpACcX5hAJyDlEXzDgXYCwnMjdbo/IgAeJKSIjVNgd0rUGhh9rgatURnO2D54gXk04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742420962; c=relaxed/simple;
	bh=5jk5wdSGunPmQnl1gjRQ0m196/L0P9mEV41/lqk7uXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxzID4HxWx5itt3SRpSYynOdoR4Rrzc8rLL8ip6kZJKy4VQ1XAONZiyqhzUDflOZBOE0Gbh2bY6v5ygcCD9ZIiAfcRn42Q/H45pLBnEABJBTi0vbmJI9/O5FEJfMk/l7bbZWfuWlvK9H6CKJNta44b8UMgu9T4EdKq0VnoQWDyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1+JbIi5T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6XdUYujh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1+JbIi5T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6XdUYujh; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 329EC1FB9B;
	Wed, 19 Mar 2025 21:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742420958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QdSj7BW+nZvoMs6vS1k0QnBNe5fhyOufkCihVfOBURY=;
	b=1+JbIi5T5+8XI4eHvCFF47gGB8N4j+bomKDVajuz5Dnp5yT7V4F1T+i3yek3eUU0OmK09r
	XLnhiYBHXW2E74xOC1mv4h2e19r55yYxZGj1/FfegJOZniQzzkbVaBxXVhI4yQOz9YyYRk
	BH4apLe34PW0t3GgOCffzH/hkw1u27s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742420958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QdSj7BW+nZvoMs6vS1k0QnBNe5fhyOufkCihVfOBURY=;
	b=6XdUYujhSNhIOmYykop45gqh3/DyiWibI1sXTcZvkMgOAcJOiAv7is5MtxYRDa5xxOEHXX
	t09LCb/bXSFVl1Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742420958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QdSj7BW+nZvoMs6vS1k0QnBNe5fhyOufkCihVfOBURY=;
	b=1+JbIi5T5+8XI4eHvCFF47gGB8N4j+bomKDVajuz5Dnp5yT7V4F1T+i3yek3eUU0OmK09r
	XLnhiYBHXW2E74xOC1mv4h2e19r55yYxZGj1/FfegJOZniQzzkbVaBxXVhI4yQOz9YyYRk
	BH4apLe34PW0t3GgOCffzH/hkw1u27s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742420958;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QdSj7BW+nZvoMs6vS1k0QnBNe5fhyOufkCihVfOBURY=;
	b=6XdUYujhSNhIOmYykop45gqh3/DyiWibI1sXTcZvkMgOAcJOiAv7is5MtxYRDa5xxOEHXX
	t09LCb/bXSFVl1Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E0CF13726;
	Wed, 19 Mar 2025 21:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JEPwAt4722cjOwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Mar 2025 21:49:18 +0000
Date: Wed, 19 Mar 2025 22:49:12 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: allowing 2K block size for experimental
 builds
Message-ID: <20250319214912.GM32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740542229.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740542229.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Feb 26, 2025 at 02:29:13PM +1030, Qu Wenruo wrote:
> Btrfs always has its minimal block size as 4K, but that means on the
> most common architecture, x86_64, we can not utilize the subpage block
> size routine at all.
> 
> Although the future larger folios support will allow us to utilize
> subpage routines, the support is still not yet there.
> 
> On the other hand, lowering the block size for experimental/debug builds is
> much easier, there is only one major bug (fixed by the first patch) in
> btrfs-progs at least.
> 
> Kernel sides enablement is not huge either, but it has dependency on
> the subpage related backlog patches to pass most fstests, which is not small.
> 
> However since we're not pushing this 2K block size for end users, we can
> accept some limitations on the 2K block size support:
> 
> - No 2K node size mkfs support
>   This is mostly caused by how we create the initial temporaray fs.
>   The initial temporaray fs contains at least 6 root items.
>   But one root item is 439 bytes, we need a level 1 root tree for the
>   initial temporaray fs.
> 
>   But we do not support multi-level trees for the initial fs, thus no
>   such support for now.
> 
> - No mixed block groups mkfs support
>   Caused by the missing 2K node size support
> 
> Qu Wenruo (3):
>   btrfs-progs: fix the incorrect buffer size for super block
>   btrfs-progs: support 2k block size
>   btrfs-progs: convert: check the sectorsize against BTRFS_MIN_BLOCKSIZE

Thanks, added to devel. I've enabled the 2k case for convert but it
fails, I haven't analyzed it as it does not seem to be important right
now.

