Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F32421115
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 May 2019 01:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfEPXnI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 16 May 2019 19:43:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45871 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbfEPXnH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 16 May 2019 19:43:07 -0400
Received: by mail-lj1-f193.google.com with SMTP id r76so4599087lja.12
        for <linux-btrfs@vger.kernel.org>; Thu, 16 May 2019 16:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=leKRpFmZnAXA1v7Ju7nz9vToh6ru7DPSpy2fzBLjFXs=;
        b=CXtUY8kt/dtjFwAjG3ShENiu8vDysxh8FtOwHVVKXu+CCw2WCubIvy6ON4A4LS1YoU
         axhZhPceSqc33wK7FUt6rl6efAv6Qm69AXsI6gmhhruV2Pw8L4zwjHAJkzwz11nEQ7rA
         3WcjwcTjH+P7RtNRJCDBEtJWDJPhxVF0mVrlE2EXIVy11pHDa9W9PSKIUslE4+OtJmcs
         53/qEHfFzpfgfOawF1KjKOt5WfCxzA7/RlQHWQH1He7kNdSiUYXYF+8we9HixMMD/Woo
         6UIstr4xSxy/xdQWQqcB+XQM5TAUT3QbHKszv4wRnEa3elI6Y+l38wFkUnSVxmAjO2dU
         eXqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=leKRpFmZnAXA1v7Ju7nz9vToh6ru7DPSpy2fzBLjFXs=;
        b=f/mQxXw/C9WBr888ScEWB+BG9vykEdx/oUakCTo31Ys+3d+KmH3RN4UVjr24A5almp
         wmRVhjb3qb6CqUSfyFz/EkjgdmeO8T3NDhpRvyJpSTliQfggju1ecgqP64GOl5aT2X/Y
         9hiLqXa8FEkyx8KdedlKk7tYN9LsoxQrpfV0+TBEQk6R0sE/CqJEyU6JK9O4AhsIDMEI
         2HDFLqiv0XnXFCnut8is2D2fd5c6DTSEE8kKtpliJ6tnb+ggTQ+iocfBVgoO6/sTn95I
         eB01XIpKFpnBqzT+hzySFSwuw6ari+ByXL0dm/9yDRFkZi5JjBEZTsQfYLN3Q/yLomvN
         K3Ag==
X-Gm-Message-State: APjAAAVIWr0bzUg+02543A7oDO2jxPh5jh2/KEWYAAxVnN1OfwDCx+x8
        5V+UnbXjd0Wr6vh1NvWC3697J5k6tx6xGQHd4vuB+VWrYf4=
X-Google-Smtp-Source: APXvYqxvzXXy+wUNjJq9rmDldV+rKkqrKthsJeTkNgGdEAUS9VShCULk36KTCoXy4oyI+v2QNO20IFxQJTQKWZotxJo=
X-Received: by 2002:a2e:93c7:: with SMTP id p7mr13842505ljh.32.1558050185837;
 Thu, 16 May 2019 16:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <297da4cbe20235080205719805b08810@bi-co.net>
In-Reply-To: <297da4cbe20235080205719805b08810@bi-co.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 16 May 2019 17:42:54 -0600
Message-ID: <CAJCQCtR-uo9fgs66pBMEoYX_xAye=O-L8kiMwyAdFjPS5T4+CA@mail.gmail.com>
Subject: Re: Massive filesystem corruption after balance + fstrim on Linux 5.1.2
To:     =?UTF-8?B?TWljaGFlbCBMYcOf?= <bevan@bi-co.net>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, May 16, 2019 at 4:26 PM Michael La=C3=9F <bevan@bi-co.net> wrote:
>
> Hi.
>
> Today I managed to destroy my btrfs root filesystem using the following
> sequence of commands:
>
> sync
> btrfs balance start -dusage 75 -musage 75 /
> sync
> fstrim -v /
>
> Shortly after, the kernel spew out lots of messages like the following:
>
> BTRFS warning (device dm-5): csum failed root 257 ino 16634085 off
> 21504884736 csum 0xd47cc2a2 expected csum 0xcebd791b mirror 1
>
> A btrfs scrub shows roughly 27000 unrecoverable csum errors and lots of
> data on that system is not accessible anymore.
>
> I'm running Linux 5.1.2 on an Arch Linux. Their kernel pretty much
> matches upstream with only one non btrfs-related patch on top:
> https://git.archlinux.org/linux.git/log/?h=3Dv5.1.2-arch1
>
> The btrfs file system was mounted with compress=3Dlzo. The underlying
> storage device is a LUKS volume, on top of an LVM logical volume and the
> underlying physical volume is a Samsung 830 SSD. The LUKS volume is
> opened with the option "discard" so that trim commands are passed to the
> device.
>
> SMART shows no errors on the SSD itself. I never had issues with
> balancing or trimming the btrfs volume before, even the exact same
> sequence of commands as above never caused any issues. Until now.
>
> Does anyone have an idea of what happened here? Could this be a bug in
> btrfs?

I suspect there's a regression somewhere, question is where. I've used
a Samsung 830 SSD extensively with Btrfs and fstrim in the past, but
without dm-crypt. I'm using Btrfs extensively with dm-crypt but on
hard drives. So I can't test this.

Btrfs balance is supposed to be COW. So a block group is not
dereferenced until it is copied successfully and metadata is updated.
So it sounds like the fstrim happened before the metadata was updated.
But I don't see how that's possible in normal operation even without a
sync, let alone with the sync.

The most reliable way to test it, ideally keep everything the same, do
a new mkfs.btrfs, and try to reproduce the problem. And then do a
bisect. That for sure will find it, whether it's btrfs or something
else that's changed in the kernel. But it's also a bit tedious.

I'm not sure how to test this with any other filesystem on top of your
existing storage stack instead of btrfs, to see if it's btrfs or
something else. And you'll still have to do a lot of iteration. So it
doesn't make things that much easier than doing a kernel bisect.
Neither ext4 nor XFS have block group move like Btrfs does. LVM does
however, with pvmove. But that makes the testing more complicated,
introduces more factors. So...I still vote for bisect.

But even if you can't bisect, if you can reproduce, that might help
someone else who can do the bisect.


Your stack looks like this?

Btrfs
LUKS/dmcrypt
LVM
Samsung SSD


--=20
Chris Murphy
