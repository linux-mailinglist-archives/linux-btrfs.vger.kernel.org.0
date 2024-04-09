Return-Path: <linux-btrfs+bounces-4054-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7277D89D7CE
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 13:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938AE1C20EBE
	for <lists+linux-btrfs@lfdr.de>; Tue,  9 Apr 2024 11:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D354386269;
	Tue,  9 Apr 2024 11:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZVpdBzoC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kx6WZJhN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D685924
	for <linux-btrfs@vger.kernel.org>; Tue,  9 Apr 2024 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661954; cv=fail; b=UbpQpwc8ENp7GKxToXv+sXk4tzrC6u4ulM/ee6wTRKnGvfvxKuIFwtED+5neV5HvtvoZvJ+MZFebN/uiGwFmMbD2H1xooqXgU8ekgQFSRyU7bnhwiezm9u9CsV0nKKwJzobfEwpdYPcOBRkLk4SgczE8sOUOdoEGWobpoyWORxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661954; c=relaxed/simple;
	bh=1e34OJ71KPcHn5mT5eStHlYHOoscGaMpwR2XCIsmJaU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hhm2WZdxUAdJd9gpfD+BGzs0bqse22HnkVDGsyl4O/SUPzsUENvObQB5wImbgpPQJjQTDBzIzLXMJTv8thKC4wZLYnpmryCgXDPKIk8rzWcHQ18tRU8LNvpnLSrVzIRkR1nWEXhUf3JbdOKtiNXI6rhmekjDvTfEQUr6isK7ync=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZVpdBzoC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=kx6WZJhN; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712661953; x=1744197953;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=1e34OJ71KPcHn5mT5eStHlYHOoscGaMpwR2XCIsmJaU=;
  b=ZVpdBzoCUZxT94CQPjBdJsVb+87bBbzcluoSaaUXXkX1EG32d9DgsWr3
   sHaBqpXMr9X9EQzaDd81Rgh2M0k9elgM8eMCR+9mO/SaBLFzgnrN7uK+L
   BNao/L5/TT3udJ7JO3f6YOjMtN79StSf+rQAsPmypl5Lqa0eIox0mR6dm
   bkc634jUiOZnlQeGqJVg9IVxabeaBpYW32rzUWgSXpxAhdXvOYAZ2fN5D
   Wbtvj4VmrWBQnafbghiF4XagQZjaF7BdJaoDIe7+kAPlgvHMbPRaG3q6i
   neTr+4goRdL4bjr+usJaaMzJP9iFbVXC6MMx03CZBw9iLYcS9cE+SHiPC
   w==;
X-CSE-ConnectionGUID: iNvtjCbbRbKr22QOlVr34w==
X-CSE-MsgGUID: EzXaahQfQLGBPMCwgqugVA==
X-IronPort-AV: E=Sophos;i="6.07,189,1708358400"; 
   d="scan'208";a="14267579"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2024 19:25:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AapUQlIxTbVh8DO2OS7CDnTHZQiXArSlSSgsdKdrmR4AUPag8ZXr22AriFxwcsdGPktbBmyuWmTPOq0sFKAcLUmIzBCOHFCCP7G0zv2WJEHWcbZggHGhgks82oW+zUcUSSDwKUhDac3VTGPm9UtisZNp+e2eWQm+QmXlU/UhYR55sZFEFjKFg16Dp+fWWFBHoWxxtiM7WtUZ1tbIjTdpdr88XX3pl4YCnIVbq8KQYneLdaCJPvF2G4mdRLhSjCGYFatuEmEp4Ch2Y5FPJXD7vgMJvlnPKm+UU42PZBHGHKkM3k2FjPndpePsqZ+1WAPFqHGqKgjIsR3Jc6cyvJ5yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1e34OJ71KPcHn5mT5eStHlYHOoscGaMpwR2XCIsmJaU=;
 b=eUNFoRWHTCLnEyRIggokUZmgNwEX/C5a4TDQ1FSjEmDcLYVPokcVtucPqkuZgHG7ORWqlXtJzM+BOSornpjuFzPlaACPN11J4h4DeU+XEfycBScUaex4EIkKgdEUNZ+7Bje31FeKX/55CUrC0S5AAN80bvy7B4GZ8k++Sxs/ZeR0tmwvijosD/Nc2Baorr+dbBhivQh4rpHEm8pRcVCRpbxl974Bzy8Ni6uhy08BNWg6//bYMvP4vvLQXHGQ5RMR+zl4L4uNwgncrbFrunAhduL5ci547dbXjX3e7zZE04Q6m3g8fczzW4j+IE7ctmlKrX4SygAV8K3jqFIr0qZaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1e34OJ71KPcHn5mT5eStHlYHOoscGaMpwR2XCIsmJaU=;
 b=kx6WZJhNHJ75QDQ1mWNQcKCYWA2/QZtElYp36B4ZnOW9cxL2VGVmJV9sUd5lg+bBUtYH5+RgqOSm8iysBPil2FmaKdGqCEG7l9xmqKHjxoTyCktyGbyy89EgQngglMh4ioGoGBgl1lF8B5q9dz+vMC3boDMyYd78hItyKryEbr8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8244.namprd04.prod.outlook.com (2603:10b6:510:10c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Tue, 9 Apr
 2024 11:25:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::48bb:3ec7:409:1907]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::48bb:3ec7:409:1907%4]) with mapi id 15.20.7409.042; Tue, 9 Apr 2024
 11:25:44 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Boris Burkov <boris@bur.io>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 2/6] btrfs: store fs_info on space_info
Thread-Topic: [PATCH 2/6] btrfs: store fs_info on space_info
Thread-Index: AQHahf5dbWzMCLbK0UqbvV5NSO4sy7Ff1VUA
Date: Tue, 9 Apr 2024 11:25:44 +0000
Message-ID: <6f207984-8d9d-4421-bd0a-b2064e00e383@wdc.com>
References: <cover.1712168477.git.boris@bur.io>
 <6f56853ca8437b8dd7d343adff2982ad9b099543.1712168477.git.boris@bur.io>
In-Reply-To:
 <6f56853ca8437b8dd7d343adff2982ad9b099543.1712168477.git.boris@bur.io>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8244:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 aM0R4EbQjg9ZmmhMTlB2sde82jzxn3sl9rjcLO1jAxXbxkg/EDsihYTZgOcVKL/+ai9TI/jgai1PQ0mwupeDh0C9HYHBiHHV0EfSkvbjbpuEKAE8hF0hy+uRpfya4p9MVpMbZJ5IxkSWChfLEiqWKcZst6lUGT0ZZri1jQMwffTC+mGmLDoW8oWlZ0hZfYEemS9xUcQWC0StQdGr0etjlqz6xWDPIUQneo5VUiapffl6aCM4h0rloCDs+bw3+jf+Ogi5tDQ5xxLhzh3a44+3C3QOUNDc/BkaDy7kmOEyJ7Q7LeQcRBgcrOUzXTRwWpAviJqazZIY3AGkZG5GzewEleVhXQm4mrR1mAt4yvAqr/crK9Iw8BPX7eyKkA5CNxfRrjmFs/DYxYZRRPQlSI4cIoMrpE6+c4dFT0VDkgDl/P8RjM187zbgGasLwCMBA9h8VZON7jwpBFtZUyzrqnyhdfYu7ydBOkB6IRrZDhv5gN2noczcCEnlbW5+xYMOJRgIGrmVSf/rol1IPtZb6M2nWxPoMWrBLm3khkmBAk0v3ah9iEJyzbRwnnVtfWCg8JSnqgq6AdorDa/5/WDIidV+2AUTbr/xil7iHawLqBMRdXfuEt280P7dNHuXfJfH6oSMpbTr3QtTgKd4atxyeWEhAMiuaAh6U7iAJJOMQqtBnYU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VCtSSTJVdUJ5c1hmdGRQNnhnYm9DTEFwcnJWSTZKU3M2MnVSSkt0S3hUZ2l3?=
 =?utf-8?B?NlYraS9qN1JyQllyYjdSeDlvY2EraFg4TVlYQ280RHJjc1I2RTVySTVvQkxm?=
 =?utf-8?B?LzRFWWFqeVBOVUZKbFZzS2VJNExEYlhsQzBPWVdNMzFlUUtXbjhSL1QyQmNk?=
 =?utf-8?B?RWVEeUFhWEpUL2hzLzRVNVFDenFaZ2dZbm5iKzZyMGcrKzMzQ2VZS2RUUFl1?=
 =?utf-8?B?c2lUVTZGNUY5TUpzTXVaeDg4NHpTaCtya2pPbW5hUHArZC9iQ25HMnJQMEVk?=
 =?utf-8?B?QUQ1Y2k5NVNPa3JzLzRoR084QnIvSUFwOFJNYVhYSTlPTnovOWxoSFNmOGJ1?=
 =?utf-8?B?LzcraUh1NmRBdkwxQWNGNWJZaFM5bFozREtNa01Fc0dCd05zV0Q1WTVQUHBo?=
 =?utf-8?B?NUpJQ01DMFZqWnIrTVF1ZDNHd3YxaHAxNlVqY01YbW9kay9RcUJKS2RpYzZG?=
 =?utf-8?B?VUpsTXFrVmRueDZLZFE3a20yMFJHL0dWMUo2WFZzbVpwTXl0SFhmaC9JbVNH?=
 =?utf-8?B?cFUzZTlqejljbTdqWlFpeFArRFJuY2xVNlpJa2tia3lmV2RuUmNaeTJ3OWtN?=
 =?utf-8?B?dkhRMW1LYVFPTkdTMk02VVJFT3hmTTZkODZMTEwwZkd3NERXR3dmQktrRWNV?=
 =?utf-8?B?WFFFYWczSnlldW5BSkpXd1k5U1BwNys2U2tUOXBpdWRnRnJNZWd6TEtkWFAz?=
 =?utf-8?B?dFJwM3FDckpuS3JHSjBXbThpRklWczBQblhEeEppaFIwdEtCM2dZN0JiTUt4?=
 =?utf-8?B?Q09SaFRybE9KUmhKWXF1dmU0TEduSk5UWTRVczNGSlg3UWUzWUFUcjRyZHVz?=
 =?utf-8?B?S2RWN2lwK00zZDZ3NHVZV3VTdHE5UnhweHR5Q1hEbTJnTnlxQjFJMSs3RnBs?=
 =?utf-8?B?aUJINloyNFd5MkJtdm5LSnExaWZVMlJZcE9YOXhHQkEwS090NExwczRvUVNZ?=
 =?utf-8?B?TEhoOG8vaVN1ZzJyb1ZnbGx4S3RvbHJGVUlDeHlXN2ZxUlFmSDM5UG1PTzZt?=
 =?utf-8?B?UTBrUmZPSTVBeE1uaks0M0svNEdwdFhFYytOcndqT3VEZ2ZXc1Q4Y1AwZlpw?=
 =?utf-8?B?eUxwMG9OTXNZeHpZbDhWbEZ4QnM1c1lDK05CZWxoRlhPVEZ2Ri9PVUNqVDVs?=
 =?utf-8?B?ZDVQY1cxNm1rQkN1c3NwRzhNZ2tVOXF4cFh6YlArZ0FnN1UxaVFtMFhyWkcy?=
 =?utf-8?B?OHlQT1NHWEVyRXE1ZXlUVlRFZzdLcFJwK0NxMks1T3V0bWs4c2hSdU5CVVpt?=
 =?utf-8?B?WDlqUnFyR1FpRlFxYXdPcHdINHMvNWhTVTVVSXdUQVR2TFpRK29GaTNzN1o3?=
 =?utf-8?B?UjlUUVF3NlFzTVZXWmd6MDJVMFRVTmk5djhmRWl1L2V1WS9wVlVFMUhqTzRL?=
 =?utf-8?B?M2NRR3BqSit3YlJkUXp3akFrdjhvMmlNRjBZZ1pBd1JJcE41am56MS9LUkk1?=
 =?utf-8?B?U2RobEpmbWVGOU4rdWRjb1lEQmRKd2ZDbmMrQkpBSndhVWYxbHl4K01SaDdQ?=
 =?utf-8?B?RVFENjI4bldJU3RpU2owamQ2ancxYWVHYzg0dG05OUdaTS9HQVc1QTg4WmlK?=
 =?utf-8?B?ekhZTGxjbUJLL1Rxc0s4a3hBWklzYW02SkhPVWhST3hFTG5idGVTK1d3NG4y?=
 =?utf-8?B?Tm1MbFp4R2JNZFJtVzlPZHJiM2lMMitYcDdRRjRWNDQvaDl2ckI2MFpsOVhv?=
 =?utf-8?B?TzJnTDhwVkNCeEFIQlhnZlRhTjJud0J2NFNSNVorQ0JkcGJpaUhmcENURVNk?=
 =?utf-8?B?RU1SMmtWWFMwdDM4TXEwemhUb0h0U0xtUUZteEx5bUNFRzdtclBZWTgxMnFy?=
 =?utf-8?B?MHU2ZVdvNHhRUFQxVDBJVkExK1JBUkxjOUxHRGRWU2M5cjdGVS9QQVJqN09G?=
 =?utf-8?B?WldMSXEvTGxQUDM5eC9jMFdzNU84NFVsWWxIaEljRG1XZTdhc0JIYzVFR2Y3?=
 =?utf-8?B?VXdaVE43aDVvT25uVmlqOTI5U2JEUmdPZXNvVG1jMGtidHdvbzVXRTNMdVBx?=
 =?utf-8?B?Y1BVMVdDb2tlaFFLdWQ3YmgzVHdNUFlDNXY2Rm02a01OQStTcTRvdmlEWlFE?=
 =?utf-8?B?U284azMyUDBLYzhxOUFNQW9uUXFpNkFjUzNKQ0pZcStUK0NSS1FKZG5pNUlR?=
 =?utf-8?B?cGtHNmJDYStodnk0VlJobkJYa0ZGVncvb1BWczJ1WjlQT2JWYnR6azNSU21a?=
 =?utf-8?B?aDJJcm9PUENWOTQ5dWVINTF1RWlJTGZrQmdBOE9acmtDYTYzUFRsY1BqRG5u?=
 =?utf-8?B?V1dXR2NjTnRYM1R3QTB1UU9jeTZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6A9163D2436704986073670C685647C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	51K2Jnx2ywNFbeGdS929f5veyHUYneHi41heMe2BNR53a3GVo50Ut6LweFsn4WAY8Vi5DZTCGSA6fkdwcd0Wnyb+zXVNUDRDpGln1IvQhblpDV9vXW8SrIsSfCiUIgLV00SJ+hpSXhH0kGoJfTcp09dBGsgkePOWjAqlJ6c2EN9NLVIakGgIuz4Elq/aP+6wESteYNJM10EZ8EqwBNutuvpxQeAEgpSNDk4HSjk0dJgBqg4mNSauc2N6jrxCpK1ErwBIjuPEB8FpjTD4T5pfPcTaadb7K1LsfpEKYAcLUsQx8O6hDM2Kqe0+DI3R2Fs5hubkng2sLKQg4E+QU91+VPZCvmoc7gUnA350WX8O8rWJzYAdm2ocFRRCB/yZD8neMxfpgbY7R2qcYhtZkyFSrrNB4JT/gd+b+K6mFlquHVkET1yxgVcrfm76+aBeOWmUtFfEPQYKisYH2TfmRQ4+0y7w/L6Ym5+fPLn55O0rCVXfyM0HJzo+m6uoRpmymIL5RQDRBMVJv6ORjTD1cT6XZQpYOTz5yNMKFtHBrpZaqWoMBQqkbK5fEwapdeKr47KNnjzgMTw+5zQlRhFMiSz7ihButeGYAss+59Mc1BrdNHfDKPONlSDY2X5RjkBQC/Yo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb27f315-1a88-40f8-d16b-08dc5887cbcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 11:25:44.2555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WXRsecW5qxxrPPY4MRt/MKs5QecevRK1UAZMmC4E0t/geVVQP0uqXN+NJBCa7Rya1ntDUCfsgVlks8EWvVQTsLcP8ZF0kbVf6AyvMO6vYzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8244

WWVwIHRoYXQncyBoYW5keQ0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5u
ZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

