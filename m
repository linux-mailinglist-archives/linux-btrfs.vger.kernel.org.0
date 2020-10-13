Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EECB128CAD2
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 11:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404229AbgJMJP0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 05:15:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403986AbgJMJP0 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 05:15:26 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D310208D5
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 09:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602580525;
        bh=4Yg3qIbVVvHEczsjzYpO5n3aj4zsZDT1pQ1uzu9uD9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iDJH+MZ4scNEUrU4TSH7ugC64YF9XGSVVAIMgKVSYJD6QeQy0vCzl0ghyF6/fl60E
         bHLwrXViMdO9gKCzYIxRDJt2ywhLL9YO/xtfpGhQdgOanx3OenY63GcMayXDus0neK
         t3wujjIpKSaMHhllkeieud80P+pzLAKDx9HyOnJ8=
Received: by mail-qt1-f169.google.com with SMTP id c13so4534354qtx.6
        for <linux-btrfs@vger.kernel.org>; Tue, 13 Oct 2020 02:15:25 -0700 (PDT)
X-Gm-Message-State: AOAM5319M9nVvhy+BjKRRCWTD7FBrRHdSYXb1uSpJetXcv4+TIM8EVdC
        bL2Y3cGG9eysk9Wz36wd1y9R1ztXZggn3iblJrA=
X-Google-Smtp-Source: ABdhPJzv+CbVr09+SXRtK0Mq8AWdmgjMHIuHYg38boZKE6VVGFK4WDYxt6CNgT9ywdU+CS8ax2rHdurQeJF2Vjw7CsU=
X-Received: by 2002:ac8:5a53:: with SMTP id o19mr13912342qta.183.1602580524318;
 Tue, 13 Oct 2020 02:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1602499587.git.fdmanana@suse.com> <6c59a12446b7583172c886bee886d5229f7dccd5.1602499588.git.fdmanana@suse.com>
 <SN4PR0401MB3598176352537EB6551AC3CF9B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
In-Reply-To: <SN4PR0401MB3598176352537EB6551AC3CF9B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Tue, 13 Oct 2020 10:15:13 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4MPN-NLomCZjM7oQFxA+kE=7hWRSUcvp7E6B9hx3h46Q@mail.gmail.com>
Message-ID: <CAL3q7H4MPN-NLomCZjM7oQFxA+kE=7hWRSUcvp7E6B9hx3h46Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] btrfs: assert we are holding the reada_lock when
 releasing a readahead zone
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Tue, Oct 13, 2020 at 10:08 AM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 12/10/2020 12:55, fdmanana@kernel.org wrote:
> > critical section delimited by this lock, while all other places that are
> > sure they are not dropping the last reference, do not bother calling
> > kref_put() while holding that lock.
>
> Quick question for me to understand this change, is 'reada_pick_zone' the place
> that's certain it doesn't put the last reference?

All places that don't take the lock before calling kref_put() are the
places that don't drop the last reference, and there are several -
reada_find_extent(), reada_extent_put() and reada_pick_zone() at
least.
As far as I could see, all are correct. The change is motivated
because I had an earlier fix that did the final kref_put() without
holding the lock.

Thanks.


>
> If yes we should maybe add a comment in there.
>
