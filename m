Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6617D44C8AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 Nov 2021 20:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhKJTOr (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 Nov 2021 14:14:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57650 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232355AbhKJTOq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 Nov 2021 14:14:46 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AAI9fDY014499;
        Wed, 10 Nov 2021 19:11:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lU9CTJ3vCUiCOgQAXPb5OcDZ5x+nIlC16F+7g48K9Ws=;
 b=AiPuPPBIUXh0NfBjOWb+Xx/B0rQ0Vm7yz6VfSeBVqUhxULXizvC9jyOjkVWaUHg8UYdp
 MpRbnhnXFO6STjdnJt7EAFlqGLiiJzoBwpINcSTh8hkfJIw0EzXGAWGKIUFYlSIEwQ5g
 Q+TpHcZiKO2hWe5YTJ/i5s+ERKX3JqxMQYULMv8kmKvedDIZ4Iw2Smq6hy7dPgRRS2CA
 4r9qnmAnbYQ9WWe7cA1aW24MyN1Dq8jISiAYinzr8jEXfgl//yU5p0yGFQf30aChcGpg
 bQbCt/UloCCfrnizarXitCrAcacB52ygLd8YJlHuDvbhmnINjm6PNBGNDeANhj6LCpX2 9Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c87vxmreb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 19:11:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AAJ2L7N092760;
        Wed, 10 Nov 2021 19:11:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3c5hh5qu06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 19:11:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPBodge4ou/VSwIiNehu3EqG4/Cxj4Flxb3IdFlwZp65fhpNNnC/Npfp1nFgpwYOzPTJY/D8X7WI4IUNWp90KntZBaoMYVfsLvR5YAlqhBxu1NvymvWB9vbXcWQAJiYVMLtq2X+qp3ekSw4vVCm8c0cxjkG2tuGqac8CA9bbZh1kxSnRXbAHATjHmvoPkRYqZsM5xIXoudE9WKmi9xB68isedT4fPLZ2h6o7bBhpB+6lwQ4HSYbopg7UQHQngqcDuz/e0jFwnxsVveXLXl5tkgmCHJmKFH7S0AFpy2d/HNG1pSScSqtwAbirVxcKrB8CLDfqGKbMxlUOAbRzGYuYaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lU9CTJ3vCUiCOgQAXPb5OcDZ5x+nIlC16F+7g48K9Ws=;
 b=BAhU9RMy3Zy1ly9sdi1I1ei4Z9xL+bjXuYxN/o3ILPjUfGLHlRF9VQR1JX+6KXzt2ByF3UKWp5GP7DKq4FnsqSDxw2OZkDSgYyvkTPiBvEif0k++CBsVVZE0crjZ97f8CURX16UHQZ4eW+eM/uoJgK5IBliEs/8pBsM08r49lk+j9KJdGqWhP7OgWwnx7+lEOharuSZvy0o52b8mLXtpXG0Jm+IC0HevnYGNKJZfNRX2E/bLo/TqEwOFt7uMK/A2XMNzcxLWVNsIM/RHgv9wWSdm8j1+98DpLw4QlFQq8g+W3shZ5mdvhQVOuwDDd55YApd96eWsNvLZeNLLuT4+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lU9CTJ3vCUiCOgQAXPb5OcDZ5x+nIlC16F+7g48K9Ws=;
 b=rpWKU0Xj8fbgoiLqaBxsJaRKOJR3o1FIbz7LOkLRARY3cqwz80ggVK1sHZLnlvb6UPXRvrrfY22lfc328VaoAFijXex157RxOp52ZFuTkZeZYz/9FnoQ4xXCdykD400AF81ARComi/KfV72+kUYCoEzBrAkTQPwFTVewASIQsJ0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4095.namprd10.prod.outlook.com (2603:10b6:208:11b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.13; Wed, 10 Nov
 2021 19:11:48 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::31a8:a8e7:1ccd:6038%5]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 19:11:48 +0000
Subject: Re: [PATCH] btrfs: Deprecate BTRFS_IOC_BALANCE ioctl
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20211110114104.1140727-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <b7cc919c-9ca2-27e2-655a-047fdf984451@oracle.com>
Date:   Thu, 11 Nov 2021 03:11:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20211110114104.1140727-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.137] (39.109.140.76) by SI2PR02CA0050.apcprd02.prod.outlook.com (2603:1096:4:196::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Wed, 10 Nov 2021 19:11:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 427dd4b3-2d42-4d60-f226-08d9a47df1cb
X-MS-TrafficTypeDiagnostic: MN2PR10MB4095:
X-Microsoft-Antispam-PRVS: <MN2PR10MB4095C5461C29663CCBFB0627E5939@MN2PR10MB4095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PupXG8NZw2cppQM0MzSjnmR4rw79o+BQsKPaOxrW1eQcphIHPDEljQyasyTxkguHKlSlZ0pSyzQgFt0Ck0JNkQBPo44feltDz6yFMJYrRdWrUkp1o7v/f+FVZhNJMRI0xwaSsGNiDUiCA4GF1OyYNVozeVPGSpxpVAKjcUMhUPOJ9XSM69/u09iYLvlnIhciKa1i/VgZ5fGS3YPiDweW+jiIcvQQfKjsP01Fwm9aFR7mMvFkotukaJ2q5BNLxRF+/srJzTg7NLCMZbqeXCdECseGxV/r1TIIv42bXbMRwQUJgHvubOglYiHvk/Ej88xfCnkTDBEEjeWjbfO7rhyvLGnZTqv3A8/T8b0AP1bxBYHBOx9foQ7Rw0LhXgpcIPTqdMnGHW8dYsa2kHsQvSqhPBdlz/gjC5DFxYKm765BQkUyJIp8RCXzXPFe68RUzm3p1rXP0B0TmTSX5AO6Xu7H6NBSi5Lg9QMwRdvKeG9wBH3oxnXzmsoJ1W/f5eeBSU+deGbcM+/8q2xCPZzMQVRhUC/z2/YXPJk8DtXNR+hSkZP3YaOFev5wWXwJbgmVHk+mkHKv1cN5yl1lR9eeze1W040MnAcNuaWwcl6YaUBkIlfPN4Hbwn6GzWTqy5SYgUUZ66k5bbLd6F/zfdZxyFYtjrqohQuz9TLiQx1cxU6A49MnZ9r7H7kx471J6hCFVSQTkN61tFdNImxj+MSBEg1p4Lq+px7m/53uqswr4vk4EQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(4744005)(186003)(66556008)(508600001)(8936002)(53546011)(2616005)(956004)(6486002)(26005)(5660300002)(44832011)(31686004)(86362001)(38100700002)(316002)(66476007)(36756003)(66946007)(2906002)(31696002)(16576012)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anJCVUtETnZHNHcwQ3haR01wVWx3RUx0bFN2VXFRRWZpZURUUEF2cE9GeVow?=
 =?utf-8?B?dFkrSnkya2tIbklhdlBIM0VoTk9iTmprU1ZlVVBKajZKcm4wZEhmMDJJdmJu?=
 =?utf-8?B?NEFWcS9jZGRQbEIvcTF2QkhiUFhlTWMrdWM2cXk1Vi9EWlJIenlpTVl0WDlT?=
 =?utf-8?B?cU51a256S3RmQVZHUG1uWnpubmsvZFVBc0lGWnhwMnROZ1M5YmF4aWNnRzkr?=
 =?utf-8?B?UDlHelZqcDRhTzhvM0lETXk1TUZZOElkQkFaamUzWlNEdy9WYjZTSUdjQThM?=
 =?utf-8?B?VWRCczJFZElCeUYyZEZlRVZRekNySWpEdk9zQVQ1V2VnQ3VXUUY2ZFlDM01S?=
 =?utf-8?B?ODI1SlMzV2pqVmFzdmZqdWFLNVg3Z0ZZbUVsODEwUUxrRzV0R0VtNUhMbGpo?=
 =?utf-8?B?Y2MvUi9JK0h3REo1TnR1RW5jSHgzUUM3eE00RVZwajhsZFFUUzg2UDhBSThv?=
 =?utf-8?B?QlI0WUJ6azMyenRabEcvV1F2NC9jc3J1czNSVzBkTkE3YUVkajVuTUVxTUha?=
 =?utf-8?B?cTEwQWxzeVVHNVVUeTRRV2VRWTlqVWUzTFR3Q2JoM2hMS3NMWnRZWGJmaUsx?=
 =?utf-8?B?czQ1ZUhvK09hVjNaMlRhMGQ1OEpSSTYyV2x0YzNXMzlOU2VjN3JxcTZtRUtN?=
 =?utf-8?B?bXNnOHpoUHIzeER3L01RYkJtczlLRUVkOVpaNFh6d01NYVZzZUpMdk1MdWZi?=
 =?utf-8?B?WVJ0ZTJjSW5RajhYUEtjd2h2SnYxL0RqajlzTXUzNmRNYmJoWkEvOFhsTk5m?=
 =?utf-8?B?VWFzc0hhYkFqM2VYQ2lQZFBVakhtT0tUVUNldmhQT3ltM05UZmszWXJHSHVy?=
 =?utf-8?B?dXJEWjNOUUlxMlRrODBCZlY0eEtwTis0bmdUS1FBY2RueUtpM1Q4R0Vxdk5a?=
 =?utf-8?B?bFgrTUgvQSsxWk1oamdWVEpqaE5pSTVkZ1BOK1NkQjlUN0JQZUpURUY5dzRl?=
 =?utf-8?B?REtlTktiRENXb1dkZk5Dbk1TS2w5czM0UVR3U0tZODhhYWxZOHlPMFQrd2V3?=
 =?utf-8?B?NmxQMGlGQWpZN0dMd3Nrb2NMSUF2UlBwaEl5eE52VGNQTEQ5bzBzUEhNdkpF?=
 =?utf-8?B?azlFM29MbmpIaHoyMTFUOTJkQWs0eGRMZTBSVUFLUGxPbGFnN3IzbEJaYm9P?=
 =?utf-8?B?ZnNUR1ljVTY4UGw2ZzNKaXBVL3VXRTBROU03RVkvM3J0a2VNOTltTWhpSmto?=
 =?utf-8?B?SG9iZHMwOFNONDh6LzY0QnVnYUFxQytVbkRiSEU4N1JzL1daSFhJcUpkNi9v?=
 =?utf-8?B?Rzd2eUZZK1NFTjZic05RSjR3dHNhLzNRZ3g5Qmdva0tJSEt1SUNPdXhFYTZC?=
 =?utf-8?B?UDJIN3VIMnplcG1wTnZrWWhiOXlIV3p5UVBxSTljSzgwSVB2L0FNbkhSa2pW?=
 =?utf-8?B?OFNCb2JGZVdIOGQwUUdHYThFNENMc3RCMnVtemJ3OE5SZG1GN1NaNUd4OGhP?=
 =?utf-8?B?c0lBUDJucFE5Q3JDcWVrMU1iVjZzWkRkc3JXMFlYZHEwbnZOam9BRXNXckRE?=
 =?utf-8?B?cXlBbURBUVJndjI0SVB6MEc0aFFDTTBubWRQZGJhWGw4bEwwd0NXOHcvSWhV?=
 =?utf-8?B?cW1nSThrK1JtQlRQb1hvMFA4YURDTEhuZ1R3YW1kUjVxRkNGRDV0dmtaY1Bh?=
 =?utf-8?B?cXFhV3lKamp1UjNFTkRRUGF0Nm85RzlaN3ovbTQyZDlid1FJL2EzSGF5TXF6?=
 =?utf-8?B?NldNbTV2NzhGbjVmeThZS2p2NWZoYW9KVXYyYTd5VW5mTGRVSmxhVkRvOU1o?=
 =?utf-8?B?R3N4U28xMjR2UjVMSjN1eUFYdm11TUtnNjBweTVCL0JUMG1wZWx5UGNIQ3Rq?=
 =?utf-8?B?c3EzdzVKK3puRHVoeVQrZHV5TU9YZVVFelBJMDRYbHJzUzRMU3JpdlVxZ0ln?=
 =?utf-8?B?aG8vOStFdzdjN2RVZkZVa3ZQRW13bmR0VHJSM1IwRkpmN1NjZmswWU01OGxO?=
 =?utf-8?B?em4wRjl6V0xsMVljKzBqek5MKzVHc0FRY3lmeHpxRm45emdZamVIMEZqUGh0?=
 =?utf-8?B?N29rVTd1V3BiMGI3aUN2L0tsSHpHVVdsSzNJSHc3dUVnYkdONlZ3Z0ViWHpW?=
 =?utf-8?B?cG12U2E3cXRmRVpBOGI5cVp1dFdpZGJVUGhycCtBbHVTL0lTVkRybDIxTWNM?=
 =?utf-8?B?WUo3b0pGQ25ISnhOcEpUMHVsb3pGWkVVZS9rZVJETEhZOHI1aG00MVQwNDRK?=
 =?utf-8?Q?jmVIOvZt51lNaWQCO9IVrlM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 427dd4b3-2d42-4d60-f226-08d9a47df1cb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 19:11:48.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lx5jWMBol/TUPt+VkegGrDLS5hXRE1VyeZFRZR5NLvdAe+W9gLNRjFjaE1m1oWGLlnpnwNAD+fiL8ZfMOaPK9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4095
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100094
X-Proofpoint-ORIG-GUID: 1E_ng4qu_muP-de6Lh1-tbIihNfHqr-q
X-Proofpoint-GUID: 1E_ng4qu_muP-de6Lh1-tbIihNfHqr-q
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/11/21 7:41 pm, Nikolay Borisov wrote:
> The v2 balance ioctl has been introduced more than 9 years ago. Users of
> the old v1 ioctl should have long been migrated to it. It's time we
> deprecate it and eventually remove it.
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> +	if (!arg)
> +		btrfs_warn(fs_info, "BTRFS_IOC_BALANCE ioctl is deprecated and will be removed in kernel 5.18");
> +

Nit:
  Needs proper formatting, split into two lines, adjust the indent if
  still longer than 80 char.

Thanks, Anand
