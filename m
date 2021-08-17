Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5D13EE4F7
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 Aug 2021 05:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhHQDV7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 Aug 2021 23:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbhHQDV4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 Aug 2021 23:21:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6718C061764
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Aug 2021 20:21:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id g138so12785385wmg.4
        for <linux-btrfs@vger.kernel.org>; Mon, 16 Aug 2021 20:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0lZ4J7SaB4lb3aijoDZQbeEsj9OqvUX5DO55f3uOqIg=;
        b=zsgIophswREAtHehy4SzO6SJdSgX6KSvUJpnOZK4PrDAzn0u0gayuDstlxNNRDMoqP
         ByHyPnROfMNbADOUZ5TXE+N4No1r5bS+XLpX4JNde/FGiKtTQZsbWo1uGQPxs8nJSYAS
         oGL4mhQeLyQF2EtXL94xpU/mxkMJ9P3Za8A/ZzNTlREPkv+JerJ4VzB7f5TzU58gX9Ff
         pEOjtCawnwNKGQlLSGFU94VGG14D8WjKD8OYWSsmqFkABXNiQibyXSrtGj4Vy92YXN80
         MX+mUIqmbtLaFpt/401IBL1U+yMDBy0PuSUUUHFb2Kky/T3os9xvUBg/F4kC8Dp/41q/
         4/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0lZ4J7SaB4lb3aijoDZQbeEsj9OqvUX5DO55f3uOqIg=;
        b=IidR+DAlWT5KAYIZDnDXAPMVcCtwNLYxKknLsqcBbuhJaFY0WOacZc+2AmGyk+CCkW
         /T/k0wg791hQDCf1BNX9sRymP5uS41dhOson7A8Db/1Wie5Vl9bkqwjSqr1M/LU/7OBn
         y5pKqZKifLIvydrF7xff0p/76x1WXxVCvuaM+1Bjy1TLrWAk8pIt++rtv3qMuaCe2aTP
         AC9DorOgku/GB8ElgYJWKt+3INXH+CIoREiY97GjfibpfDhtF140lXzHbi4oDrPpw3ST
         EZIRGgi+IpM/rWZQVrAIUhA+ZXongk1SeeDc2FkZtHzhfYbibZa9UNxO6rMCoiGdnYge
         LTXQ==
X-Gm-Message-State: AOAM5319+iktC0qyVPMlx+i9Qegx3Tep/zfK0+wxsyKP4QYaumF4tbLy
        SAY8eIVf9MHX+E6OZRrXWTed9oqKyETyMl0YaFxcMA==
X-Google-Smtp-Source: ABdhPJwYNpuXL7orgNztNAof9Cv/cJaxiwnJPypOlljPzHjtZx1eMxMv58iRHIyVIzNXTsK8aWZ86N+GsxsqWAFqj+g=
X-Received: by 2002:a1c:2b04:: with SMTP id r4mr1048979wmr.168.1629170481470;
 Mon, 16 Aug 2021 20:21:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQEp1a=sf8hO7zL5PHz-7NLjMv-A2nXGCEkNCos+nVA6Q@mail.gmail.com>
 <PH0PR04MB74160F856BD39F9942E8C51C9BFD9@PH0PR04MB7416.namprd04.prod.outlook.com>
In-Reply-To: <PH0PR04MB74160F856BD39F9942E8C51C9BFD9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Mon, 16 Aug 2021 21:21:05 -0600
Message-ID: <CAJCQCtRrAoNtukFev8-zTHOcEYzTzxtp9ENRLkKPH4_mB882Yw@mail.gmail.com>
Subject: Re: 5.14-0-rc5, splat in block_group_cache_tree_search while __btrfs_unlink_inode
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 16, 2021 at 1:17 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 14/08/2021 06:33, Chris Murphy wrote:
> > I get the following call trace about 0.6s after dnf completes an
> > update which I imagine deletes many files. I'll try to reproduce and
> > get /proc/lock_stat
> >
> > [   95.674507] kernel: BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!
> > [   95.676537] kernel: turning off the locking correctness validator.
> > [   95.676537] kernel: Please attach the output of /proc/lock_stat to
> > the bug report
>
> That can be "fixed" by bumping CONFIG_LOCKDEP_CHAINS_BITS.
> I have it set to 18 here.

Fedora is using CONFIG_LOCKDEP_CHAINS_BITS=16

If the consensus is we should use 18 here, I'll get a PR submitted to
the kernel dev team.

Thanks,

-- 
Chris Murphy
