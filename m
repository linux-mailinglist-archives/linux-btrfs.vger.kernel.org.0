Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794D770DA14
	for <lists+linux-btrfs@lfdr.de>; Tue, 23 May 2023 12:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbjEWKQs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 23 May 2023 06:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbjEWKQr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 23 May 2023 06:16:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810D8FF
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 03:16:46 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6EeRm032439;
        Tue, 23 May 2023 10:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=YKgbh1MXiO7Pl9G1MXGj77QIMiKfDHwCS3uwSXNoZH4=;
 b=VFsCg4h5Go406Z7FDuKd564frsbb3VeC0wddplQ6DK0kXmNzFS9Oy3uuLDHdquY/AMVE
 boWFjo9AJbIMtmm5ffnpasZegfXm23nz7CKHK4JVYcVJxVrm5Nrf0XGUgrS7bLPb9DUu
 QPsPn4u9N7w5yC7AEkwyM2hnV0vImpkRlfLA7cA3aMw4dojq/Z6NrYjilOuCHKHFcEJ7
 Hb0tES0QwwF9BCt0ILRvqftTX0nBz0rEvk8rRXn1N69dHJu+ENqOwmaRjYXqQCIMTkZ/
 +Xh6S54vatCp60OPwrYCSTvNfr2syqJ3khRXHVJJ3lRTqAOt13Nyyj+JDR3KzdHFDYXC FQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp5bms2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 10:16:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N8vBDe024503;
        Tue, 23 May 2023 10:16:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8u4jjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 10:16:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWVWDZmYqVZpL8qcG9fGKi0vg32q9l0PjzYh6E7T7/WIw43LFxLkAD3P5Q5hcY0G8gLyQPvhn8Ms/4Ow3agUGR62d8erECwEh56hzl9Z0QQqGGZuhpZX6K/d/LmSHALwcYrJ+9d3+zfbihI8nPbT3Smnf3BqTy8jGGh1PeeUyxwhH2wUYHJtnk8D+MgMaksJnpsxgSxMgj+MztlhrOZt7nHYXNMprbhjGbD0xI5Ozi2kreB9rZfVnNaIjlFpkrTyfmSlpqpFruFaycwMterg2lZplpyYyVgP/2prV+JOHlKpMlYqeXJifubHyQxQBDX5H+5MynLOPo/1Rxp2qcYw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YKgbh1MXiO7Pl9G1MXGj77QIMiKfDHwCS3uwSXNoZH4=;
 b=iK4p2vdv2B+dszZEj4wkBFGrHmQC8J2Dnof1jiYnZGVJQFF5CiJaGIInYrdzQmFbMp+aEVXy555ACGMlIjclgxmp3MnT2062HG54CsRB0PPTvtTejKza+8Gy19BRwgXH7oGJkAqw3YIVo46zq5TvUCQdb46RFKjOpKKelMH6vIDMsLxgMg7N1n5B4cWoE4vLWkUseEiyQJRZKfXqHMd+/Cj4yMvR95FeYCNRuVv2QzLGTBWAntag1WudAGoeu7Vt/s23vbuASW6rm159OLVyVAwAV9F427O5Qs1ATGzrjM9QtbMu3dvznqaeIA0UvuwivoqRibVLBqkhd6HUoYadTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YKgbh1MXiO7Pl9G1MXGj77QIMiKfDHwCS3uwSXNoZH4=;
 b=Hd/34iO8mT/wjlf6eF2ji4PUY+3eVksSTIvkNrfv3HS6Yhwwe1awu1ANvCfT6Q/TPUDb618yKNSMeJEFTS7/GBzISWgD0fcJ48dqlJkB1+zEsjGRpZCduH9HVtSfrdnQUqVCOunbxd5hfag0XK6/47xW9kKlNyvPYXwiQeeevDM=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6861.namprd10.prod.outlook.com (2603:10b6:8:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 10:16:34 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 10:16:34 +0000
Message-ID: <7d1d512a-e4d6-70c1-93c9-61800955b4b0@oracle.com>
Date:   Tue, 23 May 2023 18:16:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/16] btrfs: factor out a btrfs_verify_page helper
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230523081322.331337-1-hch@lst.de>
 <20230523081322.331337-3-hch@lst.de>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230523081322.331337-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: 764351da-3157-4d14-5a2a-08db5b76c8c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +DIKvSJbuiOGDkjAluzhglwUTi30Eo2apuBTkphVoXJaScU+GxQVODKOGWB9+IzTANgQMUGjISmWxumhjMqNJclfoZnSVGtwpT5qbF+q3IlS8wVgXJSB31vGAGJKMWVjHP/QHibxbi7o7ZbKGJSvkxPxTYlYgsSpltFvFAbU6Xl5aX93vskwoMBWu3vFbi84Yq1wZuQSIBIRBsrrkq+3RNGNbRMOCfWNtzCgw4E9fc+Ey4XWdKtHsQ2AYGbjRLhdXAatX84fW4tTTttBOkdHIkEmhn2TbwSuTlKg8H81koTZoNLskwSFSGiLtJveBJoeGwgfZ2CaBbNPTswFiC4LBefW2BcMgeAKP0f5XqVWJWozkE3t6GWRgS6jYMwgzklxc5+bLHKsxhwtu+wvaLtjxqutuObbAbUCD9Oomhph+T8syvujdofDB5MA19iI2KF3Ja2DOXci3ekHky6pN36/WMxt3JV2sMOukUbFEsRw2fj2k064xelBeqoRqm14fCwAa0OinbM+8lKyPcUsYUPfp0dEN2JwENmVMdBtM85RGsoF9K/hROEbfT5WlPO1bIwvKRje8y/6Haf+N901S0FwbSRQ+BkiFQgQMbHN2WduonFJ9K0wnaD/Op6KmpP6RJCEyh8jjtBwkrdz81JKaqkjaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(136003)(376002)(39860400002)(451199021)(8936002)(8676002)(5660300002)(44832011)(186003)(53546011)(83380400001)(6506007)(26005)(31696002)(86362001)(6512007)(2616005)(38100700002)(41300700001)(6666004)(6486002)(66556008)(66476007)(66946007)(316002)(4326008)(36756003)(478600001)(110136005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWxkVkp2eUFHOTY5VlB0SHlzU0hNbWFWTEZ3RE5rUUxmRnlxQnFQUDg5SVdt?=
 =?utf-8?B?a3FiSTBEM1oxNU5CaXd4S21vTzB3SEl1ZTR6bktoaXFrallDOEl0Q3V4U1hL?=
 =?utf-8?B?UTBxR2lqb2FOa1dDVmg0djZKWWN4TzAyOXlWc2tpb0NZL29Ec3hXYVI5TVRJ?=
 =?utf-8?B?UGNEN2NtQVgvNlJ4VTVMSTNLMmVmMGU1KzAvTy9rdDM2Y1F5VUxxNkJEYkda?=
 =?utf-8?B?eDZDcWhqOGE1MXpQMkZpMVRPVEdFYjZDWFBrTnpHc1lnVEJYUGdYTmM2cmpF?=
 =?utf-8?B?KzlWcHNDSlhWRGhVSEYvT0tPQUdnbjh3eEwxNktkc0VCRXRWUEt2VFY3UVBp?=
 =?utf-8?B?ZEI0aFhDMlJTMXFpWWJEZXNiaUljNTRkNkw1Zk1GZE05T29pM2NiZTliZSs1?=
 =?utf-8?B?bFhtakpDa3M5SUtKMHlWSjNnOGN0RWhXeHBJTmtudkdIcFFlZHduVU16dnBu?=
 =?utf-8?B?dVYwL2l5bkpsRmE0dUFIYnUzRUdEVlFobm9MWFM0dlNOMW5GK09BL3FqK2FN?=
 =?utf-8?B?eTZzRllURCtmdGtrNjUvaVY2bUh5TExXUGZkY0ZMNUVDWG5KQXdwUnFnT0Jr?=
 =?utf-8?B?OWpDSVBrREE4dVBxWTRybjFyQ3d6K05XQ1EvL1l6aEhFZUdqSHVMT1MxbVBa?=
 =?utf-8?B?UVRHMi93TExBOXFQUUxWeERVYUdPSVpmTlBjS0FtQnc0cDE0K24wWER3bmdl?=
 =?utf-8?B?SThVeHhrRE9XYUNwL2VyRi9OeDJNS3NuNFJ1cDU3bjc4RjZZQ3BrM1R3VlYw?=
 =?utf-8?B?bXZGcTJacVFqOTNSbFl4cnZRMFhPRGNTNDBIOURER285ZmlvWVBIbEF3cjI5?=
 =?utf-8?B?RTYvR1AyTC9jd2hYaGhkRCtUVStkZHlxRHNlVHJIbFA4QnVCY1dKdmR1bEtw?=
 =?utf-8?B?U3dVNHBSRTZucHpuV0ZkdjdKenFmejB1WnF3OTAzU0xvMDJkd3JybitNWFNk?=
 =?utf-8?B?ZFBmK0l6Z2k5eXVtVWh1K3M4cTJOQzlRcXAyTTFXUDBHQ3NxQkNLQTRRaGti?=
 =?utf-8?B?eVByN0pVWHVsUlBGWHB0aTNmdjhZdFhoOEhtcXViQ09kdm1xZXh5bk5MQ0VY?=
 =?utf-8?B?Nng0RkJXc2RBckFUMVVOUVpRak1sc3VyblYySXYwMUhqUTNvSDFoMFZRQXRo?=
 =?utf-8?B?STVXd09EcytJZ1gvTWV6Z1AwdFROOXllcFdYV0YxNDFVNDd0MU8rYzhkUC9s?=
 =?utf-8?B?UGliNTVwbWFiY3RHM29vV0Y3T29yeFJMeWcyNGN0bHhNY2VPdWwvOHdiM09L?=
 =?utf-8?B?dG0rK3hlRVMxeTd0aCs1bkZIVU5rb0lhLzBhQVN0U3M1QzFIYjFvVUM3Ykxt?=
 =?utf-8?B?L1RiVXNmTDI3M0EzZ1o0b011WjNYaFAxdGI0S0hyVUVKM0htalQ0TmtBWldY?=
 =?utf-8?B?U2JzOGcxY1ByQWczY2FqWUNmYk5BNDFYN1M1c3BMNm94aTFQaityM2hwRTVh?=
 =?utf-8?B?NjhVNk5mUVBOZGp3d0xJK1N3and2SFZ0SFdSWGFaOUZoTzgxMzJUQVJ4Z2Ir?=
 =?utf-8?B?NWJOU0oxN1FTWDZoa0ROaXp4ZzFoa3cvR2hCVEtPMFVWQjNabHRqa2dMb0tD?=
 =?utf-8?B?TFZGYWI5QWxlVFpSS0ZhMWpra3Ntd0hVWFVjZFZ4UTRjbjhGeFJvaW9Vb2Nv?=
 =?utf-8?B?cit1Rmh1U25ydEljbStBdXpXN1hvWFFhNkZDc25TZEVWL0FpdGpjSGlhWnBK?=
 =?utf-8?B?clIvd2Z5eTlLajJuTEp3ZDhnL2hqMlQ0ZEJ6cVJnSGZOYS9tL3J2aklWaXFY?=
 =?utf-8?B?alFPZUlHc0NUelhlZDJZRTdNcUN0eklPc1p0YnBVbitYVVNWS0lITHZzRSsx?=
 =?utf-8?B?S2poM2J5N2lab0x4bks5YW5tdy9Qb0hkR1JzVEtqTGV4aXZ1OGg5Zzd2aFFt?=
 =?utf-8?B?bytKMzQzK0pJeURFSGtndVQ1Tnl6di9lY1FEdTNYQW9TUWVmTHdYQUhWSnlP?=
 =?utf-8?B?ZnlxNko5aUt3STRwb3lkeC9vdjRwc0FjVTBMZ1RCdmg3M0JLSnd3ZktHZ2F3?=
 =?utf-8?B?cFQ1Y2sxSDFYaFdiL1RsM3VyY0xYelBZNEExOENGSHVvUExZclZ2UFhXemVj?=
 =?utf-8?B?R3ZBQXIzUDdvOWQzK0ZsdTU5NkVTbE1aa1c0cXRBVE9ScWJPVVNid1FRQmtr?=
 =?utf-8?B?b3dkMXJOYmlCbnpRc2lPQk9KTzk3UnF2dXBjNGJWOUtWUHZEeGhIZzR2bitG?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TkroD2Nr3B93edWOjcaLBzO2QtLEm6yabP/gz5Dz3HlGsW2iFAUMRR1tPggnd3SG2JeLOz8BWykVDk9lE+Qrynj1aTraB6e6ziwG4BhCTmyFU2ZLuAd68L/hC57QxBcXPoevLqxApT7TLbg820tkzO3E93wrycZqgQYxKPhjFMs5tZFZyqjHEiw0d1FOGpBWwjLpHH65DCj8A29PnUe2zM++D8L6gAOOM8LVoxqC/yNvkGYOO/U7rxAr38mCxY52daW0/chTl9BS7hSuYfFVQ+z+rkHjFUZYnY+buf5fFLf9SoIToBReD+oFVcsnVzq05AdI8JdS1tq8wqanjxLRl0Sv9kFFTxiC9lCArDauqGKX6rS3ike96UpQ5EFjNf+zKeUzYvx9xGXnssjyYSo+HxxmYezOxKJk4WpW0FTtrzraAWX/9odx4UTlx6LgfLMRsdrZFluvAhObLVxKk57ipQSPDY4PRLw/xGfbCuGHBGrRcwRZkgcp2PW9Xx4eLq3Ti/u7WxxqUAypwYmBx6V2MFD1dKrzH7KJ4kQauzG1s1FeucUYOPXG6xpa5Mj4kDvaxMBSywI8KIBX7bOxHCOVZeNaD11DbhBL6FAmXWhqertu9H0ZywbHvKxS0vYGKSAk3S+kq7DOfx5CJgyZLUUhVV7CjbpLQHVa5xu9BhiaGtFE1pJ3uiG/goq5FkgN1OiCMI7LfqfXnFYki9+7FbsBUpEyqwSZ0LH1BZcMBYtPXImGpSK+QpZOiuPpxDtBPg8B/ywYQTfR6hskU+G9WFieNaCNKwZXTGgAHMgISfJDG2zjgNLi4BiONVi46fi+lJV6GS4v91faI9McGlMfQ/5udnoLvCPYasMpqP4LWU0pDI0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 764351da-3157-4d14-5a2a-08db5b76c8c6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 10:16:33.9614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hhvp1lrUZqxVKyZl6OOEMHWkytdSriVnlGXIms2U+wQl8XASiDTCmhyqvXpDnv5WDZDq/gQp4YxluEkYzekijA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6861
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_06,2023-05-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230083
X-Proofpoint-GUID: RnX9q7ZcJzAmDpz7rEmnvoelq7CBstET
X-Proofpoint-ORIG-GUID: RnX9q7ZcJzAmDpz7rEmnvoelq7CBstET
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 23/05/2023 16:13, Christoph Hellwig wrote:
> Split all the conditionals for the fsverity calls in end_page_read into
> a btrfs_verify_page helper to keep the code readable and make additional
> refacoring easier.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/extent_io.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
> index c1b0ca94be34e1..fc48888742debd 100644
> --- a/fs/btrfs/extent_io.c
> +++ b/fs/btrfs/extent_io.c
> @@ -481,6 +481,15 @@ void extent_clear_unlock_delalloc(struct btrfs_inode *inode, u64 start, u64 end,
>   			       start, end, page_ops, NULL);
>   }
>   
> +static int btrfs_verify_page(struct page *page, u64 start)

  Did you consider making it an inline function?

Thanks, Anand

> +{
> +	if (!fsverity_active(page->mapping->host) ||
> +	    PageError(page) || PageUptodate(page) ||
> +	    start >= i_size_read(page->mapping->host))
> +		return true;
> +	return fsverity_verify_page(page);
> +}
> +
>   static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
>   {
>   	struct btrfs_fs_info *fs_info = btrfs_sb(page->mapping->host->i_sb);
> @@ -489,11 +498,7 @@ static void end_page_read(struct page *page, bool uptodate, u64 start, u32 len)
>   	       start + len <= page_offset(page) + PAGE_SIZE);
>   
>   	if (uptodate) {
> -		if (fsverity_active(page->mapping->host) &&
> -		    !PageError(page) &&
> -		    !PageUptodate(page) &&
> -		    start < i_size_read(page->mapping->host) &&
> -		    !fsverity_verify_page(page)) {
> +		if (!btrfs_verify_page(page, start)) {
>   			btrfs_page_set_error(fs_info, page, start, len);
>   		} else {
>   			btrfs_page_set_uptodate(fs_info, page, start, len);

