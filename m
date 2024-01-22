Return-Path: <linux-btrfs+bounces-1620-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE93837524
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 22:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECE4288FEF
	for <lists+linux-btrfs@lfdr.de>; Mon, 22 Jan 2024 21:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F5D47F71;
	Mon, 22 Jan 2024 21:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PCaxyB9+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvGA8Cjg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PCaxyB9+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wvGA8Cjg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF31E47F64
	for <linux-btrfs@vger.kernel.org>; Mon, 22 Jan 2024 21:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705958413; cv=none; b=CGsf5cPjryc8XKtepDhTa6bR56crUN+IEagv6LK5c7LvTyI6AHZ3iJDL1mgn10G8QHajp5ark1UtKWf/qMCNhGwLvt3a0xAJ61sx08bhAqYyqQQS6Bq6dqMvtL0kBsJXwD//Lr37KUkmYdWUuCKvh3lAhVdGLMiJw9ncPPm1Yuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705958413; c=relaxed/simple;
	bh=g0lMQo9O/XPspPr4S3z/0tJNG5jfU+ebLheuMHLfvGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IGeYz9wS7T4DYeR0Lpj3B6ogn7GUMHTrwyLqByrRO0yWdQvNSQ0hjhUWiGvA3iVRg3C6Xnbb0M5nmy21kufvr26+ab78JCTUWJG62kdG/BSAdrRt282iWmFHUjvQ3rwHP1pku1W8630T8kpje7u9fyA5WXpsdklHJUgrtxfpwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PCaxyB9+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvGA8Cjg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PCaxyB9+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wvGA8Cjg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2BC9021FB4;
	Mon, 22 Jan 2024 21:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705958410;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EoFIbYwHAcz1lRiy9sSYZxSCirkhTg1kUq1G3KN5zyQ=;
	b=PCaxyB9+pQL+L2RKIBqnrw+Bf3xBJGQlf/kcuE4Y7RtNRB5DpR8Sl+wDwWsX/ZeG+sp4sy
	RdiMceSt1QEO09SZUQ5PdUrtdnBUETS8rzEw7r7YD4+lRzVIQ7uUNcajH0VW7L/lwIVJhb
	YiYQOzKcv+ivroqvchhhI35XOH5fFbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705958410;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EoFIbYwHAcz1lRiy9sSYZxSCirkhTg1kUq1G3KN5zyQ=;
	b=wvGA8CjgwKNlFDuaKWH0X4nUeMMMwkcSm0EvGF9eU5XBEYMQV7zdKhiTCy3MS1nvqilY29
	tqMhers7AhIwouBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705958410;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EoFIbYwHAcz1lRiy9sSYZxSCirkhTg1kUq1G3KN5zyQ=;
	b=PCaxyB9+pQL+L2RKIBqnrw+Bf3xBJGQlf/kcuE4Y7RtNRB5DpR8Sl+wDwWsX/ZeG+sp4sy
	RdiMceSt1QEO09SZUQ5PdUrtdnBUETS8rzEw7r7YD4+lRzVIQ7uUNcajH0VW7L/lwIVJhb
	YiYQOzKcv+ivroqvchhhI35XOH5fFbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705958410;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EoFIbYwHAcz1lRiy9sSYZxSCirkhTg1kUq1G3KN5zyQ=;
	b=wvGA8CjgwKNlFDuaKWH0X4nUeMMMwkcSm0EvGF9eU5XBEYMQV7zdKhiTCy3MS1nvqilY29
	tqMhers7AhIwouBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id EFB3313310;
	Mon, 22 Jan 2024 21:20:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SSewOQncrmVTfwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 22 Jan 2024 21:20:09 +0000
Date: Mon, 22 Jan 2024 22:19:48 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <Naohiro.Aota@wdc.com>
Cc: David Sterba <dsterba@suse.cz>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wangyugui@e16-tech.com" <wangyugui@e16-tech.com>
Subject: Re: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev
 striped FS
Message-ID: <20240122211948.GD31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705568050.git.naohiro.aota@wdc.com>
 <20240119160101.GT31555@twin.jikos.cz>
 <yr52hylpfmflnh6qpmzij5u2jgfj472srovdbl7uajlpwsrpry@sbeltaqj6ubn>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yr52hylpfmflnh6qpmzij5u2jgfj472srovdbl7uajlpwsrpry@sbeltaqj6ubn>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Mon, Jan 22, 2024 at 03:12:27PM +0000, Naohiro Aota wrote:
> On Fri, Jan 19, 2024 at 05:01:01PM +0100, David Sterba wrote:
> > On Thu, Jan 18, 2024 at 05:54:49PM +0900, Naohiro Aota wrote:
> > > There was a report of write performance regression on 6.5-rc4 on RAID0
> > > (4 devices) btrfs [1]. Then, I reported that BTRFS_FS_CSUM_IMPL_FAST
> > > and doing the checksum inline can be bad for performance on RAID0
> > > setup [2]. 
> > 
> > First, please don't name it 'inline checksum', it's so confusing because
> > we have 'inline' as inline files and also the inline checksums stored in
> > the b-tree nodes.
> 
> Sure. Sorry for the confusing naming. Is it OK to call it "sync checksum"?
> and "workqueue checksum" for the opposite?

Well 'sync' also already has a meaning :) we could call it 'checksum
offloading'.

> > > [1] https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
> > > [2] https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> > > 
> > > While inlining the fast checksum is good for single (or two) device,
> > > but it is not fast enough for multi-device striped writing.
> > > 
> > > So, this series first introduces fs_devices->inline_csum_mode and its
> > > sysfs interface to tweak the inline csum behavior (auto/on/off). Then,
> > > it disables inline checksum when it find a block group striped writing
> > > into multiple devices.
> > 
> > How is one supposed to know if and how the sysfs knob should be set?
> > This depends on the device speed(s), profiles and number of devices, can
> > the same decision logic be replicated inside btrfs? Such tuning should
> > be done automatically (similar things are done in other subystems like
> > memory management).
> 
> Yeah, I first thought it was OK to turn sync checksum off automatically on
> e.g, RAID0 case. But, as reported in [1], it becomes difficult. It might
> depend also on CPUs.
> 
> [1] https://lore.kernel.org/linux-btrfs/irc2v7zqrpbkeehhysq7fccwmguujnkrktknl3d23t2ecwope6@o62qzd4yyxt2/T/#u
> 
> > With such type of setting we'll get people randomly flipping it on/off
> > and see if it fixes performance, without actually looking if it's
> > relevant or not. We've seen this with random advice circling around
> > internet how to fix enospc problems, it's next to impossible to stop
> > that so I really don't want to allow that for performance.
> 
> Yes, I agree it's nasty to have a random switch.
> 
> But, in [1], I can't find a setup that has a better performance on sync
> checksum (even for SINGLE setup). So, I think, we need to rethink and
> examine the effectiveness of sync checksum vs workqueue checksum. So, for
> the evaluation, I'd like to leave the sysfs knob under CONFIG_BTRFS_DEBUG.

Ok to have it for debugging and evaluation. Thanks for the results [1],
clearly the switch to sync checksums was not backed by enough
benchmarks. As a fallback we can revert the change at the cost of
pessimizing the one case where it helped compared to several others
where it makes things works.

We might find a heuristic based on device type and turn it again
selectively, eg. for the NVMe-like devices.

