Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBAA24390F
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Aug 2020 13:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHMLDb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Aug 2020 07:03:31 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:60363 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgHMLD3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Aug 2020 07:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1597316605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=A+H1pmr5x4NDCf8at8NYp/n+Niy/9EQVgSV3a0G9RbY=;
        b=UTG71DYrLbiyXQhhq4WYcbk1xFX0EgxhiSnPKa5Zf9BX0uBllmPlvrpxi+k7h5pmn2MJzY
        phiTUDCQv5KPK/ZiKBVFOwQ5t8UVZwYfVmKiTdD2G5bR1aAT9TXRZ4kEflCIFrCDIxrSxx
        tiGM20xPN/Q3ACPQkB9GVa0VCO5PiG8=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2052.outbound.protection.outlook.com [104.47.5.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-12-FF3PiS_kOlu1i5NWNedw0g-1; Thu, 13 Aug 2020 13:03:23 +0200
X-MC-Unique: FF3PiS_kOlu1i5NWNedw0g-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Be+0L5cMlCrejUeYVr5WEdCJV85WLQkvhAqAt5AekNfIICCxCxDdD2eQfdjTNuEKN/Ky4eM+HtcIX1ev5h6TiGNSlhYgi0XS9q3wHaU7XsI2wVedSI+AUxgoKEyLXzDb9JmZNuIqsjFJFu4GdSckSBHMepLkVfk6XsGQtk2QPJNn3JjocPNlYP33euEDija3/HfQH/LMbmHoL2XIzcz2wTYnDzWkV2gXLs2TEvloBAE/5PHRHpRtTZdstzWYJa2J9fc4/RBbW24MUB1ZzB6wVVQ9O4Wxgzb3hvf1lNQBatUBHVSk5MxUpKGW1IJs9A4FaqBzeJosR/hQBt2IoNmAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6ThkkFcNA3X5Bn4vzOmPWzf5jIYPR6bmL8mFKiBEQY=;
 b=UlDkaLcJJ1++xD5PgqF/AzqD2CAe7eaOq9RqjLFDz5eP4VhqunHC+JMggCHmBRIuFCQNZnBnSGX9FGQesnyuM0MYKRI99vAGP01eUja/fhDM3uQb0TYBXw1lOZ0FljStxxQ13k9cXAdUacDzpZhNQ0xb/jjukq784fy9ojEJ8sdIqeLmSFgJkbXk29ccvykNidT4Sh2IZNHNR9gea1NqqlS+fTn4NLHWYl4X0Zv+PIQ/gTfXoHMpT7papGkZbu6X96hxnXnbhxOTF+7pLCEiHC/w1M3vAWZF8w0BJkQWMwiRyOA0jX4eMw2o9xUgxjZhpPVCxKa3ziedZErBOAGpDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR0402MB3524.eurprd04.prod.outlook.com (2603:10a6:208:1f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 11:03:22 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e49c:64ce:47e0:16%3]) with mapi id 15.20.3261.026; Thu, 13 Aug 2020
 11:03:22 +0000
Subject: Re: [PATCH] btrfs: remove the dead copied check in
 btrfs_copy_from_user()
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org
References: <20200813061533.85671-1-wqu@suse.com>
 <20200813104815.GE2026@twin.jikos.cz>
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
Message-ID: <fc0819b6-0709-d363-afac-c1d1516e6ade@suse.com>
Date:   Thu, 13 Aug 2020 19:03:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <20200813104815.GE2026@twin.jikos.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:74::46) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:74::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.7 via Frontend Transport; Thu, 13 Aug 2020 11:03:21 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0187dafa-d1d7-4435-4afd-08d83f787e6f
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3524:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB352485C772FE04CFFDDAC55FD6430@AM0PR0402MB3524.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NpsqHq2FBMWvygsDMLv2ZTPZh2qMC9n4fu9I60+4/gKgYXl1ZfLoW7ECHdiANvNppx5e+pvsQAdfWxUsg0WSXs7zWHaId0bALSy9uazblvYAN8AWmxhrSHkitOScYxmUmU6BIrF/xmsmA6nwNsYtz8RhF6T8tTTC7JtQanGLFdDij8xokhCGaf2n/vJ0AqxW/GhFOdzAaaruLaJQSbT+0U8sMKqCSgeFqWBamzeXwXv/FS/knbYIHpzkxfU79us14msHmLDLLvo1rdN77l3OXPEbrcBm8FPzBNTORC/eF2xLyYtksiX8xoD5zx4AYYy9lxgUMUMsS8jGrduh2kwDQlY4vH/K9DYyj0+oeuDTWxjJhZBLCQ0n3YxxMJNp5RutW2sivzNSZ5nxUh2l1TLdPR8BgQci5eDoPUmxBBfj0iM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(52116002)(6486002)(8936002)(16526019)(83380400001)(26005)(186003)(66946007)(6706004)(5660300002)(2616005)(16576012)(8676002)(36756003)(31696002)(2906002)(6666004)(316002)(66556008)(66476007)(31686004)(478600001)(956004)(86362001)(78286006)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 22JGd6BPcpIDRXZefU+AClKaom+W0fFA9nhI1tfqohQSkhhNb8wJA2QG3Oo+bPkPdZ5/yPFTcYW9+rmM9/gROjWzC5X8DfdyxyAngbPj6V1JRAu0K3YYCk+44j+5me4QXLrG1tEDlaNhYykaxxme2Wx9xvA8MA28ht4GZoNK4e1YvG2fEFvLVUrNx0aPsZ2M2r6pnsrKW8yudBZaxEktVEGUwgyAttJJynGtD/YwTHw32+AhVRN6Ms3wO1xTHfM0HU5yqjhfyNn5QtF1fkgFIZqPQX0WycANDQEkMfbZnkQnLM4klL4k16xGn8spyBFiC65zb6Vxvoi6hZhxx2BgjHi4VW8TI2VPSBU220anD4lQk2teZfaH/tIF1SV9ZRepfqgUN++fcOT3wUergLgSat8TRjMrKcGfWe5lcxPPLf2XKbEJFXp8pYRv6K0Q7p2BnPXEUJPvL1Q6POyCvl9ruAFBnreOCY9DrjZFeGQawh3QvMfc7uzTuIOHqnWsqM6wR2K38nW/4Pi7jy9Ya3rPJ+C0iWfVJxJty+eLeJwBZez7ZWVyr5T0R/OY/VqHUZy8j3EGmQNFyROzMpzYis/McvrP/1FpXMFcN5Wuddvz86J+bKnmax3QMOAOV8o0EZmElr5W69RVz8x/BnFEp9qAVQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0187dafa-d1d7-4435-4afd-08d83f787e6f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 11:03:22.4362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2xNQF/0pvhf8Gl34bswz9+DExEGMk9LEUCmAa+l2wv6qzaNtFREKqPAaM5Bbfrr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3524
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/8/13 =E4=B8=8B=E5=8D=886:48, David Sterba wrote:
> On Thu, Aug 13, 2020 at 02:15:33PM +0800, Qu Wenruo wrote:
>> There is btrfs specific check in btrfs_copy_from_user(), after
>> iov_iter_copy_from_user_atomic() call, we check if the page is uptodate
>> and if the copied bytes is smaller than what we expect.
>>
>> However that check will never be triggered due to the following reasons:
>> - PageUptodate() check conflicts with current behavior
>>   Currently we ensure all pages that will go through a partial write
>>   (some bytes are not covered by the write range) will be forced
>>   uptodate.
>>
>>   This is the common behavior to ensure we get the correct content.
>>   This behavior is always true, no matter if my previous patch "btrfs:
>>   refactor how we prepare pages for btrfs_buffered_write()" is applied.
>=20
> Would it make sense to add an assert here? Checking for the page
> up-to-date status.

We can have page without uptodate bit.

Uptodate is only forced for partial written pages.
For pages that would be completely covered by write range, it doesn't
need to be uptodate.

Thus the ASSERT() may be more complex than what we initially thought,
but may still be feasible.

>=20
>> - iov_iter_copy_from_user_atomic() only returns 0 or @bytes
>>   It won't return a short write.
>=20
> And maybe for that one too, I'm not able to navigate through the maze of
> the iov_iter_* macros.

Well, after more digging, we have similar check hidden in other location.
In fact fs/buffer.c has its block_write_end() which do the same check there=
.

So I'm afraid unless we go through the whole maze, it may still be a
problem.

The current theory would be a write in a page, but split into several
different iov, thus we can still write some iov, but fails the
remaining, thus lead the problem.

Please discard this patch.

Thanks,
Qu

>=20
>> So we're completely fine to remove the (PageUptodate() && copied <
>> count) check, as we either get copied =3D=3D 0, and break the loop anywa=
y,
>> or do a proper copy.
>>
>> This will revert commit 31339acd07b4 ("Btrfs: deal with short returns fr=
om
>> copy_from_user").
>=20
> As this is a very old patch, the changes outside of btrfs are likely to
> make the piece of code redundant.
>=20

