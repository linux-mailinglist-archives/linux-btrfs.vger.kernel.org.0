Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3676F76629F
	for <lists+linux-btrfs@lfdr.de>; Fri, 28 Jul 2023 05:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjG1Dve (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 27 Jul 2023 23:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjG1Dvc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 27 Jul 2023 23:51:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81C12D45
        for <linux-btrfs@vger.kernel.org>; Thu, 27 Jul 2023 20:51:31 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S0wFRF014557;
        Fri, 28 Jul 2023 03:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=sQFw2jnedRLfaocOZbOtTHVNjnFjQpIC2d0dnZq4uZs=;
 b=vQMMpc9toJkoCHOnsBhPvzfyBc/j5TVKAebouVjnQXSJOK3bNQ8/9frI3xeSXFzmmbAv
 F1xXnjY24Zqz2CbSLzhZHi1cYIcyt6HwtsjkrDrqmyQXV00raLvLnCgzTYGI+G7NjoIe
 jAl7+Vv/waH0q9Odv/SxlH3jJc9jupNPyBeILD0613GMQBU6TmhTae0HIxj80/FG7XdD
 dncySzpZUFBD3O/wgrvY9zZ00VR7lgRcPLoIyNF1ixlmCPehrRCNMoeC5pP44etRODP7
 ZJS4I7+hPtoJhBAwqn4r00m2pHCDU21FsqwYC/e5yprxH+It4pS++mzxwhvXZghM22hI Ig== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070b32qf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 03:51:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36S2EeSs011704;
        Fri, 28 Jul 2023 03:51:27 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j8qp6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jul 2023 03:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IbkNYlsQSr+OcfluIGl1qqdEuxS20Ayb4In3jhqetgBwZOJI8Bv6SMBW52SsC5kDws2AzrStdX+LWMVR+guzu/y7ftsK3tjlymMgfz1U4avxpl5a25/KkOjF0GoYtySj8zGljDAx86mtIMK3XPPIJwSZEAbd0iXihP+SZ1lysuxtMTTK2oBAjTE4Ph6MNeOeG37b3Z+HQUHVgRuEyHOA8K+Ym/tOWlLaetdmG9mq4Lt5wdinp0mNWliKVvDCO0LfR2U4EEwsj1t+b1DROnYkey9l3GzVdWW9agj5DINtmghfBVXRCkbrxXejsBwcJy2UmQmIKaGBGNr2kl9DkizceQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQFw2jnedRLfaocOZbOtTHVNjnFjQpIC2d0dnZq4uZs=;
 b=XrV4GK3SqPEaFRGmrLLRJmF+6ELJLWm3v2kidwKelyzvympDv+1KqoUi4RA3NzA9nbgo2QrWPonqKPDwGp+eUKQojcY8zj7dJ4cYH5pdh0TLRX6AJY08tHUlqw+1QFAyDjb5GsnScgU+Dgl4yD0C8sJ8UqYo2PMr2M+osMWN86jXqX53rW+0Rb6YjnKBz1TIalj+ErpIj2Ma6oE6n07GQZ1jyfN5EAglJAo7VA+n6GJvltwSl+8oTMHSA0nveTzpEqDE85RkX1txVZuiFpNb6do9PrZjBFZSvOUUMjWRGkVLzBJQtmUeAv3RpEGxBZ2psmG0eM/OJD3fn4Qw0NNA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQFw2jnedRLfaocOZbOtTHVNjnFjQpIC2d0dnZq4uZs=;
 b=nx0fczSGvwitg/Oo8z2AL6D7QV688pEl3/3qHpH2sKMu0SSMokDC0x640iawQXQwo30b0p62KpKcWPJXABXfEzDxE/1xGwTiEG5M6tdCDKnApBbUtDZp98dbMGvRYvOCu6VO57Qs09MkAG06mb1rcmdDvOrHxX7VsUOVHfch0WQ=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by DM4PR10MB6157.namprd10.prod.outlook.com (2603:10b6:8:b6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 28 Jul
 2023 03:51:24 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::b3cb:e0d9:ef96:aa56%4]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 03:51:24 +0000
Message-ID: <12e88a5b-59d1-4403-f9b6-37ec23866e77@oracle.com>
Date:   Fri, 28 Jul 2023 11:51:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] btrfs-progs: tests: not_run for global_prereq fail
Content-Language: en-US
From:   Anand Jain <anand.jain@oracle.com>
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <149265ca8a94688008c1cda96c95cf83ac55950c.1690024017.git.anand.jain@oracle.com>
 <20230727165157.GG17922@twin.jikos.cz>
 <155356de-ddfc-118c-eaaa-9dca8f2401a1@oracle.com>
In-Reply-To: <155356de-ddfc-118c-eaaa-9dca8f2401a1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0161.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_|DM4PR10MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8133fc-3df2-485b-a154-08db8f1de9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sskkkSLNDN6SqJZ7EeMHq2CKyvDs/h/COldYgimKCCRhRs8FzMz2TUcYccAydGTgJaau40VMq8LVB5oEvVIr15Fkctu5eNOVl+aSGfq+GtzYkwiwdObJ0/c6HlDdJw3mV2sDpblolFTgLWLtQZS98gkTnWAIg+5RJl6P0h1we/ANhes3kClalhUrdjqite7vXELysvBLKvxp3hc/Fi0MYXPlNZDnwKZ+KRfH3gEPREfrSFN4UNtdj8o0mEkkE8crg0MPNEOOm5A8DrV8D2K1hEgF5Z6Ti32mb8aFjuyM3JxvblHI2htjluX7OlkKTfJ1+DPaWryyAA3hBnXM7BorkLRjHTayC7+Q+gP+WMFwBaopEvIVkStybQqH9XKBgP+AyQvs+t5OgZ9hm0BbaXVLv/36vVAMRVhvyzPJNm8zMA20iI3fB79OTWPF9QoRSi0GpE1aXD9SNVzSHWYsryJqE9O447PuR02MVCh275URWP0xC1E/WkoendnKhL7Xs/Cup7n6H3WbLIadAGOW9Mc5fybqLplDtZ5a01tkHGIkHfk2JAB8lE5uZYcfcuO1nQzdw9BWBlldK0ELUTE3UmKbQjG7F7guMPOEk0eeLZ9NXdCNaNY5eFSvhwduYA8jMrbM5lXktKUKH2BtdiC8I4JvbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199021)(83380400001)(2906002)(2616005)(38100700002)(4326008)(66946007)(41300700001)(66476007)(53546011)(66556008)(6916009)(316002)(26005)(6506007)(186003)(36756003)(31686004)(478600001)(6666004)(44832011)(31696002)(5660300002)(6486002)(6512007)(86362001)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkQ1LzZGR0tRaVdpRGJxaC9Ha3h3RGdVekVPWlpKaUNFQXFSQjRjWnRueEdG?=
 =?utf-8?B?Z3F4b3R5MWF0MXJPSGRNeE84OU5nc0p0VldzdGhHRlJPYUprZE5FWndCUXRz?=
 =?utf-8?B?dERaOERMMm1qREFycDU5YkxzM1EydXJpbEZLbzBVaHI5bk41UThuU0RkbVdm?=
 =?utf-8?B?c1ovWG5KMDZ3MnI4SG53RVpYN3BWTTRYYWhzYy90TU5CemtwQnlZZ2FMa3lM?=
 =?utf-8?B?YTdwVEdaeG92dHpLVXVWNXNnUTEya1RDbFpUc2R5S0hqL0hSVjZ6WWtaR21E?=
 =?utf-8?B?Ly9BemJZeWRvQXZpYlVXQzFDR3YzS2d6WkNFUzhQdFE3YUpLd1F1UHF1LzAv?=
 =?utf-8?B?VHZSYmpRWmNsMzJpUnZDR3VmV29qeUJLT0NXZjVpeDlVZHZCR1piQ1RlcDJj?=
 =?utf-8?B?Q3RXcXRvSnJoUDNIMnlUbXZ0NmF3UlNqVWZNTkxvTTJBT0dmcjI1YkR6YXZw?=
 =?utf-8?B?NTR2ZnRpN2o0N25YajFJTmcyVkZJU1IrMm1LOUdNVlJGMEFaL1hvanJYT1Fo?=
 =?utf-8?B?VlJ1Rk9TK2pwbVQwTFkydmdnVm5ITG84d3NWeXRhNEMyWGRTQXBjdWJYU0o2?=
 =?utf-8?B?VUhWWjBQVmZnMkRraVRObjcwZk03OStUdHM1VDdPZmo4R0hKd2MzNEIyZSty?=
 =?utf-8?B?TStNRVFUZnkrRnBmejhXc052eEZGQk5yM0NlY2JXOFFiRDNEQWI2bmVzZTZE?=
 =?utf-8?B?dVZ4dmtMbFZlR3hjdEhobzZGNDlxMjVGTEpUSkl2ZGhENE93ZzlQUE9PdXlY?=
 =?utf-8?B?NzQyUHp5VVlYZHM5VkF3Ujl0UDZDVGxVYnhtMk9HSTIvRU12Vm0rR01xNXYy?=
 =?utf-8?B?MjFGb0UyZzVZK0VvZWVZK3RXQnlhMmRwQXAvMnFPVk1NZy9TWXBnWENSWXBm?=
 =?utf-8?B?V2hWVG9oQzY0Ti9QY211M3U2RVpqVDVWQU9TQWxwTUZTYnZFNFU4Z1ZMdDZB?=
 =?utf-8?B?RmhZM0JoY0ZBRmovSDl2YW5Cb3ZoNDVRdWR1WkZRd2ppNWlUdk9NSHhDSllY?=
 =?utf-8?B?dkVPSEZQNDRuT0hCcm1jYW9rZ2EzelFERWtPZnFOMWllUGJDa0lrTTdkajQx?=
 =?utf-8?B?Z09ObWdyTDlJalBrWGF0QlIvVDdTRnhHUVpjeHp3cDgzQ3hmblF0Z0FPNVd1?=
 =?utf-8?B?TG1Jem0wdWpiRkdBQUg3K0ZYdzE0cFlycmRJdG91OEFYTDExaXNseGNTM3lL?=
 =?utf-8?B?c05kc3FPeHJBOGVlMGJMSG0wckpqTkRFUGUxTkw0S24za0V1b09idzRhanJB?=
 =?utf-8?B?ZGUrLzNFak5lQ3RUdFBlZFZ0M1Nxa1NwTGZYNWl3ajdpdmo0YXZSa2xDb2pK?=
 =?utf-8?B?aWtGK2lVOU8xY0R6bjlYR3pPOGJydkM2bHNqdjZiZWFrd052LytiVXF1UVRq?=
 =?utf-8?B?T1BFYWtuUGVGVE5sNUd5UExLcjNjWGZ4WnRZVzAyZG54UUk1c3pBbTMxT3FL?=
 =?utf-8?B?bXp5eTJuUitKanVQRTUxR0V5anZSUllzL3FSZzJzRHhuTkgrNmlMWG1wNmtS?=
 =?utf-8?B?TlByYWxoVm9mam8vV1NRNFpOV3JqRy9EdDlyZUJ3WnA3dU1CbEZoZWVhM2dV?=
 =?utf-8?B?MDJjdEtTVHhPQW1Ddm55c3d5R1BCRmZFRU9VWkJocTA3RHJUbUxWd0hMSlB0?=
 =?utf-8?B?Y2pwSGhkR2hlNllnS3ptV0FuVWVJVTBUdmd4dUVLTW85VkRyWkd4a0p0VWxF?=
 =?utf-8?B?REQ5L0FKL1orbitFcmhRMk96SmpRTUVuamM5OUxEbTJtYWpyZEY1diszTmEy?=
 =?utf-8?B?M00rcXJobnZzcWVaZEtsUlBhVHA4ODZVd1VFOFBNOXV0azNLWTZwTkFkalRC?=
 =?utf-8?B?S1J4Q3RoV0ZQWVBOQzE1UXYrQVV0SCtRRHltQmlVaVo0bnlweEpQd3BCY1o2?=
 =?utf-8?B?RDQzUjBRb1V4RktZNGZaektqbk1nMFdxSGlocmVTVDZ6OEU3UGk2MHVoMXdF?=
 =?utf-8?B?QUhzbnNjWWR2bzcwV3dobHYwcGFQQnRYdVpvck1HRjVZTXZ0ZlNFTVY4R0NL?=
 =?utf-8?B?MXU4VGd5S1BZZ3NMTnRnNm1kS3pLa1hlNDFIaVZZZWYrcEx4RmE3NFRuYTBS?=
 =?utf-8?B?UFVRTTlBTnZ6OEMzTFI4R1NKZlRzbU1zcVBTaGR1UXh1ZUw2djg4R3VCam9w?=
 =?utf-8?Q?yUhIUK3/0Navcdx0b7rVX+tJz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mXXnoy9oF7S4bkW85gKqp5aaCT8otQk7wDDPg4yUqP0HxZC3zRUCLbDkJK6yIQG93/RuDJE4oGH7MFK3iR0ir5nwwbtTLBEx7mdq+Y7YwvaZIrFdctEUVktc+STTWaLQcHRLKncMLnLN9m+W+eqhGALwDtSw1vtDLJbZ+l51d959MmjXAjyzWuQsnSG+0HhcBCZ+3cVFzm1iYUwluT9uoxFA61qNJ/DJoad3NfwjJeVKXF9wFTWvX4cQfnx6tZJPhgBZJwb+FrRxn1Mdw7Hgm5PCRf3Ji9KuWyGrb86dQYkmJ2leBZsBoDG6OcC9Nov9rvLciw1h8gR8n3vi27Ias5MpHlQ3mErDhMzqKW7PWwoZBjZneLZ2O1xbJcoWxUfRj0CR4jtIZacxbYrq18wphcKVRmHdcI7kVDd/CHVLmKtEDjmH7fs+opspVCQRdvXEpW+6PcsGdTCPqrPYo+mxwp6Hkmtk7XteMPWohsz3egL4qvoJvI5QS30+gfsVaKMFhUIT7rZqTvR3fUhsbauvWyKx3L8bDV/FsHspGyVZnzZW2wybCmIQF8S9n9NJnymIXCPb+G0h4dln9oJZRmY4myNpaI1ciXhtTbF33Lhz09jERv0pb0sNghgKXtopWt/kE7cVWi9RmQGcwJGmOUIKOEK2obNBXE/lQUf5D0ukMphPjaO2G79Kpb9y8yiOI9Fy8AV7QJVRWSqXi5LECXPHB9zKUJ4Tf8vJysR481zUQ5yXiKio1Cv3CJg1PC7mZh71jA+hs2CJbpYyQ8+zNiocCfTQFKb63Ykz8hyjjuG7jzw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8133fc-3df2-485b-a154-08db8f1de9e3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 03:51:24.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gj1CyihkuGwcfrzZPEi7J7q7E0fRlLrkKp63nGMLYz0Q7GjzHvKey9BcCoqJa5NoVhCiP4E4ZPytto+WEBN4eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=939 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307280034
X-Proofpoint-GUID: EvXaDEF-_JGOkwbRVAA9njPd02MI2O_Z
X-Proofpoint-ORIG-GUID: EvXaDEF-_JGOkwbRVAA9njPd02MI2O_Z
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2023 11:39, Anand Jain wrote:
> On 28/07/2023 00:51, David Sterba wrote:
>> On Tue, Jul 25, 2023 at 05:43:54PM +0800, Anand Jain wrote:
>>> Prerequisite checks using global_prereq() aren't global, so why
>>> fail and stop further test cases? Instead, just don't run them.
>>
>> I'd rather let the whole testsuite run, a missing global prerequisity
>> means the environment is not set up properly, so this fail as intended.
>> If you look what kind of utilities are checked in that way it's eg. dd,
>> mke2fs, chattr, losetup. All are supposed to be available on a common
>> system so it's not expected to fail.
>>
>> If there's some less common utility and a test which could be optional
>> then this should be a special case, which would require a new helper.
> 
> I would prefer using check_global_prereq() to verify all the mandatory
> prerequisites at once.
> 
> If each test case checks for a different binary using
> check_global_prereq() and it fails during that test case, we have to
> restart, which becomes messy.

  Commit 'btrfs-progs: tests: add script to check global prerequisities'
  addressed the messy situation mentioned above.

> The support for mkreiserfs on OL was removed, causing the test case
> to abruptly stop in the middle.

  Is there a way to skip the test cases?
