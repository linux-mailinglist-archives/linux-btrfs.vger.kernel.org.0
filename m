Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A65F50A106
	for <lists+linux-btrfs@lfdr.de>; Thu, 21 Apr 2022 15:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386539AbiDUNpI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 21 Apr 2022 09:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359071AbiDUNpH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 21 Apr 2022 09:45:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD073703C
        for <linux-btrfs@vger.kernel.org>; Thu, 21 Apr 2022 06:42:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23LBUBSV019412;
        Thu, 21 Apr 2022 13:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gzp6jDAbzqFPvyskVP/mmeT5t/MKO3DgtG0qUcUBkks=;
 b=iMH07+Eoe4qnFgYnr9fMkojrM7YHW/0kFLJK5dy7RXZCQAvcT+KtGd/xxNInNmMHzc44
 SNAAEQQ2hiOZgs6yP6B6+z9OPX3BvLlBcv4lmbOhnK3rRszvOmVjNss1jInz1bAAm8c+
 Tls+Ox7pasqWV/7vypw67kJ4g2S0awSiblUdLErF1g00DHFxEByhG18zrkFAcG+Et2rC
 8rJxfmQJarJFAUFRKVyTGGQbUrG90gaRPsnDMut+zQcWmZHcSzO7QjGX18JqNvY9vXWk
 +iMtJPP3vGvxzp2l1XPe0awUDJlYvS2Q0lyWkCbmSmNkerRQ411H3xCYuxP/AF2G/99f yA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffm7cus2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 13:42:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23LDeljB018415;
        Thu, 21 Apr 2022 13:42:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fk3atd0ct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Apr 2022 13:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mOeSEWifeD2ouL6vkMXDSjvHdvfugbN68qRzcN2SL0V1YMH7k742mBJ9k4ejvcQqHcqnNNWY5IbiIwZoxe5vqdroKmPlisBoy/9Bpif3tyIzExd2djP2wAPBKvyfGlMXRmeWGvibhLftuLb29W7nTne3rgHf7e1aUI0WM3qI50xeFbUfLnnWIkWt7BvcK+tZF/976JFCAUVYA/7l12mXEVhFcSiCuYdyoNTjPNz35b1SuKVdQHuWnngd6vLWWOH61BWhNQHeYjrh8dGJNly2jgiuV3D7iDGihw3V6917Z3VQRneN2IzYugyoRWvAO0MRoFuf9grCFz9or7SYepJ+0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gzp6jDAbzqFPvyskVP/mmeT5t/MKO3DgtG0qUcUBkks=;
 b=fN9Xsbp5onq0I2vzo29/5iMgTQXMWWsEC+G9Rd9rE9dDBaHDOJD0Xtpj2JkAMmGaGz0FQOLeFn4as4wRyAAvR1/JacySpPCxGeHyrhHa6jM+JrD1DQTU/4nlD/2ZTOyKZC+NQFwPL2L2mVHLIRF2vV+F+VgXX9QP3L6UlddZCVpC9jTOCskOSCzj0fbYnDGRFaf9soxqk5DsFT3Vr9AYidHtHQMd9ag3cgbiqbdj1UwGOoeUtOvQURKiqIHz1O/Poq/B3ocGJtipglRnCoshEE4w4VUYbkADkOu2eG3R4cn/gAwOLrAairLHlWVLWavpQsqiH3CHscbvz4MESWYLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gzp6jDAbzqFPvyskVP/mmeT5t/MKO3DgtG0qUcUBkks=;
 b=E5REmRG+e4jENfwCRI5fP/MFg/1E8LfXFmVgzQYo8DBFxOdnX60PbHwaOromsCcpFB0wQCBCGO31WmeqjGK57OqFVNKUs8/VkSBxeTLCj2EKBsi0233lXKrBypRraGlm5alKKe7xULWArns7FyyMWVmKmNv7HNhJO67B4BUB6Cs=
Received: from PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10)
 by SN6PR10MB2525.namprd10.prod.outlook.com (2603:10b6:805:4c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 13:41:59 +0000
Received: from PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306]) by PH0PR10MB5706.namprd10.prod.outlook.com
 ([fe80::d414:7654:e1b8:4306%9]) with mapi id 15.20.5164.025; Thu, 21 Apr 2022
 13:41:59 +0000
Message-ID: <970520d8-74eb-a4c6-53e4-53363ee963f9@oracle.com>
Date:   Thu, 21 Apr 2022 21:41:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] btrfs: skip compression property for anything other than
 files and dirs
Content-Language: en-US
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <bbb363e71d966670d8938898803dac2b8a581c7c.1650535137.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <bbb363e71d966670d8938898803dac2b8a581c7c.1650535137.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To PH0PR10MB5706.namprd10.prod.outlook.com
 (2603:10b6:510:148::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7dab4a82-b25d-410d-6480-08da239cb57a
X-MS-TrafficTypeDiagnostic: SN6PR10MB2525:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2525EB179FB7BD40D7EBC758E5F49@SN6PR10MB2525.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aiUFERZnf3f0EcaMgejkJGx1ON2yNrLJIrTEQrg+sCV7AMU485bM4RwvgEQvAxLEkMIBW1N8s+81L1/lVcRBLrqZ7/Y3wx9nsx1SDMPNvLEtLItbY6d3pFDgVXzchaa0r6ojSY3OnuPPYvPVPtq9xRpQMECHUDV7AHltAUBhu3kfwyoS29bCtyT1le0AY+n7UvpCyG6GSd3+BNpHQxDm2WBY5o4c2JQxscEu8yXJ6eP+GHM1GteX5rygUOqPkvYznSJ93eZk3LHLXeTGa4Iybh1Q5Xpj/1WQpmxRPCoWlfxV85k4FPYR45MCLJRHEGVd54CAqVPclmP3OIvBiX8/l9ugCXEpbet8zLOYriUNLrnaL6nG7qkmwxXwZ1vsCCfJBGLVUEr92GJuWPs5fVSnJ+4nxfWL5m5RnAVKBsK1yqSILfC0dEaFmn6CQ9G321iEEMW6lhVTb70SnTJT+7Z+HjWiw/8utaYMF3mob9rQhRn5dyu+LidQ51HG2pNaM7Z/ccO0BZ0Tv4v8Trw/Q7U7VmpG7334gO3Cxmxa2mgDRMSC6PLMTIoDetWBS7t0axUtmEH95kCDvk+Yuc5SAui8iwZlbhM+zwJ3jJhCFO5rS+VLF325Z0ETOXFJ1HaQfgRfskEVcTfrTJZUodeRPTku+OAUoTXD7rBS0y4SICAn0ZFaJ98iuhlq5Joc8+o/A5GJMVjdL0rwp2gN5sqCV/0h0oSx+tgYhnL3fsBaqiMazes=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5706.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(6486002)(31686004)(38100700002)(5660300002)(31696002)(44832011)(8936002)(508600001)(186003)(2906002)(66476007)(66946007)(66556008)(36756003)(86362001)(83380400001)(8676002)(6506007)(53546011)(26005)(6666004)(316002)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEk5emcwVndtUHZvSGFxT3pYNW1vSHZpYnRUU3BXNXRhZ0NJZ0drVFlRckNp?=
 =?utf-8?B?Z2JnUVhybWx0R0lrMDZXdE5VNndibnFTUXZjdEsreFZoTDFYKytzNDdmb0Qw?=
 =?utf-8?B?Y0FyMzJTdmtlbUEyMEwxZXZ3NFpBQjdDQnhrdGkzOGY5RGJLcFdZOUNXL0Y2?=
 =?utf-8?B?SndrOVdNSzJ1K0lvT0RNZUJEMUEvcU9UdGRZTDJ5cUxoTm5SN3g0RFp3OUlq?=
 =?utf-8?B?VWd5M3A5aTR5T1prZGNZTWlqUzBQeUdHK0JHaVBZeXFod3JxRmo4ZXNxdU9D?=
 =?utf-8?B?OFppL0RRVmJwUkFGeUhXa1RSVlJrdFNJeXNJQkU0bkhjek9yY3F1cXBzYWk0?=
 =?utf-8?B?eDhtWHg5T0JSMXlYTUNVVndVeUdWNWFpQ0RPN1VMRWVGZ0ZWaUxxdVVSdk0y?=
 =?utf-8?B?aGhqR2hXTlBOWjhpVEx3ZUFWeGZaMXQzc2ZoTTA0dDQ0T3dxSWtnY2lQN3hV?=
 =?utf-8?B?cW1LbVdXTUdyMURjRXN4VkYvS3h4bFI3N3VPaVl0NG5ySlBJVGwxMTJFQ01p?=
 =?utf-8?B?UEw5WlN1cGovTXE3anlEUk9OQTZlNExxYXFkSW5XbTdSNFdCSldSSnJxVXh6?=
 =?utf-8?B?R1ZYVkJqbnh6RlFoTUd4K01zSE5ja3BpWHBtZU5leEdQMko3R1FJS1VyZDk2?=
 =?utf-8?B?VU9ndWZnRVZLOHZLZEdGZFNwTWlYUnpFaEhNbTltMmRlL3o5TGZwcGFza1Ru?=
 =?utf-8?B?WE1DM2R6MTdSY0RRMFhXVkJxR3ZQOURJamdVcm9saGV5SElWM3FQNVVHNEdH?=
 =?utf-8?B?U3lvOEw3aDBoQUppdk9odE9pWHR2UEg2bFlidkN1VkxidjFheUtBeTFqckUr?=
 =?utf-8?B?ZEZBT0svc2p0d1RVeDhtc1h0MUxRNXlUK2x0WnF4aGpBMzVwRHNzdjlLcFg0?=
 =?utf-8?B?M2VWajdCcEdCempVa1R5bm9Ka2tIQlZXSFoxSU5aWEFwV1hXaTliOXhWYkVY?=
 =?utf-8?B?VjdVZ0pLYmVPSlVRcVAzeWFRRmxYYVErSGRXOXQ4WW1zWWZZMlkyQzA0L1Mw?=
 =?utf-8?B?UWpWSnpWWVU1cWxHRFVGQ2hnL1RvaFp2aUxzQzNnV3FsUVpHS1U2MjgvUHM2?=
 =?utf-8?B?R0FxWTFubmlvZU5ZU2gzZlBWNDhobXlSeUljUUE2NUUzdFowSFJQVnVCY3hX?=
 =?utf-8?B?eGxUTnNUTlhlNVhvSklRaUlXZk85YUszMCtpQVZjQ2pMUUxqU2VlbWlrNC9Q?=
 =?utf-8?B?M2hsT3FxUzZVL0NBQnRBb1g2RFVsYWN3WnRVVkpLOGNaRTdjYVRhM0VHZjU1?=
 =?utf-8?B?WFdjd0ZzdVpZZ1Q2WTBoYmhoZHQyOHZqQXRIWkFxSUhESkwxTnErUTNHaW5G?=
 =?utf-8?B?VlFWeWpEWG1WRTkrbUU3ODlSdllHUUxxbXdCZTNzMDNoaDNHUVFXNU1kQzJl?=
 =?utf-8?B?WWpNZjlVZE1lNHhuRWkxaW9lNXF3eDc1NEgzcnNDb3FSUzQ0NitmMmN3dTdP?=
 =?utf-8?B?ZVQvT2pmMG9Lc2pqZHhaUFJrQmYxSzluZmFhNEhld29oK1BPVUVmL3BlUVli?=
 =?utf-8?B?YWNDMnZVcWZXS09PU29EeVQxbzdJRWlJUVdNbTFkdFg5a1BxU2NwYkQwdXY5?=
 =?utf-8?B?ZVJjSVcxaDZZdFhNSnVMWnlwZG5BRHV1L25sWmFIUTBjWkdOdHJsL2dhWlkr?=
 =?utf-8?B?L2ZmenJCeWk5OE1OUDhPSGtLa0p4ZmFNdjJab2hCTGhlb2R2N2tHTm1MZnF6?=
 =?utf-8?B?TnNWNFd6SzVablZtZzd5S2xMSFZ0L1pLSHJSRFRHdFczR0ZRaDN3UEthVjRP?=
 =?utf-8?B?eFhKemVDd0tXc0tUaFltRDRIS2h6emFmUW8zdG02emJDb09FakYyeTgvYk1X?=
 =?utf-8?B?dDRZaGpDeUlxb2VQbnpxNkp6N1l4UENqd1o4LzJuNFZnK3dVTTZwNTdRSjQx?=
 =?utf-8?B?dTN6TGZ4RWJkR0FZYTZzckZ3bUJBQTFjd3g4QUdzUCtJYnFxeVM3QWY2V1dp?=
 =?utf-8?B?MXdoUHdZRTc3TFZzeTVoZ3hmMFVHWUhBZFNldUFCd1hBdVNFQXg5dTYzMWhS?=
 =?utf-8?B?cVpZLzJ0R1ZuYVBnOFRRVFhpZElJY0tEOHF4cEh6a1VDWUwrZFo4bEVQQkV6?=
 =?utf-8?B?MEZFeTdyK2R5MDBPcSthbFMyNzNnWGJwdk5JekM2Zm5WRzlUTGJiNVBrMnVa?=
 =?utf-8?B?OXpDbk5kc25CY2UvWUxNZHB4a01GWDUwR3NoM3NVSXh6TWpuSnlkbGN6OThZ?=
 =?utf-8?B?VmJlL1RvYzJhSC9iczFCbXA1VVovczZ6S0hqWUZiTTk1UVBRUWx3YTJOdUxJ?=
 =?utf-8?B?c0wwdzYzdExYdzBvN1l4THVGMklncTBOYkVLbG9ZQmZaOWRIOUxPVFBFODk2?=
 =?utf-8?B?UVE1VGw1NnRUckluMnl4REZFby9tUlR1RVdQakRFQTQ4clUyUmpEdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dab4a82-b25d-410d-6480-08da239cb57a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5706.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 13:41:59.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjWuG7cA7qZ7SGfs4nV53ncmbyNaCWYa4MYVmm9qiYLVwvYh3iGohJ9NDgwa9r5qo52k8OfCXuK0nhZllg50kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2525
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-21_01:2022-04-21,2022-04-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=899 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204210075
X-Proofpoint-GUID: vsubIXTjhZbUbndFg6tytvbalIqrpo4i
X-Proofpoint-ORIG-GUID: vsubIXTjhZbUbndFg6tytvbalIqrpo4i
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 21/04/2022 18:01, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> The compression property only has effect on regular files and directories
> (so that it's propagated to files and subdirectories created inside a
> directory). For any other inode type (symlink, fifo, device, socket),
> it's pointless to set the compression property because it does nothing

Hm. symlink propagates the compression xattrs to the target file/dir.

  A symlink to a directory

  $ /btrfs$ ls -la | grep test-029
drwxr-xr-x.  1 root root    0 Apr 12 13:07 test-029
lrwxrwxrwx.  1 root root   10 Apr 21 20:00 test-029-link -> ./test-029


  $ btrfs prop get ./test-029 compression
  $ btrfs prop get ./test-029-link compression

  Set xattr compression to the symlink

  $ btrfs prop set ./test-029-link compression lzo

  The target directory also gets it.

  $ btrfs prop get ./test-029 compression
compression=lzo
  $ btrfs prop get ./test-029 compression
compression=lzo

  This patch affects the change in semantics. No?

Thanks, Anand


> and ends up unnecessarily wasting leaf space due to the pointless xattr
> (75 or 76 bytes, depending on the compression value). Symlinks in
> particular are very common (for example, I have almost 10k symlinks under
> /etc, /usr and /var alone) and therefore it's worth to avoid wasting
> leaf space with the compression xattr.
> 
> For example, the compression property can end up on a symlink or character
> device implicitly, through inheritance from a parent directory
> 
>    $ mkdir /mnt/testdir
>    $ btrfs property set /mnt/testdir compression lzo
> 
>    $ ln -s yadayada /mnt/testdir/lnk
>    $ mknod /mnt/testdir/dev c 0 0
> 
> Or explicitly like this:
> 
>    $ ln -s yadayda /mnt/lnk
>    $ setfattr -h -n btrfs.compression -v lzo /mnt/lnk
> 
> So skip the compression property on inodes that are neither a regular
> file nor a directory.




> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>   fs/btrfs/props.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>   fs/btrfs/props.h |  1 +
>   fs/btrfs/xattr.c |  3 +++
>   3 files changed, 47 insertions(+)
> 
> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c
> index f5565c296898..7a0038797015 100644
> --- a/fs/btrfs/props.c
> +++ b/fs/btrfs/props.c
> @@ -20,6 +20,7 @@ struct prop_handler {
>   	int (*validate)(const char *value, size_t len);
>   	int (*apply)(struct inode *inode, const char *value, size_t len);
>   	const char *(*extract)(struct inode *inode);
> +	bool (*ignore)(const struct btrfs_inode *inode);
>   	int inheritable;
>   };
>   
> @@ -72,6 +73,28 @@ int btrfs_validate_prop(const char *name, const char *value, size_t value_len)
>   	return handler->validate(value, value_len);
>   }
>   
> +/*
> + * Check if a property should be ignored (not set) for an inode.
> + *
> + * @inode:     The target inode.
> + * @name:      The property's name.
> + *
> + * The caller must be sure the given property name is valid, for example by
> + * having previously called btrfs_validate_prop().
> + *
> + * Returns:    true if the property should be ignored for the given inode
> + *             false if the property must not be ignored for the given inode
> + */
> +bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name)
> +{
> +	const struct prop_handler *handler;
> +
> +	handler = find_prop_handler(name, NULL);
> +	ASSERT(handler != NULL);
> +
> +	return handler->ignore(inode);
> +}
> +
>   int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
>   		   const char *name, const char *value, size_t value_len,
>   		   int flags)
> @@ -310,6 +333,22 @@ static int prop_compression_apply(struct inode *inode, const char *value,
>   	return 0;
>   }
>   
> +static bool prop_compression_ignore(const struct btrfs_inode *inode)
> +{
> +	/*
> +	 * Compression only has effect for regular files, and for directories
> +	 * we set it just to propagate it to new files created inside them.
> +	 * Everything else (symlinks, devices, sockets, fifos) is pointless as
> +	 * it will do nothing, so don't waste metadata space on a compression
> +	 * xattr for anything that is neither a file nor a directory.
> +	 */
> +	if (!S_ISREG(inode->vfs_inode.i_mode) &&
> +	    !S_ISDIR(inode->vfs_inode.i_mode))
> +		return true;
> +
> +	return false;
> +}
> +
>   static const char *prop_compression_extract(struct inode *inode)
>   {
>   	switch (BTRFS_I(inode)->prop_compress) {
> @@ -330,6 +369,7 @@ static struct prop_handler prop_handlers[] = {
>   		.validate = prop_compression_validate,
>   		.apply = prop_compression_apply,
>   		.extract = prop_compression_extract,
> +		.ignore = prop_compression_ignore,
>   		.inheritable = 1
>   	},
>   };
> @@ -355,6 +395,9 @@ int btrfs_inode_inherit_props(struct btrfs_trans_handle *trans,
>   		if (!h->inheritable)
>   			continue;
>   
> +		if (h->ignore(BTRFS_I(inode)))
> +			continue;
> +
>   		value = h->extract(parent);
>   		if (!value)
>   			continue;
> diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
> index 1dcd5daa3b22..09bf1702bb34 100644
> --- a/fs/btrfs/props.h
> +++ b/fs/btrfs/props.h
> @@ -14,6 +14,7 @@ int btrfs_set_prop(struct btrfs_trans_handle *trans, struct inode *inode,
>   		   const char *name, const char *value, size_t value_len,
>   		   int flags);
>   int btrfs_validate_prop(const char *name, const char *value, size_t value_len);
> +bool btrfs_ignore_prop(const struct btrfs_inode *inode, const char *name);
>   
>   int btrfs_load_inode_props(struct inode *inode, struct btrfs_path *path);
>   
> diff --git a/fs/btrfs/xattr.c b/fs/btrfs/xattr.c
> index b96ffd775b41..f9d22ff3567f 100644
> --- a/fs/btrfs/xattr.c
> +++ b/fs/btrfs/xattr.c
> @@ -389,6 +389,9 @@ static int btrfs_xattr_handler_set_prop(const struct xattr_handler *handler,
>   	if (ret)
>   		return ret;
>   
> +	if (btrfs_ignore_prop(BTRFS_I(inode), name))
> +		return 0;
> +
>   	trans = btrfs_start_transaction(root, 2);
>   	if (IS_ERR(trans))
>   		return PTR_ERR(trans);

