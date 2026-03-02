Return-Path: <linux-btrfs+bounces-22143-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCGqJ3pspWk4AgYAu9opvQ
	(envelope-from <linux-btrfs+bounces-22143-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:54:50 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 216AC1D6EFC
	for <lists+linux-btrfs@lfdr.de>; Mon, 02 Mar 2026 11:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30327303D2FF
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Mar 2026 10:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B63590A4;
	Mon,  2 Mar 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MjKNEMr8";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p6h42r8N"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA58359A6F
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Mar 2026 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772448697; cv=fail; b=qpRSMg8ocxMhUQF9fpfbtIyrz2wAnUq6rjZ/OAzrn+hMlHhvtOE3Q67E+Y0NPUBZqPgLsoD/BASfLoqvIdI4UoVQkJsOeRqn0ZdXHCuv5nLy3qO+C7abmGB53RuL4WCWLQ5x9qmuaQSPzIFjqy8aICWn41HI5YExhv/ETnlKlVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772448697; c=relaxed/simple;
	bh=ey1R1G2PaXqgq7J/kTECVyl4wrCesIm9lRktBuwSRfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lx48EQKbkjJu5U/sJfPZKKOJkO1m5CoqvZX3vniACR5jP5X7okYTDk9zosVtWJwVYEa0+NJAHTd0JcuzjRuOtZ9pmz8CpOA3rpHwdiRkNLpol1KL/0CURT9vzWF/BQkpS5AgWvdfS5epvTF5h708Rxsu3KtXmTqTmPrXkFvS93A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MjKNEMr8; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=p6h42r8N; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1772448696; x=1803984696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ey1R1G2PaXqgq7J/kTECVyl4wrCesIm9lRktBuwSRfg=;
  b=MjKNEMr8rZGRNiALq5/M5Etq1PS6tBMSkqcbV0IUh9kNd7eBlvn/Dzfe
   uJigDu+akwOP9pjhNedPQKb24UoP8OnICz8RlW6f3BfF/B6A5bLa003M5
   eNmtavsRJ5RUiUfZTvROIR2AeQTccS2hjQATlGqIhnWCnkkrAUKTG0Ucq
   mN71idkYYnMh7IjaTQU3apD9bmxWQhvvWlyhiRxhmAAShulCMTgBG9GBM
   /zOvFeEW2/R7+wCZL0x/dZrYqSTDROLlcAuQnM7p51zEqokXe5A7CB4X+
   Ta+H40pWvrtUAgqlCdMAhP2+86Z27tucg+CBgY2YuMb6wDxZB7INI8PGx
   g==;
X-CSE-ConnectionGUID: INGQ7klcT82QjVqIPXjoEQ==
X-CSE-MsgGUID: AZD/yzGbQNSqIeB/3Mm32g==
X-IronPort-AV: E=Sophos;i="6.21,319,1763395200"; 
   d="scan'208";a="141332283"
Received: from mail-westusazon11012008.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.8])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Mar 2026 18:51:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpP78mjr3hHACtY/U6+RlpFrfefV3nF1imBg47/gkGRy2PaW7bO6rv1hwsD40ptMNfll4AN3GA5JglSIbTeQZksXJj8LYQw/IvtzwPeM6Mx5UkuwAK8TtmCux/R36l0GPHzEDC1fbqSJh16Fd/r9TIxfAManEOAnU+RFQeDjLnwfxr9aVMtKlEz4upbDtBr+dA/fnOOPrXgkcv0lK6Q4EKQyL1Aj5g7xl3wzE4GRcErL5xbrTsxoyl2kj6qZERQ8EK0pU1QAmy46S2W/Cq7q+oLpkPXxjdMvQIqEkn0sKXiit7nb7zRJYbPcV1mHsM/pHNcQz7IYCQ1NsWGkGiwN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ey1R1G2PaXqgq7J/kTECVyl4wrCesIm9lRktBuwSRfg=;
 b=r9+UDcD+hnuYqb4rws6cLiBm98HEt4UYgMZeMbnkcSsYWPjBRaXewnU5EO3glZJsJpZQHulNtZ9ws0WomzF8WusFPdJu86DMYsgzSgc/qfjAgY7KbxYxcUkQVCdW1fh/A2D/oAIIe1g2l0GbqTbpyiTBmcfwYBEuckHGs5AmWwSUwhXcvv4mIAkcXjnEDrjuos8yn346UiFdWWfKGdXZir6qBdiv8YRzqYyMABLuSu30gJRbtaU57gRRrbL9zmcQ+1SMovQuLe3CHJ/P2O6oS46NKUyorQO/b8UoQc9uGJ06TVWvCPcIUoLJwcyVSM+7fiAG1G1Rl4E2FDcpIvOHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ey1R1G2PaXqgq7J/kTECVyl4wrCesIm9lRktBuwSRfg=;
 b=p6h42r8Nd1nXOzm1PeBEB2V9iFOKDw4Sh04E1uyl4CPURZHBZBeg/rSqP59+cIrwYCLfCaFgCgmPi6+Up75HpwaY9lTflE0yRsyGAgD5NuGxbqkdcrw83kgDsWjT69JoUQY6NUoJiMRUhqbouEP3sS7GhKrNzKfNO5FkU7CeOqA=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by MW6PR04MB9028.namprd04.prod.outlook.com (2603:10b6:303:24b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Mon, 2 Mar
 2026 10:51:32 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::ce42:7775:2df8:8729%6]) with mapi id 15.20.9678.011; Mon, 2 Mar 2026
 10:51:32 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: Filipe Manana <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, David Sterba <dsterba@suse.com>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: fix leak of kobject name for sub-group space_info
Thread-Topic: [PATCH] btrfs: fix leak of kobject name for sub-group space_info
Thread-Index: AQHcqXVW7cpADFhhPEO07dEkv4KoSbWbCHUAgAAAt4CAAAj4gA==
Date: Mon, 2 Mar 2026 10:51:32 +0000
Message-ID: <aaVp3NoSv-95J8XR@shinmob>
References: <20260301121704.45115-1-shinichiro.kawasaki@wdc.com>
 <CAL3q7H7KgBd7cKMSWLdu2pe-f8SRPCjOhPCvyHrVYDnjsDTr7A@mail.gmail.com>
 <613fe925-b0db-408f-8086-74b2822e278e@wdc.com>
In-Reply-To: <613fe925-b0db-408f-8086-74b2822e278e@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|MW6PR04MB9028:EE_
x-ms-office365-filtering-correlation-id: 421042eb-9e16-4714-8ef6-08de7849aa8f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 VDqAGoJnbIKyVBAVifozRxk40Bi/4zSRggFeLIu9OuHqcfRVmJvBwL/UHFDUDv/aCHCp7OJBviYZVVdrwGD492mkbAw8tYESvdVT9ihZqcdqZTpgUBzV035WEhCFx+mAPH+V601JhzA9ND0DqZElrEDi+75Gef8kI7FZMKmNOoy5b2+GB+H691HAjVJYiKmOYsBd80v/okS0z1U7aF81JjqS9PhyKSFv6JNgo4wknyoAQnlTBRxoAmcqPgDlqD5VdK+KRlYBmF/yG/ny+i4UEN8tWGQYVgUYVb3hx8+yEdge8S+rr+ZMkwgJgk48NLQZfsxA5+IWi6j84NNkFYno0wcWT3o/pe7Bhlfns+cbNLBRXJW4HSZZ+9mARdBM8gTNsEBd5u58AU1phBXW1DPEQXtHpDJyOJ6JQil1NeMCsbp21/d2zavSfh+O3YiT6UkY0NaLTHd/AFWqL+MzR+i4gSIcelIGOG0Uc/4xiRkoP59iR+THKZgRjhgXA+c0/Tza2oilmqi1rJcJyvYvaXR+mvaCC/N6C8km48L2YV4BE/hzsbWnfJG0594qxqyUW1MFImrScjBk9K1Fk6SL0huDVMs3amuncoYUosjzfzS7zKIlBGxdsconupzBAPr1klAmF2qmcjRfMqqunytMyNoeE3kHt2wjdWN9k7J/f/xym6Gq0rJYNmFP3DTocQKmO/7tHobM5w5+t7OfPPczf+z5ajf8SuSRW6kaytqyEuv6/rHbZ0s82jzotRcvPW5aa6DtV0P09t1UrhVZ3V8/tWNW7krlWEtv+wRBk8O2tUHAT3s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZjV0Mkd1ZDdqUXlFWmRIRW4xR1RHcktjLzlNZU90MnUwYTVzWTZ4bTZhb0Nx?=
 =?utf-8?B?ZmluN0t2WEpCeHpPQnhXZWNrQStmQWdnNmJjM05BQ2pJeFU2Um1pWFJBTHBy?=
 =?utf-8?B?SW1jZkJoS0R5TjI4V2dyc2VxL2RWOUtmMlRtektYYklJZitxL3Y2VmRDUE1G?=
 =?utf-8?B?dDFwQVpwTEhEcElUQmpsOGFNbmFLT3ByMWxvV1M3TEdQNGdHZUpJVWpOekVD?=
 =?utf-8?B?R3BQMkNWOVJNZjVWZzA4NTFRblJIeTNGWnBSSnJxbHBFYkwyUGx2eUZmTGlM?=
 =?utf-8?B?Sm55T0FSWGx4c1VJTWVzVjdhOXpiVytIdUVjQTNMK3J1SWVKbWxxaVg3dUtE?=
 =?utf-8?B?ak5mMmVNbFQ5czFyUS95R1ZOTDNMRXdBYjJFLytiVEZJT2EwOXFaY1hua3VT?=
 =?utf-8?B?NmJydVB1ZURldEdSKy9BcEM4d00rWmRSd3FiNmRIOG1UeEhpcWpxY0k2ZHZa?=
 =?utf-8?B?ZXZldmxLMVB0bFhNRU5iWlZCeXpyZXpYMlhLdFdsOXhjRzZVblZ0Q0Y5S05k?=
 =?utf-8?B?aENCYm5JU3dDL1E3ZlIzRmJKOUFiVnR1NnZwblRJeHo0REVCVWZadFRaUHc0?=
 =?utf-8?B?K1JxdGMxNS8ySUV4ZnNjbjRLbFY3Q3MzcFdXV1h2WnR6cXlNaDM2eTBqOGlG?=
 =?utf-8?B?d1NwSzExbVpQZjE1aDY3ODQ5R0ZpNnNwWDhKOVkxd0IrRUd6T2gxQlJUUVFK?=
 =?utf-8?B?OUFncUZpSDkwWERGamo5aGNrdzVYb2ZRdmcrbjNDY1d5eFNGTHE0YUJ3S0lX?=
 =?utf-8?B?d0ZhUWtvSjhKQkRLNUtEQ1VyRzJPSzh4MCtuZ2w0Z0N2WkZaZzhkVnZBanpZ?=
 =?utf-8?B?Um83YTMxdXlUczN1c21hb2hmR2lHZE5jN285NVVMWGlDQnBrY21aQzkwbG50?=
 =?utf-8?B?cmdvNGZvbFJOUi93Z2N3MG9HM0JucFBwOGdEeUxyTXVhWWF1Ni9mQVB0NTV2?=
 =?utf-8?B?L2NTVDBYUXpJbE5rRE5aOTEySGZyemx3aDBsY3dHV0U0UnFUOE4zVEk4V05z?=
 =?utf-8?B?dTV4TEVxcTN6RnF6K0o1U2RNMzlqM1ZCVGtwWkRibHVDYm1zMVFXcDFPcXJ0?=
 =?utf-8?B?ZE1lRFI1eVp6dlJqN2EzNGpHdlphN0Z1Vi9GOU93VE8yZGxOak1IWXY2NW1k?=
 =?utf-8?B?eWI1ekZ0K1dCK0t0d2llbGh6M1pRajg0YVJPSjB4MXNTYklXTWZWSm54TXZw?=
 =?utf-8?B?Rmc5WVI3ejRpSEh1SEp5c0xxeVVXUkZYaTl4YVk2OU5ReXNUTlJQTmZtS01I?=
 =?utf-8?B?VklKQ1lrTnR1aXZ1aHFnbEhUVVdTL2lHOFQ0SjRhM1BzYW0wWWxCVlJudTNP?=
 =?utf-8?B?TUVFemh2YythaGUyL1ZNUFViZGw3OXRRcFJ5b2E0UkxFQktMTUE1SFNwOFZ1?=
 =?utf-8?B?TGN1cVBHZGJ6NWdLU2IzcUR1ek00Qnpqc2EyU1NlRHU4RHgzYUxlRUpLbW1G?=
 =?utf-8?B?eHVFcWJkMDFuWlVkWmMyQkpnRnlCMmZneGJiVnNZdDFxaHN3bkpkYlFzc3Rp?=
 =?utf-8?B?WSs5aFJVSDQyV3BQTElHSVNnR3d3eDZEaUZIVk0vWjFXc0dXTUs0RmZ3RmNa?=
 =?utf-8?B?RVFJQUZtY256UjduTnJGeHAwNmprbmYvMFpJS1pwaFVyL0xYaVlmOFl5TmUx?=
 =?utf-8?B?ZVljSG5WdUMzemlOMHE3czJDYjdlTXZMVGdleDdnZHdaU21YY2d5SFphN2lh?=
 =?utf-8?B?R0ZzaEJyOHpLK1FKVDE3aFpwVVFNdU1SUHlSeTI0L29Sb3FvMUsvUzNkTWY3?=
 =?utf-8?B?aHJScFZ2QjVIdmhROGIyY0todmJ2TzZKbU1hc3VjeVIwQk91QWpqbGYxMVZF?=
 =?utf-8?B?eTZGeVMrUTczZkdzSkU0bnU4MnNHNzFGRlJ3YldYUU9yRGdubFFaYzlOVFJ3?=
 =?utf-8?B?OTVjTXJrWmc0cGEvWmVxL2dOdFhscThJMWs5U3BMR0xnTGNlNUtXNVVXZXFM?=
 =?utf-8?B?ZmMzWW5zZGJ6YkJiY0Uya1FJajlXSmEzYkVIQjV2Q1JubTJtWXpDV2ZjVmpJ?=
 =?utf-8?B?SE5VUTUrb1hpSUgyWS9YTGdFK1JJZkJrY3ljQ2FHb1N1UWllUXR4U3YrTFhZ?=
 =?utf-8?B?TUl5TTZCVjBnYWNNdkFOT0lEZnZubkV3akp2RTRyT1hPclMxMmZXb1RQazBz?=
 =?utf-8?B?WXE5cjE4L0NhWHovb1BlSEZVWjQ5NjhuUDIzUE1xK2QvTEZ3ZVdCUlpwMmxz?=
 =?utf-8?B?RkVQMlRMMDA5STFJUWdsYnhEeGFjMFFjUWdJQlhITjNzYitoM0RaelVTQmhZ?=
 =?utf-8?B?ZllHb3ExUW9MS3ord2ZwamJpT0plc1dmQjBqVlE2Y2pnVDJaMlVzdW54RUJM?=
 =?utf-8?B?bXBIa2dRMUM4aEdVZ05paTRYUU03VEFxWFY5WVNJTm1pYjczNEtvY2hFeHdz?=
 =?utf-8?Q?/x1aAk0RfdorxEiI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15E45911A0A9D648971ACAC70D2F8768@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	A05e7AwpvVugTrRZ3gbkfR2YsOVfwTu+hqgHs1EB4oA1cVRb+uo+YcofLFJwEAz6n9Vbw1VxtcKmZRKB1aAprfm4eqtd2KwfKh2Oqw7pjcdLTrhEkwNZnlzLo7RhLyTgno5wc90gwvz5bCa3li7xmlCJl0++2T8QFIJk5a6Xo++nI775lNRV2ZaW8MJ+7n7kWrfNU1V+GvXdtKrhHQU6fayD3Fv38ny1lvXojroFR1gxS6s9pSjUzojBqlkGPa0MqDHeC3RHf/h+A3r+3OjOCpbkkIm4C5NzZOlLw6rCZFY3dIMkdCWiq6eX5hUxEeg6kYTXEKN0vjvD1MeapJZHXq8W2l6lLMKBmUhmUN6Z1ZjwA/W2AEnTUEHGxxyzXGxLZAAdb/MlrZxJoBnqIDkJ4CLrEUrmejm6q2Vq32mQnfYmBvVmRExRxiE6ApKfYtzGMrI8KNRO6x/pJxwiFhTS8q60ZiXgasHM94NJA3b1E2PEuo/+NZEESZ5LKgQG+C3YSFARP9LQww3XGKyn4Q5S/iQ5Hz4wAYHmNjs3+sHbptGU/zARDxMwqArwN1MipjlDdzwMfj8XBPRwqPNru9bMRFAGRGS0bRVGMUns+rx7PBzbZE/N62Y5++WE97aKnsr8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421042eb-9e16-4714-8ef6-08de7849aa8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 10:51:32.2468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvrnSbphrffBsyI23UAmUaJzyO4Yxnl/mnS7owJeSv/KfqLu7bqHCeY7G+DAbkG+PGktclW0Nu6OkO0TuNlu+dz0VY2PiS8Wmh1fyWtmjJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR04MB9028
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.44 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22143-lists,linux-btrfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shinichiro.kawasaki@wdc.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 216AC1D6EFC
X-Rspamd-Action: no action

T24gTWFyIDAyLCAyMDI2IC8gMTA6MTksIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gT24g
My8yLzI2IDExOjE3IEFNLCBGaWxpcGUgTWFuYW5hIHdyb3RlOg0KPiA+IE9uIFN1biwgTWFyIDEs
IDIwMjYgYXQgMTI6MTfigK9QTSBTaGluJ2ljaGlybyBLYXdhc2FraQ0KPiA+IDxzaGluaWNoaXJv
Lmthd2FzYWtpQHdkYy5jb20+IHdyb3RlOg0KPiA+PiBXaGVuIGNyZWF0ZV9zcGFjZV9pbmZvX3N1
Yl9ncm91cCgpIGFsbG9jYXRlcyBlbGVtZW50cyBvZg0KPiA+PiBzcGFjZV9pbmZvLT5zdWJfZ3Jv
dXBbXSwga29iamVjdF9pbml0X2FuZF9hZGQoKSBpcyBjYWxsZWQgZm9yIGVhY2gNCj4gPj4gZWxl
bWVudCB2aWEgYnRyZnNfc3lzZnNfYWRkX3NwYWNlX2luZm9fdHlwZSgpLiBIb3dldmVyLCB3aGVu
DQo+ID4+IGNoZWNrX3JlbW92aW5nX3NwYWNlX2luZm8oKSBmcmVlcyB0aGVzZSBlbGVtZW50cywg
aXQgZG9lcyBub3QgY2FsbA0KPiA+PiBidHJmc19zeXNmc19yZW1vdmVfc3BhY2VfaW5mbygpIG9u
IHRoZW0uIEFzIGEgcmVzdWx0LCBrb2JqZWN0X3B1dCgpIGlzDQo+ID4+IG5vdCBjYWxsZWQgYW5k
IHRoZSBhc3NvY2lhdGVkIGtvYmotPm5hbWUgb2JqZWN0cyBhcmUgbGVha2VkLg0KPiA+Pg0KPiA+
PiBUaGlzIG1lbW9yeSBsZWFrIGlzIHJlcHJvZHVjZWQgYnkgcnVubmluZyB0aGUgYmxrdGVzdHMg
dGVzdCBjYXNlDQo+ID4+IHpiZC8wMDkgb24ga2VybmVscyBidWlsdCB3aXRoIENPTkZJR19ERUJV
R19LTUVNTEVBSy4gVGhlIGttZW1sZWFrDQo+ID4+IGZlYXR1cmUgcmVwb3J0cyB0aGUgZm9sbG93
aW5nIGVycm9yOg0KPiA+Pg0KPiA+PiB1bnJlZmVyZW5jZWQgb2JqZWN0IDB4ZmZmZjg4ODExMjg3
N2Q0MCAoc2l6ZSAxNik6DQo+ID4+ICAgIGNvbW0gIm1vdW50IiwgcGlkIDEyNDQsIGppZmZpZXMg
NDI5NDk5Njk3Mg0KPiA+PiAgICBoZXggZHVtcCAoZmlyc3QgMTYgYnl0ZXMpOg0KPiA+PiAgICAg
IDY0IDYxIDc0IDYxIDJkIDcyIDY1IDZjIDZmIDYzIDAwIGM0IGM2IGE3IGNiIDdmICBkYXRhLXJl
bG9jLi4uLi4uDQo+ID4+ICAgIGJhY2t0cmFjZSAoY3JjIDUzZmZkZTRkKToNCj4gPj4gICAgICBf
X2ttYWxsb2Nfbm9kZV90cmFja19jYWxsZXJfbm9wcm9mKzB4NjE5LzB4ODcwDQo+ID4+ICAgICAg
a3N0cmR1cCsweDQyLzB4YzANCj4gPj4gICAgICBrb2JqZWN0X3NldF9uYW1lX3ZhcmdzKzB4NDQv
MHgxMTANCj4gPj4gICAgICBrb2JqZWN0X2luaXRfYW5kX2FkZCsweGNmLzB4MTUwDQo+ID4+ICAg
ICAgYnRyZnNfc3lzZnNfYWRkX3NwYWNlX2luZm9fdHlwZSsweGZjLzB4MjEwIFtidHJmc10NCj4g
Pj4gICAgICBjcmVhdGVfc3BhY2VfaW5mb19zdWJfZ3JvdXAuY29uc3Rwcm9wLjArMHhmYi8weDFi
MCBbYnRyZnNdDQo+ID4+ICAgICAgY3JlYXRlX3NwYWNlX2luZm8rMHgyMTEvMHgzMjAgW2J0cmZz
XQ0KPiA+PiAgICAgIGJ0cmZzX2luaXRfc3BhY2VfaW5mbysweDE1YS8weDFiMCBbYnRyZnNdDQo+
ID4+ICAgICAgb3Blbl9jdHJlZSsweDMzYzcvMHg0YTUwIFtidHJmc10NCj4gPj4gICAgICBidHJm
c19nZXRfdHJlZS5jb2xkKzB4OWYvMHgxZWUgW2J0cmZzXQ0KPiA+PiAgICAgIHZmc19nZXRfdHJl
ZSsweDg3LzB4MmYwDQo+ID4+ICAgICAgdmZzX2NtZF9jcmVhdGUrMHhiZC8weDI4MA0KPiA+PiAg
ICAgIF9fZG9fc3lzX2ZzY29uZmlnKzB4M2RmLzB4OTkwDQo+ID4+ICAgICAgZG9fc3lzY2FsbF82
NCsweDEzNi8weDE1NDANCj4gPj4gICAgICBlbnRyeV9TWVNDQUxMXzY0X2FmdGVyX2h3ZnJhbWUr
MHg3Ni8weDdlDQo+ID4+DQo+ID4+IFRvIGF2b2lkIHRoZSBsZWFrLCBjYWxsIGJ0cmZzX3N5c2Zz
X3JlbW92ZV9zcGFjZV9pbmZvKCkgaW5zdGVhZCBvZg0KPiA+PiBrZnJlZSgpIGZvciB0aGUgZWxl
bWVudHMuDQo+ID4+DQo+ID4+IEZpeGVzOiBmOTJlZTMxZTAzMWMgKCJidHJmczogaW50cm9kdWNl
IGJ0cmZzX3NwYWNlX2luZm8gc3ViLWdyb3VwIikNCj4gPj4gQ2xvc2VzOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9saW51eC1ibG9jay9iOTQ4ODg4MS1mMThkLTRmNDctOTFhNS0zYzliZjYzOTU1
YTVAd2RjLmNvbS8NCj4gPj4gU2lnbmVkLW9mZi1ieTogU2hpbidpY2hpcm8gS2F3YXNha2kgPHNo
aW5pY2hpcm8ua2F3YXNha2lAd2RjLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgZnMvYnRyZnMvYmxv
Y2stZ3JvdXAuYyB8IDIgKy0NCj4gPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL2Jsb2NrLWdy
b3VwLmMgYi9mcy9idHJmcy9ibG9jay1ncm91cC5jDQo+ID4+IGluZGV4IGMyODRmNDhjZmFlNC4u
MzVlNjVlMjc3ZjUzIDEwMDY0NA0KPiA+PiAtLS0gYS9mcy9idHJmcy9ibG9jay1ncm91cC5jDQo+
ID4+ICsrKyBiL2ZzL2J0cmZzL2Jsb2NrLWdyb3VwLmMNCj4gPj4gQEAgLTQ1NDgsNyArNDU0OCw3
IEBAIHN0YXRpYyB2b2lkIGNoZWNrX3JlbW92aW5nX3NwYWNlX2luZm8oc3RydWN0IGJ0cmZzX3Nw
YWNlX2luZm8gKnNwYWNlX2luZm8pDQo+ID4+ICAgICAgICAgICAgICAgICAgZm9yIChpbnQgaSA9
IDA7IGkgPCBCVFJGU19TUEFDRV9JTkZPX1NVQl9HUk9VUF9NQVg7IGkrKykgew0KPiA+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgaWYgKHNwYWNlX2luZm8tPnN1Yl9ncm91cFtpXSkgew0KPiA+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjaGVja19yZW1vdmluZ19zcGFjZV9p
bmZvKHNwYWNlX2luZm8tPnN1Yl9ncm91cFtpXSk7DQo+ID4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAga2ZyZWUoc3BhY2VfaW5mby0+c3ViX2dyb3VwW2ldKTsNCj4gPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBidHJmc19zeXNmc19yZW1vdmVfc3BhY2VfaW5mbyhz
cGFjZV9pbmZvLT5zdWJfZ3JvdXBbaV0pOw0KPiA+IFRoaXMgZG9lc24ndCBmZWVsIHJpZ2h0Lg0K
PiA+DQo+ID4gVGhlIGtmcmVlKCkgc2hvdWxkIHN0aWxsIGJlIHRoZXJlLCB3ZSBqdXN0IG5lZWQg
dG8gY2FsbA0KPiA+IGJ0cmZzX3N5c2ZzX3JlbW92ZV9zcGFjZV9pbmZvKCkgYmVmb3JlIHRoZSBr
ZnJlZS4NCj4gPiBPdGhlcndpc2UgaG93IGRvIHlvdSByZWxlYXNlIHRoZSBtZW1vcnkgZm9yIHRo
ZSBzdWIgZ3JvdXAgd2UgYWxsb2NhdGVkDQo+ID4gd2l0aCBremFsbG9jX29iaigpIGluIGNyZWF0
ZV9zcGFjZV9pbmZvX3N1Yl9ncm91cCgpPw0KPiBObywgSSB0aG91Z2h0IHNvIGFzIHdlbGwsIGJ1
dCB0aGVuIFNoaW4naWNoaXJvIHRvbGQgbWUgaGUgZGlkIHRoYXQgdG9vLCANCj4gYnV0IHRoZW4g
S0FTQU4gY29tcGxhaW5zIGFib3V0IGEgZG91YmxlLWZyZWUuDQoNClJpZ2h0LCBJIG9ic2VydmVk
IHRoZSBkb3VibGUtZnJlZSB3aGVuIEkgbGVmdCB0aGUga2ZyZWUoKSBjYWxsLg0KDQpJIHRoaW5r
IHRoZSBtZW1vcnkgaXMgcmVsZWFzZWQgYnkgc3BhY2VfaW5mb19yZWxlYXNlKCksIHdoaWNoIGlz
IHRoZSBtZW1iZXIgb2YNCidzdGF0aWMgY29uc3Qgc3RydWN0IGtvYmpfdHlwZSBzcGFjZV9pbmZv
X2t0eXBlJy4gVGhpcyBrdHlwZSBpcyByZWdpc3RlcmVkIHRvDQp0aGUga29iamVjdCB3aGVuIGJ0
cmZzX3N5c2ZzX2FkZF9zcGFjZV9pbmZvX3R5cGUoKSBjYWxscw0Ka29iamVjdF9pbml0X2FuZF90
eXBlKCkuIFdoZW4gYnRyZnNfc3lzZnNfcmVtb3ZlX3NwYWNlX2luZm8oKSBjYWxscw0Ka29iamVj
dF9wdXQoKSwgdGhlIGxhc3QgcmVmZXJlbmNlIGlzIGdvbmUgYW5kIHRoZSBtZW1vcnkgaXMgcmVs
ZWFzZWQuDQo=

