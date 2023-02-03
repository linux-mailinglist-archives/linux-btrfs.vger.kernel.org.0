Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53450688FD4
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Feb 2023 07:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjBCGqy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Feb 2023 01:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjBCGq0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Feb 2023 01:46:26 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on0602.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::602])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D6D92EF7
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Feb 2023 22:44:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoLJsO5C+YgSpYzJTAhR0hfgl0kDV8JPB9xLbq1OFF6r9Krfw7Cec6T/1+mU3vSAi8FC9/PMEM3NKD+RYli0YxVLJeilJagTSqEuGhKuU6BI/RFLfHK3ZNiLq36HkxfNdSHqo/kZVLKGqJhRK9NaRyAomhrWmNQsWFrvLw2yPYSHsrmlE3AC07nx3LAFmpnKVWEWp3x/h0wc8VJ8Bn4f9hoJIj31V/CjOjltwlsbtDTPN7qPnUFRu1HCQ+YiRDVu1G0zj8BNWSee5GL8jpCK/z/HjMEdCvpDfnjCJIPI0Y5xpq/0iLWf1y15oCq43ioUYzBRrfJh0zQTHo+pzkpe5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rnePwCDItWVQ9s6nf/J4NuDCck1FlnfQbge31DXXvF0=;
 b=HoFkha3XqfaH18GK/aUSOk5u79XFlat4np7dTTvpQ9ZGDNOVSrwxsNdMGcbyCl9q8yDvjpho8utPkzz39QbXk6D3Wh33byvmUgiYmUAd8Iv4QH7GmSYVL1zWxUbenTx2whUAXwDS/8pNio7NKjPCfq1Rd2pq8Mv62Ssj4z5L05u1VOSYCR8PLnIxxcixUQb6q/S/gMWy49Uh5cXDeZqnqHx37G9iYjp8Ri3P+LxjLcWpePZ68EIyrVC9mc29cIgeKjZcuArwgdKK4KUWhyC3D2/HdAt5njo3ejVXfyacpWvpytU5+7VLljiC25O9u7goTsF5BcAOggHlqOSUN3fRTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rnePwCDItWVQ9s6nf/J4NuDCck1FlnfQbge31DXXvF0=;
 b=ZYbyo/zQYGL1keCfdIfBeCF1SLv0gy0OFJ72GZ6Vj9avE9mRCT/p6t1Vhnpcj/Su4sUndEXPvMTn8piUoYWdfTgYVsWlmMptnWYGu2kZepf3woJliWRK0aw2RCNc5II6kuQsg+DiiPygVkk6LmoXFsWwSTm7y2I1+qw06ucyxgfmZNymDzVITrjFqxGtP6E6jKQXcO39jEiwaaMb2zHl99zCWXnCAGjDJJ9tIaiM58RCVKz7A2dxUlxp9uRJ34f+DZmEJUZ+X/RAVdqdAD7sMjq+AGcy3DlsKjwxy1yY6fAP3aPIq+hpLkBOfb7hn6+OPNmyGD3lU5bFbVtI+e5LUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB7117.eurprd04.prod.outlook.com (2603:10a6:800:12f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 06:44:26 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::5c50:6906:e9a4:5b9f%9]) with mapi id 15.20.6064.028; Fri, 3 Feb 2023
 06:44:26 +0000
Message-ID: <a8891be4-a39c-8e77-2954-26c66e0d95d8@suse.com>
Date:   Fri, 3 Feb 2023 14:44:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 2/3] btrfs: small improvement for btrfs_io_context
 structure
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
References: <cover.1674893735.git.wqu@suse.com>
 <a02fc8daecc6973fc928501c4bc2554062ff43e7.1674893735.git.wqu@suse.com>
 <5195283e-7e3d-6de1-75f4-d7f635bfc0ab@oracle.com>
 <61d2d841-778b-ca13-cc41-ca115b5ed287@suse.com>
 <Y9yneQhuePjT/92P@infradead.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <Y9yneQhuePjT/92P@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0007.namprd08.prod.outlook.com
 (2603:10b6:a03:100::20) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|VI1PR04MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a662445-c0d9-4f98-7d02-08db05b2177a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gYdbTu/q3+u429MuxjBxDkjHDAJOkg5IhMhiFLTpFFrg67DRPzCHUAauvxs7cNMuX7yYCyUpokrZDSNCsxn/HSE3FTAnDHEnW/5lfwYLEDLNxbv9U6JBOYw5owfl3EAiP2X11GDbL/HEGBEQMlxajiO4qOOCyblthjbDcuy3prA/tm2EXLWBnfuJSM94kEDJBV0YC3r1Alkp2HawlwCQ9Tl0GqGhvTo7xXhWp4bCa6zqM7UjWqhA4KYvNtOL6Zx0/zoV1S0amah1YRzClL+cdQP6CZPB0vcNflquf8Ry8vL1FXMFQnqoDpxYyh0rTC/44WB5XUSdxRfxkbQquoH/T3almbm4wGZvmTfGvLQeDLKwTlL2TIhZU6c+XSS3fe81r+x19j1STw1F7p1Q4ereUWyW6tL6RPDrkcjz1krXYH5jaEyxUw1llogFyWhMoFrJ9sTi8CdMM4LO/zNPNml3SgFo8/fdjiMrVvuCtnT2twKGX5ipyOjZKqnv7gHSt7G4rpNW2kDbp9wVKK089e6WvPwbz+EdgA4tUqg1ILCzQCunoLYj4oirJL1mxXEBA9owYshXDysB1Ke1gVBOAJ8nveSpFuw2Faz7nrjQ/KpMffD391hzrgZBxf+sqWZrIU8FtgL10SCw7hbYf0rMHHM4ihLtrT0tj+GAL0MUHG8nDaw2ntamE/UYP4S857yQycvc+w4lqj+yHrNWbXzsUKs4vrvV5F6VQ1/2J+MzsYB5JIY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39850400004)(346002)(136003)(366004)(376002)(396003)(451199018)(2616005)(31686004)(6512007)(186003)(6666004)(6506007)(4326008)(53546011)(5660300002)(83380400001)(8936002)(6486002)(478600001)(41300700001)(2906002)(38100700002)(316002)(86362001)(66556008)(8676002)(6916009)(36756003)(66946007)(66476007)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SytlNU5hamdDYUtmZXd3ZUt5NzB1aU84eHM4RE9VaXlmeWtERmdXeFRxb0tP?=
 =?utf-8?B?YnVxZ2pxbElacEljb21UbWswSko5Zlo4TlF4R3lIMWQyR0d2cjFHamZKa0ha?=
 =?utf-8?B?L1VDUnpiZ1BUV0orblp1Wk9ySXpOdStoVUNkSWpidDZxakpSdHdDUFBKL1BS?=
 =?utf-8?B?ZU1SS1lvbFBWeTJ6UHpZalhhSjRwa281ckt3cWZBUSs0cWNMeUxvVVhZL3Fp?=
 =?utf-8?B?MjFoeWhiOHMvWGc2WEpET0xMejc1TndrSDhjMEVablVFQ2UrdVNNRW41L2Q4?=
 =?utf-8?B?YThjMFNpM0FmYXBudkc2N3hXVXBub0E2VitZWXNTUWdiUGRMdGJVdmw0YjNL?=
 =?utf-8?B?RFEwbERjWWp4Yk9NUFVic0hRQkh5citiN0wwcEhBZlpkTk9VSG12TVhkdWov?=
 =?utf-8?B?eDhVeHNLQkRoWmoxcmFWQzV3dStnRlhBTC9aMVRCZzJUMWFTR0ZOSFRvOHFn?=
 =?utf-8?B?dkU4bGIxdFVrZlh3SFgrTGhwMDVqVTBJQzg5cjBVd0RIRlkyc1lVY2N6NEtN?=
 =?utf-8?B?TGhjWThKMzFwMmtwQnVlRG1NcE5Ta3UybkN1dTMzOEo5NDVmN1o4Uld0QUtX?=
 =?utf-8?B?REtWazhVTGRQS2w5eHEvR3U5ZFByZkVVang1VHVPSjlFTzBaUG5INzhTUU0r?=
 =?utf-8?B?NDlXdkN4cUNqNHY2ODF5bkIvbThUcGpOTkE4M3krNzArV2E3SnpXRDUxbExz?=
 =?utf-8?B?R3R3RmFzL3ZpbytkcUJWSlpOckpZUXVnSDU3Y2xTdE9kYUh5S0tOYWlpNHBO?=
 =?utf-8?B?WlB0T0J2S05zNzlsdmpnRFNqeDVuVFlnYzN6aSs2eVZ0eFl3UlY4bkpHUWNa?=
 =?utf-8?B?UW9YcUtDSTBERFdmc1dId2xnUC9PeWUvcmswQitBeUYyTC9PNmpiQWhVRm5w?=
 =?utf-8?B?SkZLVDU0eFpOMTJPOTBQSHhMbHduRVRUM1N4eG1RWXN0emVEdVdIY3JQVXNU?=
 =?utf-8?B?dTRDcFBCZks0T3k3MGdBN2ZvdmswK0R4NkMzb3FxSXF2bnBQS1VRZkFxUitN?=
 =?utf-8?B?SkhpcldYU0FOaUkyU2pqNVJpVmNwdkgycFkwK2xRNGVVZzNVMmVuT0x4T1Fl?=
 =?utf-8?B?Tnh0S3JUUEtkZEdBeU53T3d4MmNZcW5RQXAySXlmMGlKZHRRaXhZZVhYOVFU?=
 =?utf-8?B?cDdlMTNIWUJINUgvU3haUzMxZTRUTENyZ0VqWUhSYzdjWTJtKzNGMjhjcmMw?=
 =?utf-8?B?bThkUzFNUU1YRTBnUkFmYzBRTDFHZllvODM3VkJ4Nyszc1dpejJ1c2FKVzVK?=
 =?utf-8?B?cFlCRE9Lc0QzOFhsUldNK1J4N01TZ3RKOWtpNExZMGo0UThwTmp5Ymlyemky?=
 =?utf-8?B?Z1AxdFFXb3VGL0VzSXVlZ0ZUOTJuaTFlVm1zZjQxTEJkNmphSXMvNUJXR0dh?=
 =?utf-8?B?cXd5NmMxbmw0c2pONXJzRUNQYVQ2N2tNRjFVbXdFUEdjVUs3MHBuc3ZKbU95?=
 =?utf-8?B?ZU5ldTdIMjFvSmFCVFYxVlhLOVZub2Y5UUxlMGdDaHc3RmxJcDRTMmtHMkVH?=
 =?utf-8?B?dGYzTDk0SWo3c0JhU0tUNWJ4eHhzKzAxMzNxdGx2K1BNcWQzYlF6U3c2WVpB?=
 =?utf-8?B?c3g4SGxibjFFaFd2bitSOXhISzMwdlB4ZXozVFFqUDU1MjJ6TmJaRk8yRFgv?=
 =?utf-8?B?L1BCRk5xc3haQVIyUHBEclJNREoxU3dNektOdGRoRU5ReXlVeEowem90TXBK?=
 =?utf-8?B?OXpJMnMyanhqcGdHV1FMV1lZRjNDbFRSUUJMTW5zSE9rVHJEaGpldUdFeW91?=
 =?utf-8?B?ZEpFYTVIMjh0ZHJZMzkwNWpyY0VPSTRxd2ZMN21FZFhlb1c2RkYyMUNleWp6?=
 =?utf-8?B?Z3cwMUNISGFyWEpwSWkvQVRoR3lFUWlaT2hxMDhtOTJMVjN4d09VNlZ3WHZJ?=
 =?utf-8?B?Rm9VZldSMmo5cTU3QS9KNWlWZllPQlBudnBnQ0NhZGViUSsrMnorV00zOENw?=
 =?utf-8?B?U21laHZiNzlBcmlmRm9kcytkeXpEMVRYa2RRSWJtZlhnbjh5S2s1eXh0WGRV?=
 =?utf-8?B?RkxxdDd2WVhqSXkrcDlUN1NzMzBPOGV4aXdsNUtadDNKTWl6amhmQjAybjNN?=
 =?utf-8?B?Q1p4TW05Y2MvNE0xRGRPYzBubUxBSFNGUHVYTG9rMndHVTFtYnV3d0pIWURO?=
 =?utf-8?B?Y3NaMXNGU3FJV012eThNTU90amVKeVh3ZWdjVjFHT0JxRmpReTY3R21XVEJ0?=
 =?utf-8?Q?wDQ6kj9DnKK05iqbPHjozO0=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a662445-c0d9-4f98-7d02-08db05b2177a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 06:44:26.1465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KYkCapMngQ29Dwm8urBgmM61h/ZVdx9t7uPyihrAUwjLLzOhtUUyrMioLvzPpfh+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7117
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/3 14:19, Christoph Hellwig wrote:
> On Thu, Feb 02, 2023 at 02:47:13PM +0800, Qu Wenruo wrote:
>> Because the tgtdev_map would soon get completely removed in the next patch.
>>
>> Just to mention, I don't like the current way to allocate memory at all.
>>
>> If there is more feedback, I can convert the allocation to the same way as
>> alloc_rbio() of raid56.c, AKA, use dedicated kcalloc() calls for those
>> arrays.
> 
> The real elephant in the room is that the io_context needs to use a
> mempool anyway to be deadlock safe.

In fact, that makes more sense to migrate to the raid56 method.

We go mempool for the io_context structure itself, then still do regular 
memory allocation for the stripes (and the raid56 map).

Furthermore we can skip the raid56_map if we don't need, especially 
currently we're wasting memory for non-raid56 profiles.

And with my current work to make that tgtdev_map static (currently two 
u16, but next version it would be just one u16), for non-raid56 cases we 
will just do one mempool alloc (io_context) + one regular alloc (stripes).

Which I guess won't be that bad compared to the existing one.

Thanks,
Qu
>  Which means we'll need to size
> for the worst case (per file system?) here.  Fortunately the read
> fast path now doesn't use the io_context at all which helps with
> the different sizing optimizations.
