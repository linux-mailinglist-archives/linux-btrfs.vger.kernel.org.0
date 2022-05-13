Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8945F525F77
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 12:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379043AbiEMJd1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 05:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiEMJdY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 05:33:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E312F7981A
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652434398;
        bh=6O8BnvoVHU06E34vWeuwUszwKhOwLR1sNWj8U+9J3aE=;
        h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
        b=EawtiAddI/tPDF5iZ6D89CjTCZTdU/swfYHm65mSWfnjDMjtvrO4MRG155/aK/I/7
         nju20QXarHy0qdG6OTN9q+xjrki8JUZvr8jEL71UmnfGe5wPCgavJM5tp/lGp1sImv
         EFM0n8HT8yrhAKYWM/XGLGyidbGb0KrcL3azQxVI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MnJhU-1oEqGv0smi-00jI7t; Fri, 13
 May 2022 11:33:17 +0200
Message-ID: <8ad3537d-a8c1-77ca-1581-1ceac0ad585d@gmx.com>
Date:   Fri, 13 May 2022 17:33:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 4/4] btrfs: use btrfs_raid_array[].ncopies in
 btrfs_num_copies()
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <cover.1652428644.git.wqu@suse.com>
 <a51939d1e568f36135c8f0383a4f34da5bda0f4b.1652428644.git.wqu@suse.com>
 <PH0PR04MB7416E0CEDDA84965B0FDD2919BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <ace856f6-b1c0-6746-797e-af85ce6a0f0b@gmx.com>
 <PH0PR04MB74169DCF588F328DBE0D6B1E9BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <PH0PR04MB74169DCF588F328DBE0D6B1E9BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R79+M1EgxiIBtDsHjdW4fPAgNMJGbEiUUpg+1CwnMMvXfYSZ0CZ
 1i4XytLEDHGlT1hQInntBTBFA+wPxzw9V2i+SClbxYFOR3i4UTiiMeo0F7J8Ttvq4F08pJO
 N4lUneh+LdaFNUVZVSZHdm0M1W6nqYB8unTU0wdsxScF/dG0Io6I005uzDgGe6t57gtlJHq
 zoli31snVlKBqOyPrBiZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7YVcbaRjXSM=:E7fmV21gQfj/nDESnob+O5
 brKakgBFmjvCq7U3knL7jmn527x57Qcb9qbtIceHeZ/v6TESSsl96fPwTZsbDOKbdns+9E0mk
 Eoh8t+AvNqcwkVgUSEYuBcGQdRaDSK38teSHD6c7BgsVm44PBpiImRQJMt4aGuB52xQcS5ln/
 1vxd0o438T53lfJCK0qxK9WxeIQ+gP3Iv3syvxr+ZeL90ky9C1HrCwF+D9RgT/OPssfoKK/GJ
 wChQwYKQ7I1f0xU8uPfwKqQMkm9q+L3tn0EVqoxDehgdqIYcaqMfWyKeD9b5Ge3cOatxd08NA
 Df3g/aTi9dXxkaP72/r5js9W0aXGQD8konW0nbnLGjRNjNDvz3Xkn9tpw+qhm4m7958PcmEiT
 JQU0t/Jq53YufSdcIVGufEDE3DKrtaZmDWN6cXrFXpA1PsIvkez+zxIjX/rgOyLADRjCjOt7f
 ZLNR9NQVMPUW+rX/IE2tQBOm2Ba/2hNsgoC1f4K/PLsD45ebroYe6WCW5vSotdF2UyOK3NiRy
 0tMhNu9NcUBnw16rcLsw5xtIUk3lHAXvuoE4paXT6GNqt37tf3gf44hY7sjVMYFWnFmb59thd
 iCtWU3PRwrJXfMrpqwyvdwRdZeGkrc38Xh88QO6PSH/12zHE9kYs/+BWtajMz7CTK5gWmEYkP
 2064gE8er0IWa48vYxzay0TqNHRdXcuRDB7iBjPYU6vtTCVAP077Tdn+oRkUenYyhWZpTP42M
 XEGTwO5cp+lmdIcIKGG5Rx5AO6+C79kI6ZTAH08/fRHEaTPGfIIkGTa1XQ1kUKEzirkLJYW3f
 snOm/evK684lyahJ/YU97kiyTEbeboVPolsu1XWCxCjf4YSfgagP8ItaL5ECXavsu0MoM566/
 3NrbPDB0peXzCaLWlWdvFKLy3zflhxgZObjnCf968A8zLQtV61XceC+Se9qeNkL3dF4PMVM5N
 UOuCqObK96ss3EJGtpiqqNeJ2F0IfNrV4+9lv0JKvDrwfp55jDltw3WPPyLgI/kK4SGNAwYxl
 dX/QUotzRxPB0GGvmI+mvUATCnRlCPgQyq1e7xXhN61V6LteYPmWl80RQ+g+1joKKFKNGcNom
 v/W88/88Vvf30gsWmKOZt948wTJcJuCO55HDha0xG3o8t72AFGE1wgz7w==
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/13 17:24, Johannes Thumshirn wrote:
> On 13/05/2022 11:22, Qu Wenruo wrote:
>>
>>
>> On 2022/5/13 17:15, Johannes Thumshirn wrote:
>>> On 13/05/2022 10:34, Qu Wenruo wrote:
>>>>    	map =3D em->map_lookup;
>>>> -	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1_MA=
SK))
>>>> -		ret =3D map->num_stripes;
>>>> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)
>>>> -		ret =3D map->sub_stripes;
>>>> +	index =3D btrfs_bg_flags_to_raid_index(map->type);
>>>> +
>>>> +	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))
>>>> +		/* Non-raid56, use their ncopies from btrfs_raid_array[]. */
>>>> +		ret =3D btrfs_raid_array[index].ncopies;
>>>>    	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
>>>>    		ret =3D 2;
>>>>    	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
>>>
>>> Here I'm not 100% sure. RAID10 used sub_stripes and now it's using nco=
pies.
>>> The code still produces the same result, as for RAID10 ncopies =3D=3D =
sub_stripes,
>>> but semantically it's different (I think).
>>
>> Since the objective of the code is the get the number of mirrors for th=
e
>> chunk, sub_stripes is definitely not correct here.
>>
>> Just imagine if we have RAID1C30 (sounds ugly I know), which is RAID1C3
>> first, then RAID0.
>>
>> We should still have sub_stripes =3D=3D 2, but ncopies =3D=3D 3.

My bad, unfortunately if we really have RAID1C30, sub_stripes will still
be 3, and ncopies is also 3...

But you get the point, ncopies is the number of copies for mirror based
profiles, so semantically we should go ncopies.

While for sub_stripes, any RAID1 then RAID0 profiles will always get
ncopies =3D=3D sub_stripes.
So the old code can always reproduce correct result.

If we have things like RAID01, we may have a different result, but then
I guess we will have special semantic for RAID01 then.

Thanks,
Qu

>>
>> And the number of mirrors is definitely 3, not 2.
>>
>> So it's the old code not correctly semantically.
>
> Ah ok then. Thanks for the explanation.
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
