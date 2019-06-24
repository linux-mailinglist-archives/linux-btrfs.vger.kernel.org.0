Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7FB51995
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Jun 2019 19:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfFXRbs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 24 Jun 2019 13:31:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35310 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFXRbs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 24 Jun 2019 13:31:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id f15so4915268wrp.2
        for <linux-btrfs@vger.kernel.org>; Mon, 24 Jun 2019 10:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AdTcfs7l9Catez3dddN2vGtpGGD6VKSDi+3LvDvZFk8=;
        b=tg9ekbPvVO4X084iTOjZzrSJFrUhkw3tSe/8GlesFZfFd7Ie7X1gL8PG6qrwGbgd+Z
         PwgdIrpjG76y9rcOUZ76xDwMlTTmKG8t+EZoebXLy5NSjY5xTCL16SkrwRiuqrI4PMFd
         VxPRGFYQoIyfMNLlAsVmrR95CDFGHJk4yfr1+Bf/vKk6ZmtIs2RrSIPIOHagSpLb4JHn
         g4aEVL5MQwcA70OZErfGON+OU7oOveYKMUcrQoURGqfLQ2DGgYRgA+r4TO8+uYaLtIKU
         7bQZFfX2AY2fIJzhFB1xZAIIO7L5Nb1hdkaCRcf1tJA8l+C5+td1SddzJtnRYRSKfuDG
         Of7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AdTcfs7l9Catez3dddN2vGtpGGD6VKSDi+3LvDvZFk8=;
        b=ScR5VJn74ZiNHoIi7OYZMFdiSpYvmWi2qB3bLhD0Qn6EKidRfXtnHiNorPgvrQs272
         zkLK6hBkIzHfaYDRa9rZvNbLiAqq7k+35M0HiG0sCw1HnuSH2qssjfDRcb0QsNLbMop6
         J9+GPlYomG/UbIliV8gBzVSE1pl9XmJXQ2nbNOk5ebWf+v03bz/3tKdt/CZ1uHMoG/yP
         ZMOxFYDRvWSxlcX2+VuCa/A9o3QSaEMmXY7iDVZHLRk/PyKCHEKkPuASVd+XkIGDIDoH
         kit5YAAK0RQehqYplM4ZH7jGUjPn93OF2FUI0qExcm6ARk0XsrGLmRocaIa7aToUrwuA
         +TFQ==
X-Gm-Message-State: APjAAAUTjVXZG/9J1W0e2SZ3u0vezf9z5fvIB1JruMIj9P6qyESxgvSa
        S+Q2b707Ym3kYOqileXtX9vVmnnUpjx6lNOnc/yosg==
X-Google-Smtp-Source: APXvYqz/2FHiubUZe4hSbitcekPG9WtKcuWXIZZreV108caC9LicWImi45NmpocoTZncd3HOibU/16/EX0qzJYTfkNs=
X-Received: by 2002:a05:6000:12:: with SMTP id h18mr46463251wrx.29.1561397506470;
 Mon, 24 Jun 2019 10:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190623204523.GC11831@hungrycats.org> <f1cfe396-aac7-b670-b8de-f5d3b795acfe@gmx.com>
In-Reply-To: <f1cfe396-aac7-b670-b8de-f5d3b795acfe@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 24 Jun 2019 11:31:35 -0600
Message-ID: <CAJCQCtRrT5pUxOxfKWTC=zt9E=ZxRaiLeBxngqc6YVQEYp8n_g@mail.gmail.com>
Subject: Re: btrfs vs write caching firmware bugs (was: Re: BTRFS recovery not possible)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Jun 23, 2019 at 7:52 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/6/24 =E4=B8=8A=E5=8D=884:45, Zygo Blaxell wrote:
> > I first observed these correlations back in 2016.  We had a lot of WD
> > Green and Black drives in service at the time--too many to replace or
> > upgrade them all early--so I looked for a workaround to force the
> > drives to behave properly.  Since it looked like a write ordering issue=
,
> > I disabled the write cache on drives with these firmware versions, and
> > found that the transid-verify filesystem failures stopped immediately
> > (they had been bi-weekly events with write cache enabled).
>
> So the worst scenario really happens in real world, badly implemented
> flush/fua from firmware.
> Btrfs has no way to fix such low level problem.

Right. The questions I have: should Btrfs (or any file system) be able
to detect such devices and still protect the data? i.e. for the file
system to somehow be more suspicious, without impacting performance,
and go read-only sooner so that at least read-only mount can work? Or
is this so much work for such a tiny edge case that it's not worth it?

Arguably the hardware is some kind of zombie saboteur. It's not
totally dead, it gives the impression that it's working most of the
time, and then silently fails to do what we think it should in an
extraordinary departure from specs and expectations.

Are there other failure cases that could look like this and therefore
worth handling? As storage stacks get more complicated with ever more
complex firmware, and firmware updates in the field, it might be
useful to have at least one file system that can detect such problems
sooner than others and go read-only to prevent further problems?


> BTW, do you have any corruption using the bad drivers (with write cache)
> with traditional journal based fs like XFS/EXT4?
>
> Btrfs is relying more the hardware to implement barrier/flush properly,
> or CoW can be easily ruined.
> If the firmware is only tested (if tested) against such fs, it may be
> the problem of the vendor.

I think we can definitely say this is a vendor problem. But the
question still is whether the file system as a role in at least
disqualifying hardware when it knows it's acting up before the file
system is thoroughly damaged?

I also wonder how ext4 and XFS will behave. In some ways they might
tolerate the problem without noticing it for longer, where instead of
kernel space recognizing it, it's actually user space / application
layer that gets confused first, if it's bogus data that's being
returned. Filesystem metadata is a relatively small target for such
corruption when the file system mostly does overwrites.

I also wonder how ZFS handles this. Both in the single device case,
and in the RAIDZ case.


--=20
Chris Murphy
