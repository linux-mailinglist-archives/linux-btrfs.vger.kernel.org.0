Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455FE3513BD
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Apr 2021 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbhDAKhM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Apr 2021 06:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbhDAKg5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Apr 2021 06:36:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14210C0613E6
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Apr 2021 03:20:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso639720wmi.0
        for <linux-btrfs@vger.kernel.org>; Thu, 01 Apr 2021 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ij80DQ2jXL9m+Z8sKUpY0+iZaeIx94t+CnoHMJlBPT4=;
        b=NrSusv6/zPxMwFyQXF4tHJ920EGIB2nBqUdud6pxA4ltrNxvwDnkoM70Svzufil3zo
         yWrC8bwJbbBSjFvHSycSuq92hnJl/DMyRJ19W9ViWcF8+AY+GFvDD0l9wTSdZalZ7Gqb
         Sl38CRch1kTmBZkNAEkJjs+3hZhmB0jTFhfyPFi5TmM4oxmyoyWMtNxxN7j43mr5jIWH
         MF1k5gUoILM4ZcTl29pwCFK0WEaH5dm6wclnCCaJIUJ9UxV0Qbp3u3uDb4G0tf9em/Mf
         5AB9Eo9DhE3NBvCeCSPfhM1y+ch4UFTDAtSpiizNEn5FDbeCktFgL8GEHwYie3IO3GtF
         RgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ij80DQ2jXL9m+Z8sKUpY0+iZaeIx94t+CnoHMJlBPT4=;
        b=h3xE590voe6vsiUVenwVBlmKknPMoXLKvr/tyLYapHhWiq1DaDgLBgDm7+RY2uloKO
         X8IjG45TBbWXdjVZJbrrl91AjkFeUraX0BqBK88IYX+zS0z+almCJJIwSCNUbbC1bhKB
         dFE6zDG4uUIunig91xEwY3DireteFujZAO61VvPs0XIzyelqcXvJVLTyexPoQy5k8Xmt
         q9dK/m9HT53J2QPFBYMzvR5boiL7Ch7v/rFjXXkNvXWNB9EZUbyMNayWhVLmMkaOMwqe
         6oiJn1czyb6D53NZD8t6UE09DPfm+QGQgoa82NmiXCpNZt61iTWnDCcyfIvnkLc9IvQ3
         mVmQ==
X-Gm-Message-State: AOAM533r8KvnfPtzO3bNmSecDDQ/3v0DsC0682/ZNPS5J46Rd0b7hKv9
        UaphhyjLjDhytg9xZrXFCd3yVS4o9Je2Ew==
X-Google-Smtp-Source: ABdhPJw9EOOpzFLwKQ3Bq65ps8+Tkx1/U+WXFmcRZN5gCS3vz8UApL5id+jC2TKgqtmLq9XXlZYwoQ==
X-Received: by 2002:a05:600c:290a:: with SMTP id i10mr7449478wmd.91.1617272454697;
        Thu, 01 Apr 2021 03:20:54 -0700 (PDT)
Received: from [192.168.44.27] (dynamic-046-114-002-143.46.114.pool.telefonica.de. [46.114.2.143])
        by smtp.gmail.com with ESMTPSA id p18sm12450018wro.18.2021.04.01.03.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 03:20:54 -0700 (PDT)
Subject: Re: Any ideas what this warnings are about?
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <43acc426-d683-d1b6-729d-c6bc4a2fff4d@gmail.com>
 <20210331015827.GV32440@hungrycats.org>
 <adbc670b-b85e-a44d-3089-089c4564f57f@gmail.com>
 <CAJCQCtSKjcDuVprCq_kjaMrwgJ1QXq=8YaU9b8hok+sqYhvqxA@mail.gmail.com>
From:   Markus Schaaf <markuschaaf@gmail.com>
Message-ID: <ccb7cae7-08d1-4499-a1c5-9c7ccd1722da@gmail.com>
Date:   Thu, 1 Apr 2021 12:20:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtSKjcDuVprCq_kjaMrwgJ1QXq=8YaU9b8hok+sqYhvqxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Am 31.03.21 um 22:20 schrieb Chris Murphy:

> Flushoncommit is safe but noisy in dmesg, and can make things slow it
> just depends on the workload. And discard=async is also considered
> safe, though relatively new. The only way to know for sure is disable
> it, and only it, run for some time period to establish "normative"
> behavior, and then enable only this option and see if behavior changes
> from the baseline
 > [...]

Thank you for your detailed explanation. I was trying flushoncommit for 
better crash consistency. But this was based on theory, not experience.

BR
