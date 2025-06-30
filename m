Return-Path: <linux-btrfs+bounces-15118-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF55AEE4E1
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 18:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE90817AB69
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Jun 2025 16:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E783428F958;
	Mon, 30 Jun 2025 16:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z9hzxuPz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HEC0BMn1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z9hzxuPz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HEC0BMn1"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6304A28DB76
	for <linux-btrfs@vger.kernel.org>; Mon, 30 Jun 2025 16:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751301813; cv=none; b=I/bSJVVkWmTPcoUQaxYb882RNWBU+y5y9IPsIbReRFDbQPboAzkr1C7/hAB/VgOeVfzDy4q98LaJvg/XgHj5rgokLBUsAbx7D4+E5IWdvP7Iy+UpGY5X2ophE7e1oTuG/n/A7MZ3TKNCu1xlytbBBEO12y047y7S9eXvKFg3TAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751301813; c=relaxed/simple;
	bh=NgS75co3vLMNEEra09wzGKAuLjEhOmFOtx5heyxWbgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv3os0Ea9Wj7huFSwr8uTkKRN6tAKDq8Mz9p8s0pl3vo2aSUgUKQYL6aK6Z0PGjb0NzTCzGvIRC3UTuLAANCZJjXt5yjigSW1UyYAuzQCBf6ESvMDQr8UJWmqwq1iV+D+5z0TYkOZB7lb5mhxiQsr5I8+wEPcIvowZ0OqAkyFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z9hzxuPz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HEC0BMn1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z9hzxuPz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HEC0BMn1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9973D1F445;
	Mon, 30 Jun 2025 16:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751301809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IsrnDI+9htVYkLaIhxIpZHVYEUQeXM4RXD6N1+/QN+Q=;
	b=z9hzxuPzquzLMSIxxho1egQ0mtli2b6eY4hHpGcCr7lcqtWKkvKe4xQt80RrSJYD9X8U/U
	b42DxVF3u4obZ6vN2crBOeP03LUJC5OfeQNkdr4eQO6YrIFpA4OMTpGTypRPTvddPqhDtx
	y+qW+Fm9oDECogc5h2eYwVb8KFBLKm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751301809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IsrnDI+9htVYkLaIhxIpZHVYEUQeXM4RXD6N1+/QN+Q=;
	b=HEC0BMn1v8+BZHQ/YPc0JNazLsTVqnaMN4OTcf7B8CBzxFVGEWdQ7BZrGyH5TJ21DuBc7/
	rjQfK0HyGSax+dDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1751301809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IsrnDI+9htVYkLaIhxIpZHVYEUQeXM4RXD6N1+/QN+Q=;
	b=z9hzxuPzquzLMSIxxho1egQ0mtli2b6eY4hHpGcCr7lcqtWKkvKe4xQt80RrSJYD9X8U/U
	b42DxVF3u4obZ6vN2crBOeP03LUJC5OfeQNkdr4eQO6YrIFpA4OMTpGTypRPTvddPqhDtx
	y+qW+Fm9oDECogc5h2eYwVb8KFBLKm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1751301809;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IsrnDI+9htVYkLaIhxIpZHVYEUQeXM4RXD6N1+/QN+Q=;
	b=HEC0BMn1v8+BZHQ/YPc0JNazLsTVqnaMN4OTcf7B8CBzxFVGEWdQ7BZrGyH5TJ21DuBc7/
	rjQfK0HyGSax+dDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D32A13983;
	Mon, 30 Jun 2025 16:43:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id icBgHrG+YmhUHQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 30 Jun 2025 16:43:29 +0000
Date: Mon, 30 Jun 2025 18:43:28 +0200
From: David Sterba <dsterba@suse.cz>
To: David Sterba <dsterba@suse.cz>
Cc: Wang Yugui <wangyugui@e16-tech.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2 1/2] btrfs: open code RCU for device name
Message-ID: <20250630164328.GL31241@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1750858539.git.dsterba@suse.com>
 <1e539dfd73debc86ddc7c1b1716f86ace14d51aa.1750858539.git.dsterba@suse.com>
 <20250630102457.BFB9.409509F4@e16-tech.com>
 <20250630162130.GK31241@twin.jikos.cz>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630162130.GK31241@twin.jikos.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Flag: NO
X-Spam-Score: 1.00
X-Spam-Level: *
X-Spamd-Result: default: False [1.00 / 50.00];
	REPLYTO_EQ_TO_ADDR(5.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,twin.jikos.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[4]

On Mon, Jun 30, 2025 at 06:21:30PM +0200, David Sterba wrote:
> On Mon, Jun 30, 2025 at 10:24:57AM +0800, Wang Yugui wrote:
> > Hi,
> > 
> > > The RCU protected string is only used for a device name, and RCU is used
> > > so we can print the name and eventually synchronize against the rare
> > > device rename in device_list_add().
> > > 
> > > We don't need the whole API just for that. Open code all the helpers and
> > > access to the string itself.
> > > 
> > > Notable change is in device_list_add() when the device name is changed,
> > > which is the only place that can actually happen at the same time as
> > > message prints using the device name under RCU read lock.
> > > 
> > > Previously there was kfree_rcu() which used the embedded rcu_head to
> > > delay freeing the object depending on the RCU mechanism. Now there's
> > > kfree_rcu_mightsleep() which does not need the rcu_head and waits for
> > > the grace period.
> > > 
> > > Sleeping is safe in this context and as this is a rare event it won't
> > > interfere with the rest as it's holding the device_list_mutex.
> > > 
> > > Straightforward changes:
> > > 
> > > - rcu_string_strdup -> kstrdup
> > > - rcu_str_deref -> rcu_dereference
> > > - drop ->str from safe contexts
> > > 
> > > Historical notes:
> > > 
> > > Introduced in 606686eeac45 ("Btrfs: use rcu to protect device->name")
> > > with a vague reference of the potential problem described in
> > > https://lore.kernel.org/all/20120531155304.GF11775@ZenIV.linux.org.uk/ .
> > > 
> > > The RCU protection looks like the easiest and most lightweight way of
> > > protecting the rare event of device rename racing device_list_add()
> > > with a random printk() that uses the device name.
> > > 
> > > Alternatives: a spin lock would require to protect the printk
> > > anyway, a fixed buffer for the name would be eventually wrong in case
> > > the new name is overwritten when being printed, an array switching
> > > pointers and cleaning them up eventually resembles RCU too much.
> > > 
> > > The cleanups up to this patch should hide special case of RCU to the
> > > minimum that only the name needs rcu_dereference(), which can be further
> > > cleaned up to use btrfs_dev_name().
> > > 
> > 
> > There is still rcu warning when 'make  W=1 C=1'
> > 
> > /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21: warning: incorrect type in argument 1 (different address spaces)
> > /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21:    expected void const *objp
> > /usr/hpc-bio/linux-6.12.35/fs/btrfs/volumes.c:405:21:    got char const [noderef] __rcu *name
> > 
> > static void btrfs_free_device(struct btrfs_device *device)
> > {
> >     WARN_ON(!list_empty(&device->post_commit_list));
> >     /* No need to call kfree_rcu(), nothing is reading the device name. */
> > L405:    kfree(device->name);
> > 
> > do we need rcu_dereference here?
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -402,7 +402,7 @@ static void btrfs_free_device(struct btrfs_device *device)
> >  {
> >         WARN_ON(!list_empty(&device->post_commit_list));
> >         /* No need to call kfree_rcu(), nothing is reading the device name. */
> > -       kfree(device->name);
> > +       kfree(rcu_dereference(device->name));
> 
> I got notified by the build bots (not CCed to the mailinglis) about
> this. The dereference is not needed, the comment says why. The checkers
> do not distinguish the context, some of them are safe like when the
> device is being set up and not yet accessible by other processes, and at
> deletion time, like here.
> 
> As we want to keep the __rcu annotation the rcu dereference is the
> easiest workaround.

I can't seem to reproduce the warning with the command, I'm going to apply this
fixup:

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -402,9 +402,17 @@ static struct btrfs_fs_devices *alloc_fs_devices(const u8 *fsid)
 
 static void btrfs_free_device(struct btrfs_device *device)
 {
+       const char *name;
+
        WARN_ON(!list_empty(&device->post_commit_list));
-       /* No need to call kfree_rcu(), nothing is reading the device name. */
-       kfree(device->name);
+       /*
+        * No need to call kfree_rcu() or do RCU lock/unlock, nothing is
+        * reading the device name but the checkers complain.
+        */
+       rcu_read_lock();
+       name = rcu_dereference(device->name);
+       rcu_read_unlock();
+       kfree(name);
        btrfs_extent_io_tree_release(&device->alloc_state);
        btrfs_destroy_dev_zone_info(device);
        kfree(device);

