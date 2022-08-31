Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB145A7B9B
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 12:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiHaKpQ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 06:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiHaKpO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 06:45:14 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4803C8DA
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 03:45:13 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id fa2so6054858pjb.2
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 03:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fydeos.io; s=fydeos;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=rWysmroeHzaFAzCToz81yf7ET8Z5wDWj84HhAZ8vHK8=;
        b=DdUXtOPbytpx05iegVagm5+jRGkAAfJif8ODhkryf0TdD8gc/eyHTb7/XMiN9taPoX
         SChaR1+5xyVBCLhiy4LZjpLy88ftTOQjjqQFwM7tDFpqofD+9D4+A3l+Od87DCcux+Cl
         jscnKT73oFFE/GDke7WYdYzeG60chu6DF5xTFzY1Wb5npu7m54r2ZsUjdgqm9PcazOQF
         yOMjt9zx3qktfdTAmoBECdKVd5oluRAZ9YFz58e96X98mC2YehMDSU7OjwP6sqSbEeMy
         WZfU0SakXQsof9/hpnHxKFkRWTM1L+GqUIgxCybAfd609ZFmZ7T8VcH3zB9PFwvmAY+O
         ASwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=rWysmroeHzaFAzCToz81yf7ET8Z5wDWj84HhAZ8vHK8=;
        b=33QjCh+tfFOk/JhdgFv6T6njtysHSY5xER1aiq+K7a9F1dxnUXqIyNVlyrFeuH2bIb
         8poFH9/W0C45/qHSZMgbpJefwJ+ALNm4hNA71h2rWWJB6yE3g8fRpCOg3m2YM7sGw43L
         52/fpnPZKipB4tmyYA+CLa56dnGx6lLuFWPKnTHKsrVOJ046IJfCzLoSJ1WYubHZ5KHQ
         9qAon1EPbZIfOAospvtyEBNZrBEfOwhZhwG7OA0YZUl+a73xye7yWWuIyZ4Ou6BbIahq
         pG8tbyq/FroiY2uw7Xy6/CMzTwBCxrPTh6oBLsW2WL5Ip2DjbrMgLOb78st9RknaPjYj
         N6Zw==
X-Gm-Message-State: ACgBeo1mHEG+lAvbAxYoA90mxGYb4Y7d9RYIPlsDw/U+2WJIfCg0sz43
        KLPNsghuHGmNjYmfqwcKaUWU6F1NbWKlbw==
X-Google-Smtp-Source: AA6agR5oSuNNd6sJZyszFDBWNpDuTphxQ0GDYOwtWsEjp3wd0zYli/qmOHY33bh7FCHbR2q16bkG3Q==
X-Received: by 2002:a17:90a:4402:b0:1fd:c07d:a815 with SMTP id s2-20020a17090a440200b001fdc07da815mr2580730pjg.188.1661942712611;
        Wed, 31 Aug 2022 03:45:12 -0700 (PDT)
Received: from [192.168.2.144] ([2403:18c0:3:bd::])
        by smtp.gmail.com with ESMTPSA id c197-20020a624ece000000b005363abb6d0bsm11242868pfb.15.2022.08.31.03.45.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 03:45:12 -0700 (PDT)
Message-ID: <f47485f4-5d98-f4ed-b5f9-2cfb2bbe09db@fydeos.io>
Date:   Wed, 31 Aug 2022 18:45:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH] btrfs-progs: free extent buffer after repairing wrong
 transid eb
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
Cc:     l@damenly.su
References: <20220830124752.45550-1-glass@fydeos.io>
 <bd6749cf-d04c-a26e-992b-a0f40a4461c5@gmx.com>
From:   Su Yue <glass@fydeos.io>
In-Reply-To: <bd6749cf-d04c-a26e-992b-a0f40a4461c5@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/8/31 16:00, Qu Wenruo wrote:
> 
> 
> On 2022/8/30 20:47, Su Yue wrote:
>> In read_tree_block, extent buffer EXTENT_BAD_TRANSID flagged will
>> be added into fs_info->recow_ebs with an increment of its refs.
>>
>> The corresponding free_extent_buffer should be called after we
>> fix transid error by cowing extent buffer then remove them from
>> fs_info->recow_ebs.
>>
>> Otherwise, extent buffers will be leaked as fsck-tests/002 reports:
>> ===================================================================
>> ====== RUN CHECK /root/btrfs-progs/btrfs check --repair --force 
>> ./default_case.img.restored
>> parent transid verify failed on 29360128 wanted 9 found 755944791
>> parent transid verify failed on 29360128 wanted 9 found 755944791
>> parent transid verify failed on 29360128 wanted 9 found 755944791
>> Ignoring transid failure
>> [1/7] checking root items
>> Fixed 0 roots.
>> [2/7] checking extents
>> [3/7] checking free space cache
>> [4/7] checking fs roots
>> [5/7] checking only csums items (without verifying data)
>> [6/7] checking root refs
>> [7/7] checking quota groups skipped (not enabled on this FS)
>> extent buffer leak: start 29360128 len 4096
>> enabling repair mode
>> ===================================================================
>>
>> Fixes: c64485544baa ("Btrfs-progs: keep track of transid failures and 
>> fix them if possible")
>> Signed-off-by: Su Yue <glass@fydeos.io>
> 
> Great to fix the fsck/002 runs.
> 
> Have you hit any other eb leaks? My extra noisy patch to crash progs
> when eb leaks failed at fsck/002.
> 
No other eb leaks found with your patches.

> Not sure if there are any other remaining.

At least `make tests` seems happy for now.

--
Su
> 
> Thanks,
> Qu
>> ---
>>   check/main.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/check/main.c b/check/main.c
>> index 0ba38f73c0a4..0dd18d07ff5d 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -10966,6 +10966,7 @@ static int cmd_check(const struct cmd_struct 
>> *cmd, int argc, char **argv)
>>                         struct extent_buffer, recow);
>>           list_del_init(&eb->recow);
>>           ret = recow_extent_buffer(root, eb);
>> +        free_extent_buffer(eb);
>>           err |= !!ret;
>>           if (ret) {
>>               error("fails to fix transid errors");
