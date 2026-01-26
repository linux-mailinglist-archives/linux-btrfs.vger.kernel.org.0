Return-Path: <linux-btrfs+bounces-21052-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OXRIRMdd2lDcQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21052-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 08:51:47 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9E9850E6
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 08:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 713893006B26
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Jan 2026 07:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1793112A1;
	Mon, 26 Jan 2026 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WhkBe4+f";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qs1rDlO9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FA93101B6
	for <linux-btrfs@vger.kernel.org>; Mon, 26 Jan 2026 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413897; cv=fail; b=mEZLFaRDNBJ2LxubXjQg0inf410EifqUHgrljydCharqn5zx73N5+jslf5DAiF9ibchCK1HnMeD8zgtcDgAQBDgNNpaxQUeGA0+tEkLPitHYyRa/TVJy7gdkKUkSj1H8uKv7kjW+ccWfk8R5Hh4UYCHv9ssbv4unWQMp3W0s5rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413897; c=relaxed/simple;
	bh=xiqP4ZSFCQWtBGuV2WsPqUBnW16o97uLnpabavub1vo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YbL/SSxGBFqYZ9Ll0cewahhIPB7UcuLvMoA7wIfyV5UWqkjhguoPJcXsduxK49jHylcl4rkpAyyvIbbj5POfyrvbazH5yZH+JQgfWhP454nEMvYLZlYFodtRU/lzpSziIP1ObBcG8mZSvIlK9H6crZ+4baFl0UcgFefeFSRAXNQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=WhkBe4+f; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qs1rDlO9; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769413895; x=1800949895;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xiqP4ZSFCQWtBGuV2WsPqUBnW16o97uLnpabavub1vo=;
  b=WhkBe4+fuSP9HoA727nYkHkGmuBtC/Cp33CwP4f6DN56At2gzFj7C9Wt
   HL8tBFNJGqwrqv+ftga1HDmc4xiBqeAOL3HkHkmFDuBaxRgyyK582femF
   yYSlpDN2Zm3/qj0RAEZX5vF69EdHlTkf4Sjn6TyIeLcxLqZA6/bZipcXM
   +LPasL9nwe+Q6hB0SmVTBHFWOy0IPqBvnxAUUOU20RmOWH62TzV+a0mcy
   zgyG6n6sxF6nC7H5r3pxDCI+CJGoWmqdHzkrAZs40NBTCCCPexBuZT0JC
   ovbqUSwztWM5raoZR2cTz+J+mzY+Cw5xm7nW0ZYzDRXlYsjXwTZENxUsY
   w==;
X-CSE-ConnectionGUID: 7ARqb+aSTJ2pCe21BmpoYg==
X-CSE-MsgGUID: UpFgxeV5QmyICF9z6+UrWw==
X-IronPort-AV: E=Sophos;i="6.21,254,1763395200"; 
   d="scan'208";a="136057677"
Received: from mail-westus3azon11012054.outbound.protection.outlook.com (HELO PH8PR06CU001.outbound.protection.outlook.com) ([40.107.209.54])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Jan 2026 15:51:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PPKEv/8l7GeQadoRjpLwEqpirIAB3Qrxw2OxFLH+4dpIXlw6prTq5fnIdjYHS3LInX0phngTL4p4wTBuf/mX5cKiZ7qd6Un2F3GIoQvtjIAKKLX7nNp/B9gYNG6xDHnD3qdqDLHgVG5nYYrDMs597OXwXhzAHgVBbw53S3WAOwbsagIZt2x7BUunk8s3PIy4dIr5h7NZ/owPB9t8PcaktBe7YEyT5On6gOacfs9nzskrrVnkqn8OuM2TOQkTPoBQOm/ulSvs5SKie+5ds47TIyVRFaBjEdqDpMHDARBA+8epUkv8iQRq5pQQQkHqKdzcMcqUEG+0i4fc+sljsJ3bpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xiqP4ZSFCQWtBGuV2WsPqUBnW16o97uLnpabavub1vo=;
 b=qKUhk0rOMIBCPyCiG/iGJ65uC7V9Ox9ljGqPsWxDblUdMcsdgNQ9m0F/BkGPEl9v5GOj6AIdIHHKLsWi5puhUdmeeNvV2jG5L6PTFV+62wZxcVBrR5XpTRNfpRCy0FDM7t9wZN4mj4vWL/jNi/VAC0FmRvgfFLGjuZNMEdx5zXqjBiGetFFI3NbROE+lcxx4YlHkScDDm73Z/Gm8ILZnHtrtSeq6VV68mll6sc0pX/MgX3OBhlQKqPlHk7/j5+NJo60vdIxSj+48vlQVxEJd1uGIUVWP09QqPcyqQ8q77t/nVksN5Dcgopdcjw1R7yj4+8rrKR8/s/UU+VeBXpDUrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xiqP4ZSFCQWtBGuV2WsPqUBnW16o97uLnpabavub1vo=;
 b=qs1rDlO9jtQq2qdTad8HABc9jturtPlbuIvxgMSeMM53++TIcete6xBnptUqQ6VAk9KDOSRJuJlGcikdSQD7DMPXd8HpsEAVjVREDS9mcBMHnoHb/JR5cFUjiDFrcxGIiVLXqFInWvWYY7Lime3FIGwEu9Z0H2MISWqQCL4Eddg=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA6PR04MB9237.namprd04.prod.outlook.com (2603:10b6:806:417::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.6; Mon, 26 Jan
 2026 07:51:22 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Mon, 26 Jan 2026
 07:51:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chris Mason <clm@meta.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, hch
	<hch@lst.de>, Naohiro Aota <Naohiro.Aota@wdc.com>, WenRuo Qu <wqu@suse.com>
Subject: Re: [PATCH v3 1/5] btrfs: zoned: don't zone append to conventional
 zone
Thread-Topic: [PATCH v3 1/5] btrfs: zoned: don't zone append to conventional
 zone
Thread-Index: AQHcZRt6q7H5DwzOLkuXFjCQoV73jLVjLjeAgAE4twA=
Date: Mon, 26 Jan 2026 07:51:21 +0000
Message-ID: <a4bf91f2-c68e-46e4-9fa5-0cf563e5ad4f@wdc.com>
References: <20251204124227.431678-1-johannes.thumshirn@wdc.com>
 <20251204124227.431678-2-johannes.thumshirn@wdc.com>
 <20260125132120.2525146-1-clm@meta.com>
In-Reply-To: <20260125132120.2525146-1-clm@meta.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA6PR04MB9237:EE_
x-ms-office365-filtering-correlation-id: 7235d061-ac04-445d-9f99-08de5cafb295
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|19092799006|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?TzRsQktKN3hua2JselhjZUg2RjZqZHFRRjB6T2FCYW5lNGpGN0thZjVSRjFZ?=
 =?utf-8?B?MG9rRThITm5CZy9Mc013UjFlY2JPR2dub3BQKy9iZERlMWVlRlJac08wUFUx?=
 =?utf-8?B?L0RKdVorc3hmenNyN2VUaEkrTFJzdDhZVTVlSkdlSFdaMHVOSkdZL0l0a1NZ?=
 =?utf-8?B?djZUUnIvOGJaY29Ud2o3WmNUL1pVM0cxaGM4aVZXdmkyWHBaTENXZndzWGRZ?=
 =?utf-8?B?NG1nZmZDaWxzR1NyRHZ0SGE4L0Y2aWpaU3dkL3BBNHZVSVVVb1NzZ0VJcSt4?=
 =?utf-8?B?UExhNURjT090YjRkRDhabkRNMERGYlFOTCtYeEYrMFZOOUhLL2V2R2VvQjY5?=
 =?utf-8?B?TDE2S0JjaUtoR2g5bm5YRUVoK0VEZjM4YytyTzZiOE9GUzBHZklsWk9QTjRp?=
 =?utf-8?B?VlJlM255TkZXTnhrVzJncHpPbWpKMldWek9xalZJSEJOQyt5VDlHS3FnOTRR?=
 =?utf-8?B?dEVVNUovMmhrVER4NHhRUjAyU05EaG9XdGx5S0dsTTVMVk5DRm53ZFg5bTZq?=
 =?utf-8?B?eU9ZY3RqMDhGbitEREVGa25hdlVXMUxoRWRIeDdDNlZCUFh2ZzY2QkxHMHpS?=
 =?utf-8?B?cDgwaVdIa0hNVmpCc2xvTDhaUk5BVWpncG5odWlXNDJQbFMvTFR1NEJqekEx?=
 =?utf-8?B?RXJ3eGN2Tzh6am5hRnpVNDJ5VlR6YXV6WEVLcm5SNTVDa2EzRWdheEpRNEV2?=
 =?utf-8?B?aWliZEgvaEEwNmpuSjFUMUo3MFM1WDBHNlVBc1FrZnYzRXFObEU5MWJSeHFu?=
 =?utf-8?B?TGpQSlpIOG1zNTl2eEtLNzZ1d0ZxMHJIUmZSSnQ0R3ZGbFhhMDMxL2Zoei9R?=
 =?utf-8?B?aWRXeUx5S2wzdlVLZGErY3ZVTFlvTkFGblZXN3FFN1UvbFFXbGRZVzEwYng0?=
 =?utf-8?B?T3lNUmVKMmRoQk5ibVNNS1FvQWdKYkVIRmhYNGdCYXFkVE90c1RCaG9RdTl4?=
 =?utf-8?B?OFllWHdXd3g0TmhCS01tQTBraEx6V1BJQmJGazNSSDBXZVNyN052amQySjUx?=
 =?utf-8?B?MzJwMnNjYm41ekZ5aEQ3bnRrUytlRGVyT3g4R0JCME5LK3k4WmM1TS84VFgr?=
 =?utf-8?B?VTVFRGg2M0FwYnBsSnVyTGMzOHZtNFBaMXNIeWJ5KzRuSnk2bXh0Zkx3bVY3?=
 =?utf-8?B?SkNGR0t5d0NPcklxWnI3T21Ddk5Vd0lLQWFUUk5HclVqdUo3NGtaY2dHRk1Z?=
 =?utf-8?B?d3ZvOTh5RkxJRk82MWUxdzlmbU50YnFsOTNyY2R5aGxIbktyNDlVeWtkYmh2?=
 =?utf-8?B?aHRwN3lqNGZHYzZOelBEWEVsa0c0VFhCMDVjcFowQ0ZOWkNyME9NbVFKZEFC?=
 =?utf-8?B?T1FHR0d4LzRjQkd5aGJPdzNiMml0eFluMWNBOVdKb0hMcnhlZXIrbTRFejZo?=
 =?utf-8?B?ODdRN2lKZjU1YnU0ZlBGTUtndEMvd0xPVEUxZFpKZzFvcGVQeGt6YlA2d29P?=
 =?utf-8?B?VFZZMXRSY0o0amVRNzNxK1lITFhOQy9Ud24rVmhvREd4Vkk2MHNudWZHVmNh?=
 =?utf-8?B?dW54Vy9BeE5mUEFEdCtyeDdPN2VmWUNNZmQ2RjlVQ21oVm5RNEFXVVd2L0NR?=
 =?utf-8?B?MkRHSDJXTFVoaDZZRUUxMXg1alJKZ2lFb3ZEQnp2RjlwdENrcUdmZDhqRTdm?=
 =?utf-8?B?NzNZcTVPUWZqbUw4WllzNmdyZlQwdldjdlp5bkFDY2lTSENicDB6Z1JpYTFk?=
 =?utf-8?B?VDUvLzQyblh4Wm1WN0RSSHh1VzlvbHlEbmg2b3ZOcVVQN2pUQkRlZGpSbVo0?=
 =?utf-8?B?bEExbnByVDRYSWdhVzJSQmUzZ1pMeElYSU5TQkxvclNNM2tUYjhYd3dQdkxk?=
 =?utf-8?B?bXB6MzBCTXVwNEpFY3lRczd1cVdxbFE5aXk0Sjg5VndtYy9tNDhXYVNVd2lu?=
 =?utf-8?B?MDFrZ0ppNGFqRkVxUktKZ3VlbkNsNTYwK2RUSldKNEFLakJSMGRnYmtzcnFO?=
 =?utf-8?B?QjJJZmtJdjBtL0o2QlRjd0J1T1RRTW1Mb2FpVDhIeDlId1dGTDlTR3h6cHpM?=
 =?utf-8?B?RWY4OFkxYkxsditzd0hNaDlvL0w1ZmR1L0JQVDhYaGc2ZWpJaDRQQklRWHhP?=
 =?utf-8?B?U3E4Ym1pdUJaYk5UZFgxU3BZcjd2UnR2NnVJTEVFQW1aRDU0d21BYW5tM2Zj?=
 =?utf-8?B?MGQ5emFUYUdiVXVNZ0ZlMkZOK1p4b0p3SVMwQW9qdDd5Q0FzeXE1VE5sbU1j?=
 =?utf-8?Q?mSGz3djEDyB3ra6HR+D2W8c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(19092799006)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RXQxK0laNCtHYmNQNi9kZG5GQk5hVWZUWUJyVmROZGhPKzVibkRiazBVbGFZ?=
 =?utf-8?B?T21BOE0veWltOWI3cUpPL1ExSFpQbTJMajQ0WHhxYU1BT2FjajB1RG51aGRx?=
 =?utf-8?B?eWxtZDd1MURYVXo3L1poV3Y0V1gvLzU3akFkTmQxRlNYMnhrcExtOTlKcGxU?=
 =?utf-8?B?VU1mRll3ZlN4UVZpYmQ3MXJtcjBTRk16UkJISTRwaHphaStRMGNGRjhTeUNU?=
 =?utf-8?B?N0M2Q29zM0xuYjM4MW50cy9rem1WakFkMG5WWnJNTjBHK29CcWNVZUR6UlFM?=
 =?utf-8?B?Rk9pdUFhVlpTYjEzVEp6RkZoY1QwZ1JDWnZXQVVTaFVqZUI5SXc5TGJ6QUt2?=
 =?utf-8?B?U0x1QWFxZjgvRjVZRUlzRzU4eXZJOHVLdlV5YWN2ZVowejI4bys2bVQyK1I2?=
 =?utf-8?B?aUE0VllwL3VvbnpVdGQ5YlBHNDVtSlAyeUZxcUtYU0FCbGt5SVBTT1VmMklM?=
 =?utf-8?B?NTk5WExXaDg5MjNUeGR1UTZ4eWk2MnRlMERObm1XdlFqSHRiQXhsSTR5anJ6?=
 =?utf-8?B?eFZ0eGFaODJTRmJCOHlXTHdVUzBrY1g0a3ZkUGMxMUJwT0R6VndPL2NBVjc2?=
 =?utf-8?B?dU1iZGlFOWtPR0pqWCtpRi9yMWlOTFZBRkpJRm5YWGQwampYS1U5ajE4cEE5?=
 =?utf-8?B?eWk5WWVhY3pQRWVuajE1UmRmMTRCckhKdlMwbkZod2tQWjU3R0EwZWtWbE8z?=
 =?utf-8?B?MlhVSU5MM1pScEN6U3pzVGZTVTdoNlNxQ1d0YnRIZXhZd3lONE5VdEtTNGdz?=
 =?utf-8?B?RlFYVWh2Q3BKZUxMVTVzTktGYTZVc1RYY3VKTmxGUGNrQzd1WjRkTXBjS2kw?=
 =?utf-8?B?c0I4RlNqMkE3UnJud3Jxa3dPaXhqTy9SaHdkd1ZnSFk5bWIxMks1OXM3WUNi?=
 =?utf-8?B?aENITUVyNkNoTnk1emh0V0JRVHhSeGlWM1JKNG10bWEzaS8yY3JJYUhodHlB?=
 =?utf-8?B?Szd6Y085cTNIL05nQnc4eit5SkUwdGdPSWdoNjFDdEhkdHJTYWlFWkIzQm05?=
 =?utf-8?B?UXhxZXBiOXJmczFMN3VwL3VEUlJlOEVxVWZjejd5SjBGc3FLczV3QzJPZDdt?=
 =?utf-8?B?SVRnV3VoZDB3MVc1WTZRRzRJdmxFSGNGWFJIWEJZR09NTEpsMzRuT1RzQzZV?=
 =?utf-8?B?VEl2OWIvZ0YxMFdkSWV1d283bDJkZUNyQzB6RERERklBNlNSTVVyMWdPR2Y0?=
 =?utf-8?B?WWhPcnlOOGxVR1ZyeE9DN3Izb1BNeXZ4d3hkYUxHaGxuTVNPZ1NvUjRRTm9v?=
 =?utf-8?B?QUF5ZGJFRnV1Wkk3eUhTeGZTZGcwelFCK2dFY1NYSEdjTGpQV3BuWHVBdDdJ?=
 =?utf-8?B?dEF2TnNyQ3dsdXpGR3ZzSWVNelhHZDNtQWJxNXBDQm1KWWJNalZkSmlrVGxU?=
 =?utf-8?B?NHcvRkN5MHJLYlI4c1kzSTdyenM1eTZZZXVka2Z3L1Ezei9OSE9zdGIvL0lZ?=
 =?utf-8?B?c3FuM1lLeWMxbGpNcE9lZ25tWExBWGg0dU5DdE1oMVRSdG5EVldUMWI3Wkxy?=
 =?utf-8?B?RXpmempHZGErZVJUc3krRGoxcTBpL0dlRGg2dW96eExtVGgvTytXdTFqTUJK?=
 =?utf-8?B?bUFZR0Rodk1EQ0szbU96SU9UbFMvSkt5dmt5eWsrWVFwYXVIeUdvZjRGaWsy?=
 =?utf-8?B?dnBUeXJkQmxjZk8xT0o3NDc4SHFsTUtHSFp2ME1UemI2WGZuc055MXVmMUJv?=
 =?utf-8?B?ZGFwbmZVU2ZSc0FqWk01bWRDam9yRlZXYU9UUnhjRVE1MkpIVDh1bnNTMEIz?=
 =?utf-8?B?VDFzWWZqWlJmM2NVNlRvTGd6bDhvZEtRVUpGZUlHKzlZSENkb0pnZmlHWDl3?=
 =?utf-8?B?UTJ1b0lKWmFCNEZReXVMVDdjN2x6czZPK0xqMDZqeWszM0hidUkzRE9hci8y?=
 =?utf-8?B?dEJDT3QrcitvZ3p3WU5hb29kYSsyQko1a0xSZ296YnJsb0c3OFZURFpBTkNW?=
 =?utf-8?B?bW5QQkhkcDExZUNlcldsK2ZFZDRPYmlHeWo2bjBGeUhGVEo5MnVDbnBrY1BG?=
 =?utf-8?B?T1Z3ZVc0ZnM3azhrMHhna2RxR2lNbCs5YnJ4RlBQdnpBb1YwTkIvaVV6bE0x?=
 =?utf-8?B?MllRaWsrL2pkUXQrWWtqTHJ6YUdUWGRJRXpHSzl1alg1WEwxcFpBSUdVS0p6?=
 =?utf-8?B?L2lidWg0SFVRbGU1Q1Urbk9wSXpYM1dNdi9udGZrLzlKbUIxT0hNNVo2TnRx?=
 =?utf-8?B?R1E4bDJ6SHZrSGRpOU50b2I4bHJWUnFJZ01xQndmN08yMEt4VXdFTzloMnF3?=
 =?utf-8?B?Z1p3cE1rc0JESTVjZStNd3lrRlZpU3RzN3BiaG5nM0ZLWEg5bUJQbXhTRVdo?=
 =?utf-8?B?b0dNclVwSVJtd0pKeDllRWloV2JVZHVWcThXZ3BaMDQycTZWK0p1azZUYTVJ?=
 =?utf-8?Q?QKPvC1iZoRnsekgPE25YWWNQ+pWj4tjsKwl5pkjFoR5rs?=
x-ms-exchange-antispam-messagedata-1: 3l8Ud6AnDkYmUKgE34ZguGtpYi7q3ZC2ZcU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <417AC5938A4B9147A4B808DE4775CB9A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SK6n4UkG5avAMmGrfU5sszBS7jQd22OYNHChYFRH5C75vdsageZtyBGK7Ogi/v+M5BneK2OJUgG+1OC+ivDMEdLiww7yXwll2unNqIzph7wk4ASiYcl3ub/fxLzwXhz038G5nsWcgNM3mizha03t6ax6KKqjP4WQ7dA74XkWNwKbFtHZSq01LQjofuGu03+y02R2Yiz5Dc3wlXChWm4bUqWG8lhQW5Yprh9LefvYDnXxvalGsCWTZr0tFte63dmeO3RzqQJcwcotWw2G9hd6NWrrr6gv+NqGGx5Fr/qU3910P3GGF/LRVwdnLbU7qnxUL+d3rn4LaQoSjQT55p4uybcL137YzKxOx0fcVVBTc8E0iLmdIoqnMmvv9CVYxqiEF/i4We4KXK/78J+mXyg7gXRpidCYMTLBNItOLDsQ7kVsmJYfFFPSPeuuOKoNGaPEUh85BGchHy5p/8MEk1Sk488/FD5Nr0oqyCYBHFBpoOXSqZdG5Wu4gGP8cbV7KxUoolH0Mu5UPu0N1dKdSfUOsPkgBkAbmpWok/AnzKcNR+3L1Pi7O6i5JuvifZtK2oALYE4Bpj4IQrWOGPiWN0VwbcpR3czWHJH5P1hgdaobjsGYelYWBJEhEE1odM0r8JLW
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7235d061-ac04-445d-9f99-08de5cafb295
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2026 07:51:21.7917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NC2Bps88Vh8kZZ6+6zD1abr8oJwJ9UtYCLoloIVAfFXrbhenRhe5yvXVmr9ZZQXLqiGovIIhibG/tpXCY/+A9MuLFzNABjI/LDzh3hol5IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9237
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21052-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-btrfs@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: DD9E9850E6
X-Rspamd-Action: no action

T24gMS8yNS8yNiAyOjIxIFBNLCBDaHJpcyBNYXNvbiB3cm90ZToNCj4gSm9oYW5uZXMgVGh1bXNo
aXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4gd3JvdGU6DQo+PiBJbiBjYXNlIG9mIGEg
em9uZWQgUkFJRCwgaXQgY2FuIGhhcHBlbiB0aGF0IGEgZGF0YSB3cml0ZSBpcyB0YXJnZXRpbmcg
YQ0KPj4gc2VxdWVudGlhbCB3cml0ZSByZXF1aXJlZCB6b25lIGFuZCBhIGNvbnZlbnRpb25hbCB6
b25lLiBJbiB0aGlzIGNhc2UgdGhlDQo+PiBiaW8gd2lsbCBiZSBtYXJrZWQgYXMgUkVRX09QX1pP
TkVfQVBQRU5EIGJ1dCBmb3IgdGhlIGNvbnZlbnRpb25hbCB6b25lLA0KPj4gdGhpcyBuZWVkcyB0
byBiZSBSRVFfT1BfV1JJVEUuDQo+Pg0KPj4gVGhlIHNldHRpbmcgb2YgUkVRX09QX1pPTkVfQVBQ
RU5EIGlzIGRlZmVycmVkIHRvIHRoZSBsYXN0IHBvc3NpYmxlIHRpbWUgaW4NCj4+IGJ0cmZzX3N1
Ym1pdF9kZXZfYmlvKCksIGJ1dCB0aGUgZGVjaXNpb24gaWYgd2UgY2FuIHVzZSB6b25lIGFwcGVu
ZCBpcw0KPj4gY2FjaGVkIGluIGJ0cmZzX2Jpby4NCj4gSGkgZXZlcnlvbmUsDQo+DQo+IEkgcmFu
IGxpbnV4LW5leHQgdGhyb3VnaCBzb21lIEFJIHBhdGNoIHJldmlldywgYW5kIHRoaXMgb25lIHdh
cyBmbGFnZ2VkLg0KPg0KPiBBcG9sb2dpZXMgaW4gYWR2YW5jZSBpZiB0aGlzIGlzIHdvbmt5LCB0
aGUgdGV4dCBiZWxvdyBpcyBiYXNlZCBvbiB0aGUNCj4gbGludXgtbmV4dCB2ZXJzaW9uIG9mIHRo
ZSBjb21taXQgYW5kIHRoZSBtYWlsaW5nIGxpc3QgaGFzIHNvbWV0aGluZyBzbGlnaHRseQ0KPiBk
aWZmZXJlbnQuICBCdXQgSSB0aGluayB0aGUgb3ZlcmFsbCByZXN1bHQgaXMgc3RpbGwgdmFsaWQs
IGl0IGRvZXNuJ3QgbG9vaw0KPiBsaWtlIGJ0cmZzX3NwbGl0X2JpbygpIHByb3Blcmx5IGNvcGll
cyBjYW5fYXBwZW5kPw0KPg0KPiBJdCBzdGlsbCBzZWVtcyB2YWxpZCBhZnRlciB0aGUgZW51bSBi
aXQgdHJhbnNpdGlvbiBsYXRlciBpbiB0aGlzIHRocmVhZC4NCj4NCj4+IGRpZmYgLS1naXQgYS9m
cy9idHJmcy9iaW8uYyBiL2ZzL2J0cmZzL2Jpby5jDQo+PiAtLS0gYS9mcy9idHJmcy9iaW8uYw0K
Pj4gKysrIGIvZnMvYnRyZnMvYmlvLmMNCj4gWyAuLi4gXQ0KPg0KPj4gQEAgLTc0Nyw3ICs3NTAs
NiBAQCBzdGF0aWMgYm9vbCBidHJmc19zdWJtaXRfY2h1bmsoc3RydWN0IGJ0cmZzX2JpbyAqYmJp
bywgaW50IG1pcnJvcl9udW0pDQo+PiAgIAl1NjQgbG9naWNhbCA9IGJpby0+YmlfaXRlci5iaV9z
ZWN0b3IgPDwgU0VDVE9SX1NISUZUOw0KPj4gICAJdTY0IGxlbmd0aCA9IGJpby0+YmlfaXRlci5i
aV9zaXplOw0KPj4gICAJdTY0IG1hcF9sZW5ndGggPSBsZW5ndGg7DQo+PiAtCWJvb2wgdXNlX2Fw
cGVuZCA9IGJ0cmZzX3VzZV96b25lX2FwcGVuZChiYmlvKTsNCj4+ICAgCXN0cnVjdCBidHJmc19p
b19jb250ZXh0ICpiaW9jID0gTlVMTDsNCj4+ICAgCXN0cnVjdCBidHJmc19pb19zdHJpcGUgc21h
cDsNCj4+ICAgCWJsa19zdGF0dXNfdCBzdGF0dXM7DQo+PiBAQCAtNzc1LDggKzc3NywxMCBAQCBz
dGF0aWMgYm9vbCBidHJmc19zdWJtaXRfY2h1bmsoc3RydWN0IGJ0cmZzX2JpbyAqYmJpbywgaW50
IG1pcnJvcl9udW0pDQo+PiAgIAlpZiAoYmlvX29wKGJpbykgPT0gUkVRX09QX1dSSVRFICYmIGlz
X2RhdGFfYmJpbyhiYmlvKSkNCj4+ICAgCQliYmlvLT5vcmlnX2xvZ2ljYWwgPSBsb2dpY2FsOw0K
Pj4NCj4+ICsJYmJpby0+Y2FuX3VzZV9hcHBlbmQgPSBidHJmc191c2Vfem9uZV9hcHBlbmQoYmJp
byk7DQo+PiArDQo+PiAgIAltYXBfbGVuZ3RoID0gbWluKG1hcF9sZW5ndGgsIGxlbmd0aCk7DQo+
PiAtCWlmICh1c2VfYXBwZW5kKQ0KPj4gKwlpZiAoYmJpby0+Y2FuX3VzZV9hcHBlbmQpDQo+PiAg
IAkJbWFwX2xlbmd0aCA9IGJ0cmZzX2FwcGVuZF9tYXBfbGVuZ3RoKGJiaW8sIG1hcF9sZW5ndGgp
Ow0KPj4NCj4+ICAgCWlmIChtYXBfbGVuZ3RoIDwgbGVuZ3RoKSB7DQo+PiAgIAkJc3RydWN0IGJ0
cmZzX2JpbyAqc3BsaXQ7DQo+Pg0KPj4gICAJCXNwbGl0ID0gYnRyZnNfc3BsaXRfYmlvKGZzX2lu
Zm8sIGJiaW8sIG1hcF9sZW5ndGgpOw0KPiBXaGVuIGEgYmlvIGlzIHNwbGl0IGhlcmUsIGJ0cmZz
X3NwbGl0X2JpbygpIGNyZWF0ZXMgdGhlIG5ldyBzcGxpdCBiaW8gdmlhDQo+IGJ0cmZzX2Jpb19p
bml0KCkgd2hpY2ggemVyb2VzIHRoZSBzdHJ1Y3Qgd2l0aCBtZW1zZXQuIExvb2tpbmcgYXQNCj4g
YnRyZnNfc3BsaXRfYmlvKCksIGl0IGNvcGllcyBjc3VtX3NlYXJjaF9jb21taXRfcm9vdCBmcm9t
IHRoZSBvcmlnaW5hbCBidXQNCj4gZG9lcyBub3QgY29weSBjYW5fdXNlX2FwcGVuZC4NCj4NCj4g
QWZ0ZXIgdGhlIHNwbGl0LCB0aGUgY29kZSBkb2VzOg0KPg0KPiAgICAgIGJiaW8gPSBzcGxpdDsN
Cj4gICAgICBiaW8gPSAmYmJpby0+YmlvOw0KPg0KPiBUaGlzIG1lYW5zIHRoZSBzcGxpdCBiaW8g
KHdpdGggY2FuX3VzZV9hcHBlbmQgPSBmYWxzZSkgZ2V0cyBzdWJtaXR0ZWQsIG5vdA0KPiB0aGUg
b3JpZ2luYWwuIEluIGJ0cmZzX3N1Ym1pdF9kZXZfYmlvKCksIHRoZSBjb25kaXRpb246DQo+DQo+
ICAgICAgaWYgKGJ0cmZzX2JpbyhiaW8pLT5jYW5fdXNlX2FwcGVuZCAmJiBidHJmc19kZXZfaXNf
c2VxdWVudGlhbCguLi4pKQ0KPg0KPiBXaWxsIGJlIGZhbHNlIGZvciB0aGUgc3BsaXQgYmlvIGV2
ZW4gd2hlbiB3cml0aW5nIHRvIGEgc2VxdWVudGlhbCB6b25lLg0KPiBEb2VzIHRoZSBzcGxpdCBi
aW8gbmVlZCB0byBpbmhlcml0IGNhbl91c2VfYXBwZW5kIGZyb20gdGhlIG9yaWdpbmFsPyBUaGUN
Cj4gb2xkIGNvZGUgdXNlZCBhIGxvY2FsIHZhcmlhYmxlIHVzZV9hcHBlbmQgd2hpY2ggcGVyc2lz
dGVkIGFjcm9zcyB0aGUgc3BsaXQuDQoNCg0KSGkgQ2hyaXMsDQoNClRoaXMgaW5kZWVkIHNlZW1z
IGNvcnJlY3QuIEFsc28gZm9yIGFsbCB0aGUgb3RoZXIgImZsYWdzIiAoaXNfc2NydWIsIA0KaXNf
cmVtYXAsIGFzeW5jX2NzdW0pIGJ1dCBjc3VtX3NlYXJjaF9jb21taXRfcm9vdCwgaXNuJ3QgaXQ/
DQoNClNvIHRoZSBjb3JyZWN0IGZpeCB3b3VsZCB0aGVuIGJlOg0KDQpkaWZmIC0tZ2l0IGEvZnMv
YnRyZnMvYmlvLmMgYi9mcy9idHJmcy9iaW8uYw0KaW5kZXggZDM0NzVkMTc5MzYyLi4wYTY5ZTA5
YmZlMjggMTAwNjQ0DQotLS0gYS9mcy9idHJmcy9iaW8uYw0KKysrIGIvZnMvYnRyZnMvYmlvLmMN
CkBAIC05Nyw3ICs5NywxMyBAQCBzdGF0aWMgc3RydWN0IGJ0cmZzX2JpbyAqYnRyZnNfc3BsaXRf
YmlvKHN0cnVjdCANCmJ0cmZzX2ZzX2luZm8gKmZzX2luZm8sDQogwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgYmJpby0+b3JpZ19sb2dpY2FsID0gb3JpZ19iYmlvLT5vcmlnX2xvZ2ljYWw7DQogwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgb3JpZ19iYmlvLT5vcmlnX2xvZ2ljYWwgKz0gbWFwX2xlbmd0
aDsNCiDCoCDCoCDCoCDCoCB9DQorDQogwqAgwqAgwqAgwqAgYmJpby0+Y3N1bV9zZWFyY2hfY29t
bWl0X3Jvb3QgPSBvcmlnX2JiaW8tPmNzdW1fc2VhcmNoX2NvbW1pdF9yb290Ow0KK8KgIMKgIMKg
IMKgYmJpby0+Y2FuX3VzZV9hcHBlbmQgPSBvcmlnX2JiaW8tPmNhbl91c2VfYXBwZW5kOw0KK8Kg
IMKgIMKgIMKgYmJpby0+aXNfc2NydWIgPSBvcmlnX2JiaW8tPmlzX3NjcnViOw0KK8KgIMKgIMKg
IMKgYmJpby0+aXNfcmVtYXAgPSBvcmlnX2JiaW8tPmlzX3JlbWFwOw0KK8KgIMKgIMKgIMKgYmJp
by0+YXN5bmNfY3N1bSA9IG9yaWdfYmJpby0+YXN5bmNfY3N1bTsNCisNCiDCoCDCoCDCoCDCoCBh
dG9taWNfaW5jKCZvcmlnX2JiaW8tPnBlbmRpbmdfaW9zKTsNCiDCoCDCoCDCoCDCoCByZXR1cm4g
YmJpbzsNCiDCoH0NCg0K

