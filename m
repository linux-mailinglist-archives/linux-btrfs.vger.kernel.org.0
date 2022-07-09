Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B84356CA84
	for <lists+linux-btrfs@lfdr.de>; Sat,  9 Jul 2022 18:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiGIQKp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 9 Jul 2022 12:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGIQKo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sat, 9 Jul 2022 12:10:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0ED2C644
        for <linux-btrfs@vger.kernel.org>; Sat,  9 Jul 2022 09:10:43 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so1283515pjf.2
        for <linux-btrfs@vger.kernel.org>; Sat, 09 Jul 2022 09:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=oKYe7AbRdgVEW/SANKAs5haVdcr7sWgF6qR0TOl7CFA=;
        b=xZVaLqikU36jhj1A4dOH8bgtHaag6Ph0SgpXUIbYaojF08fyZA0VuNGvd/6BRHkOhX
         Fkv0iZQ/5Dehe9qcUwNnUkvhwpCdL7tjPm3fWKo8POpw0tPi4wS++DQpNdSC0wvREuzs
         iPDnS7YvfdgCzy/3PBme6kEU/tGnLiDD7WHZw188oR0+qMOLR3xhAcd4NijCJBHE7ytv
         gJ23XT4+RH+ss945HdXMIggYe/ztEn7eKKVkJpRD41P/Tb9Mw32DWrycP0NnFAC5UYr/
         nT4owGRCgWxf9bXMl6sxFU9HBFsJ9oOTX/2qAQrB2PeCtrk5qtgpdw7MqiNxGDV4y8FD
         X9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=oKYe7AbRdgVEW/SANKAs5haVdcr7sWgF6qR0TOl7CFA=;
        b=s+TZFkfdBO5/CYH80DL/LnYukY3VsbIVceJubXmXP8rLi4RNSK8Ru6zZlCcTkD3M0D
         hDxNGjtSglkoQ5PNc3dgbeI6UKS+AQohon2lBPpfeQZBFzCBPzf7umKkw6lz+pNDaDKj
         EoByNl90GWRDHLSNre9dFxLgfbXkVhvbRuZO7mvVJ1d12qNpWlcbabiSC2TqroGPb9bu
         hrmbNr0hhoZhNvesP/JYt2MBf1KD/EO3o8cwaLqAQGpY00qt3qDGm3uAx9NOD8Qw1pYu
         kqVMht64e+eEzxWhR6jF71oHPLWJz+4GAqLIz1IpKkKVMLE4+jhzg9id1cCkHGUmwk8h
         d2aw==
X-Gm-Message-State: AJIora9C+uG98miJx2KBqvwayrPHd6wGXGOvsJtKHMTq9AQN2eqt/hOW
        Fn7t0Rb/Cu20RH+WoEGW3//3vfzuxTXkUg==
X-Google-Smtp-Source: AGRyM1tWJGs3avV/brergo65kWANuqJO7WzKiLb2HtkjNdtbzRXZIEDYRoeN0iFN1TpF9SvaxLPBRg==
X-Received: by 2002:a17:90b:1bcc:b0:1ed:361b:702a with SMTP id oa12-20020a17090b1bcc00b001ed361b702amr6903521pjb.1.1657383042514;
        Sat, 09 Jul 2022 09:10:42 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id u17-20020a170902e5d100b0016bea2a0a8dsm1526795plf.91.2022.07.09.09.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 09:10:42 -0700 (PDT)
Message-ID: <44c1e78a-ae48-775e-0329-c954c7b04a80@kernel.dk>
Date:   Sat, 9 Jul 2022 10:10:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 01/13] block: add bdev_max_segments() helper
Content-Language: en-US
To:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1657321126.git.naohiro.aota@wdc.com>
 <b4401816e33a90b1f05a1e32b420f073a8438591.1657321126.git.naohiro.aota@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b4401816e33a90b1f05a1e32b420f073a8438591.1657321126.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 7/8/22 5:18 PM, Naohiro Aota wrote:
> Add bdev_max_segments() like other queue parameters.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

