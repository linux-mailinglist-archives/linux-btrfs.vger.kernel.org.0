Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55D95F376A
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Oct 2022 23:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJCVDE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Oct 2022 17:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJCVDD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Oct 2022 17:03:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF331CB3C
        for <linux-btrfs@vger.kernel.org>; Mon,  3 Oct 2022 14:03:02 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso16381206pjf.5
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Oct 2022 14:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date;
        bh=iV+tGHitMbQ1j6mk6mC7qK6hokt/utgy/q3ojU2z20Y=;
        b=MOrAgvvT1EW/WbUiLUldYpYA65WQU3Akmn8J/sgZfdMm6k0fh/fr65nC0C0XPFZiSL
         os/UyYR1A5gZEXRghW9afEfptcZIWfPKpol4Bv+g+pcvZfwQL5LGd0iF053+iMmxbvo+
         e5XTonHLKOa8iXwjaG5cPolzfs9ti4OhEFpXupnSFy/QmBTdGXmmyS0+wnx48ap+Pc/a
         hBCL2B6VvTWtRvU330sllN3tZDFMfIuzQK+6ZzhKbo786PEJq3bdm1t7IC+6AstGTv5L
         sxgrds+ByJY+SJIQ8Scil0tE/Fc/Z6GcLb+UbsDuxjNWFIkruROu45D8QnDh45sg4dae
         v/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=iV+tGHitMbQ1j6mk6mC7qK6hokt/utgy/q3ojU2z20Y=;
        b=pSTZjHSFKi7k1CdJDU9GC75BLRd4huJL7mLPZEbREWZ5aVKCtjKYW0rt3ZaQ1hl9eH
         KPirJrYM7YxgVLXqgOQG87vGkl5CJwPWtnjaEY4o0wx1zDksxkYoXdyZksH9hCgNf5xg
         tvTFn4dHtCZcnThfegY5YHn2xy17h6PKXkptM8uCx/WZ6J3qrQUSRjSwo5dv6BIdf1FY
         FFf8BsW2iNZxdjTQPDDuXqMl8ygcpVECvADaCT8vQUXkhC6Vxqd/hpYo7kgSi5KKjq6P
         jX4aKNpb4qviO9GZFZRwKsD/wDIFHH9ZsQMl0a8oJ14VdEDn4p/DsOCtOO1iIaUFyatp
         aaHA==
X-Gm-Message-State: ACrzQf2ivZMCoqF/hm2TvX7beZEMxpZ4mGO/O/Eg35F2MNayEUi+oHkH
        m9hRM4d05UDMTlNoaYP8jI23yR2bdqIZHjpQVd4=
X-Google-Smtp-Source: AMsMyM4+1dJBSx6D1t3h67wsdKfiZiGla4i8kHOOfM16EXMAgl8Xtvgr9fM1cg/cOLJSFXrgpptokkBGAUfokbjDzOw=
X-Received: by 2002:a17:90b:4f45:b0:203:6d82:205c with SMTP id
 pj5-20020a17090b4f4500b002036d82205cmr13757814pjb.224.1664830981708; Mon, 03
 Oct 2022 14:03:01 -0700 (PDT)
MIME-Version: 1.0
Sender: akamagildas88@gmail.com
Received: by 2002:a05:7022:323:b0:45:dd87:b06c with HTTP; Mon, 3 Oct 2022
 14:03:01 -0700 (PDT)
From:   Miss marybeth <marybethmonson009@gmail.com>
Date:   Mon, 3 Oct 2022 21:03:01 +0000
X-Google-Sender-Auth: 2GzYt5K-ZrxpkTy1b3GI5iLADJw
Message-ID: <CAH7gr9X6fi07R0pqK533Vh=18zkcsWuVtAF1AdDc8mHm20hcQg@mail.gmail.com>
Subject: RE: Hi DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Szia,

Megkaptad az el=C5=91z=C5=91 =C3=BCzenetem? M=C3=A1r kor=C3=A1bban felvette=
m =C3=96nnel a
kapcsolatot, de az =C3=BCzenet nem siker=C3=BClt visszak=C3=BCldeni, ez=C3=
=A9rt =C3=BAgy
d=C3=B6nt=C3=B6ttem, hogy =C3=BAjra =C3=ADrok. K=C3=A9rem, er=C5=91s=C3=ADt=
se meg, ha megkapja ezt, hogy
folytathassam.

V=C3=A1rok a v=C3=A1laszodra.

=C3=9Cdv=C3=B6zlettel,
Miss Marybeth
