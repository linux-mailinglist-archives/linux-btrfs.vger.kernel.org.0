Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9075B98ED
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 12:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiIOKjI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 06:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiIOKjG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 06:39:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1A3785B8
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 03:39:05 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F92Cvx021810;
        Thu, 15 Sep 2022 10:39:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=g6jFEiiiJQlf+A7wQmyjbNZlXEpnOUjuug+mab2X0Hw=;
 b=pwKVvAhpygFFMO8gTBKX2lNu8kG3bXlcWTpN+zzZ2+wMBJW2UIXC/+M6fRCUNOk+E4NI
 UIH/pOX10X9dWIfWIzVP3MLt9OypA/yyWMKx/Qgf0ygZlAtdnUFSZqEWDYzWw8TjAXkM
 UEkJ6Iarobn8g7Z6h0sc2t6VxIm0m1etavmw9+kAqRggs8lh6Xvs+ZDzzsITd0T95RvW
 139ERgk0NnMQAc6CJVMxp/RtqRDcEBr/2k9oa3ZGWVkBPSNX2M/RiduDyF4DiJKYPKGB
 n/9QIOdWCJiLPvwz9OgWUx/c26iZWopaynFp525ftei16v+0Y2BobkarhdtFv6E7PZiQ hw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxypcugf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:39:03 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7qHpM007213;
        Thu, 15 Sep 2022 10:39:03 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy5f880c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:39:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VK6XIiia8lGy1ZAbinclkhsdbES1FuPbKtusUG4CHyJslzrZUbWm2ugaxXkDD6eeWpCXOnmB5oWW3N3bdWtb43i7VBen1MEfs00eR1AGx6azqx5PbXKBts6lEJRwnU2E9zZg2eoZnCZcrz0EXUcfhhezTTUq6YEYM7zyoB5+3AmKxjTzN1L+80j0saPOUGr5pTtRkwk9YArBTQSNUk/UM9RL9I07ppQeo7ugXLtVZ8xmw7Nccko1ZpSaEfe8LsvABPMV+/ksmR2D7t/YDvjhzDRWXXBnl7ETxtE4+qRKjFkhqU0y8AGtQesbB6W4xfjamsvEci+etNES94bG4cUplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6jFEiiiJQlf+A7wQmyjbNZlXEpnOUjuug+mab2X0Hw=;
 b=VOJeg/LJmv9QzaS9PGQYIVkQRs17beQw7+3zEMduQSYNnMHePebEijdnT2UDqfTh8PROvAxM+aRkWtE2pEGi/jK6J48tTesfuZGsTrwUlgmmTP6ojW7Iy6OW9h2ti+82nZT3vNOCmIqP6kAyYjUbaYx0Z7T2y/HUFF1MDhdXJwblmbvs9ssmXMFQ5yyIBZVPKvzFKy435NrvZHaMj/xP6kSUB50Kl+4k9hMx309UewfKLlNsCMdR1l4PpTw7ZECoj86EKHIJOQZyFG6AQBDfg/xtKUv9FzllK2jjkS52yjsxhkYY2iArjluMvBbycc72gCSOg8agOpNE1vkTcphcnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6jFEiiiJQlf+A7wQmyjbNZlXEpnOUjuug+mab2X0Hw=;
 b=c/HJzvbayAvUCIcjoNq3iFVYVUQTSRQkx2F76djwZhS8KtbLkboSfGbnJv6h04wyOLfY+ZCkMWBnUTUWrLzX7QK2NMJc7Xymr6eJVqOmUnsXq1hGZVZjnIxmkCPwPJB3IjugTVwWVgdii+ShtRsLuFSsDIvBUkEuYUjdfotSPBQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4376.namprd10.prod.outlook.com (2603:10b6:610:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 10:39:01 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 10:39:01 +0000
Message-ID: <87a5ff32-450e-b596-9ff5-8a84a70cf6b1@oracle.com>
Date:   Thu, 15 Sep 2022 18:38:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 05/15] btrfs: remove temporary btrfs_map_token declaration
 in ctree.h
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <cada813eb22ef6d856d17c15d4e4e5d883b38bc8.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <cada813eb22ef6d856d17c15d4e4e5d883b38bc8.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: 0add395f-fd64-4ef1-69b1-08da9706806c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OnWc7Vc9yBjerOl4aauMN04LmXDJpacWY/p3DHUsnpHa+g1S3f2TTOgtSCFWWcrCmZLB/L4HX914YqsMUzf8h/Y+xfE7neMx9elD3rorjCv+v9+s+4kjwKjM4AKgQkUjc63sCKApq6rmkP6RNlbSwduMLBPnjwHFMumCzA2GA+YZTp2WBFb4cVR+xm+8eF64gdCE9h0pyLmsJdXxvKiipdY0vmlwC10zXbrV65eUUZ+bDTdVtSRtFBl/qqo2o9Ry0Fcs/LvUF/9UApJ9SmdEhfKPOtdLZ77JKWceyqtZYlh6gq4uHBTZBxK0n2SkJg6SWS86kjbXTWbIzfgDwKsnRcq76fnju9ECEbGiJ44Wcm1cJyKuzAOaxJCpTxzylJCFddk42Bl/vn7MZ6c1/ercyZ7jzsEKWsVe+xgnAUbjlxeLYhpdyKBgie9cRcZfqqwYR4eP9EhkjcTwylqBs3m5ndTT8/+zS0lxOVMMJ+SjnDFsfdqrFO0oyi383K7zy1Y8r1IQXcaHeVm5M7IEYDH+jZabjEQsPNFrtUozFDwrg3+xQMFGgYygxX+E1SL+IxurPAQpvtiRqgvmmZ2SB8XJ5XItxci8sgOssJ2GN8aHqCnsr5MbOpIwmx0jDS09/fW6GOaIu4VIcp2CVMmwvCchMNu59mQuORtYVDk1Dr9gw/iy5DQcGym4oFy4byxIURgMDDbNl8WGjXUHp2QEvl9iOPrIA4Rk7+03SrrID76jGeyNVYyqiqYjMVcAAbjDjTZrCi+0P+eZQDYlRbWeE3x7JypTGsuEiqMLOZqFNZoJxVA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199015)(558084003)(86362001)(31696002)(38100700002)(66476007)(66556008)(66946007)(8676002)(8936002)(316002)(44832011)(5660300002)(2906002)(186003)(2616005)(6486002)(478600001)(53546011)(6506007)(6666004)(26005)(41300700001)(6512007)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWtxSmtUU0NOTjlCYVVldkxmek14c295OGhnR00rVXNnV2tQYlEwUHRNaW1t?=
 =?utf-8?B?MmViVTVhV3RySEI4bjZwY3pjU0hJV1djRXAxWmw5YkpqRFJhd2g1RmN3YjdK?=
 =?utf-8?B?WnZRQU51MkEzd0lBTG5PMWFUdnBtSlpyQjgvOFZFTjlmekt3Nm9zRHVYVDFE?=
 =?utf-8?B?aER4VHE2eG5oRlV6ckRBZVdVSkdjS0JQdUoxVU5ZR3J4Q1ZidnFjaXBFR296?=
 =?utf-8?B?cWF0Rys4WTg3TUNpdTZDMWRvMzk5TFpLTXlwU3RlY1ZOMURrYWx4eXgzMHF6?=
 =?utf-8?B?WEl2L1d3K3lZd0J3eElOcXBUelhPbjIwRWdMY2ZwYTV0dzdHZXdLd1VOT0lp?=
 =?utf-8?B?WTRlTmY2MmxMZDd6cWNtTTlURC93T2NJd202WnlWS29lRWcvTzJBa09BbW0x?=
 =?utf-8?B?RHIyaXhFaFhPMCtQRitDaUFrWmJ0MjBqOXhieXpkY1JlcUNZZDh6SVBzQzBr?=
 =?utf-8?B?eVV2czN3TEhQTjBzQlk5TitOY0ROTU1aWXBjZXRxZkUyaVkwQTBUZDF0cnBp?=
 =?utf-8?B?aWRVMVdnR2FzSHFyZFl0TnplNEpIVDhRTCtRQW4zRUUzSjRjdE0zM0F6NVcy?=
 =?utf-8?B?MnQyY2xwSFR4a3NpdEJaUGp4Nkw0WXNOMjZMZkRWZ244M3ptU2RGY25obkph?=
 =?utf-8?B?ZHZQdHFLTlEvMU1vcVRDVFM3RDZVWWdNaTdway9FV2p4VUlkVFg4UGZnaDNN?=
 =?utf-8?B?OVpJU2wxcVJseTVua2RlejhLZllOWE0wR25wME5MZDlqZVVKb0sxNUx5R0hq?=
 =?utf-8?B?c2ZRVkw4ancvZUR0aDNieG1xZFRad25MT2tvVG9pa3cxVFFNVFRMQVdpR0hi?=
 =?utf-8?B?MWQ3TlQ0ek5QNmVvL2N3MDlmZldpMFI3TzB2ZmpabnJZMTk1c3J6aHFiOVJB?=
 =?utf-8?B?OXAwRTdkL0dhVUtabURNTW1kSlNobnc0QlpTRW1mN3lTcVhUVFhQcDhDSDNQ?=
 =?utf-8?B?N3V0S29WbzBQWFdQVE9wVjJiTUJlT1Rtd3VtK3c1TGdGaXUvaXYydzFncUQr?=
 =?utf-8?B?VWc1UnBEaVRocmdROWVNUnlNZTNick5acFZKVll4T0ZuUTVhalRDdDMzWWhO?=
 =?utf-8?B?UkE0QXN3K0M5Y0Z4RmNCdGYxa0pieTZCUmJIanNCK0tKN1RZejRMZEVGcFFw?=
 =?utf-8?B?MHowYzlzVGhvYk9BVWozeFhKeThwTEdJSGM2T0dtQ3NUbmRIdVNyZkdIenJq?=
 =?utf-8?B?UDVESW1MbUhLeTRVVk9neFl1L3UvS05YYUFxMXA0aWNoR2tKWlkyUFdSM2Va?=
 =?utf-8?B?SGkyUnN3QlJ6OThuTTFxZnJrWXpDaWZtR3E0T3dORFFEWjg0dkwrc2RNZHVt?=
 =?utf-8?B?dlBWWEp3ZnRZOE9LZVZBMVNaRDRqSG5Vclh6bjR2S1lFclJET1QrSVpTS0k1?=
 =?utf-8?B?SFNadU5rRUQxT0NBZFNtN3lCN00raDAxZ0c2UHZMMlJudWdHb2tSZWFEOHdG?=
 =?utf-8?B?S3Vua0RCZ3NSWmFoTmdVVjVLb0NscHNhaHhEODVZdkI0YkFkWnFTRUxzdlNZ?=
 =?utf-8?B?RmJmc2xzU0hhKzJXaXhRWTlPY1J4bTRUMmtLM0UvOWt0UDBCelluSmhkL1BT?=
 =?utf-8?B?KzlsMWV0clJVNFgwT2hGRmxOV0ZRaWRIK0twSnBCVHozK2JoKzdQRVV6TTNR?=
 =?utf-8?B?NnFseEhsTFJFRVkyQkNQTDVuTXFrZW5XMDEzK1ZTZGgrM2dRMXZKRHArRS9w?=
 =?utf-8?B?bmlNSUJlVHdzMkZpd3hrZFNKMDcvSUhOc1drdURwcWlLTVEvRGtxcFVody82?=
 =?utf-8?B?MG5TRC9wT3Fpb1VFL0RScTUyRkV2OFdUVnQ0N1oxbmcvZnFhNlJoZFo5VUhJ?=
 =?utf-8?B?U1N3b1IrdTNiUnBiMnNHSHRkNkMra0Y3aloyZUxkSVd6ZHVkYjBZWGVadVFF?=
 =?utf-8?B?aG91T2tta2pRbjVSM2RMcG1SRlFBbi81NDRiM1RvYkF4ZUhKcEZHTVdodk4v?=
 =?utf-8?B?UnI2RzF6L2VpcHZxZVZzTlBvNUJ5bnZKTU9VMjRFK1ZsakNCTHdlbmNOWlI3?=
 =?utf-8?B?WkN0OWswUVNIdUd0VE1vMEdlem1WWjZOY0l5Y1ZrNHNQNm9neWk2VldWQ0cz?=
 =?utf-8?B?QTRZYkZ2WTBxb1pJemZZN0FrMmpYajNXOC9rUkhNSlNmazNTY041UGNYSkR6?=
 =?utf-8?Q?Z419pJChBO8+B+lVlh+0qJJEH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0add395f-fd64-4ef1-69b1-08da9706806c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 10:39:01.0126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVnQu8YSetOed2mxWR6QsemoxrTtqE8NdZhLmW2gZsXBowIfn6WmlvFcH8wyDIQCSbdxen2XOkOcyQzhe+jlQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209150059
X-Proofpoint-ORIG-GUID: FM67xNqtLkYF34p45qnQxdlxrG1AXsu1
X-Proofpoint-GUID: FM67xNqtLkYF34p45qnQxdlxrG1AXsu1
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
> This was added while I was moving this code to its new home, it can be
> removed now.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
