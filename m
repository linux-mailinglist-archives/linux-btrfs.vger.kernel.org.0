Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05761281B70
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Oct 2020 21:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388406AbgJBTPv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 2 Oct 2020 15:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgJBTPu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 2 Oct 2020 15:15:50 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E029C0613D0
        for <linux-btrfs@vger.kernel.org>; Fri,  2 Oct 2020 12:15:50 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id y14so1406639pgf.12
        for <linux-btrfs@vger.kernel.org>; Fri, 02 Oct 2020 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bhOfUjVkgkwuGAkX6SDsvH52njvJawoNARNEBAfE8Lg=;
        b=Qtc4nmOJwI1KrhflVRXUoPqtZBXDOZ08QUBWZ7RO0FoqrFATRklNpJIvJe9VV1FncQ
         oi6OlL7jVVIBnoF6i3xDMqDVPwQDUnxW5utMUbNn9XhJwp1rF8Kyu4mRDtVbcRbewCqR
         Mh2snvV6COuoULNWllbkWqmGkaJfJwMTnh9F5sOXVXD6tO0vl+ec7C7XmypEG6/bYk8q
         tbL8z9vT48zYe8BZuhD5TYFMpBP5JWZW+WHxvjxp57eKu8rKUcFqhYjza7M9C/vmSyo9
         E5FqTCGQ86wvoHXtjn7sXCtCHCTXQ3oTVSgnjlTuJu8Y4b9yJhlbNKDl9vjcQ0v2Ru0A
         JGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bhOfUjVkgkwuGAkX6SDsvH52njvJawoNARNEBAfE8Lg=;
        b=V0EnUDIgJp4ekDAxoHf6IpCOdfZmkOdF9+c4h+TcSzKYMVbzai0MCViNEEETEIVUcc
         k2ZX20S3+pGbSNEqElBQG+rYbC55J/a2rCu7kcOkWVy46f/TM5VFRQwmyFQMXKC4cq9n
         K1iuxL+E7XpNhKjNTb6WiENv0/0PjWfgEWXE2vaeAnFX53mhMwhcUsS2YD21Vwonb1LE
         dTNNGvyr8JlXXallaKja4ROmHczOEe8I0u3M95CJRrBVSGsYvM4jLiJ00yRXpwGMyJ5x
         drHD/tu/vnWqiMwItGfjpdQ1giUeYi9daU9kWtIxYb0GZVy6KuerNyyQLLcmEg2vkJ0+
         UQfA==
X-Gm-Message-State: AOAM533Y1qPdUC3NEuL4tBIGPvLHdZ0Y4YECd9KUnbNnmNacUekCwYKO
        rF00CrP7BL1Wp7AbObMgt/c=
X-Google-Smtp-Source: ABdhPJyBjpBQeuciGz9GNGjDp0H9s1Y4q7/fiIjARUUXn/82yS1QM/C1AFQYvkjQ9k4yY589HOUj7g==
X-Received: by 2002:a63:c64d:: with SMTP id x13mr3630605pgg.380.1601666148597;
        Fri, 02 Oct 2020 12:15:48 -0700 (PDT)
Received: from [192.168.0.132] (S010664777d4a88b3.cg.shawcable.net. [70.77.224.58])
        by smtp.gmail.com with ESMTPSA id gi20sm2312410pjb.28.2020.10.02.12.15.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2020 12:15:47 -0700 (PDT)
Subject: Re: [PATCH v2] btrfs-progs: btrfsutil: add pkg-config files for
 btrfsutil
References: <CAEg-Je8L+KUx93im15DPGvczpvw8TfvhN752itm88w9Qwkg+sg@mail.gmail.com>
 <20200820043618.51575-1-shngmao@gmail.com>
 <20201002175458.GZ6756@twin.jikos.cz>
To:     linux-btrfs@vger.kernel.org
Cc:     ngompa13@gmail.com, dsterba@suse.cz
From:   Sheng Mao <shngmao@gmail.com>
Message-ID: <1ac70f38-4887-c28d-4601-3f9494ce9f09@gmail.com>
Date:   Fri, 2 Oct 2020 13:15:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201002175458.GZ6756@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2020-10-02 11:54 a.m., David Sterba wrote:
> On Wed, Aug 19, 2020 at 10:36:18PM -0600, Sheng Mao wrote:
>> Add pc file for btrfsutil libraries. Users can use
>> pkg-config to set up compilation and linking flags.
>>
>> The paths in pc file depend on prefix variable but
>> ignore DESTDIR. DESTDIR is used for packaging and
>> it should not affect the paths in pc file.
>>
>> Signed-off-by: Sheng Mao <shngmao@gmail.com>
> 
> Thanks, I've added it to devel.
> 
>> +test-pkg-config:
>> +	@echo "Test pkg-config settings"
>> +	export libdir incdir
>> +	$(Q)bash tests/pkg-config-tests.sh
> 
> I've deleted this section and the script, there's no point testing it
> like that.
> 
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -12,6 +12,10 @@ LIBBTRFS_MAJOR=0
>>   LIBBTRFS_MINOR=1
>>   LIBBTRFS_PATCHLEVEL=2
>>   
>> +BTRFS_UTIL_VERSION_MAJOR=1
>> +BTRFS_UTIL_VERSION_MINOR=2
>> +BTRFS_UTIL_VERSION_PATCH=0
> 
> This would duplicate the version definition, so this needs to parse it
> from libbtrfsutil/btrfsutil.h.
> 

Hi David,

Thank you for reviewing and merging the code! I agree with you, the test 
code doesn't make sense and it is right to remove it.

Also, thank you Neal for helping me improving the patch!

Thank you!

Regards,
Sheng
