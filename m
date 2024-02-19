Return-Path: <linux-btrfs+bounces-2545-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5ECE85AD10
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 21:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C114B22D39
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496C053E32;
	Mon, 19 Feb 2024 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kX1OCIx5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o6ZRAM16";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sY665t8f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="deH1j0Ln"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8795E535C6;
	Mon, 19 Feb 2024 20:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374212; cv=none; b=XO2VdfNLe1vru1ylcGo3qiSCDrYYYbuTiSo9KF+RkbO3roM/LPbhdL5edRg6HLanK3A3I+MsOAkCH7YNi6DfE4uezFuBefVCuJ1W+Rh0lWzRaS3e3+YPCjbSf4EkUIOWKlFe3asLcF+bA9nnPzId5P6E4Io78MIqpQtbVUK6h24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374212; c=relaxed/simple;
	bh=uZaCMC5IWWkK0wjuMtfXpecMc77gSRyuDuSAVtOMOsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODUyZ8MyCBUn+Vi+66+n8PJfcAt6UIELPlzE+c+S0pm7s8xMbdYpiFgIV+bNMPsbhbSYw+4eOiBRYH++b/HVza/lVnHSFbj6qOhFzW4t9lAbXZXlr/tt/rlskCBJrpkThZXtOGt7BzixQQuBT2hTbu9ggZCWnxZjRt4uLVez5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kX1OCIx5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o6ZRAM16; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sY665t8f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=deH1j0Ln; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A48CD22109;
	Mon, 19 Feb 2024 20:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708374208;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IaiaYYyRrIaayqv/xsgvuF0xUZS0lMy4+lcMvWeNzEk=;
	b=kX1OCIx5L7FrOS4ttnrl+jwssJS9IshxqPo2u/zBth9Ueiil1mMczdT2j4TjuOHfcY1BPP
	1Mq3OydsFBmLiSk81VNUukc+72GUNlViR5cSC3BaA9Ysr82UqsBEIUa+MN29wDcIPAzBjZ
	zbFYcNvE+zrC+0PEZS9A3tIrSYa8g9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708374208;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IaiaYYyRrIaayqv/xsgvuF0xUZS0lMy4+lcMvWeNzEk=;
	b=o6ZRAM16QjPGOjR0eNezYoLiPPvKB4ucceCvDTdKM7GFXJOGOALsp8PENO/GIPSfdS8+Dv
	nStz0Nr/jBeYhgDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708374207;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IaiaYYyRrIaayqv/xsgvuF0xUZS0lMy4+lcMvWeNzEk=;
	b=sY665t8fRME6ZA8d7ypbzSkc9RXAlouAKJ0Fa3jy/CaZQsecK8e9jZydeDe1luNsjdGqgZ
	c2f/5qnCM+aOdg8yE9s9c6mAkXKOHYtvyJPbS/VK9lI96mBu0NZHW1QTwAeulRGhCPsc6B
	HSpea3XM9O0s5Lr7/WSauql7xBOu7zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708374207;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IaiaYYyRrIaayqv/xsgvuF0xUZS0lMy4+lcMvWeNzEk=;
	b=deH1j0LnkaQV7CHUI8lLF2NeXthu0pOZRSzbSPhXHLMKZBjb0GgX5TZd8hbFK+JQhn5LJE
	H9tNz6NrZQjxzvBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9148C13585;
	Mon, 19 Feb 2024 20:23:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7sVLI7+402VHXQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Mon, 19 Feb 2024 20:23:27 +0000
Date: Mon, 19 Feb 2024 21:22:47 +0100
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] btrfs: always open the device read-only in
 btrfs_scan_one_device
Message-ID: <20240219202247.GB355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240214-hch-device-open-v1-0-b153428b4f72@wdc.com>
 <20240214-hch-device-open-v1-1-b153428b4f72@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214-hch-device-open-v1-1-b153428b4f72@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -1.01
X-Spamd-Result: default: False [-1.01 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[50.61%]
X-Spam-Flag: NO

On Wed, Feb 14, 2024 at 08:42:12AM -0800, Johannes Thumshirn wrote:
> From: Christoph Hellwig <hch@lst.de>
> 
> btrfs_scan_one_device opens the block device only to read the super
> block.  Instead of passing a blk_mode_t argument to sometimes open
> it for writing, just hard code BLK_OPEN_READ as it will never write
> to the device or hand the block_device out to someone else.

Opening for write was not meant to be for writing but also to exclude
other attempted writes.

That it's always for read seems OK, this has changed at some point and
is explained in btrfs_scan_one_device():

1356         /*
1357          * Avoid an exclusive open here, as the systemd-udev may initiate the 
1358          * device scan which may race with the user's mount or mkfs command,  
1359          * resulting in failure.                                              
1360          * Since the device scan is solely for reading purposes, there is no   
1361          * need for an exclusive open. Additionally, the devices are read again
1362          * during the mount process. It is ok to get some inconsistent    
1363          * values temporarily, as the device paths of the fsid are the only
1364          * required information for assembling the volume.
1365          */
1366         bdev_handle = bdev_open_by_path(path, flags, NULL, NULL);

