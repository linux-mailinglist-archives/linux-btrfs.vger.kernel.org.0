Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A36733BFA8A
	for <lists+linux-btrfs@lfdr.de>; Thu,  8 Jul 2021 14:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbhGHMsb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 8 Jul 2021 08:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhGHMsa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 8 Jul 2021 08:48:30 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E2EC061574
        for <linux-btrfs@vger.kernel.org>; Thu,  8 Jul 2021 05:45:48 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id g19so8701087ybe.11
        for <linux-btrfs@vger.kernel.org>; Thu, 08 Jul 2021 05:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HxfFOyvFOR6AzHczBpsc2jeld0Hpkrpt5vLCpMOI85Y=;
        b=VULndT0460vtAY34S1SX4DMJXmE1aVelWghA1c/PAT2cL6N7xwhEtV/bEuio2rtv+O
         blyPPvoUJn7FtCt623JJ34Hhg3NWf8F7yq/+yLNRVG5veo2R+xoTRAq6zTeuQ1OSYAkh
         knvJT32zuSnadT7JKVhSZpBrEd3VMYiwjQCzMpxinRVtkV5CJ1PVZEi5QLfLhdXjc/2S
         rZyUdR1pSnXgr7m4J2Wn+dZ7hD6B60u/IiY8TXYATLin9GzmqCO8Ryb1HxNR8zPYKIun
         zq9mLAso5FkJdvGZs3dcuBflMtZazGn0bta59BCEVNe/dxVsC1jzBO5eD+smBkWQmsbi
         zG7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HxfFOyvFOR6AzHczBpsc2jeld0Hpkrpt5vLCpMOI85Y=;
        b=I0/KusQIIriFvRaeROvSPNMV1gBB8nGXNiwcxGBSUo/+Z65+BYX4zA04h93cqL0pWm
         g8CgvLB2s3VLfsH+EZ7dGnzj82lLbU7ZsBW8uUkQFLvabedZNqY/yrJWyZaGtzccUOSo
         FrrNKz4Whi2w7ZzlFBYDYI86X0PCKj3sC4NNGgKE4dle42igGb+OYY28GE9xFIK5kZVG
         h8uwt/1Bf+pugiF3wyCEJoevAYPRYyhHWFbELdURWThDV6B4zgbPDI7G4ezXga62KX4k
         sA+DMUrXuBWWYkVBGnuvJMm2qWbju8rFPMrrp2fn8x9/7cS9MmlIHQ/pJPvOXb10739L
         C1EA==
X-Gm-Message-State: AOAM533K8PezQC4hCWlCFDxdIcinpKZbNpSHLWRuNJsGd5LJkyG/eXaJ
        3qv1leACMRgEHTsu/hK8/n9KvRfQSqeWrvgwhPg=
X-Google-Smtp-Source: ABdhPJxt+OiBGnaKuE5WNEXotksu+9XHEr1m6Jl+gfnlLsz59iYVyV/D8CTyff3c2c7CIBf0hB717Z87xk662763F3Q=
X-Received: by 2002:a25:258:: with SMTP id 85mr39058805ybc.109.1625748348025;
 Thu, 08 Jul 2021 05:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625043706.git.dsterba@suse.com>
In-Reply-To: <cover.1625043706.git.dsterba@suse.com>
From:   Neal Gompa <ngompa13@gmail.com>
Date:   Thu, 8 Jul 2021 08:45:12 -0400
Message-ID: <CAEg-Je_N8_rSfVjRD_R1J+ecH1tDW9syZawQavKXRBXQUofjag@mail.gmail.com>
Subject: Re: [PATCH 0/6] Remove highmem allocations, kmap/kunmap
To:     David Sterba <dsterba@suse.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jul 8, 2021 at 7:48 AM David Sterba <dsterba@suse.com> wrote:
>
> The highmem was maybe was a good idea long time ago but with 64bit
> architectures everywhere I don't think we need to take it into account.
> This does not mean this 32bit won't work, just that it won't try to use
> temporary pages in highmem for compression and raid56. The key word is
> temporary. Combining a very fast device (like hundreds of megabytes
> throughput) and 32bit machine with reasonable memory (for 32bit, like
> 8G), it could become a problem once low memory is scarce.
>
> David Sterba (6):
>   btrfs: drop from __GFP_HIGHMEM all allocations
>   btrfs: compression: drop kmap/kunmap from lzo
>   btrfs: compression: drop kmap/kunmap from zlib
>   btrfs: compression: drop kmap/kunmap from zstd
>   btrfs: compression: drop kmap/kunmap from generic helpers
>   btrfs: check-integrity: drop kmap/kunmap for block pages
>
>  fs/btrfs/check-integrity.c | 11 +++-------
>  fs/btrfs/compression.c     |  6 ++----
>  fs/btrfs/inode.c           |  3 +--
>  fs/btrfs/lzo.c             | 42 +++++++++++---------------------------
>  fs/btrfs/raid56.c          | 10 ++++-----
>  fs/btrfs/zlib.c            | 42 +++++++++++++-------------------------
>  fs/btrfs/zstd.c            | 33 +++++++++++-------------------
>  7 files changed, 49 insertions(+), 98 deletions(-)
>

I'd be concerned about the impact of this on SBC devices. All Fedora
ARM images have zstd compression applied to them, and it would suck if
we had a performance regression here because of this.


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
