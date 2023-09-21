Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1DBB7A9045
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Sep 2023 02:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjIUAxv (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Sep 2023 20:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUAxu (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Sep 2023 20:53:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C23CC
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Sep 2023 17:53:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJe1v009276;
        Thu, 21 Sep 2023 00:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=3S+bfaDqBO88GEnOlVbK8sW/c9HzGot/FTWKFBDkJwQ=;
 b=tKHuQoULdIjVm01SrKv4tp7RMu/Ds94XekTRqdJg8qqUcwQf2Xg4ddFPGYqqINAFkiLz
 B0f6BuV9tgp2NA1TjRv5XrcIpMeJiT50FFURBzIW/ACSIT1b/0eF8FY+yOCsgPegnO8M
 xf7D/drGC3tNVh+2pCmQxTcwoSJNSiUHC0CEXQFlTvH+hMErObU/LwhP32yIf3npP+E1
 7Uml/GcLzIqIRDn/mOF8bbm5R1Sxozoj5Ekf2nuL8kpvth+KFiJgt2f0I4XHeqYcfxFD
 LC17Ncwx/q+pAfCiSpvPxKMVkv+yRoaD196cQ9e3BESs0GHDs9MEql5/I41UcEhDdZ5x WA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t52y20p2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 00:53:38 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KMcvs1012032;
        Thu, 21 Sep 2023 00:53:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t83qyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Sep 2023 00:53:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=On2sZMOyJXpWhGgNY4iOs5S1erbHNJUJvk1CgvhAgvxxequrj7Gmt2cUg/bewV7La9lBklYI6pps71QHBA7oVr5P42AmdRkEIMbLU9Het5LDB7cdI0wtyp7lrJFQEjzkCHKNFRHblaW0FCieVVr6/fsQPZRuv9N7l6uHAfCxrd3Za/Dje8P6Ka7D3k3srCeE/T9xyEvdZzXzvCeWpo1s+JRtOB3cqXGQ/Rr+JAt6/q+U/DVPunoOwR3+CPlyM+Y7Y+cRpEzN/7Syar4Ns+TpyqyIWzySjXSs+WhzVqKHLXP6R2z4cLVtDaixCoPSxQAAnSJkzHYOnptt0xfHj3/jag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S+bfaDqBO88GEnOlVbK8sW/c9HzGot/FTWKFBDkJwQ=;
 b=HroW7XrWZUj5avDCGn6cmC4Ch8WLAD+yjqy/7XkVTyTYS6ZskEewnPtrHXUSrslFecjObkJzsejlxGHqH06DrOncgnFe93TfjcxbZfRA+4i43rmGRoRqpJQc6GgTeT8dX6U6ocTdvUjFGW2Bs+OHr3+epQfYVc8pI6FpM+ieT93YTt++mlF2qk267xbXif4YYWFA4NIALNtBUoEwAy/4I6HCUvOTBbDEIC8zza5Mpo/aRFhbBIXwNGcOaEFk27WD3pNtTbrVPdhUrf8ghzruzSRRdvierZ8Vj0g3c8Y3HTzrZTdo8+oEi2nkmsvCy8RYjYTMCqqgluGUq8JGlbp9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S+bfaDqBO88GEnOlVbK8sW/c9HzGot/FTWKFBDkJwQ=;
 b=PcAvzoY7QyPSitz5Q1Gwx1/a2aWntG9sNfJcqDRULJ6Uz3a6Gi+bOWHhApDXY2GqslJr+FRGwvMLwjqYFxzeu5rOC+O8SVu6FnnikgyVboIAf8ejTt29itMQ40Ss61cFD3d8qj6S1gW3a/IKkbMux7/cOs3vUoqI5ef8oalE66E=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4763.namprd10.prod.outlook.com (2603:10b6:806:117::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 00:53:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::2bbc:60da:ba6c:f685%2]) with mapi id 15.20.6792.024; Thu, 21 Sep 2023
 00:53:17 +0000
Message-ID: <2adb8c79-d1d2-dffa-dd6b-5254d75c9c86@oracle.com>
Date:   Thu, 21 Sep 2023 08:53:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/7] btrfs-progs: cmds: add "btrfs tune set" subcommand
 group
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1693900169.git.wqu@suse.com>
 <1c294f739f028da499cf7f57deb334f419979097.1693900169.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <1c294f739f028da499cf7f57deb334f419979097.1693900169.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4763:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ec78db9-c3fa-4700-63d9-08dbba3d24af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CVnsNzkCDKIbMUsor4TpHHFiRuZdnopeaEC+qy2uhgP0WGZGMBINp/jRTvi/D17HTCyH3B6cT6pbb1XzC22l8TvUrSS6kNDsP55y83JNZhDUn/04y8/7mgHEFkT2DgPn2GxenG+Zf3zUafl5IeOHERko1E4Y4n0r7Vs3KrcNfmA7n00CcxLqklQnNfVmC1yxhVdGw8oG0lP/LG26ERYltdIiooCHAQ9BWpcumgnIj3GV8TvsRmwAODPCQ3Yl/XavZutTW4YGpwDGuN9QBMniPo9YmbcQpCz12sIauMx8lZrXYDyxm1duHhW8pfLT7jll2VUm3Sn+7dczx3xvGH7o1tEfUBjCM3LG+dfTJp1S2VuMZMSVw491s5/SIYffHQgtPld4OlTLDcILUFFU2vEsE6Ir5Jvax+h5W4yV1Vm+YzxWhwjyPYX1AzSRdfrzS2PuuuBW4NCxeNNTVKN/MByJ/bJjopEbdhRqXOuZ4r1QxhfKGDL/u7S+oF5qTuUP+fB1PAYPMVWrFE4XSiTaCBBpzNNlX3cc/T0LboKaQuh67pun7V81rO1U38Z5QusR8UUlLTHwFT/5KcKvWp3SR5pIKUPjeGrMFpjormUMTHieQYmgjbnCn+XsAX6Ygfm2636Wq3EYJ16My6innC+nm+04PSTIr3tgdx6Kfp82xlqyEZPzalAtBuMbnrZwg44agsuR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(376002)(136003)(366004)(1800799009)(186009)(451199024)(31686004)(6486002)(6666004)(53546011)(6506007)(36756003)(86362001)(38100700002)(31696002)(2906002)(26005)(44832011)(2616005)(30864003)(8936002)(8676002)(6512007)(478600001)(83380400001)(41300700001)(5660300002)(66556008)(66946007)(316002)(66476007)(2004002)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjIzbXdNSERYV1pDem9EdWVkMzhxS09CRFk5eWdVN3doemVQSjJKSDZpSDVD?=
 =?utf-8?B?emtOcCtiZHZqa0pSNXU0RjZSeUZCWkpWWHN3ZDNyT3ZoYmpOLzYwdkNkMkZ2?=
 =?utf-8?B?TllhK0ttaGlBeW1LZ3VpOFkydjNlbGcvT2FSTDdTWE1TclRHWGMvUGtzR3Bm?=
 =?utf-8?B?cVBEUUNtWDBCbzNLK1hOVDYvSmFjYmY0MXRSRWxDTTZ0TFpHZXNmaWp0Umcy?=
 =?utf-8?B?NkxuRk9FbWRoSUMvY1V0d3ZXZXlHMjkrN3FSZnNGSHMwU2REaGxXa1BxbnNn?=
 =?utf-8?B?RERKb1hhM3F5RURmbU5yU0FGaWM2U0dLUkFTWEJRZ2ZzTThQRDMxckRXdTBy?=
 =?utf-8?B?dk1IVEtPTVA3eWhFaHVGdmJhb0R6VDJhTit0bjBXZ0FrdXBBVHVQMWVRbGkw?=
 =?utf-8?B?ZndwMEZMdE16RkQvQlRlOE0yS21GS2xkTHlxcjNxck1EREQxYno3aDdrL2k5?=
 =?utf-8?B?UUl3ZGpPT1FwNE5kZGZsSFVBbWJSUGRHV3ZlQUZVeUV4bSt2S0pndWpRbVln?=
 =?utf-8?B?TnpJT2luQjNnemxFSEgxaU5zeCt6bGZJTXRMYXlNUjlpWENxT0dxdGgwOFVI?=
 =?utf-8?B?OHpOc29jSDlvSlBJbHlodS9oRWNtSFR3K3ByemowVWtkdEZHeWxEUTNqWGVW?=
 =?utf-8?B?QlRSK0p4QXlpVGRUWTl0aVlUVVdaTUV0OXFaNTc2V0xRNzlVbjlMYkJoL0hU?=
 =?utf-8?B?V0FMeGZDaFZ3dkhtZHdlWitYV3Y0MFV5aUdadzNJd3JqVkNvVmlDMDd0aDVY?=
 =?utf-8?B?a2lzb3BVaExvVXVKWE02a2t1cFRzSXRibFB5UVJpN3psTUdjbEpVSDJEWTdN?=
 =?utf-8?B?K0w0bnp5NnphRUJFLzdWYncvZm1WUEt6bE9RMGdHSHdYcysrdW1DNWZOaDJJ?=
 =?utf-8?B?OG1FdWdpV0V2MVFwZE1SVHB4TzByUjJyaWp1VE5WR3VucVA4SUFHZTE2RG5Y?=
 =?utf-8?B?U1FJcU91c08xZXdZakZDSk5PajRGblhSNm9lZ2FDOHpwZWxYSzBKT2h2ZXFz?=
 =?utf-8?B?Zjc3QXNEUEZZR21pZ0VIcm5sNWFOc3h5aWoxZ0pCK1B4eWdZeXkzUldZdWtQ?=
 =?utf-8?B?WkNBektXWXEzTE1QRmVtY3RFVmplOTZ1Y2FKdDRjeFhhbWFjTW92YXpYWUdH?=
 =?utf-8?B?ZFRMWGFiVE9UQzI5bjRZdThySDRtTWNwU1VycDVzbU5NcGc3TGpzalZ2QUZp?=
 =?utf-8?B?ZDBOejNaaG1WczJKUk9aUTVaSUdhOExCMTA1bFFUNldWVFVNdHFTWXFVZnIy?=
 =?utf-8?B?STRSc3lTcHFKMWM1bi9RcGpvSnpPZTh6R0MyY2cyeTBTc2w3ejIrQk04MGZD?=
 =?utf-8?B?SjVGL3F3VXAzRlRRZWFwSXlXRmg3K1laWkNyYXdESW9Ec3FMUGxuRlIrS2Rz?=
 =?utf-8?B?T2I0bjBKOFlQRlhuYlFjMDBKUnVRV0xLN1l3MzdFbXBtRE5rL1NpTS8xSmdY?=
 =?utf-8?B?Zm1KNi96bDNTNEVOdGFDcjN3aUZxL09WMlp5d1FyMnJEVVo5eit6TkdpOVYy?=
 =?utf-8?B?MDFoY2VUeTZGYnlMM1RpZFhMeG45bWQyRTdkUHRsVytiTVk0M2hObTM1T1FW?=
 =?utf-8?B?OU51akcyRlVjL0YzTXBKcTZERFZDdjRCOUNkTk9oRURwZ21aYjd5c2pjZlBR?=
 =?utf-8?B?RFdDYm0xNGFNa1RMSTVMQ2orNngxS21WMnZxUk94c0F3RXlmOGRjWklnb1Fi?=
 =?utf-8?B?ME1DeUpZQWNtaGRVdXVzSG5YWUFyV2d0dWxQUVpRYXMwRE9QdFNlVlZCQkdQ?=
 =?utf-8?B?MU1lSmcvbG52TElreCtlSlNaZFAwdVpTN1E3MFlhcHFqZlJZNUszME5Ea3dX?=
 =?utf-8?B?QTZibGY1Qm03UjF4blJ1Qjg0WXRBOTF5d2dVbzhRbzJNWEI1bDBvZUNubk0z?=
 =?utf-8?B?TGtFbHJqaDltYkpPNWVscU4rK0xRYzdzQWJvWk4rZ2RhekE4c0pyelNNcmt0?=
 =?utf-8?B?dnZWelhvVWQzVldzZ1VzWENVbkdtV0tvNm1VNHBSU2tEdXMxemNSTkxNdnZ0?=
 =?utf-8?B?Z2dvZythcE5Pa1kyUWtPcTBhZm1VVlQ2eFpvSjNvWnI2cWRHVFppbDVSTG4v?=
 =?utf-8?B?WmJpWnROMm5RWDE5WGkvQTdkNnVoQ0taLzJWOE14Tk1VT2I0Q1pTQUlNWDQ2?=
 =?utf-8?B?RkZGLzAvUXdRdGpYMHMvbEc1RkRibHZqY1RLYnZienduNnhKNStYbTRFMmdQ?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yYTiIoIQpuTUauc1z9AHYkDmtrmw0AU1ghNDm8DP25t8xMIswa80XzFcWIZpF6eVtWlem3/po9fUVbNvpNzU/LGfzhH1Jc5WxvY+AuBRpCShlMs4UDy3qfPpDfZ2FF+5t8e4kRcwXRBRh03Yv1VNWQP6mHbdmVEN0hJE68B2qEPoIYIP65NvR5O2NVJuiu0LQNJw2xeoc2wF2boQMbEhTRXM4Lq0o0cAmpUFmSQ3RLuuSQCcBP0O085HW0x6ZifDZVoYsx5y0T+uP66AL94fh8AHO4rcvVsGlw8uilbK+l2u6vnbVtFbhZvmWp7QbxziSCxsvc0EZ1/PMylw6pxfKipA1Qq08BhMggMdhfhA/ir/HE0AhAGZcz8kE0MIv6OC9lCj1Lp99YQEpH41rWDA05PPP5QIGAi/ursquoNR6FFT7R8PlONefVP8xxhMEHH6VkUlh3r86qQKazyxPVK8D15MiHmuCxBpVItVIfhCshcrJrNnP/pIRSTRua/AflHfcoUcInJLo8JQxvjMCEUYEuJV+mHI5QUoD93y3+IUVwhpulBAvPMdwEglA3GX+4h2bj7YH9Lh5LOopnfTq2HeEAbFfbGuBi3YYFluYIOhQkwDnKWm4kPHRfY2kpCuC3pi/2QxZvDQBZQKkFWRItvsY3q1dbQiWT8jCJlm25t4Je9RmOGFgH0H4zCvEvvpDQenVq/G21OgXGTf0qdRsaQD/FlnPkne+dzLsi0j0WfhvV7PKWStpALPsy3dKns7QNIp9OlutkSIpRX2U/8x20j57ALC2h6r38HyoioqseyLcAw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec78db9-c3fa-4700-63d9-08dbba3d24af
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 00:53:17.7011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+dmUB8RW8woOry0nNhMLCKJQtpEZQYv4XtI/lflmJFV+rqTgKFISCiRdvCU0kKXY+fbST3KSpBAGM73FvLwcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4763
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_14,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309210006
X-Proofpoint-GUID: 8jCzo0qToSaQ0Pm54o6TK3Ah9Mk8kWn1
X-Proofpoint-ORIG-GUID: 8jCzo0qToSaQ0Pm54o6TK3Ah9Mk8kWn1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/09/2023 15:51, Qu Wenruo wrote:
> As the first step to convert btrfstune into "btrfs tune" subcommand
> group, this patch would add the following subcommand group:
> 
>   btrfs tune set <feature> [<device>]
> 
> For now the following features are supported:
> 
> - extref
> - skinny-metadata
> - no-holes
>    All those are simple super block flags toggle.
> 
> - list-all
>    This acts the same way as "mkfs.btrfs -O list-all", the difference is
>    it would only list the supported features.
>    (In the future, there will be "btrfs tune clear" subcommand, which
>     would support a different set of features).
> 

With this patchset, the syntax is structured as follows:


    $ btrfs tune --help
    usage: btrfs tune <command> <args>

       btrfs tune set <feature> [<device>]
           Set/enable specified feature for the unmounted filesystem
       btrfs tune clear <feature> [<device>]
           Clear/disable specified feature for the unmounted filesystem

    change various btrfs features



However, for consistency, I suggest the following syntax:

   set:
    $ btrfs tune <feature> /dev/sda

   clear:
    $ btrfs tune <feature> --clear /dev/sda

   list:
    $ btrfs tune --list-all

This syntax aligns with the:

    $ btrfs device scan --forget


Thanks, Anand


> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>   Documentation/btrfs-tune.rst |  40 ++++++
>   Documentation/btrfs.rst      |   5 +
>   Documentation/conf.py        |   1 +
>   Documentation/man-index.rst  |   1 +
>   Makefile                     |   2 +-
>   btrfs.c                      |   1 +
>   cmds/commands.h              |   1 +
>   cmds/tune.c                  | 227 +++++++++++++++++++++++++++++++++++
>   8 files changed, 277 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/btrfs-tune.rst
>   create mode 100644 cmds/tune.c
> 
> diff --git a/Documentation/btrfs-tune.rst b/Documentation/btrfs-tune.rst
> new file mode 100644
> index 000000000000..827c92eadb72
> --- /dev/null
> +++ b/Documentation/btrfs-tune.rst
> @@ -0,0 +1,40 @@
> +btrfs-tune(8)
> +==================
> +
> +SYNOPSIS
> +--------
> +
> +**btrfs tune** <subcommand> [<args>]
> +
> +DESCRIPTION
> +-----------
> +
> +:command:`btrfs tune` is used to tweak various btrfs features on a
> +unmounted filesystem.
> +
> +SUBCOMMAND
> +-----------
> +
> +set <feature> [<device>]
> +        Set/enable a feature.
> +
> +        If *feature* is `list-all`, all supported features would be listed, and
> +	no *device* parameter is needed.
> +
> +EXIT STATUS
> +-----------
> +
> +**btrfs tune** returns a zero exit status if it succeeds. A non-zero value is
> +returned in case of failure.
> +
> +AVAILABILITY
> +------------
> +
> +**btrfs** is part of btrfs-progs.  Please refer to the documentation at
> +`https://btrfs.readthedocs.io <https://btrfs.readthedocs.io>`_.
> +
> +SEE ALSO
> +--------
> +
> +:doc:`mkfs.btrfs`,
> +``mount(8)``
> diff --git a/Documentation/btrfs.rst b/Documentation/btrfs.rst
> index e878f158aaa1..5aea0d1a208c 100644
> --- a/Documentation/btrfs.rst
> +++ b/Documentation/btrfs.rst
> @@ -134,6 +134,10 @@ subvolume
>   	Create/delete/list/manage btrfs subvolume.
>   	See :doc:`btrfs-subvolume` for details.
>   
> +tune
> +	Change various btrfs features.
> +	See :doc:`btrfs-tune` for details.
> +
>   .. _man-btrfs8-standalone-tools:
>   
>   STANDALONE TOOLS
> @@ -150,6 +154,7 @@ btrfs-convert
>           in-place conversion from ext2/3/4 filesystems to btrfs
>   btrfstune
>           tweak some filesystem properties on a unmounted filesystem
> +	(will be replaced by `btrfs-tune`)
>   btrfs-select-super
>           rescue tool to overwrite primary superblock from a spare copy
>   btrfs-find-root
> diff --git a/Documentation/conf.py b/Documentation/conf.py
> index 1025e10d7206..e0801bca4686 100644
> --- a/Documentation/conf.py
> +++ b/Documentation/conf.py
> @@ -66,6 +66,7 @@ man_pages = [
>       ('btrfs-check', 'btrfs-check', 'check or repair a btrfs filesystem', '', 8),
>       ('btrfs-balance', 'btrfs-balance', 'balance block groups on a btrfs filesystem', '', 8),
>       ('btrfs-subvolume', 'btrfs-subvolume', 'manage btrfs subvolumes', '', 8),
> +    ('btrfs-tune', 'btrfs-tune', 'tweak btrfs features', '', 8),
>       ('btrfs-map-logical', 'btrfs-map-logical', 'map btrfs logical extent to physical extent', '', 8),
>       ('btrfs', 'btrfs', 'a toolbox to manage btrfs filesystems', '', 8),
>       ('mkfs.btrfs', 'mkfs.btrfs', 'create a btrfs filesystem', '', 8),
> diff --git a/Documentation/man-index.rst b/Documentation/man-index.rst
> index 36d45d2903ea..5fcd4cbc4bee 100644
> --- a/Documentation/man-index.rst
> +++ b/Documentation/man-index.rst
> @@ -28,6 +28,7 @@ Manual pages
>      btrfs-select-super
>      btrfs-send
>      btrfs-subvolume
> +   btrfs-tune
>      btrfstune
>      fsck.btrfs
>      mkfs.btrfs
> diff --git a/Makefile b/Makefile
> index f4feb1fff8e1..9857daaa42ac 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -239,7 +239,7 @@ cmds_objects = cmds/subvolume.o cmds/subvolume-list.o \
>   	       cmds/rescue-super-recover.o \
>   	       cmds/property.o cmds/filesystem-usage.o cmds/inspect-dump-tree.o \
>   	       cmds/inspect-dump-super.o cmds/inspect-tree-stats.o cmds/filesystem-du.o \
> -	       cmds/reflink.o \
> +	       cmds/reflink.o cmds/tune.o \
>   	       mkfs/common.o check/mode-common.o check/mode-lowmem.o \
>   	       check/clear-cache.o
>   
> diff --git a/btrfs.c b/btrfs.c
> index 751f193ee2e0..c2dae0303ffe 100644
> --- a/btrfs.c
> +++ b/btrfs.c
> @@ -389,6 +389,7 @@ static const struct cmd_group btrfs_cmd_group = {
>   		&cmd_struct_scrub,
>   		&cmd_struct_send,
>   		&cmd_struct_subvolume,
> +		&cmd_struct_tune,
>   
>   		/* Help and version stay last */
>   		&cmd_struct_help,
> diff --git a/cmds/commands.h b/cmds/commands.h
> index 5ab7c881f634..aebacd718a7b 100644
> --- a/cmds/commands.h
> +++ b/cmds/commands.h
> @@ -151,5 +151,6 @@ DECLARE_COMMAND(qgroup);
>   DECLARE_COMMAND(replace);
>   DECLARE_COMMAND(restore);
>   DECLARE_COMMAND(rescue);
> +DECLARE_COMMAND(tune);
>   
>   #endif
> diff --git a/cmds/tune.c b/cmds/tune.c
> new file mode 100644
> index 000000000000..92c7b9f1502c
> --- /dev/null
> +++ b/cmds/tune.c
> @@ -0,0 +1,227 @@
> +/*
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public
> + * License v2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public
> + * License along with this program; if not, write to the
> + * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
> + * Boston, MA 021110-1307, USA.
> + */
> +
> +#include <unistd.h>
> +#include "kerncompat.h"
> +#include "cmds/commands.h"
> +#include "common/help.h"
> +#include "common/fsfeatures.h"
> +#include "kernel-shared/messages.h"
> +#include "kernel-shared/disk-io.h"
> +#include "kernel-shared/transaction.h"
> +
> +static const char * const cmd_tune_set_usage[] = {
> +	"btrfs tune set <feature> [<device>]",
> +	"Set/enable specified feature for the unmounted filesystem",
> +	"",
> +	HELPINFO_INSERT_GLOBALS,
> +	HELPINFO_INSERT_VERBOSE,
> +	NULL,
> +};
> +
> +static const struct btrfs_feature set_features[] = {
> +	{
> +		.name		= "extref",
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF,
> +		.sysfs_name	= "extended_iref",
> +		VERSION_TO_STRING2(compat, 3,7),
> +		VERSION_TO_STRING2(safe, 3,12),
> +		VERSION_TO_STRING2(default, 3,12),
> +		.desc		= "increased hardlink limit per file to 65536"
> +	}, {
> +		.name		= "skinny-metadata",
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA,
> +		.sysfs_name	= "skinny_metadata",
> +		VERSION_TO_STRING2(compat, 3,10),
> +		VERSION_TO_STRING2(safe, 3,18),
> +		VERSION_TO_STRING2(default, 3,18),
> +		.desc		= "reduced-size metadata extent refs"
> +	}, {
> +		.name		= "no-holes",
> +		.incompat_flag	= BTRFS_FEATURE_INCOMPAT_NO_HOLES,
> +		.sysfs_name	= "no_holes",
> +		VERSION_TO_STRING2(compat, 3,14),
> +		VERSION_TO_STRING2(safe, 4,0),
> +		VERSION_TO_STRING2(default, 5,15),
> +		.desc		= "no explicit hole extents for files"
> +	},
> +	/* Keep this one last */
> +	{
> +		.name		= "list-all",
> +		.runtime_flag	= BTRFS_FEATURE_RUNTIME_LIST_ALL,
> +		.sysfs_name	= NULL,
> +		VERSION_NULL(compat),
> +		VERSION_NULL(safe),
> +		VERSION_NULL(default),
> +		.desc		= NULL
> +	}
> +};
> +
> +static void list_all_features(const char *prefix,
> +			      const struct btrfs_feature *features,
> +			      int nr_features)
> +{
> +	/* We should have at least one empty feature. */
> +	ASSERT(nr_features > 1);
> +
> +	printf("features available to %s:\n", prefix);
> +	for (int i = 0; i < nr_features - 1; i++) {
> +		const struct btrfs_feature *feat = features + i;
> +		const char *sep = "";
> +
> +		fprintf(stderr, "%-20s- %s (", feat->name, feat->desc);
> +		if (feat->compat_ver) {
> +			fprintf(stderr, "compat=%s", feat->compat_str);
> +			sep = ", ";
> +		}
> +		if (feat->safe_ver) {
> +			fprintf(stderr, "%ssafe=%s", sep, feat->safe_str);
> +			sep = ", ";
> +		}
> +		if (feat->default_ver)
> +			fprintf(stderr, "%sdefault=%s", sep, feat->default_str);
> +		fprintf(stderr, ")\n");
> +	}
> +}
> +
> +static int check_features(const char *name, const struct btrfs_feature *features,
> +			  int nr_features)
> +{
> +	bool found = false;
> +
> +	for (int i = 0; i < nr_features; i++) {
> +		const struct btrfs_feature *feat = features + i;
> +
> +		if (!strcmp(feat->name, name)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +	if (found)
> +		return 0;
> +	return -EINVAL;
> +}
> +
> +static int set_super_incompat_flags(struct btrfs_fs_info *fs_info, u64 flags)
> +{
> +	struct btrfs_root *root = fs_info->tree_root;
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_super_block *disk_super;
> +	u64 super_flags;
> +	int ret;
> +
> +	disk_super = fs_info->super_copy;
> +	super_flags = btrfs_super_incompat_flags(disk_super);
> +	super_flags |= flags;
> +	trans = btrfs_start_transaction(root, 1);
> +	BUG_ON(IS_ERR(trans));
> +	btrfs_set_super_incompat_flags(disk_super, super_flags);
> +	ret = btrfs_commit_transaction(trans, root);
> +
> +	return ret;
> +}
> +
> +static int cmd_tune_set(const struct cmd_struct *cmd, int argc, char **argv)
> +{
> +	struct btrfs_fs_info *fs_info;
> +	struct open_ctree_args oca = { 0 };
> +	char *feature;
> +	char *path;
> +	int ret = 0;
> +
> +	optind = 0;
> +	while (1) {
> +		int c = getopt(argc, argv, "");
> +		if (c < 0)
> +			break;
> +
> +		switch (c) {
> +		default:
> +			usage_unknown_option(cmd, argv);
> +		}
> +	}
> +
> +	if (check_argc_min(argc - optind, 1))
> +		return 1;
> +
> +	feature = argv[optind];
> +
> +	if (check_features(feature, set_features, ARRAY_SIZE(set_features))) {
> +		error("Unknown feature to set: %s", feature);
> +		return 1;
> +	}
> +	if (!strcmp(feature, "list-all")) {
> +		list_all_features("set", set_features, ARRAY_SIZE(set_features));
> +		return 0;
> +	}
> +
> +	if (check_argc_exact(argc - optind, 2))
> +		return 1;
> +
> +	path = argv[optind + 1];
> +	oca.flags = OPEN_CTREE_WRITES;
> +	oca.filename = path;
> +	fs_info = open_ctree_fs_info(&oca);
> +	if (!fs_info) {
> +		error("failed to open btrfs");
> +		ret = -EIO;
> +		goto out;
> +	}
> +	/*
> +	 * For those 3 features, we only need to update the superblock to add
> +	 * the new feature flags.
> +	 */
> +	if (!strcmp(feature, "extref") ||
> +	    !strcmp(feature, "skinny-metadata") ||
> +	    !strcmp(feature, "no-holes")) {
> +		u64 incompat_flags = 0;
> +
> +		if (!strcmp(feature, "extref"))
> +			incompat_flags |= BTRFS_FEATURE_INCOMPAT_EXTENDED_IREF;
> +		if (!strcmp(feature, "skinny-metadata"))
> +			incompat_flags |= BTRFS_FEATURE_INCOMPAT_SKINNY_METADATA;
> +		if (!strcmp(feature, "no-holes"))
> +			incompat_flags |= BTRFS_FEATURE_INCOMPAT_NO_HOLES;
> +		ret = set_super_incompat_flags(fs_info, incompat_flags);
> +		if (ret < 0) {
> +			errno = -ret;
> +			error("failed to set feature '%s': %m", feature);
> +		}
> +		goto out;
> +	}
> +
> +out:
> +	if (fs_info)
> +		close_ctree_fs_info(fs_info);
> +	return !!ret;
> +}
> +
> +static DEFINE_SIMPLE_COMMAND(tune_set, "set");
> +
> +static const char * const tune_cmd_group_usage[] = {
> +	"btrfs tune <command> <args>",
> +	NULL,
> +};
> +
> +static const char tune_cmd_group_info[] = "change various btrfs features";
> +
> +static const struct cmd_group tune_cmd_group = {
> +	tune_cmd_group_usage, tune_cmd_group_info, {
> +		&cmd_struct_tune_set,
> +		NULL
> +	}
> +};
> +DEFINE_GROUP_COMMAND_TOKEN(tune);

