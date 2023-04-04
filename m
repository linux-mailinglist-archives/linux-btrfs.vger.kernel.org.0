Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4509E6D6B4D
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Apr 2023 20:16:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbjDDSQH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Apr 2023 14:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjDDSQG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Apr 2023 14:16:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8F710CF
        for <linux-btrfs@vger.kernel.org>; Tue,  4 Apr 2023 11:16:05 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334GrBx6004644;
        Tue, 4 Apr 2023 11:15:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=CxF05928wX+ZGHddHC7wb7Bugyun62/6gpZo9msmVCw=;
 b=n95070g0FxX3rizFvREIqikHJHXhoBlTJqP6LaCwe8wTB2bikaqquTtOzuQSCinPFslj
 6GTzGMc3+z+5E/kd80Snr9U0MlUVUjDqs2RpED12/8icf9+LtJEPKETTk8Wdv1TGR6K0
 F00PIEedoMiIu2QR9waVd0qZU6w/vKwWnRj/fBKQ4z8bUcpl7/3/cpF20eXz22Vulitw
 Xw34CueOORcHj3Win8UhNTAy2BkCWhnR+qOsYkMSP9WdZeehlW+ibdmGz4e0ewH8dgrP
 GUrQKXXDluk7PtmnbpNQiHYzxoVvRijaXU+CutwOeqOJGtV9i2hJtVlG2tNYmXQztk1n 4Q== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3prp4ehdu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Apr 2023 11:15:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mL6NQ9bMdd70S+3Cr2juJ5rm5OKaLSptfjFq/I4nkuEgqoQHca8+45GfO7wI6urnroZmjcQ50Fc3x3ZeKn7eLBfgvMys1rMdEWiEnvsr57VpWmVOl1cd4qxXt+gpqREChCZOA4F2s5zOSMnx7IyOKvaeV1ojlTNIUV/4zs7tBaDDehJ8qWgdWDFaX1aPXbIUhGwbaJe2I9E13EEpvLYnvl4HSBxySIkyMM23osqLIoPApV7ObC5D5nMw12y14yxjZoRSQQyAasZrlwUdStE+FJYRYNdyd1d151YbSzhKl16qS6ocHpiv54g35vDsziACrKlcQSFPXvRRhXGXdzROgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxF05928wX+ZGHddHC7wb7Bugyun62/6gpZo9msmVCw=;
 b=mWNyG6qt+STtkMi929hYL5Uyssf+NW3EXsCvZncEENvnGIxV+eyJEaWXC1axTlYvztsEmdzAdFuXZwvvqnHZnhjpjmSaCD9WsgR+UossZLLwxujXF6cLSoJUnpTeJoYMu+/AVOCGktQvDSgqfDq91abM+a6NJ8dPW+cVd2xLsfu+/at0LbLnJC4H7nafafv7uiP09rfwMvZTqRsKAeBYpqATbgiZnavGH2hulRgAByef7C9seeJyln+aIhIO3cTqujGkN5GVNq2cvjqXdPGoJKfNe/c/T0EvEYmBwpow1mxWbgDkZaOEeq5DXoF55CLoseqVPBuncs3Gj8TRM02dEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by DM4PR15MB5961.namprd15.prod.outlook.com (2603:10b6:8:181::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 18:15:42 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::c6b5:a2f8:ff78:286e%6]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 18:15:41 +0000
Message-ID: <41141706-2685-1b32-8624-c895a3b219ea@meta.com>
Date:   Tue, 4 Apr 2023 14:15:38 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [6.2 regression][bisected]discard storm on idle since
 v6.1-rc8-59-g63a7cb130718 discard=async
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Sergei Trofimovich <slyich@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Christopher Price <pricechrispy@gmail.com>,
        anand.jain@oracle.com, boris@bur.io, clm@fb.com, dsterba@suse.com,
        linux-btrfs@vger.kernel.org
References: <CAHmG9huwQcQXvy3HS0OP9bKFxwUa3aQj9MXZCr74emn0U+efqQ@mail.gmail.com>
 <CAEzrpqeOAiYCeHCuU2O8Hg5=xMwW_Suw1sXZtQ=f0f0WWHe9aw@mail.gmail.com>
 <ZBq+ktWm2gZR/sgq@infradead.org> <20230323222606.20d10de2@nz>
 <20d85dc4-b6c2-dac1-fdc6-94e44b43692a@leemhuis.info>
 <ZCxKc5ZzP3Np71IC@infradead.org>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <ZCxKc5ZzP3Np71IC@infradead.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BL0PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:208:2d::16) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|DM4PR15MB5961:EE_
X-MS-Office365-Filtering-Correlation-Id: 649a722d-02b7-4afb-2bce-08db3538998f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBtwhOD9SSArVUZYKis9bE+haVNQu7/PBCox/CF+PKb/6gncJ9DfdgVSA4kb0FcOosJU0mDCAo3syTBY5msgwm1wQahijUBvqPeVD0OxAsju9KQQUazlHRFMui0m9bh29vwBNyjZiEjB6apDLjeW5IRcC59jGUdEKWfUCQFFLgHAy4NvmF2XPf3pXt9fahA2Uc/SDFj1vzSh+5+8oHYXWTKJ/dL+iwsJ9sMyUZRKpCKsml75hx1kOdfK12QZNE+9AL30NxIPxd4rLYdqbZkQ3QnarHu7T9/fNwF0fwEL6biGgyg3eJTgatt9VajPUAGxz4rZXpgHmeLpgg8i4lS1F6S+pCK0zXO3P7uErBIc2y7XaN1brXqZtXxamTo8UL1+if3e7h28p1TS69WfmvSMwKJ97OD5WcU92ldqKQ89oENnXUHimZNDrRRF8o8df0WV7yp0uFeM+9tJQJstOYe9Uy8bAWzTuuqvQfo7sgRT65gGZKD495YXwbXb+p6JbfiYTro7+gAo5h6nCbDUZjajAz6ICNpDbRMPemLBIaqK0moECHP0ZpFYEDZGDcZfk5koK1OXNmKdKeRVL+JfXqbLQxxuJ19gN4RIvKx0D8O5GEg9t88atFJAxj7H61lTC8EOx99W/kvMoVtHOH4wRB266g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(451199021)(38100700002)(5660300002)(83380400001)(2616005)(31696002)(316002)(36756003)(54906003)(53546011)(6486002)(966005)(86362001)(6512007)(186003)(478600001)(6666004)(6506007)(110136005)(66556008)(66476007)(41300700001)(4326008)(8676002)(66946007)(8936002)(31686004)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJhVXI1WlQ0Rlc4TkZ0ZkEwdUo0dkV4bTFnUVVXS1h0Q2pwVTRwekY4aWt1?=
 =?utf-8?B?aE9md1FhR3p6V3ZWR2hGbzM2dmpMaDRXR3Y3S2w0QU1PVEdlb2JMcVJMMFAr?=
 =?utf-8?B?Zmg3WU4wK283WnlOcXNwVVE0V0daWmltdVdCMWg3RTd2S3phN1VNVmNyVmRU?=
 =?utf-8?B?OEJUR1pOTktWQ0NWMzNsK1ZHK3FUY2ltZVpBc1UwWTVaais4YVFsQ2xUdjZ0?=
 =?utf-8?B?a0Z1Vjd0QXkvcThOT2VEQW5tdkRZL2VoeS9FeTNyOHhna1Zzam1jMXNBeExa?=
 =?utf-8?B?dUJhQ0NuVlN0MUhWb1JNdnVwYXo3dENGRjRGV1pSV2hrdm84eU9iaGtaaWht?=
 =?utf-8?B?REhvdXFCYmJJSjdETVIwakF5U0FWU2pRWVFoREYzSGt5WU1aN3FkcmRKTzcw?=
 =?utf-8?B?aGFWcEhRTnU0OGR5NGY3cGxYdVpzb25FVDFaU3U5dmdmMDd4Ty9KaUJ2dXVH?=
 =?utf-8?B?VDNIL1JFdWtEWXhsQXZyM1BKTWVzUWFsUThtSCtGYXUyYlJIVmJEOGRlcVZS?=
 =?utf-8?B?N2hEcHRtbC81ZHQ4SjlMWnlDQnFTTDRwQUMwZUFxRnZWbVZBY2o5anppbTF0?=
 =?utf-8?B?Ny8yaUtDVEhQT1VLVFVYZVk1YXRHeUxvZnFpcW9odUpYUFlrVUFRSkVQUFhY?=
 =?utf-8?B?RG0ybUo5Um9PZkRPQ3FmUVFmTTE4ZnNySlR1UUtqYnl4VWdHbDlLV2RDazl1?=
 =?utf-8?B?WGxPSGVnTytvNTVjMFpDdmdVTGFCc0pUL2tPVjR1a25YcXdoQ2luK01NUnZj?=
 =?utf-8?B?b1hjT3VzdFQ1UlhYR0JIL3NHU05ZS2pkcmU0TCtycHlIRFdkczFuTUM1ZXUy?=
 =?utf-8?B?dm13OG02Q2I5Y1hzL0VLSUtZbTVGeVZ3a0tSYWRKR21pTVZNbkJRR1FrcjBC?=
 =?utf-8?B?eDNDcnFicUYraEYxMUxuUVlSdWFtOEx0bmhvaEJEcks4cWZrZ1NaZ3ZZUDVO?=
 =?utf-8?B?MTZadXd6SWJVMkVIcVA1NURVQmZiZ1hYMnE5YURIUUxnZ2l1V3JRcWYvM0JF?=
 =?utf-8?B?Q01ZcllML3E4RWpHTFVKVzBzbDRjUllvUzhTSWdMTXhkYzNXTmttbk1OZmJ3?=
 =?utf-8?B?dVkvaXJtc1E0ZTM0NHU2YWgxZDN2blBiRlpHZU9PSk5xNWFBcXE0U2t4QUh1?=
 =?utf-8?B?Z1dWVDdiblB3ZEpFdGxpdGYyQnc5UjFLTldYSlJHY0lwRXBrRmw2MS9LeXh5?=
 =?utf-8?B?aUtremRsSCtwQjVhN1lpaUt1ZGlpeHNKZHJBbm02azcvWm1CdFFaY01DSU8z?=
 =?utf-8?B?aUhRSjJ2bmV0K21IV24yTUswUW4yaUdxTk5zMEdhZFl1Zkt4UkV6TkVIOENM?=
 =?utf-8?B?WHI3NitsclhmeWU5VTFFbWx4L3RjUzJDRThOU0lTUUlUM2lIZmVaalVpOGxD?=
 =?utf-8?B?Z0FkZVBxTi83NGdMbTlMRXloTmNYUC9kTUxweEZ5cUlJaVBRV3B0QStNRG9F?=
 =?utf-8?B?Tzd5aE9xZzQrdE4xMzVZckkxczBMTjRFVEVUbGg2eXJjNXQwYzlrQ1BxQ2F2?=
 =?utf-8?B?VFNRTDd4RkRvSlFkVEM1VUdpZUpsaC9aa05sNlBKTDFBYlZ6NWp6K0J1TDd0?=
 =?utf-8?B?dmR6dkZxS01TeVRJa2puUFhoY0lHTUFJUVRVRGN1dGRNa21tSTZ2Qndhellr?=
 =?utf-8?B?d1BEamdMN293QWxSdERWZCtnUjJpa0hIdGVNY0M1SWgvL29temg5K2tQNEdJ?=
 =?utf-8?B?djFmdUdzTzc1M3FuT08rVndINDFLN3k0cXJrKzh2QnJTY0gyMHdqdWVDWXNL?=
 =?utf-8?B?L0F3V0FlUEMrcFFHeElzU0hLUS9ib3dYcEM2bHVEcmlmeXgyeVRMUXViTGF0?=
 =?utf-8?B?aHF1S3MvWERpUVZlR2pJR2wyTDRrU1d3RnRWVXB1SlpQRmF2emxGNm54R29r?=
 =?utf-8?B?ZFpjTnowV1pUOHAvSzA4SFl0eXhOQ2NCOW5oU1MrUjV4aTg4Z3NuMlYyU0hu?=
 =?utf-8?B?SXJMaHUzNFlaUjhZeDRhZWJNSWRMRTYxQyt1aVpQcGVZZkNsU0JibHkvOEFr?=
 =?utf-8?B?THF0NkU4UEIycXlQUklzNjVlamVWWkVqM3RoY2tNRTRnMmhZdzJ1M200d0wy?=
 =?utf-8?B?cC9WdDRvSkcwUzVxUGZQS0F5SU50ZEVXbHkzWE8xV1g3cHVabjZoUm9QNW55?=
 =?utf-8?B?WEUvOXlGT1dqK01aLzlxWFJ0eTRIL0ErdkhNZnIya1p0MExPaGtOaVVkc3hu?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 649a722d-02b7-4afb-2bce-08db3538998f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 18:15:41.5693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezp2WODe3wYQrv2UnJo0nPHwsu6Secf1a3hF84dd+wNtkNgWDd3VYwAe49iPLLU0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR15MB5961
X-Proofpoint-ORIG-GUID: _P_VujBTnBXCEvllTtNdiclB8d5oWM8j
X-Proofpoint-GUID: _P_VujBTnBXCEvllTtNdiclB8d5oWM8j
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_10,2023-04-04_05,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 4/4/23 12:04 PM, Christoph Hellwig wrote:
> On Tue, Apr 04, 2023 at 12:49:40PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>> And that jut NVMe, the still shipping SATA SSDs are another different
>>>> story.  Not helped by the fact that we don't even support ranged
>>>> discards for them in Linux.
>>
>> Thx for your comments Christoph. Quick question, just to be sure I
>> understand things properly:
>>
>> I assume on some of those problematic devices these discard storms will
>> lead to a performance regression?

I'm searching through the various threads, but I don't think I've seen
the discard storm quantified?

Boris sent me this:
https://lore.kernel.org/linux-btrfs/ZCxP%2Fll7YjPdb9Ou@infradead.org/T/#m65851e5b8b0caa5320d2b7e322805dd200686f01

Which seems to match the 10 discards per second setting?  We should be
doing more of a dribble than a storm, so I'd like to understand if this
is a separate bug that should be fixed.

> 
> Probably.
> 
>> I also heard people saying these discard storms might reduce the life
>> time of some devices - is that true?
> 
> Also very much possible.  There are various SSDs that treat a discard
> as a write zeroes and always return zeroes from all discarded blocks.
> If the discards are smaller than or not aligned to the internal erase
> (super)blocks, this will actually cause additional writes.
> 
>> If the answer to at least one of these is "yes" I'd say we it might be
>> best to revert 63a7cb130718 for now.
> 
> I don't think enabling it is a very a smart idea for most consumer
> devices.

It seems like a good time to talk through a variations of discard usage
in fb data centers.  We run a pretty wide variety of hardware from
consumer grade ssds to enterprise ssds, and we've run these on
ext4/btrfs/xfs.

(Christoph knows most of this already, so I'm only partially replying to
him here)

First, there was synchronous discard.  These were pretty dark times
because all three of our filesystems would build a batch of synchronous
discards and then wait for them during filesystem commit.  There were
long tail latencies across all of our workloads, and so workload owners
would turn off discard and declare victory over terrible latencies.

Of course this predictably ends up with GC on the drives leading to
terrible latencies because we weren't discarding anymore, and nightly
trims are the obvious answer.  Different workloads would gyrate through
the variations and the only consistent result was unhappiness.

Some places in the fleet still do this, and it can be a pretty simple
tradeoff between the IO impacts of full drive trims vs the latency
impact of built up GC vs over-provisioning.  It works for consistent
workloads, but honestly there aren't many of those.

Along the way both btrfs and xfs have grown variations of async discard.
 The XFS one (sorry if I'm out of date here), didn't include any kind of
rate limiting, so if you were bulk deleting a lot of data, XFS would
effectively queue up so many discards that it actually saturated the
device for a long time, starving reads and writes.  If your workload did
a constant stream of allocation and deletion, the async discards would
just saturate the drive forever.

The workloads that care about latencies on XFS ended up going back to
synchronous discards, and they do a slow-rm hack that nibbles away at
the ends of files with periodic fsyncs mixed in until the file is zero
length.  They love this and it makes me cry.

The btrfs async discard feature was meant to address both of these
cases.  The primary features:

- Get rid of the transaction commit latency
- Enable allocations to steal from discards, reducing discard IO
- Avoid saturating the devices with discards by metering them out

Christoph mentions that modern enterprise drives are much better at
discarding, and we see this in production too.  But, we still have
workloads that switched from XFS to Btrfs because the async discard
feature did a better job of reducing drive write-amp and latencies.

So, honestly from my POV the async discard is best suited to consumer
devices.  Our defaults are probably wrong because no matter what you
choose there's a drive out there that makes it look bad.  Also, laptops
probably don't want the slow dribble.

I know Boris has some ideas on how to make the defaults better, so I'll
let him chime in there.

-chris

