Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B231A6695D5
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Jan 2023 12:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240941AbjAMLrF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Jan 2023 06:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbjAMLqj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Jan 2023 06:46:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7CF48294
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Jan 2023 03:36:56 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DA1jlA014823;
        Fri, 13 Jan 2023 11:36:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Rrtvf1MjA5rX9OXeJY0Hi1MzsG9DyIM/izS5nIKx5FE=;
 b=RyF9HTFYTflBC8eQHVXUVgO+klemBkeTVL0NnlSMAs2KaiwJMEuSoN9lzp3YJA4fgRpp
 HhoUNF+o6ku8N5GiH6mg2U0ZZdEmNQ5op9ur25mZruw4E2kDjsqmDR7HhFdNdP3raUd5
 8v1CeQ5Ae9KMMQtv6SxAN2d2sQ9wQtJYbMUEspH2XwvkvnZZfevJtLzvRvO6RO580zTY
 ogipt+iklP+G7weRhYp4VGmr1wDdxn2Xsb2/URXaQtfkKRemSrLLRjCZJ6VelVCtQlYp
 mv/yAH2WOpT8dOI5jJ4sWPPXQM/1rPGpX1+Zjhq2gtcnn185rGPL3j9z5bR7xlOMzagR vw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n27nrbe3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 11:36:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DB4un6033643;
        Fri, 13 Jan 2023 11:36:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2042.outbound.protection.outlook.com [104.47.51.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4rjmah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 11:36:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TG6SwRZHXOaCT9uacOhfZi9JaaSw6BZDF/Zqsu664GJdgXkeAQwHp6tG3TPQ5q8xkWlsg98lmNYOAZidU0r4JPUuH0zzisIi5PYGAUY/Y5PAeUEjOCp6OmOdqxcxabQ3BgjVmZ7ZrirTfPJcDuevpq3kcysjtikLUbRlbsVvKNIVNKpRBssdSl4nZWJ8EiMZDq6m0Gdfi0nufPXT/6u8SadJGhiO9Ch/FgxE9dGxX2Tu6mTBA8n7+FUxsbur+FU3h96Jx0VeFQW8f3Id1NmjMs07+6wmyGvr6Oik2etuIF6EzKZhNtQIQUE6EJnINE7m+uD3r+LBHwcrvtzKcEt/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rrtvf1MjA5rX9OXeJY0Hi1MzsG9DyIM/izS5nIKx5FE=;
 b=EN3SsoUxvnOPWjeivY4Y/KqcFoSnnuWjh0WZbme5HjQFNg1P/MgveuobLGbCx2kcdJ9bAuGS24MjvfVTPDPT8D45m2V5z1PQQ3F9H9v7xpHc/X6MwxPDUnOirIIZ7BaB2om4SAODonY29MDAyT+5sOWdocp0W+1fl4TKGpY0Jixek/TdYX8EaFs55Kr0LyiwqMwLdETXfW1mC61vYbKiCMXRrYrgcVyTO92tr32UdxYR9p5E4pZJE4e5nQ+WvZRyQnD/KSjb6elJ8JCM4bSOSXt42etCZQFUzP3DpxNGSEfJhu+IAL2d+kabasB6kKMZbFMD3SpxBSaSZ49sVf3ogw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rrtvf1MjA5rX9OXeJY0Hi1MzsG9DyIM/izS5nIKx5FE=;
 b=Dng3lIH5Prn1mqXO8PxIFEmEOxhYYGWukm3IrpxFJlys8erbsijZfh6oGab8UUTq9QUr0Ajm93lR7Jmk5wMeePpmd6pYgyc5SZFmg3dC9MH8YHVMvnJC/meLJ+DvrdRhrwjQ2vbAO/WFtNri+eKCZ0KXlHPQgqupUia0tQ9UHVM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM6PR10MB4218.namprd10.prod.outlook.com (2603:10b6:5:222::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 11:36:51 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%7]) with mapi id 15.20.6002.009; Fri, 13 Jan 2023
 11:36:51 +0000
Message-ID: <35eb72f2-b910-65b7-b637-32ac5b36d22b@oracle.com>
Date:   Fri, 13 Jan 2023 19:36:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH v5] btrfs: update fs features sysfs directory
 asynchronously
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <c750a14702a842dcd359b05ee79700ae0d0f550f.1673608117.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <c750a14702a842dcd359b05ee79700ae0d0f550f.1673608117.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM6PR10MB4218:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3ac117-fcbf-42f9-f204-08daf55a7651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xu4zVeRDs8uaWba5yHz/SGJBR9jK3ub5Od8DqBHGhZ+NNFaWwk1CuTH84FqqyhkKo73PAWcBLYqepO/C5J+a/HBcaXlXW7MsF94qLlkWlq3zjeK6Hi8dMYVlaeBKWUmko4BMdavTCQ53f/Z/qB1fi4CzVpuPfZeybo4foj5vS6Mp4X6tXEcYsVYLrpgyWMxkpmAeWS/FUet1KLouaLupIfKPS5zAGP1FL1w690VLiZp01aZh4q5ahT0UzyQaz0NEnqCWOj13DVXBfhoBjPSqrTG+XkhAf51wsvS3+ftjTimTQKRDYnjWVZb1R1cnt/JG7GUOCBoBIhwEnSRYmc2vRrzm2WPyuv9gdWf1mtSFvV7E6zEj046KXzTq5X13D6lCUVtiwkrWkZf8dzISJOSZnfzPzew3gSU4qlqnkDSBCe4yEFYj32LaRzVGiXKx8t2gsPc96FDYQAcF+YeWZcBD7yFBEC4cv9nWme+73/Eauyxh26MpaQdM/o46MHs83COGY/5eV8wocVSFKDveEbL7sWgo3wCBtu0AjJzdc+TfJgEplrFc4TinH/zzykvJOcwaDwnn/uYN9qhCVG/OHWH/wj9/dgn05fvJuz9VxKpb3wLYmDm9Mgf4A8R3D/n0QX/qJWCFnLG+DFhZhLfpL2lV76Wrb/cBytLX34k/iAQY3UlDGzDvJP1L+XXX0yUAy9yp23EISkOuEHMDT3e9gdr/QjfuSQiyJk9fPlYgS5aTa3Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(366004)(136003)(346002)(376002)(451199015)(38100700002)(31696002)(66946007)(66556008)(8676002)(66476007)(44832011)(41300700001)(316002)(4270600006)(19618925003)(5660300002)(8936002)(6512007)(2906002)(6486002)(2616005)(478600001)(26005)(6506007)(186003)(31686004)(6666004)(86362001)(558084003)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnlsWk9kTXl1eVFIWS9iOE43YnhzUjUzZDRFVWdOVElIaDBEZDdhZi9BZmJX?=
 =?utf-8?B?VFNhL2FmaWNEdi81QVJZSm9Jb0trVGFvdDdvbVk1dW5ESWdnYTRlamRKTFBU?=
 =?utf-8?B?djhLd1BtNUNmTm9TY1hLMjNvdGVzbzFldEZJeTdyVFlYWjMrNnBiV2lxeEZT?=
 =?utf-8?B?blgxNjY5elVvd211Y1NwKzhoL21qVlBjRTJzODFmZmw4WW1Ic1pQckdqWWds?=
 =?utf-8?B?RmJjVlJNRXY2eE1DVFdtaWt4dmtUcWFHU1ZlcHQrTmJvYmFxcDVydkRMTENm?=
 =?utf-8?B?QUlKakhXU0JmZmhQdmxmdGROWWkrYUNmaVdwZ0xlY1lQdzFYelhreTNuN0tY?=
 =?utf-8?B?K3JkRGZrSzNoa2pLek4yUmZCeVVpNmtaUnpPbTl6bmlqN05kRTgwTDZEd1oy?=
 =?utf-8?B?Z0hlZWlVZVZYUlBMaXhxTHBYT1pNc0piRFI3aU5PcFVEZzBrUE1pZVgyZzhi?=
 =?utf-8?B?WE5UMUFDdG5FWndwMXowL0NHc1lzT2tWOEpMZmxNank3czFqWWpOTXl3a0tB?=
 =?utf-8?B?RHVhRDcyU2JUTHVKcWErSGQ2V3lCTjVCYlNlOHNTcW4raWRRbDNRY1h2bFFN?=
 =?utf-8?B?OHhXb0hONXdlTm0zbXBVL0VRamszVy9MdjVXK0F6SFZlc1A1MDQzemRrR2d5?=
 =?utf-8?B?SWRUMVgrOEk0ZTJTcjJGTEpncFpWUDFKb0RNUkhmRmVvZlU1R3R3MUl3eHp0?=
 =?utf-8?B?aGVNZTBRaHZRSHZqN1VNVVdQajlpclZDN2NyWS9kYlhWUlQxT0p1cExZazVH?=
 =?utf-8?B?KzNKNzFyMFdRaGdBd1l2akd5RER4THQ2eGlrQUtMVFVOd2ZTNDlleVlGZGkx?=
 =?utf-8?B?Wndyd3NVMWpybXUvN213aEFYcWsyYUxVNWExRURaSGsybHRoSEFLQmIwb1lQ?=
 =?utf-8?B?bGNvV0VNMnBkQzFXQjZZa2tJL0FrR1c0UlFnNmswNXByZkNsWDR0SkpNQkpP?=
 =?utf-8?B?eTVlTTB5bGFQN3JaS05kSjB5Sko0SGwweTdTKzBMVmpZKzJqUnUvNzZGekwy?=
 =?utf-8?B?eWFWUnRNNW5KY3NXY2lOWCtWbEJxeVhnTlFGTFhwVnlJYlNVS05FZDRqZmJz?=
 =?utf-8?B?ejZsK1J2K1JRbmZDY1o4RGJsT3F0bFNJQ21vNk9JdlA0d1dHRzNIT244YlIy?=
 =?utf-8?B?TzBiWmpkYTBOdERTeGI3Z2xHNmRhWk1tOGkrVEgvVzVEeDVzbmg3Zlc2aG1J?=
 =?utf-8?B?QzEvWWVTZVBmNXhMM0J4aWRMcDBYSm9RSnk0emtOS1ZjYzR3L3lsaS9kclNv?=
 =?utf-8?B?ZEdpL0FrTFhzVnQzL0JQSk42dWZLWUxMNTlKd2NpU2V5blkzTlp0c3lPK1ZL?=
 =?utf-8?B?akJ3S2liZ21TRGVCeUJSUkZBWUd2UnJHU25LQmRsTndJQXFVdFNNRnpNVHlT?=
 =?utf-8?B?dmNUVE12TWczbmxZN3dvY0V1NExpRU1rVXdMQlArT20zdjdVTzliRzR5OVA2?=
 =?utf-8?B?eWJUYU1Qck4yZVhWZ0lQMjM4RXVma3Zva1VrUWRNUkMrUW4xcVB1YmxQL2RS?=
 =?utf-8?B?YXkvclpiNjFkcks0NVQwYklCQlEzc0V5RU5jUXY0R0dRYWhCWjJYMTFTdFRY?=
 =?utf-8?B?T05SMWJQVU0wVGsxbjJNUStlVWU1cS95LzdvKzJMZVlnelVFSmg2ZUdMVGdj?=
 =?utf-8?B?YVNNWFRmOWNUNXpyb0NRaVMvYmNEQjczY1hiZC9QME9tYkQ0NFZLYk9wT0lk?=
 =?utf-8?B?OHZQWm1pN1QvTGZFT3lwTXdaMHdJL3Rqb3dITHBaZnFEV2hibWNFaEdNTGtT?=
 =?utf-8?B?OGNWTForS1lwaU9HN0RZQVZSRGk3b0NpZmw0QnllU2I2Sm5oV0NDaVNhVWhE?=
 =?utf-8?B?dThhUjJMamo4RFZtcHN4TnlRc3lZMllWZGU3OVN4cjFaSHFnNm41UndtclV0?=
 =?utf-8?B?K3ZMZGR3YXhsQk1lU2tzY0hHL1lpL21zd0FwakNjZS8zbHRPNGNETldpWURx?=
 =?utf-8?B?bmFtZ1htT3NIS3FTUHo5M1E1M3FjWmVQM1luUWJvMGFUVDVMOHh3Q0FOejBq?=
 =?utf-8?B?T05lZ0tXVDVpRThnRHVVZkVHdkQrZnJSdzZrOW5LWGNKOUxlWDE5THdsRjdN?=
 =?utf-8?B?TTZ4QnpCakdlaFZCekhHNW1XWGZzQ3hXdERHdThYN0J0WTdaVDUvT2hjMlJF?=
 =?utf-8?Q?7guoW5xp1TonQovwDqHUndJWA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: pQ09pRYqvcmlrpyt70D28Zfpp20Z1orknhFL6TjVRJ/EzxM+66hKDoZZMS0yVib1ZprSgif+gZXS/OZYHLLaIJsOBaPiwVbFSZIRR8UuaB6rTBtfhN0WH3lTdEzSLUpi5ObIXw+bxlAoQkXfehIJaV88Ir4xtdbXB66cSm5e24JfQcNVBSgHEPhB5WhveBwBkCUv8NIt+LoAhtr0AKpWZEdVhNJi/Ro4FndQJKHBy1vQ7832l+ebghnwVjUZAxGeuAAQkpeQR6f/S5Xgyo07obUEVlulawvO+iZP5qjhyp+USwUrzxCW4xPefJoNYMbP5grIHJlNO3b9/7v0icY9HvZ+dr2Gvh0igtIHcIV731n5FYinNcc8OUP1346Q2qBW7OjNisu9usGsu8cbJ8ONb0WN9eO9PgUemWcHTFrn9Jf/MJO4KBOGRq+Tw27Yze9sWnvKDxB+OR/xSWZHs5wgVeTfuk2J4cE21m9XNhWGp2DGVS7Cg7yR0GzVrzaPgo958RgW9wqi9RRl8OVd1a9fXfDZjm2iwtuGhPoEE7daTgBXZgPOkO0xrlwx3wnQnwCe0bg9X5crFqhUZk1ANok/GcNUKYhBWWGi0HxQtf81QsRFPqXxVy3ncWw5teoRixHRydAP4kuWOzxqYn4nlwsDfq/qo88+XDcFeZfyCTgYMul5YUEQpBSa4gm6S4sjvX2zGU2AaYaKL/AiVnaiR+8Q59UQP2QFOYUqZNZKVUDYrYemOOnkmus7sOugIZoP7s6WWt+iELp07r9RcUkvW+o59SShh9MdWhmkzGLxJSXxUJg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3ac117-fcbf-42f9-f204-08daf55a7651
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 11:36:51.1351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfwFOyEOzGXo8JYVSWVTZLNBxdZNtWVbiKC7YZDob19/ss2jBNERKepNYWAen8BKzYYpYWyYprVecpzkqp6L5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4218
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_05,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301130078
X-Proofpoint-GUID: ifcGz0mQ-o316U3c4on7ZIJcmqfwKI9P
X-Proofpoint-ORIG-GUID: ifcGz0mQ-o316U3c4on7ZIJcmqfwKI9P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



Reviewed-by: Anand Jain <anand.jain@oracle.com>

