Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A207C4B5ECA
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Feb 2022 01:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiBOAHa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Feb 2022 19:07:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiBOAH3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Feb 2022 19:07:29 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8903F97BAA
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 16:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1644883640; x=1676419640;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=no1vTKpzUgCwKxOTRf2OpHRqjB4QlJaghxZ9PHaSUIc=;
  b=DZk7WIVsrTPtQOSaAWM764eY7DdAPDUl5OEMXzYpdrpn6nUhRSUayxBA
   /t8R48cCwMXohNfQXuLIFVX+kmhVgvgrPHdeLDufMRMPvrogBX3zdoBBq
   41EebuBjskCtrbryT5BSlheBD+Cx9plgqmyM2GTHTyKZNDna9udjh3y7f
   JAXbppgWmP8VcuTIi4RsXWiOd+1gVp9kPL65hYFb/q//pRvcgVGoODUbD
   Yb1MD6Wc5hxOPXjDhmDCIj6Ow9p3qEviNu142BAeYvTlLTmi3KQw09eIk
   7tmPn7X1cr35BodvTEq9j5wFVjdd4/znc4qFTBumRdSyeDr6uQ4kds6f3
   w==;
X-IronPort-AV: E=Sophos;i="5.88,368,1635177600"; 
   d="scan'208";a="297009705"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 15 Feb 2022 08:07:18 +0800
IronPort-SDR: iQRVZDQ9HFrRqbTCvuwGzufqgoRCdMkA4yg5G6QPc5fsivoZsiNbhlNrB/BwhkdoJm7QGn93it
 p3mEhJ5SgFgQyPA5ibgv8U6qUWjLJxIf549wIicvenga2/OkcN4XoMnphCLSmVIJCbxgWutlFO
 GDCT+sg5SE+YWbcOVGOMufElyf5ER0WtEvUXo0VddpS2TOJ6ampXiuIoZBkFnbBho8z4irDwg2
 AZImMCluiIHYkoM50FZnfYJa478q15U7/yaZNKAaow+dFB4Dk7FVECIexXc2uLZeCxq8PjSMSB
 uT1L6LyVjK2qeLV1QQxIJ5op
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 15:38:59 -0800
IronPort-SDR: 9NAENd53ySpT2GgraAOTPxC4lKK6eA+qGNBwMCbEho8SZWZdeCamGDkcFh8+ETX592ZEQJ6Eri
 6oDNzwBB2c5V9oqr09Dpd3DK4qB1v9bzmJwRUFao5yY+hISBEeSUG4chUTt6KONZ0FD/8hoJMR
 LuZUqHcxh8LfxhikMxTTRILAn9QmmLpxhuRYxg54yrLnhyqbX5dtpxxriOHvEi6rRR92uf/XTU
 2UgocD81d5eod22t9cZ+jBmrTX2oUZsR0UR5q+DncEM+dnKdo7mTHM/u0zTqIlZMWQdReKXZ9+
 F68=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 16:07:18 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4JyLxd71tSz1SVp2
        for <linux-btrfs@vger.kernel.org>; Mon, 14 Feb 2022 16:07:17 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1644883637; x=1647475638; bh=no1vTKpzUgCwKxOTRf2OpHRqjB4QlJaghxZ
        9PHaSUIc=; b=k3CXZgKpRZEtWRHs1pIKLyD/9luafP6XxEzFJXkYGRwm8brySSG
        11JAiynNIzbowVgMusFwVj2RB/xfmdEymqtYsmZzQVvb7Jwv1WasOnQig3uTnSOB
        0t2EFTFL+5zxil/JSbBKTG8WfX8t5wkTDTFgf1kgcUCWuxdirlq/QX7Bv9VD7ohS
        r0UKzCJL0WjNmRSOD4DQD3FRHvh2NHb6CABabqPAwn5P173S9laOmBi8LotgPu3p
        bCyFdhPcbtfkDEZwCL8t5sa9u+2oyO0ap30zWIhUXPZ1kmAj2fNWJLwCwrr/gQ1q
        V2rOWx/iY1OVwiTvpEcMUihO28/49BKGRew==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 03Ev7CSn9ee1 for <linux-btrfs@vger.kernel.org>;
        Mon, 14 Feb 2022 16:07:17 -0800 (PST)
Received: from [10.225.163.73] (unknown [10.225.163.73])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4JyLxc1NGBz1Rwrw;
        Mon, 14 Feb 2022 16:07:15 -0800 (PST)
Message-ID: <c2366bd1-6478-554c-14c0-36c58928aa83@opensource.wdc.com>
Date:   Tue, 15 Feb 2022 09:07:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] fs: add asserting functions for
 sb_start_{write,pagefault,intwrite}
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>, linux-btrfs@vger.kernel.org,
        johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
References: <cover.1644469146.git.naohiro.aota@wdc.com>
 <40cbbef14229eaa34df0cdc576f02a1bd4ba6809.1644469146.git.naohiro.aota@wdc.com>
 <20220214213531.GA2872883@dread.disaster.area>
 <159d58f4-2585-7edf-7849-1a21b8b326f9@opensource.wdc.com>
 <20220215000515.GC2872883@dread.disaster.area>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220215000515.GC2872883@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2/15/22 09:05, Dave Chinner wrote:
> On Tue, Feb 15, 2022 at 07:49:27AM +0900, Damien Le Moal wrote:
>> On 2/15/22 06:35, Dave Chinner wrote:
>>> On Thu, Feb 10, 2022 at 02:59:04PM +0900, Naohiro Aota wrote:
>>>> Add an assert function sb_assert_write_started() to check if
>>>> sb_start_write() is properly called. It is used in the next commit.
>>>>
>>>> Also, add the assert functions for sb_start_pagefault() and
>>>> sb_start_intwrite().
>>>>
>>>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>>> ---
>>>>  include/linux/fs.h | 20 ++++++++++++++++++++
>>>>  1 file changed, 20 insertions(+)
>>>>
>>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>>> index bbf812ce89a8..5d5dc9a276d9 100644
>>>> --- a/include/linux/fs.h
>>>> +++ b/include/linux/fs.h
>>>> @@ -1820,6 +1820,11 @@ static inline bool __sb_start_write_trylock(struct super_block *sb, int level)
>>>>  #define __sb_writers_release(sb, lev)	\
>>>>  	percpu_rwsem_release(&(sb)->s_writers.rw_sem[(lev)-1], 1, _THIS_IP_)
>>>>  
>>>> +static inline void __sb_assert_write_started(struct super_block *sb, int level)
>>>> +{
>>>> +	lockdep_assert_held_read(sb->s_writers.rw_sem + level - 1);
>>>> +}
>>>> +
>>>
>>> So this isn't an assert, it's a WARN_ON(). Asserts stop execution
>>> (i.e. kill the task) rather than just issue a warning, so let's not
>>> name a function that issues a warning "assert"...
>>>
>>> Hence I'd much rather see this implemented as:
>>>
>>> static inline bool __sb_write_held(struct super_block *sb, int level)
>>> {
>>> 	return lockdep_is_held_type(sb->s_writers.rw_sem + level - 1, 1);
>>> }
>>
>> Since this would be true when called in between __sb_start_write() and
>> __sb_end_write(), what about calling it __sb_write_started() ? That
>> disconnects from the fact that the implementation uses a sem.
> 
> Makes no difference to me; I initially was going to suggest
> *_inprogress() but that seemed a bit verbose. We don't need to
> bikeshed this to death - all I want is it to be a check that can be
> used for generic purposes rather than being an explicit assert.

agree.

> 
> Cheers,
> 
> Dave.


-- 
Damien Le Moal
Western Digital Research
