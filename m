Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA823C3706
	for <lists+linux-btrfs@lfdr.de>; Sun, 11 Jul 2021 00:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhGJWUj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 10 Jul 2021 18:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJWUi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 10 Jul 2021 18:20:38 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC55C0613DD
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jul 2021 15:17:52 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u8-20020a7bcb080000b02901e44e9caa2aso8616331wmj.4
        for <linux-btrfs@vger.kernel.org>; Sat, 10 Jul 2021 15:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=wf237VUOlDsF2qXtuyhdtLsodPvgjZThuRWO6hShyko=;
        b=o63+Er1dy9anBufvZdsrCZ6wOzOsURQoQjQj98Qav2TSJQ7rkTzErr2IUHFD7o8xNV
         zPgecOfKy1C3d2i+FkxloVI0NWdHi9EnPh+yjtIgivx8kMbji/lqrycRx6PRmPDJTswT
         suMiS83CNy3t4qxyWfZwmmg4m1YrE+ZpEt5L2xdzFH7VT0H9z9LofU5eOzJVW4JF2p2x
         j9CdGGAUi18FNsnPUh88rrTg9hFWVn89D+M8wt+HL2rCA5Hg2FW9f5uke8bl0mkiPSDF
         PT6zQUFeJ5BSZyOVmmWgu9hR6g1LLzhNaPHeLhKrdnO2I4GT8CGimjPYJdnUqUvk3rHH
         yDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=wf237VUOlDsF2qXtuyhdtLsodPvgjZThuRWO6hShyko=;
        b=TSX91fdaciyOrxxpMIC0nF+MzOtS5S2CIhpYvEBFbV4Qz1sHbhqaihBVlBUAF8v3Ql
         h3vCYNugNshP5U5OqVAspjolgz0mf0LtpOm14Ab5gCeuBia18gd4ukOoRMoEaOwIHEyU
         raOlOA6LFNBcZxceUXwahSTmw/naGKvYxvDI5yTzY8XPgewLeEyiSYpDNe+9zPYJc7KP
         UkIcsTn9BpXopVUcWpxb4+uhFPWtRYAQYXudpqzt9OlJzBsCs0ykgCe2BorE6ZbX2nZe
         hFc8LaOsMQ6vqnX85g3Mlq3PcooGy1vhUI/ikzmJjp0CARluYaGtHvMxTmgnIRgpJ7WB
         wjTg==
X-Gm-Message-State: AOAM532WliGzifcdNB1ZfdyxRG8maX11R8b0nV7PxtbaeiL/w+01akaO
        uYDpR9HoDusSlA5A28IDcnzIIZNjDqkhYAj+CFwJoXfPcCRcVwWB
X-Google-Smtp-Source: ABdhPJxqSUu9MRTGvol2hsNeOYDqAhOlcfJ6SpMYuCViup/a3FN3mq3uWR/euFSXVvfqhs0ECs6IhOXoyEJU9WnhE7g=
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr6414373wmj.128.1625955471025;
 Sat, 10 Jul 2021 15:17:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210310074620.GA2158@tik.uni-stuttgart.de> <20210311074636.GA28705@tik.uni-stuttgart.de>
 <20210708221731.GB8249@tik.uni-stuttgart.de> <56c40592-0937-060a-5f8a-969d8a88d541@cobb.uk.net>
 <20210709065320.GC8249@tik.uni-stuttgart.de> <CAJCQCtQvak-28B7eUf5zRnAeGK27qZaF-1ZZt=OAHk+2KmfsWQ@mail.gmail.com>
 <20210710065612.GF1548@tik.uni-stuttgart.de>
In-Reply-To: <20210710065612.GF1548@tik.uni-stuttgart.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 10 Jul 2021 16:17:34 -0600
Message-ID: <CAJCQCtQn0=8KiB=2garN8k2NRd1PO3HBnrMNvmqssSfKT2-UXQ@mail.gmail.com>
Subject: Re: cannot use btrfs for nfs server
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 10, 2021 at 12:56 AM Ulli Horlacher
<framstag@rus.uni-stuttgart.de> wrote:

> root@tsmsrvj:# snaprotate -v test 5 /data/fex/spool
> $ btrfs subvolume snapshot -r /data/fex/spool /data/fex/spool/.snapshot/2021-07-10_0849.test
> Create a readonly snapshot of '/data/fex/spool' in '/data/fex/spool/.snapshot/2021-07-10_0849.test'

I think this might be the source of the problem. Nested snapshots are
not a good idea, it causes various kinds of confusion. It's not any
different if you do an LVM snapshot and nest a bind mount of one file
system in another. I have no idea how NFS works but it sounds to me
it's getting confused when finding the same file system inodes
multiple times and that's just what happens with snapshots. Whether
Btrfs or some other snapshotting mechanism.


> We cannot move the snapshots to a different directory. Our workflow
> depends on snaprotate:
>
> http://fex.belwue.de/linuxtools/snaprotate.html

OK does the problem happen if you have no nested snapshots (no nested
subvolumes of any kind) in the NFS export path? If the problem doesn't
happen, then either the tool you've chosen needs to be enhanced so it
will create snapshots somewhere else, which Btrfs supports, or you
need to find another tool that can.

-- 
Chris Murphy
