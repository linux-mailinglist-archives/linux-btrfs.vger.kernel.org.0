Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41D58E5D8A
	for <lists+linux-btrfs@lfdr.de>; Sat, 26 Oct 2019 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbfJZNxj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 26 Oct 2019 09:53:39 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45913 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbfJZNxj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 26 Oct 2019 09:53:39 -0400
Received: by mail-ed1-f52.google.com with SMTP id y7so4137060edo.12
        for <linux-btrfs@vger.kernel.org>; Sat, 26 Oct 2019 06:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnYJo+e728JL6ji6OvVfPMte9CRvLzovw6Wl4tyBgo0=;
        b=MEmZ23RobeTEqaBOzYxnJkX0vTAsRMAvCeGb0vXwTnZg1cRG/v0ayjx6u6CAdzqPiy
         LgDy/Ycm8DsFyZCRa+7TwycyJlVf95HxujkQzKERDP4lbVAY00axZk3pzynCSZTo2W0/
         MFgSHCrT3fJkgx0UsrOuiWMYLWBMUCtmtZ6NknMTflJpPYvlqmxr3BJwfnU+EDR2oEb7
         r+IpaOz9ixAMHx72zchZhFK7qN7yvURELtjOvKGpvt2sncP43pdcFAA0KCc56epvMrmR
         WosBJqSb8qPEXo3yqcsj28O9rDQZkWQfFcR6Tfcaa84OSr56TkLnnN0Az/Xj9JFETSG/
         ST3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnYJo+e728JL6ji6OvVfPMte9CRvLzovw6Wl4tyBgo0=;
        b=etkR4g3+ssCgbmfyTxDjbEKdDPJ1ytVCizQi18fUl8EJhIaYUzddLxRNt3S60bLUdH
         c9khpMq31/9A0pKfDKHM1Gf7koNmqbyRuhszpXtxAmeNRsIM7vW7OHBGy+B55EwbWSmX
         qHiZ2BUJ5m6w8+Gu2I/rXgfllpAaFMgK0Cv/ZqOyS0ujcTFdVVKGV0TvGhDRoYjdW6gn
         DZCsC6RLIzVlwZjYZYJLpyR7weIZIrOCNM+xkCYyfpMwHxurH/7pj67EBSw1AffkN6pD
         Z1Bv2rp/LY/Z1MXctI0zOHIeJJquDKxsGl0lnu25H/TdNuR9cegYoAwOltX+P8G59uia
         J+6A==
X-Gm-Message-State: APjAAAWatUp5R6380mfred4nIAxQ7YiI2xiJ2ZwvkDOLgumXF9BucKfY
        4hD3E28jTuZOXsQb/dC62WdVKT5YMkT48qLoOg==
X-Google-Smtp-Source: APXvYqxj3dovZEnra2vHwyvXj7kKLMCdbNFhVG0qy9D+AquUslCTyP3uyUKzoN7Eh6lLyQZP4O7mGpbZftktwahBYc8=
X-Received: by 2002:a50:e609:: with SMTP id y9mr7316689edm.55.1572098016404;
 Sat, 26 Oct 2019 06:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAKbQEqE7xN1q3byFL7-_pD=_pGJ0Vm9pj7d-g+rRgtONeH-GrA@mail.gmail.com>
 <4608b644-0fa3-7212-af45-0f4eebfb0be9@gmx.com> <CAKbQEqG8Sb-5+wx4NMfjORc-XnCtytuoqRw4J9hk2Pj9BNY_9g@mail.gmail.com>
 <CAKbQEqGwYCB1N+MQVYLNVm5o10acOFAa_JyO8NefGZfVtdyVBQ@mail.gmail.com>
 <fe882b36-0f7b-5ad5-e62e-06def50acd30@gmx.com> <CAKbQEqEuYqxO8pFk3sDQwEayTPiggLAFtCT8LmoNPF4Zc+-uzw@mail.gmail.com>
 <e0c57aba-9baf-b375-6ba3-1201131a2844@gmail.com> <CAKbQEqFdY8hSko2jW=3BzpiZ6H4EV9yhncozoy=Kzroh3KfD5g@mail.gmail.com>
 <20f660ea-d659-7ad5-a84d-83d8bfa3d019@gmx.com> <CAKbQEqGPY0qwrSLMT03H=s5Tg=C-UCscyUMXK-oLrt5+YjFMqQ@mail.gmail.com>
 <0d6683ee-4a2c-f2ab-857b-c7cd44442dce@gmail.com> <CAKbQEqGoiGbV+Q=LVfSbKLxYeQ5XmLFMMBdq_yxSR7XE3SwsmA@mail.gmail.com>
 <043c2d26-a067-fd03-4c98-7ff76b081fed@gmail.com> <CAKbQEqHbh0pjT1+hPNuo_fKti0v9Mi-=gOUqm90v_tju1xSaxA@mail.gmail.com>
 <503118ac-877f-989c-50f2-5e2a3d0b58d8@gmx.com> <CAKbQEqFWiGdgJNSWOwvHkHGjrXu=2x0zAK-n9T-oza7qexwz7g@mail.gmail.com>
 <4a329da3-81ba-3240-8d76-6509dbe2983a@gmx.com>
In-Reply-To: <4a329da3-81ba-3240-8d76-6509dbe2983a@gmx.com>
From:   Christian Pernegger <pernegger@gmail.com>
Date:   Sat, 26 Oct 2019 15:52:59 +0200
Message-ID: <CAKbQEqGOJjNAFMitAU=coVboaat9pi5b-6DxFg4SOON+6bfJ0g@mail.gmail.com>
Subject: Re: first it froze, now the (btrfs) root fs won't mount ...
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am Sa., 26. Okt. 2019 um 11:41 Uhr schrieb Qu Wenruo <quwenruo.btrfs@gmx.com>:
> Thus I put a log tree check in skipbg mount option, and if it detects
> log tree, it refuse to mount and output kernel message to require
> nologreplay.

No, it doesn't, it asks for notreelog (quoted from a few e-mails back):

> > [ 1350.402586] BTRFS info (device dm-1): skip mount time block group searching
> > [ 1350.402588] BTRFS info (device dm-1): disk space caching is enabled
> > [ 1350.402589] BTRFS info (device dm-1): has skinny extents
> > [ 1350.402590] BTRFS error (device dm-1): skip_bg must be used with
> > notreelog mount option for dirty log
> > [ 1350.419849] BTRFS error (device dm-1): open_ctree failed
> >
> > Fine by me, let's add "notreelog" as well. Note that "skip_bg" is
> > actually written with an underscore above.

> Then you can try btrfs-mod-sb, [...]

Yep, that did the trick. Can mount the fs ro now, access files and it
even reports checksum errors for a couple of them. Promising.

Cheers,
C.
