Return-Path: <linux-btrfs+bounces-8892-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1E199C1CC
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 09:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEE31C23C70
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Oct 2024 07:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A814C5BF;
	Mon, 14 Oct 2024 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GzQ+fIHs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VDj+R/3D"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C6D14B075
	for <linux-btrfs@vger.kernel.org>; Mon, 14 Oct 2024 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891907; cv=fail; b=lEcZCAfNwm5FtaOswzIcRXYFvt+X+Y8NQs7F/dadYO1SbOEMStdY7bpXIlMIVCstYp2GvcJwT9P15a9wVq+Ik4Dr+N+yu0WpD92mSG3D/UAeAsUcvxvqMz9i/EUAKEmSfkZPgKl7Q+AqVoDy/Wfz0ctqEZluL5B6pDJLV0MB9+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891907; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uZ2pTWBzNVB1UHGladcq7qiDkNpTgbJFEk9UTPDl+KrUw7oeVNfVsh3pHsrJFVRFLfjx52LVnG0loALoCrlIUTmYOCuXj7+1vm51Ep4lhlzHsDhHrFC2QEffvNwIcK04v/vLIuSWBYP5Ib/3tDvGyPDC0kWNzxjpevjxnLi9MmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GzQ+fIHs; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VDj+R/3D; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728891905; x=1760427905;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=GzQ+fIHsx9Pj/XzkCK73YZcb0Vt3+895PHnlPHZaoxXphx6zr79QdlvT
   aoXiTqDqx7CX70bphfaGER/krtPPeMLsfqkHCaJI6ecXlE5qpfvTwuWbO
   eS/o148PHmIe2LEjLZZ/H1Pd3sNmVCePa4N61RYs53nckUB5BFCztsDNP
   SPRdYDNT6+Xf6Jhixlj9DHuYAU9C+JG5y4z0uxcgNZCDV812FkXXhuVIv
   SUQYPMrSZGxJuE8iC5i33+UVwU0NmU81Ck07r9Rt+a2/NXFzE1/12y05h
   sGyLQ1cn6yX/CdFZ+yeHD2JrFcQr1ysTspJf+Brfo9WzDEIGSwA5NSK9z
   g==;
X-CSE-ConnectionGUID: i3s/cUasQrWQjxTdLSjW+Q==
X-CSE-MsgGUID: NXCeq8BVSeqiwAWxJm+XDA==
X-IronPort-AV: E=Sophos;i="6.11,202,1725292800"; 
   d="scan'208";a="29826522"
Received: from mail-mw2nam10lp2043.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.43])
  by ob1.hgst.iphmx.com with ESMTP; 14 Oct 2024 15:44:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v2kA40mmkbLF/c3E9Rj1W7Owjm9po4P+XBWYq7BPYMjsTqi+oImPHs21781bIjfGbzW4NmK97yzrTrPSfo08IKVXyDgyFpbihI4ylCvKoPhP9tbHen32tVr72/vnasaTQBq5LSW/I94ZMyTRc21cC7mkaGMs6p/6g9ZeEzSA6dFS/ro12jluRElrUIZgu/o3uQOy7oC12qEi6QQxunO7EEUeyyo1ZG23I61zm3sXteleyJlWrXakQU3kiFesciDEG6/7BsS9SChVDvU/RvM4bU/bNMUpAsW920k2Lt3ebnOp2mevvp1AgjVBsmwanSUJ6scxw9F236VIAwa3+ZJc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=ik8KpYbpGFbqRTiy9CkD25ErRPHYGHRLs/itWeoF3BBvW+oX7LyaoXJIgCPnz6lFKI3JE9QpouTC9dwomtKIuKkf5lrFZVzS5eDcYCRAkjehpk6dBHu/l/TuIOuqdg/E2dpefulIrwipi7EIdizCwvXGSwJQ4rA00+bKLG5h+fHKTF9NSitN8pqwAomni9lNN60m+hubzlNJQbeTugaPa1MdSHhbmt23OUu+qyxnnc59972dNjWl+0D1eZGLW3w4mB7HNtuk8z9QwP5W7RUxWmyBLHyP2vt/w4Euqdd3U0Pi868uJJ+pXUFQDDS8BaKsYTA4XjWjQla/UHJZxQ9/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VDj+R/3Dcl/hTukwZ1bypUYCXrdQtt+6DhY/uqTyU2TFo0eu8AKxy+71dh82kcDeDadKUvf3a/ZU2Bil7ZcrbAmPc13+/FORlKgMI4SGhCphK4vvey+1xPaR5AMGjBsYKka9eJQdqahp9jtOXOgWeA+baxMOgXiG0YSzpLBm+Lg=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by DM8PR04MB8007.namprd04.prod.outlook.com (2603:10b6:5:314::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 07:44:54 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 07:44:54 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix zone unusable accounting for freed
 reserved extent
Thread-Topic: [PATCH] btrfs: zoned: fix zone unusable accounting for freed
 reserved extent
Thread-Index: AQHbGgP/xN9/pqeuuE2El/kUwDYAgrKF5eGA
Date: Mon, 14 Oct 2024 07:44:54 +0000
Message-ID: <db4faea3-5040-4d96-b0ca-22f3396c4de2@wdc.com>
References:
 <4d5f6524a0c84e98383ea52dcced34544ff4ae42.1728448186.git.naohiro.aota@wdc.com>
In-Reply-To:
 <4d5f6524a0c84e98383ea52dcced34544ff4ae42.1728448186.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|DM8PR04MB8007:EE_
x-ms-office365-filtering-correlation-id: f97749b5-8b63-431a-5c93-08dcec2417c6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?MDdKN1pjM3p5aUw1N01yMHJPeTdRRnp2b2VKaU9tbG1rd2hMRlZueEw4L0Vr?=
 =?utf-8?B?aFR6RzBqSWllYjdhN3FOVC9McWhLcTdOLzJLdEx3QkhjeFovTll3MzVMWXIw?=
 =?utf-8?B?UUV1cytLYkRMby8yQmluR1FweE9yeE1sMUtHeXdlWExKYzR3SHkxbTBTekth?=
 =?utf-8?B?a1pjOCtoUDVtTUtRTDg0QmRoNHBBa0NjVFM4TjlvaGlra3JzUzZnb0Fxaiti?=
 =?utf-8?B?K2QyODBLcS9kQXBxU2tITnRpUkh4MmJIL2t2eUJ4bkRBcGFnT0JkNFFTQkJw?=
 =?utf-8?B?eVBQa29SSk4rcUlvdERHNlhsNmU5R09CS1lqS21oTnhFbjJwRGxxWm94MGN1?=
 =?utf-8?B?RmtLTHhVd2xNODFQaUhxWStiRmFDWUpBc1RDNEcyQ0duRmFlZ01BU0UwUGoz?=
 =?utf-8?B?YXkvR0pmNmsrdEd2dnJ6S2JWMzlJZ0tpSklWVGNvRkFLdklObzkwQ3N6SnVW?=
 =?utf-8?B?VWpDU2Y5UXFwUlZYNjRTNTJFcnFmamJwT2tZYjJ1TmpCditqMDluNkszbnY2?=
 =?utf-8?B?YkhYaGFCYnNQNWJ5MHZMRWQ4NXIyRStzalRTNGZvQ1NpSGZvczY4Rm0xVldm?=
 =?utf-8?B?NENCbUlhK2pld2NaN281cFYvTm95MUpmbzdYL0FwMktCTmtkZUpRRmo3YW5I?=
 =?utf-8?B?TzBoS2hXQytGYkRwOGtuM09KZG1weFZzbHdWeGpkT1lBSlF4WWkrZWh2bkFX?=
 =?utf-8?B?Z1BiNXBpTjh5RzNtWmU0K3hzSGNiU0RLZUpRbmhuZUJ6bUhGQ2txTnYxcW4x?=
 =?utf-8?B?NEZla09HNHBsSitHc1UyRjA1Nmp3Z1NzSTNPOW5KU0h4T1ZqOEdQa1d5K0I0?=
 =?utf-8?B?ZExwK1ZFNUx2bFJoVHc5NkZJbUJieUJOZUJLRWV5dHhZdkM5a2FEWEpNUjlo?=
 =?utf-8?B?NGlublJLVDAxU2FHK1E5RkZZakpodWpLdVZkRVNOUVlwN0xtdXByNG5BcWQr?=
 =?utf-8?B?VndiQk1WNUo4YkJtdTI2djAxVDh3U0RBQVNsUDRENTVUWllaVWpxRzQ2QjFl?=
 =?utf-8?B?cEZnSC9ZdTR3REcyTGxYVzI3UStFRnBxWldPa0ZUbjlMd0ZJT2oxRHBGblFo?=
 =?utf-8?B?b3hMajJPRHg2Y21Wd2JTRitETTNNZFZDcDJxRDJCclBXcnJZd3ArbkhsYW9v?=
 =?utf-8?B?L01kL2FzcGE3UUVOcnNuaDJVMjR3c2hJdWJKb2diUnVWcEg5U1MxWHFPd29R?=
 =?utf-8?B?ZEg5OFpYQkZFWWxEMm9OdGVld3NvUStVazR6ZnYrd2w1UEF1RzFBWkthV3Ny?=
 =?utf-8?B?ci9ITDlLeHo5ZC93RjVmVHVLWU5sMDgvUWFsVFpZMGZOTU52YlpBWk5QcUpQ?=
 =?utf-8?B?VnNyWHpPVzZtTDZoVTE5QTV6bHRlT0lMc1oxWHUzSU9vdzIrK3BSa3JzOTh0?=
 =?utf-8?B?TjY3QXcyUUtzbUlINmo4QzN3Ti91T1l0Mk11Yzk4Y2M2OWlKaXVGdXBwOXUz?=
 =?utf-8?B?SnBGajhqQzNpeFhnV2cycUZhN2h2WmE0UVBvZkpyOWhRNmZod1puZkpkZkla?=
 =?utf-8?B?S3ViNHJzbkJOeDI3SHB1MUlZQjFBamdUTUx6bUlkd0NiYWNSZU1yZUh5b25z?=
 =?utf-8?B?Rmd6T1FoTzlCZFJOK0NXdFFpNVR5L0JERkYvczdPUHRTc2ZWa1F1cjV6SElu?=
 =?utf-8?B?MWlzakZVc0paWXBObzlGeHVnQjVUeVliUkFlKzNRMndGMEtjVTBsYWJIdXpi?=
 =?utf-8?B?TWRuRXhMa0thbnVtcGxNcHlOeVlkRzRYUE11aW10ai83YWJJVHpidmszZHZv?=
 =?utf-8?B?S1pFL1VMYVRqcVJIdmtJenk0SHRuakdhdXpuRnJEdmFlclE0c25QbTdtY0oz?=
 =?utf-8?B?VmFocmFPdFdaMHU5N2Q1dz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R1lQV1BNalZuSlpTODZTTnhmTUxsYWFHSm5DWmtvYXdlbU9WUVVHclQrYmtE?=
 =?utf-8?B?ZENzTVIvd0JsOGtKTHFZNVd0eVRCUTNuZVNUMkVLMnQxUENyU1czTWg3ZnZu?=
 =?utf-8?B?aHlpN21tc0ZUa3ViL3V5eTdxaUNoVGVOSG9waXNoMVNSSURWWWJtMklJOTkw?=
 =?utf-8?B?R3VzRjlwbEJ1aDNuMWltSEhlamVXOWpJVXN6aURwVmRQb2o2bFpNaUlFaFlP?=
 =?utf-8?B?QTBrU28xNVBHVGsyTE4vYndhaDZNTlFSZGN5VEovb2lKMkNsMG1OazlLYnF2?=
 =?utf-8?B?SFR5VTVOcUxvRWlVcUkzQm5mT3cwc3IxY244ODVQTmp3QVcvM2JseVE4Umx3?=
 =?utf-8?B?eTdMUlhmL3BtSHgvU3lwMGRsMGpkc0RBWHNoNXphaUtsN1FQWHFBQ1BDQmJ1?=
 =?utf-8?B?WmhvZW9IS2RtV3RoYVkwM3lEKzkzMlpwRGJWb1hyVnpDbDRnYnFsQUpFOGhx?=
 =?utf-8?B?ZDVOZnpOcVN6RnRMNGpBSXJnOGNIbGdjeXNOKzZxTmZmTFhzV29OMmE0Z0N5?=
 =?utf-8?B?bUVOd24vT0JFOVkwNVFyRGVQcE1pZ2FEeTJEc1NCRzdodUV1eXJ0RGR1NFVu?=
 =?utf-8?B?ZjJXSWhRVUhUZTB5Q0pwQ1BETTVHRWtjbWsrbkt6Rkh6OWJzcjY4RVNKMGxw?=
 =?utf-8?B?Y093K2JjbmFNZW91cEhBRjVrUW5hYVcwWEdpZnlOYWJtajFUOGR0MWVkSVQw?=
 =?utf-8?B?Rm0ya3RyRlJXU3lJQzhwQ1FUaG1TdjgveUorTERkdzM3azhxeWpKOEZpOU9F?=
 =?utf-8?B?VTlqSU1DaFpJS1krWXBmVkRYTTcwU2ZudHl0dG1TRDdXT3B4Vm94Q0tpWmJS?=
 =?utf-8?B?YVM5ajdvK0t3ZkZBazFsR3dRZXJlYWhTNlJEd2JsaDB5YzdHWnExQVZKb1Mr?=
 =?utf-8?B?RUxod1QxNFpwLzVSVkxmOU9kRHFaTlNLWmVoRDJxTmd2cmdEbkhEcTFoZG9M?=
 =?utf-8?B?VTVDa1piSjg3TmFpUUQ0c1dTSU1JNllDUEp1dTI5RWQxQVJ4NnJVVzdQSEdP?=
 =?utf-8?B?YXo4dkdpYVRtUWxtcmRYUjZiTldpRmp3L0ovM2cxalliK1ZONk9kVFVzN0ta?=
 =?utf-8?B?V3UxdW9tN2FOSXE3TFNtVXVET0xKWGFVQkRoeng0dXdCR0MydlRyNHN5Rndq?=
 =?utf-8?B?dzdqZjRRK1hHK0JySUI3Mk40SlJYbGdtMFRMdEFzU2J3UW5rb2x2SmduUUJ3?=
 =?utf-8?B?L2hjVkQyUndDMXlyaGdkWVNJUHNMRXJaRnhTZjNXNFRSdFR0cjQrek9Ua1pQ?=
 =?utf-8?B?ZGtZSHZ1VGNkd0ZsQUZXNERaQ3NNMWhZd1NkbHRhaDM0VnBFZHVMUEJKNlk4?=
 =?utf-8?B?MnJIdjRweUszRUhYTVEvQmJnQlNhd3BOMFN1K3JIZjJHSDRGSi9yaXdUNnQw?=
 =?utf-8?B?ZkJQa2huWVc5VzlRbnFOdUh2S0tQOEYwUDNjQXcrWkd4RW1NSWJ2dURpdGVD?=
 =?utf-8?B?K09Zc0YvUnpHU3VCcUJVaEo1cW1qSmNRUVdYY24rSC9OaUlSM2FLQzhHZitv?=
 =?utf-8?B?YlRHek1adFBuVFZ4aTlNbW9pZ29rUjVZR2pwQTMwM1d0b2VheDIxRXFTelRz?=
 =?utf-8?B?LzhaR2poeTNPZTl5ajc1VW40bnF5cXRneElSZ2hzTUhsWEdybWpBcnVzODFq?=
 =?utf-8?B?eTRUUFc5Rks4RTRqM0M5Ty9nc3lkTW1WbFBqZTEyUi9BTzlvSThxU0g1dFVN?=
 =?utf-8?B?VjlRZkM0R0dtZ3dSTkwwODdaZjd5MS85VFpIVWN3Zk02R3VtR1NMRC91U1Jp?=
 =?utf-8?B?QkNFSVN5TGRpTThxNmdEekVJZHJBVWtYZlM3ejRtQU40UGl0UUdaTklMTGNZ?=
 =?utf-8?B?cGRScU5DT2RnUzYrcC9WUlM5ckQxbkFCZUlkQ1RPSFJSOGdaUXM3cEFLSERZ?=
 =?utf-8?B?R0F5anRwQ3VkeWUxeEtKbGtKRlJGcnhNby82bW43NDJJL3MramQwRDZpZ3Nm?=
 =?utf-8?B?eTJEUjVKZnhIOFN6aTFpTytNTFErUlJOb0Nuc3BPTnY5TlV0QmQzVlZaY0VC?=
 =?utf-8?B?QlRrL3FYY2dBQXdESE9FVEdiN3plcURRc2JqbnRDVE5BcW80Q3FWOERBbUJJ?=
 =?utf-8?B?Qy8zc2JIei9hRHJKTmhNTExEYXpYZ0JXTVBiY3NEYU92RDV3UlBzZTJCZldx?=
 =?utf-8?B?ZHNaZDcvNGxFRGlyZjJaTE51L3NUSUZTY0lYWmM4eWpoVWVHVHNjK3BKaC96?=
 =?utf-8?B?Z2M4Vm12emdmNXNjcE52d1pqUHB2MHNhVTZpVXRkL2JmM0gzUTB6SmxNQWxW?=
 =?utf-8?B?S3dMRk1XMWZUNkh3VFlmT1JZNlVBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD1A3353E9D2EA4EAB84621375B25B5A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+TW3wAoBMZgwv4kCWa8ca2CXr6YNZ6StKDUbOvGc16eJaDGCWeMpbKmn09B+XqRJe+gJdcHHVaouQxN/iV8oYRXfwj8Z3dhmkTe4IEOAFT47rhGKIZq4tT+OZ4qni6dfMqPYCH6Pxzx/GR4hPA9xl3RdJ5DB5m686J/9+QL2rSq9A2v84rWZJJVZ9iP5Cg6FbHlno+JtgI6a27R+7fnq1y7DFmN9w5EoqL2fVrFL9ntAEnWCrGGBn6t/xjXyO/SK4OwzK5IhCdfzeKzbP7CpUCShnGW8WZvD0g6vUHBAJo1xzkROmNEvRiFF3bffdIN9vfziHHksFIVBo14bkMAxVaxsnLZCEzgba1cqTDdwsP5PVGoLB0PfX5kg5gBvpLHTeA/R0B6F0jCnyObGskLuar4nnoUbTJXBT3qAk6fzVhLkJJSnVugV6DZoWWuXAU5XoxMeib5iAXSfYOSHsHtYn//xXw4gTz0l1W/9/0Rdas8FvDMBNaZynHQffd5ZyVmjiTsP9PjCZdTNDjZ9m6uj1nnTvh/RykJwd+NJfK6YcFIRg+LDMKXlLJDf9b3Fd0Ki7i6sCAGEiwJebSJnosHhHuY/7k1reqUUgznKMC+eGNNDrw/d6icBY0Z6du3bVKBB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f97749b5-8b63-431a-5c93-08dcec2417c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2024 07:44:54.1343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0CN/GQcGz+LQ+/QSjJL4PoYRMBf5ZtV9tL9jeXuT5KxedLLEIkeNXNGaDuOikNGflPHI4YlyYhoGqVMUJwRd5q2754RUunovlPP+/Yno5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8007

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

