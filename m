Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051AF22E486
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Jul 2020 05:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgG0Dp6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Jul 2020 23:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgG0Dp5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Jul 2020 23:45:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE70C0619D2
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jul 2020 20:45:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t142so6898476wmt.4
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Jul 2020 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6S40ZMMmwzEDRgr3eUmy8sc9auhK+mtM2OTzVw7cPJo=;
        b=1vUXKXMByEO3IRQCpZJ52wvkGqK5afoNHL6/6zZfsTclIHzKUYW8rU6IS6wcgRdAy0
         SsBgCwtu3iCiC+Dwq8X/gJpDD4hc3NeQPUQs07PYJuIsvoJBMPBNdzCPEqtFmjbEf7YX
         JsFYITXqCZOXIBLUTz5Ch+9ozNCBPq1z3ry1+g43jAnze1x+0qjEYQWl3z/5ZNO28cm/
         q7sDn5y9jWwqxMzN9TY3rl6UoD28sF5U6+Tot55EUWSzUougUb1TNDUSIIjUWbopA0Co
         cwHSWmqswSMo3BILSz3feFAD4cwUrd8klDERy9V3gcfYRkW6l94OqPpqsYEmRX5ZcTZj
         kZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6S40ZMMmwzEDRgr3eUmy8sc9auhK+mtM2OTzVw7cPJo=;
        b=R931YLeCMBw2syap28Z1WNR7DsdvP3iyUMCLzbzQQ4ft6Qeu7G2QZLsKiZxgQDAFC3
         ouFxQTv/TTbJjnnmX0PqKNsrFgFZG9Xx47ISkYzUABGwaeD9CR8wcMVSzRB1wJJn+oJV
         d03jicySn+GHG1XG6YHRy4kbmKsifIsLjl5fIHmypeOwH3jwFE7p3Rrox+Q5pnJ65J/L
         zJM++tmFbGAVADlYFnBhNh4U8JBUEtVKIVi2/XTirz7Nd5XQbRIw/yDEqWRFPMRSGf64
         vtIF8HV4W4Y2I+6xcdy38lXpUNIyTfOujzrQL9hAVeeBXV22zlksl4QETvjdXZ2zsyuq
         xUHw==
X-Gm-Message-State: AOAM533Vkwabwtrk2cumYdqXlGT0uGiOJFGWuPdFIrQamEqL0Xu4iIR4
        vyerbm+vW0Gs4ag2nR6xIK09O56JBwDgE5hLEKxO7A==
X-Google-Smtp-Source: ABdhPJw39rmMLFH/VgMW4bk2failec0ySCdr/Oy58UEgB4CSPa9Pv8wOy9/ot9L3xTrelPFXlh7z5k8cFJbkS1nvDEc=
X-Received: by 2002:a05:600c:410f:: with SMTP id j15mr18194983wmi.128.1595821555984;
 Sun, 26 Jul 2020 20:45:55 -0700 (PDT)
MIME-Version: 1.0
References: <rflcdf$bc5$3@ciao.gmane.io>
In-Reply-To: <rflcdf$bc5$3@ciao.gmane.io>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 26 Jul 2020 21:45:39 -0600
Message-ID: <CAJCQCtQe=00iZf87BzfjtRU53b+7pjmBdee2vXeh36v9vqEHnw@mail.gmail.com>
Subject: Re: defrag/compression: will it break reflinks on kernel 4.15.0?
To:     Andrew Skretvedt <andrew.skretvedt@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jul 26, 2020 at 8:05 PM Andrew Skretvedt
<andrew.skretvedt@gmail.com> wrote:
>
> I've started experimenting with compression on a btrfs filesystem. I'd
> like to use 'zstd'.
>
> I'm on linux kernel 4.15.0.
>
> I have a handful of snapshots and I know that if all the reflinks will
> be broken, I won't have enough space to keep them all. So the choice I'm
> facing is that breaks will happen; I should delete enough snapshots to
> ensure space is sufficient, or breaks won't happen and I can leave my
> snapshots alone.

Or just enable compression now, going forward.


> The manpage "btrfs-filesystem" includes:
>
> > Warning
> > Defragmenting with Linux kernel versions < 3.9 or =E2=89=A5 3.14-rc2 as=
 well
> > as with Linux stable kernel versions =E2=89=A5 3.10.31, =E2=89=A5 3.12.=
12 or =E2=89=A5 3.13.4
> > will break up the reflinks of COW data
>
> I thought I was prepared for this, but now I want to try to be more
> certain about what will happen if I start issuing 'defrag -czstd'
> commands. Because version 3.x kernels are mentioned several times at
> specific subversions, the warnings only apply to newer sub-subversions
> of them. I *think* that my 4.15.0 kernel will *not break* reflinks.

It will break reflinks.


> I see that the userspace tools' version tracks along with the kernel
> version. Is it a mistake to use a newer version of the tools than the
> running kernel, i.e. should I drop back to v4.15 of the tools?

No. Ideally use the most recent version you can.


>
> >From the wiki, I understand that while zstd support was added in kernel
> 4.14, user-selection of compression level in zstd was not added until
> kernel 5.1. So I cannot use mount options like "compress=3Dzstd:3" on
> kernel 4.15. BUT, can I yet do "defrag -czstd:3" since I'm running
> v5.4.1 tools? Or, must I (should I) just stick to -czstd and accept the
> default level it would use. What is that for zstd?

Compression level currently is configurable only by mount option.
There are proposals to enhance this for both defragmenting and
property (XATTR). But as level 3 is the zstd default, you will get
zstd:3 just by using zstd.


--=20
Chris Murphy
