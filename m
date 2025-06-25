Return-Path: <linux-btrfs+bounces-14940-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F83EAE8024
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 12:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED211883EAC
	for <lists+linux-btrfs@lfdr.de>; Wed, 25 Jun 2025 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEA729E10D;
	Wed, 25 Jun 2025 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EVqfXfQd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Fpqgem7t"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E072A8F5B
	for <linux-btrfs@vger.kernel.org>; Wed, 25 Jun 2025 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750848481; cv=fail; b=UpSIup+g+lBoLgSLKP9xAZHIXrvnw9Hu+ZU89Mc5DfHxJVZKTywoIXpRyWwZpCiSyUVA/k2TrghC0ovXZOqvlPuJQQV51I96AkAguRAJ30r+HvcpRaoSMi0AF/MITZwt+0kAM7SzCZOyoK56maCuyii6VHHBimQzxggW3acvfA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750848481; c=relaxed/simple;
	bh=XQuisb8EnXtPv+1LMa71ftTjLXEaYjnK7hUcAlb3IO0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LseJtJ1RV9k8uH7/uIuGlrKo30OlhF7yLbEtrh9sq6Ez5msROtasQQKKTdk5dG2vMQ0H3NkUUJ7NNBJwVReOTAJzMOvXa1Genv1+eFwnh2uhg/5Z860Upl2MWD5Lr/NS+wkUAbM4dBCz3jCsQSD+xC5Uer0JxUZMqRZ28V7JR1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EVqfXfQd; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Fpqgem7t; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1750848479; x=1782384479;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=XQuisb8EnXtPv+1LMa71ftTjLXEaYjnK7hUcAlb3IO0=;
  b=EVqfXfQdP2plO+EBnPUHTLvkiT6+DhxK1ZIf9k7ZkGotWlc6Ct9LIMon
   APuCtu1qEXi4LN8zD3QXdTHhgjfPjbwFzL6W90QqDLQgL8klJ/zqICYxf
   FFBfDya4zKBV8z6mgqIRCbRGqzGqIbIUknI5SAxdNOtd+Nm0fneIYGfWV
   hN/nY3cXXcZd7zeAJc5gvadg2i8MzfUtqv6Gz8l5CHXi6Wxb3spYmthtq
   BhrAWw81m64kE/npU3/Po9kyVQWgX6veC6639zxHCq8wpucIPPN+4it27
   TB2mLQo7mlrfSOohhodlKEL4Vf2ErdPfRpM8/KMWvDPIIG/1u0hvZ01Mp
   w==;
X-CSE-ConnectionGUID: fzg9LMeLQouaBCNJwlGOpw==
X-CSE-MsgGUID: 4LznCm5QSTOZqI+88u54hA==
X-IronPort-AV: E=Sophos;i="6.16,264,1744041600"; 
   d="scan'208";a="84692905"
Received: from mail-mw2nam12on2070.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([40.107.244.70])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2025 18:47:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oav9++r0RaVnbIujmzlrVCl7CI81lMNCjBsf4Wf8ERgpoDqznnogIK6VOvGdKsMcYjQ8cDW/d0UOYhNOSXn8JuSirAAcK7miTzOn5aBtcVEkwueFHvWvYMTHrhPeMvIZG3Hw41qPPK3LKJMqCt0Q1LaFrIStbvL3fV3anh8VAOnkg7VtRwkpQhyY58U+8g+9O+1j2aLZXjPUdDaZ39LFBf1i8XCLH9xUTckmReMqRRyuWsPwP3Zn8tVxiMz2OROCEiHkaO9j6ZuztuPInd3JBrDtCMpusZCW2luo7S8AT1P92OTNGci4GZD/y7YR7zQqT0t5UpHlN6JttQNs1piLqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQuisb8EnXtPv+1LMa71ftTjLXEaYjnK7hUcAlb3IO0=;
 b=F+2XADAgvGYLml5tZB9gokVk0vq5ipDTFZwMytuaxucTRGYzXZBuJMTWYXtuYTtLii5JhuArqqjQfa7f4659ui0rvcR7ZGeW/R5nwEX8UxYlxIEN8aJfZ+8rt4d+ZtwEz97Iwr1b8NXFWb6Q8eTuDlwvdaUvu48rvv3BTBMYH7ymaBGL/1fsjsqW3qSTIFPm9J/XEZUM1bQPt21D5lTGqy1Ssg3o8ymMRiJOdqb9u4YEeu3rz5EIkCb/SY/BIb0nfV4wiwiLWrGzcZUXc4fjmbnEQaWKK3mtleL2FaSSgUMhXTJgVOOjRsIWEDuF15ydQjwqy1pMhKFwcOlyxphBgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQuisb8EnXtPv+1LMa71ftTjLXEaYjnK7hUcAlb3IO0=;
 b=Fpqgem7tHv89qkOL/+d7UHyRfgsxJmNowPsS3BAR1TePBKtPW76+GPa9z7mT0miE5ukcotZwsGGnTPkEInG0v/pLNAQ5MT3BchTw0YuBD8jZUpQObUmK+od/64hciHQ++Fv+85qwbpwuRPwejZPiKQOoNG8dc5gA9H28PLabZO8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8311.namprd04.prod.outlook.com (2603:10b6:510:10b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 10:47:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 10:47:50 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 06/12] btrfs: use btrfs_record_snapshot_destroy() during
 rmdir
Thread-Topic: [PATCH 06/12] btrfs: use btrfs_record_snapshot_destroy() during
 rmdir
Thread-Index: AQHb5RgmD/Fh/8dsGEayYD9FIy29kbQTswAA
Date: Wed, 25 Jun 2025 10:47:50 +0000
Message-ID: <0b60dd37-40e1-460a-839f-6b2d96002e41@wdc.com>
References: <cover.1750709410.git.fdmanana@suse.com>
 <cfd83c633ff032b9eabe4e71ec829151461bf168.1750709411.git.fdmanana@suse.com>
In-Reply-To:
 <cfd83c633ff032b9eabe4e71ec829151461bf168.1750709411.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB8311:EE_
x-ms-office365-filtering-correlation-id: 9154c8cd-0d3d-4c44-2e32-08ddb3d5bb35
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?S3RLN2NkbmVNZE1FUjNMdUg4eU56aE1vblh5U0pTUktIb1NnMk9OamNpT3Na?=
 =?utf-8?B?L3ZEMi9UR0s5QVUzQnQ5NW0za21UWnFRajEyMkVwbHgza2d5ZW1rVnZQanha?=
 =?utf-8?B?bGdaYXJ6dXArQ3NUQmg2RlVlcnBwWVB2RzBxMUlFWGMzNjRqbjBuMEMxbnBj?=
 =?utf-8?B?SVozOGVTY0ZJWFFIRkRUM1lud0R6elZ5WUh2ZWVHUDh1MWtMRWJ2bXVOek9V?=
 =?utf-8?B?YnUrd3FPTXdwdXFmYmxodVRiNXphZlRQYU91bCt5OUJ4WVArUHZ2YkFkUVVN?=
 =?utf-8?B?bmhZckh1MWNBSFpnYjA4MGgrOU5mUzcwcVJ6cVE0cms1T29SSkE5aHBONllD?=
 =?utf-8?B?ZVllY0dDbjVsbnpFMmZ6UmxURmVtTndnOVpZc2l6eXhhczhJL3lvSDF6NHh3?=
 =?utf-8?B?N3F1dVcybFRnTElJaERhVUFLaDljRFhxTXZyOGh2VURCSXBJUFRENmtFanI1?=
 =?utf-8?B?N3UxSENQU2pESy81eDlPZUJOM1lzQ3RzUzhWUkhPZHE5Y0E0SHVNVVpGNzNn?=
 =?utf-8?B?ekYybm1JQmN6RDRpcUtEYmFENnFrVEMvS1lUajFJV2hsVUJGdXU3SjBEdFNO?=
 =?utf-8?B?dDh0RWdLS1ZGOGtqNzN0bFdCd1dQbkhCTVNiOTBiaTZsV1ZvME55Y3RBdUJs?=
 =?utf-8?B?bXpJK3lkSHVSbTg1STJWVkdCanZiMmQ3dVhycnJ3cDBrU1NnNW9VcG0yWU1F?=
 =?utf-8?B?RHcvMFhDVTM2YjRwM0U5cktENVIwUHlRa2lsdmxxanJMOW5lcndYMVlJd3FJ?=
 =?utf-8?B?MHFTdzRSbjU3aWkxL3NSZ04yenR5VWJiaWlTRHZpdHNzRzZZN1gzd1pJK0dV?=
 =?utf-8?B?cUh1cWpFNTVOeXpIVURtMG92RXU5NVRsb1VzbHpqWVhoL2Z5dUNncVdQUmFL?=
 =?utf-8?B?YVMyWlE2NlVVT3hVckVFbkpraXpVM2piTEpaYVN2Z0lEUTFXdnBMQXpyMzRy?=
 =?utf-8?B?TEp5MFpJaGhXQUxaSEh4TldFRWJPM0s4a1J6MkdHem9BclZFcGFLc2FjbnJ6?=
 =?utf-8?B?bm1LU2tQUzBaT1ZsK0VTYW82Y2tSbXRHcU94Q0xlVmVrM2NDQVlUbHgvcUVP?=
 =?utf-8?B?Wm5yZ3dwWEZudzRuNXBtS21HZkJqeDVFUTdnKzcrSGRPSStPOTVGNExHMWow?=
 =?utf-8?B?TnFqUDVqNTZsVzlmKzg2ajZpcnlSd0tWSC94Y1NHWG9CQUZmaDRGd0pBeFFV?=
 =?utf-8?B?VkNjOHZ1djVDYlYxMWJIbmhJZ2tZNS9iR3FOK3BuTEdPSVNmLzVxOXZlNitD?=
 =?utf-8?B?c3I5Q0JOT2xXcFkwa1pmRGlBSnl0MHZsOVFuWHAxdW8veERTT01LNXIwOTY2?=
 =?utf-8?B?TTNwK2JJZEwxbzdhY0V5NExlQjYyMm1KT1RlcEY3b2J4STVCOTB0NlY5MDNB?=
 =?utf-8?B?eHJTa2pNOEowTFFMUDdLSENWZHptb25PZXNsaGpkZlY1NjFLcnVxNy9zREpi?=
 =?utf-8?B?eFZXaHc1bUdPaldPbG94MnFRUHUxUXNDM3E5STBRcHZ3MFFNOTdpN1V6S1Zy?=
 =?utf-8?B?TXBEcnJENGNkbXpEUVpOVXB3Q1l6ekEyb2E2Vld4L0w2djIvRXR2TlBTVVRT?=
 =?utf-8?B?UEM4WHowVkpCK1g3bTU5WE5zQXhLb1BNcHNHbkRuK2VIM2lSc3hWSHdvS3ls?=
 =?utf-8?B?UnhPSUpab1o1endzWDJrL08rOGNzcnhBM2xjM2g1QWxud2xveFJkeVJDUVdG?=
 =?utf-8?B?ckR1N0ZJcGJ3WGJZWXR0T0UrYWw0SEJxQjJUK3c4UGdBR1ZNeDFhaWhrQjc0?=
 =?utf-8?B?OWVzN2llVDRVUEE2ZVg5SlBTWnNzbDhkLzRzaEpFWGF3dnl6NllzbHQrRDI2?=
 =?utf-8?B?MldkcmVhSk5EY3RKUVNCY0RmMGZySDBiSUFYKzlSakQ5cGFXQ0VWQ2cxTkhk?=
 =?utf-8?B?QktvMzJXYTBXdHN5bWtoTUVnbFptU0I5c2RDK0ppRmxRV1Q2TTZacWVoR0pF?=
 =?utf-8?B?UjBDUHdzYkdNR29kZ1NHN0MwQ2NhdmxPTGtuOVplVUs0RGFueTV3bHNTTzdY?=
 =?utf-8?Q?Dd7yh22U/ftbKCxq8McWGuQUQWnTlw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWZESTU2Sm9HcVZZTU9zMW43Vm9OdGY5Q0xwT2ZSYWl4UHhxY21od201SkVn?=
 =?utf-8?B?QlRpdmt2c1ZYTEJCT2N4dHRWcW51d1N0MnhrYW1TcmNCTmorZTYxRloxZGZh?=
 =?utf-8?B?Unk5TEUxS0ZSWStHN3hUakRrWXFiWko3TFNkY09hSkd4Vi8yYWpQMzlNU0th?=
 =?utf-8?B?VWV3eW1tamF4YkpROUF0akhaRXZwSUNuYTR4LzlQMU4wKzdUM0lOeWh1WDli?=
 =?utf-8?B?S3JRZzA1UnNqTUg5L1lIU0g4UVliZ0hyVjAxdHJzTlNhWjB3QUFHK0IwczRT?=
 =?utf-8?B?a0tMakdFaVAxVXZEUFB4VmMyMzFoS0IrWFhkVHVmVW9KL01SM0tGcnpQNXVa?=
 =?utf-8?B?bnUyWGhHSzJ4c2UyUkRqeUQ1SFdjWmY4aTlJYTZObjJHUS9kejhHaFljcHY1?=
 =?utf-8?B?VkhwYWg5czN1aUIweEhwSWE3dFVZa0Q0WnFvNUpTZ2hzd1FvWVFJTGZuMjNs?=
 =?utf-8?B?WUZTTk11TUoyQmx1Ym9MbVpnSERGamhPaTVUcWpxeC9jU1RTQzZsY1lRUXY2?=
 =?utf-8?B?SjVNWjRTc1ovRjBIbERvWTNBZE1IMVdpUEFVcThnWUFDc0dST25VV0JUL1FB?=
 =?utf-8?B?NlQrcHpWQUF3M1BPZEVpRHd1cndCSTUrcHpVVUJYWnNPVmFPTjRWdXZpaXVI?=
 =?utf-8?B?VHN1Z2dtRThDSUFQTzRnbWJLb2hETWhoMnJiMUkrQUdRSjNnRWcxQml4b0hX?=
 =?utf-8?B?L3lXdDQxZUpiRUJOUTFPRzRkRlBNRDZYV2JUK1U5MlQrR0k5SXo0Ukh1ZklF?=
 =?utf-8?B?azhoWE5SUDJ6TmVxY2tqTXFPTzNJOWEwOEdEM2NSSk50SnU1YnJZcnFCVTRO?=
 =?utf-8?B?a1dZT2tueWMyNzkzVG1NY1haOUswVVBFNlNJT2VNVFl0anZsRU5CNm8rcjdS?=
 =?utf-8?B?ZmlWanNRdW1pcDJWTUVIZkFLeWFheHF5TkJ5S0JSUENHWmhNL2MwOWNKOTRo?=
 =?utf-8?B?ai9zQUQ2WnRPdklKTnVXb1daOGJWKzZBbnZSZ2IwZkUya2NUekJwMnZnQ2NR?=
 =?utf-8?B?NmpiZzlMeHY4RkNXazI1WlljMXQra0c1enZZbzl3UmtackQ2VWZQc3RCNnBD?=
 =?utf-8?B?cTBVTXhvSU9uNldVS25iaFNOWTFsS3F5cEpsbEgrQ01iVFBSaFh4Z2c2K3BC?=
 =?utf-8?B?c2UwU2oxTVBMZkQ3SzRPTTY0em5ZSXZ4VXA3T1lISDhqdEpmZFY4Qm9CZHlo?=
 =?utf-8?B?eERQUnU1QWZHbHZlcWhTaHNMdzRLdmY0Y3F1VTFpWTNvQlJZQzBvTEttc1ps?=
 =?utf-8?B?TnJqSVlsK1NTOW9mMUMveFlDWVBuL3BXYkt5YU54OFpQMlphU2lNUVRYc1dU?=
 =?utf-8?B?OGoxeU53eXZRZlV1eHE4L1VEQmgyR3NlVmgyT2NUSGk4K3lUWEJ0MFdxODBw?=
 =?utf-8?B?UjFKQzBpZzRiRC9JNnhHUGpTSHBvUEZIUnZueERCWlZMaG1DY29jckgyUU1t?=
 =?utf-8?B?elBnNnJscTVoU0lWaGltaHZTNkthUGdOeHB2a2wyVWhSRjF2WGZTRm1Wdk1m?=
 =?utf-8?B?ZnRrZkFyTkpDOUF1K1puaTVydk1ybTdSdlBwQVYvdnJ1bzZlTUVEU0RrMzJS?=
 =?utf-8?B?dTltdzZ5Sm1aVlU0NUxFRzRnaU56NDRYdWI2c29FUjU3NDlEd3RZMDdpVkhk?=
 =?utf-8?B?UEhqaFpnZkVjYUY3RWpGYU02WXdEMUtoVHdTQkt2SDBOMzN1K1phRXZPNkhr?=
 =?utf-8?B?WWZtRXJ0bzRPSWc3bFJ4eForbFp2UTVqTldxUkxCcW9VV0Z6ZldqSG8vbjdS?=
 =?utf-8?B?UVBTOWdDQzdOL3VxYVcxSkIwYUJuQXZvLzRhL3g0dUM4WXJ0VGZBTTJkbkhi?=
 =?utf-8?B?cllGaDVET29tM3FIMFNRNnhCY3lBeXozZmQxZmwzMmlGcWtzUW1RZ2VsbzU4?=
 =?utf-8?B?MjN2bXpjMzhBU2NlNE5TL1MzdW9QamdOd0Jac3RBbENwRTllR3B1QTBXajJl?=
 =?utf-8?B?dUw5YXk3dWtRcE1qY1phTllVZlRMeVVxTnhIMngySVRnVEdRYThzMUtpTVJM?=
 =?utf-8?B?RmYvQ0ZzV1o0cXNQbWFRcVZJTjlRSCtwckRrOWV5YVg4amFKZ1JqWEJuRlZL?=
 =?utf-8?B?ZGJ4Qm5PdDR3U2xta3NwMFVnbkU0QWJUR05TTzkwbXNVNmkyZFpEeEU5NjZT?=
 =?utf-8?B?M25hUTFHTi9ZS2tOQ2RNMWtOdjNyT2tRUHNjVWdhcXdqL09qdXhPenhsd1BU?=
 =?utf-8?B?WkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA9C0714CDA63444B37B1E88465BDFBE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JXCT2laDWZ9CzVZc3SbhdMnqMv4LFHLw9RGi8d8auQ1uxa1zSUPr6ndjIs/ewaNv0gcBs1Jr97iNPfz1UHY8t5s1knGcqPJm2xz1SMOs1TfX3KN9cgx0cwqWDT8ddl8evzV+xl5ma4g9Hr55mrhpfp5m+XS02pqiRLwpDfqCyLQFqSVP8IDRB0DxS/y3cO/HzvT6jRBq4qaI2iHrF2yqS1o2sI0+tc++PQ/Rslasg07lOh8jwhvo3wU1T0MS3EvGsuVcvwzuvEWCbzMfvACmr9YOmcSiFh449JJAIssCYebcy2M1jioma8QEc/JDuMLDr9rwR7P6o/HR8yHkTDOJ8Zog7wzWrUgCdeggDRAK64XBsrDv+gSsFtyGfLEty/piarDebjsK/ksbdgnr3Ij2+Gx+FjQzXZh/O7Ndk01yBXez8fUJzKUP1HZ0phvuTqxbl2AK+6m3MGDMkaWnqQEtXwHnvo7nU4RMCPFbX0vMMv2uQ8ho1KdqPnJ1bQkxZvdxrfMsGrpjSfXlTNZC9D6b9Usj4k4GjhKhi1BRtUZkLnMJgoUDRc2hljmDPE7T+s1Y+SS211wSXRiPmS/eIJuZmJMsM4HOOkR/Et+M0xIz6KwB0dUZ5fL+aVWGq/VinMUU
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9154c8cd-0d3d-4c44-2e32-08ddb3d5bb35
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 10:47:50.6094
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hafvaUX12SWQ18RPFT7gaeFC50X/kQviU4s1klov78hSd0EiIw9dROKBkhyPl7Q2J+X3PADbuPgAaXhSMugaGU4PC3mWnSXs2PfGISiMuOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8311

U2hvdWxkbid0IHRoaXMgYmUgbWVyZ2VkIGludG8gNS8xMj8NCg==

