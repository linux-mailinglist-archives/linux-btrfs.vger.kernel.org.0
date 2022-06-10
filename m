Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37539545DE1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Jun 2022 09:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346496AbiFJHz7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Jun 2022 03:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiFJHz6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Jun 2022 03:55:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4850854025
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Jun 2022 00:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654847742;
        bh=lFjIDah41EXiLsfsHs0OW88rX3SxmkRX52JlgKAJdW0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=MYpeUCbf3z8Bi70DqH/mKJRXFecXu9yJVm0PgMhR05HfrDlacV8Rmuf1CenJ1lt75
         9sJZUybIqJG1mWhLy23f3P7ruZIUTyBvWDud+Q9H1s3cGX2HHbx1tKAvGaVxGb/adQ
         8RwtzqOnvsTcLc5mYnZhRImRY1mvP/yiOp4gHco0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mnaof-1nImXw4Bu9-00jZGs; Fri, 10
 Jun 2022 09:55:42 +0200
Message-ID: <1440ccc5-3df9-a613-b923-ecc4a3e6e2cf@gmx.com>
Date:   Fri, 10 Jun 2022 15:55:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] btrfs: use preallocated pages for super block write
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     willy@infradead.org
References: <20220609164629.30316-1-dsterba@suse.com>
 <ed4f2880-b4f3-cf16-00c9-b107141a7421@gmx.com>
 <d1957ade-a9be-c1e4-1356-89d3e73bb121@suse.com>
 <51502090-6278-ae62-8084-b995cf04caa5@gmx.com>
 <237c58a0-dfc2-a99c-9559-394831de0ee4@suse.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <237c58a0-dfc2-a99c-9559-394831de0ee4@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:L8bAuEoEYxdU+PApI2pUYermKJqfZsZi8z9mGNfekUJePmTUAFM
 kKvU0cRax6KEy6yelzkkFXq0w48IwlK92/nTJxAKqLLuPZTTN/qi9VVP8LwpAHmbqm3ZA37
 nXfVI5Tg2NR62wLhTvVSQOd7mbagVzGUrSalzlIUuVhQX4P2t3Aure2NCWCraR7GvrLhsmJ
 WDSCofOdNsRu3r3oZRL5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jP8GjpOdUfQ=:UE7Ob7emtAvVMAu8mOSuX3
 xjpG5fU/dCUWjWkXuhJnwLPJUPj8ldt92Hxp9YU3rljENGGpsiK70BHSuPNy8shezjNZ5n2aM
 JkLULz/fVORKcJTDW/RBKHDoAyHz0rXGJ45dgVy+DR0BL4glT9I2zt0yTwL/seVhhMp+dyvqM
 oYCmWptcOy1QCesCzyTTv3yYaAajVx0FWTkq6Rx/7cyWflogq4QlpmJ5MeIwQl2RPkKnqKr6k
 whlsrVHEkTnc+mvImslUegvGMcaQPIm5aAydHWzoUw+1mwfPo+SADT6BesrZkjT1d0zCEZZ2y
 yfZmOG8U0oUCgj6oHw7o69ucR/cLwoSJ3oG7Nt4C5pF1S28zd50/PQu83WyB6BTErckEtgnAi
 ULVhJwC7659NdtMmMg3BXlkvmaXhp7XRZyoO9GFLsmsHq+zADS44xw2GlhpO5C/zE0BitOlOm
 1o1N0F5CUDQ/A19ixEr/Kfrjvmxpql2HjOTrBj/nOrIqDsv+w3fzt3EW11z/kZy7mhj1Qwv38
 u+yJ0IGoDJAKKFmvnXVXSR1nHirGNl8GSKo9eWXvft/oWrdtA7rpDJsexBuGsylcv6FxszVGN
 cwrM+1mv6Y20hpCYwRwvVysCYYbyitkSS2XinT9m1scr4xaaEAHH1QzXl5eBetvzGSbSl/CSo
 a90ATQYTkUqhZ+p2madXVB8iPv3BpvsHfnLP5GciK733wlNBP1ZABxMgB+/V5+2TyFpH3lxI4
 eaYFhi13Z9WscmxVVo5FJKuHQTL7ubleUOGtJpAjMXYxVJ8Rxywr77BtSk+89Zx2rvg72+Kut
 WkTNcijFIHSxTyws0/ac43IZB6I0isI1fyO3QLXuA69wiaUShjIGvoIB9wBqmwCSvLgP9/aSS
 CBRNKnd4/8hE5OE2oWXMSr47r+bwf5pNDmDcQorZ+M8tpkHbEsQ98cRmnmSt5n86HLNG1uAlz
 VhIKXQ9EhJS9jeGdJJ/Jdxxi7ZV+JNUbqwKxVpIH3WnhJYnxgZ/+NhB+u1DHnZJ5/r/609O37
 PGMSMBJ6+qmw69u3f/BMTgqaoC7/58Mb0fpfz4KMKqL0/RFO2/GCmnvbPYgVaj41AWndP/aBM
 jeegZnua3SKde+BOfHV/0+hW7E/IggN+egwQP9zPwnDg4M8emaSxHLYKg==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/10 15:39, Nikolay Borisov wrote:
>
>
> On 10.06.22 =D0=B3. 10:33 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2022/6/10 15:23, Nikolay Borisov wrote:
>>>
>>>
>>> On 10.06.22 =D0=B3. 3:07 =D1=87., Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/6/10 00:46, David Sterba wrote:
>>>>> Currently the super block page is from the mapping of the block
>>>>> device,
>>>>> this is result of direct conversion from the previous buffer_head
>>>>> to bio
>>>>> API.=C2=A0 We don't use the page cache or the mapping anywhere else,=
 the
>>>>> page
>>>>> is a temporary space for the associated bio.
>>>>>
>>>>> Allocate pages for all super block copies at device allocation time,
>>>>> also to avoid any later allocation problems when writing the super
>>>>> block. This simplifies the page reference tracking, but the page
>>>>> lock is
>>>>> still used as waiting mechanism for the write and write error is
>>>>> tracked
>>>>> in the page.
>>>>>
>>>>> As there is a separate page for each super block copy all can be
>>>>> submitted in parallel, as before.
>>>>
>>>> Is there any history on why we want parallel super block submission?
>>>
>>> Because it's in the transaction critical path so it affects latency of
>>> operations.
>>
>> Not exactly.
>>
>> Super block writeback happens with TRANS_STATE_UNBLOCKED status, which
>> means new transaction can already be started.
>
> You are right, in this case then I guess we can still stay with a single
> page and synchronous writeout but this needs to be explicitly mentioned
> in the changelog.

Then I would be way more happier to convert all these bio submission
path to submit_bio_wait(), which makes our error handling easier and get
rid of the super stupid endio function.

Thanks,
Qu

>
> <snip>
