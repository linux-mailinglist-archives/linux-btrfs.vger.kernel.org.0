Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0233235AC
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 Feb 2021 03:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbhBXC2q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 Feb 2021 21:28:46 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:38432 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBXC2p (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 Feb 2021 21:28:45 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O2JfJM171531;
        Wed, 24 Feb 2021 02:27:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gBujZyx39KZPIzOgbRsdemPpUwcxANEyygJe3W4gi7w=;
 b=s3fi8WsArfwiTNwn5IR83QDrTR9GMi3YiMdAFVrD5cU5glW59hPiTR4r00hBB43px6cn
 933pK2YMzPmFQCNnPy4EBMeG1Lmk3aCV3aOu8OD+y9GuTYIsg5gLZddLKPl2D/N7c2NM
 Z2UTUZ2ixn0iPgRtRPYX7lsp0SdVSk7z5EVH040bAJkhSZjXj3Jsegj+NTscnBrOU7mV
 eQWUj5ocV8ibK3r21mkZpF7+T8GU7/SSX0bENzKQo+fe55tAPfeMo5YypDRzIk2Vtt9e
 iW/QR4UZbWMecyV5A/vfts84ZGPKyA9HntQMlXqvz0/BUCsfQpJfbKlbiGCdDf9J8IsM 4w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36tsur1f0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 02:27:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11O2QUBw123011;
        Wed, 24 Feb 2021 02:27:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by userp3030.oracle.com with ESMTP id 36ucby95gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 02:27:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtNwa5+EhBWB8i+5aUMZoc+LdN5zvdIFO3ErbYARnFTlUk9Zg8g6GYRU5BIcYZ532awZi5nSTWNIpO2UVXE58n5eHhqNYa+2K+JW2b7xHwcP5xV3wi4cjVgNOel4ykPGMMedVewdVQqD2892AUcFwmZrF70ugA9fGnmkrtrc3aTmdZ3WirMXJirVVAwN15IYzOanBmNNAIYw10y6XpfsDzC1JVo6mq+6pq+w8OsJkMSh1x89IMQYGRlyqU25TE7YFRbWHVCYivUf7FigQMc+wi64FrG5eaFCWERf1pPJ1ov+lVlnwhl/aem0/g2qxak37MLrKdfmIZS4K5ULHoH3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBujZyx39KZPIzOgbRsdemPpUwcxANEyygJe3W4gi7w=;
 b=M0U1aDlyj/S6ZoDayWhaUzTur9jNrr2lEe966C5DzLK4USHpHR83e0Ahbto+qK4LPxiz7DRJIpWKd5T2gUzRLvqa92uGbg1RByaAtfrTKMUnOPUf3NXAGoKDhx9uGV8AVhfJu3oSkYg1aOY1/ea0nOg25tNtI982RdBSThcitOWsLfM7uI26ek5pwL/B7WnrV7UjPp7N5Og+zJ3N62AYLE3Re1yHFvl2sBkWQbhWG9GBFwlWtR0QAl09H8Ig9yWtZRbhOU8c31gRvOQUh+Bv9AhVJvPJNlAUl2hzCjXW7o8St8aUse6ga9+NOPodL2c9aQ8V9DK99l894T6/UYEdzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBujZyx39KZPIzOgbRsdemPpUwcxANEyygJe3W4gi7w=;
 b=F/VsUxNIOjl7WsCMTG1rn7fUMPq6/5FJSeNICHrmpUVtZW83Nh4tP+8kXB3ZRgz/+CVGsaihUMzJ2ySTsJpa1T9/9s9860N9SgFxNCm2G/SAmnzjkwVf1EiacWhfcWltPsIbE8Dmw6pI910maawdRHYlUj2jJBEw0v7NIqEJcaE=
Authentication-Results: inwind.it; dkim=none (message not signed)
 header.d=none;inwind.it; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4334.namprd10.prod.outlook.com (2603:10b6:208:1d9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Wed, 24 Feb
 2021 02:27:53 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::e5b0:9afa:a555:a125%8]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 02:27:53 +0000
Subject: Re: [PATCH 1/4] btrfs: add ioctl BTRFS_IOC_DEV_PROPERTIES.
To:     dsterba@suse.cz, Goffredo Baroncelli <kreijack@libero.it>,
        linux-btrfs@vger.kernel.org,
        Goffredo Baroncelli <kreijack@inwind.it>
References: <cover.1614028083.git.kreijack@inwind.it>
 <d48a0e28d4ba516602297437b1f132f2a8efd5d2.1614028083.git.kreijack@inwind.it>
 <20210223135330.GU1993@twin.jikos.cz>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <e60ed8a6-833c-77ed-f5a0-b069680b2cab@oracle.com>
Date:   Wed, 24 Feb 2021 10:27:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210223135330.GU1993@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2406:3003:2006:2288:f531:6ae1:a422:5681]
X-ClientProxiedBy: SG2PR0401CA0020.apcprd04.prod.outlook.com
 (2603:1096:3:1::30) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2406:3003:2006:2288:f531:6ae1:a422:5681] (2406:3003:2006:2288:f531:6ae1:a422:5681) by SG2PR0401CA0020.apcprd04.prod.outlook.com (2603:1096:3:1::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 02:27:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b017c98-c4cc-468f-ec0c-08d8d86bc96a
X-MS-TrafficTypeDiagnostic: MN2PR10MB4334:
X-Microsoft-Antispam-PRVS: <MN2PR10MB43343BE6C20817BCEE97F991E59F9@MN2PR10MB4334.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGEsahsIe4Wpqi7QR95Tg2Vt8HxEdBX2qvrdGjoSoab6+BSA1NxFNYJUDEW4SWJ7CNXjHkdlmBD8BycoP/8MP/Yx5gVv0cbh/ARdEnoz0+Wh3eDV6SldwUkZlfnnN7WuCPjK6dFOcWcyn2jUCDb9U5PvITvRcnC+FFj31rMpVXIsSKBzmPHx8piCKWdaylvNZkwMeQcxOG8AYLrXAVu02uZuSKrbXDhZGdqAzJu2HIatuB1tAcQDBerA5j579Qfwa3XKySZz5MsCpeoMnbIwqZrUy4z6isLx7Jot3O8xKJRiobAqXpshCUiNsdioCeUrK4QZ5mb/axLJIyIGqn7U5MZp4dIMyxx4vLilqRSh8x9OJesLgiegCmM0GZCTD9Mpq0eNNt0CchN6PAUXXkqydAeZG5LZVHaKlNkuRVH1lODwLEic/6XOpi4u61H2CWfTShSFRFV4AboaYIHTm3ReyWqnpy3wVLb+paDozNoMiAxnLQsbkUzeka5SmdmaUwmBiy9qxISgKPHvFwsgzedJNO8p/ZhHZQlcazZHKX+JXUk0ByNqbjGFTn2aU8c66Pf8pWsGjblP0ritycM2YpzvFMRXjvDp3XN03tw5ziEW3uJBUjvWR9UDDpoHuvSvifBpPC3XuEdBWR9/5x/yEi8aqmg9fRFf6xBAJPrx0pNeWqc2QKgXc90iwF4N5RwJMF0m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(396003)(39860400002)(366004)(376002)(8936002)(186003)(31696002)(316002)(86362001)(16526019)(53546011)(6486002)(66946007)(31686004)(478600001)(44832011)(110136005)(66476007)(66556008)(2616005)(966005)(2906002)(4744005)(5660300002)(6666004)(8676002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?TDNOeFJLMlhQNWcyWFQ1c1luQXd1OEFvZ3NkeFltM3pKV2c3QnZnejFDT0h0?=
 =?utf-8?B?emR6L3M3eUx6Q21VdnV4MTZVdWQxQnRCY2R5QnpPYjZ5d1J2d21mbGN3VG95?=
 =?utf-8?B?NnAyU1RQYnNkbUlvTWJTRURUWGZ4aWVhS1RjdUIyNjdwektvUGdLZ1EzTG45?=
 =?utf-8?B?TFN0TTJFT2hjSzBWaTZiOWR4WFFoVTNLbWhicHJhc1ludUFTblVFVVNPL05B?=
 =?utf-8?B?R01yeC9oTjNIWTZqSnI4NzZ2bjF6d21VMHlIM0lJeTZ1K2JBa28zT1hjaTUy?=
 =?utf-8?B?WEdMV01tTXNxZ2kyYjFIQ3EvOWpSaVJjb0VkeStyb3BLclE3U0ozVkhCTGto?=
 =?utf-8?B?TmFiay9EQVliNStENkFkc210R09MT0QxajJaVjVhZGloaUIyNElBWER3L2Y4?=
 =?utf-8?B?TEwxVHhtRGtlSWFIZFBIVW9rN09RampPZm4xay83RktCQi85MjMwVVZ0SW1X?=
 =?utf-8?B?Y2NqZWxyT2F6NUpTV09vMEV6KzgwSjZGZytlUmErTktGYVdUZzhtUWx2Q3hW?=
 =?utf-8?B?WWNQUlBETGVMSlNkSlNrNTk1dUgvZnVFY3cwR0NxS2tEdjdBTmFmSVVSMjh6?=
 =?utf-8?B?SXIrNUFQZFhiYnd1UzlydjZXUWFJYlhSZU9hd3NraXhvSHdTKzhlb1d4ZHFn?=
 =?utf-8?B?aGRHM2gxVkZUQVFwZVlzZ2ZoMFVpQm82V3FtdlFwZTYzMmZMVFZWeUt6Y3E5?=
 =?utf-8?B?U3NBMTFJU2Q5K3Zydk9aVXYvamZ4ODNwazEwRDhac2FGdy9CZytOdmdxb0ts?=
 =?utf-8?B?bWh6Z0R4NVpWNjk1ekFmWFBDOGhFamU5UncvZ0c5WTRMdE91RE5mdW93Tisw?=
 =?utf-8?B?ZWVQdThOcFgrUkdWSnJxU3JFOWp4VGhyUnBxb2lIMjBJb2EyVldUSkhaTUdS?=
 =?utf-8?B?MDBEejBtQy94WXovb1VYWlYyL1FONCt2MHROS1NqeGpndzV3N2ZsQ1oxOXVq?=
 =?utf-8?B?a054a1VxWFlGamhOQ1dpTWNBcHRDRlh1U0h4NFQxSTNWZUVFQ2R6aWRSQy82?=
 =?utf-8?B?cENvTmc5ZElOeWVuUkErOTRGa1BiS2R5clh0NFlmcmk2b2l2MXRydHArbjhw?=
 =?utf-8?B?alkwenM5bWFLYzQ3S0Vkd2lUR1gxSzVydlljdHB6aDFoNXp0dGRpUzM3eFkr?=
 =?utf-8?B?QTdGT1U1NWZ1SkU0a0tySkl1a1JKSTJlWXBmV2w1WHpydzlKa3VaTjcxOWMw?=
 =?utf-8?B?b0RzRzBEc2UxVXpUZkdpakFXcWxNWVh0OExOODVlbS9sclZsMWdDMktSWXBa?=
 =?utf-8?B?Q2VoWmdKc3FaVGtDZnA5MVpqV0ExZExwN1BmZTNyclpkTzVtbVdMRGRmcWw4?=
 =?utf-8?B?dVRMdDNscTlxUmdYYzRvS2Y2OGgzQlNHd3o2aGovNVFiRi9xTkZFeWgvanE5?=
 =?utf-8?B?YWtZblBMNzJ3d3lZVEhFRklhc05QSW9VazdmZnIwblV0a2pVVE5wZVU2ZW5T?=
 =?utf-8?B?YkdHWHZyNUw4NFI2TllEV1ZqQkNtQWF4UFo3UjJDaGQ2VDNFRlBIaktrL21J?=
 =?utf-8?B?MmtnS05pRFpPUXBXVzNWeFNLMG05dHBUaTE3Q3FEbFFoZXcrdHJNKzVZcGl1?=
 =?utf-8?B?azlKcjZvVTZET1I4R25SMktQVkVnYUM2Ly93b3pMb0FsS0NldmFmUkk3ZkU1?=
 =?utf-8?B?MHdoQnJ6MkZYbnN2bFU0TzBzdURDcTJTeGVVbXplaE5wZC9MckdPcDR0MTBk?=
 =?utf-8?B?SkFJcEEwMmxGa1JhdVFYOHgzTGtpQVBrVkVCdHlQak9VenhGSE9lWlJOZFZK?=
 =?utf-8?B?MHV6QzFRbGZCS09FS0kvWjhvKzE5UWthZllGaEpUTWJmaWg0UytERHNpcnM3?=
 =?utf-8?B?UnpQcEJkWjF3MXJVOVZNQWljS1J0dE5XZ1pkRGhYRTdFVHcyc0NJblBhNklF?=
 =?utf-8?Q?FrfFlcrvpR27P?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b017c98-c4cc-468f-ec0c-08d8d86bc96a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 02:27:52.9355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LLfod1KV5lNduk1cPijhEQgd1xDFBqWMydxCaD6RejKiUszJszwTc31CkadGh9cQx3zyB1GfZMW9C8DtN3o4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4334
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102240019
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9904 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240018
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/02/2021 21:53, David Sterba wrote:
> On Mon, Feb 22, 2021 at 10:19:06PM +0100, Goffredo Baroncelli wrote:
>> From: Goffredo Baroncelli <kreijack@inwind.it>
>>
>> This ioctl is a base for returning / setting information from / to  the
>> fields of the btrfs_dev_item object.
> 
> Please don't add a new ioctl for properties, they're using the xattr as
> interface alrady.
> 

IMO a feature like this can be in memory only initially[1]. And later
when this feature is stable, add its on-disk.

[1] 
https://patchwork.kernel.org/project/linux-btrfs/patch/0ed770d6d5e37fc942f3034d917d2b38477d7d20.1613668002.git.anand.jain@oracle.com/


Thanks, Anand

