Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F19372B10
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 May 2021 15:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhEDNdO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 May 2021 09:33:14 -0400
Received: from eu-shark1.inbox.eu ([195.216.236.81]:38924 "EHLO
        eu-shark1.inbox.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbhEDNdO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 May 2021 09:33:14 -0400
Received: from eu-shark1.inbox.eu (localhost [127.0.0.1])
        by eu-shark1-out.inbox.eu (Postfix) with ESMTP id C25AB6C006DB;
        Tue,  4 May 2021 16:32:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=inbox.eu; s=20140211;
        t=1620135137; bh=uMZMflypWV2F0c6oVmPdWt0RtvMKqvGxjDF9lQYlBDM=;
        h=References:From:To:Cc:Subject:Date:In-reply-to;
        b=nzAkrgMe4DAYIHfsdGC+ASuU4p1osHvQsLYUbwZ+ED3ozaw5XCoH4euPRPrX1/sAn
         QIwSsWEguVu4Of8Y+rv99j8+tAN9+FH6Fw9EJd1ge3FTUhyNP2GfbXxwoG/COJJWNx
         AQLOn9htSiN3BYae85T/1KtN8jVzs/0ugGkcCaeQ=
Received: from localhost (localhost [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id B370B6C00678;
        Tue,  4 May 2021 16:32:17 +0300 (EEST)
Received: from eu-shark1.inbox.eu ([127.0.0.1])
        by localhost (eu-shark1.inbox.eu [127.0.0.1]) (spamfilter, port 35)
        with ESMTP id I5lmk5P-Cfx6; Tue,  4 May 2021 16:32:16 +0300 (EEST)
Received: from mail.inbox.eu (eu-pop1 [127.0.0.1])
        by eu-shark1-in.inbox.eu (Postfix) with ESMTP id C7F3C6C00663;
        Tue,  4 May 2021 16:32:16 +0300 (EEST)
Received: from nas (unknown [45.87.95.45])
        (Authenticated sender: l@damenly.su)
        by mail.inbox.eu (Postfix) with ESMTPA id 3F9401BE186F;
        Tue,  4 May 2021 16:32:14 +0300 (EEST)
References: <20210504062525.152540-1-wqu@suse.com>
User-agent: mu4e 1.5.8; emacs 27.2
From:   Su Yue <l@damenly.su>
To:     Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 0/4] btrfs-progs: check: add the ability to detect and
 report mixed inline and regular data extents
Date:   Tue, 04 May 2021 21:30:55 +0800
In-reply-to: <20210504062525.152540-1-wqu@suse.com>
Message-ID: <8s4upque.fsf@damenly.su>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Virus-Scanned: OK
X-ESPOL: 6N1mlpY9aTPe6kLDN3bfAwY2rSJKXenj557a3RlcgnP9LyeBYEwITGPJkCwpDWA=
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Tue 04 May 2021 at 14:25, Qu Wenruo <wqu@suse.com> wrote:

> Btrfs check original mode can't detect mixed inline and regular 
> data
> extents at all, while lowmem mode reports the problem as hole 
> gap, not
> to the point.
>
> This patchset will add the ability to detect such problem, with 
> a test
> image dumped from subpage branch (with the inline extent disable 
> patch
> reverted).
>
> The patchset is here to detect such problem exposed during 
> subpage
> development, while also acts as the final safenet to catch such 
> mixed
> types bug.
>
> Qu Wenruo (4):
>   btrfs-progs: check/original: add the "0x" prefix for hex error 
>   number
>   btrfs-progs: check/original: detect and report mixed inline 
>   and
>     regular data extents
>   btrfs-progs: check/lowmem: detect and report mixed inline and 
>   regular
>     extents properly
>   btrfs-progs: fsck-tests: add test image for mixed inline and 
>   regular
>     data extents
>
For the series,
Reviewed-by: Su Yue <l@damenly.su>

--
Su
>  check/main.c                                  |   7 +++-
>  check/mode-lowmem.c                           |  31 
>  +++++++++++++++---
>  check/mode-original.h                         |   2 ++
>  .../047-mixed-extent-types/default.img.xz     | Bin 0 -> 2112 
>  bytes
>  .../fsck-tests/047-mixed-extent-types/test.sh |  19 +++++++++++
>  5 files changed, 54 insertions(+), 5 deletions(-)
>  create mode 100644 
>  tests/fsck-tests/047-mixed-extent-types/default.img.xz
>  create mode 100755 
>  tests/fsck-tests/047-mixed-extent-types/test.sh

