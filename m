Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C8E36E862
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbhD2KHh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 06:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhD2KHg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 06:07:36 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA74C06138B;
        Thu, 29 Apr 2021 03:06:50 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id t14so2169502qvl.10;
        Thu, 29 Apr 2021 03:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=94YjNA2qREmzFWlsgqo5WOVM76SDdyy2Bntm/hTvb40=;
        b=DgmTmcFoZVaskKwAHwnwE3AgIInf75M1mj/CmKOf935yPuudVoRXT4xu5SZi6/z0wR
         pXFCufocK+WevozMnFs+aNliiTDFy3leSobpN30rIrwK4pf3OZZbmysNiJBOC6QCktoQ
         KYkLnbUYjJ0VQkuB67FPLiEdt1rJFSxHoL6yl1UskQpxi/WSvZRlItzE6ZZOu6VpGJQU
         dqFHp0KhVHVzQbesBwXQcDCfavFimslMeli358kYvz+deYFb5/DVLi1dAO//YT9KCPg8
         Ldz2eWYi9QG2hFm+LqUsY+eCeMbpD7IyHYHCoJsXtXbXGY6bobpyb1PLlNH3h1LQBfG+
         kJ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=94YjNA2qREmzFWlsgqo5WOVM76SDdyy2Bntm/hTvb40=;
        b=W/NoZufua/hdWdvX7WM9dyAPyawORIa4rNnQL1ItIuNzVP0EAhIfDLedVr51hMrl6N
         JPZzdGfc42cdmHABrgeEimKNm0pPzDt8aUEGVK8SCbE6soIFAW00WXh3gu7BGziQj26O
         E8w6m6itKHpqfFmplgGg1IuebSeTGWk7clz7JM3YP9/dYOsH72pTNQgY9T+5CVMtvhb1
         pP5yfI84d/l+CcA7+tbfjSKpUFhHYh65YC9gQMHBsgRJpjrY6esMZto7mKyic5uDPpQT
         ehU7wImgKMm57aNNw/dnOKbaGwAKKHMe4VFJSi962VXveD8Ziwsbo+10fGRDzv9+oWSa
         MEVg==
X-Gm-Message-State: AOAM531Yzu5yni9Az2qtsiX4aG689ruFF9hLK0hmQp9yQch3RM6W74zZ
        tkasLbK/8xMDBCxc+IHkanIh1fkqP7JvKvCpE8hlx+qRcCh1Xg==
X-Google-Smtp-Source: ABdhPJzlUHQ6QRldCBihZxbxdah38QtxckN8PLPi8lDjujBayzbTkXbQBo4V7+pbRX0u6kca6VHMXA14ddiRYG2POqs=
X-Received: by 2002:a0c:ba1a:: with SMTP id w26mr6267789qvf.27.1619690809927;
 Thu, 29 Apr 2021 03:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210428084608.21213-1-johannes.thumshirn@wdc.com>
 <20210428084608.21213-3-johannes.thumshirn@wdc.com> <CAL3q7H4z=eePUYbOgOVZhMCp+u8m8bbvKfU5nNqq3rd_8YNm1g@mail.gmail.com>
 <PH0PR04MB74165CF0E16A53B38FF4AEEF9B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <CAL3q7H6rQt=ecHN=Q3xh0tGsq5fmrkQaCApeusyvYYj0xDjp7g@mail.gmail.com> <PH0PR04MB74163147612C69B1CD2D1FA39B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB74163147612C69B1CD2D1FA39B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 29 Apr 2021 11:06:38 +0100
Message-ID: <CAL3q7H6=QbqFkefheaKXk_U2KPpukRkAaVWYM3MbKJkvtR5TVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] btrfs: add test for zone auto reclaim
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Eryu Guan <guan@eryu.me>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        fstests <fstests@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Apr 29, 2021 at 11:05 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 29/04/2021 11:56, Filipe Manana wrote:
> > On Thu, Apr 29, 2021 at 10:44 AM Johannes Thumshirn
> > <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> On 28/04/2021 11:24, Filipe Manana wrote:
> >>> The use of _fail is usually discouraged. A simple echo would suffice =
here.
> >>
> >>
> >> Need to do echo + exit here, otherwise there will be errors in the she=
ll script.
> >
> > Errors? I don't understand, what kind of errors?
>
>
> For instance if the block group isn't removed, the dump-tree call will re=
turn two
> block groups and then this calculation will fail:
> new_data_zone=3D$(get_data_bg)
> new_data_zone=3D$((new_data_zone >> 9))

Ok, I now see it, I was only noticing the very last _fail, which is
not problematic. Sounds good then.

Thanks.



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
