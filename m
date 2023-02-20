Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F68769D0EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 16:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjBTPtk (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Feb 2023 10:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBTPtj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Feb 2023 10:49:39 -0500
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE14F1F5E2
        for <linux-btrfs@vger.kernel.org>; Mon, 20 Feb 2023 07:49:35 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id 2ADB23F6E4;
        Mon, 20 Feb 2023 16:49:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.156
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DOrHdQxzABgR; Mon, 20 Feb 2023 16:49:32 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 5EB9D3F6DE;
        Mon, 20 Feb 2023 16:49:32 +0100 (CET)
Received: from [98.128.186.112] (port=58961 helo=[10.0.155.198])
        by tnonline.net with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <forza@tnonline.net>)
        id 1pU8Pz-0007LO-Rz; Mon, 20 Feb 2023 16:49:31 +0100
Message-ID: <0282b6d0-b131-3b3a-084d-8c8de2f522a5@tnonline.net>
Date:   Mon, 20 Feb 2023 16:48:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Why is converting from RAID1 to single in Btrfs an I/O-intensive
 operation?
To:     waxhead@dirtcellar.net, linux-btrfs@vger.kernel.org
References: <87wn4fiec8.fsf@physik.rwth-aachen.de>
 <04ddea4e-4823-00dc-c32c-700d9f7e1fef@libero.it>
 <87a61bi4pj.fsf@physik.rwth-aachen.de>
 <8531c30e-885b-1d8d-314b-5167ed0874ac@libero.it>
 <87k00dmq83.fsf@physik.rwth-aachen.de>
 <c27655bc-8582-07e2-236d-e3afc6860d13@dirtcellar.net>
Content-Language: en-GB
From:   Forza <forza@tnonline.net>
In-Reply-To: <c27655bc-8582-07e2-236d-e3afc6860d13@dirtcellar.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023-02-20 00:39, waxhead wrote:
>> Hallöchen!
>>
>> Goffredo Baroncelli writes:
>>
>>> [...]
>>>
>>> Just for curiosity, I know that the BTRFS RAID1 is not the fastest
>>> implementation, but how slower is in your "I/O-intensive
>>> operation".
>>
>> What exactly do you want to compare?  Be that as it may, I have no
>> benchmarks.  Originally, I was just wondering why RAID1 --> single
>> may take hours, given that all data is on both disks anyway.
>>
>> Regards,
>> Torsten.
>>
> So what I think you would like to have answered is : Since RAID1 has two 
> duplicate chunks (A1 and A2) why could not BTRFS simply change the chunk 
> type of A1 to single and discard chunk A2.
>  > Personally I don't have the slightest idea why , but I imagine that this
> perhaps might be possible with the extent tree V2 changes sometime in 
> the future. Meanwhile perhaps someone else would like to explain why...

I believe this would violate the "CoW" nature of Btrfs. In other words, 
it would introduce a change in-place, which is not possible with current 
current way of working.

There probably are ways to make it safe and atomic, but maybe not a high 
priority from the current devs?
