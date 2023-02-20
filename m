Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DA369C443
	for <lists+linux-btrfs@lfdr.de>; Mon, 20 Feb 2023 03:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjBTC5D (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 19 Feb 2023 21:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjBTC5C (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 19 Feb 2023 21:57:02 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2040.outbound.protection.outlook.com [40.107.6.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFA1B740
        for <linux-btrfs@vger.kernel.org>; Sun, 19 Feb 2023 18:56:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VRzA9XGTAI38AIJg6UpaczIWcZf7Ri/ARPKh6iHFGy4Y2vDlq8P0QbsHEA2xEmrPZJgxVaxYDgm6jM6XO3Gv9yfFiPXnwsTnXZmsKEWGelQ5f/cEZOUwbYHbYIz70RWaLfOTtmB5F6UBUOVKr+OFVrEhNFxNhEE5NK4sDRCbeisI0jaXYbQVYjz/hqjBsvkDWF5h11C/e5z/x4EkslTbaSbrX0eLdEZq7+9YulamTfEr4RiI9Ns87TjJXOrFEqcJEilCNRn0PaJjCbNRamJaKG1jRTRnWEEcQT/y5YkYbtvcA0ejIqKdIhAmfxZxcKsYZ0Qo+zrmsksRoq9KK0PaVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnxN1FyDzQaj2Ba5+PPJyvppmSBdFH2YWgmg1q3vrXE=;
 b=eaY6S4Hsn2B3yt0aPL56RxyddWGiI694Qhwox4gFO6K9hkGtkiKyWBKj2gF3IiGDjs/mfQd8T48It4n57Un6OtJnS0Bb/BALSpEjgh+vC5Pg0RNWLA4BoZPxSjRRvtPiiXeYqvyPcpO4lfrf8HF08iPMUkfH2fnja12PZZwZ+omaQ2IVhNZhn+s2DfsYVlf9KsbR/tXxxxyopfOCt+bDDFIgCTBm9bq5Lsbxx9kZef2Bop2R1ZsTMrB6OkGsBvb+1B7gSKrS6yi3ZkQGSHg1MewkYKJxeNTVscL8aoVL4jzD0ksHAxzg6vI5ep4wsXzQAEiQnTZl1KHt6KPIFhJJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnxN1FyDzQaj2Ba5+PPJyvppmSBdFH2YWgmg1q3vrXE=;
 b=bBKG/XtzP5aBiYDwuI7OEHnHe/AlPzYCnT7qu7TUQ7cYKBDQjtX0qBXLI69qivkzow7TV3P79zstmCc7w0g6caBPWiQgX+weubGi2JFJDzFX0IrKwD3DR9QSqEn/xiQLGnAY8HQbUvvtvd1R82rRtaoM03YhYtmSB7/wmCtmVfCiOnYj8scxghckvcqpxzooWNTjrJO2g1hNQ/wMkXgeTwrixeaD40fmihiiHjya3c88Q1hRp6hT27nCZ241p926n7OUxeNLcmUcxeIuh2feasdVfk6Co9+dXSWtDzWYrt6EG+/5ExDDQY8sWuhqmBTNmBpOyTCnYYzNdD7oDgbp/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by VI1PR04MB6926.eurprd04.prod.outlook.com (2603:10a6:803:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.18; Mon, 20 Feb
 2023 02:56:57 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::7bca:4b0c:401e:e1bb%3]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 02:56:57 +0000
Message-ID: <8b465081-65f7-4b97-a1bc-3c6b93d3b9c5@suse.com>
Date:   Mon, 20 Feb 2023 10:56:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2] btrfs: make dev-replace properly follow its read mode
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>
References: <da81abd638ca83237b8b50671e72793c498dddd9.1676802781.git.wqu@suse.com>
Content-Language: en-US
In-Reply-To: <da81abd638ca83237b8b50671e72793c498dddd9.1676802781.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0002.namprd07.prod.outlook.com
 (2603:10b6:510:5::7) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|VI1PR04MB6926:EE_
X-MS-Office365-Filtering-Correlation-Id: da2911bd-5a59-4d52-e1de-08db12ee2114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JLb1PgFesJgVih6dX2v5Fm3o2zUbBG/DdKQj/dTh5+Y/YF+u9Ht/0csQGjZcMDfO8LNvDRKmwhsQRJl5wSzhRnFB7n7XOuyjlbV1q2aN9FzEI+kOjdmKEgc8nA2BE4BuDGBPEXcLsvu/Sx7/BEAs68zfVVhE5MCU7NmRnuG7BSEYcFNulGfhe30gc7Us73xz2y50NOvmz1WYGHvrOlp9OPkNcrs//U/y8uEFx1UtRgcm/VESz+K+juUSSv7jAqin4haHmxM7s7ndu+JAc82JHek24bnK1v52w5LWzmkhwdLtuH6w2tm9dXThkdGTg5rwkdIZv+yO/1/PBEP7HKQ2U7xJK3tzwHOwFdMzBB+17q28WN2njfeT7lqG5xKO7BoqoYNEpapy88HuJe/4MAbs68JRkbz5iVMp1lP/zNk/wZI6iuqGP0S27Nyj6sfj0w30bxyBZ8zncdyBD/F3B1aXT9Od/5YqsPa1g7rPqowE4+QdT1k7kuVVGDvnss84qVLFp1aQC2G53B2l4cxIqmmLKtJUy6v/EKoz3X2x86jhA6MPR1djNi5aXdVapE5Hqbk62EwlPwCoe3FThXfl4TOGBcMnrzuQ6KCTglf70n/zdfgDKGDx2NyoSCAPGjFsP8WO8H8n3IAEl6l/WYIulmmd88kduuAprLKQ6n02zHYKH2IzYwfMt6hzXcUqp3caqQJbUjf5S4EOO0Y26r7tkpQ3R5L10nkl2a/EJmdOiQ1PPfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39850400004)(396003)(346002)(366004)(136003)(376002)(451199018)(8676002)(30864003)(478600001)(5660300002)(8936002)(41300700001)(2616005)(316002)(2906002)(6486002)(31686004)(6506007)(6666004)(186003)(6512007)(53546011)(6916009)(38100700002)(66946007)(66476007)(66556008)(86362001)(83380400001)(31696002)(36756003)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnAxQWRTMDBLbHRJYTAzeGZaN2szclQ0bXpLMTVJMDdVaTZnMzRJdlZEbTZq?=
 =?utf-8?B?TktyRHN4NHNOMEptNUpCNEZ0NVFhRnJuV2UzQTJycWU3V1kyaVhYRUViczlH?=
 =?utf-8?B?OEx4aERCRmUvMmlPT1psV1JOT3dhdFpKWjl0V1dvU2RBeVlqYktsbXZTSUVq?=
 =?utf-8?B?Vi93OWRRZDRmUUpybXg4ZWNFQ3pkWUxJSWJhaUhNeWdTWmxHSUJRNzZPZlFh?=
 =?utf-8?B?TVdjQkVjUlhzQ1pCcFdHd3VQWDVyY0x4enRQc3BzU2d3REcwK3pITWpyNURs?=
 =?utf-8?B?UlIwQkZHODZ6UmFWRG5FdExzTGlqNU00THNsVlBpbkJCbVNkS2VNa0o3REcy?=
 =?utf-8?B?YWFFZG01MHI2UjBScWdDV2t2VGpLVUZSaFh0SFVvS2RPMzBubVAwTkIxdkhY?=
 =?utf-8?B?aGJlK3Jhc2ovdTh1emRaVnI3SlJFbVNEZVY4andZNjE0LzJ2cnhoWHBnMlps?=
 =?utf-8?B?M1RTVCtmRHp4akt4d2ZyeGdhSXgrK2tDRzVCeFhhcUtOakRFZ2Nrb2lFUVRX?=
 =?utf-8?B?R3hHWGd5SjF3NGQ1UFQ2enErekdyb20ySGtKUUJZRUtnbkxSTURJYUZWRzZS?=
 =?utf-8?B?cHdTRytFeDVEZjcwb1hJS1Jzelo4ZEx6elRHNUw5U1lTcHJTL0NnczdSQVRI?=
 =?utf-8?B?cHZMVEN5N0JiWTBpeTlTY1NSclVpSGlCUTI5cjBxL1kySThSQ0h1d1ZrejRi?=
 =?utf-8?B?QW92ZlFOaXpMcXBvOWxiMzFvYW1xcFhsYWk0eTZVRC9LNnZnNUZ1VXAzYTVG?=
 =?utf-8?B?WFFGRDV1WHR1dnFWcWZldEVpcGhDcUV2UHlHMFlDSFE4TGt5WWJ4V3JzVmlF?=
 =?utf-8?B?aGVhdUZQVzlWOGYzM3NXaE50UURPU1BZRXdncmtMcDZ4Z0tKVUNvTmFvcHo1?=
 =?utf-8?B?bnhVcXdlSEhsVnhBYTdFTnpuMjloOEovTytWR1Uwb0FGdlpQeVR0MitUS2RP?=
 =?utf-8?B?bnJEeFp5eDdpeUFVWWJzb1lzNGYxN0wxQytGRXFiS3VQU28rUE5PdVZZUzFx?=
 =?utf-8?B?dW1oTnlGZVljTEtTU3FPRXozYkJnRXRkR1dZU1hpOUgvTmY1S2E3L3BEaFhP?=
 =?utf-8?B?Q29YcXhjRC9YT2krYVNOaTF6M0JoSlNnZEdJbUtpQ1VQTlJTSjRDTXBOc1N0?=
 =?utf-8?B?WTVLdnljL0p6Y0tpSXB6ek9VTnc2VmJkSnY0VmduanNMOVZRWU9jekZmSlgw?=
 =?utf-8?B?STJCWFJCaGpOazlHZHFDdlNHeW4yT3JyRkpqdXRiMHBjaWpYTllyMGlrTHlZ?=
 =?utf-8?B?QnRvT1RXRTZyRGFsazdxM3BuUUppWXYxSVJpVDN6SFZPL1huR2tuMUJmT093?=
 =?utf-8?B?SjNuQ1NaQUgyU1NKaFA1RGhqSGJTZUtrOVFqUy8yeHFhemhWRDZtSFJUeTFq?=
 =?utf-8?B?NnNpdVpLRHFzZmhSSnlyNFdRMHlEOU4rZEsrT3kzU2FxbExZNVRndU0rSSsz?=
 =?utf-8?B?UUtKb25jSldEaXVNcDRnTFJyemM0WTU2R2pOa29ycHdXckxCS3N0WnFiK2Fs?=
 =?utf-8?B?REFrR3NzZ2FtSm8xZ09ueW5ta09TZTN3MEkzNXRRV2dJRExkSUtIT0NUWG11?=
 =?utf-8?B?amFON08yMm5IejA4UC9nSGFoN0JOa0J3VzFVOXYzL1dqLzQwV1QzY2pnU2Fp?=
 =?utf-8?B?YmZOMUJ6WGtTbEViM1hhSVkwaXlseFFNOHpndEJ3NDlUL25NSmZSQmtXTnAr?=
 =?utf-8?B?eTkrbW1NTkJYOGIvYUREYXF0RjFSVHp2WEdaWjRSU05NTG1tQThZMDcrd2Zn?=
 =?utf-8?B?K3EzZXVnWTJDQXRpNHZZUE53WUNrWWJUSU96TEFkVklHNFNhbDNIRlB0ZSt1?=
 =?utf-8?B?VlBhQVpBZms0VHhkME9qQlNGOTB0NDQ5NG10YUhYT0I0ak1kMXQ3L0hkdFFw?=
 =?utf-8?B?U0lIZ2w3NmVDendrN2d2Tjdoc0l3TmZ4ekFNV3ZxZW1vQ2JGQUZrSWZ5RE1i?=
 =?utf-8?B?bitjazh3WWx5QWtBclVscTBKellOa3lyNi9BZ2V6bTFRRjhObEMxS0tvam10?=
 =?utf-8?B?QUJ1QjBsMjd0T2p0ZEtiVkEva0VmMGJuaG5LYmZwT0JCSmhYSmNQdWJqUkhT?=
 =?utf-8?B?cUJWVGlndmhJQzJoSzVMYlZwVjMrY215TkE5WmtEZTNreUh0SHNHS2tNRGJL?=
 =?utf-8?B?YnpZTTMycGhZdlh3YWlxbVZLTXNFU2dpNG92QW1rbUFsY2c4K2pvOVBwQnkz?=
 =?utf-8?Q?Ju3m3nrcSSzBBxuSiLcUAS8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da2911bd-5a59-4d52-e1de-08db12ee2114
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 02:56:57.0840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+R16ecMKR6cOuS84xFI4NgYPZko4lcaAOB1eszfhb25jlpiGskyF/uu4p0Nbu54
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6926
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/2/19 18:33, Qu Wenruo wrote:
> [BUG]
> Although dev replace ioctl has a way to specify the mode on whether we
> should read from the source device, it's not properly followed.
> 
>   # mkfs.btrfs -f -d raid1 -m raid1 $dev1 $dev2
>   # mount $dev1 $mnt
>   # xfs_io -f -c "pwrite 0 32M" $mnt/file
>   # sync
>   # btrfs replace start -r -f 1 $dev3 $mnt
> 
> And one extra trace is added to scrub_submit(), showing the detail about
> the bio:
> 
>             btrfs-1115669 [005] .....  5437.027093: scrub_submit.part.0: devid=1 logical=22036480 phy=22036480 len=16384
>             btrfs-1115669 [005] .....  5437.027372: scrub_submit.part.0: devid=1 logical=30457856 phy=30457856 len=32768
>             btrfs-1115669 [005] .....  5437.027440: scrub_submit.part.0: devid=1 logical=30507008 phy=30507008 len=49152
>             btrfs-1115669 [005] .....  5437.027487: scrub_submit.part.0: devid=1 logical=30605312 phy=30605312 len=32768
>             btrfs-1115669 [005] .....  5437.027556: scrub_submit.part.0: devid=1 logical=30703616 phy=30703616 len=65536
>             btrfs-1115669 [005] .....  5437.028186: scrub_submit.part.0: devid=1 logical=298844160 phy=298844160 len=131072
>             ...
>             btrfs-1115669 [005] .....  5437.076243: scrub_submit.part.0: devid=1 logical=322961408 phy=322961408 len=131072
>             btrfs-1115669 [005] .....  5437.076248: scrub_submit.part.0: devid=1 logical=323092480 phy=323092480 len=131072
> 
> One can see that all the read are submitted to devid 1, even we have
> specified "-r" option to avoid read from the source device.
> 
> [CAUSE]
> The dev-replace read mode is only set but not followed by scrub code
> at all.
> 
> In fact, only common read path is properly following the read mode,
> but scrub itself has its own read path, thus not following the mode.
> 
> [FIX]
> Here we enhance scrub_find_good_copy() to also follow the read mode.
> 
> The idea is pretty simple, in the first loop, we avoid the following
> devices:
> 
> - Missing devices
>    This is the existing condition
> 
> - The source device if the replace wants to avoid it.
> 
> And if above loop found no candidate (e.g. replace a single device),
> then we discard the 2nd condition, and try again.
> 
> Since we're here, also enhance the function scrub_find_good_copy() by:
> 
> - Remove the forward declaration
> 
> - Makes it return int
>    To indicates errors, e.g. no good mirror found.
> 
> - Add extra error messages
> 
> Now with the same trace, "btrfs replace start -r" works as expected:
> 
>             btrfs-1121013 [000] .....  5991.905971: scrub_submit.part.0: devid=2 logical=22036480 phy=1064960 len=16384
>             btrfs-1121013 [000] .....  5991.906276: scrub_submit.part.0: devid=2 logical=30457856 phy=9486336 len=32768
>             btrfs-1121013 [000] .....  5991.906365: scrub_submit.part.0: devid=2 logical=30507008 phy=9535488 len=49152
>             btrfs-1121013 [000] .....  5991.906423: scrub_submit.part.0: devid=2 logical=30605312 phy=9633792 len=32768
>             btrfs-1121013 [000] .....  5991.906504: scrub_submit.part.0: devid=2 logical=30703616 phy=9732096 len=65536
>             btrfs-1121013 [000] .....  5991.907314: scrub_submit.part.0: devid=2 logical=298844160 phy=277872640 len=131072
>             btrfs-1121013 [000] .....  5991.907575: scrub_submit.part.0: devid=2 logical=298975232 phy=278003712 len=131072
>             btrfs-1121013 [000] .....  5991.907822: scrub_submit.part.0: devid=2 logical=299106304 phy=278134784 len=131072
>             ...
>             btrfs-1121013 [000] .....  5991.947417: scrub_submit.part.0: devid=2 logical=318504960 phy=297533440 len=131072
>             btrfs-1121013 [000] .....  5991.947664: scrub_submit.part.0: devid=2 logical=318636032 phy=297664512 len=131072
>             btrfs-1121013 [000] .....  5991.947920: scrub_submit.part.0: devid=2 logical=318767104 phy=297795584 len=131072
> 
> Reviewed-by: Anand Jain <anand.jain@oracle.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Rename "replace read policy" to "replace read mode" in comments
>    This is avoid the confusion with the existing read policy.
>    No behavior change.
> ---
>   fs/btrfs/scrub.c | 131 +++++++++++++++++++++++++++++++++++------------
>   1 file changed, 97 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index ee3fe6c291fe..4c399a720bf1 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -423,11 +423,6 @@ static int scrub_sectors(struct scrub_ctx *sctx, u64 logical, u32 len,
>   static void scrub_bio_end_io(struct bio *bio);
>   static void scrub_bio_end_io_worker(struct work_struct *work);
>   static void scrub_block_complete(struct scrub_block *sblock);
> -static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
> -				 u64 extent_logical, u32 extent_len,
> -				 u64 *extent_physical,
> -				 struct btrfs_device **extent_dev,
> -				 int *extent_mirror_num);
>   static int scrub_add_sector_to_wr_bio(struct scrub_ctx *sctx,
>   				      struct scrub_sector *sector);
>   static void scrub_wr_submit(struct scrub_ctx *sctx);
> @@ -2709,6 +2704,93 @@ static int scrub_find_csum(struct scrub_ctx *sctx, u64 logical, u8 *csum)
>   	return 1;
>   }
>   
> +static bool should_use_device(struct btrfs_fs_info *fs_info,
> +			      struct btrfs_device *dev,
> +			      bool follow_replace_read_mode)
> +{
> +	struct btrfs_device *replace_srcdev = fs_info->dev_replace.srcdev;
> +	struct btrfs_device *replace_tgtdev = fs_info->dev_replace.tgtdev;
> +
> +	if (!dev->bdev)
> +		return false;
> +
> +	/*
> +	 * We're doing scrub/replace, if it's pure scrub, no tgtdev should be
> +	 * here.
> +	 * If it's replace, we're going to write data to tgtdev, thus the current
> +	 * data of the tgtdev is all garbage, thus we can not use it at all.
> +	 */
> +	if (dev == replace_tgtdev)
> +		return false;
> +
> +	/* No need to follow replace read policy, any existing device is fine. */
> +	if (!follow_replace_read_mode)
> +		return true;
> +
> +	/* Need to follow the policy. */
> +	if (fs_info->dev_replace.cont_reading_from_srcdev_mode ==
> +	    BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)
> +		return dev != replace_srcdev;
> +	return true;
> +}
> +static int scrub_find_good_copy(struct btrfs_fs_info *fs_info,
> +				u64 extent_logical, u32 extent_len,
> +				u64 *extent_physical,
> +				struct btrfs_device **extent_dev,
> +				int *extent_mirror_num)
> +{
> +	u64 mapped_length;
> +	struct btrfs_io_context *bioc = NULL;
> +	int ret;
> +	int i;
> +
> +	mapped_length = extent_len;
> +	ret = btrfs_map_block(fs_info, BTRFS_MAP_GET_READ_MIRRORS,
> +			      extent_logical, &mapped_length, &bioc, 0);
> +	if (ret || !bioc || mapped_length < extent_len) {
> +		btrfs_put_bioc(bioc);
> +		btrfs_err_rl(fs_info, "btrfs_map_block() failed for logical %llu: %d",
> +				extent_logical, ret);
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * First loop to exclude all missing devices and the source
> +	 * device if needed.
> +	 * And we don't want to use target device as mirror either,
> +	 * as we're doing the replace, the target device range
> +	 * contains nothing.
> +	 */
> +	for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
> +		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
> +
> +		if (!should_use_device(fs_info, stripe->dev, true))
> +			continue;
> +		goto found;
> +	}
> +	/*
> +	 * We didn't find any alternative mirrors, we have to break our
> +	 * replace read mode, or we can not read at all.
> +	 */
> +	for (i = 0; i < bioc->num_stripes - bioc->replace_nr_stripes; i++) {
> +		struct btrfs_io_stripe *stripe = &bioc->stripes[i];
> +
> +		if (!should_use_device(fs_info, stripe->dev, false))
> +			continue;
> +		goto found;
> +	}
> +
> +	btrfs_err_rl(fs_info, "failed to find any live mirror for logical %llu",
> +			extent_logical);
> +	return -EIO;
> +
> +found:
> +	*extent_physical = bioc->stripes[i].physical;
> +	*extent_mirror_num = i + 1;
> +	*extent_dev = bioc->stripes[i].dev;
> +	btrfs_put_bioc(bioc);
> +	return 0;
> +}
>   /* scrub extent tries to collect up to 64 kB for each bio */
>   static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>   			u64 logical, u32 len,
> @@ -2746,7 +2828,8 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>   	}
>   
>   	/*
> -	 * For dev-replace case, we can have @dev being a missing device.
> +	 * For dev-replace case, we can have @dev being a missing device, or
> +	 * we want to avoid read from the source device if possible.
>   	 * Regular scrub will avoid its execution on missing device at all,
>   	 * as that would trigger tons of read error.
>   	 *
> @@ -2754,9 +2837,14 @@ static int scrub_extent(struct scrub_ctx *sctx, struct map_lookup *map,
>   	 * increase unnecessarily.
>   	 * So here we change the read source to a good mirror.
>   	 */
> -	if (sctx->is_dev_replace && !dev->bdev)
> -		scrub_find_good_copy(sctx->fs_info, logical, len, &src_physical,
> -				     &src_dev, &src_mirror);
> +	if (sctx->is_dev_replace &&
> +	    (!dev->bdev || sctx->fs_info->dev_replace.cont_reading_from_srcdev_mode ==
> +	     BTRFS_DEV_REPLACE_ITEM_CONT_READING_FROM_SRCDEV_MODE_AVOID)) {

The check condition is not safe for RAID56.

For RAID56, the scrub_find_good_copy() won't return a good candidate at all.

Thus unfortunately for RAID56, we won't follow the avoid mode for now.
The proper way for RAID56 avoid mode is to go rebuild path instead, 
which is pretty different from the current code base.

I'll update the patch to exclude the RAID56 mode for now.

Thanks,
Qu

> +		ret = scrub_find_good_copy(sctx->fs_info, logical, len,
> +					   &src_physical, &src_dev, &src_mirror);
> +		if (ret < 0)
> +			return ret;
> +	}
>   	while (len) {
>   		u32 l = min(len, blocksize);
>   		int have_csum = 0;
> @@ -4544,28 +4632,3 @@ int btrfs_scrub_progress(struct btrfs_fs_info *fs_info, u64 devid,
>   
>   	return dev ? (sctx ? 0 : -ENOTCONN) : -ENODEV;
>   }
> -
> -static void scrub_find_good_copy(struct btrfs_fs_info *fs_info,
> -				 u64 extent_logical, u32 extent_len,
> -				 u64 *extent_physical,
> -				 struct btrfs_device **extent_dev,
> -				 int *extent_mirror_num)
> -{
> -	u64 mapped_length;
> -	struct btrfs_io_context *bioc = NULL;
> -	int ret;
> -
> -	mapped_length = extent_len;
> -	ret = btrfs_map_block(fs_info, BTRFS_MAP_READ, extent_logical,
> -			      &mapped_length, &bioc, 0);
> -	if (ret || !bioc || mapped_length < extent_len ||
> -	    !bioc->stripes[0].dev->bdev) {
> -		btrfs_put_bioc(bioc);
> -		return;
> -	}
> -
> -	*extent_physical = bioc->stripes[0].physical;
> -	*extent_mirror_num = bioc->mirror_num;
> -	*extent_dev = bioc->stripes[0].dev;
> -	btrfs_put_bioc(bioc);
> -}
