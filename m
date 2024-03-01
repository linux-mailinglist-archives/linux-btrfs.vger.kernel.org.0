Return-Path: <linux-btrfs+bounces-2964-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CFA86E0DA
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 13:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F821F24048
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Mar 2024 12:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D5B6D536;
	Fri,  1 Mar 2024 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/u4satZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1YNooUy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/u4satZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1YNooUy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3BD6D1A1;
	Fri,  1 Mar 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709294925; cv=none; b=IPhn05hhD67DzW3ohETeAxnLCqVEzahqyNY4FljzcmGzQ+yN0Tgi+32HkqYXLbX89p8yFkpC51AxrC8bxndM1ZfluGVGIaNtwjr9YTOq0b8Hs//ZtrHooRQ+FxFfRNp3NWs5m939HFaWfOu3RX77riTU5yPikZONk3rIKSFeZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709294925; c=relaxed/simple;
	bh=orc32+uI5+mRb/3dCFQ8K8TCeKWSOPfc2luLPCtkSrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrTGgmI1j09ksirXtIqDny2346eg2B+nBW6S18/licFoBGwnrep4D68qYgjHiMGjeOjl6N54dtBX40vQMyIoIVfBEdie1pAwtdr/SgZ5+mgdq+fhqwqZ1lSbv3gbRNLzd7vgZyKsSfiB9VRSquqb0PNYB0frrYXkeBJLasbMOt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/u4satZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1YNooUy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/u4satZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1YNooUy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 34FE5338BC;
	Fri,  1 Mar 2024 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709294922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYbF9WBe9cyR9dD8QFu7d2TbmL2WiuAvy0rBmNz8f4g=;
	b=c/u4satZKusd9cmeK07TcsuVvMQBvWaYXmzppwg90KhexWHwSUKxtEV3dDkmhtIRXp9d3i
	O2VjllA6rYXS7Op3fwy0v+4jDbQeUl6NQjUhiVGsP7mbul3BikDnkGdwOlvlb/JXc/ZVjq
	u8eD0PeyWopZ+Zg2JEgQyMBazVFGi9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709294922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYbF9WBe9cyR9dD8QFu7d2TbmL2WiuAvy0rBmNz8f4g=;
	b=L1YNooUyGJAD9pZ2LYd5bdAZxpwC9ORWhZTMfUULEpmhnTB8DtcOQmrPzF2MRD3cav9K6F
	sxjGT1/vdU5CUZBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1709294922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYbF9WBe9cyR9dD8QFu7d2TbmL2WiuAvy0rBmNz8f4g=;
	b=c/u4satZKusd9cmeK07TcsuVvMQBvWaYXmzppwg90KhexWHwSUKxtEV3dDkmhtIRXp9d3i
	O2VjllA6rYXS7Op3fwy0v+4jDbQeUl6NQjUhiVGsP7mbul3BikDnkGdwOlvlb/JXc/ZVjq
	u8eD0PeyWopZ+Zg2JEgQyMBazVFGi9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1709294922;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZYbF9WBe9cyR9dD8QFu7d2TbmL2WiuAvy0rBmNz8f4g=;
	b=L1YNooUyGJAD9pZ2LYd5bdAZxpwC9ORWhZTMfUULEpmhnTB8DtcOQmrPzF2MRD3cav9K6F
	sxjGT1/vdU5CUZBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 16A8013581;
	Fri,  1 Mar 2024 12:08:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id zhNXBUrF4WVWPwAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Fri, 01 Mar 2024 12:08:42 +0000
Date: Fri, 1 Mar 2024 13:01:38 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] btrfs: qgroup: verify btrfs_qgroup_inherit parameter
Message-ID: <20240301120138.GJ2604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <bde2887da38aaa473ca60801b37ac735b3ab2d6d.1709003728.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bde2887da38aaa473ca60801b37ac735b3ab2d6d.1709003728.git.wqu@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.13 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.33)[90.34%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.13

On Tue, Feb 27, 2024 at 01:45:35PM +1030, Qu Wenruo wrote:
> [BUG]
> Currently btrfs can create subvolume with an invalid qgroup inherit
> without triggering any error:
> 
>  # mkfs.btrfs -O quota -f $dev
>  # mount $dev $mnt
>  # btrfs subvolume create -i 2/0 $mnt/subv1
>  # btrfs qgroup show -prce --sync $mnt
>  Qgroupid    Referenced    Exclusive   Path
>  --------    ----------    ---------   ----
>  0/5           16.00KiB     16.00KiB   <toplevel>
>  0/256         16.00KiB     16.00KiB   subv1
> 
> [CAUSE]
> We only do a very basic size check for btrfs_qgroup_inherit structure,
> but never really verify if the values are correct.
> 
> Thus in btrfs_qgroup_inherit() function, we have to skip non-existing
> qgroups, and never return any error.
> 
> [FIX]
> Fix the behavior and introduce extra checks:
> 
> - Introduce early check for btrfs_qgroup_inherit structure
>   Not only the size, but also all the qgroup ids would be verifyed.
> 
>   And the timing is very early, so we can return error early.
>   This early check is very important for snapshot creation, as snapshot
>   is delayed to transaction commit.
> 
> - Drop support for btrfs_qgroup_inherit::num_ref_copies and
>   num_excl_copies
>   Those two members are used to specify to copy refr/excl numbers from
>   other qgroups.
>   This would definitely mark qgroup inconsistent, and btrfs-progs has
>   dropped the support for them for a long time.
>   It's time to drop the support for kernel.
> 
> - Verify the supported btrfs_qgroup_inherit::flags
>   Just in case we want to add extra flags for btrfs_qgroup_inherit.
> 
> Now above subvolume creation would fail with -ENOENT other than silently
> ignore the non-existing qgroup.
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: David Sterba <dsterba@suse.com>

