Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2A1126F44
	for <lists+linux-btrfs@lfdr.de>; Thu, 19 Dec 2019 21:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfLSU7h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 19 Dec 2019 15:59:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35413 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfLSU7h (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 19 Dec 2019 15:59:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id p17so7115314wmb.0
        for <linux-btrfs@vger.kernel.org>; Thu, 19 Dec 2019 12:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BvLGthR+BvTpVq6+sCnUS/21zwUAoeCFntA9JvIdhMA=;
        b=Tk6r4oK0NEPX7V04GYP3fa2VgHvXHTJgA6+xIJudVE3SyX0kH7pDWkKAxTXhAhh4fH
         hhhF/+J16feVchJeLkHMDt6RN9IvSm4cZ6z3bBhSM6Uvj0UrU/V2p/SaCchscHRZZ2DV
         mwTWICkojicr4FnOKr/gg0K9qc7ubbLxfxZt/0fGY8UJowYl2k+TrSEyVBDKKvMeCOqJ
         FWOVh3/balLIJNb93dbWuDmWMq0M1IuWDJ3t+Se9A7mqo9ykafAT8gSxJ4nxQHq5qcqu
         KVzwFym6xPhAKXI6PBPJBFI8XCWfLLSg/OZLqpkmxrhoYp/kyCeFKHqv02BG6euzekM8
         sgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BvLGthR+BvTpVq6+sCnUS/21zwUAoeCFntA9JvIdhMA=;
        b=ZERlnB9REgir7L6A+AHOoLy8iTmPvgwopzMltuEqwpM411JI7Z1HB7sR2Q77cNEANz
         LjiECNjBkoTVG7FJZ1MKdivW0agXCUTkTx3lq5dOevV0otiU9Kexkjxq/ojHZMrFiYlW
         cy3SbKpGqAVrnzuyf9QlXBPKKSAYSle71iNBGXyq8DFcXwtk8mM7ycMNUxKdPVUTvd2n
         zqO3mNlnG/DNqzMp52E2h6xqkBG83vCO4dRJcBSNPH03r/Eqak394/jxBKMgS0ZYvWng
         fmI52pO/CmI0rH9RjGNjiME6WfG7zjoIKOiv8HwVV6Bb2Mi7bLQtc6gPGSyUnfzoHkyo
         nsEQ==
X-Gm-Message-State: APjAAAXkJBZFkRQmPXVk8gVzEPgXDB6QVwnKs02/q/McsVvXo29YsML8
        FqReqk2c7njohLfY5Lz6Kqbmvf8nrxPUSGtmYxVPnQ==
X-Google-Smtp-Source: APXvYqz7ZZ6tVvjqQnQ/DTm3yVBw7qDQ8gsZYihWo7u02eL9am+15lVd8o2CoaBEmvKfA0BMazjnC8b4kS8pdU8qSaM=
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr12051831wmc.160.1576789175023;
 Thu, 19 Dec 2019 12:59:35 -0800 (PST)
MIME-Version: 1.0
References: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
In-Reply-To: <C439384E8BF26546BDDE396FFA246D1001921619EB@NWXSBS11.networkx.de>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Thu, 19 Dec 2019 13:59:18 -0700
Message-ID: <CAJCQCtRH1otb=-dCjKSPWUb_SEPS4dGP0AQ2_TEN8F6Jx3-+ZQ@mail.gmail.com>
Subject: Re: How to heel this btrfs fi corruption?
To:     Ralf Zerres <Ralf.Zerres@networkx.de>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Dec 19, 2019 at 1:07 PM Ralf Zerres <Ralf.Zerres@networkx.de> wrote:
>
> Dear list,
>
> at customer site i can't mount a given btrfs device in rw mode.
> this is production data and i do have a backup and managed to mount the filesystem in ro mode. I did copy out relevant stuff.
> Having said this, if btrfs --repair can't heal the situation, i could reformat the filesystem and start all over.
> But i would prefere to save the time and take the heeling as a proof of "production ready" status of btrfs-progs.
>
> Here are the details:
>
> kernel: 5.2.2 (Ubuntu 18.04.3)

Unfortunate that these versions are still easily obtained. 5.2.0 -
5.2.14 had an pernicious bug. I can't tell if it applies in your case
though.

Btrfs: fix unwritten extent buffers and hangs on future writeback attempts
https://lore.kernel.org/linux-btrfs/20190911145542.1125-1-fdmanana@kernel.org/T/#u

The bug is fixed since 5.2.15.



> btrfs-progs: 5.2.1
> # btrfs check --mode lowmem --progress --repair /dev/<mydev>
> # enabling repair mode
> # WARNING: low-memory mode repair support is only partial
> # Opening filesystem to check...
> # Checking filesystem on /dev/<mydev>
> # UUID: <my UUID>
> # [1/7] checking root items                      (0:00:33 elapsed, 20853512 items checked)
> # Fixed 0 roots.
> # ERROR: extent[1988733435904, 134217728] referencer count mismatch (root: 261, owner: 286, offset: 5905580032) wanted: # 28, have: 34
> # ERROR: fail to allocate new chunk No space left on device
> # Try to exclude all metadata blcoks and extents, it may be slow
> # Delete backref in extent [1988733435904 134217728]07:16 elapsed, 40435 items checked)
> # ERROR: extent[1988733435904, 134217728] referencer count mismatch (root: 261, owner: 286, offset: 5905580032) wanted: 27, have: 34
> # Delete backref in extent [1988733435904 134217728]
> # ERROR: extent[1988733435904, 134217728] referencer count mismatch (root: 261, owner: 286, offset: 5905580032) wanted: 26, have: 34
> # ERROR: commit_root already set when starting transaction
> # ERROR: fail to start transaction: Invalid argument
> # ERROR: extent[2017321811968, 134217728] referencer count mismatch (root: 261, owner: 287, offset: 2281701376) wanted: 3215, have: 3319
> # ERROR: commit_root already set when starting transaction
> # ERROR: fail to start transaction Invalid argument
>
> This ends with a core-dump.

Well it's easy to say a crash is a bug, and I'm also not sure if it's
fixed in btrfs-progs 5.4. But it might help isolate the problem if you
attach dmesg. At least the good news is there's a backup; but creating
a new volume and restoring this much data will be a little tedious.


--
Chris Murphy
