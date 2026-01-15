Return-Path: <linux-btrfs+bounces-20547-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CC8D25C32
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 17:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B270F305F502
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jan 2026 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3573B9609;
	Thu, 15 Jan 2026 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="k9fQOyM1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aGxoOmIb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KqDp+1iW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y1VxKQtL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5994A21A95D
	for <linux-btrfs@vger.kernel.org>; Thu, 15 Jan 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768494491; cv=none; b=Z9tpe4vhrR1mhjgRfsxC0M3XD670M0U5gVinUeTHpMcGA0cKvAq0gtFDcUmvMf+0K3UvEFQ/UhF/1aKSWEIgYtQZ5XL3BxRj4aRqf78LEUnocv644vU+uNtxcHZBgFsJKiISWdxW4RRXt8xF39ntD3R/8u8TIBp09kfsRrqy8co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768494491; c=relaxed/simple;
	bh=R+BU5x9nXp25uU08O0WFpqZUQU7tT/12Ym0We0ndp5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eeexH77/OVt2eefNB4paoGV4eVujNupdJY1vmm9KruG3jdq+oDehHFY6OrqRBpjtJgcY8PQ9KPDn+irW0O9tNyvc9Sdvh+Q1FtmkBAXvqjBUV90gB/c9DD/ElslJEwGwloe7yuXSPyNx9OIbt0aAqRd3WH0JkascGFmA+tB6QOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=k9fQOyM1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aGxoOmIb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KqDp+1iW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y1VxKQtL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 527E75BD40;
	Thu, 15 Jan 2026 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768494487;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXS6/iiQ7SgfPOIR/lRJyEZ12eugzEX5A6L96o9XWWE=;
	b=k9fQOyM12VZPlfCgi1rebdT1R0cS+DCdIcqFvWR/SNd5yRXWx8bm6b24C/BR1j1fa7JUcR
	pU+n91NM2osl9BQZosZsUe9BzMUh4l0JsrgZNuaSclHLDCNin8VT1oZ/0ybpINgfFKXszq
	dAap8cydfDTrTxFvGhLFfm5w3/F0Wqk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768494487;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXS6/iiQ7SgfPOIR/lRJyEZ12eugzEX5A6L96o9XWWE=;
	b=aGxoOmIb8VTWDgLdMWPtWRFJNDNNCRz/SAQlcKtbmMeXB0Uyex3w98sfkXAtw/OUbWTGaZ
	9M+v6T70eL9jQuAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KqDp+1iW;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Y1VxKQtL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768494486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXS6/iiQ7SgfPOIR/lRJyEZ12eugzEX5A6L96o9XWWE=;
	b=KqDp+1iWseW9LDJiZqocLNlrfw/pHb2qfWbJu4uStyrdQm0iXSpglJdiyq+QVfBXAgToN4
	ADYlo3xOigmsMDyZqoPy581pvBH/2+E0N2s5bE1WcvaWjPZ81Ut+8ySFjtkk4x1CeMPK+U
	1Zg84Vpb2VdJuxELdbJ83tyMXLY6Us4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768494486;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QXS6/iiQ7SgfPOIR/lRJyEZ12eugzEX5A6L96o9XWWE=;
	b=Y1VxKQtLxAfKxgERXSou+KAg2ysG+9L2zY+vOA2Wb4lOobimloaGmLpjE6zhCC1wXMoLyf
	YlHQQfSiYB3XA5DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 236143EA63;
	Thu, 15 Jan 2026 16:28:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZrF5CJYVaWlhWgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Thu, 15 Jan 2026 16:28:06 +0000
Date: Thu, 15 Jan 2026 17:28:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: add extra device item checks at mount
Message-ID: <20260115162800.GB26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <8c0924089c3297c1da0a01a3ca2d83cafa6a1f2e.1768122153.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c0924089c3297c1da0a01a3ca2d83cafa6a1f2e.1768122153.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 527E75BD40
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Mon, Jan 12, 2026 at 08:32:09AM +1030, Qu Wenruo wrote:
> [BUG]
> There is a bug report where after a dev-replace, the replace source
> device with devid 4 is properly erased (dump tree shows it's the old
> devid 4), but the target device is still using devid 0.
> 
> When the user tries to mount the fs degraded, the mount failed with the
> following errors:
> 
>  BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9 devid 5 transid 1394395 /dev/sda (8:0) scanned by btrfs (261)
>  BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9 devid 6 transid 1394395 /dev/sde (8:64) scanned by btrfs (261)
>  BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9 devid 0 transid 1394395 /dev/sdd (8:48) scanned by btrfs (261)
>  BTRFS: device fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9 devid 3 transid 1394395 /dev/sdf (8:80) scanned by btrfs (261)
>  BTRFS info (device sdd): first mount of filesystem 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>  BTRFS info (device sdd): using crc32c (crc32c-intel) checksum algorithm
>  BTRFS warning (device sdd): devid 4 uuid 01e2081c-9c2a-4071-b9f4-e1b27e571ff5 is missing
>  BTRFS info (device sdd): bdev <missing disk> errs: wr 84994544, rd 15567, flush 65872, corrupt 0, gen 0
>  BTRFS info (device sdd): bdev /dev/sdd errs: wr 71489901, rd 0, flush 30001, corrupt 0, gen 0
>  BTRFS error (device sdd): replace without active item, run 'device scan --forget' on the target device
>  BTRFS error (device sdd): failed to init dev_replace: -117
>  BTRFS error (device sdd): open_ctree failed: -117
> 
> [CAUSE]
> The devid 0 didn't get its devid updated is its own problem, here I'm
> only focusing on the mount failure itself.
> 
> The mount is not caused by the missing device, as the fs has RAID1C3 for
> metadata and RAID10 for data, thus is completely able to tolerate one
> missing device.
> 
> The device tree shows the dev-replace has properly finished:
> 
>         item 7 key (0 DEV_REPLACE 0) itemoff 15931 itemsize 72
>                 src devid -1 cursor left 11091821199360 cursor right 11091821199360 mode ALWAYS
>                 state FINISHED write errors 0 uncorrectable read errors 0
> 		      ^^^^^^^^
> 
> And the chunk tree shows there is no devid 0:
> 
>  leaf 37980736602112 items 23 free space 12548 generation 1394388 owner CHUNK_TREE
>  leaf 37980736602112 flags 0x1(WRITTEN) backref revision 1
>  fs uuid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>  chunk uuid d074c661-6311-4570-b59f-a5c83fd37f8e
>         item 0 key (DEV_ITEMS DEV_ITEM 3) itemoff 16185 itemsize 98
>                 devid 3 total_bytes 20000588955648 bytes_used 8282877984768
>                 io_align 4096 io_width 4096 sector_size 4096 type 0
>                 generation 0 start_offset 0 dev_group 0
>                 seek_speed 0 bandwidth 0
>                 uuid 0d596b69-fb0d-4031-b4af-a301d0868b8b
>                 fsid 84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
> 	...
> 
> Which shows the first device is devid 3.
> 
> But there is indeed /dev/sdd with devid 0:
> 
>  superblock: bytenr=65536, device=/dev/sdd
>  ---------------------------------------------------------
>  csum_type               0 (crc32c)
>  csum_size               4
>  csum                    0xd4bed87e [match]
>  bytenr                  65536
>  flags                   0x1
>                          ( WRITTEN )
>  magic                   _BHRfS_M [match]
>  fsid                    84a1ed4a-365c-45c3-a9ee-a7df525dc3c9
>  ...
>  uuid_tree_generation    1394388
>  dev_item.uuid           ee6532ad-5442-45f7-87fb-7703e29ed934
>  dev_item.fsid           84a1ed4a-365c-45c3-a9ee-a7df525dc3c9 [match]
>  dev_item.type           0
>  dev_item.total_bytes    20000588955648
>  dev_item.bytes_used     8292541661184
>  dev_item.io_align       0
>  dev_item.io_width       0
>  dev_item.sector_size    0
>  dev_item.devid          0 <<<
> 
> So this means device scan will register sdd as devid 0 into the fs, then
> during btrfs_init_dev_replace(), we located the replace progress item,
> found the previous replace is finished, but we still need to check if
> the dev-replace target device (devid 0) exists.
> 
> If that device exists, we error out showing that error message.
> 
> But to be honest the end user may not really remember which device is
> the replace target device, thus not sure what to do in the next step.
> 
> [ENHANCEMENT]
> To make the error more obvious, and tell the end user which devices
> should be unregistered:
> 
> - Introduce BTRFS_DEV_STATE_ITEM_FOUND flag
>   During device item read from the chunk tree, set the flag for each
>   found device item.
> 
> - Verify there is no device without the above flag during mount
>   Even missing device should have that flag set.
>   If we found a device without that flag set, it means it's an
>   unexpected one and should be rejected.
> 
> - More detailed error message on what to do next
>   This will show all unexpected devices and tell the end user to use
>   'btrfs dev scan --forget' to forget them or remove them before mount.
> 
> There is an example dmesg where a device of a valid btrfs is modified to
> have devid 0, then try degraded mount:
> 
>  BTRFS info (device dm-6): first mount of filesystem 7c873869-844c-4b39-bd75-a96148bf4656
>  BTRFS info (device dm-6): using crc32c checksum algorithm
>  BTRFS warning (device dm-6): devid 3 uuid b4a9f35b-db42-4ac4-b55a-cbf81d3b9683 is missing
>  BTRFS error (device dm-6): devid 0 path /dev/mapper/test-scratch3 is registered but not found in chunk tree
>  BTRFS error (device dm-6): please remove above devices or use 'btrfs device scan --forget <dev>' to unregister them before mount
>  BTRFS error (device dm-6): open_ctree failed: -117
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

Added to for-next, with some fixups, thanks.

> ---
>  fs/btrfs/disk-io.c |  4 ++++
>  fs/btrfs/volumes.c | 40 ++++++++++++++++++++++++++++++++++++++++
>  fs/btrfs/volumes.h |  8 ++++++++
>  3 files changed, 52 insertions(+)
> 
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 96b7b71e6911..f59bdb0074a8 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3461,6 +3461,10 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
>  	    fs_info->generation == btrfs_super_uuid_tree_generation(disk_super))
>  		set_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags);
>  
> +	if (btrfs_verify_dev_items(fs_info)) {

unlikely()

> +		ret = -EUCLEAN;
> +		goto fail_block_groups;
> +	}
>  	ret = btrfs_verify_dev_extents(fs_info);
>  	if (ret) {
>  		btrfs_err(fs_info,
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 2969e2b96538..a456786bdddc 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7244,6 +7244,7 @@ static int read_one_dev(struct extent_buffer *leaf,
>  			return -EINVAL;
>  		}
>  	}
> +	set_bit(BTRFS_DEV_STATE_ITEM_FOUND, &device->dev_state);
>  	set_bit(BTRFS_DEV_STATE_IN_FS_METADATA, &device->dev_state);
>  	if (test_bit(BTRFS_DEV_STATE_WRITEABLE, &device->dev_state) &&
>  	   !test_bit(BTRFS_DEV_STATE_REPLACE_TGT, &device->dev_state)) {
> @@ -8069,6 +8070,45 @@ int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info)
>  	return verify_chunk_dev_extent_mapping(fs_info);
>  }
>  
> +/*
> + * Ensure that all devices registered in the fs has its device items in the
> + * chunk tree.
> + *
> + * Return true if unexpected device is found.
> + * Return false otherwise.
> + */
> +bool btrfs_verify_dev_items(struct btrfs_fs_info *fs_info)

const fs_info

> +{
> +	struct btrfs_fs_devices *seed_devs;
> +	struct btrfs_device *dev;
> +	bool error = false;

bool ret

> +
> +	mutex_lock(&uuid_mutex);
> +	list_for_each_entry(dev, &fs_info->fs_devices->devices, dev_list) {
> +		if (!test_bit(BTRFS_DEV_STATE_ITEM_FOUND, &dev->dev_state)) {
> +			btrfs_err(fs_info,
> +			"devid %llu path %s is registered but not found in chunk tree",
> +				  dev->devid, btrfs_dev_name(dev));
> +			error = true;
> +		}
> +	}
> +	list_for_each_entry(seed_devs, &fs_info->fs_devices->seed_list, seed_list) {
> +		list_for_each_entry(dev, &seed_devs->devices, dev_list) {
> +			if (!test_bit(BTRFS_DEV_STATE_ITEM_FOUND, &dev->dev_state)) {
> +				btrfs_err(fs_info,
> +			"devid %llu path %s is registered but not found in chunk tree",
> +					  dev->devid, btrfs_dev_name(dev));
> +				error = true;
> +			}
> +		}
> +	}
> +	mutex_unlock(&uuid_mutex);
> +	if (error)
> +		btrfs_err(fs_info,
> +"please remove above devices or use 'btrfs device scan --forget <dev>' to unregister them before mount");
> +	return error;
> +}
> +
>  /*
>   * Check whether the given block group or device is pinned by any inode being
>   * used as a swapfile.
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 6381420800fb..9d5f67a71dc2 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -101,6 +101,13 @@ enum btrfs_raid_types {
>  #define BTRFS_DEV_STATE_NO_READA	(5)
>  #define BTRFS_DEV_STATE_FLUSH_FAILED	(6)
>  
> +/*
> + * Set when the device item is found in chunk tree.
> + *
> + * Used to catch unexpected registered device.

Reformatted comment.

> + */
> +#define BTRFS_DEV_STATE_ITEM_FOUND	(7)
> +
>  /* Special value encoding failure to write primary super block. */
>  #define BTRFS_SUPER_PRIMARY_WRITE_ERROR		(INT_MAX / 2)
>  
> @@ -870,6 +877,7 @@ enum btrfs_raid_types __attribute_const__ btrfs_bg_flags_to_raid_index(u64 flags
>  int btrfs_bg_type_to_factor(u64 flags);
>  const char *btrfs_bg_type_to_raid_name(u64 flags);
>  int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
> +bool btrfs_verify_dev_items(struct btrfs_fs_info *fs_info);
>  bool btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
>  
>  bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr);
> -- 
> 2.52.0
> 

