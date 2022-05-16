Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691895286CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 16 May 2022 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240636AbiEPOT7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 16 May 2022 10:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiEPOT6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 16 May 2022 10:19:58 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363993AA6D;
        Mon, 16 May 2022 07:19:58 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id n24so18724392oie.12;
        Mon, 16 May 2022 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Mpj75KaCiBDC1z0Gq3wmQiK0bCjZ+/g+r2qV0jF0QRs=;
        b=h7hGFYuETN0Js7lA4HRVafJbtT3J3KaiOp2PQl9zOveXQ58rogRbhMTVG+EEvFEUGm
         mgiDgExHRSy3NmnDXGWIG/eqz8sOxhVtpQ6zdEtd6pXK3aHPuSX8NvSDLFQn8q3SxzKn
         qPbJoCpOhtLyQtknnmObrNRPcp65M/9lc5+nMQH9EZ6DJ9zvyrxEPJUqB4ZpHgN65UT/
         pZ6wxDTkwgT5vkbieo6BPojGLMCZK/KMf51dzWWT6GmojtBDWnBo2DB6cb2VCY+ARVbR
         DGTOsgB1Jn3+eY0XLFzfo/yyoRwisMfFzPLHaOR+iwIgr/tYqlQaBS1PasQQKYWGO8WS
         WSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Mpj75KaCiBDC1z0Gq3wmQiK0bCjZ+/g+r2qV0jF0QRs=;
        b=c6gEg18svntrKpDEkI+bVp1NjN660QCV2DBcKIwrNDMO+GSyn0EOJRdh5ezXeGsg56
         3H7/qiH4tXWtSwi24VE+CZqnaeg7KKdzMJPahmv3q6mLjOaiAoM8QXRH5YTQvHODdX7W
         jnGa6FI5LxiNo60VBv+4ZrxWM0pP7XaDnOITN1pYWEnkDOy50gLVu+461Q6TmNINnQvT
         C3UawnXAbPn9tOHswBQzM4IUlq0L4XjxcyJHYi43dDqa07azurKycR0sVEEg6ZQ34pW9
         eBgBQPgjbDt5P/X+IDJyptzUSY9BtUS8no3Hu4++ZPFdHi2tu4b+AErgV6f2RxNHYus/
         Mljw==
X-Gm-Message-State: AOAM531aHd1fxlDQIIdCpWiitYYCpb767rojc69tmyyBTUlNDsupgyq7
        zg5OoYqVvUZwdwC6s/A4tAY=
X-Google-Smtp-Source: ABdhPJzHIEB8K5ECnXXfF0FVsk0B1nV5R/BR/kSU8cshU+jwA1/3rjPaKr6PQiWtdpcKDnk1QewaaA==
X-Received: by 2002:a05:6808:a11:b0:325:e5c1:5912 with SMTP id n17-20020a0568080a1100b00325e5c15912mr8321388oij.204.1652710797515;
        Mon, 16 May 2022 07:19:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i1-20020a9d6241000000b005b22a0d826csm3916917otk.1.2022.05.16.07.19.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 07:19:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9510474d-5555-42b3-5a9c-90e3078df499@roeck-us.net>
Date:   Mon, 16 May 2022 07:19:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [greybus-dev] Re: [PATCH] [v2] Kbuild: move to -std=gnu11
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kbuild@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>, llvm@lists.linux.dev,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-btrfs@vger.kernel.org
References: <20220228103142.3301082-1-arnd@kernel.org>
 <20220516131023.GA2329080@roeck-us.net> <YoJSF8T5K9pPx3Ap@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <YoJSF8T5K9pPx3Ap@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/16/22 06:31, Greg KH wrote:
> On Mon, May 16, 2022 at 06:10:23AM -0700, Guenter Roeck wrote:
>> On Mon, Feb 28, 2022 at 11:27:43AM +0100, Arnd Bergmann wrote:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> During a patch discussion, Linus brought up the option of changing
>>> the C standard version from gnu89 to gnu99, which allows using variable
>>> declaration inside of a for() loop. While the C99, C11 and later standards
>>> introduce many other features, most of these are already available in
>>> gnu89 as GNU extensions as well.
>>
>> The downside is that backporting affected patches to older kernel branches
>> now fails with error messages such as
>>
>> mm/kfence/core.c: In function ‘kfence_init_pool’:
>> mm/kfence/core.c:595:2: error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode
>>
>> Just something to keep in mind when writing patches.
> 
> I just ran across this very issue on this commit.  It's an easy fixup
> for 5.17.y to make this work, so I did that in my tree.  If this gets to
> be too much, we might need to reconsider adding c11 to older stable
> kernels.
> 

I think I'll do just that for ChromeOS; I don't want to have to deal
with the backports, and we are using recent compilers anyway.

Guenter
