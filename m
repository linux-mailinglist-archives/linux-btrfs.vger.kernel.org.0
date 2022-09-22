Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADDA5E60FE
	for <lists+linux-btrfs@lfdr.de>; Thu, 22 Sep 2022 13:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiIVL2q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 22 Sep 2022 07:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiIVL20 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 22 Sep 2022 07:28:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA365E21C9
        for <linux-btrfs@vger.kernel.org>; Thu, 22 Sep 2022 04:28:15 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28MAOAFX032078;
        Thu, 22 Sep 2022 11:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=li1yY9D8+hb3wYYXqgbHQ/UpKEIej+dUCXyUIgTGs28=;
 b=cURSC1DFRQvVLRgANPnY9HxWd7OMdjeC2Mnf8TJprwNtwGmnUIJ47JdRFUMUAr7O9+AD
 Cz7+MqRMOlXkzn0BRFmP6ARLJY7T+UI/MiKV2GmAw20EbgfRWosl6emVaO5fBaAH13cF
 y4egC0qDpZ4EnQNGJUOrT9qXsEHEMIOArNOy2gZTYc7vufGiChpEDThxxFdq6SVQ2Z2l
 Ml0RPcHpESAeFVi0hy9F2NmsiGgm9fNCyRZCijiG0XXroictbb9Vq7nu1m5BxDj/Pvgt
 s6HXmXKJQuOjRqvR+Zf8Ri2ro2L2uqPxEtfP6QuLU9Fnq/e+ftbOu+TGEPJbegrHdLEy 3w== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn69kw7h0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 11:28:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28MBRq5F031246;
        Thu, 22 Sep 2022 11:28:14 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39ngt9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Sep 2022 11:28:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDtJmtrV+ugnv1gaDMJpaP8XboWmryLHcUT+uIXuwyk56zCIKmnm6GpIJsTZrNGPf2Putw1gRYXMD3SK4jP0BM/1LDkxXl3Xjnq303ZUsm9xccU59BjQbqfuMMSCDUi/BBBjEXdK4s711eNmJL8csWnalrGT+lgEv6SQSpe3+dxMpoKjhxAtmPut/0OYgsnhOyDSYyOB3ePFwVlf3Dh3R2EbZiFyxdd3IZXpblznarCcty0hPh9GQmXqOB4RH0/CxIzhiIEYTjWqV3UqXJRc1hePy++OYA7K6c1enOpGndFzwOqP397wWzWqSBzHIMDtkpR+nAEMbzqgwOLdGnuqTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li1yY9D8+hb3wYYXqgbHQ/UpKEIej+dUCXyUIgTGs28=;
 b=JoRpwHo1egVKrpRK2KsvZzXIUz4XVhv0RsQoccQSVDOh5l+PieGmU6jvRg99iC0z0oiine2ocEtzzr9G1DpbU3QAcC17FZl4+8sc44BJK51d9kSm5zr2CXYuCh/JnG1zb/o8OrIR4oCtiJIhSIVSo6NNJFKGJIDJdLQ6khGrhVnrYwb6UvNoGZoVdAf62FKlWbhljvqRVQd/hEwY0DIA9MD9Kie2B6NF06i2jQvlmKXLrrOwQEJGCNTLghFgE/ZPnZnhPQZma4SoS1KKdYbzUKpcRB/yxYT8SVgo2COdqYKShdt2jcm9Qn0y4AUFQdiyuOC0ite3oTH8lcL6coAs2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=li1yY9D8+hb3wYYXqgbHQ/UpKEIej+dUCXyUIgTGs28=;
 b=dwLV4++XV54ZwO9A9YsEDvfs5NM7E4e/gd9t/NPxLcDwKE8oNiCTJASm9pB2uyvvnypeE0vM9GbHS/KZ6MIO4rGVN6P9s6rzt4alrVJxn7yoPLsRyaIxcX95eVUB6g8FnEQ6oIZ0MY/UcRSwJ086nGgPcwI/egu7IahBVAn0fVs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB5264.namprd10.prod.outlook.com (2603:10b6:5:3a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 11:28:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::49d:320a:ecc9:2792%3]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 11:28:12 +0000
Message-ID: <e9e84667-868f-c791-3d90-11b3ce4148c7@oracle.com>
Date:   Thu, 22 Sep 2022 19:28:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/2] btrfs: fix assert during replace-cancel of suspended
 replace-operation
To:     fdmanana@gmail.com
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1660299977.git.anand.jain@oracle.com>
 <3eb88dc3914667123ebb0823bbab9e07b24cf099.1660299977.git.anand.jain@oracle.com>
 <CAL3q7H4ro3zAzt8vY3XEd-tO4XdxjgnMageeeoLX29=bewGpyw@mail.gmail.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <CAL3q7H4ro3zAzt8vY3XEd-tO4XdxjgnMageeeoLX29=bewGpyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::14)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: cee569e9-74c7-45da-db87-08da9c8d88a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBL/oeV6K/gkzURRIUCU6Cin0MIsfWUHSqj/vLC8RvpIU8EraE3KdYAURuP6oONNFB+pYB2tKMr9C5qpp1mnYGMudB0xOkNsXNdYbD0cbDJ9i1vGMPQ4nqTngfoKPZgOoOuZG274Nhgk6bRADI4LQjIbSnm7aIkGvtbCS5CV2jFzt0MvaoJssMwo52caT7wVIYeldwv/5c3XKSG7tkq2s93LHbVULpWFcsrEcIouCXkso7WFOELAN7FLzFBE9jbFBiHgTNdDsmW95q8lm5cEfSXMEg2EtWVQd2/9CYi6b4JnRDI93GrqXfBBv6JRD88aLDA4qN2ldBA87IiRAIpueXIlxGQBQTh2E42VKGK1fah4N72bfoOb24LbENkoVdGPgngVMhwj9fMAfjPJimgJrB3w8CqAklsMPBOvwvkB2Z4JyQxgQ9mQmPAeNKg3qjTUM5sz2jO9ds6OEi8QkX81BGxx3WpSPe4T0aXhrZUw4jyYxK8jdmzedq3bvEOQ8P6kJWnwlhQxqugio61fn5DPui2pFD0gaYD5RTcnLAmH476li2kXCXazueNVLb4haLh+a2LIreOc0Gl38PYetSpfngc/wV+BU9oFJtuSOBtZfG8Zvu2YMQS9o/NRJE6+lyDuBg9DQxEg4y6wb2ANAc5leMwYfHqL8bavZBDOp2MOW/0GGCg1bpWTc172NeASPOx4xMqmy1zKb8pgAtzvngU3+9Z/+QGd+AStDUOiC1UH+jtQoeE52bWCTSINMfNh77ZMK2dLJ/q6UzYr5mVoqtEqAO9dtAfK39wqkfmhuaBsz6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199015)(6486002)(26005)(31686004)(6512007)(6916009)(41300700001)(6666004)(6506007)(316002)(53546011)(8676002)(186003)(2616005)(86362001)(31696002)(66476007)(5660300002)(83380400001)(66556008)(38100700002)(44832011)(2906002)(4326008)(66946007)(478600001)(15650500001)(36756003)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THFzSlBTOTdtRHh1SHhadFFMQjZaL2NGeEhIRFlLUXpNRFhRK1doZWorY0gy?=
 =?utf-8?B?aFYyazBUWnowRTd1cFJVa3Q5ekZqUGFiQ01kbE91aFczdnZ2angyajg0bTRZ?=
 =?utf-8?B?bkQybUE5bWpmQVN4dzFHeGhZeTFJekRZUHRyMVVNRFZnUjViRC96NlVOR3ZS?=
 =?utf-8?B?VFR6NVU0Wk1sdmx5ZXlxM1UwSEFFZ3RFL0dzNXlJMm41N3BwR2JpU1N0WlZT?=
 =?utf-8?B?NmJ3U011MzJIdDJHejliNmVaR2xIK092T3ZsWHY5MTBJbTI4TVhIYVFxNG5n?=
 =?utf-8?B?UTN1eGpZYXYwYUo2cTdmWk5kM3ZDQnVPRHhENWtuZHczVmdWdkJMQnpTV2ll?=
 =?utf-8?B?ZGRSMXNnWkFoditjUDYwbUhYTUpTVnVZRFRWM1Z0YnY1S0NKSmNGam1vaGFC?=
 =?utf-8?B?WWhHZEt5VlBKSnZWZmZvYnhLR09XdE43c2lGaEpvYnV3SG0zVFBmN0FOKzZB?=
 =?utf-8?B?MDF6RGlwRFhEdS9Tbklzc2lYNFRhRHBoZHd1UWZma29KN0xPTkI4VU9kdm92?=
 =?utf-8?B?UVlSai9udFZxRGg0Y2lFa3dxRmgrMS9wb3I2N1dQV1hPSzdvK2p0UVdIODYy?=
 =?utf-8?B?YWtaK01GRmQ0cVdXNUlFbUFjVmdHaWJqVlMyOXFNeGFyRWVNWWNXMitpbjdq?=
 =?utf-8?B?ZUNsYVpYNi9jczVMVDFWcE10akhKUm1OYlBqcmdYU2Z3TEh3UEhDd0QreUYx?=
 =?utf-8?B?QUY5dmFTL09Sd0N2K0V6UURZeWdLVHBBdUNuZXJCdVcxeGMwM2wvVEU2ZmtI?=
 =?utf-8?B?bmxIR1E5ekZEQWVTWm5tTWpGVVpsTHkrdjdCemVlTFRWNkdSSGkvQVk3TUlE?=
 =?utf-8?B?TTh3MmJGbm8rYkY2N2FpcEpENUJDaXU2VG1ubWFtcHE0b2tvdDB5U2VWZHlL?=
 =?utf-8?B?OFlCdC9yeWs5aWl3TzZMcWlyaGx3TWJWRVh5VzVlVTlzRmFkUXcvWVdXdDNZ?=
 =?utf-8?B?UGF0MEFwZ2hOL0JnQ2VtNEVNNVpISncya0ZRaVdwcGRGenIyLzdJUFhKODV6?=
 =?utf-8?B?VEtZd01oeFQ2U3FBbFRBTklFS1ZwRGZXMVJyb2RYbi9VcUZDN2JtemV3VWk3?=
 =?utf-8?B?d01lNzZuNC82cGhXWXZFZjNlS01ETzVGRkQ0ZmFNdWtSVVUyZnJVRGl5VTA5?=
 =?utf-8?B?M0g0TGZ3NzRmb0xmVGt3VVk4ZzByVmtVOU90cFZjcU1BZkk5MGhQeXd0bVBh?=
 =?utf-8?B?c3k4WkdEM0ppdGFkOUR0a1ZDbVVJdlJhUVZEUkxzT3l1QTBNQVJncy9VNFJ1?=
 =?utf-8?B?UEozQmN1b3ZmbkhUc2xFY3hZT0F4ZktabGdWVnpNLysxTngxWlZEM1dvaUoy?=
 =?utf-8?B?Z1VBUXROc3lhN25RelhTOTBzbDg0S3RQM1VNaXVTaGVVbDNSQkoyYU1zb1Zj?=
 =?utf-8?B?UU1HbnhpeERXN24rYjQ2K0J2Y21id2xvb0hQRTNCSXFkWHpZZU5UM1lBWVk4?=
 =?utf-8?B?ZlZadHBNOGFYZXdIVkM4VjVFdklEUUpwVGl3NEFYNGNwSUxMSzFKSHRKenJP?=
 =?utf-8?B?TVA1MVpKN244Y2YrWUF4ZkxyR3BVNzFqeSt2QWFoeDc5bC9IRzR6b2J5UVdz?=
 =?utf-8?B?cXo5R2N5azB6NUF1MnUxeFBsRG1iVktIR0hmcGl3ejBTK0UwZURKT2lnYzB4?=
 =?utf-8?B?N3dKSTRSZEpTMStuNzM1SzVJUkpvRXA3Qm53VjJRbzNpdGlnVkVINU1tYStp?=
 =?utf-8?B?RFh6OUVlWmJZdEdHVXdFZ3lON0lPSGYreUlFamZFSE9JUG9qUFZUV0RIQm16?=
 =?utf-8?B?MHhYS2VhVjZacC9CZXdCblhQRDVmdHNVYm9xUXkyNHN4VHlydVNmbW8yc0o0?=
 =?utf-8?B?WlFScG5MTDNUZnpPR2oxaGJ0RGo5Zjh4cW9ndnNZeVBQYUZOR3F5UDJHbmtj?=
 =?utf-8?B?L3lCNW16WVZ6d3gzMlVnVElqMm9odmxSTDhrQ0pnVFoyOEdQc0FZanZJcjBN?=
 =?utf-8?B?U29QUXNsMGl6b2UzT3kzRExYVW9UaCtTUFUyZnFpZlMyWXhlblBJaHNFL1c2?=
 =?utf-8?B?NldWL2FCUnVOSEVZVnhZMkI1ck10TjB4Ykw1TEpvK0Q1L2VqZENyNWUrT1Yz?=
 =?utf-8?B?aXk2QVhiQS9ZLzBBcmYrWG93MDNEQ2JGYm9ROEp4UG9pY1cwTmtWek81amdU?=
 =?utf-8?Q?Pg9doDIXzd75ozdRoV3+l1Yai?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee569e9-74c7-45da-db87-08da9c8d88a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 11:28:12.6089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iYuTsbLXUQhoSAkUM6KRwH1XVq9vNi1umdv8nTHPnmwermMWubzaqrHqJ2qOfEjKSgM1aAHCbxnN40SR9JCzfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5264
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-22_08,2022-09-22_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209220076
X-Proofpoint-ORIG-GUID: RfcDoV0FgcBYJQKMwgZW7mT55jbsA5ws
X-Proofpoint-GUID: RfcDoV0FgcBYJQKMwgZW7mT55jbsA5ws
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 22/09/2022 18:00, Filipe Manana wrote:
> On Fri, Aug 12, 2022 at 11:56 AM Anand Jain <anand.jain@oracle.com> wrote:
>>
>> If the filesystem mounts with the replace-operation in a suspended state
>> and try to cancel the suspended replace-operation, we hit the assert. The
>> assert came from the commit fe97e2e173af ("btrfs: dev-replace: replace's
>> scrub must not be running in suspended state") that was actually not
>> required. So just remove it.
>>
>>   $ mount /dev/sda5 /btrfs
>>
>>      BTRFS info (device sda5): cannot continue dev_replace, tgtdev is missing
>>      BTRFS info (device sda5): you may cancel the operation after 'mount -o degraded'
>>
>>   $ mount -o degraded /dev/sda5 /btrfs <-- success.
>>
>>   $ btrfs replace cancel /btrfs
>>
>>      kernel: assertion failed: ret != -ENOTCONN, in fs/btrfs/dev-replace.c:1131
>>      kernel: ------------[ cut here ]------------
>>      kernel: kernel BUG at fs/btrfs/ctree.h:3750!
>>
>> After the patch:
>>
>>   $ btrfs replace cancel /btrfs
>>
>>      BTRFS info (device sda5): suspended dev_replace from /dev/sda5 (devid 1) to <missing disk> canceled
> 
> Anand, can you please add a test case to fstests?
> This is a scenario with no coverage at all in fstests, therefore
> specially useful to have it there.
> 

I thought about it before and found that unless we implement the
replace-pause sub-command, we can't get a pending replace item in
an unmounted btrfs using a script.

However, to test it manually, I did an abrupt reboot (or power-off,
I think).

Thanks.

> Thanks.
> 
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/dev-replace.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
>> index 488f2105c5d0..9d46a702bc11 100644
>> --- a/fs/btrfs/dev-replace.c
>> +++ b/fs/btrfs/dev-replace.c
>> @@ -1124,8 +1124,7 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info)
>>                  up_write(&dev_replace->rwsem);
>>
>>                  /* Scrub for replace must not be running in suspended state */
>> -               ret = btrfs_scrub_cancel(fs_info);
>> -               ASSERT(ret != -ENOTCONN);
>> +               btrfs_scrub_cancel(fs_info);
>>
>>                  trans = btrfs_start_transaction(root, 0);
>>                  if (IS_ERR(trans)) {
>> --
>> 2.33.1
>>
> 
> 
