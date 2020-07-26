Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDBAF22DB08
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Jul 2020 03:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGZBAf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jul 2020 21:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgGZBAf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jul 2020 21:00:35 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147DC08C5C0
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 18:00:34 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so11529806wrw.1
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Jul 2020 18:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZMuxXdCeFXUnvlKH0h/HXrE9RE6o1eoBS3X4iFgQIw=;
        b=oeTp8Is+5hNIYiHGXXG1Qmj09eAL58sp6arDW5vPh6g9K6uVfjX9sH7k4wffZ5Bbyy
         /P12FuEoqHtuXESIe6PcLIwExjvShZSVMuMS490VAhGQFL0OCGnRprkC7/kL2CqeWTcE
         bC48cf5E6YzQbDIX8ybYItvpaepTujCGvn9/nfQewQvfiM5AbKNzrZZr5WmqqR4oamX+
         C+Vu0FsaBAgapdCGJV3LuVW3i1UhHlceGw80Vjhd/M3yCZyp8Z+BFdT0U+j1J9zEThpc
         Oh3yQL3MXatSUITskh07rMVBNdKu+3illzTQkg6TtVGtez1tZYS1h+ACK2qH7WNgFXUF
         etVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZMuxXdCeFXUnvlKH0h/HXrE9RE6o1eoBS3X4iFgQIw=;
        b=lqet0GQbZvbS3e6IufHpEnwU+bpSwjWB6F7XCyHst1Bu5E4bZhVING1PZ8T82jZHd8
         UY88tb0uOWQ8Durs8LM+DB+DqziQe+UaLO2BiNQ4RIPVXbKZ/Wj3c4qsMRzYJTadT/JV
         ta6p6a/mSPqVO7AaF6wc9nxHM8M/n6Z2MD2xvRG+mHK8Ucy/F8aS3DIBnnjCsg7Whm2+
         d2x7R4exc4kWz8Rcc4QjstJcon6NJfjNma79757KRvQsQcMQWiINyersQ6FwhwiuItN6
         N/tz4V9L0tt4r13cHXyvRtPBP7tAe6wKMB2YiaBbjsoXRl2ux4eLI1mTi1L3oi/i0yA4
         zlbQ==
X-Gm-Message-State: AOAM533ImsxreohpQObXB4Z0KH07jAWhLY/y1DvvB9kkYrdGvYYnD2bV
        daBm5zfRAfr1Lef9cnMqCZGtepptVRBpAINZpb3Vl0Br
X-Google-Smtp-Source: ABdhPJws+jWtHaDnLr50b8XsLnmn/Xs44jSMGInZsW/JcNLLJKSnkH5isDDojRkcpNYD0SX95evBU0ttj97fwEAojMg=
X-Received: by 2002:adf:aace:: with SMTP id i14mr14034396wrc.236.1595725233723;
 Sat, 25 Jul 2020 18:00:33 -0700 (PDT)
MIME-Version: 1.0
References: <2523ce77-31a3-ecec-f36d-8d74132eae02@knorrie.org>
 <6b4041a7-cbf7-07b6-0f30-8141d60a7d51@applied-asynchrony.com>
 <4771c445-dcb4-77c4-7cb6-07a52f8025f6@knorrie.org> <d3be20df-2f97-6fa8-7050-7315f7ab27a5@applied-asynchrony.com>
 <b7c807f5-3741-d7ff-be4f-acb7dbbc7bb1@knorrie.org>
In-Reply-To: <b7c807f5-3741-d7ff-be4f-acb7dbbc7bb1@knorrie.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Sat, 25 Jul 2020 19:00:17 -0600
Message-ID: <CAJCQCtQ4wQbEQuGF_JDGqdB+UL+yFDMQdzt7jt1YWHQcU5hMbA@mail.gmail.com>
Subject: Re: Debugging abysmal write performance with 100% cpu kworker/u16:X+flush-btrfs-2
To:     Hans van Kranenburg <hans@knorrie.org>
Cc:     =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Jul 25, 2020 at 3:03 PM Hans van Kranenburg <hans@knorrie.org> wrote:
>
> And yes, all rsync is already running with --whole-file since 2014 to
> reduce the total amount of reflink garbage in this now ~100T pile of
> stuff with >200k subvols.

OK. So I was thinking maybe lock contention on subvols. But that many
subvolumes I'm willing to bet every task has its own.

And you're already ahead of where I'm at anyway. A search for free
extent sounds like free space tree contention. Does this suck any less
if there's no space cache?


-- 
Chris Murphy
