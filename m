Return-Path: <linux-btrfs+bounces-6462-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF5F93133A
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 13:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4011C1C21AC0
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jul 2024 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07211189F5F;
	Mon, 15 Jul 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qp52St89";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ELZOXpzm"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20355185E5B;
	Mon, 15 Jul 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721043515; cv=fail; b=kVA8qkwzCP/Ph2Oj/vskS7qq24xEcivyMfz97UlHSdr9iDr4kdlPi1/+lB18/UJa800dyNgpAtrKBT5UKcLzCJDnHd7eMRIhWGfMmpsfkdslW/II4fls6Xg731XihmUPKmIpBqOIwDf6r+XHtIIsb79hkT1rfra064LGvkXu39c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721043515; c=relaxed/simple;
	bh=s4a3v7SXbVwdydWkntTgCU3r9wGUMp8oZI1FzoLuZtM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k2yZM12G8lb2kxKfB4Qd8N/Xjh1C4KfaNeVptalbT9cL//hyGh7k1JsI+nUX98vltJGRuErxu0B6Vb5ZcnvoEPWYU6ezfRk1oAfmZ30ec44I5EOwIBAZ9Lm2bqycMQ29H3sf800XEpOaTm2eyi94rwiSx6e9Cb0DJTtgJMXFb9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Qp52St89; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ELZOXpzm; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1721043513; x=1752579513;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=s4a3v7SXbVwdydWkntTgCU3r9wGUMp8oZI1FzoLuZtM=;
  b=Qp52St89eZsu0SAMj9ZXFzw/DYHpNq8L/hdD4uotHy4tqRhX+cSnCApT
   4WLSz+D/m+dkwgdpE4kOJVfTWm7psDWkSWiTdwl2kwRU1TZj/0nBxpwc9
   WaJ7Juh/GsBj2stu+sJcKVs9NqmseLim5Jx5Afqi+4WJ9Bwj0Kql++y26
   dZOYizqa8iY/uYHxl1FEIfaF7X9y84wtzijiwac4LRkRNdCVVIhn5oDZz
   xtKBtL6oD5Z5AQC9oR3FATEg8XIgCC3ZCFidHfWYTQgcuyybhStpa1x3n
   ixoQbHVzCbVyRIcO13v8TNTibef2OB1XBFbaEoAZTIQ5SSpupjtRXqoDr
   A==;
X-CSE-ConnectionGUID: 4cm2XqOuSpumt4Z/oEWtEw==
X-CSE-MsgGUID: 3u9qGQWQTX+Cy6CV3O3HEQ==
X-IronPort-AV: E=Sophos;i="6.09,210,1716220800"; 
   d="scan'208";a="22501320"
Received: from mail-southcentralusazlp17012048.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.48])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jul 2024 19:38:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7E09XSQiz3tPTqiQBZp9V5/BUcbB3SIcqDtpob40HWaZfdDfLkHxBZ/JzhJyvMY3OXGzsZm3vsbjxs6/N5hzu0DKDflWEZ3oqSSrs+MjK9d1IqGkEwuVszlfV4dlt/rOMAAb7SKCkHzIY41eaU0XcQYPsMJuFL5102kC+tk4nThn0dOfhZKLLHi5YfRRAkmkPDx+EpRvrUfug5q17DMA4TZOqvuv6N+uS0LbRK/bGczp/rFsOwW4Rbed4wRWrA189xQvsFnp0kbxuZ4sZCIvAKcCI9+NykOH5/F3Etka9OqpjF/QHbb7TuT3HRUeQywf1lu4Qn3CVfLrwx085W+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4a3v7SXbVwdydWkntTgCU3r9wGUMp8oZI1FzoLuZtM=;
 b=to1KmlFGSi9ZMaUcgdQR4ujpaeE+O5ifaV+Itvei3ua1S1+V5sNIBsQVwUf15XOZi/TegvuYFK9ZOnTyDcqPxo6vwhaVD661JwF/N47ennfvsgjvnVlw+c24sYt6VT28n99L8pOkSIugxEn+b3LelaGYbusc/R6crlt8YQTo6B14RqctJLYrWatm8ejPpe1XdU7E5f4tLfiN8hTcG1FJUYaPHoalDhsUpfxWJ4/JEVVj+YRBwFFGS4pZ4/2QruQ8IEcSm/AotjT7wLH8hg8xFeqcvbdhG2Jgdi6yL5X7HD0cCCcZwW3WtXPwXrb95Q5lFxiTCoCzBb7ycB+iBc03KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4a3v7SXbVwdydWkntTgCU3r9wGUMp8oZI1FzoLuZtM=;
 b=ELZOXpzmBEDoDdsfprpsgOBQYBmUHyXnpfPGruPbwvWYD9OwSZbfWCkuCz2ZOQ7R8grB7wHsiAoY7/BviicuXZJRjqgCOm9kujLdLf4uFaerOA/UUvuB17dcJzJsO5I76mvgJle26APEc79Ff4BunM8huC0MA4eKu53YwKuUrGc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CO6PR04MB7873.namprd04.prod.outlook.com (2603:10b6:303:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 11:38:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 11:38:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Qu Wenru <wqu@suse.com>
Subject: Re: [PATCH v3 1/3] btrfs: don't hold dev_replace rwsem over whole of
 btrfs_map_block
Thread-Topic: [PATCH v3 1/3] btrfs: don't hold dev_replace rwsem over whole of
 btrfs_map_block
Thread-Index: AQHa1C/wl34TmZt1SkS8IJ4e7EmXXrH3rAIAgAACnYA=
Date: Mon, 15 Jul 2024 11:38:23 +0000
Message-ID: <516627f6-4568-4d4d-bfc2-0fcf6b870ad8@wdc.com>
References: <20240712-b4-rst-updates-v3-0-5cf27dac98a7@kernel.org>
 <20240712-b4-rst-updates-v3-1-5cf27dac98a7@kernel.org>
 <CAL3q7H7rFsNf1JOW0MmAda544QKe4GGwNarBQ2VaTytJgQNnsA@mail.gmail.com>
In-Reply-To:
 <CAL3q7H7rFsNf1JOW0MmAda544QKe4GGwNarBQ2VaTytJgQNnsA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CO6PR04MB7873:EE_
x-ms-office365-filtering-correlation-id: d953ea1c-e049-4641-01cc-08dca4c2a292
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UkJyNnRGQStPekdEaFMxTXdsek11TDQ0UkZ2RlgvVWtIRmJOcVFjQUVQc1kr?=
 =?utf-8?B?N2gwN0pNOFBqZHVHZk8yNmFkeU1qR1ZmZFZqaFBtdzFGZ3loVWt6ME1sRGV5?=
 =?utf-8?B?SGlmbGpNeExXY0lBVHFnMW9reFRjb1RUWVI5SXkrZHk1R0l6STB1elJQcit0?=
 =?utf-8?B?ZnhmZWFWM1JYaW5LZC9Ja0VoU0JLanYwZng5T0p1M2RWaTI2KzRXVGxrbEVy?=
 =?utf-8?B?WldYV0dqa0tQM0Q5YUhNUlp4S2dVTC80T0w3bHlVaDlpZzhGNE1LYWxXNCtV?=
 =?utf-8?B?M25vZ2dXQ0MwL1d1RkpDMFphVGpzM2txTHBXOGdielhMMmxBeTNqWTRTQmdZ?=
 =?utf-8?B?V254b0xldW1lb1BQM2k1Sy9OcXZnNVRFbDVQTUsxMTVPVDBPeVgrQTlKT0w2?=
 =?utf-8?B?YTZFZHB2a1dEWThXaVNSUllNdUdQM2p5MTFaZC82dllJemUrSFZzVU1NVnI2?=
 =?utf-8?B?VkhkRU9kNlp1NjdBVlg4N3V1emtndVV2QkZaeWlmQnZraUNCZTlCTlRoVy9o?=
 =?utf-8?B?bE1XcDZUam0zTzlsMXIyeE9EMHhVdlBTZEFJalkyRGZlS1llSTNGTHpyb2tG?=
 =?utf-8?B?aE1ZaGNWY3lmcnowTkxaQkVaQUdUMFN6V0M3eEp6bHpKN3RzL05YQThaUXA1?=
 =?utf-8?B?c3BEbGNHQjM0UUp6Vyt5bXJIcE9vczdycUpXZXJNNjE1NmM1aWFMZlhZdURL?=
 =?utf-8?B?NHdBdVR3eTNYUDVLc1NkaWFpdmNFVE5JL3RFL0dIMUI2Z21ZdzdXNzc2alRM?=
 =?utf-8?B?N0htR2poMG1OUVBUTGZuZ0YwU2Y0RGd1Q1ZGbHMxK3lZaGtXbWxqNkFXNGFR?=
 =?utf-8?B?ZDZQS05sSGJYVGNVTUo5RzdIeVNEc2ZZTGdla0tCT0lFdmFzRGJ4a0dvdllL?=
 =?utf-8?B?TDBVTHlKWDJXU0ZLYkwwc2RzVkx5dS95SnRrWFY2ZlZTLzkwbWJUMWVsdUYr?=
 =?utf-8?B?bWdjZmNQQ3FvQnl3YllQSDRFZ3ZRdC84ZGNsZ2ZSRDVtR3ZTK1hHS3lxd0pE?=
 =?utf-8?B?cGlSTjZZL3BMUUNxOW5raWNyNHNVS3dOVzhjQTVtS01ZeU9QcWpLeFBtK3h4?=
 =?utf-8?B?QkJ0MHNxb2FtdDk2UlJTL3JkODZvM0FJNGJOZkZmTU83WERYZWtFZWpwQmk3?=
 =?utf-8?B?Z0U2cGtLbE51aXZtcTB6ZmRpQTluVlRycVVPUDlWZzdDakJtZEV0M1JSTnQ2?=
 =?utf-8?B?K2htbzI3WDVtY2IzaUNIMSs0Wm5taWh0L0svQ2Q4V3k1VVVmNkRXQzF0dXRL?=
 =?utf-8?B?REp0c0sxb3FZWDdUZHRBSGswc0xVbnU1SjUzaVpJNUZYektCMkdPbDhRU0dm?=
 =?utf-8?B?RmVvSEdxWkwyOGhSWkMxRXZOVGR0R1RHNE1VM0FKQ2dSaTlRUHZ5RmowanZx?=
 =?utf-8?B?R0JqWkY1SG1NaWs0ZXNXcXNVTElKaGZRM1JRWk1TR3lUTnR4eWp4bis1OGl3?=
 =?utf-8?B?bG1yUXNRdS9CTkJRdUJXNkJPeW10TWVOdmR5YzNncXRGVFBMaFNSdHhVeFJL?=
 =?utf-8?B?WlcrMFl5VkMwNXBUNlJMc3JJZ0FFZEU2UXJlTVNuWTJXQ2J5U0RjaER0RmM4?=
 =?utf-8?B?Sm96a05EbUUwVkJUQW1sU2U4a01yVjlaOHlTdVpoMDJxdEljQS9nTXUxeFhn?=
 =?utf-8?B?Z2F6ZWdpR1A4dGNveGZLaDhCR0NCSmVZZmV5Qjk0NjlHUEpJM0FJYVp4Vndw?=
 =?utf-8?B?T1JrQnpMaFRSWkdPMUhKdkhRMVB4cVozNU1YcVFpTnpKVG1DMnBhUE5sWSth?=
 =?utf-8?B?amdPdE1QVmxaVllwS0ZSVklyNFVSaVRxdjVWYjBqVE5LVXJjNDBBNEVHWmEx?=
 =?utf-8?B?SjBSdkJzZ1AvTFpYMEtoVTJsMmxlVGRENldwRm1xalJOcjlxTjRSNmZxQThD?=
 =?utf-8?B?Sllranl2NGRtdGZPU3FNYVRHSGxYMG9XeFZLdzhFVkVGQ1E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aFIvVXJaNjc4QnV4SlEvWmZnZ0pIbkM5V0Fmck5rVzBZQ2N6REQvTWlUaXRF?=
 =?utf-8?B?bXNFMm1RT2RqQnc3eisvSVF2Y2R4ODhTRm1XK2h5NFN6UVB3NGVIMVBabDdk?=
 =?utf-8?B?eXFRVnFjZVZES2h1bGlqZWthWDJwdXdYVDhTUkVBVUhnbDc1U2FZQ0lJTXNW?=
 =?utf-8?B?ejg2dncxY3MwbkwxenNqUjlVU3J1blhnbHhBeUl6TkUyWDgvbWVUa080YitH?=
 =?utf-8?B?VVJrV1JsRW5CS0gvNVhuSS93dHdIUFIzcU5VZGhGYkdrZFRpZFZoN2xsMUdQ?=
 =?utf-8?B?N3htREYvZjgwR2NpVXcvaTRMNVFpUG5BT3Nzd00wSStpbTNreFlVSlpoUVV3?=
 =?utf-8?B?TVhRZk1tbnpGVjVUVDVqT3VDVVZ6Mi9rd2lRNFpnL25GZnUvSUUyRUx2Sm8w?=
 =?utf-8?B?a0dlREphQS9kc1N2a0hvL3BYQjVDNnZBQ0JYcEpWR2JUdkd6SjBMdC9oWkFr?=
 =?utf-8?B?MzdDYmxLNHFjMWtyS25mN0l6TER2ektRcjVFamdEY2F1eURuT3orQThLVFhs?=
 =?utf-8?B?MnhBaEdheVdoY05zWFFDQ1RJS0pKMGtoelc5bGg0dm1KYm9NNW5BK0tyeUNV?=
 =?utf-8?B?SzVDcWxmV3NYSkx5UVN0UWRtNFJ4SVA0MEUwVzNXcG1ERzFMSUV6SHQ4dEpo?=
 =?utf-8?B?bDl0bEMvbHJxLzZWdDlSODhmQW9EZkhVcTRDRkRsVGNjNmZMbDVDRVBqM2hp?=
 =?utf-8?B?U2xjQms1cHRjUzU3RzBaWk03aEhLTTZ2UTJ6M1g0VlFmR3RzY2JTbGlhMi8y?=
 =?utf-8?B?SUlHWWZNQTNibXdNcUZCbUprWFVyQWJ3Q1M3b29TSmJwSmtKWGFZRmdCWVBL?=
 =?utf-8?B?MTk4V0V6VnEzamlZRkRrcjF3YTk0VDhjcGk2TVdqK2txTkhjWGYrSnpLNGp1?=
 =?utf-8?B?VUxUaHZkMlIvSmNieXltSkRBaHdJNjFEUTc4NjdUMHkwM0pWSlU3SkNFeDN1?=
 =?utf-8?B?YkZRcVdzNk10Q3IvSFlCcTUwVEw0TmZ2U2E3VkRSVVoxVlRNMFZtUm82QzMv?=
 =?utf-8?B?TU42ODhrYytZY2loSFA2QVJmRmZFV0puNFREakJnMkIzbHhMV3FSVUV0M0Zy?=
 =?utf-8?B?QkZ2em4zVVFHMkp0dG9Pdm1JWHBzKzFrY3ZZRWw2c3owU0RUcENtbm1aWkpS?=
 =?utf-8?B?STEyMWpEMVNiTTROV3BlSXQ1WmljdXBBUGFMSXo5RUlqc1JhVzZscExldmxF?=
 =?utf-8?B?bHlmOUpuMXF6cURiQ0FoSUs3ZEwyeXZIYXBTL1cxNy8zZVN6WjBtejFUOXll?=
 =?utf-8?B?VVU4L0h0UzNzbVlNMWFJRTYvSGF3QWVZbUVRWExta1NONUlUN0YxRjV5TWdV?=
 =?utf-8?B?L3lLaFJzWFg3QnNJRUE1MXVYM1VXd0ZGL1Z3bmpWNXhNMnhsM3NlaS8wT0d4?=
 =?utf-8?B?RXpQZTNJenlRdmlhQmNQNUxZbkV5ODlpMTBNRFFML1A4SXRxOFVsMVZwM0FD?=
 =?utf-8?B?NFQzS3ZaL0IwVnRmR2h6ZDJQcTMySWc1Zjh2ei85dUk5QzBDNjk2enRFRi8r?=
 =?utf-8?B?UElSRmgzZllNVU9mWXM5TUcwTlA0UEszcjNSZTEzNFl2UGM0Q3Bia0RIRG5F?=
 =?utf-8?B?ejRTeE9lWnlla0d5QU9NUzF2WUsyYjVGQTA5RGFEd2ZyaWZCMWIrOW5GUDEx?=
 =?utf-8?B?TGVMRXBOMFRDbTN3UEF2YlNqU3V0V2hDZVZIc0w4ejZrR1pmT2VLaUdJdmNE?=
 =?utf-8?B?dXg0c2tleDFLY2paSDJjY2pJMytnWmF0WC9ucmszaGdkZDdqcm9jeTlYWUhG?=
 =?utf-8?B?djlvZ1JwSTlnYXF5VFRHV3dyWGJGUFR4UCttVEduZVJCSHBJQkxQY3FpMmNr?=
 =?utf-8?B?QVFvSktYd2pKaDROczhybFREc080bE5hckI4WFlMTVd4SFlxOVVtb0lubDA0?=
 =?utf-8?B?enhpUE9NZ3NqZ25VdkZNZ1VPUTcxYTVRRXJMZkRvYmtRUU1CdU9INXBZZFZL?=
 =?utf-8?B?MXBReHV6OWxta2Z4RGFjRnEwbTh4MFhka2RNVSt0NGU5bW9ieFNTeWVLSE1I?=
 =?utf-8?B?M203TXRVU1BVVzZ3M2poQXhwVC9EcFlTMVE1S2FqRHU1QUhOUG5mMlRSUDFX?=
 =?utf-8?B?cDBnZUwxWDg4SWRiTlJjbnFibHlZcEtWbWFxZW1uS0I5OHo5YVN1UU9WKzV2?=
 =?utf-8?B?bWwxR21vV0dXOEZKRzZTcXJlZHpuY2ZreXh2aGQ1ZkZjOU1yZ1J5OG1ZYWkr?=
 =?utf-8?B?R0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0C2EB0C6F18C045B767F0B1030129F9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4itNvKxLLOmDcLSzVsxVZ6VCQCRWdlswjPMvJBHLQJDFmCDY2LYK/SQvSUSQDlWFMEG7Oceo6q1vsIunm+35O5KUu5jyvV1dhxj+cuRq54DMqXgjYBFzEXrPn4jkPYGXmt1NnCZqL89sg5ip6uvCSxjYvRESYBsMRLx5oSwPvx7J7ghZs0mxZ+jBHtP9PHefAGiGdmuwgQOza1zp+v/R8kknRJ2Txw4RmZU4IdBBUM3/2DioU2JhFuNoZls6J9buWyvJ5A55l9TEHAMSpb8KKdukTcqvCH7+gt/EuhcCPSr3+XFRAi8bc4AbCkwTW05eIsVe/cudhqeP5tMpTkrM5QOk7wfFXqfZyR/UCAu+DVPNnZ1vjIqyWuEprF6wVVMeXSvN3jCFNbqTPRCQD1NtFn3wmptR/AX1mDUZ4Pg+B7AWM4Y043Axs3zaA6HJnC35fEHOwlu1KIsOWh3jCk3vCzTrgju2tDWrwRybLNpn5JEKe8BB9t8Z6Xf6Lsye6h1+us07lI8Aki6zQc5T0/MlvxFqV7oKzDI7Sj7DKMmcgkpNdIqar9uxxqDdMwdgAqBTKF4xQR+eDj1TUtN3Q8mNn0eBXBqM92n9waDura/0vSYGBMWJ0ujA2oFdL1HaUh4Y
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d953ea1c-e049-4641-01cc-08dca4c2a292
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 11:38:23.7530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ErNKVTAgy1RNN8/jq6oQONN9Eoi5NrT2ZPHeAHIKW2fWcgr+mBjWy2TFBVMmd8dcoOkbtKAaNcgt7HhnlX2GXU5qLOY3wjfH/vJiy0DWx+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7873

T24gMTUuMDcuMjQgMTM6MjksIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+IE9uIEZyaSwgSnVsIDEy
LCAyMDI0IGF0IDg6NDnigK9BTSBKb2hhbm5lcyBUaHVtc2hpcm4gPGp0aEBrZXJuZWwub3JnPiB3
cm90ZToNCj4+DQo+PiBGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGly
bkB3ZGMuY29tPg0KPj4NCj4+IERvbid0IGhvbGQgdGhlIGRldl9yZXBsYWNlIHJ3c2VtIGZvciB0
aGUgZW50aXJldHkgb2YgYnRyZnNfbWFwX2Jsb2NrKCkuDQo+Pg0KPj4gSXQgaXMgb25seSBuZWVk
ZWQgdG8gcHJvdGVjdA0KPj4gYSkgY2FsbHMgdG8gZmluZF9saXZlX21pcnJvcigpIGFuZA0KPj4g
YikgY2FsbGluZyBpbnRvIGhhbmRsZV9vcHNfb25fZGV2X3JlcGxhY2UoKS4NCj4+DQo+PiBCdXQg
dGhlcmUgaXMgbm8gbmVlZCB0byBob2xkIHRoZSByd3NlbSBmb3IgYW55IGtpbmQgb2Ygc2V0X2lv
X3N0cmlwZSgpDQo+PiBjYWxscy4NCj4+DQo+PiBTbyByZWxheCB0YWtpbmcgdGhlIGRldl9yZXBs
YWNlIHJ3c2VtIHRvIG9ubHkgcHJvdGVjdCBib3RoIGNhc2VzIGFuZCBjaGVjaw0KPj4gaWYgdGhl
IGRldmljZSByZXBsYWNlIHN0YXR1cyBoYXMgY2hhbmdlZCBpbiB0aGUgbWVhbnRpbWUsIGZvciB3
aGljaCB3ZSBoYXZlDQo+PiB0byByZS1kbyB0aGUgZmluZF9saXZlX21pcnJvcigpIGNhbGxzLg0K
Pj4NCj4+IFRoaXMgZml4ZXMgYSBkZWFkbG9jayBvbiByYWlkLXN0cmlwZS10cmVlIHdoZXJlIGRl
dmljZSByZXBsYWNlIHBlcmZvcm1zIGENCj4+IHNjcnViIG9wZXJhdGlvbiwgd2hpY2ggaW4gdHVy
biBjYWxscyBpbnRvIGJ0cmZzX21hcF9ibG9jaygpIHRvIGZpbmQgdGhlDQo+PiBwaHlzaWNhbCBs
b2NhdGlvbiBvZiB0aGUgYmxvY2suDQo+Pg0KPj4gQ2M6IEZpbGlwZSBNYW5hbmEgPGZkbWFuYW5h
QHN1c2UuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5l
cy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBKb3NlZiBCYWNpayA8am9zZWZA
dG94aWNwYW5kYS5jb20+DQo+PiBSZXZpZXdlZC1ieTogUXUgV2VucnVvIDx3cXVAc3VzZS5jb20+
DQo+PiAtLS0NCj4+ICAgZnMvYnRyZnMvdm9sdW1lcy5jIHwgMjggKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTEgZGVs
ZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2ZzL2J0cmZzL3ZvbHVtZXMuYyBiL2ZzL2J0
cmZzL3ZvbHVtZXMuYw0KPj4gaW5kZXggZmNlZGM0M2VmMjkxLi40MjA5NDE5MjQ0YTEgMTAwNjQ0
DQo+PiAtLS0gYS9mcy9idHJmcy92b2x1bWVzLmMNCj4+ICsrKyBiL2ZzL2J0cmZzL3ZvbHVtZXMu
Yw0KPj4gQEAgLTY2NTAsMTQgKzY2NTAsOSBAQCBpbnQgYnRyZnNfbWFwX2Jsb2NrKHN0cnVjdCBi
dHJmc19mc19pbmZvICpmc19pbmZvLCBlbnVtIGJ0cmZzX21hcF9vcCBvcCwNCj4+ICAgICAgICAg
IG1heF9sZW4gPSBidHJmc19tYXhfaW9fbGVuKG1hcCwgbWFwX29mZnNldCwgJmlvX2dlb20pOw0K
Pj4gICAgICAgICAgKmxlbmd0aCA9IG1pbl90KHU2NCwgbWFwLT5jaHVua19sZW4gLSBtYXBfb2Zm
c2V0LCBtYXhfbGVuKTsNCj4+DQo+PiArYWdhaW46DQo+PiAgICAgICAgICBkb3duX3JlYWQoJmRl
dl9yZXBsYWNlLT5yd3NlbSk7DQo+PiAgICAgICAgICBkZXZfcmVwbGFjZV9pc19vbmdvaW5nID0g
YnRyZnNfZGV2X3JlcGxhY2VfaXNfb25nb2luZyhkZXZfcmVwbGFjZSk7DQo+PiAtICAgICAgIC8q
DQo+PiAtICAgICAgICAqIEhvbGQgdGhlIHNlbWFwaG9yZSBmb3IgcmVhZCBkdXJpbmcgdGhlIHdo
b2xlIG9wZXJhdGlvbiwgd3JpdGUgaXMNCj4+IC0gICAgICAgICogcmVxdWVzdGVkIGF0IGNvbW1p
dCB0aW1lIGJ1dCBtdXN0IHdhaXQuDQo+PiAtICAgICAgICAqLw0KPj4gLSAgICAgICBpZiAoIWRl
dl9yZXBsYWNlX2lzX29uZ29pbmcpDQo+PiAtICAgICAgICAgICAgICAgdXBfcmVhZCgmZGV2X3Jl
cGxhY2UtPnJ3c2VtKTsNCj4+DQo+PiAgICAgICAgICBzd2l0Y2ggKG1hcC0+dHlwZSAmIEJUUkZT
X0JMT0NLX0dST1VQX1BST0ZJTEVfTUFTSykgew0KPj4gICAgICAgICAgY2FzZSBCVFJGU19CTE9D
S19HUk9VUF9SQUlEMDoNCj4+IEBAIC02Njk1LDYgKzY2OTAsNyBAQCBpbnQgYnRyZnNfbWFwX2Js
b2NrKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLCBlbnVtIGJ0cmZzX21hcF9vcCBvcCwN
Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAic3RyaXBlIGluZGV4IG1hdGggd2VudCBo
b3JyaWJseSB3cm9uZywgZ290IHN0cmlwZV9pbmRleD0ldSwgbnVtX3N0cmlwZXM9JXUiLA0KPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGlvX2dlb20uc3RyaXBlX2luZGV4LCBtYXAtPm51
bV9zdHJpcGVzKTsNCj4+ICAgICAgICAgICAgICAgICAgcmV0ID0gLUVJTlZBTDsNCj4+ICsgICAg
ICAgICAgICAgICB1cF9yZWFkKCZkZXZfcmVwbGFjZS0+cndzZW0pOw0KPj4gICAgICAgICAgICAg
ICAgICBnb3RvIG91dDsNCj4+ICAgICAgICAgIH0NCj4+DQo+PiBAQCAtNjcxMCw2ICs2NzA2LDgg
QEAgaW50IGJ0cmZzX21hcF9ibG9jayhzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbywgZW51
bSBidHJmc19tYXBfb3Agb3AsDQo+PiAgICAgICAgICAgICAgICAgICAqLw0KPj4gICAgICAgICAg
ICAgICAgICBudW1fYWxsb2Nfc3RyaXBlcyArPSAyOw0KPj4NCj4+ICsgICAgICAgdXBfcmVhZCgm
ZGV2X3JlcGxhY2UtPnJ3c2VtKTsNCj4+ICsNCj4+ICAgICAgICAgIC8qDQo+PiAgICAgICAgICAg
KiBJZiB0aGlzIEkvTyBtYXBzIHRvIGEgc2luZ2xlIGRldmljZSwgdHJ5IHRvIHJldHVybiB0aGUg
ZGV2aWNlIGFuZA0KPj4gICAgICAgICAgICogcGh5c2ljYWwgYmxvY2sgaW5mb3JtYXRpb24gb24g
dGhlIHN0YWNrIGluc3RlYWQgb2YgYWxsb2NhdGluZyBhbg0KPj4gQEAgLTY3ODIsNiArNjc4MCwx
OCBAQCBpbnQgYnRyZnNfbWFwX2Jsb2NrKHN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvLCBl
bnVtIGJ0cmZzX21hcF9vcCBvcCwNCj4+ICAgICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+PiAg
ICAgICAgICB9DQo+Pg0KPj4gKyAgICAgICAvKg0KPj4gKyAgICAgICAgKiBDaGVjayBpZiBzb21l
dGhpbmcgY2hhbmdlZCB0aGUgZGV2X3JlcGxhY2Ugc3RhdGUgc2luY2UNCj4+ICsgICAgICAgICog
d2UndmUgY2hlY2tlZCBpdCBmb3IgdGhlIGxhc3QgdGltZSBhbmQgaWYgcmVkbyB0aGUgd2hvbGUN
Cj4+ICsgICAgICAgICogbWFwcGluZyBvcGVyYXRpb24uDQo+PiArICAgICAgICAqLw0KPj4gKyAg
ICAgICBkb3duX3JlYWQoJmRldl9yZXBsYWNlLT5yd3NlbSk7DQo+PiArICAgICAgIGlmIChkZXZf
cmVwbGFjZV9pc19vbmdvaW5nICE9DQo+PiArICAgICAgICAgICBidHJmc19kZXZfcmVwbGFjZV9p
c19vbmdvaW5nKGRldl9yZXBsYWNlKSkgew0KPj4gKyAgICAgICAgICAgICAgIHVwX3JlYWQoJmRl
dl9yZXBsYWNlLT5yd3NlbSk7DQo+PiArICAgICAgICAgICAgICAgZ290byBhZ2FpbjsNCj4gDQo+
IFdlIHByZXZpb3VzbHkgYWxsb2NhdGVkIGJpb2MsIHNvIGJlZm9yZSB0aGUgZ290byB3ZSBoYXZl
IHRvIGZyZWUgaXQNCj4gKGNhbGwgYnRyZnNfcHV0X2Jpb2MoYmlvYykpLCBvdGhlcndpc2Ugd2Un
bGwgbGVhayBpdCBhcyBhZnRlciB0aGUgZ290bw0KPiB3ZSBlbmQgdXAgYWxsb2NhdGluZyBhIG5l
dyBvbmUuDQo+IA0KPiBPdGhlcndpc2UgaXQgbG9va3MgZmluZSwgdGhhbmtzLg0KPiANCg0KR29v
ZCBjYXRjaCwgd2lsbCB1cGRhdGUuDQoNCg==

