Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A40E325AA0C
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIBLKR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 07:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBLKN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 07:10:13 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AC3C061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 04:10:12 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id d20so3893189qka.5
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 04:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UPaIbc6u9/aRkRZQfJTa2aJFV7HyZGEvxmdQVWWMH08=;
        b=vOiFVvgctqhernRuQJT2Et3pia1MB06PJpXgQ0TOqsM3AFrJidSoApkGFh7+pQ8DPb
         oq74GMnfVlOv2O8cXu3MD1F2WywRkPRY7Qj74Rsf/oyK8rQtwmbDScTVHKEKz9XhaGFw
         2Ys3B7BaAVoqhWuVw2FZp6GqkQ8Lx3R3MrGxVWNy0EjB6DF16Hri9kF5nBElGBFUlYV/
         1xNIW43eNtPHPcCkcie76ixI6FVsP2jL+UKm4KKLTzwlLUJKGnMrr5Of+Q7sZjR66+e0
         geIAMnA0lQNoQUa1VLrd/6S3ZJzjVHu1NodZscMu3YtNuA7Bsb3/pz1HjQiEbAqKUe04
         ujmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UPaIbc6u9/aRkRZQfJTa2aJFV7HyZGEvxmdQVWWMH08=;
        b=EVcEB4ecgNDh1D5oUxp60tU9/lTn7YnKuEohqnxAw//hz02Icm7hgsaiiUN0UUMJNZ
         VWh23tyu8Sp+zMTnaatKrkbYrI9weD56/Wlq8GSU3I17cwbjysTKVrCcIXn0uJq9ThMg
         x0hUU9LUSiDJK/yEnoi4fHBoMRoVhC2Arjw9W1Ixs04yK2ebgZjMlRhaLink7znoObDS
         n3OAqUa36SLQKY2/8N8ZuvHzjtJg6qxoH74HSQouhgmlSCO41jbN/ELlqM+fVLOWzNHr
         uEDQkPqzgntHejLET4SHu6HNVTbq1iBvq2dGp0cCDl/4ihLOnS3RsKz4zZpdQPlfP/tw
         PqsA==
X-Gm-Message-State: AOAM531hn2y7ZK7nDxrCBAYu3dDjITPFEQ2n7ZyeNNdw7sEmfF2jdEwO
        B3FNmP9ZMpyLiWpWAm+oBQjOTA==
X-Google-Smtp-Source: ABdhPJwT0F9yiLOhp8RFxVVxyP9UeIaVCfsIh5V9x29mcjJq1FyRxcDmj9hwyx02kpXiO9mR/jJHdg==
X-Received: by 2002:a37:30d:: with SMTP id 13mr6460074qkd.44.1599045011147;
        Wed, 02 Sep 2020 04:10:11 -0700 (PDT)
Received: from [192.168.1.210] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b9sm4289591qtt.39.2020.09.02.04.10.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 04:10:10 -0700 (PDT)
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Dave Chinner <david@fromorbit.com>
Cc:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
References: <20200901130644.12655-1-johannes.thumshirn@wdc.com>
 <42efa646-73cd-d884-1c9c-dd889294bde2@toxicpanda.com>
 <20200901214613.GH12096@dread.disaster.area>
 <551b2801-d626-9bd7-7cb2-9d20674c06bf@toxicpanda.com>
 <20200901235830.GI12096@dread.disaster.area>
 <d2ba3cc5-5648-2e4b-6ae4-2515b1365ce2@toxicpanda.com>
 <SN4PR0401MB3598CDEB0ADC4E43179DE2E29B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <43272cc6-4d40-caf7-8777-4ef1e1725c97@toxicpanda.com>
Date:   Wed, 2 Sep 2020 07:10:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SN4PR0401MB3598CDEB0ADC4E43179DE2E29B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/20 3:12 AM, Johannes Thumshirn wrote:
> On 02/09/2020 02:22, Josef Bacik wrote:
>> Instead now we have to rip
>> it out until we figure out what to do about it.
> 
> I don't think we need to rip out the iomap conversion. We can
> take my fix albeit not pretty, until we have reworked the locking
> around ->fsync(). Probably with a big fat comment attached to it.
> 

We do, because your fix breaks DSYNC for AIO.  You didn't hit this with 
direct io, you hit it with AIO, and the reason you hit it is because you 
are on zram, so your bio's completed before we exited iomap_dio_rw.  So 
that was the last put on the iomap_dio, and thus we ran
iomap_dio_complete() and deadlocked.  We can't just drop the DSYNC thing 
for AIO because in the normal case where this doesn't happen we need to 
know when the last thing is finished in order to run ->fsync(), we can't 
just run it after submission.  Thanks,

Josef
