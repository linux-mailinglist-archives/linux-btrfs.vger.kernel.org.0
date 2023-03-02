Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9691E6A7D5D
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 10:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCBJMw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 04:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCBJMv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 04:12:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B002BEE1
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 01:12:49 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3228MVTZ017872;
        Thu, 2 Mar 2023 09:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=+ahO1AC7oS3DD/nX4lXrJT1Od3wGHvtAhpCSOqCHPGY=;
 b=iuibgASQ/hj/kTchLTcmAYARjTMqiRHu9/4pdZVHO2VTT63k3foYaZvqtwX9XmDQmUBg
 tURhXVnfNKtXxQpR1Uy2qGxHe8bcSp/5vSifG032T/5ZhSwHu9P1wdqbfEWL57PN/8FM
 fEOyMOuPeS87h7o7iyX4WAWs3ixFinj52kOX48CbP6Plp0sqQXMquXWU/DYbe0cju50Y
 +YiEYSPXzkqhXWzvH0qXTlsM4NAgdYIiv2KQ2jQyWxHw2lntgoIQSoE69tCVpjlVfhxZ
 vDXFwT/lgyXHJa9Reg/IQ6nLNIVQpDSllgEekZvwV6IpPc9boEvY+5DST5ZQq9AjF9Du 6g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nybb2kar5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 09:12:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32290kM0015940;
        Thu, 2 Mar 2023 09:12:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2171.outbound.protection.outlook.com [104.47.73.171])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8sa2wht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Mar 2023 09:12:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtPbuzyJII23Q13vzi8v3hqmmWuStMUh/dD9y3crww21rwMzEFaz+DYAiqderbHvipKkItaHeqBxIBUsNJP9mSfsXADHBuVhZM0DueDelj8PZydpgOUiUO9xkxvTXjxR0GkYKxq9yV7wl0coc/wB4fSXK+hFm/LaA8k59waGPIuwA8Llx56KmERbxJxeyaGcGyWFWh+LlcaJ8FBDEwB5ZRWABurdmIDQmOicgQtJwtsn85c9dCFI5kHanvcd5o15Jy9jL3LAbEoUtEXFzlJlpmS6wY59nC2yBQEYCPdyrHEPPwtjtYB+pF8CZlgS+/bUcSsHFZS5zxVpYf364cK3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ahO1AC7oS3DD/nX4lXrJT1Od3wGHvtAhpCSOqCHPGY=;
 b=jY/oMdXX1ieyCozwT3a9OSKedBR8qFEyQ+FqKMFaknaxTA5iYfymZTlnkdyx+fsBD/QRetlYzEbQAC/dUMolrJ7NDbfWb5mvteQQ00Jfzl0eYiVWQdZaP5WENykKB6EvLcQGfS+r61uhifxff1A6GT6gYKqolFStHEEcLcX4qC5sX4MkCIpO7M8UXaVNMf1kkZWMZ2nryKCAuPxILpGRO19LhQ5KvVxzMTbcMG9EpEx8PmBpvgT8POILyD32vM5OuEPP8epnvyQTs1SLfhw13WLQgxwqm7OM8T0iGsTKcfgYetdOF2MSP8+qCwNyPLBXiWbU/wkd2a4pNVTjgAB1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ahO1AC7oS3DD/nX4lXrJT1Od3wGHvtAhpCSOqCHPGY=;
 b=RXV0nr3Iv3Iqiv2nNqNTmpjCZ50x3EMJmrtLGhQ0+SmeZ3OjpE2VvfhgkqcblPOCHi1jpCqJlMC3xStNSkFyANj0/bp/H4oVWseTVnN2g44G+eik9YVE/zu0/O1loedJvjEHlYA7r765ybdq2zrtJfPXRACQlQWhTq3HiWJTVoc=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6249.namprd10.prod.outlook.com (2603:10b6:510:213::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 09:12:35 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::3eb1:c999:6a64:205c%5]) with mapi id 15.20.6156.017; Thu, 2 Mar 2023
 09:12:35 +0000
Message-ID: <94cf49d0-fa2d-cc2c-240e-222706d69eb3@oracle.com>
Date:   Thu, 2 Mar 2023 17:12:27 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
To:     Sergei Trofimovich <slyich@gmail.com>, linux-btrfs@vger.kernel.org
Cc:     David Sterba <dsterba@suse.com>, Boris Burkov <boris@bur.io>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>
References: <Y/+n1wS/4XAH7X1p@nz>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <Y/+n1wS/4XAH7X1p@nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0077.apcprd02.prod.outlook.com
 (2603:1096:4:90::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 5aeeaa7f-274c-45fb-5c93-08db1afe4339
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cRbof3knQJj0nE8q+7pIv9QusViz7qW+gRfD/y1OQmOovLfe75b/Bq4DivInjJIJK37rAefaegdwRI6mbxawZ4ktV55GfvkuKfpjsr7oAClOQpo6y8NLlHnoUoakdobit+AfuvFTtRfgs5r+gkMVYXxdoK2czND+8pD+jdpq8jHA8kWkFWM1dQYwl6FDy0og7ZqetPahvVTwxvnNLfxhEZnaTHDS7UgJ9YQYdoU7O/DLBI/Pev/PFBO27VXyX7qMhw6p5KTGv3DST8GotyZIAvXRWtXVCn68SShWOdPGBCxQIZfAtbd+zHBbsDVlfoe4VmvkpFGUPceWr43ewIlZWk+m+EN+oa8WhzHcKBnl3YSAktBLJNovdgLn9o2uhQyVQ1QjSEPwph+yRBBgqKHCxKZ62To5GNfJV4G+eRdwHcqnyLe0SBFX+3sr/uFzP+a5nFThgjWYSzsB58dyH/iSRmbOhUeXbNREjfuW/Rj8krKLpiF5sNk4LFiV+O7wQas+l0jbqjcCfgKCrYI+G4MpUew7jHoo+KbwldlKkUNeUdSv8X5qk80Z0qzyT5j/36QfCUMcrQnVaue+0ibcJg4AIOFazrGeFXAl0cbfwRz+LqNiQBxLmHtsAbF8xr6fcq6EUaLvL/tiJqdi9ODNtDQNWshnPYq58Ez7dCvqBNDpYnmOrmBaZpJSVE8iB0pfFB/xkd7xpfoxuFHXdL5YuXTLuaf13z64jmNs4k6jH7TsKF8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(39860400002)(366004)(396003)(346002)(136003)(451199018)(41300700001)(40140700001)(316002)(54906003)(36756003)(4326008)(66476007)(66556008)(66946007)(8676002)(2616005)(2906002)(38100700002)(6666004)(53546011)(26005)(6512007)(6506007)(83380400001)(478600001)(6486002)(966005)(186003)(86362001)(31696002)(31686004)(44832011)(5660300002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHFDa21meU45Y0YwZjNQZmJQVEVvbE9OMmw1T3B6QVc1bmpGcnh1bGFtbk04?=
 =?utf-8?B?U3dLOEtBRVRJSGtpMk1yZUlHTkk0a1QzVVhLYzNVdVVQZjJMWnpJV0hyWmY0?=
 =?utf-8?B?bXJXKytPaXltTHJuWHovcTVGbmxQWkdnaFpESi9wOTlPQ0V2MkRwZHhmbzNu?=
 =?utf-8?B?UmIvb1lXZWxycDVqYjlIK2lyVi8weURHSDV5SUY3d2lCY0pNaWVZNGhsQ1VL?=
 =?utf-8?B?dVprNzNnYVB6MmZsNUxOTnVYak10b3FpUmZSc0dDaGd0WTBrWGZCRktaLzhL?=
 =?utf-8?B?NEtrb08zNmFKczBXMU0xZHJ6bkVHYVUxb3Y2Y1U4UzFXNXFUdVovZlZmNjZi?=
 =?utf-8?B?VVRRdHBHa2FKZ3dnMlV4NVQvM0EyY3l2S2pyek9DajYvSGQwL2J0VVJmZGFZ?=
 =?utf-8?B?TzFscWdwSDFub2p2cHYrd3ZmZXpVNi9ET25yWkhOUmFlOEtTeTI4VWJKVGRt?=
 =?utf-8?B?T2haT1JFNm02VS9wVFdVdjdDeUo1ZVpYVUNoRTI1N1lQM3plRGh4Q3ZxeDlh?=
 =?utf-8?B?RHVRRXBpcW12VzV2S2RKVzdIQ3Exd1BqL2VLL3Y4b0NDQ3J2WmFnWG4xc3NW?=
 =?utf-8?B?VVJ2UG5NWURuKzdwTEw0L25aRzJpaXJSVW8rdzJUcXR0SkRqZGgxNkJzK3I4?=
 =?utf-8?B?TW1VM21RZEtqMzYxVjZ5dHgxMnRLczMzdk5RbkF6NXd2dk43eVZ6N0dsdUdy?=
 =?utf-8?B?WDZJQkhHd2ljOE42MmdSbzh2bnpFdkNVWFl6aXh2cG0wTm5iN3p4Q0ZGL01I?=
 =?utf-8?B?VmMrOC9NczRYYnoyRllQMlBmRWpMUDNrTUQwNTRzc0grSUxOQWRHbE9DK1BO?=
 =?utf-8?B?N0xZZXBSZlZyRFFUbzkrU1NmaHdUZWsvQVUxR1A3L2tlV3lrTE12T3ovR0JW?=
 =?utf-8?B?T3FncUdVQkZQUTV0YllFcE1jWklqWnlMMUFxeHNaRmZzZDFNakhkblJZYUQr?=
 =?utf-8?B?WkJwclNwcmFWTTJRMkZkakdYT2l4MEdWRFRFU2tsSjdmQ3h2eG4rVFcvQ3Mv?=
 =?utf-8?B?TTdIWXlZRm9uTkQvcFEzYmI3SDVrWU1kUG4wSWF5V3ozdFVnU1pyZVhKUjZa?=
 =?utf-8?B?RW5yRU9MaHRIb0dqTGJkV0VOT3puVkJwU3NiaFN4ZlhSanllL2tyNEl4YS9q?=
 =?utf-8?B?eThzNkc3K3ZhT01ocnh2bDQrM2pnOStzclBWdUdMM20yRHV4Z1Ivd0V1YWVN?=
 =?utf-8?B?T0NYdWpJQUxmdU1qOGV0VnR3ZkpsWFZYNFljTUtyNTk3dFowaUVYZUdTbXN1?=
 =?utf-8?B?Y3E2VlZYc1pTSS8rM0huSnVGcjZGdFZSbWlVR3NLWEVPYm5kejlJWTdkOU1a?=
 =?utf-8?B?OHVJak5tOUZXUTF0QVRxKzdpZ3VWWitlV2t6RS8yVlAvcjh4L0g0OGFjWEsy?=
 =?utf-8?B?ZjNLQ2tKWmNkSjJ4SE5ERzNKWXZ6eThRMXc2SnJhcGR2dXR2VVNNZHpQY25P?=
 =?utf-8?B?QWlqTjJGd1NiTGRiWTNQSStDM3cydnphRVpFZWhXQXVVVkdaVkk3K2QvMEdQ?=
 =?utf-8?B?ekh3SkRCMGdjcmtFZGs3R2FHbUttS0tBb1NwV0RGak9uL05QR0ZzTmVVTnFp?=
 =?utf-8?B?cTN4ZDBvLzFLUVBwRW5Nd2dDM1Q0VTBFUHc5TVNvSmN3WCtJWVNUc2dGbGdO?=
 =?utf-8?B?UmoxQlFrU05VRkNDa2MvVzVwdVQ0ajFpTC9weTZvNkxZNE9HRjBiUUg0dkdo?=
 =?utf-8?B?dlgxWklWTUxvMzd3RS9HNGl0SzBwY215azgzRmNwbUlrRU01M1lMYXlTdzhy?=
 =?utf-8?B?UVBpYWZEZnc4dHVrMlVrNVZpblMrV0p0RFNMNzBPMGxGTWoza05ZZ1lPdmFE?=
 =?utf-8?B?Sjk1cWwwMFlkbERVZzBNVlJaR1hBczRZWDdURmhqL3R3N0cyR0RxY1FBZFhi?=
 =?utf-8?B?NzZjdzE0QzIxUXZPMFlNZGlnNWk5WFhYOEIxQlJqeWpheDhkaTd5UmVRcm1V?=
 =?utf-8?B?M0VRY1FYdTM0b0w1aEZ5UGY1emYrZjFHUzAyYVJyMXJWTitFZ1FLd0VLYkt5?=
 =?utf-8?B?cFdVZWkwcjhBUFZsVDMzTVlVWUlLZ0tNZGhtMU4zdy8xRzNjeFFHM0l1ZWw2?=
 =?utf-8?B?Ty9WY3dma2xGVFA0NlVpeXBkYTVmTXRtTWowUXBxUy9yTmdKV2NMNWNGWlR5?=
 =?utf-8?Q?msIMZ2BsH5QkSKPzW7v+at+43?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RjUyNFXcPVjt6dEJDXTY5sD4eQbw08kk9/OfoL5SvQ7CrtlCTjnNRya25yB5yLuGOJqk+Lp/x/cyBRxgEnlkb36AxaJyF1h5j6lQ43xwOHyK+i2oltjdMne6GWgUDBa1RWu667osS4Kz6Gldw5oNSesVwII6C5U+Zw9fUx0CYdQrdGaxxQxjysnTcA97SbKLk3D33+XsrN5l1lwlvOZbwalsRzZyEObKss3L+dGK6SVegVHVOYKh3cdsOzC7qMvZPWcaL6HYkIv3f+XOh524tUgBdwhPREhnt82ovRL05vb6QiT387Y7uQplvTUu5cNEHHagJOq6bQB8p3h0vfHEKmWKUky4vDbuB4lxqCQyMwlewZB4IlOcwfg61uu8aSG4Mi0+6W4Qa71TVve/gr154HrLVvNQgwReGClMz8S7uB+jDViyFdfR4SEr72kKJltUTY9K432fD1z7lpMTTGuoVGvXp1580ap3zx6cgBiqd53UD92da4oVD93Isy0mUye3ypQKR67py6QV1WYAc7dRmPDW6GeAJAX2pw6bEAzGplQBA41u+bM/txjjF0zI0LQNqlYrlHO0dvuJWo8XefdYtKP1i3EnWbZMYhjSTVxs+S3VhFKS8ey3+jNq9JON5b9jlLAAK4U/X2hwZ3EEsacdnrGyzrWbpTcjim+9tNW4NKzjKmLWQZTkKhZ2kv8MR3c1s46uUcWJASrR39HCYLh90Y5hbtMnGABiSdvN900BqrcEBwQulrySQ9TaoR1Sfi4Dn5Dc+2Lj1qhWT7JcPcyCrNUH3HNnc2/2Xhsq4z6ILeaLaaurPa7zcpVpNWDFUlBkvF3UCcDRqYjox34wc4uilNe08nxJY+gu6X+rqKl3jgTk2W0d8yNirRBeswdXhrz0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5aeeaa7f-274c-45fb-5c93-08db1afe4339
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 09:12:35.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QzWWrZTa3lp+ZbJdlf3YL8w15iU7MVcUo42INlKgmPo5rj1E5XTa1tthpfwEVGRIYXTFKYmnY9a4wWsGHDVKlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_04,2023-03-02_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303020079
X-Proofpoint-GUID: XeWSJROHNfinrxRk2T6ltx-PPeXYP-sB
X-Proofpoint-ORIG-GUID: XeWSJROHNfinrxRk2T6ltx-PPeXYP-sB
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/2/23 03:30, Sergei Trofimovich wrote:
> Hi btrfs maintainers!
> 
> Tl;DR:
> 
>    After 63a7cb13071842 "btrfs: auto enable discard=async when possible" I
>    see constant DISCARD storm towards my NVME device be it idle or not.
> 
>    No storm: v6.1 and older
>    Has storm: v6.2 and newer
> 
> More words:
> 
> After upgrade from 6.1 to 6.2 I noticed that Disk led on my desktop
> started flashing incessantly regardless of present or absent workload.
> 
> I think I confirmed the storm with `perf`: led flashes align with output
> of:
> 
>      # perf ftrace -a -T 'nvme_setup*' | cat
> 
>      kworker/6:1H-298     [006]   2569.645201: nvme_setup_cmd <-nvme_queue_rq
>      kworker/6:1H-298     [006]   2569.645205: nvme_setup_discard <-nvme_setup_cmd
>      kworker/6:1H-298     [006]   2569.749198: nvme_setup_cmd <-nvme_queue_rq
>      kworker/6:1H-298     [006]   2569.749202: nvme_setup_discard <-nvme_setup_cmd
>      kworker/6:1H-298     [006]   2569.853204: nvme_setup_cmd <-nvme_queue_rq
>      kworker/6:1H-298     [006]   2569.853209: nvme_setup_discard <-nvme_setup_cmd
>      kworker/6:1H-298     [006]   2569.958198: nvme_setup_cmd <-nvme_queue_rq
>      kworker/6:1H-298     [006]   2569.958202: nvme_setup_discard <-nvme_setup_cmd
> 
> `iotop` shows no read/write IO at all (expected).
> 
> I was able to bisect it down to this commit:
> 
>    $ git bisect good
>    63a7cb13071842966c1ce931edacbc23573aada5 is the first bad commit
>    commit 63a7cb13071842966c1ce931edacbc23573aada5
>    Author: David Sterba <dsterba@suse.com>
>    Date:   Tue Jul 26 20:54:10 2022 +0200
> 
>      btrfs: auto enable discard=async when possible
> 
>      There's a request to automatically enable async discard for capable
>      devices. We can do that, the async mode is designed to wait for larger
>      freed extents and is not intrusive, with limits to iops, kbps or latency.
> 
>      The status and tunables will be exported in /sys/fs/btrfs/FSID/discard .
> 
>      The automatic selection is done if there's at least one discard capable
>      device in the filesystem (not capable devices are skipped). Mounting
>      with any other discard option will honor that option, notably mounting
>      with nodiscard will keep it disabled.
> 
>      Link: https://lore.kernel.org/linux-btrfs/CAEg-Je_b1YtdsCR0zS5XZ_SbvJgN70ezwvRwLiCZgDGLbeMB=w@mail.gmail.com/
>      Reviewed-by: Boris Burkov <boris@bur.io>
>      Signed-off-by: David Sterba <dsterba@suse.com>
> 
>     fs/btrfs/ctree.h   |  1 +
>     fs/btrfs/disk-io.c | 14 ++++++++++++++
>     fs/btrfs/super.c   |  2 ++
>     fs/btrfs/volumes.c |  3 +++
>     fs/btrfs/volumes.h |  2 ++
>     5 files changed, 22 insertions(+)
> 
> Is this storm a known issue? I did not dig too much into the patch. But
> glancing at it this bit looks slightly off:
> 
>      +       if (bdev_max_discard_sectors(bdev))
>      +               fs_devices->discardable = true;
> 
> Is it expected that there is no `= false` assignment?
> 
> This is the list of `btrfs` filesystems I have:
> 
>    $ cat /proc/mounts | fgrep btrfs
>    /dev/nvme0n1p3 / btrfs rw,noatime,compress=zstd:3,ssd,space_cache,subvolid=848,subvol=/nixos 0 0
>    /dev/sda3 /mnt/archive btrfs rw,noatime,compress=zstd:3,space_cache,subvolid=5,subvol=/ 0 0
>    # skipped bind mounts
> 



> The device is:
> 
>    $ lspci | fgrep -i Solid
>    01:00.0 Non-Volatile memory controller: ADATA Technology Co., Ltd. XPG SX8200 Pro PCIe Gen3x4 M.2 2280 Solid State Drive (rev 03)


  It is a SSD device with NVME interface, that needs regular discard.
  Why not try tune io intensity using

  /sys/fs/btrfs/<uuid>/discard

  options?

  Maybe not all discardable sectors are not issued at once. It is a good
  idea to try with a fresh mkfs (which runs discard at mkfs) to see if
  discard is being issued even if there are no fs activities.

Thanks, Anand




