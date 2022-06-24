Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E52355A001
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Jun 2022 20:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiFXRyP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Jun 2022 13:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiFXRyN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Jun 2022 13:54:13 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB61B31
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 10:54:12 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id d129so3053666pgc.9
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 10:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=Iz4uiqh5TjTNO+sQLTfuL1na+fsrLGeg6LLWb3uQqhU=;
        b=aRoC5MN1CT0aR23WxLfzsJ5j8HMz7Z7GSyAr4f95PXlvx69r902PTTYM9xb9nuQgZR
         bKNGaMLW/n/U4GSqAbuNbH3Jf/w2Y+BOELBsA/dlziSXZ4wYndtmYENvtAlFhxrnX3p8
         TCX21ka1sPVVONt0vW6FndqHjuEcXEWvwtDZN2Ixf5dZZd5TUAvXUK2fmD8eVUn9dZu6
         8WTSV3I0hzWrFAdLyrJ7lpcbKfSt/dH5jNk/qA/kVS+uk479xJX6AV/K4cfmqk6vxJXJ
         gBxRqRebGBm7FCF68MvbypHMeph5dLR9BsqCa4t6Yiyx3MaUJaBfDitFvm1p2dOU0eoL
         w2mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Iz4uiqh5TjTNO+sQLTfuL1na+fsrLGeg6LLWb3uQqhU=;
        b=3DeBDQfgk5Lx1fijDsB9y4H/mrU69fhJU7e63gAxhfCkBm9/H9++teueJ2gM5KIS1j
         KQ1XoozyE8PotrMiHeMfFJciJ1S8RXqBEORgNKVc7xcAWGfL4ZCT/CSMdEymj7PnyqZI
         eWzshcfGySqoFuw7eWvlTFlkyl4BnOGo4gp0Zf8fXYc/WxQtuMYu4sV3Qt/nwB/wEUI/
         LfVfrNHRm2xIa6V4i4XhTNuJzS1M91B7rMKUGutATtDu8OVMONEgCNQfEUVRrjbpYyHo
         sFaRBfHEm07XlET8h1NaafXmpkFFTCF+VQDBD8XX9ejBxoVj93Ud5XbjdDXRsT/BwljT
         2v4Q==
X-Gm-Message-State: AJIora+rF4aehNFQd8sJsN5OWhxB6H8DLl9VSAkfy7Qk+VmYE4heMpUE
        ufxVSE3zw3mt+tc75VTHfYL8sToC6TE=
X-Google-Smtp-Source: AGRyM1u6UcvYW7jqXYP/c52mJbbtXPfOdtodQ+kZIc7V5d3Iv+dNZzk9cZbRE3Ym05nag2kgL6SVFw==
X-Received: by 2002:a63:7909:0:b0:40c:6cba:b1d0 with SMTP id u9-20020a637909000000b0040c6cbab1d0mr37636pgc.353.1656093251947;
        Fri, 24 Jun 2022 10:54:11 -0700 (PDT)
Received: from ?IPV6:2601:600:9c80:6570:dabb:c1ff:fe0f:3e57? ([2601:600:9c80:6570:dabb:c1ff:fe0f:3e57])
        by smtp.gmail.com with ESMTPSA id k3-20020aa792c3000000b005252680aa30sm2032035pfa.3.2022.06.24.10.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jun 2022 10:54:11 -0700 (PDT)
Message-ID: <9a185ec5-45e2-3c7a-5e56-3c45e413834c@saikrishna-Lemur>
Date:   Fri, 24 Jun 2022 10:54:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Memory not shared for files opened from different subvolumes
Content-Language: en-US
To:     =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        linux-btrfs@vger.kernel.org
References: <b8011afe-fb24-3349-30eb-182a8792c67a@saikrishna-Lemur>
 <c0de2bb7-0a4a-4ab1-ad6b-9a435bf6802c@applied-asynchrony.com>
From:   Saikrishna Arcot <saiarcot895@gmail.com>
In-Reply-To: <c0de2bb7-0a4a-4ab1-ad6b-9a435bf6802c@applied-asynchrony.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 6/24/22 09:03, Holger Hoffstätte wrote:
> On 2022-06-23 23:36, Saikrishna Arcot wrote:
> 
> [snip]
> 
>> My question is, is it possible to share the physical pages for the
>> same file from two different mount points being opened? This would
>> reduce the physical memory used in larger cases.
> 
> Not an immediate solution but more background info on the problem and
> some ongoing research: https://lwn.net/Articles/895907/
> Hope this helps.
> 
> -h

Thanks, that's extremely helpful! I was primarily wondering if this was 
being looked at, and I'm glad to see there's some work being done.

-- 
Saikrishna Arcot
