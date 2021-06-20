Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37D113AE0E2
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Jun 2021 00:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhFTWVf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Jun 2021 18:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhFTWVf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Jun 2021 18:21:35 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57148C061574
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 15:19:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id t11-20020a1cc30b0000b02901cec841b6a0so8228580wmf.0
        for <linux-btrfs@vger.kernel.org>; Sun, 20 Jun 2021 15:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=85SpPiJHqHnC6H35X7ZUY6yxJKGGnREiCTWlQM0mDGQ=;
        b=TJyjy6nFizQV/ZhCuCsOOeR7MB0rk9KCl0vsBkP1NSpHe1eZ4H2AGMR/p1B5BPDGNj
         6z0IJRl7XhQOvsZSZadKC/PrTujsTm9sVTAkIPreqQoUHxndxT6t6l8PCaht5r+0+he1
         cinNqE4vP/KSuD1aFHYD5UB94EWEDBwciVXndelDdpCb4tPO6xfVia1It94Mk0uie+4Z
         By5F/a/61mO6x7MZD5+QPCZNlyO8vpnuCbTSeZC+ySbTd2OGq8/ezOq30DhOt6yINnJQ
         Zcrgdkw6PVVfmg5Wzq75wYKrFYjQBNBaw39RGPslRJlU3EjTI8Vfi7X8ddNXjNOTmf4C
         I53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=85SpPiJHqHnC6H35X7ZUY6yxJKGGnREiCTWlQM0mDGQ=;
        b=gO0/47TROwqOjGk6/OUf7mBGgDEnFrfi3kdpAj+9zbdz0qmsb1j5N3Em2n7KDCdDpZ
         Z8dM41EHqW0K8DtpfHN4ouX+sNzUd0LVMrRRpZgbWYh/SMEwTGKHVCS/4ri7y4vzUoE5
         65y8RbPpvw1kuYLJ1P3Ywj8BVmDcr4s5q1PDE4zu7ZiDieLkUrotsyrolimFyFUyvF7X
         0RjCN2hSO6ZRD8GXxw5GNPqcnDPR831jRgwQ7y/+lWgpL/INL+pr3/qLRvQSkAXz3i56
         KellIBqiYzK8H1gpTXB7GX5IW1uLtlo6iqoXw+p0YxemZ48RoVFn6BkViBb8QFARiHOD
         U+1g==
X-Gm-Message-State: AOAM530VyzPnGUn54TG+Gd8Inxhn02DoZ5Ud7Xykvs7zuL9urtvKdEqP
        CWqXymENDrg5YSUe9AxdaxBuuwhZg4o6hkz9GdK65A==
X-Google-Smtp-Source: ABdhPJxfs3GQXLzdRhftWhtNOZ8VrH3GlEbJJzYKrs4e3+gbcOgcxG6KsYLERk4M1bMYrbNgVTLehfm0ZXdvucLuZCU=
X-Received: by 2002:a7b:c30f:: with SMTP id k15mr23935216wmj.128.1624227559991;
 Sun, 20 Jun 2021 15:19:19 -0700 (PDT)
MIME-Version: 1.0
References: <CAEEhgEss-SusbDdw1qz-7hB3SbQyWhkYNkVLHdQuE+NhMXe27A@mail.gmail.com>
 <CAJCQCtQVqPbwnQXjEECxO-YQVp5XV3cLip8izbTVUkPtOL7P2g@mail.gmail.com> <CAEEhgEv1D9XBCazAn+h1ZfPqGct9PcLpTTn0vtUNh9Yny3XAAg@mail.gmail.com>
In-Reply-To: <CAEEhgEv1D9XBCazAn+h1ZfPqGct9PcLpTTn0vtUNh9Yny3XAAg@mail.gmail.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sun, 20 Jun 2021 16:19:03 -0600
Message-ID: <CAJCQCtRixJ-vkekWTJKt16BwkzRVn1HBjUHouX3adcgirhdk5Q@mail.gmail.com>
Subject: Re: Recover from "couldn't read tree root"?
To:     Nathan Dehnel <ncdehnel@gmail.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The two Intel MEMPEK1W016GA's are in raid10, but you aren't really
protected unless the drive reports a discrete read error. Only in that
case would the md driver know to use the mirror copy. While it
certainly should sooner report a read error than return zeros or
garbage, this is the situation we're in with SSDs. Is that what's
happening? *shrug* Needs more investigation. But it's at either the
bcache or mdadm level, near as I can tell.

Was there a crash or power failure while using this array by any chance?


Chris Murphy
