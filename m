Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099364CFCCE
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 12:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbiCGL3b (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 06:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243124AbiCGL3X (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 06:29:23 -0500
Received: from de-smtp-delivery-102.mimecast.com (de-smtp-delivery-102.mimecast.com [194.104.111.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339B55B3CE
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 03:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1646651529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zl+sn/SuPoQzy6BsHQhWMh7jzJMe7Vm9Pahm9aSu2MY=;
        b=lJhF0SdaeM0lczN7iJLwNmeQibsnME53WffUD3If9rrItVMc+Pv0ObgAVkukH5yVRgllJz
        KGRd7pvkrTbN+Cl5LMuRAtexQT9gpDDtRnHhog9gfxBdaoEGPlG3duvhl8KR8NyzjTtVKE
        ShO/7mkCYbkaS0XiZCmfkqS4FLMfI+k=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2055.outbound.protection.outlook.com [104.47.12.55]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-16-oSAZEKa4MJqOt7Ggm6GaUQ-1; Mon, 07 Mar 2022 12:12:07 +0100
X-MC-Unique: oSAZEKa4MJqOt7Ggm6GaUQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAHS+Z6VUTeX6IXZL3BsTGc5rDIdrFmvaeKLk/ZhUmEt2+yZZapowYlE34L2ih4we3WRDptoURV8c0S6/679Cl4evegQf9vl+RiXaUBfp3Z2jCAaPmEUbqhGGHewAkjOq9MJxglePZutL0tCHfslXwjx4qjdZRBwC8KeNdEh/PcSGEN+ck62/8cpC4SWYv4EuecR8WMK7TD+Vae+UztMoeFRcPGPB1w1qTISeTGLaSDhdT7OoV0JdcZOoG8lIF46ZzOl8Rmo+B+e0ItUQRcy/O6YXmLOJRSe9Qy3DJqHjviITkIJDUxgSXzaLG36kRm5qxAcLpjORLDoWYt9a8SyEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzhKctEoI1Q/OUenmn6zzsygzWFe9296/Mj0viUaUfU=;
 b=Agzw9LdWtjF0Wq+2kF+nhpFhomcadOhuNrVAbNwimq/wqqnnbgh3gXc0vEcgGvrmeTOzNAUeoo6SGVxYslyRi07Kc+9BrE0ZRARD1EUOG5bX/xx77VxFAgjL6k/S2WnShADUFeQ/lLebPjciMaleFtM9wToPCsBti/n5G4BIHCk+l0+9gr8V07tvTi4b6+7N3uRvsP6Eqhp3Ew2xzV++bCnHQdoEgupZJ6Xa0dZEJS7NYfRvFfx1ysNoaiApoL+05OTBp8C8oB53si/CKjNyiME3CEpYIHRTJTK94GOcKYvYcphRYPaMFkxQdmCuFZ+lcQB4LiJ673sPyoMUP6IBhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com (2603:10a6:10:36a::14)
 by AM0PR04MB7140.eurprd04.prod.outlook.com (2603:10a6:208:192::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 11:12:05 +0000
Received: from DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492]) by DB9PR04MB9426.eurprd04.prod.outlook.com
 ([fe80::fde1:fffd:bbe0:492%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 11:12:05 +0000
Message-ID: <dc2e2ed8-94ea-5861-3f84-04e432e563a1@suse.com>
Date:   Mon, 7 Mar 2022 19:11:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] btrfs: verify the tranisd of the to-be-written dirty
 extent buffer
Content-Language: en-US
To:     Nikolay Borisov <nborisov@suse.com>, linux-btrfs@vger.kernel.org
CC:     Christoph Anton Mitterer <calestyo@scientia.org>
References: <1f011e6358e042e5ae1501e88377267a2a95c09d.1646183319.git.wqu@suse.com>
 <843daedc-ffb7-658e-89ab-86c20d5db2f1@suse.com>
From:   Qu Wenruo <wqu@suse.com>
In-Reply-To: <843daedc-ffb7-658e-89ab-86c20d5db2f1@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:510:174::26) To DB9PR04MB9426.eurprd04.prod.outlook.com
 (2603:10a6:10:36a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65bfc7a3-d746-4f5b-cf4d-08da002b501a
X-MS-TrafficTypeDiagnostic: AM0PR04MB7140:EE_
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-Microsoft-Antispam-PRVS: <AM0PR04MB7140A7DE5CF48CA769D0AA74D6089@AM0PR04MB7140.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k3J1Uug3P1K0ZtQkyM6vEajAmQRkADjLeVJQFX6qAKcB+xX1XkA+hZCnTOiHdZjc6W8UUDy2wn6iOBlIKTWojNT13g+jjQr0LuAqzHkwmPQZkuxz01titghwKOzA+hSnab4zWzu+iCYqMVl4zeny1Mx6W64TzF/sTIBw0dASnLodnzuVrDjYOMHHZtkVXt/QDwZn1Yyg+FGz2sAlxHLaOHqDPcUqLsbgQxNIMVePzs0W/V/Nd066agSaRxjMbHIx0Mgb9pOMTA8cf+7QTqSP4KjABiajwZSKK8LDIwTubatyix1MMeqiGNUgJMn0lSkeTtERjNzS9Sd6McFMbzW1npOQVxBxFTm0RZ2435Rdnw2QoAQhqRmso/KqbuZoMVXvKY//3TCJi1JkfeqaKh5T/DkZ/K2+ZwEPx+TnQj2q5k7pnjgrnlFzdgDTTWxY21/sLrK6UIuVtDT+KWCq5S+u1AKjmLwBRKeVNB8e0EQEG5e8DlyXebcIY2O9Mjdyu0D9vwQw+z/Z85aNQlaDLh5LonW4MWJEjmL9bke+EdOA4OIDflNsz2s6Br9/eHL1wFNZPhhaeLeTejv7USk53MVXFyaLy0MJHRPExMaEo1SfmL8owD+UEMIzrD5QAJO1qCzCDxPvlORnbllrMg+Y7bknpKNSm21pavhSa519t9GVxsbybQ7mdJtm/oUwpjWEMTggDznupOVw/XX3jxuYiuHNeiZdZ2xJog7rM8GwkVqQPOyqdLReq1RaaCCphhPs9j90SStufAo7ZHnuF5s1S5d7HCzcTAoLga22cvZ5NZD0DW64HNBl2uJ9pB0wgO0WLIAEHDhRCEJn/JMycb1w32yrBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9426.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(2906002)(2616005)(86362001)(966005)(6486002)(316002)(38100700002)(508600001)(53546011)(8676002)(66476007)(66946007)(6666004)(15650500001)(66556008)(4326008)(26005)(8936002)(186003)(5660300002)(83380400001)(31696002)(36756003)(31686004)(14143004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wWr8gUnlUiT6YG81mAPY4Rt13MwWi56KKJSKvvL2qt4A/6UX+fz3cy2xJzQK?=
 =?us-ascii?Q?YE5NwXGCKoSJdpqmMGkmtBgLoiQiuBNHAyIpf8CKT3XECqhoL+StuR4LkzNQ?=
 =?us-ascii?Q?nkgVCj0sCL/E0TBabKdC4U43as2Jrx+hJG3uBO1kN3woxAlqaKYWdKFRLFvw?=
 =?us-ascii?Q?7+bLr+19qpwLZfan9+f7Dn6I2pDa0z6N0OqpOWPUsgb9Uonw65rb4grs3hG4?=
 =?us-ascii?Q?yXlwd2NoqziJSbO/vo+dtqS09plzpAby9jSTHuzgW9692K07/VCBOQgpVTNk?=
 =?us-ascii?Q?/9UoUbvOOPyXPLCpxXmKk/ddvTOcFAMYIEUQzJnuaD89o5RWb38ZXSg/2VO6?=
 =?us-ascii?Q?q/gMyy4CalB7IG0Nf6THKWsHogXTW+rBE/T9odH2brPmKoSF3igqjiCpqGC4?=
 =?us-ascii?Q?DRYvl3nLHylA/nTVc7E5bCuMvnsyEbgCjGvAxhaoJM8CMFGKr/d4GkdV/xSl?=
 =?us-ascii?Q?wANRhR7MCfkGxLJu6z7iqTeDYXpzT4Z599mT0r7iz+mJT2k/X8vM15z2pbYT?=
 =?us-ascii?Q?Vwcx2OJZCX410BkFnwPsBR+x8f+3WmPZVe7B2EMdhxufCdkBOh2t5O2bfUkj?=
 =?us-ascii?Q?YCGocB36d0AM0bwS7q+uyuprAGrmpN7NLEpvGyoNji2P2Xm4W/G44McTo0Gc?=
 =?us-ascii?Q?ED0JLgf76U72xYzy1wNMifOXA7xAG3LMfv074rNxjBiFjznsp0Bv0y/GXHKa?=
 =?us-ascii?Q?PWQQxu4q5SMONBiBjQL1L8Bk0utJ4bNMErhQaBMCCrj4sD9ts/txihgs3hli?=
 =?us-ascii?Q?IStwROTe/2a6PARk9Q0dSVoAI5dpXYewUv2Ugty1rKtKKA95sRppb1riRHsS?=
 =?us-ascii?Q?gxJLN6a/0BwQ7J0O2mmHPzA4NJKmDa/RF147nrxO0TY7FeKYN+XT+PH9Z6dD?=
 =?us-ascii?Q?HjnOWgPn+8dOiBklSlZP8Z0VM/9TgForYSBNMsXAoL9QFJUq5hR9THp0fTu8?=
 =?us-ascii?Q?SI06zws0kAbr8Zmx2X5nJ9NoANNQbUlJFPaF+BfVdpIo/ep2pjgtvOZdWN5n?=
 =?us-ascii?Q?aUMH4IzMZSMb6JF5NM5EAgEM9JlbviE5V27igcb4N14aJO2IBhLMRcti2mxB?=
 =?us-ascii?Q?uxl9pkoFXiPg3M1bWN/LsrCHnlA+rPENLW7U6cc8FsgKFubYvnZua/DL8Uub?=
 =?us-ascii?Q?u70IzJLiLZ8jT/a7cv71uR7qpVs48k+wYBwnKN0/UhnuAOuVryqr5RRpY1ty?=
 =?us-ascii?Q?ToFJhCBy9BTvhonmBZv3rbGJNNw3erVRv5OqemFsb7QX9t5dbFnOJJyx+aKm?=
 =?us-ascii?Q?G5aOebG8L3JMwmfV5YYCDUgpKbUCYE7hid0KyY5nw4E0axCe1rXOWGbG7WWQ?=
 =?us-ascii?Q?/ZGfIrnmPUvVAAv+Bpsa/qgmXb3xCcdocZng30pjqtu+SvGYU9KzlKxqDjPw?=
 =?us-ascii?Q?0XUOkZphawLVq4qHekpGDZbI3G6WLO59HxBHWqkGHcUDQm00OqJGZiHLHclG?=
 =?us-ascii?Q?pyG+EVylOgV1pE03QC7i7GSjglC+LVWQ0nHJSb6cN5P3YbnTKwh+OQBGQ/L3?=
 =?us-ascii?Q?6sHJ4Suc6ZLAYtOcF+DIwjRyQ26hVuP8SamlKljHStgzv2Px909OsJ87Q4ng?=
 =?us-ascii?Q?+/VyYwOh1T3X7kQn5Ek=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bfc7a3-d746-4f5b-cf4d-08da002b501a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9426.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 11:12:05.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5FRe/Pf3q6cRJKj1MaNQOpA3pe7gY1zA9aBFdX8iq1Xh5hJcSbWEw52aP1d2+ji
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7140
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2022/3/7 18:51, Nikolay Borisov wrote:
>=20
>=20
> On 2.03.22 =D0=B3. 3:10 =D1=87., Qu Wenruo wrote:
>> [BUG]
>> There is a bug report that a bitflip in the transid part of an extent
>> buffer makes btrfs to reject certain tree blocks:
>>
>> =C2=A0=C2=A0 BTRFS error (device dm-0): parent transid verify failed on=
=20
>> 1382301696 wanted 262166 found 22
>>
>> [CAUSE]
>> Note the failed transid check, hex(262166) =3D 0x40016, while
>> hex(22) =3D 0x16.
>>
>> It's an obvious bitflip.
>>
>> Furthermore, the reporter also confirmed the bitflip is from the
>> hardware, so it's a real hardware caused bitflip, and such problem can
>> not be detected by the existing tree-checker framework.
>>
>> As tree-checker can only verify the content inside one tree block, while
>> generation of a tree block can only be verified against its parent.
>>
>> So such problem remain undetected.
>>
>> [FIX]
>> Although tree-checker can not verify it at write-time, we still have a
>> quick (but not the most accurate) way to catch such obvious corruption.
>>
>> Function csum_one_extent_buffer() is called before we submit metadata
>> write.
>>
>> Thus it means, all the extent buffer passed in should be dirty tree
>> blocks, and should be newer than last committed transaction.
>>
>> Using that we can catch the above bitflip.
>>
>> Although it's not a perfect solution, as if the corrupted generation is
>> higher than the correct value, we have no way to catch it at all.
>>
>> Reported-by: Christoph Anton Mitterer <calestyo@scientia.org>
>> Link:=20
>> https://lore.kernel.org/linux-btrfs/2dfcbc130c55cc6fd067b93752e90bd2b079=
baca.camel@scientia.org/=20
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>> =C2=A0 fs/btrfs/disk-io.c | 26 ++++++++++++++++++++------
>> =C2=A0 1 file changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index b6a81c39d5f4..a89aa523413b 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -441,17 +441,31 @@ static int csum_one_extent_buffer(struct=20
>> extent_buffer *eb)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D btrfs_che=
ck_leaf_full(eb);
>> -=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_print_tree(eb, 0);
>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Also check the generation, the eb reached he=
re must be newer than
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * last committed. Or something seriously wrong=
 happened.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 if (btrfs_header_generation(eb) <=3D fs_info->last_t=
rans_committed) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EUCLEAN;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info=
,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "blo=
ck=3D%llu write time tree block corruption detected",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->=
start);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON(IS_ENABLED(CONFIG_BT=
RFS_DEBUG));
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "blo=
ck=3D%llu bad generation, have %llu expect > %llu",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 eb->start, btrfs_header_generation(eb),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 fs_info->last_trans_committed);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto error;
>=20
> nit: I'd rather have this check in btrfs_check_node/check_leaf functions=
=20
> rather than having just this specific check in csum_one_extent_buffer.=20
> The only thing which is missing AFAICS is the fact the check function=20
> don't have a context whether we are checking for read or for write. It=20
> might make sense to extend them to get a boolean param whether the=20
> validation is for a write or not ?

Not only it lacks a bool, but also needs a u64 root_owner.


However, I really want to keep check_leaf/node() simple, just an eb, and=20
all checks are based on the info from that eb, no extra ones.

Adding one u64 will not be a problem, but I doubt if we begin this=20
trend, we may add more and more parameters for that simple function, and=20
make it no longer that simple.

Thanks,
Qu

>=20
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 write_extent_buffer(eb, result, 0, fs_inf=
o->csum_size);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +error:
>> +=C2=A0=C2=A0=C2=A0 btrfs_print_tree(eb, 0);
>> +=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "block=3D%llu write time tre=
e block corruption detected",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eb->start);
>> +=C2=A0=C2=A0=C2=A0 WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0 }
>> =C2=A0 /* Checksum all dirty extent buffers in one bio_vec */
>=20

