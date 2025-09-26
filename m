Return-Path: <linux-btrfs+bounces-17223-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B850BA39D8
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 14:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 209167A48F6
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Sep 2025 12:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF0442EBBB5;
	Fri, 26 Sep 2025 12:29:27 +0000 (UTC)
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8EC10E3
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Sep 2025 12:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758889767; cv=none; b=FLPDRooTMzKHAU2ZHa+ou6Sno0s4EaypIzdRCY8n7AcOQTvCveuc7l9Km6+NRhIebxZmPO4Kfhl9+dWqC/r4IPHgyIbsoSfUQrLSNuATxxGg0DZ/0aRI27VODXpqIQjQgYtUN/Cn+Wz1s1tB0hIytarFb4Ygq+9SWs2Kxmd5YYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758889767; c=relaxed/simple;
	bh=5fYTB3upnkvD7KruJ3IuFIVUYftw1UWkWyBADgim6Js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a82KRcOg+Y8U322+37i8i3yQ9Dz/iphaeLhrk3d2FwfAMJG86W6zuje6iadwT7oci35KmLgPdqcGv0eCac7olwdoBagt0iXoiFb36r32+N2JRl7gyv/hfc/2N7JP+SzmBPt7nnJ71MhwkzdMUDjWXZTdR7l5cTbBQhLFbLLWdYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2A04259EC;
	Fri, 26 Sep 2025 12:29:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFA241373E;
	Fri, 26 Sep 2025 12:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ct5uNiOH1mghRQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Sep 2025 12:29:23 +0000
Date: Fri, 26 Sep 2025 14:29:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, HAN Yuwei <hrx@bupt.moe>
Subject: Re: [PATCH] btrfs: only set the device specific options after
 devices are opened
Message-ID: <20250926122914.GV5333@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <95f198ac033610c66c30312743fbec4869200229.1758862208.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f198ac033610c66c30312743fbec4869200229.1758862208.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: F2A04259EC
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00

On Fri, Sep 26, 2025 at 02:20:11PM +0930, Qu Wenruo wrote:
> [BUG]
> With v6.17-rc kernels, btrfs will always set 'ssd' mount option even if
> the block device is not a rotating one:
> 
>  # cat /sys/block/sdd/queue/rotational
>  1
>  # cat /etc/fstab:
>  LABEL=DATA2     /data2  btrfs rw,relatime,space_cache=v2,subvolid=5,subvol=/,nofail,nosuid,nodev      0 0
> 
>  # mount
>  [...]
>  /dev/sdd on /data2 type btrfs (rw,nosuid,nodev,relatime,ssd,space_cache=v2,subvolid=5,subvol=/)
> 
> [CAUSE]
> The 'ssd' mount option is set by set_device_specific_options(), and it
> expects that if there is any rotating device in the btrfs, it will set
> fs_devices::rotating.
> 
> However after commit bddf57a70781 ("btrfs: delay btrfs_open_devices()
> until super block is created"), the device opening is delayed until the
> super block is created.
> 
> But the timing of set_device_specific_options() is still left as is,
> this makes the function to be called without any device opened.
> 
> Since no device is opened, thus fs_devices::rotating will never be set,
> making btrfs to incorrectly setting 'ssd' mount option.
> 
> [FIX]
> Only call set_device_specific_options() after btrfs_open_devices().
> 
> Also only call set_device_specific_options() after a new mount, if we're
> mounting a mounted btrfs, there is no need to set the device specific
> mount options again.
> 
> Fixes: bddf57a70781 ("btrfs: delay btrfs_open_devices() until super block is created")
> Reported-by: HAN Yuwei <hrx@bupt.moe>
> Link: https://lore.kernel.org/linux-btrfs/C8FF75669DFFC3C5+5f93bf8a-80a0-48a6-81bf-4ec890abc99a@bupt.moe/
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

