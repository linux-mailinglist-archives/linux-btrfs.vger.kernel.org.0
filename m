Return-Path: <linux-btrfs+bounces-2071-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59321847064
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 13:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37991F23213
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEAD46433;
	Fri,  2 Feb 2024 12:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cbV0fxos";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GGDRluDj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cbV0fxos";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="GGDRluDj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42E22085
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877103; cv=none; b=Sa2yiNp1hCWThgLCpjWNvERNuktD/AlhUIm7xvZweHLcd+39Ku8WvD8KoKVsarfGbo1I90COb4BeaEJHivKB4Iuzd7ZWK3p7rYRTLYoMNd6unXcgQWEtGFQnVThkOluSXPAjAFWClEKSIn/4tjf07s7muLbKp1tBdL1W/mD49uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877103; c=relaxed/simple;
	bh=ODTqGXhYMBGJgyd/pZGRikhfRCWfgeizIglKvIEjRKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GH2ctkBgMttJKBbEppMoDHtUlC5taCW1owUoahldJJH+5AV68GGhnwQs/Y9H/iToYXTAeF/L+Y5z8MGzFFmRsZiAEnzmJIy1wf/SoF+pwB8jM8Dgsx3++tyZkx9Rj/BY0iZepeT7qBABtF66fyh4XLRY4vMs4DZjMQvGLKUkx8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cbV0fxos; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GGDRluDj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cbV0fxos; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=GGDRluDj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44A3D2212F;
	Fri,  2 Feb 2024 12:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706877099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1Uxhk0w4/cCslbCebBR+VWlbJz385EPfu43u/rGrhQ=;
	b=cbV0fxosufujffKjR7sPZdkOiQFvhUkwRHdRRClho4MPEMOieU9zSgPM8A+QAvx6G0qj6/
	K9S0vOk3ZJVoyZdPaV5dGLW1X8HOLM8wRgknSAPMNXS6uOY/ofZE629VmyFPv621O5cMEj
	00/rZAckznxAPIFlxhnq0UvQje6L+QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706877099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1Uxhk0w4/cCslbCebBR+VWlbJz385EPfu43u/rGrhQ=;
	b=GGDRluDjWBXCNy3QT0y2ikr15qKQJQo8xFRl8aXktIIgxi+P/IwSXRud19wbCRodONHGKc
	5qLGRs2t/2cHLCAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706877099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1Uxhk0w4/cCslbCebBR+VWlbJz385EPfu43u/rGrhQ=;
	b=cbV0fxosufujffKjR7sPZdkOiQFvhUkwRHdRRClho4MPEMOieU9zSgPM8A+QAvx6G0qj6/
	K9S0vOk3ZJVoyZdPaV5dGLW1X8HOLM8wRgknSAPMNXS6uOY/ofZE629VmyFPv621O5cMEj
	00/rZAckznxAPIFlxhnq0UvQje6L+QY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706877099;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D1Uxhk0w4/cCslbCebBR+VWlbJz385EPfu43u/rGrhQ=;
	b=GGDRluDjWBXCNy3QT0y2ikr15qKQJQo8xFRl8aXktIIgxi+P/IwSXRud19wbCRodONHGKc
	5qLGRs2t/2cHLCAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 19E12133DC;
	Fri,  2 Feb 2024 12:31:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id s6jNBavgvGWzOQAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 02 Feb 2024 12:31:39 +0000
Date: Fri, 2 Feb 2024 13:31:12 +0100
From: David Sterba <dsterba@suse.cz>
To: fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] btrfs: preallocate temporary extent buffer for inode
 logging when needed
Message-ID: <20240202123112.GB31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <1ef0997eee1fbe194ab2546f34052cd4e27c6ef4.1706612525.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef0997eee1fbe194ab2546f34052cd4e27c6ef4.1706612525.git.fdmanana@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cbV0fxos;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=GGDRluDj
X-Spamd-Result: default: False [-4.51 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 44A3D2212F
X-Spam-Level: 
X-Spam-Score: -4.51
X-Spam-Flag: NO

On Tue, Jan 30, 2024 at 11:05:44AM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> When logging an inode and we require to copy items from subvolume leaves
> to the log tree, we clone each subvolume leaf and than use that clone to
> copy items to the log tree. This is required to avoid possible deadlocks
> as stated in commit 796787c978ef ("btrfs: do not modify log tree while
> holding a leaf from fs tree locked").
> 
> The cloning requires allocating an extent buffer (struct extent_buffer)
> and then allocating pages (folios) to attach to the extent buffer. This
> may be slow in case we are under memory pressure, and since we are doing
> the cloning while holding a read lock on a subvolume leaf, it means we
> can be blocking other operations on that leaf for significant periods of
> time, which can increase latency on operations like creating other files,
> renaming files, etc. Similarly because we're under a log transaction, we
> may also cause extra delay on other tasks doing an fsync, because syncing
> the log requires waiting for tasks that joined a log transaction to exit
> the transaction.
> 
> So to improve this, for any inode logging operation that needs to copy
> items from a subvolume leaf ("full sync" or "copy everything" bit set
> in the inode), preallocate a dummy extent buffer before locking any
> extent buffer from the subvolume tree, and even before joining a log
> transaction, add it to the log context and then use it when we need to
> copy items from a subvolume leaf to the log tree. This avoids making
> other operations get extra latency when waiting to lock a subvolume
> leaf that is used during inode logging and we are under heavy memory
> pressure.
> 
> The following test script with bonnie++ was used to test this:
> 
>   $ cat test.sh
>   #!/bin/bash
> 
>   DEV=/dev/sdh
>   MNT=/mnt/sdh
>   MOUNT_OPTIONS="-o ssd"
> 
>   MEMTOTAL_BYTES=`free -b | grep Mem: | awk '{ print $2 }'`
>   NR_DIRECTORIES=20
>   NR_FILES=20480
>   DATASET_SIZE=$((MEMTOTAL_BYTES * 2 / 1048576))
>   DIRECTORY_SIZE=$((MEMTOTAL_BYTES * 2 / NR_FILES))
>   NR_FILES=$((NR_FILES / 1024))
> 
>   echo "performance" | \
>       tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
> 
>   umount $DEV &> /dev/null
>   mkfs.btrfs -f $MKFS_OPTIONS $DEV
>   mount $MOUNT_OPTIONS $DEV $MNT
> 
>   bonnie++ -u root -d $MNT \
>       -n $NR_FILES:$DIRECTORY_SIZE:$DIRECTORY_SIZE:$NR_DIRECTORIES \
>       -r 0 -s $DATASET_SIZE -b
> 
>   umount $MNT
> 
> The results of this test on a 8G VM running a non-debug kernel (Debian's
> default kernel config), were the following.
> 
> Before this change:
> 
>   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
>                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
>   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>   debian0       7501M  376k  99  1.4g  96  117m  14 1510k  99  2.5g  95 +++++ +++
>   Latency             35068us   24976us    2944ms   30725us   71770us   26152us
>   Version 2.00a       ------Sequential Create------ --------Random Create--------
>   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>   20:384100:384100/20 20480  32 20480  58 20480  48 20480  39 20480  56 20480  61
>   Latency               411ms   11914us     119ms     617ms   10296us     110ms
> 
> After this change:
> 
>   Version 2.00a       ------Sequential Output------ --Sequential Input- --Random-
>                       -Per Chr- --Block-- -Rewrite- -Per Chr- --Block-- --Seeks--
>   Name:Size etc        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>   debian0       7501M  375k  99  1.4g  97  117m  14 1546k  99  2.3g  98 +++++ +++
>   Latency             35975us  20945us    2144ms   10297us    2217us    6004us
>   Version 2.00a       ------Sequential Create------ --------Random Create--------
>   debian0             -Create-- --Read--- -Delete-- -Create-- --Read--- -Delete--
>   files:max:min        /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP  /sec %CP
>   20:384100:384100/20 20480  35 20480  58 20480  48 20480  40 20480  57 20480  59
>   Latency               320ms   11237us   77779us     518ms    6470us   86389us
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

