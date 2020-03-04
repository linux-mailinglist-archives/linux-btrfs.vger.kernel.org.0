Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31B7517985D
	for <lists+linux-btrfs@lfdr.de>; Wed,  4 Mar 2020 19:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgCDStP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 4 Mar 2020 13:49:15 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38491 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDStO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 4 Mar 2020 13:49:14 -0500
Received: by mail-qt1-f196.google.com with SMTP id e20so2181123qto.5
        for <linux-btrfs@vger.kernel.org>; Wed, 04 Mar 2020 10:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=MXRTwAWwPC2LcehJH5CPQwgV9NIfJzfe2abzHs12rXs=;
        b=aonjsbSi+Olf10NBPJKwK628sw8oj8Hhk6JWBLrJ0O6qFQGsX2zf2S7dWWqE7mhbg2
         pvU8IW3T1eP53b//SpTwCunNcmXg6vfTMESXz/DSRJDtvCkJcqJKJOEnhvykigWJrkeV
         /cUVEQ5uvZlrpOYXkyCuMD05S3vj6K42eDSJP4E29y8kiD1v/Nby7pH8DYRsbH0sYFLp
         Vl+bsBLuDnhHr62DEZGzILpQnKKRGCCfQ3PkWQhOTNlfOnkuehdyGbOddsfJbH36DQ/S
         07w/q5DFQ5fE7uhElj+2+vTwhptfVmhzWQmauxrFTRBI4YMPa0o1S4MgwNblCFokqzaw
         ALDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXRTwAWwPC2LcehJH5CPQwgV9NIfJzfe2abzHs12rXs=;
        b=Zx3SWJlOs4X9YYL3QfjjHn/IUZr8DIbgksZhuX/0vusBOWM10buix/J4YKZi/rGJgY
         4PUILY3DWSSwD+NrWvUjuN+bwvstjp2CeKGnoxZukm0NKrW7Gy5vyP2vFKerx1whijnL
         d6nFqvBCwNX7jJVrmg+KopIAWmK6Xe+WsCEmG6SGSm1NlnOreGiqFvfqmM0H9gQRHIXg
         kRIGgiTzOEctS79sH9q6K3x8tUniBpGocpkqfz1c0fxOiqO9stM1P7s0+T4uF5ds0Ew5
         7ZVqLBcK9hW/MYls0PD+kto8BRx3mj4lOHEkcck5yYt1AJo0vgYV0xa/WF2qO/JL68j2
         2Rag==
X-Gm-Message-State: ANhLgQ00hxUssJRg44/VIGOiUD9XHQr1PT0Ntja7asKWCJ2hbEHCg769
        ejRppIFKeaCsGHa9EA1KsHaJ4T4pKTU=
X-Google-Smtp-Source: ADFU+vvn4ToraaQrxqMMcXy/TL3Mbdyhz4WoaM3FBL+s0Bh3sMqGTrRAYzLRz6Saqzq8aljuHRurAw==
X-Received: by 2002:ac8:73d4:: with SMTP id v20mr1004756qtp.185.1583347752393;
        Wed, 04 Mar 2020 10:49:12 -0800 (PST)
Received: from [192.168.1.106] ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x5sm1417633qtq.26.2020.03.04.10.49.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:49:11 -0800 (PST)
Subject: Re: [PATCH] btrfs: Remove impossible BUG_ON in get_tree_block_key
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20200304150447.19582-1-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <4e8c5da6-6c8a-1914-e861-e4d24984e437@toxicpanda.com>
Date:   Wed, 4 Mar 2020 13:49:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304150447.19582-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/4/20 10:04 AM, Nikolay Borisov wrote:
> relocate_tree_blocks calls get_tree_block_key for a block iff that block
> has its ->key_ready equal false. Thus the BUG_ON in the latter function
> cannot ever be triggered so remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
