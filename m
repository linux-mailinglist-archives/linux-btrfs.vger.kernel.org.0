Return-Path: <linux-btrfs+bounces-10103-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178A49E7951
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 20:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0538169A0B
	for <lists+linux-btrfs@lfdr.de>; Fri,  6 Dec 2024 19:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D801C1DA31D;
	Fri,  6 Dec 2024 19:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQOXGv3a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+YovQLAg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BQOXGv3a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+YovQLAg"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F814146A87
	for <linux-btrfs@vger.kernel.org>; Fri,  6 Dec 2024 19:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733514926; cv=none; b=HIvC/eWf34NRdA6xg5LpKiAbJRfo8il6sVgJTit2AN0jBEVs2otH348aqrL48BfuEwotQ40gj9fWtyyhKJvC04xPUanDgwKivCZqw1ksz7/+vzeUz1v9YiIS/xJWDN16m7NlqyVwsmO6wdsZZPDH6toLi3fK3yBfqt1wcCCsKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733514926; c=relaxed/simple;
	bh=PhiGygppZaDnuSpaqL1m2M5ljQ49SOG/Z9JkBTMgUk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8szRfBiyUuoCFBHNJjtP+h6MfZC1NF5SINOPKdjz1GlRHJAX0pbW/pCtix1Jib8M7evOOyCHK3hD2nGWAUTBDX4+pebmQedMlllAkL3iD7uIFBlL9G0/lDuz9vV4BYYMz4qgU/liTo5kqKozmPJWHL1d7P/jv2zuVGzA6seXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQOXGv3a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+YovQLAg; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BQOXGv3a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+YovQLAg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 305F31F37E;
	Fri,  6 Dec 2024 19:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733514922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLMDsba7kXUNrwY6aOjrlIQ2H6Mt9k2sNfFX9x8AKqk=;
	b=BQOXGv3a7nc3BU1gHYVc9CTbpML74XbL1SlAc2142uqabhK6XBNQi3ETt5A3xGgaFoSe8T
	v3877mgtz5xHzR9Y9Cfogjc3taiBrjVj1eoyI3Oc4QrJ3odpEko0X1Hfb1GNqRI8y7pV2s
	hpTswV4MJclz4oxKUesQHV/sCP3I5c8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733514922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLMDsba7kXUNrwY6aOjrlIQ2H6Mt9k2sNfFX9x8AKqk=;
	b=+YovQLAgpermq2q18QW0Y7rudV2xXhVB+8du1KyezxtJQCNzc6oObugHtJjPnebIdMtON0
	wwxvQzPoJOMAkvDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733514922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLMDsba7kXUNrwY6aOjrlIQ2H6Mt9k2sNfFX9x8AKqk=;
	b=BQOXGv3a7nc3BU1gHYVc9CTbpML74XbL1SlAc2142uqabhK6XBNQi3ETt5A3xGgaFoSe8T
	v3877mgtz5xHzR9Y9Cfogjc3taiBrjVj1eoyI3Oc4QrJ3odpEko0X1Hfb1GNqRI8y7pV2s
	hpTswV4MJclz4oxKUesQHV/sCP3I5c8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733514922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLMDsba7kXUNrwY6aOjrlIQ2H6Mt9k2sNfFX9x8AKqk=;
	b=+YovQLAgpermq2q18QW0Y7rudV2xXhVB+8du1KyezxtJQCNzc6oObugHtJjPnebIdMtON0
	wwxvQzPoJOMAkvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1579213647;
	Fri,  6 Dec 2024 19:55:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5SfGBKpWU2fQRQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 06 Dec 2024 19:55:22 +0000
Date: Fri, 6 Dec 2024 20:55:16 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: improve the warning and error message for
 btrfs_remove_qgroup()
Message-ID: <20241206195516.GN31418@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <b33c149624408ed79068df8bd2b5d5670176120d.1731272337.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b33c149624408ed79068df8bd2b5d5670176120d.1731272337.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Mon, Nov 11, 2024 at 07:29:07AM +1030, Qu Wenruo wrote:
> [WARNING]
> There are several warnings about the recently introduced qgroup
> auto-removal that it triggers WARN_ON() for the non-zero rfer/excl
> numbers, e.g:
> 
>  ------------[ cut here ]------------
>  WARNING: CPU: 67 PID: 2882 at fs/btrfs/qgroup.c:1854 btrfs_remove_qgroup+0x3df/0x450
>  CPU: 67 UID: 0 PID: 2882 Comm: btrfs-cleaner Kdump: loaded Not tainted 6.11.6-300.fc41.x86_64 #1
>  RIP: 0010:btrfs_remove_qgroup+0x3df/0x450
>  Call Trace:
>   <TASK>
>   btrfs_qgroup_cleanup_dropped_subvolume+0x97/0xc0
>   btrfs_drop_snapshot+0x44e/0xa80
>   btrfs_clean_one_deleted_snapshot+0xc3/0x110
>   cleaner_kthread+0xd8/0x130
>   kthread+0xd2/0x100
>   ret_from_fork+0x34/0x50
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  ---[ end trace 0000000000000000 ]---
>  BTRFS warning (device sda): to be deleted qgroup 0/319 has non-zero numbers, rfer 258478080 rfer_cmpr 258478080 excl 0 excl_cmpr 0
> 
> [CAUSE]
> Although the root cause is still unclear, as if qgroup is consistent a
> fully dropped subvolume (with extra transaction committed) should lead
> to all zero numbers for the qgroup.
> 
> My current guess is the subvolume drop triggered the new subtree drop
> threshold thus marked qgroup inconsistent, then rescan cleared it but
> some corner case is not properly handled during subvolume dropping.
> 
> But at least for this particular case, since it's only the rfer/excl not
> properly reset to 0, and qgroup is already marked inconsistent, there is
> nothing to be worried for the end users.
> 
> The user space tool utilizing qgroup would queue a rescan to handle
> everything, so the kernel wanring is a little overkilled.
> 
> [ENHANCEMENT]
> Enhance the warning inside btrfs_remove_qgroup() by:
> 
> - Only do WARN() if CONFIG_BTRFS_DEBUG is enabled
>   As explained the kernel can handle inconsistent qgroups by simply do a
>   rescan, there is nothing to bother the end users.
> 
> - Treat the reserved space leak the same as non-zero numbers
>   By outputting the values and trigger a WARN() if it's a debug build.
>   So far I haven't experienced any case related to reserved space so I
>   hope we will never need to bother them.
> 
> Fixes: 839d6ea4f86d ("btrfs: automatically remove the subvolume qgroup")
> Link: https://github.com/kdave/btrfs-progs/issues/922
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

