Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2A524A1A9
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Aug 2020 16:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgHSOXk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Aug 2020 10:23:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgHSOXk (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Aug 2020 10:23:40 -0400
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91B9D2076E
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597847019;
        bh=5jGyDVhR6Uy3jz1A1Vjqr0pVOnKW9xg/tnhp/uEGWkE=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=SNdMxqsh65uhuCV6SmjSuv7v1ayDNmXCLkN3stWfV1gN9mtjy66NSGM5PCeW9DPS/
         nsosHL1wIUknwOfncIqRGQhO///MKgA1iTqh1FciYlxB8XeNInbAIfTgLwS9mpmwJX
         e1ZDP86hvNS53JTkHEcE6gdeTHas2Z1mWSK3XXzM=
Received: by mail-vs1-f41.google.com with SMTP id o184so12021467vsc.0
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Aug 2020 07:23:39 -0700 (PDT)
X-Gm-Message-State: AOAM5314WrC06ACVu5HJYimgJQU3VDdfYpZIV+iQs02l9EtYON7FwrS0
        c4AH4pddTpdXBZT0zRX1Ngy6dhNFjjLAtsuyD1g=
X-Google-Smtp-Source: ABdhPJxyZOalaGwcdJb5if50LZEtRRONxrAWVaUWNAm69ZkMjjcU1pe2KfFHsAuFZen+C8alRAc7C9ZhUFq1CmR4R1g=
X-Received: by 2002:a05:6102:22f9:: with SMTP id b25mr9420543vsh.90.1597847018738;
 Wed, 19 Aug 2020 07:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200811114328.688282-1-fdmanana@kernel.org> <20200819140803.GM2026@twin.jikos.cz>
In-Reply-To: <20200819140803.GM2026@twin.jikos.cz>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 19 Aug 2020 15:23:27 +0100
X-Gmail-Original-Message-ID: <CAL3q7H7RHp095a7Fsw_Nn-8r_joWOAsqPp=EUObun5dv0mA6Aw@mail.gmail.com>
Message-ID: <CAL3q7H7RHp095a7Fsw_Nn-8r_joWOAsqPp=EUObun5dv0mA6Aw@mail.gmail.com>
Subject: Re: [PATCH 0/3] btrfs: a few performance improvements for fsync and rename/link
To:     dsterba@suse.cz, Filipe Manana <fdmanana@kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Aug 19, 2020 at 3:09 PM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Aug 11, 2020 at 12:43:28PM +0100, fdmanana@kernel.org wrote:
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > A small group of changes to improve performance of fsync, rename and link operations.
>
> Thank you very much!
>
> > They are farily independent, but patch 3 needs to be applied before patch 2, the
> > order can be changed if needed.
> > Details and performance tests are mentioned in the change log of each patch.
>
> A lot of two-digit improvements in throughput and runtime, that's great.

Btw, could you fold the following into patch 3?

https://pastebin.com/raw/hmmmnzJY

It just silences a warning that one of the kernel test robots reported
last sunday:

https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/thread/CRTG5J2M2D7Q7M5GPHXKHOKGKN3GSVWJ/

It doesn't change anything in terms of behaviour.

Thanks.
