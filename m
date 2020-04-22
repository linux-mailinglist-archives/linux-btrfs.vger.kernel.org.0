Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDB61B4EC5
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Apr 2020 23:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbgDVVFv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Apr 2020 17:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgDVVFu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Apr 2020 17:05:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E693C03C1A9
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 14:05:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i10so4265512wrv.10
        for <linux-btrfs@vger.kernel.org>; Wed, 22 Apr 2020 14:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y03eZNqKh5E0nzPHQsFJ+IZan55U+YgiZM9G4HnQHBs=;
        b=TyVUbOqhgDGTn2sDOZLp03OZ4J2Sc76cIbhs7way9B2ESDmboF1QvBJGiAopRVf4Va
         qD4UTpJGRx6EPoTxvaZXI8R1TtIsIT3NRhiZPjTbC5sgmSuIwNzn71MW+BeNNZ/29BQf
         jjFIBvXWrtkwukbWMyahw99PNpuh9/Uqey6Nnw4YTdMjq3zQphudiXs8nk0S5X4LKVhb
         9GVcUC7SJRTG+RHGjHcA966oCk0Si+t6bqGfZ7MeYGFjXvkwQqQwl1g4YljEHWVUTioG
         bceyz8c1VbB6o+tQbRERHr/OP3231j/lT3o1r7pHWleYuFDQKkYLeijs33yN1lVqRHLJ
         9eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y03eZNqKh5E0nzPHQsFJ+IZan55U+YgiZM9G4HnQHBs=;
        b=iZ1J0f3+XUNhr00M4djROtofyTuDQ27mshU8NOe6Uh7DfwzmUeSkGM/4eHRj70S47l
         WUP/RnH8Gcrffg0e593aXcU4c6VVH2tV5KiS2Mkt3P0HuVRVq9SZylqOX1+vjaj4VhqG
         NDXvdawc3Vy0mcWASZoiWuA8XWKNT4TDNL0x1gtbAkb+sc0pMRMQhGH4bJtuMkYh944N
         q8jCTwgyc7WfsjBeyK427h4qkU3eYGnJPXl/US3HE4GoZ51J2JPxMARosiQM1fuD23Of
         jEja6oWQA7n5v0U82LUC8Gi1j/eTh1HPEv6yI+dD0vn9i42q09pGi562EVkUDfXa5bhb
         /IQQ==
X-Gm-Message-State: AGi0Pua3/lIeMDiQq09/4QVpeO+Szt2TeJCH0/PiGRRK8DLYT+y80knc
        sXmsnh+XnhMCelC3rVFX8uRXjPqqmudgFeZsV7apJWZG
X-Google-Smtp-Source: APiQypK29nYQZJ/ZcJvrZ7JU+CrpVhUsfVX57df7H7Hz8TK4bGeCObsw+ngIgkvz3NDvddrut+B6VnNuCfmaXbCE/fg=
X-Received: by 2002:a05:6000:1242:: with SMTP id j2mr1033239wrx.274.1587589549090;
 Wed, 22 Apr 2020 14:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200422205209.0e2efd53@nic.cz> <CAJCQCtTDGb1hAAdp1-ph0wzFcfQNyAh-+hNMipdRmK0iTZA8Xw@mail.gmail.com>
 <CAJCQCtTEY347CwHGz3QKaBfxvPg0pTz_CF+OaiZNaCEGcnLfYA@mail.gmail.com> <20200422225851.3d031d88@nic.cz>
In-Reply-To: <20200422225851.3d031d88@nic.cz>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 22 Apr 2020 15:05:33 -0600
Message-ID: <CAJCQCtR1pY-W7Bfj-gMnof_xNWiPn=EoSVxqksm9FdNbuRGB+A@mail.gmail.com>
Subject: Re: when does btrfs create sparse extents?
To:     Marek Behun <marek.behun@nic.cz>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Apr 22, 2020 at 2:58 PM Marek Behun <marek.behun@nic.cz> wrote:
>
> On Wed, 22 Apr 2020 14:44:46 -0600
> Chris Murphy <lists@colorremedies.com> wrote:
>
> > e.g. from a 10m file created with truncate on two Btrfs file systems
> >
> > original holes format (default)
> >
> >     item 6 key (257 EXTENT_DATA 0) itemoff 15768 itemsize 53
> >         generation 7412 type 1 (regular)
> >         extent data disk byte 0 nr 0
> >         extent data offset 0 nr 10485760 ram 10485760
> >         extent compression 0 (none)
> >
> > On a file system with no-holes feature set, this item simply doesn't
> > exist. I think basically it works by inference. Both kinds of files
> > have size in the INODE_ITEM, e.g.
> >
> >     item 4 key (257 INODE_ITEM 0) itemoff 32245 itemsize 160
> >         generation 889509 transid 889509 size 10485760 nbytes 0
> >
> > Sparse extents are explicitly stated in the original format with disk
> > byte 0 in an EXTENT_DATA item; whereas in the newer format, sparse
> > extents exist whenever EXTENT_DATA items don't completely describe the
> > file's size.
>
> Ok this means that U-Boot currently gained support for the original
> sparse extents.
>
> I fear that current u-boot does not handle the new no-holes feature.

I'd advise it should support it, I think it's expected to become the
default. But I don't know the time frame for that.

Also, when the no-holes feature flag is not set, you can be certain
only the original hole type is used. But when no-holes feature is set,
it's possible for both types of holes to exist, because no-holes can
be set after mkfs time by btrfstune.

-- 
Chris Murphy
