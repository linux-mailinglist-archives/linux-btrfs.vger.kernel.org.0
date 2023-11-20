Return-Path: <linux-btrfs+bounces-196-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A50B7F1632
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 15:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3102825A6
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Nov 2023 14:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B09918E12;
	Mon, 20 Nov 2023 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AY9ttAF6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qpEBVSai"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA03C1FFA
	for <linux-btrfs@vger.kernel.org>; Mon, 20 Nov 2023 06:49:34 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AFC62190C;
	Mon, 20 Nov 2023 14:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700491773;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09LUu0ST12gSjhN++fE3kmeeA70XtH/sMtqDW0ggv+I=;
	b=AY9ttAF6axFS4wwU8zmGlBPRPL9Fxy257w1QzV0hMtRURkyOHd12dn+1H+LVCQzriAjkQO
	wvSqyLe5rm5WMB2rPxCwuWGZpd4mUkZYK8/x+9asX1J574fIfgn39W9PHqqnwxXaPgTn3I
	ZHurc1phfw5Fovz+nA2hh9eK/aG6Ve0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700491773;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09LUu0ST12gSjhN++fE3kmeeA70XtH/sMtqDW0ggv+I=;
	b=qpEBVSairhkhe0iQrXO1kSLkEuJzAleGSX633C8FAEEAowKULzyXN4Vj3coKSCavtl3AMq
	teF5FFXTLbwft2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF5E113499;
	Mon, 20 Nov 2023 14:49:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id E2MYLvxxW2ViMQAAMHmgww
	(envelope-from <dsterba@suse.cz>); Mon, 20 Nov 2023 14:49:32 +0000
Date: Mon, 20 Nov 2023 15:42:24 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: dsterba@suse.cz, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Message-ID: <20231120144224.GL11264@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
 <20231102202652.GK11264@twin.jikos.cz>
 <f5a58903-b6c8-4cfd-9328-ea8214ca3399@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5a58903-b6c8-4cfd-9328-ea8214ca3399@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.92
X-Spamd-Result: default: False [-3.92 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 NEURAL_HAM_LONG(-0.92)[-0.925];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Fri, Nov 03, 2023 at 06:55:51AM +0800, Anand Jain wrote:
> On 11/3/23 04:26, David Sterba wrote:
> > On Thu, Nov 02, 2023 at 07:10:48PM +0800, Anand Jain wrote:
> >> In a non-single-device Btrfs filesystem, if Btrfs is already mounted and
> >> if you run the command 'mount -a,' it will fail and the command
> >> 'umount <device>' also fails. As below:
> >>
> >> ----------------
> >> $ cat /etc/fstab | grep btrfs
> >> UUID=12345678-1234-1234-1234-123456789abc /btrfs btrfs defaults,nofail 0 0
> >>
> >> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1
> >> $ mount --verbose -a
> >> /                        : ignored
> >> /btrfs                   : successfully mounted
> >>
> >> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
> >> lrwxrwxrwx 1 root root 10 Nov  2 17:43 12345678-1234-1234-1234-123456789abc -> ../../sda1
> >>
> >> $ cat /proc/self/mounts | grep btrfs
> >> /dev/sda2 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
> >>
> >> $ findmnt --df /btrfs
> >> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
> >> /dev/sda2 btrfs    2G  5.8M  1.8G   0% /btrfs
> >>
> >> $ mount --verbose -a
> >> /                        : ignored
> >> mount: /btrfs: /dev/sda1 already mounted or mount point busy.
> >> $echo $?
> >> 32
> >>
> >> $ umount /dev/sda1
> >> umount: /dev/sda1: not mounted.
> >> $ echo $?
> >> 32
> >> ----------------
> >>
> >> I assume (RFC) this is because '/dev/disk/by-uuid,' '/proc/self/mounts,'
> >> and 'findmnt' do not all reference the same device, resulting in the
> >> 'mount -a' and 'umount' failures. However, an empirically found solution
> >> is to align them using a rule, such as the disk with the lowest 'devt,'
> >> for a multi-device Btrfs filesystem.
> >>
> >> I'm not yet sure (RFC) how to create a udev rule to point to the disk with
> >> the lowest 'devt,' as this kernel patch does, and I believe it is
> >> possible.
> >>
> >> And this would ensure that '/proc/self/mounts,' 'findmnt,' and
> >> '/dev/disk/by-uuid' all reference the same device.
> >>
> >> After applying this patch, the above test passes. Unfortunately,
> >> /dev/disk/by-uuid also points to the lowest 'devt' by chance, even though
> >> no rule has been set as of now. As shown below.
> > 
> > Does this mean the devid of the device shown in /proc/self/mount won't
> > be the lowest? Here the devid is the logical device number, while devt
> > is some internal identifier or at least not something I'd consider a
> > good identifier from user perspective.
> > 
> > The lowest devid has been there for a long time so I'd consider this as
> > behaviour change which can potentially break things.
> 
> It's not the lowest devid, but rather the latest_bdev since commit
> 6605fd2f394b ('btrfs: use latest_dev in btrfs_show_devname').
> 
> We need a rule for choosing a device in a multi-device filesystem that
> works both inside and outside the kernel. The major-minor (devt) is the
> only consistent option.

I'm not sure how users interpret the device path in the proc/mounts
output so changing that can potentially break something. OTOH if the
device hasn't been always the lowest one (i.e. no assumptions because of
the mentioned commit), then we can use the devt.

