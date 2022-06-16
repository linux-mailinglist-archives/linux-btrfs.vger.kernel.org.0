Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEBB54EA9B
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Jun 2022 22:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378055AbiFPURY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 Jun 2022 16:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiFPURW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 Jun 2022 16:17:22 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72465AA68
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 13:17:21 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-30fdbe7467cso24365037b3.1
        for <linux-btrfs@vger.kernel.org>; Thu, 16 Jun 2022 13:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mmISoP4JhJXjfK+WSbYFhBwCTOprauXnx9/enZ+vp4w=;
        b=mk/LqIvsSbhJQtzIUf3XQ7Dj51U0fcGdFd1rWA8+8feS6mKi3PkxVKHUNBd6iOWHV9
         3LvZBYI27Zd9AOIdOQ2djvPFyTLuNja4kPDhAQwzGLouhEDYlbTZw0FEf2tHONPRIaIb
         V+drDRU4BY/6qEKL2sPIFFd1oKqX2xZRGBvKax3fU03VWBS7aKT9B2ldR2Ygi2zguHFi
         8MsxgOb+eV92D6hnQaOqVUdi+0KT9jxOp6nNuU+Kalr+nAOVqF2qrhODH1vdFpFRNogp
         5jsbKcSlz8Un8d07keQWJlnuDxMbTxXuqEhKexZ7owUvrg8lq7J8ISJAvTSGZpErZm5K
         rTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mmISoP4JhJXjfK+WSbYFhBwCTOprauXnx9/enZ+vp4w=;
        b=hxg2rDymCFdtJZyr1rdCbRsKib6zjpyaQiR9uuT3gDztOOfL1yzTR+GSp7GpDf+dqU
         5eRCBRPU1GjbUrZB3L18XqyHXUGIwYjw3P6uInnXXyoAZUrWVes/UmSC21/v34E+epUJ
         wLfY+a1+/TKJk86yQc1rlT2gVQWjDymPazvuuBE+WcvAbLFm32nUMp2RUbuFipocKWVo
         Plq4rVGGNfD3GqgZbx5uCWMayifZ4xyeeO/0Q1f4vVqJD49iWI5R+KLQ5NFaZnvxrv26
         pJZcBoVxuz7ce79SIu9JxmRQmgvqJMjQMRZr2Tla9O0+dWJWNO7HoeogjMuDBiK3v+oo
         RzIw==
X-Gm-Message-State: AJIora9virJpFh54DLFKGE4vASKkNJJNj2sj1+jcy4jVH370VeZeJrUw
        /+PYQM5te/nCsTXcS8LzR18smwUF94UjPtSsVjy6/uXVdU0=
X-Google-Smtp-Source: AGRyM1sZ2qCmz/LcV7ULdBgwgG8aXelsZ4R8O1j8nYnqjU08VU4fltQml8m4mKgaCGjZBSuzAe+8bZZI2CdwiXr9p7s=
X-Received: by 2002:a81:7243:0:b0:313:acf0:7f0c with SMTP id
 n64-20020a817243000000b00313acf07f0cmr7657277ywc.8.1655410640783; Thu, 16 Jun
 2022 13:17:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220610191156.GB1664812@merlins.org> <CAEzrpqfEj3c5wodYzibBXg34NxtXmQCB60=MtD+Nic2PN8i5bQ@mail.gmail.com>
 <20220613175651.GM1664812@merlins.org> <CAEzrpqdrRJGKPe8C1VvbyPaV3iEDtD1kB_oMiUP=bCs37NfSZw@mail.gmail.com>
 <20220615142929.GP22722@merlins.org> <20220615145547.GQ22722@merlins.org>
 <CAEzrpqdRn9mO0pDOogf37qWH07GryACqidHDbZcpoe7t73GDeQ@mail.gmail.com>
 <20220615215314.GW1664812@merlins.org> <CAEzrpqfZMA=NjqAaS1XKZgguD5L73kc7zKFL+cVHnMGxdK6rXw@mail.gmail.com>
 <20220615232141.GX1664812@merlins.org> <YqpqVSvxP8Dcz53V@invalid> <969bbc68-7dfa-dedf-55c3-da882c5bf0e3@dorminy.me>
In-Reply-To: <969bbc68-7dfa-dedf-55c3-da882c5bf0e3@dorminy.me>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 16 Jun 2022 16:16:44 -0400
Message-ID: <CAEg-Je8vMxb72qEm0Yz6X6UjiNYYvSSkjO0k+g6dkZZFosGPww@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Cc:     Eldon <btrfs@eldondev.com>, Marc MERLIN <marc@merlins.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 15, 2022 at 8:24 PM Sweet Tea Dorminy
<sweettea-kernel@dorminy.me> wrote:
>
> I too found the back-and-forth very educational and suspenseful; many
> thanks for keeping it on the mailing list.
>

It reminded me of my own adventure with Josef a while back. :)


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
