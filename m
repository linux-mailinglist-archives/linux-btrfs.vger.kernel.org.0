Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862FE3507F0
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Mar 2021 22:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbhCaUMA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Mar 2021 16:12:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbhCaULc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Mar 2021 16:11:32 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1EFC061574
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 13:11:32 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x16so20854216wrn.4
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Mar 2021 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8i70MQVvAkxEW43oHBGbdupxM0O3nxUHAT3BZ2ohwTI=;
        b=N854ZXsiIj9cqAPDgoeyFR5/fK3lE8b5BPIths38ALMBwoBlA9ojhyQ634RmjFipRP
         FaWh8+8I0mIoVTFDeNfWVrTl/RA5TMITlgeMM5WVi6T4Dwlp/ZcIEnGE7rRZ/8HLV2fd
         aR8X5XGSP7m+JyrfTNiHEO+qsqPLy8ga3TXZn1bfpX+SZNXkRwK4jp21L6JpbTRhRYL8
         AwJQTX0GxNH/WlHTcKRD4dgJeayfJBJJof48nTD+fcC4m7ZLsR2S/ZC5Nn6gyh9xhDkW
         Fb+hCtAm5q18SremaUnRBYNti9t8ezzDsfzfJn2TsXrrJ25KeEwddh40knepRSy/lHm6
         ZhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8i70MQVvAkxEW43oHBGbdupxM0O3nxUHAT3BZ2ohwTI=;
        b=A2ErSDtiV+Vz1WT5lOHRKNPddKFwfD/a681Hyf5r5wRpd13BrfPTsaQCPneX/iZB7X
         nqsTbYaq1NzJwXzceFVFg3Y7GO/cEOMdO5k1Eqwqq9RByPIV+NbdBGMpflh0Mu2i7Bsx
         DSLAkK0QEphF55RctHcEMgK4D6tAwdpFOXbKUuJxc0HxkfCVlhbG+4vF3EU+Jb3mHzmQ
         F3/c4F4vdOBDPt4S1b9xAjzKUMDq++GH6J2higM9FgUWyBcz7e17ye9BN1m4FtNLgYid
         fyhMvtnJrLJVfFZ7yYNwlXkNfrcyEISAS/jtrg/ums0a2NEyAZzTZTnxDI6EO4xOD5Hh
         F9+A==
X-Gm-Message-State: AOAM532BAtbCON1uQbVW4/Km9c9A72bPhTn4P3BuZxVJ1xpLcOp9QAQ+
        NbHyrYGKDTC8GHzUMEZH1UvYNuHsckS4+9VmC9Qql0UsmCqs6Q==
X-Google-Smtp-Source: ABdhPJy71l9qOgAMprlp6niF44ktUlyqxz8m32qsNaV/V6tZOiN5jLwtgcuQT+7EnfrbFIbGtQJobq7Hm/5uHd50CQQ=
X-Received: by 2002:adf:e5cd:: with SMTP id a13mr5476996wrn.65.1617221490938;
 Wed, 31 Mar 2021 13:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <emfd92f28c-2171-4c40-951d-08f5c35ae5a0@desktop-g0r648m>
 <CAJCQCtQt83dXev6Ngo_tDPZFqD60eD3W3h-1ZT8KLc5hMcB_HA@mail.gmail.com>
 <em7b647410-6346-4e95-b97a-f45ee2de0037@desktop-g0r648m> <CAJCQCtQH=k_h7CyRLysea0NgqadPnOVtVTGzdU9pG69RRhqL+g@mail.gmail.com>
 <emf567b17e-42d3-4c32-b254-a19d06ed87c5@desktop-g0r648m>
In-Reply-To: <emf567b17e-42d3-4c32-b254-a19d06ed87c5@desktop-g0r648m>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 31 Mar 2021 14:11:14 -0600
Message-ID: <CAJCQCtTTo+fTJ8nfRqWovSeRJEF72C0RQmydGq=ju86HAMMECw@mail.gmail.com>
Subject: Re: Re[4]: Filesystem sometimes Hangs
To:     Hendrik Friedel <hendrik@friedels.name>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Mar 31, 2021 at 8:03 AM Hendrik Friedel <hendrik@friedels.name> wro=
te:


> >>[Mo M=C3=A4r 29 09:29:21 2021] BTRFS info (device sdc2): turning on syn=
c discard
> >
> >Remove the discard mount option for this file system and see if that
> >fixes the problem. Run it for a week or two, or until you're certain
> >the problem is still happening (or certain it's gone). Some drives
> >just can't handle sync discards, they become really slow and hang,
> >just like you're reporting.
>
> In fstab, this option is not set:
> /dev/disk/by-label/DataPool1            /srv/dev-disk-by-label-DataPool1
>         btrfs   noatime,defaults,nofail 0 2

You have more than one btrfs file system. I'm suggesting not using
discard on any of them to try and narrow down the problem.  Something
is turning on discards for sdc2, find it and don't use it for a while.


> How do I deactivate discard then?
> These drives are spinning disks. I thought that discard is only relevant
> for SSDs?

It's relevant for thin provisioning and sparse files too. But if sdc2
is a HDD then the sync discard message isn't related to the problem,
but also makes me wonder why something is enabling sync discards on a
HDD?

Anway I think you're on the right track to try 5.11.11 and if you
experience a hang again, use sysrq+w and that will dump the blocked
task trace into dmesg. Also include a description of the workload at
the time of the hang, and recent commands issued.



--=20
Chris Murphy
