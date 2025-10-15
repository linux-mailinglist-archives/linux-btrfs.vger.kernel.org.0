Return-Path: <linux-btrfs+bounces-17826-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF0BDD8AA
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 10:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D23DE188C205
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Oct 2025 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB47317701;
	Wed, 15 Oct 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="h9jGcrKH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="JsUfoRCy"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057012D8DDF
	for <linux-btrfs@vger.kernel.org>; Wed, 15 Oct 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518405; cv=fail; b=DFwW6CNy9mHx+OLg9Z31YesSVC7C7VQSuHE/GQUUQMNjSNRueVRxtT1Wxkslz1sDtJIPFmmFIIl/B88PxIVVu/CKLVtkH/3ItiWVaCcP2M5GOMEH3K6/2ApRMN+sZd4S1YbHGFUNbVGO6beYNUPEfiKyU00Zda6Rs3acgXwvTFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518405; c=relaxed/simple;
	bh=9S34H7Cr1bNBb95ztEcaHQxnvrR0TgRWue4UDH+iZFQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IyFiHjG+vk04AP4rSiWxHt7r1X4kZWFzCgHaS6BJkkEKCHo1XKCD/OAyykgBoahp9Mso+wctGTweB/kuXPQZQgAorS9hro8JxpphWBU8bO8Oa6etFCZnpGJSLUs9UDqEvPb5ttwbkXzOsHi99+56K8guqBsGE6PBvePTNHg1xNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=h9jGcrKH; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=JsUfoRCy; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760518403; x=1792054403;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=9S34H7Cr1bNBb95ztEcaHQxnvrR0TgRWue4UDH+iZFQ=;
  b=h9jGcrKHdR6hZ1jgXrQK+y+apbZfTxHqZrsFmxI+REOig+azKioVp0Un
   ydJayRftmW3ZWTRytDFdZIOF27dHDNsaGRZPEFHimBJpB1+3pCR0lmbsG
   YWa8cHIer5a+B/+qd/7uK4EGMctPckKOidO52Ky95IOOw1buWel6QShJY
   gAZq6TJtDCDKKkMHbc3er/QcO+GoeT39A9cj6atu9oLck+ZMYKkJ5DCR8
   rCa4NN+LDjT08cAdJTB8XiKKjGKZfNoVzWzeKtfX46h5/d44eJ2cvICcP
   jSSIRR+bWpmM72qCds9UVxl192vwV2W2nu7TYn8INkLpqnXSv42eLTDse
   Q==;
X-CSE-ConnectionGUID: OlUeuqU3S5yt9WUQkk5FHA==
X-CSE-MsgGUID: YuUC8V9JTzyNc6PfEH5lag==
X-IronPort-AV: E=Sophos;i="6.19,230,1754928000"; 
   d="scan'208";a="132930406"
Received: from mail-northcentralusazon11010047.outbound.protection.outlook.com (HELO CH1PR05CU001.outbound.protection.outlook.com) ([52.101.193.47])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2025 16:53:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecuylEJHJOQGXxGC90/qVbuoTDM4INQJRL4nzmpZoNACvFBhBen0BIXHDrhJLh9VoVWYZ1vaKFPM/0fxhv64g1CqrusS+Q9hv7+X4D4smaFdbDmzDuJ16fqFWSI9Wpgkf/sqWpplJqRENgX1J8hKoyXfiQUSF0bIGLwjtqReRU3M2Hz5/pSNO1b2B5/2Jm4sqM4Zw4rPZCeY8hfQZr3LvUuVKK19SPNY0W+vQK6f0X53pq3JWzU4YK9MgQ4QUYkaiETpHukeN1vuvepJMEKOUZkC9fFnOJThIAuSzKENzOKZFDGVBAKWmz8DmzStkP9Qcb6ODyYbrvohP3UPTsKO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9S34H7Cr1bNBb95ztEcaHQxnvrR0TgRWue4UDH+iZFQ=;
 b=lfwCCsoreT0dJ5pZrjORPvK68bwyhWCM80cOJ9K/w+fGmC9a/OGb2haRA5/XBV1+rlYtyAmRF+RHMu2psYcPip8mXoO6lStAn4yFrjXpRzo24U5a4R/C1fgRoszlVAyB4uPy4/WX1t0hxB1dYhZJu+3nYjgLYP/NLseKPNVa1vOx6v2itJN293GyyVFWZGD+tuLwqFf03oSHq7bFuUolQykmpOlggoTcBOZ1YDgk6EJFAoRf3FfhezBZKp07MlAH8waelOR6e6rZ+bgbLzpr1ci+yUgvD8D2ZCBB6LB4VCGuuYF/RkYVvxNpXyfI+KhDiDf8HAcnjKdYRLIz7WMjYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9S34H7Cr1bNBb95ztEcaHQxnvrR0TgRWue4UDH+iZFQ=;
 b=JsUfoRCyb7phbFOLnsTS+MjRrVE+QDOAYHcGXaGAwia1hD8aCy0FF6v6ehEkLPkNAmIUmvO0dJ1WgiXf+KNcbAsH0yE/3ns3nc3ajB1hTTiDQqGbWqdWVMoa5hUSxeNw3yGxOhuFJMxRg9Xnk8586GlMfSkb8cL6HflWSmNJS2c=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA3PR04MB8953.namprd04.prod.outlook.com (2603:10b6:806:397::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 08:53:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 08:53:21 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "fdmanana@kernel.org" <fdmanana@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: remove fs_info argument from
 btrfs_zoned_activate_one_bg()
Thread-Topic: [PATCH] btrfs: remove fs_info argument from
 btrfs_zoned_activate_one_bg()
Thread-Index: AQHcPTgytfnmONEmZE2uG7sNw+YzZLTC598A
Date: Wed, 15 Oct 2025 08:53:21 +0000
Message-ID: <79eb5a36-1614-44bc-9bdc-7de238969507@wdc.com>
References:
 <fad79c0ae3452237308c7de09c6d96a524ca4857.1760466409.git.fdmanana@suse.com>
In-Reply-To:
 <fad79c0ae3452237308c7de09c6d96a524ca4857.1760466409.git.fdmanana@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA3PR04MB8953:EE_
x-ms-office365-filtering-correlation-id: df49764c-0f21-4c77-9332-08de0bc84b19
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|19092799006|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UnczbWhEcVRSUUI2SHVpUzJQdi9OOXB3ZzlqL0I3MC9HWTdCMDFjRFcvWUd6?=
 =?utf-8?B?WGtJWTI5cVAwSkFYN0hweWRmb1JDeTg3aTZWQzVaVWdWNmpZTFQxWnJqZnFx?=
 =?utf-8?B?OGtKTlNLS0Q1T1p3Z3FBTmVRd3hoYTJaaHB2dUZZc0VzM0Y1bzkyY0tQelNt?=
 =?utf-8?B?S3lCamMzRllxek1ZZ09oVm5hTnhma1dvZkVQRVB1Tzc5dU0xSHpNVEdBMU1i?=
 =?utf-8?B?SEsrU3pVaXZOZVZHZ0xOTUJ0aG1IMHhYQnBoeHIxN29uRzhPb2ptK0JVejc2?=
 =?utf-8?B?ZjZsY2lDZWxhRnkyVVIxcURzK3NId05QMkVDamNza3B3NjBHTFRXZk5sTU9h?=
 =?utf-8?B?QWlHTm41T2FlOU16QVhzSUp6cFBNUDlPL0REOEhaTnNBSlJ4bHlPSjJCWjNG?=
 =?utf-8?B?aW9xTnRVVWE4Mm5KTG5IUGhlY0Fnam54cUpCeWY0Sk55WGEycXRINHVJRGRw?=
 =?utf-8?B?b3gzQlpuQ1k2Y0V4S2duOXM3aXdYL3duakNKZkhndVA2akx1OFBHNmkyRm5C?=
 =?utf-8?B?bXQ1cWtXa01BT0NjMzFESTFpQ0dmalBDM05KbUU4ZmFVdG9MZDU4NDcyRlNy?=
 =?utf-8?B?cmtXUWpsb3h0eUJrM1l2Y3FDRXZmMys0Tng1R0hsYy9zTFBsQUl1ZFY4d1Rx?=
 =?utf-8?B?R2V1VmJKVDFacU45cS9wM2RESmkxdkJhTFZzRXV1YmlSYnVlK0JuUkZVa2cy?=
 =?utf-8?B?ZVZoaWNSVktpR0dmWWdUT1dmUmZPdjUwYld3UXNhV0s4djE0YzFCTWl1OTBl?=
 =?utf-8?B?SW5IRUVNMkJDTGVCK3VwU3RCbDZGeVdoQXRYbSs2ZnFPRkNBSkJEQzcvVWZR?=
 =?utf-8?B?eXVOVXEyNGVEZ3VvOFYvNG4yTEszM2Y5TjhpblVwTHdQRElySXJzaTlidUtT?=
 =?utf-8?B?ejJiZTZ4U05aY3F2eHQwbURpZXRsRkNEckNDNkgyZWljbTNtS3pYQlJiTUJz?=
 =?utf-8?B?bklPc0RWamtPSmdXeUxaQTVKS0hlMUIyZ0lnN0t4bHRPcVpMNzJpNXBwQWJ2?=
 =?utf-8?B?MTZEaVRvOTJFVElOcklHb2QrbFphdit6VE85Y2RSQ3A2V3JqYjBDNExScVBw?=
 =?utf-8?B?QTRhRzhQTXBvY0w1RkpwVVU2L3R1L2FnZVNpOFhwWkJMR1pxRU5tcFlSMlU2?=
 =?utf-8?B?VmFqL2I1anl4VTZoTlZKNGFsb0VKRk94ckhKN3BRaXc2VDQxOXdibDNTTHhD?=
 =?utf-8?B?U29xcEdNbEdKL2h1ckN5cTUwVk51WDJBSjlJSTFjTmh1OHlNZ2RDeUpVdlJS?=
 =?utf-8?B?d3hBWVVwaHRMVlJLY2tjcEZpeG5lS091UUdUUlZhSHRCbnNIN1ltRk5QcVdL?=
 =?utf-8?B?YVJCek0xdW56SkFjSHgvYWZzdkNjNzFqa080a3piRUVLNnQ4SFlYMU5pR1pI?=
 =?utf-8?B?TTNZZ29QWXVhSGhzc2ZJRnBCK3I3WFBham1DN093RWwxMzVndEo5YUhUZzVH?=
 =?utf-8?B?czIwSmtDRVhxbU1tNm83WkRwZWZhbVd2Qm9oUlBNSDgrQ1NDZDBmSjN1QkRE?=
 =?utf-8?B?K3FmazRVQVRHSTR3THNIbmxkdkdGOVEwMjdGNWxNVVZUR1ZpeDBmeVhTbHh4?=
 =?utf-8?B?NWtIS3Zrckp5cXdVMEJvMk5pR2VLS3Nlc3hXR04wT3F1b0k4V3plZnhDRTR1?=
 =?utf-8?B?eEZqbWl4T0I5V0lNcTJ1elp1VzZoQUJBSTUxOGFFTU5xUjd2ZW13QmdXRXlo?=
 =?utf-8?B?VFNmb1B0YWozNE0xcjJlK0Nrdkw0WnZ3QmMrQkt4MXB6UFBWNXRsSVF2dTIv?=
 =?utf-8?B?Qi91Z1Z4ckI5N1hWYUFicVlUNkRTRDNjcS9RekM4TTRYS1ZEYnZIa2toQXNP?=
 =?utf-8?B?R2FUVDBTbXRDZlNhNHhJTUVKQWxUcURURlplbzR6V3RRcVpnbElBRFBYc1JF?=
 =?utf-8?B?K08zUFZqWjk4SHZlK1BlRGxXaFYwd0VVY0F3aWw1T3krUjRPYlQxUmp2eStU?=
 =?utf-8?B?a2pzUVpnZlI5NkRNZU0wbU1EbzJaT2ZrNVJnTmxkMTVsWDh3RDQrWlMvN2Jl?=
 =?utf-8?B?MUUwNVpHMDJDUnMxeFpxd3FZb3c3bndNSU5MdmlNMUhWYnFWL21HV3lIT0pU?=
 =?utf-8?Q?pnDBCs?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(19092799006)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YjZQWDFzRE9wRTE3TkJaU0VLSkkvT3NLeHkzYXowUlVnc1hJWjJYOTRzTW9t?=
 =?utf-8?B?TXVUVlA1NjJVK0pFSG1oeEptR1FZbW1uR2g0b1B3b3drSldUUkYrREtwUFVP?=
 =?utf-8?B?VlQ1RTVPdDloWEhBc2d3MVlUZFZTdVVUcmVocmR4SW5EcTRWbnorT3EzeC9Z?=
 =?utf-8?B?VVkvdlFsOEVZR2tkK1h3U3VJZnQwbEtNbldEa3ZNVTZ0Q0xRQUhnVVI1ZkRr?=
 =?utf-8?B?dnZuSmtKRkorLzdOMThUUjFsald3U3JVcG1wTmtzeHlvNzA1SUlkWlE0eGpI?=
 =?utf-8?B?am9lVFNjTkthL0JHbFNFMlBqOUdoSThZa21ITVAwRlVZWEw2L1l0OEtET3g2?=
 =?utf-8?B?VG1MN28yYzNwYjNmeVVWVmtLTmZLdlVQdU5IZUN6TnQ1RnhMR1RZekZGQjU1?=
 =?utf-8?B?UE5NU2ZWUzdMcEZkamtqOS9sd1cxWjI1SGpUSC9mYnEyYXVtZUp5NmlhSEdD?=
 =?utf-8?B?TXZWR0lXeTgxakRUOTFPZkN4Ty9XL1liUUpENDVINzVBWWV0RFBJZTZxZTZx?=
 =?utf-8?B?Rlg1WjFGRHQ2aUU0anY2U2FyQVAvclpzOHdvdGExQ2JBbmh6NktYOWR6ZUpt?=
 =?utf-8?B?OGlzY2w1c2NxYzU2OWhEWERvdi81cGR6VDdJbUpoV3hmQjA3TTEwbDdxWjlK?=
 =?utf-8?B?RjhKMVFYdzQ5MUs0Y1lCcXpQTFVZOFBOR2Y2MDRQMU1oajVrdDIxMkRoSXRv?=
 =?utf-8?B?VUtPaXVFcy9uU3E2eTN5ZVFyZlo0VDZXdzhpT21YcjFmQmdrZGR5eHU0NEIz?=
 =?utf-8?B?TEh3K0dtWDdhUTVYMnFVNjR4eCttcmpxanJ2aC9paW44RkZ1U1hhMitkbTFL?=
 =?utf-8?B?ZCt4bXhtYkljKytBeDJ5cW4vSkJnQU9UZmgrVHptWlRva2FkcHp4cXBrdWVV?=
 =?utf-8?B?Z3JaNW9oeUg5T3BqNlJEQUpTK3haQ1k1Tk5KMFozcUZzYXhCdDY4MzR1RHJu?=
 =?utf-8?B?ZzBPNVh1L25PcnZiZVBRTWpDV3VuVkQ1TGMzR3BRSGF6R3BHUkpRUi9nVTFF?=
 =?utf-8?B?Z3lzRGZ1MmF6c21od1FQMWhQaCt1Q2NFTUlNTVlhNTdMWkN6cmVhUEJ3ZVVx?=
 =?utf-8?B?cWFobUFBMHo4dEJhUHNZTjRYbmFRY1RVeTVTenhkNkQ0WjRXU0dkd3JUemJO?=
 =?utf-8?B?Vk9tOWU0ZGJUNVlTQkVjRjFGMkFLTFZ5YWFHSVhwa2tlODZXdU4wN0RzMjdt?=
 =?utf-8?B?Z1BSTzNUU3R2UE1FUHhlNStvbVhhWEg4anF0d1VHVmRNOG9RVjIxNUZEZ01V?=
 =?utf-8?B?M0NURm1TdlNvQS9qejdVdTJuZmc2UlNsL1FXcVgrNlptMnF5dGhUSXZ0bUNZ?=
 =?utf-8?B?ZURSU05USG9NZVg3emxPSnlTNG1ZNXBVS3ZxOVhSc0NIblIvdDMyZmN2NlBT?=
 =?utf-8?B?SFZ0OWNBSk9idVlLbmdVV3d2ejI1MFlLVEs2NXZ5WjN6Z1VEekJ4aFRHbFgy?=
 =?utf-8?B?cTBXaGJIOXJKVWtFTnlZUlFWYlc4MXcycnQwR1RuSFZNakJzcytCemdpNFFF?=
 =?utf-8?B?ZkdMOGVHdy9IRUN3WlEwRHFxUGZUczh5OFVuWGpSaFVXZXQ5eXduZE1XZHB6?=
 =?utf-8?B?d2I0K2YvWGJwRUo4ajM4alNzdEtzL3A3ajV0TFRJS0ppYUtLQjN1VkxOY2g0?=
 =?utf-8?B?eWd4d292Z2VZcU1ONnNCQ1MwMkVpZFNnTFkxS05jaXZyNHFhK2ZLTmRQUVZz?=
 =?utf-8?B?QVNncTZ1VXNjeS9PMHdpR2ZrekFlcTNxRlY4aExiK0dxaEV4Vy9wZW8waC9q?=
 =?utf-8?B?ZUNUK25FSFFkRy9xZGZmU1FSNHVROHR1UDVhREtoYnk2Q2dpTE8yaFlFQ3Nt?=
 =?utf-8?B?UWZjSnh6OXVyb0dhNUJvUEdBVldmYVdOcE51YXlKQ2QyOXp1aUlvbWlXZi81?=
 =?utf-8?B?MFY1T3QrMEtrWm1zOThoTzE5dWFQSHY1djFrNG9qNmxjS1FYM2FFY25Kc0xU?=
 =?utf-8?B?U1o2UkwvTVdIQnFMOEtTSEhsdUxUTm5tZnplK0tVbDh4NXJya0dRay82eVZa?=
 =?utf-8?B?SnNMdTBmM2ZKNGVnWEZMWDNyVHpqNWU0cTJmR0pXYVpBT0tRQkZjOXdSNzFk?=
 =?utf-8?B?V3kyT1h0eWtDWndTS2R6RzNhOVN6YmdERExRbUZtQko3Qk9BRGhYaHBYcDMy?=
 =?utf-8?B?ZThSMGorUndOMkV5ZFcxaGNGcmIrOGVWc0I4Z2RsZ1VreUpLVi9INUc3dWtK?=
 =?utf-8?B?ZDZFZUE3VGtwM013Y0J0eVBOcE5yVUxrSGdBSUVPWjU4Mzl0REZ5UHE0SW51?=
 =?utf-8?B?T1AwUTNldkMzbjQrS3crcm90L2pBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE63B6B6A6CD8740952E9736BE47718D@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YLZNd8uWUQHoPn/shYDhBHiyc3KNgvFD89j3ULKWtfOwuce6AUWW1Vdqwxpo1ogOl3r4HzP2+bzH/kiQ3f/hOV6ye+HSQ3t+fqaEcfKxZUMpIk0OTKYHR7tqujW6mkTXf6FruNyvgxZAo/dpXQTCLVyDc9jYROpWgZoHpFiyO91RLlHo2YbnIe0M2Pfamu3LDwHDqw1flb7CDG2Vm6IkaSP+bAR392GMONtrZbE+7JJpeA7JClBCliFS3xs7CaGWQQ8rATfEv1qFArH2hW5zuQOzspqiAXZ/yaH2BkNkPOwqP/bOzAUnJYaCeeLp2gdQilY+BfezKImOeQfrfxmqojHdGvDhCyzMVLDcWYSfqbrdacFHBT1V/909qd+mGBP6ETE95IDH43epEBhGnfxGu7E53DiYtJKG2oe4je+Y2OeMOu0UnUZv7jpSSZsY1UUY1HYlodXlChiNvPQc5wEff0chVFsRd8Bbe9tgdWyHOvdB6+85MPNkkHgLttvgvSjkYC5D39cCe9aJVHW4XUSY1MUBUuhCnAZwMbYMMDuAmTvjma5QH/9aieu8u2d30+UqGISrstgKWqk59RwzGixc0faUsbXCOvAzoP7buVPApukGvtxrcLzINt5xZ7T2U4Jc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df49764c-0f21-4c77-9332-08de0bc84b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 08:53:21.3972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgVgEI9JEUlK9lD94U+0RNsku+bMImql5nX4c9nXKpayLWacFfVT2DtFQxBDPHaZTJLtW7cigpX8KA14Ll798DIu7SmPplbyJ0o9/WybYZs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR04MB8953

T24gMTAvMTQvMjUgODoyNyBQTSwgZmRtYW5hbmFAa2VybmVsLm9yZyB3cm90ZToNCj4gRnJvbTog
RmlsaXBlIE1hbmFuYSA8ZmRtYW5hbmFAc3VzZS5jb20+DQo+DQo+IFdlIGRvbid0IG5lZWQgaXQg
c2luY2Ugd2UgY2FuIGdyYWIgZnNfaW5mbyBmcm9tIHRoZSBnaXZlbiBzcGFjZV9pbmZvLg0KPiBT
byByZW1vdmUgdGhlIGZzX2luZm8gYXJndW1lbnQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEZpbGlw
ZSBNYW5hbmEgPGZkbWFuYW5hQHN1c2UuY29tPg0KDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1
bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0KDQpPbmUgbml0IGJlbG93Og0K
DQo+ICAgDQo+IC1pbnQgYnRyZnNfem9uZWRfYWN0aXZhdGVfb25lX2JnKHN0cnVjdCBidHJmc19m
c19pbmZvICpmc19pbmZvLA0KPiAtCQkJCXN0cnVjdCBidHJmc19zcGFjZV9pbmZvICpzcGFjZV9p
bmZvLA0KPiAraW50IGJ0cmZzX3pvbmVkX2FjdGl2YXRlX29uZV9iZyhzdHJ1Y3QgYnRyZnNfc3Bh
Y2VfaW5mbyAqc3BhY2VfaW5mbywNCj4gICAJCQkJYm9vbCBkb19maW5pc2gpDQoNCk5pdDogTm93
IGRvX2ZpbmlzaCBwZXJmZWN0bHkgZml0cyBvbiB0aGUgbGluZSBiZWZvcmUNCg0KDQoNCg==

