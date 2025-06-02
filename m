Return-Path: <linux-btrfs+bounces-14377-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15DCACAC93
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 12:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E10E3B942A
	for <lists+linux-btrfs@lfdr.de>; Mon,  2 Jun 2025 10:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114201FC0EF;
	Mon,  2 Jun 2025 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="j/obFqKE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QK0e6lSs"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EDF1D7E54
	for <linux-btrfs@vger.kernel.org>; Mon,  2 Jun 2025 10:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748860554; cv=fail; b=RWMX6duZ1EJuOeD43DOza2oQ7KULl/1A5Wycs5SeVYux3uZqokXOGOfjF4mQdRpQcd31dza75huy+C+HOv9PmhLiWbM9Ulpe/p5oDv6ea0avARWn6Hy1LspAyjfqtwgZdOmWQsbGDTrNZPIrE8WSrIplUEjUABLlcoGeiKv03v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748860554; c=relaxed/simple;
	bh=cElKRSDfIjdYR0HCG21ij/K7r3956C/DpTh5XTk5BMI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hePZWnidpqgXMEHAst6dEtFXbYwGF4PixZ799mshwTecnlOVzVExuvRbpjYzCmZjxZJDJQ7/vLtS+EWu/IxhWenLzsmjMzoh8lhekUSwG4bV1GChj3NgyrU/useDB4kAhYWGxa3rGEHFm+IisVQ7KqOBQQjoGfcs6AgHvZlW4zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=j/obFqKE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=QK0e6lSs; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748860552; x=1780396552;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cElKRSDfIjdYR0HCG21ij/K7r3956C/DpTh5XTk5BMI=;
  b=j/obFqKEaPuXqOBz+Wy9jZpzqDWkqFKjuK2hybqjIwbUocDWJH0pSSAB
   03fQ82jFfW/92HdUJJ8QgFP8GZ4WvGaiIl2HV+oQU1A5BZ8g7i2mZbR0z
   giN3zwT9wNrKViRcusAnQvj5nWr8jt12tSAPZTs+Q/XIiZkvXUr1EM6YW
   r4lK2XdVvK9TnPP2IMpD+oYzMr+Cc0WEzbB9U+nkmqx8wIxPxPGmO6iAG
   bCAEfXv8dK+6b1u9QD40gXt96D1OPtoQCIuwKXaJp5t4vSVBwm4ITBGnh
   ZFHCuJk291nvII2ZiWFDp1IabHvkj10182Kn5CJbDvSnBnUcgmWVdGnvQ
   g==;
X-CSE-ConnectionGUID: 5v93xVkJQCyekTm3uIMVyA==
X-CSE-MsgGUID: RoZxQ6IZQdyz5KwubRc3jw==
X-IronPort-AV: E=Sophos;i="6.16,203,1744041600"; 
   d="scan'208";a="83830620"
Received: from mail-westcentralusazon11011034.outbound.protection.outlook.com (HELO CY4PR02CU008.outbound.protection.outlook.com) ([40.93.199.34])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2025 18:34:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yq5uWPXVIQiwMy5SYVU4eOWFIDIYghbRYzQv5/mey3AVaMN4zXYvdHquyCbMonBaYqJXjHht6O8a4w1/5MjUY8HBFxsWZeYG93BG0FjbQF/2oo2ZyGAUco6H4a6jw+52T12w1XdIxRV8PVX+EhehTtOzeglW0BA3yyFlRcd/NLVTEGUBPJ2MfyHaEKwu6z3Pho6aiq/TJ+gjSae7utMMBhkmKld+RMnm+6BVlIIf1asCXMNssM39YWzMrZJpZ31WS3s7aIVhhRZx+t8LLud7Y9i3Mj0VrVuMUe+jq9aRsTh+9niNGdpDGggNxXDMYZyaqEARQpTlmcnqkuJljH3mJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cElKRSDfIjdYR0HCG21ij/K7r3956C/DpTh5XTk5BMI=;
 b=jFNgsfRKhTS6cZAaBcBb3hoGX4OYeDrhGEkmltR6Gt2hR9MKf1JhubXDRhTUHhIobKtiVBC321Ij4ygvVnOVTp+IaJiPx1tnj7IZLP9qxWofO4dP5uXWeRQPc8zGCjZth1Wow8fdZ7/7F1vMrHV5Mp8n1Oq0Stw0rkH84ppn8cq/NgkPN9FbtjdLgJjWY5mP7jDq3vz6qlnOiVtJFMfX2MUSg3VdYepIXvDPdu7sxEzdMNUBB93elqnPKbQfyn4IGJKH24F3N6KALUzYiNliCMtZFp42LZrQTz7LkXuUkkTAqhBxuB8/9v7MLrZJ9GraJFeeGRWzlwehbD4cu33t4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cElKRSDfIjdYR0HCG21ij/K7r3956C/DpTh5XTk5BMI=;
 b=QK0e6lSsAU57fhR6vy/H3jo9ByUBKotk4zKv9WdXPyCF+rb2mWYUgAzNgiT+Zw0ZTasBUVb9M6heNE7Y5gZ5YWKrB3zaaD2xWY8o+prri/o1dG5dLZLblWfTCkjx+07k7mg3WZGGdlP/tuI6KISDR+6qtQ4WCIlfZnT18Bd9MHE=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by IA3PR04MB9427.namprd04.prod.outlook.com (2603:10b6:208:514::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 10:34:41 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%5]) with mapi id 15.20.8792.034; Mon, 2 Jun 2025
 10:34:41 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, David Sterba
	<dsterba@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>, Josef Bacik
	<josef@toxicpanda.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v2] btrfs: zoned: reserve data_reloc block group on mount
Thread-Topic: [PATCH v2] btrfs: zoned: reserve data_reloc block group on mount
Thread-Index: AQHb04FFuaXol5tvdUKBr5w+Pig5X7PvqR4AgAADwwA=
Date: Mon, 2 Jun 2025 10:34:41 +0000
Message-ID: <c1f8c8c3-8b49-44f4-bb99-aaa8fab2f336@wdc.com>
References:
 <6133ab918b19507738e4fa08be23b73be0d8d84e.1748842937.git.johannes.thumshirn@wdc.com>
 <CAL3q7H5Nff5KVbqK9X7B2FJY2tuuQHZxaAe3CcyAT9Rwch8URA@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5Nff5KVbqK9X7B2FJY2tuuQHZxaAe3CcyAT9Rwch8URA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|IA3PR04MB9427:EE_
x-ms-office365-filtering-correlation-id: ee818f20-9de9-497b-1f40-08dda1c11532
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?d2Q3aTl4OUZMNkpXUERvQUFuMnBlSWZuTm1GQVNnVXUxeW84NmI4am5hdHZP?=
 =?utf-8?B?aDlKQjZXclJQRk1LNkZKZ2h5aXlXcFRZMlphcDJUMFBFVXB3bkd2VU9maXI2?=
 =?utf-8?B?YktXNlhRS2NUUE1yRXdTRjR0YkM3bHl4VVBjNTg2RmFMNFdLSy9RNzlad0Rm?=
 =?utf-8?B?RTN6ZUFwN1dVbDFGWG5IZWgxU2g3VmtZbVYwMGlEV1I2YlRxTjBCQ0hRVVoy?=
 =?utf-8?B?eHdsSlFXRUxUVEg5VlMrT3hYUk00emg3RTgzWk1IcWxyaTJIUzlaT1gzdGZH?=
 =?utf-8?B?emlkNHJwUjBEajRWVHpwUklISExyZ2c3ZC94QlNZdGduNWx6dEZYYlN0cGV6?=
 =?utf-8?B?SDNlMUJEcmFsZjZaeU45a1YwdjZrSVg5OWwzOFFSaVBaSEtGSzFCOU1hQ1VD?=
 =?utf-8?B?RllJV2RqQ3R6dnJLVlVOMHBmVzd0b096TXR0bWhxZ1lQSkFpQXZ1WjRsa05k?=
 =?utf-8?B?KzRPcEkreTA4dzRKU3daaGlDZGYzdlEwR1lyZndldGx1dWtVVEQ2NE1DUjZv?=
 =?utf-8?B?OHR1QTRacUtUNktUUHVWeVR2NkI1RnRmN2VxYUtOYlprd0xjM2RscnlJcm5M?=
 =?utf-8?B?ckk1OE5ubTBSL29PbUpQRldjTTJDK1pEeENIRzcwRnFIb0kzck9kNVNhdUtl?=
 =?utf-8?B?TityMGRwL0N0M3pxQ1lhY2xvVjl1bFZ4Wk1pYTJmMEZqbjVQcWR1TmxRYUM1?=
 =?utf-8?B?MWxoZ3JCUTJTSTZodi9UdzlXS2FoKzcxZXQ1M0EyNUlDTUI3K2tMNnBIOW5x?=
 =?utf-8?B?QU9HNnNKQTlZcGVJakdzdXpiS0JTWm9walVnbjJqcWdpRXdtWmRoTUltVk9X?=
 =?utf-8?B?Q3QxTmJPdE5pQ2VSSlc1bWNBT3FtakNzREtVM0tBM1hEazZDUzY0OVJobnpO?=
 =?utf-8?B?WGowb25YeXBUNElvNjhobnN1amFzSlFoN1VvcU1TaSs3WENvN2lJUVZrb1Z3?=
 =?utf-8?B?UVlsUGJLVGszNFdqMHdFdld0eDNyQVBRWUJMQmVpOVgzbS9FYUIxK2xjMDVD?=
 =?utf-8?B?TWVzaEhtZnNVK2dYYWRTWGtiRDlUa0x4K0pwLzJ4Y25VT29YRnhma1JUUWRl?=
 =?utf-8?B?N21KYmdiY2IwQ3hSbTRrNk1sMzkyejN5VkVicW9uN01UNzdhUWZaKzFUd1Nh?=
 =?utf-8?B?OC9JMDRaVlZFeVlwUDljTVdRcXRaUWN0SnhjUUZhTnFSTjlFdFRmMngvQ0pS?=
 =?utf-8?B?V2taY0Izc3JWa2k0MnF5eFlqbXFObW9iRXVZeFRNeGw3K3V0cDdFZlo3NGlL?=
 =?utf-8?B?a2hkbGUra29iM1dTbU93bC9LNWl6aFFjdFBJaWJGSzRVOVViK0JHbGxPaHpy?=
 =?utf-8?B?b2FkRHB2V1FoL09UWHdmcFJ4MjYweTlpVWxGN2lFQWRmTEhhYkVBZXhra0Fs?=
 =?utf-8?B?azlnS1ZaaG1wbWxKcmlBN3ppQ041enJDVy9WZDZwMEZwRHhlcjZscHdDUlow?=
 =?utf-8?B?aU43RDQvQ21nNFlYdHBXQURoSm1NZXhHclAxRno1OXJaYVhmZ2dzZGhEQVVv?=
 =?utf-8?B?d1F2MXFwVC8yTUFudjZLQ2x5VGoxOTU1dllDMzVMb050M09QT0dEWkxvRHEw?=
 =?utf-8?B?WDFRUDNFY1puQkxTSzNmMDhtNjRLRzh5MzhGb0dreDR5Y3ZMSmlnOFMyOEg5?=
 =?utf-8?B?b2Y4eEJIOVNpS2I2d3pFR2k2UXc3RHpvM1VsM2QzaEFrWitOT1VyRmIzOHlm?=
 =?utf-8?B?TTBUS0Q2MTVUemVMUEdVRFIzQkVUN3BEQkVBeGZOTm15VE10R2ZnVDFaSUhw?=
 =?utf-8?B?ZnozSW9vM0Z0ZnBNcmRDN0VkeUpVczBVemxINXdTcFNkQ0VZZWlNcXZqOHc0?=
 =?utf-8?B?ZzlrVHYwVjhPWXIvNVZJNzd6TUxSZk1hSW9JL0R2WEgxa255VnY0YnJjcEpr?=
 =?utf-8?B?OWVtYUhrY2tGVllTbTkxNURGSEtaTzdYdDk3azhFeFpWU0FZYVhqbXhjclR5?=
 =?utf-8?B?ajRoMUNnTVliVnhXZGk3S0preWdTMHpJVVNWM0hwMVdFaityMWxNRDdvdGdN?=
 =?utf-8?B?TFE0SUsrRURnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzMzK1gzMENqZUtYZ3Z4Q05zdlpNUU9TQjhDeS8vakFMbXhkUTNWcmJCZGNu?=
 =?utf-8?B?c2NVOVZVOGZQNGVyeWY2T0p1TVhXQ0h0bXlEWkJUeUdsUWNxZFZ2c1VrZktE?=
 =?utf-8?B?emVFTHFRS0xoT0xCUXJGdGRpZEgrTk9TVXZaTjZjSVJzY1VWWDFUUk5ObFFt?=
 =?utf-8?B?azU5QWpzRk5ldjZwaEpHckY2YWgrNStHZDZVM2xSYTZ3MFhjYjZiZUE1dDBU?=
 =?utf-8?B?Qkk3Qk0vQUxsSmxQSU9vYXRtdnFSTmdVOWd6c29lK3VYZ1BlNE1mcmdkWDBL?=
 =?utf-8?B?bEdEYlVrd1RqU3BWcFR2Tm15OEpONzRvOEF0V0Z3VWQ4M1UzSUxwUTdrLzhV?=
 =?utf-8?B?VkNjUkl1SzZQK1lXb0ZpSG1zNVVLVmMrUXdFSzFzY2lyR0M5M1ZRTkcyb1Rr?=
 =?utf-8?B?akNEdGljbytUMDVhTXo3SzdzMnloeGplWEVCTDA3TjhCc2QrbmdSeU9OS2xw?=
 =?utf-8?B?dnU1UnptUWJKcHVtRnNmNmUzdlNLd2Q5NWhLZEJXWWZ6YjJjNW1GVy9aM3Iv?=
 =?utf-8?B?T2hsS05SYzlha0VQVVgvS2pVNEpQZVl3K01UYSswOHcrYjZPMk9OVVRtU1dB?=
 =?utf-8?B?eGVrMVlORENYQWdUTWJ0Wm1GWnRNOWt2bUpQQk1JS3J6R2FmSng0SjdidDcz?=
 =?utf-8?B?NjVOVEljOXhwRWMzYytpMlhzZmQ2aGFjU09VTjM3OTVGUnBCcGF1TGovTmFQ?=
 =?utf-8?B?dUU2bDI3RDZwU3hUUGRQdllRd2RZek15bzd6elU1M3dyT3REUTVYTE5DdDlW?=
 =?utf-8?B?WUFFRUVCeHp5MDRJM1JpWkJsVko2VzNIQ3ZIdllvOFFWeDIxT0Z4UzFxenI1?=
 =?utf-8?B?TlA1SWNVU2czUzJnWHhzMXdzVW5GTVpzMjhseFFsak81TEQ2VnlIRWlQL1BR?=
 =?utf-8?B?Sit0U3BnRXA3STdiOUFCMGdzTHEvNWRSbDMrY1F0bFAxOU1BTFo1Qkxwd2hN?=
 =?utf-8?B?Z2NwSkZGaHJxSC9tR3pxM0tjcllibDVmcU9JKzZZRmxtekt0L2hYbTMyOCtI?=
 =?utf-8?B?cjVnanVrajBYVldZSHpsRnRabHdwZHBIUVpoYXE0dmJZNFk1aUFCYXlnTzcv?=
 =?utf-8?B?UWZEUTRIWUZvRG5YMWFaOTRndE9QWk45T0MrWEFYMnY1WXdpMGc1MDB1TzFn?=
 =?utf-8?B?bDV3SVRjaTdPNU9pem9IVnJJQnBPSEcvTmsxVVJHL3VEQzdQRVVjTEZPaHhH?=
 =?utf-8?B?RUQyZWZudHdzSW5BTTFmWllFV2VsdHhqRkU2cWtRMUR1aWRwQm5KMjhxOWw1?=
 =?utf-8?B?N3o5UGQyVHRhTUlBTkljUWlNT2hKRkpaUzFzS0QxMkNNN1RuYUI5dFFkRHVF?=
 =?utf-8?B?dHIwUkYxUlBLUnZlRXE3Q2trTW54amEyejJyUmhBc21Bc0JScENDZnk3QlBJ?=
 =?utf-8?B?M3VWTGZRZW5IZ0pEd1N5YWxoYjdBN1ZEaHJWSm5wYUNsd29IbkJOM05DbnRI?=
 =?utf-8?B?U01JdGtnU2RiOUJHTElFTWo0UDZZM1Z0Qk5pYUxWY1lKTEQ5ckNFV0oyUzAr?=
 =?utf-8?B?WWVTK0xBU0o0SGkzN3NMSnlJT1BZbTZKV0l5ckNQVEZkTElSVlNpUGZ5ZjBq?=
 =?utf-8?B?T0JLZkFUTHlJR005WVltLzlhVVdZQUdXUXZ4US80dzNEUWZzajNYK1plWGFL?=
 =?utf-8?B?VmJBVjYzT3hpYk1MQituYWZuY2t5TEZha2lzbG5FTlhGd29COEJkMEJWZnFQ?=
 =?utf-8?B?aGV6N2RJbkp1bWp6elNUcnBINTIrWldJalZRVy9GSEZBdVNFajdtSXJsajRJ?=
 =?utf-8?B?TFhjQytDZDlEa1RFeFBZTXZ1L3k0cldnZ3paVk1VZ2NKZVZYZ3ZJa1YwUUZw?=
 =?utf-8?B?UzVSak5ZUy9IWS9XUW9NZytqL1QrU1BTWlJpaWtPNXJjR3dEN2VxR1VRQm9B?=
 =?utf-8?B?QTRtcEpOS2dRSjJxc1ZNQjhmTjB6M3pFUkhGSmhMa25nK3NyZVJmUk9lZmw5?=
 =?utf-8?B?UWw0dHpRWFRwR0RkSFNJM2xIL3hSRC9Idnk1dzFiNXhTVDk2OWdUOUREVkdK?=
 =?utf-8?B?NmwzRC8rRERVcGZBNHIzOUVadEFtVHg5Q2FyRzVJMEdYTVJyTmVDallSN3NP?=
 =?utf-8?B?ZVVxWmY4L3A2My9tUTBUTHQySWhaaWR0NnlvY0xIRTNtdnE0MW9oY1cxeTlU?=
 =?utf-8?B?Y0dTS0RxOVU3UFZDbWZBb2NoOUcwYUhCWlpLVnozKzZGVjFDWDhTLzdvM1Nu?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73BE9280D9FB484FAA0DCBD853B024C2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l3r+NOl1YFXaHFlid3XsUArOI0UQXOlwhcDsJNiQe05GeAH9XqVwQFPcDa+sv8Gp4Q9k3dxe8sE0H1Xq7G5BXOVH6Y74MNq7CJu8mE/QObVXQRLxx1mMN1kmPNsIdg4DdRMF5QNEzRNg2wc185I90IuAcUKm0/gKcDl241XMzBsJPM+/LU1rkVY2eH2EmTwHOZ02zdspigJpVKA40w8v3uM6r2PoCbyBlcayinjjIyEw9gI7msC+t/DGPI1MrVmEKh2hY53ADJYfny9bqQNKFnbUQ5mTNGA5nXpZ+pbtiBjMLNpmrzKXwSw6i3GMOOMWaZfVYB1ee7w0AiGjSXJEbgB5EdDGaJzuMPJHcVWv8w6Kn2DzBUwVFNb2LP7fS6ah4YiDjOZCil/RYMmPIdyuophThUQf3OhF7+Obag1udLWiCY/OknGUjP4rBRaaeO5LfjgkqWPf4yhqmR2Aox6OXS0l+RgEP6idm3sNtzU9iGwpqQgOC+5+duC/IRu2j06rY7Fl1biULbvnAz6YVfVn+Fpc6DEPrdZeJ6ws42rTP4VRZMXyeH1x2hFgdRQsRl5PO+v6vEijsGSOF+ZzG0rJ/Hpg5bm71yKTOLaYW3ImANppg45wl4BD9t6XR67AiIU4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee818f20-9de9-497b-1f40-08dda1c11532
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2025 10:34:41.2621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ho7cjRX31TR0iqjHDdq+g6uyK8BmHejRPaePIUvRRbgSpIyTORq0GQHYvfVjrAIJ8imDn0aFLvlAfk2ETJFX4Kr7b0zk65OTmWDtMRDC6ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9427

T24gMDIuMDYuMjUgMTI6MjIsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIE1vbiwgSnVuIDIs
IDIwMjUgYXQgNjo0M+KAr0FNIEpvaGFubmVzIFRodW1zaGlybiA8anRoQGtlcm5lbC5vcmc+IHdy
b3RlOg0KPj4NCj4+IEZyb206IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJu
QHdkYy5jb20+DQo+Pg0KPj4gQ3JlYXRlIGEgYmxvZyBncm91cCBkZWRpY2F0ZWQgZm9yIGRhdGEg
cmVsb2NhdGlvbiBvbiBtb3VudCBvZiBhIHpvbmVkDQo+IA0KPiBibG9nIC0+IGJsb2NrDQo+IA0K
Pj4gZmlsZXN5c3RlbS4NCj4+DQo+PiBJZiB0aGVyZSBpcyBhbHJlYWR5IG1vcmUgdGhhbiBvbmUg
ZW1wdHkgREFUQSBibG9jayBncm91cCBvbiBtb3VudCwgdGhpcw0KPj4gb25lIGlzIHBpY2tlZCBm
b3IgdGhlIGRhdGEgcmVsb2NhdGlvbiBibG9jayBncm91cCwgaW5zdGVhZCBvZiBhIG5ld2x5DQo+
PiBjcmVhdGVkIG9uZS4NCj4+DQo+PiBUaGlzIGlzIGRvbmUgdG8gZW5zdXJlLCB0aGVyZSBpcyBh
bHdheXMgc3BhY2UgZm9yIHBlcmZvcm1pbmcgZ2FyYmFnZQ0KPj4gY29sbGVjdGlvbiBhbmQgdGhl
IGZpbGVzeXN0ZW0gaXMgbm90IGhpdHRpbmcgRU5PU1BDIHVuZGVyIGhlYXZ5IG92ZXJ3cml0ZQ0K
Pj4gd29ya2xvYWRzLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+PiAtLS0NCj4+IENoYW5nZXMgdG8gdjE6DQo+
PiAtIEZpeCBidWlsZCBlcnJvciB3aXRoIENPTkZJR19CTEtfREVWX1pPTkVEPW4NCj4+DQo+PiAg
IGZzL2J0cmZzL2Rpc2staW8uYyB8ICAxICsNCj4+ICAgZnMvYnRyZnMvem9uZWQuYyAgIHwgODQg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4gICBmcy9i
dHJmcy96b25lZC5oICAgfCAgMyArKw0KPj4gICAzIGZpbGVzIGNoYW5nZWQsIDg4IGluc2VydGlv
bnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvZGlzay1pby5jIGIvZnMvYnRyZnMv
ZGlzay1pby5jDQo+PiBpbmRleCAzZGVmOTMwMTY5NjMuLmIyMTFkYzhjZGI4NiAxMDA2NDQNCj4+
IC0tLSBhL2ZzL2J0cmZzL2Rpc2staW8uYw0KPj4gKysrIGIvZnMvYnRyZnMvZGlzay1pby5jDQo+
PiBAQCAtMzU2Miw2ICszNTYyLDcgQEAgaW50IF9fY29sZCBvcGVuX2N0cmVlKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsIHN0cnVjdCBidHJmc19mc19kZXZpY2VzICpmc19kZXZpY2UNCj4+ICAgICAg
ICAgICAgICAgICAgZ290byBmYWlsX3N5c2ZzOw0KPj4gICAgICAgICAgfQ0KPj4NCj4+ICsgICAg
ICAgYnRyZnNfem9uZWRfcmVzZXJ2ZV9kYXRhX3JlbG9jX2JnKGZzX2luZm8pOw0KPj4gICAgICAg
ICAgYnRyZnNfZnJlZV96b25lX2NhY2hlKGZzX2luZm8pOw0KPj4NCj4+ICAgICAgICAgIGJ0cmZz
X2NoZWNrX2FjdGl2ZV96b25lX3Jlc2VydmF0aW9uKGZzX2luZm8pOw0KPj4gZGlmZiAtLWdpdCBh
L2ZzL2J0cmZzL3pvbmVkLmMgYi9mcy9idHJmcy96b25lZC5jDQo+PiBpbmRleCAxOTcxMDYzNGQ2
M2YuLjQ0NmY2Y2VlMTBjMiAxMDA2NDQNCj4+IC0tLSBhL2ZzL2J0cmZzL3pvbmVkLmMNCj4+ICsr
KyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4+IEBAIC0xNyw2ICsxNyw3IEBADQo+PiAgICNpbmNsdWRl
ICJmcy5oIg0KPj4gICAjaW5jbHVkZSAiYWNjZXNzb3JzLmgiDQo+PiAgICNpbmNsdWRlICJiaW8u
aCINCj4+ICsjaW5jbHVkZSAidHJhbnNhY3Rpb24uaCINCj4+DQo+PiAgIC8qIE1heGltdW0gbnVt
YmVyIG9mIHpvbmVzIHRvIHJlcG9ydCBwZXIgYmxrZGV2X3JlcG9ydF96b25lcygpIGNhbGwgKi8N
Cj4+ICAgI2RlZmluZSBCVFJGU19SRVBPUlRfTlJfWk9ORVMgICA0MDk2DQo+PiBAQCAtMjQ0Myw2
ICsyNDQ0LDg5IEBAIHZvaWQgYnRyZnNfY2xlYXJfZGF0YV9yZWxvY19iZyhzdHJ1Y3QgYnRyZnNf
YmxvY2tfZ3JvdXAgKmJnKQ0KPj4gICAgICAgICAgc3Bpbl91bmxvY2soJmZzX2luZm8tPnJlbG9j
YXRpb25fYmdfbG9jayk7DQo+PiAgIH0NCj4+DQo+PiArdm9pZCBidHJmc196b25lZF9yZXNlcnZl
X2RhdGFfcmVsb2NfYmcoc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8pDQo+PiArew0KPj4g
KyAgICAgICBzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbyAqZGF0YV9zaW5mbyA9IGZzX2luZm8tPmRh
dGFfc2luZm87DQo+PiArICAgICAgIHN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpzcGFjZV9pbmZv
Ow0KPj4gKyAgICAgICBzdHJ1Y3QgYnRyZnNfcm9vdCAqcm9vdDsNCj4+ICsgICAgICAgc3RydWN0
IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMgPSBOVUxMOw0KPiANCj4gVGhlcmUncyBubyBuZWVk
IHRvIGluaXRpYWxpemUgdHJhbnMuDQoNCk9LLg0KDQo+IA0KPj4gKyAgICAgICBzdHJ1Y3QgYnRy
ZnNfYmxvY2tfZ3JvdXAgKmJnOw0KPj4gKyAgICAgICB1NjQgYWxsb2NfZmxhZ3M7DQo+PiArICAg
ICAgIGJvb2wgaW5pdGlhbCA9IGZhbHNlOw0KPj4gKyAgICAgICBpbnQgaW5kZXg7DQo+PiArICAg
ICAgIGludCByZXQ7DQo+PiArDQo+PiArICAgICAgIGlmICghYnRyZnNfaXNfem9uZWQoZnNfaW5m
bykpDQo+PiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPj4gKw0KPj4gKyAgICAgICBpZiAoZnNf
aW5mby0+ZGF0YV9yZWxvY19iZykNCj4+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+PiArDQo+
PiArICAgICAgIGlmIChzYl9yZG9ubHkoZnNfaW5mby0+c2IpKQ0KPj4gKyAgICAgICAgICAgICAg
IHJldHVybjsNCj4+ICsNCj4+ICsgICAgICAgc3BhY2VfaW5mbyA9IGRhdGFfc2luZm8tPnN1Yl9n
cm91cFswXTsNCj4gDQo+IFRoaXMgY291bGQgYmUgYXNzaWduZWQgcmlnaHQgd2hlbiB0aGUgdmFy
aWFibGUgaXMgZGVjbGFyZWQuDQoNClN1cmUuDQoNCj4gDQo+PiArICAgICAgIEFTU0VSVChzcGFj
ZV9pbmZvLT5zdWJncm91cF9pZCA9PSBCVFJGU19TVUJfR1JPVVBfREFUQV9SRUxPQyk7DQo+PiAr
ICAgICAgIGFsbG9jX2ZsYWdzID0gYnRyZnNfZ2V0X2FsbG9jX3Byb2ZpbGUoZnNfaW5mbywgc3Bh
Y2VfaW5mby0+ZmxhZ3MpOw0KPj4gKyAgICAgICBpbmRleCA9IGJ0cmZzX2JnX2ZsYWdzX3RvX3Jh
aWRfaW5kZXgoYWxsb2NfZmxhZ3MpOw0KPj4gKw0KPj4gKyAgICAgICBsaXN0X2Zvcl9lYWNoX2Vu
dHJ5KGJnLCAmZGF0YV9zaW5mby0+YmxvY2tfZ3JvdXBzW2luZGV4XSwgbGlzdCkgew0KPj4gKyAg
ICAgICAgICAgICAgIGJ0cmZzX2dldF9ibG9ja19ncm91cChiZyk7DQo+IA0KPiBXaHkgYXJlIHdl
IGdldHRpbmcgYW5kIHB1dHRpbmcgYSByZWYgb24gdGhlIGJsb2NrIGdyb3VwPyBUaGVyZSdzIG5v
DQo+IG5lZWQgZm9yIGl0LCBnaXZlbiB0aGlzIGlzIHJ1biBpbiB0aGUgbW91bnQgcGF0aC4NCg0K
SSB3YXMgdGhpbmtpbmcgYWJvdXQgdGhhdCBhcyB3ZWxsLCBidXQgdGhlbiB0aG91Z2h0IGJldHRl
ciBzYXZlIHRoYW4gc29ycnkuDQoNCkknbGwgcmVtb3ZlIHRoZSBnZXQvcHV0IGRhbmNlIHRoZW4u
DQoNCj4+ICsgICAgICAgICAgICAgICBpZiAoIWJnLT51c2VkKSB7DQo+IA0KPiBTaW5jZSAtPnVz
ZWQgaXMgYSBjb3VudGVyIGFuZCBub3QgYSBib29sZWFuLCBwbGVhc2UgdXNlICI9PSAwIg0KPiBp
bnN0ZWFkLCBpdCdzIGEgbG90IG1vcmUgY2xlYXIuDQo+IA0KPiBBbHNvIHRvIHJlZHVjZSBpbmRl
bnRhdGlvbiwgdGhpcyBjb3VsZCBiZSBjaGFuZ2VkIHRvIGRvIGluc3RlYWQ6DQo+IA0KPiBpZiAo
YmctPnVzZWQgPiAwKQ0KPiAgICAgIGNvbnRpbnVlOw0KPiANCj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgIGlmICghaW5pdGlhbCkgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBpbml0aWFsID0gdHJ1ZTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnRy
ZnNfcHV0X2Jsb2NrX2dyb3VwKGJnKTsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgY29udGludWU7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+PiArDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICBmc19pbmZvLT5kYXRhX3JlbG9jX2JnID0gYmctPnN0YXJ0Ow0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgc2V0X2JpdChCTE9DS19HUk9VUF9GTEFHX1pPTkVE
X0RBVEFfUkVMT0MsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZiZy0+cnVu
dGltZV9mbGFncyk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICBidHJmc196b25lX2FjdGl2
YXRlKGJnKTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgIGJ0cmZzX3B1dF9ibG9j
a19ncm91cChiZyk7DQo+PiArICAgICAgICAgICAgICAgICAgICAgICByZXR1cm47DQo+PiArICAg
ICAgICAgICAgICAgfQ0KPj4gKyAgICAgICAgICAgICAgIGJ0cmZzX3B1dF9ibG9ja19ncm91cChi
Zyk7DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAgaWYgKGJ0cmZzX2ZzX2NvbXBhdF9y
byhmc19pbmZvLCBCTE9DS19HUk9VUF9UUkVFKSkNCj4+ICsgICAgICAgICAgICAgICByb290ID0g
ZnNfaW5mby0+YmxvY2tfZ3JvdXBfcm9vdDsNCj4+ICsgICAgICAgZWxzZQ0KPj4gKyAgICAgICAg
ICAgICAgIHJvb3QgPSBidHJmc19leHRlbnRfcm9vdChmc19pbmZvLCAwKTsNCj4+ICsNCj4+ICsg
ICAgICAgdHJhbnMgPSBidHJmc19qb2luX3RyYW5zYWN0aW9uKHJvb3QpOw0KPj4gKyAgICAgICBp
ZiAoSVNfRVJSKHRyYW5zKSkNCj4+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+PiArDQo+PiAr
ICAgICAgIG11dGV4X2xvY2soJmZzX2luZm8tPmNodW5rX211dGV4KTsNCj4+ICsgICAgICAgYmcg
PSBidHJmc19jcmVhdGVfY2h1bmsodHJhbnMsIHNwYWNlX2luZm8sIGFsbG9jX2ZsYWdzKTsNCj4+
ICsgICAgICAgaWYgKElTX0VSUihiZykpIHsNCj4+ICsgICAgICAgICAgICAgICBtdXRleF91bmxv
Y2soJmZzX2luZm8tPmNodW5rX211dGV4KTsNCj4+ICsgICAgICAgICAgICAgICByZXQgPSBQVFJf
RVJSKGJnKTsNCj4+ICsgICAgICAgICAgICAgICBidHJmc19hYm9ydF90cmFuc2FjdGlvbih0cmFu
cywgcmV0KTsNCj4gDQo+IFdoeSB0aGUgYWJvcnQ/IFdlIGhhdmVuJ3QgZG9uZSBhbnkgZnMgY2hh
bmdlIGFmdGVyIHdlIGpvaW5lZCB0aGUgdHJhbnNhY3Rpb24uDQo+IA0KPj4gKyAgICAgICAgICAg
ICAgIGJ0cmZzX2VuZF90cmFuc2FjdGlvbih0cmFucyk7DQo+PiArICAgICAgICAgICAgICAgcmV0
dXJuOw0KPj4gKyAgICAgICB9DQo+PiArDQo+PiArICAgICAgIHJldCA9IGJ0cmZzX2NodW5rX2Fs
bG9jX2FkZF9jaHVua19pdGVtKHRyYW5zLCBiZyk7DQo+IA0KPiBXaHkgYXJlIHdlIGNyZWF0aW5n
IHRoZSBjaHVuayB1c2luZyB0aGUgbG93ZXIgbGV2ZWwgQVBJcyBhbmQgbm90DQo+IGJ0cmZzX2No
dW5rX2FsbG9jKCk/DQo+IA0KPiBBbGwgb25lIG5lZWRzIHRvIGRvIGlzIGNhbGwgYnRyZnNfY2h1
bmtfYWxsb2MoKSBhbmQgbm90DQo+IGJ0cmZzX2NyZWF0ZV9jaHVuaygpIGZvbGxvd2VkIGJ5IGJ0
cmZzX2NodW5rX2FsbG9jX2FkZF9jaHVua19pdGVtKCkgLQ0KPiB0aGVzZSB0d28gZnVuY3Rpb25z
IGFyZSBub3QgbWVhbnQgdG8gYmUgdXNlZCBkaXJlY3RseS4NCj4gSXQncyBhbHNvIGJ1Z2d5IHRv
IG5vdCBjYWxsIGNoZWNrX3N5c3RlbV9jaHVuaygpIGJlZm9yZSB0aGVtLCBhcyB3ZQ0KPiBtYXkg
bmVlZCB0byBhbGxvY2F0ZSBhIG5ldyBzeXN0ZW0gY2h1bmsgdG9vLg0KPiANCj4gRXNzZW50aWFs
bHkgdGhpcyBpcyBkdXBsaWNhdGluZyBwYXJ0IG9mIHdoYXQgZG9fY2h1bmtfYWxsb2MoKSBkb2Vz
IGFuZA0KPiBtaXNzaW5nIHNvbWUgY3JpdGljYWwgdGhpbmdzIGl0IGRvZXMgdGhhdCBhcmUgbmVj
ZXNzYXJ5IGZvciBjaHVuaw0KPiBhbGxvY2F0aW9uLg0KPiANCj4gQ2FsbGluZyBidHJmc19jaHVu
a19hbGxvYygpIHRha2VzIGNhcmUgb2YgYWxsIHRoYXQgYW5kIG1vcmUgLSBpdCdzIGFsbA0KPiB0
aGF0IGlzIG5lZWRlZCwgYW5kIHJlbW92ZXMgdGhlIG5lZWQgdG8gbG9jayB0aGUgY2h1bmsgbXV0
ZXggdG9vLCBhcw0KPiBpdCdzIGRvbmUgYnkgdGhhdCBmdW5jdGlvbi4NCj4gDQo+IA0KPj4gKyAg
ICAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZmc19pbmZv
LT5jaHVua19tdXRleCk7DQo+PiArICAgICAgICAgICAgICAgYnRyZnNfYWJvcnRfdHJhbnNhY3Rp
b24odHJhbnMsIHJldCk7DQo+PiArICAgICAgICAgICAgICAgYnRyZnNfZW5kX3RyYW5zYWN0aW9u
KHRyYW5zKTsNCj4+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+PiArICAgICAgIH0NCj4+ICsg
ICAgICAgbXV0ZXhfdW5sb2NrKCZmc19pbmZvLT5jaHVua19tdXRleCk7DQo+PiArDQo+PiArICAg
ICAgIGJ0cmZzX2dldF9ibG9ja19ncm91cChiZyk7DQo+IA0KPiBTYW1lIGhlcmUsIHdoeSBncmFi
YmluZyB0aGUgcmVmZXJlbmNlPyBXZSBhcmUgaW4gdGhlIG1vdW50IHBhdGguLi4gSQ0KPiBkb24n
dCBnZXQgd2h5IGl0J3MgYmVpbmcgZG9uZSBvbmx5IGhlcmUgYW5kIG5vdCByaWdodCBhZnRlciB3
ZSBnb3QgdGhlDQo+IGJnLi4uDQo+IA0KPj4gKyAgICAgICBmc19pbmZvLT5kYXRhX3JlbG9jX2Jn
ID0gYmctPnN0YXJ0Ow0KPj4gKyAgICAgICBzZXRfYml0KEJMT0NLX0dST1VQX0ZMQUdfWk9ORURf
REFUQV9SRUxPQywgJmJnLT5ydW50aW1lX2ZsYWdzKTsNCj4+ICsgICAgICAgYnRyZnNfem9uZV9h
Y3RpdmF0ZShiZyk7DQo+IA0KPiBTbyB1c2luZyB0aGUgbG93IGxldmVsIGZ1bmN0aW9uIGJ0cmZz
X2NyZWF0ZV9jaHVuaygpIHdhcyBvbmx5IGJlY2F1c2UNCj4geW91IHdhbnRlZCB0byBnZXQgdGhl
IGJsb2NrIGdyb3VwIHJldHVybmVkLg0KPiANCj4gU28gSSBzdWdnZXN0IHVzaW5nIGJ0cmZzX2No
dW5rX2FsbG9jKCkgd2l0aCBDSFVOS19BTExPQ19GT1JDRSBhcmd1bWVudA0KPiBhbmQgdGhlbiBy
ZXBlYXRpbmcgdGhlIGxpc3RfZm9yX2VhY2hfZW50cnkoKSBhYm92ZS4NCj4gTm90IGlkZWFsLCBi
dXQgcmVmYWN0b3JpbmcgdGhlIG5vcm1hbCBBUEkgdG8gcmV0dXJuIHRoZSBiZyB3aWxsDQo+IHJl
cXVpcmUgc29tZSB0aG91Z2h0LCBhbmQgZHVwbGljYXRpbmcgYW5kIGFsbCB0aGUgbG9naWMgaXQg
ZG9lcyBoZXJlDQo+IGlzIG5vdCBhIGdvb2QgaWRlYS4NCg0KT0sgSSdsbCBnbyB3aXRoIGJ0cmZz
X2NodW5rX2FsbG9jKCkgdGhlbi4gSXQgaW5kZWVkIHdhcyB0byB0cml2aWFsbHkgZ2V0IA0KdGhl
IGJnJ3Mgc3RhcnQgYWRkcmVzcywgc28gSSd2ZSBzaG9ydCBjaXJjdWl0IHRoZXJlLg0K

