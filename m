Return-Path: <linux-btrfs+bounces-14595-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2116AD4D76
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 09:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD6C7A1B9D
	for <lists+linux-btrfs@lfdr.de>; Wed, 11 Jun 2025 07:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265BC227E84;
	Wed, 11 Jun 2025 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BjgzplqC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="FHpxhVSl"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08AC2D541D
	for <linux-btrfs@vger.kernel.org>; Wed, 11 Jun 2025 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749628396; cv=fail; b=FX74D1kWHLRqVjhZb7iT2rEwCCnKOy6dORxnYVNFoWmtI5N/3jtngHaT0Nr7kAOmM92RCpjNMW6FeoMvYqdCDhr27/BN+2vlk5UrTvZHn5s3htrpCc0UZo8GSm45NZWkC3qjQSassf/bik5/ol//wfo3/J+qOx3FSgjwoE9uV8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749628396; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ipGxk3TXb0LRjG72hARanEPi5XJ2nXk2uadVBvmC8D7V2Ayche6mYgWDfP1gX7SBql6yG9T1o7QGFIwnigOCstwUnWK9cmgmQ39HXlXLOtvnUt4uBTqG1pw8jbRbg97WqZKTRA0eiCXRGSgLIvWen5+ARXFOLKY/+DuskDUr2uw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BjgzplqC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=FHpxhVSl; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749628394; x=1781164394;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=BjgzplqC52m+C5TRA4YkzlMVVu60JvA6IKSWgqk/Fojcjmu7MtQb3cgG
   1jRU9zfrDcZ21EPQIYOTMXNAQVR2ZXXaOompbPlWb4qVxswbVHw1dx9uf
   u7S8y1Ryp1a+Fc7ZTXaQj4YSET6WPQbNGTIWG0dwV734lIb+VdT9L9SLz
   1lhgUfVWll61FeeEqw3hM440Jsdlz2cH4PVNar2Z9mz9gnGu1dZ6cj5yr
   Iqq0p3StQIY8NXCo8A0YP3sIBhsWi9NaSBeOC7bcQNtU4cDCNd8ZnVgld
   469RokKD9CaJsgVJ9BUIPgjRE6D+wUI3r6AbhKgKQ+oofyvJas3phwWNV
   g==;
X-CSE-ConnectionGUID: EL24C/cvSBGogvGqNFBFdQ==
X-CSE-MsgGUID: g3LynFz4QQuHT9G2oX4GtA==
X-IronPort-AV: E=Sophos;i="6.16,227,1744041600"; 
   d="scan'208";a="84364647"
Received: from mail-dm3nam02on2059.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([40.107.95.59])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2025 15:53:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pKA2gBlhC277j6t4WpqdgNtAIn77MAked2zmRfS5svJ3Y+h0rKirTWN6rtlzJKTmJ0Opk/eKwHxM2x1VVdR+1TytgSaunPkwjbIFX80RishB8eEcTf8Q+BNadlzsFTdtl/fpXAO69Z5gmNE0TiF+61Dj7eFW5XIzMx9srbCjph4IsN1noFvIa/IZb2L4wCgdGfICO1iowreClX6dUH3SPfV7afKndvELKoWUM6pWVq0fIhWfnRKuu/JNCq1foXY7v0b+vd/mztGdsm0IvIhR2xZK0gktFCTOCt4OGY6UCgY8dtFL7Ljw2sXAd+Y98fH+pGvAMT+2so0OOgHSzPnMEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=VsIWb30b445A5ARoeC2tt0Nay7cqgBhDh5qqIXqchyzB0HeA3ZX/zLbNCtuCE/nz8RNuXvkBjN/8j/bJs2ufo4Bjl1yRmkoBEai6r4U+mR4apZWwV+zBqtsF9gFSLmaF+aI50azCn0XnsH8DtpcMapQC+LVg17gRnG5ur9lA/IxqcjM3OUslfTuiJjJAo8WT3KclCvtRClsCzOZRI7Dk7aer5h9zh4/Fe5HA264xoNUtoH3rvbG+9w0q7T05BEgsSQh37EBLVLypVWBLJy3nMckQLwVDFtpzJGoCmDwTlUhLuFPx15Kajm/EpG7HzULEJ2YSOpEStmafTq4CqZP/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=FHpxhVSllMk2ae9ZmxR0vTTwnYJElZIvt8Ud3EXUFJluaEFrQfKVDAgmw5lOWESeLwAj6aWkNL+ESGPWoKFrt5IHd6ffCnm3ytGa1AmP6bwvyIucM3P9x/tkXeFSZW17F8h5Fy9XsMvgr85CBPXjHTJWI1kCTTNU3nIWkSvhmhk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA1PR04MB8445.namprd04.prod.outlook.com (2603:10b6:806:334::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 11 Jun
 2025 07:53:06 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8792.039; Wed, 11 Jun 2025
 07:53:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: use btrfs_root_id() where not done yet
Thread-Topic: [PATCH] btrfs: use btrfs_root_id() where not done yet
Thread-Index: AQHb1wt+QYi0DwdJkUemzmtPX+HXt7P9naOA
Date: Wed, 11 Jun 2025 07:53:05 +0000
Message-ID: <12c092d2-0616-4cfc-ac26-329656add4b7@wdc.com>
References: <20250606175014.3564308-1-dsterba@suse.com>
In-Reply-To: <20250606175014.3564308-1-dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA1PR04MB8445:EE_
x-ms-office365-filtering-correlation-id: 450b67c7-9e5b-4873-e666-08dda8bd000a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dktXL2xYT05MREwvaGhUc3BLL1FtWWkrU3hRTnlheE9MelZ3TWFKc0JDeW9H?=
 =?utf-8?B?ZUhWMXZHbm9MN1JQUWJqQU5qeGtzWnphRnBnMVE1VzBqVFRVV01jRGc3eWdG?=
 =?utf-8?B?SGt2VENHWjVnaUdpS0NYWDNVMzc0V2NUUnpyS0VVVGlxaHF5c2J6cTdmeXRV?=
 =?utf-8?B?NWw4MzhsTzNzeUt6azRCY2RlaXNDVVo3bVpabkxEREliZ0hCeEdZZnQzcTV5?=
 =?utf-8?B?cFFlbjhPN0RCU2s1Zkk5STRPL29sbWtLMW9TK2dBemk3NlpSRWE0S0JqOVF5?=
 =?utf-8?B?MGNVYUREUEplK3Z4Z1pGVW1TaXl4Q1psaU9MUUlvdEt1SWpyUnVDTzJ6eG91?=
 =?utf-8?B?L29uMklRVHpQQkh5VTYzSlhHZ2dGUTZ0bHNqb0NkUFp1V0VrOXRKbGhsT1pU?=
 =?utf-8?B?R2pwUkRGWVFIeWprWC8vT01UU29UTm5paWtiSk5aZ3N1em11OHczTlNtSnBw?=
 =?utf-8?B?bE0wTWtWZnd4blRKQkJaZzBiejFUWktheU9OSVJNNjljZ3JoVEpxWEVnUXA1?=
 =?utf-8?B?TEYrSzNMZGpxYjg0MmtwWk0rbmpLQVBoZ1E4a2Z3Y2M5VkZJeEdKZWhGNnRR?=
 =?utf-8?B?OFE1blhHQTRlWlMrUWh1WjdyZ2paRWtlOFI1L3JETHQxUDkzZHFhSDBSbWlV?=
 =?utf-8?B?c1FrTUFTdURraUpCcmxmdU5tNTVFd0lwdmxIOEtzWnFqMENWQm9PaHRodlhy?=
 =?utf-8?B?VXRJa2ZrYlA4ZzNHRElHVkFLVFJ6Wi9mdkcxaGtkR3FPQ2pnTXdSUHI3K2Ux?=
 =?utf-8?B?aFpsTUZXdHI0WURycTZucHJ4b2VmN040clF2STAzaDFjZFd5WHF1TGVxSDlT?=
 =?utf-8?B?TVIyQTdNbHlPN0wrVWx4Sy9kamdBM3hOcTJ0UWRCQUV4bHZJNW1vZm4yN2Zi?=
 =?utf-8?B?UDFRZVM3L2ZlTXNrbWhGRDBjS0pabTVoSC80cEVYZGhxakR2Z3JseWh6bUhV?=
 =?utf-8?B?Z1pzaFZidVd5MHpnNHlsVHBDM0RLWUZEVjNxUVdYSGltRVVFRVl0TGlGOTFx?=
 =?utf-8?B?SEM4U2F2aFdEc0RoazNzRlZFNTVkOUJ5cFNGZWpUVHUzR2NiamFES2hZaVJx?=
 =?utf-8?B?L1MyNzdDaUEvc0lJN05YbUU0eVFQSDBKNjlyZHU5VFNvckRpRzI0bGZUdUEx?=
 =?utf-8?B?R3BLRDJIYVlYZE9nY0NUeDlhK0lwT2lpODdSMHdMeE01VlhsaTQwNW41U0xI?=
 =?utf-8?B?SkR6Y0JHOVJPQkkwM2oyQjRzdHhzVGdLS3hHTE12ZU5JWXdod1ZMWitUaUh1?=
 =?utf-8?B?UnVTWVpIdmpOYklMTzhkTXhzTjFydDlrRDY1aFY5WWUyZlMveWRxOEc3NHlJ?=
 =?utf-8?B?b3VMZWNHNEdKcW41bGFIeWQ1aTVRVSs1UWEvMDJDZ29nUzcyN0U2SFBLZ2xD?=
 =?utf-8?B?TUlESVVQOWwrUFBHa1B0NkErN1drY0ZYUnBpZXgyOG1HMDlSbkZtdm4vSlo0?=
 =?utf-8?B?OG9WQUhzTHFyakVSMHJGUG8xU2dnVHdLQWFGVnA1a21pV0hxK2pUdjNQa1pI?=
 =?utf-8?B?YzVQdlV5cXJnNXd1UjRhU1NNR1g2dGU0bm0vRjRyUmpkWldiL3l6MklnaXJv?=
 =?utf-8?B?S3ljODBLK1ZuVGZPUUw2MVM5U1hCNk9zNDBnNUNrRWFGYmZRRFRzUTFIRnY5?=
 =?utf-8?B?YVlGaVNobHlmMFo0MUJsbUdqN1ZpWFc3WWthNVEySXE4K3YwWGQ0NnBkbkRv?=
 =?utf-8?B?MkVzdzE4WVFuQ1VqMVFwNmNyeVRacVVJL3FnVWxWVVhtVjNlWmgrbE1oci9t?=
 =?utf-8?B?OGhXQVRYNHdHM0RDQlo2U1BoQWVCUTVxakpsZmNtWEpTMlEyQTJvWFYvL3di?=
 =?utf-8?B?M01icU4wb3VOTGxpQll5RnNDTlNhUEExMHZzd3lwLzkzcGZrN2ptRGtobXZD?=
 =?utf-8?B?NGJuQy9WUDZ5YzF6MzNqYUFxcFczQ3llWDE5RS9iVktBV1BRbXJER0I5alpj?=
 =?utf-8?B?NFhqVklJc2tLeXZVdHh2MnZaWC82YW1kZGI0RkNUVTdPRUgxbXhYOWJEbFZk?=
 =?utf-8?Q?hjKe5MVTF76wmoTrGzdvHK/AeYnOrA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SWhnSytqQWhnWHVzVkpkU1N2N2g5Qjh3T2owUnlYWHNYMWJkMWN0NlZKK1Fh?=
 =?utf-8?B?bVJ1azMvUjdQbHowOXVDZklod3hNaXVBMk5WRzE1dnBIaFRVYkkwV1FSUEMr?=
 =?utf-8?B?bHdCamYzQTZDK0NPQTd5RWdIbURKZW90TGc2QVduNEFqM0ZzTVZvdS9Hd3FX?=
 =?utf-8?B?N016N2hqc0RTTkllT2c1TXNxdk9QY0Y4a052VEs4dlJPVU44ZFFJN0ttdUtp?=
 =?utf-8?B?bDlwR0l1WWNGQk9mdWZvZGlyMytLRUhKL1g2VlRtVHJrbUs5cENXWFUrV2ZZ?=
 =?utf-8?B?cXkwakN1UkhJQU9sVEpBKzdOYndEUy9WQ2o0NmR6UWxVaW1FdWswdWw4SnNR?=
 =?utf-8?B?Z1pEZTRvRk5MckFpUjQ4T2dqVDE1KzA1VVN3b1JSc0Urc3k5YlhiZjdYRkVC?=
 =?utf-8?B?SGtLdCswQlhsc2VEdmhsQmEvc3pOQ1A2RGU4QTZMR1dpb05pdVpNT1A1Y21i?=
 =?utf-8?B?cW1MR0g5aEdlVThiODM1TXVHeHhZM0RkbkFSQ3R0cE03NElTbzRWNnhpcDR1?=
 =?utf-8?B?dUhKUEdtalEzbEZZWXNSZTJjaGJCaEd3N1kwVUU1Q2gzeUhVY2RPZkdKVW9W?=
 =?utf-8?B?Q1dRQVFDVFRLbkJUVWxNSG5nR05jRms0YUd4em9GS1ZMemVtb0tMY1oxcFh3?=
 =?utf-8?B?dExETHNOK2s2NXlmQ1RkakRWdk42TUNRb29WV2IrYmw4U2QrQklwR09OT2dF?=
 =?utf-8?B?Yno4Q1p4a3R5YzRqdVg0UjZGSjV4N083VWd0UGJwZDFQdldQM2JiU2UwRkpY?=
 =?utf-8?B?K1pKTXpBNVZYUWo0U09zRWRmT3Q2dFpTUWdJMHZxZFg2VFFpaHViUWFZRXZ1?=
 =?utf-8?B?UVpSSStCWHVlNjV0TFpKZUZpVDFpSE11NUFFZ0RzNjFpbzJidGJVZkF3YkRl?=
 =?utf-8?B?ck1Rc3F0MXpDYmFsbnFpWUxjbHByMzloNXM3ZDVHb0pBazRaeDhxOTc5UE5C?=
 =?utf-8?B?dDc0Z1J1U2MxWUFSUk9qMzJveFB4cmZSWlQvcHVLbU9XdGJoN1FOM01UbzF2?=
 =?utf-8?B?aFhBaTU3UFBOZjVrUVQxZ1BpeVVrUkg2SFlVNk1paEtBaUkwUUJNVG9XOGhQ?=
 =?utf-8?B?R0QyR01iTkxBcDRaUnoxT1E3NjZxenRsa3lBNk5XOFNWS3ErV05YZ1dZeFc3?=
 =?utf-8?B?cTlacXZ3M3NXSU5CL1ErYXhpREhIejdwZERvWml4T0dxZjNkN1NDbGlKaUdG?=
 =?utf-8?B?N1B6ell2Nkc3RFFhYldvNVBzejFLblpGZHMvR1NkT0pGQi8ybk9XbUx6RnBk?=
 =?utf-8?B?UWk3cWcxNlQ3M0xCU0xsa282OGNxREVzV2s4VmxwWmdlZE8wWFF3WWxIaW01?=
 =?utf-8?B?Q29qaFZNMXZ5dDhEcEhPa010UHdUMk5CZjAwa1lTaFMwa04zTVIwQ040VzRa?=
 =?utf-8?B?NnJ5WmlOMmdpNkh4SDQ3MDl3VDJPOExadkkzNVJJVUpkdlU2akFJV2tvTno3?=
 =?utf-8?B?ejUyWkR4c280UTlKN1Y2aWdNV2swZFZmaGRFS3dEb0M4T0ZIWHBuaUI3b0h6?=
 =?utf-8?B?K2svWXd2Z0ZDdmp2OGRRM3F5bTlPemk5Z0toRmNIMTZhcWJhbnpGWFBiQ2lj?=
 =?utf-8?B?djR1aysyT3hRZFJ4eXpES0k5NU93ZlZ1cUp5RXNBRHhSK2VmNnlYYzVEdTBB?=
 =?utf-8?B?YTU0QjYzTXZoK2pkcWlFNnc3VEFZK3M1bHZQVEpZY0hveVV5WEhPSEo0YkZx?=
 =?utf-8?B?K05IM052eG1GU2hCYkF6MUtxbkhaN0piWEZjcnNVSEVwM0ljNnk4U1hjUkpz?=
 =?utf-8?B?K3NQSVVReTNYNENSSDVHU3FmMTE0eUhSNThjdFVGYlI0UTM3czF4WFl3TUxD?=
 =?utf-8?B?OGtQVlBUalpYVnY1UFdwMG1PeC90VkpjRVZNMTJvMGN0d0VDTGY5Vzc2QXRZ?=
 =?utf-8?B?QmZGdmhBSkVCQk95a3hrdk9kWStwWHNVN0E4bUxSUlpOeW1mRkJNWUhBWU1C?=
 =?utf-8?B?MzhYbXFiM0VvWDh5Wi9TRkw1Y1FWT1loRWRVT1Y4ZUozTm0xRHc4dW5rUS9z?=
 =?utf-8?B?UFZXMTB1RWxDcDYxNmJRM1ZhcXFUZ24zbTFqTnlKMzkrd2xHRSt3Rk1rSG1Z?=
 =?utf-8?B?Rm9vN0FiazBmYVk0U2VBc05taVJERnNkMnVoZWcrMDNaK0s5UG9GcEo3NytH?=
 =?utf-8?B?cVZUa0xwMWQ4U2RQVEFlTGxoa0tiUWNjbEdYN2RIYS9TYnlhWWJla0duZjJK?=
 =?utf-8?B?bjlZUVdjZXdwUUNFOU90cVJuWGhwQ2xvVnlmR2wrdU05MzBYMGtiVWhaQ1Jy?=
 =?utf-8?B?dEpFTWlVeVcvSjBlUnBLdUFQNmlRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4293F1F9A46B54284E67963EDC1F419@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ybASBkpBewNiwbB/MhPwWps+frspeqZQj5r8DqqAtOL+EOBlgzPN/eoUq4naWGAjcIA4FtFJXyPl5zVZxGKmnjVbpOvj8vAC5OB3T8QX5lvsFdIRCKUZCtMb1VDY1ZPZVKhOxEy5llTn/p7X8jhY03DSn0obLZN2TlWesQv/N66hmZrwttG0Ed3ASAxdVqoMhyklV97fIgI+RqqHXqlsTHsC02uwsG7WaGYdkb96Y6s0Hbl6tSWY9xzNa+bT8Ho09j9lPrgdY61mE/VkXbofVdmu5Vs2QIUnc5ImtoNLohizlrlSqy1IGZKbxLJmTxCHIsYgGLPv9GVgWPlUSGvcp5re89oLkIf1bGOxEzz/UO2zSV4ssOiddKBG6b7kU0iKbhwPAWgVveZJqxeLmtQKXTQ4vHRGRkB9Vc+2nv02/+P68aTorrq4f8Z6U4ppO2oGGPPM8TN1w7MJTIHz9mfGl4hk9kULq8KQFDatviLPyFe1BrPRBFrKR09hkpIIhrKh+d+tRIPUJgVmLjjB0rTl8LhT1lND5QkKDcNvPDCOqPe5hHcLGFS5oGrO/tknCJ3zRPy75pRFMj50SYJ0qUYi0AbycK3hP5kKgcrz1+TzsnMeDAfiwErXCkyulvRMFVYo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 450b67c7-9e5b-4873-e666-08dda8bd000a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2025 07:53:05.9257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V/yBsYLr8+th/abnuakAcXqXNKXKVpjLRfaTWMtvBMPpgkaGOXRtuEhNWwBGFLCs3Z5mU4SzbP3S8NVE/ffwp3gdS0llH/kWoJcTbRR71ww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8445

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

