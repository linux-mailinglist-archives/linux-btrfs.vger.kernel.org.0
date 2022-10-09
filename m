Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C555F8F04
	for <lists+linux-btrfs@lfdr.de>; Sun,  9 Oct 2022 23:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiJIV7f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 9 Oct 2022 17:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJIV7d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 9 Oct 2022 17:59:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C4722539
        for <linux-btrfs@vger.kernel.org>; Sun,  9 Oct 2022 14:59:32 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2999qkCU019004;
        Sun, 9 Oct 2022 21:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=13BOhM1S+4MeU4bETI2uLWtesMp734DaS5mEwGNRlA0=;
 b=xlsV8KDz/ZmVXaIbraySeCIXHKfnGiEBpwgoar/YHJyW47XF3bqJqjpIXu5txVPif9vo
 /NPpKHJb2J/AIQhfWDRFsaeBGBLmLfVB975l35fcSpen+KgJvMS6lK16CRAM5bSSnHpG
 ZxxngO4SjUPHYLiEGQAAqFjWCPYMWsp8wPKha5hJ/EYknvT8eLrG4K4JZhRpNV7VMBnY
 QaHQHoVJNbJx7GdvKZZhN2jM7tXni7kxm3GYwP9wnNvRlKoKnaTjRL60UCoazcjkuRkR
 0TUXzQ8KRjImSP5e/3tguI0bE60l4YcX51S1yOLQZ8FytxuxqnchO0J5yc7WvTl8mMzr +w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k3002t2hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Oct 2022 21:59:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 299JxTWD029451;
        Sun, 9 Oct 2022 21:59:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn8wxwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 09 Oct 2022 21:59:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpN4aDRiVJTVaCaw2u9QqaLKaFWGQVD107vWdS+7O9y6NuMampus6PfZY9VoetqzH6RVi1PfLpdbHF1wlF7ARZsnkXLPPBT4OiuqXoc+iXcrvNyhDPY/6TEdFHIJN7Uc/DHYGWuDU875uqD4BhxIXJuRh5AnzGUmsJjF41ZkqH9wjOZG3hsvc4muFg2F/QQ60qOCtJiDlRYs8mZUJEDREbxRDHCRaDi8+TmbNsRt+eYDYXElGG3XdzrS44nZ8bhdC+32yrMAodvtyvYusfpQWgpnylisThQvNxr+qmMbrFuuwbRKcMNPZf8PkgX9JEHCbVj+WjG3OGjhaMS6iaz/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13BOhM1S+4MeU4bETI2uLWtesMp734DaS5mEwGNRlA0=;
 b=QB3LiDXy6FCcRyaIx0AtS1BX1o1+Z8KBJW4EsDEVm5TddEwMRUp+MInzAOF8rr3/4txqtjcEI1LzOtX7TLEK4oetAKdS5Qww4sKPJ3+EZS3U+dGJyaw4k5XiTIqaNvF9KHCvjtSSaq8KdRJevGjf1lmcqFX10FFCIHVYt8rzDXmf0Jpw4OWJ70YqmHbYnYlyZ8EJoD63nJ/oT27rf7A3xyDjTghQazufOXV06v8eVIE7v9JY/raH8/h/+t8ah6fj4ifJmJCufe57fpYuAEGiCFcFphD1fUCUhR7mz1C2xXgP9Z/R47hLMrLFsWz3iZU8bTVrXZ6jG1o14kd0Kh1LVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13BOhM1S+4MeU4bETI2uLWtesMp734DaS5mEwGNRlA0=;
 b=QqNs2nH1X7zWvgIXVdVvlf58PN710nhBCPptPWHbAEBHP9/wvKjmTwvtCUrCR14B1WvrnG0d+WfXdUwNRbKKj/zOY1n8csd+oAmFG70PmxfWIzA/gB/vK79b4ysOU7NceVm/IYYtsML7B982s9uJ4hPdwXvjJlrujILrFZYr3sY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Sun, 9 Oct
 2022 21:59:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2515:220f:4d94:63a7%6]) with mapi id 15.20.5709.015; Sun, 9 Oct 2022
 21:59:21 +0000
Message-ID: <986b5abb-9111-475d-177b-5be6940bf759@oracle.com>
Date:   Mon, 10 Oct 2022 05:59:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: send: update command for protocol version check
To:     David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
Cc:     boris@bur.io
References: <20221007154025.13949-1-dsterba@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221007154025.13949-1-dsterba@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::31)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: d76161c2-721b-4d05-a68a-08daaa418508
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0cGCClRhk3oCx0k6XY9nesb0UAxXxemnj7VSv1GToIzbiioPmqROM5NditGw9nG22RBlfzTu/u9a3R+YIsSkoB+EifpQFIn2iRSRLDthAY/N1dHgaugSRzr57NEwXWj+9mDBF9a7iHjZ5DuUqaqhP0X6KIEUUoGKndl+sJNl2AFEqqIJpTydDDOeM6SN7fAOlvYl2MKFm/e9v1GBgTW7n8smF+lgyqMRW1UK9mqEGl0JpaZdU0Z5hXGHRWhinUMkJDFVTwxihk3SUaHyQLmMpZXCy/KwdhN7xkOx+0fLzciluxsjQbhGN2UmBx7jfyf9ybun0Yk6P5D/UM08/LlB2Pxq3DJE706j6Fa/rINLKvoYgEeOj5x8rlFohuKaO99OfECcU5tvH4zq4H0dOA3cYmwNLyeOZqr1vm0RtPQLGvsLxXYjhNdsCPVInsDDmpDGpHxLxkJglmpsRYPXcXLWlZlSDWLAlz2wpDHR9++v0u3Kq69G1zt+z2LB/Znm64MdPdVbXzdZ2TrmfN9c/i0nbJRLoVdFwo1/SJ1A1IwUA1+394NSpmRegDXNkWWztCOMCiJN5oPGGxPzh028Iu1Osy2g1lMNRqJQS03S2aE0a9W8XolRpts6u7S3sVT9VAboNFOWLyiK6ZQPWRkQou+HSa5gel9rPYIy8DZ2z8lee/rqMqIsdUbA/vMszdkiQsKRLja3BKvVq3arlEtsIXfy+udTovOPul5QwEI0W2dPWfcIyXz4pI7SpFNSBmag5fTT9vxUJ21TsAs1yoMj838Q15F5MS3mrcXfum0UcffziM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(396003)(39860400002)(376002)(451199015)(316002)(66946007)(66556008)(31696002)(66476007)(86362001)(44832011)(8936002)(15650500001)(2906002)(8676002)(5660300002)(4326008)(41300700001)(36756003)(2616005)(186003)(38100700002)(6512007)(478600001)(6506007)(53546011)(6486002)(6666004)(31686004)(83380400001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NStqWHlYYjJJeDJ2aDNuSG1rQnBqcGp6Vmt5MkM0NCtwVUZ3bG9pd2tzeVFk?=
 =?utf-8?B?anpLNUFMdHh2YmN5T1RXbktqdXJiVW9QNzd1QjZsYml1TjFObUpaNTIvNEFh?=
 =?utf-8?B?VlRiWUdHVnN6QmpoalZsUDIvQXRRNVRZNEZsVzVGdXdVbHRLSXFUMG9qS3Zy?=
 =?utf-8?B?aHBvb0dCK3FBb1VxYlllRmR1NVZXcjBiSjdaMThMalRPWGlBRHJpZ1Q2dVE1?=
 =?utf-8?B?T0VseW9YaVZBRU5iQmozZnIzZ05yVW11eUFBbzNJYVUzVW54TURRb0hsNVFI?=
 =?utf-8?B?SkhXY1g2QS81NGo5ZWtWYjUwWm1ublEzaFZFNk96MUp0bm1jU3VySmNQMnNE?=
 =?utf-8?B?Szl2bGlGeXA5VjRYWHVPZWNMTm9GZG05SSsyNU5UcXh2eW5ab3YwVitXcS9U?=
 =?utf-8?B?V21SaHREMlRxM3Z4ZzlMMjZxWGlwQ3U5T3FQMEJrMXNMNEROalpXa09iMUdr?=
 =?utf-8?B?VTQ3RnZ1eXI2Q0xTSGlwa0JQUjJQbzB1WVJoeHRpR2kwMXd5SGtNZXhnbGJD?=
 =?utf-8?B?S2FKM2VHczZmdzBUNFlHZUhqblF5TlhuS0NCVTkyYWxsd01BZU1tODRvYmNR?=
 =?utf-8?B?ekl3VzRSWENrNFpqVjZyQW1SMXR1dExObE9CWEwxTFZHU2JvdVNMNkY0ZlNH?=
 =?utf-8?B?OGxWOWNybTFCSW5rdXJvYnYzdWdKNEFraDhnZUw3bmlJbWxXUVI5WEJLcE5i?=
 =?utf-8?B?WlYvMHAwREk0R1JoL2FaOXN2dzlHTUsySi8xTU5JLzBWRUtZQWtZSGQ0MUVa?=
 =?utf-8?B?R2REeXoxRkh0L3JqMFFoOGp2WVU4VXZ2U1g0YnZoSzU5bHlOQ0d0SHJWQjVh?=
 =?utf-8?B?WERTanlpeUZzVG9OREtGUGVwd1ZmUklkL01EcnltcE9wOUREMithbzU4NU5L?=
 =?utf-8?B?K0lSY0dEenhnVHJ6MEVwa2pNa1AzTmdPWC9WcVFmbzhBK3JXYnh0c21qN0hK?=
 =?utf-8?B?aGVTa0JUeXh2eSszcjd1ck9SNjcxRktwamNkL2pDbkdQTThOQkF6bGpUVE1S?=
 =?utf-8?B?WUx0Rk1yN21JdGNjbi9mejVoYWZacW44czRQWGRXeG54UXFYZkFQTlpOeVRO?=
 =?utf-8?B?Wi8rSU5pZTJDL1NOWmVnREdiSXdMUlJqUXg3RXIyMSsxWHdvTjh1UkZ5Q1dK?=
 =?utf-8?B?K2ZhNTM1WFZXVG5QeVVFR0d5MitseXkzakdVWk96VVN6TXJtRXNjN1FOcXdl?=
 =?utf-8?B?elF1VG9Yd1dRYWt1dmtITUwrNUNRSzYxeXVoM1B3T2I0bTUzK2ZlVWpMRFEr?=
 =?utf-8?B?SDQ1dmVVYkU3eDhqSndONE5DWEdGd0NJYk9KYTEvUVNBOUZabnhsUGhxL0Z6?=
 =?utf-8?B?TW1NNHpyK3o5WGtxWWxUbEdPYmVZbDdsL2FCVVFwbWF0S0pxS2lKdmhzZlJs?=
 =?utf-8?B?OVZGK0R2dWFGMGhDVXFaSFhRVXZHZFJuMk5MWG5mSThDTTZDT0N5MFc4UDUw?=
 =?utf-8?B?OVg3c0ZpWnU3NG9ZYytFMkh0OGJmUjc5NGVlNFFFQnprTmwwY1UvdnBWL0Nq?=
 =?utf-8?B?WDhGV3VpQy8zQmV2SWo5c0NTMDQwSXNtcUhHN0pYbnMrY3ZVNDhhME9QYXFk?=
 =?utf-8?B?eTYrblRSeHBDa1JHbEw5YVBJRFNhL3JMdUVSSXhXZzBEVXZrRFBNUm1uZmh5?=
 =?utf-8?B?eGhNSmFrQkRlckhOc055UElGSHVMdk42U0p6REpZTHdjV3lyUXNKblo1dURy?=
 =?utf-8?B?MUlGaGFVZm0yQWJnekZtT2NGYXNsV3hSMnZ6N3I2YmMySXdaU29ZbkhLNUNL?=
 =?utf-8?B?cG51L3MydGFIVFBBSTlOMUpXSHpYMDF0UnhGUVpXZExhMGtqTEFiQjk2eWV6?=
 =?utf-8?B?d1cveW13UnBVQmNuMjRaanQ4cS91NDVlN0RVMmpyWDhFQ3NLNy8yb1cyYlNz?=
 =?utf-8?B?M2lGQU0zRktsbVlFcEVPNVRpek1kSmlSYkVLQVBJeXJNWUMxVUlla0dpNjYr?=
 =?utf-8?B?V2gxMmFRNGc0eEhPVTR4V3VZTzRKc0loSnZ4VlNBendtYzJqM0dEek8yS21R?=
 =?utf-8?B?WkFMQzVIVWxpNTZ3bGFnamVJcUJFbWdnNGFtVHRObTBVL0JBYVlYZ1NBTFZm?=
 =?utf-8?B?S3o3eHN1Z3FUQVhyRUI1b0Fxckd5a2pvbVZWTk5PWnVVZG5hNHArQTdldVNp?=
 =?utf-8?Q?I+wVYJkm+065zQVSG7hjkKANp?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d76161c2-721b-4d05-a68a-08daaa418508
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2022 21:59:21.1785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5tPSt7cVIJ1c1ZEJI6+tg6Zk+BFqPeP0j+4h7QC88+7cMicnDukJI+qS2/10gJqmtQcMUszKCHNxMfkoBhfDiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-07_04,2022-10-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210090142
X-Proofpoint-ORIG-GUID: NspoKsjmwS-xpnd5dho1LACAAGAF_Imn
X-Proofpoint-GUID: NspoKsjmwS-xpnd5dho1LACAAGAF_Imn
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/7/22 23:40, David Sterba wrote:
> For a protocol and command compatibility we have a helper that hasn't
> been updated for v3 yet. We use it for verity so update where necessary.
> 
> Fixes: 38622010a6de ("btrfs: send: add support for fs-verity")
> Signed-off-by: David Sterba <dsterba@suse.com>


Reviewed-by: Anand Jain <anand.jain@oracle.com>

> ---
>   fs/btrfs/send.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
> index 178347666235..ec6e1752af2c 100644
> --- a/fs/btrfs/send.c
> +++ b/fs/btrfs/send.c
> @@ -348,6 +348,7 @@ static bool proto_cmd_ok(const struct send_ctx *sctx, int cmd)
>   	switch (sctx->proto) {
>   	case 1:	 return cmd <= BTRFS_SEND_C_MAX_V1;
>   	case 2:	 return cmd <= BTRFS_SEND_C_MAX_V2;
> +	case 3:	 return cmd <= BTRFS_SEND_C_MAX_V3;
>   	default: return false;
>   	}
>   }
> @@ -6469,7 +6470,9 @@ static int finish_inode_if_needed(struct send_ctx *sctx, int at_end)
>   		if (ret < 0)
>   			goto out;
>   	}
> -	if (sctx->proto >= 3 && sctx->cur_inode_needs_verity) {
> +
> +	if (proto_cmd_ok(sctx, BTRFS_SEND_C_ENABLE_VERITY)
> +	    && sctx->cur_inode_needs_verity) {
>   		ret = process_verity(sctx);
>   		if (ret < 0)
>   			goto out;

