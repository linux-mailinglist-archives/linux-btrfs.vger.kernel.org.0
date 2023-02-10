Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4F46922E1
	for <lists+linux-btrfs@lfdr.de>; Fri, 10 Feb 2023 17:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjBJQC3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 10 Feb 2023 11:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232910AbjBJQCX (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 10 Feb 2023 11:02:23 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE03C360AA
        for <linux-btrfs@vger.kernel.org>; Fri, 10 Feb 2023 08:02:12 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AFMUS6030360;
        Fri, 10 Feb 2023 16:02:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=C6GNuMupfKqDrvWk3wbTejDcCRPcYHWi2eg6cilfVOA=;
 b=RA6asPkxkMABxaqmL0oqJh7MZXg6kkxK+g+ts/PqTEIoLRqJxqyL/KPH0qMRD3+GBZG+
 ZfsBphP3M34ohRkUhZ21xRhF5BruifWS5p3Ot0GNOqVmfOEEgOTSZuA1znawIn7ss+Sl
 y2sru1hezFf40YAccUJyz15DXm9IETHuSHyrK0cMiMo6eFqXrLa/EvLqdnsp8MIOcO2b
 tSRuXcGQwZHjk6iwGZ1aIvsqS02VPrtWj2tM9xbyH43LMjAzbWbZjdPDReU8xjz3W3fl
 OdwA9AqqCjQEHtaGcNl+/OiY82cMgSIEKo2K72OJypaKtbOfW8CAtm8g+3+2pP+S3dhX xA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhe53nkh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 16:02:09 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31AFn0da036138;
        Fri, 10 Feb 2023 16:02:09 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtgrqg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 16:02:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LquTy+lOKIL/gP2t6RiT695LIi32nBWDkciBZ6/+n5pDRZxuhbSqkm8lqN07mQ/ny4IYw+d5b4wa4yT90AZ0/PxDF8MIYrc3FFiFNBZ++Q5Wd6TUD35nSs3sMFpH3Y0meuEFXZtQq9MdrvfFazxiDbNItuLPfqC6kSsYbUbBURKzwAZ0mMVlpGgy1GOFUUagHYOB5advHP7YgRqIimECpveeACdjzIyEUN6wyqvgzqLUtSzKnmYdv867iX9DiUW0Yh7deVzheKSb6dbA3SErYjsduk7v1n04vdUuZCKgYPazHDswL7hHk91vOdzTE9pIdOzKOQhL4a6km0QH4MjowA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C6GNuMupfKqDrvWk3wbTejDcCRPcYHWi2eg6cilfVOA=;
 b=C7u4USWUVbPCGSQAT8nIDq8cbnm5W3h75vqMeF5704dCAp0qDWKp3LftzxBWkTKulJLftX8/WF1YS9xe3aJ/p1wPKol3YvbPOMePqjxxHrYIZEZYhJbvSAebxg0a6hdZ3VOVuqtpWIQtWXDD81JZGFcQziIU0RkNbh94M5L2sg9xyY11OaW7voS9/2W3Bm282FgXgK9Ld94tZWZeO2+72QY12z52HPBq0ybEDKCFOkPnbMJjG4FrUOAjC5TM8VzEG+cUtpRNHi7l3+4RaFnBouzQ+WoH9UqMlRdC+jJO9xHefyKirWNx+jgFtuFLqMOTL/KL1LmIl2LrUxqMAfFJPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6GNuMupfKqDrvWk3wbTejDcCRPcYHWi2eg6cilfVOA=;
 b=H6um32eYnDW5PL6alFK7/cmugCw7OMBct9nKOLwJFvyxG7aIBQjA2Hdr48LKS3/dNC2PaxCoZCTY8NGYpzR6hPrwWQ99y8QEg9454nnCSuKZW11Zi6r/win7h/LT0nomXcYSG+OSIl0i365rBjE4jm4683iWkPy9dR0JU1G3Yv0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH0PR10MB7533.namprd10.prod.outlook.com (2603:10b6:610:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.7; Fri, 10 Feb
 2023 16:02:07 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::560e:9c52:a6bd:4036%9]) with mapi id 15.20.6086.011; Fri, 10 Feb 2023
 16:02:07 +0000
Message-ID: <770d3b15-d521-794e-b78d-ba8ad67b4e0c@oracle.com>
Date:   Sat, 11 Feb 2023 00:01:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] btrfs-progs: filesystem-usage: handle missing seed device
 properly
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <29a0e54c8461e3c25e63d5b7b3e48fa6f4254d3f.1676007519.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <29a0e54c8461e3c25e63d5b7b3e48fa6f4254d3f.1676007519.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0159.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH0PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b25caf9-f8a1-45f0-1ec8-08db0b8028b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4HEwlDCTYD9tXTHJLa4qin7LQMTTxP72YPpQ0cMFtkuFgV8x6FOx9/t2S3KXmefB9/4s4O8KceK6pqiCRy6C5b3+7vkEDkxIas9oeuvt/1gFM1yeJgGSqrHVFFVLoKJ9hFSrgARtNxk1HwrK0N6Rj+/yGLlUec0Leb3d4vH32ECf/zc8e9aj330Nulqv+yssYidbvj7WiXhskcxrBC0KU5csyNfKDvsv8VPVnkIwh6zU4cn4SVYm+uWCJNxcFKQs97o9fJXnkrsXxm+vkXf7Y7O78K/fmQDgoFgpEAOaeCMs4FGmMsD68f1l6QQr0OOlE4qrM69spwd64P6kncDXwyxoB6BTdpqIgoCbEK8Lfvh+ft9Ry05HDVRY8/Ml9lsY4JvaqvUUVMZNQDQDnr3lRSLfq1khSAZyB9A/NAYhYujsUxDI8qqxlDEVCj8qrRIkqknsGg3S81pnDsSl/JTkJ54oNFh6zS+6IjmfbX+hdQqPTJiEiusBng8Y8gnf7USlEmqFneRKlihi6a9r2X4/av182LTazajWmtu0T6J7nhse02q2C8TIbiSfPXQkOBAHcSTS6B6KtqrmpjO6kYErEGmNKuWD1s+m8PAOOxxGjGSeSU497pHNMm17YUNYgaQzfsiwfEVGUkd8jObipliYRjUxzUNuHcQT8uCVafQvWYpEquCUZ53OV3wolOG5nV9vZ9NqIWNR9XAdFTJ+izOO3++RdyepWbCC2wajAtcTgbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199018)(83380400001)(66476007)(66946007)(66556008)(316002)(5660300002)(8936002)(41300700001)(8676002)(6666004)(478600001)(6512007)(6506007)(186003)(26005)(53546011)(6486002)(2616005)(31696002)(36756003)(86362001)(2906002)(44832011)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJqQ2VLTE82Z2dEcnRUR0NDZWhoUnAwM0tvYTBQSkhFYTJMeGU0Z1doNVBU?=
 =?utf-8?B?UDZUTVQ0S002VW9sa240Rm9pUDFpeUlqYXNQSi9yNkpHcjM5MGVYZEZnUTYz?=
 =?utf-8?B?TGRZejRUZldLbGhsd3M3anBheDJTRGJ2dEtBZFliQkpzeitON2dXSnYySENV?=
 =?utf-8?B?bVdIRTRMQmNDWGcyV2hZR2xZUkVRaFFTTTdEeWlWUU5GNHBMM0NkaE4va2x0?=
 =?utf-8?B?MUMwZFI0VktIQUFWa2IzcWhhL2dIcnZRa1YzaW9NR3FYTEFLR0FvYUVKUFFn?=
 =?utf-8?B?d2ppWThaL3diOWVic05McVNyNGN6aUhDRk52c1RheXJlVVFPTU5OV29UWTUw?=
 =?utf-8?B?cFg2WEE3aE15TlFhcm1hRTJXbWUrRlNLRzNycFZ3UDlKdzZnbnIyako5UFdN?=
 =?utf-8?B?RjVsQ3lFblJUTStWZ0s3MWNFTitEa0ovVmFnc3RPS2dHczBRaHB1L3RId2sz?=
 =?utf-8?B?bm9rTzduVHQ2eDZQblhMYXMxeFp1UlJZdlkzMFhDVStiUHdVdTJxVzBpb21v?=
 =?utf-8?B?ZEpObi83ZGRabzFhTHh3bDJ1YXVWaTZlcm9ZSkFlMVFOZUZWMmxCVTQ3MlY2?=
 =?utf-8?B?L013QTI2SWlzQnNkVXZubzV0Qm5wazYrcTNVZFl1K1NWQVE2OVdmSTdheERQ?=
 =?utf-8?B?U29YUkw2bk9TMGJwUWJpQzZtSnlha2NjNWNFYndGWU14N0kxSHhMMkdmanJj?=
 =?utf-8?B?RFk3OFhnZ1gwNUF4dFFsbUtpNzNBUEROV2Z3YTJESzVpbVRySm9NNXpaanAx?=
 =?utf-8?B?dVJ5MUVwdEg3SzYramRIMk1PeXBXaktEZmVuYUM5cHFNN1ErdnBLSHdmb28w?=
 =?utf-8?B?SXpRUjBqN1JVYllwREk0amljTzZyQlNNZE9LbmU2bHpZbWxjTHpDbjhvclpX?=
 =?utf-8?B?aVFINlZKeVVtaHh4YnI0R3ZZZmlNSEF2MUFnalNiZWdQckpMVXd3cHV5dVdL?=
 =?utf-8?B?ZGpTeTM2TWhFandFZ0VNWmJDenN0MlFJRW1TM1Q0VFQxYk4zMXJzYm1jbzRV?=
 =?utf-8?B?K0JwRjMxYXFvRjV5NHMrUUN5eTRQcGtXdFIraUZTeUlyU1cvaVkrMWFXNHgy?=
 =?utf-8?B?Njk3ZktmNHRhUk53U1hveWRqMXA1bTBXSFlYUlpBV2hkS2k4VmFOQzVmUVls?=
 =?utf-8?B?a0VXU04xbjNTYk5zMUIrRnV5Y3VVRC9KQml2Q3ZjMUdnc05Eb2dJTlhoNVZC?=
 =?utf-8?B?bEVDUUlIL1NFaVJxcU0yZmJFNGdHa0IzelhpWDN3czZvZWJLaHA0aUYyMEtq?=
 =?utf-8?B?VWpRbWVRYzRIL1F3L1Q1UkN1ei9DTXRFbG5EYmR2a0Q1T1haOVRsbnZkUEJB?=
 =?utf-8?B?NFp5bGdNUlFieWxUUWZNdkpZNW9iRVc4NzFjZFhOeEZJSVhmME5JNTE2RHVO?=
 =?utf-8?B?cy84WkptVkFEaVJQTUo4WVlaL1VNa2xaMFl3RWIyamdPWFVha244TktyVXJR?=
 =?utf-8?B?cUVlVzdkcXI2WDhCaGlkd29yZkpxZU5ObDZJUFhPcjlLOEQxNUx4UjlkTkpL?=
 =?utf-8?B?ZWFGWmlobll3amlxNnlQdUtncXJuSUtDdjBsRUZydmt1S2Z4aEpwdmVCUDlF?=
 =?utf-8?B?SzNNNWp2UVpRL0p1OHJlRkZuT2VGOWdrbC9RaEFndm03cE1WZkJaZUYwQ3dr?=
 =?utf-8?B?VTh4VDZuaXAwMVVKMlB5b3QrQ0hSKzhVTUZkdDQ1TGVHa24zVUlMUjZnaWsr?=
 =?utf-8?B?bWFCaFgydHZ2NEc1Y2w3L09FaUtBNUR1Mlp3YytUYVVUcSswMHBpbXc4N2VC?=
 =?utf-8?B?Q0srdmhiSUxKeklSUnBuekhnT1RzNHc0cGc1Q3JNQ25NYnFKT3BzK0VlMU1Q?=
 =?utf-8?B?QlRGc3E4UUQ3TDdNSTZoenlSQjFNNlFScnlhRkRnMjFMQXorbHFEcVpkeUQ3?=
 =?utf-8?B?cDdmRmJWOWIxT2txUUY3WFRyUGx6Um9jaWxoalNMRHczaTR5VzN3OGMvc3kv?=
 =?utf-8?B?aDNzdUFrU0xOY2Q4ZElOaElxNnJlNDVMWHlrMGpYK1pyMjNCVmp6c2xjR3ZQ?=
 =?utf-8?B?Vnh2cEx0T09vaGtlcTBHUlFUclgwVTdVKzZSM3hNZExWMkhjYy8vODkya2Er?=
 =?utf-8?B?QWZ0YU82akhVV3daS3ZXRHh1b0tsNjEzTG9NVGxxOE0yNDhacDA0VnNTbGxB?=
 =?utf-8?B?dE5XeHZFdWtERVZrbjRURmIrZ3c0SmNuSVpqTlVvMVZzY0FLOGUxL0pXKzZn?=
 =?utf-8?B?bGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: g+CRRp+Byb80zyJEGwj1Slg0ybMyCC4IdXFuLAXjsUJENMyQgfH5se2+5xDPpGe+dl4ygsFU213ioGxSDeEdOvk4M/FmhzgOdPi4HDdDZftfpy0j3D6heAK0TFtKwVLVRTsljFmGbmKrcgD5XxAm6OEHM6P2DUXLOAxVHkeZMf/a72wtoV1f5wRHGwBDdAkWIz6tnWgxt4Tb1SdYSCDOWMfcElLqnh0wwXMrx+Q+rfJWTWu/gMzagg/VyXIYZNuyiB5dMmYdizk1zrMoAsEhv52v/Pwp0zdPbSP2X5f04JGrwfyzVWu1bkK9K4d/bk+QJ/uZXjxZ8eza3t+MPTeZr+139lInubygPN8z+lwFpXLZFD0dWI4I6dLHGlS7I12Kf9tG4Wish4X+iwKIxzU0U0Ml2T9w+9ZNEyarDzagcS1qaJvkd4VGIFhaRRHrcOwrJuUcRcBsxuLWDtneZTQpdZonzojcI8+bzwOrpvWM2qOycnPCW5k+iiEA9CDKr4xSWH0opCrFW8W0rP786Luqeq7Ym79mE6+wQtUv2dRQM1aQ1KYZq6yIoauDyEw+Q5nsnKrurMGbrPJRwJ7reYWiEdcCy3YBu1sNfc+mTcYrsOC+ZjGej54KCFxvwGjOVXO4OOifyj0LiZbvyozpWTrwITKQYmVEvK6SV9YUPkaozDDwXIbkh0GkBm6nT0o3PyGvF0fnoFVi5DV8qXkaxERaO+ff7RbuhrrYgrWoM7hIxKRIqDmdiBiL1hDx5Vu0X/0jnMnH/gpLyENWyrL4M+qLSIe+i+1o5HWc69JXqBvtKq0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b25caf9-f8a1-45f0-1ec8-08db0b8028b7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 16:02:07.3629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZalN8UlMXmcqzQZJDOzwhLWKpe9CFouMyoWvRSEkTjv7dgqsS2OMPp24jV9zeq95K5vQyiGAZBc00dXfbmG0Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_11,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100134
X-Proofpoint-ORIG-GUID: kYkF6GAcf7aoZttLJwwRDvft-6TCZAiU
X-Proofpoint-GUID: kYkF6GAcf7aoZttLJwwRDvft-6TCZAiU
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org





An alternative solution is to utilize a kernel interface to obtain the 
fsid [1]. Previous experiences have shown that attempting to directly 
read a mounted device's disk is not a reliable method and can result in 
various problems. As a result, it is advisable to use a kernel interface 
to read the fsid.

[PATCH 2/2] btrfs-progs: read fsid from the sysfs in device_is_seed
On 10/02/2023 13:39, Qu Wenruo wrote:
> [BUG]
> Test case btrfs/249 always fails since its introduction, the failure
> comes from "btrfs filesystem usage" subcommand, and the error output
> looks like this:
> 
>    QA output created by 249
>    ERROR: unexpected number of devices: 1 >= 1
>    ERROR: if seed device is used, try running this command as root
>    FAILED: btrfs filesystem usage, ret 1. Check btrfs.ko and btrfs-progs version.
>    (see /home/adam/xfstests/results//btrfs/249.full for details)
> 
> [CAUSE]
> In function load_device_info(), we only allocate enough space for all
> *RW* devices, expecting we can rule out all seed devices.
> 
> And in that function, we check if a device is a seed by checking its
> super block fsid.
> 
> So if a seed device is missing (it can be an seed device without any
> chunks on it, or a degraded RAID1 as seed), then we can not read the
> super block.
> 
> In that case, we just assume it's not a seed device, and causing too
> many devices than our expectation and cause the above failure.
> 
> [FIX]
> Instead of unconditionally assume a missing device is not a seed, we add
> a new safe net, is_seed_device_tree_search(), to search chunk tree and
> determine if that device is a seed or not.
> 
> And if we found the device is still a seed, then just skip it as usual.
> 
> Now the test case btrfs/249 passes as expected:
> 
>    btrfs/249        2s
>    Ran: btrfs/249
>    Passed all 1 tests
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> This version is different from the original fix from Anand by:
> 
> - No need for kernel patching
>    Thus no compatible problems
> 
> And also different from the fix from Flint:
> 
> - No need to search chunk tree unconditionally
>    Tree search itself is a privileged operation while "filesystem usage"
>    subcommand is not.
> 
>    Now we only needs root privilege if we hit a missing seed device,
>    which is super rare.
> 
>    And we can still fallback to assume the device is not seed.
> 
> - Better commit message
> ---
>   cmds/filesystem-usage.c | 72 +++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 70 insertions(+), 2 deletions(-)
> 
> diff --git a/cmds/filesystem-usage.c b/cmds/filesystem-usage.c
> index 5810324f245e..214cad2fa75b 100644
> --- a/cmds/filesystem-usage.c
> +++ b/cmds/filesystem-usage.c
> @@ -700,6 +700,56 @@ out:
>   	return ret;
>   }
>   
> +/*
> + * Return 0 if this devid is not a seed device.
> + * Return 1 if this devid is a seed device.
> + * Return <0 if error (IO error or EPERM).
> + *
> + * Since this is done by tree search, it needs root privilege, and
> + * should not be triggered unless we hit a missing device and can not
> + * determine if it's a seed one.
> + */
> +static int is_seed_device_tree_search(int fd, u64 devid, u8 *fsid)
> +{
> +	struct btrfs_ioctl_search_args args = {0};
> +	struct btrfs_ioctl_search_key *sk = &args.key;
> +	struct btrfs_ioctl_search_header *sh;
> +	struct btrfs_dev_item *dev;
> +	unsigned long off = 0;
> +	int ret;
> +	int err;
> +
> +	sk->tree_id = BTRFS_CHUNK_TREE_OBJECTID;
> +	sk->min_objectid = BTRFS_DEV_ITEMS_OBJECTID;
> +	sk->max_objectid = BTRFS_DEV_ITEMS_OBJECTID;
> +	sk->min_type = BTRFS_DEV_ITEM_KEY;
> +	sk->max_type = BTRFS_DEV_ITEM_KEY;
> +	sk->min_offset = devid;
> +	sk->max_offset = devid;
> +	sk->max_transid = (u64)-1;
> +	sk->nr_items = 1;
> +
> +	ret = ioctl(fd, BTRFS_IOC_TREE_SEARCH, &args);
> +	err = errno;
> +	if (err == EPERM)
> +		return -err;
> +	if (ret < 0) {
> +		error("cannot lookup chunk tree info: %m");
> +		return ret;
> +	}
> +	/* No dev item found. */
> +	if (sk->nr_items == 0)
> +		return -ENOENT;
> +
> +	sh = (struct btrfs_ioctl_search_header *)(args.buf + off);
> +	off += sizeof(*sh);
> +
> +	dev = (struct btrfs_dev_item *)(args.buf + off);
> +	if (memcmp(dev->fsid, fsid, BTRFS_UUID_SIZE) == 0)
> +		return 0;
> +	return 1;
> +}
> +
>   /*
>    *  This function loads the device_info structure and put them in an array
>    */
> @@ -708,7 +758,6 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>   {
>   	int ret, i, ndevs;
>   	struct btrfs_ioctl_fs_info_args fi_args;
> -	struct btrfs_ioctl_dev_info_args dev_info;
>   	struct device_info *info;
>   	u8 fsid[BTRFS_UUID_SIZE];
>   
> @@ -730,6 +779,8 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>   	}
>   
>   	for (i = 0, ndevs = 0 ; i <= fi_args.max_id ; i++) {
> +		struct btrfs_ioctl_dev_info_args dev_info = {0};
> +
>   		if (ndevs >= fi_args.num_devices) {
>   			error("unexpected number of devices: %d >= %llu", ndevs,
>   				fi_args.num_devices);
> @@ -737,7 +788,6 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>   		"if seed device is used, try running this command as root");
>   			goto out;
>   		}
> -		memset(&dev_info, 0, sizeof(dev_info));
>   		ret = get_device_info(fd, i, &dev_info);
>   
>   		if (ret == -ENODEV)
> @@ -747,6 +797,24 @@ static int load_device_info(int fd, struct device_info **devinfo_ret,
>   			goto out;
>   		}
>   
> +		/*
> +		 * A missing device, we can not determing if it's a seed
> +		 * device by reading its super block.
> +		 * Thus we have to go tree-search to make sure if it's a seed
> +		 * device.
> +		 */
> +		if (!dev_info.path[0]) {
> +			ret = is_seed_device_tree_search(fd, i, fi_args.fsid);
> +			if (ret < 0) {
> +				errno = -ret;
> +				warning(
> +		"unable to determine if devid %u is seed: %m, assuming not", i);
> +			}
> +			/* Skip the missing seed device. */
> +			if (ret > 0)
> +				continue;
> +		}
> +
>   		/*
>   		 * Skip seed device by checking device's fsid (requires root).
>   		 * And we will skip only if dev_to_fsid is successful and dev

