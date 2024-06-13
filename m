Return-Path: <linux-btrfs+bounces-5687-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71867905FA5
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB442835DE
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A7C4C69;
	Thu, 13 Jun 2024 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CNgmh/dH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="OHAsI6vu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4D54404
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237933; cv=fail; b=PDsjE5sf9VngRRJrQPnZfwmMolA2V6xplpeOHw27oS+ynJDpkg9SzNMuBNhYRJPzAht0RrqdODmbLuBJxJTu0R/HSdmEL4eayfRaEXLktTZJfqv9Y3u/ivKmB5UkBoc9qmMKRBXMibXfNIoyUsrKegEwn6F+yuwlOFJNCl4RWOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237933; c=relaxed/simple;
	bh=VaAePzZzZtlzjTBTrdIwdrFRFaeCxYY4sXFtrJDf/PE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YIS2h0Y/GZHfkSS6XVGz91yvXc27eKj8uWxYB3gTM2MzCS8sDIuyNVMdQ9I4xlN6qs5hBMAzf9b1bT/fVQNE3HIPTqYUAIOc7zGAFDzYN1AsosYPL/RZrgP8ei0MLLcuxdkTDfRan74vU6Sq4ijLfCPu0wic0KzRRBrqouSFl5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=CNgmh/dH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=OHAsI6vu; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718237931; x=1749773931;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VaAePzZzZtlzjTBTrdIwdrFRFaeCxYY4sXFtrJDf/PE=;
  b=CNgmh/dHHqWEjMCOCs03S6rYQpjN81oXGDkSri+tRR79dYopoj+HrMoK
   JUBPyNjQ8HyiASUv1J6zjk4jUsoqe+6AJwHH6mZu2DAAoS06TE9O3WoMM
   9WY5iDb05BMSOV3iY6f7LIz4zovJGj1KeuAesaBmdtFlzK+7P7Brk8rDZ
   JTFsSB+F3jNSqeQkJJnXUuaEVc4X3JB2HrHj9u6E28YkH6QMduG4f21Pl
   NQxLY9dUD94N8wP5bKUdStnrZeWtvgyiQxhzVPDKJt39T5wF1TMuj6ZKM
   brKZs54THrU9z7Mqs/63IUm5wkpw8nG5/XYuxnRQwOqRjAnKcmlazSJyT
   g==;
X-CSE-ConnectionGUID: R5ooECBsRuqb5tnY2fWiCg==
X-CSE-MsgGUID: DWzdSIPwSJaTwXQjevGO2A==
X-IronPort-AV: E=Sophos;i="6.08,234,1712592000"; 
   d="scan'208";a="19286079"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2024 08:18:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7+miMtFVjIf3CbIqj9NSeiKMy1WnA4GaeZckuKaHWVAe9dKU/SU2hVEKycCFWIRpO2ytk9/JqYGo/IQBMqCKoaCO/w1HTWzhx6LuXgTzFPFmXSw5uogVUMGIOkwMzw9dZMt5RhkLy/zva+XJcORfPMryIWC9xaY8vP1ACKaL5HMnMczx9L8Y4qlMEfudKsjJDur3PWAu7dAZ31lFaQVXAh4BZXA4nltkZKS7ZO8q/NjV3d0LzwlrcZ7rpEHzdNo0cAcuW1Wc5UpMgSFvOTgWskW6uJwtue4PV0WaIxsqp21wZlDfAYKIYS2P9uRU4gYmRw6htCnU+9DRj8AEcRWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAjoR1DG4kiu/n2kjjyjRcgiAtIwsPXPSUv/EAOwOpY=;
 b=BNGzcUHAWOC9EuybFc/brWydB4Dsd1Ds+sVFvalnCcF1tA9Fri6yLjJ5jXz1SZ4TBLHM+LapsAsnCkLp9SIKweCFSpfgcC0ElYA23/aKzSrLMMz/vvXRjvA3ipv34Y5lXgilGf2f4W2uSgTNeFmYbOGbnp5u1AW4lwcxCM17HNtgIrJf5epBLq5ppfQZg4Y49utKSoiIdBkoCoiNmhfwMKCYLsstVPkQCTNIwARNnXSZf6TsI9sXzQDGV70729vMVw3MCRnvqLCNvUjr3FJPXSEVf6I8Td0afh/tLZAYfCP1/kaxBfWqG7kUXO2tee920hK4IPg5l4+Fho4x62YG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAjoR1DG4kiu/n2kjjyjRcgiAtIwsPXPSUv/EAOwOpY=;
 b=OHAsI6vuXYEbmqBzmGvbjMOgmSi1/0Ky7N+6/KBuf1ZUBIE3zWn+Kt/lnq4WL3T3VBvC8alkN/FcldHWm6b09siTa0cT03rsRtV4Qzvd8nX5m8PMr11bpj1G1T+fllmmhCwtiPze4PCRFTSuy7Kl3Izv9L5Aa07NsUwgFpkC1FI=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8357.namprd04.prod.outlook.com (2603:10b6:a03:3d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 00:18:49 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 00:18:49 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix initial free space detection
Thread-Topic: [PATCH] btrfs: zoned: fix initial free space detection
Thread-Index: AQHau96tCqk6XbWvhEuhJmWeVSCHbbHEjBeAgABKsAA=
Date: Thu, 13 Jun 2024 00:18:48 +0000
Message-ID: <lxk6knivzysx6wag5ijotku3pw4agtfeytxyvqhvakfup42u77@khmgt7vbxpwp>
References:
 <ec2aafb75c235d9c37aef52068992dca0d060d5f.1718096605.git.naohiro.aota@wdc.com>
 <20240612195129.GN18508@twin.jikos.cz>
In-Reply-To: <20240612195129.GN18508@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB8357:EE_
x-ms-office365-filtering-correlation-id: 1d51a0db-1b70-4a37-6dd2-08dc8b3e65ad
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ukTwKurn1d6HfMdS2jbhPFXCkTI0RVCce1WlZAAFlgotTcNlE73b8M57Zv1Q?=
 =?us-ascii?Q?DQ/hiO+7IoQe6HYMIep+Um0+i2tzaL7qeP1J+TzvpYP18z5m9tbwgnU27I2W?=
 =?us-ascii?Q?6xeX2kO+fTiimA6UOB4xcHYVcIcE6QG7nTokBkl4d7446kmueJQpAxtPAc0j?=
 =?us-ascii?Q?+d7RuzShiVQDJxemQpP1owKWku2t71obAgKVNhP5GDHCoYwWqoqbKH5wqXV3?=
 =?us-ascii?Q?4+sf/DBvcCTU7AqSjAQWUu22hlA0sFFKoPs+9gXxZRvTpo9QKNEA5t5h2dMj?=
 =?us-ascii?Q?6AdDUXj0soDiT03eawDX4YkorXDowofySXYFdzaUjN58X8+7mlAwBsRaYyAq?=
 =?us-ascii?Q?rRe9DK8hJGl6cXCR15WPmGsin3USTqlPBZUUT/MV60UARfsJD7mmAIXjU3Rj?=
 =?us-ascii?Q?DUcVnt72ET9JJev4Sfk6Dgl3IXPJETNukG8F/eYIrYcy4sNu+xqpiz4HTy+v?=
 =?us-ascii?Q?5f6Ir3o4VTk/mJPCVznpfOKuvIaykVXSBjUQPbDGTyNqQHQlU6ZtWr4n78G0?=
 =?us-ascii?Q?ba2G4iy5Re1I1lnrZQSX3J29S6U9131K3rKkQfEy2ErCI6Za2EzKWMV3zeyH?=
 =?us-ascii?Q?5bDrwu8/owHnuyG2XpBaLrIHYm5hGp50ZGLCPgaZnTcjsDZcvAZtiDpj/yx8?=
 =?us-ascii?Q?hoqebucAv2DaP4aZuOicxSnIB8mqCBbSaOlaslIjwpBV+RVSvAGtXlIuuGSM?=
 =?us-ascii?Q?NSQkepo90YRxghz7mrnCLc41QKMWkkH4jKInQlNMKttssplPTCVhonFdiA2x?=
 =?us-ascii?Q?EgVKGbQaLlcnIVeHNIgyrrjyy2XqfVq0GMc1su3bWRjJv21vwY/4J4RUrjki?=
 =?us-ascii?Q?UMS+IxZcyUbfnZZ6gNW199yZARS5OFCh9Rg3AMsLZ9Foq7TyK3HgEUX2Im/x?=
 =?us-ascii?Q?KxSN17GfDYHT7X4IR1MHwtCuC/GHNPHTtFnzLzCq9Im9WbEYHLSHP1+zhYeR?=
 =?us-ascii?Q?GrsitJPCszZ3hrk1ZfZ4DrLa68bpZejt4I4gWYnZU8MPDNUGmv+0Ty2lYmzR?=
 =?us-ascii?Q?aB2YzYslf1m7N+SA7kgq++uTBvQJNn6U/1RzFmMLvEjuaTopZgJzT1PLPbHd?=
 =?us-ascii?Q?zsyFrrT0pMWrkOvDi7suuBLOWczVVReXhLijNPEPiT2hsDAzZJMjNE/q546Z?=
 =?us-ascii?Q?bka4oRMCN9udn0czt78IhZpzlsON2YtPSYlyc6oUcz0T8BBk0lwdPmetF4PH?=
 =?us-ascii?Q?Bq9JBOGKdiOmqjYvWhKdZl0HRplQI4tjmX+THjVTfXUMdWcI047MBwDv0sp5?=
 =?us-ascii?Q?kVpM5GFDebAoSrDpSaqiSdUsarRktr9oVMFJnTtacWISUDkGVfJgJ7NQyJK3?=
 =?us-ascii?Q?zMfOOBvT9y8fNTggrza2MSgMJnMVPWBkhkPu0udTNFUZSJayg3oDGncZS6PE?=
 =?us-ascii?Q?MPXk9tU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nMytMKl4MZNWfArk+nkJ7dzQ8B0LP9ZbX5HgTxOuN3zAozfKYKGaWg7V1i6c?=
 =?us-ascii?Q?mXiiybWLb33CkSRgWKQbpehBczCx/guY68Sj8/XcXSu+Ba+YWGsBKVmryhqh?=
 =?us-ascii?Q?DmzSKpsV7PutP6NFkGp2xFQOPuagMOwNvrcR/BlGlWm2XifF1raXd2FzW51d?=
 =?us-ascii?Q?sBUvt3zQCLyOdkXlTqH/I+fes8jnZAYJBYBgjf269Mm/EqXENqhw0Xb+Qx1L?=
 =?us-ascii?Q?pO3MxTnddUN23PW9p5FuTRGWdc3a/5Eozwo6ZVtX3nQUyuKL10Qmld3AeqBw?=
 =?us-ascii?Q?Pr61rOBg5aH2fwhRZFyw1f4xMwZDlkStsX7dND8Mdp9LyRrp0Cdw1q4T9mA6?=
 =?us-ascii?Q?3m5cIc4xhaTNTEroaGy+OsKTwP3UowNnAEe0nGTQ2Zt/LI1d2iEBOiP62sUn?=
 =?us-ascii?Q?v4G4NgpYTslEBjU4CaTPTpeFdN8sP6YhHK8Md50w5q9h7VrkfGWREoSSMopU?=
 =?us-ascii?Q?z7lKQKRAvWlSuGLcBqe+WS6XyjqhHoYkXaJUHzNJ6Xg6XrhqTYMURhsU/Sas?=
 =?us-ascii?Q?oRr9vr4+gBMs3aGm676qxIPe8PfRyhCYK1gl8cVkcfdC29cfENzvI1yDGMK0?=
 =?us-ascii?Q?WPfaLj68YHBqmilzqt5tjqYxmpoY3+KhEFm+vkI+zIF/qN8jSpImkc5Aigm7?=
 =?us-ascii?Q?K5qtRZ3/9IMEkbSKb0HlOcgPm/8kvrdwnsfV83klXWUP67uWyvnSn+HLWD16?=
 =?us-ascii?Q?UV/9PYqckrUrbeeXPuEISYS/R4qakg4rtmqaIVNCqXNua3jU6k/8BxC7ldJX?=
 =?us-ascii?Q?62Qf8QVOkeLHj/NWdqxujWVXGgyJVvcCSL6rmVCsurAGUTisyk9ZNbqxc0/B?=
 =?us-ascii?Q?nUSAuX0oLRwwaET1g+Y08oMfbx4ZgJKy0+NjjtNvlEvcXo1JRjHhaSYmuWUN?=
 =?us-ascii?Q?Y5Gtz3VFK3bnH5XZx0mlWJsDsppmynnnLOPp++WhqD6R3dNsZHoUv+wVbFFS?=
 =?us-ascii?Q?SN5wZihkR8RWzIe8uenA+yM4+kKT0UAebKXbozfBsabpk+Km7njndlUj/4/Y?=
 =?us-ascii?Q?FRFDBn1AV+Do5ygIolz2qg/5Op3ZKDTRIP2Agc/V3HPV1JWEcksrpi9OThU+?=
 =?us-ascii?Q?X7mtK+OXB8WtRWhH17nRH8JQlVwMiOqXx97jnozsnjoQmL5We/rBaNVjDrDO?=
 =?us-ascii?Q?QkjiFMd4c6alyTgi0AxsDUhFD48CPSfmXPxXHLl76/ofqKtIPS79ph/yyvFM?=
 =?us-ascii?Q?kfB7dLxoTjk3s/ihIzWKs8BVGWpb7REXIHfG+btugAUdNdS3svEd9i0sdz+P?=
 =?us-ascii?Q?eIa48wivP5E+/xA7rjIBCou4QH0AMVN9YeI6nW9nHEPnDpKrHViqv9Xq2Pj5?=
 =?us-ascii?Q?uCTGP9fV+g0CjVzgt/IYkob8ef9UpNgOuyESC+qvIUe4iFA1JF1mtI1c9Lfw?=
 =?us-ascii?Q?Vo4wJhqIrYZTEn4LgwBQkbZZy3UpMXtC+UWk/vJA0kUxuj35ROcA+V7Hz1Gp?=
 =?us-ascii?Q?larude26mtsSe61YkpCZTtIJeiWpADxxoimtskonQJSAlDFDlKEszljgulPq?=
 =?us-ascii?Q?PUDbozLLcIlcf/o4f6xy0kBigvx5D+wDB2kIxKFYmsCQrDMuLlRPbgaGqF9j?=
 =?us-ascii?Q?gG0BSR2kgcvyfS5JlwN8hoAqj681pf3QOc+nRz1VEmuwutXZOgrMvADMxrR3?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8392F466C631E247B6D3736220BE5220@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sIZglHC60RneNAUMmVZe7CJD7e0Nt6MI0TttiLH5o8D5J09iWhWxN2E02O6w13dOR0ogQHA2cMDT+KtEwet8iM/VvKyyQudYrUask5DQnLUWCzWSmFS/kcyKT/cBOLa+qApwMXfNxt1avr9ob8bOuxOj5iE0MoFjC0QN9hKUld6HO896RWYof+n06X/BJ+a2Oxb8yLC9kodMV8wxTZmaxZU2AfYCHJigeIDKJdttmnzyusrjJ5kX90NLZ0DJyflsPTfmMVyxZVtD9qJawzh15btfJT/zKwkqtvexjrJ3wsi/3uk2z2PEAhU9jQ3A+UpqIElbptB9YWVm5B3Sna+duNoj1YWG5LsBhixj4rXRpNmrnk8iGUtc3mRHYrCcg2z8V+rwjtJ3pGwdZTAfPFJc2VibKuzIZlsPYKk9lyleGIGwJIebI+JIllSnLFRPkU/QQqUTXVmSYzVEa0+xBiE0bPv1pHmuQdO4kn/BNidapKrNTgsJY4mexhRez31a1edo13Deb2FbFqwqjnXT/RbYk+zoDrlmF/OsAsL3taUB3ZUFoPOjHbBlmcJyrKiykJZumL0Eb16eOGJey1ooZ9idYzf2Ee7OV5nBrjMKziR2ycParlFe+dm+MvZp3bxsqvOa
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d51a0db-1b70-4a37-6dd2-08dc8b3e65ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 00:18:48.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SOTRen9++mm3rhhNAdsmjUHCBjqjhGL9R2uUQy/F7A6oXkGmU8Vj1NitSsZnJjsrm4O+YhLJ/5e74frbx7Aazg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8357

On Wed, Jun 12, 2024 at 09:51:29PM GMT, David Sterba wrote:
> On Tue, Jun 11, 2024 at 06:05:52PM +0900, Naohiro Aota wrote:
> > When creating a new block group, it calls btrfs_fadd_new_free_space() t=
o
> > add the entire block group range into the free space
> > accounting. __btrfs_add_free_space_zoned() checks if size =3D=3D
> > block_group->length to detect the initial free space adding, and procee=
d
> > that case properly.
> >=20
> > However, if the zone_capacity =3D=3D zone_size and the over-write speed=
 is fast
> > enough, the entire zone can be over-written within one transaction. Tha=
t
> > confuses __btrfs_add_free_space_zoned() to handle it as an initial free
> > space accounting. As a result, that block group becomes a strange state=
: 0
> > used bytes, 0 zone_unusable bytes, but alloc_offset =3D=3D zone_capacit=
y (no
> > allocation anymore).
> >=20
> > The initial free space accounting can properly be checked by checking
> > alloc_offset too.
> >=20
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > Fixes: 98173255bddd ("btrfs: zoned: calculate free space from zone capa=
city")
> > CC: stable@vger.kernel.org # 6.1+
> > ---
> >  fs/btrfs/free-space-cache.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c
> > index fcfc1b62e762..72e60764d1ea 100644
> > --- a/fs/btrfs/free-space-cache.c
> > +++ b/fs/btrfs/free-space-cache.c
> > @@ -2697,7 +2697,7 @@ static int __btrfs_add_free_space_zoned(struct bt=
rfs_block_group *block_group,
> >  	u64 offset =3D bytenr - block_group->start;
> >  	u64 to_free, to_unusable;
> >  	int bg_reclaim_threshold =3D 0;
> > -	bool initial =3D (size =3D=3D block_group->length);
> > +	bool initial =3D (size =3D=3D block_group->length) && block_group->al=
loc_offset =3D=3D 0;
>=20
> I'm not recommending to use compound conditions in the initializer block
> as it can hide some important detail, but in this case it's both related
> to the block group and still related to the variable name. Please put
> the pair of ( ) to the whole expression.
>=20
> Reviewed-by: David Sterba <dsterba@suse.com>

Sure. You mean like this?

bool initial =3D ((size =3D=3D block_group->length) && (block_group->alloc_=
offset =3D=3D 0));=

