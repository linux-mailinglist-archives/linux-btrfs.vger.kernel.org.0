Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6B97DB958
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 12:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjJ3LxH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 07:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjJ3LxG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 07:53:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F039F3;
        Mon, 30 Oct 2023 04:52:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U3fAjE021727;
        Mon, 30 Oct 2023 11:52:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gKGV9I4F/PnaP3Yal1qSl8v7At93DID06OBq7n1cIe0=;
 b=o2tH7CiMVkO1sxOJCdV/p5GTOgXYdCJIfvBc5sKnU/30CJXZTwZh/bCODHsMnvcQ4Avn
 Hpg7P4Hqti9SVlnte0jGQCTtaq31MPyreQbN6ouIeuEmJVV4HVuwsZ3pMlC5DW+jTbC0
 GgOlPPcx8NrJPMb1MLoJNLbX4m2NKD9iREvKDL9QWwz53nOynulzKF9IKOzEG6aOTJm4
 PKvpS1QvEZZhmYGgPWojPa0ynW1AmbM3a2SiWuN0IbFrQRUWklllXKeEnkk8nA9suOZe
 t5RKdHo/XSjtaVe7Frl9Xp0LLwXRJ2hIr+EF/PkWu7ycvkiB2c2enlzI55rIRf3GdPuU qA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0t6b2gey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 11:52:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39UBDg7B014995;
        Mon, 30 Oct 2023 11:52:53 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3u0rrackrn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Oct 2023 11:52:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d7rebZk/qgS35LR9EH5sBR1G4P71v9hHz+JKck2B8pf5ZA5bfMIhAp5jWpv6ugPtJXXtvPCwjnitbsRY6uUK10opTMNUIKNz43TOpCUDThWmcrrG6LCZ+0ynuUrOrmedlYKArJrA9e4nuv+ZUeCQ+3EXgP+wi27tSlHcsow4NOphId1KCYGK2ehY41Cisvgywbl0Th0C92H480PL6zMf68B06gMlkD2S2XmsBl8EqHFTWFtZChjHnTeIowgHRr42eavsGQy3x2QXxg8LT2z6Bs49ELFEuk/snwRnqFZCr+tygLow4o9eW1yuJF/qLP+1KjnARr8qDKve4K0pzKD2Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKGV9I4F/PnaP3Yal1qSl8v7At93DID06OBq7n1cIe0=;
 b=XfJ6oU75alFUYGNFY7IbET/a2b2auLsFn/UXKNWlgVyQx72GWkwwKYTCmneXLRvz7yhW9mibgaJiCL7LEO1n2ipzyC2FRvQDoDss23bqNtJJFt6mtyNdG7IuqFR/Ai8UWixBuwGNaNxaC9OzhMvMOvd4ZGWpmU49Rctp5woWcv0K9sQdaCy0UysK/0YT3lBJG6N9nRu1FVj9jggFFh0YMj3wSC6XZ8+WClZEDv94fvtVuR5WJRiI2zciQiInRPJmRJ2Ru9XP+mBVk+JSDX3RsKZ/0tXXe0ua7cjVkFqhMHeKmeqfX6e2LOjcdQFhz1t8wOHP17iTcw+VYE507TSiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKGV9I4F/PnaP3Yal1qSl8v7At93DID06OBq7n1cIe0=;
 b=sNJq582IPY3q2LmF4cEno/pW2aoNeBxWYhkod3nvrWilTV0CdR5cxfc4NK4p010Mox0eElYZg3B5foHSoCDylpz2N4EoAgQu0jFXsVJ6/wDkDGce+C7ZuFyfKrmlTtbB3T1zfd5wndM+IwnBj+YPijdm7UIvgiHNzcZopez2A9k=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DS7PR10MB7345.namprd10.prod.outlook.com (2603:10b6:8:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Mon, 30 Oct
 2023 11:52:51 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::9010:707c:641f:68ab%6]) with mapi id 15.20.6907.021; Mon, 30 Oct 2023
 11:52:51 +0000
Message-ID: <691b6ed8-1316-4a57-9789-99718041eea2@oracle.com>
Date:   Mon, 30 Oct 2023 19:52:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 v2] fstests: btrfs/219 cloned-device mount capability
 update
Content-Language: en-US
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1698418886.git.anand.jain@oracle.com>
 <cf97bf909b5a67464f5dcf2a802b7d80c79c472e.1698418886.git.anand.jain@oracle.com>
 <CAL3q7H5d7MHHJFKkkcpg0Nt7naDbURVTpfzXDa8yMTVjxFy=hg@mail.gmail.com>
 <4b206721-5bbf-4ed0-9604-fd1adb0f2729@oracle.com>
 <CAL3q7H5SPo2k1kqLgpPpRUuXCvr-7W5YcKEzHQ7WmBjJAn-kpA@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H5SPo2k1kqLgpPpRUuXCvr-7W5YcKEzHQ7WmBjJAn-kpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:3:18::23) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5694:EE_|DS7PR10MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: ed5eae6f-525d-4a46-ee52-08dbd93ebe77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a9drYGqbkY8Mc8GbntJ4L0BhBdCYSHPloWMjxInpCV2nIg4vM8YLVYka8FHS81IljFimoaMrCZ22LYs3jWMqh1GHb511h1YGNIeQSpM+IzpqfR0dRhEfI+cCsh8aOnDvKRl9Ioxn579q+GbfUzny8G+cq97PyQmfx41onDEawiyHoub/6hluoL0y3T41EtapqKqsaR/ch3kn3shi816IGeHTZTJQlT1GWEsZQKE2KwBYf0qv0W5SNtZ4il/wYJex3b08StWX2Is/fFn0uShD3PH5FYQ57Yex2pvcW0zchsWH7jrDGufEabarCWShYaf1Rxv+3RRHmuE5UllEfJH20JcyILG1LTzEHIA2d0ZA1Ef6ECRADg2oxNDyA+uWg39BSYLUKKv7KLbTjWKIqmcTlQFCKaNUeU22wIplCoOnvSm9HjVLQqVAAP2YNdp+i7UtoPddzLbW1DhXe6V/LilLwXk1heORxFliojGjsZO9KkTJOTTw1iWyanwou+Sx2ucVBwX0YYr6R2slQru8bhWO222DjCxFM4Y3881VnUk6oOM8XDD4UhBO/e2T+gJxo5JcENAM0nqpsBuVc7MmmnsLDx1qp8Pt8bl8FAqVz8pzlUHKv58Q8T30E3BeDZWh5yHU8yeM8cvdFfSwNFtCIL78sg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38100700002)(6512007)(6506007)(6666004)(66946007)(2616005)(6486002)(478600001)(26005)(316002)(6916009)(66476007)(8936002)(66556008)(5660300002)(4326008)(41300700001)(2906002)(86362001)(8676002)(36756003)(31686004)(4744005)(44832011)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXVXclBoYnhBeFJWT3NPejltTDNFMHc2WkNoSitVR29xZlNud2pnTnZLaUNo?=
 =?utf-8?B?VTkyRkpQZ3QrQzFqTXY4R1h3b0dnWVlBQ3prdkdpVzBOVTJsT2Q0bXBENDBE?=
 =?utf-8?B?KytmZUVHYkxtcTFSR3oweVFVWlZTMzlpcG1yR2RvcTBNNFZ5Zit5THVoS1Av?=
 =?utf-8?B?RXJJLzcrUUVLakxwZ2NKMXZlYnRmaXZCRTlIVUovZ0M3SVNxd0tjaUJTUUND?=
 =?utf-8?B?V1ZhdjFvZ0pwNmZwQ3UvZnJBSHBlWmNTUlNpbFRxUXM0YjEwT2JiMEYrelh5?=
 =?utf-8?B?L3VLdkxuYkkwMytSY1JST0RLUURZc1BydkpLL0tMQ0d2Vk8rUFV3cWZNbDFl?=
 =?utf-8?B?ZlovY056ZllFY0s0dE1va1B3b0t6eXRadTlXWkJDcW9xZ0drclBRcGtqMVV0?=
 =?utf-8?B?R1lhWkZnS29LdU9ieEZ6aE1IMW53VHpKV1g2RnFYOEpXUmlGN0hya1o3Ulhs?=
 =?utf-8?B?NGhGMVVuYXNNeDVMTngvVC9QZU1WTitndGFHRHAzQjQvU000TGxTZkwraE01?=
 =?utf-8?B?VzFlRng1TitRSGtwMzFJblFINXR4TWU1R21TcVVNektpMHZ4MmFwMlhNTHZI?=
 =?utf-8?B?dzNESWg4TjJpeFJSZ3pwcndFZFd6NXlKeUM5bDBrbTA1S1pNaEE3RmM4WHN2?=
 =?utf-8?B?amNhN1VDdFdYbTFHUlBWa2R6b29EelJDbjhaWEEwdC9MK3JTSnNNLytmNWVI?=
 =?utf-8?B?ZHVSL00yalJjVnJ3azB1RFlnU2JESERSM1FZRTJzOHdEczRIUzh6K0JHREJl?=
 =?utf-8?B?eTloU2s2MzRVZ2V4ZGN3cnZmWDhlcG5GTkFHTDlEeDZEVGdtZjJkMVJlaW5t?=
 =?utf-8?B?YTRFTlQ1ZDlaU0J3anB5RU5BRU9uTkpEWVJkOUNqeEpwNVpFaWRycDJJMjVB?=
 =?utf-8?B?Z0UyQzg0eHdjeHkzWGxVWDVEODNFallBT0hVc0NUTUZWK3ZzY0RVcEhmY2dp?=
 =?utf-8?B?R2MwaFM1VDQ1OVZqRndJWU5JSXo2akdJVzBUQjgrYWlUanhHMnZmSU5MVjNl?=
 =?utf-8?B?MVBySm9wdng5RTdBMVRhcnNYS0R0b1R4alpDSnVkYTkyQTdaMTYwRjQ2L1Rr?=
 =?utf-8?B?OGZxOUx3MXBOZC81R1hGdGR6bW1HVjJuU0daZDNzRzZVRWZUaWwzbXI5WkRp?=
 =?utf-8?B?OHZWbStpRDBiTU9oYWQ0ajkrQzF1SXhqYkFoN2JEYkZVcFFhWVBybTBLS3cr?=
 =?utf-8?B?TFVNemNIZzZYYTRoNEVxcm43UHg0REpQNnl1RDhOUEx1NzZ0b2U4Vk5iMFdv?=
 =?utf-8?B?WlRtOTFQL3B4TGFuMFFUQWRrcWdxUlIyNTY5andyNCtDOU5vVWdLOGV0OThG?=
 =?utf-8?B?S01SViszWHVYSDd3TDBYdE9RQ3VJY0lmMlpKRnBJZ0F6SkxRL1FSZlFrU1lY?=
 =?utf-8?B?cVRYZjljay9YV1FQbWdzRFlYVUxzTm1tMFVKS2dIQTR3UE9TbHZvQ1UyU2Nv?=
 =?utf-8?B?V1pXbkRXMUlxbEY3RmZEYjVqUkMzOEpoNWlYRTV1WFNEUHRGZGZMRWZNclVq?=
 =?utf-8?B?ZWlCQkNnK2VMTFUxelFCZ1lldmYyMnpZeEwvMG5WdGV0aWJzZjlvZ2FtZkwx?=
 =?utf-8?B?RStrSHJaWGJ3eUcwMGxTTW5OQjBwTUt0cklWL2V3aVdzNGtGUzFicjFMMC9J?=
 =?utf-8?B?czljTnR4R3dIRmJmdHVoTDZjeGF0eUVwUVJ4OERtR01MdHB2QjRDeitsQjQ3?=
 =?utf-8?B?eVRBQUlYdm5NTitpMWMxMnFXU3d5ZENKeUo2bFhkakh4U3F6TEQyeVVKNnZi?=
 =?utf-8?B?YllKRHdjU2dncURyTzhqQzBmTjhVWXlRNFJFbUNyUFVDREsrNXhiZFdLL3Uv?=
 =?utf-8?B?c0JPbG9EYmlGK2VUQlVDMzE0TE1lRURpaUJzSHhTQk50a1NsTXkwVk9Fek41?=
 =?utf-8?B?MW9xcktMU0VqVjRudkhQWkV4TkpmNkhKdVROU3RJU0ZmWVZpZm85SlFVeXZL?=
 =?utf-8?B?eHhQV3V6cW1iV2V3c0EzeTFPalVTNnNTa3lRNDg5T0pFaHc0Ykx0RU1oZThF?=
 =?utf-8?B?SncySmxFWTRmN3MwZko5aG1Gb3NGemhzdDcrRStUbThRS0dCSHg4Sk0yZnNj?=
 =?utf-8?B?Wm9HTTBnVXo4eUpnN2pGZ3dZcGs2OGtQekFSQjFON3lTNXh1aDBWTTJ0b1ds?=
 =?utf-8?Q?/3WHq6Bnk/QHpghxesDMvbH2Q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: jYsoLnjxpC9TUk3fPCXqX/ifSieuVwh5gGUpruKMcNy1Igic75ayGd7IZ9xz8WmvAiAXcTfftkVcYLtTzCgtHQNRt3H/vxgp5vnaz3cBwczy/7hgsqKCRYrX8K+fY0/sPszAidtn7Fbxjx37PNao+S8pmOKxCdyfsfiEySB8VQ1C7oEQmpznkJuq16cAHYOyEMa+KEUr0nOHcyb2kah8ohEW1BLaodrkI5bMRfHJuj+rIUYALxG+s4WyHpoKZvxuxDK4HlagzXAzh1lA8ITLXID1kIgpbZaIgON48D9RG6mdlOPX5fTABxzGYhz5xo3YhKaYF+cY2T1cH4gspfOJnnRBTjecL0Qt7XWbjdtjkyyIW35052YkyiS0zqnnhcF4aKeOMt8hyZLuZTxCG6UcnFolxuZVHElBHG+aZzti7SlwzNKWRfSpnE8ucvfVTMbTqfo8Dy5vLgzy5OXvL1ofHr4HbAZqcGis3o1J34yF6fUc6Ce8cNVPauIQmbU40geZkntcc9t++UFUQiqqJiOxeIWX78cbx4OG/mLlt2eefyPcMAZOJBag90D81KdfvlmYLafhnBwagnMTQQE0PgwGKVFUj6pXtRvlKTdhDLRXwFURmkVJ8LVdo7fObVllIG0kvp9z4GkyI0sTJPcBqjNFTk3XjLdiG4upE2T2fDKoezpQGzRyz9QRDduiI3mhM2Jc7unzxhRlJXmzheNpmd4Nf8D5mh0pbt5ceXEojMMBtGFSl34R150cWgkvbT8i+R9gWsKBMxmCgOlWg0ppf8SNpsB7fIlYpbebcMHTj2io3ww=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed5eae6f-525d-4a46-ee52-08dbd93ebe77
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 11:52:51.3055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VU3nAhsDDtM30RDEsL8WkNutJEKcY3weLTHJIS0MBHXLdwt9Kt1LZloYmg24MnaWTKZpjwfDfj1vgiWZX9XWKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7345
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_10,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 mlxlogscore=982 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300090
X-Proofpoint-GUID: Y5eOLgOrFyjOm2h5eO4r_6KQxZwd5KcN
X-Proofpoint-ORIG-GUID: Y5eOLgOrFyjOm2h5eO4r_6KQxZwd5KcN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> Is it really worth doing this type of change?
> I mean it doesn't change the correctness of the test, doesn't make it
> more readable or
> maintainable, or even shorter... It seems pointless to me, no clear
> benefit of any sort.
> 

  It fixes the cleanup bug that, when a test case failed, it failed to
  remove the 2nd loop device.

> I'm not suggesting a new test case.
> 
> Remember the code you removed in v1?
> My suggestion was to instead of removing it, just surround it in the body of an
> if statement:
> 
> if temp-fsid-feature-not-abailable; then
>     run that code you tried to remove in v1
> fi
> 
> Isn't that a lot simpler and clear?

Alright, I'll maintain the simplicity as mentioned above. Nevertheless,
implementing a thorough check for temp-fsid doesn't add much complexity
either.



