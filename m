Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C663E24F14C
	for <lists+linux-btrfs@lfdr.de>; Mon, 24 Aug 2020 04:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgHXCvL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Aug 2020 22:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbgHXCvK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Aug 2020 22:51:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4419C061573
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 19:51:09 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k20so6757735wmi.5
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Aug 2020 19:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EoEBOtaATmxbyu4HIEPz2WluXRMbMwImk0g5ZduY0ug=;
        b=svK9jCgsyy4HcxIja+l4seIf9yf5R85za+8DpQE8CakH7q1tSkO8k9JoiHTisLIRgV
         xYqd1jTxcGUMI3q6Lxcxofdf3944dnuhP1h6Qh0o6TYqI53Vw8tvPaji4TehhkCB4Mr6
         FLf+Lltcm17mIrFsvIKiKfHEwjlx16wRf/cGc289k9qLUISgR5tqwxgyTRmN8s5Rul/b
         MrZnFt/qNWqp4xsmOeC8ScqM/Z8zELrroyTAs3ugei9J0KjQiurVFK5KKlrT7CTfMBZi
         OlTV7CglsZIHctUQxHPBqc6LL1v/opFkA6gKD2g+/6sHDDWUOJBlGFkZdWb2qkhJKK9x
         HG0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EoEBOtaATmxbyu4HIEPz2WluXRMbMwImk0g5ZduY0ug=;
        b=XvXavqkT1LxEchtLd0XM42gXN4z24lAe3YZAgDBEIA5XhGFazidt0NKfo8rd6K2uy8
         Vo+Q/DqxZPrbMoJbW0ceHXQl3gonlpk796xUxoTZxpQubuQGt/ETbZ9TP5+5zgniIjBd
         gC5UNN1fXcGjwv0jeNIWCOMd1L2GZLIgYzjpYd1a0zzLahJwAB7ExK8FFUTcE9Tvzs1f
         ihiDQuWtvbbcDW6kdTgA7p57qXPtdaOB3pibIamGkA5Js5Ser2Fy5LGJpxkG6YDQ8NVj
         8n9GPUpmbpihqNQ0FfsR0liQhX2mwZJjJISK+1NhqYRIeMRP36juLy0WzXbB1Fv529vC
         kTaw==
X-Gm-Message-State: AOAM530hODPC0qg+S+v0fuEIhdI10n0xCStajUGlLEx2GADQRRMIzgpC
        zoPrvo33ZAubKMACqW1gC7uPXEH+xLy/ptK6R//iMU+5j3Z1Jgki
X-Google-Smtp-Source: ABdhPJzroE+QvYlI6BPo0c0AK0foY1EWXpafl42cdzeooV/KQlbJShHFoUqg6zjZUTW1DLI1pFvWw2bd7YCOSXrhlQQ=
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr3443899wmh.168.1598237468128;
 Sun, 23 Aug 2020 19:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
In-Reply-To: <bdJVxLiFr_PyQSXRUbZJfFW_jAjsGgoMetqPHJMbg-hdy54Xt_ZHhRetmnJ6cJ99eBlcX76wy-AvWwV715c3YndkxneSlod11P1hlaADx0s=@protonmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 23 Aug 2020 20:50:26 -0600
Message-ID: <CAJCQCtTC2yi4HRqg6fkMrxw33TVSBh_yAKtnX-Z1-nXSVjBW7w@mail.gmail.com>
Subject: Re: [Help] Can't login to my systemd-homed user account due to
 fallocate failure
To:     Andrii Zymohliad <azymohliad@protonmail.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sun, Aug 23, 2020 at 9:31 AM Andrii Zymohliad
<azymohliad@protonmail.com> wrote:

> My root partition is ~475GiB with BTRFS, my home partition is a ~400GiB L=
UKS-encrypted partition on a loopback file (also BTRFS) created by systemd-=
homed (residing at /home/azymohliad.home). Which leaves ~75GiB for the rest=
 of the root FS.
>
> Recently I've lost the ability to log in to that user account, because du=
ring authentication systemd does fallocate call for the image. CLI alternat=
ive for my case (suggested on systemd mailing list, I don't really know wha=
t is it) is:
>
>     fallocate -l 403G -n /home/azymohliad.home
>
> Which fails:
>
>     fallocate: fallocate failed: No space left on device

I don't understand why homectl is fallocating just to activate. I'd
expect homectl only uses fallocate for create and resize. Can you
confirm the exact homectl command you're using?

There is a homectl option that might help, when activating, --luks-discard=
=3Dtrue

A consequence of this option, however, is it will make the backing
file sparse. i.e. it'll punch holes in it, freeing up space on the
underlying file system. You should read the warning for the
--allow-discards option in 'man cryptsetup' which is what 'homectl
--luks-discard' is using.

Also, this option will fairly quickly fstrim the user home upon
activation (last time I tested it on systemd-245, some things have
changed in 246). And that will erase all evidence about why you're
having this problem in the first place.

Preferably if you could post the results from:

ls -ls /home/azymohliad.home

Grab this debug file from upstream btrfs-progs
https://github.com/kdave/btrfs-progs/blob/master/btrfs-debugfs

sudo ./btrfs-debugfs -b /

Mount or remount the file system with mount option enospc_debug, and
then reproduce the problem, i.e. exact same homectl command you're
using that's failing with out of space error.


> I can mount my home manually like this:
>
>     losetup -fP /home/azymohliad.home
>     cryptsetup open /dev/loop0p1
>     mount /dev/mapper/home /mnt

Yeah, exactly. Therefore I'll argue this is a systemd-homed bug. If
fallocate fails, systemd-homed can't just lock users out of their user
home. It needs to have a fallback where it doesn't do the fallocate,
and warns the user about whatever dependent operation also can't
happen as a result. But the user home should activate.

> What's interesting to me from above, the partition size on /home/azymohli=
ad.home is 402.72GiB, but the file system size is 256.01GiB, and the image =
file size is 256.64GiB (from btrfs fi du /home, although ls -lh reports 403=
GiB). I'm not really sure, but iirc the fs and image sizes were around 403G=
iB too earlier. Could it be that it somehow got automatically reduced?

I'm confused. But I'm gonna set this aside for now until you post back
with the other information.

> Could I do anything to make that fallocate call (with -l 403G) working? I=
t will allow me to authenticate to homectl and resize the home partition fr=
om there.

At the expense of sounding like a smart ass, yes you can make the root
file system bigger (by adding another device) and then presumably the
fallocate will work. But the fallocate seems wrong to me - but I also
don't know what command you're using and why fallocate is even being
used.


>
> If not, what is the safe way to shrink that LUKS-partition size? Maybe th=
en systemd-homed would do fallocate for less space and it would work.
>
> If from my assumptions you could tell that I'm looking in the wrong direc=
tion, please give me a hint. Thanks for taking time to read it!

For sure my top advice, is since you can manually mount this sd-homed
home, *freshen your backups now* while you still can. Later versions
of sd-homed create a subvolume on that LUKS Btrfs file system, so you
can snapshot it and use btrfs-send if you want or however else you're
doing backups.


--=20
Chris Murphy
