Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E3279162B
	for <lists+linux-btrfs@lfdr.de>; Mon,  4 Sep 2023 13:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238941AbjIDLVc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 4 Sep 2023 07:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjIDLVb (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 4 Sep 2023 07:21:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA90E1AB
        for <linux-btrfs@vger.kernel.org>; Mon,  4 Sep 2023 04:21:27 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 384AosdR017370;
        Mon, 4 Sep 2023 11:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=5/SqQYvLQZBEwaKzaO6VOX5g9lBLKZzgW1uBWlLhK/g=;
 b=m2NyPZNYmRXT1LmIbd5I+kJ3l44IhXleOySyojsdK6G30OvcuIc1P9haTO8Ry9eFKu6y
 +8IyaHUbAAsb7FNwmndC4CfmP6R8iCAJFFo+6HuhTUq36JJTu32bPIu0qZ6S8lciDqLh
 b/PMZsdRp+FrE3jdEocmQ8SpFBpwGXHWgGSA0p+fP4qIufgbCnl0iYARnQCeWSobSEDo
 NnMvJzXvRLH+cdDnMlw+PG5Pmp9Ez3pcCoo1SiyAm0jos0UhBvY5qNtIJJo73KBY8Hbk
 lfxZxqmsAQWE1UysbEu7iSv+cN1NbkqqoQgWwXH/UT5eOdfGN/HxQdIv6DQBywXp6JDT zA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3suw3cu2gx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Sep 2023 11:21:24 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 384BJN66017145;
        Mon, 4 Sep 2023 11:21:24 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3suug3kgxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Sep 2023 11:21:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6mGbPzNu6nQBw90YME9ZZx0nLdo0/N5aqL4DeBA85eAc97PTCJNpKdpD/dfleDQMEvc7BrAb4dUd/G4O12KEscVEdEemZAr/IbGxEJqZNkhuRokZ2re6q2IG3NsaYa90T94jDT1JklWcmYUUhMHTCjMc/lGJ3/miYAXwLJLeQv15/iwCYjkGUfa0rwF6R2tQAV2T1UIbyYTsdA0M/207rTAD2QbMB14SLP7WYdkYP7o6NIxyk5W1TGm8CmqHV9opcOG/PNciRSKyWTADUce1T9Y4yYsK8m0xK6ml+8XE+oqpCpDYCiPpNkLLf4NejPKHHvY5tX94D3AABrmSKL7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/SqQYvLQZBEwaKzaO6VOX5g9lBLKZzgW1uBWlLhK/g=;
 b=dfTZX9Rkux3ThqsNK0oAkL34SiPOI0XPZ4nS7SoCzx9HeUk7bmLuys/KfwGxEjf6nn8RcnHvDWAlmgKAgt4C9QpQWsCyG8ib1Wx4zt9xIjmFHULQ2OQQix68JsZlqFM+FhEilaa9JDe5BXtSvk2OQru/TtSm4kPqyC6CDZfiVER5/CdQgkf0mGg8NHUD3lvvopBT2C1aJlUQ8BH0CFqGxvkDTDy/1Of8KvrMscsHX5lMq//MfpohN4WxovEvOR8YylPJF4rsO71/jq7Nu1PreHVHPy9tjqxH5bB1jyTLdxMsmVCiULKivFw4Qz32Q09xUakGbjeXpowu0UAKgBz+fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/SqQYvLQZBEwaKzaO6VOX5g9lBLKZzgW1uBWlLhK/g=;
 b=YzaRPEmhdkEuHP++xzv5ACG5xpu2zgBrsDjt6iE/nUMsNaIM0VdMl9k+UCLi1cBlHDj8CjRAbJV2nzJ+dalzk7EY3gOkIe9SAJKy05FIwcEkshAYrTT/IANyIHwBjaIjGFVK26laVs35zxxPirSLpEQdW+geAHI10d0hmtZZmiA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6248.namprd10.prod.outlook.com (2603:10b6:8:d0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Mon, 4 Sep
 2023 11:21:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 11:21:22 +0000
Message-ID: <a75e59de-b3af-af74-1af9-f9df95a6cff2@oracle.com>
Date:   Mon, 4 Sep 2023 19:21:13 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH] btrfs-progs: don't take the commit root ref in
 btrfs_create_tree
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <937ef150c1d9c0135bd1b158a9b5ad44dbd35b5b.1693580689.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <937ef150c1d9c0135bd1b158a9b5ad44dbd35b5b.1693580689.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0010.apcprd04.prod.outlook.com
 (2603:1096:4:197::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6248:EE_
X-MS-Office365-Filtering-Correlation-Id: f2c1ee33-8e6d-4d3b-55ea-08dbad391188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvO1eKuifrFjNlCDKkTM52pE/QFkN4/a9ljA8ht4UC98BZHbY+wcBnovzQXiwoXnFyfaE2FalfEW2ofJUy9sYZ1PqZ2nuqgdW+hiGBcOsUEKNR/P2u47w/63U+ClYDXX6eG0T/1NlUoijGAvXTTRhXTWNxewp1bIn1kLbTZlchtxntMqejFpdNWbC9BHsFh62u2uMs7otMMn+nAjFRInxLKFlawr/gJF0+c14LipbUFIC3+Hnx8Pw3ozMbz5zrLdfFEi56tAk6MkEwM8zEYY0sI8fhBEK6pIZEpIkWQh+cFnaI1Jc0LtR/x8hVaSSBRgIpaATh75ot6FDNEoAx20Um1D4LfcU8pfOvj79oiEwdJF7Ua3W+IIHLF38kUK/JNMcKfQdU1PQxUKotH9fOHcCCE3zKvNW4vxnEPMeofP3Np/hYBChqsE+s6JR6q8fKPFCj5LzGoXiZ3GSReiCS6/VAWKBRwT4C8yPNemO3wCcnz82+XZqzj8N0KOyYGFV8LiEOnaOKj/czf0PZ2a0kkNtcfV/lVZnDeyhCKFwKcYKlJLNjnb6IYc2MHx925fIQF5iUw/11nzX9VAncgCOvZtIyPxhPAz2bmamCUTgpCApIQWJ+3LXPIYONBTg7+PzKfF07Nt6WtdDmZ61gactJrBhg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(6486002)(6506007)(6666004)(53546011)(478600001)(6512007)(38100700002)(83380400001)(2616005)(26005)(4744005)(36756003)(66946007)(2906002)(66556008)(316002)(66476007)(31696002)(86362001)(8936002)(31686004)(44832011)(5660300002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGRwbW1xdC9pVm9LQis4SHkvWS9uR1pzTDk4RjZxbTFLU3I4Q0RhaXMwTEl5?=
 =?utf-8?B?M0RMQ2ovaGNobVZKUFdXMjhCQU1udzB1c1dXSjlieG5FeFd6M2o3aE0rYUNj?=
 =?utf-8?B?RERhRHVaRUpQWUc3bmVSOUg5blN0Y1lvaHgydXcwVVJnU1ZoaHN1cGlXVDBI?=
 =?utf-8?B?TFNVM3BkdGx2bW5HR1RHQTgwMDNuRTlIcThBRHpyeVdPL0NMSHBLWURzalRm?=
 =?utf-8?B?VHMzNTdoR01aN0kyNTA5Y2RWNmNFYnczZTdFdGxYeW4rNkp1cTY3d0Y4QnBB?=
 =?utf-8?B?aDdBbkNua2pna1NOUGtWODRCeEdWRklidURNcHFxQktrN3Q1dmJseTNLVUdn?=
 =?utf-8?B?Q1pScnR3STNBR1Z1Q2Z0ZUlhOHdWNVB0OXA2TmZtN0NZZ3ZuUVY1QVJxeklX?=
 =?utf-8?B?ZTBBcVozc1ZFbG41TDBndm8xTWMrSTZpT0hBZ3kwWXVaNTA0ZjgyMjRZQUJZ?=
 =?utf-8?B?a2NlUU9wTFZ6ZEwzUytTN3ArOW4yekhObVBOVGxOSkRGblZaemJ3eDhNWVJj?=
 =?utf-8?B?ZEtyOGZqMDBNaTVTYUFLWFVFdXZUbzFTRVJEQXhnOVdITmM1TW5DcW5HNVpL?=
 =?utf-8?B?b1pvNlMrQkxsK3VucUxHeDFqRlB1SDFsbkdHdFBja05yTE40TGtHY2E4QVdz?=
 =?utf-8?B?bmNTV1FnWDd2bVpkK0NaUlBFUHdkWjVTOWxUQ0k4Rm1jSXpuV1ZlNWFwZ2t1?=
 =?utf-8?B?ZFYwUElNU3BwdHlrckZDMEJLcXh5RmdTV1hEK09mYWxKVlBjamQ5bk9nYWpk?=
 =?utf-8?B?b1YyVUthOEdBb2lGREFnSlV3Q2V6T0E5TUdCRzRua2RnTUY3RzVobjNoKzJZ?=
 =?utf-8?B?OTMvNC9HR3BKS3FOWUFsRjVOVkVLUDE0a2JJTFlFMGErV0RZTHdJeUQwcmJt?=
 =?utf-8?B?QStoK1N4aTBtYjZYaGQvZ29MQWNGZVp4MmdsNWNwZ3BsVit0NHcwQi9qaTls?=
 =?utf-8?B?Nk9KVEZKUlExVDNEUG1RRnRSYmZmNnBPVjd0bmN2V1FqLzhFYlBTdFFjVkto?=
 =?utf-8?B?YmRiK0NpQndldnBTZmtOZVFudERqcHFWM2diT2E5SFVYd2QvTndPQVNGcjdN?=
 =?utf-8?B?OXV4STZDa3ZTVTFvWGlIVmo4NXVDUVR4azdhVlRzWVpuMlFESnlYLzU2STJx?=
 =?utf-8?B?dDVDaEdYeFlTNUpVb0pkY3NDZUZKZFgyVVBYd3RQK1ZJWkVHbGw5YWVYVHNx?=
 =?utf-8?B?RC9wbEZUM2Q4aXpheExDNkhUY05BZndNRHFJOUtpdE5kMkIyUTVPY3A3Q1FX?=
 =?utf-8?B?clZaQm5DUHpvemJOcTZISWpvL0RzeUlSUHBVdlJweHlhUDBjTWtyallEYk5y?=
 =?utf-8?B?OUYxRzZXWHB3c0MvdFpqWDA4M2hkMzBuR2hBZ3JBR2dQRmgvaTlXWmx5ZS9L?=
 =?utf-8?B?cjNCWEd1V2Z2aW9Wa3RmTVBZenFIeEtUMUpmZUl2bi96Ym5maGdLTURwNXV1?=
 =?utf-8?B?dEVrKzZlWEROR0RTNTlqNVljN3dvSHRNOTR2d3dBMWxUd0dCS20wWDFhZnph?=
 =?utf-8?B?SHROUlFDR0wzTm5hQ3h4UTkyNlN2R1g1U1A5bmZPN1A1UXJGM20zRHJXd1l3?=
 =?utf-8?B?NTNWeGFqSjdwZGxKYVYvZjc2d1dlVkVQRSs5ZTZydHl0V0FzSnBzdHBHRmtC?=
 =?utf-8?B?OEVRZkpHV0FqdE9ObE5CN0hER2FHRXk2UTRLcWphaFprQU1BdFE1Q2dnQ2I3?=
 =?utf-8?B?aFlhRnp4a0ZYYm1OdWlKTkp4UzIybXFmeUFJKzdPeCtZOTNsVXdYajFab1BT?=
 =?utf-8?B?N0d1UUJRUUxCTHJoZHNaOEt4RS9iQm1Jak13di9YR0xDVDlMQ0ZIQmlVSE5m?=
 =?utf-8?B?QkVTc1pPZ2svOHlZQmREbDZFSXk4MkgwQmtzY09xNzQ5eW5VQ3VFT0F6Z0Vi?=
 =?utf-8?B?dHB2eUozUkE0UUFYOFBJTlZhRWlveFFXUWsvemVYVmZuU1NlbWEzdnQvamdp?=
 =?utf-8?B?cUEyR1lsejdmdWozL0pqSHdZYiswZDZlRnRNN2thNmR2OXg4UXpVdkFJWDR3?=
 =?utf-8?B?NW5ONTI3RXYyelpRTTFyQXR6dHAvVHpyYnk2YlIxQ2JCbjhKaU0rNWFBRVBv?=
 =?utf-8?B?Nzd4ODRQWDhRSFAzVWhPSW5iZzRSd1hQVUdPTUVFR2RsckYxS1pJT1hCS1Jk?=
 =?utf-8?Q?fiim6iOjku6prAQjQx9lSZ9Cq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4gv3Lix56avupu4OIF0PzPbHI6mITntSCUZAFReXTPc4RzUFei8PeD1/zPwENdxFLT+w8LpRNBPRBn/onLkeNEpMyPJxg35WLVGCWhZjQpoCEtNDNPprwO+w+R3qOvYYyLETvw8rf/6bV7NpdihFd85cFTiqdNwCnLwdNC1Hs38VEr+SpknSrhSHC8YIfqN0rCcS1Yj6yuBECGbaroa0XNgUbl4ryrAvEt+40/4zu0B5lP5QPv+IkOHhS4EIk2siT7iT+9sB6hu4mMuhDEj7OJQMgFaja0dTE4mrKPIWIavPbL9gCvL4/SWfdTTWsDxhOBWLeZAhT8wWRUTTFsyJz/msZkYZj3Y8ZkmzNzYj3n6r4oilk9FPXroVKfXkWJge3mN9ZTrX0EKaInIz3a5ISojN+7HPQRN5K0wnhcF1NLtwKgjxVsKDQv+SA3VO0fF66MDVRXWfr8OfYdC+v4+UmL9qMc2FNPAfw+R/uhIW+KNObglwNczRv4tljlokyLHeNfWum4cms277tHZPJ/CI8VKSJGqSL43IYPXKvAX31ci/aH8qCVICwkwGb5th1ATULQ1OU/GB9cmwmGGygNmjCaQGIqj1bA0YYP/9XmCeoOM7kTCco7UxMLTdbqpFROsN818vmThsuy56ZETfSG3p9lgigZ1xdQDNhobNKHmNugY7ukmHSfFalzUMGuQwhJ4CGw9mb2Iebil2vOawQRh6ERUxb7VUACEXWJHdejd16raSwQ3+f0WNPgFnhDqKBvVTPK8rh7MjWKzEL55E/nvywxB+ZSQJqdYiyCcYBw6SMBQehqaKp/mw90kNlX9OU7Q7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c1ee33-8e6d-4d3b-55ea-08dbad391188
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 11:21:22.6353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ApBz659G85aGlWQ7VtV44fUGOamKLEvYj0QEdnugTPrvP9uvgWL5GTCYVBd5XinLlZ8wpvkcUYYPaeTYb2o14Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6248
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_07,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309040102
X-Proofpoint-GUID: JwDub8C-1kW1lKh83WpZm_xz3ecT5Dhz
X-Proofpoint-ORIG-GUID: JwDub8C-1kW1lKh83WpZm_xz3ecT5Dhz
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 9/1/23 23:04, Josef Bacik wrote:
> In 3ca6ed76 ("btrfs-progs: don't set the ->commit_root in
> btrfs_create_tree") I stopped setting ->commit_root, but forgot to not take
> the ->commit_root reference.  Delete this extra reference so we are not
> leaking extent buffers.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---

Looks good.
Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks.


