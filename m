Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB8EF3C2350
	for <lists+linux-btrfs@lfdr.de>; Fri,  9 Jul 2021 14:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbhGIMSm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 9 Jul 2021 08:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhGIMSm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 9 Jul 2021 08:18:42 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457C8C0613DD
        for <linux-btrfs@vger.kernel.org>; Fri,  9 Jul 2021 05:15:59 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i4so14348763ybe.2
        for <linux-btrfs@vger.kernel.org>; Fri, 09 Jul 2021 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GBjT5Kh4+ziC/ddK3S4EmQTv0tov62LShuAlfMF3YXg=;
        b=X4VIwc19yWXJ2HzHZv58u8T+MqL2w0OoHC6dqUReswTsc3mox0FCRbmJ2Rw4OVmUco
         BWTEGRTMdsYdA1/s4/WlEUudD1f4kZuEuqHssZozsIpQlP4lIBL4AKIvWR61A9WCNXUZ
         m/J/zn5QzBtlVNEU3F3A1fh5GvwyrFEHyYXV3Ky209jwnpDfhoQ1ZbeSA6LhWmzcoTJe
         oOCm6jd9NJ/Lgc0z5+3jumRrn9EmTkgj0ZyY5M6VNVq/BUlCyo0d4ayL27ICgiGTMp7G
         E6VGsgk/OP20jUi8vTlQBr4IK2avEdsG678Llwx3v3zvFgJJsHC36BUa+qkto7P4tsYq
         SgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GBjT5Kh4+ziC/ddK3S4EmQTv0tov62LShuAlfMF3YXg=;
        b=HRHrKkVCrxdDqTG+CNfG5ARCb6IIAkzEb3Flf/IP9ZqOFcxMiWhCXp5hJJX+yauaNE
         WVMSXRlgMdmNWCwV9HXLAYpvXZNB8f5Gk5hrTsTXi+FbOI1E8qQTTVM13GfhmkI3C1aA
         FAiVFnPqVgYcq5p2ZCDDkswKyHKT+fLMaAhXPz8LXe7ueb9ZJuPIwBQ0xILek+5C9OO2
         jMp7qs3MJ4hX5ExZsUvf0xUspPC8ud88G3Iabs/SeY/fFMqHg5ZbUjSJIlB2qLuf3jSp
         siGjLfo8jaPyrqclbRdn85WWy6d0OWqCIi1QvLZMo6MHCloihnSHObq5z3Kb+bAMB4X2
         n0rQ==
X-Gm-Message-State: AOAM533J5nFQ1kD6jQ+2XcmRc8n0Z3GxR447RgWSRxfQgUoAvWUj/otb
        T64uU3TgRV8ETczU5v5UvPiTRgJJsCdj23EixHo=
X-Google-Smtp-Source: ABdhPJwTMfiD2/e3L/mqt7zn/oCbDIO/0xA2Q4qAl08MPsB/WbrP8vrTP/U0FYaROC0IRH+XIumWK8dAjnADxb4zS3k=
X-Received: by 2002:a25:b203:: with SMTP id i3mr46300553ybj.260.1625832958338;
 Fri, 09 Jul 2021 05:15:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625043706.git.dsterba@suse.com> <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
 <e6a4b354-879b-a767-3f21-2535e38e8571@gmx.com> <YOfwuQPtXScmFULF@infradead.org>
 <dbddba2c-9242-d8ab-3969-86e7b2974727@gmx.com>
In-Reply-To: <dbddba2c-9242-d8ab-3969-86e7b2974727@gmx.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Fri, 9 Jul 2021 08:15:22 -0400
Message-ID: <CAEg-Je9ESQ+Qvq7uVvV_K3ZGgNrD-kYzJMJif=3e5cCe8p6aXg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Sterba <dsterba@suse.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jul 9, 2021 at 3:12 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2021/7/9 =E4=B8=8B=E5=8D=882:46, Christoph Hellwig wrote:
> > On Fri, Jul 09, 2021 at 07:53:39AM +0800, Qu Wenruo wrote:
> >> Sorry, I can't see the reason why it would cause performance drop or
> >> higher memory usage.
> >>
> >> The point of HIGHMEM is to work on archs where system can only access
> >> memory below 4G reliably, any memory above 4G must be manually mapped
> >> into the 4G range before access.
> >>
> >> AFAIK it's only x86 using PAE needs this, and none of the ARM SoC uses
> >> such feature.
> >
> > Arm calls it LPAE, but otherwise it is the same.
> >
> Yeah, and I have never seen any toy ARM boards using LPAE neither.
>
> Either those boards have too small memory to bother (<=3D 4G), or they go
> directly aarch64.
> (And most boards are even aarch64 with <=3D 4G ram, like RK3399 or Amlogi=
c
> SoCs, they are aarch64 but only support up to 4G physical RAM).
>

Raspberry Pi uses LPAE, I believe (RPi OS is 32-bit for support for
all RPi models).



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
