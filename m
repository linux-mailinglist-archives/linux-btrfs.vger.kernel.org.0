Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE10695A77
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Feb 2023 08:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBNHSj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Feb 2023 02:18:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBNHSi (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Feb 2023 02:18:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A5FDBDE
        for <linux-btrfs@vger.kernel.org>; Mon, 13 Feb 2023 23:18:36 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MCKFu-1pIRuP1aEs-009PGm; Tue, 14
 Feb 2023 08:18:16 +0100
Message-ID: <e7a2cb06-d6b1-f40b-477a-dca130a4a5d2@gmx.com>
Date:   Tue, 14 Feb 2023 15:18:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>
Cc:     linux-btrfs@vger.kernel.org,
        Stefan Behrens <sbehrens@giantdisaster.de>
References: <2902738be4657ec16e5b5dd38eac1fb53aa5cc44.1675918006.git.wqu@suse.com>
 <Y+sy5xHfz6S16/oc@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH RFC] btrfs: do not use the replace target device as an
 extra mirror
In-Reply-To: <Y+sy5xHfz6S16/oc@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Fbs8RCJFQl+1gO1WcF+m98oExkedOh7bw+YZZdSBblT5sr5AOu+
 KJ15aH4cWvhFNSb+03hLj7VKPZm7uxuhO9SD9sQuVk4uFKb39xzW2Kb+8pPW7RIcBCcnYwB
 x0F7hvks4Wp2SXaSECLGklAr+luh6k0uS6Uu508tDEUN/l4ajEFHAX+A894P+dWM9loGgld
 sjIl93IUYUmSxRyYdV0yw==
UI-OutboundReport: notjunk:1;M01:P0:YhDsem/+Lak=;ltejuMLuB4AeptraT/OQGbbTxJJ
 sgAP+9qVQzCxnPbrq7+YegvbtGdn2HgvtxKDJr+IZBsEk314dQPebSdtMWaclIFzuG+i8soV0
 D4MQdkMeCnMYv8jA7hzXRJMX8YB7qV/v7hls3v2eAspBI9mXlGjCwbxzPYQ8a8SZO7/e8i7uo
 qS7oW2XDciSMgxShAdWb+ZDmzgxXk6+YcpbqVXRuSSeYjQFntbjF0KpFbjLiTpDe53v5nPtnQ
 ohOpyorXx9pV1ot/EWDXukA2exaBPeW6IN75tHDmz8i5TKTpqt+RW8PxWcZxYfD9MBe/8+9We
 ckcrV1uXppIune9o1XK7iLYnmQkbCydU01Fds2SppqI08oNoOM5+lDupFh96k7QFWQ9pj73mK
 1jLWGu4CAYuDnsqyB/qBVGGD0DdB3t0Pa1N/ubM023dbCSAAwlgdIFfqSlJ/bgArrLw94Wcls
 7/fAneydcM1sm5+wOrONdlkSdmQcPb+HHpXzSIn49LEncBf8fFzD8A1oqJptC6qZ5w3LZs1LZ
 fcIEcZBdqq99rZGdn2fukaeAGDTCJY+eZksek31cARHgJvMV3KUnD4w++U4qDNKWkyQduKZGP
 f8P+Iqtn8yG038BhHtLONOIh+p0yVJNTp5IwT1xAOSNcSYgd99Z7SSg0BsDR/NHmecRugGGuo
 AjEyg3goraf1TOwIZC/HazVeBhOEDQsP3WufCo3OSYQXji7F5picnPLH6JSI+lMGmowosZ7b9
 GILHUG9p0sksF5amsickDP0hEgz8jR8lrH4Qs01r2rFIAq03H9IQD9l3gzk6gFhjJxmofkxWa
 427LyDQ5Px83X4B86F7TJfEL7UIFBRIzgSAW5v7Y3yTg2IHcGT7RoioUy8NHZnXV9uZqDQ+Dt
 /pEw0Pr/nKGnFIzlBT9fzEUw4SNK9cnCx79ciTe47QfeLpLc1FvzODwrv+abJBkUjYBPHm2yZ
 R8MCksO0TUiviN2mH+ZhWALrcRM=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/14 15:06, Christoph Hellwig wrote:
> On Thu, Feb 09, 2023 at 12:47:01PM +0800, Qu Wenruo wrote:
>> Since the ancient time of btrfs, if a dev-replace is running, we can use
>> that replace target as an extra mirror for read.
> 
> More specifically this seems to go back to:
> 
> Author: Stefan Behrens <sbehrens@giantdisaster.de>
> Date:   Tue Nov 6 15:06:47 2012 +0100
> 
>      Btrfs: allow repair code to include target disk when searching mirrors
> 
>      Make the target disk of a running device replace operation
>      available for reading. This is only used as a last ressort for
>      the defect repair procedure. And it is dependent on the location
>      of the data block to read, because during an ongoing device
>      replace operation, the target drive is only partially filled
>      with the filesystem data.
> 
> and
> 
> commit 30d9861ff9520e2a112eae71029bc9f7e915a441
> Author: Stefan Behrens <sbehrens@giantdisaster.de>
> Date:   Tue Nov 6 14:52:18 2012 +0100
> 
>      Btrfs: optionally avoid reads from device replace source drive
> 
>      It is desirable to be able to configure the device replace
>      procedure to avoid reading the source drive (the one to be
>      copied) whenever possible. This is useful when the number of
>      read errors on this disk is high, because it would delay the
>      copy procedure alot. Therefore there is an option to avoid
>      reading from the source disk unless the repair procedure
>      really needs to access it. The regular read req asks for
>      mapping the block with mirror_num == 0, in this case the
>      source disk is avoided whenever possible. The repair code
>      selects the mirror_num explicitly (mirror_num != 0), this
>      case is not changed by this commit.
> 
> from which I father that the idea is that when a drive is replaced
> due to a high number of read errors, it might be a better idea to
> redirect it to the target device.

To me, avoiding reading from source != read from target.

> 
> The questions is how much does this matter?  NAND storage has a concept
> of read disturb, but we really should not be hitting it in practice.
> 
>> But there are some extra problems with that:
>>
>> - No reliable checks on if that target device is even involved
>>    For profiles like RAID0/RAID10, it's very possible that the replace
>>    is happening on one device which is not involved in the stripe.
>>
>>    E.g. a 4-disks RAID0, involving disk A~D, and disk A is being replaced.
>>    In that case, if our read lands at disk B, there is no extra mirror to
>>    start with.
>>
>> - No indicator on whether the target device even contains correct data
>>    Since dev-replace is running, the target device is progressively
>>    filled with data from the source device.
>>
>>    Thus if our read is beyond the currently replaced range, we may just
>>    read out some garbage.
>>    This can be extremely dangerous if the range doesn't have data
>>    checksum, then we may silently trust the garbage.
> 
> Yes, the way this is done currently seems pretty broken.
> 
> But there was a clear intent behind it, event exposed to userspace using
> the BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID flag.
> 
> So at very least the target should not be used unless a replace with the
> BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID flag is in
> progress.  I'm not really here to judge how useful that flag is, but
> if you want to remove reading from the target entirely we'dd need to
> remove that flag as well and print a warning for it, as it clearly won't
> work any more.
> 

I'm not sure if I missed anything, but doesn't that flag really mean, 
try other mirrors instead?

Thus that flag can still make sense no matter if we count target as an 
extra mirror or not.

Thanks,
Qu
