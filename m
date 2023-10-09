Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2CC77BEBEE
	for <lists+linux-btrfs@lfdr.de>; Mon,  9 Oct 2023 22:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377918AbjJIUvT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 9 Oct 2023 16:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377082AbjJIUvR (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 9 Oct 2023 16:51:17 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016CF9E
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 13:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cO5soYy8sLJIdDdHTz1inRxgKJhatQa1cMPhnVp+HRMGvT9HiAkvrvXZpP1XpqsDcQSxEy6gum12y3pi2bLYx6DXfgS0YHV26tkJFrcuB7LRy1Pt6IeP56SuhFOYmd53dmNu6yoUb8Nfhg42mSvCRsxPcgWihbyATMlT3Ejq7zTgTnKWOf/j6bqykWW71jxKP9H21vP3Oh+NrbDt6QUgRb08bs5unPCh3rVy13gAe/jMzRNK111Y1713/iislvmd+tEjKjKnNx+qF8gwKciynHBPbq3qSrnVOWtuIuZ/I/yZvTa1nVXyJRRP6zd1x80IvfMEV1V+C4VNb4xBsyA/sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WGQdWtezDeNuWakvhihrJKHUBPNvyBoYoNjY4p0b8Q=;
 b=HMJLMb9SdnYdsSV/n1mM99j8HiwiBdd+w4Jos6MQxYOg295tMax/UgS/D6mdrbpjy5dxh28Lt7JJBXbu/SRUYN7Bto9RQl1InbSKC6EZJh2j00o6CD+jvks/G3O1hORik9spq+IFkde4lfZgcQkZXXLW9/d5nOeKTnPnJiicYWFHyp9FLovBGPJ7CUi/iUgKn1/jcd/zvR1KV/oEn3Q1GB3A6vUcW1yAeQ4b7dXMqjhcTYHBKU2tdlBHjVBsXjA7PMDhYOOk0Z47yTql8V8AkaT9/R4Tk8pLTTiXrtC1lMZpoggngf29/tngGGuuzPeMatOACLrvOw0khQLKI2y9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WGQdWtezDeNuWakvhihrJKHUBPNvyBoYoNjY4p0b8Q=;
 b=xn1l89KIDr7lFgf3W8Jacou2Rttlvtggqoxzdl99Mp3CijCn5T/KcvqcUX34P7mLYxdPVS0sdyFip98HWWpzXD5uFyYtLI7Q6q7UtRAKvbic3iDnwaSNNyBQsSS/daUTMJvJzNYN21Lwd0a1XYpz8bnE7p6X6tfdx7SbHLPPyHngWSIKxRfYdpREedZN4b1WKPunpvQKUeI5pjKz2p1adXFCWuc93tixWKFBvKQFUR3XdSF3kacl9QmrZZjWr/Qo/y6E0GD++mY4/OfftKoz5MjlwQ0047TCHQlVw8n3+p0FiDAKrVLX5DJrDAiZePpfqz17HVyeLzFtz9/cjr/m6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM0PR04MB6819.eurprd04.prod.outlook.com (2603:10a6:208:17f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 20:51:12 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::21dc:8a5f:80a7:ad6b%6]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 20:51:12 +0000
Message-ID: <9f582ea7-d75b-43f8-9381-649c6bbbf622@suse.com>
Date:   Tue, 10 Oct 2023 07:20:58 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] btrfs-progs: move inode cache removal to rescue group
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1696826531.git.wqu@suse.com>
 <1d5cc97d664fc10c0244ff2c255f2fc4bbf58dfa.1696826531.git.wqu@suse.com>
 <20231009142314.GP28758@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJVBQkNOgemAAoJEMI9kfOh
 Jf6oapEH/3r/xcalNXMvyRODoprkDraOPbCnULLPNwwp4wLP0/nKXvAlhvRbDpyx1+Ht/3gW
 p+Klw+S9zBQemxu+6v5nX8zny8l7Q6nAM5InkLaD7U5OLRgJ0O1MNr/UTODIEVx3uzD2X6MR
 ECMigQxu9c3XKSELXVjTJYgRrEo8o2qb7xoInk4mlleji2rRrqBh1rS0pEexImWphJi+Xgp3
 dxRGHsNGEbJ5+9yK9Nc5r67EYG4bwm+06yVT8aQS58ZI22C/UeJpPwcsYrdABcisd7dddj4Q
 RhWiO4Iy5MTGUD7PdfIkQ40iRcQzVEL1BeidP8v8C4LVGmk4vD1wF6xTjQRKfXHOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJjTSJuBQkNOge/AAoJEMI9kfOhJf6o
 rq8H/3LJmWxL6KO2y/BgOMYDZaFWE3TtdrlIEG8YIDJzIYbNIyQ4lw61RR+0P4APKstsu5VJ
 9E3WR7vfxSiOmHCRIWPi32xwbkD5TwaA5m2uVg6xjb5wbdHm+OhdSBcw/fsg19aHQpsmh1/Q
 bjzGi56yfTxxt9R2WmFIxe6MIDzLlNw3JG42/ark2LOXywqFRnOHgFqxygoMKEG7OcGy5wJM
 AavA+Abj+6XoedYTwOKkwq+RX2hvXElLZbhYlE+npB1WsFYn1wJ22lHoZsuJCLba5lehI+//
 ShSsZT5Tlfgi92e9P7y+I/OzMvnBezAll+p/Ly2YczznKM5tV0gboCWeusM=
In-Reply-To: <20231009142314.GP28758@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0151.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d7::20) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM0PR04MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d099ca0-0b38-4090-16f4-08dbc90978a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7u5Bm4vbAG0BNbH/8c5iszXiWUck1T2K6RTtfoFmNTnBDid5bP4UEBH6dLHQmkQvkfKWB38HeHy3WuJrLCn50obztpE9jzHOMUGJ/D/r4tOsF8zGb4QuYIgsXrn5Zs9JEqFA/s98K5wgMNSWaaJ4/ODoR8rAHRXF+h1nS1qfGQfWx9Iksq2T0SX5WO0tMVNyt1kqhcHp7ReNoCtJ4Xk/v+qtPDsANx/hTvC21mEe7GWKvozalcofnZoPRvsJtYU7ZC/Suhoafty8ymPgpq69MhZDlWw7j4UP5H+ro2Gn31HBzorjSORIlT5iagXt5Rp86YfpvGpx0mbmWnQzogf8hlaAjMTuLBEWp7Z9mrgeV6hYvolbsRWud6zzmKyTVN8xZdjqZUzXlY5OitN36LP3XU6+xvuiUB2HO66pl+fF6NCGY2ZczFYQGhOeDoFxKCGTDvebzkVVQ7XtXJ0NRdo5U7zb8cu4muFBe8pcupV9vizgIGDRDq0hprJfRr8Lb3iZsvFxUgFh0VuKS0yRxPZSnVari1IIYI5T14Yrw4sQ3C71jpiXYs9Tnssle8/e5M6rDYBm4rSMRnICm/0FBD7beIRmKc4TQLXty20wZPdJRIfxtiEwJSLDT/bhEYnJRG7awCfWVpxTxm7v9EFYkPy2gGp+xGN3MOROdG4I98fmTB0U8C0kbB29ZlaBXKlWhDuCLdiKV5yQgzpZeMy6EOXAJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(31686004)(2616005)(26005)(53546011)(86362001)(36756003)(38100700002)(31696002)(83380400001)(4326008)(6506007)(6666004)(6512007)(478600001)(8676002)(2906002)(6486002)(8936002)(41300700001)(6916009)(5660300002)(316002)(66946007)(66476007)(66556008)(151823002)(45980500001)(43740500002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3g0bFpqbmhkTVQyZ0FTTDc5MnJuNDYxdkxWU3ZDVEdwRFdVcHJsdjJPUThm?=
 =?utf-8?B?em56L0pmdHNhTFFEV0p2dWVNUWlQKy9OUjBBNDVpMkdNVGtuMXMyV2s0UXl5?=
 =?utf-8?B?b2ZXK2JDK2JmV0JQWFVMK2wzYUN1Z3F6eGxaZnFkR0lUMFZsbjVZaFNjWldp?=
 =?utf-8?B?WEhMZTRpUXIzZ09Mc2NRdTlVOGhJV3hMMTMrVXE1VGIvbHdQS3Q1L2xlcDJF?=
 =?utf-8?B?OW9lMDV0YkVwSmhHSHBFbEk0V0dNUERCRDZjcktFZGpuMjdDVEp2UnJWQk5Y?=
 =?utf-8?B?UlRsTnI2dlVKSzcyZXcyelNFOHNuUDFDNFRoNlJycDdCZGZsNXpXbGVOc2gy?=
 =?utf-8?B?Q3dqM1Y1QjJ3a1JaTGt3S2ZwZDMxaFNOUXdKUG9ZUEZsMnZCZmI1dUpzVXJ3?=
 =?utf-8?B?MnVzYjlmOGRNU1NtZU9zTW1mSkVnbFNFMVBiQlVXcHF3b1NMZ1BIM0RLalZH?=
 =?utf-8?B?VU5iTTZNZnlKeEpZMmRzQnM4UmkvanQrRVpQdnNJZFJBNkhRMkttb0d1bS9B?=
 =?utf-8?B?ajZ0YU81MHZHWUNUZmp5YWk0dTgxMzAxVkRFc3YxNFZyMHZvNmNxWittNWph?=
 =?utf-8?B?OW54QXZsN09PZmQ4ekZtaDB0OUhiRlN1T2w4RjFPeU4rZG5Sd2RQVXliWGNa?=
 =?utf-8?B?N205bnlwZHhaWHVJWGcydUp3S3VmZms0cjh1VmtqR0ZTVjZVR2luUHFSYm05?=
 =?utf-8?B?V0R2dHhiMXdsZmcvWEh1b3BPbFkxSmpCeWJRMU9mZW1hbDJRZThmYUlDSkhl?=
 =?utf-8?B?YnN3QTZZanZ6cFVKU2FlUVR3SkQ0ZnpSM011TGdLUjdwSm1sVG5nTDVObUda?=
 =?utf-8?B?VUlQTGRSeUxtYkFPL2QwdWFmTjVNWFBXQTI1ZlUyNFd3RDFHcnB1ZG1mREZS?=
 =?utf-8?B?TE15L1ZqaC94ekY0ZHIxQWxnM3c2T1JrcEEwSWlBbFROY2VxTEtjNWVGdGEv?=
 =?utf-8?B?eTlJV2MzZWZYb3FYM254U2FGN3RMU2NYY1RrNlJiT3AxRnFScHA3bjk0N3Ar?=
 =?utf-8?B?SGc0Rk5kSm5XdzR3d2tDeUpmQWVWb1lNWkRHK0lVMlRSUDQrVFZaSjgwUWw5?=
 =?utf-8?B?VVhKNnZtVUZmeXpJM3FKSk5iY1RrSFFIUXZRVzkrZ1RIb0xZM2NVK1prdWQ5?=
 =?utf-8?B?UWlaNFFhZU9HcDFPU2trMWl1Wko4VDRPbFFNeHJxUzNhcGhhakdZZTZ1bHpx?=
 =?utf-8?B?Qm9wdU5OSUdMbkVqc0FrdXRaUDJjWE5sZUhXZ3pJQTViN01CSzNweXBZdzhW?=
 =?utf-8?B?YUF3aFVSdTBVcStoRVRJalBGa0MvNlhlQUN0djVZc3dEMDRPNXVDUTBYT2VK?=
 =?utf-8?B?ek16ZElpY2laMW5rOEdScm1NMUJqRGpjdUJhT2FKTjRqTkJuVjVxZHlhUE5K?=
 =?utf-8?B?cG5DWHRsdHdySGNjazRmQ2dVdEdWT20xRlBPak5wdnlpa3FvMmtZSTRIRHBI?=
 =?utf-8?B?OUZVZkNNLzEvWlhlTW1vY3BMd044QU9mdHlYRXJ6bUdsRGNWY1ZqNUhleThx?=
 =?utf-8?B?eFJPOGdtemZKYjNRenFsR0d0TVFZWmw3QlJkQ1NUSzVvU2htblZHeE93Z2NK?=
 =?utf-8?B?NDEvdlRudEdEc2xwZGZwZHRLR2tHcko5V0orVStUWGZRWGE0bFlMUFArTGhr?=
 =?utf-8?B?VDYvSEdJNFFHcUVyZ2VFWWliWmI1blU1T1ozaE4yWithTzBEYXNPcHFVeE90?=
 =?utf-8?B?OGs3WHN1V3RFK1BDZHdjTWE4Qll4cEFWSEMrQWZlT2NkblIwc2g0Z3pENk1S?=
 =?utf-8?B?R2JoSE83WVMrQlphTnlzaHNSelNXZWRpa1VGTGJBa0FJR3VRYzEyRU81U3dL?=
 =?utf-8?B?TElza3BlemVscE0xL05jd3ovTVpGYnp2bGFhMTFPTlVsSFdPV3I1SDdhYUNx?=
 =?utf-8?B?M2pKV0hUcFJmQVhVNy9qSzlUWm9VV2t0d2lzblVaRUlJa3IrL3ZlUkZRb0ZV?=
 =?utf-8?B?TDNoOGZXZXlSV3BuUmp3OENXSHBMYkE2ZnJ2dy8vQ2I5S1RZNE9Sbm1iT3N6?=
 =?utf-8?B?bVQ0WGhXeEJCeW8wWnlZY294eHRGelNLQ3hlNmlWamlDV0NhNXphaDkrT1gr?=
 =?utf-8?B?MzVrODNzcEh3Q2huaFUxdEFTemJQNDl0NTM5OXdmWDgyQUE1aFpBczY3K3Iw?=
 =?utf-8?Q?AKQo=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d099ca0-0b38-4090-16f4-08dbc90978a7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 20:51:12.2783
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/iAcJsP+2T6emitgi/M3R41GvxzP9GcJHmKgjy0xQpyNnUpkS8Da4UUO2h4Hjgi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6819
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/10 00:53, David Sterba wrote:
> On Mon, Oct 09, 2023 at 03:17:00PM +1030, Qu Wenruo wrote:
>> The option "--clear-ino-cache" is not really that suitable for "btrfs
>> check" group.
>>
>> Let's move it to "btrfs rescue" group to fix those small hiccups, just
>> like the existing "btrfs rescue fix-device-size" command.
>>
>> For now, "btrfs check --clear-ino-cache" would still work, with one
>> extra warning referring to "btrfs rescue clear-ino-cache".
>> This is mostly to reduce the surprise, and keep script users (I doubt if
>> there is any though) happy for now.
>>
>> In the next or two releases, we would fully remove the support in "btrfs
>> check" group.
>>
>> Another small change is, in the documents, we refer to the feature as
>> "inode map", which doesn't match with the mount option documents.
>> Since we're here, unify them to "inode cache" feature.
>>
>> Issue: #669
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
> 
> Please don't forget to add the new command to btrfs-completion. I've
> noticed 2 more were missing so it's done in a separate commit.
> 
>> ---
>>   Documentation/btrfs-check.rst  |  5 +++-
>>   Documentation/btrfs-rescue.rst |  6 ++++
>>   check/main.c                   |  1 +
>>   cmds/rescue.c                  | 52 ++++++++++++++++++++++++++++++++++
>>   4 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/btrfs-check.rst b/Documentation/btrfs-check.rst
>> index cf8de9fcc888..3c5f96f1951f 100644
>> --- a/Documentation/btrfs-check.rst
>> +++ b/Documentation/btrfs-check.rst
>> @@ -84,8 +84,11 @@ SAFE OR ADVISORY OPTIONS
>>           See also the *clear_cache* mount option.
>>   
>>   --clear-ino-cache
>> -        remove leftover items pertaining to the deprecated inode map feature
>> +        remove leftover items pertaining to the deprecated `inode cache` feature
>>   
>> +	.. warning::
>> +		This option is deprecated, please use `btrfs rescue clear-ino-cache`
>> +		instead, this option would be removed in the future eventually.
>>   
>>   DANGEROUS OPTIONS
>>   -----------------
>> diff --git a/Documentation/btrfs-rescue.rst b/Documentation/btrfs-rescue.rst
>> index 39d250cefa48..e99aa4ad8a7e 100644
>> --- a/Documentation/btrfs-rescue.rst
>> +++ b/Documentation/btrfs-rescue.rst
>> @@ -50,6 +50,12 @@ fix-device-size <device>
>>   
>>                   WARNING: CPU: 3 PID: 439 at fs/btrfs/ctree.h:1559 btrfs_update_device+0x1c5/0x1d0 [btrfs]
>>   
>> +clear-ino-cache <device>
>> +        Remove leftover items pertaining to the deprecated `inode cache` feature.
>> +
>> +	The `inode cache` feature (enabled by mount option "inode_cache") is
>> +	fully removed in v5.11 kernel.
>> +
>>   clear-uuid-tree <device>
>>           Clear UUID tree, so that kernel can re-generate it at next read-write
>>           mount.
>> diff --git a/check/main.c b/check/main.c
>> index 1174939fd6eb..7760511b85d9 100644
>> --- a/check/main.c
>> +++ b/check/main.c
>> @@ -10242,6 +10242,7 @@ static int cmd_check(const struct cmd_struct *cmd, int argc, char **argv)
>>   	}
>>   
>>   	if (clear_ino_cache) {
>> +		warning("--clear-ino-cache option is deprecated, please use \"btrfs rescue clear-ino-cache\" instead.")
> 
> No "." at the end of the text and the ";" is missing, does not
> compile.

My bad, I noticed the warning is missing thus added it in the last minute...

Do I need to resend or you have already fixed it during merge?

Thanks,
Qu
> 
>>   		ret = clear_ino_cache_items(gfs_info);
>>   		err = ret;
>>   		goto close_out;
>> diff --git a/cmds/rescue.c b/cmds/rescue.c
>> index be6f5016d5a9..38f4e1423434 100644
>> --- a/cmds/rescue.c
>> +++ b/cmds/rescue.c
>> @@ -34,6 +34,7 @@
>>   #include "common/utils.h"
>>   #include "common/help.h"
>>   #include "common/open-utils.h"
>> +#include "common/clear-cache.h"
>>   #include "cmds/commands.h"
>>   #include "cmds/rescue.h"
>>   
>> @@ -405,6 +406,56 @@ out:
>>   }
>>   static DEFINE_SIMPLE_COMMAND(rescue_clear_uuid_tree, "clear-uuid-tree");
>>   
>> +static const char * const cmd_rescue_clear_ino_cache_usage[] = {
>> +	"btrfs rescue clear-ino-cache <device>",
>> +	"remove leftover items pertaining to the deprecated inode cache feature",
>> +	NULL
>> +};
>> +
>> +static int cmd_rescue_clear_ino_cache(const struct cmd_struct *cmd,
>> +				      int argc, char **argv)
>> +{
>> +	struct open_ctree_args oca = { 0 };
>> +	struct btrfs_fs_info *fs_info;
>> +	char *devname;
>> +	int ret;
>> +
>> +	clean_args_no_options(cmd, argc, argv);
>> +
>> +	if (check_argc_exact(argc, 2))
>> +		return 1;
>> +
>> +	devname = argv[optind];
>> +	ret = check_mounted(devname);
>> +	if (ret < 0) {
>> +		errno = -ret;
>> +		error("could not check mount status: %m");
>> +		goto out;
>> +	} else if (ret) {
>> +		error("%s is currently mounted", devname);
>> +		ret = -EBUSY;
>> +		goto out;
>> +	}
>> +	oca.filename = devname;
>> +	oca.flags = OPEN_CTREE_WRITES;
>> +	fs_info = open_ctree_fs_info(&oca);
>> +	if (!fs_info) {
>> +		error("could not open btrfs");
>> +		ret = -EIO;
>> +		goto out;
>> +	}
>> +	ret = clear_ino_cache_items(fs_info);
>> +	if (ret < 0) {
>> +		errno = -ret;
>> +		error("failed to clear ino cache: %m");
>> +	} else {
>> +		pr_verbose(LOG_DEFAULT, "Successfully cleared ino cache");
>> +	}
>> +out:
>> +	return !!ret;
>> +}
>> +static DEFINE_SIMPLE_COMMAND(rescue_clear_ino_cache, "clear-ino-cache");
>> +
>>   static const char rescue_cmd_group_info[] =
>>   "toolbox for specific rescue operations";
>>   
>> @@ -416,6 +467,7 @@ static const struct cmd_group rescue_cmd_group = {
>>   		&cmd_struct_rescue_fix_device_size,
>>   		&cmd_struct_rescue_create_control_device,
>>   		&cmd_struct_rescue_clear_uuid_tree,
>> +		&cmd_struct_rescue_clear_ino_cache,
>>   		NULL
>>   	}
>>   };
>> -- 
>> 2.42.0
