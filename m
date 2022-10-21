Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD66070C9
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Oct 2022 09:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiJUHQz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 21 Oct 2022 03:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJUHQx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 21 Oct 2022 03:16:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A491F810E
        for <linux-btrfs@vger.kernel.org>; Fri, 21 Oct 2022 00:16:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29L5OMOr000988;
        Fri, 21 Oct 2022 07:16:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=d79Ay+GF/dqcS1QnZQclRUXLBQj15zsNBxBZBwE/4/U=;
 b=RB287kd4FDv4vY/C6R2Sl9i2g8PHQhqXxPuiSPJPn4T5qjKj2NE143zpJ9VMfR0k/Sal
 Hf1vtx8YlNFy0T6G/i1N074KgKn0+BKLVzVixBAmQJMeFMW2GRAEQ7tI/GHLo5qzOxM2
 jeHUSuaUfxxDUXDWacRzR+VdRWbeMv5gulwtUZGcSWlt3lZz6/fj0Ea57m8Z3ETut2I3
 lzNCKv8s4DjHatc+SY3zc9/BAvfrOO9kBmXIic60vKb/VOPRhETzpIqb9qhooMdNgxep
 w118H3B8mA1kWV+O7LrWWWZ39GsNefwfhN5W+/OQt71P7jsZezHboSDbNvO8yZP7ATBc eQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k9b7sthyw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 07:16:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29L57wA4027653;
        Fri, 21 Oct 2022 07:16:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k8htkbafb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Oct 2022 07:16:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ffq3qfNHHXsYS4R5JsheMNErrhVn0EG9vDcGLPGVKzMyLS9WLb8yo5ebdKRJd9aNi88e6ghy1AWHtfvADoP+i9nu2E81pIZ6NDhOxakVirLNKxt2BVd698cH5H2lrPHLFoW+8hLXuHBnndpxlxrp15uAUWD2uGfMSn2ZE9kQbtXO8opixLLflnEKLlXCOgbSk4ZEL2HzDdSjB5f3Hta81/3zm5A6bk4FaVJvG+PqkdbhYGHoLtWogVzKc/aefpbQsdJwxlBt3XjDadhXjHCkV61sgakMEP+heldk+UHZcLS0zukUYIgPaEXpsQ0joHCzHLVRQy12R9VciMPg4qNyCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d79Ay+GF/dqcS1QnZQclRUXLBQj15zsNBxBZBwE/4/U=;
 b=Lgz+eIzQXeZ/53xfB0E6g8I+KYk//obh1PZJQE+Q11lvyr65Y41jTB6vwPS0GBgL2FFkrco8/3qNsvkM6sdqK9ycRIf7ypNBDH9I/k2cOwDywRDBJg1MJUTL8+6DWRaQSVGdvDVmZyL35koET+YkvJVjNSEykl70YZzKN/M7ky3vAMQJ8oxZfG7kUv3tqEmyOxfQStReFfa57wihvbRwm/T7Havn3LPhHY2tTCZQ7fhdAcEXvc5IyJVR20ElVEy3qizS5j2fAitm7PbbpvfNVTKAe2O+r7D+3+uguiYg/7kZQi2iro+chiDB3IeYpzpurm7YzqZqWOZ/Ss/TKGT/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d79Ay+GF/dqcS1QnZQclRUXLBQj15zsNBxBZBwE/4/U=;
 b=ZKGmCXkrkQaX4c7gyttFeqBafqJ8wZ3dShHHFNDItFmu0Wmjn8W8orH0wPJ6JhncxF7PHOI+jxPn/2dp3X21mOlN1QjPWiSN9BoWYXU+XbL342NodjyNBbG9jyTFAJavObP5/UeovYsKlni9f/Evsm5b7od5BK6YnmhPPaihlWE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB5888.namprd10.prod.outlook.com (2603:10b6:806:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Fri, 21 Oct
 2022 07:16:41 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::c899:b523:4dc1:8f6a%6]) with mapi id 15.20.5723.034; Fri, 21 Oct 2022
 07:16:41 +0000
Message-ID: <5d971d1b-a691-3e31-860b-7f94ddff6866@oracle.com>
Date:   Fri, 21 Oct 2022 15:16:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 11/15] btrfs: move the compat/incompat flag masks to
 fs.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <cover.1666190849.git.josef@toxicpanda.com>
 <ef3372e9715ddc0aef3f20bab2129cd7b0bdfd80.1666190849.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <ef3372e9715ddc0aef3f20bab2129cd7b0bdfd80.1666190849.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0120.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::24) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: ee39a28f-d96d-4137-2ad3-08dab334337e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gAfFGI16XXlsuSJS7RA/d1fT/yCgO49YZmFgp5JEgE5zSt2XVa+71wDdHx5tZebQQJRaiW5C4PiMbQN51a71R0fUjSESMPnMUVnJO3VgQxcbhWCk46bWioIpxv07MhDg1JZexdF2guHaQ0H1l42dYHOMIz2Am5o+mI1eZvR0H0RqGsXj3fifpdy1yQa35osZQEmINtoz7jkLyuPmKRi0T+BqcOt8F1HpiSjomEAHdQdYaQ3aHt6QYKziBRKdPWbG5yMcnVDH4pbHQP4aAXyULM7ycJRWSX4GEQ/Ct7BVFwjSxuL5PIlgM42H7rHanMbi33Av18BzUGcMZ8d1etXbgdJWfa1hRwiOElISA4JWEcwPIWgv2BiwO7UmMA/yeVxN/9SZL4NbKqV6HRosicXlPMg1aDn2XHOLcp4fcQpfG/CEItM3OORvqcxGdjqjnAkEieoAO272YBMmrPV35RwRbbOnjjhG1j4InLSCjFkgsGL5RTv8geyy6ndLcNqQd2El6i8AVGnLtPo7fDDJ+zUe/gHd2vgmQDf7mDKl8FrUerMYbkyVSOXz0s2e7AHLzThPt1hjq8jfSDCwjC7kDk+1jhOwWff0eJzhbYTnA13kp1rzlg3kuUokKMTBVi2jtONVB39xzjoKVUlxKsjrU4ogRm/yxZDkRLFcuJGhj9zwmfcmKSrL1s/tvBEOlg202sBxugoP6SGylH7FvxNBSvERus7BLJkWpXQPjQ9yjc8fM3BMss54FV4dT6XRzQ15MrW6Oh1NwYm6IuTxj2skj1dBscbsz8ovSME/PZMyDAdyBOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199015)(31696002)(2616005)(66556008)(66946007)(26005)(186003)(6512007)(53546011)(66476007)(478600001)(558084003)(316002)(36756003)(4326008)(8676002)(86362001)(2906002)(44832011)(6666004)(6486002)(6506007)(5660300002)(38100700002)(41300700001)(31686004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eENDakN2ejRaRGtsTmZIU3hSa3prdE1JdFpzTk1aZGdhd2R2RkRBejU5ai8v?=
 =?utf-8?B?b1pyQVFKb3hCTXB3VE5aTmg5VnBoYktPVVFpcmsvNDhGYkpKZkJxaVdhd2lR?=
 =?utf-8?B?T1JuRTBZQjhpbXZ4Y3NKcmxaMmdMRzZhcksydjVjMytyMFpOOVpsd282WVBZ?=
 =?utf-8?B?Tm15dnFka21FdlV1YjM2MFhZVU5EN21xL1RTeUJybHo4akJ0WEtJS0tFa0t6?=
 =?utf-8?B?OW9sazZ3M3k0d1k2NHdSZXo1aE54RytQSmF6cVhWeDJvWFAxdC8wZnVWVGVN?=
 =?utf-8?B?clk2ODBCdHpuTFRWVlBPUy95bmExUUVjN1BGNDN3akdPLzJ4NG9Kd0tsRDV3?=
 =?utf-8?B?QU1XWXZqQmVwYnJNT2ZHS0NoY3d0MnpENjEyMS9VL0ZXN2x3SURNdUlHNUFD?=
 =?utf-8?B?RktEL0Nyem9jRGNrOWtOdlV3emFEcmhLYVZtM0tjMFJTTEwwY3YyYzFDbTEv?=
 =?utf-8?B?dE40TFc0R2hRWjUrNFpiRmVCMHBMVjNDZHlFbVlkNWtKYWZrT3lDYkRWR0cy?=
 =?utf-8?B?eER0U2plcTZxQ3cxSXRnYUVTazJIdnAyVSs1Z0Q1Sm1xUmpibThVNFUwZHZt?=
 =?utf-8?B?a0N6V2U5cno2TkVzcHJ5TEpmdEV0aEFoL2JRQlpuRzMvbVk1YXQwTnRta21P?=
 =?utf-8?B?U2twM00rcy83UlNzSjByLzdkUTB1VDdBSmE2eHZ4bDRLREFJaGx5WWlqZzJT?=
 =?utf-8?B?d3BvSU5GSDZSMDAxUzl4bkFSbyt0bDJFNVJkc3RBd25GQXoyekpxNDA3MDZJ?=
 =?utf-8?B?b1VtWWxEOUFoR3FsSzUybXVCVDh0bTlhZ3k0NEV0UG1kVnYyNU9UNE1Sb2Yy?=
 =?utf-8?B?RjBoQ0tGckVtcm9VU3BwN1RFTWprVjJ6S1dhMGRYVk5qQVlHenc1SDR2MzRj?=
 =?utf-8?B?WHR6b1N4a0QycTYxZnpmeXpjQ3pUWHc4TVpUa3VGSFZSeStXNnY1UUliK3l0?=
 =?utf-8?B?M0tTT1JlTkQ0RGQydmxRQUhGWGJ5dENXL0FYZXpHMURJVGVZUk1IZVNXdjFj?=
 =?utf-8?B?ai9QSzg3b2ZxTXhpZHZmWXg2VmZaNjY3NWc5RFU3OXh5ZUdBOWxHNFp4V0tR?=
 =?utf-8?B?TGMveFVBdzhXQkx5bnVYMkFRREV6bmFUNStRSHNvbzFPT2NWdTMwSUtkYWx0?=
 =?utf-8?B?OEUrTG5wL0RseWNrdjNodUE0MjRPMDluZWJGdk0yQnFXUStHU2F2dzc5bGto?=
 =?utf-8?B?aXQ2RGJOSFdpbk90b2dwbExpbmdKanFQdXIxdHlJZVVnTEhlR3hkUlJDWW50?=
 =?utf-8?B?dmRrUEZhdWYyb3pCNXJXK3p4bEVPRDJhNHBZYWZEa2dtZ1pvdUpwU3JGWXdm?=
 =?utf-8?B?YUpOb2NITE1aMzFhc1NJNkdoc3g4RUd3ek9MYnB4WmExUmJHcEFqMHJJelhL?=
 =?utf-8?B?REFUWk9FN25BcHBneWIrTmZpSTVGeW96ZzZybVk4UXROYUtzWXBONmxEZm81?=
 =?utf-8?B?S3RnSGhDOXdQaW1TejcyNnBDL2J5M1gxd0tnbnVTR1dZZVdaaHpEejdmVFFV?=
 =?utf-8?B?UkJHOXp4UExNLzZZbXllc2RkdERZK0dVcHc0VGVvWVpELzJ6eExReUM3SVNo?=
 =?utf-8?B?aTZKUVJ1TFNSRkxITGlmNWwwejRwSDZDSTV3eEUrbXExWUJZbHRxc3ZTQU4r?=
 =?utf-8?B?VTJWTUdYZnR3Y1NxdVFDK2R1Sm0yd1AyQm9YTTF2a3BNQThjZXdTTUtsRWRG?=
 =?utf-8?B?aXBUWDltTFBHTitzL1lRL0pUUVU2cW1KQzRPYW10QUorNHYzK3oxalBsdXpV?=
 =?utf-8?B?Q3JIRmJZWHRjV1cwMXdKdzgyMkhWZ1RjMEtyU1pLTVYwODJzK092VnNYbDhU?=
 =?utf-8?B?YVQ1dC9yVWJSSXV4MXFsTzlQZklCQTRpN0JwY3k5OVdFQ2JtaFJ4RDBQY3dY?=
 =?utf-8?B?R3gwdVg5eHloSitPVVpQUS9RMXFrTDdqRkdxcyttOXpTTzk0OFV0aUpJbUU0?=
 =?utf-8?B?OGhtT3ZsVUVmUnU5SWhkMFF3eitrUTFSaEFWWSs5Q2ZlM25hdDl0RWtHWjh2?=
 =?utf-8?B?eWpMaUVlNitkUUpnSEVnc3JBQUQzd0ZBYUQrRXlLeFhhaWtUVFYvU3ZVRnUr?=
 =?utf-8?B?MHovZFlOUlBKTXRRZi9rUGJxYXZTUmxlOForcWZUUXFtdU5WMGZEVEVKMDlh?=
 =?utf-8?Q?rYw9DY3kP8V1DLG24MBFeIAbz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee39a28f-d96d-4137-2ad3-08dab334337e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2022 07:16:41.3529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mSmlfbQFVLxziqkGOvWkD7r71PH50cwi3VuP0mdvilwK2oWz9gItSlvfFd0UVDzxnV+/HtTDoXvlrC802Zjkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-21_03,2022-10-20_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210210043
X-Proofpoint-GUID: m40td8REJ9mJDij-7KCQf-ws68UKwPlh
X-Proofpoint-ORIG-GUID: m40td8REJ9mJDij-7KCQf-ws68UKwPlh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/10/2022 22:50, Josef Bacik wrote:
> This is fs wide information, move it out of ctree.h into fs.h.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>


Same as v1. missing rb.

Reviewed-by: Anand Jain <anand.jain@oracle.com>



