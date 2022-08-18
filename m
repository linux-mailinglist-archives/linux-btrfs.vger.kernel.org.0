Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76265597C02
	for <lists+linux-btrfs@lfdr.de>; Thu, 18 Aug 2022 05:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbiHRDI1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Aug 2022 23:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242997AbiHRDIV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Aug 2022 23:08:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599F9C33;
        Wed, 17 Aug 2022 20:08:18 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I2w4uw026773;
        Thu, 18 Aug 2022 03:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/iWrzJii9N8DZY4sAsOFn+iBGUfkS2hhfigGwz1NFCI=;
 b=LCdXWjqwCxpNprExJSOJeowaYDLtnQbua7tfK5Zg2QXZqg1z5GgugKNuqWY6q/v4Rs8C
 Ngso/L4hsF7tLAffsR5eobjQA6Q3k1irYFgm7d5XXLgXZxBVDcCvu5h00CJzp1NF2sve
 nLDEH+esr+7KIUzwgaOd/FqDJX79laLqrus9IRIf9MWTeNjmy3+IazykVn9f2fNSmG80
 MyKBB8jDCrX0cu2FrdxCbgf2BtmN5npMwlnjobM6bJmDgJ9J9ILgVSFnladKEGl1b3Kw
 r0HU4q9SJH0WOvcqGoUKMvaIoNzEXDBuSi+aAAFvTa5EmE9paEYiIqnXp91rVgpV9tYJ sg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j195w0am8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 03:08:08 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27I1UQrJ025525;
        Thu, 18 Aug 2022 03:08:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hx2d42ejq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Aug 2022 03:08:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjB57Xlomqy7O0t1FcTK/E7o0HoIvM6Hk+iqNlMtvtQiMGpXHJlLqH586uoSLB+U9O1txz6EF5cEiCxVGmeXa2RMk0eMpMdJ75TZNwLHLmXI4PHLcYuIUKYAIpko+ll+86BR0g4YxnXD7kfHqCSsW9KqIE6SQPKwEa9ASJ/6P2vt+bQok5PfqAR8BTeNDwe9n4UPOdqp+7mG2cTB45xbcSSMiqqPFOC6QuVUFADY2nPN5oKs1CrdmZwQ2NMtWWQ5TmYCpa2PoPkOVPTkBRCsRFuG7vT9XHMhEEql2ir7e0zbYeU2bplLQbW7xKVrbzPlf5+3uYFvsYPMsBPn4lOqRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/iWrzJii9N8DZY4sAsOFn+iBGUfkS2hhfigGwz1NFCI=;
 b=EI36gYVgPMWGwR5WXsguux8GTjbffDmB+kBNHotbF1DUnAKOPKVm/XsPL2Qx1libwK4v0xKdKcUB6myuVEO9aIdQ6Vn5MqP+U86aQyri1K5kprOymu8PRzqFzp2qEAriK+0gpRl5YlVe1a8AkNSWgZu5f4Z7SgZMAjNfcZnB/lw2ERXiOEG46CfQxFlg1zSno93u2tAj5pOJAN41BTi+sWfqAZ5dhmvpw2PmX6d8t6sREai+njCDY+dmzu3qoO1SaTth05GZbFWVxvJI46QCd9hxiHicy1mvnJDCJ1vrLXiyBzkZgJDV8FzM9MTE2Q61IruO7gH4hGd98hAn08SGpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/iWrzJii9N8DZY4sAsOFn+iBGUfkS2hhfigGwz1NFCI=;
 b=GF1CqwpwrzJ8FXM77GGxI23RIZNUhAucv9tWpfoTgpPtNwKtVGwmeYAXDjcuVl1U4YSK72f5EsoQRYNo0vw1BjOkLmsJSp9Jjyl3WoJiL4++2KySGx9urBzG/1BTHsyU1r+t/yHafYG1Ar0sWcBILJ90h1u7ArCmKr57XFZWimE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Thu, 18 Aug
 2022 03:08:05 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::55d1:d16a:c681:2078%9]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 03:08:05 +0000
Message-ID: <143a26d6-9237-b745-ece6-ce37dc7dca9a@oracle.com>
Date:   Thu, 18 Aug 2022 11:07:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:95.0)
 Gecko/20100101 Thunderbird/95.0
Subject: Re: [PATCH] btrfs: Test xattr changes for read-only btrfs property
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>, fstests@vger.kernel.org
Cc:     linux-btrfs@vger.kernel.org, fdmanana@kernel.org
References: <20220816214051.wsw75y3mtjdsim6w@fiona>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20220816214051.wsw75y3mtjdsim6w@fiona>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44d6a182-aa8a-4c49-6ce4-08da80c6de79
X-MS-TrafficTypeDiagnostic: BLAPR10MB5329:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bhgtwt20NwCEzlvYaSOhQc8ktIGa+PK4772nEEwnHDXU5VkY9O+p6DXo98gCcwseHOcOQLg3SgTU4NaKp5p4ex7TpBTdGVDArXHW7cMCTO1cOZlmVpioh5FGYjYtcgrSfnFQAYXF7huv3Ur1W1cl+fKuD6e5mZN/2bO5VJ0Cn2+X1uIEcpm58KNexNmvHQ9XAOfxjxG5s6aly1yCXj4OrgQdHbk7QY1PfJnvOxjTCZSY+HLVxRNTRoqU3w/nHP5+QUuoMkbiqGJI/uy/JMKqxVmBKWDTmyYyeFMkz/VHPXXN5Web2cFTExJ3r4CKL+dyXzlUVA9jkXKX65IzYKdjNXWFDOX2G1Xmf50DFYsYIYdN0Eh86YcZb+kGpqxB9Z2qXRCzh/vAwtxpTOEgIos/3lJkl4fN/f9kFdVsd7/Mjvl9WUAR9vtmfgfWP3g8EeHQjcl+c1gieffb2TH9Oud5dG91FYbmlPBueXZJgyA497vw9kULJjbPZxDtlDb8zJp91/yzFMggwDe73QCZd9eCFRR0ykcj5iUxlNUMJAzif55UJXGaR8ZzUh85ytz606pqwiTT6xoRFCcI7zqeDwj0N6mhgiUan0D0QZhMTWSGn1HLj5UJyHmalKcGFyN9PVs7jUr+dcsS7N7zEByQmvP8N9Vz1V1DDI8QJbtXWrte/AeWG+qyNCP1Zk36XSO6tL2v3g6fDIZ0U4rt6hgv2aQttPQbI0jF+3eSMrEv4hBlveShfYNNCoip+mqw3rrlhl+hVEi/BfHcS/6Fj/wiTnbg1tZgCQiVaIWH2ccBEQPn0vg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(366004)(39860400002)(396003)(41300700001)(316002)(478600001)(4326008)(38100700002)(6486002)(5660300002)(8676002)(66946007)(66476007)(8936002)(66556008)(44832011)(2906002)(31696002)(36756003)(31686004)(26005)(186003)(86362001)(53546011)(6506007)(6666004)(2616005)(6512007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZnBNRkU1SHRRN0NZNUpmbElwUWdRcjlzRFBmVXNwNFMzTnlORERNVkpLUVJT?=
 =?utf-8?B?bWJ0a3BMSjUwVk13dmltVDRVdHlwWCtHREFuT04vU05COEYrQTFiSE9NQU0y?=
 =?utf-8?B?amc4MFFKRkd5KzJIZVNIVkU0eUNtajVxYVdORzFBZ25NT09CSVlZOFZIcVNP?=
 =?utf-8?B?UmFMSkYwckF1VTFvaStWbUFYelg5WG5UNnh1czA0U09FYzRSM1dkMmNXUzA1?=
 =?utf-8?B?RTFuM1F3cTNrbFZaanFMVkNsdXNENnM5cGdjb1ZEM0dDdit3WVYzMnE0VGUv?=
 =?utf-8?B?bC9sYWZJZldiU1hFdXJYTnpVNUl4Qm9ESER0Z1E3elVCZTFTS1VNMlFzLzVD?=
 =?utf-8?B?MmZ1aERjejZXTHR6Z25Benh0d1FtWlpleFo4TnBEMW1hTU9Mbkw1MnlDamxp?=
 =?utf-8?B?SHcvaXVyVnRoTkxNSktZNGczOU1QNUx0dU1qUE52aXRhU3JVd1VVbDNycWF1?=
 =?utf-8?B?UzRTT2FzSCtEZkNOVUE1djFvWjBKTlI3ZEZrc3ZBTVRrMlFkSThVbUQ5cjJy?=
 =?utf-8?B?Yjl1WVpBL0tSMzhYRE9SOVBvVDNJengrQnI5OThieEJVMTZpdEpZZk9wbUZT?=
 =?utf-8?B?Uk5aMitOZVFZZVNqbElZbTlUVUxoRXJLNGVPRmlBK21BOXJBMndVSUlSL05w?=
 =?utf-8?B?dlRnZThZRDB4cEdNUVU3VERSL3B0OWtjK3RGNHZBeFhZbE1XWUZkWXhrV3dz?=
 =?utf-8?B?cHIrZCtuVngwT2I1ZDNrelZocUZaWVBRaEEveG5MeVI4VWw4RlB0ZGo0TDRB?=
 =?utf-8?B?OGJSYTBla1RPNU9SbEJVL1pVdE9jbHNHaHM3dmhmaHJJTzE0RzFITGdjK1Na?=
 =?utf-8?B?TXJXdko5MEVtQnpSdGgzR2ZaSWpaY2dabjVsa0d6Y21nMERrM2ROZmNlRG5J?=
 =?utf-8?B?NlkzbkMyYVdPbFhER2JxdUtpWkpONEU2QnY4MDRNMGpOUTNyL0hma2JSdzRM?=
 =?utf-8?B?Skd0RkkrVWowZTdUSmF4Nnp3ZnQrS2I1SDM3cWV1T0ozc3Z4SkJxYWFaNW5y?=
 =?utf-8?B?ejB2MzY0bjB2aDVqdTNnOCsvVXk2UVZZRmN4cEhKWkdkMUMyRTkybXNnVkNa?=
 =?utf-8?B?c09OczlROGVMSUZlUmpHaXZyRXFTRGowYXU5NU5Yczk0UE5pam9jV3liM216?=
 =?utf-8?B?QUg2ajFPUkVZL2twQ2xNVzRTdmlVNmJGL0RhMWQ1aXIrcHBkMVBSV3JJSlo1?=
 =?utf-8?B?M0JtNVJuQ05KU3FJQ1ZlZkkvNlBCaDI5YVY2NnBldkVQZWgwTXBVM1pVa1RW?=
 =?utf-8?B?b0VUMFNGbnZwV1BrM0x4N285WFd1bloyUGVlemhKblpzbDNZZEN3UE5QY2M1?=
 =?utf-8?B?RGxrME9uTXRIYjc5eDhNUytmNWlGQVhOanBJWnB1SkMvdmtlYUJQTnQySGRo?=
 =?utf-8?B?RHovQ2owaGltU2xKc2lwOUxzaHVrZHZkVlZmdHVCMTN5VmQzQUQ2MG1aWUhQ?=
 =?utf-8?B?ZEppK3UzRnoxU2d6TldqNWRRRk0wd0VZQU1tUzFRNnFTQXhwQ2hSSVN3WExv?=
 =?utf-8?B?SHl1blpRUmZtOU1hY3FSbFlzYTg1OUpmNlhldTdhUHhuZm5HL2dvSUh1SHE1?=
 =?utf-8?B?WjZLZUxWOExGQWFoVmlMNTZsdkRKQ2RvUmdMcFJjZjd6VGRHaVptMlVuUzcx?=
 =?utf-8?B?b0JFUVlYT0VmYS9YbE5zRTBUNmNuUjNrTitEUENSZ2p2a0twNThoOENFN0pm?=
 =?utf-8?B?RnJmbnlrM0VTQ1BFS25NWVgybG52a0lHd0JDaklBVjRDR0dQSk5MZjBoQ280?=
 =?utf-8?B?YXR4OThsYmhwblMvT1hjTjFZbGFiOFFnYXB1aUFNSjljT2p3dXVyWkpudDVr?=
 =?utf-8?B?cGRlSnhiM3BBc0FxVTVHMmx6bmFhanYzYXVrd2JucmMxUGlBdlRYSzlIWXYz?=
 =?utf-8?B?VWJTRW9rV3Z5ZUQ2Nk9HNjJFTGZNZ2E0MXJsSEZvQXdpcXRiQlhKUU5sMEMy?=
 =?utf-8?B?Q3E2a1AvVWJUM1hQMzRKdkRHUVNMdGd5Z0lNMkNaSlN0amd1RXZHWEx0TDhD?=
 =?utf-8?B?SXJTd2t6eU1IQUJuc3pWL3BTRndiL0ZDN2M5bUFIU1VxNjI4b2tCQWJYcDdD?=
 =?utf-8?B?Z1NBb2FoREVhbnVTQm9kc2h5OFZ0cVBTWmUrQ2p5cU1hOFg0R3JuWkUraklo?=
 =?utf-8?Q?7Mm+dVKzpiZWCvKHOyyJxoV7u?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: EycM3WNJ+V8Chq33StRhmfSY1EEZhnC2d+je2yI4rfNSDvUbLamWv5mwtD/gRc1Wq8Sz3Fn7TtRRIaVEEIkO1sxnl7Nvt1I3JRRdzHTuHUZAO4dBnBXtrCG4aRwn8NaN9dTHmF8O805nJPhUX/toCH7Qj1DFTo9PyAGPzBnDm/1OUT8P637EQcytCpxn9BYdDpqHx4UeIImCKQ4n+09Te5d7wFD67/7bKG1vJVHpUBHOcBL3XdJMVw0mUv/uigFiJABwy1VNMl+VQanyEg+syfBn0V9D5za4quYoomykBIktffoLM5XF00ENUD3GoFx/OkhEMkqAL4jfiFuGyYg5a7VNq2yOVUy93gkUno96JlnH6Bi01VZzTdaSwnksQpcnFRZnZuOhfIkcoO/RjjiRI2wBsDhNm/qxhDHdZeGdhL1MXDVLtEmtdxdAHf3w+wAOTnC4HCNARmSXqoUoA0L4dZUhpVutpaVpuHG1wwrQP2h3ZcCVVL/viD/OQhSGrSwFvOG2YHNcui5qArC4tVB3PWp7sHKLTk1y37hEYIR2itmsNM8XrEFnujuju2FwSBxZ06e3UeP9zedyZBLE1vB4Vra5870pnAm9XNq57uOyazHzsSj9ZIWwB7Otf2PMEBRc6AXbpxCag0gGwj4ODO7J71ovJQ4HI0zOA3h16Pqvb6nuk8cbKv2cEiMxtRXEIdwRtVQ53iBslwzZz+gCVHaDeHaM/xdegmPqK+actjPwirTuU/W30gzeZs8yxpwWkb/DgralxuP9WYTt51QFYZL7Ixj1kHQrt8D8tEmLNwEb6n/GAYGGQjFOIaMYWLeC/p6EQx61kQ8jMhCD9uPSfpeo53kGOP6pnWjvjm5/pIlesJMFsjDmMmd3vb1j7kq20h+G
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d6a182-aa8a-4c49-6ce4-08da80c6de79
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 03:08:05.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrm6eRVVbgmlVClSy69+pEzOan4VEe03Yvm6DxNRRrm1Rll72UclOgLwt7KywqdZgqvPthNT67kEoNG0DaWmQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_01,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208180010
X-Proofpoint-ORIG-GUID: xt-OPIuTjFdVX0OZ-GVltiZ6T3sMpXvJ
X-Proofpoint-GUID: xt-OPIuTjFdVX0OZ-GVltiZ6T3sMpXvJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org




On 8/17/22 05:40, Goldwyn Rodrigues wrote:
> Test creation, modification and deletion of xattr for a BTRFS filesystem
> which has the read-only property set to true.
> 
> Re-test the same after BTRFS read-only property is set to false.
> 
> This tests the bug for "security.*" modifications which escape
> xattr_permission(), because security parameters are let through
> in xattr_permission(), without checks from
> inode_permission()->btrfs_permission(). There is no restriction on
> security.* from VFS and decision is left to the underlying filesystem.
> 
> Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
> 
> diff --git a/tests/btrfs/273 b/tests/btrfs/273
> new file mode 100755
> index 00000000..ec7d264d
> --- /dev/null
> +++ b/tests/btrfs/273
> @@ -0,0 +1,78 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2022 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# FS QA Test No. 273
> +#
> +# Test that no xattr can be changed once btrfs property is set to RO
> +#
> +. ./common/preamble
> +_begin_fstest auto quick attr
> +
> +# Import common functions.
> +#. ./common/filter
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_attrs
> +_require_btrfs_command "property"
> +_require_scratch
> +
> +_scratch_mkfs > /dev/null 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +FILENAME=$SCRATCH_MNT/foo
> +
> +set_xattr() {
> +	local value=$1
> +	$SETFATTR_PROG -n "user.one" -v $value $FILENAME
> +	$SETFATTR_PROG -n "security.one" -v $value $FILENAME
> +	$SETFATTR_PROG -n "trusted.one" -v $value $FILENAME
> +}
> +
> +get_xattr() {
> +	$GETFATTR_PROG -n "user.one" $FILENAME
> +	$GETFATTR_PROG -n "security.one" $FILENAME
> +	$GETFATTR_PROG -n "trusted.one" $FILENAME
> +}
> +
> +del_xattr() {
> +	$SETFATTR_PROG -x "user.one" $FILENAME
> +	$SETFATTR_PROG -x "security.one" $FILENAME
> +	$SETFATTR_PROG -x "trusted.one" $FILENAME
> +}
> +

This output contains mnt references that need to be filtered.
Filter _filter_scratch should help.



> +# Create a test file.
> +echo "hello world" > $FILENAME
> +
> +set_xattr 1
> +
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro true
> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
> +
> +# Attempt to change values of RO (property) filesystem
> +set_xattr 2
> +
> +# Check the values of RO (property) filesystem is not changed
> +get_xattr
> +
> +# Attempt to remove xattr from RO (property) filesystem
> +del_xattr
> +
> +# Change filesystem property RO to false
> +
> +$BTRFS_UTIL_PROG property set $SCRATCH_MNT ro false
> +$BTRFS_UTIL_PROG property get $SCRATCH_MNT ro
> +
> +# Change the xattrs after RO is false

> +set_xattr 2
> +

  Nit:  We are reusing the value "2" and changing it to "3"  makes it
  unique and so the debugging easier.


> +# Get the changed values
> +get_xattr
> +
> +# Remove xattr
> +del_xattr
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/273.out b/tests/btrfs/273.out
> new file mode 100644
> index 00000000..f6fca029
> --- /dev/null
> +++ b/tests/btrfs/273.out
> @@ -0,0 +1,33 @@
> +QA output created by 273
> +ro=true
> +setfattr: /scratch/foo: Read-only file system
> +setfattr: /scratch/foo: Read-only file system
> +setfattr: /scratch/foo: Read-only file system
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +user.one="1"
> +
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +security.one="1"
> +
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +trusted.one="1"
> +
> +setfattr: /scratch/foo: Read-only file system
> +setfattr: /scratch/foo: Read-only file system
> +setfattr: /scratch/foo: Read-only file system
> +ro=false
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +user.one="2"
> +
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +security.one="2"
> +
> +getfattr: Removing leading '/' from absolute path names
> +# file: scratch/foo
> +trusted.one="2"


> +

Nit: A whitespace.

Thanks.


