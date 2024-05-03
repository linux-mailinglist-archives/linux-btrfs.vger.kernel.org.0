Return-Path: <linux-btrfs+bounces-4725-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844018BAC04
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 14:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDAE281C3B
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 May 2024 12:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7BE5152DF5;
	Fri,  3 May 2024 12:00:22 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F8214F9F9
	for <linux-btrfs@vger.kernel.org>; Fri,  3 May 2024 12:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737622; cv=none; b=Tt+kV6nxhIbfSrYr1bTS5CxX67BSJDXI/vc77U6umRidG+nmHLFHMWhD/8l8I7XBiLIJGfvGEW0TMzSJ3fG9tTRt9jqlPPBBbnuXBaWN3WOGXEmY9m15yBA7de3YoaQUfy8KtxnzRCIsArOA0Rf3zdATNeLdmQOUOLQVzIsXwJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737622; c=relaxed/simple;
	bh=1U0hTSg/v4SbTdbwYEvVgwXobGUEdvgJnc3gxR9EBmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FtPfwcBekAlkZETaAGKnn2/OtLUa3D9858AqSP7M6aI4lictyrWUog8C4RIb6NXveOef9+6Xj40z982BGwyiD/wT5RjAr4+KsLhm1UAIlkhSRE4Y/frhDmbaHrAaFXqCfqCTwSlPdsKNqovGAHHdxQtUX0YdFjziVyN878Sdxdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 72B6121977;
	Fri,  3 May 2024 12:00:19 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 642AB139CB;
	Fri,  3 May 2024 12:00:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xwhHGNPRNGZQZAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 03 May 2024 12:00:19 +0000
Date: Fri, 3 May 2024 13:53:03 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 00/11] btrfs: extent-map: unify the members with
 btrfs_ordered_extent
Message-ID: <20240503115303.GY2585@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1714707707.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1714707707.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 72B6121977
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

On Fri, May 03, 2024 at 03:31:35PM +0930, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Rebased to the latest for-next
>   There is a conflicts with extent locking, and maybe some other
>   hidden conflicts for NOCOW/PREALLOC?
>   As previously the patchset passes fstests auto group, but after
>   the merging with other patches, it always crashes as btrfs/060.
> 
> - Fix an error in the final cleanup patch
>   It's the NOCOW/PREALLOC shenanigans again, in the buffered NOCOW path,
>   that we have to use the old inaccurate numbers for NOCOW/PREALLOC OEs.
> 
> - Split the final cleanup into 4 patches
>   Most cleanups are very straightforward, but the cleanup for
>   btrfs_alloc_ordered_extent() needs extra special handling for
>   NOCOW/PREALLOC.

Regarding the merge target, it's too close to 6.10 merge window freeze
so this series is scheduled for 6.11.

