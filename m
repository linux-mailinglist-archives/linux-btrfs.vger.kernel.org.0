Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67036D0A72
	for <lists+linux-btrfs@lfdr.de>; Thu, 30 Mar 2023 17:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjC3PwW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 30 Mar 2023 11:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjC3PwS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 30 Mar 2023 11:52:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB1CE1A3
        for <linux-btrfs@vger.kernel.org>; Thu, 30 Mar 2023 08:51:57 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 32UD0x3F028713;
        Thu, 30 Mar 2023 08:42:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=KPf9wwK/vbM9TlSuU7YYUrmKMcL7hWzcXTtMkzKgPKg=;
 b=Xg94Y0sOOF2MuvAljLkNvX8BYYNmt63rxxdcAXfbGrai/Kf5PIXdJQsrNJ4GjXwlHDlL
 su+j/MdblbqQAmiR9zZUvq0LLYBX4nNSAukGElJNULJWiN3Nqk4XdE7rQhQT8D15Y6W7
 Ow/mxB6K/Lj/uRoQafyLENYfYGzrMvPt1YE4PZEMhTE8AI9TIZbBtseTcCmKZp1DC4fs
 OPauMZkQpVss19K2RDGZAIB2WpTOlAR378qgb0fs53UIoTYjMnWgEdL5YejdhROy/UmL
 LmNUubPAZMeg6LwdSUxRGMRX2xm21iuKXEPvEGNxb4UspPXA1kxuvZOoiivBHzMAYZXc rA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by m0001303.ppops.net (PPS) with ESMTPS id 3pmwrcd6hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 08:42:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ig+5ZWltKKbQ90PpyxEWMliUV6fxjz/c27MCI8hNuNEXG8NieIScnpKbJ0sYug2nmtvKXZs+uVoQl8/qSHjvyFAqbsxXjL/o5fQdq5gO8F58tSEkKVqX+PQ5//KtOtbLdARXI+PTspyk8w1IbcvWu0Xru0W5izCSRjlfIAD3d9dETLaZJdvupy4EeNJq57lv59otWWXxMP60mu8eM2TQL74LK3fJXaGDcTOXdNRLOnnMjKxGT5QHTicnWIGKAwVKr8MYh6aZdEgfKIo0egB+pCW3adsVDaWOIThEYtVKwDPZDnxIpHB7kBOpS758kS+u667ruZzRwYl1nNJPgjgX7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPf9wwK/vbM9TlSuU7YYUrmKMcL7hWzcXTtMkzKgPKg=;
 b=mhAlvu4ITregbEvij2fRNd+ckYBUtkuXJ1ehVBhFnEQrcaEHF4zb+AHpfmbTD4SSSoAYTVOpyeN9Na6eanMq4ZN+kOH9N3kpkirTGPraSFloEbz5zFjzkNYKH/mltcCZ0qKk0y66DJvNEHJXF/AjiGEHQ3A4ReCbVPr2jV3ZMsrQZDKwant/G6aSDGoxFSEhPEOCr9J3fJjz8f2TXi6jFz/z85+mIgA984D1Be/6CUYwC8rMn3fx6JCW5wgz7HNnqxHKBu+a51S8Y0Ew33uZsfjaj7usHjgRPNNxeJz9XmSLhxtPavAVjf4yVfnjfmbSprBLn3yP74Qp4kVPouHH8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by IA1PR15MB6247.namprd15.prod.outlook.com (2603:10b6:208:450::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 15:42:14 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e%6]) with mapi id 15.20.6254.022; Thu, 30 Mar 2023
 15:42:14 +0000
Message-ID: <ce173f2b-06f5-f7b3-2cea-5a431a180da8@meta.com>
Date:   Thu, 30 Mar 2023 11:42:11 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: don't offload CRCs generation to helpers if it is fast
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Cc:     linux-btrfs@vger.kernel.org
References: <20230329001308.1275299-1-hch@lst.de>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230329001308.1275299-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0075.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::20) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|IA1PR15MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: 294a2fd9-f299-4d26-4e8e-08db313555b9
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6ZkEdrdm6ipoC0tALcfNRvPhBGWGnESMWNwOXASzZHMnHA9ckRvFDUTRgy/UWDwM9hj08xsM1x8vatGqaXT3Ceg/ZHLXKbvXanLGtroSbnXixXd9SK39bpQZ1+FzoPbubhv//UJDuTFNjMwGPL9wckKovHIlLx4G+rcC/zm+amOrHcToS6ii7Qlso6tAH3FwvEKcXVoe1Uqmh6PRJHTgGpKUvRYr/XL6tNkUp6KkKmcVASvZzE+pGXCJ8Fb73nWx7uf6use+DE4s4PqDs+t3xsGhz4Ci6DcHUtccq+T5ayqOzgHFsHyiNIvwW6QdC2TgVG+UCbWS2BGgnr72MbwcdxstahMBwLbPDxX1NwJ+/s+pG7mLMdIIDOuH6S6J7FCnKQAb2f8mPs2WH7cPWpL+nmwNefK2lcL32/nblGO6sbKULXLp27RyWiyxH/BEpUT9GHnCp/S84RwHZjh4pWslY9hb1CiG/9XA+OqQbp8pHVNCdp6X2OzfdnNsS06IAICtdRwUlQQ2k7HtmRSDDA5ZYzVYHYSToA4eOWdqa90CM+lQocNruavOV74jKVi4KuxhHA1CPIWkcS2q6PEzg8Q2qGT56vSHBjfAeL6S9M/+K13/0UIIXDnhRpqRfqpb5FeO8lnLBsiD5ADKV9vFUEC6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(451199021)(86362001)(186003)(31696002)(6486002)(8936002)(4326008)(478600001)(110136005)(316002)(36756003)(5660300002)(41300700001)(66476007)(66556008)(8676002)(53546011)(6666004)(66946007)(6512007)(6506007)(38100700002)(31686004)(83380400001)(4744005)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckh0ZkxSR3FJdkEzUW5QOWQrV1l1K2J0VE90bWVSZmdzNXZEcDAza05sUGFM?=
 =?utf-8?B?ZHFpR0ZjQ0NERHpRZ2NsTWVrVCt6YXBOZjdFK2kyckFSUVhlRlZqaXp4UFpV?=
 =?utf-8?B?bUNJQlBEWWtEMGRROVMycTRDRlBvQkpuU09CUEtnWXpVUWlpRHQyNHlPdDlz?=
 =?utf-8?B?QnpLNDJ0c3lsdE9UZ2gwVmZKSjlneUxlbWNHME9DZ3M2M280Zjk4TEhRcDhj?=
 =?utf-8?B?cy9JRUJpZDdFbHdjS200Nk5PWDl1T0FYdENEczE4aWdvcUpVbk1BV2Q5V1dz?=
 =?utf-8?B?SjVQWGQ1enkwUUF0Z2RCVW1SWHNycUJWNVNCRkpFUFF1Y3hBYWU1YmlVVHFS?=
 =?utf-8?B?WCtGY2k5NGJqUXhxUDQrVElMZlVPMkRUZXJtSW1TUlVTQ2dBZjdVOTZOZ1pD?=
 =?utf-8?B?YXNUYjNobTZXNU01ZVFhOWl5SHhUZWIvSDF0WFN4cXRMa3hKdEhrd3dOeWcr?=
 =?utf-8?B?cHNORktDVmh3aVpuVy9CSXF0eVRrcldueHlvalZtZnk2anhDYmo1Ykd3dStW?=
 =?utf-8?B?VjJwS1BScjdYQncxR0pJTzhJMEp6bzBjRlVQdi9rSklyUkNPL2NZMExtV1cw?=
 =?utf-8?B?YTVHYzkwMEdFNUxqMHVtYmtpaHFpV3dCOHMxN3VrRU9sSmdONzN2aDRDNDZU?=
 =?utf-8?B?Z0ZvQnlLb1VkR0xrU1BwYWhPaVNqQW05bGcwaEtleUtnNkZNY1lWdHdTM2lR?=
 =?utf-8?B?S25lcXU2MXVra3hpdlZ4YUVwUDJXbC9RZlROQzZVVmNPVlZuWmdLckpYa0I4?=
 =?utf-8?B?c1hLSVJZTHkrUi9SNDhWL0RwSWg4M2xMNzZmZ1gwTk1CU1NzT3B1WGRCMjRC?=
 =?utf-8?B?eWhITlZnVU5nOGE5L1VxREorRjRnN1UxSUoxc1ljcVZTYWpIUGovd3VqN2dD?=
 =?utf-8?B?V3dtUjBjSWwzMWFiZWxENm4zcVFZTCtvSURkay91U3hvbTNDL3pJWlFQNDhl?=
 =?utf-8?B?WGIvQVY2N3JvNDNPSHJVKzlDelJ2TTZLeWdDU1VMa0t3S3B6cXpvckhYakpk?=
 =?utf-8?B?Q3RZR0UrNENJRENHUHptc09OOVU3RGNodmdaKy9NMVFpUThSemNMb2pESFhk?=
 =?utf-8?B?YUx6UW5Nb3NGcHZjeUxDQk9lalFlcDlRQWoxZ3pHSWNCVFh6UERINHhrY2Ji?=
 =?utf-8?B?TXk2aTVPY2xNTUNoeHU1aXFkM1oyWXBTdXZUS0srKzA0dHVjclJNMDJqSGJN?=
 =?utf-8?B?cTRpQjZZOHJ2MUdMOFlWRElUWHQ3SU5iYTlVTlpqWTZGVTdaTXJ1UG1valZh?=
 =?utf-8?B?VDBTd0c4THR3bURoYXJuaExXSWpDcGRYMDA5U0RzN1RlYzJpaEdpMzBIS2Nt?=
 =?utf-8?B?SFFYWUt4Njk2OTVmeFBkRnZsVW5mNk5udTNzenowVjZnOWl1NkE0TVBWQ0M3?=
 =?utf-8?B?VXVNaVpacWJvRUxIM1hWaWY3OFVzRCtzRW1ZaHRRaFZvcUFGbFdzNFdjaFRq?=
 =?utf-8?B?eWdhSHVkWVZ0ZFV5WnhRS0dVZWUrRUo0Y05BQXVFQWxyTFMwRHZpcml5R0ht?=
 =?utf-8?B?T0NuTjRqNUVpQTVybkd3NHRwbXZHczZkbEVQbXZxc3VYaVVPVXl3THNJZnV0?=
 =?utf-8?B?NEtWT1dMdG9heWdWemNhZ2YvalR4T1N3ZkZ6eWVrSVdHczV5WG9lOE1xczJC?=
 =?utf-8?B?MWpvcTlFaVBJN2NJT3V6R2F1QldXZGlsYm94eU1HbTc5S3YwMVdERFBPN1k5?=
 =?utf-8?B?dktBcDFFaHIrdUlzRXpvaTFTK1o2SmdYK2hudExvc0MvQWFTbmE4bThnUnVi?=
 =?utf-8?B?R2lIaVI4L3dpVnZKUXB0SHhYSXcvK1hsWXFZWVMzS1RCN3BCb2NnaW80Y3BI?=
 =?utf-8?B?ZXBueU5FNTZLcDgybHBxcVNobWFpVlVvcWVST04xTTRhcWl5ZnZtMHR2c21a?=
 =?utf-8?B?dDh6UDJ6dUxCVzZpVm93TEwyNlViUmFPaTZtWE05TUIva0x5S3hMYTB4NEh6?=
 =?utf-8?B?VUYvcVVVRzJtdS8rS2pRM2FQM3pEdTk0TTBQNHN2T2tJU3M2K2luQ0xNcTlH?=
 =?utf-8?B?VmFBdHRGa0dGbU43bFFhNkRtR1lxcWJEM295cjhnVmhYZTVwNG0xZDRENnVG?=
 =?utf-8?B?NmV1Nk5pS0d4a0RqSXhtMFFvYi9rNURkYU5IMXB4blZGSkJHVXZPWGhvcVV6?=
 =?utf-8?B?NGw1RzBLUy9Od24wUXArZitMYTlxbmROOWpBSkpPTytwdDdQWUs5dVVpMGV1?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 294a2fd9-f299-4d26-4e8e-08db313555b9
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 15:42:14.6209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6i/rTae5IKC4sedWBXf4Uqgnzc6363ugCiOrEGSZLb61wxeMTd/w1ONd53mpRyHr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB6247
X-Proofpoint-GUID: umzlcYmLvhESsxlJP78Rl5I3MBCVvMqj
X-Proofpoint-ORIG-GUID: umzlcYmLvhESsxlJP78Rl5I3MBCVvMqj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/28/23 8:13 PM, Christoph Hellwig wrote:
> Hi all,
> 
> based on various observations from me and Chris, we really should never
> offload CRCs generation to helpers if it is hardware accelerated.
> 
> This series implements that and also tidies up various lose ends around
> that.
> 

Thanks for doing this, and for fixing up the fast crc detection.  For
the whole series:

Reviewed-by: Chris Mason <clm@fb.com>

I spent a while convincing myself we really don't need sync_writers, and
it's great to get rid of that.  Tangent-man noticed that we're really
close to being able to drop struct btrfs_bio_ctrl->sync_io.

As far as I can tell, it's only mirroring wbc->sync_mode, and the only
place that still cares is lock_extent_buffer_for_io(), and we could just
pass down the wbc.

-chris



