Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DF36C8FB6
	for <lists+linux-btrfs@lfdr.de>; Sat, 25 Mar 2023 18:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCYRQ7 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 25 Mar 2023 13:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYRQ6 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 25 Mar 2023 13:16:58 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E874A1BEF
        for <linux-btrfs@vger.kernel.org>; Sat, 25 Mar 2023 10:16:56 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32P9Bknc026695;
        Sat, 25 Mar 2023 10:16:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=EZuYaaxagbOV9WZaXjRSMQSI79VUlLhhOoSiaawsAFs=;
 b=FzPPb6B1SieyW03DOpk/J/WatC7RrFO35mf2nrMFS3PI/UEOy/icaDZAGrmLvnvcyP2Q
 /D1l95umqJNnzxZZ84ddA7u4RjpSt7UFjmlS3LXmC7zuCAFK78C0WdaybiTxqFq8IVDz
 /uvPgC8NihqocmJaWxa49BcWWnB+sR3JOFEK10u1xG3XktkLtzrAAqA1TP97fxTaVHzS
 bma0o/BCW0dBK6Cp5QC7aut/FEUcmA4CZL8kx5j/x5Eus6Y/qhXHnjnExeXkE2hDJ4oU
 oEYRaOmSWZAAgVuKil5Hboopin67um0r2ToMW4vyYyzd+ia0B5VYeRu/7dUNK/KIs790 fw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3phx309dy2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Mar 2023 10:16:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zqj5SF9TSF5ff/2PhcUbgqLAYlz9iCtPr7uF8BH3rLJPIPJz40LbO+MDCg/hux203Xgq01sdeqVwxfyZF4xpsbPGFeFou4YRMR9b8AEIoaPDcWZFkK1jkcU3RXPR111kQB1oWYoqA2dVDhMHX/VQIkOfnk9xnZunHD+LndoUE4cX35Cske47slvmWy7R+C7HULVFIXBnJ0VJg/wM39uo4LrRKYLJyBTwU2YpfH0eJcU4Tx7Ehcp4h3HvXC+Jtpv56UfCQVcB5imZloXEJkLUI69KVRP2EH19p0UEDrHjRPXeVg922kfD6Tzg9V6DrZ8NGP5BtoNUxxdGADafxGhDkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZuYaaxagbOV9WZaXjRSMQSI79VUlLhhOoSiaawsAFs=;
 b=f6mXegsNrUXbbNPn+6QKphndZOQiX+EuqzZBN6wxm2NiW4t0GWKVBwaamxKk6UnDMZ//2krKOCMCo4N8+eMpj47Qf8RO+DVS8KDdK9HaVaCLAM+a/0WYcJDZOmFzz9PsChSHj3rYaSHPz7xErbC6mgR+mYikKtlxWJKJUSFQWo0TlnFR00qf2EdhBMF1NuZ3g+bSj2RHYGyBUG58yHpq+HDi0WvlwNc8Z48V+/OHyymCxCooF+NGzjghnrJ9cFub7mvDsdPM4p+JtZ9Gsxz1VYtWvCJn/KX14N8/L519HLYSz0fgWh4+OdBeQvpvQihjn8KAmgDQlZpYij82aJN1JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by SN7PR15MB4173.namprd15.prod.outlook.com (2603:10b6:806:10f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Sat, 25 Mar
 2023 17:16:42 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e%6]) with mapi id 15.20.6178.038; Sat, 25 Mar 2023
 17:16:42 +0000
Message-ID: <94c5e327-efa6-e26b-a10e-672481bd908b@meta.com>
Date:   Sat, 25 Mar 2023 13:16:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 03/10] btrfs: offload all write I/O completions to a
 workqueue
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Qu Wenruo <quwenruo.btrfs@gmx.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-btrfs@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <2aa047a7-984e-8f6f-163e-8fe6d12a41d8@gmx.com>
 <20230320123059.GB9008@lst.de> <d4514dd9-875a-59a1-e7c8-3831b1474ed8@gmx.com>
 <20230321125550.GB10470@lst.de>
 <5eebb0fc-0be3-c313-27cd-4e11a7b04405@gmx.com>
 <20230322083258.GA23315@lst.de>
 <ff18e85e-061d-084d-d835-aa7b23a54f1a@meta.com>
 <20230324010959.GB12152@lst.de>
 <14e253bb-8530-af11-7395-9e4148249c54@meta.com>
 <eb544c31-7a74-d503-83f0-4dc226917d1a@meta.com>
 <20230325081341.GB7353@lst.de>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20230325081341.GB7353@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR05CA0054.namprd05.prod.outlook.com
 (2603:10b6:208:236::23) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|SN7PR15MB4173:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e69d112-9de1-433d-6d88-08db2d54b3b3
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tzvGx+PWDWOzfseDnqZ3ALoa8qZUNptoXA/kBhf/baCpSpeZbQbiksVtNdnpDPoccjgscmNtfNe1jRx0F5winz/TpoVGz9Cmt73w10Y1Z+oxWyfhqERsFLgefSv1ogjzVG/5rUSkMQtm1YdsfS5FqEHOkYRrSvDKpdsyuS8+PHvFlMSy+GbUCAHkU2YC7Fc+zcDQHw8Et6L5nFQglUETSw1NHnlFOuI4DwuauKH1SRB4O0W2IqKOaiwAXaioxBfIT+BOqMG4tobf6p1whVrRD0neROej+ikFD/khngJd3Bzazo4no/xSz2HbTvgxsh8JT7RPOJ1xk96n6CT1bWjjsEshQzFThttzcYP3Z8H3GgRN2tK/PiMa7u/HzUw2b7EWTIdlyPKKtorCnxd8DswGb4mkfAntf01HcIxlZvgMzubjhVUf5MeLFm4fnz0Tdm9OR6y9qihbPZUDBXBmArFYKM1PNiA9zEDBZuM1exBLxhsBZT2P6UfLDo09jKAXp2IKZKRobBkjqzzsodlI7L+AdNcD1y0QjLFtIAXQVjhHABM+62GtVkTTeAm7uNSCv+YeUu+wA3IEep2xs0wJCav5f8UHXlfi1mqCmCOeBJ3LeMta0h5mkt4x+iiW1MaGu3tpR23EvTalNRag1vJnAqn0Aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(41300700001)(4326008)(66946007)(6916009)(66556008)(66476007)(8676002)(53546011)(186003)(31686004)(6486002)(2906002)(5660300002)(8936002)(6666004)(38100700002)(31696002)(86362001)(26005)(6506007)(36756003)(6512007)(316002)(2616005)(54906003)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THBjSi9ub2R5MHAvWnFndys5cy83L3Z1NjdsM3A0TlZ1QW9EN0tSTlF1WU53?=
 =?utf-8?B?K3o0dXhyMFprNmtDUm5HRHcycnE4MjJqeDM2Y1VrZEwwdTFTdDYxYWFwSENy?=
 =?utf-8?B?NWE1aG50ekR5d1U1RWVMdm9lSE9oUytyWGFHWWpnQTk5c1Rvdm1ldUJsMm1Z?=
 =?utf-8?B?OUJGMkZmaFd6L0w1LytCeVBTYWZvRHA3RmQvT1VFaXRwRkFFRXNmQ0swd1BH?=
 =?utf-8?B?WTZrbEVnemNGS0xhcENNMzVWYWJGbktxNUp3TVRFUGNHRUphVGRFeGE5WmUx?=
 =?utf-8?B?eDlqZ0RabWZOY3hUNWlUbTFWbmo2Ukc0cHZhM3JLNkdTOUFXSzhMVitWNG1z?=
 =?utf-8?B?dEhZTG1wZkxpUkVwQUxCRUpOUWR3U0wvemRnQUtzV1N0ZEp4WlhUZk9rV3N4?=
 =?utf-8?B?cG5VamlncHlCSnRxYzYzV0NGcGFkV2s0UVJDdjJ1Mms0MURlTmVzbm1uV1Iv?=
 =?utf-8?B?K0tDbW5wUzcxNTFKUGVpRHhWREVBSHo4VW1vcTZ6L1ZMMmNuVFRDM2pCSCtU?=
 =?utf-8?B?VHIxK093b09IaTlYTmZ2OGh4VWwrNWZKWGZMS2VZY2U3YVk0bFlRWDFIR21N?=
 =?utf-8?B?Q3hncVJPMWE2dWRjeVRvMDBwODJONkw3SXBJSFRlczI3eDlNTUN0cU81am1r?=
 =?utf-8?B?UmpRQWdud3lyR3lJZUJyY1BSbnhGZXhBcHdGTm5qU3JIbzVITXBKd3YvdHNO?=
 =?utf-8?B?eTk3aU1Pc3pMSmJ0NlRBYmtyeFI1MTJGQUhrMy9CWnFtYUc3SUJTdnN6QUdB?=
 =?utf-8?B?QlRyTkdzazFsczZOckZpQk5WbFlKTnRGT3o4eU8vVS92QzZqQW9mM3NLRU1s?=
 =?utf-8?B?QkxXSEtkRjhSYW9XNmVyeHkzdXFhYlFaWkRCNnJzT1BlaTJFTVpWTmVPN2t6?=
 =?utf-8?B?ajFIcjVrNGQzQkhpekhEZE5EeC9kS3JwSTFrbUtBekxkRlR1MXh3U0l5V3Jo?=
 =?utf-8?B?bnZWcytPN2lmYit6cy9LUTB0cWFsVzBhUUhyakF6TVFUc09Kai9mZkdkTkpJ?=
 =?utf-8?B?UmxCSjdvMTdVNnEzSzF6YVV6TWFtelhlU1Jia3MvWXNXRGtHNDdPdnAwOXR0?=
 =?utf-8?B?TTU5RmJUaUVTNVNjUUdMYkRZTWpJS2lzaDZHZU9mVzl5cFFMQWg1UUtKR2E1?=
 =?utf-8?B?SUptZitzNkM4RnNaSEJhVnZ1d1k3UUc4SFZSZUw5VXhyMkhreTRWblVPUis0?=
 =?utf-8?B?Y2NNN3pVUTFreG53aFRDdlFBdk5qSFZWMGFmQjVTd08rejhrTDJxT2ZaeXR1?=
 =?utf-8?B?dDBqNzZiMHNVZFQwU0xTb0x5SHQwOFRIdEx4ZERrbWJ5bUFBNUE5UitIUW1O?=
 =?utf-8?B?TWtHNmlOTjBSS0ZvZTNYalVyMmIzRVN6SUJLellpTVhOUklzODRlQkVqV2hz?=
 =?utf-8?B?a0k0TzlLck5qcmM4dG9CRW9WZXhJeHNJWTZmendYUVhZb2cxS25qV1RHSnFF?=
 =?utf-8?B?dHg2T3FyMmo2Nnk4Vit0a2xsUFF0dnVZUTYxeThsNXN4TVFheFVveXc0RUc5?=
 =?utf-8?B?VGxjeUNDYnZUY0hMenFnSEVzc0dnbGYwcGliR0RWT1lXazlYSGpIWEJGeDV0?=
 =?utf-8?B?TStOZDJTbjVEcGNtOHNhRlpzTUc5S0M2MWtYVnVvWXozcDIrS2Y3NXc3MTJs?=
 =?utf-8?B?RmJWUWxTaG1hVzFZdVcrNVFHcFR6ZFBXQVMvcHo0YWZUb3k4aWw1MWFDbUdL?=
 =?utf-8?B?SzY0cmhDdkd2bUl3Ui9jSXhaYmRqMC9xb0Y4dk01bzZiY2tMQkVRZnNRTlln?=
 =?utf-8?B?RmVDb0FFQlcvcXdBUFM0NVhkcUZobFUvSUQ4NFpiNzlubE45ekxRaHc3Mk9K?=
 =?utf-8?B?K2Q5SlR6eUVrZ3hnUHArU004VzNadldzdEtZa1N5Zi9WRXgzNlJoYSsxYzJI?=
 =?utf-8?B?ZXBTL1drRFhjaFhrRmNkRzYwWHJ0ZjRyT0VTeWhwK2ZOeUpwc0p6WGJWSWVL?=
 =?utf-8?B?NkNxTlVuZkdXb3ZndFJLOHg5RDIySWFmbm1GNWQ4RlhFOUFxdUkraVN2TnpI?=
 =?utf-8?B?LzZKaXBRTjVrSTN4TlN1dUlEMUV6ejM4YXNwM0h3cVhwU3ppNWRhZUF0dVFj?=
 =?utf-8?B?VnpnYkFQNTF0SjdNYk5tNEQ5enlyNFRJcFh3emdMQSt5cGpJcGxJY0lvN0x6?=
 =?utf-8?Q?dPL8=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e69d112-9de1-433d-6d88-08db2d54b3b3
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2023 17:16:42.0002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c09/hKG8y0+fjSPqVou8pcA5KJmTkMkAKKzKZ1QeSfbUbPjyWQvRmPXeDoOZ6Kci
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4173
X-Proofpoint-GUID: oVLTRJH1_6sycprqyT3TRQroBhtTKZhC
X-Proofpoint-ORIG-GUID: oVLTRJH1_6sycprqyT3TRQroBhtTKZhC
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

On 3/25/23 4:13 AM, Christoph Hellwig wrote:
> On Fri, Mar 24, 2023 at 03:20:47PM -0400, Chris Mason wrote:
>> I asked Jens to run some numbers on his fast drives (thanks Jens!).  He
>> did 1M buffered writes w/fio.
>>
>> Unpatched Linus:
>>
>> write: IOPS=3316, BW=3316MiB/s (3477MB/s)(200GiB/61757msec); 0 zone resets
>>
>> Jens said there was a lot of variation during the run going down as low
>> as 1100MB/s.
>>
>> Synchronous crcs:
>>
>> write: IOPS=4882, BW=4882MiB/s (5119MB/s)(200GiB/41948msec); 0 zone resets
>>
>> The synchronous run had about the same peak write speed but much lower
>> dips, and fewer kworkers churning around.
> 
> FYI, I did some similar runs on this just with kvm on consumer drives,
> and the results were similar.  Interestingly enough I first accidentally
> ran with the non-accelerated crc32 code, as kvm by default doesn't
> pass through cpu flags.  Even with that the workqueue offload only
> looked better for really large writes, and then only marginally.

There is pretty clearly an opportunity to tune the crc workers, but I
wouldn't make that a requirement for your series.  It'll be a bigger win
to just force inline most of the time.

-chris

