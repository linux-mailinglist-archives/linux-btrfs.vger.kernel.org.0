Return-Path: <linux-btrfs+bounces-15473-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0C6B0245E
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 21:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0605C0BD0
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Jul 2025 19:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272431D63E8;
	Fri, 11 Jul 2025 19:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RQ0WbfzW";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6mTRFfqZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YSQ+svsj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NF3Ilm2n"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541CB2AEF1
	for <linux-btrfs@vger.kernel.org>; Fri, 11 Jul 2025 19:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752261334; cv=none; b=FzJlRsVoHU4JPnKOgsDUdWmvma9I3SuS/HGCUotvqQsfVcMcOMfaxvxdbcTtoA608P6uSUJfGAb4u1oE0hJS0S32N6vAcDm9uNH+VKkwkLOmFP4LcBrsEoWLU0bHGkq9BCL9Z49cQGPO+OujpTq56SqRfrVZsPqKgSSF4NiFyqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752261334; c=relaxed/simple;
	bh=vGBrCMspDW+ZLcVL1csQ3SnbZNzkPqI4sjsi/bAe0sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMsTbLKSHv+cQoyOUhbSWdcy15eQ9CCdq1DfOdsTRMv3gvbwBM767lpkWUsASH427fEkN3E4sMu91VFX7dqzS4r+amgErTI8oEtMKRM9By1m8r36UqUvEBdFoQuBAOVbXmxiU3l1I2tIaUQ5MskXbT9tJhUZJ7TCwrKhMZaRlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RQ0WbfzW; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6mTRFfqZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YSQ+svsj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NF3Ilm2n; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80FF7211E8;
	Fri, 11 Jul 2025 19:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752261328;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArtqfFFSS5lfhsSnBBi/KScC/w8rUGc66k55fXWi/Us=;
	b=RQ0WbfzWhqdc1oBye6sOVvU/g7HB7tu3ZEgk0kAd8jXRg62K1TY2Pvw5/tqHxm1CJHfQQ9
	dHoGrGElIv68iN4USuncRGLI6YFoCgYIPq1tCJQpP2qg87VMp6rW1s/9s3kU6HgYSyIotN
	wz5cvbOfcNy6kUBnRir9XD5E8Q7rSxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752261328;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArtqfFFSS5lfhsSnBBi/KScC/w8rUGc66k55fXWi/Us=;
	b=6mTRFfqZGqv33OrgQxbVzA8jkXcMISe9dpzwlvqCBKZsrczHUoXahfenZOtaKE6ggx+u5m
	0EwM4yl8QremxtCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YSQ+svsj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NF3Ilm2n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752261327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArtqfFFSS5lfhsSnBBi/KScC/w8rUGc66k55fXWi/Us=;
	b=YSQ+svsjT7jwhR9I0nuaImgmbKUyeZvO79LiUXj7APHZgLq99B6vg7l5srv+AWu0F9+ns2
	CbNn7x5a38GOqf5kMion6CUYJtdmf48ZhmOeZwuf3Z56e+XgIPpsJxtIH5ku1tZVgEWYtK
	pIHc3m6zl5r3hKxmXX4ac0hcv2pYXtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752261327;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArtqfFFSS5lfhsSnBBi/KScC/w8rUGc66k55fXWi/Us=;
	b=NF3Ilm2nEULyGb7Dgv3376tQU5Bv/8HOMXYNeszItDSX4sABXpBCFvaBgcmWy+WWfT9n4T
	H2lr0vt6HxRKd1AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16F4F138A5;
	Fri, 11 Jul 2025 19:15:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sUHEA89icWjtJQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 11 Jul 2025 19:15:27 +0000
Date: Fri, 11 Jul 2025 21:15:21 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
	wqu@suse.com
Subject: Re: [PATCH] btrfs: scrub: wip, pause on fs freeze
Message-ID: <20250711191521.GF22472@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20250708132540.28285-1-dsterba@suse.com>
 <72fe27cf-b912-4459-bae6-074dd86e843b@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <72fe27cf-b912-4459-bae6-074dd86e843b@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 80FF7211E8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:replyto]
X-Spam-Score: -4.21

On Wed, Jul 09, 2025 at 07:33:56AM +0930, Qu Wenruo wrote:
> 
> 
> 在 2025/7/8 22:55, David Sterba 写道:
> > Implement sb->freeze_super that can instruct our threads to pause
> > themselves. In case of (read-write) scrub this means to undo
> > mnt_want_write, implemented as sb_start_write()/sb_end_write().
> > The freeze_super callback is necessary otherwise the call
> > sb_want_write() inside the generic implementation hangs.
> 
> I don't this this is really going to work.
> 
> The main problem is out of btrfs, it's all about the s_writer.rw_sem.
> 
> If we have a running scrub, it holds the mnt_want_write_file(), which is 
> a read lock on the rw_sem.
> 
> Then we start freezing, which will call sb_wait_write(), which will do a 
> write lock on the rw_sem, waiting for the scrub to finish.
> 
> However the ->freeze() callback is only called when freeze_super() got 
> the write lock on the rw_sem.

Note there are 2 callbacks for freeze, sb::freeze_super and
sb::freeze_fs.

ioctl_fsfreeze
  if fs->freeze_super
    call fs_freeze_super()
  else
    freeze_super()
      sb_wait_write()
      if (sb->freeze_fs)
        call sb->freeze_fs()

What you describe matches the 'else' branch as this unconditionally
blocks on the sb_wait_write and never gets to our callback. This is what
I observed too.

To fix that I've added the sb::freeze_super so it can do something
to avoid the lockup in sb_wait_write(), because we must at some point
call freeze_super().

Schematically it goes like this:

           Freeze thread                         Scrub

	                                  btrfs_ioctl_scrub
					    mnt_want_write_file (effectively sb_want_write())
ioctl_fsfreeze
  fs->freeze_super
    set fs->flags FREEZING
    freeze_super
      sb_wait_freeze()
      (BLOCKS)
                                              (chunk loop)
                                                scrub_simple_mirror()
                                                  if fs->flags
						    sb_end_write()
						      wait_on_bit fs->flags FREEZING
						      (BLOCKS)
      (UNBLOCKS)
      ...


Unfreezing is basically the same in reverse:

ioctl_fsthaw
  fs->thaw_super
    thaw_super()
    unset fs->flags FREEZING
                                                     (UNBLOCKS)
						     sb_want_write()
						     ...

So if you see a problem in that please let me know, I've tested the
patch and it worked but I might me missing something.

