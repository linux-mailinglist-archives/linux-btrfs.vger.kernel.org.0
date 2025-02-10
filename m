Return-Path: <linux-btrfs+bounces-11363-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39131A2F4E5
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 18:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DCA01684D8
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Feb 2025 17:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32D2451C3;
	Mon, 10 Feb 2025 17:13:18 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF8255E38
	for <linux-btrfs@vger.kernel.org>; Mon, 10 Feb 2025 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739207597; cv=none; b=kUAJZ8RjE8H8uM73ko8+YrloQp9P4U+k/FkYHrtT+XVtICw1ElDzOv5nFlualwRzkdxPfHaTiBbRb3G6vc4PYLbCzeMGzDA4e3EUHQq1dSTyZ0i8o3RSLgNY0hAUOcvZBM3l2rwtm/C939kPHxNEouFqnwKPy99qBB8NirQ/qK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739207597; c=relaxed/simple;
	bh=yKzIKTOD/fiA26L/V5zc2jbsVic0vs7n58B1CcBeLAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r916C5SvbtGDRYcj8QLDbCk1PPfQff9TAm3AYS4AD+PDlqK/hD8nBK92N5b873nBdIPfwzXjgbtYXl3LMaD69v0Xx0hG6edrNny2xVGsHJy/FqigJsxmxyvax/hSqjcXTlgRejkXi+qy7Qotc4DVBPBtn9RrFlSrL03w60xtjLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0A69C21111;
	Mon, 10 Feb 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D541513707;
	Mon, 10 Feb 2025 17:13:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CpNJM6kzqmfKWwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 10 Feb 2025 17:13:13 +0000
Date: Mon, 10 Feb 2025 18:13:08 +0100
From: David Sterba <dsterba@suse.cz>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix btrfs_test_delayed_refs leak
Message-ID: <20250210171308.GQ5777@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250210111728.32320-2-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210111728.32320-2-ddiss@suse.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 0A69C21111
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 

On Mon, Feb 10, 2025 at 10:17:29PM +1100, David Disseldorp wrote:
> The btrfs_transaction struct leaks, which can cause sporadic xfstests
> failures when kmemleak checking is enabled:
> 
> kmemleak: 5 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> > cat /sys/kernel/debug/kmemleak
> unreferenced object 0xffff88810fdc6c00 (size 512):
>   comm "modprobe", pid 203, jiffies 4294892552
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 6736050f):
>     __kmalloc_cache_noprof+0x133/0x2c0
>     btrfs_test_delayed_refs+0x6f/0xbb0 [btrfs]
>     btrfs_run_sanity_tests.cold+0x91/0xf9 [btrfs]
>     0xffffffffa02fd055
>     do_one_initcall+0x49/0x1c0
>     do_init_module+0x5b/0x1f0
>     init_module_from_file+0x70/0x90
>     idempotent_init_module+0xe8/0x2c0
>     __x64_sys_finit_module+0x6b/0xd0
>     do_syscall_64+0x54/0x110
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> The transaction struct was initially stack-allocated but switched to
> heap following frame size compiler warnings.
> 
> Fixes: 2b34879d97e27 ("btrfs: selftests: add delayed ref self test cases")
> Link: https://lore.kernel.org/all/20241206195100.GM31418@twin.jikos.cz/
> Signed-off-by: David Disseldorp <ddiss@suse.de>

Added to for-next, thanks.

