Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14877617574
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Nov 2022 05:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKCEUO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Nov 2022 00:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiKCEUB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Nov 2022 00:20:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD610DF6C
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Nov 2022 21:20:00 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r12so962493lfp.1
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Nov 2022 21:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1LP68xf0w0DDXINs+YGv55KPsghGaBfkeaNFKrRq5gg=;
        b=ZpngUQgeb1tsmnLlFxmQSiMWHzHopWd+s7SVSmCGR+hPMdlOL5AFck7N6SF7WPKW37
         QkVWh/f2iDHrcoFpdiED5We01c1NtJQf1wG23NW/dgcc89Z7HzhnN2rvHHnQczqL/wJL
         UnQrbtbEJVQ10I54qbjHdazdEKbB9AUE/NYhWdoxI3x/tybnkOcbmbUlhVt0yknPCvvn
         6WZ33pGiI0OrNwJ4/Tr7V32ufIIDSo2D4Vjl9oyasmTFlcjcKB459002L4iqVxCm8T9A
         BvTtbGxOKBxrCd8lUiPuHg9sijdmaUv5KpP6JlUSeQnt/AFK/gcekazE9vKSOsB92j7B
         59Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1LP68xf0w0DDXINs+YGv55KPsghGaBfkeaNFKrRq5gg=;
        b=pz8BBwc7QGvh5rE85R1BhCQ3qbZqzmttcmzp5yoIvtPqq2cXxsLGqnlJv/B6ZFQdPp
         N7j9u1xAP+le87enSV/wDrs8VL6+ZRtAGX5nl0Y9/GvDxllyxZxjjBrYsVO3PXOUrF3U
         WTFtUmmn8Sjf1jwqGmhwqF7rzqfDyUii80/LNjwNO4S2vjOYoBbXv34kermqhb/5giW3
         ocyoSJw98WYca5uNoHhltlqPt8nMcDaK3MIaz+8xQtZWT6Km8fPB9SORL+LYFNc6qKto
         pe5kIg7pLehALNbRHXyJx7SeFJM7W7hTAJo0nYryUBLrHEr+H9tvNfkHLA26J+PT0ltg
         upCQ==
X-Gm-Message-State: ACrzQf0JIIwjUpIcCaNMGFp1NHfNMhyUGBCu8lo0l6hMnX7GNAcTbgw5
        HZC/kSEKmsOTN/QTNqC9oUf5W4D52ng=
X-Google-Smtp-Source: AMsMyM7qaShnFGa8YdAXo8Ppn+sgbBHNxr1yFFFmJzQ1msDpX1W6DBSGP2Wj1fh9aW4po3HLk5c31w==
X-Received: by 2002:a05:6512:32c9:b0:4b1:4dce:4c8c with SMTP id f9-20020a05651232c900b004b14dce4c8cmr2538852lfg.42.1667449198907;
        Wed, 02 Nov 2022 21:19:58 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:683d:a0cf:38fb:ebbd:d5ee? ([2a00:1370:8182:683d:a0cf:38fb:ebbd:d5ee])
        by smtp.gmail.com with ESMTPSA id v12-20020ac258ec000000b004a619367dd9sm2243778lfo.66.2022.11.02.21.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 21:19:58 -0700 (PDT)
Message-ID: <0c66a75a-2cf6-2944-4423-7183804c7ad2@gmail.com>
Date:   Thu, 3 Nov 2022 07:19:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: How to replace a failing device
Content-Language: en-US
To:     Matt Huszagh <huszaghmatt@gmail.com>,
        Roman Mamedov <rm@romanrm.net>
Cc:     linux-btrfs@vger.kernel.org
References: <87v8nyh4jg.fsf@gmail.com> <20221102003232.097748e7@nvm>
 <87v8nw3dcg.fsf@gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <87v8nw3dcg.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03.11.2022 06:51, Matt Huszagh wrote:
> 
> Not sure if it will help, but I'll update my Linux kernel version, which
> I haven't done in a while. Still curious why scrub wasn't helping
> though.
> 

You have RAID0. Scrub cannot help in non-redundant configuration. Scrub 
can repair bad copy of data using good copy of data, but in RAID0 there 
is only one copy.

