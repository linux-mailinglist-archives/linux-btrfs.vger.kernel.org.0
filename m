Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824A34802F0
	for <lists+linux-btrfs@lfdr.de>; Mon, 27 Dec 2021 18:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhL0RrB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Dec 2021 12:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhL0RrA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Dec 2021 12:47:00 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884F4C06173E
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Dec 2021 09:47:00 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g79-20020a9d12d5000000b0058f08f31338so21427187otg.2
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Dec 2021 09:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJkTDRskf+u9aWUMK4xh1cApXrJ04FDelo2zjSRpaOY=;
        b=GAe5njnJ92h/KVedcZ7XKCZ5FeopG5gpt/HHfaGu1HsOrLpafA8SOzzbfyxnf4/2T3
         0/t/65Htj6wny1wRCbtdW5KO99GLxJyH4Rzs7lEZ2xzbVBG+vyxYGUtjPOy66HKY0Y78
         ANFkiPDPZKGuY+Fp62yWhIcpc3o71GD/XRehvYU42sCrYeb6c4zPDsZbEm71eQEbQqDh
         kPTd/ww9zvgEzhyY/RxKf3/la4e2BaX524Kv919754zVu4wjH2wWm/J8bbetaL//gkka
         xMwr9WwtmwKp5ZZRRulIYD/vtwq7RXeT6NL5ExIpJVcqESyipZ0i1kTQXa/KU31o1xCs
         htVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJkTDRskf+u9aWUMK4xh1cApXrJ04FDelo2zjSRpaOY=;
        b=TdT2bewGuXhCRoQ1gZBTMIzgqVl5oLxylrtdM6AnvGbeoYcF8kmkPmbytWu3YETZrn
         ++vQ3NNUBaZ/zpN6MirjlSLaHv/PZu1HiSV/lyNI5Okugv20mrIgACsekebIvvbhI+lz
         EjszGBYO/jfYmRTwwn1jqkHT9/qSQFFrIxPlxRzPHoxlIPvgVF3Zlwcesk9sXCifo8gm
         4Ut70IJMSbg6Bef7hKKRJ+M8QdtdV3ugVMJFL0kRA9k9iTgoMnJGQJg0Vx1nnV/505UM
         e+QEpUDa4mxvl6OBOuew5MaNpEfK3dhnkURfIc48cbTvbQXcG1CbLYFSEOpv4FvJptFr
         jsVg==
X-Gm-Message-State: AOAM533LpnCzUptNWMAfZ9hHXQmgrXmussJy4YVUn63oOpb98Rz4+TFj
        +hRqc+HwXyrxKqHWKkQ6EhqQm1n9HpL5RRYGDEA=
X-Google-Smtp-Source: ABdhPJz4ULEYEUdXkX9tosRljBHNlm8Co+s5nJUp1cqWXvX1NjRKHfrViLsLPzs4Z1kZJn6cTiYDXTmYwRC53uviPK8=
X-Received: by 2002:a9d:61d4:: with SMTP id h20mr12423505otk.202.1640627219941;
 Mon, 27 Dec 2021 09:46:59 -0800 (PST)
MIME-Version: 1.0
References: <CAHQ7scUiLtcTqZOMMY5kbWUBOhGRwKo6J6wYPT5WY+C=cD49nQ@mail.gmail.com>
 <b57cace4-fc85-2a5f-e88b-d056b12a2a0b@opensource.wdc.com> <CAHQ7scWo2hF1r0k5_NG2kfAuy0yMxjrym866cGpxRf2Oc2cbMA@mail.gmail.com>
 <54911068-8a81-4201-bf1f-e8dcd196bb08@opensource.wdc.com>
In-Reply-To: <54911068-8a81-4201-bf1f-e8dcd196bb08@opensource.wdc.com>
From:   Jingyun He <jingyun.ho@gmail.com>
Date:   Tue, 28 Dec 2021 01:46:49 +0800
Message-ID: <CAHQ7scX1dc3LtT5-Ms+AvPwTBkKvi4017_Lnd-N7kBR7PGUvcg@mail.gmail.com>
Subject: Re: seagate hm-smr issue
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-btrfs@vger.kernel.org, Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hello,
Do you have any update on this? or any patch that I can try?

Thanks.

On Mon, Sep 27, 2021 at 8:07 AM Damien Le Moal
<damien.lemoal@opensource.wdc.com> wrote:
>
> On 2021/09/27 8:42, Jingyun He wrote:
> > Hi,
> > You are correct, for a WD/HGST HM-SMR disk, it takes about 15 mins to
> > mount a full disk.
> >
> > But It takes about 2-3 hours for mounting a Seagate HM-SMR disk.
> >
> > Have no idea why Seagate takes so loooooong time.
>
> This is most likely due to a difference in the execution time of report zones
> commands.
>
> In any case, this will be resolved soon as we can cache a full disk zone report
> during the mount operation to avoid this slow per-zone report operation.
>
> >
> > On Mon, Sep 27, 2021 at 7:13 AM Damien Le Moal
> > <damien.lemoal@opensource.wdc.com> wrote:
> >>
> >> On 2021/09/26 22:57, Jingyun He wrote:
> >>> Hello,
> >>> Btrfs works very well on WD/HGST disks, we got some Seagate HM-SMR
> >>> disks recently,  model number is ST14000NM0428,
> >>> mkfs.btrfs works fine, and I can mount it, and push data into disk.
> >>> once we used up the capacity, and umount it. then we are unable to
> >>> re-mount it again.
> >>> The mount process will never end, the process just hangs there.
> >>>
> >>> Anybody can help me with this?
> >>
> >> +Naohiro and Johannes
> >>
> >> This is not a hang. Mount will just take a looooong time due to an inefficiency
> >> in how block groups are checked: a single zone report zone command is issued per
> >> block group, so with a disk almost full, that takes a long time (75000+zones
> >> checked one by one). Naohiro is working on a fix for this.
> >>
> >>>
> >>> Thanks.
> >>>
> >>
> >>
> >> --
> >> Damien Le Moal
> >> Western Digital Research
>
>
> --
> Damien Le Moal
> Western Digital Research
