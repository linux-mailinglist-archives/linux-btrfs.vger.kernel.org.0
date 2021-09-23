Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED4D415B29
	for <lists+linux-btrfs@lfdr.de>; Thu, 23 Sep 2021 11:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240220AbhIWJmS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 23 Sep 2021 05:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240217AbhIWJmR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 23 Sep 2021 05:42:17 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F4C061764
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 02:40:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id b15so23688715lfe.7
        for <linux-btrfs@vger.kernel.org>; Thu, 23 Sep 2021 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NDMW87cPbLzxHI3onFJfyrBURC5EJ/J6Vyu4gXbnVcA=;
        b=mS2vF8b+/Nee2XrHAWQZjgiNAx4il0YSzjGRyFkakmRjR/AI/IkZAn0JRJsPoesdrE
         GK5jWYvnYuu7EZUEc56WkE+b7EpEQ0ka8PmxFvmO0bQZXFcMb7CPSEpYR0d85er72bHE
         eFx/onIDf/O9uIgr6mTdZZhXk8g/2GZYESikMJaSnevp4+nKQtZLCpiDOxUs3qOGjonv
         DrfS5qOe+qs3WSgrjD/2Jmow4O5izUQao4YSoogjQ90VQV8iWY0ZY0InqmHorAb2LaOj
         LRQa3JBB9mukyeK0pqJiutlVPR9CNKnRXdzHPKxWJhDsz7RqXh3x34DUpynnS1VLS6fS
         G29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NDMW87cPbLzxHI3onFJfyrBURC5EJ/J6Vyu4gXbnVcA=;
        b=pgEzo/HzmAqZhp/ZVHVMgnqUYqfHbEEDffYbzIK5ZK0y+FgVmLkX12Rvm+UFQMWzDo
         JkJFoRh1Z5HAPhuP7saJWxOEJ/S7f9RPBCwmeRNsFBIsQa2iVFKP6R0OLy5xBSjBU/HH
         NiI/HFIJuNrIjxfp5SBVY6Sn28xHR2HF0mZkjBcekaxfsNkZhDv99oILCvuPNi/+vXK3
         gAuSgSeViHbgacdVVlyu7Qlk4xKN0YwR25tVEQix56EG4n/Ir0PIhHC872noufk4hfXU
         TCJFNCQpqAtRSMzrz6X7HDz4iVmoUCX8n/LaycAuLBnp5vrSW6s7T8uB7r4o3/l07Y7s
         0Isw==
X-Gm-Message-State: AOAM532hDzmWcM7GeHfx87IbmZakNYWXXSAaVnoDC03dlXkhFdSpElHi
        alZkFhp4OQ0m72C2e/zNpJXkI+rY8B8VB/aSRf8=
X-Google-Smtp-Source: ABdhPJxzjSZjh8v8yQFdGRTS4fxi+EzCh1rsAY/5XhHN0T7d1/p+OBjhz1DlUuIEflgT2rxgD6260bEGQRpBse7ELCo=
X-Received: by 2002:a19:6a16:: with SMTP id u22mr3291057lfu.254.1632390043940;
 Thu, 23 Sep 2021 02:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAGqt0zz9YrxXPCCGVFjcMoVk5T4MekPBNMaPapxZimcFmsb4Ww@mail.gmail.com>
 <e45e799c-b41a-d8c7-e8d8-598d81602369@gmx.com> <CAGqt0zyEx1pyStPVTSnvsZGYKAGEv9yUunv-82Mj6ZED3WNKRA@mail.gmail.com>
 <f6be0b00-4551-037d-2f3e-e0e5913c51d3@cobb.uk.net>
In-Reply-To: <f6be0b00-4551-037d-2f3e-e0e5913c51d3@cobb.uk.net>
From:   Yuxuan Shui <yshuiv7@gmail.com>
Date:   Thu, 23 Sep 2021 10:40:32 +0100
Message-ID: <CAGqt0zxoHue9WnNdrqchfBHG_g6Qif=1DMYcnu051JdVdtnD=Q@mail.gmail.com>
Subject: Re: btrfs receive fails with "failed to clone extents"
To:     Graham Cobb <g.btrfs@cobb.uk.net>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Sep 23, 2021 at 10:27 AM Graham Cobb <g.btrfs@cobb.uk.net> wrote:
>
> On 23/09/2021 02:34, Yuxuan Shui wrote:
> > Hi,
> >
> > On Thu, Sep 23, 2021 at 12:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> >>
> >>
> >>
> >> On 2021/9/23 03:37, Yuxuan Shui wrote:
> >>> Hi,
> >>>
> >>> The problem is as the title states. Relevant logs from `btrfs receive -vvv`:
> >>>
> >>>    mkfile o119493905-1537066-0
> >>>    rename o119493905-1537066-0 ->
> >>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> >>>    utimes shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include
> >>>    clone shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h
> >>> - source=shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> >>> source offset=0 offset=0 length=131072
> >>>    ERROR: failed to clone extents to
> >>> shui/programs/treeusage/target/release/build/zstd-sys-506c8effd111251c/out/include/zstd.h:
> >>> Invalid argument
> >>>
> >>> stat of shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h,
> >>> on the receiving end:
> >>>
> >>>    File: /mnt/backup/home/backup-32/shui/.cargo/registry/src/github.com-1ecc6299db9ec823/zstd-sys-1.6.1+zstd.1.5.0/zstd/lib/zstd.h
> >>>    Size: 145904 Blocks: 288 IO Block: 4096 regular file
> >>>
> >>> Looks to me the range of clone is within the boundary of the source
> >>> file. Not sure why this failed?
> >>
> >> The most common reason is, you have changed the parent subvolume from RO
> >> to RW, and modified the parent subvolume, then converted it back to RO.
> >
> > This is 100% not the case. I created these snapshots as RO right
> > before sending, and definitely haven't
> > changed them to RW ever.
>
> The problem isn't with the snapshots on the sending side, it is with the
> snapshots on the receiving side. Are you certain the snapshot on the
> receiving end has not been touched in any way (in particular, never been
> set to "RW" at any time)?

I can guarantee you that neither ends have ever been set to RW.

>
> Graham



-- 

Regards
Yuxuan Shui
