Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A49B2718FE
	for <lists+linux-btrfs@lfdr.de>; Mon, 21 Sep 2020 03:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIUBVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 20 Sep 2020 21:21:52 -0400
Received: from de-smtp-delivery-102.mimecast.com ([51.163.158.102]:55598 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbgIUBVv (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sun, 20 Sep 2020 21:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600651307;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=U/B8THgmar16dYnS00scAUankAlB7rxn7uRWuOG9AJA=;
        b=hm//tvt8Z7sEBtaCxWXTyFfA8JDUjWAKNQpBg46RDDijYVcmGBFxSTShEs+kdYGt/tK4xp
        M7yoVrWbeNAo+O+PORmLwnKi6rFoMs3fPGMEyG0PY17M6y31MJsZ0P8BmngPqzpjnZo/qS
        NFe+gcJ1DOTAQ6wv81RYjOryDpAVZwE=
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2111.outbound.protection.outlook.com [104.47.17.111])
 (Using TLS) by relay.mimecast.com with ESMTP id
 de-mta-11-bmb4Z0bEPdSn8tDrg4GXXw-1; Mon, 21 Sep 2020 03:21:45 +0200
X-MC-Unique: bmb4Z0bEPdSn8tDrg4GXXw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0uXi4XimNPHNKZ8VSYqiFfeCqXlD79pJWYuSh84q8qKRqMBz6f2VUtApFzeyF7WcI8qXrXLAC3kPHLXj/TGWMIi2LAKDnJ1rUOyEmYXpa1a02+SB5NTIq4ZtmYleEaF1eRSwrEWGlYwKraPfjRtRerH6LNOHAEBTHJJmXl1B7Af7wNr5v1egh/vsSF6TQISx5KKd8639b+16W4jWmgAgwKwgxDGkZq0WgD4qWFOTRTgkV3w75LdWOyiq4C/TPPiGplpeDdMvJL1Wr1+NYFP26v+NXf1A1skTj6U/05K7/tgMlCitmvmf0EOCZ6U0n2AotAsVk0tS0qfVkm0u4rLSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+1awa5igRWhzJMsNluTJ/25Bx1OkwpCuFiFyvdurhg=;
 b=MQfmkuVKlS3XZ1+KctTfv9iSTkanDtY7VE7xW1qgFnJ+ztON4LPv6zH9p77hX+uMW/1faHA5YMRuEZrfGDqY2eaQ9GGI+aqIQDMUiguorpd38M53Pov1CDscKUDqXsq8S2QT7NfFaoC7Za4781zGE+WAYqPtS1+ZIGEUFyPIK+5ko1yqTDaCHULuTMZ/j9vANdw/v0p4u9hXaNgSG5ce3RHHBUCrySUJKEwjAu5oAvhDdeiZ8ASNSrFvOrYq2/7vmXaUzeJNBd4BEMkInsaMwNwKfZXX8/VxdViSvwJtH3ZYQ6sn4el6KcSuadMyBfdZWc5k/q61gxMc0g/cvNsjsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR0402MB3841.eurprd04.prod.outlook.com (2603:10a6:208:e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Mon, 21 Sep
 2020 01:21:44 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3391.024; Mon, 21 Sep 2020
 01:21:43 +0000
Subject: Re: [PATCH] btrfs/022: Add qgroup assign test
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
CC:     Josef Bacik <josef@toxicpanda.com>
References: <20200920085753.277590-1-realwakka@gmail.com>
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
Message-ID: <585901fa-663a-b9e6-3f2f-9d060cd345c7@suse.com>
Date:   Mon, 21 Sep 2020 09:21:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200920085753.277590-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47)
 To AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR01CA0070.prod.exchangelabs.com (2603:10b6:a03:94::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.13 via Frontend Transport; Mon, 21 Sep 2020 01:21:41 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f65f787-763b-4de6-693b-08d85dccb344
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3841:
X-Microsoft-Antispam-PRVS: <AM0PR0402MB38415864C4724E62816C7186D63A0@AM0PR0402MB3841.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mIHYYxWz109VMPLaEnbCbkaJF+OP7cBBIAcgX2RHJiSg+N7sCWU44ltvG2YTWHZb83AaGS1swUorQ3zcuOGWun5BHeDOoGFjZ+zgSom1sDN2VSjc0gNVwnqmA69c+Xfpo1wVjR6idqsy/jch3FTR/4Me9rmwacGWzAfhD3YGr4Z7rWKCygq8DST9C/K4HS1crWqeBYxvddO00WNZfQszo2+1KU/ny59Xnl+TZbAINBHsOcvZpkAniw6qu3cNiaRM3XkOi6fgD1afhK+2Woud7dM/eEqiYwHd2mcqnXWl0qJheqdksNCXtzE68AYNA+W91Ihl55MaJSTApko0WWpe4HoPZkbYfyMWzxBbmtllfIgRObF0fWdg4rCwx/EjOO+TXos4MqycAZrRPuikqjHscgyIo5+smcozpPkHA7/yYdaDri8tVWyOy1Me2GYGZFO8GMA6R4h8qZYQZAaxU+fYdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(136003)(366004)(39850400004)(52116002)(26005)(36756003)(5660300002)(16526019)(186003)(16576012)(4326008)(316002)(66946007)(2906002)(956004)(83380400001)(2616005)(31686004)(31696002)(8936002)(6486002)(86362001)(8676002)(6666004)(6706004)(66556008)(66476007)(478600001)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: kz/AdCx29ZJMs2myOKvRVpugrpQOiwQxZhHR3fHBWhKxqlKlIfyDhVVqSO57fuhb9HvDzTIg6rwwcx9X3iy8+ccIuezDu1P1K/5GChYWan1swH2DGUmBeT73CMDhF6eJwmSKEkz7qmlVLAnESLOde5irVMVXmyz6QzjDEZWfJPHBbXYC0Gx3EzatyhfwBxegEatkOfpCNoqIPMEDGCEjulzJP28IKzOcqS69BS6ZUqnxGg0+4fvA2GnyFJ8hyoCx+pNvnAE9xCgIk25dEwgUGljhrUJZRaQbeVuWC8klAV1Kw/AHW0BNKr2ghuEed5+NMIj/+aVUlEMvMaV3WkNdq/bZo5whLH4HnmTln30kRu+Sz+emvR810DK2Pcwo26rcqBD6RQx177QeWJ+gjj6ulOwZNtWoNZNOvLhtrDHd9hBDtOpQw256OiQWOwK24S9nhvmtIquH5AAUX4xLKbQqUfvEr4PMxPTHgAd4azZ/KvmAWUsEQxMWMzwCdepqpm2N5wR3gaO9AE5atuWPpCBs5dcoFd+Wj5YyB5w1nnvEEzeUOSbzcmikwly6m1QgQnZrdphdoBXBPNIzNYegTVWRkZrOfRdRPiOYwyO2ACIhijSFbII5Pw2Mm/MmpnGlO03+2nnFI7o+ApHv3emvFVr53A==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f65f787-763b-4de6-693b-08d85dccb344
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2020 01:21:43.8020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Ya8X6IMx6TEvpFc6nZuUSra2jkwikgXaz8R1wPNZKQ1JFI/fYQvD4hCj/pgIjRa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3841
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/20 =E4=B8=8B=E5=8D=884:57, Sidong Yang wrote:
> The btrfs/022 test is basic test about qgroup. but it doesn't have
> test with qgroup assign function. This patch adds parent assign
> test. parent assign test make two subvolumes and a qgroup for assign.
> Assign two subvolumes with a qgroup and check that quota of group
> has same value with sum of two subvolumes.

A little surprised that I haven't submitted such test case, especially
we had a fix in kernel.

cbab8ade585a ("btrfs: qgroup: mark qgroup inconsistent if we're
inherting snapshot to a new qgroup")

Despite the comment from Eryu, some btrfs specific comment inlined below.

>=20
> Signed-off-by: Sidong Yang <realwakka@gmail.com>
> ---
>  tests/btrfs/022 | 40 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/tests/btrfs/022 b/tests/btrfs/022
> index aaa27aaa..cafaa8b2 100755
> --- a/tests/btrfs/022
> +++ b/tests/btrfs/022
> @@ -110,6 +110,40 @@ _limit_test_noexceed()
>  	[ $? -eq 0 ] || _fail "should have been allowed to write"
>  }
> =20
> +#basic assign testing
> +_parent_assign_test()
> +{
> +	echo "=3D=3D=3D parent assign test =3D=3D=3D" >> $seqres.full
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/a
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +	subvolid_a=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
> +
> +	_run_btrfs_util_prog subvolume create $SCRATCH_MNT/b
> +	_run_btrfs_util_prog quota enable $SCRATCH_MNT
> +	subvolid_b=3D$(_btrfs_get_subvolid $SCRATCH_MNT b)
> +
> +	_run_btrfs_util_prog qgroup create 1/100 $SCRATCH_MNT
> +
> +	_run_btrfs_util_prog qgroup assign 0/$subvolid_a 1/100 $SCRATCH_MNT
> +	_run_btrfs_util_prog qgroup assign 0/$subvolid_b 1/100 $SCRATCH_MNT

The coverage is not good enough.

Qgroup assign (or inherit) happens not only during "btrfs qgroup assign"
but also "btrfs subvolume snapshot -i".

And we also need to consider cases like shared extents between two
subvolumes (either caused by snapshot or reflink).

That means we have two factors, assign or snapshot -i, subvolumes with
shared extents or not.
That means we need at least 3 combinations:

- assign, no shared extents
- assign, shared extents
- snapshot -i, shared extents

(snapshot -i, no shared extents is invalid, as snapshot will always
cause shared extents)

> +
> +	_ddt of=3D$SCRATCH_MNT/a/file bs=3D4M count=3D1 >> $seqres.full 2>&1
> +	_ddt of=3D$SCRATCH_MNT/b/file bs=3D4M count=3D1 >> $seqres.full 2>&1
> +	sync
> +
> +	a_shared=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0=
/$subvolid_a")
> +	a_shared=3D$(echo $a_shared | awk '{ print $2 }' | tr -dc '0-9')
> +
> +	b_shared=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "0=
/$subvolid_b")
> +	b_shared=3D$(echo $b_shared | awk '{ print $2 }' | tr -dc '0-9')
> +	sum=3D$(expr $b_shared  + $a_shared)
> +
> +	q_shared=3D$($BTRFS_UTIL_PROG qgroup show $units $SCRATCH_MNT | grep "1=
/100")
> +	q_shared=3D$(echo $q_shared | awk '{ print $2 }' | tr -dc '0-9')
> +
> +	[ $sum -eq $q_shared ] || _fail "shared values don't match"

Nope, we don't need to do such complex checking all by ourselves.

Just let "btrfs check" to handle it, as it will also check the qgroup
numbers.

Thanks,
Qu

> +}
> +
>  units=3D`_btrfs_qgroup_units`
> =20
>  _scratch_mkfs > /dev/null 2>&1
> @@ -133,6 +167,12 @@ _check_scratch_fs
>  _scratch_mkfs > /dev/null 2>&1
>  _scratch_mount
>  _limit_test_noexceed
> +_scratch_unmount
> +_check_scratch_fs
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +_parent_assign_test
> =20
>  # success, all done
>  echo "Silence is golden"
>=20

