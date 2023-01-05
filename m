Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054AA65F174
	for <lists+linux-btrfs@lfdr.de>; Thu,  5 Jan 2023 17:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbjAEQwy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 5 Jan 2023 11:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233993AbjAEQwx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 5 Jan 2023 11:52:53 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803E3116A
        for <linux-btrfs@vger.kernel.org>; Thu,  5 Jan 2023 08:52:52 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e21so5543345ybb.3
        for <linux-btrfs@vger.kernel.org>; Thu, 05 Jan 2023 08:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=leblancnet-us.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GTwiwDqu0d8HWSQoyEbKjkGpyN0PwD3D6YPbwjPH7ac=;
        b=QgdyuNxn5M9pgGW/D9G4D/IIbntQXWepRA3n+xT8xcDMzlMucEt43s2/vl2A3nYdHw
         C0j5wXeZWA7QjWT4bHdcHCtAlZAwYxv1B9AHhJ/CzevcaPV6ssMj2mYU8flqAvUOnCP3
         ro6qccIjTiRl6s2HgCyVLpPedAT79BeywmLsOxWvdcgyYRVWuoVlTBraxN5JhqF/JwDw
         YLVJvGsu2s9rCvOaMz+jM1ZcL9ixsWRMNVk68NnQfAlR0yJPes4YpBVHa/+3cLiIqaGr
         cN9WBCK+lGQKU5Pb50bdjHCtvsChbpD3dPv4WnTYur1bsXBLnb5ODhr2zIlMapChpCv3
         5miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GTwiwDqu0d8HWSQoyEbKjkGpyN0PwD3D6YPbwjPH7ac=;
        b=r4+CNQhOYDc5s9FT0EHxfdfpT3SsHNkEYtUqiiapcKUvFMu0FdVjog4wQP61wURVHO
         8dIMh1WqYhfYktptWDNh6P5DPLZ//n7R45P8pGhsYU46QtyIYommX+LZoa61WJSpGeaF
         VJtBiewo/02zEiJuHxnXahBi5fMrIbzNM6H7l+3AU++o0QrPHrk6SJzyNMPPJMJf0Vn5
         vDCAQcDZtjX2hfMFr4FawJREHhByG5LOH45N0sudqHsel3DMG0GhNKB5gpoj7koeY+Wm
         4EVzhhb5ZhbthBHdLwhoZLmgGCAAhSfsdVGnI/MB+xjVEdI/QV2B5J4hrPaviGmUFRqU
         v+Nw==
X-Gm-Message-State: AFqh2kqGX9nICAw2W3rhH+ODfMefbuQMRPQrVV7MKxqiSRqQCfTk6AJx
        g73IHK4iFp/b7kbhrnr084patR8yaof6P2Xjagiwgg==
X-Google-Smtp-Source: AMrXdXsroFe979Vtn5yXXe9+qHRF+UEBFHU2+IB9/6zU7pxnIk9XDzz/PdeJq8Mu96YlYl8jJ8zgNOgO4bk7fo+mAI0=
X-Received: by 2002:a25:874e:0:b0:726:9b62:faa9 with SMTP id
 e14-20020a25874e000000b007269b62faa9mr3513782ybn.43.1672937571621; Thu, 05
 Jan 2023 08:52:51 -0800 (PST)
MIME-Version: 1.0
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
 <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
 <4f134378-4298-bc28-c17a-8415ffdc19e9@gmx.com> <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
In-Reply-To: <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
From:   Robert LeBlanc <robert@leblancnet.us>
Date:   Thu, 5 Jan 2023 09:52:40 -0700
Message-ID: <CAANLjFr9-_bG9uhfKmrOd7ketifFsEn-tOduVOVRDM0bBwMXxQ@mail.gmail.com>
Subject: Re: File system can't mount
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jan 5, 2023 at 5:09 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2023/1/5 14:44, Qu Wenruo wrote:
> >
> >
> > On 2023/1/5 13:24, Robert LeBlanc wrote:
> >> On Wed, Jan 4, 2023 at 10:11 PM Robert LeBlanc <robert@leblancnet.us>
> >> wrote:
> >>>
> >>> I may have run into a new bug (I can't find anything in my Google
> >>> search other than a patch that exposes the issue). I had to recreate
> >>> my BTRFS file system about a year ago when I hit a bug in an earlier
> >>> kernel. I was able to pull a good snapshot from my backups (and mount
> >>> the old filesystem in read-only to get my media subvolume) and it had
> >>> been running great for at least a year. My file system went offline
> >>> today and just would not mount. I downloaded the latest btrfs-progs
> >>> from git to see if it could handle it better, but no luck. This is a
> >>> RAID-1 with 4 drives and the metadata is also RAID-1, but it looks
> >>> like both copies of the metadata are corrupted the same way which is
> >>> really odd and the drives show no errors. I tried taking the first
> >>> drive that it complained about offline and tried to mount with `-o
> >>> degraded` but it couldn't bring up the filesystem. It would be nice to
> >>> try and recover this as I have a subvolume with my media server that
> >>> isn't backed up because of the size, but the critical stuff is backed
> >>> up.
> >>>
> >>> Here is the `btrfs check` output:
> >>> ```
> >>> #:~/code/btrfs-progs$ sudo ./btrfs check /dev/mapper/1EV13X7B
> >>> Opening filesystem to check...
> >>> Checking filesystem on /dev/mapper/1EV13X7B
> >>> UUID: 7b01dd5a-cfa3-4918-a714-03ca7682fbdc
> >>> [1/7] checking root items
> >>> [2/7] checking extents
> >>> WARNING: tree block [12462950961152, 12462950977536) is not nodesize
> >>> aligned, may cause problem for 64K page system
> >>> ERROR: add_tree_backref failed (extent items tree block): File exists
> >>> ERROR: add_tree_backref failed (non-leaf block): File exists
> >>> tree backref 12462950957056 root 7 not found in extent tree
> >>> incorrect global backref count on 12462950957056 found 1 wanted 0
> >>> backpointer mismatch on [12462950957056 1]
>
> And there are two extent items involved in the case.
>
> The number 12462950961152 is the incorrect backref, while extent
> 12462950957056 is the correct extent item which misses the backref item.
>
> I'm afraid that, there could be a memory bitflip:
>
> 12462950957056 = 0xb55c1c3c000
> 12462950961152 = 0xb55c1c3d000
>
> The difference is one bit flipped in the larger one.
>
> Thus I strongly recommended to do a memtest before trying anything else.
>
> Thanks,
> Qu

Qu,

Thank you for your response. It looks like both of my BTRFS file
systems on that machine are in trouble. I'll run the memtest and see
if I find anything.

Robert LeBlanc
----------------
Robert LeBlanc
PGP Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1
