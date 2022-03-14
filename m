Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454764D8D84
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Mar 2022 20:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244702AbiCNT42 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 15:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244732AbiCNT40 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 15:56:26 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C78862E9
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 12:55:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id p17so14447050plo.9
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 12:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cOfdmFK1lnNwVVgMSQx/n2UPcPfWQUjDe2HbrnBJ8TI=;
        b=sEWbqQLzu6qogbny4fpA1Jlt97kMO2dinuRepi7MipOwPFbbc1CwDehstcE3IBZUt6
         Vo/EBS1/Ni5PnkzYsYFGWUmuF0ieXYpehwEZRvFc9m9TYcrO7pLam4RVrnGpyQAl1JCU
         2wy3MznX5Bcy4CVs7UlNdtrk0bG4UT5FN4uFj4KmehGmuwJsP0nbKxptVimCWu/DmvK/
         37pqVvZ1aw5cD6cj92mJdyBwSpi3AQeJ8dd9hNOQ8LE8jA9ZR7E5c1/DIqE0wsiSXfOF
         YaSKAxYNYFMV7cPCdY2vNagCknMqe2TbQ2/bfmRAdOPafQbV69E/yyMQRuxNezAI7yQ9
         o8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cOfdmFK1lnNwVVgMSQx/n2UPcPfWQUjDe2HbrnBJ8TI=;
        b=EjjWGWFQM9aqgTsILsrqqreqk5iVj+Q98BcFrqbo0V/VKE+K8AzdeEGQkgvTdeVLG6
         w9ekGjy2TWSn8m68Pu8GJOZysOhk4/vSXjv3d1pY2SiQSgxJWXKXsvrq287REuGqWApZ
         D/UcxmEyjlE58C08cKXmVeyE9dxJSL99+Hzqer+7xNVLabRXYxfhuCY6dGwcPf48DCSS
         G7rMex4+VNrO0qHdHzDw2OCvQbZywI9jTEVMtgXTdg/DL/Nscp/YAq7eU6eYnAnERGcu
         rz7PVWBptmXj19XsJd5q+WsvT6KtTE6xg6WPmLj1Ug1UYNsuAnshrXGCezrZP2iB4gSP
         UDwA==
X-Gm-Message-State: AOAM532kbXgAsw4Sfj8h59rrkq17FlEAigAC5dwfqxbTbGaJDHkp8Kqd
        taBoLOCMWeeqyKzpTHUnpTZ4X5MJJwT7iA==
X-Google-Smtp-Source: ABdhPJx0LO9Q+Hs9AIyMtIwvEHGOGe4KuaZdKzaThfVlH4ztH70wSBirZ2KVC2M4n0pPJALUCEosWQ==
X-Received: by 2002:a17:90a:b307:b0:1bd:37f3:f0fc with SMTP id d7-20020a17090ab30700b001bd37f3f0fcmr848445pjr.132.1647287715714;
        Mon, 14 Mar 2022 12:55:15 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:46f5])
        by smtp.gmail.com with ESMTPSA id z21-20020a17090a8b9500b001bf74f8bb3asm291147pjn.24.2022.03.14.12.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 12:55:15 -0700 (PDT)
Date:   Mon, 14 Mar 2022 12:55:14 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 00/16] btrfs: inode creation cleanups and fixes
Message-ID: <Yi+dopi9KfOSqHoZ@relinquished.localdomain>
References: <cover.1646875648.git.osandov@fb.com>
 <20220314125059.GH12643@twin.jikos.cz>
 <Yi+MiU4D4i0tBG7T@relinquished.localdomain>
 <20220314192703.GO12643@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314192703.GO12643@twin.jikos.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 14, 2022 at 08:27:03PM +0100, David Sterba wrote:
> On Mon, Mar 14, 2022 at 11:42:17AM -0700, Omar Sandoval wrote:
> > On Mon, Mar 14, 2022 at 01:50:59PM +0100, David Sterba wrote:
> > > On Wed, Mar 09, 2022 at 05:31:30PM -0800, Omar Sandoval wrote:
> > > > - Added Sweet Tea's reviewed-by to the remaining patches.
> > > > - Rebased on latest misc-next.
> > > > 
> > > > Thanks!
> > > > 
> > > > 1: https://lore.kernel.org/linux-btrfs/cover.1646348486.git.osandov@fb.com/
> > > > 
> > > > Omar Sandoval (16):
> > > >   btrfs: reserve correct number of items for unlink and rmdir
> > > >   btrfs: reserve correct number of items for rename
> > > >   btrfs: fix anon_dev leak in create_subvol()
> > > >   btrfs: get rid of btrfs_add_nondir()
> > > >   btrfs: remove unnecessary btrfs_i_size_write(0) calls
> > > >   btrfs: remove unnecessary inode_set_bytes(0) call
> > > >   btrfs: remove unnecessary set_nlink() in btrfs_create_subvol_root()
> > > >   btrfs: remove unused mnt_userns parameter from __btrfs_set_acl
> > > >   btrfs: remove redundant name and name_len parameters to create_subvol
> > > >   btrfs: don't pass parent objectid to btrfs_new_inode() explicitly
> > > >   btrfs: move btrfs_get_free_objectid() call into btrfs_new_inode()
> > > >   btrfs: set inode flags earlier in btrfs_new_inode()
> > > >   btrfs: allocate inode outside of btrfs_new_inode()
> > > 
> > > Patches 1-13 added to misc-next. The remaining patches seem to be still
> > > a bit big for review.
> > 
> > I see that misc-next has the whole series, did you change your mind? I
> 
> I added the branch to misc-next on friday and noticed some comments for
> the the patches at the end, so I removed them again.

I see. I'll resend 13-16 with the updates.
