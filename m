Return-Path: <linux-btrfs+bounces-10866-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34B8A07BED
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 16:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66EF7A3B42
	for <lists+linux-btrfs@lfdr.de>; Thu,  9 Jan 2025 15:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8449F21D003;
	Thu,  9 Jan 2025 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="b5ZPBqec";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PUwLulhn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9420921C17E;
	Thu,  9 Jan 2025 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436440; cv=fail; b=gPRTdExxKZIHAe8gLo7+cCrJMf9dIFtxqtChFXuiZyopjXc+ArJi8tpdeNAYoReymCcxTdVWiUSyeQHp+ugURtjuQOAxPPDz+WQi1ZGe6FW7esR+eYWJ26G/RBgZ6XNCIGPW+S9RIhAFD1LzTlv7gbCoY8GKWT3Z1TkPh9Hu4lg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436440; c=relaxed/simple;
	bh=q80R9FvKkqA8lgyk2gU09W0hZbvV8vkIE2OS14IDqtc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nk2/HsFvBznGkVq5PLOT0AQcObukTlu00fUKK545KFsmqPctauf0cNe3bLAek97NOKQPqxQzHPBQHxR2P06xbawdP8ZFrpz8/1ER/vnNKRWgUxBqkF50TPKUvtCJMIggoKcsxQ7vklVcc2bEDvEx0Wmkb326OrMhTQs6iDDvOD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=b5ZPBqec; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PUwLulhn; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736436438; x=1767972438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q80R9FvKkqA8lgyk2gU09W0hZbvV8vkIE2OS14IDqtc=;
  b=b5ZPBqec3ESGWLpPyRvm7ML1DQ4hOM40Bd8mj4YiIXliM7/uI3kn5jei
   IIXjk1sf2aQpMG0L6uRUt0xBxiic/Y7AkNH3/yy1NGlQydYS7ZTLa+1mE
   87OQp8h9AnCrOQfL9nPONJiBpn8QnS3m3CzikH56+nkgJc4QQ40SlVArY
   W3SpOk9f4K9e14L14j6Z/mr+pQflfD1zRKpALNpDphd8iqOzXUw+Xca1C
   bv6oSbZL5V3g2yF2mJ+Tu/lUGTeB/Sk752wZcvrB6wDaUusLbTbyFXwST
   eMp9QWu4x6pmZ7KWnUyg86u6xHzzmztaV1eqBI/Qae9muO8P62wN8mnFC
   g==;
X-CSE-ConnectionGUID: p1xwCA75R1STS5fEONeDWg==
X-CSE-MsgGUID: MzX1CFp/RaG8B7aHgpfJMA==
X-IronPort-AV: E=Sophos;i="6.12,301,1728921600"; 
   d="scan'208";a="34906928"
Received: from mail-eastusazlp17010001.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([40.93.11.1])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jan 2025 23:27:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h9ThxugEZ0MWRxRuIR10tS80IwSW/ZH62LuiogCVj+3R/NRFRAHsrtyM+n0PUkbyZxqkMBtT7V0bPdJwL9w9GbnkejVXzNKeV1sHsNLnpBq0CvZcG0XtAM7Caqemn64ZHeQohxVT1FephsZncLWhMwiUFnAnzbjLSMQr4Y8V8pwAV2hhuzg+crD2G+Lptav651bcwT3H0zAdOydH3BUA9HInBkxAjbr/eyIZt4GUmCCt0MKcqD+z5MJ9DpeCURvoY9UIG7fMGjGK/u2xRT3+8YK0EjBdn/4y21dppBdrHccbbt3xIn/KXepQvA1AqIXHTipdru+nxtMtr97WNBIwkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q80R9FvKkqA8lgyk2gU09W0hZbvV8vkIE2OS14IDqtc=;
 b=PxDf21nTxPtXpXMoQPzQCbry9MhqaTMfofbYEwufLLCPPqYKy9TugWMs1wnVS7usD273QmFxz9TVhArwGkMXJKWlRxWh/5CUaqxM9M0mMVhe2SoECIkdsf45R41jc8k+DjFToZHjwAyA24mZ6caC1HjtLaEWNbmHxKzU/YiaZg00+cZywKYptXmTAddXJ0NT6uvwzB81mIapU1ycXb2ZoaK+/VzxJ4tdJ4KS18Uo+FiA7upTHMA9uyW2f1iy/y+x8Ny5RtNQMJqAejS6D1PrtM0YJuL4d3as1eetzKmUTLZo3SkfnkTmN/AEeIg34Dk7Bn4zaWEBtcy71UW6FdX4cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q80R9FvKkqA8lgyk2gU09W0hZbvV8vkIE2OS14IDqtc=;
 b=PUwLulhnDo0TwDK9syT/0OTtu5VJC/Neb+EUCp1rf34fm+S65mami/cbOwbSCpcd8wAvxUkPTqM0Gwm00OmJQ1QBmR8Iy5mWSb+m/kcjKHkuPplOrSYU5Qq4EEZrs0p5xGSMg4NsfFScn//azJJkB6rdCjnNo4s96ZqKdOE5pzs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6738.namprd04.prod.outlook.com (2603:10b6:a03:225::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 15:27:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Thu, 9 Jan 2025
 15:27:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>
CC: Johannes Thumshirn <jth@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>
Subject: Re: [PATCH v2 01/14] btrfs: don't try to delete RAID stripe-extents
 if we don't need to
Thread-Topic: [PATCH v2 01/14] btrfs: don't try to delete RAID stripe-extents
 if we don't need to
Thread-Index: AQHbYQJflUTtOhP83EGPi0Ll42eqgrMOY84AgAAiyICAAAm5gIAAA5aA
Date: Thu, 9 Jan 2025 15:27:13 +0000
Message-ID: <ea37cf5a-242b-48f1-8b8b-f8d751ede70b@wdc.com>
References: <20250107-rst-delete-fixes-v2-0-0c7b14c0aac2@kernel.org>
 <20250107-rst-delete-fixes-v2-1-0c7b14c0aac2@kernel.org>
 <CAL3q7H58qoA1MjDG4aFbaGE5ddAJRgyNZ0rAyb+XhEqP20xKcA@mail.gmail.com>
 <ca324436-f214-468d-a769-fd4f236313c0@wdc.com>
 <CAL3q7H6cMsTn2ZksQTKuZYKW-g668i=o564sGMKGb1h2i06ohA@mail.gmail.com>
In-Reply-To:
 <CAL3q7H6cMsTn2ZksQTKuZYKW-g668i=o564sGMKGb1h2i06ohA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6738:EE_
x-ms-office365-filtering-correlation-id: dd0b90c4-fa22-4fc0-9306-08dd30c2179d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?N1hGd2lnZ3hyMWp4RGJKSFQzdlJkRkRYRWhpakJZMHFBUnZqOWhvWWJ4ZlpK?=
 =?utf-8?B?LzNRYVNIK01KL01FbDZ6cmVpK0Vza1ZWdVR2dVVta0VzaXhWSWk2S0xnTXlM?=
 =?utf-8?B?NDAyUjBWdU5vUENpMTNWWnF6VlIrMUs2WThVT09iT04wcXdCVzByVG4vS3o5?=
 =?utf-8?B?VGNjR2RJSkordSt6ZjlvZXJNbnpkbTdHVkl0dUs5V1JEVVNNWmRtQ1Zad2lh?=
 =?utf-8?B?UEU4aDZhWjRndHFrKzcrenhsZDErY1k3a2FvMkhHTFRqYlQvTTB0bnhTMzdu?=
 =?utf-8?B?WTRJMUxLRHRjZDJSYjhNL1BRMGZDUWRMRHk5NzRNbFVaUytPaDFycXRpWHFI?=
 =?utf-8?B?V3h4Ui9ONFdSakk4eWVxRmpTOGNabm5QNklpaThQVE1RNUQ2QlQ4SFQzTVg0?=
 =?utf-8?B?enhHejBvU1FOb2tGS1l6dzEyTDNOMEc1UVZDMjlGd09CcnU4MHg5SCtFcDF1?=
 =?utf-8?B?M3FReXBGQWxSQVpqSWxkZjRSSFJBRDZLRk02QzRQTEpFVm5sWlZDVTlhbWRG?=
 =?utf-8?B?Z2F1R1ljRXljN2lOUVRBK1ZjU3FaUGF2enkvR1RWTVJDbXdRL0c3cE1ncDQ3?=
 =?utf-8?B?azN6cFpSb3JiTmc3QmRMd0NpZVJ0SXhaV3UrcS9USWtSWXo1T3ZtY2tuNlF2?=
 =?utf-8?B?TjJMc011eWRwMWR2cm1kUk1SN3NGanF0M2w3dENvbjlRelo1WmZ6dDVqYTAv?=
 =?utf-8?B?M2VGRzM4UFlaakd3c09TWkYyVzZYL1NnUmZNMm9wSzVwbURiYmlHUnF4cU1x?=
 =?utf-8?B?YUE4MHhOcnRMc3JEVzAvSlAxd0xoWCtPbmdLeHFwTFFjUzVwK3dWUHE4UXBk?=
 =?utf-8?B?VkxXak5jZE13STVkR3BOS1haaU9FTVJxcDNHeWZ0TXBmT2pGSG52YUV5MXZ2?=
 =?utf-8?B?Z3RlMjNkVkYvT2hNRk1RSVk2cW1rdVppK2lZeUJKT0Fna0dYSEgzNWM0NjdK?=
 =?utf-8?B?dnZ5UVRmY3IvbmVES2UwY1l4MjNmeW1RR0ZzdTV2OGNWdW1WZ2kxazVLMHJW?=
 =?utf-8?B?K1VCNzZiQ0cybnZxMUZzZjJEMWZZY1k0QmRTd0t5RjhGQXZlNmVkcytndWln?=
 =?utf-8?B?amw4RWMrUHIzZDJtUGtrUkRoSlRMSTdvRThFN3crdVQwZGZCd0c2SEZIci9Y?=
 =?utf-8?B?ZDV4VVV4M2Vubk1yVlBQWG5BVGhJZnZ2N2NqQ1I3MmZNby9DODNUUUwzQWps?=
 =?utf-8?B?Ukk4cGtBSHdBMWlZQWUwMkQ2MHVGdHhOQTFDa2VJTXZ6YjR5UmtZSjBBM28r?=
 =?utf-8?B?MWZsTTE2NVBTT3oyUEYvbFZBSEZNQzBCcXZJeFcxTmlMUGxhMjY3SWFkSnp1?=
 =?utf-8?B?Ri9hLzNOeWlHNVM1WGZsWU02OEF0bzRBYXJZY3VVdlNKeGsyMVluUE1TSlNX?=
 =?utf-8?B?QUtlUFJITnVnQUlINzVZVEt1VHBDNkR3UlVib0R2WmU1L2NiS1l1T2hZY2NJ?=
 =?utf-8?B?WUtuaHRMZDlaQncvR3BNRzZnM2xURk5MeHlOdWNxdXpWcWNzSEUvdnZ2NGgv?=
 =?utf-8?B?QlhTLzdVRjFuQVlMbXV6WUxzTGNBa1p4S0pMK2JyVktMMUJyNkRWUjZOWTk4?=
 =?utf-8?B?aWErTEFIM2IwcFo1cjZ5MTlOZ2JFOTNuZkNwYWtTQWFFU3MwbkIwS0F6VHVi?=
 =?utf-8?B?K1Q3RzZzeHg1eFVBVnFzT1UyNmJhcTQ2bTVUTTQ2OXhFbU9pTlZhL29wNldC?=
 =?utf-8?B?ZzdodlRSVm5KWktFU2piYW9FWkJYbml2VGg1SS9EUVF0dGZ0elRQSVpWcDYr?=
 =?utf-8?B?aEFRWWo3aXJWYU1jUXpIYjBEL3cxejlYaTYrZ29INzFCL2k2RlFJVzdPWHBJ?=
 =?utf-8?B?U3NydFh5UmdSNVNMbWVuZzltMEFFWVBHTEpzQXdIaVhBTkY1NjJId2tiZEJa?=
 =?utf-8?B?bVVYYlNKa0NHOXdqMGNmNnA1T0xLY1BRWU5PTExzak5vM0lodktxdDc3NFNJ?=
 =?utf-8?Q?+s386iFDOtalyWZLnJciDFymCPH2j7Ml?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WW5HT2NMYkFYZDF1K0I0REpUUHZVUXJuaHZ5bXpJOCtJUzJPMVRkemZUVWtI?=
 =?utf-8?B?dDJ0VFU1OGhMaHZKcXQybHdSczVHNkJtc2lpb0NHNDgrbjV4aUZ0cGw4ajNq?=
 =?utf-8?B?L2l3aTY3RUdrUTFvT3Q3bkxwekJQS21YNy9JZVJjUEk1b3NUZWR2a2Ztd0Zs?=
 =?utf-8?B?dndqQ1JuSmxYS1I5dGJQTkJHcG1BWHd4VkFIVjgyNkhrZGk0NXBoZHJjN0ll?=
 =?utf-8?B?OU9sNWxORGVMNUFKbEZ3S2RIdnltak1hc3FPdGhuSlNwUitkVG1xajd6Sitz?=
 =?utf-8?B?aHJucFZIcXBKWlByWnl4QVZoWE10S1hsYmNEeXM1bXdsaGdPTWNlSnBxdUtr?=
 =?utf-8?B?S0FIeWp6S2hUZXFmN0g1TWpIeGI4Q1dXZ1o2QVUrSFdTVmZvQWJrVmxvOXVt?=
 =?utf-8?B?dVdSZmg0UVp3Y3I4b3NKdHhNbUhsTnY5QWJLc3BMQ0hJa0FPbHZwUmJzdFMw?=
 =?utf-8?B?V21Jcm9mMGNkQksrSXhucW80K3ptR25QS216SWtjRCtVRWJuYVB0cTVudHhC?=
 =?utf-8?B?VVU3SERsTVNxdDNjdE5lS1pJREdTQzlEY05vQXlKejZWRnVJNWE3ajVyTDZW?=
 =?utf-8?B?cy9QdUJ0UElNOFYranNyQUZlQUZsd2tEYWRlTE5xaU9EcDRuc2tzazhyWWlp?=
 =?utf-8?B?anVTRkdBS1d4WlVSUmtVYlJ6MENmQnAzUEw5Q0RUZTcvZVBvZWxVSUt4YzUx?=
 =?utf-8?B?cFZwbzBMUVdybkZEYjllcjlUMVIxVzhzSDZ3K3lxNHFBcXJlNjJTSnZsZkFm?=
 =?utf-8?B?NXJZSktMaXRnUG5wOStMYkxqSDRvaGV0K2xIMy9JR1JBR3JkRW1ieGhCSzVm?=
 =?utf-8?B?WEt5b3RHa1ltSVYyb1h3a2xvU0lqWTNzZWREOWN0aWRhbURJd1JDTVNRQmpD?=
 =?utf-8?B?Q3VDV2ZlaHNlUDY1N2JvdzU0RG5naXBtZS92NXlpTCtwU29GUjBlSFFKbVRq?=
 =?utf-8?B?VVZNckxIOWVFalY0RjNLMlhhZGRmNUR1SVBxbTlibVRLSjdtOE54YWxNd1Ux?=
 =?utf-8?B?dTBxcTNLdXlrVmVIZnVBT3QxNTlGbEdEMnE0UjRlNHptcmpGRzkwU09Tck5j?=
 =?utf-8?B?NENxTCsrZ2pCRFN0T1dYdWtvWmxOYnZ1Zk9tK29tajgvN2F3N2o2aTROWE15?=
 =?utf-8?B?OENKVk5sQ0NPV3dJK3dRdVJ4VTE1alIrZHM0L2R4eFNpTFl2bzJzcllYeDk0?=
 =?utf-8?B?dG43SkJBS1k3VThMaDJQQVAvRE9JRy9DbmNWanBxdVVIVmtCWThKVkI0QVBK?=
 =?utf-8?B?OUI4THdWN1Jac1BDUlhQTmhzdGI3bDRzMUhYSUYxajUzV05qYUhQbFQ3M21J?=
 =?utf-8?B?TnBlQis0NzlvTU44SlB2amN2cDhhVnU5YTZiMXlwVm93NWhpajZoUWk2ZG1Q?=
 =?utf-8?B?dDBaTS9pY3kzTTBrbHdlN3NETmMxMERqczNSejR6TmJnb3o5R3FQNVNMNGc5?=
 =?utf-8?B?UGJCVmhERk5WSVJNSEtZVHh4NmxZNml0Mzd5Z3NvWWxCRG5kWGYvRDNMTmNO?=
 =?utf-8?B?TUVvWk5sL2FtTFgzbDBEMzVyaVZuWHp5dmFmb3ZUd1VjREZCNkJoRDlvNGh5?=
 =?utf-8?B?UVpLM3BnZ1F6NzkzOVZvL1poMW1aZ2U0M1pGZDN3Ky9HK3lXY2FIeHpQS0lE?=
 =?utf-8?B?UDZTU2E1Vm43d08wamd5RXJrUkVDQWRvdUFhMzYxOVZyWEQ4VG9YUllkUHdJ?=
 =?utf-8?B?R0Y1OTR3a252Nk5RRWRDbi85WlVGN29SZUZySkI1bTdwUDBPbWxyYURTZGNR?=
 =?utf-8?B?K3UvV1JMblFsYXBaZmNrV1AzQ3I5d3BXZ3FtT1o4OVh2MkNwM1c5TmlDdklM?=
 =?utf-8?B?TXdrVDlpR25meEFDSmF6S3Z2SXBCZndOZE9JNzRkSWpSNWxJMUZKL3grbTlU?=
 =?utf-8?B?UVpkYkhCYWtYbG9pa25jRXFrcCt2YjhzMDJqZjFtNjEyOGFNQlI2RE9UdEVU?=
 =?utf-8?B?dWZveWVCdk5PbEpVQkJqYUovWm91MXlRNG1lWGthd1R5ekoxWXpMSGlhVW4z?=
 =?utf-8?B?MzNMbUZwelN0WklzSnY1SldBdVU5Si9ScFJKRVdGNGc1NGJOUWRGOFVGenBk?=
 =?utf-8?B?dmViSGI3cC9lMVlPNkx0RTlTU21zUGpyRk1lWlpVT3orR2s1cU9HMmp4Rll1?=
 =?utf-8?B?dHViWmRSZGxNZ1hjVlF1c2c5b3lQTEhjL1h0MmxhU2VVa1h1aXBkV1d3NjhH?=
 =?utf-8?B?bWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EC2AE7D273606C4C9D53E0056DD89BEF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Y3Vx9bkS4V0E9HlYTqZkT2Uy5D0cx6S7Wck2Q+m7g+Zcb2b8yiljprsstc1LSR0DqX3zL5BIi0jouHQ2jQf4qcZHqbHX8J/Fk8UmXWVpnkBsw1mp+rwaJvzbQDDxJQ3I2zl7A7QCN1aIWPadYNU6z8Jl0/v6bnsQcTDVCvRrCdkj4wcAh7FpbpR2hz3pdxyo2sOASaxWJ1KtJZH5B3xALFJXn4I8eqRDs8DgmLLaqLJjduJQ8O5S2UvZAXpauv1KfCVmu/TgXozxycC09F2NXKPrY8o70CiH/IlLGh7+voEQg/du/W0dDjWAc0FDL9jGQMQBFPvcDyun/iSm/5KZobhDc2eu0OSgOoJruHCCkysSpjhFZJHP3BDllirq7T1SHqbipQmmGm/cy7g42Juu4sFajUOvK9VcUDLXUJ0UXIp5ev4Zr6DxIavdnvsfUwFW3aL42EUX/lvX69SVt306JhtYirKkK4tIZA0Oumf1FcUr0qjRUoIZrXaNS4ro1ViNz2qMMw/nLTlTUbGIJaqGJeNZA2GycnablzGomhpgj2RDzKev0X3LWo8C0kfIaIPeXAvK5LVyQkrMK3Q7s1whwDCZxdchJWdwCR0j5b0jCtNFrt2yy8KLbBRbm5WeSsFC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd0b90c4-fa22-4fc0-9306-08dd30c2179d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 15:27:13.4316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrNyQXA5BaLCCahIN5QXVFK8DjW7GIqMgyfXvOx2znhArCLd2djBIM0l7hJN6Oq7hGuIuu5dwIUgpQmV3jnl9LuceIdgUCtIvxGkqdHswRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6738

T24gMDkuMDEuMjUgMTY6MTUsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIFRodSwgSmFuIDks
IDIwMjUgYXQgMjozOeKAr1BNIEpvaGFubmVzIFRodW1zaGlybg0KPiA8Sm9oYW5uZXMuVGh1bXNo
aXJuQHdkYy5jb20+IHdyb3RlOg0KPj4NCj4+IE9uIDA5LjAxLjI1IDEzOjM1LCBGaWxpcGUgTWFu
YW5hIHdyb3RlOg0KPj4+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvdGVzdHMvcmFpZC1zdHJpcGUt
dHJlZS10ZXN0cy5jIGIvZnMvYnRyZnMvdGVzdHMvcmFpZC1zdHJpcGUtdHJlZS10ZXN0cy5jDQo+
Pj4+IGluZGV4IDMwZjE3ZWI3YjZhOGExZGZhOWY2NmVkNTUwOGRhNDJhNzBkYjFmYTMuLmYwNjBj
MDRjN2Y3NjM1N2U2ZDJjNmJhNzhhOGJhOTgxZTM1NjQ1YmQgMTAwNjQ0DQo+Pj4+IC0tLSBhL2Zz
L2J0cmZzL3Rlc3RzL3JhaWQtc3RyaXBlLXRyZWUtdGVzdHMuYw0KPj4+PiArKysgYi9mcy9idHJm
cy90ZXN0cy9yYWlkLXN0cmlwZS10cmVlLXRlc3RzLmMNCj4+Pj4gQEAgLTQ3OCw4ICs0NzgsOSBA
QCBzdGF0aWMgaW50IHJ1bl90ZXN0KHRlc3RfZnVuY190IHRlc3QsIHUzMiBzZWN0b3JzaXplLCB1
MzIgbm9kZXNpemUpDQo+Pj4+ICAgICAgICAgICAgICAgICAgIHJldCA9IFBUUl9FUlIocm9vdCk7
DQo+Pj4+ICAgICAgICAgICAgICAgICAgIGdvdG8gb3V0Ow0KPj4+PiAgICAgICAgICAgfQ0KPj4+
PiAtICAgICAgIGJ0cmZzX3NldF9zdXBlcl9jb21wYXRfcm9fZmxhZ3Mocm9vdC0+ZnNfaW5mby0+
c3VwZXJfY29weSwNCj4+Pj4gKyAgICAgICBidHJmc19zZXRfc3VwZXJfaW5jb21wYXRfZmxhZ3Mo
cm9vdC0+ZnNfaW5mby0+c3VwZXJfY29weSwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQlRSRlNfRkVBVFVSRV9JTkNPTVBBVF9SQUlEX1NUUklQRV9UUkVF
KTsNCj4+PiBUaGlzIGh1bmsgc2VlbXMgdW5yZWxhdGVkIHRvIHRoZSByZXN0IG9mIHRoZSBwYXRj
aCwgY291bGQgYmUgZml4ZWQgaW4NCj4+PiBhIGRpZmZlcmVudCBwYXRjaCBpbiBjYXNlIGl0IGFj
dHVhbGx5IHNvbHZlcyBhbnkgcHJvYmxlbSAocHJvYmFibHkNCj4+PiBub3QsIGJ1dCBpdCdzIGFu
IGluY29tcGF0IGZlYXR1cmUgc28gaXQgc2hvdWxkIGJlIGNoYW5nZWQgYW55d2F5KS4NCj4+DQo+
PiBJJ2xsIG1ha2UgaXQgYSBzZXBhcmF0ZSBwYXRjaC4gUlNUIGlzIGFuIGluY29tcGF0IGZlYXR1
cmUgbm90IGEgY29tcGF0IG9uZS4NCj4+DQo+PiBXaXRoIHRoaXMgcGF0Y2ggYnRyZnNfZGVsZXRl
X3JhaWRfZXh0ZW50KCkgc3RhcnRzIGNoZWNraW5nIHRoZSBpbmNvbXBhdA0KPj4gYml0IHNvIGl0
IGlzIGZpeGluZyBhICdwcm9ibGVtJy4NCj4gDQo+IFllcywgYnV0IGZvciB0aGF0IGFsbCB0aGF0
J3MgbmVlZGVkIGlzIHRoaXMgY2FsbDoNCj4gDQo+IGJ0cmZzX3NldF9mc19pbmNvbXBhdChyb290
LT5mc19pbmZvLCBSQUlEX1NUUklQRV9UUkVFKTsNCj4gDQo+IFJpZ2h0Pw0KPiANCj4gUmVwbGFj
aW5nIHRoZSBidHJmc19zZXRfc3VwZXJfY29tcGF0X3JvX2ZsYWdzKCkgY2FsbCB3aXRoIGEgY2Fs
bCB0bw0KPiBidHJmc19zZXRfc3VwZXJfaW5jb21wYXRfZmxhZ3MoKSBzaG91bGRuJ3QgYmUgbmVl
ZGVkIGZvciB0aGlzIHBhdGNoLg0KPiBUaGF0J3Mgd2hhdCBJIHdhcyByZWZlcnJpbmcgdG8uDQo+
IA0KDQpBaCBub3cgSSBzZWUgdGhlIHByb2JsZW0uIEkgdXNlZCBidHJmc19zZXRfc3VwZXJfaW5j
b21wYXRfZmxhZ3MoKSANCmluc3RlYWQgb2YgYnRyZnNfc2V0X2ZzX2luY29tcGF0KCkgKmZhY2Vw
YWxtKg0K

