Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D065F65BC3D
	for <lists+linux-btrfs@lfdr.de>; Tue,  3 Jan 2023 09:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjACIaK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 3 Jan 2023 03:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjACIaE (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 3 Jan 2023 03:30:04 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4780DDF72
        for <linux-btrfs@vger.kernel.org>; Tue,  3 Jan 2023 00:30:03 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 302LcVut016926;
        Tue, 3 Jan 2023 08:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=THRNOzdooO9GLeQEmSaEQ8ej5tLOUsXVsK773mZwvGA=;
 b=AgyoonhL7rE77bxdGgKRLY/kRnvO0u7NE4W4XtxuSg0muHkjQr+2hpN6g3G3NY+YgXqa
 FccWyhdZi7U54uAzTBy2ag0rZOud9aVCIFHoXYY3Ft7zuuxkW7jRRipXOGNU+sDufEuN
 RJ98LEZ4NAIBhtoHq0oanx0jPrXcv+LEI9Rw828dyMdZjkbmaznaGCDaQFUUOroOJqtM
 CsDRjvoiNVR03zKTSbvJ34smbvryLWqXFxQd0jl+IUZdPAcYyL/RIIDXbmtxSqxmwZA/
 pC/PZEulVyl133ft2HDSkd/avRPPkPoqZVn83ddtQgFoAo4G/oBXZy1/5pXUPlDzAVQc yw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtbgqkdua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 08:29:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3036BcRi033986;
        Tue, 3 Jan 2023 08:29:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mtbh4hd02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jan 2023 08:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKFFtH3dOH95x/f3Jjvbt/alT9B9UkyVpdWiQLVV04zoH5H1/iYwT61tsZAyGQ/58AFm7rNPYuXAK+I1dO/pDerZPPuss/TlrFEE3IVVC0jEgPjDDm603D8Cy1zWljdZDGXxn9HZzTRMNnOnn6el216NjiRyCEsqFzj/bALrKqqswqqC0PdLSPm1zikDohJkgt2z0pQOQLzfT6betEL3+xaGfruVNlC2oiPT6BJld4HLxe+75yWuWZEEI472SyLVNFu4oAzzYx1TWrjfmR71g3ys6bkM/5jKyCU7bhRVJuvzNmSSopZP+22zePtKabEy/k5yNIpnZqD3o2NbO4td1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THRNOzdooO9GLeQEmSaEQ8ej5tLOUsXVsK773mZwvGA=;
 b=ddTyBtMo4yX8CR2QZoaAo0ZfTDp0rHzdxhNPzVJyeOJcqcnJZBvlkZ9VRVTN/EtzOfVCnHxpgu99zSETQgh383f2LdSI/eEfC6tQOBujdvMbOaRJIvyHFazQ+2dw55LMGxwT8ihovpkIzW1T1m6edptXaljXBNf/C/OL3V2VpwchktkdOzCN8jYBbh5l7H3VXj0pCRCeBfB+EqtbofkSGsH8vE12JTPAGopxIWBAo5FtQupg1DidyElH2yacO/+yzmFOGnzYHhcIlX0ilJnWT49C53NIWy6TE3qtyIXiSgeovkXmcCVZ8xLztZ26Gj8UaIvyZ9wGYZgL91e4yfXrOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=THRNOzdooO9GLeQEmSaEQ8ej5tLOUsXVsK773mZwvGA=;
 b=WSy83aQ5vy93d1chekVKi4UE359MCHNh1yW/YkZu36i4b7ZQsOrBkA4GjNVB3z3ln+55yHuYBcFWJMP02JkE9KGL5pQmC94EAKtVRknn/dtUIPRiFg9u+e4D3+0fv5mRVvsBrxID1Y4P2ShD5WgzUVu2G6AN/EjzdF6560sB9OE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by MW5PR10MB5852.namprd10.prod.outlook.com (2603:10b6:303:19c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 08:29:55 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::57b0:9129:31d6:613a%4]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 08:29:55 +0000
Message-ID: <4a708562-b91f-636b-f8ae-388ab2c14859@oracle.com>
Date:   Tue, 3 Jan 2023 16:29:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: don't trigger BUG_ON() when repair happens with
 dev-replace
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?B?5bCP5aSq?= <nospam@kota.moe>
References: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <e6bd27828dfa486ff27e39db13b662e06d71ec74.1672534935.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0239.apcprd06.prod.outlook.com
 (2603:1096:4:ac::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|MW5PR10MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a12afe-e97f-426f-1b79-08daed64b122
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zk0yrhpSgjR3xuBCTqtOOrHqTZqriuDCsfL1xbxgar5SLyJuRRL3Rstn2fZr79SuX5phBSinhCQsEKC+hhCHFNAOPjPnc3gF1ylUhWl0LvOqCTwWfJDZk3iWiiFqvgC6dcIxFLhEk0DrmOtdTS9Wld5mWwzim3gLDyRdEbEIvahK9CvbvvibBHd0jjIG0ee69Qa0T16C30lDg6CxKBJcO8G5rCTCSz+C0muGr3l7vxHFBU3yOlOTM1KealpxplE9vAEYBP1u6E7JxFdXuIx+mkowulEhtKeYdUX1SkPvVoDxu/CdHY3Zl3tE4pnKCp2AShlWWWCJGgdA9dFvf80zTIg5fBlP1sjm8foOqzuiktFkGtxBk/SwMCjrEsIDoBqjxhqQZStWJsvonGwFEpdY5dYFyQAw3Sx7vq+vI4IhkDV/YuvLNyX9MjqlIg3BO4TEywjrSDgG0ABT6aR7VmDLEyTknsBL1Erfaj4OnbothllP5CW8skBj9lkdSGDio63jpZRM8dhyGjN1a1cjNas1MiuUo4Ac/magOUTHi8DuyTunKAeUHFrj+Z19oMJFTnG5znxILsPPN5t8ye1gR9PnEr+Ykv5dvQdpcNWqbA0dYERDV4h91HAl6yJ8lKTVOmYeBHrT8LzOIx1ty7A4MhTyAVfnWa8TwmodjgXH+NxYBDgDGpVOASVAl1Y35iFxlpPWlmNiFggups9OQTq0ODtE9j/jedDiB3PzMpA12SUbRZt/kP9Xlzm54ao4gSLa9oyfv/mlItZYxwEY4eA99uN28hi0EtoXD2rguoBt5ZTmthI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(39860400002)(136003)(346002)(376002)(451199015)(31696002)(66946007)(66476007)(66556008)(86362001)(4326008)(8676002)(6506007)(36756003)(316002)(966005)(53546011)(6486002)(478600001)(38100700002)(2616005)(8936002)(44832011)(6666004)(41300700001)(5660300002)(186003)(83380400001)(6512007)(31686004)(26005)(2906002)(22166006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDM0NzhqQytXWHhFVjhsK3M1Q3VwNkxOdWpEOWFrK0wwSERtYnRua2RMazlI?=
 =?utf-8?B?OWxML3dQRkFaMUVrUXhPQ3J0cnRHZEJMSjlsNVJER293S2dOUEFjRGJJckcw?=
 =?utf-8?B?UzF5bFM1Z0hselBHQ2ZPSU1vRlFsaEFqWlc0M1IrdHRYUFdWU1VEblV6akhE?=
 =?utf-8?B?dDZDMEQvZXhrazhXcnhFRkp4aGw4bHV4KzdlaGtIS1BMOFhCdVoxRlZydDkx?=
 =?utf-8?B?R3FkcWVPdVBhQzBJeFlvS2h3Z1lsZWJhaFFTU2ZreG1HU3crMjdDUkFFU1po?=
 =?utf-8?B?Tzl0a2tpR2Z3NndTaWlFdmQ4L0g4WmZTTHJmWDN0cWdxK2hUNTA1YUFISW1W?=
 =?utf-8?B?djRsckt5WU5pdUxGZldScDR2ODUrTVh2MXlHRkVJL2JFd2lZeGN4Q3FiNG9E?=
 =?utf-8?B?TWp2VGNEUzNvOVRiSFoyT0RTUGZZWitLUWRaQjZ2eE42UjNRWk1GS0tPS0FQ?=
 =?utf-8?B?a1diZkV4bTVnZHhNWG9PQUVCYXR1M0RYQWZZOTdkVGkzTGdSY25aZDJXRWE1?=
 =?utf-8?B?RkJNdVdadzJ1emtPUWRuUmhhTGdpT3lsbXAweHo4TloyNm1aWUtiRHM2WDZG?=
 =?utf-8?B?czk5Y1hlaFNqSHVWRHRtcWl6Q0cxQXIwaFZzSHZWKzNVNzUyQ3daMlh0c3NX?=
 =?utf-8?B?VWRNb05OWGpVRlBHMXFndEk2dXErL2VnaGdyRFkvRTNkRCtjNEJwZzRjNDFV?=
 =?utf-8?B?dEcvS29IMHpyN25taEkxU2U5MUFJSldhR1BlV1p1L0VNRFJaMU05dWhlWWFr?=
 =?utf-8?B?ci9EWDd1NTVQdFd0UGR3dSs0ekIyK3B4N0NOclZvWTZVdk5CZVc2ZVJIY2VH?=
 =?utf-8?B?ckdFT2c1aUV6UksvbHdZdmVLOG9ZU0ZwVlo5THVpWjNVN2hHMXl0WVhGdGhO?=
 =?utf-8?B?Mm9kbHJ2Y2hnc0FWWCtlNXMvT211Ni9hbTRMUWJsVWNyNmNhaFVPUjJiVmFS?=
 =?utf-8?B?L2VRU2lESWRBQmFUR29yWlBpYXJ1YmtHZ1VrVjRZUU1kbkg5c00rQXR3Wnln?=
 =?utf-8?B?QkpHdTB4VVlBVUMwbkZETW5PUCtQODg4VlhMNTNTbjZ1dDF2a2RhUWpnNEpC?=
 =?utf-8?B?Yjlob1dGcUlVMnFqaGNVakwwVVY3REV1bXVpK3VmVDhXNGtldGQ3ZXBKdmhL?=
 =?utf-8?B?bGlVS2RteXB4S1dyVC9mY0FKbkNZUkV5ZEhBcnBoUlNjRmJiakw3ckN1dWRC?=
 =?utf-8?B?NmtjZndDMUp5eWR5WmhOZUs5OTNBRDZVRjU1WXBGOFd6SHZKV1ZPUVR3YlMy?=
 =?utf-8?B?S2FCSHJCSy9VQTFXRjVtT2luallXOUM2Y01TMk9HUFpsbm53Ymo3V0dZVVNt?=
 =?utf-8?B?RThYVm5ieXYwb1VSL1hHa0ZTaEVsdDN5aTdZVXo1dEtSVzhjdVdCdFlQT2RK?=
 =?utf-8?B?aGYxZGpOVVphQjhaeG8vVXNIYi9QUkdvd2RiRTc0THo4NTZ3S3crK1BkT0x4?=
 =?utf-8?B?NnZmaFFOcjZTQkdmR1hiYWRqZzhYanZ0QzBOQ3FkWUJ6VGJIUVVnTlpMeWsx?=
 =?utf-8?B?UnBZNENtWmpNWm5Hcng4bWtXcmVIVUF2dzVjbDZtb05OZ01sM3JTTmFYT05O?=
 =?utf-8?B?MzM0dktSRE1MTFpYb1RncVRJV3JVMllyZDE4K0NTQ2lSOFpXR3lYOW4vcVN2?=
 =?utf-8?B?eW44a1ZBajJ6VEo2S2JETmg3QmJHQjZkMnVsVUU2SmNBMjFrZjRNbHZ4QXZY?=
 =?utf-8?B?RjhkR0g0ckJVVkxxdmUyYW9Sb2VEQUxWQzl1cC9OSVF1bTdJSDY2d1VpM0NE?=
 =?utf-8?B?NHhtT3ZOcDZEa2ZoTzBpUEd5Y1VtTXJkbEliU3FTVExpUkVBT2xjN2J6dEw5?=
 =?utf-8?B?Nk85QSt5anFwM2NxZFovcW15cnExNUVVQ1VvRUVoQndwaE5pQzROTjFyZ2xE?=
 =?utf-8?B?UHRFUXJTdVFzV1RNM1lXZDIvVVJ0RkMxdUZ5TFZnL2JjbWZFMmpGSkxQOGMz?=
 =?utf-8?B?YlBJcFBZQ0xFaURHcWRsN3htaUNVRSsvVjBKblVmTlhhTGhYTkFGc1NBRFZy?=
 =?utf-8?B?Zm9PM0dpUnc1UVlrSlJXdDFaNWdlTjExUTZTa2hzU0dBN29oeGJTbC85WkpR?=
 =?utf-8?B?SStCZXNybWFlbHhLV25xd1JNMkxibXdNM2F2bDE0QWlFUGhXT05oSm9sejlL?=
 =?utf-8?B?cVJqeGxQUmx1b3h3QTZUaFBmUU5xSkpqZktKdnRKL3RTUE9ubFBnNVhlSVNQ?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hkDAnrhoWVlfw4DJQxbIp1+v1qNQnZANIU7lCOFco4svPPQRvJxCaRBuEaLNhQLh/yrCFGFf2/3NTpSkwXd3PysRYpAdliGOsDF0vEVoqxImUcjJ64Slko3IW2OmMmSfRDHmy+misg06znDHAakCPhTgAfcdPmcozEGQXgFZk4ocW0Um4VWXPApKjiBug0OvwnTQy/FWttUBqlYxMIMh+5rA7jdlutWzWMWSSl+qf/AROywAU0i5ahNYkiDd4TtBnEfLoA2CcXVxGxG0FfhF8xKetc2l017eUZp66TBK/gYxi154CATFCnRmPqqRVxTw2iD05rFxcayETVe4jqxSuQBAsL2sSKw4NN47sLCotRm9O3++5MQIyktmCNsr9KRHKqhNinyfi6vFXAoRoS2gxBXmnbpUX8K38+tIY+au8bL56drtPge2x6XeuBbt62UJ9e02eqDPHk9C6wVE8IThg5/cVGp1Pg5jFlUDeBuVQhkhMkkOZVvBp1ne/CN52iLcVdzQ15Xy/nOWBmI1FFc1P2AHpCKPUDRXrReJ7O4E7q6WzRZbWKorWtr5O2HEQVTgrpOtqp43PDQcML7ygW7ZMKzyJvFJDqz2p/TwQ2iNO+dRPFbw/y8wukFKE5M9dTZBq0qw/I8FYd298f5pZ4Z5u9323GSHW4hkE9fBqki0JDcUkzxBm2q0MbTQk+SLpYyjSQra0RapKK7eXZRx35pj5FTW+MR9llr48x+PHqiEXz/k9ZXbwc1fknopp0yAM4Hcei/xe0FiF/K1nOCUxcCuQy0EAAWXCfvl/TTlNdYzej5vGPv3XHbKT/CG5+rQi5GP
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a12afe-e97f-426f-1b79-08daed64b122
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 08:29:55.3785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lNKJz5ApkkBoFpZKTT8oelwicGjgOXEkybVPctX4xp9pq+YvjtRwVg1JlWbUhE/h+4PuUVsqIxef5ewkLhYleA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_14,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301030074
X-Proofpoint-GUID: 226XHvC-gN6Tgp4YYW0cV8zyqhkbxul-
X-Proofpoint-ORIG-GUID: 226XHvC-gN6Tgp4YYW0cV8zyqhkbxul-
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 1/1/23 09:02, Qu Wenruo wrote:
> [BUG]
> There is a bug report that a BUG_ON() in btrfs_repair_io_failure()
> (originally repair_io_failure() in v6.0 kernel) got triggered when
> replacing a unreliable disk:
> 
>   BTRFS warning (device sda1): csum failed root 257 ino 2397453 off 39624704 csum 0xb0d18c75 expected csum 0x4dae9c5e mirror 3
>   kernel BUG at fs/btrfs/extent_io.c:2380!
>   invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 9 PID: 3614331 Comm: kworker/u257:2 Tainted: G           OE      6.0.0-5-amd64 #1  Debian 6.0.10-2
>   Hardware name: Micro-Star International Co., Ltd. MS-7C60/TRX40 PRO WIFI (MS-7C60), BIOS 2.70 07/01/2021
>   Workqueue: btrfs-endio btrfs_end_bio_work [btrfs]
>   RIP: 0010:repair_io_failure+0x24a/0x260 [btrfs]
>   Call Trace:
>    <TASK>
>    clean_io_failure+0x14d/0x180 [btrfs]
>    end_bio_extent_readpage+0x412/0x6e0 [btrfs]
>    ? __switch_to+0x106/0x420
>    process_one_work+0x1c7/0x380
>    worker_thread+0x4d/0x380
>    ? rescuer_thread+0x3a0/0x3a0
>    kthread+0xe9/0x110
>    ? kthread_complete_and_exit+0x20/0x20
>    ret_from_fork+0x22/0x30
>    </TASK>
> 


> [CAUSE]
> 
> Before the BUG_ON(), we got some read errors from the replace target
> first, note the mirror number (3, which is beyond RAID1 duplication,
> thus it's read from the replace target device).
> 
> Then at the BUG_ON() location, we are trying to writeback the repaired
> sectors back the failed device.

s/failed device/replace target

makes it consistnt with the para before.


> 
> The check looks like this:
> 
> 		ret = btrfs_map_block(fs_info, BTRFS_MAP_WRITE, logical,
> 				      &map_length, &bioc, mirror_num);
> 		if (ret)
> 			goto out_counter_dec;
> 		BUG_ON(mirror_num != bioc->mirror_num);
> 
> But inside btrfs_map_block(), we can modify bioc->mirror_num especially
> for dev-replace:
> 
> 	if (dev_replace_is_ongoing && mirror_num == map->num_stripes + 1 &&
> 	    !need_full_stripe(op) && dev_replace->tgtdev != NULL) {
> 		ret = get_extra_mirror_from_replace(fs_info, logical, *length,
> 						    dev_replace->srcdev->devid,
> 						    &mirror_num,
> 					    &physical_to_patch_in_first_stripe);
> 		patch_the_first_stripe_for_dev_replace = 1;
> 	}
> 
> Thus if we're repairing the replace target device, we're going to
> triggere that BUG_ON().
> 


> But in reality, the read failure from the replace target device may be that,
> our replace haven't reach the range we're reading, thus we're reading
> garbage, but with replace running, the range would be properly filled
> later.

Although we write good data later, I am not sure if it is acceptable to 
read from the unfinished replace target (devid 0) in the first place. Do 
you have any ideas?

Thanks,
Anand

> Thus in that case, we don't need to do anything but let the replace
> routine to handle it.
> 
> [FIX]
> Instead of a BUG_ON(), just skip the repair if we're repairing the
> device replace target device.
> 
> Reported-by: 小太 <nospam@kota.moe>
> Link: https://lore.kernel.org/linux-btrfs/CACsxjPYyJGQZ+yvjzxA1Nn2LuqkYqTCcUH43S=+wXhyf8S00Ag@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   fs/btrfs/bio.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> index b8fb7ef6b520..444e20b15e26 100644
> --- a/fs/btrfs/bio.c
> +++ b/fs/btrfs/bio.c
> @@ -329,7 +329,16 @@ int btrfs_repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
>   				      &map_length, &bioc, mirror_num);
>   		if (ret)
>   			goto out_counter_dec;
> -		BUG_ON(mirror_num != bioc->mirror_num);
> +		/*
> +		 * This happens when dev-replace is also happening, and
> +		 * the mirror_num indicates the dev-replace target.
> +		 *
> +		 * In this case, we don't need to do anything, as the read
> +		 * error just means the replace progress hasn't reached our
> +		 * read range, and later replace routine would handle it well.
> +		 */
> +		if (mirror_num != bioc->mirror_num)
> +			goto out_counter_dec;
>   	}
>   
>   	sector = bioc->stripes[bioc->mirror_num - 1].physical >> 9;

