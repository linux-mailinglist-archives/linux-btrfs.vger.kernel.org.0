Return-Path: <linux-btrfs+bounces-4977-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B1C8C5A1B
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 19:14:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF7828100A
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 May 2024 17:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3973217F39E;
	Tue, 14 May 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="US8IKLis";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z4KhzIFP"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD16FC5
	for <linux-btrfs@vger.kernel.org>; Tue, 14 May 2024 17:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706885; cv=fail; b=NDfNW74Qny4JOXgfvo49TavlrvjuCFjLrgWami4fYkqB80Vi/BonEa/z8dDhqYmJKSA2u7G4gBS1+CZRrikf6Mlo6UvRSPQfwcrp2QJHjebx/StG+tu3R8SGBhC2eUzG/sFtS8OdH4c10rDv6Ta4JdPnMawXl8wRh3s4EEXt55k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706885; c=relaxed/simple;
	bh=sHr06qUpVD9RPiEmCZxeWiokCq7kzQIdO/LOxP+eZW4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aex+F4P2jVskeD3P9JSXgLCW/BHksJKHC93ViItnm+64W9eV7mfuV3q8Q/ziv3vw+37vCCUYjXdP+iD4nxiX7aBU4aoHudXmWnNmJ4Hs7mNDeVQvG3klLAEhvR5HFPme10EI0tRafZqTzNO6UMhmmpBBFf55hotUKq3w2syiftM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=US8IKLis; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Z4KhzIFP; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715706883; x=1747242883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=sHr06qUpVD9RPiEmCZxeWiokCq7kzQIdO/LOxP+eZW4=;
  b=US8IKLisyEBC+txioNPoThJ+gMP8S1k/X3OG0KESKJz5mIZERxjsGh0T
   U2qrCjfz9zqJqLPCqhGQnrKGFgNUQjsyHnFbrmTwfy4r2XWSkqiVJ1quc
   91ju6Q1TUwENF8MsuHP1RpFLvnsqmc6PQyO3wSOFMwjQKoRlvUhIN3Mbp
   TbEFQcDJGSbCypheh0vnDVxMi/B9ICo6D4qwpPpP+8bvEhccolFRbQmZL
   oBBMeLboZ8MB3Qcw+nJ41Q76libPSVkJUQUWtblF9eVenZ8P3sCiWaom2
   CKGTEBujqpQ+roqd1dbO8CDzBKC88fVXewBQ67a2w7fo8+Dlf5ALid/E0
   A==;
X-CSE-ConnectionGUID: ZFi/LF3pTgOojOknN9BZ0w==
X-CSE-MsgGUID: Mu272K4xSkOryyIgypWtPQ==
X-IronPort-AV: E=Sophos;i="6.08,159,1712592000"; 
   d="scan'208";a="16321175"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2024 01:14:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjitGIwNacetCS7aZtzeJ54ilS4N1XMoWPyzVtiWjSw00yIDSbc6JOPUc64g+G0ysFecdSRIqhN8ut5T0h0haBNYthdECUEXrD0FuNofo4axPdRawuyAfauGlECl3j85ypF0iTprMeaxTRIMw/+jkQH81JiFm9B44j9Tro8Qyd04HDQLbSpa5kNkRlJrX81h0Lx67E6pES/Uw+yEEJ2pUgeV5vN7UaJfZ9o6Y7eVGuIUcKvurAlgAnzZ8FiLKsK+r43EUV3PnbUEq0HhkvyJ1458JjrBYP9xQhxQLbodn7SAlG+4Unn8sV45SDUpRjk+J4HNM0r948jGthok2MQzFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7xqRbxy535b+TL7cIDKAX2Rv1GNfAaYt+OQ0UeqNSsc=;
 b=gq8aQQnXkurJ4c9rxMer01Yutcmb4yOKZfw344KGxkvJiu7ZL2M6wdrQ/EeppiZgm/tejfPXQmuiruTP2DV99lOnGt7rycqvZhmVrcjrYhdlRDdSYYl/Q1pu5mJQVAtjnPumIbGAzrY5c6iNDHJ9naoinUL9j/vBrY+FIJDvexz93g6jj/wOZpkngXuA1EVUGexC4ySK8Q4eLqIqMxInZVrS5OrVVni2OLlq4nGHFd8nJknjssl8yMTglvlyYbCSUwnXDEHxyGj7rgQatHjqkkhQW0fqAUNNVesSMmWeMldrB3LeP3w2u30C+XXdNgHGZa06ss4HpTef+Jq7cOdTdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7xqRbxy535b+TL7cIDKAX2Rv1GNfAaYt+OQ0UeqNSsc=;
 b=Z4KhzIFPecLZoopHoKyo1EucF313tyMCNgF3vvVkdnZ8hBiAC2jtYomOhYhk0Ndhd5TMXM+3V8Z450o5iqfoKPEIdXFLy4M8fbZDb++dAx8sICBLeZ3Pjo81vX5Z6TiNMY8s3Fjx/sOYLjf3+qpABwTT18VNMa1u3abR5gMMPNs=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH7PR04MB8683.namprd04.prod.outlook.com (2603:10b6:510:24e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 14 May
 2024 17:14:39 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57%3]) with mapi id 15.20.7587.025; Tue, 14 May 2024
 17:14:39 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/7] btrfs-progs: zoned: proper "mkfs.btrfs -b" support
Thread-Topic: [PATCH 0/7] btrfs-progs: zoned: proper "mkfs.btrfs -b" support
Thread-Index: AQHapZjp02ayEh7KyUKjN7AB+suAerGW3qkAgAAajIA=
Date: Tue, 14 May 2024 17:14:39 +0000
Message-ID: <xbrkuvkwzzwufyiqgxve67zwhwf2pxqkiiqsorbnfb3jgdug35@cs32x5a5jkv2>
References: <20240514005133.44786-1-naohiro.aota@wdc.com>
 <20240514153938.GE4449@twin.jikos.cz>
In-Reply-To: <20240514153938.GE4449@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH7PR04MB8683:EE_
x-ms-office365-filtering-correlation-id: 2e2516fd-a65f-44df-eed0-08dc743956bf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?afPHYIRK2qp0MhDYBIkuc/s9IYquPs34Ju1fd9os5y3jK2ja/MYH9tyAShuR?=
 =?us-ascii?Q?7lYKXRkRwJcHzdyIgWCryITXfg+exuZUsrlFHauGpdJB06/cUkKT0YWD9eoo?=
 =?us-ascii?Q?Wat5Ooo5Cha/+u+JNriN6rGKVDbh2BketAp84yZyZJxspG8KxVg237Mew7NU?=
 =?us-ascii?Q?Ex/dXGJatAIjPQdqOdayK1eWAZvPNeyA1Zym4ZFu80IRtcxxdvTy2M82LVrj?=
 =?us-ascii?Q?1wJQTeiredlCzUP7d0Ud964NZIbIRQNorBM37ZNIgm3v0mJ1VO+XzduUXpNc?=
 =?us-ascii?Q?98qgkCYv+SVK1r8IXEfH1KjigQuh7gx+KhSy+KE6CQ5aaqCfNDwAVwYbty3m?=
 =?us-ascii?Q?KNmJ2qOfH3NQhYU6Yefei8V8xl1d7CFHFvoxmYl9DDfsofZSK91DEo5ZLiDl?=
 =?us-ascii?Q?FhEJPIH8MOF1/mRPnYzjAkU4jmammi4XMTiNKyXd1bxfXH/S38FKrmWzt9LE?=
 =?us-ascii?Q?uqjCVb0qsDWjiDyYWG3haRuOePXe+GaSYS4DGgePLuk4YjjJgx6IMBsNKa8P?=
 =?us-ascii?Q?EMmI7ECaBC3GWBhXxWuhtrP2yuQdPFhQX2fWaZVowhbrDare7kwWZt5VXV1d?=
 =?us-ascii?Q?z9yrTtg0X/hP1GSEsO/7BXeXG/Vfd7XqnKOItit8/30g7lISgspFfhj8zfPm?=
 =?us-ascii?Q?pZhRT/itAZ3z7cJ9HeIUso+SE7W76aKOU96SIHsRVXUyvo5LeKpgc1jX325+?=
 =?us-ascii?Q?Kg+8ibo5YNJy5B8zjjJBzmOYvfANQ8/a3hnxfILBdfO7Vre3lxldZsfwG104?=
 =?us-ascii?Q?6GjV/0J3VOgdYyrgTxICNvexvpUjqwFz6CdWtpqljc90c6GTvyfY+CR+0zBk?=
 =?us-ascii?Q?jeVgZ+Lh17i/TCv85FrHCxS4NAgcomvnk8PF7tdr/6q4k8FWZ8wMopBfTmMZ?=
 =?us-ascii?Q?8JWY33itQwBJSeFTiooPw5em7lE8w6UZmsOYfNWsTx8bfFiUasgEhCPZfYWN?=
 =?us-ascii?Q?fJo44sw2AL5AO8Zu5dN3ufSpzDXykmBA0EmcFW7FvyTc+iHjSmxkxjIoO0hO?=
 =?us-ascii?Q?a3bP/WsQw00CFBTKtX/O8PSazHT3GsuzVKmuhz7GXZO9RpMAUoyuhr0eAC1g?=
 =?us-ascii?Q?YuK8EWJcXJks4KMCKc1RG+iJDJCDdfNefG5Egm4Bs+yGCXwaj0QuB1zGgwjv?=
 =?us-ascii?Q?ZK16tH+dIgDtmnMZDYW5omTHe8hZ8vYNAyPYAKqdn9AdLs7xIqQ0RCf74n6R?=
 =?us-ascii?Q?nvKJgXTByaAO07c9g/ukxDuGseSl2t5R3D2+O8uuPXgGc3a4TEffYnK501n1?=
 =?us-ascii?Q?D5HLVGOjSFM78FvyS2GNYbHfXIH0LLyJtVaM8HH4zBrBtTg5Qmi0PKf7nHZe?=
 =?us-ascii?Q?5uE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OF5gOS1V7Nu1+M+VE5r74w+az7bSXMRhSGVlG2ATVHsj2sQnvPOm59X3PhiS?=
 =?us-ascii?Q?WITCJPO9L3ZEGsPbHjKelUylRS5JBQLoGFqpqT7nLIaYKdWezL+kzdYuX9xK?=
 =?us-ascii?Q?Iwe155KAuCzG+3kSjCm7JaxahRSEVw2knsseIz3b1gupz0fKMTNunMx0f0Uq?=
 =?us-ascii?Q?16TCuaVTqtIPQd6dCdheRQCLOUbmEXqwF1zVXe56+feip22ukF9hYawsPBe+?=
 =?us-ascii?Q?C0uh8Bm0eS/t7PRkWRD6emCtYcKuCgz5lK6DcegJepWbq3BmoK5a345kgkEA?=
 =?us-ascii?Q?2gnj86iv6JG4dY/JDoMw54DcWmTTHpgLHSz1NG1M3qcdb8dx2A9JlkW+a4Qu?=
 =?us-ascii?Q?7iRXQfrC2BLQ4YHTyq3E8vNTOD98zuGILgW6doAd3f9SrdrofIe79wLlokZL?=
 =?us-ascii?Q?o4XcP2Bk4Cs0vgbDZPIJikzrrt6MkePpjHpuSpRh8WRJioQC9Wk55D8uq8d1?=
 =?us-ascii?Q?uxGHWlL/N+YwGcPlwW0eYR8mv5vmpzce/k2eFsoc76fyUH5vWUYBy/RNQ9Je?=
 =?us-ascii?Q?u/qt7GR5oGGbzj8vXYrOgLSoNVzBvwXLD8G8r4xXdcMWl62pa9ALQUXVF4xG?=
 =?us-ascii?Q?sFbxyKO1ZVQuGg+nI+48j872yLXP63ByCPidb0wlCIqPJDlxq0NOrK2h2j4I?=
 =?us-ascii?Q?5gKG5qWMrU2BSjPrkKYCknf5U5Hb0R10qc6xlmAgVsUMOLkEsA6JvZY/1Hf+?=
 =?us-ascii?Q?X1ctpwAXd0etZ670C6h5CuYSObi5atZraW2Q1NGQ/gYdiHIgYOlm998Kvpy4?=
 =?us-ascii?Q?ans3NL0egsST4I4Bp4HW1/DHPSKbLeEcSvzWajTa+bQEix9wWMv8G6WGBund?=
 =?us-ascii?Q?eeIUvbCnt6rBydKXTODvU+9EMKPMnvBHiRQeODzcmwP4xX5d0aOc7czgXvVF?=
 =?us-ascii?Q?/2MVs/VEDp7l2IiepeI5X+h9D0fe0iB0qyqf0ffxSpt51QSgd07B27ytrli3?=
 =?us-ascii?Q?22Wxg8m4fvMnXSNACDGb2U9lD4nAYvJNM0xqaGE0mbN1zNPH8MBw27qAWTPR?=
 =?us-ascii?Q?1oFoVGR39jcIa+wGfF0lw1GwU6sozrfY2tYyl2n/OUEIdVZRKOjtalbi7eWU?=
 =?us-ascii?Q?zUm/PX641G2XiAUUnbXzBOV0mDZgSQPxlb0/iG5KoFFEQuRxmZI66+67im1i?=
 =?us-ascii?Q?0aqnBQa5BvF+fxluxaKtPGPUqMwfnFXmp0tWTwcARCp3pkHoINgZwtuSBRSa?=
 =?us-ascii?Q?a3hgfPoCQh/seIWfYwshk+ZWrtj3DGmgX2dTZPAhBcJh7WHDVvmWoSJu19+7?=
 =?us-ascii?Q?DuxMPXV7gN9bGTiZeefoMbC7fsjw3HGlA5Af7R32ANCsUy2HCZrHIkizGixc?=
 =?us-ascii?Q?6mtpKZZsKotdE00wVjJd6t+Xs2cR1oJo7VkGueJ7XKtcvBAc4OxPdF7NxoAQ?=
 =?us-ascii?Q?zKTWz3ihU6xXB9dzKMy394zHqebShlF1UlIduMZmH4hNzoBvU22LvCvwLKyZ?=
 =?us-ascii?Q?MTTEjMHd88awsPV7JmgJe/NTVy7CqvQ0yZKMvRiMKOx0K0YweTc6YF1R4U/2?=
 =?us-ascii?Q?XJ+bCFfi5WhnuvwqzZ52Ze9RJUygiik90gxCAKPmuHL7V0YdMKGOyhxPR6at?=
 =?us-ascii?Q?IJRDqiPOlnCSN86YJHVjGpmAOLvb3BaQA1NjB5V6?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8B92C4DEED633243B4F90C20C981C6E7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tsBmcWbQkxxZXgIf2Nc1Q6Gng5nAfMqhlvFeXQMRaghshTMJEW9kwmEWCs2Om+796CsgzXDKhb+tHK5Y+KabB/LL/diabE7NpSwu+uJBiGGk2U4czeaXqtzlaCffaMz/zGIFtie37Bhq34JUvAIIPfhhF47SGw0f1dfT9oUZC1trdN5QsCxNI5JYBuVxeDEqGz9j/Wn0pGTCzOcWqppOWybXUWrs3vz+Lb4+y3eMbjFxj/9spel8HhOEQ+OL0WvuDPJv8PKaCK7D+a1X9O9diEcINZISwQVm5cTX/wHum9YVquJ9s+W2/yFOIC5csPKFwQS9BHyea7/nafNG5pNaksQVs03GFDKbSAHpiqzRf5lsyMr/Vtr8AlP2fePfX3RNwjVfrg5xdv2DZ0mkWbS8rpH1uFILSdzy4g3QwexxLhZpCUdG/31jBTsIY32Jl5dJ6zDiRBauWFyyTZFS8mZ4lx+R++pRDg/X9/BcxdtvdukIehmioC6bTynITNB/yQJbvsY7Tbu+vCuLBIzCB5943k4JiaP7S/KxyVmrKolDkLXtX3QTrL1M+7ulFMmwflwjLh9faMnsxApuAvG323eyUNcK7MMhwULt90JtmcvNEwUl4/4nw4jFAne4DXKdFbXw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2516fd-a65f-44df-eed0-08dc743956bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2024 17:14:39.6897
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TbHdFwUBN9m49GZ9+GFE0gHd6wg9cAIeD9VD8LAsTLknzvqtk8gerWoRVOEDHutRWzeuh2mWHw8U/VLhNKpVbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8683

On Tue, May 14, 2024 at 05:39:38PM +0200, David Sterba wrote:
> On Mon, May 13, 2024 at 06:51:26PM -0600, Naohiro Aota wrote:
> > mkfs.btrfs -b <byte_count> on a zoned device has several issues listed
> > below.
> >=20
> > - The FS size needs to be larger than minimal size that can host a btrf=
s,
> >   but its calculation does not consider non-SINGLE profile
> > - The calculation also does not ensure tree-log BG and data relocation =
BG
> > - It allows creating a FS not aligned to the zone boundary
> > - It resets all device zones beyond the specified length
> >=20
> > This series fixes the issues with some cleanups.
> >=20
> > Patches 1 to 3 are clean up patches, so they should not change the beha=
vior.
> >=20
> > Patches 4 to 6 address the issues and the last patch adds a test case.
> >=20
> > Naohiro Aota (7):
> >   btrfs-progs: rename block_count to byte_count
> >   btrfs-progs: mkfs: remove duplicated device size check
> >   btrfs-progs: mkfs: unify zoned mode minimum size calc into
> >     btrfs_min_dev_size()
> >   btrfs-progs: mkfs: fix minimum size calculation for zoned
> >   btrfs-progs: mkfs: check if byte_count is zone size aligned
> >   btrfs-progs: support byte length for zone resetting
> >   btrfs-progs: add test for zone resetting
>=20
> I did a quick CI check, the mkfs tests fails. You can open a pull
> request to get your changes tested (it can be just for the testing
> purpose, if you note that I'll skip it until the final version).
>=20
> https://github.com/kdave/btrfs-progs/actions/runs/9081685951

Thank you. I just noticed some workflows are running on my btrfs-progs
repository too.

I'm checking the fixed code with this workflow just in case.

> There are also some compatibility build tests on older distros,
>=20
> https://github.com/kdave/btrfs-progs/actions/runs/9081685969

