Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3734CCC3F
	for <lists+linux-btrfs@lfdr.de>; Fri,  4 Mar 2022 04:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237846AbiCDDYh (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Mar 2022 22:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiCDDYg (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Mar 2022 22:24:36 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E5015695E;
        Thu,  3 Mar 2022 19:23:49 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2240ivIS013852;
        Fri, 4 Mar 2022 03:23:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=avQQJ1BZA+nTe6OBN63QdRiSbCQVf5zhg395wL00ARQ=;
 b=uvw5MXMWsiGVOwNj5+zwPJYfwZMUirqmKg+YKgjVu+h9FA36ctxGm+V9hSy90yWLb2gg
 AmAdjHdn96rnmYA074aJBbEEV6od5tiRDXPVIu1a2XvAmoPInVjaiGc8cKSALFRIjoBc
 TAckp/kmFrjJIs8Uu4h6ShpHf98SKuaeuZNLNF7unzKaS5fAR/riRk2DmsPNfmPf8oOw
 EwuYHE6S3/5VNEIhiEpAYe0oOrazhoywLSn6+dVvJnMy/AhoPwK4HX6IpAm69bppi8Cu
 P7YuDL7+AbFfkOk/8CbLCc60erA9MzJMFlnLg8g+2aQooD7ho3rztLwAkc3dKnngvkJG Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ek4hv8n5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 03:23:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2243FRqb053135;
        Fri, 4 Mar 2022 03:23:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3020.oracle.com with ESMTP id 3ek4jg10j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Mar 2022 03:23:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/W7hzBiyf5KxvWIB+H4DhP4oT4QWTTR7DlaGhUGuHzfuF7XptqRzLmws3AHto3OMO0lrSGMa8D5z2lRwlyRqOMsESCNcoao+O7g18hGw4Ut0BpY0O+gNGy1LngJ1IFK2IbQtYFR2e9Vq2TWkp+01Ds1r8rGHBZPIjhx0WNqZPLEWyVsuQj3ydodZ1HZHaKWTuETI6+Tx9/dchBbxQ+zwolcOM+hb8CGXRKFWKIYwXaC9C1LpSmc9c1lrIBItcwsUwuw+vTxDZnfNtGlSJy0tB9blhwUtfvya/89AAXZ51+m29tf+Kq+/QQQSLBK3E5yVbzEFElmr9cL218SexOK5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=avQQJ1BZA+nTe6OBN63QdRiSbCQVf5zhg395wL00ARQ=;
 b=kLBZ2eLqBoHYTs6l6NH590e19NlxxqgIJ19PDOL3uD03IXMiDEOGIZlb100KLenSStZBIIhVFU7WunYeSGwF9BmEEfj72/65TuZRRfXz+3BO/RoLBQf4Sc8qHRh5r/4yeRZlDjZX+PVNdnqijVtm1R1/dhsG98/da05ZkUW/nWzzWiie4nQIGPR1NdR+nYWv8PvsF84wnQdN/Nl1UJyxVhbSMt+v5X4qtOP7BJgnGwt1feelTR1sYwPD3fu0SYG/wdSuyhay1kSRPGsXCncvLm8g1HHGn4LjCylYAo6JLz92V8T3pByJNrJXv+7qJQo+DL8UE03q0T1OU5fTrfcTig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=avQQJ1BZA+nTe6OBN63QdRiSbCQVf5zhg395wL00ARQ=;
 b=oe3OpuPkrGH0DtPkSWFrbHSO1GuRvnFgyWcNt5iiVksAkIucn0GCt/zWnuGXQq/c7obVceNJ8NLKv/MFCMgtmBbmlI1a6dz1Rf+uSce9Uychrcn8SEiAQmhk5vOKUOmN+yYDtHAwdUER6128d2IacIFvTgZWKxIeKmlF6ZRjlhc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN7PR10MB2563.namprd10.prod.outlook.com (2603:10b6:406:c3::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 03:23:37 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%6]) with mapi id 15.20.5038.015; Fri, 4 Mar 2022
 03:23:37 +0000
Message-ID: <52f97b9f-804b-3d06-9f59-28607a622d13@oracle.com>
Date:   Fri, 4 Mar 2022 11:23:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [syzbot] KASAN: use-after-free Read in btrfs_scan_one_device (2)
Content-Language: en-US
To:     syzbot <syzbot+82650a4e0ed38f218363@syzkaller.appspotmail.com>,
        dsterba@suse.com, hdanton@sina.com, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000bece8f05d95afc28@google.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <000000000000bece8f05d95afc28@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c11a4bc-4f2a-45d4-5367-08d9fd8e5ede
X-MS-TrafficTypeDiagnostic: BN7PR10MB2563:EE_
X-Microsoft-Antispam-PRVS: <BN7PR10MB2563F24A446A96578BC8E758E5059@BN7PR10MB2563.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O6totZ0QnckhQuH3332v9Hu6xFXJXbLEVROP8qAOZn6M10d9j0faS/XGGcYvEa7a6zz2Prrk6dITnnVFthYruLNpSy5XRuQrz3WCuK7/mhqFT4IBU8qSfvD6g0HdJQ41j3KPdl9kZhcF68wKlSm1b7xOrAtkXFtBK7T0fX68w6cB8YWQcEj4AtP5F6HbNMgBHbDbMdwIuprXpY/C98yChtBnp4T6esLF5PCvLza5DxUKX23cvtNbF2srYIc/38bPRWqy1Y2k5U/0qKcBmN6GAlRlteKorfvVXh9JKSvjbzvVisCVbFbgpFV4HdlrUCc/BudCgtbGH0Q9fxsXdiOH+6NpicX2Km6iDqZfbrSEp/F26yZxO6P98fCAqGty8784W2+r6QP80M1BlQMJ0IIv2lrU6hNoRes5NQgeWCvrnp6t8WnMECdr7Hq5658q8PzJKOcTWG78UwsKmKKvf5kaXRFa9UH96xBHSrdHMVAy9Qkudba8i0CiNoLlJ44Tw8zddTzfYKMW31T9YjgC8wKYQoDcNE8Z/EAxAF9EXJngBfdOUBjA0wi7Ft7CXt/G4Igh8uMK0CmbyJo7i/UjuBDKaMzc0xWvzc2PlX7krujaBHYuv9siMUA69npjVgsbQQyvGss+Z0T9kfFjffF0fXF6uOYRb4ILMFQRv3IdNDzv4THX+FfGXGdPH/C5N8aO51knbJw2w8ngLfTt3wc0TaTc6n3vlNp8FW5fWcX+AXkcH1QARKmoxd9k9hh22kHr3fHo0kwwnmneBFsITDTCn/TNG1aJla3D0jJdTJXcEFQ68zoCh3rSsovZL/PZog5tm6E1wa0caaVBfHo/fABNLETFKy4SeDfmQixFrZi7FOHsH0HIz5V/sEPNvqlxZMKhfS3U
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(31696002)(8676002)(6666004)(38100700002)(6512007)(316002)(86362001)(6506007)(66946007)(66556008)(66476007)(4744005)(966005)(6486002)(5660300002)(508600001)(8936002)(26005)(186003)(36756003)(31686004)(2616005)(44832011)(99710200001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUtMSzVkZ0QzUFpyei9xekRKT2hMK1k0RitJTndPVEVOeWVHdDdRRUFpc2M0?=
 =?utf-8?B?bWJ4YmlqQVVjMjZ4TmdLb242MllYbE4yVU4vZ3Y1cCtkaXRSWEJURkRQSWxB?=
 =?utf-8?B?VVQ0UHpldUVYdDVtckJLb3pYMDVmNVR1dG9SWlUyNmc4TVA3QVQ0ajdpQlpx?=
 =?utf-8?B?cWpDS3d2WmJVRldZMlh2WFhjYk9UamF5ZTJMRkNkMTVzZWppNzEwanl6dFZS?=
 =?utf-8?B?Z0xVbUE5S21XeUE0OStueWVKdGova1BxSDJabUVEdjRJSzBGS1hnZDdBVnNu?=
 =?utf-8?B?cmtiQzVUNXhTR3pwbmxRdE1pd25BSFF2aVJLSkpUNy9jQTBoNTRaMzRUVnBi?=
 =?utf-8?B?a3oxdmQyWFpsbWhIblNWUGhZUVlCVEhRRGZWSUoxczJCOEZXN29wUkMwUzhu?=
 =?utf-8?B?VWVaTmhiSUJZRWorclVSVjlZQkhUcFp4OUxRTWZtZEdCVXE4ZjZMQmdRUFRT?=
 =?utf-8?B?U1JwQm05UzVjd202U1VFZ1hZQko1WDBNWGo3Zkt4TG9Rb1pWNTNBTDVqYTBS?=
 =?utf-8?B?RG9qdEJkR2prZ0o3QTF2ckhWUGkzZEdCcHhRYnB0N3pJYnE5VFNJMkc5NHdj?=
 =?utf-8?B?OG12Sy9mbUdHNjdNdVBnRjJ0czllS3V3MmQ2LzBDUnozNEZLTkFEZXNIM1NH?=
 =?utf-8?B?MDBmUHptSXQwNm42ODY1cGc0VG1NR1cwVkJUelV2NEplenYvUzlTMmFiRDdU?=
 =?utf-8?B?TG0vM1IycE1LMWhlanBlUGVJd0RZRnhBcEJuNkV4ZDhMTHVTazlhYXFzRFhn?=
 =?utf-8?B?enNjRlNlL3oveE5qODNuSXFGZVFpLzZBMExRYlA4cXpKREZEVWJtbkpNUjNS?=
 =?utf-8?B?MG5mZkp5bGNLdDIxYUZYV2lVcWl0VkZlUld1Ym5UQlY3UW9uWDhkMUVSbVg5?=
 =?utf-8?B?UGdzcGR4eWtwY0tsaklpamhtR3RwZFRnWVUrLzZ0ZExTckZ0S1VCV1FrOTRS?=
 =?utf-8?B?ZXZnSkhFVStkbTZqdHRjNlJGdkVtV01IWWIvckpaakVTc1dMbnV3M2diM1JL?=
 =?utf-8?B?cC9zSStvdjEvR2ZIZk5iQk5mQThTblg5NFdLNFlQbUEzMGgvUnFxSGJXNnk0?=
 =?utf-8?B?SDFXS1JJU2c1MkNFQXhZcHEwMUxyeVVudXBaWGhOVjlhZjIrbUVqZUo0MjZy?=
 =?utf-8?B?eGI0bjl0Nm9PWS9yUkVsK0VCWVE0U0o3Ulp6Vy9QR09aeUg5cWRld2tpL2Ri?=
 =?utf-8?B?cjQzdzhLNU9IS2JURGtZM3EzMmxPYU44cVZuV3NtZ01Sa3pnS0UwT2JsSGFp?=
 =?utf-8?B?MGpDaWVnWkc3MFBwOCtzdVpOOGtNb1ZZc0ppVThhRFdCU2pWeDMxYlZhdmFZ?=
 =?utf-8?B?OVkxUmpVUEtwUlBCWFA3WEhOb3BwNEtZU3pGV0xhc2JZTWF3WFJGRXhSTW01?=
 =?utf-8?B?dEZrYWhUSWRuMjluV2tnTEFTWE5JbElMMEtMQ3NvNStYWWprTG9HMEdEQVcv?=
 =?utf-8?B?cS9Iayt3SlNWMHloSGVtbFdtYWMxeldTKzlUZzJTbmo1UFI5MXZGWW1yUEFj?=
 =?utf-8?B?TjVyR3h3Ni8wUEJYN3lYMTM1bWowVDE2NjM4U3RLTkZ0dW9tZDJRUWpjcHdw?=
 =?utf-8?B?ZUFqVUdCNEp2Ny83a0Nic0RWSHprZ1hZR05ocWR1S2pJUHNjaE1nR21MTi9m?=
 =?utf-8?B?Zys4Y1AxK1pYdEpQenNOTFZjZXdyRjFxVWR4RXRTUmE5d3g5SndPS2lNeG5E?=
 =?utf-8?B?dGtRbXB6RDI4U2pFV2RaWGhlZmFTRi8xbCtQZjNhK1NEY2E4R0RpM1N1NHNp?=
 =?utf-8?B?SGU4OG1rdUtRVDY1UFBqZXAxRm40RnZnbElPNHhPdTZLS0NWcWR5QUEyLzNT?=
 =?utf-8?B?dHhZdlVLT213bDVvaGNJL2hyV21LeEk3SXJwRVVjMlh0NCtSR1VrdWZpaHBk?=
 =?utf-8?B?aC9EN05obFhDUGFGQlNJSlNLeWxKSHlLOUQ0MHFqbnNlS3VmWXJacEcyamRj?=
 =?utf-8?B?dFRaNHpEaTVYOVFESHl3OGc0amNuYnVKSWV6Y0VPajREYzA0UWM1a1RheDFZ?=
 =?utf-8?B?S0w0MnVMZFVaYmc4RFBRdE1CTUFiUStMZC80MDI2NzlTd1hZY09lM2ZRY2ps?=
 =?utf-8?B?Yy9lQlIrT0pQNjhFUTJnL2dNeEtQWU53SzNmcHdNTmUzZFN6WXplM09XTXcv?=
 =?utf-8?B?MGxDVm1yUjRvQkRncVF2eXljWkxnRVo5dEVNQ0lrdmtEQ3BseU9jUG52RVIz?=
 =?utf-8?Q?t0/LPWlqSDMLTNIvzDD/ILo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c11a4bc-4f2a-45d4-5367-08d9fd8e5ede
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 03:23:37.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MhonpKqeSz1AW/msiMk9cdFt9d5vQhYqH+kkrsOmMoxT1ngmbn/XEpRbJGylLUjsbBDuT7jBJCcnuYV9ihOJhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2563
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10275 signatures=686983
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203040013
X-Proofpoint-GUID: e1w2phpbxLmX9pNg7GVqLq6U9D2yqVbd
X-Proofpoint-ORIG-GUID: e1w2phpbxLmX9pNg7GVqLq6U9D2yqVbd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


::
> Tested on:
> 
> commit:         2293be58 Merge tag 'trace-v5.17-rc4' of git://git.kern..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
::
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=133011f1700000


There is no commit id in the patch. The patch diff doesn't match any
changes in the current misc-next?

Thanks, Anand
