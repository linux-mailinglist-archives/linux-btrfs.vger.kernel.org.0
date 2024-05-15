Return-Path: <linux-btrfs+bounces-5007-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD28C69E3
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 17:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 174F0B2263E
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 May 2024 15:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2321B156221;
	Wed, 15 May 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kYNuSlvF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XatNonWe"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD6E155A4F
	for <linux-btrfs@vger.kernel.org>; Wed, 15 May 2024 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787814; cv=fail; b=N52LPmzIhu/0t7T2CBUBUziKxUoE/5rKsnRSm6ooKn5XgBJiUIYXY6fX4zwudbWMz3O15drvOCd9RK8YEWjyr3uFYZJaZJT76zjD7Glmrd9k0xhRmF+7OYU2ASyTwntPmkw6VbKQn+UIVgeYEyT966Oie1p/I8KhWgMYIH2xRkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787814; c=relaxed/simple;
	bh=lj6wPP9wpB6syqhyEbHLayQzOmJla0bOgoWz/qrj/NM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JgGCnO1HVLxxttL5YfvQSg1olRShPgDxyyLVz3IAtTQqh6JOu5hWTpWmCrvgA/7iiD7/eAzvy4KLwm+w97/9jXTdh0qWnRl5lSN2m0Di2SN6TD2jwOb3P9y9lxsumBBw61GIH1+PW/Z+//Rqydj6zZ8tdJI0LqlLb9aShUxT67s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=kYNuSlvF; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XatNonWe; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715787812; x=1747323812;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=lj6wPP9wpB6syqhyEbHLayQzOmJla0bOgoWz/qrj/NM=;
  b=kYNuSlvF0/NWqElWS3Qv6S33vEfGUd1a4NbjHrS1DZWFibupvymZROn9
   Y0ozs7ij2SnNPNSZKadS0D5GPDdkzHu6ncR7pTRTuSNxnU+4XpIz+3LVF
   WWnAooO/WciWWduG/6aPY/3woYzbZX7wuA6LcZ800xxmHQ6kAn/fSY9P+
   O/yc3do41XHocc91bNDl/Dmfubd6uKgxhCBivSPRbc+KbdfDvr+1yC2go
   Y9zANngIVvNGFXnGU7fpqfLdfwf3vaMyq4V89rsoKZs1kXq9HBlsextlS
   2AqyU3erbz0+yanrc0GfbW5NOKB0DeXSoC/+EdIjYOsSU56OG5dfbx5gP
   w==;
X-CSE-ConnectionGUID: ik4+ym46Szuntg8NWSDpKA==
X-CSE-MsgGUID: SRn9m0ACSU2bNK3DYb+ohw==
X-IronPort-AV: E=Sophos;i="6.08,162,1712592000"; 
   d="scan'208";a="16404909"
Received: from mail-eastus2azlp17013021.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([40.93.12.21])
  by ob1.hgst.iphmx.com with ESMTP; 15 May 2024 23:43:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMidu9f4GsS92qHdQmE+kZ6CyQfn6UfQNOlWZvUQbVulLu2skWouY2LKdxN5htKQHlpvpZV59eAr/hZFoA4sZAEQYrd7Q6GgNyJcQ3+BDLajERFXb+Foa5neBH345H24dQpSVxu4EMimzkmyknV0+Wzam+xxRe1HisJK48aWKj/lmG0fq7QhXuE8HkoVy+QYlHET5C7MvuEUJY4s1QNNbauo9msvHeOqFiZMvI9fDRLOU07ywyYK9w60Z/7Wmq89KzKJSUX4b9zUErzaKKGLQCgUVoiMUkX8+32bpn++OaP6vIKFdo6iHfVBKMiICENw2Bf7vIHEmxOxZ2rrHnKNPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lj6wPP9wpB6syqhyEbHLayQzOmJla0bOgoWz/qrj/NM=;
 b=TeWhIc1A1SS9FtHLkgeVKiCczwEXx2U1ruxW2Y3lKPklhHvr1iwFpIc2P4U2Dy/o/07+PE7zdshO0Oz2k/2L8WAuL3NCKAK3hTe29DXfnavdcYmwJ5DVcCX5moHcJIZJdqbt5Zfo45cc+TmQyFckFRupDluTodbzZXIK3imY1BnNm89iLzjSfYVydfWDnXVdK4bImlC6Cd9Tc9sgffcFS/NOzT+85ePwY06hHiIc/cpwpszDYu4AkPD73H8mjv/ogqXpxtrRaruPFkJtuXo+X1s6CFR4KMB6LMyxM91tdhOVbCF9dZCmW5mGkcerp3Pd9v5L1Dk/z4KBHmyaiPnHVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lj6wPP9wpB6syqhyEbHLayQzOmJla0bOgoWz/qrj/NM=;
 b=XatNonWehTfSb58hDTbk8jdURlnTiTZDdYo/MACJGf3n7esYUhhTsmtTxyidgVdm6u/p6HFZdkv4CJapsXCKYJ7R7U3sZefcLAOFyC2R/6rmmdudLbKMopTJ5dcl/z51nkJ7ad6decBmxfCT30zexWkD+1GVxO/ciKnuoLv3YlQ=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by IA0PR04MB8788.namprd04.prod.outlook.com (2603:10b6:208:490::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 15:43:21 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7dd0:5b70:1ece:6b57%3]) with mapi id 15.20.7587.025; Wed, 15 May 2024
 15:43:21 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 5/8] btrfs-progs: mkfs: check if byte_count is zone
 size aligned
Thread-Topic: [PATCH v2 5/8] btrfs-progs: mkfs: check if byte_count is zone
 size aligned
Thread-Index: AQHapiwEPrJsLtwKE0yFPmoynq7VOrGXV7EAgAEZKAA=
Date: Wed, 15 May 2024 15:43:20 +0000
Message-ID: <ot7cukowqpxzhz26nb63c3h7nrvjmy3goyvwxy6gkj7phpwpoq@umdwvlr5i2o4>
References: <20240514182227.1197664-1-naohiro.aota@wdc.com>
 <20240514182227.1197664-6-naohiro.aota@wdc.com>
 <da0c6bd4-b3bf-4d85-a9ff-5548f01734d0@gmx.com>
In-Reply-To: <da0c6bd4-b3bf-4d85-a9ff-5548f01734d0@gmx.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|IA0PR04MB8788:EE_
x-ms-office365-filtering-correlation-id: 8844b09b-2dc4-4657-230c-08dc74f5bfac
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?TEZkbHRBd0VLWFNqSE5lOHgxeVp6YUpDYlhXUGgwWTlMQnljclQvTS9GYTdG?=
 =?utf-8?B?NEVUT1lLd3FRdm5sWi9pcXJNSVJ4NU16cU9KaFV6V3Yyd0RxaWZCL2R0WlJG?=
 =?utf-8?B?N2hVdSt2eVNPQzBSRDY0TjdQZDRIRmVFbFpzM0NBNlhsbU5xdlNPMDJjT1Bo?=
 =?utf-8?B?YkgxR1FOSW80QVBsMEVQaEZ4NDBtTm1laGVJbDRESWtVOWtOT1hNZUJLdkRK?=
 =?utf-8?B?UVBiWnVEbUs2WmtZWFZPanYxZ1pMZHdxektjN2txWXp3UnRLWkNIeGpHbnFa?=
 =?utf-8?B?U3V4WkpQWTBMbzRwY2ZWbVdEbGJhbytDWnNjUWk4aXdxa0RRUUlKUGxuSldU?=
 =?utf-8?B?eEtNR1FxUTN4bDNoNmJxVFV6YlFxWGErelN0NmJoNHlBTlZPOGhyKzV3VzN1?=
 =?utf-8?B?WVJpTG1xdU1uTmF5dVdHellZS1FxYVZxTWFnaUFyWEdOcXd0ZFBoVG5jTnhQ?=
 =?utf-8?B?NlgxeUk0TFE2dFkxRTN0Vm5zai9zOExVMURxRys3d0M5VWF2YkZVZU43YTJ2?=
 =?utf-8?B?cWdzcHpMR2o2N1RTN3YrTjN6aFVJa3BjR3B5Ym4yZlhhYTdTUXZaaHBWaElx?=
 =?utf-8?B?Q0tKbEZPdEdQeVUwNktjeElwT3BSSFNWRFNxaUxlcHpFeUxBcExHRDg4VHFN?=
 =?utf-8?B?b0RhZFcyTlEyWTFkc1VZZC9pVFJUWWNsZElJUXFkWFFQb1dWb0YvZ1lZbWl5?=
 =?utf-8?B?NXk5VEF5VDFMVnN3ay81SmRCTXhETEI0NHFxdWljQjZ6bmRvR0k3eFVsbFhs?=
 =?utf-8?B?dWMxcUNtR3B6a1g0ei9uMk56U25tcFd1TmNqYVpXNi9xMkZxaklXRlBaU08v?=
 =?utf-8?B?S0M1dmo2TndrbVVPLzVCa1liTTVud24wcUdUenJFczZ4ZjhzMWU2VWh6Z1hU?=
 =?utf-8?B?ZzI1NW5GU3VFVk5NYzhlM3pUS015WFNQa1Q0emozS0hBT2pDblpPaXVpSXly?=
 =?utf-8?B?M3hRdll2RWNoZEhFK0Y1cXltRWM3bThON2FGMndVTTNuUmwyaGQ3Y3lCcjF0?=
 =?utf-8?B?Qm9DTTQ4TXZOM0lVc2FPWHlVSm4xS1FKMityVXZsVFJRQVNTYjIvOXVaclRY?=
 =?utf-8?B?Vk95aTJ1VjZiME1rNXB1RFk5VUdQS2IvWGRrNytFaW82RUJDSU1JMTAvZHY1?=
 =?utf-8?B?V1VmdU5kZTRKbkZsWU1ZMWlkb0ZaS0xhRnpiTk1weXcvUEF0TWVZbzdVbU15?=
 =?utf-8?B?NmdDRzRqTU9kL2dGZEZzVlhOUFNWWVhnalVOWG5ab21ybVc0dFcxeW9kdVph?=
 =?utf-8?B?dUJGb3A2cDVmczJhYkVCbVVNZHVUcHhRQTRHMlBBcGthT2hSSTBaaS80NU0y?=
 =?utf-8?B?L2xYdXpqN2d1ZGlEY3FhekdUMkdaMlh3Z044ZmcwaU5XRlllaFFLbS9UNFcr?=
 =?utf-8?B?M2Y0VzR4YlRVYlFTck5XVGdyRUVQQkh0K3FlTktvTWxwSlRZb3hxbU9CWVpN?=
 =?utf-8?B?czEwV1hqN0pjUXhIVnVUVU0yV29IWTVGaXcwUjNuSnF6dmZoR1JOaXVHNTh5?=
 =?utf-8?B?d1IxSkJ4empQU2tmVVJ1UTZwVDQrUCtyRVF0L2l6ZE5hVTJocEQ5QnNNWmxV?=
 =?utf-8?B?L1JPSU92eDR6dmdhYXV1djl3ZFlld0pPRnVrbERINHB4WWdRS0VYQzl2dFdC?=
 =?utf-8?B?NnpjR2xZOFZqNTBCTlV1N295dko1YytTNHBFVjhKN05KbmR6SW50QlpXSFlJ?=
 =?utf-8?B?cS9ySkNNMDdPL1J2N0FIL2FzdVdKM0dVd1ZmY2JDSm5wWGc2L2xmcmppR2ly?=
 =?utf-8?Q?d6XZ+N8v4WSVtdytCU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym1TMmtLTFRqUU1Fb2U0YTRJUnZoSmxOZGhobENyMm5QVTJUemZUQTEwZEhW?=
 =?utf-8?B?cXZuYlJVd2RPQ280MXNWb2hNY3dBUXp1azdPdnpVZzBoaTBIUEFIN1duL0lY?=
 =?utf-8?B?MHUrS05FbVI0TzA1aXBpOEdVOHV3OEJRQ1grZXdpTi80eW01SjViTXFMSk1l?=
 =?utf-8?B?cmJXY29jaTEvMEQyVU9LbUZwQUZRNE02aG13UEZYeDdIWWMxc2FYZmNsbFJP?=
 =?utf-8?B?bUR5aUlxaFdTeEl3Zk9PNXdadE1LalhHaUNzQS83UmxBcVFrTUNLVm00aWRh?=
 =?utf-8?B?Mm9sdk5OYVUrK0YwSGhUSkN3ZGpxN1BzR1huRnNDZ0ExMHloczl2V1l5bE91?=
 =?utf-8?B?RnhMaE9hOUt2U3Q5RkZESmw3UEJPbUVKSlhMMmJ2cUo2WUE3WmVsUkdBd2RW?=
 =?utf-8?B?cjJKZU85UGVIT3p3NDh6ZGRvL2ZRWnNRVnRVdE9XcFZUVlVjak11S3JvMklG?=
 =?utf-8?B?MUdGbGRwVUZTc0RrZzdwanZjTkFETUhkUDFMWE1BbUpaZW9sYW1FWmlFaFhN?=
 =?utf-8?B?YkZ5TGxoLzdLZ25DZHJITkZRSWltSVAzZThmSDFwK2diMHNjbVpiQkJOeVc1?=
 =?utf-8?B?L3VmUEpyQlZCTmhkSUR3SElMSTRjZUo2S0VpUUZzNmVFbmlNSEVvOFNXSkdQ?=
 =?utf-8?B?NlJra0txU2tvVVZQd0liS3lyT0JiSUdBVTlpV3VwUVpwWllVRFhVMlgrZzdR?=
 =?utf-8?B?SUg1Z0YrenRjTkpkaHlad3c1dWVLakNHbU4xWlpOaGJzajVxQU9PYjNDZmlq?=
 =?utf-8?B?alB2SFUyQ2NQTFF2TWgxYWNLTWxjamh4ek9FVUdselFKdWY1NkdXNUZRMng1?=
 =?utf-8?B?QVIzMjBaYXJLM1hHMHB0UGV4ckpscG5OVGZYbXpGRlBvYUUzNUIzRDZpcWVs?=
 =?utf-8?B?SU9xUG0zaGlBN2ptS3YzTUlQZ3ZEN283NGtWWnluaVpsWDljTWpMQm1KUGJk?=
 =?utf-8?B?NUN1OWpGamxkVStMOFVURkpqc2ZpcEVpd3kvd2w1eVZ5TjFiS3gwcE9EcThN?=
 =?utf-8?B?VnRLSnZybzlSS3Zyem5yTHdMT0dkYlQwUFVxei9qMjR1aUtnSHAvb05YUytM?=
 =?utf-8?B?T1hVREp0bm1HQytqV3B1MVcrbEhKN2ZKcldGZjUwQ3JWeFVKQ1hQUm1JSmR2?=
 =?utf-8?B?bHU1UXVtU3dQR2lvSnNXMWs2Z3VKZC9zRkRhL1E3T2JwMmg4dWpzWU8zMzM3?=
 =?utf-8?B?OTBraTM5dFNxNE54YTZDQ2F1dm41cm9wL0hQU2tEY1ViMkI4bzI1ZG4xNk1M?=
 =?utf-8?B?TkZsTlhPZFp2WUQ5dmdqcDhQeXZyNVQ2OTh4VGY3dnVRckJhajU5VnJjUFNk?=
 =?utf-8?B?aVo4TXIyU1gzb1pFeDFmZVhLYjJwbjlUSGI1UWc1aFlJWDVDaVA2ZUorU2pC?=
 =?utf-8?B?N1prcUZ4VWhMMnBRUG9PZitOTlhDdHUyczhaY2ZDR3FhNWE3YXF2d3orclEy?=
 =?utf-8?B?REdKUXNXd2d1QW54Q3lWT1lFSFRPTHFVZlpiWGNuY1JOc2t1dk9NZFFLcmRq?=
 =?utf-8?B?bkE4UGdSSFIrbGk4T3JlckhtbVBkblVJNk1SYnNUb2NTZFJUMVhEc2ZMeEhi?=
 =?utf-8?B?dkxMaEliMWl1bnpwRnJ2Tkd3bDA5MnVBcnRLT1d3V0FkejJyMXVuZk14ckQ5?=
 =?utf-8?B?aFdwZkdiWEp6ZnhkekVkaXVRV0pYTU5pS0I3RUY1TTdIdVpRZXhxSnMvcEps?=
 =?utf-8?B?OXU1R1NpZ2YxSXJ6RzZtOUdZNWNIbm1ZbXlZeXRyeENBbCs0MnZEZ2NVQmcv?=
 =?utf-8?B?alZMbzVhcmtLbjQwUU54RHVTVGcvM3hKaWM3MUhMUWtDRFNvUW9KdG1ORUVR?=
 =?utf-8?B?TmVQWDdlSUlDKzhvU3NGdnUrTFJYZ0cwWlVtSEtMaUVnd3A4S2ZmaDJEUy9M?=
 =?utf-8?B?QzdqT09lakduVVpaT1FqQXc3V25abXNSQ2N5OXIzbThINGpuSzdtNEZsQkIv?=
 =?utf-8?B?b25vb0tvSzNicjhLSUZRM2xBRmUvNXNydTJqN1RocC92a1V4SDFzSXcxSWxo?=
 =?utf-8?B?d2ZCejdSTlk3eGd5WnRNeUNwMTlJK1hlM1lzZWEvWWZrL2hPVmxrUEVBMUVp?=
 =?utf-8?B?WEs4ZUVhaStLU1dxTDFKa29QWndHTnFXMWdkSHA3c3NQYVRwSUlKekpTQjBu?=
 =?utf-8?Q?jgBCXDbOA3VmpRlBxWN2+faTT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <08A77627B2509A4687E85733F7E6C9F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KqRltX0aqek9GdHaSh452leb0eWNnZUrdjrfzADCiUb9PAtsN82P0stLjKllai5FAjDwudcSdRQ16PtpnIX0wYRhbwA/4zEEy5ST+5l/lutH26KvP7aoMZJkd1isArE1nKqP0P7Ox0qR1+ZOhzKLf0/vls7DQr+3OXbFtjx8ZYJ2XuWaYk0yPNKkU2NaJw48Ai+WLkuRgUBhQ7/FciZkZSwk7nbt0GzKkCQKhgb6k3HTVFTA8PXj6WmuF0kpupB/r+LMXbApiIfycmZz7DylN+3vGD9MWg8QrJsRzoX4Oxaevh5Gxyji2YSxJsREkPoNrtDR9oZ4YtoS5HcqBfcLOXu/Janv2YvyvtIJZiKEnHY9dIdopwNQVd85oYb/P95jU4oejJWMlDlTep/nEAXRY4AYnaArnb9JzoCSj+eZC+vc6/LAKJazf4ZmSddUhkHTfLahlJhROUw2K3ddLcYJI0PpPKTvpFIzfvSz4ZKo4KUHNw18+ws2GvHK/BqTPLrcDEtWpPao/h9T11WzDRG8jZN1QRMkiUqMA7JFZTImzEsQO08o1gWV8NOpmh1AtmIG3sVoz9Kj1Ot/RofBqK6SchfD5MYuTbPOl8zFRVLYxy4sgLPhga2o9ZyIW2FeXArh
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8844b09b-2dc4-4657-230c-08dc74f5bfac
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 15:43:21.1205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Onv2QWmgkZBwylAs04BPWcTuxqJ/aFQiNEknpzcid2rkbwIcHV08miz5mHcrak04gaMdVCuUZ7vZUG6JCT4Y4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8788

T24gV2VkLCBNYXkgMTUsIDIwMjQgYXQgMDg6MjY6NTZBTSArMDkzMCwgUXUgV2VucnVvIHdyb3Rl
Og0KPiANCj4gDQo+IOWcqCAyMDI0LzUvMTUgMDM6NTIsIE5hb2hpcm8gQW90YSDlhpnpgZM6DQo+
ID4gQ3JlYXRpbmcgYSBidHJmcyB3aG9zZSBzaXplIGlzIG5vdCBhbGlnbmVkIHRvIHRoZSB6b25l
IGJvdW5kYXJ5IGlzDQo+ID4gbWVhbmluZ2xlc3MgYW5kIGFsbG93aW5nIGl0IGNhbiBjb25mdXNl
IHVzZXJzLiBEaXNhbGxvdyBjcmVhdGluZyBpdC4NCj4gDQo+IENhbiB3ZSBqdXN0IHJvdW5kIGl0
IGRvd24gYW5kIGdpdmVzIGEgd2FybmluZz8NCj4gDQo+IEknbSBwcmV0dHkgc3VyZSBzb21lIHVz
ZXJzIGFyZSB1c2VkIHRvIGp1c3QgcGFzc2luZyBzb21lIG51bWJlcnMgbGlrZQ0KPiAxMDAwMDAw
IHRvICItYiIgb3B0aW9uLg0KDQpTdXJlLCB0aGF0IHdvdWxkIGJlIG5pY2UuDQoNCj4gDQo+IEFu
ZCBpdCBtYXkgYWxzbyBiZSBhIGdvb2QgaWRlYSB0byBkbyB0aGUgc2FtZSByb3VuZGRvd24gZm9y
IG5vbi16b25lZCBmcy4NCg0KU28sIHJvdW5kIGl0IHRvd2FyZHMgdGhlIHNlY3RvciBzaXplICg0
S0IpPyBJbiBmYWN0LCB3ZSBhbHJlYWR5IGRvIGl0IHdoZW4NCndlIGFkZCBhIGRldmljZSB0byB0
aGUgRlMuDQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9rZGF2ZS9idHJmcy1wcm9ncy9ibG9iL21hc3Rl
ci9ta2ZzL2NvbW1vbi5jI0w0MzENCmh0dHBzOi8vZ2l0aHViLmNvbS9rZGF2ZS9idHJmcy1wcm9n
cy9ibG9iL21hc3Rlci9jb21tb24vZGV2aWNlLXNjYW4uYyNMMTQ0DQoNClN0aWxsLCBpdCB3b3Vs
ZCBiZSBuaWNlIHRvIHJvdW5kIGl0IGZpcnN0IGFuZCBkbyB0aGUgc2l6ZSBjaGVja3MuIEknbGwN
CmltcGxlbWVudCBpdC4NCg0KPiANCj4gVGhhbmtzLA0KPiBRdQ0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE5hb2hpcm8gQW90YSA8bmFvaGlyby5hb3RhQHdkYy5jb20+DQo+ID4gLS0tDQo+ID4g
ICBta2ZzL21haW4uYyB8IDUgKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlv
bnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvbWtmcy9tYWluLmMgYi9ta2ZzL21haW4uYw0K
PiA+IGluZGV4IGE0MzdlY2M0MGM3Zi4uZmFmMzk3ODQ4Y2M0IDEwMDY0NA0KPiA+IC0tLSBhL21r
ZnMvbWFpbi5jDQo+ID4gKysrIGIvbWtmcy9tYWluLmMNCj4gPiBAQCAtMTY1NSw2ICsxNjU1LDEx
IEBAIGludCBCT1hfTUFJTihta2ZzKShpbnQgYXJnYywgY2hhciAqKmFyZ3YpDQo+ID4gICAJCSAg
ICAgIG9wdF96b25lZCA/ICJ6b25lZCBtb2RlICIgOiAiIiwgbWluX2Rldl9zaXplKTsNCj4gPiAg
IAkJZ290byBlcnJvcjsNCj4gPiAgIAl9DQo+ID4gKwlpZiAoYnl0ZV9jb3VudCAmJiBvcHRfem9u
ZWQgJiYgIUlTX0FMSUdORUQoYnl0ZV9jb3VudCwgem9uZV9zaXplKGZpbGUpKSkgew0KPiA+ICsJ
CWVycm9yKCJzaXplICVsbHUgaXMgbm90IGFsaWduZWQgdG8gem9uZSBzaXplICVsbHUiLCBieXRl
X2NvdW50LA0KPiA+ICsJCSAgICAgIHpvbmVfc2l6ZShmaWxlKSk7DQo+ID4gKwkJZ290byBlcnJv
cjsNCj4gPiArCX0NCj4gPiANCj4gPiAgIAlmb3IgKGkgPSBzYXZlZF9vcHRpbmQ7IGkgPCBzYXZl
ZF9vcHRpbmQgKyBkZXZpY2VfY291bnQ7IGkrKykgew0KPiA+ICAgCQljaGFyICpwYXRoOw==

