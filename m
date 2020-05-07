Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A2B1C7F6C
	for <lists+linux-btrfs@lfdr.de>; Thu,  7 May 2020 02:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgEGAvc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 May 2020 20:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgEGAvb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 May 2020 20:51:31 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764E1C061A0F
        for <linux-btrfs@vger.kernel.org>; Wed,  6 May 2020 17:51:31 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a4so2957408lfh.12
        for <linux-btrfs@vger.kernel.org>; Wed, 06 May 2020 17:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQj3Ni0GQK6+NKvWSgo7ta4qp+1afvDKSMZ/nZjR5MA=;
        b=l3tjj6JBDO7UWAIGGdKaJgozbED/qeqOxCk/HuUShGRb5b+4nFR2QHPMaGumGYa7Bq
         +4kcsy02X4y1sF3M8t/nt2l3cTeKyS6W3sQ+9hJtzuEvY0vBrrQiZQS4mS/o/IkA1+aa
         193fxR5kXfIEZ22ejEahAAuwCKbdi1V/Fd8oc3QqcB3hK/vlhppjNeDYjzoiPdc21wWL
         Rt/kqPN8p90yvqOPelL85kZj74CcDnxj/QCMzbgvFvhunzzVhoxHegqgCLXOU34SP7B0
         NsW0x8Y6+3DpfkLmb2p8lJEJt5LTIAMxhf2Vxs4MqUH8QLQJyVL0Q47xF08EUWbiihnY
         2WLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQj3Ni0GQK6+NKvWSgo7ta4qp+1afvDKSMZ/nZjR5MA=;
        b=P4XbrAOOXUO+2byRREZRUkNQu6W6s3iDI2njoJyD77T5ysGVuCjWZRxEK93hgVxNpW
         Y0MnEuEyCK/rhrsRyuAF6jL5/cSK3F3OHRKGrOPv2c967PBLDRU2u0X4FVEUm9nJV5E9
         /vzmOtl7Jn5jzcyG2XpfC05annX1KiFZRfUm0/+C2GMvOj6Ysx/dWxvGD+VMGxvkX6uO
         HNJaBEqWFVzKV8o5PTTuQ8vH1YLV2VOJp6b1po7Qfdga3ry0pT6yWmHk4tI9W4Xbh5Rt
         CNEhbxeMfHHII8epwcO0WMEnxrw1m7gg8i7wDbCPQ/5N/WfhEXggvBnxw8dlJGec+KBC
         c0fw==
X-Gm-Message-State: AGi0Pua8f3Aff0YWYx7Q1nvwwatCcChKNTaZu17H7jPowWVDu0XrKzo+
        Q+aKtge6u9Ckh1vBk0g6n0wHhlTnFYDgipc0iy6hUA==
X-Google-Smtp-Source: APiQypKvxNvHogIk0ZYPtYoZ0SvIZDPBipLYbzymJQ1SzBmMxxqAFtH5Nm3TYhD5s7Zu93VWXRObVuYhF7G78IwqJ6Q=
X-Received: by 2002:a19:6448:: with SMTP id b8mr6878929lfj.18.1588812689688;
 Wed, 06 May 2020 17:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAJheHN0FUe-ijMco1ZOc6iKF2zbPocOw+iiVNeTT1r-JuXOJww@mail.gmail.com>
 <CAJheHN3J85eLmZZYs0-ACoUQFuv3FVHmAnoJTxB+Xu8CGnCy5A@mail.gmail.com> <CAJCQCtTqxWymZK5Bb5V8FJfur2dJUgrwZs9b1D4CNWGYjvEv_A@mail.gmail.com>
In-Reply-To: <CAJCQCtTqxWymZK5Bb5V8FJfur2dJUgrwZs9b1D4CNWGYjvEv_A@mail.gmail.com>
From:   Tyler Richmond <t.d.richmond@gmail.com>
Date:   Wed, 6 May 2020 20:51:18 -0400
Message-ID: <CAJheHN1rKTrUUF=jGdDwEDYtLYZZ1F2eME+at4kuvNQr1RfF1g@mail.gmail.com>
Subject: Re: Read time tree block corruption detected
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Kernel version is 5.4.0-28. Just upgraded to Ubuntu 20.04.
btrfs-progs is version 5.6

That inode search returned an error:
ERROR: ino paths ioctl: Input/output error

I don't use any subvolumes.

The next command also resulted in an error. Replaced the actual
mountpoint in the error with /mountpoint.

ERROR: not a block device or regular file: /mountpoint/
ERROR: device scan /mountpoint/: Input/output error

Something definitely doesn't seem right.

On Wed, May 6, 2020 at 7:55 PM Chris Murphy <lists@colorremedies.com> wrote:
>
> On Wed, May 6, 2020 at 3:54 PM Tyler Richmond <t.d.richmond@gmail.com> wrote:
> >
> > Hello,
> >
> > I looked up this error and it basically says ask a developer to
> > determine if it's a false error or not. I just started getting some
> > slow response times, and looked at the dmesg log to find a ton of
> > these errors.
> >
> > [192088.446299] BTRFS critical (device sdh): corrupt leaf: root=5
> > block=203510940835840 slot=4 ino=1311670, invalid inode generation:
> > has 18446744073709551492 expect [0, 6875827]
> > [192088.449823] BTRFS error (device sdh): block=203510940835840 read
> > time tree block corruption detected
> > [192088.459238] BTRFS critical (device sdh): corrupt leaf: root=5
> > block=203510940835840 slot=4 ino=1311670, invalid inode generation:
> > has 18446744073709551492 expect [0, 6875827]
> > [192088.462773] BTRFS error (device sdh): block=203510940835840 read
> > time tree block corruption detected
> > [192088.464711] BTRFS critical (device sdh): corrupt leaf: root=5
> > block=203510940835840 slot=4 ino=1311670, invalid inode generation:
> > has 18446744073709551492 expect [0, 6875827]
> > [192088.468457] BTRFS error (device sdh): block=203510940835840 read
> > time tree block corruption detected
> >
> > btrfs device stats, however, doesn't show any errors.
> >
> > Is there anything I should do about this, or should I just continue
> > using my array as normal?
>
> What kernel version? This looks like relatively recent kernel
> reporting format. Can you search for inode 1311670? e.g.
>
> $ sudo btrfs insp ino -v 1311670 /mountpoint
>
> Note that each subvolume has its own set of inodes. You need to point
> the command to the correct subvolume. In this case it's root=5 which
> is the default/top-level. As long as you haven't changed the default
> subvolume, and you've mounted the file system without subvol or
> subvolid option, it should point to the correct file that's affected
> by this. And also maybe useful:
>
> $ sudo btrfs insp dump-t -b 203510940835840 /mountpoint
>
>
>
> --
> Chris Murphy
