Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497AF4D911C
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Mar 2022 01:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245446AbiCOAR6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Mar 2022 20:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiCOAR5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Mar 2022 20:17:57 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BD341622
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 17:16:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id e3so16171215pjm.5
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Mar 2022 17:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZRjqe/yqzaAVyCySE2DnAuiA2qA3IX21BPkBy7O5zEQ=;
        b=McdKBLzHKooA7o8E3clklrpqFLZvq/TopZCXXF0gMoCPWlfQmZ7/V/4r6inAoVBhJt
         4Eq7lZMB7I/SIxkuTkVoXj9B7ga+TPFXIz92HZcLJRaD+WmLjx66JJ8ORgbKSkJR42cH
         /slmkqqCpS7D0hBV3VqncO3/X+hkf+WhXzBtwIlbX5o/aKpnR4s0lwr+fsACVF4JpulI
         GVAJLvj2jNzbtmPs2EsyBXdTWczWTUqZAC+pes9xMOELJPssYqvG41oN3fofLlNiK4zK
         O9ku4caOzBqxfsr6QJ9ScBKDyLfvIKxHvO9lOmLg//jod5Mb2a15jpsbWAyBNz9gBo2U
         08gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZRjqe/yqzaAVyCySE2DnAuiA2qA3IX21BPkBy7O5zEQ=;
        b=nOCL/gp6pTo+Deg6L65EK6C2AlZRI5vXFmGxRcC6wOOPsQosQ+RRewY1Th9QAO7hSL
         nILubp40HRHlsOJfHMw6wqPb8i0sbTz4ccMCWGQ1D2jsaDaoe+nmjFuM7oSsD9ypt7N7
         2Fy9ks4Z4CqTr6P06g/kSPQE2nCrOI17wBMte1DaHn7FHpGRb2bu8XL4+yEnvb0YimA9
         2kcxgZNvdC+sxC8FYCR7PLBj39drkPVX88JB/l+crOgb0b8gqyZ7xSRje9/EEf1opGNF
         7CYvIS7vazSy17WPbBPJvXL4ojGvZ3grTq9xw73f6wxt17os07ZD6RTlP1pBNQrBVX96
         htRg==
X-Gm-Message-State: AOAM533Phft8XBRr5HFQiqqLNMzAQMswbXJT11zow6+AjcLoSNCBG474
        89zxTjr3341rkUSYL+jye4ZYTA==
X-Google-Smtp-Source: ABdhPJyV959yzMdIrp0Xj4DieDY6+X6Ma7bDlhOuP0rf7wG0QgsDRe1XI4rRUOKG4/Gczont9jpZmA==
X-Received: by 2002:a17:902:e549:b0:151:f021:51e6 with SMTP id n9-20020a170902e54900b00151f02151e6mr25423033plf.71.1647303406834;
        Mon, 14 Mar 2022 17:16:46 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:46f5])
        by smtp.gmail.com with ESMTPSA id t8-20020a6549c8000000b00372eb3a7fb3sm17437230pgs.92.2022.03.14.17.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 17:16:46 -0700 (PDT)
Date:   Mon, 14 Mar 2022 17:16:45 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 13/16] btrfs: allocate inode outside of
 btrfs_new_inode()
Message-ID: <Yi/a7a4C9zT/c+KR@relinquished.localdomain>
References: <cover.1646875648.git.osandov@fb.com>
 <24d8818e1152a8fb31e2d78239ce410d2a0f8cd4.1646875648.git.osandov@fb.com>
 <CAL3q7H5ACv3ej1=7P2y7mA1vCJoAcHkCqro6_VBuAUxeaw25rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5ACv3ej1=7P2y7mA1vCJoAcHkCqro6_VBuAUxeaw25rw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 14, 2022 at 11:33:51PM +0000, Filipe Manana wrote:
> On Thu, Mar 10, 2022 at 4:56 AM Omar Sandoval <osandov@osandov.com> wrote:
> >
> > From: Omar Sandoval <osandov@fb.com>
> >
> > Instead of calling new_inode() and inode_init_owner() inside of
> > btrfs_new_inode(), do it in the callers. This allows us to pass in just
> > the inode instead of the mnt_userns and mode and removes the need for
> > memalloc_nofs_{save,restores}() since we do it before starting a
> > transaction. This also paves the way for some more cleanups in later
> > patches.
> >
> > This also removes the comments about Smack checking i_op, which are no
> > longer true since commit 5d6c31910bc0 ("xattr: Add
> > __vfs_{get,set,remove}xattr helpers"). Now it checks inode->i_opflags &
> > IOP_XATTR, which is set based on sb->s_xattr.
> >
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> 
> There's some leak here Omar.
> 
> misc-next is triggering tons of these on dmesg:

I reproduced the "page private not zero" messages on misc-next, but not
on my full series, so it's probably some mistake I made when splitting
up these patches that doesn't exist in the end result. I'll fix it.
