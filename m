Return-Path: <linux-btrfs+bounces-1656-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C98399F1
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 21:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5B50B277B9
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Jan 2024 20:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5057B82D8D;
	Tue, 23 Jan 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iWPqLW6R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4cbVHQU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iWPqLW6R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w4cbVHQU"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7CB82D6E
	for <linux-btrfs@vger.kernel.org>; Tue, 23 Jan 2024 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706040210; cv=none; b=csHQMSoqxCeXbw8dolM84p6rjGwRItk3Po0xQzhPMYlLAuuXdYyEHdm42I2lVgRxsvcWHtGU2Tp9nFI2RFbrsrqUKag3jSK7CCS87ArA8ZtJQxOsdgprfRPfe2x6eP0hukStHFfMMYvIo/v+3nyrLh/I0c0Im02sBWx7IrCMTL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706040210; c=relaxed/simple;
	bh=YRbTIryXMxp5Xq4IjbUWndU0X66iZl3+odqDj7wtjAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJ6NGs/v7IlD8eNxmGimRlSeqQaQf6TRgiSZHN1LDyBamgANxOIxkAJN3brETi2vN0ltxKYxignUvdn/nhh8qFG2+teQU/diF8ki7ViYwwGl7894ODJZfSpPEeWE7qtZKUIJMsU/GMj3nG1YS2lN4d5Y9as92qusfku7WtdU6G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iWPqLW6R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w4cbVHQU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iWPqLW6R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w4cbVHQU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A19521A98;
	Tue, 23 Jan 2024 20:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706040205;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu6ySG3Kj90X4OCFG2xqKhzx663JdKdLRjiSKdChZ5U=;
	b=iWPqLW6RaBMN9rQgmRoKWGEIxqmMlO/JhaKDjRfvE6vWcUr0amFCtvylltY5b1+HH/0T1q
	aRdoo9FFjS3IpusU6dKoumH6zSE48z0lnrtHvyvTeZ7tOa/AmGcqYDjvs+iNlSxSJlRvi/
	QYQmI8JtR1R4hlpPbLdlGN0w01sZ4PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706040205;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu6ySG3Kj90X4OCFG2xqKhzx663JdKdLRjiSKdChZ5U=;
	b=w4cbVHQUGr/7uWHXvSsHIto+hG3aEx7y4nbENS2MMnIl8m3TREYnVFRcodU4LnxGpzF9Oj
	HPn3iY/9sizcn2AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706040205;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu6ySG3Kj90X4OCFG2xqKhzx663JdKdLRjiSKdChZ5U=;
	b=iWPqLW6RaBMN9rQgmRoKWGEIxqmMlO/JhaKDjRfvE6vWcUr0amFCtvylltY5b1+HH/0T1q
	aRdoo9FFjS3IpusU6dKoumH6zSE48z0lnrtHvyvTeZ7tOa/AmGcqYDjvs+iNlSxSJlRvi/
	QYQmI8JtR1R4hlpPbLdlGN0w01sZ4PU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706040205;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cu6ySG3Kj90X4OCFG2xqKhzx663JdKdLRjiSKdChZ5U=;
	b=w4cbVHQUGr/7uWHXvSsHIto+hG3aEx7y4nbENS2MMnIl8m3TREYnVFRcodU4LnxGpzF9Oj
	HPn3iY/9sizcn2AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7897813638;
	Tue, 23 Jan 2024 20:03:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id YgjxHI0bsGUBFgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Tue, 23 Jan 2024 20:03:25 +0000
Date: Tue, 23 Jan 2024 21:03:03 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, Chenyuan Yang <chenyuan0y@gmail.com>
Subject: Re: [PATCH] btrfs: do not ASSERT() if the newly created subvolume
 already got read
Message-ID: <20240123200303.GK31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <6a80cb4b32af89787dadee728310e5e2ca85343f.1705741883.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a80cb4b32af89787dadee728310e5e2ca85343f.1705741883.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iWPqLW6R;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=w4cbVHQU
X-Spamd-Result: default: False [-0.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_SOME(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[41.29%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 9A19521A98
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Sat, Jan 20, 2024 at 07:41:28PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a syzbot crash, triggered by the ASSERT() during subvolume
> creation:
> 
>  assertion failed: !anon_dev, in fs/btrfs/disk-io.c:1319
>  ------------[ cut here ]------------
>  kernel BUG at fs/btrfs/disk-io.c:1319!
>  invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>  RIP: 0010:btrfs_get_root_ref.part.0+0x9aa/0xa60
>   <TASK>
>   btrfs_get_new_fs_root+0xd3/0xf0
>   create_subvol+0xd02/0x1650
>   btrfs_mksubvol+0xe95/0x12b0
>   __btrfs_ioctl_snap_create+0x2f9/0x4f0
>   btrfs_ioctl_snap_create+0x16b/0x200
>   btrfs_ioctl+0x35f0/0x5cf0
>   __x64_sys_ioctl+0x19d/0x210
>   do_syscall_64+0x3f/0xe0
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
>  ---[ end trace 0000000000000000 ]---
> 
> [CAUSE]
> During create_subvol(), after inserting root item for the newly created
> subvolume, we would trigger btrfs_get_new_fs_root() to get the
> btrfs_root of that subvolume.
> 
> The idea here is, we have preallocated an anonymous device number for
> the subvolume, thus we can assign it to the new subvolume.
> 
> But there is really nothing preventing things like backref walk to read
> the new subvolume.
> If that happens before we call btrfs_get_new_fs_root(), the subvolume
> would be read out, with a new anonymous device number assigned already.
> 
> In that case, we would trigger ASSERT(), as we really expect no one to
> read out that subvolume (which is not yet accessible from the fs).
> But things like backref walk is still possible to trigger the read on
> the subvolume.
> 
> Thus our assumption on the ASSERT() is not correct in the first place.
> 
> [FIX]
> Fix it by removing the ASSERT(), and just free the @anon_dev, reset it
> to 0, and continue.
> 
> If the subvolume tree is read out by something else, it should have
> already get a new anon_dev assigned thus we only need to free the
> preallocated one.
> 
> Reported-by: Chenyuan Yang <chenyuan0y@gmail.com>
> Fixes: 2dfb1e43f57d ("btrfs: preallocate anon block device at first phase of snapshot creation")
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

