Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C4B36A45D
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Apr 2021 05:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhDYDSr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Apr 2021 23:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhDYDSq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Apr 2021 23:18:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903AAC061574
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 20:18:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id e5so23641803wrg.7
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Apr 2021 20:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OUyN9VmNuazzv/UoaJLUX0pGnWeFpsavKukj2v5145s=;
        b=1MCY8YIbhE0JqUG3AbMEDpb5yBhRXWQMRaxmL8+q1TYj4xFRf5cS7YQtCcttRVFX50
         MbB5793y9MOCefWtAEcys1tgeq4sUvgQ9NuNgslAGyrdqKMtTxcmt1cxQySxnHNf/spT
         B2skZ7AenRvVY/lzHN3qSEY62SwRikBby5G6+VrxIICwj9gMr2+y0ZAaRDiP3YVgV7yk
         xDfhVkhbawGPQO9RR/WZ4oImJoVfzHyuc2tidZ+Moo3tyAOC5I9+ODnm5mvge6Dw2d8X
         RDwe6uYNnPWvgH9kg+HV64fi1UGUmastds8lTeAaSaBiWaED+K000VsB3E9M6ODmnTQI
         i7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OUyN9VmNuazzv/UoaJLUX0pGnWeFpsavKukj2v5145s=;
        b=ZgyD4iqiwRFMfwN1GvT5yLSgbdNk4G0duc+Xq4j33tau3Yo7lGThpDPJlyTjUch8N+
         PU+YEmaeMOm/Yj14UohCUTnUYIak+Hz/t7A0W5FuqP5BPkibcGDM9i448KeIYPFw3WGM
         X/wV/v22dufF4knlEBAZDYcVeQZcpakJMEKrT2FQt/7H+VBC2gla7wgjOv9sHxwcovLI
         MYfkbN4pRZxg6NhJUEbPR/M4H48BMPqXTYDEZwm9Vl9x8aILrfEpVu7d3AnQRZh0qYez
         qagGV70j8Hcgprriy8Ox40sAEbKcbVXuULnlK0qDYW9VC8kh/yplDFq8XbAS1DzS9XcZ
         Whig==
X-Gm-Message-State: AOAM530mA7OFhGEGQZbVIW+EDjcvm4gJdTRZXirIS+stpHLT0PxOmC1r
        tfhVe1hzOMtD9ja4PvgTu/TyemlSncDFiSj8lAS844MdyfRh0DJd
X-Google-Smtp-Source: ABdhPJxRzSyt/Y8sIzjFD7EarSzoUWoVuVCYNRyUmJ5rHtztmtp5l/rG03pfdydD3ty32NE5slDsc1XtYLHXQ/qQuWA=
X-Received: by 2002:a5d:47ce:: with SMTP id o14mr14297280wrc.236.1619320686271;
 Sat, 24 Apr 2021 20:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQzVWt8CBTgkjBDWE-ZP1HN6gdLd6_7HD5rhxrPypjHYg@mail.gmail.com>
In-Reply-To: <CAJCQCtQzVWt8CBTgkjBDWE-ZP1HN6gdLd6_7HD5rhxrPypjHYg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 24 Apr 2021 21:17:50 -0600
Message-ID: <CAJCQCtQW3KsuGSSJvKJdv_9m4y=f64zthv3eS0_t0U6jBuRnuA@mail.gmail.com>
Subject: Re: fstrim bug with seed+sprout
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Seems pretty bad...

[  100.274795] BTRFS warning (device vda3): 'usebackuproot' is
deprecated, use 'rescue=usebackuproot' instead
[  100.274812] BTRFS info (device vda3): trying to use backup root at mount time
[  100.274818] BTRFS info (device vda3): using free space tree
[  100.274823] BTRFS info (device vda3): has skinny extents
[  100.281661] BTRFS error (device vda3): bad tree block start, want
5373952 have 0
[  100.281774] BTRFS warning (device vda3): couldn't read tree root
[  100.284534] BTRFS error (device vda3): bad tree block start, want
5685248 have 0
[  100.284661] BTRFS warning (device vda3): couldn't read tree root
[  100.285318] BTRFS error (device vda3): bad tree block start, want
1343455232 have 0
[  100.285386] BTRFS warning (device vda3): couldn't read tree root
[  100.285657] BTRFS error (device vda3): bad tree block start, want
5373952 have 0
[  100.285680] BTRFS warning (device vda3): couldn't read tree root
[  100.287529] BTRFS error (device vda3): open_ctree failed
#

This is happening in a qemu-kvm on a raw image. I guess there could be
some additional complicating factors.

--
Chris Murphy
