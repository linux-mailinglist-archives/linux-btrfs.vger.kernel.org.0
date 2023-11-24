Return-Path: <linux-btrfs+bounces-347-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727137F78E4
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 17:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2F5B210E3
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Nov 2023 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B5F341A8;
	Fri, 24 Nov 2023 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GjyH1eL4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VebehqG9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679C2199A
	for <linux-btrfs@vger.kernel.org>; Fri, 24 Nov 2023 08:26:23 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EADC321E76;
	Fri, 24 Nov 2023 16:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700843181;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntsd2UZ+jt5qjybwKgybez9NbW61Ujsc+l2C3IDSlvU=;
	b=GjyH1eL4O/phTQFrcn27VZF2wdR0abTV8B1wcR+ES1X46Sp2ShHa74CGBw8n/LhD8Rjk81
	kzK/0jYKtjpW/L6loNsdnG5UlZEVj6ta+lXAnwqSWEI8vaB8l42wHrSqSLvXA+ZKJ/10EC
	RWAHwioNPJBIvKN0PLliNBzSOSG/MOc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700843181;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ntsd2UZ+jt5qjybwKgybez9NbW61Ujsc+l2C3IDSlvU=;
	b=VebehqG9RbsmDFrU9ktpYa4s9u0Qj58aB78/avhV0SpdbwfgyowFNHLhzwDiNwLAJGTqlE
	AJpL/lubdMyjiSAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BE538132E2;
	Fri, 24 Nov 2023 16:26:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qSEpLa3OYGU/RQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 24 Nov 2023 16:26:21 +0000
Date: Fri, 24 Nov 2023 17:19:06 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH RFC] btrfs: pick device with lowest devt for show_devname
Message-ID: <20231124161906.GE18929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85226cf68d7a72a034f0c0895b96b2557169755b.1698917826.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: 1.72
X-Spamd-Result: default: False [1.72 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_SPAM_SHORT(1.02)[0.341];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]

On Thu, Nov 02, 2023 at 07:10:48PM +0800, Anand Jain wrote:
> In a non-single-device Btrfs filesystem, if Btrfs is already mounted and
> if you run the command 'mount -a,' it will fail and the command
> 'umount <device>' also fails. As below:
> 
> ----------------
> $ cat /etc/fstab | grep btrfs
> UUID=12345678-1234-1234-1234-123456789abc /btrfs btrfs defaults,nofail 0 0
> 
> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1
> $ mount --verbose -a
> /                        : ignored
> /btrfs                   : successfully mounted
> 
> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
> lrwxrwxrwx 1 root root 10 Nov  2 17:43 12345678-1234-1234-1234-123456789abc -> ../../sda1
> 
> $ cat /proc/self/mounts | grep btrfs
> /dev/sda2 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
> 
> $ findmnt --df /btrfs
> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
> /dev/sda2 btrfs    2G  5.8M  1.8G   0% /btrfs
> 
> $ mount --verbose -a
> /                        : ignored
> mount: /btrfs: /dev/sda1 already mounted or mount point busy.
> $echo $?
> 32
> 
> $ umount /dev/sda1
> umount: /dev/sda1: not mounted.
> $ echo $?
> 32
> ----------------
> 
> I assume (RFC) this is because '/dev/disk/by-uuid,' '/proc/self/mounts,'
> and 'findmnt' do not all reference the same device, resulting in the
> 'mount -a' and 'umount' failures. However, an empirically found solution
> is to align them using a rule, such as the disk with the lowest 'devt,'
> for a multi-device Btrfs filesystem.
> 
> I'm not yet sure (RFC) how to create a udev rule to point to the disk with
> the lowest 'devt,' as this kernel patch does, and I believe it is
> possible.
> 
> And this would ensure that '/proc/self/mounts,' 'findmnt,' and
> '/dev/disk/by-uuid' all reference the same device.
> 
> After applying this patch, the above test passes. Unfortunately,
> /dev/disk/by-uuid also points to the lowest 'devt' by chance, even though
> no rule has been set as of now. As shown below.
> 
> ----------------
> $ mkfs.btrfs -qf --uuid 12345678-1234-1234-1234-123456789abc /dev/sda2 /dev/sda1
> 
> $ mount --verbose -a
> /                        : ignored
> /btrfs                   : successfully mounted
> 
> $ ls -l /dev/disk/by-uuid | grep 12345678-1234-1234-1234-123456789abc
> lrwxrwxrwx 1 root root 10 Nov  2 17:53 12345678-1234-1234-1234-123456789abc -> ../../sda1
> 
> $ cat /proc/self/mounts | grep btrfs
> /dev/sda1 /btrfs btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0
> 
> $ findmnt --df /btrfs
> SOURCE    FSTYPE SIZE  USED AVAIL USE% TARGET
> /dev/sda1 btrfs    2G  5.8M  1.8G   0% /btrfs
> 
> $ mount --verbose -a
> /                        : ignored
> /btrfs                   : already mounted
> $echo $?
> 0
> 
> $ umount /dev/sda1
> $echo $?
> 0
> ----------------
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/super.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> index 66bdb6fd83bd..d768917cc5cc 100644
> --- a/fs/btrfs/super.c
> +++ b/fs/btrfs/super.c
> @@ -2301,7 +2301,18 @@ static int btrfs_unfreeze(struct super_block *sb)
>  
>  static int btrfs_show_devname(struct seq_file *m, struct dentry *root)
>  {
> -	struct btrfs_fs_info *fs_info = btrfs_sb(root->d_sb);
> +	struct btrfs_fs_devices *fs_devices = btrfs_sb(root->d_sb)->fs_devices;
> +	struct btrfs_device *device;
> +	struct btrfs_device *first_device = NULL;
> +
> +	list_for_each_entry(device, &fs_devices->devices, dev_list) {
> +		if (first_device == NULL) {
> +			first_device = device;
> +			continue;
> +		}
> +		if (first_device->devt > device->devt)
> +			first_device = device;
> +	}

I think we agree in principle that the devt can be used to determine the
device to print in show_devname, however I'd like to avoid iterating the
device list here. We used to have it, first with mutex protection, then
RCU. That we can simply print the latest_dev is quite convenient.

I suggest to either add a separate fs_info variable to set the desired
device and only print it here, or reuse latest_dev for that.

Adding a separate variable for that should be safer as latest_dev is
used in various way and I can't say it's always clear.

