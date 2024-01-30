Return-Path: <linux-btrfs+bounces-1937-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A2842445
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 12:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD3B1F2DE7E
	for <lists+linux-btrfs@lfdr.de>; Tue, 30 Jan 2024 11:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA29A67E68;
	Tue, 30 Jan 2024 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rrcp6HzE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BPMYsEwa"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B9A67E62
	for <linux-btrfs@vger.kernel.org>; Tue, 30 Jan 2024 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615925; cv=fail; b=uu04b5UNOS7QqHHE1kP/J6wb1IjDgR6EAk/tj0pGmKZTBUQy5HB3kvRwsiZfbZL0M18a9WQ+hNExjpkce0UdvGnntzNnA+mW2Si2tmwi0gHq8vWUKa3p3u9PfsWP/m6E1l/EOEU5fBjaWpDfnNwCxp9HTr/TFPcmG+6f8GZNIHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615925; c=relaxed/simple;
	bh=N931Wioka9CqZ2hAvWyw4w5AKYBisNrrq/PuVZq95W0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pSVkN4CXRNzj0S3ILJccHLl/TG59leEfFPvpLxAQElZ5j45jC72TfE31iqvJttAba0YDuX3FN6JbHs4ADzZyJ3392C6P8EQeq0oMu5k8ocSv1+wGdx14dqrBMQga1OjhLWbVgabp9nUo2e0GUcnOFkFUEN+Mjkxocv5iyY81g/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=rrcp6HzE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=BPMYsEwa; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706615923; x=1738151923;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=N931Wioka9CqZ2hAvWyw4w5AKYBisNrrq/PuVZq95W0=;
  b=rrcp6HzEMKW4r0yN+TstQBF+d6wMF0Nbvoqt0DKqSMO/tzQvu+S6dZOP
   tvdBPpajC2qR/xvG4cjhAfISNYdcVtuoOBeMxhYQULZRHbydzVJWFv2/i
   rHo4WJPxLuyLqZMsqBdWr0cBkh2K8BzElCdfBXILyfcvdrNa64E8bFapB
   6KA33XWFRfrwVz8B24YEsbD2n7zyJIfhOa97g36CIieSv4t9GUjzVTHjY
   1VCGyYdb+IAMb9KEFDPqiGpvMZt6e3Zkyn4/V8AdU2kmqiQ7sHt/izY1R
   t+Rx5ZmqNvaxC++yC33zhyNixWk+2fOMHlDWveOsEt1KM5Z8O2H3l+wyR
   Q==;
X-CSE-ConnectionGUID: shA55sJ2SJqk24dVOJeJmw==
X-CSE-MsgGUID: 7O9Kft5/R66sbT+pWtdrdA==
X-IronPort-AV: E=Sophos;i="6.05,707,1701100800"; 
   d="scan'208";a="7999801"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jan 2024 19:58:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGfCuMlWUgkafsSGvydB7w8H+QdUooQqDMAZv8DYCMcNuzLgroLMp/t3bydQYCyoU7Zpw+icsfdnxLDTPNTNV0ultqVVQcb6UDJtPpvuuewSe6Bte+VX6JfVx89vHgcCAEQI96yzHCmS9mHx1fIWpTfWrJEa9z2S5YVpfTvePr4Qnj3ccF6sX7ElXNVSh5R0WPAdKuVpophRMD+QBT3g9SI/9j6t/Wle7j4vwl8tFNHQXMXG57AUkWD/eVBetj0H13K3bsoOO031rmdbTacwIKLkI3e7OhvvwQXnr6rRnNZOTUpOvEbR3/aEhgnGl0mhqxbDQ1R2LmoUQLncgBYbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N931Wioka9CqZ2hAvWyw4w5AKYBisNrrq/PuVZq95W0=;
 b=mcmXME/BP06KSPp3DvE2ggDfJTAfknJnfDoo4Xp41gYbnUFZ1yPVttZ/XG37jTpsPi3DmO7ogs+P6HJN91t7AtTmahafN/7py7raMw3IY3ic9LHCHZYmk4FHW4RuGUwV7FgeUzdQ13UHoGGvSdtFpT31BqXLtxZcSeG+R95/vGAu37+aBQQNdrfkLUFrih4dIUTkoY21NEY1bPofVooMIYwIN0dn4MWdRwY43RMdcffD3J9dvr++O4PPSZd/+w4LMhUbXA9u4gEQMgFn6BGwXfqsjElRpzGKohAAHN4O5NIwVAfZWCRbpHzM8SL7d67Wh6SDH/t9IWSs9R7U72ll3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N931Wioka9CqZ2hAvWyw4w5AKYBisNrrq/PuVZq95W0=;
 b=BPMYsEwaqRf2cYzi1QmlaYjMzqcCMT8sKuUI3rarflticwTsFqWydWnqaEe/SJ87gOoKt695hx4VDVx+12VQQWThi3fUDlLeXka+Jg8hQ3oGK55qT7AUWkh4RkB1yI3Iz1JK8H6A8RFdSK00epkKt5UlIXU/Sbx+rFcm2TFcbRo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB7930.namprd04.prod.outlook.com (2603:10b6:208:339::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 11:58:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::649f:fe78:f90c:464c%6]) with mapi id 15.20.7228.036; Tue, 30 Jan 2024
 11:58:40 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 3/5] btrfs: add helpers to get fs_info from page/folio
 pointers
Thread-Topic: [PATCH 3/5] btrfs: add helpers to get fs_info from page/folio
 pointers
Thread-Index: AQHaUuG7HJ4Q74Jb/0WfvGCVCVTDjrDyQY+A
Date: Tue, 30 Jan 2024 11:58:40 +0000
Message-ID: <2495e4f7-f389-46fa-a111-0e3e6deedaab@wdc.com>
References: <cover.1706553080.git.dsterba@suse.com>
 <b93ed05e42a65c5bb11a8c5a3bdad9facb3ed43a.1706553080.git.dsterba@suse.com>
In-Reply-To:
 <b93ed05e42a65c5bb11a8c5a3bdad9facb3ed43a.1706553080.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB7930:EE_
x-ms-office365-filtering-correlation-id: d844aa4b-85d9-4981-d8d7-08dc218accb9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GUsyFn6we4gtQkoXdb1HhlsVbemjFnNX3VCYTAUuT+nFoB8MjBSZ+Kb0bBRN0yCBy+xumz9Z0UeXzwAJlECkWQJfw1xF7Sk4mg+aptrWb9HPvQ2SnTPZ9A67AJwxfK5l5SzKHjvkycHvqRi8uStmRfSTSSsjjvjzIbUP0pQjUaHbWJ9n+5ULlVqldJTpb2kJ1SjpEH8SEgBGwbJqSPCwN7kVodyestPcOWo4OQ42a4YI4Ub9QyJgkOV68eBvS9/JCHb+YDlJNzvf5/hnj8UZAh04anWom4WLijDD4rCDW/D8dQjeLCXWR7Saltm+icT44iglNkMI1eGcez6YF7DRArwzNS6jRnvBsxfXM0NzQvCThGuSSKxAUS+LvR+jqbrCjux5NS2Z3PO2/WBkoN4rWT6Sx3HbR6XBvBetibApGYNxXdpsaG70DzX/VRjVbFZTIlzlRgRCYFyWYVlC/55rgvbWvMd/EF4238gsKeJUOL5na/Ew808+IyDNG12TQztVPgiYhdFcybryG6WqsQ8sYQAElzPCPpX3aoWZd3X3uGLinslCBM4yxExFVDUJUHss+ZSoVZn7JVC3/AbYVv1yKQL2ye2qYfQNLuk0SIf8sJIo9um4jwedzuhIDAlqh5XxPhm1ag3Eu3Iq08cB+Qf/4DhXdjUfd78JemaEhbx2AAzh6HB0maRFtLdNFfwXGM+0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(82960400001)(86362001)(36756003)(31696002)(38070700009)(66556008)(122000001)(4744005)(2616005)(6512007)(38100700002)(6506007)(41300700001)(66946007)(76116006)(478600001)(2906002)(91956017)(110136005)(8676002)(316002)(66476007)(64756008)(53546011)(71200400001)(66446008)(8936002)(5660300002)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YklkK3JSRW1jVW90b21lRWpqQzB1MFdUWm1HWU94RE5oMUxUSUF6emw4RDF5?=
 =?utf-8?B?YVZmMEdhRkgyc1lBOW15bGdoR2FkNzB6ZWRxRnhEMWhHb0Q2dzZzbTkxOWJx?=
 =?utf-8?B?YlZJZllCVGZXSnVuYWdIT2Z6M3RvT2JNYUhZOUxaWkFpVVFETXg3VThKY294?=
 =?utf-8?B?SFJnOFUveklXQjR1MnBKT01Xb1VEZzJJK1h0UXZTMGM2VW1teEJxUEJ2dWxT?=
 =?utf-8?B?TFZ5UU9KbXVEaXlqbWI0eWUyOXZ1dS9sNi9HQU9CN2tnUGJwZ2JFR3pFVnVs?=
 =?utf-8?B?SkRhN2tCa2Z4RVkwNTZSRXdMSHRmMlVFb0ZpSmNvZStJc2JWT29mSGpNRTYv?=
 =?utf-8?B?NkkwcjlnMkJrSHFXbzRYK1U4SUZEdXhxWHEvWnBQZTFVS0pXa00rY1k1M0Zp?=
 =?utf-8?B?WW43N3pwNCtPcG1TZ1NKbnVOTDNUcWprKytqM0RMTFg2NEFMYkIvamcreFh0?=
 =?utf-8?B?ZVQyWVlIcDdjd1I2SGg4eUVJMUFYL0I4L0tzU2FHd3ZPT1kybmF3YjNWbnl2?=
 =?utf-8?B?TitMR21Oa0xIaWtzQkNidm9sb3RnM2FGcER1d2U3d3Y2a3NaczRDcnFqUXJs?=
 =?utf-8?B?d2l0eWE2S1BuYUdDM0F6MzJHL1JEWkE0aTF3Uy81cFZ4cEJxSjdhRXBFOCtF?=
 =?utf-8?B?Q3owNTJJL1ZNSEo3cGt2eE1oTDNzT3c2YlpGZVpWZVM3bFB1VEhTZmhaY3Zo?=
 =?utf-8?B?cGdQYllTUWJRQmpDdy93b2dDYnNhTkQ1UVpsSHBDUk9LNHNBQkVCVkMyOWk2?=
 =?utf-8?B?c0l0KzlRUGI1VEtMNVBONjAwblZGR1kraGpUbDRVOTRMQmNJREc2T2RQY2V6?=
 =?utf-8?B?OHJZNVZQRkRnbXl3NTgrOFYwOTJRWGc4dnA1UEpyQXJ5NTRQODJhaUwzNGg3?=
 =?utf-8?B?Mld6S2lnaGt2OWViN1hiNHovckZlYXo4MUNyVnpJMWVORlV4M0xXaUhVandC?=
 =?utf-8?B?eDZMREdqU0tYbHBHTGJZWnR2Q0xwMml3eStMUHhYRXdEQnliblh3RmNzcVF1?=
 =?utf-8?B?UzFnMkFyeEZvQTIvS2FCcnF2N2V1alg0TnhtVXNnQTNKTU9iQkZSakdDODlo?=
 =?utf-8?B?MERwV3hCNWgvM0F0eHVzajJRbEUvelppZHRTbzBndnM2eTROWlBySnZhTDJE?=
 =?utf-8?B?cHIxZHE0bm51KzB2M1dWWUZGVG9ON0xFb3JLZjFxWkxKOTltd2U0dXV2Z2ZB?=
 =?utf-8?B?STlFQlU1VmVvNHptZHFqN2ZEb2hJcUJ2akZoRXdzUTIrWjZxeHlHdFRQTlQ3?=
 =?utf-8?B?OWROVmdlRGpaUC9pUEswWWN5dU5GRmdRb1FUUXh6WHpOUERIdC9hZmJINHFi?=
 =?utf-8?B?cFlnUy9TZmZXdUJNOE1qVVplUDNobkp4WFBxanZEQldENTB5NC85bVZRcjVl?=
 =?utf-8?B?TTVxZDduWVYyWTd5VzhJY3N1Ti9XSGJpOGJaYkI5QXNJVXF4Z3cxMUVJeCtK?=
 =?utf-8?B?NXBrL2dGK3A2N0NwbmlueTB5aTNMeVB0R3BCbDkvYVRSbFJNeUQyRE1EbWhT?=
 =?utf-8?B?UWRCUEhSaWlza2w2U2VIRjR5UWppbmg2SXlJOU01d3BCeDhIbG5zbWQ5eDZm?=
 =?utf-8?B?TWppNk53ck9oTGFiWWdjWDJRaHZtUm5tTUlGRWhxWU5VWjhta091empvS3Fy?=
 =?utf-8?B?RG52RU04Z2NLamViN3hoTGErT3lZOVZBQ2lJa3NMWkl6YlF4V2NPSjUxU2RE?=
 =?utf-8?B?OC9ZZ2NKYUo4aGdJbFBBejloTVBhVTJCcmM3RUpQSmJtVEdITzhMaTVqMHBi?=
 =?utf-8?B?MlZLKzNwcHZBQ1Y0QTV1aFpxYm1iRXp1c0NSbUZ6TVFHbHE0R1UySnZYb2Z3?=
 =?utf-8?B?ZVpacmF1MkgxZFMvY1owb3hTcmtrTHJQTzVJeVozOUI1MkxVWmhnbzQ4VkI0?=
 =?utf-8?B?QWZDUTNZeGZmWEY5Mmo1R1ZUckNSY1hHeTRYV3cwRFZoY1VsZHRwNExlZjNh?=
 =?utf-8?B?UUswczJWamhudDU1Q2ZTKzNpWEJtbW4xWTNnZnV5MjJyNmlBbEkzQW43NERn?=
 =?utf-8?B?V3Z3WXJ3UXplT0hsdEpPazBpZXdvb24yVzBKcy9yV0d5V04xSlB1STZ0TXIy?=
 =?utf-8?B?ckVvUW95cjYyRmtubWY2RFphbGluTVpCcjEwTURFdlVIS3hSUnZxWDB4Q0FR?=
 =?utf-8?B?R2NVT0FORFJHemNXY21sVC9pZWEydUVvTHhoTURVR00rdGo0b1NaQk9YRHlZ?=
 =?utf-8?B?RlhNbnVUUFIzc0JPVU9MU1BzQXVKdlExd3Y1NkpZZlBlRXJwQlFFc1RnbWZV?=
 =?utf-8?B?ZFVGbjIwR2lzaU1COWpOdVhDQVJBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45E89E95E8B52941A49E8715A171D0FF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Rpn4bJJY3lg+3z9xfoh1uVV81kYS1bMzPtTcOfQVxLBcK7I2kVbXmK22jjjRHfaXcQLS3uB8EKXWOoe7ZEQquow+Fp3YK+dfGvfxUj/YNactJns0sf9pR7+UPW6LI/tZxB7fVD2AqDdnwjyyode7Z0WtqJ51ZCel6bhwTzLJfXkf+rWTboHpfYgNhKbx39l4/FohVyYpVtK671Cp2ryjC0d7/jWPkrquO2ptZZ161sGM9r9rB3YcMmhHSNzHXfBw9Z8/w21va32IOcZx4z+97bgWmK4gv29F+l8okoNkFxgB5Ho+2l/AtE6ljQPmFMmDCrGfE7kAz+jafrkFNQcOmDa4blzGscUkEmlKMdBPkQEYzjV5VTG85YXZ6IXUK/Y3jEXoDZVKVi/mjHb25T1G+XzES3vG91GQEMaXR+DI5He6/e2FfeaKOgYEIiUn2RtYBbqECpQhEjYM2ZiURe3Z5QKgSqBlOB1/89jGqfS/rZg+vgoeW/q0HC/nnDNcgkXf3Ezqj/zJkh1QaWVp6VKKOfakJebCbqiF2IbXJ/uYrFm74h/n/x0UHQ2yfKaKaZS2/pp27ATkePLC8RvWR1UjF/ZhHWeAWfB75n5yxBcKoF681quEyOnAtL0dKgHEMd/7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d844aa4b-85d9-4981-d8d7-08dc218accb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 11:58:40.3155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: emAQh0v1yeAqIcrejqy2uSGMG6oTb7aYuD4BJU4XagG7iviwk2GS239TSkKKV8eCk+g9oYEapxlndCrxc0k+nyEzaXMNem1MOAKhyKjHHLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB7930

T24gMjkuMDEuMjQgMTk6MzQsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gQEAgLTE5MjksNyArMTky
OSw3IEBAIGludCBidHJlZV93cml0ZV9jYWNoZV9wYWdlcyhzdHJ1Y3QgYWRkcmVzc19zcGFjZSAq
bWFwcGluZywNCj4gICAJCQkJICAgc3RydWN0IHdyaXRlYmFja19jb250cm9sICp3YmMpDQo+ICAg
ew0KPiAgIAlzdHJ1Y3QgYnRyZnNfZWJfd3JpdGVfY29udGV4dCBjdHggPSB7IC53YmMgPSB3YmMg
fTsNCj4gLQlzdHJ1Y3QgYnRyZnNfZnNfaW5mbyAqZnNfaW5mbyA9IEJUUkZTX0kobWFwcGluZy0+
aG9zdCktPnJvb3QtPmZzX2luZm87DQo+ICsJc3RydWN0IGJ0cmZzX2ZzX2luZm8gKmZzX2luZm8g
PSBwYWdlX3RvX2ZzX2luZm8obWFwcGluZy0+aG9zdCk7DQoNClRoaXMgaXMgd3JvbmcsIHBhZ2Vf
dG9fZnNfaW5mbygpIGV4cGVjdHMgYSBzdHJ1Y3QgcGFnZSwgYnV0IA0KbWFwcGluZy0+aG9zdCBn
aXZlcyB5b3UgYSBzdHJ1Y3QgaW5vZGUuDQo=

