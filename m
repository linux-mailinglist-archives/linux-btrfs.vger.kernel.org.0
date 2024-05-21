Return-Path: <linux-btrfs+bounces-5152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358188CADB1
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 13:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2751C221C0
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 May 2024 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F55757FC;
	Tue, 21 May 2024 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="M7rZJbk2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QDIOKhEB"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421474BE0
	for <linux-btrfs@vger.kernel.org>; Tue, 21 May 2024 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292460; cv=fail; b=WwH0eAI23H89KzmOnTUF8j7AGY7LNrVHwbku/1TlR8ucRORuLWMQ55d/D/6MD8MW0LG3nQ0Pajq3U/h4bqKVr32LQ65NGZqQWlw9iwIbkIMXshPCuIvqq9+zbfyNFTM03VOm1HXJX4sScOoeS+Pk4M/Y8e7cJkRpSYvqUPWEWaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292460; c=relaxed/simple;
	bh=DOh7Zm144XWb/klSXglthLCQ2pIzj0JtzKN5C/WpHzM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGqvmUh7+AxZE3iFK6NTiWkEXrH+SBugFMGpkPxUdD3bDtiPJFG+bKFiJi2dMapjfETVLq+AIZRNXtaTHNnA9YrbNBtNC3JxHF5omZ1yfUQTxdV0cg1WtD6xwZcbbyv9mT+5vC8G7ylI20HA4Z1TfewiWo0BlMRbn/q0II+XfMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=M7rZJbk2; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QDIOKhEB; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716292458; x=1747828458;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DOh7Zm144XWb/klSXglthLCQ2pIzj0JtzKN5C/WpHzM=;
  b=M7rZJbk2aHj8f7kV/jH1aKigsml0p+TIKrMrF7fYGbRAJfG1dXIC7/Eo
   DK2CdgD8iXsPH9r/kh8hKUq0CwzK/FTPlu85MCwpQoSfFOLCGDAAKp+l6
   L14f8VfFT9hPAsG02VTqc7Grn4D1YlRM+sSJcyx2pfGVYItCBWZypCyt0
   EFBXwU0WocL69VJcMP3BvWYSam4V3c9eDNAEPS4drrWQNo0H6QrPnYyQt
   Cg8gFojkbs2ot9bv1LtA+OpWngp5oco8IumsN6HaDKWrSX0sslsYq311o
   N136mZ/4PLTl/wrwIjj9tpZ/bNauCvy0kA7yrgYMwGu5r7VEY2aZdQ/Ul
   w==;
X-CSE-ConnectionGUID: tOzh1LKaShatkZUmPaDetQ==
X-CSE-MsgGUID: f+mk87HbS+aKzonOtmWCVg==
X-IronPort-AV: E=Sophos;i="6.08,177,1712592000"; 
   d="scan'208";a="17679639"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2024 19:54:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1DeyF5Pj3Qj+0aZxVRrKidpEZi9LK5Iz/BpgFo/XxnPCpoy1ZflBJJgkakXFWlneM5PRx01qK8EA64sfOnV7XoawGtmbDygIuNH5YjEBptM/JC+Siol/QKavyizcPcSZnL86Wl3wVvCrpBa1kr84oQq8LUUSx7Rs8+h5EUZhj76YrzNYv8QlVAucb+4vwqpsPqk9lthtq0Op2ey0KtrtRVgF1O6HJGA+ltG3WPVnVHM0DC7ZCA9SPDIVTMdhfeNbieaWtp3YJHjzlvdbgWQLSK4YZo4f8PZE4K3u3iqYC+hAULbF2AkdavjYIXpUAwEXjngGGhxyRFfwUDfqZ1Bgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOh7Zm144XWb/klSXglthLCQ2pIzj0JtzKN5C/WpHzM=;
 b=CpszZplkCRCc9Km2AbgWnAo6Lx0JrshXE6gPWiy1JX5rUgT6iXmX1nJkct5IprAa7/hBCHr41vfFebTxbroV3Wa9uMtN8Wn1Lz1JGMTuDwkSz30KsaXL05rFISkAMlQP5TCTOAEYzPz95RHBMRHgKmSrhgYwmBXGwOX8Jpzcm2RgDWQ5U6EnmetAj7Olb54b9E0n2jk0VT4glW93C1vIK/hVPTidj3OJVtwg3Nb2t1Ikb6soWyhOG0kGH+D0g1ZMGpqiE8cjdjBcvOK6HUPWHVWWDaZhBWvoFs9K61mcnB5PYhg89/vwlVO5Jua+WUMJVWws+5MRwQYZ/jLAQHttkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOh7Zm144XWb/klSXglthLCQ2pIzj0JtzKN5C/WpHzM=;
 b=QDIOKhEBkEhox11iHljguuzkqmek6STZ1VrY7O97O2bAOdFj9Ayg4JLdPe3Mevh5hqiNXyhOLqQ23EZ2xysOu7ZFubAmjsduhsf30z7UqRgf6cHtL0sqVaiI2oTq3h41Ds0wsHnvA9yz/5da2QdSdEtwc0SYAvLkgWZ1uwAdNWc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6955.namprd04.prod.outlook.com (2603:10b6:5:240::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 11:54:16 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7611.016; Tue, 21 May 2024
 11:54:15 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <wqu@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Johannes
 Thumshirn <Johannes.Thumshirn@wdc.com>, "josef@toxicpanda.com"
	<josef@toxicpanda.com>
Subject: Re: [PATCH v5 3/5] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
Thread-Topic: [PATCH v5 3/5] btrfs: lock subpage ranges in one go for
 writepage_delalloc()
Thread-Index: AQHaqOFs5z6tA+7MAUmGvzzVgUkS6LGhW0gAgAAJbwCAADS5AA==
Date: Tue, 21 May 2024 11:54:15 +0000
Message-ID: <tdxf76yhloruo4pubudlhr2p4xf4spvmhrfsf56jfzxh544id3@fcaaplcp6vwp>
References: <cover.1716008374.git.wqu@suse.com>
 <b067a8a2c97f58f569991987ad8c3e9a2018cf06.1716008374.git.wqu@suse.com>
 <7oxv5xm6n4yg5r523pzm7hxql5pihrfylrducrsiwlk5k4jl7a@wxvlrl6w6cbu>
 <30371f39-18b1-4c3f-af31-b4927eab99a5@suse.com>
In-Reply-To: <30371f39-18b1-4c3f-af31-b4927eab99a5@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6955:EE_
x-ms-office365-filtering-correlation-id: 64d954ad-ae9a-462b-b282-08dc798cbd53
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFlOd2RPV09CdTc2WndyV3M4SDNpdkU2dk9ncUQ1VUorbGZCRFZzSWhGZUxX?=
 =?utf-8?B?SzVXR2RBUU9HQjMyclg1dzA3UXh6ZWg2cGRFbUEyQWE3Y3kvSElvNzM0VzNC?=
 =?utf-8?B?ZzBNSFYvdm5vb2ozaW8vTzg0QnR1K3YxRFBoZDNveFgwNVN5QWlPY0hkbXZ2?=
 =?utf-8?B?azJ0M2RrcjhDYjNVVEtaU3lBOFN4Ulp0YldHQzZlV0ltWXA3RUxHdEZZRCs3?=
 =?utf-8?B?SHNHVTR1am9WVGRPSW1zSm56U2VXblhyeVFpZW1RejBscHB6dmswa08rNVhK?=
 =?utf-8?B?cjg1M2RtNVA2Vkc2dldDT2dRZkxUbzJDM095NXJNOTdLOTZ0TFZXNXBNUVlz?=
 =?utf-8?B?bXN3Wm9XRXlFQXJYN2xKVkFsaUhudUREVzJiMDdQL0trN2lEemZhamdkemxV?=
 =?utf-8?B?cWZOTFhIMGFZcnRJalVWdVlTRDdpMmhxMzg4Nk5GNjVDZVdUcVV0Q2lCLzlE?=
 =?utf-8?B?NFVyYlFKZFh5b0w4TkhnemtGc3ZqOWtlVzUycGQ0SGhLQkdaK1VvYlpkOUxl?=
 =?utf-8?B?eGdIZU02cUZuRHo3R1Vybnk0ZmdFWXI2Tnl6YURvVys3dnR0RWowZzZCTWlU?=
 =?utf-8?B?MDIxOFBOQmhxNjN2ak8vNjhxUTFaSk5qQjFCTG5LZnlzMmI4dTFWeWlVY0pv?=
 =?utf-8?B?NzNSOXhaZnR3dHhZMTg1OGlocSsxWUxCblV4cHlTWWRNUit5S0NOcGt2Zkp6?=
 =?utf-8?B?MzF6YmloTjcvSFZtYldQb1grUHdyRFNlTFpXZ3QvRGJEN1JsTjRjdkk5aUdP?=
 =?utf-8?B?eWxaUUQ2QnZ6WWlVWmtVR3prcllmYkxkOEFYbHZrM0FOa0tJWERpaDJteU45?=
 =?utf-8?B?OGhsYktvYit2TDB5bEJMbHo0KzRMYVFYU2tIZnlwS0N5RnZOc2M3Y3IvTEVQ?=
 =?utf-8?B?RzNuSjdkNEdpTlNOaksyYi92TjdpM2pBTnJIenhwQi85eVozTlFPVGhmc2Rt?=
 =?utf-8?B?N2RPN1VScHZ2Q0VhSjBWNGYwT296V2Z5ZWR2Si9zMnUraVM1K1NGQ25UTmti?=
 =?utf-8?B?VnJhT2Jwa2t2bzFRQmFxTGNKOEh2VVdvMmttaWR1ajh0bGNnY2ZzYU1nd1RU?=
 =?utf-8?B?V1lGVkd2NzNkZWEwcERGa3F3M014NVFjUGdKSjJmNlR2NWhZWTdUZ3hLdDVi?=
 =?utf-8?B?VWQzWnpFbDdwRTJ3UUMzaTBRaVhCVUFlMDhJNWM1QnZXSHBQNVNrVndsVXJV?=
 =?utf-8?B?ZjZ3bDVJZmRVWnBvL2NXbklPRmZlNU5xZWtreVZQamNHVSsxSHRqUDVLRkli?=
 =?utf-8?B?MlpjTVIrUGlPQnpNWjFSSjlpUHZvcXRrWnFkWEJ4N0pSNFZCcnlwY0d1ckty?=
 =?utf-8?B?WnZMQ1V2Y2playtERkxORVJpc2FpWFd3WExXNHVMSUFGdENSRWJlbXUvZlIr?=
 =?utf-8?B?YytiaTYyRkRTclJ5NzgrUDQ2KzBaekNCVTNoTnpxZUdnblZzNlJiRExHenhI?=
 =?utf-8?B?ZEdYQVBRVWthOVIyVlVIVk9wQ25qaENySHE1TjJKa3R4Ny94eDNoWlpCZllP?=
 =?utf-8?B?dEJWOHpBOU5FV3E0TmxpajZhdlV6SG0vNVRJOXhBaDA5ek1rcElHZ1d4eXdO?=
 =?utf-8?B?M05RSUZySnZTcUJiZHo5ZVB1R3FEcXBaL09ZUjZhVVcvR2JRMHphRUhmTHdF?=
 =?utf-8?B?NDRRNHZiOUtiY09TWmxPQitJTlZxVXVDb093My9qdlJubmVINWxGOWx5Sjd2?=
 =?utf-8?B?UmNHMWRQTHA2TVF0QUlrMnZDelV5WXZNTW9KeWptR3lHcVhVbGl4QkNTN0dS?=
 =?utf-8?B?Z1ZndGJ0alIxbFlKNmZ4ME9KRkJSaVBkc2dCL2ZqZUJDdEJsaU5jbFVaSmMz?=
 =?utf-8?B?bzR0NFBJMWp2ci8wOEdXdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGFocks3eWlDWGhyTldLNWNLaVZPL25rNUszTnJuQ1dDTzFmRWthcnZwQUJB?=
 =?utf-8?B?U2xqckZJKyt5RHhueUQxVDVyWTdzdTJNbkJKZFNnQWtkVUpHVENDNm1kU2RN?=
 =?utf-8?B?ZjNSaUpGSzY2VjU2RjRkWFEyNStaWS96eXF0aW82cUk2VFpIdENTb0lBMWc2?=
 =?utf-8?B?clI2VEtXaHdKdWJ1T09yeUVYQnFyRkEveElKZmRmMnpSKzFzdEttaWR1M0RU?=
 =?utf-8?B?R2FjdzFIKzkvU29NMVRTNVdkVjZoTkp1T05CM1RQQzUvdzFkT1RwY2dIVXZ1?=
 =?utf-8?B?NlAxN2FOaC9zMkZPSVFjcUN6KzJWOHQrUWFnWkc0MldPK3ppemJONG42MWpv?=
 =?utf-8?B?UFhTc2RjTFhnb0JEc1lNWG56eVRSazZJdGNHTmRwR2ZTTGtqSy9ITXRBaVE4?=
 =?utf-8?B?TVp5UHAwd29jSGdmOHR6bkw3YzBDYnU4TXp5VXdyMEJjQS8zbXJ3Mk1xaUVn?=
 =?utf-8?B?dTE5cTgrV2lzaUhxYUFheVpjTHhXWkpEQ3R2ZW02S3hERXlJdlBUc2g0ek5T?=
 =?utf-8?B?VHZQUC94U2RXTEpNdzFOVi8zU2hDSTdNcFNKNEcyWlFndVVOWU04MEhabVZJ?=
 =?utf-8?B?dUErTkNLa20zODJxVzhFaTNPVUtoWUdORWJhTnlzMlVDeVo3cEIxTmNobnpv?=
 =?utf-8?B?ZitDSWYxdUNHMFUyT1lhN2xWOVR6SVVKTlZDai9tYjJXc2MyNHVYdGRRNTlS?=
 =?utf-8?B?cE9xa0RnNnc0azhPN3ZtUGYwajBPSmRuYTJZdGpLQXQxaTQ4d05TZ1o0MlFH?=
 =?utf-8?B?MlNvWDh1bXJJNTM5Qk4yS255eDNXY0dzNzdLVjBQdkpVRExyNU9HU1VHdUt3?=
 =?utf-8?B?R1dGU3IvcEdodmZHMllzTTJMN1N0YW03OThKUmJZaE53Y0Zyck8xNktzbWVD?=
 =?utf-8?B?Ym9ZbTlOSVZybUxoRWt4cm43anU1WlZ3Z2lzT2FBam1xR296NUFhMWxnSTBR?=
 =?utf-8?B?NzZNWDFqWW54dUMvWlRjVGcvOXVRcGtmMGZCZ2FzMnh3dUlNblBhL2RrcG5p?=
 =?utf-8?B?bzZtK1l6SXpESUdRblhXS1dITWFORjZBd1VYUTdzZWlqbGxQM1lWeWhuZXNz?=
 =?utf-8?B?b2diVUZBV2Jsc2IwUnAzOFgvVXd1RTVXWTNMMTl6ZlE1b0x5S0lnbXVwL2hu?=
 =?utf-8?B?U1kyTTVWcUJGK05mM1F6WmZsREVIWDd0WTFMM1o4MkMzTDdrT2pSUDJMS3hu?=
 =?utf-8?B?RnB4aDRqUmVmOW5MNTNUZnE4UFljQ0FjQ0d2ZFJVNG5BUk9pTy9ZUlhoT2Zw?=
 =?utf-8?B?TnZBTjZKRFo0ZGh0QTJna3dPNTJWcjhiSmNkdW8ybWpTRUVaTnJid3hWUFRW?=
 =?utf-8?B?L1U3b2Fua24vU0lQdGFkdFNQNWVkYndyajI2bnMwa2JYNkltZHlkUWRSWHR0?=
 =?utf-8?B?SGVtMHExK3YxbXlhaTQyVG9zK0pzNjNGb3JWU3Y1WUUyNGV5VnhmczRwZWVr?=
 =?utf-8?B?Y1ZtMytjc3NYejVPSlo1bHRQRGErWkdudGZkS1Vwd0tUcjkvajQ4NTFWcXd3?=
 =?utf-8?B?U2EybE1uajFGdjYwczhJQWUvWXNZWkhhM0ZrVlRFVFBWZDNSajVsQVRrWkRo?=
 =?utf-8?B?R3l3VmFCZjhSTWtMM3RjS2o4MXZKWUN2dnlsUk5DdlRRaEhyRXhWYnVqWnlV?=
 =?utf-8?B?b2t5bDdmWUxVdGVadzROVXhNakhEUDl2OUo4bkNEU0ZyYUNiMmhNeXNqMnp1?=
 =?utf-8?B?b1V4RlErUlkzYnB2MFI2eklIeTFJeE5zZTBES1RoOW9sM0lKUTBycFF0eFEx?=
 =?utf-8?B?RnZkTVEwSGZEZ1JRN0ZxRXZjb0NzVVlNK000YkRUMnFCd3R2RDZ1MkIrbUR0?=
 =?utf-8?B?czFVQU9DWGkyQWFiRzBkWVJxaU1vQXFSRytINlJHc2grOFNmSU8rMG5nT2ZT?=
 =?utf-8?B?b3hZNEVYZTFCMDRYcjRXazhaYTJ2MWZZeVZJWXUxRGhIMHBTd0Y2cXluNkpl?=
 =?utf-8?B?U2EvNENQN0JwQ0VjU2cyTkdMc1VVQ2E5dWhEMUVqc2hjdlk3MFhNK3BQZXlx?=
 =?utf-8?B?L1N1bExsbEljQWJqS1BkcHdJOXRUdXVraWxCWDZRVGszdzNaY3lsUlRrRGxG?=
 =?utf-8?B?RnFMNVBVcVRhdVRBYitMNncyZ28zTFBJNSt1bXNxZjM1eGlNLzBveDZZN0Vi?=
 =?utf-8?B?VkZNQU9WVFBONnQ5ZzF4OE5ha2Y5Qk9JYi9LTWVPRFlORjJxWGdGVytCMEp3?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <273319347BC0B74A94987FF139963647@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	puBOw8pnZhom4/2FcCAx9oqwJKJvqc+c59S2YOfIkJ8k6S9bdkpBFQ3DGWb6NLGpwQXVP0GosKg9rSmRP+Utyru27OnJDO7ajKFtBctK1qnDkmBMlVOBztOG0vVCLt/S/0MPtclpJvumiQzTrVa3LR4w8qyQzmVgBw3f6sCwgNxkuwH4OU+RI307IXJY2sIPK1rdfk+ujeYdP4CBNAWOEAQXgKC+3gdy7KWtNe42LKyMsMxFB2gZ7gkCqmihJkQ1MabGJFmbWDKwrL/VO0j4Hdc/4XXaRsnvuJJEbIFMF4k1JqJiVR72ltHaxHKxVfYvd/iRYChzw589oZYaPGVgmhHQxt3q6F71Cv6LfV9aVR5JRarUtxpBG3tsMoJKKrFjfJg9KczSHUqhwrRaupPOD5h+D+PSVmkQTyow0XM8YVR5U+e5CLFiq5tOQyUHAy2wU5sz+6YjrhdHBH+DoI9Lf1R4yVzKW379C4np0xap3R3Z2ZnmB04+7hWZd7OdeY0HiRjZ036iPjwXiltfKvyh53eVSDwzkGo4+0y2j1SAgyNlH6lEXuWFubMxMKTpcuZo2x1WXvseTrnoyIqehm48WVP/PQpq8CC3h+uPF7x1xwR/fqTpVvh1Keb8oo4lymwO
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d954ad-ae9a-462b-b282-08dc798cbd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 11:54:15.8092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3ZIgJm+AgvqorzvtXt+LgopS5gPLyNgzcNQEXpx9jp5sX7L2PDLfF1k0Ul3mhpeZIGdnRE9K4tMYJFRaOFJUcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6955

T24gVHVlLCBNYXkgMjEsIDIwMjQgYXQgMDY6MTU6MzJQTSBHTVQsIFF1IFdlbnJ1byB3cm90ZToN
Cj4gDQo+IA0KPiDlnKggMjAyNC81LzIxIDE3OjQxLCBOYW9oaXJvIEFvdGEg5YaZ6YGTOg0KPiBb
Li4uXQ0KPiA+IFNhbWUgaGVyZS4NCj4gPiANCj4gPiA+ICAgCXdoaWxlIChkZWxhbGxvY19zdGFy
dCA8IHBhZ2VfZW5kKSB7DQo+ID4gPiAgIAkJZGVsYWxsb2NfZW5kID0gcGFnZV9lbmQ7DQo+ID4g
PiAgIAkJaWYgKCFmaW5kX2xvY2tfZGVsYWxsb2NfcmFuZ2UoJmlub2RlLT52ZnNfaW5vZGUsIHBh
Z2UsDQo+ID4gPiBAQCAtMTI0MCwxNSArMTI0OSw2OCBAQCBzdGF0aWMgbm9pbmxpbmVfZm9yX3N0
YWNrIGludCB3cml0ZXBhZ2VfZGVsYWxsb2Moc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwNCj4g
PiA+ICAgCQkJZGVsYWxsb2Nfc3RhcnQgPSBkZWxhbGxvY19lbmQgKyAxOw0KPiA+ID4gICAJCQlj
b250aW51ZTsNCj4gPiA+ICAgCQl9DQo+ID4gPiAtDQo+ID4gPiAtCQlyZXQgPSBidHJmc19ydW5f
ZGVsYWxsb2NfcmFuZ2UoaW5vZGUsIHBhZ2UsIGRlbGFsbG9jX3N0YXJ0LA0KPiA+ID4gLQkJCQkJ
ICAgICAgIGRlbGFsbG9jX2VuZCwgd2JjKTsNCj4gPiA+IC0JCWlmIChyZXQgPCAwKQ0KPiA+ID4g
LQkJCXJldHVybiByZXQ7DQo+ID4gPiAtDQo+ID4gPiArCQlidHJmc19mb2xpb19zZXRfd3JpdGVy
X2xvY2soZnNfaW5mbywgZm9saW8sIGRlbGFsbG9jX3N0YXJ0LA0KPiA+ID4gKwkJCQkJICAgIG1p
bihkZWxhbGxvY19lbmQsIHBhZ2VfZW5kKSArIDEgLQ0KPiA+ID4gKwkJCQkJICAgIGRlbGFsbG9j
X3N0YXJ0KTsNCj4gPiA+ICsJCWxhc3RfZGVsYWxsb2NfZW5kID0gZGVsYWxsb2NfZW5kOw0KPiA+
ID4gICAJCWRlbGFsbG9jX3N0YXJ0ID0gZGVsYWxsb2NfZW5kICsgMTsNCj4gPiA+ICAgCX0NCj4g
PiANCj4gPiBDYW4gd2UgYmFpbCBvdXQgb24gdGhlICJpZiAoIWxhc3RfZGVsYWxsb2NfZW5kKSIg
Y2FzZT8gSXQgd291bGQgbWFrZSB0aGUNCj4gPiBmb2xsb3dpbmcgY29kZSBzaW1wbGVyLg0KPiAN
Cj4gTWluZCB0byBleHBsYWluIGl0IGEgbGl0dGxlIG1vcmU/DQo+IA0KPiBEaWQgeW91IG1lYW4g
c29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+IAl3aGlsZSAoZGVsYWxsb2Nfc3RhcnQgPCBwYWdl
X2VuZCkgew0KPiAJCS8qIGxvY2sgYWxsIHN1YnBhZ2UgZGVsYWxsb2MgcmFuZ2UgY29kZSAqLw0K
PiAJfQ0KPiAJaWYgKCFsYXN0X2RlbGFsbG9jX2VuZCkNCj4gCQlnb3RvIGZpbmlzaDsNCj4gCXdo
aWxlIChkZWxhbGxvY19zdGFydCA8IHBhZ2VfZW5kKSB7DQo+IAkJLyogcnVuIHRoZSBkZWxhbGxv
YyByYW5nZXMgY29kZSogLw0KPiAJfQ0KPiANCj4gSWYgc28sIEkgY2FuIGRlZmluaXRlbHkgZ28g
dGhhdCB3YXkuDQoNClllcywgSSBtZWFudCB0aGF0IHdheS4gQXBwYXJlbnRseSwgIiFsYXN0X2Rl
bGFsbG9jX2VuZCIgbWVhbnMgaXQgZ2V0IG5vDQpkZWxhbGxvYyByZWdpb24uIFNvLCB3ZSBjYW4g
anVzdCByZXR1cm4gMCBpbiB0aGF0IGNhc2Ugd2l0aG91dCB0b3VjaGluZw0KIndiYy0+bnJfdG9f
d3JpdGUiIGFzIHRoZSBjdXJyZW50IGNvZGUgZG9lcy4NCg0KQlRXLCBpcyB0aGlzIGFjdHVhbGx5
IGFuIG92ZXJsb29rZWQgZXJyb3IgY2FzZT8gSXMgaXQgT0sgdG8gcHJvZ3Jlc3MgaW4NCl9fZXh0
ZW50X3dyaXRlcGFnZSgpIGV2ZW4gaWYgd2UgZG9uJ3QgcnVuIHJ1bl9kZWxhbGxvY19yYW5nZSgp
ID8=

