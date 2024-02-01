Return-Path: <linux-btrfs+bounces-1984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F51844EA9
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 02:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D531F2CBF3
	for <lists+linux-btrfs@lfdr.de>; Thu,  1 Feb 2024 01:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5244A32;
	Thu,  1 Feb 2024 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lZD2jVKz";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CH1t7vMH"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659424403
	for <linux-btrfs@vger.kernel.org>; Thu,  1 Feb 2024 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706750935; cv=fail; b=RkeAECQQo2Hk6DYv6Hp7jQmbUTGnz8gAqSvYoDVIHX6+oWm8IDQNomTh5Rwjt+CbzNKtVv2VC6wp7Hy0fZveobc4kNhBhAeLWRQ82/Kx+wUdAewPM6+yAzWuM3nbDUlkvV4QHElapCEvvkXGw6vBvIR0uEKcqm3ivCHYUWwhYo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706750935; c=relaxed/simple;
	bh=Ikve/Y1WgBXNIf4k96b1YEoabDVyqwmtWzrdrzp0Wr4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=djw9wIA5USfLsvzC+tB51JB8SeZICNPIOEW9My20VzSmXvRijlhmImK8rvPuAi8PxQkS+WFnd8nKhIWZx9nc4ZCRGTJZS7Q4vBB05MILPwCRGoydVF3r859NkOKFpjLlX2KtbjqNLpRnDungxymMDMAESDQ0WTyjm1uLsMjX23w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lZD2jVKz; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CH1t7vMH; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706750933; x=1738286933;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ikve/Y1WgBXNIf4k96b1YEoabDVyqwmtWzrdrzp0Wr4=;
  b=lZD2jVKzFN+C5bmbI306TUkARZ3LWrqLSDL5VFUPLF49ZOyZozy7vMxa
   6d11XAkSbZpk99w/FF3UeRlUIsGlla4rrApfvVjfxnq+kw25W60SAIaCh
   xTgJrA4uALfyGsNxR4/qIKQA6NtkyOdhRmrI8DCuCdPeVt5Qh2Ehup9Gn
   XAwcLL+b0n8NDfElAupvicDtmUxf6DOBUW3Q5odoaJSpxgi02r8LZhcYG
   +k1qf+WiF21M4kwmnxqxeqnrpy6u1Jq/QERdrALf9VRgs6pTPC6io07VP
   yWoUX2qJtc187Yrr+Bj8GJwJl0G20TBUIHNoSuhVqIvawSpgaY9w3W29c
   g==;
X-CSE-ConnectionGUID: ACdjkccMRD2YnCg12QhdXw==
X-CSE-MsgGUID: LNOu3FYGRIKOuKNl/PYKQA==
X-IronPort-AV: E=Sophos;i="6.05,233,1701100800"; 
   d="scan'208";a="8277428"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2024 09:28:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVsE+3J4JuEBMzbsPShnMcGLmiX3hjAzCGPb+5rApuSxjNVzzvMXYwCkESmDcoFRZNNgokZgpD7tmaI3RwmDTGcNArVqyYDrigiXjRlIQJBAk7qurXaEGVcwULvCdbbjhMW3Dgo7uLe1QAiixxEay4yP1mINYgMGxH/u/ciLtipal+vKPfktPiFSROclFl+FoYogbtTOq5ISWffnTZ+4JrflyU/vYZLgQJ45V/r6l9+zmIr/fM5g9dae/wYZhw1WrrTU7wiQ4EDPeta7sbtUQUf+bmnvOktPrzOtjEnBfUKUn+EphlFtGspPHiOvQTw+U0UNI12Vffa+8s+DHxMnPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkOTkuHxpvR6HoPqlpXmCYJR21C0ir+2vu2YjzP8AAY=;
 b=gk6Chdx5GkP73in+EuONmgq5etjUNzHDjFI8hcsVeV//0sIh/DtZIMT8PAvszTt8e8xa3Vkj9mhMCATPkdJhQHl6yUn3b9UONurbq+86feSHfVp4P+Feh9e9O45BnQNou3e7hcN68/RtlYnFnLRl+LK3JyBsltRAqbGSoyzH9M5JonGE0/Wr22LxSS33E0nMywBMjv/4GgqeZ94TlVdcs2WNGDqUcKniTpRLdTj3aDxk+alHpQLmMES8swOXJwu0LqjOk/yWSFSDLCYNjlTwNiqBPtwIknqBOrjxuEI3MO+ft6GF7MUXGPLE527++Wx/C3G2OlsW9dAhC/58Wtlmxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkOTkuHxpvR6HoPqlpXmCYJR21C0ir+2vu2YjzP8AAY=;
 b=CH1t7vMHzY0IRayfWOlec70HkAkqrIrpU0xd+cVgvIWj3634Syl7T3ZyHYPU24ajACexQixQQCzIt+69Fmg4WTCHVIfnzA+uFfQ5RJ0ZIt7OJMfl0jpnjNG8W1PhMZ+Ekm2vWZWH3HNJ5SORgcl+E1YGzXQBiCBkVR1hUUfKMHE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CYYPR04MB8878.namprd04.prod.outlook.com (2603:10b6:930:b8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 01:28:49 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%7]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 01:28:49 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"wangyugui@e16-tech.com" <wangyugui@e16-tech.com>, "clm@meta.com"
	<clm@meta.com>, "hch@lst.de" <hch@lst.de>
Subject: Re: Re: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync
 checksum behavior
Thread-Topic: Re: [PATCH v2] btrfs: introduce sync_csum_mode to tweak sync
 checksum behavior
Thread-Index: AQHaVBUW8GgHeMVXLk2Sy0cneKmkAbD0SJuAgABrPAA=
Date: Thu, 1 Feb 2024 01:28:49 +0000
Message-ID: <lti7awd56rvcvlmviq327ueqjleeo5cvmx3w74bulka5btvfoj@u6zmx3xrbybg>
References:
 <75b81282919c566735f80f71c57343e282c40bed.1706685025.git.naohiro.aota@wdc.com>
 <20240131190459.GS31555@twin.jikos.cz>
In-Reply-To: <20240131190459.GS31555@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|CYYPR04MB8878:EE_
x-ms-office365-filtering-correlation-id: 69dd228c-adcd-4511-6274-08dc22c52461
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PYkGgEmgJD9KsQg3vRTfGc3n7KizfpWAdDQU5QjC1oP7lTUds4BXGJOTcq7Ta80KL3E3/R+NKG1kdxIv0o2KEVlugB/mzJt/mXPNT+nYviCQDoP/jbbxN78ed5SO4DifJm+w7Ekism7B1E9k2WYg8FpJA+Cn16XOMO2HMotb0bO+Xw01upvCo8P0Guzs1Jx5THSPj2wSdHk83Ye8ya7sSq5Q2zkcM80YwZyhBHjrF7tmTETvfFTT9NuUM1CaOGGIXWWm2+0fefOvCnS7tNWWZr9osB/g6Oi2mfMDFNsTr4klWTZgu9OGAhoRSuVIrD/1LFEC08swuKPk00hZa8yWHAUPMP59MDqOHxu7lvXsFAyDvjj6hierz3Qy/mvy746+rpti/gpG+VhdQC+HdADKqSHE8lpRra9AmauM3M5YFvFaNOV2eq0VwVCyT/d1Aimo3dCqaWbB6DSR2hTabkbrUrsysf5nfrE11aagh0qUcc8qSp2bIxPuZBNlgTFk0Lv0Q5xZB/YN4B8uz8HhVbqEV72JwZWEBkO0ojeVprb03vGmyvttKlbkmCKEBUYJj78IJLhrdvpZIdRf1G35IMMpfubPD6iGVtVIUpyeUE+ysOJxD3tQ2jl9ZQH630Mu5HNZP8cAz+l46wpO/Dk9e0RSpw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(396003)(346002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41300700001)(26005)(6512007)(9686003)(38100700002)(122000001)(4326008)(5660300002)(8676002)(8936002)(66556008)(64756008)(66946007)(478600001)(6506007)(966005)(6486002)(316002)(76116006)(2906002)(66446008)(54906003)(66476007)(6916009)(91956017)(71200400001)(33716001)(82960400001)(38070700009)(86362001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9P8Q/FsjETXl7H8CH9DqKQOu9juEwQJq2YN7vpVM7ukun8ndmyjgphdCfACs?=
 =?us-ascii?Q?d6ns9Z1Vf/lT2JHQLH0rbuGVXtz3cRq8+GCqJohO39Cf6kwJJMfTd3BwOK9Q?=
 =?us-ascii?Q?d+Pr0+4IqY22G1FJJ754dzi7JT+4ZhwFnhslIqcgplaqQOruezJ5YvtTuwW+?=
 =?us-ascii?Q?xmbH3bDnpopzdTiNdu8muhlHoUqA3wge+7iJVpZzVvJl6CQz14RdDSJNhaQ+?=
 =?us-ascii?Q?Ul9ibMaIXJ7V7t5vj4q5fSTCT7FXJcP7QnDt5J6oglhlYmrhHuEIhjcM29DE?=
 =?us-ascii?Q?gZ3XZFQMm5TgTmLJeSnazuMt4HVEx40K3EVBN6YDQ/FNK8ewMN34aMwDaN+n?=
 =?us-ascii?Q?VHM9U41rK1ccJs2OGkD5jRuG/KWhkgpZ5XCAdXEBdWYKgRu5yaKuZL99Ntja?=
 =?us-ascii?Q?2p8UjfhgCBUrPpokUgKlUj1zqDOiWoS4XH9KTeXPLtjjeCudu92bqJoSrgZA?=
 =?us-ascii?Q?8PtfyJqTksAFgTsqNZL/q/xwzdw1pYUBYUwwY+abSrMtb3N7Y1cxSwQ66pzN?=
 =?us-ascii?Q?upHXbC2WQJL7JfOFlByErArjVjwGgzT+2EgVyAh3K+fcaR6WbVkrsYJwq5gE?=
 =?us-ascii?Q?Tg9l1ePTDqGgPXLZgqj23DSNZ+Ljkgg4u6H6eqCLHG+ZjnikaCjMMAjga47a?=
 =?us-ascii?Q?3LAzmlPLLO6oY1LfFMqjwke6HTkJPoOOU7T0npUGuJ3X/5U0SrJibALRQEqE?=
 =?us-ascii?Q?e0ThRDP+MxL9sarK8VgXZ4LveetdMlmQj+cpohr14E/E9vRX1dXRtJTv0cS4?=
 =?us-ascii?Q?Oqmae2g8SqVfLCHfs5e4yBgaIn6dCg9MHm11k47Dxd0HzXxDFilzCbB4gdSZ?=
 =?us-ascii?Q?UD7t7fn5squ81HDzHrvBYHKUJ3R9Kn7CCeXXGlO/BxLXYyp4ELfBUDPdhog7?=
 =?us-ascii?Q?YPkR5eb6dwO9Eal1qN7WCtiJFMDGVxeHnYlkqtr6fHkK8pG/WuwTsKDf5Xa2?=
 =?us-ascii?Q?YvIP0hlomuFZnMlyLz3O0Snce8YFkjLi7h2cjHYt3Xz+ySHw93PatffmS8du?=
 =?us-ascii?Q?oNnUJXl5IZ/GMsvRw7Zf3vxklwJN1PF98hdAcTWbTB5RLSmBXXshCts4syma?=
 =?us-ascii?Q?+AuPEUY5iyQl87mpquBK/Hu0m2tTEAokKiBx9lzoK1hP8dNK4WpWgbGWVsYL?=
 =?us-ascii?Q?ikrg1O+nKziJRvPDq8/burjx+lt/wfwgYKtV9waPRkIJgnY5++b7UydAhgwf?=
 =?us-ascii?Q?2dpyKZFu2K/YRsaRflbS2kdF+hd4IP9rX007JojdGDH/W2yBibPwnfEL6N/3?=
 =?us-ascii?Q?81Ia6o5MB3ydr+BGQwyZf05Y6zK8XuZbnYHYVgUMm63DXrSah+VwI14HlVMi?=
 =?us-ascii?Q?15PVQqjvT4E+gejnin+PKYoVC2/Xg07jIUkAJdMrIQiDNJQfBbr/YAe8hzRs?=
 =?us-ascii?Q?Vn92O9K3d3n2VVaLN8+h8E6gIHrmNsQNSAEAC/7zX+SGqb0KXrM0Q6jYHv9F?=
 =?us-ascii?Q?s06nv2yBjW/Atdn1NAfAYJe+IdjcM+PU4jGWCcGBSFuVy3cKzWLzCyq3cnSG?=
 =?us-ascii?Q?ldu/pRmfz0wmrWByiNVHGm4FkvFpInvzffE8jGMJ6XpZ3hgyMOCvCd47gS/T?=
 =?us-ascii?Q?VCunjcicEQrev6P5+g5BPPGXF58I9jgzhnbcTvovbgbhbU+bFC3Ntp1X15Xj?=
 =?us-ascii?Q?zw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <287A844D8A75FB48921E73219927DD4E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PYiqw5e8RwAZ2UooceHyE4vUJm7VUCGvIzvJosolGbYxo6kB2eEZ2GRuCL8xAb/nSB3qDF97ruDt3U2DsGw9YGBK4ccLbke0czwmPdcEu3a+hOkZU1AnzmPQ0pvwY8u6CiLPjsuSv0gyniFLlF7/IMXLh7RqGkf1tJcyJHrTe/3VCMsGGb01iy/6POqcdViMgfbvU4ryqE+xost8ca+JlxAv7ea8RBIF3PZmvPS9gCEvaj1WXXUMWbgg+AVIieVnKghL74sX70xKDw6DLHDcjkfFwQI8lzKkjM0opJXQQiCGT4eNIlQnFTPnmvddWKCI23TqWcJ3947JTpvMoZNbVkc2TVoxWKggqY9nI27t3X/tRcIUUIWn2qUNFs4KHI66Vpkt35bGpU1SiiBXf74Oo9N9kzmS4NtYD+d72DK0Brp4FAIMMAyAy+O21WR1BntY6VggACgvi58bpnMUX4hQFD/93jc0jqNHLlBpVGT1vT0CIXlWnTsgnHpNtHiwUWQR8B9NOLzcVh552v0qiJPH7UfDrkqcUt2gU66yjbU7o2sD6/rIF2zVwtsiIKAa8B0ryzAh6oGlI4Uoo93Jn5hzZw19ajFBzY2K3kTDufo7a3RhB1ubizMAcvujkPksuMS8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69dd228c-adcd-4511-6274-08dc22c52461
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 01:28:49.3628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I49oiOCyZR/wkd6P0nVqSo+8/7DnjJXbFqWFrnfm1eonLLa7Ha6OradMYrxPs/9/oAr7jqHONpssUrdY6TAL4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR04MB8878

On Wed, Jan 31, 2024 at 08:04:59PM +0100, David Sterba wrote:
> On Wed, Jan 31, 2024 at 04:13:45PM +0900, Naohiro Aota wrote:
> > We disable offloading checksum to workqueues and do it synchronously wh=
en
> > the checksum algorithm is fast. However, as reported in the link below,
> > RAID0 with multiple devices may suffer from the sync checksum, because
> > "fast checksum" is still not fast enough to catch up RAID0 writing.
> >=20
> > To measure the effectiveness of sync checksum for developers, it would =
be
> > better to have a switch for the sync checksum under CONFIG_BTRFS_DEBUG
> > hood.
> >=20
> > This commit introduces fs_devices->sync_csum_mode for CONFIG_BTRFS_DEBU=
G,
>=20
> Please rename it to offload_checksums, this also inverts the logic but
> is IMHO clear what it does.

Sure. I'll do so.

> > so that a btrfs developer can change the behavior by writing to
> > /sys/fs/btrfs/<uuid>/sync_csum. The default is "auto" which is the same=
 as
> > the previous behavior. Or, you can set "on" or "off" to always/never us=
e
> > sync checksum.
> >=20
> > More benchmark should be collected with this knob to implement a proper
> > criteria to enable/disable sync checksum.
> >=20
> > Link: https://lore.kernel.org/linux-btrfs/20230731152223.4EFB.409509F4@=
e16-tech.com/
> > Link: https://lore.kernel.org/linux-btrfs/p3vo3g7pqn664mhmdhlotu5dzcna6=
vjtcoc2hb2lsgo2fwct7k@xzaxclba5tae/
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> > v2:
> > - Call it "sync checksum" properly
> > - Removed a patch to automatically change checksum behavior
> > - Hide the sysfs interface under CONFIG_BTRFS_DEBUG
> > ---
> >  fs/btrfs/bio.c     | 13 ++++++++++++-
> >  fs/btrfs/sysfs.c   | 43 +++++++++++++++++++++++++++++++++++++++++++
> >  fs/btrfs/volumes.h | 23 +++++++++++++++++++++++
> >  3 files changed, 78 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/fs/btrfs/bio.c b/fs/btrfs/bio.c
> > index 960b81718e29..c896d3cd792b 100644
> > --- a/fs/btrfs/bio.c
> > +++ b/fs/btrfs/bio.c
> > @@ -608,8 +608,19 @@ static void run_one_async_done(struct btrfs_work *=
work, bool do_free)
> > =20
> >  static bool should_async_write(struct btrfs_bio *bbio)
> >  {
> > +	bool auto_csum_mode =3D true;
> > +
> > +#ifdef CONFIG_BTRFS_DEBUG
> > +	struct btrfs_fs_devices *fs_devices =3D bbio->fs_info->fs_devices;
> > +
> > +	if (fs_devices->sync_csum_mode =3D=3D BTRFS_SYNC_CSUM_FORCE_ON)
> > +		return false;
> > +
> > +	auto_csum_mode =3D fs_devices->sync_csum_mode =3D=3D BTRFS_SYNC_CSUM_=
AUTO;
> > +#endif
> > +
> >  	/* Submit synchronously if the checksum implementation is fast. */
> > -	if (test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_info->flags))
> > +	if (auto_csum_mode && test_bit(BTRFS_FS_CSUM_IMPL_FAST, &bbio->fs_inf=
o->flags))
> >  		return false;
> > =20
> >  	/*
> > diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> > index 84c05246ffd8..ea1e54149ef4 100644
> > --- a/fs/btrfs/sysfs.c
> > +++ b/fs/btrfs/sysfs.c
> > @@ -1306,6 +1306,46 @@ static ssize_t btrfs_bg_reclaim_threshold_store(=
struct kobject *kobj,
> >  BTRFS_ATTR_RW(, bg_reclaim_threshold, btrfs_bg_reclaim_threshold_show,
> >  	      btrfs_bg_reclaim_threshold_store);
> > =20
> > +#ifdef CONFIG_BTRFS_DEBUG
> > +static ssize_t btrfs_sync_csum_show(struct kobject *kobj,
> > +				    struct kobj_attribute *a, char *buf)
> > +{
> > +	struct btrfs_fs_devices *fs_devices =3D to_fs_devs(kobj);
> > +
> > +	switch (fs_devices->sync_csum_mode) {
> > +	case BTRFS_SYNC_CSUM_AUTO:
> > +		return sysfs_emit(buf, "auto\n");
> > +	case BTRFS_SYNC_CSUM_FORCE_ON:
> > +		return sysfs_emit(buf, "on\n");
> > +	case BTRFS_SYNC_CSUM_FORCE_OFF:
> > +		return sysfs_emit(buf, "off\n");
>=20
> We're using numeric indicators for on/off in other sysfs files, though
> here it's a bit more readable.

But, numeric indicators (0/1) cannot indicate tripe values well. Should I
represent it as e.g, "auto" =3D> 0, "on" =3D> 1, "off" =3D> -1?

>=20
> > +	default:
> > +		WARN_ON(1);
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static ssize_t btrfs_sync_csum_store(struct kobject *kobj,
> > +				     struct kobj_attribute *a, const char *buf,
> > +				     size_t len)
> > +{
> > +	struct btrfs_fs_devices *fs_devices =3D to_fs_devs(kobj);
> > +
> > +	if (sysfs_streq(buf, "auto"))
>=20
> Please use kstrobool, it accepts awide range of "yes/no" values and
> check for "auto" only after it returns -EINVAL.

Sure.

> > +		fs_devices->sync_csum_mode =3D BTRFS_SYNC_CSUM_AUTO;
> > +	else if (sysfs_streq(buf, "on"))
> > +		fs_devices->sync_csum_mode =3D BTRFS_SYNC_CSUM_FORCE_ON;
> > +	else if (sysfs_streq(buf, "off"))
> > +		fs_devices->sync_csum_mode =3D BTRFS_SYNC_CSUM_FORCE_OFF;
> > +	else
> > +		return -EINVAL;
> > +
> > +	return len;
> > +	return -EINVAL;
> > +}=

