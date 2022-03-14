Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5214D8BE4
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 19:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243951AbiCNSna (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 14:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236506AbiCNSn3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 14:43:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF943DDE8
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 11:42:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id cx5so15598713pjb.1
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 11:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qAZf8+c1QJzjFnHXLHLyhxdXiTMjdxZAP6KpvFVoAC0=;
        b=jX2y6GXLGXZDpzbMTX/3T+fm9q9i24HL+hsXpiB2dYi3ah38lYaxL2mPL1xjVfPkmx
         +VcaU4AclIvnhhXXc2aXW4kmllHKBGyEh4WNJhrZuu1muGWTv0eYwqJh73gTT+73dzen
         oo86GlY/hW0qi5qcA9SQlfMEaR56oD3ERF+ITH6UtU8ZmE+SNQX3UQOo2NAqnIa7O+yQ
         /4R2Olyb4nvSHpXydIb3MRQ0+a8Ri93n3UeMht914aC6H9/Gm/y7/RHz7135H+qBK/p5
         QRlOF8W9ugLGKaRpOtZVaVpjcgSnsMzzZ5fvc4Zqw0HflbkHCQ8XqjSDzoOYf7G7ZwaT
         n9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qAZf8+c1QJzjFnHXLHLyhxdXiTMjdxZAP6KpvFVoAC0=;
        b=nCMmZnajnk0oIUpuzYNm0KNcy8gKDp2XosVbCHDz9dPbVJqPdTiBOk20kkoxOsnZle
         LMDx9uxKq+eozKmTP+jHnxLJKVZGT8YdJ0yeMbDY56wI1tqgGOKZTUtROJPVp6vTC4rD
         Ifc2Wa6lfj1s66H6VOsJ+1YQm+N/olShtzpnA2O/yVdTwl/HFB6uN2QO2GPd6oGR5UNG
         pUTW2/R3V1VpvhAHVlegte+CvDhqz/Tw3o/fBv7ICcd3LmcRyEawvcNcxAeHu7jvIbvm
         U0Z5PJO4qO2KBvaNFNsSKhpfb21Kd29kvTg7tW0MbsabK1PIzGkCcqkvnnxgylBhtx7b
         J6SA==
X-Gm-Message-State: AOAM533DyLgGGWqtFPlGWIttS3EoXCJ4I5NsVWFlNYOzRjAT963gL70C
        jujGIZPDyrsFfQqN5Ke0EziW4rOPOhIiKA==
X-Google-Smtp-Source: ABdhPJxI6TonYSR4oJSpU2FBHh/0p5lwXnkcmrpAH9S28p79ZK4wv2JdyOj+sqschVFUn2EK4EiVXw==
X-Received: by 2002:a17:90a:5643:b0:1bf:ac1f:a1de with SMTP id d3-20020a17090a564300b001bfac1fa1demr566891pji.224.1647283339104;
        Mon, 14 Mar 2022 11:42:19 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:46f5])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7972e000000b004f7b8b43d96sm7137939pfg.51.2022.03.14.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 11:42:18 -0700 (PDT)
Date:   Mon, 14 Mar 2022 11:42:17 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/16] btrfs: inode creation cleanups and fixes
Message-ID: <Yi+MiU4D4i0tBG7T@relinquished.localdomain>
References: <cover.1646875648.git.osandov@fb.com>
 <20220314125059.GH12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314125059.GH12643@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 14, 2022 at 01:50:59PM +0100, David Sterba wrote:
> On Wed, Mar 09, 2022 at 05:31:30PM -0800, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > This series contains several cleanups and fixes for our inode creation
> > codepaths. The main motivation for this is preparation for fscrypt
> > support (in particular, setting up the fscrypt context and encrypted
> > names at inode creation time). But, it also reduces a lot of code
> > duplication and fixes some minor bugs, so it's worth getting in ahead of
> > time.
> > 
> > Patches 1-3 are small fixes. Patches 5-12 are small cleanups. Patches
> > 13-16 are the bulk of the change.
> > 
> > Based on misc-next.
> > 
> > Changes since v1 [1]:
> > 
> > - Split the big final patch into patches 3 and 13-16.
> > - Added Sweet Tea's reviewed-by to the remaining patches.
> > - Rebased on latest misc-next.
> > 
> > Thanks!
> > 
> > 1: https://lore.kernel.org/linux-btrfs/cover.1646348486.git.osandov@fb.com/
> > 
> > Omar Sandoval (16):
> >   btrfs: reserve correct number of items for unlink and rmdir
> >   btrfs: reserve correct number of items for rename
> >   btrfs: fix anon_dev leak in create_subvol()
> >   btrfs: get rid of btrfs_add_nondir()
> >   btrfs: remove unnecessary btrfs_i_size_write(0) calls
> >   btrfs: remove unnecessary inode_set_bytes(0) call
> >   btrfs: remove unnecessary set_nlink() in btrfs_create_subvol_root()
> >   btrfs: remove unused mnt_userns parameter from __btrfs_set_acl
> >   btrfs: remove redundant name and name_len parameters to create_subvol
> >   btrfs: don't pass parent objectid to btrfs_new_inode() explicitly
> >   btrfs: move btrfs_get_free_objectid() call into btrfs_new_inode()
> >   btrfs: set inode flags earlier in btrfs_new_inode()
> >   btrfs: allocate inode outside of btrfs_new_inode()
> 
> Patches 1-13 added to misc-next. The remaining patches seem to be still
> a bit big for review.

I see that misc-next has the whole series, did you change your mind? I
was going to resend with a couple of Sweet Tea's comments addressed
(passing btrfs_new_inode_args to btrfs_init_inode_security() and
mentioning the d_instantiate() change in the commit message for patch
13), but I don't see a good way to split these up further.
