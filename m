Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3351537321
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 May 2022 02:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiE3ApK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 29 May 2022 20:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiE3ApJ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 29 May 2022 20:45:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425BC1D307;
        Sun, 29 May 2022 17:45:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24TLql2r019990;
        Mon, 30 May 2022 00:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=31oIBYHtRcdVmQJo45kyVsmhpAaJwuJDtml6LJU9yTk=;
 b=Q8X1M9HRvfkVOrZB8NsnIPrt5v2T/1y7VCg29TK21CjWsazQU79iRQ+vKdvukZEXptYI
 ljXhNzplWLEBYcAXLqgQ6shySWK6IQfoA6pSOdvk4MYPt36Yin/62H2pwMWXsfLid7da
 Hs5q+ZDY7HgKLfBF9TZdavbUQkEBi7v0v4dp1eNZvtoV/zpmZSdbpZdhYnk/xq2KqyFF
 9KHSsrvscFaS7BvfT7WhGnwcK6azsiUMhgdqSKjBqzMoJCCwdbdiR6SCQ+ujFEeIT05H
 yd50kFwmrgzlTVJWoEgMDVqVMZ+MAoR1nuetcyb41a6pAAI6gQMROB0qLpGZ0FhAEo+W 4w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbc4xhsar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:45:03 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24U0fLCk036876;
        Mon, 30 May 2022 00:45:03 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gc8jvqwvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 May 2022 00:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLDlsnmHjS45vw6CFTeNKTfTZ05Nb5DGq7DmFzQrJu7LBLuGTmjyMEo6rF33bcle+DmRpive2vP2xfauaXd0280/RcSFeb7hDNPDbVDs5GPU/TgQ9Enksn+c67hMzgxV2F+2XrXLB4Yg0Rk0+sHuMyTgqQTbPhwW0xIPjy0LbMh23jvTfU0YSpx97dDmPF01fpIZm4HM0kqHmIrCi72+LX+GqCu0ncwmsTS2fHa4t+qTw4RvFdIYknQ7pVygiPs3FcAldjpfxVp18cVoN5nBcKIGXuRWvvID19Ugde+yj7wmWZ6FR/81OS2PD2zNdsOVW57hgICyQXW0Mu8STSp84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31oIBYHtRcdVmQJo45kyVsmhpAaJwuJDtml6LJU9yTk=;
 b=WzznWCixKR0+BLIR8W+HZ5Vpoq35xkAMR2TydSsKPsBILNhBlX28d/anp6rD4NM8GLAG2UpmvXheNStw5kk5YTbHCL8Jyq7Nc9iQBSWIk+x3w4LD7Le5rExjgI50DbcecH4J9tL00OSr8U6gquxmZLT2WLN8TY9Q0Yhg0ovUWdsiFOMgvwy+m291w5ERrkkXEAd927Y1ptZshgW9F3vfR7XHtY099YpYGHljdC/A9flP6tJzbDwnnI8GcfM01Z2GinxWRoo5xG8enoizEAKdi5EUcGHrZOq5Mqxza8gCwnH5kneyu0korQNWeU4mAx0jMlqlP5TOfiCiePS22XrXwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31oIBYHtRcdVmQJo45kyVsmhpAaJwuJDtml6LJU9yTk=;
 b=SG4H7ZqjBFo0cshRfQ228/KWR6X+jYNzEoDcVM0H8lD+zy3phGcv+x3M+/cYH9BsPV2LONN/O/7oYMKzQNY3kl9UJV14LyldAfT9LaLHwPEXT7s+QS8W1qlbs5UxiCklBgM2ezkfNz2YIGpBBc96l7ZmzIHgDau3hPtO7IUNzVA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4681.namprd10.prod.outlook.com (2603:10b6:806:fb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 00:45:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::5cd0:c06e:f0e0:784f%3]) with mapi id 15.20.5293.018; Mon, 30 May 2022
 00:45:01 +0000
Message-ID: <5b08b4a6-f4e5-9143-9646-19079f49675a@oracle.com>
Date:   Mon, 30 May 2022 06:14:51 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 07/10] btrfs/215: use _btrfs_get_first_logical
To:     Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20220527081915.2024853-1-hch@lst.de>
 <20220527081915.2024853-8-hch@lst.de>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220527081915.2024853-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0030.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7ac6f0c-87b3-45bc-ab07-08da41d5a10e
X-MS-TrafficTypeDiagnostic: SA2PR10MB4681:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4681FEA47AC2093963BCB359E5DD9@SA2PR10MB4681.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJo6by5Z2GonoacYYF3Vyi0fRjhfUKwzDlHcWVOQ68hxQSebLgB2sFN3wdnJlAL4gPCiAuESvwe+VpYbMwVjghsLMMVBeUGCGlrDs6KXblmsIBV8XNP2KzbzyDcnY7RLifzk5vE6r6eFqVAuS0XNGV+Hrhs9jWC6vJjPHwhXrXiaPxADwROVTIEjbwGOvV6GIHaJ198hoDrVQsfCqb3S1K9pY+Wrkdiuelf2RT1A7atnCPqg+h2XZNsmpvZxrXnvRj8Dl2nk2J6FVhWiXmUpC4xhgwYi3RgJFUL8QKbfA6Y24CeBDeX2be4uBWGKn0dgzkJ2CmYL4k3OUYTaZWIdiif5bGPaPepRfZV0OMnVWC76jzVE+TlyBiiKUaxzJb0wcFQNK03z/c/h5wsQAttNURpWzad/rxju2jDJmmiIYmoS15HUGO+sLdJ8vd5d18tRFYctTI3mZZzPTZupYZu5YtN5Q+3NXdLyyk020GVNljOUeamVTsTV0z7yc1Agd9ohcxkt2aYpiwCLvVn0pyE3iVPCbD9sMfuvnPRkLJBlFwMtCyq34g+MZMng+E8lKRc1fccPjthzLgUQOkP7k4BcCQYJd/GhmaBPBcf2VXJHVfXW7q+Ce/2K8mfaWPrMPohYu+zO2f39R41l3iJ9evHGjqE3CJJqftpxxayAP00GOUkXO14DuzjUawxkDtZad+zkZFmJqzAGyiPZ3eVcX2LPD1hb8NoOoQ9yEA90XHqSuFg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(5660300002)(66476007)(66556008)(4326008)(8676002)(6486002)(186003)(83380400001)(508600001)(31696002)(86362001)(8936002)(6512007)(38100700002)(4744005)(2616005)(53546011)(6506007)(44832011)(6666004)(2906002)(36756003)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBGRDlyREpTL3krSXB6cHo3RjUzUnJFM3cxaFl0TDRCdE1ib0w5Q2FQblVi?=
 =?utf-8?B?V2REd0JuSXFPSWJKM3psQW9XckkxalNrV3d0ZzJrUHMzZXVJS1JOOHh1Y3F1?=
 =?utf-8?B?Q0M2TlFWQTdnTTd0WWhIVEtmV1J0YW5rbDBNVHlnakZPYi9EZXJmbFU4aUJG?=
 =?utf-8?B?K3N5Q25oLzhpUkJJdHAvRHlSZUlscEhFUkpmUy95N1doVkdtclhDa29MTTU2?=
 =?utf-8?B?bnYvcDBENXBSVnZzTXI2V01wc3g1c0tFS3ZOQXQzWTUzakljb2NCU1pGOTk3?=
 =?utf-8?B?cmpseGdGS1VQU2FVZkl4V0NsbUcxVG84dVVqQjZrVTFiczdOTm5UNmZYNHlr?=
 =?utf-8?B?Tk4xZlE5REdpeDVncDZHbEVCc3ZwK1o4MlcybXcyaTNPbWdHZmNiMmozWjVY?=
 =?utf-8?B?WkVvSm5HaFNDRW5tNDNrQ0tTZFpzQkdZUzMwdmRzbnZiYWVzWUVJMzlrb0lo?=
 =?utf-8?B?d21hbVQ5VkxEb1haTFY5NU94cHRhTFpBSnhHUCtQWC9Ra0VpNXpSZ2I3cW9a?=
 =?utf-8?B?S1V5QVEyZll5Mk8xMnJlSHE0MkthRG1JRUpGdm5kL2w5Q3o2VzNpdmhKNWt2?=
 =?utf-8?B?anhWRlRMZmdUckc4dE5YUWIwRW15ZURrQUdxa0RON1FJV1hQYUJGOWtnWUZq?=
 =?utf-8?B?eEFsSm9BaWQ1dGNGUEx6QUhvbFBSSStBRk5ac0U5VG1KUUsyNUxYMG9DdURZ?=
 =?utf-8?B?NEg4QUZDSW9MeThwZzg5cWJpUy9yVW85eG9sNGxnM1EvQW9Fb0lYM3lvR0Zr?=
 =?utf-8?B?MlkyN1NwNUdNMEZQU3dZWUFVY3dZYUdjNlNkVkJVd29vL0I2WktnQy9xeGNo?=
 =?utf-8?B?dEt2UnJCNjJOZ25panpIQVQ1NUdBNFNHWlR2V1VjOU5QVjJCWmU3NVhvdXZo?=
 =?utf-8?B?aWxET3RHeDVpOURkRGZMaU5KbktLUnNJMDNXVFhzRDQwUFI1end6b0JjQnNZ?=
 =?utf-8?B?UUlZdHI5d0ZnSXY1UkxKWTVWU0ZhZjVSSktJaHp0YzdoTFhzU1UwTFNNMWJF?=
 =?utf-8?B?bm5mbFlxMnF2enlKL0VxRWRSSFYzYkR6b3RVOUtsN0cyUG5GTllVd1pvWkFB?=
 =?utf-8?B?L3RKWmYrM1BJVWJCQlQ5V25Gc0ZKQk4zUWIrVlo4eThDRVM1U1RGY1JheVox?=
 =?utf-8?B?T0NxMDVWdWlDejVrU2lkSWxuck1tbXVhNEFGNE56NXBpMitnU3FnL0Z2L3ZZ?=
 =?utf-8?B?Sy9WWVNEYzlTWUlTY0JFenVFZ0pJT28reXZWMG9MZ2Q2bWRGcWZHWjJ2eWEz?=
 =?utf-8?B?TmV4VlFrcVJpTldQMEJhbmhaMkhNcGpDeFQxSi9Vc3FtT2w3TjdmNkdjM3V4?=
 =?utf-8?B?YlYzQUlwVUJFTjgwaS81eFV4V3hNUHhlbklhb0l1c21adDV1SXFRMCs4cTlo?=
 =?utf-8?B?OTlBaE1vVGR5ckpNV2xhR0REU2JLb21qQVovVXErVk4vQzhhQUVENGY1bGUz?=
 =?utf-8?B?U0RzZkxsTi9lTWQ3R0RBdmxCWFgvRWhnTWZIQ1kvZU1DSHpNUnlLdWxZQ1Jw?=
 =?utf-8?B?UjlTQzk1aENlMDV6K2thOXZEQlJwL3ZIeXVsTVVJNHEybEdWblBBNWZ1NFRa?=
 =?utf-8?B?N2hDWk1QUG5rSjlDRjZ4aklzQ0VSUTVUSkRhSUFnUEdKVmtTT3g5TDdwZXZJ?=
 =?utf-8?B?blBWL2htMkthT0E4RVVoSFA2UG1wTnU4ZFZMVE1wL0FabmN4WjJvemxtNzkw?=
 =?utf-8?B?dCtmeER2TjV5Y1IzYlNqWmllam54SHZ2ZDRJL3NSeGpSZndkOC9kYUZaL2I2?=
 =?utf-8?B?SkVvb3ZPaTlLcFlWSDE1ajluSEFBR3hqcEkxN0tuZXhqSnlkN2liREM2YWJT?=
 =?utf-8?B?Ykx1UjNkVVBNcEV2RjdRcVZVSElRWStiRWRrMWo1eXYzK2hTR3c5YWo5am85?=
 =?utf-8?B?T29QOFkzQ25XUjBXd0o2NVNmd0pzN3RhaWNJVWdOZXdieGJFSHR6dy9MaHhX?=
 =?utf-8?B?UzNiTlRkRzlFRjhmamNTSUVDV0Jac2VWN1V4WFdoTWpDY0xJdHpSU3dCYWJn?=
 =?utf-8?B?L3FkeE4zbThkL0tSZTJETXZrNFJwdFNONG55U0lMbHUyN0xlL3piVmZ3UVJE?=
 =?utf-8?B?dFNqM0FTd1RxQnFQeHhxMlRRVUxoZ2tOOVVVMm5aU3MrU0ZzQkR4RDg4ZmJI?=
 =?utf-8?B?cGlOQkpxZWVsQS9XejZOdnlPbG1VUndyVWpzR0JGZjBtYm0xYjVHbDF4dHhY?=
 =?utf-8?B?UVYzOFlhbDBocFR1UmJsOGlQZEgxRVRWY3hqbHNuL1o2MGkrZ0pZd2tlQTU1?=
 =?utf-8?B?RXk2UzB1TGlhb1J6M1lGWDdxeU9NSWNhekVyQzQ3Vk1WOVF3MFYwa1pOMEJD?=
 =?utf-8?B?aHB1cTNmQlZrSHcyNUpVNjRjU2h2OWhOQnZlTUFhclEzVjBxUHNFOXJjLys2?=
 =?utf-8?Q?5aXT8i7N7rnkXzdlSuVIAzeZBrczd4cuH3aUQqFIYsnEt?=
X-MS-Exchange-AntiSpam-MessageData-1: Nm89hdO7lSsKXTpNh77XdtD35vKhrluFgKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ac6f0c-87b3-45bc-ab07-08da41d5a10e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2022 00:45:01.6028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOhaJYuaTz7ExbYDoaFqx8ngRN0aOaSW4uOuXfr8jDCO0BbAe3MXMck7oWLsx4MbHyhKv57vgSKfubq4idPTGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4681
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-29_07:2022-05-27,2022-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300003
X-Proofpoint-GUID: -lcVRXIlKUjLwYeguTOLNAmAWxGkcrnn
X-Proofpoint-ORIG-GUID: -lcVRXIlKUjLwYeguTOLNAmAWxGkcrnn
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>


On 5/27/22 13:49, Christoph Hellwig wrote:
> Use the _btrfs_get_first_logical helper instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Qu Wenruo <wqu@suse.com>
> ---
>   tests/btrfs/215 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/215 b/tests/btrfs/215
> index 0dcbce2a..928f365c 100755
> --- a/tests/btrfs/215
> +++ b/tests/btrfs/215
> @@ -56,7 +56,7 @@ fi
>   #create an 8 block file
>   $XFS_IO_PROG -d -f -c "pwrite -S 0xbb -b $filesize 0 $filesize" "$SCRATCH_MNT/foobar" > /dev/null
>   
> -logical_extent=$($FILEFRAG_PROG -v "$SCRATCH_MNT/foobar" | _filter_filefrag | cut -d '#' -f 1)
> +logical_extent=$(_btrfs_get_first_logical $SCRATCH_MNT/foobar)
>   physical_extent=$(get_physical $logical_extent)
>   
>   echo "logical = $logical_extent physical=$physical_extent" >> $seqres.full

