Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 447C811D701
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Dec 2019 20:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbfLLTYW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Dec 2019 14:24:22 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46077 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730416AbfLLTYW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Dec 2019 14:24:22 -0500
Received: by mail-wr1-f68.google.com with SMTP id j42so3958647wrj.12
        for <linux-btrfs@vger.kernel.org>; Thu, 12 Dec 2019 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDZxIlS5XBNlthgRuag14O4cqVRSwVawOVi/0pKRTY0=;
        b=JpacJ8Ky//jsX+TtKsrgGFJJS0bv0cvyp2Ws+w7Jw9AzkxAALliM9Tn+qeOc6vbuoL
         ns/z60DOQB+8HFg5XOKm4lwrfAtVzjPz7q24a14xjefI11T0zCLiRvHy+8DgXlHaZNdC
         oKkaD854FaApYNPN8Y/JwEWWcSdj2HEMf3gn/4CScRV5KotvLBLl/BXXwPvqSdeFpfKg
         nUy0pym/YLXVM6I5V5P5nHbQLAEFXQRK/tDJjI9YyN7h1ScwzzykPkTHd92wtr9tvRK7
         eeOC8pVXKp7pub/Kx1nNj1XjcYOy4wqTLXD1yDCoP1FGry8a5MULScDSgQ7KRK9EsucV
         d1Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDZxIlS5XBNlthgRuag14O4cqVRSwVawOVi/0pKRTY0=;
        b=m2zAtXr57oLeJGeJfGsoI0OzE5HBPozDWpR/4s18Hzjw9yTvF0v4Mesf2UFimcldBe
         yU/LCGaagbsW9WVcE6I6e/CMoQyUbyEHIeOZwA2SMpgdf0/BSHvgqj2tvmvPmrSb3fSO
         j7z1Tf8R3AVh3xfQimx7rSlEIseighArYn4ptgddKp6BHPKFtkgEn4qMLtCwgS3GKpaF
         TJyNqC3nKk0miY3xXhT34Hlj80UB7e+hfS7mz8dH5k0jxJbFdmzu1auQCRPwHDh/tYsV
         SAeIDsJEIyqw8t1cAf7DtCtK/UcUFwriMacGGWghToIx2pturospTFwKJlVTNRsTXwpP
         ZBuA==
X-Gm-Message-State: APjAAAV0WQuAlUyRbBxg8W8yHyvuRTiq+F78XQ1c0dG+p7szCQ6Z00Kw
        jXPVQ0f9iO+ZxlShlCccRTTh0DMQXNGwcMewgMHJWg==
X-Google-Smtp-Source: APXvYqybt0XBC+85BerWlQdLkD9s6d3LXPLdtGgzj7QHi2Rs6JFris6JE3SX83+Xo2vt7959A0puBWj0HG/KjK1zNfg=
X-Received: by 2002:adf:9c8f:: with SMTP id d15mr8138366wre.390.1576178658473;
 Thu, 12 Dec 2019 11:24:18 -0800 (PST)
MIME-Version: 1.0
References: <CAN4oSBdH-+BmSLO7DC3u-oBwabNRH2jY2UUO+J0zdxeJTu5FCg@mail.gmail.com>
 <20191211160000.GB14837@angband.pl> <CAN4oSBeUY=dVq5MAZ6bdDs1d5p3BVacEdffzsvCS+80O1iO7jg@mail.gmail.com>
 <ff7f40eb-301e-e890-f58d-99f65a79cbe1@georgianit.com>
In-Reply-To: <ff7f40eb-301e-e890-f58d-99f65a79cbe1@georgianit.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 12 Dec 2019 12:24:02 -0700
Message-ID: <CAJCQCtSHdd0vqpS9Hv-UCuthq5-bSX_7UBVDiULzrb-P9Y_Q-Q@mail.gmail.com>
Subject: Re: Is it logical to use a disk that scrub fails but smartctl succeeds?
To:     Remi Gauvin <remi@georgianit.com>
Cc:     Cerem Cem ASLAN <ceremcem@ceremcem.net>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 12, 2019 at 12:18 PM Remi Gauvin <remi@georgianit.com> wrote:
>
> On 2019-12-12 10:40 a.m., Cerem Cem ASLAN wrote:
>
> >> Try 'smartctl -t long', then wait some minutes (it will give you an
> >> estimate of how many), then look at the detailed self-test log output from
> >> 'smartctl -x'.  The long self-test usually reads all sectors on the disk
> >> and will quantify errors (giving UNC sector counts and locations).
> >
> > I tried this one, however I couldn't interpret the results. Here is
> > the `smartctl -a /dev/sda` output:
> > https://gist.github.com/1a741135af10f6bebcaf6175c04594df
> >
>
> That drive is toast.. the giveaway here is the over 1000 "Current
> Pending Sectors.".. there's no point trying to convert this drive to
> DUP,, it must simply be stopped, and what files you can successfully
> copy consider lucky.  The rest depends on your backup...  (I wasn't
> clear on why your backup is supposed to be bad... BTRFS should have
> caught any errors during the backup and stopped things with I/O errors.)
>


Exactly. It's possible though that the backup is missing files as a
result of EIO, if those errors weren't discovered until recently.



-- 
Chris Murphy
