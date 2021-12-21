Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6367547B867
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Dec 2021 03:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbhLUCe6 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 20 Dec 2021 21:34:58 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:20701 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232030AbhLUCe5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 20 Dec 2021 21:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1640054096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UxI3VHsCqw/Rlt7U900MgrQL7PlxZOWAeDrdd6cfxXU=;
        b=J8VoJ+9fK2hD4amSLiNFJr6cOOwlGUb4GjAMEv0mMuSHi7WIZS32JbNHVNwnbfDT/PNVNw
        HJjIDBCfWmv8ee9fz2rHLmoIpZuHk9FBRDMtcyTAa/wTpkIwVWQCVFbYZzESh8zaPQkSNz
        4X/f2LQlwKNDLJaYaAvXVHCccUux9r0=
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01lp2052.outbound.protection.outlook.com [104.47.1.52]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-13-VvhzUNELPhya8G_FIFJlJA-1; Tue, 21 Dec 2021 03:34:55 +0100
X-MC-Unique: VvhzUNELPhya8G_FIFJlJA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWbeSd48Xi2dbpMpLpzkH4uUvkI0v2t98rtR/QEp94OjhFwhcd9rhPtfG6xmK9CYSiUWTWxxvE9BdBDa+sRAY7L3GPCc9IV8y8fup5zXM8EzivwBSMSf0whh1EfKyAvkdMunDkW3rhxLR4GkotXPAXvhZFb5vW/UcOAoPxyDT4sRP6deYPDu6/tvr9oLUpMPfBHAN9lLGARrrvIYkue5fzTeHaIhPiJtQQ6oj+3zqRKBvAb1jSimP5dhzXPjxdgggsysGyCtKkOswyqGfwnT7gvbPBc6jVtNudcck5jnKcwr0xuVe9qoijSb6nQ1Cv1gPILCAuESEmmGWkmOQMgWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imrhcKX8IA+gKpAg1oQRNvS/Q2K7VM87b/zDncdrkDM=;
 b=iW99BgeicXYYMygefaFZ4gFa1VS8IydbPjz3nVFpoHNz7bRkCYTt3v9aTf2TfZ/tDTN21xHrJU2oHOm4fXukX8YHLdWu1GQjZ+3PZhC1gIPpemZHZUHSRRqJgqeIxCPoEX8V3y+oxEE46dW8G94N4NQnJwo1vkzXcY6A8ySuH/izRiyS4OeOw4H6gyJ0wj0nwCETFKRMnbW04ABYu/ntL7bflcBeuNUzSzLMaa5nukUuoUTRJrOIDn8A5wcICk21BSjes8mAwayySysbCl++beRCYGjKw77/rPPmhQtLp42Xp0Cpm7n0HYGAWISqoznsx9o5b3f9pgVPWz8TRoheFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by DB9PR04MB9235.eurprd04.prod.outlook.com (2603:10a6:10:371::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.18; Tue, 21 Dec
 2021 02:34:53 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%5]) with mapi id 15.20.4778.018; Tue, 21 Dec 2021
 02:34:53 +0000
Message-ID: <048b4de4-3394-dc27-d510-c20150f19afb@suse.com>
Date:   Tue, 21 Dec 2021 10:34:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: btrfs_free_extent
Content-Language: en-US
To:     Tuetuopay <tuetuopay@me.com>, Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <ce91d387-78e0-3e8e-fd05-a3f952352e73@gmx.com>
 <41C61371-EB11-42B4-A9C8-6296D45CB9A7@getmailspring.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <41C61371-EB11-42B4-A9C8-6296D45CB9A7@getmailspring.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:74::48) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b182f3c-1aa0-415f-3e9b-08d9c42a77e6
X-MS-TrafficTypeDiagnostic: DB9PR04MB9235:EE_
X-Microsoft-Antispam-PRVS: <DB9PR04MB92351DD3BE4C953A941A279DD67C9@DB9PR04MB9235.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWLFFf9eSEyl03+/p/46dmesdrSiBk5YaIc+7Zfcta5p2+sNVCmotkIwvrM2NVw3GVgKf3fpdxS3xkYtlTqak/4Ekgk4Ak7frfV2M0+jWCN+7umi0v7xByx+yHNhxOI9eaAC4BEDJBaWWTnrJ5WEx+lCYPfqrlNwS6oPDE6Z1Ig0TX5l+QPH4nmICPDSkzma4+1j1zs6oQXtXnCGeXFhm7PGJHLtXe+BrRcsBIIQz2n6JZGAbpExlbw62LuElzJU/59FCC6oUFRIfZBMBCg3cWBl7e5j7tU85qnlYkOzfViFNmGsAV4Evl2peBorQ7W2C8Q9zSTo+1BJ+CoMruxrVTDKwWf+oMYVx51ZhPh8BFzXnMwtOS61GhfckUVHSmyuwGJ5thDZhk9DoISOTjQcnk0YmHTxG9Npmo6SSoi/MdGKZD7VNycbWVb5z4DsTdLmwVzjflFqJxvx3iVR2+f64ojkFQQmBTk8nv5XxcSEE7Y6P1miIX8TE4vEt/G5m02/SKXZ4sUJPaIs44eA4ePXZ+42kLjRG9HmdLBg21fVudqEaDT1kugFX5PrFfR0MKxkK+6ngjY1sC803LUEjieLcTxRCjWvYh3ulr6S7ZsiZV3FyocOjFng1iyC/Do7ApVK5is5jwqmezS4tepyo6mChlfY4XTY3m1qliT2lZ6AjAvU9M36IJCXTQwDyuTEBMLZCurgzEyrYWO1VkMiO3PGQyMC7MlsByRrWqAlsf6WdT59UL5wvaM/uVlm3ZU+WqLY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(31686004)(2906002)(2616005)(36756003)(86362001)(186003)(83380400001)(6666004)(4326008)(66574015)(7116003)(8676002)(66556008)(53546011)(31696002)(6512007)(8936002)(316002)(38100700002)(110136005)(26005)(6506007)(66476007)(6486002)(66946007)(508600001)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XoK3hKqNq7VIEawwvQQCD9sPi0N8eAXudeRIQBXQfnFXzCdbh9MPQTlWRbHJ?=
 =?us-ascii?Q?UdiAKUN23nFvucMBEiBabjG+BKV6JGjsQdKvGlX1YUIKLQaiIOh096+xzlj5?=
 =?us-ascii?Q?jlsTAJmYJ5vYPyiHlfxxxT+9oCWhNnCEIjeA6WBYr4eQG3cuQBg2hWiOF8x6?=
 =?us-ascii?Q?tQiQH5oGN4UB+tRz1uuhq7i5uiVCOCGLxZHzQmqNij04jS7K4G7hT+sR6sNG?=
 =?us-ascii?Q?lytXYX1g/Tg7qaXp4foIPew83jsJY2YN4r+ZWwMkMYPe6JpigGhl+Pp05LY0?=
 =?us-ascii?Q?wcBUYfG+wG3CQdHh0fC2dcRpoAeBAamP0a0PUJoDeHCClB7bp/ezEPWzxQcj?=
 =?us-ascii?Q?mIx0ixr78rmmNgb8blCD5vBC5x8/GaoMlc4FCDfF1cOkljUzx9sYr0bqYbXY?=
 =?us-ascii?Q?JykUe3NFkedY3DlcFl6Owvfd1sMImqwO1kGk8x/nx0en+ZrhA5tNAvEyVdmM?=
 =?us-ascii?Q?UH8i5oDs6cl/gKKKG9fQrujd2hYMn1ngyxZKiexNi3Ex2cw5Vr9yH1ph/8CK?=
 =?us-ascii?Q?gcNXACKRjpLuIvp0RpuVTfhipSymFq8xw9PPzI6XoYc1xaoIIQgC06o6SN37?=
 =?us-ascii?Q?GiWh2wTUdEYb6mnLWq94K4+mrBc3yoGiMK4RMn7d+bzkhPDlSINQ1NvfC5vz?=
 =?us-ascii?Q?2OR2S3JysWeCNJxW02Mwdvc4Kk+BRkCdc8ws92QnPEM7mNpkge00WghRNUwg?=
 =?us-ascii?Q?3BbZQPz3dzyTYG3KL/7liUE2riDeEpzvZbwSEyIrLStNJJw+GGB0JuimvAOh?=
 =?us-ascii?Q?QAVRGWb5+QBnNZP+xWe1jalhD6+pJ14KGQA5vV4LEf7bwoCbvGpc814+NAAX?=
 =?us-ascii?Q?K25kXOvC8Zi1DuM8+AkYeaCKXn4H2EnAEeXeq6IPV4JdYRuCg6MsGFeeHZxk?=
 =?us-ascii?Q?VWhG9rT5COh19FS9Q6/gPATSJzF1Vawy7t4iDvOLRl7T95bs87XK0GxE6fc6?=
 =?us-ascii?Q?si0fkrOAUY+41a1ZJj08f85J5vxAUrN2Y7d6AgUqW6y0mBo9z4QuTezjv3dh?=
 =?us-ascii?Q?TRqvKvWEd4d4W8nc5XGUWdW9JDs6ytql9mF5ePXaK1CiAn+TsZIQkdzpU/nK?=
 =?us-ascii?Q?+qGnwdwIMBXdG7vnye8qQqdCEaa2Q6LmNAWI6G02QBPHeBTQZALKsLQlCXEC?=
 =?us-ascii?Q?zHNWS6WoIFYkQjPDU75iVlYVrcLg00B43zfYWowAG8aX5Bzget/7OYHkYESa?=
 =?us-ascii?Q?jbpdTg5mTzsp+EPmnK8KBvzEaLpNd34Rlj0rMEF8h9NSq0Fozs+lT5HznrEn?=
 =?us-ascii?Q?/TFjghAPI0m8U4BqFrV0MIg/igFmnH0FAGb4oaCj3iuaJO5UCxpsj0dWd/Li?=
 =?us-ascii?Q?cGSqTGT3BdcnHhibswKPyE4GlQXL8ocal4gN0o9A4g5xQu2/LJ0TsGT3tIaP?=
 =?us-ascii?Q?hfUwSg/hErqSDPIGzqswfy7kjcyioGvfGYdvgptrGudsBqMP7+QbMjy0L/Qt?=
 =?us-ascii?Q?+FI9S8fyBWiy37IDY5hGMCRLCTkABLA6eUtm266RcON1PlOecxQS55SfTc3+?=
 =?us-ascii?Q?3tWJQ4N8YIcNyrjUcumoPxY33UAW2fo27o9o+D+5jaQE8EMmOpwjmxVrWi2K?=
 =?us-ascii?Q?jWARDSC6jT+9flZw9ys=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b182f3c-1aa0-415f-3e9b-08d9c42a77e6
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 02:34:53.0759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YZktrN3NjjL2t/W5hfQR8XPEhJTDXHah0rZfliGdFEaKK7iK5yXx4WTKa4sHzCp4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9235
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/12/21 10:05, Tuetuopay wrote:
> Hi,
>=20
> Thank you so much for your advice. The check in repair mode did indeed
> work without issue, and the issues I had with the files now seem gone.
> I'm stressing a bit the drives right now to see if everything's solved,
> but it looks like it.

To be safe, another read-only btrfs-check would tell you if all the=20
metadata problems are gone.

And for data correctness, scrub is always the way you go.

Thanks,
Qu

>=20
> Cheers!
> Alexis
>=20
> On d=C3=A9c. 21 2021, at 12:20 am, Qu Wenruo <quwenruo.btrfs@gmx.com> wro=
te:
>> On 2021/12/21 04:30, Tuetuopay wrote:
>>> Hi,
>>>  =20
>>> It's me again. I have completed several memtest86+ passes without error=
s
>>> whatsoever, so this RAM can be considered good. Also, following your
>>> advice, I built and upgraded the kernel to the latest stable, i.e. 5.15=
.10.
>>>  =20
>>> What is the next step to (hopefully) fix the error? Is it to run `btrfs
>>> check` but not in readonly mode. I think I'll need to upgrade
>>> btrfs-progs too since I'm now running 5.15.10 instead of 5.10.70.
>>  =20
>> Yes, latest btrfs-progs is always recommended.
>>  =20
>> After backing up the important data and upgrading btrfs-progs, "btrfs
>> check --repair" could at least solve the extent tree problem.
>>  =20
>> Thanks,
>> Qu
>>>  =20
>>> Thank you so much in advance!
>>>  =20
>>> Alexis
>>>  =20
>>> On d=C3=A9c. 20 2021, at 10:35 am, Tuetuopay <tuetuopay@me.com> wrote:
>>>> Hi, thanks for the swift reply!
>>>>  =20
>>>> On d=C3=A9c. 20 2021, at 12:42 am, Qu Wenruo <quwenruo.btrfs@gmx.com> =
wrote:
>>>>> On 2021/12/19 23:24, Tuetuopay wrote:
>>>>>> Hi,
>>>>>>  =20
>>>>>> I need some advice on a btrfs raid-1 volume that shows a few corrupt=
ions
>>>>>> on some places. I have some files that triggered some safeguards on
>>>>>> write, which ended up remounting the fs as read-only.
>>>>>>  =20
>>>>>> Over on IRC, multicore suggested me to run a readonly check, whose
>>>>>> output is here:
>>>>>>  =20
>>>>>> # btrfs check --readonly
>>>>>> /dev/disk/by-uuid/e944a837-f89b-48ea-80fd-40b2bec8f21b
>>>>>> Opening filesystem to check...
>>>>>> Checking filesystem on /dev/disk/by-uuid/e944a837-f89b-48ea-80fd-40b=
2bec8f21b
>>>>>> UUID: e944a837-f89b-48ea-80fd-40b2bec8f21b
>>>>>> [1/7] checking root items
>>>>>> [2/7] checking extents
>>>>>> tree backref 9882747355136 root 7 not found in extent tree
>>>>>> backref 9882747355136 root 23 not referenced back 0x556ea3cb07d0
>>>>>  =20
>>>>> This is one corruption in extent tree, we don't have root 23 at all.
>>>>> Only root 7 is correct.
>>>>>  =20
>>>>> On the other hand, 23 =3D 0x17, while 7 =3D 0x07.
>>>>>  =20
>>>>> So, see a pattern here?
>>>>>  =20
>>>>> Thus recommend to memtest to make sure it's not a memory bitflip caus=
ing
>>>>> the corruption in the first hand.
>>>>  =20
>>>> That definitely looks like a bitflip to me.
>>>>  =20
>>>>>> incorrect global backref count on 9882747355136 found 2 wanted 1
>>>>>> backpointer mismatch on [9882747355136 16384]
>>>>>> ERROR: errors found in extent allocation tree or chunk allocation
>>>>>> [3/7] checking free space cache
>>>>>> [4/7] checking fs roots
>>>>>> root 5 inode 1626695 errors 40000
>>>>>> Dir items with mismatch hash:
>>>>>> 	name: fendor.qti.hardware.sigma_miracast@1.0-impl.so namelen: 46 wa=
nted
>>>>>> 0x12c67915 has 0x0471bc31
>>>>>> root 5 inode 1626696 errors 2000, link count wrong
>>>>>> 	unresolved ref dir 1626695 index 2 namelen 46 name
>>>>>> vendor.qti.hardware.sigma_miracast@1.0-impl.so filetype 1 errors
>>>>>> 1, no
>>>>>> dir item
>>>>>  =20
>>>>> This can also be caused by memory bitfip.
>>>>>  =20
>>>>> Fortunately, both cases should be repairable.
>>>>> But that should only be done after you have checked your memory.
>>>>> You won't want to have unreliable memory which can definitely cause m=
ore
>>>>> damage during repair.
>>>>>  =20
>>>>> But it's still better to keep important data backed up.
>>>>  =20
>>>> Yes, definitely a bitflip, f =3D 0x66 and v =3D 0x76.
>>>>  =20
>>>>>> ERROR: errors found in fs roots
>>>>>> found 6870080626688 bytes used, error(s) found
>>>>>> total csum bytes: 6668958308
>>>>>> total tree bytes: 9075539968
>>>>>> total fs tree bytes: 1478344704
>>>>>> total extent tree bytes: 243793920
>>>>>> btree space waste bytes: 820626944
>>>>>> file data blocks allocated: 326941710356480
>>>>>>     referenced 6854941941760
>>>>>>  =20
>>>>>> They suggested that I run a non-ro check, but warned that it could d=
o
>>>>>> more harm than good, hence this email seeking advice. Has check any
>>>>>> chance to fix the issue?
>>>>>>  =20
>>>>>> I think I should also mention that I'm fine deleting those specific
>>>>>> files as I can get them back somewhat easily.
>>>>>>  =20
>>>>>> To finish off, here is the information requested by the wiki page:
>>>>>>  =20
>>>>>> $ uname -a
>>>>>> Linux gimli 5.10.70-3ware #1 SMP Wed Dec 15 03:46:13 CET 2021
>>>>>> x86_64 GNU/Linux
>>>>>  =20
>>>>> One thing to mention is, if you're running kernel newer than v5.11, t=
he
>>>>> last corruption (the one on name hash mismatch) can be detected early=
,
>>>>> without writing the corrupted data back to disk.
>>>>>  =20
>>>>> Thus it's recommended to use newer kernel.
>>>>  =20
>>>> Amazing advice. I'll definitely upgrade the kernel, likely latest.
>>>>  =20
>>>>> Thanks,
>>>>> Qu
>>>>  =20
>>>> Thank you very much to you! I just started a full memtest on the
>>>> machine. I expect it to be good, since the RAM is brand new (just
>>>> swapped the whole system due to the previous motherboard dying), but y=
ou
>>>> never know. I'll get back to you with the results!
>>>>  =20
>>>> Also, if I can get my hands on a DDR3 system, I'll test the old ram to
>>>> be sure. If this ends up being a RAM issue, I'll send back the current
>>>> one and buy some ECC memory.
>>>>  =20
>>>> Thanks,
>>>> Alexis
>>>>  =20
>>>>>> $ btrfs fi show
>>>>>> Label: none  uuid: 381bd0ef-20cb-4517-b825-d45630a6ca0a
>>>>>> 	Total devices 1 FS bytes used 65.49GiB
>>>>>> 	devid    1 size 111.79GiB used 111.79GiB path /dev/sdk1
>>>>>>  =20
>>>>>> Label: 'storage'  uuid: e944a837-f89b-48ea-80fd-40b2bec8f21b
>>>>>> 	Total devices 5 FS bytes used 6.25TiB
>>>>>> 	devid    1 size 2.73TiB used 2.50TiB path /dev/sdd
>>>>>> 	devid    2 size 2.73TiB used 2.50TiB path /dev/sdc
>>>>>> 	devid    4 size 931.51GiB used 702.00GiB path /dev/sdf
>>>>>> 	devid    6 size 3.64TiB used 3.41TiB path /dev/sdg
>>>>>> 	devid    7 size 3.64TiB used 3.41TiB path /dev/sdh
>>>>>>  =20
>>>>>> $ btrfs fi df /media/storage
>>>>>> Data, RAID1: total=3D6.25TiB, used=3D6.24TiB
>>>>>> System, RAID1: total=3D32.00MiB, used=3D944.00KiB
>>>>>> Metadata, RAID1: total=3D10.00GiB, used=3D8.45GiB
>>>>>> GlobalReserve, single: total=3D512.00MiB, used=3D0.00B
>>>>>> $ btrfs --version
>>>>>> btrfs-progs v5.10.1
>>>>>>  =20
>>>>>> The dmesg is attached to the email, but most of the `BTRFS
>>>>>> critical` log
>>>>>> lines related to name corruption have been removed to get the file
>>>>>> to 200KB.
>>>>>>  =20
>>>>>> Some things to note:
>>>>>> - I recently upgraded the machine from Debian 9 to 11, getting the
>>>>>> kernel from 4.9 to 5.10, but the issue already existed on 4.9 (it ev=
en
>>>>>> started there, prompting me to replace a drive as I though it to
>>>>>> be the
>>>>>> source of the corruption).
>>>>>> - The kernel is almost the vanilla debian bullseye kernel, with an a=
dded
>>>>>> (tiny) patch to fix an issue between 3Ware RAID cards and AMD Ryzen
>>>>>> CPUs. It should not affect the BTRFS subsystem as it adds a quirk
>>>>>> to the
>>>>>> PCIe subsystem.
>>>>>> - I have a few name mismatches, which can be seen in the logs too. W=
hile
>>>>>> I'd love someday to get rid of them, I simply moved the affected fil=
es
>>>>>> in a corner for now. That's not the issue I'm trying to solve now
>>>>>> (though if someone can help, I'd be glad). They come from a ZIP arch=
ive,
>>>>>> so deleting them is fine, but I can't as I only get "Input/Output er=
ror"
>>>>>> when trying to rm them.
>>>>>>  =20
>>>>>> Thank you very much to whoever can help!
>>>>>  =20
>>
>=20

