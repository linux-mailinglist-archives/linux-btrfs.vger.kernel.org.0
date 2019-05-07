Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 030851693B
	for <lists+linux-btrfs@lfdr.de>; Tue,  7 May 2019 19:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfEGRax (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 7 May 2019 13:30:53 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:40218 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfEGRax (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 7 May 2019 13:30:53 -0400
Received: by mail-lj1-f175.google.com with SMTP id d15so15073796ljc.7
        for <linux-btrfs@vger.kernel.org>; Tue, 07 May 2019 10:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDfcbYcklV7EvVwSK7hsey26gHyLjO1ZT9JrzeGEfHk=;
        b=VMddX7bp3pDorEaIv+y2lCYgRCBJZX7kShkz5D9mKMH63T6Hd3JXXvBdUbJRsxjIlT
         BrgZ54tJs6FBa02Uh2dD+Yf7WK4yooi+ouE2LDN4G3EJP04xmXKhzPSV+On5MKf2+8sj
         8aEu7CceXL1HlfASeHNHXcfOD3+ALHTo7oaPc1hmehj2Hz1ulFDX04oF0TIuLHEQBdg5
         LtJhroF795DAqWWZ3mQCZUfPZ1ur1RhDnAuc+UE70JhyEezUslARHfwVOxSkLemCO69t
         +W4evXFAbGVqCDaqR0PH2bcFS+NRue6Y0Db2d3rI3rlMRtTWOXcNE/2AVACj4dT9d6U3
         lW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDfcbYcklV7EvVwSK7hsey26gHyLjO1ZT9JrzeGEfHk=;
        b=I787JdktycTA8zaY9kjryjbhVR0GvuE4sxjbstdSeX1+TjGVyFVk040VvRaPPPoPs4
         lWOdr5eNVtdPoJ+a0WJpeLUgLqtd7DdzuSlB/iHOm9zEGbsVqCLfnZvGhTGyTx3HfyQq
         uNrNfpSzV9fGf+n9IjasjXmTRhD8a+s5YNG0eRZ6LCWk2EB0kj+V8MFaGs4iiVAGUuiM
         97Z950TKuQwu9yRbdh0esmkJJiu4D4yAbl+8NoPkGpOzG/aaXMVwLKdVNk133uOEDl8o
         ewGwOiuZN/4KmnAIqB6r33FvlFBZ5d8ztNQx2mnTwO34KhJnnXOjzV+g04F9IPrpoe9G
         lQ3g==
X-Gm-Message-State: APjAAAVgUe+k9CDUsp4gLRwa7vlXB/RBAqfZ+oCaJtVcdb6dSVBCX7lH
        fbWBAiZgI7mSGW44KpCYXkq5OLq1ia09rvspXZrxLPKN81k=
X-Google-Smtp-Source: APXvYqxvhrPHa1FgIoo6V12eO4xBu2zpHUiVISefxmSUEvVDY7P+RuMnFl979KWDpMsyCr2umeHe3Ucj/nfN1e09jmc=
X-Received: by 2002:a2e:9350:: with SMTP id m16mr17789521ljh.38.1557250251424;
 Tue, 07 May 2019 10:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <aa81a49a-d5ca-0f1c-fa75-9ed3656cff55@avgustinov.eu>
 <e9720559-eff2-e88b-12b4-81defb8c29c5@avgustinov.eu> <a75981da-86f7-e0fb-d1dc-a2576b09c668@gmx.com>
 <039ec3eb-c44e-35e9-cf1b-f9f75849d873@avgustinov.eu> <c69778f5-a015-8b77-3fab-e41e49a0e0db@gmx.com>
 <51021dd7-b21b-b001-c3f9-9bc31205738b@avgustinov.eu> <00e3ddf1-cbd7-a65a-dee3-ca720cecc77d@gmx.com>
 <a6917f39-eeb4-5548-f346-a78972c7c3fe@avgustinov.eu> <6a592ffa-4a5a-81af-baef-8f1681accc87@gmx.com>
 <2c786019-646a-486f-1306-25a3df36e6b3@avgustinov.eu> <52b23bd7-108b-63f3-b958-2a5959c7ca6e@gmx.com>
 <f2b33d93-aa37-9fd3-6036-44e1e3f065eb@avgustinov.eu> <a9135dba-26fe-777f-048b-87052d5cbd14@gmx.com>
 <21ff2435-af15-573c-e897-05ceb4f42e0b@avgustinov.eu> <CAJCQCtQJkJwEyouCUzcV1MzPkcxhvtqxkWqmrwnB9txV=MUTXA@mail.gmail.com>
 <3f1f66d3-e04e-de16-e9a4-7c8a6238d5b8@gmx.com> <246c2330-acb6-3205-0468-051bacbfaeb5@avgustinov.eu>
 <24ab8eed-a790-bff2-cdad-0b091f7d0fe9@avgustinov.eu> <917e0530-7f68-a801-d87b-d00bb4e10287@gmx.com>
 <00637d5e-b66f-7f87-b13b-7eea5a62fdfa@avgustinov.eu>
In-Reply-To: <00637d5e-b66f-7f87-b13b-7eea5a62fdfa@avgustinov.eu>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 7 May 2019 11:30:39 -0600
Message-ID: <CAJCQCtRugbGyr8Nyjo7P_g+VpATdhojOeaY4BPdJFfcOMxDYGg@mail.gmail.com>
Subject: Re: interest in post-mortem examination of a BTRFS system and
 improving the btrfs-code?
To:     "Nik." <btrfs@avgustinov.eu>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, May 7, 2019 at 11:17 AM Nik. <btrfs@avgustinov.eu> wrote:
>
> It took about 18 hours to compare the mounted volume with the backup
> (used rsync, without the "--checksum" option, because it was too slow; I

If you're comparing without --checksum, it's just checking file size
and timestamp. It's not checking file contents.


> can run it again with it, if you wish). Only about 300kB were not in my
> backup. Given the backup is also on a btrfs system, is there a more
> "intelligent" way to compare this huge tree with the backup?

Not if you have reason to distrust one of them. If you trust them
both, comparison isn't needed. So you're kinda stuck having to use a
separate tool to independently verify the files.


>Optimally
> the fs would keep the check-sums and compare only them?

No such tool exists. Btrfs doesn't checksum files, it checksums file
extents in 4KiB increments. And I don't even think there's an ioctl to
extract only checksums, in order to do a comparison in user space. The
checksums are, as far as I'm aware, only used internally within Btrfs
kernel space.


-- 
Chris Murphy
