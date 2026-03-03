Return-Path: <linux-btrfs+bounces-22190-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBv/NDwKp2kDcgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22190-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 17:20:12 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 835F31F394D
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 17:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 683F530387ED
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 16:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86A7B4D8DAF;
	Tue,  3 Mar 2026 16:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DLiRyYqp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eBYYGf0t";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ziGKkZgU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="SDD7g3hQ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D1F4D2EC4
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 16:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554718; cv=none; b=ZOMOh89zQInZtJSPacQFfRt/PFFjGED1OkiMLhJLL1TjCJrTFdZ/3JzYYjfEBpPWGhpRzbDDE529iXsWSHth4ymmfchirw/pyKmvvbjzVbLkx8kKRvmt2FZGfLgDeDRTn1Zwd/z55//b4ycci1OEDF2yEWjOCLom7Zw98S4lfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554718; c=relaxed/simple;
	bh=UHYUouiud3+67OyLdloymmVTmYc5RfFg2uXTSSmS5UY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Egtg4hR5Z4XU73xn0+WPfDWvAJh4eZQH8xifOlK0k7wcn194aGoiTmOiJGvGWN/RuNwjW/wDk6Sydtg85DxbPaQhaSK/rig4EnHKOPAKhrM6B2ZnakkwxMpULbJpdj8qjnzDVHkrI/oY65gmAs9sH0I+oO9xxupcc7STVRrl43k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DLiRyYqp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eBYYGf0t; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ziGKkZgU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=SDD7g3hQ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E3C7B5BDE3;
	Tue,  3 Mar 2026 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772554715;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utCAaxh6+gq5oqyJtORxqE3rbSsfnfZcPR0u3MJjVKI=;
	b=DLiRyYqpM4fzcS8usIbRnuh6v5wLbxdGNQP4ad3r0UssAC43WsURT+ABw8MhV2x0BkDH0w
	ypGo9n57WVfuJQNtxE2XjBEd4AAk1ARbx8jvC+A4oSUi5rUUCtkwtc2treqRiduJj+WMzX
	gcOgdrXt0NJBRs6DPz+VCgEEW4vmQu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772554715;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utCAaxh6+gq5oqyJtORxqE3rbSsfnfZcPR0u3MJjVKI=;
	b=eBYYGf0tLhSfxo6z5+U4/j0xZlhsljjbDlDRAsrcloeWgtWIwunAtItqdoJutVBeFVOnRZ
	JZL0uT+uSv9Ic/Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772554714;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utCAaxh6+gq5oqyJtORxqE3rbSsfnfZcPR0u3MJjVKI=;
	b=ziGKkZgURy9rx6rdDZo9s5BcdRCZalydM1cR/5G48L/wg9mK5yLXockDThtBGf18SkDpbF
	5K0ImFezgYlGMZPh7nj5BKFMzHUTxMtFuGHa/rTFyHcbXnjbjBHPSoDMs8g8F/NCxTC3TJ
	rSTnnL27QcivjWXMJ6CStpYIXRI79M8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772554714;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utCAaxh6+gq5oqyJtORxqE3rbSsfnfZcPR0u3MJjVKI=;
	b=SDD7g3hQ3RTIcP/SEARAcLcw4Gzc0w0LgV4PT0HrIBqtLovBATsizwew+tw7TIYpaLpAVV
	xb1O7XJs1L3DasCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C359B3EA69;
	Tue,  3 Mar 2026 16:18:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O8FyL9oJp2mDBAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Mar 2026 16:18:34 +0000
Date: Tue, 3 Mar 2026 17:18:25 +0100
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+ba123cf1dd631315ffca@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING: suspicious RCU usage in btrfs_dev_name
Message-ID: <20260303161825.GC8455@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <69a5eca6.a70a0220.b118c.0003.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a5eca6.a70a0220.b118c.0003.GAE@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: -1.50
X-Spam-Level: 
X-Rspamd-Queue-Id: 835F31F394D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=98a1e192f758c1c1];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22190-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs,ba123cf1dd631315ffca];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 12:01:42PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7d6661873f6b Add linux-next specific files for 20260226
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11591952580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=98a1e192f758c1c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=ba123cf1dd631315ffca
> compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4cd2824adb8a/disk-7d666187.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/bbdd4a130d86/vmlinux-7d666187.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6e3bea3e96f8/bzImage-7d666187.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ba123cf1dd631315ffca@syzkaller.appspotmail.com
> 
> BTRFS info (device loop1): first mount of filesystem 7e32c2af-f87a-45a1-bcba-64dea7c56a53
> BTRFS info (device loop1): using xxhash64 checksum algorithm
> =============================
> WARNING: suspicious RCU usage
> syzkaller #0 Not tainted
> -----------------------------
> fs/btrfs/volumes.h:872 suspicious rcu_dereference_check() usage!

#syz invalid

Marking as invalid so it does not appear in the list of issues but
otherwise it's a valid report caused by patch that has been removed.

https://lore.kernel.org/linux-btrfs/20260205114546.210418-1-dsterba@suse.com/

