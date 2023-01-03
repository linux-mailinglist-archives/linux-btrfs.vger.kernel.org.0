Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3DA65BCDE
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 10:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbjACJPa (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 04:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbjACJP3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 04:15:29 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554506579;
        Tue,  3 Jan 2023 01:15:28 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302JZZ0W024585;
        Tue, 3 Jan 2023 09:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8StZaXr5PTzJDR65UjwftDJbEMXYXm0vB+XhQ5kMmi0=;
 b=RPpp77KV97VbkD06HHjPOzp1XAAgbAw4UNI562ASwvLtghKhBpRUFgtitRkDqjDePld0
 SZGRDGr3KP02cgtHIyHVaGxl3Qg+CQbsdtVah5k1YD5FFMq6TWPaTiTq6FTSfQ2y8HJO
 uiY7aSKyKiQU5V4puS980Sx4WsPFLdG/Y9HtLh3zvEVNEYSyN7+kIJM9RzMF1X0nWU+I
 QukwHrBduUW0n6qN4tNF8imJ4HOuCNz/qJLCmgfXUPg9Pxj5favg2ElmyUUU/iGDlgNT
 yRxyL6gg/5x/ts5zLRsprVoq152OtFgEglWtKMKCBr9nOP/vWzCxo8UIdfo3jdA7lVtn NQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbp0ufpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 09:15:22 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3036tQWH005812;
        Tue, 3 Jan 2023 09:15:21 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbrbt3sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 09:15:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpgolwQV3KoNcPwBfkubyCHqRJ1QfxaiqwFjABAloG3n+lzU0gxeXO/mlxNoULVfzS/6eN6muFU2Axz4KM83Hu+/+qsBPOSNtgOmzp89rUEYsLtIzAh4x8j2Oatv++VicEeP+n2FmPMzTAYiZGlmnLD74uGYZKjYOYMsT3QO6j/l6NFR5wDUqoINWHyHofCya06Ve1LJyePV3EbV8MqWNws5T3PC4cHELofNkG6nixQtdqzPDEsWSfDMc1Z5sQggL8StY8HwMQONn5jKy+AH4d1EwSFrpCpvc0Cvf7vsNREmf8zTlfdLf1OQFMqNLCX5uftKH2lHaubSG0DT3Ym0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8StZaXr5PTzJDR65UjwftDJbEMXYXm0vB+XhQ5kMmi0=;
 b=YR1ghB8Rivvml33UslsuEkUOi6YxwOH4WirmhG8Hf1T/qzni2KC7xKEXBqeJTHq26LScKVBnF2JK21ZIMnQ6CfIV7H7jHqeAR4Afjm5Q+uWNYywGBMd5vz4PC669XHlkCazbXIG3M6FBxAKh8upybz8QiQowc1Exuen9C6LZibfy2SR9bjWf4S28Nvvx3epehmYt/yTf7LN8U/uDphAdEsuRsP73rHiC2+aJSdvMZ4Ijj6UWY2lLqTPribL7yJTWV4FjFkZuDUGFQPKe9C7RAFtrUwsIAM0BN1bcWb+0NxyAiuFoIX8Bg1jb4oWSaBu4Z6r80LF8+7/eriY2KCBzyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8StZaXr5PTzJDR65UjwftDJbEMXYXm0vB+XhQ5kMmi0=;
 b=iy3rZNqJQ1sPp79GzuUUtNrjHXzfVrw0WuXNNTDrMkDtLlKTmCUxmhMUo8taUQKFYyXudgb44Ap07b0qtzxrbumRZBVp6arNK5Fm9WTGGFcKy9q6MViazA+T9nBbOwSR5gIl8mmR+PShM6d9l9uyIFZWWz7ci2RhEw8FtgpxhfU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB7035.namprd10.prod.outlook.com (2603:10b6:510:275::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 09:15:20 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 09:15:19 +0000
Message-ID: <6ab14932-4b97-021c-4373-9a1aed86ac71@oracle.com>
Date:   Tue, 3 Jan 2023 17:15:11 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: Fix ASSERT of em->len when getting extent
To:     Tanmay Bhushan <007047221b@gmail.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221231150501.123205-1-007047221b@gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20221231150501.123205-1-007047221b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0249.apcprd06.prod.outlook.com
 (2603:1096:4:ac::33) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 6916f38a-0f9e-4ff4-1758-08daed6b0903
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5UZsuMIM/9F4U9ilcUaqYvc2VPFE3eIr5YBLC8Tqsrxl1N6XfQ4tMgNcg79zJv1MXn6LeMH5z1OM7xaEGd5WsnaViwz5qssY7zCInWS0iBZc/A2bQCmkmyZDr8eG8jY61F4CzPGv+X0kClirTYa0BJZ1eCuOrYEDcYEuE+Zw4rkQ42nIXhDJ4DPryJdUEF+JN5gRlPm3n7PIudK903AquAZz2m8gZldBm/rC3TT8a8/rgGFE6qJ2M/0C/nBe276uX3U1V7VeV2YsOdpYLxvvbsx9lckilLaUcBrOzCY/4MD7TEEmbxf4euUxgeo/PQhhB3mkNfSDrhbaQ5sUOTpeHc6OdezKoVUXDNTx9jXlGaDfQ0QsQj8Xa6/oIVc4of+mad5IBX6KBSNcw9tOz0FA+pwpr8vCdtNAuqeUmmcNgUuw8okpAxC7E4aXpP9gIyd9SONIEH5Q70QWowppS88AK6nKto/DXci31+AhwpVuGg4Es9aCgLxGOl9RVN1mv4fcmEOrbeW/nvq0+6XZm2qdTYkg/fghSCiwTjRrtwhYOfOpre+rmomKGi45s6AlRdhwYpPKxAhhRyB66ojlupz9EHSaGUsrHNV4tgnnz7orLP4Dao2u397HljJ+srthnJMkt02J3ETEgmwCYdhbneAC3EN6f+/7sOffItc+bIYCV8ibA0NUzhUAjH6jpqpMLkiFto0noOKopnFTgS0ENt3wG+JQu0NjpsSL6PRWxgCwI1deab8+BW5lMu79kwK1bYW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(396003)(346002)(366004)(376002)(451199015)(2906002)(38100700002)(31686004)(36756003)(41300700001)(316002)(2616005)(6512007)(31696002)(86362001)(4744005)(44832011)(83380400001)(5660300002)(66946007)(66556008)(66476007)(8676002)(53546011)(6506007)(110136005)(6666004)(6486002)(8936002)(478600001)(186003)(26005)(22166006)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGJhaFI3M21hR2Fhb2dNcm50d09aMHBmRCszd1BTa2dmY24yRG1YMnhZYkJB?=
 =?utf-8?B?VGllY0t5cXMwaVBnMjRBaWVyTnltV1IzQk4wYlc5ZzFGWU5IdXl6dXBPUTl5?=
 =?utf-8?B?TVhEZWRabmJrVnB3MSs1eVRPc2ZZeVMzSGxIcWk2Y1c2Ry9JUVVsTHdmRTZu?=
 =?utf-8?B?b0QzNW1zK1k1NDAxNS93UjNXU1NMazVRNENBSXh1UjZnWHJPS09JMnlEclNs?=
 =?utf-8?B?MjI0SnF2OWN3UjhhckZSTE43UXlDVyt6UWVGeHZDK2JVd2FvRGcxYlRKZE05?=
 =?utf-8?B?U1d2YlQzVWZ0QmI3Qll3RWNLOW5RSXFWZzg1ZWZiNlloMEtsTDhrdW5PaElL?=
 =?utf-8?B?MVV3NEJUYjFTSk5CeEhqMndHRk9QZGZ0WU1HQjNYRStrbEJ3U2hRVlJ4QzFO?=
 =?utf-8?B?dUg5QU5QNUY3Ums2WGNQNHpubVlLVE4vcXJHaTI3VW93OXRKMENaeHdwWVFl?=
 =?utf-8?B?VWF3bFRIektsbHFGa0ZDbHYrZk5xNW9Vb3dWcGp6bDlWZkFiVmltaENBT2tK?=
 =?utf-8?B?aXpBNUlaQUMwaWwwOEJZNks3Qlg4YkIza1JqTjRDeHlUcDI2Y0ZQdThnVmhq?=
 =?utf-8?B?Nlh3S1BLb0R5clAydGhBQ29KLzBxSHV6M0huVzcwdW1nbEtIakZzb3gzNWxy?=
 =?utf-8?B?K3NtdUE2VDNpbW04K2FaSnorWGFLRXNES2V5UlVYNllsRGJKcUhTQ0ZuNHF2?=
 =?utf-8?B?TjFkNEo4QUlvZDI1SllZaGtoQ3lXajZOL0ZUOWZkSnk2NmoyNlE0RkhlR3Bj?=
 =?utf-8?B?bkFWWHY4ck5hem01T2JxeEhsYU8rRGdBcFFObXoyaCtJcVhkc0dQc0M5dDIr?=
 =?utf-8?B?Rmk2YlpicEtCcGQ2Y01WTU5JR04wMDJRUE5YTEVMNENDWUN0K2RDZUFIcnl4?=
 =?utf-8?B?MnIxOHFkczk3WWY1ZDBDM05OVlJsMVVxSE90Uzg3cGgrUnVIcGZrNFNqNTEy?=
 =?utf-8?B?WDY3T3gwQ2RYR2FTR1k2TjRLYksrUDB4MGt3UlhCVWRMU1g0ZDJGbzBYazEr?=
 =?utf-8?B?Z0lqaXNHUkZVdEhVQktab3ZLRmF3M3NDbXlzUWRiNjQzZ1lGYXc5TFAxTFRG?=
 =?utf-8?B?anRJME0ya0twVUVLK1p3MHhYZ1pFeTE1dDZiUmxqcytmRGZxMU1CMG5MTnJC?=
 =?utf-8?B?TE9zbEFubWhaTWIyZ2wxY2dBZXIvRVNtMGhlVjNuSUEzdXB0UXZaUi9Sd2dK?=
 =?utf-8?B?cEY1VTlGa1IwQXhUb05FRGoxZkM0YlF4eVBXUWl3dHFBeWJrWEtqZXBlOUNP?=
 =?utf-8?B?cVpsT3U5VGFLVFNFWG9VM2l5azBydWU3VEoxOUMyaURLSjl1dklPVHVBbEVR?=
 =?utf-8?B?clAzUUxGQkZIZ0VUT01xSmdmUUFGK0l6VWQvenk2K2xtVDJrekpQOGhFQ3J1?=
 =?utf-8?B?WjhJWjExM2ozT09ob244eTczTVJBc2F2cUNxRVZOeS95bUZPckdwUk1jdXk1?=
 =?utf-8?B?bTBtazVtM3ZsYzNzUU9HMTZ4OUpWMWorTW9GQTdVZ0M2aGw0aWFxUUZSOFB4?=
 =?utf-8?B?OVdNdVl3YnN2cUdTeUNuK1NoaC95Mnc1eE5OaktDancvS0M1VXQ3N2FOdkp3?=
 =?utf-8?B?ZUFkYnFUWWJoKzUwdzY4WXA3SVVvS25sVHV6cW5ocUREcXYveWtOTlk3MXNv?=
 =?utf-8?B?eTdHblFCdVhna0kvNFZVVW5BenRjLzNzMDZXSEFkaHRqd0N2TWx6Q3UzYTRF?=
 =?utf-8?B?VEt4WUpONGZHVjBBRkRQS3EwaXRqdWdoU2xWKzQwTWlGajRWcFFUdEJ4ZTBl?=
 =?utf-8?B?alNEeVQzRWF4MUdnUk9sUExUK0JzQnowejJxakpOUlNKV3kzTTFsbjYvMTVG?=
 =?utf-8?B?WVlnaU0ySDgwZTJQOXBrNkR3T1ZvY1lWOWZVQ2xRbkNKazQ3emVVQml0RW1p?=
 =?utf-8?B?QVI1Q1hLeXZEU29EeFV5M2dWb0FNOUxkSmlmR0JUb2N2TUhrZkU0aXRIOHQz?=
 =?utf-8?B?LzFoOWNGYkpjdDNhT1RiaHVBNVJWTTY5QXEvdkd2QjJ1Y0psdDF3VElHRmhz?=
 =?utf-8?B?d2VvREpOcERxajJZUVNNTzBQYlVVdG5EQzMwZHFjMkwzOExqS29rdUlrMk5U?=
 =?utf-8?B?czZwbEQ5NkFDWno0V0FGamkySGJ3aW1WUTJyNTZ1amtzemhLMmxHN2lqcWl1?=
 =?utf-8?B?a1dqOG1RWmFiUm8yS2J3ank0Q2V6UDFySFBNeWtLSjk3bXRmSGNKK29HV2tF?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cpnEs5sjVOZnpKQzFwtzq5LEtqgmseYuohOpn3mfU2jSVmkreMoKuAxUAQABnAEsBwUgieZZxzPKTuW9sdz3fD3JTRqaFYnfsFuozx8SzKxm0RTYGnhIzgFwhHIbVJAI6iX0+smam2OQ9+PmibOn5kgurw2GyT0yyDnUoEnfo/DlRcH0DqJL8Btm9DfUMqdKgh5RVd87ilrxbK7OZIJeZGlEDqjg1dtErzubRCl9uwYEfk5JI9gT3ufixeq3gj9eGwY2qPxXVYlDqnRcqSF8YIoUOexuOM3fUk+XFTHgSe1YplB7Fv0bHgP1r/G6H4DZb5WH58+e5RCwXvT2ZYh1jGpvxIqnKVGHS40zys/g5KBc/bMQ5vhI1susl4h9rFnVn2eP3HMSwriMd4pKB+HLcFZHnctaM1B5StKuRE4x4GYa6qppFtWnz47f7OUKvx4sQUV9scMSCVG/p2w6zZyMBA0ItmmxnEpG4NLPd8m5AvOchfD0sbsInX2c8zTCZAkLH/o4sts0Do5jo4LngSFl0jaXh2JhW8Y3XmMDDnspvR3VPWdBXQ8UBz0kGrJJ/aHQiSt7IKIJeJ/tP3d/rlRaYgpuyKy6pfeEbe/bdcB3/deY51/x82fMpTy+7Px5bc+OSWy4BjZlaHLBGL/k4CCLF+AixvsFzLU/PJioK8QGIUmdymvfaI7YJdYm7XRM98TaIBGe+jHOQdH/AZruRN0jLHADup9NogRqT5E4K4xcec+A+A86+kc2yizAIXM4T9AE5xkypVpVSoVZlIqLZIiDKdpB5iEOvd6rklcbx+SqmZx5aM9HcDHUu+/PpOFuf8cI5RDK4ZEpF1pgI8sI6GP5+PVvtj60XlKZLPLmm0Bb6ps7ZQYo/NhivQZoU4h6+iF/R37qC/EQnFsUwLKIZH+BdMIlhxuJalJJHdejJYdpwlU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6916f38a-0f9e-4ff4-1758-08daed6b0903
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 09:15:19.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1hL4glBbvF4c525owIJFwOzbrZN2PArLwy3WnIvHxlP4OU9lACIWo16Aae726TjyK2h5TmWfKjROJelNFpE8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2023-01-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030081
X-Proofpoint-GUID: p0bQ-oR3C0mHpXPJ3mp16yy9eK9ZITSg
X-Proofpoint-ORIG-GUID: p0bQ-oR3C0mHpXPJ3mp16yy9eK9ZITSg
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/31/22 23:05, Tanmay Bhushan wrote:
> em->len is incorrectly asserted which is leading to it's
> assignment to sectorsize instead of being check for it.
> 
> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
> ---
>   fs/btrfs/inode.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 8bcad9940154..e49358048a98 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7092,7 +7092,7 @@ struct extent_map *btrfs_get_extent(struct btrfs_inode *inode,
>   		 * Other members are not utilized for inline extents.
>   		 */
>   		ASSERT(em->block_start == EXTENT_MAP_INLINE);
> -		ASSERT(em->len = fs_info->sectorsize);
> +		ASSERT(em->len == fs_info->sectorsize);

Good catch.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

>   
>   		ret = read_inline_extent(inode, path, page);
>   		if (ret < 0)

