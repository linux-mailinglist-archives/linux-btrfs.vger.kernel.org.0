Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B752D129042
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Dec 2019 00:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfLVXXo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 22 Dec 2019 18:23:44 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34575 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLVXXo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 22 Dec 2019 18:23:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id c127so5951742wme.1
        for <linux-btrfs@vger.kernel.org>; Sun, 22 Dec 2019 15:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MlVTo3JrvFL4OpeGwsdg49SuQcI+Cs3cdhK4BkDa0rg=;
        b=DW5nqbqmPdgc+oaLVSDxaotPmVa3tOrg+1eRbO7AjppHOrTSXLRFy5mH91LMPzqdJY
         6292jdLGcopV2qvpnQqxLOfueSyPFpYYdxbGajtjdpBkd/3SsYzKkD15ryYS0fctiY43
         ng2s56aGE5kNMZ2WR3ZoiYNJJCHWfarrAOui/kH4pSaDLVy7URYThBjVPbwVOdKvHkXD
         9TLDFKTvePVXjmlvM1uRLsJnb17toJmi9/ETzUz4WaqbX/ehqwGqGK1KMHQSnwFFkjF9
         LCaB2OD6f+yg5LecSKCxYhsZqN5P31yjpeCn/EgAyBR9AHzkpT8AfBxQWNwktsk912Wf
         X9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MlVTo3JrvFL4OpeGwsdg49SuQcI+Cs3cdhK4BkDa0rg=;
        b=jnwNuquhsUrySrPq4UQTuIxgN+hFkMFRnuIs6lsP0O3GO9xQSJishsvMs/nH/uSZ3B
         Px9DyuifBjuk5IRP5IdJCx1cLzGGTw9vE0Lc+UC9QOGjORoKrBp95ReQfHXnwhmfmem/
         1dMm7hfJgSuclgIAcimC8hJMUy0BdfTIQxcrRRzERqSfEf9wUQaJWRyXFzqEvx6XxlFK
         2fVFaeeWNURTywXzkNOX35z2L3GvexbV3+HFqRuUtYNi2jTTK01p4wl5+OHFIBbklJOe
         UF5uj9LzDcmoODB+Gsdsxa6n/b6zs5wnEomhUVdrqKBNBIJodZ103yveHVYE+QwZl2+W
         U22Q==
X-Gm-Message-State: APjAAAWArBlEwU0Gh6lanzOox2j8U9+8mFoKWQ/zgjirA3462LSOMvzQ
        uryBnKfimjOS5xYsZtqYrPDoUiOe522zG6A6YL26Hw==
X-Google-Smtp-Source: APXvYqxE7/MUGHE5dpcJvr0ZKE9touqge6h5eeygC1fk6hpZrRHBszKvg35jo8Sa7YpZgF2hy1ArK9YunXctwuakluY=
X-Received: by 2002:a05:600c:294:: with SMTP id 20mr27789628wmk.97.1577057022022;
 Sun, 22 Dec 2019 15:23:42 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtTQ-xkWtSzXd14hb1bmozg3U8H2pxQMO7PqEJjymCcCGA@mail.gmail.com>
 <c246f5e9-c9b6-8323-9e2d-26f17051df6a@toxicpanda.com> <a6b6cfde-d5df-b68b-cd57-edccc970ad64@suse.com>
 <5e910a0e-2da8-72a0-fa36-7d48f2454ca4@toxicpanda.com> <a6488349-301f-1071-0d96-4970ca50c3cd@suse.com>
 <20191223001512.6477bd8f@natsu> <CAJCQCtSDxOa29cTNgr_cpJ5vT0boKRz2+nHLv2oUHiWYrGpkag@mail.gmail.com>
 <347063a8-d0d9-4fa9-564c-17f7e01121cb@suse.com> <CAJCQCtR_0sAw4EZGgfVe4YsV+XSgKefbpu3dANEkRp-YUSGZHQ@mail.gmail.com>
In-Reply-To: <CAJCQCtR_0sAw4EZGgfVe4YsV+XSgKefbpu3dANEkRp-YUSGZHQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 22 Dec 2019 16:23:26 -0700
Message-ID: <CAJCQCtTwMivK5D4vGRs6qPpXau_HoXdt76sz3wqiz55V8LbxXg@mail.gmail.com>
Subject: Re: fstrim is takes a long time on Btrfs and NVMe
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Nikolay Borisov <nborisov@suse.com>,
        Roman Mamedov <rm@romanrm.net>,
        Josef Bacik <josef@toxicpanda.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 22, 2019 at 4:14 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> fstrim on this file system results in 53618 discards to be issued.

Sorry, that's only for one of the CPUs. blktrace recorded four files.
So quite a bit more discards than that.



-- 
Chris Murphy
