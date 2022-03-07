Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F39374CEF97
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 03:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiCGCZJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 6 Mar 2022 21:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbiCGCZI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 6 Mar 2022 21:25:08 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615745AA75
        for <linux-btrfs@vger.kernel.org>; Sun,  6 Mar 2022 18:24:15 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id o7-20020a056820040700b003205d5eae6eso15570897oou.5
        for <linux-btrfs@vger.kernel.org>; Sun, 06 Mar 2022 18:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XgdMNRUyMAHPpNsR+C8Oy1b7Savto8iLw98m54PdjMU=;
        b=id+j7BOtC7wyhM1GGq900XEAzHZaXiEog3ASTc7VYWvhvJerVFluufVk918C3B3qnp
         NX6YbF0ZO7bBlCbN9qDmILjvepzU+hVhDwfx7cQz4DxX2QU/Lx27VaCKPq5mk+pL12pX
         ceq9GL2bp/9bC7Sfg5QPpn+DJiw9g4hcd4bZYKpI125tP5Gv7ncDHq5s+rMoXPG1knEt
         xh3mz0n80GuOle6mZNqFfUGp+RWFDzjXet4d++HKDTzM1FXuDvKLNc5OwfEwI0P5M1y4
         J+OxnDcHepK7vcy1s4li7saAXFui1a2RSj77+AKyANbZZY29UcDOQgNOT9+qG/KzLT45
         SX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XgdMNRUyMAHPpNsR+C8Oy1b7Savto8iLw98m54PdjMU=;
        b=5O+Az5U9+L1pPkMKDULPy10lHE5Eqk9viqNNj0RTrrzq6q4tjIBCSK+pATYwfWyDcI
         IR1sqjc/a8Qxg/WhmC5oPxs623AB1aFtDRD03degSS/8ivCD2tLQx1+WB/IM0HvRT1o3
         371fdUOQHz8hIs7HNWLbN11pikAo8JGDzGx6dPnPmxjJRI0AUniHRFuYLrrrAHV9RbiK
         UXcMMEzQBkvx11CnoKElLT1+1G24+k67OiZsHgbE56u4eo6U8ODSTN50eCnumcCzJFdv
         caCICQfEC4pi9D8wlil9jeFvJs+AdKpuEbXwhGad87dFWQZuAQvZYXFZWypgpZbQW0/N
         MT7A==
X-Gm-Message-State: AOAM530EFDs6PrWkHMIanoMEtSHmr5xVTyNs3tdX4d0MYt5CpVXDNxZJ
        8Ns2SIav2I9oZjU29wYf/uLFcPglK7X3SfgGd92GBbQmfjA=
X-Google-Smtp-Source: ABdhPJz+r0mQpzWySCWWJO30VP7QeKS+2RjKEqoF+D2cS1QbUAxY3dw3u2WGk8RPS3yvajVwwMwZSzVTj5A4Yod6u1M=
X-Received: by 2002:a05:6870:1613:b0:da:b3f:2b3c with SMTP id
 b19-20020a056870161300b000da0b3f2b3cmr4976634oae.219.1646619854588; Sun, 06
 Mar 2022 18:24:14 -0800 (PST)
MIME-Version: 1.0
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
In-Reply-To: <455d2012-aeaf-42c5-fadb-a5dc67beff35@gmx.com>
From:   Jan Ziak <0xe2.0x9a.0x9b@gmail.com>
Date:   Mon, 7 Mar 2022 03:23:38 +0100
Message-ID: <CAODFU0q56n3UxNyZJYsw2zK0CQ543Fm7fxD6_4ZSfgqPynFU7g@mail.gmail.com>
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 7, 2022 at 1:48 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> On 2022/3/6 23:59, Jan Ziak wrote:
> > I would like to report that btrfs in Linux kernel 5.16.12 mounted with
> > the autodefrag option wrote 5TB in a single day to a 1TB SSD that is
> > about 50% full.
> >
> > Defragmenting 0.5TB on a drive that is 50% full should write far less than 5TB.
>
> If using defrag ioctl, that's a good and solid expectation.
>
> Autodefrag will mark any file which got smaller writes (<64K) for scan.
> For smaller extents than 64K, they will be re-dirtied for writeback.

The NVMe device has 512-byte sectors, but has another namespace with
4K sectors. Will it help btrfs-autodefrag to reformat the drive to 4K
sectors? I expect that it won't help - I am asking just in case my
expectation is wrong.

> So in theory, if the cleaner is triggered very frequently to do
> autodefrag, it can indeed easily amplify the writes.

According to usr/bin/glances, the sqlite app is writing less than 1 MB
per second to the NVMe device. btrfs's autodefrag write amplification
is from the 1 MB/s to approximately 200 MB/s.

> Are you using commit= mount option? Which would reduce the commit
> interval thus trigger autodefrag more frequently.

I am not using commit= mount option.

> > CPU utilization on an otherwise idle machine is approximately 600% all
> > the time: btrfs-cleaner 100%, kworkers...btrfs 500%.
>
> The problem is why the CPU usage is at 100% for cleaner.
>
> Would you please apply this patch on your kernel?
> https://patchwork.kernel.org/project/linux-btrfs/patch/bf2635d213e0c85251c4cd0391d8fbf274d7d637.1645705266.git.wqu@suse.com/
>
> Then enable the following trace events...

I will try to apply the patch, collect the events and post the
results. First, I will wait for the sqlite file to gain about 1
million extents, which shouldn't take too long.

----

BTW: "compsize file-with-million-extents" finishes in 0.2 seconds
(uses BTRFS_IOC_TREE_SEARCH_V2 ioctl), but "filefrag
file-with-million-extents" doesn't finish even after several minutes
of time (uses FS_IOC_FIEMAP ioctl - manages to perform only about 5
ioctl syscalls per second - and appears to be slowing down as the
value of the "fm_start" ioctl argument grows; e2fsprogs version
1.46.5). It would be nice if filefrag was faster than just a few
ioctls per second.

----

Sincerely
Jan
