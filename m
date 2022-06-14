Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1382354BD72
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Jun 2022 00:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356646AbiFNWMq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Jun 2022 18:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358419AbiFNWMl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Jun 2022 18:12:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D2E32053
        for <linux-btrfs@vger.kernel.org>; Tue, 14 Jun 2022 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655244753;
        bh=kLQ0JTUfmBG0vicAIV8mIrt0TntCCOQp7Zss/4lWMvw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=J1J3pMhlkNkw2fdsR2SrnObEJlrLUAGtssmzmvkyWjoQl4cJVR3G96JBP6ENZubkw
         ZouoZ0+5d2N2oJyqKeZQSPTiRZDt2gQyiJPtSyiZocg6/vnVRhL1yxd9iDujD5TERB
         s7Fm0Oa6RUAV6AI4MtQTY2+JWXgkfdK9hGR1m4Q0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MsHnm-1niCUM2R5u-00tmJR; Wed, 15
 Jun 2022 00:12:33 +0200
Message-ID: <4ee22ab7-6597-b254-d85d-fc8268fbfcd2@gmx.com>
Date:   Wed, 15 Jun 2022 06:12:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/2] btrfs: warn about dev extents that are inside the
 reserved range
Content-Language: en-US
To:     Boris Burkov <boris@bur.io>
Cc:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1655103954.git.wqu@suse.com>
 <c4b02ac7bf6e4171d8cfb13dcd11b3bad8d2e4df.1655103954.git.wqu@suse.com>
 <YqeKZuET4MDe0D5w@zen> <7d764668-cb95-f410-4846-9a1a98e3b861@gmx.com>
 <Yqiprewvw0q6OYza@zen>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <Yqiprewvw0q6OYza@zen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TgH3hFIGZPTb2H98ZUEl+75dF68YC8xG98BTNJL4wbOpeWmnnnU
 VfHWRPhBEk6gYrUK35DJ3qDvFg7m6Ozc76xLPnR1Y5htMpGKNxvPVw+g5m6+usKfqyvxMD7
 Dd6YCVcFr8WrPDxmBSwSlpgnCBhqtm6nfy1db1QY1wxVc8GJP2ryow64lqFzegSokIjcy97
 DdbBf0J4SY/JV5p9mlgzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5CQA4abHrn0=:TAkLAfWqQYeOSr4FhLAC0j
 gp0mD1lac/Qd3Mm2Y2vtYYuOqdngHCzdiq3b1TkwOIR1PDSB5vfyK7JlZ7mw8NNI2FgqFIcIo
 LcGw6qOEYwHkkz1B3XT79DtN+h4mjWY4YQKvKuTb+f6U/QUdwmnwha5hNnEkBWrb7CyXHTHJR
 FW6k8w97+l9NXJZ+dqKXeGioemrrTXRic6WBUnev/QObtZ27wnAf5S8woAx8Gu9JZtcf9eLF7
 wnZddCfiqZ0lhywXbCvdv2O6GOU5UnS9o+TwkILRC+c1z550csEXIeuA7Ea79SoLc9/ItaYXI
 muoxbWpsxHxzFh8FFGNtYYnyBRHaR1SEWXWcOEK/mydwQ2iCrl7qt88OWPk36jAWYRtSgJ59J
 ZjPt3cDgCfZsre5exROLNjNpS8c0EocRzWRcMgiiWTxLA9rk1CAbNnCdEhvRJIfOyBbcggZ+N
 Womj6ePIu0fXh2AcbknRjIxoT1UP0YvVNjSQ9qVzBHw1LTQRCC6SKvw9Aq857hJZma5taZHxW
 WpxlIcTG3jxjuD9NXjvADAIb/ORQ1nOs6IBM0M2iduZcGdcwgxG0VxMYKGUCC7iK0KlkG9zrB
 VShMlAMnUEDDLVS1J/arX4O4+3SsW+gj9deQfIh1Iwgw+YEifOxPbvVmv3VKVvMwuqNdXJ7MB
 yC/x1DafXNC+Dc/FBvHMzaXTOhuDl4qZL/V01UaAQhPcwBDWUi4Km0LvR3pYWDYEVVvS4mAqo
 BiuIU8wTwCcYq8lg9/nt9z8+jEzI+UsGQmcWthc1IMpabte1wsLAcUfnTd66GOflOb5gmkCWN
 XKEHWDPdbdlNgZGvsQerM/hIM4IJasWbW8VWXmxzbexRGmpzx/JRzFHvYkrkItqakPvidNnAM
 aJIdxZXI6kYCy3ygdFu198xCTZSnEFuimu5MmgJVsvRDNDw4anecpsz1ydREMl79DcnAfJJ8Y
 5gcF6FlK9DNdaDbXg/Qrok1DZZZ2JAUM+vfQQWSypAToZuO3EjJPsq1/u4JfIIGUVz1sk8Hzv
 X4nZZJdf1gK9mi3r3hb4vjeSjyyFo8U2iEsY23oGfEg9rLfChvsAHwdd0gwuYu1qgQdnvICZ1
 0nytS/OOY0tf9Y43y7igsJm+bJV4O/MzV5VSphRbviubqjtHIfqFV/4Wg==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/14 23:30, Boris Burkov wrote:
> On Tue, Jun 14, 2022 at 03:48:06PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/6/14 03:05, Boris Burkov wrote:
>>> On Mon, Jun 13, 2022 at 03:06:35PM +0800, Qu Wenruo wrote:
>>>> Btrfs has reserved the first 1MiB for the primary super block (at 64K=
iB
>>>> offset) and legacy programs like older bootloaders.
>>>>
>>>> This behavior is only introduced since v4.1 btrfs-progs release,
>>>> although kernel can ensure we never touch the reserved range of super
>>>> blocks, it's better to inform the end users, and a balance will resol=
ve
>>>> the problem.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>    fs/btrfs/volumes.c | 10 ++++++++++
>>>>    1 file changed, 10 insertions(+)
>>>>
>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>> index 051d124679d1..b39f4030d2ba 100644
>>>> --- a/fs/btrfs/volumes.c
>>>> +++ b/fs/btrfs/volumes.c
>>>> @@ -7989,6 +7989,16 @@ static int verify_one_dev_extent(struct btrfs_=
fs_info *fs_info,
>>>>    		goto out;
>>>>    	}
>>>>
>>>> +	/*
>>>> +	 * Very old mkfs.btrfs (before v4.1) will not respect the reserved
>>>> +	 * space. Although kernel can handle it without problem, better to
>>>> +	 * warn the users.
>>>> +	 */
>>>> +	if (physical_offset < BTRFS_DEFAULT_RESERVED)
>>>> +		btrfs_warn(fs_info,
>>>> +"devid %llu physical %llu len %llu is inside the reserved space, bal=
ance is needed to solve this problem.",
>>>
>>> If I saw this warning, I wouldn't know what balance to run, and it's
>>> not obvious what to search for online either (if it's even documented)=
.
>>> I think a more explicit instruction like "btrfs balance start XXXX"
>>> would be helpful.
>>
>> Firstly, the balance command needs extra filters, thus the command can
>> be pretty long, like:
>>
>> # btrfs balance start -mdrange=3D0..1048576 -ddrange=3D0..1048576
>> -srange0..1048576 <mnt>
>>
>> I'm not sure if this is a good idea to put all these into the already
>> long message.
>>
>>>
>>> If it's something we're ok with in general, then maybe a URL for a wik=
i
>>> page that explains the issue and the workaround would be the most
>>> useful.
>>
>> URL can be helpful but not always. Imagine a poor sysadmin in a noisy
>> server room, seeing a URL in dmesg, and has to type the full URL into
>> their phone, if the server has very limited network access.
>
> I don't see how the poor sysadmin would be any better off with "you need
> to do a balance" vs "you need to do a balance: <URL>" or "you need to do
> a balance using mdrange and ddrange to move the affected extents" etc..
>
> My high level point is that you clearly have something in mind that the
> person needs to do in the unlikely event they hit this, but I have no
> idea how they are supposed to figure it out. Send a mail to our mailing
> list and hope you notice it?

I guess you miss the point here.

First, this is really rare case, it need older mkfs.btrfs and never
balanced the fs.

Second, the warning message itself is fine, kernel is 100% fine handling
it. The warning message can be ignored as long as there is no usage of
legacy bootloader.

>
>>
>> In fact, this error message for now will be super rare already.
>>
>> The main usage of this message is for the incoming feature, which will
>> allow btrfs to reserve extra space for its internal usage.
>>
>> In that case, we will allow btrfstune to set the reservation (even it's
>> already used by some dev extent), and btrfstune would give a commandlin=
e
>> how to do the balance.

In fact, that would be where the detailed balance command line to be shown=
.

Btrfs check and btrfstune would output the detailed command line to do tha=
t.

Thanks,
Qu
>>
>> I guess I'd put all these preparation patches into the incoming on-disk
>> format change patchset to make it clear.
>>
>> Thanks,
>> Qu
>>
>>>
>>>> +			   devid, physical_offset, physical_len);
>>>> +
>>>>    	for (i =3D 0; i < map->num_stripes; i++) {
>>>>    		if (map->stripes[i].dev->devid =3D=3D devid &&
>>>>    		    map->stripes[i].physical =3D=3D physical_offset) {
>>>> --
>>>> 2.36.1
>>>>
