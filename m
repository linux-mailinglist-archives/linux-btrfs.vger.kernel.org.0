Return-Path: <linux-btrfs+bounces-3007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A6E87188C
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 09:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BA4B1F22EB2
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 Mar 2024 08:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6E24EB22;
	Tue,  5 Mar 2024 08:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q+L7oQp5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d7LIF3HN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ED24CB58;
	Tue,  5 Mar 2024 08:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709628524; cv=fail; b=XXdUjK/IdVzC0083HU+PsJjx7LecK6w8pCPmcRm1uud0FjDuQ/9oyoq4E6OFOysrETlTMEZ7G7me64Hwsgjdf+uC629A2n0d3hmGvn0Awkgo2Qk8/Z1FGAp+ykOnNad4I4hfRyUOZqOMnACxgpvNGpTwAsDmbULmj1g+fbzrDQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709628524; c=relaxed/simple;
	bh=3zMHMZT72w1Er1jmakCh2edM816VLC7lN0MvIRx0BVM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sxxqUWrfyRqbMDvxOxCT+CVL1yNcQhMWrFJ/O6J7SUn3dr5y0RguC+tQklvyFP/3DO1ShRF3yo4a6vLzUAZH4Gn0EvGZfI6cyMaMe0zIEZEdBfHnZA4b4myA+PFFYItxIBLPBNkistpfzqWz7HwaUoM+rAnXTVqSNGbnoAi6Dws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=q+L7oQp5; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=d7LIF3HN; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709628521; x=1741164521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3zMHMZT72w1Er1jmakCh2edM816VLC7lN0MvIRx0BVM=;
  b=q+L7oQp5gI76Vulwmu8qWRnDlHn20a8Ui/FR/Ic0UbNNCbtJ9pVOXBfU
   jCNgoGWF6ufa9ez91BU2QKhgp7hH8FCsQDhtpiQVIFzxZlCRipUlDwhr3
   stZyTJpx7mDxrsbEC7xogA07lCr9h4HA2PKQamBfiUGIjp9X5aJgc6czW
   K2t2cl3oiIB+W8jh5J4GlrJjnGuhZcpjdHu6sIasn2WOXVR6uwDXmIUiJ
   rjpJ4VVeXCgLPbUIU/pvB4qamd/hQeUzgZGbccSoB4N6iScFP+QvkLPbO
   IYhg7ziMXhi7TwlH/ibpnxmrngUOoSNbiiN3+0seSq9LxsyZcoCz1VOaE
   w==;
X-CSE-ConnectionGUID: sQtQowyHS9KEk8AyHKzR4A==
X-CSE-MsgGUID: suzX/Hj5RlaLXr2psvf3mA==
X-IronPort-AV: E=Sophos;i="6.06,205,1705334400"; 
   d="scan'208";a="10824989"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 05 Mar 2024 16:48:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWYLveh+s9k/qPGlB9txi+GQjtNXECzorFVZFWF7GEomimGJ4X9jBVO2IPMZzVvg1A242Y+B8sFVFPPeNNR2Gyoj+F5VFEDJgMO6kUMAvzUMVfJdsGoDagySDnm8VgWTA5yzPzVBi/zdqLJUIvFyawgKtYbiogYUq05aZiCJMv2jj9oLRM8+QGGu3+LoMqm6OUVmTcxEmCabZTBmwWQMjTpihCgR2n0rK9GRppn9s4RfAWxQQzmAmEOjPgrxhrGz8Tr0AzXG1597bF1J1Be0j0jD4RBqcQAR0f0OYy+if/CMonY8aT0C8FfQDQCD6b0zHI18uXYPe/uqSruNdmdzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnJclm7T7W3RiE5ICeYNH9IA0ernlCuka8NL0K5gI2E=;
 b=SceIGGcwflQZMaiLnOIE/NNGlLKaf1ELNXD3IGtD2SfgjnP5oHlPKeuE9TIkxE+vSZsP34HEmQib6kBVdA7klfyJCq3HRH3Oqke3VSfvpdEN3YKHTZmV3E9wE706jvBUo7UeG9rVpAiK39inCK9VtRLCAPQABZgSUF7tQrtvKzVXGFQmGTPtMKKFz8pjLdiWHkZ+CN0bz+hnkQW1atcDyqzUPEwswNVMT20QSwzWuPUdqInaA9/l1rryNUMLgmK4GAI3vYUV9wjTH5a2rp392uhqo/SQF19uZm90CDKdx9v7hvByYXtFcwM+5cjih/fB0gQoIAfCHnAFTPBAaz4hFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnJclm7T7W3RiE5ICeYNH9IA0ernlCuka8NL0K5gI2E=;
 b=d7LIF3HNVYUxys7hbGfRJeElSC6jt2qKoBnqWeBOdFGFwtMWRvnnmHyeCz+Hvg0cXWTs3JrFWVsKXAe/iJCHoE5ncfszqQY5WUan1HEt3NmQK941iExGSwuNNw6JHJ3ndWnOuOScHyl+/ElekHa7kIh6frVtGY8oI4OLbCV+OYU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CO6PR04MB7683.namprd04.prod.outlook.com (2603:10b6:303:a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.40; Tue, 5 Mar
 2024 08:48:33 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::117f:b6cf:b354:c053%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 08:48:32 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, WA AM
	<waautomata@gmail.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: scrub: fix false alerts on zoned device scrubing
Thread-Topic: [PATCH] btrfs: scrub: fix false alerts on zoned device scrubing
Thread-Index: AQHabqevZoggDQz39EqUvAx2S9E4N7Eo1n4A
Date: Tue, 5 Mar 2024 08:48:32 +0000
Message-ID: <lxmzcflltgts5hesryp5duiufj3mtsiqotn7bjwiowzz5ljge4@ifshxhdddgo7>
References:
 <91a3647a1f2657b89bd63c12fa466c6c70965d22.1709606883.git.wqu@suse.com>
In-Reply-To:
 <91a3647a1f2657b89bd63c12fa466c6c70965d22.1709606883.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CO6PR04MB7683:EE_
x-ms-office365-filtering-correlation-id: 710f7158-5214-48d8-a4d9-08dc3cf109d0
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qBKa8l0095/wgbyBaVJQFi3KnBFntaSQrHlVjoElXIRPLMgq+PWZR7rRyKQ5kjOCj4IsEd2uG7CN+4BE2KSw/5+2ej9YjjSTUx7p20lUXB/13/1XFisMdhCoqlHkJHudrDVX/ElQjRIt00czAZ7ZkuNFmyxCj8zW+ap26GZVdPJo1hTmWTjRLbYNAFZHXgC9EIQ7WQGi5lALrHjbnVPTkT2RYjqHxMObQRYpm9l2/Iw88zLODAk+sTHk+dk1O/hsvP0sSQh8Xa05xUBOQSXJegqHSMGg2k56dKNFVNcuBC7vUWkvRxNVVjjnx5tReNPBoblBR+KL1cMrqxOJRQ/rtz0r9rbs+7XiSU6Z0CqU5NtOC+AURb8zRuLH+vWWJn2gz+n+dES7lvP/WILLW9R4SiFmUTEoONLKRzHvLdP+jfzg1FzfDn5DU5jL86vh+wX2xSfGJ5BlxcrXs3198CdRjP99Rs5riXat0ObV5KfSZH1dNLv2o3UfVer6CC+Evuq+bjEpqGtTO0zYG86jO6V6UgpCuVUzMjA4z8qyLNdL42tWe/M7er1X5nAuNLKhdOmX6+0y4alLaoIADF3zBzoteWbv73iWF/Ip5RzppsY+FiSCPSCocqd6/yI/xeZ3SJetUdSb9NAveojTamoznj56SomfNLWW9kojikg3NKW6Q5A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EpHdC/cstsbfS4vP2PJlG1EjYj6UwIIEu8mFoBSuayFGAkPr4hO5SChd5NKW?=
 =?us-ascii?Q?TZeiYP8WyQhFiPtFOtNyD9c0X6U1kHDI5WAWdBZ3fFwulAf05kvxqgffaA4K?=
 =?us-ascii?Q?P48wcx/TylvbMs2EHxZJ72IvVWapTtWStQGhgIn24L6F2T5xgEdWM+QEeeLL?=
 =?us-ascii?Q?RGPwU+WCu+k4fRmvWzDcB4QTBOnTclGo1RWrPEh8jh6zIj6QTY3wp2lKSU7X?=
 =?us-ascii?Q?5VhM24QjnrNy7AMvQ7HUgORZPLBYrxkhA9Os2VlF6TgPEhhc2zt99ROWU0I2?=
 =?us-ascii?Q?kiaiZYoqk/yp1qs5b0iP6OvaoTxoRe2PdDE1eSgtdxhzXjBDAD5EyoDGXYno?=
 =?us-ascii?Q?yZMcToULeMYyQ8aAkh1gQCWBNt0fQqzfX4YrRUrGpVwB2DwIveM1wiK4ztw8?=
 =?us-ascii?Q?DjGC9KXY4Vo4CwNW2cCHXYLYzBclXn7RMoTfyuTeoRgcleqafTe7e/b58hu4?=
 =?us-ascii?Q?jUlUVKlkyX3AodtDAJoQacs7CeScNu9rmZvIhuHLrjGtNSkOodV9rO214z3D?=
 =?us-ascii?Q?9jfBLkovkksjgT60e3q0CFAhUb5e6+85D/+sx74E+g5LjTcQWa1M2Rgw0dmi?=
 =?us-ascii?Q?bqFStEoB62EAAO8R7DMVtHG3ucCkw7jCkPOrajvd0uvWrGozmoEiMFJGq5Y3?=
 =?us-ascii?Q?No6FJjuQwnlmTQVEPxt/RWXcFQ/VWfbGW3Jd7f/ThTQ+O/F+u3fI1A44ioTF?=
 =?us-ascii?Q?F9NLYyRex/91qox8FHJr00KcafhS5i4mnz9sQ7vCq+to8QQS23MjRqNAJPKG?=
 =?us-ascii?Q?k7chqQPMNssBWWkGGG7T3F3xQrBg4jDPDkRqqryFkxXF6zLBeWcpJ+8AgWJS?=
 =?us-ascii?Q?KloI1Rp5S1OrtA4IZ3ZlnoVgayML8XyErJE5MvbNJtra3bWZT9UnhwfUQj0m?=
 =?us-ascii?Q?ROVbU6mtAj/UgpXbT13h8e4Ow8S83NMSFYu4YBp44w/+Zoo5txZqReKntxO4?=
 =?us-ascii?Q?S+YMnbt4n/iWTuh9aIkqZ3fTtwMwMIJLj5ZYIJclIiac8+m7KoTnWL13d9qM?=
 =?us-ascii?Q?/5p3jROGsGj3pYWhELvkmeZ/UysHonA9zUQqGm6J6ltpzfjK9fFgCMkOhGtC?=
 =?us-ascii?Q?m+iiMggEC6fkPMN0C98EhVTRyX9NvXrclLS6DHzkbnTEc9GPtMtXXbtxKop/?=
 =?us-ascii?Q?frixq5Tf63yr45O+CvHSnUXj8tKwc2tZ5bN4QioWgfoRUIJRjod0EYbRZhaq?=
 =?us-ascii?Q?K2nHlVzpLEtKX/TydmmI6CV2w+8MRM5vuSNOOsRS+cN40lEUDTCKe9Lp8BpT?=
 =?us-ascii?Q?r7Fh1eY7K9NhKlljHwN4c/r0HqFcE2urx+odXd+LKloBMCdWOr61jYOPEbM9?=
 =?us-ascii?Q?Omj2vs+WTBsL4HxbUkrlJl7aA/iNZD1PFnEoEvEYVHx0ofDjCPMv/x496fSU?=
 =?us-ascii?Q?y6shnKie4UmRZuv01R+19X3nOHx47liIJgkNvihpm6gBA6A8SqtKTYz/7Vx6?=
 =?us-ascii?Q?tJN7mXpWXK5Wq12NZ2niNdIM9GVm+a9EfatmjdRVx3E356CWC0XXLrDQGw1F?=
 =?us-ascii?Q?2BVVNvVKOOeSVelUs8e+IFSXPWKlgmYkcm11GkXLRAXOR3XaLvdZyBmHbdyJ?=
 =?us-ascii?Q?5sqj/uMcvp1RGueXpi5a1sA100OVIyj9JmP92kWci1z0JgDJO7C4nKjZaSuI?=
 =?us-ascii?Q?iQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2EB3BAA52D8F5A4CB7C2F712F083BD7A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RcCog4CxGBCOmuhrgLhwIczjs60twoUSdzKzOipOKa2PixMG0yeXvDW01Yl5ebZRGyjhqfB5NYzK8VpfLozPKrMEJzzJrobKiHW6HGE0yOwwFht9cti3mejcBl0wJcasg+C/KUBDqApA0ntuafokXQ2hG74POCfwptBfINMKnM01UkxWPXc9uHINSpvpeyfhIaFP5nJjhef4ZfWZKpl0WWX/HqXIfNi6FMTnYHaLO4yvux+1hxRDHfAxm8oJlJclZpHxhgAduwzeZ/phUKoIucEsTi+3I0sDqH5B3Af2GB7aKWIc4FWhpsbY/yDDZPxUKyHHkGBWDka1pNYtCyUUdOhxtEQ9o3VaHRre3Ii35MyYQu0buEBHC4wa7kZ+X606Wel7CMwAd6s5wkRfmeVNijOz4QtgNCIQpNIiO1KmwBsFLVfn1ikTZ6bkp6QX9ocnj8ADhHdVg8eOL99zfd+pd7TGaqH1ZlfL4eDUJtCxen1VyrGEXLHlj5xIc6nXLwqXzg3YP18kdij+rbbwy/zKxL11KDVx+89Fxcr8DPQti9Eg+2UPiD+xvXJvn0P5pJSnu8Rnk1znykbt6yD17wMMLnTsAtt5PKvrFqZr4S5zP91SgqsH446yCBk5cJf5ZOIY
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710f7158-5214-48d8-a4d9-08dc3cf109d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 08:48:32.8988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZqUlI1m/LeCKqak6Xj0n6hKjHNxc6wWepqPDNXts70MP9GvF/Zdd/17unQ8ksR8uG1TJ8k7s1YoIC2moq/9Mbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7683

On Tue, Mar 05, 2024 at 01:18:22PM +1030, Qu Wenruo wrote:
> [BUG]
> When using zoned devices (zbc), scrub would always report super block
> errors like the following:
>=20
>   # btrfs scrub start -fB /mnt/btrfs/
>   Starting scrub on devid 1
>   scrub done for b7b5c759-1baa-4561-a0ca-b8d0babcde56
>   Scrub started:    Tue Mar  5 12:49:14 2024
>   Status:           finished
>   Duration:         0:00:00
>   Total to scrub:   288.00KiB
>   Rate:             288.00KiB/s
>   Error summary:    super=3D2
>     Corrected:      0
>     Uncorrectable:  0
>     Unverified:     0
>=20
> [CAUSE]
> Since the very beginning of scrub, we always go with btrfs_sb_offset()
> to grab the super blocks.
> This is fine for regular btrfs filesystems, but for zoned btrfs, super
> blocks are stored in dedicated zones with a ring buffer like structure.
>=20
> This means the old btrfs_sb_offset() is not able to give the correct
> bytenr for us to grabbing the super blocks, thus except the primary
> super block, the rest would be garbage and cause the above false alerts.
>=20
> [FIX]
> Instead of btrfs_sb_offset(), go with btrfs_sb_log_location() which is
> zoned friendly, to grab the correct super block location.
>=20
> This would introduce new error patterns, as btrfs_sb_log_location() can
> fail with extra errors.
>=20
> Here for -ENOENT we just end the scrub as there are no more super
> blocks.
> For other errors, we record it as a super block error and exit.
>=20
> Reported-by: WA AM <waautomata@gmail.com>
> Link: https://lore.kernel.org/all/CANU2Z0EvUzfYxczLgGUiREoMndE9WdQnbaawV5=
Fv5gNXptPUKw@mail.gmail.com/
> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  fs/btrfs/scrub.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
> index c4bd0e60db59..e1b67baa4072 100644
> --- a/fs/btrfs/scrub.c
> +++ b/fs/btrfs/scrub.c
> @@ -2788,7 +2788,6 @@ static noinline_for_stack int scrub_supers(struct s=
crub_ctx *sctx,
>  					   struct btrfs_device *scrub_dev)
>  {
>  	int	i;
> -	u64	bytenr;
>  	u64	gen;
>  	int ret =3D 0;
>  	struct page *page;
> @@ -2812,7 +2811,17 @@ static noinline_for_stack int scrub_supers(struct =
scrub_ctx *sctx,
>  		gen =3D btrfs_get_last_trans_committed(fs_info);
> =20
>  	for (i =3D 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
> -		bytenr =3D btrfs_sb_offset(i);
> +		u64 bytenr;
> +
> +		ret =3D btrfs_sb_log_location(scrub_dev, i, 0, &bytenr);
> +		if (ret =3D=3D -ENOENT)
> +			break;
> +		if (ret < 0) {
> +			spin_lock(&sctx->stat_lock);
> +			sctx->stat.super_errors++;
> +			spin_unlock(&sctx->stat_lock);
> +			break;

Since an error from scrub_one_super can continue, this can be "continue"
also? E.g, if btrfs_sb_log_location() returns -EUCLEAN on the 2nd SB, it
fails to detect the 3rd SB's corruption.

Other than that, looks good.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> +		}
>  		if (bytenr + BTRFS_SUPER_INFO_SIZE >
>  		    scrub_dev->commit_total_bytes)
>  			break;
> --=20
> 2.44.0
> =

