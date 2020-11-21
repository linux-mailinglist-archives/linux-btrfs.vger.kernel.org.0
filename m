Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252532BBF0D
	for <lists+linux-btrfs@lfdr.de>; Sat, 21 Nov 2020 13:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKUMtV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 21 Nov 2020 07:49:21 -0500
Received: from de-smtp-delivery-52.mimecast.com ([51.163.158.52]:58116 "EHLO
        de-smtp-delivery-52.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727497AbgKUMtT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 21 Nov 2020 07:49:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1605962956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=JJQUOebxxYb1vB/sq9wKpzRFc8qXeYvI9FtS3x/85ys=;
        b=kZkNsQxPPxce88HSUMhFkRja24hDmPe/JGR0lEOOjJWKUCU6O5ZQqeMl7U58ytYO3GMbo3
        ghrBK4rWrxlHN0BQy/UKbC5nhRY62cYvV24ZVKOM9ZCdMYCWjGZsCLyAtSpHVa+EmdlPnq
        ypxEo+VGqYZz3jpqKskY2QBQl46fzJE=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2058.outbound.protection.outlook.com [104.47.13.58]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-25-WlDkGhQPPwGY1tS-3N2Y6Q-1; Sat, 21 Nov 2020 13:49:14 +0100
X-MC-Unique: WlDkGhQPPwGY1tS-3N2Y6Q-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFnPM4Tg4yZ2DepsbwAm5l3IMlGKBDyE8OBnD9jqb1t8rOQB/FxkTsX2UFHLTA/8+PKIEKi/AMi/OwEOU/RYvhqVLWcK1vP6ozSnJv3pFXqQ/vMh1pycSlxaTYnv8xva67i+RexDjvMB49TuxU5XUB1UgtiuTv0/98uH7P7eTlL5kTDndPRStyufgqjMAquZ2+IQGw8A76p+UFc94gwaFEkdDYs/RjqpUtOyB/oENN0a5kykCJc6twDYza7RnrUaT6JnyLtHT75lB1b92iotckVoptCqDX7t0MiKoX6yIffmPTxHXgmWtj7XcyYLDOSOqr0NR3LoVHaWpMbCGLNaLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0qFL1RpNgrMONPJGmD0JXl2/AHnbLf2Y4uyzF8a4/Q=;
 b=njVr8N1Nm6y5Cp9jgrC/6CBICXqd+e1mHjvp4g0FMJWiPTziPliWiuyU8hArEm87AcC86URbsD32+Mr7mrxLPuIfs7X6LuIESBkUlRSJiD2mgRq9ZNR6b0fODl8Zak4grrH56flntYtORUDFUXbuXwy62ZtNn+RLr9fzQM/lh5/1bJTuLY5OkCr/XifcHE3U4x+UmoOfdnSo/8RiwZH/pcf2cB2dpCIW0Cnj/p1PzfES2kI1dgY/KpLqk2qYlRWOWQlPE6ReiEGx/CetLnJW9by5rGmVfR764VzrVanxAmruA5d1APYR6wElj0uD3bZBCnkA9fvI8ubrH0cQautNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PR3PR04MB7291.eurprd04.prod.outlook.com (2603:10a6:102:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Sat, 21 Nov
 2020 12:49:12 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3589.022; Sat, 21 Nov 2020
 12:49:12 +0000
Subject: Re: [PATCH v2 2/3] btrfs-progs: inspect: Fix logical-resolve file
 path lookup
To:     Marcos Paulo de Souza <mpdesouza@suse.de>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Marcos Paulo de Souza <marcos@mpdesouza.com>,
        linux-btrfs@vger.kernel.org
CC:     Marcos Paulo de Souza <mpdesouza@suse.com>, dsterba@suse.com
References: <20201116173249.11847-1-marcos@mpdesouza.com>
 <20201116173249.11847-3-marcos@mpdesouza.com>
 <977d37a3-5240-c5d6-b117-d91f0e5a5f9c@gmx.com>
 <0f7074c63924d64feb837c67bb8f25a6d0b6ac29.camel@suse.de>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <c8d8c050-3ed8-ece5-f46f-f1702973c837@suse.com>
Date:   Sat, 21 Nov 2020 20:48:51 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <0f7074c63924d64feb837c67bb8f25a6d0b6ac29.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:180::18) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR13CA0005.namprd13.prod.outlook.com (2603:10b6:a03:180::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.9 via Frontend Transport; Sat, 21 Nov 2020 12:49:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b8a9651-de2e-4ec9-4220-08d88e1bd87e
X-MS-TrafficTypeDiagnostic: PR3PR04MB7291:
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PR3PR04MB7291BF69EA6958FF2DDBE6CAD6FE0@PR3PR04MB7291.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kNsUlUAEB7Pj3P6PEL9wEMWoYMVWxMcv+owHMF8+jwkTY//cy3DByMhadGNVJ5zBzwRFIL/bO4JVnI//aHhQXQhBJk3kpJH0LJG8noPnW+jrwnP5rNaHd12ShBCDfDTMcwZQ4tadyL4igO5+6ngnd5AugSVd4qRr4qkLfWaP82Zlvi3E5cAtuo2dDuqGe6vinbDS+mVXKK1dIWbirbW6UAAOJdFkG5kJZg9S+mOY8+99inrTh7Ao+hDv9tLn3IgDU2hb/Hh0ua3GmqqAuVVZNriubXr6GNPL29KuPxXU0mOx32ZgVM7hPqOrxM6C437BIteF6K/WZuX/he5ZttQ9jFOHTsVK0pEiNyrCi45RZN50WClvIdFpYJ3SPvN2Yyf2h0ySQYX1dSSSaAvc945A2HhJq1nB6i0lTnKyT//nqbI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(396003)(39850400004)(366004)(6706004)(478600001)(31696002)(186003)(16526019)(26005)(4001150100001)(8936002)(2906002)(8676002)(86362001)(107886003)(52116002)(66476007)(5660300002)(66556008)(110136005)(956004)(316002)(36756003)(16576012)(6666004)(2616005)(6486002)(4326008)(66946007)(31686004)(83380400001)(21314003)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: GcnEmx3+Ee9395j74TQf5ORPvG4U4CL25oJe1I/kCGGeEs9F3KrvJS0THwEj4nKFzJZFjEBVHZGbkMKidcNnG6Xux2MzoLTtipfQ+7BBVyHUynvrbR/+6lK47fnFVziWHJkymuyZrJrnbFMciSIDrg8gb2QHPNAcXZYD2a3M85Es4TLvloUkZd239flzkRS6QnyIvo/faNJcHgpoYJPRElffWfreWYV5Ya3IhWUSPS9niW9A1UNbm4IZQv2iOc6EN9syNLOIvXj/ixkxxOMUqjuQvuhOI6/JDz/J5i0jsviJN1sekNVGnJNnlyZ9+SLJEjPvsHGg5JbOq5rZnvPYfIR4HyoJWgRuvDk0e1ZApuTajmLeyG5d2YaTamfs+V0kqZZ7RVJkAyrb7tktEZ0IdNXTk+/Ooqc4PB7dRKEaueWd6DBbRT0U9hk1ULIFIH9avX+VevmIpR4HBizDt9yoWhFPm1Y+pCCpUxImUX8F6taj+AK4ZsD23LNNbHsK2TcuIh1Y3o7d4ypVaomT4ljVQGESaSmcBa/DuT4CPghSSf1jNTYx0Hqm5C9L3b7AqDu+HXaj+xYBk4RjYOunZAXAJfESImQi4MIIkAHW3jhCeYnUduB4a41du2t7i+g7Eg1lUIMeVLlxPsZ7Z676tiKM5mvqgJBYSyxq8QTN6Pt+wv4/o8sWUHZxF3oY3YgFhnLoLU/R2mGTBYfCdRJX4F8DqzBYNhKuZq4Uedp1Jwvo+CSc0vV+yjvvGBcDo/VGx3NxUChLaMNFjPjCVwKwUzgqt4rINjEm6A1aQl0zchmOCJZl2IIeskgM8OtHqsbIXNCZ2Qivwq50D6PiQ9oZne260k2BZaiFn4kOb2pfQbMbNoa4cVP/zuI1j0ix8UO5lDvzU4zIA5ahD/t1dJhs0Fu/5Q==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b8a9651-de2e-4ec9-4220-08d88e1bd87e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2020 12:49:12.1872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLHMgGif54RZrJYI3+c4eD8PtTqaWeSUqldfdZbckFzF8VqjhN90gaIi7U68MyYY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7291
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/11/21 =E4=B8=8B=E5=8D=888:35, Marcos Paulo de Souza wrote:
> On Fri, 2020-11-20 at 16:32 +0800, Qu Wenruo wrote:
>>
>> On 2020/11/17 =E4=B8=8A=E5=8D=881:32, Marcos Paulo de Souza wrote:
>>> From: Marcos Paulo de Souza <mpdesouza@suse.com>
>>>
>>> [BUG]
>>> logical-resolve is currently broken on systems that have a child
>>> subvolume being mounted without access to the parent subvolume.
>>> This is the default for SLE/openSUSE installations. openSUSE has
>>> the
>>> subvolume '@' as the parent of all other subvolumes like /boot,
>>> /home.
>>> The subvolume '@' is never mounted, and accessed, but only it's
>>> child:
>>>
>>> mount | grep btrfs
>>> /dev/sda2 on / type btrfs
>>> (rw,relatime,ssd,space_cache,subvolid=3D267,subvol=3D/@/.snapshots/1/sn
>>> apshot)
>>> /dev/sda2 on /opt type btrfs
>>> (rw,relatime,ssd,space_cache,subvolid=3D262,subvol=3D/@/opt)
>>> /dev/sda2 on /boot/grub2/i386-pc type btrfs
>>> (rw,relatime,ssd,space_cache,subvolid=3D265,subvol=3D/@/boot/grub2/i386
>>> -pc)
>>>
>>> logical-resolve command calls btrfs_list_path_for_root, that
>>> returns the
>>> subvolume full-path that corresponds to the tree id of the logical
>>> address. As the name implies, the 'full-path' returns all
>>> subvolumes,
>>> starting from '@'. Later on, btrfs_open_dir is calles using the
>>> path
>>> returned, but it fails to resolve it since it contains the '@' and
>>> this
>>> subvolume cannot be accessed.
>>>
>>> The same problem can be triggered to any user that calls for
>>> logical-resolve on a child subvolume that has the parent subvolume
>>> not accessible.
>>>
>>> Another problem in the current approach is that it believes that a
>>> subvolume will be mounted in a directory with the same name e.g
>>> /@/boot
>>> being mounted in /boot. When this is not true, the code also fails,
>>> since it uses the subvolume name as the path accessible by the
>>> user.
>>>
>>> [FIX]
>>> Extent the find_mount_root function by allowing it to check for
>>> mnt_opts
>>> member of mntent struct. Using this new approach we can change
>>> logical-resolve command to search for subvolid=3DXXX,subvol=3DYYY. This
>>> is
>>> the two problems stated above by not trusting the subvolume name
>>> being
>>> the mountpoint name, and not following the subvolume tree blindly.
>>>
>>> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
>>> ---
>>>  cmds/inspect.c | 30 ++++++++++++++++++++++--------
>>>  common/utils.c | 13 +++++++++----
>>>  common/utils.h |  5 ++++-
>>>  3 files changed, 35 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/cmds/inspect.c b/cmds/inspect.c
>>> index 2530b904..0dc62d18 100644
>>> --- a/cmds/inspect.c
>>> +++ b/cmds/inspect.c
>>> @@ -245,15 +245,29 @@ static int cmd_inspect_logical_resolve(const
>>> struct cmd_struct *cmd,
>>>  				path_ptr[-1] =3D '\0';
>>>  				path_fd =3D fd;
>>>  			} else {
>>> -				path_ptr[-1] =3D '/';
>>> -				ret =3D snprintf(path_ptr, bytes_left,
>>> "%s",
>>> -						name);
>>> -				free(name);
>>> -				if (ret >=3D bytes_left) {
>>> -					error("path buffer too small:
>>> %d bytes",
>>> -							bytes_left -
>>> ret);
>>> +				char *mounted =3D NULL;
>>> +				char volid_str[PATH_MAX];
>>> +
>>> +				/*
>>> +				 * btrfs_list_path_for_root returns the
>>> full
>>> +				 * path to the subvolume pointed by
>>> root, but the
>>> +				 * subvolume can be mounted in a
>>> directory name
>>> +				 * different from the subvolume name.
>>> In this
>>> +				 * case we need to find the correct
>>> mountpoint
>>> +				 * using same subvol path and subvol id
>>> found
>>> +				 * before.
>>> +				 */
>>> +				snprintf(volid_str, PATH_MAX,
>>> "subvolid=3D%llu,subvol=3D/%s",
>>> +						root, name);
>>> +
>>> +				ret =3D find_mount_root(full_path,
>>> volid_str,
>>> +						BTRFS_FIND_ROOT_OPTS,
>>> &mounted);
>>> +				if (ret < 0)
>>>  					goto out;
>>> -				}
>>
>> OK, I see how you utilize the new parameter now.
>>
>> But considering there is only one user for BTRFS_FIND_ROOT_OPTS, i
>> really hope to not touching the existing callers.
>> Anyway this is just a nitpick, and mostly personal taste.
>=20
> I tried to avoid creating a new function for only to only check a
> different field of mntent, so I slightly changed the callers. But let
> me know if you have a better idea for this case.
>=20
>>
>> Another thing is, what if we bind mount a dir of btrfs to another
>> location.
>> Wouldn't this trick the find_mount_root() again?
>=20
> I don't see why, since they point to the same fs. The only difference
> is that find_mount_root can then print the mnt_dir of the bind mount in
> the case that the path that was matched was bigger than the other mount
> points (longest_matchlen in find_mount_root).

So you mean it can handle such case?

# mount $dev $mnt
# mkdir $mnt/dir
# mount -o bind $mnt/dir $mnt2
# umount $mnt

Then in $mnt2 we can only access what inside dir, even something inside
the same subvolume can't be accessed.

In that case, can the function still handle it?

Thanks,
Qu
>=20
>>
>> Personally speaking, we should only permit subvolume entry to be
>> passes
>> to the btrfs-logical-resolve command to avoid such problems.
>=20
> Doesn't it limit the usage of logical-resolve?
>=20
> If the user receive this a message about checksum problems like
>=20
> BTRFS error (device dasda3): unable to fixup (regular) error at logical
> 519704576 on dev=20
>=20
> How would the user know which in which subvolume the address is being
> referred to? Maybe we could add this info on the kernel side to print
> the subvol id too? IMHO it would be better if we could find the correct
> subvolume in logical-address as this gives more flexibility to the
> user. But I'm all ears :)
>=20
>>
>> Thanks,
>> Qu
>>> +
>>> +				strncpy(full_path, mounted, PATH_MAX);
>>> +				free(mounted);
>>> +
>>>  				path_fd =3D btrfs_open_dir(full_path,
>>> &dirs, 1);
>>>  				if (path_fd < 0) {
>>>  					ret =3D -ENOENT;
>>> diff --git a/common/utils.c b/common/utils.c
>>> index 1c264455..7e6f406b 100644
>>> --- a/common/utils.c
>>> +++ b/common/utils.c
>>> @@ -1261,8 +1261,6 @@ int find_mount_root(const char *path, const
>>> char *data, u8 flag, char **mount_ro
>>>  	char *cmp_field =3D NULL;
>>>  	bool found;
>>> =20
>>> -	BUG_ON(flag !=3D BTRFS_FIND_ROOT_PATH);
>>> -
>>>  	fd =3D open(path, O_RDONLY | O_NOATIME);
>>>  	if (fd < 0)
>>>  		return -errno;
>>> @@ -1273,11 +1271,18 @@ int find_mount_root(const char *path, const
>>> char *data, u8 flag, char **mount_ro
>>>  		return -errno;
>>> =20
>>>  	while ((ent =3D getmntent(mnttab))) {
>>> -		cmp_field =3D ent->mnt_dir;
>>> +		/* BTRFS_FIND_ROOT_PATH is the default behavior */
>>> +		if (flag =3D=3D BTRFS_FIND_ROOT_OPTS)
>>> +			cmp_field =3D ent->mnt_opts;
>>> +		else
>>> +			cmp_field =3D ent->mnt_dir;
>>> =20
>>>  		len =3D strlen(cmp_field);
>>> =20
>>> -		found =3D strncmp(cmp_field, data, len) =3D=3D 0;
>>> +		if (flag =3D=3D BTRFS_FIND_ROOT_OPTS)
>>> +			found =3D strstr(cmp_field, data) !=3D NULL;
>>> +		else
>>> +			found =3D strncmp(cmp_field, data, len) =3D=3D 0;
>>> =20
>>>  		if (found) {
>>>  			/* match found and use the latest match */
>>> diff --git a/common/utils.h b/common/utils.h
>>> index 449e1d3e..b5d256c6 100644
>>> --- a/common/utils.h
>>> +++ b/common/utils.h
>>> @@ -54,7 +54,10 @@
>>> =20
>>>  enum btrfs_find_root_flags {
>>>  	/* check mnt_dir of mntent */
>>> -	BTRFS_FIND_ROOT_PATH =3D 0
>>> +	BTRFS_FIND_ROOT_PATH =3D 0,
>>> +
>>> +	/* check mnt_opts of mntent */
>>> +	BTRFS_FIND_ROOT_OPTS
>>>  };
>>> =20
>>>  void units_set_mode(unsigned *units, unsigned mode);
>>>
>=20

