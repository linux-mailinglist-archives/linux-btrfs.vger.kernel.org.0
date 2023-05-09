Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23896FBCA1
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 May 2023 03:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjEIBtD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 8 May 2023 21:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjEIBtC (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 8 May 2023 21:49:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 097C259DF
        for <linux-btrfs@vger.kernel.org>; Mon,  8 May 2023 18:49:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348Nx7ER016440;
        Tue, 9 May 2023 01:48:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=QcMwRR3nXVfAH7mNvWr6FEwWqczeaGKtNdW0W0UMGl78osEoVKt2Z3vivK9Aslpn0laU
 Lwk79esi6CUbkg3mf1xEqZqbNwf9GTJNt5Npm21ub9wVs+d1fR9+M/KMM+VpcsEjGg3C
 4S8ZaqRnfNIE7Hyxdz4Y+WnqSPuQYhDYGa63djl+dgaZuDiWoinXgeDYmvhis8xFQzoV
 O20ZpRyyRpSwnKupmbDqF4Gogx4qWzvfWeeXOSyez/Tg7/z1PfTLtNMcIDdBecgb8REx
 5TSbSnufi+4pmH766wB/doZe+HgL1A0v7KOEc/GcXx+3o0p8J4mpluO4527hQOz2fnZw qQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf776gjm7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 01:48:59 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 348Ms1Fk020079;
        Tue, 9 May 2023 01:48:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81004k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 01:48:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWM71bAyNMVTreBykEox0AwAm30qhbI43vTySyMfnNzhGCgfP561A+TsAPLjd049QErSc7ov0r3xLdVenEqOxvWukjk2k5JwVKCwbaUpFTL3JJihJUWFu8bb6/9FM+5ewGjuzK6hiIyfRoaNbkUm/1oUr9wFnmh6cplcq0KAhEfjw4y+D9v+vTZRKTOKG/TbxYGylm7pQD+60S1vxfkxjUo+l2qDOivcYDn20vgx11mtNwuyR5YGxbgUGHuxu68Ox5fo90bBDIV0hAYs++MrX4fwZFLGGxaDUvuJHJY8TftSTPbCUYkfZmBx8HMkxXbH3/CFR1x0A9p+4251usiHDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=itk1QZp0MCJPMrFsnz2HcZis8ZtNQCtQ9g/i4+GcyCcP39n/jl4sWKCNseNSstZGHK7L8WAMeURaGhY6W6vA0DarM99F/qTTldENnr9HdAorMZa8fOyFL93yqEUd2wpH52+gVBcO6rNA4E8/6RT1rges9nCFuN3n/kpL/WYUpAERN+iXSO6EYJLJnEuWbXXjD9KMfEz9iDjLqtG/be+Gxyw4OIUMCvelgG2O8jk6JhqmH/lnBAEJgbJNuLB9EVGPX0wGRwAX8511lIcPfAN/udGqUcWtyRE9jeuK7CRwWaxCuYIrO8ZJnlj1Jdmt4aE1g1YIidm8XMdnWdLPw5NZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuDNgKTQyR1v+e+/h0BO+JE9KoOmKadtfusT3hJpEEk=;
 b=zW2o68bRGug/FLzLYgxqtb1/n1DL7G70L3tRTrGboGlCuDQpihbBHfNtf2eNeI3cWgbeswc73ITUo+IhGCOKh0TXwQRrpxjb5FKUcl1FjX0ekEhL8PilFE1wgWRUtB90XcSu1vzXpyYiWSDuK0vXxHBbrebpQu++Z3OGFUb6EtE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH8PR10MB6576.namprd10.prod.outlook.com (2603:10b6:510:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Tue, 9 May
 2023 01:48:56 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6363.032; Tue, 9 May 2023
 01:48:56 +0000
Message-ID: <8466b344-5abb-44e5-b04f-214391bea223@oracle.com>
Date:   Tue, 9 May 2023 09:48:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] btrfs-progs: tests/convert: add a test case to check
 the csum for the image file
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
References: <cover.1683592875.git.wqu@suse.com>
 <624194cbbce1d068e1e2a409e5d5497eea366875.1683592875.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <624194cbbce1d068e1e2a409e5d5497eea366875.1683592875.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::34)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH8PR10MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 38873606-214e-47a8-bdf7-08db502f8c8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: saCJBGL3V++x96Q0M8yWwNniejUctDF47MLXwnHqHFBDMv/174GOV7J2kuc4JXfSN4PiJYBBywC66ULslZKEiH+j8pkbKLcNpoqCZnOmminiFaBqczFsRUvvsu8McRahMV9F6sq2z7mMmuGXRrYzzu/KwDBiIPo/g4tEca+CchHA7K9zjp3h8VOCKIMbwp0rRPrLmEKnuqSiN7ipjLKJ3MFVZOM/VcdApJZCnoS/UXiEUzIsfhlnczP3rd2HMIivzB1O/kw8efPlkSFwmBGCfBVXnXQ83GbqCwocbryQmzxMDTA+GqAeVoeBIEKuiCeKaur5Ai2wlLvTFlSU2FB50Izw0kdrtBrVePRL9JpDwL7IlHU9wlTP7l6q4OET7mGZAxiNqo3EhOvUQlyyQkLcEeFOUpj6mqSmLfa5oIdmiHblxbU+gLoWjFHURe6qd4Tv199ueLKGSZuPSiS6g4jp43GPD6kuZbPau6jqWKal7b2lgQ07gKURMcPgcUu5TDcC+8igmc6olSTqsWv63BLuHu7holo+kExArNvCTJByOOw/FfrgDrsW9XBUpF3DR2ug1pCseOB/V2VLDc8KU0bQyD0yf6tEJX9BcS9UfOWq38xpX7a6pkhneKyIk78NsHRytppAjJlHsUgprv/jj6a7lw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199021)(31686004)(2906002)(5660300002)(8936002)(478600001)(316002)(66476007)(8676002)(66556008)(41300700001)(4270600006)(6666004)(44832011)(19618925003)(66946007)(6486002)(6512007)(26005)(6506007)(186003)(2616005)(36756003)(558084003)(38100700002)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDdZeEJBU2s2UTNQVkpUQzdnOUJoSS9icXlNQkJGOUF3YTJpRGV3NmZsVEdE?=
 =?utf-8?B?SFZjZ1JIWWQxdlRESVdQMkJhcEtUNlZReklud290SDFhR3E4V3E2TFlNWTNi?=
 =?utf-8?B?Z05jeVAvTEFnY3o0ZkUwM3YwZTErUXhGVHQzKy8wQnZSeU53VytGempycE9C?=
 =?utf-8?B?MVQ3bnZmRlVIK1RyWEZZQkJDMkZ6QnZoZCt4MXg2T2dwZXkvd3UxODlDWDA0?=
 =?utf-8?B?ckptV2JPZmtaTGZVZ3g1amRETnNkNHA0Y25IVCtJQkxxYmlveXpxUWgwaHZk?=
 =?utf-8?B?dUpxUXc1SEd1OFRmVWM0SXdwSVdkNlZmd1JiQmNRdnp3U0ZWVG1hMEdnY2dy?=
 =?utf-8?B?RGZFb0dJcGVBRy9LNFVuQ3QwQThYUW90SWJOTUZnMVpZUjdua3g1SUNWblF0?=
 =?utf-8?B?WTZxSnIxMmJiUkFMc1VRY0cxZ2lHb041Ry84aHk1SUpJNVJxOExkY3RGSTFW?=
 =?utf-8?B?ek1icWswZTJBNjlFT2xVZUFseUZvY1llRmkwcHpPb1NnVUdCamJUM1pJZVVO?=
 =?utf-8?B?clFPK2Z3SFlNMzNkWWdzSTFoenNSdUFCRWVLZmlkdTVtRkt2ek40QUJTTXJ1?=
 =?utf-8?B?R0p3S3RzT3FyTjJNRnMyOTErM3dXc2F4eHpFSXF1TmZwcDljVUM5aTA2MlFL?=
 =?utf-8?B?dGRQSlNFb0tHajRCWFVhUFhzODRoZzh3aHlWRnVMR2djMldKSkpreGQ4cld1?=
 =?utf-8?B?Nkw2T0FGU3lHSUMwTndMMVBYNFZ2bGRHTkxJNkVxUGpRS1diN1J2SG96SC93?=
 =?utf-8?B?V3FZMkQ3aUFjZG5USlZuZ3lZWkt2ZzRLc0xLQ0g0M0VBdzRWdWlzbFVuWGU1?=
 =?utf-8?B?UHJWa0g5NG1lcndmLy8velcwQk1TMUlENWNGUm1XcXNXRU1Md0JVbG0zNnZX?=
 =?utf-8?B?S2dDaXdqdlZXU3lzTEdIMEhMWmUvNjA2K3k5WWIvV2lMSk8rN0d1dVpPSXVt?=
 =?utf-8?B?aitjOG1rMlRRWTlYRWcyajV3aExSalFWV1pyUXJIcjRzNHo0dlFxUlptRXYy?=
 =?utf-8?B?UkQvT1I3aVhrZEVRMnFLaGFpbC8yN0tIclpidExQcm03VzJJbi9QbzAzYW0y?=
 =?utf-8?B?NU5NZDFuRFJBYmpUYzZIcGpNcGlheDFCRGE0K3VWZTNTSVhNNklaL3ZCV0ZD?=
 =?utf-8?B?RlI3L0p5cE93K2kzOGpQU3phSk8xQys5SUxmRElwS21jV3JFZ1dmMmFlUm5y?=
 =?utf-8?B?dWN1cWVrOXZmSjE5Z0dmZkQ1S1ZKYU5iei9PQWR5UHpjcEVFMDBQVnI4ZEtG?=
 =?utf-8?B?UlROb1RUNGJIVnI1ZjVvVXEyZjhYSzJFaEE5R0RPWUJ3K2NwOURRSGJxQURv?=
 =?utf-8?B?Y0hrb1hoK2FUUnhVZlRpcC9rQjdvQllTNTY1S3JEbC9sQXUxRkZNbU5TL2Nu?=
 =?utf-8?B?TFlJTEk1cnpQelhHdjNhREo4RDdLbHd0MlQ1MURZYnYvb244WDZuRzRDVVh3?=
 =?utf-8?B?VTFwNTJQSnZlcXU0ZGM3RlpOYXA2RjlSY2twbVNXdlB6Ry8xVHB2Mlc2MWUw?=
 =?utf-8?B?NXhXdXBhS25ZWVNhei9KbkJXYWFqRE04WFBTeWd5aVExMUd4RGF1dnp3K2Jo?=
 =?utf-8?B?d3FIb29USnZWNjFMTWI3Z3ErTzVYUkdvNVNua3Z1Vmp6SDhlSC9MV2U1YTZP?=
 =?utf-8?B?L0F2VGVZZ0o5VU1ySkR2YjFjdU5wQ3c1ZkQva2FwWnM4WllCb1UzcXhPU0tW?=
 =?utf-8?B?RDE3OFRYdUhuZkVTc25TMDFiZ3RJcm9JWkxXdDFnTmhkK0tXQzlCK2V4TWox?=
 =?utf-8?B?L25FMGtXNm9zS2k4L1hiMy9xTy94WGt4ZTVVWHFzK3RKSXBUNk1pVVpzOVd5?=
 =?utf-8?B?b3pnL1FPdmt2YWUzTklraGgyTHlRMGMycDlmRFRualZ3YXZUdFFyUFNPOUhK?=
 =?utf-8?B?VHY4SEJSQ1VWdkZ1bEVxd3psUUwrRlZMY1MrbnloNDBEaTczd25OMm1PZWZo?=
 =?utf-8?B?SGd6OGgrcVdWVFRTNUdTQnBkZDlURWV2TVh0U2dYOG94NFMxL1dtMXhWMmRJ?=
 =?utf-8?B?YkQwaUxNM0w4MnZUT3JrWGFja29ickxMbDY3cFJOb1RPdWpQZGpJL0d0WFpa?=
 =?utf-8?B?R1dJaUhFZXlMbGxyWXdJUHg4VlRFWW9SV25vQTcrQ0p3UWpUeUZhaUNqaDVt?=
 =?utf-8?Q?LQl0uYpPAU3fe5+ysk8jaevT1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: orBljCzKGSdA6TnJ0sATgpgYmGiTURYJ3umkYOA7CA617SfDLjNVIUq7SyJ2xdmQHmgN04DqWutf3/K+eRAn+B5HSnOTVnTsjjt8eSDobg53HmPtDCrFzxnj0o6yOYyVmb0vuFipki69GmMwo3R1orx/GxfgONNNW33s7dAXyqODtti1stY57zJvvxkFyS1jDuY27vwfbc+lhpP6ujP5J6c+j26/Wp5ZKp0zn1cxDFIyVhkkScBcTY9HYrZ767cAwywCvCx8CG9CrysHIbs2CEK0UxPbJ0dG6Ix67J/dqBBv8OoJy322mqospoV1whrmC9MT1IoGMUTzxmptjoosGq0RcbJS5tMD3QxfwQAmpO5M5tVDOiRh9r9QycMcvk2+R7/ZArqCXBgxRNzQa22n8CJHnQV1CP8ByyM0tBQCzM4Pgy4IgGgHu/QodHJAt4OuSuf0Vkol0pU5cJeGIfrGdgTCYntMfZErVT+YOynLDx/yWTd8H3KnVQbWshs+dS+GQGmKufbI7w0Y4FasoA3wQOwueu0Fbmf11fOlDuw6hJNdEVg93Qv7Wy26pA7vZRw/m49eoJNn7n24yb+wYcONeIMXmJ7P2tpot0lFHrczEWZ5twqW2HCImkl5nbFDoxEgF68++HdBLo+t1h2RopGUcjOlzsuR3acKVHsvGZwnDT9eSkYCCvPtyAjL42A8Nm+1f4rsTIBh2or82vsl+wZ7AKtM0cy94/0wrq+hWOWnZnr3Qo6ilnRay2kuhLWOFCnMfHSHoZgYxKvplfV0cl5eties2RXVT8jo2xO3gM6R1Q4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38873606-214e-47a8-bdf7-08db502f8c8c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 01:48:55.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDiGQLJU5T8iqFpsuAx9g6pk1Fw92W5p7rhStQsYi8JLqGOlhmp+f+cSiM1QVt9VNKZNYAvJTC4ay2sRoXq+MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6576
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090014
X-Proofpoint-ORIG-GUID: 9SfbBMYZdsjB8z_iykX4Bw14DiJO0v2y
X-Proofpoint-GUID: 9SfbBMYZdsjB8z_iykX4Bw14DiJO0v2y
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

LGTM

Reviewed-by: Anand Jain <anand.jain@oracle.com>

