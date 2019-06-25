Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEDA355454
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2019 18:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfFYQUD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jun 2019 12:20:03 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:56303 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfFYQUD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jun 2019 12:20:03 -0400
Received: by mail-wm1-f44.google.com with SMTP id a15so3456397wmj.5
        for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2019 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mDFxUgOW2rEnyBWP2PGeFEslidPaoalvacAr1/DWWsk=;
        b=fitsNY8RaUTbX5+ZL2+4xCXoyb3N063QJcW1lCtdx4uAmPKXKpT11cS4tubrhvWTBU
         TpFpi5jbeU8ekOhR8KOeyJagf2j2pd5iVo+tkn6AcrtvCi1plPo27AHCnmh3VI41iMvf
         GF8sVhgT2+SedyoaCqxMGClIxc3cJFfBJZ28dSK0Lg2fcKBgpi4UV5BHwjNO58yWtrOR
         ptgXz+nRvzeg9jqEfk0MRZUvR/WZNgf3ep68n4+wQZ1FLww2C2ep7ng+bTdeC5RyGU1z
         wrR/SnT0fZfXXHq0yccagM/aauXohwCJR0RcdB0qakQ+UAUBueQBrfrnHt8AIZdqrAeC
         /Dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mDFxUgOW2rEnyBWP2PGeFEslidPaoalvacAr1/DWWsk=;
        b=nKfAW2RfmEedTtY65GT0lXQzHb4JL9BDVzYMQVNLPrgbegp09YgIZQ3vJImQ9Kq9wO
         4FOH3cE3lt/r638miB347rCYU/e1DrEkvfyNz/tHDgsV/mSzdcMtkAEMiq9zI/j7WCZp
         kwsVPniG/6LaY785vVPQIbK2C9r6oJmlkbuJf3hh2oiKlQw4ayD+X4+78todSBngSb7+
         CB2fq2JhNjwlKf1PhRE3CBKCiCOY2xBYO88/W4irtjCUARgNAOUD9kjYdV8BYKJeEDwx
         QGyjY1+r+ZC4AuBcTA7J4kZnOvugWf3kQlJRmLhUqHLtJGVi7UEsH1eEtPNHjrLJIB3f
         mMAg==
X-Gm-Message-State: APjAAAW35Mv1tE77o3iibxIrqekvd0R6qq4Tt+7If4OkLTrDyLvGA2lJ
        E/ybKJmC3uHkw59eJ+NOquCKUJ3LOlwrLPH1ceegcA==
X-Google-Smtp-Source: APXvYqyTiZv+/XF/ulxyT3iTFv3N7H9h4b2AOTPtP3C1R/kqAGk0RyymVrJ7d13YvTI1uSVqtISVgkm9/CfRaOYBMgM=
X-Received: by 2002:a1c:f018:: with SMTP id a24mr19701038wmb.66.1561479601956;
 Tue, 25 Jun 2019 09:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRNn9WFQc2VHc8uHg-Uoe7iKq0zOu6qA1OjBBP_O4385A@mail.gmail.com>
 <e55aab31-58c3-e736-d95e-9e5324fa0b5c@gmx.com> <CAJCQCtT8SE5TYkVniJxhK5ZpE8OoE6c9AVPzs4baHn8C5y5X5w@mail.gmail.com>
 <714f8873-9a38-8886-4262-4d8e43683614@suse.com>
In-Reply-To: <714f8873-9a38-8886-4262-4d8e43683614@suse.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 25 Jun 2019 10:19:50 -0600
Message-ID: <CAJCQCtTvz7c18jE2qdbHke+sp1_=qgRdN6VJBqZu+kB4UEJORA@mail.gmail.com>
Subject: Re: 5.2rc5 corruption, many "is compressed but inode flag doesn't allow"
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 25, 2019 at 12:58 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> But why are your nocompress files being compressed?

$ sudo strace -p 624 -k -t -o sysdjourndstrace.txt
https://drive.google.com/open?id=1IspAjQ6b9dVizjqrX4E6ZErzUKH0CQBl

Maybe there's a better way to see what's going on. I do see chattr but
I don't know the value or the file. I wonder if the original file has
+C unset, then it's defragmented which somehow permits btrfs to
compress even though unsetting +C on a non-zero length file shouldn't
succeed, but then because it's written in a directory with +C the new
defragmented file inherits +C and gets no csums even though it's
compressed?

I'm throwing spaghetti at a wall though. (I know that's not a good way
to test spaghetti, so the analogy works perfectly.)


-- 
Chris Murphy
