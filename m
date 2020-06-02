Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6171EB406
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 05:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgFBD60 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 1 Jun 2020 23:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726069AbgFBD6Z (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 1 Jun 2020 23:58:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA64C061A0E
        for <linux-btrfs@vger.kernel.org>; Mon,  1 Jun 2020 20:58:25 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v19so1470488wmj.0
        for <linux-btrfs@vger.kernel.org>; Mon, 01 Jun 2020 20:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=isff1leaJ8j/qlQccnxByG4Bk0AZg7anChHntnG3afY=;
        b=rgPQO72jyMGfqOZueW7tP/9mXysyP86+7OmRPyFMqEUNs/7JT9LJ7Pp+OK4N3wLn+L
         fra6PnrMi4c1txPB6haAh4nqBQKagpqSXX/2eLWcBDT0Nwgvxju6NUVku2/viT/COU3J
         PIqdEXCsSXQUNFHY4oB+/TOh117YrIz4wvTikguLHANdxt4JPfkXvSdjUQxNG2ysdVL0
         koGiRNT1qpTJJ87eob80U6Ptjf90dB3PPpkwXLj1UIjCwseZu2w8Z2W0sP7wDxp6YUmF
         DdfixW9ZrfmqO0hsQGdoeceyOsjWY8e2jkuQyRxNV/E/osp8gJMNsQ/TxF6ELq+tOYSx
         PvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=isff1leaJ8j/qlQccnxByG4Bk0AZg7anChHntnG3afY=;
        b=MytPcaxejek99PVfKsnM9qLYFBuWXq3js2KJWvzZTBzkgg3gyMqAZEMlhf1155Wgs4
         dbMHf2m2FlwtnN9pZQVR7dYnFYEZn8DpgDeAvo0bWHJ+qvYciSa+FCd0Inxdb6yyOTSb
         WiqwCy4Nn4dqBA1TwlJLefkz4v6G/nA/VKXQfApEZmbEgKxF0rz0G4cZvJJD0yfg3iCU
         sOnKq4LhDGs4m0wlmblDDG2CF8CxQd+C9B5vxJ+A7kgeIGTE2K/s98fWV3E15jbTYRon
         +8UikiPsJ4r70aGfONh5QpHFot4EVI+OMmYLyDxcdsfV0EqpEjgFSPkkNS7Q29YBwzKb
         LaLA==
X-Gm-Message-State: AOAM532/YHiY32IUAsigwyXIOVqPG6VrUOXwVeelju8StyPZ3CzF9Gxq
        R0PYtTNOEpbrHgk44X3DdKj+RYJ/5NIxTuCin3XCYJQ8kzZIRw==
X-Google-Smtp-Source: ABdhPJxPP6Safk+g21OWrz8LqGsGOU8Wi9JYE+vr0odq/F6WpeE8LD/1x1QO6y5AOnqiqKrI3DzkMmbT/ts+3xdnjYc=
X-Received: by 2002:a1c:143:: with SMTP id 64mr2296514wmb.182.1591070304307;
 Mon, 01 Jun 2020 20:58:24 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR02MB44274C6B16F173291A82C4A8C98A0@DM6PR02MB4427.namprd02.prod.outlook.com>
 <bf3629ad-730d-3808-38e5-8c42eccbaf5e@gmx.com> <DM6PR02MB4427F7962A6FD26BC147B4B2C98B0@DM6PR02MB4427.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB4427F7962A6FD26BC147B4B2C98B0@DM6PR02MB4427.namprd02.prod.outlook.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 1 Jun 2020 21:58:08 -0600
Message-ID: <CAJCQCtQbORJDhYdeuhANCvk41RxeOBJjNRgh1yfa8LtuKY8iwQ@mail.gmail.com>
Subject: Re: Massive filesystem corruption, potentially related to eCryptfs-on-btrfs
To:     Xuanrui Qi <me@xuanruiqi.com>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jun 1, 2020 at 7:52 PM Xuanrui Qi <me@xuanruiqi.com> wrote:
>
> Hello Wenruo (and all),
>
> > Any log on `btrfs check` without --repair?
>
> This was all after I reformatted the partition, so it might not be as
> useful. But as you see, `dmesg` reports 14 corruption errors on
> /dev/sda1 (which has been functioning correctly) but `btrfs scrub` does
> not report any problems. I'll do a btrfs check when I boot from a live
> USB.

[    3.464079] BTRFS info (device sda1): bdev /dev/sda1 errs: wr 0, rd
0, flush 0, corrupt 14, gen 0

This is a persistent counter, not a live event. So it's probably old
if scrub isn't finding problems.


-- 
Chris Murphy
