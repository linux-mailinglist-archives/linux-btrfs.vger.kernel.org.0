Return-Path: <linux-btrfs+bounces-2637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D25F85F790
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 12:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A362B24919
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Feb 2024 11:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27FB45BF9;
	Thu, 22 Feb 2024 11:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KrWxaVn0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZmP8Full";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KrWxaVn0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZmP8Full"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E8145976
	for <linux-btrfs@vger.kernel.org>; Thu, 22 Feb 2024 11:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708602892; cv=none; b=MIDLaCRfNkpUMQKWwHSfscDXHcI6EKd2xY7Vvua9ffbDm4IY3Ew8jDKQ38nTvNsETJzajHywx625c7c4wZhVI4BQSwyMIA/j3hvWqq+jqBLqyDcwXLamPzhOrnSAYRmT1Nkw+plnWORQXJgoV1l/VZqSlqq7vciAB8jnmtE2ZwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708602892; c=relaxed/simple;
	bh=epbzZbPG+SUDPlaE1GQSabPiQhdWeBgbMFj9apbTLa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SdHwxyZmQEALMKZgb8PYAPpA03hVoKDhYpF/sLq+NvgaFaH2kmKVnJQ3LrWyDEx2jKWOSsd1ysSG4kE2LAzGoJQ1Oo2pQIh+A89BcABq3z4CtLvL4cNPDqvdHmzSnGv2wzzdiZvvxPKDqFgU/ID3IAZKDTOOvGKhIWwQ0RPdWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KrWxaVn0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZmP8Full; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KrWxaVn0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZmP8Full; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5CB311FB9A;
	Thu, 22 Feb 2024 11:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708602888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCtTsnVQzaPwH9ChwlEpeZ3dQhry828TCEc5yGa9hVY=;
	b=KrWxaVn0OUoEYQIyLapS8e+XsYiP6z6/smM/GMtYWmZB/YWn7Rlc8OISJROd13xkpThQuS
	SWndVX7TAjkAZPtYxQwGMVtENicavkY9jko0nD3NEY9TK4IH/yLN8pizslia1eFOHUADIG
	56F560FKFHguip744lHVMb15UwBQujM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708602888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCtTsnVQzaPwH9ChwlEpeZ3dQhry828TCEc5yGa9hVY=;
	b=ZmP8FullKc5JUHRJIuDZEenJiSHt94KIA1vqsdxkCwCQ+gbfAWB4nsBnj6ukNu6X2iHvSA
	HlpCKScmQJ3WNmCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708602888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCtTsnVQzaPwH9ChwlEpeZ3dQhry828TCEc5yGa9hVY=;
	b=KrWxaVn0OUoEYQIyLapS8e+XsYiP6z6/smM/GMtYWmZB/YWn7Rlc8OISJROd13xkpThQuS
	SWndVX7TAjkAZPtYxQwGMVtENicavkY9jko0nD3NEY9TK4IH/yLN8pizslia1eFOHUADIG
	56F560FKFHguip744lHVMb15UwBQujM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708602888;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TCtTsnVQzaPwH9ChwlEpeZ3dQhry828TCEc5yGa9hVY=;
	b=ZmP8FullKc5JUHRJIuDZEenJiSHt94KIA1vqsdxkCwCQ+gbfAWB4nsBnj6ukNu6X2iHvSA
	HlpCKScmQJ3WNmCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 48E0F13A6B;
	Thu, 22 Feb 2024 11:54:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id sHebEQg212U7QQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Thu, 22 Feb 2024 11:54:48 +0000
Date: Thu, 22 Feb 2024 12:54:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 0/3] btrfs: make subpage reader/writer counter to be
 sector aware
Message-ID: <20240222115406.GN355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1708151123.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1708151123.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KrWxaVn0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZmP8Full
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-0.997];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -4.21
X-Rspamd-Queue-Id: 5CB311FB9A
X-Spam-Flag: NO

On Sat, Feb 17, 2024 at 04:59:47PM +1030, Qu Wenruo wrote:
> [CHANGELOG]
> v2:
> - Add btrfs_subpage_dump_bitmap() support for locked bitmap
> 
> - Add spinlock to protect the bitmap and locked bitmap operation
>   In theory, this opeartion should always be single threaded, since the
>   page is locked.
>   But to keep the behavior consistent, use spin lock to protect bitmap
>   and atomic reader/write updates.
> 
> This can be fetched from github, and the branch would be utilized for
> all newer subpage delalloc update to support full sector sized
> compression and zoned:
> https://github.com/adam900710/linux/tree/subpage_delalloc
> 
> Currently we just trace subpage reader/writer counter using an atomic.
> 
> It's fine for the current subpage usage, but for the future, we want to
> be aware of which subpage sector is locked inside a page, for proper
> compression (we only support full page compression for now) and zoned support.
> 
> So here we introduce a new bitmap, called locked bitmap, to trace which
> sector is locked for read/write.
> 
> And since reader/writer are both exclusive (to each other and to the same
> type of lock), we can safely use the same bitmap for both reader and
> writer.
> 
> In theory we can use the bitmap (the weight of the locked bitmap) to
> indicate how many bytes are under reader/write lock, but it's not
> possible yet:
> 
> - No weight support for bitmap range
>   The bitmap API only provides bitmap_weight(), which always starts at
>   bit 0.
> 
> - Need to distinguish read/write lock
> 
> Thus we still keep the reader/writer atomic counter.
> 
> Qu Wenruo (3):
>   btrfs: unexport btrfs_subpage_start_writer() and
>     btrfs_subpage_end_and_test_writer()
>   btrfs: subpage: make reader lock to utilize bitmap
>   btrfs: subpage: make writer lock to utilize bitmap

So this is preparatory work and looks safe to me, only adding the
bitmaps to counters, you can add it to for-next.

