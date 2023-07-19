Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B04759875
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jul 2023 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjGSOfS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jul 2023 10:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjGSOfM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jul 2023 10:35:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC8410B
        for <linux-btrfs@vger.kernel.org>; Wed, 19 Jul 2023 07:35:11 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36JCwxQx001595;
        Wed, 19 Jul 2023 14:35:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1B4OQOSPZwd0vfZ7ONCnCadojM8Du9mtXhQ02AMV6Zg=;
 b=aFyiQD9kfPVPou2VxhWe6dkbIL6u7A/jIv1u2v10Ta0cylNYup4fU5nTL5s6EgUdC9g6
 Y/PbSIsVm+WDOffe90pB8BpI0UgLRBD67wY912GBoQnmdXM4PepiRqwu7tWF3cdXWk8c
 McPAEuePJGzvuARptUkgvHdZtcyV6KLhk0OoUAVQyEDVLq9sxFe+nj3n34QrCG8u2ivX
 7/3cHnLWnygfvNxWMJ+BRCbyAF63eDKTOO+FIRKMnyPKI1QS+vKd/fG2WhYl+MSB9rTM
 tKIe+sCkmNjnUwK0GzI1h8y/kLpS9fNIGPFnUDrS1vTj6glQZl9eipIzRrkgpfgbJah5 5Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run89ypek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 14:35:08 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36JDMaXp038228;
        Wed, 19 Jul 2023 14:35:07 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw6xh1h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jul 2023 14:35:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/1PE3BbAcnONp6fH87UOwa9E5QEhRWa3m1Hi2z2GoV64yKxqyaL/LB+cPz5bITiQBS65Jx5REYpeUKWGYY3KtND43EaM27Ce+nqIdfZKQaj83rjsx1S6WF55g3/ixRK1o/572aKFIfrpa2uq+tP4oYKPgTLmnkMCb4nFqqnkm5Sikn6UtaLSFnhRDr1l8HPgYRrKMVfA4yCqvuVLT4IZmoO2RcBbkCdkJCBn6HrKEwDLfSVngF/pGxm+fLgWeSg9AsxBAffDE976unsDQbwi8A4oA1X88aM5n99fYm6FYTAFjm8+3eP1t5XDuKRyW7l5U5hRsv9iaFJp4bFCh8XoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1B4OQOSPZwd0vfZ7ONCnCadojM8Du9mtXhQ02AMV6Zg=;
 b=QmXdrTQp/AyR90QqYjo7umsS/6AVHLUmCboysiGukqVh8s66x2eX2sio4DHo+KgXZ42qACUgtiaGrubWy8FoVXIPJ4RXSUjbN4Zm220DQXn8ybwa/ALNJish4VvP7YA9sUYz665vH/img/v2G1Np3ofVUQZmFzSPZZ71VqBAoKMJ7jjDmFV9yWeyN8gx9ZsMJtxHgntq8p/+IWx4tSHulbSwTKyx0uqFCOqW3w55KPUv1jsaTev932ofr7zXgaTi97Ts30ARhNBvdTmzH90LNfSG1TQ/Nu1B2X0SN12q+2HG24dYennGtWKY25tcb5rmYxx0TGtd0hczIfrjr1JIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1B4OQOSPZwd0vfZ7ONCnCadojM8Du9mtXhQ02AMV6Zg=;
 b=WbYLCL4YD0zhDqSrs4GOIB/upUuIo7yAH8xvtdLYqQpiTAdOJyCQO44V73Gf9QYtwpn4s87CYhvBNtovXDZdCpangwszHfqQkXEaLIAcC97vipODX2ueeOURp4bWrJ0CyysCKKLuv2k6yqMLCoXFCqKeGe+aRlJg77Rb6eOifhU=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by PH7PR10MB6506.namprd10.prod.outlook.com (2603:10b6:510:201::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 14:35:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 14:35:05 +0000
Message-ID: <7dd5f32f-43e5-d8f9-1ce6-1411c66adc31@oracle.com>
Date:   Wed, 19 Jul 2023 22:34:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/11] btrfs-progs: call warn() for missing device
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1688724045.git.anand.jain@oracle.com>
 <e4e0299f46b9b4715039cd74f90944d9357446af.1688724045.git.anand.jain@oracle.com>
 <20230713184802.GC30916@twin.jikos.cz>
 <21fbff59-909f-ff39-1b35-197fe14be4b1@oracle.com>
In-Reply-To: <21fbff59-909f-ff39-1b35-197fe14be4b1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|PH7PR10MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: 232eb58b-ecd7-4658-747a-08db886557e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1h23nBooGLyiafQCKdgeco+MmzuMvKnxgV953e1r6shLPH18cONGW6VQ0jzpUXU+dPwth2Fuqjv3Rxmb58K9gue2zkOVA7s26FYS7SWHHVMvBcEInekUMgGTk/HNcZwKS6/43S4xrLgAgPxQjm1mDUuVrCX7H8jl1MGyhhhJSBp3n6uYNiNzRScpPrFaAaFeZH3HuHkZMG0EhyNzlmiKMoBswtmBy8UGNj0ZVbPxmHEaMoZCh2VEy3pbceqhfQ92/IwPpUjkLshAHI9x6AO9fbTUEHwjPcLGe/cPoNu9DLRxeEwybO5sUoxIgQg7aRPBy7upwbjJ9As12jJqpIcH3y4I4/sVDiSE0Zs0Ozml+RURAq0WtKvSMhUr48otrWEQzK0Unfh2uceR26NNi9N/MSVKH+0/5ZvfLI/u1NsI2Yd7IJxUuJZiqFyPnHCHoW7V1lyG7wxgFooXrCMlwWmC/xHBNnA2B+ENIwDDW4DQQuSra5Ly3hcb7sociqhDT3ciYTozOSgDon09gmECTCDmXGc1/esFcxjFFmrfIBPk3oik+aUJrhuz/Tc5m/KIX4WbtCQwppVv9UtTg5iy+ytPwKw2HudJmULJOK1m224Jouz/tC3/pRGPsy5CcTB6WdD538pbQMPda1BgLfs5Zldfmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199021)(66946007)(44832011)(6512007)(66556008)(6666004)(6486002)(66476007)(2906002)(316002)(53546011)(8676002)(6916009)(8936002)(4326008)(36756003)(5660300002)(6506007)(2616005)(38100700002)(186003)(26005)(41300700001)(86362001)(478600001)(83380400001)(31686004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0lmb0k3WS9sdUk0bDk3NnZpeUxqWXBycGx5ei9jZEhsbVBUNmdFRnNvUXJH?=
 =?utf-8?B?L2FYRFRlamJtejArWnAvQkxkTm9uT0tvbHJzRWk3YUh3cWliQ01udXNld3Jt?=
 =?utf-8?B?UE9jdUVmOWxJM2lIUzR5ZHpqTVA0RHBYMTExWnl3OFJtTUd6MGhLWG8zbFdL?=
 =?utf-8?B?eTBpd3FiTVBVWWlCVDAzdGkvTXFLRkdKZHdWdS9LeFAxcnBWdDVZbXRjSUVO?=
 =?utf-8?B?VGtEVGsrTHg5YnZKcy9vRU1kcnRGSDBISERxNHEyMFNLOVBKMGN4UE5VSFVI?=
 =?utf-8?B?SFNhNmpONTB3UXVvc3ZXeTlWNzB1ZjVJYmpxNUx0RWZpRUZBaFpBNkRLeTVK?=
 =?utf-8?B?OXI5ZXd1Qk55SmN6SVBDcXl2WXRMQjNFZFgzZUxVcTJ4L3dNVEQ2RUgrNk9B?=
 =?utf-8?B?Q0dOK0RkbWRjMUtQcWFSNEYwaS9nT1E1ZjhyM1hJYWlzU2hxK1hDR0QwZ0pD?=
 =?utf-8?B?SDNhRzk1ZzQ5SjFQTDBKbUZWZXZOVFFBNFg0dE13b3paM3d1SFpuL0ZxZ1Mz?=
 =?utf-8?B?czA2V3NZWXVKVGt1YVk1YjY2ZU5FMVd6N01vNlVWREhBc1o1MjNaUzB3QTh6?=
 =?utf-8?B?WWRCUkZTU0U3S2xYcTNCcmp2N2dyM1hsWEtPZHFhRjUzRG5yM2lYakpEamtW?=
 =?utf-8?B?b1NIeVd2RkRlVzl0RU1mZDcwTjk0U051dUkzZFo3bTBBajZkTFdNcTNjR3Fx?=
 =?utf-8?B?bnhsazVRcEUvOGM0Tjc3Yk9MZ0JKQWtjd3p2OGtUdkRTWUFDSzBXR20wbjMr?=
 =?utf-8?B?MXFNbEVjc1V6Q1BxcmlTbG1Rb2YvcXZPa3I0NkJZQTFWeUw3WWw2TWxuNW5w?=
 =?utf-8?B?OFQxTHJQRDdxTlprc2lFUDY1WnIwdUNST094WUdqQ3V2OWV0d0dkUjlYNWpM?=
 =?utf-8?B?bnV4MC9FVnYwTDhoalZ3MHBQU2RLWGdBY3M5dlBvVHVJR3hDODRhTTRIR240?=
 =?utf-8?B?bEh5b0FjTVlIOWpxanIvN1JucVRCaDRDQk4raHRRSkMvUzJrd0JtNFRoWi9N?=
 =?utf-8?B?eFBSZkNDRHVlaWgzekw5c3BPd1hsQzlPby9nZnFDSWJyb3kyaW9yTUtRU2o1?=
 =?utf-8?B?dE82bzZBMFVYTU1td1ViZlpkQm1OOG1Ja2Z6aUh5UlFzcmd2Y3FYRWNoSjVj?=
 =?utf-8?B?WVN6Sm1PUDBYNzlkZCtGcUMrbldoaDQyRGR0SnE5b2gzdG5lVTI3Q01hdnV3?=
 =?utf-8?B?d2t5RFZHOGphNHVCUUlmK1Z3TExTem1GTUMyWVhOL1BROUFqVUZCK0ZGZTJS?=
 =?utf-8?B?dEsrTVZnZkR5Szl4VTlTemdPRXV0UnE4WmJWVXh4eXBLUTZ6aTdTOXdLZXBR?=
 =?utf-8?B?TVFlQzFjREZFSGRPQnFPNHA1Ym5ybmJBMGZEM0tMV0J0OUVrZG9CSGNMZnZa?=
 =?utf-8?B?ZGZYZ3RxMzZRaURkWHhXVE9id1ZncjZSaGNmR1BNb2ZwL2NmaDdhYXc2YnFF?=
 =?utf-8?B?cFBRZmM1eG8wUXJWcFVrTW1KQVRJSDgrMXFqbFdMcUc2NDBKZGhkbTczSkx6?=
 =?utf-8?B?eWt5Mm9rcWFEVWcrNi9veFJUbkdRUmVOZ2xTN1VJWFZvWmQxaERsTzBSeG96?=
 =?utf-8?B?TEhlOG9aTGh0QTFTS3RZaEhKUHhzRU9TZUhjZmE5ekdLUWovbjlsQTNsRWhs?=
 =?utf-8?B?Y0d2cmd4T2p3SVJLQWJrSXJsbW85MDI2UTRqelpHT2tLT2xlSjQ4YS9uOGdW?=
 =?utf-8?B?SnpkWGZkYmFXUVVVK3RWVmh5WndOTTBSV1FxREFGTjcrMWdUK3JWVlJsWDhB?=
 =?utf-8?B?TVhJeFZ0SHVKaUFhR29QMVNNaEtsZWVyYzgvM3UyVjVOQUlhQ3RPRVg5THdZ?=
 =?utf-8?B?RElKeU9ha3hnYW0yUk53UWQrdytaSndDRGUyNWRLQ01UWkxGSjJ5UXR1S2hq?=
 =?utf-8?B?QWhYa2YzQmduTDZEdk1wNFJHcGxuaytSdVQzbXVsalhXVmRxUHhOc3JnLzRB?=
 =?utf-8?B?djRMVTY2UGJzUkQ2Ly9hc21uR0JzRmRzWENFbGo3Y0ZDTWtCY09EeFprZ24x?=
 =?utf-8?B?RDhjbFcwKzY1Y25EQnFlaWRhc1ViLzY1SjJHejlqd0VYckxyWXVyKzhVRHkw?=
 =?utf-8?B?dW10YXNqRmZzczBhTEVXbG9YZGpQR3hJV1BZbEhJV3grazhNSDZ2bVNRbEZ3?=
 =?utf-8?Q?P5RP3WmMS0lLblfHxIk++mKW4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EevsjdxWNz6pcakE3hsvOnYa4Z46VHyLDKifc1FMZie1VZ7HPRRddiW79ISrG3ImRsffr9b8WdpXBP6JqNaF39iaPeIxuN084ITjh1zUghLsCeNYvzzbCxEzqttPVCzQG2bi6OdcxIAVGjOcNBK6M8/qjk8Nmix5NfyaHfrb7jHHNruLoZaaDMa9/RHKV3xoWxqEvhwaQB6nNcycNZTXQSfIIBrt5o6cnOiWAdQnSX9gG44es752gf39T7Es1syKyCenesP4lz88NgxyqxDK9KnM4xkEkTznH6FV6CFoNBXoUVBmaM/c8eDRV0YSUywrimZpFugJVuMvJa3CIZFj9HgEULse7Squ1Zdwyc/Jshp2Xt/hTKmj+9Dwu8ZsY7XNrU3+DabX2V4O60fjDWGG/pxF6/o5eSnJoKYQW4jzJzDKM/MN3+u+p9iMN36lWd/Z3Y1lpUFfzWVOfoNJvEQ5CgFyiq1FzcWYEx2CNxK2rRBOTu3c6Mal1IzC1OdhNmmHteFfLJGJXmXocGZeVh8qInKts7cXG3clXhecCRh07mDQEAf4RbH0W8rPEP2Q5GZhOeLbEsWc7noZ3QZZHGaJ9SG5/Ebnhb/JN6yR1qCp3GWuSYU8scontemP8RmPTP11SnbrxKaIhIWPAW4k68W21K3jy/qK24ubMTaulUx6jzUBTKl67zVHWgBQ9d1SUYBNfm7N+kthxpYCnn90qPzuqnZyQfyaJrfJWaTUwTExh7dEfqLhchDPRkjZnpCau2EIzEyKdSyilfamVZT4vra8FQjhvosTp1szbMONFlbSGJU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 232eb58b-ecd7-4658-747a-08db886557e6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 14:35:05.4180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ArLwg++rM+u7qGUOZX/PJDhT26rrk4wkVEF7Xvzh7WUq74lcbWBaX8VFFNZQ7hfZ7dNnea5wAQFelk85OIBK/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_10,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190130
X-Proofpoint-ORIG-GUID: b3x0V1yuqgKSFN7kXLCBIROko0uGE2L_
X-Proofpoint-GUID: b3x0V1yuqgKSFN7kXLCBIROko0uGE2L_
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

On 18/07/2023 02:22, Anand Jain wrote:
> 
> 
> On 14/07/2023 02:48, David Sterba wrote:
>> On Fri, Jul 07, 2023 at 11:52:32PM +0800, Anand Jain wrote:
>>> When we add a struct btrfs_device for the missing device, announce a
>>> warning indicating that a device is missing.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>> ---
>>>   kernel-shared/volumes.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
>>> index 92282524867d..d20cb3177a34 100644
>>> --- a/kernel-shared/volumes.c
>>> +++ b/kernel-shared/volumes.c
>>> @@ -2252,6 +2252,7 @@ static int read_one_dev(struct btrfs_fs_info 
>>> *fs_info,
>>>       device = btrfs_find_device(fs_info, devid, dev_uuid, fs_uuid);
>>>       if (!device) {
>>> +        warning("device id %llu is missing", devid);
>>
>> read_one_dev() is a low level helper that should not print any messages,
>> the calling context is not known. If you really want to print such
>> message then please move it to the appropriate caller.

Furthermore, there is only one caller from the top function:
open_ctree context.

__open_ctree_fd()
  btrfs_setup_chunk_tree_and_device_map()
   btrfs_read_chunk_tree()
    read_one_dev()

Do you remember any failing test cases or potential concerns
if we print the identified missing device information here?


Thanks.

> 
> The motivation for adding the warning comes from the following test:
> Despite the missing device, btrfstune -m was still able to change
> the fsid.
> 
>      $ mkfs.btrfs -f -dsingle -msingle /dev/sdb1 /dev/sdb2
>      $ wipefs -a /dev/sdb2
>      $ btrfstune -m /dev/sdb1
> 
> This series fixes the bug; that is, it makes btrfstune fail in this
> test case and this particular patch reports the missing device.
> 
> Which is similar to the behavior in the kernel code.
> 
> read_one_dev() function is only used by btrfs_read_chunk_tree(),
> which is not aware of the missing device through the returned
> error code.
> 
> Perhaps we can make an exception here?
> 



> Thanks.
>>
>>>           device = kzalloc(sizeof(*device), GFP_NOFS);
>>>           if (!device)
>>>               return -ENOMEM;
>>> -- 
>>> 2.39.3

