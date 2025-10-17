Return-Path: <linux-btrfs+bounces-17911-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F63BBE5FC9
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 02:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 266564F969F
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Oct 2025 00:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0491D214801;
	Fri, 17 Oct 2025 00:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qT8vBnjc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dTjAgsPR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA71E9915;
	Fri, 17 Oct 2025 00:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760661887; cv=fail; b=UDEBGIbJ+NINlkgW4qz7sg2tcXPdEKEl6HogSfMc9UrDKkekVNB28jIxw7vOPKP4Bh9JfOKhzG02Gsgsr+N1EmebeMDVcTPtxhO3BKOs4h4/AI99/KFXajv5bIQ0I+rZ016xiG5eJTxDtOWf6CRLgxANO3YB8knTjzDM83u0Ytg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760661887; c=relaxed/simple;
	bh=IAUu/FPhb4PlhJ0sGrrqjoxkhtl6p1gXjtDxAodgDL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sdo0JbPKmGwe0E6sM9PzTQFQIZtczSckgvFNWrjNJd7LXmmHqLAX0jQWbx6N2tfnGEgBQttHRMa/67LlvPG0Qr7wbYqF84eaRv9BTOkacn5K2hJPwnRACqQOnFvDCy5zaRFvBf65ZTjA5SSB+vidQkia9sY9A/v1s8Kaio7D2QI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qT8vBnjc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dTjAgsPR; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760661886; x=1792197886;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IAUu/FPhb4PlhJ0sGrrqjoxkhtl6p1gXjtDxAodgDL8=;
  b=qT8vBnjcLpTycyZp2n8LMTNYMYnh/HC3lLJR1yTXnHTckxNONc4Jy52w
   z0BjuM7McGN+XieuJIsAWYjqZcXgz9+5fQ35mmBgBNpnk32gJW4QeIHZk
   aYNPoCK7LMftdaEwghJRS/JoBpUJNTHalQkOk1rwCokOs+D01bP4V5l9R
   Y4/1htNS3ag+vUuMjXMhkHDZ84Ac51PV/FH6FwO8Ha2PQJ1MgYKCkMko6
   fwQ87FpdELx2wPg85tFeSDd8QUf04CQN5FPP2DohtEhGVDYdox7MzDhEf
   YwJvO8S66hVTak+SeEYKbWkKYR508oX6oLdpD2iX4mrMVYI8lTaZN8C+0
   g==;
X-CSE-ConnectionGUID: axlCseJwQtOxnSDjrW35lg==
X-CSE-MsgGUID: fJPhIjhAQX2YYDLl1Ag58w==
X-IronPort-AV: E=Sophos;i="6.19,234,1754928000"; 
   d="scan'208";a="134323278"
Received: from mail-westusazon11012020.outbound.protection.outlook.com (HELO SJ2PR03CU001.outbound.protection.outlook.com) ([52.101.43.20])
  by ob1.hgst.iphmx.com with ESMTP; 17 Oct 2025 08:44:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgyUnCOOT6Rg28qavPxgzvTKfuK1ufoNq4nr+VdCG5LSk8quMzsaudlfru4vWYCW1WXofSVlW6odFggHad5O0A5dK/OjNDtp22+7lcjN6DWAppY2wKdzfNtD/HMIbAB6VfGvGIvJA6OwotsOwTat8elfAOEMhMEWvphIYyMjonSj0cpPdGlabA6X6fuS7LgyFYfqyApVcg5N0WFnMtmNdZ1QR2o3tLMZcgwiJvvF7KDgJYVhNbTylJTdOkaLziFPmOX3NnCryQAgd2GhdwKYJ2Z3CHuqiFeegcP7Ku3+ZOvI5P8Y+4wjpoEsmZ4pPQgtPLzqc+RBF+sgcHPCqzuvXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAUu/FPhb4PlhJ0sGrrqjoxkhtl6p1gXjtDxAodgDL8=;
 b=CmYOlqeSbXtKd1fovvIQ+dq6ZMarAfMXloF6Tw1wtH5OcBVRjQc9+E2FdlyQgKDagMxMkZzM+M4gttY3Ddj3qNDPpxS7n7HHkbjR3HnKRsOJgWpXek7vri4tzArQnNYjiO8RWOvBAcFzEzpBBWUGX43MvFLjPXNcy9V2/RdCcUf1SZaHNip/IUm7kri1ADAa2cAp600MBzfEYvV5roQL3Uu6VmOVK8pmfzq1Y0CIVPl5Vs51xKB2Kv0wnEaiPkjXLVbsBIC0qOZIgz3gj/v7n0yYH9wPESesELIot9b5xl00nXyt6zjd34JijB7apwLpluL/rTDGzJDLOLCudtS4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAUu/FPhb4PlhJ0sGrrqjoxkhtl6p1gXjtDxAodgDL8=;
 b=dTjAgsPRu0cAPtMiZ/HiEScfmVPYD0cNYMLlZt2D2nvZpVgP+3CG1tLoZEoxLmtgVubCxBq7+qbZCqEz90fzN5dHc5AeiAeWRdwybMQ/roeT5PZQbJvJAPCOYWHYBQsisp1c/ifwEnSGRPNK/V8RB3H6pT7HdJ5FXDwiY2QfHTk=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM8PR04MB8119.namprd04.prod.outlook.com (2603:10b6:8:2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Fri, 17 Oct 2025 00:44:35 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 00:44:35 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, "Darrick J. Wong"
	<djwong@kernel.org>
CC: Zorro Lang <zlang@redhat.com>, hch <hch@lst.de>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Hans Holmberg
	<Hans.Holmberg@wdc.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>, Carlos Maiolino
	<cem@kernel.org>
Subject: Re: [PATCH v5 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
Thread-Topic: [PATCH v5 2/3] common/zoned: add helpers for creation and
 teardown of zloop devices
Thread-Index: AQHcPrB340r8taN6yEWQqPlZfApMLrTE60cAgAAAkQCAAJUwAA==
Date: Fri, 17 Oct 2025 00:44:35 +0000
Message-ID: <DDK6JMVR67I6.2RADBK222K8SX@wdc.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-3-johannes.thumshirn@wdc.com>
 <20251016154834.GN2591640@frogsfrogsfrogs>
 <05b2e86b-bdc5-4298-afb2-9ca9cf702c42@wdc.com>
In-Reply-To: <05b2e86b-bdc5-4298-afb2-9ca9cf702c42@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM8PR04MB8119:EE_
x-ms-office365-filtering-correlation-id: a07d7619-ced1-4f7a-8a78-08de0d165845
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Yk0xcEpZMDlMUkIrT2d2b1dFMGNGVEF4UlR5bjM1ek1yV0lhN0U4aG5BbVBT?=
 =?utf-8?B?Tm01OVRSVUU3bkRuVzJ1RlJlWWhaWGNiSjZicXBTdDd3ck5zYUxRUFZUd0ox?=
 =?utf-8?B?RWpPQ0dNYjdCWkVHTVZtbWs0ODlNcFE1a0F2SW1Cd1I3K3lFWFFUZkRsV2Z2?=
 =?utf-8?B?YkpxUDZHUllFNWFCR202NXlLSnBZNnBLa05mcE5SUmhONWRaNitnTEdsd1pz?=
 =?utf-8?B?enR4RERTVEJNOGV4UUIvNDJXUHdkTXM1U1hjakRvdmlKSW12bmZQaEltSEkw?=
 =?utf-8?B?QkpKNzhCVlFxVnVraktYekNOSXlKRW5CTm5nd3NpeHhaYUJYU25VMlZjS1FI?=
 =?utf-8?B?TW8wZjQyOXFld3p1U3dYaWlXYWNqTzRPN1BZM1BqbGNFNG90anhrUzAwbDRO?=
 =?utf-8?B?U2dUYmlyemZnemJtUGxNc1Y1MGxlS3FTSlNhSCtURmkvMk1MSGsxenEySHdK?=
 =?utf-8?B?TEJJMWRhR1JTemhISjNoU1VvdDYzaWpvTEhJdVZJZHhoMVBnaE5tcEZ4blZy?=
 =?utf-8?B?ZG5QUjhPVXN4c3J2dkwzUUJpTWxTcXZtZ2tCUDl5NkcyVE9jYzIzZCtlZUNi?=
 =?utf-8?B?a0tOeW5saGxHRFFVdndqc0JTcnRUTkV6SVVRZ3V5eXROdHJrTkFoNUc0THRM?=
 =?utf-8?B?dktSODBSeDJRMUtEeStSbGIzRkNJc3dHOHNDSkMzbmx6Nm1IM0ZwRjdVeXRU?=
 =?utf-8?B?a09LRDVmRHc3c3VTUmNBK2dSa2d3Ui9JQ2lkajJTRmxwMktGWXBJdDV4cnNN?=
 =?utf-8?B?aE93RHdHbit1UXA2ZUVaeGVjR0RuWkU0bWp3b0xYejMwK1JiSDZSS1FwdjV1?=
 =?utf-8?B?WmJ5azJZSEpRUDFKWEMzeFJCeWFrYU9HVnNENGZOamFCRUJpdk1jcm5rZ1ZR?=
 =?utf-8?B?WWYxd0tFMmMzYUJDWTJ5Yy9iOS9GT1p5dWtoM0hPS21WVE9VbVdwbmV4U2d1?=
 =?utf-8?B?MXRKRjI4ejNJZ1gwWGdENUI5YnFYcUEyNXlKSlBSTjFiSUUzVTFPOHNRdzlE?=
 =?utf-8?B?WGFQMC9WV1RxU1FpNFVaUTJ1QkhFR2tmSHU0d1NJTk42Qnh2ckZIQm9xQVl6?=
 =?utf-8?B?Tzg0Z25OQjN0N3ZrMk5OdDBhYmZ3VWJzUk5lMjR4OFVGYlgrYy9vejFKQVFG?=
 =?utf-8?B?aFRnUHEzd2lzbU1zSFJFS0dSaGVsaFZXZTlBY0did29MK3g5MEdPNE9qdWoy?=
 =?utf-8?B?ZDdybEFnYWxqUTM4WmkrQ25tTURzK3RSN1ZhdCtEbFBMc3RmeDkzSHJqa0dv?=
 =?utf-8?B?R2ZxS1RJVldVMk8wUm5lMkNJd1A3em8xUEhiZ1ZBZVBFa0NoemNzY1luMnZl?=
 =?utf-8?B?eG9NTlRIZ1ZoWUhHUUZ1b2FPTFJQeFJRMTIwb3kvVjRPL1MyNE52Mzl0S0lW?=
 =?utf-8?B?WlFlYjFMTDduYjZ3VElQeUl5aGRnL2Nidi9yS1d4SEFiMk5rV0t1d0FvTzVI?=
 =?utf-8?B?SWhoMU90aVVQSnRnOUJvQTZqUFUwU2pHR1FlcXVnWCt3N1ZwelRXYVFRM1M2?=
 =?utf-8?B?ZGpIUzRvOE5zZ1huZXp1TTJOWDFYOVZyU0Jyd3JzUUNrVXNKRVFGQ1VJNlpi?=
 =?utf-8?B?Mk5XNG4yRzl3QVhuUHk5VkRpZ2JrZHZ3VnY4ODFNdW5RVDJzU1d3eGQ3ZnJV?=
 =?utf-8?B?Yy8vME5pcitYSk5Gb2lpWTlWUmhzUDlKQjNDZVVFczQxUXQvaVh2cWFSZEZw?=
 =?utf-8?B?SG4vNXV3T1VMM3BkNE84eWkvSWN3THhVK0pOakVJTXk5V1VnUDI4UWc5RW5i?=
 =?utf-8?B?a2VwK0RoaHVaK2d1dkNLNktnQm02dlNvK2xWekQyUTBSVzd4S3J2VFdCaXd6?=
 =?utf-8?B?eTB4Y08zTy8yaGY2MDRFM29vcGN3R2Q1Z1lTRUEyR1h6cUJTeHFSWHE3blBq?=
 =?utf-8?B?K00yK2ZMa0FXL04zTkIreE1JVGFuT0U5VEFZM3Z6YjVkNlZJa2grYkF5dnM3?=
 =?utf-8?B?QzI4aUU4cXp4MHQ3QW0zMHhuTit4eEpqQTJRU2ZGZkdiVkpzYzBZSnhyU0x6?=
 =?utf-8?B?WkZYbWhZb0pZdmcvMEY1WTBwblZRRlRRbjE3RHpGdmxxTGdJdUdFNjUzcmVH?=
 =?utf-8?Q?ztYLhQ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c1VNS2JuK2REVmVQWFJKenVOSkpaQlZTbHc3TUZsNjJmd2pzei9YNmtaQlJr?=
 =?utf-8?B?OFZlQjgxRldmRWl0cXQrcW1uaDR6UWlxTGhUbnNvQUZsbVByeWh1Mk01NmdQ?=
 =?utf-8?B?VjEweFlsSlNLeXlvTERxVVZ6QWJPdHBKOURNVWNhbXRCTFUvZjFXZldaYjRB?=
 =?utf-8?B?emR5MnVqeUJvNDArd2pvN21ZdUFCcERSQWs0ZzhQcGVlcHU5Q2x4WTlOclp1?=
 =?utf-8?B?NnpONjFHbkoyTTg3amtBVDZ1ODE2RGlSWDkvSjRPM2JuajhvTWhZdVVyWGZ6?=
 =?utf-8?B?QnlxbFVZQlhyRUQ5RjhPT2ZGaFRIRThrcnU3OGtXYjhxQUt6ZUNQaHluOURL?=
 =?utf-8?B?LzlYWFlyUFJZMHVKaVJ2eWFJWU9od2FnNkNyODdnSG9ET1hzOFI3QXNVZFZo?=
 =?utf-8?B?NkZsbG9zT3NvS1IrdHRxU0hCQm0zTXU4VXdKeEZnT1RaTXAweFdyOEUvem9O?=
 =?utf-8?B?NjN0RGxETCt6VFlQcllCYlIwV3dNQVlpSk1pbDhKS05VS3JXTGhkTURmVkE5?=
 =?utf-8?B?emtKbnVueGhaa2tKdFpiR2RCZjc4MG9xMEFwTkpnSG5QMDZRUUpOY01ZbVF3?=
 =?utf-8?B?TEp6ZlFpelFmeUpBRWhiTXlNZUI3cEZqVG9jU3pZQUxma3pFZEF6QUszSDBU?=
 =?utf-8?B?SERWTTBQbDZ2RWNlaExSRFVVWld2ZjdvRFVGQjByOS9kZERkSDlxRmFDaXA5?=
 =?utf-8?B?b0hMeWdZTUpPU3E0c01objVCUkFxUXc3VmdpdFVNc0dmdVFSem9nYVBaYnVq?=
 =?utf-8?B?aFJEVjhVMEJKSVdzcll3ZWh1ejNYMWJ4d3R1TEFka2RUSVFWYlV2T1lXMjZt?=
 =?utf-8?B?S05ybFRWM0JZa053cWFlVGhLbDV4Tlgwamhpck0xWTlEL0EzRGM2cjJRcm95?=
 =?utf-8?B?MmJZaUFlcCtxc0N6WGtqQTVsZGl4TmxrUHBEeU9JZXp6VVNyOW1yeWdPNk04?=
 =?utf-8?B?dmorYXhSTjVpL0UyQXRqU0JDY0VGTUo1Qk1BZXNzWkhIZ21XYzBSQnRUTDlW?=
 =?utf-8?B?dThVQlFJVFIySWZqUDRhMFA2V1BMQ2ZwVGY2VjNkbjVFUDFJVVFyVjVtcUtl?=
 =?utf-8?B?WnU4NndKRVM2LzN5Q0NCMTRlczcrbllDMmJ6NFMrcnZ2N01TVG5jZ3JuK0tF?=
 =?utf-8?B?dGtHWUZvcit6emN5dnJVczBzRDB6bXhGSkV5aTFkVTZ4VXZqakJoRmxOc0Z0?=
 =?utf-8?B?Z2EyRFR0ZlRzaVUvbHMrem0wbE03NWx2dDNOdWdha3pFbnI0NUtBSFFQM3Zj?=
 =?utf-8?B?cUI2ckVGcmhQb1h2ZW1sV012Tkk0dnB4T3E0T05haHl1UmNsTlU0d2ZMb2hO?=
 =?utf-8?B?cFQ0NzZQWFppVk50Y0RzY3dIMC9vZ3Z4QlR3dXNFU3V6RUxZOE9zSUNRbWpH?=
 =?utf-8?B?b05lbzJldUtSMnU0NVZ5V1d2TEI0Z0tJOE0vTU1OeG54Mys5SDc4SklhemhC?=
 =?utf-8?B?cjc3T3RsVS9xWGtid3ZWdVAxRjFBS05CK2FYSHdJcGhrR0QvbytGdFQvYzk4?=
 =?utf-8?B?NTZkMDhjY29RSitrN3R3a01GMk8xWHdDNmdkZDBvUzkvSXFSWXptZ09OVS9w?=
 =?utf-8?B?bnUrTnFlcjdWWS9VOXJ4L2RRSy9KMytCUGlBM3pFckVEL3h4TTRwaVRJaVc0?=
 =?utf-8?B?ZmZqVlhRRmJNWEl6aDlWT2dqa21wRFlKcGFsUUNpNlBTcy9aOUJxMlo1U0dQ?=
 =?utf-8?B?RGlOK3h3RUZITkR4U2NmOWFFb1RZWUdEWDBiclVxM2JLNjRGYlRjZWxQdk1u?=
 =?utf-8?B?ZXc0WmlxK1hWQndEbzdGSmU5RjVXcjUrd09qcU8xZHZUN0FBcHg3eFFvQ1Fx?=
 =?utf-8?B?VHlDcVhhV2FxNC9kTUdJMUprRFMxS2NVVml1SnZlL3RTYnI3c3BCK001SDhE?=
 =?utf-8?B?SG9VYVVtYlJRTWs2cHAyRUxtWTNDOHR5S3lhNmlzMmFnUERWYnM4OWc5WTlT?=
 =?utf-8?B?cUk3YUptUHc3Nysyb25HdzJuQkNSK1dnVDdtK0lUQndEbjBWa3BCU1ZNSVA1?=
 =?utf-8?B?QXBZVk5ldmNNTWxMcEVBTmlZQjQrZWJvUFlmUy8vZzRUUVBINDVIUnovdkhJ?=
 =?utf-8?B?d00vclpqQkwrYjBrWFpkSFUwMWF5S0xzRXIzZ3RRbW5tNW5MQ2U1VENmNUdY?=
 =?utf-8?B?Wnk0U1l1QXp3TjhiMnhTZitLNUd3dy9jdFpwZGxhdjVjVWt3QkgzUGJiU25L?=
 =?utf-8?B?M3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EDDCCEBD47CCC40A8D53F0E4772F082@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ELeUPIINy5+amIZm4nwO6cLEuHH6pNIa4kXUBOzcf9pmGAnSg5taWdNTaN9s7X6ULwfSMNYcWC5e4StPXuZlGrU2qTUWovkP59d5KuyVkjiw29/m95RUlO944AWc6LponTR44u1oCpt4nJGJB/vXHBkDKgkFpVuTnZ5VCz8tF/R7ibDoF9XQhDdo24iCDTNhiiL0EBNPgZJ6pmlnDijVakk4VE76xPUuUUmH+47QHNe4jLGr8tpU/BXAB01VYquBUKNZh8uVMpGuRWmu22c4VYAbq3RG/JaWusqaYkp9Gyq8GrPcQenLT0CjvR3UST6CQBI6U1F6Hh9mqhYaWmNIoogreHDsxLWM6OE4Zy/HnuriFVp1QTYlQapt7XZZWPOgR3UbiGxhDIFQJ4K9gXKc6cDKIZF+0xcIMvj5SW+hrs4lVZ4qbH5HqNzxNwGD84W01dyLnG+KRRcnbpIvh5JUiEm+eDn3uXiWrrnfc+IpmgNaenESrcthPnpd3+2xycE+Fnpf9sKYr4rKmSg9J23wGHGCKoWZvMiQ+GUr3xsFsuOK5yt0XTf7JXuVqy9JGmInBb4aEFbXc8EBCBNbaubf6/jba0IBhJ/M9wwtO8SmhHZUi5p08eloCBv/OQn9dpjw
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a07d7619-ced1-4f7a-8a78-08de0d165845
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 00:44:35.4365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IiOsC5bjVZes1FkFlPHmBBZvBLMaX3wMicYYxLym2ftWqmGUaDga9TC5E83/lCZCQlJEj2CkuHVQh3UESpsGJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8119

T24gRnJpIE9jdCAxNywgMjAyNSBhdCAxMjo1MCBBTSBKU1QsIEpvaGFubmVzIFRodW1zaGlybiB3
cm90ZToNCj4gT24gMTAvMTYvMjUgNTo0OCBQTSwgRGFycmljayBKLiBXb25nIHdyb3RlOg0KPj4g
U2FtZSBxdWVzdGlvbiBhcyBsYXN0IHRpbWU6IHNob3VsZG4ndCB3ZSBvbmx5IGVjaG8gdGhpcyBp
ZiB0aGUNCj4+IHpsb29wLWNvbnRyb2wgd3JpdGUgc3VjY2VlZHM/DQo+DQo+IERhbW4sIEkgdGhv
dWdodCBJJ3ZlIGRpZCB0aGF0Lg0KDQpNYXliZSwgaXQncyBnb29kIHRvIGNhbGwgX2ZhaWwgYXMg
X2NyZWF0ZV9sb29wX2RldmljZSgpIGRvLg==

