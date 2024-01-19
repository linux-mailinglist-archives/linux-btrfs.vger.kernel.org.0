Return-Path: <linux-btrfs+bounces-1574-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4697A832CAB
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 17:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AC74B22FF9
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 16:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BF254BFD;
	Fri, 19 Jan 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RU8Gteb4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+fzVLUL7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TUtah5jz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="V5hyIQJC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23454BE8
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jan 2024 16:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680086; cv=none; b=AH5g+WPU9pKEANGxSGAhE2rB+Nx9vbH9tFeWThjQTlOvk0lCrMxB8G/JukRulkjZQ0J+vTBXG+JrqTsVe3zJic8X9BS8Y5rhgDSSX8hE3USiPTWp3UXdKR4SVPRP0Zs+EEDfaKvdAAnkhdcWUIrs/RJOaBpFJmkL/gbJGnArd24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680086; c=relaxed/simple;
	bh=IQadk+QEc7t5ilJqGoKcOWkXeR8IFDMY4EGL5/KdKYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mumeB0T/BF7ZIWlS4MCBa8nAJGzU3jYyRu4J0xizQToG3gpndEwbnaviDiO7JuqEaJyYvWUaswaXNn5eRlvHip6zEbOjfAbQlJEEBpxFfXTE0EhHNIiJvXecShXeLEeFd8IOHs2PhKPZw9+UpMSSS3k59Ea6QUbtf0AEL0Y7bdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RU8Gteb4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+fzVLUL7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TUtah5jz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=V5hyIQJC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8EF5A2205B;
	Fri, 19 Jan 2024 16:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705680082;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DusS4YxfStZkGWZHuZ1FSdbwlcveQQDufWFoA3yjJ4g=;
	b=RU8Gteb4xRq0BX1Ago284StSwRhR2hYXBrcc9G+5xC/o83dWssUkso7+E+Qko70TNl8nM+
	mSb8mtcj8gzBRzvi8rNTchLTeZlVVSw6WlVTpNjhw6S9X6z5lTBzv4HDBJtXThtbu++HNG
	35etUP5WH6G4R4F5n3t7TV6TBDqy/4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705680082;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DusS4YxfStZkGWZHuZ1FSdbwlcveQQDufWFoA3yjJ4g=;
	b=+fzVLUL7CHpoRHh7OFHO/nB8qaVd/f75XYoovnzH4XiGsTaZsBlugKr471ht31S94ZNY3b
	B74/ABxgb36tDHCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705680081;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DusS4YxfStZkGWZHuZ1FSdbwlcveQQDufWFoA3yjJ4g=;
	b=TUtah5jzBW9z5f7mixEHKtflpXdzEUFy9D++Mq5+HrxfwARIBSEPIK5yRTNoMoo4Wk9uad
	GM5ND5Zuir8mRfkht2Wrs2K9tkQAbpwRsl/kLEqDGAGjg0ITvWjyqlzHIuM1GeH/S/Es7z
	aTndvrx3djXeBD51oL6Bk/kaFVX152A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705680081;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DusS4YxfStZkGWZHuZ1FSdbwlcveQQDufWFoA3yjJ4g=;
	b=V5hyIQJCOHtTEJ8pYFePfXkdKsF6Ycl5St0QRV4uf2arCuVK40VZBbUxGElzVxOyku5WPM
	IWjpReeAjcFSVWCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DE7E1343E;
	Fri, 19 Jan 2024 16:01:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SHxaGtGcqmWQCgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 19 Jan 2024 16:01:21 +0000
Date: Fri, 19 Jan 2024 17:01:01 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org, wangyugui@e16-tech.com
Subject: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev striped
 FS
Message-ID: <20240119160101.GT31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1705568050.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1705568050.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TUtah5jz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=V5hyIQJC
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[26.39%]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: 8EF5A2205B
X-Spam-Flag: NO

On Thu, Jan 18, 2024 at 05:54:49PM +0900, Naohiro Aota wrote:
> There was a report of write performance regression on 6.5-rc4 on RAID0
> (4 devices) btrfs [1]. Then, I reported that BTRFS_FS_CSUM_IMPL_FAST
> and doing the checksum inline can be bad for performance on RAID0
> setup [2]. 

First, please don't name it 'inline checksum', it's so confusing because
we have 'inline' as inline files and also the inline checksums stored in
the b-tree nodes.

> [1] https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@e16-tech.com/
> [2] https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> 
> While inlining the fast checksum is good for single (or two) device,
> but it is not fast enough for multi-device striped writing.
> 
> So, this series first introduces fs_devices->inline_csum_mode and its
> sysfs interface to tweak the inline csum behavior (auto/on/off). Then,
> it disables inline checksum when it find a block group striped writing
> into multiple devices.

How is one supposed to know if and how the sysfs knob should be set?
This depends on the device speed(s), profiles and number of devices, can
the same decision logic be replicated inside btrfs? Such tuning should
be done automatically (similar things are done in other subystems like
memory management).

With such type of setting we'll get people randomly flipping it on/off
and see if it fixes performance, without actually looking if it's
relevant or not. We've seen this with random advice circling around
internet how to fix enospc problems, it's next to impossible to stop
that so I really don't want to allow that for performance.

