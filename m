Return-Path: <linux-btrfs+bounces-14428-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F2EACCE4B
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 22:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE632174E2C
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jun 2025 20:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83151F4297;
	Tue,  3 Jun 2025 20:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="miqyn0nD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/6ayIcRR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q6UV23hP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H96xSOQK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3951F1534
	for <linux-btrfs@vger.kernel.org>; Tue,  3 Jun 2025 20:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983053; cv=none; b=eU5ucyH+GwNLjnUa2qbX5Nk8reRecUhRb2QZY4SOMutyC10ThwCaNJW6NJPoRaHcQ4avOyPS4KJlp8VWgpiI3xsC2uDo78/pUMVeClxUt/i8SgdwMVrsdvoYA7jhm6Zvcai+BpvCBwdh1usXAvYKFL7Ok43riH3jM5sUTAGnZF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983053; c=relaxed/simple;
	bh=RZFTgd/MRf+cVQGhDbd+cFQeLzSATStF745gTMNJAJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQFX+Cip0wc2fBLsqfH9OUFGqWOXMxrXPnrcxtW8/t30H/kpbtM9p6+ODv9MZGUL3dwuxwqVQ2hXJxMCg0TgGq5I49u606MaXw7Vi/V3rhpjCB+BsxlFfYhvptijjO+AsGemRwvJ9hA7hewFrn8Xy+YU+HwleKB0RDdiZ1wfS9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=miqyn0nD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/6ayIcRR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q6UV23hP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H96xSOQK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E86F8216D7;
	Tue,  3 Jun 2025 20:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748983049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr80o8VlCudhEt7JbT2/bTMRYzUeMsretsT2iavWSp4=;
	b=miqyn0nDzO0BejcaZu5SPLd8hor91Y3k8CHhSHb4dDlg6lA0TyVYL06fyuxwQ0cOiDI6tD
	eGoCpajvdVp0hQwTZsCpaRvkGFAZxnAoR6vhJn0NVpPjuOf7v2fyUN4LKlyU1NXQuIMBPf
	RtqzHaNJEVdFhHFSqNa8htfpwlVfxr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748983049;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr80o8VlCudhEt7JbT2/bTMRYzUeMsretsT2iavWSp4=;
	b=/6ayIcRRCZoVCiZoS8/vf0Fwx4AmKLvWG3RawkRMMXYdQjiZtNfoAPLtmjMPDDivVSYzpW
	6otPuGEuYX7ueDAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q6UV23hP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=H96xSOQK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748983048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr80o8VlCudhEt7JbT2/bTMRYzUeMsretsT2iavWSp4=;
	b=q6UV23hPHx4JkZnSG+stG3jXJjNu3dqeIGmQby65WoZ8g+KFVLg/rJCK1vwzeqUDMDoSH5
	bzbGv2thHZRTgKI8EFe/m03zzsOaAcwhZ4yAj7ipqShKoCEAxD/N7RICRwk/ABLoAuZygS
	+z4HlrHXZyGY5ik3hig3Cre1srBPj+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748983048;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr80o8VlCudhEt7JbT2/bTMRYzUeMsretsT2iavWSp4=;
	b=H96xSOQK/xzN77tj0JBlpf7d1IufnkbLyo3SqNvaZtzFfLoALdVEeYOHXVoh10HYa2W8zt
	ysRIweMbmjvdceDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAEE513A1D;
	Tue,  3 Jun 2025 20:37:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3mZXMQhdP2h7FQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 03 Jun 2025 20:37:28 +0000
Date: Tue, 3 Jun 2025 22:37:27 +0200
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: fix invalid inode pointer dereferences during log
 replay
Message-ID: <20250603203727.GN4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <774f04cc2a403a615ac24ecc9386fb870a88b956.1748975634.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <774f04cc2a403a615ac24ecc9386fb870a88b956.1748975634.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E86F8216D7
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.21
X-Spam-Level: 

On Tue, Jun 03, 2025 at 07:55:06PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> In a few places where we call read_one_inode(), if we get a NULL pointer
> we end up jumping into an error path, or fallthrough in case of
> __add_inode_ref(), where we then do something like this:
> 
>    iput(&inode->vfs_inode);
> 
> which results in an invalid inode pointer that triggers an invalid memory
> access, resulting in a crash.
> 
> Fix this by making sure we don't do such dereferences.
> 
> Fixes: b4c50cbb01a1 ("btrfs: return a btrfs_inode from read_one_inode()")
> CC: stable@vger.kernel.org # 6.15+
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  fs/btrfs/tree-log.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
> index 34ed9b2b1b83..1e0042787be7 100644
> --- a/fs/btrfs/tree-log.c
> +++ b/fs/btrfs/tree-log.c
> @@ -673,10 +673,8 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
>  	}
>  
I think it would make the code flow a bit better with

--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -668,8 +668,7 @@ static noinline int replay_one_extent(struct btrfs_trans_handle *trans,
                extent_end = ALIGN(start + size,
                                   fs_info->sectorsize);
        } else {
-               ret = 0;
-               goto out;
+               return 0;
        }
 
        inode = read_one_inode(root, key->objectid);
---

as there's only the iput() at the label out: and at this point inode is
still initial NULL so it's a no op.

>  	inode = read_one_inode(root, key->objectid);
> -	if (!inode) {
> -		ret = -EIO;
> -		goto out;
> -	}
> +	if (!inode)
> +		return -EIO;
>  
>  	/*
>  	 * first check to see if we already have this extent in the

