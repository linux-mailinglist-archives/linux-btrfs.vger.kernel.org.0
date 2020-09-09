Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4324C262E6D
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Sep 2020 14:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgIIMWI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Sep 2020 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729691AbgIIMU4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Sep 2020 08:20:56 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6286CC06179E
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Sep 2020 05:20:40 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n133so2119857qkn.11
        for <linux-btrfs@vger.kernel.org>; Wed, 09 Sep 2020 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4l8mKt9mfVJ087l8w7qZYrVZQl10TB7eQmTZuL+96YE=;
        b=CazflOz2+2Zu5QpKy/zLMMIMHLnrAxkzaAw0CestzcRVQyOLWbw47vVQe7j8KNeUJv
         XMZ9tLci6wYFMjjr+JuJlKgRmSbAm3vnbOBd7OLKUq7DRdH69gXFl25MS4VmXsUlpKv5
         S3sDheASNQ+abwyHKzSctexCETwe39PMbc9PRzRu18elVlB4vpwHV1u1BdzkcFmjGlgD
         Jdy0hq/v2JCmL/pXJlHSU6nOyQ2/5Nz+NKQV7s6Dsjk0bGh5owBLLryb1XRgdj/UxJIP
         08ioUzArjOCRsCxzwqIhyuU0MP6pdgcvOMPlqpW/DQ9XNdeyquV1pj3imXUEawoGc0Kq
         F7LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4l8mKt9mfVJ087l8w7qZYrVZQl10TB7eQmTZuL+96YE=;
        b=Lt2HrZqDsmVlNYZ9zVdlcM74PMs29nag7GObn3ma7rfueCwsr2v+yPaoe/AivAv3gS
         DVyAnb7MWV72g7Jy+MiGB08dw9WVpF6pMlx5vLgBhUFW1fuCM9/tWzGk5RYjvdrkV/Xr
         r8VHd+UAjuF7CmI96xGsf6jqDSTeLlvRX1fxtay7e6SiJpAZEO/NwJg02TA32oJhry3K
         IWbSuXPXflZKJCmqyeoyei6Xc7n9s3yyvGpeaVcdWOb2jJppbtBg6oGG/xbK/frI3kQj
         qdewxnoPB94uj+ToMN2rSV0wcfiMqRKNcN6HqHJey0vMSH/KreATobpZ8p4S6u5tzHxO
         kWag==
X-Gm-Message-State: AOAM531m3+qpauFKieGR726AJ0njoggbkFdb1tUh7Gol8QZnik48LIVa
        nL0hSw2HrNW4kcYoHXpkvrU00w==
X-Google-Smtp-Source: ABdhPJxUTR50sN44TvspyghPStFhAkd3NCostgtOdDzv+E2q+HFazIYxoFBmUtxwn8xHG/cLcmkC2w==
X-Received: by 2002:a37:bf43:: with SMTP id p64mr2898037qkf.24.1599654039531;
        Wed, 09 Sep 2020 05:20:39 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id u17sm2682949qtq.20.2020.09.09.05.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 05:20:38 -0700 (PDT)
Subject: Re: [PATCH] fstests: btrfs/219 add a test to test -o rescue=all
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
References: <5e29c56193c6de8bbc364f22595479d292da13d3.1599579754.git.josef@toxicpanda.com>
 <SN4PR0401MB35985107123C67C711DE69E79B260@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <8ee024dd-6c7a-3d80-d98d-4f622a380c4d@toxicpanda.com>
Date:   Wed, 9 Sep 2020 08:20:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB35985107123C67C711DE69E79B260@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/9/20 3:15 AM, Johannes Thumshirn wrote:
> On 08/09/2020 21:39, Josef Bacik wrote:
>> +# Modify as appropriate.
>> +_supported_fs generic
>> +_supported_os Linux
>> +_require_test
>> +_require_scratch_mountopt "-o rescue=all,ro"
>> +
>> +# if error
>> +exit
>> +
>> +# optional stuff if your test has verbose output to help resolve problems
>> +#echo
>> +#echo "If failure, check $seqres.full (this) and $seqres.full.ok (reference)"
>> +
>> +# success, all done
>> +status=0
>> +exit
> 
> This looks very much like the test template. The only thing it does is check if
> the mount option exit and then exit, doesn't it?
> 
> So it either gets skipped if the mount option isn't present or it exits with a
> failure.
> 

Lol Jesus Christ, I git format-patch'ed to copy the test to the box I 
was actually going to use and fixed it there, but then forgot to copy 
the new one back over and sent the template.  I'm an idiot, I'll resend 
the actual test.  Thanks,

Josef
