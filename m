Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9D2766A06
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 12:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbjG1KQY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 28 Jul 2023 06:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjG1KQV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 28 Jul 2023 06:16:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0012D60
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 03:16:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S1Fb96023192
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 09:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=edtW7x7T0iaYLFA6GsXiosBwn8SYa6yNt2aCwyMNAFs=;
 b=2Kx9ui0eg+d7uz/jfAg6YlzW5i9mrnc8mb6AyAEzpTBC0PpUp0hctp4ac6PYR33xkfnx
 N/Hi5+Qn3/P54VV/aj1yGB/2Vcu/s7eJHNRtcamPJUsz8lVgsxyHHxRI8JvzyDQ6GqLI
 XgD6C2iUS5zKVn88dZfw7hbdI7pbcuJuXlRmlLw3gJy82nYJ97bmC88fdF7mLXSZjzQ1
 66DVXDuKelzi/cvu95NmLJxqfojnoRJWRSBOA+Db+h45vdfYPpx970Jpsztfa6FmQxm5
 n6dS1w08ItOrR9DaioN+FQD4MAATPnziOvSvqNuABkMXCPivXhNZ7QTUHAousn5+JvGt MQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuug70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 09:15:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S7Q2RV025523
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 09:15:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j99295-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-btrfs@vger.kernel.org>; Fri, 28 Jul 2023 09:15:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=icpqFOLtR2n5FBwo48GviWR/BRt74AZ5wBfk5yV2fQ5YY0C9fZdRdFlvd+g/toRz6GWQC1wx8zr/v+AMcncXNRfpuHbOop0LunJOV8QIB5pmG5YKXm1NgVhuHNSfsexsZEHxOyQPQZHwGectSOH+iGTBRJPMgVeJpxQwSFyl1V0U8DFdhYHWfDdwyEHafwT4Gb8KAK6R0YIH1O7h1f4wN4dBD86NYQJrFnxzplmshpB6o6dKvFa9i2xFZrBcEzwyHP5hYEvyeL4ROUzwdFtuj5FOF5Z/8QVs0XmGPs6ZHc33hjd58r4HqF7POzaXOwMlAckN3M3ue1WsQILihS374w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edtW7x7T0iaYLFA6GsXiosBwn8SYa6yNt2aCwyMNAFs=;
 b=jP2ZKURpiyCIa3koXEcz96TLu0EmxLumr7qaOBe9BIBX0bbWpPxf28N6cz+PbERbufFxJAWcdIVXTaR9eiVeYAtHR3Igfv2h+COXMSnUiJeBitvNS9rdyNS05IqTOe0JdaE+N7s2su8QMOt8/32Os7vPINuKXBtmoaBF77NQMLg/yoXHPhCTQ9m/9Ftq6zqsrNkj4iy9krGYA2g/IwaC4aZOII/iuhJA1xdLxOADItHPeAVhXCh7VQf15ZZIRjEftGlEfFDfGAANOrRYXLWwBmVrKkrscOBCQiWiZJN0auPhFbRVQBE2ZJEG/DVo/MvVYn5Fg7dOWyIgidXKRrXURA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edtW7x7T0iaYLFA6GsXiosBwn8SYa6yNt2aCwyMNAFs=;
 b=bCfSwso71Ed4a1MLcRLVYa1BdSta874GVGMynAEcU+bIVNEP6DcKo1fQDTfHGvi+tUbf49wk9OPqHzlNxWTEDXYG+TFu4s0RWtVsJXyhEfV2USxXPNHTvJ2cKsfnXTgEGpldkoExqWWr9kcRNZ6OoaZ9KTKFVtzazIkbJitIkb4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BN0PR10MB4936.namprd10.prod.outlook.com (2603:10b6:408:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 09:15:38 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 09:15:38 +0000
Message-ID: <960295cf-0f4f-8337-f2b2-7167cf78bcba@oracle.com>
Date:   Fri, 28 Jul 2023 17:15:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs-progs: register device after successfully changing
 the fsid
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     linux-btrfs@vger.kernel.org
References: <4b7b4c651700247046a32fce3148e510877ccdc6.1690448585.git.anand.jain@oracle.com>
 <e41a8748-bcf0-f0dd-0f06-d8ee9c261cd1@oracle.com>
In-Reply-To: <e41a8748-bcf0-f0dd-0f06-d8ee9c261cd1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BN0PR10MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aeb172f-9eaf-464f-7b21-08db8f4b3559
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YMjLdv8YVAbcJfU0YccgULagHuZ0+EX5Rw2ei7teb812qezYcgvUVMLEYym+M0WwYNJ1yDeMYgh5kpHbWCCl+POh24CVxfJ5dSI+WjANnnsvGfRySZH/WXcFQD74hkjHsvtAw46V4DL/QwyZ+C/hUUtI72D/Sf3F8xSCPz8zNZ5Q/RfrahyogdPlFHG3jhI+b+FJNkgr/v6AMBx86FJQF7kwXBJwdJrTsm3I8Uy8Qk+JQataGe8pYjbYiqhq3oki7ki/m9/oNkmXjz27TgVpNHoJrnp7F5OIsmzCnmIcTZuZozRv30w6sRI7H5JuDEUtD2OcH5/siApqaEVvDFBXLuyMwvcJnt5V7oP2o6RB3d0uScS0ZUuogy08hqv1a3bc2XcI6BpaDUPu3A4efZMSerLmUxzkGJNZPaaKMytNzAlmeHdTZxpoOapRDbzwKVjkiK5+Wi1VfyAbLr8EUE8pQ+GmX+N9yjHgLOgDXIVb4MRWWPfa/aFQ9zus+rNLbSYEmy8d7dE1h22JENGoCKMq9JeShAM91VL7FyjFiBBWilEtYOIzWxpFodykbpfEuRO5n2Z1j4U0yBm7ZVTm0R780nFxOmdv3my6Pc66a3GRzBlEBJ204nZDqxyzCj9S/riD3prv4dB+QI6uuRbhUJhQbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(44832011)(2906002)(2616005)(558084003)(6666004)(6486002)(26005)(6512007)(86362001)(4270600006)(478600001)(38100700002)(5660300002)(41300700001)(31686004)(66476007)(66946007)(6506007)(186003)(66556008)(31696002)(316002)(8676002)(36756003)(6916009)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MS83eHEwTVZ5VjVtbFR2cC9vSzBXZ3VZUHVFbHdmazRaakh5YU1XbjhqNzBU?=
 =?utf-8?B?U3RsQTFrTnZsbkpqQ2N4NUU4NHA0WEF5ZTkwU0VpRGk2VmdiQ0I1RGdGbzBt?=
 =?utf-8?B?YUhDOFpiSlVSWjZQZUs3bGZCMU5pQ0s1dmF3cFlLV2E5YmZoYkQwVFFLVTl4?=
 =?utf-8?B?QlNhUWwrb0V5MTk4bW1vY3pNS0lNZityOTZtaEFjNzdSWURVWDFVZVhaVjRt?=
 =?utf-8?B?NGNUT0NkcmtoT01hR2lJV0tKQkVLbGhXUmQ2TTNuZDRSbXZSb2FkcjNRc1ZS?=
 =?utf-8?B?cG0ybk5IUUp5TkQyN2hKRXFNSVR5QytVcm9tR1FORVpreGpjQXRNU3dveTk3?=
 =?utf-8?B?S2hYOE5scjFHRGhsQ3oxVTNMY01TNDRKM0RpMVdVbVNwVTIyeWhmb2pENjRU?=
 =?utf-8?B?UDhZZUtnYS96Z25Ycy83Q3l0OHU3clp0a2o0dEliYkNBK2JSYlBmM2RoWEJt?=
 =?utf-8?B?ZU5ySE02TDNKS3lwMmo0OHh2ZzJveVFtOThKeVR2Q3BEZG1kTUoyeW4rcFps?=
 =?utf-8?B?NTBIOHVuL3dlMXd0MmZJQmpadzRjcVN3Y1NQOGxvRXYxK1RCbE1TMjFtWTl0?=
 =?utf-8?B?WVhmVEk4N2hMcGxPTUQ0RmJIeFI1ckx5eTl6UFJDZXhvMjJ3RWFHcVlVUnA3?=
 =?utf-8?B?NGxCcnRBbXpLbStpV2lML01STG1BRk1DSWNXQ2xMekpBVEhrb2NvSmw2NDFj?=
 =?utf-8?B?MHplTXBJOElIVkF0bEUrdlR1eXNwMFkzdTZjZDd3YXBESGJPY01sKy9hNjM3?=
 =?utf-8?B?NXpFcktoejFBa1J3Zm83YmZreGR0RHhxMUYrOFFIRVhXUS9iMzdzemN2OENC?=
 =?utf-8?B?RElTUUdZYnlzam13WWFDVjQxeDdlZGxZSUV5RlNBUHAwdkZhQnRBKzh4Vk4w?=
 =?utf-8?B?WnFnQTZNSUVNT2p6aDh1RHp2WG1rcXE2UWhKR1VYSm1VWXpKZS92bEFGdTJ1?=
 =?utf-8?B?UlpHWnA3cjhJMUZ6ellocVdLWHN5VjVDeFEzWlVrSlJTTVJFellkaXVkbkMy?=
 =?utf-8?B?WUZxRUJBclNZVjFrNzRwUExjblVTREJwOXpBQU01VHBhQjBsR3ErUDZpTi9a?=
 =?utf-8?B?SVVRY3ZVY3NoZFk2R0FZL0RFRWRnaVh2NFBXdzRYVjcwaFF5V0RZTFBtbnZC?=
 =?utf-8?B?bUZObFljV1NhR3F0dUNMdDlEWFdVanBGUE5vRFJ6Vi93WURjdHJ2Z1pJKzJj?=
 =?utf-8?B?MkNxc3R3OWRKQUk3K25Lc2Y5RmtlTUxRL0srMnpxemlwbStoNTZJUUQ3aGcx?=
 =?utf-8?B?aUZDVWdYSWVUZUtoZHkwMSt5dE9JallwTDlMcms4akUwSDI4b3NRbk9QcXRS?=
 =?utf-8?B?Z1ZFU2hhUWpNMGtWKzJiZEdKZDUvdFVPL05yMnB2QjNwR3VUN2U4NHNCMWFH?=
 =?utf-8?B?YVlDbzJOMm44Y2J4aXFEcm1RempMalNjcWhvdmhBN01BcVZ0KzFFc09PckRC?=
 =?utf-8?B?R0VOcHhBK1llNWN4Q1FUS0piSkx3cFpxdEdqR3hkemIwcnllTUYxbTdkcFRE?=
 =?utf-8?B?eGdYNFF4cVlBRGJ1ZnpKS3FQd3h6TXJ4ZGUxZ05MUjNRcXRyQ01DN21JRFJR?=
 =?utf-8?B?bjUvekRPUjhIMFI3bEozUWRXUlNpb3kyazZnRGhNdTB2RnhHMWpDb3ZsZDhW?=
 =?utf-8?B?TlRBYm9aVkQybXpIOE9lZWJkU0k3NktKbHJmbmhmY25oQlkvajNJSnZwWnNV?=
 =?utf-8?B?R3gvTTVqbmkzVlo4dEE0alFDWlpDeCtmcTgrOWg3cE8zMm9nRHRKTUFhWjgy?=
 =?utf-8?B?WldrSitCQkQ3bWZhUkt4SWpEcFR2K0VXYXhoWGk5QnpmaU5JRkJyeHVzSFhV?=
 =?utf-8?B?MWd0UXdQQ2oxdzdRUFJlTjVPNHpvRUxhMjdHbUJFZ28rL3lLaTBCOFJnU2dP?=
 =?utf-8?B?MklYOGFXeWJ5TndOQmxSMm82MTZwREJBTll5QkpaSksrd1c2UDlRbmNQZFBB?=
 =?utf-8?B?aTY4RG40MktDU2czc3lldlNBT1FZN214MXJWSUJrdWNYQlpLampyMmswWHJG?=
 =?utf-8?B?a2p3RkNxYjl5WEZKSjRKM2orSnZ5UE9pbGVUeTZlSCtUOWxtZ0VzSG1jYVA5?=
 =?utf-8?B?cE5OL3QzMXJoZWpjZklSbGRDMVVnZXJpaWZkUzltL2tJcFBLeFp2REQyUXJz?=
 =?utf-8?Q?Geb0TeRbikxowuPMrnOKURAi7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FW0CqoPhH96P0z+7Bc/czoz67JmoAbYX+KbrEuZxUR02IyOBxXCBDmsyHWrQMH9VnTO0X43uvCuQ4XE/XteY5jrQ7idgXXDlmv/Dj6Ee72F6JW6ThPo2fmjAQUyKROshyEbHaSlwMWRG5L67Q5GGO1mUmg69vubcHAwQVabD3I6xIhClZZ1MpXC5pnm4Qp76EjfUBqAsqaRe9X0Z5j/HMsxllHh7zqKaL4KbrYPSI7nM2GX90odyvkIMScCxNHxqpVqttHaMQ5eLEOY8wI89qKAF2lWss6Tu+2vGTnhcB2vSUvtFhep5IwVN4GBZcxdal0s6hI5/UHwCfGFGLyGOz6Y4S3oGPj9oZgjPmnTGC8vBVYqadSarDzpiqi2PKnhxF1ddrjwOMIz8e9v4TkOqgk+y75yWRu9RKdjkMttV12OfoU+f+P7Di8/9mPqwgpCUei1bWDd+W3zFhnuTVIh8019AWQHXrfXs6Mx4N7fpwx8IDftCM/pw4ninByvGNv5QKFFioQVJ2bvJ+EvB2l16xHmNsEcs6kPu5Cp6Bqd85U/oGAVLHKAQzw1vl8iiP73RPXhxjcozOWjW92JyDX+fE/FV3AZO122OutL9cGafvy72kijJlQC3JEU1wekugvtEOtnDSavY3o8cr41k/LCmel7Zu6fiidiS2KTOabmkuwcbmICDgx6u9mv20LGcwINgx/f/Krxevaf1wUJEF1HZGPIMDABTcVblTpxY/8zUxX8pXzwZeIVMszjRk8uqaQ39c0Xv87IvvPhSTlchGhO83g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aeb172f-9eaf-464f-7b21-08db8f4b3559
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 09:15:38.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuXJIRha0DwNUDvQGnYsk8HgRWM2hDOF71toUDw2yNgi8AfpPw0GPI5EZAqLVEAfluSToFKT2rlVxi7TNGRLxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4936
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=766
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280084
X-Proofpoint-ORIG-GUID: ELpDxbctl9S7LKc5bywSJoKcG-9hrHIX
X-Proofpoint-GUID: ELpDxbctl9S7LKc5bywSJoKcG-9hrHIX
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


   My SOB is missing in the devel branch. Should I resend?
Thx.
