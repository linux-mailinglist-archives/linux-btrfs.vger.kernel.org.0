Return-Path: <linux-btrfs+bounces-4338-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C28A81BF
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 13:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 005F31F2248B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Apr 2024 11:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9413C838;
	Wed, 17 Apr 2024 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RV1drGAC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="nXJuUJd6"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3613C66E
	for <linux-btrfs@vger.kernel.org>; Wed, 17 Apr 2024 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713352304; cv=fail; b=rWXrM9m3YqFi7VO7rK8BJyNO68GqC+95RnlSGJELutHzebxqOU9koJhXn8CcIwHDLK3CoXJtejG0yugBTc6Gq7nYZf0P/S81o8fBrQALnLJrLLDqScRS4y9Bry4YNDfNaL2yHFTYJgdkqU8ppBQhFVIbkQBP66UHgHtTQjk1Aow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713352304; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qjg8/9IUlZnATNtTubHidVnO2ZwFQxTc5QS9rykDRd4q2nejDuAzZnou/AbCW7oZOAhxajPBnetafyjxv6IBTuqi8CMoX6kK6Ss5IkyBHlIG5VFYia5jpNBSQZ+bBv/hqTqcVH9ZJIsAHagSoZhc9zDItlo47JvKY3rQEKgBges=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=RV1drGAC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=nXJuUJd6; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1713352302; x=1744888302;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=RV1drGAC1pdMfJsOVVbt2aCjvm3E6asAqWEI1+zSRAGaPEQLbM6n7k5e
   AT3ewER5HdGsk0uzVBaYd2m8BZiQOVJRXy3bD/dapBZXmOwKKi624gkBj
   gJQsa7A/A6aTeRoWujTexUKOr9nVsLKKP3AipPHaK74Grp61WAsHtKRhH
   LmkJuXYx6cywpvOXZbodYj2xSj2/Ft75KGgrZaumTwRv9YxgCH5z7VWkN
   Sm2UPFTLKVKebWurAIhsZsrQ8KAIPCWZ++3FliiVnNT4FS4/I1PjJou5W
   fXtkU8k3wjQA7VanBAgf7XpSILDiYlU5sjT9IzxfSf8KmhHRzhwaC5nSA
   w==;
X-CSE-ConnectionGUID: z5QNEmP/Roao45Zam0r3JA==
X-CSE-MsgGUID: TqYA856YQJe8k1RatnmZBw==
X-IronPort-AV: E=Sophos;i="6.07,209,1708358400"; 
   d="scan'208";a="14460025"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2024 19:11:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+ade9BJqBqfjDMyjhxutljN2T4DP5zWWE0iakQg5gfIOrmzNoHNWecruJet4b/dCVebqY4sEVdd9XCSy07JSDVR+y6gepcnBKik+th4Yh55Q/c6jdDrauY068mGYMzUlPFVk2uuAee6JEX7bzh1DHs/PSiW6IWEsVPaGQPQ56icLRwzSM9Zk4LiZUCUDUn0VVOjHYfU78Z5tDLf55taVEZMC54OOMf3cQcd8tSBuSpxSiQ0+j3w9Q/Qk0Czqv5wtLwSaNxdzxiFfQBtf1gSmCQiLyIV27TOQ0doMBEnDiO8RgM1tpUGWjnjKjV94+m2GQJdhumN4tQeeB9sQPDcgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=iU9PZbPYslpo6LnMrO9b1e6nhx4WLgbN3fo65/D2UeImkE5HALGb/6wpe9DVxNuhyM5wXim6vU61UvQsEtGTFtUKNd6xgCe3zNy8SeML24hCkJhneecKseAS8Fg+GjfD5i+wDd+kA6njPpp6ySFnPGyd+3lD2oCaCj4ccJoRApAAvidEJEIeh/2hGFd7+ouurFKmHNxTyNytVa8uepuKT0fM/2+nQg+eihKJOI7iauK1AsrHw0BALWrXDMGDw6M/2LREJgFlvUC70qjaE74SlU3LsVS9urXqv/p22ytqpzS7/tAsn3eVT3YZash442u3Mbrc9qUo09L8ILhdWiPv1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=nXJuUJd68SAXrU+45jari0wCzR5S27eZEW8CQrAT/ss8vYJTlJ6dOPgxk+wed6zebNXyHG8q+XunhWou8a8yjsYp+7KN4VDqfFjbvg9GMMYdfmevbXcHiT190cWX8F8ESWQvGMg9STbIRQf84VDw9w7ZWI1HkhMuhEJm2WWUcDY=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8453.namprd04.prod.outlook.com (2603:10b6:510:2b2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 11:11:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 11:11:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 05/10] btrfs: pass the extent map tree's inode to
 setup_extent_mapping()
Thread-Topic: [PATCH v3 05/10] btrfs: pass the extent map tree's inode to
 setup_extent_mapping()
Thread-Index: AQHaj/81DOVNGLR88EeD+UZ0g4h/yrFsUAuA
Date: Wed, 17 Apr 2024 11:11:40 +0000
Message-ID: <6d92b26c-aedd-46cf-a45e-bef661221550@wdc.com>
References: <cover.1713267925.git.fdmanana@suse.com>
 <29e0cd5f1077fc214aabb5ba1f404d993a670d4d.1713267925.git.fdmanana@suse.com>
In-Reply-To:
 <29e0cd5f1077fc214aabb5ba1f404d993a670d4d.1713267925.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8453:EE_
x-ms-office365-filtering-correlation-id: 71573f87-f1b4-4380-6fbf-08dc5ecf2804
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Gw57d9uaZCAPOVTgX/cPuPgDha4t7KyrRVkL9Qec7tkWlpD3R0nYqAUMCGhJOjqstxpl2qqZwO/QWhLb3P5686sFT6LQoD2fAknvw1a9HDYgh3ekcS6PG/ClgyyBusAEO6eXuwnMwktTQzg3wQu6ktLrPwDH4aLMBKKtyCist3WNSdnrTUHjvz6Ju7GSeVrIH6Zj5aJq5B6wNVmX9tlXTuJMY671Ezk+jtotFkrQ6DG1vCAXUzoFmY3aXHbGgBuITpQTaKv7/8KpbGxra0T1VDz3vM6aSY2x0knoMoEw1AnXN4X4epTv95KMLO5A7Hnx/j8M7fKjk2RbsxtHT9sW++7bMMQUX4N7QFB18ES3cjaIf1laOpeveecmhQvDktkJF+6/eb9vpRbRYAysQk/HUsgMQcZJ64dLHjW1sPLPDQTU9avL8o5d4MFB4na+LHH3Gy8XOP5ksdPpBB87Wn/jaQ1dPJeNGExyiSuSF6YVo9xk4UBg1mlBsrU7PCIurgeF9bmGkWe8OeQ6R8R1uX8G/E9pHW/+ZDvNr+kWGEAfGnlEr9v/agtG465/3E7pT6ipwnYa0Fe5CBnCA+3w+mm/0D6mRopKSoofVtWUuFniuvdMKlTAAFd5y7MRO7SgGnepFD9UQLtNqcnWPAnkxtRFtVgbhYcWlHpPARUPLbxD9KCM3r6UU1I7hQfSxPHnIb31F3K73VBXnhjy3TcEWbcc0e+bSx+frTcB1seehZnDJLE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?em1xa25HOWx5dU1RQXRvSVB6Vjlsb0kvSWo2bXlQWDltOTdEUzlkemZLR1BW?=
 =?utf-8?B?YmhRWWk2bitETEhaeFNFbGlOQVo5ZFNPeC9CczZ1QjhnZkZMTFBsSjZsMGxM?=
 =?utf-8?B?ZUQ0U3BmOU44bXQxcUYzSzNtbmEwZG4yNVB3Q2VpTTVUUXU2c2oyY2NFem1C?=
 =?utf-8?B?TjdDU0pySHV0TWxraXIyL0lTZ09raGl4QnBZdWRhOWpIQ1dVZ0hlZnFtdEpZ?=
 =?utf-8?B?SlBHOFhMdnFoWjVoR2cvbUhlZDlMZjU2TVEvV3Zybmd5aVR2clRkMXdtbTho?=
 =?utf-8?B?T0VFZSsyWkkvb2k1SzNhbnlwTlJvRjhXc215ZWdYVnVlaC9mVEJ4OG9QeDFE?=
 =?utf-8?B?TDJBZmgxLzNyOGp1SGxNcmdSWTQySGhxaTdScDJTTk9TZjU3SnVhbW1jVUJZ?=
 =?utf-8?B?TkloQ1YzQkY3RncrbzVYOTFNTUVvZnJqLzFaZFRDRHEzRVo2cFVkenNzcGpC?=
 =?utf-8?B?MDVXeU5CL29OUzluVjNackRZV2d5QTBBZUs5NHNzMUhWVHBkMHZWSUc4NVlI?=
 =?utf-8?B?b2JZMzI3ZS9ELzRvNU1sYzQvUDBjZXN0U3ZjSlY3Y3ZHRFZKS1lOdEVRZisx?=
 =?utf-8?B?MnpLb1VCeWtmU2RRU0s0Y2hwN29vMjgxMmVCTUUwNlE4N2ZuZkV1YVBweXVi?=
 =?utf-8?B?NzdqQVpOaE5GbDlBTERqSHd3aU90elBRckZUUW82b1pTbUFrY0FPZDdlN3lu?=
 =?utf-8?B?VnZWc29qR2Q3WnJvSkhxU2hrUHpwdGhOVHVEeU5WRDdVNGpHU2FRQ08vcG5M?=
 =?utf-8?B?dENHdVVQVnJUSDE5d01FYTY0aDB3d0FQdDYvRVpST2o2ZEVlQWl4SmtWbm9M?=
 =?utf-8?B?LzlLU0lWQVRTaXBMa1doekxic2JWLzJ0Z0JLaTRLUnEyMjNCeFNvdlR0TXVv?=
 =?utf-8?B?eVJ3V21EMlZzZ2RNa3Q1QktzTDFZekpPcjZiRldqWDJQRTRnVjRBUE9ZZDIr?=
 =?utf-8?B?U0t1SFFmOU9TNEdubDRRWDVzcTVGMnJuRVgrYUVJRWIrT3JVdHBJcXV0V2NP?=
 =?utf-8?B?cDFkU2M0ZEhBS3hSdUx4L1VvYnc2VnFMOVkxNGxmbmVvVG0xR1hRZFJsa0dj?=
 =?utf-8?B?MnFOOVBQSW5HTlNETG0xVTZJUHZEYlp4eGRMVzQwTkxZVFh6YVR3emVldXMx?=
 =?utf-8?B?TFZCUkNrSUtYZSs2OHZBdjFnV1RvVXI0Nzg4VTA0bFNSS2t0VGc4TS9JMG00?=
 =?utf-8?B?RGJNZ3lPRFgzdDFpblc5VFJVVGlONUhCdDZFZUhlLzUvUW1vQ1haZlJLSUlZ?=
 =?utf-8?B?ODczL0k5alE0VisyTWZycWtSaXdGNDBKc1VId052bUVHbEkxSyswS05HN2Nl?=
 =?utf-8?B?eGl4VDZycTJ1MmhSMVRDSjhJUUhhNVVvam1iV3hvMlJraEVWaVN6Wk02Uk9G?=
 =?utf-8?B?dnFEV2pMSUlsZXIyVkJLVytGUU9pVTRsVmdZRDdNMk14dk11MkpBZkJTK0ZE?=
 =?utf-8?B?cUhITkxHZE5PaFdmWDVRK2dXODlPbXgyeFA3SEJBejl0OW8zT2RQa2Q1WEZY?=
 =?utf-8?B?QWtydVVLazlCTEhPajhXMEl6ZFVkSDhsYld4OGYwRnVibmk5RVl0a1QzZnVo?=
 =?utf-8?B?bUIyWEpwbENwS0RwdWdVNlY4QzY4dXBGT3g1NTJHZEJQSGg0RzljWVRDbUlI?=
 =?utf-8?B?OG5tUVcvT1VPdXIybnBjKzRsejVUbGF2L3k3bW1rZW5WMGVSTW1WRWJ1NC9j?=
 =?utf-8?B?TlBNOHJSbTA0c1FIK0QrQTRsdUJhZjJtQjdabHNVNDR6VmFBelBMRHhhNlBy?=
 =?utf-8?B?YjI3eks3VUk4cnk2eFhKalJUVjhYUGJDTFVwNTQ1ZmtLK0JtRDhJQmEreThT?=
 =?utf-8?B?MUk0SHplUjhPeXV5NE03RWFEWFp6Q1ZwK0wrTWsyOTJrQS9MTmZzb3IrMTE0?=
 =?utf-8?B?MXV1amh1L0w4bVJNNFZyZllKVGEybGVPZHpsZmlDWXhVclZKWS9RbVpvdGdu?=
 =?utf-8?B?N0Z1R3BNV25DY1VHMWhKTGNRaEJOOG1WS0hJNWVmNVA1SWM2djdjeG5sMHVu?=
 =?utf-8?B?RUpTeWtYZmcrWmJ3MCtrY3I2ekFsMllxYVJZc2w2b3R6R2dYK01yV1hPOEls?=
 =?utf-8?B?bDVLOG5GcmlubmhDYm1CRi9CZWtiNy82WGVucjZkNmxhbzdHdlEreXlUTm11?=
 =?utf-8?B?aWY2WjhSbG52VG1iNVBFbEljYSt2WnNvZWVYM21FcEplRExCMjNCOUtnV09R?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD3A18A9BD006E43BCE1B7E6392092AB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3ThfF+tDwkUO8Ld40uLZNqIpP2bcRXX2Wy1EgdepgNgGyQKVqd6C2Csa7j3FRUht36+qeSx4OUFuNIDmxly3u14Fy83n9BGbu617JjLssZtIIFOClyBihJ9qVRbHi+/r2jfkzqInxjMKbrDNd+N7nhZ0lBXSW67bzea81sFU6sIYkFoyfxn4LcvVgrgTu2DE7Nz4GfJ57BhQVFetT2h72VDQvjrPFMe9+5jEIMbeZk1cuCLUyqRBOCq8q9sa8GzaFcXckiXyvxOSrLBkpP5e9lXUZ+RDJ/gi9cPVJ/5jVukfG5HPSi09/s++UYv4dCtzhdjCT5exwAa2G0+fM7R0Iae915j7IIn5t9NCgCb9XwaOY7WVGtMEhBcHGIF3T4ak3vn9aeX5eXv25xT6eD7LIjFMxHOoYEplDwxVjuYm6bQUwitzWto2pzsAW8bVxZq8JdfWMiNYUwNNZvpeT/FmNjEvmWNezqa0nxqBjYQC/awQMWwxK/zwNYHfU4CEeSzdCewTwgtvMfdaIGJzBpXpsk4UjH3G2cKBP/jhHFfh2jN2n616+0MfCqn+F9QM3jl9MRxqRqfHgNGF4+ed/iVU0EKJKwG6q8+et1rmlQeietDjJn4A5pMFgcZJnX1lzd7h
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71573f87-f1b4-4380-6fbf-08dc5ecf2804
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 11:11:40.1777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M8GxcWjcrckZtvPmGQsdyg0YiWPHDlG7BCyaSKjRqkcbg94S5Xeds7M/rVRIwvsUvInJvzsIQ9bQWCGzrehLKWMYIr3L8AvvQGdUo+ILBk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8453

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

