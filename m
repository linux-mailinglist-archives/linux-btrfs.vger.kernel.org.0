Return-Path: <linux-btrfs+bounces-12008-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A12A4F78E
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 08:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A46816EF3A
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Mar 2025 07:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83BB1EA7C7;
	Wed,  5 Mar 2025 07:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ls7HfrcG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qS3BQedG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ls7HfrcG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qS3BQedG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565851C5F13
	for <linux-btrfs@vger.kernel.org>; Wed,  5 Mar 2025 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741158130; cv=none; b=B63hvXWvCp0cySjX1CNS9Zc9bqd9MLzpm/57PAnW3Y+4UpjzrvFSWGmjdJXWtR6yo9D5l5+TNc7+WvEoHSnRRZEBIJq0P9t1Lj7AimRnI1MMwbG5bnIbau4/RdXM1fElytsX+CbqajcGChiJBG2QmlMXEekSCdDc8EqMIbzu3Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741158130; c=relaxed/simple;
	bh=WUqh+uX0yIDqnoRecIg5kLslXqaZLsm/z5AAWKOSeIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fum8slaA46b6ltyffVXbkqsb/GTHACpg6/9JcGdJi2ht7t7p68U7OTeaJrydBSEIKCF1PZ2oUaUbQb5dB9iF34CqAwOA4DUUZ/QdVPqP0FbJjp4jLvd5+0/GSqLQ2vue/VBDJo0uALG3d/tOizS7nIhx908l4jtgdsZL92kPH9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ls7HfrcG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qS3BQedG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ls7HfrcG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qS3BQedG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 675931F38A;
	Wed,  5 Mar 2025 07:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741158126;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4SHEXo/0aTbfaugGQmNuGg4yI5z6hBgzwGRxJ3hqeQ=;
	b=ls7HfrcGhGV6lZvvREYFdhcwynV8QKKN3q4sJQip3k30mK0Y/OOMML17uEFo5/RDBqDgUY
	24cXDKGMhNEAL+6d/nuNgEdUY+5a627wZ/DQjeSF1tIwJgEpgJ4aeMw02ZG6uQqeOeAlrp
	jnKvyM/ExoPaSZrLVaYtPAz7tFxUqtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741158126;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4SHEXo/0aTbfaugGQmNuGg4yI5z6hBgzwGRxJ3hqeQ=;
	b=qS3BQedGolLqAxZxWye6gGiscIb0x9teQxEl7aJK4IHFEijISjWPk7nPiDUmDygegufTZ9
	44Bu1J+ojI+W1GCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741158126;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4SHEXo/0aTbfaugGQmNuGg4yI5z6hBgzwGRxJ3hqeQ=;
	b=ls7HfrcGhGV6lZvvREYFdhcwynV8QKKN3q4sJQip3k30mK0Y/OOMML17uEFo5/RDBqDgUY
	24cXDKGMhNEAL+6d/nuNgEdUY+5a627wZ/DQjeSF1tIwJgEpgJ4aeMw02ZG6uQqeOeAlrp
	jnKvyM/ExoPaSZrLVaYtPAz7tFxUqtA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741158126;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t4SHEXo/0aTbfaugGQmNuGg4yI5z6hBgzwGRxJ3hqeQ=;
	b=qS3BQedGolLqAxZxWye6gGiscIb0x9teQxEl7aJK4IHFEijISjWPk7nPiDUmDygegufTZ9
	44Bu1J+ojI+W1GCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 395B013939;
	Wed,  5 Mar 2025 07:02:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RvstDe72x2dpQAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 05 Mar 2025 07:02:06 +0000
Date: Wed, 5 Mar 2025 08:02:00 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] btrfs/defrag: implement compression levels
Message-ID: <20250305070200.GY5777@suse.cz>
Reply-To: dsterba@suse.cz
References: <20250304171403.571335-1-neelx@suse.com>
 <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc3446ce-347f-41da-9255-233e2e08f91c@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:replyto,suse.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed, Mar 05, 2025 at 08:01:24AM +1030, Qu Wenruo wrote:
> The feature itself looks good to me.
> 
> Although not sure if a blank commit message is fine for this case.
> 
> 在 2025/3/5 03:44, Daniel Vacek 写道:
> > Signed-off-by: Daniel Vacek <neelx@suse.com>
> > ---
> >   fs/btrfs/btrfs_inode.h     |  2 ++
> >   fs/btrfs/defrag.c          | 22 +++++++++++++++++-----
> >   fs/btrfs/fs.h              |  2 +-
> >   fs/btrfs/inode.c           | 10 +++++++---
> >   include/uapi/linux/btrfs.h | 10 +++++++++-
> >   5 files changed, 36 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/btrfs/btrfs_inode.h b/fs/btrfs/btrfs_inode.h
> > index aa1f55cd81b79..5ee9da0054a74 100644
> > --- a/fs/btrfs/btrfs_inode.h
> > +++ b/fs/btrfs/btrfs_inode.h
> > @@ -145,6 +145,7 @@ struct btrfs_inode {
> >   	 * different from prop_compress and takes precedence if set.
> >   	 */
> >   	u8 defrag_compress;
> > +	s8 defrag_compress_level;
> >
> >   	/*
> >   	 * Lock for counters and all fields used to determine if the inode is in
> > diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
> > index 968dae9539482..03a0287a78ea0 100644
> > --- a/fs/btrfs/defrag.c
> > +++ b/fs/btrfs/defrag.c
> > @@ -1363,6 +1363,7 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
> >   	u64 last_byte;
> >   	bool do_compress = (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS);
> >   	int compress_type = BTRFS_COMPRESS_ZLIB;
> > +	int compress_level = 0;
> >   	int ret = 0;
> >   	u32 extent_thresh = range->extent_thresh;
> >   	pgoff_t start_index;
> > @@ -1376,10 +1377,19 @@ int btrfs_defrag_file(struct inode *inode, struct file_ra_state *ra,
> >   		return -EINVAL;
> >
> >   	if (do_compress) {
> > -		if (range->compress_type >= BTRFS_NR_COMPRESS_TYPES)
> > -			return -EINVAL;
> > -		if (range->compress_type)
> > -			compress_type = range->compress_type;
> > +		if (range->flags & BTRFS_DEFRAG_RANGE_COMPRESS_LEVEL) {
> > +			if (range->compress.type >= BTRFS_NR_COMPRESS_TYPES)
> > +				return -EINVAL;
> > +			if (range->compress.type) {
> > +				compress_type = range->compress.type;
> > +				compress_level= range->compress.level;
> > +			}
> 
> I am not familiar with the compress level, but
> btrfs_compress_set_level() does extra clamping, maybe we also want to do
> that too?

Yes the level needs to be validated here as well.

> > @@ -643,7 +645,13 @@ struct btrfs_ioctl_defrag_range_args {
> >   	 * for this defrag operation.  If unspecified, zlib will
> >   	 * be used
> >   	 */
> > -	__u32 compress_type;
> > +	union {
> > +		__u32 compress_type;
> > +		struct {
> > +			__u8 type;
> > +			__s8 level;
> > +		} compress;
> > +	};
> >
> >   	/* spare for later */
> >   	__u32 unused[4];
> 
> We have enough space left here, although u32 is overkilled for
> compress_type, using the unused space for a new s8/s16/s32 member should
> be fine.

I suggested to do it like that, u32 is wasting space and the union trick
reusing existing space was already done e.g. in the balance filters.

