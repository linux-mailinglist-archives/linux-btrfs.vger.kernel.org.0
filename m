Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A066DC286
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Apr 2023 04:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjDJCDn (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Apr 2023 22:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJCDm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Apr 2023 22:03:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7495F2D79
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Apr 2023 19:03:41 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id gw13so2150005wmb.3
        for <linux-btrfs@vger.kernel.org>; Sun, 09 Apr 2023 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681092220;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U8+HYCJGCwTXkdKfc3wbjzMmuJZ78fDXX1DXuZa8+pA=;
        b=Zn4L8Zn2SGkDhaCmjspN2hXev2E6AivTG9yp/AkqbFj/ciIiDBLGicGYRMEnGil75R
         YjKuoti73ybffs4oaLBVBVepWt0qaakppp6FBpAjBLJA34kdvSA/mZnXo52baJUgCaWM
         dBPEzy1OP8KkUOEiXkOEmnRnWPq0F9xpvhDXQKoIjXpa71HB4Ha7fXjIGwlHIiEdsqiW
         d5lQ53RL6Gzh9oTwdxxCDwpC27i4z1Tdko0XbKvqrQhbDVOhQ5aLLQ/GoP2HoeNXrsBd
         z4ajIOPl/peGLoxb48GJZNLj7vuBngGoMIRABOiCRO7sVPs/zRDoZStp0PVkFXvy2T6u
         leBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681092220;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8+HYCJGCwTXkdKfc3wbjzMmuJZ78fDXX1DXuZa8+pA=;
        b=LYgqqPvefr3wMXIJXjekkPLaqRyuycV9hJGpwDRpIngvKuOjUgl9VexrzF+/K1aKb9
         +Ga31wKA6VE7KwmRRxM3e1qI7YDvRjD2v27GKyERfu06vjaK512M5Sdi7fm+Rs4Wmyqb
         ReCIR7QLg3l9n5jjav9hdXkMRwn0msSN/yF3TSeWisKas826DV9UlJ52pewnYDBuUkLS
         XIkGWAMZLaT74JWPsFzasn059nkd+s9e1hd9xUN4d8og9UzQRLJ2lMaLxznj/dudf7XR
         OnPMg/fDBArfzlRvwwq3zhafpeQmowDzRgbb2iiVayk9BkBbAgnKcIqgOXVp7hQfN9tz
         VnfA==
X-Gm-Message-State: AAQBX9fMLmy10BS/nX4l4yy+ynA614ngiGt5DAuu11oHvw9y6FiXZo44
        5pjmahOkRgJO9a3kiIelGBrzYr8foKzb3K7i
X-Google-Smtp-Source: AKy350Z/6Wz/AaSZAWSycWD7855m1cvAvEDlrhAdjGi0OyoFQMG9U4z1AiTpp3NxUPX0q4Fa8tmEXQ==
X-Received: by 2002:a7b:cb4e:0:b0:3f0:7f07:e617 with SMTP id v14-20020a7bcb4e000000b003f07f07e617mr5088932wmj.8.1681092219869;
        Sun, 09 Apr 2023 19:03:39 -0700 (PDT)
Received: from [10.32.180.129] ([148.88.245.129])
        by smtp.gmail.com with ESMTPSA id f3-20020a7bc8c3000000b003ee10fb56ebsm12176018wml.9.2023.04.09.19.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 19:03:39 -0700 (PDT)
Message-ID: <6a54fa77-9a0c-8844-2eb0-b65591e97a16@gmail.com>
Date:   Mon, 10 Apr 2023 03:03:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Michael Bromilow <stick.insects22@gmail.com>
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
To:     Boris Burkov <boris@bur.io>, Chris Mason <clm@meta.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org> <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
 <ZCxKc5ZzP3Np71IC@infradead.org>
 <41141706-2685-1b32-8624-c895a3b219ea@meta.com> <20230404185138.GB344341@zen>
Content-Language: en-GB
In-Reply-To: <20230404185138.GB344341@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/04/2023 19:51, Boris Burkov wrote:
> On Tue, Apr 04, 2023 at 02:15:38PM -0400, Chris Mason wrote:
>> So, honestly from my POV the async discard is best suited to consumer
>> devices.  Our defaults are probably wrong because no matter what you
>> choose there's a drive out there that makes it look bad.  Also, laptops
>> probably don't want the slow dribble.
> 
> Our reasonable options, as I see them:
> - back to nodiscard, rely on periodic trims from the OS.
> - leave low iops_limit, drives stay busy unexpectedly long, conclude that
>    that's OK, and communicate the tuning/measurement options better.
> - set a high iops_limit (e.g. 1000) drives will get back to idle faster.
> - change an unset iops_limit to mean truly unlimited async discard, set
>    that as the default, and anyone who cares to meter it can set an
>    iops_limit.
> 
> The regression here is in drive idle time due to modest discard getting
> metered out over minutes rather than dealt with relatively quickly. So
> I would favor the unlimited async discard mode and will send a patch to
> that effect which we can discuss.

Will power usage be taken into consideration? I only noticed this regression
myself when my laptop started to draw a constant extra ~10W from the constant
drive activity, so I imagine other laptop users would also prefer a default
which avoids this if possible. If "relatively quickly" means anything more
than a few seconds I could see that causing rather significant battery life
reductions.

- Michael
