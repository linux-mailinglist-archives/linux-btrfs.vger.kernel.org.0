Return-Path: <linux-btrfs+bounces-4384-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0711D8A8DE1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 23:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20FC28369F
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A06A651AF;
	Wed, 17 Apr 2024 21:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M6Aaaunh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n1gE8ohU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M6Aaaunh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="n1gE8ohU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B59818C19
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 21:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713389196; cv=none; b=QmhF0b8aRW51GMM8MwsZaR/rSCR11s6mW82pAZIfzTM4wjCdgDzdXwd2oAcAhZbS0VhH+oKBAMsCaVQwr7ifcjjCErWIf8DSsm7yZgTBcd01ixJcyIE8UJdd+pWhQucmmcAMLIlNeMTv0+8fDhGMG75FqJH5PjIsaUtotrjVmSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713389196; c=relaxed/simple;
	bh=cFicshi9hQM4ZjVFU6I2lODbYokQh34hWuJDTPxzpxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1stolB3QuKEaumrmQaiexQvk5xApAR6ubwhTipSO82ya6ZttXACwu+nicfjv0DUpWIG8LWlofM5VT4UjfcRS13dXlUrb/4Ia2h3bq0okZIaVrvzN6qKzW3GEIf6pLMLIwyEe6sZdqqXSm7Iej9yARZBAHd53cEMUAwMe4p+njM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M6Aaaunh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n1gE8ohU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M6Aaaunh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=n1gE8ohU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A29FA342C5;
	Wed, 17 Apr 2024 21:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713389192;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kitwWCttdpw8PhOC8pBJNKMzdQ422Iu1CWJNJ8V7bcI=;
	b=M6Aaaunh5gbvfSfV5QBAAvhIpnQwQ0P1Gru6I3ILaXDuDJEZ0dWc25v24+uNwwM+L1CynZ
	vNNsdJg1vmm2zRkYNriqdBiR7jHUWsGDlMNHtcxl4DMUozDRtsfNuxik865XSQcGZ9CnAr
	YRRln4dNyE3RWsjT5eswouCbEos0lik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713389192;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kitwWCttdpw8PhOC8pBJNKMzdQ422Iu1CWJNJ8V7bcI=;
	b=n1gE8ohUpb5DsuhewH9nqlqNxQO0xot7SHvF21r3yTM3sqMpE0Kt5h4z7ZlWZN3VPG6cQ8
	uZguqMySnz2gXQCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1713389192;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kitwWCttdpw8PhOC8pBJNKMzdQ422Iu1CWJNJ8V7bcI=;
	b=M6Aaaunh5gbvfSfV5QBAAvhIpnQwQ0P1Gru6I3ILaXDuDJEZ0dWc25v24+uNwwM+L1CynZ
	vNNsdJg1vmm2zRkYNriqdBiR7jHUWsGDlMNHtcxl4DMUozDRtsfNuxik865XSQcGZ9CnAr
	YRRln4dNyE3RWsjT5eswouCbEos0lik=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1713389192;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kitwWCttdpw8PhOC8pBJNKMzdQ422Iu1CWJNJ8V7bcI=;
	b=n1gE8ohUpb5DsuhewH9nqlqNxQO0xot7SHvF21r3yTM3sqMpE0Kt5h4z7ZlWZN3VPG6cQ8
	uZguqMySnz2gXQCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88BF41384C;
	Wed, 17 Apr 2024 21:26:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b4vyIIg+IGY/WgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 17 Apr 2024 21:26:32 +0000
Date: Wed, 17 Apr 2024 23:19:02 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Filipe Manana <fdmanana@kernel.org>,
	syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com,
	Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v2] btrfs: fix information leak in
 btrfs_ioctl_logical_to_ino()
Message-ID: <20240417211902.GU3492@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <7eb2d171cdb1a2a89288a989dc0ef28c21bebc59.1713361686.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7eb2d171cdb1a2a89288a989dc0ef28c21bebc59.1713361686.git.jth@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-2.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email];
	RCVD_TLS_ALL(0.00)[];
	TAGGED_RCPT(0.00)[510a1abbb8116eeb341d];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -2.50
X-Spam-Flag: NO

On Wed, Apr 17, 2024 at 03:48:49PM +0200, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Syzbot reported the following information leak for in
> btrfs_ioctl_logical_to_ino():
> 
> BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x110 lib/usercopy.c:40
>  instrument_copy_to_user include/linux/instrumented.h:114 [inline]
>  _copy_to_user+0xbc/0x110 lib/usercopy.c:40
>  copy_to_user include/linux/uaccess.h:191 [inline]
>  btrfs_ioctl_logical_to_ino+0x440/0x750 fs/btrfs/ioctl.c:3499
>  btrfs_ioctl+0x714/0x1260
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>  __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
>  x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>  __kmalloc_large_node+0x231/0x370 mm/slub.c:3921
>  __do_kmalloc_node mm/slub.c:3954 [inline]
>  __kmalloc_node+0xb07/0x1060 mm/slub.c:3973
>  kmalloc_node include/linux/slab.h:648 [inline]
>  kvmalloc_node+0xc0/0x2d0 mm/util.c:634
>  kvmalloc include/linux/slab.h:766 [inline]
>  init_data_container+0x49/0x1e0 fs/btrfs/backref.c:2779
>  btrfs_ioctl_logical_to_ino+0x17c/0x750 fs/btrfs/ioctl.c:3480
>  btrfs_ioctl+0x714/0x1260
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:904 [inline]
>  __se_sys_ioctl+0x261/0x450 fs/ioctl.c:890
>  __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:890
>  x64_sys_call+0x1883/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:17
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Bytes 40-65535 of 65536 are uninitialized
> Memory access of size 65536 starts at ffff888045a40000
> 
> This happens, because we're copying a 'struct btrfs_data_container' back
> to user-space. This btrfs_data_container is allocated in
> 'init_data_container()' via kvmalloc(), which does not zero-fill the
> memory.
> 
> Fix this by using kvzalloc() which zeroes out the memory on allocation.
> 
> Reported-by:  <syzbot+510a1abbb8116eeb341d@syzkaller.appspotmail.com>
> Signed-off-by: Johannes Thumshirn <Johannes.thumshirn@wdc.com>
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

