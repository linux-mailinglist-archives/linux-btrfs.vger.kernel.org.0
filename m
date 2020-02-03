Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31FF71504B2
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 11:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgBCK4o (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 05:56:44 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:35524 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgBCK4o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 05:56:44 -0500
Received: by mail-il1-f171.google.com with SMTP id g12so12237239ild.2
        for <linux-btrfs@vger.kernel.org>; Mon, 03 Feb 2020 02:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Uh50SS/TPTTtO20aItCHJ4nPL6yop5ZR+M/UVmadt6c=;
        b=k3m4E1zLF0WSCSYrSi2WtT6VST2BKN7CUc6zqRfwEmBFrKi11LCwT/DyRIXY4OCQ8Y
         N7YLbgSukQH2dqnPLHHABq5ao8y/l1pKpnl3mtenewImlh4KrxMAbQIL3MeO5OXtJaed
         wTyoIHmKrvnjvHv0BhsdThRJYfGTl8d/EDt/Mmja2/gU6SYeQwPNCCOiiuJzXh5kWene
         oespO9asVCn0sPbIfEmcaJZXdBkNUX/CtIlO9lMGuK8X9iAJv5JuNmhIzzLsmVzWR9Jt
         UirnFnQRJ0UJrn3/CRP/NXdhOcLTOrKtJ7Wgt6tCuCr+dPbIZPzDVYXzs62Z6WadC5Sl
         y+Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Uh50SS/TPTTtO20aItCHJ4nPL6yop5ZR+M/UVmadt6c=;
        b=oxK1/qa+K45QX2R/SyM/PuLMIZxVXT/+SAOUzQPvSg0ttREA9DN8eebpK+t3GYpUFl
         eGFd59xX8NGNdE+iXbdOPr3uKmLAZEwtYvn5c2GWP1xFB5Kj3hMQDNGuIOT8V5Wscucg
         qtkoI2208NWFRwJFQQLvSZfZ6pYyyd28HCntayS7h+s0WHIQYmSZsSijcywkKePW1Odp
         vQvI5XrGlnlkjVuho5qIfGf+xOQ+ap8CCNHU/RgdI6y9l16nCrDlCb5/uSEZUNA3CPAK
         1Xw+YXHy03H1IiFgTv+1Hi3PQZEPgt3ac9SG7Aii2lWiXorM90zpgEI0nmj8XjJ54XCQ
         M+9A==
X-Gm-Message-State: APjAAAUc1tm3qalj2yUoyPOxG4j+0oXXEQ6iA+211d1PaYghud5AA45u
        X9v3LoxjXUz4RN2i0bT9PgG5xvKV0AcCis43A0blPJkI
X-Google-Smtp-Source: APXvYqwXWUWwTr9j5Nbg8wITJ1QPVZq4iMdUOx/VPTPp8o/eUNw2Uab0ntJNI3pIArq/aDYTRL5FqsKtQ7q9m05EkFQ=
X-Received: by 2002:a92:af44:: with SMTP id n65mr441507ili.158.1580727402343;
 Mon, 03 Feb 2020 02:56:42 -0800 (PST)
MIME-Version: 1.0
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <CAJCQCtR0hzV+9S7cggGUUTtp4R1WdnSwzsOp=9fTnxvzn3Stmw@mail.gmail.com>
 <CACN+yT-FrVi71HKANj7NRinyPoDG5Aowma9NT=UB2WGvqoLSVA@mail.gmail.com>
 <94fb7bb4-53a5-f2e8-a214-2d12cf49664c@gmx.com> <CACN+yT8OD1jFFgbdrNuqrfsfYZMpPfJaTQ+7cGUSuWaaeH9g9w@mail.gmail.com>
 <8944f055-6693-01a9-5b29-23d78c309274@gmx.com>
In-Reply-To: <8944f055-6693-01a9-5b29-23d78c309274@gmx.com>
From:   Skibbi <skibbi@gmail.com>
Date:   Mon, 3 Feb 2020 11:56:30 +0100
Message-ID: <CACN+yT_6_LaZ_Yep88FgZZcRDTDXvmBczWDUW=r0O=ts6vkLJg@mail.gmail.com>
Subject: Re: My first attempt to use btrfs failed miserably
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

pon., 3 lut 2020 o 11:11 Qu Wenruo <quwenruo.btrfs@gmx.com> napisa=C5=82(a)=
:

> It depends on the timing.
>
> In fact, as your initial report said, btrfs even succeeded to read some
> tree copy from the disk when we lost the device for a while.
> And finally goes RO if btrfs fails to write any tree blocks.

Yeah, it wen't RO but when I tried to remount I got bad superblock bla
bla. And I was unable to fix this by using btrfs repair for example.
I'm not sure if it possible to recover from the error I got. That's
why I'm concerned about power issues in the future. I've been using
ext4 for decades and I don't remember that fatal filesystem crash.
Yeah I lost some data due to bad sectors or power loss but I was
always able to mount the filesystem.

--=20
Best regards
