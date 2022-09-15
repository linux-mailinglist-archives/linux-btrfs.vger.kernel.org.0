Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A878B5B98FF
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 12:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIOKma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 06:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIOKmY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 06:42:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D5458DCE
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 03:42:23 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28F8sdGM014976;
        Thu, 15 Sep 2022 10:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vjSyQ5lXAMBQiG2QjeCF9UXfHHf81hyE/XmzOVVlJBc=;
 b=VqENXcRuin2XrMVxbVE/u+qY+r7jh3f3tTyIO5YdWWf7VebY/2xadtIdzHGOY7ZrPURv
 A/Quz9NVLUG9dsPWkqATJKnlWEKtcu9KL6yH1vBgxuAZMB7P8hvIK6oXECZ6SvzvBUyu
 9rd88OlKNs4D+v7pEJXVIlfqr513Waotmox9H23Tjk4z07d/jtKMexrg2RP8NYqwo0zp
 gyQOSCApwAk6vxXO1MoGb62ZAFP08JTC+yXD89dbzmndl8Bpk5WypiPGHVqWOx0CRfQw
 S4b7/HznwjfWsRZDwfAiLH6/fU6yrQJCLUKtPYZXSlqmwmqo2XMc3/Nj7OodHyztihdS Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyr51qw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:42:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28F7qG8h023238;
        Thu, 15 Sep 2022 10:42:20 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjyee16t7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 10:42:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TJAevj0T0Eahq6tMTRDvUyzu+p2ihKnd4NnLBUKRX96X7I3r4FcuL+3eaom9Zy2B0faTrfiIC+2pxUh8eCwNbhuykWcA8V88KgUty4Sw2ECZSDVkxxSLXcQqyDfrg5V0uFSSHnExbeCHKQOxEgnEJA6cOmsn60LYZnTopfcb6aWIWa5SAEPC6qKTaPYV2MkpIDu2RnWPUy+ZsPmi+AVGG/WTInxaaq4tkYHCh926lSbeee/VujfanwhoscPDS4qF+1twSh8NGo8zI20AEAi0fO1Y6KzAP1yASqTJ+QONwk56IBS5uJR6mQx/WZetME8mvGcPlSxWCnI2+8jLVN1Htw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vjSyQ5lXAMBQiG2QjeCF9UXfHHf81hyE/XmzOVVlJBc=;
 b=nPaTeDAbAXli12W0UvPm9MNjLShuJ/MJKKwI4i4ViE+ylOYS4WVwbYZud+3yLrbbPDhWm9TXRS/rWwiaL9IrV1jLD22MeVL2MXemTSGk4rGkIar8oS6zJe1pMmnhTACy2xuNoERyuN3K7PiZTEmGFZOkB0C6DDfGa+i02IZeu7UCIDwk9G9JC18xiLbaM711Z1sWeTT5NbqF2naCrNPlpmzvbBF9SLRmoK+44Pr093uJey3ikUE4tkZxVs8ux5u/d+fiflhn8fKUAx8wxuG3mVKY8k80G8ke+4SDVp3u8ynl2Sc0hHCn+3Cxy0X0ISEbPzAmgmq+m9a6ZvA7YpLXXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vjSyQ5lXAMBQiG2QjeCF9UXfHHf81hyE/XmzOVVlJBc=;
 b=IDla/n5acgcoAUof13CtNnA6HL+EyKxzUVAMkJnUZpN6Zyc4LDfyUbhDMSRY+v3mNusnZc/udCGy41Y9hHTBJBcoBckYt0mAjSi2LvX6nDyGIOmvwvCiKQ2nqOtuADOHCs32MnynPmvQXOowoU8AuqU5jykbDP1lIosOq+ELLF4=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CH2PR10MB4376.namprd10.prod.outlook.com (2603:10b6:610:a7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 10:42:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::74b2:acd4:6739:716f%5]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 10:42:18 +0000
Message-ID: <6aafa24f-af20-0985-90d7-0b00d3e532f4@oracle.com>
Date:   Thu, 15 Sep 2022 18:42:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 06/15] btrfs: move static_assert() for btrfs_super_block
 into fs.c
To:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1663196541.git.josef@toxicpanda.com>
 <6b462dc4d7ceffe2ba9141f46bf28350be7c7f4a.1663196541.git.josef@toxicpanda.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <6b462dc4d7ceffe2ba9141f46bf28350be7c7f4a.1663196541.git.josef@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|CH2PR10MB4376:EE_
X-MS-Office365-Filtering-Correlation-Id: c7cb39cf-38ab-4dd0-d9d9-08da9706f629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3QounooVoLzj3dhXKkv2fO1cuAe7qP2BJjpdrNQ65TXJ1SwF7EeCBfbXY03s1V115MWT8DC35vyg6w8+QwC62qHaZI5jwI2t5ApPGlgGA2GLYqUKVF53Xj5E5a/izeAgO5Gnj0uFJfE2lctN4LxTSowgqC1zlW8huQhj12N9rMEnFCBuz5r1qhQoyOPIKCcbMrpUIwkyOKeBnOVLwjm3bq/yS6cDa2eFp70WxknKkoRKiVN7LoNd6BjKnjlkhvl9D/kJrVmuV5B1VSZQwnnNA081k0PLUZCLseQ75pzb9fZa5DbiXSgtF7zW9JYgrVJmP1Bjbk2JakW3bNdtzZlrAWw0fttWsU84zwDWJltuH5CZvYjshrysbwId+QBCsaBewm2Y7LFOcrnfYuF4VVsmmwdWs6lppatY49xqOmyOpxZdklWiEqn8izOeCQvgzmocJD4eUF8cOGykpNaNbqoVYwNrW+88Fx6vIyg2B27IR8ShIVH1hsJfvacGBdyGzwwWkTCFElNlQeXJZXMhdoL8efPnZQFEuuviSCO13PCdm2X39hFlOYI7Kr/dYIT0YJl/GM56/N0y7lzlM6gmdBfoVIN2tWWwUbJYg8JWeRUzSG1n671RSQYtupkieJbOC8jIh/wa1Scla8P8sscry0fl8GZzxRZWrl2XLk5Stv2BLal11zGXAqJh4plgM7P8ULvLn3SSHIeVv7Koktpd6S8DkfKCbPcusD0qVuGKUpF+C0/hfokGfUrdKj1r1O03D8bSaaY6LZBhmh+0o8dBY6yJI1iu9Y9ahyFOcnFbWMWiXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199015)(26005)(41300700001)(6666004)(6506007)(53546011)(6512007)(36756003)(31686004)(38100700002)(8676002)(66946007)(66556008)(66476007)(86362001)(558084003)(31696002)(6486002)(83380400001)(2616005)(186003)(478600001)(316002)(8936002)(5660300002)(44832011)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGhYbE1CakR4bWdEU01DdjNvY2VWZWZwcTF5a0lzMExjYUJmOVdrTGcrdE4v?=
 =?utf-8?B?T1ZFY1J2bGVOcTc4KzRGaExGN25KcEJ0S010UmpmRGpZOUdPanAzdkJIOENz?=
 =?utf-8?B?aUQvem5uVmZRUkExTFZFeXNLODNmaTB5Q1VIYWJXSlkraTNkVkluekRqN0pk?=
 =?utf-8?B?U1F3UXlKbmZVcVJpbldNYU12VjhyYk4xek9ZcU9ERUVaWGdWbUFOb0N0TVZt?=
 =?utf-8?B?K2UxQ29ER2dYNE5VU1QyMXZmSnhFYVJyMCtWcWh1QkwxY2ExdXdlR2s0elZp?=
 =?utf-8?B?Ulg3a0E0bXAwZDB0UGhpTDBqeHMxNXJmOWpaV2V5VWhKSVpsWEYzSUFWWTVS?=
 =?utf-8?B?YjcydFQyMUhmTVEwMExsUjg1VDVRSHdENVphT09IQUcxZ0pLaW1JSTlKc0Qr?=
 =?utf-8?B?cXd6NjB6SHFzOHpvbCtScFV3QlVHeC9odG83b3lvT2toUkRMbkEwOVh4dzVM?=
 =?utf-8?B?OStEbkZhUkZuMjI1WmN0NGJ3bW5YWGFTZkUwV05ZSHFlNUp4Qis3ZjJpcVU0?=
 =?utf-8?B?aTdEVkRWL2pYMVNFa3djYlJJNm9vbWxXQmJpMWhKc0lwMjAzbFR3b2xvSlNl?=
 =?utf-8?B?UldQRVJXR3RaZEMwT0pyaHJpL0dJZkVzc0F4YzNRSHhRWHJNeWpIeVFnd1VJ?=
 =?utf-8?B?MUZZajdjL3I5bkJVVWszRTJ2LzVJcEhBaEpMV0NDZDNYa25Ed2dmUmgzV2Js?=
 =?utf-8?B?ZFlITU1Ibkh5c3ZURTFMQWcvSzEvY0dDeEFqa0VubmJydUNFakExcTRoV0Ir?=
 =?utf-8?B?ajdLOWg1dHB6aU5maTdiME4wV3BYa3JibUhHelYvU1RheXR6dnlIcGdjNkF6?=
 =?utf-8?B?WkcydTZiLzZtaXlIWHR5ZkRQQkxEQ2x3SlV5bXlzVUpKc3ZZb1Z5cU54M1Bi?=
 =?utf-8?B?TXA1YUR5eC9zdjl0THpZWXZTRk9Cd1BJY210ZVBTR0RKSU9RUk9ZUWxmQUw3?=
 =?utf-8?B?aDJDUXo5V2NBeDFiNGhXT3EvOURVc1k2NklBczRhUHN4aWkwSVppTjZ1QmNE?=
 =?utf-8?B?UFNGZzA0d1JkZlU3d0xZU0E2UWpJMjhLN0REMm14cFpmNlJMemNhNC9XZXFB?=
 =?utf-8?B?bWFxSmlndXBFRGdicXVYK0htQTNObEh0SkJVdEJaVTBqOWhpR1ZuRUpuTHpr?=
 =?utf-8?B?b2V5K3NxUkplNkJOZGRxR1p4TEdNZlhyTkxmbjBnTkxPMC9XbzhjY3pIbytm?=
 =?utf-8?B?akFrMVU1NjQrSDJXczZWUmxIWXZaOE9PWC82QVRubVp0ZHB0SDNlUGhyaGEv?=
 =?utf-8?B?ZWxvYjlpTjFlUU1aeVFXR1AvK3FYRlJVQkswVEovUmM1WTNiR3Jua09wdmJw?=
 =?utf-8?B?a29oWU4rT1NuS1ZoQWdab2lOeTFCVGVDVy9EUkhCVkhtSVp0VTFHSEdBZFhH?=
 =?utf-8?B?bVdTK3lsY3ZTQWxTZDVlSGFCYzRKREo0QjV2WHFLb0xKM1NNOVNtYWhRSWUx?=
 =?utf-8?B?djdVWmFPNGhhN2JVMjBla0U5UDZKL0syZEt5L2p2aExRUjVETGFLVWJGRnhV?=
 =?utf-8?B?eVIva2xHNmpQa25sUERtZFJCVFdPREZYK2ZQZUV4SGkvQ3BQZXBXSEdlSnFt?=
 =?utf-8?B?TDhzVXBJbmc3WlJidGVmRjNkcUZ2YXkyVUUwYXIvVlRrazZXQkRWUy9xRGl1?=
 =?utf-8?B?MjFlam1YSzBsRXdSRmFHTnBpeUVMeXV4b1JLTHVVeDY5TE9jeEo0WkY3R3J2?=
 =?utf-8?B?bFQ2RmtPRTlEYmRxTTlwMlNOUi9ZSUVOeGFTRFJTbFNycHVhTUdBT081b2E4?=
 =?utf-8?B?Q0NrcTFqSE9ha3BQSTVqZjVNWGxRZzFZYS80aHpNVnhVelFPSEp1eUhGMHV2?=
 =?utf-8?B?RVZvdUV6Ymt6and6R2pzK0pYdTIxaXAvVGwxQXMrV0pEbEkvQWxpRkp6QWRB?=
 =?utf-8?B?NDJvZjV2Ym5DZnhIMDNUc2doTG1nbmc1bWlIb21sRkxSSS9jNUZySktRak5Y?=
 =?utf-8?B?c3d4cUR2R1V3S05OZDdjSXlLLyt2aWRJeENJMGJYS3EwV2ZBT09SbVQ4TGVE?=
 =?utf-8?B?S1ZKaHEwUjRlZzhIVU1GbU01MDdOYVByWnVSdDFTNUd5WFdXbmphb1doRVQr?=
 =?utf-8?B?dEZ0byticGNXQlZiZ2xVQ0lES1pTSjJBUUxiRnBXMVVtYXlOTHZ3eVFNUUdq?=
 =?utf-8?Q?KIJ1AFysddAQ+O92azG8G1W2e?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cb39cf-38ab-4dd0-d9d9-08da9706f629
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 10:42:18.5177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b8Jgmi6JLKABONmqxniiW9z6NZMBRyhGgie7L0YzGf7StrdwvS1bResVqmGMlkBQcrxUwSriTF55/s2fPQSodw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4376
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2208220000
 definitions=main-2209150059
X-Proofpoint-GUID: IXHHrHa2IqbMSfyHSnojE5MUlmQ0BC6q
X-Proofpoint-ORIG-GUID: IXHHrHa2IqbMSfyHSnojE5MUlmQ0BC6q
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
> We shouldn't have static_assert()'s in header files in general, but
> especially since btrfs_super_block isn't defined in ctree.h.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Anand Jain <anand.jain@oracle.com>
