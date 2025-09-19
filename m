Return-Path: <linux-btrfs+bounces-16984-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70306B89159
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 12:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 892247E1C18
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Sep 2025 10:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED6D3081A4;
	Fri, 19 Sep 2025 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="PFgIQAkN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zKz0e0WI"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174A2E54B3
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Sep 2025 10:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758277952; cv=fail; b=lw2tN0mh8WWhZOPNVgBhF0hSvAek7SwfJKuQ5xQtkDxT3EZocwHapNIjBfdpzSIle2aKqQN9U7oei8+5z7tGz8UOPB1UOv+tRa65Pwn55aJg2Efwpgz5YGBF898Czf5Vcd+E4iQZ9QUKuXBAjd9M4qHwwtravlpJ1outfG531lU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758277952; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p8dM0PuZYxNYQMWjoUjhvCujOD+ZSGFzKq0BrCg1SvjY7URyfSLrEpDBQkZaanzqr2pq2HzyThvkScY3TQQuQrV5e3s1veUmuFoOGQB1YTsdG05dQW2ABha8lPxhV3dVVELJomNv9swNoiSA4n3LHCqQAuqITOa9llDaqjsXwLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=PFgIQAkN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zKz0e0WI; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1758277951; x=1789813951;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=PFgIQAkNIwgOWKlYDhGRueDaWCi2qCokPrmVNnshjRSHxrwiB77DlV6x
   zHW5Rfn8W6ygXe6O/bc53e9JNg0WWPxOi+4G4kiz/1iZx63gOedhwmPXP
   GT3+6RIhSUK4b9oHpxaSpH7Lwooy5Ojj353RzE+DDV83VR/ffJOx3smfM
   6NulBM8XtahOEfDMZ+SsaHV2FszYh2ZezxxMHHY86rIl9W8fJ8r4Ds+fs
   AU6ZTOBgSjyT+/JhfsnzZpeV2nyRfw7Pjm2TwiivTAkcMuXNFkpZPLHkt
   Qcy+Q/WkSRcbfE6tcgG2ggqGjM7S+uSdEek+6Wp8uJovg9XaZ4kHVTNOM
   g==;
X-CSE-ConnectionGUID: A3oXB20GQLWz9CBXvonZYQ==
X-CSE-MsgGUID: LYAPuDBKSlSEDqYMERikrQ==
X-IronPort-AV: E=Sophos;i="6.18,277,1751212800"; 
   d="scan'208";a="121465636"
Received: from mail-eastus2azon11010040.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 19 Sep 2025 18:32:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PrMc1U+pMXDTY2wFKesIMaZpETzp+H91U3J3J+3O713mmDSXCyu48BWj0naS5fxFajl8Rw+tmN/8Izg5LJOhKk7PfA/G3c0+hOwrtH6a1xCBpa6g++PJCWSCNc6fz3n9VpgBSK6u77ptbzTiajNbinfUsSR1D27c++PFiVRV5gGENoFsGWg5dVj8YUbKa3R0FjjeRpW4VIf2LHUV9FzejApKGwFmWFHbJL3K9CPIF946DkOPOCMRhhuD2jOZUbevs2phF/AR+hYRGnHYTJwKsPVS6mFus+PuVfCVo1omwCkOEarMZjyhvhuNTi+6dbSKot0QhXLHtZ9XZJalSheY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=DW/eRYG5pTVH+CfIxswlMNqBtUuMBHoxRWubg687G1Et2mpO4QMrG0HZ0DhYvQV9wcxTWaidFqRx3Gjt2XC4+f1sm7o+7WhjLlveGbJWbQt9annfjgkVcxnf7DtvupkGZwQdjO7D4nNVHcSWxUorAhYJKUhcWgpn1A12cyioBLW8uyA7XhC0Xv9PI0xbQlQ6zvokebVv5jlaxPmoeFuMioVAHVerXDjJlOw35rkSgNTjAUyzuprqENIYGV/lI0Y9+y7qV1H/vLMcg+SBEqSzKe98h/xD7zGUbpKhB5tSIZ5W7pxJxldtoitlQTGZg7V+V4Wyv+6sE2zahtjGjM3F5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=zKz0e0WIlFAtBfFUjT9kvqaFH/e/u8Oj5NAEx+hWfeK1RAmbasQr/k/PQSPaNlJ/JlJZO2HXB+lsMWQp70Jf1XF3cho9kmdRDhUSFKPONGFO7vA0vAlMCXkS+8g89pNVtOVuGIpsVWv3QSkd3x3DehOrKxKAePYq5nCVL0KTavU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6836.namprd04.prod.outlook.com (2603:10b6:a03:21b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 10:32:22 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 10:32:22 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: annotate btrfs_is_testing() as unlikely and make
 it return bool
Thread-Topic: [PATCH] btrfs: annotate btrfs_is_testing() as unlikely and make
 it return bool
Thread-Index: AQHcKU3eZ5Ui/k5+0U+sOj5FPaicbLSaTr8A
Date: Fri, 19 Sep 2025 10:32:21 +0000
Message-ID: <8aeecbb0-aca9-4c16-89a1-da43d2e01ffd@wdc.com>
References:
 <eebf22439d2422d36703ab3bc7191f382605b8a4.1758272653.git.fdmanana@suse.com>
In-Reply-To:
 <eebf22439d2422d36703ab3bc7191f382605b8a4.1758272653.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6836:EE_
x-ms-office365-filtering-correlation-id: 616bb6a8-2b75-48f3-b5cb-08ddf767d138
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZmJmSXFqdWMzajRGMWN0K2U1TThRSi9XaE1Ya0FrMG9tcm1EK3RFOEw2WDF4?=
 =?utf-8?B?MkZYanpKQ3RzdE5qVWpzZXZpRGM3NjBuQlAvT2lBVWxxams4L29xa1JET0E4?=
 =?utf-8?B?VEh3N1VHN05XYldURjlYZ2N1Um9QRW03UkxGeEw5TUoxV09ZZklMU3FYN0lx?=
 =?utf-8?B?TDVsUHRxdDIvU0ozYkJCRXMrS0ltOWc5dU42aUw4NVdLa2JRT3pCc2VTdTcv?=
 =?utf-8?B?dnpMaERDVVBIRElwSmV3Q2lDS0xqTW1iV3NBOVBQcmdSNUNwanVya2djK29G?=
 =?utf-8?B?OWZlaExPWWx3aUR3MGJrUFlyQ3d3ODFVNEtWWHpmTEdwaXUvenFCYjd0dDRn?=
 =?utf-8?B?bmhKU1RjOWVoNTBSVDdiRVlDTE1oeVNhRnNpSG5BMTFHa1BBc01ybTdPNS9E?=
 =?utf-8?B?Q1RseFhDeWp6QjJXMk5HZWxuTVZEOWVoOVpSWGhwRVRxOEZPSHI2cFoweUpL?=
 =?utf-8?B?TU5PR0VVaDNyQS80M2ZvS3ErOCtwL3hIWFhvRHZOUFArQjFodFR0akw5NVl4?=
 =?utf-8?B?RVBmRlRoV2dhR3F5elNOWEkrSlFUV3IrNjVTQTB6SWZ3R3lFQ1BrTUMzT3lK?=
 =?utf-8?B?eXVVV1g0Y1hNd2N1TjRrTkZXZFhGSVdOMHVzTFpGSTFyWDJiNTBwQkpqSEdu?=
 =?utf-8?B?RlZlbFQ4emcwd0RDVG51bXJQSThxbXVQdU5XUUxzcEFPclMrQk4vZWo1ZHRy?=
 =?utf-8?B?RnFCZjBQN3h1N3pHT3ovRzUvS1dPS2g5WlFjL1RPdDZUQlRnVnMvVGx6Y3B2?=
 =?utf-8?B?Qk1NemdtV25odlN4M0FlVU1YYVlUL3pzZWVxMVlzRS9adVl2K2pkZ2VicjV3?=
 =?utf-8?B?UWMvZlAwTXZmc3hXbDRNaFlHYmU1czRlWXI4cEpYT1ZPSFhXT1hVcktaT1pl?=
 =?utf-8?B?N3g0a1Z3NTJXamhXVUVBeHRyYy82TURDYjBGaUZCMmgxOFQwRmp4bXFsdGRk?=
 =?utf-8?B?OEFJZDZ5NEJpUFZvMGNUdlUyaU5Ham5FMlRCOEJkTTlIOGUxWUJDRmo1SEJ1?=
 =?utf-8?B?dVVUQm5Tek5DTFZzamVnbExSVlI3S2p0MVo1dGV1RlhqM2hNZFd3ZVlOenZ6?=
 =?utf-8?B?L1RNeldSMmhudnRDVUh3cGtqRTN1N0VOWmpsemtvSTU5YTZhRWhSRHFOa2ov?=
 =?utf-8?B?VFZXTGFZUE9qS0d6Q2JpbEdxRExNc0lHQXVxZWIwemdVWFUyYzB3YmZXcjN6?=
 =?utf-8?B?QUpOZUdmMHpvZlJvNVdxbHljcTNmMTZMdi81L3pyQkJmcTQzcVNWU1VOVTlB?=
 =?utf-8?B?VngrNmpiNE8xYmZSaFRsMWVmVWxMaXArQlJzOGRlN3VMTzJ1NmZxcDdKZytp?=
 =?utf-8?B?T3ZFb210V01BSFdidEFTcTBrMWVVeE1FcW1KZ1VqZ3lXRElTUXBQSDZNRS91?=
 =?utf-8?B?TFZZVm1rUnA2YnlUbVorMkRxSHA5WFFyM2cwcUdYUEthQkN5ajRNVzFua0gr?=
 =?utf-8?B?UWltN1Z0QkROZzhkWUlGemFXSHNFbERZekRaRmJ2V1hYeStKZnJGcEFYSGJH?=
 =?utf-8?B?Qktma0d4UU9kbTMwNzM3MTRNSkxXVU8zRkhVb1hzZkVQSGVBclVMNDI0cmMy?=
 =?utf-8?B?ZEhlVDB1TW5tVnFZRy81RVZHMkpVckYyYTFtZWhUeExMWlpuN1pVSDVQQVlH?=
 =?utf-8?B?OHQzOGxEbHFXVlBzZUlrbmovZlpmTmIxdDZDZ0hmVVNUYzV1VDloOGpYOWZ4?=
 =?utf-8?B?V2t0cXB6VUhJUUNFZHR6MW9xTGE4ajJINFFOVkJ5TWIwemdxRXduWjNxUmhw?=
 =?utf-8?B?d2lMZC9BZHduSWQxS2FhUXZRaXQ2cnlEZ1dKcTJ0SzZISlp0OHF1RStRc1hK?=
 =?utf-8?B?ZnVaS0NyYXNoMnRTTFBZTGRuSUpPd0lMWnA0NmxteENpeE9oelZ0Uk41N3cr?=
 =?utf-8?B?cEd2R2hkMEdVaGFpcUd4akY0QWRmQzZqQTZkWEZsbmNCWFhnOWJZbW9BUng4?=
 =?utf-8?B?ZnltbnRWVGxXRTk5NmZKa3hoUWJ2Uk1zbTRHRy9DZUc5MTdDK0NwVXBmNi9q?=
 =?utf-8?B?bGhJNjNlamRRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3U5RTg2SHdmSGZvQTQ0MVRPNGlEVmVJSUNjTGhCZ205cDFlVUtZNjZpTEZ6?=
 =?utf-8?B?cGJueERmb09TdEJPVGVKNW91a0JIb0ROR1pGQUlDcTJadkkyVjV1ZU9aSjYr?=
 =?utf-8?B?NUliTUtTaGlxZFZUTE8yaGxPak9MdnhIY1oyNzhHdUlTa0FPSjVoL1VRcGgy?=
 =?utf-8?B?amtBcVRYczZZcUhWQU9HbDBmbzBUVGFDVnpXVXJYZmZ4QjlkUFZpRzR5S1Fr?=
 =?utf-8?B?bG0vR1B0YjdYWnphMUZUOVlQbmx3d01peWlNSEhKc2F5d2duK0VGenNPbFNS?=
 =?utf-8?B?aHZoR1h6Y1hVTDk1TG5DZXBPYWRaeVhBMGxNV2szMUtZZXdTNThxVmhnSlQ3?=
 =?utf-8?B?R2RsRStWeE9ONzJIdmp0b0h4SVhkc1pwVVVPQWVKaHZQZklZMm9sNDJma0hw?=
 =?utf-8?B?N1pqV3gvOGtxSjgwbmRBcEg5ZnhrVitRVUh5VGRaTkVOUTVjbFZiQk0rcFFk?=
 =?utf-8?B?ZTlCakxZNlRFODloN2lrN2I0YlFaTUR2UXpYTlVPK2tXdlo1bGtNa2QrZFpU?=
 =?utf-8?B?MHFZVnhtUGlnamFMSnJqRS9qUlNZVTFpVnV3elFwaWZuTXlFY2puQ2M1dWY5?=
 =?utf-8?B?bjk5UkpnQTN6SS9pMzgvY29XNTdJam9UTzFSdGRueWxWWFRwZnZON0dvVnFM?=
 =?utf-8?B?QjBXK3FmdUFmekVTWVRJVGdVbURnNDhZalR3SDBQSUdoOXBZMXluOEwvNXBC?=
 =?utf-8?B?VlpQcTBMTnZ0Ym56STgzK3BtUDB0MWx5dHhMOW5menJ4ZGVvbFhDbTIxMTN0?=
 =?utf-8?B?UmVKU1Rack9iaXVIYmg2SnRVakpxTXNBdFRHeFJkbkNnMVd5OFM1U3hsR2tt?=
 =?utf-8?B?M2w1aHRGNXMwdWVDMTRlcEhzMzJYUnBqU1FyNXJ2MCtKQzRaK0tvcjlSREx0?=
 =?utf-8?B?T1VLRUMvb2lRNXpXem1DK2lJbjYzSEgrQUNzbmRjKy80NTNQbXZUT0hna1BD?=
 =?utf-8?B?VDVwKzk0MG9lY25GRWpNd1I3dU1uUEJLNTBwSThtYUFtZmZPRWR2dHRCN2Vs?=
 =?utf-8?B?eTVzVUNIZGoyNGNlWTdSSE1vWDdrbEFURm53bDA1aXMxdmZ5M29ncUNiK29s?=
 =?utf-8?B?VGo2N2VPR0l5VkRYZ09sd1ppQjJ4STMwMm54QTcrM1E3VjZpcG9sVFJCKzlv?=
 =?utf-8?B?WWpwcnhYQWxySjBoZzZDeXF4MkZkTTZHYWUzSTRNS1NMbFM4SVYyMzNta1BI?=
 =?utf-8?B?VmZCbnIycHJSLzNKdnpMQnhRMVFtclhKZHFlUGVmd2p5STZYd1dZQUxkbzVq?=
 =?utf-8?B?SExxbzdmQm0yTU1Cejh1YUFlSXRHMDVDMnNKRjFyMmtVby9QUDN5V3RCc2da?=
 =?utf-8?B?TTVhWWJpZGNndVVISlFZME1sTkRkOXI1NmZaRVNkVUZXVWpDWHFEZk5rY28w?=
 =?utf-8?B?a1IwM29tWGZ2aGdaNWFVREJlOVFmYThIRlVvQ2NxcnIydUNJL2ZaR0Zvek9k?=
 =?utf-8?B?Q1NrRTczUGVCMG5ZaTdWZmdzV3FQVmNyeGdmWGVyTHVnMHkvdEs1OW52Rjgz?=
 =?utf-8?B?bG44VFVLMjA1Qk5iNldJRUhQaG91emdYS3BzRTZCY256a2NFVGZjWmhldmFu?=
 =?utf-8?B?OThpSHQvTTdaeXQxUmxSR3lnWXgrTjk2a0NvZXBvWDhXODIySTFZM3FDS252?=
 =?utf-8?B?VTNuU3NYWWUrWE5nVndzUndFK1MxeGlUMGp5VGxlMkhKUXozMWJwWHNYaDNH?=
 =?utf-8?B?Y1NnclFDOGJyOHJYYUtuSkU0a0RyREFYcVJnenNJRG1XU2FWbUlzbEUrb1dp?=
 =?utf-8?B?NzZzWXBoMkFtajZHT0Fyb2F6SDU0OXR6clo5UStFVU9aYTVmMFUvU044V2tG?=
 =?utf-8?B?aVFDMTFJWUE4dmR0QzNHdXl0NEU0TFBCZHZLVDFyQnZkNUQ4MlprY00xOEtN?=
 =?utf-8?B?SFRVMU5LVXFiUDFBK1gybWIxVWpkT2ZlVDN3ZHRvOEcydWZuQjdwOFdwQkJy?=
 =?utf-8?B?TmdIZEVuS3ArWkdCbUpQYXFnSUpTRlU2ckRRQjMxbFpLUW9ZaVVjeGNBMmFn?=
 =?utf-8?B?QXRCblZHcCtNRlVqWVl6M0YzNzllaTR2QldZV29JaGFOWlFVQnhVTkYvbFRU?=
 =?utf-8?B?a3E1VHNkbEZBV3Nnam50a0JrNmk0ZldkQnhWM1JrbTJ5eVpycDN5Vk5WN093?=
 =?utf-8?B?cm1zQVBMa0Y4eU5FNHRtdWk3eWw1QllvdHM2aUU3WklYVTJ2TnBWTWJtdE95?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF1324469E909F40A71D7729A8DB4DBB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OA5YLhIGOWA1kVytn+kKAGsqklgqIJh8vIhc/nh74XQTKZRPehFTpgZYQqENm+//8wm9C49qyzUVOFHia0vR4i1Wd8STV4yHhvY+XcX96vHL2R81jlDltTFyIXbZuZMDWu+IU6CuP63OyWVZhCxnlGQjltt/cRI2SgBlqIUvKBCUTkPkJuRnI3/eGADe1cVtkTRTqNwuxAbZDklMEQoaxBKdEwZIYH+eonqN7pVeWRlCmM84d/xPyf2ZXV8WJli+WRO2rXD06MmKxoN5xYqStOh3uVhVX2Nor/fV/2pHq4sKfK+gBzGcy0LXxMr76TbIwmocimaXe1w/DHvBTgqDIYxMeXboW33ppl3Ai/cWIesZ9roaxz7wl0aWzJtwM/r6SDz7dZjfdQbuEFoDmXWuEzyT2XGHtjLMW8bp66yb2awQ2AQuIBGJe8JzYYosWdPY2OVAzQlJ4XTOKE/juudA36sUw2gSGcrGay/QfjCJMTlRsfwB7yL4fVRULkQTn3oNBrtyGHbkyybm5eopX9ullGD6RC24iUsfnIhRoOPz9huJ4LUFyZIugxzb9zk2PLuuogyj5m5eaWAkZOZmwpp0hIfhjrAs7OY61Kt4+BQUdM8506GQP5KaXtuHrNXpdjJJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 616bb6a8-2b75-48f3-b5cb-08ddf767d138
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2025 10:32:22.0253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CGIzY/iLfbrL2JByDexznbHIdx18qYXqv1+0fnEhcuB5w+W1pjvpeqXmdR0Cl3BoWWp3SLSIIRuRjWuvqp89WWjXTStlj3znAPJRzPqIpxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6836

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

