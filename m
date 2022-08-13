Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662465917C6
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 02:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiHMAYy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 20:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHMAYw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 20:24:52 -0400
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F059DA4052
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 17:24:51 -0700 (PDT)
Received: by mail-pf1-f174.google.com with SMTP id u133so2247588pfc.10
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 17:24:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ndB+Ay6B3XnCo07JcEQR6/yYE11c2aLRestu+CsVscc=;
        b=r+emB3Bw/an2kAFy8x+5Z8WGLBpx5FaEQrDLPcsRRRYraraeez+1FZHAwOPjbluqDq
         mtVTvPtZqIQJ9t6cJ1Z+tpgHaOZRBOd3dFgDdQsO9uBp3IG5PDBuD0ShkhnSCgGQW6oE
         fyfR9hCb9DW19tqIfuOmb2ZEmfkEE4EwzvfEz/vIrHZrLVA+ZglS69HdweG71Y6qt6zt
         R3MPa91NV1FTjLXecoTgvoMtJX1fkvV8+NqOqO0HoP7GLBMyst+Gz4aJ8fYg17tdbUJu
         mcUSqG5FQMTRj8XCtxOX+QJayYbdpke5G7apech2LHiUq9CgsloFp6uLFIqyDSb/L8dA
         9PDg==
X-Gm-Message-State: ACgBeo23yE4TXVgf581Y9OzSQTHJ95bUZfhwqYHH5951ZG2/TS8c5c0x
        5fMQh7i823wIa5GauQrO45ru0SxWUxM=
X-Google-Smtp-Source: AA6agR4pcydSfryMpgYQaEkYvkZ9OzeG9cLFEyUhtxdm7wlh8h+shkhmS3609zM/c+6IFybwfIj1bA==
X-Received: by 2002:a63:ea09:0:b0:41c:2c83:df5f with SMTP id c9-20020a63ea09000000b0041c2c83df5fmr4738682pgi.503.1660350291337;
        Fri, 12 Aug 2022 17:24:51 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902784a00b0015ee60ef65bsm2322697pln.260.2022.08.12.17.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 17:23:18 -0700 (PDT)
Message-ID: <60fef86b-2174-e1a9-6d2b-2508fb809f8e@acm.org>
Date:   Fri, 12 Aug 2022 17:22:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: A sparse(make C=1) warning in btrfs about the 'blk_opf_t'
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>, linux-btrfs@vger.kernel.org
References: <20220813080046.ACB1.409509F4@e16-tech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220813080046.ACB1.409509F4@e16-tech.com>
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

On 8/12/22 17:00, Wang Yugui wrote:
> Hi, Bart Van Assche
> 
> A sparse(make C=1) warning in btrfs about the 'blk_opf_t'
> 
> ./include/trace/events/btrfs.h:2327:1: warning: incorrect type in assignment (different base types)
> ./include/trace/events/btrfs.h:2327:1:    expected unsigned char [usertype] opf
> ./include/trace/events/btrfs.h:2327:1:    got restricted blk_opf_t enum req_op

Hi Wang,

Please help with verifying whether this patch fixes that warning: 
"[PATCH] tracing: Suppress sparse warnings triggered by 
is_signed_type()" 
(https://lore.kernel.org/all/20220717151047.19220-1-bvanassche@acm.org/).

Thanks,

Bart.

