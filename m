Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7309949B78C
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jan 2022 16:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344222AbiAYP1N (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 25 Jan 2022 10:27:13 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:60880 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbiAYPYl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 25 Jan 2022 10:24:41 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PF0AZr022688;
        Tue, 25 Jan 2022 15:23:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : cc : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=imi/s/JfTnSSdf4iE8yHasdvbfAUwNpG3kXvpDqrE2I=;
 b=OpPuJlQ3y/7g8yma6psE1e9xg90Z5WRiY2byc2QAe2m5e53iukghmmGMDE0Wn9c5n2Ld
 9qPK0y+Fe17IP1rLe8gaIxzBLmpnZhfwp3r53saeZJqslYg2EMaCczUMtllm0RU/jUUS
 vGJNWuEEwIk+ZWLbAj2knyGgFfTKPLDxGRZANB63RPhcpwTtVPBHaPnJAEdsAXTmq8KJ
 dbzlQ4RLJQ/Lzo9++wV/pGJbP0gbkpZzHfuGOJ5/bBDbdVvXAXprLqnX1Uc+NA4mpWT9
 VmmL6dCzH3rj1JpM0GEXvafYFZsAUTTsrbitzsTTYNsBKF2QaE3MjS1YGB6dv7GhPJre Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxaabe3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 15:23:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PFAmEp039692;
        Tue, 25 Jan 2022 15:23:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by aserp3020.oracle.com with ESMTP id 3dtax6pf6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 15:23:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeUT+zSpjSPgt8G7l296nh/VALZVGcqLIhxF2kQkRjMogxo3syL4k8PZTJE/pdAoavnBjNLC4esVFfRATwqNUIGS1ufYT/CkR00Gge3a5JYB7QFcKHFndAmwqNMBLRMipAOKTcdn5jNS/BGx9/on8YW9YAocfhTCjJcyHd+hPX3VDUbzZFzSvWS2Hhm8JqOjvoOpRc9y0PnptdKP7vleSPB1Bw9x08vk0QZxaGUSlojR+77JVw7Pv4kMETO8tjowt++ynyEDvxCdLHsK2C2j0PbT1d8aPNAeroCNOM+YHNIHNbLevg9HXMqWMlEeSCIP0UwrgNyGYGIwzr52CuXJ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=imi/s/JfTnSSdf4iE8yHasdvbfAUwNpG3kXvpDqrE2I=;
 b=j/YL6lnoh9hZwTTp4uitxgKjIgxVIk6ObnsYt2v7rvyyBSatAAkfhBUZJ17+IcPSgQOQ5ts0CqRRIf+G9utHYD+SZgWNl6Ze+G/FpicM6pLqECCT/p4DwtcGkSAvlOk/2vBY66jF/sUDmDGLHj/cNGQRpJChPMzERtmTOCT3Vo3H3YlIdkzpT/cbcvnIYzZNLjPtrmGDzJc5g0O7MchxTSEPu91yVuiP8EtNB2cVpedO3LiLPGhAqOT1bF15NsQPyP9i+Djh5jKgfjYIIcvVMwshckag8v7sNFpYuZqy5vD1uld3h7KxKCWr9PVb3RyCQ+Ku/ZTJUMcLMAepAICUBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=imi/s/JfTnSSdf4iE8yHasdvbfAUwNpG3kXvpDqrE2I=;
 b=kKn0vicZ1tWvzz1azp2KTAk7ZfKuf1/8rYT+JFdo7XrFJjsF4WxY2VJUDKiqLGIuyheXzJpVJcQlcI93vnHjY5nPFlOFm0wH+wk3vT5Yxfs2Dl+2FZxhZPqSLq/hcrX+iExFvSg1A+INY4B2uqEkwn0cjqjhTnop0Ch2V/cxc/o=
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BN6PR10MB1377.namprd10.prod.outlook.com (2603:10b6:404:43::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 15:23:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::f450:87d2:4d68:5e00%8]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 15:23:39 +0000
Message-ID: <229e952f-f04a-e062-7915-7918b5df0c3f@oracle.com>
Date:   Tue, 25 Jan 2022 23:23:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: some fix for the comment in btrfs patch please
Content-Language: en-US
To:     David Sterba <dsterba@suse.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
References: <20220125201301.CBA6.409509F4@e16-tech.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220125201301.CBA6.409509F4@e16-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0090.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::16) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b4a74ff-a15f-447c-567e-08d9e016a997
X-MS-TrafficTypeDiagnostic: BN6PR10MB1377:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1377A5F1A9492D9FA7E8169FE55F9@BN6PR10MB1377.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: otFmWJ32YjhcTlEBhWfzETbSURkM3jwp/Tip6uNI97fplmk3j9VQzohbqxjQZY4YCIjYDc3vrKJn3p/gbbYVpd49HnBAqtClP24wZ7rsWgJlimA2kPxrOjg7S0AktS9PQYaicug2cNsYfXylS1jhhaJj9yh/7bEkqIzT748M82R/dz7uCHo9mgSpTSqajZnuW6QddC8acQ5GLB1Fh+2MsZ9MeKdkiJzbjFf228BUEykw/biC70vv62X/vsxCph9UELrR2W7Y9Jzd/9u6xOlgJiTQXKfrQ0yccQTuDUrnVTM8fhf5Y3Ry9Jl2jJqGHY5Zgud0/Bxc6b/f1ZuycfiL4N0NEihy6/JY6uXmiy5b/47tUdADZ+zSgknXlNNCxOb8tebZcBOqi+dYmfWb6lLECVji9l0e2vkzrsLoHrvwSOdgG/LGNbHK82SPcTewwSvVXtKkU1wceOAdNgJmvkFh/uaBEIfju3IIVN1M8IqAFGh6rgkH+Dn8uX2d3jq+E1HF/glkgzIHmq5WeOgsGsJ/dIJGQTvoZAVaOyT1+vJIeR++1BjVfm7vMXE8L+H/71eGH1E72d7+hYZJlKFoex6qRFlHugymTMdZqmzpuseHQ87DQiAMYG/3fhh87/53dxzrRR2Adm3MqkVrQ4KXxmgtXU67GPqn9NiL+E31MH+EsASxkHPSFwz7qQkTKoS/cr8Gs606peQ6p1rpomw/plqzPi8FRcp2ML/k8cMIS1EICrY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(2616005)(36756003)(110136005)(186003)(316002)(31686004)(66946007)(66556008)(66476007)(6486002)(26005)(5660300002)(53546011)(6666004)(6506007)(6512007)(8676002)(44832011)(4326008)(8936002)(38100700002)(31696002)(2906002)(86362001)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blNRK2lSaTFZOUZCSGc2UmRlUzRXZXc3dXlSNHpVbnpwUVM5RFhEVGpQQnph?=
 =?utf-8?B?blhvZFpVSUNXTlFXRklxbGh0c2REM1ZSOWhUd3k2eXNTN0ppbEorM21QL0VL?=
 =?utf-8?B?eVhNcXFobkRKVjFBTlJZSHJ3dUVRQlZORnQySzNhRVozZ05zdUoyR3dTZWZq?=
 =?utf-8?B?akRRZE1lc0xGVmxQS2lKdmw1U3p2KzNxTVpPdVZHUU1BNlRWYm5CaWE0THEx?=
 =?utf-8?B?bndFVEtaNERUVEFrL2RiK3hmNExXWkI2YmYxYVI2ei9XNFJFOFhXcHZ2UW9p?=
 =?utf-8?B?WDFMaVdhdko4T2h3akswNlhvVmk2eHJaRE9qc2w1bUpkVDd4Z2VBaWNpRi9W?=
 =?utf-8?B?UkdOTys2WmVTQmI4NnRmRkdHajFySGMxOVJ2S1I3bWZIejlqY2VyME9IL29I?=
 =?utf-8?B?dTFGSmRmTkpYeVByeUNwUHJlRVEvcHNTYTdzZGkvM1J1KzN3L2lnUmxDZnBZ?=
 =?utf-8?B?VHF4S1ZodWFLc2hRelVYSzQ5eWh5WkpUSUdjMEpSTnU2ajA0R2UzaUVJY0VW?=
 =?utf-8?B?bkphOUZNQW1aUThVNXNneFptWFkzRHNUMzdqY2I2N0FDRXRmWGthSXplRldD?=
 =?utf-8?B?ZlZ3SUl4TitXZS84TXNtRlRhcytkRWJyU1hxdm5DLzh0YnpMS0MyM2FzUTV6?=
 =?utf-8?B?R0UyMzMybUVWK0I0eG5xL0h6RzBXamtIMndQVlJCU05EMW9pUDIzTEN6Lzk5?=
 =?utf-8?B?THlaRFFlTE14QkF0OXJLWDRWOERsNUQ2eFREeVVOVXcwZUFCYStGOEhxREJW?=
 =?utf-8?B?VjVBaXh0NFhPNHVJRU5oWUFEZEtzYkZReHFqQ09XeFAxRjNJZzVxYzg4ekZR?=
 =?utf-8?B?bEpFWS9Mc3o4Mm05bFVSNDhiclkzcE9mYkMxMk1RTXZrWkdWR1AreHRDK0cw?=
 =?utf-8?B?YVVLWTJLZnZ2RHNWOGRKOXVJeHhuZklRcmFIZjdvT1FveVZsRHNDNlZPaDRl?=
 =?utf-8?B?WTlacVl1enloWGxXRXp6b29oVXVRcjV2UzdYd3JpSkVmNW12N25NMVp0ZER5?=
 =?utf-8?B?ZUJ2Nllnc2hERm1nNmlXVHQrYmdoSTJxOFBkUWM5ODZsaWtaZWtEOTVhMldj?=
 =?utf-8?B?S2VhQlc5MnRvMmc2aDBuUGp2b1NUSWwzTUpWTG5ic1BmeGlZU3R5RjE0S2Vm?=
 =?utf-8?B?V1FSemI4TUNFRUJHdE9ZL3lpTFk4bzkzRXJOd3MwWlROSUEvQi9uelVhTWVL?=
 =?utf-8?B?Y1FVMHkySmNrTGlaUHVYa29DWHlDSmNKRFA5SHQyWFpFcWlXeklMczA2Qzlq?=
 =?utf-8?B?eTVjTWFYNDN4ZzNDWGtBbmdkWjZSc2FNd3hEa1lRSVlrbEx0aDlUUVhYSjMv?=
 =?utf-8?B?UmFQaVBWYWFyYzQ4Q0J5NmxRaXZMbjNoK1cwSmlQNzcxZmlFWXZyOXRhSGpD?=
 =?utf-8?B?dm5ZaWdNWTFXRGxmdjhpNVJiZkZ3bWE1ZndEa25IWEhJUlhpNWVETUNoZUVR?=
 =?utf-8?B?VlozcnJWMkNWT2ppdnNEcGxwK0x6Ty9jN2F1MnpEcUhvR3BqY3VjREltTmto?=
 =?utf-8?B?d0l2VnppeGN2YU9MMXVKaUgvd2orK080YjVsenlXTTgxTzRHQWtLRDh3M3B5?=
 =?utf-8?B?VzNCVFFmZ2VqbG9TOVhva0FTd1NTYzVudTZmaElNenlEUUZJd0ZWVjhXRlg1?=
 =?utf-8?B?cDh0RXFGc3IyMUFGd251UFJYKzFraE9aZ3hDaVBDUkYwYThIcE5leFJUd0NW?=
 =?utf-8?B?ZGNkWmd0Z0Q0U3hRa3krT1k5V3VtZlJtREwrRnFCUjBnSUh3RTJXZUNOODNO?=
 =?utf-8?B?RHhTdXY1UnRmd21tTFpJa05VRVF6ekxQR0hqVVIwbVJnc2tpSEZrSFZkV053?=
 =?utf-8?B?cFdqTVNCa2NKQzFmUTdsc3NqRy9UQmZaU2M2dFR2cmdJaVlVNEpjRmpYdTlK?=
 =?utf-8?B?QStCdzk0RHJkeHNyNE9zYUp2M0hMQjBlZys5QnFTSVNlTzdIWGxxbHNKUmIx?=
 =?utf-8?B?QlFYelBURHZPcXpCa1hWa2tEYlZGMFFsWkFYaGdDQ2Q3a1JQSzlFQzNGSkJ1?=
 =?utf-8?B?b05QSytuZFl2Nyt3ejVPWFFJTk1wTjJGSlRwMStnQTJBQkU2MGtSODhITDgz?=
 =?utf-8?B?R0tRdlh1SS9FZk5IbW5RaFpNNmxieXJqQWR6bjNMdnY1R2ppVzEybUl3cDgy?=
 =?utf-8?B?TEpxRXFEeDJDM0JVd0NUd1o5K0k3anhJOThRM1N1S3dEVlFJaFRkUytYQm5O?=
 =?utf-8?Q?+m1bz5xsWz9GqkYiIBBSh6g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4a74ff-a15f-447c-567e-08d9e016a997
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 15:23:39.2711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mvep2GbKvUC2N2AZ/kpiFL0t6RpzobBePVC5l+YR/H/s4MDx89sOpSSoXJ6Mx1Sg82jypy2v5ZTT1Fj5D1TJ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1377
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250099
X-Proofpoint-GUID: NlBHx-Dl6QnZPKggXVpjXoyiobiHHWop
X-Proofpoint-ORIG-GUID: NlBHx-Dl6QnZPKggXVpjXoyiobiHHWop
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Thanks, Wang, for the report.

David,

  Could you please help fix the typo in the comments for the function
  btrfs_free_stale_devices(). The bellow diff can be rolled into the
   commit a67b5c57cda9 (btrfs: match stale devices by dev_t)
  in misc-next.

---------------------
fixup! btrfs: match stale devices by dev_t

Signed-off-by: Anand Jain <anand.jain@oracle.com>

diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index e3cdb4f5ae37..8d42037d2ba7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -540,8 +540,8 @@ btrfs_get_bdev_and_sb(const char *device_path, 
fmode_t flags, void *holder,
   *
   *  @devt:     Optional. When provided will it release all unmounted 
devices
   *             matching this devt only.
- *  @skip_dev: Optional. Will skip this device when searching for the stale
- *             devices.
+ *  @skip_device: Optional. Will skip this device when searching for 
the stale
+ *               devices.
   *
   *  Return:    0 for success or if @devt is 0.
   *             -EBUSY if @devt is a mounted device.
---------------------

Thanks, Anand

On 25/01/2022 20:13, Wang Yugui wrote:
> Hi,
> 
> some fix for the comment in btrfs patch please.
> 
> From: Anand Jain <anand.jain@oracle.com>
> Date: Wed, 12 Jan 2022 13:06:00 +0800
> Subject: [PATCH] btrfs: match stale devices by dev_t
> 
> @skip_dev -> @skip_device
> 
> this patch is still in misc-next.
> 
> Best Regards
> Wang Yugui (wangyugui@e16-tech.com)
> 2022/01/25
