Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9F3F31E7B0
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Feb 2021 09:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhBRIzD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 18 Feb 2021 03:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbhBRIxX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 18 Feb 2021 03:53:23 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2034C061756
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 00:52:38 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id a132so2188973wmc.0
        for <linux-btrfs@vger.kernel.org>; Thu, 18 Feb 2021 00:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7WyF8aYOWWzE3g1krWfrmfJb8I4DdC10tohQ6zIPYzo=;
        b=ooKXZpPmyOKdFGSzXU4Q1KeMdpIoedCW1AcVhtYp9KFAdQdLDjKEnW0r/5Ma3JbNyp
         +ZpEGcaAbQToIkx5iD82S+epEmItIwU+ySsJK5uutQ4mz6oUjVmeGwysyJ513paV7CHB
         fkpsgY6Ub+/toTL8c+4l5LlEKK5iWs5IGhtXOKSGv9Gs5RJV2vBdvR7DG2lVY2VZGO+5
         oZJCYHSyEKSmxImobPEjgxciMc2GeJIfTI6sRWt2gh+rzY6Ue6XyW+EcFR9sQ5Tx+o8v
         r186fFT3njohBn4XJOOety9Jp5SZxqnfYo2UwgwdxT/LY6ek5i77BFlkT2ztyv3qGd6u
         Xh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7WyF8aYOWWzE3g1krWfrmfJb8I4DdC10tohQ6zIPYzo=;
        b=Y2k68PORzUTcy5lRZO6U4uZxXOeYslVObSIRWocriJPuwRut84sYBCt/pHWWA/UqD3
         tweRLWD7gbCudCs6D+KhWgKbP7aAGvKA8oEG1PIEUHO6NDt0rp1s8yWtKkjkmefYguik
         qjkeCjzHXp34vKR61GR13nKM+caoRq3bOj7XLNpIyspQ8hBkj8K/uxVoG/+GVxjGgMJ+
         wVp8D1/9ZFpntTIG7rZ/hEHn8XMVJgGUncWaU4NOBBPKLUR6jm/1wC4gTLyBXoAEQSOF
         ukF44qmZtan3CgjYjTKcuYXTE3sNtb4TztKMIfu/mDnool2fpVv0tMdnEZo1iV8px7O3
         N3vQ==
X-Gm-Message-State: AOAM533Ze4Ds32dA5gvR/eVl12+2eOIrRwmnD9hyk50FiN3tqVyNKVZv
        N2KfAP0kQKrc0w3o+bBT/VBk9P8peMfIp6nAkdGnAwp3BPBZhnUV
X-Google-Smtp-Source: ABdhPJwT4KJmiMBuffZaaLCq0gDa04brm0F/9tQcKxQyOQSjzNqhBNm3zZJxePkTSmNII7x1IBMkKY60LhlQAQxHh3M=
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr2606397wmg.12.1613638357398;
 Thu, 18 Feb 2021 00:52:37 -0800 (PST)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <CAMj6ewPtDJdkQ=H3DO6BSPucdkqSoHOkeb-xgTd8mo+AaUWhkA@mail.gmail.com>
 <16d35c47-40c5-25a9-c2ba-f6aab00db8e6@gmx.com> <mtwofibp.fsf@damenly.su>
 <CAMj6ewNYSnFUFPER06qweZaypWC6qVHmUX7gYxRXO7Gbuw_16A@mail.gmail.com>
 <CAMj6ewMSw+UzZHhEEN=rhxN8O3pN9gWA05usAodk2xX5+s-Qjw@mail.gmail.com>
 <7d32a06e-dc2e-c2c4-ddce-1f2693980c5b@gmx.com> <CAMj6ewOc+jJAo=rLmH_mBzaqO10daPkcN5XacPiwx6eh9PVvBQ@mail.gmail.com>
 <90ce8de3-c759-da91-f89e-3d1ac7b3d049@gmx.com> <2ac19a21-1674-b34a-7e0a-8a5744f0513a@gmx.com>
 <CAMj6ewPbivS1yZOmvT22hJsMxHGK-fWhyGgm3PJ4TVUbo04Eew@mail.gmail.com>
 <b06c1665-7547-2321-3863-4c68c9818f90@gmx.com> <CAMj6ewOze4Ngw7ydj_Ry2nLeyvWs_dB=fuGJ2zBdCEepTiC6yA@mail.gmail.com>
 <c6c8cb80-455a-181b-ada5-83001d387044@gmx.com> <CAMj6ewP-xUUa2G448HhPDPV9ZB7XiYVf4eCv+SMMtLH5MzTJ8g@mail.gmail.com>
 <08061b36-c49d-9604-49dc-7e85720b5040@gmx.com> <CAMj6ewM2wr2tRrMjRk+sztH0nD7RG1J4tXKfoekg3-rqEL3RWA@mail.gmail.com>
 <50599154-2ab4-2184-7562-f0758cf216eb@gmx.com>
In-Reply-To: <50599154-2ab4-2184-7562-f0758cf216eb@gmx.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Thu, 18 Feb 2021 00:52:26 -0800
Message-ID: <CAMj6ewPGbkxH-OdsRt+xKQyLUUgR3J7dV7Xcf9XMq2-E=n3-tA@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Su Yue <l@damenly.su>, Hugo Mills <hugo@carfax.org.uk>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Feb 18, 2021 at 12:38 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> We got it!
>
> The eb->start mismatch with page_offset(), this means something is wrong
> with page->index.
>
> Considering page->index is just unsigned long thus when we initialize
> page->index using a real u64, we truncated some high bits.
>
> And when we get it back to u64, the truncated bits leads to above result.
>
> The fix would be pretty tricky and with MM guys involved, and may need a
> much longer time.
>
> I guess this is a known bug, as page->index limit means we can't handle
> files over 4T on 32bit systems, even if the underlying fs can handle it
> (just like what you hit).
>
> Thanks,
> Qu

Thanks for digging into it! Is there an existing bug or discussion I
can follow, or any other way I can be of assistance?
