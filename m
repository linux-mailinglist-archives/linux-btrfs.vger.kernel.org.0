Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D441B1C23DC
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 09:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgEBH1m (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 03:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726468AbgEBH1l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 03:27:41 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432EDC061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 00:27:41 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id h26so2541699lfg.6
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 00:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9+QDXcspSrQ6jiqwHUvZJ6lVjvnLNA3VzES+EHK/Eg=;
        b=kisk++ZBPLafrVzX+jXN1o2CFrGJgp09e5DaYQuZn2l9qpRz9fr75I/bP3pgb3kw3I
         HKYUG4gGzM9VniEeeA63/mG5KMYw42YXE0amt7ELABgFugUv2fB6ixye2nfk5Cc0Ay6r
         cwoVk+2BYvzTtFU2NaMc5VX4v5/IzwRXNtbj3djjR8+ib49+4d0yDwy0WCUdxw0DS7Xz
         j6gNnDjc5k3xR2FeliqU9HrpVhZbx3BoJedwj+sAXpu75RVXJjh0sjLu466gvNtkBt0V
         rL4yM6V9390C8pB63RQO7i93YYGbNoBQbC8fx6y+c127Dvz5QRNeBI/C4sxhNKKWYVgl
         uSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9+QDXcspSrQ6jiqwHUvZJ6lVjvnLNA3VzES+EHK/Eg=;
        b=AWaoZfZiqOVOmNpc+QAnVliuY55vYEJB8kHd4qBeBA2qEQOkmOIJAxFKpvyl3nNzk5
         nrBGOfQ39waKG2VoNI8NjvLYScYlzo5qJaqFviBunKFZQwSiMrcnf52yB6kuacGQLr3L
         K50vKAEKre7QGxUDvmS4kLmWNW/SNAXHNuWmh7H5JoyNTFB0kz6fBrBvYWDycJ2cNE2t
         yiSXrWjcV9RGcrLbLbDa2ZOe1xDFffy8KebVSFSD6n4sOAAL02utXKquScY+JByweFdI
         Tj+iZ1wkaNzUuQA0nu2Thsbg7D8BcTCyJ8AH9jGL7HOnlqDd3Ef40IS1lgHGri/6iwAM
         6FzA==
X-Gm-Message-State: AGi0PuaWSEVwq8OIY0pEVOqJhbNmIOAtxQSZOORZm50KQzIEDeYjruod
        NUhX0Bx5TRAtZfrvT/sjKA3JCdnv3cJq/G0hfRNdrA==
X-Google-Smtp-Source: APiQypL+F8A6nz2L58Zcren2Q4U+/h9n/wHUNCZMosxq0CBNd/qr7hnWoP7TjENdmZJbv2ssl13SSUwcTwJ/a+u4AZs=
X-Received: by 2002:ac2:5f73:: with SMTP id c19mr4989879lfc.29.1588404459536;
 Sat, 02 May 2020 00:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net> <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mi62y+9BfXYSmS0-VStGFnqDi8_UkskrdfPg5LsexaRNQ@mail.gmail.com> <20200502072053.GL10769@hungrycats.org>
In-Reply-To: <20200502072053.GL10769@hungrycats.org>
From:   Phil Karn <karn@ka9q.net>
Date:   Sat, 2 May 2020 00:27:27 -0700
Message-ID: <CAMwB8miVfp_vpJaak=W_PK-xYtb=Py1zqqVYXWo_3NN4a9Dk7Q@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Paul Jones <paul@pauljones.id.au>,
        Jean-Denis Girard <jd.girard@sysnux.pf>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> deleted the originals in logical extent order.  Sometimes people call this
> "defrag free space" but the use of the word "defrag" can be confusing.
>
> balance is not btrfs defrag.  defrag is concerned with making data extents
> contiguous, while balance is concerned with making free space contiguous.

Got it. I actually would have understood "defrag free space" and that
it differed from file defragmentation (btrfs defrag, xfs_fsr,
e4defrag, etc).  "Balance" confused me.

How do you balance free space when you've got drives of unequal sizes,
like my (current) case of a 4-drive array consisting of two 16-TB
drives and two 6-TB drives?

Phil
