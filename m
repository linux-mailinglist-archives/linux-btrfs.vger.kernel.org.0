Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6030B76E8D5
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Aug 2023 14:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjHCMx3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Aug 2023 08:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjHCMx2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Aug 2023 08:53:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D0C01712
        for <linux-btrfs@vger.kernel.org>; Thu,  3 Aug 2023 05:53:26 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 373CgMET015288
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Aug 2023 12:53:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=MyhsQn8MTvW8mbNXo19lhZmKWKUhfMP/ALS4iOiXSUQ=;
 b=dHyF/MetA+Cs6L/lpdSZ8i4/c7RNZz5bWZnMmoKNsUbXQpVHMuWOTO1iRg0z8HxsJDga
 BskxnOm5dBjiwruHvtHA1lLEOMeNldm/OF3vy2uZrPfDq7Z5UL0qIen8yPoNGOs5mfrB
 cSTNOrzEYMDru26/UQcZCacUj0LXCpuEZgus0Ph9uqkftuoaKdv9phmIWIJB5WDnpqK8
 aZFh+z/iRtIb5Us4keEEVmbwjqIkDp2Sd+AEf/FSU1nRUuZT8OgL3J2nw2uvFLGZ0zFf
 HZ8UUqrZBfzY4BHJ0abWUqnxGN45o8c3Xkl80GX1NYPRTSmIm3yU1llYIieXjfv3AmWz dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4tcu1f68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Aug 2023 12:53:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 373BsmJO006594
        for <linux-btrfs@vger.kernel.org>; Thu, 3 Aug 2023 12:53:25 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7fu51u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Thu, 03 Aug 2023 12:53:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=alOMfVxk/Gqh9eXWc8AQ5XgG0udP4+5tCx5/MQ2cJmvb0R9fRijbFh3uP37Fm/GZNer7JPtHwHYo1De2JXOqfXAhYcf2Mewz7XMvS9HRprs10qas+zhCKO4J38AlBAK6KpZkiROrFaOTeRJjAIRGQy18Vt6I4jl2J+A1R+l60pOGpLZvRse2ca4q637qWiGU9OqCoxUy8NwZgD1zdc0l/0XczB7MyF/yX0i41+M/uQQvylfYuWhtj3otFpF8Wc2wgT1i3vvMIXlVx51QeheNq7kUM1hxyLkzjVi5KFLP75i0ZkHTH2T9KdxOehPMrKOdPiBxJBxivE8sjNQmOCkYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyhsQn8MTvW8mbNXo19lhZmKWKUhfMP/ALS4iOiXSUQ=;
 b=bNR9OQ/GxxdRoRxKOmMUEeLnsCVMknJPCrLtcredpdQLMySQoJ3jgAVjPtqIP4gUJuJCLT6Xj6j5ZND50HR2eMcGQcNhDFq6ZhgMTyUBzx1DHZldZVO/sGUZBPXrlHK+nPJcanF5UsaCvE6ktmv787X3pLwl1rBnCPR6oNWFseR/HB9id/rr9p7oktVdhDtRvPxsebZqNak5kjuDlSaqc8ryNmrUFz4zCF95JdFbeXFVxQmNLABK0iN18kVYB9BU4qEKXIGCyVn9t857W9e/Xu4XvhLkBMDxQ9PFro465s7o4oHR7RtAZnatceMTyitMrknUMDsz59ijIIghv6M0Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyhsQn8MTvW8mbNXo19lhZmKWKUhfMP/ALS4iOiXSUQ=;
 b=rbu3q9/h51XstVrwiiZ6bc39JTfjLRbokDLizTT/fgp5A2f6SIQr6QGD7rT0Y03UQZ+de14KmhdbGLk8FgGM1uAjXy4wU9IQLW+6h40df57fUYJ6iDPrreLDAshJs40N+xjsymuisTlxzHprxC4/Y7//VO0znIbeOcXTkEWuNr8=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB4957.namprd10.prod.outlook.com (2603:10b6:5:3b1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Thu, 3 Aug
 2023 12:53:00 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 12:53:00 +0000
Message-ID: <1fe981cd-1221-5575-ebc9-f444e736f864@oracle.com>
Date:   Thu, 3 Aug 2023 20:52:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 01/10 v2] btrfs-progs: dump-super print actual
 metadata_uuid value
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <cover.1690985783.git.anand.jain@oracle.com>
 <53c1111fcc49df5f0563839146260c8f0950b071.1690985783.git.anand.jain@oracle.com>
Content-Language: en-US
In-Reply-To: <53c1111fcc49df5f0563839146260c8f0950b071.1690985783.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB4957:EE_
X-MS-Office365-Filtering-Correlation-Id: 568c0315-984b-4c9c-b8bf-08db9420913b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ICi6X8AUpCy2pM5+qWz5kza/+M2SDYeTw9WeSCuTn9lWcnHIUfdG2jdJI7l/gARqUNyEzWfiFyuZnzcMlPfNFjQNRClEudE+rTuoJIXwGIhwS7n0vwm6xlU2K+l36iFB9m+3MYDHf135K6F4TT0HI/8eNgZU6IIMAEXG5bepeRpEuPD521RJC5izGoERP9eUwlR/LOeI2rTv7C4UH0/t82ZtOfpiBqf1eahiY6bp9gaH/Xoz6EKtybh6o2gGeTh87qYFPOHXhb1KYMrGXXeKxAixKAGROR5d3PjY0t6eogannC40zOj7SB1UOQUkGDa6U/WyxLdxmt7gLbP10Dx5/L7tiMnyz6LrkyzkDhoO9hnU1kIXbNHhHfGhpCMTJ30YYoxAoIz3Gr7LYvj3xxMTNg3D6dkkOu6THYncS6SmfWaDDg1IKJXpA8yHCDDHqubMLfyVuGAWZgAJI7asRlWICOGmH2mGmvX0KYWO3jj2jYlr53VkKp8L3Sj4s1+VH1zyoAWJNqTeRNUe1apO/kJxTyazmFT7pMAY/+C3POMPwIdqxKYAYY72rON1v+DtFvMi2lBMqNlE8CLG8PfJIqzspxHLy4ZTb+ztwwXHHH8guLhKHP96A/uAhRAr5h7vzSNylt82NDDwe9bPIOLrDrvNlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(2616005)(53546011)(6506007)(83380400001)(26005)(186003)(316002)(2906002)(66946007)(66476007)(66556008)(5660300002)(6916009)(44832011)(41300700001)(8676002)(8936002)(6486002)(6666004)(6512007)(478600001)(38100700002)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWJvMlBHclJXSjNlZW0yRk9nNnM0alQ2T1dVMGVvMVI4K2hyL3N4MG0xaFFU?=
 =?utf-8?B?KzBhRzIxM25OUjNMN3JZcFJQWllDNkp1d1cyM0R1MmtJZ1NjTHI1QmtjNjdJ?=
 =?utf-8?B?akRyWHNLd3RYM01pazJBOWpjTFREeVZwaDNCaUhxbWdlbHhvcTBhTStRRDBR?=
 =?utf-8?B?UVd3eHNGbGNZdWlHWngwYkJNcm5YWjNFMytsdjQ0ZitXMFJTNEF1QkNSYitR?=
 =?utf-8?B?NnYvR3hqaDlaQ3hibEZoUDd2eVdhMGZYSmh1SitONEJLM083NDJSWUk1d0dD?=
 =?utf-8?B?QlhyakhjTVNxREtEUUx5L3F2SnoxbjdMY3A1UVVsQVZZNzFBcFBIN2lxNWw0?=
 =?utf-8?B?ajJQT3RHS3JSb1RSVGVQNVhORjdiY2hMSm9KZ1VST1FwMEJDM0o4VHdrczZr?=
 =?utf-8?B?T1loT1VuRmt3d09zUCs1dk9uRHVjdnZxN0FFa1Q2N05HYVM1VmtxTDFkU2ZN?=
 =?utf-8?B?dGk0WmY2Q0ZrYjlZRFZjeTdKWmNtNmlEVW93cVlGdHJLYk9tK2ZLUUlNUG1V?=
 =?utf-8?B?c2JPTnVOTnErTHBzOCtMWkxZVVFOd2VGUWc2MUVPeDYwOFBCTDAvRWQ2MjEr?=
 =?utf-8?B?OGkzWm9ESEM1OTVGbzY4UldOSlJ1MHVvY21WaW44b1pKZU5rNHZ4UFZPelBt?=
 =?utf-8?B?NnNuZDlxeXp3Nm9lVGV4Z2RLdDhTeTBPSkpQY3hjRlVkM3dZZi82RFJYMDFF?=
 =?utf-8?B?RUU3VjY3SmJxb3Y5WHZ0NmZVZU5oVm1UM2Z4QnNmendMZXhkOUtSNit4RUEy?=
 =?utf-8?B?Nmp6WmxSaUQzK3BVL1RnbnZNUjE5NmVGK1lGVWpXbWpHL2NXVEZkYytzb1Q4?=
 =?utf-8?B?RzVoWGxMeityTndqTW9NREplYUl5TDBidHQ2d2sybDZUcHh4aVo3ME9PZ2Vz?=
 =?utf-8?B?MnhWL2gvMlBucm5KYjZHVUdrSmI2NkJ1VnQ0aGN3aHJGbFZWcHQwNC9JajhN?=
 =?utf-8?B?clNPN1BCRyt3bjM0VU5yY2t6dkkzem1UcWNZNEZlMTFzVmhHWERDbUR3eTND?=
 =?utf-8?B?d1ZJQVFyTnpJYytvazlyakRYOHZuL2hPU2RPWlNyY3VWR2c2R3VOTmVzczUv?=
 =?utf-8?B?TmYzaXkyS3ZYdjNkdDR6K3lpYWMzUmY0eHVyU0JJakxFV25YMGdWcTZuQ01P?=
 =?utf-8?B?V0RNWEpaZ1BVTEY5OU5ZRnVncWEyRk1iVWJ3WG5rSElTL2c3WmNVNUt3Q3Ft?=
 =?utf-8?B?RU9qNGs5V3J0UjNHNlFsWTNGRHFtaFhqTmU0dFVvd09USUlmSWtIUm1pbHNy?=
 =?utf-8?B?RmN6ZnZPeGxNY0d4ZkMyTnFtMCs1NE56TGF5YmQ5dFUzMVRjSUJHMWQyN1FU?=
 =?utf-8?B?dHZna0thUlZSNzYxZ3BlMmJ5Q09Pam1zYlRhQWVUQ1JDTEp0K3R6cWVZNzVV?=
 =?utf-8?B?b0JQck9vMkczL05CYTlXZFJyYVEyN0wzN1h4S2svQzZIZFZZS3AycmVDOGVl?=
 =?utf-8?B?M0N3bEVaTXJmaTFKSlMxSElDNWNrNGMzTTE1VmNvanJoWTdQN0thWTcvUVlh?=
 =?utf-8?B?L2FtSlVCcC8wcmZjZGlOemdtOVJQQ0ZaaGx5ZGlVaHZ5Nk4wVnR5VlNYVHo2?=
 =?utf-8?B?ZU9kRXBXY0VJazhzcUhpcnphc0RPQzNGOXlrNUNQL3VxOXVxUW9TTWE1ZGFm?=
 =?utf-8?B?UDBYQnVOWnRwQTB0NmY4UmJucmRPUy93K052ZGl4S25ueGw3WGZsMi9wTzdn?=
 =?utf-8?B?MXZpcjJmNUJ5MmRlTHpRTXQzZ0dmeC9HTS9NY3JGZ0d0eXYxeDdSRFlXTzVQ?=
 =?utf-8?B?cUphSUYxZktxc29yUERiR3BSTkdHUTI3Q2NEbDhUSGF5cGVNUTdjeWYrS3dN?=
 =?utf-8?B?UWZwejVyY1hiNEp5RE9pbHM1eVB0TFJ1TG5qb2wrNjkxQlJoRkFBUkZiUnVT?=
 =?utf-8?B?T1NIbGJQbzZpekQ3TjU3UWZ0WVZVWHJjbjdKam9reTFkZW9DVm9mNWhQQWpj?=
 =?utf-8?B?T2d1Z3pqWTdacXRGYmZFKytTMUpIa1l6bFdraDY5bTcyN1ByMjJEeGgwYmFL?=
 =?utf-8?B?eXcyaG8wMS9Zd1lLRmY2VnVKRGZkRTBQL1BWNjNtSFhIbmJGdHdabDJibVpT?=
 =?utf-8?B?bnpKQWRvdDltVkxCUmJmZ2JpQlNudm1MZldDSDRuMVdBZ2VGdXc1T2NpNk1Z?=
 =?utf-8?B?dHlhZGFKS0puQ29kL3cwM1NXeWt1NDFMc0JhT2prUU8rYTRTTmZaR3pvUVMw?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kcu2iKYr0Vi3uZxiqe46v+JCQU3Xg56F9/saWyBpCiPC6EncVYmIhNSvAv6nHiLDdydaMkH4l+OK9e9os2d/cf861idqLFTs88vVZGe+Iwx2ODLit+3A0qDNYZXufLP1IYZJW0Nv3ii05KRjHSiKBE6fVOcFonoUJuMZA5IQwem4zn3dt8zR4zTJTPlb+q00DL965wmZkGFJI6oqu9EMkuoGlNoeSeerDuA2T5Tr0zhzuzmmq24b8quUH0srgmrpcJFiNpQGcBPSHMWCuTBzJaKPKciUTndGTUXi4Ms9+WicJuRiJlgJopA+lUT92vsa6IgqAx6CY1RrZMuAAnkEqTLs00he8jmbJP+Sk5c92X5lkW6fdI+SVEW7ixpgHOoU6hELkidJNmG7Re6vMRHbFT9rMeM9btaIqa889roFU944pIE1Loik2Ql+8DF8Z4hN7nJ+dsyocrGbCw9z9aDNhhrWa4TogOheEQ7iwzGgtKxkYovKGEIqmuAPHpQ1pKPIC8/qxGy6Z7258Hvct+nBtW8I0azW9c4qkZhXHmj5w45zmNT7/cg8wsGHIi9As/pXslCjK0K8X5EpUEs4bfTlW3DM0vRELvjuwcD6pKSqhVXUo+UGLWommO+2RJvlZepQLohDA63Olc+Ww27sIR1o6v9Th1b4BZTwN8PltJDQ41TkMqa2eVIMlNNYCU8J04UqVGIfpnLC3tbG6i9am2dM7gLDH+XbYAXPeEolU5Az+UEA8w4c8wk/2PiHxzzmNaGTtrqGiw8EwM2qfrhARW5Jrw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 568c0315-984b-4c9c-b8bf-08db9420913b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 12:53:00.3845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PXp5KW5BHxoIo4qdU+0gZsofapuRgqz/aMMwZ19wTPzxROPYGim0vTiDi6R+9ze1aHXv2rVpKFFHLFaMFe0EFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4957
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_12,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030116
X-Proofpoint-GUID: v7h_13a2_ZdwrZ6FjWSClPswUcl8TLAL
X-Proofpoint-ORIG-GUID: v7h_13a2_ZdwrZ6FjWSClPswUcl8TLAL
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

On 03/08/2023 07:29, Anand Jain wrote:
> The function btrfs_print_superblock() prints all members of the
> superblock as they are, except for the superblock::metadata_uuid.
> If the METADATA_UUID flag is unset, it prints the fsid instead of
> zero as in the superblock::metadata_uuid.
> 
> Perhaps this was done because to match with the kernel
> btrfs_fs_devices::metadata_uuid value as it also sets fsid if
> METADATA_UUID flag is unset.
> 
> However, the actual superblock::metadata_uuid is always zero if the
> METADATA_UUID flag is unset. Just to mention the kernel does not alter
> the superblock::metadata_uuid value any time.
> 
> The dump-super printing fsid instead of zero, is confusing because we
> generally expect dump_super to print the superblock value in the raw
> formet without modification.
> 
> Fix this by printing the actual metadata_uuid value instead of fsid.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
V2: none. pls ignore the v2 in the subject.

>   kernel-shared/print-tree.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel-shared/print-tree.c b/kernel-shared/print-tree.c
> index f97148c47b5a..1c398c3dacab 100644
> --- a/kernel-shared/print-tree.c
> +++ b/kernel-shared/print-tree.c
> @@ -2006,12 +2006,8 @@ void btrfs_print_superblock(struct btrfs_super_block *sb, int full)
>   
>   	uuid_unparse(sb->fsid, buf);
>   	printf("fsid\t\t\t%s\n", buf);
> -	if (metadata_uuid_present) {
> -		uuid_unparse(sb->metadata_uuid, buf);
> -		printf("metadata_uuid\t\t%s\n", buf);
> -	} else {
> -		printf("metadata_uuid\t\t%s\n", buf);
> -	}
> +	uuid_unparse(sb->metadata_uuid, buf);
> +	printf("metadata_uuid\t\t%s\n", buf);
>   
>   	printf("label\t\t\t");
>   	s = sb->label;

