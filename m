Return-Path: <linux-btrfs+bounces-21152-lists+linux-btrfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /MaIOV2ieWk6yQEAu9opvQ
	(envelope-from <linux-btrfs+bounces-21152-lists+linux-btrfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 06:45:01 +0100
X-Original-To: lists+linux-btrfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CB99D377
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 06:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 33B1E300833B
	for <lists+linux-btrfs@lfdr.de>; Wed, 28 Jan 2026 05:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1992D313520;
	Wed, 28 Jan 2026 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BXBdkwjk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zn3d5fDv"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DC426B95B
	for <linux-btrfs@vger.kernel.org>; Wed, 28 Jan 2026 05:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769579097; cv=fail; b=sSmQ+eD229yuQhuObOjHzg5smQkd8f+OTCz8WsVTzFpE9/tRT+ndQXsbkvlMnMWUu8sBGwfd94oCmqZZOeStMxdr4bdIkrB5J103iuzi8MohqTmXBbg9//dDDn+/DfCf5WX95f0Iv4k+3XCg8giPKeFrbUj5SURy59cnjlRuVVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769579097; c=relaxed/simple;
	bh=7bEJcbWyqsO6iJjgpr7BBn0jVIwcgs/7hHBikegICkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z2MyIJiyLYNY2ojjbQTgMm+ZXO9+T/VVWjtBcF+Q5OoamZgH/ctcsSipHwWf/M1YFW/7G3ZRntmJne3SU1IPA/QZA1trxOdK8hE1wEsBbLfR3LUu4JlD4270xffUJospaU3kYQ+bwf7tD3bX2WaCBcPruHV62UNdQ430JwV40JQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=BXBdkwjk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=zn3d5fDv; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769579096; x=1801115096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7bEJcbWyqsO6iJjgpr7BBn0jVIwcgs/7hHBikegICkY=;
  b=BXBdkwjkoVz8CZaerIMvrvoGGUFOOhefW4SHP09W+53QyLBfxxWoXXY1
   lTPIsmUBm8wQKkiTuuU9NVALtnhu1ulg61OOIFnAymJ3pyH/bKXSP7WKZ
   pcOLE7kbohPHyvtdWopBwGr3QLPU9GIwn61vxfj4XpFzHl+g1vicfpM5m
   d2V0tdDw6v8SkD7+rL2cxtGkYh8iFs5ofSRV5i21TLz+HVJDaACDohS9/
   lhHGIyz6rvExXZ8w86tzOwcxhY7p0Oc9Hd+jvDjkuT3ZKrvfz35v3Y1gK
   GJeEnYCn4pwOoL3RmZX1jYa3XJCXn3HUg9l3zASFsmi0z9H45r39Vh1ZG
   g==;
X-CSE-ConnectionGUID: PgVj/Q1xQjenMrQZsQ44NA==
X-CSE-MsgGUID: lwvU4B+7Q+WM1l6hvRE/Pw==
X-IronPort-AV: E=Sophos;i="6.21,258,1763395200"; 
   d="scan'208";a="139612359"
Received: from mail-westcentralusazon11013031.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.31])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Jan 2026 13:44:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNhFgsJfQJYko6pxEUEfQUwc+OPQwLvZFROmb82bOxPNS6x7Qk1VQksbe413tGSmhhbJayWT0SLlRysFKmsCKhlMCG//iNWR/voJDs9hcR+pIacV6CEXBBYOrfmzUmfh5IzrjWVDfo/yK2sHQFXTKqQsVeM5+WbRc+7ogm4UfwIgDQdjJ6V10mxCignjVZUBRdjgbegXqfIUtbtaaB+Nj3I61fAVsPgkfxnBsHMZWigICOnhnV1ZSbh8BqUn3QwaNG+kJno+AAKPZHgcHOqC/DHvxA42bPC0jTwb1whUO16SRhJIUXAa1YTIgdLWNog1cthfPTNoy0B+OCYUldswMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bEJcbWyqsO6iJjgpr7BBn0jVIwcgs/7hHBikegICkY=;
 b=vXGtxZFJ4RqJC4idxWyuTYgtxRf809RUbz5igKr8KrZwtVQQxainNuImbhVjdR+UW50m6a0yk8A2oQnP3QSn1wxDnJ40Bo2d/q/oQJs/z762ottkMoUMft/e7HKFAZap6+Txd4j0nSLxgUdvY4vc/HEZJ0O/uJcyQGFWMZ5dL8DU1rPajG7O+UMCenoVMrmUNufWohXoIAquWvjCKsCjGAekhZUO+czebiTjd7XF3owJcFpNmfY2l8O/1PmzAeORMjulZZUZOuyYYKLxGq1+eVK27EJW2kue685BkGfFoviks7nrh3uHqaVWSVRFWfDZzb0aEtUG1Q7AeGN9W4u0hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bEJcbWyqsO6iJjgpr7BBn0jVIwcgs/7hHBikegICkY=;
 b=zn3d5fDvCVi/YOT/z4gdPy449TO6w3BmX/HvSox2fdc3X6ht6NERiRyFw+rXKIgedQBijykfdXeoOrS02keBzM1NPkiGJU9SZ+Vxlpvu1aSNIQSeDrtqnP1PcZHMyHDWwFD0xdI/L12tXvTP3povaypTBCt0eu3RHLl71C5kcgU=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by SJ0PR04MB7774.namprd04.prod.outlook.com (2603:10b6:a03:303::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Wed, 28 Jan
 2026 05:44:18 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a%5]) with mapi id 15.20.9564.006; Wed, 28 Jan 2026
 05:44:18 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: use local fs_info variable in
 btrfs_load_block_group_dup
Thread-Topic: [PATCH] btrfs: zoned: use local fs_info variable in
 btrfs_load_block_group_dup
Thread-Index: AQHcjEBYIIgXohCLH0iKkzgm3SVuKLVnGceA
Date: Wed, 28 Jan 2026 05:44:18 +0000
Message-ID: <DFZZF8ITSFTT.SSYQ213RQPFB@wdc.com>
References: <20260123081444.474025-1-johannes.thumshirn@wdc.com>
In-Reply-To: <20260123081444.474025-1-johannes.thumshirn@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|SJ0PR04MB7774:EE_
x-ms-office365-filtering-correlation-id: 81a50692-4829-45f7-fd68-08de5e30477d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?MlNEczBJSkxTQkVHdHdIZWViTGlDUUtaaG4rTHlLOEhZZjZ5VzdDTWRHTzBM?=
 =?utf-8?B?dTFhUVQ2bEdTNGxlbVg1b3MwVjlCZ1haKzIyREI1eHNNWXlOYVR0VzIwQzhp?=
 =?utf-8?B?K21NYnB2b21JcW84ZXNmeS9WRzVJSkxCalByOVBXNzIvRnZlNFJKYW5mVnNM?=
 =?utf-8?B?MTlGNlpoZU90NVRZR0xDN0xIN25HclUrL2pHcHFCaHFreC91aXhML0c2ZWU3?=
 =?utf-8?B?Y09NOGZ4UVNCUTZkV3FDcnlOWVpsSGpRRzlHRDcrUzFIQy9DMzBaVVJ6VHZi?=
 =?utf-8?B?TjdMbXVmeGV5dHlTeERMK2xZcTErSWNEcVVRVERtcGdQbW5aeGdTK3ZMMnBH?=
 =?utf-8?B?TDNIYU1ZYVdjb0lBMENMNnpXcE5uUUZiRWhrckE0VnFVUDZMOGJiS2NtU3pr?=
 =?utf-8?B?UTY0bDhYaU1LZWJyNy85V0Uzdm5mc3l1azVFWnZCS1U0L3ovL2tTUkhpVVJJ?=
 =?utf-8?B?VzU1MFQwWG04TjNYcTZqQ21ISE9Udzl2R2VFOFQwZlc0Vjh2L00vcGIyOFNC?=
 =?utf-8?B?b1N5T2oramhXeVk2ejQxZGhUSm5BRzFTKzlTQzU3MVg5YUJYNU4wWm1DTmlM?=
 =?utf-8?B?SDVSRmVnN1FCWldrbWVQTUE5RlNIQ2xPL0FyMDhwWEpWNXlVMFRRMVluc2Q3?=
 =?utf-8?B?RHpCMmN4S0NOQ0pzbmpoQlc3ZHhOSGg0Yzg3YVlQVWpNRGlWbGhqVjF3bGNX?=
 =?utf-8?B?a293bVlqT2RHU1ByOXhCaTNuS3JZOXpqYThVSUdZMTVuSlNJeUdiNUxIUUNU?=
 =?utf-8?B?UytUZHFSSGhhVElITDhTbEp3K2lOakdXekVvdDVQb1NvNS9LNFRkNCtHTmxt?=
 =?utf-8?B?TVRDMjVUMERCeE1Ub1VKL2o2emFJZlBFdFY0Mm53cENhdzlTN2l4N0M4UHEy?=
 =?utf-8?B?WHhVQWVSRmhINHg5MHpjTE9DRFRGeCtqVE45QWg2UmdIL0hQTzJtSE8zY01y?=
 =?utf-8?B?TDVQYjNyaU9idmRKeXNpcHlZR1JNSEpqQVZvL2VyN0daNmc5eGttUDV5M0do?=
 =?utf-8?B?aGsyV01TWHowOEFOR0tGRUFkM0k5NFBwMmxFeTE0RUhHc092UWlVWXBTVndW?=
 =?utf-8?B?MjR3TFpWVTAwSUtwRU1RTENGb1FqZ05HYkFrQ1BzOWJXWFd5NjgwbGpueEZL?=
 =?utf-8?B?c1MwbmV6N1lOa0FmcDBrdFNFSmtlc0hUSll5SmtnZENqZ2xRTXJWVGhoZE1N?=
 =?utf-8?B?bTNyd2UvZGVBaXFjbEJxY0JtSXBQZ2xROGdZK2tZUUNqZ1hHVklSZDh1UENZ?=
 =?utf-8?B?SHRzakpSbG82L0k5R294VXFnM2ZsTGJvSGtDc015YUF4eDUwditsY1gyWWJ4?=
 =?utf-8?B?T09DYlRUWFNGUGt2SjNkU3VSQTFjR1VyRjBJY1pVS1JyMEs0YjhVUlJVWSth?=
 =?utf-8?B?TU1aQU5mUDJheUlZeWhiMnNucW9RdFhnYmFqdW1jZmdyMlRlaWsyWkNtKzkz?=
 =?utf-8?B?c1JBRUp5OGhNRC80RXRJaDlqc2RaYWpzM29uU3Y5SkFoblBGYVlDdVRrQmhD?=
 =?utf-8?B?NTVEQzk0VWpVTXJIWk43KzdSVDB1SE1obnhpM0tBZVpwQzlHWEVDb1BkK1hN?=
 =?utf-8?B?WlJhZFhhMTVuR1JWYlJ5TlRjZlNKTXpUSUFERVo5Y0FuTnB2MUt6d2FVcjda?=
 =?utf-8?B?dkJ3ZmpVYUVFRU1RNElweXgvcjlaTlliejB5SGQrL0NVbmxIWGY2T0Z6RlBk?=
 =?utf-8?B?K0FYd2xqRWxRR2gyVU1obnZTcFIwQmlNUDVWZHhvL0d3ZnhrSDBkTk83bDhC?=
 =?utf-8?B?ZVVpVktrV1pVanFjM0k3OW1RdVByelNoVFlnOTFPZXNaWFluQVRETlVJbk5o?=
 =?utf-8?B?dEQ4OWNBaEUzZVVGNmJzRmg2dm0wOUxRZUFlZ2xWRitzOXA4d3QxOEZETm15?=
 =?utf-8?B?ZExBL0laTzhuMUFDZFZjNVBmd2tMcHllUS9GMVp6dkROb1RVaHhMVTc3ZWxI?=
 =?utf-8?B?SmZBVWlFN3k5R1NWWDJJNU5FcmNZWTJRMjQxM0liN3Y4M2pDRG10K3pXZ1Rj?=
 =?utf-8?B?T2thNHVyL3ZRUVVNV1N2TktrTUZIYy9jUUZNWGZLbFVsMm9HNlhjUFd1ZFoy?=
 =?utf-8?B?a2I4T3ptRmNYTXYyOC9mSksvZmh4em9QamNSbFFWdjBGOXAvL0xkQXNPRjBq?=
 =?utf-8?B?K2p5eXBKUDFwYjAwdGkyeTdHODNFZ05hRmI2Qjg4aVU2Rkg0N1ZUbnByaHJE?=
 =?utf-8?Q?Sg6wp3xnN7+FbMN2x3uASTc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UW53SVZtSG1nWkN4UWZiY1JhSW81YkZQQWdzSlJheW1EVG1nRHhNeVdvU1lG?=
 =?utf-8?B?Q2Qxc0sxYjVkbHc1ZjBlK095YlNSNEx0L2RhbXo0ZkZSQm1BUmRITStQUlJq?=
 =?utf-8?B?UVNadzBWR29BT1U4dlhFYzE5SHJsRStKMWNCdXZ2ZVZrdWxSQURwNFJ4c3dQ?=
 =?utf-8?B?c1l1ZHQxZ1FmY0RZL1BJaWdTYVE5bjR3MTZvUDJJdzZuTFBsRzdMdjdmbFRp?=
 =?utf-8?B?SnpIeFNnYWVhZkd1YWlId3NaOUtZd0Z4ck1rdzNLVEJORm92Y1hDSGY1T1FK?=
 =?utf-8?B?bDZqL2J1RDhHMUNyeWw3cXJmNnJUWUMzc3F2Um1DM2cxZURRSERtT3d2SVo0?=
 =?utf-8?B?M2poZ09lUHJ2MmhHV3RFNDRWOS82eGNkSmtwWHhlTmgvR1VlZGhDYU5FZGVL?=
 =?utf-8?B?WFM4aWFxdnVRS1ZJQVJpdU5LRzZyZ3JncC9TWDl4N2p2YXl2Tkl2V0FVcmVI?=
 =?utf-8?B?SHZKV1RLd3Nabk5aR002a0NoWlNieWJ6YzF2RHlwSmk3V0RRQ1RLMUl4ZUZE?=
 =?utf-8?B?QkNwdmcyQVdKQXgrNkRRejBFdDZPSmtKUE1ZajV0WitJUGFTR0ZvZkVVRE1T?=
 =?utf-8?B?MTVrWEZTalVObDFWMXJ4cFZETDFCdTdLd3FGK2ZxYjRlSVJRckwxWFk4d3Mv?=
 =?utf-8?B?SWVTSCtJL1pONzNWV0x6RW0rZXFkZkdwa0NOOHcyb2k0V3lRbnkvMkxjbFE3?=
 =?utf-8?B?MWhta2xaMnJ1cGk2eGlqMk9tY2t5alJHM2VRM3Q5amxHL3E5SzZLeXE4UVZh?=
 =?utf-8?B?bUhRVnd2S3RMOEd6Q0djTk80eXFuWHJVeW9DR3JtL2llalY2NW5CNmVUZ2ZX?=
 =?utf-8?B?YmlvcnZReE1talNJMVlzOFgwNEcwME10dlhMeXJJWjg3eTFia2NrclR6YWVJ?=
 =?utf-8?B?VnRnck42T2tERkRiaUNuZkRaOFBud2l6NDIxQ0VJQ3RFZ0d0RkxwemozN210?=
 =?utf-8?B?S1UxRGtiUmFZdnU0ZWgrcVdtN0JXeDNmMW9tTDMxZHpJUHk1ZkovM1o4NGxQ?=
 =?utf-8?B?b29WWFJGbkNlTXF4ZnViZUFvNFI5YkpDRE4wbVpMalVHQktSTGR1bXRobWVP?=
 =?utf-8?B?bTNBQUsxenVVTDd0Vk85citaWklRc3NUSmtlZXpxeVBNSnE2bFNWU1NvWDFZ?=
 =?utf-8?B?REtDcDBKUXZja3JWRXMyWTJ0ayt4d1V2Mi9xeGk4aHhOdzhyNExwYnEzUE9j?=
 =?utf-8?B?Q2pLQ1JJS0J5VXFvdm5HaE9Hc212QXo0NlU0UGJPZmZ1aUVoRitjSjBVbXJ4?=
 =?utf-8?B?ejNLTTRzaFNRSk1pMEhZU3lnMEt2L1Z2VUI3UDVYYVYwajdmSy9tUDY4bkw2?=
 =?utf-8?B?WjdEVkwxbUF3UUdJTHRBbGtCVWxUaWsra3JpemdOcHAxYVVabk9aaWg1SHNT?=
 =?utf-8?B?YmRGRnYwaHo5UHVGNFpEbzFtYktwV25SSkNObGFSK2dLNkRuUCs1cnBHeUNC?=
 =?utf-8?B?N1FMRXlCYmRzUUFBanBYT0FhOTRVVE1wYmZPcUtsdER0TWd2cUpkdG1iYTFz?=
 =?utf-8?B?RUlRdERaOGdtS2dZSU4xbUhOaDNWTnJKcXBFWDZ1ci9Ca0dINHo1R0hBVjlB?=
 =?utf-8?B?NlBsMFc4VEpEQ1JacVo4SUt0bzZRcHJzcDlUeE5LNHZqNUZXdXpyV3Q2aC9v?=
 =?utf-8?B?VTQrVTNZNHN1R1pBTjIrdDhaVlJMQTNYcFppTXQwbWt5dFlSNmVJYXFjYzBV?=
 =?utf-8?B?QkkyTXVWQWRyV0tDT1dtT1c1UWVtVCtScEt6YzhEa1ZnR25mL0k2a0tDb2FL?=
 =?utf-8?B?ZFFCUXhEYzhmZ2MvMzVDOXVDelhpckl0K1lYVjJSMEFKTklwU2ZEQjNzeEtZ?=
 =?utf-8?B?cTdaalZPMkdUaXN6MG5VTWpPYktSWDFpN1pmeFc2YmZZcE1lQ3BQSGNWMm1i?=
 =?utf-8?B?cHdkTXB5MmtBOFNNWTZyYW00L2NiRTNCelpxekRQaUoxbjRicXVQQ0JnQnYx?=
 =?utf-8?B?aVlsVUJsYmMzWUdRLzU3NG42WEc0WjVacU1SNHc2b3ZYYkc2cHdZOERRTXg1?=
 =?utf-8?B?dS8vYnRMdGJKRjVvaHluSVRFczBIWUl1OGZkUWtBcUh2cVpHMVRZREtqcjM5?=
 =?utf-8?B?eE1YaTVTTjRBaDQ2Um5jRXpHNWlmaENiVzZHOFJKTnd5UTdGV0l4SUpzOEpV?=
 =?utf-8?B?Qm1sR080RFJMcEZSWVltK2hVckk0ZmJ5M09VU3dBQmVBZDRWS3VPNmRzTFpv?=
 =?utf-8?B?emlHWmhHMnI3U0s1M0lBNTZIYTkwOFB5Z2luQkt0L1dEWHVlWVRoUFlhMlZX?=
 =?utf-8?B?RERXWnBFR2l3MGQxbFdNK1RoRnY4aVM3UVN0V3lrQ1EvNUlHRkFsN2h0enU2?=
 =?utf-8?B?WFRGSFFNZTlVWTQwa090OFdRb3VDbVdtMmRUOHFsdlhQNUkrYzVQZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A1D2C11C333B24EB8F387342FC99764@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QM4v4C/Pjr0994jolbGZNMFdMJEHLXvLBYB5XqiJUOGL1af5i2qVBmzuyxXi/wyY5eVkoYzAN6lZ5KbHfhlr5WagMx8868Rz45MI1g2+gdsOFHVrzLXRZpRjLIezAGNQUtFvdqd9afUj9rR18mfddvlE+9uIR+tAlEC2A1CNHNYRxXaUqoT0AX+mTBfEnNvGQC6qxbAkDjvZfNa0dugoqL2MCIQLfKDglaLeQT/+HmzUQtCuvew/tZaD0dDQqux2Zqln292D3Vku75uA5548lFJnydaFzwLGL+jAZRTyZovktRs3ei3JJeHbxh9tCh3ZGJawTV+H+9Biw0/E8IBeVSFDd7LwN5SughGwlsskEY3gZMrghk9kDABrAGYgDj8gphalhvHEFVU8uLhwuFvurrHGrqr/HlQHLvxVCqOFf6Vo9dqGqtMBxQpEoDs9EVDM/Ab7ympx8MoHTaKaH6aUw75gD4DWn+ay1HJ5FTXj/suJwaoCrutMo/aAAyHJtbMPitSa02fHAoL5RwDa5kKMEoX+3qp0QoFcw6+pL0ArZ2gBT4yYq/K/imsmiajl+2Y5xPXNhUmsNJylQ49oZx+5c/2LSIg+5T+bOoUt5gQ6ZbNnLpUOzOok6sZLfDtqyFWJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a50692-4829-45f7-fd68-08de5e30477d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2026 05:44:18.3842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tkxp/kNXYUxVO+0MUJe54bSqF/XKWjj5vT3m3a9ShXFY+oclwor6gcp5PLzPk/iqpA1UE8H6SLUmN722IwXCxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7774
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21152-lists,linux-btrfs=lfdr.de];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Naohiro.Aota@wdc.com,linux-btrfs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-btrfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Queue-Id: 63CB99D377
X-Rspamd-Action: no action

T24gRnJpIEphbiAyMywgMjAyNiBhdCA1OjE0IFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBidHJmc19sb2FkX2Jsb2NrX2dyb3VwX2R1cCgpIGhhcyBhIGxvY2FsIHBvaW50ZXIg
dG8gZnNfaW5mbywgeWV0IHRoZQ0KPiBlcnJvciBwcmludHMgZGVyZWZlcmVuY2UgZnNfaW5mbyBm
cm9tIHRoZSBibG9ja19ncm91cC4NCj4NCj4gVXNlIGxvY2FsIGZzX2luZm8gdmFyaWFibGUgdG8g
bWFrZSB0aGUgY29kZSBtb3JlIHVuaWZvcm0uDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVz
IFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQoNCkxvb2tzIGdvb2QuDQoN
ClJldmlld2VkLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hpcm8uYW90YUB3ZGMuY29tPg==

