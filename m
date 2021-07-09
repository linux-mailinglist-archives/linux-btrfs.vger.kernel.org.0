Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8B73C274B
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhGIQJI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 12:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhGIQJI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 12:09:08 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD784C0613DD
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 09:06:24 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id x192so15446667ybe.6
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jul 2021 09:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vuzbK3Mkq8rG/4RTPs/yrULKbinV4x88PtppZndM2SQ=;
        b=Wj+FPJEMfWGLo3fnF5rk9bt8IaDqM04KJbvHdOTkgEh0RhQx2HMKMY4BqfsJ3vn70b
         /7zD5X5BE3VDsySWyBd6A5FHv+LlGqb40Eb1bzPfnFjBuqb7pi1YCnqoMbdY9PDRETP/
         XOuoz6YBcS1GpPiP91vNjVRwUkLKGuraXi3Cdh/OOb5IdhhqCIWCeSP0j1KWPjoEkaBH
         IpvL45pGCTfzM2o6OLNLzKl8RRM2dQLRHiAvVmvkGWZGmXVD+hfDza++huaz5cbDnUOc
         rpD2uzTPumColO3FqD8xYycAzVkSG+zoh/O69uc2pMs5N3E2c1p1NgH3ZwabLrXFKwoU
         PvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vuzbK3Mkq8rG/4RTPs/yrULKbinV4x88PtppZndM2SQ=;
        b=YqZ9zdYvnojAydAD/Ooi2ydL8M0WzAI9sni1uC/Gp5AB2DE9hQKytMl8ereG1PVxzV
         P3Fh56ijLw3nvGBv/1qPTSjca9XCHZaElXkH60dIKRSXS6tpPrd7kL/2Sv8a8+S7Me0H
         V9cczDKKNeSIX22DIW8l3KiH8D/G2n0QTgBNeTJmIhT1tQDOTS1kuuggkZaXJ8G4/tHp
         H3qZCFzZ06XH6qOiKqzg+znXXNbaEKbMst2LnGwjosYJpzVjezSfE1VAhH/lF3SM05k2
         a35SRluKTc8tYlyYPC2DR/oKeLRVRa83q1tfZuH4Wg8/bQDOhnyqZcYmSRES5umxF5px
         4lyQ==
X-Gm-Message-State: AOAM532whAmk67NYUvcgzy6MvVe+bdhPlTPO7T+9m2DlRngX3+FYF1NM
        MPoBHuNI/ITWy0APQ8wsLOSitRMixVaHL1Z20Y5sZ7A7
X-Google-Smtp-Source: ABdhPJzHqP3vSRspkY3IiBBvPTRng0I4xU9CIUuGJNRjmeGquZF/XbOHqc4QTEfZLwyiv0Y8Mjs+8HocL1vfrGrhDKE=
X-Received: by 2002:a25:c050:: with SMTP id c77mr49555391ybf.223.1625846784046;
 Fri, 09 Jul 2021 09:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210310074620.GA2158@tik.uni-stuttgart.de> <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de>
In-Reply-To: <20210708221731.GB8249@tik.uni-stuttgart.de>
From:   Lord Vader <lvd.mhm@gmail.com>
Date:   Fri, 9 Jul 2021 19:06:07 +0300
Message-ID: <CAMnT83vyufNCMDQQnyYi-k8dOft3_bc_2L-rgHOBzeWgKqPt2A@mail.gmail.com>
Subject: Re: cannot use btrfs for nfs server
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, 9 Jul 2021 at 01:18, Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:
> I have waited some time and some Ubuntu updates, but the bug is still there:
> > > When I try to access a btrfs filesystem via nfs, I get the error:
> > > root@tsmsrvi:~# mount tsmsrvj:/data/fex /nfs/tsmsrvj/fex
> > > root@tsmsrvi:~# time find /nfs/tsmsrvj/fex | wc -l
> > > find: File system loop detected; '/nfs/tsmsrvj/fex/spool' is part of the same file system loop as '/nfs/tsmsrvj/fex'.

Can you try exporting NFS share with 'crossmnt' option?
