Return-Path: <linux-btrfs+bounces-5743-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD45D909F10
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2024 20:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AD19284114
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jun 2024 18:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1052E44C7B;
	Sun, 16 Jun 2024 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iEp+plr5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RWqzTIOy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iEp+plr5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RWqzTIOy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E16E1C68E;
	Sun, 16 Jun 2024 18:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718561953; cv=none; b=u9uMl/KqaOYI9mlAODhaG9qp9ivI2yrBdJ3p6Z7vpHqh+BhHflGTqFDDaFJHYkDQkMdgk6M96HKziEvmb4Iq0TFdTjivE0egYAV0QDt8s4RZhthfIddkbE3nLigXmoBWuI0GJhh9fA7Vjf4BBRByfJpEAjmm4h1DDVsB7YOyuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718561953; c=relaxed/simple;
	bh=t7PPzXp8kO9lRno4T4TpBEn9E1lbqcDyf7XGltaz7jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwF/wWn7Z93CROSwBYF9DutGwsxc8Yq8vzdqAc84XS1nzD60QpRO3/sQra/5n/MvOXk1bEmPcR4zNwKg4jmLc6ce2mSqOZeA56/AFbRT+BCn1zsgzTkOTLFfEJfbreVNvgp+t4D2cWxe4F2D57n8E+F2/0ry3pXNpXRjJ5/QnEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iEp+plr5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RWqzTIOy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iEp+plr5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RWqzTIOy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7F7A35D555;
	Sun, 16 Jun 2024 18:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718561949;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utgc9yx0ZBDXDPEB9diVuwP8I1o/um7SJHnQ09SdfKg=;
	b=iEp+plr5qkw3krsIfCOho0Vpi2qryyRjG/eU3QQAM/u4GGrVOhbhX7QF5ioET4IXQXG2cg
	KctWIog0iVkGw8GE4VmE4g4zIaeobmgJRcLH/en3Q7F1gFxFLplJ5Pfd22pDMSO6MB98Wp
	luR61QTleUXQKveoA65J2ANJFBrGNXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718561949;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utgc9yx0ZBDXDPEB9diVuwP8I1o/um7SJHnQ09SdfKg=;
	b=RWqzTIOy95gccufQioICNvXS0Ji9BWY4UX5g6HOD5PtpRv87aW2fz8osfX2wH1C+bhD8YC
	tAEx8Rm30jm9I8Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iEp+plr5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RWqzTIOy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718561949;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utgc9yx0ZBDXDPEB9diVuwP8I1o/um7SJHnQ09SdfKg=;
	b=iEp+plr5qkw3krsIfCOho0Vpi2qryyRjG/eU3QQAM/u4GGrVOhbhX7QF5ioET4IXQXG2cg
	KctWIog0iVkGw8GE4VmE4g4zIaeobmgJRcLH/en3Q7F1gFxFLplJ5Pfd22pDMSO6MB98Wp
	luR61QTleUXQKveoA65J2ANJFBrGNXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718561949;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=utgc9yx0ZBDXDPEB9diVuwP8I1o/um7SJHnQ09SdfKg=;
	b=RWqzTIOy95gccufQioICNvXS0Ji9BWY4UX5g6HOD5PtpRv87aW2fz8osfX2wH1C+bhD8YC
	tAEx8Rm30jm9I8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5923813AA0;
	Sun, 16 Jun 2024 18:19:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ERSJFZ0sb2aLGgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Sun, 16 Jun 2024 18:19:09 +0000
Date: Sun, 16 Jun 2024 20:19:08 +0200
From: David Sterba <dsterba@suse.cz>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: rst: remove encoding field from stripe_extent
Message-ID: <20240616181908.GE25756@suse.cz>
Reply-To: dsterba@suse.cz
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-1-179c1eec08f2@kernel.org>
 <20240611143651.GH18508@suse.cz>
 <c7246728-aadb-4699-8fdf-060502c1092a@wdc.com>
 <20240613212347.GB25756@twin.jikos.cz>
 <d6cf3e45-aaf0-4256-92c1-bb8780c76da2@wdc.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6cf3e45-aaf0-4256-92c1-bb8780c76da2@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7F7A35D555
X-Spam-Flag: NO
X-Spam-Score: -4.21
X-Spam-Level: 

On Fri, Jun 14, 2024 at 09:36:34AM +0000, Johannes Thumshirn wrote:
> On 13.06.24 23:23, David Sterba wrote:
> > On Tue, Jun 11, 2024 at 04:33:19PM +0000, Johannes Thumshirn wrote:
> >> On 11.06.24 16:37, David Sterba wrote:
> >>> On Mon, Jun 10, 2024 at 10:40:25AM +0200, Johannes Thumshirn wrote:
> >>>> -#define BTRFS_STRIPE_RAID5	5
> >>>> -#define BTRFS_STRIPE_RAID6	6
> >>>> -#define BTRFS_STRIPE_RAID1C3	7
> >>>> -#define BTRFS_STRIPE_RAID1C4	8
> >>>> -
> >>>>    struct btrfs_stripe_extent {
> >>>> -	__u8 encoding;
> >>>> -	__u8 reserved[7];
> >>>>    	/* An array of raid strides this stripe is composed of. */
> >>>> -	struct btrfs_raid_stride strides[];
> >>>> +	__DECLARE_FLEX_ARRAY(struct btrfs_raid_stride, strides);
> >>>
> >>> Is there a reason to use the __ underscore macro? I see no difference
> >>> between that and DECLARE_FLEX_ARRAY and underscore usually means that
> >>> it's special in some way.
> >>>
> >>
> >> Yes, the __ version is for UAPI, like __u8 or __le32 and so on.
> > 
> > I see, though I'd rather keep the on-disk definitions free of wrappers
> > that hide the types. We use the __ int types but that's all and quite
> > clear what it means.
> > 
> > There already are flexible members (btrfs_leaf, btrfs_node,
> > btrfs_inode_extref), using the empty[] syntax. The macro wraps the
> > distinction that c++ needs but so far the existing declarations have't
> > been problematic.  So I'd rather keep the declarations consistent.
> > 
> 
> Yes but all these examples have other members as well. After this patch, 
> btrfs_stripe_extent is a container for btrfs_raid_stride, and C doesn't 
> allow a flexmember only struct:
> 
> In file included from fs/btrfs/ctree.h:18,
>                   from fs/btrfs/delayed-inode.h:19,
>                   from fs/btrfs/super.c:32:
> ./include/uapi/linux/btrfs_tree.h:753:34: error: flexible array member 
> in a struct with no named members
>    753 |         struct btrfs_raid_stride strides[];
>        |                                  ^~~~~~~

To fix that __DECLARE_FLEX_ARRAY adds the layer of an anonymous struct
and an empty other member. We'd have to duplicate that so let's use the
macro.

