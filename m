Return-Path: <linux-btrfs+bounces-14947-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B15AE80A3
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 13:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABBA07B6249
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 11:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425B22BE7AF;
	Wed, 25 Jun 2025 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QcXb2yty";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X7pgoq9Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D437B2BDC39
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 11:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750849660; cv=fail; b=d/m8Y174yfR3g8UQhEMa45SICKeJGxJMPwvC+hZsno2MVcpIq4sJ4iK+OSJO2MchXPfyl2d8wooib7REIl8QuXv/f0+geXmuHt0Z8KIpDVXuzWP34itEB96JdwFS45bHIGAXnhPG1EOjnX5t0+vqimFX0CeXzJBJzDb7XtHMyoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750849660; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WcKi7b5U447sWKMJeH8ivQicotw4WOt6PMyrOL2Dhs3LUXRFopmFZAiYnY57Ri7j0MQN1cooHZv+TK2CKPdcomkRwr6O8djs4re60VMFA8pwhgAXC+2O9WcE+fZAFx/tTeNX8X+VxnMRr/CNBSBpY+ryq/XGUsyVxbbwnlpHI1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=QcXb2yty; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=X7pgoq9Z; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750849658; x=1782385658;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=QcXb2ytyaMByPR/IZK6EN1mhX0ppqhEVMpIgm6NujBW4GW01QCtoY8ir
   rLRQhyLukOjy9BYf0+z2W1f4QUoRaJoGr3oDULV+syAcqSbCOkfANgcgO
   GT110SPUAcEUADruuOFMQvf7zFT9uop4VwQMxIs3sOOKFfx2GlytoDmnU
   M8YmKfYP+nK1Hecw9lW1OaVpl1MgJPuoqA4b1bK/vjMhG8AdYoaS6aGFp
   ahPAjLsHCuKxThwp1aYImsuCUIxB8obYCowD3Bo844OgiwvPrabfo667P
   phlJEilBZoyDrwgtP3IetS6hH8tYVqi61bfEaHRq3XWtDZ6He806LkeV3
   w==;
X-CSE-ConnectionGUID: 0siwVsbhQ8S5SBL2fDagOA==
X-CSE-MsgGUID: jMLyTWXDQ5qVWDv+zK1ttQ==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="85205673"
Received: from mail-northcentralusazon11013053.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.53])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 19:07:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGj74R7MIatRd1vnHhfOs/KXgRmb3A5EouEE8cVdZni31Zpj+QruIsTSoheCUY9rkNrGl658AcLbC2kS1i7f8ZxxoYdhqj9dkRMDpfOkeDwdlbkFf+O3FaQf8Q4NLhEL7GVoZ/7gfJsQE3ReY00kUrIYculCjiaRwg2NSGVBo0Nn/Bx8L4BPeYLHscHR01vA8C3UtLvC9rZWmgqYSc7XiHpYv8VhHTKg4iDwqMUHHYhyvVBSu6RWAtJnZjZpWBKmTGbF3VkcEPeokhJNxK5kOcj5QDSUgoV/ole1msRsRNpk0ywsHBWqUTQqVrZaQt2qKSjtPD7JrONdyQVok7jkuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=h0xGfdw/VxmBthd9mBNXfvIYWtaHUQNkKeolCxZWM51rw6sbHXLlsZxuagAeyp2XfJBTBeDSSKU1TLgMrmbwKVAGq6bR8bQeu85UWwRI65BhwKDwWhRSerr4kIILGppnXqQeoDa2rabwMwfMOfHOs8NF7beuWjsbAac5R7GW51ieMk0uOsnlZRtQTXLSrhnwkpMIuUB/sUPPJ6nsrlDCmGR0xuEh25B9qGz+etsMFRR17V6OMaaJrPApnA/E5XCi7IFH/elBu16jxKI40A406bISSh/TqaHbpKI7uutr+ReTsyeOlIzBi4CxZTtql9f9gc88euKvP/ICMq1Qet/1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=X7pgoq9ZY2QZQutjU9w0VchBKWCn6Lz83YwdH+ciokOH8D6XM5NoRvjEHBmsGPjaycCFco+s+G57ccYrLNj+UD3/MAmZN+tgOD73hW2iJSz7zwAmqPkF8OLeP8L3d3vsa98hXN46d0nEfp3ZhWX9TxJWIA1XzYRyDCyRt73dk8E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by LV3PR04MB9220.namprd04.prod.outlook.com (2603:10b6:408:26e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 11:07:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 11:07:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 09/12] btrfs: split inode ref processing from
 __add_inode_ref() into a helper
Thread-Topic: [PATCH 09/12] btrfs: split inode ref processing from
 __add_inode_ref() into a helper
Thread-Index: AQHb5Rg6gvR+sWTRhUaVxMDt8eBQhrQTuIEA
Date: Wed, 25 Jun 2025 11:07:33 +0000
Message-ID: <87494bc9-2a02-4826-a7a5-ac8704493cf4@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <d9b05a7bce29f816bd1880b2395cb1e49a925660.1750709411.git.fdmanana@suse.com>
In-Reply-To:
 <d9b05a7bce29f816bd1880b2395cb1e49a925660.1750709411.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|LV3PR04MB9220:EE_
x-ms-office365-filtering-correlation-id: b5763e10-abe9-45c7-76dc-08ddb3d87c06
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?OGE5VFl5RjQwcE9GalEyK2FwN1ZlOE42K1VJYU0vazNuWlhMWVZ6WHBsY0ds?=
 =?utf-8?B?NUFoNDVIS3NrNWV6dmtBWnBhK0pQdE81UGZHQ2tVQzBpaHFyR0FHVitKOTAy?=
 =?utf-8?B?ZllrSG1keWU3WkEzc2NFTVk1ZW4veU1BN3IwcnFBemh0T3lXbm0rL0xIWUcy?=
 =?utf-8?B?UTA3TWthdVF2eDhBcUMyZGNYMmVyTDZRMUgvbVlWbndGZXFaNEhRZDl3bmlt?=
 =?utf-8?B?cDJ0UTMrUUlJeURyeG5yTlpCM05VQTNpVnVLaGhKQ0lSUXFUL2N3cCsvbE9G?=
 =?utf-8?B?WmRCcUlObThQbFM5Tks3cHV1WjkrVWhJSVpxYlAxS2ZHK3dqUDB6Y2dIZHIv?=
 =?utf-8?B?K0ZpcWpVbFdvQWc4S20wNEdzUWpLSmNFUVJEb2pUL2tXN1E3WkRxSDBOdm1w?=
 =?utf-8?B?QTBtL2JSVVhvVmhieWdyZWJIK2ZDVDN3TjdjV2VPemZJNUF2Titadm5Lb1hT?=
 =?utf-8?B?S1lpa3FvQmpSRnROcWdQdE8xQXpPWlB3VzZBOUpMNnBVdzd3RVNzSDJCbnVX?=
 =?utf-8?B?anFvQ2tmV3VRWG9tbUZJVmdpOWhLMW40enlSNDI2MmdRRy9iVGR5ZGFsOWNQ?=
 =?utf-8?B?bWNGQWV0ZUYzT0hOSk00MmZNRjlpQ3MyZlk2cVYraVlub2d5NTVnWk5XMi9l?=
 =?utf-8?B?NnExSFZWWkorR3pVZ05CVFR3Z3BvNjJib2ZKY3cyUlJZNklwdHlMeFlmM21h?=
 =?utf-8?B?d1hHdXpoZFZ6Zk5yRlc5b3JoUzBWWVFHdm5pQW1aUTFqcURJbDFRRnlGQ1NF?=
 =?utf-8?B?S3FLZm05WXhpcnNIZytaaG5rZ3VrTWJjTFd2QThMdWhJTksyODZBc1pnaHRT?=
 =?utf-8?B?ek9CakF3MkErcVhYVVpLSUJ4aU1kcEwzRktkdUxDOXFIWTFOUldEbWpDbi85?=
 =?utf-8?B?MEVzY2lmdm9NY2doQkkweE55SEdjditaZGFQZElsUHpicUh2U1prSW5ueHNh?=
 =?utf-8?B?Mk5vTGhDQzEyYVFqM3NzY0FmaHdXTVg4cEk3M0Q0dzJuaVVDa0Y5azJRT2l3?=
 =?utf-8?B?S3hSRVU5dUxtL2V2bjRMWTJIL09mb0V2Mm5KdTZsVHZsaHl1cDA4OHByN3Q5?=
 =?utf-8?B?aWNWdXBrNzdwOGNNS1dyaVcyNEp4NE1xcDd2d01YZkFiU3ZDQWZnNFFkbHVo?=
 =?utf-8?B?SXc0eVhrMVAzR3llVVhPdUNCUW9nMndtcXpzUW9ta0ZhWDJNaWFpQnprcWdE?=
 =?utf-8?B?cHBZaGJNbUJlMi9sVW5RVk1mdGYzSU4reG1xRWpIbGNMM1VMVWcrTWZHZjUz?=
 =?utf-8?B?UHcrRklNcmt3RjBQYk1hOHdJdlBsRjBjK01XT2ZhQUF3bVQvUXF4alQvcFFO?=
 =?utf-8?B?RjBXWks2emlxMC84L2gwQ01ZemNSakRqcmlSc2d0VE1VSnJVNUtvUU5xQWh4?=
 =?utf-8?B?cUtIKzhPVzUxYVJhRXBYTitTOFYvc2xNUkZLZWR1R1VyMGNCQUcrUzFqTlpL?=
 =?utf-8?B?TEs3ZFZ6eUdXQTFpbml1WGgvQUdmZ25ZamNlcHVFb0xYN1UyNUExTnNwNWJD?=
 =?utf-8?B?ZXBsNFBvUHI3RmJoUTAxaS9NbnBmL1BCbTAvejB1WVN5OW82Z0ZocWIzeGdw?=
 =?utf-8?B?cG9FQ0lnbzRPMnpGQ3RQU0t5VzVOaXJMaElVKy90bzNjYzk4WVU4Ti9YaFJG?=
 =?utf-8?B?QVBuMEtNL3Q5MTJybzJhZ1MweCtsMWpuUzJIV2w1S2FyMFR6Qlh6TVd3YmQx?=
 =?utf-8?B?WWxxV2xDYjJsZnhOR1VCZkovNnhteDVpQVRrMnIyWHQxbVdKQ0gvd2QwV2Z3?=
 =?utf-8?B?allWcDNBckFLWmcrd3NVb3EyK0VsRGZwd0VlaUJPKzVRMHFMU3ZOU3VEOFkv?=
 =?utf-8?B?N3d0b2J3WkZxQ01BQmtyTmlFRURpVElYQndiL2VXcGppTVcrSFg0Rk1MSDhO?=
 =?utf-8?B?Zk54MWRKdGZIMk1iQ1p2NXpBay9RT1ZpMmY0M0RnNmR6VXo3cDF4MjJPMUxi?=
 =?utf-8?B?ODlmYkhoTmxiWVJ2RHRpK09LdDR2N1ltOVV4WVJGenNNSi9Jd3dHN2w3OWF5?=
 =?utf-8?Q?1rEuJ7ckdkXh8oC6/doZbuK1FSgvzI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzArdldsRWRvQzVVZEZCZXI4YWxxNFNZMFMxSU9vYTB1WGhwN00zWGpVbmJZ?=
 =?utf-8?B?eS9jOEVWa0QwcDhvZ1BSMGZUdnRFeWdEMnc1QWdva2xMNHhvRHFXOVRPZ3U4?=
 =?utf-8?B?Z0ExZExOV3hsT2Q2ZUtkUjgzV0FYcGpHWmVBYkhCTjMwV2pPR0FoR0pwM256?=
 =?utf-8?B?N0xqWktGZThCS2JWZENIR0dyYzBHL3RNUWZlWUNIY25tMmQzNlczSHNXL1ZU?=
 =?utf-8?B?bHpHTUtJMzJBZmoxVlRGNTlGU3VxVUpTMlhnYnRlTnNWb01BNXlJWENFNGUy?=
 =?utf-8?B?M2l4c3lYdlZXK0FKMjdrcXdidnU1Mzc3enRRNnV6YnMzZEFWYmNXSkY3azNY?=
 =?utf-8?B?OFVJSUJJdGhvZ3IvaVVWNjB1aE1YWGxhVUd0REJSL2ZzM045OWxIVjRJTTJt?=
 =?utf-8?B?ajlBSnFBdmtCU2JpSWUyMzVwVnNtWVlwQlM1bmV2Q2Z1Y0dvdDFKLzJreFJ3?=
 =?utf-8?B?VmlUK1pMVUVDVzkrUjRqSFFiWlhKbTBsMUpQT2hoMlRmU0tFc3FkTDlBcmpn?=
 =?utf-8?B?V2NvWjRJU0thYzN1K3k2eTN5bEFPMXo4KzQwL095azY5MFh5U0E0bkZLRTZW?=
 =?utf-8?B?U09EU3NNSVVNajJJKzdNREhUeW5yQzdRTmFENi9LNE15cUNPL0VydTFSZzNx?=
 =?utf-8?B?TWFPbmlORUh4ZENEVEVrMERJU2d5Y1QvVG1qc2xNWEhhVE5JSkVWVUhWVU80?=
 =?utf-8?B?dDRiN2pJTWxwWWQxVW9yUm85WFBqdTdFS0xmZktuUlYvc1VOWDBtSlhBdENN?=
 =?utf-8?B?UXlmcUFLbEk5RmEvcU5mcTU4UjNoeTY1VlNMQUMrMGhkOGtPQnV0M1NxTkZ3?=
 =?utf-8?B?ZzVuRDcvUmY5QjJPNnEwMUZFM0tSNzRNMUVRTlhCTGdYaW5YQlUvWEtBV1Uv?=
 =?utf-8?B?UEJTUTNVTTdCRS9HblN4YStXNUdYQytIRkE4RktXUml0OVdObGo2VlI1UVdB?=
 =?utf-8?B?SGtKc3pQMUJwZlRyOFJvaVZJTlBEQWZxcWM2ZVZEV3N1Y3J5a3hTam5LUHpq?=
 =?utf-8?B?TWdycWNqQ1FoUzNsZGI1QTZsT1FtUCtNb1luK3ZpQUliZ1BUSjRucmlPbHBB?=
 =?utf-8?B?b3IrMXNuM09LRTljeGhrcGw0M3QwbVJrTDhqN3dFZmxDa05wdjJCK3ZRMUFn?=
 =?utf-8?B?TFVUYVpKcytNbm5HZnJWcFk3TWs4SEhYeUpnU2pOV2M4WFBneHlNUXdaZ3dU?=
 =?utf-8?B?b09WalZGV1lBWVRPMEsrRnQvcEVNSGVoRlpEa0VzMW9mV3FDOVk5N204T1dC?=
 =?utf-8?B?cW1kTUNHNnpkcGlUSlI3ZGpvcUQzNXhyODUwZWJ5MEsyMnNyaEdKc1cycVg2?=
 =?utf-8?B?WU4rUG0wZjBVdTN0dG1lVkg1MWYwZkNiVTYwdGJLSTlVV040UXBPNmVvSTNU?=
 =?utf-8?B?ZS8rT2lMOG5EbzB3Wi93dkpzTXBvRWFCTVk0aXlJVHJJV0I1ZzRIL0FWOW1u?=
 =?utf-8?B?UnFUajR2ZEZYc0JQdGgvd3JmVmY0WGVDK0pSRzFSSEtLdTZvblJhUHh0Kyt6?=
 =?utf-8?B?WlhxS2Jaa2FQdVRoN2lQbXVOdFBmWjZJTFpmYzQ4dzVNUDhHWWc2Y2trRVZF?=
 =?utf-8?B?ZzBTZytmRFFKbm5zVkUyN1BtbTh5bzdacVNiczh3RXpaQ3IwWDJqWjh5N0tQ?=
 =?utf-8?B?MGFvY1d6c1VmS3dmYkVLZzB6UGgxbjBDOXZYcEVaWEhDcTJ0Znd0bmpFYUVP?=
 =?utf-8?B?S1BKcDcxRzQranZzaGhmc1VZZTZ5M3h1SXI0c2FybVQ2OVJYdGtkL20vdHpO?=
 =?utf-8?B?WkxKNkZEZWdraU9YWHl5YzJzejRWWWJJK1U1NW91Z2dGbkx2NGZoYU1FaHVy?=
 =?utf-8?B?MlgzRkFzVExlRjFRWWREUFd3a3FhaDNQbytmbjBoU3F5TitvL3dlZkdBR1dy?=
 =?utf-8?B?L2RkMnM5VWc4SitkZGsrWDFsc1FSYldSNGc4Q0RaV211dHF3c2RDNFREUlMr?=
 =?utf-8?B?TUxpMEdEcEg2dnJMS1RJNXoyUVJOY1F4aXdjZ1hvWldwcWRWbjUwMktHM2w1?=
 =?utf-8?B?SWRhaUNkZitoRWphaWJqMXB6YnVKV1laYWFhRWFmaHdKM1A4SWRCNFgzdHpW?=
 =?utf-8?B?Q0E3L0Y1dEwxVWpWOS8zalJ2eTFWc2dzOTZHU2QyMHNYUGNkK3QrZU1vbFlp?=
 =?utf-8?B?MDIvUUlPV3lkZkxza3E5K25Yc3B1ZFFLNE5jL1JmZllZdFJQSU9zakVuRk9M?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5043981DFDA423429CCD9F9C3E151834@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J+qjz9YNt7KEKJTdAwlVwpgTjsDQQfmXVsQs2TVWxDKgtJYfQuBTAb2tJVb8n2zIRN6G7UcyseLQpW1CzdBqh/5+qloyGfPAdNp26OrAtPCJDlqKwo9PZSnAKHAcjblYfzOLC7V4jQWetqr/aUkds6H+zcckuLy820mF3XX2SeRrx4+ulJ0RtpaYUASfcR1g6J+9kkk4qT7BP5dfw6earpIrz1LZCcPoW2vhcnjoGVKd3yBvlzhIWv95TwBIbvya2gG74SxPL0KebnCX6nvE/tEh8r+26cdpdpdb7EzZYQH33q33S2f7ZmxUqachHcuL6iAN1cIxe56Pp8BKBiD2ZkDP++IqMnfRxKOKzoMQZBbn0omTjPOK4l4kYCiIqxeGxfaWN+ZXJhiFd9k95KPMohKqo2COqLLHqM1xtXoC/uNLsGt9BtUVBwKjKU6tU2pg1YxFwFldx+ZQpLUOieLlxAHB9+0gFHBARv2erVqKT+BKG1b4ZIwTqmXZsGVQ++BrSc5lSDdN94kYDNtXJ+IcMq0eSo5s7+B0yLTAJM6Hc60T5Jztigkl4WM8PxZSvorX5zvNvhCSLj8OBc37QpBdZdK3okcvVpAuivO+FwaXsyShGG54SRE804mETFirCpfm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5763e10-abe9-45c7-76dc-08ddb3d87c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 11:07:33.1199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9yj6yx7N7Oxen2HNTd7+YOv9GLUHoJ7TLsQA+DgrOR17DYTXErmTc7yZ+8ODdUrd0NouNY5aw82BjfI8SqB7RSBI6vOL7HITa4OODBoXqkM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR04MB9220

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

