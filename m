Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6C756BD4
	for <lists+linux-btrfs@lfdr.de>; Mon, 17 Jul 2023 20:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjGQSXR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 17 Jul 2023 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjGQSWs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 17 Jul 2023 14:22:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05B0B2
        for <linux-btrfs@vger.kernel.org>; Mon, 17 Jul 2023 11:22:31 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HF0WoD029452;
        Mon, 17 Jul 2023 18:22:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=nL8W9qAJLpSztwpUVIEmuL6D27fdp8pWDm2c6a28BjI=;
 b=0VsGXdrjWt2KoBqqAXjs5UG+mx0XP36D5pZs1oAhc3HvjJLN7Mw8vB/tYv3HuNTGpvLR
 L2dQYnKSYUsdfKr+p8zXnD/Dx6rvJ6IqwliCiykGOCrGWltVUSa2J08P9xQIs4emEYZh
 E6TZ7XyW4aF346dNapXJhKXR4weD+2cjL35x7Rdc669T/xPRPo9eQWcMqLYrBZWbSuks
 mQ4Je45sIe7TzoS7o4i/oBjR6HHinC2VoWrBfIpWuFQLppv2oDHDCO5uAurpDPXsJKnu
 bSmHyT2MkqldKpAwKO57Ovg7ddFe6ZXZK/d6krxzjip2xnO42jo430VPVytlGK9fa+5p Jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run89udmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 18:22:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HH16qO007757;
        Mon, 17 Jul 2023 18:22:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw3sv8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 18:22:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOiP3G9xTBCdJzXjj/g3z+WC0MSWUq8aTI1PKwLg+8Q/haMm62GxDtDRLpey5TCfRs3at7lqLPF2nXsMWc7ICd0oYJ8b0TeJInjEfh/eYBKpYWsve1szbTehug9/tZ6FP0HDTtY8E3A+I5xBIWfE4ekuvS0AmYFgaS8iAE/lVkI3qFeTQLae1H6VFf9tVJotmRfDkZMO2vR71O4SzPfpn/AhrBqIrvjX5537Y6sIkqgZjBjdj7iZqZvYjVzE2uOpA5wyUxkQC8krbZyXP3L2V9Y/Q9OZbak8t9xv+gnbHh6Mr4lf6c78LMltuVy3vZ2FyiEIb/HtwVSwOHkzV+GULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL8W9qAJLpSztwpUVIEmuL6D27fdp8pWDm2c6a28BjI=;
 b=W3rLakrCwsBq14irn5N0vHhSZKlqjZlN1ns1RKA3yenMt8by22NMW7IXtJE27jSdqJJLGEP3Pk0lnxzH3RWCVtldgNp1y7hcT0bIEQU0qA9gRgdwtnanPLSGFkUeUn5fHxgLVMlbX2/y95SXgDetSoZsH3L3MkzNBn+5V7nssuNu55WCRn0Z3jrYtOmRjb0IA9aQOz/0hC+E6ILhKvXdK0e5JPo+BWyCM2VVULvfPDyhGYu2LVD4C0MJMNx08pSnWSArZVKGot6zqv0EOxSc1Onp+bMwj+V2L9785TsAAw1USOranbJzpaLP4+E9dM9g19Q1Ylga+L/XanNGtGyLtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL8W9qAJLpSztwpUVIEmuL6D27fdp8pWDm2c6a28BjI=;
 b=yvkqsry8B+DL8ya0wJfIRsyJfzNvv7dOxij8hBjcvQdA06fTEJv5bFsCPs90hlzy2u3PXjTNvM7wJknMKL9Io29+OTyFaQry6cWR/xKM7TckBQE1WPaWe59IWAFGNLp04qmcDq4e3Ce3J3cSWdVmwuLvoTndDGwdpVKoji2dWmE=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by BL3PR10MB6259.namprd10.prod.outlook.com (2603:10b6:208:38e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 18:22:22 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::a42d:1dc1:64e1:f814%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 18:22:22 +0000
Message-ID: <21fbff59-909f-ff39-1b35-197fe14be4b1@oracle.com>
Date:   Tue, 18 Jul 2023 02:22:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 02/11] btrfs-progs: call warn() for missing device
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1688724045.git.anand.jain@oracle.com>
 <e4e0299f46b9b4715039cd74f90944d9357446af.1688724045.git.anand.jain@oracle.com>
 <20230713184802.GC30916@twin.jikos.cz>
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <20230713184802.GC30916@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|BL3PR10MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 9559b701-3b12-4935-511b-08db86f2c349
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SiF4oHdah7OXYidgP9rA7ObrcYs1c6syDugykdVDTpyoro7SuJNDVMpCnvL6cRReTOSy3ATHYORCN18CUZkGya8txjtcwVhpOp7KrW3t1afoa+uPvDNi7vDghmJ/3dWB229q8k1qM+2psXw69rY+l5pG4E/+4K4Ci+Sau6C1zXMkjQcC0nXtBE9Dt2NySmQULD4zt4puv2Ft0Iq+MPaVs7FSoG3UKOXF+/+AP52XL83VKk5e7hMUgjZV9kSC95Q9nyVE9UhOvJFMTVcElH86GZW/aYHDAn9emoHRwOct3S4/1RiCwZz/M/yH45JGS1EqPqGh7YdNuWBnkBVrJa7JEKvyBNRMU3kyy3CvP6oJaAGppDutvQYO5ihzKN2ED0FtTsRO6WdVRHdxLshTrTwhjB5R9GNb578/3qy6pMddXDlixbllFJwjjYiDq/rTg2ipdXep5IL7YfmjDH0b1pIZ/9ArZLN4lYTIrkgytTs1PAzQub3KJB0hkQs2fxfVebKTEzdQEU4ymHnXTCGvsWNRZvsKvvw9GAJlI9MmCLZgXaPijgFby/Ovjc2Np2StRRImz0kdceJ6fjw7ffkeRAFer5oV0zGZTf3G5cACDb4Hj8sTtmiCpyyzsvWoSvZtjdHZEUXtctJhPoUGYbLPBP3J1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(31686004)(2906002)(478600001)(6486002)(6666004)(8936002)(36756003)(8676002)(44832011)(66556008)(41300700001)(66476007)(316002)(4326008)(66946007)(6916009)(83380400001)(38100700002)(86362001)(6512007)(31696002)(53546011)(5660300002)(26005)(2616005)(186003)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWtYenF1Q2FRR3YyQkVBWVFRQ3JMWlZCSnJ4SUVvMzFWeE84VzFFUldIOEJi?=
 =?utf-8?B?VS8rSkVMN2V2aXdMeG43c1Y3Y2UwWmU1Vk44UzRzUk4wOGFmYXBhYk1YaHBl?=
 =?utf-8?B?c2JIZklqVzc5S2Zic2wyRUUwNmtYSzA1eVFUTkN6NXVxdnVmUTlDZzdLekN4?=
 =?utf-8?B?Y2Y0clpIZzk1QkQ2bXQyUFEvK0lVaEFvVVNKWWN0bnZVR04vNE9tdmM1d2xj?=
 =?utf-8?B?VkV0eWViZ1BTNm9UM0ZqNUkwb0pMZmFwV2ZIc2Q2TUlKZCtHeWFYOTlLb1Yv?=
 =?utf-8?B?UnJTQXZGdlk0SWZDb2w2OWNtZjN6TEh6WTRTd3M3SHQxeGJVM3Vtcm9EZnhH?=
 =?utf-8?B?bDFxZ29qZm5Ic2ZZQWhFV3pqcXJRei9IN29qUk5pZHUrVnNlQlNVUk5sdGE4?=
 =?utf-8?B?eVVxZWpzMGJtWEJ2Q1BxVnJ1WnFDbVdqclZCWmovM0l4UTQ1dkVRVG1MWkI0?=
 =?utf-8?B?VzlLTVh0akExS1lNblJUa1QzYk5vdWh3MWlrbFFock1KYVhKbVpPUDVxcWRU?=
 =?utf-8?B?Z2F5MTBRcXpRUEdSR29YQW1Pb2ZoSnZ6SlNaaVdscG43Q0Zud1I1V3dmQWhB?=
 =?utf-8?B?OUFJVDRqRnc4UmNucWxYdkNqSnBBRWNhNk5GdUhmWUFmeGgzL01UL1VFYWRM?=
 =?utf-8?B?bHNlaHo4NTlWeERHWk05UVRJdnJvcjRUYmtUdWtUUXB2NkJveGR4MHpoN1FZ?=
 =?utf-8?B?cWZGdWVXN1NzMmJtdFdvaWIrdlFydElUVHFhQk1yZWZjT1craXVEMGdnY1dw?=
 =?utf-8?B?YlRxb1h0TUozYk12OUpQZ20wNkpVTXNOR2tQSzVVemwxMHo1azdYTHl4STNr?=
 =?utf-8?B?bnJybVJUblBqOXZnUzdJYmlleE1rTlNqR2h2emh3a3BYMDQxTCtoM2o2ZGJK?=
 =?utf-8?B?VnMvQTdSdWFjSzVLNE1NaEVlYUJCWkx3T1RPTzJxaUsxbnBnRzN0Ulc0LzdS?=
 =?utf-8?B?T29FbkNNY0JxREE3UGQrQml1cHVnb0MyTUJFQXR0SEcvZmtFVzRvOFVMbkJE?=
 =?utf-8?B?VG1CdVg1QnFaTDBSZ3U5cG9WY0kzMVRuOENFNGd0TTBXdlZXWHpRU0hmdjNv?=
 =?utf-8?B?Sk5Id2V6NndWQ3JncXA0UDVFM0JOenZoa2lRczluUFZlZUs3aEpFZnpKajZO?=
 =?utf-8?B?U08yNE14eU9iZE5tMy9ueDJDVXFVL2txNGY2Z0ZQZEZKaXNvazl5aXd5VE9V?=
 =?utf-8?B?eWdWejNCU2R6TUNKVFlDUGhWRWswWXBLL0FIVmdxUFY0cWJjVXhJTklkQ3JU?=
 =?utf-8?B?RkYzZnR5d1g2NGJYbUtDQURVcVl3VytKZm5vbWoyK1M0LzdqNDhpdEZDMkRz?=
 =?utf-8?B?VkZocFM1RS85bU44Nk5CSWF5bzAxYlpaekFxSWI5Y1RYb0RodnJQM280cWJI?=
 =?utf-8?B?TUxHdUpZQzZDYnlEanZBVDMweVdDckx1SmRWSHJObG1td2JEclBWbkJjUVha?=
 =?utf-8?B?UzVxTUlFN2lnVEtJV0toTWN0clVBQVVrdlZmNjZrdnlvQmUxM0c5aWVRQ2lO?=
 =?utf-8?B?bHpWTnpnejBMLy9lSkI1M0dNcmgvOW5PU2U4V0JZMXNsWmFHWHlwMWgxQ1Aw?=
 =?utf-8?B?KzV4dE9qTTFhSXVhRkFlYjRoUndoN3Bmb3N1eXU1cjhQU3pyL2dDODE0Yzk4?=
 =?utf-8?B?ZGJqR1JCRU1XT25aR251alowRWhJbGEzOWNsMUtDcG91K0tkb3FENW1uZGVQ?=
 =?utf-8?B?eXNwOEN4M0xWcENNaXZwQjdudkVzSk0rQzNaQjIwWWljdEc5ZnZkRUhLZXlj?=
 =?utf-8?B?Q240bmp5YTJieElPNUp3NXNaQUFYd210SjZ2NVlBZmd5b3g5aUNWMkdhVi9H?=
 =?utf-8?B?U29qNWorT2pleFM5SjFaS04wTVl3VXlWU1dZWFJPcVd2Wjk0ejZ1MktMcEpi?=
 =?utf-8?B?M25TZWpnc1p2M3p3aVdINmNmR1I0V2JiazFzb2duZHRRZ0FlOHU1N1BnNEdo?=
 =?utf-8?B?b09sdDJrdm9weHdGM0NKRjNwc3AraktmTm1ZenJpS0NORzNsU2J4RFFvNGlz?=
 =?utf-8?B?VER1bGFXSC9RRDFNck1PTmxvRjZaelllVXBnSUx1SlFjZzRoUms5a2RSZ29o?=
 =?utf-8?B?Y2xUTWprL1B6a1dpc2hpcUJHc2t6cGxNb3RSempaRmMwNUQvZzZaVjV4NWVF?=
 =?utf-8?Q?VqyjK/ly4SDj1yXKkfGkyl5oY?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0Ka+HlIduxmABFmxHMghwgvXKYz/IJ4CHp+Oz88FRRgylI4YUXwdJA3+/UOnI0y6idFaMLeRxxHXDkN48+dyU7SUa7ATSO4YeEd4gJaV8MNl+ePCukFBo9QicFPD8CYiRBZ9TxsjcG9uaF3oIM87km2PDMwRcqN/+xSnSZhY9XUd22AesWN9o+l6ocbpZEDhaZiT+u2mI+nmRQv9wlD93NHCDC/XA/+loxgd7UEH+UPQ8fCpM/rarsW8yPzlJsuk3k0nGha7Ebb1a1FwAqU5XRQG1oDYx7eGvT5SB85Y/wdswaDqx60FFatJjqHpD3MFPqe1AbPBCWaIBi1gCU86RI/56J1GuVETC/ssmq+cYwZRKzm0zszezM21i0bPnonA1i9UZ/vBjSejqU2EZdXGtKXRaW78EHsDs96SuRLr/zH5w0b1IHAXhwBavqlEPvp1jeUrj48wDbBLMqwY8fQUOdHUVJp5M+zs579uX7Idu+FBQQCVBze2jrEQX3QsyTYYyQB8VxiMFY48mbA/l/A40M7/c91AYAeAMGUH/dEy83U5qqdohCc3sw6725N/UQtJpW6C59pPKEKwH1z9zfJxgLrDboStVCYYpelMeiOfJmjrSAAeEDvdMIqp2ceYAOpMES3PetkvTagUyWtxZ91Aw1dgvY9j90o9VyYmGIk7RTi1Bs5v0WLZy7I6AoDXijugV8L4mLFnYBz0f0lIbn5Aro+59gz6cnbayp8ZX+jUKzqkTJSqZUhjeHVUkXt7XOW66j4nrt4o42x5gwffI0w9whQDAV4NRBa7QBJ4CZcw4jI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9559b701-3b12-4935-511b-08db86f2c349
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 18:22:22.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2eua6PDtk5fGU+IPyobatU5W/tX1EQ2Tp1zvoJKEV1pAtabTJSHt/cGlP+t7kGkY0jNSahIbsaD9Mg457/UsjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_13,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307170167
X-Proofpoint-ORIG-GUID: s6mtJxkbLPW5mTiq09UphNGAXilp0YcB
X-Proofpoint-GUID: s6mtJxkbLPW5mTiq09UphNGAXilp0YcB
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 14/07/2023 02:48, David Sterba wrote:
> On Fri, Jul 07, 2023 at 11:52:32PM +0800, Anand Jain wrote:
>> When we add a struct btrfs_device for the missing device, announce a
>> warning indicating that a device is missing.
>>
>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>> ---
>>   kernel-shared/volumes.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel-shared/volumes.c b/kernel-shared/volumes.c
>> index 92282524867d..d20cb3177a34 100644
>> --- a/kernel-shared/volumes.c
>> +++ b/kernel-shared/volumes.c
>> @@ -2252,6 +2252,7 @@ static int read_one_dev(struct btrfs_fs_info *fs_info,
>>   
>>   	device = btrfs_find_device(fs_info, devid, dev_uuid, fs_uuid);
>>   	if (!device) {
>> +		warning("device id %llu is missing", devid);
> 
> read_one_dev() is a low level helper that should not print any messages,
> the calling context is not known. If you really want to print such
> message then please move it to the appropriate caller.

The motivation for adding the warning comes from the following test:
Despite the missing device, btrfstune -m was still able to change
the fsid.

     $ mkfs.btrfs -f -dsingle -msingle /dev/sdb1 /dev/sdb2
     $ wipefs -a /dev/sdb2
     $ btrfstune -m /dev/sdb1

This series fixes the bug; that is, it makes btrfstune fail in this
test case and this particular patch reports the missing device.

Which is similar to the behavior in the kernel code.

read_one_dev() function is only used by btrfs_read_chunk_tree(),
which is not aware of the missing device through the returned
error code.

Perhaps we can make an exception here?

Thanks.
> 
>>   		device = kzalloc(sizeof(*device), GFP_NOFS);
>>   		if (!device)
>>   			return -ENOMEM;
>> -- 
>> 2.39.3
