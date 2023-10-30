Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9946D7DC114
	for <lists+linux-btrfs@lfdr.de>; Mon, 30 Oct 2023 21:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjJ3UVY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 30 Oct 2023 16:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjJ3UVW (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 30 Oct 2023 16:21:22 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287F7F9
        for <linux-btrfs@vger.kernel.org>; Mon, 30 Oct 2023 13:21:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kYno2UfwLI7ZHRXPfSETuizuMzkDLWyqAv+eecWc4WsqdWtTg5GvjE9Mxu64LGEhLMMYdw50GwxbnRqyj2SbhLxW5lo7ktvlSXjLYF7f+9DcGS08PDUTua9NPp0SIj2voJAWhdaMS9vcQIu+J+kHNg32RLk/kJDwxicrCK45SRoBJHOtF3XqUFjCFroYf6q2Z7vXu8HlV9PmVTFwzHjfL1yOAKd2Tq5zk6A3AWbzqrdxsQV4BmUm97qbzgtQrXYXDqC1+h15Cf0OorsYB2tDHLza8VDACWjCg8M8x8sy81AjJgLV937gVN3RT+GJXY0r7aW0rxEwHvq5t4ovfXlfuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yAGOBq+YSSFEaU/nSaybqyyXXKnxSvQlMc/Yws9cdzU=;
 b=Ca+HfzxX5uzEKa4aphWm6ZfewQRTc3z5MOErLBEUa5dkL13hTxrA+7Vro7M9Uu+qy6cUOMBBujdxC0dFI/ct3UcpzirRISIT9LWBq9FV6zl94JwGy6CHPON6tnhMpLtLHv2rxAS8FPOM+ClXdfwhxhX08OHuCUSKfmq3XE46At8wq6DfPmJWMvg8KPru5tV84Dtru1MeCybRnTL6aAzy14BqIf9KZPrIPB8//naW9/XSHVirDfDqxY9UT0zTNRlyBhWHKpMuj3c4wUGz8bihuoYgRR7FLt/fJPClenRbSecoZhcMmayH/Oe4rUQUW21UQpgLG7JcQKhqrr41s/av4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAGOBq+YSSFEaU/nSaybqyyXXKnxSvQlMc/Yws9cdzU=;
 b=KkIU/4OQMJXzdBeTnYhv12zyDMR02R29HfXb8cQvPaXEperqYldr7iHcOBarxQ0I61HckJXZu9xyVW1/7u/rfkV6BoSp3e2oq44OuovMno1t0Nk8E0bA8rXgXwO1CNsH6RIBfRB+/kwNXumksY/N1hp87TeaNKv5bDD0OcVjJ380NtcrtbqtB/hY7UfGPGVQo9ViNPA/Z1Zg+gMpMuwzrH7WOGleoX5Pv1ahJ5Y6dZfQBR9KuzeSeLHhy9pT0iS7uVQB2QLquEoBExTouCwM0/ly1De8P1ZQEO+yOCp9xfOLC/lkn5KwqhNhkcCfmsrvrk7EoKow+2xusjoWozFc+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com (2603:10a6:20b:348::19)
 by AM7PR04MB7189.eurprd04.prod.outlook.com (2603:10a6:20b:116::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.18; Mon, 30 Oct
 2023 20:21:17 +0000
Received: from AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::46d9:6544:503:c37e]) by AS8PR04MB8465.eurprd04.prod.outlook.com
 ([fe80::46d9:6544:503:c37e%4]) with mapi id 15.20.6954.016; Mon, 30 Oct 2023
 20:21:17 +0000
Message-ID: <61029842-ad3d-4561-9493-bc042f254809@suse.com>
Date:   Tue, 31 Oct 2023 06:51:08 +1030
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs-progs: remove unused functions
To:     dsterba@suse.cz
Cc:     linux-btrfs@vger.kernel.org
References: <d4d0bb2c6fb0ad0a3666e9e0a78e432634f58a0d.1698452036.git.wqu@suse.com>
 <20231030140646.GB21328@twin.jikos.cz>
Content-Language: en-US
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
In-Reply-To: <20231030140646.GB21328@twin.jikos.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MEWP282CA0152.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:1d7::18) To AS8PR04MB8465.eurprd04.prod.outlook.com
 (2603:10a6:20b:348::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8465:EE_|AM7PR04MB7189:EE_
X-MS-Office365-Filtering-Correlation-Id: b6c33c23-67d5-46cf-3982-08dbd985c569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gRBN3kwl7Tmy7CQw6v68nMLlR5DkHqlctPMa1xtDfaFYi60V7yzUg/8/lrXjTcwRWEEg10yfpsmTCxtioNPi17p8NnWXA/LYnzSml+BKd91ra4IW+s+igXoOS3fuYkwzTkG2dEAJ0Y70xSfz1MYjVtEcwpYVkeqEyZs5WMlWzx0vMr4B7v9h+ShhnXm2u5yDiOuJf6xEj7W8l5zB12uKY+TYSoxG3GCAfg7H4AY46V6NQM5aUj3F8rWdgZfkBoEwXDpD31Ex8/dP7a5/xgDv5ikCrrNczFyn757ADfsMky4c7qDG7aoP+HhnNJ0u1f8L/YgnP3CdSxAYBr5FcdayaXu3CeMIy+IrI9etRUeAcbPZAL60tsbYJ/97TyTIpkyBrDAhHjbmyTZl7L9q6oD7blW+AU8/UPj4vrGx8XMDlXm90kqmbwYymzWZNjrHdGs6N60mFl7NDQeWeR7t7y53LsZge82Pcb3ILTGKxMaZbFb+vE8K0vYVbsqSL2NOzNaEye+37lnwijfV+cpoa1IZ/T2V1nHFQ/YVHHXyu448uQGEP5mQ/Oul8Xx17nTCLjVsLjfQoV/t8VcknxT0+CUqcadGE0kiv5rYdUGQpAfncMys0Si2Khu79arTszqFtU6A4f5zikGUklFrQz/VBpKWx3KDcDTxl3lh9Uk8O15l7vd73dSU7OxIzzKmu41MEq+H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8465.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(136003)(376002)(366004)(230922051799003)(230273577357003)(230173577357003)(186009)(64100799003)(451199024)(1800799009)(6916009)(2906002)(6666004)(316002)(66476007)(66556008)(8936002)(8676002)(6486002)(66946007)(4326008)(478600001)(86362001)(31696002)(5660300002)(41300700001)(38100700002)(36756003)(83380400001)(6506007)(2616005)(26005)(6512007)(53546011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEdudkZVeWhabHJmb2Rxd1AzcU9OblBQOU54NWVGZ3FJbXJ0Njg4bDVYOVht?=
 =?utf-8?B?MDl2SE9LRm9xMXAwLzdDLzRuZHNuYUV3cXl0aDNuL0lRUC9DNjRiWVhYU1Jp?=
 =?utf-8?B?Z3U2MElmTzBPZisvWTVrdTBIVU4vSWdtbHdYUkJrOWpSY1diSEoyUGE0UFpC?=
 =?utf-8?B?MHNaWnpuMVpuOVcybEVVYWQ4RGF5NnZETGFuTXMwUjFHek1KeVRuNnBJc09t?=
 =?utf-8?B?YmJlQlExTkJrblE1MWNYaGdDbk9HMWd4Tk9XWlErRUprSkhhQkhhVTVLSVYy?=
 =?utf-8?B?aWZZcktVQXFRTktHc0dTOXBOZTJJOHgvUjNpeHVJczZGc2tXOEFhTG43UHpk?=
 =?utf-8?B?SDIrS3YzR2tUckErdjZvYWpreHo3VS81T285R2txdDNMcm5RcEFsaHJUUGJC?=
 =?utf-8?B?SkNTVzl5NzltVzBocGE0TFZCYk5HRE1sMW1VVStSSUpEam83V2pYbkt0elBl?=
 =?utf-8?B?K2tkQURmeEJzQlZZR05MU2pOMFBiTmt4bWZNSlo3YmxzYmNNdlFPTE11THZS?=
 =?utf-8?B?bjZmOUxEV1ZhUURXamRzUXN1TEZTbGpBdXFmRnJJSUF1MHphYzRNVFNMWFpk?=
 =?utf-8?B?dVlMbm1FMDZoM3pHZGlnWHBjbFdJbmF1OUdhZnkwQlhIUGhFaG1YS09wTXh5?=
 =?utf-8?B?VkFEYURyek5wL21YTWV4SkZUMDZNR0FrcGF6YWo3UlVSTnVkMUhndGF3Rk15?=
 =?utf-8?B?c3orb280RTkwaEFOVUpNYTZaZExJVk8yb2lndjdzaVpDT2loVDFRQXVWRjJw?=
 =?utf-8?B?eVpydGVhSmdDblFmc3E5cTNYLzBrTmFaNE43b09ZcXJwdUdQZ3dXZjNONndi?=
 =?utf-8?B?UU81c09qSldZZVpleWRCNHp3K0JRa0ZQZ0tIYjl0M1hBYmxnenFBbWpzK0xE?=
 =?utf-8?B?UEYyM0tORVZQYUJoZlgyRTFRam1KTUEzMVREVU5KY1p6WDJUZWNiS2pqYkNG?=
 =?utf-8?B?ZEpUM3R1R2U1Q0xBbUtsUW4wbVJVNjJQUUJrOGE0ZFQ1QUxHeWo1TjgySnVU?=
 =?utf-8?B?MnExUGUxVWNQTEN0dUl0dG5zZmo3QTBZYkdqZkhqNUFzVk5UMThablpMWTNT?=
 =?utf-8?B?Y2hjVDlINWJITEVUUWxMSjRuZW16VW55NE05c3owN0R5emhjVHRkM2xoVWxn?=
 =?utf-8?B?T1BTdkIwcWxaWkE3Q1ppbnhIZEw4SEwxYURhblk3VURXcEJiTk10T3VyM2Uw?=
 =?utf-8?B?K1FxUXJHenNGM2xUSXQxWWZVb1ROZ09BMkQ5SlQ4QjAvcHJ1bnk3QU0xZmRw?=
 =?utf-8?B?T1gwWGt1L3VkZS93SFl5M1A3c2JoT2Q0VEJaRjJaV3BpdHdlSGVBRXhYTHBM?=
 =?utf-8?B?dmY5TThiUXROcE1kR1JzSkJUV0g1NGpRanhZaVhRVE1GVTREd1ZGNStaNFBQ?=
 =?utf-8?B?VjV6d0JpN1BMckVFZ1I3SXh2UGtUWkR4NTNjdlBHTUFmN0NmQXcyenYzSjRG?=
 =?utf-8?B?aWVkMGd2bFhRWUp4SFdoaHZzUHZWb2hOWGxtVTBNY0lUT2JyOVQ0YTRSaXNn?=
 =?utf-8?B?MHJjbVF5MG41aHExR21MT3RtbWI0aElpSHJ4Ti9IRzBMdEV1VENYM0Z3QSt0?=
 =?utf-8?B?TTRtQjA2L3hybXlGa095THZQQ3paSTZtYTZQVmhmOUhrRFVaSDdZVm5YSmdN?=
 =?utf-8?B?ZnFHaHVQWENpWmN4aStIZDBqYWZNOVI5NVlDV0lkelhtTXlReXVreDdLMm1L?=
 =?utf-8?B?Nzl3M0xsbkhqN2p3UVBvcC9hdXc1NG1YOG5Jd1QyeDdCSGtCdnBVTTZjSldx?=
 =?utf-8?B?M21yTVZYZ0F0WnAyak9pVURqSElvVUJNWko5cS81WjVPWW1YL1lXdVlqZHRa?=
 =?utf-8?B?M2hna3o4QXBkQVBKWHViL2xZUkwxdVNjZ2RJblM2a29hdG16Q1c1aVhBOFNZ?=
 =?utf-8?B?UllnNmNTSU91WWx1bzc4SUdxcWNQSm1wa2V6RnBLWUl0aUNBa2RrUThzL0V0?=
 =?utf-8?B?YlFzRDVJNGkxMnUrVFl3c2l4RU5RTFB0dHFOVHJmZWRENEZjYmJ6Uzl1aTdR?=
 =?utf-8?B?MnhuVFc5KytrZGg4Nmd4TXpvLzFRdmp0RzYwdUF0aTVkSWZoSXdxTEpUMGxV?=
 =?utf-8?B?aGM3WUZneGxpRks2c2NlQ2FPR1lpYUhSOTFYS1B2YUg4OHZzVU84MER2TW5M?=
 =?utf-8?Q?K+C8=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c33c23-67d5-46cf-3982-08dbd985c569
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8465.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 20:21:17.0181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3s6POrs0b+BzAXsz2PwI1UFcWIApytKsXCBN/FstXR7Go4Me8GJu/U6YC0zRr1q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7189
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2023/10/31 00:36, David Sterba wrote:
> On Sat, Oct 28, 2023 at 10:43:59AM +1030, Qu Wenruo wrote:
>> When compiling with clang 16.0.6, there are the following unused
>> functions get reported.
>>
>> - memmove_leaf_data()
>> - copy_leaf_data()
>> - memmove_leaf_items()
>> - copy_leaf_items()
>>    Those are replaced by memmove/memcopy_extent_buffer().
>>    Thus they can be removed safely.
> 
> The files in kernel-shared directory could have unused functions due to
> the file-to-file sync, so as long as the function exists in kernel then
> it should say in progs too. I was looking for some linker tricks to
> remove them from the final binary, but the resulting binaries increased
> the size (it's either function sections with garbage collection or LTO).
> 
> The warnings could be suppressed on a case by case basis by some
> function attribute like __maybe_unused eventually.

Indeed, I forgot they can be synced from kernel.

But at the same time, I can also argue that, if they are not utilized at 
all, there is no need to sync them at the moment.

Thanks,
Qu
> 
>> - btrfs_inode_combine_flags()
>>    This is only utilized by kernel for vfs inode structure, meanwhile
>>    it's totally unused in progs as we don't have inode structure at all.
>>    Thus it can be removed safely.
> 
> Yeah same, if it's in kernel then it should stay.
> 
>> - LOADU64() from blake2b-avx2.c
>>    This is only utilized by the fallback implementation of
>>    DECLARE_MESSAGE_WORD().
>>    We can move it it just before the fallback implementation.
> 
> Ok.
