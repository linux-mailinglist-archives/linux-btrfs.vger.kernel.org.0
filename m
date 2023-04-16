Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951056E35B4
	for <lists+linux-btrfs@lfdr.de>; Sun, 16 Apr 2023 09:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjDPHYh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 16 Apr 2023 03:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjDPHYh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 16 Apr 2023 03:24:37 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA38E62
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Apr 2023 00:24:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-505035e3368so3660327a12.0
        for <linux-btrfs@vger.kernel.org>; Sun, 16 Apr 2023 00:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681629871; x=1684221871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=35H+v3zJiNfD+Rxt8L7QjvkGtXPGfY+nM2+jlM43BnY=;
        b=c+EAK+Mb7rZRYCU4mJeSItR9WwKyKYX9GpS6mQR1SlObFsWoGEwIMGqHUB32kPj6F0
         wBuSi8A/g7F6AXcEyyKx9XycqtF+7Xz92eBWQ6p0j7q523x0lQuk8CfKY159mjH3XkWO
         38dtHs0WSWAs+ofe9tOCKVnrEfq91gq3GhP6qu9YxAMk+4U8Unj3el9fYSvN6V6AvRwz
         99LncUYwiFmYav9lUTdtz6F0H1dUN8uVoPrCGralaegC9xgEAs9WeZy+ziRadbtY37qN
         7ydnE5so/Rl70lfxHTsjVgLxYE0JNznftu0hhyuuqMn5K3ud3M4oI3vvbNWPFcdcsJ+n
         s+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681629871; x=1684221871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=35H+v3zJiNfD+Rxt8L7QjvkGtXPGfY+nM2+jlM43BnY=;
        b=icj9sKi7gddz8sZ78iZv4Ne5JJ7PFH29LvX+0T5hfeG9stFivuZ7jBV7SRuucH2SD4
         pAZ7cVLx4bermWaHETDfC7T/rmP8vUE6u4n+Z/AbmJvGQd/d2lPyqPGnmXq9I7fd6954
         FZ+MgL9/HxElFQ2mY0AiOlTfkyrELwUMNWfUukvdJPSfZmKEzuAD/pHM1QHQj6rzerRO
         igWJbJSR7OEX0WF9/Laa9fCZJKjIlWisPkH30X1VeLs05LYN16dXbBvcOuSnC63FURzO
         nWDxpoTaMErXAQTEPG8TcUqCYocJnfwzIIiSUqf5SE1xC8ryNfDYXCchlBnPkcOgH7WS
         EqOw==
X-Gm-Message-State: AAQBX9fR2b8Z3K1QKlxmg59hh9vhn3R3wGCtpvKzc+IjiPLnzqcHGxQw
        roYDTQgTg4s5g1qyayukvDwoFImOCdtGU/KY+OY=
X-Google-Smtp-Source: AKy350Yy3LoaSTSL7MW5puiCovA3PrM5r3h/TtTG+hugaPBvgZne1EQfBSYV6/S3Vm+8OFZnKUhzzECP7eHCWsvJQgY=
X-Received: by 2002:a50:9319:0:b0:502:1d1c:7d37 with SMTP id
 m25-20020a509319000000b005021d1c7d37mr5526532eda.8.1681629870669; Sun, 16 Apr
 2023 00:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAL5DHTGEzg2evkVEQMfcCo+kyq_7XcgGJfjLcH6OaQWrvqMAiQ@mail.gmail.com>
 <182e4a51-53c2-94e5-71c8-3125832dd2ec@gmx.com> <352ecefe-cf65-ce53-dd25-15445e3f484e@gmx.com>
In-Reply-To: <352ecefe-cf65-ce53-dd25-15445e3f484e@gmx.com>
From:   Torstein Eide <torsteine@gmail.com>
Date:   Sun, 16 Apr 2023 09:24:18 +0200
Message-ID: <CAL5DHTEXVvNzTfdxJCYeTSn=yGqZ7Mnk78-Rhfx63cjzJagmdQ@mail.gmail.com>
Subject: Re: scrub/balance a specif LBA range
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

The correct format is then:

`btrfs balance start -v
-ddevid=3D2,convert=3Draid6,drange=3D11454997800..11454997807` (convert
force move, only data on that device)
`btrfs balance start -v -ddevid=3D2,convert=3Draid6,drange=3D11455002752..1=
1455002759`

And so on?

Since I believe one of the ranges is matched with a bad sector on a
different device, can I tell BTRFS to, if failed work on the next
block that is not dual failure?

s=C3=B8n. 16. apr. 2023 kl. 02:23 skrev Qu Wenruo <quwenruo.btrfs@gmx.com>:
>
>
>
> On 2023/4/16 08:16, Qu Wenruo wrote:
> >
> >
> > On 2023/4/16 02:59, Torstein Eide wrote:
> >> Hi
> >> I have a disk with "Pending Sector remap".
> >> That can be view with:
> >>
> >> ``smartctl -l defects  /dev/sdd``
> >>
> >> ````
> >> Pending Defects log (GP Log 0x0c)
> >> Index                LBA    Hours
> >>      0        11454997800        -
> >> ....
> >>      7        11454997807        -
> >>      8        11455002752        -
> >> ....
> >>     15        11455002759        -
> >>     16        11464481352        -
> >> ....
> >>     31        11464486423        -
> >>     32        11480702000        -
> >> ....
> >>      39        11480702007        -
> >> ````
> >>
> >> Can I tell btrfs scrub or balance to move files on these locations?
> >> I was thinking the balance `drange` may work but was unsure of the
> >> correct format.
> >
> > You can use balance to only balance a logical range.
>
> s/logical/physical/
>
> >
> > And it's indeed the drange option.
> >
> > Although you may need to specify the option for both metadata, data and
> > system, or go --full-balance to make sure all chunks are covered.
> >
> > Thanks,
> > Qu
> >
