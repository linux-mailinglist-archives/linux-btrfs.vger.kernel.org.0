Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47DBC26D336
	for <lists+linux-btrfs@lfdr.de>; Thu, 17 Sep 2020 07:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIQFql (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 17 Sep 2020 01:46:41 -0400
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:29029 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgIQFqe (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 17 Sep 2020 01:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1600321588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=ErWFnKfpV25QPG4Io87D1dSK5VoHKlgKYE5zQS4un3k=;
        b=CkLPQ3AV2Q0gSTSpSm3i+OV71/tT3uXtTvvMeaF78j9eZT5i053hAuP6zRQQ+LQPn4w3tW
        LTnYXxczzF7MlBTpmd/gdH1lsExMBN0jh7/1iaxjx8RP2KZ3e4/fA47DmOaYViiYUKcGSz
        QFxYv0GA428sIMZkB1jVJKh39vUprzw=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2055.outbound.protection.outlook.com [104.47.8.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-6-8WvQ52luMy27Apdke6jjLw-1;
 Thu, 17 Sep 2020 07:46:27 +0200
X-MC-Unique: 8WvQ52luMy27Apdke6jjLw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSKdgyelfZgOHTMtGI3QJ/RBwRicdFKDztK9aJAA6DVW08X7mV4mxg6UVnsCaa+4xcprCeBOI5nZNzkRwlSUIKNYjHNsTHJFgOW64J3f/33QT0pLX1Hwoeifw8MpCyKU78JFDUhf5xORiMs0on4pvipOu3bSEaMr2L2rlYX5HilXS55xnOwKk2uKM9WldQw+7lsTyiwFS/lXeCUlDrvJZ4mRb+9h6b6CEArxD+mWDspgDWoLyviH36S/Qicm6JQeZrNWDxp3E61Bn0Fsy+qnFTDZgtKmW3hYh38KXekeNQlAp+VEbrOF40aMoyJRD3hRZt64CC1ScJvJ5FHp1P0bdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xNnhw2fU9ezCAZ5Sa9D6jdg+gOV3r9aWIOTWCCZtDjw=;
 b=CKhQ5lq3vD1o6CXvJhrRcZwgVCq6N3uuOYMWhAY1J8/wWoRaQcXpHAgoFlcW0fp9Bho/l+C6i34p8tY49Sz9/y9vFPRYVsC94LY57gZd/BPFtiL3Xkv+cyy/qN+DXc9Yi8kUI/wS5n2MlvR2d5T/SDr9e3ziELE+K90Y4CspUpM/sP7zWy4C2mRhDE7dTOLTelUetw99JRjTV4/cqs62lec751jFYCsHWBxp5cd6OnvWflrd8YoS1e+uHh7vDIov+L3pECSZSPq5plqXE3ratz4o34qnxmRAwt+tf2G6iwzpbktNxpBBexnScrM0oUNtlO91NOaAy6FDr3Da5emUQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com (2603:10a6:208:13c::13)
 by AM0PR04MB5714.eurprd04.prod.outlook.com (2603:10a6:208:12c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.18; Thu, 17 Sep
 2020 05:46:26 +0000
Received: from AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315]) by AM0PR04MB6195.eurprd04.prod.outlook.com
 ([fe80::e9b0:22ea:e2da:1315%5]) with mapi id 15.20.3370.019; Thu, 17 Sep 2020
 05:46:26 +0000
Subject: Re: Need solution: BTRFS read-only
To:     Thommandra Gowtham <trgowtham123@gmail.com>,
        Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     linux-btrfs@vger.kernel.org
References: <CA+XNQ=ijYZbtTejEcdfgOAgmUu68d7c2YL-3BLQfokq3YYuZNQ@mail.gmail.com>
 <9b5706c1-fe21-6905-9c42-ffdc985202d9@gmx.com>
 <CA+XNQ=j1=XObwis138fphNcRVfwgXUcfm7JW1FJG2UWm8pBEGA@mail.gmail.com>
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
Message-ID: <9415e33b-c018-7a60-33c5-4d2b992bca80@suse.com>
Date:   Thu, 17 Sep 2020 13:46:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <CA+XNQ=j1=XObwis138fphNcRVfwgXUcfm7JW1FJG2UWm8pBEGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR05CA0077.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::18) To AM0PR04MB6195.eurprd04.prod.outlook.com
 (2603:10a6:208:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR05CA0077.namprd05.prod.outlook.com (2603:10b6:a03:e0::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend Transport; Thu, 17 Sep 2020 05:46:24 +0000
X-Originating-IP: [149.28.201.231]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d131415d-a802-4e0f-2eed-08d85acd049c
X-MS-TrafficTypeDiagnostic: AM0PR04MB5714:
X-Microsoft-Antispam-PRVS: <AM0PR04MB5714ED7B4C68FD4019B761D6D63E0@AM0PR04MB5714.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZDKt6XnpVZRye57NQTjHFbeJcgfALum77vbdjuJNep0JQnCuA3llh452+lUUoIYgyxWKyRIWreNh1SAAFONczFBLNj1pm/zOQgPRAtpgQqxkC0bt5Rr+56qruJ6BHwo4Q+lvY2+fAmbmECWnjJ9uFbWiycpNqjSfIcpTd1bTXT5/e1hqxBsbDiPhkm5Vc5dfcfYBn1X06JoJ9f1juOcAlp/YrE/8YxnVgVmcTPL1e4pxkJJZ9oa+ac2MKLOcr5GI/+U7qvtTHrCihziSDNOaX8fRNNWBrpB82BKKBD6sQBWyBpME7PWMSOOnYGHzwkJEYnNhREOUd8wSd6viBX5nzBF8BS4IkRB+tiSqqtqfXkpKkiZL/JDcSaPzG0KIiWh0nUU33iL8vAf67iF/u5re3Wm4VwUYlW40uz8XcUa6/fLT1gXIOZSN8X0BGXxhXG5k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6195.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(346002)(39860400002)(136003)(83380400001)(16526019)(2906002)(4326008)(478600001)(8676002)(26005)(52116002)(86362001)(6486002)(186003)(2616005)(31696002)(16576012)(6666004)(5660300002)(8936002)(53546011)(6706004)(36756003)(110136005)(66946007)(316002)(66476007)(956004)(66556008)(31686004)(518174003)(78286007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4QyakBU6CgkW4ReA0186La+DnGck0i0Xn6vVMZjZMK6TKWdubd3nbzD/85/bDf/Dw+FPHKrR5yCnAQiRdXJw8q3xKAwf5IJiMPS1jyNx4tLYdTzpOWZxDO748qlOKvMlLtqya2YCdTdqTg2Tp6JqxWl0vhUB2G2ZXVTMjLre+n+eMHLLjolvQSTwBMv+MwbpXQN7cuOSrvf558iPhnidYzsgNrryCu2Ao9nktQjWIhldsooZXly7eM3y/+/XqC9EEOVj5TEdiBBGyhYwrTBhWhSsC59i33Mq7J6BpjgZY1cfdZyz2qwLoRcas1ml/gqEmGwGPitMoVgdAaykzjMJy55W+3ME7iIpRQTKNqtGpDYlIzNKekkyvS2uFT3MhkVE8WcPXD23mXEdlvxtT/EZw2Y0KnWtOABaF6PDEomvGig7DRhrNY0zHvmmYL8acLHQMREdyiX8/Ndj8qXZ2tU7AZQwZ8n04kxToznTPaf44017LPcJ001Dp1PSNrGLkxkDJRxPEuYYtkCsDPoYQLMULTTo6S5z0yUfU0m2ZgsfAYSY9y9hneGh2QX2+KPVewRl+LWYzPbTtAx1IlFVqCwcztHAkUkKhoFY8MvWbcemPNkay8/8Ouwubr39/JhNIMBnzqKKUScw7Bp5Sgy3WJGyZQ==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d131415d-a802-4e0f-2eed-08d85acd049c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6195.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 05:46:26.6444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2L105WwXR5ooXxneNBZy41s+lCnSVOGq/w1/QcE9dnwEW2mU0qAVqHSKqg515tS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5714
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/9/17 =E4=B8=8B=E5=8D=881:26, Thommandra Gowtham wrote:
> Attached the dmesg file.
>=20
> I think the primary cause are the below issues

It's really better to see the first btrfs related error to grab a full view=
:

> [   10.565736] BTRFS error (device sda4): bad tree block start
12455654870318135914 4455038976

This shows that, we want bytenr 4455038976 (0x1098a8000), but got
12455654870318135914 (0xacdb601c962d3a6a), which is completely garbage.

And according to the later more similar error messages, this means a lot
of your metadata are already filled with garbage.
This looks like a big problem already.

What makes the problem even worse is, there is no duplication for your
metadata, thus btrfs can't grab a good copy.

So far, this already indicates your fs is heavily damaged by losing tons
of its metadata.


But so far, btrfs is just failed to *read* tree blocks, not yet enough
to force the fs read-only.

The killing blow happens here:

> [   41.892643] BTRFS error (device sda4): bad tree block start
16883770880424882955 4455632896
> [   41.902071] BTRFS: error (device sda4) in __btrfs_free_extent:6997:
errno=3D-5 IO failure
> [   41.911097] BTRFS info (device sda4): forced readonly

When btrfs tries to read extent tree block to update its extent tree, it
failed due to garbage on-disk data again.

And extent tree update is vital for btrfs, if it fails btrfs has to
force the fs RO to prevent further problems.


So your fs is too damaged to grab most tree blocks and finally leads to
fs RO.

According to the error pattern, a range of garbage overwrites btrfs
metadata, and this looks more like a hardware problem.

Thanks,
Qu


>=20
>    43.066928] BTRFS warning (device sda4): checksum error at logical
> 166334464 on dev /dev/sda4, physical 166334464, root 288, inode
> 350101, offset 2965504, length 4096, links 1 (path:
> var/etc/vport/vport.mtable.5)
> [   43.069662] BTRFS warning (device sda4): checksum error at logical
> 166334464 on dev /dev/sda4, physical 166334464, root 285, inode
> 350101, offset 2965504, length 4096, links 1 (path:
> var/etc/vport/vport.mtable.3)
> [   43.072073] BTRFS warning (device sda4): checksum error at logical
> 166334464 on dev /dev/sda4, physical 166334464, root 284, inode
> 350101, offset 2965504, length 4096, links 1 (path:
> var/etc/vport/vport.mtable.0)
> [   45.330412] BTRFS warning (device sda4): checksum error at logical
> 440729600 on dev /dev/sda4, physical 440729600, root 269, inode 11983,
> offset 3682304, length 4096, links 1 (path:
> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> [   45.330532] BTRFS warning (device sda4): checksum error at logical
> 440860672 on dev /dev/sda4, physical 440860672, root 269, inode 11983,
> offset 3813376, length 4096, links 1 (path:
> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> [   45.330542] BTRFS warning (device sda4): checksum error at logical
> 440668160 on dev /dev/sda4, physical 440668160, root 269, inode 11983,
> offset 3620864, length 4096, links 1 (path:
> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> [   45.332656] BTRFS warning (device sda4): checksum error at logical
> 440729600 on dev /dev/sda4, physical 440729600, root 256, inode 11983,
> offset 3682304, length 4096, links 1 (path:
> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> [   45.337842] BTRFS warning (device sda4): checksum error at logical
> 440860672 on dev /dev/sda4, physical 440860672, root 256, inode 11983,
> offset 3813376, length 4096, links 1 (path:
> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> [   45.337977] BTRFS warning (device sda4): checksum error at logical
> 440668160 on dev /dev/sda4, physical 440668160, root 256, inode 11983,
> offset 3620864, length 4096, links 1 (path:
> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
> [   45.392220] BTRFS warning (device sda4): checksum error at logical
> 440672256 on dev /dev/sda4, physical 440672256, root 269, inode 11983,
> offset 3624960, length 4096, links 1 (path:
> usr/lib/x86_64-linux-gnu/libicudata.so.52.1)
>=20
> On Thu, Sep 17, 2020 at 10:42 AM Qu Wenruo <quwenruo.btrfs@gmx.com> wrote=
:
>>
>>
>>
>> On 2020/9/17 =E4=B8=8B=E5=8D=8812:52, Thommandra Gowtham wrote:
>>> Hi,
>>>
>>> We are using BTRFS as a root filesystem and after a power outage, the
>>> file-system is mounted read-only.  The system is stuck in that
>>> state(even after multiple reboots) with below errors on console
>>
>> Please provide full dmesg.
>>
>> The provided dmesg doesn't provide much help to show the root cause.
>>
>> Thanks,
>> Qu
>>>
>>> [   35.099841] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
>>> rd 0, flush 0, corrupt 1, gen 0
>>> [   35.109822] BTRFS error (device sda4): unable to fixup (regular)
>>> error at logical 166334464 on dev /dev/sda4
>>> [   37.500975] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
>>> rd 0, flush 0, corrupt 2, gen 0
>>> [   37.510993] BTRFS error (device sda4): unable to fixup (regular)
>>> error at logical 440860672 on dev /dev/sda4
>>> [   37.522128] BTRFS error (device sda4): bdev /dev/sda4 errs: wr 0,
>>> rd 0, flush 0, corrupt 3, gen 0
>>>
>>> Is there a way to make BTRFS delay moving the filesystem to read-only
>>> after a reboot so that we can scrub the FS? Or is there a code-change
>>> we can use to modify the btrfs module to affect this change?
>>>
>>> Regards,
>>> Gowtham
>>>
>>>
>>> mount options used:
>>> rw,noatime,compress=3Dlzo,ssd,space_cache,commit=3D60,subvolid=3D263
>>>
>>> #   btrfs --version
>>> btrfs-progs v4.4
>>>
>>> Ubuntu 16.04: 4.15.0-36-generic #1 SMP Mon Oct 22 21:20:30 PDT 2018
>>> x86_64 x86_64 x86_64 GNU/Linux
>>>
>>

