Return-Path: <linux-btrfs+bounces-7696-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A28D5966926
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 20:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4CD1F2366C
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Aug 2024 18:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E911BC07B;
	Fri, 30 Aug 2024 18:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xkLhIyio";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BCZJ1hec";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZL2E9gkv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+9v/wZhL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6C1BAEF5
	for <linux-btrfs@vger.kernel.org>; Fri, 30 Aug 2024 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725043879; cv=none; b=mfS+MKRdEm4i3mwekW53ApGTd3gW+b+w9H2JWv+YihjPOmhauNSVD+vQiJqrGRgUdmgq8+SlGXwKq19+c/9K4PqjbArIB4tkKntEihFI+g0fCabCCy+bs0xORPGz2g1hPPyOYxJokFZIkg1bJtan3ML61HBHEqXn1U/U577dWDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725043879; c=relaxed/simple;
	bh=Lsod64vaXmE90REbi9W12j5Cnnu8oNRQV5fFaQt/OsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEIwXW5b1r2CEM0RG5WuDU2REdaiz/RnVqCc3legliuoMg8JPWFhHQl8eLkPLjEKmyvHixVSZlcgC8OLRwxB1DGAoP1PsRiHVHicJuBFpf1+IwVTYzyosR/K0FOhCGqXZuEjqVob5iRzO06wjEICHs2wOq2RcgqE2DkHcXsjTXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xkLhIyio; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BCZJ1hec; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZL2E9gkv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+9v/wZhL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DF16821976;
	Fri, 30 Aug 2024 18:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725043875;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35q/mDFpG5dlBuwRZTQY3wlBe3KE4GK11fpWan/jwkk=;
	b=xkLhIyio2+OsmVVpsm1YQzaOwTQygSe9z51/e/2Oyic8Fk71WKz4hH1D7yXCFgtKzZxS5L
	sdmpvVVs3RHuajX4tDLAanfSPr1yUESgoi96U5SpUylFc6E6ePzYN5+fi7VdrYqNhgk7Ie
	T3VsHdN1hWVChPm4Nx1/1nB6L+8CepE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725043875;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35q/mDFpG5dlBuwRZTQY3wlBe3KE4GK11fpWan/jwkk=;
	b=BCZJ1hecKLdhYpqYx2u4gaGYaZcfGvwKOsjQyknvoht6OYwkdj3+Ym+aN1fVnECkNumJpv
	JEoItxRg/En1tbBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725043874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35q/mDFpG5dlBuwRZTQY3wlBe3KE4GK11fpWan/jwkk=;
	b=ZL2E9gkv9PIy6mP1te1Xo3slORJGxtdQjSdxBila03VHry3MeO28NftUn1wd4cEOBUph+n
	LVNJKJTsAoc13TSQBQco8khzIGtKsG/EgyiRAKvtoAvkRL8C0xyJv03r/CSBPuDkK8dO5z
	f0392duWeiYJBt86TtlyXkUbs+XUvjU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725043874;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=35q/mDFpG5dlBuwRZTQY3wlBe3KE4GK11fpWan/jwkk=;
	b=+9v/wZhLyDzkPQsHURb8BjRD6zCcgT/3uMmRgfmyTN9UwuoRkQwGUTWYdki6dpyY5l9KDS
	xffA9HgquZMyHyAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C415B139D3;
	Fri, 30 Aug 2024 18:51:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vuagL6IU0mb3NAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 Aug 2024 18:51:14 +0000
Date: Fri, 30 Aug 2024 20:51:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Rolf Wentland <R.Wentland@gmx.de>
Subject: Re: [PATCH v3] btrfs: interrupt fstrim if the current process is
 freezing
Message-ID: <20240830185113.GW25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <eeffae0b8beecb3406f43ff48e788fd9d88fb2e2.1724971143.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eeffae0b8beecb3406f43ff48e788fd9d88fb2e2.1724971143.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmx.de];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid,suse.com:url,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, Aug 30, 2024 at 08:09:11AM +0930, Qu Wenruo wrote:
> [BUG]
> There is a bug report that running fstrim will prevent the system from
> hibernation, result the following dmesg:
> 
>  PM: suspend entry (deep)
>  Filesystems sync: 0.060 seconds
>  Freezing user space processes
>  Freezing user space processes failed after 20.007 seconds (1 tasks refusing to freeze, wq_busy=0):
>  task:fstrim          state:D stack:0     pid:15564 tgid:15564 ppid:1      flags:0x00004006
>  Call Trace:
>   <TASK>
>   __schedule+0x381/0x1540
>   schedule+0x24/0xb0
>   schedule_timeout+0x1ea/0x2a0
>   io_schedule_timeout+0x19/0x50
>   wait_for_completion_io+0x78/0x140
>   submit_bio_wait+0xaa/0xc0
>   blkdev_issue_discard+0x65/0xb0
>   btrfs_issue_discard+0xcf/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_discard_extent+0x120/0x2a0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   do_trimming+0xd4/0x220 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   trim_bitmaps+0x418/0x520 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_trim_block_group+0xcb/0x130 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_trim_fs+0x119/0x460 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_ioctl_fitrim+0xfb/0x160 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   btrfs_ioctl+0x11cc/0x29f0 [btrfs 7ab35b9b86062a46f6ff578bb32d55ecf8e6bf82]
>   __x64_sys_ioctl+0x92/0xd0
>   do_syscall_64+0x5b/0x80
>   entry_SYSCALL_64_after_hwframe+0x7c/0xe6
>  RIP: 0033:0x7f5f3b529f9b
>  RSP: 002b:00007fff279ebc20 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>  RAX: ffffffffffffffda RBX: 00007fff279ebd60 RCX: 00007f5f3b529f9b
>  RDX: 00007fff279ebc90 RSI: 00000000c0185879 RDI: 0000000000000003
>  RBP: 000055748718b2d0 R08: 00005574871899e8 R09: 00007fff279eb010
>  R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000003
>  R13: 000055748718ac40 R14: 000055748718b290 R15: 000055748718b290
>   </TASK>
>  OOM killer enabled.
>  Restarting tasks ... done.
>  random: crng reseeded on system resumption
>  PM: suspend exit
>  PM: suspend entry (s2idle)
>  Filesystems sync: 0.047 seconds
> 
> [CAUSE]
> PM code is freezing all user space processes before entering
> hibernation/suspension, but if a user space process is trapping into the
> kernel for a long running operation, it will not be frozen since it's
> still inside kernel.
> 
> Normally those long running operations check for fatal signals and exit
> early, but freezing user space processes is not done by signals but a
> different infrastructure.
> 
> Unfortunately btrfs only checks fatal signals but not if the current
> task is being frozen for fstrim.
> 
> [FIX]
> For now just do the extra freezing() check at a per-block-group basis.
> 
> Reported-by: Rolf Wentland <R.Wentland@gmx.de>
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1229737
> Signed-off-by: Qu Wenruo <wqu@suse.com>

As a quick fix it's ok, I hope there's some way to support freezing of
the ioctls, try_to_freeze() or schedule() at the right time could work.

Reviewed-by: David Sterba <dsterba@suse.com>

