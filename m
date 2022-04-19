Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD8B5063DC
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 Apr 2022 07:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348524AbiDSFWr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 Apr 2022 01:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348563AbiDSFWd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 Apr 2022 01:22:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAA46167;
        Mon, 18 Apr 2022 22:19:49 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k14so22891168pga.0;
        Mon, 18 Apr 2022 22:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=je3GAhnrsS3qmDoIuVcaSDn6nM7iLRjCpgJb3vVvrAc=;
        b=A8a3td9wlfAiSIhFkg5saM13qY+3v4FW01xS8tmywfWv+aYfg1FQGkNcWC4Uv1QrHZ
         yKMabMhWqEPo93hessEAL59glLZtvZVAsMUV+faVLPCX/yG9wO1y0kO3XR3zFx/BV4yc
         u5cTZITXyaQJN1ZX2NyR+3+xwkUvX5KDPJ1p38D3qJdub1fXJfndKJv7kDWiLpNoYNLC
         lUluKrxiRx34yY2knrldzdzePWBdiSl5H8SRjJyPoJgC8HzXt4Pco7333xU7kg2vRf1K
         bu/64+uxtsguYjnDmbLB9iOFgs5zlQfWqkpR8TvrIi8r65x77ter9yFWogkfVNhfHDwZ
         ElyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=je3GAhnrsS3qmDoIuVcaSDn6nM7iLRjCpgJb3vVvrAc=;
        b=OwabXReaj3dYCiinBjSMRw4lCwt2ZcV07YvJVdVbfFxPicmbeQS+dzkGZVmVUzt6Vi
         xdbN9A443MNFCKdw5qAfiE47XYQhJb1fouetawGT7/PEEkMVHXykT5WaiFyZ/hYN9tDi
         p6mgWgZTtEqu2eAszJl7f9osSKp0gnaMz8ARQV/SIzxWdyLWyst9aq9YBAhJCzpLPXq2
         wC5QjUdoSpqFAyld6zUbFzsWlZ9q+1Uu9kt86Qjea67zGAPRIGEGr0nY4HhOc25IUpME
         ru4TP38k4hbnXPEODDDS3MPBAaEYEKd4CIChZKGIEYG94bCpln8FiBIL1Y3uD4yo+nqJ
         i7RA==
X-Gm-Message-State: AOAM530v7/m4ZmHW03P2sUjTYsjAxJw6r5tu/YWzZNi7XTiNW7ncTGsP
        Sb/Lisy1JA3ga9mBLA+kIZQ=
X-Google-Smtp-Source: ABdhPJzhM5IkrPTBazVFqfWlLXwWqrSQLkhlty36WeiwKvHzSvbQHp5tWd0+ALc1qK1qWDh+XUJuNg==
X-Received: by 2002:a63:68c6:0:b0:380:3fbc:dfb6 with SMTP id d189-20020a6368c6000000b003803fbcdfb6mr13102086pgc.326.1650345589078;
        Mon, 18 Apr 2022 22:19:49 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id 124-20020a621982000000b0050a73577a37sm6583315pfz.45.2022.04.18.22.19.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 22:19:48 -0700 (PDT)
Message-ID: <b5b42b49-9d0c-c745-f355-89900b53f6e1@gmail.com>
Date:   Tue, 19 Apr 2022 12:19:44 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] btrfs: zstd: remove extraneous asterix at the head of
 zstd_reclaim_timer_fn() comment
Content-Language: en-US
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-doc@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
        Nick Terrell <terrelln@fb.com>, Schspa Shi <schspa@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220418125934.566647-1-bagasdotme@gmail.com>
 <Yl2Dx+jefYs1Un+8@localhost.localdomain>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <Yl2Dx+jefYs1Un+8@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/18/22 22:29, Josef Bacik wrote:
> Reviewed-by: Josef Bacik <josef@toxicpanda.com>
> 
> Thanks,
> 
> Josef

Thanks for the review. Should I send v2 with your Reviewed-by
tag?

-- 
An old man doll... just what I always wanted! - Clara
