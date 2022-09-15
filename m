Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AA05B9990
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIOL2a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 07:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiIOL21 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 07:28:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752C58B2D4
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 04:28:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FB1r5J009352;
        Thu, 15 Sep 2022 11:28:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CDUx4AKgZc9cJ3EIvY3qoK4mDY1BUZUUwjkymzwkugQ=;
 b=ODAWzoCDkc1tWZ/ovB74yGE2dEQ3yDEBznFhmtTynZcKA4n0lFXsd3oSMxuJc0Qv9HkL
 P/fHtAjj+EpwhsvsdmhmPt+LvJyqKIOGp2HUMEYK35Zcj4C88ee8Ve+Uxk++1ZtTSuGW
 QwFY7xcyZOemH/gdP9+R/WtmQw3tiiK6PbJ9qrJx1Xny0wXdK9xvok6Vf3K456lEu7KR
 kRJ4daMbk4XGc+/EEPsPYpXZhTdcbSMyhmOfTXOsbGJ/IhFiaIRqYlVEcYPqsUxJgoVx
 FrIbL8fHlWtREChbU7xGeE+hJzbYLevDM3+CysotFW0EKfEYJXMtQfQgycLxkQuJanSZ IQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxydvxyh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 11:28:21 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28FB6fLL002769;
        Thu, 15 Sep 2022 11:28:20 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyejkaxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 11:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4/pNlCz8JCppP0uOplxVBEVjFUtpax6BHqPaQC/AzmUXK4nEWJPu0xegwPkv3x9iJkKY5k7HnICRo9dRD3D2PtGUvWomrVWHwCCHVQUmWHuOo4IQ4AIJxywa2MfsFFQ5PL44m0LpECVKtSCb2XrQRxEeb3qabGzGv72pQcAhzql0bwl/wrpagmfTpd9Ty15QKo3tptNFCwDwEb8G4xkqDIsz2mgoykQtKlb4nPA0XuG6Ba5Yf8v23Ks1dL9HmWuDcbk7je4to9FGearCXg52MwLOCZX5RH8L95DTvyJjxDFGAjCzcLpuhaM/RUH1Q76YPaHW4cpwAI+bhsdrZfJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDUx4AKgZc9cJ3EIvY3qoK4mDY1BUZUUwjkymzwkugQ=;
 b=AzPmF69zI6OY1SUaXdHecE2TvyFgbp58fMpk51h9Q6mLvCVkXMjZW3mcA4IoM2Id1pTwB2ophNcK1CPpPW8nSYrytZGEY0G/L7A54vQfIuaugUKgId3U4ml4SSOwPTd7PxXuTWJI0sIVPjnWs0Yn4nhfStEU6YyUYMmpOHnHG2k6E5NtcI7uFBSvwsUGbUtTT2olSuTnj5DpNxUntezaUTUeYqAUSmrw57QkEuQ41msf4dw/gmNEZFWC1SCx1zAU270Lfk1FuGWtQgYEk0N3jhoblIGERMmgurHVFxPGOo03Pul01Idpw/H3Di6jOlW5X6CIniakC7uwj37xJI3RCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDUx4AKgZc9cJ3EIvY3qoK4mDY1BUZUUwjkymzwkugQ=;
 b=kK/ek0Ftk1RrLViepf2MJgm9AxFQdlo9PzcM55KtlgFwyZ0xz+Ti+pypD/ynIhNMENiDwqHdb0dpNQqJ3+PSQZAzHAYxtaISKSKbrf96m0MO50a4eQdAZygvFFncEKtHJY0ZBxgeIvE8MIts3e3eUJubkEyJnuEZH6yqeMPC76g=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SA1PR10MB6367.namprd10.prod.outlook.com (2603:10b6:806:257::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 11:28:17 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 11:28:17 +0000
Message-ID: <b7b4ddb8-b484-8bb4-a193-b44acb694b07@oracle.com>
Date:   Thu, 15 Sep 2022 19:28:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 10/15] btrfs: move the fs_info related helpers closer to
 fs_info in ctree.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <40ff0ebb4b409b881b7e4cd2e051b07acb05ff40.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <40ff0ebb4b409b881b7e4cd2e051b07acb05ff40.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|SA1PR10MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 3376516b-393d-455a-0323-08da970d6249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hrr6s47ib66xlzhEGc0Geg8UQAe2JJPFKtOI1ERA8pSEN7DpEjFIVylhYxBa0xRQ8NzB2oVGfKOLeCdbXcgHxEFL4enRepRPzmIKl3NQ+ZUdM6yofZojs+IzvzxHXT7TVBLNQouPg2byMFRqKWBef3WM+tlBMtl+EOS1vXwiXmsYNGfAOkGe3m1hXSlSU40wPnExXSJgTPaGdfOtp2PRr9wAtIPCKrMLglOVEWuwtD4xaJ0eKsbcjRQ1h0tWgPm6o+orK8oCow/l7UA+MF15Qo41azF07hFnyPDeg72x46VCFqajq8u+OT5Xn12Q1p8k7sJlAIqLj/0J0tLVNUka0LTn/rl2ILK1VxwClWdfKqwhN0iFZIH7RUYMoMeHFspvkPWcRRlh0RwseQfbjgTHHMHt2IUjCNRQ//aaMnk1HE0M0dTDZuoITJjDcNG7NMFJzaz31MMpOfqmoX+1roRFMfG0pEILFQKq3vUqnybQDD/aDLscjJS1TuGHlQcUFA1WgxVRI/v73eT8WkRvFtctRFvXRAYIltfsorh/IjPd+idZwnKVWyj/mztiAbM9xWZbAP4hZ7sBFVqhbfQibTR25TXzu4d6qM5ec+sEbTISBvUYCK4GELnbKB3RrqW+di6uh2qFi6QUqLcF3+rfoVYAnR2xpE/4e1HRLZN+36PRroUrBRiLCGCA5re5XvLCbQbmT61Y5m6wO8SGO27d5I/uVj+jCkhVBO3nRqjla0//zQ0z6P6akyrFF/5IYj3aFeIApe4HfXzRYxAilSL5n/wyoBjWIXr0sI78HhgEd71yJf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(346002)(39860400002)(376002)(396003)(451199015)(41300700001)(44832011)(8936002)(4744005)(5660300002)(53546011)(31686004)(38100700002)(6666004)(86362001)(31696002)(26005)(8676002)(66476007)(316002)(6506007)(6512007)(66946007)(6486002)(36756003)(478600001)(2616005)(66556008)(186003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a25OT1M5VlFuZWVNVm9GMUFYZFhQdjJGcDlqaEdZMTFmT2lLY0pKbml3RFRZ?=
 =?utf-8?B?TVV3d1dCQ0NEYWJwUkh1TUFLcTBMZFlVdXEvVnE3ZHdzTkI0aitEaHJUNlpm?=
 =?utf-8?B?U2ZKNHJ1eUVTbnJSb0hpbzlFdVVzaWxCZXNMUm9nL1k5NTN4amZXcGVCWVBr?=
 =?utf-8?B?aW5qOVRmMXhLZEpBN2FZWUhSOXdPbllodzdPNkU2VkRkMFdyRnJqQUlHREdY?=
 =?utf-8?B?cFFVQjVNcm5yOHdvdEV3aHZGM3NpNXp0QndweWJtUmtpS29zSDFiVm9UK0dK?=
 =?utf-8?B?YUg3bDREVkZKVXNWa2h4NlhEN3U2a1F3U3dORUZ5NVRrYnZGb3RuSUM5SnNy?=
 =?utf-8?B?Y3dmTlJwVUdyYzh0TFlKdkprb1RENjdxUlJveU4vRU9ycklvUnZoODc3bURE?=
 =?utf-8?B?UDBpWFlLOS8reTloY1cvV1MrT3MwcUlHZWR0TTAwWWVNS3lzZFZXRkVpQmgx?=
 =?utf-8?B?UUg3N0U5c0wrR0I0MC9LeHZvR3dDQXVMdFl1VUR3TFRqK241MFl0TUtmWHRr?=
 =?utf-8?B?VlpmNUJmbjVhaHJ6NWJ0eWpXZjl4S3hlMDVPL2dwSE5xV0ZLWkJSek4wVi80?=
 =?utf-8?B?Q3JCZWZ3OWZTblVSMEdXWVdUOXRKdFlyby9CZzFkdnRleTJva0JZdklDRVU3?=
 =?utf-8?B?aUFpbHFTL05ndEVBWndFNmZESWp6b09CY240RXNIQXNnZUpWMlRLWkljZEpQ?=
 =?utf-8?B?UitrSTM5M3A1c0Y5TXIzZlJva0tSSndscC9aa0paZzMraXlqYXROMkxpeU9U?=
 =?utf-8?B?cVJQTWwzZ2t0WUxWam01UlRVRjlLN0J4VzJhUWdpUzJkZXB1WVpkZ3RMdHVu?=
 =?utf-8?B?RjJQbTRsQ3NkcGRhZVl1TmJGZ2ZPZzNkNzhIVXFYQW9adWQ2TUpoWVRYVE1G?=
 =?utf-8?B?MWNpUWtXSlFpd0w5MUZ6bzBDUVpKVmpVRGpNSVFNc1FjVllURDBrTFFjWHJF?=
 =?utf-8?B?QU1kTVNZQ0E3YWR6RFRSVUFUMi9rZWpHKzhJWnNweXFrbzQrQlNBYmNrRC92?=
 =?utf-8?B?Q2dueGdsbE5yYk9Feklra0xuR0wyRHB0NjlxdmlVT3NyRlhsdHZQZzh0eHMy?=
 =?utf-8?B?VDFFUWt3RThYSnBHU0VFb2UrVVBVYnI1QloyUWNjMm1lVG1SdWkwN3YwcHNH?=
 =?utf-8?B?aC81Rkpyc2I3TC9lY3JZdzArT1ZqNUszRzV0dEZiMzlWWm5JdkJZbHVRSnZi?=
 =?utf-8?B?NXF5MWxNdVJwZ0FoczhkMDVkcDF5UnB3NmRFTjQyb0doMVhQb0VNNEhBb1FW?=
 =?utf-8?B?bHBvMmNHbDFBME5wVFpIc1dIOWl0K08xbm9HWE9ZSkhJZnd0Q0R5R1dHMko1?=
 =?utf-8?B?QkxvL3BxN2xkMlZTN1lBVExSNVdEVnVUVkpYTTR5YlRRY3U3VzVKZTVRWmpx?=
 =?utf-8?B?SEs5U0lwaVpvKzRERjRwK0trM09EOHRlMWE2eC9nQWVhbmJ1RDJYcC9RTjlN?=
 =?utf-8?B?MFFqSEk2QTdXalB0di93QjgyellGbTY3WlBVSWNsczNVOUVRSWdnMVgwZ2dQ?=
 =?utf-8?B?QkNDSEpZSngyRStuNUtwbWw3Y0ViZ1g1NmVvYVEvMEczRTRQdmNCdHc4ZFpq?=
 =?utf-8?B?U0RpeTg0OTBWRHcwdEIyWjVLY3p6UFBQWVd0eTFSak91VFZMWlZvK3Q1akxl?=
 =?utf-8?B?V1o5bXRBQjFvWkEwZE9ramFBeFBsK3JzcWI1bm9vem1ZdktKSjhQcmNWaS9k?=
 =?utf-8?B?WUcvc2FuaHJSMlUvS3UxSHFpa0dpNnY5OTI2d1FTV1ZHT25PZVlzanpUaTdW?=
 =?utf-8?B?eVg3Z25qdUM4d2xDalcwTUlQUEdvTVVvcFovVmxKb1hUdWMyZ3c1SThRMTlp?=
 =?utf-8?B?TkxmdFlaOW1sZ2xNM0dpeUdydlM2UmFielNjQmY0Q0JBS1paWU1MQUI3VnZN?=
 =?utf-8?B?V0FTbnM2STFWZDJqS1ZLYnljSW04WnpnQU5CNGxCMTlndVdrdUVYd1I4alo1?=
 =?utf-8?B?VDM3amRYcjcwNXN0T0cxZ3l6b2JITDd0cmk3RkZCeFVMVzhzbHpGQ3NCU2pu?=
 =?utf-8?B?dWlib0lGWlR3cWw3dG9PNWNYb3VoTk03WVk1dFJyWWtFNjJrdS8vbXZZOTBU?=
 =?utf-8?B?eEJSRUNoLytWRThLa1YyWVhlSU9RcjI1ak1leGM5V3kwdWJKL25JVzNHMnhB?=
 =?utf-8?B?dVlnM3VmRG5mN21zb0luOXkxZ0o1d3grOTNVbmlzRm9CNkcwZUhvcThGZEFz?=
 =?utf-8?B?VWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3376516b-393d-455a-0323-08da970d6249
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 11:28:16.9885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEj4nomvHMgKXnDhV+6qv8DBthCbZa6OvkGnD4UvJLvJuJzmd9NXZwWJXlpyof6EOzUyfjAxHrKN3M7dttOo3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6367
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150064
X-Proofpoint-ORIG-GUID: 1zL_NpySqAmyJ98gJXkydXR425R8z4mn
X-Proofpoint-GUID: 1zL_NpySqAmyJ98gJXkydXR425R8z4mn
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 15/09/2022 07:04, Josef Bacik wrote:
> This is purely cosmetic, to make it straightforward to copy and paste
> the definition and helpers from ctree.h into fs.h.  These are helpers
> that act directly on the fs_info, and were scattered throughout ctree.h.
> Move them directly below the fs_info definition to make it easier to
> move them later.  This includes the exclop prototypes, which shares an
> enum that's used in struct btrfs_fs_info as well.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
