Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742FA2D2B34
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Dec 2020 13:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgLHMi4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 8 Dec 2020 07:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLHMi4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 8 Dec 2020 07:38:56 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6EC0613D6
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Dec 2020 04:38:16 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id w139so7770938ybe.4
        for <linux-btrfs@vger.kernel.org>; Tue, 08 Dec 2020 04:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TzUvJTAbaztlMbm5FtUHRnFcHSpCJ6upx1fcqZb5gtg=;
        b=nFGOBX2o5ZNpC88qH2BgY2zXdg85Vgk+5tHbikuzC3o9Rcg1Xtw68s/PGbX1J1C9qw
         oqpeRdr0/nr9/OuEygnRr7FL695LJp73In+5FxsXbwjBL9/9TVJQbxs069rifFoXgNI4
         4y1DXHHNjCf2uXKdRsccXRgV5yiGwgQ5Lk1xGzmTcWLe4yPiq8TnLJ6aXwRNfIffqbuw
         r7JgNRaJF2uzu0PSF15jyIra4VPZIAPCUUF7pzdfeVZvyu0OV6NxIACawRwTgmpqGQHl
         OjaCgyEqQGYQuUnkLvLMoHg/XuXLW41LucziBZ/hR3HHWnNZWKlXc3Xb9STqAbM0Yall
         rahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TzUvJTAbaztlMbm5FtUHRnFcHSpCJ6upx1fcqZb5gtg=;
        b=bIXuqkM2tRswftg2+ENFGS0Cg7K0qd1RS2ACEXysV05a9SEaLztUW50nWAvr0/fsAu
         CrDaG/7vjlmLxeI4A+POuhviulz7yfLHEfJeVRWw9Np+kIwPjiyvli2T6wfwK10uXent
         tkYZmaiaLCDZYV1nEPKL28E0znCNyuSfaetsP53fvPWXxb3TtsAGQOY1sQJosueYj47X
         xaQhIzgGhQjTH2yLMSNIXUtBVkgPxrdbfzta7JBNu0bL6zYyH/5mMKeIjDqTo8orJQ5j
         up4ZQKm/s5fwDcRpgEop9gzLVH0MVbDSvPkKDh8V0Dz1w3MMc5NvUdPElZ6nJN/ZRU/5
         li/w==
X-Gm-Message-State: AOAM531V1fD44HSvwrrJbMfJN/xyGmgIHvI4hGiFQka2xxoDCtdn2wdN
        bJ9u5t7WOpOcjLI9hGd+NRTBwkvcERhPumCupDBTL7yE/hM=
X-Google-Smtp-Source: ABdhPJw1Vvn0O4AjjuNG520kP9Qi0NvtqTLjDfKyPmfIm+MouTtdiDZnfNfo6mQ6956yRpcImJcfMA8mrV5ClxOw4OA=
X-Received: by 2002:a25:3f85:: with SMTP id m127mr11106717yba.184.1607431095278;
 Tue, 08 Dec 2020 04:38:15 -0800 (PST)
MIME-Version: 1.0
References: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
In-Reply-To: <b927ca28-e280-4d79-184f-b72867dbdaa8@denx.de>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Tue, 8 Dec 2020 07:37:39 -0500
Message-ID: <CAEg-Je9iUAn+9H7p+qm8D+bSY382VkTKZ0H4ExNLePAEZT9nEA@mail.gmail.com>
Subject: Re: btrfs-progs license
To:     Stefano Babic <sbabic@denx.de>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        David Sterba <dsterba@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Dec 8, 2020 at 4:52 AM Stefano Babic <sbabic@denx.de> wrote:
>
> Hi,
>
> I hope I am not OT. I ask about license for btrfs-progs and related
> libraries. I would like to use libbtrfsutils in a FOSS project, but this
> is licensed under GPLv3 (even not LGPL) and it forbids to use it in
> projects where secure boot is used.
>

Please don't use this phrasing, because it's not true. There is no
circumstance where the GNU version 3 licenses (GPL, LGPL, AGPL) are
incompatible with secure boot environments. What you're talking about
is an additional restriction *you* are imposing in which you don't
want to make it possible for the software to be user-serviceable for
any purpose. That's not the same thing as "secure boot".

> Checking code in btrfs-progs, btrfs is licensed under GPv2 (fine !) and
> also libbtrfs. But I read also that libbtrfs is thought to be dropped
> from the project. And checking btrfs, this is linked against
> libbtrfsutils, making the whole project GPLv3 (and again, not suitable
> for many industrial applications in embedded systems).
>
> Does anybody explain me the conflict in license and if there is a path
> for a GPLv2 compliant library ?
>

I'm not sure there is a conflict, but there are relatively few authors
of the libbtrfsutil code, so we could get the license downgraded to
LGPLv2+ instead of being LGPLv3+.




--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
