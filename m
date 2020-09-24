Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88B8D276819
	for <lists+linux-btrfs@lfdr.de>; Thu, 24 Sep 2020 07:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgIXFId (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 24 Sep 2020 01:08:33 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:24829 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbgIXFIc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 24 Sep 2020 01:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600924108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=5TOuyrrVbhz42jLB8ZNy8xafolLdUx3sMQ5hdSrHlqE=;
        b=Mqb65tl1px8+ebuNXzQy7K+k/T6VpACdWO1kz87D7LcekPMnjJd/rfJfVpLea0RMarxGmO
        NiCvufqNNNERkGLbyDZyXvXniwa2tMy0Fczc3GtQXAy/1DYESB8Za0kfOmG1rNRrmv3S/L
        F8LyjvjQxWvOAYDNNGWDvaoCSKKxigk=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-22-2nlqWkGhO-GLqCEcznCA0w-1; Thu, 24 Sep 2020 07:08:26 +0200
X-MC-Unique: 2nlqWkGhO-GLqCEcznCA0w-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8/FBZPXDwoffOdue9u3ZuFmFBBZ6yxgIMVMBbBFHBfyAwaS/cpf0/kYRX3tbpvFfaodwIRxmhcR6/EwEQh2RZmr1oSYRoGGhW512wv+SzJO6nYeTbgbHJC8p8zVJozMiBP1eaCU53ngu96HGowGzrAhiu6pJvmLPyqX7bBxphNdQf3tCQIpmy5zTPPhDbVKbICoN3BoLizRTUx3obWvqpGyPCLzR6rxiIsOTEbexCbZjNS78Byntwbb3TPwHiT8+pFHEov9iVexXV1rIQEDTzuab7J2+hFXTC6gl8mEfNJDjKP3HmlZ+Z+6CMzyejZ7BJ89HtRPgidtj9DYBo0ghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5xJifC4eHUM9fgaarkxzc2O70jKYp1fPfoUhQAGHKY=;
 b=aF+p04i3Hoz39F7ulKKzEvM9gUMEEex3wS7hjlCi5aWS6IYy5uP1mMdimc4VNynZAsRMitFMVZ9q15BWqJzNdYfVmdjLLUkM2Beq9DQxx1jhVP5+hO1xGv78nTlz58q0rnq5BFcgc2x5e7QMH/HEcUxCUZFNzwq+tEkvLrsqukPFvQpv0A7dmpU/NFiC3/g+/SLsIdYDGxsNHZNrMM1iHa6fOC6AKRITjwOt0cXldVfAE2y2GNYohQu5BP8b5a2foa/e3ogyuFXqOpmr0n/i6YzStHSVScLea19KXOaujm+9tFQNg3S2IbjocoqOj9lKAvcz6hmvupEiFwQ496ViIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: eryu.me; dkim=none (message not signed)
 header.d=none;eryu.me; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM8PR04MB7236.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Thu, 24 Sep
 2020 05:08:25 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 05:08:25 +0000
Subject: Re: [PATCH v3] btrfs: Add new test for qgroup assign functionality
To:     Sidong Yang <realwakka@gmail.com>, linux-btrfs@vger.kernel.org,
        fstests@vger.kernel.org
CC:     Josef Bacik <josef@toxicpanda.com>, Eryu Guan <guan@eryu.me>
References: <20200924041146.32577-1-realwakka@gmail.com>
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
Message-ID: <d67277a5-c0a9-cee5-cddd-54ab8610fc41@suse.com>
Date:   Thu, 24 Sep 2020 13:08:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200924041146.32577-1-realwakka@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::47) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR03CA0034.namprd03.prod.outlook.com (2603:10b6:a02:a8::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.22 via Frontend Transport; Thu, 24 Sep 2020 05:08:22 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4b34a28-fce7-4993-bb6a-08d86047ddb3
X-MS-TrafficTypeDiagnostic: AM8PR04MB7236:
X-Microsoft-Antispam-PRVS: <AM8PR04MB72366013C764EE58C29BD1BCD6390@AM8PR04MB7236.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qa128ig9Ku3JbMpuOlZ2osBwp0G0AjKqqECen6hNa61KZIIjeVVmDeiaNqeUw03v6r/vAFJMxdR+6hbNEQ7l5+z8PwPhy87XiXb0izTzI/3My8vcahPXPaDCD4r0amo17IAwVMOiZ90zvm76LaxZ9DbDQw8VNJM0PN/YvN1eUAMedqGY6nRHzh+muboyPblOEy/WVe+TbQAcqgrQAPAEFbO8D+poqXBOBz3toOzqo0jj8rqBHm5HxBXWnNT8q+o4Q5wUCyJbNMpTFQSMn5d13phpKDLVVNAjTzutz8wRQvW/eo9/x+ji5ko24A4OXsjxFKRa/l8egkdzFzeZ1Pzyo4hzs31OJ3d+zR88pUt0lOMqsqRT8rm3gXpKRhq5ngqfjh8NkTUryOJpZcCn6oxPiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39850400004)(346002)(376002)(136003)(52116002)(186003)(16576012)(478600001)(36756003)(86362001)(26005)(31686004)(6706004)(4326008)(6666004)(6486002)(5660300002)(16526019)(316002)(8676002)(2906002)(66476007)(83380400001)(54906003)(66946007)(31696002)(956004)(2616005)(66556008)(8936002)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mIhRoQh5UJL0OeNdPtWuMZvw2lxgtXBfTwQrvCgCV0MRNOzkGyjbj+nlLWvaQs6oCPXMrGVKipcqgsauTj6l8tcW3Yt3DL8DPd3Q9u8CFtygN363cgJDMsI/J2vEoVeQtH5KZ9SGLJaxoiWfislK4/YoPebk59bdmVdTfuRdv8NesKMBn9N6WqPOOqPlBukEdygZBAcU6COwuktEYtwmTr0/57Yq23zqRuUsJSFPLMNPwePK5kHXqUKU48zBrnGE9ItWuLsWRpYFPNEO/hdmkq0EcHEfbWb1e2QP3kjPTqVari61ajY97qLSLM3xe+BtXTyBalgSrKkjXQDUOf/ec8s8Km5bdvF7xbmW1XIYyVOp1QpVb2b7u1Vd2ZGEDY6Zpt53bTcNiA7kIYuz97wz1CmA7EXjLJUleXowRc6uo/QXfHGiq/JTke4mmxtFfED7jZn+uqw6Y9A2ITflHHwBLwA3BmWV+g7w0xRvf8vG2jOGPfxeAXdzZ2ivNdhFBjZg5uW+osFkoeIpxL+v7RBYeFTTKVWZul8+hMM1clECaLlHrDbMHRMu1qEOJsPF3rwSOZPIVbLC5+nhgVimwm4zodNgkj1/IhKqeaxBlafiDEMtjAOu0VujsQGF0CyWV2l6egLvTxWlUmM3T81ypnNoOQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b34a28-fce7-4993-bb6a-08d86047ddb3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 05:08:25.3372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfiFQSmMDAyDAy53WA42fgIIi6DfXcNo4AjHBnQ0dy7d/BuMKMdkAnqL17Cm9rNu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7236
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/24 =E4=B8=8B=E5=8D=8812:11, Sidong Yang wrote:
> This new test will test btrfs's qgroup assign functionality. The
> test has 3 cases.
>=20
>  - assign, no shared extents
>  - assign, shared extents
>  - snapshot -i, shared extents
>=20
> Each cases create subvolumes and assign qgroup in their own way
> and check with the command "btrfs check".
>=20
> Cc: Qu Wenruo <wqu@suse.com>
> Cc: Eryu Guan <guan@eryu.me>
>=20
> Signed-off-by: Sidong Yang <realwakka@gmail.com>

This version is much better overall.

The remaining small problems are mostly fstests related then.
...
> +# Test assign qgroup for submodule with shared extents by reflink
> +assign_shared_test()
> +{
> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount
> +
> +	echo "=3D=3D=3D qgroup assign shared test =3D=3D=3D" >> $seqres.full
> +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
> +
> +	_ddt of=3D"$SCRATCH_MNT"/a/file1 bs=3D1M count=3D1 >> $seqres.full 2>&1
> +	cp --reflink=3Dalways "$SCRATCH_MNT"/a/file1 "$SCRATCH_MNT"/b/file1
> +
> +	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
> +
> +	_scratch_unmount
> +	$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1

We have _check_scratch_fs() function to do it properly already.

> +	[ $? -eq 0 ] || _fail "btrfs check failed"
> +}
> +
> +# Test assign qgroup for submodule without shared extents
> +assign_no_shared_test()
> +{
> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount
> +
> +	echo "=3D=3D=3D qgroup assign no shared test =3D=3D=3D" >> $seqres.full
> +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT

It's recommended to call "quota rescan -w" to ensure we finished rescan.

As fast enough system can go to next command before the auto rescan even
finished.

Not sure if Eryu would have extra comments.

Thanks,
Qu

> +	$BTRFS_UTIL_PROG qgroup create 1/100 $SCRATCH_MNT
> +
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/b >> $seqres.full
> +
> +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/a 1/100 $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG qgroup assign $SCRATCH_MNT/b 1/100 $SCRATCH_MNT
> +	_scratch_unmount
> +
> +	$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
> +	[ $? -eq 0 ] || _fail "btrfs check failed"
> +}
> +
> +# Test snapshot with assigning qgroup for submodule
> +snapshot_test()
> +{
> +	_scratch_mkfs > /dev/null 2>&1
> +	_scratch_mount
> +
> +	echo "=3D=3D=3D qgroup snapshot test =3D=3D=3D" >> $seqres.full
> +	$BTRFS_UTIL_PROG quota enable $SCRATCH_MNT
> +	$BTRFS_UTIL_PROG quota rescan -w $SCRATCH_MNT >> $seqres.full
> +
> +	$BTRFS_UTIL_PROG subvolume create $SCRATCH_MNT/a >> $seqres.full
> +	_ddt of=3D"$SCRATCH_MNT"/a/file1 bs=3D1M count=3D1 >> $seqres.full 2>&1
> +	subvolid=3D$(_btrfs_get_subvolid $SCRATCH_MNT a)
> +	$BTRFS_UTIL_PROG subvolume snapshot -i 0/$subvolid $SCRATCH_MNT/a $SCRA=
TCH_MNT/b >> $seqres.full
> +	_scratch_unmount
> +
> +	$BTRFS_UTIL_PROG check $SCRATCH_DEV >> $seqres.full 2>&1
> +	[ $? -eq 0 ] || _fail "btrfs check failed"
> +}
> +
> +
> +assign_no_shared_test
> +
> +assign_shared_test
> +
> +snapshot_test
> +
> +# success, all done
> +echo "Silence is golden"
> +status=3D0
> +exit
> diff --git a/tests/btrfs/221.out b/tests/btrfs/221.out
> new file mode 100644
> index 00000000..aa4351cd
> --- /dev/null
> +++ b/tests/btrfs/221.out
> @@ -0,0 +1,2 @@
> +QA output created by 221
> +Silence is golden
> diff --git a/tests/btrfs/group b/tests/btrfs/group
> index 1b5fa695..cdda38f3 100644
> --- a/tests/btrfs/group
> +++ b/tests/btrfs/group
> @@ -222,3 +222,4 @@
>  218 auto quick volume
>  219 auto quick volume
>  220 auto quick
> +221 auto quick qgroup
>=20

