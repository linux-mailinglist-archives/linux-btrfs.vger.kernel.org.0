Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E85997B634
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Jul 2019 01:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfG3XZH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 30 Jul 2019 19:25:07 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:33865 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfG3XZH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 30 Jul 2019 19:25:07 -0400
Received: by mail-wr1-f43.google.com with SMTP id 31so67592828wrm.1
        for <linux-btrfs@vger.kernel.org>; Tue, 30 Jul 2019 16:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wB9GRCyGrImKnIe37AZDZhedjTuA4riiTi45nfBIZCo=;
        b=UgTCOC3SfKfa9y60hrN9ISrPKlQaGg4KEtlwfkD8TzpTKRmzRbV6ZCJlbRaD3B+eyC
         1OduBhQRRrGHknJR3kLiCa1jNJAu+nhJHPb7xKwunU9ASGsuBokrs1YOr39CZVxRJ1a2
         aTnta26kBfaEqmoNRio+6eCgONC1pc6sFkCiMacMeZZBiTjXJ50BydBMug/MbKu5ybCt
         J26tnX56qDWkt4SKczA71PgXdDVgMCeNzeD94QMJYsV2CYhAQ7J4W/u5J3O6ek2bLKMM
         mICjqZz1czqSI6m6Dn0CSJdf/HkqvaTnz9xkATvkA83urDXCGd7O73QvaiSfTs1KriGd
         Mjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wB9GRCyGrImKnIe37AZDZhedjTuA4riiTi45nfBIZCo=;
        b=onrKDNRjscJIZ4dNIGvbHzYxCttfIiksQ003MfAu03rnMT7Tf13Z9xlq9E/p70o3u8
         +Sbmv0pHp3czeOBSiUoS6e8WiWzq6tlySqkstNL+ua8o2z+l6OfzUuopYRTfqYGyEm1e
         upfh49CmqbgwjTd8IqjdJuKUZ2TROLJjEYHDkbIw7OiNNsS51/6+jmpczLq9wQXdeG1J
         F8fjxti7jY/A3x3CAdR2PnELCNwN6EPpEt7AmVYERvSttGLEH6bmwp7jE7ZHzHtNIGuM
         cJzq+IvIvn0Mp56Pk6CXGQ1lDcdxc7+EaoVq8mwXwMP00WoF98uZF7uPRD0DCaflCIrV
         10QQ==
X-Gm-Message-State: APjAAAWRRJqIC7M/dxhfPdcri7T48SVOpsCGuN4beTX4zzedVtgoUebO
        0LteUB2KmAIcMLBaXY8Enn1l1xaw5MsNif355Y0=
X-Google-Smtp-Source: APXvYqyL9yhWc1qjn3gINW1sQgXotzkxcFAKMnTEvKfIn4u45yOaW8O+x1HASHmP1WnFRZStOHP+sXVIZs22f23uS+Y=
X-Received: by 2002:a5d:4403:: with SMTP id z3mr49069422wrq.29.1564529105881;
 Tue, 30 Jul 2019 16:25:05 -0700 (PDT)
MIME-Version: 1.0
References: <bcb1a04b-f0b0-7699-92af-501e774de41a@petaramesh.org>
 <c336ccf4-34f5-a844-888c-cd63d8dc5c4e@petaramesh.org> <0ce15d14-9f30-ac83-0964-8e695eca8cbd@gmx.com>
 <325a96b2-e6a4-91e3-3b07-1d20a5a031af@petaramesh.org> <49785aa8-fb71-8e0e-bd1d-1e3cda4c7036@gmx.com>
 <39d43f92-413c-2184-b8da-2c6073b5223f@petaramesh.org> <b7037726-14dd-a1a2-238f-b5d0d43e3c80@petaramesh.org>
 <71bc824e-1462-50ef-19b1-848c5eb0439d@gmx.com> <a08455f0-0ee0-7349-69b3-9cdd00bfe2aa@petaramesh.org>
 <fc26d1e5-ea31-b0c9-0647-63db89a37f53@gmx.com> <4aa57293-3f60-8ced-db14-ed38dff7644b@petaramesh.org>
 <43dc92e7-cd13-81db-bbe5-68affcdd317b@gmx.com> <CAJCQCtTSu4XdUmEPHD_8QL71U3O3M8-0m+SweqhPonkKRMUMeg@mail.gmail.com>
 <d76a038d-fc7f-5910-ec2d-ac783891f001@petaramesh.org> <CAJCQCtR3pW7T7=DxuAyqwfG+4ii-jg2AVqQL2wVEAx2VrGAY8g@mail.gmail.com>
 <1d80844d-9932-03a8-ae59-c8cbf48a1f57@petaramesh.org> <a73770f4-5ee9-176a-5591-5700864f75b9@cobb.uk.net>
In-Reply-To: <a73770f4-5ee9-176a-5591-5700864f75b9@cobb.uk.net>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 30 Jul 2019 17:24:54 -0600
Message-ID: <CAJCQCtSMHLTBV5RJzqBTZXOQ+dGsQ54RQpu3QX8KuE_RZqytmA@mail.gmail.com>
Subject: Re: Massive filesystem corruption since kernel 5.2 (ARCH)
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     =?UTF-8?Q?Sw=C3=A2mi_Petaramesh?= <swami@petaramesh.org>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jul 30, 2019 at 5:13 PM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
> On 30/07/2019 23:44, Sw=C3=A2mi Petaramesh wrote:
> > Still, losing a given FS with subvols, snapshots etc, may be very
> > annoying and very time consuming rebuilding.
>
> I believe that in one of the earlier mails, Qu said that you can
> probably mount the corrupted fs readonly and read everything.
>
> If that is the case then, if I were in your position, I would probably
> buy another disk, create a a new fs, and then use one of the subvol
> preserving btrfs clone utilities to clone the readonly disk onto the new
> disk.
>
> Not cheap, and would still take some time, but at least it could be
> automated.

btrfstune might allow the seeding flag to be changed on this volume;
I'm not sure what kind of checks are done to see if it's viable; but
also the seed feature is somewhere between tricky and unsupported in
multiple device contexts.

But yeah if it's readonly mountable, it should be possible to script
`btrfs send-receive` based replication for the ro snapshots anyway, to
preserve shared extents.

--=20
Chris Murphy
