Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC6B55A769
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Jun 2022 08:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiFYFx5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Jun 2022 01:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiFYFx5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Jun 2022 01:53:57 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90393CFE8
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Jun 2022 22:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656136432;
        bh=gaDYoDRSxZdttDG3+oE4L13hxEAX2BvbARukmOPXlPg=;
        h=X-UI-Sender-Class:Date:To:References:From:Subject:In-Reply-To;
        b=eX8Se/+jGb0epGaSWxi/LgQSeM1sX0u8GWmRybrwHbL1qsURhCkzLVgngwlhxXbIM
         C3EXFjQE19XTFxq+0XNpdoMxnC9KlzOHskBU/2sjwKkGwEYOcSoSnEoGir8WG3aaTR
         jeIrHaerf46IeS8uM5ujmbleeK6CPKUkBNMy1/oY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1Mi2Jt-1nRXKA1bnd-00e1QN; Sat, 25
 Jun 2022 07:53:52 +0200
Message-ID: <7ac6d505-6806-338d-d1f2-100737749e89@gmx.com>
Date:   Sat, 25 Jun 2022 13:53:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        linux-btrfs@vger.kernel.org
References: <20220624080123.1521917-1-nborisov@suse.com>
 <20220624080123.1521917-2-nborisov@suse.com>
 <21f7eb10-09d7-826c-48c3-ded892984d50@gmx.com>
 <3e01475c-8296-4cf1-14cd-5774d780b6e2@suse.com>
 <27f72ec4-a365-20ba-03f1-8d603a66e011@gmx.com>
 <20220624134706.GV20633@twin.jikos.cz>
 <75cb4383-72e3-58d6-ca23-fbfa9be65617@suse.com>
 <20220624154436.GW20633@twin.jikos.cz>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [PATCH 1/2] btrfs: remove MIXED_BACKREF sysfs file
In-Reply-To: <20220624154436.GW20633@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Lns0S6/p9RiAnUO0HzVMZMJ6fz78lU6NQqZlu12SgimDulDL37l
 k6sogzGxUWfXyLeJOjkz4SEj7OEqf84dDLI6BGoulcC02/+w7Vmr2FIWsER0G7u3KtJ3+1+
 3DB48VJooqeFN0BT2KK7rLpzuyyrKWT7FWCZkq+VBGRlBJ+EyjNzF75BMV11MmEPmfCQFax
 5/mI7icMoRbQFyQnaAKBg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bDH79qXo580=:yAXAnOEmPzC5gFvQA/750a
 k/dzli3JFov1ZlbSer1PKrn7elCqifDMHMJbaCbdyShSPcyFVRgBrDEM0A5SakIGT8iRemFES
 90lBA86z950Bvl0CXM7Q/oRuHJLRWrSj8cQCgHNplNxbd/UAgPX9xCS7EpMNfnwBuO3RAerr+
 fMhcuYDLm9SeBY6HyH0EWYPLAePgJdPe7Jg6hnm551e1vG5Q/GJ6RFizCAsN9cnLNNdb7GI41
 Pqz6/7S8XJN0zq6JmGyZ/h4PDU/zvSBXAYIDFTP0VLGZ2ArUqIiLU9qOGSvdzQf9OoyU5RyCn
 IkCI0srQcPlaGvwENaACWSJTDMoKzU8ZRMNuPMfrDfeXJLqIxjEHj4qqs+sgM+BB5hQ+AbtHG
 J8rHmLr/4Oq9zxjrWzZ0JjqvwWg4i6MBPU01QjcctXUhlAO1WNyUiAnfxnHlorhZafOHBl6VY
 XQK2UJq9MLk5E5DmvLAyvGpAMFd2VwO9tjx9XbRMgnPWz/kJkOiPLn9O74FpOe1bDJmN/lS0w
 E/GulM5Ty2+JO2d9vowz8moMzOdHBcK2cwhYRPBh7j0axlCRUqiwhbHBTcZnMSUmmVKpF2mJy
 SNkKae+AUcIb7+aQOh2JRaVlcZbMWwzVGC2V4fS2g4oqW/0B3pRUk20SOk7ZYy8qTe5lVw3EL
 /zYqvExwKMFp6NLf06ap04ugqXSkr0X/NTh+2DiZxqv6+zRdNzAolA2sxl32gOwt2Mns5bjDa
 /X5hhvp3LAdGoCFpn8M/c10PXqngXfd5fDa4OYI4c0M9fqVgTy+XtWu+sVX8NYpZ504fQngsb
 J0MGw7dzvjUTeDM/jCdciNu7FxkpYd1cXK0DKagsESy/xb1AyKbCDvRvSrmF4Z8ClQ2hLlrLZ
 5cwvi9Uh8C1yMtwa4mjdIkYVulx0tRrf49Ys7SQVxvgKTRNsv+MjWbPE4Jr9z9bTT6aNsI/yU
 B/ykFhfszr4F0VvFaR52m76c37Z8mIjlU5NbLgeP3wMhablNbOhpj1hRX9fkuWzUhbitXvgmT
 zzr+AMhKUfvUi2RVxdIQYL3ThKeqN4DB80b1a4P1PVflr2pMfwMsOF9cuqD0RCDhrLhKk/lBN
 zV2zRDhj9GkFAlB33CggmR6ysnlYEz9Z6E2PqqmKVeq4t4AtH3BsXfqNQ==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/6/24 23:44, David Sterba wrote:
> On Fri, Jun 24, 2022 at 10:02:43PM +0800, Qu Wenruo wrote:
>>
>>
>> On 2022/6/24 21:47, David Sterba wrote:
>>> On Fri, Jun 24, 2022 at 07:46:12PM +0800, Qu Wenruo wrote:
>>>> On 2022/6/24 19:32, Nikolay Borisov wrote:
>>>>> On 24.06.22 =D0=B3. 11:13 =D1=87., Qu Wenruo wrote:
>>>>>>
>>>>>> I don't think that's the correct way to go.
>>>>>>
>>>>>> In fact, I think sysfs should have everything, no matter how long
>>>>>> supported it is.
>>>>>
>>>>> I disagree, for things which are considered stand alone features - y=
es.
>>>>> Like free space tree 2, but for something like backrefs, heck I thin=
k
>>>>> we've even removed code which predates mixed backrefs so I'm not
>>>>> entirely use the filesystem can function with that feature turned of=
f,
>>>>> actually it's not possible to create a non-mixedbackref file system
>>>>> since this behavior is hard-coded in btrfs-progs. Also the commit fo=
r
>>>>> the backrefs states:
>>>>>
>>>>>
>>>>> This commit introduces a new kind of back reference for btrfs metada=
ta.
>>>>> Once a filesystem has been mounted with this commit, IT WILL NO LONG=
ER
>>>>> BE MOUNTABLE BY OLDER KERNELS.
>>>>
>>>> That means we're hiding incompat features from the user.
>>>>
>>>> Even if it's not tunable and should always be enabled, we still need =
to
>>>> add that.
>>>
>>> I think the mixed_backref is an exception because it's been part of th=
e
>>> default format for so long that we don't even remember there was
>>> something else. For users it does not mean anything today, moreover it
>>> could be confused with mixed block groups.
>>
>> Then after some time, there will be some "smart" users find that we hav=
e
>> one incompat bit without any explanation.
>
> Removed functionality is documented, the sysfs feature files are in
> manual pages and we can add a notice in which version it was removed.

Then have all the old features get removed one by one, until one day we
have a dozen of bits set, but only one or two still show in sysfs features=
?

No, this definitely doesn't look sane to me.

It's just trying to hide some bad behaviors which we didn't get it right
in the first place.
It's fine to didn't get those things done correct in the first place,
but not fine to hide them.

Especially those sysfs is already hidden to most users, way less
invasive than the dmesg output/mkfs features/etc, why we still want to
remove them?

Thanks,
Qu
