Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34597CD10E
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Oct 2023 01:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjJQXvW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 17 Oct 2023 19:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjJQXvU (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 17 Oct 2023 19:51:20 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2045.outbound.protection.outlook.com [40.107.247.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F626F1
        for <linux-btrfs@vger.kernel.org>; Tue, 17 Oct 2023 16:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtFmvAdbHLokkT3rm9n9gXR2Cguf2DeLLWYpfj4pWnNtVOGSK29mJm7GsaiFXNFJC87L7NFebX9N10rSAXpDhelyJNYj/4nYScHoj4S2cLhrOtGck8tvnRy8Hr+SQu0ijGA7BS8BB/VCEHorWi7MFMOYtqmkH62tg0RYbmYwPI9bOK/TfN47FuGPop50ayXdV553cEaljZHqYJbSpebwdPpXriG0I1s1WEwwtQ2UJjsxni7ee05D6JtA0UTqVC/msIRXmVc9wWVFt6glyBgKSZ+ktEnPa726hcg0HQK6FXyl64Lwb9pDCXxMoTtLyjY0rsHc1+3lHtDosVuhs6rhtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4VciJmZMLffI8euajAbpnrY5POrkk044N2HxRekFoqQ=;
 b=l4aWB+rxYDfOFO8zi+WuxORdAbUyZ/DvBPqRbq5ZDX4IoVtrUxcoGeR7S/kgRF/jrWm9MQdnwKw9DvgmAEZ4E8hO+TQwmfBITLGkJwXHMZyFLjTnGTNg0UpDeHIhO9Z9pkQmFsfZKskgfJq1mrS+SIyGuuMvzPywlZ6FXCOOqFf8i0F2B7STHYIlGDk4ODpZqFYPRbjilT7GU4a6OPSZ/E01cTKA+ekscnXswNjbMHqCLL7hhHcd0SMg2XkcEirLvRety6VjJy6z1GNmL9rPGd3ewAcvuephVIBJVIy6l3lbTJ9rC39oEoe08HWf+T8HFGn2YFq9Z0xtrieL0tkpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4VciJmZMLffI8euajAbpnrY5POrkk044N2HxRekFoqQ=;
 b=i509Y+dzR7pcpyZjIqB6zgL579ycal5L7IKASRhwRyHG65uK3SshtC8quGUmmpvJxfPurAFFnOjLHYQS45iyCz6UT+BcKsAv9wS1nLY9Fj4E4fESFeP9wZTPnODFjMycY9GEsuG8P03VfB1oRRJXVnrxL1A3xvQCjDdNvByoAv7Aa90FSwKbUblIu1tzJ2E/fV0S7xuSSWWqAlIwGmC+4/4rBMmBng7zqNkJq+k5iJj00cm3PazLt9pRJtvYXQBGa9ysC2O0p2OnRJvv3hiW3cKNYUsc8NUpFOwow3E7xiU1DOEozUnzfsGJDCeEyn1g8CteM9JVhdC6+xx24VGCKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by DUZPR04MB10061.eurprd04.prod.outlook.com (2603:10a6:10:4df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 23:51:15 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::bf90:3aaf:2ddd:20a5]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::bf90:3aaf:2ddd:20a5%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 23:51:15 +0000
Message-ID: <fd864ecf-5887-4b3f-94be-352b87fe29df@suse.com>
Date:   Wed, 18 Oct 2023 10:20:57 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] btrfs-progs: use a unified btrfs_make_subvol()
 implementation
Content-Language: en-US
To:     dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-btrfs@vger.kernel.org
References: <cover.1697430866.git.wqu@suse.com>
 <7b951f3a0619880f35f2490e2e251eb35e2f2292.1697430866.git.wqu@suse.com>
 <20231017134929.GA2350212@perftesting>
 <3df53251-41f6-4655-a0fe-a7baecb2a66d@gmx.com>
 <20231017231128.GA26353@twin.jikos.cz>
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
In-Reply-To: <20231017231128.GA26353@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0033.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1dc::16) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|DUZPR04MB10061:EE_
X-MS-Office365-Filtering-Correlation-Id: ae865b80-6fd2-4c1f-41b9-08dbcf6bf2cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3+xr91rAmo+/C2ER7aY+8W2jhLIDOPphIdK4ji/wgpVZOqBGEPF22Xep8MP0AoQjSU5q6cVbeG2/NTdzKP5iNOjVBJRwZaApvsR5F0iNBUVcY9c9HAEeCsZL9+es6a2rCillPhb2Dq+3bf/uezh2oHNu1z8/XibKwNVRtZes6bcfZhS1NB/WX4ORUsoGMjd/Lezlxmo9XxKh86tEbsn3XSZsetXPx2MzOxnVuFYnnsp9gBLxO+JglJtWkzz8ZK5LPDzhd+9Y4pFOL9o7Om6kY4YC5DO9x6Yv4FrQhB6d2TkVfcHqnSjF1ebY3/QZhck77ppCfcdOhSma6PiehM7P8d+kgzBnzrGv/z5YlZeJXN25MVHBVyikdoAfBa+SpJ1W7wqetCs5FHfQmoFHTAoTtptcoktMGC6ljPxte2icrSpYXWa2OeSkiqU46MWX3+Wv20yWzypOmlao+Xnht1nAbFD7cXDNpmiN7GcqUA54VxX2+7ESYocLwrfi1nNXTbdAS+hTJ0SL3TA35h++HX34QXC5pXb1f42nyqqmhy95Oi573IZUnFx5OXnqCr4gjgi8c9M2TSii5YS+mHOF9nf1yLQwJKIbU3Ge5S6Xgi35Gi7mTsZrryRFL4AD6pP0fJBbeLV+d7GWHs4gcu5Al6nbpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(396003)(346002)(136003)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6512007)(36756003)(31686004)(316002)(66476007)(66556008)(6916009)(31696002)(38100700002)(86362001)(66946007)(53546011)(83380400001)(8936002)(2616005)(26005)(6666004)(6506007)(2906002)(6486002)(478600001)(8676002)(4326008)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlVWd2dJSmVYMzQ2UmMxc0xtL050aitwQU95Q1ZNUjZXaHZzbjRvVXRGK0xG?=
 =?utf-8?B?RUNabUIrUm5rRHdONjZFVlczTHUxVmt5d1FsNDF3UjZ3UnMyV0lZOUNDOVE4?=
 =?utf-8?B?MjBzTGtxbWx0R08rTGR2WXpvWlB4cXdrZFpXYmRGalBMOWNwalYrejRIaDlr?=
 =?utf-8?B?eW5IVDdwQnJJUlBqOCtYcFpyeFkxSmlOWmpTUHlrTURQQi94c2lmMDkzYW56?=
 =?utf-8?B?bE5tR1V4RmNad2RyaE4wZjh3T3owdk5uS3c1ZUNhK0ZNdmgwZlRFL1ZVZE9T?=
 =?utf-8?B?V28rTEJ1UlEzT0ZPQ1cwclhzK1FUZDRsQUh0SCs3aEcreEdYeDlJZlpydzNV?=
 =?utf-8?B?SlFyRlU3RUtEMEE3dnpXelRrbHM5ZDlTaDBjQ1ZXQStoSE1jNGMrdm5ESkdj?=
 =?utf-8?B?dFhONTI2anFkb1JJbFhzaHpUbUV1Wmt5TzlrTWgxeUoyczlhSG93MG9MSjZG?=
 =?utf-8?B?RWpVNmloTGhtaHNyMjFOSTBkUWZMTVRSS1ZQY2lJa3paV1A5SXRjdFgzZFZa?=
 =?utf-8?B?TFpXbkQ2dWRPcm50ME1VNUhEYmZFTmczUjhVZExCVGRQcWhlYys3NXV6TUow?=
 =?utf-8?B?eEJEWkZoNHFGYktRNzZlWGY4emJuVjFXOE5wVUpOZTl4TDZXdzBIV1p6OFgy?=
 =?utf-8?B?RFl2c0hNakVMM2N0eEhaOFoyRXhIN29JU0dpV2k3MUR3REZabCtWY2taa1Qv?=
 =?utf-8?B?V3ZtOXNubzZEOXN6VlRWemRVbE92V3JXbEw1NTZNSUEyRU9ZZ2xoWE5PM3VH?=
 =?utf-8?B?RURmVUNPZ0NLYkdGSEJTOHNxZUEyTXU0RVE3U2IwWWViK3FPemdJVmtib3M5?=
 =?utf-8?B?Rjc3TWNXbnFENHEwOWZua0ZaaG5PcUFNMWFTWFhZZzV5aHF4Skgrb2ZCdmtL?=
 =?utf-8?B?ekdHWklPNWdoYXRVNEpXVURWM3hheGNHaDJ4ZTJ0ZXh2ZzVtRjVybENSaFZm?=
 =?utf-8?B?YU1jbitSQklFWGFTeWgybzlyTWJyeWRsb1V4VmQ5SkE5N3FGNytHSzB4ZHJp?=
 =?utf-8?B?UnZyMHJuQnBLVDBzQTNhMUxoVS9vMlZFeFo4ZTcxMzdrM3FtRDRjSmhtMFgx?=
 =?utf-8?B?d1JJcVoyYlhkNVVkYVB0ZjF3dHdVZVM1anpjYSsvVW5aYk5BVm9taWRUUHNY?=
 =?utf-8?B?TGo1Z1ZGYWlTN2ZraGhmWFovV0ZnQ2lsQmtTZEVsTkFDUEhha3BjN2dYazF5?=
 =?utf-8?B?dDdJYXpROHgyTnBtZGpleVlDWXZpUWMwYTV1ekZjYVhIekhLQzZBVkZqWklY?=
 =?utf-8?B?M2RUQ2NqbWlseDdtbHVBSGxLWUI3MTRPYjZaSVIyS1dQSzB0MU9EUHB4NWlm?=
 =?utf-8?B?RUlFNEtSOUZTRXhKRVdyNm43bVRDRzN5aUVPYjBFUjVCVTVJMTJ1TWM2bDFq?=
 =?utf-8?B?czNQcVRMdDJRZmtCSmQxek9TdE9TN0JzR2h0djVRd0NzVS8vaGJQWjNFUG0r?=
 =?utf-8?B?OVJqcVo4am1ZczVxNGtFUlBVcDhNK29wd1hhbnZVeHYrTHR1Q2kvNXNSakZ6?=
 =?utf-8?B?OGM5cHNKQ05BNmY1T1gxZWc4TlQ1anRsbFIwWUVUbjNSVG9pVUZhOE5YQk5V?=
 =?utf-8?B?MUsxL1hGbVM1anpKcm1zMmpRMmZSV2pNSmwwZlkzemVDUWlRZHBtYnZEQWYw?=
 =?utf-8?B?USt1QW45VjRMRzRISWVHZXZGaG5IRFg0ZkIvNnYyNDE3eEdpeVFoL0xkYWFL?=
 =?utf-8?B?WHlnRnMwU2ZGS0Rqa0U4L1EyUTdUMGRubVNIbWxLc1pGVDZkRHJTOVR0NDho?=
 =?utf-8?B?eVoyY05aZmN4amxPMXZYNG9PdldtWTM5THRQN1F6cnN2SGh5RWMyQ3FPclB2?=
 =?utf-8?B?dmh2Yk5BWTBKS2R1WGJKNFhHVUFoM1ptbGpYdmJQK3NiN2k5d0RZeGg5N1A0?=
 =?utf-8?B?RVdhN01hNmVLT1dGWXFHS05wTFRSbzFjRzZLNE5rN0M3S3AwUzZKdkxDR1hk?=
 =?utf-8?B?Ym9kRkY4VWFLWm9BWkVHaEZ4QVJzcVlTMExPcGJvN1VuMUpSVDZMTEtlTVk0?=
 =?utf-8?B?OVNCMnhyNTN2aE1wVm1HNGRMclNWZXA0MHVraHZTSFlwYkhZZ2xaN2x4cUc5?=
 =?utf-8?B?L1g3KzZLYjZsRStpL0ZqUFlFYUlPV25HQ2E2c1E0ZFJVRjNNQzhxZkw4QnVp?=
 =?utf-8?Q?oz/A=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae865b80-6fd2-4c1f-41b9-08dbcf6bf2cd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 23:51:14.7806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xQNTxspuDM47PJZ9v/T1TBbZ2x5HCSxF6RBavwAqu/f9fAno4Uy0GsVLVryewiFI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/18 09:41, David Sterba wrote:
> On Wed, Oct 18, 2023 at 06:44:22AM +1030, Qu Wenruo wrote:
>> On 2023/10/18 00:19, Josef Bacik wrote:
>>> On Mon, Oct 16, 2023 at 03:08:50PM +1030, Qu Wenruo wrote:
>>>> --- a/kernel-shared/ctree.h
>>>> +++ b/kernel-shared/ctree.h
>>>> @@ -1134,6 +1134,10 @@ int btrfs_update_root(struct btrfs_trans_handle *trans, struct btrfs_root
>>>>    		      *item);
>>>>    int btrfs_find_last_root(struct btrfs_root *root, u64 objectid, struct
>>>>    			 btrfs_root_item *item, struct btrfs_key *key);
>>>> +int btrfs_make_root_dir(struct btrfs_trans_handle *trans,
>>>> +			struct btrfs_root *root, u64 objectid);
>>>> +struct btrfs_root *btrfs_create_subvol(struct btrfs_trans_handle *trans,
>>>> +				       u64 objectid);
>>>>    /* dir-item.c */
>>>>    int btrfs_insert_dir_item(struct btrfs_trans_handle *trans, struct btrfs_root
>>>>    			  *root, const char *name, int name_len, u64 dir,
>>>> diff --git a/kernel-shared/root-tree.c b/kernel-shared/root-tree.c
>>>> index 33f9e4697b18..1fe7d535fdc7 100644
>>>> --- a/kernel-shared/root-tree.c
>>>> +++ b/kernel-shared/root-tree.c
>>>
>>> We're moving towards a world where kernel-shared will be an exact-ish copy of
>>> the kernel code.  Please put helpers like this in common/, I did this for
>>> several of the extent tree related helpers we need for fsck, this is a good fit
>>> for that.  Thanks,
>>
>> Sure, and this also reminds me to copy whatever we can from kernel.
> 
> I do syncs from kernel before a release but all the low hanging fruit is
> probably gone so it needs targeted updates.

For the immediate target it's btrfs_inode and involved VFS structures 
for inodes/dir entries.

In progs we don't have a structure to locate a unique inode (need both 
rootid and ino number), nor to do any path resolution.

This makes it almost impossible to proper sync the code.

But introduce btrfs_inode to btrfs-progs would also be a little 
overkilled, as we don't have that many users.
(Only the new --rootdir with --subvol combination).

But anyway, I'll keep the mindset of code syncing for the incoming 
feature, and hopefully to find some better ideas to sync them.

Thanks,
Qu
