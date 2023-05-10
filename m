Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEE56FDDA5
	for <lists+linux-btrfs@lfdr.de>; Wed, 10 May 2023 14:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbjEJMWV (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 10 May 2023 08:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236593AbjEJMWU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 10 May 2023 08:22:20 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5CA1BD;
        Wed, 10 May 2023 05:22:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AA2w8B008601;
        Wed, 10 May 2023 12:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=jFH8eJ+iCMdIZnosqplx1o+DCKaf8O7fmQlANCdcFqY=;
 b=ZJJNBhSKrVDdvHpKiQZi1OYk+PvO4ESSN7WSXzi0JWOja7uQxv6iQL9YJIHYAIauiVqp
 xFQDof+Dm64+4wLt4S7RABMtRQekl6uym61hJo1yV7XS6+SPWKTGfPDUSVN9XcH5TTfT
 gFG4ncgsFCxBrrtv//xjSR4lwbxgAHZMzr5bSHl2WGP3yQQM/un8nQpImegdnxmVGQtQ
 wrqEF92lE+I4PVxgKCzU3N8bNX2k24mRQk49rq4Z1vbf224U39k3WtUt0qm3Wa/iw+k1
 MO3Ij1aJpOnvVBTIm4hb3blqz34j03rzM9orReyDnwVpqL0lGBE5lGxragYs6xNBzlSq Cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7774dgq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 12:22:14 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ABreAG002074;
        Wed, 10 May 2023 12:22:13 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pjgxc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 12:22:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PtwbhclPvBubnf19b3GsytdFsDJLfu69KQRvGYFgA+o0ONpyhVxb03ZtmzFqafnV4wg0isAT1RJ8JX+3cdQpIhaDJ8/3v59q5zQvGiarM8i6xzaoX86YZhJPG5DcYX8Npf9Qf7ZpNTxCeO5IBXX4swEQ+L+JX7gcSW+3LvkCZ+uDj9TdmdoPy9HE9CSA3yMoHbO59NzlfdL2q6O75VvWtotlFHmQG3f+DiYOQG1oOo/9CD+lnz8ZCIJ2xxTZTJl3ALa82LSA1YqLF3JpPVWu+3pv1xnT5P70/EK/LXHdN3Wu5ovzc9GNLy3png29U6Pl8mIqCvDm/Xi6vs/qLHxC0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFH8eJ+iCMdIZnosqplx1o+DCKaf8O7fmQlANCdcFqY=;
 b=k1VLzPfoTuZ7fCh2xMr1DZYz4xXX26L/aav0B3m4+d3MfO18oE0ox8+7BtEpjAo/x8XkJ0mXwA2+TfBpzmyJJE4yjuQywcfGEfcjAx4SnuIJm4tEL3zHn5dXPJtRxp20sKUpYWwH/By65CKZLCGcncnOMEF+gdxuFcjUUwTwzYmfdH2/wUijUoqhDf7sYhQOVVIpiePht7k2/6pOGaDR3/52lNl1ZMsxebbXpnJ+hOJrrKv9zhq7hAmSza7l+W5ZalUWdcHA+GcZsgSix3s6WfI58UUMbFc8gqHQo0Umd/+3gp0UO859Okt7tY72Xyt2UeIRjH7XwkKqW3OpLpVRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFH8eJ+iCMdIZnosqplx1o+DCKaf8O7fmQlANCdcFqY=;
 b=OwgtdLpkcQ7l8uh7i6JcRvPCXHpvwAJsnjHzsO79dSmWqUQ9E03QRPzw3Yw82oPtZHJFBll3sBPELfC+bNU9cQHwnZT22n8JGndds9ZmkjxwgQ4/DwQgKcCmYfs8p0E8kSwk28EBSSfamR/8QkNVUBHbiXzRnRNpnTe4tYbpY+g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA2PR10MB4602.namprd10.prod.outlook.com (2603:10b6:806:f8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Wed, 10 May
 2023 12:22:12 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%6]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 12:22:12 +0000
Message-ID: <baf6b593-c3f9-47fa-a6eb-df18a639596b@oracle.com>
Date:   Wed, 10 May 2023 20:22:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] btrfs/228: sync filesystem after creating subvolume
To:     fdmanana@kernel.org, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <6553d98ab74fe2fd627749f368d9623a0b12ee4f.1683716041.git.fdmanana@suse.com>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6553d98ab74fe2fd627749f368d9623a0b12ee4f.1683716041.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0123.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::27) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA2PR10MB4602:EE_
X-MS-Office365-Filtering-Correlation-Id: 0617e364-92e1-4fbe-b1fe-08db51512e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6EdyWBIkRrLjQrFq0vK/3PM0HSrpCB1qnLR4tLsFicmDapP32Ha78U2Oqomw+Usvgq+vDnMRuJ015ZzOYfmc1c1hoFa6uYCLIFGIPFlmMb3j1rhlwrjDsdWfjIxbvLx+XDUnObqnr4VnNKdpN0B6IVOL/XXxY182Vs8mGln98QTG1CUVd5gpa2AIoTRftakiFPkKpm+S/NUFr8bv2frULuurPBIXMFN9rfgRkEcR+Co4CiVHttMlBVMPWIt/D9wNYgJJ05iwP12ZT5afUDsPG1TKD6JHOuxbsxfd5YZMeuv6X1jxz9iu9YklLmVYxU4vTyAaQc5QcWXSTFvUcJqxMACBoPLk+n1/Ucj0bmxM0zImgbzKKcZ3Ze7id1L5dO8FY2MhG6WnLB+aBseBX/CfvLLETJcpexKZViJuTZGcv2boTgTEt2DiGNVUD6bRQg9V+W+S6+YL4bCLnBlNzGU5CvWK9ilQPzTBuPat39SIEO5QACzXoM2OmWCk/vCPK0c4lX9kYCa8OXUVz11BS37+/idiN5vf+nivHLTU1XHLPJQN1Nf8RZzBrf83cnZs96uWIDanCa7vtNDRK3VknyGS1iehIPFssHB8+rGLX9sqy3M/U2vHu67Lbkbz0vESrDmQHPe17ndHE4IkbnVgoOlRMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199021)(6486002)(4744005)(31686004)(316002)(36756003)(5660300002)(186003)(66476007)(4326008)(66946007)(66556008)(2906002)(41300700001)(6666004)(86362001)(31696002)(38100700002)(6506007)(6512007)(26005)(2616005)(8936002)(8676002)(44832011)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck1aVmdzMzFyUVhxeWx2Qng3UlRQSHdnOG5jZUNwNktjRDYzYzMrZjdLcGN3?=
 =?utf-8?B?aWRlY3k3R1JCSmJONUpSTGpZajZSc3ZGT0dwVUdOaXQvVzhBbnpkbUpBbXpY?=
 =?utf-8?B?cXBVblM5eTNaZnMwSEdQc2lseENFWnYrc2NKclgvZG5hOG9DaWRHdjdtNEg2?=
 =?utf-8?B?NTBPcmxoUmV2eU5FaWFwdzJsQjlvTzB2WVQ5YTQ1K3NxVUFlek1wUWpERHNa?=
 =?utf-8?B?OVp2OUZhVkp6ZEdFdGpZLzRUVmZUZzVXb3ZHTXJybW84aWtFSGlXMm1FRWdr?=
 =?utf-8?B?U1k1MXl2R243S2M2QktCRDlRVDRzdXBXVDgzcGRvMTd6cFI2d0traFhOdVV5?=
 =?utf-8?B?ZE1kUXFaeWJQZFZMNUFhaysrWUNycTF3L1YxMnE3bUsxUlZUQ2t1LzVKb3FE?=
 =?utf-8?B?RVlEbWFjWXNZaGNxZzhpalJzdGNOZVNrVEpBWUhNU2FzVU5oZW83a0UxeUR4?=
 =?utf-8?B?alJpa3pJR0V2V1RRaGdGYzFQM2tvaDVhTkh5QVdlUmhzVUVnZ1VubWFkdU1a?=
 =?utf-8?B?NVNia29uYUdMa1lraUQyUHYyZ1FrQWdxQTBkOXBkb2xSaVBSWDExR0hvUGw3?=
 =?utf-8?B?YnhJVGlsZVhhTWp5ZHdpTFkyRnlEOVFwZjdvd21MTjZlZERiTW9GQTd4Ly9D?=
 =?utf-8?B?N2RIWE1HYVNEWDRIZUw1bHdjSmFITVBnYTZzRjFJVE1XUE8vSWVCSTdzejNk?=
 =?utf-8?B?dGg1SENTWHMzMTY5UmdrRTNVeng5YitQS09SRmhaQzZ1dGlDMlhabUJzSkJM?=
 =?utf-8?B?OW1IMldUYk1mK2Z3TnlvZ1o4R0xvbyt6S25kYXJrcTlOb1FpZlRRS08zeXF3?=
 =?utf-8?B?UHhQN3kzSXduTmdTNzFmYmF6ZFBCK0lVZ3k3MkVCNlBkRDdTY1lMM0huZGN4?=
 =?utf-8?B?WnA1WWRmeDRtRmdQV3JNeHFIL0JadlJvSmIxL0NrS094NU5SSExGMjlvcTdH?=
 =?utf-8?B?b1BjMzgzZ2ROQmFxQXhiRGRJODJEOWFSc0FvRkxoV3kvcWdEQ0JueGNmeDhH?=
 =?utf-8?B?VDNLN0lsTDJWL05nYVhtTXNaN050NlFMeEVaL0FqT2dqNGtGeVdqSHNBMENa?=
 =?utf-8?B?L1I1RC91ZkE5Tkg3NjBxL2sxb0Y0aHZKS3gza0hSSmlncXFmTTlkZElvVWJ3?=
 =?utf-8?B?WDJaUTRJZitHTEp5TFhUNjhUTVBXaml1Wm1sMUhYRW1yendJeVg3ekhsVXlU?=
 =?utf-8?B?MzRRcDVkZ1NUVmR1RFBUZml3c0dNT3YrMzFDT25BMFNWVk9XRTRLOGN6Rldq?=
 =?utf-8?B?dlN5YjZRS252aFRCMUdRM2xJYk42b0VtRW5yRWhjSGpXN0xyVkwrRUNHTXNk?=
 =?utf-8?B?aTRGdjBZb1J3QW5xWFI3M2NzMVM4QlVneXhtNXRqRmVBTU50dHpTV2YySVo3?=
 =?utf-8?B?T3JUWnVGTVdqdy9vdldTdmhzWUxFWFEyYjVrekVqNVFZa0dmcm83MisyeFZG?=
 =?utf-8?B?d1I4a1p6R3k1dCthN2VLUkt1d3BpY2dnZ0FDZ2hiejREZ0l6dmpNaWlkcGQx?=
 =?utf-8?B?MDlsR2FUTS9ZOUxMYUpmN0xhTE1vUDFZRTk4UkJGcXQ5TVpxWnppQkJsRGJo?=
 =?utf-8?B?akNOTXpGd1l4OVRyejlzdllNVmNjem1jMlBJM2ZRdTE3UkdNVzhsTmZoWE5Y?=
 =?utf-8?B?SzFERTRyTzJXTlRha0FHRk9pWGp6WC9SVzVpVW1ZK1ZER1JoMzRlZkwvWGNN?=
 =?utf-8?B?ZytUbEFBQXRBWSticzlYUEFyUDQ1Slo3SWxJazlFN2RjV095cXlkYmRGSkZ3?=
 =?utf-8?B?OVI3Tm9pUzhpQkZlN3RyRGZGNkhFeWdhM082dUVTaDBoZ1F6TE0zZ3MzcTZj?=
 =?utf-8?B?ZWdYMFNleG1LbHRUV3hxT2UyQXZYK2FYbitUZjNubkxzcFU1RGZlUzdxV3px?=
 =?utf-8?B?VUpPeHY2MzZRb1NkeE9UZG9XL0RIamMzbHZRTFIwMm9LUVY5Tm9vc3g4OTVi?=
 =?utf-8?B?VWhYNXNQSWJKckYwUWV6RExJa3ZCYVpYa1ZHV0NTeTdRQzI4dHZ4VXlpa3d2?=
 =?utf-8?B?bjE5ZzVIR3NHOWF1ZUhyazdIZGx0UzFXOXVLL2N5ci9vcUltdDQwSVo0cXhy?=
 =?utf-8?B?WVJLVUE4TUQ0TzN6WEdEcUMvYnZXTmZOOTF3ajhCNTFONE5rMzB4NVZDRzVl?=
 =?utf-8?Q?13C11ugdqL1brzghdCSV92Dhf?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UkSQMhfVdySHhdPL8/pYZtnu804eILhDxr9tcKRMCDne1rTpzUK1mFF6MP87QIXKbLy3sRXlxNLq96w0HIydzqZ1cKeZuOy0DMQXHzTJDNEWmahsUwH53ajg77MvSO22tQKtb5Mlg8mXPes7sbRNy9CQJM5dLyXwR7K8Z9KlMnwnseY1HS1lFTgWFd9MNoqw0Q/Dw6ikQkRuP9Z+NIifLxbAOqoh1wR1SZ4ymf3o45yR1h3DjP4rK8HSJLVVBED+/e/sYWKef6qkFhAeGpMxV4dI4BvEGv+do0hl9fL2UboKCD5b63T6vZFW9pT61Yh8EUUoHxtWxzcqK+f99HqIGYksvm0mDiVs9u7zf5/DuSsFQfIEDkA4f7qOCHvb05QBqG1zCz5O5q93eqcUB6bj0sDfaeJs/whYI4R5qdtGBIMXMJFJpB7rrV9+mUjf4P3QGSVGFeRDOLKn6oJerY/y0qIgZDbTuUdRVK1MveZS899XyF0cTL/WGP12KmgAdrZL5y9wHTv82sgD0Ayc7ZmA4licSWFYp1j2nq3mxd0GthiLT50eJTlrWQ3G58k24inI36CU47OkxS+3311OVrdgnYYdnVyQwy5wfAUgD8ItJh1nrHF+in3HfyMhk+THRIVXBD2juBZYOhBk3qm5Vx5RZ3wFJIw3kgwJgGcVGu5FSvIYvmvKYSiyCX73m+0vgyLx9Iuqj8O2skej6nHPJgG7H2eyG2xdu4PdzkLLj6Lanxyc8WYkJktJHTo4WClNvjpUCPmRp/mnWxorvOjRByL0nVdUWA9DmmaCZvJoMP7uGX3YzoCi9JqvSrN1QOD4gLi7
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0617e364-92e1-4fbe-b1fe-08db51512e69
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 12:22:11.9784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z80btdqrtWV0xswBpvzAKwXYaVwJpDm5xQMfbfSZsI1523lyGrPhB5y5DgGiZCl+jk45oinY3YEq3J4L3v1JHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4602
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305100097
X-Proofpoint-GUID: 1vfilQbuOf_CXBQ1lUTkWuDJggHvvgoh
X-Proofpoint-ORIG-GUID: 1vfilQbuOf_CXBQ1lUTkWuDJggHvvgoh
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


> +# Subvolume creation used to commit the transaction used to create it, but after
> +# the patch "btrfs: don't commit transaction for every subvol create", that
> +# changed, so sync the fs to commit any open transaction.
> +$BTRFS_UTIL_PROG filesystem sync $SCRATCH_MNT
> +
>   $BTRFS_UTIL_PROG inspect-internal dump-tree -t1 $SCRATCH_DEV \
>   	| grep -q "256 ROOT_ITEM"  ||	_fail "First subvol with id 256 doesn't exist"
>   

Oh yes. Nice catch.

Reviewed-by: Anand Jain <anand.jain@oracle.com>

Thanks
