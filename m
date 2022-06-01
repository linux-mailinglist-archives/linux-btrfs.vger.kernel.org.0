Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA51D53B03E
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jun 2022 00:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiFAWfK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 1 Jun 2022 18:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbiFAWfE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 1 Jun 2022 18:35:04 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A3D24CC82
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Jun 2022 15:35:02 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p74so3198357iod.8
        for <linux-btrfs@vger.kernel.org>; Wed, 01 Jun 2022 15:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KiV9c3uGJr9ajCbSpEGnvsT5dWFYthwtPSyN2Bf9CjY=;
        b=AFY1ubAS3ldjKfcaMtJymx9JgGD+2BYEpguRU1Ro7pvLPKRpMdvBR0FMzzbUPMbswC
         5x15ufxupS/xRnfj2mzngfukkNs2dQuuS3Hb0qqxndFNeQke/9I1szD7klQEChsrIuiq
         ZhPw/cRwTJKZK1kDnFn/cs8pvVjHzucj8yvTRyPsktOQS4FG/YkxgAaKYbg3LmCUBVGz
         CMM4w0km1iKKQsBy/3ZQlma2XInAFTIS+qkSKLNDym3glNoW8KpbgPd8F3l2mIVPutlg
         O4hrRZ2LUSk//Po8jRMwVpET57ejYY6P5SD+dXktM+lXmC7cLa5aYcrmm8oDIDbfYLRC
         l4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KiV9c3uGJr9ajCbSpEGnvsT5dWFYthwtPSyN2Bf9CjY=;
        b=zvCASAZ9anBhMLeS8I6KVQ2pzxA3iaLhRFQCuva59rDjuznCONYUqrjgHfNNV26HfM
         MPH3JONytd04cpetC5zgWhbFeFrH/GIkKaP24h5j2/MQU7eUxHBvqc6/+eB6WK2dL1jb
         VmoliiD5Q7QjVBDhPuLyhGYzcfmpJq/JAZS7Vxh7iY1eabrQLBVe9CDlbEioeK9azEAh
         v5MLdDkWDVn20ou65MGt+WCRmZzKYIUbMJZ5Goxe4l1sw2RGv99D0vgks6BJfVRqFx2B
         X1aA8KWH4Si0crJ5YMJaaK+3KbayO0GjnJ7Z8+43Oh7OVIWXizgBVaJjaki3U0TOSehd
         GUmw==
X-Gm-Message-State: AOAM532GYTi6SU+Yt4wPsrnx58xK5saWjrXQ/VWA2N+fT/7rSgFHPCPS
        E0p5HbYR+NJY8Fxyv5NCt1EPP7KV8WMXmECYqAzyLI/knIs=
X-Google-Smtp-Source: ABdhPJzYQK7zFwuero8UfVf2ls2azFzqVpfCef2Rd2Pm9uGjXIas6Rho6fUJ/FcJfEhwTL7qZ+DO3DMyc1IR+Iz+2YQ=
X-Received: by 2002:a05:6638:379c:b0:32e:d7a6:b715 with SMTP id
 w28-20020a056638379c00b0032ed7a6b715mr1446180jal.102.1654122901928; Wed, 01
 Jun 2022 15:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAEzrpqc_sCu18+tfP9E1Z3+kj70ss7nH-YTnEu0Rw_QQxPWTUQ@mail.gmail.com>
 <20220601031536.GD1745079@merlins.org> <CAEzrpqfw85GnLUq8=vywej1Gb6vjcgKUYucLw9DgoSaWEbyZbg@mail.gmail.com>
 <20220601163924.GE1745079@merlins.org> <CAEzrpqd7=9JxgjC0pqikEo5o7RTsP9M-qLLcCps0Vx1RxRak-g@mail.gmail.com>
 <20220601180824.GF22722@merlins.org> <CAEzrpqc1cFHwb8fczUatznbwzDFi87j-kuXMMcUf2rmKWzu5Lw@mail.gmail.com>
 <20220601185027.GG22722@merlins.org> <CAEzrpqcY-F4WOiaJcDfHykok0LB=JEX1DnZj53+KvM7a6j+daQ@mail.gmail.com>
 <CAEzrpqeTEuRzP_Nj1qoSerCObJLA4fJYDfR1u3XMatuG=RZf-g@mail.gmail.com> <20220601214054.GH22722@merlins.org>
In-Reply-To: <20220601214054.GH22722@merlins.org>
From:   Josef Bacik <josef@toxicpanda.com>
Date:   Wed, 1 Jun 2022 18:34:51 -0400
Message-ID: <CAEzrpqduFy+7LkgWyyEnvYLgdJU6zDEWv25JM-niOg9tjmZ3Nw@mail.gmail.com>
Subject: Re: Rebuilding 24TB Raid5 array (was btrfs corruption: parent transid
 verify failed + open_ctree failed)
To:     Marc MERLIN <marc@merlins.org>
Cc:     linux-btrfs <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Wed, Jun 1, 2022 at 5:40 PM Marc MERLIN <marc@merlins.org> wrote:
>
> On Wed, Jun 01, 2022 at 04:57:34PM -0400, Josef Bacik wrote:
> > Ok I've committed the code, but I forsee all sorts of wonky problems
> > since we don't have a tree root yet, there may be a variety of
> > segfaults I have to run down before it actually works.  So go ahead
> > and do
> >
> > btrfs rescue recover-chunks <device>
> >
> > if by some miracle it completes, you'll then want to run
>
> Found missing chunk 15483956887552-15485030629376 type 0
> Found missing chunk 15485030629376-15486104371200 type 0
> Found missing chunk 15486104371200-15487178113024 type 0
> Found missing chunk 15487178113024-15488251854848 type 0
> Found missing chunk 15488251854848-15489325596672 type 0
> Found missing chunk 15671861706752-15672935448576 type 0
> Found missing chunk 15672935448576-15674009190400 type 0
> Found missing chunk 15772793438208-15773867180032 type 0
> Found missing chunk 15773867180032-15774940921856 type 0
> Found missing chunk 15774940921856-15776014663680 type 0
> Found missing chunk 15776014663680-15777088405504 type 0
> Found missing chunk 15777088405504-15778162147328 type 0
> ERROR: Corrupted fs, no valid METADATA block group found
> Inserting chunk 14823605665792wtf transid 2582704
>

Fixed, lets try that again please.  Thanks,

Josef
