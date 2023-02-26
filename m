Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B56A3385
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Feb 2023 19:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBZSw2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Feb 2023 13:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZSwZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Feb 2023 13:52:25 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06862193FC
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Feb 2023 10:52:25 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id s26so17169449edw.11
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Feb 2023 10:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OmvS65ComhL5PGaM4gNGzt5zU24WTNUTAdHFSOp0v70=;
        b=SvQazNj6O5rXsODIlgR8XaKOuuYgwJ9aK5zAdGtJM1ENPQsetAhFFv6m3pm24o8/3m
         pdqrIioqXfF6iiiaJyU3qZrWA9OmrtcqQJvbBNr/WLTB0kcpgWXI1ZERatiBTWJ6NYDy
         uklnsxM5nrYcZkh8CQ9092DCZKcJNx8Szr8ElJzRN/aEtQ7TI0W44R2XHcXZvLRrZHjL
         YXbIZl0JPi1bgfej9AcWBBgx8Olt2Sgrg8Rkg9kIciy9rzmNc9AJ228vHM8zLezBmD59
         kRQb1qQqb8AFdicPApW2o3HRC3saMEjIIZrrTf6i6PqXX61AB0GYMMltVIaa/7QQ0mNN
         n58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OmvS65ComhL5PGaM4gNGzt5zU24WTNUTAdHFSOp0v70=;
        b=M0Ir0DnQEpLo/jKo7aG+Fh7TxiEc2lVajTSnnx9rVUVCa052uGAzPXY2aZ3sbAad+2
         vk6YRORJA8RyC8tHtlV9MD1albl1foghvbHcWZl1C8Tar98tChVAdxd4ktj/MGlecF/C
         7ru4BlddVw0sL84foUXzlT8IxSBnE6OPIxw2wu/xSUhTfgsNbULn2kf1IPbsH48endxB
         htyIezufA2Uz1x+TZ96X1vasTBhLaDcD5yVYZvZmo/NK3sDiD/EGTO1N1aiEv2TRomkR
         Iph8hZxntIIkf+yy7xlpi9vDJoGmc7obfg6lO229xkFaaf82n5/8JW5FFCuXA847euIy
         GhSQ==
X-Gm-Message-State: AO0yUKUVoBkrvZIOej7W1t204OKJP5h+RqCU/KbTnKfuGdKqksqVJ81Q
        iPcxAWToJQXXw6PHti4wQwAv4TvCRKU=
X-Google-Smtp-Source: AK7set/6iI9QsdfG2zvir+fOIG2dlo1r2ptN8NVWcF9mqkSIiKwr8HtcAHD6RnhP/oGraV2qab4J/g==
X-Received: by 2002:aa7:cf03:0:b0:4ab:4d3c:7e99 with SMTP id a3-20020aa7cf03000000b004ab4d3c7e99mr22793558edy.2.1677437543253;
        Sun, 26 Feb 2023 10:52:23 -0800 (PST)
Received: from ?IPV6:2a02:a466:68ed:1:d8f:7960:eb1f:1674? (2a02-a466-68ed-1-d8f-7960-eb1f-1674.fixed6.kpn.net. [2a02:a466:68ed:1:d8f:7960:eb1f:1674])
        by smtp.gmail.com with ESMTPSA id eg41-20020a05640228a900b004acc7202074sm2206599edb.16.2023.02.26.10.52.22
        for <linux-btrfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 10:52:22 -0800 (PST)
Message-ID: <22291d90-26fe-ab6d-cedd-cb251abdce3e@gmail.com>
Date:   Sun, 26 Feb 2023 19:52:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive
 operation?
To:     linux-btrfs@vger.kernel.org
References: <87wn4fiec8.fsf@physik.rwth-aachen.de>
 <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
 <87a61bi4pj.fsf@physik.rwth-aachen.de>
Content-Language: en-US
From:   Ferry Toth <fntoth@gmail.com>
In-Reply-To: <87a61bi4pj.fsf@physik.rwth-aachen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Op 18-02-2023 om 12:38 schreef Torsten Bronger:
> Hallöchen!
> 
> Goffredo Baroncelli writes:
> 
>> On 18/02/2023 09.10, Torsten Bronger wrote:
>>
>>
>>> I want to replace a device in a RAID1 and converted it
>>> temporarily to “single”:
>>
>> I suggest you to evaluate
>> - remove a disk when the FS is offline
>> - mount the FS in 'degraded' mode
>> - attach a new disk
Better (if you have the hardware for it, i.e. sufficient connectors) add 
the extra disk to the pool. Then remove the old disk from the pool.
Then physically remove the (now unused) disk.
> I agree that converting to single is not the fastest way to replace
> a disk, but the safest AFAICS.  It is the boot partition in a simple
> home server without monitor or keyboard, which makes mounting as
> degraded difficult.  Besides, you can only mount in degraded mode
> once.  If anything goes wrong, I have to rebuild from scratch.
> 
> Mileage may vary in a more professional environment.
> 
> Regards,
> Torsten.
> 

