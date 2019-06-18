Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B374AA96
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Jun 2019 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfFRTEK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 18 Jun 2019 15:04:10 -0400
Received: from mail-wr1-f46.google.com ([209.85.221.46]:37703 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730231AbfFRTEJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 18 Jun 2019 15:04:09 -0400
Received: by mail-wr1-f46.google.com with SMTP id v14so686916wrr.4
        for <linux-btrfs@vger.kernel.org>; Tue, 18 Jun 2019 12:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JlPhXMbPlna11dTRNiGlWzQsq+a5WAMSifktWVt+TlA=;
        b=pbeU6oJrkKTduCSbo6o4nGSXM0WC4H0NipSXOzzoeQU3SmKZvGybsVvKTcDRRf2hrq
         kLbgmqB14W/vIK4tIR3IjiyZqrHcdE8D6vVyg4GqLne8YV9+PAuDnD3OYwQ1QZOKXe0i
         F0blcum8i60tIDa7mDnehMjRh1r5WQKvCdcfHBs/o6zcz7WGpKGnjIJ4yoIKNkamXEQG
         kZoKH9JGsUYcyDTd2L+QdQpW/POLqJPNW3tSeI2ntCFZ/4LLVOWfKvi0kP5i7VKcjoH2
         Q9SNNLejn3KgHOuMn7mACwma86sX098Aht5MmtAFbVUgH4eFHkAEZFP/MBONDFUnEW5d
         lu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JlPhXMbPlna11dTRNiGlWzQsq+a5WAMSifktWVt+TlA=;
        b=QZnf/Ae20MmkNJzlGf6up4/eldNUFJl4/Mry6X+M3VOGehaqTt7LxNQcVVZAEEGYWW
         IcrETAVVwmQ3kusbUqrOTCA1fh34PB7xhcfrwGsKU667QofCwcPO5/+xaBWxUfEYE7Qw
         hPRxNpR/8krlkJivRMJYiptwutz/LW4I9eLL2qst/AEVAQNdjVVENn/eFlplR/ku+LP4
         YRb74+YEmWojY9m82rB6FQiz0nIwB3KuQblyL3jDR/os+K+t19dxU+PFO7BSOMOE00Rp
         Md5h9ex9veThnHN11Lfccwz4yUIXJwCaYzZ+/wGERUwKr1QCzTVZKsA7YQgE4fYBSArJ
         pTeQ==
X-Gm-Message-State: APjAAAVOiO56VTxZozhzxH6MFx7kXLvZC6kT9YddVCcmcB5PJVcMqyNA
        o2PGH7/5y3Bdy5qs4sPl33dgTK4c1gJWlLz1j5YkLu/WxbY=
X-Google-Smtp-Source: APXvYqzoR06tKTseN/0RKN7VeXwnrGCF462Mj6DxP8H+tUxd9lV2AV2Jd2mAG8f6k1/SSZqmI+NdZrA6nln27pWU9mg=
X-Received: by 2002:a5d:4843:: with SMTP id n3mr31150998wrs.77.1560884647546;
 Tue, 18 Jun 2019 12:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <16b6bd72bc0.2787.faeb54a6cf393cf366ff7c8c6259040e@lesimple.fr>
 <20190618184501.GJ21016@carfax.org.uk> <51e41a52-cbec-dae8-afec-ec171ec36eaa@gmail.com>
 <20190618185701.GK21016@carfax.org.uk> <cab8986b-aa52-0aa8-8f7e-cb5f5a3597b0@gmail.com>
In-Reply-To: <cab8986b-aa52-0aa8-8f7e-cb5f5a3597b0@gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Tue, 18 Jun 2019 13:03:56 -0600
Message-ID: <CAJCQCtTxnniZeuUK1V1Yj-E2CV6igmbzhg8D0eQm-LNbU+JqyA@mail.gmail.com>
Subject: Re: Rebalancing raid1 after adding a device
To:     "Austin S. Hemmelgarn" <ahferroin7@gmail.com>
Cc:     Hugo Mills <hugo@carfax.org.uk>,
        =?UTF-8?Q?St=C3=A9phane_Lesimple?= <stephane_btrfs@lesimple.fr>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Jun 18, 2019 at 12:58 PM Austin S. Hemmelgarn
<ahferroin7@gmail.com> wrote:
>
> On 2019-06-18 14:57, Hugo Mills wrote:
> > On Tue, Jun 18, 2019 at 02:50:34PM -0400, Austin S. Hemmelgarn wrote:
> >> On 2019-06-18 14:45, Hugo Mills wrote:
> >>> On Tue, Jun 18, 2019 at 08:26:32PM +0200, St=C3=A9phane Lesimple wrot=
e:
> >>>> I've been a btrfs user for quite a number of years now, but it seems
> >>>> I need the wiseness of the btrfs gurus on this one!
> >>>>
> >>>> I have a 5-hdd btrfs raid1 setup with 4x3T+1x10T drives.
> >>>> A few days ago, I replaced one of the 3T by a new 10T, running btrfs
> >>>> replace and then resizing the FS to use all the available space of
> >>>> the new device.
> >>>>
> >>>> The filesystem was 90% full before I expanded it so, as expected,
> >>>> most of the space on the new device wasn't actually allocatable in
> >>>> raid1, as very few available space was available on the 4 other
> >>>> devs.
> >>>>
> >>>> Of course the solution is to run a balance, but as the filesystem is
> >>>> now quite big, I'd like to avoid running a full rebalance. This
> >>>> would be quite i/o intensive, would be running for several days, and
> >>>> putting and unecessary stress on the drives. This also seems
> >>>> excessive as in theory only some Tb would need to be moved: if I'm
> >>>> correct, only one of two block groups of a sufficient amount of
> >>>> chunks to be moved to the new device so that the sum of the amount
> >>>> of available space on the 4 preexisting devices would at least equal
> >>>> the available space on the new device, ~7Tb instead of moving ~22T.
> >>>> I don't need to have a perfectly balanced FS, I just want all the
> >>>> space to be allocatable.
> >>>>
> >>>> I tried using the -ddevid option but it only instructs btrfs to work
> >>>> on the block groups allocated on said device, as it happens, it
> >>>> tends to move data between the 4 preexisting devices and doesn't fix
> >>>> my problem. A full balance with -dlimit=3D100 did no better.
> >>>
> >>>     -dlimit=3D100 will only move 100 GiB of data (i.e. 200 GiB), so i=
t'll
> >>> be a pretty limited change. You'll need to use a larger number than
> >>> that if you want it to have a significant visible effect.
> >> Last I checked, that's not how the limit filter works.  AFAIUI, it's
> >> an upper limit on how full a chunk can be to be considered for the
> >> balance operation.  So, balancing with only `-dlimit=3D100` should
> >> actually balance all data chunks (but only data chunks, because you
> >> haven't asked for metadata balancing).
> >
> >     That's usage, not limit. limit is simply counting the number of
> > block groups to move.
>
> Realized that I got the two mixed up right after I hit send.

No one's ever done that! :D

> That said, given the size of the FS, it's not unlikely that it may move
> more than 100GB worth of data (pre-replication), as the FS itself is
> getting into the range where chunk sizes start to scale up.

It's a good point. The limit filter could cause for non-deterministic
results if there's mixed size block groups, created at various sizes
of the file system over time.

--=20
Chris Murphy
