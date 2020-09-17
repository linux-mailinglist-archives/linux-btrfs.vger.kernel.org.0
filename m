Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBCC26CFCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 02:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgIQAJK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 16 Sep 2020 20:09:10 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:43266 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726007AbgIQAJI (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 16 Sep 2020 20:09:08 -0400
X-Greylist: delayed 317 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 20:09:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600301343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=sI9sFVOaYcAlmH3rW3xSlB6fzDevMYb4qr7gdiLbejQ=;
        b=NHvBoegfmKbwTYL/hYVf04V6STVtLLpYSqxkgFvrltXCXFNXglQuBlmqoIHemfzqJKScLI
        cb3E5Vxt44yC9rmYfyvunVszOGpacXLRYgHsC3HvXvYnkHyfG4c55ZqOk+tsUYVPLUX6ib
        oDHm9i1oDnkLx6aflX/ja1iKUscC8kU=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-sY-gwJWENh6J3s84uRCzYw-1; Thu, 17 Sep 2020 02:02:24 +0200
X-MC-Unique: sY-gwJWENh6J3s84uRCzYw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+vK27HH1Hito7+XZsfBBOpXQ56HcshFpvysulMYKy6sV3RV+gApHNqVkSOmRmpIyyNyQwh0X70RtZOnxK05IyK2zoZyT/Vy78xvg90EyRabXmSp5jgPQkBSneELr6iLIHxpwCZfq7KP4BHEYw3oU4Cu0fAU0011wp3x1iwf2kQUPBAnZ+9Mg1TkFQ3l6AjWh1Y2Hw0oQ5LJRSF/fAlKxfjusdJRBI6o57xCT8Gu9wOnyY+ExVv6kD61UQA4uhjw9HhZQlStp5l99c0lzsNPFILJ6xv5MS+wyiBXm5wXe9FxLDx0+X8VnwNz7nQ5s6od3Sk49Bbq9EOsTyixrftQzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OeiPdtFLJ6GcYFuKnpEpUQe79BQQNTFGoG+R7BWFiz0=;
 b=Ino+sWDXeU0TBl7OwpVluZhEhZZDEhGc8L/PXFqdlIxi9glGMtdYeC5IBuks7A+akr/WO8hd/nTj+jpj+nYmQ3VuvplRwlBemi+6M3wRvdJN7ocVQeoiAKM8Qrw1gf+Mi1Iwz9qfTs/YAoRCmcpNzi+AE39o4aq+0F8rBfxtXk7XjieKGGe40vsL+c5LsWOMTEXIB1bsPqFqopZ+NNu2bFkUsi7zXVfyBSGSIQAlOAaoq/IkpJbcTsr8rDqQdD54Vv/ijMLvMRcNbhtiAqyA+C9xu5X8EQLzUKBLOQUXKb5a46KZncl8hgmrB0yfQoNSD9MOAm9bf4/PbhyC5IBpMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 00:02:23 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 00:02:22 +0000
Subject: Re: [PATCH v2 14/19] btrfs: make btree inode io_tree has its special
 owner
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200915053532.63279-1-wqu@suse.com>
 <20200915053532.63279-15-wqu@suse.com> <20200916160612.GO1791@twin.jikos.cz>
From:   Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0GFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPokBTQQTAQgAOAIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJdnDWhAAoJEMI9kfOhJf6oZgoH
 90uqoGyUh5UWtiT9zjUcvlMTCpd/QSgwagDuY+tEdVPaKlcnTNAvZKWSit8VuocjrOFbTLwb
 vZ43n5f/l/1QtwMgQei/RMY2XhW+totimzlHVuxVaIDwkF+zc+pUI6lDPnULZHS3mWhbVr9N
 vZAAYVV7GesyyFpZiNm7GLvLmtEdYbc9OnIAOZb3eKfY3mWEs0eU0MxikcZSOYy3EWY3JES7
 J9pFgBrCn4hF83tPH2sphh1GUFii+AUGBMY/dC6VgMKbCugg+u/dTZEcBXxD17m+UcbucB/k
 F2oxqZBEQrb5SogdIq7Y9dZdlf1m3GRRJTX7eWefZw10HhFhs1mwx7kBDQRZ1YGvAQgAqlPr
 YeBLMv3PAZ75YhQIwH6c4SNcB++hQ9TCT5gIQNw51+SQzkXIGgmzxMIS49cZcE4KXk/kHw5h
 ieQeQZa60BWVRNXwoRI4ib8okgDuMkD5Kz1WEyO149+BZ7HD4/yK0VFJGuvDJR8T7RZwB69u
 VSLjkuNZZmCmDcDzS0c/SJOg5nkxt1iTtgUETb1wNKV6yR9XzRkrEW/qShChyrS9fNN8e9c0
 MQsC4fsyz9Ylx1TOY/IF/c6rqYoEEfwnpdlz0uOM1nA1vK+wdKtXluCa79MdfaeD/dt76Kp/
 o6CAKLLcjU1Iwnkq1HSrYfY3HZWpvV9g84gPwxwxX0uXquHxLwARAQABiQE8BBgBCAAmAhsM
 FiEELd9y5aWlW6idqkLhwj2R86El/qgFAl2cNa4FCQlqTn8ACgkQwj2R86El/qhXBAf/eXLP
 HDNTkHRPxoDnwhscIHJDHlsszke25AFltJQ1adoaYCbsQVv4Mn5rQZ1Gon54IMdxBN3r/B08
 rGVPatIfkycMCShr+rFHPKnExhQ7Wr555fq+sQ1GOwOhr1xLEqAhBMp28u9m8hnkqL36v+AF
 hjTwRtS+tRMZfoG6n72xAj984l56G9NPfs/SOKl6HR0mCDXwJGZAOdtyRmqddi53SXi5N4H1
 jWX1xFshp7nIkRm6hEpISEWr/KKLbAiKKbP0ql5tP5PinJeIBlDv4g/0+aGoGg4dELTnfEVk
 jMC8cJ/LiIaR/OEOF9S2nSeTQoBmusTz+aqkbogvvYGam6uDYw==
Message-ID: <9ea58668-b6e5-6471-01fe-d4bf8ae8b310@suse.com>
Date:   Thu, 17 Sep 2020 08:02:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200916160612.GO1791@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0064.namprd08.prod.outlook.com
 (2603:10b6:a03:117::41) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR08CA0064.namprd08.prod.outlook.com (2603:10b6:a03:117::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.14 via Frontend Transport; Thu, 17 Sep 2020 00:02:21 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33b1deb7-3f1c-49c3-fd55-08d85a9cf3f3
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:
X-Microsoft-Antispam-PRVS: <AM0PR04MB64528C57613931BB163C2C38D63E0@AM0PR04MB6452.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZbdmuMuJkYnlTESFFGnh8rXJ7BF9iILhdXoHWTRnq7lDZpD0mQmX3WqSFbrKnQ9qzlDhHdWNdf0mXcca1y0yFjTNfr/vNVBR4izYcubwJJnaz+OuF2BXu264CTHeJkqMbtpIlDNuceGTWikR05jq72D6m8JItBWmclY7s9o4bvMO0oFY2fxomiI1Lv+4KPMP4moSzWS7aQjJWguFWsaFIf2nmyxb0B5OH6ZinLXuactwjrsW8rT1exZVb4e5eWmhcwigh6tMXgH/UWaSb/Z9r8aXdWpElK/DBCcC6r3+PeiOZXjrJexH//m7iDEcYiRmF+vUe0wkG+bcjt2xeQ8vDTRfbOq7uFFBE02Zz5pb0fd/TAEx/bmz1qFp6gO7js79oUgwh5dDJLCgLzVjWBvtBWv5EusonrVd0o/6PRu/B40xGs+YrJ31k1xOObADV3T+Ni5dp1/eKh12wf67uydIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(396003)(376002)(366004)(316002)(8676002)(186003)(83380400001)(6486002)(6706004)(478600001)(52116002)(31686004)(956004)(31696002)(16576012)(16526019)(66946007)(26005)(86362001)(6666004)(8936002)(66476007)(36756003)(2906002)(2616005)(66556008)(5660300002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 010x+1Q3NHWsJqyGCgKQPVxFPQZqkbRmILuP8ZRQjbSQwvDK++rENo0jNulYvVuHg52jgCeMKIwykQgzH501mX6ykuo3oaigefs8JUE+ATAciG15PxdfM2OVbD2voYfHnILpUFSnJhC25Wfi1IUcQlknZ7qDX8x6k/AApimu1mpGT4ikMFxfng9p4SgDi/t8OnI5xRWH0r/m4PvOG634NnF9CSsnxjuQIwsx+fRvVYYA+SmwkQdFfBdBGhB83EV5LX9x8+gpQeKyGNx5177CxgWaHkRUxES/26kIpHVzL0fEwTOSstIIVqMtyL+TLqh2/LsS9Lkvjfe7uhF8HlEzd4zMIis8hrDjRsyBElf0RzKAP7WrYqc3cbb2lM/5uTHYdZbOrw64ujQ5bu9fBfj/Zd+xIZOb+NU9PbpouayVuYuGTIIhbErvFAKHTOGHCAomCGlMLKG8kNkrkDU7+a1dvgR3+jcSslWVq/so9hY9HRFuvJ5AxUtO3TZALm2VTS3+6RNEOspskMCkA0uhRYhoKOurq9JRqcCr8b60pTqrhViN4KsgpLKZLStOJ2tgw/0cIkDo1RsyHdJczlw5UytBgMmXtdIW3Z9+cbmmETycr/EFf4wLLY6KMl57HwNZbIVrQQR8qeg5J0XwWcWInhyFzg==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33b1deb7-3f1c-49c3-fd55-08d85a9cf3f3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 00:02:22.8476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ge26xgxkZy+kPjvodb1wnT06FOOBRIY5g+7qBp940pXWFXPntSQ1uIESD3zwcq9Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6452
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/17 =E4=B8=8A=E5=8D=8812:06, David Sterba wrote:
> On Tue, Sep 15, 2020 at 01:35:27PM +0800, Qu Wenruo wrote:
>> Btree inode is pretty special compared to all other inode extent io
>> tree, although it has a btrfs inode, it doesn't have the track_uptodate
>> bit at all.
>>
>> This means a lot of things like extent locking doesn't even need to be
>> applied to btree io tree.
>>
>> Since it's so special, adds a new owner value for it to make debuging a
>> little easier.
>>
>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>> ---
>>  fs/btrfs/disk-io.c        | 2 +-
>>  fs/btrfs/extent-io-tree.h | 1 +
>>  2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
>> index 1ba16951ccaa..82a841bd0702 100644
>> --- a/fs/btrfs/disk-io.c
>> +++ b/fs/btrfs/disk-io.c
>> @@ -2126,7 +2126,7 @@ static void btrfs_init_btree_inode(struct btrfs_fs=
_info *fs_info)
>> =20
>>  	RB_CLEAR_NODE(&BTRFS_I(inode)->rb_node);
>>  	extent_io_tree_init(fs_info, &BTRFS_I(inode)->io_tree,
>> -			    IO_TREE_INODE_IO, inode);
>> +			    IO_TREE_BTREE_IO, inode);
>=20
> This looks like an independent patch, so it could be taken separately.
>=20
Errr, why?

We added a new owner for btree inode io tree, and utilize that new owner
in the same patch looks completely sane to me.

Or did I miss something?

Thanks,
Qu

