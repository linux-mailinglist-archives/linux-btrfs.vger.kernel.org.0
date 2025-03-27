Return-Path: <linux-btrfs+bounces-12625-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F0A73E05
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 19:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A2263B4E3E
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDBE21A45F;
	Thu, 27 Mar 2025 18:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lKvbpbLK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sXUm9fwZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lKvbpbLK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sXUm9fwZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDAAF4F1
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 18:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743100015; cv=none; b=rg29H7n6zUAC6GWTzpCOVSPasorErSCXZDCJUozsr4RqDbLECQ5QFGJYCCvsCN49xwu/qxnNgJ65XRAqCeWzvOxnWGexOu++6fJO6UDLLzpwODuUutGO1hGEFBH5cJ5b6vPJiHjkx+TZ6sj+Og9JtzQoh43ZTYLWh2QK7kJ91kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743100015; c=relaxed/simple;
	bh=Wye4ZZIRenMNg0rzd6fYOpl1wP1Ygp5UfmQvcZqn7V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JYwxN77Frq7lA4rOzEkgNfaxJUMNrMm/MWjcB9hKHt1l+SW4Qir3th0z7wi/C26NE6dK7/UlfSNeJQluU2yxzxguPwR2YRmVnRT7b2jRNegutoBwg4g4dERehwMrM4WpjU5Sgxl6goQscqcj8+P2lTmnXLADVbzGz/XhN8UBdUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lKvbpbLK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sXUm9fwZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lKvbpbLK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sXUm9fwZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CEB401F388;
	Thu, 27 Mar 2025 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743100011;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REq7mGtPR43VXqkRphIgh4y/ph6O+Z7qjoRcgE8oyPg=;
	b=lKvbpbLKqUBc0REkBS6de+LEkwZgf77xiqGu4shF7oj1kl2WxnCAurlbjevyw8k0JQ3sa6
	eW0PDFaW5UrnhfbhLTV2Vv0U3l7dYQYfA3WpKS/0J9cidorKpWiWQFtTUYakZ++zTrfHKe
	hz0FCJebwAP8Dx7tmntKq+3VuQ8XpOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743100011;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REq7mGtPR43VXqkRphIgh4y/ph6O+Z7qjoRcgE8oyPg=;
	b=sXUm9fwZDeKEnlhehWr3NbcsjEffIsU20DLIh3GXCjynnE+UJOP8FRCFzkkW8Kjx/vjzk/
	hT5DDVuEGZ/Av/AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743100011;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REq7mGtPR43VXqkRphIgh4y/ph6O+Z7qjoRcgE8oyPg=;
	b=lKvbpbLKqUBc0REkBS6de+LEkwZgf77xiqGu4shF7oj1kl2WxnCAurlbjevyw8k0JQ3sa6
	eW0PDFaW5UrnhfbhLTV2Vv0U3l7dYQYfA3WpKS/0J9cidorKpWiWQFtTUYakZ++zTrfHKe
	hz0FCJebwAP8Dx7tmntKq+3VuQ8XpOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743100011;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=REq7mGtPR43VXqkRphIgh4y/ph6O+Z7qjoRcgE8oyPg=;
	b=sXUm9fwZDeKEnlhehWr3NbcsjEffIsU20DLIh3GXCjynnE+UJOP8FRCFzkkW8Kjx/vjzk/
	hT5DDVuEGZ/Av/AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B20DB139D4;
	Thu, 27 Mar 2025 18:26:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KEobK2uY5Wc7LAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Mar 2025 18:26:51 +0000
Date: Thu, 27 Mar 2025 19:26:50 +0100
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+1de7265d1e4c0c19dd35@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in btrfs_backref_release_cache
Message-ID: <20250327182650.GD32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <67b8c338.050a0220.14d86d.0594.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67b8c338.050a0220.14d86d.0594.GAE@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[1de7265d1e4c0c19dd35];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.50
X-Spam-Flag: NO

On Fri, Feb 21, 2025 at 10:17:28AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0ad2507d5d93 Linux 6.14-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14b775a4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b7bde34acd8f53b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=1de7265d1e4c0c19dd35
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0ad2507d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/dfb4fc7c042e/vmlinux-0ad2507d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1682113b81f5/bzImage-0ad2507d.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+1de7265d1e4c0c19dd35@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 32768
> BTRFS: device fsid ed167579-eb65-4e76-9a50-61ac97e9b59d devid 1 transid 8 /dev/loop0 (7:0) scanned by syz.0.0 (5320)
> BTRFS info (device loop0): first mount of filesystem ed167579-eb65-4e76-9a50-61ac97e9b59d
> BTRFS info (device loop0): using sha256 (sha256-avx2) checksum algorithm
> BTRFS info (device loop0): rebuilding free space tree
> BTRFS info (device loop0): disabling free space tree
> BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE (0x1)
> BTRFS info (device loop0): clearing compat-ro feature flag for FREE_SPACE_TREE_VALID (0x2)
> BTRFS info (device loop0): balance: start -d -m
> BTRFS info (device loop0): relocating block group 6881280 flags data|metadata
> BTRFS info (device loop0): relocating block group 5242880 flags data|metadata
> BTRFS info (device loop0): found 139 extents, stage: move data extents
> assertion failed: !cache->nr_nodes, in fs/btrfs/backref.c:3160
> ------------[ cut here ]------------
> kernel BUG at fs/btrfs/backref.c:3160!

void btrfs_backref_release_cache(struct btrfs_backref_cache *cache)
{
        struct btrfs_backref_node *node;

        while ((node = rb_entry_safe(rb_first(&cache->rb_root),
                                     struct btrfs_backref_node, rb_node)))
                btrfs_backref_cleanup_node(cache, node);

        ASSERT(list_empty(&cache->pending_edge));
        ASSERT(list_empty(&cache->useless_node));
        ASSERT(!cache->nr_nodes);

