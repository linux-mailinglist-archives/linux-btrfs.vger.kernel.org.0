Return-Path: <linux-btrfs+bounces-19694-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEECACB8183
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 08:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11882300BB99
	for <lists+linux-btrfs@lfdr.de>; Fri, 12 Dec 2025 07:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B7D2F1FE4;
	Fri, 12 Dec 2025 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="apm0+ww1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jbGG517d"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CCC1DEFF5
	for <linux-btrfs@vger.kernel.org>; Fri, 12 Dec 2025 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765523814; cv=fail; b=FywmRjaeXqOxn5xFAtSBpL9zgHgVaywgNq4awnQ2z1JbKDu8VKjVo3fx8lDhQHAexL0RVgSvqIf+NdKKPAEzOHYhNQP+8teOkmKSs8hntBFyZwgr+zvUQWC8jIWZVqsrP5F5RpdVT14ORXioXraUYeEvUELSgpKT/TD7RKqBcPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765523814; c=relaxed/simple;
	bh=FbNUsoPUs4AzVe4qgiraiLM0UdzHJkTHOD94AHSlwHQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ARYRZnB8cCHw4gPny3ibbZhwvu0Jhxx16mugTrC+2nILIo74FOTij7Geu4VPYEQ+Mj8vouTCEdDxPAan+yUrK0AlHulOQa9e/OmBfNDb+5nH5TEQ8iVlSeP4uOA/susdhn66lYhFyM3qotDbOxkQq+8uuLhloeiQLb3qdFd7km8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=apm0+ww1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jbGG517d; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1765523812; x=1797059812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FbNUsoPUs4AzVe4qgiraiLM0UdzHJkTHOD94AHSlwHQ=;
  b=apm0+ww1v+z6Dc0WxcphuB6zNA5LG+JwRTPKHOE5AQtXgmQeAMUt60oB
   8PN/Ukc2AWRJ36x/8WqhyK1oYY/a8Q3EMjo+rIU/6qIRMeZaUuoiOrZGU
   cV0XXr/sbFUXmZFuSlM8sjU8Yj59f19aYzl/C0YrftUVku0Ea2WHcj0Ek
   1Uf7rUJytoIiJaNP+1xo3ZFSxzc3meN65swzX0mmsbsMNKbQZzfkrTg0w
   wwBNgAjYOYZfeL9PySBGaWOf1CSKwXfV+82ypWlMoSXGlGHD4xU4HBqC4
   Xnrb8N7f0h7yoShfefKWtdOaw8TLFQNXXWIK6/l/I+X+ZICnoONqukym8
   A==;
X-CSE-ConnectionGUID: wioCUalaQyKoAGtAEiYyCQ==
X-CSE-MsgGUID: MVer9m6QTSuOWAmVULxynw==
X-IronPort-AV: E=Sophos;i="6.21,143,1763395200"; 
   d="scan'208";a="136927533"
Received: from mail-southcentralusazon11013020.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.20])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Dec 2025 15:16:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1KvTRjI+5wCfxuXTHPp79PtJX+pivX8X0laftaXl47fQ8xARv2/L15i5pu4hQ7ZPZrZhTTANkXACPIBVtFzi+AfXKefkiixrXojblU3AOS7V4o5p8HF7AMGs/PvICWBdgUNwAD/HEXC1hP85mlcTxl6sIKyaNsEP2SfjdZo2OetMaChu3d0BVMyEXUEVcVIzKgt0XtMMHtSLAsOIjytIwVkgo2fwY4HTVgxt/BcabkVucucRtIxiJ81SHHOxenzT/F2i3kDGVkWMBW86i05Ih9F0YxaZ4B80XMANOfqIgUQtq6AId2Z/wqoDxdLowjxahPaJacOMw9FAPktuLd4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FbNUsoPUs4AzVe4qgiraiLM0UdzHJkTHOD94AHSlwHQ=;
 b=r9fm0tOnj3QhJ3rRfIF62BjdE5+BVLeBdOWzeLNtbKEOw+2AjkKbqHJaaibeSlkc9GRg2D8us7wPt0mpH0D7gj3pbXWqtExbfH+Um8YGXqFkAOL5uemgeSfAOhp+VgNNK46mwpyVxfEDd/N6uM7PZFPOz8RaJmszZxed7k+4g2AaXsLn1l1A8RBrHU2fprP//6zQ4YdZG5zZ4KEUwiub8xrf/r5dG/gvUvHW1bSnKAUGx8PIo9WrXg0MSYfXyrMRZUbtsd6kI2AcaQBN8U5RnigGlrMjuzpPDNmuTD92wyRStw2EP41OTybAi9M31+glSptEaVHw2brp0V6VwjYCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FbNUsoPUs4AzVe4qgiraiLM0UdzHJkTHOD94AHSlwHQ=;
 b=jbGG517dn0eG74xAl7bZnTtoEzVuu9LDHH//xUEnPncWOivwTBxjrx/YQuo/5atwNlYtccnAW1ZJFxtbKA2rezTL5CtZIGHhBUPYsn5xqFBurXQ0VoX8UDZct+Uk8yGJsCKdmDYwdRjPqI0howCHhWj+FGggmUE11V8eOLvLCuU=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM8PR04MB7813.namprd04.prod.outlook.com (2603:10b6:8:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 07:16:50 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9412.005; Fri, 12 Dec 2025
 07:16:50 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: rename btrfs_create_block_group_cache to
 btrfs_create_block_group
Thread-Topic: [PATCH] btrfs: rename btrfs_create_block_group_cache to
 btrfs_create_block_group
Thread-Index: AQHcaZdj1vjoyVSOGkmvB/u2OKviC7UcxYCAgADV4YA=
Date: Fri, 12 Dec 2025 07:16:49 +0000
Message-ID: <2e1c4e72-9c89-40c2-af0b-614fcc1155e3@wdc.com>
References: <20251210053932.149358-1-johannes.thumshirn@wdc.com>
 <20251211183119.GL4859@twin.jikos.cz>
In-Reply-To: <20251211183119.GL4859@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM8PR04MB7813:EE_
x-ms-office365-filtering-correlation-id: 8c2a223e-8903-4721-bd75-08de394e6b2a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ajRyM0Y5b0FJQzl1ZDN4SmZQMXNGcFdlZGNjR2c1TWorNDFyVUk2MWZwNDFp?=
 =?utf-8?B?bWJscm9SaGhxQ1hYZUpuQldZQmpNazYyVzZrNXYvL09qelh4bUtnRWRGK2xh?=
 =?utf-8?B?U3JUNXROaGFvbjJjeEhDQm1QZGVReFRFa3dUWUxYaUhqU242QnVuNTZsM2ph?=
 =?utf-8?B?VzYwdXRUamJaa25XMHNtdUZwS1VlTTg1NXpjempuY1lYNmdiL0N3WXRneURP?=
 =?utf-8?B?SDBJTHdGbENuTEZSRzJwa2tzVFlINDNESmFuVC9wd2tqankzb1FJaHZUZzNY?=
 =?utf-8?B?QlpUUFlHVkE3U3k4TzZRM0gwOVR0cnJOaVdSeVM2SmtSbm16SVBPU3BZNzZB?=
 =?utf-8?B?MDZkTTVUamk4dHcybVlOYm05a2NuSzRGYkNGeTNIb053ZUVYK2FKcjFiVG9h?=
 =?utf-8?B?czg1WE52alJrTTlLNVZjNUt5ZGtRRkl5WDZ3Q2ZjM2hBSzhvVVppclQ2eGpX?=
 =?utf-8?B?MEovalZiOG84WFREUy9Sc01aZFpnZVFGNnZ3OWMrNjVNYXgxQmZQd0FUbVBl?=
 =?utf-8?B?aUd3QzlFMzRXUzk0RFUwdUpSWFpyanVVVVdPM0hCZDBzNkl1SmZLS1U3YVJ4?=
 =?utf-8?B?ZFR3RmZvQ0o5YnlBSDM0aVNaOTNHd0xRYnBnUW5pZDd5Ukx5Qno4dXVtVkhD?=
 =?utf-8?B?VEdFWTNUZzdYUTg3M1ErdTA5b2pycXdaN2FwRUxGQ0Zsa1RMbmZoTHE1K29w?=
 =?utf-8?B?czZlVlVkNEM1a0o1TGt6eVlVdW9WRjlocy9ScWh6ZWo5bWQvS0dPeFVYaVk3?=
 =?utf-8?B?SC94SzlLOEZYQzdQZFVHR2h6d1NyaHB3cTcwRGVvMGcrQmZpdE9NaitSKzF3?=
 =?utf-8?B?UHBQS3NaTlR1dDJxZ1dsdzE1SVYvb3FaRjZtTHRtazJZZmJrR2NsMHo4NGN5?=
 =?utf-8?B?aEFPaGpaQzZkQ1dXNUVFYmp1TXExdzdoZzVzSVVjMWZPTk8xbDlpS21WV1ZO?=
 =?utf-8?B?cUVseUdBbmc0d3ZPS0hOMy9sTEtKVHEzRHdYTGZ1eGF5Q2pPeFM4ak05Y1ZZ?=
 =?utf-8?B?YzdSZ2FTSGE3U25iK2dpNGZFODlSY1lJV3B0ZTdhSGdQVFc1UzlxVnk0Y1pU?=
 =?utf-8?B?SllzTGM0YUxrSGl2bHR1OGxEcFFYVG5URzliR2RIODVtSDgzdnl2RnRBRUR5?=
 =?utf-8?B?SkYyL1Y2Si9OMlRqcyttaE84TWVMbkwyL0xqVVlTOE5yTHk2WmJQUGxQZ1dr?=
 =?utf-8?B?UUNJOHRMekJUVEY4aXJQVHFRR1NFQ1cybjhYWWpkMFo1TmtDY0p5cTRuaEtP?=
 =?utf-8?B?T3VaZmdpMlVwbzVCS2lEVW9Ra3BhQkplU2w5aW8yOGM2azVicEVYM0hpYkRO?=
 =?utf-8?B?cjAwZGVUMEZoNXptM0MzTVVEYkliTTBOMEJCaGFkRVNFeThRL3BHRGZYN21q?=
 =?utf-8?B?ZDhQbzgvbkRicDllVEtSNXIrbks2OCtmOTcvUS9yU1JaMWtKT3IwZnlMc2xQ?=
 =?utf-8?B?YmI5alNkUW5zSmlLSk9CWDIxckk2ekpkU0VlYXl5VTFZNTBsV2Jsa2pPbCtB?=
 =?utf-8?B?N2VKZ01xWHo5Rlh2NzJaTU91TUxqMDVKVzZ6aENLRDI5YTlBak1RK1UrTzJM?=
 =?utf-8?B?Z3BVY3FDdEx4c0NHeGoxSE1XRzNDRUdLaHpHb1YrMVFWanBYNUdDZCtBQkZK?=
 =?utf-8?B?SDhseU81T29SQWwyNTNjUjQ5bER2RVJBcytSTXBiRnljU0ovMEtGRzhVYnBD?=
 =?utf-8?B?enBoVGZwdm0vZU1uS3FQOXNMeEpzK01Ld3pkQjJIbVlJT3lPN0ZKZEhyZDQx?=
 =?utf-8?B?eVhYWFlXMyt3aFJ1N0NIVExMb2M0VjFSTGNja0FEOHduYm56bUFBeWoyVWJW?=
 =?utf-8?B?cWdjR0hGWWd4UDN4UFZSTnpuQW5DNU9ncHVzRnVNai9Sb2dMbFRmd3dlRzVL?=
 =?utf-8?B?d0t2RlJOUkkvdnRHenY0Z1dmVU5uUk1RUTc3YzV3SWtDTzM4UlhxckxkVG9I?=
 =?utf-8?B?eW0wMGEwVlA5VkpMUU51OCtLN1pVS3hlbEdKcXRlZmVTUy9OWEVIMUlWd0Js?=
 =?utf-8?B?Umw0eFR6Y0VIb2pycUdPUTFobFdmVHNYTU85Y2xTL1NBcEROb1lud0IvWWN1?=
 =?utf-8?Q?Tgrwi2?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bi9SbnRWWnZlZ0lLN0hwRTFZUnBrWU5XM1ZRNjUzendpNkh5QzNYTGFyQitk?=
 =?utf-8?B?US9McDlRa2ZyVW5mM0VMNTduNTJBUzYyTVdPcFViOEU2c2hFRzFxY094Vksy?=
 =?utf-8?B?dHcySGo4K05BVUxvcGY5MnRPVGJLRFpWMThLTXJRbXpOYTYzS2U1bUFVdzZj?=
 =?utf-8?B?TTlocnhtMmhOVko0Ti9ORkhleFFSenVjSzFlYy9CTmU2djNhOWQrMnIyU3RY?=
 =?utf-8?B?dFlZNEdJN28rWEFwTnRpZmhNTll5UFdOTkxyUnV2UUxwYlJTT3E5MTVJOFlQ?=
 =?utf-8?B?UHEzK0FBbGFqc0FOdGxJQ0JTdGNHbTgvUkYrSTI4VEdiWGwvc3Q2ODVlSEJW?=
 =?utf-8?B?MVFTQ3J2SnFreDc0eEN6NmsyV1lVRjZwcWlnVzg3WnBOcGU2dnh6RSt4NU93?=
 =?utf-8?B?aFJEQmdGQ3BZOCs3aSsreFlpMnhKeVRUemk2aXBWVWY4Wk9VOFIxREYybm9x?=
 =?utf-8?B?ZFRjRWgyUCtWKzRzS3RETkNaMDZlUFB5d2VleWR4U1RsZVdDZmZHOXdnVkZK?=
 =?utf-8?B?c2txWWV4REtFcWlIQVB3ck5JWkw4dlozS0tuZmJHeHdJeXA1RGpjbmtHSXM1?=
 =?utf-8?B?ZmYvaEhwNTBnMFprbCtCak9vcWlDZCs1Wm9XaThSSFRYTHh2TkhudzRkN2t6?=
 =?utf-8?B?bGZZTjYvNlNDNFRKZkNzMXh0UnJtSkpaYXA3Z0ZzcHZxbE5nV25lWlNRUWNx?=
 =?utf-8?B?MHJhZVJueVNTdVQ5YTVkRks1RDg5aFpxYXhpKysxb2JGK1Q1ampoS2tXVi9x?=
 =?utf-8?B?b3FWcTc5U1RSUGpTNlN0OG5kcmFkVmxxc2d1SkJJelpkekxkNjhFNmVIRi91?=
 =?utf-8?B?dmtNZC93blQxSkthUzF5SDhGd2d4akhieklBeTl6cWNBaW1FTitqZUY3N3lw?=
 =?utf-8?B?WmdZTVN2bUFrVEdwM1J4eUpTcTVxSkhud21QL0RuNmY0TXROdXFwRjh5RG9j?=
 =?utf-8?B?SThlUSswNEpnVFdOQWFQeWVUbktlN1RvNlFIS00vUWQvQjBNL3J6VGlmSWJK?=
 =?utf-8?B?ZmMzcTBQVmlEVGg0MWdwYmp5YXQ3WmtHWi95VVhKTXE5dWZIa1RyNGxyYkcy?=
 =?utf-8?B?YUtVYkd3dDlOcVZWZnFuc1FNMDZUYUFSNW4wT0prZ05xeWlNZzcwVDFGb2NH?=
 =?utf-8?B?bXFiTk5VajBlTkpVOVJNTkFtbHFDd0M4a29ob0RUYUNmalh1ZDVXNGVWb3kr?=
 =?utf-8?B?Q0tMZFRNSndYZE1YV3FBdHlGRFZDRll0dTg1R2U0N0l3T0dNQTRqSFhkN0lr?=
 =?utf-8?B?TlB1RzBjWDBBdHFTRXZUb3IyYVUvS01tNXNDaUtsaFJTMUpaRjZXOVY4WWRz?=
 =?utf-8?B?cFBweWtxUU5VdzdzK3NUcThrRENWU1FHUGRnamdZUXo2M1RwMDkyVkp6ZzM0?=
 =?utf-8?B?OFltQURrWFZMZGVoMUVBNnFQcDRZRDdheVVEYUlaVG5uZk5kZldjZ05jdWFL?=
 =?utf-8?B?elJXTU5zVkwxd1hwblcrSWxPODlKclJwcDJXR3FWSVN2QktCM2pUU3V3YUx2?=
 =?utf-8?B?TU1NeFFQNnlsT3NQZkJlVUx1Uld6ZCttUFdIbDVqWjZydnRRN3FBSTRvdllI?=
 =?utf-8?B?VkxLZWtyYXhsL241OHBhSzZ3RjFJRkdRemxQUUpsaDVvS080amVHOWF6NXlr?=
 =?utf-8?B?RDYwd0dLKzU5ZHZHcUZrRHdJOUJoWlZVa3VVbmxBck4wZWhQbVhVQ1hrNFpP?=
 =?utf-8?B?aERWdHNoWEhaRFY5R3BpenMyVzNWMVVWZlppbUEweHpMQndsVHZpM090YXN6?=
 =?utf-8?B?eXRzRjVhK0FlcWhDWHVUUXpaOXUzZjNWOGRVZmZnY1VqeC8rY0RMVjFoN1g5?=
 =?utf-8?B?K0Uxb0FjM1NxWWlUbHY0c00zNHhRemNndGVrczhFTlh0N09pR0lERG0xRnpZ?=
 =?utf-8?B?RU5zcHd6QkFiM0w3cmZ1Q21qdzFQdUU4UWVxaDhiRFhoSytUUzhWNExFdjND?=
 =?utf-8?B?YjQwdFJWdU9lUWNJYmZYb0I2Y09DODJsdXVRUW0wN3doUHp2N0pjbzBkT2pm?=
 =?utf-8?B?dlJuMnpBZUhvQVZXay9RdjYzN1ZTdS9GN09ld2x2djhrYitIbEQwNy95Smd4?=
 =?utf-8?B?eGoyYXpGUjdtcmJYdy8rOXp6ZCsxSVRra0dDRDhjVDNCamFjdnA4WktpM2Fn?=
 =?utf-8?B?SVdQQ0hJckxTVFFZWTgwYVNaWjN3T004NjB1Nm9IQXc0SGVvQTU5ZUJJdUZN?=
 =?utf-8?Q?OULkbsq0iU2i1Gvv991+7/M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1108C7EB2A218F4D903FC678BC4EAD61@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9jomQD/TSyZ+zZkRwl3B2SWD/sXWf5cKKttS0DQdm0WgcKjFbl4h+lRz1ioDhp83Ei8OTQO5+lzDS4NMza1hGM7oJNYGizv0z4R2WW4b8zok5Xq5k9xZyCzxctdx461qYAKXR+rHxCynUnpEwstLG7vsBo9fuXtBw0gKHvdATi0p6eWvbw4hK4JH/13dfT40nYG8kPyfi13kiw4w1B8KeJVVs2FKm/852TrQTU0mRon6AHr8uOp+JUE0vp8wC7hymF0oa0JqiPiFXg7ibNYU2mJ4olQ9JQRLyUQcxd4eMi3zAXwsxQoCskoZKKPCKQkkS0Lf8oMWoBXOAcEpJrej5Jjou0SeCPgy6CsLmaNx0i7FOXb/Yaz2pZBxHP7nx6yk/d2UXlrNs793NMGJGz5mK49x19UAWgcIwogp38c6K4IgXk/mj6XJrbhjw27mzTR0RwkfTwpmrMMXAInN6MR5/fzEY00H4Cxiw0TX9J3VRkYTMql9J5TmHGtcUSw33/D1p+p7fTErvTfif5wdUduoKrvTiP8pbE05JWnGTk5vxJK/5z3YeZ83SoVQ8bJzI3TfUusTiqKume/m7M77/9XCBQf5VrCTOH381GNL4RTv43hC0eIOotRI1x9Ldui0Pt+p
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2a223e-8903-4721-bd75-08de394e6b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 07:16:50.0773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65ReAoLL1WJR0XZ0HKPHf+yXMGT2XJ/wCJxXfJSC2kgAiqDTDu4BsOPYZ8pS+zUKDDf0Fy9ra/q2MHTDU04wrPN7Ne5lPM10bBcCdoRbCws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7813

T24gMTIvMTEvMjUgNzozMSBQTSwgRGF2aWQgU3RlcmJhIHdyb3RlOg0KPiBPbiBXZWQsIERlYyAx
MCwgMjAyNSBhdCAwNjozOTozMkFNICswMTAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+
PiAnc3RydWN0IGJ0cmZzX2Jsb2NrX2dyb3VwJyB1c2VkIHRvIGJlIGNhbGxlZCAnc3RydWN0DQo+
PiBidHJmc19ibG9ja19ncm91cF9jYWNoZScgYnV0IGdvdCByZW5hbWVkIHRvIGJ0cmZzX2Jsb2Nr
X2dyb3VwIHdpdGgNCj4+IGNvbW1pdCAzMmRhNTM4NmQ5YTQgKCJidHJmczogcmVuYW1lIGJ0cmZz
X2Jsb2NrX2dyb3VwX2NhY2hlIikuDQo+Pg0KPj4gUmVuYW1lIGJ0cmZzX2NyZWF0ZV9ibG9ja19n
cm91cF9jYWNoZSgpIHRvIGJ0cmZzX2NyZWF0ZV9ibG9ja19ncm91cCgpIHRvDQo+PiByZWZsZWN0
IHRoYXQgY2hhbmdlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8
am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo+IFJldmlld2VkLWJ5OiBEYXZpZCBTdGVyYmEg
PGRzdGVyYmFAc3VzZS5jb20+DQo+DQo+IFRoaXMgc2VlbXMgdG8gYmUgdGhlIG9ubHkgb25lIGxh
c3QgbGVmdCwgZXZlcnl3aGVyZSBlbHNlIHRoZSAnY2FjaGUnIGlzDQo+IHVzZWQgaW4gdGhlIGlk
ZW50aXJpZXIgaXQncyByZWxhdGVkIHRvIHRoZSBiZyBjYWNoZS4NCg0KWWVzIEkndmUgY2hlY2tl
ZCB0aGF0IHdoZW4gc2VuZGluZyBpdC4gVGhpcyBvZiBjYXVzZSBpcyB1bmxlc3MgSSB0b28gDQpt
aXNzZWQgb25lLg0KDQo=

