Return-Path: <linux-btrfs+bounces-20795-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BiWJktVcGlvXQAAu9opvQ
	(envelope-from <linux-btrfs+bounces-20795-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 05:25:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2B150FF3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 05:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B59C7486BB3
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Jan 2026 04:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE68D36C0CB;
	Wed, 21 Jan 2026 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5k70oBc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="50rpwBza";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="f5k70oBc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="50rpwBza"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385B135FF7A
	for <linux-btrfs@vger.kernel.org>; Wed, 21 Jan 2026 04:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768969503; cv=none; b=vF2RbBAZxGQrcnRGjlUNNb5PtjMrL82AogMlBQEyTbWu2zriNi2OjaLwGBjDOYPeY3oWltBKkX7w2CSREOLx7GN30yNYYDGlgv4cl2flIqu2UJQ7m8ZXVzaFc6L/PBhOseE91ltLLqLWt96tXU0Pl0NsKguDcI7HKdakguQvPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768969503; c=relaxed/simple;
	bh=H+pmDawxlbrWkPRTZJaHL4pFZJ0/kmpWheKEwZRC+78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbaVTFahNkbzTftSBuPLvUxn4mQkpyWok8r5hamTafIpxgJL5yqYYVwM7wsy7HiF8pc9FtCqFinjr8cGMq8AzJBN3ZMmzAGWzHDLQ7xSTbYY71UbYuIBS5p2ZHKTfPQTinhxIpqDlvNiyP6MyMapaTnbeBd977/KxldaL79lg2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5k70oBc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=50rpwBza; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=f5k70oBc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=50rpwBza; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 016385BCCA;
	Wed, 21 Jan 2026 04:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768969497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+y28UUoNWEO+TVKfHe8U+f5SZAvQL62JG9BEmKBSv4=;
	b=f5k70oBc+BqFH/2teNAOEHFk0P+WDRPo+xhtlz56GwYIdchqXbmibF4zqwJdaY/nlWduBF
	qMM4kVWsdG3AAR7rka/StsgQ9C7W7jQ5VfZhT0MHcSVeHjTEssMTGUaJPHmpPoI+AhkElf
	V8D8Ufu1/+qtTMZ80Vliff0MuiRfpdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768969497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+y28UUoNWEO+TVKfHe8U+f5SZAvQL62JG9BEmKBSv4=;
	b=50rpwBzat69RXO53t7Lg5ao44/BxP8lGKWsy/Nftlt1znut4N6tzpoOudxUk7JXHKR3VXJ
	5ZFhdhLie2r6gkBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f5k70oBc;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=50rpwBza
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768969497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+y28UUoNWEO+TVKfHe8U+f5SZAvQL62JG9BEmKBSv4=;
	b=f5k70oBc+BqFH/2teNAOEHFk0P+WDRPo+xhtlz56GwYIdchqXbmibF4zqwJdaY/nlWduBF
	qMM4kVWsdG3AAR7rka/StsgQ9C7W7jQ5VfZhT0MHcSVeHjTEssMTGUaJPHmpPoI+AhkElf
	V8D8Ufu1/+qtTMZ80Vliff0MuiRfpdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768969497;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H+y28UUoNWEO+TVKfHe8U+f5SZAvQL62JG9BEmKBSv4=;
	b=50rpwBzat69RXO53t7Lg5ao44/BxP8lGKWsy/Nftlt1znut4N6tzpoOudxUk7JXHKR3VXJ
	5ZFhdhLie2r6gkBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9B5F3EA63;
	Wed, 21 Jan 2026 04:24:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id umH6NBhVcGl2FgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 21 Jan 2026 04:24:56 +0000
Date: Wed, 21 Jan 2026 05:24:55 +0100
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: fdmanana@kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/4] btrfs: allocate path in load_block_group_size_class()
Message-ID: <20260121042455.GO26902@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <cover.1768911827.git.fdmanana@suse.com>
 <05452a804b036b205a791be1c1c5e09d0279812d.1768911827.git.fdmanana@suse.com>
 <3a5d1472-7ff0-447f-9d02-f75a60161ead@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a5d1472-7ff0-447f-9d02-f75a60161ead@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.21
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20795-lists,linux-btrfs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.com];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,linux-btrfs@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[twin.jikos.cz:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.cz:replyto,suse.cz:dkim,suse.com:email]
X-Rspamd-Queue-Id: 5A2B150FF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 07:16:06AM +1030, Qu Wenruo wrote:
> 在 2026/1/20 22:55, fdmanana@kernel.org 写道:
> > From: Filipe Manana <fdmanana@suse.com>
> > 
> > Instead of allocating and freeing a path in every iteration of
> > load_block_group_size_class(), through its helper function
> > sample_block_group_extent_item(), allocate the path in the former and
> > pass it to the later.
> > 
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/block-group.c | 32 +++++++++++++++++---------------
> >   1 file changed, 17 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> > index 343c29344484..a7828673be39 100644
> > --- a/fs/btrfs/block-group.c
> > +++ b/fs/btrfs/block-group.c
> > @@ -579,24 +579,24 @@ int btrfs_add_new_free_space(struct btrfs_block_group *block_group, u64 start,
> >    * @index:        the integral step through the block group to grab from
> >    * @max_index:    the granularity of the sampling
> >    * @key:          return value parameter for the item we find
> > + * @path:         path to use for searching in the extent tree
> >    *
> >    * Pre-conditions on indices:
> >    * 0 <= index <= max_index
> >    * 0 < max_index
> >    *
> > - * Returns: 0 on success, 1 if the search didn't yield a useful item, negative
> > - * error code on error.
> > + * Returns: 0 on success, 1 if the search didn't yield a useful item.
> >    */
> >   static int sample_block_group_extent_item(struct btrfs_caching_control *caching_ctl,
> >   					  struct btrfs_block_group *block_group,
> >   					  int index, int max_index,
> > -					  struct btrfs_key *found_key)
> > +					  struct btrfs_key *found_key,
> > +					  struct btrfs_path *path)
> >   {
> >   	struct btrfs_fs_info *fs_info = block_group->fs_info;
> >   	struct btrfs_root *extent_root;
> >   	u64 search_offset;
> >   	const u64 search_end = btrfs_block_group_end(block_group);
> > -	BTRFS_PATH_AUTO_FREE(path);
> >   	struct btrfs_key search_key;
> >   	int ret = 0;
> >   
> > @@ -606,17 +606,9 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
> >   	lockdep_assert_held(&caching_ctl->mutex);
> >   	lockdep_assert_held_read(&fs_info->commit_root_sem);
> >   
> > -	path = btrfs_alloc_path();
> > -	if (!path)
> > -		return -ENOMEM;
> > -
> >   	extent_root = btrfs_extent_root(fs_info, max_t(u64, block_group->start,
> >   						       BTRFS_SUPER_INFO_OFFSET));
> >   
> > -	path->skip_locking = true;
> > -	path->search_commit_root = true;
> > -	path->reada = READA_FORWARD;
> > -
> >   	search_offset = index * div_u64(block_group->length, max_index);
> >   	search_key.objectid = block_group->start + search_offset;
> >   	search_key.type = BTRFS_EXTENT_ITEM_KEY;
> > @@ -679,6 +671,7 @@ static int sample_block_group_extent_item(struct btrfs_caching_control *caching_
> >   static void load_block_group_size_class(struct btrfs_caching_control *caching_ctl,
> >   					struct btrfs_block_group *block_group)
> >   {
> > +	BTRFS_PATH_AUTO_FREE(path);
> >   	struct btrfs_fs_info *fs_info = block_group->fs_info;
> >   	struct btrfs_key key;
> >   	int i;
> > @@ -688,14 +681,23 @@ static void load_block_group_size_class(struct btrfs_caching_control *caching_ct
> >   	if (!btrfs_block_group_should_use_size_class(block_group))
> >   		return;
> >   
> > +	path = btrfs_alloc_path();
> > +	if (!path)
> > +		return;
> 
> Considering the function is only called inside a workqueue, we can avoid 
> a memory allocation by using on-stack path, which also reduces one error 
> path.

As a generic pattern we could switch to on-stack variables for the
functions called from workqueues but it may not be obvious that it's OK
to do that (unlike eg. the compression functions).

But I'd like to have an assertion or a debug warning for that, not sure
how exactly to do it, maybe something is in the task_struct.

