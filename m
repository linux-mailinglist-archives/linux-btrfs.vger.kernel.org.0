Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112764DB80D
	for <lists+linux-btrfs@lfdr.de>; Wed, 16 Mar 2022 19:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348131AbiCPSo1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Mar 2022 14:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbiCPSo0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Mar 2022 14:44:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DB8BC09
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 11:43:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id s29so5208626lfb.13
        for <linux-btrfs@vger.kernel.org>; Wed, 16 Mar 2022 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=RjOvplxxawlgqSDodva+SmEGflMpGmMqSF4JzYdnIqU=;
        b=OaLx3FLmjnuTOFsM21DaaM499GJbDmrS73WJ46v8oXMmVaUsB25aUeQV4LilvzMkko
         uTh49z1B4HA3Jjr1K1V40weQCvKrDuWXQ0Bcn0jQ2lVD22w8BBz4e3Xpknw/u6PmL0dL
         WK5Bzu2+oDNjWdgfmr9E6f2aKRBZCmXShei1IwiPByFIcodGQUGyKV4WXKTzVEk7/7dY
         jxVQo7D/JjuEbYazlF87G8o9t748TX2j1UWJZDiI40ue58dBnekg4CjS5cDLdG/TobuT
         eAViE8O7IgQlPuRpy/D4GAiD87QbA0VPDcuy+sJnXIpl0hFgwPFikiNbZZWbgS5PfcAf
         rkUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RjOvplxxawlgqSDodva+SmEGflMpGmMqSF4JzYdnIqU=;
        b=TemC2TIiH+kqJDFbZ4CfLiyaizH9T3SbdQKRhPpVpSIGwLbgsOEcToNv9F56RKok2I
         crB1tgCb9rbG58zAO1J8gJ1TWuTSRew4E/0iW7YKlcmCnbr2477IyYoYXuNMJl+zK3F4
         qSszloTcLkY9Pba8xAmyXdOfOoQuxkENteqIDTNSUdi1L4rtitjSgsuKR5aAXGqeLX7V
         WXqfwaZKecTnbSXC+UPvNNO/ESWORNZKhoO9COsPQFdzzXQFelLZvtF3HE5tMBmcWdEd
         ry4wgXiHqN9QVZgChjhugdQCUwE3F6IWBfk2oapIeFQtiMrkTkBaqq8YTf+2zqwmD3ee
         WBvw==
X-Gm-Message-State: AOAM530orcttFHUaBpPj8XgqCHf7IWnAtmXRFp6iexVTPuvkpoPWJbMi
        APj3xZ2KLtOn6FHLGdjcYkn0MTZOKFGCsczozHy6yw==
X-Google-Smtp-Source: ABdhPJxrHKtcmr18LiwdJWNLsfUFVRw2jJcZg1I/ws4JHszWFjkYZJUglYZEAwwi6sGxlzfiMPg4eg==
X-Received: by 2002:a05:6512:a8b:b0:448:9767:e45 with SMTP id m11-20020a0565120a8b00b0044897670e45mr562591lfu.477.1647456189221;
        Wed, 16 Mar 2022 11:43:09 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8182:3ffd:fa46:42b2:52e1:1c7d? ([2a00:1370:8182:3ffd:fa46:42b2:52e1:1c7d])
        by smtp.gmail.com with ESMTPSA id y16-20020a2e9d50000000b00247b105c11dsm240576ljj.34.2022.03.16.11.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 11:43:08 -0700 (PDT)
Message-ID: <07ed9357-9c21-6610-9ac3-ad3764fabcc9@gmail.com>
Date:   Wed, 16 Mar 2022 21:43:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Btrfs autodefrag wrote 5TB in one day to a 0.5TB SSD without a
 measurable benefit
Content-Language: en-US
To:     Phillip Susi <phill@thesusis.net>
Cc:     Jan Ziak <0xe2.0x9a.0x9b@gmail.com>, linux-btrfs@vger.kernel.org
References: <CAODFU0rZEy064KkSK1juHA6=r2zC4=Go8Me2V2DqHWb-AirL-Q@mail.gmail.com>
 <87tuc9q1fc.fsf@vps.thesusis.net>
 <CAODFU0py06T4Eet+i0ZAY5Zrp5174eQJOCGh_03oZdDXO55TKw@mail.gmail.com>
 <87tuc7gdzp.fsf@vps.thesusis.net>
 <CAODFU0oM02WDpOPXp1of177aEJ9=ux2QFrHZF=khhzAg+3N1dA@mail.gmail.com>
 <87ee34cnaq.fsf@vps.thesusis.net>
 <5bfd9f15-c696-3962-aaf9-7d0eb4a79694@gmail.com>
 <87bky5wxt6.fsf@vps.thesusis.net>
From:   Andrei Borzenkov <arvidjaar@gmail.com>
In-Reply-To: <87bky5wxt6.fsf@vps.thesusis.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16.03.2022 21:31, Phillip Susi wrote:
> 
> Andrei Borzenkov <arvidjaar@gmail.com> writes:
> 
>> btrfs manages space in variable size extents. If you change 999 bytes in
>> 1000 bytes extent, original extent remains allocated because 1 byte is
>> still referenced. So actual space consumption is now 1999 bytes.
> 
> Huh?  You can't really do that because the page cache manages files in
> 4k pages.  If you have a 1M extent and you touch one byte in the file,
> thus making one 4k page dirty, are you really saying that btrfs will
> write that modified 4k page somewhere else and NOT free the 4k block
> that is no longer used?

yes.

>  Why the heck not?
>
Short answer - because it is implemented this way.

There could be arbitrary number of overlapping references to this
extent. To track all of these references on every write to decide
whether extent can be split will likely be prohibitively inefficient.

Alternative is to use fixed sized blocks where freeing space is just a
matter of reference count. This means increasing size of metadata for
keeping track of blocks with unknown impact.
