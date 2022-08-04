Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88F9589529
	for <lists+linux-btrfs@lfdr.de>; Thu,  4 Aug 2022 02:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbiHDANc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 3 Aug 2022 20:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbiHDANa (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 3 Aug 2022 20:13:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAF94B48D
        for <linux-btrfs@vger.kernel.org>; Wed,  3 Aug 2022 17:13:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 273Mw67s017807;
        Thu, 4 Aug 2022 00:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=g3zhjnhFLpEnqW56LWhYNT0z3rpc2vuqwoJcZp4QccQ=;
 b=dWUKGuCCiBHt43AMcLys58HmKbiLIkUaGrXmuY9SaM7+dy9zFVeiBO2RbAlMGI8vBTTk
 IPfeoaoTi575DRJ045S8nCQBsU3yHel4MF7fcHOLEpOkHU1onv3MdgpWzUrOWLS6kRso
 puFwOw0PROb0GDHx+zuZn11mGhSo3Davzrxh4xRCNgj/sfkWJPBl4NopiwjxrhN0ZCN1
 134kJV15ghGZZ0aSklUn9dQEeDWoeFXnOuW5L26gf6vnp0x3DA/4AflYk7q3EQsDN//r
 nPJsszOCL7QAjucPoG9C/XwAfkOVC1zHXbcb2AnAPAoHTdidWqT96oXEz5ynWKQUYklG /w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hmvh9u5jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 00:13:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 273M5l2H007344;
        Thu, 4 Aug 2022 00:13:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2042.outbound.protection.outlook.com [104.47.73.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hmu33h99r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Aug 2022 00:13:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axAMcrN9rEMlKG/G056ex6kDQsPb4LDVhCballzCxs27qKuoSvTT4yIPoSJjqgiw/uDHb1P4U/rDd4VEsycR3+QbTQvtWI9PVrXmUCRGlwYBvDgPkJUKvaRCge1uUrgseU/MuWVC2ny/pa4k/7GOyHM0yRtlyN3q4zTlxiVI4rRvPUq/vXdOSssQRReESQdn4KxVrzuIggHiRD2L2PvU0xPxU5H6q2VLtWTdL5v57dn9+JBHZLL5jpC82BlWr1jI6LUYMBtqt0cP6C5wbiPA4MsnPamRaP4uBFNrkwo5d8NcGENsvoqdM6QM6QI2C7so5oISpr1j70epDULv1r9QwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g3zhjnhFLpEnqW56LWhYNT0z3rpc2vuqwoJcZp4QccQ=;
 b=FPhWv1SNZIkSJN5wpLWeV9IhOMNaePZ0JLRC8RXRVrwFU16JcnDcDC5tyRo9I/fgSa9HsidfwilnPtxkBF/y9VNpSVNlYcBLEhXZcyxY9bLOwl2fPXPoXB/bbUbyX+XJi5o5slb5b/9BOiB86i7mrD60mOeRIDwTdXqgZiuQxXpkNIlvBUTaZ5F7+hGVxqG3Jh3OxTmpMi0AkrtQw2hEpCg1wX1sqwRQos/gX7kFXVk+ZZABcN9xH8V8TzeJtOjAXFV8iN+hrzpPhzw2QMTBf0Bk8GW3S/vzCtGWS/BH+J9TUohyCeBk/5rS+QHjAeUxuTVJWo6XsVuoDeGg2lEhUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g3zhjnhFLpEnqW56LWhYNT0z3rpc2vuqwoJcZp4QccQ=;
 b=qCGQuQDduhsPl9zG+LN0wfETSYruOfCLser/L3dAtOZ3qc5pxxuKCzhGJPT0CwMr2O4/r/SXyL5Dzl/TDVwlLSvSge/ZBtfRNVjGQ2NBYwx9xQgfqXgQ1b9pIAzn0IkvpYXWXdDnYcX+4qW0iWFPna7ih1MJg48bBlvdjei1ca0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB3451.namprd10.prod.outlook.com (2603:10b6:5:61::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 00:13:23 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%8]) with mapi id 15.20.5482.016; Thu, 4 Aug 2022
 00:13:23 +0000
Message-ID: <2dd1028c-3d20-3812-ad16-32959ad53aa0@oracle.com>
Date:   Thu, 4 Aug 2022 08:13:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] btrfs: sysfs: use sysfs_streq for string matching
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <20220802134628.3464-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220802134628.3464-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0193.apcprd06.prod.outlook.com (2603:1096:4:1::25)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40850ca2-2e73-4c40-08d1-08da75ae24e1
X-MS-TrafficTypeDiagnostic: DM6PR10MB3451:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 30tp5dLITxP3ATYrOiWwUsT1wolhKad0VUdMvX+RCToQ6fyhKjHCW4Aj1naVIWvkBVioUS1yLVZrOUWzwAtu+aokV9M4hy8F7N4z73YrKcH8s9/O9X1SkOckp/HdvcJb2qY1ribOnpaFuWoQBlV/vqk96YhgHAVmTM+2uhNqIpx1cQLDr4vXDvg6yuN9wSaAM9yR/ZP7sRsUbauy1JGunlObr4pnGJM1JsCSST3o9nVAAdVPJtQQ54sNlI6dA4u0KgNH3tdSrhy552sJechwL3IKl3Fwl9gooqc3t0CIKXoGLX6FmMBbQyhpPGXpsPnoslUwMPUJSEF7Tqi2ibZzmwRDBzshwMPRmrzeRo17BbTgJn5lhRnJs2CQiv9b/zkYDhbQRBMUXfxQHLbusdsBSuKRNh1XxVAuyqzDDQydpyJGllwKwbLTP1whtHDrzlnmcgNeLKdIihoaDv37vqokh2dUxzvnEWZ9r75Oc5zGI18+mMhHwDaQRRpNPWHUWGE08Y2tGJ1odLGhjPnsiDMVQeDrMWy4bYEnBNyFQRBbqVNVDSIOYhKDIBsn1tzLoN3o0Du7/Obtl6oGZtBJ53BfPTq/25lulPFOJBwUb5By0tTDA9OOpufpaaFpRvXHoJZOxh8+Phbfe9dBlvb2eoMSf2HCFYgIUFgHC8yrJcL/lgaFLylsU5KK1pbRZOoLXm+qIwOjZPX94Hugw6lqlrWUZDSfz7TmVuExcMerhqcn1JAL87Ta2sQgC/rxQjPd6nwwB0abHCdSe9wfYHHHdK3OWc3WnuAWbWD7JLGIePDwrKVB39uNoA8/m2M5hIFCJPgmz7tvVgGJpU8BjSCzW5m0KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(366004)(136003)(39860400002)(66476007)(8936002)(5660300002)(36756003)(2906002)(6486002)(8676002)(31686004)(66946007)(316002)(478600001)(86362001)(38100700002)(53546011)(26005)(6512007)(6666004)(66556008)(186003)(41300700001)(6506007)(31696002)(44832011)(83380400001)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azZDSGlwQkFvbmp5QUllNEgwZk5JMUpKbHBWSWlSb0NMOVg4ODNJcmo2blFp?=
 =?utf-8?B?MTk2R2pSNktMRjRvWktpQWpwUEtxWlR6eVRjalhsVmpHbWFGeVR6YjdqWWRm?=
 =?utf-8?B?RjBXbGtLdnRocUhRc3hqM2pGMDdRenp3QjFJMU9tRW9UbG01UExlenFQc0VG?=
 =?utf-8?B?U0FQQkpFYzVBOGt2cWt3MXV6dXJiMGZVMitzcitTNWtVeldySGhpckYwbzRL?=
 =?utf-8?B?M0pZY21xMVhsYjA5OGxxSmFQd2swTmJkeHJjVHdyZERjcVB4OEhFNDIrbHFW?=
 =?utf-8?B?TWtyZEpQckcvNFNhbk5MbGpWZWpUajVJRjkyUzRIbS9pbkw3WEpFRmFCZXRm?=
 =?utf-8?B?N1pLa3BUdktyREhVNEZhZDdVU0N3M2o0TXdhaHJPNStqaXRKOUNaZFdBY1pV?=
 =?utf-8?B?V1NpaFhocUdjZFd1T2JUNFV5NVVBczBPbkxPRFZMQVpLRjVCRXZSOFluM3Bo?=
 =?utf-8?B?Z2VjY3lmL2JveEJzZDV3aVZRRnhHRlo0NkhUaXRhaVoydWRxYWJ5ZGx2L1dn?=
 =?utf-8?B?WmVPVXZUVTJCWEJHTlNveFpVb0ErUWVIeTY0UEtmU1pFZ2RBZnJTYUNSVnJa?=
 =?utf-8?B?cnFDV21HOWQ1cFRac2M5SkRVekJ5Qnd5QWFrSmNzY3h1YmFranAvaTVsZFQr?=
 =?utf-8?B?UldkMEhpTFA3czBNbXovZEFVM2ZXQnBlWEVsaDF2a2pjUXh2RnUveUxYblEx?=
 =?utf-8?B?enRIclRmdkh4ZVJvTTQ0RHVSdTJ6VTZ6YnlHU0wvbHVYNWRucFVKR2xkSWhv?=
 =?utf-8?B?OFRqTC81S0NiQzVhZ0t4VmpyVHFNcTIwMGNlNVFkRHQ1STQ2YTdNZFVYcFdn?=
 =?utf-8?B?YXpYUEhIN0hDbkI1cDJlalNDcXRuR0Y0aDU2OC9yeE1ZbUJmOXVnT3BDeHVz?=
 =?utf-8?B?Znp6T2MxdHMrWURzYjk3S055NkdJUVM3SVM2V0grVUlHMnhMT1MxV205ZUFo?=
 =?utf-8?B?NTczWlU4V2Flakx3TkxqQXdlbHVGK3BrQ2trOTVNa0N1VzdXdmVQbGlrUWVH?=
 =?utf-8?B?TGN0Z0x4SGI0dTJFRXVhYXkxdjQwc1JsZWZuaHlYc0dyVGdZUVg1WFl1RHcw?=
 =?utf-8?B?RFBEWi9JckVaNWRMdkZqNkdXdTlYUWVrd01KZTQvakpFNVYvWmQ0Q216REJo?=
 =?utf-8?B?WjBJcExMSEREalRlaXB2dVpyazJvRXQrN1VzdmNKUFFEcEpCbHJ2bURYU25t?=
 =?utf-8?B?MGtVVWpMbHU1MzdEbWtIdk5mUmoyZXVFbENCYmk4c2ZUcjRrWjliTnlkNFh5?=
 =?utf-8?B?R2t2QndLd09TMXlqVE5RbTIvUUR1TFhhYlBjdDJ4ZTRSSTM5NVBudzloUGYw?=
 =?utf-8?B?WHZWOWhuS3B4Q3dGeWdEOFhMTGgzc0NLTnpsY3dmOFY5UVhlbk1TcW5QdEVL?=
 =?utf-8?B?eGVIM2J5OVZvWE9QbEY2M2FZK3Y5dG1OZTVtem5OejNsWnRvMlpiMDZ6T1hZ?=
 =?utf-8?B?RlpSeVE2MEFpOW43VEFyQkNod3Nha3JpRVM2aS9zQTVrTGtYQ3F5U0F3UWlW?=
 =?utf-8?B?OHE4L2s2WnNTUWNTc1hMMG00ZUtwZnFvMlBieitGR29BR2VCcXo5NWtTSkVa?=
 =?utf-8?B?RkF3YndBWVZMT2R1UVZaVkpYTEZrcUViUzJLTjN0UmtTcGg3eFkwbnVuMGc2?=
 =?utf-8?B?Q2syZTU3emhkS3pNLzNSbG5xd21mRldZaWZseGI1eThlZkhaeFc2SVd3WEtT?=
 =?utf-8?B?bFQxYmVjQzYreVY2Y3NrZEk0em01VWhMTVRVNFY3aFNxUHh0OXJId1B4RFVZ?=
 =?utf-8?B?TC9SUTA4dlBCMGpxR0xlMk5zWi9FcGx0czBLcG1tZ09hdWt5b3VpdWYxTXR1?=
 =?utf-8?B?YnlrU28zZUhmV0VneER6RlNxL2Y0Wk5uQXMxSjRMNktxSVlrZVRDUThMQzYw?=
 =?utf-8?B?Q3JzUFlEUGd6cWwxdi94QU1HaXp1ejNUNVBSeGVsSFZZSkluSHExTmNoNERJ?=
 =?utf-8?B?eHhhTFEybWgvcXhDTmE3bVBUa0lNMXJEZjlMRU1kQlF4S0tYQUJXcHovZUtI?=
 =?utf-8?B?SmdkZk1RRHUyaENmZTFqZzdvTWFVSmxodjBYRGgyYzJiNlNzMzQrRlJxbkZP?=
 =?utf-8?B?SHJVVnR4RVdTUGZiSDlEY3lRQWVldUVWUGlSdjNYUTdEZm9HQXdyQnU0WDRF?=
 =?utf-8?Q?mEeGLB8gAOttjFYnaM60r+6gw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40850ca2-2e73-4c40-08d1-08da75ae24e1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 00:13:23.3730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88giDxUZJMC6s0JDovXsiPzksCTUdZg0wvIkvmhIPecAyixMb4a7P/uZCjbUXI8KD5/d6yJZ/nTH20FyxH3r3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_07,2022-08-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2208030103
X-Proofpoint-ORIG-GUID: DOwjaA7oImAju7JxjDxk9IUrFv2ebPi2
X-Proofpoint-GUID: DOwjaA7oImAju7JxjDxk9IUrFv2ebPi2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/08/2022 21:46, David Sterba wrote:
> We have own string matching helper that duplicates what sysfs_streq
> does, with a slight difference that it skips initial whitespace. So far
> this is used for the drive allocation policy. The initial whitespace
> of written sysfs values should be rather discouraged and we should use a
> standard helper.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/sysfs.c | 21 +--------------------
>   1 file changed, 1 insertion(+), 20 deletions(-)
> 
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index 32714ef8e22b..84a992681801 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1150,25 +1150,6 @@ static ssize_t btrfs_generation_show(struct kobject *kobj,
>   }
>   BTRFS_ATTR(, generation, btrfs_generation_show);
>   
> -/*
> - * Look for an exact string @string in @buffer with possible leading or
> - * trailing whitespace
> - */
> -static bool strmatch(const char *buffer, const char *string)
> -{
> -	const size_t len = strlen(string);
> -
> -	/* Skip leading whitespace */
> -	buffer = skip_spaces(buffer);
> -
> -	/* Match entire string, check if the rest is whitespace or empty */
> -	if (strncmp(string, buffer, len) == 0 &&
> -	    strlen(skip_spaces(buffer + len)) == 0)
> -		return true;
> -
> -	return false;
> -}
> -
>   static const char * const btrfs_read_policy_name[] = { "pid" };
>   
>   static ssize_t btrfs_read_policy_show(struct kobject *kobj,
> @@ -1202,7 +1183,7 @@ static ssize_t btrfs_read_policy_store(struct kobject *kobj,
>   	int i;
>   
>   	for (i = 0; i < BTRFS_NR_READ_POLICY; i++) {
> -		if (strmatch(buf, btrfs_read_policy_name[i])) {
> +		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
>   			if (i != fs_devices->read_policy) {
>   				fs_devices->read_policy = i;
>   				btrfs_info(fs_devices->fs_info,

