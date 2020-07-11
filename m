Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB3521C1BD
	for <lists+linux-btrfs@lfdr.de>; Sat, 11 Jul 2020 04:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgGKCEE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jul 2020 22:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGKCEE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jul 2020 22:04:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A817AC08C5DC
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 19:04:03 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z13so7625709wrw.5
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jul 2020 19:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vt0r9TyyAmkc6PSHlLkQtq18GPViUYaKaplOyufiIDQ=;
        b=YfS0ZIGEiiFaWRVZM9Oj2+aAtryO7LQKJGBpg5RW8/yG7VeNHCponsOebklPhC3tyS
         QkGX/kg9kIABGNEWGnNUFTCRq3+iclnp81PER7phrO3SLwbI8I3fJDeCRta9EuD5TU4W
         b4Yg3/JIvWyP3TXxKQtQAYnn50sRC26gpT8G3E8IVFaGytp/FoUQYVU98fiqu4+uMVrE
         THKE2Rryy54/ugGzOz1x0Oc+liE7x6iiJ5p0FU8gjGbmH6LYEp28/FZhxRT2VvJblwNW
         bEJTpKwpha1r3h8t7vhA/qyyaxyDshIyl+4II6jxdcVzBCMDx21rphIkQqBkMvVmc8/X
         H6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vt0r9TyyAmkc6PSHlLkQtq18GPViUYaKaplOyufiIDQ=;
        b=S/VHkvppyU9roDR/ezlKGPUaFd9GVa58vzKkpuIbgtm10wpRHjn2JKPEi0LGKlHTW1
         P6U1TyExJJC8DAw/u7dyqfR04Ktj7jzeNgcMf3GTsvF8hX3Dq1K3UnxDQOw1hH38IvO7
         EGs8VPV2k/VijPrO5y/hL4oz1UgvECMyme2EUcw+ZB1R+ScuLmWQnrxSOE+HPIoDl1Tj
         TilHkr3j34s21SY47HrQhm3yijH2TBsyRKSf6JJD38gsmEEoncAWhNwj3LoGRAu9nyhU
         ka46r6YkzdLJAZETrhz59msCi+kRVqg6NF4qiazl6HYK86GIkjvj8CHDbAEnUeXyvN3D
         BPKw==
X-Gm-Message-State: AOAM533/5w2T1q8D3A9+p/J2WyZq/w13xdxO8xjX0DdLDuHoivZ5vw9N
        Ca4glgtEtsboTejTsc9Lp6UvmPhTRSRCbJHA4PuiAOijjqI=
X-Google-Smtp-Source: ABdhPJyE9MGOBQfLvamJlxcL3FaZUfPtpeJ5LwnvAHnhEAJ2nYHVc4kY1t8/bzBngfpubxk5APafueECQQL3zsEU8kY=
X-Received: by 2002:adf:e38b:: with SMTP id e11mr69275709wrm.65.1594433042348;
 Fri, 10 Jul 2020 19:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtRfXy9YDqZQgYz0_djd78oEMwiYY7Og2x=J=w361FENWg@mail.gmail.com>
In-Reply-To: <CAJCQCtRfXy9YDqZQgYz0_djd78oEMwiYY7Og2x=J=w361FENWg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 10 Jul 2020 20:03:46 -0600
Message-ID: <CAJCQCtTcMOqBKqUjdUaaG_fHNXg1X8-HOCp86BQBL7C8g4rcPw@mail.gmail.com>
Subject: Re: raid0 and different sized devices
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

'btrfs fi us' misreports freespace for raid0 with dissimilar sized devices #269
https://github.com/kdave/btrfs-progs/issues/269

mkfs.btrfs shouldn't always use data profile 'raid0' by default with
multiple devices #270
https://github.com/kdave/btrfs-progs/issues/270

This is sufficiently suboptimal behavior that I went ahead and filed bugs.

--
Chris Murphy
