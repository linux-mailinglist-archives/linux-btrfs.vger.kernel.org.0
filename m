Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7754B1B8EA5
	for <lists+linux-btrfs@lfdr.de>; Sun, 26 Apr 2020 12:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgDZKD5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 26 Apr 2020 06:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726118AbgDZKDz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 26 Apr 2020 06:03:55 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C424C061A0C
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 03:03:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l19so14398819lje.10
        for <linux-btrfs@vger.kernel.org>; Sun, 26 Apr 2020 03:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1Qn7dMUaScW6RStYYl/ei8skK7kxyIxqczbatJhHU64=;
        b=X23VxZM5wrV7BnKT3+qwneSrIo7JK+pSWMaHd0vBdM42rmCs8qDhUdUH6g7ur2mta3
         LAn+xoD9fQM4HBi24MIE+begRcSHkqP49nKmIBeP1ipMq/u1iz91WwjKCtP9RJMnVJ91
         rt3GiacKXNSf7JHZF/6R7wLn+tPIaK+HHIA32Bz3oUVKDf53RTMU5ylzEQdnUEmFCqLb
         A/uoB4Hokt1H8bh3RkbtpiM6QfHKmkH5il2WG4nWpdgnRtb93UkdoF5sib63UB7D8FZT
         GSSvXcL7AXJfPtlKCltva0/H2r7r8kO289KUMA0JJ8aAN/l9vh9zwaqwkqnAk4Qihuok
         cigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1Qn7dMUaScW6RStYYl/ei8skK7kxyIxqczbatJhHU64=;
        b=egPH0GuIwVmT7bAgnNPv00cdP98u583H4/rbANmsZuvFOTTBFLFVh0qmbrnApWtvMf
         U0PipUqKkVmVZkfCvHL7Vkg8CjTe0mzD7+3o5gwANVGu4TknLdOpYSB9kvy/KGDVwuGl
         ZmJgwpGN0/N2stMflyHzkExddvnhPnBtXqQGUZPgpbFfQx6mcqyUQ0mtXLY08XSaDynX
         Cz0DCzdG5TXhEVUY6vcZcSMRgSoqJYdDfqyYTKXmzOsPcgJ/E/YHbJHTHT16EQSGgFKs
         7OvB3U6qM6yMzTgfjLJu4Rm0bSnkSCgGOD3yhWv1RDQ273j0aitdGfUwiLd31Se16PTH
         W7Xg==
X-Gm-Message-State: AGi0PubwCscaBmxqRcdhryK31CEKLBJbJJTmhlP9L5Uh79WKOSxvmiCe
        nTtN13RimSrEprJ3nvAFGPJ+nlum
X-Google-Smtp-Source: APiQypLmQDxoTbL7GqCk7nRP7bzC5souxykhHdfAATZ9Haj/4rMNqzrjGHeIhcCuapN5cxadKVj/3w==
X-Received: by 2002:a2e:9996:: with SMTP id w22mr7899400lji.59.1587895433121;
        Sun, 26 Apr 2020 03:03:53 -0700 (PDT)
Received: from ?IPv6:2a00:1370:812d:48ee:3630:6817:757e:9dcf? ([2a00:1370:812d:48ee:3630:6817:757e:9dcf])
        by smtp.gmail.com with ESMTPSA id g22sm6642099ljl.17.2020.04.26.03.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 03:03:52 -0700 (PDT)
Subject: Re: Help needed to recover from partition resize/move
To:     Chris Murphy <lists@colorremedies.com>,
        Yegor Yegorov <gochkin@gmail.com>
Cc:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <CAP7ccd__ozu0xvp5yiFW8CuyDBPhD4jOV1auXE5U-z9oBKmn-g@mail.gmail.com>
 <CAJCQCtTdghbU1au1AOpeF2v_YxZoh_d1JZpu2Jf7s_xMdT=+rQ@mail.gmail.com>
 <CAP7ccd8u-pStGzCau+bcYEVjRy+SPE+JQz169i_2NiY8dfUXuQ@mail.gmail.com>
 <CAJCQCtSdyP_SspJGwitWSOM1mvT-_ykXGq_azk=R+jqCZ+V4Yw@mail.gmail.com>
 <CAP7ccd8WTtCMb2t4FWPEwrh+d3sNSPrkkpa4R=Z91-ieXK_vMA@mail.gmail.com>
 <CAJCQCtRy5-PBRP0K-4BDkdMJfD3U6FPDAYZSxwhFB9KoX0XUTA@mail.gmail.com>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
Message-ID: <4c46f2a2-8603-977f-74ec-449d3cfb1fb8@gmail.com>
Date:   Sun, 26 Apr 2020 13:03:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAJCQCtRy5-PBRP0K-4BDkdMJfD3U6FPDAYZSxwhFB9KoX0XUTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

26.04.2020 10:36, Chris Murphy пишет:
>> superblock: bytenr=274877906944, device=/dev/nvme0n1p3
>> ---------------------------------------------------------
>> ERROR: bad magic on superblock on /dev/nvme0n1p3 at 274877906944
> 
> ? OK but why does it even go looking for this 3rd super? A file system
> of this size doesn't have a 3rd super, which appears at 256G.
> 
> There's no dmesg for the resize? This should report the block group
> changes that happen as part of the resize; and also the fs size
> change; and also the partition map change. And if it is rebooted, then
> dump-super shouldn't be looking for a 3rd super.
> 


Most likely it is code bug. The condition is

                 if (ret == 0 && errno == 0)

but errno is not guaranteed to be reset to zero after previous errors. 
Linux errno(3):


        The value in errno is significant only when the return value of 
the call indicated an
        error (i.e., -1 from most system calls; -1 or NULL from most 
library  functions);  a
        function  that  succeeds is allowed to change errno.  The value 
of errno is never set
        to zero by any system call or library function.

And pread64(2)

        Note that is not an error  for  a  successful  call  to 
transfer  fewer  bytes  than
        requested (see read(2) and write(2)).

        On error, -1 is returned and errno is set to indicate the cause 
of the error.

So errno check here is entirely redundant, the only case when pread64 
returns 0 is reading past EOF.
