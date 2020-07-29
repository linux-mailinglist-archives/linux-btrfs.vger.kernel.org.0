Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2325E232724
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Jul 2020 23:49:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgG2VtA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Jul 2020 17:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2Vs7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Jul 2020 17:48:59 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E14C061794
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 14:48:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so19434154wrm.12
        for <linux-btrfs@vger.kernel.org>; Wed, 29 Jul 2020 14:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TUGcdYT7jELeBh5hFTATFO2S/q2U4Y1N3LaONePlylU=;
        b=jAHvluvPasMAv3yEAcO/ag6pDhwmANJTp0Vj3rApJzVQc9FW0dZk18QAPWJAd5JjyY
         mwLCFbDNf4vgOTarO7j0wfGMvJFp9mntxrnfANRGNYixB+JHuVUzY8TnOGSH2D4Lv+Pm
         UNXLlmVt/UEppIERN0gLksa/PJe6n6q71dDNIlROW+nuLevnn0roRnXzNUXA2z14QQ+K
         UD5h0O7wHAHQpQao3Bi/nM17hPBTteHJENuvQLWRb/TOHWaVBltd0ZLNs0IO2IXWAIdh
         zcLRsQQnpY3WjAjlyfEUrisUIoTzvm1Fr+yjInb0WfSpu/v+RVWc9nQ6bkYYGAXz7ZKg
         leUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TUGcdYT7jELeBh5hFTATFO2S/q2U4Y1N3LaONePlylU=;
        b=AOavJ9nWMzw1SEMb1n8GmSw6OdevFtAQyV8jk3NuBJyZhgVotPjE/qKJonRmdstZmN
         Cn/0FwnyA0FURr99gZkujw/E7+wV+O5Qz7zRZypQRJSRwNYl3igHV8P4w79YYZB4NpoF
         xdG/3Z7b8FuEntoiRhIzLdZ/ozo8zRnWeonV0Gd+Pa5JfjeKHcTPfJ0BACgE9TgouQ8m
         i67PG2KGyw03AuPkZ2bXLDkLGwuJqw/Bl3wl2g5jeYWOcNR67mX/BgVnITA+Nq9KKtPb
         z1xLds3gcsKkW87LyGZNVhR9JDkQp44lDNHx18YQFDlEk9j7hQkdmsxYZPvK0wZHvt3W
         bm6A==
X-Gm-Message-State: AOAM5328OaphbI91o1bNzn3BohT7XVyXwqyFeTHqKCZ86gJ4ermuOGYX
        bq9E8Kt/aARYfjoAe+DBs3athN9oNaVZQ7VXLEtItg==
X-Google-Smtp-Source: ABdhPJyD5eHjIC07UQ3vncKTUKnlJa9bv3fNZhyLLtJa+e1BEh6f0IPK2xVWOgiTL3VfEc+AQHPQK8rv7dDnpvYo7WM=
X-Received: by 2002:adf:eb89:: with SMTP id t9mr406375wrn.65.1596059338069;
 Wed, 29 Jul 2020 14:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <d3fced3f-6c2b-5ffa-fd24-b24ec6e7d4be@xmyslivec.cz> <a070c45a-0509-e900-e3f3-98d20267c8c9@cloud.ionos.com>
In-Reply-To: <a070c45a-0509-e900-e3f3-98d20267c8c9@cloud.ionos.com>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 29 Jul 2020 15:48:41 -0600
Message-ID: <CAJCQCtQAHr91wEwvFmh_-UB3Cd3UecSjjy6w7nOeqUktrn4UzQ@mail.gmail.com>
Subject: Re: Linux RAID with btrfs stuck and consume 100 % CPU
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Vojtech Myslivec <vojtech@xmyslivec.cz>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux-RAID <linux-raid@vger.kernel.org>,
        Michal Moravec <michal.moravec@logicworks.cz>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jul 29, 2020 at 3:06 PM Guoqing Jiang
<guoqing.jiang@cloud.ionos.com> wrote:
>
> Hi,
>
> On 7/22/20 10:47 PM, Vojtech Myslivec wrote:
> > 1. What should be the cause of this problem?
>
> Just a quick glance based on the stacks which you attached, I guess it
> could be
> a deadlock issue of raid5 cache super write.
>
> Maybe the commit 8e018c21da3f ("raid5-cache: fix a deadlock in superblock
> write") didn't fix the problem completely.  Cc Song.

That references discards, and it make me relook at mdadm -D which
shows a journal device:

       0     253        2        -      journal   /dev/dm-2

Vojtech, can you confirm this device is an SSD? There are a couple
SSDs that show up in the dmesg if I recall correctly.

What is the default discard hinting for this SSD when it's used as a
journal device for mdadm? And what is the write behavior of the
journal? I'm not familiar with this feature at all, whether it's
treated as a raw block device for the journal or if the journal
resides on a file system. So I get kinda curious what might happen
long term if this is a very busy file system, very busy raid5/6
journal on this SSD, without any discard hints? Is it possible the SSD
runs out of ready-to-write erase blocks, and the firmware has become
super slow doing erasure/garbage collection on demand? And the journal
is now having a hard time flushing?


-- 
Chris Murphy
