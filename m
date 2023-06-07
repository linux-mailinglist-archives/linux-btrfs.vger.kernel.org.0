Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF7072582C
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 10:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbjFGIm6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 04:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239438AbjFGImq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 04:42:46 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047371BD5
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 01:42:38 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-53fbb3a013dso6500235a12.1
        for <linux-btrfs@vger.kernel.org>; Wed, 07 Jun 2023 01:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686127358; x=1688719358;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIt1nDputa1qKAW8W9LfQJnAVJ3EqUPT/y4NrnXRe08=;
        b=jBEZKV2lMo56S0BCDA7oDebgzCiOSzHYIPzKV/nvVHJvSE99KZ5ayoRfVTDBrrspzk
         Xh3MrrGOOOTXDCNSgWs9m6HhlX+bLwXvzisiYNxTEsoTAfS0+QEbFTQeMVxa/9vdRWX0
         oYyuODaMfioMemVIdFrRaJArTpK5eKPo5UgJOAEn92mtj1kCQvZr1oLp/12i+xldtyM0
         S6JX4kgOdHgMjiF4OXwVWtp9X8WaDL8epzWFLzT4vKh0sDPEaQdK5US873ePKih1Cw/+
         3lcCKq3Bcii3zGILwjgpauksU1E/tcWVSUwOmtJ2HM+Y/IR9W5pU2clFNqozCFH/pzpX
         94fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686127358; x=1688719358;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIt1nDputa1qKAW8W9LfQJnAVJ3EqUPT/y4NrnXRe08=;
        b=XVqGftdnyl+mYpRtqyF/6XqdogZp0i5W6gOXLidhgNST8voi/f9YlOw22ih7xZnPuC
         kG8jG2+Lrr/BiJhTG29WBa2fTOD2jvv+CgS1KErzFQ57PSfzDtK0rgNBQuoOv97KUhqz
         ayltheVbYQ6AdDhqZV460Z4kvyoDTtww3JDJb8LbyoMHT0Ia+/dY40CnPp09BB56ieOU
         Ri5WS5G1C/cT/GLEMcxCkpVtdw2yTLqoGq8I/e1T839bQnjlZ+rKXEboUyGOYSaC47lv
         eH6Y3eJ1qjFEusmIF5YrRCAHOlQEeJAmauyndXWAUM7YqGY1PnA9MYkvAF3Ar0Mcq/CI
         ZHhQ==
X-Gm-Message-State: AC+VfDwkLy3Wj8ybN+ZXuLamkoY+8m69rlnw3kOxG24DJ78KfBvsYI/s
        jAQadFr8zGrWoB2OjYz5YXiBvI7XQXmjyK8xb4ws/dfnrHY=
X-Google-Smtp-Source: ACHHUZ6f03AaoceR8sZkOUFn2N7SgxPNVQRMKCjutCz5Ia4i7OwuoflApIR8Fj2RsRH05hynmkvruXb5xEliajmTepk=
X-Received: by 2002:a17:90a:3e09:b0:252:75ed:eff5 with SMTP id
 j9-20020a17090a3e0900b0025275edeff5mr3982689pjc.30.1686127358251; Wed, 07 Jun
 2023 01:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <CALgeF5=8Www=aG8=6XXTYsiD-A=dBdGUN8Drj=h4d92yoZNXHw@mail.gmail.com>
 <cf225ad6-69f4-a339-2e7b-42f094a7b5fb@gmx.com> <CALgeF5ksBx0+0v8yGu3XECPkDZJZB0tBAeHt+1MUAXLEa67QPw@mail.gmail.com>
 <01d99c0f-da3f-0d2a-8437-b065bc610eb3@gmx.com> <CALgeF5kFsrBSfUQS9p2sq0xPHJJYcykfnPAe4TP_XM=zXE65tw@mail.gmail.com>
 <383d593a-c26f-bd5e-022f-4f5bd04b4715@gmx.com>
In-Reply-To: <383d593a-c26f-bd5e-022f-4f5bd04b4715@gmx.com>
From:   Massimiliano Alberti <xanatos78@gmail.com>
Date:   Wed, 7 Jun 2023 10:42:24 +0200
Message-ID: <CALgeF5=xkkSpoW8WqqTtfYszOe-jTiS5Ntxy==MNdm=meLjwgQ@mail.gmail.com>
Subject: Re: parent transid verify failed + Couldn't setup device tree
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Ah yes... It was even written.

[ 1234.138677] BTRFS: device fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
devid 1 transid 9196 /dev/sdb1 scanned by mount (6062)
[ 1244.472400] BTRFS info (device sdb1): using crc32c (crc32c-intel)
checksum algorithm
[ 1244.472420] BTRFS info (device sdb1): enabling all of the rescue options
[ 1244.472422] BTRFS info (device sdb1): ignoring data csums
[ 1244.472423] BTRFS info (device sdb1): ignoring bad roots
[ 1244.472424] BTRFS info (device sdb1): disabling log replay at mount time
[ 1244.472426] BTRFS info (device sdb1): using free space tree
[ 1244.499999] BTRFS error (device sdb1): parent transid verify failed
on logical 4390576160768 mirror 1 wanted 9196 found 3295
[ 1244.500563] BTRFS error (device sdb1): parent transid verify failed
on logical 4390576160768 mirror 2 wanted 9196 found 3295
[ 1244.500589] BTRFS warning (device sdb1): couldn't read tree root
[ 1244.508357] BTRFS error (device sdb1): open_ctree failed

And yes, it gives error.

And even the btrfs restore gives error... So there is no hope for the
data? I have some backups, but as always they are incomplete, not
updated...

Il giorno mer 7 giu 2023 alle ore 10:35 Qu Wenruo
<quwenruo.btrfs@gmx.com> ha scritto:
>
>
>
> On 2023/6/7 16:26, Massimiliano Alberti wrote:
> > The dmesg
> >
> > [  288.076822] BTRFS info (device sdb1): using crc32c (crc32c-intel)
> > checksum algorithm
> > [  288.076844] BTRFS error (device sdb1): unrecognized mount option 'rescux=all'
> > [  288.076975] BTRFS error (device sdb1): open_ctree failed
> > [  345.636207] BTRFS: device fsid 1524cb0d-c1cd-4ba8-9908-7bfe91bc377f
> > devid 1 transid 9196 /dev/sdb1 scanned by mount (5926)
> > [  345.639381] BTRFS info (device sdb1): using crc32c (crc32c-intel)
> > checksum algorithm
> > [  345.639407] BTRFS info (device sdb1): enabling all of the rescue options
> > [  345.639409] BTRFS info (device sdb1): ignoring data csums
> > [  345.639411] BTRFS info (device sdb1): ignoring bad roots
> > [  345.639413] BTRFS info (device sdb1): disabling log replay at mount time
> > [  345.639415] BTRFS error (device sdb1): nologreplay must be used
> > with ro mount option
> > [  345.640184] BTRFS error (device sdb1): open_ctree failed
>
> Forgot you need to go with RO mount option, "-o ro,resuce=all".
>
> But considering the root tree is corrupted, it would help much.
>
> Thanks,
> Qu
>
> >
> > Tried btrfs restore (no hypen):
> >
> > root@ebuntu:~# btrfs restore -D -i /dev/sdb1 /
> > parent transid verify failed on 4390576160768 wanted 9196 found 3295
> > parent transid verify failed on 4390576160768 wanted 9196 found 3295
> > parent transid verify failed on 4390576160768 wanted 9196 found 3295
> > Ignoring transid failure
> > Couldn't setup device tree
> > Could not open root, trying backup super
> > parent transid verify failed on 4390576160768 wanted 9196 found 3295
> > parent transid verify failed on 4390576160768 wanted 9196 found 3295
> > parent transid verify failed on 4390576160768 wanted 9196 found 3295
> > Ignoring transid failure
> > Couldn't setup device tree
> > Could not open root, trying backup super
> > parent transid verify failed on 4390576160768 wanted 9196 found 3295
> > parent transid verify failed on 4390576160768 wanted 9196 found 3295
> > parent transid verify failed on 4390576160768 wanted 9196 found 3295
> > Ignoring transid failure
> > Couldn't setup device tree
> > Could not open root, trying backup super
