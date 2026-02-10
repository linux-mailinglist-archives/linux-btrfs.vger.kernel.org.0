Return-Path: <linux-btrfs+bounces-21613-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHErJZ9Vi2k1UAAAu9opvQ
	(envelope-from <linux-btrfs+bounces-21613-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 16:58:23 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED6E11CDA7
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 16:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 443753005993
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Feb 2026 15:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBA93859FD;
	Tue, 10 Feb 2026 15:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f3KXc0ue";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ne1tKhqb"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810E1385EC2;
	Tue, 10 Feb 2026 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770739097; cv=fail; b=heql/U9jmlGXMppSCCKWgPujCnDIT79S3aee5ngSIQmVIexzYc9ObHMvf+uK8Fh/J7TccpS5fXlrlX1TnYBcGbp7hxF5yTzdANbycjJDOxv9iVqsesOrSJ5V8tBGzhF4QfngEWDQEMj7YiGVTVlx77PifAzb2P8aYTl/8X73Pds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770739097; c=relaxed/simple;
	bh=ycvEET9lkBG6ikowLQ18sKcQviafPtwWIq/XFQ7NCec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e1urXEtGiRkSREDChmjYhwi67o7EF5CjjsdJ9MNNO9Khk9MDMNgccnSxgah8vdoSth9CCNmH7bDfMDFUKDAhCCdD3LUjfYG/gR46T+mmh7IVdZNde21uwnFUI783/B/4SSPWpQ+k4tRVQTgpUVzQXaJOjcSzFrV+Yghi1V3KVwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f3KXc0ue; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ne1tKhqb; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1770739094; x=1802275094;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ycvEET9lkBG6ikowLQ18sKcQviafPtwWIq/XFQ7NCec=;
  b=f3KXc0ueyJvxj00h8EoJ8gZjQP2vI7eAECp07EwfeiP0ZYNaY8WeZcso
   M45fT82o4VR67k7d/TCPT7hhbbkQ1asGZQItM2k1DNnbra0Y8TU4764xX
   Rg4KM0IE4YwAYhOMVinowEiFufAOGbn5sAUAo1AIiNjpXD2kmlpt8VZZF
   9IG6XWE+uueZebOvjahLxUeKhkpWpcoWJUWHSeghd35k7pcywetZ61usu
   TCGLtuuTORMcHZKKy4vG6hWIANMF8e2lZdyY5d1xVPYH8hMnCcpBvOYLW
   zj6yXYVLoquOQKnhvzNMe5eUj6COZP/hs5KYvcgrDUZpcFGYfChxhnqFV
   w==;
X-CSE-ConnectionGUID: Sy7ZqhlAQb++PP6d1hT63g==
X-CSE-MsgGUID: RBjhFmigTfKTRWZkHxCVgg==
X-IronPort-AV: E=Sophos;i="6.21,283,1763395200"; 
   d="scan'208";a="140139000"
Received: from mail-northcentralusazon11012023.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.23])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Feb 2026 23:58:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rACZxkRi2B5lMu7ArJDtq0956ahCljP9Fb8QnR+DzSChkVO1vBMsUei0TLJY7Qpelz2qT1sKdjuqWV98xRq/ieg//B3/I8shFXBJ71xmSAdHeM7d6hHIg50TyT0XuuvuOaaXlD9S0+jo2KiqZtoFr/uQ8Z6n9I4fSZf/iXz5Xq3CJUIA2qHHeYYqrE8F01MeBGGRVZjyZ7DEdVIuYdeIO7nvlntL0AXrc51Hv0T3yfVuSHCxwev1sNEhlmIXiIG2vafZhXbgMGEbhrun2cZdoH0oaiVSfy0HHPPMnzu9N+A0HKWr2l6v+MFPr6h9aXuU3Idfmo7FXbwwp/OQm9kv8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycvEET9lkBG6ikowLQ18sKcQviafPtwWIq/XFQ7NCec=;
 b=I22SpIxLwJKOhPSDTProHJweK4O+/O6MRhEwREvlmGYbpEvrTOnt+LWkgreKuQKCfWas0BlyeVCCldkpg001VtdF95xEGkgsFJvudwxGExTFQ0NgtfkYqw1GzUYgz6jPBF45ukwYr9vFZGnRrhK4p3f15Y0mTWFqx1mpNkXllo9QfU2Yu0UM/wvoypYreK8BqFoLki8pF55fCrdK7ueiYkcdxZSm662cnlnfMwN2XSZxIE3k3bTDHu7NpqdIvVhm2YPtAU8cheaui/4PQJ3PPw1E6mSQtOnr+aCDBnQm4hCax7YalRGr50L6MoL8wKrL8yVNXQnugmEaxG7FFf7eBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycvEET9lkBG6ikowLQ18sKcQviafPtwWIq/XFQ7NCec=;
 b=ne1tKhqb1KvpZqhoE19B4vzF5QB7f3EY2eTE+stH0wcSyMjBq1RuGU8WWAno7B/EiD9/g5qJI1JKqV8COwGk+rWlj3oTfZCHvSZbU9gk1ogD4vOjcra39eh+c1GTW11+Ap/RksI29eqVBIO2IpkyPqjfPqz2LakrthuHwWm5QuI=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by BL3PR04MB8153.namprd04.prod.outlook.com (2603:10b6:208:348::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 15:58:06 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%3]) with mapi id 15.20.9611.006; Tue, 10 Feb 2026
 15:58:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>
CC: Zorro Lang <zlang@redhat.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "fstests@vger.kernel.org"
	<fstests@vger.kernel.org>, Hans Holmberg <Hans.Holmberg@wdc.com>, Naohiro
 Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Thread-Topic: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Thread-Index: AQHcmn380SEWYFJwgEKjj1PHhcZCxbV8FTqAgAAB4AA=
Date: Tue, 10 Feb 2026 15:58:06 +0000
Message-ID: <676f3219-c4f8-430f-b479-904cbb64d6b6@wdc.com>
References: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
 <20260210155123.GA3552@lst.de>
In-Reply-To: <20260210155123.GA3552@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|BL3PR04MB8153:EE_
x-ms-office365-filtering-correlation-id: bccdff0e-13a3-4bd1-2daf-08de68bd2e31
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|19092799006|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QWdoRkxRdWRWMVkyR0NnM2RTV3d2cFIrd1JEemRPVmFKRVgzcmpIditnNmRL?=
 =?utf-8?B?bmR2c3ovZXord2V5YmI0RGhxOUFJRGhhNGRSKzZ0L3pzN3VTN0tkTGhoWWZh?=
 =?utf-8?B?WWNQa2VsSUsyRWRkMFpvQ0tIL2JodEp2cjd6RmxWVnpLbkUvQy9LNlJ2czF3?=
 =?utf-8?B?Yks3SjBIU3dmZm1BSVJMQklZVHlQRUY3RTlOZjhaQm9GVnFDVG83NWoyME5h?=
 =?utf-8?B?dG9GL2xudzd3NzY4WXhqUDE0ZHdCaWZDVjNlMzRBS2loQ3FrakgwWHZrbkpQ?=
 =?utf-8?B?NVdKamFwaWNhVnlUNzNCeDIzeXlqN3hUWDJoMnROQm9HSk9nVE1RdjYzeGZJ?=
 =?utf-8?B?YVBFYXRhZWVoano3WW9QREw4eER3bWdYSjhiOXZ2dXRGRHZkb1RDRnZVbWg0?=
 =?utf-8?B?anAwYUJCMzZQc0pHTHoyVFUrRmpyQ29EYmYxN2xBYUd2VzdDYUhkYUNNekFP?=
 =?utf-8?B?aEFOU3pKaE1OLzd4bTBYKzdlMFo3K2d4RS9oNTZ5RThkQnlzcFNTVzErRGh5?=
 =?utf-8?B?ZEpyaHFxY0xpbVhYYVhzUjV0OWRPRlZjbEQ4QVVBMTYweTliNXVXRlFlV3Az?=
 =?utf-8?B?NW5URm1TNXZ4bktJMTBBV3hTbmdROWRjM3A3T0Y4ZWNOa281dnFWVHlVRXIw?=
 =?utf-8?B?VExROTRUSHRBNFdzdnU0YTRiZXdwWHRReWxwTVhOTU55UGRnUnB6aDlQcVQ0?=
 =?utf-8?B?ZmhCM0ZIdFZuSjJzcmovQ1YrUjF1cm53bHhmQ3FJSUVUY0tWT0ttcnBnSjJz?=
 =?utf-8?B?azAzaGgxUS9ScVd5MnpDb2g1dUt6VG00dHJJMVVmZ3dqbHlUSXJtZ3ZYTndm?=
 =?utf-8?B?UzJTTFF3YmRmQ21keUhEZmlwT0ViT2dsTVF6TnYvbVVMajhHQ1lDTmJoY1F1?=
 =?utf-8?B?bUZScWllTCttVzllemh6ZUtPaDM5eXc4cGRSN3B6YzJiLzBhUTlLTXRWTG9X?=
 =?utf-8?B?NWxKR2JWSTVUcEJMd1NBTUZDbVZua0tEWDFPaFA4N2Q0L25vWWloYmNmbERr?=
 =?utf-8?B?cS81OGRQclM0MG9SbnVzbngrMXpLR0lENG05UkxGM1FlbTViaUpaZS8wbUZE?=
 =?utf-8?B?SUN5SEIxSTNyOTVMOVVGRTVNa0ZGdnM4UUZuL3d2R3Z4WTlneHpjeWpwTE9J?=
 =?utf-8?B?WWpaV0xYanF2QnV5SVJRaFRPYXF3UHZReG5MWXF6NSs4YjBjckZaQXg1UFVo?=
 =?utf-8?B?aGFUMXFBR2ZFRENVS3J0RGhBZkNrWnVoTllveFdsSlRKMy80TWdjV3QrMVp4?=
 =?utf-8?B?alNLZjRIaldTSnpqeVFPMmFNRXJkdzk3cms1R1BsSWZ4SmY1c2hrcG0rOUNF?=
 =?utf-8?B?N3owSHVOWTdnWjVzS1c4Wm5FM0Y5cTd6TlI2V04vNytWcVczQlN5VnFBNldp?=
 =?utf-8?B?N1lkQ2tiRlNoQVJGK0V0bG84VjMwN2kyUFJCWlhUMjFHT2JPYjU2MWpjclox?=
 =?utf-8?B?TjZVbjB6QXlVdGR5YnhEN3pENUtFVTVibW8zUFJ5SElweEx1U2h3R21SczFT?=
 =?utf-8?B?bXVwZFIxQ243WjNIVXlaLzdzT2dZOUtWVFlmWE5aa1ZWNXV5aEhaN2p1bTZ4?=
 =?utf-8?B?OXRYR3k1aXkwRkhTbElPdUw1TUlyUzRRVWR5VXdtK1pyTHYwZ3libzYyRUh0?=
 =?utf-8?B?OHlTaUtIQlZFWnBoT3JnTVBZVVRvbUgxNFY0RDlUbjRjNlVHRTNoTEdGbUF6?=
 =?utf-8?B?WGNGczVyQjliWmkvT2ErOGVKSHFsYU5ZRnZqVk16KzdnK2xBVndKMVJlcS9x?=
 =?utf-8?B?RlprWmZVVlc5Nk9SNnEwRndUc1BPaHBIVUpqTkpLZWp2TXJZeTBLaDIvVnc1?=
 =?utf-8?B?dnB3czNCVC9FNVpScEwrdjZVVFNCYlVKZlVFRERaUHZYZDJQUlFtdDNlOWk1?=
 =?utf-8?B?RThid3pSS0lZVDNwYkVNZ0l0ci9VRmlORTU2bFVEVXVWTmVHaXducTJMR3dv?=
 =?utf-8?B?NlFXdENJRHc3R2ZuMk9uMjZGU1l5MmFsSGNuUDRMTmFHQS83NDc4NjZYRFJK?=
 =?utf-8?B?ajZhYzgwaVdNME5jT2xJb0FNZFNRcFc5bndjVEI5QnQ2Znhjby83bUhYSjVw?=
 =?utf-8?B?Qnhab29YUVFUMEVCVmw4S3djN3dhN0t4c2RpLzRqT0dvNzZqSkdIREg1WVQw?=
 =?utf-8?B?MG5KS1R4UStscjJkdmI3U0s0OEJZdVhERFlEYmozcmhocDlVMWorRzlnSzVH?=
 =?utf-8?Q?H3L0DdPig3nKtxWvQZD4o9U=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(19092799006)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEFqdm43QmR5UDR0YXAweFJ0bkxRWVZEVmxQSWtzaHRIRGh1NnI0dDdjVWM1?=
 =?utf-8?B?VU5MTitSdzJFcW9maEpEa0Jrd0JFTnc3SGphanRwekdFdmpsRlIwTkhNVnNX?=
 =?utf-8?B?WG9vMi9ETnIrMWNaQ1lsVm5hOTV5TEpBTkU3cmtSMWhCWUJGM0hDN0dlVk5N?=
 =?utf-8?B?Q01RZ2d0NVVIZUEvWjF1L2lTc0ZSOFVEcGZvcktmMk5SZmR1a29kaUdRWTdQ?=
 =?utf-8?B?OXJCTi9wMEQyU1Q2TzBQdTNxRHJqZGRUMDlCMlFka0FTYkh5czFBWGFzZzlY?=
 =?utf-8?B?aXVVdmEwcEYrVlVRNEV2VEplZHltYTkrQW1Fb1lORFkwcm5QYkRBVnpJNGJM?=
 =?utf-8?B?dGZ0YWk0TDZ0RDVXTEFkQzQ5UWw0MXNJWldLTkZvSVVQVnBDRlpmbDB1N2Ir?=
 =?utf-8?B?aDg0Um84ZHZOZWZiTFFueFkwUHNqMHZIVlRXYTViMUJBbnBWakJpUFFpUGxn?=
 =?utf-8?B?RWJtbGE5djlUcVRKN1BLTWVwenZZbzlpSTNNcHVtSi9peGVLSEhWdUVWMkJF?=
 =?utf-8?B?cy9NRkFWQTUzakFvNkFIdU9zejQ0Nk0rSGYwWkJ6WXUzVmJVSzF6VXhSbmJr?=
 =?utf-8?B?SjZoajIvZUZFdm1aeE9mT1RJSEhJSUx0OTgrYU5WUDU4YmpMcVVTam1mWFQ4?=
 =?utf-8?B?dEVtbU1mcTNqNTdreGlYb2NWSVltS0xuTXc4aHArRnhVaURGUEVldXFvcDE1?=
 =?utf-8?B?SHBwLzA4TGRhRTFTNitHN21FdUJVdiswdE9kcEduK1ptRUtLRy90S1NiL2hz?=
 =?utf-8?B?S3RCaFZUTHNtdm9FenlXRW5OZFg0SExKbFF2cElQVyttRjVmQWUrMi96SWdq?=
 =?utf-8?B?cjdTSzM2K0VNamxRclEvTDFuQlF1SjdPNXJWUk10RTBDVkVEY3dUbWora3Jz?=
 =?utf-8?B?RytqV1pML01vTXJPWlhBNWlBb3E4NENmMzlhR01IUmR6Vk0yVWlZTEE3NEJ5?=
 =?utf-8?B?N1BZcktENHdxVnlvWk5tejh6dzlTcWdUS2lYa1VXSXBnSi9WclhIMXhoT3Iw?=
 =?utf-8?B?RGNwTzdURUt4ZFVGVk5DcE9BRm9qZWcxaUZDMURnaCs4R1IycC9VVWtHTW5U?=
 =?utf-8?B?Zk5zWW5kWUo0V2s2clVzVjRqcWxjVzFhRmtsdkdKR0xScStiY3V2TGNQNkFz?=
 =?utf-8?B?b1V1UWJYYVk0TGhWZEpzdWhFZ3ZNc05yZFBNbC9xaS91RVVrSG5OSm5xY0RR?=
 =?utf-8?B?dFlvY2gzSXNPK2pQT0xWZlhhTFM3SEJSTUZZblVUUXVxVDVsZ0sxWFJxL1k2?=
 =?utf-8?B?bk1xNEVaM2puSjVGVmpnUXBPa3dqOXI5NWtIK2tZTk9pdGlrY0NYTkgyZ1Fu?=
 =?utf-8?B?Z0xNSWYwZU84R2hjRmlzMm5TMHMxZ0VFekp0MUNkZThKYlhia0FDZ1ZUVVF2?=
 =?utf-8?B?Tyt6QzdNMGI1cjE1Q1crUnlEYVgweGx5eStEZlhVaGNiWFdCY01UTTV5aFBz?=
 =?utf-8?B?VG5xaTJxWkM5bXR3bC8vUEJlbEZIMDN0aS9wb29mUjdLZjZlV1JIeEc0V2JF?=
 =?utf-8?B?NTNoZkZvcWdmYW1jMlV6c2ZnK282c3RWS04zSlVwL3RxY0NqdFdHNy9VdWM0?=
 =?utf-8?B?WVRJRUZTdVJ4ZUFsWmVqY21CUEtINExVMis4c0E3ejY0R2g5cWtpWFRiSzMr?=
 =?utf-8?B?Wk1pYmlLQ3NRb1N3dWNUWm82UzY2c3NtVnIvZlB2bWo1bVI5dXpibDk5dDMv?=
 =?utf-8?B?QmNHZHZNUE9mNlB0TEpZRXBlNHRSVEpSaXQ0MnpMcW5FVis2cjRKL2JCSm1P?=
 =?utf-8?B?ZU9ZalZtcnZEekM2ejl3b2w5SzhhVm9XUFQyLzJiVVFwRjJkdEFmRzhZWGMw?=
 =?utf-8?B?UVl5VFFsUDgwMFZPZXQvd2ZMemNTQ3BNYnRjcmJNdmpCSytDV2JtZU1aOEZr?=
 =?utf-8?B?b1JkVUI0SFl3bll0Mk80WktxQVhaWk5BS3dFaHhqOEdwVjdyRlJaSjRtVTEw?=
 =?utf-8?B?ZGxlQ2VZc0JnME95eWZPTzRRSjZkWS9JUmdvSDMyYVdqZFVQZTBFTWtoZWJG?=
 =?utf-8?B?YldieHdJTkRTWFhkQkZTVEkzdnh4a2YwSEFoSGtQcmZtQUpPWmxmR1kyVHBZ?=
 =?utf-8?B?MUNOVVRGTmFQc1dMNlBzdjFSaCtEeXFlSkNkT0dwVGcrWm1ScDN3QlZRMHR4?=
 =?utf-8?B?V280UXROV29TNU1OSURUalhZVFNxaXd3YStTQUpsNHZwOFJVNTVYZGlXaTRH?=
 =?utf-8?B?cVJjRmorYW1mSjBnNERuSnl4MUFCbTB1eUNyUWRyVjJLQ2Q0M1FwR0VaTnlp?=
 =?utf-8?B?K1lGWG9lbUJJUmM0L1JVS0NOSkhwVUExUTZuenNnNEpsSWFGSStPMit3SmhW?=
 =?utf-8?B?M25aZTZiWkk2S1N1cFFGTjlraERsR0FFVllGU3lTWnVpZkpEd3YrMmI0OEZM?=
 =?utf-8?Q?htzuXN8pD91H9sFdwW/PBbhDrf/NR6cleqLHfzoed44nP?=
x-ms-exchange-antispam-messagedata-1: tsrp7XWlVy+hIinIhC0PGP41Q/jUiOZl7yc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <40EBBB41408AFD4C8147A1370105512E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kYuEDLg9Jo5JwLggy63eSCgMkmSoYjYhZvCV51e9qxPd2xFbOariPNRG+6QAunz3yLu9r0xEl7qG/75RH0ePXIl6QbgPXL7DIHHf84wUCKxWIsDSNMDNr3MaNFpJJ37q8N6XUzV6zx4mMP+INK9Gz4MPB6TcecyAjp+xvbLLoXt+fzMlljKU13/FcLh5T0MG2zqA4IxJ2R8Tt6Ob2cBKDua8JUT/VxvkmhM9h1XyTb3IeCrxzSn5GzcPry8o8uzlFGw6lzbtTIRgLh+uM7AoKCvJDrPttpkKqemH+s8E7lWMj5fGf9jbwZR9KUtOgDrqVaV1jW3oNpnMkom3QsbhtnbGuUCBuE1rDSpGyOR11nd4ufVqzz1xVnKBiycIZqn7f6+HaZDqcD+hKhMGMy/VomGyaS8octT6J3JKPfzF+HKCcdkK4k3dKRNGrVA3g0VdtZwAVRfFq9wC/R9ohsY68ohVdo1ycx1uJt8u5E1AAoIVlrOjOdTNHhf49wkhMhgkRQ7oJHfC9cFYa7p/YBxPsukBYjLVE6+zNsQxQzhtoNiL4rqEBT1K+fb+jnqUBfFuy2ou5nIKm7fj4dARxl9mTVOaiVdz6qilk521dX864RB+iRRjgjoq4x9OqAtgv69f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bccdff0e-13a3-4bd1-2daf-08de68bd2e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2026 15:58:06.5905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DL4CHM270iNT1aHVrvQv8Ae0DFbQRHq90yxFXPwY6vHR+F7MBqpvT0eMwqPmfWDorVFKjgFeNtKSTCKbcH8SU0WFVZwo6J0ZJ0xG1ynmtIM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21613-lists,linux-btrfs=lfdr.de];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim]
X-Rspamd-Queue-Id: 2ED6E11CDA7
X-Rspamd-Action: no action

T24gMi8xMC8yNiA0OjUyIFBNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gT24gVHVlLCBG
ZWIgMTAsIDIwMjYgYXQgMTI6MTE6MDNQTSArMDEwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3Rl
Og0KPj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2dlbmVyaWMvNzgzIGIvdGVzdHMvZ2VuZXJpYy83ODMN
Cj4+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+PiBpbmRleCAwMDAwMDAwMDAwMDAuLmY5OTZkNzg4
MDNhMQ0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIvdGVzdHMvZ2VuZXJpYy83ODMNCj4gV2hh
dCB0cmVlIGlzIHRoaXMgYWdhaW5zdD8gIGdlbmVyaWMvNzgzIGhhcyBhbHJlYWR5IGJlZW4gYWRk
ZWQgdG8NCj4geGZzdGVzdHMgaW4gTm92IDIwMjUuDQoNCkFwcGFyZW50bHkgSSBoYXZlbid0IHJl
LWJhc2VkIGluIGEgd2hpbGUsIHNob3VsZCBiZSBnZW5lcmljLzc4OCB3aXRoIA0KdG9kYXkncyBt
YXN0ZXIuDQoNCg0KPj4gK2lmIFsgIiRGU1RZUCIgPSBidHJmcyBdOyB0aGVuDQo+PiArCV9maXhl
ZF9ieV9rZXJuZWxfY29tbWl0IFhYWFhYWFhYWFhYWCBcDQo+IENhbiB3ZSBwbGVhc2UgZmluYWxs
eSBjbGVhbiB1cCBhbGwgdGhpcyBtZXNzIHdpdGggYQ0KPiBfZml4ZWRfYnlfZnNfY29tbWl0IDxm
c3R5cGU+IDxjb21taXRpZD4gaGVscGVyPw0KPg0KPg0KTWF5YmUgYnV0IHRoYXQncyBhIGRpZmZl
cmVudCB0b3BpYy4NCg0K

