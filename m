Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFA2F24B11
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2019 11:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfEUJB6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 May 2019 05:01:58 -0400
Received: from mail-qt1-f169.google.com ([209.85.160.169]:41932 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfEUJB6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 May 2019 05:01:58 -0400
Received: by mail-qt1-f169.google.com with SMTP id y22so19545300qtn.8
        for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2019 02:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rkjnsn-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=He1yfzGy2zlsjKvQZ4VHqo1aIhQELTLYaIlV46sxuyU=;
        b=19ueHWJNxK0hwgfQVvLlvBd9osdUvbsexrjXcXnGCQsevCiRa0BTGv3UPvIXukZAoi
         GTr42sVGtfQN9IzJDQeAbrbWhEkNE336ZYjQHddm+QmS1o3SgF1hjcWmTdUE7WYnfgzY
         hPQOKzGe0d27ff4sX+azPTZzQuxauU9HQTVs9J8hmX9NByQF/PvYvhq/wRn7b8R7vtmb
         IwTmBDkTmUKiB0C5EDjqE2ERFNmtE4+BvYbQlj6pvu/01jiydWbHf0Tbh9yPz00/LX0e
         tJQSpwSmplJ/Vq28cVrzn+q6L9LRynHnGQ/8scWageTAlR1x2L9EDLLbw71+z9oNozw8
         g7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=He1yfzGy2zlsjKvQZ4VHqo1aIhQELTLYaIlV46sxuyU=;
        b=lsu0sr8TMsIaqRmXI5fvYr1zFOZDS+M6VDTOaceh8LsdU25Hpt5dRyXMxU1Bz333k5
         pDQmSynDTKWkTjDuYTwjcPTXQhYWhyPxasPZRrpvawV5mYz4TWtJWHHJNJHbIkBf5HtI
         mX/Wx9GtxSIscAR1lsrsXeGAktmtEN3MBjKdAQ7lqcIakEJyECIJ3p/oPYM9JtPTDqLM
         IjY1muyHGraXe3tms7ztdh9ibVatNWHYSo6VSE1Ni1uy3ipJFq0+ZG4APu4dkb+kN2rA
         Qy1hXB/LDFbOMrZ/qfqNz3PMYZdHtaDZWHqX5iojUdGvVQsi5oDqroP6TS8btoxFgZI4
         P4uw==
X-Gm-Message-State: APjAAAV0VRN8NAAOH34fToYw/3VwdzDMXb+WWzCazL9sPD+Z/sKhE15m
        POoUWd329aewJfxiV2qbaKL2wyLAD9M8GV7+G2p6XQ==
X-Google-Smtp-Source: APXvYqzEESSo8FiuZZWZLDypZTUEre/URvrRKIhYaBQ19Ey9g0opWTelqZISIgSaLbxk+u5RNtxHYeNi2FAVk7GAEtw=
X-Received: by 2002:ac8:3fdc:: with SMTP id v28mr65237359qtk.206.1558429317242;
 Tue, 21 May 2019 02:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAMj6ewO7PGBoN565WYz_bqL6nGszweNouP-Fphok9+GGpGn8gg@mail.gmail.com>
 <CAA7pwKPi5L9GT5t3CfhHa07TkLmdhpdM+7417kdLEbnkm7RSaw@mail.gmail.com>
In-Reply-To: <CAA7pwKPi5L9GT5t3CfhHa07TkLmdhpdM+7417kdLEbnkm7RSaw@mail.gmail.com>
From:   Erik Jensen <erikjensen@rkjnsn.net>
Date:   Tue, 21 May 2019 02:01:45 -0700
Message-ID: <CAMj6ewNeKoHnTCXtmv1PhE5Jpn5=iFNp-FnZgz2n3wnwBsB6tg@mail.gmail.com>
Subject: Re: "bad tree block start" when trying to mount on ARM
To:     Patrik Lundquist <patrik.lundquist@gmail.com>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Whoops, sorry. I actually meant RAID1. Data is RAID5, Metadata and
System are RAID1.

On Tue, May 21, 2019 at 1:56 AM Patrik Lundquist
<patrik.lundquist@gmail.com> wrote:
>
> On Tue, 21 May 2019 at 10:35, Erik Jensen <erikjensen@rkjnsn.net> wrote:
> >
> > I have a 5-drive btrfs filesystem. (raid-5 data, dup metadata).
>
> I don't know about ARM but you should use raid1 for the metadata since
> dup can place both copies on the same drive.
