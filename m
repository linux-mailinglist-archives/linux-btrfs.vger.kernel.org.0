Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2657442673
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Nov 2021 05:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhKBEy7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Nov 2021 00:54:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:57754 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhKBEy7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 2 Nov 2021 00:54:59 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A21QrBW022168;
        Tue, 2 Nov 2021 04:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BqL5hvcEUhP1USlglLLgohMuBVRw9V1qb2bmwqlUc4Q=;
 b=LKV3bGPkyh+83ll3tGT9OolFt1NkXdg3r4wP+YfwUmNAXWzEGKkUCf5qTwC2qrrip4z8
 gNRqG/D3TcT/XGZmsI7CjBhXay957k/QgafFc6gDNTCJE/O58U3nDg1X+EpmExcUjp1c
 SqGB6e3ImB/PdjxCPF2UK/b07rs3qTBJm6SMYjhaCF8Sc3yA00e8drvNE32nl+lDvrXe
 llfudoddbrrxreDEKXSCi9kIhB7YYaKg65Q1TNW7SAh1xFQ/MpCzHpzxBNczFcvDkDMI
 SmWLzRMPnm2d8PxnClGFUbwjUi3k5BEC39E6CPB9iSPnjc/iUzMJBjFh8cIAc7JDW6ae Og== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c26e8dn56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 04:52:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A24pZLs027478;
        Tue, 2 Nov 2021 04:52:21 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by aserp3030.oracle.com with ESMTP id 3c0v3d593s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 02 Nov 2021 04:52:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDCMOGhL5k6lwMEAH7YhJWTItOefl7jPufZptMI5XY0WQv5O0tY0mTpMwbUdl+b3ZLcRNgNz8tU8MrViSnHiZ50ioc2q6W5XuRDBVknBNCZz296wn8/7za8cNHLsz0r/En5iggXRy8a6QSYI1bp5kKiegDQpTKhAAA1+hh+tX899EQUksXrEmfR2NsIAcYcLXAXuQdvd5s7CYin7ln0nTsKSOLZuLTnIX49f4Wk/tLPYM4BbIJETq1TnMPTsgVqHJOmyKP2/XKW6TmGVVnBlU8/nrxGwpMFeG8402thJt2aHsy/T7rLB/DThm6Wzu+FmKIDPqmu/aiUcKhU3M9JQyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BqL5hvcEUhP1USlglLLgohMuBVRw9V1qb2bmwqlUc4Q=;
 b=D94zmM5JbDaL5HtNCGFg1WItGvfGA9ebnS11KqnSzTIPxffhlkWCRkqUI+2jaD4RKmKMdCaeQ/Cu8kWC6FHOMQuHmOWjyZJYr/FFKpHizGpMOCGmh81oiJUFObOBPcatHKqRaZkTWJ9THjT4r9yK03rT7FN66WMHqaXsxcS6J1F5ifVKBe2S0lFgxZEsydApOa0e0waT+k7nw3JTq4OTNwgVkflMPyIieMeD1Pjkt1o/MhpxWwtg1m8ZcMVbIyQp6I8PdS3kvCdfglB3+iiNwX0vJfIUzAG+iJ2adO+RGtGgilBPHQIuczuqUCpqky/97pojz1Eg2LUCY++DWKb5Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BqL5hvcEUhP1USlglLLgohMuBVRw9V1qb2bmwqlUc4Q=;
 b=n69QkWjc6PIx0YBdqvr+GxFWv7riYc7MOcS+jUFcu8xxIL53mVdZCxb2quAc1EzKgkl3RavUzJ3A5eP4TOH5at5XqNKgEWpm6EBDmHf0hFAI3h0vbxBbuaXgBVZbX8s8P4mnk/o/qFBb6TBgFUlETNMqsyPic6Q9fF74/2nesBU=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5025.namprd10.prod.outlook.com (2603:10b6:208:30d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 04:52:19 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::49a5:5188:b83d:b6c9%8]) with mapi id 15.20.4649.019; Tue, 2 Nov 2021
 04:52:19 +0000
Message-ID: <3447a87c-d91f-1c24-a77f-9a87d946bab4@oracle.com>
Date:   Tue, 2 Nov 2021 12:52:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 0/3] Balance vs device add fixes
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
References: <20211101115324.374076-1-nborisov@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20211101115324.374076-1-nborisov@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
Received: from [192.168.10.100] (39.109.140.76) by SI2PR04CA0013.apcprd04.prod.outlook.com (2603:1096:4:197::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15 via Frontend Transport; Tue, 2 Nov 2021 04:52:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eb15222-bf4a-4a13-6635-08d99dbc8ceb
X-MS-TrafficTypeDiagnostic: BLAPR10MB5025:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5025A77AD25F65DED5992E4DE58B9@BLAPR10MB5025.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A+FN/DOvfRn+6zON4WEwUab9/C55WGd+aHmGD/aar8+V9JCpONLrTX6GY5yhZ2KswopYTD0UN3pYW1JVON1bHoiFJvmVtdJCuOfg8878VHSYQ1DXhxTh6rfMgr4R4uKCn+4YFs/Z1tgLfFkUNPMuAdg20NWRr3hD2mTuf3qLbThDtT9ihk+i9JBx2Xx4yt60clPD9hAzOIV/iRudo3Nicz2AsutT+DrAKlHO3nFzrAF0Tk/zP12e8/qtVAAu0n8FqGazg3go5Ik96EmCnc748HKElMJ5KRocJ+ktc8hsbGe5OiVafZd1QLgTVQOSw3E89eZHmrofS4YKFm2tUIgziQshkQs/uI6qXw6ou4TTFoo5jBDcVSj8gea7ai6X9qRV97ix59LATE23G2qLqaIaJkPNhH0anhZmVsd470/zpJfcDDBqaA3Ply9ciswK9BeJbK28dUsWCMrGAbTFzEaOZvOnyP0gpYH/8oV0y7U7aXaK6EK2SnFrgqhBqjZYxPvnAUmkR1b++7DGY83YpgF7M5VhkM1oZKZVqVXXBcKE3xdiC2VcVh5uImTAKFBZx3G4RTfRsqsrtoaqZ2OqpQTODiLgU0dQMtqJwkXNMctpbEF3SCK2IcYAY+pg3GwcoSuqvaP+Ms8AFBEHeSW4MBcxmqDXs0hU8oq41QoIZTzg2yo4AY4B4JwDyQDhFPiyyAymKfnykKH+WR7h8SC7fx9uQ5fv9VwkpiwSPiVrMSEimic=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(4744005)(2616005)(956004)(6486002)(44832011)(66556008)(66476007)(6666004)(66946007)(508600001)(31686004)(38100700002)(53546011)(86362001)(186003)(2906002)(16576012)(8936002)(31696002)(26005)(316002)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vy94VXVsQ2Fqd0NuR2ZDMGdwU2ZTa1VuZ1hLWmtUbi93ZVZBeEM4ZTdJNmdH?=
 =?utf-8?B?K1Jhak5jUFhZQXpWMUUxY1cwdVk5ODA5VzIyYTF4TDc2UzdXYStMTzJVUnI1?=
 =?utf-8?B?U0NsVXorMVkxd0tGMnhsVkJ2OVZLQmFDQTlQbTVlT2pCanBWcVNWMHlFNnN6?=
 =?utf-8?B?bXVUOEkrY1F3L2Q5T2pCd2d4RW8rNnNXR2ZnZjJUOWpnSFMvMzhXV2R0eFdC?=
 =?utf-8?B?dTE1R01vOXBTVHBDK3plcFYzUzZJeTFUbSticUY1d05Gc05wR1c3WFIzalVw?=
 =?utf-8?B?Y0ZjZlFqZklvSitrRkw3NXNwV0hKNTU4QzJNWFljTG9UL29hVVUzZGgxaGh4?=
 =?utf-8?B?TXpTa0libXJkSnlUOWJnRnM2SXEvU09senFQaklwQVZjd21iN1ppQU1ncE1X?=
 =?utf-8?B?eU9seFBxM2xsb3VLUHJIVklMQkdUei9YZ1FmSzlYZXN2eCt0aC85UVFEbmto?=
 =?utf-8?B?Nm51Z1QwVVNxdklwQUthM3Y4a3JMYi82SGNPeVE0aDdFRHhqaXNNakdxMjdT?=
 =?utf-8?B?T0lDT2I0RWN3bzFSVGZBQmc3Y0p0ZHJWOU5Ec2tGUmc5WGZRNjhJVjN4Q3JZ?=
 =?utf-8?B?L0dxUHphNU1XTER1eFp4MlM5WGgwdStlK0Q1TkJ2RVM5dDk2dUJiYXpOR0c0?=
 =?utf-8?B?SzIwREM2dTNueVNNQm5DV1Nhdm5JU21kV2tFcG1KVW9XWnpmUTdJcW1wYURC?=
 =?utf-8?B?eUdjTTJmbkduREhsL0RtN1VZQ09sWGFLK25ZSFEwVVU4UVRpcGFuYmordXlG?=
 =?utf-8?B?UzNCZXZzN0lBVlZGVzArOUN4a2p6NTFPT2grTFlZdkowVG9Yejl6cXZNbXRl?=
 =?utf-8?B?ZFVDM3M2TEpsN0FnTHQ4ZmtRS3lKRmFML2N6ZWFmYWhkNFZaL2ppd2U3Umpw?=
 =?utf-8?B?RHUvTWUySmxYNjU3cnZabFRpN3lheE16R1k5dE5qbGRvS21EYWh6bktJRGxl?=
 =?utf-8?B?S3NGTkE4RFVpOUM3enJxTlQxeVVCVzU5TFAxcE9BL0daUW1SV3JDWHJRSHlG?=
 =?utf-8?B?L3JSYzBtVHpDZnV1d05aeWp5OW9JY2x3V0JKM2lZVWZkcExPR1J4eGQvOUlr?=
 =?utf-8?B?eXJJVkhObm5KLzNWS000amdGbWNicWF0c3N5SW45U1U4emg3dHlrWjhyREll?=
 =?utf-8?B?TmJqVyt1enZPN3QrelA3b1BEYkVJRFBXZnlDRDJ4ZTFHZ3p1TkhSa0l1VE40?=
 =?utf-8?B?LzJBcDBXV0xaclc1NVZZY3BqcXNHUm9zL1lubFRnektEQi8xVFNUY05kelBN?=
 =?utf-8?B?VEtLcjlZbjJJQnR1THpPWFhLZEltNTI0WUM0dHBSbksrQklheThmQ1Eydkpl?=
 =?utf-8?B?NzRVdWd6a0p6SzhwVUdKQi9xMG9FSDQrOWRVM1ZzVXphaUV6Q01XdlpLWSsz?=
 =?utf-8?B?YWdpYk5jVEp6aTJPYlJQWVVMVU5sd0srZHB6bENDdGp6eTQ2L2YrbmZ0ZWlC?=
 =?utf-8?B?Mmpac0s2L1NETUdOYUFsNEVrbHlWNUpnMmVCQWM0OEx0QVlqSEgwMmZWbUpK?=
 =?utf-8?B?c0sweThVd2lNVXFCL0RKU1Z1ZC9iNldObDQ2MllwNWNSZWUvbXRJaFY3bnk5?=
 =?utf-8?B?dlQzU0s0MCtkV0hRTDNqcjdFYXdEZUM2ZGk4M01LbnhIeWU5QlQwQ25IaUdY?=
 =?utf-8?B?N1lxVHdpa3dpWkNMQVFSMy8wRURMTGhaL21rVnBXTFFOVHJuU0x0Tk93Q01j?=
 =?utf-8?B?Q0ZiN3BXZ1U5NTNVUHRMUWdFSTVFRmw1ZWdCdFpjNzJwSHVKME9kUkJkVjUw?=
 =?utf-8?B?UU5VTDAxYlZsN3B2a2tJdHBZeWlUcU1IRHZCSDYvYTBMcXhiMmFmQUg0a21z?=
 =?utf-8?B?c0wxWmExYVJjMHRRTHM2d09kMW5JK3E3Ny9WNS94cDFkQzQ5Nkpqczc1UXFz?=
 =?utf-8?B?cFBEYndLeDBjdXMxY2h3aUg3NmVUNHBPYUdDNkVlejVuUkVQL051bXdxS3dw?=
 =?utf-8?B?TEZvUmo2cG1TMXBaaEhlclNmYng4UHhoL09MalBLenFFa0tESmw4MUdzWS9n?=
 =?utf-8?B?TExOR2NvdFhVcVRIejlzOUx2TXJZMGUrZTc2WGl4akRDQ0I2U2Q0cXJnSnhQ?=
 =?utf-8?B?bzAwcjJ1dWNBZkxvUFNqd3RvczlraXNML1k3eXdiZlZYaGxldmpTbTZiZmo2?=
 =?utf-8?B?S2VYSGJWUkZ4M2VqODN0aDJiUmszQm1mSHcrV0kyTzFDZHBlZDE4dG5jd1h5?=
 =?utf-8?Q?OnR0+AgM/Y3TCKeNdJSsAIo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb15222-bf4a-4a13-6635-08d99dbc8ceb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2021 04:52:19.7009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eVCETmBCcDBmKQyzCgPXpax3V13/Cc5tqbrKnJ1rh2v2kdU2qQpa38vslDQ1kU91vnwUY4kUC5pQobLTseHnIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5025
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10155 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 adultscore=0
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111020026
X-Proofpoint-GUID: HljZVt0d8Urtb7A1aleBg2Gsq-bEGjmE
X-Proofpoint-ORIG-GUID: HljZVt0d8Urtb7A1aleBg2Gsq-bEGjmE
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 01/11/2021 19:53, Nikolay Borisov wrote:
> This series enables adding of a device when balance is paused (i.e an fs is mounted
> with skip_balance options). This is needed to give users a chance to gracefully
> handle an ENOSPC situation in the face of running balance. To achieve this introduce
> a new exclop - BALANCE_PAUSED which is made compatible with device add. More
> details in each patche.
> 

Have you thought about allowing the device-add during the 
balance-running, not only at the balance-paused? Is it much complicated? 
If not, then we could drop the new exclop state BALANCE_PAUSED altogether.


