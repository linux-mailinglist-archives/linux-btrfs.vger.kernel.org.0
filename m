Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F3C50DF09
	for <lists+linux-btrfs@lfdr.de>; Mon, 25 Apr 2022 13:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239975AbiDYLoB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 25 Apr 2022 07:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238950AbiDYLoA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 25 Apr 2022 07:44:00 -0400
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE2E37A06
        for <linux-btrfs@vger.kernel.org>; Mon, 25 Apr 2022 04:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1650886853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/InSwxGl/1HUp0pSygZH9uFMOPFB0l82ddIbRFQK3y0=;
        b=TFv/O6dvCIdBxdx+Hy8BWU+timgfkc9U3TRGhWVbCXvtkbEdKdXL8GQmdLhDjhNZqVBrLm
        hNHqCQdYDaoX3DB7eHKIfUZ3jxpMpemCWzDTKVTrcvv0fGc/c5LRAjeFZLm2TrWAjSr1km
        CiHZH0esZCb4ohOQtzBIGkmSqZzYZ7Y=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2058.outbound.protection.outlook.com [104.47.2.58]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-9-XXrv1j4SOQCTLcTcX5IpKw-1; Mon, 25 Apr 2022 13:40:51 +0200
X-MC-Unique: XXrv1j4SOQCTLcTcX5IpKw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2DoQnNJYHlfO0rYWdARTx91we1QmXzlO7fyiB9iE2jiuCgsJ5EoR1hw/ZqNslxtLGzOL4kccoxBs71EjF1LYctSEqBQb1ZTXlLpjI/JG6Mg4nWafy5ER7y9CKr4RrnErXii0YmPh3hwqeHFB09oZUGRJJN5qaaujtRCwLB5lS4srdqns5r9M7RNLGuu6SRkq+GFwge+RFzq8sYUc9d2bLBGnX4indC2exrJ4qlEmKV2TnR5UqWzHA/EhrMJvdjt/U1euyZDAnaLEEuEijDFITkIoW3+XzuWds5T4u8QJs/iGNvdCp3ENkK4x5e8MibEwRScqQMk7DOtb/dl0FycjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/InSwxGl/1HUp0pSygZH9uFMOPFB0l82ddIbRFQK3y0=;
 b=N4BV+HxqxQYm2nW/nwyek5kNhh5hnHozl1Ti3/zTbuvKmQ5K9QglA3AlLvu033yluOMYe1Aqw2xoOKc7seh4DWB3ddSDfX4segUxr0mvxN3LS0cOTphNzj317VrKCXksrtJscpBo7JP8DjMGU041qZZmfVYkPHRNdPMvu+moUrdy4iLnuCXiz/0GuYuaxMzc2JYd2wf+gJJJjVnGtR3A3ZpYV8LgmWJYUYeO5d0zYWh1tkgcXaVyG4jWNwPzSsyhyDWtN7dZZsRPnqWzkfYf99ku0JjGijxGl4DGD4thCMmqZ6oZHRqnslSNyvPk+nkWt7a8JVfMxOufxVHoHF0Z2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AS4PR04MB9508.eurprd04.prod.outlook.com (2603:10a6:20b:4cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.18; Mon, 25 Apr
 2022 11:40:49 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::21fb:190b:867a:67d2]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::21fb:190b:867a:67d2%4]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 11:40:49 +0000
Message-ID: <9d6e5424-e872-7767-e1c7-6eb35d53250e@suse.com>
Date:   Mon, 25 Apr 2022 19:40:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 03/10] btrfs: split btrfs_submit_data_bio
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org
References: <20220425075418.2192130-1-hch@lst.de>
 <20220425075418.2192130-4-hch@lst.de>
 <62f71a43-8167-f29f-8e9f-d95bc6667e0e@gmx.com>
 <20220425091920.GC16446@lst.de>
 <458ba4e0-15f3-93e4-bc17-ae464bdf13e7@gmx.com>
 <20220425110928.GA24430@lst.de>
 <bade7fa8-d95b-e0e8-0af8-e40fec341789@gmx.com>
 <20220425111925.GA25233@lst.de>
 <af44fee8-deb9-a3e2-a04f-06dbcc16b6c0@gmx.com>
 <20220425113458.GA26412@lst.de>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <20220425113458.GA26412@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:510:174::21) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12af6e06-513e-4042-7d57-08da26b071d1
X-MS-TrafficTypeDiagnostic: AS4PR04MB9508:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AS4PR04MB9508DBBC1CC45903059896ABD6F89@AS4PR04MB9508.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vKDBe5+fotjYw7r6aAyZ3rUmZz3arNgazZ91gStNAYNMGa1oEF342nUmJbEJYWEfof6JXCW7UapurVToewmWQ5P+yLy3RcoHDj4213S9knyVm9ZaKxsqp5vvWK5kKgqfQn3S5cnmrY3Zgml3sfPbluuQq1RItclFIEkFhj9dE+0bsa4tnpLbNROEPlP0VBpqkCcXwvMrGwJnf5WV0VLK4THxg8/HUHqP+C63WzgpILhzI6MFGNzMboHqWaz9agHP+GAwG7zTj75GD2rTKfjFe1DJLOsVxEf+NR8v3TEkjKYbfH6Y+j98yfXyTj80lFrKU96TMAawkB0PhseawObsvJDnjvV8JRHvi6+jlMsIV44jd3UDIgARE0/sVwgqZDYOU/wAWRm+rsd5GNELhu+XJnSucf0iIPMv+8QvAFdNGmJ43LPWwxFWTkCq3sbUHbllkBP1gKD1eZpgvJmlNjrf9/JlAbemdp4nMohVYs5MVsivkkIkE7qUby8xpsvp+XxFNCBBqIMT41Hn64ICSQh8VRNp6lHtqJvzu8s70fXgVQdmsNJzv9DI7Od0dHTc4TC6kW4Oz6N45aubDp7ZLEHJeSdJ4PHdA2G+75Bj2HguZcLFHtgjUSXWJ3DpUBVu5UOtwWb74Ifnw8iJSUKsJIGICaSgYcS0jZd89xmSByCs2vNw4qMLDd3QzBxEZV51NDaqozlZSgy+DnJpk5NoumdXp4ZBC2DUlHMC3nfoAFs61Tk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(5660300002)(2616005)(508600001)(316002)(8936002)(83380400001)(66476007)(8676002)(4326008)(66946007)(110136005)(66556008)(31696002)(6512007)(38100700002)(54906003)(26005)(6506007)(2906002)(53546011)(36756003)(86362001)(186003)(6666004)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWxkRkN5b1VQblNFZ0xaVkVrNE42enJ3ZG1RMHQzVkF0QkMrK0JsU3FsL3N5?=
 =?utf-8?B?MDRRYWUvNGNEQWtIeHFYcmdLaWRUQlUzejY5dE9JRC81STk4enRQaWtlNjdx?=
 =?utf-8?B?blpVUDU4S3JEWDBIVHAxZ1FFOTJJVDBjQkUxOWpyUjMvbWhKeWErMHNpNkwy?=
 =?utf-8?B?MFdFV0lycXZnRXRXYy9JV0haR2V1Qm0yU2YwM2JDSllBTituN2I1WHNMeXpr?=
 =?utf-8?B?a0VaWkFDUFdrZG1Rdk9qUWNBMTIzN2RFek1Na2tDVTNSeDhvODdLVm9KSnlC?=
 =?utf-8?B?cUMxQlpsVGtRUGt2UW1GTG9NMXl0dm1xMVRFMUtLcnFXNG5US0tHbWVkUTF2?=
 =?utf-8?B?NkNtWVE4N1ZYMXZuRXg3bmc1SFRaSG9rTTl3Z1pmaWp4YUxOTUszYUZDQWd1?=
 =?utf-8?B?SThkTzIwMmpkYUdvOTVOcDB6YUhkYU5LeFVhMmEzTFVldTQ5UkVyUFRJcUF3?=
 =?utf-8?B?SE12dXFnTFpMNUJoSXdFaG5qNXd2OVJkSjNIc1h1NVJyVExJdlc0RjdLRm5t?=
 =?utf-8?B?VW9UNFZnVFI2WElwT2FtRnZTY3VXNTNEZlZtK3ZsVVFUNkl1enJVRkkyK3hq?=
 =?utf-8?B?L2NDWHFueHZLbW5wbUU3SzJNZ2lybUpsWFd5RkNubS9ITHJ1TmxCaHgvbmpB?=
 =?utf-8?B?T1g4SHNLRitLZm1pME85TE1vVWNjTGs1MlVhakpmNUd5dk5jVlc0SS9xaDV4?=
 =?utf-8?B?ZEtzL1hJaXhCNGx0YVhWLzZmYU9jdFlXeHNwSkNwUkFZWGJlM2hiS1pDRXBj?=
 =?utf-8?B?MVc2OWMwYWVxSGRlTjlicFVPR1dIaCt4OHEzUDlhSkpsUzV1c003Y1NORXl5?=
 =?utf-8?B?Mis1enhmT1FMR0o3b0FDS1RXbVRqek5EUTZlYll3OWRxcjZ4d3B6WU1ia3NH?=
 =?utf-8?B?TVFab1VqbnJpc1VUZ0oyMzFtQ0VXKzUrc2U2dVdScUhTa0Q1UGpIZ1Npa2NP?=
 =?utf-8?B?TkRGZ1MvcSs4eWJ5bzgraXlUWUhaVm5uVTN2UHR3b3c3bm0wYncxZXNkZHNT?=
 =?utf-8?B?eGlySDhyRm1IQ3B6aVdaNGx5QVIzcXJ4MGJXamp4dEVtZ01FaGs3U0crN3Qx?=
 =?utf-8?B?VjlPVmE0RnhlbjArd1RzNk1Ucnp4dGZoWTE5S01ESVRVMmE3RzJSLzFaZHY4?=
 =?utf-8?B?WDl1cjFzdzN5bmdzMHVPNXNtSHR5QTlTeVc2eHlNOFJWUFpKY0VFL1lDVmtE?=
 =?utf-8?B?LzRzaHl0QkgwV0k3L2lraWpXUlRHcU91b3JkdGw4cjMwSmxKQ2tSdk8yb0N1?=
 =?utf-8?B?MWVHTHI2UlR6dHJZYW9nTFdZaCsrajIxdGJnNExmeDRTaWhJbXhnTnJyMXFX?=
 =?utf-8?B?TjhvTWdLS2hmWTJzUVdZeW1jSjJuVU1OT0NrZTFib2JNTjhVWVdObHF4dUsr?=
 =?utf-8?B?R1N0MC9KcGtUdm9WSEVkbE9QM3Nuc3l3TFB0cHV5R2Zaa3N4S2h3cDVPSzRJ?=
 =?utf-8?B?RnNBeEpUNTc1SjZRcS93MUtNMURralJqc2NEYnUyYWdCYjltb1lWT1JQNklS?=
 =?utf-8?B?U3VCci9lOVU5WWxjYUlEcXIzTkJDQTZYeGpmMTZwc0tpa1hxMDJJV2hIazE4?=
 =?utf-8?B?VGs4MlM4QXRnSGtSZHEwNTE5VFFsRjZpcDBuR1lWWm16dE1DK0oxM0JHb1Zo?=
 =?utf-8?B?ZXozRHhUWHRmOVBQM0pjSFN1Q0kyWE9GdTVZM1ZDNFNmcnUzSjlqOTBvcFJL?=
 =?utf-8?B?WXdNLzFNTzc5dVBFSm5zcXQvRG5qbTRVQU81UHZUZ1EvZkxsd3l3MXFsYkZV?=
 =?utf-8?B?YjkvUkk0RHFjRURndk5ZV1gxNisyR0VURFFQS2pPajI0V0xzNGl4VVMrcS8w?=
 =?utf-8?B?QzJGa2V5eHlzUWNNMHh6WFlkVVhKN3N2SzZHMHBhZVFOc0o2OE5sRUk5cndT?=
 =?utf-8?B?VXFvemc0alhURi9tQmQvSHp3bTVBdkNCQW1UUlhKMDRtUlcrei92L0ErZHJN?=
 =?utf-8?B?TFk5YW1zQkkyenk3b250TWpEUjJ0ZVFtbUxXSW00cWdVaVFVREhqY0dkc2FR?=
 =?utf-8?B?WENZWStnbHlQUDdkR0tZNUVWd3BpY3JPRXBtVU1zaUtJOE9CT0xhNTVHR1E0?=
 =?utf-8?B?TzZSRzlSS1FkRUhJSlVnVXJ4eW4yeXVGc0lpSVNxci9QelpvdzF1cS9CMU9w?=
 =?utf-8?B?bUNrSm1sVVFpb0dWaTIwWjJPYmt2UnZzUGdTYmxrUTYwT0p1ejQ0QjMya1lN?=
 =?utf-8?B?UldualN0a1ozOGc0YmZoTGh0dXFRYUY4WTgzN25xTzdzc2pMdk5WZXdqNW1I?=
 =?utf-8?B?QVRmRTJWdXpzMHdBUllOSzRYRVcxMEM0bk5SbGlQUS9ZY1FaYnhGMHhqN3Fj?=
 =?utf-8?Q?xcnLfJlefazha8VL+P?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12af6e06-513e-4042-7d57-08da26b071d1
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:40:49.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 391G+dNxEGq9pc7d7B61MMFHoLFf2eoDYLcj+vfgr2stBaCmPdcCRI+y4ulIe4CV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9508
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/4/25 19:34, Christoph Hellwig wrote:
> On Mon, Apr 25, 2022 at 07:31:08PM +0800, Qu Wenruo wrote:
>> Then it comes against the btrfs read time repair.
>>
>> Currently we split bio to make sure we never need to split bio at
>> btrfs_map_bio() time.
>>
>> But this is against common layer separation.
>>
>> And we really want the ability to read a partially corrupted bio (some
>> part matches csum, some doesn't), no matter if the bio is cloned or not.
>>
>> Especially, we already have cloned bio which needs repair (for dio).
> 
> I have a barely working version based on your patches to split the
> bio in btrfs_bio_map that solves this problem.  But the next step
> only removed the save iter for writes, where the only user is
> index_one_bio.  And the fix for that is pretty trivial :)

That's only for RAID56, aren't you going to remove btrfs_bio usage 
completely for all write (including buffered, non-compressing write)?

Thanks,
Qu
> 
> ---
>  From c8fe61748ebc583a7f57c8e5de79f92428e5717c Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 25 Apr 2022 13:23:54 +0200
> Subject: btrfs: stop looking at btrfs_bio->iter in index_one_bio
> 
> All the bios that index_one_bio operates on are the bios submitted by the
> upper layer.  These are never resubmitted to an actual device by the
> raid56 code, and thus the iter never changes from the initial state.
> Thus we can always just use bi_iter directly as it will be the same as
> the saved copy.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   fs/btrfs/raid56.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
> index 1a3c1a9b10d0b..8b40353bb89db 100644
> --- a/fs/btrfs/raid56.c
> +++ b/fs/btrfs/raid56.c
> @@ -1218,9 +1218,6 @@ static void index_one_bio(struct btrfs_raid_bio *rbio, struct bio *bio)
>   	u32 offset = (bio->bi_iter.bi_sector << SECTOR_SHIFT) -
>   		     rbio->bioc->raid_map[0];
>   
> -	if (bio_flagged(bio, BIO_CLONED))
> -		bio->bi_iter = btrfs_bio(bio)->iter;
> -
>   	bio_for_each_segment(bvec, bio, iter) {
>   		u32 bvec_offset;
>   

