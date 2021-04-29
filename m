Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FCD36ED46
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Apr 2021 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237130AbhD2PUb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 29 Apr 2021 11:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbhD2PU2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 29 Apr 2021 11:20:28 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C46C06138B
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 08:19:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y12so49387486qtx.11
        for <linux-btrfs@vger.kernel.org>; Thu, 29 Apr 2021 08:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Cjat2scVV8Z2CIXIhmnAzsEY2Z7gDapTVHP7Gq8CHCY=;
        b=zZYA5pXuB0cdml/YJ6VDg0+scyQxyWPJrBYRbYp8Gq3QLQNdwM7fDLmx5hyupi1lZ7
         VffkhPnt+Rhyv9HtHKVtNGeGZ9a7y7AvHiWvFncgryHehaIMLNJtOPmr1qGUpFPxfaVj
         iC35G89GzUEg3kF8X04rS5wOUNHjk4o7LcmGdyFxx+v+lbrNOso28/zg0reLnDeXdn30
         lT87435yBMKKk2+PWd1WJr+L1HNhy2/sGwqJ47myQenqGBw6jpwSnIE1kvkfshA4Fute
         WrUbO231AUP6pDbwazauZP3oH3yEkRhiyhwiibqg8zKOxR4EnFS2sY6KetpkjSIo6ArH
         cGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cjat2scVV8Z2CIXIhmnAzsEY2Z7gDapTVHP7Gq8CHCY=;
        b=UCLaGtcCOGDLUNoPx/rvsSU7GWFwFVERVHFGdAyl8aZ0Mljkn1Sn+eqfNX93q8Qc7y
         tH0VYmWVnrXgzIqiMlVcdZMaXsZRQmglp9B0mzAcVHX5TQpCbhl/3Z+IKy/5q/pGSf9g
         jlXu3/oZbDPcKMmFN1CvlKxsoPlE2qiKjDQ0e2R63Kvj5VCyUJTHLrunYudePyOcgHya
         O+pQO1iWwohyJZHaF01mCyH8R7xRVvFDhUKfT50uJYuvRSU9TOHK7iLLFPcR5EohkhFV
         fdTv1eNfkQh0Ppk2lrfgXD7xrJt5kaix3n3CXjJw7MLps1eGUAcIgnzxYpae8CMY2ptz
         KoeA==
X-Gm-Message-State: AOAM533wfK+NVjFvKza2SBFgIRquc2qp3dmJeXJbjiZ4dw6hBcwb5MvB
        fi9N7+o+eKfJL8W5hAQEiq8Fww==
X-Google-Smtp-Source: ABdhPJxa9/ufrwUZ8JH7a1NmFDj2yH7q/dXMHwjp9BfV1utEVXAn1MRC/d/KfH6XOZc2xpBLvCvzog==
X-Received: by 2002:ac8:4e24:: with SMTP id d4mr31997253qtw.213.1619709579416;
        Thu, 29 Apr 2021 08:19:39 -0700 (PDT)
Received: from ?IPv6:2620:10d:c0a8:11d9::11c3? ([2620:10d:c091:480::1:a937])
        by smtp.gmail.com with ESMTPSA id p187sm493701qkd.92.2021.04.29.08.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Apr 2021 08:19:36 -0700 (PDT)
Subject: Re: [PATCH 4/7] btrfs: use the global rsv size in the preemptive
 thresh calculation
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <cover.1619631053.git.josef@toxicpanda.com>
 <31114026fc63ffebcdc43197fded45da7731ef03.1619631053.git.josef@toxicpanda.com>
 <PH0PR04MB741630B03D3693142C46EF639B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4db7b3b0-ca7a-12a7-156e-153dbcf6e9fa@toxicpanda.com>
Date:   Thu, 29 Apr 2021 11:19:35 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <PH0PR04MB741630B03D3693142C46EF639B5F9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/29/21 10:04 AM, Johannes Thumshirn wrote:
> On 28/04/2021 19:40, Josef Bacik wrote:
>> -	thresh += (space_info->total_bytes - space_info->bytes_used -
>> -		   space_info->bytes_reserved - space_info->bytes_readonly);
>> +	used = space_info->bytes_used + space_info->bytes_reserved +
>> +		space_info->bytes_readonly + global_rsv_size;
>> +	if (used < space_info->total_bytes)
>> +		thresh += space_info->total_bytes - used;
>>   	thresh >>= space_info->clamp;
> 
> 
> I don't quite understand why you introduced the 'if' here. Now we're only
> adding the new free space to the threshold if we're using less than our
> total free space, which kinda makes sense that we're not going over our
> total free space.
> 

Because it's possible that the global_rsv_size + used is > total_bytes, because 
sometimes the global reserve can end up being calculated as larger than the 
available size (think stupid small fs'es where we only have the original 8mib 
chunk of metadata).  It doesn't usually happen, but that sort of thinking gets 
me into trouble, so this is safer.  Thanks,

Josef
