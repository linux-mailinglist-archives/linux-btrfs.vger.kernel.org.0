Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6124E8D71
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 07:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238100AbiC1FG1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 01:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiC1FG0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 01:06:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36EF205F1
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Mar 2022 22:04:46 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m3so22689883lfj.11
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Mar 2022 22:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FKaaumvBBrK9yDYcVqFdXGKP27XjtOk+hkdjrp/Fues=;
        b=m6yDCCi3mV7E8+nKOOuFZSTg+84azqr2MatyM21zgnc/WVuR8roXZUzFk+wLeTUVUV
         V2kZFle8Yhj/7tLlDIwg0E8+NQ3PaO6U1LZ+G+eltElqJ8xI0b6v5QFRe2vdL9YC6Ttd
         mxR/35CpPGte09xrAA9PokvaCy0kZs/J45PklZCf24z4GPyWeYkYPZitzII/R3NCfQfM
         zCxuX4vFHoTMBXJjOlO0MbZrw7RLfa2Dvq0HcfCYv81qutSeAfAwrfw4jrwWcwobbtlf
         Ye/Oo809kotimNGgdHST6cHLjqK9G5LhZk7JHsfaAi+awduLDlIYgMVbHFjy+nKOoyso
         lcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FKaaumvBBrK9yDYcVqFdXGKP27XjtOk+hkdjrp/Fues=;
        b=Jxyppm33aQsAVgBsrnSPQjlIZ2q9SlrbfHjl1sgvG5QYSs+cgXsyPEPQuL2rmw1JDB
         dEx63u9hRA5n3qSMtCqtuuuEzymCYW+CbGLmdTTGeu7+DBIbWDykI57fiU/0rrG5dYMU
         qjqrABt/ML8YR8Yx2P1lx4KAA9N7Slls067kQuMz9dBTvLWZtgFV0l6YbprthiLRl6R2
         AIFbbGTtXphUtfbChzClTqhmyFFAdWDT3i8ZJGyYsDmx/nZl5HlQSCuBiwNvQobNZ053
         144UXjwPEIUbqT/NXOpESUwjZo1reOPq/lZneZK02Q7vvtsOYbxlj8feQrpcLeUYbzWH
         fDeg==
X-Gm-Message-State: AOAM5333v+VgG1Dxe0nqmEahNDX8gXMx4IFTzZSI1jrFzGi4Y3ifAj1O
        rFKRn+lPhWVtVzpqrdWhDnvK78lW0EyBlZS+Ey651g==
X-Google-Smtp-Source: ABdhPJzRbowPT6MnKrFhN2S+FnW+9wrlyUacj1SqnZ9xYdGAAUR9++Aof0DcIvflH3Ho1pgnke9SgRrLxx3W+IVWD4Q=
X-Received: by 2002:a05:6512:33d5:b0:44a:7d31:7773 with SMTP id
 d21-20020a05651233d500b0044a7d317773mr9145585lfg.357.1648443885150; Sun, 27
 Mar 2022 22:04:45 -0700 (PDT)
MIME-Version: 1.0
References: <5790FFB1-5F16-4E2A-9132-41B8FADD428E@icloud.com>
In-Reply-To: <5790FFB1-5F16-4E2A-9132-41B8FADD428E@icloud.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 27 Mar 2022 23:04:28 -0600
Message-ID: <CAJCQCtTwb6H2hOrNEVpsrrTT3p_EO55A91i=HqJanHZy+CE56Q@mail.gmail.com>
Subject: Re: Ref-Linking across multiple mounts of the same filesystem
To:     Alex Lieflander <atlief@icloud.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Mar 27, 2022 at 9:29 PM Alex Lieflander <atlief@icloud.com> wrote:
>
> Hello,
>
> I=E2=80=99ve been using BTRFS for a while now, and absolutely love it and=
 CoW in general. Unfortunately, I=E2=80=99ve encountered a limitation that =
conflicts with my desired usage; it's impossible to create ref-links betwee=
n (or efficiently mv) files on the same filesystem when the roots of both p=
aths are mounted independently.

Yep. It's a VFS limitation, disallowing reflinks across mount points.
And when mounted independently they effectively are bind mounts. This
looks slated to get fixed in 5.18 barring some unexpected fallout.

https://lore.kernel.org/linux-fsdevel/CAOQ4uxjNqNxF6YQK7Euo9qCg3sTHrWESw+H_=
G0c8QaXFDQhGRA@mail.gmail.com/

In the meantime you'll need to use the work around you mentioned.
Note, upcoming coreutils 9.0 cp command will default to --reflink=3Dauto


--=20
Chris Murphy
