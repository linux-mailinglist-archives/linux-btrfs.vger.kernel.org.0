Return-Path: <linux-btrfs+bounces-19240-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F13EC77A1A
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 08:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF4424E84DE
	for <lists+linux-btrfs@lfdr.de>; Fri, 21 Nov 2025 06:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92C33555E;
	Fri, 21 Nov 2025 06:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oMDApCsx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JEOnbipi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC33346A9
	for <linux-btrfs@vger.kernel.org>; Fri, 21 Nov 2025 06:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763708373; cv=fail; b=mqsjhE849Q7KeiFgFSzayflnixRLGcaP7IasKZJZyVhyuijzdRD2D9tZ4pUxjSpx/IiR/YcMfgVlEp+9izKSVvNyKnajsrYCwRsLpVoueiSZ5lrmsKA9ray9MhQEG4BXo3CyWDEYZgRgwg2+/KNDaUF5udx+6agTDXn6zJ6LJeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763708373; c=relaxed/simple;
	bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTa2MbbZqCjZrhCLYOVUEtC3Vu/2tqmHtyv1BJLZ/GvH9MTMsSff8CY5m82FkLAYdxEuHPQ7TloJrxU5QKRwBzqQsSg/A/LtcjYUvJdbJsj2GGaNHtzYE1zVif78l6PNzokaboLFzDiJ1dN5+Deegc+ln/6xK41vYWGb1Nd6Two=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oMDApCsx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JEOnbipi; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1763708371; x=1795244371;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
  b=oMDApCsxO1Pz9y9YRmQbIZmsd/PLxhbRnyTPiW5ki9VKaxUWPn4oG8H+
   kPfJ5XQJfmYGviL+3EBw8XNSnej1h0qitlF9ZztAlzOrYarI6yB7fbmDn
   z3OfD8dV3NNPyvRI6arnKNOqfp7qhIryO9GMLWv0rq/OImhCX7uB+gPeq
   E+0n+7RLElQ/QifoexLKJJGK9pxlZoaUWwMBTnL3noUXvRcW+kPhLibq2
   LrY5sguiO2cmd3j45XWWaXWaP/89hhcYNDBLMrJOIPxepkmD5HA3zykAk
   ZYy5K4/T+iwXwNgCKQoXjseE6vkw7GD0PfFGnag2brhhtWNh7b7Qzm/Ab
   A==;
X-CSE-ConnectionGUID: eWaDEZMbQOm7WyAbQoYCLw==
X-CSE-MsgGUID: 4d1MDZcERtCQbUM4XMfNPA==
X-IronPort-AV: E=Sophos;i="6.20,215,1758556800"; 
   d="scan'208";a="135532859"
Received: from mail-southcentralusazon11013014.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.14])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2025 14:59:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIJ6cujxV6nIHBr9zm1EpsDdOaAAIN83Be3YXKBxSWuc9itjC7OduLtek1XeFBmYoO6vIbGlu6mNK11zHb+l796PxV9VkAHCtIA3pjeDyBr1lk4Cr11FuPABtdEh16FcBMWzUBLrwqY017Chq3epRdlaRP2n3kBC5NjBnsl/3ZvhiJNtpjGg22mS7ypqKw3NixasxvnV6A3lkD+fUgVGLtYOPmcjTjW/9/R7UCbpdLhPYCVjswU3svDQjcd2KImB7xUD7KJAvWAAjJ3IvV1lmE17+92ZdgzZjMrKC3w076dWUnw3XHzhmy6q76Pba5RkboIymChRItGMAq/0AuLiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=o0zbID77P41b3Hm20UhD1kKY+cM+kNLLKHgKYfaF061r1GXeX8ka5Vd8OSjjQ4HwAyEk9gghLzrmqiTaphgQZDof8/H167m4TWBij1SvNQNk1SCR536Bpu6lwzT+3TyMwcqDRwxUqOQChElhoQYvGvvepfoKnm4q+QUOXjgDlqt1Km0SL3abK1JiIXZ07rggMfNNBxNzjCYWG7G1JcwuNFfcnCAZgXXyDAnP7KH3Mdzjrl6S+j0mJqFewPVpWzPp55cwdOpNlMbJzZKEGduMhXWSg/KoBCLDCuer8gXT/nzPMqqdzxzInh6uhjH0B5wnagRdjCFJ/I7kH+LFOc1IwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+z6ql9M5JhawzkmfcJJBxApS2D5ls0dv54BOWw8ja8=;
 b=JEOnbipi6Km6eplP1BMTt9l9tbqTf1br/4Vyy05EFw64bPKPKqmGb/j5NfE2YeszLfqm8SOLXHbUbxxAhEjXdNrpH5hst8F7PZ75uVdQKI8xnQ02jmz8XBaTQuRwZQAR6xs+EkHZmJhhXeCHW+Yi3D6cBRh5tKgjRuRFtc3GLJ0=
Received: from CH0SPR01MB0001.namprd04.prod.outlook.com (2603:10b6:610:d8::5)
 by BN0PR04MB8192.namprd04.prod.outlook.com (2603:10b6:408:144::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 06:59:23 +0000
Received: from CH0SPR01MB0001.namprd04.prod.outlook.com
 ([fe80::1425:795e:ebac:cf71]) by CH0SPR01MB0001.namprd04.prod.outlook.com
 ([fe80::1425:795e:ebac:cf71%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 06:59:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Sun YangKai <sunk67188@gmail.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: use true/false for boolean parameters in
 btrfs_{inc,dec}_ref
Thread-Topic: [PATCH 1/2] btrfs: use true/false for boolean parameters in
 btrfs_{inc,dec}_ref
Thread-Index: AQHcWijh4ZTu5+KyFECEbmZkPda7ObT8tGgA
Date: Fri, 21 Nov 2025 06:59:23 +0000
Message-ID: <14575f9f-7ed9-4ff6-a984-fc45654609c1@wdc.com>
References: <20251120141948.5323-1-sunk67188@gmail.com>
 <20251120141948.5323-2-sunk67188@gmail.com>
In-Reply-To: <20251120141948.5323-2-sunk67188@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0SPR01MB0001:EE_|BN0PR04MB8192:EE_
x-ms-office365-filtering-correlation-id: 8510f52c-2e4c-499b-ff80-08de28cb806c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|10070799003|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?THNuNTAreXBqNkxTaFhkNnRaaVIwSGk3dnUwamxick04NndPOC9vVGJNZXZm?=
 =?utf-8?B?S0xHSk9sYmhKYVZtOEp5ckhFNkxpcHVWdUZZWEljL0tlbG9LU3hrVGlaMS9P?=
 =?utf-8?B?SDdKN1pCWXRsaDgxUGcvNXRxcXoySGZFb1d5b2pLOVBoTnFmeEZ5QzdaeG1z?=
 =?utf-8?B?dkxOVUJIbGRadHJxbUM0OWpVQi96VDVWdHo4TnpWU24wZWYvZGtJc3VWYW9I?=
 =?utf-8?B?QkNGQit2eW5DbTQvSGZraW9QMFVjdk01d3pXNHM0Z09EMEF2N3hCMXpMMGVM?=
 =?utf-8?B?UUZVTTBibmpvOEwzV081ektpM1pWQTZIUElWbnhOaVk1eXFPM3RaS3FqaFBr?=
 =?utf-8?B?ZE5kZlp5enB5NDI1YWF3Q2VVK1k0a3VGaFJRQkx0L1lxRU9Fd2V5dUdidnhL?=
 =?utf-8?B?aUF0UWNJcHBYU1MwaWpYRUtzamtNK1BOYmQ4b3V6ZWl5ajUzemZBd09Vangy?=
 =?utf-8?B?Nlp0a09pNWsrTXo4UERuMzdnQUR1QysvTlpMK2g4T3VUcDgzc2o5T052S2Zm?=
 =?utf-8?B?NTBBK2hIOFJremNUM2tUOVpDWXJJd2w4OGE2ampCei9DWXI2QXY3dGNzWS9y?=
 =?utf-8?B?bHkyeFdUMy9naWpjNG41NkFyb2xSTGN1S1lRazlJMGtJZ3FHNXBObnZLQUx2?=
 =?utf-8?B?b3RaQ295UElnRzZ4dDV3UWZESHIrOUtxRU95V0VxRGJUdDZrR3VQeUFrTVBl?=
 =?utf-8?B?aDI5MXptUXlROVFwNG5pWUNobm8wNDVYTmFtbElVQTcwZ1Z2M3EzNDBFaTAr?=
 =?utf-8?B?cUhkc0VpRUdDQkM1cW1vRWRsbm15RXNNcHo1c0VvM1NTSFlsc2xzNlVXYlJC?=
 =?utf-8?B?YWVsYVlXQ1l6eHNlNXY4eHhYZHNTWktodDczMnB5Rk9PSlRVcmFHNEpEeHFU?=
 =?utf-8?B?OXB4bEdmMEJIMVhjV290WGppOU4weE5tM2ZwVUlKNHBSMDFsSWJzSHczbDBQ?=
 =?utf-8?B?R1pJNVVxbmppbVQ4QXdIS0hzUnZHT1VZazlFZnpjbnFScXVaY0M1MHBJaFVF?=
 =?utf-8?B?bjlWbkRHUW90OFBjUGtnZURXQk5rM0o5RFRxOUNOYXFnR3hCdkp3Y0tYbUln?=
 =?utf-8?B?cjB4WWVWbFpySHhlSTVlT2syMlM0azdHYm8zM1djeEJ3TlBCMll6aXpxQnhw?=
 =?utf-8?B?UVA3SUQ5L3hKZ2xFaXlLYXJIS1o5WnJnR0tIa2pyTnM1c1BoeUxKd2lhMzdY?=
 =?utf-8?B?Y1F3ZnNTUWh0MzRzMHprc0VRNm9RZHE5V0dDNjhjRTRrV1pwMXc2S2tEbnRr?=
 =?utf-8?B?eTdKRXFuaFlHSGRLMENEdXlES3lRcy9OeEVuWlNWb3ZBNFJaRkJvV01MVEtZ?=
 =?utf-8?B?aDVUMjBNZ3o1cWFFbklXelA5cU0wYnRyZmFaL1F3aituSWFNVE84OG5SRWR1?=
 =?utf-8?B?NUhDUmxFbFgxdjltR09zU2p5Sk16SW9PakdybFlYK2ZwdjFwTkkrZlNpc00x?=
 =?utf-8?B?QWJmRkxxaTZqZjFFdzNRMHNyVkJ5ZlAybmtjdUtwSnZsMThKWXJLVllLRXRH?=
 =?utf-8?B?M203SHAxOE1OLzc5bmYwL2xKbWc5dkNINUtBOVdoOVd3K3pDWDNGM2RZNFkz?=
 =?utf-8?B?ZEdVbHp1YlVPUURnN1pHTnNvTFJ4NklmOGZLVWEvRVZaWmgzcjFvdFVmUGkx?=
 =?utf-8?B?TEZkMHJlS3l4T3pEYm0wZ25VbjVVYitsSEFkV2l4czU1VDVHWHpKRytFLzlX?=
 =?utf-8?B?T2dyWVNRZWI3Ti9TL2lCcHBuQVZ4TXM2Z2hEUWdUTXZadnJOVWdyVklHcnlJ?=
 =?utf-8?B?R1ZJSWxrdi9JT01zZlRZZzNYZGxNUys3aC8rc2hjK3FnWXJPRmt0UFU4MXRt?=
 =?utf-8?B?SHdpVTUzZVRLZkdvM1VRVWlYa3o3NU9TR3JoRGxrelVCQ2R3cEorSmtjTmlW?=
 =?utf-8?B?Z0FtcDI4NktRSVRIMENBYWhBKzQzK1haUlhQd1FrMHVzVnAvUEVRUnd6MGhS?=
 =?utf-8?B?WEFWRjhjWWkwWUJTdmpEaVVYSTc2ZGdwb0tmRHRHNklZazVha2ZPMFFJc3ZL?=
 =?utf-8?B?QkRoRTJiZm1CVGErTGxLVENMMkpsZzRMZEFRQ1RyQ0NLcnl2SHljdGplWmgv?=
 =?utf-8?Q?s4C0SO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0SPR01MB0001.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(10070799003)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RGNuc0pPVnlaMExFVG03ZXlFR0NibTdyMlE0Y202K2srblpPS3NjTjgySzB0?=
 =?utf-8?B?L01GaWs2T0ZBdERBaWR6c3hvYUYwd3hBbmRndWFFSy9DQkw1cjRRa0FZMEVt?=
 =?utf-8?B?ajJkRDlBYVpZRG1hSzV1TERjaVF4UEprUkIxVjBVYUYxeExqYnJaRXprVm9Q?=
 =?utf-8?B?Tmc1TU00aW9BVHdwTWREMGtFY2dJRkJtVWd1YjlEbDhZaVh6NHFjK3dONmJN?=
 =?utf-8?B?cTFZVnVveTRXRU1uRXc2TmhBcVd6NXg2OXJHMGp2cERpVy9BVm5TKy9RWmpP?=
 =?utf-8?B?VmY5MFJDQTRZaGpWZ2x4VS84eHQrVnlyU1dwa0lMeW9pNi9zTm5OZ0g0VFlV?=
 =?utf-8?B?cEhyWXlLZEpyNGI3TlErL0xrWW5idDNKWVVXWThQQmYrUlFWeFlaY0k2Slh4?=
 =?utf-8?B?dXdwYTg2VTZFZ3NHYzNiQ3Bta0RVVzBSbm9scWRyZnQxTk1DVUxCMmROcnlW?=
 =?utf-8?B?RDdxbERvUWNkcy9VYUJQbHF6YWtMNDNrRHFhVXMzc0xDZm1KVm44Rml3VjdY?=
 =?utf-8?B?aHJOaWJ4QVgxdmJNMTJRYnYxNTR6Zk40NjJlUkpkR1hZRmNXbnk1V0VJUERI?=
 =?utf-8?B?YkZycG9OaENNVHVjNkpubXhRSjNYVWx6d2NNRVB4VCtTVlVmcFNxa3pBS3lZ?=
 =?utf-8?B?YytLTklQRW5DS2UwRjJSYkhYdnRITUs3Sk9NVVhrR3NoeHlEQXo5ZUE3Zm9E?=
 =?utf-8?B?cXA1K0VaU2gzT1RXQVdwVUc5ZjFOdlRFOWMwK2t4YW9Xa1hVMEhDNFYyM3FE?=
 =?utf-8?B?N3pDOW05YnFrOGJHVHFTZEhwamtQMnlzSGU0RTl2b3hJeENpY0ViSlFabXlU?=
 =?utf-8?B?SWpVUmZpWjJ6cFp4NGdCTGFMVmlDc0xRUS9MM1JnMTNyZEEybSttWDRMaWx1?=
 =?utf-8?B?dUpQQ3F0Tk1sZ1c1T21POWZ1ZkZIamRFM1lKV3YrU3UwV2xGcDFKeVlENE9M?=
 =?utf-8?B?MGFhOEZ1NmhwKzViVW1UdUgxY2Z6YzdFSmxjcEV5VXJwN2tLSjhFOXBna2xW?=
 =?utf-8?B?UHptcS9EdGNTa0tsY2lSeTEwV1k4WmlnOHJKQW5wQmRsK3U3dVl2UERjYW9F?=
 =?utf-8?B?enVGS2xjQVFZQkpIOTk0TmFHcUx6ekxnOTE2SlN3TlVwaVRRbVNIRXdPSWdj?=
 =?utf-8?B?MVBuT1FadkszYVd0Vy95R1pUWUhYZ2xqc1pxV1djdk9zdzJNR1Rjd0dyalU2?=
 =?utf-8?B?TnduK2I1YzA0czFBUHE3cmZXcit2QkVSdS9rL29xSTU1aGlFcDM3L2pHSnNP?=
 =?utf-8?B?VXRqa3NQdlU0aENRMFA0VldqTEEwc0pKWWpkbjZaOWIyWVU1UlBtTXA2SmdZ?=
 =?utf-8?B?WmhLaTZ1bHJtQW1aY1dBNGltbGxRTXM5VTh0VmpZWTJ5Y0p0VHFVNEgrSHVK?=
 =?utf-8?B?WTB3U0VZbFVYNWJDRVdqbmdFckpYSm9EN1pCOTNKQm9xR0JOeGR6ZVg5Mjlk?=
 =?utf-8?B?QW1HQjNLZ2RFdjVMMWEzelNFTklhdlR2dTExU3lNemJLQzJqM0VacWlib2Nn?=
 =?utf-8?B?N1IyVUdlNWRkTFpid2dUall5ZHB2bythUEY1amJucHE0dlpaSnJIMTlsRGFE?=
 =?utf-8?B?VWZybHRqSUsxTWtuaUJtbEFWU1lSS0Rmc2cxRDk2R1VLcjhKY3dJb0M5SHcr?=
 =?utf-8?B?dFQ1bk1mTVlmTmR6ZW9CWVVPUTROL3Z0blgrc2QwNXNqL3lPL0Q4bkhhOXdW?=
 =?utf-8?B?N2N5YWhYVnpqdjQxeHJaY00xUkZKS2RRb2VIUDE3NEh4R3RkSGs4ZFJTTTdE?=
 =?utf-8?B?cCtnZ2V3ejRnZFBsanBPWjVpUDFtdnc1MzFyd0c2WGRhS1ZXRnVpcDFxOXc2?=
 =?utf-8?B?ZUF2MWtMblVxRmZkNEhtbDV3akp0eVVLVGJDWjAybXFuWDhXT1pvaGdpU3JR?=
 =?utf-8?B?SktsbnE1VmZpWklFa3JKNDhVMnN5V2V5c2s0S2tMK2hHT2JoTjgvc1Zpc0dz?=
 =?utf-8?B?YkhISzBMS1hKZGRtR2xwUVRsL2dsbDloTzRzUFZyZ2pSV2VnYnhvSmNXd1FR?=
 =?utf-8?B?U2krYS9lcElFUllQbUxzaDFodFA5VDl3dnkrYXlRbUxsWjdNejl5NWdWZkJV?=
 =?utf-8?B?WVBNMkNHc1JneTVhVlE4dGJ3RG04NEQ5bmNyblh4SGgzY0UxN3lpT2NnMzY2?=
 =?utf-8?B?b2NhbHNFbGd0WVhVM3ZkYXJla1dHNGZmNnJSTVg1TzdGcmg5aTI0c2pUa0V2?=
 =?utf-8?B?S0xIa3N5SmtHVjlsT2lwZFZEaUV2R01hNDdvRzNxYXl3eHZBdk9HWkNGMnVa?=
 =?utf-8?B?MHIyQWNBbHJNNXdoRWYyd0N5amt3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12ABF94B227A2D488CB4E5317A804C82@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gWCsplqWNg2Ym048C79cDXLBQZXRJgh0hgeD5kVrkIpICCtb4V4ItIB6hfrPP5CpKnB8sz7UbmspeCmqXMF7dXtClMATNvO5pSaCT+2d0lDkG6R3oPXFJn+pTug4GF7kqRVoDcvUy88PBWqVi2L8b1pgOfBZmw6f+8TnVZZE6QRWl2zrseMJGquFHpLPbRUUxpR3tgn6GHanYCIbJsQjmbw1U6/Ba1ZVRMKbvzM36aVeQh7fZ0GL3oWBZl8nXE9iUHW9ckoOykcMy+GyOXqjIhMkUSpgGFZuYWUmP8p7TDd4RVIWo7mJCgupbOuleg8FS736RrmUze3wMcnhLe2x3DuzuFUePFp5CLU53pEXl/HTXGAXeVREzO0IqO4RCmR+Q6jazV2NSacNjND8W3n1jGrguNebhTNP/jWSlqiEVtxHgYFK7qdq+MhpUO0K742uJK3VAq5QRtXUta9NIvG3pbZFUUt++zkwfLl2DtcPDJm6vO1JS9Fkbg15N6xXChAIJK8jbf+W6hZ0cQuHp2IZ2AelvOw5QgGcSsDV78jZDDPfevhbA1HPgl+cevJ0eZMf/G2yhRBgNX2BPoh/LxjYP7JIifmeUL0zlD39zSrLdmNHcS72Dk84AAblCRsl9/0r
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0SPR01MB0001.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8510f52c-2e4c-499b-ff80-08de28cb806c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 06:59:23.1233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aeNHNJ1PDt7yPSoGixpq9+b8GK8mMRjK9YH0PAfvyCVHbHBUEGAnq7+IYtqAznjVPabGgsmmSF+Ps/TR+XyhwtzrTVTe91JeDpIX9Yi8+xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8192

TG9va3MgZ29vZCwNCg0KUmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMu
dGh1bXNoaXJuQHdkYy5jb20+DQoNCg==

