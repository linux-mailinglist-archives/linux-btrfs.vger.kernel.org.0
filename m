Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3608F69BB52
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Feb 2023 18:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBRRs3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Feb 2023 12:48:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRRs2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Feb 2023 12:48:28 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402C314EB2
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 09:48:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ec30so4340314edb.10
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Feb 2023 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jse-io.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilq6zPMBe5nShMufNpG/d+eOQbxt9lvbDFQo+/h41Wc=;
        b=4SLRT3BPleUxoL4YM5LnLzDRvBu6506pVU80dVWtJ33ZuHljKfa4h+x6eJiENHXeIF
         EjJ0M1fcNAQfR9ZgiO5Yb13xz2dYp4LgJ8B5CPBR5fhXbwI09QICkaeW8WJZRBHE/Swg
         N612klXiqTsgI8HWmdjqJ6nV2PvwMXjXGFal0OxNTxJqI7Fes7fo9I/hG50p+Hcp98dF
         qhvFdV6Ze2ZHO5EdQluQJX4yxnyjKQVPL2uK0OHDSHoPyx9Uu2EE92x2Y5x53adaQZoA
         Wjcg16q0f6289ArDH8XATuGdwRMN7z/s5DVWyG/7kVYg79UGvme7Pn/49SwMUV4CoULH
         rHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ilq6zPMBe5nShMufNpG/d+eOQbxt9lvbDFQo+/h41Wc=;
        b=1WGWP/k92jrqIrfOXQQeRfK5xBxBzoHHgLmISudlWPOzepTUbii6wNBe5oovXrNjRS
         pnbfDel0YonfqYmOwjAKdB6tzYUDE2EQe+PBiRX23IHwpNfmHGAEsa36cXdUZqe7y8rB
         ygoYibXoo1f6URRo4C/VS92ONaQ9uVlpj0vp+aciFuhpddPAbC5GwIuaPx8xueVATOn5
         cIt7s69aWhfGhfaz+n05r2OhwS6ixUBxbJVG/iiRne1CUvAczw2GICPUmv3AcaNNNWCf
         OxqKn46+3C+swpSMr/iMqcvUgQF2Zb6ikGTj/57Xi6bvzmFgyBsNG/LxSKwZzbRY2rAl
         fWhQ==
X-Gm-Message-State: AO0yUKXwEEQijkXhKSCnL3SwJyrSwaQYas6qUbOiHTEISvmcH1XYdHQh
        V4hvwL6kZFzctvb5G064j0iNzK3zRYZ0nzkmsNHfnG4/5ZxIdQ==
X-Google-Smtp-Source: AK7set8fqMKZ4JIB5p4Vv8Czm379uwojAb85rKixpGQKDvIOmvdVts0EnVuZLj5riLEKfgiHXvF/gYNU7ZhZmWf0Lu8=
X-Received: by 2002:a50:9514:0:b0:4ae:f5fd:c2d1 with SMTP id
 u20-20020a509514000000b004aef5fdc2d1mr688347eda.2.1676742504433; Sat, 18 Feb
 2023 09:48:24 -0800 (PST)
MIME-Version: 1.0
References: <87wn4fiec8.fsf@physik.rwth-aachen.de> <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
 <87a61bi4pj.fsf@physik.rwth-aachen.de>
In-Reply-To: <87a61bi4pj.fsf@physik.rwth-aachen.de>
From:   "me@jse.io" <me@jse.io>
Date:   Sat, 18 Feb 2023 13:47:48 -0400
Message-ID: <CAFMvigcmGsqNv11LbZxnJ+TX1_RUm__Vay-S2xNhwKupxTXuQA@mail.gmail.com>
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive operation?
To:     linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Sat, Feb 18, 2023 at 7:45 AM Torsten Bronger
<bronger@physik.rwth-aachen.de> wrote:
>
> Hall=C3=B6chen!
>
> Goffredo Baroncelli writes:
>
> > On 18/02/2023 09.10, Torsten Bronger wrote:
> >
> >
> >> I want to replace a device in a RAID1 and converted it
> >> temporarily to =E2=80=9Csingle=E2=80=9D:
> >
> > I suggest you to evaluate
> > - remove a disk when the FS is offline
> > - mount the FS in 'degraded' mode
> > - attach a new disk
>
> I agree that converting to single is not the fastest way to replace
> a disk, but the safest AFAICS.  It is the boot partition in a simple
> home server without monitor or keyboard, which makes mounting as
> degraded difficult.  Besides, you can only mount in degraded mode
> once.  If anything goes wrong, I have to rebuild from scratch.
I just want to make clear, this bug was fixed long ago. You would need
to update your bootloader conf to use degraded at boot time in this
case, but in theory, it should work identical to have a raid1 degraded
as converting it all back to single.

I agree though, it would be a great feature addition to reduce IO load
to replicating single chunks to RAID1, or converting them back to
single but not rewriting them out. On SSDs it would reduce wear, and
on HDDs would reduce seeking/head thrashing.
>
> Mileage may vary in a more professional environment.
>
> Regards,
> Torsten.
>
> --
> Torsten Bronger
>
