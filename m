Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8AE1CB9AF
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 23:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgEHVUk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 17:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbgEHVUk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 17:20:40 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E632CC061A0C
        for <linux-btrfs@vger.kernel.org>; Fri,  8 May 2020 14:20:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i15so3530702wrx.10
        for <linux-btrfs@vger.kernel.org>; Fri, 08 May 2020 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5g00r4PilUhbVKB8L7xlfGef0yJyZCBxS69f4BZ9Ws=;
        b=KH5HOfjFnisGVk4eq9saghrNiWPD3UDD7FNAWPAoFCDYNf7SHt39/Q3IsxVjPzEyS8
         g/7sH7+g65dRrLmZGQN6GsSsq4nTS/FKdT97PeCCfPAtZJIbllByWFH9TyNPxngGhZ2w
         Tf/URkcoiayHUcUgB6bl1/PKoPwRcM2tg+yyERUPDu8rVUvr7IUm2OWebw63AQN32IZb
         GCu5XwOTghQHDg2L/tSR0suBMrtUr9PwHzNEOA4oVMApC6WEjntnR5cOb8RUjrDKM9E+
         ZKVaBP2T2ZKtPfRZRLefsIyybcRgt5rFi7U3OWxkxAGaSFnp4zOaqpu0GtO0OrN4M5iB
         ezjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5g00r4PilUhbVKB8L7xlfGef0yJyZCBxS69f4BZ9Ws=;
        b=h0cNNBYx/jKe5xrj/emn/5+zU+UAawkBsLvubBCfU3FcZT+57b1ie+kYijHZmSxTm0
         I6t2WnXeRLGDV2Ko2cA/RLm0xwWVlMjQQczkHQGlJRpA19IyX61hblpYfuRVKromU4Fs
         3JMxWSn27cAS+sHrI0Q83xU/5f/4tOcgCvZ2kqrjM6xVCHp8UdoCFskKhMXfNb0y3ZnM
         pIIEzNkOLZ6FIF/RhlXYnlpnzRF94WKy2LGRGQLqiB61FsYD2CPqGI8QekmC7xJp+AeT
         asQBLSoSZ6Rr+LuZEHnVvnGh3AqNDZ/ELfoYDrlJtH+oIjpqyE02gvElxwwmR5rzMsDn
         Hj8Q==
X-Gm-Message-State: AGi0PuYvYJjg4iU5Wny/ZZzC1gF5MlVdqs141ianFOUEG15++Ak+DzCA
        u661MdmWqGK6cNNpWC2I1k81wVxbfX/+xqXQ6aIOMnsVLuSCxA==
X-Google-Smtp-Source: APiQypLsvwihiRc8gsR+QyLkUwYkvR14Q/N+B2/mzdQzK7PYkFtXyQFTflfHPVpztthNnHS9w7rfhPwJQLjnAR6+ZRs=
X-Received: by 2002:adf:a449:: with SMTP id e9mr3954716wra.252.1588972838471;
 Fri, 08 May 2020 14:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <0d1cceb6-9295-1bdf-c427-60ba9b1ef0b3@sericyb.com.au>
 <CAJCQCtRK+jEMVMz1QPCJCYqCciaaMZ5W+STabrdAQ5RyzWHhGA@mail.gmail.com>
 <7e54f0b9-d311-3d69-94dd-03279aa2dda2@sericyb.com.au> <CAJCQCtT8VUvpo=fvcvhWpSNx_gt+ihk8orkkPuhdQ1nNnSMnPQ@mail.gmail.com>
 <10b14d0b-9f10-609f-6365-f45c2ad20c6d@sericyb.com.au> <CAJCQCtSdWMnGKZLxJR85eDoVFTLGwYNnGqkVnah=qA6fCoVk_Q@mail.gmail.com>
 <709e4c3f-15b3-3c8a-2b25-ea95f4958999@sericyb.com.au> <CAJCQCtTGygd22TYvsPS6RPydsAZoqQYDDV=K4w1yFgTn0+ba6A@mail.gmail.com>
 <8ceacc86-96b7-44d2-d48d-234c6c4b45de@sericyb.com.au> <CAJCQCtQ4xOdNH79XDQdy=ExkNHbpbYdMMHG1fTeN7SeA+dTo7w@mail.gmail.com>
 <8ab9f20d-eff0-93bf-a4a4-042473b4059e@sericyb.com.au> <CAJCQCtQvyncTMqATX2PkVkR1bRPaUvDUqCmj-bRJzfHEU2k4JQ@mail.gmail.com>
 <ff173eb0-b6e8-5365-43a8-8f67d0da6c96@sericyb.com.au> <CAJCQCtTdHQAkaagTvCO-0SguakQx9p5iKmNbvmNYyxsBCqQ6Vw@mail.gmail.com>
 <ac6be0fa-96a7-fe0b-20c7-d7082ff66905@sericyb.com.au> <c2b89240-38fd-7749-3f1a-8aeaec8470e0@cobb.uk.net>
 <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au>
In-Reply-To: <ace72f18-724c-9f2c-082f-cb478b8a63ef@sericyb.com.au>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 8 May 2020 15:20:21 -0600
Message-ID: <CAJCQCtTV5PnJaQLNePrSfcC_aUo0CZgsQHNRpTNd=SLA3xau7Q@mail.gmail.com>
Subject: Re: btrfs-progs reports nonsense scrub status
To:     Andrew Pam <andrew@sericyb.com.au>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, May 8, 2020 at 11:06 AM Andrew Pam <andrew@sericyb.com.au> wrote:
>
> And here we are again:
>
> $ sudo btrfs scrub status -d /home
> UUID:             85069ce9-be06-4c92-b8c1-8a0f685e43c6
> scrub device /dev/sda (id 1) status
> Scrub resumed:    Sat May  9 02:52:12 2020
> Status:           running
> Duration:         7:02:55
> Time left:        32261372:31:39
> ETA:              Fri Sep 17 23:35:41 5700
> Total to scrub:   3.66TiB
> Bytes scrubbed:   3.67TiB


It's obviously a bug. But I don't know why.


[ 1683.525602] BTRFS warning (device sda4): qgroup rescan init failed,
qgroup is not enabled
[chris@fmac ~]




> Rate:             151.47MiB/s
> Error summary:    no errors found
> scrub device /dev/sdb (id 2) status
> Scrub resumed:    Sat May  9 02:52:12 2020
> Status:           running
> Duration:         7:02:59
> Time left:        31973655:40:34
> ETA:              Mon Nov 21 19:44:36 5667
> Total to scrub:   3.66TiB
> Bytes scrubbed:   3.70TiB
> Rate:             152.83MiB/s
> Error summary:    no errors found
>
> I tried building btrfs-progs v5.6.1 from source, but it gives exactly
> the same results.




--
Chris Murphy
