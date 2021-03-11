Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67E43375FB
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Mar 2021 15:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhCKOnm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Mar 2021 09:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbhCKOni (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Mar 2021 09:43:38 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6C4C061574
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 06:43:38 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id 94so1273637qtc.0
        for <linux-btrfs@vger.kernel.org>; Thu, 11 Mar 2021 06:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2VN8q72EwCgZh2nTWEr1lYUbcfY3arUHB75Y3K6XdU0=;
        b=Xs+5Epl3EV0Z7qSQWp1NaQgAzHUr030KZGRkHcKAXkzYoNjaaQCfPfh4dPuVxEPTAz
         k7mwRl86fda8J3ggv1JCK9S61c/eYWEYAJtipG2nxakcorQmI3HnY6zoC3kah4HA30Nx
         h2rWhT7h/nVl7ke1syA55sRkOMjeSA3rSyPJOUUGLPsXVd51juRPrP68wCFh/TkzziFY
         XsvQ6gXYqKhlIz7q9iMH/h9owkVftb95rl0pavEEyY8xvShXCZnpzBMFKwHuzmrrlDxM
         2d5s3YAmB3as3oorhIgHauhfMpXwuDqzYxAPkTNMGamkSeeVLl6mPPLtpIN3iimxgro1
         Do9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=2VN8q72EwCgZh2nTWEr1lYUbcfY3arUHB75Y3K6XdU0=;
        b=QzNNHNlD+o25D/4MhvridU2yhttgTrUUocm/pQhd0Pp4c1ICDc30mEN8cK2Asn8fiq
         d9vwt5dllnxsS5TcksN83cpZoC2gZqtohcCe8i9kBoNx8k/6R9YZzDvpzOD+w0HCf4wZ
         zPtr1/7aO3YIWrUM4R/2duqBlcpi/ZX/qBa/cWhn9mriRtXoaOawH+oKCP+7p9R+w6mc
         yTB7CFPROXhadBxr5SgoEINi9LWQDVaf8W1/7Qohpo9eqAHf8g6uWUaIPAw6ohhYlrd1
         YPA4c6SGGVytW92XvxE/ntwiwwn5c6rVkNO3jXpbqcwI1e8TQl8JksyMNJWqp21E0qa+
         wUCA==
X-Gm-Message-State: AOAM532iH8An3ppuKnPSc4YQR4SWIvtQYw2cYJx9y7rka6vhbIA8/CEN
        vNlIlW0r8d7m35qxF131pbhSUr+xD4g9DnYK/xTibrQxDDM=
X-Google-Smtp-Source: ABdhPJxpID4L1YDJ9YFJ42JrukDGXTFgRg2rv9eJgxCwp8z8e+qH3UWxkRXtvDPdRb/K2LwQvgUNJ1kHuXhOVKaK5lU=
X-Received: by 2002:ac8:76c5:: with SMTP id q5mr7675334qtr.376.1615473817607;
 Thu, 11 Mar 2021 06:43:37 -0800 (PST)
MIME-Version: 1.0
References: <010201781d22d3e9-78ba2d74-fc45-4455-813d-367e789d3e9b-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201781d22d3e9-78ba2d74-fc45-4455-813d-367e789d3e9b-000000@eu-west-1.amazonses.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Thu, 11 Mar 2021 14:43:26 +0000
Message-ID: <CAL3q7H79BO0qgTUVmbW2kzcUqtp4vgRLK8vNT95+Sz7tgWDdMQ@mail.gmail.com>
Subject: Re: Multiple files with the same name in one directory
To:     Martin Raiber <martin@urbackup.org>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 10, 2021 at 5:18 PM Martin Raiber <martin@urbackup.org> wrote:
>
> Hi,
>
> I have this in a btrfs directory. Linux kernel 5.10.16, no errors in dmes=
g, no scrub errors:
>
> ls -lh
> total 19G
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> -rwxr-x--- 1 root     root      783 Mar 10 14:56 disk_config.dat
> ...
>
> disk_config.dat gets written to using fsync rename ( write new version to=
 disk_config.dat.new, fsync disk_config.dat.new, then rename to disk_config=
.dat -- it is missing the parent directory fsync).

That's interesting.

I've just tried something like the following on 5.10.15 (and 5.12-rc2):

create disk_config.dat
sync
for ((i =3D 0; i < 10; i++)); do
    create disk_config.dat.new
    write to disk_config.dat.new
    fsync disk_config.dat.new
    mv -f disk_config.dat.new disk_config.dat
done
<power fail>
mount fs
list directory

I only get one file with the name disk_config.dat and one file with
the name disk_config.dat.new.
File disk_config.dat has the data written at iteration 9 and
disk_config.dat.new has the data written at iteration 10 (expected).

You haven't mentioned, but I suppose you had a power failure / unclean
shutdown somewhere after an fsync, right?
Is this something you can reproduce at will?

>
> So far no negative consequences... (except that programs might get confus=
ed).
>
> echo 3 > /proc/sys/vm/drop_caches doesn't help.
>
> Regards,
> Martin Raiber
>


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
