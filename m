Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6597C8E92
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Oct 2023 22:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbjJMUx4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 Oct 2023 16:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjJMUxx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 Oct 2023 16:53:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48C3BF
        for <linux-btrfs@vger.kernel.org>; Fri, 13 Oct 2023 13:53:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q4eF9tKiPYcFMSKtTInfwB7+UBz2DaFAFoUp81HwAL4EigVPECg3Qibw9LCg0R+sT5mcUxqOIwPliJy/aVW+xHOLc1diCiNtrqh7At8jePw48rIkCvhoBfOGw4Wvi9BHbbUwpsuxeyeCAsrGCWLfJkMcLMg0xi5+x+5+xks9BRlRSydpwvKJ5AxGW95K756zrIYUvAdrxx7vm+xXyhDMG17o4PYsWo4hetRVrNlFKA4/21qHHNyzQFSqic9XhWCA5E0u//lLTru08vD4jfeBpvpYFwy91sxBGz2iPoW3Pd3i92TmJ4Mfg9SthNQwbPFgT7Rj2vh+jIrFJrdq6uiIsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtXwCpxiP+hs7up4QQuVu3HaNmOobLA4Ky7vc6BCrEI=;
 b=j6ceecGBI2i6hyUjJBKhkKrQFiMH6hUmQUz3rZ3Jt4AYzdNRYN9isUoWtu2ptF1MnwxoCFZbs8cEY3BScjJgJvDyUlJ0xSIjAFAiq6tBEfeXEWx6nJ+hkJHwzL7cKnlO2UJDuUgVw2x1QwpQJtJTsuOx/QT92oub1wa0X7F/J/kj3hX+h3VXhIzM58cS2IKY8E0qRhL8tXYiBnarJt1RrAl7lm9+X3xWUt2VW4a2PHdMXcR2DjlsEzmHgMLnEKCv9rcjFriHYdFagU1gDPKEmwg9Uh6Xiy0TjDtfCzAEqP9ulecd6kTRSWtind//0S5OZIvudeLvqVGGwDW5Ey5HIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtXwCpxiP+hs7up4QQuVu3HaNmOobLA4Ky7vc6BCrEI=;
 b=O7JdleQJRoCkBGlYbzoiDADo3UQ9u8x+ryIZtMHbCbofQiCf9Jt/qmubigP6I3tzyNouzjXG1uYo0G21oYWd/X65xB4WbazK1xm9+aC/k1P0ihIKjHtnDxulWhOs5g6hqmM9yoHq0/orEQE0lIdqDR7lAkkbbEspkK16EAQDZdeK6XHdWFSVY9YFRruku0IyEQik/R2qXjWZ3knDLQlPSFSK7ToYNYrf76ICK6R90S5gAfPvLdQ36R6F9GVsMqCMkfM6j5Q/rA98FeMYuN0+MPmmolIO+oOWdlNPgrmXg3c0NlHiuiVLzijAYP4mteVlzO4j4UK2knm+1+NBJ218VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AS8PR04MB9207.eurprd04.prod.outlook.com (2603:10a6:20b:44e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Fri, 13 Oct
 2023 20:53:47 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::bf90:3aaf:2ddd:20a5]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::bf90:3aaf:2ddd:20a5%6]) with mapi id 15.20.6863.043; Fri, 13 Oct 2023
 20:53:47 +0000
Message-ID: <b668cedc-560d-43da-a84d-d86acf1da756@suse.com>
Date:   Sat, 14 Oct 2023 07:23:33 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] btrfs-progs: cmds/tune: add set/clear features
Content-Language: en-US
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <cover.1693900169.git.wqu@suse.com>
 <20231013185023.GV2211@twin.jikos.cz>
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
In-Reply-To: <20231013185023.GV2211@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ME3P282CA0085.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:f6::18) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AS8PR04MB9207:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d8d7fc6-0f3d-47f1-6a04-08dbcc2e7eab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3iu3yAGmauIaLB1+V/OOK2Sy7FWa2TN8V6iQ7y3I0Bl0xkh4E2hhugzJNTj0jw1Wg7Q0NulHhiwVVXUAv06/MO5JV287Zj98OWXyIXl9YI4mok/jBmhki2pshT7/AUnjN/8PLErZXaaG8cehVWoLWs5owHjIljjVIqYbpsYUtaIkGJImVPx7m4fHcCv6J4TQFJRlsKCNav4oDsaFsOaY1vQrJ8zQfju4AK4tMsIRo+SnbksOVCYfSAL0KrZ3pv8OTU1rsLDYBeiu7+LWhBmdwG1BNy2JKVWtkCL76xuKtGrUOOnR0JpRVBNrnC4WOlIlkZxninrH0qH/mrFxk2jbJS/ekf79ZzXZWhJzeFgB5snv+4Y9BNkAtWacg+mKZgxbLeZUnS1Fssz4zLBF20wULsqiUoWn76qPzw+weOaHAr1bUxgm174BNB+2fL+ppKqll+3P39NV0aC5EzFOwV+CiPe53XuVIdJb2XYhrJmrPyMcYVT7VBE8E1dg1fAkpbyqjo/2ALQsOqmP5UdZpueneXzOhZBgsv0M6GlKtggGai/fQ56bpwK4ibMuOCdBV5hgl/sQ7DKC1p09DljpGxgHgtJGc1QjOnW8gik9RdScF9iO2YtKKEpywwvYbGvXvsJ5+0njnQh+EM9FsRcSoN3jRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6916009)(5660300002)(66476007)(66946007)(316002)(41300700001)(66556008)(31686004)(2906002)(8676002)(4326008)(8936002)(36756003)(83380400001)(6512007)(26005)(6486002)(2616005)(38100700002)(478600001)(6506007)(53546011)(86362001)(6666004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aSs1UWZXRjcyZUYwbjIvRkFKaWZuWFUzWnh6NE5GSVRtYzhGTWNRQmVOZVkv?=
 =?utf-8?B?N1o1cHg4b00rK0MydDUxZlYzUXVtdWNsWElkS1FPU1JwTUpyakJPNUVUSCti?=
 =?utf-8?B?RE03T1lOUDRhVmxCVzIrUlpQcy9JWTBnNGxCazlHSTY1Z3d5Mlc4SW1FK01C?=
 =?utf-8?B?aDhjdytPQTVROVdybzNvbTV5Rzhjd0ttaURpL1ZZNjlyeFp2UzVPVW1CZ21x?=
 =?utf-8?B?ek9HWjA4SFFSYjYzVmZleDBGQlRPd0lXWUgwaXM3Z0Ztc21mT0pYa0JJVzR1?=
 =?utf-8?B?Y2NndCtibVVNWGNpYUdJZ1RSZW9ieU1iSENtaThLajZTMzQyQzVkMkZXZ01T?=
 =?utf-8?B?RGtmYUVxQm9FRmRVZFNweHFRRFZkYURrZ210NUtUZE9NOVV6ZzN6bUQ0S3ZF?=
 =?utf-8?B?K3ZId2x5TWV2cnhpLzg2eDlzeXV3cEduOUUwVkdGUGRVS2ZMd1J6dmVHc0hx?=
 =?utf-8?B?S2crNWVWUHY1TnhwRjR5L0txR0xPN25qOHAzL0p6bTlZNmxIUWZGOXh4UnhD?=
 =?utf-8?B?eWxjU3pZNjFhNUluMXdvU1NZUmFYZDN2MkswZHN0S2krMUNIZkhvQXJnWjlJ?=
 =?utf-8?B?OHFUOWFPN1E0cjJmSkppeXV0OXI2ejhWOVRPUU5BbjFRRkE2SVhtQmF5cWF6?=
 =?utf-8?B?Q2dYZ3hZWFNuZC9TNndrWitxckt1NytZcTJoRGRqRUN2SHhhaDhhcWhrR29Y?=
 =?utf-8?B?aWVNOC9pejJJN242WkxyUFR0amVXTVp5aWZWdE9uc1d4REN6bmhCRmFxVzZO?=
 =?utf-8?B?akhDSVhGQi9CTzJRUXI4Y2VoMGNiM280b1ZRb0Rxb3BzakZVc0tIekFlcFFD?=
 =?utf-8?B?L1RDaFprMnA3UFIwT0E3MjRRUmN4UTJ5Q2lNbmVPZ05KUnl0V2dQTmZwT2xz?=
 =?utf-8?B?cm9jUGorV1VkTFo3bDUxdkQvb0dXeG02ZzdTVE1kSWYzSGFQaEl5MlNRZ05u?=
 =?utf-8?B?YlZaNncyZlk2a3RXckYwVHBId1IxQzFveHNFTFBaOG8vQUs3OHkvR0t1ZEZl?=
 =?utf-8?B?L2FudWcwdGh2a2pDTTArWVJxY0l5UXh4YWZnMGNuVktEWVNHajZ5WTRrTC9a?=
 =?utf-8?B?eWtVK2o3T0JTY29ac2F3Sk1HUmhUUVZCZWdnYWZlNFJESjIwbUgvQVZ3aDVL?=
 =?utf-8?B?N3kvdnYvOUF2SHdsN0JXTEh6MHJlUnIrL0dabFY5L3hGT3ZQWXJ6UkpLS1pQ?=
 =?utf-8?B?UkZjMXJTbUNnL3BFVC94STZLcE12OGU1b1BxRHErY2dRdGFEcVRIWFpXc3d2?=
 =?utf-8?B?TTBVcGZyaTA4a09hZzJTejA2bUtNcWJIUWxUendSNEI2Y2VRc2lTUEZNeHVo?=
 =?utf-8?B?V2h6UndLSnJpL1Q5Y21YazhrcnNxNTA4a2hKOGJZUkRSUzhrbFRBUkt2WGRG?=
 =?utf-8?B?bW14djBJeDAybHdiY2lTYjhGQjl4dlBSQ1BuMUZBSVA4Z21wNDVkL2xYZWh1?=
 =?utf-8?B?a1Blbm4xYndPQWRweERKMTZ6K0NBM0FCYXVscnpzVVkwdjc5OU42OHg0Y2s0?=
 =?utf-8?B?Z0NRRVlXcytYZXQyWjQzeHlZKzh4d1d5U215eThLSnFmTkF4SWY2emRnVXFt?=
 =?utf-8?B?WkpLTWVOelJIYVBSaDZjVDdqc0ppTE95dU9ZV3NVQWhRNzlUMFFXVGVqZlpL?=
 =?utf-8?B?dlp4aUNOWHdqK0E1YnluNHFDNmNKWFBzTmpmWW9sODJFOENRc3lpb1ltWEFD?=
 =?utf-8?B?bE9BNTVueWpFY1hyai8rcXY0K3lJZHF5US9oNmFzbG1HRnVad09LN3Q3WXlq?=
 =?utf-8?B?TzlGVVorUDFvMmpTSytVSUJ3NldWcEw3WVM1OXVXc2g3cUE0dmtjdytvRzE1?=
 =?utf-8?B?bjJMZVFzU0tGbTAraWNsaHZYMWZTaHhxR2xNN1lqTklWVmJpMitHUWZqZUpm?=
 =?utf-8?B?cEtYK0xMNnJDREF5cWdPamthdEJ6RCtoNTdFQjRheTJEYnlSR21YRDE3aVVY?=
 =?utf-8?B?cFU0RWdRWmFnYUZManhpMDJPc01vVnJzeWxrTExaamtFQUFTcG4waGxrdi9Y?=
 =?utf-8?B?QTdDYjRzbjIzRjFmWmhFTkY5TXB4NXRVdHV1Mmx2eFFLOXkreEJONTZ5VURZ?=
 =?utf-8?B?U2Z2V3ovWkliOXM3cmE4MVpnVDllMjV5ZjFCK3IzMmg3ZEVzZERJZEp3djFh?=
 =?utf-8?Q?poNw=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8d7fc6-0f3d-47f1-6a04-08dbcc2e7eab
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 20:53:47.4680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ux7OkAdWWQLmrfdGqTfrH82OB24/Psvq6GL4ihIoqp1etl8/bQRA3Qa+Ky7CnF54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9207
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/14 05:20, David Sterba wrote:
> On Tue, Sep 05, 2023 at 03:51:42PM +0800, Qu Wenruo wrote:
>> This is the first step to convert btrfstune functionality to "btrfs
>> tune" subcommand group.
>>
>> For now only binary features, aka set and clear, is supported,
>> thus uuid and csum change is not yet implemented.
>> (Both need their own subcommand groups other than set/clear groups)
> 
> There are the easy on/off features that can be added first but you also
> added the block-group-tree _conversion_. That's a different category and
> IMHO requires a separate command so we can add options to check or reset
> the unfinished state. And we also have the the conversion 'to' and
> 'from'.
> 
> My current list of 1st level command groups is:
> 
> - enable - for the simple on/off features (on)
> - disable - dtto, (off)
> - convert-to - for the BGT, checksum
> - convert-from - subset where the back conversion like BGT may make sense

So your idea is, if an conversion is a long running one, and can be 
interrupted, then we need to go convert instead of simple on/off?

That makes sense, although my question is, does that makes any difference?

If we have an interrupted conversion, the only valid operation we can do 
is to finish the conversion. No rollback for most conversions.

Thus in the end, it's sill on/off, just with an extra interrupted 
status, but that status can only lead to the "on" state, thus it makes 
no difference to have an dedicated state for it.

Thanks,
Qu

> - analyze - go through the structures and identify features (all, subset)
> 
> We can add aliases like set for enable and clear for disable, the two
> conversion commands may not be necessary or even confusing when it's not
> clear which direction is the right one.
> 
> Actions:
> 
> - extref (on/off)
> - skinny-metadata (on/off)
> - no-holes (on)
> - seeding (on/off)
> - uuid rewrite (one time)
> - metadata_uuid (set value)
> - change checksum (convert-to)
> - currently there's the simple quota, this may change
> 
> This should give examples of all categories of actions we might have in
> the future.
> 
>> And even for set/clear, there is some changes to btrfstune:
>>
>> - Merge seed feature into set/clear
>>    To enable seeding, just go "btrfs tune set seed <device>".
>>
>> - All supported features can be checked by "list-all" feature
>>    Please note that, "btrfs tune set list-all" and
>>    "btrfs tune clear list-all" will have different output.
> 
> As the help test works, we would get that for free if all the
> implemented actions are also command names, i.e. 'btrfs tune convert-to'
> would list 'block-group-tree'.
