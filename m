Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F9E1B64CB
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Apr 2020 21:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgDWTud (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Apr 2020 15:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgDWTud (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Apr 2020 15:50:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AE11C09B042
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 12:50:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id t63so7855590wmt.3
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Apr 2020 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qjF/3AHuVShtgStUYfepVTzhKZv5pkjntB5n65LaIq8=;
        b=fJnNCY6ugddn9cIfy4ZeOQA/5FfOKe8KPrK5HCKWn5Vn7pQmKABwdCd0v8ofNQL43J
         wb82uIZ2g6zpxB5+KTxT8Ghos9R3tFqBzxr/pUv5LHvk2knxr3XbUmRipolr3FR9uc2g
         0eYWvZ9SVvRP8Bfck+iRz0RIVyhmQnFRVye4HMzK5bSAHFa/N5Ra42FrcVVt9Uy5ELvA
         J7QFpl7jr79tNMDzWQ8E0icn6eAvAYo2157R8OySCW8etxy62RibFEjkegR1iSF0b3Er
         7MWJRfQkU9xvN7KhSO9H4vbOOqyD1qfV6/dNB2SEYYn6iPFPx1STAFzyvUE2pjpPiGPV
         sApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qjF/3AHuVShtgStUYfepVTzhKZv5pkjntB5n65LaIq8=;
        b=B0sP8flDQwVD/CuDxlsRmaKrFfdC/+nxSxCNhu9QRQIVWjfKTUw/8GJXrq4DADYWk3
         oq9wAUTCtobDhXbAfeNW50qQkrU8aG9q9XRuatCj72fWyyz/8WTLtgKf4wtui2hlGQJd
         YbfXJv3qzuGGbWRUCvTJfGxV1/+GbiUVzgN+/VtAdIOGbW+XDI6sl5WJ6D003GEdNEiX
         i+ROGDnCEGZRVrMgLXeTuQYirV3VaXaiO1m0bBy6zhJ9GRi/m5PyLRxPrNMcROCKqFa+
         /Ygmb81Ht9UpPrOpi3EgfPOrD2t71FLxrXddA0ira8ixmpxJOoh1cL/Y2ZohgZR/G3yA
         vvTA==
X-Gm-Message-State: AGi0PuaiTSlg2esk8HmnTStD+81UL6RXN1yqsWd9tLnGj9CB9HxhLJmS
        9Ci6AWJtqxa8IYbWBMmrsu+BJsNuLTDnaIFtJQE+HMBd
X-Google-Smtp-Source: APiQypKAAhCYAvHb//0Lv9bvkIeE0WUHZPVMAj7rwTQUpEHFD+hFFO60moHkkHIiY/Q/J21ZguuVq5n5UC13bVLN4M0=
X-Received: by 2002:a5d:5273:: with SMTP id l19mr6784622wrc.42.1587671431877;
 Thu, 23 Apr 2020 12:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200422205209.0e2efd53@nic.cz> <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
 <CAJCQCtTEY347CwHGz3QKaBfxvPg0pTz_CF+OaiZNaCEGcnLfYA@mail.gmail.com>
 <20200422225851.3d031d88@nic.cz> <CAL3q7H7eE4wFi95JaTYRPOrTQiihOSEqV-W4hT1t-9-ptUHGrg@mail.gmail.com>
 <20200423134248.458cd87c@nic.cz> <CAL3q7H41C6do6SdBCfCmA==TT1nPJQ4dB0vTi_jsm0tYuvvsUA@mail.gmail.com>
 <20200423140559.2762bb0c@nic.cz> <CAL3q7H4Vx0-vfxCHpdhwg0rSby6rphxVnDFYX=NnfJ_96gEfdQ@mail.gmail.com>
In-Reply-To: <CAL3q7H4Vx0-vfxCHpdhwg0rSby6rphxVnDFYX=NnfJ_96gEfdQ@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 23 Apr 2020 13:50:15 -0600
Message-ID: <CAJCQCtR-gTQW4zdJLb9YUqhvQSO2RMUwG8Z_iKQqNRZwothVhw@mail.gmail.com>
Subject: Re: when does btrfs create sparse extents?
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 23, 2020 at 6:39 AM Filipe Manana <fdmanana@gmail.com> wrote:
>
> On Thu, Apr 23, 2020 at 1:06 PM Marek Behun <marek.behun@nic.cz> wrote:
> >
> > On Thu, 23 Apr 2020 12:51:32 +0100
> > Filipe Manana <fdmanana@gmail.com> wrote:
> >
> > > There's nothing in btrfs that converts a sequence of zeroes
> > > automatically to a hole.
> > >
> > > It always has to be done by user space, either by writes that leave
> > > holes intentionally (e.g. create file, write 64K to offset 0, write 4K
> > > to offset 128, leaves a hole from range 64K to 128K) or by hole
> > > punching through fallocate().
> >
> > Thanks for this information. If you ever come to Prague, let me know,
> > we can have a beer :D
>
> Noted! (Through it will be a long while until travel is allowed and safe)
>
> Another case I forgot is a hole created by truncation - truncate a
> file to a larger size, then you get a hole for the range that goes
> from the old file size to the new file size.


I recently discovered the benefit of using both truncate and partially
fallocating a VM backing file.

I start with truncate so I can set a typical device size for the
guest's view, which I don't have the local space if I were to
fallocate. e.g. 100G local, but do truncate -s 1T. Then follow that
with fallocate -l 12G so that I don't end up with a massively
fragmented backing file.

To be clear, this backing file is set with chattr +C and never
snapshot or reflinked. Btrfs initially doesn't seem to perform any
different with sparse or fallocated backing files. But with aging, the
sparse file can get really fragmented depending on the guest file
system. Tens of thousands of extents are possible, and that does
impact performance it seems.

-- 
Chris Murphy
