Return-Path: <linux-btrfs+bounces-14306-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A49EAC8CAF
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 13:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC831BC75AA
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 May 2025 11:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A1C226863;
	Fri, 30 May 2025 11:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJjfkaM3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eUKOXHOC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rMRaDZdP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="w9ha3BF6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95319AD70
	for <linux-btrfs@vger.kernel.org>; Fri, 30 May 2025 11:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603655; cv=none; b=KOakG3Op3rwKfymnZZDsclykK7lW+MepNk25drmlwmqDW377qo39rI+mZOthcLxk6st8HJnq2gllsBVLeg/yQpyvHyP4GceJKZprcpGAwrYdIjCwV+fITRpHmRPZWc7u1d5hjgYb8wki6jWAfVRMsua2XtqWraWCMTMSgINUQac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603655; c=relaxed/simple;
	bh=Z3GoETbt8Jw0Nq8UHHkmuzV3j6ivwhmJjDY62k4yA1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0R9d7Z0DlkEz5tsKh10CTWEMYn8N5o+fdyZ+5FweEc/I1C2gwb9DdW4juQbiRvXzZHwrGplTu+7erI2dkAeCWVYjpeuqoKNa1YVsLZH4fbjL0isvbbP303e2G+pOG0u4aPbiMX51yEW48x5aRUHDKmiZKaLxdusxfqWctNjrh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJjfkaM3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eUKOXHOC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rMRaDZdP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=w9ha3BF6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 782041F847;
	Fri, 30 May 2025 11:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603652;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yp2U88IYMlfZktfFtNxCubXghOBBpnsyFnVkMj8r+s=;
	b=LJjfkaM3XX5v1amtooH3xl6zVnxwYdgYUmTBKG+bnEF4Xu30qWCYckOxbGnZldBmNhqd+/
	FQc2UmP1vQaIH+JrLrM7x5ih4zTW8vvFws2ILmMTuRTctq/9kRmB+8aHK4awLh4tD75GEy
	Z0vCxwpsP5r2/+qxJQ+gkI912xL7lPc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603652;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yp2U88IYMlfZktfFtNxCubXghOBBpnsyFnVkMj8r+s=;
	b=eUKOXHOC0kYyJff1FNt50we+CtDq+xYBYHULaT7usUS+WiAy+cAdaq4pPU6zYwi2KyAxRw
	R3ELN9SM/77wCXAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748603651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yp2U88IYMlfZktfFtNxCubXghOBBpnsyFnVkMj8r+s=;
	b=rMRaDZdPuNiQcDYtxZsTg/kDgM6aewT7HAgoeo6z27Ol+rIWsncsEA2iL6iE0tDRYPRqG0
	otApK6CZt2dzigsZeWpehbdZYxAiHcKO8Ci06lOHeiCKaTEB06Ffhpn7AJfbGunZAO6gyR
	v8jOOp6VBdOK1/oZvZbRthWQ/nJTSlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748603651;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+yp2U88IYMlfZktfFtNxCubXghOBBpnsyFnVkMj8r+s=;
	b=w9ha3BF6TrWsFn5Pjj+UaTeqR/L9mq2Nl7Q/Xe0EbXdoX/3NZHPf59BcAHAi87RoBI4azR
	xUqcc8RNzyfGaUDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5189D13889;
	Fri, 30 May 2025 11:14:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TBKGEwOTOWhFEQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 30 May 2025 11:14:11 +0000
Date: Fri, 30 May 2025 13:14:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 3/6] btrfs-progs: fix-data-checksum: show affected
 files
Message-ID: <20250530111406.GS4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1747295965.git.wqu@suse.com>
 <6112e51519a5914c181dd1e5deb07bf165e15c72.1747295965.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6112e51519a5914c181dd1e5deb07bf165e15c72.1747295965.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, May 15, 2025 at 05:30:18PM +0930, Qu Wenruo wrote:
> Previously "btrfs rescue fix-data-checksum" only show affected logical
> bytenr, which is not helpful to determine which files are affected.
> 
> Enhance the output by also outputting the affected subvolumes (in
> numeric form), and the file paths inside that subvolume.
> 
> The example looks like this:
> 
>   logical=13631488 corrtuped mirrors=1 affected files:
>     (subvolume 5)/foo
>     (subvolume 5)/dir/bar
>   logical=13635584 corrtuped mirrors=1 affected files:
>     (subvolume 5)/foo
>     (subvolume 5)/dir/bar
> 
> Although the end result is still not perfect, it's still much easier to
> find out which files are affected.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  cmds/rescue-fix-data-checksum.c | 59 +++++++++++++++++++++++++++++++--
>  1 file changed, 56 insertions(+), 3 deletions(-)
> 
> diff --git a/cmds/rescue-fix-data-checksum.c b/cmds/rescue-fix-data-checksum.c
> index 7e613ba57f76..bf3a65b31c71 100644
> --- a/cmds/rescue-fix-data-checksum.c
> +++ b/cmds/rescue-fix-data-checksum.c
> @@ -18,6 +18,7 @@
>  #include "kernel-shared/disk-io.h"
>  #include "kernel-shared/ctree.h"
>  #include "kernel-shared/volumes.h"
> +#include "kernel-shared/backref.h"
>  #include "common/messages.h"
>  #include "common/open-utils.h"
>  #include "cmds/rescue.h"
> @@ -158,6 +159,49 @@ static int iterate_one_csum_item(struct btrfs_fs_info *fs_info, struct btrfs_pat
>  	return ret;
>  }
>  
> +static int print_filenames(u64 ino, u64 offset, u64 rootid, void *ctx)
> +{
> +	struct btrfs_fs_info *fs_info = ctx;
> +	struct btrfs_root *root;
> +	struct btrfs_key key;
> +	struct inode_fs_paths *ipath;
> +	struct btrfs_path path = { 0 };
> +	int ret;
> +
> +	key.objectid = rootid;
> +	key.type = BTRFS_ROOT_ITEM_KEY;
> +	key.offset = (u64)-1;
> +
> +	root = btrfs_read_fs_root(fs_info, &key);
> +	if (IS_ERR(root)) {
> +		ret = PTR_ERR(root);
> +		errno = -ret;
> +		error("failed to get subvolume %llu: %m", rootid);
> +		return ret;
> +	}
> +	ipath = init_ipath(128 * BTRFS_PATH_NAME_MAX, root, &path);

128 is a magic constant, I've left it like that but we can use the
PATH_MAX and some named definition for the count.

> +	if (IS_ERR(ipath)) {
> +		ret = PTR_ERR(ipath);
> +		errno = -ret;
> +		error("failed to initialize ipath: %m");
> +		return ret;
> +	}
> +	ret = paths_from_inode(ino, ipath);
> +	if (ret < 0) {
> +		errno = -ret;
> +		error("failed to resolve root %llu ino %llu to paths: %m", rootid, ino);
> +		goto out;
> +	}
> +	for (int i = 0; i < ipath->fspath->elem_cnt; i++)
> +		printf("  (subvolume %llu)/%s\n", rootid, (char *)ipath->fspath->val[i]);
> +	if (ipath->fspath->elem_missed)
> +		printf("  (subvolume %llu) %d files not printed\n", rootid,
> +		       ipath->fspath->elem_missed);
> +out:
> +	free_ipath(ipath);
> +	return ret;
> +}
> +

