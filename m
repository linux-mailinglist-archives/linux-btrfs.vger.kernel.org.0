Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860904C6443
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 09:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiB1IBJ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 03:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233122AbiB1IBI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 03:01:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C5569298
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 00:00:30 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21S6JXGS008194;
        Mon, 28 Feb 2022 08:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=jDxlUwt0r55TVhIBYhRhnit71Jue3R1Tah69araRfwk=;
 b=aHuAh9m0jpD+Qujg0mVLtGyzHe192LVZjt86EZG10jvQXcdxw7kiKvJ8785CQwwUKA7I
 BETx97b2odrh3ve/SuvE224Pwfxbot9KNN31HRMvaZhNVst8qL54zNnMBzfIeVWO35sO
 758brep+5Bklog4KeP78cfnch+bFsxYdljBjgXriwQ92645e1UcwBoLyYBivpiyWcTAc
 mlaLIusJLDN2hu09eOKsPHNg+3DdpdQhTGRdaE1s4Z+OipZB3dmuFPTia5EbDKJUfcnn
 XciVoFxWVCnyF+CYs5KILHVCnVGU/9rcjpTOP1QbHJsVkh4C4+Llxl8VuDpW4y91XA6i HQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3efb02ker3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 08:00:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21S7tAnC115157;
        Mon, 28 Feb 2022 08:00:25 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by aserp3030.oracle.com with ESMTP id 3efa8c4nu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Feb 2022 08:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dn67C2VSf50z86QBQFFfZbWep3fEwG/38FukriAOt8fJ7NpzNY1WwW2Kl+Ap0xrMVd+noNMNwBVBmVUvsqg8Attn+kYqsARKbQIB3sPNKisEGiIvzgNVIdIk1kUJ4RFqyYSBOURIdINJDP6S0jowo3dIdq9d2MpYWNPrTWKYWrRYzeqmjJq+KlSss0D4rjSUKIpGytag9bLFlLDtSIjs/ANoE8ZDh2UtFDyqTTbV9UDH8JUAeWpm0myYuwYFYVjgUfefD/T7MuKFq6mdRfvPTeXigHrUlA0Asji+vd4FgH24i4YR82bgKrJ4Ps7S+aPW6OOW/+MidGzk18i6Iml1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDxlUwt0r55TVhIBYhRhnit71Jue3R1Tah69araRfwk=;
 b=bhVJDP5I8L8KqF6AyO76UbMedC5mWuKq+W8GQqSlt+/7zE6kREBYeD5yMzHh82v5sgPoZ6HU6k2y0RnpzY9qZxIZ1hew1WH/0YEFxbzvUKL/LN/QKZGvrk4zyYuzbibRWi9Akw90USU5IC28KAC+XXpAD+6h24Uuu8M7UH0rIcn33z9LRp2b2+4m7PesttewZ0ZSRIVQCOqkx/qHVBBUACfKbJhuo2cek+OKRrNngA/f6uS9XYNS0RLqiu5yQdz5bN7OL6GiFbSvKtKisOWe8Zgvt+5rry/f+oWOm7pkoapoF8yi+qaHDkihDZ5KhfHQv+rIwXELWjmhUKqy77aOgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDxlUwt0r55TVhIBYhRhnit71Jue3R1Tah69araRfwk=;
 b=v6GPV8oC2AVRQRg9qBXrN/pO94jb8/ca5OFR5pzOmonGtGSdfnOkZYYm9kjG5mRlKNnu9t48D7Z//sIslnA0hoCUG4vNxDc+HQzvkALQSCMZsX/cIpsjHv0bH1fu7B98OH++DLvI9QQJv2pahX3FmscTav0tDnbptYWL/uh0BHs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by CY4PR1001MB2328.namprd10.prod.outlook.com (2603:10b6:910:4a::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Mon, 28 Feb
 2022 08:00:18 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d469:7ab:8ae2:1e6f%5]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 08:00:17 +0000
Message-ID: <ebdb0e67-0e9e-4ca6-1d2e-4dd2a7a7c103@oracle.com>
Date:   Mon, 28 Feb 2022 16:00:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2] btrfs: repair super block num_devices automatically
Content-Language: en-US
To:     Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc:     =?UTF-8?Q?Luca_B=c3=a9la_Palkovics?= 
        <luca.bela.palkovics@gmail.com>
References: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <732d0a86c3624bc96df3cca05512edac40efc75d.1646031785.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::36)
 To PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 682e27f8-5ac8-4a2e-878c-08d9fa905bf4
X-MS-TrafficTypeDiagnostic: CY4PR1001MB2328:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1001MB2328F592696EEA2C46CDC7F1E5019@CY4PR1001MB2328.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOHnY3SD1dRyU/CfLPX0/KTzY7C7VJmZfqp192GnGNvqxwW1NFdw0wVh/d0G7jmXG76vF16wHsDL/Oq0fzCuWndx8WF0kEoascD076xTE/6yAXJZI1pLNyvpdckH3U0cQoxSiB5Vt8JKMogpEF4XUC/1DhmmtI4712XCmkleLRiyqjFSX29HYR6imxec/cLrCOctASjhcXVsVxqFYvzfng28e+jyvU6KxRiVfHXp16m6gHsWj9yp4udgVVWObNqYFZOYur1EsJ8vZmCIh7V6dQVM3nHbJmxj+Zn/2Q1AuANXl6AzCRXLOw1xfGXIOsoJ9vgnnUhtwaHNFn4a0HL7tKtiih4dWdmaK1LZcvjti6sdco9XXm4a8z2R6qH05ak83pwiqC5mfwZ5sWl4+KEf//pbddSaLI0gfIONBOMqkWhrc2DW0ulgdPiuWFuhsNN+qTN0bpnJvApz8kgpUT6nxnXif5c41lCPyJXJxeXOYAagnDgFT30vi8DE/OSg5PBMyTUlHXQ4YpJT5VhqqZ/J+P0TVeQ2bKcoO47tV4fm+0PqD7JyNrXEq5BGUz2fr+T1dYzsZYfDRaU1Ri2Jbo+SthmtHetBgG9kieQFpcIQTjiM4nsCsNUlGzYhHZEAGjsaglHc2J0yEyVWnNXjVJSNriW8z2n7SLmKYJiNzQV9Z4+fHclnmJiX/26/Zw3wrHXfpRVYdBklpw9abjRjDhphrwrA7ysEyasoZfBL0XNBLR2nktJoEzUlkYQFNErdlCn80uF1n61GPt+MWjjshQvVyMZe+kjBlk4Qh6To149V4RAbkurX3CE79+WcjVoVTVTWURL8jU3irgH/16OrD1Q8wA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66574015)(36756003)(66476007)(4326008)(66556008)(8676002)(31686004)(26005)(186003)(66946007)(83380400001)(8936002)(2616005)(6486002)(53546011)(6506007)(5660300002)(38100700002)(508600001)(966005)(2906002)(6512007)(316002)(6666004)(86362001)(31696002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXNkczhZZU5BQXZMYzIxUFN4N2dlMm5Yc3NBUm5tTDFsZk9YT3RRdk1xbjNO?=
 =?utf-8?B?Y0FONzhPdUxQczFwVnhGSnhzeXpEMUhmM2F2WWtHanpMNzNNT0RGcWdXNmxT?=
 =?utf-8?B?SWlvMjMwWmx0MllwTXdKTC9VMFFPeDBlWkw2ekRmK0VCVDlGY0p3YTNTZGhY?=
 =?utf-8?B?OER5Q3VvZ1pWdVkwS1ZPZUZVbkFDblNXN04rY2c3dU9qdjBEQktqMFlkNWdD?=
 =?utf-8?B?OGg5R2xZZGdyYW04MTkyUS9hb2NybjJsNTd6VGxnZmRBMStYQ0VBeGs5SkVm?=
 =?utf-8?B?d2tKYWdBVU1KQjVlNFh5R25IVFdoeGFGaDNuazQrOVZsUDh2aEFkNm56WWRX?=
 =?utf-8?B?YUN1Y1RsVUJ1a2tsVy85Qk55eW9vdEw0TGNzTkVyVnJoRXRHU0lBcFZXdmt6?=
 =?utf-8?B?UFpvMTQrMURaMERERWZNckpBNjFXeTgweVVMZzM0cjNFRGVPUzNuRmdWckdB?=
 =?utf-8?B?ZnhHRSs3WWw5VFRLd2ppUUdjYnR3eCszWUlyc3FqL2wxRTV0TWpKdkd4QjFE?=
 =?utf-8?B?MkFTWlhBUW5iM0V3REJmQ04wM2ZvclpLSWh1U00zWTYyNHpyZTdJYW9YVk1K?=
 =?utf-8?B?NjJ3dHYrcFFIL1M1L1Z1NnN2dkNWTmRmOXc2TUZLVlR0MGk5STh2Q08xbE5C?=
 =?utf-8?B?UnZ6bjRQTnJScEVmM1lTa0FpTy9zTGw4Q0JOKzZheDFPQyt6c0srWmRaTzZu?=
 =?utf-8?B?Y2prVTB3YTUvbktXZ2FGQUdvcmg1NHhtcmFMRTdVVWdabXhpakxzWGV4K1Vk?=
 =?utf-8?B?ZWg2KzRxOUdoUXdZamhnekRMbEZFOXhZWWxxb3M0UWxOQjBydlFOYXVJaG9O?=
 =?utf-8?B?VEdGdkJXYmxPMTQrSEQySWs2MWpUZDNsNzhRSzd1OWZ5enZwUFY5WnZ2Y3NX?=
 =?utf-8?B?c0h4UDRIWVpPM3U1ZGpqNHBzd3FrYk5GM2JkZmViWS8zcXBONEd1Q1NvczNn?=
 =?utf-8?B?dlNYZGVhQ3QyUGx6anBkUEFxSFhmWjJmT1JtMS92Tm9FUjlKNG8wOTdKZHFP?=
 =?utf-8?B?bERZUEIvZURzckpxenMxWnIxS0RzcDFLNE51TDBaWjZhUUx4Q2NPcXJqNHdW?=
 =?utf-8?B?UEMrcjVhSmo4U3ZvUUdPOWdRUFJ0R2xHcFNwRzNPYVZHenBURklkUHpLR3pz?=
 =?utf-8?B?R25xdHlncEF6cnJYNFJhalZ2eWgvb1BsUjdNUERjdjQ5T2VmcjNSOUJSZytS?=
 =?utf-8?B?RkVkRWNvS1dXSUZBcjhmd2FxV0N5NlZWak9ONmx0QjhXU2kzbXhtMVRTTXgx?=
 =?utf-8?B?U1JEYzlRM0FweWU0TkFZc09hQXppbzI0ZXdKMzB5aHgzaEltVmFNTlBYVlk4?=
 =?utf-8?B?MmxnYWd4ekJISGJLS2U2dSszNEpiNkl0RTZSM1BPS2VndytFdHNHSjFNWVFr?=
 =?utf-8?B?K3BlemM2UUM5NlMvK0xwVHVQN2hxcGNVWHlQNlVVWmp0OEROSFpNUlkvTE5j?=
 =?utf-8?B?MHNvVXMwVVREWDAyNTEyRjd6SjVCUjhJbFlCZ0dxL2xkT2VoQ0tKYjhOMm5I?=
 =?utf-8?B?NXdmbGIxaHlZNnVpTkNhU3FIMVZhcm5zS0dSVFo0aXJyRTd6VFdiYk1Ha0U1?=
 =?utf-8?B?Q0xkdUpxY3NEY3djSitqZm5yeXYwcFJCejl2V0h3RS9HMzRLNHl6ZXFmb1pt?=
 =?utf-8?B?aklsZXNWSU43Q2tQNFZQRFcydDhnRHA3NlA2cjNSTGxKTGIyM3Rpck1xeGtW?=
 =?utf-8?B?VVRpNm5YMzJaSVV0WkgvM3ZOK3dSS1o3R0xjZW04WUYyK2NRQkpqRnRsQ1hO?=
 =?utf-8?B?S0dwNzVzMWZYS0I3LzRIMXdkTFd1d0c4dzJMRTAyOHh6Y3EybFdhcXZhTTFD?=
 =?utf-8?B?R0pKcWNlNjFwL2JiS2Mwd25XVWoxeGlGR1RHQU1FSDI2QWQ2VWozMGY0eElh?=
 =?utf-8?B?ZzV4N1ppWGVNcHFweEpLWDQ5T211Vks5Rjl4Wk1iamNUK1NNTHhWQ1dhWkta?=
 =?utf-8?B?RHA2L0ZkSVc5UjVJcTZBYWExazNlRS9WRUJlZFNLS1R2aUEvdSs4TVBCMEdE?=
 =?utf-8?B?aGw4OVFqYUc2ZmQ0emxjUjhIKzZ6c0hMc3NBUHFMTWpSMDVQSFRPSEpQOXFv?=
 =?utf-8?B?S0NZMUtJYXRPVzJLOWswVkgxZ0hqcGt1VENUV0NIU2U4cFkwZ3phalZUNm9s?=
 =?utf-8?B?cU13OG1QU1NEczkzVU84dWx3T1MrbHFPazBwOUVsZnl6ZnpxcDZxUmR2czNq?=
 =?utf-8?Q?QQczYmtHbYLy/Q9//88S8Fg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682e27f8-5ac8-4a2e-878c-08d9fa905bf4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 08:00:17.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E65n8ijC6NnVzp4eY6vjrJPT/ANbf5/bjimi10RGi53Ajd1kZ/Bha7XkB2K019tix7Y8gKpIkdPHQnC2SzxG2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1001MB2328
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10271 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202280045
X-Proofpoint-GUID: cDwFEB-f9f6SrYP-PwQvroogzaR5AUVC
X-Proofpoint-ORIG-GUID: cDwFEB-f9f6SrYP-PwQvroogzaR5AUVC
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/02/2022 15:05, Qu Wenruo wrote:
> [BUG]
> There is a report that a btrfs has a bad super block num devices.
> 
> This makes btrfs to reject the fs completely.
> 
>    BTRFS error (device sdd3): super_num_devices 3 mismatch with num_devices 2 found here
>    BTRFS error (device sdd3): failed to read chunk tree: -22
>    BTRFS error (device sdd3): open_ctree failed
> 
> [CAUSE]
> During btrfs device removal, chunk tree and super block num devs are
> updated in two different transactions:
> 
>    btrfs_rm_device()
>    |- btrfs_rm_dev_item(device)
>    |  |- trans = btrfs_start_transaction()
>    |  |  Now we got transaction X
>    |  |
>    |  |- btrfs_del_item()
>    |  |  Now device item is removed from chunk tree
>    |  |
>    |  |- btrfs_commit_transaction()
>    |     Transaction X got committed, super num devs untouched,
>    |     but device item removed from chunk tree.
>    |     (AKA, super num devs is already incorrect)
>    |
>    |- cur_devices->num_devices--;
>    |- cur_devices->total_devices--;
>    |- btrfs_set_super_num_devices()
>       All those operations are not in transaction X, thus it will
>       only be written back to disk in next transaction.
> 
> So after the transaction X in btrfs_rm_dev_item() committed, but before
> transaction X+1 (which can be minutes away), a power loss happen, then
> we got the super num mismatch.
> 

The cause part is much better now. So why not also update the super
num_devices in the same transaction?


> [FIX]
> Make the super_num_devices check less strict, converting it from a hard
> error to a warning, and reset the value to a correct one for the current
> or next transaction commitment.

So that we can leave the part where we identify and report num_devices
miss-match as it is.

Thanks, Anand


> Reported-by: Luca Béla Palkovics <luca.bela.palkovics@gmail.com>
> Link: https://lore.kernel.org/linux-btrfs/CA+8xDSpvdm_U0QLBAnrH=zqDq_cWCOH5TiV46CKmp3igr44okQ@mail.gmail.com/
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add a proper reason on why this mismatch can happen
>    No code change.
> ---
>   fs/btrfs/volumes.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 74c8024d8f96..d0ba3ff21920 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -7682,12 +7682,12 @@ int btrfs_read_chunk_tree(struct btrfs_fs_info *fs_info)
>   	 * do another round of validation checks.
>   	 */
>   	if (total_dev != fs_info->fs_devices->total_devices) {
> -		btrfs_err(fs_info,
> -	   "super_num_devices %llu mismatch with num_devices %llu found here",
> +		btrfs_warn(fs_info,
> +	   "super_num_devices %llu mismatch with num_devices %llu found here, will be repaired on next transaction commitment",
>   			  btrfs_super_num_devices(fs_info->super_copy),
>   			  total_dev);
> -		ret = -EINVAL;
> -		goto error;
> +		fs_info->fs_devices->total_devices = total_dev;
> +		btrfs_set_super_num_devices(fs_info->super_copy, total_dev);
>   	}
>   	if (btrfs_super_total_bytes(fs_info->super_copy) <
>   	    fs_info->fs_devices->total_rw_bytes) {

