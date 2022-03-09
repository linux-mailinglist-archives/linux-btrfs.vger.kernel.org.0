Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCEF4D3D5B
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Mar 2022 00:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237696AbiCIXBr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 18:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiCIXBn (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 18:01:43 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5C7CB924
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Mar 2022 15:00:43 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id x193so4276496oix.0
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Mar 2022 15:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWfLc1QRnKpGfpxDErIuLfonnSFvXSBVnB9mprT/KUI=;
        b=EjC8JmBNzkN1i6/h9Bv+b1HUcI83YqfyeJJCLj+wCP94jaJ02G0fwmsvHUtC7i0OW6
         jtlRa8Hi1XGE21K52aBl2JWyX7HLdmGeXV/B+wMdCA0zAhHrZ3iibfe9bQbBEMAQU4g9
         zO90/8xD2+Zzq5UwAkWeGhISTDcMsIb79E0sxB2NltMbk4xONPQEoVDtxKU6Zliq+/d9
         yacSSOlLJpaL0PkXVkzHUI8lDq7LR0Pwtjv5EtSXpx7h3VU4PVa7ZyfvepdEe7kwquh2
         IXbli3x3M2XN8pxVmRYeBTOh31ZdV32ltFNxVJC9D4xi+saWjAZ1Nn2zK35iQIYXUMZD
         JJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWfLc1QRnKpGfpxDErIuLfonnSFvXSBVnB9mprT/KUI=;
        b=L3UZmTF8RHHz267FIjWuv9O3GURi9N4RMGDcoLx48m+VaeJ0NTldtHHLpiSNnMZeYn
         egt48syD3gYI4YngRDNbYp/d+JmwFknbItWqmWk01jJPoVf38XnrV0eOM/h9TTRUveMC
         Tzr24f4TnOfruCtylztZLc1I0/CV9i462Azl7+gypM3SMVFxMats5sCctnJrfKaHm75b
         gk8/zbTlEUv/IDqwpH+R1DvG7dS0ZYdfigkhweVbsJF5OSP1FPV7qlcxpZ9h2Qr8MCNz
         nCRARJIplB65559pHTlQmYi7CuzdwWO14IXPth0jarY4k3o4EdSfY8RPTzcbsgRDau+C
         CDBg==
X-Gm-Message-State: AOAM530JhcSjDNHon0sfIb3LmSI2pnO+8AJyp2G+ajNw8woG/Bdlz60a
        m9pQuk+birmwF9dldUWspXHGaNp56e1QhlQJn7UpPfo8
X-Google-Smtp-Source: ABdhPJzVVrJOnIvTopCtdQ/975Xac7Xg9F7auRVYsl9xaOvMaK7WD1FrXc/uMjgC2rh20gzedPgDeDS5AJujtbfSBWY=
X-Received: by 2002:a05:6808:14cf:b0:2d9:dcc6:8792 with SMTP id
 f15-20020a05680814cf00b002d9dcc68792mr7709101oiw.219.1646866842851; Wed, 09
 Mar 2022 15:00:42 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com> <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
 <e5bb2e23-2101-dcc3-695e-f3a0f5a4aba7@gmx.com> <CAODFU0pEd+QTJqio6ff5nsA_c--iCLGm52t0z6YBgzJcWPxy9g@mail.gmail.com>
 <3f286144-d4c4-13f6-67d9-5928a94611af@gmx.com> <CAODFU0r8QqbuHdH_vG21bPacuMM+dmzMbdSq23TPHxL=R1DbgQ@mail.gmail.com>
 <cc8d21c6-6bda-f296-3f3a-09b10582fde3@gmx.com> <CAODFU0p3=xn9viSQsnhqt=c3AuD_tEzXpxJAuV-sDWN=udrOow@mail.gmail.com>
In-Reply-To: <CAODFU0p3=xn9viSQsnhqt=c3AuD_tEzXpxJAuV-sDWN=udrOow@mail.gmail.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Thu, 10 Mar 2022 00:00:07 +0100
Message-ID: <CAODFU0qq_fp946XUm665DQtxXGdkOofqxvSyQ649rtTiD_aOZw@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 9, 2022 at 11:55 PM Jan Ziak <0xe2.0x9a.0x9b@gmail.com> wrote:
>
> On Wed, Mar 9, 2022 at 11:44 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> > > xfs_io -c "fiemap -v 0 40g"
> >
> > Well, I literally mean 4k, which is ensured to be one extent.
>
> The usefulness of such information would be 4k/40g = 1e-6 = 0.0001%.

1e-7 or 0.00001%, of course. Sorry about the confusion.

-Jan
