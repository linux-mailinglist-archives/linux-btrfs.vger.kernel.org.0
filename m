Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BADE697DF6
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Feb 2023 15:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBOOFK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Feb 2023 09:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjBOOEz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Feb 2023 09:04:55 -0500
X-Greylist: delayed 177 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Feb 2023 06:04:54 PST
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CBD34C3D
        for <linux-btrfs@vger.kernel.org>; Wed, 15 Feb 2023 06:04:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676469533; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=OywmAq8XCxaEmaYHZ1jxBdyjm8hf31K3w7oFwW7IzunaBamUUh8u4YUskUIKNVst+o
    W1orBDsU4Qyd2hTViR0ozwI1t6rKi7a+2Yk2r13I2/xqRWTgBao5ekLzYFeicNev/kej
    RYteQTq0ICigLB5bFSoy1k9KoC1Nh0kojfKsjtbwN2AEyUsz+196DWLvXtMWk1qQ4a+y
    VBqoopAxc+w7ESpQl8QpOl/harENZCKhxuxOuUBKZxnyoJdvbJRo0bM8Rz6QRPgeV4Ei
    ie3U/0ccWcDhN9RGmfsEd1qkvCG6iCB8lryuJNVu25izGygOIVcL6XDoEnQPz/sySunn
    9MiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1676469533;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VrvrRZgsYJKPwXt5vvHnPBvbqOz3NG+qjb0NA2iMeWM=;
    b=ET5v+ARCAWVL+qkEnxhi1wRyqSbv/YXXg1YVmCyXLCQFfIJtzTiKM3easNwTW/v5Mi
    kqzYAGh+oTe2j5fOtUW6zfK+CyNyR9UE3genze5qKKFFs0+uHI067puiQFcmDb17nyVn
    CiTZk5J3FrV39V3VzpZciezwyR9Qs7BQws0EwDkwgPPq1wORXBdwqZcc49KtRuind7rE
    +1Ncz0/uTrZ4yPqRMowJe5PgP4Cvv+5BNNad3tAyg9EbDtsKfMF6YZlVFcUo9wuclgIK
    wlhUDE0md1/59PMqs7kLzzXJ4S/b/i8rh4yc7qfYr9YBPczheiCKYjEt4Nha4DBy58BG
    JAqw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1676469533;
    s=strato-dkim-0002; d=giantdisaster.de;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=VrvrRZgsYJKPwXt5vvHnPBvbqOz3NG+qjb0NA2iMeWM=;
    b=gjT8Oz77+YGNNoLZsWRp+79gpIgju6mPKASmPSEvawXJkr1wwK6fWdvB4VIFRcdLBL
    FM0IQRIDwOQh1YxEyS8zJ+/SnGxL+KMlZy4ywSLb2ITy3i1fxcMWt7rSpDk23taC2xVe
    3QIfMgji1tKZmcNITeYDDvhgZ4K2Ctj/xaXYUp+s/v8UvG96JdX7KyksmZoiEgIzPTyA
    d5mqtkUCuzoz/PGvl2ExG9QhnxCrQuYLSbBzva9ctxCQMKiIqVW3QIYTJWZqalwPBSzH
    i3vS9vAVcX7O1T6I5LTC/lNYeI7O4wZfxQIX+FXadpnSy9OUzCEnM6OZ58w1QMpJROSB
    Bk0g==
X-RZG-AUTH: ":P24BfVKtdewSqNxKJHA7pzS3qMJDcjZcfhyLxL2YKij8O05xyuukTyyZQWU4Hq02P4TcpQpuN2yc"
Received: from [10.208.10.37]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id 0266b0z1FDwqhNf
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 15 Feb 2023 14:58:52 +0100 (CET)
Message-ID: <7f78db15-7f82-5349-a4da-6fa58365e3e0@giantdisaster.de>
Date:   Wed, 15 Feb 2023 14:58:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH RFC] btrfs: do not use the replace target device as an
 extra mirror
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
 <Y+sy5xHfz6S16/oc@infradead.org>
 <e7a2cb06-d6b1-f40b-477a-dca130a4a5d2@gmx.com>
 <Y+x+GjgREMyYe5pP@infradead.org>
 <d2f73a10-7ec8-0b42-1a4e-eb86b0740741@gmx.com>
 <Y+yCncfD0EyfsxTe@infradead.org>
From:   Stefan Behrens <sbehrens@giantdisaster.de>
In-Reply-To: <Y+yCncfD0EyfsxTe@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/15/2023 7:58 AM, Christoph Hellwig wrote:
> On Wed, Feb 15, 2023 at 02:56:39PM +0800, Qu Wenruo wrote:
>> Meanwhile replace hasn't yet reached that bytenr, thus we're reading garbage
>> from target device.
>> And since NODATASUM, we trust the garbage, thus corrupting the data.
> 
> Yes, for a read from the target device to be useful, the progress
> needs to be tracked, and the read only needs to happen on data
> that actually was written.

The device replace code maintains (or used to maintain) a concept of a 
cursor.

There's a small area on the target device which is currently written to. 
Left of this area is valid and already written data, which can also be 
read in case it's needed to fix read errors or to avoid access to an 
almost damaged hard drive which tries to reread every bad block 2048 
times (which is 17 seconds at 7200rpm and something you want to avoid). 
Right of the area is data that must not be read because it is garbage 
and uninitialized contents of the new disk.

There are several comments about this concept in volumes.c. And scrub.c 
is the place that keeps the left and right cursor up to date which 
define the area that is already written, currently written to and not 
yet written.
