Return-Path: <linux-btrfs+bounces-12441-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F568A69CBA
	for <lists+linux-btrfs@lfdr.de>; Thu, 20 Mar 2025 00:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83B13B5C7C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 23:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106C2248AB;
	Wed, 19 Mar 2025 23:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a4MyDtml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XUSqnf8t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="a4MyDtml";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XUSqnf8t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B17224889
	for <linux-btrfs@vger.kernel.org>; Wed, 19 Mar 2025 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742426861; cv=none; b=lncQUO0EaHvgP6Jch9mPkXoiJmet/em8VSynYc7oeOwbasz1YOOK3AHxmB9Uus6TK3DvGicx2uAzitmCrvbSfFW+2pGgTSx7V61R/3UO8QaqJnffluUZ95Gt8L6pVJidfQA5vViveq1lPSn8hezJD+l0F0sJBpx6Jqkj6Ssy96U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742426861; c=relaxed/simple;
	bh=y6gtyRAWCt5Iox9BLf6Q/dB+izrd77W9dsoTj9Q1pJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BSskArlncdd0r3KYkIAXn1CyMo/toQ2EmQnpdIuWEO0tn2IBaT/gdRxdTHiTgIFe7cM9uB2USc9m9j56FkXnAcVIgKhFOc+aVniAKMr5iAv90GkieI+i0BqJ9sRT3LZqPJ40OIx2lB3HonciNu/gS2Gf3Zj4Jlbg4AVTBg+zVlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a4MyDtml; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XUSqnf8t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=a4MyDtml; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=XUSqnf8t; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E5471FE20;
	Wed, 19 Mar 2025 23:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742426857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkvKNyEtijcFbX12fWINJXQYly9lXHtzwUCmxZdiIkA=;
	b=a4MyDtmleP60WBBx3VoftXX4mNkVjn6edUTicmh7QB9qbqH6JEt0YcHAX/mRNU4aEEjZW9
	OnIJZya7Sl0C3YM8c4BymnCCDW4sgvEcP8mqQPGkL8RlMTtSr3YSu8s90ygv96kFr/dOTQ
	D+Uyt8pZidM95fWXtZXvoz4uXH1ajEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742426857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkvKNyEtijcFbX12fWINJXQYly9lXHtzwUCmxZdiIkA=;
	b=XUSqnf8to8KQ3RUc2zaFJE41VLh5ooj0BabMFdJMjUa3q7Xb0yx9e3VnAdL3Y2E2auWiIB
	Ia8mYHGYmNaO6BCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1742426857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkvKNyEtijcFbX12fWINJXQYly9lXHtzwUCmxZdiIkA=;
	b=a4MyDtmleP60WBBx3VoftXX4mNkVjn6edUTicmh7QB9qbqH6JEt0YcHAX/mRNU4aEEjZW9
	OnIJZya7Sl0C3YM8c4BymnCCDW4sgvEcP8mqQPGkL8RlMTtSr3YSu8s90ygv96kFr/dOTQ
	D+Uyt8pZidM95fWXtZXvoz4uXH1ajEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1742426857;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hkvKNyEtijcFbX12fWINJXQYly9lXHtzwUCmxZdiIkA=;
	b=XUSqnf8to8KQ3RUc2zaFJE41VLh5ooj0BabMFdJMjUa3q7Xb0yx9e3VnAdL3Y2E2auWiIB
	Ia8mYHGYmNaO6BCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D5A313726;
	Wed, 19 Mar 2025 23:27:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fXw0GulS22cTVAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 19 Mar 2025 23:27:37 +0000
Date: Thu, 20 Mar 2025 00:27:36 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/2] btrfs-progs: allowing 2K block size for experimental
 builds
Message-ID: <20250319232736.GR32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1740542229.git.wqu@suse.com>
 <20250319214912.GM32661@twin.jikos.cz>
 <57216433-0829-48bf-af23-d9959611974c@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57216433-0829-48bf-af23-d9959611974c@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu, Mar 20, 2025 at 08:49:06AM +1030, Qu Wenruo wrote:
> 
> 
> 在 2025/3/20 08:19, David Sterba 写道:
> > On Wed, Feb 26, 2025 at 02:29:13PM +1030, Qu Wenruo wrote:
> >> Btrfs always has its minimal block size as 4K, but that means on the
> >> most common architecture, x86_64, we can not utilize the subpage block
> >> size routine at all.
> >>
> >> Although the future larger folios support will allow us to utilize
> >> subpage routines, the support is still not yet there.
> >>
> >> On the other hand, lowering the block size for experimental/debug builds is
> >> much easier, there is only one major bug (fixed by the first patch) in
> >> btrfs-progs at least.
> >>
> >> Kernel sides enablement is not huge either, but it has dependency on
> >> the subpage related backlog patches to pass most fstests, which is not small.
> >>
> >> However since we're not pushing this 2K block size for end users, we can
> >> accept some limitations on the 2K block size support:
> >>
> >> - No 2K node size mkfs support
> >>    This is mostly caused by how we create the initial temporaray fs.
> >>    The initial temporaray fs contains at least 6 root items.
> >>    But one root item is 439 bytes, we need a level 1 root tree for the
> >>    initial temporaray fs.
> >>
> >>    But we do not support multi-level trees for the initial fs, thus no
> >>    such support for now.
> >>
> >> - No mixed block groups mkfs support
> >>    Caused by the missing 2K node size support
> >>
> >> Qu Wenruo (3):
> >>    btrfs-progs: fix the incorrect buffer size for super block
> >>    btrfs-progs: support 2k block size
> >>    btrfs-progs: convert: check the sectorsize against BTRFS_MIN_BLOCKSIZE
> > 
> > Thanks, added to devel. I've enabled the 2k case for convert but it
> > fails, I haven't analyzed it as it does not seem to be important right
> > now.
> 
> 2K convert needs the ext4 to use 2K block size too, which is only 
> lightly tested here.

So the failure I was observing was because I extended ext2 test (001),
ext4 works.

> E.g. at least it works here:
> 
> ./btrfs-convert ~/test.img
> btrfs-convert from btrfs-progs v6.12
> 
> WARNING: blocksize 2048 is not equal to the page size 4096, converted 
> filesystem won't mount on this system
> Source filesystem:
>    Type:           ext2
>    Label:
>    Blocksize:      2048
>    UUID:           e004c54c-7a86-4c71-be87-a8ff707c3948
> Target filesystem:
>    Label:
>    Blocksize:      2048
>    Nodesize:       16384
>    UUID:           b54b8947-7f7a-4e3b-a658-d344a1d47766
>    Checksum:       crc32c
>    Features:       extref, skinny-metadata, no-holes, free-space-tree 
> (default)
>      Data csum:    yes
>      Inline data:  yes
>      Copy xattr:   yes
> Reported stats:
>    Total space:      5368709120
>    Free space:       4693164032 (87.42%)
>    Inode count:          327680
>    Free inodes:          327668
>    Block count:         2621440
> Create initial btrfs filesystem
> Create ext2 image file
> Create btrfs metadata
> Copy inodes [o] [         0/        12]
> Free space cache cleared
> Conversion complete
> 
> But it should not be considered a feature for end users.

Agreed.

