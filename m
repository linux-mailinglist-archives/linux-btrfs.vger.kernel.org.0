Return-Path: <linux-btrfs+bounces-12616-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDBA736C3
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 17:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF843178C63
	for <lists+linux-btrfs@lfdr.de>; Thu, 27 Mar 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968A31A2658;
	Thu, 27 Mar 2025 16:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S2MquODH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CvCPhWiv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S2MquODH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CvCPhWiv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E52E13DBA0
	for <linux-btrfs@vger.kernel.org>; Thu, 27 Mar 2025 16:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092730; cv=none; b=sU0PYymCwJuZwfMC3uwLjEaiyOeXdlwY37gFXOG48jSmEVVMRvqVfxZsPWeAurttg6aqLXXhjQbKstqzZ9KgOTScqYytdgHnlyiu1F7ETgwSMMVVCGG0dYs9hDldBl1rFaM2XnqPyYnHlU4LJujLpWqYVpSLru3mRXzkO7u2E3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092730; c=relaxed/simple;
	bh=DDjugNFPbeakj/qu2tntNnvG/Uf2JQoiZAk4CNyhQlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHfObcdnncM8tK3rLCiTMBheMjT0wDmFDNifv/NTqhVtrMks93Ag7iaoae0fcgNdHI5wLt+cFmALWjljuxWNFM8PwTRa5J7lwxPOb2eEkYxDvBA06K2v6SxTiKBmDX9x8Ey0s/GoCmNwAe6W3z7h9YDOg+ce141OJzPC5yGTAc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S2MquODH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CvCPhWiv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S2MquODH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CvCPhWiv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4DC501F456;
	Thu, 27 Mar 2025 16:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743092727;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQxOyXL1dWmOFO2pD6nzjvHibRIYMmruGxa80tTGqEs=;
	b=S2MquODHoTmFFwRWw6xg/MlDwVDCn4pDGGhTooOgJav00Nl4OvksOSIvH4/40My80mrTKX
	oMCD5SMLk7mOj0vy/Umx83Sm7An43j/n1o0cE8oBzYElCKqvpsuJpQ67Sc1k28om5xU1Yy
	7OedrWyndkMgGhIzvLLulODiwTgB7FQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743092727;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQxOyXL1dWmOFO2pD6nzjvHibRIYMmruGxa80tTGqEs=;
	b=CvCPhWivjPMEqpVJ52CnKiKQKGyYJ1/egr5TiUFMClbc7KrFbVc/BPcBdTdVGcUMZ96u+v
	XQZvddYYLOlXy4Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1743092727;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQxOyXL1dWmOFO2pD6nzjvHibRIYMmruGxa80tTGqEs=;
	b=S2MquODHoTmFFwRWw6xg/MlDwVDCn4pDGGhTooOgJav00Nl4OvksOSIvH4/40My80mrTKX
	oMCD5SMLk7mOj0vy/Umx83Sm7An43j/n1o0cE8oBzYElCKqvpsuJpQ67Sc1k28om5xU1Yy
	7OedrWyndkMgGhIzvLLulODiwTgB7FQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1743092727;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cQxOyXL1dWmOFO2pD6nzjvHibRIYMmruGxa80tTGqEs=;
	b=CvCPhWivjPMEqpVJ52CnKiKQKGyYJ1/egr5TiUFMClbc7KrFbVc/BPcBdTdVGcUMZ96u+v
	XQZvddYYLOlXy4Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25BD5139D4;
	Thu, 27 Mar 2025 16:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id x0bsCPd75WedCAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 27 Mar 2025 16:25:27 +0000
Date: Thu, 27 Mar 2025 17:25:25 +0100
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+34122898a11ab689518a@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in write_all_supers
Message-ID: <20250327162525.GU32661@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <67e5799e.050a0220.2f068f.0032.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e5799e.050a0220.2f068f.0032.GAE@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=46a07195688b794b];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[34122898a11ab689518a];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.50
X-Spam-Flag: NO

On Thu, Mar 27, 2025 at 09:15:26AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f6e0150b2003 Merge tag 'mtd/for-6.15' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1405d804580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=46a07195688b794b
> dashboard link: https://syzkaller.appspot.com/bug?extid=34122898a11ab689518a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d7abb0580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15d76198580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f6e0150b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/7ade4c34c9b1/vmlinux-f6e0150b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/1fe37b97ec9d/bzImage-f6e0150b.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/1f4c759fe772/mount_0.gz
>   fsck result: OK (log: https://syzkaller.appspot.com/x/fsck.log?x=1757abb0580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+34122898a11ab689518a@syzkaller.appspotmail.com
> 
> BTRFS info (device loop0): using sha256 (sha256-avx2) checksum algorithm
> BTRFS info (device loop0): using free-space-tree
> assertion failed: folio_order(folio) == 0, in fs/btrfs/disk-io.c:3858

This is

ASSERT(folio_order(folio) == 0);

and the folio is from device->bdev->bd_mapping.

