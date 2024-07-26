Return-Path: <linux-btrfs+bounces-6736-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC193D79E
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 19:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A791C21B0D
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Jul 2024 17:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9A17D353;
	Fri, 26 Jul 2024 17:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1N+wNjah";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L03kZnQV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1N+wNjah";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L03kZnQV"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75156748A
	for <linux-btrfs@vger.kernel.org>; Fri, 26 Jul 2024 17:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722015045; cv=none; b=CTz+DxLN6NfoAAWBaEpD0l7kAAn8YSBAeOtI5JxchbL9oH7J7Bed8i+Iz1V9hWVh++tSMOYiDvJPY1dhwA1l15O+Dcxj/Mi10n/2RK4PStz6j1/Fu5jMRDRcKiHmb/8h67meU5Z5F/kh7V8vTVip+M6uY5+9up/7fj0G4Hd6p8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722015045; c=relaxed/simple;
	bh=bl2+4++zW/LR89KTRgQKshYeTjP5VQt7v16UgTL6Eko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d1OJVo+m5Z6qTz9qONySF1dS+wD5gejwJm57qizbYm391/FTYfd0aHQgCNkZAJZfTCyHrVdm+qHbxlYHxDkm7+VM9FPkBckcOEpQd8/X3q2E5lnXMrJCigsAzSqO6LXnuAwwl3XAtx7RzVAflybL80YwMh1zdvwbi47+0SttpZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1N+wNjah; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L03kZnQV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1N+wNjah; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L03kZnQV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 806E91F8BE;
	Fri, 26 Jul 2024 17:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722015041;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4UWBO+Zy9xViSclnzL5a2EzHFNDT2TwbEWFrVq+NgE=;
	b=1N+wNjah5wKCHZhlaJ+LCjx0kKSjW6VuddPufWMC6lvL57HFy921Cc2CqmDd6m4PKEb+ik
	7TIK8WTPsLkpemPrRAFrskdgG/RMwqnRs57hRIzoZlUW7f6nHr5WCbcEYDXjAqJBmZzkqu
	yVmPBgnvf2jHkN7CB09XqHLPHkNZngU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722015041;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4UWBO+Zy9xViSclnzL5a2EzHFNDT2TwbEWFrVq+NgE=;
	b=L03kZnQVdK6BrLincOGsQe/pd8naBBwQ7u3Ms+hvNDKCE1WB/YdXWHdZCL+m0GUKiTuQPy
	gJpRbuuQ5qybv/Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722015041;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4UWBO+Zy9xViSclnzL5a2EzHFNDT2TwbEWFrVq+NgE=;
	b=1N+wNjah5wKCHZhlaJ+LCjx0kKSjW6VuddPufWMC6lvL57HFy921Cc2CqmDd6m4PKEb+ik
	7TIK8WTPsLkpemPrRAFrskdgG/RMwqnRs57hRIzoZlUW7f6nHr5WCbcEYDXjAqJBmZzkqu
	yVmPBgnvf2jHkN7CB09XqHLPHkNZngU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722015041;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O4UWBO+Zy9xViSclnzL5a2EzHFNDT2TwbEWFrVq+NgE=;
	b=L03kZnQVdK6BrLincOGsQe/pd8naBBwQ7u3Ms+hvNDKCE1WB/YdXWHdZCL+m0GUKiTuQPy
	gJpRbuuQ5qybv/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 574481396E;
	Fri, 26 Jul 2024 17:30:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8BITFUHdo2ZSUQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 17:30:41 +0000
Date: Fri, 26 Jul 2024 19:30:40 +0200
From: David Sterba <dsterba@suse.cz>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Mark Harmstone <maharmstone@fb.com>, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 2/2] btrfs-progs: set subvol uuids when converting
Message-ID: <20240726173040.GO17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20240719150343.3992904-1-maharmstone@fb.com>
 <20240719150343.3992904-2-maharmstone@fb.com>
 <cbe0935a-7f38-4c13-ad39-3cbe2fbdc13e@gmx.com>
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbe0935a-7f38-4c13-ad39-3cbe2fbdc13e@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_THREE(0.00)[3]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Sat, Jul 20, 2024 at 07:58:30AM +0930, Qu Wenruo wrote:
> 在 2024/7/20 00:33, Mark Harmstone 写道:
> > Currently when using btrfs-convert, neither the main subvolume nor the
> > image subvolume get uuids assigned, nor is the uuid tree created.
> >
> > Signed-off-by: Mark Harmstone <maharmstone@fb.com>
> > ---
> >   common/root-tree-utils.c | 29 +++++++++++++++++++++++++++++
> >   common/root-tree-utils.h |  1 +
> >   convert/common.c         | 14 +++++++++-----
> >   convert/main.c           |  8 +++++++-
> >   mkfs/main.c              | 29 -----------------------------
> >   5 files changed, 46 insertions(+), 35 deletions(-)
> >
> > diff --git a/common/root-tree-utils.c b/common/root-tree-utils.c
> > index f9343304..9495178c 100644
> > --- a/common/root-tree-utils.c
> > +++ b/common/root-tree-utils.c
> > @@ -59,6 +59,35 @@ error:
> >   	return ret;
> >   }
> >
> > +int create_uuid_tree(struct btrfs_trans_handle *trans)
> > +{
> > +	struct btrfs_fs_info *fs_info = trans->fs_info;
> > +	struct btrfs_root *root;
> > +	struct btrfs_key key = {
> > +		.objectid = BTRFS_UUID_TREE_OBJECTID,
> > +		.type = BTRFS_ROOT_ITEM_KEY,
> > +	};
> > +	int ret = 0;
> > +
> > +	UASSERT(fs_info->uuid_root == NULL);
> > +	root = btrfs_create_tree(trans, &key);
> > +	if (IS_ERR(root)) {
> > +		ret = PTR_ERR(root);
> > +		goto out;
> > +	}
> > +
> > +	add_root_to_dirty_list(root);
> > +	fs_info->uuid_root = root;
> > +	ret = btrfs_uuid_tree_add(trans, fs_info->fs_root->root_item.uuid,
> > +				  BTRFS_UUID_KEY_SUBVOL,
> > +				  fs_info->fs_root->root_key.objectid);
> > +	if (ret < 0)
> > +		btrfs_abort_transaction(trans, ret);
> > +
> > +out:
> > +	return ret;
> > +}
> > +
> >   int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
> >   			u64 subvol_id_cpu)
> >   {
> > diff --git a/common/root-tree-utils.h b/common/root-tree-utils.h
> > index 78731dd5..aec1849b 100644
> > --- a/common/root-tree-utils.h
> > +++ b/common/root-tree-utils.h
> > @@ -29,5 +29,6 @@ int btrfs_link_subvolume(struct btrfs_trans_handle *trans,
> >   			 int namelen, struct btrfs_root *subvol);
> >   int btrfs_uuid_tree_add(struct btrfs_trans_handle *trans, u8 *uuid, u8 type,
> >   			u64 subvol_id_cpu);
> > +int create_uuid_tree(struct btrfs_trans_handle *trans);
> >
> >   #endif
> > diff --git a/convert/common.c b/convert/common.c
> > index b093fdb5..667f38a4 100644
> > --- a/convert/common.c
> > +++ b/convert/common.c
> > @@ -190,7 +190,7 @@ static int setup_temp_extent_buffer(struct extent_buffer *buf,
> >   static void insert_temp_root_item(struct extent_buffer *buf,
> >   				  struct btrfs_mkfs_config *cfg,
> >   				  int *slot, u32 *itemoff, u64 objectid,
> > -				  u64 bytenr)
> > +				  u64 bytenr, bool set_uuid)
> 
> Considering this is really a temporary root item, I believe we can skip
> it the UUID step for now.
> (Only one of the 4 callers are passing true for it).
> 
> 
> I'm wondering if a kernel like uuid tree generation would be more
> concentrated and easier to implement.
> 
> E.g. after the fs is fully converted, generate the uuid tree then update
> the UUID for the involved subvolumes.

Agreed, this sounds like a better option.

