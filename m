Return-Path: <linux-btrfs+bounces-1953-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E28437DC
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 08:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E9B1F28C79
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jan 2024 07:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC82564CE6;
	Wed, 31 Jan 2024 07:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l55FOPQA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wD8kzxrk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="l55FOPQA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wD8kzxrk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDD063139
	for <linux-btrfs@vger.kernel.org>; Wed, 31 Jan 2024 07:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706685826; cv=none; b=EMLmrY8WEbTRY2lW/McM3EYIngcfpVNAteql4hNwyeawFNjjniAEtyjGK0cmcyqvVfRwTdcgP2BO2BwT5x2sAvD9fF2nPkFMk9tUrDoAdxejfZwqE2CyMQKFWQ0BAWaMuqmDsAJ/KYZjPOlrAcN5vnTgNaBKSgpzQU6gSpR0AgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706685826; c=relaxed/simple;
	bh=2BzgnCL8yerPF71k7wZvO8urOOzm8a+5KTBs5SjGduM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NotKXXzvIRMt+Qs5ocj7nJbsJcz8q+FVc4oMiG+xDEKcS5+vSS0rUE4U3dshMrz8/dKxDVxfjSFvPznHgadv04Ipn0HDCYGAkSOxRjXLG5A4syeZtY6Szx8Hpl+Gnh+DZf8ubMFKrTcbvhsYV5+5MdjalCO8N3GI7My8wDxLYf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l55FOPQA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wD8kzxrk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=l55FOPQA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wD8kzxrk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2ECFF21BCC;
	Wed, 31 Jan 2024 07:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706685822;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CP6OD56n6A1/HvNpAtT6/nkMeHBtDGpSNvMOQ6XDwTI=;
	b=l55FOPQAsXqMDBu6oDaREG184SEBvw46kLDwKK1D8wnZOCugA5XBIHfj/ed4tD/BCTZhP4
	Q4gijrfru5p/myrM/cplWOIbCq3N6OedVbt89++l8Exduxy3XC/8Eit/Af8BekCug0as1+
	Dh0pPrVhUvZAPiQ8DTy/u7ajc6VOKP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706685822;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CP6OD56n6A1/HvNpAtT6/nkMeHBtDGpSNvMOQ6XDwTI=;
	b=wD8kzxrkfF1T04uAEAt2Cc4OpUIOthEHKBPQmZw3HBDEm1qk/hme4cZ12KApMpp2yF6sxL
	u0oSvo9x+ERECYBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706685822;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CP6OD56n6A1/HvNpAtT6/nkMeHBtDGpSNvMOQ6XDwTI=;
	b=l55FOPQAsXqMDBu6oDaREG184SEBvw46kLDwKK1D8wnZOCugA5XBIHfj/ed4tD/BCTZhP4
	Q4gijrfru5p/myrM/cplWOIbCq3N6OedVbt89++l8Exduxy3XC/8Eit/Af8BekCug0as1+
	Dh0pPrVhUvZAPiQ8DTy/u7ajc6VOKP0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706685822;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CP6OD56n6A1/HvNpAtT6/nkMeHBtDGpSNvMOQ6XDwTI=;
	b=wD8kzxrkfF1T04uAEAt2Cc4OpUIOthEHKBPQmZw3HBDEm1qk/hme4cZ12KApMpp2yF6sxL
	u0oSvo9x+ERECYBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 185BB132FA;
	Wed, 31 Jan 2024 07:23:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id c4V3BX71uWXXCgAAn2gu4w
	(envelope-from <dsterba@suse.cz>); Wed, 31 Jan 2024 07:23:42 +0000
Date: Wed, 31 Jan 2024 08:23:08 +0100
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.com>
Cc: linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode
 pointer
Message-ID: <20240131072308.GJ31555@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1706553080.git.dsterba@suse.com>
 <edd12dabd0ce57ba84a4c2b82c51becd64fd7a6f.1706553080.git.dsterba@suse.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <edd12dabd0ce57ba84a4c2b82c51becd64fd7a6f.1706553080.git.dsterba@suse.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=l55FOPQA;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wD8kzxrk
X-Spamd-Result: default: False [-0.01 / 50.00];
	 HAS_REPLYTO(0.30)[dsterba@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 REPLYTO_ADDR_EQ_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 RCPT_COUNT_TWO(0.00)[2];
	 MX_GOOD(-0.01)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.00)[29.23%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[opensuse.org:url,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -0.01
X-Rspamd-Queue-Id: 2ECFF21BCC
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Bar: /

On Mon, Jan 29, 2024 at 07:33:18PM +0100, David Sterba wrote:
> @@ -5211,7 +5211,7 @@ static struct btrfs_trans_handle *evict_refill_and_join(struct btrfs_root *root,
>  
>  void btrfs_evict_inode(struct inode *inode)
>  {
> -	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
> +	struct btrfs_fs_info *fs_info = inode_to_fs_info(inode);

This leads to a crash in btrfs/232, happened twice:

  BUG: KASAN: null-ptr-deref in btrfs_evict_inode+0xac/0x6b0 [btrfs]
  BUG: kernel NULL pointer dereference, address: 0000000000000208
  Read of size 8 at addr 0000000000000208 by task fsstress/21264
  #PF: supervisor read access in kernel mode
  
  CPU: 3 PID: 21264 Comm: fsstress Not tainted 6.8.0-rc2-default+ #2288
  #PF: error_code(0x0000) - not-present page
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  PGD 683f8067 
  Call Trace:
  P4D 683f8067 
   <TASK>
   dump_stack_lvl+0x46/0x70
   kasan_report+0x123/0x150
   ? btrfs_evict_inode+0xac/0x6b0 [btrfs]
   ? btrfs_evict_inode+0xac/0x6b0 [btrfs]
   btrfs_evict_inode+0xac/0x6b0 [btrfs]
   ? local_clock_noinstr+0x11/0xc0
   ? btrfs_rmdir+0x380/0x380 [btrfs]
   ? reacquire_held_locks+0x280/0x280
   ? wake_up_var+0x120/0x120
   evict+0x17f/0x2d0
  
   btrfs_create_common+0xe4/0x1c0 [btrfs]
   ? btrfs_tmpfile+0x2b0/0x2b0 [btrfs]
   ? init_special_inode+0xb9/0xe0
   vfs_mknod+0x25c/0x320
   do_mknodat+0x2fd/0x360
   ? kern_path_create+0x50/0x50
   ? getname_flags+0xb5/0x220
   __x64_sys_mknodat+0x5d/0x70
   do_syscall_64+0x6f/0x140
   entry_SYSCALL_64_after_hwframe+0x46/0x4e

The new macro does BTRFS_I(inode)->root->fs_info while the old one uses
fs_info in the super block. From the context I don't see why a root
pointer would be NULL or how would anyone see that right away and not
introduce such crashes by using the helpers.

