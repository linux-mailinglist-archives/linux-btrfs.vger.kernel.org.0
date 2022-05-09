Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B911651FD56
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 14:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiEIMtl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 May 2022 08:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbiEIMtd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 May 2022 08:49:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0431CFE6;
        Mon,  9 May 2022 05:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 272C66138B;
        Mon,  9 May 2022 12:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFBEC385AF;
        Mon,  9 May 2022 12:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652100338;
        bh=Tikj/nyIgX8rDQI3upyRXQQTWA+piTOjreg+neBF7fk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NSYXduVPnqGBIo5bAr4Qhcv59SFUpHiy+YtKi+WnT2hzwmCX6vTKy+qweU/YgUWRs
         LnLgNNFC8ymy0H++QoEQ0p1V/SLj7iBakMo6ZEqllx/qktNqu/joReQqSrCs/Z1EnJ
         rJdtCA2w316GLa9DlifUid5WPJDUIhqmezWfrOupU3/zHEPRHRHJSCsiOF7GJAtH9w
         VZ4pCGaH2oqVdtEcHg9IyinkQrAh1/d5ZsgT8nVpaYhee2O2FP+fH9EpZM2cyfey2d
         4kmVbw7KeRxUWnCqT1NsElB+b4rtXgQjoRXoLNq2G6CWaCJdQWWFzTrxyNAidzNIym
         m8MefvG9wH1YA==
Received: by mail-qt1-f170.google.com with SMTP id h3so10841603qtn.4;
        Mon, 09 May 2022 05:45:38 -0700 (PDT)
X-Gm-Message-State: AOAM530Kjqo4+kG2m2+qJ5g4ANmGykz22xUu7EPCjfawX1j/ogGUI/S+
        FyUC69/pIPwXwIL2Ti7IU5d2XA2HlMriBs2ZUSM=
X-Google-Smtp-Source: ABdhPJzkMa92WoT+Hr5nxKqeeehUUH0AclduK/szoqHisL7zh7PL1t0NJZJBxwrtgq+V/wuriYCHwzzCRd9JWJJd9b0=
X-Received: by 2002:ac8:5850:0:b0:2f3:b4c3:110c with SMTP id
 h16-20020ac85850000000b002f3b4c3110cmr14575809qth.379.1652100337594; Mon, 09
 May 2022 05:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <8f06924cda35f9a5e22c1c188eb46205dd50491f.1651573756.git.fdmanana@suse.com>
 <20220509141508.6647bc5f@suse.de>
In-Reply-To: <20220509141508.6647bc5f@suse.de>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Mon, 9 May 2022 13:45:01 +0100
X-Gmail-Original-Message-ID: <CAL3q7H5cFDa2AjMA2RFGpd97EjFmerNJ9HWrE8pZ4LZTC1RbZw@mail.gmail.com>
Message-ID: <CAL3q7H5cFDa2AjMA2RFGpd97EjFmerNJ9HWrE8pZ4LZTC1RbZw@mail.gmail.com>
Subject: Re: [Resend PATCH] generic: test fsync of directory with renamed symlink
To:     David Disseldorp <ddiss@suse.de>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>, zlang@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, May 9, 2022 at 1:15 PM David Disseldorp <ddiss@suse.de> wrote:
>
> On Tue,  3 May 2022 11:57:49 +0100, fdmanana@kernel.org wrote:
>
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that if we fsync a directory, create a symlink inside it, rename
> > the symlink, fsync again the directory and then power fail, after the
> > filesystem is mounted again, the symlink exists with the new name and
> > it has the correct content.
> >
> > This currently fails on btrfs, because the symlink ends up empty (which
> > is illegal on Linux), but it is fixed by kernel commit:
> >
> >     d0e64a981fd841 ("btrfs: always log symlinks in full mode")
> >
> > Signed-off-by: Filipe Manana <fdmanana@suse.com>
>
> This looks fine and works for me.
> Reviewed-by: David Disseldorp <ddiss@suse.de>
>
> ...
> > +mkdir $SCRATCH_MNT/testdir
>
> nit: It's worth quoting the variable here (and elsewhere). That said, I
> highly doubt anyone is using a SCRATCH_MNT with a space in it, so it
> should be okay as is.

Indeed.
I'll send an updated version later.

Thanks David.

>
> Cheers, David
