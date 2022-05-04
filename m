Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FF651ACDD
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 May 2022 20:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377117AbiEDSfb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 May 2022 14:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377108AbiEDSfW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 May 2022 14:35:22 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA5C21809
        for <linux-btrfs@vger.kernel.org>; Wed,  4 May 2022 11:15:54 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id c15so2692448ljr.9
        for <linux-btrfs@vger.kernel.org>; Wed, 04 May 2022 11:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=QX0HNgrVS21Is8gMwDP+/rSETOCjRVGNklqfue5Uuis=;
        b=pd5GrCz6KtgIsQWf5dg1TWqAQNNhtIy78U1pY9aYfL69gVNVbZLo5Bu4G6/kcIT3Oy
         HLiCgDrCat5BJ+gGKZ/JUPP401+wo6HeAVfn78NGO5vEjyAbqqRdx9UY8+8Ah3Iv3/Gf
         ZWf6Fdxrxo3vHnTUczl7n7UoqJWWgiolwy3LVjgOg/xsO6x3sTboCpDXTDasr+gTbkJ0
         /htutVaqSWqDIVwIrwKqjrbdiJZSZ4yKrgLiuymnvM968ig/oQR9sYYo+PEsfIUsIfxM
         JP5XqdUT219E1t5fcv3GYnoa4KtUqR0WFItzjCTpp5TvJcxlYCoJWjr7hfnsTxz/HWol
         Jy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QX0HNgrVS21Is8gMwDP+/rSETOCjRVGNklqfue5Uuis=;
        b=kw3pw2/AFCUtqSzIWI5EzGe7R8GhHvDgtH2XJsAJVREGd3WgENs6IrmaGTmIgZvubY
         Ld1vYbHBMShR1Erowy1tSK0DGQHZSp8H1oA5Akapp27dEApntKf5pBUBdgi2faJ+wlNJ
         0lLBHkYPtEcxo8eKdJMaqpdMrPbkGgrDNxJOPEuPh1YwLnWJbDPv2FCK3qS+Mz3+ZIbR
         V/0hXlT1Nh3XdyB1IyhwdTZhl8bxq20QLmHWY2l4Y5h18UKmCIpwwc5If+AR9SwpdiUP
         AczCAVOS+YQ08m2rLfotnpo5BWd53CMCiySC7rvaZ4VgAP7c/xnqWwGvF3sN1GE8nfkR
         GxIw==
X-Gm-Message-State: AOAM531kEPkBwHJs0jSIqobZjFvEjb6uuN7W1N7TV817ksz017l3uQFF
        8M1hpkdj7knShyE4pzz7yi0tsovmfxF8Tw==
X-Google-Smtp-Source: ABdhPJys1JmFACa4koPUHqc+yz4Yd1HvgPuQkmv8+xysea+OH0IKMzmCjcJRzBc6UCZWjel6fJQM9A==
X-Received: by 2002:a2e:a7c3:0:b0:24f:5201:d839 with SMTP id x3-20020a2ea7c3000000b0024f5201d839mr10180246ljp.218.1651688152180;
        Wed, 04 May 2022 11:15:52 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:3365:df52:ce71:56d4:e7e6? ([2a00:1370:8182:3365:df52:ce71:56d4:e7e6])
        by smtp.gmail.com with ESMTPSA id q9-20020ac246e9000000b0047255d2116csm1270962lfo.155.2022.05.04.11.15.51
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 11:15:51 -0700 (PDT)
Message-ID: <42d841fc-d4ee-37e1-470f-4ac5c821afc7@gmail.com>
Date:   Wed, 4 May 2022 21:15:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Debian Bullseye install btrfs raid1
Content-Language: en-US
To:     linux-btrfs@vger.kernel.org
References: <20220504112315.71b41977e071f43db945687c@lucassen.org>
 <c0a5db9f-2631-9177-929c-9e76a9c67ec5@suse.com>
 <20220504120254.7fae6033bee9e63ed002bea9@lucassen.org>
 <9129a5be-f0a2-5859-4c02-eb075d222a31@suse.com>
 <20220504121454.8a43384a5c8ec25d6e9c1b77@lucassen.org>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <20220504121454.8a43384a5c8ec25d6e9c1b77@lucassen.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04.05.2022 13:14, richard lucassen wrote:
> On Wed, 4 May 2022 13:07:14 +0300
> Nikolay Borisov <nborisov@suse.com> wrote:
> 
>>> The wiki explains how to repair an array, but when the array is the
>>> root fs you will have a problem.
>>>
>>> So, what should I do when the / fs is degraded?
>>
>> In case of btrfs raid1 if you managed to mount the array degraded
>> it's possible to add another device to the array and then run a
>> balance operation so that you end up with 2 copies of your data. I.e
>> I don't see a problem? Have I misunderstood you?
> 
> I fear you did. I cannot mount it -o degraded, I have no working system!
> 
> I need fysical access to the system to repair it, contrary to an md
> system, the latter will simply start as 'Degraded Array' even when I'm
> abroad...
> 

No, it will not. Some script(s), as part of startup sequence, will
decide that array can be started even though it is degraded and force it
to be started. Nothing in principle prevents your distribution from
adding scripts to mount btrfs in degraded mode in this case. Those
scripts are not part of btrfs, so you should report it to your
distribution.
