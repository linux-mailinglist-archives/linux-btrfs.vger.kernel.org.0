Return-Path: <linux-btrfs+bounces-22191-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NHUA6AKp2kDcgAAu9opvQ
	(envelope-from <linux-btrfs+bounces-22191-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 17:21:52 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F36EF1F3A2D
	for <lists+linux-btrfs@lfdr.de>; Tue, 03 Mar 2026 17:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B1233026BF4
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Mar 2026 16:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0087C4D8D88;
	Tue,  3 Mar 2026 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iFwq8aLd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k0ZclSxq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iFwq8aLd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k0ZclSxq"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F713EB80B
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Mar 2026 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554742; cv=none; b=bCMIdADPTXJPAoak3fRumzni3JMNtZDQDRgY89kM7Y7Vqw6nIKO0UHWP3IYxaf5BGisGE7BPkh+iT8GI4ZCybpZxAs/H2FZyCl7eqNqYEPQn0Ciqe5gWj1LmWPRxmvJk+5qW9KeQlEkoEMi8x3ISamY/6KxSBu2xkFRtOE9Y9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554742; c=relaxed/simple;
	bh=c+VEBptUTAVQPT3783tO8UceHphCO6o9/jSyPtJypTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1SNrSM1+ebkp0J/TIHk86MXOmhJON+F4AI5vSqXpNxrEngOFYWIBha40yWGuWouBD5LMl/WEgbTFI8iDFvdSw8R8k8tfGtqsCL26EvqSqlLA+jTCuC2gA5hFZlBz6JCh4IhzcOqR6p4t5vYroKBva0JGvIEi8hXm4vTigVayjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iFwq8aLd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k0ZclSxq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iFwq8aLd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k0ZclSxq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 70BA55BDE3;
	Tue,  3 Mar 2026 16:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772554739;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnncA7yISzGT7Ygtp8yUke2CjQ7MCULQNr4wKAJSgqU=;
	b=iFwq8aLdu9jeMPgSfWzyiIXR7Ite8i6NortyGvbCaWUdddUquZI4KFAu0YrTzTIgYIDMX8
	33Lob/F85itg2uohLoUL98um6eXukEXeOrfLjYprCg14oqZhIuKbBjfCIW3TH364tD/apQ
	VkwaYcWL4YbAbsQaNYs1rC4eZQa6FD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772554739;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnncA7yISzGT7Ygtp8yUke2CjQ7MCULQNr4wKAJSgqU=;
	b=k0ZclSxqu+U+cYWpKgpa9xDmkqkttjE89rRldgudn3utvhP6A7x5y5i11Ob58S0/HqU9WM
	c01nv/vvZb/g7eBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772554739;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnncA7yISzGT7Ygtp8yUke2CjQ7MCULQNr4wKAJSgqU=;
	b=iFwq8aLdu9jeMPgSfWzyiIXR7Ite8i6NortyGvbCaWUdddUquZI4KFAu0YrTzTIgYIDMX8
	33Lob/F85itg2uohLoUL98um6eXukEXeOrfLjYprCg14oqZhIuKbBjfCIW3TH364tD/apQ
	VkwaYcWL4YbAbsQaNYs1rC4eZQa6FD8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772554739;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dnncA7yISzGT7Ygtp8yUke2CjQ7MCULQNr4wKAJSgqU=;
	b=k0ZclSxqu+U+cYWpKgpa9xDmkqkttjE89rRldgudn3utvhP6A7x5y5i11Ob58S0/HqU9WM
	c01nv/vvZb/g7eBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F9C13EA69;
	Tue,  3 Mar 2026 16:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id M8o0E/MJp2ldBQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Mar 2026 16:18:59 +0000
Date: Tue, 3 Mar 2026 17:18:43 +0100
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+2c45a55710ac9b888efc@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] WARNING: suspicious RCU usage in
 btrfs_dev_stat_inc_and_print
Message-ID: <20260303161843.GD8455@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <69a5f980.a70a0220.b118c.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69a5f980.a70a0220.b118c.0004.GAE@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -1.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: F36EF1F3A2D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=98a1e192f758c1c1];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	TAGGED_FROM(0.00)[bounces-22191-lists,linux-btrfs=lfdr.de];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,appspotmail.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,twin.jikos.cz:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-btrfs,2c45a55710ac9b888efc];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 12:56:32PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7d6661873f6b Add linux-next specific files for 20260226
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1753c202580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=98a1e192f758c1c1
> dashboard link: https://syzkaller.appspot.com/bug?extid=2c45a55710ac9b888efc
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
> Reported-by: syzbot+2c45a55710ac9b888efc@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 32768 to 0
> =============================
> WARNING: suspicious RCU usage
> syzkaller #0 Not tainted
> -----------------------------
> fs/btrfs/volumes.h:872 suspicious rcu_dereference_check() usage!

#syz invalid

Marking as invalid so it does not appear in the list of issues but
otherwise it's a valid report caused by patch that has been removed.

https://lore.kernel.org/linux-btrfs/20260205114546.210418-1-dsterba@suse.com/

