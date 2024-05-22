Return-Path: <linux-btrfs+bounces-5201-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EEB8CBD0A
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 10:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4A4C282C77
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 May 2024 08:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FCD7E57F;
	Wed, 22 May 2024 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G8Ev86PE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LuYv5yUC"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9DE6139;
	Wed, 22 May 2024 08:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716366671; cv=fail; b=s47L8lv+2p48vuts5xBOm6m1naCFGF0GDSQJRF4kbCf1176swco4LG4mLzTrlste5YpXyABZ4lLY4iNubOnFxvDSXUziU2/i2IjZQQ8HktBTmuJQgbvxLfTYVz0oipK9c7FFbZSgksVdmOotmkXyL+THrOT6lqq7ugUX6L5c9us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716366671; c=relaxed/simple;
	bh=Yknem4sW2uvIj+hdgKZXJ1Ps/FfO4UEekJqbtrVXZX0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mKmJ8D6upTUs6YFI0fw0Kyp8Mrac558i0Gp1MrpZ6HO4PzJFPwg8/hQyoAgHsN2GP8shCiCOhyRUI57NP47/DA/eEixDooDaeM5kShe5NxbszE4H5+9rIZl2bUe6XFSpxNBXHTjm7uLUrvUu2kVWJGazmy70awMa7653vS5odBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G8Ev86PE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=LuYv5yUC; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716366668; x=1747902668;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Yknem4sW2uvIj+hdgKZXJ1Ps/FfO4UEekJqbtrVXZX0=;
  b=G8Ev86PEICUHvzruBgZbTESHh3XgRUxTTWxIBuNGI0y1Pe4hH4od5OvA
   UJ1lyUrCsAUtUDGU8Tblusor1v+suvDZOHkPtx6zZPthrRstwGaLhGEKg
   XxI96bLG+KOQibD3SVvhSccB3wpGbdfLKtI1s9Xe1hWhY+wVNjLpX+LnR
   LyVpCmg/TnBXCDdLUuneqe1Td0vWhstPQT0GNGo69MdQEUj2HLGyH2ri4
   WKwbda+eKaHfl4FDITWnUdVZA+AVrLZsrHYJMswZYf5mKYmFgGFZF/wH4
   U3abavSZqLfIwxxZs75ZM7X/aslRX8Wx13djOhoRTf/b7wQXwejox5U+y
   w==;
X-CSE-ConnectionGUID: Y8aLGB+FRyik5fFfV6Hylg==
X-CSE-MsgGUID: cOGBz9vrSOaVsq0yX3Pi5w==
X-IronPort-AV: E=Sophos;i="6.08,179,1712592000"; 
   d="scan'208";a="16266154"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 22 May 2024 16:31:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3R2xJNRfTWgd4FBitgubyraQIHdH/dNyAleadv4PRqzDb2QMfspmFkzndqP9QXEC9QGqTurHlGK5+3R/PEhigA/f0ixSOgAOcI0LQwideGi38/zJje905kmc76/hoX2LtrZY2d0lwe7QdPgrHHhmA8+SUk5vyIQWhEFV/PATgqfQdb3Q+ErkoVk0bhKmzx4DTauuNYQ7sCWiS70kfVYy1OU/k6ocVQ7rgISIXLbVR+SVxDraH1SbxKpgROLYSSQktqFgdTXcP0RdhzDf/azLD8OCJYB5fKNGL4ve6GVbB/OKGPX/p+bfODPOpuHgtTcmBOETl/uLNGWr/N7ArepGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yknem4sW2uvIj+hdgKZXJ1Ps/FfO4UEekJqbtrVXZX0=;
 b=Hr5eOTisje+OhZZa8mG0lSp9BVHXjpCTIyV7DLhcwNrxOZAl//ml0FaoxxImwtSBP9dGhmU3N9G1HRlAOwZwTwweKHu/8KWOEg5oMyhR4ZiMBrNdegS4XB5Uj5GLt1QPbNs4CUxcpu8xVrIEjSiP6lrsNkb2RzHqXMfNEtbEIKCqYksDX1tTrE34nggHcQe/JOZ4bE43b16ecz/Iw48CbkvvIO1CD4kdZylozO/ioMkThDj7LLEftxkwsCOI9oUADkiQnRS4T3uodtkSqFJ1BYzGMDF4xSVwgKujQTIp4S7bDii4OrGT+VnaiHOD0dxs11u0nPGjaxoapMnXGP2o6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yknem4sW2uvIj+hdgKZXJ1Ps/FfO4UEekJqbtrVXZX0=;
 b=LuYv5yUCPgO/uHBUnSyNRLjDR+y5xT05jowB4F4W8hLUfN568C7iQ8NuOBQQkr3uKIAqoTRIgdT9K1IpZCPi3iZNxpNjq0zdKoJAFGDOriUBer6tXULbwbS34mu+orOQ+KWQjb2fdRMalX4hriZLmR62m4qBPQYCfUqN143xG0o=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8355.namprd04.prod.outlook.com (2603:10b6:510:da::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 08:31:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 08:31:00 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v3 1/2] btrfs: zoned: reserve relocation block-group on
 mount
Thread-Topic: [PATCH v3 1/2] btrfs: zoned: reserve relocation block-group on
 mount
Thread-Index: AQHaq49QVA3MzlT2fEG6JQzCVj1rAbGhzloAgAEfRoA=
Date: Wed, 22 May 2024 08:31:00 +0000
Message-ID: <122b5973-0191-44aa-b3e2-bdae52ce1f36@wdc.com>
References: <20240521-zoned-gc-v3-0-7db9742454c7@kernel.org>
 <20240521-zoned-gc-v3-1-7db9742454c7@kernel.org>
 <CAL3q7H5ONbcPnj=_+b2VeUvo9Y1BzPJ9Xh=WnaqmEnNUA0U4Kg@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5ONbcPnj=_+b2VeUvo9Y1BzPJ9Xh=WnaqmEnNUA0U4Kg@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8355:EE_
x-ms-office365-filtering-correlation-id: 06947b58-8063-4229-af92-08dc7a39828b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?SitvNWw3ZDA3amppYVNQK2VzQ092UGJRSGhkZWk2aUErMytBeWRKQythcXYr?=
 =?utf-8?B?bUtlMHlDaFVVTVhRRHZHU2JPQlArUjBwU3luRTNqUThjMSsrcGNmNkIzSFps?=
 =?utf-8?B?T3ZqNlBkT1FuRW83VVVlT1JRcUI3MCtEVi9SVGZvbWRJV1U0SnFjWUwwbHFo?=
 =?utf-8?B?TkoxU0N1YW90dHhTaVhGNGhzSDhwUkU5U3ZEeDNtZjN4TStqd0JZbCtYcklq?=
 =?utf-8?B?UHdtNHZSMmdGb0p3cG5NRWdtT285bVFBNTRHVnZ0WWUwbFZSMUU0Zm9CL3pC?=
 =?utf-8?B?bXEzemlCTDlxc2VzOTM2M2g4UTRsbllTQU04bk1BQTlDMHN2YkJRT0dDWEQ5?=
 =?utf-8?B?SGI4Wld1ZjRKVVppSWlqOHRLTXVrTzdSWlJmdUFUOVBTZDNZWUdxQVI1SUJD?=
 =?utf-8?B?Z0pvWjA3cmhpeURwRXF3RnFLNUxROHJWcmJTUlRpNzcxMnBvWXpHazVWQW8v?=
 =?utf-8?B?NjdaRG8rQ3lEa1JKUEtDM0x6dFVCbXlGczlsb0IyeU02aHV5RGt3UG5aR2tY?=
 =?utf-8?B?THVDajBETWM4MHFnTDg2RDV1QUdCQllkUlV1TWE2RjI2L0JjYkFxZWk4Qmlz?=
 =?utf-8?B?S3RabUdxQnZHSGFtREVKRnAvMkxXd2FNQUNHYjFGLzNQbHBsRytGTklKM3RQ?=
 =?utf-8?B?R2tXdndNY1Z3RXZtUm1iL2NIdFNyaGdUWEt6bU1DcW1wSStDNGZETS9FYkFD?=
 =?utf-8?B?SXlIS210MFNIN3Via0NNZ0t6YjNGTlBjaGQ2b3Y3RWJvcUdhb1oxMFJlWlJn?=
 =?utf-8?B?UUpIbGF6b0JnVnJCMkh2QUNWa25kN3BJdEhQdEd0V1VlS0ZqVzNmdjJFYXF0?=
 =?utf-8?B?aUtIL3U2Q2YzZ2RQQkxwTmlCemlrY3o3R28yL0RtTlFqTFV4T09abEVIWUZ6?=
 =?utf-8?B?UzBzQXUycUdwOTZqTmt1L1lOT1hZZDgya1g3SHdzU0xJOXpFRVJENldoSFFl?=
 =?utf-8?B?QmgwVXNQZGtSTWdvTnhVVmw3WWpSdUF2VTFxemJSYmI0eEFmd2F1Y0g5SDRu?=
 =?utf-8?B?U2hvVXZ1QW1oYXk0ODZqejMvMitSKzRPWjVpWVpzTFRtanVneExHZmJQVVBE?=
 =?utf-8?B?cVRSdW85Q1FUQVp1K201M040YWxPL3lZdHR6TnhudS9vZFpUYlZmYXRXZEVl?=
 =?utf-8?B?Y2ovQ0xUS0M5MTZ5ZHJSdWVLY0JpTndmS1ZXakV3Q0RVMnBKeVQrZDZjUTh2?=
 =?utf-8?B?VnM3MGNpb25zRG44WkVmcHRkOXE0RFFkTEF1YkpXNFRVTUtUUUJ6MFBKOGto?=
 =?utf-8?B?TXRLaGtlaW82TFhqeHo4YUc0a3UyNjhvUHZSbEhIYkpsYkdnQjMvQkFqMGdU?=
 =?utf-8?B?R1hxckdoVVFIdGw3dzZ2cWNDNzlIOTRHWkhqdnJoeXBENVVDb0xoZHd5Z3JN?=
 =?utf-8?B?dUhNUE5nZTdkdE9jQk0zRUJJNVhyZXhLMjg2UXB1NzUzU0Myd084RVRydEhj?=
 =?utf-8?B?U01JcVJMQ3lUY2IwUXBJYTErUFJ4TGVzbmpYWDg2dWIyTGd4TjRNZklmWWow?=
 =?utf-8?B?ZkkrM3JTT2FEcHFlVHROaVhISGNoNkxveksrdTVYcWltWjBuMkwxazRWYy8r?=
 =?utf-8?B?OXZLT1FPVWdSeHZyZUVHSjNXSXZLcTVSeHprSU9TK0FrVUlEUFdxYkphMEZi?=
 =?utf-8?B?enBlNFpyeGhkRm1Zb1FNSDJrcFR5V3FCaUtVbHh0Wlg0bTl0elV1U0pVL2ll?=
 =?utf-8?B?TlViWUY4dHpkOWlZRlNBWXMyNC8rUFhiNE9CZmhvbTErYTc3SGlWakZkNFBQ?=
 =?utf-8?B?U3RIWGhBamJzS0ZyaGVuaEkrZ0pSa3JJWGZoUXcxbkJxZjE2T2lXNFkvZUI4?=
 =?utf-8?B?dnAyNFk1c1BzaFVBN1Jidz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WjlOQjNLYk5xbEFoV25WNEZJdHBCUTNZWmF5cHp6VGJOcE12OWxmSDZpZTdj?=
 =?utf-8?B?TWRjS0pvY01PKytzUkNrSEFnSFNXcWJmbEt4bmxEQ3pqaUJyd2dGc0oyRjlT?=
 =?utf-8?B?bjZONkxtSW5iZ3RUdDhRRDRNMkhJblVlTTlvTWttSktQTFBia2NPT1dxQ05E?=
 =?utf-8?B?RkhmZ2haakVwS1VhTW05aUdNVzJqdVdNZW45ODVsV1VweWhHYlhOZDExbzZR?=
 =?utf-8?B?OHRmTmtSTDRRMEJiNVR0KzFWQVZ3djNlRmI5aEVTMHV2OEM2RjBzV1lZcEF0?=
 =?utf-8?B?VnJHd2NGL1MzWHJqWkovVGdVL0lYcy94eDgzaW1FVzVlempObUdjNWxhRXow?=
 =?utf-8?B?M202WWVTbHZBeUNEenl4N1IrdlRCVU9uRUFtUXVzSkJWWTZTUlM3Vmx5UG5X?=
 =?utf-8?B?Z2lPR1UwSjBhNlo5K3V1QXViaXYyYTJxTUkyNENYTlpVbVIrMjhnWEttamJV?=
 =?utf-8?B?bHRQTFBHRk51KzVYUllYT25uRWYwRDZwWFpoR0dXL1o3dXRRWG15TVU1d25v?=
 =?utf-8?B?Y2dXbjNyZmZTOHZXMHRNMTR1d3lWdlp2Q25BQlVXa3VFbkx2S0U2anY1UzVN?=
 =?utf-8?B?dG5VakJReW1MSkFzVjV0QXA1VTl2a0U3cGlKcTI2Ymw3TlpBS3VRSFdNUm9O?=
 =?utf-8?B?T1JSQlpzQTFaK1oxZUlYS0tweFpxVUM3REhYaVNScmxhYklIenVMdjRZMmpa?=
 =?utf-8?B?Y1V1akRtdHdkLzl2czVpYWYwaExORGVYbVRKSlV1eU1KVUMxVHlHQzQ1aVI2?=
 =?utf-8?B?aHVTamdkSjd2WFA2UzlXZDU4OEpVWHdRQVFpb2hsT2w3YjhNalI5RHhxUE1z?=
 =?utf-8?B?a0NwQ2tJZjRsZFk5Z2hlSVFHcDU5T0NUdC84MG9KTDBqNzRQaFEvZjZaRXFx?=
 =?utf-8?B?a29vcTFYTGxRS0lNSlRXOWc4YlAzWXllUktBSVExb3dyQVIxNnBkdklZU2xF?=
 =?utf-8?B?S3FHUjQzN2tnZ1VOQmxUckM1REdTdFZlcm9Za04yVkFVNFMxMUJwaXpialVO?=
 =?utf-8?B?aDRadFVaM2dpc2V0ak5XYVhVVnJPR1BqVllJbUMwYWE5bjE4VER2VE9BR0VI?=
 =?utf-8?B?ZmJrSjBuMnRUaU5lcHV3ZHhid0w3TEZmaHd6RXplbU5JeDdnNFhqc1NCRkxv?=
 =?utf-8?B?OTcycmh2NGdHQ3VCRGdnRUxseGVGSTJmdXlwVld1SHFsMVUzbDVpbHF1NVBM?=
 =?utf-8?B?cTAzVHJwZnBqUHpQMHE0Mk9COUtsNXRPN1FvQ3BHeFo5QWNtbzVWeVJUTXF3?=
 =?utf-8?B?ZDBMc0xiQUpSaE9XU3ArQVhJUzNpdGNZeWNraldYRHFzR291ekx0Y0Z1SU9a?=
 =?utf-8?B?UFlGbVhsUElNM2dMODcxMWRvSFIyaGZ3Y0laY0YxNWR3Ym1QODFab3BPUWI3?=
 =?utf-8?B?NUhZd0RZbG9HUXVweUlsUFV1dzJhRFd1TENFc0Q2ZTZ2TU5ua3A1a3ZvVDBW?=
 =?utf-8?B?YnJCUThuV0RYNWx2dGEyNDdJNklCZStTandaVlF3Nmk4eU8rdDFCeU93TDB1?=
 =?utf-8?B?YndtanNEa2pwVVlOVnU2anhtQW1ZakFWTzJrWmJQdEhPU0YveE5BcGU1dHVi?=
 =?utf-8?B?UGh2Zkx0S2JXUWJRN0laSm5QWXgzZnRaVVJpdmtOK1VBckYrU2ZlNFhwTjgy?=
 =?utf-8?B?Vk1JT0ZtTlF1K1k3Sk1nc3RCck5Ta3d4SkplTWNLV3d3dEZHVnNFcnVtWEF0?=
 =?utf-8?B?b0lFWE9wSjhRMUd0NGVwT2JZakJFRllncE1xVEZNbVdPNU1VVmR5QTMvL0M1?=
 =?utf-8?B?bHhZL0hWcVRGT2hjQnJCaC92d01NT1VkQmlIVG9SeWpVa2c5WTVTdEZQZ1Nw?=
 =?utf-8?B?UHVxNUlteSszalROcEVFb3Y1dzhGeTRteFN5anVUd1l0blNDUzE5NmdMWGNp?=
 =?utf-8?B?c2dBcE9QMWI2N3krc1ZhYS8wYnY5UHBLQmViZmtWd3lFWFNlV1p2NjlENURE?=
 =?utf-8?B?bVVKRXpieGphekFONmkwZ0tTZ3FVSUxvNHFVZVRsY08rTlZDRDZucU42SmJP?=
 =?utf-8?B?d0t1MnJYQmVZTU1rMk9rTUpPaTRxSUYybFozMnBUaVVVSGgrY0oyVlhJY0hQ?=
 =?utf-8?B?c0FnU0luODcvbU1Dd0pnaEt3S1Z4eng3L2xBaXpJNUsxYVJCU05VSHoyaWNK?=
 =?utf-8?B?TDFEbmxwTnZXSmFNVTFpMFNLbDYwbGhhYnFkNDZTMFRaUzZxVk4wQ3daWTVi?=
 =?utf-8?B?Y3hLdmQ4WFZaOG83d0o4ZVkyNjVyZWY3eE9CUmFMOHFDeHhWZmRsb1JobFY2?=
 =?utf-8?B?UnhwdHlrcTVOYnl2RnNmQU5xQ0hRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BBC5B444A7FA5E41A9D0A6780E2DCC4F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4OxYM2sNpWWUuzuwmr6DcJAqhaN48jqhSu07w3qJrQPEbP434xEAmc3pkOhEmrrJ824eIYn3vj/WJBe8HRXOy+17o60mSelGATAGQiCpjUspJ8hG+xLGKYWyHMQp8mjZvmIqXyppZK9iERgPNzqOPbBdEocQgURZPzOgm4hPtgZn2mguC3j/UO1p0/GwRQxIF2hJod33rBD8ODh+Dcmdj6/wRCVOb9Ca3tYiAZRkLWSJvNpnZXnbg2dFlC1/9a0wX9ynMRrBatl55LPNgQiSUzjVDZgu1H1Js4KXtyNN7sQpm9Nll2adU6XrLnyVOFCG4whZh7OFGHgF56z3DJ76pw9OSfk2HsarceY6bhWQsSWxodIXhlJYw/DXDLNUhT/li9RyTEPy1T9ygw/S6dT+9z8ql9E4VydRjTJEaOF3EAAlPWzmYoBSfAOa4SDOkRrTrlMzIK8UqB5Pkg6YKQdDHfSx9r2N/Hoci0J6ShsHbb1aRPte9ZBjL9momXhCjfk+Jsb49ahOwTeLZZUgRIXkhGUlsgteghWNnosdL3treUetwabtqM+PCJWv0fyY9tlwRnHbvvF1MATIbDI6fsDeoBqYzZSjsPFWVajq+7TTBCC69/CBjCPkcgY366eH0EPL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06947b58-8063-4229-af92-08dc7a39828b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 08:31:00.1632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bdztq55YQbl8mJb6sTnYvKJQtVKeJsij8G3IKhfj/cuyTGlM/R7qUgnw4MGeh0CjauEYKvk5ioRDZbn9dhbFU0gvRjxFuQCtOjENy9tZrik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8355

T24gMjEuMDUuMjQgMTc6MjMsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+PiArc3RhdGljIHU2NCBm
aW5kX2VtcHR5X2Jsb2NrX2dyb3VwKHN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpzaW5mbywgdTY0
IGZsYWdzKQ0KPj4gK3sNCj4+ICsgICAgICAgc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwICpiZzsN
Cj4+ICsNCj4+ICsgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBCVFJGU19OUl9SQUlEX1RZUEVT
OyBpKyspIHsNCj4+ICsgICAgICAgICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5KGJnLCAmc2lu
Zm8tPmJsb2NrX2dyb3Vwc1tpXSwgbGlzdCkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAg
aWYgKGJnLT5mbGFncyAhPSBmbGFncykNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29udGludWU7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoYmctPnVzZWQgPT0g
MCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGJnLT5zdGFydDsN
Cj4+ICsgICAgICAgICAgICAgICB9DQo+PiArICAgICAgIH0NCj4gSSBiZWxpZXZlIEkgY29tbWVu
dGVkIGFib3V0IHRoaXMgaW4gc29tZSBwcmV2aW91cyBwYXRjaHNldCB2ZXJzaW9uLA0KPiBidXQg
aGVyZSBnb2VzIGFnYWluLg0KPiANCj4gVGhpcyBoYXBwZW5zIGF0IG1vdW50IHRpbWUsIHdoZXJl
IHdlIGhhdmUgYWxyZWFkeSBsb2FkZWQgYWxsIGJsb2NrIGdyb3Vwcy4NCj4gV2hlbiB3ZSBsb2Fk
IHRoZW0sIGlmIHdlIGZpbmQgdW51c2VkIG9uZXMsIHdlIGFkZCB0aGVtIHRvIHRoZSBsaXN0IG9m
DQo+IGVtcHR5IGJsb2NrIGdyb3Vwcywgc28gdGhhdCB0aGUgbmV4dCB0aW1lIHRoZSBjbGVhbmVy
IGt0aHJlYWQgcnVucyBpdA0KPiBkZWxldGVzIHRoZW0uDQo+IA0KPiBJIGRvbid0IHNlZSBhbnkg
Y29kZSBoZXJlIHJlbW92aW5nIHRoZSBzZWxlY3RlZCBibG9jayBncm91cCBmcm9tIHRoYXQNCj4g
bGlzdCwgb3IgYW55dGhpbmcgYXQgYnRyZnNfZGVsZXRlX3VudXNlZF9iZ3MoKSB0aGF0IHByZXZl
bnRzIGRlbGV0aW5nDQo+IGEgYmxvY2sgZ3JvdXAgaWYgaXQgd2FzIHNlbGVjdGVkIGFzIHRoZSBk
YXRhIHJlbG9jIGJnLg0KPiANCj4gTWF5YmUgSSdtIG1pc3Npbmcgc29tZXRoaW5nPw0KPiBIb3cg
ZG8gZW5zdXJlIHRoZSBzZWxlY3RlZCBibG9jayBncm91cCBpc24ndCBkZWxldGVkIGJ5IHRoZSBj
bGVhbmVyIGt0aHJlYWQ/DQoNCkluZGVlZCwgSSBmb3Jnb3QgYWJvdXQgdGhhdC4NCg==

