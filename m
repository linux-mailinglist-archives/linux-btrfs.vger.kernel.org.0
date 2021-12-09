Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1A746E273
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Dec 2021 07:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbhLIGcE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 9 Dec 2021 01:32:04 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32174 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229662AbhLIGcE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 9 Dec 2021 01:32:04 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B96FR3a025396;
        Thu, 9 Dec 2021 06:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jDYPsWyZbS0A4BIkRUBQWOq34x/7rPibiP9cwZv7cts=;
 b=ZjdMhqsfA84wpKFHzGd3gdZPBK7ChcCGHf3sNy/JHiRAl9snfaPGRMM1Ro0QUu3dChbd
 bnq0cx/v4qUmRj7bxDzBu1haHoAAf0+uvp0IXG5pyBrokplady3nWN3nme4FECUQ21/T
 ANGEKVzio00/q0PzOG5eZgGipy+3OlaEGXxHDH7IqvpowdJkCMoAqRPODjabwsEjUyL1
 SY6ymFRbbSWwoKIjmbYMDkz6J8fFyWWQXD4SSb4NjlpAM0yK16POcROrXXCbB/TcwbIn
 BpzapQSfa2p1+ftNxmW1waux9n+G4ninxngEdyZeEQ+5yGQ9Ki2sHpxPvDLzdWiukNpa ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctse1jh2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 06:28:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B96QBwO007335;
        Thu, 9 Dec 2021 06:28:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by aserp3020.oracle.com with ESMTP id 3cr057dhf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 06:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGba/biwsuYFVcZaXm8oNJCcAgwAgmqVKZt7FEuuWVpL8cYVrZOKMhvlrGewHgzmUdjCk4ldrT56JQUhE0CwRGThn6mWs9zxYG+6lpj2mrqbxcM7g3+M5CevfkaMYUABf24NI9VrYkgXdJPnQe6ry1fPZCBhhNXzdsZ2GCuD2xv4Ti6GBkEDvTwMbYjf5e3QhsBVGq8uEB0kS7kMZkanH8AglokLAfo9dw6BjitZjJlNQkawzDjeBADBQ0jIzA/JWqBIF1lMFqJISm5eDDVai69eR49tvU2tFDFvTlqmQoH+YfgRAi9gtJUgRwkPbzBhrhT4CH7k1jFylUH0sgKliQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDYPsWyZbS0A4BIkRUBQWOq34x/7rPibiP9cwZv7cts=;
 b=Uk/kQcCzhODpBOZaEFtJ0OO8i3yoIBvfeGlpuC9LpZ20AjcVXdllNnMhd6w7EkaJdTGxzGehbJ7drIgkZVu52WRUo58KezH4x0p4ptHFqQgjjrvqjiXo98fk/sxYwphIJAXl9yG3dYKoXX7y4KDdJKzyLjtiJwMxk08i9sMRmyufzmcfPvRVWwZWvsMXv7vZQu7efrDSfXrJFzOAbHdB2iAYvpaOEwbRA34ozlQAfPe2OUccPXmoLTOPToasWNVe1yafC1/roxWdvpn6e+tEp4of8RbapwKyRoXn9moiKxGYXqBTL3FzuuE8tcLj7LeQtn9AILLxyFEz96rBp/jplg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDYPsWyZbS0A4BIkRUBQWOq34x/7rPibiP9cwZv7cts=;
 b=VYKl92YpcbVP/cSmPLkbisCNJB5YSym1Nhe7NweSgv3NnlpyIxsUlr3kANHVutl+1kV5r8l5gzNUFAulREKM5S1APn1wv15peHGR+qvffN5f/QYTVjpGj3N0z9R8MeVkLWA5xoewFBUeTwL8MJwF7B/v2m1xV+bptjizZgUHQ7Y=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by MN2PR10MB4285.namprd10.prod.outlook.com (2603:10b6:208:198::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Thu, 9 Dec
 2021 06:28:25 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%5]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 06:28:25 +0000
Message-ID: <865767f5-e942-7477-4f71-38279cf3146a@oracle.com>
Date:   Thu, 9 Dec 2021 14:28:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] btrfs: harden identification of the stale device
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, linux-btrfs@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Josef Bacik <josef@toxicpanda.com>
References: <166e39f69a8693e5fe10784cdbd950d68f98d4fb.1638953372.git.anand.jain@oracle.com>
 <202112091123.ETjD5KQj-lkp@intel.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <202112091123.ETjD5KQj-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0232.apcprd06.prod.outlook.com
 (2603:1096:4:ac::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SG2PR06CA0232.apcprd06.prod.outlook.com (2603:1096:4:ac::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.22 via Frontend Transport; Thu, 9 Dec 2021 06:28:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68781273-f0cd-453b-3422-08d9badd1ad6
X-MS-TrafficTypeDiagnostic: MN2PR10MB4285:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB428575A3AE0F9F2D138BC597E5709@MN2PR10MB4285.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLAbQJOx9ynf9aSEHfJTfowdrgCdeQKvd2e1rBROBsia8jbri9zFGwXrNJSCRLKianrHtHtyoWYSeBatic9M1M1/TKvl5bYwQGVrIt2WQe3pvF3KPqw2oJtCZGrTK3iz70KjjOJxrchvEiJibDl7dHnzjqPYZYWaQt99jF8plCjrcWueJif3/y5RuTRynwDPlDQ68/u+5klsdMp+3ccJcSFkyaFOlbQRELulfcvma/k1dEZyq8CntyfaunaVqu5CxoQyaKrikLBwrn77r5n0Hrrz6cH/1eIjsBOgU41D+M+p4NNko+PYjB2SbaZ/gwaF2LpleC/JzP+SgffMHDNay06KVTutkAcS4Gh9NCKnyHJ37UnyEI88xOl6siQuecYOe4OnB8YVQ9u8dZLno0CYL04WXmDXMTRG98r3KsagHphrackYREGYf8qjrBxYlmr+qLyx/mKXReagNtJ8gqWoH4oJMWzBugAQSf0ZYfaqiMaA1YHz5WL1kuYqITiOLEYgYFHuNDLgDB13x4B3JKWENdgJqljvmqPYQsLhrqTNdxeLgkCUFo4D/TvOc6pZCmVdoT/53p/FttmNKHLcbHSQN4qrB15u4cE4H6ZozTZ3VTIF0e8RTSphREcUkPKkmy76qLXcaqP6K8JWnPFjc4Y5yhMGafoKMNE1KrxhWrz0gr0OjtOml8r/H1nAJM3HHk8/K+pMxsUpjCC8F85vmQasrgvg+THj/wNf3z6ggllyUeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(2616005)(956004)(8936002)(31686004)(86362001)(83380400001)(2906002)(66946007)(38100700002)(66556008)(66476007)(6666004)(8676002)(508600001)(36756003)(44832011)(16576012)(4326008)(31696002)(5660300002)(316002)(186003)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFpYdmI5OGRQbWFCQ2diZzdPZmVNK2pjYk1SYlRtOEZhbkF3cFhkYTBFMzEx?=
 =?utf-8?B?b0RBWWt3Yk16WExQdEFjZDJsWFpVbWFBcXhJWEVxREl6UXg0MUJpZDVBZklp?=
 =?utf-8?B?dXkvT1F6NmxXUXl6RVFsd0xkMHRHYURyRzIrNitCMWxVb2dTMW03ZmI1dnVI?=
 =?utf-8?B?eFo3c09TbDJITC9MMHNxamR0YTRNS29pNlYzUzVydEZjV1Q3d3ZlUUlGWDA0?=
 =?utf-8?B?YVhkOTdzZW1tNjF5U0NjeDdKd0RJZU1LMEV1aFFoS1ZxbldibzlZZ0FNZXhp?=
 =?utf-8?B?STNJZ0MvSjJFb3E2RE8xRkpBVVNPai9WNzBPY1Y2OHMwMGhxVEg4ZzVjcjVI?=
 =?utf-8?B?UHQ3dGI3RU4va1duUkhmRmtCOVRMck5CbmRsd3JBSW1LTXBjcWlGVG1Bakcz?=
 =?utf-8?B?RkNuL2hDeC8wZW96RXM1ZnNQdGhmU1p4cCttYjlDYWdlN1VUQXd0VVcxem9q?=
 =?utf-8?B?NlVTYVFIUHU2Zkx0RlJYMDhOMTc5alQ0Vkt6MUVSL0xTR3orMmVkeFBiM2o5?=
 =?utf-8?B?eEE4VUJ5VFVDR0JFSEZwc0o5VkZBQlh3ZWV5aTd0bkJhZnMvbGFGTjNNUWJK?=
 =?utf-8?B?NkRJZ3dsWVVEam9KNjhRVVQ1aW5zcVRtQ2hab0ZLdWpqWXhSQlhCSFRtYVMx?=
 =?utf-8?B?ZmE2RlkrT3V4YUtRTHhJM0ZMaUJKbW5KWm1JRE9WeGlJR202czFrQUJTYjVK?=
 =?utf-8?B?b1RnQ1cvWHB6TmdBZWttOGQyeFdSdXlVY0dacytHZWdDVUdtb3NkMXFVZWt3?=
 =?utf-8?B?d0lHcExuZHhBVVhud3BYaFp2OElYWkNjV1gyeEZHMnp0cFV1OG55elRoZGVr?=
 =?utf-8?B?MnphNzQzM2VhYjFqK09RVlF1d0JaM3J2ZHZRNXFFeHVRUk41TkFIVkJDRXls?=
 =?utf-8?B?bGk0M29XeWg0WnlTUmQyQjREK3RnTWlUbWNjVXVrOVJ5eFFCQ2FQSDhPRWlT?=
 =?utf-8?B?T1ovb2wxWFEybE5MUWIrMWVSSGJVSVlhbk8vSXBMNmNNdlk3ZDdmQXIwaGJT?=
 =?utf-8?B?NVZDOTdGY3NDSGczYXRxN3Vrd0YyUWh5STNXQ1BRWkhaSmVFK0xRV28vWUVV?=
 =?utf-8?B?N0t1UnVITGJmUmFrVkFJb3B5WDBOV05RUjR0Y25sYWxkRllpL1hIZlU2TU9Z?=
 =?utf-8?B?TEVSTkZXZ25BdUJodHIwbTNLVjhXNTBudmF4dnVucmxSOVRIdVZRa1dxdEt3?=
 =?utf-8?B?RGtva25NMkxJVmJiR0NuaVZzeTdjQ0wvcWlUUjlFazAyWXBBN1FUM05hTEp0?=
 =?utf-8?B?K2cxc3ZZbEo3RDhZSWVtd0gzenFpUzJkSlBKWGNNaGFuMmo3aUdib095dXNH?=
 =?utf-8?B?M3NEc29ZQWQ5aW5pSWNWWk5qZkc0ZXFZQUhFSW04NWhRUGhCZXhDOGZNR1VQ?=
 =?utf-8?B?dlc0MWNPcnE1UStkVVlpMXdJcFdWOU00QzVCa3RsaVFjZjg4S3J1Q2JHaU0r?=
 =?utf-8?B?Zm8zNlpSdi9wVXNNb0VJNWlIMlJYZ3pvTjRFcFJpQjhySld6NFFSKzQwc1RT?=
 =?utf-8?B?NTdOWEVPS0hzUnBjRkdQU29iS1dSRUljR2VqYk1CNEl4M2g1NnVtanZ3MDl4?=
 =?utf-8?B?dmdIRXZBSjBaQ255S0dVTWNDNGwrR1FySDhpb1ZQc0ttSEVLbFZWTE5oY3M4?=
 =?utf-8?B?WVVLMjFiaUUvMitQSXJpdGVsdWNKT3IrSHFSRE9vOTZVN1hKK0NYTnViNTI4?=
 =?utf-8?B?YUZjdklrRlNYV0phQkI0ZzB6eXJNQlJEUGRDWk1Rc2xDZ05SRDhrL0UraDJv?=
 =?utf-8?B?SjFtYkVuYzRLbTVpQTE2bFQ3QXhxeitCcHRYTytJeXNEcXUzTzdhSTMrQ1NI?=
 =?utf-8?B?Y1FraFA1TUNIL1JsYUx2UU40M1BBZlZUM0hsZnk4dmZEWEo5Wnl2STNEWWJj?=
 =?utf-8?B?ejVXeEFORjlzKzEzdWZ3aHFYM1Vqc05VemRJM2dCK0h2RENhK05sNHpIWTJj?=
 =?utf-8?B?UkltM25OTXY4aXJZRnpzZkp5KzVyZE1CUysyWmJQMnpEbk03K1c4aFg3UHpx?=
 =?utf-8?B?WjArM1A5WjJhQnNpenAzazhUSWFHQVJsRjBqMXJjTXpiTUo1RVJmdndWTUtM?=
 =?utf-8?B?enpLWmtFdnd4Z1hkZTl3b2phS3pMUDZNUTJwOURmOEVpeTBNOWlaV3ZKWHYz?=
 =?utf-8?B?RUR5UWlHN2FsLyswQTg3NE5YWVJFdnZWL1FvR0FXNmdJeCtmanNPMkQ4QlJR?=
 =?utf-8?Q?D/mccke75bjlHrVWTmY9b4E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68781273-f0cd-453b-3422-08d9badd1ad6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 06:28:25.3388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bgci98BSwovoUExuLs95kOO7mKAwMKPp0ejerPvNT2oXYka6zukuKoHgCFQs5f4sRpYoCumvCenpTEiTOVlqHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4285
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112090032
X-Proofpoint-GUID: UzWdoS0J45-x1GJfB6ruXNZR9OmJw7Gv
X-Proofpoint-ORIG-GUID: UzWdoS0J45-x1GJfB6ruXNZR9OmJw7Gv
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



> sparse warnings: (new ones prefixed by >>)

  The new Warning that this patch created is the same as the other 7 old 
Warnings. It is all about how we have used the device:name.

  I will fix the new Warning. Looks like we need to fix the older 
Warning as well.

Thanks, Anand


>     fs/btrfs/volumes.c:402:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
>     fs/btrfs/volumes.c:402:31: sparse:     expected struct rcu_string *str
>     fs/btrfs/volumes.c:402:31: sparse:     got struct rcu_string [noderef] __rcu *name

         rcu_string_free(device->name);


>>> fs/btrfs/volumes.c:549:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *pathname @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:549:35: sparse:     expected char const *pathname
>     fs/btrfs/volumes.c:549:35: sparse:     got char [noderef] __rcu *


         error = lookup_bdev(device->name->str, &dev_old);


>     fs/btrfs/volumes.c:643:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:643:43: sparse:     expected char const *device_path
>     fs/btrfs/volumes.c:643:43: sparse:     got char [noderef] __rcu *

         ret = btrfs_get_bdev_and_sb(device->name->str, flags, holder, 1,
                                     &bdev, &disk_super);


>     fs/btrfs/volumes.c:904:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *cs @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:904:50: sparse:     expected char const *cs
>     fs/btrfs/volumes.c:904:50: sparse:     got char [noderef] __rcu *

         } else if (!device->name || strcmp(device->name->str, path)) {


>     fs/btrfs/volumes.c:984:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcu_string *str @@     got struct rcu_string [noderef] __rcu *name @@
>     fs/btrfs/volumes.c:984:39: sparse:     expected struct rcu_string *str
>     fs/btrfs/volumes.c:984:39: sparse:     got struct rcu_string [noderef] __rcu *name


                 rcu_string_free(device->name);


>     fs/btrfs/volumes.c:1040:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected char const *src @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:1040:58: sparse:     expected char const *src
>     fs/btrfs/volumes.c:1040:58: sparse:     got char [noderef] __rcu *

                         name = rcu_string_strdup(orig_dev->name->str,
                                         GFP_KERNEL);

>     fs/btrfs/volumes.c:2235:49: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:2235:49: sparse:     expected char const *device_path
>     fs/btrfs/volumes.c:2235:49: sparse:     got char [noderef] __rcu *

                 btrfs_scratch_superblocks(fs_info, device->bdev,
                                           device->name->str);

>     fs/btrfs/volumes.c:2350:41: sparse: sparse: incorrect type in argument 3 (different address spaces) @@     expected char const *device_path @@     got char [noderef] __rcu * @@
>     fs/btrfs/volumes.c:2350:41: sparse:     expected char const *device_path
>     fs/btrfs/volumes.c:2350:41: sparse:     got char [noderef] __rcu *


         btrfs_scratch_superblocks(tgtdev->fs_info, tgtdev->bdev,
                                   tgtdev->name->str);


