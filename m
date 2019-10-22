Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7040AE039C
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Oct 2019 14:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388970AbfJVMLr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Oct 2019 08:11:47 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:35325 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388968AbfJVMLr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Oct 2019 08:11:47 -0400
Received: by mail-wr1-f53.google.com with SMTP id l10so17371295wrb.2
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Oct 2019 05:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7w+7mr+V8DaF5QjormjKnCAC4FGJMCTV3nvzhDCo9SM=;
        b=nxM2sUv3oXFbjgMThPdIvLhl55AdxRwnkG4LYLoZ6SrwFfAVCdENFYAmRp3THdBQcj
         y2GC10UBjy2YeX32KxvIq7QxJ/YoAqSsnpavsZvSzBJiZs+uQ3Lz+StA6xC/3Tv/gtr0
         G9269ns6s4aA1d4oVLFDi6n/TKR8WVn0/kwkSNPyh8d9BcvQMnGjSXNGejkD4p40XCWJ
         tWSnSfU8RZ8m27M9jGd0UTxfXR9c7Wz1vLiukTub4RKfdsSx4PTYqmFIKIfNmopofm4X
         LYKnRGr9Kd4OgXnGsJRr2XptRuIBniUTygp0Fpp3hCGNBehM6a6PNFLQhyHLzkhBiSHn
         hCOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7w+7mr+V8DaF5QjormjKnCAC4FGJMCTV3nvzhDCo9SM=;
        b=lDsNWvqB2yT6UUhutd/7KkILjP+AjtbgyuKSDn80yr31jQnsMvf8M7ZThgo05btL9y
         DbQBCgIPRwh4qaJvD1hqSgr1SSHEUflChS+Is5s20ixTLt+r0wNL4iMncNDKkauJCGgx
         iZ0de4zeEsaYUaVXqCo5D6aFg/qhs1nUFd2W8ZK7jG1KYUHCL9wzmkvFTYwAjHe+tMPu
         hNmGbqxQFPbO99ecbtEvHEIdDzTwV2HDCDKjVHX/S9YzfYNyBXXcoWK4PsdudSs6yiHJ
         L0A6rKCmu+c8T/IzxpqRWx90bMN4xXeSc3F3nBMptViYTr3TPtAw/etBgzWUGNbHb0YG
         aeCg==
X-Gm-Message-State: APjAAAWw9XwzcyS3zSS4UJo8i00AYQ08BAI/RrlhEvyKP0jVIodDAGj9
        uqXwu0B5fM197rAMVrd64WQ5a3TJagRLVaY20c6+20kklrs=
X-Google-Smtp-Source: APXvYqyUMGUF85E13g0P6iRaz1Feu8q3Xq4vrRC4AGQs4MV0nOONtEK9b0ebMEYExuZHN0iw7JH7o/4D1viG9I6wQt0=
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr3274561wrq.101.1571746305121;
 Tue, 22 Oct 2019 05:11:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtTPAm6eGA80y9LYc+Jaeo1wB0+vOMvO6B02o5JJKRFrhw@mail.gmail.com>
 <20191022163344.19122329@natsu>
In-Reply-To: <20191022163344.19122329@natsu>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 22 Oct 2019 14:11:26 +0200
Message-ID: <CAJCQCtQpkDOsZsWqq4Gc7rXyDpTZSqFdBs6X6qzSpMcEtuCG2w@mail.gmail.com>
Subject: Re: feature request, explicit mount and unmount kernel messages
To:     Roman Mamedov <rm@romanrm.net>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 22, 2019 at 1:33 PM Roman Mamedov <rm@romanrm.net> wrote:
>
> On Tue, 22 Oct 2019 11:00:07 +0200
> Chris Murphy <lists@colorremedies.com> wrote:
>
> > Hi,
> >
> > So XFS has these
> >
> > [49621.415203] XFS (loop0): Mounting V5 Filesystem
> > [49621.444458] XFS (loop0): Ending clean mount
> > ...
> > [49621.444458] XFS (loop0): Ending clean mount
> > [49641.459463] XFS (loop0): Unmounting Filesystem
> >
> > It seems to me linguistically those last two should be reversed, but whatever.
>
> Just a minor note, there is no "last two", but only one "Unmounting" message
> on unmount: you copied the "Ending" mount-time message twice for the 2nd quote
> (as shown by the timestamp).

That's funny, I duplicated that line by mistake. User error!


-- 
Chris Murphy
