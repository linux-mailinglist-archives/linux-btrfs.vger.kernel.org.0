Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2B275DBCD
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Jul 2023 12:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjGVK7h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Jul 2023 06:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGVK7f (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Jul 2023 06:59:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3476BE64
        for <linux-btrfs@vger.kernel.org>; Sat, 22 Jul 2023 03:59:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36M9a72t015895;
        Sat, 22 Jul 2023 10:59:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=D6SE5M9hv9Cw+1hKXKp/ZeM/YFhttbBh3MexQJgndno=;
 b=4UdKLi4aSAdRL7VrfigTkRsKOG/1WfTeU/xdODsS+bcm40MpDGHnAFcXZoCD69zzpzX+
 rTX2Vpq4NkJv/gKICx5Qj+rd3r5i807vroM56YfJFnNypH/DkC6jk9AawbIjLIxIfMw+
 QdAt3dNPq7vb0QuuKaWltJ4HLkip17SpALVxzRVboWudC7xNV7+Y9butNCAgSJRtvJtE
 C3If12Jex9tY+lXH7KYKsQBFI1p156X7Q3H3Pta28UYKGShRckxdMGAECXO9YZb1HYT2
 dgp+lvz1rpeZbUeUzsd8DojpHuy8j+L16EJTzicDA6nhOIC1WAQQac5IYSbMy09Tjy/G 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1rd4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 10:59:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36M9Vucq035399;
        Sat, 22 Jul 2023 10:59:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j1t0kb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 10:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dv/6JAPlXtKd4uMkamXHgnvVKThscvBrl3bAARSLRonKeEMS3ogPh9bexT4tmveY+A+ixRU4RS7U95eFFzzKYDsvi8BTHeXbhYAgPKC1FUS0XoWcq6Clg0QjCXiEfPCTGI8obIwbLnYn05eWvwsHsrRRRqpiQExPZxgtcD3ouUedgjsgELuyinytN391Lb0HK3HJShZPqVVSaq/meUn1OniEZPbN+1w3E+Tr/+eC/SvcwPeoKMjNcvwS2cDMlcOtqG1BKbq6TcSOlcVSd81pMuiI7/XQ/LNSCplrBpW2QE/MFBkkZLUWcy1XBh91Dxl847N9LJBmxfDGeNLBSdNqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6SE5M9hv9Cw+1hKXKp/ZeM/YFhttbBh3MexQJgndno=;
 b=NW5JlWoGU5/Tp4wivPgVKZ+CEGuRojluR6ahir68MeV6OjX1rkq6pCjubM1qENTgghPRygYuoqwt/e84TZbZobpXP+iqw4PtSUDJRGYNU3Nfb0WhTECZqCiHcUanpvDVAT813FrnwR+744cSU69TzY4ELVjvzA2WA/+jF2KZn2ryxQrE28omQWojYsvN0fkqU9zM8WjF58N6vjXpY7ES9neaF+FPsIJfepWUACsamOD2rVO1wG5r39A9ntX4n78jl3D79XHCcTJO5jNmvpm4XG5bX8JnXu0hoXKnqkZWFCFIq3wLF8Z2LoZjSMVT+U29WUHTepoXyiRBGl5JZS5Jfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6SE5M9hv9Cw+1hKXKp/ZeM/YFhttbBh3MexQJgndno=;
 b=MLa7E0HD84YXlyMckZ9F0RvnoBXYFl6L5rT02lKbAtcoR0/l911ioQ2kEQ8O+mplH0koKjRpsaTmjMWKJKMKTyNt87VYraigrTVXQpG8EivUN/d7mXBsceOcL2kT1Qsa1+K0ThQLh/bF67I0OQ/7C0ZCjFtK6O3i8vgSEiPWu70=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB7526.namprd10.prod.outlook.com (2603:10b6:8:17f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Sat, 22 Jul
 2023 10:59:30 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.030; Sat, 22 Jul 2023
 10:59:29 +0000
Message-ID: <921897eb-ca61-4da4-57be-f845b7bfb87e@oracle.com>
Date:   Sat, 22 Jul 2023 18:59:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: RAID mount fails after upgrading to kernel 6.2.0
Content-Language: en-US
To:     Eric Levy <contact@ericlevy.name>
Cc:     linux-btrfs@vger.kernel.org
References: <B3M2YR.U71TM7CWM1P12@ericlevy.name>
 <b3517b3c-f966-53fe-3c70-8fa787755672@oracle.com>
 <OKQ2YR.1O44EDSAXJ853@ericlevy.name>
 <5b436e82-cdd4-0f84-71af-014c41c3e12d@oracle.com>
 <QO24YR.0OIFSCSV1LXX2@ericlevy.name>
 <fe7fc452-8356-85c8-9685-f40e68db8a2a@oracle.com>
 <FOS4YR.OZITE19DH4RR@ericlevy.name>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <FOS4YR.OZITE19DH4RR@ericlevy.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 60fba136-3ba1-43f0-0ac2-08db8aa2b865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JdgkgJw7n4DRX4+z+jen5uxso0NJTxMVLa6/K/469dlpdOSgyGoURNXclUsXPoNFGlPRkSJSbA2cxm0XU02dHBOJmmnPQ2LHRZSRBIVzy8qlT8GH+FStnq002nZb3w1bY1vyybbOD1YHbhZ8C4S8I8t8DElq7fWTLUokwc8HPKT5imo92mi0tl/ETEcl7qwo5BESi8gP5oQC5siSAjUYfKBXUW/2mSIkHrRtWFMqp408M71MFeceMHX1gyMfjwldVlGagmIooTig7wmkR60s3mUH4+BuPgcwqk2u63vmDUW+DC4jX5gJqV1Bqvr9tOwWtbjIFJ/6kfRikFZbq/PBo+uQXzIi2Qn0rJp5J3Qi98ddb6YLcWzdjTXoSMlgXzdMY0wYjB5ulZTWwMZBzEytVEFlPDhXqnPbbGFTMYKL8Fy/mHstAg6PP/tylzoFeaTswgDLSGhb/rnKz10AwOPi/AE0Zn32T0K1eJJkiYTs5DEFyMHUfjeO4YfZYEgfLTZpPj1qWv02QEdzZRIzL+tS9jcJ1MUNxkCtwd3i6vHQE+62/gLURf2KpqUNObQphx4GbU0ll9W+N/LFFrCew8/e+sbDYtyhlGvP9RC4a74tEZWnVapNJ7csJn+bWIgK7AdDMNnKfAS8cAznGXFHmnU3qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(376002)(396003)(451199021)(38100700002)(186003)(83380400001)(6506007)(2616005)(4744005)(2906002)(26005)(44832011)(5660300002)(8676002)(8936002)(36756003)(478600001)(6512007)(6666004)(6486002)(316002)(4326008)(41300700001)(86362001)(31696002)(66556008)(66946007)(66476007)(6916009)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1hZbWRRL2licXYwOU4xUWtPQVZUaEpQMnJlWkRRemNURi9mcTM1bWRpRExh?=
 =?utf-8?B?ZkNDamgyZEUrUW42U0FDc0ZlcENqUG9QbU03R0lSNzBvTExWbUNoTVpTeUFS?=
 =?utf-8?B?Um1Xand1Smg2VGlWREw1a2RwMGUvdzl5K1dPUkFmbkZEOXQ3V3FZdnBEdjFL?=
 =?utf-8?B?eTdvVG00TmxLaWpWOXlWMzM4ZXdTV2tiMkhoRnZ0T3lENVh4MitPMTQydUty?=
 =?utf-8?B?cXhiQWppZlZTckFudUNIQVVOSmYxWGhjMmEwWUlWcFF4MldNTDgzMWh0aUpD?=
 =?utf-8?B?UVpOWE5TOWRMcEFQS3JGWUtQSlQ4b3ZidjRlWi9yK1prS05ac05rWU96NFhS?=
 =?utf-8?B?M2VGTlA5di82OUdxUGNHT2drYW5Ia3pIWjlKcU9JalorZVZMUy8vV2xvQ3hX?=
 =?utf-8?B?L2Q5QW5VS0RLck5qSGJWektoRmlrUU45U0tuR0Q5ajFhNTA1bUY0Wnc4bCt5?=
 =?utf-8?B?S3lhVHdvTWZMbHMxTXo1Z3hkc3NTOGN1Tlh2bjYwRlIzWnVNYWNzWkpYb0N5?=
 =?utf-8?B?ZVc1SEdIb2RkZEdXSWthTjVUTThqaE5vU2Q5YUR3b3BiM0tlUW5kaG9ST1l5?=
 =?utf-8?B?N0NoZG1JV2o5UTdSYjNoYTdSRDJXVmZYaytRUlZOZ0Q1LzJQSEtubXhuVlUx?=
 =?utf-8?B?K29LWFVSOTRmMnl6RHR1WjBRSHlpRGZDQkhmRWNacG5KcHFxVTNkVGlpUHZ0?=
 =?utf-8?B?eVFKZWt3SXhqRmF6MjBsVjhwK3duSWY2Rm9CY3BlZFQxVHZDOVRwYzhyUDV6?=
 =?utf-8?B?bVZVbkxSNVVzTUNadnBhdjBtMEVmbG96MkZNQjlUR3ZRUE04bmlQZldDWGRw?=
 =?utf-8?B?K2l5b2dWUzRzcXpqckRmUWpQRFYyeEVCenp3NUF0MGxHNHZRSmY3c1NybGtj?=
 =?utf-8?B?ek8reUxTS0VRaTI1MDR1NkQ3c3BJclYrdGtZZm0rNWxOUGxNeEErQUdiWVY5?=
 =?utf-8?B?em1salJKZHBlK2N4YitFQ1JWQ2tUdzJDcXQ2Z3FmWVFNWWdsSGhiTTlGNjdQ?=
 =?utf-8?B?NHc0T3FVRUlOYUpQaFNBSm1BZ1NNRUVZYXI0RkJyS1hPdDB1NUtjRFEySzFM?=
 =?utf-8?B?UGxoT3dxNmtEc0Z1TEVuWFlDWjBSZVQyWUl5K3FMYUdNb0hHL2FGUldqOTYw?=
 =?utf-8?B?OXVoNmFDdXA0YVJoekFMRkdCb1JKWkNZVjFSem52QlR5Q1RlYXpwTGVNTnl5?=
 =?utf-8?B?TWpFTWxMSVJNdXFMV3FSejkvcFB3bURLRFNtV0tLbmJZV1FYSU0ySktma1Iw?=
 =?utf-8?B?VHJoOEE0bGtrNDdJYlpoOEJJRHI0WUVwQk5tQUFtVTQ5VWV1TldqblZmNjFu?=
 =?utf-8?B?RnFvc3JSWWhiT0F4RHNzZkJKZ1dxeldpYXdJa01kTGZaK3BuZ1JBWndhaXRj?=
 =?utf-8?B?OFhuelZZRklGelQvdG5DSkVSVEt1dDQ1OXBOdXBwMmRTbU0yMFBuT0Uxa0lC?=
 =?utf-8?B?bUw2VmdqTG1XMllSTzcvL0dpTXFMamdiaHRVTXJUQjlZQitMR1BKQ3J2UGdo?=
 =?utf-8?B?RWwzVE1XdDQ3L1ZMU25rL2N5cDJZb1EvNEFScE9xL0w2c01JbWtGeEZFN1Y0?=
 =?utf-8?B?eGxhcUdHZTM3MGM1aU9IcHNEWlY0bjF2SHJCcE4rbmJoeCt0WXp3ZmZMcFBn?=
 =?utf-8?B?blI5azc2QytvK2Q3VVNqK0JWaGdGQUhXUjFQNzNKWVV5NlBjeDM0RzdZWGtY?=
 =?utf-8?B?UEkyZ21HLytPQjRQQktwODVCUjU2eitWcC8yOTd0TmcyVUtvMHp0NXdaV2pI?=
 =?utf-8?B?eEpPR28vSmh0Zi9WZ29lYUZiWTlhcEgzbm5mOTQ0dkdHRmJ6a2QrSUJiSVhU?=
 =?utf-8?B?SnNWQURJVnFVSjJ4Mk01SGhzaXNhVVl5UGNJQWFGVnVNNVB0MzUwWnZ2U0FG?=
 =?utf-8?B?QzdtZXlaSkpWVnJGaGYvOFBJSVRuYkY4YlRzdVk4SWhOK0ZMZTYvVkR1QXBN?=
 =?utf-8?B?VEVsbm9UR3RXSTJ1TzYzYVRWSGdWZFFMS2lvb2p1ekZIREYrUDJMeUM2VHlN?=
 =?utf-8?B?dDR1bHAwTWJwdEJ0cWFTMklTbTdSS3pMaHZrL3IwUFNmWVAvQWdHdEZ5U1ds?=
 =?utf-8?B?UUdWMnNyU0NNK0J5dlMzUWU3STdHa3d2SmRlOXZtbHRwU1YrbmVrNDR0N1hG?=
 =?utf-8?Q?3BeS/kZ/IZHjE3cbTOATBPfeW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Db9bjoHbBO25g4EJfEkIEH+KVRPInjV8mmNHTjHeeJ/zZhNHukTtqCV4y/mBqO14+sDWImpuLaI/oz7ko29x0J0et/jkkTieKR4yWUQl/nFIXZCLaN21zHPNzf3rUKrToFH3Ig2bQ4SwuK7GNj/v0mc1y6ZPOuzeKBLrlwFlH7Ss3/gODfNzQ0zyoC1uvK2wILi6Q4tgSkilwQDPmIzaGRlpGyusFakeNdn/tmhP0ZVM4XMRNH8mYbF6WM56pHrnZ57/YzPX/uC2BkxF6Gv1Q404uyDsjWslmhB720JeEJjdVftir8qgF7zp9dd1FIBLzIguDoFQzXP/gOOSV1/fwEf+sIPVzFx7zLzKw2q7kn6UMcrci5g9tPGVvdbnC7aLip2hY6hhN4fgp1p2SQ/JBhTD+2IDhH2nEQIA/c99NnQAjAWRoy0qKJWmG7DL2EOJqg5OKixrJRRdDbP0meleoSo43gHm6O5mHQPVKdRS2PN3SxDgAlFt99IjWcFJXZP703iPJPsRly/ZBWUk1Ub9tsu1uu7L1GZ+7vczff3nUmFCToV6i9qc1vSZpHDCIALgWrR4f9SCXH54JimIfpSFXxTBsIhAq4c+KuukoBa9Exc6qntnaPmXumjo2UF1HbioIiYiEZGhMOMUlm54IKCwyNG76L/VX9bxpLc3DP3HqEiYTfKfoWhgoQ+ixtx7dR4JKQNkmdU3Z3fH+wMewJZAxdh2XMX20L3e8lzZPwEdYvHEe9VHNEiI56SxwkKhgyRwq68jh5YZ9POUZkgPKdMrXzFiJ3csfwcJ9p3CMp6l2iQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fba136-3ba1-43f0-0ac2-08db8aa2b865
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 10:59:29.0723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7flxzmTNfhWGzvcSBWyUvw4dttwaQZIzyY62gI9Guu0ed5AfNDrda6O4ENN3aY6R3grykJrEQ3uIW/GbbX/VNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307220097
X-Proofpoint-GUID: aotVjBQ8mVlWk_Ox7Wig-ZTzEroQRmMd
X-Proofpoint-ORIG-GUID: aotVjBQ8mVlWk_Ox7Wig-ZTzEroQRmMd
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


>>  Thanks for narrowing it down. Please check if you have the btrfs 
>> kernel commit:
>>
>>    50d281fc434c btrfs: scan device in non-exclusive mode
>>
>> This commit addresses a bug that was caused by interference from
>> systemd during the device scan/mount process.
> 
> I don't know how to check for a specific commit.
> 
> I am running Linux Mint, which is based on regular updates for Ubuntu LTS.
> 
> The current kernel is Ubuntu mainline 6.2.0-25-generic for x86_64.

  Commit 50d281fc434c went into kernel v6.3.
  You could try upgrading if available.
