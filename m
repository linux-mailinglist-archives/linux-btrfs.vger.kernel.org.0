Return-Path: <linux-btrfs+bounces-2069-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88385847019
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 13:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AB991F23789
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE55140787;
	Fri,  2 Feb 2024 12:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FkxGmaJf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R5pJ090f";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FkxGmaJf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="R5pJ090f"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E163A1C4
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876419; cv=none; b=FLo/EewnYNTGOagB9NumM1d3tj5u1/S5hW5zgQ+vkNm3tfXIs/QgjSibXjNWY71faFsHfn0JQqNrZ6lghittTlrweyfgKoSltlXSuiNyehI1VEkJk/y5TyI4I9syzuiPWE1P/UrqnfbVHBxrur1ZK/qP6kJ1t3PC/NBoGi/zGec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876419; c=relaxed/simple;
	bh=8j5VeJbKgXf/VhB/4DISPTfgeADl7jhY0y53lQ6C3F4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QZc4ODGBiEFgxtN7nwEZLCquSEyQICGKlv0yTfd6X3jFReNc6RYrYUGlSCSLDMnzksMQOFngrQ1TIBxf4yT1KQD0Mfj3kkJyRx8CgdE/J6i72ktgCLUcoe94f5mQ+NwbfBvHYVf9Ca3qApWGjFasJSraXO4r1WYp6/rQWWqp5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FkxGmaJf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R5pJ090f; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FkxGmaJf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=R5pJ090f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 372A621F40;
	Fri,  2 Feb 2024 12:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706876415;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiw9/QuTBLd6tLECQQHZdOADYI/Nbul+c6QDX/uTYeA=;
	b=FkxGmaJfJXF85quzh3Vn0iBxJs1w2tKLi/g/34djF4+JT2RRbEb3X/EaHD/72Zm4mxposr
	9ElZtetm0DsfXzmZD+1ym+Cucn/WTfj6ohKMaZ7/hWr2W/PLe7BBQo5iVmmQUPHK0V6ahX
	1TdXyZAWtyf1rSjSqaPHxBYNGDF/1HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706876415;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiw9/QuTBLd6tLECQQHZdOADYI/Nbul+c6QDX/uTYeA=;
	b=R5pJ090fTJOrGPHAYu9m/hEbSDtOEVFEBaMXb9hE12m9tunpvZf9Wj4ogAZbsgk6RUGxKy
	LvI2IwUHb0pCt6Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706876415;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiw9/QuTBLd6tLECQQHZdOADYI/Nbul+c6QDX/uTYeA=;
	b=FkxGmaJfJXF85quzh3Vn0iBxJs1w2tKLi/g/34djF4+JT2RRbEb3X/EaHD/72Zm4mxposr
	9ElZtetm0DsfXzmZD+1ym+Cucn/WTfj6ohKMaZ7/hWr2W/PLe7BBQo5iVmmQUPHK0V6ahX
	1TdXyZAWtyf1rSjSqaPHxBYNGDF/1HA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706876415;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kiw9/QuTBLd6tLECQQHZdOADYI/Nbul+c6QDX/uTYeA=;
	b=R5pJ090fTJOrGPHAYu9m/hEbSDtOEVFEBaMXb9hE12m9tunpvZf9Wj4ogAZbsgk6RUGxKy
	LvI2IwUHb0pCt6Cw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 18A94133DC;
	Fri,  2 Feb 2024 12:20:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 1gGNBf/dvGXdNwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 02 Feb 2024 12:20:15 +0000
Date: Fri, 2 Feb 2024 13:19:48 +0100
From: David Sterba <dsterba@suse.cz>
To: =?utf-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Message-ID: <20240202121948.GA31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FkxGmaJf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=R5pJ090f
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.73 / 50.00];
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
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.02)[52.83%]
X-Spam-Score: -2.73
X-Rspamd-Queue-Id: 372A621F40
X-Spam-Flag: NO

On Fri, Feb 02, 2024 at 04:13:13PM +0800, 韩于惟 wrote:
> Hi All,
> 
> I have built a RAID1 volume on HC620 using kernel 6.7.2 with btrfs debug 
> enabled.
> 
> Then I started BT download and sync, and it oops. dmesg in 
> https://fars.ee/N4pJ

The system has 16K pages and uses a zoned device, this crashes in the
end io write callback that does not seem to have subpage support:

[ 1863.303324]    ra: ffff8000025364b0 end_bio_extent_writepage+0x110/0x220 [btrfs]
[ 1863.303413]   ERA: ffff800002533464 btrfs_finish_ordered_extent+0x24/0xc0 [btrfs]

[ 1863.303638] Call Trace:
[ 1863.303639] [<ffff800002533464>] btrfs_finish_ordered_extent+0x24/0xc0 [btrfs]
[ 1863.303736] [<ffff8000025364b0>] end_bio_extent_writepage+0x110/0x220 [btrfs]
[ 1863.303831] [<ffff8000025d4510>] __btrfs_bio_end_io+0x50/0x80 [btrfs]
[ 1863.303924] [<ffff8000025d5118>] btrfs_submit_chunk+0x378/0x620 [btrfs]
[ 1863.304016] [<ffff8000025d5524>] btrfs_submit_bio+0x24/0x40 [btrfs]
[ 1863.304109] [<ffff800002535628>] submit_one_bio+0x48/0x80 [btrfs]
[ 1863.304204] [<ffff80000253a2bc>] extent_write_locked_range+0x31c/0x480 [btrfs]
[ 1863.304298] [<ffff800002510dc8>] run_delalloc_cow+0x88/0x160 [btrfs]
[ 1863.304393] [<ffff80000251186c>] btrfs_run_delalloc_range+0x10c/0x4c0 [btrfs]
[ 1863.304486] [<ffff800002536d1c>] writepage_delalloc+0xbc/0x1e0 [btrfs]
[ 1863.304579] [<ffff800002539874>] extent_write_cache_pages+0x274/0x7a0 [btrfs]
[ 1863.304672] [<ffff80000253a4c4>] extent_writepages+0xa4/0x1a0 [btrfs]
[ 1863.304765] [<900000000252ee14>] do_writepages+0x94/0x220

