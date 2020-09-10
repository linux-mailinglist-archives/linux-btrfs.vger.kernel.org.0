Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFBA264E99
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgIJTUh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 15:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727826AbgIJTTu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 15:19:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859B2C061573
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 12:19:48 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c18so8164865wrm.9
        for <linux-btrfs@vger.kernel.org>; Thu, 10 Sep 2020 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mq4g9iX7vMS1vhKhh8oOVsQzdkuG2tr1PL6fU+TzzX4=;
        b=A6dNLLWp6oU7q+GYQP+SSSkU9z8AHKvvpjDBQuZPOgGoEkf+lO/QLi5tRTlDEnoaZC
         ugpWVd8VfSaD43Ux4pq6JSslDMBW/W9VmtWlcqselruiWqEYJ1RT8suj63+wWBnjAa7Y
         cohJun+2qcdCYvfoREfKgQFG17YAmlRcDpYDQt5h9N3L7RJzPupPpNHiEroeuYiReDAs
         l2pYJ5HBJ4KHOEk7AiwrchIzzDpZykAzm7oIOeCsHH7WXsPA9O4RJuaTFNzS1qIR8M7w
         rJIkxtX4jO5A3zyCllPaHjBHSfOOr4ZKRxKj8V9HO3lu4iN17ADeO00wSuw1cHunnTJS
         NjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mq4g9iX7vMS1vhKhh8oOVsQzdkuG2tr1PL6fU+TzzX4=;
        b=b78GTHxXt4tJolzab7b1c60/5CfSXGSc+lYdPc0cSTkbxXJ+CshctcIl44iM2FuCeT
         57tAumbLP3fBpjbFEdANIkf2g1hGNv5jWQffulTclW50INgu3i49NXLyXuX7zbMDZomF
         trBeqk7KNnM7re7ZVQ7MPoe4WFIwIfPsE83fY1+cTKlGabxDwWMgLscZB8VCY+iHvOtQ
         M5FusWVlLFFB0DUXT9RUObjsO8z5IPGAe0R0Gqii7ZiFEwwVk9L2Ufv8W1NHUOSS61ot
         RYREDtefCofAVbXZjbrMclQ0QjRJunxRYVo5EpKenK02gfT1Mpz1bgrybrmCi+9HKTwZ
         n8Bg==
X-Gm-Message-State: AOAM531BNcjKlZ5xJnjE2QxvBt1wcnoWVz3+TKcgtSl00kQ4LsKS8UHI
        wGA9pg1VdWzLzvUxyISEeValYBA+hHsjWfnUpENDlxlX2cW3TA==
X-Google-Smtp-Source: ABdhPJwMbPLQRHNQqThgflD6A65Oc37xMtGbqBhmSdcQlYZhujrPGIyvxU3xosDIarnf0WyjeM+tUfDf1EogFO1BNBQ=
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr10555038wrs.274.1599765587211;
 Thu, 10 Sep 2020 12:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <9224b373-82ee-60c4-4bd1-be359db75ea1@gmail.com>
In-Reply-To: <9224b373-82ee-60c4-4bd1-be359db75ea1@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 10 Sep 2020 13:18:48 -0600
Message-ID: <CAJCQCtQYSPO6Wd2u=WK-mia0WTjU0BybhhhhbT5VZUczUfx+JQ@mail.gmail.com>
Subject: Re: No space left after add device and balance
To:     =?UTF-8?Q?Miloslav_H=C5=AFla?= <miloslav.hula@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Sep 9, 2020 at 2:15 AM Miloslav H=C5=AFla <miloslav.hula@gmail.com>=
 wrote:

> After ~15.5 hours finished successfully. Unfortunetally, I have no exact
> free space report before first balance, but it looked roughly like:
>
> Label: 'DATA'  uuid: 5b285a46-e55d-4191-924f-0884fa06edd8
>          Total devices 16 FS bytes used 3.49TiB
>          devid    1 size 558.41GiB used 448.66GiB path /dev/sda
>          devid    2 size 558.41GiB used 448.66GiB path /dev/sdb
>          devid    4 size 558.41GiB used 448.66GiB path /dev/sdd
>          devid    5 size 558.41GiB used 448.66GiB path /dev/sde
>          devid    7 size 558.41GiB used 448.66GiB path /dev/sdg
>          devid    8 size 558.41GiB used 448.66GiB path /dev/sdh
>          devid    9 size 558.41GiB used 448.66GiB path /dev/sdf
>          devid   10 size 558.41GiB used 448.66GiB path /dev/sdi
>          devid   11 size 558.41GiB used 448.66GiB path /dev/sdj
>          devid   13 size 558.41GiB used 448.66GiB path /dev/sdk
>          devid   14 size 558.41GiB used 448.66GiB path /dev/sdc
>          devid   15 size 558.41GiB used 448.66GiB path /dev/sdl
>          devid   16 size 558.41GiB used 448.66GiB path /dev/sdm
>          devid   17 size 558.41GiB used 448.66GiB path /dev/sdn
>          devid   18 size 837.84GiB used 448.66GiB path /dev/sdr
>          devid   19 size 837.84GiB used 448.66GiB path /dev/sdq
>          devid   20 size 837.84GiB used   0.00GiB path /dev/sds
>          devid   21 size 837.84GiB used   0.00GiB path /dev/sdt
>
>
> Are we doing something wrong? I found posts, where problems with balace
> of full filesystem are described. And as a recommendation is "add empty
> device, run balance, remove device".

It's raid10, so in this case, you probably need to add 4 devices. It's
not required they be equal sizes but it's ideal.

> Are there some requirements on free space for balance even if you add
> new device?

The free space is reported upon adding the two devices; but the raid10
profile requires more than just free space, it needs free space on
four devices.

> [Tue Sep  8 06:48:34 2020] BTRFS info (device sda): forced readonly
> [Tue Sep  8 07:31:16 2020] BTRFS info (device sda): disk space caching
> is enabled
> [Tue Sep  8 07:31:16 2020] BTRFS error (device sda): Remounting
> read-write after error is not allowed

Yeah it's confused. You need to reboot.


--=20
Chris Murphy
