Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDE11C23FE
	for <lists+linux-btrfs@lfdr.de>; Sat,  2 May 2020 10:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgEBIYi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 2 May 2020 04:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725785AbgEBIYh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 2 May 2020 04:24:37 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516AEC061A0C
        for <linux-btrfs@vger.kernel.org>; Sat,  2 May 2020 01:24:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u6so4691084ljl.6
        for <linux-btrfs@vger.kernel.org>; Sat, 02 May 2020 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ka9q-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pD8vEUmrxnzwM238uQ094Wn+fsoCxmuPYgLo4OLc26o=;
        b=gFayBCt69ufgeVdaoNASr5vBndcwABKUbWP3BJWD2bFjX3SEwCHNa/bdNBYJHqFpZu
         Wavh9kx2I/eECjOLdaADyHmdClvm7z1750ufFQpf2bdvdfYao6qterj4rRklr+tbJzKv
         NrZpO45x9P8jN3VZ7T9Mmvm7gJYy9WKI6SulTnuPo3DNUBkcyKk1cMQqTQzaXA7T690r
         VUwtJmNf+cd0e/ltHeMPdninBIvxJEBAFkzeM3sEklu0ZL3uH/1Quf3dLpJ178SdFg0Y
         XtVuipeTdKohj0PqJXD7TfTNa+oms2mYsLDowyEX0ZZ4/fpqOdBbRI3iOP0kYJVoJ+bV
         Ne7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pD8vEUmrxnzwM238uQ094Wn+fsoCxmuPYgLo4OLc26o=;
        b=PlRNp9IuBij+d5Nu+r3zk4bN4bPmUXi3IR2m2uidq35TuHGfmjXiEjBs1imr/dettF
         azkhd97aBe+V2uFLnnVMZfb8PcSx0y7OQppgA57/4eKOS2fcV7pjxTyNDZp5Pvm1vpFk
         2xabyxUnWAVr1HoJCcp5SeCJ8R+463Y/1s9JLH+0huh1z0j1n4lGcCCCTL/PBLJQX1BR
         KTqs44njOVky2IkE4563Iflkrtzr1VvQWhHHOmgqjRpaywrRhEWrNI7rzARBtm+KVuZk
         lfmNvntJZ4BCFQvrlOWv3n8zZZ+QFFK64vygFjrmnxqdBv7R4NFM8ENX7Z2ziC2qy6Y/
         e7ew==
X-Gm-Message-State: AGi0Pua15MKUePA85BHSVNwwl1yZLXOuPlgDlflHrGhbpDPTZ2vzBPC9
        rZ17nv5s4VL6VsxIhMCLZ3hlaohp0voShkktl56xVA==
X-Google-Smtp-Source: APiQypI+8jDu4XzuN46SZEGRZ+F4/29cwgPcFPmQetGrofdUtRiWs/W3Sxzsy0HiLd7BgfpQHO/P/A3DfsItz+coMHw=
X-Received: by 2002:a05:651c:319:: with SMTP id a25mr4308210ljp.209.1588407875737;
 Sat, 02 May 2020 01:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <8b647a7f-1223-fa9f-57c0-9a81a9bbeb27@ka9q.net>
 <14a8e382-0541-0f18-b969-ccf4b3254461@ka9q.net> <r8f4gb$8qt$1@ciao.gmane.io>
 <bc4c477a-dd68-9584-f383-369b65113d21@ka9q.net> <20200502033509.GG10769@hungrycats.org>
 <SYBPR01MB3897D20A8185249BF2A26B139EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <20200502060038.GK10769@hungrycats.org> <SYBPR01MB389730010988EC44E7D109EE9EA80@SYBPR01MB3897.ausprd01.prod.outlook.com>
 <CAMwB8mhGkcM3DCTusuHAi-cQcr-FrA5cq4hVYfv+65zn_QjAig@mail.gmail.com>
 <20200502074237.GM10769@hungrycats.org> <CAMwB8mg5npwzxFrBw8gdBt7KPbTb=M8d_MAGtbQbCoJS0GoMgA@mail.gmail.com>
In-Reply-To: <CAMwB8mg5npwzxFrBw8gdBt7KPbTb=M8d_MAGtbQbCoJS0GoMgA@mail.gmail.com>
From:   Phil Karn <karn@ka9q.net>
Date:   Sat, 2 May 2020 01:24:23 -0700
Message-ID: <CAMwB8mgYnkRN-pEySsX832nTuGGfeWR6k+QedqLQpPeWXSS24A@mail.gmail.com>
Subject: Re: Extremely slow device removals
To:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Cc:     Paul Jones <paul@pauljones.id.au>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, May 2, 2020 at 1:22 AM Phil Karn <karn@ka9q.net> wrote:

> But I had to use replace to do what I originally wanted to do: replace
> four 6TB drives with two 16TB drives.

Excuse me, I meant to say I had to use *remove* to do what I
originally wanted to do...

It's getting late.

--Phil
