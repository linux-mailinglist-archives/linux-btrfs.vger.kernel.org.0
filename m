Return-Path: <linux-btrfs+bounces-7983-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD6497786E
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 07:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3EFB223DA
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 Sep 2024 05:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE16187356;
	Fri, 13 Sep 2024 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qBU3z08N";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iOG5y7AL"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20511D52B;
	Fri, 13 Sep 2024 05:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206165; cv=fail; b=JnJCsrCvlxGQm0MEA4wM+h0c30zOf6O1c2JVaH4/VUL4/aCtSYLd/SvtWaXEwmCUO8TitMgI6zWkRamWuy2swlzLR8F8BeXv1ZB43LrIsDk6mQwj3smb2SgF2LfM4TKPVXq8h/YsB6IgN45R27Ws7bMT+FGIrJE9mF6XFZDsZC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206165; c=relaxed/simple;
	bh=o/cHBSom9yPg02xThK0RWVnp1gcxSBeN7iQuwijEE+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkmhMIDi73C9eE9yX4rzVADbvqlHIwGoqcCkc94eLlqfLyM6565noSPDudDCKb//1SbjF9hgE5l35TDxQ3fl8/mS6GWX28WyR81SlBpG4VPTpfgk0iQyHe8MBEKEyGFcZXxE1SertK2wooddoM/JXx1WUMzXzCimtlcAWZUF3es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qBU3z08N; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=iOG5y7AL; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1726206163; x=1757742163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o/cHBSom9yPg02xThK0RWVnp1gcxSBeN7iQuwijEE+k=;
  b=qBU3z08NsZ1BooKO3ySZBStbC2nwt9cuxCk+dVk3BmpoJjIj7Gens9mJ
   u1oU8XE3+QrheITjeZePI4P0BFIeFj6lLewQQO4WyX5L/fp8kKQBgL97X
   aJJGGeNnSU5+IQXggLjvAwCpTVEVGrFSzmVVxsV9RWw8qICJboEB6DpOI
   iu+jdedH8f5vss15gUipVvD0qySG0fQ8Ig0lNqG64R8Pio3GALV8EyxUt
   ZwyixnwHUOw69qZ4IOQX+rKSZ2GeW+fmsxUgJFpiPJN4VRIL/CDn6L00l
   DlCVFgmyV9fDGKwvEDOiyva22KnCLjJmixE8+ZDnM9t3vX31G9KRaCWpI
   g==;
X-CSE-ConnectionGUID: /jAqPXanQreI43TkWW+iYw==
X-CSE-MsgGUID: ydDiXCpMQ+6m7V01o78CpQ==
X-IronPort-AV: E=Sophos;i="6.10,225,1719849600"; 
   d="scan'208";a="25963006"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 13 Sep 2024 13:42:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQDszUBhEyYmKQAxP6Ow/egA9r97wSU1sLwxKIHQ7a2lTRkqsW91myNQwdDU5hmNQkjTUC0khyTl6k/VD6Dp59cCnErMSqwy8ofo/x8/F+HHmuFgmgMeUwKTxk6yNWGWPKfxUhk3YZ00ZzUKi7f6f8/DrMlA0ESIhc9ADhg7QZhSN195tY7Z9yDu7X73c1IQCgWWCAHGcRY5UgRzz0hixQhf3eNvLk6CNA3DMytYENh3BGSDmaieFe2K8w4cNbbLIwFhTMjqMxqSHDvqjgyJhRc7yajB9WLZ1bl5rOBK/n+lS1v4gRIo2CD9ZDD5WQdnbB4TQ+qYdLMBgAgBUJ6zgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/cHBSom9yPg02xThK0RWVnp1gcxSBeN7iQuwijEE+k=;
 b=fuZwX8yaLydjPpY8BgOcV22IkY5yRV1Mq1elhVCCsnybaAjAGwDTWE0GthXeLFACOEaXvBPspGDrSc86EogqEOs4ClMmz0MTUpY1yv3rIGMEK8fGglKLR2LlGsSaevXEUndj7zfrn8tf+sHSEXA9tRZrTJZl59Ia2SsXVPa4iG0Pa+1ssKOYuS+NjqV50d53gR6aslRqkqGeOMC42Ej/sYQT4adXA3zRumrxBkb7txLWV6wfDUifI6HElaGIC5OBFdiCExd9PgSQMru65cAml28ICPD5FnVvvMW+6gywOOELE2t1BD5JU9rmeOZaZX/HBnL3B4iYfIZ6oTEliSo19Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/cHBSom9yPg02xThK0RWVnp1gcxSBeN7iQuwijEE+k=;
 b=iOG5y7AL6DH4Jzm/els5Bk1KSaR1nMlj6rPsRTgLmpVIdutctur2FduUjMfeLFsVAw+nMj+Ony5gS6m+jJ/UURq4qi/TgVsbXdFkjt34dXE2jwUApKsBQ2XWYNvG07G4+YBXVOvyNCqa5m6+G9Nx02CmwugtYkYbtg18Y9zpNUA=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by MW4PR04MB7457.namprd04.prod.outlook.com (2603:10b6:303:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Fri, 13 Sep
 2024 05:42:39 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::17f4:5aba:f655:afe9%3]) with mapi id 15.20.7962.017; Fri, 13 Sep 2024
 05:42:38 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: WenRuo Qu <wqu@suse.com>
Subject: Re: [PATCH] btrfs: scrub: skip PREALLOC extents on RAID stripe-tree
Thread-Topic: [PATCH] btrfs: scrub: skip PREALLOC extents on RAID stripe-tree
Thread-Index: AQHbBSC+kvSg3UAINUmNY6YxZZJ+o7JUrEqAgACI8AA=
Date: Fri, 13 Sep 2024 05:42:38 +0000
Message-ID: <958f5586-c37a-4836-87a2-4530428b0a4e@wdc.com>
References: <20240912143312.14442-1-jth@kernel.org>
 <a0d0fa88-e67c-4b35-88b4-74c5b15a16bb@gmx.com>
In-Reply-To: <a0d0fa88-e67c-4b35-88b4-74c5b15a16bb@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR04MB7418:EE_|MW4PR04MB7457:EE_
x-ms-office365-filtering-correlation-id: 08eb796a-a59b-4375-c685-08dcd3b6e0d0
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cnRHclh4VVR1WjB6cmJrR1BOMGptMnR6ckN4VFowZ3BTQmc0ekE4T2RLSGdk?=
 =?utf-8?B?bUVuL0J4V1hTU2xpQU01elpvR1pFcVgxRW1SU2dzUVN1V0NyamRRUHNTdnNj?=
 =?utf-8?B?R0hpRHk0bHRQU2ZGMjVFSG91OW9SRURJYTlqWjRmWVhTZXh1RXQrSzFxbXJZ?=
 =?utf-8?B?V0EzaXYvekZOME9pMzdONXdwUm4rUHhkei9rcWdnaWlQeU1nT21aR045MCs3?=
 =?utf-8?B?eWZMdTJoNTRwSDc2Z1d4VHNhbzNGQVBmN05zVlFNVnRnTkc1MlJiRVpZT25L?=
 =?utf-8?B?NjBBWDg2YmFBMHRKeW1GRkhHYmlaRnd4WFNhWFFKZ1B2alpLdWpGdkx5VUIv?=
 =?utf-8?B?bXpGMFpFekk4SnNIaDZBWXNuQk92N2lWL21JaERqZUg1SVYzWmtqY1pBQ09s?=
 =?utf-8?B?MHJqWVF2WHY0ejBUNlBEb3Y2T2dSa0ZCTkE2WFJNekpDOFJxTnlEcXBtcWxy?=
 =?utf-8?B?Rkp1bkMzcmNmNytreFFzV3d6aWRJTnhDWDE3N3dodnQ1L0ZIK0pETnd1c2tG?=
 =?utf-8?B?a0ZpZXNNT2ZaZUhSRURRTDZTakRlbEQxU3pjaUFaQjNtTVNiSDcyZDl4dXov?=
 =?utf-8?B?MHZydUVsMVN6YUoyL3FNOUFZUE11M0RJK2EvNUN5bGxGRlowY1h5dTd1d0FS?=
 =?utf-8?B?YkNjeXlKSC9JUExTTlFXWmI5TmdKeUZkbHY2emRNK0VPQmFsaG1aMndtcjc1?=
 =?utf-8?B?V3p3c0Fhem5wVHFacE9ZaXQwRjFhL2VBejhYd3FBcmlaWmhmeTJITVVJbVlx?=
 =?utf-8?B?QTYyRW9xNHJUM01DQkU2RkpGa05jMVV6LzR5V0xlTWRsbDJXL1IyS0VhZ1Rz?=
 =?utf-8?B?MWFyUWt3RkxTT2F3OWo0TGFza2hVcGYzYkVCNFd1aGdHd0RqSWRBZTl0bEU5?=
 =?utf-8?B?NlUrVzM3bnpaS3d5OCsrM0FmR3UyREU0R1FmZUtNZThWU0R4SGk4RlVmK3po?=
 =?utf-8?B?RnlXTHlyRzRBYk56MmJsNTdSdEF0andlS1VxTXFnKzl0YzA4NG9LU1VPVjRz?=
 =?utf-8?B?MlUxV3VBeWY2MkJpK0E0ZWswWWhhMFVyUEdXVzNlS0ZuWWplZ2VSUEo5QzU2?=
 =?utf-8?B?MkJ3aGpxY1NycWFPeEtsV25aRVVmTi9IOTJXdk54OFBlemZ4K2lKeGRXbG9Q?=
 =?utf-8?B?SEdlbU5FMFlRSjJKR3RiSHpXSVVjdHEvU3Z4SE5YbzZPZjdyYTNobXZJUTBr?=
 =?utf-8?B?eXVvQkJvOWpoZzY2UnNXV3FVRnNmU0VUK2pSNWU2SmVJMTJEenFyS1BGcE9Y?=
 =?utf-8?B?ZnhabzNTRlVUNUUzUnljaUVQdHp0WkxZVi9tTm51cXlNWTVhWjYxbHdVb3Rt?=
 =?utf-8?B?MkxBUmFjSFVBT253L0hmb0kxNjFsQUdaTDNLbU5wM0crTTN3TWtEMVlQV0wy?=
 =?utf-8?B?U0lOd3dCUUlNbmc5bG5zYVFoYWJXTEdIU3Y4OTZkUGZXWnR4bmJnaEY1TDgz?=
 =?utf-8?B?d25wRm90YUdFbCtpQ1FKbGZ6SmNTdGdxMVVFZ1ZkTk51a1huN2Rma0pvMXg3?=
 =?utf-8?B?eU5rMm1yT1owRmJLTzNMNlVvdFZrK3pBU1U2ZHE3dmZwMFRNamUrR2tjY1J1?=
 =?utf-8?B?ai9tNGNSRjhYYTJDZ3RoZzlSVVlOZndsV2o3T3BtNkJ4RzUySU1XNXpIUUJF?=
 =?utf-8?B?RFI2ZzJ4MTM1RXl5aEZwcCtyeTlMZFF2NVF1SjhvMzdKMDRCci9Lb0tPWElC?=
 =?utf-8?B?NEJHR0hUTFJFUkV4d1NYZGJSdDZPQ1E3TVpaSlo0ZEJsczdZNVNuQzI4RG1t?=
 =?utf-8?B?T0lTOStiVkNZdDVmdzkvR3NLNE5neUQ2RGRheS9WdjhRU1laOWMvSDNPTUFO?=
 =?utf-8?B?MVhmL3UrQ3JabTNGTU9jeUNpblpEd0IrNUVrVWFqQlgrUlJrWG1lTkRUc2xX?=
 =?utf-8?B?YXoybW5vaUxLNHV5anROT3gwVmdKK2NkaU5EbDk2L0s0ZHc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2J2aTV6bjlBc1c4aHByL0hncVduVVRoUW5oWmJZZE16TzdsTkcyRDF1ODhQ?=
 =?utf-8?B?SkJDMzI1TVR1cnN0TkNjU0xoNWh4Z3pYRStSRUFFenVSM2xnYzN6NDVMa1VU?=
 =?utf-8?B?aGFPSEppT1gzWEdCTlBGNm4ra1F1YXF5cUZrK3RhRFl0UitlbjkydGFabEU2?=
 =?utf-8?B?SFpPWG10eEFJM0xuTG9HVVVZS0Q2eXZTVU5kMDl4WGVEanRTNVQzY1Erb2wx?=
 =?utf-8?B?bHhJcWt0Z25IVXZpVHliZ0RMWTRkMVVrZmtPbi9vZjdUdlUyR2szT2JUZi9I?=
 =?utf-8?B?Y1VrZzVvNlNwVzdHSlhyck1kNGlQTUUwQjhaQVdjcWZBeVM5dGNSanJzVVFz?=
 =?utf-8?B?S0FZc2NtVmVsd1NhTU9IL3FVSXdjaVEzUkpRVHNBQTNMdllqL2JXOEtBOFFJ?=
 =?utf-8?B?RDdSTUJ2L0l5MlRiZVliYXhzMitPc29mSm9aQi9hem1qSjdzL2lzbmpUeUoy?=
 =?utf-8?B?L3MvRS93MEplaVRhbW1ZdVdQVWdDOVBYVHRLVjlWQVVhYVJPdEl5VWtsQXJE?=
 =?utf-8?B?VFBVWEhMWU9qaVVSTnQ0MitOOVoxdVNDMkVyWXY2b0dRTkdDQUR4S2JkaUI4?=
 =?utf-8?B?UUhTbDhhSmM1aElMR0t3NEZPV21nUzQ5S08xWFNZUkVqbVVMR0ljSVBQd3JW?=
 =?utf-8?B?MmdBTDlaT003R1RHdlBBRVp1dDdJQXZPSCtKUGVFaWRwazBWN3EyR3I0dWZG?=
 =?utf-8?B?NjNJQm5XZzdydFVrZ2QyZ2N3a3hwd1prT0lOZjEzdFYzRDNqUzJEbG43VlhS?=
 =?utf-8?B?aDlnZUhUT0dkUEdHbDBvM2NLVUhBZWFUMXIxUEQ2TlJTRHplaTBlRlVuWFBy?=
 =?utf-8?B?RzF1STNZMm92d0NBR1FKOHU0cWZzQTBEOGxWZHdXMVp6dWVFSWdSc3N5VVZT?=
 =?utf-8?B?YkNTVWRoNUlhMVlnem96U3doak9DanI4S0Jza2pxU2prWHl6SVFaaFl0QTBZ?=
 =?utf-8?B?Rm0wUXE2UGo2a2FUVVNINWQxb2x6aUovWkJrSUs4OFN6OTllbVRtS2ZkRjFE?=
 =?utf-8?B?WmtvbnhUY2dmOHhIbVBZMjE2cjFlcTFNYUlsM1F0d21jTzZrVE1Qd0RRRjVB?=
 =?utf-8?B?MkNjajlsajBOd01KQlJuZzYwM2pyanl4aWFzK01GVExTcERRc3lzNkNGTjVv?=
 =?utf-8?B?cHo1ZHVjT240bG9TbDBaTXBoczZQL1FZQ2J1WFo1ZVFJVXphQmp3bHpPRWlQ?=
 =?utf-8?B?Q2pnSGxZaWJpZ3RMWEVkT3VXVGlqWWoySjdGNnBTd2hzOU1SbmFpVXR3eHQw?=
 =?utf-8?B?bVRDY0JPZ3RzRGdMeW8xaGV2WUc3ejhSVWlWeklxcWExYkdyNko3S291VFZ0?=
 =?utf-8?B?YkZuQ0VvZzRNd2YrWGRIdk1STHdicExJSXlwRytUZXAyVmdISndIRndCNTNK?=
 =?utf-8?B?TGdYaWRScEVyUWRZZFpZV3JmVnBwOVNObXlNOU1tSzExU0dHK1pyWWxJUWxW?=
 =?utf-8?B?ejlIRGcwUElHQW5yaGhVOWROeU1ENzdPaTV0cjkwSVNmWStxN3VnQ1hSYWd4?=
 =?utf-8?B?NGRsWHo4ODZQQm8zK29kK3p4R3hEdkgvZStlZTdVaFpqMTVuWnBJSXNuTVhz?=
 =?utf-8?B?enc4RGdPZytDanhJb2Y4NUM2NDZMbVhaTzBneHVTT1REdHFMbU9uSEhyOFJS?=
 =?utf-8?B?VnZOK1Zzbmt3enNPWkdqVzk3NXUrQVpQU0ozTUNmcEtickdvcmJhcGFzSFBi?=
 =?utf-8?B?Um9wR3VxdDk5V3JwOFp2aW82TkMwVVI5TzhXcVZ3WXRpQkRxRndZdUxIdE0v?=
 =?utf-8?B?bGlZMmZleFFpeHY5V0kwVlk2Q0RxVUJIMnZIWkUzTXd3MDJPU2hzdkFPeUQw?=
 =?utf-8?B?UzJTTGNuY3FTMXVEUGR1OWtra1NLR3hWZFN4U1RJb0R4TjRDeElJak5XMXJp?=
 =?utf-8?B?VVVnbEpkbVdlMnpBNklWWmllVW9qZ2hVdXAvcjNIN2hvbTk3a1lPbEZ6Wi9Q?=
 =?utf-8?B?czNzaVRZWVJpYVlJdjBJUGtuZzk2d1p4ME1VaGlVK1p5L0JlakpEaGdzVFhS?=
 =?utf-8?B?ZmJQMGtwcUlzejhEaC84UnJmdVBsK1ZtYU02MDl4S0hvVm9QSlRiTTk3TkhH?=
 =?utf-8?B?UjYyUUtZZUlmeHNJR3ZXZFVIZko3WjlpamlNZ2lxdUZFQVJnamoyNGJJNDcz?=
 =?utf-8?B?bzQ2ZGNGa1J4VWRHbCs0YmJNdi84VTUwRGh6T3NrTzluaVc4SytrWW83N3hS?=
 =?utf-8?B?OGFTUFYya2lmMjQ3L2NHL1d4WHpXZnFQSlRmSWhKNnBNbE9zamJOYi8vdlZn?=
 =?utf-8?B?TndzOW4yWHpKc2xQdnV6d1NiaDJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <791FCFE4AFFD3949A14B2AB9B5F7DE90@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ebIG/oD18XLGXYd5yQUkgY8/z4DpVBwdjZmcbvx1wK40TdJFtqfJj/tliMd1DAUIbdR0V8uQs8TMgz+gx6aGgdpOOfgYH0xoMKRkByIasoNO+94HlQBDObQIauCcoJ8osGre8kJnbPFASEgrBfUp/m8aGYl3As9BoP+dc0JG4IT39HxSsNAxwyvOeaCcPE1cGLww3G8OxNs5i+YKEOr7TMQ5RQkmhFoqZUVnJHjnQBZ5P7ZaoFflQNwt6JZlhEbaoaVMustJ7nityfWBqozsctPfs6p6MP+Dwo9csTBcCxFmHoIn816RDWFiSojFyv/MBqTDs7/5zC1zHkwH//zqRpdPDVvenHZy6Drcqqy5sqNC6J+3G5KRJ15EsvFmt+yQ3dxH7KHFnWvyyXcKcYt28TLP74EoRkdYFour2iJKiiE6E84tS/fqSXQMvXGBQQeO5D5ZT1iOcsNtRGBWZXKHhagx7w2iynd9nscV1HL0i4qBJUdglruc05U2JO66crupuW61vVD7z49SG49hT+da8r/HaeIsQpdCDRKqeFBTI7PJMe46Ml+lonEXSW7gFomt6ZZ+U1843pGGhXX+fi1XG6aocEdShrwTVgguVVWeOgQNtdjN38Hk6AVmkpYyqEfr
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08eb796a-a59b-4375-c685-08dcd3b6e0d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 05:42:38.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r5zF1Z3VF3c66gj3WNUhzgLJROUQ6UN2RTzLbXPLOaqE3dUeTrS3l4eBWTyvcjOzkzphvfrkyW816uCFDgITdVCIEUsfycxtmQecdFrcF7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7457

T24gMTIuMDkuMjQgMjM6MzIsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC85
LzEzIDAwOjAzLCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPj4gRnJvbTogSm9oYW5uZXMg
VGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+DQo+PiBXaGVuIHNjcnVi
YmluZyBhIFJBSUQgc3RyaXBlLXRyZWUgYmFzZWQgZmlsZXN5c3RlbSB3aXRoIHByZWFsbG9jYXRl
ZA0KPj4gZXh0ZW50cywgdGhlIGJ0cmZzX21hcF9ibG9jaygpIGNhbGxlZCBieQ0KPj4gc2NydWJf
c3VibWl0X2V4dGVudF9zZWN0b3JfcmVhZCgpIHdpbGwgcmV0dXJuIEVOT0VOVCwgYmVjYXVzZSB0
aGVyZSBpcw0KPj4gbm8gUkFJRCBzdHJpcGUtdHJlZSBlbnRyeSBmb3IgcHJlYWxsb2NhdGVkIGV4
dGVudHMuIFRoaXMgdGhlbiBjYXVzZXMNCj4+IHRoZSBzZWN0b3IgdG8gYmUgbWFya2VkIGFzIGEg
c2VjdG9yIHdpdGggYW4gSS9PIGVycm9yLg0KPj4NCj4+IFRvIHByZXZlbnQgdGhpcyBmYWxzZSBh
bGVydCBkb24ndCBtYXJrIHNlY290b3JzIGZvciB0aGF0DQo+PiBidHJmc19tYXBfYmxvY2soKSBy
ZXR1cm5lZCBhbiBFTk9FTlQgYXMgSS9PIGVycm9ycyBidXQgc2tpcCB0aGVtLg0KPj4NCj4+IFRo
aXMgcmVzdWx0cyBmb3IgZXhhbXBsZSBpbiBlcnJvcnMgaW4gZnN0ZXN0cycgYnRyZnMvMDYwIC4u
IGJ0cmZzLzA3NA0KPj4gd2hpY2ggYWxsIHBlcmZvcm0gZnNzdHJlc3MgYW5kIHNjcnViIG9wZXJh
dGlvbnMuIFdoaXQgdGhpcyBmaXgsIHRoZXNlDQo+PiBlcnJvcnMgYXJlIGdvbmUgYW5kIHRoZSB0
ZXN0cyBwYXNzIGFnYWluLg0KPj4NCj4+IENjOiBRdSBXZW5ydSA8d3F1QHN1c2UuY29tPg0KPiAN
Cj4gTXkgY29uY2VybiBpcywgRU5PRU5UIGNhbiBiZSBzb21lIHJlYWwgcHJvYmxlbXMgb3RoZXIg
dGhhbiBQUkVBTExPQy4NCj4gSSdkIHByZWZlciB0aGlzIHRvIGJlIHRoZSBsYXN0LXJlc29ydCBt
ZXRob2QuDQoNCkhtIGJ1dCB3aGF0IGVsc2UgY291bGQgY3JlYXRlIGFuIGVudHJ5IGluIHRoZSBl
eHRlbnQgdHJlZSB3aXRob3V0IGhhdmluZyANCml0IGluIHRoZSBzdHJpcGUgdHJlZT8gSSBjYW4n
dCByZWFsbHkgdGhpbmsgb2YgYSBzaXR1YXRpb24gY3JlYXRpbmcgdGhpcyANCmxheW91dC4NCg0K
DQo+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGNyZWF0ZSBhbiBSU1QgZW50cnkgZm9yIHByZWFs
bG9jYXRlZCBvcGVyYXRpb25zDQo+IG1hbnVhbGx5PyBFLmcuIHdpdGhvdXQgY3JlYXRpbmcgYSBk
dW1teSBPRSwgYnV0IGp1c3QgaW5zZXJ0IHRoZSBuZWVkZWQNCj4gUlNUIGVudHJpZXMgaW50byBS
U1QgdHJlZSBhdCBmYWxsb2NhdGUgdGltZT8NCg0KTGV0IG1lIGdpdmUgaXQgYSB0cnkuIEJ1dCBJ
J20gYSBiaXQgbGVzcyBoYXBweSB0byBkbyBzbywgYXMgUlNUIGFscmVhZHkgDQppbmNyZWFzZXMg
dGhlIHdyaXRlIGFtcGxpZmljYXRpb24uDQo=

