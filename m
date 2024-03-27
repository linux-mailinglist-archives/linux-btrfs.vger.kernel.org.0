Return-Path: <linux-btrfs+bounces-3687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B38B88F361
	for <lists+linux-btrfs@lfdr.de>; Thu, 28 Mar 2024 00:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 208101F28D15
	for <lists+linux-btrfs@lfdr.de>; Wed, 27 Mar 2024 23:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1FB154450;
	Wed, 27 Mar 2024 23:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SK1/IG2Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hwCgheNH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SK1/IG2Z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hwCgheNH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369BA22094
	for <linux-btrfs@vger.kernel.org>; Wed, 27 Mar 2024 23:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711583978; cv=none; b=o6VDU2r4nkv520PsDCufJJRWI29dnwA6DE//nwXA8KlZOT7kd189qwrIEw17S9n9BG3KxCBIrHqByurNtLLrrLjIg2ty983MZmYu62M1hGoAuv5EiofCr366mCxZ5dcnW8wbiGm3uIy2kyGIf8tx0Nc/+GM8tpjiovOn7TJNhMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711583978; c=relaxed/simple;
	bh=jZG3oFTty8ULKEBX2VcLI5TXEIjSZ1dWObAL2UC/cWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoZWF5BQfYPmqRHZZejSYmIZhK9jIHvh4QnCK1MU9RXVm3T92Q0FYG/LFXgv1iJfTL1njeP2/VQiUzYX8b9CzfdsdR5Tmb3JnVPzyRqK+ILx3WzCgswUSqFPBY70j5+8/e0S6o5oLLEtDBWUcv0KTrp6YSF1UQwRalwiFil6uus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SK1/IG2Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hwCgheNH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SK1/IG2Z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hwCgheNH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 387251FF97;
	Wed, 27 Mar 2024 23:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711583968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OOyQvGM5FwSmvz8bjvSAbkB1KT1kCGTg5hnI+oq4VC8=;
	b=SK1/IG2ZmnyFpAtffbNLuYj6Ci4PxAJDA8DSAzq6mv+4/Yn6WL1j5CpESGhNazikBK93FC
	ZEYg640jjm3AM06BfVSPovyuRwkpv7a0ngJhk9w2VpQTzpTQE95/v9LA5wXp4/dUnSEzTS
	+3k2CvkYkut1U30XAsJDS3pdGoJ0HZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711583968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OOyQvGM5FwSmvz8bjvSAbkB1KT1kCGTg5hnI+oq4VC8=;
	b=hwCgheNHjBKC2eeOAY6bfZtJmAiLQ2S7xjdT9d1iLYSX8Q+qwc1pZ2Wb8jr0tWSQkZ4U9s
	tsY+rXF4nxySlTCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711583968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OOyQvGM5FwSmvz8bjvSAbkB1KT1kCGTg5hnI+oq4VC8=;
	b=SK1/IG2ZmnyFpAtffbNLuYj6Ci4PxAJDA8DSAzq6mv+4/Yn6WL1j5CpESGhNazikBK93FC
	ZEYg640jjm3AM06BfVSPovyuRwkpv7a0ngJhk9w2VpQTzpTQE95/v9LA5wXp4/dUnSEzTS
	+3k2CvkYkut1U30XAsJDS3pdGoJ0HZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711583968;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OOyQvGM5FwSmvz8bjvSAbkB1KT1kCGTg5hnI+oq4VC8=;
	b=hwCgheNHjBKC2eeOAY6bfZtJmAiLQ2S7xjdT9d1iLYSX8Q+qwc1pZ2Wb8jr0tWSQkZ4U9s
	tsY+rXF4nxySlTCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2920F133B5;
	Wed, 27 Mar 2024 23:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id yTjlCeCyBGbKSQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 27 Mar 2024 23:59:28 +0000
Date: Thu, 28 Mar 2024 00:52:10 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/6] btrfs-progs: zoned devices support for bgt feature
Message-ID: <20240327235210.GX14596@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1711412540.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711412540.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -2.34
X-Spamd-Result: default: False [-2.34 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.17)[-0.860];
	 RCPT_COUNT_TWO(0.00)[2];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.37)[90.66%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Flag: NO

On Tue, Mar 26, 2024 at 10:52:40AM +1030, Qu Wenruo wrote:
> [REPO]
> https://github.com/adam900710/btrfs-progs/tree/zoned_bgt
> 
> There is a bug report that, the following tool would fail on zone
> devices:
> 
> - mkfs.btrfs -O block-group-tree
> - btrfstune --convert-to-block-group-tree|--convert-from-block-group-tree
> 
> The mkfs failure is caused by zoned incompatible pwrite() calls for
> block group tree metadata.
> 
> The btrfstune failure is caused by the incorrectly opened fd.
> 
> 
> Before fixing both bugs, do two small cleanups, one caught by clangd LSP
> server, the other caught by my later check on the test case output (a
> missing newline).
> 
> Then fixes for each bug, and new test cases for each bug.
> 
> Qu Wenruo (6):
>   btrfs-progs: remove unused header for tune/main.c
>   btrfs-progs: tune: add the missing newline for
>     --convert-from-block-group-tree
>   btrfs-progs: mkfs: use proper zoned compatible write for bgt feature
>   btrfs-progs: tune: properly open zoned devices for RW
>   btrfs-progs: tests-mkfs: add test case for zoned block group tree
>     feature
>   btrfs-progs: tests-misc: add a test case to check zoned bgt conversion

Added to devel, thanks.

