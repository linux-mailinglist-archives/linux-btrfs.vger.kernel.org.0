Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDFB4C810E
	for <lists+linux-btrfs@lfdr.de>; Tue,  1 Mar 2022 03:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbiCACb0 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 21:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiCACb0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 21:31:26 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.109.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C035DA79
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Feb 2022 18:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1646101843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0leea32QjMW4bnNb1HuhCsYIL0vnn4Gp0lD6EwN1Ohs=;
        b=MEgA2ewULKteUsinu9W401ezAoH+BKgzzatilrpt4LXzg/mXI8LrqzWdox1wj3aCp6xOjs
        AGcx32sUZ+1sOIId1Bfk1vel6lG3rfT8R06/4HPSpoMsGEUhJXOXe5zc8GitgyOFyy490c
        8rmuXpsC+898tKnPFfISuT6eqkgmZvQ=
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2168.outbound.protection.outlook.com [104.47.17.168]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-27-2wp89VptOZmhDXA7Jok9DQ-1; Tue, 01 Mar 2022 03:30:42 +0100
X-MC-Unique: 2wp89VptOZmhDXA7Jok9DQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhcdRUJ80SducS4/sEB/kMIU7iDwHWqlj3E+h8mWapEkOUXdr1+6jYE54LrQqELJN3g6cLGNWH2KAI8hSAcaIkSWw9OQKkKYOpFgC20XxPoeWC/Y+dWoEM+oiY+Vp9fTFgj547jHKeKd79vDDzYNfWGIftYQmfnoUqyKEgYVTScvFBNzExg4uj8xtAs2fhg7/MURwNppx58o/qBLEzwtZTxJz8l0TRXyet9X3nizQsbG6c/nLmHSeV/UVS4vxkX2e6BBQXFd/piMMz8TPGvyZHIszeub3JUYFebnNuYr43qE1fYlbvqXSFdPakHPHuCIXZKFjWXzb/G8Wn8X2N+8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYJnyEa7OWs5tCy0P0ukwpJF2bbgEeAXlGqbsKrwpHo=;
 b=M24e2dteetva9W0AD0tq5jtVRrP6AaWWy9mJUmqs2z9Z9NdvhTcQ9i7M85vkXc2fdDmml/ZX153AsL8HAgyvSnLlgR/6XzIrbcjLsOR87+9DV6dnP78pPZzGZLK1Hsn6YFy5KMiqayX84BMcdTiL0grmUUIewIMw0RiyvxPcLOHpN6r/8B5LaZVntPuE06n1i3j9gQCaceePGH90slPExiAgIQ/CQ1RnptddVer4wEExxilF48cglvjWew9tneFEZVv6EWAqlA3xInuBWWU2T3YHSX8lLLIfRX78s1A0RLzhqpcE8nFenZnuam/pbJQItN0cF2JBfuLykdvij1OAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM0PR04MB4643.eurprd04.prod.outlook.com (2603:10a6:208:72::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 02:30:40 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.5017.025; Tue, 1 Mar 2022
 02:30:40 +0000
Message-ID: <66d31354-a6d1-01a0-3674-c4976bd7d557@suse.com>
Date:   Tue, 1 Mar 2022 10:30:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: BTRFS error (device dm-0): parent transid verify failed on
 1382301696 wanted 262166 found 22
Content-Language: en-US
To:     Christoph Anton Mitterer <calestyo@scientia.org>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <2dfcbc130c55cc6fd067b93752e90bd2b079baca.camel@scientia.org>
 <5eb2e0c2-307b-0361-2b64-631254cf936c@gmx.com>
 <f7270877b2f8503291d5517f22068a2f3829c959.camel@scientia.org>
 <ff871fa3-901f-1c30-c579-2546299482da@gmx.com>
 <22f7f0a5c02599c42748c82b990153bf49263512.camel@scientia.org>
 <edefb747-0033-717d-5383-f8c2f22efc8f@gmx.com>
 <74ccc4a0bbd181dd547c06b32be2b071612aeb85.camel@scientia.org>
 <d408c15d-60e2-0701-f1f1-e35087539ab3@gmx.com>
 <9049B0C3-5A30-4824-BCED-61AA9AC128E5@scientia.org>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <9049B0C3-5A30-4824-BCED-61AA9AC128E5@scientia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BY3PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::12) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9829f218-55a6-450c-97db-08d9fb2b79dc
X-MS-TrafficTypeDiagnostic: AM0PR04MB4643:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB46434E0092D485487C170F3BD6029@AM0PR04MB4643.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: csOhbAdTLY2F0F0nW3T5fRY0bMIq/pSfkjFAV8PDgbJ3bcDOmfUUB7cihlnxQxcLf6QQIXX6taOFL6WYrRtsSHVizzv4ZVARp7yR9cGprPW9jIWMLeR/n8Ei4WnHjxPh95h5FkRK1k1uxox9WU0vObT/5bfWFZ2aat1SWmMks3dUm0J0otXIJA4qANAy5btUixSn1AjHUGPMhm99AoMPLNR/GGrodKM6P+Q4rTIwHJ0U6f0YW8Z8yQr6/h/6wbPRHT3xOlyGI+Ergj79R/Un0CUBbRglbqXq56RrRObGxxVJQVzuOPlJRHqzErp/LeYMWNRyHrnBq3orw8JlI4upLuOfOEZb63rHoXgd8nIOuYz/VMKBb+cUz4F9o4797LzvqXPZxbwyntYAp4wQYsio0IkNGv40dbrm4J3qhQoLqxzqUYTYjpc55/DrHOHU9w3v4OH54ynV9bdSby8rSLKLEOtDYqpYF+wyyKm6JPlGEZ/9tDQrPE6xYezhAzMUZs6w/I0BYnQxZ2O8eIX5AwMGl4lenko7vNAH9pFji1XKzxX4yEIU0SyWUadtwDgyTqJWkFFJTknQD0Eo00/2Omgq95IRr/So6zHLOIRI0IbGqlsZ25mkSeJI2i6B+1hv+iOGwBQr3lI2zgWo+fM2mz/vCAEed9nJHD47ZDjxM+cg36lQaKcjyh6Q7I7EeEGu5AI45rkngLZwHmjA6ymt8E9bcD3LojRYeUPptgpOmfZFQ0s/+qorkAJCCY6WI3AFfrrqJZIQgs0H0nnXbehdAfYR+1GMq7F2o7+/agQk+YR3F9Qz9LCFZh7Ksizfzepxf4K+VV4KlzsX0jWNZg+R2KTsKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6486002)(2906002)(31696002)(15650500001)(5660300002)(38100700002)(86362001)(186003)(66946007)(66556008)(8676002)(83380400001)(66476007)(508600001)(36756003)(31686004)(66574015)(26005)(316002)(6512007)(53546011)(110136005)(6506007)(6666004)(2616005)(518174003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VIeiNRclBVy9RjtYCug14EBXNIKxB4JcGZJtVoWv6vYpjYYO3+IQXNHE3hAB?=
 =?us-ascii?Q?h5XEHz3WnxmQTJXD/mNe61Gao+3tZetRiaG1MWrXOKztEm4BeZxHiei+Adcc?=
 =?us-ascii?Q?MoGY+cQTMrEzmVHgpRWzC73UAJKO1XT32NYj7rgnSzRkLBnAc5lqQecnQPBD?=
 =?us-ascii?Q?8XWhLlB3Y4UYAgSWSNUUYrcXAWgj7CTEApinSACldMV/d32aQG2qt0Qkb5Dg?=
 =?us-ascii?Q?LzzEe29gfMb81R4m2gdqtyOek8a6pbQ19vy27HF56V3t8p5d7qMr2axlRcXG?=
 =?us-ascii?Q?oycmKCori8tFzmstfn6yvydUK0GzI0c0Bm8yeLoWBHwZhwe6y98FKbOaEmw+?=
 =?us-ascii?Q?OkA/wCE+YS8xfwvB8WbVOMPa5sM3k0NljPutu4uSjQi916lnWUixWeR7rc8Y?=
 =?us-ascii?Q?SUyKritITCxEGLmOulD/D10sTeemA9LmdyCbLk4QDS0+a49jqQeInKJqR2f6?=
 =?us-ascii?Q?m6kN2Bp9CyWPEDET9N+nfX/VfH3KU2HmOXWeJLg5OWpAQDgvQEII5+U8uZcB?=
 =?us-ascii?Q?tB9ovBLS2pyMRwgsOBMxlw1Pxpq+n/NTGqj4/mNpJmy48S2wXPDnRBb8CYw8?=
 =?us-ascii?Q?KHfpVT9T7p/T8rjt/vVgcwr+3eVsjv0WEQKcj3T6yp/qSuvwnr3NyBLyU3PK?=
 =?us-ascii?Q?eZIVOLHEGA5zEmjQV5LU7Ky5z5UmdodSFRwytw5iBN6kK4jfa3EFmOIB0s1w?=
 =?us-ascii?Q?PmbpqrDiCnkBUA1CZg7l3ztkbHnLR4ZQIpEYlVCUY5s6AYrwUrBK3DS8k4uZ?=
 =?us-ascii?Q?MYAsqsZ0H/PS9bT9djujZN+oy3T7zmMcCS+Tt7R32Z20Da4LnUE02EOaEZaY?=
 =?us-ascii?Q?nrSF+lzaRzQMc1N9jWW2G480mVCpLtM18YyKdPd4P71gCvNF/tWsmec+rvrO?=
 =?us-ascii?Q?vyLQfyMUzLtLgq5Inc7W3odZbXL/g5q2soxh/7PH5zxidgDpNgbNV0krpxzz?=
 =?us-ascii?Q?JgAedDTHJNfL0/O8Qp2PEVvLyA40d4yEX/vfbJhW0Kq9/lNAvlL+7OA2Elhx?=
 =?us-ascii?Q?ytHpxy2s9XKYuuvrXapsExImcktWRgM59jayfJmYiAIB52T3LAJ5e6BcWLX8?=
 =?us-ascii?Q?iQ2b0cA8fU3w+GX/vMiaiI2i1Ty+ZpEwKvf/BgPjLFFIKW06KGkwc1qMCUvi?=
 =?us-ascii?Q?n2rVZIjF3m52CqbAG1rW2O+iSnxWKltDipzg/Z8gj6j+7rzG6ESztbfWamM2?=
 =?us-ascii?Q?5Y1t7yOsezl9hJcnf3Vxw3FvcK1aC+rInoQoP4/qxACcSUHI0bYER8jKAbvv?=
 =?us-ascii?Q?67GACCpxGuXIYISNIWOwfh3NBaqmSCDOCXgZAl4y7SIBOBpOZUv7z8eFsWfX?=
 =?us-ascii?Q?y1f5GyT9jElL+cMdAAtiQ8rUKGo1LzgjPScndFPRQsXfTkUjTjjgceAyGleQ?=
 =?us-ascii?Q?6aG1L+TOpPUZzyQHQHUSS5Zcjl65iJeAQyBdS7cg7x1+cDPmq1U3o5VKgT1h?=
 =?us-ascii?Q?wvgUNn2/52ar4bhGcUXtMQVtqfzg2vSz7MoCYmHSOhtzB4uDoJx+douTwXFD?=
 =?us-ascii?Q?WIPwUoOyxj29F3BaW93XDQNXN2LphkgIssNn/hu1qdvYeiTKZL9pob0BmVf0?=
 =?us-ascii?Q?77lpDSqUQ1xFIJ3u4bQ=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9829f218-55a6-450c-97db-08d9fb2b79dc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 02:30:40.3175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g6F9EvcrftpEATabBeOlw4S/x2eUo6w5+5OJZsTFsfXxSi7JEXvAczsIKoDz+Rp5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4643
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/1 10:14, Christoph Anton Mitterer wrote:
> Hey.
>=20
> memtest[0] showed, that in fact memory is damaged in some higher region..=
. as you've guessed, its always a single but flip.

Btrfs is now a pretty good memtest tool too :)

>=20
>=20
>=20
> Am 1. M=C3=A4rz 2022 01:19:12 MEZ schrieb Qu Wenruo <quwenruo.btrfs@gmx.c=
om>:
>>> It would be interesting to see how much is actually affected,...
>>> shouldn't it be possible to run something like dd_rescue on it? I mean
>>> I'd probably get thousands of csum errors, but in the end it should
>>> show me how much of the file is gone.
>>
>> As said, no real file is damaged.
>> It's just we can get csum.
>=20
> Sure. I've had understood that. What I've meant was to find out how much =
of the file (or, if more were affected, which files) was not guaranteed to =
be integrity protected, because its csum data is broken.
>=20
>=20
>=20
>>> So would expect that the corruption or bit-flip would need to have
>>> happened at some point after it was first sent/received?
>>
>> I guess the corrupted csum tree block happen at that time.
>=20
> It's still a bit strange, though, because I most likely had run a scrub s=
ince then,  and no errors were found...
>=20
> But in principle, scrub should notice these corruptions in the csum tree,=
 shouldn't it?

In theory, it should, especially for csum tree with skinny metadata feature=
.

In that case we should do a tree search and locate that tree block.

But there is a catch, if the tree block is still cached in memory, we=20
may not do full comprehensive check on it and thus it may be a hole=20
allowing it to sneak in.

Anyway, I need more investigate to be sure on how this happened without=20
triggering scrub, and find a way to make btrfs a more robust memtester :)

Thanks,
Qu
>=20
>=20
>> And fortunately that range doesn't get much utilized thus later
>> read/write won't get interrupted by that corrupted tree block.
>=20
> That I don't understand. You mean the csum tree isn't read/written in tha=
t region (i.e. not unless the associated files are read)... and that's why =
it went so long unnoticed?
>=20
>=20
>=20
>>> Shouldn't I be able to find out simply by copying away each file (like
>>> what I did during yesterday's backup)?
>>
>> Yep, that's possible.
>>
>>> Or something like tar -cf /dev/null /
>>>
>>> Every file that tar cannot read should give an error, and I'd see which
>>> are affected?
>>
>> That's also a way.
>=20
> Ok... if both works to find out files are affected (in the sense that the=
y cannot be verified because the csum is broken... and thus may or may not =
be valid)... then I guess that's the easiest way for me to recover.
>=20
>=20
>=20
>>>> 1) Which logical bytenr range is in that csum tree block
>>>>
>>>> 2) Which files owns the logical bytenr range.
>>>
>>> Is this possible already with standard tools?
>>
>> We have tools for 2), "btrfs ins logical-resolve" to search for all the
>> files owning a logical bytenr range.
>=20
> So in principle,  since my tar yesterday brought no further errors,  the =
should result in only that one file.
>=20
>=20
>>> If I'd delete the affected file(s) would btrfs simply clear the broken
>>> csum block?
>>
>> Nope. That generation mismatch would prevent btrfs to do any
>> modification including CoW the tree block to a new location.
>=20
> Ah, OK.
>=20
>=20
> Thanks,
> Chris.
>=20
> [0] For those who haven't seen yet,  there's pcmemtest (https://github.co=
m/martinwhitaker/pcmemtest) which is a fork off (or based upon memtest86+).=
.. but with UEFI support, which memtest86+ cannot be used with.
>=20

