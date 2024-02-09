Return-Path: <linux-btrfs+bounces-2266-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6162E84EE87
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 02:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19A2A2892CA
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Feb 2024 01:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49BF1FBA;
	Fri,  9 Feb 2024 01:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1xUy9Juk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EE8FlbGK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1xUy9Juk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EE8FlbGK"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20828184D
	for <linux-btrfs@vger.kernel.org>; Fri,  9 Feb 2024 01:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707441063; cv=none; b=FzyLQEoy5wjQhy+8awdaJahqGbHA8ZUOM4GdkwxgCXUiHAxnAY1is0XDqbvuAPCDACRg/UvU6rJU4tC8E0XAlbfUptwV5JKofSdWMZteVpw1Xcb+9whuc+IRa15VCpnzs8f/M+VCsKN1XPdZiPEFHwNbuP1S3ev/akMKosH2Bwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707441063; c=relaxed/simple;
	bh=m8jaqFLLZioE4iykSxIKQNkJvntbY0TH993z9DAZ/kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nUt3pn24joTc8O8kNboWXiLta3Y1f0oGOuCtlkmxh+9pVzEaSjwqAmN3vO9GjuU798U5Tb8ZwwKSq1ias3NEFPiX6l7N5NZ0mJfpqFVIAUdwNAVi3OBAz93qjdsr9vM7rpZaPFsNOrTDSbNbPB5rDmzriLmm1X8y6ZsZI5k2aqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1xUy9Juk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EE8FlbGK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1xUy9Juk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EE8FlbGK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21A181F7B7;
	Fri,  9 Feb 2024 01:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707441059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/bgz0Ze0YTNVkL4Dmk5Isms01qQohHj+k+5hVPTypA=;
	b=1xUy9JukP+MkAMPZcDSjylDF4cpxpv8yoYVE+iNjp4JxLKfBO3JHzg1+to/bNo/SejHPpH
	EFX21/9PR5IKw5GMD5yNTfhXyaUuIlpa0IhRv0fWfmLojA795ytn1Myk3Dp0iXgjJUnwdN
	cSaj1gzWUCatrNpDZZrcMAytNxJR8Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707441059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/bgz0Ze0YTNVkL4Dmk5Isms01qQohHj+k+5hVPTypA=;
	b=EE8FlbGK92Y/BMK1YeUfUqztIxoZpJ9F2SG6L6GoObX/UtM+y7vWqkpwmHDPOapV1tj4ke
	c43RnMhSJTJUnpAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707441059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/bgz0Ze0YTNVkL4Dmk5Isms01qQohHj+k+5hVPTypA=;
	b=1xUy9JukP+MkAMPZcDSjylDF4cpxpv8yoYVE+iNjp4JxLKfBO3JHzg1+to/bNo/SejHPpH
	EFX21/9PR5IKw5GMD5yNTfhXyaUuIlpa0IhRv0fWfmLojA795ytn1Myk3Dp0iXgjJUnwdN
	cSaj1gzWUCatrNpDZZrcMAytNxJR8Hk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707441059;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/bgz0Ze0YTNVkL4Dmk5Isms01qQohHj+k+5hVPTypA=;
	b=EE8FlbGK92Y/BMK1YeUfUqztIxoZpJ9F2SG6L6GoObX/UtM+y7vWqkpwmHDPOapV1tj4ke
	c43RnMhSJTJUnpAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00A791326D;
	Fri,  9 Feb 2024 01:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id B2pLO6J7xWXmFQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 09 Feb 2024 01:10:58 +0000
Date: Fri, 9 Feb 2024 02:10:28 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	Qu Wenruo <quwenruo.btrfs@gmx.com>,
	=?utf-8?B?6Z+p5LqO5oOf?= <hrx@bupt.moe>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [btrfs] RAID1 volume on zoned device oops when sync.
Message-ID: <20240209011028.GX355@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1ACD2E3643008A17+da260584-2c7f-432a-9e22-9d390aae84cc@bupt.moe>
 <20240202121948.GA31555@twin.jikos.cz>
 <31227849DBCDBD08+64f08a94-b288-4797-b2a1-be06223c25d9@bupt.moe>
 <20240203221545.GB355@twin.jikos.cz>
 <C4754294EA02D5C7+15158e38-2647-4af8-beca-b09216be42b5@bupt.moe>
 <ae491a34-8879-4791-8a51-4c6f20838deb@gmx.com>
 <6F6264A5C0D133BB+074eb3c4-737b-410d-8d69-23ce2b92d5bc@bupt.moe>
 <66540683-cf08-4e4c-a8be-1c68ac4ea599@gmx.com>
 <cf12dca9-e38e-4ec7-b4f2-70e8a9879f53@wdc.com>
 <7ff2a6f5-9881-4224-a49e-cbba816a60a8@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ff2a6f5-9881-4224-a49e-cbba816a60a8@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.80 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[wdc.com,gmx.com,bupt.moe,vger.kernel.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Fri, Feb 09, 2024 at 06:45:10AM +1030, Qu Wenruo wrote:
> 
> 
> On 2024/2/8 23:12, Johannes Thumshirn wrote:
> > On 05.02.24 08:56, Qu Wenruo wrote:
> >>>
> >>>    > ./nullb setup
> >>>    > ./nullb create -s 4096 -z 256
> >>>    > ./nullb create -s 4096 -z 256
> >>>    > ./nullb ls
> >>>    > mkfs.btrfs -s 16k /dev/nullb0
> >>>    > mount /dev/nullb0 /mnt/tmp
> >>>    > btrfs device add /dev/nullb1 /mnt/tmp
> >>>    > btrfs balance start -dconvert=raid1 -mconvert=raid1 /mnt/tmp
> >>
> >> Just want to be sure, for your case, you're doing the same mkfs (4K
> >> sectorsize) on the physical disk, then add a new disk, and finally
> >> balanced the fs?
> >>
> >> IIRC the balance itself should not succeed, no matter if it's emulated
> >> or real disks, as data RAID1 requires zoned RST support.
> > 
> > For me, balance doesn't accept RAID on zoned devices, as it's supposed
> > to do:
> > 
> > [  212.721872] BTRFS info (device nvme1n1): host-managed zoned block
> > device /dev/nvme2n1, 160 zones of 134217728 bytes
> > [  212.725694] BTRFS info (device nvme1n1): disk added /dev/nvme2n1
> > [  212.744807] BTRFS warning (device nvme1n1): balance: metadata profile
> > dup has lower redundancy than data profile raid1
> > [  212.748706] BTRFS info (device nvme1n1): balance: start -dconvert=raid1
> > [  212.750006] BTRFS error (device nvme1n1): zoned: data raid1 needs
> > raid-stripe-tree
> > [  212.751267] BTRFS info (device nvme1n1): balance: ended with status: -22
> > 
> > So I'm not exactly sure what's happening here.
> 
> I have the access to that machine, and it doesn't reject the convert as 
> expected:
> 
> $ sudo mkfs.btrfs -f /dev/sdb
> btrfs-progs v6.6.2
> See https://btrfs.readthedocs.io for more information.
> 
> Zoned: /dev/sdb: host-managed device detected, setting zoned feature
> WARNING: libblkid < 2.38 does not support zoned mode's superblock 
> location, update recommended
> Resetting device zones /dev/sdb (52156 zones) ...
> NOTE: several default settings have changed in version 5.15, please make 
> sure
>        this does not affect your deployments:
>        - DUP for metadata (-m dup)
>        - enabled no-holes (-O no-holes)
>        - enabled free-space-tree (-R free-space-tree)
> 
> Label:              (null)
> UUID:               e49c5f73-35dd-4faa-8660-dd0b3d02e978
> Node size:          16384
> Sector size:        16384	<<< Not yet subpage.
> Filesystem size:    12.73TiB
> Block group profiles:
>    Data:             single          256.00MiB
>    Metadata:         DUP             256.00MiB
>    System:           DUP             256.00MiB
> SSD detected:       no
> Zoned device:       yes
>    Zone size:        256.00MiB
> Incompat features:  extref, skinny-metadata, no-holes, free-space-tree, 
> zoned
> Runtime features:   free-space-tree
> Checksum:           crc32c
> Number of devices:  1
> Devices:
>     ID        SIZE  ZONES  PATH
>      1    12.73TiB  52156  /dev/sdb
> 
> $ sudo mount /dev/sdb /mnt/btrfs
> $ sudo btrfs dev add /dev/sdc -f /mnt/btrfs/
> Resetting device zones /dev/sdc (52156 zones) ...
> 
> $ dmesg
> [146422.722707] BTRFS: device fsid e49c5f73-35dd-4faa-8660-dd0b3d02e978 
> devid 1 transid 6 /dev/sdb scanned by mount (4172)
> [146422.736415] BTRFS info (device sdb): first mount of filesystem 
> e49c5f73-35dd-4faa-8660-dd0b3d02e978
> [146422.745508] BTRFS info (device sdb): using crc32c (crc32c-generic) 
> checksum algorithm
> [146422.753388] BTRFS info (device sdb): using free-space-tree
> [146423.313000] BTRFS info (device sdb): host-managed zoned block device 
> /dev/sdb, 52156 zones of 268435456 bytes
> [146423.322954] BTRFS info (device sdb): zoned mode enabled with zone 
> size 268435456
> [146423.330808] BTRFS info (device sdb): checking UUID tree
> [146446.313055] BTRFS info (device sdb): host-managed zoned block device 
> /dev/sdc, 52156 zones of 268435456 bytes
> [146446.345735] BTRFS info (device sdb): disk added /dev/sdc
> 
> $ sudo dmesg -C
> $ sudo btrfs balance start -mconvert=raid1 -dconvert=raid1 /mnt/btrfs/
> Done, had to relocate 3 out of 3 chunks
> 
> $ sudo dmesg
> [146533.890423] BTRFS info (device sdb): balance: start -dconvert=raid1 
> -mconvert=raid1 -sconvert=raid1

Here I'd expect a message like "cannot convert to raid1 because for
zoned RST is needed"

> [146533.899668] BTRFS info (device sdb): relocating block group 
> 1610612736 flags metadata|dup

but relocation starts anyway.

> [146533.992730] BTRFS info (device sdb): found 3 extents, stage: move 
> data extents
> [146534.126812] BTRFS info (device sdb): relocating block group 
> 1342177280 flags system|dup
> [146534.252836] BTRFS info (device sdb): relocating block group 
> 1073741824 flags data
> [146534.428593] BTRFS info (device sdb): balance: ended with status: 0

