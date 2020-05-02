Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6811C232E
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 07:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgEBFZL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 01:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726468AbgEBFZL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 01:25:11 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B9BC061A0C
        for <linux-btrfs@vger.kernel.org>; Fri,  1 May 2020 22:25:09 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id d7so1980272ioq.5
        for <linux-btrfs@vger.kernel.org>; Fri, 01 May 2020 22:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3f4iWG5DutksgF6f391QTum3LAEAyFwOwgED5PjZn4I=;
        b=V7a/Fc+Fu1RqGbtQezYLZoUVEvCcXGfJ8ClLNBJpH3cPKbOBtRyhaEJWP46md6UMr7
         HlfSywhGvHNOzB/l30V1C2Y8aHH+Jy5mjmfujYzkoskr0gZAbE1n+6TK3NudxOQEb+4q
         64fQIWe9fQGJtXZiUHiC6FykLAgeryBWpXXvpCc0Qz/Y0kLMM/FkDJuyjZHcQAHBhDtq
         eRqBdxziZECtho09fnoDIP5SufMhpsV/0pAa65rG/qAoLM4OKvt783QOs3F0q/5Bgo6W
         1osVczC25dnUo0xHXnHb64vtOt5JyR9TAuwGmGetgUuL6v1O7uOnj4es/Ah6hmz4jqGB
         gFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3f4iWG5DutksgF6f391QTum3LAEAyFwOwgED5PjZn4I=;
        b=i1hOvLXEj027lfHNsKPgz5gFD2znO6m38txOepxOuGInCaDDO6boEmgJAeMPN7qp59
         FiJFv7nqScFZsUtHq2vLIlTTTgLeGHkeV7LNmue1rKBu1DcSU3UwrYjBFXT4sViDuCSj
         O++g3tceT6TvSr20S+VsNWWVmwQx+74tbUxysYmyndLwHWjBKleQrc3Y/MbxZd7bnkP2
         C8Qq2UN/JRJ1FVzgszym653KrBh0G3RJxGjQq6bu63IJGWO0VATJqW7ctmeGDJbwrtYq
         X2wK0S3cDzvJQMgCjzJLchZtUie0cziqEbsiBW0sFG7OXh5pc0AVoMUCRmZJ+BNQq8qI
         E7LA==
X-Gm-Message-State: AGi0PuY4vDsDtM8Jxnn4OAJHM+sEI027yhxNmf2pzZaluuX5xRUVWKrP
        rEiNHBY3Fd+YDpx3VYg0Q88KU3gYWw/HCcKFkYXOZw==
X-Google-Smtp-Source: APiQypIQXjSb57ezwCL+1JhYUyx3P7eCncXjCgs3lc+NXNGjQ2ruuwHVCy3LJZX97jIfzvh+S9H9H4uXgBmxZ74Ah+A=
X-Received: by 2002:a05:6602:5db:: with SMTP id w27mr7003623iox.152.1588397108600;
 Fri, 01 May 2020 22:25:08 -0700 (PDT)
MIME-Version: 1.0
From:   Rich Rauenzahn <rrauenza@gmail.com>
Date:   Fri, 1 May 2020 22:24:57 -0700
Message-ID: <CAG+QAKXuaah3tkhQLd7mD3bx+pc3JZdXkUg6yr0R8=Zv2vXnhw@mail.gmail.com>
Subject: Western Digital Red's SMR and btrfs?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Has there been any btrfs discussion off the list (I haven't seen any
SMR/shingled mails in the archive since 2016 or so) regarding the news
that WD's Red drives are actually SMR?

I'm using these reds in my btrfs setup (which is 2-3 drives in RAID1
configuration, not parity based RAIDs.)   I had noticed that adding a
new drive took a long time, but other than than, I haven't had any
issues that I know of.  They've lasted quite a long time, although I
think my NAS would be considered more of a cold storage/archival.
Photos and Videos.

Is btrfs raid1 going to be the sweet spot on these drives?

If I start swapping these out -- is there a recommended low power
drive?  I'd buy the red pro's, but they spin faster and produce more
heat and noise.

Rich
