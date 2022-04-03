Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA53F4F0A01
	for <lists+linux-btrfs@lfdr.de>; Sun,  3 Apr 2022 15:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358915AbiDCNoM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 3 Apr 2022 09:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358908AbiDCNoM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 3 Apr 2022 09:44:12 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32300344EB
        for <linux-btrfs@vger.kernel.org>; Sun,  3 Apr 2022 06:42:18 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id bg10so14924874ejb.4
        for <linux-btrfs@vger.kernel.org>; Sun, 03 Apr 2022 06:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=oK4vOpAUkD4qg7RicLDV0hWXvl3Idx4VcIM1XJewOzc=;
        b=RAy9PNarSQuqpReClVc1HCf0B0EWdlBVGsculRUXjvDC+tcqKcb4x+Cx4/mtS+3Rpk
         bx30/qbhUUIFChXXCM2Oi81J7amGzV3TcDy4Cw4UWoU1nfjSV6r9tNteDeepHlGMwsl2
         ya4sz4jhfWeMmcOnHbReYE1oyPp/9jtpkNlDIHUgWwqix+uvGJ7+Ga6N5N6Lz1lN3mMl
         QTKi5v7QzeNfHj0aqsWi3D4T+xZ86ISYCToIsAXCrpIAotMSoVCGEHfeksNGcxK+nqW3
         3OMXWGDZGFtq8qoUOD38P+mVkuZ2ahJninkew9IODt6XEJDS6wn9LeWa2AgkDD/9Enlc
         SG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=oK4vOpAUkD4qg7RicLDV0hWXvl3Idx4VcIM1XJewOzc=;
        b=yPu8kbZcnd5E07Xg1WDPvcSm1UB+oD4eKBovOq7o48WqeqR/YM+aeLM5lgjtEAqlXV
         l9/lLIe+Ab2fGy4fA1iGwyi5g9CvREUoCWgPYm7+hT9Q2/E8OLQIjf7iQTBBYPmnT/K8
         AfQytZJ2RSRMWM/II6Oet7bYLSUqx/RDjPP3i+47a6z8Wd+v95Un4bWjYg72M1nI1fhH
         DXbePK8HyxI25tAwMe/pGB+Www4egOj52cVPQDe78DlK1Og17hXFgVAG/knSABFp3oAB
         Rtda3+byQOQpCuekz3PxHBxdGu01EcmxCeLS8OnHYM5a1frbpE4TMl38Wj3IxZbpLZqf
         FLdQ==
X-Gm-Message-State: AOAM531RGXY0Z0xh00RVTmDqpgLY9870jPMyhcGc+QC68mI921+j86e4
        lsCLn+w47fEABhbveaZOrck2ZDQu1Dg=
X-Google-Smtp-Source: ABdhPJykLQPgFm++Syo8+v1qomunxXM/GC2Tciozf9kZh2S7h2O9mJVf/6mRh45P31Ql4AIIK8v5RQ==
X-Received: by 2002:a17:906:64ca:b0:6e0:1648:571c with SMTP id p10-20020a17090664ca00b006e01648571cmr6844617ejn.477.1648993336625;
        Sun, 03 Apr 2022 06:42:16 -0700 (PDT)
Received: from [192.168.1.121] ([94.65.82.68])
        by smtp.googlemail.com with ESMTPSA id u19-20020a17090617d300b006cea86ca384sm3237828eje.40.2022.04.03.06.42.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Apr 2022 06:42:16 -0700 (PDT)
Subject: Re: Adding a 4TB disk to a 2x4TB btrfs (data:single) filesystem and
 balancing takes extremely long (over a month). Filesystem has been deduped
 with bees
To:     Hugo Mills <hugo@carfax.org.uk>, linux-btrfs@vger.kernel.org,
        ce3g8jdj@umail.furryterror.org
References: <8a536fe1-68bd-4136-8cfb-bd410afc5fa1@gmail.com>
 <20220401131715.GL18319@savella.carfax.org.uk>
From:   Konstantinos Skarlatos <k.skarlatos@gmail.com>
Message-ID: <693e407b-9780-7afb-ad7f-d8d97cf9d65f@gmail.com>
Date:   Sun, 3 Apr 2022 16:43:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20220401131715.GL18319@savella.carfax.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 1/4/2022 4:17 μμ, Hugo Mills wrote:
> On Fri, Apr 01, 2022 at 02:13:58PM +0300, Konstantinos Skarlatos wrote:
>> Hello,
>> I am running btrfs on 2x 4TB HDDs (data: single, metadata: raid1) and i
>> added another 4TB disk.
>> According to btrfs wiki i should run balance after adding the new device.
>> My problem is that this balance takes extremely long, it is running for 4
>> days and it still has 91% left.
>> Is this normal, and can i do anything to fix this?
>     It's not normal for it to take that long, no. Do you have lots of
> snapshots (like, thousands), and lots of small or heavily fragmented
> files?
Hi, sorry for missing your reply.
I only have 12 subvolumes and no snapshots. There are about 10 million 
files in the filesystem.

>
>     Is the balance actually progressing, or has it got stuck? Are there
> regular messages in dmesg about it balancing block groups? If not,
> when was the last one?
It is progressing without getting stuck, every few minutes (sometimes 
sooner sometimes longer) a new block gets balanced

>
>     If your data is single, it's not really necessary to do the balance
> anyway, so you may want to cancel it. The balance in this situation is
> more about ensuring that all the space on the new disk is usable by
> the higher RAID levels. For example, adding a single disk to a
> nearly-full RAID-1 without balancing would leave you in a state where
> you couldn't add more data chunks because there's only space on one
> disk to do so, and RAID-1 needs two disks with space to allocate a
> data chunk in. With single data, that's not a problem.
Thanks for the advice. I think this is something that should be better 
documented as the official wiki says that this must be done after adding 
a new disk


>
>> kernel is linux-5.17.1, i have also tried with 5.16 kernels.
>> mount options are: rw,relatime,compress-force=zstd:11,space_cache=v2
>> I have been using bees for dedup, but it is disabled for the balance.
>> I am not doing any IO on the disks, they have no smart errors, and none of
>> them are SMR (2x WD40EFRX and 1x ST4000DM000)
>> Autodefrag is disabled, and i also have checked that the disks are in stable
>> drive cages in order to be sure i have no problems with vibration.
>> Benchmarking them gives normal speeds. Quotas have never been enabled.

