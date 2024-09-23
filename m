Return-Path: <linux-btrfs+bounces-8169-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C181397ED46
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 16:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8FE1F22233
	for <lists+linux-btrfs@lfdr.de>; Mon, 23 Sep 2024 14:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBB719D886;
	Mon, 23 Sep 2024 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NO0gqSgl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="exkDKOxO"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDC77107;
	Mon, 23 Sep 2024 14:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727102493; cv=fail; b=rTNReuS4+weOCMCLZmjyM5CtQtymIOsz5zbiXcIuxkgg9rMFbmw39b5NwadCPHMe6qnSIOeks+J51YIl0ITTanlWVox8ooN2qhBjxqlZ6Gnxesk2TVOnoWaKJ4QnekTD9US7yZ3/5t9Q7x4sJXFxvKz+KJMdgUijs2z31zToJjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727102493; c=relaxed/simple;
	bh=UjugTbfYRRCCVbBOssrO282kyHgc5js7VQTXSeCQv5k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o3mCupr4xvhVIYqWhqC4fVCz0WLUylG3aLAYDJdMkLG9d9e0zbvPFbcj1h/2qahcj5hnh56+qkbyHzCvU2EEDK6aj+a+yp0Ycir6nBuqAaw0kEYcy8RGydv+UzHlPMRcEtQWESGYzXjGNMy1MNxGcl3wG5wkcFuVY6vqYczMDmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NO0gqSgl; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=exkDKOxO; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1727102490; x=1758638490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=UjugTbfYRRCCVbBOssrO282kyHgc5js7VQTXSeCQv5k=;
  b=NO0gqSgljUmnCG8k5HKVoOu27iuTSDmwC+JrxivxZ8TdKbW01W4EdBx0
   vhxCNJm/8gOzbeppSYO/OOqV5CAtuYQJhQGVwXaqI3xKIZilVypu+RAL7
   U8eqtXRRlK2KiXZM2P5MJM6tU9PN4n4RmziONQZWFU7Z6JwIA4qfyaBPe
   hhi1hPecJPSCuE8YIiT025ryBSSDsQnERYAMKzzwXcHuq0bq3Cn4IsEm4
   ABvqsUzZV5HlARzPN1CXGRvtrEoBg9K8FmmMlMEow8jqc1lTqxFO2C7c+
   rwcewdGE1LIHVymnN59ls1YBWYypEj3gVSWjAvspvm4iSzIGOBKRM/NsF
   Q==;
X-CSE-ConnectionGUID: cax2dQupTQmP7qGKbq+bhA==
X-CSE-MsgGUID: 1jNJv91DS7WS7dkeGuVm+Q==
X-IronPort-AV: E=Sophos;i="6.10,251,1719849600"; 
   d="scan'208";a="28200707"
Received: from mail-westcentralusazlp17010002.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.2])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2024 22:41:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Du6JlvJLZlh3E5ssM19dIOEZmPShQKlK7c6RfIaJmcBQOkE4rifgujkkS7OhEbCrsPCCOHiJz9QstA8324R2Wa9WY5u2fv9wB6o9RWPPAUVhwZ68RUIWKhjymjx5NZWjL/zvuX/Yn+mPvfGU7YRaZOE9zUneN4O/5+3BzQ8E7c8CYvlqi549b4zMBk7+7/uz6Hz1BjGV441rhQqksF16bQMvMBtHPnANAvwLpaExL397nUL0Ik0zJfF/nmJ4jBkks2+QJPqkz3Gummwyg2wpjZXpQaIlvmMBgLLGD8/OE9y3ezmrffKCU4BuzZUgiYwSfx+sx+LEiE0HACz6wVSYew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UjugTbfYRRCCVbBOssrO282kyHgc5js7VQTXSeCQv5k=;
 b=amWqBdvE/RannCPxJgLkE1ulxV9RNT3yA/G9uWlIyfq1tMAwarJaB3LpYhaM6LT/P6n44k06IgSzyGdRMUzoJnV8as5vZnrzBYjFm6MAJ955s7lUGEdtQoJ85AlYcTGN20a6afQJMSan9AWSUyZ/iKuxvLf3rbif1mJihCVKsGOvsUUlzddGcti3IFlOJpxfIx4Rn9/Z/ObzZvO0DJZmL+RsOiSvXUiPuJg3EKsz8lDTPLCgxIm/NYf+f7P3s72/tBLBGaXY+MEv42O0y7D/l7bRlhD2z0CP7DpdL5X5vcJD0LNCN+k/oATxgS7k7qRknDuxAsXpOj+XJiK28w510g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UjugTbfYRRCCVbBOssrO282kyHgc5js7VQTXSeCQv5k=;
 b=exkDKOxOyGu4SIZ6VSF2d4otkAYWAr6MBbHaToD62Nl8E746B+JcIbEXqXXyttZBJicwe/ihzsKa6LVUmn87tDNpQKXjhILn/ZdSJmnVLEXrp+hfWvisE6vaSrA1Xq4FPSWDAdos8UL6bfhLEP499yvtMM6aVsS98Rbqcnr/2SQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9567.namprd04.prod.outlook.com (2603:10b6:806:42e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 14:41:20 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 14:41:20 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "open list:BTRFS FILE SYSTEM"
	<linux-btrfs@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
CC: WenRuo Qu <wqu@suse.com>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: also add stripe entries for NOCOW writes
Thread-Topic: [PATCH] btrfs: also add stripe entries for NOCOW writes
Thread-Index:
 AQHbDYRHbR6Y52Md7kCz87BUoKnMl7Jk+VwAgAADdACAAARkgIAABUcAgAAKvQCAAGEOAA==
Date: Mon, 23 Sep 2024 14:41:20 +0000
Message-ID: <887a09bc-3c98-4bd1-aa31-0732fc633315@wdc.com>
References: <20240923064549.14224-1-jth@kernel.org>
 <71088008-c105-4eb9-9199-882091eafe07@gmx.com>
 <3c0c8517-a642-4e7b-bbcd-ef0022c49c3f@wdc.com>
 <d42756f6-d5a8-4f44-a6f0-6056f5c1015b@gmx.com>
 <aacb742c-2081-441e-ac52-d9e0f580ab1e@wdc.com>
 <47d0f003-ebc8-4959-a22c-ccf9ea7ef35a@gmx.com>
In-Reply-To: <47d0f003-ebc8-4959-a22c-ccf9ea7ef35a@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9567:EE_
x-ms-office365-filtering-correlation-id: c7d177fe-0b9e-41ca-bc76-08dcdbddca21
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UlhuYmRpVHdXVUtwVFMzNk1EcktRcXNTUDd2MVRvR0VBZWxoWEhvZGo4bld5?=
 =?utf-8?B?NnRLdlhGdWZmclVvWStBYkxMNFRCY3BxUnc5NjNGeU1Wb2dObXdXYWFQYzJj?=
 =?utf-8?B?b3FOZ2l5N0QyZjdGN2lRNVdJWlROUlF5TjhiSzIzVmFIYXlHcVJONUt1WjV3?=
 =?utf-8?B?aXlIVi95NFN0ZUVObGJNZlJnY21QWW9WVzBKOHBJMFEyUjI4Y3JQejJ3N2VJ?=
 =?utf-8?B?a2NWRXhzaU1RdzV4TE5CaEc3cEZTeFV4VHFGeHBYbnA0U2plOGIyenp4akF1?=
 =?utf-8?B?N3hTM3dWUEZFbUNsWWFSU0JkLzN2ZEVHKzk0OGorRHZpZEovQUp5QlpYajNo?=
 =?utf-8?B?bE52ZzNBb0JtejJLOFVFc2huWGtsR0Zsanh1ZzNDTkIzTU5mTHZZNTRrZmFt?=
 =?utf-8?B?T3pvSFExWjdHQjB4T0xrZWptb245WHFxOG5yTVQ1TjlBNkV0UHVTNklRVEJl?=
 =?utf-8?B?c0JHVkFKa00xZTNjQ3h1allXeWFJekhtN0FwREdvMk1DME5MbTA4RENZSTlN?=
 =?utf-8?B?S0JUNFVnUVdEKzd6Y2xrZnlBWldMclpNTFdhdUxLdjduTnpFN2x5MUpGc3Nq?=
 =?utf-8?B?czVjaWZWakpBbmE1dEhaVXJ2SFh6bnNxeUZGUmIzSG5FRHBiZFN0QlJwT0ZT?=
 =?utf-8?B?c0NDMG9ucUU2NHNUUVBmU1ZXL24ySWR1U3c3THNsVS9IcGY2WEh4enRoRXZX?=
 =?utf-8?B?LzlibHE3UE51aDVudzgrT21Oblk5ZHRXemxvSHZBeFZ2dXlIWEt0R1U0RHZO?=
 =?utf-8?B?M0Z5b0hXb2p1ZnArTUlvcTV3YXJZTWtaME84Ulg3SGRucTV4MkRpWldZSTh2?=
 =?utf-8?B?Yko2dzFyNmR4NEk5NGlyQUpSY2lZS2tsS2hzbzU0NDRPQXVzRis4Q1BPcVlI?=
 =?utf-8?B?bnVTZE9pVTFHajJVR2lyWkw5NjVXa21Wbm1TdC9RaFk2dkk1UEtTbEJXYStU?=
 =?utf-8?B?L3daK05EemZod2Y1YUVldkc0aVJZT2I4WjhMT3BlNnJWWEJaOFRVdFlmTGRU?=
 =?utf-8?B?blMzUnpQYkRUZ2p1UzFrbjRmcGptWm5NTW84ZDZ2R0JVZW13SnU0MVJraXI3?=
 =?utf-8?B?MVQxUThNVW94V2t0UmFrNXAvR0I2bGtvZ1p2dHRzYm9NR1FtSEFCOFhtWEFz?=
 =?utf-8?B?d1ZDWjN3dkk0SnluZ2U4V2Ywa1NBeXUzT0FBNjhHVlcvWjdMMm00Z1p4a2Nv?=
 =?utf-8?B?MFRFVzMxc28xYk85TFZQYzJoN01iTktaNm9NekdYMXJrdTM3by9KTE51alBE?=
 =?utf-8?B?T0dmQW9oYlRyU0FyNHVMWnp4Q2xHeTRLZWhLcE1mbDJ1cWJWbExZWkpwYUlD?=
 =?utf-8?B?UHFOcFAzd1NEcXNKbmpLMUdRdEplZWJ6WjMzRTdrVWFmVUFyZVBJR09wNlNt?=
 =?utf-8?B?Sy9nWk9TbUcrRTMyRmNFRktCSjJBMEhaU1lQeHZQNGk3eUxGNUZkTVkwSlYv?=
 =?utf-8?B?eFR5SkpsYVJacGNDQ2FNVkxyR3pZbXNMUjZ3SVhlRXdsbUVEMnR6dGVUUnN1?=
 =?utf-8?B?NzJqczNmZXR2aERGMWk0bUVZdFNSRGZUTElQOGNsaHZaaFI0eHU4TEdzaVZ5?=
 =?utf-8?B?SEQ0YmtPcWlTZVJ1a3N6THdSZEU3MHZ1WEhMUUZFeFQ2MWFCTXM0eGx0QkVz?=
 =?utf-8?B?UUYzN3lyS0hicEhyMVovUVR5Q09YdUthRXNDZXJiaHU0cVRKMWNEQzFlMSsr?=
 =?utf-8?B?UG8wNUJZdnlZd2ZBdFZEVUNNamY1NzY0dW9PK2M1VTgvamNaNVo3L0RwZnd5?=
 =?utf-8?B?c0MvK3B1UzM5SUg0anJJYkNqdlpMc2M1Ny9RSmthN1k5SldQdHRVZDZpbTZ0?=
 =?utf-8?B?RSswSmtVUWZ1VXN5VGtHb0hCemx3c0F2L21DbFZQb2JCb3JRY204U0R6NXpU?=
 =?utf-8?B?TEE0SzE2bW5mVC9uTjRMMkovVjd5Y3R6RWIvdlFuaWtOUkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTRWUFcrK1ZoUkYzTGxXOVcwWS9WUmd3dXdLVWNobGtsTmtsaGI4ZkIvbElX?=
 =?utf-8?B?TkFiRGpCdnRDb1RqMG80dTlVQVdxUjlkUkt0N3oxbkxZTEVPczgzanNmNE9K?=
 =?utf-8?B?K3lFQWo0akIzYzR0Uit0NWhCSndBaXNsZVpCSzRjRDlXNG1xNWl0ZWxMZmky?=
 =?utf-8?B?cXROM2k3d2tlMGNpOHNvSEVwN05KMnNLb2o0SUE2TDhqSnBhRllqQXpSNEY2?=
 =?utf-8?B?clBkcVB5MGdhOWJrU0pvUWNEZGlPVVFVNEw3VG9SREx4RzB6ZkpvbGNNN1pP?=
 =?utf-8?B?VFJwQm5wakcyWFhGNlp1RDNUUzZQeTlpWktJUThnbkkrZndCRDkrTlFLZzhN?=
 =?utf-8?B?aWcraTgxRHBjMlBYcVY5d2pFQ2NvUkZ3R285emdpWDNnRUsrZEtJYmxHdDRq?=
 =?utf-8?B?Vy80WGxSOGd3OUUrZVBFbkFhaURsM2JiNzlGWEFFYm5jWTdzQTZ2Z3RrM1ZE?=
 =?utf-8?B?OEZJWGZkbUh0MG0wTWljODRadWNaZHBLZTZmZlJsMUVQcDBxSmk4RWxiTlVm?=
 =?utf-8?B?RG5obkVrUUxkZmgyRHNQT3BUelhTTFl3d2xhbmlJQ3NFenY1UHJzbExaT2pH?=
 =?utf-8?B?U0R4SFlmcDl4cGM0MFA1YW5yb3d1UWdrMWpadU8xaUpkN2NmS3UxYnZTVmZV?=
 =?utf-8?B?TysvUWZqeVlJaGtIRlVFOTlHU1FvbFFlT1dHanByQ3J2OVBHMGUxdTZtdUNI?=
 =?utf-8?B?R0dybHlzRTFFZ0NnV1VKaWU5VDlLWThtRDUxRmtiU3c3Q0tXUVJpeVRkVExo?=
 =?utf-8?B?dnkxYmtNMHlOUHFNLzBvYWl5QWxvbUM0ZkN4cXlZMllJOC9PMTRwMHR4TGZP?=
 =?utf-8?B?bDIrYXlzWEJhUzNNVDB6bm1jc2I4L29RazZ1dmQ0RXhqM2pRZ1Qyb2lEUWpz?=
 =?utf-8?B?Rm41Q0pHdGlWVm1VUzhzVWtNZVJiVWhLUEhFUGxMZy9PbmlGVlV1ZVVaT1JZ?=
 =?utf-8?B?Y2ZueTBuZnlTdkFlY1p1aHBBbFlqRTljTmc4N1RaWnMwM1Q4bzRwK2plM295?=
 =?utf-8?B?bmF4VHJLdHE1YVdERXJYcFIyL0VKQkkyV1FNQlZpOTJrWUUwRUw0ZUlBSEFy?=
 =?utf-8?B?SlFkOTlMcGJhWlZKK3RxUEVUa2UvWWRiUC9ZcWVJemJnOEhheE9WcVVvVE01?=
 =?utf-8?B?Z08yaVZvT3NwVjU0UGRjTFh6aFRsenY2N01PM3JqOHc1djFsZVZhTGRuZkZ2?=
 =?utf-8?B?Mm1OcFdZaHBDa2FnSEZyS0hzNEZ2cyt3RlhLc1B0ZStFeGI0MmUxd0xEQTlR?=
 =?utf-8?B?K3M3M1ViS21ROHhtTk12Rm1mSjlLdXUzSzAyUXFnaThhOGpDbzNZbzFKQWJR?=
 =?utf-8?B?Z3VWOGV3Sll3ZGN4OHh2dlVWRzV3OWtqUTlQbDdkdzF5b0RoOVB4cVI3Kyt2?=
 =?utf-8?B?VUd1c1NQL2xQZjVWQU5xc0wvcFJxWWxBUVp3bVhDcUtodjllWS93Q08zVVNY?=
 =?utf-8?B?UzB6WTNIT3phTVMyc3NWazdnV3hDR1VQWlJyQloyUEhhaVA2NkJHb2xEZ0Uz?=
 =?utf-8?B?bldxM1BUc0YvS1BycW5sTGtFMTFPVzBCUFgwV01FTm9QcXlReGVwY28xOFhy?=
 =?utf-8?B?UUxJRGRYOUN1SUVSa1BXSTU1NytKTjMvWXR2dmVoNnUzRDdKcjZ6Tkt2UmVR?=
 =?utf-8?B?dHU2N1lkRmRKalBtRXRtWnBNNHNjNFJZVTgvOHNpUWtpa1BQTGdaZFh5RnVC?=
 =?utf-8?B?NW9rMFIwUDlhbzFpMU8vWGY1YUJTTW1wYkM1RWNaM1NNRm5wQTVOV2Y4WS92?=
 =?utf-8?B?a2gwVlRPRTJmMHNEQXFETXRwNVJETUNHcDVRSWRNM0ZXNGdTNU1iU3Iwa09v?=
 =?utf-8?B?ZHBBVXkzVkFRdzFCSGFBZFRrQi9WalhpMGFWT004TVZUVE5rZnBGRlFHMG5P?=
 =?utf-8?B?ejdhbTViNHFKSmFOWWhCU204MnpKdUR6QW81ZzBmRFJCMC9KczVjL3FIbHpM?=
 =?utf-8?B?aG5ZYTlPQVpTdUhvVUVHeFJkWEJUQWhJTG04QU5aOGhKOUNOR0RtOW5kMWgz?=
 =?utf-8?B?YVJZUkgrT1FDY24zRSs4OGM5dXZFY2pQRjZKU05Ub1RmdXVOZlFsYzBlTHN1?=
 =?utf-8?B?M1pRT2twYkJUakoxUVk0OXNpWXJ6RXFJVzdlcEpubEh3YWNlOWd6LzBiakU3?=
 =?utf-8?B?QjRia2lOZzJLSmdwaGFBa3FjWndZQ0NNeHBmOUp1L1Rhb3RMS1ZVOEsyWFJF?=
 =?utf-8?B?MDkrTkxqU20wQXJNeWZYZjhoWG5iU01aSWhpa2ZMaXh4VWs2M2pHYmtYMlNK?=
 =?utf-8?B?VkNGMzMvQ0lWU1pxeHJ2YnIrR1lnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CAA40F7531CF644E9C49923BE24C68A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3bUEh3VUCCUPwRZQwxg7hInKdGHLYXbxtanxw/eJtbbRYig1R2bJsu3klwvVphco0DUC8r6pNt6Gn+MsrtfefWJTRhOiKC8WRl/1zslTmJY1hyuKjrHMPVmnws729lPIt0HFkUF+v1t4VwjmlbnWotOogxsfnLqr30LE3Z4PScXoIQGHG1V9tO5EEw3GDMmYqbZ1IAD+uxt29PK02UzDzSGR/2zvJMg1Vitfv1PRH7HphSeHqU69aQbW12rz9nHr8q+VuvUMuSSOq+lzYZWka8NsWz5oSv3w2M8wxB57EkkyKaoQvqq7aHYRng0CLisIjDIFSnHHmcyuxc1NBRmCtloCx9jKmx7ruIP/SQ5mByVqcBj3xSdkX5wnW7xtKgmTB3DLo77oxuFfuIwNinuaC234xuyhzouRprMAlfkGmzzq/puibmRTXc9stwZAyvvJWZ+ZcAUXqlI2zYk4V0EHwwLNYCQV6Dn3x3Oy50cF4R1pXjnGU4Ge/wJjprVwfG0uReU5GCcVc6ef/o1My+s3z5pE2vlFHavtVxSv6mwEj7+miE/F4r8Sw8RCEg3UwX0ockyz7v4M/+1PPXYJu641K6YTNf8ZvFtC+cKyiIgfdIoAi4jkTkbV7KIrNH9paJ2h
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7d177fe-0b9e-41ca-bc76-08dcdbddca21
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2024 14:41:20.5141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhuyrga7zaxXQ5QMRl4X4GDwma94cJKtvOVZVHbjwMmtx9da7NJO/c4cmCvFPQgEV0m0l2qPKKE48I9vCH6ViTykEAaR6jaz8H3wn75CbWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9567

T24gMjMuMDkuMjQgMTA6NTQsIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC85
LzIzIDE3OjQ1LCBKb2hhbm5lcyBUaHVtc2hpcm4g5YaZ6YGTOg0KPj4gT24gMjMuMDkuMjQgMDk6
NTYsIFF1IFdlbnJ1byB3cm90ZToNCj4+Pj4+IOWcqCAyMDI0LzkvMjMgMTY6MTUsIEpvaGFubmVz
IFRodW1zaGlybiDlhpnpgZM6DQo+Pj4+Pj4gRnJvbTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hh
bm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+Pj4+Pg0KPj4+Pj4+IE5PQ09XIHdyaXRlcyBkbyBu
b3QgZ2VuZXJhdGUgc3RyaXBlX2V4dGVudCBlbnRyaWVzIGluIHRoZSBSQUlEIHN0cmlwZQ0KPj4+
Pj4+IHRyZWUsIGFzIHRoZSBSQUlEIHN0cmlwZS10cmVlIGZlYXR1cmUgaW5pdGlhbGx5IHdhcyBk
ZXNpZ25lZCB3aXRoIGENCj4+Pj4+PiB6b25lZCBmaWxlc3lzdGVtIGluIG1pbmQgYW5kIG9uIGEg
em9uZWQgZmlsZXN5c3RlbSwgd2UgZG8gbm90IGFsbG93IE5PQ09XDQo+Pj4+Pj4gd3JpdGVzLiBC
dXQgdGhlIFJBSUQgc3RyaXBlLXRyZWUgZmVhdHVyZSBpcyBpbmRlcGVuZGVudCBmcm9tIHRoZSB6
b25lZA0KPj4+Pj4+IGZlYXR1cmUsIHNvIHdlIG11c3QgYWxzbyBhbGxvdyBOT0NPVyB3cml0ZXMg
Zm9yIHpvbmVkIGZpbGVzeXN0ZW1zLg0KPj4+Pj4+DQo+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogSm9o
YW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCj4+Pj4+DQo+Pj4+
PiBTb3JyeSBJJ20gZ29pbmcgdG8gcmVwZWF0IG15c2VsZiBhZ2FpbiwgSSBzdGlsbCBiZWxpZXZl
IGlmIHdlIGluc2VydCBhbg0KPj4+Pj4gUlNUIGVudHJ5IGF0IGZhbGxvYygpIHRpbWUsIGl0IHdp
bGwgYmUgbW9yZSBjb25zaXN0ZW50IHdpdGggdGhlIG5vbi1SU1QNCj4+Pj4+IGNvZGUuDQo+Pj4+
Pg0KPj4+Pj4gWWVzLCBJIGtub3duIHByZWFsbG9jYXRlZCBzcGFjZSB3aWxsIG5vdCBuZWVkIGFu
eSByZWFkIG5vciBzZWFyY2ggUlNUDQo+Pj4+PiBlbnRyeSwgYW5kIHdlIGp1c3QgZmlsbCB0aGUg
cGFnZSBjYWNoZSB3aXRoIHplcm8gYXQgcmVhZCB0aW1lLg0KPj4+Pj4NCj4+Pj4+IEJ1dCB0aGUg
cG9pbnQgb2YgcHJvcGVyIChub3QganVzdCBkdW1teSkgUlNUIGVudHJ5IGZvciB0aGUgd2hvbGUN
Cj4+Pj4+IHByZWFsbG9jYXRlZCBzcGFjZSBpcywgd2UgZG8gbm90IG5lZWQgdG8gdG91Y2ggdGhl
IFJTVCBlbnRyeSBhbnltb3JlIGZvcg0KPj4+Pj4gTk9DT1cvUFJFQUxMT0NBVEVEIHdyaXRlIGF0
IGFsbC4NCj4+Pj4+DQo+Pj4+PiBUaGlzIG1ha2VzIHRoZSBSU1QgTk9DT1cvUFJFQUxMT0Mgd3Jp
dGVzIGJlaGF2aW9yIHRvIGFsaWduIHdpdGggdGhlDQo+Pj4+PiBub24tUlNUIGNvZGUsIHdoaWNo
IGRvZXNuJ3QgdXBkYXRlIGFueSBleHRlbnQgaXRlbSwgYnV0IG9ubHkgbW9kaWZ5IHRoZQ0KPj4+
Pj4gZmlsZSBleHRlbnQgZm9yIFBSRUFMTE9DIHdyaXRlcy4NCj4+Pj4NCj4+Pj4gUGxlYXNlIHJl
LXJlYWQgdGhlIHBhdGNoLiBUaGlzIGlzIG5vdCBhIGR1bW15IFJTVCBlbnRyeSBidXQgYSByZWFs
IFJTVA0KPj4+PiBlbnRyeSBmb3IgTk9DT1cgd3JpdGVzLg0KPj4+Pg0KPj4+IEkga25vdywgYnV0
IG15IHBvaW50IGlzLCBpZiB0aGUgUlNUIGVudHJ5IGZvciBwcmVhbGxvY2F0ZWQgcmFuZ2UgaXMN
Cj4+PiBhbHJlYWR5IGEgcmVndWxhciBvbmUsIHlvdSB3b24ndCBldmVuIG5lZWQgdG8gaW5zZXJ0
L3VwZGF0ZSB0aGUgUlNUIHRyZWUNCj4+PiBhdCBhbGwuDQo+Pj4NCj4+PiBKdXN0IGxpa2Ugd2Ug
ZG8gbm90IG5lZWQgdG8gdXBkYXRlIHRoZSBleHRlbnQgdHJlZSBmb3INCj4+PiBOT0NPVy9QUkVB
TExPQ0FURUQgd3JpdGVzLg0KPj4NCj4+IEJ1dCBhcyBsb25nIGFzIHRoZXJlIGlzIG5vIGRhdGEg
b24gZGlzayB0aGVyZSBpcyBubyBwb2ludCBvZiBoYXZpbmcgYQ0KPj4gbG9naWNhbCB0byBOLWRp
c2sgcGh5c2ljYWwgbWFwcGluZy4gV2UgaGF2ZW4ndCBldmVuIGNhbGxlZA0KPj4gYnRyZnNfbWFw
X2Jsb2NrKCkgYmVmb3JlLCBzbyB3aGVyZSBkbyB3ZSBrbm93IHdoaWNoIGRpc2tzIHdpbGwgZ2V0
IHRoZQ0KPj4gYmxvY2tzIGF0IHdoaWNoIGFkZHJlc3M/IExvb2sgYXQgdGhpcyBleGFtcGxlOg0K
Pj4NCj4+IEZhbGxvY2F0ZSBbMCwgMU1dDQo+PiB2aXJ0bWUtc2NzaTovbW50ICMgeGZzX2lvIC1m
YyAiZmFsbG9jIDAgMU0iIC1jIHN5bmMgdGVzdA0KPiBbLi4uXQ0KPj4NCj4+DQo+PiBbMV0gd2Ug
cHJlYWxsb2NhdGUgdGhlIGRhdGEgZm9yIFswLCAxTV0gQCAyOTg4NDQxNjANCj4+IFsyXSB3ZSBo
YXZlIHRoZSBhY3R1YWwgd3JpdHRlbiBkYXRhIGZvciBbNjRrLCAxMjhrXSBAIDI5ODg0NDE2MA0K
Pj4NCj4+IFdoYXQgc2hvdWxkIEkgZG8gdG8gaW5zZXJ0IHRoZSBSU1QgZW50cnkgdGhlcmUgYXMg
d2UgZ2V0Og0KPiANCj4gRG8gdGhlIG5lZWRlZCB3cml0ZSBtYXAgYW5kIGluc2VydCB0aGUgUlNU
IGVudHJpZXMsIGp1c3QgYXMgaWYgd2UncmUNCj4gZG9pbmcgYSB3cml0ZSwgYnV0IHdpdGhvdXQg
YW55IGFjdHVhbCBJTy4NCj4gDQo+IA0KPiBDdXJyZW50bHkgdGhlIGhhbmRsaW5nIG9mIFJTVCBp
cyBub3QgY29uc2lzdGVudCB3aXRoIG5vbi1SU1QsIHRodXMNCj4gdGhhdCdzIHRoZSByZWFzb24g
Y2F1c2luZyBwcm9ibGVtcyB3aXRoIHNjcnViIG9uIHByZWFsbG9jYXRlZCBleHRlbnRzLg0KPiAN
Cj4gSSBrbm93biBwcmVhbGxvY2F0ZWQgcmFuZ2Ugd29uJ3QgdHJpZ2dlciBhbnkgcmVhZCB0aHVz
IGl0IG1ha2VzIG5vIHNlbnNlDQo+IHRvIGRvIHRoZSBwcm9wZXIgUlNUIHNldHVwLg0KPiBCdXQg
bGV0J3MgYWxzbyB0YWtlIHRoZSBleGFtcGxlIG9mIG5vbi1SU1Qgc2NydWI6DQo+IA0KPiBEbyB3
ZSBzcGVuZCBvdXIgdGltZSBjaGVja2luZyBpZiBhIGRhdGEgZXh0ZW50IGlzIHByZWFsbG9jYXRl
ZCBvciBub3Q/DQo+IE5vLCB3ZSBkbyBub3QuIFdlIGp1c3QgcmVhZCB0aGUgY29udGVudCwgYW5k
IGNoZWNrIGFnYWluc3QgaXRzIGNzdW0uDQo+IEZvciBwcmVhbGxvY2F0ZWQgZXh0ZW50cywgaXQg
anVzdCBoYXMgbm8gY3N1bS4NCj4gDQo+IFlvdSBjYW4gYXJndWUgdGhhdCB0aGlzIGlzIHdhc3Rp
bmcgSU8sIGJ1dCBJIGNhbiBhbHNvIGNvdW50ZXItYXJndWUgdGhhdA0KPiB3ZSBuZWVkIHRvIG1h
a2Ugc3VyZSB0aGUgcmVhZCBvbiB0aGF0IGRldmljZSByYW5nZSBpcyBmaW5lLCBldmVuIGlmIHdl
DQo+IGtub3cgd2Ugd2lsbCBub3QgcmVhbGx5IHJlYWQgdGhlIGNvbnRlbnQgKGJ1dCB0aGF0J3Mg
b25seSBmb3Igbm93KS4NCj4gDQo+IA0KPiBGdXJ0aGVybW9yZSwgZnJvbSB0aGUgbG9naWNhbCBh
c3BlY3QsIGF0IGxlYXN0IHRvIG1lLCBub24tUlNUIGNhc2UgaXMNCj4ganVzdCBhIHNwZWNpYWwg
Y2FzZSB3aGVyZSBsb2dpY2FsIGFkZHJlc3MgaXMgMToxIG1hcHBlZCBhbHJlYWR5Lg0KPiANCj4g
VGhpcyBhbHNvIG1lYW5zLCBldmVuIGZvciBwcmVhbGxvY2F0ZWQgZXh0ZW50cywgdGhleSBzaG91
bGQgaGF2ZSBSU1QNCj4gZW50cmllcy4NCj4gDQo+IA0KPiBGaW5hbGx5LCBJIGRvIG5vdCB0aGlu
ayBpdCdzIGEgZ29vZCBpZGVhIHRvIGluc2VydCBSU1QgZW50cmllcyBmb3IgTk9DT1cuDQo+IElm
IGEgZmlsZSBpcyBzZXQgTk9DT1csIGl0IG1lYW5zIHdlJ2xsIGRvaW5nIGEgbG90IG9mIG92ZXJ3
cml0ZSBmb3IgaXQuDQo+IFRoZW4gd2h5IHdhc3RlIG91ciB0aW1lIHVwZGF0aW5nIHRoZSBSU1Qg
ZW50cmllcyBhZ2FpbiBhbmQgYWdhaW4/DQo+IA0KPiBJc24ndCBzdWNoIGJlaGF2aW9yIGdvaW5n
IHRvIGNhdXNlIG1vcmUgd3JpdGUgYW1wbGlmaWNhdGlvbj8gTWVhbndoaWxlDQo+IGZvciBub24t
UlNUIGNhc2VzLCBOT0NPVyBzaG91bGQgY2F1c2UgdGhlIGxlYXN0IGFtb3VudCBvZiB3cml0ZQ0K
PiBhbXBsaWZpY2F0aW9uLg0KDQpUaGUgd2hvbGUgaWRlYSBiZWhpbmQgdGhlIFJTVCB3YXMgdG8g
d3JpdGUgdGhlIFJTVCBlbnRyaWVzIF9hZnRlcl8gdGhlIA0KZGF0YSBoYXMgYmVlbiBwZXJzaXN0
ZWQgdG8gZGlzay4gT3RoZXJ3aXNlIHdlJ3JlIGJhY2sgYXQgdGhlIHdyaXRlIGhvbGUgDQpwcm9i
bGVtLiBTZWUgZm9yIGV4YW1wbGUgdGhpcyBpbWFnaW5hcnkgc2VxdWVuY2U6DQoNClByZWFsbG9j
YXRlIGEgcmFuZ2UuIFRoaXMgd2lsbCB0aGVuIGFsc28gcHJlYWxsb2NhdGUgdGhlIFJTVCBlbnRy
aWVzIA0Kd2l0aCB0aGUgbWFwcGluZyBhcyB5b3UgZGVzY3JpYmUuIFdyaXRlIHRvIGl0IGFuZCB3
aGlsZSB5b3Ugd3JpdGUgeW91IA0KaGF2ZSBhIHBvd2VybG9zcy4gVGhlIGNvcHkvc3RyaXBlIHRv
IGRpc2sgMSBpcyBjb3JyZWN0bHkgd3JpdHRlbiBidXQgDQpkaXNrIDIgZGlkbid0IHJlcG9ydCBi
YWNrIGJlZm9yZSB0aGUgcG93ZXIgbG9zcyBoYXBwZW5lZC4gQWZ0ZXIgd2UgaGF2ZSANCnBvd2Vy
IGFnYWluLCBhIHJlYWQgdG8gZGlzayAyIGNvbWVzIGluLCBhcyB3ZSBoYXZlIGEgUlNUIGVudHJ5
LCB0aGUgcmVhZCANCndpbGwgYmUgZGlyZWN0ZWQgdG8gdGhlIGJyb2tlbiBlbnRyeSBhbmQgZ2Fy
YmFnZSBpcyByZXR1cm5lZC4gQW5kIHRoaXMgDQppcyB0aGUgZ29vZCBjYXNlLCBhcyB3ZSBjYW4g
cmVwYWlyIGl0Lg0KSWYgaXQgd2FzIGFuIG92ZXJ3cml0ZSBvZiBhIGJsb2NrIGFuZCB0aGUgc2Ft
ZSBoYXBwZW5zLCB3ZSBoYXZlIGEgUlNUIA0KZW50cnkgcG9pbnRpbmcgdG8gYSBnb29kIGFuZCBh
IGJhZCBjb3B5Lg0KDQpPbmNlIHdlJ3JlIGFkZGluZyB0aGUgUlNUIGVudHJpZXMgYWZ0ZXIgYm90
aCB3cml0ZXMgc3VjY2VlZCB0aGUgcHJvYmxlbSANCmlzbid0IHRoZXJlLiBTbyBmb3IgcHJlYWxs
b2NhdGVkIGV4dGVudHMgaXQgaXMgZXZlbiBoYXJtZnVsIHRvIGFkZCBhIFJTVCANCmVudHJ5Lg0K

