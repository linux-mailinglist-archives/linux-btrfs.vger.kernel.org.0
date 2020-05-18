Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3C21D8838
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 May 2020 21:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbgERTaH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 18 May 2020 15:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgERTaG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 18 May 2020 15:30:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFBAC061A0C
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 12:30:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id i15so13151928wrx.10
        for <linux-btrfs@vger.kernel.org>; Mon, 18 May 2020 12:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/DA4XKszBZL8uqrSHNXelJEKJ5PL8CUBPV9V9Tr2UM=;
        b=jP4yQwA1/rrku43ywMrGNjWifGYG3qMmrckp9oafRZZifa4DM9hkHzsA1MGyI5/avB
         CRrhrb06R9hM3kgKAv6bPwYXFotx5pIElywerBWf4aR8fbL5IDxvDsLLv1usoT32rtxs
         eRik0qhTd2J2KXSxZPamPKCUNhf4PKZLNaXxpJ99kRupCfwWuGbTLC0RQOGmpAW0y4zS
         xJ7uuJS5ZLJQbVnKW9IF87XYlc8M0UzCdoPMzza8Sd3nXBA7TLemNZHBMXvS/B4SU07H
         7yLUvPnajhtq89cSIhJ8jZ5c57pd4vg8EaOAFTFbI94jZpusmfwejYvEnB3lE7naq/GA
         CYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/DA4XKszBZL8uqrSHNXelJEKJ5PL8CUBPV9V9Tr2UM=;
        b=mR/7HG02T0DJ0GcKWn79PbaBURC2qA7v6pCPcHbdLbiP2qyVCA7nf3fByHyGsEXv7E
         M4/6d6Bsz0NgVI6FtaRgH7l7qaIbj6/RlPr/ONJgRmtIx3n2q+yVqmBoMja3U65FDtVW
         Qp0NlTC5rbXK8Gme9yPlGInCerI1jaq2w4hN9kUVxO1/dTesZhBWSRgyAR1M5iQjhsQQ
         AZW5CExiI6mhmTsl1qIJ2JO+XPEIfZnfoD0oDFzpt+sQoVxCj3whpSKXDz06of/Qq2Om
         psMmkpUFxA1T2uaB0WFdyYzhnl3x9NCMaoaU8a7C8k6MiaUCFUrw1T1SgxnryVnE0p9k
         onHA==
X-Gm-Message-State: AOAM531IhjciemFdK/QjsVUHw66PmbkSUhXpRyI9RLjC5zyLWjhsgNVd
        cf0N2mk9jBZ82rT1wGWZHRINXVYdHkkNnPCzIsmSBg==
X-Google-Smtp-Source: ABdhPJzeVPrauU51EpnHUPsZiEVr0hApvFjJmab4dbEhwBgO4AetBh/ApdbgODpxOUc40Sllz0gWpQdVcn6ydAlUquM=
X-Received: by 2002:adf:e688:: with SMTP id r8mr21068602wrm.274.1589830205013;
 Mon, 18 May 2020 12:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <1899345116.843043.1589811116462@mail1.libero.it>
In-Reply-To: <1899345116.843043.1589811116462@mail1.libero.it>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 18 May 2020 13:29:49 -0600
Message-ID: <CAJCQCtRBo33PAwW4Ykk=WQ5yMtmcHE84dObowb=K_dfZPZvpzg@mail.gmail.com>
Subject: Re: how to recover unmountable partition (crash while resizing)?
To:     a.mux@inwind.it
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 18, 2020 at 8:12 AM <a.mux@inwind.it> wrote:
>
> Hi,
>
> due to a crash while resizing my / btrfs partition with gparted, my HD was left in a unmountable state.
>
> This is on me: resizing a partition moving it to the right via gparted is a risky operation per se.

"to the right" means you were moving the starting point of the file
system? Was the size changing too?

What is the nature of the crash? Gparted crashed? The whole
environment crashed? Power failure? Is there a dmesg or gparted log?

Do you have a backup of the GPT before the resize? By comparing the
GPT before it was changed, to its current state, and that of the super
block found (or not) at the expected locations for both GPT states, it
might be possible to infer where in the resize things went wrong.

It's important to look at the GPT and *not* repair it if it's damaged.
Any damage to the GPT might preserve useful information about the
prior state.

# gdisk/fdisk -l /dev
# btrfs insp dump-s -a /dev

> I am confident that all my data is still in the HD, and with proper guidance from the tools it will be possible to mount back the fs. The UI of the tools is a bit hard for me to understand.

If this was moving the starting point of the file system, it's
possibly difficult to recover if the crash happened while moving the
partition. This copies the file system in sections - it's basically
broken for the duration of the move and isn't atomic.


-- 
Chris Murphy
