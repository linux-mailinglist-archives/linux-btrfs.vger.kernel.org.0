Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7255C539AE2
	for <lists+linux-btrfs@lfdr.de>; Wed,  1 Jun 2022 03:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347013AbiFABpO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 31 May 2022 21:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbiFABpM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 31 May 2022 21:45:12 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7020272209
        for <linux-btrfs@vger.kernel.org>; Tue, 31 May 2022 18:45:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24VNxwg4026536;
        Wed, 1 Jun 2022 01:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JbdCLzUBBYIK0CQ9XcbqkFX9c7tHZzCVFkWigBIzazI=;
 b=xiV6QuB5zX8FZDs+eyLXi798T5lVEr8RGtoLwDsY66Cdy88H7sz7PiDJw1J1V9ud5mMG
 azgT+Y/OMsAdGBNX5fNiFSxJCfrwLpLtP0DCs9/x5Ev7NY6MfwaIWVbPFjgkQ5ZSwY7H
 0xyOScVxaKD9ImNv2C9AS+aTdfko6Cg7ch1i7wmWrThSfYMOtyJulF5SYc/bHFXgUQwZ
 WV2PYTHDWbSrsNz0xufnUqVCSUolnZQ2bJpyw2c7VBL1Ny8Jo9sb65C8c0KGybkIqrmA
 hSKf7ieYZACg9nzorq3cwsvHbZn6Fiqq77kHN/PonOe2eOaMOxHa4g7rqwAGPId6Vcvx 7A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gbcahpkfn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 01:45:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2511Zvt7011496;
        Wed, 1 Jun 2022 01:45:06 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gc8ht9x90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Jun 2022 01:45:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pmc/zKZf936yhyUiwpKIdpQB7Gx73KxGyNazHOK8SOr/FEdWg0q1TGXCbm1VtwOmYNIc1YHz8mNPjS85tV3/QWSNiBwbohHVCF/WPP21nAbxicRJmp6vzSsVs/qRiLRqeJimW62JSomGHRch08fWhQPQ8NsWGJqKBg/L3ilmr9GBM775O3ncH0mnjWv1Gho2/KuKOwOdgtSxLU6XLxOaGiDxf8rrW615mej8vwMzxi1CnElvMV++BP75fAUm2DI5CAJUYTfiMwA6ueS8N6pZp9DMg9Re1ALfrzZjssd3FL0wYUxbkobFH3dBkr0V21D9oLXfSGOUF06qFz+8uMDdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbdCLzUBBYIK0CQ9XcbqkFX9c7tHZzCVFkWigBIzazI=;
 b=MmYp28OwI6fy+lGvQ0ogh5Fk1OZ6vDG6WOcABctCF0ZuyaHfYWQRgzPey72qRsrVhjtLWQbdLKbExpHUif/LiApmgBu/mBYnFcBX5CD+TGQ23H1lW4KsWXMvJ0rmwOxyQ+XOxs9mk+j8fTjCEzFCuFNSQetThrK0OOjJ97jISMwz7eA0JQPEuW6ChVUMtT4I3d3RgnqlWRmbfCm5tV3B8lVK3FgppHJ0fJFIRL+W6yOYErH0VzD23dPqf5yUEMMGvX5zrUg58Z/C7gvw6iQXzDn7mOw8PiGwVP4bsis7kooFDQhlc0l9jdXUcEogQN8y5S421COeSSG3JgMUY1SIPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbdCLzUBBYIK0CQ9XcbqkFX9c7tHZzCVFkWigBIzazI=;
 b=l3hFnR9Cik53x6qV708HY5bTD1nU8BdLBUMgF6yC8XNE+5AZNrFXcWp42ww7LYyZP4qdSUR+cEfKqEgtirGH/sYzGlzuNOGBVShqFnRz4djvE6GmG8GORS8Ia5Eb9qhMXGkOUSWktImdOOfQjAUgBuyKx1v9iq5YGrZkk1keOo0=
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15)
 by DM6PR10MB3564.namprd10.prod.outlook.com (2603:10b6:5:17b::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.15; Wed, 1 Jun
 2022 01:45:04 +0000
Received: from SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a150:6600:64f4:b606]) by SJ0PR10MB5694.namprd10.prod.outlook.com
 ([fe80::a150:6600:64f4:b606%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 01:44:57 +0000
Message-ID: <ded9e93b-a160-ef14-777f-2d23fe5534d3@oracle.com>
Date:   Wed, 1 Jun 2022 07:14:48 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH 05/12] btrfs: deal with deletion errors when deleting
 delayed items
To:     fdmanana@kernel.org, linux-btrfs@vger.kernel.org
References: <cover.1654009356.git.fdmanana@suse.com>
 <765e2a5d2f1ae54767fd49fae2fcae2dd34b63ce.1654009356.git.fdmanana@suse.com>
From:   Anand Jain <anand.jain@oracle.com>
In-Reply-To: <765e2a5d2f1ae54767fd49fae2fcae2dd34b63ce.1654009356.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::10) To SJ0PR10MB5694.namprd10.prod.outlook.com
 (2603:10b6:a03:3ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1bf01848-b1da-4dd6-bdbc-08da4370556e
X-MS-TrafficTypeDiagnostic: DM6PR10MB3564:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB3564972F7FF513B4A56A5A28E5DF9@DM6PR10MB3564.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkCEw+RJT8bZFQJQm4FIe4LSXyFwrTPdjK9VIC9oL6JI8/SHMsqKpryZJABNAEeEsx5SLyzKjkFerJ7DpEP8ABXX5CZMtB6ab6jL9Bat00f0xC28lxSGEiedvUDuGKHqZvaqEsulHKJdhfDL9Y6o6x75mnSZyE5u1pQ9Y6h2zURrUq+MqqhAI1tAiJGWrKYLPtOU+Quz2Ou/jeKrbTR6iX9HFwlLOnQ+SWI3l7MZ721LOLb4IHBTG/f1Ji1kztKn0WX+p8iJOJmCrh16enalh00toh34rGKShZY6iscosn5V02wq8cb2S0/RlsG7ynp78dP7ZBdh6HSU2o4DD0ivob2U0WCcTMKWo7xWcCRLGqabAT6MuYOanJuU7mABzGcn2NXbS4pmiOjfuM5R5QT47lKOx/1vw7LbmQPP2rJxp+KIaydo0LNaBqueY2m1Da9VCR2PrB6KWs9DvICe4F4QWaiyO+WowyGgOJpLrW+AD9GeMeYCaFkVjoC/ZEKvajZb+eGJHkh5KevIBX2sl/rPYszE61RDoEG9W36c2FtGiQO/aqSzRkNLbApJZKPxgl2hM0ZEeLGAjIQufEYzP+l/nHMQyaWoEmwmko6V3WVj4ZE2032ygWwhDdemhljmxM3JbvtWr9s0eaGjs8H4Ht4WbQ73ekG4pTZQO1NqjV9/kRYxyIwYDaslmD0kh7l+omBaO7ZeieUEQeA0JDEMGS1g3MVK1nTfAB1EDayIG/2S1lQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5694.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(6512007)(6506007)(2906002)(53546011)(83380400001)(186003)(2616005)(8936002)(5660300002)(8676002)(508600001)(86362001)(66946007)(66476007)(66556008)(6486002)(31686004)(31696002)(44832011)(36756003)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDVpL1h0TEg0TnFVUmUxWVlpM1EwQTZTdXhtSVc0TVFUNXBjdVpPQjlqd25p?=
 =?utf-8?B?QXRiZENOTVg2SUVCb1Vqc2ZWdW1zOHRvYmg2NExZQ2NCZExOOHlWWTk3V3dK?=
 =?utf-8?B?czZZeGJQMU44a1kvaGdKbUYxcWFNcmRVNS8yZ3VWa2NlYlo4MFVmL1ByaGc2?=
 =?utf-8?B?bE1YN0M1ck1lZXc2Z1NKOUZMQXlNWlJ2TDd3MWNKNEZPSkhCdXZZTlp6d3ow?=
 =?utf-8?B?MVFWdlN3Mm5PZkVkVUtpZlJhcDRzUlhOL1o2em4wY2lUdDhZWHBUUWlydnl2?=
 =?utf-8?B?WTFEZG5OMks2UUJTZVIzczlwdWozS05tck1GZjNOczhSN0xYNnJZQml1M0hJ?=
 =?utf-8?B?TWFJWkJIc2RhcnQ5ZGZHQ2ZEaHphM01ZNU9xMGtUTTB6dytKaGRKeVp0NEox?=
 =?utf-8?B?WUo3aitaU05CeDBuOTJqWnBCSXJ6eTh3akFPbEJ5aE9DNi9MMUY2UjBVY2ov?=
 =?utf-8?B?eEdEdXZoL254bDREcThMc3FsUG9YQWJWcTkvdUZDUWdBaUYrMVVyVHBPQVFx?=
 =?utf-8?B?UkZKWUNudVZwR21xNlZCUjM0b1dUYVNaSHZQeEwvK2VFT2x5c1hoa0ZZQkN3?=
 =?utf-8?B?enRyYkxqTW0rc0pidzRqQk45ZkU0RFN5aXYxNHdhZVJHUitvMHlRd1o3cVdo?=
 =?utf-8?B?VC9NUDlGU2N5VHVNUU94MzkxQ2ZOa2lvbVZtcHR6NmpBUjhNVEMrS2N3ZXdT?=
 =?utf-8?B?bTRhVVVRNWRuVmx4TmtCYUNMMnkxNDBwWG1DazFpMDYzMXVqOVRWUldhdGxS?=
 =?utf-8?B?UUkybVFCVEpNQ0JScTJOelE1a2VlV0tTZU94bVBuSnBseTRzNERlbzUrWTI0?=
 =?utf-8?B?NjhOMXFGa3F2R0NGTks4NldFNTVQZldDNmJKN3NFUmYvOSswWmtwbjczTnNK?=
 =?utf-8?B?MHdUTTUyMkMxQnE3MkJZT0tBZjhkYVFGMjh0S08wc0U0S25nZ3BNTmZINzdB?=
 =?utf-8?B?RVhXVkZZaC9IbVRiL0JoMWZJeDE5aGNkOE1JQ3FGZC9yS0ZYc24yK3B4RDlJ?=
 =?utf-8?B?ajYvcXJqUlJTTTFMUUhhbTZDaG44TmUxSDlsZnJPMTkwK0ZWam1nNzVqTWJr?=
 =?utf-8?B?cE5ZOUYrU1piRFg1UEYzUEx4bTFxVzh1ZDdiVTNubkx2NGcwNnd1SDV4NFhk?=
 =?utf-8?B?TnBLNDB3czFSbjdPK25VclAyMys1RlFhY2pKclpuOXUzbndsMEFpc2FPVk9H?=
 =?utf-8?B?ZlVpRzFKdXZNOE9yOFczYStpWng5ekJsMVVPMzhIcnRMNnQvWHY2aEcrSVUy?=
 =?utf-8?B?MjZpdkZLazExQS83bW5KYXlwQmJoQ01yOG5sMUFrdnNvQ1ZhMWFtYVJKSDFX?=
 =?utf-8?B?YUJKMVdkL2ZVcHRMWmVxZjZNZFdWbkcxSTQzcFR2azJ3UXRJWEQyTDR2bHBW?=
 =?utf-8?B?RVloUkhPYS81Ylc0MnA5Z3NLLzIvOGgzVWRKWjdnRkNOK3NiTUpVMEtFMTlX?=
 =?utf-8?B?RldBMjFpRDJXWjdTNnF1c3ozVzVhK0dBcWliRGZiRGVLUkhLZVU1L3BWWm1W?=
 =?utf-8?B?UUc3TUxOSnlqcmxwMWVTckdKaHJURHRJb0dzTXplU0JtakViTTE3ZUgzQmVU?=
 =?utf-8?B?RWZsQkRaSjNtZ2wyVHJJS2h6T0RmM0VuMHpEaUYvWDdSVXpkNERzTGxhMDFi?=
 =?utf-8?B?RWxKUm5IbXJrdmtxcHZuRUNPNzh0Qzg0dUI0ejd0dS9saFB0aE9uM3hFQUF0?=
 =?utf-8?B?TTNibWtxaDkzRUY3SkhhVUtVU1JPVUlWY3NwSGJ6NVF6aTVxQm1raGx5ZmdU?=
 =?utf-8?B?bnpTTE1wTjRNQXhmRTZLbERBdk5LZ0laUVNuSmZOQjdVS29renE4YVQ2TmxF?=
 =?utf-8?B?UnZGUk13eHc1ZVJkeHdnZnJEWHFyanNhNVRGZHc2enVTUDRaUFRlUW5UdDVR?=
 =?utf-8?B?QThmZUZ1Q0gySlk2T1Z1RHVvYjE0S0pYUE9QQWlXUUI4QXhsUGdmK2lzd0l1?=
 =?utf-8?B?K3pZdVZMcmV3WjdRb1k1dkFlNU05ZE9nL3l4UnVoZ3lrclgyQnhVdXl0QUpJ?=
 =?utf-8?B?N0I2M2pvczhNd1ZuZGgxZXlaTkg3aFM2U0ppTFhlcERlOXo3THhqOTJqRDEv?=
 =?utf-8?B?eGNLZFVXSlBJRml3UUszRmNBUzMvWTVpdmNOL1FiTXFwTVR2YVVhQkpEYThJ?=
 =?utf-8?B?czBreUxTMkc4V1Vta3IydjNKZExXRnE5VDVYbkt2NGlMcVVlTVU1bTdFTm9k?=
 =?utf-8?B?cjlEdlVtcDV5cXdNL2dNekJwZDVCbUFnSXBqM0I1MEZSM205L3Y2SldrQ203?=
 =?utf-8?B?ZTlRc2FhdDNlcHRkREJkMytMTEFEaXBOVnpsR1pFVys2YmYzb2Q1c1I5NHZN?=
 =?utf-8?B?ZUJScU80WG9kb1ViVWVIaWxHbElLMmVkN0FVVmZ3VGxsNFFhU1ZiOGpwZXJV?=
 =?utf-8?Q?4vAFtADq7U+P3BGK46kN3zpjRico+CHYBJnnUcmfis12o?=
X-MS-Exchange-AntiSpam-MessageData-1: w3/spfIVHeWFZlbe4m5lcCMLW3WTdkmdjNk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf01848-b1da-4dd6-bdbc-08da4370556e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5694.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 01:44:57.8962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9Ljftohi5z3Bbu2vCH5R12NeV1idW7nByqd27TIqd46/1ZCaoQw02YlZtls/h5Ld1iLBAWVze97S4eUXteyqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3564
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-05-31_08:2022-05-30,2022-05-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206010005
X-Proofpoint-ORIG-GUID: pJK0LMPf_uuCKVZ9ATukPt5Tkb-dPfx7
X-Proofpoint-GUID: pJK0LMPf_uuCKVZ9ATukPt5Tkb-dPfx7
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 5/31/22 20:36, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently, btrfs_delete_delayed_items() ignores any errors returned from
> btrfs_batch_delete_items(). This looks fishy but it's not a problem at
> the moment because:
> 
> 1) Two of the errors returned from btrfs_batch_delete_items() are for
>     impossible cases, cases where a delayed item does not match any item
>     in the leaf the path points to - btrfs_delete_delayed_items() always
>     calls btrfs_batch_delete_items() with a path that points to a leaf
>     that contains an item matching a delayed item;
> 
> 2) btrfs_batch_delete_items() may return an error from btrfs_del_items(),
>     in which case it does not release the delayed items of the batch.
> 
>     At the moment this is harmless because btrfs_del_items() actually is
>     always able to delete items, even if it returns an error - when it
>     returns an error it's because it ended up with a leaf mostly empty
>     (less than 1/3 full) and failed to migrate items from that leaf into
>     its neighbour leaves - this is not critical, as all the items were
>     deleted, we just left the tree a bit unbalanced, but it's still a
>     valid tree and causes no harm, and future operations on the tree will
>     eventually balance it.
> 
>     So even if we get an error from btrfs_del_items(), the delayed items
>     will not be released but the next time we run delayed items we will
>     find out, at btrfs_delete_delayed_items(), that they are not present
>     in the tree anymore and then release them.
> 
> This is all a bit subtle, and it's certainly prone to be a disaster in
> case btrfs_del_items() changes one day and may return errors before being
> able to delete all the requested items, in which case we could leave the
> filesystem in an inconsistent state as we would commit a transaction
> despite a failure from deleting items from the tree.
> 
> So make btrfs_delete_delayed_items() check for any erros from the call to
> btrfs_batch_delete_items().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

LGTM
Reviewed-by: Anand Jain <anand.jain@oracle.com>



> ---
>   fs/btrfs/delayed-inode.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/delayed-inode.c b/fs/btrfs/delayed-inode.c
> index bb9955e74a51..3c6368c29bb9 100644
> --- a/fs/btrfs/delayed-inode.c
> +++ b/fs/btrfs/delayed-inode.c
> @@ -889,7 +889,9 @@ static int btrfs_delete_delayed_items(struct btrfs_trans_handle *trans,
>   			goto delete_fail;
>   	}
>   
> -	btrfs_batch_delete_items(trans, root, path, curr);
> +	ret = btrfs_batch_delete_items(trans, root, path, curr);
> +	if (ret)
> +		goto delete_fail;
>   	btrfs_release_path(path);
>   	mutex_unlock(&node->mutex);
>   	goto do_again;

