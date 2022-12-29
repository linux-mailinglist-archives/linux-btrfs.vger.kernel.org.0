Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5DC6587F8
	for <lists+linux-btrfs@lfdr.de>; Thu, 29 Dec 2022 01:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiL2AAY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 28 Dec 2022 19:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiL2AAX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 28 Dec 2022 19:00:23 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809DC13F66;
        Wed, 28 Dec 2022 16:00:19 -0800 (PST)
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgNh1-1odFjc0WTP-00hz5T; Thu, 29
 Dec 2022 01:00:16 +0100
Message-ID: <52793f07-a842-dac0-b7c2-bca641e18a94@gmx.com>
Date:   Thu, 29 Dec 2022 08:00:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     Qu Wenruo <wqu@suse.com>, dsterba@suse.com,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CABXGCsNzVxo4iq-tJSGm_kO1UggHXgq6CdcHDL=z5FL4njYXSQ@mail.gmail.com>
 <CABXGCsMMYmCT_Hz=wfKWDy4OQJ2KyBO3rNAFC1YCAthziWm+Lg@mail.gmail.com>
 <41734bdb-2df0-6596-01b6-76a7dfd05d64@gmx.com>
 <CABXGCsM6GOzr+wL9BEk7mD5xLNgsKE5KUBADD8r783V6-FwXdg@mail.gmail.com>
 <e9f4d768-d91b-b5cc-dbe6-041a81833cf3@gmx.com>
 <CABXGCsPK6ZZ4=5qathvjqSJNde6MYhA0uvh6zAMznT9Yj3xk2g@mail.gmail.com>
 <24cd64b2-4536-372c-91af-b425d2f6efd4@gmx.com>
 <CABXGCsOG1GR1QqQSULHRcqJyfo5zY1bkZA+Mkb2m3C=rV_2z2w@mail.gmail.com>
 <ff262ad5-2ae3-329a-ba88-19721850131d@gmx.com>
 <CABXGCsOgy0N_TLEadgacMBQLuU5xBe-hmoRvv4h=q-M5PcPvEg@mail.gmail.com>
 <7d2edc1d-922b-763c-3122-0a6f81c3454e@suse.com>
 <CABXGCsOq56Qjq+-Bnfbe7ZvhfjSs204cbc8VFG7b+J2Ncss0ng@mail.gmail.com>
 <fd0a0bfe-5c67-fd95-b17c-78a14c63bea6@gmx.com>
 <CABXGCsMev+96zixic3=5cLgzMfZKcJE-zOLPrc3-vTrrDZQDig@mail.gmail.com>
 <dc63f5ac-44f4-f5eb-f1b0-c14291595e3d@gmx.com>
 <CABXGCsMhtEFDWYhFU25X3NSw3R3z8byV23F_E0EgSEfcvHrZFw@mail.gmail.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [6.2][regression] after commit
 947a629988f191807d2d22ba63ae18259bb645c5 btrfs volume periodical forced
 switch to readonly after a lot of disk writes
In-Reply-To: <CABXGCsMhtEFDWYhFU25X3NSw3R3z8byV23F_E0EgSEfcvHrZFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:2SUEsCNvuq/EcN3gZ72JCc9vQLF2LpaosyJ8iDEUdcn8LbHps5R
 SxNUXd1Wh23brnOSZTwDZmtRTlm9OZkyh5NJ/4hGgYoC5Rbn4KlnDIFqO0hOa/YpCrfE1NU
 XdbyrC8VKvokvbZXw5pKtOFOV2Nt/gGRUhEOS0dyTrUA5PgBLuTqs8aitpltiLa1PhWT38u
 PDaHmApmnhWM3VSx9jxsg==
UI-OutboundReport: notjunk:1;M01:P0:tVGWBWFHVek=;16r7pdq3iojDXlexuZfAUAhrq2V
 x1Q0zvnhmNaXv4ukPVSwZ9tiZSioTVdJDSXibWLnzHbLc5omXtQ62asyDCeLHCRJD7hrEeqep
 Hxr7E6M4Yr2FkQvfYGrmo7BSziGax3enaQ7Y3Pf/OVDoaPPgPISzHS/JJbT3V3TZSWKlriVwy
 N+9oD8ZkZn0AQCyWa9KkyFUBFeP3coJJveG9tIlGDyj3riSvfthX9R3LAldK/e7YG4p1vybm6
 Otg12crnfOpNj1banWacXXTIeB4fOARTvxJgsHeo/GUIAuTbFMQ5P4MJD0+bg5mjlAA8vEHsb
 ett9peGer2KymSGGjAnFfzCaqiY+FVgjoTl5uF75ImYjXyHCnafr/cBU72C1ddzf2gvy8bA6I
 Ozh4KJPzhoURxqPE5Rsu+QaI0JSY8aEDY3cFKmn1KRxFfUpfogTgNwtoGzRCvX/pi63EtTg0B
 S7sNCJJaG4Ijl4GElyrLTEuSwkKI4aDSofoydqFK85Ss+joQ84YZrwBHTM1OWU07MAIk9IHvw
 iUeLA+/5rl69aP0PkyEpVmMP+nuYnCvyaDsKaaZrMSPIGo1NIYwghxW8zVrAbz1xRtGcaLXzS
 xfkpI2AueT8bGCiMwIRGUavLaVcsRSaLuarqShWvXSseSAUGvKV3iQVu1nvwbw0VSPD/ZrBgx
 O47Z4AuUE1mtg5nkzMg3eeqClCSHN28IRP8BjCwGdVdDlWOMi+jZKOP5bPmSkw5IbPu4PVG6G
 LRlknGqkptnhZddwEaZiXxqCmeUljWfMtfJGDSrO9YtEUG3OxhIAFP3+SdIeUB8UWHIhmwUiC
 m4uKawPudJQKdHX4cY7cGqhOmBJRJCQToaBtpp0B5ZpSvAhHS9kSZF8tXkVXijI3m/VUejl6w
 K5mBq1Qy6qMWcTT2TOdsxceKpSwtUOcTOJtf+agiw65WEr+uNjIn50Llfrwb1XQsZKzp4TX8+
 +QArXJNxOqpfHydsafp3Y+3cTUg=
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/12/29 07:42, Mikhail Gavrilov wrote:
> On Thu, Dec 29, 2022 at 4:24 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>> Just one last thing to confirm, mind to provide the following dump?
>>
>>    # btrfs ins dump-tree -t chunk <device>
>>
>> If the fix works, it means you have some tree block crossing stripe
>> boundary, which is not the ideal situation.
> 
> I attached this dump.
> The only thing that I did from a working system I hope it is not
> affected to result?
> 
For small dumps like chunk tree, it's completely fine to dump from live 
systems.

And your dumps (along with your previous debug output) shows no metadata 
crossing stripe boundaries.

I'd need dig deeper why btrfs is splitting extent buffers unnecessarily.

Thanks,
Qu
