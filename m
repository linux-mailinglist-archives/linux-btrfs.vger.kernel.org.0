Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175F32CD421
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 12:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgLCLBA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 06:01:00 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:25945 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727007AbgLCLA7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 3 Dec 2020 06:00:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1606993189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=eUqxgjkE5hFzYY3wd1aW7xK8Q0+DTyqcTXFq8uBqARQ=;
        b=b9UsbkluV3cfq67mwizW7OLkjIusfpyfLQuzXCIbRU+bws1i4A4wXwL3d/LIR6Gw+GhP/C
        UR08Rj7qzVRUGq8z0fxXJ1+ffSFek/LVeKi5bXZ40++cNPJam0glgvigALZn/aGuoaE9hm
        H7orqJskpKK2GE+ymquUo576JUgluY0=
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur02lp2051.outbound.protection.outlook.com [104.47.5.51]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-32-bYP6sVujNTWMJ24S891jgg-1; Thu, 03 Dec 2020 11:59:48 +0100
X-MC-Unique: bYP6sVujNTWMJ24S891jgg-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mle6wwTBf3mCEuBVOtI3lNeYuCxejMHhUL/a++6NDuRbvvdF7frvELEBknHg4KZ9DRqii1xk1Q8XOZTYqXE4Hb6yiRN2+OOzOVrOHVTeXuFWCmn8uUs8+j69KxRsuce7RvR7gvU6hrLXmYDAgm5kIs4cNKZ8fAXkwyLV0KQs1D0bG7irvCOBYWCVZTsdjH3xfhs+m6YxUREmsRjtaBD5ED2hIaQGtQ+LFI8CgfpZIub3gvwR/WadBzWoPQUQxvJTy1SLYDsHn3zI9Ttcoxx2OfH6EgXUOshoCgYPHzB0K0hXPMrZ9IdTIXR7PcDO/uTQregQ8U/L6HCOyBrgUd6jrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBZTBdNubH9Q3YrK85ROCayiCCnT57jJ6PrxYfZnJpo=;
 b=mRPyTTWidH7rewtd6wYNyREnCf7bcl2a/EOmK50wwupy4HU47Jij8ay6BM958rI+8/8W0IuEKjYWmb8t5Y4I9cTLcyIMVYmM8MwEAYIdwIJbd5AHLULDMAn34mO4wfbyjVzHyRBYWCgp7OGvGOi1XHGDFF3q70JcgcQIGp7RregFS76d2w+GovjYpbnuQgR8gMa/kOTy+9JXmT/LmR+xX1S0inlVuRSKL3rEEnAYF7jful2kB14QGzMs85Ma7PZLtpdMc728QDw8obwK9RG/nvx8ydoo1gFmjSgB72FQMyz3WwxV+UsQu2tX8jfPQvo7k+FTAK3oGJUMKTCsmPnjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com (2603:10a6:102:f1::19)
 by PA4PR04MB7680.eurprd04.prod.outlook.com (2603:10a6:102:f3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Thu, 3 Dec
 2020 10:59:47 +0000
Received: from PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7]) by PA4PR04MB7533.eurprd04.prod.outlook.com
 ([fe80::545:8a04:2a5c:f4c7%6]) with mapi id 15.20.3632.018; Thu, 3 Dec 2020
 10:59:47 +0000
Subject: Re: How robust is BTRFS?
To:     Jens Bauer <jens-lists@gpio.dk>, linux-btrfs@vger.kernel.org
References: <20201203035311997396.38ae743f@gpio.dk>
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
Message-ID: <f51b636b-0e5f-c3d9-916f-f8196dae4ef0@suse.com>
Date:   Thu, 3 Dec 2020 18:59:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20201203035311997396.38ae743f@gpio.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: BY5PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::14) To PA4PR04MB7533.eurprd04.prod.outlook.com
 (2603:10a6:102:f1::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BY5PR20CA0001.namprd20.prod.outlook.com (2603:10b6:a03:1f4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Thu, 3 Dec 2020 10:59:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a3610c5-25f5-4e45-99dc-08d8977a8c44
X-MS-TrafficTypeDiagnostic: PA4PR04MB7680:
X-Microsoft-Antispam-PRVS: <PA4PR04MB768096623F16D879005E2598D6F20@PA4PR04MB7680.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/Dqcc9jzWDlX2YjGcMXafe3wyi3V8NHXSPEnkWXzUit9G9q8f14uqlwGQH+ZfAO5eDR9RVClzNU8x7QmYX4LpoIlJVM4hv1TPlBLinsnfVgZS2nkHZaChoD/aG+itiOvrGT9CfWDQogdWnamtlooH8yW2Jsml4zECk7Jc6EqkhRJYQhIwfjGYDNJHhXxz9YDjJI3S45sY9r6uX3FQiZnehikqiLsDMvam4tgW4hosgDeNPrDwuL4YQFbGCD8inHo1WB8yUNasxevCj0mMHDxbORACiaiHn/SjEBxuLkVBzSK2b2w6RbgrJKIMhj1bUzYs+AeolNfvSi3p0fgA48j6rHrc8MhVwgm0MuCdhojs/Yl6RqI7Jyxu0VX7Xc4+DKwWzo3ik1fZo7Q308NsbDONvdoPHymS4x1zrEiSG1APtLJ0wRtmkaZIuTN6sJoNLd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7533.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(366004)(376002)(346002)(86362001)(316002)(956004)(2616005)(2906002)(8936002)(3480700007)(6486002)(52116002)(6666004)(66476007)(66946007)(83380400001)(26005)(66556008)(31696002)(36756003)(5660300002)(8676002)(186003)(16576012)(478600001)(6706004)(31686004)(16526019)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?P/f+F14h9tVh+zlMUqW/lrLUhkQ7o/LvAEyG+v9i9sgbre5g97lb3l0IhOKk?=
 =?us-ascii?Q?vnnKiAb2hi/5pxGQwG1/IKYEalcFQl7xOly8sqcs5ZneiJKJw07XYFwaxgwQ?=
 =?us-ascii?Q?s3+9higGrT81lcn9bxuVFYbA9yCiH0v6AuDmOstls2bogb/cAuCc/3rLS5Y7?=
 =?us-ascii?Q?43cvHtt8rSxJWrBqriiNBrlX/YK9cAt61gDbkgXHktN5uT3/bodVEEdTIMAq?=
 =?us-ascii?Q?mr79q4aYpSc2nimxqZtfq3pVsnPsZCaBNfeudMRQguF9CyyVdTReeqmfENI8?=
 =?us-ascii?Q?ZPXspM86TPdb3OulDMegKZ2Iyl7dh/MjeOYelNz8Aq9Sxc1fmuLS9UlssE2i?=
 =?us-ascii?Q?gZr5BsGg1WGpHh5CX/zaCUbYvC9hNSqq6WYeIVSX2ETpYrKGAaCcxGR/Fdib?=
 =?us-ascii?Q?NGIaoty0KLldSJkBvZ77TISKOQHJe0vhnPhdkyldB5Om45WBoVtztZXgxLMY?=
 =?us-ascii?Q?yhrc9csG7bkyHqN1rxSpfY6ZHE6Y+LCokQ+V2rzyS10rcK1mnBix5OGhp9Mw?=
 =?us-ascii?Q?wQIsWMcCeHdru4Ja197Egd7tDwnKJRwvAg+E3m6Fcd0Bk1nm0m/GDrFQt0qq?=
 =?us-ascii?Q?GCyHXT2IiBVBWOuN+w/6eUqu78gusRHjBM5LmTg1bdZX0KSezcfufdnjJL9D?=
 =?us-ascii?Q?Y9MTZP1QO5Ws/Uz4xXCCbgBALEs+PaTlErL7ejmt8S+9E50tD1N/ETQS7Gvm?=
 =?us-ascii?Q?Gh27yIbbbtRHShgOsB34J8exJvr/bZUFhwEquSxGPbQDRf+RKL5+xW6Ubfmn?=
 =?us-ascii?Q?OsP2f6aoBZ5ESpaRDr8Wzjh4F2gts+S3TnWmnHgN+9fdHuEQHnCxp2IGK9eS?=
 =?us-ascii?Q?0lMgX07I94SmVZsmBd8LJNVku/X+h2Xr3UffVCdh3rpYIeeKPuGWyOUZfqJH?=
 =?us-ascii?Q?SaV8oIh0OOZkUyfouFzY1u4u+sPlGKIC8VhR6SYKEzMwu9EDvoDJcKPLLPEa?=
 =?us-ascii?Q?iQi2ESiJGWbGI3f3Ntbtxm25pqV6iGWqAVZw+F/AOR1mB7E7pNOsvxMLEds7?=
 =?us-ascii?Q?XQEy?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3610c5-25f5-4e45-99dc-08d8977a8c44
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7533.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2020 10:59:46.9728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXj07UZseiCqnCgjJzI/OP11S0kWTYzIKNgfK/OR/dg3j1YPYrAemZiO6Os13+RT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7680
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org



On 2020/12/3 =E4=B8=8A=E5=8D=8810:53, Jens Bauer wrote:
> Hi all.
>=20
> The BTRFS developers deserves some credit!
>=20
> This is a testimony from a BTRFS-user.
> For a little more than 6 months, I had my server running on BTRFS.
> My setup was several RAID-10 partitions.

You should be proud for not using RAID5/6. :)

> As my server was located on a remote island and I was about to leave, I j=
ust added two more harddisks, to make sure that the risk of failure would b=
e minimal. Now I had four WD10JFCX on the EspressoBIN server running Ubuntu=
 Bionic Beaver.
>=20
> Before I left, I *had* noticed some beep-like sounds coming from one of t=
he drives, but it seemed OK, so I didn't bother with it.
>=20
> So I left, and 6 months later, I noticed that one of my 'partitions' were=
 failing, so I thought I might go back and replace the failing drive. The j=
ourney takes 6 hours.
>=20
> When I arrived, I noticed more beep-like sounds than when I left half a y=
ear earlier.
> But I was impressed that my server was still running.
>=20
> I decided to make a backup and re-format all drives, etc.
>=20
> The drives were added in one-by-one, and I noticed that when I added the =
third drive, again I started hearing that sound I disliked so much.
>=20
> After replacing the port-multiplier, I didn't notice any difference.
>=20
> "The power supply!" I thought.. Though it's a 3A PSU and should easily ha=
ndle four 2.5" WS10JFCX drives, it could be that the specs were possibly a =
little decorated, so I found myself a MeanWell IRM-60-5ST supply and used t=
hat instead.
>=20
> Still the same noise.
>=20
> I then investigated all the cables; lo and behold, silly me had used a ch=
ina-pigtail for a barrel-connector, where the wires on the pigtail were so =
incredibly thin that they could not carry the current, resulting in the vol=
tage being lowered the more drives I added.
>=20
> I re-did my power cables and then everything worked well.
>=20
> ...
>=20
> After correcting the problem, I got curious and listed the statistics for=
 each partition.
> I had more than 100000 read/write errors PER DAY for 6 months.
> That's around 18 million read/write-errors, caused by drives turning on/o=
ff "randomly".
>=20
> AND ALL MY FILES WERE INTACT.
>=20
> This is on the border to being impossible.

I would say, yeah, really impressive, even to a btrfs developer.

Btrfs RAID10/RAID1 by design is really good, since it has the extra
checksum to make everything under check, thus unlike regular RAID10
which can only handle missing device once, it knows which data is
incorrect and will then just retry the good copy, and recovery the bad one.

Which means, btrfs can even handle extreme cases like 4 devices raid10,
and each disk disappear for a while, but never 2 disks disappear together.

But in your case, you really put btrfs failover to limit.

In fact, I have to check the code just now to make sure that btrfs can
tolerant metadata writeback error.
My original idea is, no, btrfs should just error out for even single
device metadata writeback, but it turns out that barrier and super block
writeback really can tolerant multi-device error.

Anyway, feel great that btrfs really helped you.

Thanks,
Qu

>=20
> I believe that no other file system would be able to survive such conditi=
ons.
> -And the developers of this file system really should know what torture i=
t's been through without failing.
> Yes, all files were intact. I tested all those files that I had backed up=
 6 months earlier against against those that were on the drives; there were=
 no differences - they were binary identical.
>=20
> Today, my EspressoBIN + JMB575 port multiplier + four WD20JFCX drives are=
 doing well. No read/write errors have occurred since I replaced my power c=
able. I upgraded to Focal Fossa and the server has become very stable and u=
sable. I will not recommend the EspressoBIN (I bought two of them and one i=
s failing periodically); instead I'll recommend Solid-Run's products, which=
 are top-quality and well-tested before shipping.
>=20
> So this testimony will hopefully encourage others to use BTRFS.
> Besides a robust file system, you get a file system that's absolutely rap=
id (I'm used to HFS+ on a Mac with a much faster CPU - but BTRFS is still a=
 lot faster).
> You also get real good tools for manipulating the file system and you can=
 add / remove drives on-the-fly.
>=20
> Thank you to everyone who worked tirelessly on BTRFS - and also thank you=
 to those who only contributed a correction of a spelling-mistake. Everythi=
ng counts!
>=20
>=20
> Love
> Jens
>=20

