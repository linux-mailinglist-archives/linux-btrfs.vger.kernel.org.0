Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83E02310D9
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 19:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731988AbgG1R1w (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 13:27:52 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49775 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731951AbgG1R1w (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 13:27:52 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 326B55C0170;
        Tue, 28 Jul 2020 13:27:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Jul 2020 13:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        mime-version:content-transfer-encoding:content-type:subject:from
        :to:date:message-id:in-reply-to; s=fm1; bh=f4XOui/TuYBzBp0PHR7bq
        eA2t/FhBcRDHqXqTwDO0kE=; b=kzAajd/ICIhnrskmTj2iFDL1Qf0cEPa0V11fw
        4/YUu3356LCUVGtNF1c2b4yj0GTYyAD7Fxw+ZQUbgrrU4++dbzhK37g1J+bpiRxK
        ZKs5+y95HaafBqX0qgHrPNBfVr7yVV7Yso6GyRWAcbFJiPHAXXeQ56wDPZzbOJZ4
        kMkGUlnWJjQBxx9Folt7e50MQ9j4Xas7i7VqDVez9AyGKthDWu7QMwAWMIXeEccJ
        bUqcS8BeVCyl4Lg0FQKlO9cGHaMadUCeru9V27WILUmmPCM01XrTS2pMOFJQa5Al
        lrJLCJWn9F/lH9z9gz+dfW+wSGwoygDv2WFN7aiPrt7iDE52g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=f4XOui/TuYBzBp0PHR7bqeA2t/FhBcRDHqXqTwDO0kE=; b=LsLmmX+k
        qD3+ND1f7tI3VnPOyO403Ln43QaWGoJZoBZTz5Vnpw3dnX6Kxnj0RaPj9OrsAHuc
        pMq/41pZOsbsFJh8wggdwJR0+z3cTm7SDLwgkPFUu8U3j2AJFm9ERE/Zs5mPUE6U
        0Rsj9Yb3Sd3sx8I5sUoUqYi1fwfHD3tplyIvfa8aOPfnrVn0OZNvwZyUcaTW/Wxr
        HK4iFpWzT+bR5QY6BjFizjjvkqQOzxXKh45ZY3AHylwbKOzpMonkiRAu5stw+Fb7
        fUyV4SSsMbKldFNOk16BLJ+INkw5YK2lxsmjMpuk9DC8Rb7XVoC3dixYgl31sIhs
        tIDzO8xAeKV5VA==
X-ME-Sender: <xms:FmAgX0HMjLXQcn9HQK6spDUgcN2UieQxayrTZl-E0FXaRTOMBLQQWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedriedvgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfeehmdenucfjughrpegggf
    gtuffhvfffkfgjsehtqhertddttdejnecuhfhrohhmpedfffgrnhhivghlucgiuhdfuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepkeeugeevvdevudffte
    fggfdtgfekteetteevueelteduledvtdejkeefjedugfdunecuffhomhgrihhnpehgihht
    hhhusgdrtghomhdprhgvrggumhgvrdhmugenucfkphepjeefrdelfedrvdegjedrudefge
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihu
    segugihuuhhurdighiii
X-ME-Proxy: <xmx:FmAgX9V5V76eyESja_mvLTlGDuG7D1acHjOaS3szyHmmoEZYJU7rDA>
    <xmx:FmAgX-KVcKDKARNL70RN_2OV8SfQ1f9uCl7_n9FOAqDkUaM3lkp8mQ>
    <xmx:FmAgX2FJ1OM6QOA_zekUyy-PwgW0XQRokeAJrt-NSCJiVP7_dS0aDw>
    <xmx:F2AgXzfNkct-TVxehyGIRBCW17CUqymurZ696X41aEX-ltvJeGPkuQ>
Received: from localhost (c-73-93-247-134.hsd1.ca.comcast.net [73.93.247.134])
        by mail.messagingengine.com (Postfix) with ESMTPA id E2072306005F;
        Tue, 28 Jul 2020 13:27:49 -0400 (EDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH v2] btrfs-progs: Add basic .editorconfig
From:   "Daniel Xu" <dxu@dxuuu.xyz>
To:     "Qu Wenruo" <quwenruo.btrfs@gmx.com>, <dsterba@suse.cz>,
        <linux-btrfs@vger.kernel.org>, <kernel-team@fb.com>
Date:   Tue, 28 Jul 2020 10:26:58 -0700
Message-Id: <C4IFM8SN79ND.2BH0DOVF4VXEG@maharaja>
In-Reply-To: <0b039506-577f-05a1-2109-565e8c5c2a04@gmx.com>
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue Jul 28, 2020 at 6:00 AM PDT, Qu Wenruo wrote:
>
>
> On 2020/7/28 =E4=B8=8B=E5=8D=888:57, David Sterba wrote:
> > On Tue, Jul 28, 2020 at 08:12:40PM +0800, Qu Wenruo wrote:
> >>>>> +trim_trailing_whitespace =3D true
> >>>>
> >>>> Does this setting apply on lines that get changed or does it affect =
the
> >>>> whole file? If it's just for the lines, then it's what we want.
> >>>>
> >>> At least from the vim plugin code, it's just for the new lines:
> >>>
> >>> https://github.com/editorconfig/editorconfig-vim/blob/0a3c1d8082e38a5=
ebadcba7bb3a608d88a9ff044/plugin/editorconfig.vim#L494
> >>>
> >>> It just call the replace on the current line.
> >>
> >> My bad, %s, it replaces all existing lines...
> >=20
> > So this would introduce unrelated changes, but it seems that we don't
> > have much trailing whitespaces in progs codebase:
> >=20
> >   $ git grep '\s\+$'
> >   btrfs-fragments.c:
> >   btrfs-fragments.c:                              black =3D gdImageColo=
rAllocate(im, 0, 0, 0); =20
> >   crypto/crc32c.c:/*=20
> >   crypto/crc32c.c: *=20
> >   crypto/crc32c.c: * Software Foundation; either version 2 of the Licen=
se, or (at your option)=20
> >   crypto/crc32c.c: * Steps through buffer one byte at at time, calculat=
es reflected=20
> >   crypto/crc32c.c: * Steps through buffer one byte at at time, calculat=
es reflected=20
> >   kernel-lib/radix-tree.h: *=20
> >   kernel-lib/radix-tree.h: *=20
> >   kernel-lib/rbtree.c:            node =3D node->rb_right;=20
> >   kernel-lib/rbtree.c:            node =3D node->rb_left;=20
> >   kernel-lib/rbtree.h: =20
> >=20
> > filtering only the sources. So let's keep it in the config.
> >=20
> Great.
>
> BTW, it would be better to mention we use editorconfig as the unified
> formatting config.
>
> As most of us are using vim, which doesn't support editorconfig by
> default, thus we need to install that plugin manually.

Sure, should a hint about editorconfig go into the `Development` section
of the README.md?
