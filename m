Return-Path: <linux-btrfs+bounces-19751-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66CCBF6F2
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 19:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8934C3016CCB
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Dec 2025 18:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F43A268690;
	Mon, 15 Dec 2025 18:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eatnPw43";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QS7UkUGn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UJ+9s2Kf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a0+126/G"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC7271A6D
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Dec 2025 18:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765823265; cv=none; b=WFbp+1br0Oqua/XXyCaMVtyP23qKv5xZQXYMxeDPFecULOWz1hrWpcTDcm+aRXkt50l91UEG/RA+AzUgYHtEbXamqyUernGzo4MGMYsenwEePxKY4hEmPsTwR33NWgOzDOGPJB1DAsvYKgQpJ6MSjyD2AukXKZPKKZyfOLRtIa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765823265; c=relaxed/simple;
	bh=ZpEEWd3W7s/OPB4IoO4OTEjwEFrvzXP5ZvwDzoV2ID0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3M1XO5vgw3ypEoSUOAAL4CfSiy4OntguPInf7q1Jz41z8Ww1va9rTClulmtF5dGq7LxLu6sBaGiYV8vsbR5GEm5HE2hMeSgNJ6j1IpKtOO3FFhZpIveAQq0i/T0MIWTrFXNpDX9wqMCuFSfFDF78z+xbkB9DrjRuSvhCY+cvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eatnPw43; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QS7UkUGn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UJ+9s2Kf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a0+126/G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16B4A336F9;
	Mon, 15 Dec 2025 18:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765823262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVfEEMvG0YXZ1ksN0MHBFHziQtswAIIOuNianF7RZpo=;
	b=eatnPw43Zt+uJ6z5BqMeVPfNNYVHWqcO7MUfuFNPg5N57i4LoqLxPFYhqR7j8WR+kvb6G0
	USYpWAFXWBY0OuQ7LlXkVgstY2ZFdRQsl09uEjJUpP8lSbKPBkTCZ3CnqGIQ0fQx6o6ogT
	mS4ofxvZ71pneL/6qg4LZysoIKNrv84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765823262;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVfEEMvG0YXZ1ksN0MHBFHziQtswAIIOuNianF7RZpo=;
	b=QS7UkUGnFVsaTHV+834Eri4JJNCXCEsrmyUEJGJ3Jdzee27O3R/nxQxp6ZSuudOUJIHX4h
	gTg6/iVe+frssJBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1765823261;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVfEEMvG0YXZ1ksN0MHBFHziQtswAIIOuNianF7RZpo=;
	b=UJ+9s2KfZe1aJmqMgvA1T2jNfvfKhe7oax9E4UDOHbY8v3x/xBJduTP7KLFug5PAXhhjs/
	gJeHwI9EB3/rkH9JD6BP34tZL7B66i4nNoSG5UdVpoZMzzqTMLC4oFC67Pq+arSWA8/O9B
	uMl7LT5XQdoOo53BFJJknyoOSq/OnD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1765823261;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVfEEMvG0YXZ1ksN0MHBFHziQtswAIIOuNianF7RZpo=;
	b=a0+126/Gwzhv5UTYMztnajp5nT+0XWJ2gUKDn5oQJF07b8NE8KiqPYlwFs9d2bAYUUj8dG
	0KBOC+wHM6A9HCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3A023EA63;
	Mon, 15 Dec 2025 18:27:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id m5JNOxxTQGm7dgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 15 Dec 2025 18:27:40 +0000
Date: Mon, 15 Dec 2025 19:27:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2] fstests: generic/746: update the parser to handle
 block group tree
Message-ID: <20251215182735.GB3195@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20251205071726.159577-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205071726.159577-1-wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.95 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.15)[-0.730];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.95

On Fri, Dec 05, 2025 at 05:47:26PM +1030, Qu Wenruo wrote:
> [FALSE ALERT]
> The test case will fail on btrfs if the new block-group-tree feature is
> enabled:
> 
> FSTYP         -- btrfs
> PLATFORM      -- Linux/x86_64 btrfs-vm 6.18.0-rc6-custom+ #321 SMP PREEMPT_DYNAMIC Sun Nov 23 16:34:33 ACDT 2025
> MKFS_OPTIONS  -- -O block-group-tree /dev/mapper/test-scratch1
> MOUNT_OPTIONS -- /dev/mapper/test-scratch1 /mnt/scratch
> 
> generic/746 44s ... [failed, exit status 1]- output mismatch (see xfstests-dev/results//generic/746.out.bad)
>     --- tests/generic/746.out	2024-06-27 13:55:51.286338519 +0930
>     +++ xfstests-dev/results//generic/746.out.bad	2025-11-28 07:47:17.039827837 +1030
>     @@ -2,4 +2,4 @@
>      Generating garbage on loop...done.
>      Running fstrim...done.
>      Detecting interesting holes in image...done.
>     -Comparing holes to the reported space from FS...done.
>     +Comparing holes to the reported space from FS...Sectors 256-2111 are not marked as free!
>     ...
>     (Run 'diff -u xfstests-dev/tests/generic/746.out xfstests-dev/results//generic/746.out.bad'  to see the entire diff)
> 
> [CAUSE]
> Sectors [256, 2048) are the from the reserved first 1M free space.
> Sectors [2048, 2112) are the leading free space in the chunk tree.
> Sectors [2112, 2144) is the first tree block in the chunk tree.
> 
> However the reported free sectors from get_free_sectors() looks like this:
> 
>   2144 10566
>   10688 11711
>   ...
> 
> Note that there should be a free sector range in [2048, 2112) but it's
> not reported in get_free_sectors().
> 
> The get_free_sectors() call is fs dependent, and for btrfs it's using
> parse-extent-tree.awk script to handle the extent tree dump.
> 
> The script uses BLOCK_GROUP_ITEM items to detect the beginning of a
> block group so that it can calculate the hole between the beginning of a
> block group and the first data/metadata item.
> 
> However block-group-tree feature moves BLOCK_GROUP_ITEM items to a
> dedicated tree, making the existing script unable to parse the free
> space at the beginning of a block group.
> 
> [FIX]
> Introduce a new script, parse-free-space.py, that accepts two tree
> dumps:
> 
> - block group tree dump
>   If the fs has block-group-tree feature, it's the block group tree
>   dump.
>   Otherwise the regular extent tree dump is enough.
> 
> - extent tree dump
>   The usual extent tree dump.
> 
> With a dedicated block group tree dump, the script can correctly handle
> the beginning part of free space, no matter if block-group-tree feature
> is enabled or not.
> 
> And with this parser, the old parse-extent-tree.awk can be retired.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add extra requirement for python3 if the fs is btrfs
> - Utilize $PYTHON3_PROG other than calling the script directly
> - Add the comment on we need single DATA/METADATA profiles

Reviewed-by: David Sterba <dsterba@suse.com>

