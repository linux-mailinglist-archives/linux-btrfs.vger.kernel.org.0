Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE37553BB92
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 17:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbiFBPax (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jun 2022 11:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiFBPaw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jun 2022 11:30:52 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506E022938F
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Jun 2022 08:30:51 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id n145so5143372iod.3
        for <linux-btrfs@vger.kernel.org>; Thu, 02 Jun 2022 08:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NpFIkLBGSwL+tQ40Bb1MlfFDjldxM6dfjT81j6URS6U=;
        b=dO4T881JSGCnvYQOIihwAJs+RdEuLyMlJsa2Z7+up+/t5Utvc6mBK1Fq3wzkVRLfuS
         y3yl2GggjZC59uTlX4W+QUyfYAMU8EAFGfWF22Tdmu7DdqEZEi3LQY42zMqNrDxwHFAz
         6n95bqAfT6ZJnfRjWyP/SbDhWdRRiP07nv9zNKbDe/Ue7ORIcInx+ZbRfgFYbpG0Bpr5
         b0ObtuJ6Ec2O42qfd2uhffX3wAjFLFdaHCG85c4NSiS/SPVI+OjDqaKl/v5oA9myrutx
         05LSEvAJhTfpVSjVVbDRKFzQYpoUdD2qvj98NjWkfx7cqe/VNS2ufL4APwaGL91BgCdS
         RlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NpFIkLBGSwL+tQ40Bb1MlfFDjldxM6dfjT81j6URS6U=;
        b=zGVhec0KHRvfD/O1iiBTrYYCJho+Yl9+iXhmT78y5eS0ickACjpSzsIpLp+Z9Bzc3q
         /AQ0n9LBhBLDRo+nqgHOOrXziPMP0Pp2QomAbBiXj6qgDtNNn9+E/TZaCkY8Y1EovbHc
         7xQwx/lG7WWQa966zLzgWDbEkgULOW3o4Yp58BlofKt7qr6BUWtn8XM2aD1fGWbn7gCU
         nkKjCA2X2oQ6+v3v4q8bbtSa0NVh1ySjzRr9HjKAGb5QStiJvWmNdO2HQQFte9BFA2sO
         LONYRDo1pkKtPIR9cGLkENJWuOAEv4kJwutOBd+w3Btv1n8IKA9wyyX9HKmxkDMH0WXX
         1U6A==
X-Gm-Message-State: AOAM533jcmoPH/MZg3PWAlMa+YIgyKIfH4C8mlw2e+wtFqGt6ClPOggY
        nUMjx6+dCmu+doX6XMRBbrg1hzVCMCxFb5W+EcY=
X-Google-Smtp-Source: ABdhPJye79VpNnz8KqBt+wL6Jp9p3iD7mFQtUqsR+VaFSNeshkG10I8qOq93ZX5oVMu4rcECNyGBm7wqUBwmZ1cUsJg=
X-Received: by 2002:a05:6638:1925:b0:32e:dc08:ced3 with SMTP id
 p37-20020a056638192500b0032edc08ced3mr3367001jal.212.1654183850734; Thu, 02
 Jun 2022 08:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <CA+H1V9xQEDf0G-Nvcv3irtSPF+09dJ6VMs7F8LBLpUGEUSfxmg@mail.gmail.com>
 <7762988d-0a64-695a-4ccd-ba7b51c0754a@gmx.com>
In-Reply-To: <7762988d-0a64-695a-4ccd-ba7b51c0754a@gmx.com>
From:   Matthew Warren <matthewwarren101010@gmail.com>
Date:   Thu, 2 Jun 2022 10:30:40 -0500
Message-ID: <CA+H1V9wSZXVrLdz9ZELx8gc3nOHOJz4b48DQMFcmc8cTEJgXAQ@mail.gmail.com>
Subject: Re: Manual intervention options for csum errors
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
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

> This is not a good sign.
>
> Such bitflip can only happen in memory, as if it's a bitflip from disk,
> then it will cause the metadata csum mismatch.
>
> So this means, your memory is unreliable, and a memtest is strongly
> recommended before doing anything.

I don't think that's the case. The files were last modified all the
way back in 2020, but there hasn't been any file modifications near
them since the end of April this year. There's also been 2 scrubs
before the last one where there were no issues at all. Does this mean
that at some point in the last half month (since that's the time
between the last successful scrub and the scrub which errored) BTRFS
read and re-wrote the file to disk?

Matthew Warren
