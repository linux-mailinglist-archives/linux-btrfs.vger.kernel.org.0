Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA9C2DFF2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Dec 2020 19:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgLUSDg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Dec 2020 13:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgLUSDf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Dec 2020 13:03:35 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539C3C061285
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Dec 2020 10:02:55 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id cm17so10460810edb.4
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Dec 2020 10:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=S/Ykl1Wnb0F5ZX0igLAfZhjTugHopV/lmOv1l2/X5PM=;
        b=cjOuKjOyYyv2lkzpqQ1MItKRTCMdHOfWZ7de8e/8LLXPXvSAPQl9D9LGBdNj7LvxCe
         QgmxPhP4UzLwgE81kWcyhbKkTMJydVXK5uk+5lVvAWWJ6/gASp77vf/YL/rXejDKuL4E
         0QcxdSu54z40lr9sUDxS0LX4tFK28VksUrW5zZC2uzmvyvQXkJM9LdQnE13n5oPsdKc3
         zi6+eLrEDoJaIirsAt1IEx8dxCT22cM7vP2sEQH8GLB/ZfUoZSzqYE/wWeJubX3r4Sln
         rT0xooCoAavn6CO2YfaAYsp8gJoc7x1ormRcieQhjEV4K5Jx5AscuF/mcU4ZpIneivGT
         AJQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=S/Ykl1Wnb0F5ZX0igLAfZhjTugHopV/lmOv1l2/X5PM=;
        b=gM9hTc2ThFeATQYBfDkJfx0Nzpd1sO98pvbxxsYPjaVdesWYaLnnlloIOLwmWCD4B5
         PPTrcKA9RNdIETrJZghE2xkIZkOY8c8snNRQNlUNNYL0fyALBJ+T4YkGYHNZdBzaY1sC
         sC/DDOH+uUr8EfuOLFe9WQurRDfpGNi/rsYTRlXeTSiV8nq8JDSdPmzCo4mRgh75LfQd
         Lf5dRxgKtcYhr2bhvxGF1zlDIUEDwvT2wxF6MRbQ1a47klY+zZDHqcPiuKbizaU9IZ2t
         Irtz1TP1oudVNHUTYMlE9YhcaVUo6fyISomaA9OPMWh3b2roF2fA0gdjyk3bff7AYtWQ
         cnsQ==
X-Gm-Message-State: AOAM5304tKoPGrcj9Rsbasj5Dsuf63BGv0+qh1qgpQjfYBOAsFT6uwax
        dvYPoIbbCtoidtoSE89GGdx+ZtfFlcB5xr6uPNzC99DErw7dG02V
X-Google-Smtp-Source: ABdhPJz1C5UPOKixKHhQHgG8tLtDuruGdHF2aYPofLTLxXxa+7zNyJO0bBmFoGBJuCQMoGldsqxKDAVJQWL6wnfRld0=
X-Received: by 2002:a5d:65ca:: with SMTP id e10mr20059465wrw.42.1608573453729;
 Mon, 21 Dec 2020 09:57:33 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 21 Dec 2020 10:57:18 -0700
Message-ID: <CAJCQCtRDT--SzB=CWk1Z1ZY7QbWHd-VFQXL=LjunzTFJV0HZEg@mail.gmail.com>
Subject: memory bit flip not detected by write time tree check
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

mount failure, WARNING at fs/btrfs/extent-tree.c:3060
__btrfs_free_extent.isra.0+0x5fd/0x8d0
https://bugzilla.redhat.com/show_bug.cgi?id=1905618#c9

In this bug, the user reports what looks like undetected memory bit
flip corruption, that makes it to disk, and then is caught at mount
time, resulting in mount failure.

I'm double checking with the user, but I'm pretty sure it had only
seen writes with relatively recent (5.8+) kernels.


-- 
Chris Murphy
