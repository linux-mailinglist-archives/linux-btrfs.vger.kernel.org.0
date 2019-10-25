Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A73E47D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 25 Oct 2019 11:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408896AbfJYJu7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 25 Oct 2019 05:50:59 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:35843 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390193AbfJYJu7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 25 Oct 2019 05:50:59 -0400
Received: by mail-wm1-f48.google.com with SMTP id c22so1350311wmd.1
        for <linux-btrfs@vger.kernel.org>; Fri, 25 Oct 2019 02:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=PibrJScj46OUNj6Sq4t/MKzar8zubsoXKfGnENX/yHM=;
        b=xXUA3bAtcGuSo6icSWwKa8Vkv/qBalaq5BOaLz0LFW50VRU4bo3lBoeJYY74cxYDGA
         1ipPPX14x0ansbmG2d+O2ByDT3iyF1OfLYGGTxgxod5S+Sh8Uoilp+qIZWVkXiDd9P/h
         UZdFl5mHVLCKYodZGxO3rwpsSPIYFqZtUcLvRmI+7Y44uS0SFOC/18hNK7zhrGGCXCNy
         b1xCuCMEBySJRtxgVHQ4HN3yMVAWuT9Fp6yOJ+hWeQ0O9NZm7s6Rbdqtczu+JYEqzwPl
         yFGsYhJ98Wg1+eP6i5p92zdDgCZCa6YRIakks8zbDvzoA13NWpp3sHEiAbS/CJ34QnSw
         Xl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=PibrJScj46OUNj6Sq4t/MKzar8zubsoXKfGnENX/yHM=;
        b=Dt08dL1AWmqq12Uw19Kr3nxRsA8RxyNhv07HUiXOF2BsCAGa9EHzerLfVarj89wYZO
         Up7/n8RkzauEaVbOf+lPIEynuuy1lS48PWR0uhB+tRV7e9r7RDnb4cXTZwDJLrybwf3I
         pNnbuhYVBRSza3UReEQfYvNFnjc766t595pJKDDcPApA/tbIpOmAnL/pLCEjOuPGzrZB
         7m4+Ka0zPoMMDTHeccREpI06B6obV/O6G3m8Ik+fVMF6fWAPftRvn9T5wPmrKDkd1cP8
         0m8+jsYbvU8w1UR/LhEq/j/mfm320113082/UaTq0yiwNomeJCuqPCfPkvtjy5KeBnSd
         llWw==
X-Gm-Message-State: APjAAAWN2uXDD9WFnREmEBqIYx7NdNr5rv3Rg7V8lmQqZ9H6LtjTobih
        o6CQLPKb9M9fS/DLcvByuYwVl7hZomomStDVKrB6SEewrJTbB0ck
X-Google-Smtp-Source: APXvYqxIG7K+LOijuFHH9HXnbLMhyBEl4S9dp2ixWR4fQbOH0Ahh18Kuav7lVoZqAc1Rz4p9Iey3obRkPPP8K1WlAXs=
X-Received: by 2002:a7b:c94f:: with SMTP id i15mr2761163wml.8.1571997057085;
 Fri, 25 Oct 2019 02:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
In-Reply-To: <CAJCQCtS1v7waFA=ERafSCSCHmPJVytdFZkJLqNTC3U3Gw3Y7tA@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 25 Oct 2019 11:50:36 +0200
Message-ID: <CAJCQCtTWF2e6Q1MNLDVkmq62N6zv8n-BGEvT1c9vzK=TtN93FA@mail.gmail.com>
Subject: Re: Does GRUB btrfs support log tree?
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Oct 25, 2019 at 11:47 AM Chris Murphy <lists@colorremedies.com> wrote:
>
> I see references to root and chunk trees, but not the log tree.
>
> If boot related files: kernel, initramfs, bootloader configuration
> files, are stored on Btrfs; and if they are changed in such a way as
> to rely on the log tree; and then there's a crash; what's the worse
> case scenario effect?
>
> At first glance, if the bootloader doesn't support log tree, it would
> have a stale view of the file system. Since log tree writes means a
> full file system update hasn't happened, the old file system state
> hasn't been dereferenced, so even in an SSD + discard case, the system
> should still be bootable. And at that point Btrfs kernel code does log
> replay, and catches the system up, and the next update will boot the
> new state.
>
> Correct?

Pretty sure this is the current and self-contained Btrfs code for GRUB
http://git.savannah.gnu.org/cgit/grub.git/tree/grub-core/fs/btrfs.c

-- 
Chris Murphy
