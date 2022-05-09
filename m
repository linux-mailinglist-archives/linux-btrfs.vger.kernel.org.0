Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C3751F29F
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 May 2022 04:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiEICWe (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 8 May 2022 22:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbiEICWB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 8 May 2022 22:22:01 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99CE583A5
        for <linux-btrfs@vger.kernel.org>; Sun,  8 May 2022 19:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1652062685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uf5gInuvv5bHbt9YhGcumMEJep7NHGn7TSsaUPHZP4s=;
        b=QnuFNfKiX9mMlCtHA0869wUAwrcduJepIA8JhjWBxMWLQt/VPnpgss+j0BekTUpnUIZHGM
        sBtgo0/IYOoZIUUWR0m28sjaOl3T0KuGk+I8WAAWz71O7/2dBB/a7P+TMtmpuGpQx+y2o5
        sIxE6Kn7zoF7kTWK1Ih3VkTEok5Xpuc=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2054.outbound.protection.outlook.com [104.47.12.54]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-15-uljJEDrnOSOLqS5WOQe7wQ-1; Mon, 09 May 2022 04:18:04 +0200
X-MC-Unique: uljJEDrnOSOLqS5WOQe7wQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+njaT8kjXFaXZYnbhn7mYK8gKw8qiWhvHcuHEw/nPEVs7318uwHwLU7X5pRQBvHqW9EpbINGOua7ltgiz28MSBN78aEGveh8Q/O3f3Ar6aLtggjB9KouGtQ6ub9TiV7yqMNUAEe6am+GidmW+/rQB66FzoACvqor9yFLrc/lLgIEukFvojriJyxAn+H+SPjmlq/gyTCf/7hQ9hewBOMVUP+PRttv1L3qdDC5QTxGatrGr0NQZrlwZhc3Z3ACa6K/9umc5y6BdFxXj0mryV49hjDdgclg0Wz8+iiZVpsLvHwyRjNBqKURb++VFGMITVB55TF705mKFnvmdHNTOKzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1wSaB2lHFhNxOymhxTmTQSdapqyvhE4Gl+t1cg7AWU=;
 b=CkcklFlU5HYL/4XjxLUWFPij054/acYWxUQtV8cKl4Zqmhn7baN6yExyXA4vdOHVM4pRwmz3dnbZRr8f1wmIJPe1FLW5VPcp3iJdG3+lINX2M+xdV13LwyXevWOVknvbDLSu6sPGi4JOW14GsmNs6KrPKUqwiI9nDROTle10X9ZdPVrk9D1tybXi2QJLviF4lmtSqvP6WMBn8A7jKbFOYStab5b4IX6mDQi+0FUkv452jLpiJ4Fz/M/XBxvdY6mnlXurIxyEFd4FAn/G6fqR2AhQyMjlgQYnnWNKpjCodj7zFz5NU5A74pRTCaGBn9kzoVo1E8dA0SwgnVzuJsI9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DB7PR04MB5193.eurprd04.prod.outlook.com (2603:10a6:10:15::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Mon, 9 May
 2022 02:18:03 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::917f:6f1:b888:b74f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::917f:6f1:b888:b74f%8]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 02:18:03 +0000
Message-ID: <a9cc3342-9658-5f5c-c26b-80a3c7bc9ee8@suse.com>
Date:   Mon, 9 May 2022 10:17:55 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] btrfs: allow defrag to convert inline extents to regular
 extents
Content-Language: en-US
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <c26d8d377147d3a80e352ee31e432591c28e3f4b.1651905487.git.wqu@suse.com>
 <981a54b2-884e-0426-22e7-f8a332d7b331@oracle.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <981a54b2-884e-0426-22e7-f8a332d7b331@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01b6cb63-e3f5-4820-027b-08da31622565
X-MS-TrafficTypeDiagnostic: DB7PR04MB5193:EE_
X-Microsoft-Antispam-PRVS: <DB7PR04MB5193C2387021FA47A7B7A480D6C69@DB7PR04MB5193.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2UP0GvmCVBSeNhw3brUI0UCQ9K2iQHLeU3TvNvuF+22QqXa37/aE0viZupdsAksK9RiaZrxZ9XIUmMKLRrd1CdAd5Usf7Ld7qBLnaYikMGZRQz/UYKRAQRFZ9MokxHKbZlioem7UHIGomnJ0qmW5DXCBe/TWWAAJ/lHVa8YtehbrzU8mEHW1qTRI8QQRjzJFc78UP8AzbTEnhgfFTHTdju2D4ROIhAS3qCSFgCuxGs5g6nVq6Bd1GaJNSAKIAHkleJVn1TIXBj/k2sH4PwrkWhLcklsBrL7vPGAl9vs1BUIsTF7wIj+PfCCY01aPhUwIJsn1u/bj41OPQy4Nkr6I5Gy/LB0kUHape7qQ0bWVRdyyf+L+gz+IkHLgXBT5MT1xiokrotQ/Aq829U3RtOO3qDsHZ3rc2z0yrYfzAgwyll+8BaktLoXPiU2oXEd0ZfYi/PR9Qqwpz3+O3/9AnSnD/XNDRvr1z30wmdQP0TOYaDspgccUzzibHl2AapnW/P4rqx4uuPmSyVCFbVgBwT7M8HrsoOSgWqaiLaSEgoiRjsXTh9Bc5WqXirFZVsCUvvpMzFUingnls4xXGF+tSbBF+5L+fXQjvgZZrCFvbgKVuFoVpd8bpyUmAeyBjMMkGvFZcXTNVczUKJdpiESicfqRcNywwnZnAca+wyE69GJahszkb7nQN6zbdIAECJcpy1h6+hg0Bsr24wu8sAldqu52gxcBbiaVwRquUbqktNJdP9E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(2616005)(5660300002)(186003)(83380400001)(2906002)(66946007)(316002)(66476007)(66556008)(8676002)(31686004)(36756003)(8936002)(508600001)(6486002)(26005)(6512007)(6506007)(53546011)(6666004)(86362001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+R1RDg6WjQxPrQjYmv4xNtETzkH1fKg95GhmEtyvD9AXqeKkJLW2tLt58TDr?=
 =?us-ascii?Q?rfEIN4CguZmUgM+LyWx9Zo5r5IWgMZ4hhs/mje0m/ANvkQ47SotvhYJlZShs?=
 =?us-ascii?Q?tJ+lQydrvNDci/bzyT5Md0+f1Zx6lDZbYf5aHm1PTvp52uvKKL37NG/3tFvN?=
 =?us-ascii?Q?A/OwxVqRyjrRNsHKe+moMyLlSl6HLtfe7U51JfwahrFHQcK4c/60WFJBH92v?=
 =?us-ascii?Q?zD470JsgwNdLebnmZkNMTR4oinqSR78djL4ln9cWZR5o2+3nYoJGjZ2/6afA?=
 =?us-ascii?Q?lHqYpBfv7lKxkw08tZPd44nws23ShOCuyasbfVSRIRnYpdeccRLyMCDeEU5z?=
 =?us-ascii?Q?uc4ZtB/n7Vt1RNMBTL3UjdnyamxQ09xeT0KqPZZghlItkEGBfa6J1ntpf9PC?=
 =?us-ascii?Q?JHm4FykgRDUNrOy1ZhyCgBPUIxnV4fr0s+OX679l1k04VSSVzdRDxMjUqoCL?=
 =?us-ascii?Q?5N5LVjFBP5uLkZeYpQ3kR5Q/5Q+KQrx8UiQ5A6dW6GRmLWUQqn+WMl2mqohF?=
 =?us-ascii?Q?yHzyOnX++sv6Y1o3Y40Xu6mvBx4cdZLboqRNnZjL5hlAeXdF6juxmYDCwcmC?=
 =?us-ascii?Q?/5ZwFNmmTkFi6jbN3xYyhwU/HA+ZrBckh5XoD7VSVcGtTU0LHb6fO+/fCRXc?=
 =?us-ascii?Q?c6Fn40+/92kKgZsUHnkH0/P198Pq4P1OgDwqyNNPZKuaWK2MDzEnQntgBcfl?=
 =?us-ascii?Q?gMACMEbgECiswpj9cH3CfYhy7gyVVry7NcbVzc62RarGjWtDVC/9RQ88lFNJ?=
 =?us-ascii?Q?s2ftNWvbdkk6mTOOBYh8Y5f3d8ds+NaxmNCzlW16lXKv0eODvZdG7y3TdNcA?=
 =?us-ascii?Q?mbUI8Su6b+r4Zu/DSZkqyw0HtLCaU4J0sZ4wMWydp4bPrwhnh9/N+YWbp8s4?=
 =?us-ascii?Q?Oa6sj7ebcNwGFlhDrfeji5fgPyCLT1Y9RCQGkXAWL9iPG+wzNQKjVnF37EGH?=
 =?us-ascii?Q?h6uOoIovy33dLnfwpaRaSRN0ThvoAvI2R5ouLkm6yynRHQxUQy2bPc1dNGAV?=
 =?us-ascii?Q?RSZyKnkGJrUkXu6vSX/19bFM1bsCxIuq+pUEQZKYMAT4l3C0VNefcVIUIyte?=
 =?us-ascii?Q?9GCqVX2Wh0cyfVQopaHymInjXECoGpMdcRuIuR7KA87xYqg2S9q/HTPW1PG4?=
 =?us-ascii?Q?W6s6PKYVSyxcikIuyvzjmMhW4tGPkRpgho0rzMDG7Xrhs0YO7Dy1SY0H33Zi?=
 =?us-ascii?Q?yBNAmaJG1HPReoC5J+CXzldTvgMN/Ms1C2voQY0Yb90+eWVa5pAyq8jyoknX?=
 =?us-ascii?Q?eUFAP1D0XEyTqckzzYm6VMaypl1CNqxMOHBgdERQiZrrROdri3yvS1h+RLqF?=
 =?us-ascii?Q?WJXVBaZ2vPxdruuqUvT2dZVTm0/66wDfFB6BLAGHdzQ+Y7MuFC+ICIleDIkf?=
 =?us-ascii?Q?BBxkgAoIh56SntHdL0leLsxnJaNcIyyQyM2ancQtPvuEs3wbbvPGAplDmHDm?=
 =?us-ascii?Q?XOgs1jbH5wM/3tTRTPyH3aWr5zGYRni87WHucn4O8sdC2/AZ7bbne3VUjzK4?=
 =?us-ascii?Q?TBUHmNDWhAtzqqRAm3+gFKi5btC6H9aXPq0/FwGYjgcYwPUwUlPQ8oCS+7Zr?=
 =?us-ascii?Q?kmSq3FvJBxpY/IjGEWsjw3EAE1p1l3mduZ343SLJ019YQcDduTH/N89sF06H?=
 =?us-ascii?Q?jCsWdpOti7gCmToIjy+yIS/M84wHiYGFmHIxGvIx3j+m9c0Av7dUJw1fNtcR?=
 =?us-ascii?Q?gfbpFxGqgohoM+BolWi4X/nDWGkJG7GKQ9dMtBA5pqsM2J/U?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b6cb63-e3f5-4820-027b-08da31622565
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 02:18:03.1684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tb1STQFwhJ1ycRes/mIaNVc3B6qaDrXbM1qP02voS6nkmNuh9foJRUG/JHpIXzgK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5193
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/5/9 10:15, Anand Jain wrote:
> On 5/7/22 12:09, Qu Wenruo wrote:
>> Btrfs defaults to max_inline=3D2K to make small writes inlined into
>> metadata.
>>
>> The default value is always a win, as even DUP/RAID1/RAID10 doubles the
>> metadata usage, it should still cause less physical space used compared
>> to a 4K regular extents.
>>
>> But since the introduce of RAID1C3 and RAID1C4 it's no longer the case,
>> users may find inlined extents causing too much space wasted, and want
>> to convert those inlined extents back to regular extents.
>>
>> Unfortunately defrag will unconditionally skip all inline extents, no
>> matter if the user is trying to converting them back to regular extents.
>>
>> So this patch will add a small exception for defrag_collect_targets() to
>> allow defragging inline extents, if and only if the inlined extents are
>> larger than max_inline, allowing users to convert them to regular ones.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/ioctl.c | 24 ++++++++++++++++++++++--
>> =C2=A0 1 file changed, 22 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 9d8e46815ee4..852c49565ab2 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -1420,8 +1420,19 @@ static int defrag_collect_targets(struct=20
>> btrfs_inode *inode,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!em)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 break;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip hole/inline/prealloc=
ated extents */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (em->block_start >=3D EXT=
ENT_MAP_LAST_BYTE ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the file extent i=
s an inlined one, we may still want to
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * defrag it (fallthrou=
gh) if it will cause a regular extent.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * This is for users wh=
o want to convert inline extents to
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * regular ones through=
 max_inline=3D mount option.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (em->block_start =3D=3D E=
XTENT_MAP_INLINE &&
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 em->=
len <=3D inode->root->fs_info->max_inline)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 next;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Skip hole/delalloc/preall=
ocated extents */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (em->block_start =3D=3D E=
XTENT_MAP_HOLE ||
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 em->=
block_start =3D=3D EXTENT_MAP_DELALLOC ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 test_bit(EXTENT_FLAG_PREALLOC, &em->flags))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto next;
>> @@ -1480,6 +1491,15 @@ static int defrag_collect_targets(struct=20
>> btrfs_inode *inode,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (em->len >=3D =
get_extent_max_capacity(em))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto next;
>=20
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For inline extent it=
 should be the first extent and it
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * should not have a ne=
xt extent.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * If the inlined exten=
t passed all above checks, just add it
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * for defrag, and be c=
onverted to regular extents.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (em->block_start =3D=3D E=
XTENT_MAP_INLINE)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 add;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_mergeable =
=3D defrag_check_next_extent(&inode->vfs_inode,=20
>> em,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 extent_thresh, newer_than, locked);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!next_mergeab=
le) {
> Why not also let the inline extent have the next_mergeable checked?
> So the new regular extent will defrag. No?

You definitely forget the fact that inline extent should NOT have=20
regular extents following it.

>=20
> -Anand
>=20

