Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC65974958A
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jul 2023 08:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjGFGYY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jul 2023 02:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjGFGYX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jul 2023 02:24:23 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6739F1BFD
        for <linux-btrfs@vger.kernel.org>; Wed,  5 Jul 2023 23:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
 s=s31663417; t=1688624589; x=1689229389; i=quwenruo.btrfs@gmx.com;
 bh=S8L0elF0NWhPAk07TNVl3+ExOl3RCyLfFHcuiaIvd1s=;
 h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
 b=syAf43PUbDDQ01BhyRFZcEP5a11w/UnFSqhWRNw16iz0WYM2B9vGNqND7eQKnN40a4GccEq
 JviA0YJY5Xz2rTtHvIX44uAQ3AnZ35kwVG8BQlp6sOKhUx39RVdJ89636LCsteHIJJ0kIulAC
 yH69saJqy9Wnqyh6IGA/kcEYB+gfjOOJI8fh5DcEls83JYUD0Th4nKnLG8KHo7tPhYWDlO+5Z
 3uQqSmInjQHAFVIS+Wdh7EOh6FwuQmIy6VxpPqyNudz8LnvZfrKm5Jo2ayqIrXKLx60Msl0UM
 rpKIUx6eOdVp+iNw99PfpWWO+MnSwNNlY58hAwX1nlH9Qrp4xxfA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MgNct-1pnQl134Ax-00hu7X; Thu, 06
 Jul 2023 08:23:09 +0200
Message-ID: <00c1ea17-680f-18a0-d40a-f36bcdb9101d@gmx.com>
Date:   Thu, 6 Jul 2023 14:23:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: question to btrfs scrub
Content-Language: en-US
To:     Remi Gauvin <remi@georgianit.com>,
        Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>,
        Qu Wenruo <wqu@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
 <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <3d208b62-efc2-afe4-e928-986dc4c53936@gmx.com>
 <PR3PR04MB7340ACCB059FA7C9A22052DBD62EA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <e4237dc0-2bdc-a8b3-9db5-6b0e24b7b513@suse.com>
 <PR3PR04MB7340B6C8F2191ED355D1232BD62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <80136f6f-0575-58e8-ea8d-7053c8af4db0@suse.com>
 <PR3PR04MB734063CF2AEA3709D3AFD9A5D62FA@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <743f92ee-19e8-ba45-0426-795a91fc0e0b@georgianit.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <743f92ee-19e8-ba45-0426-795a91fc0e0b@georgianit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:IicpPrib2pBFJYdfyytZ1WYUeFHdfBn2pNhFJEHk43GzZ74qn39
 t8hoZr0FaZfWy4vofZX8oiDB4rnTn6QNR/p1dMTmj0RxxKCxj2YFJoDDh4gp0/+jyNrelsj
 69QJJt3BAqhEPp53MOUaQZtQhuQ4J9UaklTDxfpwqNPpCCPbeFonPXwoSGQt8EyTOOr+Ia2
 FgK6ZOxjPSD5jTTZw6THQ==
UI-OutboundReport: notjunk:1;M01:P0:XtJXaLIyg+o=;Iclu1pWM6Aklzf8mIiHv2tkz2cg
 8WVGgdEAqkJ1EKdjVPHwuSpSleVDbLV5jDu0/XFfp2znSQhgZB2aKoBXvyhEZrNNQc8MTomQt
 ynmKYouRQnO5Z35IgjUCeaRoKhaq3hhiJsaum3p9dcHzvnoZNqTjQAav07229lFZLXsf2df7f
 ZqXj24oierC9QOXDtKsotakcsPJcyv3qSS4A8BztWqtaDdHVoloJrLFvmb4Yaqb8389dGg/Xq
 1AwgS/nerAkA+mcaHthC3n0XGiWW5y+jgu5ozQqQYr2OlEqVNh/ldAAk7Qk7p6SYO9d4qBZEX
 kqk/Ti842lzMWszhB9vQOTjVYQt6YB0YJMvtw47OYM0jTx1VXfAMG9xhu/OEbtmJeyevtO6lH
 74C04sXtTMtugioN12pgoGCL4s1zKg2I724rR3OypUulL1m/28jrZmP+069ZCeiF5yHw9viki
 APcsP0f0ducUGMVLWZDEbvSgeSWIRXtl6hK0X3NClXmHhHTV9ZrzBj/BsIMEaKDtspYb0hV+V
 BUHM8f3Xo8/wZvcsMgr5kGdcPSxYu8Dg8u9w2w68pid20WAo2aLiOP1w4ed+Z8gckaH+NObmr
 TavQzZTH+YQOmkiJ7NKSTanIEVdScOpvfjLpVR6PZeCTrjei0laZuz8dWu5UmQVmxaOheSQDN
 hCY5DUYKWMh9HYJhk39c5Xj0OdqfOF8OER3IXlm4Dl227Qe1e4Mbipic0jgC71jBkiXApDsQ/
 xyjaoTdrJ7N8pQ8Sl1PqzHLAzf10pClL1wDNijb0IKOvWlJpVGXAQ/aU4Bsg0fIycGQOQpJFN
 ZP8ziPwTZsel4DDcjZkcKCgUS6dvNfgL4wFTqilTnYAsf4OuEb+AI4C0X4F6FLGl3kN91qfxY
 4s6IQEhvtOqqStJzcDbytt0lrj9k/+dnUHp7uJFXIhlME01/HKNDsjQnFbjhO4ZgxGIzUG2by
 LnkFiPDe7U+xh2WiXmOH0BFr3Io=
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/7/6 01:53, Remi Gauvin wrote:
> On 2023-07-05 11:01 a.m., Bernd Lentes wrote:
>
>>> The main thing here is, nodatacow implies nodatacsum, thus it would no=
t
>>> generate any csum nor verify it.
>>
>> But aren't checksums important in case of errors ?
>> OK. I know which VM images produced checksum errors. I delete them and =
restore them from the backup.
>> Then I set the attribute for the directory.
>>
>> OK ?
>>
>
> I'm really not sure how we jumped to this being a bug that you should
> work around by disabling Csum.  I know Qu mentioned the possibility (and
> I by no means want to question his expertise.)... But unless I missed
> something in this thread, there has been no real indication to not
> simply take the error at face value,, the drive/controller/usb combo
> resulted in corrupt data, BTRFS detected and reported...
>
> I would hope that the error detection working exactly as it is intended
> would be the most likely explanation.

I hate to point my finger to btrfs itself, but I still remember in the
old days some workload can lead to such false alerts.
But I can not recall which commit is causing and which one is fixing the
problem.

Another concern is, the report is using SINGLE for data, which is
completely fine, but it doesn't help us to determine if it's really a
hardware data corruption or btrfs bugs.

If the report is using RAID1, and those corruption are all repairable,
then we're pretty sure it's data corruption on disk.
Or if all mirrors are corrupted in a RAID1* config, then we know it's
definitely btrfs causing the problem.

But with SINGLE profile, it's really hard to say.

Thanks,
Qu

>
> As for what you can do if that's the case, delete the corrupted file and
> see if it happens again, (in which case, buy more reliable hardware.),
> or just skip the wait and go right to (hopefully) better hardware.
>
>
