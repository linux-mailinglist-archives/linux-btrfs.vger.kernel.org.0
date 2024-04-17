Return-Path: <linux-btrfs+bounces-4379-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E93818A889C
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 18:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1744F1C225D8
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 16:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CCD146D59;
	Wed, 17 Apr 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b7kBG8Im";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nz9fAnqu"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EE11422B9
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370497; cv=fail; b=gdO6zscI4VuIgCJSWAcFa2/mZDC/jCclNpVXW54cRZzEebmNZ8EG2W1rvsCvq1/kvZvMtXIWL+Hu0O4849nmZnCyGlMyOzYaKMWqiCHlfTLLRi9toqG3AFvXLNSggZKhVVVv9twtB9LCkVoYVcbM7k4zsSRIpVqWmueuq4b9QKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370497; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dGsoov8OXk3rbKNXxh2zZUx1TkssH08mKkX3ZxdlznbB7pPTAQYSLM4Mu5kvLABy9RvM00uTWWPjGeAzPQS8g1CeN08mQkR5K72htYpmHauLIvT3ftQHp74LsgdntGWpJBOXnxzLkkUYD7/H77hs+fR/XY18ufN4s0haaYFOW/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=b7kBG8Im; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nz9fAnqu; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713370495; x=1744906495;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=b7kBG8ImmNDj8W/6lbpCsH+HVHce24kYMBFhXGT3vNkk4IGL8yjklVqA
   v53xExnaCs2xGQrFA12YYKK1ZLSpo3vNTigqEverq9XGNxEaWQdYbfbHe
   kPnpCL7AnINMeSKX+oyy+EnIWbufqz6fTXaBNZEFBPVV212V4+lWRAhYp
   ynEnNGpPrBJkkVGrXSOmHwxXK1O1FUUYu4SFYrfnXNXVN1speqPEgN+KV
   SVhnCO89KKQtok6+eb5FpfXpD5gDlC/lWgfPl57esxKyKi7YttzRoQbpZ
   UbM7jIpi0wivx9r4xeaKLXnKbc6+PqKciGYd9NY958vY5SkudYNf2nwls
   Q==;
X-CSE-ConnectionGUID: o3C6dj2pRXm08Vozdf0iPw==
X-CSE-MsgGUID: vaC+hiCuR8KFSzTeJ2W/EA==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14236791"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2024 00:14:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f49jB9Lo3UqKUTixMPsyZ1rMqA7gmVOcHw4G+OMXAYWW4GmRdAXmkB0mYZuVh4GEvIXnnGdL/+8JqrpfhLrXxZVUp+hFV6HfG61U3Uc+Y6owB3iH0KuV6GdIhwCkTljsT++tdyLaIH7AkpgQ+CG6HTNtivqh+HqfjyYXx7sNe+ybp+Cmw7auW23jveOWQFdmiIfFbKnLKGAACZE1EcIAcDD7u8S1Tq8jmmzzyooEz9NflUYWI3VifjZppz/2WKBEbjbAWh5ZcJ1XmBTBVbTR1boeRZ9QGOTKP6IR/VruxW6bnWvI7cX9eOr92kFrE3+2Ilu1TGMaPQ2b03AlHryIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=kg5AHqKixCHih86MvBcWPFGNqoVvQ5ZkL3tqPrCVk8DtpEH+RToqlTzTqWcxpdxRCbmxY6lfipXgRijVF+4f6WmD6moBQEkblN3xi9NcGnelGfEAF2Sue9yiLG/hDrZN33yjAmJ1mDk1Irt4ZSi96QllKLA7y2SRo1NXptZfv3huY8uJO3LVgDzc6xXSl4HrdZaOotnuMY2Z59MwOAn7g25ml8Ng6GbDBkFcbGrGDCCn9/WhRXbnj6BwUTA4tfnVIKu1clGNhJiKEj6mj+iNRqKP+RQ2ilWNTVhI8N7hvDG3c1hRsxdM6sCCbNtI4V3IfCTkEm/JsAZst6O1rZJ2Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=nz9fAnquYvd3kq4/O4kM1pD1lxWCL5OYyRyH3j7FuN5f+cBxToybZDC4QsNk3b2Qz/U4Dm/S+HYlNc0pDK7L/6UQwQB+gkQLyAuPrkd8kcYfqCHdO5qNhi7gOme9BPWwChYUqUmOjlJgn8nd/PC3tDcI3ACCYVTMaHN1oNzG/1o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6465.namprd04.prod.outlook.com (2603:10b6:408:7b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Wed, 17 Apr
 2024 16:14:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 16:14:50 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 03/17] btrfs: unlock all the pages with successful inline
 extent creation
Thread-Topic: [PATCH 03/17] btrfs: unlock all the pages with successful inline
 extent creation
Thread-Index: AQHakNSnUVD/7VcQbkm5UEH2WEiL17FsoxUA
Date: Wed, 17 Apr 2024 16:14:50 +0000
Message-ID: <34d0a2fa-601a-4f4a-b712-1de51f79d786@wdc.com>
References: <cover.1713363472.git.josef@toxicpanda.com>
 <7e58618dfcb81c8035c30b814b881fd957f134ae.1713363472.git.josef@toxicpanda.com>
In-Reply-To:
 <7e58618dfcb81c8035c30b814b881fd957f134ae.1713363472.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6465:EE_
x-ms-office365-filtering-correlation-id: fd4bafdc-66e9-46e3-4126-08dc5ef9827e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zpJTNzxKnLeJNiNk54QzDMH9UyyRQB+MVq2i+KsGuDQo7iqMrsw2B6HUgj3nwhQ9xE4tvCkxhibZ9g1srzD6hCdWbBk8V37CUfJ2FRCQ0uzHTRJ5s5tHnssbn6e4UdYyziepHM6qTILqUe4lM6s4BySS4JLV2VI/LhMaDcZ1lkEE3SP4E9HzbTc6MVqjRJmwE9XVvE3EWndlp+UdJ5ry6GzCaEYwLB70jlG8scz7+RAs1OFVdUlZcEjrPAYSNpsf85A+ucoRz+CDP6jsFweSCs1kyDFDZ7JuSfUCoE92+1JeaVLWnKSbhEd9a0dVAYGPjnsIGuGBQ6yMIg9MQgC8y6PeWYBpGJXfSB2UfiDBzFBvd2NE7axb8+mXJDh8N6etJ9jTnTvNsRZon6lZPBO2CC6pXq7wOokyBtcC7pflrdqLyl1NQqk7HvyRq3YO9sQx8ep4K2lV7ml/L+DjjxWbj73pfCLWdgYmrt4neqy0O6lmjJnlFFFCxQ9cTIn+5UkEGbmhjWhzSVYgl+DleYW29Y7T3Oac8M0rM7/PTxnHduDHcdOmoVVT3tKU/RuQq0GmVUljM1rk2GsfAtSvnV9R9G1jkaVa3xCeAEN7AH/Wn9jXuc6ubu/KqZTZfIjQAFEh+OrgxlVDhW5qCLVHgiqKLsOv7f3KTMlKTZvdcnE4DScE1eiys5gNQ8CnZqr0auBiPDzQzuqL8HqzQe1VoE/Uxtb4Hn3+PjigRIc6RcGucjg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2hGR2M4aWhlQytJQjN1OTgvQnduVXVBMTFYK2JDWnFqL0tJWEVRLzJGdGFU?=
 =?utf-8?B?Nkd2a0ZLZzhHMm9sdVc4WnVBd3F4WXhQSGczMWVvb1hSb2pkc3p2Vk9OSXYz?=
 =?utf-8?B?dlRIbldnbml5ZGMxLzFnSnZNRXNpaWNsWitOL2NOTHZwR2F4OXcxaWlVY3Zx?=
 =?utf-8?B?QkMvT0RmbFBNaGJaaVJLZlBDc2tHdzZ6TkJGU2o0OWYxRkI3TU0vcDBzZmdj?=
 =?utf-8?B?ZmJubDlObW5aUDdaSkF1STJtTFRxMStJd1BvZHRISmFVUHVlZ3hObFJpeWxC?=
 =?utf-8?B?K0hxVkNhK3JNb0NlVHRIYzNMVmxXMzRmNlpQTUI3cWsyUFlTWnROOFI4TWxC?=
 =?utf-8?B?N2o3enc1UGlyR3Nwc1BpbWVzL2k4S0NKdkZKWnNzMUgwZU5hdXhhNVU4b2Rl?=
 =?utf-8?B?ZmJJZFM2Q01HMVBGallreGk5cEVnbFVPSUNKTElrNlR3UjVRU0xROHBTT1hs?=
 =?utf-8?B?Um5GbFR2ejJLenBRMWxEV1d3RWtaL1JyMnpnbjJWNjZEVTlXd3QvMlZodktI?=
 =?utf-8?B?Q0lOc2pCVVR5YXBRWDVVNm14OWdvcnQwSUx2OHRWT0JJR1FqaVpJRVFsWHdm?=
 =?utf-8?B?NlhyWGVjN2hPdHQ1R3ZHZHdtWmpqR1A3MFdIcUI0RUVBT0lNRkxsRk9oZ2lC?=
 =?utf-8?B?bFBvZlJ4cWNRbnlHUWhWSUl2aTgrN1FXcVcyYnJOZHp5TDAvM2FaUjhwL3Zy?=
 =?utf-8?B?cHA2V0NmN1U0QWJ4dVp3OHdMcHRpZFFQV0dWenVWYXEyRDI4MDN2Q3J0NUJu?=
 =?utf-8?B?SC9QQnNaeS9mbEJZQ3lYT3ZrMjUwQU1VbHlYUlUweTRCUDVoSUtjZDRjaVVE?=
 =?utf-8?B?Mkp0NUZYRktSLzF5TmdNU0JxV2k2V3k0NzQ4THBFdzQzNmhTZFZUU3JjZWZy?=
 =?utf-8?B?Y1B4eTkzY1BFR2x0YzIvOVNjVVRlN0FLTGh0eTMvc3dNallQSjJoemdRT0F0?=
 =?utf-8?B?WTlDS1VURFdkV1RqSCtaZ2pkbG5YdEVoNG1DeDVBbDY5SkNLNlJDQ0NscGpv?=
 =?utf-8?B?Snp2T1l3MFd1a0ZqcXR1aEdEc2hUa29HL1N1aUU5L3NvWHFweXVYNmt4aTJ6?=
 =?utf-8?B?aWloLzJUVGhmNnA0Rzhzc0JWY3d1b3pReTBvKzhtOWJ3QjJwb3FDMFdoWTdN?=
 =?utf-8?B?Q3g2ME1tOHlaZUFIZWlRa2Y0N1ZQcktjd2hjUUtUNWtwRWNMYlEvdXJ0b29L?=
 =?utf-8?B?Q3p2T0NQcHdXUUJLVWRMc0plSkU3VjQwc21BcXFmdzRoclhzY1F1c0JjTnBM?=
 =?utf-8?B?ZGUwMjl1Nm1pYjlQVHo1eWxEZGo5Qk9Sam9taHRKSnRSR3R2V2xKSDBCczNU?=
 =?utf-8?B?dW9za3hQQmNvWTNmZWszZ1phVlJxWTU3cit5ZExoM1RtNFlraGVKVktjS0JL?=
 =?utf-8?B?VHB2K0VYMVF1S3pGUXVZUzlEUG1aL3M2S25nVUEwbk4zakdaWE1iUHNsYXpC?=
 =?utf-8?B?d1Y4ejFWYUxMRWRQMWVLNVBacS9XYm96UkliOWFwVFlHTlRBeWtlZHQyM2ln?=
 =?utf-8?B?ckRnTzUyaGY0M2FoUGs0WFZnR2FadGxNbDlOOHoyV280M2NqQXJWYnVQRFAx?=
 =?utf-8?B?OXV4OW93c2pod0JsTDdXcGFoNTZsY2dPY3VwMS9lN3R5dzMvdXZTSFNPejln?=
 =?utf-8?B?eWZvK1hZNS9pZ3dZVisxSmFQRU5WNUdVNmFpeEpDeThDamE4b2RKZkp6UGZV?=
 =?utf-8?B?amJFVHYyYVl2Rml5ZXVIeUZLWXRGdVVPTEdWSlJSUm9XZTFyQzk5bTI1Vlla?=
 =?utf-8?B?U0xwUGhMcnpqMDJRYkZvL0VvMyt3YkhIYytUSitCZFJCc2lyKzJFL3lsUWhs?=
 =?utf-8?B?amlaa0haeGp3MFplWVZsRTRVNXBUckdlanFmeUNwWWw3cG1mL3pJQldsV3or?=
 =?utf-8?B?ZWtyWDNxVGZvYkNMWHFIY1NyZDZHUFAxQXNHcXAzRFNwbUVyNWJVUjI5MGtW?=
 =?utf-8?B?OXRWa1FBbDNXdlF2RlQ5OVVsbDJHTTU4ZDFtL1Ezakl5UEswUlFHbjVtc3V6?=
 =?utf-8?B?ZG1TR0pTdlZBZ1UrcndFbms3VEd1bkFrbmk5bGdwV2Y1cTVSc094TXhrUHVo?=
 =?utf-8?B?K09GZG5iemU5TWFNaDRHMm05L1IzM1JEU1Z1ZFlJaFZ4VnBkRmx6OTJPSHpo?=
 =?utf-8?B?a3BsQS9DZUtNMnpvU3hLeGNWeW0vT1lVdzVPL29rTWYrK0Y2T0dla0ZUU2JX?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <254E07923749DF428C69BEB51C34C098@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	IMHxUA6p3jm7qng9aXxVQkuXZdwIPb4fHzq6Ixflrat4ZKN6YkYPcWzoEiWNMtzPd/2tAY5EKHgoYrHtHGKMuiJwyjzP5/mK1tUkA2sMMCQ9PJ/AZdLQh6D61Jp8n4S+pi9rtSXW/Lf/ibpx+kyY8SBJ+YeN6K7zKTl4c5AbCixsmXaSpmKeH4464l98A6eu8wKZHUm9XRuxQSXsqt3ozAt2YjsAS5Zc66gzzg1VsmRJejIKZuOWJmP51Lx9jVE/v1sC4BOvZXpFG8nNvAXjdAroQarH+jIynJfBH/LGd7zDMzgFXVsHAxVG/vIfjIuqQG4Plu4WV8+/hJDG2o8u0Q0k2fhxl+E1tdq7tcFOIp53/OUaa0jr6RFFSAVPvxirWJ+tWAdIxH/Ca6Z2p6gZ2acfhICK/BSltMkn1IYlKUX0PSOl2KG+uWUJCSgt3BX7p3ahwnHj6pyiE72Bjl9DC1GuYRncoTgpDBm0GwWpo0TGbEetr8HMRKRrBdk8Wm7VxSt7jsxeOq/2C5BeIHCg0GiaHRVfvTlaNBZ1LC2FQVlWkp/X9UB4JkJy8i4j5fvY5s1IQECvWUKP3nBdPDTFjIMJGXgC4hjgBFhwaOQmThM3OFzGx8ixTaFpVEnoCyeg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd4bafdc-66e9-46e3-4126-08dc5ef9827e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 16:14:50.8922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zTGWfLa06OPvMrfjjU1bg8zwAgHp3RNdIL8CedoYzHiUendjiu1O14ZsatNm6jfuXJ8Jfy9ogJ7bLIrIHUbWceAY/5Pxw6FswefSOrV8qxw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6465

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

