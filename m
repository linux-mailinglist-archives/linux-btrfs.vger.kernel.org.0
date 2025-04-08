Return-Path: <linux-btrfs+bounces-12893-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7BDA81901
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Apr 2025 00:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3BB3A98E4
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Apr 2025 22:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBE52566D5;
	Tue,  8 Apr 2025 22:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mxqy+Hqb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="D18k3pKr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hbtCBZ/5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mhaqPr6a"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BFD2561DC
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Apr 2025 22:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744152482; cv=none; b=jpeyJdHVx3Q8J17LCRdDGCpdwbqE1bpYVNtduDxf6n2/wkaKh7dw8S93XxgpCMwOvygWDotsXE2+snkwYaUnMwF2NoIGb6/FhHq8UTmmggTUoWd96cAS8nwlNclKvs8WyeEWND67pfOW3s6/UJs0ZShsPLY13VVAhIPIztUn5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744152482; c=relaxed/simple;
	bh=Jbe/98dp+EuqRLWP7cw/1jKGl1zqnZvcRH8lxwRKHVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e57QPJQg/Ic7V53c1n9cPy2K80V73n1oA+gKJ9RpM00JmU5W7HdiwLdM/d7UAwowWal/gKKfKIRP1mazD0XiDVrWsgmcSoVxNpt1961rpE/B58uOwfymIlWJyHX4SIspGvueJU6M7/vVcAF5Mt4Y751cU7QkQAne6mAOOnc5zHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mxqy+Hqb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=D18k3pKr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hbtCBZ/5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mhaqPr6a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F1CBA2116C;
	Tue,  8 Apr 2025 22:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744152479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWphO4ey+lxM+jIkAUI2g/YNSOxgfU+/VZAsAKrSDCM=;
	b=mxqy+Hqb2U38gETAyGqDdEvzEaFx4QJmQ2fkDNMe27TaLe8KRt4hx4+cmwjjE0/duA6M9n
	7WZg54UkozDj0isU0x2r6D6wGFfX6npG+Z26sUSdOSl18QkeKZDZaiUnPvArTKW8tmPtRJ
	qeoWJUapb1b0U82v+H62QYNSzevyQOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744152479;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWphO4ey+lxM+jIkAUI2g/YNSOxgfU+/VZAsAKrSDCM=;
	b=D18k3pKrCzxfc4g2f2u2DxeX2eNRom45DqPQg6nvtUWmUxZ97mACz91N86PiGtdHCTab/Z
	5l3nA359iHmJL9Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1744152478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWphO4ey+lxM+jIkAUI2g/YNSOxgfU+/VZAsAKrSDCM=;
	b=hbtCBZ/5nK+onM9neqFylaMYqYyUQt5qMEiwE53jsqX5jCyIUECVqTSTT4PNi0uaA5hxuT
	KRFDAsoM9lWlDsjx1qohuqTs/dP+xBYNOI4aRVuiFzBYsVM1hHSz7N1zLsN/CiN7Ji5dsd
	W1Y3Z0cWaGTn96FBGSje59c1RnAmgrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1744152478;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TWphO4ey+lxM+jIkAUI2g/YNSOxgfU+/VZAsAKrSDCM=;
	b=mhaqPr6atzrKJnFScTDThdhqOitwq5eyueuvFJnhoxHcwyTzqKgN3WDKOUUcKv2meCciU0
	MDpH8m/CWRw6qGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D1AA413691;
	Tue,  8 Apr 2025 22:47:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MQO3Mp6n9WeNTwAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 08 Apr 2025 22:47:58 +0000
Date: Wed, 9 Apr 2025 00:47:49 +0200
From: David Sterba <dsterba@suse.cz>
To: Yangtao Li <frank.li@vivo.com>
Cc: clm@fb.com, josef@toxicpanda.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] btrfs: use BTRFS_PATH_AUTO_FREE in
 insert_balance_item()
Message-ID: <20250408224749.GD13292@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250408122933.121056-1-frank.li@vivo.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408122933.121056-1-frank.li@vivo.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,twin.jikos.cz:mid];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -4.00
X-Spam-Flag: NO

On Tue, Apr 08, 2025 at 06:29:30AM -0600, Yangtao Li wrote:
> All cleanup paths lead to btrfs_path_free so we can define path with the
> automatic free callback.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/btrfs/volumes.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index c8c21c55be53..a962efaec4ea 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3730,7 +3730,7 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
>  	struct btrfs_trans_handle *trans;
>  	struct btrfs_balance_item *item;
>  	struct btrfs_disk_balance_args disk_bargs;
> -	struct btrfs_path *path;
> +	BTRFS_PATH_AUTO_FREE(path);
>  	struct extent_buffer *leaf;
>  	struct btrfs_key key;
>  	int ret, err;
> @@ -3740,10 +3740,8 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
>  		return -ENOMEM;
>  
>  	trans = btrfs_start_transaction(root, 0);
> -	if (IS_ERR(trans)) {
> -		btrfs_free_path(path);
> +	if (IS_ERR(trans))
>  		return PTR_ERR(trans);
> -	}
>  
>  	key.objectid = BTRFS_BALANCE_OBJECTID;
>  	key.type = BTRFS_TEMPORARY_ITEM_KEY;
> @@ -3767,7 +3765,6 @@ static int insert_balance_item(struct btrfs_fs_info *fs_info,
>  	btrfs_set_balance_sys(leaf, item, &disk_bargs);
>  	btrfs_set_balance_flags(leaf, item, bctl->flags);
>  out:
> -	btrfs_free_path(path);

The pattern where btrfs_free_path() is not called at the end and is
followed by other code is probably not worth converting. It would be
possible to replace it by

	btrfs_release_path(path);
	path = NULL;

that drops the locks and refs from the path but this does not save us
much compared to the straightforward BTRFS_PATH_AUTO_FREE() conversions.
Also release will still keep the object allocated although we don't need
it. As a principle, resources, locks and critical sections should be as
short as possible.

Unfortunatelly I've probably fished all the trivial and almost-trivial
conversions, we don't want 100% use of BTRFS_PATH_AUTO_FREE(), only when
it improves the code.

You may still find cases worth converting, the typical pattern is
btrfs_path_alloc() somewhere near top of the function and
btrfs_free_path() called right before a return.

