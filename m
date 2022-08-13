Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AA159193F
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 09:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236310AbiHMHaf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 03:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiHMHad (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 03:30:33 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55047B8C
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 00:30:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s9so2834659ljs.6
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 00:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=oeBEOD3iBcZG40s1J0OXMz7xVA/nfJC4j+rkJNGKeJ8=;
        b=JGhRJklm1OJ2Bphp4uFuwDB0XCHNFU5eT7hr4g2AmnT/zP0hud0aFw5jSI/m/jjaul
         LeQrD32cjKkrENoI0iTh1k3hi5Y/YZRrBytb/9bZZywgBztM8qC1yfc2bQQn0rfwWrqq
         30h0CcWDh9DufJ3DTgtOcJN4bsf4VIvHyGxzAgJDxoyCK0OreOdP65wbg3aChqgmwPBI
         UYkmyK54Zrf3xz6uY3WO5n/hwnTVEcs9Su8xoZ/pKNqrfW0kqSEJpscs0QxxRF8EUpZK
         loEvtiMnwbEC9wUg+kmIIJH0dSOwiIjpfrmdVVZjJfnHT6oUCbsd2YwglBnqi3eZdZW9
         bgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=oeBEOD3iBcZG40s1J0OXMz7xVA/nfJC4j+rkJNGKeJ8=;
        b=Abqm8J0S7v99jw4PTdzacD9LQef7ntyanRBBVOyCFg3gFT19t3i83RTwPtl59j005N
         IpXP7fc4xhlRhMy8R9ji3vqNV/bgRuq05lNWMmt/sS5vowYJvSCvWhavnF3BgrCv4JKa
         Mg0ekS9dRnZmHEOlJfGyoFhgkFZTcgVwFEoP/jAoNx2K25RFrnZaVIs8udNiV8gG9Qzs
         oh5++ghPj8hHub78exlnYFyUzMpi1ahc1GX9HLQoKAAOVjeCugl7HhpafMdM3J5TZcSh
         KD7X+hRuhrgC7OSNkCcIyDVJBi/6baRqwCHqeK3jamM+7MV0hkLdKeu+lX8SHCkxeFWI
         T+pw==
X-Gm-Message-State: ACgBeo1fXngbwxi8bIH+iBP//VU1v3aEeZMqmLwbuj4xKZ6TuFyJX4Qq
        VQpcobyb0/pxli4F+zIe/2XPLM1yQMzFBb4Q
X-Google-Smtp-Source: AA6agR4NeWNj33qj9fWVGOG5B+Qx3T+uSjm12IRdZ8P6yyrk9DWmBRvwEO4Y8q/n8xmHAFi9EiLscw==
X-Received: by 2002:a2e:a411:0:b0:25e:5ff0:469 with SMTP id p17-20020a2ea411000000b0025e5ff00469mr2038990ljn.149.1660375829535;
        Sat, 13 Aug 2022 00:30:29 -0700 (PDT)
Received: from [192.168.1.109] ([176.124.146.177])
        by smtp.gmail.com with ESMTPSA id r28-20020ac25a5c000000b0048ad0ad627asm466312lfn.128.2022.08.13.00.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 00:30:29 -0700 (PDT)
Message-ID: <ab7c756d-c045-bb0f-155e-8ba94ffaf6d7@gmail.com>
Date:   Sat, 13 Aug 2022 10:30:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: du --bytes show different value for btrfs and e.g. ext4 with
 identical data
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <533edd660d632b46a0cc6bde07276f07435a84de.camel@scientia.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <533edd660d632b46a0cc6bde07276f07435a84de.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13.08.2022 03:11, Christoph Anton Mitterer wrote:
> Hey.
> 
> Forgive me if that has been answered before, but I couldn't find it on
> the list or the manpage.
> 
> I have my personal data on several backup disks, all of them except one
> (which is ext4) being btrfs.
> 
> The data on them is 100% identical (diff -qr --no-dereference brought
> no difference). On the btrfs, the whole data is always in one
> subvolume.
> 
> 
> Yet, when I do:
>   du --bytes (which implies --apparent-size)
> I get (in my case):
>   5035634863728 for (all the) btrfs
> but
>   5035836693616 for the ext4
> 
> Which is some 192 MiB more on ext4.
> 
> 
> Because of --apparent-size, this shouldn't be any refcopy or
> compression effects; also hardlinks shouldn't matter (and are the same
> on all of the filesystems anyway).
> 
> 
> Any idea why the results are different and shouldn't they be the same?

You did not show your actual command which makes it impossible for
anyone to reproduce it. But my guess is that your du invocation includes
size of directories which is different between different filesystems.

> And if not, would it make sense to have this behaviour added to
> btrfs(5)?
> 
> 
> Thanks,
> Chris.
> 

