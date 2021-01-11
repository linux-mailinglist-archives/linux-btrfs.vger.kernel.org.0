Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82422F0F2C
	for <lists+linux-btrfs@lfdr.de>; Mon, 11 Jan 2021 10:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbhAKJdC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 11 Jan 2021 04:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbhAKJdC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 11 Jan 2021 04:33:02 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A91C061786
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 01:32:21 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id x15so17734674ilq.1
        for <linux-btrfs@vger.kernel.org>; Mon, 11 Jan 2021 01:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ceremcem-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/c/5dDfFiOTVWqcRCQJ+HPISkYvwb8dwNJBYWbtKUeQ=;
        b=lCHB8nawDcl0NCoI9rD4uCAagGPx9xKHh5exUVnHRbhJ3ilG5tunOnqJzMTM8f4H6R
         KV238lcKBCqso7N3jEWY3o2R6twuHx2oMhLuNIPOpAPEcvyMQXuwV8aYmNXRTz4GQS+l
         uo9Vlc5P6/7OEF7SPhvw7YDHfVEubKjte+0MUibO6PF8XrcyFpkseCYY7pQoKKkJ0xuE
         k/pZVyAaSchRDBYFJhiC74++Hg4I1OD+jPnzBwYYFSWjoL/vtX3coxOOAJsDVnItxSWK
         y0TTkvfBuK6K7KzeC1YCfkmn18RrADl4z1qc0wKzVmnBvlqfLgnoG+SdThfSpELH3j5p
         iksg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/c/5dDfFiOTVWqcRCQJ+HPISkYvwb8dwNJBYWbtKUeQ=;
        b=hW2pglc+DQdNMsBxqCkHN2zt0jYyOKNYNTz2gb585D6+PIf2yk5oAs4cd90LqFHP9V
         z+HAsrGjalva3PhyfnGq9e8/eTvgenFkr4Y9wCo/eofL1xHnFs7yqGvqc3TYUTrMszEy
         4tCG+YbT5ewRQDDfN05GjJCYF4HKb3HpuiLW9Y/ehDOMB40EHVk+btdLJ39YSTrnmgDZ
         jyMlAVfVrpkUkt/rGGJYTTVsOvwHFcMa58EHyhFRKNFaQijd/r05uy9d14H+cnxdgsWu
         F+0aLzNAS36LC8bHoGjL0vVcq/surZqI/lc+mMQ6GJUW3U6WcVDjdzMsI810HAhjfwAE
         52RQ==
X-Gm-Message-State: AOAM530gGLNFzyzYo4dBg2dnS32Fz3r95q7f6n/T1XzzAfAoOWupVykU
        7lT68CkqUPPbnj6uZBimVvx9mi2dtDI9oqwiCdzfVNs0V9sYzn5/vS4=
X-Google-Smtp-Source: ABdhPJyQtUYiY2+kN62aB62sHTvgDsEAT18+yZnQET2vh+n+xrghnOwJ4mUHZ3z79wWpfzkYPgguedAdvYOeXwMTJwE=
X-Received: by 2002:a92:9e57:: with SMTP id q84mr4983726ili.112.1610357541177;
 Mon, 11 Jan 2021 01:32:21 -0800 (PST)
MIME-Version: 1.0
References: <dc1e528567c9a57d089d77824f071af8@mail.eclipso.de>
 <cd3a4a0a-e0b4-3224-f00c-5ec52c6362e3@tnonline.net> <cc104d7c-b993-941c-2851-9366a1d87902@cobb.uk.net>
 <CAN4oSBcL7ae_qwKDDoP=sbjkR4gcweTO8otEQv1Zh0YhStWZsw@mail.gmail.com> <b9662cf1-e45f-5113-5b23-bf1aaa73cb97@tnonline.net>
In-Reply-To: <b9662cf1-e45f-5113-5b23-bf1aaa73cb97@tnonline.net>
From:   Cerem Cem ASLAN <ceremcem@ceremcem.net>
Date:   Mon, 11 Jan 2021 12:32:10 +0300
Message-ID: <CAN4oSBe4UR1BA_QpPoAWor0p7ijBNAZqWEgSy13oaRKc-t5MPg@mail.gmail.com>
Subject: Re: synchronize btrfs snapshots over a unreliable, slow connection
To:     Forza <forza@tnonline.net>
Cc:     Graham Cobb <g.btrfs@cobb.uk.net>, Cedric.dewijs@eclipso.eu,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

> You can use `btrbk diff old-snap new-snap` to list changes between
> snapshots.
>

The problem with 'btrbk diff' approach (as stated here [1]) is that it
can not show changes for empty files, empty folders and deletions,
because it also uses 'btrfs find_new' under the hood (see [2]).

However, I found this[3] tool at the time of writing this reply, which
works great and idea behind it (parsing 'btrfs send --no-data' output)
is rock solid.

[1]: https://serverfault.com/a/580264/261445
[2]: https://github.com/digint/btrbk/blob/7dc827bdc3c23fb839540ff1e41f1186fe5ffa19/btrbk#L5692
[3]: https://github.com/sysnux/btrfs-snapshots-diff
