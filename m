Return-Path: <linux-btrfs+bounces-12393-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6524A682AF
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 02:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC7C3B834C
	for <lists+linux-btrfs@lfdr.de>; Wed, 19 Mar 2025 01:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9A576025;
	Wed, 19 Mar 2025 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aOuzebIN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cl5YPfGn"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBF62F22;
	Wed, 19 Mar 2025 01:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742347140; cv=fail; b=qYBidk5L73nyQLIEGEIvA0IQi93ASrwggT1zVMbZfOVQzEyJsLlDUB+EF4HVo61Gb0i8wNImjYvk3bFgG8mGQ55qB/a/0RRhLw8NAK9HXvmslpj/AL67/n5tijWdRsI2qMgNYpjxsfG+/ZdduT4M8JbjSXmUQa8+U/tQ2R4CDBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742347140; c=relaxed/simple;
	bh=m5L8lnIiMDfC7V2kNNwOGuai3ZNJSeyvw72V9snnnAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nqrv3jIvHJnSEgC7/5p2gTaANeEbz8C654hh9Y41j8BgeN7S5F3viDNFhBsWBI9USfzGUWsEuv3/XR9gO24olGbeV24UVAH7lmrpoDNnOhppRsbzsfUf1re0lHxtzbnaHtvRavOhvionJxEU07SKAbOMg7hWo2I6ctJ9ZmQDE1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aOuzebIN; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cl5YPfGn; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742347138; x=1773883138;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m5L8lnIiMDfC7V2kNNwOGuai3ZNJSeyvw72V9snnnAI=;
  b=aOuzebIN7da9LumX0bNjXWNU9UtQ1pMttl52QLcRVTiVHk3RdAFOI+ty
   L24JsePv9kNOsVlUCcPj7FV9yJZyUgb9aDhq0vxi3HhtAkKkyhPkTlhBu
   q+ynALcZip9AynC54f9k9zRvKPIdOW/CVsDXHkmY2yt9UCfNCXBre9+Of
   LkQJ1GsfPSCQCkUwhz8yifH+iLIWHxCbdzUS984Q8cq2UUalcpclhr94o
   FZKTFN7Bfyu1B+zrxbeYmeUFEEKQt9PtP1jAXKQEoYjPxrVjHxHVNL2I6
   /N36Ts+cQXg/hOfEHo/cPbwPeodE2VR0iN2RMn1ierFDmhJK5JMyHkSZ5
   g==;
X-CSE-ConnectionGUID: ZL3/1yF6SVSNCYwoiPW7Wg==
X-CSE-MsgGUID: ZrdCsa1eQiCeF8Abd6xnqw==
X-IronPort-AV: E=Sophos;i="6.14,258,1736784000"; 
   d="scan'208";a="54983915"
Received: from mail-westusazlp17010002.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.2])
  by ob1.hgst.iphmx.com with ESMTP; 19 Mar 2025 09:18:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbrdhCeOvotpMWvnCOUZ1H9kIYfCbeMLLDPJQ2sNHx7ogexHJgA1rcLBBoIjtcXPd0RbUiwufJ90CJr1lgflXa1l4ydRV+PoSkHxYiEI932KacsVi1hxrqBraueQAOkqUiNFA/8e5C/AUkFn5qztmsjMEiujs1d7mSd6rMq6yQNMsDkSeGodSYPoZJ+66i8EbpL8YpmyZcC3TouONMOL8pqM7lcOmFOcydKXQI5Ts5Wt6WQhbCmZ1/nI4RNLl+qpNKFU/2npw9RJOx7bOhGSsA7PgUjGjUhSz8S0ZHJvXuQLbVCm/X9h/BrmayuEgFlEcQFG2zib3xgfd2Yi9+Ux8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5L8lnIiMDfC7V2kNNwOGuai3ZNJSeyvw72V9snnnAI=;
 b=yBAMTcCgnILGBh9bDHwW+ZTWVZNxa4j18aJE9UAJ/Ixw78iNehDfqwbJ0IPuVo5Y0g/kmqfjpQKBIR5+AmXM2EdN0NLrg9jW2eEbOL1XixUVITpaBQJQntqbBu6o8n4LTmON6HgAWqHWezEXsKGgizeoaSZm+IAufGYsedCGF5uX3hGIMoWcvlLSXEOiherSqze3CqFPEgH5dZcy2F+eAELoIGLb4q+KAb+x1ppYFzGkd2k3JqkUpdGC4sU7oJLJPf/L/aLImlE92jFeL8TKRf1YYxQKAnG3uUonzhB/PgTADkYpiljpTNWfTrcR0weIeCv0EuNPo6fn1B4KAeHMhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5L8lnIiMDfC7V2kNNwOGuai3ZNJSeyvw72V9snnnAI=;
 b=cl5YPfGnvGasRaU36CYYgsmmygKuTXLWG6Zr+MsVfC4Cx9J397zfbYs3EcCbAoCDvDZLQcgnN06uYdNm5cvch84UQe5T1JRNj46sNv+nzeDDqCwUFbTTlGIjU1kl8LhBgEG45TDc73UIbdrfiF8dG5h+ZjiBvlGqEajYBDByFCA=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY1PR04MB8679.namprd04.prod.outlook.com (2603:10b6:a03:526::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 01:18:54 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 01:18:54 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, Zorro Lang <zlang@redhat.com>, Anand
 Jain <anand.jain@oracle.com>, Filipe Manana <fdmanana@suse.com>
CC: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v3] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
Thread-Topic: [PATCH v3] fstests: btrfs: zoned: verify RAID conversion with
 write pointer mismatch
Thread-Index: AQHbmAgkxT/w4Oni0k23/ftlWU0YGLN5qbCA
Date: Wed, 19 Mar 2025 01:18:54 +0000
Message-ID: <D8JUIEYCDPGF.2OM4BFFRXRUAF@wdc.com>
References:
 <05f928908a7949fb1787680176840b5ab23fde0b.1742303818.git.jth@kernel.org>
In-Reply-To:
 <05f928908a7949fb1787680176840b5ab23fde0b.1742303818.git.jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-mailer: aerc 0.20.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BY1PR04MB8679:EE_
x-ms-office365-filtering-correlation-id: 10f74616-278f-4531-23f3-08dd66840405
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RXhQOGVqRGU1NXA1ODNVd2lMSWdBU1BISnJEZWtEOWw5RndTSUxBL0FSeGUr?=
 =?utf-8?B?ZytKK0o2WFBUdFA2V1JQK1VsS1phSUp2b1dzUm5HQkxJQUp4alFiV3pMejlr?=
 =?utf-8?B?Zm1XK1EvWG9kVUdpTFpFUC9kRmRzeS9FVTJZY083TGNuKzNzdng2UzNmZFFw?=
 =?utf-8?B?VzlueFNkYUppZDg3YitrVXcxTngycmJOam1zT0pyUlh1UHNYay9FRE1FYjJV?=
 =?utf-8?B?OC9IK0Q0dFdROGhtQzNvR0xWc3EwRHlhWG93TFpNTG56N0VUTy9oMk50cEZu?=
 =?utf-8?B?R3V4RlJKUXBka0hDUEZXRER3M3V1S1N6U3hSbk1DNUZBRHpuNGtxM1p6eE5O?=
 =?utf-8?B?TFNXdFdkVFNUWEQ1SVNWaVdsUEh0cUVJcTBQM1A3RHJiUzVjTkZ1ZzV5Vzlj?=
 =?utf-8?B?ejdBODdQVzFGZUJvZ2tERUJ6MHQrM2VaRFhoNnB6SzZQWU1TdTVtc0lUbXJr?=
 =?utf-8?B?dlNTb0hZenpCQkpqT0Fvbk04amExTnNXMmRtM0IxYktmUTVZLzJ0dDZEVEM0?=
 =?utf-8?B?UFpaanVUOSs5UlVUcnpQNERZenRRUzFSTmF4YjRJOGtoVExpMXFZalNSUTFN?=
 =?utf-8?B?SkhkbHEwWjNaNGZpTUZxTFBFZzRJTTNqYWxvalNuTnQyZnF4NkJtOFdZZDEx?=
 =?utf-8?B?QkZJcGZXWWdmOS9BNHk5TExCSDYwMG52T0t2VmxFQUEyUCtZTFIzY0lKYjd5?=
 =?utf-8?B?M0lUTFJ4TVBmdEgzYTJ1ZFBvYU1zbllzVngwZ2QxMytWU3hmM0s2bEhsc3pP?=
 =?utf-8?B?d080QVlaRzFyaXMxc1VPNUpwTTI0SVl2WCt4TDRiRlg2V3JIOTZyblBBZEQ2?=
 =?utf-8?B?UVJYdEQ1YVFmQ2hyQUJFSmlzMUNlcllNVFcyamxxaUVqcW9aR0F4Q0hGR3lD?=
 =?utf-8?B?SWVlUEhjUTBmcVlrNFVYZmxNLzhEbVk2Vmw0Ync3SUI1Z213c0hua2lxU0Ja?=
 =?utf-8?B?M3JZSlV4Q2xRUCt6UWVMbHRWMzNVWS9DWWpmZEpBaHBoMGRUd3RzblZBWHBn?=
 =?utf-8?B?MENScnVZcmd5MkpXaWEwMW12Y3VRaW1ycWt0UWlhRTU4OC83azJvZ2cvNExR?=
 =?utf-8?B?V0VmUmV6d2FrdzRKalY4TytaQTVYTjhxclpTS0ZkZ3k2SDJaZ1BacG42ckFT?=
 =?utf-8?B?cW82a1NjbVlZS2lMSkg0TzdoeTZRVVc1bDc3bHZyUmI1akRKV1BhZFZYYTZr?=
 =?utf-8?B?Y1V3aFJ0Yks3SnJLUUxHbjVtamRMQ0JtTjBCZHNVTWF5U2Iwa0U4VFZPbGZU?=
 =?utf-8?B?MElrd1VlTUgwc0JmdmI2WHBKcnI5ZVlsVGFwR0dwc2hIeFVUa21NalpTNVlz?=
 =?utf-8?B?QU9hbS9NeXBKeVlVdldwbUVmRkhXU0VlWnRuUWdxdk9qK0huSzdNMnZZYStP?=
 =?utf-8?B?cXZQYWZxWHE2R0c5RHcxaVA0b2tEZjg5THFwd0ZEb2VVcDl3TmxsdHUwYy8w?=
 =?utf-8?B?U0NNZjJCRnJNRzE0R3A4TUgxcVdzRFNYUmxMUi9WZks2Qm9PVUtULy9zRmFx?=
 =?utf-8?B?YThSRE02K2pCbGFIVDUvSS8wQVB2a2xuYU9vTXFlR2c4RVIvNG04dXRPVFQy?=
 =?utf-8?B?dlJlY2dKNE1UT2gzQmdTbWtkVmJmL2tRNGpUV0w1YXBsREJja2VPaFFMV2F5?=
 =?utf-8?B?bDQ1dHArWXVLTW1VM1pkQW43WDVUM3djdjFnRE52TTQxK3h3cUd0NHFBWDZq?=
 =?utf-8?B?dHZiVGg3cy9ya1ArZ0grdVFGY1gyUGdTays4TnIzUHRxR2ZzbGZ2c2pINGQ5?=
 =?utf-8?B?cHRLYmEyaUcvYUJFZHE2eXByTWZsUlRoRk0zWkVNemd2SGxYU0J6Q0FpM0Fh?=
 =?utf-8?B?VDZSZWxyc2FjV0E3eDVlWHYrMWVrRXdHZDU1SFYwNWFvZUxTMDNna1MrVmcw?=
 =?utf-8?B?bHJnS3JzVkRTVnBuc1pZaFlRSUlTbzNhN1kxdHVsVWdDTFQwMmR4OTM4OUxh?=
 =?utf-8?Q?FF0Au6IlrQnBwTeaoPDnLNDaRWZcPs3y?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3pmSmNWZkl0VmVrWHNVaGhYRTJZYm41OUR0aTdlVUNkc25ER0hJeU5reXhv?=
 =?utf-8?B?M05FMDNDeUVaUWZkVUl5L0xkNzJkUTFPRjVMMHczcFpMN2RYNFRDRGtiZXZt?=
 =?utf-8?B?cFB6TWxuU0RhWm9SempTczdBM3ptVGh6MURiN3lrTjk1RHdpTm9HUzZhZjdu?=
 =?utf-8?B?SDZVZEJGa1ZIeHN1NVBzOWRqQzJSRWJSdEpYY200M1RWYlk4aUVyVE13U21R?=
 =?utf-8?B?em5HS1VKTS81RSsyUkEwc24rSHN3RlVnYkhIeGVtUFE4cFJvVGxLdWt1VFVx?=
 =?utf-8?B?aitjcnl0TWh6YWJCK09HSjF5MFY1SG0vNkJ3QWc1UWtqcjBUak5zVzVzQVJq?=
 =?utf-8?B?akZabVJ5RXY3eTBVNEZ2WGp2a0ZJUzZhQUo5dHZEZHJCcW5tV3NaVmZRUWJW?=
 =?utf-8?B?MXdpVE1HRUoyOTRqREFZajcrU3lqSUMrREU1YXlnZVlSRTlCNzB4eUxtN2V2?=
 =?utf-8?B?UXEzQzFlaitpTXBRTGhGOUVFZW1XcnordnhWa2p0dnN4NHRJOTIxczgrdFpx?=
 =?utf-8?B?VWN3bVFtUit1M1JVNS8ydGFzM3U4NHduZjhqZURZWE1IbWhJTzJZL0F4MFJI?=
 =?utf-8?B?ejh6YnBjS3B1TVp2UFVrdTVreFBidVFMeGZOWjJaNFc3RTR4U0FMdDN0NnAr?=
 =?utf-8?B?MExSaStHK1JVRU9RWXkyb0ZSWEp1SVJTdVRLZGlCc1VMNDFaWW01bkM4c1Vu?=
 =?utf-8?B?c3F0L21XMjZVbXljcXFEblJjRlZ0QkdCY2VFZGxJckE4alBFYmo0OC9BNS9s?=
 =?utf-8?B?UVA2SlJsVEFqZDNWL3V3LzYxSzQvdEdzSDUyTDgrTlY3ZEIvUWFYclRjK3RF?=
 =?utf-8?B?TVlubk1Nc1RBenpKdzNqaDhOd1VMSmM0ZHRnV2F1UG5PcW1IV3kwYU9pNzlI?=
 =?utf-8?B?QWtENEwvME44Z2pQMWpRQndMQVVNNy9peXh1MkdvYklmem9LQmg5NGdTUjRx?=
 =?utf-8?B?ZS9wVWRUZE52Y2srcHhDbDR0YWI3S0hsdFZZY0loRVZVcFdyaEdINWFiTHAr?=
 =?utf-8?B?TVdpQzJNTkNrTDV3V3NJbGEvUEtncFErTzhKL24zN3AzSzlsVUpoL05lVjFh?=
 =?utf-8?B?eTJoWVR2UFpLbEthdUJueVpxRWZ1SVd0cXF3VFJyQTlvWGxCV2xRZW1zSWQz?=
 =?utf-8?B?S0VPcllNd0lLcGIrRXduZTcxUjFvcGp2ZWtDcXA2WEpDUThmK0dnS09qQzBm?=
 =?utf-8?B?NzZESG90aXd0NFg5Z1ZTQ3hDWnNWSCtjakZXV2I5ZzV6SVphaXZUTFRkcHNm?=
 =?utf-8?B?bUdtclhRNXIyOTh5ckhsSTFQTzNYZ3JxNGZkRWZxSjNZTzdCbGozcTk4WTh6?=
 =?utf-8?B?MFZ1VHV5RmQ2dFNZNnlaSXA0dUxIMmlrdWVkNFd0R1F0UmFVVzVyMUFVQWQ2?=
 =?utf-8?B?MEtSV2ZURWdmajRFYTF6eVUxeUVaQkhVcXhJWWJCcTg5U0ZMcVdEbzRSUll3?=
 =?utf-8?B?YmVXQ3hVSVZaMHlXMzB6RjNpeVNiODR1VXBLMEVGbXNhd1k2eEpNaTBBeGlj?=
 =?utf-8?B?UTZXNlhvYlExOHgxTERoQXl0WDdtNFhjeHlTK2wvU3VEdERLdEpaTTBFbWRo?=
 =?utf-8?B?M0pCUmpiNURuM2VuVUx6Vk4ydmEwTXc3T3c1a2kyam5WWFg2RzhEakVUQ25Q?=
 =?utf-8?B?bEZuNWxYWTlFdkFyVUh6ZFJaYkt3WEVHaGtxS1RmNC80ZUlUblMwZWVqZ0ZE?=
 =?utf-8?B?S1Ivd3k2T0ozR2xSQllhQWlHbldNbklQTXk3cS9kTFh1aldWRGUzU29TVkxB?=
 =?utf-8?B?NVV3SG9PVmZrbXpoSmVLMjZlWW5oZXlTOCszOFcwcDJGbEFpalpGd0ZTRW5S?=
 =?utf-8?B?NURZb2ZwMWdiR0o5YWcxZ21LUmtaWTRDYWpNMzVCTnpqWjN5S3FyandTbzJy?=
 =?utf-8?B?Z3VORVUzUjVxbXdaN0Z0R0QwczBNRCtQUGZsNS8xRldTNFdKYStkcUpEcXQv?=
 =?utf-8?B?b29qMjQyK09UeUJoem9UOWROR2J2bi9vTy8wY3BObTduOWpNQ2RDTm9ZVHp4?=
 =?utf-8?B?N2R5YmlybDlqWktlRzBqdHlUc0ZOVVExWmdJcDVYWDFieXJUdjZZSWQ2VFpQ?=
 =?utf-8?B?dUdUWUxlazJ6bW5oUkV6aWdKTVVWaXoxelI5T1V4Yk9PR0QyelJwZEJ5MkpN?=
 =?utf-8?B?c3pBNmR1Ly85Wnl2aWpLQ05pQk9SQmFaMmppdFJNVjJITUp5M0dnV0NRMWM3?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA17FCFF7BC5504D8BABA0752191A2FE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4b+f1TL26mFqMGHqXHeQ1l9B/JLXHffS06/ZcTjEbGICDg2NCmibsKsCluF66Id0s2phIJKGSIJCRD84BuvNYBWP24/5UAlPHjLWrhCs+k/dIQP/eInoyjtzur+BXfK2rXcb+FYcmpa32SdOKzU3RkX1viKpeqeJfeg2/0RNrOhatKN0vQNzFh7Oq+905+ZG+oVvecgKV8Uq0foxdTDExZnWvuBXiP1mNY2Nq8Z8GNdVE57Se4Rcf5JTmnV9wT57yW51RUPZ4CO8x+58juOie3kEolsqXgfHRC2m2CsNLupv51wbFawfP65xxGslv0cwQ+VUSUajId4n+3KMswPPQaZxlqHSlyAJJllS6jg9fI9/5Q2CcalyPEMqYSRmlLQZIxAuSy9fnxgagVZGhaN/Mz9IPRnbsuoMX3kt7VdNuMJFlrGKxVlE23qDm8N9oK6L9sLFwzdE6xCniPqVtSRDl/znznQoIJSN8pBiVJVhrZ5Vssrn+DPhHX9p+kxZXgZnRJ25GtoBMPkGif+EG/WnIGlo31yEPER/AgyzZVtBLG63v5G9n0otiVcLXf6uf2F2CARAqmNadn2793mWK3DlNhi3ceKUjfgBluOcOBIhCSNmX295lNSaGgfYkgjBb7M9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10f74616-278f-4531-23f3-08dd66840405
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 01:18:54.5330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sFqwt3qTMOMp2SFt07/dAd+zcc4qscd/1aOum4U7Jl9kdIUBE5TPKTXGFiySxY4RG5tkbskcB1HVRhmn9q3eBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8679

T24gVHVlIE1hciAxOCwgMjAyNSBhdCAxMDoxNyBQTSBKU1QsIEpvaGFubmVzIFRodW1zaGlybiB3
cm90ZToNCj4gRnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2Rj
LmNvbT4NCj4NCj4gUmVjZW50bHkgd2UgaGFkIGEgYnVnIHJlcG9ydCBhYm91dCBhIGtlcm5lbCBj
cmFzaCB0aGF0IGhhcHBlbmVkIHdoZW4gdGhlDQo+IHVzZXIgd2FzIGNvbnZlcnRpbmcgYSBmaWxl
c3lzdGVtIHRvIHVzZSBSQUlEMSBmb3IgbWV0YWRhdGEsIGJ1dCBmb3Igc29tZQ0KPiByZWFzb24g
dGhlIGRldmljZSdzIHdyaXRlIHBvaW50ZXJzIGdvdCBvdXQgb2Ygc3luYy4NCj4NCj4gVGVzdCB0
aGlzIHNjZW5hcmlvIGJ5IG1hbnVhbGx5IGluamVjdGluZyBkZS1zeW5jaHJvbml6ZWQgd3JpdGUg
cG9pbnRlcg0KPiBwb3NpdGlvbnMgYW5kIHRoZW4gcnVubmluZyBjb252ZXJzaW9uIHRvIGEgbWV0
YWRhdGEgUkFJRDEgZmlsZXN5c3RlbS4NCj4NCj4gSW4gdGhlIHRlc3RjYXNlIGFsc28gcmVwYWly
IHRoZSBicm9rZW4gZmlsZXN5c3RlbSBhbmQgY2hlY2sgaWYgYm90aCBzeXN0ZW0NCj4gYW5kIG1l
dGFkYXRhIGJsb2NrIGdyb3VwcyBhcmUgYmFjayB0byB0aGUgZGVmYXVsdCAnRFVQJyBwcm9maWxl
DQo+IGFmdGVyd2FyZHMuDQo+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LWJ0cmZzL0NBQl9iNHNCaERlM3RzY3o9ZHVWeWhjOWhORStndT1COENyZ0xPMTUydU15YW5SOEJF
QUBtYWlsLmdtYWlsLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxq
b2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4NCj4gLS0tDQo+IENoYW5nZXMgdG8gdjI6DQo+
IC0gRmlsdGVyIFNDUkFUQ0hfTU5UIGluIGdvbGRlbiBvdXRwdXQNCj4gQ2hhbmdlcyB0byB2MToN
Cj4gLSBBZGQgdGVzdCBkZXNjcmlwdGlvbg0KPiAtIERvbid0IHJlZGlyZWN0IHN0ZGVyciB0byAk
c2VxcmVzLmZ1bGwNCj4gLSBVc2UgeGZzX2lvIGluc3RlYWQgb2YgZGQNCj4gLSBVc2UgJFNDUkFU
Q0hfTU5UIGluc3RlYWQgb2YgaGFyZGNvZGVkIG1vdW50IHBhdGgNCj4gLSBDaGVjayB0aGF0IDFz
dCBiYWxhbmNlIGNvbW1hbmQgYWN0dWFsbHkgZmFpbHMgYXMgaXQncyBzdXBwb3NlZCB0bw0KPiAt
LS0NCj4gIHRlc3RzL2J0cmZzLzMyOSAgICAgfCA2MiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysNCj4gIHRlc3RzL2J0cmZzLzMyOS5vdXQgfCAgNyArKysrKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCA2OSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA3
NTUgdGVzdHMvYnRyZnMvMzI5DQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvYnRyZnMvMzI5
Lm91dA0KPg0KPiBkaWZmIC0tZ2l0IGEvdGVzdHMvYnRyZnMvMzI5IGIvdGVzdHMvYnRyZnMvMzI5
DQo+IG5ldyBmaWxlIG1vZGUgMTAwNzU1DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uNTQ5Njg2NmFj
MzI1DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGVzdHMvYnRyZnMvMzI5DQo+IEBAIC0wLDAg
KzEsNjIgQEANCj4gKyMhIC9iaW4vYmFzaA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
R1BMLTIuMA0KPiArIyBDb3B5cmlnaHQgKGMpIDIwMjUgV2VzdGVybiBEaWdpdGFsIENvcnBvcmF0
aW9uLiAgQWxsIFJpZ2h0cyBSZXNlcnZlZC4NCj4gKyMNCj4gKyMgRlMgUUEgVGVzdCAzMjkNCj4g
KyMNCj4gKyMgUmVncmVzc2lvbiB0ZXN0IGZvciBhIGtlcm5lbCBjcmFzaCB3aGVuIGNvbnZlcnRp
bmcgYSB6b25lZCBCVFJGUyBmcm9tDQo+ICsjIG1ldGFkYXRhIERVUCB0byBSQUlEMSBhbmQgb25l
IG9mIHRoZSBkZXZpY2VzIGhhcyBhIG5vbiAwIHdyaXRlIHBvaW50ZXINCj4gKyMgcG9zaXRpb24g
aW4gdGhlIHRhcmdldCB6b25lLg0KPiArIw0KPiArLiAuL2NvbW1vbi9wcmVhbWJsZQ0KPiArX2Jl
Z2luX2ZzdGVzdCB6b25lIHF1aWNrIHZvbHVtZQ0KPiArDQo+ICsuIC4vY29tbW9uL2ZpbHRlcg0K
PiArDQo+ICtfZml4ZWRfYnlfa2VybmVsX2NvbW1pdCBYWFhYWFhYWFhYWFggXA0KPiArCSJidHJm
czogem9uZWQ6IHJldHVybiBFSU8gb24gUkFJRDEgYmxvY2sgZ3JvdXAgd3JpdGUgcG9pbnRlciBt
aXNtYXRjaCINCj4gKw0KPiArX3JlcXVpcmVfc2NyYXRjaF9kZXZfcG9vbCAyDQo+ICtkZWNsYXJl
IC1hIGRldnM9IiggJFNDUkFUQ0hfREVWX1BPT0wgKSINCj4gK19yZXF1aXJlX3pvbmVkX2Rldmlj
ZSAke2RldnNbMF19DQo+ICtfcmVxdWlyZV96b25lZF9kZXZpY2UgJHtkZXZzWzFdfQ0KPiArX3Jl
cXVpcmVfY29tbWFuZCAiJEJMS1pPTkVfUFJPRyIgYmxrem9uZQ0KPiArDQo+ICtfc2NyYXRjaF9t
a2ZzID4+ICRzZXFyZXMuZnVsbCAyPiYxIHx8IF9mYWlsICJta2ZzIGZhaWxlZCINCj4gK19zY3Jh
dGNoX21vdW50DQo+ICsNCj4gKyMgV3JpdGUgc29tZSBkYXRhIHRvIHRoZSBGUyB0byBkaXJ0eSBp
dA0KPiArJFhGU19JT19QUk9HIC1mYyAicHdyaXRlIDAgMTI4TSIgJFNDUkFUQ0hfTU5UL3Rlc3Qg
fCBfZmlsdGVyX3hmc19pbw0KPiArDQo+ICsjIEFkZCBkZXZpY2UgdHdvIHRvIHRoZSBGUw0KPiAr
JEJUUkZTX1VUSUxfUFJPRyBkZXZpY2UgYWRkICR7ZGV2c1sxXX0gJFNDUkFUQ0hfTU5UID4+ICRz
ZXFyZXMuZnVsbA0KPiArDQo+ICsjIE1vdmUgd3JpdGUgcG9pbnRlcnMgb2YgYWxsIGVtcHR5IHpv
bmVzIGJ5IDRrIHRvIHNpbXVsYXRlIHdyaXRlIHBvaW50ZXINCj4gKyMgbWlzbWF0Y2guDQo+ICt6
b25lcz0kKCRCTEtaT05FX1BST0cgcmVwb3J0ICR7ZGV2c1sxXX0gfCAkQVdLX1BST0cgJy9lbS8g
eyBwcmludCAkMiB9JyB8XA0KPiArCXNlZCAncy8sLy8nKQ0KDQpDYW4gd2UgbGltaXQgdGhlIG51
bWJlciBvZiB6b25lcyB0byB3b3JrIHdpdGgsIGluIGNhc2Ugd2UgcnVuIHRoaXMgdGVzdA0Kb24g
YSBodWdlIGRldmljZT8gSSBndWVzcyAyKigxMjhNLzRNKT02NCB3b3VsZCBiZSBlbm91Z2guDQoN
Cj4gK2ZvciB6b25lIGluICR6b25lczsNCj4gK2RvDQo+ICsJIyBXZSBoYXZlIHRvIGlnbm9yZSB0
aGUgb3V0cHV0IGhlcmUsIGFzIGEpIHdlIGRvbid0IGtub3cgdGhlIG51bWJlciBvZg0KPiArCSMg
em9uZXMgdGhhdCBoYXZlIGRpcnRpZWQgYW5kIGIpIGlmIHdlIHJ1biBvdmVyIHRoZSBtYXhpbWFs
IG51bWJlciBvZg0KPiArCSMgYWN0aXZlIHpvbmVzLCB4ZnNfaW8gd2lsbCBvdXRwdXQgZXJyb3Jz
LCBib3RoIHdlIGRvbid0IGNhcmUuDQo+ICsJJFhGU19JT19QUk9HIC1mZGMgInB3cml0ZSAkKCgk
em9uZSA8PCA5KSkgNDA5NiIgJHtkZXZzWzFdfSA+IC9kZXYvbnVsbCAyPiYxDQo+ICtkb25lDQo+
ICsNCj4gKyMgZXhwZWN0ZWQgdG8gZmFpbA0KPiArJEJUUkZTX1VUSUxfUFJPRyBiYWxhbmNlIHN0
YXJ0IC1tY29udmVydD1yYWlkMSAkU0NSQVRDSF9NTlQgMj4mMSB8XA0KPiArCV9maWx0ZXJfc2Ny
YXRjaA0KPiArDQo+ICtfc2NyYXRjaF91bm1vdW50DQo+ICsNCj4gKyRNT1VOVF9QUk9HIC10IGJ0
cmZzIC1vZGVncmFkZWQgJHtkZXZzWzBdfSAkU0NSQVRDSF9NTlQNCj4gKw0KPiArJEJUUkZTX1VU
SUxfUFJPRyBkZXZpY2UgcmVtb3ZlIC0tZm9yY2UgbWlzc2luZyAkU0NSQVRDSF9NTlQgPj4gJHNl
cXJlcy5mdWxsDQo+ICskQlRSRlNfVVRJTF9QUk9HIGJhbGFuY2Ugc3RhcnQgLS1mdWxsLWJhbGFu
Y2UgJFNDUkFUQ0hfTU5UID4+ICRzZXFyZXMuZnVsbA0KPiArDQo+ICsjIENoZWNrIHRoYXQgYm90
aCBTeXN0ZW0gYW5kIE1ldGFkYXRhIGFyZSBiYWNrIHRvIHRoZSBEVVAgcHJvZmlsZQ0KPiArJEJU
UkZTX1VUSUxfUFJPRyBmaWxlc3lzdGVtIGRmICRTQ1JBVENIX01OVCB8XA0KPiArCWdyZXAgLW8g
LWUgIlN5c3RlbSwgRFVQIiAtZSAiTWV0YWRhdGEsIERVUCINCj4gKw0KPiArc3RhdHVzPTANCj4g
K2V4aXQNCj4gZGlmZiAtLWdpdCBhL3Rlc3RzL2J0cmZzLzMyOS5vdXQgYi90ZXN0cy9idHJmcy8z
Mjkub3V0DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uZTQ3
YTJhNmZmMDRiDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvdGVzdHMvYnRyZnMvMzI5Lm91dA0K
PiBAQCAtMCwwICsxLDcgQEANCj4gK1FBIG91dHB1dCBjcmVhdGVkIGJ5IDMyOQ0KPiArd3JvdGUg
MTM0MjE3NzI4LzEzNDIxNzcyOCBieXRlcyBhdCBvZmZzZXQgMA0KPiArWFhYIEJ5dGVzLCBYIG9w
czsgWFg6WFg6WFguWCAoWFhYIFlZWS9zZWMgYW5kIFhYWCBvcHMvc2VjKQ0KPiArRVJST1I6IGVy
cm9yIGR1cmluZyBiYWxhbmNpbmcgJ1NDUkFUQ0hfTU5UJzogSW5wdXQvb3V0cHV0IGVycm9yDQo+
ICtUaGVyZSBtYXkgYmUgbW9yZSBpbmZvIGluIHN5c2xvZyAtIHRyeSBkbWVzZyB8IHRhaWwNCj4g
K1N5c3RlbSwgRFVQDQo+ICtNZXRhZGF0YSwgRFVQDQo=

