Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB31B785A84
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Aug 2023 16:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236428AbjHWO3s (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Aug 2023 10:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236429AbjHWO3r (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Aug 2023 10:29:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C16E67
        for <linux-btrfs@vger.kernel.org>; Wed, 23 Aug 2023 07:29:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NDuJmG026398;
        Wed, 23 Aug 2023 14:29:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4qwpjvSuwnEFmTpUAYiC7iNvWsRL/+6gc6bysscNjP0=;
 b=Ymeoitw6yab9XE6N5PajER2bIIufeMyFQzWh/0lrawccbjtqF47tS4rVspdVebnjwf7g
 uQcBS5nO9f+lb/vMhnM5yQSPKrw2uam1o6KDrfpQkJOOkFUI6e8NoRSO7Lifpv2Un4oi
 N84ETaf3HaiucFpLClJBVaOIlBzftoNqOmIwuet4/H/jsb1xhpY7a3QChDVVQtpwnEpD
 QilJv4hTZDa3hfqb/1lq0sKSppquXn5y82eW8OdsYey3AWjPijvxi6abNxQNjIRN/WdX
 jhC71g6x5I60qf2EeavDt8dToNaFDu96ELg53uN8azanVR+ZWAvEL9sJ8/a0EGUze4bY 7Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1yvsy76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:29:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37NEMxDc005758;
        Wed, 23 Aug 2023 14:29:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yrw3sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:29:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AT+sG1+Mq7w0i6HHk5dyfOffP3yleKb6dst6pc2NyrcFWK2z2YgnXPlECkKYPzt6UkOc3LanX7dCv5gwxnCbYkw5XfjkN53QUxxxtF+n48MPc7zg35k9Y5KoC8wguFvaVTHK/BggGtu8h9E+j7YK67Uq3Bqok6XOcJaLwALznv0VovuIBtzgPqkifm1zNNCmV6TDQWJzgR/LlZg1ntyU1v/ktCX9GzUs/CWgtfv3G6xCBU0okWIX1TzHJ/INRx4G2v/YW54WrqeHaw53c+eBcr7cC24cDU4YnzWu2D8ayUILMK7Xw8vppVV6M18M9wBHJ1L4wzr1E/7N/Pr64VQ37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qwpjvSuwnEFmTpUAYiC7iNvWsRL/+6gc6bysscNjP0=;
 b=lNMH14Jv/TcFFAAn00fab4qGy/naAb03Y3LIdlRs/AZ1Vt2MKrAB0ay8rDONT4huDZw5pNzR+qGOtKZ+0B8yHbZfPdCrPKWj4Xsc06GbyourxFKem/FWr8bvrUklsTX2TbiDuaZrSSPRMc/INPaElGea+vzsasfskBfWtAdplCITjDutj9nJlQZdWXYLBB3pZwC+tjjx9UXqIuRQtwFlnvrs9qhkzE8fmtPldA1r7QKgwd+wJgmuTchSfSsS2ykL4eFHppz1qQWvkyIwcThpCZnzxlWcOANj9zc+pdrWUq4WUIknVNLPhy36Crt6q/AuAmcpHeyJ/GZpy97CLkDJYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qwpjvSuwnEFmTpUAYiC7iNvWsRL/+6gc6bysscNjP0=;
 b=gKYaUFT1W3CslCeJ+q/ClQKfWLukcmocUGFAkwpft3YdQ60O1TR9sm3iPz0IXouf96HS+NwbyDLaRCBiRGUeKP2iIl9o0SeNgD3Zt6JU05Wyr3LrSGzAvU2pn3PeKdfRM3rvgvyDS8uT4naUg6hhutTghjh2vdFxp33+n9R7tBY=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS0PR10MB6727.namprd10.prod.outlook.com (2603:10b6:8:13a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 14:29:21 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 14:29:21 +0000
Message-ID: <7fca4273-6266-8dad-f1fc-1704dbbd937a@oracle.com>
Date:   Wed, 23 Aug 2023 22:29:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 03/11] btrfs: move btrfs_extref_hash into inode-item.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1692798556.git.josef@toxicpanda.com>
 <cbc6dcc234fc794de58b8786351b24f1bc5f4f9e.1692798556.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cbc6dcc234fc794de58b8786351b24f1bc5f4f9e.1692798556.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:4:186::21) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS0PR10MB6727:EE_
X-MS-Office365-Filtering-Correlation-Id: 11361b58-c269-46e4-3c4f-08dba3e55775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HyZiIIdeJCyDba+hsa5eJ57tpdG0DZYXP4DSDy7qlYvAf3zG73VZKMINCFSSlO3HmG38NYxhnM6Y0/ySqcC3Z00eZD6Us290gM/h8xiGrOKQEy0N72Ydfn8pyWjDihmMk8x+bc7yqdXzAWO/W3YEmRIATCE22qQ+iykanEUSMKWKKy+8/XCIR5QYxUmmKuDhrASZLBBI8n9E2GyQYt+69G0LGgHEtN3RK/5hJ+psg28MAqGBq7JOdv1pjxUvBkM1WBqusjJsHpXQKg7xPZ/avmrBo9cWT+SwjuLH3nh18rGi82xe7YKkmLxdPOlYAB2BPPqLYtJRIP7gytI7v9yTi2oP9BVv19juuu+INFXBxKEVBQTFGccmF+fL4duDCucF9Gu/gsnoF9yxwlBNOFKjiNmbOWTvZz7GMIvBFCiLIidUz8kDTWs7ZxUsoabFem6GljhUnSeO7LUtexSAJIrBdXi+3t6V5lHBdf4217UcKhprTFb656jH135/cMo3CKvqfUyvwu/626LteyzF+sNPGKw9I4rZ6uJO/XvyVtYcoLPzGq5OMbjbcwdH29CHmwOFOUnEF1cS1JfsUMnG7pK/Ck/KyFD8IwJ4iRVTT/KWMqJg0dfjPrXyN2F2NrR5NZFiQ5kMurfe63a8wG8eAXO6CQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(186009)(1800799009)(451199024)(66556008)(66946007)(66476007)(316002)(6512007)(8936002)(8676002)(2616005)(41300700001)(478600001)(36756003)(6666004)(38100700002)(6486002)(6506007)(558084003)(2906002)(86362001)(31696002)(19618925003)(31686004)(44832011)(5660300002)(4270600006)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE9zNWMxZE55a2d5cnZ5cHhDVXRXT043cDkxMlBScldmUm11bkkrQWRHbUhO?=
 =?utf-8?B?V1ZNc3BBV1dteUk4SzBhZWxDdXoyWm9KTEVGSExXMmRmK2tySXMxK0twSVRO?=
 =?utf-8?B?T0huR2VVTlZOQlJQSTdUdUxUT3UyQ3lvdEJ1cWhJT3B0WEMzdnp6R25vOU9o?=
 =?utf-8?B?VDVnVnJvYWJtNU1BeDZOdTUwSk11RzJmcUQzVWF2cWlOcFQ1VHVaRFNUSGlC?=
 =?utf-8?B?bVIrVzZHZmtNamNDT2MrUUdGMXdjUml6RjJIZERHb041QTBmLy8vZWRDYXlR?=
 =?utf-8?B?Z1h3cUJ2d1p2N2NJZTBIbmRPVWRJdERza21VNVhCVHQ2dlF4NVQrd0JVOVBE?=
 =?utf-8?B?SW5PWUZmR1NZTHUzMk14d3NrOW5QMmFCOUtVVjlJQnZ2bHFzWDFKOFhwZGp0?=
 =?utf-8?B?WjYydnlldEhxdVo0K1MyNGpmUzRWT3prUVNydU1JcGg5dUh0bFpYeDIxWHVG?=
 =?utf-8?B?M1RaVXhHZ3hyYUFUZVBBQlQ3aFNRcFRxNjBKaTJBUnZWTzZ3YThLQllrRnFl?=
 =?utf-8?B?eXl2aGNsZ2tidmw5WFozc3d4aHVTOHBNY3J3dXljbnl4MzJBcmJNN0swenRC?=
 =?utf-8?B?Q2pjNjFnVWRBM0FIclY0cGtLL1JnSkl0a1l6djhxckxzQ3Vnd3MrWExuL0hV?=
 =?utf-8?B?TDQ1N2ZBSWIrbUUvdmxtNVplN3dpa0FEOVh2MDZNNTcremZHSVI0a05QNjZR?=
 =?utf-8?B?SnA3Nmg3UUxHREZaTEtYNWtwQUZnc3V2T1RQcncwdmFtYkpINVFQdit6RjVD?=
 =?utf-8?B?VnZqalp1ZlV6cTIvQ05nUGh1dmsxUUFwcGN0MitGVTBQNkxUeS9nNHFmY01H?=
 =?utf-8?B?SWF2TkczaUdNRnRpV3A3VXZtNXFZWmFtSTVjUzZrNWdEZk80R2p2VktMaXFl?=
 =?utf-8?B?OWVPaVAxbU9JNTlhaUV3Tlc1alVrVTNzcHQ4ZGFjL2I1a0VUSDFTK2lkZXF2?=
 =?utf-8?B?bC93RHNRdFc5R3dTdlREdWpLWk5CUzlabndxNmpOL2N4YzdETHVVSHUvWFov?=
 =?utf-8?B?TlRwUCtGRXRaS3NXM0tqTThQaFpCczhQRURNN1ZPQlIxSWJxK216OTRXamhG?=
 =?utf-8?B?OGJKS0t2cURLRkNiNGVUMDJ5andGbWNWbkFWT3Q1MjRJS243TU9wNDROMkZJ?=
 =?utf-8?B?K1RpYVRpSHBUUTFxcTZxMjZIdHZtTlY0SWVKK1RHenVHV3Y1ME5WYWZ4OUlJ?=
 =?utf-8?B?d05hVXlDK3E0cit3YTBQM2hjZnZlUjZNaXhKUG1iME1HQWJ2M00yUEU3emR2?=
 =?utf-8?B?NmtVRUlRNkJLaGRNRklOanNqL0FyZkwrMnB5ZWNLRnN4QURxTjlyUUNiLzVG?=
 =?utf-8?B?Um9FMEJSeXJVTXJIZVd2ZE11akFTaDhKNDhESzNkMkZNRzQvSVpZOE5CTDlP?=
 =?utf-8?B?WEJzNVU2QUNMeE1UWVlVY0syWFc1Lzl1cUtseVJ2ekttN0o4b2ZUOGxPZXBq?=
 =?utf-8?B?UEtlalNoRnZTeUVCS3pjQjdvTUtTcVFNbGI5RmFGT1VwMzYzMmVQS3lQR2pu?=
 =?utf-8?B?bStiQW9nS0labnJjb2NTQlBqYWt6blM5U2VIODVtSnkvVEw5RThZYWt5K1dr?=
 =?utf-8?B?Y3lleDY2Mi81dVJzaXpzTTFCZmNPa0M4ZHpBUzVka3ZYRitQRzRxbnl0aWlQ?=
 =?utf-8?B?T1d5SFpNMHRzaXh4dlp5VFBpNmsyRmlYSGRia1BxaWZIb1NZS01obTZ5V0Vz?=
 =?utf-8?B?Wm4rM3k5NGhHdnlZYkRRZkZoOXlRNnRCNCsyOXBLZVFxMGc3NlJzZ2pPNEZq?=
 =?utf-8?B?Tkg1Mjcxa0NzVVAyd08vU0FaNmdJSnFJNFlEUHVhdkVUR0tHVW95T2UyTjZB?=
 =?utf-8?B?c1plWjdCRVhIZXJET29Za0hCQUpYM2FWaGd0bHZZblZ4Vld0MFc2MXJ5eTZn?=
 =?utf-8?B?bUYrUVprb05yeG15Z2RURnQ0NXovUDYrKzM2am4vd1M5TWxOaUN6YkNYYmVs?=
 =?utf-8?B?RDFjazl0ZlVwTlo2MktDSTRsZDdFcUNTZWpwUzJQSEoyZFZ5bm5LZE0xTU5n?=
 =?utf-8?B?VTVKMjM5ZTZRRXprR0NCTU1Tdi9hVDNrTmY3amFLWGRrcHZwTEdSQWdCZW1B?=
 =?utf-8?B?Z0xINytvdUdRajRsNzRQL0xKQk0wRkxLc2tRbDVhb0M4ZWU5R1BZOTFLUXZZ?=
 =?utf-8?B?WWxmRENQdlZWTHJnVWlsSmlDcWh5eVUzOWdhMjQwWVRjZFJKUVU5UzVnclk0?=
 =?utf-8?B?L0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4Fefxw1TH5elcGMJ/ypVmSQhyk0XLBudZey9nPQAoJAXiWspOk9NmJJs+GheDQNaF6gyit+/1q4HW2zWCyPHJoxz6HCEuyKgDxOmdY//1Bn655DP1iFQDsnMqR4TcYTLVFB+SaR+QbhHA4fz6anOBjUOS+v4hvgYdos4QROFhrXgETnbzppj5Cq4dcdNEcF4aeGld+heA61KGvCLVtgIvq/WaR+E+r8euWfxzo5nGo1IStfl158Yu+RpSEa0lWme7uXsbCuY/iW8cqxqwu6HAfj+V7VWpUuZnJlThjkmz6yNXtLe0AFDstsWmEAnSsexT/bf+C3VhkMRpjpKq/UQJ8s1QbB+uK5pkBTVONxwOpIhn3WMV900yNCv2bTeOcz0aL6E0fI6YvOBSMwjn0T48s5nkGGBRA0ict7ti6X9BVOXD3JZ+0GryQ3yBynzhC1J1dLYZGeUNaLG+xBj1FzIkCHequObS31zUm+qZdvyJLs+GDV07Eao3ertJc3xuxxEUQM1QP+pIwMUjYvtLbXFfNteRIka5fqRqHNEp79cELKnPgpRngoKKYobVjqgib8xlZ98NYMKPup0x4JDeCraFoI4nwa+b1vAWhE1r6yBnFzeWC6Cp6fiLHU3whdeIVx6VwfUDGcs9ZleedeNvyBtGXb1jbMdW9jFcwe1ojpk7W167unBfDaoAdng6N5lYpM9dTA/t0E7pWXM0VdR+bCAMETZa2zAkga4FN4PPXhT2X2t/+ctKyHz5oOAG/kjGLlayGr0myjs7uQ42QM6GKb8R9ihW3y9yhAoSGRGKLh7BZW8nm0VvjzTR4Tx0Y1qhiq6
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11361b58-c269-46e4-3c4f-08dba3e55775
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 14:29:21.7091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HQAXcXoxkYh3EeljZboi6QsUw9eM4XwgTIZ9LSh5OqUY6BFcKpuibvPLSsj174slQVztLs5BYqR3i/Eien5MFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6727
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308230132
X-Proofpoint-GUID: MjvH6wZUQ7gZexUxYt8LVWst2x-n6ec1
X-Proofpoint-ORIG-GUID: MjvH6wZUQ7gZexUxYt8LVWst2x-n6ec1
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM
Reviewed-by: Anand Jain <anand.jain@oracle.com>
