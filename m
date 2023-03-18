Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74C86BF9C2
	for <lists+linux-btrfs@lfdr.de>; Sat, 18 Mar 2023 13:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjCRMLv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 18 Mar 2023 08:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCRMLs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 18 Mar 2023 08:11:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3382012849
        for <linux-btrfs@vger.kernel.org>; Sat, 18 Mar 2023 05:11:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32IACJDK022007;
        Sat, 18 Mar 2023 12:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3JwkYljwv8LFXh4YI/EOnsQkjWLjVY6rsyPQqVBsBLw=;
 b=Hq+XpeBUzz9VLKOLoguQMjh5R3j9pUq7KyYCL+SXbEJMmnI94aRXlG/dVynzmkghkFeZ
 AtlDxtjyHK0s4rMg0yxfCbYg5yeWuFqg2G1F+kdVCs8lR9YW3O7egwcQ1sVXY/7XomQ/
 cfv//f+BWb/9fWtGgcFjGftLmhHrVlW/RxomBMGoeoOutWAqUQPwVO57FcjJ4nQX43pP
 XpMnroP6+zs/arMYhOq5JTwmGYWCXGpJU9onQypSkDTU0RLKZjYJUZpKF/3b7eRmT/iD
 2YMMqF2n2Ylf0Fr2qL2u9TkYAvn7xh/NBnq6sMa/lfbKg4qqm3r1PNQBYWMCCrq8eO/I GQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pd3wg8ptm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Mar 2023 12:11:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32I8RfxI013417;
        Sat, 18 Mar 2023 12:11:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2044.outbound.protection.outlook.com [104.47.56.44])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pd3r2n3d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Mar 2023 12:11:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NApM2GTKb+KIsZOV3rV/ejx9nqBfA7X69adRgU8xCBFERkqBV3BvfMnsPoRbEvaaJ/NxDjmhrZIiSR4LDJq3/FdtK3jZpJdBVrWIMOjcW4eWDTJpxYt6fHx5zge2j6Ry/D8gQwgoFQLKQyTxhtqOmuzTNuOxwHLQXEeo2TI5GseSgQoOuL1i0lfPqMjQTU6/Bfsqd8wu4DkuEtxY3KHJjgNCqeQ1USV+5chjOjNU+7e2gF0RH6y9IA0i3hF30lPM/HluKLahKf3NLte+hJMCLZD/2BYhCtbAldvkcy9DGsjcM7M7IK6iQ3YDq7JBKJUa4f1GD1OlhNfDXT9QvovkGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JwkYljwv8LFXh4YI/EOnsQkjWLjVY6rsyPQqVBsBLw=;
 b=Io8jKXBnw9hJWdAcuTlxqj0d1gfgufirPOz8DTxLfpRnF0WjZH4wF90MQCXFPUdpMr1fyj6ula7aZgcgI/g3ZoJBSS7LaMEDlu1hN5/t9VixV4c8afgWF4S7netWqPozv2SndrK5NZI6VikgnClT4oaZ2uuQyumbEqYv9vW5oaxdHwaBezrdx5h7FqLoAeZDfkIOFnsRgJb0w9bKuOrD5oF3Jf4AEKOqTAZFFGDVH/hg1PlpELdRVOdgE+IQbxaX9uxOYDmItPf4Vklw4Xr24V8P+siKIMmb1ik3MFHxRY2q+z6UwaD780iPNG4AfrrVMect1kcm373rH6VsOnfpkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JwkYljwv8LFXh4YI/EOnsQkjWLjVY6rsyPQqVBsBLw=;
 b=NP/uD2DYpLv0wic+YgsdC4z//E9MURus99UNdBQXM9+w1kMmnQq0KlIFQG0iA9fXRl6LItUhIxPNFtncXtNdkPIVK+5hD2tsFkIeCvaKvZ4gs3WgsyUxbZOOkjMvzGeBBi9zLVxR4WSYdgcMe7ORuftJtwQXtxK+S7ELrJybDmU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN7PR10MB6452.namprd10.prod.outlook.com (2603:10b6:806:2a3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 12:11:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6178.029; Sat, 18 Mar 2023
 12:11:41 +0000
Message-ID: <4e9d2860-06ed-b0ba-588c-67f6c78920d0@oracle.com>
Date:   Sat, 18 Mar 2023 20:11:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v2] btrfs-progs: sync ioctl from kernel
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <4fbc61d726ee1830d3e24313b7bf6f8a763951a1.1679098064.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <4fbc61d726ee1830d3e24313b7bf6f8a763951a1.1679098064.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0108.apcprd02.prod.outlook.com
 (2603:1096:4:92::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SN7PR10MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 985a51b9-e879-461e-4683-08db27a9ee69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0z0o6TJbRX3SZk8iq1LhNjTQoEO1CPOEVfujtsZgtv6qkZM2wPpX/lUhs4gTShxQyMnCLGeQrCRq6bwp9m4eaFZspssrhyGzOAsyrUNyqVDAE6qYSQBm7vbX/fSUgb6qDMS38ZLVzQrQ1suaGj9Yx3pBkRVghLG4hGes2GJ6z1SSwY0AFF1ATIiBoFmwzFZb7F/rv4qRZa6S+OK1vEI3AKCex222iw1gHdS75bgoo64RTCmnzVVqVdDL8YR5QoG+S94W6a9/3jgHE41gARPuS6s8GMqx3bhleM6j/KBPYi9R8cPmR7I559CPxICSb+HCEzKzkKqqWWhsdgZloiJUWfnyb38Gdnn6kEpuRqwesD/deyyVwqA7aDTmGWQoOD8i6aIRueikJAAvgN0eU0rhaD8cidbU4ZE12trGzMAZL1ajqvToya1lqvPVps/Q4DB9LC3/t2wEg7wGKmKGQz2DKnmubc88wd+ayYyZt6mlpCuRn5ifZ8+YOX6v2CWAQl6LuVAdyJkUo9tJlp6vrDDBArSoWUu2MWLe7MWiL/kGRNd4BIvzuJk4W0pu/G/pq0/dpFglqu8onp6wLu+sLiA3+SppW72A3FHgwJYbXGYIKXQvtg6qQgdR4bGtdRmvoG6Ofnc/G1gLP99VyPXhnzpEFqqc2CCoTjpkQJXqUq6qJSUJ1VHOeHMNkUDHw2Iicde5yk6RCt5yEBo0ZlGtAu+qAHx56t1TwmFH+Y+TIht6KzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(396003)(376002)(346002)(39860400002)(366004)(451199018)(86362001)(31696002)(558084003)(36756003)(316002)(66946007)(66556008)(66476007)(478600001)(8676002)(53546011)(186003)(6512007)(6506007)(26005)(2616005)(6486002)(31686004)(6666004)(38100700002)(44832011)(5660300002)(2906002)(8936002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qll4UzhreEs2YmhKL0d2b3hJeWJRTE5zaWNiWVdrU1hYcURlY0x2MlBSZytk?=
 =?utf-8?B?SVc4VHRONGg1dUxWUm93ZiszaDhuL0NUalZ4M1dQR1ZBY1hrSlpMWVkvWDBT?=
 =?utf-8?B?YTdvNzVrbStXbjBVRHVGMm1wKzRBd0NZTkF4QWY3KzJSdmNnZTNTZzRQUTU1?=
 =?utf-8?B?dFEwS3JCcHpUSkxkT2g2aUlNWDE3S0hvczl6Z2JPQlh3eGtsUUIyTHg4dlYy?=
 =?utf-8?B?SC9BeDNrR0kyY2FjK0hRL243dHlYRjF6dHh5RTc5K2IzczNQamdXdExiRTZj?=
 =?utf-8?B?alhIdmRvcmRGdDcwZzlad3FMREU2VG1FNzh5RjdjdjlKVmJzaVFQR1p2TDUy?=
 =?utf-8?B?a2N0SzdlQ0Jya1ZXT0swWDlOODlXVVA5dGM0ckRxVThvckRNbzQraDY1MDY1?=
 =?utf-8?B?N3p0Q2dPQWcvdkZSMGtkcEVOS1J2a3J2MU01RzV2N21xRUpXUFcxV3JYaDZR?=
 =?utf-8?B?RS92SER5L09XQmlmdStEZlhoanpQWnpHTUFsSDJ6ajRJeUV0YVpDeDdXVzBv?=
 =?utf-8?B?SGY5MSs4MnowSzEvbmlsTFRCU292Rmo4U2pIRlFmZXJPQStrZUdGdnUzVlFr?=
 =?utf-8?B?NE00ZG5hVmdwNnpXd3lXUm9vd09CbmlpbmlPQmVxWjhqOWtucnBIT0U4V1Rn?=
 =?utf-8?B?T0d5aklzNFZaNnlsRzFXSDVTZUplU1F5WjdDcU5uRm9RcHQ4YVhRVS9DVHRG?=
 =?utf-8?B?VkU1dHBaMWxwL1g3anVQYkRYNDFWV0VoeXFia3Q4WHFOVW83RktuRStmbDVk?=
 =?utf-8?B?RDhQaG15Z29MQW43OG9abDd2d3dPZmVTcXVPR3AvVC8wTDBKNmpveHE4YVNq?=
 =?utf-8?B?K2dCR1QvTFpiTDd6blNVbXNoRVcxd2RWbmlmUXBZTU84MGM0dVlEMHhKSFJL?=
 =?utf-8?B?QkVVeXhGRVpBa2dtNEdwSVUrVDh3K1VpUVhoRzJpVDBmZmxidnN0WHI4OFFp?=
 =?utf-8?B?RGpqdWw4Q2N2T3hVSlF4N3AzTlhhd2xIUFNJUTVNeFRZOTlES2pZVktEMWJD?=
 =?utf-8?B?NkI0R09vQnJ0T3cyN1RtQ3FZU1JpdHVJRXd0eVFGZDJWRFBMWkRDTEF0Zy9h?=
 =?utf-8?B?KzViMkVHRjNYWDBNSG95MmptdGRnYnhEb290MEwycjRQNDBvV083NTBwSlox?=
 =?utf-8?B?OFR3S2JvQ2dSWFkwYmpqNGZZWDRFakZtVVZuOE9CZ3JoTDdaR0lBNENEaHdj?=
 =?utf-8?B?OGpyeTNqMmEzU053eVJYTk9rakdmT3Nua3VzcGxqTkRKY3lkT3dSNld0Umlz?=
 =?utf-8?B?T05jQW1kOVNubFNtUGtaVmw0Z05jUTBKYzBjZ0lTSkRnYUJ0bXJxdVZHT0tC?=
 =?utf-8?B?ZVlyd244bHRLNzhMeU14c2ttRExCNm0vM29mOWZTaVFCdTFTVXRmNThIZm5K?=
 =?utf-8?B?UGFVMmplOHZaa3NLVTV0ZU8weUNrNEZqVzYvYS9mbVQrRytmNEZNQTRJUFJO?=
 =?utf-8?B?bjV0VnNJL0VDZk5tNzVnVzVtd0laemROL3ZqdUFUYlYyZ1VIaEJwQittL3k1?=
 =?utf-8?B?aWEvbTViS0FjWHl3UzBncFpVNnBaV0ZqVW43SzFuYVRBMUVibVZZeFc0SFVF?=
 =?utf-8?B?ZXRPckxqZU5zNktXVEdXRXFSTTdLVWFhZTlaMmVvZzdUWWluWngxMnpqZW9w?=
 =?utf-8?B?eUhXUzRZZitoV0JFR0d4YWtWd1Ziajc0SWVSeTZJdVRxNGZLdEpnbGFnaTRR?=
 =?utf-8?B?VUR6MEJodTdMNjVCZTN4L0Urc2NWTnk3c2x6OWRsVWU5Wm5XeWUxdWpKM3Bx?=
 =?utf-8?B?VE1vRWRTYWhhMCtUdFVCMjAvaEhwd1hyVWVVVHREM3NlL1BVYlNIY2MveXlw?=
 =?utf-8?B?dW9DSUZhOTltU2dFWUJxeWY1UFZ2Tmo3R2o1S0NjNWVvazFkZWRsTlhZSnpo?=
 =?utf-8?B?dHJaZ0pyeVpyUnBjMUdrVWkzbEorQkZVOXFUbXcyZXlqRm9hNzNka21icXlQ?=
 =?utf-8?B?QVJqNHovZTdhOXVvMytpU3NrT3lNRWFWNy9EWEpGQUlXRmtNTkljSjhjNDVr?=
 =?utf-8?B?SXErWkIyTkRsMTRaZjBlVXBWUnJhM2VRTDRmV3picExVZE9OYVhKVzFESTBh?=
 =?utf-8?B?REdTUERZREluR3diNWxZcmVTcXlTMkJSQzcvQlNidldxQy8xVnNaY3FZVnJS?=
 =?utf-8?Q?Zby1LRwsOZYGTANwqnPV1VLpR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KmAusjHpzGwVqV88ikpBL4hA5H31xzRe2l1TMzfmxzDxdb7j0f3YhChBqWkVpWnf36nW7LjSCeQJpXon8LuXi81tZmp9+JxWL1x7TgEp4FxAiBe3ALGL+jn5C1k58BV+KUfv1iRRkqU5uQzzGiDn2DnOecCEQqgGOA20ytu92y6PttPB2vwAWPiqDegGK8muz0N9St4isfgLWVEFQSV352YEvPdlU83d3z70Ya0AsOidmWXD7N3GhCyDxV2oC5CKE8SfLZxzfI6kiRQYNBv3x7d8ll2V6BScvEYSZW62AleXbJ5auKCNtf5PLP2JTikq1reLFNm5I1OtBZY/0viXL6Fb0kKOby1skJkChCxyAt6ijllAyea/65GtI+W3N9sdRIcsaGalRfpJ8r7a2AesDAhEkHZvZDvesv/C6Zoblik9zM5PJ2OB665KGOSP/zCtCb2sj4H9ou9QlhZ1Cke7tDzIG4LskBr4b6z4D80xGpdyjgg3wEcVTeGcO7/oco4xgXCPqkMWFr8BkZhxGVozSnbiB7Kc2ygeH5b9kiLhINtZeJRsXlRRnlpyjk9xerod86RGJnoThB4GOUmAB3PcV8bDoC8BcrqQdFdxqA/uzvgyrwFKY6WCiki45q0yeOyCF2V69PbZpfTJlJ0MpVqLjKge/pwDceoPgCwWvkdyJTlv/05Mpq6GCrAzyQs3vneUuyOYQdoXRyNvrmY7guv41b7WAb8r4FTyPHb3NZqr1e+DrtNwzj9sw7SaS7kZxMCXFMj7x2ov5XiIdKyb0XvoWvcfy+cq6H2G6jzGM7GB9UA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 985a51b9-e879-461e-4683-08db27a9ee69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 12:11:41.0135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tRcStSrh0lz2St0hGkaR9e8J5Z1odFY6FMmmccM8ead+M4zIPfTTo+kP55nHXMAp6hirmrgYPzyB287P2nzdyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6452
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-18_06,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303180104
X-Proofpoint-ORIG-GUID: a3WwETrsfYgHUDSnXAukShJhPbEDK85k
X-Proofpoint-GUID: a3WwETrsfYgHUDSnXAukShJhPbEDK85k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/18/23 08:07, Qu Wenruo wrote:
> This sync is mostly for the new member, btrfs_ioctl_dev_info_args::fsid.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>

