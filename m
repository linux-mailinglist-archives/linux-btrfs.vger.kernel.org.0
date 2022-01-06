Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3844E4867B7
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jan 2022 17:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241280AbiAFQbm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jan 2022 11:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241273AbiAFQbl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jan 2022 11:31:41 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF4C061245;
        Thu,  6 Jan 2022 08:31:40 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id d1so8971582ybh.6;
        Thu, 06 Jan 2022 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZM6UOM3FnObRgkqEaRi7ZwsD77LyLEAv2E7+Qwz8Kpo=;
        b=VFCxEpktrpxVRGftdbTMwrw0K0F4iRBgf/FyutcTsvjBshi4XyaAR9z8aQ1XSsuPMW
         XZwBWhC7xGFrRA7qJ7ZCdRCnCl3IG07J41NrYQOdtNeZqyCkfb5gxVv2gzovjf1S25Cj
         nJ29mE0DJcinUaYPSRFG5CMLPZ07BcCe7mxdeI68C44G5pvX4NxPtvOQ8OJOdUKqp5MW
         C5sEj1X1RkO53v91PxhkmXXMFrJzFHg/ztn4QrrH3hd7EKUzxrmaIm7JXC15fZEf4G8u
         1vEdnf77nA9yfZBXMbnpXAZTi/STZdYof23Fsi08VjH8kIwtknhGklWB+Jhh+1ZfaWgr
         yZlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZM6UOM3FnObRgkqEaRi7ZwsD77LyLEAv2E7+Qwz8Kpo=;
        b=HAdMAA8PwLOscZQ1cBHKBbmtEetjaQkccNhmX3OmmySSveXYpCVn55Qmea+JvOHcyL
         i9zwFgiooAKkZfJDkwLeenoanmhziH/BM07k/fC7JaLnwWibeUeJMEn7J6i5ZdZmmOwC
         v7/feSSDHLTXmFqipKdgrrg6wiNr5Askimj6jN+KoR9oB7+vj/yL3DC5gHnvEHn6LZRO
         txf8LpW99zF22cTMUPSL9UoK4nYKQ8Pb+luPox5ssuGH34ScOV5ZJ7tvuAfepDdo+JwI
         I6NPyiDTyIls8FpNdi69pf+3SWmfnGe65mWHYeTnPw1mXTp3ndC1BDZqFWSmF91qFB9w
         EcpA==
X-Gm-Message-State: AOAM5307/5xI4K8ylF/TDg6t99mx9yasnwJRzmXVJB/rgVw077Mq5cJk
        lFX/cYYM6fJ1X361g/vSpuzm8qkHWwidlRETCTM=
X-Google-Smtp-Source: ABdhPJzNdTP4XFd9P9NPS3ZzTPTsau2wGRp5cUn725XM9mHDW1ZcoJ4wEL3J1x4enMFKNDk4Az+hl/frDFPXPcgZERY=
X-Received: by 2002:a25:d708:: with SMTP id o8mr65492245ybg.582.1641486699930;
 Thu, 06 Jan 2022 08:31:39 -0800 (PST)
MIME-Version: 1.0
References: <a16c31f3caf448dda5d9315e056585b6fafc22c5.1623302442.git.christophe.leroy@csgroup.eu>
 <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
In-Reply-To: <6c7a6762-6bec-842b-70b4-4a53297687d1@gmx.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 6 Jan 2022 11:31:04 -0500
Message-ID: <CAEg-Je9UJDJ=hvLLqQDsHijWnxh1Z1CwaLKCFm+-bLTfCFingg@mail.gmail.com>
Subject: Re: [PATCH] fs: btrfs: Disable BTRFS on platforms having 256K pages
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        linux-hexagon@vger.kernel.org, Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 5, 2022 at 7:05 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
> Hi Christophe,
>
> I'm recently enhancing the subpage support for btrfs, and my current
> branch should solve the problem for btrfs to support larger page sizes.
>
> But unfortunately my current test environment can only provide page size
> with 64K or 4K, no 16K or 128K/256K support.
>
> Mind to test my new branch on 128K page size systems?
> (256K page size support is still lacking though, which will be addressed
> in the future)
>
> https://github.com/adam900710/linux/tree/metadata_subpage_switch
>

The Linux Asahi folks have a 16K page environment (M1 Macs)...

Hector, could you look at it too?



--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
