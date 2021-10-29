Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4AF43F8DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 29 Oct 2021 10:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhJ2IeH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 29 Oct 2021 04:34:07 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:34098 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232455AbhJ2IeG (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 29 Oct 2021 04:34:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635496298; x=1667032298;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mnlYF/034IseHhFxseZ7U/7tINnm/fQ4REZo4hgQGp8=;
  b=Ww0GjAql65SclJHBW5uZiTd/Pc3nDf8X+Uo9Ea3ALJyy9X8B2iCvGfjD
   bWnDtMlXFz9sR9sJ/r7Wro5mmFwfMoShiWTHgDfsMq9b9jeKheb2xveus
   YmHJReLrUHnnQ8+Bluel/sf7cy7Qho7bGBS8huK2OEv1gEPnojoFt+nFg
   TX+zOmEJRkOEIQpUFSl685eh/Qem+ZBQuiA0ncZ/+ifYx9GIpG7jcKtLe
   HYDJW4fvxYHUywA75PH5F3CjtedBd5FPLtYJLQ7g//R0/2BmYLuCqmIxx
   XIPXkHqUqYS2OUdEYQ5jLA4aYd4AEOW3YljWuCuyNSmwqNX3XCvunm7OF
   g==;
X-IronPort-AV: E=Sophos;i="5.87,192,1631548800"; 
   d="scan'208";a="183159279"
Received: from mail-bn1nam07lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hgst.iphmx.com with ESMTP; 29 Oct 2021 16:31:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZIi52Q8QIXShh40tJxyn+qDlBkFFfSk2BZ3lU8i9esUQ7fzN17HdBN0jFU4s8ILsRB2QZeylqcd24uT3iWseBIf1fZGvM5Prowt1r3R6ijh9+gnV8NCSrA8MnJboB4CDXC3OZ9cEqcZs8xR7RRvKnAHSDLGOEdyqiKT1qYwD8yHwd0bwje5rZmd2K9anSo6viqMN1HOeXvg1mOyQh2vzO48q0ZiLB9O8ADx3bLJcmX5hTMQa7YF5XYh7vpVbp/6V55TdtcgZxE61lpMZwvjxWW88G/1/aNYBctkCl3TRwnKdgZWCNV22ZFtkQcNtY9KPIsg6zggIQsOoEf7NCNcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86UDZWvhbmes8Ei9ktRAsjc8L+z19kq+lO1sCtr/GDs=;
 b=bC3yXMNK1A6jqeWkHHE15E32vDnp5Zx059R2Ik/w6c5SawJP8pCB4fYAXSm/Lizmu0FfjP7mXl0y5ZWJByNXP3jKZ62TOwKNc6TEBnbqgfNmu83wux8/zojwTXKKsw1rGYxh+hXAoR4ki+kGr+WGICyixqoPzDjZ5Co3WlPy+ZsbIdcrXmIhsKshj+831hB7lLIAG+fnB5I6WVEjTLDj/KXYfG/llEvF9TOyAbQvWRJj3EUSF9+Ts5BCkQwrBZLotrEtHKd/6Ma097lM/dlLPpoFrGH/0cje/kpoFR9zIIb+rXGNE5AX2birBvm6Sb349Wzc5TRqxS493WLkr6jCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86UDZWvhbmes8Ei9ktRAsjc8L+z19kq+lO1sCtr/GDs=;
 b=Fr0XBGJUPvMtKdlIng+LJQui+ZkADLVykOOoUC6Lf7Z5KRsdMaxLsjx1j3L4hZPlf6HIcf/qeLSvvMEGR/sksaaQX/uAFy91sTt/Vh72GU9onaOI/wnKH6bHXPQNFJTOAF2jTXT2fftbRua2TSSo2i/8GWNwHverMptdikQJ1rM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7576.namprd04.prod.outlook.com (2603:10b6:510:4e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Fri, 29 Oct
 2021 08:31:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::79d3:3357:9922:a195%7]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 08:31:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Stefan Roesch <shr@fb.com>, Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 0/4] btrfs: sysfs: set / query btrfs stripe size
Thread-Topic: [PATCH v2 0/4] btrfs: sysfs: set / query btrfs stripe size
Thread-Index: AQHXy29brpg8XrKOlkmVKJzfObsJQw==
Date:   Fri, 29 Oct 2021 08:31:35 +0000
Message-ID: <PH0PR04MB74166FDFC130F986800668829B879@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20211027201441.3813178-1-shr@fb.com>
 <YXqpFxiAVrC92io6@localhost.localdomain>
 <YXqzWv7t77ZpKIig@localhost.localdomain>
 <PH0PR04MB7416FDDC06510EFD61785BC19B869@PH0PR04MB7416.namprd04.prod.outlook.com>
 <29f1017d-99f5-dfa0-8365-ed7552f4c76b@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fb.com; dkim=none (message not signed)
 header.d=none;fb.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23bf6afe-17dc-40bf-b366-08d99ab6854b
x-ms-traffictypediagnostic: PH0PR04MB7576:
x-microsoft-antispam-prvs: <PH0PR04MB75763BB88C24AAC7B26E0EBA9B879@PH0PR04MB7576.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Zb2lVx3hJBxW+VYjKDAMNfDZTHix4E6tF2KBfRIjAWbeuAC5/qo+XEahoWGY7oIt8dxH1tYBPcx30WyJ1T8IR1xlrEb5Qdm7KXiPChz1suWQ4UwRl+r20f7S2A0/+cVDCusYVfdgVarc7aT4I0uB7Op9MiPeYeVMGLp8+OylHuBVLRZvdFAnkNdyU9BIONb4Nr2ZAWP7x+g8IqaudyOrx23paV0Ihi2lsZsoR9ZUx9JXJGn8ugX4FWzk7nkIn1kH2cp1lLebiA49AjAsttzvbdgwRsIwkPSEsd8OEfXciKRicUxclrXzIdgmDenS2QnBozAGeH0SpbfcFOIfP0+E7VzmJe45/RtTNBeaE4/FFCTRIE4QQ4U6uR/ugIVQ3Sur+pDgtfDAJsVEt26O/UZ6GhJY/qYYslBfojwNOvOKrgc49VZ4b8hTja/+DBg6+LMJJ1OCkIWgpDGQnkGMkKNTWoT34eyf4Izg22I8EhljYmM5HtQBXRUcY/ExFy7x3dSpZJdxdu4asmTr0wfV5W6w91/6YLiz78eEDzKnnxZhf0YgCXzJx/EMpdXLVA8Sbc7Cjpw4Khrt7+ACDV6f1UqaqadvqtcZJgnGj25NDXsUMOrK3/ckj3mjCd1JYoQNMJEfGhej6Jzsf4OmBGAijqryRp22t5/52XJhO1EG1+09CQb0wfsDxqTKXsHkDjuW0uRFGkU6EKGDpcpp9shbzmqBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(7696005)(86362001)(76116006)(8936002)(54906003)(186003)(91956017)(33656002)(110136005)(316002)(8676002)(9686003)(6506007)(83380400001)(122000001)(26005)(66946007)(53546011)(2906002)(38100700002)(66446008)(4326008)(64756008)(66556008)(66476007)(82960400001)(55016002)(38070700005)(71200400001)(52536014)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A6rSw6H5DtU6jBDiuT2uOdae53pt/CZ8EejKmXUpUTJ0DxRvjrid6DOumGyP?=
 =?us-ascii?Q?Fwnbv1VfTOwE8KNyZJjxOoDdqbubgBchj5nV6UYrAhsGzBP4xdylR/zqaHyv?=
 =?us-ascii?Q?QektvVOAUjKispkEg1NoSkd/y90g9/YI60+kGJMG/ibLAp67tG/RlZN6iNYl?=
 =?us-ascii?Q?r1lZMKEKOSE1JiqpFD90c2TDkk23Eco15IGgVLVeem69Umk4aooOn+Hhq2BP?=
 =?us-ascii?Q?9JEnwrKLrajLKIdhTbDuBi23J9xqfsrDWOSYGnLt0e8I+XxpOT/E1rUvrjCz?=
 =?us-ascii?Q?gcWr3PbahXmr1P/opDwAxO4wh+sky6oNOf5j6jL51oGZlRVrncZFT3Acd9VM?=
 =?us-ascii?Q?KB5n7wEc3Uv5sJkjaK1UHLevJZPMS/Dx+XtiYUuyZCJx6DFTPlZIe3UeS5jr?=
 =?us-ascii?Q?TgzZWI3B6f9NTXvlCc+ORPyEkOBZR6LLE9Mfhc2nEoramVuF+CG8CHBMNMKx?=
 =?us-ascii?Q?NbeYMptZOQIuiFmrv2LMTwvuLz9pC3ZfMqcIqTtPW9wpIBoTq00qdjq819vc?=
 =?us-ascii?Q?L11E4qLofIcIROz04ZImaeRPTNl3Bds/PqgtckFwcXpr9pMbO1roi+oxUlIL?=
 =?us-ascii?Q?wB/MfIqRcZr+Cerbb7auyMrsobbDDMeT6jixDw0fzXb4kmVsEK/VX8ft+1Xc?=
 =?us-ascii?Q?gGbkNSVf/bbg3CG/E0k3uVrVOoF29o+td4nXJ+Z/f89ZivGSwcqeX3kqeyoR?=
 =?us-ascii?Q?vYK/xD8ivUT/gPWXDQ/YVYaJEfmeQO8qjGzum60ZMIsU5hD16w2omxnva5nK?=
 =?us-ascii?Q?azcKWvVYxg9DUNgywEv6mFD50+QsKvQi7NgrUuLzR1rkaL8dVGF1LcFE7U+h?=
 =?us-ascii?Q?tGGDrBpXmT8nZA0GEIPe5EpPwdjmwOozlAFLfWRecQpO3YyP/57WeInDWa1B?=
 =?us-ascii?Q?gzGkHSxkBRjUwkjJkpqi3YEo7SphNyIgnv6lFFbkYckpRfLQ01NlCtRYu2bK?=
 =?us-ascii?Q?Ky6QYVnRFPhE33peaB/TXTGRw3NgFF5pwfHBFJc6g8ywlmAf35ipn5ugaRk8?=
 =?us-ascii?Q?dY50Nz3SAa5dXTmpdfvq+7NYpEzfm7A3feE+qsoNj06BMy4e8O2TBs49RxLI?=
 =?us-ascii?Q?TSvfkTo9xc3ujkKLAuWKI+WNwZkwbzpxbx4mAA8Md/xVZuf+VeWxbst0ryi1?=
 =?us-ascii?Q?t4GFHLpbORalPVTsTFxzlqKHU2tsMjhPKCP/qFtnHWA628aSp3idKOwGjAJp?=
 =?us-ascii?Q?EKLYMtAELl+rGfXDXwmF8LQ04ZLyBAReLtACtKve89smKkYLgM/Rvkct9hgu?=
 =?us-ascii?Q?Q2igZ5fix3WcQN6v4d0C7LSDNk0qlaw1x+yQDi5BbP4T/MbQlVdFBW66Kc4d?=
 =?us-ascii?Q?Q/8O1NV0F9uNQatIKs2X1qcSvM+ZzXgiAKqIII8wGsSWI61Dgd+pnhyZ3i2d?=
 =?us-ascii?Q?U8IOlXRX4t3y+5WQzKY/dmtiOia2ZAWn2Xvg9IMf8n4DnsFNErVf2qEPFap/?=
 =?us-ascii?Q?AfI4+lX54GfuJywUDJlofXEC/zJ8wGvJw6MJRD66hMYCJ7wB5oTVx0JdypZN?=
 =?us-ascii?Q?tJ5x1bNbCz50GNj9LakfUGxTIbk7YMz4VzxRCftz0dhuIAEPinlZwIIO+lJQ?=
 =?us-ascii?Q?Z9zitaK4kQbOtja8r7EAnU/NNsQbH+ie6tD1IeIbrG2pO/VC6kef3/JWiSlz?=
 =?us-ascii?Q?/JnxqdrXpja9EwCzb9eql3sbhZW5nEtgzBHUd19VzcpgS1VqnvxiWzHND2KG?=
 =?us-ascii?Q?K4ZJ/Ehg40M6SheCi7C0K5SaCs8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bf6afe-17dc-40bf-b366-08d99ab6854b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2021 08:31:35.8770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6oy7p4Y4bDtJtegDzIysPXRzNm7w5z8b1CA2CvUE+SP0czDcT+cqz07hOIoTYbJFVFL84Y+GGNHQx/IyzTQBo5rnfHzjs2xz8ZpK7f6RMpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7576
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 29/10/2021 05:11, Stefan Roesch wrote:=0A=
>>> In fact I talked about this with Johannes just now.  We sort of conflat=
e the two=0A=
>>> things, max_chunk_size and max_stripe_size, to get the answer we want. =
 But=0A=
>>> these aren't well named and don't really behave in a way you'd expect.=
=0A=
>>>=0A=
>>> Currently, we set max_stripe_size to make sure we clamp down on any dev=
 extents=0A=
>>> we find.  So if the whole disk is free we clearly don't want to allocat=
e the=0A=
>>> whole thing, so we clamp it down to max_stripe_size.  This, in effect, =
ends up=0A=
>>> being our actual chunk_size.  We have this max_chunk_size thing but it =
doesn't=0A=
>>> really do anything in practice because our stripe_size is already clamp=
ed down=0A=
>>> so it'll be <=3D max_chunk_size.=0A=
>>=0A=
>> We should also add an ASSERT() to verify we're really never ever going=
=0A=
>> beyond max_chunk_size.=0A=
>>  =0A=
> =0A=
> Do you want an ASSERT() against BTRFS_MAX_DATA_CHUNK_SIZE?=0A=
> =0A=
=0A=
Nope, I thought of an ASSERT(stripe_size <=3D max_chunk_size), but now I'm =
not sure=0A=
anymore if this really makes sense or not.=0A=
