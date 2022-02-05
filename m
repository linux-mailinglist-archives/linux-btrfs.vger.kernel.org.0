Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FD74AA4EB
	for <lists+linux-btrfs@lfdr.de>; Sat,  5 Feb 2022 01:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378695AbiBEALw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Feb 2022 19:11:52 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:21643 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239054AbiBEALs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 4 Feb 2022 19:11:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1644019907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4mC232vHZA3R0A4QkQz1FbYRcqzYjccGxgmEVLqRsj8=;
        b=IoQz+5WOt2RPS80fhNNizAxrFRP1dipHX+cDTxp+Lkr+XiykiLKz1CpyTZClwQzmre/Atc
        NvYZsKdtfKYKbg7rHNl2A+w8Dz2gt+lwSyh+GIj4GqMtONzm4Nnx8Pm+mF/V2p1hSivEXV
        oDtRhwKbY0qhtjbWJ9bSPCPhcEdRWZQ=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2055.outbound.protection.outlook.com [104.47.14.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-32-jkvTKk3_MOWIKjFwHUv5Aw-1; Sat, 05 Feb 2022 01:11:46 +0100
X-MC-Unique: jkvTKk3_MOWIKjFwHUv5Aw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZtwgp6TcqMJ3zYXd3EgDjag3HpcOjnLthnzjG3MMKQ2X0GVJqAkrlzx40XFQhM5cqAuz+yim0DGLDq+U+T/1ieTdHB9F87pNhTNsIm+WYMvuCCFR1pEmyYMhjmLQMmEUMYk9h6IxIt+Mf6tScNssU9sDu2+HH6rMUsEsddmtfY5rkNpkZDf8fbNrTH4FBtG3tWHOvkvJq1jjD8KYZnG8E3mYRt1zDmOOyBx1y2D5BEMmIbINCVb+4mIU0og+nGD19x5gT1Mq3O+lUnkeUbp/beN2FbdTa4cFD0vn57JOQhs54xRrNiFT22tYJmPk6kzxGBTgRyYwWfV+hT+TFwwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BM8a9ZOvdeNdJX6hx1wIWafsaLjk3AY/ybomzLu2PwM=;
 b=kY/BE6lRmOHDb7/RS9wulrNW7czDwbFJtOzXu5GJ4OSUpZx5HIKnSw+x/4qJfn3/miapAXZ+SuisotpcWyRfk5964NQ73d8SzMwx7Ao/+4mVO4aeyEusAUG6p+H62hj7DQHBO3+EZfE/17ggEmSNJIMoCaBLbwsBbjlGB1FO6RY15jyhqDLcX74K/C28mk/lcg9LSpmr+fHveTP0LJbGo/6gdsAnNxtlwgEQmY1zqlm5u+TJTdAAYzF50NWPvAsY6HhrPFEAoJqaT4g5Mh6AsMclUf6Ch3lGFNVM+ubfglH6D7Co63AtHihFb3oEcFCEfm+2CrSOzEvsUkI9RLpqYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by PAXPR04MB8943.eurprd04.prod.outlook.com (2603:10a6:102:20e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Sat, 5 Feb
 2022 00:11:45 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::18db:1eae:719e:ef4e%7]) with mapi id 15.20.4951.012; Sat, 5 Feb 2022
 00:11:45 +0000
Message-ID: <a48e1e53-1c48-ae01-6646-f5d7872af8be@suse.com>
Date:   Sat, 5 Feb 2022 08:11:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: root 5 inode xy errors 200, dir isize wrong and root 5 inode xx
 errors 1, no inode item
Content-Language: en-US
To:     Hendrik Friedel <hendrik@friedels.name>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <em7a21a1a2-4ce2-46d5-aaf1-09e334b754d8@envy>
 <b29bcb81-883d-f024-d1a1-fe685e228d4b@gmx.com>
 <em596e7e6e-2b32-4c1e-b568-736fa23fd402@envy>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <em596e7e6e-2b32-4c1e-b568-736fa23fd402@envy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0044.namprd08.prod.outlook.com
 (2603:10b6:a03:117::21) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 613f1b45-72bc-41ce-bd85-08d9e83c1851
X-MS-TrafficTypeDiagnostic: PAXPR04MB8943:EE_
X-Microsoft-Antispam-PRVS: <PAXPR04MB894309D21136BD9A493E8ABAD62A9@PAXPR04MB8943.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qPCbPZ+WGjMB2j6k4gRfGvNj5sdxpX7ZQomEhibpKqMq50Wp9RTHfjPWo3nXq8hhID0fPacmMsKlPduowVLsBDQ/99A4FDCSobYfZLsS9fLbXwLMp8BNQkhAu+nL7OQ9F/y0NsJlw7Xwzz7Xt1s70wd2K3XAUyLQ00NDmv1gkLJzQcaCbMQiggSd0TZAc2pgXDTxCpZCaQwmenPXCESMNbMzQ35g+PJ0dCAxmtjRjPD/2v9hRSgcum4eAUBOVb+WTRQN7RnNNhLNzBaUESb4RLTRByfuuwkcWzCcqB7B/jzHhj3l7xOaPjLFAIqeWCln5oV8cVnTslZmflmM3N7/jiEBknJa+hqj3fabn082KhxobgSy0upQKLQfnd1UC/OOghR8rStaT4jEVpgixDTekOpnzUkKqmxFvdGS065YjwsPCGZqveEdTcvQqipoDYP1dP67/lSNwBQ5ESEe+yuhEQDLpbJlYbEreQJtvmjTJUaJ6LMr4o/nqcb061QM9R6m6Gd12lZ5fMAnBoBu451gCfw4kg/wTd5e3563dH6UmFp86tj3MNym6XrIjraCx79gbRwalaf7exD6qZ2c5Mg6jSK5XPhtZZoKt1MBFVjaFCEynwq3ulEfQa24m+OqAWbESmfxeyaTbc9KACgiXRXCVFjiTCeRdgscb0qKgoTy/OL1JC36eKFSjWdNGzTztH+gTuK+tB+Qa3p+gz7nuJFUpq1LxLd078Y404Fp+ZkMOhxGl5dSzjLJF/bDgBGy+LKN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(508600001)(31696002)(38100700002)(31686004)(110136005)(316002)(6486002)(5660300002)(66946007)(8936002)(66476007)(66556008)(2906002)(8676002)(83380400001)(6512007)(53546011)(6666004)(186003)(6506007)(26005)(2616005)(36756003)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCJ2pj6qQA1DK59jJFz24f4J2YuH906fExpV5i8kW7jd4dwo0EtptFW3/qfG?=
 =?us-ascii?Q?n0r8weK5EbfU/fbWqqCp0UxYQPuFXueU08aRKP81UatPkMHVdhziSsD3FY0a?=
 =?us-ascii?Q?AphuQOA6+j74oiiKUHbwxFAbWKgHmu/PqChhNlupwPex727bD5vR8EJfAo4S?=
 =?us-ascii?Q?RkPb0lr44uhyYsh/te9RcjfJGUh1ssZFz2vskoqGH9+7CoO23MCulaHn/smF?=
 =?us-ascii?Q?u97XF1gwnrhvSjd3jzl7VM6rXqozHZhkkZkos1hMjyWYZ6V+Uf/Z0OXCfwbP?=
 =?us-ascii?Q?jd/F94rXmV8EqfvXiVYgO/JGS0WjCyAcmSmU8sn0pGBM9CNQZEhIFNiGjAHp?=
 =?us-ascii?Q?atOQswKEGdK934ZmPx18bn5F3ucAapcJPE3ZMOSMrTtJ1Ay0Y8rPCbm8KXHL?=
 =?us-ascii?Q?CyBs3MKg8syDqe8IseRCwCzJVfxhiQSAgSM37GoeP3PuRggJIKq+WVHcdReI?=
 =?us-ascii?Q?WfvlYYEQsS6Ffah9Rz9gAwmR/WkCHdQF/8mmje1GoKaG3H+F2PU/J5vuaj5X?=
 =?us-ascii?Q?5xCz860v6kGZSogTZiuSkyYgfqDq2eTaFf/JUx1Jt4znUvo/LHjy7k+IgUbr?=
 =?us-ascii?Q?x0OLRSCZe5U0BD9/kgZv7d/29CfuupDLMV8ju47QGoiE3Sm3lWx7jzb3nRNQ?=
 =?us-ascii?Q?kqffI2CR3/DO84s1ca3ZjyZolo4i9rOwJAxsv2OoNSVWhvPFDYYdylhfdfOD?=
 =?us-ascii?Q?UXh0TS7r/AWPBHBz0qNV924filAsuApLeTewPzsxGKdACgbdTFIAsPtShe9r?=
 =?us-ascii?Q?E3GT7pP9YaKIzZRohTUmFg+hegxkxtKZTUGT23/HpNWtrpVUHE1wqAHmTVdb?=
 =?us-ascii?Q?tMrDMzOVz4oGn+aBAha/Hw6A4uYt4LcYoD1pvnleQsU78kOisW4d8xDjZZGo?=
 =?us-ascii?Q?9KrI3BhwvrzNI17mA10k6TmBHlI/vvTnqYFjVnO2GBP3PDqW3Ai+GNKQycIe?=
 =?us-ascii?Q?xZUWCSlA4tuE+3wB4enYGWL33F9ffZU4Fn9JpAfQdHpC4lYz69OTuv3H4VsR?=
 =?us-ascii?Q?4/L4ZMI4ZfTC3qGvfVlLQC3+CJ5ET4qR71O8o8rxJDC9tjWA3xMftkFrRLrz?=
 =?us-ascii?Q?RuQi47QkPcJFIhUO/2fnFyeFjAsAa3mtGOMWRPB/qyoAoLqeef1ZmUZg1L3C?=
 =?us-ascii?Q?ix8Cc2HVqHHlEtM5fpgl6kJgHPQjS1oD434IW8K2wEYs/ys4UWKE4DbcS/BE?=
 =?us-ascii?Q?onPJlTZUFLGzeKL3aGkQ+ByFXxpAhWOp19fvj2iZurGiBhwfzMl1i4TbKmwK?=
 =?us-ascii?Q?zNaOzh0BLbyP5laHgovFiBfiH3GFez2+PUL4nGzK7jnylCOUIFVYUfg76mr/?=
 =?us-ascii?Q?41pvz3zKpP6+ge9kYrBxPoRuNVjHzMl7yYOfD+ZF3L0gDFKZNVCMdBKe32Gi?=
 =?us-ascii?Q?O2h2NR6gV2ZNGZo8o3eD2NRYTymkYesnLyexJxOWHiawZCxR891j78zEMn+4?=
 =?us-ascii?Q?5dszBIb5HAQiQ+Ft5OZQM+kb9j29mZriJhBFFcORfS/I85uEbNZtFOikp6zG?=
 =?us-ascii?Q?0O0j5Y2LqGNG6Q398aPeeT34xDoYGch+SBw5QL0LsXktllDjQmlqlhhorLYn?=
 =?us-ascii?Q?gSrZoX+DUPSdnCQ5ltQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 613f1b45-72bc-41ce-bd85-08d9e83c1851
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 00:11:45.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Cgdp5njaL64JPDdF1Uo2ISqe+l/FlA3mZtG5k3WYnH16uq0uc1cbLKIUri4JfuW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8943
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/2/5 01:20, Hendrik Friedel wrote:
> Hello again,
>=20
> I guess it is not normal, that it btrfs check is now running since=20
> hours... iotop is showing no disk read going on.

OK, new bugs in lowmem mode.

You can safely kill it, as it's really read-only.


For the errors reported, they can all be handled by --repair, but please=20
keep in mind that, those offending files may be deleted or moved to=20
'lost+found' directory in root 5.

Thanks,
Qu
>=20
> Best regards,
> Hendrik
>=20
> ------ Originalnachricht ------
> Von: "Qu Wenruo" <quwenruo.btrfs@gmx.com>
> An: "Hendrik Friedel" <hendrik@friedels.name>; linux-btrfs@vger.kernel.or=
g
> Gesendet: 04.02.2022 14:47:45
> Betreff: Re: root 5 inode xy errors 200, dir isize wrong and root 5=20
> inode xx errors 1, no inode item
>=20
>>
>>
>> On 2022/2/4 21:30, Hendrik Friedel wrote:
>>> Hello,
>>>
>>> I found some files for which ls -l gave me odd output (??????) instead
>>> of mtime etc.
>>
>> And have you checked your dmesg to see anything wrong?
>>
>> My guess is, tree-checker reports something wrong.
>>
>>>
>>> So I ran btrfs scrub without errors and then btrfs check with these=20
>>> errors:
>>> [1/7] checking root items
>>> [2/7] checking extents
>>> [3/7] checking free space cache
>>> [4/7] checking fs roots
>>> root 5 inode 79886 errors 200, dir isize wrong
>>
>> This is pretty easy to fix, --repair can handle.
>>
>> But I guess it's mostly due to the offending dir items.
>>
>>> root 5 inode 59544488 errors 1, no inode item
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 798=
86 index 199 namelen 11 name global.stat
>>
>> No inode item is a weird one, it means the inode 59544488 doesn't have
>> its inode item at all.
>>
>>
>>> filetype 1 errors 5, no dir item, no inode ref
>>> root 5 inode 59544493 errors 1, no inode item
>>
>> On the other hand, there are some other dir refs which doesn't have dir
>> item.
>>
>> From the inode numbers, it doesn't look like an obvious bitflip:
>>
>> 59544488 =3D 0x38c93a8
>> 59544493 =3D 0x38c93ad
>> 59544494 =3D 0x38c93ae
>> 59544495 =3D 0x38c93af
>>
>> And, mind to run "btrfs check --mode=3Dlowmem --readonly" to get a bette=
r
>> user readable output?
>>
>> Thanks,
>> Qu
>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 798=
86 index 200 namelen 10 name global.tmp
>>> filetype 1 errors 5, no dir item, no inode ref
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 798=
86 index 203 namelen 11 name global.stat
>>> filetype 1 errors 5, no dir item, no inode ref
>>> root 5 inode 59544494 errors 1, no inode item
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 798=
86 index 202 namelen 9 name db_0.stat
>>> filetype 1 errors 5, no dir item, no inode ref
>>> root 5 inode 59544495 errors 1, no inode item
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unresolved ref dir 798=
86 index 204 namelen 10 name global.tmp
>>> filetype 1 errors 5, no dir item, no inode ref
>>> ERROR: errors found in fs roots
>>> found 62813446144 bytes used, error(s) found
>>> total csum bytes: 43669376
>>> total tree bytes: 665501696
>>> total fs tree bytes: 329498624
>>> total extent tree bytes: 240975872
>>> btree space waste bytes: 119919077
>>> file data blocks allocated: 4766364479488
>>> =C2=A0 referenced 60131446784
>>>
>>> How do I fix these?
>>> I am runing linux 5.13.9 (about to update to 5.16.5).
>>>
>>> Best regards,
>>> Hendrik
>>>
>=20

