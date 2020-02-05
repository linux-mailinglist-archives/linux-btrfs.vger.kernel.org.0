Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4577E1533E0
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 16:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgBEP3V (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 10:29:21 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:34494 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgBEP3V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 10:29:21 -0500
Received: by mail-oi1-f176.google.com with SMTP id l136so1119244oig.1
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2020 07:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cCLjnz2NW+WIEHtqBSLh65dC6/JXH48Ygs7NDcwbQV4=;
        b=PtyJZ28BnbQ0rYGousgmLyhpHrtJKqnxdLJpcHftXp3maMoAVoeuhJANdvd+WQbnoA
         UtOj4keDyTEogqa+YYiRAnWimYACbJdYK8//0OzLrwS1t7hUXuhjC/lTk4GyS+YLapvi
         C2mDhTCzl1joiS9VOLEnpRlzhvRosIYAh1fTMDliuUaCOspJh6wfxS5a0r9ggs0rPe+m
         cZKnm/RUbjHFdXDZbKeYCGo7VkqG48o/LXA8A7im/AXyIcygDmW5UTbz7j1lFkZKbLwh
         1nVopTgFcxXkjCy8r08Rkg2ZlSwHSd3VISCpr4HC4nOgakMMo/hrLYlM3QEi9UIOcmgc
         00Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cCLjnz2NW+WIEHtqBSLh65dC6/JXH48Ygs7NDcwbQV4=;
        b=lP+/RNQXIbegLbBRkDgE7ggMkTnv5fUVD585yKGAO/9wYJoQ6zsx7MEqVi/rjkRp+L
         bbTLujesNu8a136P2sIt2COgD492jfKp47wpTpaBBxzy+m9hUaXNsvQy5Pwdz4rOKQxo
         7ciLfMgSwV4KKT+Z7GjJbjTHG3mWFr1BB+JvvWEj000Ail2qhcAtF2Q92D/nycKl7bsP
         hxJBUoAnveQLgd+1gKZYz9eWj1ctSKx1sCsMyjT9m/bNaRiUnFdezmUXuwDFoNywrLRj
         DPLM16YqVRf1JrBiv/NOnvKWmo4w3G29UG15Jm6W3Zk4G/ajAnZZB95Q1oj0mrjwRopt
         J4Mw==
X-Gm-Message-State: APjAAAVZ570PwbRSliZ0xhGEGjH8QQbVcKoYb3fmAqLT6V2qWWK62HdW
        oy2WwDl5dpOpm68sx+e7wGxoT4n988nNdkoOeulftcEqO5k=
X-Google-Smtp-Source: APXvYqxpAKdBBo2dTU31nZouB/iKr7kqxDWRBWS6PrNv4qHGuULVlw/el4VESKxHtfrG8NXnoTOrqTWZUGmxd8/A0CY=
X-Received: by 2002:aca:4ace:: with SMTP id x197mr3342284oia.23.1580916560049;
 Wed, 05 Feb 2020 07:29:20 -0800 (PST)
MIME-Version: 1.0
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com>
In-Reply-To: <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com>
From:   Chiung-Ming Huang <photon3108@gmail.com>
Date:   Wed, 5 Feb 2020 23:29:08 +0800
Message-ID: <CAEOGEKE6m=n1JTfFqBy33D9n1WFTjuuyQ_q+X=jF7+tNCYsLfg@mail.gmail.com>
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu Wenruo

Thanks for your reply and help.

Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=885=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=886:29=E5=AF=AB=E9=81=93=EF=BC=9A se=
rver ~$
Decrypted by /etc/crypttab
server ~$ mkfs.btrfs -m raid1 -d raid1 /dev/bcache0 /dev/bcache1
/dev/bcache2 /dev/bcache3 /dev/bcache4
server ~$ mount -o subvol=3D@defaults,degraded,nossd,subvol /dev/bcache4
/ (By /etc/fstab)
server ~$ reboot
server ~$ btrfs balance start /
server ~$ btrfs fi usage /
^^^^^^^^^^^^^ Only /dev/sdc (3T), /dev/sdd (10T), /dev/sdf (10T) have
data. The first two don't have any data and the last one have a mirror
copy of RAID1.
server ~$ Removed /dev/sda (1T), /dev/sde (2T), /dev/sdd (10T) from
/etc/crypttab
server ~$ reboot
server ~$ btrfs fi show
^^^^^^^^^^^^ /dev/sda (1T), /dev/sde (2T), /dev/sdd (10T) are marked `missi=
ng`
server ~$ btrfs balance start -f -sconvert=3Dsingle -mconvert=3Dsingle
-dconvert=3Dsingle /
server ~$ btrfs balance cancel /
server ~$ reboot
server ~$ Put luks on bcache and mkfs.btrfs /dev/sda (1T)
server ~$ Put luks on bcache and mkfs.btrfs /dev/sde (2T)
server ~$ Forgot to do it on /dev/sdd (10T)
server ~$ btrfs device remove missing
^^^^^^^^^^^^ Executed about 5 seconds. (Becasue /dev/sda (1T) is empty?)
server ~$ btrfs device remove missing
^^^^^^^^^^^^ Executed about 5 seconds. (Becasue /dev/sde (2T) is empty?)
server ~$ btrfs device remove missing
^^^^^^^^^^^^ Executed at least 12 hours before power-off accidentally.

[Change to the independent rescue OS.]
rescue ~$ Add /dev/sda (1T), /dev/sde (2T), /dev/sdd (10T) back to
/etc/crypttab. And /dev/sdd (10T) still keep the mirror copy of RAID1
before removing it from /etc/crypttab.
rescue ~$ reboot
rescue ~$ btrfs check -p --repair /dev/bcache4
^^^^^^^^^^^ failed
rescue ~$ mount /dev/bcache4 /mnt
rescue ~$ btrfs check --repair /dev/bcache4
^^^^^^^^^^ [4/7] ...
Errors ....... fs root
rescue ~$ btrfs scrub start -B /mnt
^^^^^^^^^^ Showed a lot of errors and I can't ctrl+alt+3. So I rebooted.
rescue ~$ btrfs check --repair /dev/bcache4
^^^^^^^^^^ [1/7] checking root items
Error: could not find extent items for root 257
ERROR: failed to repair root items: No such file or directory



> ...
> >
> > 7. $ btrfs check -p /dev/bcache4
> > Opening filesystem to check...
> > Checking filesystem on /dev/bcache4
> > UUID: 0b79cf54-c424-40ed-adca-bd66b38ad57a
> > Error: could not find extent items for root 257(0:00:00 elapsed, 1199
> > items checked)
> > [1/7] checking root items                      (0:00:00 elapsed, 7748
> > items checked)
> > ERROR: failed to repair root items: No such file or directory
>
> Have you tried btrfs check --repair then mount?

Yes.

> Is that mentioned dmesg the first time you hit, not something after

I keep kern.log but it's about 17M. I cannot post it here. And It
doesn't show `btrfs command` in the context.
A lot of `BTRFS critical` and `BTRFS error` are there but `BTRFS
critical` repeated.

Feb  3 15:38:24 rescue kernel: [ 8731.172674] BTRFS critical (device
bcache2): corrupt leaf: root=3D23146 block=3D19498503094272 slot=3D8,
invalid key objectid: has 18446744073709551606 expect 6 or [256,
18446744073709551360] or 18446744073709551604
Feb  3 15:38:24 rescue kernel: [ 8731.172860] BTRFS critical (device
bcache2): corrupt leaf: root=3D23146 block=3D19498503094272 slot=3D8,
invalid key objectid: has 18446744073709551606 expect 6 or [256,
18446744073709551360] or 18446744073709551604
Feb  3 20:19:42 rescue kernel: [25609.592216] BTRFS critical (device
bcache2): corrupt leaf: root=3D23146 block=3D19498503094272 slot=3D8,
invalid key objectid: has 18446744073709551606 expect 6 or [256,
18446744073709551360] or 18446744073709551604
Feb  3 20:19:42 rescue kernel: [25609.592511] BTRFS critical (device
bcache2): corrupt leaf: root=3D23146 block=3D19498503094272 slot=3D8,
invalid key objectid: has 18446744073709551606 expect 6 or [256,
18446744073709551360] or 18446744073709551604
Feb  5 17:05:58 rescue kernel: [ 3601.738469] BTRFS critical (device
bcache2): unable to find logical 7157918187520 length 4096
Feb  5 17:05:58 rescue kernel: [ 3601.738474] BTRFS critical (device
bcache2): unable to find logical 7157918187520 length 4096
Feb  5 17:05:58 rescue kernel: [ 3601.738481] BTRFS critical (device
bcache2): unable to find logical 7157918187520 length 16384
Feb  5 17:05:58 rescue kernel: [ 3601.738531] BTRFS critical (device
bcache2): unable to find logical 7157918187520 length 4096
Feb  5 17:05:58 rescue kernel: [ 3601.738533] BTRFS critical (device
bcache2): unable to find logical 7157918187520 length 4096
Feb  5 17:05:58 rescue kernel: [ 3601.738539] BTRFS critical (device
bcache2): unable to find logical 7157918187520 length 16384
.... (repeated 4096, 4096, 16384 these three lines)

> btrfs check --repair?
>
> And `btrfs check` without --repair please, that's the most important
> info to evaluate how to fix it (if possible).

rescue ~$ btrfs check /dev/bcache4
Opening filesystem to check...
Checking filesystem on /dev/bcache4
UUID: 0b79cf54-c424-40ed-adca-bd66b38ad57a
[1/7] checking root items
Error: could not find extent items for root 257
ERROR: failed to repair root items: No such file or directory

rescue ~$ btrfs check --repair /dev/bcache4
enabling repair mode
WARNING:

        Do not use --repair unless you are advised to do so by a developer
        or an experienced user, and then only after having accepted that no
        fsck can successfully repair all types of filesystem corruption. Eg=
.
        some software or hardware bugs can fatally damage a volume.
        The operation will start in 10 seconds.
        Use Ctrl-C to stop it.
10 9 8 7 6 5 4 3 2 1
Starting repair.
Opening filesystem to check...
Checking filesystem on /dev/bcache4
UUID: 0b79cf54-c424-40ed-adca-bd66b38ad57a
[1/7] checking root items
Error: could not find extent items for root 257
ERROR: failed to repair root items: No such file or directory
rescue ~$

> Thanks,
> Qu

Regards,
Chiung-Ming Huang
