Return-Path: <linux-btrfs+bounces-3645-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD3188D2E6
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 00:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8246BB21FB8
	for <lists+linux-btrfs@lfdr.de>; Tue, 26 Mar 2024 23:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF2913E047;
	Tue, 26 Mar 2024 23:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Roctq8q3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dtr7JoLX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Roctq8q3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dtr7JoLX"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4621E494
	for <linux-btrfs@vger.kernel.org>; Tue, 26 Mar 2024 23:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711496467; cv=none; b=T2smM3KNQV/uUDP35hPnjwB88O5y08TR6WFL/HSGLxFFQAcb26BgkOD/eq8rtueV7Ak+HIbqBBWAZPKslnd+gHKh7gQkGExwtlop8GzUkC46pPoWWvLNO7UFJQ3KyVka7E+g0xuUW0O8P9ZEf7GE8kpyvu3Cybz8EiAtfkyzBwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711496467; c=relaxed/simple;
	bh=fyP94p+0H0JUW3Uj76Zg369AaDJQ8KCGdyNskXP4gAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bajr/Fsmw5irPmYZdU4D5i6EVi85ynu8ZQn3fk5nomX0xz+HwSiccaHYqSa/Mo00gN54/OaJokXCUv6BnJPLAiz8uLMhSWwkUpm2tRXO+H20yim1OP8lIaHUmex8b4NNurdeY/eRkII92Nn15IP/tP7tOkQ0BhVo+yo/ZCVKXE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Roctq8q3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dtr7JoLX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Roctq8q3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dtr7JoLX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 844D45FA83;
	Tue, 26 Mar 2024 23:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711496457;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MXKQAod03t/85cJAO3njrLafNJRbYS6MPDuGNQGIOg=;
	b=Roctq8q348dNEtrQrjLpTntjuUneqh9Cl5BPO1fyhfa4Ghbtsro3d11+SSJWm72OBkTpUV
	YvNPZ18mGqJXicEKTjUy/q9TS/tOkmfVOcBcGMrETa6UcUxe51qrWbpXrCwmyjIUqHSrbi
	KrJNO2FTslgudKmxMXC4hedbFCeY3hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711496457;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MXKQAod03t/85cJAO3njrLafNJRbYS6MPDuGNQGIOg=;
	b=Dtr7JoLXaBVEqBl82gKx4GrSu6N/GwO+b/p5tuDwdgK+1NuzyQ+blVcmplzrx4WRDGSIxE
	3dblqEcxJuSpvQAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711496457;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MXKQAod03t/85cJAO3njrLafNJRbYS6MPDuGNQGIOg=;
	b=Roctq8q348dNEtrQrjLpTntjuUneqh9Cl5BPO1fyhfa4Ghbtsro3d11+SSJWm72OBkTpUV
	YvNPZ18mGqJXicEKTjUy/q9TS/tOkmfVOcBcGMrETa6UcUxe51qrWbpXrCwmyjIUqHSrbi
	KrJNO2FTslgudKmxMXC4hedbFCeY3hU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711496457;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6MXKQAod03t/85cJAO3njrLafNJRbYS6MPDuGNQGIOg=;
	b=Dtr7JoLXaBVEqBl82gKx4GrSu6N/GwO+b/p5tuDwdgK+1NuzyQ+blVcmplzrx4WRDGSIxE
	3dblqEcxJuSpvQAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D59713587;
	Tue, 26 Mar 2024 23:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id MrMyGgldA2Z5HAAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 26 Mar 2024 23:40:57 +0000
Date: Wed, 27 Mar 2024 00:33:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs: compression: migrate to folio interfaces
Message-ID: <20240326233335.GV14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706521511.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1706521511.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -3.23
X-Spamd-Result: default: False [-3.23 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.24)[-0.240];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.19)[-0.947];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Mon, Jan 29, 2024 at 08:16:05PM +1030, Qu Wenruo wrote:
> This is the conversion for btrfs compression paths to use folio
> interfaces.
> 
> For now, it's a pure intrefaces change, just with some variable names
> also changed from "page" to "folio".
> 
> There is no utilization of possible larger folio size yet, thus we're
> still using a lot of PAGE_SIZE/PAGE_SHIFT in the existing code.
> 
> But it's still a good first step towards large folio for btrfs data.
> 
> The first patch is in fact independent from the series, to slightly
> enhance the page cache missing error handling, but all later patches
> relies on it, to make later folio change a little smoother.
> 
> The third patch is also a good cleanup, as it allows we to pass a single
> page to inline creation path.
> Although during tests, it turns out that under heavy race we can try to
> insert an empty inline extent, but since the old code can handle it
> well, I just added one comment for it.
> 
> The remaining but the last one are some preparation before the final
> conversion.
> 
> And the final patch is the core conversion, as we have several structure
> relying on page array, it's impossible to just convert one algorithm to
> folio meanwhile keep all the other using pages.
> 
> 
> Qu Wenruo (6):
>   btrfs: compression: add error handling for missed page cache
>   btrfs: compression: convert page allocation to folio interfaces
>   btrfs: make insert_inline_extent() to accept one page directly
>   btrfs: migrate insert_inline_extent() to folio interfaces
>   btrfs: introduce btrfs_alloc_folio_array()
>   btrfs: compression: migrate compression/decompression paths to folios

I added this patchset to my misc-next and it was in linux-next until
now. The bug that was a blocker for folio conversions is now fixed,
also thanks to you, so we can continue with the conversions. As this
patchset is 2 months old I'm not sure if it would be helpful to start
commenting and do the normal iteration round, I did a review and style
fixup round and moved it to for-next. Please have a look and let me know
if you find something wrong. I did mostly whitespace changes, though I
did remove the ASSERT(0), if there's btrfs_crit message it's quite
noticeable, and removed the local variable for fs_info in the first one.

The conversions are all direct and seem safe to me, we won't do
multi-page folios yet, so the intemediate steps are the right way to go.
Thanks.

