Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB946A7B7F
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 07:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCBGqf (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 01:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCBGqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 01:46:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0507320D38
        for <linux-btrfs@vger.kernel.org>; Wed,  1 Mar 2023 22:46:34 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321MkvRx011771;
        Thu, 2 Mar 2023 06:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TlF9BDCYqH3sZgZbnOuSkbmay+zLCpUvTN0kzzyaAM0=;
 b=dG3FaLIv2BJ31oij8IUL5AuXgnUxdOriLcT5iAKOCwdKftVF9u+h4Xga72ua4qfvqWwH
 P+QByrTgntfG6RPnUPVcA5z5TCOMGZOMfWGpROwfp4socZQZACmB/mwsPSSvL/NKFSqB
 dgVC85+HM2qwwt9ybsyTJ/4D/43vBKAY24ISjd0X4vzdgy8tR7CMVeLAipD1lC128Nnn
 yTTMb1T9uH3042jtxNyfT7M9bdxLL3+qHvbXJjGzK+lUrDM0w27Af4gclaxkkGiPSpfH
 cUVDy13ytJzsA38+F8C4hxdudMOeEtqVZDq8+f7mZdC+q7C+6O59RshOXTsx1yT107wV LQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyb7wtv47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 06:46:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3226GrQC015921;
        Thu, 2 Mar 2023 06:46:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s9wtxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 06:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIW+9fD+vPfKpXv4VZ5vxJFWN7xfjDSw+c+M4vSgiSa/eXjjurOPz9U0YjsOi+//5MD5eovt0xYT3fW0HFofeSNcNJDhwbc2euJ3JVxwclbHoJEmLsIEnUqL00rW8vs+v024G1yMIDKLDvQd/wLBuDqexDRGsoFlirA2UfPAMPU6kdFij4CL/EewQzLVuK4BKTuKBmqExmKzx5SJJqgIMCW/ePLkCV4ZFC3qvu2pMzjI22m/oXaUM/4Iucj10xKuVlP1V+UAWxx++K4oGyn7aoPyV9dnfyaqFz5c2HsjUpMFjbISWATI489K+5StYSVpgQ87udi1kWZNUxP5vxBeHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlF9BDCYqH3sZgZbnOuSkbmay+zLCpUvTN0kzzyaAM0=;
 b=BqSe/dKkQturUnP99hqCqDjB8xkLvDpeG63XLIWYmsYA92zUaLuHLVpGm7E5eKF7Uq0Qf+lEf6taxwwpOoTBetEcrqLJ/HCuY47kYIEL/D1uDsV9/XOkwaPX8DUAabor1udJo9xw5MkVG0NV9U8l2Vjix2XCYDpmSLd95Pt18YoTVfVfWF2IAVh+xuWkZ4furEbEJV7GsLUsWRAwf9S7LIGSBD3V+OAEJJtmS5oTB6TjUPHAIfYq2VpX3pDxeR7WfKpjiATb1iLoa/a4reK/ZtZ2Yse7vHlUs/9MK3BNSU7J5vpFIup65cqCvk1zgePr5wa6Pk+1/Cqv2r0tzz6NUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlF9BDCYqH3sZgZbnOuSkbmay+zLCpUvTN0kzzyaAM0=;
 b=ActY6Uy4Q9MZC5TLilVsBsTe5YYKrxzsUTdi5kyDaP6TEG+Nrt2LNZvLruGAfq2LJ4NMqbnW/7u02H0RdDB7y+9xSynsdy8g8ArLy0z+pOCp2qAMZYt9w4r5iGX5ejkT3P2N/xu+pfYDSx6f8eOLHhHcZBHjZzapja9BLtLDtxs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4893.namprd10.prod.outlook.com (2603:10b6:5:3a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 06:46:28 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 06:46:28 +0000
Message-ID: <c08edf3e-bbd3-da0f-b7e7-af42fb5e10cd@oracle.com>
Date:   Thu, 2 Mar 2023 14:46:15 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH 2/3] btrfs: clean up space_info usage in
 btrfs_update_block_group
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1677705092.git.josef@toxicpanda.com>
 <f7a7a4beb5d9f249204fbca72a04b4cd78274c18.1677705092.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <f7a7a4beb5d9f249204fbca72a04b4cd78274c18.1677705092.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DXXP273CA0018.AREP273.PROD.OUTLOOK.COM
 (2603:1086:300:2::30) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4893:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5fd978-8ebd-42cd-7763-08db1ae9d93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jU5EKLA1Apwn3vaqQkDmFEBfo9M0gMAxeQhkuklBJsN1UCEpAKOLRpzGc4HfJZ2kV/vZjrHwno1LRJ3gesY7jd4d86Bw1IzbU3HIsvKpUGzX+yTvS2OZ9LYCKD+XgxP+x3Y1cANRulw33Dav+BBW9JzHg+T6IYFtISTD/Mvw0jVv1Xw1m7GNQHfmSKzrYBVDMFjpMIh9rxBSBjdqMU/HBlaR0OmbMtOLn7F4CTK83jlDdMdNpCOi2Klw9HknvuWO+iiP5W0jnyr1FRgJ9JUu9uwCjZXzAr9SpuYUWqrYjONdrQbS5/rOOi+ardPC9KBSAG6pLCTroTQgMepkF7KgaWPlRqBUj403F+uCelorJu/+dkkoUGwUSoLyX+IiBH3bWYw4Xk9GC9TSgzYAoZSU6Im3VC4+viW2X+AHoo9gflBY/LdmLQQyuHIOVAvJhl2Iz1r1fOIZaKF1bCxWKhqArRwpbJXN9BacHXc0QrT5/X/8Tt9vz+/4VQTQwLpKwQqy5AE2wGHIA0O9Xj4DQDV0UVKWry4ovnwt3OsLF8M0u9jgwBSJHy27xVVKHXFMuVCbwhPLEJuxe7isJZgySi5IOhX0bKa6E71fJaN19rcVHLwPYDfgTLh3g4a5fNWapZ37bctuH+UjLmCJuD1iv2R6soMHY2i0sadOR7mHgnKL/IMQ1X/4uyUf7TFSVFxomFh6UTQYJ/YqBSKlxjAdvVdFnAYPxouw4gtu0zuQWWFEVfU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199018)(86362001)(6666004)(26005)(186003)(6506007)(6512007)(478600001)(6486002)(31696002)(2616005)(53546011)(316002)(38100700002)(36756003)(2906002)(83380400001)(41300700001)(5660300002)(44832011)(31686004)(8936002)(4744005)(66946007)(66556008)(66476007)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amRlb0ppOTB5d3F0S2xZUmtYUUVXclowaVBPR1ZyUXhUOUIwWEtWcitkZytC?=
 =?utf-8?B?eWMxUmJvdXRZUmw1MkRmcEl3dlhuQW5PRU85Ymw0eXVIRXlBR0FSbVZZSkdR?=
 =?utf-8?B?cnpaZTlXcGhjOXJPVVI3ZUJ4WXAwM2E3RUVXVnJXckR4OWM0dXQ0UHAreWtj?=
 =?utf-8?B?UkE2WnFCVlovWm9yMEJxKzVNSytub3hqMzQwT01EWUIvcXdINDdyc0hmbzlV?=
 =?utf-8?B?alpzNEpUbW9KWFhjeE9icnl5WmZyUjUrUy80SHI0WTExMTN5YUpjM2VZSWRU?=
 =?utf-8?B?Q1c5ZCs2cnljUmRPV3dFRUExUUVPenNLdCtSOWhnOHZya0pVYWJJMW4yQUxp?=
 =?utf-8?B?RUw3NUpVR0R3QjlkWkl1emM0Z0lySVBseUp0MjE5WTAvSVppRG9qT3VkNkdG?=
 =?utf-8?B?Yk4ydHlYbld2VFdQRytYd1BQN2FuM3hoRDAxRlk5RHJESHB1SlYrN1JLSFh6?=
 =?utf-8?B?T3Uwb202Y0t2bEdZb3A2VnpqR25JbHNCYTRvZUxrOGMyQyt1aVdYTU9vMnhJ?=
 =?utf-8?B?VVFyYUFjWXdYN1k0Z253YmFoR3hpeHpGMXpFZlBTNDNGVkRYZWpmOWd6WERi?=
 =?utf-8?B?L0svZTBvR29iOGFxMEN2SGhRcHZ1MmFTVW9MQmNGSnZSUTVBaDVnSGhFR3Nr?=
 =?utf-8?B?b3REaXNoZEpmQ0laZ3crZlVmbDkyTktYVDlRcWRsaU1WVWlOeVRmR2J6SE8x?=
 =?utf-8?B?YnR5bzR0aStUSDNZNEtHTU9DUXluRE1aVFpVa1pWVE02L2pjWVRWYVRQaTZU?=
 =?utf-8?B?UHVHck0zaGx1L1JGNGdPU1VEOEpYeHE4OTNlM3FUcStEOWtVakM0eStaejEv?=
 =?utf-8?B?ZFZ2K0ZFREpaaDV0d1RRZjl5ZFY0VG51eUI1MS9GeDFMdjBxNFdUUGhRMFBm?=
 =?utf-8?B?QjlLM2dxMGcyRUZTZjJhZXZxVk9sS2p1VlZ2UWZCTExKWEI3WG1ocXI1MlV1?=
 =?utf-8?B?ZkNGdVhzYUxpVDZaRGVDbGkxSVg1TW5oLytmRU5nUmhqNzdEWWhBaEE2UUV1?=
 =?utf-8?B?VTRBSzZQdUEzZUNGUGcwRFAxNkJBVFhwWFp0WG41NkRmRGZ3WVpQdXg4b1Ev?=
 =?utf-8?B?SHRSOGNyemtwNW8yNGExMDVyUWNsVWNhbSs1dnd6QzdXczBsd3JJVy9CYnAr?=
 =?utf-8?B?MjA3TllpZ2h0cHJETlVYbjFrbmJMenVmcWhJQTRRQ29hYWZEVWtNV1F3R1pW?=
 =?utf-8?B?dU50YnErSTZwVHZPTi9Udm43TDlBYU1zcjhaWnRDamJ2dmJPOHAwWlVuMDNz?=
 =?utf-8?B?b2t2RVh3dWFFNVZLQjg0VWlPa1Z2QVJBN2dFQ3prdHdKbWdrYXBzTjEzMm8y?=
 =?utf-8?B?NkEweUFSblhrT1V2cy90OE00V1luVzVibFI2c1pxYzc4SkJpa1hYU3UrNG15?=
 =?utf-8?B?Kzc4NmRjVk9jZnlwaUN6RnFqUmtIdnNaSnR2SkZ6L2NzSkRHVWhETUdJUDll?=
 =?utf-8?B?UkI4bTZuMTg4dFRhcXYyWDhZbm5ZUzNMWGw0cWZuUWtlWHNyZFlrcW9KNFI4?=
 =?utf-8?B?MGRvNkhyUDVmQmNDTGpBUjM0UGU5cWJpeXFiS3VoTU9PckQyelRneXI5TGd6?=
 =?utf-8?B?azhsZHFzZ0wrYTRoNyszeDhEWTdJRmZZZE9RK3dBN3pmOFFrQktXNzNCVklW?=
 =?utf-8?B?Q1ZCWU9XKzFjRmtQQm85MVRTa2E3YklSSkI5bWNKci91ZG9FNUZwUDhLaCtF?=
 =?utf-8?B?MUZaak9NSU54eWhIRDlMcHhCNjVEanJ4VkxITE5VYi9Ya2Z1Zk1JYnpHR2R6?=
 =?utf-8?B?aFAwQy9xUlZuTVNVd3lkZXhRbjZyY0xFbXlsMlBvZzl6NXFldDJIRzVnN1By?=
 =?utf-8?B?dmRoRWRvQmRuWlplOGkrbnVqMmFvUlFiYUJsMUFzNTBVazIxektzeUltdFAw?=
 =?utf-8?B?cm9WZU4wTGxKd3pOazQ1c0ptanZwcEJCN3ArMkJtWGxQT25JcUZkaXNCVjdH?=
 =?utf-8?B?b3JuT2xiWDhEUHFZWEVEUFhMTmJFT2xvaWdzZEplM0FVWjF2b1RPaUI1NTRK?=
 =?utf-8?B?dnNDU3NaejhOVkdrVEtBcUx0VHFVOFJBYndDMUxkQzFOOFdqYXpHU1VBRXVE?=
 =?utf-8?B?Yjc1bDFNWnRURmE1NFBQZVRWY1o2eStRTS85VkQ1OGpsUWg0MGt6VWtFNTJJ?=
 =?utf-8?Q?QO/qVcttxyiUzDXlF6a/4QfIz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z4A2gL86LjAu/xC+7CYu4d9Jn/TtMPs7TeIJOPu7hF8exyUDraYHaEu8PoOmf8AXHY/itzlHD/OQNfcOj04U+rwRGJ7HysLekdMqVH5WHFLWdMHBoCNGo2zXv244nHhymNgj/3Cxrt1cnHWbOXpoe7rme7s6k384D8wfSATL/Ei1rkeAJZHgz7AEI6QiiD5yXDZQWlvlVwfDdp43Lz8A24aHB66VzncobAmNGp7tsAUkKh5g0p1dC/uueHeamrp6/H9nQxaXgUFTDyw+LxXz9QpzMRwrnfh6yAwAclo0VV5iJ9loKF0lEEmGn5+3DISdXD2cfoHeq7vSqkAfl2M7Clbuy8Nc1fWF3kH3AkvAwtHXTnSbfcCLXuB2EvXNk4UhJXfMNJPRn5mg7xmLeozfiEVFinHE2hoHs2nuxHbPznXu8CUu0BnmOknmRucexfntSR1XxSenb2b8YZ1KyFVJePFyyehkL9F7e+pmITdawHWuYomTYxd/ekrByAevsw3UN7EkaH8rWa5J4rn4KPCO31O3meKnfzpqYaYeQ2bheZeCw1Eqrt9+ML6JvICac6wgkNgxmyfsV9QnoP4QseS6poedt1QnKFNPMjKDVmRfmBkCH3c6vmr8wdSfqK6JRoJBSOtp/iQVALvToPYRngzGlX3uBPnEyVYCQaf47i9N22tb4/BIY7NCjRKOUAXlmt0N7DcDSCz4KTxlTFmdNpezQyIN7Cq/rUC1s4Kpda1HorSvMPxGLRejWj93fZdrGBCbvAmO31x5/6i/TuN/jzn9rX9wp/dMJGIMnmqdzw6pG02Ye2cWXLYrAbOY+o7O1+6D
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5fd978-8ebd-42cd-7763-08db1ae9d93e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:46:28.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2pbQhlVqJ81fDfiOxKQS83lRYhqbee1r8ohiIGXUdA6e2DWaFqmEPWCqWVgfcB+T5kYVqw3MTlkyT6zxj6P6Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4893
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_02,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020056
X-Proofpoint-GUID: E460WIZYE_-xxfeyvcpnJBG4dS70H_fc
X-Proofpoint-ORIG-GUID: E460WIZYE_-xxfeyvcpnJBG4dS70H_fc
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/23 05:14, Josef Bacik wrote:
> We do
> 
> cache->space_info->counter += num_bytes;
> 
> Everywhere in here.  This is makes the lines longer than they need to
> be, and will be especially noticeable when I add the active tracking in,
> so add a temp variable for the space_info so this is cleaner.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

