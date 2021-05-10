Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5B837971A
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 May 2021 20:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbhEJSi5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 May 2021 14:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbhEJSi5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 May 2021 14:38:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1FCC061574
        for <linux-btrfs@vger.kernel.org>; Mon, 10 May 2021 11:37:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id x5so17625095wrv.13
        for <linux-btrfs@vger.kernel.org>; Mon, 10 May 2021 11:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=4Aoj8AEK18DgRsI93ntKdj2U680ZbFouBu8ODBlYn0A=;
        b=gIaBnaNualRdaLCVJPAp0Y20niqflt143ivSyYRIS0x4oa2tAzUJP0oFEGuJFNr/Ku
         ew0XD+a5bcnRKlyglPzg/Uykz8OWoMdjx5u9D/NFCxCgCke+CmJJ7iNWgIjfpRRmJp23
         NUFyLg8kTC2Q0MXpQCCtURdHsB1jvSDc08/RfymBnJ4najs77HeaFjSdycw5Ov9hjRej
         xLehj+EXwPRohK/CoUfJXsW/7++3nqO0muvJpgXSD60d1jiKhJwggCCI62C/s95/sCTG
         L8cXgHRh/3TxSLZnI/yZGuwtxSxR1G0MkckOjvgrzdpCiVPNU+v+i6Bacwtt/rdB0PJX
         G+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=4Aoj8AEK18DgRsI93ntKdj2U680ZbFouBu8ODBlYn0A=;
        b=ep4Sh1YdHU+JzBbs3jVNFyH9PvDOGbQ7UIrFvKhh5mltxxhRR/+BvLbX/vwqQWKybe
         L0dQWYFrAd45Yc/ZKWIWmDEwNXGBbryQUY+bkuIutlhdhl0XlNoiapohWhI9WYxgy5L3
         BsCNkiBcCtQ0+WOctOW764YssVW2iSrJZ5/3T4IehFS9euWwU/NdrT0V4aeC34+8VdDO
         T0uPRplQo0I3Pxyt+eIDq1rfRh2YQ+/RmaoV9BEmrjm9l1AJU6rNUGMnd6uiqZBLXw9S
         dVoTlhFT7qXv+jiQKiOoPeXkihrxpkPu4UN000dU67X/zz5vXEvbpeUb9/egX8iJRPrS
         ekjQ==
X-Gm-Message-State: AOAM533VgRgI1e+M/M5gbhEv7Cb5UVaV5uHgjwRG6psoZpWiqU3fW5hD
        AvGNGNsTLcckJH0w7zvcPMjd+z0tnSWhcCLeUbNfMuU/qlbF6GtM
X-Google-Smtp-Source: ABdhPJzWgPZD0fapkeNZf1/a9bcC+OaOGlOcCEpWvVkufvoNc+IeYoZTewrrd6IBTR3T0aYpc2qtEBItQMeImuqQgBA=
X-Received: by 2002:a5d:400f:: with SMTP id n15mr28450088wrp.274.1620671870489;
 Mon, 10 May 2021 11:37:50 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 10 May 2021 12:37:34 -0600
Message-ID: <CAJCQCtQtidkf2n28Lr2dETV8zcskQtZk5s9tAgGd6XU6sSetSw@mail.gmail.com>
Subject: 5.12, notreelog isn'tt shown in dmesg or /proc/mounts
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

kernel 5.12

$ sudo mount -o notreelog /dev/sdb1 /mnt/0

dmesg shows no messages

/dev/sdb1 /mnt/0 btrfs
rw,seclabel,relatime,space_cache=v2,subvolid=5,subvol=/ 0 0

bcc-tools mountsnoop shows:
mount            4968    4968    1076068672  mount("/dev/sdb1",
"/mnt/0", "btrfs", 0x0, "notreelog") = 0

Seems like both dmesg and mount info should indicate if notreelog is used?


-- 
Chris Murphy
