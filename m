Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0FB35A88F
	for <lists+linux-btrfs@lfdr.de>; Sat, 10 Apr 2021 00:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbhDIWEK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Apr 2021 18:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhDIWEK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Apr 2021 18:04:10 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FD3C061763
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Apr 2021 15:03:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id y204so2222307wmg.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Apr 2021 15:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=8iWFxQZZQAc5jdnFXiN7O6miYrRYiTmSboleYIBqyb0=;
        b=KRTYwLOwqNPV5ICYqCr7Z4C6zkilAb3DkfeT4fc1RXaWQQfHddVYoShuDZW74a1boe
         QFegFywJA3IIuGJ8RCiB31q9MhOrNW8EizakNXd5N+oEqbJFT4C5GSjbh4XKeB1HSsPY
         dhgOSbGmT5Wi9f+k0+MV/DnlJDba05SepIU8E5Ma86tm5OEDyEoWQ1i9MuG96v0GYAam
         OP8oTJzBJuFe1GsJ262Y/vzzZVN2lVBwyrz2k/hDh8k9oNj9IKzP6qiV6aMECl5uD1zM
         F5XjI/Pou8+3OQUnCcWbccSTqsNj0Msekc+AeH1TUWJPpBziNqJ7Jh93FCbcct6ORbJT
         bEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=8iWFxQZZQAc5jdnFXiN7O6miYrRYiTmSboleYIBqyb0=;
        b=Kj0rVPrUOFUhusHkg+mk9+WCs300HucO0SC18f0E+viWFPg+D/hEy8lzMkuAQvNizz
         el18Tywq1HtTHSBhzTDJuqPhhNEB/9tKnNhtFP76s4pb8JDvrqiYP9Z46dmM6joiBz+l
         s1+3iFdbBW2MriIy+bd2ygvx9dX4BvXxGC5wukWOML1BU2CKET4ek14PqXmQSDkYILrN
         MbZkD/mmfjoueJtW3UWsnmG7041SDsHdSvCCpL85ZfWvqoo2XvaBjPm6vrWKoaqZhPGI
         T94+EQkmbx1WJTz9W8rVN7qoKa2IldhTLeS99+PcKTMdC8Ga/9uy4NrP1mdTX95V1qQF
         edlQ==
X-Gm-Message-State: AOAM533fkW4VYpkeP9XcMlHrpwa7kRf42SLi8e+FZHfgbHEvzJjj8uvN
        7TEzWAsq+mV6srtpWuN1f2A2Tqrbz82Op9a5WsuGnaw6mfO3dKwN
X-Google-Smtp-Source: ABdhPJyLtoTnN6scH+aZGRuiF5QTcbFXfRvCvrmYXhTb3AFaRssYjwMR2SEuc/oue0lzU/e/IB2JlTKwx1EWu74iKqI=
X-Received: by 2002:a7b:c30e:: with SMTP id k14mr15674612wmj.128.1618005834837;
 Fri, 09 Apr 2021 15:03:54 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 9 Apr 2021 16:03:38 -0600
Message-ID: <CAJCQCtTp0aXBssEr4ZXGX=DS_+RyGghmoANCKDdxG59QWu8LVA@mail.gmail.com>
Subject: btrfs+overlayfs: upper fs does not support xattr, falling back to
 index=off and metacopy=off.
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi,

The primary problem is Bolt (Thunderbolt 3) tests that are
experiencing a regression when run in a container using overlayfs,
failing at:

Bail out! ERROR:../tests/test-common.c:1413:test_io_dir_is_empty:
'empty' should be FALSE

https://gitlab.freedesktop.org/bolt/bolt/-/issues/171#note_872119

I can reproduce this with 5.12.0-0.rc6.184.fc35.x86_64+debug and at
approximately the same time I see one, sometimes more, kernel
messages:

[ 6295.379283] overlayfs: upper fs does not support xattr, falling
back to index=off and metacopy=off.

But I don't know if that kernel message relates to the bolt test failure.

If I run the test outside of a container, it doesn't fail. If I run
the test in a podman container using the btrfs driver instead of the
overlay driver, it doesn't fail. So it seems like this is an overlayfs
bug, but could be some kind of overlayfs+btrfs interaction.

Could this be related and just not yet merged?
https://lore.kernel.org/linux-unionfs/20210309162654.243184-1-amir73il@gmail.com/

Thanks,

-- 
Chris Murphy
