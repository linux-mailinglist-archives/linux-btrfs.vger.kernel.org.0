Return-Path: <linux-btrfs+bounces-14172-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E626AABF494
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 14:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3BC64E03A4
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 May 2025 12:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3728267732;
	Wed, 21 May 2025 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GWoHaiT9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hU9zPVU/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F341266F19
	for <linux-btrfs@vger.kernel.org>; Wed, 21 May 2025 12:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747831436; cv=fail; b=lOeULC64763VRF/gBQum7oONffv8LMNOxZhbjpD1yZ36iFVtFJwccHJnnezQPfTuiFVSJqwu8+8clwgCFunGxPPsxd41LhiV56whPxjzObNSA52WxzO8mCjIin+Xh+5JwGYj0dYk3EEuagNLWSyQ03u7T/6nM7Hd0p8HTQOekQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747831436; c=relaxed/simple;
	bh=uHz9HkC3DTFsBXm7K4HCYinbQm2zMM8f6g8ECuNDKs0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lNcV3Rg6vdm094lVFfW8li5Hmo5/JdVp4KH+cLCcUcDZLdGGLsE5sSnCEr4DIY2umhk2nM4phM561gSTUogbpkK2f4hgC+M5wjJ+X+qQFAD6x2PKOLo9xbkBIRMQ5EQUyXopdjNvmcOTfwsaJPVQlK3v8T0MgyX459VgTELGHsc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GWoHaiT9; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hU9zPVU/; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747831434; x=1779367434;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=uHz9HkC3DTFsBXm7K4HCYinbQm2zMM8f6g8ECuNDKs0=;
  b=GWoHaiT9cX5gD+GG4oYHRDn1lZlctJ8V1Tfl+DSpiRnVC2rNXbNTufmQ
   ahOea6kVTSW4CG6W+v+vvITxl0Q/2/cpvMJRhGdqvaGaVm0bg2SHsbmso
   ZfzPrQgVshmgL34h5aWRc0651opMvPx7e0OPbUFy7r3kaupnrvHVPLWn5
   4v+AJsfIaWDBEefCKoL3Nlo3cv77+HWV0Y/af4iNTilWq3XPBg8i3847M
   pkpKj+lKX/pu2xt5ew26XFRdEe4MMtQppHRshwxLxuQh1ycibNMWHsBV/
   Gn6B/pd+s2bIy2XnH6xa/lpF7aEU44X6PcJ+X7c1ZRkg1z/yVFhCp+doY
   A==;
X-CSE-ConnectionGUID: L/neG8LcR8Kc1PH3DBhu6Q==
X-CSE-MsgGUID: ORIfAsIyS2O32LyFpeHEfg==
X-IronPort-AV: E=Sophos;i="6.15,303,1739808000"; 
   d="scan'208";a="88661065"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2025 20:43:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dUteCJ27tPZgAZiSBzThBXaIW5wY1ESMkKnFhaJH04N1zsUrKuecPJUgwLD4P5zCShn72XdfXcjR1bMxkYAPzrErD6YV8tsXjTft7Bu3NfGvbNkRTM0GS5beJ7VShJJmo0JqIT3e0s4DJ9eVb5NOBbsDFJIg5baqXTDM69q+NZ5jFPZFIp3PPvL/SGmsDj/4IiLGRw3YuUXQrZGJvJNQkyxIfEx+FnMDhd0kfw0Y7/rDT5GVoZl33KSQEEDyxBcO723L+p7Z9T0Sjsp4sNRwYTHQJYEeRjFtym1Ml7eRuof3M8xS8u3GHdBAbLYM7pk4qA04epgwHa4yKd3ChY4clA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHz9HkC3DTFsBXm7K4HCYinbQm2zMM8f6g8ECuNDKs0=;
 b=wKiqwkABijSsZd5ml6IGs3CgUqsdblLyeY2SpXeQ23OBV++f3z4ks6r/DIZBa1VixRlLCG5dzJQIT6rOTOw1PWENJ6Q9ResOT4hPXKznbdOlf4TJ9p3JmwdVglXxLi3Z2dMoWjRGcFSWvCO9jwBDu87NHzAV+9wPEbqah7k9l8aIjdTHD/Xir6HCX20pabAkbar5gmnKV8nIjt0pAkVmFSi6HJbjJFq5HjLlpk3bpSX6UBiq6RUdujUmIpAXY71ahxFQGKDI5uIbMjWeuF4r4sGuBHcT8fdYiK3i85y7ma8FPGj2eF9oH+ROHMoqzWCIU67AEeEFxStU3p3UvC4ZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHz9HkC3DTFsBXm7K4HCYinbQm2zMM8f6g8ECuNDKs0=;
 b=hU9zPVU/hcvpKfPjqFJEaKcARDX5L4f1wbEQzrRk04QjaD9ysMzdTHFoiWXwN9BOjMpLPx9m/HZsa9bHf7kPwUYyxiCMXh6XZG/Va5QnHF4EGH2ImCDI/1kzYZxq4JdvkrZZlj8s0uwsHBod8vUSRkZcP/FCpsiJm04m3NsEx/s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH1PR04MB9711.namprd04.prod.outlook.com (2603:10b6:610:2ad::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 12:43:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 12:43:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Mark Harmstone <maharmstone@fb.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [RFC PATCH 01/10] btrfs: add definitions and constants for
 remap-tree
Thread-Topic: [RFC PATCH 01/10] btrfs: add definitions and constants for
 remap-tree
Thread-Index: AQHbxbe4MkRT+aV44ke4sIf2OR6SNrPdEI4A
Date: Wed, 21 May 2025 12:43:49 +0000
Message-ID: <33145376-05e7-427a-a20e-6933ff0b949d@wdc.com>
References: <20250515163641.3449017-1-maharmstone@fb.com>
 <20250515163641.3449017-2-maharmstone@fb.com>
In-Reply-To: <20250515163641.3449017-2-maharmstone@fb.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH1PR04MB9711:EE_
x-ms-office365-filtering-correlation-id: a975f365-28f6-4a63-923c-08dd98652266
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d05pamhZbXNQcVkrN0tYMUltQk5DUzRvbUpoRDNudlBOamdmWTU0UmN6T09z?=
 =?utf-8?B?aVliams4T1ZwZEJ4WmxmMEs5d3poMTVYVVBJNXJFd0FmbE5CR0xVcDVyUitt?=
 =?utf-8?B?dVIwd0ZwYWdnM1Eyd3E2QmpWcGdSbnl3Tk5uZ3dmL0UvNlRkQWtMQkVZc0Rs?=
 =?utf-8?B?OG5iUzNmVFhIZVovZWxzbjJhZkZOV3lodWNnZTF6VDNEZG85UGhYNlpVVHR4?=
 =?utf-8?B?L2VrTk5IcWJGTlQwdVV1WUZ1OG1PNXJnWG0zOGdIbE5kN2F0bE9JQXhpSUhF?=
 =?utf-8?B?UURKWTFrb1lKazk1K2VqOGFMUVdKVVJmL0l6ZmJoa0JJK0hrT3VEc25Mb2Ft?=
 =?utf-8?B?V2V6M3lmNVQ2SjZ0MW4xOGRsYmdhUE55UDNtbkp4VTFrZTFKWFpuMlZyTm9X?=
 =?utf-8?B?Nm9qekQ4bEhNNDRIeWxPRnNvQUZwaDlRWW1LYS9oV0Y0VTBOeFhwLytDazg2?=
 =?utf-8?B?OHBFZE1mYXFaMlZwVjlFTERKVEt4VXZXQStGenVnYkNFSXUyMVZKWFo2RWRl?=
 =?utf-8?B?aG1neFlPdHFES3FkTE12bVM1YUxTRmFEN09HaExVODN6T3JPMEp3TmRsZTI4?=
 =?utf-8?B?Mk4wazlKZUt6cUVNWCthb3dBbnE2Tk5Ra0doa1hCdWZWYU5VM0xJRzNsSWxB?=
 =?utf-8?B?czBsdWprbzlrcmI0eXhESVAvZHJoZC9vZjI5ZVgwVFVuZzRLYjZVbkpEVThn?=
 =?utf-8?B?ZnJWc3JaZmg2cUZVRmJrNEYwZnhnZFhwSTlCQ0E0NXFHdmpxTXFieFhNcGN3?=
 =?utf-8?B?Mko2cFdERFJwdEsyTmY1U2VyNk92a0dlTnpGMlhURTYwSVlXMDVJNUV0TkFJ?=
 =?utf-8?B?cTEwQlZYSmxyZ29wZ0FxYkU2N21wSFFNZTQvbXhaVXNDOGE4dHU5UnNWSDg4?=
 =?utf-8?B?WHdpS2YzYWVzOWhLKzFTaG45VHVEZ0xTdjYyMDBFL3EvcjVLaEhqYkVReWZN?=
 =?utf-8?B?b2JONW9qV2UyaGVEVHpLVlhZakRqdVlVUlZDUnFZeWhKdWpRc2pRTmlLWFBJ?=
 =?utf-8?B?akRaMDZkN3EzNk9uMHZIYy93Ry9MQ3piNCtiemlNc3lQZEVXSXpSSUVpdHc2?=
 =?utf-8?B?cHh4RVNNeU9yeVIvVTZiK0wvYUt5U05pZmxkSzJmNlVpL1RJdDQwUXZSUm4r?=
 =?utf-8?B?M0F4Zzc4c2NGOXkrTjFIdUQzdjZNMkRIUXUvZnZvTjV5VmllMnM3VnRXRzVv?=
 =?utf-8?B?TGxMWlNiSzZxODJCa3N2MVhsb0dQKzlYdlQ1Q1BlWDZGRjM3aSs5cHZGUWFt?=
 =?utf-8?B?YmR0eWF3dG9wQ21KWENDQ1MxLzEzQ0FCSUhMYUdoMDJJYnphMGYweFpVUXd2?=
 =?utf-8?B?NEk5MXpGdVNLanEvRWdCYmJxK3UxeTNWclJjVEJCZWpPUG94aUJRS2FTNXRP?=
 =?utf-8?B?M0xYYWNaaU9uRlRBdW9BdUJMZEJxamI0dVdzMjlMYW9JbU5WaFB6TExFZ0Fu?=
 =?utf-8?B?NXJMR2I3L3dNSkx0OS8vcnRSc0xSWFFsTnAxcnFiUkk4VE96dVhKUWorS3p1?=
 =?utf-8?B?dk96WkdZVTAxNnpNeXZnRDRUMEwzdWRKd3c1VitDQjhxN0xMZ2VYWkVBdnlF?=
 =?utf-8?B?OWF6ejVGeHNBSW9Wajh5ZnFkSnZCcXBCUUpTWWVsNEV0Z2t1Vk5QVjdmZzJs?=
 =?utf-8?B?S0hzb2E3anpFNHVqYkl1T2xWZUFVTllSQ0lyQ3hkMU1PVDdpWFdYMnRoc01m?=
 =?utf-8?B?SU1GSmZ3RmN6cTlaUldUckV3WXpDOXY1SFo2WnplSmkxOUoya2xmNkJCRzhi?=
 =?utf-8?B?K0tieDNaVXkxUkhacC9KRnl4Zld4QkdqZEZvSmhJVXVqZ21MUmRGM2xpNFJR?=
 =?utf-8?B?MVB0NS9rSTl2dGxsZm5zSTYzcERSVE4xYXVwMFhEdktkZ0liSmw5NG1LZGlU?=
 =?utf-8?B?enhEYWZveXB1RFJodHp3OHN4bDlvL1F5b25aR3VVTWRtclhQaTJBRENnczUy?=
 =?utf-8?B?VW15WWtvNHhaUXV6WmsraWNyTjVta2c0bENvYnB1SjdMRzBRNHkvaTNOd3BF?=
 =?utf-8?B?WEpuTklRYk5nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDg4by9VMmN6b2h4cnNxRGlWb2hscVFFZUFydGhwdjhqSm1veHVWOC8xUW1h?=
 =?utf-8?B?aE1CZXNmOGR4ZmhWQmk0OUtRSUhtTzhDcWZtWmY0WDNVblFzMXNQaDdJaCtz?=
 =?utf-8?B?R1h4WGNLUHdIMlh2TEdpRXNJOVQ1UVpDNmxXOElYelJSTXh1amFwVWN2bHg5?=
 =?utf-8?B?Rmp1M0JOdVZsbyt0ZlExckd2ZzhmeGE0eWE1RFNqNHphNGhFKzIzbk40OFhG?=
 =?utf-8?B?RkZaamtpUzc2ZXdzbUhUL3AvVmg3clBlOFJBSzkyL0xCcnM3elFJaXpKRitS?=
 =?utf-8?B?R1JPd09KMk1iL1AzQS9uSEJ6N3NDMWJOa1RXWWR3NC81R3dwZFRZSXRocUJu?=
 =?utf-8?B?Z0t2OE1UNzlDODZvVVFTUVNpbWJ0bVFwZjVPZlkwazgreUo4M25PRnBPaVpY?=
 =?utf-8?B?MTU5d1hiWU84K2RJSVAxT0dQREllOTF4OUhHWEtsMERYUU84bkNyd1pUb2xP?=
 =?utf-8?B?ZnpCUU4vUW4reEU5UHhFTGFJa2MyQ0MwSHhId3pYb3h0MXlrYlMranlXd3lp?=
 =?utf-8?B?WWhxa0FnSkVSajhCeVJGUEhjMWd3RVJVeGZqZnhWNHMvb05HenUxUkF6bzJQ?=
 =?utf-8?B?QjNZVHNtUElyaHJ0KysvTEgwN2ltVlJmZ1kyeldIUTBEdm5aTUJiZHFqWVE3?=
 =?utf-8?B?emRscFJVZ0Q3SFQ2WDJ6Tnh2OUttU0pvSXl1MjFnM0FpSFZ1NG1WVTVDN3JQ?=
 =?utf-8?B?TzlldlFtQXBKKzBUV1NVRTZ4T3BjQTFHRDAwODFiVXFjR0xkcHU4MWlLamRa?=
 =?utf-8?B?VmhCRlg4d3VleGRoRklqMzlTZXBVQStxeXRYZnU4Wi9NVWZFdjZEclhCWDdF?=
 =?utf-8?B?elV6anlzM2lFQWh4VXFzTzlhTHlNcWFDSllaVGNhNlJQblZKQUFkeURXUUVN?=
 =?utf-8?B?SVI3TDNLbzFJZDdVOEU3SHY5Mm42VXg2RTQ2RzhGZjVQRFNpYktDM0EwSVM4?=
 =?utf-8?B?RDl1SE1JVHcyY0Z3SVdxdGpOK1Y2dnR1MHNKU2FzcEdERjhNR0Zta3Jjbitw?=
 =?utf-8?B?U2ZJVDBKSk5RYVVjamhoU2RCbmR2czBkYXMwOEw3bVFGU1RpbThnVzYzQ1Q1?=
 =?utf-8?B?THM2dTFhQ01tTmdWaEpJSTBudkQ0UkJmZEN1TFYvNFo2c2dJL214Vnl6T2pM?=
 =?utf-8?B?WU5NQk84NmQ1RnV3OStUUVJvZld2S2N0U1R6enNxQkkrd21pSzU3NWgxVlZt?=
 =?utf-8?B?UExsaXdhK0hFcVh5bE1XUlVkekFFWkd4L1UweEdudWNjK3crbklqd1JOY290?=
 =?utf-8?B?d01LTE9sdjg5Mm0xbG9rR2tZdVlqeG1yTXJDc1pIYnN3UVNpeTlKZ3Vrd2xp?=
 =?utf-8?B?OWhDZGJKRGFhMWNwOVpXNXRsZnpFdGhQa3JkU3UwSTJzQlFIMGl5Qy9KM2hu?=
 =?utf-8?B?azFsWDRURVBaOGovSzR0N05LTXVtR1RKS0dVVi9sdnFzSGxJSTBJbk9TdTZM?=
 =?utf-8?B?RVFvcjlDbUlsem1YZjhuNGtiQlUvSnhwOTUvRTZWSWM5V3M5YW1BeVErV1Bz?=
 =?utf-8?B?alY4Z0tqaEcvcHdaRmExcmpadWhNc0NLN2o1QjZHa0R0QU5FeW01NGtjOW45?=
 =?utf-8?B?emlNK25BUHlxSTgrSW1kL1VXRGlReDNRcGRydms2Z3lwQ2pXcms2aXVSUmN3?=
 =?utf-8?B?THNwakw0UmpWbXIyaDhqMmg2Wnh6SlcxZVNDWWtncjArMGxXK041TmNGVU10?=
 =?utf-8?B?Sm9LcmdQeEgyUUVYNnJ4RlNaN3AzZnJMRklVaDcxWXczamJYU050SlMvaGVS?=
 =?utf-8?B?bHVhZXZGQ2xXZUtpK1RjN1BCQndsOHF0bVByUmkrVllHNDk2ZnFZNlhKMkRw?=
 =?utf-8?B?T21KeHBKWWlhODl0WnFVUHUyK0pQNkFRVEJ1Nm0raDFyT29INDJZYTNaZ0pX?=
 =?utf-8?B?VlZSOVY3dDFIb2hkN3NRS0p3TmUwVngrMU1WS0dBQ2dNRElndFhhMDg5ckRy?=
 =?utf-8?B?UlJrNmZpQnNza04rUUw4MTNlWmhEdjdYZjRURWJtQ2F0elVHdlRhdU1lak5u?=
 =?utf-8?B?czRWY0s3Mkd5a0JreGZBQWNCWk5GOCs1S2VLUS85NHFlRjM0VTFVZHljQk15?=
 =?utf-8?B?dHJ4VTljSW9JSGZJUjFNNy9JSXJHMytzdzdGeFhGOGpWRlh0RHhjTG11bTla?=
 =?utf-8?B?RHdhZUluT3hoUnBLZE5Qbzk3WDI4L1BGam4zZzREWmw3cDFrUkpReTZvYkNO?=
 =?utf-8?B?OFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81B4ACBDED292D4F97457FE4283BAB06@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8qxKOXb+yPnQEsnfdf1N5PjEVRIZ22lQBmp93G+Kxk4UTzBRfwXjv9yhZbbSy+/LHhC+rD5V4G8b+Vo17eUlgJV4BMSt+QCZSTjeGZFnxI71eq9GD2XVlA3yoUA7SleMgbNhg6kvbG+vJg49S0FDC+TecfLuDAtEn6iSMuSWlT4ygaUa0BRP2LSJ2DCYq3VFj74eMaWFRlz6jVvr7uwrG0YldALwit1SI3j4TqBB5HY4qgEz+uF+FOLZT7j8LDBTS+C6Fgqe6R3r0xKinKZKWsKgy7E4iy6xdFwWv+Vc//rlgmdS2QLM/FVNWVhWKQrd9sUOEMzEf7lYA/wUnD01HKfBclHljnPDMSLKm/KVQvADSbZtxEhCCTXbUkg4i3zxRYaECaYfV/A3RaJ0guCWGM1QmFWyz/suexF78ngkh3XA30zj9qZBmXM7irEsdmEDWKF6n/WnN+QGAz7Q8VeFM2BJvEDZdk/JSBIkdy0KAuuai0lgN6UQ6QRThyHb1mD7Y1bmiGJeHUNQZdivQ4E24RKCBYpSKtTljahu0l+1kvF6xuRLZrsxekaMGFpxKMeQL3WSP6qBG4y5OB4IL8PHIeGlp993CjV780V/X39QWhIdm91UZwACFqVTbxbmxca8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a975f365-28f6-4a63-923c-08dd98652266
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2025 12:43:49.2233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLBET4xmHBUcYWDSJ3xdHq2Uf5QV05IZ15ouM/A7AJbbVkH8srlui9VJsFYQt//QRH4AzoMYaiMt+sYoFmAN4ZhEkB71RonU+yMNq0qzLIE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR04MB9711

T24gMTUuMDUuMjUgMTg6MzgsIE1hcmsgSGFybXN0b25lIHdyb3RlOg0KPiBAQCAtMjgyLDYgKzI4
NSwxMCBAQA0KPiAgIA0KPiAgICNkZWZpbmUgQlRSRlNfUkFJRF9TVFJJUEVfS0VZCTIzMA0KDQpK
dXN0IGEgc21hbGwgaGVhZHMgdXAsIEknZCBuZWVkIDIzMSBmb3IgQlRSRlNfUkFJRF9TVFJJUEVf
UEFSSVRZX0tFWQ0KYW5kIG1heWJlIGEgMjMyIGFzIHdlbGwsIHNvIHRoZXJlJ3Mgc3RpbGwgc3Bh
Y2UganVzdCB0byBsZXQgeW91IGtub3cuDQoNCj4gICANCj4gKyNkZWZpbmUgQlRSRlNfSURFTlRJ
VFlfUkVNQVBfS0VZIAkyMzQNCj4gKyNkZWZpbmUgQlRSRlNfUkVNQVBfS0VZCQkgCTIzNQ0KPiAr
I2RlZmluZSBCVFJGU19SRU1BUF9CQUNLUkVGX0tFWQkgCTIzNg0KDQo=

