Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB12725BA5
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 12:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239301AbjFGKa1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239126AbjFGKaO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 06:30:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD1719AE;
        Wed,  7 Jun 2023 03:30:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3576Jh7d002003;
        Wed, 7 Jun 2023 10:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=mWjI0FpBBiTeFxc/gr3KvOTw8k0m4GfrS8AKP7y3z0Y=;
 b=SlEqmFQvQvwreCMxDZp39uU7E3CqFMqEKtL3Hja3fO2fZ9TMyN34RPNn8Eae/F2UsdWT
 g79VvLao36TU12dndR601BzhcJ+xC4v4ySFVvemhDKw0+/ikLGBCruLS5UeOKP5AnRpy
 H2jdYIhcqfSluTksm8Ce0jBMzozNViKOnocfZdSs1MGm/eIS0UQj0LwI4D50tJj35vKF
 /X9Ek6yPnCAsuBqI0CIm04bW670cHKldGce4Oz88MszGyDXrVm2pV/MgRLxiJPy5R5Gg
 s3DfCA00eWY7IFATgpA4e3XDQ1UCRN5v0I64CWaoAMauMBX1Ighpl47AEO6xztt+Uw1+ iw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6u1drp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 10:30:06 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3579DX05010520;
        Wed, 7 Jun 2023 10:30:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6qapb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Jun 2023 10:30:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw0VpbVbIqD/esLfB6OQtSol0VVIx7QQ8Q7mLIojKlPYLOt6sViIptwLpgkRoYMSgVyjNQMG4aUQNmq5ZZbtWjsuaEufm52kuSGRMirYbKPlqVneIKmtXzdsDe2jFdC+FtWmoo2edz/6wqsOsPQsTGGjU4Zfq8dBMtx5IRIZdjDZ88EpB+ZaHJgw2yfNKl8gjUDqYC6dsl/G9/hI2LkTk3DzXr86sxiQprX7QtapwQl2/f8Lqz8HVaW1kZKnovUCrhJcOIvx3S8FQX4Ln795zgYLqOKJr1fe4+uqrzss/P5dziqt4UAHZjL3vQGeWTMrRQ/9wsFD/FhfoYu8ynIm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mWjI0FpBBiTeFxc/gr3KvOTw8k0m4GfrS8AKP7y3z0Y=;
 b=jx3TMab8ydRuzr6aH/REDzkfgRbgFU6dCwUrVIs2sfGFouMgKBgejZktuvjSilA+PFn/RDF9zCuEQ+nDiSCtETkWLKnfFx2oWphb0EkcqnjrckoyObNs8dE4Sqb6jD1XysdZJZvbX0RBjQdd9pG+FwMh5+7dVQ/rj0z/An/UU7X8dr+AljX6VO1MzG/cPpo7aPieWzReKMetGA7n9cYthJHiCvC/d2VvFB2pcZ6dvMhNzne3ww8Usq/14vuTzjmk/yqv6bC937zP7EykemUh1jhUUPMjg1gVqkaoB8RgUH+0FqnI3zJd/h0ep5KR/W18W1cA9mu/ctRFiuiOMqjHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWjI0FpBBiTeFxc/gr3KvOTw8k0m4GfrS8AKP7y3z0Y=;
 b=YkIkc+fiJvHvvMAJTVcs+wuE9wQXQZPpXttessIF1Q90XQmvBrkY6xP8it9OPFM4PJOOXC8TWDM5+nsu1gU//QRridlbDOLPUvvXA6OYrXeGSklb3V42Zv8//dkBe2fCZt0en2yjimg5nj4sRU2IyT354fWlA6lqoBNjBFYGqZI=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB7634.namprd10.prod.outlook.com (2603:10b6:806:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 10:30:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 10:30:03 +0000
Message-ID: <3e5e3edf-8d3a-e498-ee25-2d5a19d77def@oracle.com>
Date:   Wed, 7 Jun 2023 18:29:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] btrfs/266: test case enhancement to cover more possible
 failures
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>,
        linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
References: <20230606103027.125617-1-wqu@suse.com>
 <2f4659d6-667d-d9d2-7bf8-656019fd3c99@oracle.com>
 <f0745b27-2e93-7e35-384a-e5cd7b832a3f@gmx.com>
 <46c2f952-7d13-5e56-56ec-902fd0387632@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <46c2f952-7d13-5e56-56ec-902fd0387632@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 657abfcd-a720-44d7-2bc8-08db674227a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8kHLnIE2HrkOvmwbpkHnO5QNQ1ImrK2d2RN5BCglLLfWMGhbf1tetPOItbVCsQE49zrFsTQZhUFc/fAG1X7/4zLFzwf3TWsuaobLi9fw/A1lhq3ftcQzzP0EFiydzrWy2nGPp1Bw1gLuEW/WmWmYmQdbBtY6hlV5u6HAAe4DRdKsqoViKQbIZi8aNhmW1cTsVRXbCh2RjNny3eIi1MbG7t2XdqCAFVvar1U/ErDjyKMAlomUdGQrfXeM74DxaxZTJnANLYwuB620LK5q0AJ1EeoTMq1vaPfE5Y+UUAv9eXfIxBTToKkfY4Bo7MiN0YLU+SMyaStL9EQfnH8+B6Qiqi8YIQUxKHDdYNbHaUNxgxK/LtR29pM7kbGrPMNmk7gQGPstQPQ4fAlqdpDQ1Dt9hjWV4n9HfSeGnAmByFXUc72axv/bMXT2ZZMMpyXZ9aWf26sqS+s2lPK0z7YSkdOJ8VNxloAKq8sAEH3OzkSIoiVE6YWxhOx/5tLfWCL+2i2z8xDFi2udI8Ydf/IowfuhhP6yYEq+nN0U0PTFQVFIRovUWZnYLzxVstBnb6NT7zidBtL/CWqlWBD4AQubftav9Ws9ol/HJ+h/NEFd/e0p+98Bg8Ml+hLPJ9Cbhbqk7su2mSZ3c2T+IZ/uuH02qRu0OBuiyaygVCkXotmCPPyJ2us=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(53546011)(478600001)(186003)(36756003)(2616005)(83380400001)(6506007)(6512007)(26005)(6666004)(6486002)(316002)(41300700001)(66946007)(66556008)(66476007)(86362001)(44832011)(31696002)(30864003)(2906002)(31686004)(5660300002)(8676002)(110136005)(8936002)(38100700002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFJyTnJaTjlhcmR1MzdRL0hMaXg2Zlc1UHJZbVI3M21ySVMwbFIycnI5L1Zj?=
 =?utf-8?B?cHV1dFNnWnM3cHU4RUlTLzJ4UTBlUjNXWml4NjJHdGZwQTJKY0FORWlHVFFQ?=
 =?utf-8?B?bzBJVU9jc1N4K2tQOTViVVlYSnV4ZktNWkxpN3hUMGora0p0SjZqOXJ2T3Nu?=
 =?utf-8?B?UjlrczFWSEczUEtKN1M2alQvMDVOaTNoZHNvWDZVN29TRVd5SXZubTFkNFpk?=
 =?utf-8?B?VU9teWxyMkNLU29OZS94ZmZzb2U4U0dxaTJTUzZhTTcwQXUwWTAxZEMwaURu?=
 =?utf-8?B?aEdsQjVqSmVKUU5mU0piUXlWcmM3dFQvbzYrYzhkR0hyNVRJSzNHT2lkZEZp?=
 =?utf-8?B?Y2VZQVBxMGQxYkZJZEdhNUIrejhPNWROM3czL3p3NjBtWDFhTzNra0FORTEr?=
 =?utf-8?B?a0FZRDhrM3lyTVpSRkhOKzNXZ2VKN0xPSGJVN3ZKMmM4LzluUi90Tmt5eGlt?=
 =?utf-8?B?Q0c4by9KYWUvcEhjYXIxKzlyQVdCRm5ZeHNDVGJHcDA1NUhmWi9lblphY1Vj?=
 =?utf-8?B?Mi9ZZ3MwWHJTa3REYUtwalBoY2lxY0p4dkExY0hDbW1ZTlQrV0VleGNiQ2sz?=
 =?utf-8?B?cnEwK0hYbEtWL2JIaGw1ZnZrT2V3QkRPVnZLNkR3bWhrQmdNc09FMFphelhm?=
 =?utf-8?B?aDRhTUdWNTFwNHNOdWdabS90NVh0aDB1WW9OM1BQQlZKakU3YWFzY2IrbGhz?=
 =?utf-8?B?bHlxcWdKNWhiekJZQkhrODRoUDBRSlg2MTFEUG84QzRoQjdKQ25rQWZscGpm?=
 =?utf-8?B?NXZtTzZ5bCt6T2FMSEw3UUZ4cDNZaG5QRXNmcHhVcUdpTjhDSHpubHA3T0lU?=
 =?utf-8?B?Y082WEZVc2xVUG5tVTk3dkhQT3VZeUVXTVVNeEdqV2o0TjkvK1NVVTltZGpL?=
 =?utf-8?B?Ui9oSkMzZEdKSFNPYURFWElPOG8yNnc0WlNuNmNER3NDL2ozd251N0Q4eHZj?=
 =?utf-8?B?UEZ0YnhldTY2eDdrZTVwcitRTWcyajZpak1qM2lOaDhzSFRZanNNZTY3REFq?=
 =?utf-8?B?TXd0SmtPck43YWxCOHZVM3ozbVZZOVlzclVXbi84V2Q2MHlmaWd4Wjl2QXVK?=
 =?utf-8?B?ZWxmQVJCdndmcHVFUWFpdmJxN3BwWlRpRmRPYmVQa3lwRWgwb0c2Z1VEanMx?=
 =?utf-8?B?ajd1T1ZvV2VEc3o3eUZ2bVhRYWpReTRxcFdNR1cvazlPN0ZNbHlGOGYxTWhX?=
 =?utf-8?B?WTdXM3hOeWo1MzdheEVKdzdkUzhFYUsvdTFKVXdSNXBhQldhOE9OTXVLSyt1?=
 =?utf-8?B?VG8xU1lkbnJhTkM0YTRLclJxdjFITjdIT3NtdzlZdjBHRWpNTUlvWmx5WkZ4?=
 =?utf-8?B?OXQ4Z25wbEt6aGQxU1JkV0RjQjg2a0lKTjdDOW9WZ1ZvWC9yZkFOc2NqMFox?=
 =?utf-8?B?WjdySlV5YlBqYzdzSmJGWnJrNUwydWhkc21ucXdiVndrRnl1MDlmMnpPenVt?=
 =?utf-8?B?SWsrak9BUmo5Y2JjTXZOWWhSODJna3NQdU9iaGY2OVp5anI5WWd2NkpDMzVn?=
 =?utf-8?B?WnNZT1RQZ1UyM3o1Sml3MmlVNWtkN1FnczJ4ZUxRbkFNUStnZWR3TFVLazJ3?=
 =?utf-8?B?bHp2UC9PSFl1ZXBMUGgzRnM3OXIrYndmUUQyWU5nVlg4SDFET0JDNHhqMFRD?=
 =?utf-8?B?am02KzNqVjUxNHFCcjROK3AwcGxCaVR0L1A1anJ3bzAwbjdrR0U2ekdJckc4?=
 =?utf-8?B?ZGRSWC9RVTFYU2ZxcW52UFUyQzhqcXNKbi9kTURaZGw5YWVrN3VhVlYrWCtK?=
 =?utf-8?B?VmxEOEIwYmF2REJwTW1WUzdjb3U2VHoxOTNjR3BoNVB6cEdNWFd6dXFJRWs0?=
 =?utf-8?B?Q1VDMnljekMxQTgrSTBLK20wbEQweDJubU5MN3duSnVMVzBtY0lha21Ha1I5?=
 =?utf-8?B?OXlCUlVKZ1F1eHNyVjFvM1dMVDZlM0tBR2ExOGYwMEw2SXU1VTcrdy9wdlBU?=
 =?utf-8?B?cVZXdllDNkZCVEpaLzdWZkpDSnY0Ylc3SFozaTRXQUI2U2t6Ly9zWDFNN2tt?=
 =?utf-8?B?NVZ5QjRYRThkTEV1MXBSZGFGTEU1N2ZNWEVmR0grYnVpRlRJSWZEMGVSQnds?=
 =?utf-8?B?ZE5Ed0s2Nm9UVHFPWXo1WDRyUDM4NklMMHdscnA1d2RFZWFuQWtQOFV0RWpv?=
 =?utf-8?B?UkZ4TzF0U0FMM0kzZ1ZoTWh0UUoxZHRTRjVqZWx6VWplYkgxR3pMaXpXSnBE?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zJ9XDAZ8Q6rR28BCy3+hvhB83mQ4UN7CWi5PpF/wnam7ppeYvHuG5dXSmGNVQIB1R+sNLPKr5PVdvQfEplmfgmz8ACd1MPHIvPZHZGCbEHYH81mTXaYe2UxFIUr7SEHFWlENGBd1oxyCn22/cGL0XZ1EL1qqKzR6a+e/Sm9Mthla82/t6NNr7n5Qrj04jBz9eGJcm6kDH5FVVQG5lEKd8rzbdWIf5786YCvWyFOJeIC409HIDCZF492tNl0YBEvFIOZmWI/ZeUhWgL0ARlBArbO9ctiyItlcRZMYxX6o4VxfbElXaJSFCU7abQz0c9jN7aTwH7vm7ry7IriPVTUiAlQ0MOLGeLAQNgZ3rY3QnNszMezDG2TPDTwg9fZDIKQquom0zOKDPMQ9NlciZh74fUpyeYak3zNqRoSd+MguVwcySOkM1c7pK4Ht82dy52/sWLmyJ9ykL8LP4KikT6C62S3tLIXsJDOyhkGAqNOrza5OowumE4SXhHluXQNypiPfSoI9TnxsvQwIN89oAnLTfezjvxVK9OdQr4Bwwly1XpdXWN7Hnv+TYuWe0WP4cd31R+gmRV9H+3AkrRMmFRWu3EKvN30ha0Rn2ekaha78e2ChQz6b0kWjeL9P6qaF0pACSBvGmvg5qv6Ainm7uqY1J7TzqCJz2qjuak+VZGliP0Cvu3zhgR+93lmW3F6DS3F8v6/gmjQ0MfJXvQBLAgZI/TjAwW3d2yvd/NKgaVSGDXCP9VCccmtgU6V8JCRP5btwaI19yX7j4UNzpRrhFlBr/XsxmvI24jzbZW8IsEKvcKJg8hdcn9eRcOjI0VIEmtBY
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 657abfcd-a720-44d7-2bc8-08db674227a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 10:30:03.4547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OIxNp8t8IgMdE6MmUoy5v9yQQnmbGSQXs3UhGsLO0cIuiv5hEqkIttjy6SlBS/diI+jdvX7//X0zLPULxmw7Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7634
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_06,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306070085
X-Proofpoint-GUID: jnkPkzdd2AmLfVyTZHBJbHigb4zfneJJ
X-Proofpoint-ORIG-GUID: jnkPkzdd2AmLfVyTZHBJbHigb4zfneJJ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 07/06/2023 15:39, Qu Wenruo wrote:
> 
> 
> On 2023/6/7 09:52, Qu Wenruo wrote:
>>
>>
>> On 2023/6/7 08:13, Anand Jain wrote:
>>>
>>>
>>>   It is failing on sectorsize 64k.
>>
>> That's what I'm investigating.
>>
>> And the failure is random, if you ran more times it would pass (the
>> failure rate is 1/3~1/5 in my case).
> 
> And to my surprise, this is in fact not a bug in btrfs, but more likely
> a bug in drop_caches.
> 
> I added several trace printk() for __btrfs_submit_bio(),
> btrfs_check_read_bio(), and __end_bio_extent_readpage() to grasp the
> repair work flow.
>  > It turns out, when the test failed, at least one mirror is not read from
> disk, but directly using page cache. > Thus no wonder the data would be repaired, just because that mirror is
> not properly read at all.
> 

Failure is inconsistent on my system too. Does the test fails depending 
on which mirror becomes the latest_bdev for the metadata?

Thanks, Anand


> I'll start a new thread on this particular problem.
> 
> Thanks,
> Qu
>>
>> Thanks,
>> Qu
>>>
>>> ---------
>>> btrfs/266 2s ... - output mismatch (see
>>> /xfstests-dev/results//btrfs/266.out.bad)
>>>      --- tests/btrfs/266.out    2023-06-06 20:02:48.900915702 -0400
>>>      +++ /xfstests-dev/results//btrfs/266.out.bad    2023-06-06
>>> 20:02:56.665554779 -0400
>>>      @@ -19,11 +19,11 @@
>>>         Physical offset + 64K:
>>>       XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>>         Physical offset + 128K:
>>>      -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>> ................
>>>      +XXXXXXXX:  bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb bb
>>> ................
>>> -------
>>>
>>> Thanks, Anand
>>>
>>>
>>> On 06/06/2023 18:30, Qu Wenruo wrote:
>>>> [BACKGROUND]
>>>> Recently I'm debugging a random failure with btrfs/266 with larger page
>>>> sizes (64K page size, with either 64K sector size or 4K sector size).
>>>>
>>>> During the tests, I found the test case itself can be further enhanced
>>>> to make better coverage and easier debugging.
>>>>
>>>> [ENHANCEMENT]
>>>>
>>>> - Ensure every 64K block only has one good mirror
>>>>    The initial layout is not pushing hard enough, some ranges have 2
>>>> good
>>>>    mirrors while some only has one.
>>>>
>>>> - Simplify the golden output
>>>>    The current golden output contains 512 bytes output for the 
>>>> beginning
>>>>    of each mirror.
>>>>
>>>>    The 512 bytes output itself is both duplicating and not 
>>>> comprehensive
>>>>    enough (see the next output).
>>>>
>>>>    This patch would remove the duplication part by only output one
>>>> single
>>>>    line for 16 bytes.
>>>>
>>>> - Add extra output for all the 3 64K blocks
>>>>    Each 64K of the involved file now has only one good mirror, and they
>>>>    are all on different devices.
>>>>    Thus only checking the beginning of the first 64K block is not good
>>>>    enough.
>>>>
>>>>    This patch would enhance this by output the first 16 bytes for all
>>>> the
>>>>    3 64K blocks on each device.
>>>>
>>>> - Add a final safenet to catch unexpected corruption
>>>>    If we have some weird corruption after the first 16 bytes of each
>>>>    64K blocks, we can still detect them using "btrfs check
>>>>    --check-data-csum", which acts as offline scrub.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>   tests/btrfs/266     |  59 ++++++++++++++++++++----
>>>>   tests/btrfs/266.out | 109 
>>>> ++++++++------------------------------------
>>>>   2 files changed, 68 insertions(+), 100 deletions(-)
>>>>
>>>> diff --git a/tests/btrfs/266 b/tests/btrfs/266
>>>> index 42aff7c0..894c5c6e 100755
>>>> --- a/tests/btrfs/266
>>>> +++ b/tests/btrfs/266
>>>> @@ -25,7 +25,7 @@ _require_odirect
>>>>   _require_non_zoned_device "${SCRATCH_DEV}"
>>>>   _scratch_dev_pool_get 3
>>>> -# step 1, create a raid1 btrfs which contains one 128k file.
>>>> +# step 1, create a raid1 btrfs which contains one 192k file.
>>>>   echo "step 1......mkfs.btrfs"
>>>>   mkfs_opts="-d raid1c3 -b 1G"
>>>> @@ -33,7 +33,7 @@ _scratch_pool_mkfs $mkfs_opts >>$seqres.full 2>&1
>>>>   _scratch_mount
>>>> -$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 256K 0 256K" \
>>>> +$XFS_IO_PROG -f -d -c "pwrite -S 0xaa -b 192K 0 192K" \
>>>>       "$SCRATCH_MNT/foobar" | \
>>>>       _filter_xfs_io_offset
>>>> @@ -56,6 +56,13 @@ devpath3=$(_btrfs_get_device_path ${logical} 3)
>>>>   _scratch_unmount
>>>> +# We corrupt the mirrors so that every 64K block only has one
>>>> +# good mirror. (X = corruption)
>>>> +#
>>>> +#        0    64K    128K    192K
>>>> +# Mirror 1    |XXXXXXXXXXXXXXX|    |
>>>> +# Mirror 2    |    |XXXXXXXXXXXXXXX|
>>>> +# Mirror 3    |XXXXXXX|    |XXXXXXX|
>>>>   $XFS_IO_PROG -d -c "pwrite -S 0xbd -b 64K $physical3 64K" \
>>>>       $devpath3 > /dev/null
>>>> @@ -65,7 +72,7 @@ $XFS_IO_PROG -d -c "pwrite -S 0xba -b 64K $physical1
>>>> 128K" \
>>>>   $XFS_IO_PROG -d -c "pwrite -S 0xbb -b 64K $((physical2 + 65536))
>>>> 128K" \
>>>>       $devpath2 > /dev/null
>>>> -$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 *
>>>> 65536))) 128K"  \
>>>> +$XFS_IO_PROG -d -c "pwrite -S 0xbc -b 64K $((physical3 + (2 *
>>>> 65536))) 64K"  \
>>>>       $devpath3 > /dev/null
>>>>   _scratch_mount
>>>> @@ -73,19 +80,53 @@ _scratch_mount
>>>>   # step 3, 128k dio read (this read can repair bad copy)
>>>>   echo "step 3......repair the bad copy"
>>>> -_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 256K
>>>> -_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 256K
>>>> -_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 256K
>>>> +_btrfs_buffered_read_on_mirror 0 3 "$SCRATCH_MNT/foobar" 0 192K
>>>> +_btrfs_buffered_read_on_mirror 1 3 "$SCRATCH_MNT/foobar" 0 192K
>>>> +_btrfs_buffered_read_on_mirror 2 3 "$SCRATCH_MNT/foobar" 0 192K
>>>>   _scratch_unmount
>>>>   echo "step 4......check if the repair worked"
>>>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical1 512" $devpath1 |\
>>>> +echo "Dev 1:"
>>>> +echo "  Physical offset + 0:"
>>>> +$XFS_IO_PROG -c "pread -qv $physical1 16" $devpath1 |\
>>>>       _filter_xfs_io_offset
>>>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical2 512" $devpath2 |\
>>>> +echo "  Physical offset + 64K:"
>>>> +$XFS_IO_PROG -c "pread -qv $((physical1 + 65536)) 16" $devpath1 |\
>>>>       _filter_xfs_io_offset
>>>> -$XFS_IO_PROG -d -c "pread -v -b 512 $physical3 512" $devpath3 |\
>>>> +echo "  Physical offset + 128K:"
>>>> +$XFS_IO_PROG -c "pread -qv $((physical1 + 131072)) 16" $devpath1 |\
>>>>       _filter_xfs_io_offset
>>>> +echo
>>>> +
>>>> +echo "Dev 2:"
>>>> +echo "  Physical offset + 0:"
>>>> +$XFS_IO_PROG -c "pread -qv $physical2 16" $devpath2 |\
>>>> +    _filter_xfs_io_offset
>>>> +echo "  Physical offset + 64K:"
>>>> +$XFS_IO_PROG -c "pread -qv $((physical2 + 65536)) 16" $devpath2 |\
>>>> +    _filter_xfs_io_offset
>>>> +echo "  Physical offset + 128K:"
>>>> +$XFS_IO_PROG -c "pread -qv $((physical2 + 131072)) 16" $devpath2 |\
>>>> +    _filter_xfs_io_offset
>>>> +echo
>>>> +
>>>> +echo "Dev 3:"
>>>> +echo "  Physical offset + 0:"
>>>> +$XFS_IO_PROG -c "pread -v $physical3 16" $devpath3 |\
>>>> +    _filter_xfs_io_offset
>>>> +echo "  Physical offset + 64K:"
>>>> +$XFS_IO_PROG -c "pread -v $((physical3 + 65536)) 16" $devpath3 |\
>>>> +    _filter_xfs_io_offset
>>>> +echo "  Physical offset + 128K:"
>>>> +$XFS_IO_PROG -c "pread -v $((physical3 + 131072)) 16" $devpath3 |\
>>>> +    _filter_xfs_io_offset
>>>> +
>>>> +# Final step to use btrfs check to verify the csum of all mirrors.
>>>> +$BTRFS_UTIL_PROG check --check-data-csum $SCRATCH_DEV >> $seqres.full
>>>> 2>&1
>>>> +if [ $? -ne 0 ]; then
>>>> +    echo "btrfs check found some data csum mismatch"
>>>> +fi
>>>>   _scratch_dev_pool_put
>>>>   # success, all done
>>>> diff --git a/tests/btrfs/266.out b/tests/btrfs/266.out
>>>> index fcf2f5b8..305e9c83 100644
>>>> --- a/tests/btrfs/266.out
>>>> +++ b/tests/btrfs/266.out
>>>> @@ -1,109 +1,36 @@
>>>>   QA output created by 266
>>>>   step 1......mkfs.btrfs
>>>> -wrote 262144/262144 bytes
>>>> +wrote 196608/196608 bytes
>>>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>>   step 2......corrupt file extent
>>>>   step 3......repair the bad copy
>>>>   step 4......check if the repair worked
>>>> +Dev 1:
>>>> +  Physical offset + 0:
>>>>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> +  Physical offset + 64K:
>>>>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> +  Physical offset + 128K:
>>>>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> +
>>>> +Dev 2:
>>>> +  Physical offset + 0:
>>>>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> +  Physical offset + 64K:
>>>>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> +  Physical offset + 128K:
>>>>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> +
>>>> +Dev 3:
>>>> +  Physical offset + 0:
>>>>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -read 512/512 bytes
>>>> +read 16/16 bytes
>>>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>> +  Physical offset + 64K:
>>>>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -read 512/512 bytes
>>>> +read 16/16 bytes
>>>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>> +  Physical offset + 128K:
>>>>   XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -XXXXXXXX:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa
>>>> ................
>>>> -read 512/512 bytes
>>>> +read 16/16 bytes
>>>>   XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>>>
