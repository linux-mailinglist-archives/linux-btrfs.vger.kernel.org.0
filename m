Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9B70E63A6
	for <lists+linux-btrfs@lfdr.de>; Sun, 27 Oct 2019 16:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfJ0PTo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Oct 2019 11:19:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38075 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbfJ0PTo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Oct 2019 11:19:44 -0400
Received: by mail-wm1-f67.google.com with SMTP id 22so6476535wms.3
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Oct 2019 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YJb+vmjy0wXs/Kws6kGlO2P4oTjtM6GMyzuyiFSYUAw=;
        b=XC50yoViEgR0WRfNzML48D2gPidFTyG1XtoDnEkJbVmCMDviRzCAslgZpX+0TOlS0+
         IpGFH6Uh/iseGG8GBLWlAgOfAntZhRlsfXP5bIGGqmlLkAy/2a6zTJ3Rs4SlYzOWgQD+
         05QPNF3UQyQql5tmz8hGcFpAEg/YDXSgi7duW9OuIJs235LmbWkK6BSpHkmwML9twwfm
         iL6uPTInoFJX97RBvWBEjAKxq6z0nHnaRkBlO2rrsRedpmqpVWCqdRNjMDoZL5eeR6oH
         8yj3CAX5uo8gomb+wXToknmOkwAuTgZlVmdwFXYnZ7YjtaY9pUoxESbZbxftZBRSQD1o
         XiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YJb+vmjy0wXs/Kws6kGlO2P4oTjtM6GMyzuyiFSYUAw=;
        b=dlynsQjqG7EyBau8BdokGV6Dthak/w8oi/74paHOWjc8GEeE23UpmkW+Z84twbYGEc
         8hOttqWAGBURk1wyfABjvVpu7ecFBVsXTJvilpopWUZoIQmCTPtJb8Oo8xK2M5ejO96t
         iaJF3vv/b6kRsTFg2mlGe8qq4ynSGnKmu/XtfYcBfHjFG79BX1Uvji4+YzrxSWaawgLg
         y8oezjuVr3jHzpRvvayGxcxgWpe675d+DSlp0gezoix2Ch+ii8RrCnFT0GepsPQsUR3q
         LXOEEirV4SMWAuYDH8rXvpXlUCwHer6nQAU/ssIQAgl4iNz1j6KomjTZlSO8FuigqCcR
         61zQ==
X-Gm-Message-State: APjAAAW//JyQdf75JI7s7uYJcbtLTnijdp+Krp7xCd9OvKI21yRg2wHN
        EVeHDRa2P4JCKS8CoeICNhwskOKAHIgnRtYfiIPFp9F9704=
X-Google-Smtp-Source: APXvYqzr9jwHprsLxL423U57iA3LUzWbjxci6LeJZDHrEV2mCBO4bJqjV39jHtq45ucmEkxqUrf4y8ww8FOWLrMMAiw=
X-Received: by 2002:a7b:c049:: with SMTP id u9mr11674388wmc.12.1572189582197;
 Sun, 27 Oct 2019 08:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAE4GHg=W+a319=Ra_PNh3LV0hdD-Y12k-0N5ej72FSt=Fq520Q@mail.gmail.com>
 <cb5f9048-919f-0ff9-0765-d5a33e58afa7@gmx.com> <CAE4GHgmW2A-2SUUw8FzgafRhQ2BoViBx2DsLigwBrrbbp=oOsw@mail.gmail.com>
 <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com>
In-Reply-To: <b4673e3b-b9b2-e8e5-2783-4b5eac7f656d@gmx.com>
From:   Atemu <atemu.main@gmail.com>
Date:   Sun, 27 Oct 2019 16:19:31 +0100
Message-ID: <CAE4GHg=4S4KqzBGHo-7T3cmmgECZxWZ-vXJMq8SYnnwy16h3xg@mail.gmail.com>
Subject: Re: BUG: btrfs send: Kernel's memory usage rises until OOM kernel
 panic after sending ~37GiB
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> It's really hard to determine, you could try the following command to
> determine:
> # btrfs ins dump-tree -t extent --bfs /dev/nvme/btrfs |\
>   grep "(.*_ITEM.*)" | awk '{print $4" "$5" "$6" size "$10}'
>
> Then which key is the most shown one and its size.
>
> If a key's objectid (the first value) shows up multiple times, it's a
> kinda heavily shared extent.
>
> Then search that objectid in the full extent tree dump, to find out how
> it's shared.

I analyzed it a bit differently but this should be the information we wanted:

https://gist.github.com/Atemu/206c44cd46474458c083721e49d84a42

Yeah...

Is there any way to "unshare" these worst cases without having to
btrfs defragment everything?

I also uploaded the (compressed) extent tree dump if you want to take
a look yourself (205MB, expires in 7 days):

https://send.firefox.com/download/a729c57a94fcd89e/#w51BjzRmGnCg2qKNs39UNw

-Atemu
