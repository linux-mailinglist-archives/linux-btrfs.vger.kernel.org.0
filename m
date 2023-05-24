Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35A5070ED23
	for <lists+linux-btrfs@lfdr.de>; Wed, 24 May 2023 07:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbjEXFeO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 24 May 2023 01:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238604AbjEXFeN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 24 May 2023 01:34:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AEBB3
        for <linux-btrfs@vger.kernel.org>; Tue, 23 May 2023 22:34:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O5TFFv003036;
        Wed, 24 May 2023 05:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=cpbEqtPXtCECJ3lRZXG9+ZcT60XQC2gRoM3ipaDg7wk=;
 b=XOr+FjY5L+D/2zojT8qUn9BUnC5ldEikEuDRIlbXE1YXMJ9mjLxJG5PVwk8cdQOwkAmo
 xaGAUkisfv2lxVCRCZ1v4nOeVROVlseo0JFIUlvR74yNd57Rig1FVX+7GmAFfXWZQ3Xf
 u6Zs8W6Wl9JCV2x/l/8ETwRXUy8DUAMRCZknmRK6OJmQXSg+EJ6js8sRwSvieN5qZtlw
 gyc4NzFlnFou+1p0KxTKd/VCC12BsE3Z7iQ/UPLkWbnYcEpY3rCWjicVoqEw/oJjfYcw
 Re+VVVK6UGN39Ud0a1aEJhLDiMWBWp5tw1/iOiPZQBZQpqMlHxMuDEP/IWGFxhr7DgD5 OQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qscfnr0du-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 05:34:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34O49aDh027571;
        Wed, 24 May 2023 05:15:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2efutp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 05:15:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGIILKRSVCb1FE/xBfvLgYbzZfMYdLEVLQNJqI1q0dLwhXYIbs/f1tjo+a8UhjBhybaUP1FNjunBA0wdwmlZrjES3+KF55jfDtAANP3EuHL0vUpbR51+PNTPVrcDOxa1WteZWZMZEHXRxhWv3d5i0as6KH+vG2W2UNeB3AA/z9+HO5zORkxyl5Gg3wm6NLgeMVfkCt8no791I7FOWMWVYg1Vn8jZWuCs3YWJNUNHPPaMkZmPV4Xc2n/1AqnA3yZRoTu83XY5097PtdgkFhcvDtPM2ydNmIUoyZSHTbIWPcbQGDCH6oDv5ORjxDuTludSWI+OE++NvDXD6aSs95hNBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpbEqtPXtCECJ3lRZXG9+ZcT60XQC2gRoM3ipaDg7wk=;
 b=Ybhf4aupJgX3Fe7zWuu9BwqCeg08pQa3ic8Op+0QHGDXWJ3ESxyrPvrEpz/sUpVqYA/Z47QHEfZW8WfhFAMy3jLFa1sX4bZAiqwB3RDfFb343huu8Cr3MmJh5xJKe3jj4j9Me7LQ5c+MYX4LfrrkR90H0YeT37mC0sML9lmuJzKrrxOZ16v8mL3VBdXCjPGKx67tkm8S+GIVYrDxGg/idWHRUYI/cB0+0u1GHMZuLDJXuBtC6nPRf1H4+Ht4W3P3Vqx/HJgOyugT2IcTqLnUZO1BoVeILk4LdnwKtNy78cNafR3qsLrDf20PY7EqqoQyFUuSH2kEWrF6ZnGcmxa/tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpbEqtPXtCECJ3lRZXG9+ZcT60XQC2gRoM3ipaDg7wk=;
 b=ImR+T2/P6WyfeU8/EjQhRGEiY3iIwBR/BOXpMb5GudkjM4+1b2/OOLyh/bLsIHzfRoEaZIK7urXEo8cfHaJzt74n36S0CmO7BL6qCsuc0B/VFRwBLT/HNYZyh+s2/E6V/hFFmmuN0YEb/GP4vbm/vK6q5f2/rupPwjoSrcx9fKA=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DS7PR10MB7251.namprd10.prod.outlook.com (2603:10b6:8:da::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Wed, 24 May
 2023 05:15:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::bc67:ac75:2c91:757e%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 05:15:18 +0000
Message-ID: <204770df-051b-cba3-8def-cb1e5a11b562@oracle.com>
Date:   Wed, 24 May 2023 13:15:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/9] btrfs: reduce struct btrfs_fs_devices size relocate
 fsid_change
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1684826246.git.anand.jain@oracle.com>
 <844fa765ab173b8dd24549f145534f41d412d3ea.1684826247.git.anand.jain@oracle.com>
 <20230523213142.GF32559@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230523213142.GF32559@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0120.apcprd02.prod.outlook.com
 (2603:1096:4:92::36) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DS7PR10MB7251:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d86640-c4ba-4e5e-6d3f-08db5c15dd77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpOMiw0ag9S9DRBewrNNtqreij/SppjLlSLCLxLFQ86jbVchGkC+fQgeHRpV1BMVjR8g0Ze367EF/hXp7eYyfp7olcI1QbOd2a10I+756+GVjlUbfft3olQvz3nc1vNoBcoWUnI5D8K0DzVifTOXhvi73m8tub8csbP1z21xQeovAfs7Dmg0b08s7jlihMpuniPgee60cx6mno3puTiVwBInm4IcAQ+b8foh9kpCWuZSN4OLtINE7b/0N0wKk7tZaIzLUq7bYIjMUDtKQGrry6u374Y0ziqEa1vyzAVxxlAF3L5fFF+c/LKiuy9hwfuNdT2s7GHndXZZo30NpprgqsEBW7cGeSYUo6PTU7bWL7PycqV8pIO9KCmjbOq7qDh3eAag64mtIZ63alaV6zxtZHcA2jjJnt044JKGmLBW84HJ+zwihxBtlstyrJNT8kBGUl85CXbS0p90Pm96vJvUHcumOI8wmNaITKmfazBBgs6KRjqiyGpnKRLWzTM/Z0saPWFOvAmemkKFgZdXDJ8kW2sT+LwOhRsxClMu+z5+HftEQP5AWurKQpnaBF4qB7YBTVAK3zbLQHZ8kwEmYHv6yPemISh3bRGMSNLpPGxE/W0u28S2Cecr5nAkL4GD/ULIQW5wVah6+n5n0Vsc4KgzNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(366004)(39860400002)(451199021)(31686004)(31696002)(66946007)(66556008)(66476007)(4326008)(6916009)(6486002)(41300700001)(6666004)(316002)(5660300002)(8936002)(8676002)(478600001)(86362001)(38100700002)(44832011)(26005)(6506007)(6512007)(186003)(53546011)(83380400001)(2906002)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXc4UElsQ2k2ai9EM0VnV2dDbzhjTXZZYzZMWFVVcE9xMGtFbHQxUVV2TmtP?=
 =?utf-8?B?WDkrMStOQkYxQWdMU1M5eGlEVXlLZGtqZlMyK01semtVcDFQcXVuOTBUUDFq?=
 =?utf-8?B?QXY0RXVWRFZSS092b2lGNEttZ0QzbzlwSnRITzhvYlpoNEJQSnQ2bTZ0TllW?=
 =?utf-8?B?cys2ZHV0ZVZDREQ5TzdNUXFDZnlsSExkWTVqYVpPVEhWOGp3WjZZbmRYT2NL?=
 =?utf-8?B?UndwUTNkd2VCWW1wYlBzd3ltZWQ1U2RXTlNZVkt5eUVheEFiMjEzdUpqbERV?=
 =?utf-8?B?Mk5TMmhmenpjS2M2WllrVmM4MG1ycFNqQjNWMzlrNmlXQndKMUNDOFpGN0g0?=
 =?utf-8?B?d3g2NkFWekFTOFFXNEFMSlVGWWhraC91U0Z2YTNOVkREaFd2WEcxLzdKK2Fl?=
 =?utf-8?B?Y01SRlZZeHpwclRUVHlIS0VFMkpjUnBFV21TbTFrQ2ZuN2d1dlBBMTlSTmRo?=
 =?utf-8?B?ZUp5anVKK1BPMmdpaTJXZFp0enBTZ3EySGFnREZ3RHZGTWlOR1BnMlI3Z0NB?=
 =?utf-8?B?a2ZEUXNWbTdyL3FXYnVIWlFuc09SZ21UYXliU3JEUjdGeE9aKzVKZWxTUkk4?=
 =?utf-8?B?NWxPU0cwM0NtRDVTeCtPQTdtalY2SWJna0dCRjBBN1ZxSloycHpUdm9adTM1?=
 =?utf-8?B?L0ZjYzRHZ0NMVis5amhXR2FiL1Z3YnhvUVNZVytObGNSZ3hwVWpHL0YwUk1y?=
 =?utf-8?B?ZVF4dGlsYzBSbG9KVVQvcWdtMXRXd0l6L0wrVmtUbjFveVFObHVDR2VBY0Vk?=
 =?utf-8?B?YnI1VFJWSDhMQ29MS1I2WVFGT2hJQUlwZHg0M0pQY2luZDNJV2ZWZjZ5c0JS?=
 =?utf-8?B?VDVTQWVzQlUrQlBIZnpqTGRxZ2FWYzlXSFBpcWhxTS9Bb05vMjIvLzVUT0ZC?=
 =?utf-8?B?T3RQNndIbCtlaktMN2pqKzVOMlhlK2dXdHJYRi93V3F3alg3a0VlckhmYWpN?=
 =?utf-8?B?VmlNL1FLWGVSc0JsMk5KOWtMemdiT0JTYVErdVpTVnNkVmpZL1dYTXFJU1ds?=
 =?utf-8?B?SE9wTzBRWkJCWGlQdzNXY3VXa1Y4TWxlbXQySEhwdkVtUDIrWGgyeTVwcEZG?=
 =?utf-8?B?c3UrUnpSdHlBQkxlV05CNWtXMWp3d2ZyaTUzTG43SW9MQ1dKV2dXSWpiSDRk?=
 =?utf-8?B?ODN2STFuRE0vWmx0UWxnWDNZQ2k1QU1VT0c1U0ZoNVpadzFoa1piVUtDVTJK?=
 =?utf-8?B?NTZFbVc0N05ieGE2MHJqYXNmY2VuTzJDMWRUVWFYSTY5cVByMWxJaGdnMnlw?=
 =?utf-8?B?MEU4em85bGx4VUMvdmtlb2J5MS9lZ0dyVnZXNis1MnhTK3hlRjVSRWMzcE5T?=
 =?utf-8?B?Y0tCTCtXUmhZamFabXVLMDR0Yk5SaWZONWs4TlFsYmV5U2ZUc2FpMnVRM0Q4?=
 =?utf-8?B?SHVKSGxKbU4zR0NlVTFvV2o3MWpaVG43OG5SckZrc0lLb2xMcC9UZVJpbjhF?=
 =?utf-8?B?OFdEWE43bzBPcnczUk9yQUtBOFZleUloRTlka3RZVXkxZERGR3pFeE4wbGQy?=
 =?utf-8?B?S2x2Y2kxOXo0bDFubWVzc0pydmlTSEs0ZG1wbUFoc3hhZ2Y2bDB1TzFYY3k5?=
 =?utf-8?B?cVZwcUNMZFlGYjBPL3pBcHhaYmV4dWxqalhZYTMzU1cxQk9QWlU5bkFKRnIv?=
 =?utf-8?B?TGcwRS9mN2dSeDBnWFNCWjkwNUZFVmR4bXl3bGppOXpiQWl5dzZkSVpPQzBy?=
 =?utf-8?B?VHloYWFVbUkrSDdHdnlMQXdEMGlnTkxwdFd0VWFyNmlmYWN6Q2dCeFZEakNl?=
 =?utf-8?B?aXQzQlhHS2FuTFBjL1F0NGVvU1hObDAzRUJFaGhTbDZRdkwrbnJoSGltOTFM?=
 =?utf-8?B?c3FETTh5QXhXZmFDdHZqNUVCcUd5Q3lpSzZ6NVBwVXN1UmIrT3N2aSs1a3Zt?=
 =?utf-8?B?bkYrZzkzT1U4V1UrOVpDV1ZFbENHMUdraXhkcGRESmgrQmpMMUZnYmdHZnIy?=
 =?utf-8?B?NWxzcTJ0UkEva2NsbGVyNzFmdkU1MDVPSTZoZWpmV0pCQ3F4WXZVT3drZUpM?=
 =?utf-8?B?akJyU0tCbnU0Y3FuelhSK0NheHVPbVQ4QmEvZUduQ3hiZTZvUHRqeFcvZ0oz?=
 =?utf-8?B?REdCYmtYWjh3cG1ZeFQ2T0J1cnZUVmhrM2lONHFuTG9XRmFGMUM1dTJ1Wnc3?=
 =?utf-8?Q?QN/9YXU1qhltLCQ18f5rmqRWn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zgVh2atFLZFsbrhS53uKjlpKvIeUPmJlmlVS/4grp/kszRthQKnfAoCRB71YdrItNTUGpBrkdI/cpxWVbxJXpN7dHmSH50vHeVax/QwuaUC95Uxam5rrGPNGA0nRbJxAE4OUz7SKg6kWm4LXMMD/MCDWOHc6MPPRs9jfWEDJ+kXxTIoozwRix9RRfbGQ5+jjrWZT9NrGKPAWFOsZeHLzWXA/oyvRrkbZi3at4asbLbFcFItPr+SdV+jR0XxBnQE7MjIL5qgMAZEOYirrFf7ViuIioqzqPhozdEf5tWQReT94+BWQO6cAbMIqLU/WCBjGxpbtwkPbWPjoTmiGWcsasCBxLAETOwf2qutKndQ9DvLelKYVPoQLECM2myyxLmQ82IEArT6FYdXu6aq3GQEy7J7d+lcf2U4wqF6vE1nbvIvUYyYdZjtp0MlgHZ7pGIxytgMEQF2Arok2OltpOnPQ1OelUtVv09+MBZKVPt1f6ypkoXJiYiytW4a+zHoVF9xweQD+++7X7PzlkD5SXEKGTM86xqDFDm0wx4zQrMFVA8pRdhvQpYlrPxAk7GwNf1CJRU0THzqpf9WKmXDEjj5WBRci0Qx609Eckga/PHI8pPzQn4Xti0lRn3iwsjZ+QDWaCGiTAIPyYyAZMolUrCmJNkm/Ghy2IDD/O7WDSb2BKfO8FKiVoYjlmtHoQPuZcjZrVPu//dssFe0OIy2di9WBLNoGXBsJccsirfXmHQJhInVbPYrQrpTIGYsIak+p0oPBHUU6TEKXE94CIW0nMuD1PJL0L/hu8d5AIVGICkNgvRA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d86640-c4ba-4e5e-6d3f-08db5c15dd77
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 05:15:18.5750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xj3yr649KI9Gcu6p3Fwbp2OQmcmGjpfraWsIxsXy7xCDeZmqNLDySN99ykISmhbVNEZ3VMW9PQRA/S0GW5OaYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7251
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_02,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305240043
X-Proofpoint-GUID: rCMqnov6T8w1b7Wkj9zvhqsRJODBIcCJ
X-Proofpoint-ORIG-GUID: rCMqnov6T8w1b7Wkj9zvhqsRJODBIcCJ
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 24/5/23 05:31, David Sterba wrote:
> On Tue, May 23, 2023 at 06:03:15PM +0800, Anand Jain wrote:
>> By relocating the bool fsid_change near other bool declarations in the
>> struct btrfs_fs_devices, approximately 6 bytes is saved.
>>
>>     before: 512 bytes
>>     after: 496 bytes
>>
>> Furthermore, adding comments.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   fs/btrfs/volumes.h | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
>> index 5cbbee32748c..a9a86c9220b3 100644
>> --- a/fs/btrfs/volumes.h
>> +++ b/fs/btrfs/volumes.h
>> @@ -281,7 +281,6 @@ enum btrfs_read_policy {
>>   struct btrfs_fs_devices {
>>   	u8 fsid[BTRFS_FSID_SIZE]; /* FS specific uuid */
>>   	u8 metadata_uuid[BTRFS_FSID_SIZE];
>> -	bool fsid_change;
>>   	struct list_head fs_list;
>>   
>>   	/*
>> @@ -337,17 +336,24 @@ struct btrfs_fs_devices {
>>   	struct list_head alloc_list;
>>   
>>   	struct list_head seed_list;
>> -	bool seeding;
>>   
>> +	/* count fs-devices opened */
>>   	int opened;
>>   
>> -	/* set when we find or add a device that doesn't have the
>> +	/*
>> +	 * set when we find or add a device that doesn't have the
>>   	 * nonrot flag set
> 
> Please reformat comments so they follow the most up to date style, which
> is to be a full sentence (with "." at the end) and if it fits on one
> line then it's the /* text */ otherwise multiline /* ... */.

Sure. I will fix them.

Also, I'll split into two patch adding/fixing comments and moving
%fsid_change.

Thanks, Anand
