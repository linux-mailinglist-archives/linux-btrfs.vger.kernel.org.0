Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2424545A683
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 Nov 2021 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238328AbhKWPa6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Nov 2021 10:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbhKWPaz (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Nov 2021 10:30:55 -0500
Received: from zaphod.cobb.me.uk (zaphod.cobb.me.uk [IPv6:2001:41c8:51:983::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A9C061574
        for <linux-btrfs@vger.kernel.org>; Tue, 23 Nov 2021 07:27:47 -0800 (PST)
Received: by zaphod.cobb.me.uk (Postfix, from userid 107)
        id C520D9BB43; Tue, 23 Nov 2021 15:27:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1637681263;
        bh=O4EOb9qDLmpFs9ag7UYCEp5vXc0RE42PkXzOdVYr2TE=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=LeFWfuMwsiZadUR+UIGBfTG097tqHbaTaKIviN63Pa07rKLRSoHAyVVENnlQ9BWAY
         IATOtrCUWquW/9EJHxgC2AV+XFPG3yvbew3aRqGKs8lRVef5d/cPzmxuWsjIHnGKhP
         QJQnA4C//5X5z7Y3noRIyB0b2NKx8hFCm6ZHq6YRXLZQPjK25ZtetYW2O2huEhbMOQ
         eQ52rjM1dcJMrPSAR2GoZyOESV5356Bv73Moq20fGFSAVnTi1FV7EO24DFkT7pQHhG
         dAOIgiEULgvxttDSszSeuVCbAOd1IxtXbRhJx1kf4K7kxheckcHthtCenJmib60uOS
         E3gL8/i1Kc7hQ==
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on zaphod.cobb.me.uk
X-Spam-Status: No, score=-8.4 required=12.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A
        autolearn=unavailable autolearn_force=no version=3.4.2
X-Spam-Level: 
X-Spam-Bar: 
Received: from black.home.cobb.me.uk (unknown [192.168.0.205])
        by zaphod.cobb.me.uk (Postfix) with ESMTP id A6EC29B84F;
        Tue, 23 Nov 2021 15:26:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cobb.uk.net;
        s=201703; t=1637681217;
        bh=O4EOb9qDLmpFs9ag7UYCEp5vXc0RE42PkXzOdVYr2TE=;
        h=From:To:Cc:References:Subject:Date:In-Reply-To:From;
        b=Ltw+N/HImrVqiVtDt9+x7DGbWxqGdzFnPY/omUZyT2YNsSAO3W6EbOmzXimFamJ2p
         jnG7RcOapSArHJEGIg4rrNHBHtoOlmBqUuTXUdl+zSGQp/c0mfIq0J2dqnfa+OSyY2
         egiTfrrtaJ2Tyjbqwfpo0o5mxrjYGt1sEaOUCptajd/jSNaDmRBSivIdqgQ6O6ZTcQ
         5/wkT1+2LjpGYL9HL5e1lCp1QpPCIsDHHHT3LQkIcJ17SE5RAfPplMP5L9cVzlbIyl
         kcYugcO+5btJ7m9izJeE8jZey2i3AXHiua3t1Xit9TrtqjAXbHB17wPOtuMc6pMeGg
         AXIhqJQluBE8A==
Received: from [192.168.0.202] (ryzen.home.cobb.me.uk [192.168.0.202])
        by black.home.cobb.me.uk (Postfix) with ESMTP id 5379A2C6524;
        Tue, 23 Nov 2021 15:26:57 +0000 (GMT)
From:   Graham Cobb <g.btrfs@cobb.uk.net>
To:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, kernel-team@fb.com
References: <3990fc5294f2a20a8a4b27c5be0b4b1359f7f1a6.1637618651.git.josef@toxicpanda.com>
 <e31d5b36-a8f3-05a1-040a-7295c3f64b42@gmx.com>
 <YZz64qAUHAZZnxPO@localhost.localdomain>
Subject: Re: [PATCH] btrfs: fail if fstrim_range->start == U64_MAX
Message-ID: <fbc40cff-df59-5d58-b9cc-32759472e1c3@cobb.uk.net>
Date:   Tue, 23 Nov 2021 15:26:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YZz64qAUHAZZnxPO@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/11/2021 14:29, Josef Bacik wrote:
> On Tue, Nov 23, 2021 at 07:29:04AM +0800, Qu Wenruo wrote:
>>
>>
>> On 2021/11/23 06:04, Josef Bacik wrote:
>>> We've always been failing generic/260 because it's testing things we
>>> actually don't care about and thus won't fail for.  However we probably
>>> should fail for fstrim_range->start == U64_MAX since we clearly can't
>>> trim anything past that.  This in combination with an update to
>>> generic/260 will allow us to pass this test properly.
>>>
>>> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>>> ---
>>>   fs/btrfs/extent-tree.c | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
>>> index 13a371ea68fc..6b4a132d4b86 100644
>>> --- a/fs/btrfs/extent-tree.c
>>> +++ b/fs/btrfs/extent-tree.c
>>> @@ -6065,6 +6065,9 @@ int btrfs_trim_fs(struct btrfs_fs_info *fs_info, struct fstrim_range *range)
>>>   	int dev_ret = 0;
>>>   	int ret = 0;
>>>
>>> +	if (range->start == U64_MAX)
>>> +		return -EINVAL;
>>> +
>>
>> Isn't the next overflow check would catch anything which length is not
>> U64_MAX?
>>
> 
> Yes, but if you do range->start == U64_MAX and len == 0 it'll pass.  We're being
> pedantic here, but it's a simple enough sanity check.  Thanks,

Out of interest, what happens if you do range->start == U64_MAX - 1 and
len == 1 ? If that is allowed, why wouldn't range->start == U64_MAX and
len == 0 just follow the same code path?

Graham
