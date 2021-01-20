Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72D02FD4D4
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Jan 2021 17:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391220AbhATQCw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Jan 2021 11:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389342AbhATP4V (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Jan 2021 10:56:21 -0500
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903DAC0613CF
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:55:39 -0800 (PST)
Received: by mail-qv1-xf2b.google.com with SMTP id s6so11085941qvn.6
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Jan 2021 07:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=T9x3p3RuFHKWQi0JgYEw3ryIpU6CG+DAJxr1jZI86zE=;
        b=I3pNoaVJX2kwUX6oBtVqlzPBAtTWOc2k2FbCvCUVYrxTsL3pK1SfRJ5vNHB1cOginD
         X408fjIOyzL53M19fu9jBmq8KsiWD0o7FiNB1/+kHYHJ9i+VGcgtK8+8uIm2//TCH7lo
         7h3BtYStlEACFHgvuwMlU87R6aDZn3ICl//VPdNNeDPfnmmd7mRhmttrXTggXX6Yhaqj
         yZMaCV+ChTS6p8c7b7sDzATF5c6PzwAEYzr3WzaAOsHNqDFsjUbZPwKrCY4ZsAbUBLtz
         eTTkVikVtnt8cnfzXUgpJkaR+8uiuyYN9KFkJ9h/XnN4Jt7H2RlR4V/6/KbtqvnLPEuT
         OP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=T9x3p3RuFHKWQi0JgYEw3ryIpU6CG+DAJxr1jZI86zE=;
        b=Fbcx8XwiHFHtfq3EuMh1++HV+8aSF7mDyCScWk0lm/H4BNmcJgsW9qPyNBjCi+IqFf
         m1adZIPR4M4zyQDzlQeEkf9oODnNFRlkAEe8JeF3t9T+KyOUs2bCC+BOYFFIR8L53mgr
         mvSzeHvkhnnt2TvjDPQ1vV46MetgYvUahZRbxUtv3Vko8RriFSaEkJwiib4gmxXx1ST/
         2IDVKaxgNVXWrK29On+DR63kVFfU64/z+ug8fgui6TD1D+ZT7vdCpc5fGrtiplPdrr/A
         wiXZwCFtsDHF4lRNE5MVBq2pmtFrT3uxhr63RJ0UVPVrQ56SwgKIUWioGDQZhHOAiVSl
         vI5A==
X-Gm-Message-State: AOAM531Nm1UFf1QkaQ2R40l9Ie1UaK3Hf4ZscX3oEEYaggCD2gayzqZO
        vYLbaYggFmH8JCFnbZ9f9B/YEOp8KnnbsuhoBFE=
X-Google-Smtp-Source: ABdhPJya+OpLQMUrcZSMxOdiiAgub2lFdEhKP1CrUKi9tNPMUWIfOI9ePMCDslWN56HFFk3Qb9i9HA==
X-Received: by 2002:ad4:4a70:: with SMTP id cn16mr10182678qvb.38.1611158138344;
        Wed, 20 Jan 2021 07:55:38 -0800 (PST)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 102sm1411174qtg.45.2021.01.20.07.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 07:55:36 -0800 (PST)
Subject: Re: [PATCH v2 14/14] btrfs: Enable W=1 checks for btrfs
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20210120102526.310486-1-nborisov@suse.com>
 <20210120102526.310486-15-nborisov@suse.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7d769a82-e573-4d04-a125-13ca99136d49@toxicpanda.com>
Date:   Wed, 20 Jan 2021 10:55:36 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120102526.310486-15-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/20/21 5:25 AM, Nikolay Borisov wrote:
> Now that the btrfs' codebase is clean of W=1 warning let's enable those
> checks unconditionally for the entire fs/btrfs/ and its subdirectories.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Once this is enabled I get

fs/btrfs/zoned.c: In function ‘btrfs_sb_log_location_bdev’:
fs/btrfs/zoned.c:491:6: warning: variable ‘zone_size’ set but not used 
[-Wunused-but-set-variable]
   491 |  u64 zone_size;
       |      ^~~~~~~~~

on misc-next.  Thanks,

Josef
