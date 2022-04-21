Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C1250A13B
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 15:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351352AbiDUNy7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 09:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbiDUNy5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 09:54:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6489313FAE
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 06:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECEC361D3B
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 13:52:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6101FC385A8
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650549126;
        bh=rpNoxTRCPUY8vjWhtW6Q5LGnO6tkB7RISVG0K0pwgXQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h9GwcQ95gJWA+zYiVBJNSps6FYGFGZ8a4pSIRUehYo+EThpCq3JwDmvxuOGqwUaLV
         goERTmbbcc6HRZdma1NBQC2gFQ2EM2PiDCFX74A/sqjq6yu7CxZxIJB9TaGXwSkUNc
         E9JyQM+2BAgqpX607yJ7EM5HJ7G7NoQ552uFiGUFtjwW490DC42UQ21cDvYvXyYufQ
         OAWEHW9Zgbfnmr1fnuU08jIa1jMksk/N5Pzn6d9HIzmZwJ4DGeIHBpgmmiMm93fVLD
         UBx0Qrrb6uZmyNWQjPbFHY1/BnvfEvjWxSX4BJjIdGOS0fdJ6Q2L97LXonzuYE/8Ip
         yzWb68tPncVMA==
Received: by mail-qk1-f182.google.com with SMTP id q75so3557652qke.6
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 06:52:06 -0700 (PDT)
X-Gm-Message-State: AOAM533uc17prNvtptlf5SUq2CZr4DUbSXRzIEDP4sCnoP5MUarocEug
        kDtWN52pRI4f2M4+vUixr7n70UEG9n6AmRiJWCM=
X-Google-Smtp-Source: ABdhPJy+2zBMDkab6adZgOEG6k3yNhNMK979pokv5fvgnKcNJ7lo2V86KDCsYRGHmAa02WrKgiU9NsctUE1FHhm5riA=
X-Received: by 2002:a05:620a:288c:b0:699:b9a0:b61a with SMTP id
 j12-20020a05620a288c00b00699b9a0b61amr15491650qkp.233.1650549125308; Thu, 21
 Apr 2022 06:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <bbb363e71d966670d8938898803dac2b8a581c7c.1650535137.git.fdmanana@suse.com>
 <970520d8-74eb-a4c6-53e4-53363ee963f9@oracle.com>
In-Reply-To: <970520d8-74eb-a4c6-53e4-53363ee963f9@oracle.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Thu, 21 Apr 2022 14:51:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5APJ0p4NFECgmvUV8ahTdELyXF6Hsjhd0Q6StgNJ-0vA@mail.gmail.com>
Message-ID: <CAL3q7H5APJ0p4NFECgmvUV8ahTdELyXF6Hsjhd0Q6StgNJ-0vA@mail.gmail.com>
Subject: Re: [PATCH] btrfs: skip compression property for anything other than
 files and dirs
To:     Anand Jain <anand.jain@oracle.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 21, 2022 at 2:42 PM Anand Jain <anand.jain@oracle.com> wrote:
>
> On 21/04/2022 18:01, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The compression property only has effect on regular files and directories
> > (so that it's propagated to files and subdirectories created inside a
> > directory). For any other inode type (symlink, fifo, device, socket),
> > it's pointless to set the compression property because it does nothing
>
> Hm. symlink propagates the compression xattrs to the target file/dir.
>
>   A symlink to a directory
>
>   $ /btrfs$ ls -la | grep test-029
> drwxr-xr-x.  1 root root    0 Apr 12 13:07 test-029
> lrwxrwxrwx.  1 root root   10 Apr 21 20:00 test-029-link -> ./test-029
>
>
>   $ btrfs prop get ./test-029 compression
>   $ btrfs prop get ./test-029-link compression
>
>   Set xattr compression to the symlink
>
>   $ btrfs prop set ./test-029-link compression lzo
>
>   The target directory also gets it.
>
>   $ btrfs prop get ./test-029 compression
> compression=lzo
>   $ btrfs prop get ./test-029 compression
> compression=lzo
>
>   This patch affects the change in semantics. No?

In your examples you are setting/getting the property not to/from the
symlink inode itself but to/from the inode it points at.

"btrfs property set/get" follows symlinks.
That's why in my example I used setfattr with -h (don't follow symlinks).




>
> Thanks, Anand
>
>
> > and ends up unnecessarily wasting leaf space due to the pointless xattr
> > (75 or 76 bytes, depending on the compression value). Symlinks in
> > particular are very common (for example, I have almost 10k symlinks under
> > /etc, /usr and /var alone) and therefore it's worth to avoid wasting
> > leaf space with the compression xattr.
> >
> > For example, the compression property can end up on a symlink or character
> > device implicitly, through inheritance from a parent directory
> >
> >    $ mkdir /mnt/testdir
> >    $ btrfs property set /mnt/testdir compression lzo
> >
> >    $ ln -s yadayada /mnt/testdir/lnk
> >    $ mknod /mnt/testdir/dev c 0 0
> >
> > Or explicitly like this:
> >
> >    $ ln -s yadayda /mnt/lnk
> >    $ setfattr -h -n btrfs.compression -v lzo /mnt/lnk
> >
> > So skip the compression property on inodes that are neither a regular
> > file nor a directory.
>
>
>
>
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
> > ---
> >   fs/btrfs/props.c | 43 +++++++++++++++++++++++++++++++++++++++++++
> >   fs/btrfs/props.h |  1 +
> >   fs/btrfs/xattr.c |  3 +++
> >   3 files changed, 47 insertions(+)
> >
> > diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
> > index f5565c296898..7a0038797015 100644
> > --- a/fs/btrfs/props.c
> > +++ b/fs/btrfs/props.c
> > @@ -20,6 +20,7 @@ struct prop_handler {
> >       int (*validate)(const char *value, size_t len);
> >       int (*apply)(struct inode *inode, const char *value, size_t len);
> >       const char *(*extract)(struct inode *inode);
> > +     bool (*ignore)(const struct btrfs_inode *inode);
> >       int inheritable;
> >   };
> >
> > @@ -72,6 +73,28 @@ int btrfs_validate_prop(const char *name, const char *value, size_t value_len)
> >       return handler->validate(value, value_len);
> >   }
> >
> > +/*
> > + * Check if a property should be ignored (not set) for an inode.
> > + *
> > + * @inode:     The target inode.
> > + * @name:      The property's name.
> > + *
> > + * The caller must be sure the given property name is valid, for example by
> > + * having previously called btrfs_validate_prop().
> > + *
> > + * Returns:    true if the property should be ignored for the given inode
> > + *             false if the property must not be ignored for the given inode
> > + */
> > +bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name)
> > +{
> > +     const struct prop_handler *handler;
> > +
> > +     handler = find_prop_handler(name, NULL);
> > +     ASSERT(handler != NULL);
> > +
> > +     return handler->ignore(inode);
> > +}
> > +
> >   int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
> >                  const char *name, const char *value, size_t value_len,
> >                  int flags)
> > @@ -310,6 +333,22 @@ static int prop_compression_apply(struct inode *inode, const char *value,
> >       return 0;
> >   }
> >
> > +static bool prop_compression_ignore(const struct btrfs_inode *inode)
> > +{
> > +     /*
> > +      * Compression only has effect for regular files, and for directories
> > +      * we set it just to propagate it to new files created inside them.
> > +      * Everything else (symlinks, devices, sockets, fifos) is pointless as
> > +      * it will do nothing, so don't waste metadata space on a compression
> > +      * xattr for anything that is neither a file nor a directory.
> > +      */
> > +     if (!S_ISREG(inode->vfs_inode.i_mode) &&
> > +         !S_ISDIR(inode->vfs_inode.i_mode))
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >   static const char *prop_compression_extract(struct inode *inode)
> >   {
> >       switch (BTRFS_I(inode)->prop_compress) {
> > @@ -330,6 +369,7 @@ static struct prop_handler prop_handlers[] = {
> >               .validate = prop_compression_validate,
> >               .apply = prop_compression_apply,
> >               .extract = prop_compression_extract,
> > +             .ignore = prop_compression_ignore,
> >               .inheritable = 1
> >       },
> >   };
> > @@ -355,6 +395,9 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
> >               if (!h->inheritable)
> >                       continue;
> >
> > +             if (h->ignore(BTRFS_I(inode)))
> > +                     continue;
> > +
> >               value = h->extract(parent);
> >               if (!value)
> >                       continue;
> > diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
> > index 1dcd5daa3b22..09bf1702bb34 100644
> > --- a/fs/btrfs/props.h
> > +++ b/fs/btrfs/props.h
> > @@ -14,6 +14,7 @@ int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
> >                  const char *name, const char *value, size_t value_len,
> >                  int flags);
> >   int btrfs_validate_prop(const char *name, const char *value, size_t value_len);
> > +bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name);
> >
> >   int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path);
> >
> > diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> > index b96ffd775b41..f9d22ff3567f 100644
> > --- a/fs/btrfs/xattr.c
> > +++ b/fs/btrfs/xattr.c
> > @@ -389,6 +389,9 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
> >       if (ret)
> >               return ret;
> >
> > +     if (btrfs_ignore_prop(BTRFS_I(inode), name))
> > +             return 0;
> > +
> >       trans = btrfs_start_transaction(root, 2);
> >       if (IS_ERR(trans))
> >               return PTR_ERR(trans);
>
