Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53AB3F494E
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Aug 2021 13:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhHWLCD (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 23 Aug 2021 07:02:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20880 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236467AbhHWLB3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 23 Aug 2021 07:01:29 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17N8TMJt021828;
        Mon, 23 Aug 2021 11:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5ELPdi36qU2NOJLOU2Q2mWrYG9TcY7eWJBBhkbNq4t4=;
 b=gMFoBThdIMHgv9U3KbyWi0EnP145fz1qoqe0VEVYql6jkxDYEhjrLuLnqAPQDosaV43X
 EEBhhZmGJ0E9d64H0iEDx9BYWQ26VEpsH9hDF1hXCsYqBKYB9JQvrnhHFSYVf4zK2SOH
 w1zY91eUYKcagF/xfze01Sdmu9JDrEuZY6jIiElbGhAqk81Y0n4Hvx2LSvEdE0PY9UI+
 VojTLxZuntrPRYKBWa8X///iA3vRBQUFORevxp0K+qEyETPK+WiEXrTkHvk3t+veIVci
 6ZF+R/sVJCI4L7D8GIDvjAcB1BVSCDBFBOmNT1SbcXDK2UQWOmnDmf/omYL8NaWbm8cc bg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5ELPdi36qU2NOJLOU2Q2mWrYG9TcY7eWJBBhkbNq4t4=;
 b=xsk9ILv34tyBCvYZRnCj+QM4gM6WGeSBsBUqfI2bTSeYKtCiMRf/hpBZurZ5MAmnjZ/m
 +dpqMJBaC+18WHUH90ZP2up0OyUBEiogw1Y6BBdin5agI6BOUpC1CWUbeNjgVo7CKezN
 vrXpk7HkuZ5EilFXLBSOtSmSt2OXtJW4too7xlpwjZjtg+xx77y9MvujKUlCHqs35K8+
 Paicr0gCu6rs0hhHDdhEWDCQawmATUyXxcEMzbSErOlJzkPrU5e23JCJ4BM/atfRXkFN
 EpzvoH8Io/Tx579V3zmeZ1Y51GoaE3bBgPe/zFUaO6L4R7MRbWXvFzpOmmNlv8KfEmJo Cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akwcf94eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:00:42 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17NApEMV174857;
        Mon, 23 Aug 2021 11:00:41 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3ajqhcfnwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Aug 2021 11:00:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVvvVsLTt9g8v0XDkU8j9q4Khv1nZbMNnh6SjML22skBlBRGrc0OaGnBKTfFZd67r4h9eYCI9uwWOJs2M/CvmRpKv9l6163v0Cnkrr3ZK+tMKifEYKtQp9lKLtfFs9+lFq4XSctrMxBzVABjmvHOjJU+x1Qo9wsxcxc+al7HzTOfml8zfPG/McHmUQ0kG2MOw4y8RJ6Ibp3lCBXyffQLq0qIA7utZ6AOSljpkE8ooxQ61RNYPaQsxsgHzhlLzhdGmLuZhA532qKz4jJyMDIFdLflbCt8/vnqDe6b0uX/Xh2UQ3bOHHL72KxXzEWNF7b8vV9m45MzbZiRa/l9pCl/WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ELPdi36qU2NOJLOU2Q2mWrYG9TcY7eWJBBhkbNq4t4=;
 b=R12lI83sjhTy+DsrI3SocTk+T4Y6cffSN6vG9KcgRBxIzqV+ZEq0erKs2TW66xOIjfUYlfXd5yIxna7yzKqup00G7SILpUEoRCJPzSB3edFxgiUqdrvJusin4G5ZuRL8duZeoegPxHUcH4vPGVhWzh/L2c5vEYU5b/PaY/QTF4TZeMLCqMwx52WRhm6135GPC9D6s175s0gqyjOZbrc1gs7M+K2h/ebqsNXgLB7xq4ssrTk7VOmu9y4j/goc6BgCNnDfNQ/5shVCinDU+Em5AVLLzkbiINiwgSPXJzkIZ6FSYHdmXcyDQgQzVyLrjUkJ6ojtEzYcY+J6wQaAUkpzNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ELPdi36qU2NOJLOU2Q2mWrYG9TcY7eWJBBhkbNq4t4=;
 b=rFTT/KKFkZiHuzOUoVc9UDL9iV+pOnAxt2Ed54KGtrDRXuZSVAIrtQs14iVEVuhTTZ5U/+GPqzNZ8Km3DKwX1C0EqHwDAhsjbGoiYVkOLGwtJlrrpHkNQAq685amI9p7EnG6zJH7xEAT5GgcExmJhs/ESwdemRlxyFlttGbNQRc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MN2PR10MB4128.namprd10.prod.outlook.com (2603:10b6:208:1d2::24)
 by BLAPR10MB5138.namprd10.prod.outlook.com (2603:10b6:208:322::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Mon, 23 Aug
 2021 11:00:39 +0000
Received: from MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a]) by MN2PR10MB4128.namprd10.prod.outlook.com
 ([fe80::b813:4805:31e:d36a%5]) with mapi id 15.20.4436.024; Mon, 23 Aug 2021
 11:00:39 +0000
Subject: Re: [PATCH v2] btrfs: fix lockdep warning while mounting sprout fs
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.com
Cc:     Su Yue <l@damenly.su>, linux-btrfs@vger.kernel.org
References: <23a8830f3be500995e74b45f18862e67c0634c3d.1614793362.git.anand.jain@oracle.com>
 <08c3bd5b-b0ec-9a85-6e54-9b79c78282d4@oracle.com>
Message-ID: <05476c95-6517-c5b9-5551-e5772dcd1e5a@oracle.com>
Date:   Mon, 23 Aug 2021 19:00:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <08c3bd5b-b0ec-9a85-6e54-9b79c78282d4@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:3:17::25) To MN2PR10MB4128.namprd10.prod.outlook.com
 (2603:10b6:208:1d2::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.109] (39.109.186.25) by SG2PR02CA0013.apcprd02.prod.outlook.com (2603:1096:3:17::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Mon, 23 Aug 2021 11:00:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9613d7d-092c-4eda-1ae3-08d966253e1f
X-MS-TrafficTypeDiagnostic: BLAPR10MB5138:
X-Microsoft-Antispam-PRVS: <BLAPR10MB5138372B584B53EF1FC25674E5C49@BLAPR10MB5138.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:494;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BFOclDYOpw4Ze1yvU4q+/TfEfCojCalA4/ewNZbzcWrjt3lKIxbuPv0tkcAtXq7ThbUqaJoGbx1bH26vRdC4c0JAicO94wxBIj0+OAHgxydJ/9EdOcR/cz4V49ot5EcJIvHdWOT1OiTCrugJ3eaRwTk253kEs6fPLHI4XLR6Kz+AEVGbAurNAQBO9CX0fjLVoXyHjYmDwFRDGx6WqpYo9LF1Yk9n9HwLswgVGhDULruxMmmQHHAH9oA5ObDQBr9ETAKieW1EztVLvQ+XeUdcMdIZzchmtYsXxN1V8G2frpQMPQAobI1PiXOR7pToEIQRDD5eXvf9kl8M0yAbWdDkPtgfDojkblmQ6i/yUpWXPvxC4CoTbOr9hL7dke5q8Z6o7fFlXmgcM1w07ufgNMJ4dxDmM5XeyV330LeIJRZ5PjSzx5VbLU907PokL4nkqhndVVPf8EUUT3L7lG6FK2OJHt4/f8Bo2tXCTF4Ke7dm1Olv2YHeNs2s+z1aXFnHXEOykyJsgfM22rxuLraCGUS4qdUX0nEanFynW/KZoQxGKJe3KUV5PkPF5qu5DWpeyEnnZ7tkWe+9rnO7e6FvP2IpSoPXYamTMUkxEgFAPENqRmfG7Jnk6/2f4H3zto4K4pAWLnJQUV8QG3NFnOMHzoZtEk6N4ZH5ZlG1+MGCF57331qLnHcEAGlJzByEBwhuDijWWmwTJWSjwqmILiuOi7o7mwHT81yBHgzbIRdes7YVabU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(366004)(39860400002)(83380400001)(316002)(66476007)(16576012)(36756003)(53546011)(186003)(38100700002)(2616005)(86362001)(31686004)(2906002)(44832011)(4326008)(5660300002)(6916009)(8936002)(8676002)(31696002)(6666004)(478600001)(66556008)(956004)(66946007)(6486002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzBaUmU2aUpUL05UUml2K3FtRjY1bDFYQTJmcGttbmJ3UHRYN2lBMjRTVHRl?=
 =?utf-8?B?S2RzMkZNUUxxRnM0RWc0bHZ1OXZtODlza0pwaFRBNGMrRFhBWXBEOXNjcDZq?=
 =?utf-8?B?SGpsczQrMzQyMytvNjV1YU9QbVhZZzloTWRjVDFXZjRycnpXb0FRN3NNUXo3?=
 =?utf-8?B?MUd6QkZGeitSL0FpWkZjSEhEV0VuNi82QlV6d3ZnSGw2Qng5Y2w0K3pzT214?=
 =?utf-8?B?dUlXOERRb25BY0JwYUF5b1VnYm5Ya3hNejRwVC9pSllsS2RnU0ZvK2VyaDFE?=
 =?utf-8?B?WnUvckhZR3U3MkM2bjRQRWd0ZDRxdGE1czIzbENrdTkxQWJpR01hUkIxQnFn?=
 =?utf-8?B?N1k4N292QjR1NGZlbXRVMktGR3NReEkxdzFPc3g4YjVYRkMvNEM5UWF6RjZC?=
 =?utf-8?B?aW1qWGZCV2YxRktLMFh4ZFZaTzJQdHRXa0YySytwbnNPMG5HLzlOaWxyaXlm?=
 =?utf-8?B?Q29mZ0FsOU5mcldZTkpDUnl2ZTJjS3UwdEZEQk9wcG50NjI3ZXpoRFBsS0VV?=
 =?utf-8?B?d2tZQ2lXVFROQitlZlBRLzdWY3FqL0pKMCt1UWZaSityUnlDOW4vNWIvQ0wz?=
 =?utf-8?B?d1pqdWJwZW5KVEU1NEZoaGJPUkQ2YUUvYjVpZytxOHJEUlI4RmE1aGlkdHhT?=
 =?utf-8?B?SWkwcTVIRi8ya3J4b2k0dDFsdU41WldGQ1phcDEybzYwb1lhQXNhS1I5UXZW?=
 =?utf-8?B?Tzc4K0JBRlR5TmRPREFFdEpNSU53a3NxbVJCNHdxSzVXTWRZcHBLejlHZVdl?=
 =?utf-8?B?TmRqYnhiVEpBNlBadEl4ckFjQUU0ZjZHZUlyZk9ab2RISnRUUlBGbElSV3V0?=
 =?utf-8?B?djMvKzBab2JpNGVtSlNEYVZaSUlNSFZOdk1RbUxHWVZyeEl0UVVXaWRvWkU5?=
 =?utf-8?B?c2ZyK1JUUWRob0s0RlVyS05pbHdMRVJKUUE0ZzRNL2dNakZKdmZhKyt2NVlZ?=
 =?utf-8?B?Y2swcmhnQ3h1OUREVk5XbFVuZ2E2TDhrNVVVTlpKN0Nmd0plL1VuN2U0dDN4?=
 =?utf-8?B?ZnpYWGhUWDF3djNFemc0R29DRjFRMmhMVW90SEVhQTJCdDBRbERPVmFrZFk2?=
 =?utf-8?B?a3BxQjlnanpVa005NVFBeUVZbkRkY3ZsYmNxdE5vcytzS29xMzRjdUJtV200?=
 =?utf-8?B?NW0vWlpQQzRSRkI4bzNJNndtNDJyNStCbksxeWE2Zml3alhHbCszMHV2ekg1?=
 =?utf-8?B?eXAxcmFtOVdVY3gyTGRFK251RitGaXBNbTgvd2J5UGZrWG54ZisrWDNWZFJw?=
 =?utf-8?B?eTdKWERCSUtrWGVTanZVeTd5U3hJWmw1bXpCZ1A1L0V1T1JFNHFVREJTcHhN?=
 =?utf-8?B?cVNEeVh3cUlESzd0U08vb1dLR3VoU0pTbG5ON2RicXhxVXdNb0FTdWlGUndV?=
 =?utf-8?B?VGszUW8vdngwQmMzQTB5S0JkSGExR2JzcnZpSlYrNWNaQmpjMVdvR3ZWbmFJ?=
 =?utf-8?B?SXZHYS85WGoxNVZjUlkwQ2E1S1NqZWozODJSK2hQb21CQ0pmNG5ndVM3bE9r?=
 =?utf-8?B?d2JGSGMrbnlvcWZiYTdVdUc4OHE1ZkNrNGVBNXNjNk5DNEJGa0VrU3RSTWcw?=
 =?utf-8?B?K0txMEcrakxCWVdzV01KRlU4SWJMbFdtK2V1ekNrZ1RZdThmSWQrOEV3OUJ5?=
 =?utf-8?B?eStCRjdiSDZld2xqWFZuVGF1MG5qcGxnbExrUm8xUThiVHE5WWRKQTBzZUVC?=
 =?utf-8?B?NDdMS1I2Vkc2akhjVlJZRlpPMldCUzhJdEtIOXM4a2cva1Z2K0Y0K1c2WEVF?=
 =?utf-8?Q?rDhgNewGlHnHeKQYoyxcNgC5U2oMJSjtDnMd2uT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9613d7d-092c-4eda-1ae3-08d966253e1f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2021 11:00:39.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2uEqA07U4M4U3BINcQO/B/COQgnQC3z/pURUA/iLXyWGfLWvPdYPEoTxJjFz08R1wlMSMES+Sy90nWG418NgAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5138
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10084 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108230072
X-Proofpoint-GUID: 6oVmMh6CYPud_7M5GkhkMMyaPfS6poFt
X-Proofpoint-ORIG-GUID: 6oVmMh6CYPud_7M5GkhkMMyaPfS6poFt
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


Ping.



On 21/06/2021 23:52, Anand Jain wrote:
> David,
> 
> Ping. I can reproduce this on 5.13.0-rc6+. The patch still applies 
> conflict-free on the current misc-next as of now.
> 
> Thanks, Anand
> 
> On 04/03/2021 02:10, Anand Jain wrote:
>> Following test case reproduces lockdep warning.
>>
>> Test case:
>> DEV1=/dev/vdb
>> DEV2=/dev/vdc
>> umount /btrfs
>> run mkfs.btrfs -f $DEV1
>> run btrfstune -S 1 $DEV1
>> run mount $DEV1 /btrfs
>> run btrfs device add $DEV2 /btrfs -f
>> run umount /btrfs
>> run mount $DEV2 /btrfs
>> run umount /btrfs
>>
>> The warning claims a possible ABBA deadlock between the threads 
>> initiated by
>> [#1] btrfs device add and [#0] the mount.
>>
>> ======================================================
>> [ 540.743122] WARNING: possible circular locking dependency detected
>> [ 540.743129] 5.11.0-rc7+ #5 Not tainted
>> [ 540.743135] ------------------------------------------------------
>> [ 540.743142] mount/2515 is trying to acquire lock:
>> [ 540.743149] ffffa0c5544c2ce0 
>> (&fs_devs->device_list_mutex){+.+.}-{4:4}, at: 
>> clone_fs_devices+0x6d/0x210 [btrfs]
>> [ 540.743458] but task is already holding lock:
>> [ 540.743461] ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at: 
>> __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>> [ 540.743541] which lock already depends on the new lock.
>> [ 540.743543] the existing dependency chain (in reverse order) is:
>>
>> [ 540.743546] -> #1 (btrfs-chunk-00){++++}-{4:4}:
>> [ 540.743566] down_read_nested+0x48/0x2b0
>> [ 540.743585] __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>> [ 540.743650] btrfs_read_lock_root_node+0x70/0x200 [btrfs]
>> [ 540.743733] btrfs_search_slot+0x6c6/0xe00 [btrfs]
>> [ 540.743785] btrfs_update_device+0x83/0x260 [btrfs]
>> [ 540.743849] btrfs_finish_chunk_alloc+0x13f/0x660 [btrfs] <--- 
>> device_list_mutex
>> [ 540.743911] btrfs_create_pending_block_groups+0x18d/0x3f0 [btrfs]
>> [ 540.743982] btrfs_commit_transaction+0x86/0x1260 [btrfs]
>> [ 540.744037] btrfs_init_new_device+0x1600/0x1dd0 [btrfs]
>> [ 540.744101] btrfs_ioctl+0x1c77/0x24c0 [btrfs]
>> [ 540.744166] __x64_sys_ioctl+0xe4/0x140
>> [ 540.744170] do_syscall_64+0x4b/0x80
>> [ 540.744174] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> [ 540.744180] -> #0 (&fs_devs->device_list_mutex){+.+.}-{4:4}:
>> [ 540.744184] __lock_acquire+0x155f/0x2360
>> [ 540.744188] lock_acquire+0x10b/0x5c0
>> [ 540.744190] __mutex_lock+0xb1/0xf80
>> [ 540.744193] mutex_lock_nested+0x27/0x30
>> [ 540.744196] clone_fs_devices+0x6d/0x210 [btrfs]
>> [ 540.744270] btrfs_read_chunk_tree+0x3c7/0xbb0 [btrfs]
>> [ 540.744336] open_ctree+0xf6e/0x2074 [btrfs]
>> [ 540.744406] btrfs_mount_root.cold.72+0x16/0x127 [btrfs]
>> [ 540.744472] legacy_get_tree+0x38/0x90
>> [ 540.744475] vfs_get_tree+0x30/0x140
>> [ 540.744478] fc_mount+0x16/0x60
>> [ 540.744482] vfs_kern_mount+0x91/0x100
>> [ 540.744484] btrfs_mount+0x1e6/0x670 [btrfs]
>> [ 540.744536] legacy_get_tree+0x38/0x90
>> [ 540.744537] vfs_get_tree+0x30/0x140
>> [ 540.744539] path_mount+0x8d8/0x1070
>> [ 540.744541] do_mount+0x8d/0xc0
>> [ 540.744543] __x64_sys_mount+0x125/0x160
>> [ 540.744545] do_syscall_64+0x4b/0x80
>> [ 540.744547] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>
>> [ 540.744551] other info that might help us debug this:
>> [ 540.744552] Possible unsafe locking scenario:
>>
>> [ 540.744553] CPU0                 CPU1
>> [ 540.744554] ----                 ----
>> [ 540.744555] lock(btrfs-chunk-00);
>> [ 540.744557]                     lock(&fs_devs->device_list_mutex);
>> [ 540.744560]                     lock(btrfs-chunk-00);
>> [ 540.744562] lock(&fs_devs->device_list_mutex);
>> [ 540.744564]
>>   *** DEADLOCK ***
>>
>> [ 540.744565] 3 locks held by mount/2515:
>> [ 540.744567] #0: ffffa0c56bf7a0e0 
>> (&type->s_umount_key#42/1){+.+.}-{4:4}, at: 
>> alloc_super.isra.16+0xdf/0x450
>> [ 540.744574] #1: ffffffffc05a9628 (uuid_mutex){+.+.}-{4:4}, at: 
>> btrfs_read_chunk_tree+0x63/0xbb0 [btrfs]
>> [ 540.744640] #2: ffffa0c54a7932b8 (btrfs-chunk-00){++++}-{4:4}, at: 
>> __btrfs_tree_read_lock+0x32/0x200 [btrfs]
>> [ 540.744708]
>>   stack backtrace:
>> [ 540.744712] CPU: 2 PID: 2515 Comm: mount Not tainted 5.11.0-rc7+ #5
>>
>>
>> But the device_list_mutex in clone_fs_devices() is redundant, as 
>> explained
>> below.
>> Two threads [1]  and [2] (below) could lead to clone_fs_device().
>>
>> [1]
>> open_ctree <== mount sprout fs
>>   btrfs_read_chunk_tree()
>>    mutex_lock(&uuid_mutex) <== global lock
>>    read_one_dev()
>>     open_seed_devices()
>>      clone_fs_devices() <== seed fs_devices
>>       mutex_lock(&orig->device_list_mutex) <== seed fs_devices
>>
>> [2]
>> btrfs_init_new_device() <== sprouting
>>   mutex_lock(&uuid_mutex); <== global lock
>>   btrfs_prepare_sprout()
>>     lockdep_assert_held(&uuid_mutex)
>>     clone_fs_devices(seed_fs_device) <== seed fs_devices
>>
>> Both of these threads hold uuid_mutex which is sufficient to protect
>> getting the seed device(s) freed while we are trying to clone it for
>> sprouting [2] or mounting a sprout [1] (as above). A mounted seed
>> device can not free/write/replace because it is read-only. An unmounted
>> seed device can free by btrfs_free_stale_devices(), but it needs 
>> uuid_mutex.
>> So this patch removes the unnecessary device_list_mutex in 
>> clone_fs_devices().
>> And adds a lockdep_assert_held(&uuid_mutex) in clone_fs_devices().
>>
>> Reported-by: Su Yue <l@damenly.su>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>> v2: Remove Martin's Reported-by and Tested-by.
>>      Add Su's Reported-by.
>>      Add lockdep_assert_held check.
>>      Update the changelog, make it relevant to the current misc-next
>>
>>   fs/btrfs/volumes.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>> index bc3b33efddc5..4188edbad2ef 100644
>> --- a/fs/btrfs/volumes.c
>> +++ b/fs/btrfs/volumes.c
>> @@ -570,6 +570,8 @@ static int btrfs_free_stale_devices(const char *path,
>>       struct btrfs_device *device, *tmp_device;
>>       int ret = 0;
>> +    lockdep_assert_held(&uuid_mutex);
>> +
>>       if (path)
>>           ret = -ENOENT;
>> @@ -1000,11 +1002,12 @@ static struct btrfs_fs_devices 
>> *clone_fs_devices(struct btrfs_fs_devices *orig)
>>       struct btrfs_device *orig_dev;
>>       int ret = 0;
>> +    lockdep_assert_held(&uuid_mutex);
>> +
>>       fs_devices = alloc_fs_devices(orig->fsid, NULL);
>>       if (IS_ERR(fs_devices))
>>           return fs_devices;
>> -    mutex_lock(&orig->device_list_mutex);
>>       fs_devices->total_devices = orig->total_devices;
>>       list_for_each_entry(orig_dev, &orig->devices, dev_list) {
>> @@ -1036,10 +1039,8 @@ static struct btrfs_fs_devices 
>> *clone_fs_devices(struct btrfs_fs_devices *orig)
>>           device->fs_devices = fs_devices;
>>           fs_devices->num_devices++;
>>       }
>> -    mutex_unlock(&orig->device_list_mutex);
>>       return fs_devices;
>>   error:
>> -    mutex_unlock(&orig->device_list_mutex);
>>       free_fs_devices(fs_devices);
>>       return ERR_PTR(ret);
>>   }
>>
> 
