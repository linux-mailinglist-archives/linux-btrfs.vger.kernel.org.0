Return-Path: <linux-btrfs+bounces-1245-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7DB824629
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 17:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135341F23FDB
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Jan 2024 16:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE583250F2;
	Thu,  4 Jan 2024 16:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wJYn6Xai";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bBI1t9XC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wJYn6Xai";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bBI1t9XC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30894250E6
	for <linux-btrfs@vger.kernel.org>; Thu,  4 Jan 2024 16:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E438220D1;
	Thu,  4 Jan 2024 16:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704385707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYzrrE3v7lBa2e039YOpg9MsRdb3XEcoLNodp1f9bhc=;
	b=wJYn6XaiwT8CQCMMxiftURXOf6lyHabhyUJxH12t8Hy1W2C5QA5J7xwQBl8xRRXSZ3zM0J
	KjRmQ5kR8pMAVOBqDUPSUMkz1zgsZ/NGodbgr0lRG7B+G+EaFVdvRv+chre3BtBQA99zTj
	HtPkW49kZq7UXgyezATu4hpLoiFMcvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704385707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYzrrE3v7lBa2e039YOpg9MsRdb3XEcoLNodp1f9bhc=;
	b=bBI1t9XCa8RmMynF2q5FsKZwUebN/wC1NF66WZ08tEcTlvwX9sD8bR0fBRoY6I2QYHQMFg
	kcYIrLrYP+fE8LBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704385707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYzrrE3v7lBa2e039YOpg9MsRdb3XEcoLNodp1f9bhc=;
	b=wJYn6XaiwT8CQCMMxiftURXOf6lyHabhyUJxH12t8Hy1W2C5QA5J7xwQBl8xRRXSZ3zM0J
	KjRmQ5kR8pMAVOBqDUPSUMkz1zgsZ/NGodbgr0lRG7B+G+EaFVdvRv+chre3BtBQA99zTj
	HtPkW49kZq7UXgyezATu4hpLoiFMcvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704385707;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bYzrrE3v7lBa2e039YOpg9MsRdb3XEcoLNodp1f9bhc=;
	b=bBI1t9XCa8RmMynF2q5FsKZwUebN/wC1NF66WZ08tEcTlvwX9sD8bR0fBRoY6I2QYHQMFg
	kcYIrLrYP+fE8LBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 023A3137E8;
	Thu,  4 Jan 2024 16:28:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wRArAKvclmXoXgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 04 Jan 2024 16:28:27 +0000
Date: Thu, 4 Jan 2024 17:28:11 +0100
From: David Sterba <dsterba@suse.cz>
To: Naohiro Aota <naohiro.aota@wdc.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: zoned: fix lock ordering in btrfs_zone_activate()
Message-ID: <20240104162811.GH15380@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6e209698b6956fb5cc9da480ac194a6d79426148.1703220899.git.naohiro.aota@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e209698b6956fb5cc9da480ac194a6d79426148.1703220899.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: **
X-Spam-Level: 
X-Spam-Score: -0.21
X-Rspamd-Queue-Id: 1E438220D1
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=wJYn6Xai;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bBI1t9XC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [-0.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 URIBL_BLOCKED(0.00)[wdc.com:email,suse.cz:dkim];
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
	 RCVD_TLS_ALL(0.00)[]

On Fri, Dec 22, 2023 at 01:56:34PM +0900, Naohiro Aota wrote:
> The btrfs CI reported a lockdep warning as follows by running generic
> generic/129.
> 
>    ======================================================
>    WARNING: possible circular locking dependency detected
>    6.7.0-rc5+ #1 Not tainted
>    ------------------------------------------------------
>    kworker/u5:5/793427 is trying to acquire lock:
>    ffff88813256d028 (&cache->lock){+.+.}-{2:2}, at: btrfs_zone_finish_one_bg+0x5e/0x130
>    but task is already holding lock:
>    ffff88810a23a318 (&fs_info->zone_active_bgs_lock){+.+.}-{2:2}, at: btrfs_zone_finish_one_bg+0x34/0x130
>    which lock already depends on the new lock.
> 
>    the existing dependency chain (in reverse order) is:
>    -> #1 (&fs_info->zone_active_bgs_lock){+.+.}-{2:2}:
>    ...
>    -> #0 (&cache->lock){+.+.}-{2:2}:
>    ...
> 
> This is because we take fs_info->zone_active_bgs_lock after a block_group's
> lock in btrfs_zone_activate() while doing the opposite other place.
> 
> Fix the issue by expanding the fs_info->zone_active_bgs_lock's critical
> section and taking it before a block_group's lock.
> 
> CC: stable@vger.kernel.org # 6.6
> Fixes: a7e1ac7bdc5a ("btrfs: zoned: reserve zones for an active metadata/system block group")
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>

Added to misc-next, thanks.

