Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B994D79394
	for <lists+linux-btrfs@lfdr.de>; Mon, 29 Jul 2019 21:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfG2TKS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 29 Jul 2019 15:10:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38277 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbfG2TKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 29 Jul 2019 15:10:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id g17so63037956wrr.5
        for <linux-btrfs@vger.kernel.org>; Mon, 29 Jul 2019 12:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t59ZlgmNU16d/aCKjUAbTSrwyGGcSXOzIiFi7Uom1fA=;
        b=GUDt21lFgUS/785vG91AXkhmdxQoutNpXBj21cHnTa7/E6TX3qBYuJsqmHqIhRTMV+
         s0enmgYS28imlcaCdo4X4ZO2znPyMp8j/rL4TQXfDXfTkfYXfB+coUijB+pLb8O41Qa7
         wU5On8xwEERnmc+g/X5OGhh2MwcBE+zdVzT7Bb+YlZZQAK8OGtWhGSd6Z4uli6kFSpNb
         FT+lwMRk3a2Bfim1v12c7SmbNtrwE55BdvgpSOEiy4ckvgqOw+oD/wTGpGBP9pPJ8XPl
         NEZWY+iP90Fp/7UXingYOv+PxKw1P+u8vjnWzMwoctnzwhVU+iMDv+8l95qz9kT458NH
         mw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t59ZlgmNU16d/aCKjUAbTSrwyGGcSXOzIiFi7Uom1fA=;
        b=nNL7IwZqJQpZ90SQkP+R45pGvOpbQP2VDT57WIM9lNM8yM357uVViMuBhX591FWZOG
         91JjxQau/ti41CF3QRHuhXoa9PQdUWBlvzlBNgrcgJgBBYtyu45oioOAbTyQEAxPy4Gt
         zQoQiF/M56iYDYT1q3m0W7ZtIYSREJYYkSRb60d6GSWRH2wXf0qpu4muI5tyisFqVPaS
         lWa4CwvvQ+HLEFUMxlfFESZleYKpAx7M2GNLsRwvD1YeAceUYsb9bDHonWSazTG4vVLd
         SBVueh0JR1Dn4UtMhVAnQnC0snt3UsjB1Jmactyru175kFq9kV6Kk/d0AOO4wiXUwWIY
         ++Aw==
X-Gm-Message-State: APjAAAVTuF1lrqjFdaAWWzk/VC0g/JlOZjMp196bV3dt5cNxhWbtjZgO
        FxfFb7DN3sJh6yOU0m2rohJwHN5+9/YlRi98x7Bs5dgies8=
X-Google-Smtp-Source: APXvYqzU+uyK4gkNEyhqPZyCHKYj4yO888MULZKcYCdN/DYZAn/PHDbRQmYGagJYLJ7SarVv0nuY+Chk4IMWNGblSro=
X-Received: by 2002:a05:6000:4b:: with SMTP id k11mr19895522wrx.82.1564427416069;
 Mon, 29 Jul 2019 12:10:16 -0700 (PDT)
MIME-Version: 1.0
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org> <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org> <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org> <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
 <71bc824e-1462-50ef-19b1-848c5eb0439d@gmx.com> <a08455f0-0ee0-7349-69b3-9cdd00bfe2aa@petaramesh.org>
 <fc26d1e5-ea31-b0c9-0647-63db89a37f53@gmx.com> <4aa57293-3f60-8ced-db14-ed38dff7644b@petaramesh.org>
 <43dc92e7-cd13-81db-bbe5-68affcdd317b@gmx.com>
In-Reply-To: <43dc92e7-cd13-81db-bbe5-68affcdd317b@gmx.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 29 Jul 2019 13:10:04 -0600
Message-ID: <CAJCQCtTSu4XdUmEPHD_8QL71U3O3M8-0m+SweqhPonkKRMUMeg@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Jul 29, 2019 at 8:40 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>
>
> On 2019/7/29 =E4=B8=8B=E5=8D=8810:34, Sw=C3=A2mi Petaramesh wrote:
> > Le 29/07/2019 =C3=A0 16:27, Qu Wenruo a =C3=A9crit :
> >> BTW, I'm more interesting in your other corrupted leaf report other th=
an
> >> this transid error.
> >
> > Well I already broke 2 FSes including my most important computer with
> > this, took me 2 working days to restore and mostly fix my main computer
> > which I couldn't use for a week (because of lack of time for restoring
> > it) and now I lose my main backup disk.
>
> At least from what I see in this transid error, unless you ruled out the
> possibility of bad disk firmware and LVM/LUKS, it's hard to say it's
> btrfs causing the problem.

I'm using kernel 5.2.x since early rc's on several ystems, nvme, SSD,
HDD, half plain partition, half on dmcrypt/LUKS. I can report no
problems. None are on LVM.

It comes down to:
a. workload specific behavior is triggering a new bug in Btrfs or dm
or blk layer, or combination
b. new hardware issue

It seems to me whenever weird stuff pops up with ext4 or XFS, their
call traces generally expose the problem, so I wonder if Btrfs devs
still have the kernel debug information needed to point the blame; or
if there needs to be some debug mode (mount option?) that does extra
checks to try and catch the problem. Is this a case for metadata
integrity checking of some kind, and have Sw=C3=A2mi run this workload?
Either on the problem file system or a new Btrfs file system, just to
gather better quality information?

But yeah, at least a complete current dmesg is needed. And even
possibly helpful is kernel messages for the entire time since
switching to 5.2.0: it could be a big file but easy to filter for dm,
libata, smartd, and btrfs messages. The filtering I'd leave up to a
developer, I always by default provide the entire dmesg, it's not
always clear what the instigator is.

We've discussed many times how both file system repair, and file
system restore from backup, simply are not scalable for big file
systems. It takes too long.


--=20
Chris Murphy
