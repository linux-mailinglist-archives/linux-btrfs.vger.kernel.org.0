Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7380C6C85C5
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 Mar 2023 20:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjCXTVM (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 24 Mar 2023 15:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjCXTVK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 24 Mar 2023 15:21:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C53EC52
        for <linux-btrfs@vger.kernel.org>; Fri, 24 Mar 2023 12:21:07 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OGSVOH000586;
        Fri, 24 Mar 2023 12:20:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=y+8sBxGOi1FjogghAaCiaIjGzk3qVQLeVHub6y8C+mA=;
 b=MqqwY7e5WZrAGJ9z7g9uon09/X6SWALCEKnKQcC+o8nyQlTTWDqZCiTmguBR+06lnFnz
 PKNCajev7ZUUPhwzNNBZvwIFksqgNfOODWgsY2o3obVuPnyAiD16xGscuHJPyICC2nj1
 wzu2y3cDt+FbfxzF+TgPU0G/W7pa3Q+bJwiwhLU8jvvoaOJ318K9zvuEoC4kvAR5jeQr
 B/4FZsMQE6Dlod2jgQzlRwtdyVQx2161RfO5E0xTZ1LwF6L73XQZ0xhyLbag5ODAWkBu
 OP5rDfWaPTPyA4RmYKUOdO9Ep4r+RRsoMlWoXe3GD/25oo3AUHTlpQzOlbAhCUiYrCde +w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pgxmqx139-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Mar 2023 12:20:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMDfn9VUP9Vo8uxg+OJeVY67CriMQ2x85gH7pJxezisaL7gz3tBFcmTYxstwwAF7A+khnkmjDdBKwi3wWpaseVTXypppaRX52wgMTF+8q4Fz1BzK6tPbBxeWqsjlcSG4LARyCJRtcKj/fumnC3SUM21FAaROdBkIXatm+zwQYNAzi+0j3v80CcgZwkdtGkVPFE9h9pCKehxvdGszfFeChTNVUcDgN1VJ1k7d1mxKxgO+QB24egMaEbPpWWuCW5gKOZTj7pqIYVX9+bm/TYOK/UxZreAxG99poKG8SCQtH4xa6y74kdGgoYaJXz/3VIcRRxDb4zuMeRHJkprTdFoGEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+8sBxGOi1FjogghAaCiaIjGzk3qVQLeVHub6y8C+mA=;
 b=OUnJIcqrzjzHU1hmUPKNMt4NHGhFSX16U5xOAsx62LJM7hHBHMV964e5u7NP8slcNYLhU6V3R8kMUmQtFbyGC99imF2fHWm+z4xb9sTob/jZOoPanh/HeedragBsix/2jh+pDrdKku2nrca/JA3A9KsnE2ABjGMHHIQa8/BM1T5vUIG5v6CCEfWPKq9zLcpE9KHtjwCoOnwI2XXOoTK0XyVWrfY/pP6uTlEI/ywBmyYM0fxtdvD/mNNwUJdZFraqVcG1q6t3T6uuPtutN2MlWjYeiLaMTm97urqzN1zTgzvDDmFfWP0yocjHG08g5PUUmFrlRAqncnLXLezuC9eB+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by CY8PR15MB5900.namprd15.prod.outlook.com (2603:10b6:930:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.40; Fri, 24 Mar
 2023 19:20:49 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e%6]) with mapi id 15.20.6178.038; Fri, 24 Mar 2023
 19:20:49 +0000
Message-ID: <eb544c31-7a74-d503-83f0-4dc226917d1a@meta.com>
Date:   Fri, 24 Mar 2023 15:20:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Content-Language: en-US
From:   Chris Mason <clm@meta.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <20230314165910.373347-1-hch@lst.de>
 <20230314165910.373347-4-hch@lst.de>
 <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com> <20230320123059.GB9008@lst.de>
 <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com>
 <20230321125550.GB10470@lst.de>
 <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com>
 <20230322083258.GA23315@lst.de>
 <ff18e85e-061d-084d-d835-aa7b23a54f1a@meta.com>
 <20230324010959.GB12152@lst.de>
 <14e253bb-8530-af11-7395-9e4148249c54@meta.com>
In-Reply-To: <14e253bb-8530-af11-7395-9e4148249c54@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0309.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::14) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|CY8PR15MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5cf468-db99-4bba-d64c-08db2c9ce039
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lfXzvfcMKoepgX5k9HxK1rGjR/K6c11/o0gsG6O6rMzP+4RmoIaEQ4f1jwavz3+Iw8bCFHJ/74QinDg2tEc2f4+4i4D2RF4vpxLyYYJDoGobP7m8YGmu89UT0z0JuuaHWDOn+L6zIZBatOC7u7xHHdl0W1+RMqDcK0Es4YdMuMn3zjgRmKeKEKnwuFccVAHhskW917/Gi+DSKqj8cBdRpauFPBF1HH8Lml6221WJDKgctleHzyFmUnM6JOLZnT9A7IwCntR2EhU7/vxJRIR7QJQTlW/Hlgn9+QPmMEHAkwukxTaadJNCEmlqMW7L8GxYHttua39/q6IkB3IvDQQgshvmgIbl/GBnIYIoccFRPWK0Rp+zNiaHCDn4+2tAPBb7kU6c6V7XsvFYLVrxfwxVcdsM1WnXcsmuftvyTzj+aNQVnsj8Ny/gtyUIRu3DMhxBRzVkXyX/uZvBqgl6fvcJxDLMCsiRklOXPFfpdgL8g7qLWxaxhgZcMIuHBheu5+0NsInzZzhymgCTYALsufF4lAKH5YMQ9PaN/LLNopFxqQeyUrj/JJdwuTS0AvRsp3bnP8hgxY0ru5LRaCkiXK1tBrGur4GEXDmIf2OfqiA8N2iZoNVSeM+LpieHzBZ8bLjEPKUo66SVahSDmLddTQpYMFYd/IBriUc+476vawVBNO2uX1ad4POoUgPnGVgwyL6lB4beWst7nZNTOppkQRKwGbIp5eHyGKa+ANfC9XYhrc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199021)(38100700002)(2616005)(8676002)(186003)(66476007)(31686004)(66946007)(66556008)(4326008)(6916009)(41300700001)(2906002)(36756003)(54906003)(31696002)(86362001)(478600001)(316002)(4744005)(5660300002)(8936002)(6506007)(6512007)(53546011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnd6dURSN0NIUW5EUXFNL0VXdDZQWHd1VGZ4blArNERPQ0EvNU9vaTJ1amdI?=
 =?utf-8?B?azFicU1GSmVVMUNidlFTVVBUdndrcWxyZHk5QlVod2NsRzJyT2dDWHBPTEtF?=
 =?utf-8?B?TVc1NGMwUWFIcmNkQ2xTZ2hVQ2xLUWRPeXR4YWxzeHloNmdobkkxU0l6OFd5?=
 =?utf-8?B?K3RrQVo1aFRiYzZtSjExdk5ya0NTYnV1OVBaVGF6Q1FPUHhib2lvNzJFTG1r?=
 =?utf-8?B?WXM0Q1ZKalRZdnB2MlMxY2hMYlBZUTB6bTNKVXVneHUrNVVacUo3UzQxK3d0?=
 =?utf-8?B?K2dNUTNMZGJUeGJ6Q0JtRDJNM1Y4d1VLSWVIYmVGcDRuUitkOXphWGVicTFR?=
 =?utf-8?B?ODdkdDN2Zk1XNU1aajMwSnJwc0tSbFl5MlU5T25jbEt2dVF6Q0k4UUdWRWU1?=
 =?utf-8?B?L1Z1V3BreHY0TzdOZW83RGxIRVI0LzdDUzk3d0kyVWdBUFNyRTR5T0xEYjZw?=
 =?utf-8?B?RzlHd1FJeEtLeTRPcW9VaWRYQU5MTDVlc0IvZjhxZmh2RTVoODI0TjRXckFH?=
 =?utf-8?B?b3ZOTmtwTmR2Rk9rY0xEd2lWaUsxV2xpMkUya1NBVGdpNmh0eHppTlE5UXNq?=
 =?utf-8?B?M0JvRjVzR3doekQxZmsxZGs1blh6WmRSckhQTEtvVnAvcVI3WVRIL3lsMy9p?=
 =?utf-8?B?YlF1Nm0xTmRmdkRuWTQ1a21NZ2R1SDVmOVFuR0JVMys3MmZFcG10K3U5MUZq?=
 =?utf-8?B?VW5UMnAzQzFGNEZTYTVKZVNxR2REUTRpUVZPeXlZNDJIWjhiQW5FMlN3ZFlv?=
 =?utf-8?B?d2tRUTVnKy9tSm9XQUdZSlVCd0p3UkcwMU03QVBYU1RJYkhqVWxXOVZyQ1J6?=
 =?utf-8?B?UWZiYjhLTkk1TzZzUUNoZ2FIOUlPNDdOWDdJckJ5OUdFaUdxWFdxQ01QOVJF?=
 =?utf-8?B?clFyakhLanV3dDNwc2pKN3FRSVJFSmZRM3BjUldmbDY3RHV3aU41eWg5SVQw?=
 =?utf-8?B?WkJ3MFVmMkZBMkhYRHVFZkh1QndsMW5zQjlpdkNwZUxWbHFkQ2dQOE9MZ1pR?=
 =?utf-8?B?eWh2a1FWQTlicWxDcDZjTTlHUkZUZmFSYzRPMnhWK2trTGJtZ04yTytMTG5B?=
 =?utf-8?B?TWRCWWtvb2VPZytBNGJIcytHQWt2MlNMb3ZFTVlYTlQ5NS9lMnFkWmMwalNR?=
 =?utf-8?B?YmpmamxneEkrdWEvUnRsRUNnVnUzUmd3blBBbG9KZTVzSmZidDVVZFoxVEMv?=
 =?utf-8?B?LzZPTndZNm8ycXRUaXNzZ2huSWkveDRVZStFcndBTWxWaERpZS9uQm5zYVJh?=
 =?utf-8?B?ZzBxMGRsNlNFS1djTlNkVzdzVUpCaWc1UnJwUkdJb1dyN2cybXdrK3NXRVVQ?=
 =?utf-8?B?WkRDLzB4VFJXeEdBWVo3TlV4ZGZSVzZVOVdLM3hSQ0RpUjZqbGJCWkFZbUpR?=
 =?utf-8?B?U0Y0OXNoUXFEVFRrZjU3Z2JZcW9FMmttOXRJL1BxMzN4WlNDdkRjR2JLeXZU?=
 =?utf-8?B?OFNxNGxxVVBNMG45eWhMY2RoM1QyZnYvNHVjdnZuNVk5b0s3NEdGdmtiUHNM?=
 =?utf-8?B?eFpGQUJ6eVdjUVFyYU5TWlBWdndRaWx6UWVRLy9PaUtvRnpqc0NxK1ZyejAx?=
 =?utf-8?B?blZVSGUyWTY0ai9JN2ZJWWZpajhudjJWVEFrWVoyQ3pUSjNDTkVmWVg2ZWF0?=
 =?utf-8?B?UGxGek92SFZOb01ET1VLSGR0Mk9sb1RJekk2YzY1M0NnZHVrZy94UG1JWkcx?=
 =?utf-8?B?L3U2N0E2MDhEc0p1eExxRzdoby9xZFY2NnNLdC93NENTbmN2UmxneFV3QjNq?=
 =?utf-8?B?ZlV3S0FocExwYUhlU1pCQ0hxcisxUkh0ZTZORXZVZUJIMU83eGJ4aWlKejBH?=
 =?utf-8?B?S3VhRkZkaDN0VmZBem0rRlBqL3RHRThFNDJKekcvUTBaS1JYakVzNmdpc3E2?=
 =?utf-8?B?Y0ZNWS94UDF5dFRyVk1VZ2FBTkhSTFJ5ZlBZMkdJUFlFUEtIeG9JRGlVM0Vq?=
 =?utf-8?B?K1Fsamg1UTdRL0VGYmRIbjI3Rm9tZTRzMEM4UEpqMEpRdnVUZFQybTZ1UUVm?=
 =?utf-8?B?QlBoMUZQWVVETFVITzFiYVJEUlhJRkVSeldrLzB6RWFkMU9tWCtkdkZWWi80?=
 =?utf-8?B?dllaM3NsWW1SR0t6Qk41QldNNkNEeUdNMHkrSk9kS2loNzg4aGRrOWI3Vklp?=
 =?utf-8?B?bGNjMXV2Rjl5ZE83Ui96UTc4SmJvYXVqL1gxVGFQT2xYSWFFYmdXZk0rSFNO?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5cf468-db99-4bba-d64c-08db2c9ce039
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 19:20:49.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Isb5kx12oj0nnz4rYRPKJ4pdUIX9BwzhAwncYunMOIYhMXMOQxXhPkSZyA0QgX/8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR15MB5900
X-Proofpoint-GUID: fdw_gy21zIPaIHLPk96KyQWDX4UJz_Vg
X-Proofpoint-ORIG-GUID: fdw_gy21zIPaIHLPk96KyQWDX4UJz_Vg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 3/24/23 9:25 AM, Chris Mason wrote:
> On 3/23/23 9:09 PM, Christoph Hellwig wrote:

> As you mentioned above, we're currently doing synchronous crcs for
> metadata when BTRFS_FS_CSUM_IMPL_FAST, and for synchronous writes.
> We've benchmarked this a few times and I think with modern hardware a
> better default is just always doing synchronous crcs for data too.
> 

I asked Jens to run some numbers on his fast drives (thanks Jens!).  He
did 1M buffered writes w/fio.

Unpatched Linus:

write: IOPS=3316, BW=3316MiB/s (3477MB/s)(200GiB/61757msec); 0 zone resets

Jens said there was a lot of variation during the run going down as low
as 1100MB/s.

Synchronous crcs:

write: IOPS=4882, BW=4882MiB/s (5119MB/s)(200GiB/41948msec); 0 zone resets

The synchronous run had about the same peak write speed but much lower
dips, and fewer kworkers churning around.

Both tests had fio saturated at 100% CPU.

I think we should flip crcs to synchronous as long as it's HW accelerated.

-chris

