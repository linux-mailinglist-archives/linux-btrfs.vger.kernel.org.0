Return-Path: <linux-btrfs+bounces-7674-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A11965276
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 23:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F95B2135D
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Aug 2024 21:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84381BA27F;
	Thu, 29 Aug 2024 21:59:39 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91C18A950
	for <linux-btrfs@vger.kernel.org>; Thu, 29 Aug 2024 21:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968779; cv=none; b=QpMYZwJRMA7IUdCuypMK4m2oOuWkwf1uk9pkKaMzqJHnsYlG+AcVMzQwA1e7mPYMwM5rIdXWD5QNAeaWZh/KVNkMWqer/q6nfQxSlb2MT8xmqvXalAWAzc/AlYZjuLO6EB6YTfkmxiyVQLWZYshWlVKD1ROQ+JwzsVpX98twQVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968779; c=relaxed/simple;
	bh=o92t6zTTUNbF8H0cgo3ubWT132UUul8WptEKEd6a+Bg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C097wCA9sBpKZ9/CagfDc0EIsRCJ8ylo5a4KnYXXLia1ZfAYIt60xeiL48QzCO48EX77kJpXmD0GQ4nkt8BvwLhTOF6vld2VBh47uvJ92nDyLlZdC/hig5s0/bZ1dXznEvPmhIVtRdrRXwywM6Bw4288U1zH2nj8jGMm3KGMV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6EE37219D9;
	Thu, 29 Aug 2024 21:59:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0393C13408;
	Thu, 29 Aug 2024 21:59:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l+ooKkbv0GYsUQAAD6G6ig
	(envelope-from <rgoldwyn@suse.de>); Thu, 29 Aug 2024 21:59:34 +0000
Date: Thu, 29 Aug 2024 17:59:32 -0400
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: David Sterba <dsterba@suse.cz>
Cc: linux-btrfs@vger.kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH 0/2] Reduce scope of extent locking while reading
Message-ID: <iij3uydgaf5z5x6ydrz5yjh3vkvc7ee34toadx7ayb73h2qwl6@qempakwsbm22>
References: <cover.1724095925.git.rgoldwyn@suse.com>
 <20240829175357.GO25962@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829175357.GO25962@twin.jikos.cz>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 6EE37219D9
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On 19:53 29/08, David Sterba wrote:
> On Mon, Aug 19, 2024 at 04:00:51PM -0400, Goldwyn Rodrigues wrote:
> > From: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > Extent locking is not required for the entire read process. Once the
> > extent map is read all information to retrieve is available in the
> > extent map, and is cached in em_cached for later retrieval. The extent
> > map cached is also refcounted so it would not disappear.
> > Limit the extent locking while reading the extnet maps only. The rest is
> > just creating bio and fetching/decompressing the data according to the
> > extent map provided.
> > 
> > The only reason this was not working is because we would get EIO as
> > the CRCs would not match (or were not committed to disk as yet) for
> > folios that were written and released. In order to get over it, mark the
> > extent as finished only after all folios are cleared of writeback.
> > 
> > I have run the xfstests on it without any deadlocks or corruptions.
> > However, a fresh outlook on what could go wrong with a limiting the
> > scope of locks would be good.
> > 
> > Goldwyn Rodrigues (2):
> >   btrfs: clear folio writeback after completing ordered range
> >   btrfs: take extent lock only while reading extent map
> 
> The first patch seems relevant but it had been sent before Josef added
> the read locking updates so I don't know if it still needs to be merged.
> The second patch is covered by "btrfs: do not hold the extent lock for
> entire read".

The first patch is not relevant anymore because of the way extent locking
is used for reads. ie, a read must make sure all ordered extents are
submitted beore proceeding. This was not the case before and hence I
used to receive CRC errors for reads. This was a small race, where a
process would writeback and invalidate pages, and a fresh read is
performed simultaneously. The CRC tree was not updated and reads would
fail with EIO.

The second patch is incorporated in Josef's v2 version of the patchset.

In short, ignore this series.

-- 
Goldwyn

