Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEEED40F68A
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Sep 2021 13:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243008AbhIQLL2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Sep 2021 07:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:44914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242876AbhIQLL2 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Sep 2021 07:11:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 098D6611F2
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Sep 2021 11:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631877006;
        bh=VXK94W36acpDvBRY+pxm2wu8islc1pxTculDxJYm+ws=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=sgcjone08OKp4KEJ8oLJtSufc4Rx0Qv1kyTtwDJcrGt5x6ghYz12Zw329OD/udNor
         Tsb/Qt8XlrwZo9/MkIj91MIs+cUVYYhUZbfkRXO67rGoSc5UALTVitiCbj3sPJvO6G
         EWR93J2vAzkY5KFO3nTxbPi6HSGTxtzzsZLp1QVtfqGBQ5xzoKs03AbmxbUwZq/jKE
         CA8cwH4qyseI15eOwrZBdJgq7n1qrioA41lfCND8/mWAmYAotfIEFgFuBh+cziahNo
         chWj+ph185Bd0WBFN0QM9ZLqSBBdSQo49PxVaf7/dnmtSvFMLYz/2uiJwcsymNE1BK
         tH8xUrgzsx1nQ==
Received: by mail-qt1-f174.google.com with SMTP id c19so8360037qte.7
        for <linux-btrfs@vger.kernel.org>; Fri, 17 Sep 2021 04:10:05 -0700 (PDT)
X-Gm-Message-State: AOAM533JA0bszMO10sjqlsIyuOffNV67w4vyNHfF5xFCfB4d2I6bwgnT
        ralDcVunSVoPN5PiFGnXqBhWTetJRRVzCs4Go04=
X-Google-Smtp-Source: ABdhPJw/ji0oXVqdxehuf0ML2Cwos2+k38j+23Rni58iO27UAGblbMV1Zz69V3h10TGFMDuzHGJUcLxRxYLMBL/vhRc=
X-Received: by 2002:ac8:4912:: with SMTP id e18mr9936774qtq.124.1631877005251;
 Fri, 17 Sep 2021 04:10:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631787796.git.fdmanana@suse.com> <03c99e78af748d21af7ff0bb6e915230cf0e3310.1631787796.git.fdmanana@suse.com>
 <20210917105158.GL9286@twin.jikos.cz>
In-Reply-To: <20210917105158.GL9286@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 17 Sep 2021 12:09:29 +0100
X-Gmail-Original-Message-ID: <CAL3q7H75r83Ou=-k0zMtOmb80Zjh-KNQcFBLcc99S2aYSWRyag@mail.gmail.com>
Message-ID: <CAL3q7H75r83Ou=-k0zMtOmb80Zjh-KNQcFBLcc99S2aYSWRyag@mail.gmail.com>
Subject: Re: [PATCH 1/5] btrfs: remove root argument from btrfs_log_inode()
 and its callees
To:     David Sterba <dsterba@suse.cz>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Sep 17, 2021 at 11:52 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Sep 16, 2021 at 11:32:10AM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > The root argument passed to btrfs_log_inode() is unncessary, as it is
> > always the root of the inode we are going to log. This root also gets
> > unnecessarily propagated to several functions called by btrfs_log_inode(),
> > and all of them take the inode as an argument as well. So just remove
> > the root argument from these functions and have them get the root from
> > the inode where needed.
> >
> > This patch is part of a patchset comprised of the following 5 patches:
> >
> >   btrfs: remove root argument from btrfs_log_inode() and its callees
> >   btrfs: remove redundant log root assignment from log_dir_items()
> >   btrfs: factor out the copying loop of dir items from log_dir_items()
> >   btrfs: insert items in batches when logging a directory when possible
> >   btrfs: keep track of the last logged keys when logging a directory
>
> This is a nice description, in all the patches, though I think you could
> make it less tedious for yourself to just reference the patch with
> results or a significant change. Up to you.

It's just copy paste, it doesn't add any significant work for me.
Btw, I see that patch 2/5 is missing in misc-next, was that intentional?
