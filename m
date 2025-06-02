Return-Path: <linux-btrfs+bounces-14395-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581B6ACBC35
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 22:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12910173488
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 20:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2558E14B965;
	Mon,  2 Jun 2025 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NDlzFDJx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2A0k63G9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NDlzFDJx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2A0k63G9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDFE23CE
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748895374; cv=none; b=BKeVaR68yUuRbxdmhiWTredd52EtfMgC4ewdXgprK/sedG33ougOHEsx5Yg6sC9QnikXpiCwMQBcdmmAnXIoKtSYoXJEbJahpFtjK4L2lCXhA9DR21GR7B5n6TVXgimNBBIcePK3NSLW4kW5Li+kcRtYTUKfDFCTjaa935iv3O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748895374; c=relaxed/simple;
	bh=FPXDRTxtsJoDHSJYpap+UBMRRwjVRvYlwPB5jaP2OVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twtSIITrTPUY+SW0dUFY8e/ilXD94geUGnA3M3HOXNPkrNqh73bwNGIzjZSvAG5dmztuzAc7qAwh4zEQ1pVECZ3C4NdEJWPH5VOwaF0O9MJXQwwu/axbQv++sCKqMvL9tXzqV9SR28rMBv988lBmkEpNN6dXhkkM0nEvfKXvBwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NDlzFDJx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2A0k63G9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NDlzFDJx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2A0k63G9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B117F1F7BB;
	Mon,  2 Jun 2025 20:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748895370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eqShJfjpTGkeiejEy8KwUz3K3USF3jwaRsnzPXwIaI=;
	b=NDlzFDJxb6BX5sqPp1awqEfNjGU5tlS3IzwPb5C9eNNf2hZiclZtCz7a757/jKc2CRSblA
	aAXNLUKCtIbGzPBGOS5/mF80q+ZrNaKLpHU8Jo46wrJvWJ2GZByA123IgrNNsmzcJXzu0l
	2sq3sQbUznVpD2ZmtOKJ/rV+k1xGTW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748895370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eqShJfjpTGkeiejEy8KwUz3K3USF3jwaRsnzPXwIaI=;
	b=2A0k63G9iuv+DQhujxA6U2EcumYXKKDCVhoQ3Ub0jFi7esVhTKYySJT1S3SjKj0gdd8gi1
	ZGSQFZ1dV4w1FwCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748895370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eqShJfjpTGkeiejEy8KwUz3K3USF3jwaRsnzPXwIaI=;
	b=NDlzFDJxb6BX5sqPp1awqEfNjGU5tlS3IzwPb5C9eNNf2hZiclZtCz7a757/jKc2CRSblA
	aAXNLUKCtIbGzPBGOS5/mF80q+ZrNaKLpHU8Jo46wrJvWJ2GZByA123IgrNNsmzcJXzu0l
	2sq3sQbUznVpD2ZmtOKJ/rV+k1xGTW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748895370;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5eqShJfjpTGkeiejEy8KwUz3K3USF3jwaRsnzPXwIaI=;
	b=2A0k63G9iuv+DQhujxA6U2EcumYXKKDCVhoQ3Ub0jFi7esVhTKYySJT1S3SjKj0gdd8gi1
	ZGSQFZ1dV4w1FwCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94E95136C7;
	Mon,  2 Jun 2025 20:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HnDMI4oGPmi4VgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Jun 2025 20:16:10 +0000
Date: Mon, 2 Jun 2025 22:16:09 +0200
From: David Sterba <dsterba@suse.cz>
To: Mark Harmstone <maharmstone@fb.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: update superblock's device bytes_used when
 dropping chunk
Message-ID: <20250602201609.GH4037@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250529093821.2818081-1-maharmstone@fb.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529093821.2818081-1-maharmstone@fb.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Thu, May 29, 2025 at 10:37:44AM +0100, Mark Harmstone wrote:
> Each superblock contains a copy of the device item for that device. In a
> transaction which drops a chunk but doesn't create any new ones, we were
> correctly updating the device item in the chunk tree but not copying
> over the new bytes_used value to the superblock.
> 
> This can be seen by doing the following:
> 
>  # cd
>  # dd if=/dev/zero of=test bs=4096 count=2621440
>  # mkfs.btrfs test
>  # mount test /root/temp
> 
>  # cd /root/temp
>  # for i in {00..10}; do dd if=/dev/zero of=$i bs=4096 count=32768; done
>  # sync
>  # rm *
>  # sync
>  # btrfs balance start -dusage=0 .
>  # sync
> 
>  # cd
>  # umount /root/temp
>  # btrfs check test
> 
> (For btrfs-check to detect this, you will also need my patch at
> https://github.com/kdave/btrfs-progs/pull/991.)
> 
> Change btrfs_remove_dev_extents() so that it adds the devices to the

There's no btrfs_remove_dev_extents(), the code is in
btrfs_remove_chunk()

> post_commit_list if they're not there already. This causes
> btrfs_commit_device_sizes() to be called, which updates the bytes_used
> value in the superblock.
> 
> Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> ---
>  fs/btrfs/volumes.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index e59aa0b5c4f3..ee886dc08d15 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -3272,6 +3272,12 @@ int btrfs_remove_dev_extents(struct btrfs_trans_handle *trans,
>  					device->bytes_used - dev_extent_len);
>  			atomic64_add(dev_extent_len, &fs_info->free_chunk_space);
>  			btrfs_clear_space_info_full(fs_info);
> +
> +			if (list_empty(&device->post_commit_list)) {
> +				list_add_tail(&device->post_commit_list,
> +					      &trans->transaction->dev_update_list);
> +			}

There are 2 cases, one is being fixed here. I wonder if we can add some
sort of assertion or transaction commit time verification that we don't
miss that in the future. The pattern seems to be after
btrfs_device_set_bytes_used() and btrfs_clear_space_info_full(). We'd
have to have something set a bit in btrfs_device_set_bytes_used() and
check it in commit unless something unset it when adding the device to
the dev_update_list.

Otherwise ok,

Reviewed-by: David Sterba <dsterba@suse.com>

