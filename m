Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7216482615
	for <lists+linux-btrfs@lfdr.de>; Sat,  1 Jan 2022 00:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbhLaXKP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 31 Dec 2021 18:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLaXKP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 31 Dec 2021 18:10:15 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A939C061574
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Dec 2021 15:10:15 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id e202so40401684ybf.4
        for <linux-btrfs@vger.kernel.org>; Fri, 31 Dec 2021 15:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wey99hSgAQ2gLV5XEWazTEn2z3FAb7ChvGXASj1X3A8=;
        b=r8FDK8D9GkgwKqEH8vTt5XbDkqIu2bjq26F8OxeEP8aHBaUQLUjYip97GiDUw1GS1m
         uEh/OTvjPg1D5RBm4Ta/IOBLK/tiLbc7vEnuqkPXou7WijtABsyUdCqrsiGVErRYvBu1
         buIRsm2iM5bOZIRFuz2TmEsI0pLXNCfJV0PuIlNPi1s7rONvxEwksWObQQSYwGix0d9h
         OKsrwKWRVGhv2z5HevAJsx+cEx1HExEPRfIgGTwHR093FdV7ptVX3K0MZJjnspNo/+Ft
         CovNZOYo92AQn+n8mdHr8TK4PxFwti2GJMUqxS0oUkkmJ6s6mx9H+HsrM5KaL/aQVfE9
         n+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wey99hSgAQ2gLV5XEWazTEn2z3FAb7ChvGXASj1X3A8=;
        b=ArY7tL+qN4+sl1+kdZ5xnwIfKg0hQPlHT4Q46pEFfw4zjKFDteYy7CNQZeOal7j+5Y
         0PAd89PaVMdJS2nb1p1j5bPDSpb/DGzzRCQqdxb0XCqqoENLrHgHdnjpt1cSFdUyhMK1
         kG/tg344rewl35yw2HdIsJyqTeMACKB5wMBme1V9Db+QLpdjkiRHPYc118aPPYXL6JTr
         W3U/NvXU3md51C3aQwvIxqBxHz+mZ7Ye3GWxlubk1JP5ium/H6FfslE7tZFSaWZ81JiN
         CzLQV9AWV/SuBkNmOo2YDgfkoT1ZYPZpJvTqzxGuzQtvU4IYG4SO5anqXB1Au1JfjJTS
         N4pA==
X-Gm-Message-State: AOAM530oj7VCPkjbVOqu0IDMnLi4fZQuvvOXLg1h753wZav6OcXR9eRV
        Oi3snfZd6IeyqHf5RhQYvaTO+YLGQjajzKgOT/qvKGfb01ZZ/cnu
X-Google-Smtp-Source: ABdhPJzxzmTz8uN3tm9oEnCHTbRVvxa3cIUCacdRBNi8GZ6ca872IM6qzsdwfLV8FCN7KN4Nx6fTvcbccGqT8u4S4wA=
X-Received: by 2002:a25:bb07:: with SMTP id z7mr9606725ybg.509.1640992214068;
 Fri, 31 Dec 2021 15:10:14 -0800 (PST)
MIME-Version: 1.0
References: <c0c6ec8de80b8e10185fe1980377dcc7af8d3200.camel@ericlevy.name>
 <Yc9Wgsint947Tj59@hungrycats.org> <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
In-Reply-To: <baa90652685a400aa60636f8596e3d28304da1ad.camel@ericlevy.name>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 31 Dec 2021 16:09:58 -0700
Message-ID: <CAJCQCtRxkZ4NjQA9KrOvb_ybDE-sg_BzzMU=91fT_p8gMEKw6Q@mail.gmail.com>
Subject: Re: parent transid verify failed
To:     Eric Levy <contact@ericlevy.name>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Dec 29 21:01:09 hostname kernel: sd 4:0:0:1: Warning! Received an
indication that the LUN assignments on this target have changed. The
Linux SCSI layer does not automatical
...
Dec 30 03:47:10 hostname kernel: sd 4:0:0:1: rejecting I/O to offline device
Dec 30 03:47:10 hostname kernel: blk_update_request: I/O error, dev
sdc, sector 523542288 op 0x1:(WRITE) flags 0x104000 phys_seg 128 prio
class 0


Can you tell us more about /dev/sdc a.k.a. scsi 4:0:0:1? Because this
device seems to be in a bad state, and is rejecting writes.


--
Chris Murphy
