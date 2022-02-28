Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC04C61C6
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 04:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiB1D0D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 27 Feb 2022 22:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232807AbiB1D0C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 27 Feb 2022 22:26:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388954F86
        for <linux-btrfs@vger.kernel.org>; Sun, 27 Feb 2022 19:25:22 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21RMdVx4021527;
        Mon, 28 Feb 2022 03:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=V9GJ7M5gLKKz0NJUSwyoGnnE5WmdgAKsLThNe1/ofVk=;
 b=E9HCbHXm+dIPZ2RxFE6bObTZEASAFMM1Qcf9hMoYXEZjn1owtFMRhW3nB6yfwoK2C5EG
 byreEwLxMaPhE7iQbvYisQL9WmSG1EYELoo/ezf0FJ8QPCidG/zjQSdyguI77cqnT/2c
 ykEJediduKTezLeMeGa2vv6j/nsTcIZGKunuSKD+MApcbWJnt5xUGcZMN6lDAzX1HlCK
 +DwsGyb4tfy7pXOTLiD+05p2/IE6E2Ar+H8U36OzxFQdqQuTKq2xAqF8dp+BLsqEysVP
 vvPkQdoJSyN7MQLVf2IZxEue2dbnSKnEarFUgj2J1dC1j0xxlFsmYsrwbtXpl51AUmmi HQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efat1u0ju-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:25:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S3Gh7b106731;
        Mon, 28 Feb 2022 03:25:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by aserp3020.oracle.com with ESMTP id 3efc12g7f2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 03:25:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNU80ZbalhkG88Q2aSeVUdM7TjXZg83bpElb8N8MMDikb7TzYrViTHiv+h0AP4S7p5NVOODBC/lo9zIJqWg1OjDFCW/sagx/fpQ/SSIDvtPyq9xBfAmZ+HJIVR+GlJCAOuRJx+zlca0PZwoRHQ6UPSLGRLnjomwcnDoT6El3qRzh0zgCp/ZuT9MPgNS1rmH7HPLVNl+kNLy75FIwW6Xbtnwb5EgWZ2dAIyWIldEeKqCxMTTpcf4/4leeM6WMgzqSl0WM5O06KADBaV3QRLsqhASvB8rv/Ve3vEObInvct0y833Njyt9jy4l4FHV9iItVkkRisIxXXFWsB5IPmdcUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9GJ7M5gLKKz0NJUSwyoGnnE5WmdgAKsLThNe1/ofVk=;
 b=ZmzngxEspxbR2+pzLpweBt+8oMX5naCjseCGAlrH6KmdWQXKQxASrwXJBR35IJ6W22fKYXUr3B0k8cCd8+P6zel5Yk6jxwpb6pzYrLBXs6J+NYHVta4XEiv3zhJI83vTdxS5Qy/Eknl1Acc6ou0sgu2hzoDjRSLPZQo3FGdNpaMKBtDjE+H/a0AUb7slifREx4cNkbtpkoxtmjDm5h5Z03vZTjzS3uUdwSFz+xbjg0oi9hhMVrLteSjFtJzcKxW9wPiA/zUWNhJuTY2ZeNEWaezIIrSxEVUy4+akVuNOoWGaAbwg4nAOgFisrxGDRVlShRG2O0LhVPTklyNwD1Keyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9GJ7M5gLKKz0NJUSwyoGnnE5WmdgAKsLThNe1/ofVk=;
 b=Ju/EuYf+Fwa1k3PAoKram6zdM8nsKEX3F7vsGKyeJWHmTLWSTwr7/dsq0WpCi6ML2D5RUZ3uyV5dQpSe38uFf+qxqFnNGb8Jk7V8JkCEtNufHFFDDIEOVjF8Vw/iaUPspvmUhRc+tgdIpY9C8kJ7+UbE7+VMxImDYsvvN9q7nq0=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SJ0PR10MB4655.namprd10.prod.outlook.com (2603:10b6:a03:2df::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 03:25:10 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 03:25:09 +0000
Message-ID: <508772bc-237a-552b-5b63-80827a5b268a@oracle.com>
Date:   Mon, 28 Feb 2022 11:24:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: Seed device is broken, again.
Content-Language: en-US
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Qu Wenruo <wqu@suse.com>
Cc:     dsterba@suse.cz,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
References: <88176dfc-2500-1e9c-bac0-5e293b2c0b5c@suse.com>
 <20220225114729.GE12643@twin.jikos.cz>
 <56a6fe34-7556-c6c3-68da-f3ada22bd5ba@gmx.com>
 <YhkrfyzmCgOGG+5n@relinquished.localdomain>
 <f4525052-8938-42f9-543d-c333200353dd@gmx.com>
 <43aea7a1-7b4b-8285-020b-7747a29dc9a6@oracle.com>
 <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <00f162f7-774c-b7d4-9d1f-e04cc89b2aee@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0013.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::9) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54b43dc8-c1a3-409b-73ec-08d9fa69ec41
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4655:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB46550CE5A3666AB5D9E4219CE5019@SJ0PR10MB4655.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /qafPfhIfT9HVMqOLLp36wA/hm/nJ3RI5cwUb9LpHMf/lAn4cHWPZqRj6WysNURcns9hfGK9SgigpCRRgHZd9h05/sNkJeShjnK+m0pAdhy8vJbPlXzWFghzZKvTYiEkxg5XS7LZ8I0gobrHfZPilao6EEbKHIZC8hGIkQlg17HS96mgQdTRHebS1HC4uwWlR+91nBpDKHKleF7DVxOLXCDeoDaz3GatCJWcozgkCGm4zdHqDowKwHAwyW+cRPAhXhJnGjIWxq268k3aX0DiQDvml3hAvAVhiPmlRucnQUfSVJi+9lA+VzTl9PeucrGaX1iK17d3W2M69+8IJJ/vINs61gy+sZ4h6zhQeZNtjBzEKVkLu/2VBhm7htakXer2e/F7PMN5ertg+5275YeD52T7LOBkQ5OIHdlY7eKhhmfV2gT6OA1zdAGqgaisnpTld7ae3MY5mdsXTKAC9fUCCCBdanmoZ1JGoFCQOi3tZI7+VD3SCymg1aoh/sGrNZxdH3DAGkZ+IbO6FCYBFV0CMMyX0Xdp5bfSXzDLAiLPLyXcw8j/ZU9lAhIuHX46z9O/TnEqLMGDyWRIEY5NHNroVj+QoRmOCOoc8Zbrpl7E3wC9CPeYKnT5z3uHWqeK7/fuNqW22JDs9KpinDHyKpR+DuF78RN1ROKg1u+eUA9yLc6orFtR7lolUSF3Fmeewv9hg/6bAyEJBscEH4LTcMGdB2GmKW4HD+4H+pg8GLCLsg5/iUyTH/bx3bgM/DUWd8NN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(66556008)(66476007)(66946007)(110136005)(54906003)(6506007)(316002)(8676002)(86362001)(2906002)(44832011)(31696002)(38100700002)(5660300002)(2616005)(8936002)(6512007)(26005)(186003)(6486002)(508600001)(53546011)(6666004)(83380400001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUxPdGw3OTRMb3l3QTJ4bVk0N3VvQ3dPemJPa05yMHRVN081WlNvRnIyZkVT?=
 =?utf-8?B?cjVQRFFpS2JYZ094S1A3b3RRRVczaHV3WEZvdlVTRTM0WFVQbEdHVkp2OUM4?=
 =?utf-8?B?R1Q3bmN6S2EvaXF0MG4zUk9BYnFQZHNucEdab3ZJMmRPYzdaT0xqTyt1TFlm?=
 =?utf-8?B?Vk80bTZsZ1FsSVB1ZUpJeUZCc09OVzhlYmFyZm1RWlZlV0VScldzYncvb1dG?=
 =?utf-8?B?d0piZUpXcldtSG5BUDVleVpBYjViZkRYcHM0Ky9nVWNRN0N5ZUc4R3lIUUpn?=
 =?utf-8?B?cGp0Ulp6R3JZTnZ3dHRKNHpjczdEWlVLNEFiTXRLRjZkM0g1eGxMRnYvY2E3?=
 =?utf-8?B?aDJpM1MvcVYwMWlHWE5oNm9ITDRPWmtvVUV4NzVDVDFvWDlnVjBYM2QxblBz?=
 =?utf-8?B?S0Z5MHVEMzBHSDJEdlZkQ0pDejVWZ24vY0JNMUZxNEYwNUY5ZmlqSVRkeEJI?=
 =?utf-8?B?dHNreUQzZEZKenRWT2tod3hqbHMrRkUwWWRtR0tGRlVvQkcxVUNhUlk4VVV1?=
 =?utf-8?B?L0tEZnJzQ3M1VDMrOFZyVXhBajdvcVhFNmNUY2xMam5qejd6bzc2bjRUZnBD?=
 =?utf-8?B?bENCTURibkhhZEVtc1hBaWZSa2lYZGgrVHlRMXk0RG5vQTdoS0huMlB3NmVE?=
 =?utf-8?B?MSt5U1lKVGRsMHpBR05HVzFFVW5MaUd6dFVBNnFGRHljdDZkenpiM2xIMnJX?=
 =?utf-8?B?Qnl2aUdIOXM5QTZuTVhsVlNIek9seEU5c0VsMmJneE9NOEw2OXczZFB0RnpU?=
 =?utf-8?B?WE1zNGFaejlIK3BjcHgvNFNRTEpjam9Xckl0SmExUHIwUXFvREc1SlkxNko5?=
 =?utf-8?B?R0NQdUQveXFXYXdQZktqbEtmM0RBbEJhbVpQUEJhamd6UElIdzRUNUIzWUJR?=
 =?utf-8?B?bm9UU0RpL3g3azBSRVVZYTJteG9Ic2VqQStVWmNBc1RuS3U4azF0SEVpZ3ZB?=
 =?utf-8?B?Z3FFalJNUEc3eCt6ejVVM2EzM1BrVGRoZlErbk56aHlYQm1ieWJtQnN5YWxp?=
 =?utf-8?B?VWIrait3V1FtZ3BqOWJPVmo5Unl6Q1pDMkphVytIaEd0dG4zY1hLOWhndS9n?=
 =?utf-8?B?blo4K0wyT3YxaFhJKzNXUXVIZG5IdjQreE9JSDJhWms5QXArUEVmM2NhK2NK?=
 =?utf-8?B?UUNTVHZING9QdHMwZ2d4Z3lMMy9WSkMxVHBjNU55MXkwcWp1ZkptOFlBc056?=
 =?utf-8?B?R2YxRUpsSHpGdEFscS9QU2NxVzFJOE1ncGxHNzBXTUdOQ1BacllERmdzcVpE?=
 =?utf-8?B?K3FCM3dKNnZUbmcvVHR1eGFVbkVhRThURWZrSFR1Q09ublBNTXRqNlk4TDAx?=
 =?utf-8?B?T1FNbytuMUlUMGM0cFA2c0E5RGVJdk9ScnNOcmxMU2o0NVJndmkyUXpBWC9z?=
 =?utf-8?B?ckxLVUZYU3MrT081Rjk3R2hoYW10eGVObGVmYzJQTndLd0ZUVnpiNEdEVHdj?=
 =?utf-8?B?dWhGOUhZMXhqM1hENVZsbTNnNjBpZWlNeHZxalIrTExPaHFiNWljeTZ5RkhL?=
 =?utf-8?B?ME5rb2VBVHF0cWJtQStjNVEzbmcvaGExY3dGUjVPMHMyVE9QelhQOFlaQURW?=
 =?utf-8?B?Q1NsZlJxYTRUekVNdVlqTjFCb0kyT0E3TGx2eGZJbkE4cDVKZENaZWhFM09T?=
 =?utf-8?B?YlU0eEFFMHpoYXhoNERVckI0VnBKZVhBNnpkbEZHTkZLa29Ld3Q4aWVKVm5r?=
 =?utf-8?B?RlUwaU8vZ04rYzR1aDg1azExc2x1YThnS1E0aGNYbjhDZVdMOUlISWVhUEZS?=
 =?utf-8?B?dGYvL0hZbUZlTGV6aWpVendiYkVxMFVPMEc0dTNPS0U0QkpERWRUcUdELy8v?=
 =?utf-8?B?cTFHd2dqVVBlaExYQjM2ZUVkVS9RYmxQU2d4TVFVblRpaHYrOG8wK2hMblZi?=
 =?utf-8?B?VHdRb1NGQW9IUEw2ejluaUV2MllNNmhxeWE2UEJxeUp1L3BZb2JxVTllMkcr?=
 =?utf-8?B?cG5kQkUvQlJFZTVYY0tKdGtHcTVGSXBrUCtFWDY0akprRWRGVlJJTXlKMHkz?=
 =?utf-8?B?UTVNc3IyeVVod2lUYlg1d1dCai9lMEd3QTlBc0twTzJFMVpIZmREVVBSR0pY?=
 =?utf-8?B?MHlHeWVXMjhBZFQ0OWxIVExSVzh5aEd5MUd1U1JrQUxtY1c0djVKVTZyQmJ5?=
 =?utf-8?B?QzMySit5NVNDKzNtZmRrMnI3T2NUb0VHaVNmSERZdU14VkR0MkJXeW14U29p?=
 =?utf-8?Q?+5y5Pi1+55aoPfxD+o4aJCg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54b43dc8-c1a3-409b-73ec-08d9fa69ec41
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 03:25:09.4347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SFUe1zNMT5ZV3kTf0ZmZzVQeltiJ1wh4Jj4UmwkfdP+Ba0wY8od0Rlq22qd/uJjkcC7JH3MeJdvbtUrjsdau4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4655
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280019
X-Proofpoint-GUID: NCBU1vFSnfpks8Ld0TBkEaCKcUb9HEG0
X-Proofpoint-ORIG-GUID: NCBU1vFSnfpks8Ld0TBkEaCKcUb9HEG0
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 28/02/2022 10:35, Qu Wenruo wrote:
> 
> 
> On 2022/2/28 10:01, Anand Jain wrote:
>> On 28/02/2022 07:56, Qu Wenruo wrote:
>>>
>>>
>>> On 2022/2/26 03:18, Omar Sandoval wrote:
>>>> On Fri, Feb 25, 2022 at 09:36:32PM +0800, Qu Wenruo wrote:
>>>>>
>>>>>
>>>>> On 2022/2/25 19:47, David Sterba wrote:
>>>>>> On Fri, Feb 25, 2022 at 06:08:20PM +0800, Qu Wenruo wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> The very basic seed device usage is broken again:
>>>>>>>
>>>>>>>     mkfs.btrfs -f $dev1 > /dev/null
>>>>>>>     btrfstune -S 1 $dev1
>>>>>>>     mount $dev1 $mnt
>>>>>>>     btrfs dev add $dev2 $mnt
>>>>>>>     umount $mnt
>>>>>>>
>>>>>>>
>>>>>>> I'm not sure how many guys are really using seed device.
>>>>>>>
>>>>>>> But I see a lot of weird operations, like calling a definite write
>>>>>>> operation (device add) on a RO mounted fs.
>>>>>>
>>>>>> That's how the seeding device works, in what way would you want to do
>>>>>> the ro->rw change?
>>>>>
>>>>> In progs-only, so that in kernel we can make dev add ioctl as a 
>>>>> real RW
>>>>> operation, not adding an exception for dev add.
>>>>>
>>>>>>
>>>>>>> Can we make at least the seed sprouting part into btrfs-progs
>>>>>>> instead?
>>>>>>
>>>>>> How? What do you mean? This is an in kernel operation that is done
>>>>>> on a
>>>>>> mounted filesystem, progs can't do that.
>>>>>
>>>>> Why not?
>>>>>
>>>>> Progs has the same ability to read-write the fs, I see no reason 
>>>>> why we
>>>>> shouldn't do it in user space.
>>>>>
>>>>> We're just adding a device, update related trees (which will only be
>>>>> written to the new device). I see no special reason why it can't be
>>>>> done
>>>>> in user space.
>>>>>
>>>>> Furthermore, the ability to add device in user space can be a good
>>>>> safenet for some ENOSPC space.
>>>>>
>>>>>>
>>>>>>> And can seed device even support the upcoming extent-tree-v2?
>>>>>>
>>>>>> I should, it operates on the device level.
>>>>>>
>>>>>>> Personally speaking I prefer to mark seed device deprecated
>>>>>>> completely.
>>>>>>
>>>>>> If we did that with every feature some developer does not like we'd
>>>>>> have
>>>>>> nothing left you know. Seeding is a documented usecase, as long as it
>>>>>> works it's fine to have it available.
>>>>>
>>>>> A documented usecase doesn't mean it can't be deprecated.
>>>>>
>>>>> Furthermore, a documented use case doesn't validate the use case
>>>>> itself.
>>>>>
>>>>> So, please tell me when did you use seed device last time?
>>>>> Or anyone in the mail list, please tell me some real world usecase for
>>>>> seed devices.
>>>>>
>>>>> I did remember some planned use case like a way to use seed device 
>>>>> as a
>>>>> VM/container template, but no, it doesn't get much attention.
>>>>>
>>>>>
>>>>> I'm not asking for deprecate the feature just because I don't like it.
>>>>>
>>>>> This feature is asking for too many exceptions, from the extra
>>>>> fs_devices hack (we have in fact two fs_devices, one for rw devices,
>>>>> one
>>>>> for seed only), to the dev add ioctl.
>>>>>
>>>>> But the little benefit is not really worthy for the cost.
>>>>
>>>> We use seed devices in production. The use case is for servers where we
>>>> don't want to persist any sensitive data. The seed device contains a
>>>> basic boot environment, then we sprout it with a dm-crypt device and
>>>> throw away the encryption key. This ensures that nothing sensitive can
>>>> ever be recovered. We previously did this with overlayfs, but seed
>>>> devices ended up working better for reasons I don't remember.
>>>>
>>>> Davide Cavalca also told me that "Fedora is also interested in
>>>> leveraging seed devices down the road. e.g. doing seed/sprout for cloud
>>>> provisioning, and using seed devices for OEM factory recovery on
>>>> laptops."
>>>>
>>>> There are definitely hacks we need to fix for seed devices, but there
>>>> are valid use cases and we can't just deprecate it.
>>>
>>> OK, then it looks we need to keep the feature.
>>>
>>> Then would you mind to share your preference between things like:
>>>
>>> a) The current way
>>>     mkfs + btrfstune + mount + dev add
>>
>>    And further, dev-remove seed if needed.
>>
>>> b) All user space way
>>>     mkfs /dev/seed
>>>     btrfstune -S 1 /dev/seed
>>>     mkfs -S /dev/seed /dev/new
>>>     (using seed device as seed, and sprout to the new device)
>>
>>   Does the -S option copy all blocks here?
> 
> Nope, just the same as dev add.
> 
>>   How does it work if /dev/new needed to be an independent filesystem
>>   only at some later point? Add another btrfstune option?
> 
> The same dev remove.
> 
>>
>>> With method b, at least we can make dev add ioctl to be completely RW in
>>> the long run.
>>
>>   Could you please add more clarity here? Very confusing.
> 
> Isn't it an awful thing that device add ioctl can even be executed on a
> RO mounted fs?
> 

Ah. That's fine, IMO. It is a matter of understanding the nature of the
seed device. No?
The RO mount used to turn into an RW mount after the device-add a long
ago. It got changed without a trace.

Thanks, Anand


> Thanks,
> Qu
> 
>>
>> Thanks, Anand
>>
>>> Thanks,
>>> Qu
>>
