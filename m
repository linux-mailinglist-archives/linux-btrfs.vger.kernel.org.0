Return-Path: <linux-btrfs+bounces-2155-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBBAA84B58C
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 13:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C2F1F222C2
	for <lists+linux-btrfs@lfdr.de>; Tue,  6 Feb 2024 12:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8838112F385;
	Tue,  6 Feb 2024 12:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JGTiF3zE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ToJCbcpz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WH2o8oQT";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i6J4CPl8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47BA12B142
	for <linux-btrfs@vger.kernel.org>; Tue,  6 Feb 2024 12:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707223637; cv=none; b=JJm23CaOM+B7wZLZR4ZCQibnYUU+zMT6pAhbOSNS2PjDXaXMGUK+ZDKcuDRyNTVTl5C4QjKEA2IT6RTqzdtEGFQzfr9qlMQ83acfQnpH4vMPIINacl9NZQQdi+XE65WhBHp087JROOFENQ4KPNt+MEnUf7Ss3Kperq7shWlie4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707223637; c=relaxed/simple;
	bh=cuuh+9OjfV4CJR2nXF1lfrwTI/6unr7X9rFJNeRl9Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nRALHHUX6utx38aZPHOo1Ur+1XhttPAmkvmJTXUGTAyrdXTrMXn2dS18s/OFZ1M+e8ZctRPNqbq/etBqy/UAbsPk6DB1Xr7XPobzCfh76gTPhSw1evtB0um0wyGk3Li7R/chz/55z/9kJhnJTroGcsydmivMfNq+crii+2Ib27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JGTiF3zE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ToJCbcpz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WH2o8oQT; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i6J4CPl8; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9ED21FB7A;
	Tue,  6 Feb 2024 12:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707223632;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Mzo4dkKGcCGmIrWkNANTwhtBzwXKIKKEtA0kUjQk/M=;
	b=JGTiF3zEN7KRBlQHa4yd4sLuUcfUg9Av9CqCHv/8nYarYRXWiztF3uKUQ+W2TxV0i/yQq4
	ilZa3x55vdHWnOGyWFeoK1uOzCjMok5F7p84kxr+6OVujX7pZEiYpjtmuZ6QCM3FM/oYG7
	sCEyU5cWqtGNarls33qwwmpsVc/oPuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707223632;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Mzo4dkKGcCGmIrWkNANTwhtBzwXKIKKEtA0kUjQk/M=;
	b=ToJCbcpz6GIk4PTVJICUdqIpdB5CHKCkH0tAr1pBxtYCB3+kAnIJmckMn2k29Pd6l3fRF9
	VJRURiXrxvrgwZCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707223631;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Mzo4dkKGcCGmIrWkNANTwhtBzwXKIKKEtA0kUjQk/M=;
	b=WH2o8oQTP2mMSBC2GeCiokd7W+sB1Qdn7Q7wzhXcM2kXmd7EdDVsipjMmB2KiFGKbwWV63
	8i/qFfZzUHUOf/SNxl2p42aVkbbA3VZepvpwhLduc5A5Bu0tqc7Bxhtr0iJRrjn7P7BYWG
	NpM0GUca08vDC3Pvnhyr0bTt1eRB46o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707223631;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5Mzo4dkKGcCGmIrWkNANTwhtBzwXKIKKEtA0kUjQk/M=;
	b=i6J4CPl8AM9rQxNyifj/O4HbaqBjnECQD1K890XxfzPXvjmmSW4PdJn4yE+otAl0CvGIXX
	fO7tRWx/k22IkRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4A3B139D8;
	Tue,  6 Feb 2024 12:47:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hkMBKE8qwmViMAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 06 Feb 2024 12:47:11 +0000
Date: Tue, 6 Feb 2024 13:46:42 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: tree-checker: dump the page status if hit
 something wrong
Message-ID: <20240206124642.GM355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f51a6d5d7432455a6a858d51b49ecac183e0bbc9.1706312914.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WH2o8oQT;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i6J4CPl8
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,marc.info:url,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B9ED21FB7A
X-Spam-Level: 
X-Spam-Score: -3.01
X-Spam-Flag: NO

On Sat, Jan 27, 2024 at 10:18:36AM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report about very suspicious tree-checker got triggered:
> 
>   BTRFS critical (device dm-0): corrupted node, root=256
> block=8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]
>   BTRFS critical (device dm-0): corrupted node, root=256
> block=8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]
>   BTRFS critical (device dm-0): corrupted node, root=256
> block=8550954455682405139 owner mismatch, have 11858205567642294356
> expect [256, 18446744073709551360]
>   SELinux: inode_doinit_use_xattr:  getxattr returned 117 for dev=dm-0
> ino=5737268
> 
> [ANALYZE]
> The root cause is still unclear, but there are some clues already:
> 
> - Unaligned eb bytenr
>   The block bytenr is 8550954455682405139, which is not even aligned to
>   2.
>   This bytenr is fetched from extent buffer header, not from eb->start.
> 
>   This means, at the initial time of read, eb header bytenr is still
>   correct (the very basis check to continue read), but later something
>   wrong happened, got at least the first page corrupted.
>   Thus we got such obviously incorrect value.
> 
> - Invalid extent buffer header owner
>   The read itself is triggered for subvolume 256, but the eb header
>   owner is 11858205567642294356, which is not really possible.
>   The problem here is, subovlume id is limited to (1 << 48 - 1),
>   and this one definitely goes beyond that limit.
> 
>   So this value is another garbage.
> 
> We already got two garbage from an extent buffer, which passed the
> initial bytenr and csum checks, but later the contents become garbage at
> some point.
> 
> This looks like a page lifespan problem (e.g. we didn't proper hold the
> page).
> 
> [ENHANCEMENT]
> The current tree-checker only output things from the extent buffer,
> nothing with the page status.
> 
> So this patch would enhance the tree-checker output by also dumpping the
> first page, which would look like this:
> 
>  page:00000000aa9f3ce8 refcount:4 mapcount:0 mapping:00000000169aa6b6 index:0x1d0c pfn:0x1022e5
>  memcg:ffff888103456000
>  aops:btree_aops [btrfs] ino:1
>  flags: 0x2ffff0000008000(private|node=0|zone=2|lastcpupid=0xffff)
>  page_type: 0xffffffff()
>  raw: 02ffff0000008000 0000000000000000 dead000000000122 ffff88811e06e220
>  raw: 0000000000001d0c ffff888102fdb1d8 00000004ffffffff ffff888103456000
>  page dumped because: eb page dump
>  BTRFS critical (device dm-3): corrupt leaf: root=5 block=30457856 slot=6 ino=257 file_offset=0, invalid disk_bytenr for file extent, have 10617606235235216665, should be aligned to 4096
>  BTRFS error (device dm-3): read time tree block corruption detected on logical 30457856 mirror 1
> 
> >From the dump we can see some extra info, something can help us to do
> extra cross-checks:
> 
> - Page refcount
>   if it's too low, it definitely means something bad.
> 
> - Page aops
>   Any mapped eb page should have btree_aops with inode number 1.
> 
> - Page index
>   Since a mapped eb page should has its bytenr matching the page
>   position, (index << PAGE_SHIFT) should match the bytenr of the
>   bytenr from the critical line.
> 
> - Page Private flags
>   A mapped eb page should have Private flag set to indicate it's managed
>   by btrfs.
> 
> Link: https://marc.info/?l=linux-btrfs&m=170629708724284&w=2

Please use a link to lore.kernel.org, this keeps the threading and the
message id is in the url so it's possible to look it up elsewhere.

> Signed-off-by: Qu Wenruo <wqu@suse.com>

For debugging the patch is useful, I'd say go on and add it.

Reviewed-by: David Sterba <dsterba@suse.com>

