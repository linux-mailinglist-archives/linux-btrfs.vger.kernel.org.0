Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61AB41DC172
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 May 2020 23:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgETVfy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 May 2020 17:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgETVfx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 May 2020 17:35:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EEA6C061A0E
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 14:35:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id l11so4681110wru.0
        for <linux-btrfs@vger.kernel.org>; Wed, 20 May 2020 14:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1z9vOlNSq7QKOD05/VIywgLVc3vkPJz3mB7Fr5uBmE=;
        b=Oc7yd+T+n2orV32cUrbRTC55vJRRlGiYz7pSJ8PP0MAjxVBbQykwCMskkADyMVJ5QY
         bOD6nIRXNtnTf4fLNywVYupGH+TRf+9JCHEZ/yGltAVaeVNEICZQXgpQXzgN3AhMRIu3
         HbZH9S06bQzWtsc77Afz3oQTYOCWpTjfb5wdUOwYL+70KdMkLF3dMlWqO8pebfpKcWtS
         kPe+ZF5o/kn+x7e3GlZIAoaWr/tUnaMENOOz28cLe2puXeq1i75I9HuiA4crIAbHco8M
         1EbqhyhQv4faIrGzmUx4U04nPUh3cvaIRtM1y/fTvV39JpGVGNNPtkwCim6yfZgW5zch
         DDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1z9vOlNSq7QKOD05/VIywgLVc3vkPJz3mB7Fr5uBmE=;
        b=scDU+g9ZNCsWqZqSpLEuO/glsO8YNaleNg7L/bA6rkFJ6z9fdSis9U+7ifsuRIizJx
         yU3btt2hNvFQwYADDrG9uAVndLDD1laWuM/jSh6i37Gajvod4sHVtaxyZDiYdt/Y7TUr
         pv0brX9LuXLk+J5uriCGP1/g6fJfT0vFntqjzRwm7rbw2m6w5NqIOUljPGqr+wg8R7Wm
         pVSwDr+04TsLCxW/feXyb2ffMViiW2T+JShyT+swjdTYvB4j/1XLu3NAuKjvxNRHT+Jq
         S9lZg6UqRk5Ks4aVhPSLX6Q9Wt66zRLebOr1svFXCqEM7GEhiOQxnEsCShlyF5deJVJi
         eCFw==
X-Gm-Message-State: AOAM533hUM2OYp9oHvaPgtcCkxl43kuDh94joquaiQxk2HKCyN2gXLiN
        OHU2JnB9Pd0fcPsdFdvZ9ImUtkRtyxPnoVA4eE9MRKeNiuA=
X-Google-Smtp-Source: ABdhPJw7ehjFbkhYtugm6vUZTGnT82P2yi19v+qmDPxXSZNZ7zWvKr6iblvlqXXkCYA+lJrdXthh21KqtFYlkGJ/j7c=
X-Received: by 2002:a5d:51cb:: with SMTP id n11mr5551658wrv.236.1590010551440;
 Wed, 20 May 2020 14:35:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAGAeKuuvqGsJaZr_JWBYk3uhQoJz+07+Sgo_YVrwL9C_UF=cfA@mail.gmail.com>
 <20200520013255.GD10769@hungrycats.org> <20200520205319.GA26435@latitude>
In-Reply-To: <20200520205319.GA26435@latitude>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 20 May 2020 15:35:35 -0600
Message-ID: <CAJCQCtSU9EyFDodLvpYMF+AU=i=-EFZNJw7h4vWL98vEz1jkvQ@mail.gmail.com>
Subject: Re: I think he's dead, Jim
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     Zygo Blaxell <ce3g8jdj@umail.furryterror.org>,
        Justin Engwer <justin@mautobu.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, May 20, 2020 at 3:02 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
>
> On 2020 Mai 19, Zygo Blaxell wrote:
> >
> > Corollary:  Never use space_cache=v1 with raid5 or raid6 data.
> > space_cache=v1 puts some metadata (free space cache) in data block
> > groups, so it violates the "never use raid5 or raid6 for metadata" rule.
> > space_cache=v2 eliminates this problem by storing the free space tree
> > in metadata block groups.
> >
>
> This should not be a real problem, as the space-cache can be discarded
> and rebuild anytime. Or do I miss something?

The bitmap locations for the free space cache are referred to in the
extent tree. It's not as trivial update or drop the v1 space cache as
it is the v2 which is in its own btree.


-- 
Chris Murphy
