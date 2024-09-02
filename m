Return-Path: <linux-btrfs+bounces-7740-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A93968EC0
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 22:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EE3FB223F1
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Sep 2024 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3775A1A4E74;
	Mon,  2 Sep 2024 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jGiuiM2J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJVp0npa";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jGiuiM2J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LJVp0npa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8228E1A4E60;
	Mon,  2 Sep 2024 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725307924; cv=none; b=Op3EmFIrucWLUqJsHnAo7NiK3J3PsgU9yp+IyYfPBpipffJChnLqGp7aEmih47p4JuK9VeJusu5K4bqQjnNV0dKo97QQN7EyWyTPi2X/0FO9ihlgx7hwyzYSkYbb3u/8CAuYCDB/FtHu+ztDzfms/3CSiK4hYxAvnBY1tpk3b7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725307924; c=relaxed/simple;
	bh=CC2cxi4YGQy65RVqryZridxiofsecHHacEBoO18k1hY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clHJr0Y/ipKZnhF7MCNzUuYMUiN52yZdL10kgPisqoji2KgLpLqyXCzYnNQhX3WhndKabzG1T7G3SjoGi4YmGZpX8ebeX78zhVUMCm/kQ+x/EJqXCWOF1DhEmb/mDe/ZyuEwzmf9e1FDZt47n9xf+hqeQDlcVwxVHEgrsVPrNxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jGiuiM2J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJVp0npa; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jGiuiM2J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LJVp0npa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4519C1F79B;
	Mon,  2 Sep 2024 20:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725307920;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YSa0oRjJvAUZTYJeMNY8fs0ZfMIj4kLxEv4Q87cFhg=;
	b=jGiuiM2Jm6JmLEQISDQfiYtVhyFpZ3zDsPN/XJndF6uof6FwQitxqKl+3teMlLexQbvIG0
	uNhrnK8KemKG2mHMNJNEmo1GdDRyYsvHgEHzehveoVKZBEkf6MlvTN3tB19H9LPSLlt2Ws
	JWEQ8s0rFNwE+IFiQh9VX/rrTgvWkVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725307920;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YSa0oRjJvAUZTYJeMNY8fs0ZfMIj4kLxEv4Q87cFhg=;
	b=LJVp0npaWTft3yLnk63Y2+NLviBZZWDWz8y6y4Nw0a5/q1IaOHBAQJ8oMfkkrwA6/O3etI
	DQmn2U+78x88RaBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jGiuiM2J;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=LJVp0npa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725307920;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YSa0oRjJvAUZTYJeMNY8fs0ZfMIj4kLxEv4Q87cFhg=;
	b=jGiuiM2Jm6JmLEQISDQfiYtVhyFpZ3zDsPN/XJndF6uof6FwQitxqKl+3teMlLexQbvIG0
	uNhrnK8KemKG2mHMNJNEmo1GdDRyYsvHgEHzehveoVKZBEkf6MlvTN3tB19H9LPSLlt2Ws
	JWEQ8s0rFNwE+IFiQh9VX/rrTgvWkVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725307920;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8YSa0oRjJvAUZTYJeMNY8fs0ZfMIj4kLxEv4Q87cFhg=;
	b=LJVp0npaWTft3yLnk63Y2+NLviBZZWDWz8y6y4Nw0a5/q1IaOHBAQJ8oMfkkrwA6/O3etI
	DQmn2U+78x88RaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 203A913A21;
	Mon,  2 Sep 2024 20:12:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ub5VBxAc1mbkFgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Mon, 02 Sep 2024 20:12:00 +0000
Date: Mon, 2 Sep 2024 22:11:50 +0200
From: David Sterba <dsterba@suse.cz>
To: Luca Stefani <luca.stefani.ge1@gmail.com>
Cc: Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs: Split remaining space to discard in chunks
Message-ID: <20240902201150.GB26776@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240902114303.922472-1-luca.stefani.ge1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902114303.922472-1-luca.stefani.ge1@gmail.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Rspamd-Queue-Id: 4519C1F79B
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
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmx.com,fb.com,toxicpanda.com,suse.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.71
X-Spam-Flag: NO

On Mon, Sep 02, 2024 at 01:43:00PM +0200, Luca Stefani wrote:
> Per Qu Wenruo in case we have a very large disk, e.g. 8TiB device,
> mostly empty although we will do the split according to our super block
> locations, the last super block ends at 256G, we can submit a huge
> discard for the range [256G, 8T), causing a super large delay.

I'm not sure that this will be different than what we already do, or
have the large delays been observed in practice? The range passed to
blkdev_issue_discard() might be large but internally it's still split to
smaller sizes depending on the queue limits, IOW the device.

Bio is allocated and limited by bio_discard_limit(bdev, *sector);
https://elixir.bootlin.com/linux/v6.10.7/source/block/blk-lib.c#L38

  struct bio *blk_alloc_discard_bio(struct block_device *bdev,
		  sector_t *sector, sector_t *nr_sects, gfp_t gfp_mask)
  {
	  sector_t bio_sects = min(*nr_sects, bio_discard_limit(bdev, *sector));
	  struct bio *bio;

	  if (!bio_sects)
		  return NULL;

	  bio = bio_alloc(bdev, 0, REQ_OP_DISCARD, gfp_mask);
  ...


Then used in __blkdev_issue_discard()
https://elixir.bootlin.com/linux/v6.10.7/source/block/blk-lib.c#L63

  int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
		  sector_t nr_sects, gfp_t gfp_mask, struct bio **biop)
  {
	  struct bio *bio;

	  while ((bio = blk_alloc_discard_bio(bdev, &sector, &nr_sects,
			  gfp_mask)))
		  *biop = bio_chain_and_submit(*biop, bio);
	  return 0;
  }

This is basically just a loop, chopping the input range as needed. The
btrfs code does effectively the same, there's only the superblock,
progress accounting and error handling done.

As the maximum size of a single discard request depends on a device we
don't need to artificially limit it because this would require more IO
requests and can be slower.

