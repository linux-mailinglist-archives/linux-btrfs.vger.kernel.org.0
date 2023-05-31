Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B356718052
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 May 2023 14:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236005AbjEaMuE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 May 2023 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235967AbjEaMtY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 May 2023 08:49:24 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFCF10C0
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 05:48:51 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d4e4598f0so6384392b3a.2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 May 2023 05:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685537328; x=1688129328;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D9KyF2Ca9y1NqSCBsW6Rtxm8i1hv9DBV1RFCtJ4iwl8=;
        b=bLdWyv94xfPcRt80wrldvlYxXaIjevRKSWJineupIkZjPQr++1Y/9K0IgYWTkqLpLr
         8LoVf9400HSb25sZkuYoOkvGa/7Kqi72EVnk9CrFW41oF16nFZqmRsbbDzg1/Jaej0vN
         daDaG2y4ZThIwBMEviHSts4r9UJUZfm0KgoKf980mmsp84Qhte91mVgzZZcBH0Y9SV7G
         dXmdsTE/exkHVCrjENur5ZjGnyJqys5l37nbN0yktQy4maPUkOxWVXVXt9wsZMqSHEjv
         F7uBqXW9+b01dt/vTchmNtRtIb637/c1e9J5UPxbeolXhcJerXoZkSO44fw4onxUM3Zx
         rubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685537328; x=1688129328;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D9KyF2Ca9y1NqSCBsW6Rtxm8i1hv9DBV1RFCtJ4iwl8=;
        b=bZ4e5nJT8w1vCnsM4nKRyBsc7iNOKUwsBq9QtmQcqpIOuJtYLbB9qk6Hk5BcmybFG7
         rPW6a2u2fLzL73UIAsf88RrskN+0HTHyVx9Twczy2liqsoSGcsJbUEtUNzeCPw8vFVHH
         nKceA5wumJkUvYkcWywfBR/cNSn9BKJ//bk3VS7rpqFnRDo4FbbdT744fCumC7fCFRfQ
         55mb0oW9Fi/gT1NFr7J7nO9Qz/ud/SP45jJfShmbMxS+9LzxNfPUqeiJ0cTSBrRKoBbi
         ZXZKQYExPfdzajd8xsdA/uRPc2rZp6zMWpF9SwE26+BoE4llUWoSfdqgRSbZD/gw0KKh
         gJIw==
X-Gm-Message-State: AC+VfDw+b188/CsZzUo8ab/FcuNHBAzTlF/ko7ppbV2FYFD8duzGfTKg
        yXfRsvQLye/x/7xqT32KnCU=
X-Google-Smtp-Source: ACHHUZ78XvfMqB5j/2M6agRigDyNkjMmIaa81VvcJCGzBkkrlbG1GJb6uhJkFczxif4DV9RQ/X6MfQ==
X-Received: by 2002:a05:6a00:22c9:b0:63b:4313:f8c4 with SMTP id f9-20020a056a0022c900b0063b4313f8c4mr6795006pfj.9.1685537328256;
        Wed, 31 May 2023 05:48:48 -0700 (PDT)
Received: from [192.168.188.28] ([122.199.60.237])
        by smtp.gmail.com with ESMTPSA id r9-20020a632b09000000b0053ef188c90bsm1204346pgr.89.2023.05.31.05.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 05:48:47 -0700 (PDT)
Message-ID: <4bd29f45-935d-ef16-9f97-1c48e74a385f@gmail.com>
Date:   Wed, 31 May 2023 22:48:43 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: btrfs raid10 rebalance questions
Content-Language: en-AU
To:     Todor Ivanov <t.i.ivanov@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAOv4OrX7kxTMrpE+AdqWo+PCsAGpBkrJ9irr9Xj8ZcRrPTvRoA@mail.gmail.com>
 <CAOv4OrUdSBccOiEk_fW2c8wm9YwfYk2vGZtCwHFj_woXKm5NKg@mail.gmail.com>
From:   DanglingPointer <danglingpointerexception@gmail.com>
In-Reply-To: <CAOv4OrUdSBccOiEk_fW2c8wm9YwfYk2vGZtCwHFj_woXKm5NKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi Todor,

Have you tried looking at the new documentation? 
https://btrfs.readthedocs.io/en/latest/

Could someone respond to Todor?  Many have similar questions and 
experiences.  Thanks in advance!


On 22/5/23 23:02, Todor Ivanov wrote:
>       Hello,
>
>       We have a debian10 system with 6x16TB in btrfs raid10. In the
> past we hit an issue with lack of space, which we resolved with data
> rebalance, but some questions left unanswered:
>
> https://unix.stackexchange.com/questions/743528/btrfs-snapshot-fails-with-no-space-left
>
> We will be very happy if you can answer or give guidelines for at
> least the following:
>
> - How often should we run btrfs balance? Trying to use some logic and
> looking at https://docs.nvidia.com/networking-ethernet-software/knowledge-base/Configuration-and-Usage/Storage/When-to-Rebalance-BTRFS-Partitions/
> looks like a good example, but this is not for RAID10. How do we
> calculate chunk size correctly and should we alter Device Size beause
> of data duplication?
> - Is it dangerous and should we rebalance metadata as well, having in
> mind we use btrfs-progs v4.20.1, kernel 4.19.0-16-amd64 and btrfs
> raid10? What is an optimal value for musage?
> - What does it mean when "btrfs fi us" is showing a lot of
> "Unallocated" space, and yet we ran into the out of space issue
> (probably on Metadata data - subvolume snapshot), why isn't Metadata
> expanding into that Unallocated space automatically?
>
>
> Kind regards,
> Todor
