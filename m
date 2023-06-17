Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D6733E2E
	for <lists+linux-btrfs@lfdr.de>; Sat, 17 Jun 2023 07:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbjFQFL1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 17 Jun 2023 01:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjFQFLZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 17 Jun 2023 01:11:25 -0400
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A58519BB
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jun 2023 22:11:24 -0700 (PDT)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-55e1a9ff9d4so498211eaf.1
        for <linux-btrfs@vger.kernel.org>; Fri, 16 Jun 2023 22:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686978683; x=1689570683;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EVPg4WuB6iQ5NVO++gAwDmqFBoPITQhWSWc1v3vZyRc=;
        b=QyHqmWzd2rObiEyOlsSJkmLqusKEBpSVc5K4+c8NU7T0jeOgpXNTv7ejAwksRHs7wN
         58IwTFiTSF4Cgg+KgO9U9ycT8oliqkED0lYbjPIBmOsmulWh2cZEA4T2xgMGg+mgIwt7
         TwnIoUZ8aWqWZ94VMw2PESHdQ4OnujbG8L4zBkJmiFyGjHtpvP95IHtJBqMmGTDMufu0
         29kK0EPg0ICfGQRpT4NP61OLbha3xFODh3HoULpn/EcpJG1ZLRc985G9XSdkKioL3n45
         QokQBfTZLN3PwxLulGD39GrUJ7yje/uhNdzhK/tIVC3GPgJ3XUJgRuKzHkSlxSSl8+9M
         0CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686978683; x=1689570683;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EVPg4WuB6iQ5NVO++gAwDmqFBoPITQhWSWc1v3vZyRc=;
        b=Fok1oWPtYhyc52zkwMSHCz0EWrZ2ZDTHwOLpIHvLBKEqF8khsfRoFHq6SlPzW2mXor
         cxuwt60RxrgB9ovi8kVn8A1fB3Y/G2aAyuXyeA8QLqzhYtdNB0zfq+F3L2vetvc/8yZc
         yIXQFs8LEQDf6cClY6xnp5GiEG1lNdxrYZMHEsjpTHOwJx8iH2Xmwo+/6HXashp8I4Tl
         LgdI25ivPrqFvJygpIwruU3+runNnKB5mxxoo/Vt2o6HCCImonI9Dcpc4RnTbRJ7+sAk
         DAPoS/UDeJOStJ4EkljxbxMiJBDKqVhf/5nvebExcRCYW1HT3mENhrJ0VCVzcmjfVeUe
         ycvg==
X-Gm-Message-State: AC+VfDzg3zxYxiXGds+r3RfIdxeTKBczkpGXSBFpVCuPNI6O/XTABP1A
        rmsOU4T0nyRj0+iPfA/L89/uDeTocUBULkaSSVDkqcaRTUg=
X-Google-Smtp-Source: ACHHUZ6xy2TrVy7n76hwNB0EJKMVAxWJ8QRR3VUSG2WWGhgTg6xUODBEPuu7LSz8eDtmhcuH3zf+TOJroSZXnBtvK7Q=
X-Received: by 2002:a05:6808:101:b0:38d:ed4a:52f4 with SMTP id
 b1-20020a056808010100b0038ded4a52f4mr2309578oie.14.1686978683479; Fri, 16 Jun
 2023 22:11:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+W5K0r4Lv4fPf+mWWf-ppgsjyz+wOKdBRgBR6UnQafwL7HPtg@mail.gmail.com>
 <1ee0e330-1226-7abf-44bc-033decbe43e0@gmx.com> <CA+W5K0ow+95pWnzam8N6=c5Ff61ZeHyv7_yDK0LG6ujU48=yBA@mail.gmail.com>
 <40ecba88-9de2-7315-4ac5-e3eb892aac39@gmx.com> <CA+W5K0qLN3SaqQ242Jerp_fiyBw407e2h_BEA9rQ45HU-TfaZA@mail.gmail.com>
 <SYCPR01MB46856D101B81641A6CE21FB99E55A@SYCPR01MB4685.ausprd01.prod.outlook.com>
 <CA+W5K0oKO2Vxu3D2jOLET1RrM=wOxTEH2a_uH1w44H2x9kT2tQ@mail.gmail.com> <16ab1898-1714-a927-b8df-4a20eb39b8cd@gmx.com>
In-Reply-To: <16ab1898-1714-a927-b8df-4a20eb39b8cd@gmx.com>
From:   Stefan N <stefannnau@gmail.com>
Date:   Sat, 17 Jun 2023 14:41:11 +0930
Message-ID: <CA+W5K0pm+Aum0vQGeRfUCsH_4x8+L3O+baUfRJM-iWdh+tDwNA@mail.gmail.com>
Subject: Re: Out of space loop: skip_balance not working
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Qu,

I believe I've got this environment ready, with the 6.2.0 kernel as
before using the Ubuntu kernel, but can switch to vanilla if required.

I've not done anything kernel modifications for a solid decade, so
would be keen for a bit of guidance.

I will recover a 1tb SSD and partition it into 4 in a USB enclosure,
but failing this will use 4x loop devices.

On Tue, 13 Jun 2023 at 11:28, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> In your particular case, since you're running RAID1C4 you need to add 4
> devices in one transaction.
>
> I can easily craft a patch to avoid commit transaction, but still you'll
> need to add at least 4 disks, and then sync to see if things would work.
>
> Furthermore this means you need a liveCD with full kernel compiling
> environment.
>
> If you want to go this path, I can send you the patch when you've
> prepared the needed environment.
