Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0F2509F04
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 13:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382575AbiDULye (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 07:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiDULyd (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 07:54:33 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB8A2CC9D
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 04:51:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LBEoJ4011972;
        Thu, 21 Apr 2022 11:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=WNKzQY/n+8tIw4MCl4Xn/5jp0t7QFNMrAPicW0I9om0=;
 b=y3e/RgxIe84I3S62b5GZoE1mm3sgyPQeHYJjw9iiavvAn/AFxdbsy+K+wKXL4z9pMObT
 Cgh5K7dI8sLwMqFxsOZNtQXASyVmt5ITfqZv5qlzOcO3pKHP9zMAZqJmmiSdifFUQ56z
 //Zg7RRkAyXXV51Bl0bMDBzirG6YW6V9XoSoDke2TQC3dIKcQRFt9sA1nDdyShCGwX1t
 IKWNuuFaXRWJAt7eqlMH+mTk/dA1rGu9yNWWegQa0sMeY5CnD8rNw7cbohZtTKrvj+O/
 XSbMEpm6QIgvQbrmzSICtWswrkFVX19UYZ7MNliIt/67+rZZQJ5XczwUVZgxZnM24w2j 4g== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffpbvc0a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 11:51:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23LBjrCX024744;
        Thu, 21 Apr 2022 11:51:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm8anfud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 11:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDH8F+jrygRvi+GK4YYTxCLDY4cUHMl6as+gnSd8I9jHYvJp39/WUdxssQwdAlTicscKYdbFSh+92LFHN2cTEtPDpWOPdxEFpP1nYvkvdc6GouDlMcFmG+abcA6n32Clowdcj9gPeJu3FjZ+jDD71UsWG8SQPUO9GWLJpKt5GHeMUfKs+GWCKmt/80/OTjsppyWvLdJJZSsOVVo9vuN2+nM55tN54Q/f+RKhpmKjrCqgPN38lVIeAt0GMfOL1v6k8uzEdgWSrx2V7LiwYSBZtaIpjF5Pr3J7vOH9tSWx+7pkUV4nengfEOIYH6077mDrwXVNJQlUz1k5neUsQcXddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNKzQY/n+8tIw4MCl4Xn/5jp0t7QFNMrAPicW0I9om0=;
 b=leA18TCYa+U/PLTERbUvCnd45XOOhaXvMAQL8w/ufHeXkKB/IW6DZGRsz+mNQaz3nx5q469G8XmEBaPldwuatawM5+E9dFQjmid/5QDHb36s8Vq6Xd27OT7xxZiltyFLjmd4ZbtKhOverhtgsMjoD2Jg9c38oSbwqI3GDJNctupUfGG6AIjwzuKAzSBca/WJaHKoUPteHI60nM6Oi83weB4lU4/6UnwG2sXMCBqzoS9xg0k6XyculCL4nDE1V+oPQT5MHZM5C1520iL1PgbSKUMwZAE2th19a6T4WvW+emNw8LwSy97NIbQJY+eYHdi70qO0VD1jDH0MTZimzIyrJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNKzQY/n+8tIw4MCl4Xn/5jp0t7QFNMrAPicW0I9om0=;
 b=yxA+pw4AcWW/J+uiIIUuAe5FKO36xwVD2lPZQ7dj7bow1NQWTqQTQ+JG/x0uG5Kb9QlJXKUgs7bQr9nbLSgEoMLFoWmsGk9mLvX3lvWo2e7/KTX+qmRvCABHiWP+ajSbPCcTInhgEHR1b1Dt/pmaLXZNB8HAtOFWCU8o+Nxtxo0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB4584.namprd10.prod.outlook.com (2603:10b6:510:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 11:51:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%9]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 11:51:38 +0000
Message-ID: <93c95b82-148b-6fd0-a1a3-bf735e91c145@oracle.com>
Date:   Thu, 21 Apr 2022 19:51:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] btrfs: do not BUG_ON() on failure to update inode when
 setting xattr
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <bf2fb575bc7b960b925693b9d64a802f4c477fc3.1650535321.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <bf2fb575bc7b960b925693b9d64a802f4c477fc3.1650535321.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0d26c64-8467-49cf-80ce-08da238d4aee
X-MS-TrafficTypeDiagnostic: PH0PR10MB4584:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB4584048A7F866970958344EEE5F49@PH0PR10MB4584.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WZRXRlPfJnlKp6cdDL4pgcoFlBewqmum9Aoa7x1XxeaDC9uny1HUwmfoGzRU3l3Jls3pJRk7z4rTNr35VanGYMVNc68ipekWEYvx5QQ4LFEog/H08kj0qxR9GM9v6kKGPkrwYQX69QmqDMcqMWpnLP2IfpdwtNqlhSdFbag5Dy3PhTALUUbB3P2fkgE9WoMFpsx+AMW5kA8LHE6p4muw+lK62tUqVG6jwIU2xvlfqAyGIhQGcShw6qu+A7hh/sVv/YmGixc2r28cPTI/wcmrb0fWPu22aHRACnbzANvyg2rO3VDLVuu82b+82ygAteug4z6fvaDLR5ndz7B2QCbIsG7VZVNBf/GYEeTWPJsgHH/WUM7MPT7eJKy7MTilo49TFisAEYjFRFipm64X0aZAx3mvhUBBf/MccP1vHRawkIF2PijMbWux+bdLoOQov/TkaJLpBO7+zGwwfkI/KcEw55o4jnccAsovyz70NnslRykqV5bWtGt27tCLTfrOrbz094u1VIHwEJ2WKNF/yvrF2JcoY3NR5hwQ7I+DxO4i/2bXPJ4Xomczkxa7iWsfq5b9xZhX0z0YQXisQHKZGZi6PL2gdvmnoF3boFLlvKkzII4wRTJT27UuM/qSGyU6AvJZ6BEpEvjzIL42+n6Ux0dPNjhW4bp3G/Kuix+Jqz32HEeT3AwQZAR+oWsYC86XUWZcH7CvqseoJZfDAmBuhEYQt5Wxd7JpBytNe0IKYNGmT3o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(38100700002)(83380400001)(316002)(508600001)(8936002)(31686004)(66556008)(6666004)(44832011)(66946007)(8676002)(2616005)(2906002)(66476007)(86362001)(53546011)(31696002)(6506007)(15650500001)(6512007)(186003)(26005)(6486002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWE1VHo1Wit2bHJqK0JLUTR0YVVYY3JmTHZXZ1Z3RUdqWWphVHdJaVg3WDl2?=
 =?utf-8?B?RURqYUtoOXJEa3kzTzFMNTNydU40VjhLQ0FWQkMydjdScEt2dDNNeXk0WG1t?=
 =?utf-8?B?S1N6SEg3dGVaT1BJY0RBaFd3dDg0NHE4Nit2eDFiZTFLQnk1M1V3REtKNWFE?=
 =?utf-8?B?clpXRkI0TVFWSEtKdjlxS25GLyttRnIyUGRqQjR5cEtUV21kTWhLNjllL0h6?=
 =?utf-8?B?V2txY0Q0VEtzNHdzaGZWQ0wwenVaTVBQN2JNWExnTVlGU2NVcFgyNXdtYWls?=
 =?utf-8?B?YzFCMTIvYk02SGRCeEtjTjRJQ3JlR2tjOGlKOG80VlpJbHJvZkJaZGlhMHV3?=
 =?utf-8?B?OUJaL1hHNmFWSFV3cHlPK041NXRLM3BBYmRhUjJ5V2FwVllmcjV1YW8ycUYv?=
 =?utf-8?B?RWpOMUpmeDZjUTJvem9JS1hOMG4yd0xOa1V0UEZzOWVMS0dKcTN5dXEweEor?=
 =?utf-8?B?WXhrY3lLTGV0ckZvMkRrbjBjSEVhY2lwc1JYRFZLTk9IK1pDejRMVm05MkR3?=
 =?utf-8?B?ZXhmNDBSK3hoU1RXQll4bDBLYWhCaXQrU3hPK2dsVFlqbEhnUlpmWWdaWEtx?=
 =?utf-8?B?YkNmU1pnT2djSE9RaXAxQk5SdGl5dTFJV3UyVEdVSDBoWHpYTWdwd2FYNlNo?=
 =?utf-8?B?bnZWNnR5NDlqNUVhcnczRXY5MnZHU2F6VVd0TGdzc1REVDd4ZFBSYSt5V3Ru?=
 =?utf-8?B?QVd1RXJhOG43NHVkQkI1bXhGR2pPYXcram1Va3VsOCtjK1NPaXd5R3pKSE8w?=
 =?utf-8?B?UGlFcWxKbzBYR2U5ek9BeUY1ZHFrSkwwL0czVjBCbHE5VXJDMXlWbXd4UGhI?=
 =?utf-8?B?TklxTzRkdWNNUm9JSzZxbTJ0RTU2QTIrOUVtWHAxbTNYVzJ6UTMxSC9lUkNL?=
 =?utf-8?B?UTRDcnVLRytXYTNNWmF3Yk43d0NXSlRWamlVdEU0MXBJbktyTERuaE9xSEtv?=
 =?utf-8?B?QWh4ZUFCQ3M0LzYrVFdWS0JqVldkc0loaUp4aEs5TW1Pa2FlakJWMHU2eUZ4?=
 =?utf-8?B?dUx6THJsTm9odmxQY2JnMWc3S3pzaXl2Snk2MVd3OGwveFp6WXBDSnZ5bTh2?=
 =?utf-8?B?QzcvbGdUZzFsR0NXM0l0RmxlbUdRZjZUcG84VFFicUFnUHFxd0FZV3B5em9U?=
 =?utf-8?B?V0R0NTVpNERFRlJnN243S0lTTFVHSlluKzdkYm9PVkJKa0xoaEY4MEVIc0Ny?=
 =?utf-8?B?Z25lRTBNR3BiMVhJdlNCZUxHdmM2TGY5eUt1Y3ZsVEcwdi9LNzhlQVZYS21E?=
 =?utf-8?B?T010U3NxYldVTmFjK25Wc0NmcWlaNzlmdXQ0MnpUa1hNREVMVVhSVGlydUVX?=
 =?utf-8?B?STNqVW9Cd2xHS1dGL1ZYV3MzRHAwRmZGbFN2dm5Xa3Q4d0NqcXVyTytJUGxU?=
 =?utf-8?B?NXphUms4WmlxTkRFcTA5UFhoSExwd3dSQjUzTHZKNXF3M2x6d0MyTWJQcm5m?=
 =?utf-8?B?SkZJQkM0Mm54OWlTalVvRTFyMjZxU3FmSXFNbXBXdHFhanJhVkczdjN6bS9T?=
 =?utf-8?B?cWYvZUM0Qis2UFNUNHN5K2psWEVnaXd1S1daUHE3bXJBRjJvbHZFRStydjJD?=
 =?utf-8?B?clNZSEtUbFFxemZHKzUySDRYbUdtUFAvZnYwNkQwMEtNajh4dUpOazVydG5M?=
 =?utf-8?B?YWlBTmJteTZuSUFPZzRiWjVLNHVuRFBzMU1qeHNhcWtJMlh2Wlk4WWxqaGhz?=
 =?utf-8?B?cERUSlNrK2szdG9MWkNGN0FnOXllVy9nSS91ajZMa1c3UHNPS29HbVA3R1R4?=
 =?utf-8?B?Y281QS9zMkZmcFkyMW92Yjl3QTVBa3dUZUliVXFabExMQzlhTGZldTN5ZU5l?=
 =?utf-8?B?QkpFaVd1a25xVWRkUEE1T0dzTkxTSWIwN3JyQjRlUHdVZWZhb215UTNONkFp?=
 =?utf-8?B?S01iTllEcW9hZFU0Y0R1SUpXOVdVNjZIVFY5ZGp3Tit0aGVWV2JVNFNZOTY3?=
 =?utf-8?B?VSszTzBaNUJSVys0TTFJQjlwZStOQ3pkZGdhQ0pjaXI0dlFMNjZpUjBsNjhF?=
 =?utf-8?B?UlRVKzRsSVFqT2d2K2VzSEljNlllMHVYQU56VkNmdm04cXUvUEQ1SGJHUStU?=
 =?utf-8?B?TVo5a1M2aGIrdlBJcFIyODRJU1ZXY1ZRVkdQeHBZTmtyU21sSC9tTnZFaDNn?=
 =?utf-8?B?VlBFTU1XY3FscUJiYU0zREtUdkVvT3lBaVNSbVgvQ2dXWExOUHhyQ1BFak1Y?=
 =?utf-8?B?WXcyNDViZ3NGdnRDMG15a2ZjbHFDMng5aEdWNDhoaWVKdDR0TjRDYlc1dmlP?=
 =?utf-8?B?TktoSEZsZHZES1hWNnNaQzBhdTdsU0dPUDlmNHZzTHlOamU3dGhmcU5oVkVn?=
 =?utf-8?B?SE44VWgvK3dlN1VVSGlpYUdwQmNSSExNVFF4NS9qUUdacXZCSU8rdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0d26c64-8467-49cf-80ce-08da238d4aee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 11:51:38.4757
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zpANGrqlhlNO7kO3nTMIGq9rUqRxv0CpWPLVg6AH0g7mG5+YxEcutnYmTYZN2l1DJz1zx4a9dhhQYw6l1kBvzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4584
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-21_01:2022-04-21,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204210065
X-Proofpoint-GUID: JbxkFVYFCJ9g4aU8IDSs9jCH1XEvb_a8
X-Proofpoint-ORIG-GUID: JbxkFVYFCJ9g4aU8IDSs9jCH1XEvb_a8
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/2022 18:03, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> We are doing a BUG_ON() if we fail to update an inode after setting (or
> clearing) a xattr, but there's really no reason to not instead simply
> abort the transaction and return the error to the caller. This should be
> a rare error because we have previously reserved enough metadata space to
> update the inode and the delayed inode should have already been setup, so
> an -ENOSPC or -ENOMEM, which are the possible errors, are very unlikely to
> happen.
> 
> So replace the BUG_ON()s with a transaction abort.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/xattr.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index f9d22ff3567f..4a2a5cb1c202 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -262,7 +262,8 @@ int btrfs_setxattr_trans(struct inode *inode, const char *name,
>   	inode_inc_iversion(inode);
>   	inode->i_ctime = current_time(inode);
>   	ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
> -	BUG_ON(ret);
> +	if (ret)
> +		btrfs_abort_transaction(trans, ret);
>   out:
>   	if (start_trans)
>   		btrfs_end_transaction(trans);
> @@ -401,7 +402,8 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
>   		inode_inc_iversion(inode);
>   		inode->i_ctime = current_time(inode);
>   		ret = btrfs_update_inode(trans, root, BTRFS_I(inode));
> -		BUG_ON(ret);
> +		if (ret)
> +			btrfs_abort_transaction(trans, ret);
>   	}
>   
>   	btrfs_end_transaction(trans);


Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks, Anand
