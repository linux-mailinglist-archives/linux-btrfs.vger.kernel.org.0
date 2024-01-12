Return-Path: <linux-btrfs+bounces-1416-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4A982C2E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 16:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9412D2838FD
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Jan 2024 15:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6C86EB45;
	Fri, 12 Jan 2024 15:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q8+KUDpf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="In8pbZH3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nISCfMV/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="MPiE8jPw"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECFE1D53F
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Jan 2024 15:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE04B21F9D;
	Fri, 12 Jan 2024 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705073893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1MbbGj5SE6oLeRfbAkVRU06ISfSUKVm8bTBdOVo99g=;
	b=Q8+KUDpfyIDBwAWzYE2X1H89VQmI8wtdGrDeF87HngWjqZ4b9Q1zSYyWr90UMM0Copsu2K
	WBtfvJ3D63SQbFLKYX1s7xqW8DJcipL+xEjtFrT7zRwQ13kBaIeYwA2fhB6IFVdKonJt4l
	wK1k4Z4Wk8ntSwSCf7dYVTsRQP1AT7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705073893;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1MbbGj5SE6oLeRfbAkVRU06ISfSUKVm8bTBdOVo99g=;
	b=In8pbZH3+cI3X26zNiHASV1rq/dQ7K57Yl9HTVf3cgagYQq1/nuKI6UpWT4rMb+0aJrf5A
	Us9eX2UkI4VgdFAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1705073892;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1MbbGj5SE6oLeRfbAkVRU06ISfSUKVm8bTBdOVo99g=;
	b=nISCfMV/3G5RX3QcAlVVZ0KVZvpHQsshmYKEzEWuCBCFb3XDWjWx5Un+S/5aotJRh6IaNS
	Q9WURraLXZ/qKQ1kq6UNjDYook93KKzjhcSuLOZImzZcP7WJdSz43vCCFouddDXTBZggyM
	0xdayv4KJ/ATRRz7BG5QAqCpV0AU7pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1705073892;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a1MbbGj5SE6oLeRfbAkVRU06ISfSUKVm8bTBdOVo99g=;
	b=MPiE8jPwOtsQxAcI4Hesik47NN1WdV3SxeDeD/tHB49+fFFtDdKUDP+geLPgKz3ydNSWO6
	hLfetN3wiopkOWAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B218E139D7;
	Fri, 12 Jan 2024 15:38:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +IJoKuRcoWVIHwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 12 Jan 2024 15:38:12 +0000
Date: Fri, 12 Jan 2024 16:37:52 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs-progs: convert-ext2: fix possible tree-checker
 error when converting a large fs
Message-ID: <20240112153752.GQ31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <f238f09e92c4043d5e6892c322234515b260df20.1705038162.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f238f09e92c4043d5e6892c322234515b260df20.1705038162.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="nISCfMV/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=MPiE8jPw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.24 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.03)[55.44%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -1.24
X-Rspamd-Queue-Id: CE04B21F9D
X-Spam-Flag: NO

On Fri, Jan 12, 2024 at 04:13:27PM +1030, Qu Wenruo wrote:
> [BUG]
> There is a report about failed btrfs-convert, which shows the following
> error:
> 
>  corrupt leaf: root=5 block=5001928998912 slot=1 ino=89911763, invalid previous key objectid, have 89911762 expect 89911763
>  ERROR: failed to copy ext2 inode 89911320: -5
>  ERROR: error during copy_inodes -5
>  WARNING: error during conversion, the original filesystem is not modified
> 
> [CAUSE]
> Above error is triggered when checking the following items inside a
> subvolume:
> 
> - inode ref
> - dir item/index
> - file extent
> - xattr
> 
> This is to make sure these items have correct previous key.
> 
> However btrfs-convert is not following this requirement, it always
> insert those items first, then create a btrfs_inode for it.
> 
> Thus it can lead to the error.
> 
> This can only happen for large fs, as for most cases we have all these
> modified tree blocks cached, thus tree-checker won't be triggered.
> But when the tree block cache is not hit, and we have to read from disk,
> then such behavior can lead to above tree-checker error.
> 
> [FIX]
> Make sure we insert the inode item first, then the file extents/dir
> items/xattrs.
> And after the file extents/dir items/xattrs inserted, we update the
> existing inode (to update its size and bytes).
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Added to devel, thanks.

