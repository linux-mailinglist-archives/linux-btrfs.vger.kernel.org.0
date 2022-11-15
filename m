Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAAF62AEB3
	for <lists+linux-btrfs@lfdr.de>; Tue, 15 Nov 2022 23:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbiKOW5W (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 15 Nov 2022 17:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiKOW5U (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 15 Nov 2022 17:57:20 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70045.outbound.protection.outlook.com [40.107.7.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801B62B606
        for <linux-btrfs@vger.kernel.org>; Tue, 15 Nov 2022 14:57:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrlAFcsVWmnMSqDRurZcjAavO5e/C6TgvHwLVfCQuWDY4+9XrHHLIxZGvbdHW/7Q0QF1T1s1Il0WOvDA2SW4t88l9C05G1RQzWUbKEN1oDvhbiek9FelNd7AowoTP5wZyKa8wE5kP84QBC0x8mGrT829yRz193TfdQpnIEOJm3ekY/nNx3dRfPT7sepGXFPiVJzeHr41l5dXRxfiJ4I33ujW3ff5dy1MoF4JNyJwSpaexftqbxDjHyUbxsoVNWAaWTz22K1rcVhYo669U8gMaE9fFEhD+1+KlGEQYNBYps19ZTnszD/B2hmopr4Ia0y1EQxM+iVMe7EZnEYU8t14PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jJggQM6L9Uf8t/dE73pkZn06Lm6J16Lqh+1Lg38p0o=;
 b=OjlwoxetBCHM4r/8fP53TR7XWHZw2MlfZKnst+Lw22wWcmIkRTg7B8KRjmvArvdhspK94Td2zGN/FvHgkk0s7pIj2+hWBHMHjdFKLuSbv+Sp5wpc0St/WxEcv4kLIm8TgoQoHvCgUXmU6bmNL+RoWnkMk2ob5yDzrEMsxqxXX3x4LuWGkfxvYayoNL9pK2euWOE6WeXOxMKeY5Nw1sYHE0Ju4UkIlIAtoX0a008vmGimCYNSU06CZHnDihMy1yk31yPof99pYpEFh8edtdeLdKB8SEnGGiWOQUNl53UupM/Quap7BODvzkyN/SrNSSbDwDvO0irlBxpaR/BBrNy1CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jJggQM6L9Uf8t/dE73pkZn06Lm6J16Lqh+1Lg38p0o=;
 b=H6ySxHUdWLpH/gFF9UGekQQ8116L/rTKInFxz6q6RuYDlne/hRc9q2kC6c+aCLT5qz4WS7amjJ8pOUm4KDbMm3VNULghOA1bCTfi7AQ577yueDtunIPUpaSkWaQV4oB+AcGYWnmJR75/pu3B9uNlJpRmLH1DCDmssO+2S5kzy5RYQWpXoTShNMGHEEzaVjQnlEzISC6StH2hgO8HWN3Rv7yiPLZyZVGWs7MRDkf89Mtxhkp7aiv0wos7C07oQYdTHDSj2HWOklOM0VjNkEfSpe36PWOasAYnFtMvcrDWz0HzylbwMvtPaC/0aWoCRn4LB8d0JUa/rCgBq1o8qDgIGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM9PR04MB8588.eurprd04.prod.outlook.com (2603:10a6:20b:43b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 22:57:15 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::b69e:7eea:21cc:54ab%7]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 22:57:15 +0000
Message-ID: <77b0da75-8ef8-42d5-c8c5-bfd63bf7c4f0@suse.com>
Date:   Wed, 16 Nov 2022 06:57:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     li zhang <zhanglikernel@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <1668353728-22636-1-git-send-email-zhanglikernel@gmail.com>
 <f5cceda5-e887-0807-7331-12382b45ea29@gmx.com>
 <CAAa-AGmQpL34eG8yx3bg8FYcbbOOjb3o8fb5YEocRbRPH1=NBw@mail.gmail.com>
 <11a71790-de79-3c2f-97f3-b97305b99378@gmx.com>
 <a4ebbed4-f75f-16d3-34d0-838d73d031f9@gmx.com>
 <CAAa-AGmqmnKyQ_LgxB-oVnP+8tP9QChSq2M_SPhtgPQBxd3Skw@mail.gmail.com>
From:   Qu Wenruo <wqu@suse.com>
Subject: Re: [PATCH] btrfs: scrub: expand scrub block size for data range
 scrub
In-Reply-To: <CAAa-AGmqmnKyQ_LgxB-oVnP+8tP9QChSq2M_SPhtgPQBxd3Skw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:a03:217::35) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM9PR04MB8588:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c25ed24-01c7-4b7d-8601-08dac75cbbee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rt0fYDpYXUNwvWsrC95xp/5RU9pK8E4EPrrBqyQzEhxY/L9ZqvY3Zkan7dm50FdnPMB2VrVS+3AmvssjVyO8DpfVzyQqiXDgfSzL5lRMRsLkvTSVBjvOrLxBD7X22+GL1V2Mg9Rabqc7ds9zZeXAiNKtQFoUNNjO7VTGYHH5qoMA+UQUMnCAVct3tLnLD2imf4jzD8SSNzYB3EE8mEP5Iz1cLsU+TmWRhtaohwJDYdlsCQz9Y1wO5mvGZKFTOAuHBQG5dL9Nei9EBx5QalEkK1z1QR0z7sxJtgXeZwa/XupCQe4su42CiM9uVdUEjBOZwG+ky3DfcWPMiWg5QAJVp84F1wF1PLiHJaogyNgGYZgy39K+HUg4vK/pdeLkPc7VYDoqbJ0w3t56wqHit5FbSbsluRsVEflfzIKho9S3jKq2PhbZBbIFiWx+wbu03qrJkDhJ+vrj4gn4wcyo2Nzvzsc2tgIC2Yi7e7QsvLYYSS1e1irZUBSXX8mXk5tOOWWcAeXn5WOOXNYkFHw2OBYn8v3N9wkPdfTwKD36YfO3mZwQ8SasDTtnI/UDSPEM4ZdDUdnxiAaW2gtiFpB65lOW6DHuGP08ykAeLp+4yrNs7aTQQ1WJE6afbmwRPTM5j8ZK1s0wdZbJWuNdNiPVm6S7KsOeQBrfYnOKUTccQcKp2KaVk6zUjTrqmODneAx0V9D/Y0mjU7FYbKI53UmNvdZJHhua9epQ7tANbakVQBEcLy6c9qfRZj206zhkOUXpJ6MVEmZX0V1R4KQ22eFp/VRd5CV/NoPTK5aNltXPpVx9T06k5wfvHK01eKjzb9KMxTuV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(396003)(376002)(451199015)(41300700001)(36756003)(83380400001)(2906002)(110136005)(6506007)(316002)(6666004)(53546011)(86362001)(38100700002)(66476007)(66946007)(31696002)(8676002)(186003)(6512007)(5660300002)(66556008)(2616005)(31686004)(6486002)(8936002)(478600001)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVdNT1hIeENEZklXS2R5STRjTjdoWVlMdmczdHVCOTBJbEdHN2VRN3RBVGFm?=
 =?utf-8?B?UVNZQ0dGQi85RENlU05VOVpraTZQVWZrTmx2Q2dNR3hlVE5vVmpTZGxKNHN5?=
 =?utf-8?B?emgzTExRbThwam5Ec2pBY0Jla3dZeFZISmRuMkNJeUFhRXA2L1U2a1JQTys3?=
 =?utf-8?B?VnI1NEgzNGE3MjFsMEowZ0o3VHBUdjBVUkRLM3Rja0Rya01OZCtSemF5Qkhi?=
 =?utf-8?B?a05Yd3ZyelAvMGJ5SjdPNGdYSVBwRDF5Z2JjYXBkekF0Tk8vbHBWOE9kazJv?=
 =?utf-8?B?MGJ6SzBYRkJXRi9BRWwzWFJTc003M0Q0R1UyaW41V0FZR2NMWWxNM1Jsd29q?=
 =?utf-8?B?R0ZncGc3S2paK2VVYm9zcCtuSXRiNXExcWZkQjFMKzVsTEMzSC8zS0JUcEpk?=
 =?utf-8?B?MjdpZGJ2ZTlJRjYxTDdnN1czN3NhbjZCZ1VsMDJHSWJiUDJYcFBvdnlaTTdz?=
 =?utf-8?B?YkVtWHBGb2J0QlZHRzFJSUpJZUdlTklhNHFkL2VsSUhMZTErbHF5OCs2UUZW?=
 =?utf-8?B?eDlMU3N4bE8rSGpTRnpQVHFoRVdGWDlFNDJJUm55NjNrTWprU0hhdzgvZUJK?=
 =?utf-8?B?OUtEclRKSlBnUGJNZnU3UG9ZRUkvemVLMzhKczA4N0pUSzBySFdGdXJNVitr?=
 =?utf-8?B?dWMzOWVPOG9SSC8yQ2VjSDRSNHRRTXU2a3RWbE9lZEI2QU5DUVRjTjNnZWdS?=
 =?utf-8?B?ZE1RMzk1UTh1TXM0SGxsK2ZMUTZkQWpvMEVxUnV0dTQ5M2UrSW56aURpaSsx?=
 =?utf-8?B?Y3UwQ2F1ZVFVVnhRRjZza2l5UEVvZTBSNUtubXZMbGNrVnptM0tHWTZxczVY?=
 =?utf-8?B?QVNMajlkZGVoaUtPcE1Kb1hIWDF3cHUrR1JseFBybDVNdlRQRGVoR1g3clp6?=
 =?utf-8?B?RTBucWFXUmttNU92TDhZb05UcW43Y2JibmFwVU5LVGFrZHBDY3hpa1JPTlQy?=
 =?utf-8?B?dWxueGpwcnhlNU5GZnI4WTN2L3hQN3lRQXY5WlAwUjM5QnV1OVovTzYvS29u?=
 =?utf-8?B?TlYrR0EyWG5Ib0VUQzhvMFRGalJxVmU0eUMyY2E0cGtYazdrUGFua2srRi9o?=
 =?utf-8?B?eGpUUjEyYzY2aVVjUHplMTVPTEFPNjA1VGQxdGlZV05mZEs1RU5sNm5HTkFO?=
 =?utf-8?B?cW5yVVVxM1pLbzRGL2xKMkUvSkxkSXBKUkNQcGdSeVNCREhSdW90MWVLMXZp?=
 =?utf-8?B?TEtRQlBCaDgzcHF2SWplZitTS3BEL0g5bWJrNktmYXdTdHdudWlZR2lhZm4r?=
 =?utf-8?B?bTBjOXFoNEFIZWRuM0dQd0wxcFp4NHJFM3pzN25TMStaaVc1NnErck1oR1lp?=
 =?utf-8?B?TTdSVng0alRiOUxtRHdmeEp6dStzbVdudll1UDgvOFZsYjBKSU51WVY3Tktw?=
 =?utf-8?B?d3FYSHkraWJFSGo4RU4zRm1YTUIyTmZCb1lVQlU5R2xJck5MRjQ0NmUvK2Q4?=
 =?utf-8?B?cFhxOXFjNlBDY1hzdmdqM2xIa1MxeGFYZ0cyMUxoQjZXd3ZLN2IrWDRLTHhh?=
 =?utf-8?B?MVR5OEZyWW9XTmRKWDIxSU9LZC9pdmdLNENrMGl2eG5JcGFQWTVsUmc3OXhV?=
 =?utf-8?B?YWtzL2d6NDBESWlHWVlwQUw4UDNscjB6ZklGR1JrQzNaalpkMFRYYlBzbk8v?=
 =?utf-8?B?czczZlpMRGdTR2QvTElZQkNIQmhBYVRQTGEwRWQ2TEVoRlNzY2xXTHZFY3VO?=
 =?utf-8?B?dVZlT3MvNiszQ01jM1BrUUZIRi9zcjZoN0lwZ2RJQWd5U2FTZENaUlZFRUY3?=
 =?utf-8?B?aE5peVo3YWYyTDBteHBtMjBaVkIzVTMreTZvWXZJbUp3U2h1MXZqUWlFV3Ba?=
 =?utf-8?B?NnBkYytMQlhXMzNnRHVKT0w1N1lVN3NBMEVON2UvTWVKU3MrL3RPamRqci85?=
 =?utf-8?B?ZnptdGk0TTYxRUJLK3dCdUpWbzN4dGtIZ0FjSWcxMU5ISjBmNzYyc09JMjRV?=
 =?utf-8?B?M29VNTY3aHJoWUZtMzZTTjB2ZG56Z216Sm5EZkhER1VPalE4Y1VBUHcyNjhT?=
 =?utf-8?B?MDQrbjk2NllPQndyb0MzNTE4eVB4Unp0NnpkNGRILzFnV2k0ZG9ySy9tUjk2?=
 =?utf-8?B?SDNJK2t1cVEwZGtqYklsSXlkNHFWYnBhL3lPcTFyd2duTFNOVkxuWFRUU1lU?=
 =?utf-8?B?cFJkZGxGYmxtczJzVklOMGE0VHEzTHZDWFdDVWVoYzlYK3ZYdE84UkFoaS91?=
 =?utf-8?Q?IBPtzIN5LbvcitEynPtHmrQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c25ed24-01c7-4b7d-8601-08dac75cbbee
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 22:57:15.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhGw059o1CQu7iTqBjgOVRfM2dYqC9wko8m9K5r5NSRRBY5J8m0DebJRsQdgg4Lp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8588
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/11/16 02:29, li zhang wrote:
> Qu Wenruo <quwenruo.btrfs@gmx.com> 于2022年11月15日周二 18:37写道：
>>
>> [Adding the mailing list, as the reply is to the first mail I got, which
>> lacks the ML]
>>
>> On 2022/11/15 06:39, Qu Wenruo wrote:
>> [...]
> 
>> I'll try to craft a PoC patchset to a stripe by stripe verification (to
>> get rid of the complex bio form shaping code), and a proper bitmap based
>> verification and repair (to only repair the corrupted sectors).
>>
>> But as I mentioned above, the bad csum error reporting can not be easily
>> fixed without a behavior change on btrfs_scrub_progress results.
>>
> 
> Actually, I also considered refactoring the functions
> scrub_recheck_block and scrub_recheck_block_checksum to import a
> bitmap to represent bad sectors, but this seems too complicated and
> may affect many things,

Another thing I don't like is the various jumps using different end_io 
functions.

I'm a super big fan of submit-and-wait, and already converted RAID56 to 
this way.
Thus I believe I can also handle the situation in scrub, and hopefully 
get it easier to read.

> so I choose
> Handle newly discovered errors by recheck in
> scrub_handle_errored_block, ignoring recheck errors by exchanging the
> result of the first check and the result of the recheck, as follows:
> else if (!check_sector->checksum_error && bad_sector->checksum_error) {
>   struct scrub_sector *temp_sector = sblock_bad->sectors[sector_num];
> 
>   sblock_bad->sectors[sector_num]
>   = sblock_to_check->sectors[sector_num];
> sblock_to_check->sectors[sector_num] = temp_sector;
> 
> Anyway, I'll take a hard look at your scrub_fs idea

Feel free to do any comments, I'm pretty eager to get some feedback on it.

Thanks,
Qu
