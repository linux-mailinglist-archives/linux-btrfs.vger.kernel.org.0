Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E36A59186C
	for <lists+linux-btrfs@lfdr.de>; Sat, 13 Aug 2022 05:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbiHMDCO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 12 Aug 2022 23:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234787AbiHMDCL (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 12 Aug 2022 23:02:11 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1FBC05
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 20:02:09 -0700 (PDT)
Received: by mail-pf1-f175.google.com with SMTP id 130so2183657pfy.6
        for <linux-btrfs@vger.kernel.org>; Fri, 12 Aug 2022 20:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nvYZoG6y+yEpaHDR199DsqkcQLiZTx4ckAj1ppSsD04=;
        b=gFNP/AVYLE3MwDtZ2833UoBqalx8g+iAfGQiiQ38DSL47G6tQmWcgk8kZ4N4wrYTb5
         KaYAUM9wpCROSl/HKegAaFLTqTTmLOB7sZsOvPaptHdPYHPng9JA0yAmHOMmNMZOxXzv
         WR4F+NdEr2oDgH8BlpoB2UdUU5snMfyyTpFhcGo3WB4pSFSlWYZ95pE0AHuVRD16f+LB
         C6F3WqVd5UXFrum0VzW74RrCW92Zg34/fY8IclF7TCfuGS3QAaLoyD89sY2o/ryWiyZI
         l9O76/Ga3I+2OJTJy2PgMCca31rIQfJflmMYhbUKvQ/ajibsrnfgbrgdi1sPI6Cigu6x
         yuEw==
X-Gm-Message-State: ACgBeo2M29wbYrGqOFEDRYX+vHl7FWOv9gBjECyM4AtaL5t1crpBSGrA
        +DtfitlXIdgVJe3mvEfm6BvFiOX8gTc=
X-Google-Smtp-Source: AA6agR6iaAcIkbgCCFsUMcNzUh+Rs+i1rhyloYjlxrsEooPpRrtkaiSSIy7OMqveMHjCRnMsgdDFhQ==
X-Received: by 2002:a63:6b81:0:b0:41c:3a8c:b4fe with SMTP id g123-20020a636b81000000b0041c3a8cb4femr5360680pgc.84.1660359728950;
        Fri, 12 Aug 2022 20:02:08 -0700 (PDT)
Received: from [192.168.3.217] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y24-20020a631818000000b004202cb1c491sm2015408pgl.31.2022.08.12.20.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 20:02:08 -0700 (PDT)
Message-ID: <bc8c1eb6-18e0-788c-3863-7f0b39501944@acm.org>
Date:   Fri, 12 Aug 2022 20:02:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: A sparse(make C=1) warning in btrfs about the 'blk_opf_t'
Content-Language: en-US
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20220813080046.ACB1.409509F4@e16-tech.com>
 <60fef86b-2174-e1a9-6d2b-2508fb809f8e@acm.org>
 <20220813091324.38BB.409509F4@e16-tech.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220813091324.38BB.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 8/12/22 18:13, Wang Yugui wrote:
> This warning is still ON after applied this patch([PATCH] tracing: Suppress sparse warnings triggered by is_signed_type())

How about the patch below?

diff --git a/include/trace/events/btrfs.h b/include/trace/events/btrfs.h
index 73df80d462dc..925e74356547 100644
--- a/include/trace/events/btrfs.h
+++ b/include/trace/events/btrfs.h
@@ -2338,7 +2338,7 @@ DECLARE_EVENT_CLASS(btrfs_raid56_bio,
  		__field(	u64,	devid		)
  		__field(	u32,	offset		)
  		__field(	u32,	len		)
-		__field(	u8,	opf		)
+		__field(enum req_op,	opf		)
  		__field(	u8,	total_stripes	)
  		__field(	u8,	real_stripes	)
  		__field(	u8,	nr_data		)

Thanks,

Bart.
