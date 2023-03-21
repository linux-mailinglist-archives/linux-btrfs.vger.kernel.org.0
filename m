Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5E96C3C9B
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Mar 2023 22:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjCUV1D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Mar 2023 17:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCUV1C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Mar 2023 17:27:02 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711F65708F
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 14:27:01 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5456249756bso8141427b3.5
        for <linux-btrfs@vger.kernel.org>; Tue, 21 Mar 2023 14:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112; t=1679434020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quiegcQSCiXRFTXNojeIfrcsBYh/Ff/DgGvH4TpI6jo=;
        b=Lj676nPtWBnUX3fqsr1xp/SnihGpFQ8+V4hkPfV1/gUS5f72bJ9jQuYU0h5Ta5l2ZW
         5cUi/Anrkrp1js8pDJ84/rHnFPBaPWIBtxvtHsjcZT+5qFKPj1ilyvQ1YJS7nm2Px2fW
         FCycjzYeiQHBbSWGyr2Ih3l2MbjPG5Fn7QG6XuJwgX6nn2/2MwDFa45VOJyJBpxR4oPr
         2sBcQ7xtZjWNeXA98mFCdrEEBUN0QuRpAqxVkNeUeybT85/bxBIaBcEL6vGJG9fIE8e6
         8NsE3sCrT2hiaczGqOYp6Ty8bUx6CjYVQidQQHJPTpxL9RmtfsMnP0eXTRRj3CNwW4lm
         8PEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679434020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quiegcQSCiXRFTXNojeIfrcsBYh/Ff/DgGvH4TpI6jo=;
        b=DvJHisALOWUuTAzbdmfFNGHRqPTX0CNrvFk7n2npx0yxb30msC3Pd/5rR8OFVFvPaw
         +P02spz1qeJZJ+8pHUcDaJEQkfABS9vnkzmLmtWd3djzcPNtE2NwxTxWYR75wo+kG1z0
         cvz9tLFwuXt4Oz3EEqTLTUhfc9zCref1Jphdl9oOPIso4JbBcs/5dQpjV96N2hr1aY/u
         tTrjwXt9kfSvXmdHOpYttOYEUTKcueONxItCJHWAeSSkYtMXdgWn2qnXwGCf8IeGvDpC
         dJmCvs62BVnf3uisBADMH391GvbyI+B5GIrxYVc97geedPDliZeHq1zdHB6nJ13S8RU/
         lT4A==
X-Gm-Message-State: AAQBX9eXNLDPQbCxrh6tYI9rGa29msUY6hXwQp7ScbDty4BJ8goMYFy6
        uLCZ93oUDZqYUdJqbLbMhzLe06jcE3M2QJ3JUH+Hbg==
X-Google-Smtp-Source: AKy350ZobmZAx6jRdIic7N58KhFORCo1uOULJ1qMAuCQGaQFmluAMfxfKUlCer3QUP0c+0OPQHkXhKzy/zcVqyKl110=
X-Received: by 2002:a81:ac20:0:b0:52e:ac97:115f with SMTP id
 k32-20020a81ac20000000b0052eac97115fmr16105ywh.5.1679434020436; Tue, 21 Mar
 2023 14:27:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
In-Reply-To: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Tue, 21 Mar 2023 17:26:49 -0400
Message-ID: <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
To:     Christopher Price <pricechrispy@gmail.com>
Cc:     slyich@gmail.com, anand.jain@oracle.com, boris@bur.io, clm@fb.com,
        dsterba@suse.com, linux-btrfs@vger.kernel.org,
        regressions@leemhuis.info, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 20, 2023 at 6:41=E2=80=AFPM Christopher Price
<pricechrispy@gmail.com> wrote:
>
> I can also confirm the issue occurred on and after kernel 6.2, and
> confirm the workaround setting btrfs discard iops_limit works for my
> device:
>
> 08:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd
> NVMe SSD Controller PM9A1/PM9A3/9
> 80PRO
>
> I had to use ~6000 for my device, instead of 1000.
> I'm currently on kernel 6.2.1.
>
> I am also interested to know what if this is expected.

We got the defaults based on our testing with our workloads inside of
FB.  Clearly this isn't representative of a normal desktop usage, but
we've also got a lot of workloads so figured if it made the whole
fleet happy it would probably be fine everywhere.

That being said this is tunable for a reason, your workload seems to
generate a lot of free'd extents and discards.  We can probably mess
with the async stuff to maybe pause discarding if there's no other
activity happening on the device at the moment, but tuning it to let
more discards through at a time is also completely valid.  Thanks,

Josef
