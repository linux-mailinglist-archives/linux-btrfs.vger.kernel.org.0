Return-Path: <linux-btrfs+bounces-5637-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BFA0903296
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 08:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BC4B27F8C
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 06:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA80171662;
	Tue, 11 Jun 2024 06:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eVrWQGp4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b5WD5E+/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1610B6116;
	Tue, 11 Jun 2024 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087251; cv=fail; b=sEfWA0qh3PHWgk/240uB5k5bL33wvKEY3qpLVVW+e+3PVEH4TfL/itekAyvwCwQ+f7O/heqcIrAichVvKtUnCsnVQdcgf8JfnJYkh06ULANDSyKg5cYXUDQwiWWaG/PhsJa5vzPA4f+0DyWTb+806mdgGL5Rn/mY6AlDDQPjf3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087251; c=relaxed/simple;
	bh=HW5BdImB4+vsJqa4kELKLATfe5Anb/LARcyZPv0V46o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OB+C/AZXeC49r/aBJMgJVhNBVCYfniliPS7bbCfT8i3M2dLT7Wj7QMvnH5RmWhx8hfrtqz+SMsHEfUUqBW48IPasPWkJkOk0JWLjFbVvrbPkXFFZv/dapcGFKX+mjvpb8fpH5ZVJXB/ET77B2SCBPBVBGqQNFfsiSc0jjAoo3jw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=eVrWQGp4; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=b5WD5E+/; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718087250; x=1749623250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HW5BdImB4+vsJqa4kELKLATfe5Anb/LARcyZPv0V46o=;
  b=eVrWQGp4gl5R7Hjp/VQ06QWFVhQtI2xFnlznzFIscz0zLzdZlcB3GmQk
   gwMR+w+9XkuHqiERu0bh4XM0LV/nDO7PMO4NORKMei3vpVcAPqif3mLIX
   fFKcd5XhHk/I0CjdyqzOgkRlVtwJLiSLBbiXMloHeY0OsTOgWw4QGc5DJ
   vJIw50L26sFDzKG+NdLd2vbBkGCC4X1sZAhuARc0o3TTgAbFQ/9u8p9Es
   YlmdPtCgitNO+fQOUUprmxliH54mfcMZaEsbQX0+fkhHPV48ga0oRN8Y2
   pB8o+c4LQhakYF+nEuuG1Ctx5isrEBEwW9v7beB+A9k9jrvGKqEaZSUZ3
   Q==;
X-CSE-ConnectionGUID: ptjvJf0YQVyaQkZ5jnh1rg==
X-CSE-MsgGUID: IiapnHz8QJeNoxk7+3dt2Q==
X-IronPort-AV: E=Sophos;i="6.08,229,1712592000"; 
   d="scan'208";a="18044300"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2024 14:27:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPm1LMJcm3pL8yiq0sTfd/6k8AaGuNNsuuf36uuAhLqg9DestzgXVNoLXP6EdEvsc0CNTssFU/aitC57pDnyFAbzGD/ocO7ZeAruF4idmIfTQUDMRNHPGPBOSz+L4klH7Xi1yCs4l0P2k3cr5aWPMtnJ0XXUqMgEQRVlIxGxHg/6S1AxLCUGDjDWkl5Nk8rMYWMmQD6WMnCxIwZQ7aB2uU5lN5MRxx2yc2/J7V8YDcpClA9SzSBdZg0UyHl8bSNoa9w4WgU9W55giaVOpzEVotkWsaLBSha2GW0CyMdqx8qzIVj075842SN0Gf2ROqC8X5mHQ4aOt1bVWdl3Fe+Ulg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HW5BdImB4+vsJqa4kELKLATfe5Anb/LARcyZPv0V46o=;
 b=id0s4IoMBedyJapzxzxelHCEugHDoPHne0SQiWgsIxDCVI+z76q9KYMwPu9o2anzQFF1ZlR3kE/cqmC5+jxCDTJ6fapDBMfZxR/Yf9lN5GsBT8tcj4HQGioSlXgisZdWM4RlBXj1kk37U1bWBHCKuRLFey5c9K79ZzOytqtYG9Lv4wok4zdxEt8uIX76sPPGjkO4zLiPXGV1hFmbkDo6dfduVN4J63DqS0rRNBAMEbspEXf9ssqJzhEDkYkFynJziDHKG/fGhDDNBpLHZcaOz1oYRuWu0vmqNcOMTi9IDE4jCuJYyavVjfknZMC9lxHd5S+vY8N0gfPmk0fzUm4phQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HW5BdImB4+vsJqa4kELKLATfe5Anb/LARcyZPv0V46o=;
 b=b5WD5E+/qBWEpPtWOiGnckoXfBLCFQrt7D3TvryRaXr4GBGH/xF+myBSIZVDTBh2irQ5hvuJpFWmbEBjkOuqJhIbC+KEFYU1EhxjP1cFTg3+4DGcoSUVE76HMsmRuNococokqEZ6k9ATduG+v+eYeKKq7u1rZEHzxB7Mb6b/m6M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6746.namprd04.prod.outlook.com (2603:10b6:5:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 06:27:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 06:27:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] btrfs: replace stripe extents
Thread-Topic: [PATCH 2/3] btrfs: replace stripe extents
Thread-Index: AQHauxHfVBemePVEaEukJ5rE+eVylrHBZucAgACzyYA=
Date: Tue, 11 Jun 2024 06:27:21 +0000
Message-ID: <a70a9adc-b3c9-4d21-b282-a0bf565d6c6a@wdc.com>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-2-179c1eec08f2@kernel.org>
 <20240610194352.GB235772@perftesting>
In-Reply-To: <20240610194352.GB235772@perftesting>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6746:EE_
x-ms-office365-filtering-correlation-id: 173cfc80-5101-44b0-4a1c-08dc89df8cff
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eTRpVGt5T2VtUlY3ZFlodHhlUkNyK1ZmU2JRWWorNkQzTkI4OVZobDlUeTFC?=
 =?utf-8?B?STZtTWJheGJNTmx6Z0wvNUdHZ3QvSElZb2l5bkdIOGZHdk5pVEFZVlVaVzcz?=
 =?utf-8?B?c1BOYXFlc25ySmxlODYyYVMzVXQvS2duV2FTRlloVmVPYjdSQXFobUhHYzRJ?=
 =?utf-8?B?VFBFZVZjK2xoOVRCdm1mOGJRdG85YVU1RXh2NHVkZW1QUWthSGZ0UjVWL0tO?=
 =?utf-8?B?c080a0JvWklVa2ZpdXF4M0EycTBrcS9xUUlTSkhjanRlYzlQWEZDeU5iRWVk?=
 =?utf-8?B?TUJ4aWcxeW9TWCs0TzkzSnFjZ3hmRzBzSVJJV1BCQXhVUFpLdktBZlNpWll3?=
 =?utf-8?B?UFJlMEJucG5MMmxSUis4eUo2cWk1V2pIN1RIWWMvSUJtb24ydjdSbHR6VDE5?=
 =?utf-8?B?eDdYbGZEUjJFRlRZSkRMWXlDWTJyN3VYRHM0UmRqZlZKQkhGZG9hbUJoMVla?=
 =?utf-8?B?WDJlTyt2djhTTmVTTnZCb2RGN2R0bmRkN2s3c0Joc1ZjdW5RcHJSS0NSQWJN?=
 =?utf-8?B?ODRyeUZUcWdSczRkUUQ0ZkROQm84RFZrLzlRWlFzOXZ6RSszd2ZFc09SY0Iv?=
 =?utf-8?B?Z0VRMzBJaWxyWVErOEsyL2JrQzBHeXhrT3VlbnJ1cGE5eUk0c2VGemtyaVA0?=
 =?utf-8?B?MzhyM2lKZGNHU01ZQXV1RXg0cjltbEhmamZXaVVrQWpiVzN1Q2dJckM3WVpr?=
 =?utf-8?B?anJnRzZLeUZHeGZ3dEZZL1hKMDMyelBWQTUrZWppeHhqTEZCeE9SUzJmT05M?=
 =?utf-8?B?OTFFMlEzU3I0QVFLYm1wbDBXRmJISncwYmV0d2I5NC8zMkUyNmo0c3BQZlJ5?=
 =?utf-8?B?U2ZOU2NmeHJ6dmFwV2VNS2lNaThGQXEyTUUxL2RqSkJvZzV0c0lyY1F5MXdN?=
 =?utf-8?B?OWFYVEZPN3grZm5IQmRTTTR2eEczS2I5VEdZYWYrUzdEbi9Ic0VNL1RJQXlD?=
 =?utf-8?B?alFRbCs5R2xraHlaMXhvUmVqWFF6S2xyUmMzQm9DaHVpR0swd2VuU1pBVFQ2?=
 =?utf-8?B?VG5NVC9Dc3hCRDA1dXZoZ3dOOXlhOVVCaDJwcG4wRkJ2NVlzSW5RVVV1T3Fw?=
 =?utf-8?B?V1lEci9hN2NnRUJOVEJaTU1ZZ29jaXV2ajFJOHJ4RGhibDdFdnBjemZ0Lzcw?=
 =?utf-8?B?SFRDNDl3Z2EvUk5ZVWFtTlU5eFBUWE5EZzl6TUljUjlRcG5kK0VjQ2RVNThN?=
 =?utf-8?B?akV3dFM0dzZGaHV3d2I1eldrekVnMHBQKzFVdFp2QWU2SEZTSm9Wbm1zaXd4?=
 =?utf-8?B?MlFPUjQzTEYyZm1JLzhJTzBaUFJFUjBOVU5oN3R5ZDdFR0l6K0FEOEROanFu?=
 =?utf-8?B?djdBM04vMEY3cU5WQ1ZTYzNKalBXR0REeEthNTVNemJCbUxQaExlSnVSY01w?=
 =?utf-8?B?TWkwc1lSNUJ0T3daa25YaDdtN3R1Qk1kUmtBNHJCa3drcU9VU0lPWU9uWlgv?=
 =?utf-8?B?VUl3bTYyOEgyZ2VubmZ5Mm9Va01ELzN5dVVnczdaVTF2KzFyQXN1dkxxSFpM?=
 =?utf-8?B?T0g1SkNFNDJiUGFmd0NWdURPQmx3TVVQQXpKa0xEa3FBOXFYbVNHMVIwY1Y2?=
 =?utf-8?B?dGNtZkg0K1dOS2hST1p5cG1nZ3p5bWNwd0JTY3R2YjhoVUFlTWpxOGhZcVhB?=
 =?utf-8?B?eDIrVHJzQ3BXTnVvMi9ndUQ3b2dLV3pKSjVRc29aWWJoWXRzQ3hNVWdzRXcw?=
 =?utf-8?B?Z2xWTUhRc3ZaVm51MEliRUNrSEw1eHp1cXdXeTJJeVhoaThQQktKQmxKSTFC?=
 =?utf-8?B?UThxMmNwYXozRXpvb210WDAxMmR5TXNZZTlHN2NwNG1VNGp4RjNPa3pHc2N0?=
 =?utf-8?Q?lzt37EkV5NHoEZDll9TeQX9blw5NE8ic9AaUU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2VBbnBqY2FDQmI2OEl2QzZTa09lTmllNDJGQTc0WnFQZHB5SFlKTjgvclh1?=
 =?utf-8?B?SC82S09jb0UrUThUbG1oUTVXcjQ4SktYKzRwQ2RHMEE2NzlocHg5VFZ5Yyta?=
 =?utf-8?B?MVNBeStHcWk5d1k3MW9LV2FsN0h3MGhsOEdERldSUThuSUNQZFpJdVZobGZU?=
 =?utf-8?B?WWxwVURsYXdYUU82eHU1dUIxUjhGbS9MOUNMNW83YW1Ycmwzb0RaZGthTEoy?=
 =?utf-8?B?RXJaRWhjRStES09IV3VpS1pXV3hGNXlpSmsyU0FIclVlWGd1czdVcVBTRHhX?=
 =?utf-8?B?WEZwR1pqNFVZN1RrOWRla05va3p4V253TmVURDE4eFJIeHVyVWtvVEJQdnk3?=
 =?utf-8?B?N0ZLak5JRGJSSGxLeGxnUWVVWUx6ZUJtM2o1TzViQlpkWTMxcWs1MUgzR0JE?=
 =?utf-8?B?QUlLUXk4c3VnVGJWZDhwbkJSQ0JGOHByNnNJTVowVG9TNndIbysyQ1N6cVJk?=
 =?utf-8?B?UmFGSTFaUWl6Y1hGSDJGcDJlSWJ6R2tYeDFsdWtFSVF6aDZPbWQxT1YycnVh?=
 =?utf-8?B?Z3ArR0tXMnlUVWE1QVM2V0duZkxpaFcwQSt5bmlqZ0hTNkgwUmJZaVYxWFdj?=
 =?utf-8?B?RXBhSjZUb0hwMkpReWp2ZTEzd2tOdkx5T3R1SFFDOENNQzFKdjZSVHNRbjJj?=
 =?utf-8?B?bzBMSm9mdVYrUkV4dzhuV3RJRFpmeG5xY3hGYjRRU1U5Q3F4djVtN0thN1k0?=
 =?utf-8?B?QXMyTXRGNC82SHZ6c01PU0dINFpWeEVhMlZiYzFENzZFNkhYMzVPWnJKRE1Q?=
 =?utf-8?B?Smt4MlpEZlVGeTFxMDl2aFByS3JXVDRwdGx6U2NHREJlREJhSXQzRlFQUzBK?=
 =?utf-8?B?L3A4YVE1M0pjeUdJSXVYaWNvYTgzdTUwbEtUWFA4QUFOdDJWZUV6cUNJV3Uy?=
 =?utf-8?B?NUVWL0Q0cndMSTlZdmtJRGw5NldPYzU3dlBhZCtWOFIzNWM3czYvUEo0NEZw?=
 =?utf-8?B?SHlmRWZIKzM0cGFHUlBkK1lKUTA5KzVUUDFRaGh6VmgyY2M1YU5ha0lJRlRv?=
 =?utf-8?B?QlRhZHhtbUJtaStDTXFFNE5SU2o0cml4ODQ1c0dZVVpkajg2YlRseVRJWmEx?=
 =?utf-8?B?ZEU3azNzdHR1empiL0JNUVY4S0JLYjkrSnpnL2FpRmI3d1ZuQXhrellXVFla?=
 =?utf-8?B?ZS9Lcy9LTzhuSWtQZ1J1M2F2UTVqbU1IM3ZYMzR1bjUyc1U4RUhsQUlGOHRm?=
 =?utf-8?B?NUJFUFdHT2tJbmJyWWNtK3hsVDFibGNuUm4wUlBkRzB2Z2d4cU5ETU1rV1c3?=
 =?utf-8?B?aHhVbVowZUswcUNnOGFiMHFvd1V4UGRUSGVjOHRSU0xCVXJ0OHpzQXoweFNJ?=
 =?utf-8?B?NjY3MFE5aWhwWWVyODZPU0VOT0hDa1AzcVNUNlI1eUpyd2V5UVNvQXU0YktS?=
 =?utf-8?B?WU9GM3ZMalMxQTF3WFAzbG1NazJSdFFKbmFtSXVVMm5TZEl3SXU3QkNGV2NK?=
 =?utf-8?B?Y2hWejVIdnVrQ0JFY0VJZkh0RTljYnozeGxwb0dLS21zUjNYWUhPSklFTnJ4?=
 =?utf-8?B?SkYxQ0craDlHZWtoUXlqVGU2dFNCNEUwN2ZqMlh4Y2cyV1FGNW01dEJtMDJI?=
 =?utf-8?B?NEdXdkVDK0ZCSnFsYy9BU0I4cDJHUlBrZ3BRcFptMnNZMTZiR0oweE05d2pY?=
 =?utf-8?B?WklWcFlNWDJFeWFkeXY0ZDdEdjNlQjFhdldMZmtNaGVjeWtDdDlDbzhRTkp0?=
 =?utf-8?B?MW9QUWd1YWtubFo2ZlU4TFhuVitUK3NYOGxRd1NvWlBSTlNOaUhUeWlZNTZ0?=
 =?utf-8?B?elZsb1pTS1JQamJWbzBWTkxaUG8zTCtmV2VIcWkxcUFQQnd2RUFVZWlMZGdo?=
 =?utf-8?B?L1ZORGU3TGViMC9tRjI2cEFvWTlBaDMyTlMzeHlIRnRTNWZoMit0K2Y3cysr?=
 =?utf-8?B?dFR6VWpZS3VJSHRRMndLV0xLR0lkTG9ub1NtT3MxVW4xWExRNVRKemV4MWhQ?=
 =?utf-8?B?Si9LME05NFRuMDUzV0ZpTm5XcmhHRlpQclFpVkRNbU1LbGpPeEdVakVBRVB6?=
 =?utf-8?B?bWFOYVBNUEs5TGZKc2NkVkNKUitscEJmNG5nNzJlZDJ1MzhjVGVlR0tsd2xa?=
 =?utf-8?B?NVBoMzJady9SQ25XRkJvT2tYMXhqRXpORlN5SE9HTld1TkJuRGFnMUUrZXMz?=
 =?utf-8?B?TytlQUtQMHJTd3YydXpEZ1pML2diVGdubVlYeFBQV3JZVUF5UjNpL2RCeEdT?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E6B435C5A09014FB7F2350560AE8987@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dwIBbquELuU/j18mQbx0B/si/957DXhCjVgnMwstXo2g38NE8AVdaMTOV3XjVhvNZLSok4DX28aRv0DulZ+PMaF911kUoQ0ySEAX5OwOsrEKSRvf8u8JOi3IZJe57FCgX8auYi8TkkA1FDz7iE+NyIRBac6IhBUnsE1wyrvEHwPNZSHYuC754EF8q3VmhheaFoFkoTBvSR6+HNzfYiqzGq50GUgks1WHH0/PviznABfaCLwza1hgsFJgVs5bppJjUZ/iR9qKqBoNJE/aZ18Oqdac6wkbBV72FyyEob7WKL9tU83e+N14+35PHHeCShvGA7fiY4fveLZ9I92f4AOLu3mlQtuF8oBut60eJY68NrTnPMUVX6Q2T9pD8vYAejYPGhxuLIXTbgOttm5BEbrzBk53Dpstf31XoM5G7AY/YqfYyICc9/i09AiCgaS7sOzbWzouPtOBN26KRaCYDjYwUnKtsGUnBgjd6hbU3TnMOybspCCNwBTGPTvPBqPBYoMLP4lKP5wmZucgvlhr7mwsSdarEVX4hmnI6w5L47HDSIrXcn0lkF9zAztZlFx/NqYdJL3shxY1o9bylKdh0HqRnTPCoylUVvD08PR82h7fZ43fn5ieBq3KBV/qpiIUr88t
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 173cfc80-5101-44b0-4a1c-08dc89df8cff
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 06:27:21.5762
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vjk45+trjHHDzk1w2+4CyNuZC2k/pGXYRvxY2BjTQkTR7kYoAVAvl7NLl65YjMesRiJrirtrbUJy72KejUbNxf0tBWNx9hpI65afA4oLgUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6746

T24gMTAuMDYuMjQgMjE6NDMsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBPbiBNb24sIEp1biAxMCwg
MjAyNCBhdCAxMDo0MDoyNkFNICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBG
cm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4N
Cj4+IElmIHdlIGNhbid0IGluc2VydCBhIHN0cmlwZSBleHRlbnQgaW4gdGhlIFJBSUQgc3RyaXBl
IHRyZWUsIGJlY2F1c2UNCj4+IHRoZSBrZXkgdGhhdCBwb2ludHMgdG8gdGhlIHNwZWNpZmljIHBv
c2l0aW9uIGluIHRoZSBzdHJpcGUgdHJlZSBpcw0KPj4gYWxyZWFkeSBleGlzdGluZywgd2UgaGF2
ZSB0byByZW1vdmUgdGhlIGl0ZW0gYW5kIHRoZW4gcmVwbGFjZSBpdCBieSBhDQo+PiBuZXcgaXRl
bS4NCj4+DQo+PiBUaGlzIGNhbiBoYXBwZW4gZm9yIGV4YW1wbGUgb24gZGV2aWNlIHJlcGxhY2Ug
b3BlcmF0aW9ucy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpv
aGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4gLS0tDQo+PiAgIGZzL2J0cmZzL2N0cmVlLmMg
ICAgICAgICAgICB8ICAxICsNCj4+ICAgZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jIHwgMzQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQs
IDM1IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvY3RyZWUuYyBi
L2ZzL2J0cmZzL2N0cmVlLmMNCj4+IGluZGV4IDFhNDliOTIzMjk5MC4uYWQ5MzRjNTQ2OWM0IDEw
MDY0NA0KPj4gLS0tIGEvZnMvYnRyZnMvY3RyZWUuYw0KPj4gKysrIGIvZnMvYnRyZnMvY3RyZWUu
Yw0KPj4gQEAgLTM4NDQsNiArMzg0NCw3IEBAIHN0YXRpYyBub2lubGluZSBpbnQgc2V0dXBfbGVh
Zl9mb3Jfc3BsaXQoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQo+PiAgIAlidHJm
c19pdGVtX2tleV90b19jcHUobGVhZiwgJmtleSwgcGF0aC0+c2xvdHNbMF0pOw0KPj4gICANCj4+
ICAgCUJVR19PTihrZXkudHlwZSAhPSBCVFJGU19FWFRFTlRfREFUQV9LRVkgJiYNCj4+ICsJICAg
ICAgIGtleS50eXBlICE9IEJUUkZTX1JBSURfU1RSSVBFX0tFWSAmJg0KPiANCj4gVGhpcyBzZWVt
cyB1bnJlbGF0ZWQuICBUaGFua3MsDQo+IA0KPiBKb3NlZg0KPiANCg0KT29wcyBpdCBzaG91bGQg
Z28gaW50byAzLzMNCg==

