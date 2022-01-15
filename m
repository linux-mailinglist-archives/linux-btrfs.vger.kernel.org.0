Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27B348F95B
	for <lists+linux-btrfs@lfdr.de>; Sat, 15 Jan 2022 21:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233674AbiAOUpr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 15 Jan 2022 15:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiAOUpq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 15 Jan 2022 15:45:46 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428F5C061574
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 12:45:46 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id n139so4045097ybg.0
        for <linux-btrfs@vger.kernel.org>; Sat, 15 Jan 2022 12:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cS/L0lsZuo+GnBoyBAXIt2ooPXMTJ0kn+O0BcIz4/o0=;
        b=QQPRzvLajtISTiN1SGBhaFa98A1J4cTxdRNHtDwUbpZAsmMIuknY67kT4JaSXw511L
         sRUlUF7Y6yseK0Rb6r6GJUTAEI0aRx+W8SPh6m1pFSbUp3BAKN5LpxWyWUBI3ICmRz54
         kOEkvoSkeXn1sQlctiHFD1GPDAPI9UUz7lfkcV6JqZxud1IsNwdu1JiaMCLQ6y0ONd2W
         xvjjP/Mi++7g9toSU2gZrD8h5tCHrstQFUDB+XaEiHio/awZhf6ErCvSkKsNi35yY9fu
         VJCX7C9/6Jff44ZoLo9n5olBp26vLBjuv6eRkBE/p5JczvzbZJx4gMI6B5AgOH1bndAR
         O/IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cS/L0lsZuo+GnBoyBAXIt2ooPXMTJ0kn+O0BcIz4/o0=;
        b=Vc8ZLZtcTb3FFnLM4ybOQtIEmQEdMPZ2AfX73E57z7bJEQqAYZma5DWAaoj8Bdjd/V
         SBmLK9kf9lu+4GNwViS3LnZ2ZzWk+W2lBrOiYR8kCwSqrDONpmGs1fT5/pu3htz8TgBA
         4HSF5BUrx45gUAq+WaEonZ/sBjjW1xncr237Fc+yCBGdn9MV0dEo9TuJYWF7c2tZieu5
         zGc1EKUPtXUM/UTTnaw0T8MyOA+b7z8hqMIk1xSrAUpduflXj6MkEvUbyGVICL8+irEV
         qILrhFYNmAkVPSZhrTRf2lMsFhevlhmytCQi5ud/KR+LCF22aQMDb7TrJKodQILpjWqV
         iMGA==
X-Gm-Message-State: AOAM530JuqpcaTN2DSmY8DnU1AhhiEY/Ol7oRdFRNftZnYZowFhHa2Tz
        69KIi8DWT6KJaRZohSugBZ05J3HNdmr1fomPDPtof0+DUuR3nQ==
X-Google-Smtp-Source: ABdhPJytoL1+juC/RJt9/4nkBScEDSrjHbeVovvumLsGDZnbV7m2qqCwLtpW3Klzaz7RguoTjbk0yaep9t26lA9JypA=
X-Received: by 2002:a25:cdc3:: with SMTP id d186mr20423989ybf.400.1642279545188;
 Sat, 15 Jan 2022 12:45:45 -0800 (PST)
MIME-Version: 1.0
References: <6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de>
In-Reply-To: <6ed4cd5a-7430-f326-4056-25ae7eb44416@posteo.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 15 Jan 2022 13:45:29 -0700
Message-ID: <CAJCQCtSO6HqkpzHWWovgaGY0C0QYoxzyL-HSsRxX-qYU2ZXPVA@mail.gmail.com>
Subject: Re: 'btrfs check' doesn't find errors in corrupted old btrfs (corrupt
 leaf, invalid tree level)
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Cc:     Stickstoff <stickstoff@posteo.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jan 15, 2022 at 6:17 AM Stickstoff <stickstoff@posteo.de> wrote:
>
> Dear btrfs-mailinglist,
>
> I upgraded a machine from Debian Stretch (kernel 4.9, btrfs-progs
> v4.7.3) to Debian Buster (kernel 4.19, btrfs-progs v4.20.1) to Debian
> Bullseye (kernel 5.10, btrfs-progs v5.10.1) in one go, with a
> few clean reboots in the process.
> No (other) traumatic events (like hard shutdown) happened in the last
> months.
>
> Now I got an
> > 'read time tree block corruption' and
> > 'corrupt leaf: block=934474399744 slot=68 extent bytenr=425173254144 len=16384 invalid tree level, have 33554432 expect [0, 7]'
> error.

Older kernels don't have the read time tree checker, so they tolerate
this form of old corruption likely by a bug in an older kernel (but
hard to say).


> The filesystem mounts and works, after a while this error shows up and sometimes the fs is then forced read-only.
> A scrub quits after a few minutes with the exact same error.

Forcing read only is the way the file system avoids corrupting itself
when it gets confused. That way the confusion stays in memory
(hopefully) rather than ending up making things worse on disk.

Take advantage of the fact you can mount the file system, and freshen
backups to prepare to abandon this file system. Depending on the
problem, it might be fixable with current btrfs-progs' btrfs check but
... if it's extent tree damage it's going to take a really long time
to find out, and then only at the end when it either fails or makes
things worse do you find out.

> After consulting the IRC (thank you again for your help!) I tried "btrfs check --readonly"
> and "btrfs check --repair" both with the stock btrfs-progs v5.10 and v5.16 from kdave's git.
> All runs found no errors or problems and did not fix the corruption.

Interesting that btrfs check doesn't see any problem, while the tree
checker does. That's its own bug somewhere...

Can you provide a complete dmesg of the read time tree checker error?
Ideally everything from mount to going read-only.


> One possible explanation from IRC was that the corruption might have existed for a long time, and was only caught
> when the newer 5.x btrfs started to first check these parts of the fs.
> The corruption itself might have been caused by bitrot, bad memory or some random event, the machine is a consumer grade PC with
> regular non-ECC memory. I noticed maybe two, three unexplained program/daemon crashes since 2015.

Yep hard to say but with complete dmesg it might be possible to figure
it out because bit flips have a pretty unamibiguous signature compared
to the random junk that a bug from an older kernel might have
injected. But still, it's unexpected that the tree checker finds
things that the fsck doesn't.


-- 
Chris Murphy
