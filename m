Return-Path: <linux-btrfs+bounces-16610-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E45B41719
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 09:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04001BA04AA
	for <lists+linux-btrfs@lfdr.de>; Wed,  3 Sep 2025 07:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7FE4204E;
	Wed,  3 Sep 2025 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qDODlHP4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hNzec6co"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6E4261B75
	for <linux-btrfs@vger.kernel.org>; Wed,  3 Sep 2025 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756885545; cv=fail; b=BePqSBqrsvG6hLjxQbJtjg6nXmbCIEoyLErh1MIxuSTsALs99fyqxB6i6aN2iudEKTW/9hlP2B+fbnKDel8acZFQ1qaiXeMOFxG3IYNLr6Q0tmivpg++/DcarvaBSn1bmR51HmFA8nBgACLI5YPuvo1audDze2tqHK1xxaMBsDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756885545; c=relaxed/simple;
	bh=JZC5Z/OEcMVn7h6jY+wD2VaXM/EVn1DacyuX67HhFZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AHP5Ki41S4gwcJa56e6y+R8tMHdEy/Thv5mc4M53DzJZFd1CIC+YzbwTPQUeKNtRiaqrDighwCWo4iEf1MdUquLFExp0/1nnYSIv95aWstxJ+uIBq9N2tvTWGhLrwOukaCXHNyojfIQdHVCDObTJT3h6eRLcuzcpw9yIY8zDTOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qDODlHP4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hNzec6co; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1756885544; x=1788421544;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JZC5Z/OEcMVn7h6jY+wD2VaXM/EVn1DacyuX67HhFZY=;
  b=qDODlHP4pKMmvCobo95CqruKTxWQgzBwFWM93vQ6sDovTZ//VzRk+uJ3
   ZfNiJFQpXf0XEcxIkp3K3tdWUXIsrp7Ooo29qCfHSDB7TUzeoQJX5C2qJ
   0Vcd5clugqd72sejUZ+lO69qyq8VKcMvXP2DSbAWe/YBfPQs7W7unmuiR
   qxq0NnIJFZBrb5cPWHaSbjWiq5OS3oyvirqokzK/angOfGWF2WXXMK3pY
   5p5bXVjfgU6F8vOlcwEzSdm7QO7XJwr6B8aItqkLbzLtyR73crwWirn6F
   MLBjxAg2RkCVcU9oSJM6aLzjr0DHIkVvrbvZZPbcklGYXn/nw3SiRUZFP
   A==;
X-CSE-ConnectionGUID: BgSCpEuLTUes64vq5C9reA==
X-CSE-MsgGUID: XU1P/gd5QjK5f4bNvyZ6cQ==
X-IronPort-AV: E=Sophos;i="6.18,233,1751212800"; 
   d="scan'208";a="107514157"
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([40.107.237.67])
  by ob1.hgst.iphmx.com with ESMTP; 03 Sep 2025 15:45:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQti5r2gy0FN5uM7c7V0cvyYPw6PlcPgENV7afBFenXRclCXHph9dCJF6CbIgtxOmtExKWbUdBpc/hod9Xl60WqvF61wHmemYhnsyMqvhVxCitr3G2/9OSA+x5k5JTqyqcq9z2h4yUgfJp70OeNFi1u/tnHm7Z0+Z0+Fp1gKXESU7DQ9sHyQ1ZS/P++Cdvm7nWqiBS5vvF9FT+FY00DEX9FJNHUajmrfw8vlX6n0sLo90o9LpkHNJYOm8INhEI+a48A1WzQZJYJ+4aYbvpBCrNe38wPkYVayH1X5acV005cf1Cx1aZlvKC/7p1Y7zoBMcQ1fxoOeivi++D/NyroAkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZC5Z/OEcMVn7h6jY+wD2VaXM/EVn1DacyuX67HhFZY=;
 b=Dnxm7PJUqB+ZtDH3n+hKXbpz1I5sXaDC4kaAg+synTQM0yVwpvMPyFolx0AIfwbXumUZvG8vRZuXMYDu/tA+60CKSZWZLu//AKuB/S0SSaZaaCVmaIeP52BIKxf7AXfraxTVZWhLs0u4zYWU9Refqwf0PDs1pCSq39XCE7Es1e/spJ1F4jddo3H7TBdxLvxMolegpiaGnVhjDsdflPDGLhbqbu4piNupIKoLB7bpvlEUjjgFhYW7AhFCwDEGrAr9IIeqO3Gkbpa+szfpJTf3Yk8bVELlxiX+lZWd+aLEFQNmXKr6+MfQAP0ZnS+0w9a6j8izqk6yxfc/woxM3mAgzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZC5Z/OEcMVn7h6jY+wD2VaXM/EVn1DacyuX67HhFZY=;
 b=hNzec6coqs6+9JntDijeXWxiRQw3DFK6kYmqagCWrupxbLNZk1ZrIbIHzjJdhJypsfrvD/23GRlM3MifYQm93/R/5hoFetMVZ88b2x5zZPO0HDvCMkaA31HnFsSXDcldMMydEcs241QlRogeWt+LpfN0/9FQCNnqO9JobErOIEY=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SN7PR04MB8695.namprd04.prod.outlook.com (2603:10b6:806:2e8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 07:45:41 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 07:45:40 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs-progs: tests: add new mkfs test for zoned
 device
Thread-Topic: [PATCH 3/3] btrfs-progs: tests: add new mkfs test for zoned
 device
Thread-Index: AQHcG8JLW1LArBL5L0KYZ/kdwV3wx7R/qPwAgACWfICAANaAAA==
Date: Wed, 3 Sep 2025 07:45:40 +0000
Message-ID: <DCIZY33HXU8F.21VMNI2HL600I@wdc.com>
References: <20250902042920.4039355-1-naohiro.aota@wdc.com>
 <20250902042920.4039355-4-naohiro.aota@wdc.com>
 <381793b8-e35a-4b4d-965f-8f78cdcde8a3@wdc.com>
 <20250902185757.GJ5333@twin.jikos.cz>
In-Reply-To: <20250902185757.GJ5333@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SN7PR04MB8695:EE_
x-ms-office365-filtering-correlation-id: 63d724ee-7679-488e-1a0e-08ddeabde170
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NThRQk1Ydi9FcHdwODUycjRBTlA3ZGphY1B2a0tLdHpaWnRJMmlFQmNZR1BC?=
 =?utf-8?B?UXFLSEl3RlphNnFBb0wySkRQbDdnQXFUTkQ4cm54dWVPcE9qVzZ5bi83MTUz?=
 =?utf-8?B?czZ4dFB4YS81RDZOS01JOFJNZDBGUUpEY2R3MHoweXlLZGZkRXg1OTlyekVa?=
 =?utf-8?B?UTEzWXRTeUdGamE3QUNkWlNiSmxaZlNlMFVQSlhuYWd3OWpMZzF1NGtBQnBI?=
 =?utf-8?B?dm1Zb3NZQmRGaEFDQVRjb3JIeS82dC9RM3lhWkVaR28xc0ZhckhVdi9ORVRu?=
 =?utf-8?B?N3ZUdXJTWkxTaEpRTnhqQ1BIQVNFcUU1dWxMRDBUME5xVTcyUEx1bE12TEhZ?=
 =?utf-8?B?MXBhcWY1eDIvcDFiRCtWSjNEV0kvVHZROGVyTnl3UWhTeU9OcGEyKy9mcmxk?=
 =?utf-8?B?TFV0U2Y1ZkdNMFFYQWY0b3AwZldYNDRwNmM1enlydkpaNGw3MDIzRzBpWlJJ?=
 =?utf-8?B?ZUNsd2dUTEdIMXVoYUJmTWhjMzJmZk9VZ1BCOFVyVW1hUHpGbTRJdEI3RHI1?=
 =?utf-8?B?aTFMc0lNZjRzYWlNcHJkMzJPU0E0d2x1enZtSG96N1F4cG5PN3BpL0JTK0k2?=
 =?utf-8?B?QXM4aDI3QlhRTmE4TnM0dy9hNGluckE2U0prUG9kNmhwU0tEcXRZdTF5M1Nv?=
 =?utf-8?B?enk1U1FFOEYzM29sMWcyRG1UY3FYNmxOb3pqQldrOWMzbndtRERHUnV2OGJH?=
 =?utf-8?B?MmhoeFpyWUZyVWtPRXZpV0Q1ZStkNWZOV2R1MkZKVVRUa2pGbWNDY3dXU3do?=
 =?utf-8?B?bGdDSWpFTGwxTkpiWjJLcHoyMzNNcHBMYllBVnlxWXN5NEpITjdJdmlqb3Zh?=
 =?utf-8?B?YlF1bURTdDVla29oQnFCMXlzeWNwTTc4OEl4TmhNbHN0RzlKNHpEcFJiM3hD?=
 =?utf-8?B?cXFQUWdqbmxKOXBLYjhFN1dCQkhZTFNacUdpajZJbDZCUTdZektEQzJKR0FM?=
 =?utf-8?B?cjVuSWthc2tyNWM1d2tqNEpSUzJYWEZySVprb3N3ZWNoaWl1MjhIT3l4NThn?=
 =?utf-8?B?aWFuVi9LL1BFZzNvNDVWb0pkbDVEcHg4MzZzVUZoZ2VsSkFVQzVTN1p1bU44?=
 =?utf-8?B?bzYrMHY1SFE4aE5kRXF1emVWVHFLQ1BCMFE4czZCcG1QUkZ2MmtBUktERDd5?=
 =?utf-8?B?cUpFdXVLUGM3MEM3TzNRVTRmTENIN3g2S2d6aVY1L1RNeFJOQlZyUDFOVVQw?=
 =?utf-8?B?QmZTWTFXSWE2TWFicCtIY0RUekpIOTE5eTNZcVhFTkxPSm1LSk9uem5tRXlL?=
 =?utf-8?B?TEp0YkJZUkNubnVkYk9FZndKQjdEVERpenE1Y2JRUG1pMlhYcDRWOW9HWUxr?=
 =?utf-8?B?TVJiUWtLUlAxVU1zZjBDeWlod0Y5b2MrMFFqZkdoZEpzWGJiRjVuTGFVNDE5?=
 =?utf-8?B?UWdZeHBXLzBkYmU2V0RXR0NXcWhQQytpYzUzMXg3ZEF1RUJCL3ZmeUoyVkIx?=
 =?utf-8?B?Z2UrREVldmpwU01NRi8xQjExMERnR0p6bStPOXQzdzdMZFBhaEwvWEZtL1dN?=
 =?utf-8?B?RGU5RmJtR2RaNElBYWI2K2tIcDBMRnNSTFlsS1d3S3hyOTE4R1FkQ2g2MC9p?=
 =?utf-8?B?SlYxNjRWajVGMlJMeEt5WlhjcGszbjNSalU1ZSt6Q3dsVGxTWUFNVEJyZ05C?=
 =?utf-8?B?UEdXYVRoNEpDWC80VmllekJCY3RVbFVEVVRFUkV5Mnd6MXdXT0hyV1pHNWlM?=
 =?utf-8?B?VGl2MWxiUlNRRG5nOFQ1aTVVQXdlU0hNYi9FQWtiWk1aQ3NvVUdWUHpxUmhw?=
 =?utf-8?B?VnBzRHZvL0IydXVkUmcwc25sMGp3YjAwN2RBSUozNWhXa2xvMWR3eGFEd2Iv?=
 =?utf-8?B?VjdCVi9ld21SLy9iV0FJcCtZUmRxTXZoQXFxK0xCQ0RoUXQyZ0NLUnljV2Z3?=
 =?utf-8?B?ZmxLMjUybEFNMkZqUTVyTG1qS0lYM0NZV3dYQkNUem1TTzFzVUIyNm1aajlm?=
 =?utf-8?B?MW1yMW40YU84cUdhcU1MeUlnbnZTcXNHTVJsci9UWm1LTmNyR3F0eWZ6TGFs?=
 =?utf-8?Q?GFjZs5Is9jRNSgQs1dRFf0KQ1kB7Rw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZU0yaGduYlhXSVB5UlRLd1lYemswSFphRFVvYlZ1eTczTU5ScEg4UGRTbW9C?=
 =?utf-8?B?UTd1amxxNEhXdFRMZ1hzaXgxdkJaaGtYb3lZVlZOQnVrS3pDVGRHODRRTlNM?=
 =?utf-8?B?ZkgvSU82MlhxKy9zYVZNS3Z3MkZDalJZQXNFVWEzOHNjV3JsM29UeDFNdm45?=
 =?utf-8?B?dmdDb3pKY20yL3hSWWsvck1CRkdzY2E2UVFDVU5oUlJOZ2lGV3BRTy9JZVZO?=
 =?utf-8?B?eWdqanBpWGdQNjV4VmJGeE1zMG03RVNDTjBHODZKMlovNnpXbTF2ODBsbGJa?=
 =?utf-8?B?WVJUOUhJbWNLOWQ5QUVhTFMvcGpqdWZIRHBjYmhSdldxckpuRXFsV0d6TmRZ?=
 =?utf-8?B?c0JESnd2OHBFbDZBQWd2WDV3L25QckFmK3dUYmpuS2t6K1BtS09QWU9USVI2?=
 =?utf-8?B?dGVEeVpYb3VvcDF6Wk5NcnhySkJkOUlVV1FmNFFkTlZ4YzFTamJVTnc3OUVR?=
 =?utf-8?B?UWlJNDJtbnk0KzY5RUNrN3dyeTE5U1VVVVhZeDZIUFJzTU5yd1FuaWRRWjQx?=
 =?utf-8?B?aEFMRmVhaE9hakRHc1FiUFRqeFQ5b1JYMW5FcUQrcTZxYTNpL2Y0ekdvOFVW?=
 =?utf-8?B?ajd6MHhvZEQyUFpPWE1MUmpweVdSclp2dHBEOCtmVUJNd0tjdlFuQkF5UFBD?=
 =?utf-8?B?ZXorVCt5dXJvOC9XOU5XQ2JWdHJuU1hWSW1wOUdkNWtKQkZwRllRM0l2MjBC?=
 =?utf-8?B?dVFHczk5Z01sdC9EY05aRndvZnN5TDFFN1lCd3VxN3FoWWZ1THhHM3FKZXF4?=
 =?utf-8?B?U2JmREZSZkozMjZLTWlmL1RabHV6YkM5WGNVaWFlWlZIRWxKRElHUHFtbE9Q?=
 =?utf-8?B?SWRUeW52bTVPa1NsbUNPemhGcWF5Y01KQ0E0dTlKRHVJSGFzLzJiY3hvb3Mx?=
 =?utf-8?B?MGVVZkFIMGppWFduRUVYR3B6bkM4UFo1aUN3azl6SkNIQ3ROaE9icUpnU3dx?=
 =?utf-8?B?b1VCWjBKdzQ4bmVFMTNmYXdaSUdvOHFjRGdFbnpRYVNSZzVMR0pUaTBOdmR3?=
 =?utf-8?B?MWhENndEUWQ5SVlrQ2dKU0R3Ukd4ZHV5OEVmNUdUS1NMcjNFazZ0aHJIYUQ4?=
 =?utf-8?B?Uk5CUjBRMkU2M2hmdldhRnVhVHRXTFI5YVhEekVGNm1aQnR6RjkxeU1YeHJR?=
 =?utf-8?B?UGhmRnMrb05kQ1h0NGk4dzhuY0tmUXJBbU5wTHlEQStCVnZiaUFYSjZIQlVs?=
 =?utf-8?B?VlpjQ05UZzBBcUthUTVKV0JmWTdHTHJaKzRiS1pkQ1hYY05tQWI0OC9ldjNx?=
 =?utf-8?B?WU9Uby9taWc3ME1OSzFlZ2J4dVJDNDJvZlZZRGxIVldCOTZxbUp3cWVWMFhX?=
 =?utf-8?B?OXVhZ2lBNTJzOXJsTjlPS09mTlVpclJ1aGNLT2xlSkE5eThCRE9NeEVxdStt?=
 =?utf-8?B?L1R4YnJKcWdLSXByK3VCdkpwbjdkKzJPRVo0T1lVam5Bd3dYM0JUMGo1Q0Zy?=
 =?utf-8?B?ajF2djFyekpnYTlKdzlWdTdLRUtpQ0poQVZ6dGpRNTdVSHdjY0lYWjlNaW96?=
 =?utf-8?B?K0tsNEt1MHE4QmREUW1QQ0MxM1E2WVJlNG5IeFlkek4yem1KWmtHemlyRTk1?=
 =?utf-8?B?NGlNa3EzZWtjcVpIR3dYZ3RhcngyWjJ2SnMzdHRxbmhLMGRXai9jK3J0WnV0?=
 =?utf-8?B?ZjNEQ1pFUm05cG1qYUgxclVCdEdGY1ZBMmR5em1UemQxajBvVGhQL1JqQ3RJ?=
 =?utf-8?B?WU5xU2wrajVjb3BFRU1CTVhYYVd2Njkrc0lkNXpoTjBqcS9pOHBnVHlMOWFl?=
 =?utf-8?B?dUpucUNTcWd6K1FvdW1xUnY1S3pEdmpaTGdOZkJJazMxSk9TMzh0OVBZNElE?=
 =?utf-8?B?UmVBd3ZaN1BhWjE4RHlBbGhTWFVobk9McDliQm5BMll4MkRRZTgydGEyUGFH?=
 =?utf-8?B?SThwbnZBV0RadmUyMkxFSHJlQTNPTFc0RWhJV1I4Nm56VGM4Ryt4VXJqNExB?=
 =?utf-8?B?T1UrRlUwVTlJaTlTT2pLcVczdWxXMGdWMTlVcjBhc1FGUndHK3NNc2ZRYlBj?=
 =?utf-8?B?VkptSGxyN0cxcy96a0FsTExDd083V29jOGxxTithU3UvazNqNmlkUjVWSGlM?=
 =?utf-8?B?WjdmOEsvbUZHNnVOYnppd2R1Szl2bkhxZk1VOU9YWldTWFo4QUtUd21wZTRQ?=
 =?utf-8?B?aGU1NnpQOURZZmJqUmlReTF5cmdiK1Z6WFIza0dDbE5NWTdmQlVXaXE1a0E0?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31B73B12CE40B742B794046652612701@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	29z5YGXheUHIaCOTrYJFH2EunDcgz20bUd91hzmacU1LqKb4bO9YVukdzFp2VDqZd9EfkYtniqfjResb+FRGG8u9tk+e9nIDU7vw21ZeX8G0zZxvE+ehH1tU+zqGQAiIeTbl2zCDqtVvkgQYT69Bd4OdtIkIxgzeImQMo2mZr3KayeAST0WfFL2qgpj1urOiNsJAnZazQWgB3MfkRCo6wjCQK9mQJI2kqNRfZv0p2d8SvTqG82zUIxQOWKSJms33nxHI9BZA+e03X7EdvdsA9eKLxZ7roWxT6olJVgJsXDZHKGK2IMalFheNQrWflbrLaFUSSsJUz6LaqFbF0xOL3AiMiH2rmDNRtGE489rhVLJkGJgXWPo4RPuQF0cnJ965pMiCUDqTz0cuS4Mxgv/gKD5q0aGzl3vxAB2DLxO6anjHjXI7Ag/wFIDc6qyrPncLXvKB1XSoGtKB71neEvLwdTyUcSiJIgwJDDJQvd+RtOgm0+HMvl9gCLx/cinoZh7d2fvo/s4sgPhKkj5m47NRESdH8x5GuLZ508wfUqhXOnfzUqPFp/uEsiCZRPxAFj4moHEV27BxE7+f7wjvAN2wiEo+d0QT0a6Xgf5JWlKlxLuvspSN2ECSBy9wpyzJC/r6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63d724ee-7679-488e-1a0e-08ddeabde170
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 07:45:40.7986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YVDtXMcLIWteNpXWN0HTbO2gVyTvrzWQogVQFiwMYtaVbwQrSNgwZ1GmyRF7BKRlL9AfN9lOFoNIPCMq+fxwbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8695

T24gV2VkIFNlcCAzLCAyMDI1IGF0IDM6NTcgQU0gSlNULCBEYXZpZCBTdGVyYmEgd3JvdGU6DQo+
IE9uIFR1ZSwgU2VwIDAyLCAyMDI1IGF0IDA5OjU5OjIwQU0gKzAwMDAsIEpvaGFubmVzIFRodW1z
aGlybiB3cm90ZToNCj4+IE9uIDkvMi8yNSA2OjMwIEFNLCBOYW9oaXJvIEFvdGEgd3JvdGU6DQo+
PiA+ICtpZiBbIC1mICIvc3lzL2ZzL2J0cmZzL2ZlYXR1cmVzL3JhaWRfc3RyaXBlX3RyZWUiIF07
IHRoZW4NCj4+ID4gKwl0ZXN0X21rZnNfc2luZ2xlICAtZCAgZHVwICAgICAtbSAgc2luZ2xlDQo+
PiA+ICsJdGVzdF9ta2ZzX3NpbmdsZSAgLWQgIGR1cCAgICAgLW0gIGR1cA0KPj4gPiArDQo+PiA+
ICsJdGVzdF9ta2ZzX211bHRpICAgLWQgIHJhaWQwICAgLW0gIHJhaWQwDQo+PiA+ICsJdGVzdF9t
a2ZzX211bHRpICAgLWQgIHJhaWQxICAgLW0gIHJhaWQxDQo+PiA+ICsJdGVzdF9ta2ZzX211bHRp
ICAgLWQgIHJhaWQxMCAgLW0gIHJhaWQxMA0KPj4gPiArCSMgUkFJRDUvNiBhcmUgbm90IHlldCBz
dXBwb3J0ZWQuDQo+PiA+ICsJIyB0ZXN0X21rZnNfbXVsdGkgICAtZCAgcmFpZDUgICAtbSAgcmFp
ZDUNCj4+ID4gKwkjIHRlc3RfbWtmc19tdWx0aSAgIC1kICByYWlkNiAgIC1tICByYWlkNg0KPj4g
PiArCXRlc3RfbWtmc19tdWx0aSAgIC1kICBkdXAgICAgIC1tICBkdXANCj4+ID4gKw0KPj4gPiAr
CWlmIFsgLWYgIi9zeXMvZnMvYnRyZnMvZmVhdHVyZXMvcmFpZDFjMzQiIF07IHRoZW4NCj4+ID4g
KwkJdGVzdF9ta2ZzX211bHRpICAgLWQgIHJhaWQxYzMgLW0gIHJhaWQxYzMNCj4+ID4gKwkJdGVz
dF9ta2ZzX211bHRpICAgLWQgIHJhaWQxYzQgLW0gIHJhaWQxYzQNCj4+ID4gKwllbHNlDQo+PiA+
ICsJCV9sb2cgInNraXAgbW91bnQgdGVzdCwgbWlzc2luZyBzdXBwb3J0IGZvciByYWlkMWMzNCIN
Cj4+ID4gKwkJdGVzdF9kb19ta2ZzIC1kIHJhaWQxYzMgLW0gcmFpZDFjMyAke251bGxiX2RldnNb
QF19DQo+PiA+ICsJCXRlc3RfZG9fbWtmcyAtZCByYWlkMWM0IC1tIHJhaWQxYzQgJHtudWxsYl9k
ZXZzW0BdfQ0KPj4gPiArCWZpDQo+PiA+ICsNCj4+ID4gKwkjIE5vbi1zdGFuZGFyZCBwcm9maWxl
L2RldmljZSBjb21iaW5hdGlvbnMNCj4+ID4gKw0KPj4gPiArCSMgU2luZ2xlIGRldmljZSByYWlk
MCwgdHdvIGRldmljZSByYWlkMTAgKHNpbXBsZSBtb3VudCB3b3JrcyBvbiBvbGRlciBrZXJuZWxz
IHRvbykNCj4+ID4gKwl0ZXN0X2RvX21rZnMgLWQgcmFpZDAgLW0gcmFpZDAgIiRkZXYxIg0KPj4g
PiArCXRlc3RfZ2V0X2luZm8NCj4+ID4gKwl0ZXN0X2RvX21rZnMgLWQgcmFpZDEwIC1tIHJhaWQx
MCAiJHtudWxsYl9kZXZzWzFdfSIgIiR7bnVsbGJfZGV2c1syXX0iDQo+PiA+ICsJdGVzdF9nZXRf
aW5mbw0KPj4gPiArZmkNCj4+IFdvdWxkbid0IHRoaXMgbmVlZCB0byBjaGVjayBpZiBta2ZzLmJ0
cmZzIHN1cHBvcnRzICItTyByYWlkLXN0cmlwZS10cmVlIiANCj4+IGFzIHdlbGw/DQo+DQo+IFRo
ZSBhc3N1bXB0aW9uIG9mIHRoZSBlbnZpcm9ubWVudCBpcyB0aGF0IGtlcm5lbCBtYXkgbm90IHN1
cHBvcnQgYWxsDQo+IGZlYXR1cmVzIHNvIHRoZXJlIGFyZSB0aGUgc3lzZnMgY2hlY2tzLiBGb3Ig
cHJvZ3MgdGhpcyBhc3N1bWVzIHRoYXQgaXQncw0KPiBlaXRoZXIgYSBnaXQgdmVyc2lvbiBvciB0
aGUgdGhlIHRlc3RzdWl0ZSB2ZXJzaW9uIG1hdGNoZXMgdGhlIGluc3RhbGxlZA0KPiBwcm9ncyB2
ZXJzaW9uLg0KPg0KPiBXZSBjb3VsZCBwb3NzaWJseSBlbmNvZGUgdGhlIGFzc3VtcHRpb25zIHNp
bWxhciB0byB3aGF0IGNoZWNrX3ByZXJlcSgpDQo+IGRvZXMgYnV0IGZvciB2ZXJzaW9uLWRlcGVu
ZGVudCBmZWF0dXJlcy4gSSdtIG5vdCBzdXJlIGlmIGl0J3Mgd29ydGgsIHNvDQo+IGZhciBub2Jv
ZHkgZWxzZSBjb21wbGFpbmVkIGJ1dCBpdCBkb2VzIG1ha2Ugc2Vuc2UgdG8gbWFrZSBpdCBtb3Jl
DQo+IHJvYnVzdC4NCg0KSSByZW1lbWJlcmVkIHRoYXQgcmFpZC1zdHJpcGUtdHJlZSBpcyBzdGls
bCBvbmx5IGF2YWlsYWJsZSB3aXRoIHRoZQ0KRVhQRVJJTUVOVEFMIGNvbmZpZy4gSSdsbCBhZGQg
Il90ZXN0X2NvbmZpZyBFWFBFUklNRU5UQUwiIGZvciB0aGlzIHBhcnQu

