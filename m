Return-Path: <linux-btrfs+bounces-14016-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1A6AB7047
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 17:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11321BA2720
	for <lists+linux-btrfs@lfdr.de>; Wed, 14 May 2025 15:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1051E3762;
	Wed, 14 May 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fcpQ3r4c";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QWI74WVj"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70834AD51;
	Wed, 14 May 2025 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747237698; cv=fail; b=tupMt7VomnLGuLdvtOy57pxmDtypscAxe8ZG7BXauGyH85m5Opkqjww+rx9JgPiBXc2w9gV2pOReh5zcle1V0m5dkoeGTY9ioP0K6QdltDBf08ZYyos4BMK+ZP4l6DGp0EnNSylbJZHNMYvjXLwo2fVImP+NJYqnGQaq3+QUosA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747237698; c=relaxed/simple;
	bh=m9NWAzbH/4FIttRryfgmaPiVu8V+lYoicX6smfOzjHc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SoWFHelqjTzPg9zZXBpt5rLJ+5oZJ6EAJwk1ILi6JJooWpop/+zip6qoP9qM3cptWuNC6JfTDv6cepS2/5M9Jghnmg0TBD24XZaoemoBr+qNvvzHS/rqWJeh4qcl10JmCo/+CsCbWxf2TqLcxFgXB7iYthGC1loMLkyWl0qhXOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fcpQ3r4c; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QWI74WVj; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747237696; x=1778773696;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m9NWAzbH/4FIttRryfgmaPiVu8V+lYoicX6smfOzjHc=;
  b=fcpQ3r4c5DtvDDjqZSsgkcSwzh/U7GN4uGxShG6jf8H7jC4mfqzmKlzo
   YbozP/AiuNo0pDuzdNwYCDV6sojNbnkKQujXkXft7XsWxG/aad2ouwOdy
   k+yYVN+/mtHR3Y276bSY/J75hrgNH9ZQEIiKZVXAqwXqHbmIHXkmugVQI
   3cJJK+/F4F8WcbELl2wEUE2FiBfwwHmMYhMpc5neq+rlYSZYw3Di3Pv1N
   M7OPncMX4SftfJscbfLKKec6OJaIi3Wgo4UU/QznOeEzsUMeAl2gUuWT1
   GpbGPbC547m7VDecwnGsPYZb9AZfvP3/lHfxIhyGm4NrNGDO7E2RDD38y
   Q==;
X-CSE-ConnectionGUID: FB/RoVnHTNCy3mDbjVki8A==
X-CSE-MsgGUID: 85MCC4+BSLamejtzQUW9jw==
X-IronPort-AV: E=Sophos;i="6.15,288,1739808000"; 
   d="scan'208";a="81183118"
Received: from mail-bn1nam02lp2045.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.45])
  by ob1.hgst.iphmx.com with ESMTP; 14 May 2025 23:48:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rU5AwW1OYzynjPMp5T8+3ZJDofoa/U/W8hq3tPnN0bffL1heI3Xmk7rGMOtkHV3ILYhO2uli56WJu0CIWk3hgLBRmE23OlqnZ8R+3UxkPksgrCcrgrFiWLmeOdxmf6ADRcPdm7FCe+nsEjGuKkyR91/wpabkqO+ygDQJC6QqI0h/3RMxKLNrkB9SePuM3YIe08Erif5sNvYQe6EFygGwI66pkiumqlTrRcJHiWhY7YeQtBCe01AUGjxxowX/btYuYUHeZkHBUSkxAmjnxk+DtL4p6nJ7xx1oGRMtlY0cTDAOu1wFKaeChPwRavdGY4gyQbdRcWKXKTGF5HKdVLWixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9NWAzbH/4FIttRryfgmaPiVu8V+lYoicX6smfOzjHc=;
 b=IJP+k49LqqjdnpbeH2/zKyKZlRoxzeiEoqW32olGqAUnj7+9CkuEmfgQZCgkH/FJor8glgijGGw5/RLC4+/JpK2DMgwP8A2IWF0wtCFefAaJgzcc7e9Y1D5MThoxiYX9VdMNUU7D8j64GTVPfE2DfzB/jmuXaZyd5P8LjTtfywBxBfGc1klraw2g8VAsus9W1YoXvMHGmBH3EqPFvIDkGEVkVZBvhVHnUZWoIFD/TkUAx8oBraIBhq+JO9LPmS+idRHj3/TM+iErdXwNrxK57qoJx6/Ac7qd8btxUmh3KHQ3owXLwUoGtRIW41qRdSwyhfg9ph/AekoQ9k2fxdorMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m9NWAzbH/4FIttRryfgmaPiVu8V+lYoicX6smfOzjHc=;
 b=QWI74WVjkBL/mGtgjO4vd1HeVcsB9238DNCHWbgl1DJ1lkKF/IzjWEUrQe/kRfPAdmAEcm8oUMd+p/R89glTQz6baLLhH/IzbVuaUMj6PmgFIu4JBniw+uQnJWe7nClzIc7fTN9PTFtTFusbfPxE67ZeIxe+3sOKRHHBZ2yfh7k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB6684.namprd04.prod.outlook.com (2603:10b6:5:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Wed, 14 May
 2025 15:48:12 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8722.027; Wed, 14 May 2025
 15:48:12 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: btrfs_backref_link_edge() cleanup
Thread-Topic: [PATCH] btrfs: btrfs_backref_link_edge() cleanup
Thread-Index: AQHbxNH2yFtPkzrFOUmgsJCFS0QwRrPSRS4AgAAAXoA=
Date: Wed, 14 May 2025 15:48:12 +0000
Message-ID: <ad599778-43c1-49ae-9662-ecd5b79292ca@wdc.com>
References: <20250514131240.3343747-1-neelx@suse.com>
 <3c08a5d6-bf17-4a74-a889-b1658a2a75d1@wdc.com>
In-Reply-To: <3c08a5d6-bf17-4a74-a889-b1658a2a75d1@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB6684:EE_
x-ms-office365-filtering-correlation-id: 055341d0-fa32-47f4-541f-08dd92febb86
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Zmk5ZklmMzdLaUU1djJrVlZXT3o3OHJWV0VxdWREN1RjTXBuUmExSHQ2NmJS?=
 =?utf-8?B?eWF0T2ZHZWpuc2l6bXVXa0RRTitRd1pTU2RYemt3aXNrQ0FFMGRmcFVFb3NH?=
 =?utf-8?B?T2w3TkFsWmRraUtWdmIxTWtmYmRrRlJFZm1vcWl2eXRia1BQeUFvNkpQenZX?=
 =?utf-8?B?c2w5TW9XVlllcGhDaEtVOFlhVExlR2djNVVRamdIcGg4TGpTYjREeGRvcnYr?=
 =?utf-8?B?WUN6TUs3N3FkSkNsbDVNZEdxZUR0QXBwbytSbzVCM1hyZU9kWU51YUtDSWw0?=
 =?utf-8?B?NDB2NVNoSlRqaDVEQ0FHVGVDTnkyNCtvOWRESDVpR3Z2TVdaOEE3TE1TM21Y?=
 =?utf-8?B?b2FGdDg4d2VCTmVxdWxXQktaUFVEajkxUVNHSnphaldGTk8yblBEMTJzTm9l?=
 =?utf-8?B?Vm1TcGNmRzdmQ1VoV1p2ckFzWWlJNnRvWi9mNUNuQndEUUtmRTIvTGkzemk2?=
 =?utf-8?B?d2VtM1llL002SDNwdDZMSk1YaEJVaFRJT3ZRbHdUc01NUUFBUjJVU3d2bHgw?=
 =?utf-8?B?RWIxL2didXg0UlFQR2gzWVhPUXNNYkE1NzdmdWZhY3V2Y0xoVFk3YkJ4ckc4?=
 =?utf-8?B?N2lzQ2l6U2hHQkNUNFcvVzhhU2R4UlJRRStCY0NLdm5TMG55UmlRSHZISnE3?=
 =?utf-8?B?MWZKRHhIZ0VuQVdrZTJNTFlFM3dsZmpWd2YvSXpJYmNEWTVCdkJzd0lGWTBq?=
 =?utf-8?B?UTBnaFVUOERKUS9VT2lXb3dYZ0lvZW5VTFcxdklyaDBGa09nNnJ0SEtGbjJV?=
 =?utf-8?B?UFVmWDd2dzl3UGU5R2ZMWkN2eGdFRmxkaVhpWVkwVHNjUTg1SmloLzR0eGwr?=
 =?utf-8?B?N1c3NXFaUnBweU9jSGFZakVCbkJHM1FKRzhKcFNwTGZPM09jTUdqcHFrQWw3?=
 =?utf-8?B?RlBNc25TWGErOGlQYmNHS0doSVBHRkdZQ3YvSk1VWGpzSmFlbTNZS1czbVZp?=
 =?utf-8?B?M1pscFoyVk1RdUsrRjBrY3VTWFB5aWpVWS9Wbi9WaTZ6V1MzUDgyVkloY2d2?=
 =?utf-8?B?VHB1NFhTcFgydS9JV1o4RTlGUDlZRTZiWW9iU2lrT250TFNnbEluRXZMQ2JB?=
 =?utf-8?B?NVpybWIwSWk2ZHNQZjJtSUZocnFIbjFJbjFRbHNPV3d3NW52QTZwVWNESS82?=
 =?utf-8?B?bWc4WGVEeVFsTytQelhud3FIckxPdWg5RDBYK2NORUFFUnBqd1BqVW1yLzJZ?=
 =?utf-8?B?SlhISEQzbmJhYWc0dUNZYkVsUnZ2ZDZzWngzS1FsY0NsRHg0R2dWSGVEay9z?=
 =?utf-8?B?eXJIOStqVU1CSzk2R3pNSnlqeUNKZkxXOXd2M28zMFVjek01UFZFN081Yk1I?=
 =?utf-8?B?UTZBK1Z4WVljZjBmU202MUVWZkhveGg3TG1FcFhTQThuQXBLZTBNVVRQYTk4?=
 =?utf-8?B?enEyMWI2Q0NLbldNTVlBV2lUS2RlbjhRWDlnZEdVOEYxc3ZGMlBjUk54SnFo?=
 =?utf-8?B?RUU2SDIrT0FSSXY1Q0FOS3lkSzY2YXF0QWVYRWdEbHZQd3FaeEJTU01POFVt?=
 =?utf-8?B?L0tURGd1TUl3K3p2bDg3QldmN0RiSkRqT0s0YjNxY0lSVHUxaHJDWk5JZUp1?=
 =?utf-8?B?WVNGdEhJUzBEeG9JZTB3YmFPV3M0MlNEWW1VMmtWSFZNVFFGRTdndytuMzly?=
 =?utf-8?B?c1A0SHdQSk9LN1loWmZwSnQ2NWZWV2dJSjFyT0oxQXhtWGpmRUVzRldWcXJo?=
 =?utf-8?B?NGhSVWxCbmZXaG93QThXK2hxYndPWURSNTFTQzJ1dkxlNDhNblM0ZDErNXdO?=
 =?utf-8?B?N296cUVOU0tpekpKR3MvY1hGdWFFSzdLeTJiMytRQXNjZWduQnA5N3pjQUli?=
 =?utf-8?B?aHJrU3d4WWMwL0Jrd2k3ZUFCVXNnK295VTFoWjlhSU04YUgwT05LNnFJQnpz?=
 =?utf-8?B?MEZORzNROWk1a2JHamVxZU5hY1l6UzVFUXdUV0U4Z3Y4YzdRaStUWmFYVUxO?=
 =?utf-8?B?K1J3S2FuTWdyWmFsaFpCUHpzOFVsa0MwVU1rSTBFMGtNc2ZMNDA0MVZZSWxT?=
 =?utf-8?Q?G5EJiyj9dabzea3iLl1TNeZKoVpfXk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVhrcXdRZDg0SE55QXJRTE11Tm9KQWdLeWlIVnBXMmRJNnN6Vm5JeUJQcitx?=
 =?utf-8?B?aDFjV1pVcExyMStVSXBqQklaZGtnZTU4cldLQ0haMjdNN3Bvd1c2NlVLL08r?=
 =?utf-8?B?Y2NBdWVXQmpFVGw4cDgwdHEyMDlvS3FlV3drdGI4ZXNhR3F6QjBMbjIwckgv?=
 =?utf-8?B?ajViOTViWUIzMDlXUDVRRWc5dkNTbmhpc0dTQVgrVmozQW0zbVE5M1p2dTdz?=
 =?utf-8?B?RFA0ME4wZWFoU0pnc1pJYTVEY0FxcVNNT0lsTlFBWkpyWjlGeVVGUVJKT2xv?=
 =?utf-8?B?NXBmRW1XU3Y4SzRza2tZMS9VMTVuODFYR2Fjbjd5Q1oxRGdiL1RIT2xlaVBF?=
 =?utf-8?B?VG4vS3dFNEFoQS9hWnNjVkRzMElUK0hKVUFxRFB5V3hEMXhIRUltcGFBUGx1?=
 =?utf-8?B?TTdGeTdWYVdKS2I1R3ZxcFRyVXdDaUdKRHJyYk9KaEo5YVJJRGhUQ0RXSEFM?=
 =?utf-8?B?V2tIak1ZKzV3bnVyalVSWjFBRzM5MGVhY2lTOFlWVUx4ZU9scUFoT0ZucUtL?=
 =?utf-8?B?RHU1aDQ1ZkRoSlQvdWV4UlJSVTRiMytvd1ljWXNnMXJBSnFuNCtQaGR4TkFX?=
 =?utf-8?B?Yk1hR3ZsbkR6NysybXdGV1ZRSlpnNnJQQWsrOHRTVmw2cTBVTjd5SWlFWEFa?=
 =?utf-8?B?UlF1TFFZRTJtdmpJSGFiWHlVTHIwNnB1eldLdzNoMi9pR0hEY2pSbGRWWGF6?=
 =?utf-8?B?VlF1T3VmUW5hUDMxSXlhS015azUrVHpkcmVacHBTVFpIcmtkdUszdkRreS9M?=
 =?utf-8?B?eEJoUnlQSCtoMmFxcVB1MThHVWV4VWR1MCthTlFUSkxqWlgrUDdEMzQwWG1G?=
 =?utf-8?B?NFpjTEVSTXZHWVl1Qi9qdG5EYzJDMXVvY2hBeWoxN1gwVVdhN0Zvc1BvUVVY?=
 =?utf-8?B?a2sxb2h4dGRCTkZRVXRVMTNkRTF6d3pCSUFEYUdmSzk0cG1CMjVQTGZlS2s5?=
 =?utf-8?B?VkFIcVFUWG03S0VOSHZkc3R2LzVtVDdtYzRTZ040QW9pb0xtWVVOZndESENI?=
 =?utf-8?B?QVA2NUMyZ2gyZkdob3dyVWVNMnppMHdMRXltVkpWYW1FNkMxcHh0ak5ueS95?=
 =?utf-8?B?SjV5NnY1TWx3cGNVUnJYWGJiY3d3c3c3OFkvSytybUVjNVhsRDNBR3dxYXFO?=
 =?utf-8?B?MXJrblI0QTI4YjJLSGVYaFEzaHNRbUVsN2U1Rit2N3cvdEZ0OUM0aHpNZmFC?=
 =?utf-8?B?TG5EN3ltSlRLNlAyMzJtMlRtNEhTRHlPbTBMWUc4SjM2RFRka1Q0TXdxNnB4?=
 =?utf-8?B?UnE1ZGxJZWVWaGdRdkRvcEp2YjdZVzl6RytpVnpvaEpSK1FwaWFvMTF6eEdD?=
 =?utf-8?B?UEZwa09qOXNtVU0xUjdCalZJVGtoZzhKY2hURVFNMG9vUjhFMVhiTjNnZnZQ?=
 =?utf-8?B?Zjl6bTlUQjBIWG5DSEduelZJODJ1MG5HbUF3ZlhvbTdQRjdsN3VReTBpSGM4?=
 =?utf-8?B?R05aTVh6M2lnUzNvdkk1QytPWUZ5dGx4c1BERCtDNHduUC9ZMFcvQzJyYndZ?=
 =?utf-8?B?WDAwak9nWnlHd3crQ3g5bnZTYi9XUlZEN1VMR3hKcGVyZ3J2OFJqQkpnUTNW?=
 =?utf-8?B?Ui9RMnpmV0p0QmNOcVRidDlWMDR4UUNTdXYrZzdmejVvQ1ljMHk1ZEplOTVt?=
 =?utf-8?B?UUVya1BVdDF6VUpXMVZMd2RaNllpODFJenlhRGJGRTQxTWppNmRXTTN6UkMy?=
 =?utf-8?B?QTBxYUNnbFhkNWp5T2hzTU52bEEzR1NLcVIxNkRkUUFNR1h5YXVHWWZ3bkxW?=
 =?utf-8?B?TUwrRWhWZUlmM3dXY0RmYXFJQ2tIM2hoSmlReTR5emJUS0ZaOTQrRnVhaE92?=
 =?utf-8?B?Y1ZDa3F3TWdYVE9KcGh3Ly94aFh6V2hqMjEyTDNLZzVleHRsUE5NeFZsQzQ3?=
 =?utf-8?B?NzdReDMzTnNCdC9XdmkxM3BlVWM5RVNuMWY0dDF5QzJvaklRQnVtTHM2dHZG?=
 =?utf-8?B?eXJhT0ZCZ2tZNEdBVVBHVE5xT1BHK3Zic3pubytaM0YvRld3YXo3SnYvbVpn?=
 =?utf-8?B?Y3VjdWRjdmZ0bjBJOWhGTGR2TndEM2pGWGt6QmRDQ0JMeGV1UmZsSVFhNU80?=
 =?utf-8?B?TExRVnJTUTFBbUZ5Mzh4ajVlaUxIQVpLYlBOSFFnaC9nRzR0U01pM0R0a3d0?=
 =?utf-8?B?ZEQrSkRKYjFHTzlGRXJHZ29aQzdyZWpNU1FlRlkvWStacmE4UENzeWFTaVd3?=
 =?utf-8?B?emUyZFhhVmt1T1J6aC8zWDVJMy9OMjJFc0ExbFBWcGFIZWJuUUlKdUp0TEtY?=
 =?utf-8?B?U0Z2dmo3U3NralRMajV1OUV4ZG53PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD79DEEB3BC9584FBADEF3FC8C45CD9B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MhYSP8MOhCMLQIvNVvY/xy+E2SM8oHuZaebbpZgaLu7TOdFth79PhNyikKA5nqg2MDQVMf1ObxxuqMwdZ1HKdfjoQsqPCrgrCTVC9Ox0GOFvCNpQ4MdlONJQMKL8XZgcnjxrfEHX5UCuzGFM9l9HHGklgS1ErtBwXUjPrYmlco6sZoWHezwOyIP8x7tIjt2M1/omGU06Y6SOqC9GFRaVDeRj50FpXTndMQoZremAcf+lzp5hP5Mq3tD8wQmRD4HzCy/DuEzncswA09d8nBS3LSxdkeJQQFTPM6PCdgrKuF+fqX+UvZ8qmHVaWxuoX1SvCrK1Elg9J3m8hFV387iFZNQ3kZyOXo8HZ2QEYOfHVpESA6Z3R+ofEz5z96Y4UsPcLYRDyFm1QyTq6mv9E4dGjzxuBBWAdFeQ2hZgj6BG5pQRSFgu06Ebl01RpevleeKHzlD/G7S7Xpe7WQLamKcdNH6glQORT/ibukfShTAzsRHWUHJwQ/IKEmFVzQIKqSRil1x3QYH7/vYcX56vKR14MrzDFY3xeHdz4hfmPtSrYgIQBIbk/BrUkqtoa2EAU7BZH1/az/jtRz84tGKPTYzdqBHorooVE7gvDK8kXPOXRAWJCQk2MDzaXUFI/2/wKryH
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 055341d0-fa32-47f4-541f-08dd92febb86
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2025 15:48:12.1560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Py3MleSj1MNIptjFVbmjmtE7sco/s+AfdMXeGUmlmiSLYArw5zNc43Umihymmskev1qj2eiRAm1KJAHY+MdhjlCO8D3CPJjsIJcyk38R1qA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6684

T24gMTQuMDUuMjUgMTc6NDcsIEpvaGFubmVzIFRodW1zaGlybiB3cm90ZToNCj4gTG9va3MgZ29v
ZCwNCj4gUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJu
QHdkYy5jb20+DQo+IA0KDQpIaXQgc2VudCB0b28gZWFybHkgc29ycnksIEknZCBhbHNvIG1lbnRp
b24gaW4gdGhlIGNoYW5nZWxvZyB0aGF0IGl0IA0KaXNuJ3QgdXNlZCBvdXRzaWRlIG9mIGJhY2ty
ZWYuYyBzbyBpdCBjYW4gYmUgbWFkZSBzdGF0aWMuDQo=

