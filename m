Return-Path: <linux-btrfs+bounces-7505-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2644E95F4C4
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 17:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 865C4B225C9
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C899C193093;
	Mon, 26 Aug 2024 15:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ud4AgQCY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2y4SevjP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ud4AgQCY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2y4SevjP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38915187FEA;
	Mon, 26 Aug 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685045; cv=none; b=bgQ5Kr2Fay8/kJvcNHbHDSitrociOTmgkFy5kKPBYVTP4JahMN4JkGMbfN4wPaGY6yX3K+hDzGcIJ4ew7Els1lxTDw5w1Cf+RNri/dkGLwnBr8yhisH/xQUkET95/kdf6ybLei01BIBawgqMUk0J4HVADp34YACMwdBJwcjtXDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685045; c=relaxed/simple;
	bh=GOwYPH4voP6ERUprYOuRn4PcUAwaVpG0rMzt4FbHPoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHSXliC0hy/4qcTZuJRVAUlpPPuO3FJwHJZwIrlKNDNBeN4Xr6zdHn5grMBlONW0Hkfl38ImDHe9bpBqBxo06V0Xev46r1L/i5ZQ6/vGkwkRVqiPazEvH1BmKzU9+EJk2KhbPhP6grLc0TkETeamp9SmeaqHlfkkVPWneITZ1Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ud4AgQCY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2y4SevjP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ud4AgQCY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2y4SevjP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6189621AC4;
	Mon, 26 Aug 2024 15:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724685041;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnRZl+EVx04OO9ahKGU2Ei9MKkwqkIMEeOxvb9Nyanw=;
	b=Ud4AgQCYQDXlySUuQyn49TDqzOA6ryw/O/jWKavCibtCq33vQe/nhFqZxQfahEOLDn1xbl
	cTBThUIC841sSqvZmevB75EGLXdpnModpU11uMfEv9PDkFnkMJKSMkf/TXxKfUIFSo9SWJ
	ITpcgs/GquRhRxVisikikTHhd2Yn23E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724685041;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnRZl+EVx04OO9ahKGU2Ei9MKkwqkIMEeOxvb9Nyanw=;
	b=2y4SevjPk8lfL6pVwCPmcsE9G43+3DDwvZ0KLz9C1i3ZRJydbS6xQ3yn0WcmLqkDnxyStH
	RIT6CwRFAiTlttDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724685041;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnRZl+EVx04OO9ahKGU2Ei9MKkwqkIMEeOxvb9Nyanw=;
	b=Ud4AgQCYQDXlySUuQyn49TDqzOA6ryw/O/jWKavCibtCq33vQe/nhFqZxQfahEOLDn1xbl
	cTBThUIC841sSqvZmevB75EGLXdpnModpU11uMfEv9PDkFnkMJKSMkf/TXxKfUIFSo9SWJ
	ITpcgs/GquRhRxVisikikTHhd2Yn23E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724685041;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PnRZl+EVx04OO9ahKGU2Ei9MKkwqkIMEeOxvb9Nyanw=;
	b=2y4SevjPk8lfL6pVwCPmcsE9G43+3DDwvZ0KLz9C1i3ZRJydbS6xQ3yn0WcmLqkDnxyStH
	RIT6CwRFAiTlttDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E77413724;
	Mon, 26 Aug 2024 15:10:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aCwJD/GazGYvZQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 26 Aug 2024 15:10:41 +0000
Date: Mon, 26 Aug 2024 17:10:39 +0200
From: David Sterba <dsterba@suse.cz>
To: syzbot <syzbot+d7d1fc7e21835ca19219@syzkaller.appspotmail.com>
Cc: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, boris@bur.io
Subject: Re: [syzbot] [btrfs?] WARNING in __btrfs_check_leaf
Message-ID: <20240826151039.GO25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <000000000000dc4656062058a165@google.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000dc4656062058a165@google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-1.50 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[d7d1fc7e21835ca19219];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.50
X-Spam-Flag: NO

On Fri, Aug 23, 2024 at 05:08:25AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    872cf28b8df9 Merge tag 'platform-drivers-x86-v6.11-4' of g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=154c5825980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
> dashboard link: https://syzkaller.appspot.com/bug?extid=d7d1fc7e21835ca19219
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/c63409516c62/disk-872cf28b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/79b2b8c52d3a/vmlinux-872cf28b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/27cb9df9c339/bzImage-872cf28b.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d7d1fc7e21835ca19219@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6069 at fs/btrfs/tree-checker.c:1545 check_extent_item fs/btrfs/tree-checker.c:1545 [inline]

Thats'

	case BTRFS_EXTENT_OWNER_REF_KEY:
		WARN_ON(!btrfs_fs_incompat(fs_info, SIMPLE_QUOTA));
		break;

So the incompat bit is unset for some reason, or the tree item is intentionally
inserted. Either way this should be handled in a better way.

