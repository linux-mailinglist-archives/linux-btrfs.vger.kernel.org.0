Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9298A4934A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Jan 2022 06:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351610AbiASFwj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 19 Jan 2022 00:52:39 -0500
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:41400 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351611AbiASFwj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 19 Jan 2022 00:52:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1642571557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+g1v+GrTw9mr8crdVo/UPguSxvsCv4C/XkEswdAwWs=;
        b=HK3MRv42eCcE6kLbQ99vCGm9phvuR0LUz6Sa72wwy12cmfh9+lXjA1gpHcGmGjrRxDA3gP
        3WuhuVA61KLFTSbdCdYR6aP52/+ngGwhtNTMagUTa3xuHQ+CxyROL1+1r12jMNkF2itDpg
        GIr+VaSZSeo1iQXopxKot5JTSxdF3NI=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2050.outbound.protection.outlook.com [104.47.4.50]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-37-3Cqd6C2HMIyDDtrJKovqeA-1; Wed, 19 Jan 2022 06:52:36 +0100
X-MC-Unique: 3Cqd6C2HMIyDDtrJKovqeA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASYTh81NVmJkuf9evsxTgb+k+mFKQOfPbkYajg0NPD/e6QiRwwnXcrgsjMC3c/Bjc8NuRfIgr9G+4vh2T07PGf73jeZaUbQWRDd0NjR49H3oJyZ4JdrATYihmLhoySIHNFfibkHjieDsNgbsKQAjseCmOoB2XwPN8+AurHva0dXLQ6IPKnNayG32XEHG0iph3F8VqNNP0AGWH8UL+YLpLPK0TTak8dp8nlsPmxxTxC0YCoQQpicZZrxlAovhxBnHdrdqXLxjCEF+/3LNYZeTccKV0IZeoJv1iOyZhhpY1reoQUW7npIThOHlMqcj2SMBjhOjKBwDdOP1DseXMoKAyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+g1v+GrTw9mr8crdVo/UPguSxvsCv4C/XkEswdAwWs=;
 b=RS1El5gPCg09bjUI1nDf5dIthxOdb3caWIRtqlfFbnI3lIqoL22f2pR5lnOxXXNJ6x0FTn2r5WoHqIwchwKSkhxpCuCwmX+3f93qfxr/JucplBr5CzYk7iAfXC6Btw8mTWLETLU+2Y7QI1Y8rnMoi5xA0vAUy3lalZi2TbMSl8fpiAvfX0kDvGMP6o2BNCQngHGE6RYu6j8AOiyQiewN7f1z1cDGXjtEO2HG1GigNsKRsxHmypXEW5Y6D8IJNt3scOaGfDAEAKvwia6J/A/F0BnHARb/IPvU7cHNpigzfUy+O9JPkUF2sDkjYlkoVfEAkFMvm4kPv/ADNpuHYZfnGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM6PR04MB6248.eurprd04.prod.outlook.com (2603:10a6:20b:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 05:52:34 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::7547:9d8a:d148:986e%6]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 05:52:34 +0000
Message-ID: <12e31a86-79b6-d806-f232-51e9bb0a7e07@suse.com>
Date:   Wed, 19 Jan 2022 13:52:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 0/4] btrfs: refactor scrub entrances for each profile
Content-Language: en-US
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.cz>
References: <20220107023430.28288-1-wqu@suse.com>
In-Reply-To: <20220107023430.28288-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::31) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a160a79d-9477-4fc0-2176-08d9db0fe3ec
X-MS-TrafficTypeDiagnostic: AM6PR04MB6248:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB6248724C9C5D21E8B3A27F47D6599@AM6PR04MB6248.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: loGCjQoqDYWhPnqVi5qq2WjzlYfU4IZHI2NbQvR+6t4DU6ROLZG8xiWkZC7rWDa1HH4AE3hxADYwGNlYwIpoYEXl3fMsLXRh2xsbPYXZe6kj5tVNfc7+5BXyMkJ3xlRIuJ3X4OcnZ5RsLPLtzIJturnWOs5QnVmbVk+llJWsBlNTCA1xklNebvpfI5j9jFzUdIire8M0++RPM0tX+05ZemhhEZJ0+YcFVHsVtT39HSVYQrwcMLmlmqX/s30whEtGbXD6vNWdFDlhpNR86lD6nIyWbH4l/SAEf8A017ap7lrUa3vwcNnVYmk9mZMGZR/iGtF0rB5brWzEVUeq+5TXmdlkS3/PyBkfwhAdYVQhhKP2AXe/Ib+hkR2ar2uGtobalR+8VsrE+ttliB8evK/wVGN83FMxRNbBq7qTrFAdSxlBGyGY4eFreN118ay8DqiLHCQSyox+plWRYWKvxMZeT+M63J7/0lT/rEChedEuu+prNC0u1u6bVvca2sDChh/J8YdF643ytdHB3gZKDqjUmtGvktn0TLu2UFlwbBZkVCV3r8Termqqr2xqjEQtmw0SVnWzfHKJe8E/Qlc1ZFcBA2cLNqxatuch/fzrhn6OhhuXq44ssYKNMol13yjeRxdRCjJwAykt1zOipaldJLm+EfsZfyK4GcH0S/FSMfFL8m7evU5xikuqaW5pP4RucBnuQcgvBZzfjfeOjDfaEJF+JitaUjHr2MZ7+rCoN9XxRBoppJE428clqWqV4CvCgjIvZqo9zhPvnQrVEV5dN9qjcbmKr1AL4Y9Cysucwpi6cjNzBDvXnmPEc3JgAHXpv0et
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(83380400001)(966005)(186003)(86362001)(6512007)(26005)(8676002)(31696002)(66946007)(6666004)(66556008)(66476007)(6916009)(316002)(31686004)(6506007)(2616005)(8936002)(5660300002)(6486002)(53546011)(508600001)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE84V05qcWFiSG5Ia0UwSGh5eUFWSmxybkYrTnpROTdtYkg4OExXVnFOUU1s?=
 =?utf-8?B?OGp1R1YxcGpNTnZ3R3l2VXZGNGN3V29FVEUwREZtZVJXMStieklLMDlPQWpq?=
 =?utf-8?B?ZU9LaFNlWUtWZXBjdVBLdTBxdzQ0WmNVeGo5OEl1cTFNWmkrTXE4RE80SG00?=
 =?utf-8?B?MW5Ma1pXVVFZbWJsVENselRwZ3Rkc2s5YVcvZ3U2S3NaWUFwcE94d0I3ZDRq?=
 =?utf-8?B?Q09kMDZxY3NXS3ptdURxcjM3RTdNT3Q4UlhCMHRmMTlVcnZ2MkZQNWRzanlS?=
 =?utf-8?B?OFl6YkNxcDNRakRoZnpOYzl2bGlVRjdEY3RWRXN2Tzc5RDZRZXo3SU52bndU?=
 =?utf-8?B?clI1ck5WR1QvSUpta3JicEtPa0hLYXVteVVMUmdtU2pOOFFyaGoyY0JkUmwr?=
 =?utf-8?B?aEZxV2Zub0RkekJGZWt3Q2pJb2MwN2ZMdzRIdXZSSTM5M1JLRW8wandYSWVY?=
 =?utf-8?B?c3JFSWZjekVxOTZiSWxJK25DRHNxYzBpNnRvc3dkOUdWR0ZKNWtTNzJBcVBl?=
 =?utf-8?B?dkh3bEtZSGZFYnYyeEFuRk1pdHNxOHBscGtsSzVwbjdtVit2aGZVRlpHMXp3?=
 =?utf-8?B?MHovK0VSN3V2dXM4eFdBUkE0S0tZblZSTjc3SjgvMXJRQlpXQi9ndWNHRWpr?=
 =?utf-8?B?QlRJVDFRckp1cmt1Mm8vQUdNRSsxYmxFOXNDS0x0bktiU2lxWUhtazhmZHlK?=
 =?utf-8?B?eGU4bS9vZkEzKzErTTY2QU41MWRpdGhyWndPQ2l0amRLVVc1QVl0d3ZmZVlK?=
 =?utf-8?B?S283cWEzNDR1czlyWkMwQVVhQzlQU1NQM1JUa2xhWWdnL0IwY3JNSmNTdnV0?=
 =?utf-8?B?eVhJQ3RNS0FxbmxjL3hzUFE2emtZTHpTR1A1RHVOSU1Pb3RQK3NlbE1Qb1BO?=
 =?utf-8?B?clFTVWlQQnlIbjFxT2VTbzNhcWdhZitXL3NCQXJFMTJBL3o1SGppVGtGc1FO?=
 =?utf-8?B?MnRJbnVNOG5vdnZIL2tFdk1RVFkzaDE1SEszWmo5cWtCRUk4UDVoMStjcXh1?=
 =?utf-8?B?RlpjQk02K0kwanFnSzVjY01tN0FVODhySXZkTDZNWEwvdGMxRFhqTWg4a1hV?=
 =?utf-8?B?OW42RW1TelBsNXZmQVZqZk9HSlpvZmJVeDVxQzd1dWdJdnNyYUN1OU9SSCtW?=
 =?utf-8?B?S1FSSDd0clg4MDE1T0xocW1nK20xN3dqOGNZbm1UTG4zNm90VzlqanNvdDRv?=
 =?utf-8?B?blRpSmRZOG5DQlROb3ZpZ2VDS2VveU1ZYTFKSnZCSWZCS2lVTGdkakJyV2k1?=
 =?utf-8?B?ZDliVVhuTDdaODJUbFU5RGZERkVCWVVtTjRxS0N1R2p3RmUzNDJ2VXFxUk9W?=
 =?utf-8?B?WldTd3lOWEtmQ2JXcWZxcElqWDg1M0dlQjNSSTM2R0RaNUxhbXBOcHBmbW1m?=
 =?utf-8?B?VmpkOXIxNDdTcStzRkIvVXFvNklQWFkrVS81ZlN2Q21nY0ZwT290Vjk4Nmkz?=
 =?utf-8?B?eTVuMlJSZGVkVHpBMGdMNE1abGlkN3dPT3RRU1NJQXFBbk1jNElmNWQ4R2NK?=
 =?utf-8?B?ZDl2MGlKSHJLa0JSejl4VkUwMG9YZWp6M0hRdDlsU0dEbm56R0MreDJRYnpv?=
 =?utf-8?B?b256RzVORC9EQmI2VlNYaTdwc0cvaTBHTWhBaVpMakdUQnJOU09QaUJkUjRv?=
 =?utf-8?B?cWtzQnd0QllhRmw5Z2tkNWllQnB0RlM0Mnc1a1MremUvK0psanJOMERIZzlh?=
 =?utf-8?B?MlRkWW9TRlBoOUZmUmZPZnd1SG9SM2RkYWtqZXF2Mmx2eEJQQmZiR2lzSlFO?=
 =?utf-8?B?MzlrY0wycVBiM2dnbUUxSncwNkFtRG1wZmRrcE1vR3c4cUVxK1NLVkY3YVdR?=
 =?utf-8?B?OXNoMDBSUW5CWjNna1l5emRwWHhBQlZXbEp6cGNEeTBNY2thVVl2SUZDK0ZO?=
 =?utf-8?B?RXdJS3kzZytocjR4NWpoaEs1M21zZ0tzV001ZXk4ZXNNQ1FOM01tMFBsMSta?=
 =?utf-8?B?Wm52SUlnZUQ1akdTQ3Qrc1RtQy93dzBaaXZKWnlxeFVURDJ0bEovVG55RU5h?=
 =?utf-8?B?K09MVXFXZG96VWJjWFcvYloxTHJOcEpDYVJBTm9naHI2UXk2aDZ5d056QlJE?=
 =?utf-8?B?cDFWYmJ3Uk1jMmo4R3VDdXByUXVmamJMbnRxWnBxcWRqWG55TTB0cDRsdHli?=
 =?utf-8?Q?rXA4=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a160a79d-9477-4fc0-2176-08d9db0fe3ec
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 05:52:34.6874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dPrP9FjnkPHxlbtuCNqUqzOV5Q4zEG4iDHLx2oVbmi4NmfgMMTRUc3PAVcAb8Gbw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6248
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi David,

Any plan to merge this patchset?

And if you need, I can merge all these refactors into one branch for you 
to fetch.

I know this sounds terrifying especially after the autodefrag "refactor" 
disaster, but unlike autodefrag, scrub/replace has existing test case 
coverage and this time it's really refactor, no behavior change (at 
least no intentional one).

I hope to get a stable base for the incoming scrub_page/scrub_bio 
structure cleanup.

As there is some plan to make scrub to use page::index for those 
anonymous pages, so they don't need to rely on bi_private to get their 
logical bytenr, and hopefully just one structure, scrub_range, to 
replace the scrub_page/scrub_bio things.

Thanks,
Qu

On 2022/1/7 10:34, Qu Wenruo wrote:
> The branch is based on several recent submitted small cleanups, thus
> it's better to fetch the branch from github:
> 
> https://github.com/adam900710/linux/tree/refactor_scrub
> 
> [CRAP-BUT-IT-WORKS(TM)]
> 
> Scrub is one of the area we seldom touch because:
> 
> - It's a mess
>    Just check scrub_stripe() function.
>    It's a function scrubbing a stripe for *all* profiles.
> 
>    It's near 400 lines for a single complex function, with double while()
>    loop and several different jumps inside the loop.
> 
>    Not to mention the lack of comments for various structures.
> 
>    This should and will never happen under our current code standard.
> 
> - It just works
>    I have hit more than 10 bugs during development, and I just want to
>    give up the refactor, as even the code is crap, it works, passing the
>    existing scrub/replace group.
>    While no matter how small code change I'm doing, it always fails to pass
>    the same tests.
> 
> [REFACTOR-IDEA]
> 
> The core idea here, is to get rid of one-fit-all solution for
> scrub_stripe().
> 
> Instead, we explicitly separate the scrub into 3 groups (the idea is
> from my btrfs-fuse project):
> 
> - Simple-mirror based profiles
>    This includes SINGLE/DUP/RAID1/RAID1C* profiles.
>    They have no stripe, and their repair is purely mirror based.
> 
> - Simple-stripe based profiles
>    This includes RAID0/RAID10 profiles.
>    They are just simple stripe (without P/Q nor rotation), with extra
>    mirrors to support their repair.
> 
> - RAID56
>    The most complex profiles, they have extra P/Q, and have rotation.
> 
> [REFACTOR-IMPLEMENTATION]
> 
> So we have 3 entrances for all those supported profiles:
> 
> - scrub_simple_mirror()
>    For SINGLE/DUP/RAID1/RAID1C* profiles.
>    Just go through each extent and scrub the extent.
> 
> - scrub_simple_stripe()
>    For RAID0/RAID10 profiles.
>    Instead we go each data stripe first, then inside each data stripe, we
>    can call scrub_simple_mirror(), since after stripe split, RAID0 is
>    just SINGLE and RAID10 is just RAID1.
> 
> - scrub_stripe() untouched for RAID56
>    RAID56 still has all the complex things to do, but they can still be
>    split into two types (already done by the original code)
> 
>    * data stripes
>      They are no different in the verification part, RAID56 is just
>      SINGLE if we ignore the repair path.
>      It's only in repair path that our path divides.
> 
>      So we can reuse scrub_simple_mirror() again.
> 
>    * P/Q stripes
>      They already have a dedicated function handling the case.
> 
> With all these refactors, although we have several more functions, we
> get rid of:
> 
> - A double while () loop
> - Several jumps inside the double loop
> - Complex calculation to try to fit all profiles
> 
> And we get:
> 
> - Better comments
> - More dedicated functions
> - A better basis for further refactors
> 
> [INCOMING CLEANUPS]
> 
> - Use find_first_extent_item() to cleanup the RAID56 code
>    This part itself can be as large this patchset already, thus will be
>    in its own patchset.
> 
> - Refactor scrub_pages/scrub_parity/... structures
> 
> Qu Wenruo (4):
>    btrfs: introduce a helper to locate an extent item
>    btrfs: introduce dedicated helper to scrub simple-mirror based range
>    btrfs: introduce dedicated helper to scrub simple-stripe based range
>    btrfs: use scrub_simple_mirror() to handle RAID56 data stripe scrub
> 
>   fs/btrfs/scrub.c | 702 ++++++++++++++++++++++++++++-------------------
>   1 file changed, 422 insertions(+), 280 deletions(-)
> 

