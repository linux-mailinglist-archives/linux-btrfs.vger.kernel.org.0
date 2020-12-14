Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2B22D9541
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Dec 2020 10:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405294AbgLNJ2H (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Dec 2020 04:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404820AbgLNJ2C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Dec 2020 04:28:02 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E477C0613CF
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 01:27:22 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id l11so28428702lfg.0
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Dec 2020 01:27:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=5KCU8wb441dhqjHn2IA2eJ/cj4Tb1hsCRtDK2us90DQ=;
        b=t1Em7w0Rm8wIsAtc2xkqcJJUuj4Xt6RTXRAFPywuvhBmuD4s4Fw6RwLGFXZ5eTKzXB
         V2tBtdVopXGNm5ibhHRCFugtuJpy3tz4bUw5eUaH7IlkTSicLlUyFuVXnQ3IBBK6sN0m
         yGEUjd+v942qet/N11bf0FV/YtN0dcfiWIyKvkLBleZd5C3eJ0A3RW45C+ymaqAxBb9H
         xrZaPHzZOLUMT55hjPKG4+sGb7+sR6fOLqeQD4OwUnCGi6RI9SKSaGagvlA4y/nE5cxA
         iRHGSVcuyfruDStffQGc9gI8/0AVQnJfNweZKZ3AShOtPIw6Rt57TGRGrnGHEPjQDqw7
         44UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=5KCU8wb441dhqjHn2IA2eJ/cj4Tb1hsCRtDK2us90DQ=;
        b=QXC3+MJ4D8QSiz6Thkzdxt1xO+RtgeQgr7xNxYk4tQWQRswkfTHaH8R0Np1RCuUgKT
         TRsfZdlT5K4ZPKGamS4mU6L9nj2eBuqRK0gm0Xvxlhh0EtdU1lzuCYY/JLwGgS3m/IKb
         8Kese4WL8eCTAEP5jnSfJ9jwgaosU48nxJap9k7a3HMqzPCD6ppPQ9MYNrvzuMOirrC+
         LdXu+86yEktoqJdb6fhwIFyhjBgVCj8/tUhXxZs6FLaoiKyx4nFvTrHtE2mGJE+FsRN4
         JqEQNee9DTEIA/faV+UNWSGYPL1TbCS6teD4PZ4L1DzLsIM0Y53YvsL3QgNjYuf5XemC
         VvgA==
X-Gm-Message-State: AOAM531deRmLBQfsA7XPbzsDv+rVbdc/aevOHx7j5yJrbeiHCAyWogKd
        oCnWQRaHHv4hW+cwAS4VYZH1DfurMlcnSzpcaec=
X-Google-Smtp-Source: ABdhPJxkrShbBauiZkKZfjITtBygu+yJzLrhNWmfLvYbDVCNOe3RQ4jBPQ6bRZ2ulWPaPE2G85tTkiPO4kLfwVOugLE=
X-Received: by 2002:a19:c3c2:: with SMTP id t185mr9522417lff.104.1607938041017;
 Mon, 14 Dec 2020 01:27:21 -0800 (PST)
MIME-Version: 1.0
References: <CAMaziXsqG-z029cCTd1BBn6HTm2EDLxsSocSOVs1s5RoK_Q0aQ@mail.gmail.com>
 <CAJCQCtT+sfHjhKn4a+GdT5ktxzuRooxffuoK5M5T8mMbM6o4Bw@mail.gmail.com>
 <CAMaziXtPXvKS=FETe1pU7YecY8Tsxdf5k1Auretd0bFn6mLOag@mail.gmail.com> <CAJCQCtTHiN7dFMeHQh7hhFze9BDcY=042XQ-0ENh3DzMxsQ1pQ@mail.gmail.com>
In-Reply-To: <CAJCQCtTHiN7dFMeHQh7hhFze9BDcY=042XQ-0ENh3DzMxsQ1pQ@mail.gmail.com>
From:   Sreyan Chakravarty <sreyan32@gmail.com>
Date:   Mon, 14 Dec 2020 14:57:09 +0530
Message-ID: <CAMaziXsy4-_5RpN4cxviLX+infRL7-4NmvCEWz_QDA-spfLmXg@mail.gmail.com>
Subject: Re: btrfs swapfile - Not enough swap space for hibernation.
To:     Community support for Fedora users 
        <users@lists.fedoraproject.org>,
        Chris Murphy <lists@colorremedies.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Dec 13, 2020 at 3:23 AM Chris Murphy <lists@colorremedies.com> wrote:
> You are in adventure land. So you're going on an adventure. If you
> want it to just work, use a swap partition.

To be clear my problem is not with swap files per se.

It's a SELinux error. I was asking for help on how to configure
SELinux so it does not stop systemd-logind from accessing the
/var/swap directory.

It has nothing to do with swaps.

FYI, I have used swaps in BTRFS with successful hibernation, but it
fell apart when I restored snapshots.

So I am not sure why you say a separate helper service will be required.

-- 
Regards,
Sreyan Chakravarty
