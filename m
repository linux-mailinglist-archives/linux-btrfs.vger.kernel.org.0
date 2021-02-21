Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B45B4320819
	for <lists+linux-btrfs@lfdr.de>; Sun, 21 Feb 2021 03:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBUCWD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 20 Feb 2021 21:22:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbhBUCWB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 20 Feb 2021 21:22:01 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597EBC061786
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 18:21:20 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id w1so99373qto.2
        for <linux-btrfs@vger.kernel.org>; Sat, 20 Feb 2021 18:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=85MiQaM3Rk2cX5WbsPt0ztr53aGFzPdtOqWQmDBfm0o=;
        b=KPAdM6y9pkulWcmW03dB2feWf/EwUQJ0O1wM8W0CkQzC7v/wadFug7JyykAxLjBGus
         cIZfMrUy4LaHE8f2LdLeaafCKY83wL7qKbegVrF9APwMmWdvJeXcQReHJlDD5uGjDnC7
         mX9Dienl9f6Lf6av7QlR+WcUlwjMDPOGu7j9G50WhrSYJF3W/kw2oD2t+1/PosW/nrUy
         uk+bfKKa9OQ4H0Lim1BI4CuXhs0tSaOAOQS96Zk5KPpef+S7RFqZfQS5ujacNiPrfiuL
         Aa0ugHNFkOo+/KO6bc9Czca5HUq+Ids+knJqoAcZmaUWRr4BEk4uKjn5uAMIULf7ntZl
         v9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=85MiQaM3Rk2cX5WbsPt0ztr53aGFzPdtOqWQmDBfm0o=;
        b=hKNFuMDX7+Lnx61gvNLZXxJBKIKg+ektkoH40E2uIeZf2nDHeizm9DnMAcvjy2N9Ot
         piEh1WkWnfI+rHmGhyQhHjOEZV8uhux35ShWvZqi1MZfL3SPIrAPdz2e25nERI6GySd+
         xUZb1//JILAml9H6cxAf1X1t1oXhXB/d9IkBQpY+gDQT19udqXqHcg4+iXmKPMJSH6Lz
         BYG1lxg0jyvMkLzigWOZ2T+kV9HfLZ3+8HS9yr3gdU8swbpL2DHmRs6CxT+39DwFnrmF
         V9oUo+t1n+fQgvDfwLs4tazfx6Hh3CsoOJH38+0BWtWkYpy3HQ9N+n55aUOSv92F3M2z
         p41g==
X-Gm-Message-State: AOAM5321zrM4MrakeAQTGiwXBkTmzV+4YSZaIPb64ToEIds2YCGVXsW4
        dVb2GOfRjMLlfFe0YdmGyp3wx6q4WqH7m3e/ngu6udETPFPQ2w==
X-Google-Smtp-Source: ABdhPJzrIHE0L9G0cE3Mko+U4RAG0p3pEIBNOD9eb/cDynrWcY+oMzJt9rXE5bccl0hHLP++2qdMTtbhEJVo0GNOX8o=
X-Received: by 2002:a05:622a:93:: with SMTP id o19mr15227590qtw.336.1613874079633;
 Sat, 20 Feb 2021 18:21:19 -0800 (PST)
MIME-Version: 1.0
References: <CAOE4rSyacNvoACo7+CYc76=WFS6XYtKMJg9akV61qfnnR1uTGg@mail.gmail.com>
 <20210219192947.GJ32440@hungrycats.org> <CAOE4rSwPALKbk8Wv4eqnapbXKb=MeG2gYmGezWybx-mJ2ZPXXw@mail.gmail.com>
 <CAOE4rSyf06YjongJ2h1tpMXJeYj6wGV7TKV9AK_c8M1+7o4NsA@mail.gmail.com> <2a600c23-eb54-6b4b-70dd-8053ed210601@gmx.com>
In-Reply-To: <2a600c23-eb54-6b4b-70dd-8053ed210601@gmx.com>
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Sun, 21 Feb 2021 04:21:08 +0200
Message-ID: <CAOE4rSy+NOUh3SUwO-HQLCsT4gdO+vkZ76FD9teV6jm17MYheA@mail.gmail.com>
Subject: Re: ERROR: failed to read block groups: Input/output error
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

sv=C4=93td., 2021. g. 21. febr., plkst. 03:08 =E2=80=94 lietot=C4=81js Qu W=
enruo
(<quwenruo.btrfs@gmx.com>) rakst=C4=ABja:
>
>
>
> On 2021/2/21 =E4=B8=8A=E5=8D=889:03, D=C4=81vis Mos=C4=81ns wrote:
> > I just found something really strange, it seems pointers for extent
> > tree and csum tree have somehow gotten swapped...
>
> Only the latest 2 backup roots are supposed to be correct, older ones
> are no longer ensured to be correct.
>
> This is not strange.
>

Well here it is latest backup root, it has the highest generation but
looks like it's not issue as it's not used.
