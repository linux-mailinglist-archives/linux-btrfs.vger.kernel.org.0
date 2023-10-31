Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2886E7DC3CE
	for <lists+linux-btrfs@lfdr.de>; Tue, 31 Oct 2023 02:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjJaBM2 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 21:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaBM1 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 21:12:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C6BD3
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 18:12:24 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39UMxGc7011946;
        Tue, 31 Oct 2023 01:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vSGBsNdU9tgJghu6GNpuCIYle72mM1UdiH3dMQAGdy4=;
 b=KbrPomdzBUI03cIiabNYpV8jVeOgkwYFljjL1/S2G5QCrUJZE415PrNL410fLEU0haHG
 ElpaYAhv32m5cag7o5QCPDvlbfI14RPSc6lPULpcoutfY2WbR9sZUhwEox1CuGGRocqD
 bYBryeMR3jhSWjVBE8BZveRZIGTIEsI27s0ogAbshfzgjy49WfFIal71yg5gy9VPNEKR
 MpUqbpMGPP7b9rYGWyVR0qoIbAnKuEfYyoNq0bI81md7Yg4mhRWWZ4K3ifW7tC/6CbwK
 yLhYi3LIMjl/53MAMCGmHEHYZWvqjtbAm6mQJ5ZNMZVZqS/kdCbVzfqi7WvZZqCdC02c nw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3u0rw24149-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 01:12:21 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39V0Aolm009110;
        Tue, 31 Oct 2023 01:12:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3u14x4w7f9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 01:12:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xd6mXDmzxyng0T1PZxy8aqJMHSvE5GsjcQoDwmYisJGge7EVPyVrOc53duRzds4eld04S1KXFkTM2LsXFJG3DLPNLd6HUUMKFaglu70xO7OhOeejo/1imrOSsDb+fcP8YKQef41OTxXqWB1R12XPhmV6/W6n/N+MVGCzgUEyPcj92zK28EqRoiZ0+buKyhay3/l3KuOEGmrVOk4rYhmKaam3RDRCi/m7IeT/CkbEJnhafGOOd+oJxbHK8dgAcHLkeyn0oiiAPTMVlj36r1ngDtU51C5DPbn4OjvIIIn4RXJi9GWGpG/LbvoBEX9fq6PYxdEEb2/W4/KgY9vKAsmZ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSGBsNdU9tgJghu6GNpuCIYle72mM1UdiH3dMQAGdy4=;
 b=GqI7Opc+MKSGtzCSL2TApbtTB0q8D3Ue0mHPlBNOp9XV+0gfgoyWnMypTdDyvzErQuJnIyrL3QWGqNyZBVS1YPtQa5qhwBkhsWdOpyoNgdkYLmCPthgNE3H47VjFvVwmkxoKl4vs492GsMlt7KFyOLcqs7afwzo39duQ7o3D8W1W3AAO33PGcR3KkhlXbvNW+tKVC+c4T+W+KSO7tVdyULhsL1eX0RQg4w6xoBDiAoTgFDR0mwTmPZU5by+hxJ+tL4GPIuvq3GgSewdCG9aR71QXQtw7oc31fF+BTFct6c4e86JpEz+Ncc8z9/k0XpOVZ9NHOSoaP0pvDEzPgcaFQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSGBsNdU9tgJghu6GNpuCIYle72mM1UdiH3dMQAGdy4=;
 b=NfH2eF1aVHvuP0ikT2ZJVETtzCSXPFr87JJ9Q9sVub96v+MBhxxhsssT2zgLRezpr8w+zVo6x+37ZO8B5atcb5zK/l6WLY362zlpZjsJiLWL7kV+/X3/WBXdlXgjeifL4PGLdkPoUNmUR8Ap7whR671FnRDPa4gW/pg3XWWFvXQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CYYPR10MB7627.namprd10.prod.outlook.com (2603:10b6:930:be::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 31 Oct
 2023 01:12:19 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::8732:b8be:e262:1fb%4]) with mapi id 15.20.6933.029; Tue, 31 Oct 2023
 01:12:18 +0000
Message-ID: <90389e48-1ce6-478d-8cb9-ec365fbea9d1@oracle.com>
Date:   Tue, 31 Oct 2023 09:12:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs: fix error pointer dereference after failure to
 allocate fs devices
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <86c522f5e01e438b4a9cc16a0bda87a207d744e6.1698666319.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <86c522f5e01e438b4a9cc16a0bda87a207d744e6.1698666319.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0080.apcprd02.prod.outlook.com
 (2603:1096:4:90::20) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CYYPR10MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e33ada-ecaf-4b2d-e8a6-08dbd9ae6d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tDw63o6kGtJp/v0McLxUBd6fx5k+Xs7K9SCgfV76uBNWyZjdjWSQs4oJpXF8eEmZZOs6ME7GWaw9juL5AiOlhb3AfJ543mB8oAinKaePpNxql1jAHqhKw1T8fXIWhS1rFOhnURfhjbItQ0HBouvit45YZKZTO+8Wg9xm5HSITjEyzIGRrDNxsc09ezu/dx4ODPMIuhU93LhglTg/xOOM24NEMfbAUAuDUx6RszWZw0zQdojf+vuJiQWQmUKGNxDggqV7qifAfnlXLFAkA8dn3hMNsGeE528zBdYFWpzugGV9yu1Po1g4oIa56ANTnrJyGF8M1TOTv2Y2vGZW6KNWjlejoKSEYQ4/9sw1yP9rKcx4DYFflmTSeGpWB80qZn7UVY0cH+sKyFYxsQpkpfy+ZOF2WCnfhb4uvXdOS9U1N3I5SZrfhu8qvpKo3DPXOGDI86Nk6JAiNQs1/3ji88GFkO3/tLq9WXv51ALP863YF2Dr/kQsuSq9vGHqXLpY8CcE21Z4NG4CsLrFaZl0pMjpqTE12mSAFK+AbmvoWgkaBRKd9vTe65wxXqHHEnI+eA0p0tk9edJthuoTbYM7S+RjjSkm2SfHxzPCqYR+c94E17OuRapfPdveiLDhiOm+WV+Mev9WZuxd7lYTDTmc2dndMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(38100700002)(83380400001)(2906002)(8936002)(8676002)(44832011)(6486002)(41300700001)(53546011)(31696002)(31686004)(5660300002)(316002)(6512007)(26005)(478600001)(6506007)(6666004)(66476007)(2616005)(86362001)(36756003)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFU5b0ZFQjg1ajErbWs5enVGMVg3RU1JWXJmMGRFSjBBelJlUDd6SjBUdURL?=
 =?utf-8?B?Yk5aZ1dVVEdDREhMdGxnMzBZWmxMSFNPL0JTa2tQYklqenlKckl3Y1dYY2dY?=
 =?utf-8?B?d04wR0hTUnhqZ1ZpOTlnTlhIL0hybFZlb3hES2I5NWJVeEZJTC9sSHB1eS9r?=
 =?utf-8?B?WTRpdUJjZk5VYk5xUmUzNlNmRFViYmhPcTc0cUQ2VStvOE1GekZVNnpNcnJw?=
 =?utf-8?B?L2F5RFpxWUYrMFBkekFvdkttVGtYRDBVT2hybThMZU5ETXBOSzdUbERzV1Ew?=
 =?utf-8?B?dEs1WUxyYlR5RW5JeTBPbTJ1SlhQbFE3L2N6SExWd0RURGMrQUprb20vNHdD?=
 =?utf-8?B?UUE2VmMwOHN4RWEwemRWWWNZOURBVkVUcm1LSUduQWhaOHFiRkFXN1pWQWdy?=
 =?utf-8?B?Q0IvNVFPZWQ2TTBrekFESlovaTNwcTMycStzS3VZNVI2L05uckFVUmJVOFdR?=
 =?utf-8?B?L0JXZ2NPc1pDMXBrSHY4R29LNExwNVZpYVdIMnh0d0dtTzdLSDU4aGNvMnVo?=
 =?utf-8?B?T0JLemhsdHlpZVBrL3oxdHFNc1hIRnc5VU5LeVFMYjBDdHZzbURaQWhxNHJi?=
 =?utf-8?B?c2FIc0RZdTlFSS9HUGhhVEpZdmFXS3YwaE1LMm03RUdqckRMblZkc01ZSXdr?=
 =?utf-8?B?S0lHZThBL1NobFlCZzdpc1hyUXQ5cHQ0MDZyTDc1U3ZuWTRmV3ZFVVlLYi94?=
 =?utf-8?B?dFoxODZyWWlIbkJSSWFsSlRvTDNjTklsbXdYVk9ZZTVPbkZJalh2bVV5cFhi?=
 =?utf-8?B?dWdDbW1laVkrdlBvZnlldGw5UmVXRHRqRThBS0h5bXRjWUNkdEYrVEpNUDVo?=
 =?utf-8?B?WlhCQkN5VHFLYWp0QkdnS1hLV0ltRlVUNSszVzV0QkliSGlJaWhKQVM1TDc4?=
 =?utf-8?B?d0RmbjdPdzFlWlJ5cUl4WnJVYlhrTk9lRUVtVm5rNDZDZlJGVVRNcTRkdW9B?=
 =?utf-8?B?UXo3RHY2TTNlVThCUDM2ODFkMThJVjJndHJGVXZSa2dKalVMcU5za1RBVmhX?=
 =?utf-8?B?QnE2cXc1OTNvKzZYbkY2V2hhQUI2SHg1Z1FTOVh5ZitwcUd2R3ZHYWw5ZUhh?=
 =?utf-8?B?bzlIemorekU5ZWJIbGFicWtpS1FkQlBUNXZrdHE0RjBmYXhKNnMzWXdRWnpX?=
 =?utf-8?B?ODU2VFhBZjVweDQ5aEhoR0t3VllSVE9iYnNwTGtLQnhZc0F6clVHQ0t0VUQr?=
 =?utf-8?B?WU94T0M4SU4ycUJJQzJDK3grU0hGeVFsYWxXSGNwcTBoU0VLc1N3enFTckVw?=
 =?utf-8?B?dk9OZGNMZzk3SXZ4TGVzSHIzZUxOK0JjUG1SZmRObWt6aGdrNTN6V0ZZT0pa?=
 =?utf-8?B?QzBQMG92R0lNWjR6djNqd09PekViS2NJdTdsVHg4QkJpM3lHdjl5OFVrTm1q?=
 =?utf-8?B?Vk1oalpmbXpFc2VVMmtlNk5CZkY5U3ZkOC81ZFhnd0dKcUNOTHQvcnV6dkQv?=
 =?utf-8?B?eXEwZVVIZyt0NlB2bHpzYWxwOVNoWFZRVmk4ZGNWRmNQSjRsWDBkLytXOFRY?=
 =?utf-8?B?aktFTHpiNWVxcXB3WGVPL3pWV3U3ZWU5RExENkoyZlpQeExnTk9VL3Z3QVA4?=
 =?utf-8?B?Y1VZSU90NnMva21DU2RSbXVIQ09DU3JOaHRRS1o5OTRWb0FsMmZTWGxYejJ3?=
 =?utf-8?B?RTg1NGdKVUI2U1lXbGZuTUgrUkw1TDZyYmkwa1JJa2g4V2ppMVcwWU9MTkM5?=
 =?utf-8?B?dVFLY1BUUzY0YnQyVVNFdVFmeXJOaXNzc1FMMFM5MlcyK2dIcTcwQjM2ZDY0?=
 =?utf-8?B?WUZtUUw3SjNpdnlQQ2hLbjF1bE1FNnZDekZiUDdTNjlLK0hxdkMvWkt1bE0r?=
 =?utf-8?B?dmV2SGVNWHBVTGM0TjNWc3FXa2E2elRJSTQxM1ZSWWV5S2xRMkg1ZkdwT0tX?=
 =?utf-8?B?U2IwT0t2ZWtoWWoyWXNUbTAzSWZmS3hnNXpjekM5d2svcko4QW5kMFdBTHJp?=
 =?utf-8?B?NEFxTGpxTEtqMjNJdXlOTXlKUGpQUFpyYmpkWmhiNzZQeTVqOXl5SDVYQ2Fl?=
 =?utf-8?B?V1RQb1pxZnhxQ0lzdHZsNm05RHZJZXVzMnB4RDNnWWdIV3Z5Y2s2YVBPOERp?=
 =?utf-8?B?YmRMbWZjcEJZbDh0b1B1c0wzYU9Ra3hVM09tL2hLdVc5Y3dFOHhySTUwSWd4?=
 =?utf-8?B?K0UwSHc3Z1l2RWpLQ2IwTHFJeURkZVRKa0JsZ1dNYmozUUtobm5EN2l4T3JR?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: aUMPqTi/vBrrNeKzM2uwhPT/+96t8rDGzmNwYo39hZfq1/xa63jDOFV/Qwgd4503GhlXLFsd39F31OJnEsFZxvksAzw4y8VUGSvDfL7LNKZBrE6pa/b7mZpCjNlVmU1S5ULrRy2ap9qdkEKiQg09sLES8sYSwyTFqNo5yIYm1dx5vRGjLZ9vwShCzbJTzysEXkxm+J0eeY5EvSNChPsTurU7r/zRY1ugCNCppFkt1v3L9dhm0+XAF0MvNXh09YtFo660Ac9tKxp/YiAP0xoj+w4IJKMPC257oX2jUx/1UwmIz/O8X44h57a8NRis28mQ9UOv7t0dNILTTlM+1GMQpS4BDhwGUPKZlbJOvmRrunaZSqNvGJiA+1+pm6aMCKHZo6cnL7jRtZhi3uqf5bxO2OWpGHlfpb6m6Dxdo7H/qLbws/udMY0OX6hxfPNnuUHtFY/xGvILKl+jl5UtZVVC5kfoCR8zfqUSK23RVwfsNYrSNLu90vyqhSlGqQyP3ZjHPZH0wbmKcPY8dNUuwbIg8hdHVeKXKtQUPiJzTsPqAElVlhGl21BYOGUKYJXLV+gu6RpqXQdFobL0uy+GQ4hOBLLmvBXihQPDnLpjtQiLRloazEJfxtGhbHXSQM/CVfV56X5m8T/2jBc/gs/qAKsaAl5mPp8Ls83nx9+Jmk0ER9WEl1uKDcQJVzZ67+z31tHo/eH7hO4hgni63L8UtL4nXSQm8hULp2qW1bo8Z2Py+dNPjsmyBRUtfK/BgNL4iiusMBtsvo/yTqHjUGZx15VSONLRTrpRpEQtm1z/jmCm/I0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e33ada-ecaf-4b2d-e8a6-08dbd9ae6d33
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2023 01:12:18.6130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hMwwiOArIzX2vPkQ+FC9Sz3NgrAlfl+H5ulIYn1xgC4EijUvYRJyCBj/2iWvBs84CdGVPUPQ3xYYdd+f21dWYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7627
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310310008
X-Proofpoint-GUID: lV1-8MFb6EKiX1N7LmPXYaOr4QlScZlo
X-Proofpoint-ORIG-GUID: lV1-8MFb6EKiX1N7LmPXYaOr4QlScZlo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/30/23 19:54, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> At device_list_add() we allocate a btrfs_fs_devices structure and then
> before checking if the allocation failed (pointer is ERR_PTR(-ENOMEM)),
> we dereference the error pointer in a memcpy() argument if the feature
> BTRFS_FEATURE_INCOMPAT_METADATA_UUID is enabled.
> Fix this by checking for an allocation error before trying the memcpy().
> 
> Fixes: f7361d8c3fc3 ("btrfs: sipmlify uuid parameters of alloc_fs_devices()")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/volumes.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 1fdfa9153e30..dd279241f78c 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -746,13 +746,13 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   
>   	if (!fs_devices) {
>   		fs_devices = alloc_fs_devices(disk_super->fsid);
> +		if (IS_ERR(fs_devices))
> +			return ERR_CAST(fs_devices);
> +
>   		if (has_metadata_uuid)
>   			memcpy(fs_devices->metadata_uuid,
>   			       disk_super->metadata_uuid, BTRFS_FSID_SIZE);
>   
> -		if (IS_ERR(fs_devices))
> -			return ERR_CAST(fs_devices);
> -

Aiyo!

Thank you for the fix. How were you able to identify this issue?

Reviewed-by: Anand Jain <anand.jain@oracle.com>



>   		if (same_fsid_diff_dev) {
>   			generate_random_uuid(fs_devices->fsid);
>   			fs_devices->temp_fsid = true;

