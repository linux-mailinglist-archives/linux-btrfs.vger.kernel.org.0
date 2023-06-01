Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE97195F3
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Jun 2023 10:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjFAIrd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 1 Jun 2023 04:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjFAIrK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 1 Jun 2023 04:47:10 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED901AC
        for <linux-btrfs@vger.kernel.org>; Thu,  1 Jun 2023 01:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com; s=s31663417;
        t=1685609222; i=quwenruo.btrfs@gmx.com;
        bh=fbOPMeFm1TPM7qem9Ybb8CCBQuYJoqWmj+Fz0xy12yM=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=rmHA3Mpt7yda+hoiWTxHL3tOku+S4jqmScV8KXFj5d0vQfw26qcMjaL1CAFVVVci0
         Wfc3F2bk3xt6OhAXmi8EOgMJb5toZX7w1fQWqfmwzLWARx/aqPwGBL4opSeibKHkf0
         c/SS4Gf+lAS0mGQXnwIDiR0JMc5QIFwX7Fyzmy4KYIokkWi64WFydiC92GPDap+e+V
         ehTDQRXvbNFP9qelr+VJNjUD+O1gBldzWMhXbNSfMdTF99qOIdnXyxveyK1ZzdMsxO
         lbqe/ZK6KcQSN7wncZA7Ze7Ta7F8yS7NzoPp1cqzk3kvO4/sh9mXqQamCCnx3xTtzA
         obr6GkRRV+tDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MJmKX-1pl2dw0TO5-00K4og; Thu, 01
 Jun 2023 10:47:01 +0200
Message-ID: <d5d69915-538e-e38a-4470-c9739efdffb5@gmx.com>
Date:   Thu, 1 Jun 2023 16:46:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <821003e3-b457-90ba-e733-8c2fdd0c3b3c@wdc.com>
 <20230531133038.GA30855@lst.de>
 <a59b2274-9d64-f11e-f726-9283f560a495@wdc.com> <20230531141739.GA2160@lst.de>
 <134e56ed-1139-a71c-54d7-b4cbc27834a9@gmx.com>
 <20230601044034.GA21827@lst.de>
 <dcc61893-c48d-e8d9-3161-7f7b965b8e8b@gmx.com>
 <gn6vj3mlwsm53iu4ktso2dts4ifyxaky54ivb22laq3mqy27lv@guvvxohmkxy6>
 <mmttvfirtcp32ruvodutdw2vnvxqdnad2gywwb6jxl7gtkzqta@xw75lfxofsso>
 <37a62c6c-ca9a-a6d2-37ba-249605427d08@gmx.com>
 <20230601072757.GA28794@lst.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: new scrub code vs zoned file systems
In-Reply-To: <20230601072757.GA28794@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kIaBdRzsQlgnOXW4qfuUbOYCtIz9HgnpzS98ind3yG0cwwV9Vk0
 dg1ovljPomh2g3FkMXSgi+CVZZOjoH/ITzI4z8bFNLk0//kbMzOMl+91YwK8YhR+LB6YIRT
 iQYobuT8pqY+3yDApVqK9krzSdNZ5VMw+CUo0qVI9K+l0GFd7gzgFLe/HF+QpdNgO61PfsX
 dvTNl//HcgMmQ7ka1vjyQ==
UI-OutboundReport: notjunk:1;M01:P0:3kfyvf+6x4A=;P30B+EwrSZr26I1J4DxZmiUQJIJ
 brilR/JtwdGcVl0QvDe5tt1q1FQMbkP6vX+tqumwLgreqZHhN3nEK6s28Z/StOSyv/A1Qjxz6
 92oqZLfscu0csBTrFzwaHcFgLu5rLN3H7n9q8N7+QSHrf9RlNPFprzwTvdJxA8Np8OaTQb+TA
 LmeDMB6FkBZxPBbCeKs/nNTqbq5DdDlaiuHcI9m8LmHwMnRO7Ce+W7SCUjVtLsu9sdtPjhMJD
 Hc4lqKDLfPcXax7e+P5FtTOSKUdR8L2+bq8M4x45z3lokutkR+hWKVA5ySigKvV80jdS62MG5
 RVY/wx3Ab1QaubTz3uoE+3bOY8t2teJd2RZaaKSau+hcaBwlo5LBrnjpZoJz81BWuST3MZQEm
 amWB1pDomKlCJUmQMwpuQQbrKs8zP2JA/3ntSBMeEC/WBX1yH0j5B+6DTtxHAmUq9FTtHTRef
 9k9O8CGW5dqPzotU82RGwPkRvI77fHxWKnbMTiGLQ/rcZWmSydK4Mr8PNskICHgTejIukB3EK
 sT477V+MDL4EQoqnIheGl0F5QEK5bG26JATYJDBadreLKA/QgM6+Ak8XBpLujW8+SYwJbPVK0
 SRJH2Y3S2ROhnzTX7SIV0ieo21Typ5p5UnuFrT8+9LgdNfokKn2VcCHWwqBP5dfnm/lMe40aE
 ksOqK7eDU+U1UyttWwua53obF5XULgbSUP2ib/54c/dSkpu9C9dH/BZ2TvvBlEYTobiuwD9il
 ojBiVKWc05P/aICTYsiw7KG4lx+gDpKJcNucDWAI4mUumylV27hL4A45ynvHnrqEYAHLMIuOf
 Rw9cyFLgDW3NFzxvZJEX+tWAizozWbxal6WMDfGrhLdbZGMmxozRoSTextM8BsgvJXIy2ZTAd
 Lh0BOqpOfexXreViHhUCeagjaLi7PCv4WR1v2zfkA+SGV6cqnAMM1ioOrqTb91TB0Z0WA5pfP
 V1kaB7dsz8EsCOIFRXswgXfB4S8=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/6/1 15:27, Christoph Hellwig wrote:
> On Thu, Jun 01, 2023 at 03:21:22PM +0800, Qu Wenruo wrote:
>> Is there any function that I can go to grab the current writer pointer?
>
> You can get the information using blkdev_report_zones, or the
> "blkzoned report" command from user space.
>
Several new bugs exposed.

- We need to forward the sctx->write_pointer after the write bio
   finished

- Wrong physical bytenr passed to fill_writer_pointer_gap()
   The 2nd one called in scrub_write_sectors() is passing logical
   address, which is definitely a big NONO.

- Missing gaps for certain bitmap layout
   If we have the following layout for write,

   0     4     8     12    16
   |     |/////|     |/////|

   We should:
   * Fill gap for [0, 4)
   * Submit write for [4, 8)
   * Fill gap for [8, 12)
   * Submit write for [12, 16)

   But we have a wrong check, we only file the gap request before
   submitting the write bio.

   This results:
   * Fill gap for [0, 12)
   * Submit write for [4, 8)
     Obvious the write would fail.
   * Fill gap for [8, 12)
     No op, because the write pointer is already at 12.
   * Submit write for [12, 16)
     Weirdly, this would not fail, as the write pointer is at 12.

In short, the fill_writer_pointer_gap() arguments are a total mess...

I will submit a proper fix soon.

Thanks,
Qu
