Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAE955745E0
	for <lists+linux-btrfs@lfdr.de>; Thu, 14 Jul 2022 09:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237000AbiGNHcv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 14 Jul 2022 03:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbiGNHcu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 14 Jul 2022 03:32:50 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD7930F7F
        for <linux-btrfs@vger.kernel.org>; Thu, 14 Jul 2022 00:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1657783963;
        bh=FAnSrHowkGkWmRjVc1c0WCEizgMVyUjLfLgeSEjxZIY=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=d0g98j1w/mqjGAEEfpkssn7lDncgC0JSdA6mGQlwRUdKjBvxdHRKCXS2Qm94MNZ6B
         Bmax982xD/r8422so89rYdXaRvlH1ZWMnX8k0SU59h98zO+5MU4UkUOs4L5qJbJJ3u
         etJV+1nxoweE3NQKy8wCNpPnO5HY5yuPjjdbuVNs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N49h5-1nTRrn2r0T-0104B4; Thu, 14
 Jul 2022 09:32:43 +0200
Message-ID: <61694368-30ea-30a0-df74-fd607c4b7456@gmx.com>
Date:   Thu, 14 Jul 2022 15:32:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: RAID56 discussion related to RST. (Was "Re: [RFC ONLY 0/8] btrfs:
 introduce raid-stripe-tree")
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652711187.git.johannes.thumshirn@wdc.com>
 <78daa7e4-7c88-d6c0-ccaa-fb148baf7bc8@gmx.com>
 <PH0PR04MB74164213B5F136059236B78C9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <03630cb7-e637-3375-37c6-d0eb8546c958@gmx.com>
 <PH0PR04MB7416D257F7B349FC754E30169B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <1cf403d4-46a7-b122-96cf-bd1307829e5b@gmx.com>
 <PH0PR04MB741638E2A15F4E106D8A6FAF9B899@PH0PR04MB7416.namprd04.prod.outlook.com>
 <96da9455-f30d-b3fc-522b-7cbd08ad3358@suse.com>
 <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB7416E68375C1C27C33D347119B889@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H224AlG7BlGVxNOh07DfI5n7Mck927zyOWESfq1HipoGFbW5nGa
 D0KDqnjKu4yk7laq5+opAWJByDdm59pSpxMpmLdsSDp4xehP96ClnwP8ezmjM9rrnwkw++v
 wtGFpErlxLcF1lMD32q1/o0Ui3vOOl2IccH0zQQK4b2A/bhxYRGN/k2qwPvV0War4R9D8Kr
 OWuAAVikF9alCWOn71snA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R49KXFO2es0=:BXsLi30es8P3tqShbMQvV9
 JHVRii0slXcmp+c2413y3cyJWoo4UrMImMLSu3FDogcgk06AA2+P5HkD2vA7byVC5orr3unrb
 ZApk6gNatKVR2QWlc9Fei5E9cpnQpryHe2n25jOQXLx/74YpubrK6xw3yfL0wecY9BohfY+yp
 2TRnTUfOR/y7XCS+2CtaMUS1E8pFiVuemX1L0m8orIwz6dOeCfEn9lFcxKKR8na74wWZDnvK6
 IFveolOcruiirSt3UkWEBwFWm8nT9NKzj6b/f8xU95loPccFi+du4EXd9KvCRMPfuq7oiunqK
 XiJaDRkphCZfYTqPe6iCbrm+xgYPuQub1FJzaavtcp+ERQ8MzcpNYdN/Vuz2Ry2iiEV4gb0Qq
 cJCWFFLJorPMW60NlwtdtOiKdia9a7MJ7T5zcfRBQoQsY4vfKPHakeYn/8vkwZxSRqLVVFuo0
 UyK+Ojqd/r2hzOuo+L+orWN9zS6iukIXxXWunaR0ttvVXV9sI6KDaj3mOIKY/K4SLhJOHCVap
 cs8Ty7piZMoeyDEq3lCbOsWxMwB97SxxKgSkrx8sv+w3V7pHnJC+bVgi3qvA2GfTsAOp+xj1t
 helPYG0ZpEaXIemiqzqjVauIQjiaZ6BfRHlW+dU2LB9aVp7oHLfn69rGXMzGSuYAH0iGEa069
 MYKbpGOIBjVr5Haj/PFjAcEOOzLLnBhRzYpWRpDKpYfBZPblIPOkxQt0odVO6Ec2F5k9wOuZG
 Fi2zxtWlTk8gW0nEyofmBppfebhOWQXVeEyuBTY8p049rr/dsjAhBDBeUgwYnaSL15oJkB+Di
 kn8WX+2pPYThHxO6d4uBNwotKwFXMjii2vn4g5MfGanh4VOT4uy7CeEf+RJJzR0bt3uYnap0X
 vqy9JJkslWdfNWOxfZEjOsxgYWuM8HURTTAV7PzRFPUaqS37meOJQX5PutYg4i2ylIpLydIbM
 uarPLWO8YwjLVgr/AiVvw6Xlkpe/1UiH6iQ7U+Q5AdXgwAkv2Y9r/Yj+8+wJfTlffJB2wWva+
 A7TVpdnmqqu6+AeqX8DcbRmZ4nJSAkJorkV5UMB+3BYoxKgLquUJmnJagPf6PQI2qFscdvTQz
 bh5wYOawCH/lyOMJkaYYorHHWbcWXTuwFjEf2NCMSsc3BxCfjmRDR+bqg==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/7/14 15:08, Johannes Thumshirn wrote:
> On 14.07.22 03:08, Qu Wenruo wrote:> [CASE 2 CURRENT WRITE ORDER, PADDIN=
G> No difference than case 1, just when we have finished sector 7, all > z=
ones are exhausted.>> Total written bytes: 64K> Expected written bytes: 12=
8K (nr_data * 64K)> Efficiency:	1 / nr_data.>
> I'm sorry but I have to disagree.
> If we're writing less than 64k, everything beyond these 64k will get fil=
led up with 0
>
>         0                               64K
> Disk 1 | D1| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
> Disk 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
> Disk 3 | P | P | P | P | P | P | P | P | (Parity stripe)
>
> So the next write (the CoW) will then be:
>
>        64k                              128K
> Disk 1 | D1| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
> Disk 2 | D2| 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
> Disk 3 | P'| P'| P'| P'| P'| P'| P'| P'| (Parity stripe)

Nope, currently full stripe write should still go into disk1, not disk 2.
Sorry I did use a bad example from the very beginning.

In that case, what we should have is:

        0                               64K
Disk 1 | D1| D2| 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
Disk 2 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | 0 | (Data stripe)
Disk 3 | P | P | 0 | 0 | 0 | 0 | 0 | 0 | (Parity stripe)

In that case, Parity should still needs two blocks.

And when Disk 1 get filled up, we have no way to write into Disk 2.

>
> For zoned we can play this game zone_size/stripe_size times, which on a =
typical
> SMR HDD would be:
>
> 126M/64k =3D 4096 times until you fill up a zone.

No difference.

You have extra zone to use, but the result is, the space efficiency will
not be better than RAID1 for the worst case.

>
> I.e. if you do stupid things you get stupid results. C'est la vie.
>

You still didn't answer the space efficient problem.

RAID56 really rely on overwrite on its P/Q stripes.
The total write amount is really twice the data writes, that's something
you can not avoid.

Thanks,
Qu
