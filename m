Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437AA4EB139
	for <lists+linux-btrfs@lfdr.de>; Tue, 29 Mar 2022 18:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239131AbiC2QD4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 29 Mar 2022 12:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237870AbiC2QDz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 29 Mar 2022 12:03:55 -0400
X-Greylist: delayed 67391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 09:02:11 PDT
Received: from mail.as397444.net (mail.as397444.net [IPv6:2620:6e:a000:1::99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA16851590
        for <linux-btrfs@vger.kernel.org>; Tue, 29 Mar 2022 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bluematt.me
        ; s=1648568465; h=In-Reply-To:From:References:To:Subject:From:Subject:To:Cc:
        Cc:Reply-To; bh=/se9KYauJHRwtUa0YSY5d99MHzu78MwHh+hvQ6cMRH0=; b=gIilpW1RZFY61
        fE37YwFW2oUZ6cSuFvPrLUDpXEYG/CDhhD/Rfsq9IfwGBPY4/63oJcwowBqt98v0nHZM44dV/LyL4
        qcujbW0XPZJ0vFT4ZplKHZUe1qVPqL81cNNRDbUJCpVG3i4+IeI5yBQK5iM4TAEOmy6evsnOiOI1w
        Hu9S88BSn1hN2td4y5ncOz0fGVpQSbNqMXcnEwfdly/cfIqg72Cv6a9eM53sCBxOkyXn6w4UDapeu
        Ii28enzwwF0ULCBCLPITYmlnj+Y70kp02rtmxXyY3LIK5/G7JDgFW0WB8vZNeXHk4kIp4bBg9EaqA
        gKwuMgMnPd8xXUgojo02Q==;
Received: by mail.as397444.net with esmtpsa (TLS1.3) (Exim)
        (envelope-from <blnxfsl@bluematt.me>)
        id 1nZEIK-000fG6-DR; Tue, 29 Mar 2022 16:02:08 +0000
Message-ID: <008fdf29-dc9c-3a22-687c-a593378e64ed@bluematt.me>
Date:   Tue, 29 Mar 2022 09:02:07 -0700
MIME-Version: 1.0
Subject: Re: [5.16.14] csum mismatch on free space cache on subpage
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>
References: <61aa27d1-30fc-c1a9-f0f4-9df544395ec3@bluematt.me>
 <9e32aa01-c712-1def-6d54-1db450fd2750@gmx.com>
From:   Matt Corallo <blnxfsl@bluematt.me>
In-Reply-To: <9e32aa01-c712-1def-6d54-1db450fd2750@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DKIM-Note: Keys used to sign are likely public at https://as397444.net/dkim/bluematt.me
X-DKIM-Note: For more info, see https://as397444.net/dkim/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 3/28/22 10:57 PM, Qu Wenruo wrote:
> 
> 
> On 2022/3/29 05:18, Matt Corallo wrote:
>> Basically what the subject says. Any time I mount an fs on my 64K-page
>> PPC host mount a 4K-page device (so far two-of-two - once a flash drive
>> with mirror and nothing else, once a many-TB volume across multiple
>> disks) I see a stream of csum mismatches in the space cache in dmesg.
>> The FS' otherwise seem to work.
>>
>> Matt
> 
> Oh, so you're using the subpage feature recently introduced, awesome!

Yep, been waiting on it since I got this box years ago so I can finally stop building kernels 
locally. Thanks so much for all your work on it!

> But it looks like there are still some v1 cache code using hardcoded
> PAGE_SIZE instead of sectorsize, thus it's reporting the problem.

Ah! Okay, thanks. Definitely strange to see the errors in syslog and not have them show up in `btrfs 
device stats`.

> You're completely fine to continue using the fs, as such PAGE_SIZE usage
> will invalidate all old cache, thus there is no chance of corruption.

Awesome, thanks.

> Or you can convert to v2 cache as a workaround.
> 
> I'll need to investigate some time for this fix.
> 
> Thanks,
> Qu
