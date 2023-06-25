Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7571F73CD8A
	for <lists+linux-btrfs@lfdr.de>; Sun, 25 Jun 2023 02:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjFYAby (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 24 Jun 2023 20:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjFYAbw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 24 Jun 2023 20:31:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0B6122
        for <linux-btrfs@vger.kernel.org>; Sat, 24 Jun 2023 17:31:51 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35P0GZHQ029964;
        Sun, 25 Jun 2023 00:31:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=be3mVZJ3t5oZvvfF50S+TdYgWE5KqJY5wYBopC1J3GQ=;
 b=ymu4+490TtGiQ3dszOrykmAsUVQGr6/8vf4+RbKh63gWD8kjNMrSyyOxxysOA0Qtnl+2
 zBJTNcDtlDbGG/WO/RcNpcfdlMtltOyMNNm19oz+dFQngv/cmF/aPcEhZKZAbk2p+yuM
 1YUuPkAw27ESOpkvtxW6WhcJEkEFqSd+fjDQmzc+n5HSy1KGhdZHlUn7kNzsI9ysdbnG
 hA+Bi3iWvCazPgzdXeMeefOi5FGsTIfL7IQQ4VVdgaNthwa0KMXxvAi8NTszKr+l4s6J
 UmM2+zSbXZk2ZeM66SbifKV+hB2MnpfEL+XEPMNr409LiZXnjnYhB9OkIgqVtCGHSvFk iA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdqdtgrs9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Jun 2023 00:31:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35OKNUU0011181;
        Sun, 25 Jun 2023 00:31:41 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx1r4rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 25 Jun 2023 00:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAzB8TzLW2tiuUxLa17rH29lHAmkmKCo3RgV5rRyhOLQId9P7E4Z5QEr1Ox/2xbXlu9CakH5Bees2gDN6IhZbcGvgX0LJ5J6gcPJQPpeDdF00AMNsEDya/ZU8dWvr6IGQH4J471BdpnwWU+1W9Ut30VR9jmM7xxIN8pmIcXVClXHFG478FqOVzQGGXaAfqUjAuyxLZ7+P3bp9GUB+15TWE1hPKDBx412GksH34a3GJxvvu/nmCfhlB3cVA5V54JKlsIRgTlFVBjy3/IhIWC8zXHm3BJhuTxVuWvja1fOKGY066u1bUS33dWVbOxVlPYz2wDqBbDw7FsEN4DYPi7Mbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=be3mVZJ3t5oZvvfF50S+TdYgWE5KqJY5wYBopC1J3GQ=;
 b=EqW4dMB/ESv7TmsJ3GV6Q+dmewSbHMkw82mGqFpNVnzorZjLCp/xkizSTzhOqxj8LQFV9uj9UoNpxMPht5VlfE1r1NI1TcQJJdd7vuvaofg8i6CTfXgKYWcH10tPS4DVRc/mIvTUmbTyR+2EJRrfOdagvyplrp23W/PQE+ae3Fl5d8rf7xB3xUB163WPNwX7ABuIMFCnKd43AxHssHv9lBt0uYFja8ZDhI/91C2JWdEyE4IrWXjUB6nh9q78VdHY0nkQ1ovv0bI67+uz60y5h+iwE5fHpcNXZqR5Z4+Lo15h7Rd1TZReK0CodXVvqBxQsXSbk7pyILMmYrYftRyA8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=be3mVZJ3t5oZvvfF50S+TdYgWE5KqJY5wYBopC1J3GQ=;
 b=FMSKzLXfg6m5OGty0KipeggD7yr/5+B+cUfilZDdHC8zV2k629xliFz7fCxUjjWU+7LWtEYMn7Sfu9i16p7TB024f+ZeBDVA2CIrxDgxM8WxodVR3W2ER3ErE5PExcSSFKkSwEFBq90LPhdBNdkZ+H5If9+eqD7Gl3QZkjOCtxs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH0PR10MB5580.namprd10.prod.outlook.com (2603:10b6:510:ff::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Sun, 25 Jun
 2023 00:31:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6521.026; Sun, 25 Jun 2023
 00:31:38 +0000
Message-ID: <32e26f27-82c1-79d2-6f6c-216bc4adb5b2@oracle.com>
Date:   Sun, 25 Jun 2023 08:31:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Btrfs shrink user failure
To:     notrandom98234 <notrandom98234@protonmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <7C4AZLXJxx6RBljNuhgqY7rfGiHUD9OZJKFLaR1MGbEzcvKSFAh_3arLVskVMfHkbnt7VA6y_YXbZg_eQ5R0UKSZytj_8X_yAUj8wXu40Ys=@protonmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <7C4AZLXJxx6RBljNuhgqY7rfGiHUD9OZJKFLaR1MGbEzcvKSFAh_3arLVskVMfHkbnt7VA6y_YXbZg_eQ5R0UKSZytj_8X_yAUj8wXu40Ys=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:4:195::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH0PR10MB5580:EE_
X-MS-Office365-Filtering-Correlation-Id: f84b0343-fd8d-44bc-4233-08db7513899c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qLI05UErEKqma4IMJH+5h6EJEoDb30hEokItxRJBIYD5ZfQ7XdLfXSWPqJIclZ0EEaOqX4Qw8Haw3OKN+yjjOb/DPFeFUBHlqSs5D2vdCOlnffuLF8rgeCwQBmCEqQozRXDJBCW/IPQ4uvs1q+k2157DFGWQsYrqAHuxLRmBULn6U7TrK9toLGSIuyKexdI9MWiYJsBladCgOivKSbGbwHBc9yGxpsR1y9R6wLH4XmCN/Sm1sdPsqjJ4dEENCBEYIXEWWN+2ZezxCvoc/TVj1zpysQUEypymEDPyNs7X/y0B8aHMqNWFGD86s8iETavcs0vzDLWEP32JolpK6yxGe01mglbzf3h6PZ5OpJb8nh+kQjUeYqin1J1qshuxESotYrWReawi6+MY5jKNEVpN6T/+oiHUCwXqu5yzwV0yliqVAkomZTvcgvjZ41sNvkFtdgIX2YUZg3ZQHAfkiRMqV+KRpnEwyqYGAh1QiXehqR+gONmT300rKzi91LoEY09Nu21WI07wzmqSXMaEvjWO24ffVY+kqnJIjfO0zkJP6jS4Tnci/YRSYJ5Mh/LA6oSxeD0BIBmsdJJqYX9n+uid82nXbPOP4YR8LeH9UY80Y/KKA82o7lleTnAxQN1bWyRGMxzdKxYszZalKedUAHI/UA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(346002)(136003)(396003)(451199021)(2906002)(186003)(26005)(38100700002)(2616005)(53546011)(3480700007)(6512007)(6506007)(44832011)(5660300002)(41300700001)(66556008)(83380400001)(66946007)(66476007)(8936002)(36756003)(8676002)(31696002)(6666004)(6486002)(86362001)(110136005)(478600001)(316002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnpGVzNGSVRCbUJJczAzdmVIb1FLSU1rdmFsMnNndjRRdCtVekU2L2F5cUNW?=
 =?utf-8?B?dFN6T3RmOEc4anoyWnhEZ0oxL2V4LzN5TlBDOGZ1T3hxVXE0QUF6SzlvRWhh?=
 =?utf-8?B?WnRQVDVHREppSmxOM29lYTFtaUY0aytXVDl2ampoSHVhSUQ5K1ZyRTlrSkp1?=
 =?utf-8?B?RjdFZ1VhZmdSbFhIUGc5aGRpSU5lM2pqVnh3WXVFV2lnSHZNYks5TzVaUkJC?=
 =?utf-8?B?cFI4TGhYQ2VZNGZXNlZCUkhlNU4vVklvSUlJeTk2TnJLeUpZOXdIaVV6ZEt6?=
 =?utf-8?B?L2Ivb3Zpb3EwdnpQRVk1UGJuU0UwSmU0OVNvck5tSDE4T3FlOFJHbDJrbys3?=
 =?utf-8?B?TktKdXErOS9UcHdEUGpqVlJsMmR3L09RR0l0YklTNng0VlFjUlpMWUx4V2JK?=
 =?utf-8?B?RmR1d3ZLUEF6Z2tDTFh5KzVXTTBpVjVDMFU2dWs3ek9idjgzR1VwcGZldlNn?=
 =?utf-8?B?MzZOMDQxVVl6YlJpVGp4MDQ0dEFaY0JEQXYvUFYwTjExY2dCS2MwZTRzUHE5?=
 =?utf-8?B?SW9ZWnkvYUhFeWVQdzJpODM1bEZqa1VDNm9rait5MG5pMUxWcFE3MzhFc2cr?=
 =?utf-8?B?TWoxTUZ1V1YrcW9TNEpBSWhTY2JtRW1DUk5xejRYY0pqdGY0dUNoRWtnbUhP?=
 =?utf-8?B?c20yc3JMMTlqQjhBRzJqRWNzVldLVTJXbDZ5QVA4L1I3dVovTjJ1cHU2R2pm?=
 =?utf-8?B?YWhzV2tmdnNSUkdWcUVadUNwK3hSc01qUTBjb0RmT284SDJVWkJzSGRwcnF5?=
 =?utf-8?B?TitOYWVhdGNUS1VQNFJLaDQrc2VyUTNLaEFXMTNNYnVXQ2VLbFd5MmRTak12?=
 =?utf-8?B?Nm8wQjhoQnZqR2dOL1Z3aWVubWNkZEQxaVRnS0p5YjkwNlErZUZybjFRL01s?=
 =?utf-8?B?OXl2a054cXpCQUhLSzB1bjR3aUJPbktJenZZL3ltVHVqUFV3dnZPaTRucitS?=
 =?utf-8?B?a0hZdGRwTHNReHpBQTl5NmlYWXRXd2RDOWVyUFdQSnB0cFlranJ6T0w3ZjRn?=
 =?utf-8?B?aktjbnV0U21vY0xESHVUejkrdTZhU1NzSmNuL3JtZ0RZOUlqWFg1RXhyZml4?=
 =?utf-8?B?TTRqc2dnMXRIdnpkR0dpNjhHdkVhdW1RcC9DNWMyYXRwYVc2LzBKblhVbGho?=
 =?utf-8?B?NVpjck50cEFWVWRpcUo2ZG1qaVp1d3FmUHA0K0FQNmRPWmRpRXdlUlFoNUIv?=
 =?utf-8?B?c1lxY0dFSVA4cStxOERUK21oR1QyOUlVeVhRam5SQ0FvMUx6QmViYXExSWcw?=
 =?utf-8?B?ZWgzTkhRWldXTFhPVGJtMkJwMFhZUVNGTXdPTUZDR3ZUTHY5OGl0QmdOYWVm?=
 =?utf-8?B?VHc1Tmd6bWdZUG1CL0YvektsOXZzb3JXMGNmRXBBRUEzVEFQWWhnZm9MZWxX?=
 =?utf-8?B?aENCUURJbmxGWElYelJERzBvTWR4V0xxd2h6V00wQlNkcUdIZEoybVNScXlp?=
 =?utf-8?B?OXgyc2IvZUxGWlNvaXAvd2VFQWtkbGVSTml4ZlByU1AyRDJwU29GYzlYM3h6?=
 =?utf-8?B?ZUhJeUJUOENGU1N2a0lXRXFBcW9mb1VJWVN3UVJ1ZWNnajFLSFVpYnpFdEdh?=
 =?utf-8?B?SEZlbTJWL1R4S0tMakIxVStzYnZJWlVYdllIWkNzaUJCV3pmbXNvTnZ2UlF5?=
 =?utf-8?B?QXd5dGdWNFBJTEVqT1BienYyQ1VkMFN2eU1mUitaNDZZQ1FYZDc1Y3gxZ01H?=
 =?utf-8?B?TDB2WHRtdy9VaDBXV1cwWmhYMmMxNVIwUU93Rm1IdDFZODhIZFlXS2xaSXE0?=
 =?utf-8?B?N3BpZ2hya2JwN2E4NEMzaU5aQlQrcmU0Y2hHNFFlTzQvdWFYZnkzTWZxNjJP?=
 =?utf-8?B?QVpxUEFJeDU4MmluVjdjRzR4dml2eFVQWWN5Z3lwREVBcDFaVzJsR1N0cTNC?=
 =?utf-8?B?TVI5TTM2VXp1Wkx0NHFReEJYdmM5b09OK2F1bWNXODJZbDJvTGxPUDV2ZWp4?=
 =?utf-8?B?QjBia0lES2JZUUgva3RZRFRWaW01dkg3MXBMM2NuNUZtb1ZOdDFpVWtjbkI4?=
 =?utf-8?B?R3VhR2ZoaDB2Ly81dHpTSUprbkZkRndzTnpLMTJLRDBFNm9QOXVlZWFFSm5a?=
 =?utf-8?B?R2dnUit4bFNaMG1nLzZwcFo4ODBmU0dzVDlGcTRDRWtwVWtHUlBQNzJFcGtt?=
 =?utf-8?Q?w7eeaeXtQ86x+GVGoS9T+EG9V?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MfaJqqICueoT2vPyn/L6POiQ9wBGNqd6QEIgPRUyIMRpREhRnkZMrQqHjUJrNyW3lgV73ChErHSEsBGtEy916ZuAn+sRBrFHOPrj0kULEeb3tieZZxckRzMuBsaTDtiq3wOo3KFeud4OrCP7ZYepyEByYY13q9TwW7gsTI/DyynxplQNgtE97euXgmeFNjdQtBbrTe1jvc4OiJr28cm23Jt7aC/m4DeYbXo8spNz5uXEccJvHTGNHPI38EuVQ6TmUbjcCGyiDLFluWK3ArSkPHCTQ8NC1TBZ084W4oxd9C+gFK9SCFNS92WLwJeOZTW9EdAhP0TK3eodPDPHg/RhOjbSNvON1I6YwuHbZCBMiqDJO5C3bBgpLjLIoGaJCg9CbwCkv34WTcjcV2vIpvRieT4XwWALjcw/6RxLsv/CdpFzUzWS9dzlRpPVGFey0QO1dZQnpQeds8RhQ0QjlcAltynVAZ5aYRLY+kgQLyEYyvSUGPUxjk4STyP6BnZ75zXJCato9WYXaBHwSbdrdx66QKa4B2E17CgYDjA1MmtlxldfxNhDiEjraiVA6yamSpYKntUgnntINB0d7PzOwYt7cFEqtBOWalwedfydI8LlraMHwOnga/b5a7LUOqhsPpGHa16ToMSLG6FR01+qDjF0zqTnthkcnn3ljsZKiIm6JKILlhujAdBjyzRv1uoc6g+XN5l84dey+jDi8wkNE5mDi+iQJaRrGbGTu5u1V78wMdOvu4dwEUE3tJGUgct857+zQ62fF+6IXmIO0fpwiZ0S5RIsx1Ssz3EN9aB7zqwpMV7ExV4GJClDOANZr3p84QHB
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f84b0343-fd8d-44bc-4233-08db7513899c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 00:31:38.0173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxUap+FfduAUetWFwe9BQYdHwkM6mE+xU30mYHoH9/EdDA4G0LR+19s4IpfAD6qZn/xpdELKoz1WQcWcnPSzAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5580
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-24_18,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306250002
X-Proofpoint-GUID: qdeEYv4luMr3BpLQX-MovK41lF-lXuTg
X-Proofpoint-ORIG-GUID: qdeEYv4luMr3BpLQX-MovK41lF-lXuTg
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/06/2023 07:46, notrandom98234 wrote:
> Hi,I shrank my btrfs too much, and now btrfs seems to be missing 2.1 MB of data at the end.
> 
> [23368.040870] BTRFS: device label endeavouros devid 1 transid 22521 /dev/dm-0 scanned by (udev-worker) (144690)[23463.852308] BTRFS info (device dm-0): using crc32c (crc32c-intel) checksum algorithm
> [23463.852342] BTRFS info (device dm-0): using free space tree

> [23463.877154] BTRFS error (device dm-0): device total_bytes should be at most 442379534336 but found 442381631488

It appears that the device has been resized to a smaller size outside
of Btrfs.

Typically, "btrfs fi resize" should be used first so that blocks can be 
relocated if needed. This will also help you determine the maximum size
to which the device can be downsized.

To fix it now, is it possible to resize it back to its original size of 
at least 442379534336 or more than that.

HTH

> [23463.877187] BTRFS error (device dm-0): failed to read chunk tree: -22
> [23463.878731] BTRFS error (device dm-0): open_ctree failed
> 
> 
> Opening filesystem to check...Checking filesystem on /dev/mapper/luks
> UUID: ed20b6bd-ac51-403a-b2d6-3797de4ea122
> [1/7] checking root items
> [2/7] checking extents
> ERROR: block device size is smaller than total_bytes in device item, has 442379534336 expect >= 442381631488
> ERROR: errors found in extent allocation tree or chunk allocation
> [3/7] checking free space tree
> [4/7] checking fs roots
> [5/7] checking only csums items (without verifying data)
> [6/7] checking root refs
> [7/7] checking quota groups skipped (not enabled on this FS)
> found 98553413632 bytes used, error(s) found
> total csum bytes: 95213404
> total tree bytes: 829259776
> total fs tree bytes: 661422080
> total extent tree bytes: 47677440
> btree space waste bytes: 163491925
> file data blocks allocated: 187938603008
>   referenced 111398690816
> 
> btrfs-progs v6.3
> Label: 'endeavouros'  uuid: ed20b6bd-ac51-403a-b2d6-3797de4ea122
>          Total devices 1 FS bytes used 91.78GiB
>          devid    1 size 412.00GiB used 96.02GiB path /dev/mapper/luks

