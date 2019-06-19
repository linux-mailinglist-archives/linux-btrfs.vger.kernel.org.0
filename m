Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA2EB4B78A
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jun 2019 13:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731602AbfFSL7Y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jun 2019 07:59:24 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:42933 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727458AbfFSL7X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jun 2019 07:59:23 -0400
Received: by mail-ed1-f52.google.com with SMTP id z25so26781062edq.9
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jun 2019 04:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KWpkUa8oW/Ki/fDQwZ9WyBGwrRdAhUzYNB0KMOC1nSA=;
        b=E4uZOm6vEox8wuMtPmtFUu2Mh3I6819tWJAi6vnz62X+s0sxMegVEzsUGg5inmR4xZ
         Hfb3YnMBcFcTB3G6PqNDmA81+dOgMgqhzS2bRyxSsQ0PsjGg992Xo0m3HPIBwr8cDgEi
         2rcSo+DVA2KI9fYzBMqf2tpj1/Xh6LB/Zwz0xqz1xGD3YZ29/iFA4Mfpz93zjjhcvhoE
         PpiHl0acrTMtxvtT+hFfvNKbUuUksUNc2Om/3S8ad1fAilANXacQ70BiZDlgAdGhXAco
         33OgPqQN1tye37QF7mNt3jAdF3y2BPHTXwNK7TEUueSk3aTM4mzWS/UJeNeaffCdR/5q
         vgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KWpkUa8oW/Ki/fDQwZ9WyBGwrRdAhUzYNB0KMOC1nSA=;
        b=pSkQ3mV9xPTJD1zPjJihHn02bgUlhsUwpPMOaTZFIuq3Zxpk483sgRShQEh9BqcASB
         zC1CKozxNjwXuf41893i0UGAxabx60Ftftt0bSlUVk1qSUrmPR1gm0gvsiPGhyOcZmYn
         wvhU53v5pGASLNxgfVdyYNiVhnqokleWNIBKxZC93bDFooRvV0GRHpV7q6wKPI57PCS4
         qnwk8rfajVYE0WRENWdTRt6Hn8FTe1FnXbvBxFYwTzy6xv8xTD6IXY+YPTnLW3vQMEvI
         rWtE2GMyCIPS+61doUhxkVdDLiuRx90Q8+yjCIt6Z0yipgapu4a1S9VHDSc93CZAqXFA
         8a+g==
X-Gm-Message-State: APjAAAWaDPQQdl5fXn2Yixn6UuFgNakDyCUeyt3IYgv1kk7uLin6GAsN
        44kn+fH/jOfpYwIL6jOKR/h+nVw/WQXEU1NkiHe07w==
X-Google-Smtp-Source: APXvYqxJHcRT93AaEzfld5lF3qjjVXv/aj4oChI+DM7wROIc+41uWdgVwf/0ts7iOfSAEyJdlMlf7b2f3szT/9LawSA=
X-Received: by 2002:a17:906:1306:: with SMTP id w6mr53967294ejb.2.1560945561906;
 Wed, 19 Jun 2019 04:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr> <20190618184501.GJ21016@carfax.org.uk>
In-Reply-To: <20190618184501.GJ21016@carfax.org.uk>
From:   Supercilious Dude <supercilious.dude@gmail.com>
Date:   Wed, 19 Jun 2019 12:59:10 +0100
Message-ID: <CAGmvKk5yAi_9PMJjtPRb=2huOJCRFtKvbxeq_y2XFXRU3x05LQ@mail.gmail.com>
Subject: Re: Rebalancing raid1 after adding a device
To:     Hugo Mills <hugo@carfax.org.uk>,
        =?UTF-8?Q?St=C3=A9phane_Lesimple?= <stephane_btrfs@lesimple.fr>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, 18 Jun 2019 at 19:45, Hugo Mills <hugo@carfax.org.uk> wrote:
>
>    It would be really great if there was an ioctl that allowed you to
> say things like "take the chunks of this block group and put them on
> devices 2, 4 and 5 in RAID-5", because you could do a load of
> optimisation with reshaping the FS in userspace with that. But I
> suspect it's a long way down the list of things to do.
>

This combined with a flag that prevents btrfs from allocating on
specific devices automatically would finally enable my dream
filesystem where all writes always go to SSDs and are gradually
migrated to slower storage after the fact (and eventually to RAID-6 if
the data is really cold) as well as hot data being migrated to faster
storage. All this could be done via a userspace daemon with
controllable policy with this ioctl() and flag.
