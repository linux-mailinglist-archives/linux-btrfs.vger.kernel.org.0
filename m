Return-Path: <linux-btrfs+bounces-8435-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC98598DDC0
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 16:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7801F256F1
	for <lists+linux-btrfs@lfdr.de>; Wed,  2 Oct 2024 14:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FD11D0F76;
	Wed,  2 Oct 2024 14:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TGKGwy0g";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="th8GMrDk"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68671D0F48;
	Wed,  2 Oct 2024 14:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880566; cv=fail; b=R0dN6XgF6lpWuytA3HZT+NdAKAqXTDcVzpS/Tz4JJLE8LrX4h9WH0Ni7/4MqfBGboePjkFUjvdAiUrH5XV5lRyuAHW8JZmaKpYC8IsjPcO/GafiHOdScCMw1SAQ5m379czlOFYXuvNrkRrAHp3PDUaJMPQO3J5GYKEJW+nos4hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880566; c=relaxed/simple;
	bh=YQIpJMf/afz3do0uPIrt2LHiR7VkiJee4R2mgYczb4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dLQpCt0e3LPfoHf4Y2MXvxm0m5kzXBPX8SkY4BUlW0MiKRFp0ckXvCg0oUP/LRHcbT5RXBTtJeRLuXerkKETCawXGYXW/XxmUKLYSvbRo3C7C68pt5YI7vPJ7q4j/BnmcUMzpg+RpniF86sc6VVvn4ZpGNV+XoMx3iRMmkeSrlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=TGKGwy0g; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=th8GMrDk; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727880564; x=1759416564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YQIpJMf/afz3do0uPIrt2LHiR7VkiJee4R2mgYczb4E=;
  b=TGKGwy0gPKzKZeyuTL73eg10D/x+iaNAWmEynrdjW5+oJU7BfCvM1rdt
   atkbs1VKdEoQfMjkNi3hVA/WjgpPFDxr7oFoB3Esve2QkyqIDkDqFUA/h
   cf6NTSGmC6fMJK2bQXw+oF0b112lo2JZMtETV4Xf/SFQq9usD5oVMGop4
   PWudhXR4vvzODxUUvzNN+Byg856cJbWz8UAp1nxkVPzSbTrRI5ieI0avZ
   4mXVLWvmDFp3sw1vkc7Z/4mx2JM0tf5lWmz7ffr2CJUoFzB1ml33UOTTK
   21O1MTe3nYX83fQfNXHw9y2U4or6qeRo8ix41AMjYHDIRUFv+IFAAh7wa
   Q==;
X-CSE-ConnectionGUID: GnXerJCDSJWfjKAYKTmDMA==
X-CSE-MsgGUID: fVhb7hoZQ06QDlI1Vp2mig==
X-IronPort-AV: E=Sophos;i="6.11,171,1725292800"; 
   d="scan'208";a="28099417"
Received: from mail-centralusazlp17010003.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.3])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2024 22:48:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hwyT1InqnXV1ZQ4Xl0Vt9t+Yb2vdKHJMOQ2a7IiqVYq9T5juqb7ectKxjg+TdaQipDrfRp6huoPDuyWWU202o6xWmxchQx43QEtaAbDnicJ7zG5gxEQFU9oLDJYXzhXLS7aNqI8jwjCEcWvbFyBNnYMGr/D7H6YBQOD8WZAT5yXWGImWPF1+jxRv93zkMjAshe5ExXLIAnVTfD+ADgT8T31i+VjS9POrmc9owZ/rkD3wy0dtZUDS/T7HM5zf3DiIXjL3b2P+Vx11qUGwvO0wa3xrNY9idSDybF4jsqFMQPIwnxwySJpXT2O2BZ/ZX5v3kitIYZfoKYjKWocKzKeyDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQIpJMf/afz3do0uPIrt2LHiR7VkiJee4R2mgYczb4E=;
 b=NiWNe7Iv1dwW4HMMjomrjjdnNymj0+Gs8PfkmTfGI5AczHQ87xciALdGqx+UFN6e+kR0W27mJB1ItqOT9Gr2KOYuIGYL0y18bfKukQKIAtYOVbRotHDEuyOgPjjxNQXqjUWPzTVtcxMARKNAzs8Q90CS7330klDNPgaD6Gl1CCxKWQtkSFSK2p+Qjb3gR1KL1B9ps5DJt64VvcbHKzTyiZ5kPYEw5EW6szhfiEY+51iZnQnRALxdtNyYE2gjW3kid7U17U+i1z2gaPFIf6jAsGbv0XSVin8m5pGI1sMlySZZzYHsoqH7EkKGSkeamIEha1rOmsUD9UYEOBmS+Nkzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQIpJMf/afz3do0uPIrt2LHiR7VkiJee4R2mgYczb4E=;
 b=th8GMrDkkdn7WRL5zFs3lB+xPz9OXw/VeoYz/mMroiuBvEtgsWZ0d6fFqDMtDBVJB9bDKo51WBAOY5WJQPRLzezHvfxUgbJzxVb7pPOqKBbaONBOiDxzxcnxrVC/kaB+ayOohrFvh0C4nhgz9qUMugotl+KiQySGvKyvwDPCuKo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7848.namprd04.prod.outlook.com (2603:10b6:8:26::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 14:48:14 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 14:48:14 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Filipe Manana <fdmanana@kernel.org>, Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>, open list
	<linux-kernel@vger.kernel.org>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v3] btrfs: tests: add selftests for RAID stripe-tree
Thread-Topic: [PATCH v3] btrfs: tests: add selftests for RAID stripe-tree
Thread-Index: AQHbFLOSS5sFa2A/RkGoxEYLjorXL7JzhA8AgAAGwIA=
Date: Wed, 2 Oct 2024 14:48:14 +0000
Message-ID: <459f05cd-23fd-405c-b52a-bd2b667eba62@wdc.com>
References: <20241002101200.14543-1-jth@kernel.org>
 <CAL3q7H5mRqf9hP-boXj7Tgd6SLYsUEyAboHzB7ZEw4vsgHLX8g@mail.gmail.com>
In-Reply-To:
 <CAL3q7H5mRqf9hP-boXj7Tgd6SLYsUEyAboHzB7ZEw4vsgHLX8g@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7848:EE_
x-ms-office365-filtering-correlation-id: d3c6e0ea-e18c-4239-ec5e-08dce2f13e61
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?a09PdlNmTnYwZ25BdlU2Y0ZIWTg0ZUlHZkNiTjlRTm9IRFVMM0gvNmRnME5U?=
 =?utf-8?B?MWNRdEg4MU96a0Nqd08reG9nSWl1TlpQQTlsaE05cVpyRnMyaThwTzhuNzBQ?=
 =?utf-8?B?cGNVWFN2dDE5NGNyTGJ0d1IxancxQ2JlbVlvMGdsK0tURytnT2VIQlRrd0lv?=
 =?utf-8?B?bDF2RFNkWHE3Y1dhb0swYkowMlJZMkdoME5EWlRrVktieEdQc205WTNSd2R3?=
 =?utf-8?B?eWRmUEkrVmZhSkdPOFEvZkJiamlqRDFrVlN3d3R5WHJkMnVZeENVZ0JTL1l1?=
 =?utf-8?B?eHMzYTcrM05SUHdXQUhVVE1qQkRuVDd2MzhSNlg0VjZTNGVXUGEzOHhoRjI5?=
 =?utf-8?B?RUdWSW9JMFBNd3FTVEwzQTd6RGc0anl2NTZTbm1tUDVrNHpFcnAwekVhTnBz?=
 =?utf-8?B?MnJDQ1Z5eTJMVHh3Zjh1NTBndzZ4TWk0Z2JJQlR1WUVuZWVpMGpsRXg4N3Zp?=
 =?utf-8?B?ODlWQ2ltOFFML3VSTW9IRXNnM29Ub1NNRjdLY25QMDE3MTRCaG5lUVl0NFpV?=
 =?utf-8?B?TXNIR3kxM1Z1bllCUTdxSk9iV1lEVUlzc1ZiR3NveHg0eHdLQzFHZi9mWFJv?=
 =?utf-8?B?VWpzTWdpWUNSNmFsUDE2cVFBVlg4eHIrdGZkcU1wSXJ6Rk14a2xiME9Paklx?=
 =?utf-8?B?UkFaTHU4L3FPVnF1VnZqUnNyaWcvQjd1OXI4ZVRLK1FkM3Axd0IzNWxxZWdu?=
 =?utf-8?B?dElrVlRISmF6V0I0d2hGRUlxNWtTWWRudGFQU1plbVNhZ1RtSDZGWGt1ZmZY?=
 =?utf-8?B?SDZrNG9telROYm00cHJ5d2l0ZmVWUW9jakJLYVo4R0tXUTMydm04TkJJOWUz?=
 =?utf-8?B?WnhiS3ZFUFd4Y3NCZENkbWlkcURMRUtpRm5HZnA4T3FydjVCWlluOFUrakt6?=
 =?utf-8?B?ODVTYlNhUTJCekJ1VXR1RFllVW1nWlFpSlA4UVNielFsdUpUeWgwdnc2NWNw?=
 =?utf-8?B?TzhnTmp6bDVDYkdENFVWMmxwWUp0OG9BNWNFMUdOckg2MU5JaENON2EzZ2Nu?=
 =?utf-8?B?VHgrMVlCd2ZoaTlwVTUrYjRSaHlXTkdxbzlZanZ0YWlNeHN6cVBpUGVqbEZY?=
 =?utf-8?B?TUlrNzJVVEtxVFZnUzFWUzAzczVCNk9ZV0pPejhSTnhqeWY1bVN1Y1dheDZW?=
 =?utf-8?B?OGpNaFNqTUwxelRidHBYb0pUeWo3MDQvSnhyQjRWSk5NZGJvVFFDWCtHUFln?=
 =?utf-8?B?Z0liSThiRFhScko0Yll5MmhoQ1cyRElEbnhhQy9xL1R0MDR0K3BPQnJURWl1?=
 =?utf-8?B?MlhGVWpjR094bWxYWFRJOEVtT29lWFgrdDAvVWJvSDdubW1IT3ZPVTRSckNu?=
 =?utf-8?B?ZlAyZndPeEw3VnMvZmJiUVlkNmo5NlBSMllleDRxUHdtOG9sNCtPL1J3cFcr?=
 =?utf-8?B?ZldzQlF1dEMwcjVqOGhaWGRwYlZKSllYYkE0UHhiQUNnUndpM0ltUW80NklW?=
 =?utf-8?B?dzdVcWxhdmdhSXI2UWtEVjNuWjNtNi83SjdZSUtkcWZUS3VGSzdOc25sQ2tj?=
 =?utf-8?B?Z2dSTjdhbytXemMzMGl1TnY3YUVwU0pHb3FqeWllYU9zVElCS3l3WTZ3V3ls?=
 =?utf-8?B?dTV3bXhyV1dRR09RM1FGSzZSTnFGNVlDWVVlVllRU2lEaGtRMGdsV2c3bFVt?=
 =?utf-8?B?bFJvRXlZeTRKNnBMQWlKZGlJbXpGNEgwcHd6OVJpVW13aWFKSWE4K3Q1NWZD?=
 =?utf-8?B?K1N2RDllSDJ2QVZQQ1gwOFdLdE9wWXAyLzVQVXppTkptQXkweisvWDZPL2VM?=
 =?utf-8?B?WUdUZnJ3cCtOYUJRcE5LVVBURGsxb2VKMnNNa3RLa00xN2VnM1F6cWFLT3hL?=
 =?utf-8?B?ajBtZFFIWmtuRlIxWjRoUT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlZpSU55enV1SVVXMTU0UWFUKzNaWFAxU1hDdzYzbDBwVjM4MUFkVTVGTXRY?=
 =?utf-8?B?MWlCYVBmMVZuZ1A3dFRHOWJyaDB4ZkFBRWZqODNOWVdRTWJYVE51S3ZNZ0o3?=
 =?utf-8?B?cWx1ZlJWR29lQWo3dEpGRmQyTWszNStCM3JMd3k4eU1SQWcrdXMyMUJONkxi?=
 =?utf-8?B?K1ViWW9uQ0J4RzJUZVVVam53WHFaSTEwV1Zoc3JXa1ZHNnFVKzFqY3NBVzFj?=
 =?utf-8?B?WFBGcU5jZzZTdTA3UTRpSjEzSE1xdVhrbzZ6V2ZyWVZTajFaVGY0VlRDWGZm?=
 =?utf-8?B?Nk5pdGZudUJObkpmZ1ZhbGwwWWtGR0h3SnBXSzcxNHFoOXljbGUvS2JGcXVP?=
 =?utf-8?B?dGNYSGdHbXU3NlZ3WDVmUlBBdGR0dEV6ZG55VS9mZGhOMlBuQ25iOVY3TEhu?=
 =?utf-8?B?b2xvN2Z0dTVxMGJKN1VVelZ6elBVbGZacnZKeDZmZFliU01YT21UbmFNai9u?=
 =?utf-8?B?a1hRbVJiNmNJNHA3QlhUWWhYOFNtcXNqR0JjcHlQdG1obVJteTRXVUs0Q3hn?=
 =?utf-8?B?L3B6QUhyekgyTEVYT3dFbkhJS2xHS3JSbDdubWtoYkNvZFJwemlrUWtXVnFr?=
 =?utf-8?B?UTkvOE0yUzk0M0pzaGNqcHpFQ2Y2T1RLNkZ3a2dBUUxUWU5sOE9XbGIvRS9a?=
 =?utf-8?B?VG1KSFJiSVljL2tMb0N2bEZxdTFPbSs4YXBldkFlVmdRdnpRc3JlNFhsUUVM?=
 =?utf-8?B?MUE4RWU4NGVYQUpLU1FzYkRFcGhlOWhLa0dLdjZlcFB1bE0rMS9qSjJmcXZM?=
 =?utf-8?B?SUZYUUJ6WUxvK1ZlYkkrWC8ySm1WQ3p2ZlU5RmpuK2k0YnBNa05DZHNiWGs2?=
 =?utf-8?B?dS9IRFdEWDU5Ty94N1FvTmZNT1p1SWxMLzdMdzY5WFJaTUgyVEZ1SUorZXJ0?=
 =?utf-8?B?S3N1VGk4WlZuRzNWbDdBMFdQa2lpQjhvWFBGbE81ZitWSDZFMlhkYUtLTWlq?=
 =?utf-8?B?M28yN1dHMGFhR0doMXNUbGdRT012K1lhby9aV1h1QjZlbm1jdTFxdWVIdHk2?=
 =?utf-8?B?Z29rN1gyTXRhazhLVDRJdmd1OWJubjcrd1JoNWJGQjJIUncwbUY3VHc4WWY2?=
 =?utf-8?B?bDVrRHV5NlZ3TThKYTVNN2UvMS9LMUE3Q1puNlp6NXYrcWhmU2czYnZ3c1R4?=
 =?utf-8?B?R1BhN0JKWlFjRXNGVmV5dzVZV2IzMWhqQjJnVmMvNXJodTdwb00xL1c3ajhW?=
 =?utf-8?B?a3dmbHl0eU42Q2owU0tUbGlLMDhRY0RoRHJVSHBCaWZObWxYVENmdEc2VEMw?=
 =?utf-8?B?OEVEZElnNFRtQ2QvMjZGRkk0UWoxamUvVDBDU1lCR0ZMN3hTenlnYmV4ZGpp?=
 =?utf-8?B?dzdUNFNYUnk4anBpUHc3bkVOeHA5ZkFuQzlDUG5wSDJ3N2JTNTh3SVVoWUVJ?=
 =?utf-8?B?YktTU3UrSlVQeUtMc0o4WjBQRlNmQ3BCSkMxaFNGcTJxNjQ4MGJOL3RXcC9T?=
 =?utf-8?B?Q0U0Z285bFhtanNZaytYNS93a0luUWRZRk5mVnRJNGVieFNmVlQxYjVUVDRt?=
 =?utf-8?B?VzdPRnFGR1dpTHVFcWxIQzRqOUxER09pYkM4QWw5R1g5YnI0TzdRc09URFdt?=
 =?utf-8?B?YjNEUXFOd09MOUJFbUtaaTlVbDcwNVVncTdNdVl2YU5LV2Frai8rSzVXNHhq?=
 =?utf-8?B?eWVKbnFSdXhzSXpTRUZkYWM4dTE2NURSdW5hUkQ5R1p1NGF1TlY1UEw1SmRJ?=
 =?utf-8?B?M3FMMHkxQTdvQUpnR1JxYkxmTWpBMmVsU3p4cE5yenk1d3JOWTlxc0xxYWlF?=
 =?utf-8?B?My8zMVNRZExyZkRiRWEyNVhscDZSQmpPR0FPRVIvZm00UFVPM2pmcEpwbG5j?=
 =?utf-8?B?TWhlYlFlSzRlVGw1RmJ2enlVOUZXME5laEwyY1JRU0YvaFZZa2dGczNxbS9D?=
 =?utf-8?B?OXMxN0E4ZzBTK2x4dUxHS0xkdndXY3lQNmdyekhHVko5b3lEWWlWcUdzMWJi?=
 =?utf-8?B?WHBkZlZsbDRrTFIzZG5pWkJZMlluZTZyUVpCbk1XcEFlbjVuZE1KZm9iUzBE?=
 =?utf-8?B?RURuUk9LVEljZFF0eXZlQkZXZWdIK3VQOFpUUThTVFQ5NU1BSzNRSmU3dEVP?=
 =?utf-8?B?K3FXYnpSVkY3TVBqQTRxemwrT0VpZkEwREpWL25iWWgxSWIwa2JVUXlwckg3?=
 =?utf-8?B?SXJGNnBJRDJ5SUp0T2ZoVG05M3JoQi9ubFA3SXR4SW1ZaFM2Q0NERFV2ZXJh?=
 =?utf-8?B?ZHc1TUJHc0o0c3p3UkdkYThOL255T0VuNFJVNGF1bWRzd0QwQXJoTlE5dWFQ?=
 =?utf-8?B?eGJPbzdpV29qRnBxWFc2TFlHbm5nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2C8157276D50564AAA2E0980F292915E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	i/7VqhbIvAf9Bt1/9x/bVifCyeSxmXzm8WmEsPFHJwyqa2ImOAHwGaRZBER6O8jP+dQ9IfX2SzT7GkPore3tGgiNjLhQSrIlQuxel0T8ClS7J3qUFuobl+BH/Ryx1UKY1OpZwk3anhogP/aqDrvQYW/u/3mX8OcL08oQ0m55X42Km1D7PlkrYBMUFGUvKPcMEHoXPW7WnpIIGLyEKEXRLt8bwHHEKaBn1Q9eVBnRFUdgFQOlMTINOS9evksS2i0H94e0eDQwLM2qRParq6qpzFPCDqOo6QdL0kxLOEIvIHDnSC50/v3UAGn1fgmByXr9U5xdiEuy5A9PELnikGALwy1/DrMNqIOrhqFr9y3guD4hLbrtT8n1vNR1QwugvIATbe3IBoLAG395vA9HcRtnloIIOvRq3W3e8G2vOadcBxIgBE2VXDhglHinezFW7yO6eQZ9X/+P1cB1VUjL+DyS83BB3zecoD6UKizNCxHCCD+3MqeKzGizYBmuxnPDDQKcQAaYK6Gt2NzQpsifvLby7KBB0iDjtCaFL3OV8VVz4wU7YNq0sB23KJycCoCuw/L8Hm8t18TJ8PWqkKFegA8KcWkUxQSkJ8j9/C3T0O3zBbyurQ/BYhXhkm8/ogivZkIz
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c6e0ea-e18c-4239-ec5e-08dce2f13e61
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2024 14:48:14.0993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcCzEgRuDTfcyy8TKhZCIcmQwZIJ3oEWNWpBQVjUhfX1aLmouaYfkwZB25Hs6bUdIRkKjDw8atVTWRxJMD6bDyZ7BZaIwEjC9woxlFp6Vdw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7848

T24gMDIuMTAuMjQgMTY6MjQsIEZpbGlwZSBNYW5hbmEgd3JvdGU6DQo+PiArICAgICAgIGZvciAo
aW50IGkgPSAwOyBpIDwgUlNUX1RFU1RfTlVNX0RFVklDRVM7IGkrKykgew0KPj4gKyAgICAgICAg
ICAgICAgIHN0cnVjdCBidHJmc19kZXZpY2UgKmRldjsNCj4+ICsNCj4+ICsgICAgICAgICAgICAg
ICBkZXYgPSBidHJmc19hbGxvY19kdW1teV9kZXZpY2UoZnNfaW5mbyk7DQo+IFN0aWxsIG1pc3Np
bmcgdGhlIGVycm9yIGNoZWNrLCBpdCBjYW4gZmFpbCB3aXRoIEVSUl9QVFIoLUVOT01FTSkuDQo+
IA0KPiBXaXRoIHRoYXQgZml4ZWQ6DQo+IA0KPiBSZXZpZXdlZC1ieTogRmlsaXBlIE1hbmFuYTxm
ZG1hbmFuYUBzdXNlLmNvbT4NCg0KT29wcywgZml4ZWQuDQo=

