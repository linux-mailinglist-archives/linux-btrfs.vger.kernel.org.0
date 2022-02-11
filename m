Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4D34B2DF2
	for <lists+linux-btrfs@lfdr.de>; Fri, 11 Feb 2022 20:45:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352976AbiBKTo6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 11 Feb 2022 14:44:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiBKTo5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 11 Feb 2022 14:44:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2678ECF5
        for <linux-btrfs@vger.kernel.org>; Fri, 11 Feb 2022 11:44:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CE49221136;
        Fri, 11 Feb 2022 19:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644608693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T0naXAxYU2HksfpsEg8/6YT7ej91oLq6qOfEMdjEAvE=;
        b=kceP58mfi9VOqbOBciXANw9f+JWlRZ5Dk3+xqn7Z3Jj0t1GkIUJczsg5zKfEy7kTTsYJzv
        y11Y8OH76QFgU7psRsjOHTZQmUuwU+TapMP/EG0N+xXkxFcOiaik3bMastPZaz5kOBj7pf
        yd5tMWyZTtsyHwRbD010O7hm2I41plY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644608693;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T0naXAxYU2HksfpsEg8/6YT7ej91oLq6qOfEMdjEAvE=;
        b=E53bjNXZw69+xVV8B4mBa13LU+exzp8Dj1240kQPAxytx0x2omkKDcaV7PT4V1j0r1qIlY
        cBsaUCpO7FFnsbDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6505213CA6;
        Fri, 11 Feb 2022 19:44:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 60lCDrW8BmJ1OAAAMHmgww
        (envelope-from <rgoldwyn@suse.de>); Fri, 11 Feb 2022 19:44:53 +0000
Date:   Fri, 11 Feb 2022 13:44:51 -0600
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH v2] btrfs: Fix subvol turns RO if root is remounted RO
Message-ID: <20220211194451.oioy4xl3dr5ebmhr@fiona>
References: <20220211140918.c6wpmh3pgzjuytve@fiona>
 <3c5b83dc-86f5-bedf-d1ba-71b05d0f19fa@cobb.uk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c5b83dc-86f5-bedf-d1ba-71b05d0f19fa@cobb.uk.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16:42 11/02, Graham Cobb wrote:
> 
> On 11/02/2022 14:09, Goldwyn Rodrigues wrote:
> > If a read-write root mount is remounted as read-only, the subvolume
> > is also set to read-only.
> > 
> > Use a rw_mounts counter to check the number of read-write mounts, and change
> > superblock to read-only only in case there are no read-write subvol mounts.
> > Disable SB_RDONLY in flags passed so superblock does not change
> > read-only.
> > 
> > 
> > Test case:
> > DEV=/dev/vdb
> > mkfs.btrfs -f $DEV
> > mount $DEV /mnt
> > btrfs subvol create /mnt/sv
> > mount -o remount,ro /mnt
> > mount -o subvol=/sv $DEV /mnt/sv
> > findmnt # /mnt is RO, /mnt/sv RW
> > mount -o remount,ro /mnt
> > findmnt # /mnt is RO, /mnt/sv RO as well
> > umount /mnt{/sv,}
> > 
> > 
> > Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> > 
> > diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
> > index a2991971c6b5..2bb6869f15af 100644
> > --- a/fs/btrfs/ctree.h
> > +++ b/fs/btrfs/ctree.h
> > @@ -1060,6 +1060,9 @@ struct btrfs_fs_info {
> >  	spinlock_t zone_active_bgs_lock;
> >  	struct list_head zone_active_bgs;
> >  
> > +	/* Count of subvol mounts read-write */
> > +	int rw_mounts;
> > +
> >  #ifdef CONFIG_BTRFS_FS_REF_VERIFY
> >  	spinlock_t ref_verify_lock;
> >  	struct rb_root block_tree;
> > diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> > index 33cfc9e27451..2072759d5f22 100644
> > --- a/fs/btrfs/super.c
> > +++ b/fs/btrfs/super.c
> > @@ -1835,6 +1835,11 @@ static struct dentry *btrfs_mount(struct file_system_type *fs_type, int flags,
> >  	/* mount_subvol() will free subvol_name and mnt_root */
> >  	root = mount_subvol(subvol_name, subvol_objectid, mnt_root);
> >  
> > +	if (!IS_ERR(root) && !(flags & SB_RDONLY)) {
> > +		struct btrfs_fs_info *fs_info = btrfs_sb(mnt_root->mnt_sb);
> > +		fs_info->rw_mounts++;
> > +	}
> > +
> >  out:
> >  	return root;
> >  }
> > @@ -1958,6 +1963,11 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> >  		goto out;
> >  
> >  	if (*flags & SB_RDONLY) {
> > +
> > +		if (--fs_info->rw_mounts > 0) {
> > +			*flags &= ~SB_RDONLY;
> > +			goto out;
> > +		}
> >  		/*
> >  		 * this also happens on 'umount -rf' or on shutdown, when
> >  		 * the filesystem is busy.
> > @@ -2057,6 +2067,8 @@ static int btrfs_remount(struct super_block *sb, int *flags, char *data)
> >  		if (ret)
> >  			goto restore;
> >  
> > +		fs_info->rw_mounts++;
> > +
> >  		btrfs_clear_sb_rdonly(sb);
> >  
> >  		set_bit(BTRFS_FS_OPEN, &fs_info->flags);
> > 
> 
> I'm sorry my earlier email wasn't clear. I still believe this is an
> unacceptable change in behaviour, unless I am misunderstanding.
> 
> Let me provide a short testcase to clarify my understanding and my
> objection:
> 
> Assume we have a device /dev/test.
> 
> Current behaviour:
> 
>   mkfs.btrfs /dev/test
>   mkdir /mnt /mnt/1 /mnt/2
>   mount /dev/test /mnt/1
>   btrfs subv create /mnt/1/a
>   btrfs subv create /mnt/1/b
>   btrfs subv create /mnt/1/a/aa
>   mount -o subvol=a /dev/test /mnt/2
> 
>   touch /mnt/1/a/x /mnt/1/b/x /mnt/1/a/aa/x /mnt/2/xx /mnt/2/aa/xx
> 
> All 5 files can be created. I can create files in all three subvolumes
> accessed as /mnt/1/a, /mnt/1/b, /mnt/1/a/aa, /mnt/2 or /mnt/2/aa.
> 
>   mount -o remount,ro /mnt/1
> (or "mount -o remount,ro /mnt/2" the result is the same)
> 
>   touch /mnt/1/a/x /mnt/1/b/x /mnt/1/a/aa/x /mnt/2/xx /mnt/2/aa/xx
> 
> I cannot now create files in any of the three subvolumes accessed as
> /mnt/1/a, /mnt/1/b, /mnt/1/a/aa, /mnt/2 or /mnt/2/aa.
> 
> New behaviour:
> 
> It is not immediately clear to me what your proposed change will do.
> Will it result in all access via /mnt/1 (for example to /mnt/1/a/x)
> being read-only but access via /mnt/2 to the same file (for example
> /mnt/2/x) being read-write?

Yes.

> 
> Or will it result in access to the directory /mnt/1 itself being
> read-only but access to the (subvolume) directories /mnt/1/a,
> /mnt/1/a/aa and /mnt/1/b will be read-write? Please explain. [I think
> this point is worth clarifying in the patch if it goes ahead - it is not
> obvious whether the counter is a count of mount points or subvolumes]

Yes, but note that this situation can also be arrived at by (without
this patch):

umount /mnt/1 /mnt/2
mount -o ro /dev/vdb /mnt/1
mount -o subvol=/a /dev/vdb /mnt/2

> 
> I think either would be unacceptable changes - existing systems, scripts
> and procedures have been created around the assumption that changing
> *any* mount point to readonly makes the whole volume readonly. This may
> not be ideal but it is existing behaviour, and is very simple to understand.

If the subvolumes are independent, shouldn't their access be too?

> 
> I would also like to understand how the system manager would make the
> whole volume go readonly with your patch. Taking into account that there
> may have also been mounts in other namespaces, associated with
> containers and not directly visible.
> 

Would a subvolume remount,ro in one privileged namespace make a
subvolume in another namespace read-only? Yes, perhaps sysadmins
shouldn't give privileges to containers, but controlling one
subvolume from another subvolume sounds like lack of control rather than
being in control.

Ideally, setting subvolumes readonly should be done by btrfs property
and not through mount flags.

-- 
Goldwyn
