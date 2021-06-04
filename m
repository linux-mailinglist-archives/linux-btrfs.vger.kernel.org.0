Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA2939B91F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Jun 2021 14:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhFDMj5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 4 Jun 2021 08:39:57 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37206 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhFDMj4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 4 Jun 2021 08:39:56 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154CZ94O163726;
        Fri, 4 Jun 2021 12:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nm3U3Q7RZ68+5g7Dq2wtyP+H/bb2zUAMyzbpoOTAugE=;
 b=wuQYu3a0sp8vRXNDBTRZ7NhvOqmx8wXvVvJ1tIDOb42PvfTXy2V+S+1wIDjHeE+RqmS7
 jal8lUYbxVWaGtUyf3JfimNRUgXu85AAq4klNO1fCD7Gy/o/LA3WW5oEvOLxMrYf1VM5
 e9kVOGaMnJu7i3Uas7cs2VcVaSh7Y8z1ZrFlpvRbZYy2CED6lNGpGZMQX8uwE7TTSgJu
 4EgJo4VzYWKCwuAs9i6HEdrrCpZFUXoJVuBqug5k1DV8vfPe51DftEAezNiBq6wkf1Lf
 XP/zjQA0ebI9OTRrjrKIjJyCOWpy71ArfCdRt9LTte24vekghvPF9RkciE1n1al3dGW3 jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38ub4cwwj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 12:38:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 154Ca8e1002158;
        Fri, 4 Jun 2021 12:38:06 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by userp3030.oracle.com with ESMTP id 38uar07f28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Jun 2021 12:38:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIQIrp1dQAkMKSPCyhJteNs8LWLvWbmXn4dsXKgF5hFl92E9QBtdlVEZWAvJWAgzyDuRXapESAFQZvdXAtKi2fQA9M8fhOPY3ax+GpqcII1FkSjrjLs29mfGQoq0IuK70IyjdkLgj9FYaU6CziqRp+6GNRd37opivr05TNBuNBig/HSzpOL4s+d1AUTkXQ4MKKsBO1ALjXjxcnz4xOs/yOA3GEt+fz5lgmd5bu5s4X4dAA0SPE9ud0/naXjS6Vuq1Jp92pVsfEKDtoNBGBDiYZWzXHP53wF+bAKVBfER0CQnvhCRNYe+XWn/LwzsZinFEQNHaQh+XqNUE34ybkn/Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm3U3Q7RZ68+5g7Dq2wtyP+H/bb2zUAMyzbpoOTAugE=;
 b=CSnJ3IhTG6q+SL+Vj9aRpQe0G6f6EfA9pV4Q5UX91xDIQH98Q/AFxDhbll1m+ssTjUV/tVoRpz1GNnTpSPrzLmAFNQ8if7gcY/h/f/1b4QTjzQLfnCOabU4df53mjJPTERMAMCc93gk6vDV2zhJ/WU8LsfdiuodNS5OfdpDpN1tV7sZ+ve4+RW/jtkc5CK5+TN3Kh4YuJ0y+1fLPe9mmFEPlZ07bbrXgL/tMJ0uRCLoP7VS0MUkpK3q0ciNPiuWb93XrACy5zCT7jsKiAVdtU2ri3W1ooOLnFoKLmIfiO8UibqtwIzu8jaB37d0x5mBLn8CxryVOaQaS+GHyLyg+Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nm3U3Q7RZ68+5g7Dq2wtyP+H/bb2zUAMyzbpoOTAugE=;
 b=Pb8JkuJtOFoRytspX+QxH4WOMBXHZEZvX25+PGcK4F2DiYAI36zha9J3iYJjRdJNXgYz9Qma874SWAqjUdPUpQXnfxLiKbDUQo6V3ZdhQuAuJqrfcC/9eHKTTLJP5bPD7uQX1zJZaYMkP95b0AFTcXAFdT/tz5OoYN5u35EfwKg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BL0PR10MB2916.namprd10.prod.outlook.com (2603:10b6:208:77::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 4 Jun
 2021 12:38:04 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::992c:4b34:d95:def8%7]) with mapi id 15.20.4195.025; Fri, 4 Jun 2021
 12:38:04 +0000
Subject: Re: [PATCH 2/4] btrfs: inline wait_current_trans_commit_start in its
 caller
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1622733245.git.dsterba@suse.com>
 <21a09105f7c7cc9bed5c565b32d3b37964806b82.1622733245.git.dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
Message-ID: <c704ada7-53e5-49e4-d399-84ac4b7f7aff@oracle.com>
Date:   Fri, 4 Jun 2021 20:37:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
In-Reply-To: <21a09105f7c7cc9bed5c565b32d3b37964806b82.1622733245.git.dsterba@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [39.109.186.25]
X-ClientProxiedBy: SG2PR03CA0091.apcprd03.prod.outlook.com
 (2603:1096:4:7c::19) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.137] (39.109.186.25) by SG2PR03CA0091.apcprd03.prod.outlook.com (2603:1096:4:7c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend Transport; Fri, 4 Jun 2021 12:38:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21203678-c464-4559-aad9-08d9275598b8
X-MS-TrafficTypeDiagnostic: BL0PR10MB2916:
X-Microsoft-Antispam-PRVS: <BL0PR10MB2916457B3924AC62EC364530E53B9@BL0PR10MB2916.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IB8NoKZLJiIShBoCzzASKNaKUx8U68SrHTfUit8+bf7GnX75gr0asujsHnfH9p7GE6H6ICjPmYrELbpHU331Km975yX1pNa6VuqpYEg57MXkLDvu8sKASHonjSYEcM/KTKA4moQ5feJg+LTkniMnAgTHSWbzCYJFeUlCo1LPRfIAJusMrR3VVvnH9v87hymU1EXQDxgCgshZhhM5Vk9SZ/wH5ovbYNpXTKegYd+AZhHHIvHZuS/RGolcRD7JlQjtPnmY2PLTH9JE778dYxp6ODYRAn7f6lrbmMDla1XEMxe5Z8mBNTlPhLO5BtG1c6AFhxavHN8YZ10cC4ugl6jjMHz0nwjdpgo63rfH5/+1aiFtbSxwYB57KeC0GfFwiI4pmiFwR9JLPn83H0c1BI2TzLERwZp37uSUmAzEEdrObivpWEVp8trRSLZ77Q0yFEAhtrTtC54uo78HdLBO2CmIc+Pbe9rvnfaYU6IFAkmD+4ydyd+w+PlTJ2zoo6fQ0E+eb4O2pplhNF2+UlXNiNtMmlHrrA7Kfu2mghdf+o2WkUnf6C/YYqAUsDOJGniflxfEULFROje2A9UK621pJ3pvCQQP2zbQAZtjQcO3IdAdqfvD74hAIjrfkGuN2YNY73mzvr29ITf13X2cSjA+WHVg/TuZ698JdYX6zTa6sfdB/bUxQiBp41a467y7Li+0vEqH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(31686004)(16576012)(38100700002)(186003)(16526019)(2906002)(86362001)(31696002)(6486002)(83380400001)(36756003)(53546011)(956004)(2616005)(66556008)(66476007)(8936002)(66946007)(26005)(8676002)(44832011)(5660300002)(498600001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OVZxbWZoVGNFU2NodlVuNWRXRTR1aThiRzVpWFBuSERCcU1LK2UxWFVGZ1E5?=
 =?utf-8?B?TFBlYzdsbFV4WjdTbjQvY3RDdkJQc2U0WG5XSkdTVHBjTWEvMGJIOWZpdEd2?=
 =?utf-8?B?NEk0ZFVHYWRZeGMwNHVTNG1xZVhKSjVrd1E4dEJUYXVRREhJZXpPaUZkZSt1?=
 =?utf-8?B?bUdSTFNQajFTNU95K1RxY0xiNVdIQVZTcW5sRVpGdXJ5dFQ0MThhOS8xWE5R?=
 =?utf-8?B?TDVJVktsejJ3ckxDSExYcWVvZ0RFeXpzSDFaS3RxZS9aVjFSYTkySGRhNjd2?=
 =?utf-8?B?Y3FyNVVJWENaNDIwcnkxcWwrcjY3YmhaSXFjOFRUZEhoVm1wRzdZQmczQ3ph?=
 =?utf-8?B?SENnRWlJWmZqVUxuQ0RvWittcndsV2FPbFB6NEpqMmpWQnFCbEdMTEZQZFJI?=
 =?utf-8?B?QlpFU2hqa0poTlk0cFZSeG8wS09pNTZiVlUrQXhUWTlkckcrd0lCSW9rL3NH?=
 =?utf-8?B?M3RqVU5RM3NPdDl5RytDTlFDT0ZsYXlIM2tMSE85clhEbkNNb3p5TjVFUEJJ?=
 =?utf-8?B?U0NCeWRrT0dCWUtaTzJJTGNmbnJrTXpsMDZZK0k4cXpxZWRWdXExMU0rWWM5?=
 =?utf-8?B?ZzFya0lYYjRFQkpkTWdvL3pscXFITmRjMnFjVWF0dkhMYzJBc3hPeTB3cTJx?=
 =?utf-8?B?S3NvanpSZjUzc2Z3bEpqVVNSUGdGSHJnL1NtWHQyUkF2a1k3dUwxR3dxbWIy?=
 =?utf-8?B?MFJEUDJqbjRmZ0RvQktwSGR3UHR4WmVXbjNLaTQzRG1xRlRiUXFFQjdCU1lG?=
 =?utf-8?B?YmI3YTFnTlNpRExZeE5xcVR2TGh1V2p0S2tsN0piMXloVkJ1cElkWmxwVTdq?=
 =?utf-8?B?VDVzOUthNDk4YzRTVGFSdDhTcDNxWXFxYy9aWUVUTUx5RmpGa0cwbWhUeDBi?=
 =?utf-8?B?Mzd5Mm50cTlLUjljbmhkODE3eUtZN3NmUFNnWERZMXFzU1pKUTdicFdlZFc0?=
 =?utf-8?B?YTNyM05TeG1tdWJHVVcxd0pHOTMwTEsvemxqVzBsdTJJNitPaFVaKzRkTXRx?=
 =?utf-8?B?MjBFWWc4cmhlYmZjaWxmYUxuQVRyempvTXZwOHJmYUxXZDhOcjVZSXg5MTdL?=
 =?utf-8?B?d2hHMGFmb3VGa2loVUNvMEN1cFJOcy83TjZNOTRGaTlDV1poeFdIdE00akd1?=
 =?utf-8?B?bGw1V1U5cnJBTUpxRTdmVXc1R1VjbCtkcjJCNFozVGJTcGF4aHNycnNTVnFx?=
 =?utf-8?B?eTkwMnpvWWRidFNOOXNkVG9xVjV0T0ptaVk0Z2crSTJQaDVSSnFuZGk2Y0Fw?=
 =?utf-8?B?dFRvS2xQeWRSUWNFTnhYTS94VjVudnpQU0JjUFRqQnBjR2Q4NE9VcG56MCtw?=
 =?utf-8?B?dll0YjFjdU91enNocE9MZVZDK2U4UDUxR1Bzc2g0YWpMdFRFL2tZN0tJaVFj?=
 =?utf-8?B?RUU2S0o2a0VyOFdLS0NENWVEY1pEL1hrWVdxbUFPSW85TDZ0cG1oQWJ6dVpH?=
 =?utf-8?B?ZkpyZXY0KzE0TXRneEpYT3JYeGUyWEwvOVU5UzI1dmp1aVNGdG9OK00wc2Za?=
 =?utf-8?B?ZGF2bjNUUm9OZERCUU1VdHNBb3lOc1Vic3krVklZZGdwQnN2QWE0RzMvei8v?=
 =?utf-8?B?VGVHQURrN1d0T2VJTlpmakJ2OFR3Qkt4cmR5dVo4L1lGZnJsVU00WHgxOTBV?=
 =?utf-8?B?Vkt3RXYxaStkT01jcXBWRW10WjJPTks1VHJIVDJvay9FcUlUN2ZkRTJHS1FJ?=
 =?utf-8?B?cDRCcUFNRGtFUHJ0Mjc3MDRDVHZaNEdyZENlZ29QU0lVaS83N0g4dGwxWjNy?=
 =?utf-8?Q?M6KPML1Sq7Wm1IA6qkeiYorcxLSAAyYBS+LMFz/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21203678-c464-4559-aad9-08d9275598b8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 12:38:04.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmHGlgPqNYz1HEDfBH01cBGo4dz51XaGJ/YaqsFPxaRobBkn83p4LwWqCc73I9zcTDFwBgi9yYi8VhfZXinVEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2916
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106040099
X-Proofpoint-GUID: yOgSkZzYOMfRnDUgnogwkOJXUzQCPktw
X-Proofpoint-ORIG-GUID: yOgSkZzYOMfRnDUgnogwkOJXUzQCPktw
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10004 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106040099
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/6/21 11:20 pm, David Sterba wrote:
> Function wait_current_trans_commit_start is now fairly trivial so it can
> be inlined in its only caller.
> 
> Signed-off-by: David Sterba <dsterba@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand

> ---
>   fs/btrfs/transaction.c | 20 +++++++-------------
>   1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
> index 30347e660027..73df8b81496e 100644
> --- a/fs/btrfs/transaction.c
> +++ b/fs/btrfs/transaction.c
> @@ -1870,18 +1870,6 @@ int btrfs_transaction_blocked(struct btrfs_fs_info *info)
>   	return ret;
>   }
>   
> -/*
> - * wait for the current transaction commit to start and block subsequent
> - * transaction joins
> - */
> -static void wait_current_trans_commit_start(struct btrfs_fs_info *fs_info,
> -					    struct btrfs_transaction *trans)
> -{
> -	wait_event(fs_info->transaction_blocked_wait,
> -		   trans->state >= TRANS_STATE_COMMIT_START ||
> -		   TRANS_ABORTED(trans));
> -}
> -
>   /*
>    * commit transactions asynchronously. once btrfs_commit_transaction_async
>    * returns, any subsequent transaction will not be allowed to join.
> @@ -1941,7 +1929,13 @@ int btrfs_commit_transaction_async(struct btrfs_trans_handle *trans)
>   		__sb_writers_release(fs_info->sb, SB_FREEZE_FS);
>   
>   	schedule_work(&ac->work);
> -	wait_current_trans_commit_start(fs_info, cur_trans);
> +	/*
> +	 * Wait for the current transaction commit to start and block
> +	 * subsequent transaction joins
> +	 */
> +	wait_event(fs_info->transaction_blocked_wait,
> +		   cur_trans->state >= TRANS_STATE_COMMIT_START ||
> +		   TRANS_ABORTED(cur_trans));
>   	if (current->journal_info == trans)
>   		current->journal_info = NULL;
>   
> 

