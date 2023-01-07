Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2D660B04
	for <lists+linux-btrfs@lfdr.de>; Sat,  7 Jan 2023 01:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236276AbjAGApp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 6 Jan 2023 19:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjAGApn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 6 Jan 2023 19:45:43 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F486AD8A
        for <linux-btrfs@vger.kernel.org>; Fri,  6 Jan 2023 16:45:42 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id i15so4498884edf.2
        for <linux-btrfs@vger.kernel.org>; Fri, 06 Jan 2023 16:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=leblancnet-us.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou+HTqAEsrj8zk387qxCZKF2hHsh3Tt8BOTjfgh3L5w=;
        b=NGDZstCAWd2Se/AUVALqIYwcy0LYeL+iPTR+bx7bxmvhYqvGJqxjM6K0QNMWXuTedW
         +Mh+Lu72FefgKQ9zqSkRYbD77gaQzxUwQGUgfxgufeGfLjG9TDGymNukuUCRgNKRB1S0
         FjJq7d5xADbxfMuqjPXUkNbH6xh7G9cAuLzgkU/UxpItR344v7enrf32tP2XonoNq4rG
         ryAlZeOkCWvaktnQwG+ldVnaiChy1wIFj91mvgaeBbuWdMkI+PTgZBOW41kPYbLZHH2I
         mP8C0VUcoddta6iKGPaNwDgEcP9gseILUgxh4JjMHA3uuXSbNM7KK/PZOFfT1ADWxqxF
         V7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ou+HTqAEsrj8zk387qxCZKF2hHsh3Tt8BOTjfgh3L5w=;
        b=ISSHQNNPmQTZY3CXiov7LihujzVZ7tNutFZ23dBpDfnl4h1NBqU1IBJu420eDVWl8j
         gFt2ZEWPUYz+nGQfnTWaaefzYdnXFhGfKYnNGppuT9wNIgBWlbUNINpGbd8XwVw0HjM7
         oKuXujXlYSQeVhjDDDDaBjrS1dY3RMc2ZD/+uwJN8FLD6UUsQtrm/EBr7zLUx3SyUlCl
         HYkn+6jX0c+KpUmX+rrHYQP4dtQw559FBa9OA6DXNSP0usL0WVFTPejeWljw8lL3o3ca
         2fha/SiZNiElzuyOQFy9vWfIXJ5L+9Su4LgI3mQS4xzqaXJaDGH2YtZ5LAL7z3NzPfkj
         Uy9w==
X-Gm-Message-State: AFqh2kpkFwwJ5mBE88bjatkscWbIPZuibrMNg3jZjBkuq28arhKyfeHH
        VKFjLcVnWAD49lAILQZmti2NYcsLftuK/yx1Ka8apPFdfYRDPkmQvl0=
X-Google-Smtp-Source: AMrXdXuOe1rtbOTVAM1vL72avlDX/keh5nMu8PzsTC1VngcWZ//NDe//tgMi29YfH1bMI61K4fkvRBWT0/QLcu0UAoQ=
X-Received: by 2002:aa7:c854:0:b0:483:d293:36a3 with SMTP id
 g20-20020aa7c854000000b00483d29336a3mr5324632edt.176.1673052340985; Fri, 06
 Jan 2023 16:45:40 -0800 (PST)
MIME-Version: 1.0
References: <CAANLjFobOKhui5j1VsRkNSTF9SjRADtBennjoZE1jEPnU=iVaw@mail.gmail.com>
 <CAANLjFraYrdzZLv0ZcW=1sfnKSnbbb08qEpVHiAQHZQ181epjg@mail.gmail.com>
 <4f134378-4298-bc28-c17a-8415ffdc19e9@gmx.com> <50ecc4dc-fbf1-8fca-5484-27de33a2ed85@gmx.com>
 <0de3f1eb-4131-774b-74bc-ab2cfdd022de@inwind.it> <b09e0dfc-a911-5eea-8a35-f829ab618b2d@gmx.com>
 <CAANLjFroTEUcOLjfRs-4FWdSf_rgnSHpP8TkU8fo--SYrfjKCg@mail.gmail.com> <3a220ba2-67a6-c3b8-6b07-cf70c1c80fc2@gmx.com>
In-Reply-To: <3a220ba2-67a6-c3b8-6b07-cf70c1c80fc2@gmx.com>
From:   Robert LeBlanc <robert@leblancnet.us>
Date:   Fri, 6 Jan 2023 17:45:28 -0700
Message-ID: <CAANLjFr9OPyvoGfg7dfU314=ba01Ar=GuiXZmef+skCXEC+OzQ@mail.gmail.com>
Subject: Re: File system can't mount
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Antonio Muci <a.mux@inwind.it>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 6, 2023 at 12:47 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > Your assumptions are spot on. One of the two memory dims is either bit
> > flipping or stuck on 0/1. After running memtest86+, I can verify that
> > some memory addresses create spoiled data. I'm currently running off
> > the good DIMM as I get some new RAM ordered and recovering from
> > backups (apparently my backups stopped in September of last year) and
> > then trying to pull off the newer data that I need from the bad file
> > systems.
>
> Well, I'd say that filesystem should still be over 99% fine.
> Even the memory hardware is faulty, it shouldn't cause huge damages for
> the filesystem.
>
> > It's really odd that I never saw csum errors in dmesg and it
> > only appears that metadata got corrupted.
>
> That's because if the corruption happens for data, you won't be able to
> see any csum mismatch.
>
> Because the corruption happens in memory, we calculate the csum using
> the bad data, thus no csum mismatch would happen.

I would have thought that the csum was being calculated as the data
was being written to memory and before being stored in memory, but
thinking about it more, I'm not sure the VFS will let you do that, so
you can only inspect the data after it's already been written to
memory and corrupted.

> You can only be sure by comparing with the backup.
>
> > It looks like some of my
> > more critical subvolumes I could either do a `btrfs send/receive` or
> > do an `rsync` of them from my NVMe btrfs. I hope the HDD will have
> > similar luck and since there weren't a lot of writes to my large
> > volume, I'm hoping that it escaped corruption.
>
> In fact, that bitflip seems to be the only corruption (that matters).
> Thus you can go "btrfs check --repair", and still use the fs
> (if after repair, the fs can pass btrfs check).
>
> >
> > Thinking out loud here, with BTRFS being so good at detecting bit rot
> > on disk, could that be expanded to in-memory data structures kind of
> > like RAID with checksums?
>
> In fact, if you're using newer kernel from day 1, then such corruption
> can be prevented directly.
>
> Newer kernel (v5.15+?) would reject any write that has obviously bad
> metadata.

I was on v5.18 for a while (months, maybe since the backups stopped).
The backups before didn't complain of empty streams or anything so it
probably happened between then and running v5.18. I created the new
NVMe btrfs filesystem on 6.0, but the HDD filesystem won't mount on
6.0. So, I've got to decide to go with the demon that I know (boot
into v5.18 and try to get things off), or the demon I don't (repair
the fs in v6.0 and hope it gets better to mount).

I enjoy exercises like this to learn more, but they always seem to
come at inconvenient times.

>
> Thus in your case, it would result a RO mount, but no such corruption.
> (But of course, if the memory bitflip happens for data, there is no way
> to catch it)
>
> Thanks,
> Qu

Thank you,
Robert LeBlanc
