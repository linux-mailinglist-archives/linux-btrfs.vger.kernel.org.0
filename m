Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0FF4C6D62
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 14:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiB1NEq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 08:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiB1NEo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 08:04:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BAC40E41
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 05:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646053437;
        bh=xqHFGMFTKfRJJO+2qvD/TWkl5w8HNGE6hPX+qIqeRHw=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=EFMJsJ2cOw3Ig2XHHMjbn1vR8uczSk1/0NoPaEfZVp6YRBawq6VHg8Khc3z/OOP4E
         R5q12MOi9ZJJ1msfIrqK7EneI3Ze6vv6pQ21ReoqYVHpfxuw4pkeDVePqSYi7jVCZL
         lrl9OLBJPMNGTP5auWFVaeBiyaLlKyU1tm8O42jc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MowKi-1nzQnq3hbq-00qPVn; Mon, 28
 Feb 2022 14:03:57 +0100
Message-ID: <07588d0a-293b-643e-f2c5-ebeb74023c4b@gmx.com>
Date:   Mon, 28 Feb 2022 21:03:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] btrfs: repair super block num_devices automatically
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, Qu Wenruo <wqu@suse.com>
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>, linux-btrfs@vger.kernel.org
References: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
 <ebdb0e67-0e9e-4ca6-1d2e-4dd2a7a7c103@oracle.com>
 <a6923955-00f9-d739-c70a-3beace0b85e1@gmx.com>
 <82df81f6-74a1-b77d-c4e9-48d20ab1bd68@oracle.com>
 <f8c0610e-466b-256b-347f-d10c517023ae@gmx.com>
 <c8009e2d-7569-4dec-3745-e9c3718ec57c@oracle.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <c8009e2d-7569-4dec-3745-e9c3718ec57c@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/2BbR0ncuznICLhQUz0iJLW9Kt9+vB4jG5mEAj1Hwnn21yfM1s3
 F5HzEq6rkrMm1vIM4p2dpwWEAfWcbZr7tADvoXDOMWbYaR4v9MSF9z8ndP/M/tZ+sLT2Jgq
 s0LH64FpxrID1kwpGaJvsKzMKbj1tQ9MerhRcMYNv2NuU9NK2ovvW0WFzm0yaOzybF8/B2Y
 NnYjAOEQCE0DnGHl/dJEA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qypSbmy5ZWA=:Cg84HMe1WzZHY1fN880Z4K
 mwrXSZ5tmYZpJUuiepBEvBHjxACNP1ihSmV7b7VfAvnJ/bSNl/108/542F0Q761HEUKfMeBT6
 MhJjRWQzaPiVXim4T6liA/ya2emy38XDujU9UEcOVEMXOrZCOzKNGzUYd10Hsj0EACw+WxNVv
 TyttziIe11rnkVqXDuCoHjSQW4c114AEJHcAn2Uy2L5Q9RCDVZ6MMQ4mqVlPh/eyFm1Hskhd9
 hG84mDLKi+u8VhbyJWtQYqjbtaICcdLENQVWRzv67PPZZWCkWD8gqtblGWwyb9x0/6X4zPcAK
 aJVP79y1pTgQj/td/p6iiNq4iLU6gymgC7suoqHCzk6DhzHRRWQGByFwR8H1Qmucjs5s463Yc
 0cFdONdsTAv0WnBgIcHB3GN9a8XA1ZwNbHrQLCRkxZ3ma7+6Amutbo5gAeRJr1aNFnmlHAGhu
 La88Cz9jZsMaYeDrWnsFmvMhqyBmQVU9XUNf72wyUItqmdDPpns/B0RVMLux1aAjh/7j6pgbN
 XE4osXOo3+FgIuVHyVG4YLHKBVcI8HMmbH5nNwKXernOtcJgIqsrAqkjsO67gVjz61KmnYKwE
 Xy30FrOVm7POhdF7hgu946CZ0BH5OHf5SWyk0bZ62+nAWJ7EnUPD4lEnPacPQWq/ThD1ibKpH
 Q0R96x+UayKCOLpYTWjnFFpth8yHNkbvxNcyS4Lg1C4WeOjmwjtGyb+8riHctFm55VvhixZGV
 R84xM8VuH/oLQq3B5q5F/+yBP8pc8Ds6Exeh0MLCwWw6IvjuTadsr67+yd7j5rEFlxZDWUrW7
 CFhgegLoLraqHuocCzF3CWd/jQ0zLAXNBzsaHr/XYNfUJLJLdNHicME4gZLuAJS52wjKunMK8
 Ifq5QDEd+3lFe4ZWvchkPdjzy0/kVsdS2qMvr6sLgV+Z3WSy85eyBhhhq7eBtDdGeQqj0drGf
 YMUE8CbMzd4I4xqEk0yxa/P+8crlOih7RnhmWSdTlJZm6d5uPLpOQZzbkkHoUUZ7aF5WWeZsF
 3u6ZnbEhVV/yagnBtTjYbx0f5hncjjOsoec7cojdJysspvBNCi9Hrkev4E+J3TG/xDBj4xxUK
 OgSaeKQbN8Mgpw=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/28 20:51, Anand Jain wrote:
> On 28/02/2022 17:21, Qu Wenruo wrote:
>>
>>
>> On 2022/2/28 17:01, Anand Jain wrote:
>>> On 28/02/2022 16:54, Qu Wenruo wrote:
>>>>
>>>>
>>>> On 2022/2/28 16:00, Anand Jain wrote:
>>>>> On 28/02/2022 15:05, Qu Wenruo wrote:
>>>>>> [BUG]
>>>>>> There is a report that a btrfs has a bad super block num devices.
>>>>>>
>>>>>> This makes btrfs to reject the fs completely.
>>>>>>
>>>>>> =C2=A0=C2=A0 BTRFS error (device sdd3): super_num_devices 3 mismatc=
h with
>>>>>> num_devices 2 found here
>>>>>> =C2=A0=C2=A0 BTRFS error (device sdd3): failed to read chunk tree: =
-22
>>>>>> =C2=A0=C2=A0 BTRFS error (device sdd3): open_ctree failed
>>>>>>
>>>>>> [CAUSE]
>>>>>> During btrfs device removal, chunk tree and super block num devs ar=
e
>>>>>> updated in two different transactions:
>>>>>>
>>>>>> =C2=A0=C2=A0 btrfs_rm_device()
>>>>>> =C2=A0=C2=A0 |- btrfs_rm_dev_item(device)
>>>>>> =C2=A0=C2=A0 |=C2=A0 |- trans =3D btrfs_start_transaction()
>>>>>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 Now we got transaction X
>>>>>> =C2=A0=C2=A0 |=C2=A0 |
>>>>>> =C2=A0=C2=A0 |=C2=A0 |- btrfs_del_item()
>>>>>> =C2=A0=C2=A0 |=C2=A0 |=C2=A0 Now device item is removed from chunk =
tree
>>>>>> =C2=A0=C2=A0 |=C2=A0 |
>>>>>> =C2=A0=C2=A0 |=C2=A0 |- btrfs_commit_transaction()
>>>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 Transaction X got committed,=
 super num devs untouched,
>>>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 but device item removed from=
 chunk tree.
>>>>>> =C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0 (AKA, super num devs is alre=
ady incorrect)
>>>>>> =C2=A0=C2=A0 |
>>>>>> =C2=A0=C2=A0 |- cur_devices->num_devices--;
>>>>>> =C2=A0=C2=A0 |- cur_devices->total_devices--;
>>>>>> =C2=A0=C2=A0 |- btrfs_set_super_num_devices()
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 All those operations are not in tran=
saction X, thus it will
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 only be written back to disk in next=
 transaction.
>>>>>>
>>>>>> So after the transaction X in btrfs_rm_dev_item() committed, but
>>>>>> before
>>>>>> transaction X+1 (which can be minutes away), a power loss happen,
>>>>>> then
>>>>>> we got the super num mismatch.
>>>>>>
>>>>>
>>>
>>>
>>>>> The cause part is much better now. So why not also update the super
>>>>> num_devices in the same transaction?
>>>>
>>>> A lot of other things like total_rw_bytes.
>>>>
>>>> Not to mention, even we got a fix, it will be another patch.
>>>>
>>>> Since the handling of such mismatch is needed to handle older kernels
>>>> anyway.
>>>
>>> =C2=A0=C2=A0Ok.
>>>
>>>
>>>>>> [FIX]
>>>>>> Make the super_num_devices check less strict, converting it from a
>>>>>> hard
>>>>>> error to a warning, and reset the value to a correct one for the
>>>>>> current
>>>>>> or next transaction commitment.
>>>>>
>>>>> So that we can leave the part where we identify and report num_devic=
es
>>>>> miss-match as it is.
>>>>
>>>> I didn't get your point.
>>>> What do you want to get from this patch?
>>>>
>>>> Isn't this already the behavior of this patch?
>>>
>>> =C2=A0=C2=A0Let me clarify - we don't need this patch if we fix the ac=
tual bug as
>>> above. IMO.
>>
>> Big NO NO.
>>
>> The damage is already done, we must be responsible for whatever damage
>> we caused, especially the damage has already reached disk.
>>
>> Just fixing the cause and call it a day is definitely not a
>> responsible way.
>>
>> Especially when the damage is done, you have no way to mount it, just
>> like the reporter.
>>
>> You dare to say the same thing to the end user?
>
> You have a btrfs-progs patch to recover from that situation. Right?
> Plus, I suppose you are sending a kernel patch for the actual bug
> which is causing this corruption. No?

Not yet. It can be more complex.
Feel free to try to fix it properly.

>
> This patch is the reporter side fix. I don't encourage fixing the
> reporter because a similar corruption might happen for reasons unknown
> yet. For example, raid1 split-brain? Which is not yet completely
> analyzed and test-cased yet.

No matter whatever the reason, you still can't deny the fact that, if
just super num dev mismatches, there is no need to reject the full fs.

We have tree-checker for each chunk leave, and rw bytes check already.
Even the possible bit flip check for num devs.

The super num devs check doesn't make much sense except causing more
hassles to the end uesr.

The report is just giving us a chance to review if the behavior is
really helpful.
To me, NO.

>
> In my POV.
>
> Thanks, Anand
>
>
>
>>>>> Thanks, Anand
>>>>>
>>>>>
>>>>>> Reported-by: Luca B=C3=A9la Palkovics <luca.bela.palkovics@gmail.co=
m>
>>>>>> Link:
>>>>>> https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=3DzqDq_cW=
COH5TiV46CKmp3igr44okQ@mail.gmail.com/
>>>>>>
>>>>>>
>>>>>>
>>>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>>>> ---
>>>>>> Changelog:
>>>>>> v2:
>>>>>> - Add a proper reason on why this mismatch can happen
>>>>>> =C2=A0=C2=A0 No code change.
>>>>>> ---
>>>>>> =C2=A0 fs/btrfs/volumes.c | 8 ++++----
>>>>>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>>>>> index 74c8024d8f96..d0ba3ff21920 100644
>>>>>> --- a/fs/btrfs/volumes.c
>>>>>> +++ b/fs/btrfs/volumes.c
>>>>>> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct
>>>>>> btrfs_fs_info
>>>>>> *fs_info)
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * do another round of validati=
on checks.
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (total_dev !=3D fs_info->fs_devic=
es->total_devices) {
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info,
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "super_num_devices %llu misma=
tch with num_devices %llu found
>>>>>> here",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_warn(fs_info,
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "super_num_devices %llu misma=
tch with num_devices %llu found
>>>>>> here, will be repaired on next transaction commitment",
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_super_num_devices(fs_info->super_copy),
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 total_dev);
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVAL;
>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->fs_devices->to=
tal_devices =3D total_dev;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_set_super_num_dev=
ices(fs_info->super_copy, total_dev);
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_super_total_bytes(fs_info-=
>super_copy) <
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fs_info->fs_=
devices->total_rw_bytes) {
>>>>>
>>>
>
