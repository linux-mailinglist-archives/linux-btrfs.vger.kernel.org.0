Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401306CB2C2
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Mar 2023 02:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjC1AQz (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 27 Mar 2023 20:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC1AQy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 27 Mar 2023 20:16:54 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939A61BFF
        for <linux-btrfs@vger.kernel.org>; Mon, 27 Mar 2023 17:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8nq751yXmDEhzTBxM6ScjAvhmRMZxxCGS1pFoqV+5bs/sV+9juFXazNuHVPQniAqxcG/eM5Lbb+btiiyiN72TBOYNQcC3p0GrUQ0wYA2BFSDxr7UeaUDt1tCXKRH3vSB8TbNQyyu8cZknk1IRBEa+tE1nkM4Nt6VuyfLaCOsejWIQVipZuUqb8NkfWJEc7GRT85bPQG1Sf/K7o7CZsJqrf09DhnBfbG7tHaeozbaQaKGteEs3Jp5xyNl7BY4xp+RnvLYOdRYEWzJxwFdjlDJgwuJpaFMNIxxnxXirN/tjNZNhC12cSQWDkD+4f52McASKSpoBh+hGONl/U7hpWCQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UlgPDVJQ4Tuk5fWDeM1MOkYWggYD2Ulg+5h6F6wMwio=;
 b=DHxOH8zFnRG7qeYf9h4mw5OVAl3xejLgu0Nqu8d+oWkXvYPqvCwYedA6C+RUH5MGl1eKUoXa5su4pux//Q9fTbKFpGGqQYuTiSYkxnkLiawlJLnSqUQxht7UJd6yxurrphB6adUjMo2b1aft6R5xrrwTP8+PNYeFs5WS+4T5003E3GXftCP71t6t+EWdJsAXFOojwRoP/c7ibjGXud2FlbGSO3DLPlq6fRknqcH7ETaKOBB3/2iBIZQO8CufpT822PWg7O/uWP0B467svhirfJzJFOkBBDHT1LtvsDtY/pRK9tOQm8uJYaaV3a280pjeiiz6ooFy5QsQ8FD9yocEqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UlgPDVJQ4Tuk5fWDeM1MOkYWggYD2Ulg+5h6F6wMwio=;
 b=a27VLe24U45YQGXDWOuFYxmZ42ZJbeOJ0Ww2oLT9BcITTkdqxQeJapCJ6xusu8GuCZOrnFDP309noglPs/KNiImvvGgXBzCXA/mZTLcQIeXNEFsPYln6AT6VPUxs2ygqFxRedfoZ9ouGhCcIV+v1R/PS3nDEuTJgmDdggjsa1OqOwlf8nEd/dNB4jdEqJYq+7RzssqE1pcesTMYQTb/Qal/W2uDVyGC5TrVQyl55t77402bFGGs6sHqWm5xEzoNM5ef+GjU4plXExD7MpLESo7AzDOpk1IfxganEcp+aZDa6ALfCb0Ay1bXKMfhUiKe6Jk8ZgHcEq/+6MBZPL5VwZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Tue, 28 Mar
 2023 00:16:48 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::8aa:9e7e:52da:c652]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::8aa:9e7e:52da:c652%8]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 00:16:48 +0000
Message-ID: <cd8a91ee-2e30-9829-b50d-599fab3fb490@suse.com>
Date:   Tue, 28 Mar 2023 08:16:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
References: <cover.1679959770.git.wqu@suse.com>
 <79a6604bc9ccb2a6e1355f9d897b45943c6bcca9.1679959770.git.wqu@suse.com>
 <ZCIoQLysbLrQW0pX@infradead.org>
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH v5 03/13] btrfs: introduce a new helper to submit read bio
 for scrub
In-Reply-To: <ZCIoQLysbLrQW0pX@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::23) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|PA4PR04MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 951b0bd8-9e83-4cc6-d0d5-08db2f21b87c
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGJu6bL5NIhzpuUS9/BhL/xTJ48HJjH1lO/qgisjBznEdjDKxo2NXbP1q8Sk60uxOjAax3f3fkfJX5Rf/y8NdKMlm2rb6JVyho9NdeSCI2z8tBioMmxkNBPMarU3zEugRJi3JYjsiBzfMqFJSmbsDF0hf2Axzo2ZtHn6IWYB85NX3zYXrKDYB/XSJBbfIups0+Ov+y5XLH22qWsecy///cZV1fz9n5zX26iZndvWpfsKsI5PFPnTnhIfSp/9UrPdY9baxM0K6DbCBiGkeCEBr84JbNYUDww1U44HEbnM0jgFt+uS0Dxr10qWKs2ES5TNtfVBmzCpBH9fxg5Y2BnHNssvVeEzQ68jUZWSeAxmj8Ryuo+cpSYNE1Qn5jMyE61RljIA8KVrW8cEvRF0xoXePZ4qxrGF3zelyPRKrxlkm4/mVCeEnf8iHv0l/SpwT6ql+ULwx+jk6/rPs20fTsIQbHke7wOuY0Mpv2IVKd+BI/Dtc2jF54CFOG/UlTiggyAfQiMC0sfPEvsIwKB+o1vhO1lb0/H35BXqG4osBVwQpoiazw3MZL2qIb/OfUeSClII2Bap2TSMPT/AckblWfITEeIIUaPujt97kB9tX5lCY8TtvIOI+IksF4P+GP4WUzi10F4kX1WY3vzDjuUDyxTC/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(2616005)(83380400001)(8676002)(66946007)(66556008)(2906002)(66476007)(6512007)(4326008)(6916009)(478600001)(316002)(186003)(53546011)(6666004)(6506007)(107886003)(31696002)(86362001)(36756003)(41300700001)(8936002)(38100700002)(6486002)(5660300002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1VkZ0hSdjM5TUdqelFLOFBZalpvRms2cDRDMWR6UGRpek9uVFF5WGpNTTZi?=
 =?utf-8?B?ck04bS9XS0UrVzFjODRQZGdCN3d6MHVWTXNuWDE4TnBtREdNTDBMVFRLczU0?=
 =?utf-8?B?YjU4cUlnM2dBRFNkcUUrS21uVG5nZHgzd1c0S0IrcTdLdTBleXN5ZXJYR2t5?=
 =?utf-8?B?MXd1ZHFNS1hHeHZlNFlBNlBqM0ZzNjJCZnRDSkYxOVlVS2RpOUtGTTJla3pu?=
 =?utf-8?B?NnkwVXRpOEVtMCtMUjhZQ1lNc0k5TUM2WmhNUU53MWgxUWxSc09nc29NWmdX?=
 =?utf-8?B?UkhTWFBUQ0RrZ0dmYmIwNHdhanVSeG9oWmZ2YWFiL3ByQVZpNGZyL3RqVHFl?=
 =?utf-8?B?WEdUYVVKVlFaZUxmK2d2cjhxY1NCMFhWSFJlajY2M1huQ2dGU3pkZEVNK3dF?=
 =?utf-8?B?R0xkSC9ycE5VYUljcEtSbnZObUxEL3Q3RHJBdTdWUG5pdWdHb0ZqOUszMnNQ?=
 =?utf-8?B?Vy9nQXBHRUlONDE1WnU5dlF1QytuVnhoNkJhRHFNSUtxUWZDK3RTb01VeGQ0?=
 =?utf-8?B?Mnp4Um04YWpJL0d4aW5CWXZUaFhGUklYRGlnQ3FxZWRqMHNPQWZHRGk1dmcy?=
 =?utf-8?B?RHBlV3g0WEJhVjgyQWJXVGZRMittdmU5cWh1Z1BXTEUrWEMyZ3orLzN6ZjVz?=
 =?utf-8?B?RnNNWFo4dU1pOVhBemxFbXBFVTVXMHNWMXBld0ZPTVdMdlhkYVBNc2prNUdy?=
 =?utf-8?B?SUhHdnJ0a1YvT1d5d0lYRjN4dFRpNFFwQ3pvZ3UxelRydm5lYjVUTGxhcVBL?=
 =?utf-8?B?cklXMHZwQS9Ubno5a25RNE5weGVoVXNYcGVxNml2M0t6R3U2eHpzMGJBUEgr?=
 =?utf-8?B?YmMvV0lGRGU2dEtod1UvYjI1aFEwTXN6bDJFak4wcXA0ckdSZFRXMk9xR2lr?=
 =?utf-8?B?RW8yZDlkdEh0cmw2aDIyU3pFSWtwYkU4VGZCVXllUnZ4K2FSblIxeS9sSHhW?=
 =?utf-8?B?Qm1ZRll6OXBzdSszd0p6N0R2dUVrUTU3elR2Y3pRNEpkZ3ZRUGlpUkxZR3Z0?=
 =?utf-8?B?dFFlbFNzR0VES3ZFNFREVWZMZWNqM1ZvZHRkcUpEVTlYMEE0TUhlSzRKMFJT?=
 =?utf-8?B?VER1SlhOQ2xLMnIvQ3l0NWFFWjdpYkNWS1dIMUlRYVZuVkNWSXUzRnJzL2xr?=
 =?utf-8?B?Qk05TnA0b3VOVHhraXE2V2lBK3VzazB4cXdQWVlZMCtYSWlTd3Y0YWlmeGdx?=
 =?utf-8?B?NlVhSG9hK0JVT3oxM1lrZU5ISEQxalpaaFc3N1lhSG1ZTzlUaFl1OEZWQ3Q5?=
 =?utf-8?B?UEZJWHR6TmE3UkxwZGp1QmN0SHppdjdIY1gvTlJ5NGkxdCtOdlQvRlZxNnJx?=
 =?utf-8?B?Q0xFMlZybndqR0F5TmhrYy9wZjEyZGdOR1VPNjVtcUxWV3JLUFY3SzJIY0hW?=
 =?utf-8?B?eXJjT0lZcW5TWE9GZkNxUWJlalRwcHMxT3RqSzE2cXN3bW9wT3ZPR0NkVjR0?=
 =?utf-8?B?TGRqZXVRTzlrczk3aW12VklJNUxNMWVtdTc3dFd6RzBhYVhPQXV0NDRxUjRs?=
 =?utf-8?B?ZEFNZU16SFpxMUR1OGJ6bnZhcVNSYnVMYzlrS2tEaUExZUFJOFY1UmJKMVp5?=
 =?utf-8?B?Yyt4UmxEWDZ1YklJMi9wWi9JK1N5ZVhIM2gxOHNQNmhoWHcvVnVvYUdwUURY?=
 =?utf-8?B?R3p5cFlac2pZWkQxdEFVQ1M3L3NqZllwbVpySjlndkRjbVpmNVRyK0lhMTJE?=
 =?utf-8?B?MkRINDNHRXAxSUYxQUt0VTBNa1RRVW91NU5LZXhPQStFS01wTUY1WVQzTE93?=
 =?utf-8?B?Vnp5VTdiNWdmZ1NVUVQwVmR0V2kwRndrM1J2bkdFcTFsdGh4MDYwNld5OUpI?=
 =?utf-8?B?Z2V1ampNU2pPSnVWTkZSbEpSbU8xNWs5NEd3UWJzaStZbzh0d2Jkb1BqVUJu?=
 =?utf-8?B?Slp5QWwwd0RFSEdkNWIrR05OdWRBQ3hFYXBZZVJuRXRNNkcyQ3FVbkgxWE1r?=
 =?utf-8?B?TmNWSzJZNXpTSklSTmxFbUhVVmxsZm1VbkFvS3Z5ejhNeUVpSW9FK3c0Q2ZR?=
 =?utf-8?B?bGFQQXJTTllEcFRDTE14RW5EOVhyaEtuUEZkZE9SZXhHMUVlMFRjdGhNT0hi?=
 =?utf-8?B?NXRTeXBpeHA1S2lGZFJzR2hmam9JMm90RTNBZnFxVFVzTG5jTk1TUmVDdllN?=
 =?utf-8?B?KzN1MnpXK1pHcmhSczR0VzdVSHRxdUZpM1h0aHlscGVrcVJacGloVjBNMjNL?=
 =?utf-8?Q?uw2T0PhZA0CaApmY0tHPs0w=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 951b0bd8-9e83-4cc6-d0d5-08db2f21b87c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 00:16:48.1254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bwq0xDpg1PdTWsXwFN21vTOkvKuSggwHnOhdNbaB0zuYNY7AE9QjkHHBiLZSk6vs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7533
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/3/28 07:35, Christoph Hellwig wrote:
> On Tue, Mar 28, 2023 at 07:30:53AM +0800, Qu Wenruo wrote:
>> The new helper, btrfs_submit_scrub_read(), would be mostly a subset of
>> btrfs_submit_bio(), with the following limitations:
>>
>> - Only supports read
>> - @mirror_num must be > 0
>> - No read-time repair nor checksum verification
>> - The @bbio must not cross stripe boundary
>>
>> This would provide the basis for unified read repair for scrub, as we no
>> longer needs to handle RAID56 recovery all by scrub, and RAID56 data
>> stripes scrub can share the same code of read and repair.
>>
>> The repair part would be the same as non-RAID56, as we only need to try
>> the next mirror.
> 
> Stupid question: what do we actually still need this and the write helper
> for now that I think the generic helpers should work just fine without
> bbio->inode?

For read part, as long as we skip all the csum verification and csum 
search, it can go the generic helper.
Although this may needs some coordinate during merge.

But in the future, mostly for the ZNS RST patches, we need special 
handling for the garbage range.

Johannes is already testing his RST branches upon this series, and he is 
hitting the ASSERT() on the mapped length due to RST changes.
In that case, we need to skip certain ranges, and that's specific to 
scrub usage.

Thus for read part, I'd still prefer a scrub specific helper, for the 
incoming RST expansion.


For the write helper, it's very different.

The btrfs_submit_bio() would duplicate the writes to all mirrors, which 
is exactly what I want to avoid for scrub usage.
Thus the scrub specific write helper would always map the write to a 
single stripe, even for RAID56 writes.

So the write helper must stay.

Thanks,
Qu
