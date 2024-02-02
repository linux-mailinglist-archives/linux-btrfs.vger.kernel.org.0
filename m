Return-Path: <linux-btrfs+bounces-2067-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E31846FD2
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 13:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 921D31F2AA19
	for <lists+linux-btrfs@lfdr.de>; Fri,  2 Feb 2024 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2B713E233;
	Fri,  2 Feb 2024 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bv/2Z6OC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WnThDeMZ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A013DB9B
	for <linux-btrfs@vger.kernel.org>; Fri,  2 Feb 2024 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875783; cv=fail; b=OpGs+nwRLewTrQ46aohex/JzKy4jtDKfSukWS47YZe/RLzSh81tMswt99chh7aMnQeXbuku6N/OEIDKMONkKLiXGEWKsg3is0QoVgm60BRk6XaLipxBEf18PvO5tiWTQziwLCRJl0Gi0jG/GTGwnEmUjmjx1Pd5wZj8HshpZUJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875783; c=relaxed/simple;
	bh=6WPi6w7RWfjHuErQdeX54qrh3Tnu1TShYjTfy7/TK1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XkxYQiZHp9gr3wZGkW3gnQ+A9RajbvjGw3tLjF2u36BRwP0zLez6VLadpvnuFye8ntD1M9BImJPeWZQVrM3LXGGRBbR66HL8szVLM7kLEXg02cC+Vd9IUJ3CTQuQZ9PLSwPYcOPfB2eHUls7IsnjEj0DOoxqXWX2D81nF6OEf8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bv/2Z6OC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WnThDeMZ; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706875781; x=1738411781;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6WPi6w7RWfjHuErQdeX54qrh3Tnu1TShYjTfy7/TK1E=;
  b=bv/2Z6OCBAH7FeOZqI23hNChgSTM6qmYIHjYfEkPAkLxAulhvB/cLZLo
   luesS4qTeRQ2whm5u4cvv+PVZFR/Y7Nq+CFoHG1OzuxNjn7XlFuUfJuye
   SaLzPRbNZeoF8HgMiHfHuNEer4wxlOZ28fM1c7SuEug5RWHNjKYenmpxu
   G3pI8cUjBoOE3NpRqG+Zw7X1ln817qvmD/NkRVXcukd5gCYYr1di9KUI7
   3aeFdkSkAERaBQDLnaBrD+1I/HUXmjvtkMOOjrX3fusPZ/KmrgVF4N5ub
   wa8JC1iDku1M/fhau1GP2kl7MQGk18O48nPcLgxCJo4B/f/c7b8z6ohb1
   Q==;
X-CSE-ConnectionGUID: QRMAs+qZTUa4ZVJAYceYoA==
X-CSE-MsgGUID: DFuPjTZyTgeQ7FsK90TdXQ==
X-IronPort-AV: E=Sophos;i="6.05,238,1701100800"; 
   d="scan'208";a="8409093"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2024 20:09:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0r72D6u3iRqNwavqx5aHIJPJqfHkYygLIeSIf/B88oOdUAKDkY9ddVMxaWOzDcgIZaCsGV2TVQ8BTNpNw+4DjYYBHkL6fQtGmHlbfaifGraKSbMxTHrbllUctWxW/X2FtFKHYf54D4upuwOrq6bR0Qb77Hgw6pzLE4eL8FcNTuSZawYLzhOCOnChezAxQpF/H6j7XWUCvni1ge7242j9tG1KL4aNXsnoVqPSpSnFmc3z/cA2KMHsMcQysw/Yq5l0WREiajsuY0PJRZJQbaRq8bE7fO22r1HySRBITVgkBsiTqYJF3XGN/o5yI6xsjTSzvKg2Q4lWAymh5ezqPRJ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WPi6w7RWfjHuErQdeX54qrh3Tnu1TShYjTfy7/TK1E=;
 b=IQLK5aV+EX5ckql3v5VeZ2LzLW05bCpK5WigmZ9ZOl5dVBsufSkGtKQRMLHsWAyvzK97RYNFGDsEzNQZ4U0j3mTulWJm1iHsaZ5FPGnVzXu4B8dZgxJgA0Tm4xHDuikQJUgdvVMJLIXKHacmhXJU3Iah24lmzdWhHKW6glw7TqyyFWodbi29l7ZvYJyY+ZtYYXxys85uZCbw5shDatfd64XTJJiA2PYb9j/d6jCVm0Cvh9oLEqWAb5Bx87AwMu6TI0COCv/G3yTrqR525cJthVCuSpeHrYRXbF/78QZg7+oVZiWtAR01y5dR+6ESmGtAWb1yz7c2V9GW+uhP2BmLlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WPi6w7RWfjHuErQdeX54qrh3Tnu1TShYjTfy7/TK1E=;
 b=WnThDeMZlET0ySFCLZUMgAfrftSOItz+2rn4V4Z1lBgAXoXpi4gxPhlK0GAJP4Mp5dHK6yWFb2lwxduq008XwrXR64XvDK1GKaMHokB1qFKCD1h9b13TkPMpnlg3xAmDtyqHKGjUqmLca5aiMgOzc7zIhIW0ORQcHd4zt7HiI2M=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7543.namprd04.prod.outlook.com (2603:10b6:510:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Fri, 2 Feb
 2024 12:09:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 12:09:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "dsterba@suse.cz" <dsterba@suse.cz>
CC: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode
 pointer
Thread-Topic: [PATCH 4/5] btrfs: add helper to get fs_info from struct inode
 pointer
Thread-Index: AQHaVTmg407G8UXRYk2sdBaMMp3LBLD27QCAgAAJTQCAAACfgA==
Date: Fri, 2 Feb 2024 12:09:35 +0000
Message-ID: <916813dc-f96a-4b05-93cd-6bf6f6284720@wdc.com>
References: <cover.1706810422.git.dsterba@suse.com>
 <e25d9d750e5a753c5341d11356649f89f00a260d.1706810422.git.dsterba@suse.com>
 <9eab4581-ee07-4e03-a0df-635ae4f30716@wdc.com>
 <20240202120722.GY31555@twin.jikos.cz>
In-Reply-To: <20240202120722.GY31555@twin.jikos.cz>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH0PR04MB7543:EE_
x-ms-office365-filtering-correlation-id: 6b9a9b2c-7780-4757-dc6b-08dc23e7d2c2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ahc4DVhytTtIIBDgGJ2sM9c6AAgEiCzlH0T6YSSbYkWSKkeFUZqPv67rplMiXPz0czyettJcBIuQaRapQ8/2B/T7dd/0UndsBxAHl5I8ra2FaHpD/LXU2MFcKopHaCQC80CT5bJoDFsWcz2uldk3I7Ihp1uEqsVg1fs1AKiEy6ki563eqB+xuJzTdJoz/okn3xpmbbHKbPBNpMX/0I9QAXn0FHG6noDzwYCEJyCXrd2QkDBVJS0gRNEgy9+TQtlT1uBBCTt2aE95wvKUA5JOJwuNAEBhOCBzJih/f0alozLz7FDquHgbgN1VZiTub3kzlTj3swDHIxe4Xd+NMkPnKPIKpN/e2f2w/LK3k/E0vyQb9CGEVGA5QTyzNfuCzrNWtaxJOCWZx/d1H6kBtJHpfDsvF9zCIb3EGwAnlA+n6eOGJp9c6yNkdFLDf8CCjwDZPfnwp8xiZX9BrYDoACajA5L7tc3V0s2Z6Z60iiF2UQICxiZXpfn6qfSZ2zxEOYMztZIT1fIXKcARe95ts82mGr3FvrPeeeg4zCQRDUf7KGFWzD3D+XQjDk8yKR5s6ZlTz9qZn75oMtG8kBq1VhjCcU3aRUZhZqrxvVbDUcZ5sFAywb1AWnyN3rMrI98Km9mOaezbbnCx9jI9Mh8I5DvENVKE3shEZhqjzcAB9Bh8El5mKKYy8rA418EAFRD1Wg4E
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(6512007)(2616005)(122000001)(38100700002)(4326008)(8936002)(5660300002)(66476007)(8676002)(66556008)(71200400001)(478600001)(54906003)(64756008)(6486002)(53546011)(2906002)(4744005)(6506007)(316002)(66446008)(6916009)(91956017)(66946007)(76116006)(38070700009)(41300700001)(82960400001)(86362001)(36756003)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NEJ3N2Uvd1NnRzlXMmdra0tJZVJiamhiZFNCOXZZa3dJdGJiV3ovdXRqNUc3?=
 =?utf-8?B?RE14dTRvbzl0WmNZUER6dkZrTkd3b2VvUmJJZkx2WHV5a0xQQVV2N3lNckJv?=
 =?utf-8?B?QWdiUjBFZXl0YjFwaUxyN21pTGd6eXdpM2VOZklsMFhLL0F3Qk54cE1YNzQ0?=
 =?utf-8?B?QzVoazRFYWJhTVJkTzhmY2pmbzZkeXNYcnhURGZuaytQWHZVd1FUTjVCL2pK?=
 =?utf-8?B?WGd5aTl0N1ZxWnJmUXlTeTJNTjR5U1JZOERLNmhkNWRzOHhjNWE0cWZkSVNu?=
 =?utf-8?B?M01xTEQxTFpaTEU1d1owVDJrSlFwYzNqc2JlcHJPOW5DWjNSQkw5SHFzWXRU?=
 =?utf-8?B?ZUN2SUN0djFJNFRZcWZFU2VMckxuM2ZGZDhtWEk0cUdEZFhhMnFRdmdkVk91?=
 =?utf-8?B?SWdpVHJ0Vno1alRQNlRIcjFadkdrTSttTWt1MWR5Y3ZYaFNjd3JseWlYc0FN?=
 =?utf-8?B?SDhSZUJhcm1KSUVyTkI0ci9rQko4dy9PZ0NMRGNMWitnMC8vcWtqVmdmbStv?=
 =?utf-8?B?Tkltajk4TTM5cFYrN2FpYzBSaERYb2pPSWdpRG51d0hoaGd5L2duY0JUVklK?=
 =?utf-8?B?N05NMHBwOUxoMi81VUk0UERoU3gvZE9oMG1SRnBMSmxuWFlHaVV5VFhQVWdD?=
 =?utf-8?B?WWk5ZE1BRTNUZkJMQzNrNTJIYjZ0a2VlVUtLaEdPRGozYmQ4d0w0L0NpYlN0?=
 =?utf-8?B?V2dOSXV3UHVRUEFla1lEQVBsVW9pVWtjU0l1ckpHaERsN1E4TUIvZEhRbUZR?=
 =?utf-8?B?SUJaaGJ5VU1uZk1tTGtvS0RSU05Ka0Vua0JDZzUzRzhXQktja0FMeWZ0ZFl6?=
 =?utf-8?B?akNPbjhxWjE2RmZvdFRzcGh3eS9pT3hTSjJGR2RHZllQZUZIeVgvank4VDFT?=
 =?utf-8?B?SEJXRFhLRFpLY24reTRDZytZNHgyNnY5TEFlaFRXdGFPampPak0wZVRGenA3?=
 =?utf-8?B?UUhEVEVmZU1rN1V5UTNrYmFmSE96eEdvcEIzRy8wYUw1YnhSdS8wQnNPUHlt?=
 =?utf-8?B?djNJV3o5Z0lSYVFxb3N4dlRlMFRxKzUrWnNiaDJvamVjUDF5NDk5NlJSb2Ry?=
 =?utf-8?B?Q2w1UDJLa0FLTGJ6WTNwUHh6NFc5TkVYTTdSTUlIWVJ5bmNvdXZzS0xCYW5V?=
 =?utf-8?B?bitRNlh6bFV0VGUxOWZhS3doSzVKcjkvdEtwb014Q2Z1emp2TmwybU1ReVV5?=
 =?utf-8?B?alQrYm1FN2tBcWtKMm9PL080NjF6Tnd5QkFwQmJrNmo0Zjg4NTJkVEYxRkVQ?=
 =?utf-8?B?LzQybFd5S3JtcXBhaW5nUVk3V0tycTFlNEx3L3BzQkZBdjI2NlNiL3JVdUlI?=
 =?utf-8?B?ejhwdzZ6blpsODYyNFFBcHVmS2pDbDgwZWYrc0J6ZjRQazNIMm51dVNXZjBt?=
 =?utf-8?B?MEJBSFBLQkpMQXI0ZWVwWTRsWmxxVmsrM0NDYmZKaEVRYXFCQzRhbmxSTnl1?=
 =?utf-8?B?S3FqcEUzZEw4SlVYTnZ6Yk03cnc3U1lLTGc0bHdqT2lnT3hzOFVJQkVwYTc1?=
 =?utf-8?B?eG1WZjJibHpCem53OTJGdDhZQmlBY0ZBOHh4d2U3T29WWHE4NTlKOUR1Yzk0?=
 =?utf-8?B?NXYyVm9uby9KYzZDM0JRaDkyQmltUEJVTHFncEE3UXZTcVV5WENrL3RTU04x?=
 =?utf-8?B?YWhLSzFqa2NjZHhqYlorY3lzODZwL2lKcTNGaVk1V0p1OHQrUDBwYTdWbWZl?=
 =?utf-8?B?TVhFQVk5TFR6c3lRMjJTNUYwQk5rYWVOZEZJZnFOQkdKTjAxbzZxa1pzclla?=
 =?utf-8?B?UC9XdU1wYmRkN1RFMkM4UVUwYUZSVDQ5WTlxTmMvT1BuazRiRk1JQ0FPUEF4?=
 =?utf-8?B?YkZuQmtuZ0ZHSk53aVBXZjEra3E1c3VrbnMzNy94N3A1ejdLa3VqcGNabTNk?=
 =?utf-8?B?VG4zZFhjV1ZFam1UaWxlNzBKZW05bXlEb2lsZ0RTeXY5WVIvSXBYc2Zhb3Fw?=
 =?utf-8?B?WjVzc0h6Z2JIdzV0MDFtVmVLZVpDZzI4OFBvWXVNTkszWG1FUndPQmNoOHlv?=
 =?utf-8?B?Y1prS2ZwUDA0Y1kvcVZGaWpkSjNMTW5ZanB3djZhaDl4OS9qRWFyc0V0UkNI?=
 =?utf-8?B?UUFxSW1YUy9ZbERvbXZ6emFuZUdqVlI2Y3BTN0hBdm1ySUVveDJyMWRUWUNp?=
 =?utf-8?B?SWUzckUyeC9VVStHdUEvbDV6bVQrcm9aYUg3S2ZHSGNjN2lNeVRudnpBZWZa?=
 =?utf-8?B?elNncmNBVnNucXFRZE5TQkZZVGN6M1EyLzR3V3JmTXQ5T3RmcjB6SWp3bkJC?=
 =?utf-8?B?QmxOQUJPRnJ4eXhva1Qyb2h5S2RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86025FA78AA0B743BF8FB5B60CAE3846@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CtLKsoPiX8h8n7yBU/hBzCdnEj5AR6nCHDsMdU8pmsssQ7hRyEQ7geJxrTmHR6aEu9UDDYTFdNkFP5HPo92/SrajOsTJqbUezKLD/poKySeEPRaD5yWfAVw6oBjoK9ozcB4ozoog9MZkb7rh5ggvTMQnGrFBwyD0pTy0AvJmRVjlWsgVdV7ofyokb3C5fe2h8a65LF4DcpyTe5LlWUv6i79AmldlT92IE0UUdBAfB2ovaHepelUIXcxPakO093OgZvHZ5P7M3Fi1LrxG0wv9V46an4OzBrg+7nhhMphXWnOhNMmp+ZzPyTNq3o98+PUvXz1d8dleSAoZ1srPPc2rXs8VGovicWtVChOnkunlw3Nk+q0xhOqDVwU7AWdSy10Gg1nwLwfIXgmpiqmXgzDJZoOzOIB/gVq22sIJeFz9E2yQUkmcY9qCKaUIwzoW4ddh8mwaR8hiLMpaYXFOQPVXZcvZihKOM5TlDt83RdWe4HEveqPfkiCxyL9Lc+pukmdvWlW2l5GGyaBbI8YKeZS3atyfIqXzc5e2m+WnHcrhXw7Qr6vcgXWcAb4lj+pQq1buCLTT2ZLb+SPnxN1XS76YFApg1wMZhHzWoM0unVIQm4eBBUxcoA8kGC/oE3sFqJYK
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9a9b2c-7780-4757-dc6b-08dc23e7d2c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 12:09:35.9561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qI4ec4bbAbNZ/3l5dKz8S5j5sSxFM4cbt56F0yXeJH6/X0s3Vuc0SdBBHY/SGQxRsJ64fq97nfpq8n881XekVVzgk43rWUpE7XueBfY0N4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7543

T24gMDIuMDIuMjQgMTM6MDgsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gRnJpLCBGZWIgMDIs
IDIwMjQgYXQgMTE6MzQ6MDZBTSArMDAwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4g
T24gMDEuMDIuMjQgMTk6MDgsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4+PiBkaWZmIC0tZ2l0IGEv
ZnMvYnRyZnMvZnMuaCBiL2ZzL2J0cmZzL2ZzLmgNCj4+PiBpbmRleCBjZTFiZmQ5OTM4YjEuLmE4
YjNhODgyODE2MiAxMDA2NDQNCj4+PiAtLS0gYS9mcy9idHJmcy9mcy5oDQo+Pj4gKysrIGIvZnMv
YnRyZnMvZnMuaA0KPj4+IEBAIC04MzYsNiArODM2LDkgQEAgc3RydWN0IGJ0cmZzX2ZzX2luZm8g
ew0KPj4+ICAgICNkZWZpbmUgcGFnZV90b19mc19pbmZvKF9wYWdlKQkgKHBhZ2VfdG9faW5vZGUo
X3BhZ2UpLT5yb290LT5mc19pbmZvKQ0KPj4+ICAgICNkZWZpbmUgZm9saW9fdG9fZnNfaW5mbyhf
Zm9saW8pIChmb2xpb190b19pbm9kZShfZm9saW8pLT5yb290LT5mc19pbmZvKQ0KPj4+ICAgIA0K
Pj4+ICsjZGVmaW5lIGlub2RlX3RvX2ZzX2luZm8oX2lub2RlKSAoQlRSRlNfSShfR2VuZXJpYygo
X2lub2RlKSwJCQlcDQo+Pj4gKwkJCQkJICAgc3RydWN0IGlub2RlICo6IChfaW5vZGUpKSktPnJv
b3QtPmZzX2luZm8pDQo+Pg0KPj4gRGlkbid0IHRoYXQgdHJpcCBvdmVyIGEgTlVMTC1wb2ludGVy
IGluIHRoZSBsYXN0IGl0ZXJhdGlvbj8NCj4gDQo+IEl0IGRpZCBpbiBvbmUgcGFydGljdWxhciBj
YXNlIGFuZCBpdCdzIGJlZW4gZml4ZWQuIEluIGdlbmVyYWwNCj4gaW5vZGUtPnJvb3QtPmZzX2lu
Zm8gYWx3YXlzIGV4aXN0cy4NCj4gDQo+IA0KDQpBaCBvaywgdGhhbmtzIGZvciB0aGUgY2xhcmlm
aWNhdGlvbg0K

