Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BAE3FB427
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Aug 2021 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhH3K5G (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Aug 2021 06:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235818AbhH3K5F (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Aug 2021 06:57:05 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641CEC061575;
        Mon, 30 Aug 2021 03:56:12 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c19so11220959qte.7;
        Mon, 30 Aug 2021 03:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=lmTXH0f4gpTc8x+SCOnNq02yPWJMOVcINx5SpXDVI9w=;
        b=Lyn9E/QGIuCMGPJoqJOXtaYMRg+k9NsT5G80pwVlPA5wZwbOHM6VDqyDZr3YUiktsx
         fjBVryqK6RkqYTIHzUY54fqHyv3zDamlqsjwxnUiDbCRW/J43+jUZ+jK3yazPiiifghy
         9K/Ichb0vYH9szw45tBFHhlHVmOTis8yLsGUx8IOlBWoDnfzCsMWqUMXMHVOP0Xgm9DO
         Wr3yML3V867uzJsu3MZzqwGN2Mpti1L+sRYQ3hlz6xFCdKEm3f11vN2VDerKCHsbelsk
         KG7vsTpGY9T93Qb1dVGEQBBnWxNeXuDllpMIbb9YCK09mB/8EsI4jPPUnsfI++vAziWA
         nKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=lmTXH0f4gpTc8x+SCOnNq02yPWJMOVcINx5SpXDVI9w=;
        b=acpYGWjsOkmz6ab93iFzR2ctcWCb5QMQJqtabQZuVggnHdjrdrR/hSqPy60TJG3Byh
         1S50opISU+Qy5Vurhy32G09k9ubIOUCP38jgxrLJjPPUafq/U+OVIxatgO9Bs59OdrrS
         D7kHNlk6/4KqsD5SQSVcLcAkUlvXYvoEgZto1bRh/h59sbq4WzgYBZXFEQyW45EPViMI
         8CVVr7TBwaXpcCy2ODmU7bI2HqBcVY8xMrCTsTo8VL1dPPEVq2J8gABckYVFKxUV8fgl
         Zr7+YdUdCQvXv242O84GAp7cJNnQ9TjWdnf5rJDUEPD1lZp5w28Fc/CrENqcw+YrH0CG
         OZlA==
X-Gm-Message-State: AOAM531Ii37snJYul5vASMIdiq2txrQVWyTxgBjAg1XgfBeKKvEGoMD1
        MRefVu8V9Dr379LeEKvhg2nu4Zd8YF6vOGLaVqyY6AM7
X-Google-Smtp-Source: ABdhPJy+ZG+i0DePnFK6mUYxNbl+5tVDC8Ljs33n2l6qO8kBejC6I0jPXiHUZ3sJzv/9kNgc6VCNNcNsiKcBKRWiveU=
X-Received: by 2002:a05:622a:58f:: with SMTP id c15mr20458427qtb.21.1630320971619;
 Mon, 30 Aug 2021 03:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210819131456.304721-1-nborisov@suse.com> <CAL3q7H57NsQ2WhdsC3=gYftFp_JUKHVxNgCAQuXPwvFzux9CaA@mail.gmail.com>
 <b49f409f-e5cc-6d13-ef6a-2ab25f95d19e@suse.com>
In-Reply-To: <b49f409f-e5cc-6d13-ef6a-2ab25f95d19e@suse.com>
Reply-To: fdmanana@gmail.com
From:   Filipe Manana <fdmanana@gmail.com>
Date:   Mon, 30 Aug 2021 11:56:00 +0100
Message-ID: <CAL3q7H7WyC9LQXJYYe9DCTPPiL-Q1P_gyNGptEBMH=2br5dE-g@mail.gmail.com>
Subject: Re: [PATCH] btrfs: Add test for rename exchange behavior between subvolumes
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Aug 30, 2021 at 8:18 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
>
>
> <snip>
> > Finally, this would also be a good opportunity to test regular renames
> > with subvolumes too, as we had bugs and regressions in the past like
> > in commit 4871c1588f92c6c13f4713a7009f25f217055807 ("Btrfs: use right
> > root when checking for hash collision
> > "), and never got any test cases for them.
>
> What specific tests do you have in mind? Ordinary renames of files
> within a subvolume are already tested by merit of generic geneirc/02[345]=
.

So besides the case mentioned in that patch's changelog (renaming a
subvolume), checking that we can't rename an inode across subvolumes.
Something like checking that:

rename /mnt/subvol1/file /mnt/subvol2/file

fails with -EXDEV.

Thanks.


>
> The test in the patch you cited is basically renaming a subvolume within
> the same subvolume, that's easy enough.
>
> <snip>



--=20
Filipe David Manana,

=E2=80=9CWhether you think you can, or you think you can't =E2=80=94 you're=
 right.=E2=80=9D
