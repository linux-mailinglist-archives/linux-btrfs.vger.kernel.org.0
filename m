Return-Path: <linux-btrfs+bounces-3378-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1084A87F334
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 23:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D239B21393
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Mar 2024 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2825E5A78C;
	Mon, 18 Mar 2024 22:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="W1HrgQFH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hEOIF4Ku";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xs1LvmEb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i6YDtVvi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78C5A4E2
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Mar 2024 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710801837; cv=none; b=haUnZQ4m/FZPcdjSD4fZi4RrRHU6TtLSFmBrd2YoVB44AJcwqwmoiX+XxpKbS6TStNPf2/BAJUTYpqxo9/3HzYXC3Ji+3RqSUHIqZddebKFnc6s5eC21IUCptYkSaaXQk9Ay069AZkY3rb5Fi3fE4gAfqDLh2d+tMhN3ceDugNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710801837; c=relaxed/simple;
	bh=+cedA9Hq7MnoiVXNzyf1QgOo7THo6dMHCnkfx1mY6DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcnFIqcG1GDa7hRVqW40CUW3yt3HcP/bUylJUZ4HSw0HV/QrMGKsdE0AejXHRlTnQZUCQWJthWElerOI2Ty7YQu5gPljFIWvdGgp54vWj/7s4CvLqB6/l65mgzDyy0YJbuAeOfWTBMUaRqRcRYQNsWuHN3rQP1q+kr2+dNMrOWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=W1HrgQFH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hEOIF4Ku; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xs1LvmEb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i6YDtVvi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BD71D5CC2D;
	Mon, 18 Mar 2024 22:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710801833;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huPVR4YqE9DTViqWHAZIoaVoY6euSjj/P+/SCp4JEag=;
	b=W1HrgQFHZFIX7FqNlnT3Q6zWmrvtXEYH47sw1FP0l1/vbQ+xfmjD1cYLxKQW8lHEQSu1HZ
	Adwe5lrA/8LDAQ7pM0ACxXjYQB6FrQ4PX9Q+JadZgRvxbkWSErSKDjtEf+trzbA+oVKnTv
	JnYMLBSWamF4/pHiSxM7ZEO7EfE/kfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710801833;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huPVR4YqE9DTViqWHAZIoaVoY6euSjj/P+/SCp4JEag=;
	b=hEOIF4KuWKsCdi3mCCNYiXLQIPClQSw5KgkbpIIWIHaluZCpmixB1V4CiBd0m3gXxQ6r9F
	yU5yYhXguMpoXGBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710801832;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huPVR4YqE9DTViqWHAZIoaVoY6euSjj/P+/SCp4JEag=;
	b=Xs1LvmEbu8pmGbB3ygE4NC2rw3Lk8mF3Pyy6P7qyehvHwUoGrjyLjZ7jpDdbScgQ1wNCmS
	LtJviqSZyWIb94fxzEx28Py7BbRX+nt9426py/9mLSe10RzD1W2GIFmirOv71QR5e05+on
	2eEkL2R5XvzWtsBzKMfFn7JRYsS3xnQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710801832;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=huPVR4YqE9DTViqWHAZIoaVoY6euSjj/P+/SCp4JEag=;
	b=i6YDtVviKKTwkWn82cKC9BC4L5jD485wbD6GFJTn204G5QHMOA3mXjeDF7gqIyhH9fXWbD
	SQ94PlwmEt3x97Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC33D136A5;
	Mon, 18 Mar 2024 22:43:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 63DaKajD+GWsWQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 18 Mar 2024 22:43:52 +0000
Date: Mon, 18 Mar 2024 23:36:35 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: return accurate error code on open failure
Message-ID: <20240318223635.GM16737@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <dfe752bda3e3d57c352725a4951e332b016506a9.1709991269.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe752bda3e3d57c352725a4951e332b016506a9.1709991269.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Xs1LvmEb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i6YDtVvi
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.21 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.19)[-0.971];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[37.42%]
X-Spam-Score: -1.21
X-Rspamd-Queue-Id: BD71D5CC2D
X-Spam-Flag: NO

On Sat, Mar 09, 2024 at 07:16:35PM +0530, Anand Jain wrote:
> When attempting to exclusive open a device which has no exclusive open
> permission, such as a physical device associated with the flakey dm
> device, the open operation will fail, resulting in a mount failure.
> 
> In this particular scenario, we erroneously return -EINVAL instead of the
> correct error code provided by the bdev_open_by_path() function, which is
> -EBUSY.
> 
> Fix this, by returning error code from the bdev_open_by_path() function.
> With this correction, the mount error message will align with that of
> ext4 and xfs.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/volumes.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bb0857cfbef2..8a35605822bf 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -1191,6 +1191,7 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>  	struct btrfs_device *device;
>  	struct btrfs_device *latest_dev = NULL;
>  	struct btrfs_device *tmp_device;
> +	int ret_err = 0;

Please use 'ret' here

>  
>  	list_for_each_entry_safe(device, tmp_device, &fs_devices->devices,
>  				 dev_list) {
> @@ -1205,9 +1206,15 @@ static int open_fs_devices(struct btrfs_fs_devices *fs_devices,
>  			list_del(&device->dev_list);
>  			btrfs_free_device(device);
>  		}
> +		if (ret_err == 0 && ret != 0)

and rename the original 'ret' used in the scope as 'ret2', this is the
preferred pattern. For simple changes within one function it's ok to do
it in one patch.

