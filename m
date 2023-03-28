Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F636CB2F3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 03:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjC1BCN (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 21:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjC1BCM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 21:02:12 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ED0199A
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 18:02:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yqv9E1wNsMLFhvQ0YdFoNXrQEm+cNskOfCqfXR4CII9I/K5Du5FG0klaXH588Xbs/QWfhuWjqonDb5K7YQM7KCSiURqXrb2+n2+3+pggG1UhhbIDHRyIgQ2fHlUmKb0aBPGovuPD7jOItA9s1IgjpkB0bj/+2t87oqMv9MK2LqSUKMIB8rWzNYoZJ0WBCI6NWw+PpmZITEJGFLEJlZzQwF0NRLcctY6IRn8VvyYvjzN7lP+MMook7o1tULtS8L9bbzd6xAaMqRy1/4aHsLYxrgZUKRr8fLDxUZewiCRWhZJvIqdlsLxHAmTZDx3erNGrjmr/08ecKjUiJmdAm31ZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hk59gtnOt1f3d9d7n/zlY9knA9rt+EtfUJCPn4f0a10=;
 b=XyuvKUsLhXTvPy56yUBgmbO4w71Ebl9MEhVnDjaHmvQA2GSlQ7AjzaZleN3y3KxyN3+mSsd5OSqfU6j5zEM5ZTy45QiC01YSF5def5Jy9y2ffwvsbicUk25umwodzARCj4xZ+NG1Bq6fgnYQxum0Lx9af6Wzq2EUHn2NIZEl+IvTUZSLyi2DpD3lBIhSuwil20kdLRgQPnUc9DWi5aK7XBT+iQbv6jXber1MmNmSDu4H5JEGFKUFELp2F+NHt/eUl5ji8o28s6TqQKwevUclevvw6gbDPeAgRpUwc+ZaHpe1DzGGBLJIsMKexk+EyIfoyZ0icgLyTQJSf9ebD5SiFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hk59gtnOt1f3d9d7n/zlY9knA9rt+EtfUJCPn4f0a10=;
 b=zgnpVhUn/X7HqDOQCAnxtP/5YJe0PefKcLF8U8y9hZ5wfSWQhzXoyw/j+4XXyGiy8um81OBeW0aflc8LdA+l1kU4ARFPyXAUqNRoFVI9AXsj3C7b7kFnqIlIPnU9/VwfZ27kRbwwOd+9NJgvr7clXfq8aDJBTOn7AvsAWf0AUJVKwQW4XcY9hzoCMHY8SdHo03V09VmTuA1kTCUzAZn28SRuUg/MSNseaWWolvpaOdAlW5NIcZ21rsE6WLqCaCVji85F6xM/jLIs6mZYaFW7VR9D3VXZWhqVkvjrPg4/sH4fWFF0unJZ2u8RxnNodimo0hqTSNj+T+EYtKZVKpYghA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PAXPR04MB8373.eurprd04.prod.outlook.com (2603:10a6:102:1bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 01:02:06 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::8aa:9e7e:52da:c652]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::8aa:9e7e:52da:c652%8]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 01:02:06 +0000
Message-ID: <7aa553ab-b019-b5c6-235a-4c17a9cf3b4c@suse.com>
Date:   Tue, 28 Mar 2023 09:01:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1679959770.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1679959770.git.wqu@suse.com>
 <ZCIoQLysbLrQW0pX@infradead.org>
 <cd8a91ee-2e30-9829-b50d-599fab3fb490@suse.com>
 <ZCI0DXvc+h7DoZvB@infradead.org>
 <7ec722e8-d685-004c-6c24-6bdac7982e0b@gmx.com>
 <ZCI6hOjU+yrQ9SCE@infradead.org>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v5 03/13] btrfs: introduce a new helper to submit read bio
 for scrub
In-Reply-To: <ZCI6hOjU+yrQ9SCE@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::38) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PAXPR04MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 14bd9d2a-2af8-49f7-6503-08db2f280c9a
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zlf+OrafQUr+50hjUUHQIA+lRgNspsdPPvfQdD4YETv7p7DXjMR3z+t2S03Yn5hMgPMXToDcPPf503BrcFNI9fVwhPhujE1YFjF2ji+wSS3S+UDqHoVkgN8fxXTjrdSv5+BywF4v3F5D7J3D4ioB5nFpL0SUBVJcUlZHJEi9Njr12Vg0eU99WBTtUqln/9QqQnzsMpBDEO/ju2RG4145ICxYR/k/EJ/20jVSivL6mlb18jCCFxyeJYq2c2EVVrTWnKAc+DnhPKiM1f4T+9utwSpTVJFl5NCzf3fOuIvb+BIYQVBXaATWRE/QMVwjce3y6Qmev/MMiav2r3ujovFQS6CifjzRilJwifGwJnJeuxhJrnEJzCBC6DtM7EZhXJmidJ49pkCog6lbH+U40o87CXxaoejgoyLXMM1wtlPRwRH0YahWwyb/pYWOA0ZPqILFz/5/gHtxYqJvQfW7mVFuPoKzxqyL8pQzSoBZA/ozARrgNijjMntJBaDOBCXa2CNrbiI/yno4sLb6jt1S31zRf1rFhlIGcWCZxNPMHXiRCFpp5Xz2TPjArsXrVD/6Y6jIjDXIbjmXeokSsOZ1VMaU/WfuyZmSesbeCxUa0TbWapAj49k0pW+H6YRCJmuHc6jV7qIfpo7vQuElbNeykVq95g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(36756003)(31696002)(86362001)(478600001)(316002)(110136005)(6486002)(66476007)(66946007)(66556008)(8676002)(41300700001)(53546011)(6506007)(6512007)(83380400001)(2616005)(186003)(31686004)(4326008)(6666004)(107886003)(2906002)(8936002)(5660300002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpxUldPOThxK3U2RWV1UzhoTWtleEl2ZmpVUTFVSzJOZm4zcXhwTTJHcklN?=
 =?utf-8?B?NVJWOThGNyt3QmdPVjVZSjJQTzdTZSsxNUI2ai9GWThIZzloRUMwNkI2R0VT?=
 =?utf-8?B?RFQ0cnp1SGZJaU9rK0JiWWRaRFVXU2RvM3ZCeUtNM2JISzZrdVovb0cxc3Ju?=
 =?utf-8?B?K0I4SzllbXlHV3RWQndnS2ZKdllSaHRGNExvSHpSWTc5UC9SR3ZLZjNOTHE5?=
 =?utf-8?B?dENIL0Zua1IrWnMzYjVHY0hmcElRTlU1UHdHTzJkWjduekU5eldWendNekVN?=
 =?utf-8?B?UXdGVWRGanlPOWpKd1FLa0YwSk04bDRmaXk0aksxZ1MwSU9LZ0xKbUZPRGJV?=
 =?utf-8?B?T25hemVUVGJlK2pQZCtPM0ZvRmdTa2sxSFBxR1FzSzlqTUhrVmtmb1BMK1Ey?=
 =?utf-8?B?b21NVVBvUWJNSXhIVXRuV2NqR0NQRkxVbGtWcm85UERLTWNiRFl6VHZvU21x?=
 =?utf-8?B?S2NSTTBFM0oxd3NEODM2eXdvRHNTc3d6NHl3RDNvYm5BQkppekVySEZPUExM?=
 =?utf-8?B?YWxTV1R2NGRvTHlrSk9yRnJVbFdQRjlDekNEQVErVlZSb2lpcFd1YVVUands?=
 =?utf-8?B?L0c5bTYzUnFVeTc1WENkeUpQaUZmV2tnZk5HSER1ME5ZQkhEa255TVhvNXp3?=
 =?utf-8?B?V2VPUjk1MGx6ZnZaYlhha0xucHBzMlR3RWdMeDljTEJIM3dPU1lXK3hYOWhq?=
 =?utf-8?B?dkhmS3NtSDRMUG9PSFZsNDVCK1FUdTFXS0VqVElaNmZWSnVOYUp0ZCtEU0hL?=
 =?utf-8?B?RGl0b1VMQ0V4NmNndE1BRzhoalNpZ2VFcVVtV3V3QkpRMWR1VUloZUZERmZE?=
 =?utf-8?B?SGpCbUg4Um5TNkJoMlpxM29uUEVZT01KLzgweWlDRFIya3BvSjQ1S2hnR3pP?=
 =?utf-8?B?NlBmeHIyZHR1QVRFRlhwaXN6dUlvMzhmcGt6dUVHZmFwaEJ3UlBlM0w1Q21D?=
 =?utf-8?B?OC9uekdRcVQyRzhFV2g3RXE4S2FvaEllUHJYdktWVHhPdWdEL3hPWkdPcUpS?=
 =?utf-8?B?eFZSd1d0N1ZBd3pTVUl1VlJPT21mVUdQclRvcXJNRVJYWVpJa1p5czBUMjFo?=
 =?utf-8?B?R0wvMlNWdk5BbGZwNE5SMEh4cUEyT3lYUlQ2U1JzRWdYNE9LYjh0VjYxb2sy?=
 =?utf-8?B?OFhSZ2U0TFBSOFQ1RHdSeExYdk9HT2lzTXlRbTh5Sk5vMFlvZ2dUbm1tZ3E5?=
 =?utf-8?B?QVR4UVhBWE00SnZGNXFpVGVSS2pjSEExQzBockdEeUxxbU14YktYOFBQaW5n?=
 =?utf-8?B?Z1BnVElKUTMyN0cxQjJIV2o4Y3BjUWxNVnYzRUJiTVpHWlBNOG9XVUJpWm0w?=
 =?utf-8?B?ZWZrKzdjejVESFE0UytTd0ZyWFFrRXJqYlhnMlVNVDRpeEgzNnBtdTBWV0R5?=
 =?utf-8?B?WjFwNk1lVVhvRHlZU2pFN0JkakVqNmdENUJhL3RweEtFN2NpMFpoOXV1RWtJ?=
 =?utf-8?B?MHovUDNlRjJQcUt3OVpvSVh1Q3hXbFRiRXlqZ042cUkwMml5cnVxTXYrR0wz?=
 =?utf-8?B?OEh6YWJIaXlhUkY2MlVxNktISytZc1lhZ3hDSGYyRVdTSCtxN3Bpd1g0NmJz?=
 =?utf-8?B?ZEUrUGMvdVQ4d2FwRXNrc1lKOVlrZVZrREpzZU16dnhGVmcxWUJ0YUhjVEg5?=
 =?utf-8?B?UlEzU2lublNpQVRqbDZ6N2JDdmtlcFBuQ3pXR3JkMWJqSDhIUXhwWTdvOU8v?=
 =?utf-8?B?ZytmQlhRTEN2S3BJSG81VG0yR0JraVhicGM0and5NjBaQlBkNnJqUEk2MzJ3?=
 =?utf-8?B?MnlIa0xMV3VyVWF6ZjJtc0hXcjltcVE1SVEwbGFkbGQ4OVR5UjN6NXFyS1BL?=
 =?utf-8?B?S3RpWlhVdFZadGlFMlJNN1JTWXhoRkhiM2tpZC8vM1JVRWFySVFUV2Y3eFZv?=
 =?utf-8?B?RmRCWDE2MFY0a1dSYWF0VVJqTFBEODkxc0dUZFlWL3BCaVAwbkExbm81N3RZ?=
 =?utf-8?B?QytFSnRMRHJWVzh3QzlsdHUyQWxqRHplWW1vRWtlOFJSZjdwamlnM1M0QVNT?=
 =?utf-8?B?aWdpUisvNG8zNUsxb1QvRTJYdXk0UjdLKzRoZUw5dndHLzNEaWtZbGs2cjl3?=
 =?utf-8?B?RVJVbDU1Nk9pYmlyTTBKUGNHbDhXQzkwV1VvWEd0T3JXSzFUeUdwNlhDZ1VM?=
 =?utf-8?B?WnNaV0ZodHlrY0dkYVhaZkk0THlia1JMMnNrNXZiNWZEMzhvZ2ZnZVN0aFBn?=
 =?utf-8?Q?tnMbpdoBdS1sI88niqemRGw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14bd9d2a-2af8-49f7-6503-08db2f280c9a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 01:02:06.1126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrRzYtHGhARsTSdMht/j4bmg7ffWACqIIxac/kGU4tK2DIIi4lKOVy2hAawByec0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8373
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/28 08:53, Christoph Hellwig wrote:
> On Tue, Mar 28, 2023 at 08:48:29AM +0800, Qu Wenruo wrote:
>> The new behavior itself reduces IOPS, thus it should be an overall win.
>> And for regular devices or non-RST zoned devices, we just read out some
>> garbage, and scrub verification code would skip them.
>>
>> But for RST cases, there would be no mapping for the garbage range, thus we
>> need to skip those garbage for RST cases.
>>
>> The dedicated read helper would provide the location for us to handle this
>> RST scrub specific case.
> 
> Well, if did just call btrfs_submit_chunk, the RST lookup would ensure
> you only get the length of the RST mapping, and you get the behavior
> you want without duplication.  We'd need to make it non-static (and
> document it), but I'd still be much happier about that than yet another
> I/O submission interface.

But in that case, wouldn't we just error out?

As if RST can not find the mapping, it can error out.

The behavior of handling missing RST mapping is different between the 
regular read path and scrub read path.

For regular path, if we're reading some range without an RST map, we 
should error out.

While for scrub path, we should skip (or if you want, we can also read 
some garbage) the unmapped range.
And for non-RST cases, we should not hit stripe boundary (although this 
is just a debugging check).

> 
>>
>> The core shares the same idea, only the support code is different.
>>
>> I'm fine merging the core logic, although I believe we still need different
>> entrance functions.
>> (e.g repair is only done for one sector, requires inode/file offset, and is
>> done synchronously.)
> 
> Well, the inode number and start is only used for a debug printk,
> so we can easily move that into the caller.  As for the single sectors
> vs not, what we really should do is to move the bio allocation
> to the caller, which means the caller cna decided how large the bio
> is.  Together with moving the printk that also makes the interface
> much simpler as we'll need a lot less arguments.

Yep, I'm totally fine with a helper to do the core single-dev mapping 
helper.
Just pass logical + mirror as parameters to the helper, and returns a 
smap or dev + physical, and let the caller do the submission.

Thanks,
Qu
