Return-Path: <linux-btrfs+bounces-19426-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DB2FC9356F
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Nov 2025 02:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E9A84E02A9
	for <lists+linux-btrfs@lfdr.de>; Sat, 29 Nov 2025 01:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6817A30A;
	Sat, 29 Nov 2025 01:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vvg2+tUl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="M1xNWS/X";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vvWV9bpc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wsNYlj8P"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1DC8BEC
	for <linux-btrfs@vger.kernel.org>; Sat, 29 Nov 2025 01:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764378058; cv=none; b=p3JKty4+lrzhOoF4zYZO8Oieba0aiBmQj/OrwRWWpl54U01xQN0mfdY1g8AFxbivRKgsxuXN/2lXkKVpY72b+SBRjE5FB7+yBKNW2aWos3ol9KumVAfheFt+BCC519ZZg0LL36XT4bhW+5iwEjidizYzAj7v1K7b2KC5e/Vgck0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764378058; c=relaxed/simple;
	bh=RLTvWgWVPCYP18bxhuQBHfa6MPjpYbuglMugZe38LeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkCeSWcbQJYSfkD2VwZ0Flzo8Vo4P5VQBSNHlke72TUyDu8IVIBMBge0f4k1mpIKL/vDRzzOnMMOs5ch/LMu40DMkekBVDmMz132QMud931nLKtEzThJn9cAVhbUHbdEQsWH8r4Vdoy8ksFsZTMNyEXKBea1sCWS2HvanGtYAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vvg2+tUl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=M1xNWS/X; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vvWV9bpc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wsNYlj8P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E70A75BCC1;
	Sat, 29 Nov 2025 01:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764378055;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNxtAFFnTbFq/TFLv56mwgiYJHmSIKQDuZWGYVDugzo=;
	b=Vvg2+tUl/Zs0KRzaiNfcFWAI37OulfCx0jKTxKGQS5I+hvQrcVZElM3IxF7E1K6HsBqj2h
	eJc7EM2fwD6I01tAGzZsRIQVl6u81hsocVZ64LGtBpecrn0ZDisLJwg0+s8HbFuWTZizT/
	BUVyNKy1G33/AzTPGFRDE70VB+RIvTQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764378055;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNxtAFFnTbFq/TFLv56mwgiYJHmSIKQDuZWGYVDugzo=;
	b=M1xNWS/XjwDfj74qNrVjpbEOn80P18GpZ1OfAQjBhrMU2TNyYMLn6zE2Y1XfssDphDlAWZ
	J3pOwvBkYrlMh1CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764378054;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNxtAFFnTbFq/TFLv56mwgiYJHmSIKQDuZWGYVDugzo=;
	b=vvWV9bpclyE9/fayFdQDEOsx48jwgapTM0VzRZoy+SGrBNZGf1qjqoan8stlgdHvqM0QGC
	hnCjyhAI1mBFB/AjDM97T6l9VJJo6toC92GG1Mx79N8MGmktyjJKfEzWQ5jcYY96BAk03A
	RONDt5K21ypUJbV0dpzIg3uP/jNDkck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764378054;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNxtAFFnTbFq/TFLv56mwgiYJHmSIKQDuZWGYVDugzo=;
	b=wsNYlj8P1M8kcv3iDBAOBqiHAfsO2okEO8RmJug/BPLK/dKTyqUWVg+g8GI2910LOOqnZc
	7R+912gzkWn/3bDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE4713EA63;
	Sat, 29 Nov 2025 01:00:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FhjmLcZFKmkFIQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sat, 29 Nov 2025 01:00:54 +0000
Date: Sat, 29 Nov 2025 02:00:49 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Qu Wenruo <wqu@suse.com>,
	clm@fb.com, dsterba@suse.com, terrelln@fb.com,
	herbert@gondor.apana.org.au, linux-btrfs@vger.kernel.org,
	linux-crypto@vger.kernel.org, qat-linux@intel.com, cyan@meta.com,
	brian.will@intel.com, weigang.li@intel.com,
	senozhatsky@chromium.org
Subject: Re: [RFC PATCH 16/16] btrfs: add compression hw-accelerated offload
Message-ID: <20251129010049.GE13846@suse.cz>
Reply-To: dsterba@suse.cz
References: <20251128191531.1703018-1-giovanni.cabiddu@intel.com>
 <20251128191531.1703018-17-giovanni.cabiddu@intel.com>
 <1dc1adaf-635c-405b-84c9-97d9567f8c14@suse.com>
 <aSok4RiuQVZ8zckR@gcabiddu-mobl.ger.corp.intel.com>
 <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0617afdf-14d4-4642-8298-69ef71f53b4d@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Sat, Nov 29, 2025 at 10:29:04AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/11/29 09:10, Giovanni Cabiddu 写道:
> > Thanks for your feedback, Qu Wenruo.
> > 
> > On Sat, Nov 29, 2025 at 08:25:30AM +1030, Qu Wenruo wrote:
> [...]
> >> Not an compression/crypto expert, thus just comment on the btrfs part.
> >>
> >> sysfs is not a good long-term solution. Since it's already behind
> >> experiemental flags, you can just enable it unconditionally (with proper
> >> checks of-course).
> > The reason for introducing a sysfs attribute is to allow disabling the
> > feature to be able to unload the QAT driver or to assign a QAT device to
> > user space for example to QATlib or DPDK.
> > 
> > In the initial implementation, there was no sysfs switch because the
> > acomp tfm was allocated in the data path. With the current design,
> > where the tfm is allocated in the workspace, the driver remains
> > permanently in use.
> > 
> > Is there any other alternative to a sysfs attribute to dynamically
> > enable/disable this feature?
> 
> For all needed compression algorithm modules are loaded at btrfs module 
> load time (not mount time), thus I was expecting the driver being there 
> until the btrfs module is removed from kernel.
> 
> This is a completely new use case. Have no good idea on this at all. 
> Never expected an accelerated algorithm would even get removed halfway.
> 
> [...]
> >>
> >> This function get all input/output folios in a batch, but ubifs, which also
> >> uses acomp for compression, seems to only compress one page one time
> >> (ubifs_compress_folio()).
> >>
> >> I'm wondering what's preventing us from doing the existing folio-by-folio
> >> compression.
> >> Is the batch folio acquiring just for performance or something else?
> > There are a few reasons for using batch folio processing instead of
> > folio-by-folio compression:
> > 
> > * Performance: for a hardware accelerator like QAT, it is more efficient to
> >    process a larger chunk of data in a single request rather than issuing
> >    multiple small requests. (BTW, it would be even better if we could batch
> >    multiple requests and run them asynchronously!)
> > 
> > * API limitations: The current acomp interface is stateless. Supporting
> >    folio-by-folio compression with proper streaming would require changes
> >    to introduce a stateful API.
> 
> BTW, is there any extra benefit of using acomp interface (independent of 
> QAT acceleration)?

The promise of the acomp interface is that the CPU can be handed to
other processes while the async hw does the compression. Using the async
requests has some problems with deadlocks and allocation. The async
crypto API has been deprecated or removed where used, IIRC fsverity.

> If so we may consider experiment with it first and migrate btrfs to that 
> interface step by step, and making extra accelerated algorithms easier 
> to implement.

I had a prototype for acomp and switching to it via sysfs but once I
saw the patches removing acomp I scrapped it. The QAT is a bit different
as it's extensible, the acomp hw engines I assume the interface was made
for were hw cards and accelerators that eg. implemented zlib. With QAT
we can have LZO, ZSTD so it's worth adding the support.

