Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628D54F6C89
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Apr 2022 23:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiDFVXp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Apr 2022 17:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236604AbiDFVXL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Apr 2022 17:23:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25AB267AC8
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Apr 2022 13:18:33 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id u14so3646668pjj.0
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Apr 2022 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qyAM37LDkJeT53T0w688+RF4xOyTWlf91/8iwGkLDts=;
        b=h3lvGQxuYzPJUBqyTIeWr8lgYtRX+RkDFStBesHiet3xCm8VFb92AYzUSpAiuHXR4k
         BSHcsJvzW1sf+KRLH/QHs6yLf4vUO1QdCHpu6yf86Fz6ES+9+yKpgRAVHD+oQcpgRO2w
         j1DkT2HOD6uf4UsPHZsUgO3vB9FHHJTvPLSm9vMwWDLFEgZUlFX31x/4SOszZ+GtXZZ3
         gBdTXIvFJZry3YtuoQ3vXgAGj/dJLNmOr7U4V+Rk8DXCO5UST7hQnW69vzz4TFNprlJJ
         QMSKQsJg2D1j5XMaknJojH77k4cSOfu6CB/KdoTJNOluW1nHcEnfax1Z30xJO78yesfO
         EVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qyAM37LDkJeT53T0w688+RF4xOyTWlf91/8iwGkLDts=;
        b=qpH27e9+W/4OXb/ZfBBRZDzzpl+7Bow2PtiNJGEFBb1SqM9XoBKiqobu2tftPfcufF
         y0DkWWYN0FVLA+I368BhjCG/H3+o5agJtSgzYKC91SqdxlXccVlyze+wKTXdkiQgcFu1
         y228YJKM74CJkiCdPc31RdMMZXgIVEQkYpi431sXAA/v3cgv90yw4g6S5qFJz+uVm7Rg
         aaiAnGZY954ey8ky1rUqkHTO/v3i3kuiWQOiSZ4BAeN8DMgueOFC/niAhqI76Yd0AC4X
         y3HH3/mbLudF2Ymtoqu6uSCg2UCKcJhdvZD4DnQSWQXkRY016fMN00sS9I2qFxWjU0Uc
         iBFA==
X-Gm-Message-State: AOAM531B0ZPJvDPtInMQNsannb2XB4MNVCxJGy/siH2CsYwFk96wbpHX
        7c1/J73N+n6SHeCm5U8Kp+n+MOZ/GUcodw==
X-Google-Smtp-Source: ABdhPJxls77ZT6H5XSl05v81v/rtqI0dmN9UI0sTm6lPIMB6EbFoTLJE1rt6mOxSLKEEvSV26lY8nQ==
X-Received: by 2002:a17:90b:4c84:b0:1c7:7769:3cc7 with SMTP id my4-20020a17090b4c8400b001c777693cc7mr11789224pjb.73.1649276313291;
        Wed, 06 Apr 2022 13:18:33 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:4964])
        by smtp.gmail.com with ESMTPSA id ga1-20020a17090b038100b001cac85761e5sm6420822pjb.50.2022.04.06.13.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 13:18:32 -0700 (PDT)
Date:   Wed, 6 Apr 2022 13:18:30 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>,
        kernel-team@fb.com
Subject: Re: [PATCH v4 4/4] btrfs: move common inode creation code into
 btrfs_create_new_inode()
Message-ID: <Yk31ln4fk4BvfzFT@relinquished.localdomain>
References: <cover.1647306546.git.osandov@fb.com>
 <da6cfa1b8e42db5c8954680cac1ca322d463b880.1647306546.git.osandov@fb.com>
 <5029eef8-cdd7-20ef-ec89-34c8b685ed00@dorminy.me>
 <Yk3cejA34sSukoH7@relinquished.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk3cejA34sSukoH7@relinquished.localdomain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 06, 2022 at 11:31:22AM -0700, Omar Sandoval wrote:
> On Wed, Apr 06, 2022 at 01:18:52PM -0400, Sweet Tea Dorminy wrote:
> > As Naohiro Aota noted in slack, this change turns out to make generic/650
> > and others have write-time corruption. It appears to be from moving
> > btrfs_init_inode_security() (which inserts xattrs for the inode) to before
> > inserting the new inode into the tree; if the xattrs for an acl or for
> > selinux get written out before the inode they belong to, the write-time
> > corruption checker complains that an xattr item appears before its requisite
> > inode.
> 
> This may be the write-time tree checker being overzealous. Both the
> xattr insertions and the inode insertion happen within one transaction,
> so we won't end up with the xattr but no inode actually being committed.
> I don't see anything that would legitimately be upset if it came across
> this intermediate state in the meantime.
> 
> > I'm not sure if it reintroduces the leak, but moving
> > btrfs_init_inode_security() to after the inode is fully inserted into the
> > tree seems to fix the issue, something like:
> > 
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -6238,18 +6238,6 @@ int btrfs_create_new_inode(struct btrfs_trans_handle
> > *trans,
> >                           ret);
> >         }
> > 
> > -       /*
> > -        * Subvolumes don't inherit ACLs or get passed to the LSM. This is
> > -        * probably a bug.
> > -        */
> > -       if (!args->subvol) {
> > -               ret = btrfs_init_inode_security(trans, args);
> > -               if (ret) {
> > -                       btrfs_abort_transaction(trans, ret);
> > -                       goto discard;
> > -               }
> > -       }
> > -
> >         /*
> >          * We could have gotten an inode number from somebody who was
> > fsynced
> >          * and then removed in this same transaction, so let's just set full
> > @@ -6327,6 +6315,18 @@ int btrfs_create_new_inode(struct btrfs_trans_handle
> > *trans,
> >         btrfs_mark_buffer_dirty(path->nodes[0]);
> >         btrfs_release_path(path);
> > 
> > +       /*
> > +        * Subvolumes don't inherit ACLs or get passed to the LSM. This is
> > +        * probably a bug.
> > +        */
> > +       if (!args->subvol) {
> > +               ret = btrfs_init_inode_security(trans, args);
> > +               if (ret) {
> > +                       btrfs_abort_transaction(trans, ret);
> > +                       goto discard;
> > +               }
> > +       }
> > +
> >         inode_tree_add(inode);
> > 
> >         trace_btrfs_inode_new(inode);
> > -- 
> > 
> > 
> > I don't know what the right process to follow here is. Naohiro, might you be
> > able to test with this incremental patch and confirm that it fixes? Omar,
> > does this have the inode leak problem you were trying to fix?
> 
> I _think_ this fix is fine, though. The only thing I'm concerned about
> is if btrfs_init_inode_security() changes the inode, then we won't write
> out those changes to disk. But I don't see any code paths in
> btrfs_init_inode_security() that change the inode.
> 
> I'd say that if this fixes Naohiro's issue, we should go with it.

As I just discussed with Sweet Tea offline, property inheritance also
needs to move after inode creation for the same reason.
