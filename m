Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BE9025B203
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Sep 2020 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgIBQrh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 2 Sep 2020 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgIBQrb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 2 Sep 2020 12:47:31 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2E7C061244
        for <linux-btrfs@vger.kernel.org>; Wed,  2 Sep 2020 09:47:31 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cr8so2510853qvb.10
        for <linux-btrfs@vger.kernel.org>; Wed, 02 Sep 2020 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nQO25q/nLJlT714Y47ryMfDUol79zpKt8MoXwz+JXQE=;
        b=1BOaZ3IHykF6uTh/alOkTs9HN/UfH3yOmQCS/8iYCkuUeSyHxcwAPGggWx/XZpdmBg
         LEUD+TdcmFkG21gKFnrER/3zTX2Z2Ge+vW4E3jJTz1sAdth2N0NTRX3EYNAwoSDTc3nE
         Y2jVXTrb0p1IaDxgZtvBIIOVzBaGSNR7a2H75PBknulTt8VNV1qPqdnCjCPuMQ3Fi051
         t01Ph8rMdmNNYjIkikSTZFCx/81LR5NeN01BL8KBRFaxNj45EndO+OVzovmXR8+Y2GRb
         yvij9sstV57pS37wd6TbPPORXGYjQrRsAUO0odeshnG/Mbqw5jptdUFvPjqLqfI5z2iQ
         4qBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nQO25q/nLJlT714Y47ryMfDUol79zpKt8MoXwz+JXQE=;
        b=B7DwfwXSpp2gmiCV0ORp4R45z41dUZXyxfl/q7DJE9V5EwIcLvhlwWAvCJtp98on2N
         uOdHuTfoiMe024HsfT/0CRhnvoCUme3hxsyVrDQfk50ugRamXH7Q+mg9ZcTJIf32uL1p
         Fx90B4k3gL9r7M3B00O3ji8zqmZZMxVIzuJzVshGWRyh2ou67TW2L0MbThl1A+8+ZU+A
         ISimjmlv0+kdKrdpuLV2oLLduojUEGrqQMeH8a1d3MBSERvvW2vR+8Fnsj7aINALyS3A
         Lg65v60KjeFRK7X6vukoK+Vq7t9qiiD9P1geWOv7KY0N1eV5ryxpEjF2+6C4EEI9be+S
         gm7w==
X-Gm-Message-State: AOAM530mOrmLxkfySHRDgpu34/7HwPf7crgrBBFxuJi+esC6B8pHw0+s
        fe8asMM2echkTmt3+Fxp6j6cAg==
X-Google-Smtp-Source: ABdhPJx9o4MS6u5mDx2f/nXu8wNg5QtPFOurFOw5yD7Eg/YbqoOVd8AiCHx0iqRKMk+JoDdg30Nwrw==
X-Received: by 2002:a05:6214:178d:: with SMTP id ct13mr7541292qvb.195.1599065250411;
        Wed, 02 Sep 2020 09:47:30 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id n33sm4975846qtd.43.2020.09.02.09.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 09:47:29 -0700 (PDT)
Subject: Re: [RFC PATCH] btrfs: don't call btrfs_sync_file from iomap context
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Dave Chinner <david@fromorbit.com>,
        David Sterba <dsterba@suse.com>,
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
 <43272cc6-4d40-caf7-8777-4ef1e1725c97@toxicpanda.com>
 <20200902162944.GH6090@magnolia>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <d001c8df-1c35-6426-4000-ad1222af7196@toxicpanda.com>
Date:   Wed, 2 Sep 2020 12:47:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200902162944.GH6090@magnolia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/2/20 12:29 PM, Darrick J. Wong wrote:
> On Wed, Sep 02, 2020 at 07:10:08AM -0400, Josef Bacik wrote:
>> On 9/2/20 3:12 AM, Johannes Thumshirn wrote:
>>> On 02/09/2020 02:22, Josef Bacik wrote:
>>>> Instead now we have to rip
>>>> it out until we figure out what to do about it.
>>>
>>> I don't think we need to rip out the iomap conversion. We can
>>> take my fix albeit not pretty, until we have reworked the locking
>>> around ->fsync(). Probably with a big fat comment attached to it.
>>>
>>
>> We do, because your fix breaks DSYNC for AIO.  You didn't hit this with
>> direct io, you hit it with AIO, and the reason you hit it is because you are
>> on zram, so your bio's completed before we exited iomap_dio_rw.  So that was
>> the last put on the iomap_dio, and thus we ran
>> iomap_dio_complete() and deadlocked.  We can't just drop the DSYNC thing for
>> AIO because in the normal case where this doesn't happen we need to know
>> when the last thing is finished in order to run ->fsync(), we can't just run
>> it after submission.  Thanks,
> 
> Bleh, Oracle mail (or vger or something) is being slow again...
> 
> It occurred to me that we added iomap_dio_ops.submit_io for the benefit
> of btrfs.  Could we solve all this for now by adding a ->write_sync
> function pointer to iomap_dio_ops that could lead back into a btrfs
> function that would flush the necessary bits without itself taking the
> inode lock?  And if a ->write_sync is not supplied, then the caller gets
> generic_write_sync?
> 
> It's kind of a bandaid, but maybe less bad of one than restructuring the
> btrfs locking model under time pressure...
> 

I'd rather not mess around with the generic iomap stuff for this, coordinating 
changes between generic and fs stuff is annoying enough as it is.  We've got a 
strategy to work around this in btrfs so we don't have to rip out the iomap work 
right now.  And then we'll rip out the workaround once we've reworked the 
locking, since the locking stuff will require a fair bit of testing and soak 
time to be sure it's safe.  Thanks,

Josef
