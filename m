Return-Path: <linux-btrfs+bounces-13153-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB20A92F06
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 03:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2408A5727
	for <lists+linux-btrfs@lfdr.de>; Fri, 18 Apr 2025 01:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9C72A1C9;
	Fri, 18 Apr 2025 01:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SpyCuHRZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BtgEyFUi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D98C0E
	for <linux-btrfs@vger.kernel.org>; Fri, 18 Apr 2025 01:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744938517; cv=fail; b=cZzXVA/8yZ+AyITyT9N5nQtI02x1c7VjKNvWCDPOrUYIa6ciM6MVY7q/ZPL4Dzi3mQb9IdJ4//ECZdrNXM6NlY/IWvPo8rvLGEPG4FVUIoPlJE+9ojkVeM4yEDlwMZtYBSRBleMEWFXKQR2QBFIsEbxqCD+7Q0hUDMT2lUGCMKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744938517; c=relaxed/simple;
	bh=pcY1XzPFjYmi8D7CNb9luYfEeXhqhqu9RoVWMsCmAu4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YTEq0/EGCmN6HzZ7zUsxYdKgsIJPmAsystID7Mr/iVGYrlOfZuF6uqlxLkYpg+VMD8Xsn2eB14cAlt6TG2Mz4WgQ+O4D8i2UWDg6bS4HE4XMCBR+uUymKJyu8b1FaImjNAbzsFVSSZQsKTWuCOYxbkHsTC1QQLto4vbcLAM5Tms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=SpyCuHRZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BtgEyFUi; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1744938515; x=1776474515;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pcY1XzPFjYmi8D7CNb9luYfEeXhqhqu9RoVWMsCmAu4=;
  b=SpyCuHRZtC6sysR0dkIu4Fnzgz2rCdAW/KgEhRXGabvXubMZgY5nIuwT
   zRoN9MfzYyoPZJEW/6jOufBDth53pxX0nJKGMK2962+bwFrj1/UjXsgrs
   unXpgPNjzkRu1jl46+qwhopOnmR9QRXxkrWv3J8MCy9SvY3ED98e446oJ
   sXUVwY5go/9COe4MA56LOsnpws2oPm3ZN+fscCFFJ4t99rSA/A+ZjSWH+
   L/RukGAoSsjsIVmafK+1lrCHLeSmQxYsZqXdKN0DICa6hu+J8vXSIRq3m
   Pl0lZi0aUaKa10sPwu/l6ran27lx5MaiXdF6LOyAtWqR8HrnW5xuL7yXH
   w==;
X-CSE-ConnectionGUID: 8xeWZCXDQxeogxvVbNmuvg==
X-CSE-MsgGUID: kerfYa4SRPmlGvy3LGicxQ==
X-IronPort-AV: E=Sophos;i="6.15,220,1739808000"; 
   d="scan'208";a="76476394"
Received: from mail-westusazlp17013077.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.77])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2025 09:08:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwQ93QybOKTZSPe+1dHzSUTrP68sMEyNyd5+QVxB4ehMJ0sh3rB1ONkjEeF3BLGU2DEJFWi+jG5hPUWZvEuEWq8BYwVCEQS+TNk/5Fy/B82I8BHge3VT0WWjvvvHtXFiiH/s5j4n+4h4HCY4QXpsjNi4Ihc7+Lpdzqxf5veOmco7x7h0gZTL9n5lwcwcM75Iq22k3Qi8SmKxLHvmP1dvDKohQt1oo0VUUshtQKXXBpIGZwN1LKVmdr/Moteh8S8rbixM4FcDn1WICa5izK+WU0Eioqj175tL5dWtkau4z+TDQqMQNRnHeuXmDwSBOEH5wBtvp+Y3xmWlR/A4IdvNHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pcY1XzPFjYmi8D7CNb9luYfEeXhqhqu9RoVWMsCmAu4=;
 b=QRYDCvPEADVx4CDUCKrP0IDPo3Y5q2nigRNlCaTE7YIiUxHYaw8f9rI7f/3f116V9v2a4+Ir5VijeInoqIwEHsC3E55XWcVv+/SuJuk8ve7cgNs9BXtEeWZ93qDKZCYSHcl6AB+p42a0IvfmzWoQwDhiBok5OGoEONWpvMjjY3w3n+wSWmzHQu+Me7hh45H3BgnMZYuF5Lt4RTYdzqhMDh1ar/J+t6+IGrl1ripVt9MXVuQqVuaCGmOIz6lnEyOMzfKmuw9lJpgKKkN2h9KWAKZiMbS17rP72VJM04CazOWNHc+rjhRU/ViG4FOiF/jO8X18EcD3XYtZu5tFkBtPHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcY1XzPFjYmi8D7CNb9luYfEeXhqhqu9RoVWMsCmAu4=;
 b=BtgEyFUiiIpU1kJUuMTODh/5QTBwN4IRwvm/VtWxzVPVnahiIxR2Dy1cVS513YViftU0mR0XVgqXSTDAPU5h5GlP5DwnwRR/nAMS51FUin0iAakyhcaIpB9/CnbFAE4yZgXbQPcUemmv57hVDq9wTOKkECNI2TiUW8RXwd4O22c=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB8261.namprd04.prod.outlook.com (2603:10b6:510:100::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Fri, 18 Apr
 2025 01:08:25 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.8655.022; Fri, 18 Apr 2025
 01:08:25 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 09/13] btrfs: introduce tree-log sub-space_info
Thread-Topic: [PATCH v3 09/13] btrfs: introduce tree-log sub-space_info
Thread-Index: AQHbrtvXM9+SN50PQEG4Ow9pqlyVCbOnzzyAgADP0AA=
Date: Fri, 18 Apr 2025 01:08:25 +0000
Message-ID: <D99D2QQFZE1O.1K4P59O7DD6LE@wdc.com>
References: <cover.1744813603.git.naohiro.aota@wdc.com>
 <e5339b5616f1b4b7ee7625f86fa392bc49d2fc0d.1744813603.git.naohiro.aota@wdc.com>
 <20250417124437.GD3574107@perftesting>
In-Reply-To: <20250417124437.GD3574107@perftesting>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB8261:EE_
x-ms-office365-filtering-correlation-id: 00d6b9a7-43b2-4d30-c799-08dd7e158561
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?THBuRHk2dmZIekg1K3pCaE1mSkZrRndnZWd0MjZzVk53Zi9nNXp3bjZKRm9E?=
 =?utf-8?B?aityQjRTbnBsRTdNa0M3WDFpZGt1bmJ6bVE5V2creHJrMzZ2WG1KWSsyS1dG?=
 =?utf-8?B?dkNIQ0JONE13SmdubnR2Q1FKTnNSMGFUNTZqNXdOOWhWclV5SCtEMVNGa0Nt?=
 =?utf-8?B?bjhGODFaQWtsNERIQ2x0bmNtNUd5L0tjc1I1dHdJTno4VDcxZkVXcEVXOEtI?=
 =?utf-8?B?dGNnOVhXcnJ3c0ROS0MxaStwbkk4TU4ySzg1b3VZdFdXM2dkVmxkL1BidmVX?=
 =?utf-8?B?eUVmSm9hT0EzTGttNTRTbHV1YkhUa0pyNjNVRWFRWXVmUVVuL0tIWkdUSnpN?=
 =?utf-8?B?elM1Sy96bVNrUU41TERBM05OZTdoWDVLRjJYcGFwSGV1VlBRNWtsd2k4Nm5I?=
 =?utf-8?B?ZFJ3RnU4d3ZobXpzZ3NMUlRMcURQenRvWHRvR2VLRWIzZEp2MUpPWmlORU55?=
 =?utf-8?B?SFZjQVBmZFppNGFQY0QrVlREV3h1OElINnJxdUNBS3FBTkdhbmdVTm5SVUF0?=
 =?utf-8?B?T2JiWHhlUlRMTktHalZnTTZlKzVaYWUreFRNMm5iZUFXaUZpbnJMdUtTazFJ?=
 =?utf-8?B?WEZ6bTg4UFFXZzYwMFFlWGMrcld6aDFmUERMMndaWExoTDJRNUJDbHE5R3NO?=
 =?utf-8?B?NW50aWtKbmdGcnlPSkVRMzAxZ21XNnFtbjAxSlcyOWRFWURndlZvbUM4RWl0?=
 =?utf-8?B?eTVuODc1UFZ4TjIrKzdWMlNCWG1xQkoxVFA2bG9LdTRaNWRjeHBXVE9JZ2N6?=
 =?utf-8?B?Umw4WFBLNHI0TTlkYVpTZ2pkWjVsUW9rb1F3ZWhMYVFCMjZXcXhteEJONHRJ?=
 =?utf-8?B?TmdaZ3JDaGcyNkVDbFBvS0VOMUZMV0d5ZlpDYi9VNmliYVg4VlNHeEk1S2gv?=
 =?utf-8?B?R3hvOU5qT3k0ck9ScllPc0hYRml6K1Y2eEErb1BueHBWdkJyaXl6SDZHNHVl?=
 =?utf-8?B?OFZ5dGNSNlBlTGF5V2d5UWNmcFBjaUdTUWRuaGtJc2xxWW1ia0JXS2haTVBO?=
 =?utf-8?B?eHlBR1c5a3FqSUdQVWx3V21wV0QxVmF5dnJNZThVK3JOWkdXdVFPdnBSSzIx?=
 =?utf-8?B?S2E5WEowcWZmSWgrRlo2NDVCbyszUVZqdTM5VzZGZXZiaDVnTXRjcDFzR2o5?=
 =?utf-8?B?NFVLQ2g5UC9SbFVUZzhxRzJ0cHQ1MjNydkZaS2ZBZGtxaTFpQ0ZEN25GU3I0?=
 =?utf-8?B?YlBNZW4vVHZGdGpVUUJWa2NoOG9lZWlnNkdsNlUwdkEwYzRndHlBbE8yWDVD?=
 =?utf-8?B?b2Q4RjJqU21NcDJhemxxVHJRTDIyQlA5L1VrMU9mdFZpRlRQKzJmVXpXbUQv?=
 =?utf-8?B?VWJnb0E1Yy9BNVlQMWlaUU1HdytCcDVwMVd6cDlsL2lweG4ySVBwUGc3U0JH?=
 =?utf-8?B?a1ZQK2xNUys4T1AzakRiTS90aG82dFdkejBNQUtITGVuNEExVUdHYndsamdQ?=
 =?utf-8?B?MmtnNDRxb3FucFpFVnVMRjQ4SkJxbjlhVnc0NHJzZTZmRjZLaEd6ZEVVajBD?=
 =?utf-8?B?Q013ZksydkdlK0pHVVkrMzdGQUFLTWtvTjdwOW0vNVJBa2IwckIxRWl4bVBh?=
 =?utf-8?B?WHh5c0M1NCs0SVlnekxkbW9RTUg0Wm1WUTYxemJxSm5pUU1nTEZFUDVkaUQ1?=
 =?utf-8?B?eHVrczZTTDMxdkRYM29PbUZmbWRqRU9GNCtjbkdhQTJNWUtBQ2EzdDE0L1FG?=
 =?utf-8?B?QUNJZHBGUjlZdnpwQkFEQUJ6c2N0d3l0d1k5YWRBNVZJV3dpS0l3UDRxcjBL?=
 =?utf-8?B?MVBNUXJhWWZiSks3NWdSOUFaaUdkbWdsUW1DMzlMQjZjTzlmZFdXUTJGZWNj?=
 =?utf-8?B?ajRlelBHZCs2cm9JSXpIdExTVDBzOEtMWUgwaWdwMEJNdURXQVlxbG5VZW1H?=
 =?utf-8?B?MGdSWU8yRE9QRHNXMGxMVVlhZndDei9KZlFUVFNacjMzSWI2OWFUNjNoa04r?=
 =?utf-8?B?MzJsN01UMmRCMFZObTVFU2JqZDB3cUdnSlpFcWI1ZlAyT0FyMmQ4L3B3WWpS?=
 =?utf-8?Q?cMVNpPCbG74BukpSbXLZPZJnsL09to=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a04rdFBZYjIveENnRkM2azNGRWw2Um5QUytBRnAwU1N1Mi91dVYwMHBvakh3?=
 =?utf-8?B?enpFcnBJWkxzQzNRRG5zMEhPT1FUNXlJSnRLSVEzaWdCUk5vN1JXTUY1Ukxi?=
 =?utf-8?B?VStSazBaYkxYS0VGL0x2c1F3VlBFaDZpcmJyeHk2RElSbzliRmdNTk80S3g1?=
 =?utf-8?B?UHYxanhncGx0eWVETXBvRG1MeFpFb3dUem9IZkpFUWx4QmZvOWhqTTkxTSty?=
 =?utf-8?B?TWJsZzByeTExdllXWnRPNFpnWU1GOUhjNm5oeXdNUjliS3ljekk3YXAzbnlu?=
 =?utf-8?B?UmxXS0IvK2owTzNmWWhQUGJrRnlRTDN0S0tNQS92MnZBODd5MUM0UzNhbzNo?=
 =?utf-8?B?ZGZrN1dWdXdJT1B1NVpOZFI5aEZacmZkc2I3Q1c4czlreVhteDlRdkpBSXdV?=
 =?utf-8?B?ZGZIaFZ6MWRjYmpEL3lnTTQzSUNxWmNFOS90WDlMZ1dSRE9KTUVQWVZndy95?=
 =?utf-8?B?eGFZTzgzYkRiNTVnWnN1Vlh4bEdneTVmRGtmSlJZdm5XNXByQVA1aU5xTlA3?=
 =?utf-8?B?U0xmOGZhU2RlaC84L0hmWWtVTmw5M0hEZlBRRm1PWVM3M3J0TXQxNFRHQzE0?=
 =?utf-8?B?TGtKUlNlTUw1VE5TYkdmcUgzeWUzU2p5U1dHR3dLQ2lYTHdXYXBsNmFUd1Z3?=
 =?utf-8?B?N3ZuQXZUZ2NzaDZTTHcxYUsxRDhWWHZnM0dLVk10QVU3MzRCc3MycmdIc3ZS?=
 =?utf-8?B?SE5SYzdyakhURzRZZ0kwQ2lKY2hhcUk4TVFLY0RNS3ptV25mMEg2R2cxUi9w?=
 =?utf-8?B?ODd5TUxaZTdiZlhNOE1XMzk0S1dxN29GaW0vSlhzaXdxTFg4UXdISzVmaS9p?=
 =?utf-8?B?bHE3Q3duaXM0eDBpQ1JuaDgxTHE1dXdvb3JqNVpVNXhqaEwxN1Q1SjcrWUdU?=
 =?utf-8?B?UGJKQk5ZTGx0VlRJUTFHREd1TElEZm1qdGFZcnd1TjVjSnhNRlBFc0dnMFZx?=
 =?utf-8?B?UzV5S2E2N2I1a3ExaTc1SURkU0p4MUdtMFNqVFBPR0ViVVk5L1hIRndCb2k3?=
 =?utf-8?B?RHczNEhIMVNSYWkrUjE3TERpUkFRM3l1SGVubkJLVG11RFBHREU5QWd0MDI0?=
 =?utf-8?B?SUV6NG56SzZTenNaM0lrU2R1dlJoYVdaS0VlN1FSb29RT2xoMXJoS0NITmZ1?=
 =?utf-8?B?WmlOVjlraUNTbHVTM0o5SWlROWQ4VXdvbTBic3pMWFFwVW1SZ1EwR1VnTlJG?=
 =?utf-8?B?S0tOMmoreFcrMENMSHBYT1FobUVOdWJDTGhGNGFDNFdIanVSNytzbzl1akFT?=
 =?utf-8?B?S09rbEtXU3prdlRTeGU5YnFtcHZ6N2E0cUljMVlZYXNMN09Sa0ptOEhBYnBn?=
 =?utf-8?B?KzRZMEx3RzJOb1Nkd2VBcENUZWlnTXh2WDJnVzZzNGtRTGtNdmJDbVRGNTBD?=
 =?utf-8?B?bG05NmtQUE1PNDMvVDM5cjNvV2U0UmdmTU5kc2g2YWRUakh2TjBZdzNmSmlh?=
 =?utf-8?B?Q2FwZDFCbkkzK3ZSZG9MQ3ZNZHVQejZyWGViK2hJOWMzWlRiYmhwd2w4cnkr?=
 =?utf-8?B?RnRyNis0NEtYYzFwd2xLMkVXVG5ZVVYvTWIwdHV3KzVES25SUDlvZzZxR2VG?=
 =?utf-8?B?b1haN1A0OFg2Q0luUXB0bG1HL0x3c1QwNVRyNE95clo0dkRrbDczQTRrMEVH?=
 =?utf-8?B?WTNNMVRIYmtDd241Y2h2ZXF2NHZadUZxVHpBTWhKTnpOUUdYdUQ5M0RvTHZm?=
 =?utf-8?B?TUh4NnRzb25kUDlzSnJRbXhqdTh4b0hQTzJWaVFDWEcvZy82Vm1FWDJRcENR?=
 =?utf-8?B?YjF6RjVPa0FKelRMUWJRTjFYVG1OUmdxQUZJY0RkYjVqMXJvOGNNRkJ5NkNP?=
 =?utf-8?B?c0Y3YzVLWU9tYk5Uakh3TjBWUVljanBxNVcyUUJuWjVqN0ZZU2h3bHRNd0M3?=
 =?utf-8?B?dnFjZmxWcHg3b3haMmgrQTFxeTUvWG9IQmpIZ2MyaEJmNTRjWHBRVGNxdGhr?=
 =?utf-8?B?SnVnaHN4emZpYjFEcDVReTFDWmR5VFFHeHNySkZZcFlFcnJ5T0ZqbnEzTWpx?=
 =?utf-8?B?Zmp3SDdZNWU1bklydFRDeFQ0RlZYM3ZIZ1VvSnljeTRUMUk2UlgwVktud3lX?=
 =?utf-8?B?d2h0VjJDTTQzVHpSa2h0bUlDZTRITFRleE5JYWdoQ0EwT2psOUh0S05WZWdt?=
 =?utf-8?B?SVBNclhBRlRyOW1aZExrNXdZMzhza0ZodDJHOTBCL2ovd0w3ekpLaWRwRGJs?=
 =?utf-8?B?UXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <43E56AFD3809B84CA14EDE00F3DA1A64@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PRdzMK0sN9L5ZrUXUJvuT3JjCX8ad1QMEBQFoHF164O+WGjfMYZMJPxYoTGk5PPM3eOAgZJFZbDJMEXyJFYpubt2MonJoDab6ujjg/EI4LhfPKTU++jffULvGiz++emtHxlPuWyx1hlf72G7wxejHf72npN7pvqHcGthRTBJxV69w+cI1cT45JoRku95PBTKeFSCOxSpia0S68pkXFCBoAwhbdpeD60n7J/6LxP7lCD8PvpaZ1UzqcwNOg2GRvRVjnc4zQoE62MoSDIK8B5iDpRBu8DBilq2IAWMgOeoucYZjLBHtdrgNikom9pzyuMIY8JUYGs8mgO1K2YsyQ2NNKFo0z6wj/qF9ZFpaNkLOIjiR++aHfOHN2d9VXuoSqhelP9B+20AtrM9pOs1paS22K2Ev1X6KXsyyL2ovgHP60lDoaANo9oUVN4iV6+5R8XkEeqSlUINSV1Jy3XkJl/aOCUzOdhUjc6K1amRGVbbaq6o33B9wODNXXVd5vZWNyrIu3BVUbkDwPW19gPaU0pVGyMEebTvGrA9MivzhgwHYhn32AJWp28J8t5qCVGWI8ru/jQFtL2m45vbIctjUwdi7IlCCfd8f1hIL3OLPHZkY+nhjkvVNNjuRKN8mkzLlNts
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d6b9a7-43b2-4d30-c799-08dd7e158561
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 01:08:25.3221
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOCanxinc2J94LhbTcs24Dv+i1mLVcDB+1P7Py3mY13QX03OfgtKVjGVM3a6qftVOICZ80T+9nAAdTFl7VCnlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8261

T24gVGh1IEFwciAxNywgMjAyNSBhdCA5OjQ0IFBNIEpTVCwgSm9zZWYgQmFjaWsgd3JvdGU6DQo+
IE9uIFdlZCwgQXByIDE2LCAyMDI1IGF0IDExOjI4OjE0UE0gKzA5MDAsIE5hb2hpcm8gQW90YSB3
cm90ZToNCj4+IFRoaXMgY29tbWl0IGludHJvZHVjZXMgdGhlIHRyZWUtbG9nIHN1Yi1zcGFjZV9p
bmZvLCB3aGljaCBpcyBzdWItc3BhY2Ugb2YNCj4+IG1ldGFkYXRhIHNwYWNlX2luZm8gYW5kIGRl
ZGljYXRlZCBmb3IgdHJlZS1sb2cgbm9kZSBhbGxvY2F0aW9uLg0KPj4gDQo+PiBTaWduZWQtb2Zm
LWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg0KPj4gLS0tDQo+PiAgZnMv
YnRyZnMvc3BhY2UtaW5mby5jIHwgIDQgKysrKw0KPj4gIGZzL2J0cmZzL3NwYWNlLWluZm8uaCB8
ICAxICsNCj4+ICBmcy9idHJmcy9zeXNmcy5jICAgICAgfCAxMCArKysrKysrKystDQo+PiAgMyBm
aWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+PiANCj4+IGRp
ZmYgLS1naXQgYS9mcy9idHJmcy9zcGFjZS1pbmZvLmMgYi9mcy9idHJmcy9zcGFjZS1pbmZvLmMN
Cj4+IGluZGV4IDM3ZTU1Mjk4YzA4Mi4uNGIyMzQzYTNhMDA5IDEwMDY0NA0KPj4gLS0tIGEvZnMv
YnRyZnMvc3BhY2UtaW5mby5jDQo+PiArKysgYi9mcy9idHJmcy9zcGFjZS1pbmZvLmMNCj4+IEBA
IC0yOTIsNiArMjkyLDEwIEBAIHN0YXRpYyBpbnQgY3JlYXRlX3NwYWNlX2luZm8oc3RydWN0IGJ0
cmZzX2ZzX2luZm8gKmluZm8sIHU2NCBmbGFncykNCj4+ICAJCWlmIChmbGFncyAmIEJUUkZTX0JM
T0NLX0dST1VQX0RBVEEpDQo+PiAgCQkJcmV0ID0gY3JlYXRlX3NwYWNlX2luZm9fc3ViX2dyb3Vw
KHNwYWNlX2luZm8sIGZsYWdzLA0KPj4gIAkJCQkJCQkgIFNVQl9HUk9VUF9EQVRBX1JFTE9DKTsN
Cj4+ICsJCWVsc2UgaWYgKGZsYWdzICYgQlRSRlNfQkxPQ0tfR1JPVVBfTUVUQURBVEEpDQo+PiAr
CQkJcmV0ID0gY3JlYXRlX3NwYWNlX2luZm9fc3ViX2dyb3VwKHNwYWNlX2luZm8sIGZsYWdzLA0K
Pj4gKwkJCQkJCQkgIFNVQl9HUk9VUF9NRVRBREFUQV9UUkVFTE9HKTsNCj4+ICsNCj4+ICAJCWlm
IChyZXQgPT0gLUVOT01FTSkNCj4+ICAJCQlyZXR1cm4gcmV0Ow0KPj4gIAkJQVNTRVJUKCFyZXQp
Ow0KPj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3NwYWNlLWluZm8uaCBiL2ZzL2J0cmZzL3NwYWNl
LWluZm8uaA0KPj4gaW5kZXggNjQ2NDE4ODViYWJkLi4xYWFkZjg4ZTU3ODkgMTAwNjQ0DQo+PiAt
LS0gYS9mcy9idHJmcy9zcGFjZS1pbmZvLmgNCj4+ICsrKyBiL2ZzL2J0cmZzL3NwYWNlLWluZm8u
aA0KPj4gQEAgLTEwMCw2ICsxMDAsNyBAQCBlbnVtIGJ0cmZzX2ZsdXNoX3N0YXRlIHsNCj4+ICAN
Cj4+ICBlbnVtIGJ0cmZzX3NwYWNlX2luZm9fc3ViX2dyb3VwIHsNCj4+ICAJU1VCX0dST1VQX0RB
VEFfUkVMT0MgPSAwLA0KPj4gKwlTVUJfR1JPVVBfTUVUQURBVEFfVFJFRUxPRyA9IDAsDQo+DQo+
IFRoaXMgd2lsbCBtZXNzIHVwIHNpbmNlIHRoZXkgaGF2ZSB0aGUgc2FtZSB2YWx1ZSBub3cuICBU
aGFua3MsDQoNClRoZXkgaW50ZW5zaW9uYWxseSBoYXZlIHRoZSBzYW1lIHZhbHVlLiBTaW5jZSBT
VUJfR1JPVVBfREFUQV9SRUxPQyBhbmQNClNVQl9HUk9VUF9NRVRBREFUQV9UUkVFTE9HIGFyZSB1
c2VkIHRvIGluZGV4IHNwYWNlX2luZm8tPnN1Yl9ncm91cCBhcnJheQ0KYW5kIHRoZXkgYXJlIGlu
IHRoZSBkaWZmZXJlbnQgcm9vdCBzcGFjZV9pbmZvIChEQVRBIHZzIE1FVEFEQVRBKSwgdGhleQ0K
Y2FuIGhhdmUgdGhlIHNhbWUgdmFsdWUuDQoNCkJ1dCwgeWVhaCwgbWFraW5nIHRoZW0gYXMgYW4g
SUQgd291bGQgYmUgbW9yZSBjbGVhbi4gU28sIEknbSBnb2luZyB0bw0KbWFrZSB0aGUgdmFsdWVz
IGRpc3RpbmN0IGFuZCBpbnRyb2R1Y2UgYSBzbWFsbCBpbmxpbmUgZnVuY3Rpb24gbGlrZQ0KdGhp
cy4NCg0Kc3RhdGljIGlubGluZSBzdHJ1Y3QgYnRyZnNfc3BhY2VfaW5mbyAqYnRyZnNfc3BhY2Vf
aW5mb19zdWJfZ3JvdXAoc3RydWN0IGJ0cmZzX3NwYWNlX2luZm8gKnNwYWNlX2luZm8sDQogICAg
ICAgICAgICAgICAgICBlbnVtIGJ0cmZzX3NwYWNlX2luZm9fc3ViX2dyb3VwIHN1Ymdyb3VwX2lk
KQ0Kew0KICAgIGlmIChzdWJncm91cF9pZCA9PSBCVFJGU19TVUJfR1JPVVBfUFJJTUFSWSkNCiAg
ICAgICAgcmV0dXJuIHNwYWNlX2luZm87DQogICAgICAgIA0KICAgIGlmIChzcGFjZV9pbmZvLT5m
bGFncyAmIEJUUkZTX0JMT0NLX0dST1VQX0RBVEEpIHsNCiAgICAgICAgQVNTRVJUKHN1Ymdyb3Vw
X2lkID09IEJUUkZTX1NVQl9HUk9VUF9EQVRBX1JFTE9DKTsNCiAgICAgICAgcmV0dXJuIHNwYWNl
X2luZm8tPnN1Yl9ncm91cFswXTsNCiAgICB9IGVsc2UgaWYgKHNwYWNlX2luZm8tPmZsYWdzICYg
QlRSRlNfQkxPQ0tfR1JPVVBfTUVUQURBVEEpIHsNCiAgICAgICAgQVNTRVJUKHN1Ymdyb3VwX2lk
ID09IEJUUkZTX1NVQl9HUk9VUF9NRVRBREFUQV9UUkVFTE9HKTsNCiAgICAgICAgcmV0dXJuIHNw
YWNlX2luZm8tPnN1Yl9ncm91cFswXTsNCiAgICB9DQogICAgDQogICAgLyogSW52YWxpZCBjb21i
aW5hdGlvbiAqLw0KICAgIEFTU0VSVCgwKTsNCiAgICByZXR1cm4gTlVMTDsNCn0NCg0KPg0KPiBK
b3NlZg0K

