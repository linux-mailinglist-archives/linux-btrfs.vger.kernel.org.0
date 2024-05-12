Return-Path: <linux-btrfs+bounces-4922-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE33F8C37BC
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 19:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EECE01C20B1C
	for <lists+linux-btrfs@lfdr.de>; Sun, 12 May 2024 17:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E395B4BAA6;
	Sun, 12 May 2024 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bkUwnS6w";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VEF+I4qA"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAAE36122
	for <linux-btrfs@vger.kernel.org>; Sun, 12 May 2024 17:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715534089; cv=fail; b=RMCv58le9EOOX+CGu4Xux65qv/W9kQbaVFjdx5YQ0nsR6dzpHGp5S5t3iw1KOikCtqERoVbue5VHAJLyWbYiLfbwO39d0Mr/LcjdK8mXhBRErqDbDkDMV/+XBPj34IUdMJM4qXZJr1ukW+PRBLw9o16tzyndn9Pb/McIeCaggFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715534089; c=relaxed/simple;
	bh=iikTAY62iqIvB/3eRP4jDFRJhaedq8xjkZEyT325pvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUjzuIeZRgARP74tCr0eBqwQ9P+9KCy6oybFg7/l+1YvsWS+5muglWUuQ23bQ1tFiHBEnJkvjoj9PWnbe1+n/4mpkLD83AP0r47U28FMSmNnHbyZ5WX/7KnC68gn78PPG5FOEX+ClWDfJKSDUJo4lLcL+hpwQEnvAT9pCq1/i6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=bkUwnS6w; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VEF+I4qA; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1715534087; x=1747070087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iikTAY62iqIvB/3eRP4jDFRJhaedq8xjkZEyT325pvg=;
  b=bkUwnS6wiWNJm4jdGvKzd7vi+/s/JqW7CCQ7qiNHJY/Lbp1NFtSTNDm9
   uoIprgk/a3XUTltZySibAgyUVORF0QqPrq5qT/7FianK7caV2uubFBr1l
   fcaQMiFZm0UKqMT+G1dQEY7PdF6pbyaRcSA3sg73wWQWiVwHDbLSv5XIm
   stzKKz76BIWQLDv9VE5va/ljdrdLhG6Hc32s1cy7ZylElOAPZRglEW+Xx
   BzQHmyPVKuDYyOr6qoY7snPmtWaLec1196WPJ2/yEUahJ8HOWlPTV6CJq
   K7K3brI9wc6PurbdBIK8Q7TqR36QF6eM+xBsBQ94K+NdFxh4xP9+Lc7mO
   Q==;
X-CSE-ConnectionGUID: YUkfloY9S3iSJY3N+azkAQ==
X-CSE-MsgGUID: p4HYfDDKQFqtBWAoHh/pNw==
X-IronPort-AV: E=Sophos;i="6.08,156,1712592000"; 
   d="scan'208";a="16137641"
Received: from mail-sn1nam02lp2040.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.40])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2024 01:14:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSfFr0nQouTAkZznGGCkWh1iVsVDWfB0cavEguB1ooGVJK049YiiswUYSKwb8Zqdt4cUwaaCLrXpeyODCGonHKaoR9Oltz37Er/j5blMlqmhCD5V5qERmXJ6XScCuMRk1sPw2CDQiuj9usQ/u9Nx44CQ2oWJ+Yj18jqOq463Hh7tecxe/MbG11OoRtKiVmp5IzpuX/Sk+8Une5+FSqEOitRvyst9oWL+oMvFRqEs86kfMiHxTsOy1ZZL2wJPiSOq32T89fWt7AeZ9Y1Z49lTMUyCRTtrxucqTUCKQ1EF/cHbi6NsxKmcvh0Tyb4Pfgt9P1AQRXdpRyexyrtz+bFLGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iikTAY62iqIvB/3eRP4jDFRJhaedq8xjkZEyT325pvg=;
 b=MuHmOlJlqq2lWt/m3+F0FT/px2lIWyqiBiDQrh2FwbSWAx7qSWRUAhtBiGz31buK8gq6IwAjjWPCZqBxkzZtDuBykaNgVb1YNG0sG0u6NDr6H9LWCjOtGwwGo7IVh9uMmV6pLLdHMx+Reu7csCflTnmo1XNSyn2R11u3Bj74S+cCGHkHaLnBaW7DeKsRatperdv0D2Ej59qOGzD52iZG8R4RhaayXi9jaUSzBePyZDK+FP0fRGjtya5l8Akc+kt7Oj/2onBH0HuyyrlHxoKeHm4GWR/z3+aVFjRdMH6AOLZ3om9znaqaOb0to0hNW8dns5mu1pLPGX+6xlASB0mMUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iikTAY62iqIvB/3eRP4jDFRJhaedq8xjkZEyT325pvg=;
 b=VEF+I4qAmKq9gpRGV1FkcRr5reUDfmswldCPhv60Q7Pu2Ws5kIh8kx1mzPSzwbe0wpxOgW9TK9/oCdtMNOPYcdCYSsTplOCuZtX+HLGIQhs+yZtxMLLh2Q8n4weDce+k+nKajiHsLqKCyiS/Q/Od1z/DnPzY+IGhfzvXVemeTP0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ2PR04MB8897.namprd04.prod.outlook.com (2603:10b6:a03:547::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 17:14:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 17:14:44 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH v4 4/6] btrfs: migrate writepage_delalloc() to use subpage
 helpers
Thread-Topic: [PATCH v4 4/6] btrfs: migrate writepage_delalloc() to use
 subpage helpers
Thread-Index: AQHaozhgO13REBoYHE26HfBlX/cm9LGT2VKA
Date: Sun, 12 May 2024 17:14:44 +0000
Message-ID: <367755e7-a791-4d02-a037-d0c583ec8a3b@wdc.com>
References: <cover.1715386434.git.wqu@suse.com>
 <5b2f0242b7084194f4481739dac4bf9270f8f25a.1715386434.git.wqu@suse.com>
In-Reply-To:
 <5b2f0242b7084194f4481739dac4bf9270f8f25a.1715386434.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ2PR04MB8897:EE_
x-ms-office365-filtering-correlation-id: 35782b81-dc55-43b9-645d-08dc72a70498
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?N0J5WkloWmkzNk9MU3dHbGo3cGJxM0g3TWpUb1IyZ1V5K0hod0MrYlBzaUNU?=
 =?utf-8?B?dUU4ZzJSN3B2aWVtdmFZRHNUODVTU0txaWVMYU9pZDZSSHhQbVhrK0VZVDVX?=
 =?utf-8?B?cWZ3emV6ajEramo5eEs2dzcwWm04WVBCVkRkRW1NbUxYYzl1cUVqRVVScXgx?=
 =?utf-8?B?MFBSMEZvWkFIdDhYdCttYVp3WDVzUW5mY1ZJK0hiQlFqYUxiUkJCS3oydXlD?=
 =?utf-8?B?elRpd0hTeGtFb0ZxU1JBcGExZlZQNitNbi8zUk5NcHcyMnFnVDlvVDZIcFJs?=
 =?utf-8?B?bFhYTTZJU1orTnBNRUJJRFkxQXQzYy9zS1RPZjF0a1IvSC9RSDhRWGZPZlRP?=
 =?utf-8?B?UHJKOTFFWlJQS0d0ZVBOWHRQd1FrQlZoaWFIL1U5Ry9aTkxuWEcvVUY2SUVS?=
 =?utf-8?B?cDJQYVpmcmMyRnh5dVAvYzJLeWJyaHNhc1VPcnB6bXZvek5CN3o5eFRVc1pO?=
 =?utf-8?B?cDJQY3RVWkxGRkloNzJLRisxcHhobElpWXNaWTBmQ2NsS2JhVzNHaUtkMFB2?=
 =?utf-8?B?M1NtdGdBZG40YisxdHNtWS95dFFwWHFFRHViQ1l1RWVOanRoR2FzcUxMd1Nl?=
 =?utf-8?B?UzFyeStTSGFDODhFNnM0VUFYeENpZG5NU2FkalVXOFZrL0JaZ2NXd25TZ0hr?=
 =?utf-8?B?eVF1MVhJYzlXVVVxWWt6a3Z6R2VVVjBWQkpEbGIxNmFwa1BYeVBnNHl0ZUxO?=
 =?utf-8?B?dUM0SmxDUStJQkRmM3JyVFVIVE9nZGxGVE9SUkdCcHFaTnFTTFJPUEg1REll?=
 =?utf-8?B?MUxzeFhsdlZZTHJWaHpoR1NwREpoOXo3TEJ2WFp6WFhVWG9iZ25maVJhQU9r?=
 =?utf-8?B?ZzJsb1ZHK3FLZ0hOdWlxait4TlZVTU5sOUREbzRVdnhqdGF5Y2xSSkM5cHFI?=
 =?utf-8?B?M1gzTStBZWF6ejd2WGVwZ3lnTmYwRXpLd0ZmSnJJNmZWNjAxTmN2aDBBandw?=
 =?utf-8?B?d2VQc1BwYi9FdEo0RW52OENxOEdUckIrbGxXejNTZlR5ODJIZzFodFpYOTR4?=
 =?utf-8?B?Z2E2RWg4LzdvT25qeDhWKzNrYkVyNmdQT1VYY3c2bVMxSVMwQXplVjZJVzdK?=
 =?utf-8?B?blB2S2VIWVB6aktVdkJlaG45em5NclAxenZWalY3UXU5eWZTcHFGWS9Wd2Y5?=
 =?utf-8?B?NTM0aGx4R2tyc2RoOTFzTDJuNnFyR0p0VUFCcW5hd09YdTFidno4QXVBVWtL?=
 =?utf-8?B?eHJMOG5iN0J6cEJVSTE2dzlncy91QWNqbW1BN3dhM3hGRlJqSE5KT1JXVzds?=
 =?utf-8?B?R0xueWJzdzgrdzNpNUpzYTJOV1ZaeXZBZE1SdHJ6SHlISmdFMExjZWk1S0VT?=
 =?utf-8?B?cGtuUW9zdzUxeVNuMy9BbXJteDdDUXNIeFVRU2pnYVNtNmIyNXRYUzZnYXRp?=
 =?utf-8?B?aG9NWEs2TmdzOGd2Tk9sVmRmKzBzck0vR2Z4eVhUQ0dMaWF3UTVZWHVZV3Zi?=
 =?utf-8?B?SFVic0hYU2hJcHNkY2xuWlUvdllyL3hLUzRQTCtBVnJhN05yS2lmK1NEZSt4?=
 =?utf-8?B?VXNCZXBwdE9HQjVkLysvMU9aWEh5aGFhVWhBa3h6eG5UTE5IVy9JbzQrYk5B?=
 =?utf-8?B?SW1MOURxT0RpZzB5MFJNSEtoVm0yaklYaWc2cE1pMExRSHpzZmpWcFlSNWdh?=
 =?utf-8?B?NjhtUHhVS1RJaC96Q2d4eDE3d0RIdDBGc0t6RGNYQUJJcitvUGV1NHF1NGtS?=
 =?utf-8?B?Zkc0Y0xJU0oxaWZyYzZIZ2E5THU0dnRjSnB0ZDNUTmp2dHpjQzM3NGVFUXlW?=
 =?utf-8?B?NVNJdjNpZjFQeG5YalNzRElwaFZBVmhNWENoUXhncHFqaTJBSENVaFZ3Sjdy?=
 =?utf-8?B?aE03cUFDd09sSkwyV3BPQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RkhsOFd1TDFMVE5KbktlREZSenJDWHBSZ0dqTTVJd2E3WkY1UzY1Q3VGVGdr?=
 =?utf-8?B?d1JwaXpRSTk5NU1PZWJPUlFyN3BvYkxmclk4UjUzcUVSaTZvTTcvbE41eDBR?=
 =?utf-8?B?ZE02OERZZHFrakhPYUx3YTRpZlRxK2F3OWZmNklsaDVDSFdOYndRcHNnK2Ra?=
 =?utf-8?B?Z0dtbWZmUGRSeExlK2dxcWZtdE1pdGJDMnhDK3JHREZWZElmWTdTRGFrdWpV?=
 =?utf-8?B?cDdsZTlPWHB2QTVHa1VoUmFCYVNRa3BLUlQ5Z1BpK3l0RHJWUUh3VFJhZVJw?=
 =?utf-8?B?azhsdDNESDBQaXBZNHYxMzBiRldKSmRzUzZ3VGJNeG1NdUFlYzVWdmNFSDc4?=
 =?utf-8?B?dHIveDVPcW95cExIV1htYzZ5bXpEQlJUT1gzQVd3Y3lrdTdFRGoxeEluT0o3?=
 =?utf-8?B?UmVOTmdmU0tzWG9LV1Y3dHZrYm94T09TbWlSMHVoMllKQnBCUHZBelI4ZlJp?=
 =?utf-8?B?ejNPblBmNU84d2ZYV3Z4dU50MU5qSUt1SDJqMGNZNWpKN3JlaHl0d0Yzai9o?=
 =?utf-8?B?cE9UV3I0YXgvK1k5a0QzU2RqSkIyUEZyckV3ajZFOHkrV1dyMUs0WWV5Z2RM?=
 =?utf-8?B?b2V5c1Zsc2pWOWUweGFHc1ZjclQrK1FsY09rZ2tWamR5cGxnMndKL0hhUDVX?=
 =?utf-8?B?S1h0T0l6dE9CLzBKSGVTMXU2TUhHNWJNcTFpN2o1UHJIUDFMenRpNjlPQndW?=
 =?utf-8?B?a1pjclRIT0ZPczJERDUzK054VDhZOExQZjM3dWYwa0ZxVjFSTTVISzNKOTBy?=
 =?utf-8?B?VDN4Skk4cGxxaFg1endJaHByZmV0SE4vZWg0M3FmcDcrTEZQNTJDcDg4WG1N?=
 =?utf-8?B?WVA0RUJnbmVsOHhRcktuZDNVMlRlT1FqSUZnVWdDWHdJKzEvNGx1aEh1N1Zs?=
 =?utf-8?B?c0xJYnM0ZlZNTnR3TUZkSElWUDhHMUFwM2pmR2dVYk0xNFNxR2YvVFF6UTgx?=
 =?utf-8?B?MlpaY3pCbzdhQ1lNU0JPcFBybE11dXd4VStyZzdpVjZ1cGluNWtRM3NoQzFu?=
 =?utf-8?B?VXYzcFV3VnlNRzhNL2REUkdRb2FLdHhKOTIwY2lCempQaHBSVHZYUG1rMmps?=
 =?utf-8?B?SnVHemZQR3lCL3ZJMk9veUZXSVowYmVVV3ZyVHpDOUZ4NkxKTmIrby8zODY0?=
 =?utf-8?B?RUpQM2hQeWpoV2lBLzRmS1lQdklaempkeHlmc1dreVZLblhVcG9TNVRwNnk4?=
 =?utf-8?B?anc2UTlKZ28yK0VJUHRRMFRFWVp5R3B6Zngvb1N6K3d0UHQ1bzVKdmYrT21z?=
 =?utf-8?B?eGVmMFcyU2o1dEh1QnZYRmdkRGVScXNyU3hoM1R3KzIxaFVIUCsyeFZtMk9W?=
 =?utf-8?B?ZXM0aVpIWFIwa3FzZ1hvVS9LTXZENmtqY0FBcXV2RjNPVDE0NGtIdTA3Y2ZT?=
 =?utf-8?B?YlovcUJpWjdZTURiTHNDUTJmcGphUkphSUQxOEVydjR4TFNjOExQamowV29t?=
 =?utf-8?B?SGxlTmhJTm5GSjBLK0VtSXVNNytNck0xQUxiY2IyUWtBOHZZekFucXpEQVlZ?=
 =?utf-8?B?MWJWOWs0Qk1WS2VRTUJXaVd6eVp0ckhubmY5cTNHcWVBeE1ERlZOZm94S3NI?=
 =?utf-8?B?N2ZXZVRPYjhBbXZsVW1pdU5rR2dUUHRVakQ0Q1NnVnZiTFBtQkpKYk40ZWth?=
 =?utf-8?B?TUdUSnBkQitldk5xNDFnK09FamQ1ZERUeFVzNXNGMmxwaHp2Nm4waDhvemdQ?=
 =?utf-8?B?clRid3J2RkVndlAvSGFkaFRjYzlHQWJDZG1JNStqYS9ncWlmQ1czKzVyeU42?=
 =?utf-8?B?endwRGlwM3RSMS80azAwQ2pIV1VDTExrWWhWbmNPWHg1Z1o3RDRpbmQ4TTA3?=
 =?utf-8?B?TGVyVzBZRUZ3eXcxMWtIbG5xNkhFQy9ZWW1FUWJIRU1JdmlITEdyb3JBVWpn?=
 =?utf-8?B?THRyNmxxOGxWSU9LcGxoYjZpY0puejgyY0FBY3BBT1JBRE1HeGNNYXN1dENO?=
 =?utf-8?B?Z2phWjVZQk1NRUdpcmRtc0d6VVIrTXdoODhSb0lSVXo4aWVubzNsWUt1N2tG?=
 =?utf-8?B?UW5taVpYcDZQdXJWaWNBalN4d2NRZ0JjV0U2d3lCa1BGWmxaUkptblNENS9H?=
 =?utf-8?B?eHVzS05CM2NPSCtKNkJJNk5SdmkrM1pKYyt6a1Nic0FNZGp2QWxJZ0ExWURV?=
 =?utf-8?B?WUVsT3NqN1BhQ2x1WDNjRnNMUkxEdkhkWldCUHFWMXF6SnMxS0pFNjYwSDdT?=
 =?utf-8?B?RXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9226E5D408002249B185C9D36B5F750E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cgND9BBqL/oNz8zS8BH1TP35dJ60rbnQL1kPhtpFlOZBVKxOrHIVztFAcMX4toVo19+vB/ThrSKpy4fgh/gMOjm/j0l/PBqhMznxnwlQfScxNMZgN3F2gTL0VnA3d8ekqdSWR+mracvNZww1x6J4MIDDJwrDUEzAzFgpvVhHKh5033yjxTIoABPigZ4GYylZCyMPMiG819teusdFqinwtpYQH2xQHaN0q75qBLkLz14ko4Md3Ep8+W3uF/UvIVVojlo1JvJDri6L/hPTokbP9L2wOVvJlkOcQbXMrLyyoCGzgNxt7Hrw2PI7oVDRBn6pQKY96SNDFrKM/sdROkf5rh8Hqm3fJrjYpbALnKXjy5KKY2IDefp75jvsS/q95Ez6F6cG3u6HTVcxLBiGnf/acWpp//FFi/2OSWQsQIsazDpDxmhVrcdOMLr+P3YUCMIyXKMKu6am+D68/qwi+A6n/IWNDUZldxgf1Yblur1i1Cto3Uw51tOPQ4T7SkODlD1KecMWMo4GMMdGvBQoI+saI49Tfc5V6WhlXbsYM75BH8HKjVF8n8vuqHVGva6XX2oXnN5Ur1+nhfH1dDMcNEFA+qDwz5gtOEap783UIbvlWwbdL/P12gvUzIaHPVgwC6RT
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35782b81-dc55-43b9-645d-08dc72a70498
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2024 17:14:44.1725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KjOR2GGiwG+8fK2R2vUlzPRfqc0JEmXB5RYilesR+byi901AACKiQquPt3ZJ7cyMEUFhuoBkY8o50Ssr5256am3mV34s9V3PPZLiZm0CLj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR04MB8897

SSB2ZXJ5IG11Y2ggcHJlZmVyIHRoaXMgdmFyaWFudCBvdmVyIHRoZSBsaXN0LiBJcyBpdCBwb3Nz
aWJsZSB0byByZW1vdmUgDQpwYXRjaCAyLzYgYW5kIHRodXMgdGhlIGxpc3QgYXBwcm9hY2g/DQo=

