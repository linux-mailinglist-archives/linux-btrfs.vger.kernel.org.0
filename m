Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B42423DE
	for <lists+linux-btrfs@lfdr.de>; Wed, 12 Aug 2020 03:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgHLBxl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 11 Aug 2020 21:53:41 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:37612 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726235AbgHLBxl (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 11 Aug 2020 21:53:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1597197217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NoRy4EEiyPnt2q7+KNad34USRxkhpyd5VOjEfc6MLjk=;
        b=LKGSlCm4kzAJmKR1MeaUI1TM8DaLKtIeMFgchSoXCbEYShq5d6HWyKIQUgXldH7eET5X0M
        g8bQTgIh9i22clee9nSymNggl2FFgJqSAqv16dWKL4QilUlZv0sRBjquoWNVZ09Vs1SG9Q
        LMD87qLn1/NYTJdP3RRJY1N8AMaOiiU=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-27-EFucMKiaP2C4q4XWh4GezA-1; Wed, 12 Aug 2020 03:53:36 +0200
X-MC-Unique: EFucMKiaP2C4q4XWh4GezA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR5lsciLyIaxbDPucoJ+NSCDozXrzIll3b0imNAqSvNN7bmRdFCiZrf7SsT4+pKKrEDnBJBIiU6OBmJXd62BKx1HnRy++8AHjcqMmDXpeIpMMOZKKHTLNNxAOiLdAYBlrw6UGPbGgzfSNjHee44KiBZ0A6oYFoYxwqokigbdREh7EBvG1dBeW7vaijVuERIHeKRB2nt9jgalof5mhNHldWTFyb76lqFZrZGqO7iJx3KXEPfPN/j6NZxRMoKoC43vFdgeu3ogTg5YSSLvFMiLM3F7Etgo9yV3gSQWPjFYI26iCzXLbEiqGm7mCYxMDgY9AFfv6F2+Yinv4KqRTorE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5CW9088KjdOu1k2qwQdqFuv8FC5t3qgtlmJNlNoZ4M=;
 b=fxX7TukwaeJqT4muE7nOsN6pWHeD0mzRVwK/ChpeQJFe9it74WTNfyfRlfIsy468lVXQwpgVCmIfg8KMjLD1Kv8P5KfCQ1GWlne5LL3mNZ0zL0kqtc7bym+m5jLNupSJiu1i9SjnNc7YcZmOwAM1spspLNdFDqa4tQvQkC0SUhhYpxInX2Ucnwe47MH6hK1SSzFiIDXuZgvI2hyhzW0KMN5eE/EmbHchBMq6It4q+gWDnxZ0JDmfNvwykB3qZuGA+kD98EafvTeIYqqHzyg4BjEpGZnjvFJEnkHJKt9hk2qZ6WO7vQzgNiqW8vQha8T3sa1VXS3evWqfpDe5Rg6K/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB6451.eurprd04.prod.outlook.com (2603:10a6:208:16c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Wed, 12 Aug
 2020 01:53:34 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16%3]) with mapi id 15.20.3261.024; Wed, 12 Aug 2020
 01:53:34 +0000
Subject: Re: [PATCH v3 3/5] btrfs: Detect unbalanced tree with empty leaf
 before crashing btree operations
To:     Josef Bacik <josef@toxicpanda.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>, linux-btrfs@vger.kernel.org
References: <20200809120919.85271-1-wqu@suse.com>
 <20200809120919.85271-4-wqu@suse.com>
 <8d21ba85-52a5-5419-dc16-ceece8b0c3a8@toxicpanda.com>
 <dbe1176e-db46-7ff7-1231-ee69d7c3c5d1@gmx.com>
 <ee1203ab-444d-cc9d-0e00-2102bd02ecd2@toxicpanda.com>
 <fb4aea50-0e81-6444-ae9f-3e6c2df88c67@gmx.com>
 <727019b8-254f-d2eb-f886-3f46e7b522c7@toxicpanda.com>
From:   Qu Wenruo <wqu@suse.com>
Message-ID: <442f2087-d0e0-ebb9-06f1-7a97d7557204@suse.com>
Date:   Wed, 12 Aug 2020 09:53:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <727019b8-254f-d2eb-f886-3f46e7b522c7@toxicpanda.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYAPR01CA0100.jpnprd01.prod.outlook.com
 (2603:1096:404:2a::16) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (45.77.180.217) by TYAPR01CA0100.jpnprd01.prod.outlook.com (2603:1096:404:2a::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Wed, 12 Aug 2020 01:53:32 +0000
X-Originating-IP: [45.77.180.217]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c0a32e69-5eb6-45a6-d947-08d83e6285cb
X-MS-TrafficTypeDiagnostic: AM0PR04MB6451:
X-Microsoft-Antispam-PRVS: <AM0PR04MB64518E9545EA9BE0E1D648F9D6420@AM0PR04MB6451.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCKmNvVa6QgjVeYzZ7bxIfv01DNWAdFPJ8Q4DIVWQvonUvqv8r4nUAa41KX9sSDs47cRjp5Y2uWLC0SG4Js80+SO5ofiZVdbLXAGjAFBIWZt/4sdGsrWhTpP7kLGIdmIY/5NqNbrx+ZaGF4fokl3AH7nDtpqJh00RuZz+4vWbm40hx0NhoOypT4Cm0C0LKLnosjridf180AAYm0UqmkOugWc3Oes4yxk5gkQf0f5C/mXBQBCo9qXmlgnrwBM7Z2hQUF+QbH/CHNzeHpdtLK954iPGR8mCIV340jUwlVEU+vEfDlA8b9XpqHrg3Rsu7ZSG2E5TbfjtRuOsdUSvIqWSYb09mCZz8ZxO1QXVQlqJhjRVXoos3NeBCD7bMBK8QeFG2/iZDWEyzqw2sSyEYhju73XlEup6PX7JII4FeTN1ps=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(366004)(39850400004)(396003)(478600001)(26005)(956004)(16526019)(110136005)(66946007)(2616005)(66476007)(2906002)(16576012)(52116002)(31696002)(5660300002)(186003)(86362001)(31686004)(8936002)(8676002)(53546011)(316002)(66556008)(55236004)(6706004)(36756003)(83380400001)(6666004)(6486002)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 6qCRizgppSOtR3/9bBjNbTwWJaT0CUerjgWhbZ0wY/SSlFRNC86XEVGl4T7WKwiJ1SkUmooUado41POmXOCW+2o5ZkJCc3p5hqweZdug5fYUqZfV6s6UEW3rKLVQnk0T1sDX1GLHeIEvrOICLfKRnMX13oakC+vktcaeYeR6E2jw+7DLWyaqdnQjoSV6YDuIJqP5v8k0AviEFxC2xSetfEirAr6iGttEExHKQGEuqjT66QMzC9dxvv+lnqciGXfjPYOllN35uL4oPgoOAbps/qqThw8RNcy8cZG4+6W+c4ZhgCpXCwkxfsCHiKKVUW8G4ZD/lnpvtqidf5DMVmz9O2/Kw6+8fIcvg5Bcs3NwTaDgJWBmf/jTWE7FCfDYnS0xEA/y1Z4ztLtD1Vm7uXbv+FqtHb8Jhfvy/Cp7aer00mUNsBzdeR0WJwYfl1SDxI0boFn/mlIiYy4c72GtGlrgL7TBi4ECan0aydNtqqlakNhnceTRmQ1tSSBVpCwQ68y8fXFDhP8b7KpLBOhVZ1dVgrmev0sL8Vg7wB0svMaq50V/m8iXhEnbLwhbYO4+CAtpe4mH4COf6t/6mRkBk3znAscYAQKef+hYjwlMkWBXKivEojxPX7kQi/HKXa1TLeDTugKQOjB0E1HcO6kVaQyElA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a32e69-5eb6-45a6-d947-08d83e6285cb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 01:53:34.7430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrgXSNUzBpSrUrkVfdJ3h18G+EDThX7NGo1zUoK2QpIL72m/4zI10VV2AnN0mA8X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6451
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/12 =E4=B8=8A=E5=8D=889:50, Josef Bacik wrote:
> On 8/11/20 8:29 PM, Qu Wenruo wrote:
>>
>>
>> On 2020/8/12 =E4=B8=8A=E5=8D=888:23, Josef Bacik wrote:
>>> On 8/11/20 7:04 PM, Qu Wenruo wrote:
>>>>
>>>>
>> [...]
>>>>> Which I assume is the problem?=C2=A0 The generation is 19, is that >
>>>>> last_trans_committed?=C2=A0 Seems like this check just needs to be mo=
ved
>>>>> lower, right?=C2=A0 Thanks,
>>>>
>>>> Nope, that generation 19 is valid. That fs has a higher generation, so
>>>> that's completely valid.
>>>>
>>>> The generation 19 is there because there is another csum leaf whose
>>>> generation is 19.
>>>>
>>>
>>> Then this patch does nothing, because we already have this check lower,
>>> so how exactly did it make the panic go away?=C2=A0 Thanks,
>>>
>>> Josef
>>
>> Sorry, I don't get your point.
>>
>> The generation 19 isn't larger than last_trans_committed, so that check
>> has nothing to do with this case.
>>
>> And then it goes to the header_nritems() check, which is 0, and with
>> first_key present, which is invalid and we error out, rejecting the
>> corrupted leaf.
>>
>> What's the problem then?
>=20
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We have @first_key, so this=
 @eb must have at least one item */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_header_nritems(eb) =
=3D=3D 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "invalid tree nritems, bytenr=3D%llu nritems=3D0 expect =
>0",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 eb->start);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -EUCLEAN;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * For live tree block (n=
ew tree blocks in current transaction),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we need proper lock co=
ntext to avoid race, which is
> impossible here.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * So we only checks tree=
 blocks which is read from disk, whose
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * generation <=3D fs_inf=
o->last_trans_committed.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_header_generation(eb=
) > fs_info->last_trans_committed)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We have @first_key, so this=
 @eb must have at least one item */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (btrfs_header_nritems(eb) =
=3D=3D 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 btrfs_err(fs_info,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 "invalid tree nritems, bytenr=3D%llu nritems=3D0 expect =
>0",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 eb->start);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 WARN_ON(IS_ENABLED(CONFIG_BTRFS_DEBUG));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return -EUCLEAN;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
>=20
> This is the code, you have the exact same check above the header
> generation thing, and that's not the problem, so I don't understand why
> you have added this check.

Oh, you're right.

A bad auto merge, which we have merged the same patch before...

Thanks for spotting this!
Qu
>=20
> Josef
>=20

