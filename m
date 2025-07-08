Return-Path: <linux-btrfs+bounces-15310-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF38AFC1EE
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 07:17:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DE04A52B8
	for <lists+linux-btrfs@lfdr.de>; Tue,  8 Jul 2025 05:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6310F1419A9;
	Tue,  8 Jul 2025 05:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="crId80Nr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ysh5t88Z"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093061401B
	for <linux-btrfs@vger.kernel.org>; Tue,  8 Jul 2025 05:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751951845; cv=fail; b=o+YfhZmqsYUIvK11nQ6QDVaMPsJEy4yEOYGFbgddPY7qF6ElFtj8hdqP3TBgo18Rd1bD06L3Yys9dq1lprXZ1N8IDreo/okt0O03F5Fwdm92ajNba1FwP1uYqBlbir5b/SndZ2S+QKQ9TBKt9TbIiQ33YQqeswQtKK62fbv2Cq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751951845; c=relaxed/simple;
	bh=vuIdtHey+sJ7QNBkWAGTwnSeya8Vgy0W7JF4YVPWerA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxlQnEkleUjP5ElF0MoX4GHQfcVhUSdIMAflBlvLlNWWSyNuU0bBa5kNlqwqGoveUkLeylYERL8f1P4/1i0OXbSrZ96tWsdX8Dkbr8kvU4OcvEKJY89sWhFdFnJzL1WWOW537nqOJ7BN90amPIlFUU42AKtif3NCIzthBH5qx9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=crId80Nr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ysh5t88Z; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751951840; x=1783487840;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=vuIdtHey+sJ7QNBkWAGTwnSeya8Vgy0W7JF4YVPWerA=;
  b=crId80NrebfrC6VmycqFdj6DZeJIpZsJJLr2WewAdXqZ66yAtXINxo5X
   rbmJKHp0IDVyPqemsb0VnmKYIpUUbj+QeHkhdcirqCm4YKFL2UrXR47y3
   oth6aeLNt6t4I6jFS6HXRNMRS6ZDuPuCMBg3CFdcNQodsf7FLqVv4hT2y
   Ytqyxdxv58JcXv0/VEdzw+ulfao2UmxiyNcNaWBC8638x7BzTDif7w1Kt
   sTqpuWmqHWryeNXap3MBbhaHsYXSuQErRq/gDekPg7datNmlRQbUcSoYV
   OuJ1hAWFSz+XIO1/X2eRuBLXmmbrq0U7n4CT8eIhL4yF5zp5ZL1HnvXdP
   w==;
X-CSE-ConnectionGUID: fH0ghgb+TJmj1b+DH7GrrQ==
X-CSE-MsgGUID: P453wYGFSvK0nU7FUGPXTg==
X-IronPort-AV: E=Sophos;i="6.16,296,1744041600"; 
   d="scan'208";a="85503199"
Received: from mail-dm6nam11on2051.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([40.107.223.51])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2025 13:16:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aNsanjT4l1UJWTMqjfZmswXzGs1QNBS1ZmdaieIVh7IO0EOYm5ZZtkPIhe5jbe1RAVKJCNhP/pWe2VAR31VYFcb4AMqbtFHcRYm9ljfyEnEpCoaCKOsUbi+weHgF8Ph7RHNkAysr9o0tEAx+WpfXRHykhWFkx75q7CoXG53DRh6F+q6wH8TpEfbGGV+z3fGKquSFeEIPDJfFMssWuIPNwKbUO6OlFAmm7GkErw7p9KFNBiaji/cfbw3joeoVaFGXK4I8H1rDfBkyMcLbE+t0op7JIXyMj/QGa87BZQrUhV2nk8G/BIAl0lzQANdj/dcamS8qPL3KEH0Bi62Xl6vgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuIdtHey+sJ7QNBkWAGTwnSeya8Vgy0W7JF4YVPWerA=;
 b=SU8a/Vlz0AgcrGGybWILb/hI38+PzhO7bcgsMFpDXiDEpum9nWi+5gij5yawAD4SyLuaAGyywOmk4ORiV1mvKQBpP1/F7QRC1gycefEyCBRGyNSOU9S0qXYx2Ykw1Qylahh/zBrqZ1fxEivpv0B+xq3jIWZ04fuhqzFmEu8TgCyJo9iByOXVTDDdBtJ9eQ2I9Hw13nwGv3C5k3yKodsA6J4wp6WX6ck3ihy03E+Nr3n1amVW1bMQg3gXrDf99qqGquiKnJxvuv3fM9P56bqNHTCuqixlJO8uFB/8G0ts49TjWvYQZhyJ0XJ1tRU8Etqz/44c37KHqODYBavB+4H61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuIdtHey+sJ7QNBkWAGTwnSeya8Vgy0W7JF4YVPWerA=;
 b=Ysh5t88ZFuapBdOE26A5h5HemopyUqoWwOleGE6zT/kYLkFRiPKVi0HnVlHR/Np1qC/+60EbIkqd+zRuiEbItklbqZCsZU8UlHIDY2qYq7cIzShxDHvOWtLscxkmStuB0my2IjpwvmoRKuetklZU6wt9eQLiBXwyq2G6MfeZHRo=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH0PR04MB8435.namprd04.prod.outlook.com (2603:10b6:510:f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Tue, 8 Jul
 2025 05:16:08 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 05:16:08 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: zoned: limit active zones to max_open_zones
Thread-Topic: [PATCH 3/3] btrfs: zoned: limit active zones to max_open_zones
Thread-Index: AQHb7ukboruZfaiU7ku/Pc7lMO01qLQmBBCAgAGs7oA=
Date: Tue, 8 Jul 2025 05:16:07 +0000
Message-ID: <DB6F2IZB4E0V.3FG1KQ7WNZPA9@wdc.com>
References: <cover.1751611657.git.naohiro.aota@wdc.com>
 <d2f36336c9eff5de35149223e9fd9b279028a804.1751611657.git.naohiro.aota@wdc.com>
 <17bd900f-78a2-4c24-911a-6c29c6e9a520@kernel.org>
In-Reply-To: <17bd900f-78a2-4c24-911a-6c29c6e9a520@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH0PR04MB8435:EE_
x-ms-office365-filtering-correlation-id: a60204ca-3ef1-489e-16f2-08ddbdde8ba7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VnM2SmR2TkR4NUpLSHJOWHBwcDgvNWpGMFFSRXd3cWE0ayt6cmhFYmhiTjQ2?=
 =?utf-8?B?eTdhcW8xbkFPYkgyMEFNN1NMQUlvcjdiczc0Y1pDdmlYZUhaT0RYSGlKaDNX?=
 =?utf-8?B?MlVKTzRGVjZSbGc4U3RvZWphNklHN1BUTzlESExKN3AvcTh5M1RVcDZVSGNW?=
 =?utf-8?B?enFUbXd2dzd0UkVtYlNxazRxZEhrdTlkakt1djdNeXVkZWJZUkExUzY2Z0Fl?=
 =?utf-8?B?V1VqRUxySVlRNHhVRW5zR2ZLM2hFdWZFR2VtZ3g4MFlsY0ZwZTdtM1ZmcjBl?=
 =?utf-8?B?ZTE5OFVMcG8wcHpNU0QvVXJ0bVVhVzBMWDJ3TFFYTWg5TzRPYXVHNmpVcWs0?=
 =?utf-8?B?VlVuaFlMci9ac2NHSWlpdkZscElRaUxkMy9tU2RhNnFUWjY5YjFGK0I1bkRs?=
 =?utf-8?B?NSt4Rm1pTHJWRGhUck4rWEdmdnVUdlZ4ZW5UU3dVNVg2NkVZTUgwakdGUlZu?=
 =?utf-8?B?Zlk5c1I2VVQxdjlJWXQ3QURKclNaUk1iR210MUxoaHpCN1pML25uQlYyWVdm?=
 =?utf-8?B?emc1N3FVNmhKRTlRUDdTMXhsWUxRQWFGRzRYRUdoZ3NqRnpuSSt6WVkxV2dr?=
 =?utf-8?B?cW1DNDI0WHROZnlwOVplMXlnWXFmL3FVOHFmc0IzWTEyaThVb1JTTDMxZjFw?=
 =?utf-8?B?Y2FXcTFHOVZuNTRtYjFGOGhURkpRK2FKUXdZWXVlU21GYjBMODFNUXJkOFVv?=
 =?utf-8?B?OVRCbDd3ZFo2SWs0cnZLSWc4dHg4dk9TR0x3YTJkSVJsZE9ZSWZyN1JBSEJv?=
 =?utf-8?B?NXVuRDBZVE0vSnNIN0kxYlhoNTAzMFEyOXI3Yk1rVDZCVVNJTUl3ZUZ4SjZv?=
 =?utf-8?B?RUQ2OUxwTjRBWjl2c2tyTWNmMStWMlBWOHMvemRKaGNqQlB2NHlqdncvZW9z?=
 =?utf-8?B?RmhldEFTQkVYSFJaN3VFcmFjVXkyT01jRmlkMm51WFlkVGF6T0VMZnowOG9y?=
 =?utf-8?B?UGdaRkRMRThPQmFmSXI0bTFKNmQvVmwyanowbUJMdzQ2VHl0K3dET3ZJWlZX?=
 =?utf-8?B?VmovSU1TSGMrRTB0YzlLZThJcy9PSk9YWER3Y1NlMDVsL2oyQytOVGNUTGhy?=
 =?utf-8?B?MnRjczB5QkFvV0NXMjRZdzErUmxWK3NMSkZ5Mms0U05OcEtzdXJpcy96WlMv?=
 =?utf-8?B?RUdkOXZVemkxb1dNMjhsY2k0L1J0Sk9pRjZwamNLVEtDamZlZzVPTDJzOXUw?=
 =?utf-8?B?RnBDcXFGcGdVQlNvR3p1WWc1MVVublVEZjBqNTVXeVFhNkJaN0xPK3oyRkNB?=
 =?utf-8?B?alR3MDhxNzJPOUFnMnJHQ0dXUyttZk9WZ08yMUp6b2RlZnBrQ05TZ2RqeWJp?=
 =?utf-8?B?c2xvbkozajFyeVpZLzFmbCtSQTZLZVBaU0NKOXViLzJBdGMzWmRCeWtick9G?=
 =?utf-8?B?cFFqZTE5MkJrK3cxVFRKL3JNcGVxcU1KSW9JTVRxNldBNTRCWlhiL3FBL3lK?=
 =?utf-8?B?ZXlCZWVTbTVhNW80TXkydElFRDhFVFJWRkVDZWt4L1MzdXJiemlPWkhRRUg5?=
 =?utf-8?B?VXBXZ0VOUU13aXY4WUNxT2QzUmZraUlxTXNMMWlsSTJ5a0pvaXFudlh3TDZC?=
 =?utf-8?B?V0h3OXJSbG5KaU0xd2xEWFJRNC81Sk5yQ29jbDU2Z1BUemRiUnEvR2tKVnNN?=
 =?utf-8?B?ejZPSDFmTEhCYjIzcndoQk5uV1VLVGRXdUJZT2NyN2d5cGN1TlpmNU5FUHU3?=
 =?utf-8?B?OG04Ym5mRGs1S2VVd0M0M2RtSkR3eVNVc2IrOFdpQ0VsZmc5RDNVckNGdXdx?=
 =?utf-8?B?bUd5cWxsdERqR21PRlBwMjcyY1JNd215Um53ZGdvQ0EvcnBDVTl0Qm9pOGpB?=
 =?utf-8?B?cVVYSnJTRjk3dnZpT1UrMUpQQUg3bXNBWEppMjF5V2h0OG9uNDFwemVqS3N5?=
 =?utf-8?B?RnJMR0JIdVpGMnZGblBHN1I4bTRSLzE5b0psa2crdmZNQzZVTnN6T0ZqM2VM?=
 =?utf-8?B?ZUJFSGR3bm5wTXRCV0NJYi9xK1c0ODVaOUh4MmVWZ0pibVV4dTAydkhWZzBM?=
 =?utf-8?B?OC9IVjZNcDhBPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VjY3SUdqNEFZY0w3VDYxWU5VSVh1aGsxeVdYTkNSSzlSVmt1YlczMWVucUdK?=
 =?utf-8?B?WlkvZklPdXhPcnFyMzkwYW9ZWTRwL0NhWUgwbUg1alpXZ0pZLzlKaVRwT1p1?=
 =?utf-8?B?dDJtTHI4R0pEVHM3WWRPZ1VKMy9ROEN6R3cySEg4Q1ZaYS9nS1Y4N04yeUdJ?=
 =?utf-8?B?SVVITG4xY2FLSkU2azMyUkhYdFpFWGkzTWlUbmgyTHJrcWdUR2Z5RFVHVzBL?=
 =?utf-8?B?YUIvVFV0a21nMmovUUpCaGltUzZhdkVYMFNsbUR2RlJOdmlqMDg5Nm9ZRzVB?=
 =?utf-8?B?SnhQOHRkTVN3eTZGTU5GQnFXU09zaGVEMUpvc3ZxajM2U04rOWRvbmlPL2Q1?=
 =?utf-8?B?UnJxdWFZUEJaL3B3UzN5Rmw4am9ycENSYmlJS0hieHFpblFiRWVJTEZ5bU95?=
 =?utf-8?B?VzEwdW1za1lZWFhaZkNkNFQ5aWdZMHo0WGkwVWh1ejA1aWFlbmVWY3dabTBz?=
 =?utf-8?B?ZHRqTUhJMFpTRFdQVWxqWnR1NFhNMy9SZ0tyWTZwWVR4dWsrSHpOMkhWRS90?=
 =?utf-8?B?bUN0N1I3M0MvZm4zeHNLREJoenpVdjNlNE5JVG1pQ2E0MFhGaExPSExIQWFE?=
 =?utf-8?B?eUV4aHpVYm1SNGRNUUdXanZLRnBUTnUwZHFkK3NOZjkreUhmZHN5cTZGR2RR?=
 =?utf-8?B?TzFvZWRlOWlaT1R5N0lCeEIxeWZyNzhlRG9YOE14SXVWdURTSjgvYTMyb1lO?=
 =?utf-8?B?Uk56ZDlDVHEzeWNHdzVvd01MSWc5aFEvVHdaQjZQb00rNTN0NzR3aURBa2xx?=
 =?utf-8?B?ZTNGK2xlanhqeVpRaCtSeklocng2WmlZcTZldWFPL3RzU2JTRjJseFFoT1pa?=
 =?utf-8?B?alRCejdDblZHQUV6RzFsZUlPRnNyNCtJS05OY2V3bW9PTzgyT3pjS215Nkxo?=
 =?utf-8?B?MzVnaW1CcnZodEVFeVhhVjhtWVdLTXVNMGVnOHV3UmJPcXVNbTVHT3NDQUxO?=
 =?utf-8?B?dC9NYkZjOEREUndHNkxuK0ZXSnpYTERSQTMxSC83aUNnNHZaWmF4bUl6Y2ZZ?=
 =?utf-8?B?WnRxdWlWUG4xcy9pQWZXYVNHb0hDYVNtTDVmVkg3aGtHNnNwQXlJNlEwa2Y2?=
 =?utf-8?B?S3VuSTdtUks3Ylk0SVRhS29VYWFEcUpBUXdYOGNIalJ2SitMU01lTmIycVJk?=
 =?utf-8?B?VHppMVhXcGUwTFJxM2RSVkQyTldyWnpDM2puOUZTRTBXNGRrTjRMR2FwVi82?=
 =?utf-8?B?RnQ5TlFjdjNpMmxaVDNxdHVpS1VSUVF4TXpxblF6ZjB1cnJzVitBZUQ4VEUz?=
 =?utf-8?B?U3J5Wks2WHA3TzhobkdiTVlOelUvV1NUVk0ydmlKanphWERoc0t1ZXplVmVa?=
 =?utf-8?B?TW5GNUF0Tm9WT3Z1aFgreU1OdzJ3OU9QL1l1dUxpeGFUY2JveWZpMXNoaTdK?=
 =?utf-8?B?UHgyWWl5cFhZT1dBaGNWeS81cjBOTDJkYjhXL3htY1Y3WHhXOXpsL1JNTjFT?=
 =?utf-8?B?TVdtTFVmY2NUYnYyUEtsTEFNSTJYMUFWSlBKbnlrdVVGSXNXN2lXY1pZUWwv?=
 =?utf-8?B?SVhTNjVhelJtdGxQZXRnWXc5Z0FhWkVKU08wV2JjWWxaQ3k5ckpmOEl3b0VB?=
 =?utf-8?B?ZjZzZEFjOFEzMkwwVEhWTWtjWGpqcm8vNkRoQjRmbzhIVzJHUFRUZFFJRVhz?=
 =?utf-8?B?WFhrTXE2a1QyWk5xb1ZLQjJvaWx6dnJaSFVRcHRIYWhHYTU3L0hHTmJHMllT?=
 =?utf-8?B?RDdqSTJIcEkyMVQ0aE9WV0F2QU54VG9XS3p0S1U2NVJXbXl2bHFhZ1FPVVd0?=
 =?utf-8?B?aHRaQlZ1MDdzMkpsRTVhbWJrVHk1c3NCTi9BL2diNjRtVFpvM0xjdWxHTmVG?=
 =?utf-8?B?UWpteHhqK0Fwd0RYaXdlbU4wSVJPZXY4NVFNTEVON2VLQ1cyUEFoMlUxMm1M?=
 =?utf-8?B?WDFuMmNXZUl2NTgwTlovUEpTZ21TOUV2L24wendwSitsSXU5cnhIRFhiS25W?=
 =?utf-8?B?a1VKZjJqcnNuUXFaNGdyQXlGMU1xTXROdzVkYkgzY3ZYSGExZkkvNUc1cDB1?=
 =?utf-8?B?bGt1MWZOODdpeTdaeWRKZW8rY3VmaXp0R2N5dkZZb21EQjB4aGFYSXRucUR2?=
 =?utf-8?B?eGtTUlh0N0dxcEtpbkdOMGxUWW92azJwR3VpS1BETmNYd3NqbFkwU3ZpY0F1?=
 =?utf-8?B?aDE0MDBnOG5BelZxaC9MQ0p2Y1JxdW1nSGprdXd4YjUwZXdIMUdEdnQ0Sm9G?=
 =?utf-8?B?U2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FFA41F64E5F7B48ADFE76C47EED1B89@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2T4wFlbLpwT8szIeGNL9gIYpYu2V/YqDOOuFG7kGjhSnA91gQ9DwnVH3H24CC9oi8NJdE58aQ6ljQxIOMfdUr3p2yGL/4RvZMc2v1hOmaoF/volFV2cxJuIOU6epgrPu/iibdD50E9k8bYKsevSK769SCpN+zEc7JcJSAd3VxFKVIsl0lsoCOVXZ4odzaJU+1u4axBzqmO7V7XE4DTgoiZsIZOMlennDOnrlnhuZq7xoJE1hSBNrK3G5nLc6FgylxTlumHZgx+s5OzKz+u8NxRHA+4pRhGA2pyhRn0e3VlsgGA00di7KdB0Qa1lTkIwy3yxr4f/bHhWGBe2F4wnOtzsMaAHEjSnQSrzmJ5QJ5hCuz2czDl4NFppEYLIN6KhJjcgRzVAHC0WcLn4Ygqil/sOIoKEvmrtLp8pmb+3WQ6VrbbV/kKj6SySFpj2QmSzJhuCqDYvRKg8oj5fycryZi3Hd6HYFxJIbrxfzikrnEuwGKZjE80HI0VkUC0LzUL7tJCymUbjeJCgMqlK6JbNj6GJJd5Wgbuurwyq3ZHhPOcpbl6tX76ZLAVk2KDopeo6qg1E8c8VkWttIUa+Io1/O2AnUcWJlEaxH3U7gGnj3tpLuyIF7jnR/vUXfDEMgdwgN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60204ca-3ef1-489e-16f2-08ddbdde8ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 05:16:07.9835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OBXmfvGEOd389UzYNdXwCbzSstOyiGWk0ECrANT4jIACpNabOI2XL+PO0lU46n9WI0TT6oUqGmXoUA5hldS31w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8435

T24gTW9uIEp1bCA3LCAyMDI1IGF0IDEyOjQwIFBNIEpTVCwgRGFtaWVuIExlIE1vYWwgd3JvdGU6
DQo+IE9uIDcvNy8yNSAxMTo0NCBBTSwgTmFvaGlybyBBb3RhIHdyb3RlOg0KPj4gV2hlbiB0aGVy
ZSBpcyBubyBhY3RpdmUgem9uZSBsaW1pdCwgd2UgY2FuIHRlY2huaWNhbGx5IHdyaXRlIGludG8g
YW55DQo+PiBudW1iZXIgb2Ygem9uZXMgYXQgdGhlIHNhbWUgdGltZS4gSG93ZXZlciwgZXhjZWVk
aW5nIHRoZSBtYXggb3BlbiB6b25lcyBjYW4NCj4+IGRlZ3JhZGUgcGVyZm9ybWFuY2UuIFRvIHBy
ZXZlbnQgdGhpcywgc2V0IHRoZSBtYXhfYWN0aXZlX3pvbmVzIHRvDQo+PiBiZGV2X21heF9vcGVu
X3pvbmVzKCkgaWYgdGhlcmUgaXMgbm8gYWN0aXZlIHpvbmUgbGltaXQuDQo+PiANCj4+IFNpZ25l
ZC1vZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQo+PiAtLS0NCj4+
ICBmcy9idHJmcy96b25lZC5jIHwgMiArKw0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlv
bnMoKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3pvbmVkLmMgYi9mcy9idHJmcy96
b25lZC5jDQo+PiBpbmRleCA5YzM1NGU4NGFiMDcuLmJkY2ZhYmNiMzVlNyAxMDA2NDQNCj4+IC0t
LSBhL2ZzL2J0cmZzL3pvbmVkLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL3pvbmVkLmMNCj4+IEBAIC00
MTgsNiArNDE4LDggQEAgaW50IGJ0cmZzX2dldF9kZXZfem9uZV9pbmZvKHN0cnVjdCBidHJmc19k
ZXZpY2UgKmRldmljZSwgYm9vbCBwb3B1bGF0ZV9jYWNoZSkNCj4+ICAJCXpvbmVfaW5mby0+bnJf
em9uZXMrKzsNCj4+ICANCj4+ICAJbWF4X2FjdGl2ZV96b25lcyA9IGJkZXZfbWF4X2FjdGl2ZV96
b25lcyhiZGV2KTsNCj4+ICsJaWYgKCFtYXhfYWN0aXZlX3pvbmVzKQ0KPj4gKwkJbWF4X2FjdGl2
ZV96b25lcyA9IGJkZXZfbWF4X29wZW5fem9uZXMoYmRldik7DQo+DQo+IAltYXhfYWN0aXZlX3pv
bmVzID0gbWluX25vdF96ZXJvKGJkZXZfbWF4X2FjdGl2ZV96b25lcyhiZGV2KSwNCj4gCQkJCQli
ZGV2X21heF9vcGVuX3pvbmVzKGJkZXYpKTsNCj4NCj4gQW5kIHdoYXQgaWYgdGhlIGRldmljZSBo
YXMgbm8gbGltaXRzIGF0IGFsbCA/IChlLmcuIG5vIG1heCBhY3RpdmUgbGltaXQgYW5kIG5vDQo+
IG1heCBvcGVuIGxpbWl0KS4gSW4gdGhpcyBjYXNlLCBtYXhfYWN0aXZlX3pvbmVzIHdpbGwgYmUg
emVyby4gU2hvdWxkIHdlIHBlcmhhcHMNCj4gc2V0IGluIHRoYXQgY2FzZSBhIGRlZmF1bHQgbWF4
X2FjdGl2ZSB6b25lcyA/DQo+DQo+IEZvciBpbmZvcm1hdGlvbiwgdGhlIGJsb2NrIGxheWVyIHpv
bmUgd3JpdGUgcGx1Z2dpbmcgZGVmYXVsdHMgdG8gY3JlYXRlIGEgMTI4DQo+IHpvbmVzIHB1bGwg
b2Ygd3JpdGUgcGx1Z3MgaWYgdGhlIGRldmljZSBoYXMgbm8gbGltaXRzDQo+IChCTEtfWk9ORV9X
UExVR19ERUZBVUxUX1BPT0xfU0laRSBpbiBibG9jay9ibGstem9uZWQuYykuIEkgd291bGQgcmVj
b21tZW5kDQo+IHVzaW5nIHRoYXQgbGltaXQgaGVyZSB0b28uIFNvIHNvbWV0aGluZyBsaWtlIHRo
aXM6DQo+DQo+IC8qIERlZmF1bHQgbnVtYmVyIG9mIG1heCBhY3RpdmUgem9uZXMgd2hlbiB0aGUg
ZGV2aWNlIGhhcyBubyBsaW1pdHMuICovDQo+ICNkZWZpbmUgQlRSRlNfWk9ORV9ERUZBVUxUX01B
WF9BQ1RJVkUJMTI4DQo+DQo+IAltYXhfYWN0aXZlX3pvbmVzID0gbWluX25vdF96ZXJvKGJkZXZf
bWF4X2FjdGl2ZV96b25lcyhiZGV2KSwNCj4gCQkJCQliZGV2X21heF9vcGVuX3pvbmVzKGJkZXYp
KTsNCj4gCWlmICghbWF4X2FjdGl2ZV96b25lcyAmJg0KPiAJICAgIGJkZXZfbnJfem9uZXMoYmRl
dikgPiBCVFJGU19aT05FX0RFRkFVTFRfTUFYX0FDVElWRSkNCj4gCQltYXhfYWN0aXZlX3pvbmVz
ID0gQlRSRlNfWk9ORV9ERUZBVUxUX01BWF9BQ1RJVkU7DQoNCkluZGVlZC4gSSdsbCBkbyBzbyBp
biB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+DQo+DQo+PiAgCWlmIChtYXhfYWN0aXZlX3pvbmVzICYm
IG1heF9hY3RpdmVfem9uZXMgPCBCVFJGU19NSU5fQUNUSVZFX1pPTkVTKSB7DQo+PiAgCQlidHJm
c19lcnIoZnNfaW5mbywNCj4+ICAiem9uZWQ6ICVzOiBtYXggYWN0aXZlIHpvbmVzICV1IGlzIHRv
byBzbWFsbCwgbmVlZCBhdCBsZWFzdCAldSBhY3RpdmUgem9uZXMiLA0K

