Return-Path: <linux-btrfs+bounces-5638-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 607139032E2
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 08:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F781C23725
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 06:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3B0171E47;
	Tue, 11 Jun 2024 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="i0InvFqf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Nfdj/UiN"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CF736D;
	Tue, 11 Jun 2024 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718087967; cv=fail; b=LFM4ZRx6FQsRIbDlgTb1AQR6t01dZARkKl/nFSvM6AG4x1QBy5ivnuofgJO8i1E+Mz3UICz04bz1OeFZVOzOBL/qT09dAvj4Q2P2kMV2dvMXhufHe04/hj27VHBKmujVSVyFxEgsZ3JB0i++2ne+Corw6vQy9nBLlScrZwF2org=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718087967; c=relaxed/simple;
	bh=o29U04tW5O1MB6cQx5UR+a1RI2tlUYJ15s65KHNY4pM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pFquJFC8C9WE1Xlm11WhG8ZUU3RTPNg43OHideQv6yjB4erVRJZTu1ZMGPdF2Vq8rGgt4s3zfRL/SErvGeQlkdnfzChhVr/eZNHNAGPv3Zi/405tJdVyUVY7eb1d2afoIC1rfR2sFj2NonU38ykbYOJv/bgEoxWiHMDKm5J3Ta8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=i0InvFqf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Nfdj/UiN; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718087965; x=1749623965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o29U04tW5O1MB6cQx5UR+a1RI2tlUYJ15s65KHNY4pM=;
  b=i0InvFqfTzOUg8mya6Sz/W6/w0njUFS+8GZdgmw4/+PiXkB8yezrOvSj
   4Vx2Qoly1CsiADrcDKXqT+cayg+2tz52NdmyUittNLCOO14v1makqUtYK
   xyFs6dhIRgv9alPaxJuOWmKyCiAjAlhas/Hu8XWz4tltvg6jh4vABzJFX
   0wgiyjZ5gNi76xdlozcqeqsqzHznsB3qxiU9ICXSKRdHl1+stk+25gU1p
   tykXfx0g0tPIuT8fhBt8kIkMHupo2+Bchj5CHgeWFhN48QlKDb16RZV6O
   SKSK9k1dTrHPNb08Z0cQTHQ3E1NWy0AT//PE889jOnrdrSOjpwlgrHXdx
   A==;
X-CSE-ConnectionGUID: D7RCCxPhS3uzvowbyfguzQ==
X-CSE-MsgGUID: ks3bxfpwSA2OMRa/OL7lcg==
X-IronPort-AV: E=Sophos;i="6.08,229,1712592000"; 
   d="scan'208";a="18816541"
Received: from mail-dm3nam02lp2041.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.41])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2024 14:39:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6EfldX1ckbvlVmpUtV/bvCJjq55sSGyDW6f/vzDvTHwzZStOCOnfXlfp85JwElthZpSTMoYMzWbrP8Jk7koWxmh3rxC137VJkBTjDMh43y4DP/ApVUcRw5ziWhR7eCwbdycmuExCCWxp+I6Eepo/zou4xUPWoPn0pQu0EIhO0CZIHWXFaEbBufL3Cm8/W2Wkm8gzf7EfEYm7gPsURy5r1iKiiq2uydLntiDYNuDfey+un2kAi91wheqWt8FvQ5KaYN3iWd6mXnBIMxKOVlprWF/e4P99KedxNggey1EIthiCr2rpfqfUMUlOGXr8TPkc+YnifG8vGFydZonawMSyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o29U04tW5O1MB6cQx5UR+a1RI2tlUYJ15s65KHNY4pM=;
 b=ZLF9Q6BBR1byMFTX5jfTIywMZwZdNZ6/KZVOKNnfTIcNbPZ3cHjlP21LdtIcSsBB5TrdORXMhNoTO7Rjq2suuJr0YySCYTr+2u1U0M+yKuxkgGDoOjm5OMh6GmhNhIU37idsahCC98BZ01opQ6soTDAu7oKjgojnQrn3krfbCzIqsqs5mffT/howOwRM3g8zt98yLr3+gpL03JufJwbG6o+Hrs4oGgXl4iZHJb0+dKC6mAyZS/i9/wcZ76EF2QULIUWh1EgZ4NjFRP6pD6uvqDCiwHkV21f8/f+dfxaMv4a9OLnqMZA3xeOEj5qWGDp+Wq6LO0k7O9Uppn/t4/kvug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o29U04tW5O1MB6cQx5UR+a1RI2tlUYJ15s65KHNY4pM=;
 b=Nfdj/UiNioAjzlKJ1Zw2Kjfz4be8pbUe1horee2du+PRxf8ZcW5oraQ42AQ7k08TKo7sBr4nOl7rPx1Z0RwsXazUxzWjTVRRdsPl3gVWEWHwdvl9PzCBcq4aFkTQKLlLq4MB3GNBm1BM1aL1lxi05HGBwoisBqvemb+AjIoqXRU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9469.namprd04.prod.outlook.com (2603:10b6:806:446::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 06:39:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 06:39:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3] btrfs: split RAID stripes on deletion
Thread-Topic: [PATCH 3/3] btrfs: split RAID stripes on deletion
Thread-Index: AQHauxHfGIZHzbl8sUOT9yHUWlJJILHBZ0qAgAC2wgA=
Date: Tue, 11 Jun 2024 06:39:23 +0000
Message-ID: <0d744299-99b3-43be-b414-74ba73a4dbab@wdc.com>
References: <20240610-b4-rst-updates-v1-0-179c1eec08f2@kernel.org>
 <20240610-b4-rst-updates-v1-3-179c1eec08f2@kernel.org>
 <20240610194515.GC235772@perftesting>
In-Reply-To: <20240610194515.GC235772@perftesting>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9469:EE_
x-ms-office365-filtering-correlation-id: 84d18a71-36ef-4a91-17a4-08dc89e13b0d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z2dDcm1pMmI5bVNGcnlUQmRES2VIT2VEaW81a3ZWZjY4eTBjem8zb0sxR1Z4?=
 =?utf-8?B?WVd3anZadXBJN1lORTA1a2d5MWtIUU9FK1FnaERuT0p0TXhwZDJsVkJNTWpp?=
 =?utf-8?B?WWUvZmhxc2h2T0lzdERCNU42Rmp1ZUlJNWJ5RWNNT21zMzAyTFFEQmcwQmJ3?=
 =?utf-8?B?Q0Z1NDNQaUdsUm5TVTZ6QVVuaGVCc2U3SUxoOWtKOUJPdEhJOUkzaXhHVVlO?=
 =?utf-8?B?bEUybjRsclJNWFBLejFIMFdjMDQ3UWExbllYVzc3T2xjbWZUbGZRZERxSnpZ?=
 =?utf-8?B?b3lQcmZFRVVHUHVwK3N1UjMyNnI2cW8rOVRzQVRPbDlaS2gwT3lYT2VoWFdl?=
 =?utf-8?B?UjBrQVJmdUZJcm1PTk1Kd3VVTTFJMXdvVzNTdUt3OWJPWjZ0Szd0dkYybG9Q?=
 =?utf-8?B?bncwQjhnY0FmRld2Nm9XdnExeHkwK21hRzJvZWZnWk1pa0xnZUc4OUhNVkov?=
 =?utf-8?B?USs4d2xsVjAvd3JZOTlEejRaWFhHeU4vKzZRWlBqYlNQNWtQM2pVQXhsVlJ3?=
 =?utf-8?B?UXcrbFBCeTQ3MmNOVm03NXRsL1plaG9QOU4xVXgxenFUWEI4RmQ3MmNSbHBr?=
 =?utf-8?B?QXNoWnVEQTNFY1JEa1ltdzJFQS84Wmtmb0FXaTB2MEJDcUFaYzJ2YmJlMkRD?=
 =?utf-8?B?SFhvRk5TdFlJQkU0QVVKS3E2QU5EZWozL3JoVGR1UUVHT3BMYWtsWEs0QlRs?=
 =?utf-8?B?YVVwQmFueWFLemhmbThZMUcxR1p1OFVjRDZPQ3VXWUJMMU1iSGtrWEwxWmdQ?=
 =?utf-8?B?T3NzcEVPcGVkc1lxb1FmQUJzMmlrcllaeTNhbkVFMzRYN252bTZxQTFoQS9B?=
 =?utf-8?B?cHcyY25aOGIxOXpoMmFrdXcxKzdNeUUxL1ZMbkZGSG9mdWJVejE5dG5IbStU?=
 =?utf-8?B?bW5yWWc1L2dacXFLbUQxbUo1anh2aU01WUd6SUs1blM5c0N0clJldERQV0Jz?=
 =?utf-8?B?TmJpK1VXNzdRK0NlcExTcHV6YU5GeGJKOGE3K1NWbnNrWDA2MXpwL1dIbnNi?=
 =?utf-8?B?cWpBWHIvSDhqTDFuMll0Qm1SamVuSFdsMzZRR056eE5EdFcyeWRKSDl3OWNF?=
 =?utf-8?B?Y0J3OU9QZTFHTXFsS0hmb1RoaHpBUmw1a0psTUgrNGhia3loa1hlQ3p0SEpZ?=
 =?utf-8?B?YzhKbzNjY2s5cU9tQkUyczIzd21vS3ZuNkVIZEdVNC9KbkgrUUZ1YUR3RzVQ?=
 =?utf-8?B?WWZMRXpXakJYVHFLazZweUtrTXRkM0ZJcE1yeW0wTzdIeHZVQUJTemNnOTUr?=
 =?utf-8?B?SFI5NThzUnJnM0xPbXljWkZCYTBGUDFNeFVSOWVhWHd4dUVuTTdTemlDTkdn?=
 =?utf-8?B?aUhObDcvR01YRTlOTTdCOVNibkFqQkpMTzZYamphYkY1SHFoYVM0eFdTRkFW?=
 =?utf-8?B?ZUt3cnNXR2V6TWFXbEs2UzZTNjhUYU9RZ3ZSSEhEVXJCQlFtcXNwVE1SYUEw?=
 =?utf-8?B?bExUbjZwRFNoeHh1UE84UGZQM3NZS2N3TjVEUjM4TjczbkdwekhrNnVSb0Fl?=
 =?utf-8?B?bUllSnZiemhCWUd6dHZBZkNXTEJ0eU9zdmRhQm95c2lrUXpvd1h0Y2lhYXpJ?=
 =?utf-8?B?bXdpWG1jdExDMURFSGZiWWFLS3BKckNHNXp4QzBxYUVKVDdzVTdoSFJxNVBz?=
 =?utf-8?B?RktOUG1LcktpOGtWK0J5b2hTNXZmbVE4ZklPeFdiampLaWxMSDBYNllNQ0Mw?=
 =?utf-8?B?eHhrVTVnbEFjK0JnSkM2UlI4NkEvZU1ydjloamx1eVhhSU53QllJdk5QeFFW?=
 =?utf-8?B?aVJJUWF1ZUhsY2hWaHJHTlk4clNvN3gxelFicStneGRnOStJa1ZQL3FTSVRo?=
 =?utf-8?Q?3THQotmjMuVPIcJ9Dd+AQ+5vAWUbJkGpKWrAI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b3M0azJhazJwR1N3N29VMzQxOWU4YVlZU2FrTG04dldQeCtSd2E3OWlXZDkz?=
 =?utf-8?B?VWlncFRPS0RaMXlxL2Rxd2x3VjFJS0dlYkhMV3pJeTRtNXgxQWprdFBqZE12?=
 =?utf-8?B?NGRzUDdiU0FWMENrVllENVBNaTBrNFNyTUpST2c4V3hnaDhtMU1lQXVQNnJi?=
 =?utf-8?B?dHE2blQ4ZkJwMkN3clc1aHVJVHliV0ZuSmVSTWZwS3ZqTmJJem1VbXlmdUkr?=
 =?utf-8?B?eTNUWlIvcTlJYmgxSDVGdG9CZmc1cVBFd1JXc0VwKzZOMG13MzREMkRKSk1p?=
 =?utf-8?B?NTFFb20vSFdDaFVZSjFHdTNSNDYxWXlEeGtMOE5wL0s0K3hZKzRWajB2K2RH?=
 =?utf-8?B?OS9GWFhCY1hDU1lJZlFWZ2ZMbFlDOEdmdnpRdzZKeWpLZktIanhUVFVJbU8r?=
 =?utf-8?B?SmZMWnAybHZoRW8yTnNlTmxEVFlYT0FaQzJlM00yNHBHc0JKRklwTmN6c3I2?=
 =?utf-8?B?bXVHYndaaE1DVER2QytONUZ2VkZxRHAvZ2NldnJUdkpOdnVaekR5c3EzaTdL?=
 =?utf-8?B?bTJzUG00d2Y3T3ZlbS8wNGdjVUdzTUl0QkZEd01mZjBMY1c1bzhPZ1ZxS2Rl?=
 =?utf-8?B?LzVlTE8zRFNHVGdPS01GUEtORktMeGpFYzRqYW1zVFcwNFBYcUVSRWdkalBH?=
 =?utf-8?B?L2E2ZzU3bTA3Y29QQ2JOUXE2S3ZUU0xYbEJvVE1CZThWOEhSQUVjSnVvUXk2?=
 =?utf-8?B?NkV5VFJmaFJ1TU9idE5SVjhVM2p1QmtCZjJ4VHlieTBKazFoK2g3ZDRLekxR?=
 =?utf-8?B?cDVKNjNOY2ZBOUlUNFpyRDl0NFZsY0ZibFpnM3lvWmk3ZlE2cnBaTmg4SnB5?=
 =?utf-8?B?VFdQTGZoNnlueHdsL1FFNTFpN2tiU0hjZ2RCdGtoUDVwaDVCRWZiUWpiV21l?=
 =?utf-8?B?TVg3OFo3KzdsdTZDeE1xVVJ6cVVKU3JEU04rMDJOTDBISXBPdmdBNHlQZito?=
 =?utf-8?B?aUk5WDVJdGx6SlExL1ZQbGJpdk51OWJJeFdPdDdPUFNwN2ZIWHg3Z08vQ0tn?=
 =?utf-8?B?U2k3QzVOL25Fbitha2dob3A1bEtCM2N0ck9oNmNnbFBLV0xSbkJiSUNSQUpk?=
 =?utf-8?B?T2tSR0xieWhZOEJRWDBtWDBCa1UxS2FBT0F2dEtHbjRyVWdGVGl5Y2c5Z1lG?=
 =?utf-8?B?REVxMmdiTTVYS2Y3U0hQOU9BcFhOM1VJYzlBb2xQcytpNlM0UUJwa1F5WHov?=
 =?utf-8?B?aHJBM3VjRUpCeUFIM3czVUpKUHlncGdvZ3JqVGc1ZFhwRkdJNU54UnU1YlFn?=
 =?utf-8?B?L1Q4Y2srODQzYUtlZFpFZHZyS2cvYzBBVDFWVTg5MUdQVGJhczNPR0VvQ1Ix?=
 =?utf-8?B?K1pKdHdmaGthRUMvSDRCYXNNdEJGK1JRY3RnckpJejczeDNzUHNIdEJtR2s3?=
 =?utf-8?B?NXEwVzJHWk5DTEhMODFHNDdIam9ZTmM5Ry9ZS2pGQTlDaWo0QkdTclFpVStS?=
 =?utf-8?B?VW9xU2FFQjBEY1doRTdUK3UrUjUzblB0bFk2aUVTdlV4NWlwQkdWU2lSd0F1?=
 =?utf-8?B?cXM3L2RZL2twa2kyL3NMUm54bGYxZUFseWZpYisxL3prZ1JPSzBneG5kOTFB?=
 =?utf-8?B?Wk9uM3A3cWtjdGs2VDBidTlHaTZac1lCOFBqMldybmdOWERKdkxqek9odWtG?=
 =?utf-8?B?dSsvVkFqMkhYSlN4VWgrb00rbEtqdXRaZHlMT3hVZDQzU3RtdGhrWGxocm9H?=
 =?utf-8?B?SjdnTEcvM0I1dzVBUzRKZ3I2VXcvb3BDVUJPRjA5VEVJLzhtS0w5cXJmQVEy?=
 =?utf-8?B?Z1drVTNOQnFsdEQwYW83OWp5eHFVRDRFWjRQY1ZwSFdQRnJROGFYRkZUSUds?=
 =?utf-8?B?d0V6MXpvSmsvRCtrRitNa25zV2dtSWh1dXhIZ0RQWEhuMENWQ3lUVGovTitC?=
 =?utf-8?B?d2l0VnptVjNWYWlFWTRRU28yUjZ4bC9tNnVUTVlBS2VTYVNicGswY1EzN0dL?=
 =?utf-8?B?aTFmWkVkdkxaLzk1Wkt5OWcwR1prQkZvT2toSDJ5c3BQRnlobjRNcG1SdXhQ?=
 =?utf-8?B?cEpvN2xRRWRqTzd1TFdPem53aExRRHJ1b3J2VTJpTDBaS29DTE4wZ0FDazM1?=
 =?utf-8?B?dUIwME0zL0UvTU1EZ2hOaTFkSEs4LzM0eUNtZGNyUEViWEtYNmdTYXhlSk82?=
 =?utf-8?B?cmhLdk5SUkY5YThoMThRaDVNMXVGREFEdGFWbDl3bktGaGJTUXM4a1Y4bzNY?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C503AF3DE3601D49AEEA1E52C55292A3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0VoJBBtm0/2iKafj/IlgkICtRn1gsyQjJBtMVoGmBu9I61owC7LVRPKNHqFQVchC40h8GrAq6E2+nmMT80D5KH7oM19RBiNoozt0nh4V64KZCjzyJ/jvuhpBY0bF68pnBSSjgFK/kJ0RrOtryR4jsfL8ABAKZ59NNce7FKbbTzqQJ19iN+jALDr2vtYP+i+r6SaCc1cEJAf2kkr7/Q0TRlO2gNC0IOW72jIxcuCmG0GCF0jzR7xWm0hSe73HaZC3rda2KZHuV+feaWqVok4XQIWL6jwN6FddsEXNgfcUWDNY0bZOlPK/6rZNfg5OphK1/oBwu+NXSZBKBQGdSh5cJ/JqNtJTzus4vAH9y/cBQgYGAl2XfIcoOFQR3blAKgOQcnwPxvl8HVEPyT3CN4hNnKzxZsIjg7dLrmhR/qLaQtLhHmMGyj69TlbSiqKF4nknUKosek1XJUb//WNW2TGC9RYvzgUtnSj3QG0UiBUoqKNxVsIXdDdmZhdfjv647LrjGlQs2ZbET6cTAwmw6NaTX9WRlc6ewvFVQFjpW0HQ602R6r32ZaqpUBsWIBN8H7MwRtxEYPASJSmJDDUHCys9GukF29NgImKvlYE4aesZYjL61LuOBzKCJgMmjvYQO5Hv
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84d18a71-36ef-4a91-17a4-08dc89e13b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 06:39:23.0633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mIyls2rGTQQrLprgtN8MV2mrj3zrw5prTLqU+mczrWMoPBecHhi8LFz0tx5NUQUCcgvm2nt53EX+9hZF2HgGDrQ81VWkqAyxl8cHEL8WYAw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9469

T24gMTAuMDYuMjQgMjE6NDUsIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiBPbiBNb24sIEp1biAxMCwg
MjAyNCBhdCAxMDo0MDoyN0FNICswMjAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBG
cm9tOiBKb2hubmVzVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+DQo+
PiBUaGUgY3VycmVudCBSQUlEIHN0cmlwZSBjb2RlIGFzc3VtZXMsIHRoYXQgd2Ugd2lsbCBhbHdh
eXMgcmVtb3ZlIGENCj4+IHdob2xlIHN0cmlwZSBlbnRyeS4NCj4+DQo+PiBCdXQgZmYgd2UncmUg
b25seSByZW1vdmluZyBhIHBhcnQgb2YgYSBSQUlEIHN0cmlwZSB3ZSdyZSBoaXR0aW5nIHRoZQ0K
Pj4gQVNTRVJUKClpb24gY2hlY2tpbmcgZm9yIHRoaXMgY29uZGl0aW9uLg0KPj4NCj4+IEluc3Rl
YWQgb2YgYXNzdW1pbmcgdGhlIGNvbXBsZXRlIGRlbGV0aW9uIG9mIGEgUkFJRCBzdHJpcGUsIHNw
bGl0IHRoZQ0KPj4gc3RyaXBlIGlmIHdlIG5lZWQgdG8uDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
Sm9obm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPiANCj4gSSdk
IGxpa2UgYSBzZWxmdGVzdCBmb3IgdGhpcyBoZWxwZXIsIHNob3VsZCBiZSByZWxhdGl2ZWx5IHN0
cmFpZ2h0Zm9yd2FyZCB0byBkbywNCj4ganVzdCB0byB0ZXN0IGVkZ2VjYXNlcyBhbmQgc3VjaC4g
IFRoYW5rcywNCg0KU3VyZS4gTGV0IG1lIHNlZSB3aGF0IEkgY2FuIGNvb2sgdXAuDQoNCg==

