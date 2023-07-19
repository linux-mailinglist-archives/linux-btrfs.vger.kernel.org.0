Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A1B7598F5
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 16:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjGSO7N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjGSO7L (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 10:59:11 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF21731
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 07:59:09 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77dcff76e35so68234739f.1
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 07:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1689778749; x=1692370749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ICb7RPhj9THtotfEDHYZojODhhUA6rrNiRk3l8GEH5M=;
        b=adlagU0m2fty6MnRjE1esHQVatB0LA435j+iLIOVlwId0WTPrfJHS0IWcLBvUuBhzE
         krKRBVTY//YEn6pe7DdfargaDfzUckgP5CiiaIDaNJTejme82k7E0//0Xq7msZaDtX6v
         BLO5VOFNElLKigoT5KGm3UKl64vpomGBoqmnOopMCAHx+gP8VnDH0ZadOLfk/sapQh2D
         0uqfxtbBEMQ0IGlHTFHn8uF5OrQsXH6GM9GLNgyBgeZs86ZPMzK+D3/XAkb0ruM7t1Kc
         +H32+jroBrktJ/P12jtmXJq3UT3MjkHBmTU2rX48s1ns+df5JplLYXr0nroDloY27gTC
         Jxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689778749; x=1692370749;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ICb7RPhj9THtotfEDHYZojODhhUA6rrNiRk3l8GEH5M=;
        b=DegnWmRJXDOZmbDy/wOK7yM7CSKPi1fhOxwEmSirySsMLAfDY2bqxjYt2HNsh/yK8u
         04Jg75ljAC8jonW9Eb5+ED3W+MnkBxdbPKGN465lVXz6JRhTsRhSuZQY6h1+upUuY3Wa
         IaEgHFaciSemaoV/ck5bgP+SH3bT3ionvGgnK4GycMRzBMEQDPP5eQbsvJ68Am0i3PVH
         DojJm6qIvsDtFP9O+E+YU7If+F10ZDFopxcglU+BW4z7zIbjf2x/DZjHBAYYTqVI0NA/
         hmQvH81WAJRQbzQ2Zm4GCrqy0u8flYyxpRc6glWaxe/KNscACddnXnpAW7lwrixiVB6J
         UMlg==
X-Gm-Message-State: ABy/qLbg7YbBuJ1wW9IGWpxpOFwdWPaFXj0BHTz2aiN9HffO1s+cGt8O
        XO6uC3G88PgA1CsjETlcRK+4mQJg8hsBexrQ8K8=
X-Google-Smtp-Source: APBJJlENVexdLonLHoMGmsTXKJlyns1HNzBP7ChYcyzLyvA4b08KT3XHE6Ew+3JyPI4q6+GpQHp5zQ==
X-Received: by 2002:a92:d985:0:b0:345:bdc2:eb42 with SMTP id r5-20020a92d985000000b00345bdc2eb42mr2753iln.3.1689778748855;
        Wed, 19 Jul 2023 07:59:08 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l3-20020a92d8c3000000b0033b2a123254sm1460661ilo.61.2023.07.19.07.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 07:59:08 -0700 (PDT)
Message-ID: <ffb05334-b3ee-3a74-8c07-84afa2e62932@kernel.dk>
Date:   Wed, 19 Jul 2023 08:59:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] btrfs: scrub: speed up on NVME devices
To:     Martin Steigerwald <martin@lichtvoll.de>, dsterba@suse.cz,
        Qu Wenruo <wqu@suse.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org
References: <ef3951fa130f9b61fe097e8d5f6e425525165a28.1689330324.git.wqu@suse.com>
 <6c9a9e34-365a-3392-0289-a911b34a9e4d@gmx.com>
 <4f48e79c-93f7-b473-648d-4c995070c8ac@gmx.com>
 <1921732.taCxCBeP46@lichtvoll.de>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <1921732.taCxCBeP46@lichtvoll.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/19/23 1:27?AM, Martin Steigerwald wrote:
> Hi Qu, hi Jens.
> 
> @Qu: I wonder whether Jens as a maintainer for the block layer can shed 
> some insight on the merging of requests in block layer or the latency of 
> plugging aspect of this bug.
> 
> @Jens: There has been a regression of scrubbing speeds in kernel 6.4 
> mainly for NVME SSDs with a drop of speed from above 2 GiB/s to 
> sometimes even lower than 1 GiB/s. I bet Qu can explain better to you 
> what is actually causing this. For reference here the initial thread:
> 
> Scrub of my nvme SSD has slowed by about 2/3
> https://lore.kernel.org/linux-btrfs/
> CAAKzf7=yS9vnf5zNid1CyvN19wyAgPz5o9sJP0vBqN6LReqXVg@mail.gmail.com/
> 
> And here another attempt of Qu to fix this which did not work out as well 
> as he hoped:
> 
> btrfs: scrub: make sctx->stripes[] a ring buffer 
> 
> https://lore.kernel.org/linux-btrfs/cover.1689744163.git.wqu@suse.com/
> 
> Maybe Jens you can share some insight on how to best achieve higher 
> queue depth and good merge behavior for NVME SSDs while not making the 
> queue depth too high for SATA SSDs/HDDs?

Didn't read the whole thread, but a quick glance at the 6.3..6.4 btrfs
changes, it's dropping plugging around issuing the scrub IO? Using a
plug around issuing IO is _the_ way to ensure that merging gets done,
and it'll also take care of starting issue if the plug depth becomes too
large.

So is this a case of just not doing plugging anymore, and this is why
the merge rate (and performance) drops?

-- 
Jens Axboe

