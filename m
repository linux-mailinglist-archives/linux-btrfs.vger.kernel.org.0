Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA56591B5C
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239670AbiHMPZt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 13 Aug 2022 11:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239475AbiHMPZt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 13 Aug 2022 11:25:49 -0400
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB4D165BC
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 08:25:48 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id u133so3338985pfc.10
        for <linux-btrfs@vger.kernel.org>; Sat, 13 Aug 2022 08:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+IvjtDhNAPKOsYTEsiOSWsSAgXhO8hgYLNo+898xZAM=;
        b=t4u/Ye4RAyQpGrXm3CeptiaExiJl/NDi7t4X3toRwst0IBiMK2HowJVnNzQR2o9ift
         Yt8TI4W/OQp5OyVmnuanA22FeSiJYEaVsgHKDaKCLmoPFABkET+7iumkPBjdYnxrApCf
         D7pBQ9ygzmZk5xKS11Bg3f50JYIdpj6M1mT9r57Iu5Jk8ma7rJM9JBa2I7DFLe7AyDqn
         twL1ZHUAWNIiOlGxFwCvozS16N2McdXY2HIBAeFIafpJyx6MSsptD0o6yVOEfajndSJ9
         Cz6RvyalAZFIaxUKjKGKCz5OqQg0jUeYmd0utMawKQmRMHC1lpNDK0AFuedci9h72eL2
         qBAw==
X-Gm-Message-State: ACgBeo2CJn2xjf+6Gg5YwWeUpsMq4bqn3TpXiEGu7Nz41mDwtqKSpSLx
        EZCrYScP9GY63B0EeNTh7e6UCHNK9mI=
X-Google-Smtp-Source: AA6agR6w/JlPhti5VgHjLMmpbUDOCfv7bO8bL91N4SZAqBSZH823L/NPV0KwjbqD9bqaslVpPjSkog==
X-Received: by 2002:a05:6a00:21c2:b0:52b:ff44:666a with SMTP id t2-20020a056a0021c200b0052bff44666amr8501016pfj.83.1660404347333;
        Sat, 13 Aug 2022 08:25:47 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id i190-20020a6254c7000000b0052d4f2e2f6asm3664315pfb.119.2022.08.13.08.25.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Aug 2022 08:25:46 -0700 (PDT)
Message-ID: <e129b7aa-9589-242e-b259-298b73382002@acm.org>
Date:   Sat, 13 Aug 2022 08:25:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: A sparse(make C=1) warning in btrfs about the 'blk_opf_t'
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220813091324.38BB.409509F4@e16-tech.com>
 <bc8c1eb6-18e0-788c-3863-7f0b39501944@acm.org>
 <20220813125331.3F71.409509F4@e16-tech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220813125331.3F71.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/12/22 21:53, Wang Yugui wrote:
> both '__field(enum req_op,opf)' and '__field(blk_opf_t,opf)' failed to work.
> 
> ./include/trace/events/btrfs.h:2327:1: warning: incorrect type in assignment (different base types)
> ./include/trace/events/btrfs.h:2327:1:    expected unsigned int [usertype] opf
> ./include/trace/events/btrfs.h:2327:1:    got restricted blk_opf_t enum req_op
> 
> /ssd/git/os/linux-5.19/fs/btrfs/super.c: note: in included file (through include/trace/trace_events.h, include/trace/define_trace.h, include/trace/events/btrfs.h):
> ./include/trace/events/btrfs.h:2327:1: warning: cast to restricted blk_opf_t
> ./include/trace/events/btrfs.h:2327:1: warning: cast to restricted blk_opf_t
> ./include/trace/events/btrfs.h:2327:1: warning: restricted blk_opf_t degrades to integer
> ./include/trace/events/btrfs.h:2327:1: warning: restricted blk_opf_t degrades to integer

 From https://en.wikipedia.org/wiki/Posting_style:

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

Regarding the warnings reported above: please apply patch "[PATCH] 
tracing: Suppress sparse warnings triggered by is_signed_type()" before 
testing my patch.

Thanks,

Bart.
