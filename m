Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87AC39AF6F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 03:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFDBSz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Jun 2021 21:18:55 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13704 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDBSy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Jun 2021 21:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622769432; x=1654305432;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vh9/6Wuj12Htn9LEctEUji7R4lUaq5eqsTwYEqPFMeo=;
  b=EbfRXTEEbIxWO82FsKcXt3cv6U0FT2rLNxrvOG6vRuW0L9xLqqv84N8i
   8cFZpqIzNxFPwi5qZEB07ZvQ2LtOHYwyklLaBkd/+XqvXvXpVU7twM3XF
   FaLWxgbBv62CxYwcV/I0PUcTS11YSlg0toUjy7CUT5O/ghxEBXLtaecn9
   mGqdVqbygFvbyVFVC8EDssTGQ0RlLr3LcaqbhTdHNRuVtbuywc8ruSSq8
   +BUIS4JdZowrUxR4lLmztlhEMuXJVIEEVlMPZZLu6MmmzfleqLKjUf97k
   HFYG22M6Kuv5obGyr1N1T2dEPqGTfEuWzHXijkd3jC58Rbf+iCX16BXpp
   A==;
IronPort-SDR: NEP1NThL3iALf3iP5fzTgDJCkOYb7IVbjTm6f3IZwitZvKn114S9HJZQrx5Y9tzmUOkt02RTIU
 I6VyAkHi1qHK7WDY7XERPxsrxJty5KqwP2ac/kd1gNtHcq9XmgLQZIRhdJC7H9SB+pyrFTmOkS
 s2khGaodcZ1ZhIf5cWfFAX+vuaW/blegt4AQY0hZsv4KIUsg0cpSfImQ30A2VM4M0/ceJGu/C5
 x7yg8vnBrRECyy/kSJFXngsznSeO/J6r7gCfoQrHRLA7nghqazLKMegSwUyqtKqJDdnCBLNTNB
 BZQ=
X-IronPort-AV: E=Sophos;i="5.83,246,1616428800"; 
   d="scan'208";a="274534084"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2021 09:17:11 +0800
IronPort-SDR: OXk6qBKF8+H74L/HJcYzMgwavpNlXgaxpBnmB9SQLkFFEWCyF4qPIfCrqCyXIc1GeKnT9vg4Cz
 krvkH1qlxyQ/w/p2IjRYyvpvPCcMEzneYs2XtTYJpj31Udr4KVijC/ax4f5WSJM76DEBQ5OXxE
 MQ+fAXAM3pZtFP1RyznE5WKnYZlsF6wsEdK7qWP/yNIfXyPZLxhnLEOO74wsjxd7zvSPP/sd3y
 3AJMMTH3Cwf7tWPq4cVUggkv9ezZp2LZVpMPZAthcCF2/pQZe4LO8Z7NmUDqgVTvACZSiTPofa
 2zZ7iHL1TXIRXgsqE7Sj6Fiw
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 17:56:22 -0700
IronPort-SDR: NrTxArL7zx/JFVZTTaKwEGHvoGHBh/HTpZkjVQ4W9I1qbXCzqJXrOVZcmaFxL2n0nIgt7wDqwN
 MEAX0ffTCkbeYox93vH5edRHNqa4q5BddruUXOsp/kbA10TbbOX7wbIos8lYTTiPyT1Tl/jZV+
 lBtTcahjtGvgCml8b85DDvp2Fv91ogvKJuEe0Slgbx8Wbn4S0DVA2j2/i9p8kSoAaGBist5dKi
 A1a9oxDbI6mNW9GiZdRtlC2ZmCppvmcHeqfHUbq62FeywwGmjaKp/hhsUUGrGjAk9D59upEme0
 kLI=
WDCIronportException: Internal
Received: from 1hfg3x2.ad.shared (HELO naota-xeon) ([10.225.56.215])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 18:17:09 -0700
Date:   Fri, 4 Jun 2021 10:17:07 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Btrfs fixes for 5.13-rc5
Message-ID: <20210604011707.l6mvqn5z2yvm4j3z@naota-xeon>
References: <cover.1622728563.git.dsterba@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1622728563.git.dsterba@suse.com>
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Jun 03, 2021 at 04:50:15PM +0200, David Sterba wrote:
> Hi,
> 
> this is a batch from last week, I wanted to give it more testing because
> last pull request introduced a bug, interacting zoned and subpage
> features. Otherwise there are error handling improvements and bug
> fixes. The last commit is from today, adding IRC link to maintainers
> file.
> 
> Please pull, thanks.
> 
> - error handling improvements, caught by error injection
>   - handle errors during checksum deletion
>   - set error on mapping when ordered extent io cannot be finished
>   - inode link count fixup in tree-log
>   - missing return value checks for inode updates in tree-log
>   - abort transaction in rename exchange if adding second reference fails
> 
> - fixes
>   - fix fsync failure after writes to prealloc extents
>   - fix deadlock when cloning inline extents and low on available space
>   - fix compressed writes that cross stripe boundary
>

David,

Could you also add commit "btrfs: zoned: fix zone number to
sector/physical calculation" for pull? Without this commit, on a
device larger than 4 TB, zoned btrfs will overwrite the primary
superblock with the 2nd copy and causes a mount failure after the
first mount/umount.

https://lore.kernel.org/linux-btrfs/20210527062732.2683788-1-naohiro.aota@wdc.com/

Thanks,
