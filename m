Return-Path: <linux-btrfs+bounces-7992-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD27977A45
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 09:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED74CB27684
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 07:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDFF1BD4E4;
	Fri, 13 Sep 2024 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pp3bHrAY";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="H7mAmlsG"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC1B154BFC
	for <linux-btrfs@vger.kernel.org>; Fri, 13 Sep 2024 07:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213580; cv=fail; b=nJiE93wcjuVZABHZ7oaJvR1p3mSv0d5rALRE4sfKFeOeI0gIeHm8o2rlBlDyMSOZPuWp5Etrzu5zGAt6cUfH5lUYZSEl9cuE29erTyM71cIgQ4C4As4ATxH2UysUTqAqti5NMvfjMci/UAWZM+lwK425x+c3DEXvhqLJq97W4YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213580; c=relaxed/simple;
	bh=CF3RFm9Ey0KJ2yVXYNFoaegTBhOAcSSM0C7i2njoEz4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZKUBMfyoRILTkaBGSBAfWJ4+ElmAJ2gJbHIvyXuA8ALES1wGMGU4z/3xSNQHxeni2IRoHcy3b22EUM+uM1XRUYVMQUGIAqdhqeXNdyg40EdM41ZpKINi3xkYDJJw2drviTVtTRvdvK4Rr0Hs40/y+dNHG4BZ7sOb3lnCVMHVKqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pp3bHrAY; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=H7mAmlsG; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726213578; x=1757749578;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CF3RFm9Ey0KJ2yVXYNFoaegTBhOAcSSM0C7i2njoEz4=;
  b=pp3bHrAY9HRW+jejr3r3WcKrZ1mnOr/16Nic5i1mvd2bVttMtpmYzM46
   OdWdkSSGMG1ilb2yT9zb/SZ4xtd0zZxhtpKPBpetTN8yAJTEcWRj5YPp1
   FtsBnTt53aVndBo3YJkMIwLvoJp4jCnfQ/wCsk6GwR6yZwbP8e+MKXbHo
   m5hHqMV1Jw4d9s0q2NX1fcw2bS7n6W/N1MPbYbHev6B3UuA1clfWoXSd7
   Ds7gDn8te/Bjd0iY6kdB3at3y96oI1r6u4z+bFKr+NojXfQj1XFrrj8Yz
   OLSqJjimhnGnkZcXLJir+zghhi0HmyNtpnYGZVqAF9rnszx4plyBinMGQ
   g==;
X-CSE-ConnectionGUID: raqQiPfAS9e7OGEGlTqxQA==
X-CSE-MsgGUID: seYGcT9+QbqmeUadhbIOLw==
X-IronPort-AV: E=Sophos;i="6.10,225,1719849600"; 
   d="scan'208";a="26610313"
Received: from mail-northcentralusazlp17010000.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([40.93.20.0])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2024 15:46:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0Pzccu+roDbO2gCLCWsiAH/syjbuEjnM/diC8RbyXDmTVgW0MzBy92IWuwWYAtDyjUcnZwwvP06ncOouJH8gSMKKGmOuIzcwJslsFG+ZBZCuco1o9EaUGvMJ6FoHPmnZeQR+yRaFvNmckFm+Taw+HDWkKHqxrS9Jl9jy5XJRUkNvWJ7erKJxtPXgsyTcv099JhiRFxt89UG9/yibYk4KlHaBL7qdXFroHVtamC6CLr7/etqMmP0g3nudF2Bdf75tUKG/K0MAomBtjPEcWacb/6NI+I+p2g0ldbYtykk8o54zjpTSaoxngK+7DLtQSLg8chnaKFODpmyb3jrMRw1YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfwTPmZprNmOJDxCmiH9RcmttDLurac9IRsieP9PGtU=;
 b=u8OekN9t7QJfOyecaL81Ij76iC7MkNMxIy73acEIxXA3xzF5BeAK62rPemi/I3fGqPdoOGxI5uF64JvKKpa8YTm5Ap/qtrBeXiLJ2lkVJxbjrxin4c4Lw/gKppipglz7ooJI3NyDh28Em5dAu1UzSXK6fxe7Vv3sVliQ+Eb91ogdkikY5wRbkKSg/Dd7Qvyo8+kLGz0mhTH6q7ZvEn3DncwzhuUaMSjUKAza4DA/T7a40bfBfShj6OThStxvcwYNWDHzGilyDZTnPefjAqkV/C/NSfE+qMVLmVU72c4VE8j0FJnGqTOb/gIyQt3Kz6rHGFpXAcF/LCM6oo3MzdUo2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfwTPmZprNmOJDxCmiH9RcmttDLurac9IRsieP9PGtU=;
 b=H7mAmlsGkDMEV4nDFPfabJWqgQm4DzDtNHch9zCpf2uE/JI2rUUKmtrteeZdfOAUlp8+oJJ8CtB5ZUGBV44jERRMn/XhpLRgDZa/DFlOivFTDmK5BtHC7r5gXzvXnhFWjSfGOADAGFZI820UK/GP5jAYdZCOehJV/LZgImIBpzs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by LV3PR04MB9258.namprd04.prod.outlook.com (2603:10b6:408:26a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.20; Fri, 13 Sep
 2024 07:46:15 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 07:46:14 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"xuefer@gmail.com" <xuefer@gmail.com>
Subject: Re: [PATCH] btrfs: zoned: clear SB magic on conventional zone
Thread-Topic: [PATCH] btrfs: zoned: clear SB magic on conventional zone
Thread-Index: AQHbBYLzKk4OKV1Zy0iDf2f7Bly9L7JVQ5aAgAATVQA=
Date: Fri, 13 Sep 2024 07:46:14 +0000
Message-ID: <7eqi7tf2xv43r2pwqpgzcia6vtobnp5jrwnb64nyj7a54m5rmu@kkhsqy3msgc3>
References:
 <98ef25697d52cd3e17b44a846e60eba9e5dfb39c.1726193590.git.naohiro.aota@wdc.com>
 <aecafe2f-a3e8-45dd-8c06-27e5925896a6@wdc.com>
In-Reply-To: <aecafe2f-a3e8-45dd-8c06-27e5925896a6@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|LV3PR04MB9258:EE_
x-ms-office365-filtering-correlation-id: da683f7a-a683-4cc8-bd9e-08dcd3c82508
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Fnai6RUy3R6hbp4H0qXqgn6SX8hJTSU0XDTdaWvvBWuD83v2rjseQxlEpQJu?=
 =?us-ascii?Q?EF9RtgQGmIfvW9ELHgFiA3JJ+3CZENW8vse4rPt6gcn2w+KdPixMpEWFbES5?=
 =?us-ascii?Q?ZEh0GADAl+5rPFTabGk+vyyAmfLpJcJdWkPQ+e6uPPauApclouZTBxFXZB4d?=
 =?us-ascii?Q?GNb1ubgYtfTM8bjba0pLeyP+AASm3s6ktuGfvUPGwy3CAaP+Fjw6SlgaZJeF?=
 =?us-ascii?Q?G2nRcn+fL4UXdHFdDHRZTzJHC7GPSd3jazfVyIQfgh0q5HrrZv2pIv0uPNUQ?=
 =?us-ascii?Q?NFTX6V0lzAhYdyc3HjZKvBCZMTBEeZ2ISlVw0IVxSF6ajSxG8kXQ2AlHId5o?=
 =?us-ascii?Q?7I/FRlUkvP3JANMZ/kVaayZtH7FgvzU9AVfGGrqQROUITwSJI+kDz3nygeiI?=
 =?us-ascii?Q?CmXWqaKE5y7eZvmQdlWN+zPxrYbf8W/4xRZ+G+lfhW9C0UOGfDhh2h1hZa8a?=
 =?us-ascii?Q?jj1O4dnNBiRVpEVd/OPrqiKqwC+OPEJEaYDf2ENJSjsYdbEXy0sL/XVxJ0DL?=
 =?us-ascii?Q?/uvN9ROVveMUxiYcX6JhXBhmxIPT/H5KUnqR1OmfIVkRtsxX+9bPfuxu8y9f?=
 =?us-ascii?Q?B1g9ZBsVccIdFeaNQySSU/cjOUHwKf9L9IcXto2K4PCYn1HO3YuQnNKyMhst?=
 =?us-ascii?Q?Lk7fbreeoVmEVqY61giT2iGFwe7yjGmkVIkJJ4v7zkvq3DiWkHTUV8RXhxiz?=
 =?us-ascii?Q?NA78dVQIRM8Rt78iuh5LfA07c0F7RHBzZZHVj0X0TM1ywJ0gyeVoAynSCTk+?=
 =?us-ascii?Q?OLitJa0xJp52vCWj6FGUIBZiopnrCgrGPvL0g9gzS9YKHNarBF0lwlD1TUej?=
 =?us-ascii?Q?lmjdOQVHIGzzDSsyHsOJNy9CC/SjYPqzI4FxUxqsCHVHgNA1OJrFdqmac5bk?=
 =?us-ascii?Q?9qF0jYN6iYQtG5209Z4qBHyT3JLs1dPpQdNtALZAhpPoH3QfaBTcd/sg2rbH?=
 =?us-ascii?Q?PKxvh9h4jZVBByUtqrTILoUqS7bLQ1ssLXnvd7A/mg17hYGjxnHeG2IZCPiN?=
 =?us-ascii?Q?s1535E+AN0wxZ23oXPimDDU9dd/i3CUHKG+6GJX+fP8w0pCUNeDF1bZPxbKO?=
 =?us-ascii?Q?YL43eOGP7E4gxQBVPhSOfkEE2iN+dmbLSCPUMsPYBOu80ttTL3RLb4iE56AN?=
 =?us-ascii?Q?zX10Jp12258zanRfm1FhaLpm3SKbinE5NIzsDigIZYDbJdvN+jc5rTA5YcdG?=
 =?us-ascii?Q?h4sY4bLK4aeMR8Q2UQTuT2/316khzLPCRaTurppmHt79p/X9A7kNI/9Kb7zu?=
 =?us-ascii?Q?550Ous64PMhEQZwENR2RAowqrQRk43uJiLgTYt7suFFPysg/ScOEL+mKVRMJ?=
 =?us-ascii?Q?93ltTKYSb9tUrdQX0pK1lwTvw6JyBsKRxDDbnfI9bzhW+WLav+qO4dmdALGc?=
 =?us-ascii?Q?EFn809I070kl2so2sQ9yD2io9gI/jIvTax/m9uVW6MlbPCfUwA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0C35xDAkmT/f2SQdnh1QQGSq5aP74gHYc3P7JPsOdoMIr9TcTVMpbGsoPWWD?=
 =?us-ascii?Q?HH4y2gy/lPESun+rFDWuzu/zFkxN+FckpUPddrAWLeKilpr34BzXRv2sL1H7?=
 =?us-ascii?Q?Q9/4nZYfuXTdlML0f3THomXx8BSmP66ztgXtXO8Kxc3T+aRe+PtmeAZovo07?=
 =?us-ascii?Q?zaUbaKmnT/uIUUb7sR3Ca5VdQWBScWn0ALrwsvV9pmMdRHVHqrJPxHBipmcQ?=
 =?us-ascii?Q?ETGoko4S3kYxVqFSO4ZtgnCji7hJlsbftzIIlOVE9VdkA3i3QEngFq6zzwn1?=
 =?us-ascii?Q?e5iVmEeMuONIBIYG/Wul407rzCHSslgc5IJQIY8UKO4Nt4WCGNshHaVidbhf?=
 =?us-ascii?Q?Q3/smMvFQIaTVZytjWOq0lzBC+j8IspEZC9y/JNDrFpPdgTc77/TQm+ldySw?=
 =?us-ascii?Q?vYodT+GjkX/2GGaqNAvpsqSJedfI0Z4tYGZmdXHPWHQPoYqWZruL5F/q8Nkx?=
 =?us-ascii?Q?cBByhK9vyz9P2pgwTu8ng0nafVMRPpcQ2kN3tyyJJy+dF8PttJCXl476zOSo?=
 =?us-ascii?Q?a6Tzw3dD+QTAcTmvWai1NFvxCGeYogIWyinT7mLJW/4oSen6m5clfxj+Ovth?=
 =?us-ascii?Q?lUaM0JAIhDaR0l0zjZn1OydM8SjuJJnNxhyymqDTGI/GNk0KhVZ7KAc5/KAI?=
 =?us-ascii?Q?dPzN81BdQ2EhP1Ut6BpD61l6QlUwnJFdb4To10e7pBuC/srG4WPLZSEYNMxx?=
 =?us-ascii?Q?WAhI+csT6BeGnbXbJwKbnPuvuaDM5kLS+CHhneDmveTAo0dcAibRbCEyBou4?=
 =?us-ascii?Q?48PJNYQcAVKBzUr+2KsttVwx836KzEo8rn7JbL+c2XGvNBfckaUY0Ue5MJIH?=
 =?us-ascii?Q?AxrDWlAMCU6451cxoqDc9vchxVTMVw/lL5ChHEXXyzentOWZk+0FYbNzzo2k?=
 =?us-ascii?Q?0LW9NI8DAhxgj1YQbjhNkShR3t0fNeaxB4YbNw3IoQO7rxcs91zJ2Utm6Ldu?=
 =?us-ascii?Q?sX0bCOxjafibBtlPLEpMFsUXmbkpxZwnx55WxdahhoZ13MxLUllXPA0BllaT?=
 =?us-ascii?Q?jwpsPp62O8nCyImKoU4CeI3SXqetJglF+Jvku1jTEK+oqZTtseaCWYgBpFsI?=
 =?us-ascii?Q?s42HrJy8EDTcPC8bC2Mj/SxnDi0gwB5OViaNn02/2953uHpTqMewf2GBfQVy?=
 =?us-ascii?Q?ssfHXtWsm8Lzb1j+ZEykxT3FxysQIZayGllzmuo/eNc6sv4ml+a99U0uBo6D?=
 =?us-ascii?Q?ywhqGuf+TZWAI5LZKnEORclomzKTn9YFtw/UztWFI9SX+A8kXxXxolxGRXEc?=
 =?us-ascii?Q?1hhpt6oKJ+VUblgYKX1aE/cy6O+nCKyS/l0ooj3pkOcG826IqLIiJ+44VMzH?=
 =?us-ascii?Q?FbOclKGJ/jYQowXKG/NbQV31zAddzvVKV9hU/eqEEo/kAa0nsRqj6opsJp9h?=
 =?us-ascii?Q?Zy2BqGfI+i1znrY3XCvoy+vucm4swmtS2GCpcsEYzbe+IW1fRPT2UHjhTGpT?=
 =?us-ascii?Q?ph4KYa9ICHy1juJ4r4pByRSGB43gL/ZuWWeAfqF4PbvycR/9XDWOjIKsRvgL?=
 =?us-ascii?Q?ISlqX86yf+WhE88EIbSUottokkZ/pksbFnFhRGKRSguuZ+3fftS3Fh7KAiWA?=
 =?us-ascii?Q?s8kPktHteU4lb7Hmhkt4BGCMaDPi45shvAHjFXtziktoBStlaSLKggg5Xl78?=
 =?us-ascii?Q?Jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6FD8289803F3154EA12A67940E7A437E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3rwkfLIw2blbABy4MmgepaoPJyIzXyyOfX2In8uUF/X2lxNLUwOjnCdaiydAK93idbx/hVf+0WL09zq76oOssyQJZwotfksJ3FzkmJgzSY91THvdeKL0P7IBv6nSt3IRqjIN5X8dQsrvdiTLCq8bR6Td69jtgBgs/KpaOwjYCKFEUnreyyndYcDqsoajg+bh/Nv0SXJ71sc7bFLBk7pn9XZ9h+SRipjy8S6orsOGR3JHBea8L6KuyWkqceo/xzf/9TTXaRtvFiioO4AmuGCAwqslBSuECwC3w4RH7dmt8Pn247oYL4pWRrBBcbCNo8uyaPUJfNDiN3e0wv/nyl0q8NtgiemYx45xE8W+Z/znSfq1OI/Fu6jOenpWnYyfhdCRLXf7FS20CPUr0A5YD4h/pDQxyXhC9dnnrcT8J6VI1hEpHt+nxm18TZIJsBKpJl6vDaxtDDTjLVsIKpKt2ArAPd3AaYW9G4GYlHlPTeZzFQzNwiJPyF5eINF3BSclXrHzV3kIyxPQTI+QHZoAd6lqEHIJ7oqDvppLd9u1fWL+TXHBYiHMoESsxxQvcbwyG5LuyPx3UuUMVjictviC4SBr/r97BWyls48NICs0IjBge53BSOrjzfRKWL1aLbBHx9oW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da683f7a-a683-4cc8-bd9e-08dcd3c82508
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 07:46:14.7491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ypan05PTkPaV57FSJMBsy5ozVDLSRfSWp5eEOh0p56zrf9iy763ji6sGjHBFMokFSz/URlDSCd9z2r14qD75JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9258

On Fri, Sep 13, 2024 at 06:36:47AM GMT, Johannes Thumshirn wrote:
> On 13.09.24 04:16, Naohiro Aota wrote:
> > +	zone =3D &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror];
> > +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL) {
> > +		/*
> > +		 * If the first zone is conventional, the SB is placed at the
> > +		 * first zone.
> > +		 */
> > +
> > +		u64 bytenr =3D zone->start << SECTOR_SHIFT;
> > +		u64 bytenr_orig =3D btrfs_sb_offset(mirror);
> > +		struct btrfs_super_block *disk_super;
> > +		const size_t len =3D sizeof(disk_super->magic);
> > +
> > +		disk_super =3D btrfs_read_disk_super(device->bdev, bytenr, bytenr_or=
ig);
> > +		if (IS_ERR(disk_super))
> > +			return PTR_ERR(disk_super);
> > +
> > +		memset(&disk_super->magic, 0, len);
> > +		folio_mark_dirty(virt_to_folio(disk_super));
> > +		btrfs_release_disk_super(disk_super);
> > +
> > +		ret =3D sync_blockdev_range(device->bdev, bytenr, bytenr + len - 1);
> > +	} else {
> > +		unsigned int nofs_flags;
> > +
> > +		/*
> > +		 * For the other case, all zones must be a sequential required
> > +		 * zone.
> > +		 */
> > +#ifdef CONFIG_BTRFS_ASSERT
> > +		for (int i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
> > +			ASSERT(zone->type !=3D BLK_ZONE_TYPE_CONVENTIONAL);
> > +			zone++;
> > +		}
> > +		zone =3D &zinfo->sb_zones[BTRFS_NR_SB_LOG_ZONES * mirror];
> > +#endif
> > +
> > +		nofs_flags =3D memalloc_nofs_save();
> > +		ret =3D blkdev_zone_mgmt(device->bdev, REQ_OP_ZONE_RESET, zone->star=
t,
> > +				       zone->len * BTRFS_NR_SB_LOG_ZONES);
> > +		memalloc_nofs_restore(nofs_flags);
> > +
> > +		if (!ret) {
> > +			for (int i =3D 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
> > +				zone->cond =3D BLK_ZONE_COND_EMPTY;
> > +				zone->wp =3D zone->start;
> > +				zone++;
> > +			}
> > +		}
> > +	}
> > +
> > +	if (ret)
> > +		btrfs_warn(device->fs_info, "error clearing superblock number %d (%d=
)", mirror,
> > +			   ret);
> > +
>=20
> Is there a reason we can't go through the discard code for this? In the=20
> sequential zone case we end up with REQ_OP_ZONE_RESET in both code=20
> paths, in the conventional code case, we can do a REQ_OP_DISCARD or=20
> REQ_OP_WRITE_ZEROES for the whole 4k of the superblock.
>=20

Yeah, we can do so. I agree that is simple.

But, I tried to make the behavior compatible with the regular
mode. btrfs_scratch_superblock(), which handle the case for the regular
mode, just overwrites the SB magic (4 bytes?) and leaves other field
intact. I guess it is for a rescue option?

That is not possible on a sequential write required zone. So, I'd just
reset the zone entirely. (Well, reading the last SB, resetting the zone,
writing SB data with magic cleared may work..., though)

For a conventional zone, we can do the same logic as the regular case. So,
I follow that.=

