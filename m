Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76178514010
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Apr 2022 03:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiD2BPV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 28 Apr 2022 21:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbiD2BPU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 28 Apr 2022 21:15:20 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1D8BC879
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 18:12:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e15so8359922iob.3
        for <linux-btrfs@vger.kernel.org>; Thu, 28 Apr 2022 18:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KE+lVNm1O0RMlceg0pxe/XTAZVFkkKm+kaRI/+Xnxyw=;
        b=1CsGt+oAYI+XLl1KEIwfJR2RgL80+/sY5lShKwnkxLPRTFbWhg9o+gRe75ltKwfmzr
         cGsgZhljuuG8TeGLmLsujvKO6R43I6KKKISV6SBZOe7dWeovjbAMzYiu85xHfUWvL/ov
         vbC8hDvaVuOgonHhSFc0Pe18Q0uHSaxtzDoJOfJnArPwVeDwlycms9zJ3mjUI1rmiyBW
         Tt+T1yCJFRf3XGpANLThfxB9ompu2+830vaWpRqpKBc01vvpemlE8QVzJSx+kKmuu3WH
         vkV5jIwl1EL5/Oj1m1iKL+bRYs3NWhuub9SyIVhb1OW7ggItglYGhCRUAaeayMXpZ5O/
         cOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KE+lVNm1O0RMlceg0pxe/XTAZVFkkKm+kaRI/+Xnxyw=;
        b=VaNou7sgY0fIrnroFaAOnVwjr0E+KnMBz8Vo8ndRKUk46DzLJZHxHgKkXOevB04s+7
         z4gTUp41j6mIeBz8H+rNxzUML23Olgs8ZpxYKsyFU2oPK3CqLVIvjX36OlLohlE9DpJ7
         s8dR1021wu0mtEkCtTfyM/QCWEays486UsZ0nXlE8Nlh1czAjM63pLJrS7oY2Llvuz74
         Nz5uoRzZZouQyRnqHWZAdODzZJ1w+ro1XwIx8MqXTKImWRtSBgt5wI+EVKrGFwr1AKDa
         A/xHtBoFH10s5WgFj24/onCRrv5NVVZ34syRpi7AuN5kdTkCoXs6wI/B5cDvJ8o970Ha
         qv+Q==
X-Gm-Message-State: AOAM532Mftdbaohq3kHu7YWhnjWt39CJxsHmdqQr49IqNRrOJYhUtysj
        xmn02dmxQf9x1EOvjBlPQq6zNk9kiF0RtomxCVISEz6NNy4=
X-Google-Smtp-Source: ABdhPJxJJk8cDitAGyxrSyhkCezYp4LhpMU4XADlvLATP0xnVuMcEb7RWrr9u5jzsyNQJlVaOY+KUhqIxcmah3SeRIA=
X-Received: by 2002:a05:6602:2d55:b0:657:a28c:26bd with SMTP id
 d21-20020a0566022d5500b00657a28c26bdmr6943374iow.134.1651194722839; Thu, 28
 Apr 2022 18:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220428162746.GR29107@merlins.org> <CAEzrpqcL_ZyvenVuO4re9qCS2rLnGbsiz0Wx9zUH_UaZY9uVDA@mail.gmail.com>
 <20220428202205.GT29107@merlins.org> <CAEzrpqfHjAn7X9tMm6jAw8NJiv3vsvYioXj9=cjMqNcXjFhSdA@mail.gmail.com>
 <20220428205716.GU29107@merlins.org> <CAEzrpqduAKibaDJPJ6s7dCAfQHeynwG6zJwgVXVS_Uh=cQq2dw@mail.gmail.com>
 <20220428214241.GW29107@merlins.org> <CAEzrpqd0deCQ132HjNJC=AKQsRTXc=shnAmHfs0BR9pWiD4mhg@mail.gmail.com>
 <20220428222705.GX29107@merlins.org> <CAEzrpqeQrSrMgGLh0F34fVj8dnzJQF7kv=XSBKcD92oHyV8-gA@mail.gmail.com>
 <20220429005624.GY29107@merlins.org>
In-Reply-To: <20220429005624.GY29107@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Thu, 28 Apr 2022 21:11:51 -0400
Message-ID: <CAEzrpqe+n9iGQymL01eZQjPBnN+Z1NeGDyTDaC-pwsGkOwvuDg@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 28, 2022 at 8:56 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Thu, Apr 28, 2022 at 07:24:22PM -0400, Josef Bacik wrote:
> > > inserting block group 15835070464000
> > > inserting block group 15836144205824
> > > inserting block group 15837217947648
> > > inserting block group 15838291689472
> > > inserting block group 15839365431296
> > > inserting block group 15840439173120
> > > inserting block group 15842586656768
> > > processed 1556480 of 0 possible bytes
> > > processed 49152 of 0 possible bytesadding a bytenr that overlaps our
> > > thing, dumping paths for [4088, 108, 0]
> >
> > Oh huh, we must not have a free space object for this, in that case let=
s do
> >
> > ./btrfs-corrupt-block -d "4088,108,0" -r 2 /dev/whatever
> >
> > and then do the init.  Thanks,
>
> gargamel:/var/local/src/btrfs-progs-josefbacik# ./btrfs-corrupt-block -d =
"4088,108,0" -r 2 /dev/mapper/dshelf1
> FS_INFO IS 0x558c0e536600
> JOSEF: root 9
> Couldn't find the last root for 8
> FS_INFO AFTER IS 0x558c0e536600
> Error searching to node -2
>
> not good news I assume?
>

Just that I=C2=B4m dumb and making silly mistakes, its -r 1, sorry about th=
at,

Josef
