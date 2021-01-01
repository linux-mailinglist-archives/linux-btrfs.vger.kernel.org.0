Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B198F2E8378
	for <lists+linux-btrfs@lfdr.de>; Fri,  1 Jan 2021 11:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbhAAK1y (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 1 Jan 2021 05:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbhAAK1x (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 1 Jan 2021 05:27:53 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFAEC061757
        for <linux-btrfs@vger.kernel.org>; Fri,  1 Jan 2021 02:26:58 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id q1so19148553ilt.6
        for <linux-btrfs@vger.kernel.org>; Fri, 01 Jan 2021 02:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2vQ6iqC4CndNBeiIFLrfo2PMRh+mcqERP0ZLSMI0UU=;
        b=S2e0UyON57vBfV4TYhF3yPrS2nbggdWhKASDKkJyyZhZZrjDkAVKHQZ26oCiBGwSFX
         UDzTX28rWXZcodt0np0keMnUqzYQ17/DQTLTwwfR+nqTnbOIeJKrun6JulieBxrFKNb6
         sijYwADkpBgOOo7LwIp5zStNDZK3l0kIytvlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k2vQ6iqC4CndNBeiIFLrfo2PMRh+mcqERP0ZLSMI0UU=;
        b=Xtvq3cmi+mRqyWjjwKJnJ0BfumOBgUUOYuIl7dz9rpMJVLY3Xv0TRKFUXbFA1w+hfQ
         0BapEbEBhaIEX16gjsa6DALcF4ogJUc+lCXkULStYQjL5f4a7hvu8oDZoT+LxE5gRRgC
         bwIAdeWccSBwk+HKnjJCwITjzn7LdK4DJIFsmW/KZr24Wu0L+tvPYFaZ2TW085uHCoH/
         0tvv38960V0pAW0JVyTbIfdRYYESByndeBr2bPCOkyHxmFLcIQ9oIVdWi4F505F4UeHQ
         akDuEiVlbos4YFvd/P+649b+VbOwb0funhRbD6mMQr1V4uieG71v7JNigTnmLO+UcuDv
         hW8A==
X-Gm-Message-State: AOAM531dyPiyPtALgofxBKBQg40ChcQQ3bTxei+K1n+ffdrWnRGPydSE
        ImxvZ2Ax0hAqU9IeyT6UwBxZaworLVRkU7t9eNG+oA==
X-Google-Smtp-Source: ABdhPJz1USMv6E2KC8ZVmIWBjUJhlS5f9B0ew9hFe2xL6yHufIj3i5Q+DJrMQoaeY+K+o+6kwBrDtzQTcfz8CCZkwqA=
X-Received: by 2002:a92:c990:: with SMTP id y16mr60036119iln.35.1609496817666;
 Fri, 01 Jan 2021 02:26:57 -0800 (PST)
MIME-Version: 1.0
References: <20201230214520.154793-1-ignat@cloudflare.com> <20201230214520.154793-2-ignat@cloudflare.com>
 <alpine.LRH.2.02.2101010450460.31009@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2101010450460.31009@file01.intranet.prod.int.rdu2.redhat.com>
From:   Ignat Korchagin <ignat@cloudflare.com>
Date:   Fri, 1 Jan 2021 10:26:46 +0000
Message-ID: <CALrw=nFFt4aUaJMc0OkKJfFfyv+A3oPuJxKMceOVGzrzwtP3Cw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dm crypt: use GFP_ATOMIC when allocating crypto
 requests from softirq
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        dm-crypt@saout.de, linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        kernel-team <kernel-team@cloudflare.com>,
        Nobuto Murata <nobuto.murata@canonical.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Jan 1, 2021 at 10:00 AM Mikulas Patocka <mpatocka@redhat.com> wrote:
>
>
>
> On Wed, 30 Dec 2020, Ignat Korchagin wrote:
>
> > diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
> > index 53791138d78b..e4fd690c70e1 100644
> > --- a/drivers/md/dm-crypt.c
> > +++ b/drivers/md/dm-crypt.c
> > @@ -1539,7 +1549,10 @@ static blk_status_t crypt_convert(struct crypt_config *cc,
> >
> >       while (ctx->iter_in.bi_size && ctx->iter_out.bi_size) {
> >
> > -             crypt_alloc_req(cc, ctx);
> > +             r = crypt_alloc_req(cc, ctx);
> > +             if (r)
> > +                     return BLK_STS_RESOURCE;
> > +
> >               atomic_inc(&ctx->cc_pending);
> >
> >               if (crypt_integrity_aead(cc))
> > --
> > 2.20.1
>
> I'm not quite convinced that returning BLK_STS_RESOURCE will help. The
> block layer will convert this value back to -ENOMEM and return it to the
> caller, resulting in an I/O error.
>
> Note that GFP_ATOMIC allocations may fail anytime and you must handle
> allocation failure gracefully - i.e. process the request without any
> error.
>
> An acceptable solution would be to punt the request to a workqueue and do
> GFP_NOIO allocation from the workqueue. Or add the request to some list
> and process the list when some other request completes.

We can do the workqueue, if that's the desired behaviour. The second patch
from this patchset already adds the code for the request to be retried from the
workqueue if crypt_convert returns BLK_STS_DEV_RESOURCE, so all is needed
is to change returning BLK_STS_RESOURCE to BLK_STS_DEV_RESOURCE
here. Does that sound reasonable?

> You should write a test that simulates allocation failure and verify that
> the kernel handles it gracefully without any I/O error.

I already have the test for the second patch in the set, but will
adapt it to make sure the
allocation failure codepath is covered as well.

> Mikulas
>
