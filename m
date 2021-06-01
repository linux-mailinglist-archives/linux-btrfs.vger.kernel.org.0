Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252BB396DD7
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Jun 2021 09:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhFAHUR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 1 Jun 2021 03:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhFAHUQ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 1 Jun 2021 03:20:16 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA651C061574
        for <linux-btrfs@vger.kernel.org>; Tue,  1 Jun 2021 00:18:35 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id l19-20020a0568301553b02903beaa8d961aso622044otp.0
        for <linux-btrfs@vger.kernel.org>; Tue, 01 Jun 2021 00:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=yGj76un1hj6ZEs43qNpztOU1zUM3o3Jns80H/6xx1oE=;
        b=OHkdTkt6dRyqnZ2r6QO7+7qLhM/CWgOWng97pq769vlMVy4C0GId0r4VMslZqD/VV9
         CMDKersCRvvVsu4XNeg9c+wkJD+gD9fUW6s95+qU4WuCjg0n4udy6lKOf+QQDaH9QAky
         Y5WhK/PDalRRCNCmWddRuwVwsur+XjAjpV3A7u7taNAswDKNlS9xTO03jrbmsZa8rToD
         W6kNQ9iRBaJOHFa/6tRBW3krLTRP/8VA0VYD0NwAwCVs2cV/5jWB62FmoFwq2Ilhbt3Q
         g76DDn9itmzrYQpRE4Glsq2LmMhrnRxMlvGr3Zj2wlWbjwCJUZEvSHh+7/0R218S6wU5
         GCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=yGj76un1hj6ZEs43qNpztOU1zUM3o3Jns80H/6xx1oE=;
        b=eNwDs2oH3sEH/H+WSroU5pMV8TLN1K+7uDui40+6yMpSmeZhYXp60ByYuB45TDBSeg
         QDHiN/d47KzpUmMwem7GpJQk0YMI2rTyAzVwWZR8feVgTsbxnHi0YP/KOwl2faoOZYut
         Hx2NPMXTza5ulKXMEKJndiakTDBFSuN6GI3sQ1nPQg/H+njL4NQ9Ml/g2EzeWLCJTanW
         JLgaZVworqsxQfwExRB0CAQTTkiG2oQF5V0jN9Z0i5g9P7JLBeCBct+k7DSOjJ2aWHPx
         vgcFMIlH3Vq95jzgbq8sCMId1fncug8+iru6EUX30+Hrc6ShOQjrwIE8QJJZlK6KuGFw
         PV3A==
X-Gm-Message-State: AOAM531yMWrRlnvvnWMopmlXnD9e/uj7mj59zD0KzcS7f1qqEfGPsOJu
        OQ27N9WflKNi6EMSF+jgy5Zn2Uo7JWhUr+IFdWp/h2b1/1g=
X-Google-Smtp-Source: ABdhPJzKPEtJutsQ0S6KZsCvSlIRPHJC4FIv3kpnOkYeFlnpgirXaJd69Th1Wu7cu3W3nnXUidU8qdbdNL/IvIcv7Lo=
X-Received: by 2002:a9d:71da:: with SMTP id z26mr20748994otj.41.1622531914829;
 Tue, 01 Jun 2021 00:18:34 -0700 (PDT)
MIME-Version: 1.0
References: <CACEy+ETCvJ+cKn6N4maL0Dq1608pKtCXYSX6CO0oz4B8X1=gLw@mail.gmail.com>
In-Reply-To: <CACEy+ETCvJ+cKn6N4maL0Dq1608pKtCXYSX6CO0oz4B8X1=gLw@mail.gmail.com>
From:   Sampson Fung <sampsonfung@gmail.com>
Date:   Tue, 1 Jun 2021 15:18:32 +0800
Message-ID: <CACEy+ETdogdch6VC9KijA7gfbgR0bCNG9mXfhwCuUkXQr=u1iQ@mail.gmail.com>
Subject: Re: btrfs send -c: ERROR: parent determination failed for 330
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Typos in 7 & 8.  Should be:

7. send A10 over by trfs -p A0 A10
8. send B10 over by btrfs -c A0 B10, then error

On Tue, Jun 1, 2021 at 3:13 PM Sampson Fung <sampsonfung@gmail.com> wrote:
>
> My full test setup is post at
> https://ask.fedoraproject.org/t/can-i-continue-incremental-send-after-subvol-is-split/14597?u=sampsonf
>
> In short:
>
> 1.  create a new subvol A
> 2.  create 8 new files in A
> 3.  create readonly snapshot as A0
> 4.  send over by btrfs send /source/A0 | btrfs receive .
> 5.  split A into two subvols A & B, and move 4 files over
> A/file1-file4
> A/B/file5-file8
> 6.  create readonly snapshot.  A as A10 & B as B10
> 7.  send A10 over by btrfs -p A1 A10
> 8.  send B10 over by btrfs -c A1 B10, then error
>
> Why was that?  What is the most efficient way to send over B10?
