Return-Path: <linux-btrfs+bounces-1325-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F94C8289DA
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 17:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81E8A1C246B6
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Jan 2024 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482153A1CA;
	Tue,  9 Jan 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NZ6oEdoC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKI6JGKh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NZ6oEdoC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sKI6JGKh"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8819E3A1C0
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Jan 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C9A21F7FE;
	Tue,  9 Jan 2024 16:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704817173;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xLrPVNE9HPo9kT8Lwyr89aCgPMfTyjt+IPZ1Rs+0Gw=;
	b=NZ6oEdoCyUML3+dQO8nmGRVvuW76esVHUFgNVfhXU1oe9ryKmEIiNWtSF2nOfqfpcTINWj
	Es9Kz+aIqGbGE8DuAlzndo4W6km5k0giuPdIRJ3QscU4BBxykcf1zIzFeJvL0MJ91nJV+R
	R0c5g2F2p/cQUthrijfUywLzdzP6JFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704817173;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xLrPVNE9HPo9kT8Lwyr89aCgPMfTyjt+IPZ1Rs+0Gw=;
	b=sKI6JGKhTijaJKZGmXBY7XToG3q06j4gG7P7XVJoKYv5xC2roXBqQ7Sd2+cMavHdfL9ZQB
	cL5k4xBazoW83+Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704817173;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xLrPVNE9HPo9kT8Lwyr89aCgPMfTyjt+IPZ1Rs+0Gw=;
	b=NZ6oEdoCyUML3+dQO8nmGRVvuW76esVHUFgNVfhXU1oe9ryKmEIiNWtSF2nOfqfpcTINWj
	Es9Kz+aIqGbGE8DuAlzndo4W6km5k0giuPdIRJ3QscU4BBxykcf1zIzFeJvL0MJ91nJV+R
	R0c5g2F2p/cQUthrijfUywLzdzP6JFY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704817173;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4xLrPVNE9HPo9kT8Lwyr89aCgPMfTyjt+IPZ1Rs+0Gw=;
	b=sKI6JGKhTijaJKZGmXBY7XToG3q06j4gG7P7XVJoKYv5xC2roXBqQ7Sd2+cMavHdfL9ZQB
	cL5k4xBazoW83+Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 636BF134E8;
	Tue,  9 Jan 2024 16:19:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8IQaGBVynWXacAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 09 Jan 2024 16:19:33 +0000
Date: Tue, 9 Jan 2024 17:19:15 +0100
From: David Sterba <dsterba@suse.cz>
To: Anand Jain <anand.jain@oracle.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] btrfs-progs: Documentation: fix sphinx code-block
 warning
Message-ID: <20240109161915.GJ28693@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1704438755.git.anand.jain@oracle.com>
 <b5e7aa00820d6fcc680b201070f81e3178571dea.1704438755.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5e7aa00820d6fcc680b201070f81e3178571dea.1704438755.git.anand.jain@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: **
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NZ6oEdoC;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sKI6JGKh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.29 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 0.29
X-Rspamd-Queue-Id: 7C9A21F7FE
X-Spam-Flag: NO

On Mon, Jan 08, 2024 at 04:31:07PM +0800, Anand Jain wrote:
> diff --git a/Documentation/Tree-checker.rst b/Documentation/Tree-checker.rst
> index 68df6fdfa0de..c0e5e316d958 100644
> --- a/Documentation/Tree-checker.rst
> +++ b/Documentation/Tree-checker.rst
> @@ -30,7 +30,7 @@ fine.
>  
>  A message may look like:
>  
> -.. code-block::
> +.. code-block:: text

No syntax hilighting is specified as 'none' elsewhere, so I'd change
that to be consistent.

>  
>     [ 1716.823895] BTRFS critical (device vdb): corrupt leaf: root=18446744073709551607 block=38092800 slot=0, invalid key objectid: has 1 expect 6 or [256, 18446744073709551360] or 18446744073709551604
>     [ 1716.829499] BTRFS info (device vdb): leaf 38092800 gen 19 total ptrs 4 free space 15851 owner 18446744073709551607
> @@ -54,7 +54,7 @@ checksum is found to be valid. This protects against changes to the metadata
>  that could possibly also update the checksum, less likely to happen accidentally
>  but rather due to intentional corruption or fuzzing.
>  
> -.. code-block::
> +.. code-block:: text
>  
>     [ 4823.612832] BTRFS critical (device vdb): corrupt leaf: root=7 block=30474240 slot=0, invalid nritems, have 0 should not be 0 for non-root leaf
>     [ 4823.616798] BTRFS error (device vdb): block=30474240 read time tree block corruption detected
> diff --git a/Documentation/ch-subvolume-intro.rst b/Documentation/ch-subvolume-intro.rst
> index 57b42fe7a97f..3a138f221cc6 100644
> --- a/Documentation/ch-subvolume-intro.rst
> +++ b/Documentation/ch-subvolume-intro.rst
> @@ -3,7 +3,7 @@ file/directory hierarchy and inode number namespace. Subvolumes can share file
>  extents. A snapshot is also subvolume, but with a given initial content of the
>  original subvolume. A subvolume has always inode number 256.
>  
> -.. note::
> +.. note:: text

Does note really need the paramter? You've added 4 but there are 70+ in
the whole documentation so that would need fixing them all (or none).

>     A subvolume in BTRFS is not like an LVM logical volume, which is block-level
>     snapshot while BTRFS subvolumes are file extent-based.
>  
> @@ -34,7 +34,7 @@ Subvolumes can be given capacity limits, through the qgroups/quota facility, but
>  otherwise share the single storage pool of the whole btrfs filesystem. They may
>  even share data between themselves (through deduplication or snapshotting).
>  
> -.. note::
> +.. note:: text
>      A snapshot is not a backup: snapshots work by use of BTRFS' copy-on-write
>      behaviour. A snapshot and the original it was taken from initially share all
>      of the same data blocks. If that data is damaged in some way (cosmic rays,
> @@ -68,7 +68,7 @@ change and could potentially break the incremental send use case, performing
>  it by :ref:`btrfs property set<man-property-set>` requires force if that is
>  really desired by user.
>  
> -.. note::
> +.. note:: text
>     The safety checks have been implemented in 5.14.2, any subvolumes previously
>     received (with a valid *received_uuid*) and read-write status may exist and
>     could still lead to problems with send/receive. You can use :ref:`btrfs subvolume show<man-subvolume-show>`
> @@ -138,7 +138,7 @@ Mounting a read-write snapshot as read-only is possible and will not change the
>  The name of the mounted subvolume is stored in file :file:`/proc/self/mountinfo` in
>  the 4th column:
>  
> -.. code-block::
> +.. code-block:: text
>  
>     27 21 0:19 /subv1 /mnt rw,relatime - btrfs /dev/sda rw,space_cache
>                ^^^^^^
> @@ -151,7 +151,7 @@ then a snapshot is taken, then the cloned directory entry representing the
>  subvolume becomes empty and the inode has number 2. All other files and
>  directories in the target snapshot preserve their original inode numbers.
>  
> -.. note::
> +.. note:: text
>     Inode number is not a filesystem-wide unique identifier, some applications
>     assume that. Please use pair *subvolumeid:inodenumber* for that purpose.
>     The subvolume id can be read by :ref:`btrfs inspect-internal rootid<man-inspect-rootid>`
> diff --git a/Documentation/ch-volume-management-intro.rst b/Documentation/ch-volume-management-intro.rst
> index c93576c72586..15b44c9447b8 100644
> --- a/Documentation/ch-volume-management-intro.rst
> +++ b/Documentation/ch-volume-management-intro.rst
> @@ -27,7 +27,7 @@ RAID level
>          standard RAID levels. At the moment the supported ones are: RAID0, RAID1,
>          RAID10, RAID5 and RAID6.
>  
> -.. _man-device-typical-use-cases:
> +.. _man-device-typical-use-cases: none

This is a label for a reference, I doubt it needs a parameter.

The rest looks ok, thanks.

