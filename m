Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5970C2EC5E7
	for <lists+linux-btrfs@lfdr.de>; Wed,  6 Jan 2021 22:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbhAFVxS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 6 Jan 2021 16:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbhAFVxS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 6 Jan 2021 16:53:18 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FDFC061757
        for <linux-btrfs@vger.kernel.org>; Wed,  6 Jan 2021 13:52:38 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id z21so3173481pgj.4
        for <linux-btrfs@vger.kernel.org>; Wed, 06 Jan 2021 13:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=vOQDCUw9vNhoJrlRrhNeID8ogk6ArSOSd0B/6yTRUcE=;
        b=mWrACDjiB/bAPM/Jv/VudGhLu/PUi5+IURLBQnJ0N9nMoeNbGA33GNN4nfQn8xsQH9
         ohRIF6Hewf3NCK/Ljr/1Ipr/YaerDxLY7LQmwNTd546ngcVQP0RGXPc7yxmNFlQurG/+
         bg4KkENQalsmnbANqeDSMBrStxiZ+OTHgpkV9PXg7pYKkXrXvt4E8shNtZxxGwdyqt95
         v+NrjvQ8cA0+ebaNG60jQ2dXftAhQX/tsEDqHapFRBDSsmubfYUVhFasmxijmHswsWkd
         spJvHqHUo+KuVdAwm7FNNGFkxu8nUnhKRIUaqY4pSm2PnVfyvcRNVe0CjpIPB5MN4RIK
         C2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=vOQDCUw9vNhoJrlRrhNeID8ogk6ArSOSd0B/6yTRUcE=;
        b=jhJ7UGWabEBYVb6ddjcE0m5gdVvupGtdE4fm1mohbICwWWm3ltw5fbs9a8xaccyGtY
         psXmwYUAUPq06vPIPKf49f24aALq/dsF23Nm2A1NM5BWxko62tEh1vdSTDjgtceTu23n
         iNvmMZ5GaAzSphhziiVK3QF19H0AxUf7gM1xc2P1e1kNmKAgDO9rN7/f5paPd/dLGbLO
         p+aTJqEIpWeyizOJ3HgFtjQuJ8eebNlS8xAYuC559kwywhms0K3Pn+JlKn6KuHPP1smp
         htmMTj1qJFKUq9gtQvg5cvNCOg6IxAv30pZ0C7qttQqgHzoRH1dC/cVC0GcspQK1RGYi
         +2ug==
X-Gm-Message-State: AOAM531NdWnMOEl5JmlSBAhRve95wXbZtZGBqVWN+Og2+SLcdlNJvJIX
        4v7NsxghK7EWcmxXPjyCkMAh3vwFFMV3rqvcj5U=
X-Google-Smtp-Source: ABdhPJzneySULONJ8m6H8ohcuWkZlECt9yXCkLyKM//qWovSplDJMqTXA4vH46lWjVB2mamyrI6cbiuGDU+XzeoC7IM=
X-Received: by 2002:a05:6a00:2384:b029:19a:eed3:7f42 with SMTP id
 f4-20020a056a002384b029019aeed37f42mr5795326pfc.4.1609969957807; Wed, 06 Jan
 2021 13:52:37 -0800 (PST)
MIME-Version: 1.0
References: <CAKxU2N_=1uKoVMh20h=_8SyOnHM=WvfZjfQP3t81yN2QTZS4Xg@mail.gmail.com>
 <20210104144437.GE6430@twin.jikos.cz> <CAKxU2N-Q5mjTS6arE5+-UgTgAZMGhTMDaGUAT-bQwe4BdjKOsg@mail.gmail.com>
 <20210105153312.GM6430@twin.jikos.cz> <CAKxU2N9XkG72T0pUb2iSeATXB-Sh9j+rBpSogfAVH0Zccui_mg@mail.gmail.com>
 <20210106123738.GS6430@twin.jikos.cz>
In-Reply-To: <20210106123738.GS6430@twin.jikos.cz>
From:   Rosen Penev <rosenp@gmail.com>
Date:   Wed, 6 Jan 2021 13:52:26 -0800
Message-ID: <CAKxU2N8yq2OUWcFauiL32o__DW25YJdN7vVCdQWRrEFibHFmCw@mail.gmail.com>
Subject: Re: Question about btrfs and XOR offloading
To:     dsterba@suse.cz, Rosen Penev <rosenp@gmail.com>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jan 6, 2021 at 4:39 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Tue, Jan 05, 2021 at 02:40:28PM -0800, Rosen Penev wrote:
> > > What's the raw speed of the hw offload? Measured on large data so that
> > > the overhead is negligible.
> > I have no idea how to benchmark such a thing. I assume it could be
> > done indirectly.
> > >
> > > It might make sense to add the async support in case the speed is
> > > comparable or better to the CPU, but also to reduce the CPU load.
> > I think the latter is the reason Marvell added hardware support for
> > doing parity calculations.
>
> The support seems to be in NAS boxes and besides xor and raid5/6
> calculations the engine can also do a memcpy offload. This could gain a
> lot of performance and be cheap in terms of code. Full page copies are
> wrapped under copy_page so we'd need to insert the offload code. Similar
> for the raid5/6 calculations.
>
> The MD-RAID already supports offloading so we have code to stea^Wcopy.
> Overall it sounds worth to add the async support to btrfs as it would
> help with the metadata updates too, there's a lot of memcpy/memmove.
That would be lovely. I assume 24 hour btrfs scrubs would become shorter.

Unfortunately I lack the expertise to implement this properly.
