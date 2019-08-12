Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6E989617
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Aug 2019 06:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfHLEY5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Aug 2019 00:24:57 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53300 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbfHLEY4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Aug 2019 00:24:56 -0400
Received: by mail-wm1-f44.google.com with SMTP id 10so10883613wmp.3
        for <linux-btrfs@vger.kernel.org>; Sun, 11 Aug 2019 21:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fx5YkSKpXW9eeWhVWAWfO9c+uw1IXP6qZUJ/dyQogiQ=;
        b=iL4EyxkCOWapZbCy6R3m2TmtGivYmp7+/2+wIENfO0/Q1Op5siTYmmHSJixg3pzmpq
         JM2eBrs1p5Yhmpf0+LXslwadzrhkW6ZhYG8Ntk5V8IRA4QrN8uDZX/8jTG4q4U8jC1rg
         YjD8Jt67S8x4vVAyV4vb1ip1tyIjt70MGkE5uyPxBUD6uOGUbDFJQL80QjUEyCbH8eqs
         LNmv12I2I5aHYKgpN5rwbI3UzdAOoM8ZYZ8lUUhH17KqLo7BOToXS0dtCUOfmjnuXPUd
         vHum1/Ls4TWFw+4OwCWY7E7uv57MOZOqF1yan9e6MIMh/wUZgnPp5GPPJyr2pGZn8pAd
         VDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fx5YkSKpXW9eeWhVWAWfO9c+uw1IXP6qZUJ/dyQogiQ=;
        b=Cv/1s+Qsyjdl1Bfn/KwFwfyLKVrWvIaYc5anU/0lYei8kD/PGKD3cSUbxDVgnUeJH4
         GRjLrFwBrFB4X9ZN+JsEuTqvhbyGDu9+sn8RUyQ5tAdORuxH0ZUH8IKuyCdpkp/gWcQm
         dA59EuUxAxHDZHZ1dML8dLSn5peCo+iJBUPBVJMzNNltm/10cbiXYDENSm+3maa/ekG0
         JDbHPA/oiYN9eZU2DYmfHAPygcC/K1IkfS7y8WU3JokBOr/ozzJXszv2W6wU8D6iYYmG
         bqClDoDVUPp+pHk8hXVKng5xywEegNevufGL8JR0PBjMFnmk2isyRVid2fn2eUHzwF2K
         Y/4g==
X-Gm-Message-State: APjAAAXrPcpuVs1HnLuQAP7+AuaOZQEEeG+UGDBl4UQsGNnEaEF4stMo
        IiZy4LNCRr5qmtIHQAg2L2XV1zi56/FuijSOKf4JJUV7q5Hmwg==
X-Google-Smtp-Source: APXvYqycKRQkZn/4Vv/Tvni6rQN/19BS8z+i67oBLWxDZj88jaREjDrbl7cNDDBUb/3IYdRwCX69TPCj48btmhRE45c=
X-Received: by 2002:a1c:a957:: with SMTP id s84mr25521360wme.65.1565583895173;
 Sun, 11 Aug 2019 21:24:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQrLLpX8uZwp2BYfgaF1QPfuf1_XRjVxG24cbDHfEo2uA@mail.gmail.com>
 <4dfdc5a4-a6d7-e96b-afa1-a9c71b123a96@gmx.com> <CAJCQCtT+VnSp_8i-QWT6iwCv9yaqQv2XfsVtsdvQmoG70aQZ7w@mail.gmail.com>
 <afe23216-7d73-4d33-d80c-15d29f24c64f@gmx.com> <CAJCQCtRyStqPLOXHVWkcha3GkA7wt2u00qSH7DfUyL_ift5ppQ@mail.gmail.com>
 <CAJCQCtQ7aFpyQ+g_YWZJCuwuqOSXH-Gany9s-CgEQM6f2RK5bA@mail.gmail.com>
In-Reply-To: <CAJCQCtQ7aFpyQ+g_YWZJCuwuqOSXH-Gany9s-CgEQM6f2RK5bA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 11 Aug 2019 22:24:43 -0600
Message-ID: <CAJCQCtTwxW65Ftiu6Ts3FKF8bKef9cvnOrFrXo8ikvGcwog+9Q@mail.gmail.com>
Subject: Re: [bug] btrfs check clear-space-cache v1 corrupted file system
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 10, 2019 at 5:20 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Sat, Mar 2, 2019 at 11:18 AM Chris Murphy <lists@colorremedies.com> wrote:
> >
> > Sending URL for dump-tree output offlist. Conversation should still be on-list.
>
>
> Any more information required from me at this point?

This file system has been on a shelf since the problem happened. Is
the lack of COW repairs with btrfs check solved? Can this file system
be fixed? Maybe --init-extent-tree is worth a shot?


-- 
Chris Murphy
