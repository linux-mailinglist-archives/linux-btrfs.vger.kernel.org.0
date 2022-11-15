Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA09F62A156
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 19:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiKOSa3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 13:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiKOSaJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 13:30:09 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AC0BE31
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:29:56 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id m204so15762281oib.6
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 10:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OpAYd7rsGeOL9Zk0yXxQbGCFMcXh75AOUqEgUp/zXTw=;
        b=k7Sru6iQrjY9eIBZcTnPAhUJ37MHPsBPFY81+GB+lWFmgy9+7t2eXfsOsfVIYTkO4P
         yk0wS/ISJyQY/NrB45BwVBZOwBzl98CYGwDDFZzEHVB1S+H1vgHKuZWs+cYnpz+T+B5L
         d+UCLgPkZvnLfN/WbwzX0uimMwY+QDyGRruKPIiZ8D2qljyz/lq8eoLoO+BO1vuKXozL
         6Kv3PaJsTSLL4+j8/WTXO8dskEWD8OKvA0RycuVQnkEotHVDFBR2MiRUh941qk0nmZcc
         72ediQkWnRbISLczZ3Fo0o07QioqnQUuhaIlnyuk58Jpa52c9yfzKmOcm6LErQd35+uK
         begg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OpAYd7rsGeOL9Zk0yXxQbGCFMcXh75AOUqEgUp/zXTw=;
        b=JKC4RwSJDxlsOSRTztV0GHzxKqybVTLcbHTO4Fv+qCemtSkyad+7tTsHs9WjjC2gfe
         KpT6GuSLVc4NmeZGQYkh+IDN2EQhtTdzK5RGDNSIcZ0D7+T/WyXF9HC3NZzbti6O7XFe
         zcasie98pcchwkzssoTuvFPBtcLdE8o68EGpn9r2jje3QdTsrBnHoSrflXwqhh21BcXl
         0tdxFnJloD5OZPhrlvAMaYqpONc7n1UHcsXYEDwpb8iFCWg03S2eqdY3ooM5zd/w2ago
         V6ID3EijANRfDAK4+eRX/epAZhAsIQt0vqGUFkUJ/aLoGeVk/s0THlwjFWBnf4aTcUTa
         PhMA==
X-Gm-Message-State: ANoB5pkZt71mqkyAX66h8JI9tL8wq1A6K0bNSU6ZXn/xKKwPQdenB72v
        CKo6pEQckkLclQGQo4ZOqHSLZPztNhx0haCxRLYWRh6Uc7c=
X-Google-Smtp-Source: AA0mqf4Kz+kH+520/uF2ZHT1DTT7NMcs4yIysxdyPtPYtjT+iNt7gZG3e3eQuSyZDRt3v/4nBuhIA7sDkJ+QyE7lmm4=
X-Received: by 2002:aca:1e06:0:b0:35a:1139:37fb with SMTP id
 m6-20020aca1e06000000b0035a113937fbmr1044026oic.158.1668536996263; Tue, 15
 Nov 2022 10:29:56 -0800 (PST)
MIME-Version: 1.0
References: <1668353728-22636-1-git-send-email-zhanglikernel@gmail.com>
 <f5cceda5-e887-0807-7331-12382b45ea29@gmx.com> <CAAa-AGmQpL34eG8yx3bg8FYcbbOOjb3o8fb5YEocRbRPH1=NBw@mail.gmail.com>
 <11a71790-de79-3c2f-97f3-b97305b99378@gmx.com> <a4ebbed4-f75f-16d3-34d0-838d73d031f9@gmx.com>
In-Reply-To: <a4ebbed4-f75f-16d3-34d0-838d73d031f9@gmx.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Wed, 16 Nov 2022 02:29:44 +0800
Message-ID: <CAAa-AGmqmnKyQ_LgxB-oVnP+8tP9QChSq2M_SPhtgPQBxd3Skw@mail.gmail.com>
Subject: Re: [PATCH] btrfs: scrub: expand scrub block size for data range scrub
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C 18:37=E5=86=99=E9=81=93=EF=BC=9A
>
> [Adding the mailing list, as the reply is to the first mail I got, which
> lacks the ML]
>
> On 2022/11/15 06:39, Qu Wenruo wrote:
> [...]

> I'll try to craft a PoC patchset to a stripe by stripe verification (to
> get rid of the complex bio form shaping code), and a proper bitmap based
> verification and repair (to only repair the corrupted sectors).
>
> But as I mentioned above, the bad csum error reporting can not be easily
> fixed without a behavior change on btrfs_scrub_progress results.
>

Actually, I also considered refactoring the functions
scrub_recheck_block and scrub_recheck_block_checksum to import a
bitmap to represent bad sectors, but this seems too complicated and
may affect many things, so I choose
Handle newly discovered errors by recheck in
scrub_handle_errored_block, ignoring recheck errors by exchanging the
result of the first check and the result of the recheck, as follows:
else if (!check_sector->checksum_error && bad_sector->checksum_error) {
 struct scrub_sector *temp_sector =3D sblock_bad->sectors[sector_num];

 sblock_bad->sectors[sector_num]
 =3D sblock_to_check->sectors[sector_num];
sblock_to_check->sectors[sector_num] =3D temp_sector;

Anyway, I'll take a hard look at your scrub_fs idea
