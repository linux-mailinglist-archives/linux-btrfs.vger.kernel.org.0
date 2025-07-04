Return-Path: <linux-btrfs+bounces-15249-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2546FAF85FC
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 05:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7578A56531D
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jul 2025 03:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D575F1DF26B;
	Fri,  4 Jul 2025 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NB4Ny3Oi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1qJLzzZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NB4Ny3Oi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1qJLzzZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431ED189902
	for <linux-btrfs@vger.kernel.org>; Fri,  4 Jul 2025 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751598885; cv=none; b=OwpI40fHXSKpEU5/BDe+S2DtwoVDJjVej4DO9lZ8vjg5D+xF51XTorzy3kCddXOtRsMENbYZ5wRDzpmt4Ua9JW3CexK3/K67AKLlzPFSoLA5lGXUkVvOchdvzUj3h90q1N0J7WlMGoVbMe0QzxVL7l/Kg1EEvRV8EsCFzFoEVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751598885; c=relaxed/simple;
	bh=hkVvyfW3/73RQvV8DKitS/kKi1PQjALs1As9tpfTnZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgiTofh0bLPTx43d3dUzyB75nE4o3dtXEVTX8BurPpMnj16D7SaVeiuut8gluS0kP+GBk4y4phUQozjvcfRjk9kER1R3Y6Qcj2E/Oprj1+ofp42+cKUO6nokjZQFgOCAT8fGQFJzq7AAGAGlb/uBbDya50+W1UfBlDQarDuC5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NB4Ny3Oi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U1qJLzzZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NB4Ny3Oi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U1qJLzzZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B5E221191;
	Fri,  4 Jul 2025 03:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751598881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJV4bIvQIYbRtpQjNBl7tM9LGQu+NXrNHRCeRTYtmYM=;
	b=NB4Ny3Oimr6ONtOtg8rr1RcY1SHSO88MfRvHGnR4EB4oJ4ss8YWU3h4qlNczqu4anYrsHI
	8IGApHPx7orwNKFRcGTpBADOZm+s92UNjqwVML5TwtrAEuNkWW42RxfujaB18vVrhix5XZ
	FiYSMN/f975EbsToWNJfnhA4O8qRCQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751598881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJV4bIvQIYbRtpQjNBl7tM9LGQu+NXrNHRCeRTYtmYM=;
	b=U1qJLzzZl+l6s/AXNRy+Vfw3S7KpFCPFOG5rH6f8eFVMDbdMV0USRIXRmDPEJt027ZULr0
	u64InGTuWSHk9BAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751598881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJV4bIvQIYbRtpQjNBl7tM9LGQu+NXrNHRCeRTYtmYM=;
	b=NB4Ny3Oimr6ONtOtg8rr1RcY1SHSO88MfRvHGnR4EB4oJ4ss8YWU3h4qlNczqu4anYrsHI
	8IGApHPx7orwNKFRcGTpBADOZm+s92UNjqwVML5TwtrAEuNkWW42RxfujaB18vVrhix5XZ
	FiYSMN/f975EbsToWNJfnhA4O8qRCQE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751598881;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJV4bIvQIYbRtpQjNBl7tM9LGQu+NXrNHRCeRTYtmYM=;
	b=U1qJLzzZl+l6s/AXNRy+Vfw3S7KpFCPFOG5rH6f8eFVMDbdMV0USRIXRmDPEJt027ZULr0
	u64InGTuWSHk9BAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CE3613757;
	Fri,  4 Jul 2025 03:14:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +jKvAiFHZ2jAOQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 04 Jul 2025 03:14:41 +0000
Date: Fri, 4 Jul 2025 05:14:39 +0200
From: David Sterba <dsterba@suse.cz>
To: Wang Yugui <wangyugui@e16-tech.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: open code RCU for device name
Message-ID: <20250704031439.GA31241@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250630162130.GK31241@twin.jikos.cz>
 <20250630164328.GL31241@twin.jikos.cz>
 <20250702072946.6BE5.409509F4@e16-tech.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702072946.6BE5.409509F4@e16-tech.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fedoraproject.org:url,suse.cz:mid,suse.cz:replyto]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -4.00

On Wed, Jul 02, 2025 at 07:29:47AM +0800, Wang Yugui wrote:
> > I can't seem to reproduce the warning with the command, I'm going to apply this
> > fixup:
> 
> steps to reproduce the warning:
> 1) install https://kojipkgs.fedoraproject.org/packages/sparse/0.6.4/
> 2) make btrfs module(kernel 6.16) with the commands
> #uname_r=$(uname -r)
> uname_r=$(ls /boot/vmlinuz-6.16.* 2>/dev/null)
> uname_r=${uname_r##/boot/vmlinuz-}
> pwd_dir=$(pwd)
> make -C /lib/modules/${uname_r}/build M=${pwd_dir} modules -j 20 W=1 C=1 CF="-Wnocontext"

I did try the W=1 C=1 build but there were no reports, even with update
sparse (which is what is run with bare C=1 I believe).

> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index bb91a7b..5080ab2 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -699,7 +699,7 @@ static int btrfs_open_one_device(struct btrfs_fs_devices *fs_devices,
>  	if (!device->name)
>  		return -EINVAL;
>  
> -	ret = btrfs_get_bdev_and_sb(device->name, flags, holder, 1,
> +	ret = btrfs_get_bdev_and_sb(rcu_dereference(device->name), flags, holder, 1,
>  				    &bdev_file, &disk_super);
>  	if (ret)
>  		return ret;
> @@ -1061,7 +1061,7 @@ static struct btrfs_fs_devices *clone_fs_devices(struct btrfs_fs_devices *orig)
>  		 * uuid mutex so nothing we touch in here is going to disappear.
>  		 */
>  		if (orig_dev->name)
> -			dev_path = orig_dev->name;
> +			dev_path = rcu_dereference(orig_dev->name);
>  
>  		device = btrfs_alloc_device(NULL, &orig_dev->devid,
>  					    orig_dev->uuid, dev_path);
> @@ -1436,7 +1436,7 @@ static bool btrfs_skip_registration(struct btrfs_super_block *disk_super,
>  
>  		list_for_each_entry(device, &fs_devices->devices, dev_list) {
>  			if (device->bdev && (device->bdev->bd_dev == devt) &&
> -			    strcmp(device->name, path) != 0) {
> +			    strcmp(rcu_dereference(device->name), path) != 0) {
>  				mutex_unlock(&fs_devices->device_list_mutex);
>  
>  				/* Do not skip registration. */
> @@ -2197,7 +2197,7 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info, struct btrfs_devic
>  	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
>  
>  	/* Update ctime/mtime for device path for libblkid */
> -	update_dev_time(device->name);
> +	update_dev_time(rcu_dereference(device->name));
>  }

I've updated the patch, this is basically equivalent to the same
expression but does not report any RCU violation. This should be safe in
all cases so the _raw's are justified for this patchset. The handling of
device->name perhaps does not fit any common pattern for RCU so we can't
avoid it. The protection involves no mounted filesystem (the scanning
ioctl) and then access when the filesystem is mounted. We have the
uuid_mutex for serializing everything.

For linux-next, I've updated the patch to use rcu_dereference_raw(),
depending on when the branch is picked for merge there should be no
warnings anymore.

