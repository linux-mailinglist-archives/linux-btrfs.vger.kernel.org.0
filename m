Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5B83E1A5D
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Aug 2021 19:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237996AbhHER26 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Aug 2021 13:28:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50410 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237413AbhHER25 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Aug 2021 13:28:57 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E90620250;
        Thu,  5 Aug 2021 17:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1628184522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npaI/wqSlbA8SFx3VJYKd1Ve+/uiXLQbnwfIj6cjiLA=;
        b=RaUVc3S1g8FE7rarUxvz4kfZAaCWvSQuBpbf4+2SS055hntga7ka03suUcmQ52tlUr0EPv
        MPYYh5Pg48W1JeR5u7ewOan0XchSG8x0UbrWbCcIqIIm0O/JUyWMpYp99vu//I7YliuPGE
        Xg3Jg8dILcarSZl8x1xjazwROaOktiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1628184522;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npaI/wqSlbA8SFx3VJYKd1Ve+/uiXLQbnwfIj6cjiLA=;
        b=yTtqbGMi8EC4Jo3uvQp+/hZh83XJ13yz7Qiinw5tP0Sz3BdyI/LLd80om/HRqdKaNUtgvl
        DWKMpvyHdfdcRgBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CD05613DB9;
        Thu,  5 Aug 2021 17:28:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zU9oJcgfDGGSGAAAMHmgww
        (envelope-from <mpdesouza@suse.de>); Thu, 05 Aug 2021 17:28:40 +0000
Message-ID: <edfd5fcf7b63b791425543c642dad2c04b5a71f8.camel@suse.de>
Subject: Re: [PATCH 1/7] btrfs: Reorder btrfs_find_item arguments
From:   Marcos Paulo de Souza <mpdesouza@suse.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marcos Paulo de Souza <mpdesouza@suse.com>,
        linux-btrfs@vger.kernel.org
Cc:     dsterba@suse.com, nborisov@suse.com
Date:   Thu, 05 Aug 2021 14:28:22 -0300
In-Reply-To: <f50cc30c-ea62-5581-2a52-d3a475d3044d@gmx.com>
References: <20210804184854.10696-1-mpdesouza@suse.com>
         <20210804184854.10696-2-mpdesouza@suse.com>
         <f50cc30c-ea62-5581-2a52-d3a475d3044d@gmx.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, 2021-08-05 at 10:16 +0800, Qu Wenruo wrote:
> 
> On 2021/8/5 上午2:48, Marcos Paulo de Souza wrote:
> > It's more natural do use objectid, type and offset, in this order,
> > when
> > dealing with btrfs keys.
> 
> I'm completely fine with this part.
> 
> > No functional changes.
> > 
> > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > ---
> >   fs/btrfs/backref.c | 9 ++++-----
> >   fs/btrfs/ctree.c   | 2 +-
> >   fs/btrfs/ctree.h   | 2 +-
> >   3 files changed, 6 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/btrfs/backref.c b/fs/btrfs/backref.c
> > index f735b8798ba1..9e92faaafa02 100644
> > --- a/fs/btrfs/backref.c
> > +++ b/fs/btrfs/backref.c
> > @@ -1691,8 +1691,8 @@ char *btrfs_ref_to_path(struct btrfs_root
> > *fs_root, struct btrfs_path *path,
> >   				btrfs_tree_read_unlock(eb);
> >   			free_extent_buffer(eb);
> >   		}
> > -		ret = btrfs_find_item(fs_root, path, parent, 0,
> > -				BTRFS_INODE_REF_KEY, &found_key);
> > +		ret = btrfs_find_item(fs_root, path, parent,
> > BTRFS_INODE_REF_KEY,
> > +					0, &found_key);
> >   		if (ret > 0)
> >   			ret = -ENOENT;
> >   		if (ret)
> > @@ -2063,9 +2063,8 @@ static int iterate_inode_refs(u64 inum,
> > struct btrfs_root *fs_root,
> >   	struct btrfs_key found_key;
> > 
> >   	while (!ret) {
> > -		ret = btrfs_find_item(fs_root, path, inum,
> > -				parent ? parent + 1 : 0,
> > BTRFS_INODE_REF_KEY,
> > -				&found_key);
> > +		ret = btrfs_find_item(fs_root, path, inum,
> > BTRFS_INODE_REF_KEY,
> > +				parent ? parent + 1 : 0, &found_key);
> > 
> >   		if (ret < 0)
> >   			break;
> > diff --git a/fs/btrfs/ctree.c b/fs/btrfs/ctree.c
> > index 84627cbd5b5b..c0002ec9c025 100644
> > --- a/fs/btrfs/ctree.c
> > +++ b/fs/btrfs/ctree.c
> > @@ -1528,7 +1528,7 @@ setup_nodes_for_search(struct
> > btrfs_trans_handle *trans,
> >   }
> > 
> >   int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path
> > *path,
> > -		u64 iobjectid, u64 ioff, u8 key_type,
> > +		u64 iobjectid, u8 key_type, u64 ioff,
> >   		struct btrfs_key *found_key)
> 
> But the @found_key part makes me wonder.
> 
> Is it really needed?
> 
> The caller has @path and return value. If we return 0, we know it's
> an
> exact match, no need to grab the key.
> If we return 1, caller can easily grab the key using @path (if they
> really need).
> 
> So can we also remove @found_key parameter, and add some comment on
> the
> function?

I believe that the function name is misleading. Maybe we can adjust it
to something like btrfs_find_item_offset, since it validates if the
found item has the same objectid and type of the searched key.

This is very common for a lot of the callers, which expect to receive
the same objectid and type, and each caller validate the offset as
required. Maybe we can add a comment and change the function name to
reflect all aspects of how it works. What do you think?

Thanks,
  Marcos

> 
> Thanks,
> Qu
> 
> >   {
> >   	int ret;
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index a898257ad2b5..0a971e98f5f9 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -2858,7 +2858,7 @@ int btrfs_duplicate_item(struct
> > btrfs_trans_handle *trans,
> >   			 struct btrfs_path *path,
> >   			 const struct btrfs_key *new_key);
> >   int btrfs_find_item(struct btrfs_root *fs_root, struct btrfs_path
> > *path,
> > -		u64 inum, u64 ioff, u8 key_type, struct btrfs_key
> > *found_key);
> > +		u64 inum, u8 key_type, u64 ioff, struct btrfs_key
> > *found_key);
> >   int btrfs_search_slot(struct btrfs_trans_handle *trans, struct
> > btrfs_root *root,
> >   		      const struct btrfs_key *key, struct btrfs_path
> > *p,
> >   		      int ins_len, int cow);
> > 

