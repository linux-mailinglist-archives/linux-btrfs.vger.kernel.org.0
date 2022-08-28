Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B195A3CE6
	for <lists+linux-btrfs@lfdr.de>; Sun, 28 Aug 2022 10:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbiH1IyD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 28 Aug 2022 04:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiH1IyB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 28 Aug 2022 04:54:01 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEF930574
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Aug 2022 01:54:00 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-11edd61a9edso1230185fac.5
        for <linux-btrfs@vger.kernel.org>; Sun, 28 Aug 2022 01:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=8gAv/zcim9DDIkW27wgtw+28N6QYoTToWRXXeoZOs9E=;
        b=KV4wfcqBWvMQg5ZKDl4Glg7XypZu0HloQSQv+/JFnVz5xfdP/7m6g20mq13pJkGthh
         O+p2ayirUeXoXiaD+2k10ifUZSYpCxD+FJTrvgIxeGxe/JqVu8B81yZWZjahJH0IdUPQ
         ij7BpZbsfKh2uq0dTOJZ96yHRVPx4OxfM+o9ai+ZAEdGeSe1YjdOHJ8apOAkPFMiUS0T
         hM7ryt/EOzuJdY5K2FygISCg2q+kUlLCWu55kyfWXog/l831+lvq5H5xbIGj/vwIzbIc
         JzOeYqQAmX7vfKJcekgKVI/ndhbbZTnNj2UM+b43/D4tSwrFAXAY/4wluvrn8Tl4fkRT
         lZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=8gAv/zcim9DDIkW27wgtw+28N6QYoTToWRXXeoZOs9E=;
        b=HDOsmyy7y9+nGQ6+h6lB65Ngi0A5DW0PZBRufoVxi18TdYZYuPaWtZvzkuIGIaF/jd
         yVl6W4hC696SVeXm+zHs71YeQkFhYWgCqspSjddG4MRg/NejDGrLCdqsWYFlCk8zma+U
         uj7jSRl/heS9B7uGg1yNBBCr4Nl5n8RBnuReQtRDXqa6JQvCWj9BZztFzlJa04jJGVT3
         AEl9oz1o7ssZmwa93JAHFIoeqdtQx1juvZyA7zYvoplboK9KK/0BKN+lWuB9l3zGqkPz
         hqLtSra57pjk0dlT4+v37YH0w+K8i3ms40imbnz2x8/AeCzSK6t/KXh1OXjXIcBsQbGa
         EDvg==
X-Gm-Message-State: ACgBeo1PWzGKLIdD2tv5WEDScVwrkQ4Mvwv2eVa6hX3xM7DjjQ+Xlx19
        WN5yNGG4gJR0d/rgZzXl4ksftA07cNAUzxoyuPI=
X-Google-Smtp-Source: AA6agR7GRObELhbX6audO8h0JecvkrIVn+URYHrTCR0Uac0i465YGCFw/872q4fC6QAcceBTw1TA2Pc0mNmdIe0ylVU=
X-Received: by 2002:a05:6870:c349:b0:11d:dc76:b336 with SMTP id
 e9-20020a056870c34900b0011ddc76b336mr5232424oak.42.1661676840269; Sun, 28 Aug
 2022 01:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <1661357103-22735-1-git-send-email-zhanglikernel@gmail.com>
 <c3dc352c-8393-c564-4366-42fb9ece021e@gmx.com> <PH0PR04MB7416B660C501F73F47E7D4159B729@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB7416B660C501F73F47E7D4159B729@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   li zhang <zhanglikernel@gmail.com>
Date:   Sun, 28 Aug 2022 16:53:48 +0800
Message-ID: <CAAa-AGk67Ex8woPz=F-P-GdsY1i2N0w==AP9Bk2YpH=Yk+vPdg@mail.gmail.com>
Subject: Re: [PATCH] Make btrfs_prepare_device parallel during mkfs.btrfs
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     Li Zhang <zhanglikernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi, I'm a bit confused, do you mean if you open a zoned device
without O_DIRECT it will fail?

I tested and found that if I open a device with the O_DIRECT flag
on a virtual device like a loop device, the device cannot be written
to, but with or without O_DIRECT, it works fine on a real
device (for me, I only test A normal block device since I don't have
any zoned devices)

If we use the same flags for all devices,
does that mean we can't use mkfs.btrfs
on both real and virtual devices at the same time.


Below is my test program and test results.

code(main idea):
printf("filename:%s.\n", argv[1]);
int fd =3D open(argv[1], O_RDWR | O_DIRECT);
if (fd < 0) {
     printf("fd:error.\n");
     return -1;
}
int num =3D write(fd, "123", 3);
printf("num:%d.\n", num);
close(fd);

result:
$ sudo losetup /dev/loop1 loopDev/loop1
$ sudo ./a.out /dev/loop1
filename:/dev/loop1.
num:-1.
# cannot write to loop1


Thanks,
Li Zhang

Johannes Thumshirn <Johannes.Thumshirn@wdc.com> =E4=BA=8E2022=E5=B9=B48=E6=
=9C=8825=E6=97=A5=E5=91=A8=E5=9B=9B 16:31=E5=86=99=E9=81=93=EF=BC=9A
>
> On 25.08.22 07:20, Qu Wenruo wrote:
> >> +                    if (zoned && zoned_model(file) =3D=3D ZONED_HOST_=
MANAGED)
> >> +                            prepare_ctx[i].oflags =3D O_RDWR | O_DIRE=
CT;
> > Do we need to treat the initial and other devices differently?
> >
> > Can't we use the same flags for all devices?
> >
> >
>
> Yep we need to have the same flags for all devices. Otherwise only
> device 0 will be opened with O_DIRECT, in case of a host-managed one and
> the subsequent will be opened without O_DIRECT causing mkfs to fail.
