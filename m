Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBCB3AF90D
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Jun 2021 01:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbhFUXRX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Jun 2021 19:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhFUXRX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Jun 2021 19:17:23 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C350C061574
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 16:15:07 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g4so33591473qkl.1
        for <linux-btrfs@vger.kernel.org>; Mon, 21 Jun 2021 16:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTfNDJzejXnE1YW8pbjEhPLN4XT04vM7ykkceXdecBs=;
        b=sQ64T8l5rfZD9ADMEfrH9nA3UfwQfgVY0FereaidraBr9Hbi+JxaGPvKtxganah7cO
         +zt04OYcU4UlmGBQhgER9f6sYGmnauh/Eqzj6QEJEFnXiVLIhpV3/YN4G1Pzlz3R6rS2
         TzHOX5sxg0mN02hu7f/uuDiH+M6GlBi7n0gWOtHWM89MNW1YwAomTUjr+mJE581L6Huk
         MOaaxtYvOEYF0i8k6kjmzgMV+4Ag76kXlB+cWxqO1upbxmgRUSp5AKcbJ+uLcRKt5nEa
         AHgB7TYrEpYh/MKXXbBEJcVy8BQ3nx3azDAEDTuvyK4VMSbzDOikJ4MoEq6D/1oBKlCO
         /MiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTfNDJzejXnE1YW8pbjEhPLN4XT04vM7ykkceXdecBs=;
        b=YSTP5p1H4i91dxy2U+zopgrTz4m1CoEhUvJsVSQau0pCMRB4tuNyMheaNU6jFAxAn2
         oLUNfrSa5uJiBNtmatCV/F53KisbqnVAUIBrvmPBmwalVmy4PyUAX1ns1jViTtzFDJLZ
         /LICBJFimBYyRlJyKy+mH6nzhdGl3aKwvH8vGad3sPUb4npa/j2cOXCfZFQ+P0BHm7MZ
         +oqmvkx0aa5Rdc2ZM0o6csTqKTPFEQb/enPoTShsUraYbJ/HC4BJ1l+JcXouEP6O6xWi
         JYiawb0Mq+635MNXbQ8bwmVp/UGIqHHmB/qVBDxnPS5uusJ8R+S1vseUu59NNPacnPYT
         WhJA==
X-Gm-Message-State: AOAM532dVdNl2BUF9Dc61LNoRsJmcXBIzpzJ/gFfxLmJNS9SghNe4QiN
        3A8s+Njk3WWzWK82wLEpbAZVVn2pifkFdb5G5PI=
X-Google-Smtp-Source: ABdhPJyAMwmC2RmUV90mgAbcxa+yyispCm9NkD1L0aHS3qeHyAsNnzHSDIedEYlTPKwBqqI4NFJ315euvkmjO2w8E9c=
X-Received: by 2002:a25:4055:: with SMTP id n82mr779792yba.242.1624317306651;
 Mon, 21 Jun 2021 16:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <2bb832db-3c33-d3ba-d9ae-4ebd44c1c7f3@gmail.com> <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com>
In-Reply-To: <1b89f8a3-42a4-3c6d-aec8-1b91a7b43713@gmx.com>
From:   Asif Youssuff <yoasif@gmail.com>
Date:   Mon, 21 Jun 2021 19:14:54 -0400
Message-ID: <CAHw5_hk9Uy-q=9n+TvtiCtLH5A08gVo=G4rUhpuQyZwzuF68dQ@mail.gmail.com>
Subject: Re: Filesystem goes readonly soon after mount, cannot free space or rebalance
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu, thanks for responding.

On Mon, Jun 21, 2021 at 3:42 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:

> Can you delete some subvolumes/snapshot to free some space?
>
> In such critical case, I don't believe balance will do any help.
>
> Regular file deletion also needs extra metadata, thus maybe only
> subvolumes/snapshots deletion can help.

I have tried removing snapshots, but the disk continues to go ro -
after remount, the subvolumes are still there. Is there a way to force
a sync of the subvolume removal before the fs goes ro?


-- 
Thanks,
Asif
