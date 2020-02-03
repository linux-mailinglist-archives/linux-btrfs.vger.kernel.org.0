Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA051501C7
	for <lists+linux-btrfs@lfdr.de>; Mon,  3 Feb 2020 07:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBCGjB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 3 Feb 2020 01:39:01 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:46337 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgBCGjB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 3 Feb 2020 01:39:01 -0500
Received: by mail-il1-f196.google.com with SMTP id t17so11608192ilm.13
        for <linux-btrfs@vger.kernel.org>; Sun, 02 Feb 2020 22:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DrqyjuQZ2ZPxF7qQhTc4wPd9OUy3yO5lcGHXuLkL37g=;
        b=J341HzsAjAURmVuhznlib0l3+8wtDa4HYpUK8tIFwR2K8EPz4s1bj1RlguiSIIEn3M
         19fS+vxI1lZ/+xCD2r2h4lDDv8s28B74pLgj0QggiPCK6xVjrGqM7BHRfszvvZp+S8AG
         tVUBko+7sIWQrIoiWfweKxjooVV/wK0YFaJWdVULH59E7hJ7g9oDB0deOOIVSI/sNqUO
         Xg/pdMxUY/iJ21914JNAqv5nrIS8hanzekzhb7ZhjrZB5SXB2zQ6+kS+yMVYfTN6j2l7
         vV3+TYY/lsik08cqvymRr5420KtIlXkD8vDC1zNz5apj8ZNW8Zsg9kBWlUcq7IIHqUeq
         KzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DrqyjuQZ2ZPxF7qQhTc4wPd9OUy3yO5lcGHXuLkL37g=;
        b=NgPiJpaB7ig7nMaonNN7SgNVWGjSwmD3sKya5sOL1viwrizuV3N4es6m1b6s9JHX1N
         sPQE35Qy7ZQjTzotXHxHyTnnu2mjzk2JT9aSnKsquyzDxon1hwBNiUy+PM2LfP/q7mx6
         LWLcTOkQ7zRJ+7yykGmyeOstim8x0jpKIivcKMO6eyxhrdL70ZGknk3nJoXn49I4/TN8
         czKpAevq+icBVsCrWxGfxPTYx3FA0rSCi2bUyePqVLJrbVOKbS+AwK7ssbr6a4k2VGqj
         cRoEz3xr36lE3Gyrnjmx7ET33InK80ptLM3cUus0slF4PRcHuLLsaQ0IcUmQG7+y86Fz
         suAg==
X-Gm-Message-State: APjAAAXPfmBEPQ0jbLn4gINFulmNi6i6YbBqzbzp5RxwDFAe4by0uWgS
        2isBQCUM5ZIiRWjAgiHZbNithaJPT3NjEvKuehCPlQ==
X-Google-Smtp-Source: APXvYqyM9zy4Dg4sgNBcTWDkm6v6TtWqV2EIoI0LlfjRDH0yP3IM0Em520qio6YDrRVDj4+WrJjzE2ADwILrCxzaON4=
X-Received: by 2002:a92:dac3:: with SMTP id o3mr14268884ilq.237.1580711940748;
 Sun, 02 Feb 2020 22:39:00 -0800 (PST)
MIME-Version: 1.0
References: <CACN+yT_AYiLc29M41U+WrQHtk4t==D-4AkH+wRROKJY=WstGAA@mail.gmail.com>
 <CAJCQCtR0hzV+9S7cggGUUTtp4R1WdnSwzsOp=9fTnxvzn3Stmw@mail.gmail.com>
In-Reply-To: <CAJCQCtR0hzV+9S7cggGUUTtp4R1WdnSwzsOp=9fTnxvzn3Stmw@mail.gmail.com>
From:   Skibbi <skibbi@gmail.com>
Date:   Mon, 3 Feb 2020 07:38:49 +0100
Message-ID: <CACN+yT-FrVi71HKANj7NRinyPoDG5Aowma9NT=UB2WGvqoLSVA@mail.gmail.com>
Subject: Re: My first attempt to use btrfs failed miserably
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

niedz., 2 lut 2020 o 20:56 Chris Murphy <lists@colorremedies.com> napisa=C5=
=82(a):
>
> On Sun, Feb 2, 2020 at 5:45 AM Skibbi <skibbi@gmail.com> wrote:
>
> > root@rpi4b:~# dmesg |grep btrfs
> > [223167.290255] BTRFS: error (device dm-0) in
> > btrfs_run_delayed_refs:2935: errno=3D-5 IO failure
> > [223167.389690] BTRFS: error (device dm-0) in
> > btrfs_run_delayed_refs:2935: errno=3D-5 IO failure
> > root@rpi4b:~# dmesg |grep BTRFS
>
> The entire unfiltered dmesg is needed. This older kernel doesn't have
> new enough Btrfs tree checker code to help determine what the problem
> is.

OK, I need to reformat my drive and reproduce the issue again.

> > [203285.351377] BTRFS error (device sda1): bad tree block start, want
> > 31457280 have 0
>
> > [203285.466743] BTRFS info (device sda1): read error corrected: ino 0
> > off 32735232 (dev /dev/sda1 sector 80320)
>
> > [218811.383208] BTRFS error (device dm-0): bad tree block start, want
> > 50659328 have 7653333615399691647
>
> These happening together suggest lower storage stack failure. Since
> kernel messages are filtered it only shows that Btrfs is working as
> designed, complaining about known bad file system metadata. But
> because it's filtered, it's not clear why the metadata has gone bad.
>
> > [223167.290255] BTRFS: error (device dm-0) in
> > btrfs_run_delayed_refs:2935: errno=3D-5 IO failure
>
> More suggestion of IO failure, whether physical device or logical
> layer in between Btrfs and physical device. Btrfs trusts the storage
> stack *less* than other file systems, by design. It's a kind of canary
> in the coal mine. Other file systems assume the storage stack is
> working, so they're less likely to complain. Only recent versions of
> e2fsprogs will format ext4 using metadata checksumming enabled. The
> kind of problems you're reporting look so bad and happen so fast I'd
> expect a good chance you'd reproduce the same problem with any
> metadata checksumming file system, if you have new enough progs to
> enable them.

I removed luks encryption and had the same btrfs errors after several
GB of writes. Then I reformatted drive to ext4 and was able to save
60GB without hiccups. Of course, you may be right that ext4 silently
damages my data, but at least I was able to see it on the drive after
remount/reboot.
I'm beginning to think that my Pi draws more power when used with
external drive (I used only pendrives so far) so I need to investigate
for power issues.
And also I need to figure out how to get newer kernel. Raspbian is not
the freshest distro...

--=20
Best regards
