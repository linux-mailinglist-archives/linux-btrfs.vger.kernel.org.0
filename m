Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15819151A6C
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Feb 2020 13:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgBDMRW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Feb 2020 07:17:22 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35984 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727156AbgBDMRW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Feb 2020 07:17:22 -0500
Received: by mail-vs1-f65.google.com with SMTP id a2so11186749vso.3
        for <linux-btrfs@vger.kernel.org>; Tue, 04 Feb 2020 04:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=k/EzLHy956tTwPGe2CvpIXk2Cw3d04yIjRTyANwWmTc=;
        b=C64y17721MqxgcZ90Yw/YFttVqhpZ3UlHtgfxAbVhFA1qQ8/htZ3IryNECDzvnFZHF
         fsM/4ReV/Lj4E6RT2aX3HLhGHZ8r2oZaq+KAtzDF3RFgn9k8DMbpe8STWwGM9r4sT02o
         S88cnGvq+nQyEZHd+H6FXtEBGV5CLUX5eP1bt7fzywMxYzK1GihKF14TreX6g6iTb0s9
         ku4ylziuSwk3+hQXukY1V1rd+oYMXtFBup5dT72xi3nI6s4e4KAVOhoF1cfH6sdzc6ja
         BaWvyotxd0dfQzbVfnb0YDUTaTu62Z7TpTyaI0MvM3VLcDwQq3scHvkqroPAsuijIE4m
         6Rdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=k/EzLHy956tTwPGe2CvpIXk2Cw3d04yIjRTyANwWmTc=;
        b=fjg2rs8kJRDLH3cL1pppzoADFvHA29fdam7YsuJ+v5BUO3LKwJnDnFWlMcpz9YmcZY
         ch/5i+3iUlVy51bocsLE50tHYlITFRxREqXDiKtiX/OUMYXPyDYWhviUKVnb5GI9eZRB
         j7ByWwZTcv8Jkv2+wCoSS70NK57yn6cs/nWbz+ogXUjMunecSwcYqlW9eiGMCSipvdzj
         k34IFfm02w6jfTD6IqCyB8z+HP97dfruZI9EJUikQxnl4iAMFkZvrVv4SmgVc07DFG4Y
         Ptf/uPLDdndIpwdH9DG0mwZKqQiThbgfrPtYVa+zxOJnP5aaydc6jzVl9weZL7irPQdu
         rGkw==
X-Gm-Message-State: APjAAAV6qr3OFdUJWuqiqtgJyhgv7gXUOt7j0Bp3DX5bgwktm1iaTZ3z
        BQmStU0H+6IwwsXzqShee2tSBEyOTrY1Bdv3Ms9vGPH7
X-Google-Smtp-Source: APXvYqyVDBdp+BOCT8wOEZeSezl3uT6aunWiduTqUmM5DwH+lpncNWS3sbaCuBUW+TEnW694HS68f3ZiHQKSVhZay00=
X-Received: by 2002:a67:ff14:: with SMTP id v20mr18299937vsp.114.1580818641196;
 Tue, 04 Feb 2020 04:17:21 -0800 (PST)
MIME-Version: 1.0
References: <CAM9pMnP7PJNMCSabvPtM5hQ776uNfejjqPUhEEkoJFSeLVK2PA@mail.gmail.com>
 <9cff72cb-ef8e-2d12-45ad-3a224e86b07a@gmx.com> <CAM9pMnOpSFnR9Dc_MyTyJevMRgiKBMPec-Y2W-iMbeyatTetog@mail.gmail.com>
 <6f39d3a5-fdae-a0af-007a-5e95067b5921@gmx.com>
In-Reply-To: <6f39d3a5-fdae-a0af-007a-5e95067b5921@gmx.com>
From:   Robert Klemme <shortcutter@googlemail.com>
Date:   Tue, 4 Feb 2020 13:16:45 +0100
Message-ID: <CAM9pMnOkuqfu8Grwc2ddBsUTCJgJb2Y4Z5RnHmCLX1_fAHfeCQ@mail.gmail.com>
Subject: Re: Root FS damaged
To:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Feb 3, 2020 at 3:10 PM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2020/2/3 =E4=B8=8B=E5=8D=889:58, Robert Klemme wrote:

> > I would assume as much as there were no power outages or crashes. I
> > read about a bug recently (probably on
> > https://www.reddit.com/r/btrfs/) that had to do with btrfs on LUKS and
> > / or LVM. Could this be an explanation?
>
> No, it should only be some bug inside btrfs, nothing to do with lower sta=
ck.

Unfortunately I have not found the source again. IIRC that was about a
bug in btrfs code but showed only in combination with either LUKS and
/ or LVM.

> >> Btrfs check --repair should be able to repair that, but not recommende=
d
> >> for your btrfs-progs version.
> >>
> >> There is a bug that any power loss or transaction abort in btrfs-progs
> >> can further screw up your fs.
> >
> > That explains why a repair I recently attempted elsewhere did make
> > things worse...
> >
> >> That bug is solved in v5.1 btrfs-progs.
> >> I doubt it's backported for any btrfs-progs at all.
> >>
> >> So please use latest btrfs-progs to fix it.
> >> A liveiso from some rolling distro would help.
> >
> > Is there a PPA? I could not find one so far.
>
> For "some rolling distro", I mean Arch...

:-) Understood, but I would have liked to also install the newer tool
version on that system. Anyway, I pulled a Xubuntu 19.10 and that has
more recent btrfs tools. Repair went smoothly and system is up and
running. As additional measure I installed Ubuntu's HWE packages to
get a newer kernel (from 4.15 to 5.3.0).

$ sudo apt install linux-generic-hwe-18.04 xserver-xorg-hwe-18.04

Just wanted to give you an update how it went. Again, thank you for
your support!

Kind regards

robert

--=20
[guy, jim, charlie, sho].each {|him| remember.him do |as, often|
as.you_can - without end}
http://blog.rubybestpractices.com/
