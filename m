Return-Path: <linux-btrfs+bounces-14914-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEDEAE668F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 15:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF191BC4B3F
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Jun 2025 13:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92262D2386;
	Tue, 24 Jun 2025 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iPf4WcMb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NsLWcEge"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13842BF3CA
	for <linux-btrfs@vger.kernel.org>; Tue, 24 Jun 2025 13:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750771803; cv=fail; b=d0JXt14hxjVkTDhtRK85SD3cVt2Y41wlLreHXS8yOM/DYMN6lJNFfE6R02kdJgqRtYKINy/iy1ccfZPureVdhsjZLibifA57QPllWrsFTAz+n4ZZ2t9+hYvsd6PmzM9uGAgjK6bKh/izEVMqQ5gN1zIHVLfOKgdUWE1HWKeFWcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750771803; c=relaxed/simple;
	bh=GJjBKGq0gO8AKHQG1B0EfDK++KSZk+ooib/VrnLg8os=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MbB12MdwrNgBfYgUrA0hdW0VtJJ1d6U0opZ0uHtOibxO/ZXHOzNUfurcQ42g+v6XhrqG3ZDlGl+vjmZiBVoVymRBg5c8BuX/FpVmPyPAAu59iNtl/ly7hFXwG1f8NMj21FY3xrmx8lMGUqn4JOH/lQoEw+mcpRq1C8o5/OMLq5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iPf4WcMb; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NsLWcEge; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750771801; x=1782307801;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=GJjBKGq0gO8AKHQG1B0EfDK++KSZk+ooib/VrnLg8os=;
  b=iPf4WcMbIJm7ysEsQhPAPcA3APoiDyi4dE7ZqSKCYX0IdUJjiQCwdSNc
   1Mhy0uNvsQE1GS05Bw4VPYohUT2+cWLX0bi1H8ewe/vz5Q2udq9LSRVyC
   Pyrjn396wx1RWh0t8xEPDkh5w0M+eJ/RrxpslQZbMaMRqgX4SvhmH0311
   G4+5HszZPsukNKrjluDSMTfdIdxpcMjTLK2Sk1a0cxkw9Eq/Uq4TkMb0s
   FGOq/9bwEvbUGZMGP/O7c6DH9HSLRq05QyuIX3APnjdBmjUw75j+FnANq
   13EwVzle5cLl932a1LvMdDC2/w4xZ4Ala4EMGKgWcw3yizuwnGFANjRVj
   Q==;
X-CSE-ConnectionGUID: qnTz3AblRqC8zORG8Q8OSg==
X-CSE-MsgGUID: JdmlMg0JTkmasdkXw8uHiQ==
X-IronPort-AV: E=Sophos;i="6.16,261,1744041600"; 
   d="scan'208";a="84627966"
Received: from mail-co1nam11on2050.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([40.107.220.50])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jun 2025 21:30:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKT3EJiM1h6Xgc5znbKsBmxdewiJeJSvPYzefKRtKZnPDWBN/yW1AXk8+1FqtQcXY72c8uU0VcjuB0CGL22+a7LwJPiLnSTZPgseA8sI5Y5Kf2TG98E21oZmK5o5iytFewnQDhW3Tn7mNVN+zCK4eM1XbCjJiFXP6h7BuFj8kN3eBfBeXFu5DMweLuU1GKkYbOPJPfCttykO2Kc7LVgUMPyJ3If+6Wo2fEbZyEHWZywWlxVgt+CFIkVk9ZfdjXS024IvH7cTIqXodl+dHFOgcXmKgVfNYIpbTvxzHKXm7yd2VDAuhZMq29sV2TYoWUdtv5ztkmNEx9l+MrP3TqSxFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJjBKGq0gO8AKHQG1B0EfDK++KSZk+ooib/VrnLg8os=;
 b=Dz2j2O7PsDVbJe3uIMwg04+Bs4du0G2/IxqvIRUqyZcwi62OXTPRQTQjkN5k/ZkL1SKo4MS/iT9Su40amK8UMfeKCP58CKiE7ddmHuAhLPK7Rl2qyw1HhpEK8QNl9BmaO83S1TzOcBVUv0DGZf84blU3BUSzYKkjNsgUCiDf0D2GUxNqMyQmfaykx+Y++a7bbmuauumLk1HSUQrm7jzj00dVaJKAvcX91Rh8aJKVVaZe9p4QqOfCwqLcGESUlvPWIoe3dwjjf0djuSQ5bXhVz3ogml2mNvWHuALbcDl4dLGXmsco6yNttGma6LVrmC4ThoBdAIi6/yud7DLk+A1rwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJjBKGq0gO8AKHQG1B0EfDK++KSZk+ooib/VrnLg8os=;
 b=NsLWcEgeYdX+sAhQ0vPO8ylfNuH0iL6nr0hPhZ6nCnXpP88CEFvLli1gpNZiMBAbiEByUMR8ZWUso4/nGdETvX8JounHJP2EREjuAS1vQReadys0Ql4UJ6C8uM2ZU7692UU/f0PP7DuxD881NRV1U5C3sTU40SDwjcxSiU6Aocw=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA1PR04MB8853.namprd04.prod.outlook.com (2603:10b6:806:383::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 13:29:59 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8857.016; Tue, 24 Jun 2025
 13:29:59 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix a stupid bug masked by CONFIG_BTRFS_DEBUG
Thread-Topic: [PATCH] btrfs: fix a stupid bug masked by CONFIG_BTRFS_DEBUG
Thread-Index: AQHb5NI9ofPHfRwobkyg/ZN3fP0vorQSToQA
Date: Tue, 24 Jun 2025 13:29:58 +0000
Message-ID: <DAUST0RXUM9H.3ORVRVN7V3A4O@wdc.com>
References:
 <9b16023e2cb31b509405dd5525bbd5d19a2f384b.1750746917.git.wqu@suse.com>
In-Reply-To:
 <9b16023e2cb31b509405dd5525bbd5d19a2f384b.1750746917.git.wqu@suse.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA1PR04MB8853:EE_
x-ms-office365-filtering-correlation-id: 80b0695c-99d0-4f4c-a76f-08ddb3233757
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?T1M3TFBLZzM0ZjN0NzVLZHNDWWlkVDlCWC9EK1VreHNyWitFR3lnaitRN05t?=
 =?utf-8?B?NGtHeGxzbHVUZkM2cnZhTlI2SlhLbElrdTFtMGxoMUVOUWVaQUJ1Sng0UTMw?=
 =?utf-8?B?bFo4aCtWcWp3Mkp3dFNoeElmN00vVldHTGUyMXB4N0crRytLMFNWZ1hGNUda?=
 =?utf-8?B?Ujc4T20wbXRDeXJOSlhCZkc2QVdvUWNTRGl0c04yWWJ0ZjBBbXRpN3pTVjVo?=
 =?utf-8?B?Rmc4SFc5c09CSXEyWGJsOXVkWXdGcUZDQTJEOVJwek5rTTkvM2FvYzdvcFZx?=
 =?utf-8?B?TUJMN0xMMnp5cWdiZW5ycFM4ZkhlY0sxejJ2T2tmeXFXVXQ2OElqZHYzb0cz?=
 =?utf-8?B?SkFtNGREMEJ4YWdqOU5haU11am9ZekJiV01DQldMdmVUbVlpYzE4Vnh5VGZj?=
 =?utf-8?B?RGovc1VzYm42cGFWTHBuM2dZYjhTdzBnRHNGaUpOODd1ek5XenVhWWszT0xO?=
 =?utf-8?B?bWpYYTU5emdvUXJ2Q1BDYktLaTB0U3k5NmVMOXlMaEpGM0NvcDNacndjUlhU?=
 =?utf-8?B?YXd6ejFQZHhBdmpTTksxbkdYT0hCcnRrdTN1ZTZtVnBQYm9sZC9iamFYMGZS?=
 =?utf-8?B?NFFQK092Z29KaDRIaE9vUXZLeFpXdGlEcXhYVEhSVEluU1hrUE5DTmw1S2FD?=
 =?utf-8?B?cTZlaGhkcmZGNnNiaHp4VkNvTDFkaUdTM3ZKRDJ1dXdicUdHWjh5T2RWT2NQ?=
 =?utf-8?B?c1ZEbE11ajd6WDZGWEVHZllmaXlEWEZReWRjWkxOSjJQMFlmZmJOVHJ1OHNj?=
 =?utf-8?B?ZG1lTkNHd1BiRW95cXU3czA2cDB5Z3hBbDJoV0dGV1lPdTUzWEhTNHpTT1Fw?=
 =?utf-8?B?WW1NaCs4eWxnblNzUjlGeUR3TkVnZWUwQUtRRlVDVW5HUlVuZnphSFhyNHpS?=
 =?utf-8?B?TDhoTHIwUmJOZ3dkQ1ZKdlFxMHB1eW1jMlRPejdwRzdEcHd5dE15QlNmK0Vr?=
 =?utf-8?B?REcrbTd3cDA4V3RhOVV2REpkZ1pZcjZrblRacHlTU2N5d1lxejBSOEVodXVL?=
 =?utf-8?B?UG85bm9XbGQyaG9tZnU3NytGTmsvZVRCU1kzMFNwWkFxL2VJQTFianEwN1V4?=
 =?utf-8?B?cytSTDVtcVZiNEhMTno1aU8ycWRaaE1DTldYb0lUeUJxTEZXREQxR3ZBTkFw?=
 =?utf-8?B?NFpIRGVHSnFJek52dml3MnovWW1RbkVaeTcwZ01laGI1Y2NnWHM4cS9SYkRY?=
 =?utf-8?B?VlVwMUhMSjNrTWVnNmdQMHZoalUybW1TYndnQ0lSZDNRZlVhYjZNbFZkOVcx?=
 =?utf-8?B?OG9tTi8yenJGUTA0OUE1cjV0aDBDY0NXQ2k2T2E2SE1DUWFObGxlOFRwMFEr?=
 =?utf-8?B?WWtMNjVTOFpRZ0d2TzJINGlwMTA2eXY0cG05VmhSL2puVllrOVI0dXBaeUhi?=
 =?utf-8?B?RHFrUzNkYnFUdmQxOGNZUUNkMGdlUEdObVdFZEw0K0NBN3NUTUdvOEIzaWlR?=
 =?utf-8?B?Z2ZQbFlBenY0Ry9KZWowUnY4VHJCdHZHSGtNMElOL0cxZW0zMTRXdjlMUjI2?=
 =?utf-8?B?dzhiRWliZXY1YmJvMVFRUXZndXFKMVBhQUVyTlNSckE3TmxwaGxNUkFqTE1t?=
 =?utf-8?B?clhLRExmcWswbFlob0pqY1RKaURJcE1JbUtOdDNSZUE0Q0VvMWx6a2RSQWV5?=
 =?utf-8?B?cW10Zzg0TzIwclBBUXlwUjIvRGNzTmdTbnphT09KMUtOMkpDUC9wRXJva0tt?=
 =?utf-8?B?TmxFYXYrV2tWRGR4UmhpMlUrVHFycTJZcGtzK0hFREdDWGsxQzhUUVp0M2xI?=
 =?utf-8?B?cnIzcjFsL2xvbUYyRzZ6L0VPNFJ3M1dCeTErcmgxRXc0TmRXdXp4ejJrN0Nk?=
 =?utf-8?B?cG8ydlNWbVA0eURFaXFVRmxIakRMNVJBQWRsaUJ3QUFUdDV4cGd2VkQzQVlC?=
 =?utf-8?B?WEt2OGcwZmFmVHMrZ0J4RzZETjVxSTU4MTNsTVZYalR0dG4zSWlucU94Vkda?=
 =?utf-8?B?Ymo1NkdYWkNyMU02eXN2d2FRSllJK2kwU3JSdUZFUndqbCtJZVE3bjN1RFUv?=
 =?utf-8?B?bHhhVkgvQUh3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1ovYlVyQlF3Ky9EUW9zdzJTb0EzaVp6bklqV3Z4OEdjVGtLRndMQS8rOEZq?=
 =?utf-8?B?UFFXT1d4d3UwaVJsT0pGRThzalFPUHVHL2hzKzlTN1VPWG9UTWVUaDlhN2xV?=
 =?utf-8?B?VEE1NE8vVUdDVjhTL2N0RmRqRE9rUCs1SWNTSFBSNGV4RW82eWY2Ukt1bUNo?=
 =?utf-8?B?UDdqYmM1VWF2aFd6em9pb1BuMHJIRWVpOFhoWGpjMlU5Q09Qc09zNjRCY1RF?=
 =?utf-8?B?VjF1eWdXTWFEakUrWHB5eG8vLzkvTHhhQXN1S1BUT1dNL1ZFVjVQTTI0MzZa?=
 =?utf-8?B?UU1LQ2xKNFVERExzWEZUOWsreStvZ3ZUVVUvc2podzl0Uk5FQjZsdzFJQjBQ?=
 =?utf-8?B?RlhJNWwzZVYrTU4ydHdUdk9RNmw4NzZ1REE4Tkg3T3RUM0JMTGpCVVNHZ0s2?=
 =?utf-8?B?c09BM0djMWNFRldNSVpzS2F6b21ENjZ2SS93WUE2YlowRTYyNDFPTTF0TVlM?=
 =?utf-8?B?R3h4UkRNN2RJU0p0bDlSTHhRWkdVMWlnODZpYWpjOXB5ZmxzaGd4QWxhOVh6?=
 =?utf-8?B?Y2N0TmJlYWl3eE9JeDMzSmdpc2dDdmVXQWRTRWg3UjdRTWRUbjVSRGU2bXNB?=
 =?utf-8?B?TVRBdzBYaWxCVU9pTE5IMGlzeHlTRG5GRi9FRVNXbml0NVhJeVNEWTZkc3pI?=
 =?utf-8?B?NnBtNzlwTVk1YmQ3NlM0ZG5oLzBJbTFvdHlnTFRGd29rMS9wRE1PaUN4aTY2?=
 =?utf-8?B?dUhHSzBGbjk0ZFpXcG9pWmR0T3RvMXdQWFVJTHpVNFMyV1lXWDJ6UnRPVDVj?=
 =?utf-8?B?cHFsZVdzdFJVTnA3dVBPbVlIUEpwT014dTFwQlRkdW9LT0xQQWs1T1paU2xw?=
 =?utf-8?B?MC9sSVdEUi9xdUFEVlladzB4RE1ObFdCR3h5WkVLVE5OdEhoa2hKMFA3U1px?=
 =?utf-8?B?cDcwU0t2bndIbDNWTStaNDRaa09OSjIya0lMK0pUM0MvWXpYK1Q2OTl0Tkcr?=
 =?utf-8?B?YTBWNmZ2K1hQT1BYU3hodmdEVmJKZW9aYUc1UEFJdEJhMWJBdkhuc3NLR2xj?=
 =?utf-8?B?eVVPaHdEZ1h4YUEwc3djQk9lMUdGcFBySDEzNHE1VlFkczc3RU80eHFKMzVJ?=
 =?utf-8?B?N1A1MWF2Zk0vZEZmc2xUY2lVK1JUTXNFaUo2clNHY2hUdTVmajZ4cGtxYnEv?=
 =?utf-8?B?bWh0R002ZlFMZkRBMzV0Y0kyRVFpZjdmcWx3TWpGVi8zQ0l2KzNlTWtoRDdx?=
 =?utf-8?B?S2h2bWI3M0diOWJhZlVLWUVMMElUcXJHejkvZmVIM2M1QURUKy9la1ViNUdj?=
 =?utf-8?B?UjJYNHZpYjlwTkVCdnFjd3l4ekJKbHpRcnEwVmtLc2JnMi9iVis4L1NhTy9M?=
 =?utf-8?B?NThwVXdRRzRwamNWUy9nWHRVV0grdzBSc045S0tNaTR4enE0bDdFVi9mTFp5?=
 =?utf-8?B?em5UVUhmSFB5N3A2YlplaFkwRTE3UUk1cW1wQzI0ZWk0dlhsQVdKY1hITnFM?=
 =?utf-8?B?ZFFuS2V0M0xHeHNYQTVxaDA4Qi83R3pURjE2YzNYMzhSWm1wWWh3SGRGcTlz?=
 =?utf-8?B?cmZlMzZhK2xWTE14MUJVTnM5UkhGQUMvdUp1ZHRKSkMxeVhTdXlUbWxsVVhl?=
 =?utf-8?B?TDNQdnZiQW00eG5pZHVoWkpiRUM4LzRkVFF0Um1pczBpaE1PMWtETENBcTBh?=
 =?utf-8?B?bGZzWmpIbUk0NXJGcVRFTUlHMDlVMEQrSnUwTTNMcWxOR0wyTTdsamxCZkRW?=
 =?utf-8?B?UzRJNGkyeFlSdWJzaThta0tJNDVRUFFCc3dmQ3pWYzFac2lhOWdtNGRvQVVU?=
 =?utf-8?B?eDQ3dTRXUzRnVktwR25UTXZ3UDdDL2hyTEw5aXd4RkRvRGF1dnltc2pDcG5k?=
 =?utf-8?B?bk9relBjcWxrUWpSZFVONGM0b1AyQjdWUnJBNmVZNEhDK2ZNMDE4QmZ0VzBt?=
 =?utf-8?B?elNGREdPQXozYnY0Wk9aYlVmakxiVnlPOWVmZHBMN25xUFhzT3JnQkdSR0ti?=
 =?utf-8?B?Z1gwZzBuTnM1UFkrRFRTTlVzeFUwSEtaeWt3OXNLK2U2RnVjQ1dwZUpBWDE4?=
 =?utf-8?B?WHBSU1EvN0FaemZCRjdUYUROTW1ONVh6UE1JQmloTldCcjVockkzS01qaDhF?=
 =?utf-8?B?OHExalhJcG9OT2s0bzFvd0t4M1RJTVF2Nzk5WnpPM2ppV0RrLzQ0TUx0eGhV?=
 =?utf-8?B?eXdoUnN2NkpiNmhjcEtiYVIzUXkxbXViVWZPalRsejhGczRXdkFpSzFpSzVs?=
 =?utf-8?B?Smc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A93197589815441A9C07DC76D9832BE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2BHGJeL2BTIIvFgjVlz1yqRH3w0uCwBSuVjEljJg+1WRPF9WrIK+P7nIls9uVit5pPZf8UYCAVFPzhJpP0FodskZ6K8yI1cLcQ6HW54STT8D3y/3yJKkFYHB5aDNrWdEuGnJoGIJZcQA6DpCgufUtLC4qry2HS9XPOD7K84xJcXJ63JPuqGK4d6L6TqGMjgzFyoVVoABw6yPO8j+dkcQjo7rkN50Uo6tQ4x4Wnmzh5kjQk6/TQNg0y0uPV4ycj30WUzvNSkQzg1V9xWp1Pj26Qtcm6RSM4aIQGK7Q7C+DWvyilqU1FWDGdU8tOX/uWVw2+YORYnHRHuTqnIJLjjC+1HzgWk8/g/haRdgfvwgnw28fpoGxnIKqF0UMQEd0Bz5hB6HOXowNGE8XN4r7EQw6iHE3d+ABKMJ6cr04I7kNTxOxNcBu47uIMIBhEB8j73ogSmADvQDRngnVQiVQpTkocruzyJomMDRIwx2Vo+lqDKJIskjDPg7joTt2BKtE2ZVDm6O2Ye1Ak27+gXS9Muc7KfZkSQEg+21GdJfGd4RDWcqy86z49ExYdXE0+cAtUQOvU2+shw2/DkXrlcP6A3mY+L26o+aZUWeagU7W49YWqwNVrsMj78KyPU77yD4gA3r
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b0695c-99d0-4f4c-a76f-08ddb3233757
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 13:29:58.9783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lma35rBW2SMphCNdnWyTy3ykoC+CSM1qfl4IT1HdkWuWW+dn8eMN3NAa4H0uZkjX/n4oqy5Qx5CyebFCf07krg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8853

T24gVHVlIEp1biAyNCwgMjAyNSBhdCAzOjM1IFBNIEpTVCwgUXUgV2VucnVvIHdyb3RlOg0KPiBb
QlVHXQ0KPiBOYW9oaXJvIHJlcG9ydGVkIGEgd2VpcmQgYnVnIHRoYXQgd2l0aCBDT05GSUdfQlRS
RlNfREVCVUc9biBhbmQNCj4gQ09ORklHX0JUUkZTX0VYUEVSSU1FTlRBTD15LCB0ZXN0IGNhc2Ug
YnRyZnMvMDA1IHdpbGwgY3Jhc2ggd2l0aCB0aGUNCj4gZm9sbG93aW5nIGNhbGwgdHJhY2U6DQo+
DQo+ICBwYWdlOiByZWZjb3VudDo1IG1hcGNvdW50OjAgbWFwcGluZzowMDAwMDAwMGE1YWU5ZWZm
IGluZGV4OjB4MWMgcGZuOjB4MTEzNjU4DQo+ICBoZWFkOiBvcmRlcjoyIG1hcGNvdW50OjAgZW50
aXJlX21hcGNvdW50OjAgbnJfcGFnZXNfbWFwcGVkOjAgcGluY291bnQ6MA0KPiAgbWVtY2c6ZmZm
Zjg4ODExNmQzMTI4MA0KPiAgYW9wczpidHJmc19hb3BzIFtidHJmc10gaW5vOjEwMSBkZW50cnkg
bmFtZSg/KToidG1wX2ZpbGUiDQo+ICBmbGFnczogMHgyZmZmZjgwMDAwMDQwNmMocmVmZXJlbmNl
ZHx1cHRvZGF0ZXxscnV8cHJpdmF0ZXxoZWFkfG5vZGU9MHx6b25lPTJ8bGFzdGNwdXBpZD0weDFm
ZmZmKQ0KPiAgcGFnZSBkdW1wZWQgYmVjYXVzZTogVk1fQlVHX09OX0ZPTElPKCFmb2xpb190ZXN0
X2xvY2tlZChmb2xpbykpDQo+ICAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0N
Cj4gIGtlcm5lbCBCVUcgYXQgbW0vZmlsZW1hcC5jOjE0OTghDQo+ICBPb3BzOiBpbnZhbGlkIG9w
Y29kZTogMDAwMCBbIzFdIFNNUCBOT1BUSQ0KPiAgQ1BVOiA5IFVJRDogMCBQSUQ6IDI2NCBDb21t
OiBrd29ya2VyL3U1MDozIE5vdCB0YWludGVkIDYuMTYuMC1yYzEtY3VzdG9tKyAjMjYxIFBSRUVN
UFQoZnVsbCkNCj4gIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRhcmQgUEMgKFEzNSArIElDSDks
IDIwMDkpLCBCSU9TIHVua25vd24gMDIvMDIvMjAyMg0KPiAgV29ya3F1ZXVlOiBidHJmcy1lbmRp
byBidHJmc19lbmRfYmlvX3dvcmsgW2J0cmZzXQ0KPiAgUklQOiAwMDEwOmZvbGlvX3VubG9jaysw
eDQyLzB4NTANCj4gIENvZGU6IDM3IDAxIDc4IDA1IGMzIGNjIGNjIGNjIGNjIDMxIGY2IGU5IDM4
IGZiIGZmIGZmIDQ4IGM3IGM2IDU4IGU2IDQ1IDgyIGU4IDRjIDY5IDA1IDAwIDBmIDBiIDQ4IGM3
IGM2IGI4IGYzIDQ3IDgyIGU4IDNlIDY5IDA1IDAwIDwwZj4gMGIgOTAgNjYgNjYgMmUgMGYgMWYg
ODQgMDAgMDAgMDAgMDAgMDAgOTAgOTAgOTAgOTAgOTAgOTAgOTAgOTANCj4gIENhbGwgVHJhY2U6
DQo+ICAgPFRBU0s+DQo+ICAgZW5kX2JiaW9fZGF0YV9yZWFkKzB4MTBkLzB4NGMwIFtidHJmc10N
Cj4gICA/IGVuZF9iYmlvX2NvbXByZXNzZWRfcmVhZCsweDQ5LzB4MTQwIFtidHJmc10NCj4gICBl
bmRfYmJpb19jb21wcmVzc2VkX3JlYWQrMHg1Ni8weDE0MCBbYnRyZnNdDQo+ICAgcHJvY2Vzc19v
bmVfd29yaysweDFmZi8weDU3MA0KPiAgIHdvcmtlcl90aHJlYWQrMHgxY2IvMHgzYTANCj4gICA/
IF9fcGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQo+ICAga3RocmVhZCsweGZmLzB4MjYwDQo+
ICAgPyByZXRfZnJvbV9mb3JrKzB4MWIvMHgxYjANCj4gICA/IGxvY2tfcmVsZWFzZSsweGRkLzB4
MmUwDQo+ICAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPiAgIHJldF9mcm9tX2ZvcmsrMHgx
NjEvMHgxYjANCj4gICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwDQo+ICAgcmV0X2Zyb21fZm9y
a19hc20rMHgxYS8weDMwDQo+ICAgPC9UQVNLPg0KPg0KPiBbQ0FVU0VdDQo+IENPTkZJR19CVFJG
U19FWFBFUklNRU5UQUw9eSBlbmFibGVzIHRoZSBsYXJnZSBkYXRhIGZvbGlvIHN1cHBvcnQgZm9y
DQo+IGJ0cmZzLCBhcyBjYW4gYmUgc2VlbiBmcm9tIHRoZSAib3JkZXI6IDIiIG91dHB1dC4NCj4N
Cj4gT24gdGhlIG90aGVyIGhhbmQgZnVuY3Rpb24gYnRyZnNfaXNfc3VicGFnZSgpIGNoZWNrcyBp
ZiB3ZSBuZWVkIHRvIGdvDQo+IHRocm91Z2ggdGhlIHN1YnBhZ2Ugcm91dGluZS4NCj4NCj4gTWVh
bndoaWxlIENPTkZJR19CVFJGU19ERUJVRyBlbmFibGVzIGFub3RoZXIgZGVidWctb25seSBmZWF0
dXJlLCAyaw0KPiBibG9jayBzaXplLCBtYWtpbmcgQlRSRlNfTUlOX0JMT0NLU0laRSB0byBiZSAy
Sy4NCj4NCj4gQW5kIGF0IGNvbXBpbGUgdGltZSBpZiBwYWdlIHNpemUgaXMgbGFyZ2VyIHRoYW4g
dGhlIG1pbmltYWwgYmxvY2sgc2l6ZSwNCj4gYnRyZnNfaXNfc3VicGFnZSgpIHdpbGwgZG8gdGhl
IHByb3BlciBjaGVjay4NCj4gQnV0IGlmIHBhZ2Ugc2l6ZSBpcyBubyBsYXJnZXIgdGhhbiBtaW5p
bWFsIGJsb2NrIHNpemUsDQo+IGJ0cmZzX2lzX3N1YnBhZ2UoKSBpcyBoYXJkIGNvZGVkIHRvIHJl
dHVybiBmYWxzZSBhcyB3ZSBiZWxpZXZlIHRoZXJlIGlzDQo+IG5vIG5lZWQgZm9yIHN1YnBhZ2Ug
c3VwcG9ydC4NCj4NCj4gQnV0IENPTkZJR19CVFJGU19FWFBFUklNRU5UQUwgZW5hYmxlcyBsYXJn
ZSBkYXRhIGZvbGlvIHN1cHBvcnQsIGFuZA0KPiB3aXRob3V0IENPTkZJR19CVFJGU19ERUJVRywg
YnRyZnNfaXNfc3VicGFnZSgpIHdpbGwgYWx3YXlzIHJldHVybiBmYWxzZSwNCj4gY2F1c2luZyBi
dWdzIHdoZW4gaGl0dGluZyBhIGxhcmdlIGZvbGlvLg0KPg0KPiBbRklYXQ0KPiBSZW1vdmUgdGhl
IFBBR0VfU0laRSA+IEJUUkZTX01JTl9CTE9DS1NJWkUgY2hlY2tzIGNvbXBsZXRlbHkuDQo+DQo+
IFRoaXMgZml4IHdpbGwgYmUgZm9sZGVkIGludG8gdGhlIGxhcmdlIGRhdGEgZm9saW8gZW5hYmxl
bWVudCBwYXRjaC4NCj4NCj4gUmVwb3J0ZWQtYnk6IE5hb2hpcm8gQW90YSA8TmFvaGlyby5Bb3Rh
QHdkYy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPiAt
LS0NCj4gIGZzL2J0cmZzL3N1YnBhZ2UuaCB8IDE0IC0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTQgZGVsZXRpb25zKC0pDQoNCkkgZGlkIGEgc2ltaWxhciBoYWNrIChwdXR0aW5n
ICJyZXR1cm4gZnNfaW5mby0+c2VjdG9yc2l6ZSA8DQpmb2xpb19zaXplKGZvbGlvKTsiIHRvIGJ0
cmZzX2lzX3N1YnBhZ2UoKSBpbiB0aGUgIiNlbHNlIiBicmFuY2gpIGFuZCBpdA0Kd29ya2VkIHdl
bGwuIFNvLCB0aGlzIHBhdGNoIGl0c2VsZiBzZWVtcyBmaW5lLg0KDQpCdXQsIGRvZXNuJ3QgdGhp
cyBtZWFuIHNvbWUgY29kZSB1bmRlciAiYnRyZnNfaXNfc3VicGFnZSgpIiBjb25kaXRpb24gaXMN
Cm5lY2Vzc3JheSBldmVuIG9uIHRoZSBub24tc3VicGFnZSBzZXR1cD8gVGhlbiwgc2hvdWxkIHdl
IHByb21vdGUgdGhlDQpjb2RlIHRvIHRoZSAibm9ybWFsIiBjYXNlLCBpbnN0ZWFkPyBTb3JyeSBp
ZiBJIGdldCB0aGUgInN1YnBhZ2UiIGNvbmNlcHQgd3JvbmcuDQoNCj4NCj4gZGlmZiAtLWdpdCBh
L2ZzL2J0cmZzL3N1YnBhZ2UuaCBiL2ZzL2J0cmZzL3N1YnBhZ2UuaA0KPiBpbmRleCA3ODg5YTk3
MzY1ZjAuLjQ1Mzg1N2Y2YzE0ZCAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvc3VicGFnZS5oDQo+
ICsrKyBiL2ZzL2J0cmZzL3N1YnBhZ2UuaA0KPiBAQCAtOTMsNyArOTMsNiBAQCBlbnVtIGJ0cmZz
X2ZvbGlvX3R5cGUgew0KPiAgCUJUUkZTX1NVQlBBR0VfREFUQSwNCj4gIH07DQo+ICANCj4gLSNp
ZiBQQUdFX1NJWkUgPiBCVFJGU19NSU5fQkxPQ0tTSVpFDQo+ICAvKg0KPiAgICogU3VicGFnZSBz
dXBwb3J0IGZvciBtZXRhZGF0YSBpcyBtb3JlIGNvbXBsZXgsIGFzIHdlIGNhbiBoYXZlIGR1bW15
IGV4dGVudA0KPiAgICogYnVmZmVycywgd2hlcmUgZm9saW9zIGhhdmUgbm8gbWFwcGluZyB0byBk
ZXRlcm1pbmUgdGhlIG93bmluZyBpbm9kZS4NCj4gQEAgLTExNCwxOSArMTEzLDYgQEAgc3RhdGlj
IGlubGluZSBib29sIGJ0cmZzX2lzX3N1YnBhZ2UoY29uc3Qgc3RydWN0IGJ0cmZzX2ZzX2luZm8g
KmZzX2luZm8sDQo+ICAJCUFTU0VSVChpc19kYXRhX2lub2RlKEJUUkZTX0koZm9saW8tPm1hcHBp
bmctPmhvc3QpKSk7DQo+ICAJcmV0dXJuIGZzX2luZm8tPnNlY3RvcnNpemUgPCBmb2xpb19zaXpl
KGZvbGlvKTsNCj4gIH0NCj4gLSNlbHNlDQo+IC1zdGF0aWMgaW5saW5lIGJvb2wgYnRyZnNfbWV0
YV9pc19zdWJwYWdlKGNvbnN0IHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvKQ0KPiAtew0K
PiAtCXJldHVybiBmYWxzZTsNCj4gLX0NCj4gLXN0YXRpYyBpbmxpbmUgYm9vbCBidHJmc19pc19z
dWJwYWdlKGNvbnN0IHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLA0KPiAtCQkJCSAgICBz
dHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiAtew0KPiAtCWlmIChmb2xpby0+bWFwcGluZyAmJiBmb2xp
by0+bWFwcGluZy0+aG9zdCkNCj4gLQkJQVNTRVJUKGlzX2RhdGFfaW5vZGUoQlRSRlNfSShmb2xp
by0+bWFwcGluZy0+aG9zdCkpKTsNCj4gLQlyZXR1cm4gZmFsc2U7DQo+IC19DQo+IC0jZW5kaWYN
Cj4gIA0KPiAgaW50IGJ0cmZzX2F0dGFjaF9mb2xpb19zdGF0ZShjb25zdCBzdHJ1Y3QgYnRyZnNf
ZnNfaW5mbyAqZnNfaW5mbywNCj4gIAkJCSAgICAgc3RydWN0IGZvbGlvICpmb2xpbywgZW51bSBi
dHJmc19mb2xpb190eXBlIHR5cGUpOw0K

