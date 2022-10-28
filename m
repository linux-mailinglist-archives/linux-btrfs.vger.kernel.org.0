Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31640610E5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Oct 2022 12:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbiJ1KYZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Oct 2022 06:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiJ1KYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Oct 2022 06:24:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63131CBA80
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 03:24:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4770EB800C1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 10:24:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E04C433C1
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 10:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666952660;
        bh=TuALZncGVxxYFxylktRbZ/Ic9R0Ava6gXLhGQz2P4ac=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bwD8WVxcO9/jXhRYvVuCXfOAEJOw5c4OWlsOAdUx1I2PDgtIJ5yHCR490g9zrclHD
         GJ9K55/65PGxXF/KjZzevR24jeykmT1aTLSy3PBYN9hR6+4dlTBWIbcpPmkACy/7H3
         RKn5p8c7nX6dFo/IamFCt2hdxlocMr73m9OSRovZwOba3qv8WAmWZuCOWrPwb27y7O
         IZpGkzdS7ZzZZvt9B2EzyzMqqwoRLh1tOU0FD/GDfZAMYdnVB0v9N8O2l2I+9S0+ip
         y/jC07gi0HWH2WbLTjApONcIDNLJgW1kbIzwcmPO2MxwV345hmPzTc7w5o1tQRSojB
         Mdv9nRTmHEXRQ==
Received: by mail-oo1-f54.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so713231oop.3
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Oct 2022 03:24:19 -0700 (PDT)
X-Gm-Message-State: ACrzQf2izNdRVKSmdN9YUEL8Ck4SPZqy8Yeg9/Y18z4IEGT/k556pELE
        t/hdOaKsgw1RaUDt3ZFhVQyhs05PdcMvgSY9/bo=
X-Google-Smtp-Source: AMsMyM6uoxZxXaeApeBo+FNJb74Uo2dqftfbGu0ORymEf8J+OIZgJpQ3w1Gws7GNbjQT0PK0MGoECQGMh3OKDoorVug=
X-Received: by 2002:a05:6820:81f:b0:485:157b:f066 with SMTP id
 bg31-20020a056820081f00b00485157bf066mr12601460oob.79.1666952659089; Fri, 28
 Oct 2022 03:24:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEmTpZGRKbzc16fWPvxbr6AfFsQoLmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com>
In-Reply-To: <CAEmTpZGRKbzc16fWPvxbr6AfFsQoLmz-Lcg-7OgJOZDboJ+SGQ@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 28 Oct 2022 11:23:42 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7RmDV2Xe2+Fb11Jr=NqPWQtw9V=En6JR1swS6Ocr5Z-w@mail.gmail.com>
Message-ID: <CAL3q7H7RmDV2Xe2+Fb11Jr=NqPWQtw9V=En6JR1swS6Ocr5Z-w@mail.gmail.com>
Subject: Re: Major bug in BTRFS (syncs are ignored with libaio or io_uring)
To:     =?UTF-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= 
        <socketpair@gmail.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Oct 27, 2022 at 11:08 PM =D0=9C=D0=B0=D1=80=D0=BA =D0=9A=D0=BE=D1=
=80=D0=B5=D0=BD=D0=B1=D0=B5=D1=80=D0=B3 <socketpair@gmail.com> wrote:
>
> How to reproduce (I tested in kernel 6.1):
>
> 2.  mkfs.btrfs over a partition.
> 3.  mount -o lazytime,noatime
> 4.  touch file.dat
> 5.  chattr +C file.dat # turns off compression, checksumming and COW
> 6.  fallocate -l1G file.dat
> 7.  # prefill the file with random data
>     fio -ioengine=3Dpsync                      -name=3Dtest -bs=3D1M
> -rw=3Dwrite                 -filename=3Dfile.dat
> 8.  fio -ioengine=3Dpsync    -sync=3D1 -direct=3D1 -name=3Dtest -bs=3D4k
> -rw=3Drandwrite -runtime=3D60 -filename=3Dfile.dat  # Will show, say, 2K
> IOPs
> 9.  fio -ioengine=3Dio_uring -sync=3D1 -direct=3D1 -name=3Dtest -bs=3D4k
> -rw=3Drandwrite -runtime=3D60 -filename=3Dfile.dat  # Will show, say, 32K
> IOPs
> 10. fio -ioengine=3Dlibaio   -sync=3D1 -direct=3D1 -name=3Dtest -bs=3D4k
> -rw=3Drandwrite -runtime=3D60 -filename=3Dfile.dat  # Will show, say, 32K
> IOPs
>
> Steps 9 and 10 show implausible IOPs.
>
> This does not happen on, say, Ext4 (all the methods give roughly the same=
 IOPs).
>
> Removing -sync=3D1 on all engines on Ext4 gives immediate return (as
> expected because everything gets merged and finally written very fast)
>
> Adding/Removing -sync=3D1 with io_uring or libaio changes nothing on
> BTRFS (it's definitely a bug)

I confirm that the syncing is not happening often when using aio
(either old aio or io_uring).
I understand why it's happening, so I'll work on a fix for that.

Thanks for the report.

>
>
> I consider it's a bug in BTRFS. Very important bug because BTRFS
> becomes default FS in Fedora server/desktop now. This bug may cause
> data loss. That's why I set this bug as high priority.
>
>
> *****************
> https://bugzilla.redhat.com/show_bug.cgi?id=3D2117971
> *****************
>
>
> --
> Segmentation fault
