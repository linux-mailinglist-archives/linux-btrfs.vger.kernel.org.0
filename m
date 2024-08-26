Return-Path: <linux-btrfs+bounces-7508-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA8895F549
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 17:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C542A28284E
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Aug 2024 15:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C61C1946A8;
	Mon, 26 Aug 2024 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XPbKV1zQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RHQZTVD9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XPbKV1zQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RHQZTVD9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B6F194096;
	Mon, 26 Aug 2024 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686751; cv=none; b=L3PLP36LwKPUPS+pL3cWIEmBeO6STNwcoLn3Z+I6epJnMqcA6caJkT+CDDeOxXq+PPD83OsyWW2QRdvxczc+bcRe0noFZGNfgfEwduHHRyRHTbddXBiVPbEHSTL8Qe8KCFpk59hQugnvs/mlVBODMpHAVfEqLPstHGqdMbLIfmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686751; c=relaxed/simple;
	bh=8Q9mQZsmLs0nnnagjGhXv67IgmVrkxtc1Jufbx9UgGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MT3dvyukCs50FqQekQo3tLDcDlZ3/GMJPxANXCoXQhryjPUjhkqY4WktrQzAYX3fngL+z65GolfRrN8zqV7hKwlXCuv8l9f2MoH6kX0aGmbp6D2YZ1eH/IRtzomB1lYZf2WtJl2+7Ew56JF1F18uQIl6J0ea0zANT21xMDMEcgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XPbKV1zQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RHQZTVD9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XPbKV1zQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RHQZTVD9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 55E211F894;
	Mon, 26 Aug 2024 15:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724686747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7nGSNeI9+toSqot2xIzZRmBlBYQYRWwPcrJTv2ZB4nw=;
	b=XPbKV1zQy6lFOMWmNOK7ZfrSwnHlRAzOda8Ul4PeTTpmsLZqiGfNWij01Q8FBgBAzRVimw
	t9e6cDf1EZ4IbYGKusUui3SwdtlpGWJI4B/PltsXwK56vCsZ5723TOsVW2EvoPqup6x20R
	fgThQERiceElkByCpFA2eKx3oHuYGd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724686747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7nGSNeI9+toSqot2xIzZRmBlBYQYRWwPcrJTv2ZB4nw=;
	b=RHQZTVD9IXXxzvZEaOJ9jgW6JrCVu70avlFPsJBgQISh7PFmqXBbnTXHBsCgnww37whA1o
	chphyN2/dWyeN/BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XPbKV1zQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RHQZTVD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1724686747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7nGSNeI9+toSqot2xIzZRmBlBYQYRWwPcrJTv2ZB4nw=;
	b=XPbKV1zQy6lFOMWmNOK7ZfrSwnHlRAzOda8Ul4PeTTpmsLZqiGfNWij01Q8FBgBAzRVimw
	t9e6cDf1EZ4IbYGKusUui3SwdtlpGWJI4B/PltsXwK56vCsZ5723TOsVW2EvoPqup6x20R
	fgThQERiceElkByCpFA2eKx3oHuYGd4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1724686747;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7nGSNeI9+toSqot2xIzZRmBlBYQYRWwPcrJTv2ZB4nw=;
	b=RHQZTVD9IXXxzvZEaOJ9jgW6JrCVu70avlFPsJBgQISh7PFmqXBbnTXHBsCgnww37whA1o
	chphyN2/dWyeN/BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35EB51398D;
	Mon, 26 Aug 2024 15:39:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1eX0DJuhzGadbgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 26 Aug 2024 15:39:07 +0000
Date: Mon, 26 Aug 2024 17:39:06 +0200
From: David Sterba <dsterba@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: josef@toxicpanda.com, clm@fb.com, dsterba@suse.com,
	linux-btrfs@vger.kernel.org, stable@vger.kernel.org,
	syzbot+67ba3c42bcbb4665d3ad@syzkaller.appspotmail.com
Subject: Re: [PATCH] btrfs: fix the race between umount and btrfs-cleaner
Message-ID: <20240826153906.GR25962@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240821180804.GF1998418@perftesting>
 <20240822124524.1375008-1-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822124524.1375008-1-sunjunchao2870@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 55E211F894
X-Spam-Level: 
X-Spamd-Result: default: False [-2.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[67ba3c42bcbb4665d3ad];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Thu, Aug 22, 2024 at 08:45:24PM +0800, Julian Sun wrote:
> Hi, Josef
> 
> I believe there is a bug in the following scenario, but I'm not sure
> if it is the same bug reported by syzbot. Do you have any idea?
> 
> umount thread:                     btrfs-cleaner thread:
>                                    btrfs_run_delayed_iputs()
>                                      ->run_delayed_iput_locked()
>   btrfs_kill_super()                   ->iput(inode)
>     ->generic_shutdown_super()           ->spin_lock(inode)
>       ->evict_inodes()               	 // inode->i_count dec to 0
>        ->spin_lock(inode)                ->iput_final()
>                                           // cause some reason, get into
>                                           // __inode_add_lru
>        // passed i_count==0 test          ->__inode_add_lru()
>        // and then schedule out		  // so iput_final() returned wich I_FREEING was not set
>                                           // note here: the inode still in the sb list
> 				     ->__btrfs_run_defrag_inode()
> 					    ->btrfs_iget()
>   		                              ->find_inode()
>                                                 ->spin_lock(inode)
>                                                 ->__iget(); // i_count inc to 1
>                                                 ->spin_unlock(inode);
>      // schedule back
>      spin_lock(inode)
>      // I_FREEING was not set
>      // so we continue
>      set I_FREEING flag
>      spin_unlock(inode)                   ->iput() 
>      // put the inode into dispose          ->spin_lock(inode)
>      // list                                    // dec i_count to 0
>   ->dispose_list()                          ->iput_final()
>     ->evict()                                 ->spin_unlock()
>                                               ->evict()
>                                               
> Now, we have two threads simultaneously evicting
> the same inode, which led to a bug.
> I think this can be addressed by protecting the 
> atomic_read(inode->i_count) in evict_inode() with
> inode->i_lock.

For reference, this will be fixed in VFS

https://lore.kernel.org/linux-btrfs/20240823130730.658881-1-sunjunchao2870@gmail.com/

