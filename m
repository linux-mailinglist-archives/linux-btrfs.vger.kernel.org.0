Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B85E33C9C9D
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Jul 2021 12:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbhGOKaO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Jul 2021 06:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbhGOKaM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Jul 2021 06:30:12 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC639C06175F
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 03:27:19 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a16so8219194ybt.8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Jul 2021 03:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gXjeN/ZMtGiV/hYYt6JfYSR3biBGvhyWOnsSk+bqiV4=;
        b=TJ1X8PfWgiBPoQDxl+NKzGCbNLfH/lauQtqXZgHzFxT2DFa2Y3AImXRpxcT46yBqUN
         vl39p8uTjYhpP3lmRoEiLuaIxWhBABdJ+6673f0wwa69206MVhbsmEQbCenE04B6iuTm
         MzgzjYdsCQPlwiAgBfwWZ0KjHZ/pL+lOck+wjazQijbkK+OS8IVZ6nrt8fwCuNhhpCrI
         StZuZOH/dnyXcIqCr2HqO5QoqotqqbmL9OK3W1FLuU7h3uOOa+pRQ7dM41vkL5X0hN/c
         aN+Hnfw9yOrNE+F4UzbE/IML6WyLwb6MSzC3l+AMrumbSWCMz20tSiJCQczw6kWFhXvw
         RQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gXjeN/ZMtGiV/hYYt6JfYSR3biBGvhyWOnsSk+bqiV4=;
        b=E/DHWpzlYJwX0z+OlZN3ZsN2GYQk4ExkZhUvCb67r9RELWrJT3Ndbgt3piOWYV50Q0
         +qUPg6dsZTQm5a07DUQMbiTyTAvUO488ld+r7mtS/UCoAGrE7TDCbbDeDc1Ux3SkrCl3
         bLUqTOixT0am0E92X8jIM3XqIoPdbLCFfrkPXmgGLCktE//nO/ysW/ZlEL3osnYnIXqf
         HVcl73GIrEV/e12V3JgpWWr0p57Lk+x4NzLCwyKQ3+GgyN59qfxSMsa2MlhnzcZ7uYXT
         fvjtpgzvHWWaqmUvlVWnaK3MUbDEOGhBYBRA6abGw0Wc6RkPRVhiS7aRMQ485FyOd0wO
         MYew==
X-Gm-Message-State: AOAM5323vFOrmLlBmIaIUxHhzfXwg3rooEtL/B8GIKMhaJFYZQQqjyWc
        S/1b2f8tfQ1Lt0fQREJFIaP08oQkeOg8ipJwstIuOZ442m60yg==
X-Google-Smtp-Source: ABdhPJzdlWQxIoU/cVnu7jq1OH4UBKuBoo3fHJM650p5YZRQCakkOnv6HjL8x9iyLyDhjd1qknOFfJOzujNnSW1XXt8=
X-Received: by 2002:a25:258:: with SMTP id 85mr4478015ybc.109.1626344838508;
 Thu, 15 Jul 2021 03:27:18 -0700 (PDT)
MIME-Version: 1.0
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 15 Jul 2021 06:26:42 -0400
Message-ID: <CAEg-Je-JDyoWvcHZjVh-Wm-KOcV_qt3R+m-ObDzCR2kByft_2g@mail.gmail.com>
Subject: Memory folios and Btrfs
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hey all,

I've been peripherally following the work on memory folios that
Matthew Wilcox has been doing[1], and I started wondering if Btrfs
would benefit from it after the subpage stuff is done? It seems like
adopting this would be an opportunity to decouple Btrfs from mm page
size entirely, while allowing us to pick more optimal settings for
Btrfs regardless of architecture.

Am I on the right track or completely off-base?

Thanks in advance and best regards!

[1]: https://lore.kernel.org/lkml/20210715033704.692967-1-willy@infradead.o=
rg/

--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
