Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3794644DC73
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Nov 2021 21:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbhKKU1Z (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Nov 2021 15:27:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhKKU1U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Nov 2021 15:27:20 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80087C061767
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 12:24:31 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id u60so17989962ybi.9
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Nov 2021 12:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=Qvece8PZmbspgJR3Zxru9iTtFer0lwJEBdhfE9Fkq80=;
        b=lAGpr0DglWoA/pRbaAyDtj/5N/gKcrL5ru4TswKZshgjvfZGrz8fbJJ3UctcjZ5JKO
         JCRr9LtFEXIzBtREmNmdoKJVS2Kqiq3RNIlZ4nlgod3+9W+jV/kjBTm8T9GQmaPa/Ahy
         pvgvIHdwTO9PtHvao8BcfCxKpfwTUrucGJcIY90i8sK51acGp/zh/WrdwJrjFHwf7yrk
         bBumt+NATBr6ngha6Bcfsei3cWUoy7P2z8cd1QObz3cl63IKtO90ycLM/FZYJDYD9glM
         yIC4rCHv1K1Esh0emrcy2G6KE/TGANSmHyv8nJbdT1exLkqdmsY3HWvfPgzIPhEPwgl0
         XD2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Qvece8PZmbspgJR3Zxru9iTtFer0lwJEBdhfE9Fkq80=;
        b=puuFAdbar0fBYo295ydm+VN0ZE2l63oEb5rKLSg4TgN9GqFEMn3bZIuLIdRvJGVWF3
         y5nCrlKgMtDlZLFY2ZLeZ1YT6kof2QhmK91lBwQ4oxc80TJF0gpeuAIg93Iice2sPwrE
         vyb4EjgERnhPmAdGCYcVQz7iMtZPLpgsBExtdnR6N08SemkJBkjyyQW7Gx9OiGVGNwkH
         uauxJbjNTJ5p6tNqe+6sfGyNaM0r0cuVrxb5p5phlOAeYjQchmYt5UTR6HXNHsMX68FP
         chb7VfqE/TJVzrwuQvJ/MwG7lCIifB7YyvUCkgeADLzYpTCOf5Nktu/DGcmHEuMwwUFy
         5QLA==
X-Gm-Message-State: AOAM532EzNgQAml9NVsNPgEtBgtPzc9sXfhcGa47k2pQcfo7ZCyhmL/f
        H2ppq8ug1F1pusVe5UB08kuddkzSE8Vsc6FjjYvqsxWvGh2jyCVV4hU=
X-Google-Smtp-Source: ABdhPJyvapKveU7blL/sdUFkoFETid69sVADg86ag7QAeGCQowEZCr1BE404ZWmI5Xy0ziqPqKvJf1TwY7rOZ1m5bI4=
X-Received: by 2002:a05:6902:1021:: with SMTP id x1mr10782593ybt.391.1636662270654;
 Thu, 11 Nov 2021 12:24:30 -0800 (PST)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 11 Nov 2021 15:24:15 -0500
Message-ID: <CAJCQCtSh2WT3fijK4sYEdfYpp09ehA+SA75rLyiJ6guUtyWjyw@mail.gmail.com>
Subject: 5.15+, blocked tasks, folio_wait_bit_common
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Soon after logging in and launching some apps, I get a hang. Although
there's lots of btrfs stuff in the call traces, I think we're stuck in
writeback so everything else just piles up and it all hangs
indefinitely.

Happening since at least
5.16.0-0.rc0.20211109gitd2f38a3c6507.9.fc36.x86_64 and is still happening with
5.16.0-0.rc0.20211111gitdebe436e77c7.11.fc36.x86_64

Full dmesg including sysrq+w when the journal becomes unresponsive and
then a bunch of block tasks  > 120s roll in on their own.

https://bugzilla-attachments.redhat.com/attachment.cgi?id=1841283



-- 
Chris Murphy
