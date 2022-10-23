Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99DB86093C1
	for <lists+linux-btrfs@lfdr.de>; Sun, 23 Oct 2022 16:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiJWNy0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 23 Oct 2022 09:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJWNyY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 23 Oct 2022 09:54:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0052AD8
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 06:54:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id o12so12824910lfq.9
        for <linux-btrfs@vger.kernel.org>; Sun, 23 Oct 2022 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5oAEtx2ggx7Ry1nkhfZptphuZuq09FUGeyM5kj19LsE=;
        b=JaX395LJDgCn5OE5LNCrNCaV/fsnwiAEsKVyfMxTv7C6lDiSlUNQYKSKB/7Q6s8aWE
         xMrb4vQ8NoLX+YTsHwjNfgs71hn4bllwSW3de7BaFEI8v4D1g+VU85M5+EAxQCNw69VH
         7s9YygwfcGigqqcqpt1AUHThu7MccgPgpsbysKZnaY1dq5OVrRMBYePzmnKutUUKBTxD
         ypPtLWHDcR+XoFn2hCLZYbGBe4Gj3yFa7NmBLRZMx774n7OEDcCtypLcUbTk7xvRxRv5
         XE+4nRoqyGIZNsg11MZcHynCYxZFhPNVcDyZ2gsWfuzJuwIB7eBbHbUMgKR+msN70Db7
         uFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5oAEtx2ggx7Ry1nkhfZptphuZuq09FUGeyM5kj19LsE=;
        b=PvIwqaQkXo1N43YZ00dcbDaSA0viVCMJ8InYnMUY1YUJqPiSN4HL2XTDoXifwZAsTl
         quXVT4f4v54bk+PawcxNiJJKt8MnMj429dmRO0izVPlJj7GtMztq/l1X8Aqv2J2yLyjP
         nBAqyh6ltmm+kdnoj3pe9V3L96OmYWY/xMtGhvWgkYmJY5zmyBjEJNVe3eE1pTxbMnOW
         pgES8wtX9ow7RUc3h51RGid2uhEJ7DVWDo1Kg75XsTTCnBdP41S4dg3JldQiUkyVwYYZ
         IPcaS2O0LzXFAodk1f1Si3YBnF6+q9/DEPp8swPNhHqUkVjBDD6fgIa5slhRi8tfMw97
         91rw==
X-Gm-Message-State: ACrzQf36E5u8r4ACBktPjbTS7joy5wu5DIESAd3SEpge1S/01+MJ/oWt
        lL3TP9NbgeWZc8hCLCOnVJ8UE2NUvdU=
X-Google-Smtp-Source: AMsMyM50+GlBBdGtM9Q/k3WVbq0WoJKseUTnBzemwKcauVZwC8ztXU1aK/sHeLLHcd9sinlqgaXKXw==
X-Received: by 2002:a05:6512:158c:b0:4a2:5cf6:5338 with SMTP id bp12-20020a056512158c00b004a25cf65338mr10102449lfb.81.1666533260238;
        Sun, 23 Oct 2022 06:54:20 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:683d:c840:bdd:653a:30ea? ([2a00:1370:8182:683d:c840:bdd:653a:30ea])
        by smtp.gmail.com with ESMTPSA id d30-20020a19385e000000b004979da67114sm4037738lfj.255.2022.10.23.06.54.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 06:54:19 -0700 (PDT)
Message-ID: <9799c630-ec3d-232c-92c4-4aa3dee839ba@gmail.com>
Date:   Sun, 23 Oct 2022 16:54:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: Is it safe to use snapshot without data as 'btrfs send' parent?
Content-Language: en-US
To:     Nemcev Aleksey <Nemcev_Aleksey@inbox.ru>,
        linux-btrfs@vger.kernel.org
References: <d87ce800-670e-9ca2-b524-8b20678abd9b@inbox.ru>
 <d59f04b3-9b79-905c-dca9-5fc4ce7be0a9@gmail.com>
 <3f97ee58-4f52-7660-a9b3-916598d6a463@inbox.ru>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <3f97ee58-4f52-7660-a9b3-916598d6a463@inbox.ru>
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

On 23.10.2022 12:32, Nemcev Aleksey wrote:
> 
> 
> I thought it will be possible to somehow track changes for ongoing
> incremental backup but also be able to delete files on original FS and
> immideately reclaim free space without losing incremental backup
> ability. I don't use snapshot on original FS as backup, only as parent
> reference for incremental send and would be happy if it will be any way
> to avoid space consumption by this snapshot for deleted files (just to
> keep track "this file should be deleted or overwritten" references).

btrfs data sharing is extent based, not file based, so it is more 
complicated.

> But it seems the only way to use incremental send|receive requires to
> keep normal snapshot on original FS as parent.
> 

btrfs send works by computing difference between two subvolumes, so yes, 
you must have two subvolumes to be able to compute difference. It may 
theoretically be possible to use some metadata dump (like btrfs-image) 
instead of source subvolume, but it does not sound like a trivial task.

If data change rate is so high that even keeping snapshot for one day is 
a problem, you can achieve similar effects by combining btrfs snapshots 
and rsync

- on source create read-only snapshot (simply to have consistent image)
- on destination clone previous backup to a new volume
- run "rsync --inplace from source to target
- remove snapshot on source

This will effectively do the same as incremental btrfs send by sending 
only changed blocks. It does mean increased IO load on both source and 
destination though. If you have mostly small files, using rsync 
--whole-file may mitigate it.

