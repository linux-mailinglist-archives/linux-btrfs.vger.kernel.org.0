Return-Path: <linux-btrfs+bounces-19665-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8356BCB6E23
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 19:16:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 677B33017EC3
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Dec 2025 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD5A319875;
	Thu, 11 Dec 2025 18:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tuGhzwx1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8NWGNJWT";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tuGhzwx1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8NWGNJWT"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840003C1F
	for <linux-btrfs@vger.kernel.org>; Thu, 11 Dec 2025 18:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765476960; cv=none; b=MS7kpPgHhqh2XoEjEDA6a7JJqsbYA1acBcXtCDEPtHaM65w+sVpi8LMl7H0oGGHUQuAQzXPjuHeicc5aMz6tg5btnw76VVy5E94m0yuEGzmBNstRuM3Az09qFW+PBx+QZ7aSUhwG7Aue6PbmRtWbFPVITDjVmtqshRZWgJD/zJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765476960; c=relaxed/simple;
	bh=BNkwMkQ6iAwJLxIZ+poqI5QKq0qdYinRNZ5BVQ9jQYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glBqJ/4SA/LkPVmNDo52lkUEDVyGk89XvSPywwTw9yDpy76IuXoS4Gyrf/AfFFP5VQBuGENAGvOwmRwa+rJLm9i9qOgYsWb/+7I8moVoChue9mQqYg9nye9UAzfXD1VHhn8CjdXLkTMJOBTTzpgNBEa5fnZOC+SyjLrMhFDZ5t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tuGhzwx1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8NWGNJWT; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tuGhzwx1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8NWGNJWT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C57D8336CC;
	Thu, 11 Dec 2025 18:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765476956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofdmDeA3OU+kRRQ2wBRxIZ4DGKOu9EUmHI9zF+u5AEg=;
	b=tuGhzwx122mfxJXJe1f5OMx89qYP0uEIxim0bvtu503j/pzsZSbf2SD0dMjuhK+5mJk3Rd
	i1JhNipa24P02fSUilLh5gnM1wWdajSk9Qs/7w2Nuw8jkAFZgfgYrdeakF5TwZZ1ASGqY6
	AN+QIfgnhX1otlIggJrNafiOT7ocwzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765476956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofdmDeA3OU+kRRQ2wBRxIZ4DGKOu9EUmHI9zF+u5AEg=;
	b=8NWGNJWT+zy4ctVPGSx8Yv4NIlk4vVc1RQT6HyigOzuLJvLhNzsPMVzJMiz+mKRCbUu82D
	eynLPgKCGmNInUCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765476956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofdmDeA3OU+kRRQ2wBRxIZ4DGKOu9EUmHI9zF+u5AEg=;
	b=tuGhzwx122mfxJXJe1f5OMx89qYP0uEIxim0bvtu503j/pzsZSbf2SD0dMjuhK+5mJk3Rd
	i1JhNipa24P02fSUilLh5gnM1wWdajSk9Qs/7w2Nuw8jkAFZgfgYrdeakF5TwZZ1ASGqY6
	AN+QIfgnhX1otlIggJrNafiOT7ocwzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765476956;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ofdmDeA3OU+kRRQ2wBRxIZ4DGKOu9EUmHI9zF+u5AEg=;
	b=8NWGNJWT+zy4ctVPGSx8Yv4NIlk4vVc1RQT6HyigOzuLJvLhNzsPMVzJMiz+mKRCbUu82D
	eynLPgKCGmNInUCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC6223EA63;
	Thu, 11 Dec 2025 18:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A+ftKVwKO2kKEAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 11 Dec 2025 18:15:56 +0000
Date: Thu, 11 Dec 2025 19:15:51 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/301: use correct blocksize to fill the fs
Message-ID: <20251211181551.GJ4859@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251209085213.110213-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209085213.110213-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.94 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.14)[-0.699];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.94

On Tue, Dec 09, 2025 at 07:22:13PM +1030, Qu Wenruo wrote:
> [FAILURE]
> When running the test with 8K fs block size (tried both 4K page size and
> 64K page size), the test case btrfs/301 always fail like this:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-custom+ #323 SMP PREEMPT_DYNAMIC Mon Dec  8 07:38:30 ACDT 2025
> MKFS_OPTIONS  -- -s 8k /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> btrfs/301    42s ... - output mismatch (see /home/adam/xfstests/results//btrfs/301.out.bad)
>     --- tests/btrfs/301.out	2024-01-02 14:44:11.140000000 +1030
>     +++ /home/adam/xfstests/results//btrfs/301.out.bad	2025-12-09 19:14:32.057824678 +1030
>     @@ -1,18 +1,71 @@
>      QA output created by 301
>      basic accounting
>     +subvol 256 mismatched usage 41099264 vs 33964032 (expected data 33554432 expected meta 409600 diff 7135232)
>     +subvol 256 mismatched usage 175316992 vs 168181760 (expected data 167772160 expected meta 409600 diff 7135232)
>     +subvol 256 mismatched usage 41099264 vs 33964032 (expected data 33554432 expected meta 409600 diff 7135232)
>     +subvol 256 mismatched usage 41099264 vs 33964032 (expected data 33554432 expected meta 409600 diff 7135232)
>      fallocate: Disk quota exceeded
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/btrfs/301.out /home/adam/xfstests/results//btrfs/301.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Although the subvolume usage doesn't match the expectation, "btrfs check"
> doesn't report any qgroup number mismatch.
> This means the qgroup numbers are correct, but our expectation is not.
> 
> Upon inspection of the on-disk file extents, there are a lot of file
> extents that are partially overwritten.
> 
> This means during the fio random writes, there are fs blocks that are
> partially written, then written back to the storage, then written again.
> This is a symptom of too small IO block size.
> 
> The default FIO blocksize is only 4K, and it will result the above
> overwrite of the same fs block for 8K fs block size.
> 
> [FIX]
> Add blocksize option to the fio config, so that we won't have
> above over-write behavior which boost the qgroup numbers.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

