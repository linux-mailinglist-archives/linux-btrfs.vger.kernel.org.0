Return-Path: <linux-btrfs+bounces-6142-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF2D924166
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 16:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13F21C23E8C
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jul 2024 14:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583AD1BA872;
	Tue,  2 Jul 2024 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJ2ROJRi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZdMWeMZs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XJ2ROJRi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZdMWeMZs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F0C76F17
	for <linux-btrfs@vger.kernel.org>; Tue,  2 Jul 2024 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719931931; cv=none; b=td1m6W5fVFPw91OwXvp2kXwTgH55phfBunt8ybrCHxWf1w9hmh6ptVEt5bbVeblqSXQr/8Fg5DbTe0oi3m7rPeffBW23G68cO0cnDhT8N/h1sWyt+7Pv8ecnk8NlZVIgaQ3H3B/ejHpLlfKDl9UeNR2Gs44mIo0BpGKoSoXcej8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719931931; c=relaxed/simple;
	bh=yb+Z31TH6gdHuAujMvTcdLU9kVKR31rBs4EDWrWLogE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qKSLAH3XrND99DLoUc6q6Gfa1/gHokM9C0ai//3HwiJHgukERwTC+ESaW6VVgsPFLzRYIjjtEL9rghoNco2+XxT5qxIUGEad/RGbAIzv3lc0Ymd7q9sduQ0OPUuT0+N4U6icx5JTGOhGr9+Kp8+RWt7GncoKy7CoMyXYDvzANAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJ2ROJRi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZdMWeMZs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XJ2ROJRi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZdMWeMZs; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 77BA821B40;
	Tue,  2 Jul 2024 14:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719931927;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssVFPd3IvwJSR0u8JQwpDkOvrc6FlCu5iP5L9W9543I=;
	b=XJ2ROJRi1aqkZWSBKNipUq6XfmFSxelQYPl7zKqfF3OZIaJlWDwDynaWSQSo5oqGhbt7Ep
	mF0Z28gSGgRVUhWJ/iqpHy2Avo4QM0quxwrJZqekAhSMpZypI2OimODfXclbeJ6lVMVBQ7
	ByiGKaZa2PFq6S+AEcwn9RmrsyL1Wq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719931927;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssVFPd3IvwJSR0u8JQwpDkOvrc6FlCu5iP5L9W9543I=;
	b=ZdMWeMZsUCU27++E1z3kNxMG6jo9iHO7Li4Ax83wF4ygKcMZ5IEaOOAr82SGZDUqf/8EkM
	nyYZC3D+v6CoH1BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XJ2ROJRi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZdMWeMZs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719931927;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssVFPd3IvwJSR0u8JQwpDkOvrc6FlCu5iP5L9W9543I=;
	b=XJ2ROJRi1aqkZWSBKNipUq6XfmFSxelQYPl7zKqfF3OZIaJlWDwDynaWSQSo5oqGhbt7Ep
	mF0Z28gSGgRVUhWJ/iqpHy2Avo4QM0quxwrJZqekAhSMpZypI2OimODfXclbeJ6lVMVBQ7
	ByiGKaZa2PFq6S+AEcwn9RmrsyL1Wq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719931927;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ssVFPd3IvwJSR0u8JQwpDkOvrc6FlCu5iP5L9W9543I=;
	b=ZdMWeMZsUCU27++E1z3kNxMG6jo9iHO7Li4Ax83wF4ygKcMZ5IEaOOAr82SGZDUqf/8EkM
	nyYZC3D+v6CoH1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 602801395F;
	Tue,  2 Jul 2024 14:52:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H1A/FxcUhGaTGwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 02 Jul 2024 14:52:07 +0000
Date: Tue, 2 Jul 2024 16:52:01 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix data race when accessing the last_trans field
 of a root
Message-ID: <20240702145200.GF21023@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <5152cead4acef28ac0dff3db80692a6e8852ddc4.1719828039.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5152cead4acef28ac0dff3db80692a6e8852ddc4.1719828039.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 77BA821B40
X-Spam-Score: -4.20
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.20 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:replyto,suse.cz:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon, Jul 01, 2024 at 11:01:53AM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> KCSAN complains about a data race when accessing the last_trans field of a
> root:
> 
>   [  199.553628] BUG: KCSAN: data-race in btrfs_record_root_in_trans [btrfs] / record_root_in_trans [btrfs]
> 
>   [  199.555186] read to 0x000000008801e308 of 8 bytes by task 2812 on cpu 1:
>   [  199.555210]  btrfs_record_root_in_trans+0x9a/0x128 [btrfs]
>   [  199.555999]  start_transaction+0x154/0xcd8 [btrfs]
>   [  199.556780]  btrfs_join_transaction+0x44/0x60 [btrfs]
>   [  199.557559]  btrfs_dirty_inode+0x9c/0x140 [btrfs]
>   [  199.558339]  btrfs_update_time+0x8c/0xb0 [btrfs]
>   [  199.559123]  touch_atime+0x16c/0x1e0
>   [  199.559151]  pipe_read+0x6a8/0x7d0
>   [  199.559179]  vfs_read+0x466/0x498
>   [  199.559204]  ksys_read+0x108/0x150
>   [  199.559230]  __s390x_sys_read+0x68/0x88
>   [  199.559257]  do_syscall+0x1c6/0x210
>   [  199.559286]  __do_syscall+0xc8/0xf0
>   [  199.559318]  system_call+0x70/0x98
> 
>   [  199.559431] write to 0x000000008801e308 of 8 bytes by task 2808 on cpu 0:
>   [  199.559464]  record_root_in_trans+0x196/0x228 [btrfs]
>   [  199.560236]  btrfs_record_root_in_trans+0xfe/0x128 [btrfs]
>   [  199.561097]  start_transaction+0x154/0xcd8 [btrfs]
>   [  199.561927]  btrfs_join_transaction+0x44/0x60 [btrfs]
>   [  199.562700]  btrfs_dirty_inode+0x9c/0x140 [btrfs]
>   [  199.563493]  btrfs_update_time+0x8c/0xb0 [btrfs]
>   [  199.564277]  file_update_time+0xb8/0xf0
>   [  199.564301]  pipe_write+0x8ac/0xab8
>   [  199.564326]  vfs_write+0x33c/0x588
>   [  199.564349]  ksys_write+0x108/0x150
>   [  199.564372]  __s390x_sys_write+0x68/0x88
>   [  199.564397]  do_syscall+0x1c6/0x210
>   [  199.564424]  __do_syscall+0xc8/0xf0
>   [  199.564452]  system_call+0x70/0x98
> 
> This is because we update and read last_trans concurrently without any
> type of synchronization. This should be generally harmless and in the
> worst case it can make us do extra locking (btrfs_record_root_in_trans())
> trigger some warnings at ctree.c or do extra work during relocation - this
> would probably only happen in case of load or store tearing.
> 
> So fix this by always reading and updating the field using READ_ONCE()
> and WRITE_ONCE(), this silences KCSAN and prevents load and store tearing.

I'm curious why you mention the load/store tearing, as we discussed this
last time under some READ_ONCE/WRITE_ONCE change it's not happening on
aligned addresses for any integer type, I provided links to intel manuals.

I suggest using data_race as is more suitable in this case, it's more
specific than READ_ONCE/WRITE_ONCE that is for preventing certain
compiler optimizations.

