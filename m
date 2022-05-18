Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A3B452BBE2
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 May 2022 16:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238463AbiEROHm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 18 May 2022 10:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiEROHi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 18 May 2022 10:07:38 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9531B6A06C;
        Wed, 18 May 2022 07:07:36 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w123so2754323oiw.5;
        Wed, 18 May 2022 07:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=44Xgt+EUBiutauBulnIHgR1NZC7VLz+1d73CrLpoSuA=;
        b=EE+Ok5Q3AOQEWrEsMLQ8bJwxLj5JWKC0uRQavySm46LGHksaEXSJblszKsh1MvsIVQ
         sDPRJcb4u60eXiklTNwE2U+LD49Wb+WD9qcumnXXeQJnMUEh+Cprmc8yCFMWDDAx/laZ
         tSGFznxKpbQzHqnKFUn6Obmd3DZeEhLOmDwgdK5v2kgO5opVsh+5I61QnC6uyCbqRb+P
         h2C/Fnjhf4h05p6b5Q8AMg4jSgBqBTEFQHak8Fh8GP7YqlfCZ9bfj2PBgjyDMGe6fFi6
         v1tCilE06OSMQ2Ap/40R6GV7SfyLOFpw0XtrB50yxlMyw4CFBhcTVnu1K1CJBROjIYsQ
         b0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=44Xgt+EUBiutauBulnIHgR1NZC7VLz+1d73CrLpoSuA=;
        b=UvfdYzjaYNc11S6u5pZoZfkmF/3HNP2jxVLuKGEQJVMnQoa+MW2GEQ9MMyNUkY+Beh
         AJpCWk83cmRQY4KVLLhvTmXGxF4/jWaTrcZFs6dwjsmiOCYMNDifYk5+KFYPK9li20xS
         I3SHfizt58K4XB+7BEYZbGDv8wUdG2Y5uQxWmsq2AetTH6L5VtSQVKmamYrygKvX0Upd
         ehPXl40FAFzdPuIBdGINGXEMmozi8gmLC0CB6IeIoJEn/d8pfDWxvdTFKjmek3jL1CtO
         vMtAieiQ+SjClo9GEne2eV1BVxLd+zbZGfKub0UnjOOscpAb1yylTb/hTGdtM7gbZI31
         IeWw==
X-Gm-Message-State: AOAM531toroo+wgroA7WY1g/hs9utoSpfBOQK+aNJ7lyFbD/R5UHexPd
        CroNBrkDLgVB6sXEVvuT00Y=
X-Google-Smtp-Source: ABdhPJyXPBsJSPb3qsIt30kakP/1viqje/dN0om/JEDZ69uJP4Erfc4CCzg7BfUTauTabr0j1dC5fA==
X-Received: by 2002:a05:6808:23d2:b0:326:979a:46f3 with SMTP id bq18-20020a05680823d200b00326979a46f3mr12917oib.207.1652882855862;
        Wed, 18 May 2022 07:07:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v8-20020a056830140800b0060603221267sm782203otp.55.2022.05.18.07.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 07:07:34 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <47c64195-6629-ba2b-4533-b0fe37518da0@roeck-us.net>
Date:   Wed, 18 May 2022 07:07:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, Hu Haowen <src.res@email.cn>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220228103142.3301082-1-arnd@kernel.org>
 <20220516131023.GA2329080@roeck-us.net> <YoJSF8T5K9pPx3Ap@kroah.com>
 <9510474d-5555-42b3-5a9c-90e3078df499@roeck-us.net>
 <CAK8P3a1GmRqPTXFCoLH9h1sP76a-bVRsGYP-YvczoXM4Na3OVQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [greybus-dev] Re: [PATCH] [v2] Kbuild: move to -std=gnu11
In-Reply-To: <CAK8P3a1GmRqPTXFCoLH9h1sP76a-bVRsGYP-YvczoXM4Na3OVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/18/22 00:46, Arnd Bergmann wrote:
> On Mon, May 16, 2022 at 3:19 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 5/16/22 06:31, Greg KH wrote:
>>> On Mon, May 16, 2022 at 06:10:23AM -0700, Guenter Roeck wrote:
>>>> On Mon, Feb 28, 2022 at 11:27:43AM +0100, Arnd Bergmann wrote:
>>>>> From: Arnd Bergmann <arnd@arndb.de>
>>>>>
>>>>> During a patch discussion, Linus brought up the option of changing
>>>>> the C standard version from gnu89 to gnu99, which allows using variable
>>>>> declaration inside of a for() loop. While the C99, C11 and later standards
>>>>> introduce many other features, most of these are already available in
>>>>> gnu89 as GNU extensions as well.
>>>>
>>>> The downside is that backporting affected patches to older kernel branches
>>>> now fails with error messages such as
>>>>
>>>> mm/kfence/core.c: In function ‘kfence_init_pool’:
>>>> mm/kfence/core.c:595:2: error: ‘for’ loop initial declarations are only allowed in C99 or C11 mode
>>>>
>>>> Just something to keep in mind when writing patches.
>>>
>>> I just ran across this very issue on this commit.  It's an easy fixup
>>> for 5.17.y to make this work, so I did that in my tree.  If this gets to
>>> be too much, we might need to reconsider adding c11 to older stable
>>> kernels.
>>>
>>
>> I think I'll do just that for ChromeOS; I don't want to have to deal
>> with the backports, and we are using recent compilers anyway.
> 
> I think it would be better not to have the --std=gnu11 change in the older
> stable kernels by default, as this has introduced build warnings and other
> smaller issues, as well as raising the minimum compiler version.
> 
> The users that are stuck on older kernels for some reason tend to
> overlap with those on older compilers. One example here is Android,
> which used to ship with a gcc-4.9 build as the only non-clang toolchain,
> and was using this for building their kernels. If someone wants to
> pull in stable updates into an older Android, this would fail with
> -std=gnu11. Others may be in the same situation.
> 
> Changing some of the 5.x stable branches to -std=gnu11 is probably
> less of a problem, but I would not know where to draw the line exactly.
> Maybe check with the Android team to see what the newest kernel is
> that they expect to be built with the old gcc-4.9.
> 

I don't think they still build anything with gcc. We (ChromeOS) only
need it for test builds of chromeos-4.4 (sigh), and that will hopefully
be gone in a couple of months.

We already enabled -std=gnu11 in chromeos-5.10 and chromeos-5.15.
We'll see if that is possible with chromeos-5.4 as well.
We won't bother with older kernel branches, but those should not
get many patches from upstream outside stable release merges,
so it is less of a problem.

Guenter
