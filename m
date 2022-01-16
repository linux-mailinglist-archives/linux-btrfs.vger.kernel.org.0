Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF6348FB28
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Jan 2022 07:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiAPGBK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Jan 2022 01:01:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiAPGBK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Jan 2022 01:01:10 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F0FC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 22:01:09 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id n139so6206829ybg.0
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 22:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lG3F2oeq5MiiUlFMZRyGKgQk8UyOnSaiNg+YHOkTHAo=;
        b=StWi26o2+g9Se+lhrglbm5YKxx9QWumnTijBUP1nBdspqGftQ4KigDCsU4yEB95cr/
         DxbzJ3UsHsDQKUI8+C/txSbwm3N+KVlIghSJ053U4QdWttFKqzNEfZicIr4Gn/cVJpCp
         DxaMkdx8kLfqSdxki8pVDUzJHzB6L088AKAzDrgSPOy53EcXvuYxAZFOrK7MdHP/rZp7
         caXXiwKlUlr39zJ2MAcAXSpedTYsU5UKJzRh+AOrINb+L9ALmjQ69mrMLzEGrVOxFAYV
         58wPp6XKycYjW+aNmByaxfdr5DbpCgSKxvOQtzQ8bq7+miZB0Ik9uD9MVERUfXjISv+V
         2b+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lG3F2oeq5MiiUlFMZRyGKgQk8UyOnSaiNg+YHOkTHAo=;
        b=rNndc59hFLYN+hM6ZcZp5iB8g+7dxUAnRBFIx8BEqqUZa3YeVGu1UrzzPqqB2YUw0H
         uzYt6I3ex5aufJB/ZlHzWacqEGbnXzbTV+cY7Ww9rWbvRMXhGir/CJr6nsq2LlWTqo1F
         y+Gav+t1Foi/CPlqQthK/J8vhadiA7ctgWskvn7hLAxXJvbAhepWHJD2VtL4VgkIvooy
         s1pbi15HLiKdJKqw2VnzpJ+TVVD7V/lbxPuN9/QM3IG8fiev2xqgFUWMObxvXHV3S92Z
         cBTXT81LuiaFtc6x71DxR9RsqE6S6sscWcqA1GEo39EmBBNnw0cw/ANvj2qBKIgypJHM
         4JRw==
X-Gm-Message-State: AOAM532pzAb9gMVMmdGjKGf5ymHLvQ4Xs25pVUxjGnLeKlOlcGBm1Z6Q
        EbBEtCQ0EHihMJg6/3F1Uqrd4FBHJEWmmX49928r8Q==
X-Google-Smtp-Source: ABdhPJwLTx9eYhZ48b873wuLSOwES3a2JNOlHzIO6i5K8cy+X5FMP27WgLqRYaAANXoUvrVjAu0LIOgJ7cCstF02130=
X-Received: by 2002:a25:bb07:: with SMTP id z7mr19414619ybg.509.1642312868763;
 Sat, 15 Jan 2022 22:01:08 -0800 (PST)
MIME-Version: 1.0
References: <20220111072058.2qehmc7qip2mtkr4@stgulik> <CAJCQCtTKd_yMUa_Fr9bGuhPvfYWPuY0=Vs=-+k85gfZJqLK_FA@mail.gmail.com>
 <ba6db0c3-6605-d5d1-de04-051b9f099547@suse.com>
In-Reply-To: <ba6db0c3-6605-d5d1-de04-051b9f099547@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 15 Jan 2022 23:00:52 -0700
Message-ID: <CAJCQCtSDt=Yk_ircs5jS6KVMUACRiMvZPzF4ePDuqfzOibe4xQ@mail.gmail.com>
Subject: Re: unable to remove device due to enospc
To:     Qu Wenruo <wqu@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Ross Vandegrift <ross@kallisti.us>,
        Josef Bacik <josef@toxicpanda.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 15, 2022 at 5:42 PM Qu Wenruo <wqu@suse.com> wrote:
>
>
>
> On 2022/1/16 08:39, Chris Murphy wrote:
> > On Tue, Jan 11, 2022 at 12:41 AM Ross Vandegrift <ross@kallisti.us> wrote:
> >>
> >> Unallocated:
> >>     /dev/mapper/backup      7.24TiB
> >>     /dev/mapper/backup_a    2.55TiB
> >>     /dev/mapper/backup_b    2.55TiB
> >
> > You might be running into this bug I mentioned today in another
> > thread. It's an overcommit related bug where the initial overcommit is
> > based on a single device's unallocated space, in this case the 7T
> > device - but then later logic results in ENOSPC because there aren't
> > two devices that can handle that amount of overcommit. If you  can
> > remove /dev/mapper/backup, leaving just _a and _b with equal
> > unallocated, then try to reproduce. If you can't, you've likely hit
> > the bug I'm thinking of. If you still can, then you're hitting
> > something different.
>
> I tend to believe it's a bug related to recent flush bugs Josef is
> trying to solve.

Hmm, how recent? OP reports this happening with 5.10 series.


-- 
Chris Murphy
