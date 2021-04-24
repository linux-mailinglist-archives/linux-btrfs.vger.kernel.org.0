Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B417369DCC
	for <lists+linux-btrfs@lfdr.de>; Sat, 24 Apr 2021 02:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244157AbhDXA0g (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 23 Apr 2021 20:26:36 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:40405 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232614AbhDXA0f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 23 Apr 2021 20:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1619223957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=90t6pr+stp26rKCho5slrd8B7lhbmdCwQ5sgNbbdCbY=;
        b=Lgc60fKXlOFHPEU3qOHR2mARU90Ur5UJKWEgn56N3bx4xPAwZsJtQ9SDeO9bSWGLZyuDPR
        EhtSnz4bA9757/bew0UGeyYnD4fokiYv5I2TMGcHE+skt2VBjo5ohZx5shZb27qZ+Nyncx
        QLolxvN4VjPzTBos23dH4Rs2udBptUc=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2059.outbound.protection.outlook.com [104.47.5.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-19-O-1dgg19OqyC1cb4jUUXzw-1; Sat, 24 Apr 2021 02:25:55 +0200
X-MC-Unique: O-1dgg19OqyC1cb4jUUXzw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ7Gk9jVQNcBSfmhSR4xxVXtaLPegbCe/tuIGjZjpqq2e1tBDwmxoobbeSBJJepjLsGZlr/1JSt52GUUYgjxw2gUFjjxEotYYh8w9y0KfZMXfUWc4qR3vPQxnMMrND9IyTFqHxn5pPdRinnAUMlyHsOzQkDNKpE759lDGCnBlI4iUPLSeAgCIWID2tkSuEnYD1r6Z1i9aQcfbfDzaVaY/TmQnN8Wngl0HRMm6AEYKGCZxtg/02ypCyCbtl4Xmi+qR32DeusY6UHc25ALi4pqFPx1Gf3IzCjKEK2nldYpK+d4h0Lv2CRuhz3i1/HEXoyVBkWREerOtzH0aZv0JWmkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7jv8EksB4ZHpA8q/O6AK0Uw8eNHx6eV+lfqQnDfqGU=;
 b=nsh3Y8dZRKG8mhkgk+k48WkjpzldH0IBLAat+X0I/58uanVJ/b4y46FgussKURxsMzfA3O/sPE8edxc8R8eoGCvLVg2ApcoULdNkXT6jAiEQk5G4GOfmJBYbCNgy76vZypuKukKUusgZl/nLHOhnQWxyN8lu/LsjlD7E3e1GqN3QyvTJT8SDo2uWyxkrzyNql2spz4zOfSs68mer7U2GBB8jqYUQUG8KD5OqOxo+t/1qaUNsqgwk3cjbWgY7KjGBUIpp1pZBFJEG7D49/S77GuW+aej3aK3t4RY7IJlRjuCz5+FYirRETOF4PiWmOYLBbg4W/xhNOy3qhLPPXUwVZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: fandingo.org; dkim=none (message not signed)
 header.d=none;fandingo.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0401MB2564.eurprd04.prod.outlook.com (2603:10a6:203:38::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Sat, 24 Apr
 2021 00:25:54 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::85d1:2535:1b6e:71d7%6]) with mapi id 15.20.4065.021; Sat, 24 Apr 2021
 00:25:53 +0000
Subject: Re: Access Beyond End of Device & Input/Output Errors
To:     chainofflowers <chainofflowers@neuromante.net>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, Forza <forza@tnonline.net>,
        linux-btrfs@vger.kernel.org, Justin.Brown@fandingo.org
References: <5975832.dRgAyDc8OP@luna>
 <09596ccd-56b4-d55e-ad06-26d5c84b9ab6@gmx.com>
 <83f3d990-dc07-8070-aa07-303a6b8507be@neuromante.net>
 <5494566e-ff98-9aa9-efa3-95db37509b88@neuromante.net>
 <3a374bca-2c0b-7c95-d471-3d88fc805b57@gmx.com>
 <7a02dd5a-f7c0-69b0-0f07-92590e1cd65f@neuromante.net>
 <e179094e-8926-beee-92b7-0885f1665f89@tnonline.net>
 <76971f62-d050-fac2-1694-71d3115e1bf7@neuromante.net>
 <704ad3ea-f795-93c1-3487-c644ea5456d9@gmx.com>
 <dea68577-4f60-afd2-753b-1fec3c13494d@neuromante.net>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <e229a858-79c2-0416-6ab8-14b56177b21d@suse.com>
Date:   Sat, 24 Apr 2021 08:25:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <dea68577-4f60-afd2-753b-1fec3c13494d@neuromante.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR05CA0174.namprd05.prod.outlook.com
 (2603:10b6:a03:339::29) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR05CA0174.namprd05.prod.outlook.com (2603:10b6:a03:339::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.16 via Frontend Transport; Sat, 24 Apr 2021 00:25:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f032a6d-6b94-401f-dfa7-08d906b7856e
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2564:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB256447592C302B4C01942C78D6449@AM5PR0401MB2564.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ls25ksp3UIpkjXo4xAmYzR3HqZgvBdu/07Rur4WB4GuyJZprjQRhfOoOtkDbWB3GJasNGx+raM7J5ycaNpbcSBnNZyK6CxoVwfGxa4RTlIeHV8UbQud30npPscPBeeTjKiO8j7JZjBZhbxbZko/Kl8J/+M2QtMHs0/uwiyJ3fTokDWWDqI/gBmt+7lyUksDGy2D/L77pubrLM9s1Esw5RIoxdOppp9Vj6lXqLQrQlXntdM9Yn5EQPPD2LwM7zPNDv/lomAKL/0Xs7OD2Coe4y7yZRVq8CZqtMWiquF9p6OboaP+YnGOK0fHuMiXPlGVVQbpBQ+WGdCIx7ZXhBggtkywo0vK10vZU+pyTYUyjUlmpdrtmc9uR2pgemkkWdf8aVoJ5po/rp2Np+rFMmdXwqo7cy+jmQCDPIRtTTh1aiK8dJk2JVYrReeunkLoczrBcT88RMa3IBuNunkFquJ4QN2Zex2+lx+fogIYpXf9997/B0JYsUSYYL9sG3jZQyc3Eo37WlG46Nc5f0I8nNlkNP3myIbjupPceM8hq7Dvu7vF8ntdTujREw0eBYcfzEWwVvlVq0Fyq0oYmUAwU0+YU1pyDnQOEQRtB2v0eI4q4kBJCwoQJPPxgY47I9m6aQPhIpyeQMHceii6lJbkavGhD185qd299nVyQ3o+DPD72VwtfXsAcKfzE3ucw5v/pOi90NbyVy/lN++ywQjvR3y8QR3vYomMaYuN8whiuv9X3EW5E1wWtmJNyHRX9IglCkhMIJH0YK875SlRwBVd8VAraN+KZxLddOgkyUZoWIYb4Vq2dugYHIJDWptuFeJvmhzof
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(39850400004)(366004)(31686004)(316002)(8676002)(6706004)(8936002)(6486002)(83380400001)(38100700002)(26005)(16526019)(36756003)(53546011)(956004)(2616005)(66556008)(66946007)(86362001)(6666004)(31696002)(478600001)(966005)(2906002)(5660300002)(66476007)(186003)(52116002)(110136005)(38350700002)(16576012)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?EtcUSulO6uJrLLsEhtbjPdc4BU8BNE0oGgCfwVMk2STfeyAKN45GS/LBOnr1?=
 =?us-ascii?Q?VqItE90qvkE49GDhsFNd/9G2MgQWsR+B0WQbZabjxwZXyW83574OCHzEmPDt?=
 =?us-ascii?Q?lp5ryFByRSrs34lDRR/pTOzO0+RZBuocTOZLH5TfGs1jdyXZqaEkpbnWDxcw?=
 =?us-ascii?Q?NmWl0Vb+O3Yi7MSoRGcZYh/p8cE9xGf34epnKausOnEd5fLRPo2cyL3VwibJ?=
 =?us-ascii?Q?ZoszO0cYkRJFmDn5jniyb1T2piv+nOF4uoUYO3A6EzRxI5oRA9geKCFxQwiW?=
 =?us-ascii?Q?NKZ0MwrQHlDUjoylQ4eXeUqahH08O2rqcVjranOA5b/Wyax5G5BwSjd8j+dA?=
 =?us-ascii?Q?EidaT1Ov38XgzuOiWsKyoOM5x2GO8tbgWz/JxJU2z4XJtMVrETT8wc9q+6oc?=
 =?us-ascii?Q?dZxTGWJVYj5+E4fMEmWBvEGuAax1IdcQ30Tt/6jKxfNW08y8cx1NE8FuUZhe?=
 =?us-ascii?Q?H0vcu1Uih8mD42LNaf3mBHdwECpBG6YMiVD7GOWVi/kUE4kU1MqVUWCRvxIv?=
 =?us-ascii?Q?aJ4SWNejfsot3E6ER8t6Sy3m5bwsrBewx34UhGAJOX1+O3imwJ6ShYJE7RsT?=
 =?us-ascii?Q?l8FPtm+01d7UjxdL3ggB8/tNKHwuSEfAnj04MBZOVfcOuZysbk3yl2fTsl8L?=
 =?us-ascii?Q?ZunOXdaFD81r7mzzSE207uNGtYNS3aw66ZqAaMRCPR9RXYIs55Hp588yZXsl?=
 =?us-ascii?Q?PBwjtxFyi5WAzHfvV8Mj4hLZ+x98ngp8nEk587ka1AHYC4JW+Ke4Yt95PIKb?=
 =?us-ascii?Q?nzN+z1iT38jYA48OEpDsORkDm1X/SWONkjNA2cV+WSVg0SASEWHe2tUri8JD?=
 =?us-ascii?Q?i9rkA79v5rHO05hW14R+tUoYrmzbgznHo2RRXhJCzgweExaLhQoiXvkzD9hM?=
 =?us-ascii?Q?0Anw/e9WYuZJQEOqm/cJgttAgh6JOfLGfVYDhmmBxQTW14qFhEVQ5iop2LYp?=
 =?us-ascii?Q?b3blf9ZDS2NSCKtWkHfkQiAhyx48WhJS+dFZwIWiB5Jns5AzvnCJIK+VUJGS?=
 =?us-ascii?Q?0OKS9oNiIafTJ6U2htFzVNyhE3m8eFOcLCWMLKPAwFMr1uDhD3uZdzZqIy4g?=
 =?us-ascii?Q?E2UilNXbDRvdGjv1XpbYsrz5d0O5KC8xGfQUhe5RmWIT62iYzuvSvYgzldCy?=
 =?us-ascii?Q?7sUyC77EKCxj/qFmVKFFgYIPVJ4UNRZHM101Ixk4ahlRtjNtBB15iAXck80B?=
 =?us-ascii?Q?jBC+xB0IGF9x450tefaa007yYmrGxTLJlp27BwNt+WHWfS93JC9bEgHUwRLc?=
 =?us-ascii?Q?1FIQWMbGXDLEMfiHbXE/x79IYJmGQ1B9qWnuhD3FV/NyF8EQv2zBErDajUJ6?=
 =?us-ascii?Q?oM6J6OsDE4zBiSMj+7lC800K?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f032a6d-6b94-401f-dfa7-08d906b7856e
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2021 00:25:53.8557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiqzF4LlLswT2tVuqIks3t6Fk+oCcOdZNgPLEcp8Y3z8RwYl+konECXCvp1hAvgL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2564
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2021/4/24 =E4=B8=8A=E5=8D=887:36, chainofflowers wrote:
> Hi Qu!
>=20
> So far, I am not experiencing the access-beyond-end-of-device issue
> anymore since some weeks.
>=20
> The new thing I did was:
> 1. Booted from an external disk
> 2. Ran:
>         btrfs check --clear-space-cache v1
>         btrfs check --clear-ino-cache
>     on all my volumes.
>=20
> I had somehow missed this (from man btrfs-check):
>> --clear-space-cache v1|v2
>>      completely wipe all free space cache of given type
>>
>>      For free space cache v1, the clear_cache kernel mount option only
>>      rebuilds the free space cache for block groups that are modified
>>      while the filesystem is mounted with that option. Thus, using this
>>      option with v1 makes it possible to actually clear the entire free
>>      space cache.
>=20
> I think, in all of this I had missed that I needed to "clear-space-cache
> v1" on the non-mounted volume, as I have always done it while the volume
> was mounted.

That's interesting, this means we're lacking sanity check against free=20
space cache.

But if that's the case, btrfs-check should be able to report such=20
problem from the very beginning.

Anyway, it's great to know the problem no longer bothers you.

Thanks,
Qu
>=20
> Maybe this info could help Justin too.
>=20
>=20
> BTW: Could "--clear-ino-cache" have also made any difference? Or was it
> just about cleaning unused left-overs?
>=20
>=20
> Thanks a lot for your help, Qu! :-)
>=20
> Have a nice weekend,
>=20
> (c)
>=20
>=20
>=20
> On 20.02.21 13:13, Qu Wenruo wrote:
>>
>>
>> On 2021/2/20 =E4=B8=8B=E5=8D=888:07, chainofflowers wrote:
>>> On 20.02.21 12:46, Forza wrote:
>>>
>>>> Are you using fstrim by any chance? Could the problem be related to
>>>> https://patchwork.kernel.org/project/fstests/patch/20200730121735.5538=
9-1-wqu@suse.com/
>>>>
>>>
>>> Yes, that's what I mentioned in my first post.
>>> Actually, it all started with the bug with dm, but some similar
>>> behaviour persists even after that bug was fixed:
>>> https://lore.kernel.org/linux-btrfs/20190521190023.GA68070@glet/T/
>>>
>>> The only "maybe unusual" thing in my setup is that I use btrfs on the
>>> top of dmcrypt directly, without lvm in-between, but I am not the only
>>> one...
>>>
>>> @Qu:
>>> My RAM looks OK so far, I also thought of that, and I actually ran
>>> memtest for 12+ hours and more than once. I would exclude that case.
>>>
>>> I will do a "btrfs check --check-data-csum" and let you know.
>>>
>>> In the meantime, I thought of a related question:
>>> -> When a data-csum is corrupted (for whatever reason), is there a
>>> chance that the corruption persists when I copy the whole file system
>>> over to a new one?
>>
>> You can rule out the possibility that some data checksum itself is
>> corrupted.
>> Data checksum is stored in btrfs trees, and all tree blocks have their
>> own checksum.
>>
>>>
>>> As I said previously, I copied the whole fs to new, virgin SSDs more
>>> than once with "rsync -avAHX", and I couldn't spot any issue related to
>>> the copy itself...
>>
>> Then you can rule out the checksum problem.
>>
>> Thanks,
>> Qu
>=20

