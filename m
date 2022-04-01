Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0804EE641
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Apr 2022 04:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244258AbiDACuk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 31 Mar 2022 22:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbiDACuj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 31 Mar 2022 22:50:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199C622B0A
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 19:48:51 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f3so1382568pfe.2
        for <linux-btrfs@vger.kernel.org>; Thu, 31 Mar 2022 19:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2EYQ+xjHshEcvLNCPzOYa0QaJoMJTUPqRxD61n+m2I=;
        b=mm376W/Xz+ak+N+lliQdBh97l/huqIYUX2XZ9/xxtReXOppbsUHCyzvrQGAOHXdCTq
         HaVAoodrIcp+LOxxTIbNj4rMsJKg68DbpnNl55eN4eRqqSn6h4IoDdIH1HUS/t5qNqRm
         KBHWxXI0xe8SjgHdFgDob0+KYPZ4RzbHHL96ie8u6JPI6D27DmVcNWe3rLgKS27F7B2e
         ote8KMA3pCshvJP0kM5COiarw/r+uxrX2GZ8IYGYxLOVOKPqDuCfk8AqQj3+HKWssap5
         JXw7SLLr90CgciNNCrrgxDoYvggdADV+qaGo5f8u4P0oNUHjR5m9mTM4FHpanSdCgskj
         wjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2EYQ+xjHshEcvLNCPzOYa0QaJoMJTUPqRxD61n+m2I=;
        b=4v0+75kFuRJF9GqdP9FkMKgmIYiRcct8Nqf63zw/jJ0FIY1vvz58xwFgpCI6jLi+oC
         LVSR54aEs5HgEner5DjrZUmcJeWIWuVR1hvbxc9whWJX25NUMGXw8Rgee6f1SL9+HdCG
         saAOHCRsfwLNsugNH9CmeXRzP+GR2FumsNIQfA8pRAeCgIu5GVrTmCiZ6YeZsGWef9mD
         SEeCcQE7fivE64YOR8JgWjf6nErf5XHwXWggVBTulnwtMNib/+eglsaLaf+wKlqvyDum
         6wB2gxojw8CyYelv656k0oAXvx/yZnKYt/mb/niIYmr55kY4nq8OjZZ6DEZ3WbJupwDh
         51xQ==
X-Gm-Message-State: AOAM533I4lDw4rGF8Aa//mXv4pgcvZpz6+jj0nwmvAGvfId4kAP+mfz8
        dV1rl46Q/G3Ul/AJ0+ysOgYEQ2Tebp+mlAJWdkQXm+tXzrQ=
X-Google-Smtp-Source: ABdhPJxIYoSvUv1YvKjRP5L48wYCSSG605TphCw1hBbEmei09PUXzlt/vl/LDaJ6JvBLKuZ6+DFZ2zg9IVgG3aMwJ64=
X-Received: by 2002:a63:7f15:0:b0:398:5224:9b52 with SMTP id
 a21-20020a637f15000000b0039852249b52mr13187688pgd.249.1648781329978; Thu, 31
 Mar 2022 19:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAKxU2N-FKf-RsbA4S7hrYJXHUe7wJUrRyHGKjzKGgBmNcE1sCA@mail.gmail.com>
 <562b797f-49b6-80a0-4a1e-7dafa1975e86@gmx.com> <CAKxU2N9bzKpt94i53vzKgYKaDEGZ7tAj_nE-KFm-71qK3yXDjw@mail.gmail.com>
 <bfa7ae69-6a2b-af93-cfae-9b7c929d115b@suse.com>
In-Reply-To: <bfa7ae69-6a2b-af93-cfae-9b7c929d115b@suse.com>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Thu, 31 Mar 2022 19:48:43 -0700
Message-ID: <CAKxU2N8JiE9n+qEM8LMKz60v46k0+P2whjzK49Z=jUooNdkDRQ@mail.gmail.com>
Subject: Re: btrfs volume can't see files in folder
To:     Qu Wenruo <wqu@suse.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 31, 2022 at 5:59 PM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2022/4/1 08:24, Rosen Penev wrote:
> > On Thu, Mar 31, 2022 at 4:40 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2022/4/1 03:29, Rosen Penev wrote:
> >>> A specific folder has files in it. Directly accessing the path works
> >>> but ls in the directory returns empty.
> >>>
> >>> Any way to fix this issue? I believe it happened after a btrfs
> >>> replace(failed drive in RAID5) + btrfs balance.
> >>
> >> Btrfs check please.
> > btrfs check --force /dev/sda
>
> Force is not recommended unless it's your root fs and you don't really
> want to run btrfs check on an liveCD.
Same result without force and unmounted:

btrfs check /dev/sda
Opening filesystem to check...
Checking filesystem on /dev/sda
UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
[1/7] checking root items
[2/7] checking extents
[3/7] checking free space cache
block group 4885757034496 has wrong amount of free space, free space
cache has 286720 block group has 290816
failed to load free space cache for block group 4885757034496
block group 4898641936384 has wrong amount of free space, free space
cache has 36864 block group has 53248
failed to load free space cache for block group 4898641936384
block group 4953402769408 has wrong amount of free space, free space
cache has 262144 block group has 274432
failed to load free space cache for block group 4953402769408
block group 5478462521344 has wrong amount of free space, free space
cache has 716800 block group has 729088
failed to load free space cache for block group 5478462521344
block group 5484904972288 has wrong amount of free space, free space
cache has 811008 block group has 819200
failed to load free space cache for block group 5484904972288
[4/7] checking fs roots
[5/7] checking only csums items (without verifying data)
[6/7] checking root refs
[7/7] checking quota groups skipped (not enabled on this FS)
found 2689565679616 bytes used, no error found
total csum bytes: 2620609300
total tree bytes: 5374935040
total fs tree bytes: 1737539584
total extent tree bytes: 511115264
btree space waste bytes: 889131100
file data blocks allocated: 41913072627712
 referenced 2675025698816

>
> As sometimes it can report false positive if the fs is not mounted
> read-only.
>
> > Opening filesystem to check...
> > Checking filesystem on /dev/sda
> > UUID: bfa267c0-df2c-45a6-ad88-9d76b3844326
> > [1/7] checking root items
> > [2/7] checking extents
> > [3/7] checking free space cache
> > btrfs: space cache generation (1084391) does not match inode (1084389)
> > failed to load free space cache for block group 139616845824
> > btrfs: space cache generation (1084391) does not match inode (1084389)
> > failed to load free space cache for block group 146059296768
> > btrfs: space cache generation (1084391) does not match inode (1084389)
> > failed to load free space cache for block group 3183842689024
> > btrfs: space cache generation (1084391) does not match inode (1084389)
> > failed to load free space cache for block group 3184916430848
> > btrfs: space cache generation (1084391) does not match inode (1084389)
> > failed to load free space cache for block group 3185990172672
> > btrfs: space cache generation (1084391) does not match inode (1084389)
> > failed to load free space cache for block group 3187063914496
> > btrfs: space cache generation (1084391) does not match inode (1084389)
> > failed to load free space cache for block group 3190318694400
> > block group 4885757034496 has wrong amount of free space, free space
> > cache has 286720 block group has 290816
> > failed to load free space cache for block group 4885757034496
> > block group 4898641936384 has wrong amount of free space, free space
> > cache has 36864 block group has 53248
> > failed to load free space cache for block group 4898641936384
> > block group 4953402769408 has wrong amount of free space, free space
> > cache has 262144 block group has 274432
> > failed to load free space cache for block group 4953402769408
> > block group 5478462521344 has wrong amount of free space, free space
> > cache has 716800 block group has 729088
> > failed to load free space cache for block group 5478462521344
> > block group 5484904972288 has wrong amount of free space, free space
> > cache has 811008 block group has 819200
> > failed to load free space cache for block group 5484904972288
> > [4/7] checking fs roots
> >
> > It's currently stuck on that last one.
>
> If the fs is pretty large, it can take quite some time.
>
> Thanks,
> Qu
>
> >
> >>
> >> It looks like an DIR_ITEM/DIR_INDEX corruption.
> >>
> >> Thanks,
> >> Qu
> >
>
