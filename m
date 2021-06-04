Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003F539BB00
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 16:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhFDOke (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 10:40:34 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45022 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFDOkd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 10:40:33 -0400
Received: by mail-lf1-f45.google.com with SMTP id r198so11098910lff.11
        for <linux-btrfs@vger.kernel.org>; Fri, 04 Jun 2021 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Q3DAHo7o8uTZmmTsRSGNgAAzhtDAUn7kjhQPFCrNbU=;
        b=q3FKQka587yDspxjq+rl2r12tVoeSBBvM0yYDb3B+nS6GkRZNcQmbTF7sIjcCFS4Ec
         y0idM4sRgNxyzlgkPJplp6zBdg8A8v1F2Hd0D2KwS9uv//JKccK7pP4scW4X+ADWgUDc
         b+4RgsbYRGtbVr8F7XpPlgsfNSmwWt2tNVh2AjzOm9/3yk6R6kt8kGZDE06wUpxb0ZlC
         m0VzXIMfT0aeZVqeCboIxpGP70TE82907SpJSfrVhDfeWHC1mFpwCayPbNpsUNp6vufx
         Sp5W+/5M77/uEubekpWHCOgQzeL8xbTdHsAd2PI1JTWZw9KItzRP0y8huDo4FiX/uz08
         HYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Q3DAHo7o8uTZmmTsRSGNgAAzhtDAUn7kjhQPFCrNbU=;
        b=IazRhG3GdVjwipMzQNGVQCQ5uFV19f/ZQ4LBihNq/Sp6BTiDtnzDmDuWDA4WGGcL15
         ZuKVBCcGGQ8AKBkBr3M7EJdPmBiB4M/xN6Vj4iiNVzK/UVdEAmIE///x5rOqtRvAM9Iy
         kGH8ECmsWiWrwYG7WTQH1CQCK5Xs3O82DKEYIT5d73ldceQkdxX7eBG0Bz/7XrtqoRau
         SW21Wmti3JF3tvXAxArVxT/Tb5NPFpTlTKorP8hPNrxghXR6izqgngmTqkqqJwaRI+Uk
         JdtQ/stD7O5C/0qSzaJw/imFRGfPI/I/rw8JeXTjcdhttSvGYekY6RVyFLPn+4uzctMd
         VIdg==
X-Gm-Message-State: AOAM533Pn5k8ybdE12RGUu0Ame8uUIUQlEtZQ55a5jBV4Y018/pi3SeI
        THbBy0zg3QmLfsRk7sDQjcrEdRIpG3nT7Sb4Jn8iGbciH7o=
X-Google-Smtp-Source: ABdhPJwRIfDKRHR1x+IXcRyi6WnOSOoR3c5FL30hTTPxHIS5RJPOsGpKuT4f3OsIoTMqWxI91N6iJz7w1YMBWZpWBJE=
X-Received: by 2002:ac2:55a7:: with SMTP id y7mr2992309lfg.112.1622817465963;
 Fri, 04 Jun 2021 07:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAGnHSEkr0N_hnxvm89prL3vObYgvVoPFHLL4Z7wnQCSem6hB_A@mail.gmail.com>
In-Reply-To: <CAGnHSEkr0N_hnxvm89prL3vObYgvVoPFHLL4Z7wnQCSem6hB_A@mail.gmail.com>
From:   Tom Yan <tom.ty89@gmail.com>
Date:   Fri, 4 Jun 2021 22:37:35 +0800
Message-ID: <CAGnHSEkeu1hW-7YQO0HrYK__aY-eMdxfgSbcOTvnMu3jUcu4iw@mail.gmail.com>
Subject: Re: reflink copying does not check/set No_COW attribute and fail
To:     linux-btrfs@vger.kernel.org
Cc:     bug-coreutils@gnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Also cc'ing bug-coreutils@gnu.org.

On Fri, 4 Jun 2021 at 22:33, Tom Yan <tom.ty89@gmail.com> wrote:
>
> Hi all,
>
> I've just bumped into a problem that I am not sure what the expected
> behavior should be, but there seems to be something flawed.
>
> Say I have a file that was created with the No_COW attributed
> (inherited from the directory / subvolume / mount option). Then if I
> try to do a reflink copy, the copying will fail with "Invalid
> argument" if the copy has no one to inherit the No_COW attribute from.
>
> For example:
> [tom@archlinux mnt]$ sudo btrfs subvol list .
> ID 256 gen 11 top level 5 path a
> ID 257 gen 9 top level 5 path b
> [tom@archlinux mnt]$ lsattr
> ---------------------- ./a
> ---------------C------ ./b
> [tom@archlinux mnt]$ lsattr b/
> ---------------C------ b/test
> [tom@archlinux mnt]$ du -h b/test
> 512M    b/test
> [tom@archlinux mnt]$ lsattr a/
> [tom@archlinux mnt]$ cp --reflink=always b/test a/
> cp: failed to clone 'a/test' from 'b/test': Invalid argument
> [tom@archlinux mnt]$ lsattr a/
> ---------------------- a/test
> [tom@archlinux mnt]$ du a/test
> 0    a/test
> [tom@archlinux mnt]$ du --apparent-size a/test
> 0    a/test
> [tom@archlinux mnt]$ rm a/test
> [tom@archlinux mnt]$ sudo chattr +C a/
> [tom@archlinux mnt]$ cp --reflink=always b/test a/
> [tom@archlinux mnt]$ lsattr a/
> ---------------C------ a/test
> [tom@archlinux mnt]$ cmp b/test a/test
> [tom@archlinux mnt]$
>
> I'm not entirely sure if a reflink copy is supposed to work for a
> source file that was created with No_COW, but apparently it is. The
> problem is just that the reflink copy also needs to have the attribute
> set, yet it cannot inherit from the source automatically.
>
> I wonder if this is a kernel-side problem or something that coreutils
> missed? It also seems wrong that when it fails there will be an empty
> destination file created.
>
> Kernel version: Linux archlinux 5.12.8-arch1-1 #1 SMP PREEMPT Fri, 28
> May 2021 15:10:20 +0000 x86_64 GNU/Linux
> Coreutils version: 8.32
>
> Regards,
> Tom
