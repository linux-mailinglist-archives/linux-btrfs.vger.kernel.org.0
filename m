Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117B978262D
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Aug 2023 11:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbjHUJZV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Aug 2023 05:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjHUJZV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Aug 2023 05:25:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45164C4;
        Mon, 21 Aug 2023 02:25:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37KMaSJm023930;
        Mon, 21 Aug 2023 09:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=h9ZiX0BmINo58RBOXM8GZpfUaG4vBo5etpVwFwh7k/qCz+LOAXCLK4IQI0tTWvDquKYx
 WrM2zh7SHUnrXn+uuP35Q0Q5TlTVSevr6QrKFH6I7Ib0Vx76+vmjg8UPZlDwXjSqYy7D
 ticY/8/bcQU6Jpad3GP7ye9gmDG5qGmIrnluwpabQrzRdcTm5tKJ+ewrlNUM2h15lndU
 7Eus1L+f2AnCyr2kIJm6Xhyvv2cr4xIgJNFyAdKdqe4dASVFQGvhyshe5MXmAVmnTJZy
 cRu93mWVkIKIotg/hOcj8o+2Er8BMNH096Gu95w8I1S+KSGM+coi0RerComC7FWjpgoG yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjp9uad4x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 09:25:18 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37L8fwrX029816;
        Mon, 21 Aug 2023 09:25:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm69q6hq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 09:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ga41JtGNs/9Mg8sWNOhWTvf8Dp6lJf/MI4ODeayivoy+EgH6C8KFRd2Hy1NrSs53JzPH6nvGSh19ruNlSeBmT3JEoiHiqndhy7ie5L2uy96cH5pGEGzFNaQ4GmuzOYOFXZTWz457yNpne8HVIVN4H/HeoqtvqYUZaI4IWWW8KzTPivZFci576UsgEjPUBRlci0Te3wIdUbYfpo/G6Q3kNBTYjdYuRBryayU/PsC/MDEx5le0EJur8NY/6PKFN6Oah5R6FZgS289c+Fo8X6s65+OqPGVM2VK18yEjijWY1WXXM2Bb8CYrSSJbPyN9Aw0/Ymc+K/qJIOM9J0EBkJEpOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=ebMdh71oxHVtEJC25i89dzChSAk7BOw6QcGz/52E4N+bG1pHW6pBe+VJx4ZsfdD6knVnqtQwx22dVHtfKc+BCx8jupf+Wrqu5hLL1N+1zgSFInEqa/TnqErS/3G1dD3WUgmRtd+v3GpYniLLYGusj5U/JCXvuOZYSgmMOZbErrz5YBgrLHFjssdU9/WeWAJYKVZQHcqKZi0YeDtUM0vuyfiZC6fTKwXr7si4OsqcHSaSAeYewavTJ1Wi1zPakN3nD3MLEg5LK8kGDMv8FzBVsN1mSJPZTNLzPelufNKsz9L+oROlGN7+jETwFBBLwhRHU1OZgOoXX71DDtP0IQn5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=Am/bbeW3RwDLe10qFTzHJddNkSNkT6dCM/EbASEEnFSrFKjjKSE7AuBre4o1kL8xYSs6IqYVkacQWYbUWbGWk6vZ+GCD1j4WQ4+IKzJ94bqdJd5oRuKZwyr5ideIXFCBEKihgSYyVDfU1vlFeSrqg+jmbMGkfCdE+JSbyL5T1f4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5070.namprd10.prod.outlook.com (2603:10b6:5:3a7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 09:25:03 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 09:25:03 +0000
Message-ID: <07d8e590-c016-9698-c5e7-dd090a6909f4@oracle.com>
Date:   Mon, 21 Aug 2023 17:24:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/3] common/rc: introduce _random_file() helper
To:     Naohiro Aota <naohiro.aota@wdc.com>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1692600259.git.naohiro.aota@wdc.com>
 <63147107b1aee89c21ef848857e0dc3964134392.1692600259.git.naohiro.aota@wdc.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <63147107b1aee89c21ef848857e0dc3964134392.1692600259.git.naohiro.aota@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: efa02796-c9f5-4bdc-f600-08dba2287fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JnJx+ncYwkXcBLqIDuaPI/NhtrZQHO4tG18yi9Q9RlHcfYMZ14cbraubeI/V0JtyYbv/wbWNmBWe0NCs4/+SCKBMqfjoOS5XOiud4YpOrTi/QrNue7B8ti3pzZRP9OU9ACVylMRp8HrWMuVcC+bxASu5UnPxXQjTi6ZBh0wKIoqAzLNs6vaZOGXo2+ebrQEyisambqcIM0fKYc5ZmA56wseHGjki/YgpJTxchmoT4AgKgb88ynYsAfY/V+NSiH+9oQ3jY7KOv4ZElNgc/oVkJm8Sg5rxsrrJh14F9pPUdA8ulr9TIZ4AjDptu1USdExzh1zr1N5QfIyCnBuYqXLPu9c1z6v+t5pE6s8im5EjHSH7t4BUkwTxsuwITiedacszTk2/xoIo89i/dB6ezsaYCw8+d61zFLPvyy6hNCXDIHBpePheTINqLTvRCzmK6tLIxjVX81f5x6samDgBBi+OeocdIjTdZBr3pZB43Sqh0DzMplTyKToWpVFkbtfHzaIPegB0hdgBshoDc7s7AV48TqOy6VH49MrnjxpqDhlrGgVtBEeaiaurHre06HrO8/11QqPegMCJH0tMY2jW3XPTegGEbhn19WJ3DvznS98f+HtjgDz2gv9Lk6sFEJZlhq+ieLmfD5C9yWt4Dvpkyk4xOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(2906002)(38100700002)(6506007)(6486002)(558084003)(5660300002)(44832011)(4270600006)(26005)(86362001)(31686004)(31696002)(19618925003)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(66556008)(66476007)(478600001)(6666004)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2FZQ2hLUkV5b2RYL01pVmJhVllYMzlmajEzVjFtVytZYjdOZXVaOVZZWmRk?=
 =?utf-8?B?ektZcWZQZ2tPZ1N5U21ONFcxRzBFQmNkZ3RvUVdaTUlITWt6ZjVJd2ZHZUsr?=
 =?utf-8?B?RmVsNE55K3NDalFSbzBleFVycmw5TXljNS9uNnhmekVmbG9uZ3RKbTVhR0Na?=
 =?utf-8?B?ZlYxUHFMMU0vVlc4OGtlemVqaWQybjdCbmRTT2FFMllVOCtCMmNNaWc1M09i?=
 =?utf-8?B?cWxwbjVueG1kMmRTZjJDUk0zMXMxWlFYZ3djWVdyRGtRak5DYVpranpBWWRN?=
 =?utf-8?B?enlYQ1NMY2p0WWhPc29tSkVIODhEODZmTnBNYURKVjQya3AyVHJld0tBWHcr?=
 =?utf-8?B?dGtJOEhqYi8vcDlKVmhwRXFXSWlzS2NicHkvUXRsWTlrelZic21xUUNuY2gv?=
 =?utf-8?B?SzRoMHVkWUtQNXltU0VJc3NvWEMzUEhOOU5EdjB4WHdOUVpFZm5ZZmFENVVk?=
 =?utf-8?B?QmdLSmtzU2s2TnNLc0hDZmRCSy9aTjdlOFZ5ODVESXlmcCt3QkxTWVk0eG5Y?=
 =?utf-8?B?L0JBakZBTU1LeDhBYk52d1B4dE5LSExlVTN4NGxVY0QwbitwQnYyd1dRc09L?=
 =?utf-8?B?NXFDSXJkeWpFL3ZBd3ltY21taklPVmNsc1JaWXhtcXpoSVpnUkdhVFZEdkRt?=
 =?utf-8?B?Qi84Y2hMVG0yUi9TRkZxajNLZHpqV2ZsTWJiMmYxUDJHYW1VaWR1U2RKRmZh?=
 =?utf-8?B?WUN2MUp2UTdmM1F0Z1JzUjVmRWdHMlBWajluODRMbkE0MGJJbVZPMG9ySkVC?=
 =?utf-8?B?MHhLOWU1Y3pLcERScm1hSnlpSzdFWlBRMW9ncW9ZcjV4Qnl0ODc5dE9ZSHMy?=
 =?utf-8?B?MjhJcnlSUFVHMEdsY3MwQlUrUmZuNXJMT0ZhSnVtSmtOb1ExOEZQWFkyRE4w?=
 =?utf-8?B?YUduUzVxM2ttc0FIalVnRUVFYWRKa1hnU2dqdk1nanFVWmcvOHQxbEVsbW5U?=
 =?utf-8?B?bEFEb0xXK2J4ZGVqeTd3THMrZzRMMVBDUEZkYmN3ZTNJNDhmUkordnlhRDJV?=
 =?utf-8?B?SEVSQks4S0UvT0JCVklNMkQ2bGk2RlhWRHpMTnRmR0NqNEFld2hKRGc4cWVS?=
 =?utf-8?B?Y0VURVZUTmZNcTZkOTFjVVZpcXB0aGV4cWFpNGcvZTBGVllFNzc0YzhtcXFL?=
 =?utf-8?B?R2FsekoxUnVpeW9wVVQ5dmRYQkVzM2duVDZ1MDIyMGpNUjk2bUtuYkFmTzVa?=
 =?utf-8?B?c3h5R2JDUUpRS0lBdWRPMmF4RVlQNVBTRWJEOHN5QnFlVDRDMFc2YTRSNXZq?=
 =?utf-8?B?TTk0ckRxVHZZUDZsdVkySEM5RkxVeUY0azNmRXNRWmtRUkhNeDRyMHJHbHZm?=
 =?utf-8?B?K29uaHVwME5zTkFWK1JrVkhXYkFIeUVDcjU5bEdiTFJ0bUhYdUZkcXIvZm9m?=
 =?utf-8?B?OW1OQmZXRk1kcUlIN0xjZ0ZzYlo2RDREb0Z4dExoZnhJclNBWTN3WEVUTzQ5?=
 =?utf-8?B?TmNrN1RuM1dDRHRRZlBBRFpVMjF5cDJXUStqcVB4b1QwWDRqeHZCWkJiVGZ5?=
 =?utf-8?B?Tmdrdjd4NWp0Z3dPcys3Ykxpc2V0WjZBazllSkpUVHpkY002SDZFZTdvN0Vn?=
 =?utf-8?B?aWxETlZhellQM2J5dzI1cloyMnMvcEh3VmM4bVl2REF2R05YSzhnbTB0WHVi?=
 =?utf-8?B?WUx1czN1Zm96UFc2aUVZV21tTkVLMFJFMENGM3lUNFo2b1JnYzVtQjBKM1Q4?=
 =?utf-8?B?UTZPbzdGUTRiSXdiOVhsLy9OYnArYnZpdEVGdEdTWXdFSWNKSWNmQW5iK2tM?=
 =?utf-8?B?MHpzVXA3SEpldlRYeE1UcHZPWTlSTk1ra3I1SE1icm5QbGM2ZVJ5Mk9JSjhn?=
 =?utf-8?B?QmtHL1VZZU9aU09YNWVaT3ZxYk0zSWtFMEY2MEFFNURXbjQzODVRcUFLaDBM?=
 =?utf-8?B?MHdNSkxsY3VPZktXa25TZkgrY01FQ3hqZDdoYXoxc0lwbDVMdWpGeEVFZGtt?=
 =?utf-8?B?TDZrVlp1V01XVVV4dGsySEJwWVlsN0dwbjdWOVh2dXZKYjB4c2RYYjFkMUto?=
 =?utf-8?B?WmZiQkJMM1pGR1B4RlRPbmtkRlFxNUpZVm8vSUszd0JHaktjcHJzaWNXK0xt?=
 =?utf-8?B?cnFmWENFSGtBUWNMcGNEVjhVNS9IZkJtWVJ6U1h1RG1KdDJERXZjMElJRWlI?=
 =?utf-8?B?SkJaN1N6ZzFRZzE1azZoZGoyempNYTlIb2RrRjJhenljSzVDdWFMR2pyaFdi?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: lF5ZoofUuy5n/hj3GFSyFJJ+/i8VSQMKAWPw4MX7rsP/rlrg7rXqlWt7kFUKbRbJNTaM+n6jq08nQN+In46KY4Un6NuIWV9NHO5iOKW66tkcnFJzM79/AWAIqKFyaCgjMc7jVL06VpIPOoPVwp8er9ivLZ2FW36u5RJxttrkH5w6OCwnwh2G0pwZ40pxln4UqYGgdi13peoDXdclFHJUa9bgH+Yniz8OnvPeEuGk4VVFD269FWuGr1eXRUe4OiMr5Yd0fDgGbyVFGtiyLqO/FuTTuYKU2eR24nl7mK8EmmoEW9Bz/Z2qxCFGh+JMnpGdaxFKvjXGwjqvj4Fb6PTsCMXi3nvHs+gz7OI/e7a61EOBt4yQ0ywrR0cXcHIEYM+KSInDpjRmXGns4lUdCRuWgdjwCgsKSDmhuQefb2SWVQafCcadJUqsu4OEzYEfpFa87+dVspB7E0vhnONy4yjuWSos3E9oKb8Ok5f6u/QjP9eX/lfqIBzM/NiCFOXxDH0QHsWgtvHVJyuNpvY14bLnC4LMsQrqLBXWXUrodU6Ak+Jj2T8f+2bgCEQlzFhYQ2niG9X3OflWWpGVe4PxLPEekDMtDQgWijsZB8U/8RBe+0HwwjUUWCTYHm71mTptQ6Qa+0ZnYpiaf+ZbNoS7aHfteTgaxN88eGNPPSAdWbAdzaNQ915QobngJ/fuFGOjrcQc6qXkmM7Ek22kYyTWzHsLm3zI+3nP4V0lm8sp9M/c1bclKkoTMz9b0Q0kprdJW/HdrL16xr6ibJ42XCP48TxHW3tjYiJA1wr91u5DZADvQlg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efa02796-c9f5-4bdc-f600-08dba2287fcc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 09:25:03.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKdZLjEq55LT7+gGQ4roGH89yEbDx/lH+EMNQUB638LzqTdKaXDPMbisMuLw1SyVQMBe3Lc0Ux3nD0Jxpbc0Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5070
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210085
X-Proofpoint-ORIG-GUID: bRfFXFZj0x4x6XtxtLbrBidCpjPRW4rd
X-Proofpoint-GUID: bRfFXFZj0x4x6XtxtLbrBidCpjPRW4rd
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
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
