Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34AE5EE4D7
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Sep 2022 21:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbiI1TM7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Sep 2022 15:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbiI1TM5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Sep 2022 15:12:57 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3AD9A5984
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 12:12:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id g20so15387057ljg.7
        for <linux-btrfs@vger.kernel.org>; Wed, 28 Sep 2022 12:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4eSS1PMQMwoHIQyfUXnv2ELR2DtWjtxas+T5OsBz7zo=;
        b=nsFfI9DmCGm+fDwqR4Zb2BqDCfl++fV0LsCYbLwj/1onkHofAcZhqjGPbjm8pcvjHG
         n9YJ3H4axKM/opNaPFo0aEmrlM5pJH0H3gc3jMddYinkUGVpK57p9FEQrVlwrw7xRrea
         F3wr9uXS5IVoJkCvYOCg3Mit++iAk+9f/AUn70ipWAZMjMuKkp8ykrtrgaDhSkVX0Oqn
         YUx14PKu1kgFFkqWHrW0jiEwR8jDBQwGCM1poFZeJNILtg0RKFK8nSlSxr8PZ/TKG5il
         T/Bzn21uqxUg+mxBHsoEG8wVwhw1/SKovuJdENe2KmKhE62/astHNJfZ9x0uPVa9dwLw
         Aklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4eSS1PMQMwoHIQyfUXnv2ELR2DtWjtxas+T5OsBz7zo=;
        b=6IzsX3PvTmoHYwBl1ZaokzDzMX5KfYR7ezsr9iPqP7JBX/pkRU90XLy1OxMEoJ7MyB
         SuiaBfDnftaXt3U+wV0Og7KiZWp82NS/MbGPqlgBWbpXRlZMnjIY23AjcEy1IRgNdlEb
         kPol4ZKrb8WbrjBK4dJ84qSYmBGtFah8B41cJRFMLCNIj06+jdccyA0pabPLrcn8Adp+
         ig18I+gErgwVsMUmvnRzPl9OHM5FinscMgvKo/2jLdaMTWJDtkfUxvaTjxWLS4crwSCm
         txGVkVq1ZgFMkqbgwjOJQxNcVFwgPTUNXKpXYSJqH3MExqmWyhXwZxIgBd1S74Ha10yn
         hEdA==
X-Gm-Message-State: ACrzQf0TeomaVruGtF0RKM64GHAyyVC3Z23Bjc3uSrBIGVuaxJ51cf0A
        ibzOixeUqqr9wJrEFC4XnQDbKme56j0=
X-Google-Smtp-Source: AMsMyM6n10n3Cq2sVDQHrIhJ5OBKZfPi0Z7gwg81UGegI4g5PrlrUgAXFCLBPZL2BBzfmiTJSUoDzw==
X-Received: by 2002:a2e:a0cc:0:b0:26b:e763:27d2 with SMTP id f12-20020a2ea0cc000000b0026be76327d2mr11833973ljm.62.1664392370271;
        Wed, 28 Sep 2022 12:12:50 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:c82:b5e6:8f1c:91ab:35b? ([2a00:1370:8182:c82:b5e6:8f1c:91ab:35b])
        by smtp.gmail.com with ESMTPSA id p2-20020ac24ec2000000b0048b3926351bsm553562lfr.56.2022.09.28.12.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 12:12:49 -0700 (PDT)
Message-ID: <ed497bfa-1f82-6761-788e-a20ef3b91cab@gmail.com>
Date:   Wed, 28 Sep 2022 22:12:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: btrfs and hibernation to swap file on it?
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        linux-btrfs@vger.kernel.org
References: <31660c315eeba4c461b6006b6d798355696d2155.camel@scientia.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <31660c315eeba4c461b6006b6d798355696d2155.camel@scientia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 27.09.2022 18:45, Christoph Anton Mitterer wrote:
> Hey.
> 
> Maybe someone could help me with that question:
> 
> I'd like to set up hibernation, using a swapfile on btrfs (which itself
> is on dm-crypt).
> 
> Now I'm aware of the section on swaptfiles in btrfs(5) and their
> restrictions... and I think these should be fine for me.
> 
> 
> What I don't quite get is:
> 
> a) Hibernate seems to want an offset parameter for the swapfile. How is
> that used respectively why is it needed.
> 
> Does that mean that hibernation directly writes/reads to/from the block
> device?

Correct.

> And wouldn't that be kind of fragile (if something internally moves in
> the fs... or if it's split in several extents and not one big
> contiguous space)?
> 

There are quite some restrictions for using swapfile on btrfs, in
particular, it must be preallocated and btrfs will refuse relocation of
extents in this file.

kernel supports swapfile with multiple extents.

> Guess I would be kinda scared to get some corruptions if something
> writes directly to the btrfs' block device - other than btrfs.
> 
> Are there any suggestions with respect to btrfs? Like not using a
> swapfile for hibernation, or is it considered safe?
> 
> 
> b) Internet resources say that for btrfs one cannot use filefrag to get
> the offset.
> I found Omar's tool, but wondered whether the same had been directly
> integrated into btrfs-progs in the meantime?
> 
> 
> 
> Thanks,
> Chris.

