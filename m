Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EAF3FB422
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 12:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236411AbhH3Kw5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 06:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbhH3Kw4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 06:52:56 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232DEC061575
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 03:52:03 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x5so11209101qtq.13
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Aug 2021 03:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=zfgUWq4fO/UMqsyxQbTkKpv0o/XYCdQuE7zLYvIa1J8=;
        b=aC9pfxdX/RpDy2lp441ESHYk8CYoLVERC5OILDmAiyQkTOiVoZWxRRJWsa3Hz8jeFQ
         jHRBhn71xB/f0rZW7CzsLa39WrlyPBfer0pSsRg6n7G6aN8+h+DmqWuy0I1aYsjAf+CH
         mATsGUGiBagE/iqSvStBTsUUM3Vwc1KaIRG9FmfO6tfN48p0AhA0UhGZlqIGj2Fy3e40
         ekfUsG8SUtL+Cb+P6ASCnccHmrSXcX32K/HXIY2yGjWnPL6JHuGTkREntffyfdolYSm/
         vQHMKlfNbMoaVq9DlUWWVvqU9Oj1x8PM+hmnOu0pF32p5P0C1VPU38XBOnpv/avo3N6R
         +Fgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=zfgUWq4fO/UMqsyxQbTkKpv0o/XYCdQuE7zLYvIa1J8=;
        b=FnEbPvbxz5nnv3kWfyZDbwp6cQMtQocLNtmhO5deJOPFJda+DNnOFXG89wigQG1hvU
         oFD1YLBpUEYGhAAqM15+aer4TVzdEd8yiNF0w3KkHnpctOSacLH0YDCMGCdyo3sfepVP
         /E6URDZvPxgQYl2lzITtt671XnUsGwe6pl7vWvLBA6ERAg69f/JJTuBk96wEEXKaYRK1
         9V5rDiEUSJ6VYSjlQS3z8yk6TobPiboywDTge1AqvK9rBjLwEwQQPOOOq9S536DEMUJB
         YVT9oMdF2TrSrG+KNawetCroB0rg+ft6IarknzAw9iIfejbrVvUcbi18j5ZLk2hzUelo
         Y9+g==
X-Gm-Message-State: AOAM5324ZsOAWrBBFnc8bdpTGdFlYNCBnBKYwloAkvkYvmeeDNVEWx3C
        FcWrOLQ4Vpft+XUJa2VY+7q6ZFOXe3H1Hl88JlibhMPB
X-Google-Smtp-Source: ABdhPJwZjjjUPRfwdn2gLLPYWEoJAIW4FWbC1n29TNN9J5mQg3bkVCqxh+eCdvTCFjCPI6Uo+p/p+8Ao+ebyOJgYGyM=
X-Received: by 2002:ac8:424c:: with SMTP id r12mr20181921qtm.183.1630320722311;
 Mon, 30 Aug 2021 03:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAOaVUnV3L6RpcqJ5gaqzNXWXK0VMkEVXCdihawH1PgS6TiMchQ@mail.gmail.com>
 <CAL3q7H5P1+s5LOa6TutNhPKOyWUA7hifjD1XuhBP6_e3SQzR8Q@mail.gmail.com>
 <CAOaVUnU6z8U0a2T7a0cLg1U=b1bfyq_xHa8hoXMnu6Qv1E-z+g@mail.gmail.com>
 <CAL3q7H7kbgsiTfLWWYJikuWOFP9yXSdgav2EEonx98pPhSEQNA@mail.gmail.com>
 <CAOaVUnV9FJSVBxmX-tAeZJCq+0rPoY2zga8nuw_toC=tdt8K0w@mail.gmail.com>
 <CAL3q7H5xkGiLcfMYDb8qHw9Uo-yoaEHZ7ZabGHhcHfXXAKrWYA@mail.gmail.com> <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
In-Reply-To: <CAOaVUnUwoq69UZ_ajoxYYOHk8RRgGPNZrcm9YzcmXfDgy24Nfw@mail.gmail.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 30 Aug 2021 11:51:51 +0100
Message-ID: <CAL3q7H67Nc7vZrCpxAhoWxHObhFn=mgOra+tFt3MjqMSXVFXfQ@mail.gmail.com>
Subject: Re: Backup failing with "failed to clone extents" error
To:     Darrell Enns <darrell@darrellenns.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 27, 2021 at 10:05 PM Darrell Enns <darrell@darrellenns.com> wro=
te:
>
> Inode number of places.sqlite is 400698. It's the same in both
> snapshots, as well as the current active subvolume.
>
> From 2nd snapshot (id 977):
>   Size: 83886080      Blocks: 163840     IO Block: 4096   regular file
> Device: 5fh/95d    Inode: 400698      Links: 1
> Access: (0640/-rw-r-----)  Uid: ( 1000/   denns)   Gid: ( 1000/   denns)
> Access: 2021-08-27 09:59:01.619570401 -0700
> Modify: 2021-08-27 10:06:43.952629419 -0700
> Change: 2021-08-27 10:06:43.952629419 -0700
>  Birth: 2021-08-07 20:16:37.080012116 -0700

Thanks.
A quick first look shows me that the cause is not what I initially
suspected - the clone operation that fails is not from the inode at
the send snapshot to the same inode at the send snapshot (cloning from
itself), but instead from the parent snapshot to the send snapshot.
The clone offset and length seem valid at first glance, as clone range
is within the eof of the inode in the parent snapshot and it's
properly aligned. So I'll have to recreate the same extent layout and
see if it fails, which will take a while.

Can you please keep those snapshots (IDs 977 and 881) for a few days,
in case of the need to get more debug information or to try a patch?

Also, I forgot to ask before, but you are not passing any clone roots
to "btrfs send" (-c command line argument), right?

Thanks, I'll get back to you later.


--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
