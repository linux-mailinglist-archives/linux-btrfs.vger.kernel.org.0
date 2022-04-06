Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC404F6AEF
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 22:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232463AbiDFULw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 16:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbiDFULU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 16:11:20 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF4F309739
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 11:31:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id l4-20020a17090a49c400b001c6840df4a3so3676266pjm.0
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Apr 2022 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rD1XDx1jXxzSvf9RmVkrXhhokgfERaHAnYLbdWt5O/4=;
        b=03ooZCk9CcBbF+9/aJiCKCHodsApoBCA+FdELQMQCts4AFw4f4CL0S5Rbn2Qc/kX2b
         JxOlxgqQebwIlK9Nl1yTp9ua+Y3Kfv6Qj/IgGfA54sCjhFqAT2C0L6E+J5AvwNvOjt7L
         2t+1CZdfH4Oos1sEULDWpa2OlgB4Q4eroReTBubVj+xsevO8brVjKyklXrwwvn7tiXOa
         yYLFWHM/QQadjjoeZYtsPA0kiTNVC0ufg4tGOBWnfy3VsvUd268SXQMlSO0jF3IK0RHz
         dUvP7TQJl5/XQmDeDYSjoakuUM0a/L6fJpo/QEeW2gucopS5J/hR02GX6DgJfqBuQZ5Y
         heRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rD1XDx1jXxzSvf9RmVkrXhhokgfERaHAnYLbdWt5O/4=;
        b=1HGEo3NyINoc/p/zdEEsUWwUNl/+BMx5x4gZ85bubjBVZru/ZZhZs8RW9Ox4M+9vNP
         u9AjT890Dv8sDGw+7uZZs+UmCVx6JX4lWDwJff8vWa6SoAIa2joDxwI60ay4o6WTOYFZ
         tfb/gPSNoEe1R6AZC+9gWuB3I5spA4BwHMr8dycVpjWwsdb8508vh9LeSUd6jtc1xIDc
         drmg1uC2PEzoo7fuxmE49gNbbCVc1IZugcU+Yr0YDy2o/R596Xizly0IobZrlrZxSHqK
         J2/zX8bj6XJJRftTzV9+AsvU69vr/SmLLqKTpTFFx+a6PeeMvo2e6RNoD0mrvGkWm3fe
         Gnww==
X-Gm-Message-State: AOAM53285zYFZ1iw2sl6C+xq/uA0c/Aebx2edKvm4/WaI6IDlY2DSWY8
        BYw2WEkujhxR5To+hPbWlTry6Q==
X-Google-Smtp-Source: ABdhPJxho8CjKI9yt0bruwCzdkg+15ON+7auaSckUkDPqe9ZHMYDyVOqbe5j/Y+w+OJ1VocicBmvCA==
X-Received: by 2002:a17:90b:380d:b0:1c7:223:c0d with SMTP id mq13-20020a17090b380d00b001c702230c0dmr11665234pjb.94.1649269885332;
        Wed, 06 Apr 2022 11:31:25 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:4964])
        by smtp.gmail.com with ESMTPSA id f31-20020a17090a702200b001ca996866b5sm6308532pjk.12.2022.04.06.11.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 11:31:24 -0700 (PDT)
Date:   Wed, 6 Apr 2022 11:31:22 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        kernel-team@fb.com
Subject: Re: [PATCH v4 4/4] btrfs: move common inode creation code into
 btrfs_create_new_inode()
Message-ID: <Yk3cejA34sSukoH7@relinquished.localdomain>
References: <cover.1647306546.git.osandov@fb.com>
 <da6cfa1b8e42db5c8954680cac1ca322d463b880.1647306546.git.osandov@fb.com>
 <5029eef8-cdd7-20ef-ec89-34c8b685ed00@dorminy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5029eef8-cdd7-20ef-ec89-34c8b685ed00@dorminy.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 06, 2022 at 01:18:52PM -0400, Sweet Tea Dorminy wrote:
> As Naohiro Aota noted in slack, this change turns out to make generic/650
> and others have write-time corruption. It appears to be from moving
> btrfs_init_inode_security() (which inserts xattrs for the inode) to before
> inserting the new inode into the tree; if the xattrs for an acl or for
> selinux get written out before the inode they belong to, the write-time
> corruption checker complains that an xattr item appears before its requisite
> inode.

This may be the write-time tree checker being overzealous. Both the
xattr insertions and the inode insertion happen within one transaction,
so we won't end up with the xattr but no inode actually being committed.
I don't see anything that would legitimately be upset if it came across
this intermediate state in the meantime.

> I'm not sure if it reintroduces the leak, but moving
> btrfs_init_inode_security() to after the inode is fully inserted into the
> tree seems to fix the issue, something like:
> 
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -6238,18 +6238,6 @@ int btrfs_create_new_inode(struct btrfs_trans_handle
> *trans,
>                           ret);
>         }
> 
> -       /*
> -        * Subvolumes don't inherit ACLs or get passed to the LSM. This is
> -        * probably a bug.
> -        */
> -       if (!args->subvol) {
> -               ret = btrfs_init_inode_security(trans, args);
> -               if (ret) {
> -                       btrfs_abort_transaction(trans, ret);
> -                       goto discard;
> -               }
> -       }
> -
>         /*
>          * We could have gotten an inode number from somebody who was
> fsynced
>          * and then removed in this same transaction, so let's just set full
> @@ -6327,6 +6315,18 @@ int btrfs_create_new_inode(struct btrfs_trans_handle
> *trans,
>         btrfs_mark_buffer_dirty(path->nodes[0]);
>         btrfs_release_path(path);
> 
> +       /*
> +        * Subvolumes don't inherit ACLs or get passed to the LSM. This is
> +        * probably a bug.
> +        */
> +       if (!args->subvol) {
> +               ret = btrfs_init_inode_security(trans, args);
> +               if (ret) {
> +                       btrfs_abort_transaction(trans, ret);
> +                       goto discard;
> +               }
> +       }
> +
>         inode_tree_add(inode);
> 
>         trace_btrfs_inode_new(inode);
> -- 
> 
> 
> I don't know what the right process to follow here is. Naohiro, might you be
> able to test with this incremental patch and confirm that it fixes? Omar,
> does this have the inode leak problem you were trying to fix?

I _think_ this fix is fine, though. The only thing I'm concerned about
is if btrfs_init_inode_security() changes the inode, then we won't write
out those changes to disk. But I don't see any code paths in
btrfs_init_inode_security() that change the inode.

I'd say that if this fixes Naohiro's issue, we should go with it.

> Sweet Tea
