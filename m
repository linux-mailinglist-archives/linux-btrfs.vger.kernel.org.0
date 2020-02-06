Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4CA153EE5
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 07:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBFGus (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 01:50:48 -0500
Received: from mail-ot1-f44.google.com ([209.85.210.44]:44315 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgBFGus (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 01:50:48 -0500
Received: by mail-ot1-f44.google.com with SMTP id h9so4478686otj.11
        for <linux-btrfs@vger.kernel.org>; Wed, 05 Feb 2020 22:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X0Rm6kBckb4sBApTm/PUZsch++TfXv/lFuKt9F/YXOA=;
        b=Q2uLpXWhWm0sfD4ryTehqenmzgeGP+bMJL7276vWolVm0kEHjeKRyHJqbREgI5GpFv
         CkuBL54VGmuWKdpehbtSJWA5TvigQbF0UTzDP7maLxVHGHNDaR71Yf8JTSwK6TNneSvr
         9ctqQZ++CBQ0L9kPTgTbbyEsPABZz+bM9ODP+zr3cXlj/fdyLmmiylO2qrCmV+ZJo+vO
         2xOrnMEpvL5SbHJJtfnmXScdTVrr+gUAmZuDE/4/wmOWlpDoJt3GVWeKKa4SbdXWziWi
         bReEQdfll0XXM8v+bcyYOsMJDfeoOi8dW590iwNg1U47GuWUptSHEr8VtmVnKf25C6Sk
         vkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X0Rm6kBckb4sBApTm/PUZsch++TfXv/lFuKt9F/YXOA=;
        b=j5L/gTTHnBrDBw//t+QPiHUMpNvSNuJdYwoKGTmKWNqTCZP79BUQv/IrFBEPjmsh7w
         spyAGegkFPA3BH3xtWl6YXX4rVOvMweHuKmNC2ZH90a7G/xmTHBxYrQLuwKN7Dt0QMJP
         aykkyiUabR3jNyXmvUOvsyRYWiAIbbUd0iyDb7rT/+W4Vnsuyf08mGyhzc/D5owX/HoF
         pL0phUPCh2YAlSAAWyM7N66z7JMb1qtKbDkWEGfGtLxJdqfQEW8PYU7/SLl/vu9Zx/Hr
         akEib+hLktbEblHSfqp8ZAZcgwjyp5oP5NV6QDng5LarODDyW5ZXA4usa2/LQJOS3n6s
         34BA==
X-Gm-Message-State: APjAAAXrMj8bHVPTcYl3AyL5YFeB/s1k3qxiXOXOWxxtfzvPrpwyxeDe
        SBClK4J0px09Bd3ZWvBCwxut174JBmMnq5ggmCA=
X-Google-Smtp-Source: APXvYqzJkwjXi48NOHXqEnPmfMg78jMjpdR36VOVpvsYW4yV48h/Xp7I+legtv7hiAB0cYXnNeVJKr2LoTqejI+4pbY=
X-Received: by 2002:a9d:268:: with SMTP id 95mr29824545otb.183.1580971847817;
 Wed, 05 Feb 2020 22:50:47 -0800 (PST)
MIME-Version: 1.0
References: <CAEOGEKHSFCNMpSpNTOxrkDgW_7v5oJzU5rBUSgYZoB8eVZjV_A@mail.gmail.com>
 <6cea6393-1bb0-505e-b311-bff4a818c71b@gmx.com> <CAEOGEKHf9F0VM=au-42MwD63_V8RwtqiskV0LsGpq-c=J_qyPg@mail.gmail.com>
 <f2ad6b4f-b011-8954-77e1-5162c84f7c1f@gmx.com> <CAEOGEKHEeENOdmxgxCZ+76yc2zjaJLdsbQD9ywLTC-OcgMBpBA@mail.gmail.com>
 <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com>
In-Reply-To: <b92465bc-bc92-aa86-ad54-900fce10d514@gmx.com>
From:   Chiung-Ming Huang <photon3108@gmail.com>
Date:   Thu, 6 Feb 2020 14:50:36 +0800
Message-ID: <CAEOGEKFB9Keg91AKHmYc47BF4LrpjDS_93UBFgHS+JeLTzaSLg@mail.gmail.com>
Subject: Re: How to Fix 'Error: could not find extent items for root 257'?
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=886=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8812:35=E5=AF=AB=E9=81=93=EF=BC=9A
>
>
>
> On 2020/2/6 =E4=B8=8B=E5=8D=8812:13, Chiung-Ming Huang wrote:
> > Qu Wenruo <quwenruo.btrfs@gmx.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=886=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:13=E5=AF=AB=E9=81=93=EF=BC=
=9A

> Got the attachment.
>
> The first strange part is, I see several mount failure with is caused by
> 4 or more devices missing.
>
> Then it mounted with devid1 missing.
>
> After reboot, you got the the full fs mounted without any missing.

That's because /etc/crypttab of rescue system wasn't set up correctly.
I logged in at the first and then fixed it.

> So far so good, but I'm not sure how degraded mount affects here.

> Soon after that, there is already problem showing some degraded mount is
> causing problem, where num_devices doesn't match.

Before `btrfs balance start -f ...` to single, I removed 3 disks from
/etc/crypttab of
server system. They are 1TB(empty), 2TB(empty), 10TB(5TB data + metadata).
10TB is one of RAID1 copies. I formatted 1TB and 2TB immediately but not 10=
TB
just in case. Then, I triggered `btrfs balance ...` and let the server
keep receiving
data from internet. I thought 10TB disk has old data and metadata. Even if =
I add
it back to RAID1, btrfs can figure out what data are new or old and
fix it automatically.
The server can work at the mean time. Just wast some disk space but it will=
 be
rectified by `btrfs balance` or `btrfs scrub` later. Is that true?

`btrfs balance ..` suddenly failed after hours. The server system was
totally not
responded, included ssh and ctrl+alt+3. After that and power-off, I booted =
into
the rescue systemand then fix /etc/crypttab and bring all to /dev on the re=
scue
system.

So `super_num_devices 3 mismatch` means these 3 disks. (Not sure)

> So from the full dmesg, it looks like the abuse of degraded is causing
> the problem.

According the description I wrote above, is the conclusion still the same?

> Thus degraded for btrfs should really be considered as a last-resort
> method. And manual scrub after all devices go back online is really
> recommended.

Thanks for your analysis and help.

=F0=9F=92=94 What's done is done. My purpose now is to try to fix btrfs and=
 save
data as much
as possible. Should I unplug 10TB disk, one of old RAID1 copy, at the first=
?
Originally, the server had about 6TB data. This 10TB disk I removed from
'/etc/crypttab' keeps about 5TB data. I'm worried what I'm going to do at t=
he
next step may result in loss of this 5TB data. Maybe worse, it's gone alrea=
dy.

I tried mount btrfs with only this 10TB disk. It didn't work. Dmesg showed
[Thu Feb  6 14:34:03 2020] BTRFS info (device bcache2): allowing degraded m=
ounts
[Thu Feb  6 14:34:03 2020] BTRFS info (device bcache2): disk space
caching is enabled
[Thu Feb  6 14:34:03 2020] BTRFS info (device bcache2): has skinny extents
[Thu Feb  6 14:34:03 2020] BTRFS warning (device bcache2): devid 3
uuid f9b7fe84-d95b-4db5-9e2b-c34a2d4186e9 is missing
[Thu Feb  6 14:34:03 2020] BTRFS warning (device bcache2): devid 5
uuid d442b477-0233-4a4a-aa71-cb24343b83ee is missing
[Thu Feb  6 14:34:03 2020] BTRFS warning (device bcache2): devid 6
uuid d18e3182-a3cc-448b-b15b-0a20dc9c8cbe is missing
[Thu Feb  6 14:34:03 2020] BTRFS warning (device bcache2): devid 7
uuid 991286c4-fa81-417a-876d-a0cb10989ded is missing
[Thu Feb  6 14:34:03 2020] BTRFS warning (device bcache2): failed to
read tree root
[Thu Feb  6 14:34:03 2020] BTRFS error (device bcache2): open_ctree failed


Base on your analysis, could you give me some advice about the next
steps to save
my btrfs raid? Are they
1) Apply the patch.
2) `btrfs check --repair /dev/bcache4`


Regards,
Chiung-Ming Huang
