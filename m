Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D0252A375
	for <lists+linux-btrfs@lfdr.de>; Tue, 17 May 2022 15:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347860AbiEQNc5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 May 2022 09:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347192AbiEQNcy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 May 2022 09:32:54 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A142A09
        for <linux-btrfs@vger.kernel.org>; Tue, 17 May 2022 06:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652794359;
        bh=RVN/aMQ2n6/gu9ESXleBobhscrFmgy99gkFW7Hst0tI=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MWXJYzHGqcoM2l1dy9iKXOoIdc56rKi+TDiEntKcny3BAUu16OnAJY8cm17k1RiFW
         0njt3M5NQW32HYlmvk49kYhGdaBgG+5G+hk964qZOxE33iSXVN0//jY53Vh2MIDkeY
         yi0pf7UPcELBb+SVEBLuyCd+OfN6Vs3bD/J00j5I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M26vB-1nst7n3wHR-002b0b; Tue, 17
 May 2022 15:32:39 +0200
Message-ID: <2e4f065f-3c97-8266-308e-38e78c504f04@gmx.com>
Date:   Tue, 17 May 2022 21:32:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 05/13] btrfs: add btrfs_read_repair_ctrl to record
 corrupted sectors
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org
References: <3f9b82f1bcc955fbb689a469e749cf1534857ea1.1651559986.git.wqu@suse.com>
 <YnFE62oGR5C/8UN2@infradead.org>
 <dac4707a-04f4-f143-342b-cd69e0ffcd80@gmx.com>
 <YnKIM/KBIJEqU/6b@infradead.org>
 <efb8bdf0-28f0-0db9-c2b0-a08ffbd22623@gmx.com>
 <20220512171629.GT18596@twin.jikos.cz> <Yn40Fkhz0jyef1ow@infradead.org>
 <5520df08-b998-a384-f1aa-16b301474cab@gmx.com>
 <Yn45tomlUQ8mGyVs@infradead.org>
 <581432b0-9324-8509-2737-a57f19c93937@gmx.com>
 <Yn4/qQmrWkRymqCV@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yn4/qQmrWkRymqCV@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:63VY1QrTf5UJmsrcrDT24j50gblxqWveDSvzUUsYpGbBRYaTnza
 lEBYnJjnyu17kpx2UDm5xpBXkbxC3t7tDTJ7jFiyUQ1d0slLpFYOZCePAI79bBKAqKosvkh
 Pm5YZzy9DqjtYDmvXLL0OWnwvCEIaIkqDIrDn2o+oJqNw/g0WwNiMPLg5wlgFuLzrZmD8mZ
 NzomRa+nwSmLFCOJDY08Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rzleJ1BOwMo=:8SpR5Eo2kSqRwPoD01LlVR
 a4WCaHQY0Qhpg+Y7HZtOpGbDxWACY+hthF5TWErYGvpZdUuuzMfQmuiMeAHQHlX1aXDaouAVN
 HgtKsosif0acvM9JOIXI4x14fSPjeaFZN9e5b17cR0h9fc2sFoynxbLNgt43ZYXEOmTb5hDcc
 MkkNaL9HoZ0jZpnXJRBhGPpB7zVqu28GHCkcOIU2phaey2/LMGoNYV7t14tmyP+Y7EQj7+aiI
 fMv4qSzNSHHlpzDBSn92t+DegrXo0kKDNbI1bzd3P6ZYCe11ajLaQfVSfQOfEG38e4fczbmpk
 rayX01jNF8mtiMZYzmRGjKiSJCsR17a+LyquG5fl0JgM7/tcFwzC43tXjm6PdQ4HgXdPjHb78
 KJXueiKUBYtOxX4xKBzGFIslsgub/Ux681qlw/+hjTcfoCZvBlI7FxG+/nqbdDGZy1lB0sz2Q
 7b0LwmvQ3nfyDNmbEQJ4Nq2ISIbKNmhiyRi4swszOy3z7vR//FVMx1z4fjpNU9xagUo3Me8xP
 bezHUw2SB3+aiw1eeHFN4g44xaTZ1ZYYvgCDhWiBqwjvfGhUY0LW4XV7fTdXCuRvg7IsewtsZ
 uvLwM54lIL2T99CNRngYiAWbskbBcXnYOz1mYLVX/8ykq/lyzl4lyHbEw4xc14g/oqVjG6EXt
 6lNqPH3rxHga5Beh2AWQpLU2FdHa8l/CM03Y8gNtpinrP+khYR7YWtEkongv/S7pnIOOU13cO
 3xjxYdTH053zQdoHDeYhK9HaxWNSTQIkJpnC3kGt2gVc71jvxCUA8i8x36J2Q3cFTPgKJyVQG
 l/2dHUFPf2n5lsJoE0hrzMeul4qfUBYD/CcQmr9kcRCKaQ7krvzA8N/zazMYUKtoBLZDROC8o
 F00mML3nesPfCyX9vrnFIuxhC5WvivrcqX9W9h4BgiN686eFH/brwPImshWRnjlf0mk0+bPCI
 NA8lIU7Va94A+3XQRLqsZfkisjih6yYb0mia1jqfwKPaVLjmfg4kWl+o7vfjtu+1IZUVG40a3
 xm86gnHR8i0QjUEaqxWqFrdaXkv0XzJQPJ7LmNlSoYWk4erea66GJIo9Fb9mKCUdXx0dyQJks
 xF6ra48UKnjCc4JpeM+BVaXob3JZkOCC77sqaDrcyBLW4xKx5XEZbUhWw==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/13 19:23, Christoph Hellwig wrote:
> On Fri, May 13, 2022 at 07:21:55PM +0800, Qu Wenruo wrote:
>> This middle ground is still synchronous, but batched.
>>
>> Although for the checker patterned corrupted sectors, it falls back to
>> fully synchronous submit for each sector.
>
> Indeed.  But how common is that case?

Well, my initial reason on the super slow repair (but super simpler) is
even more extreme:

   How common is data corruption other than the crafted test case?

I know there are data corruption in real world, but I doubt we would
have even more than 1 corrupted sector in a large (128M) extent.

But since your newer idea will also assemble a larger bio without really
causing new facilities, it looks pretty reasonable to do that.

So, yes, I'm pretty happy with the idea, as long as there is no strong
objection against the possible but rare performance drop on it.

Thanks,
Qu
