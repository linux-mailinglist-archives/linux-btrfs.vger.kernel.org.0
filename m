Return-Path: <linux-btrfs+bounces-10792-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0706AA05BD5
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 13:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51C083A7614
	for <lists+linux-btrfs@lfdr.de>; Wed,  8 Jan 2025 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8291D1F9F4C;
	Wed,  8 Jan 2025 12:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S/V6He7p";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DKGrV/wD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47341F7589;
	Wed,  8 Jan 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736340156; cv=fail; b=jgBPn7st8Uw/z8hGhXReWeiSM+CTN37U9ojV9K7jEsAT3xpwJySr3PAeSBYtV7gaErCjHgy222KXTzNB+Pb3QOxnZLovzpSwMzznEfo4YfDt97LZAPmiAM/tW21KWCa/nWOLB573AVosxUAlLGg2MCiSfpVH4Kv8dGXyZ7i6APA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736340156; c=relaxed/simple;
	bh=P3ni2Lj1Pmzzjg6eNWGVcFrmdtgY481JHbO/F9SqaKw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eEpdzHBoX8MPOCCLyx69jdU5YR1GpV5Rjj72iWkwRAearHdunq9pTUHYELH9JAy9BhGdXiYkHl30dOoOsc7eNoBwOJxNv3zqXlsu1RzzOobFvmGM64F4tcRBtM5voCSQHm4lUNf6EWZWkI60aEhmH96GtzSVK8DEDFsJDWPBWME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S/V6He7p; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=DKGrV/wD; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1736340154; x=1767876154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=P3ni2Lj1Pmzzjg6eNWGVcFrmdtgY481JHbO/F9SqaKw=;
  b=S/V6He7p0/EkGhxsqU2kyUHSAvGm9UKxlgspDFumH1FBTBSgSnjNmGgS
   QgLG0y45iHJMksYmOj4rRLtmfgGAf2IzK/qYxLpPyU+4PYB90LPrB3Pf4
   vD/amu8N2cy4WszZXFbJFmWt3C3lGqxd38VumaBB6fsJtyDbQFZL0Eq36
   loBE2RoHuCyWOyVh9CeCWIoMgapB+Ax4mRU+XAVGtDdnKYqaXQQ/A8dFn
   SCKEVzVpdrmY8hco/EZex1A06RGdK8hrVVrJFY5OQfsFNjAsFQtymTWk7
   uBZWOf5EjtR5/u5kaYNtSs82sVVJ7JwFGrVeG9sLtZPdk+tUTAYvybqab
   w==;
X-CSE-ConnectionGUID: 5WfonzUgRGmp3wilZfPDWA==
X-CSE-MsgGUID: Z2LkELjiTiCHLevXfHn7Hg==
X-IronPort-AV: E=Sophos;i="6.12,298,1728921600"; 
   d="scan'208";a="36661477"
Received: from mail-bn8nam04lp2043.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.43])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2025 20:42:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MjmhO+t5nf1QSaVpZp+JXENKz5vnkVL0zUWrussM5S+MItAydVFNC4csa55PH2n6Bd+07mTEufcprGdXY+GKMJfzH4VAnDKuBRMJ+0HsrtT3nC64b3+1N9vCKCVgCG1wY5FNjtxHXM5GbsOZ29O5LAt45iCYpzT7EQVbdydruQfeaHtPdTj2H4SxqNO7L5X1jugrgrEEBlJTFp5Vl7wV8S/lAwCNhwStVWy4WLelun81yHxqEEhVJWpTDMNYwqbuOObiZKQZyjtQUzl8ItNB3Cl0xo2Iq2zAW5aQY2bLW3zs4wH6sqGipAu0WxoPsmWCuEzVQht/WbGWnazjuoYBeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P3ni2Lj1Pmzzjg6eNWGVcFrmdtgY481JHbO/F9SqaKw=;
 b=XKHo5vQzIjMzLXfeSwu8qWbM43ZBYRcNAvDN0IUDtDa75Y0TG1ohdO+zaKM55xWbzDX1dnikSV0YlalTqC5p90W3myp9UhslZqXedJlq+XSXIrLlnpLkLe4sXFrUAft19TujspKWseYxEq371kmzPsSh3tf8nGDdx7lvYx+ANm2Jebsgn7qKGF3AzyBGO0USMBGJkyz0yB8/nQEdPo01PSqiOSWchwBxsgN7urv/wqvP+tZuW5ETKRDgw6QgYv+sIpk+1a4vxePdxe3C3KQ3teLBFb1j+zo076LxRs/165FjZJS0LrmZRbWGEOnlb/JPkjhIX4BBV1Sq58+dKrYsEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3ni2Lj1Pmzzjg6eNWGVcFrmdtgY481JHbO/F9SqaKw=;
 b=DKGrV/wD+Vkk93LCG2oJDRwqWGOB5Tt9DRPZkbME8g3+rhRCzXgAGjKYzB5XgMqGF9PAU5Qm/9JFKDxECDTHTRZlHRu+1fKDmlMSAZA9i+8xy8Sdssdb8ca51+IP0ZQ4FoU2nlTMOwdTo5ig7/6e550vHl3gCfIrdlAZq6xad/I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MW4PR04MB7202.namprd04.prod.outlook.com (2603:10b6:303:7d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Wed, 8 Jan
 2025 12:42:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%6]) with mapi id 15.20.8293.020; Wed, 8 Jan 2025
 12:42:24 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Daniel Vacek <neelx@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btrfs: keep `priv` struct on stack for sync reads in
 `btrfs_encoded_read_regular_fill_pages()`
Thread-Topic: [PATCH] btrfs: keep `priv` struct on stack for sync reads in
 `btrfs_encoded_read_regular_fill_pages()`
Thread-Index: AQHbYcKvsL66shJuj0GP7Xf11s6QnrMM0gAA
Date: Wed, 8 Jan 2025 12:42:23 +0000
Message-ID: <9cca57da-3361-470d-83e5-0d78deffb673@wdc.com>
References: <20250108114326.1729250-1-neelx@suse.com>
In-Reply-To: <20250108114326.1729250-1-neelx@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MW4PR04MB7202:EE_
x-ms-office365-filtering-correlation-id: a159de5b-08fc-4ca5-32bb-08dd2fe1e6a1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?cTdGbmVtdVNHWGxpb1hWN0JsQmhkcjMxU05qQ0tOK1gzRmdOeWo1VjBudmEr?=
 =?utf-8?B?R2hpbTd4ejlHTnVyWnZJWDR3QzRTVXpsOGx3Mm9yS2lNSGFQWG5oNjlzY0E0?=
 =?utf-8?B?ZkUvMWtuRzdnZWlhQittK25YMWFrQldkSk5IZFU3dm1VR0YvOTNLUVYybzRH?=
 =?utf-8?B?VERXU0piaXY3bVVjayt5V1BVQ0sra1lYZWR0Nnl4cHJNaXd4NStKT05tSURN?=
 =?utf-8?B?Zi9CSUI5RnE3ekpmVDA4VzlFSmVYc1R2bW9GQzBKSHdYSUxnRkxTc2JoblBC?=
 =?utf-8?B?cGNFYkhVNHZzNDZIeW56Mm1QeGkreFF3TEg5c20wRmZjVU9FVHYrODNNanFO?=
 =?utf-8?B?MFUzMHFVL2Z4OEJXbHFKMVJjQXcxOEh3THZZUlR1cTVuWW5sSjZrcGN0T2lO?=
 =?utf-8?B?bEcrRjJJOFQ2WjZQVHNhcGxGdGp2Tlg0aXhuK2xIQThCVC9vdkdSTzhxUVY5?=
 =?utf-8?B?WVBVdmplWEEveVhEckxNL09HUy9WZXNIY3pQTUdGQkoxMDE2Y1dvMVVTV2J0?=
 =?utf-8?B?WXY1TjVueG9Xa1hCVUl2N2ZMM2Nnemw3VVlPa1pUQjA2NElLV2FCWWtPbjZk?=
 =?utf-8?B?eWZDeFFhZTA0S3N5WjlCVUx3bXQ2YUVici9BazVnTlYxUUZhLy83NmZSL0hu?=
 =?utf-8?B?UmRvdjZ4MUVtM0pIeURJTmZMczd2Q1VueEtkc1FDay8rcDQvZk45UjZWdHA4?=
 =?utf-8?B?VkV0TDhGYWEzYmdzaVNFN29FN1ZqMm9kc3BMY0hBNWdxWEV6ZzI3ZDJRYnNi?=
 =?utf-8?B?QTRaeEhtL2pJb0ZGanBnVDBCQXpKR1lLejcxZGxyYXBDUDN3Wno0K2xnbVhJ?=
 =?utf-8?B?SStwS2dWZFVYdVVWa2NGRGVHV2Z1TTAyUi9rN1NEUUljVlArR1pVTmFMUVZi?=
 =?utf-8?B?eS9EV3pBOXUzUDZuRkwvZ1UrbTd6NDVzQmo5Lzl0RWNFbmZnRlBBUmNWZlFY?=
 =?utf-8?B?enI2cS9wdEJlbFJvZHVjRnY1N2JEOFI5eVZVQVpxL0hEUUh1OU5SSEd6UmQw?=
 =?utf-8?B?bnF6cEV0N2xJZ3hiWUtPcjVQMjZQdWxJYmk1RUdlb2JXTHBpSEFCRm9mYWtD?=
 =?utf-8?B?cmpFYkdObERhczdWWWc5VHFOb2NFTEdicmIyUVM3bDh0cW9GT1prRU1FOTd4?=
 =?utf-8?B?Sk1PVUUvcE5sdlh6TlBwdXFLS2JtdkdTYURBaHMwZHg1M1pBMk5aeE5uMHdR?=
 =?utf-8?B?bEFqV1NETDJHOUsrdTJWZ3Eremtsb3doQVVNOGh5OFg2SndkR3k0RTV3WjRN?=
 =?utf-8?B?TGtFaENSZGVLZXBJc2FLM1ZNSGdsTG82RlN3M0tTTGZvVGkyN3pzYlJFK2lR?=
 =?utf-8?B?M2JEVDNULzlkeEcxMTRzUzhnaVRUd0tPb2xaa2xXbTdtVUN6ZWN5Nk9PTmln?=
 =?utf-8?B?VlFWeVp6Uk8xK0pOOWdnQjNnUmFtNGxnbXpHcHBkZjIwM2FqanRxODA3TmJY?=
 =?utf-8?B?U2lhQ0lOSjFuTEFTSDQxOGxhUWlnRktvRUdjQnh4RnBBdGdaenFpS2FRSmVC?=
 =?utf-8?B?NkRIcDZlWGQ1d29xOVNwWHBDbHdWN3BDc1JEOW16ZmFoRUVhWFE3a2c4VXRr?=
 =?utf-8?B?b2Y0Z21UTTQ4QXVQeHN3cDVITnhMSHc0Y3laSFZJbyt1aVNvNE9UbURGZ2tn?=
 =?utf-8?B?cURydFZPU0tYRVdKdGQvUks2RmpFeSt1RWhPMGdyazVFak5tOGdmTDhIeUFl?=
 =?utf-8?B?dmdnUnhJbDZONVRjZldIZUJHNEVxOHdqVG5CQ3ZVdkZRT24rOTVNeUNPWGd5?=
 =?utf-8?B?dHlBQUFlZllseUhoSHJpTHVyN2xvaDBEN0I1M1pySUlINkFaZURWbUlYWHB4?=
 =?utf-8?B?bnF1cHo3c0F1Q20wUUFjb0VSc3hObjRVaWdxOTZCV3RHV1RTcmF4cHA4L2xh?=
 =?utf-8?B?eHRQb2cyTDdhRHdvZjBWeGt4ZktKMlU4bmRJRFA3NWJ6RCtOMVdQTkpKWmVx?=
 =?utf-8?Q?wGxtb1vdhxE9pXivmjBlpqxCc29RUvLR?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2lFR3ZlaDNzd3lNWVZmTW9yQjBvejFwWHRXZ2tQQkRPcUFpQjFoUGpjcXdS?=
 =?utf-8?B?d3p4SS9EVjNSR25FWmRwZjNFZ2lIdzJmWFpKMjl1NG1kMGtCQjNpaFRuQUFl?=
 =?utf-8?B?dmpRQ2lHeTZFSDBIOVFidUErTnlaY2Z2QjJDZnVZb0NndjBQTXcrQTBybzFp?=
 =?utf-8?B?cjc5Rkcyc1BsejBOeXExa09yMGs2MmFYVGxJaUZwTitpZklhNzZ5SWVpMXVV?=
 =?utf-8?B?SW92M2VodkhwYUo1RlpkbWhJMmtnNjFJY0NGNWVLUS8vV1hsZkwyMVBjL29Y?=
 =?utf-8?B?MHpHbm1Rc1BTaFRaZmZlK3puTWRyTUNXa3pFa1B0cUhjb0FEajJwcnNCaElC?=
 =?utf-8?B?bjcwWnlBMjhnN3hZRGlENHVLcmtTbm1aa2hnQThaa2dXVXZINVZERXZxTmly?=
 =?utf-8?B?ZkxoZUxsODdpL0x1Q2xOUUR6WTh5ZTkyVElCYUV2MjJuV25rLzNMdTljczlJ?=
 =?utf-8?B?Qm1OMUhPN0tWQXorYVBlTWYvc2hIZ3dKcUVsdHN0Q0cwcmUxcUx1clpKZVpm?=
 =?utf-8?B?dSt3ZTRQck11T3lGYWJIOUFNcnNNZlNIYVMzUmFkc00rUlQvVk5haE5VM1Fz?=
 =?utf-8?B?UDJZSExaRS9UeGpVUlJiall1K3lPVkVrNEpxQ0xPUFdYZVYxdVRhN2ZYNkVo?=
 =?utf-8?B?UFBpOXo3b25LNlJCUVk1R3dnQ1lSdUloUmc3NXZYWmNVM3lERENBZWF1QnBv?=
 =?utf-8?B?N0Q0Q1hzUkpCSUYzK3NOcVdyTWIzTStiMnFOVTJjVXExZEtEdHdpV0ZFNVZ6?=
 =?utf-8?B?TkZVdkh4SXZZSFVGZWErVFpIUXZMTnRGU052czMyd3EvdjU5OWh2L0l5WkxU?=
 =?utf-8?B?eE5FV2hZZGRKd2FpYjRRNFBxYVhCRVovWlcvdzUrcjN1VHAydjByVHp6V2hC?=
 =?utf-8?B?Z09HTHpuWGhuc2JNN1piWnF0K05HUStMRXFvVndCaC9IdnJROGthTVl0cGtE?=
 =?utf-8?B?K1JOUzBnb1JWanc1QzlYbXpqK0htWVVKT0k2MURpR21iWWNGeGtZMUdqQmJk?=
 =?utf-8?B?WjJ2V3gzM3NZdHd0UlhkUXl1REdXM0pxaGEyN01KZUxqSEtKY1Nhb3FRVk9r?=
 =?utf-8?B?WENCOHNjTWw0U3gwbHBwUVR0aWR6QmR4S2pwbElUMXgzRzFyM1BUS1ZoMjA0?=
 =?utf-8?B?NXo5T0RtT29TK1JqM3BybStKT3RrazNKM1hsTFg2S214c2wzTEZpUFlwaE56?=
 =?utf-8?B?TDVEUE9hdEVGei9XL2ZnaDZYNXNEVGZ0a3R3NTNTdGVZL0xuamhOVDdjNFlL?=
 =?utf-8?B?SWpHd3JjYWpxWWdtWnlwM2xqejhHODJiSGIyL1dybEZTTmZDZmM1aVhQVncy?=
 =?utf-8?B?WEI3b1FsRFYrdit6c1hXc29jNDMyYUVPeFNCWW9TejhkMk9wTHNVUkpHd1dU?=
 =?utf-8?B?UHdrRDRnQWlCQW9CMW0rRlJJUm9EZjF4Qm5VdnZiQUl5RzJpTkNHdzBiZnBj?=
 =?utf-8?B?Y3Y0bG5sUWI0R2o5WHg1QnIyL1EvaTBHN1paZVpzY2hMQUtyVDA3SHZweWo0?=
 =?utf-8?B?eThka0Zac3RpYlkyKzlyOHZNNmkyRVc4VW5lM3crRDVqMGdHZGdhK0VvZVdo?=
 =?utf-8?B?a1FMOE1OMHZVblZRUzBzOWhYUVdhN1E5SzZkZ3pQcnJNMGVNSkswbHIyNEow?=
 =?utf-8?B?MkI0UEtJTmhNcThMTXliWGROdkRaNDQzeFBQUXcvMm51eGVpK2JWRHdpM1ZB?=
 =?utf-8?B?citlOXZVazR3WEJ4MFgxRGNWaERGZnBHakNXdk01blVhOFgwUVhLdTRkeGF6?=
 =?utf-8?B?dURtbEYxbmZRTElIQ3lZRGlQaUUrM09KaDhwb2NMVWZDT0VRY2d2MnBNTVo1?=
 =?utf-8?B?NzEwaWlGVW9QM04wOUtRTEU5MkthaFlFSTh1VFZrWDVnVytYYVI4NnI5U3dN?=
 =?utf-8?B?YmovdmFjTFU0QXNJVVBDZ1h1c3hWUlkxNTZGSUpvaS81NFBWUzdrMTljUlVR?=
 =?utf-8?B?bThOSEdRS3pLaU9sMmV4SndLalR3Y1Q4WFE4QkZaMmRaVkZ6QzhqaTJqUklV?=
 =?utf-8?B?NXFwL1hNbDNkTHVRWmJrcjlkVlM5S0NzeFFvMWdTNFZTNkcyb2VybVBNbDdr?=
 =?utf-8?B?WlVEQnQySFpubFgxdVErTytucUplcmhSMFdqanM5VCs0WTc4RUxJUndkdUNM?=
 =?utf-8?B?K2d0MGlsbzNzenRwdW1oR29OY0lvRmM5RzNQSmVBQnh5N25obTZkdzNrQUVt?=
 =?utf-8?B?Znc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <02CD0959324A2042BA6DE4E0FDD7995A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EpaxhguhUhxLGDF/AKg4VM7zbS2/rnDckgZBW3O0wGEeghZ4ACNTEokE74WLeuVj8FvpEf5fI1mnQ5wMZXWJLLmYcbkC66G6RaqLUaOGf99D7XPdS/pgYrYhVw0uIgLAuxSVDxC9QEhV2clBRsNaS5LSJGiTM01yfNZDzHMuNbpLUd55EzRUCB8tagVqd3qIznPRRdkxS+dMgnUW+ZvE+Ca+wDIgonay/dT7vfI0c1DZoVEDDgO6HV1iepji4rhs/+SkNhyr1MCYlXb7z1u+hhiRYpRgpY5nfAdjkw1iaMaNb69OO6IeoCYDshUrGvF/QTr5QN9R+kmEBgToO3c1i4EzMgCB26A4muCBsTzOFGP/Fd4I1d9W8qiTRpT+HYO0cgz9/SkniNIBBLpH0S1WOxZL3tBhZc5GYcscLbXm2lwrrWjnMFUAZGQVURupOq7aWt+sFijyVWPGL/kagyeiUF4hHMtDY2olAlb2nkKJlOjV7bHD/eI2CO2vCQuMChXYbLD2gQ0G5c4TUdSC9EUtLWLamqeCC06E7ltqhEix8tfNcYic/F8GAPOOp2ySM+TAsDrOjzU3iAcDAf/doghvGSuczYZMRTmqWF2hjkGGj0IpUtnfFbUXrJQjSRyDJs8f
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a159de5b-08fc-4ca5-32bb-08dd2fe1e6a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 12:42:23.9729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdtOLFcauHOGh3GVbYaWjbwlk5a/KTaVoOvUmKtGxUkX8PogeKxyta99R26GcXlT1GNSObfF4kMUQJUVbmjS218DOJWN7pEHt1PzYjrcKVY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7202

T24gMDguMDEuMjUgMTI6NDQsIERhbmllbCBWYWNlayB3cm90ZToNCj4gT25seSBhbGxvY2F0ZSB0
aGUgYHByaXZgIHN0cnVjdCBmcm9tIHNsYWIgZm9yIGFzeW5jaHJvbm91cyBtb2RlLg0KPiANCj4g
VGhlcmUncyBubyBuZWVkIHRvIGFsbG9jYXRlIGFuIG9iamVjdCBmcm9tIHNsYWIgaW4gdGhlIHN5
bmNocm9ub3VzIG1vZGUuIEluDQo+IHN1Y2ggYSBjYXNlIHN0YWNrIGNhbiBiZSBoYXBwaWx5IHVz
ZWQgYXMgaXQgdXNlZCB0byBiZSBiZWZvcmUgNjhkM2IyN2UwNWM3DQo+ICgiYnRyZnM6IG1vdmUg
cHJpdiBvZmYgc3RhY2sgaW4gYnRyZnNfZW5jb2RlZF9yZWFkX3JlZ3VsYXJfZmlsbF9wYWdlcygp
IikNCj4gd2hpY2ggd2FzIGEgcHJlcGFyYXRpb24gZm9yIHRoZSBhc3luYyBtb2RlLg0KPiANCj4g
V2hpbGUgYXQgaXQsIGZpeCB0aGUgY29tbWVudCB0byByZWZsZWN0IHRoZSBhdG9taWMgPT4gcmVm
Y291bnQgY2hhbmdlIGluDQo+IGQyOTY2MjY5NWVkNyAoImJ0cmZzOiBmaXggdXNlLWFmdGVyLWZy
ZWUgd2FpdGluZyBmb3IgZW5jb2RlZCByZWFkIGVuZGlvcyIpLg0KDQoNCkdlbmVyYWxseSBJJ20g
bm90IGEgaHVnZSBmYW4gb2YgY29uZGl0aW9uYWwgYWxsb2NhdGlvbi9mcmVlaW5nLiBJdCBqdXN0
IA0KY29tcGxpY2F0ZXMgbWF0dGVycy4gSSBnZXQgaXQgaW4gY2FzZSBvZiB0aGUgYmlvJ3MgYmlf
aW5saW5lX3ZlY3Mgd2hlcmUgDQppdCdzIGEgb3B0aW1pemF0aW9uLCBidXQgSSBmYWlsIHRvIHNl
ZSB3aHkgaXQgd291bGQgbWFrZSBhIGRpZmZlcmVuY2UgaW4gDQp0aGlzIGNhc2UuDQoNCklmIHdl
J3JlIHJlYWxseSBnb2luZyBkb3duIHRoYXQgcm91dGUsIHRoZXJlIHNob3VsZCBhdCBsZWFzdCBi
ZSBhIA0KanVzdGlmaWNhdGlvbiBvdGhlciB0aGFuICJubyBuZWVkIiB0by4NCg0KPiAgIHN0cnVj
dCBidHJmc19lbmNvZGVkX3JlYWRfcHJpdmF0ZSB7DQo+IC0Jc3RydWN0IGNvbXBsZXRpb24gZG9u
ZTsNCj4gKwlzdHJ1Y3QgY29tcGxldGlvbiAqc3luY19yZWFkczsNCj4gICAJdm9pZCAqdXJpbmdf
Y3R4Ow0KPiAtCXJlZmNvdW50X3QgcGVuZGluZ19yZWZzOw0KPiArCXJlZmNvdW50X3QgcGVuZGlu
Z19yZWFkczsNCj4gICAJYmxrX3N0YXR1c190IHN0YXR1czsNCj4gICB9Ow0KDQpUaGVzZSByZW5h
bWVzIGp1c3QgbWFrZSB0aGUgZGlmZiBoYXJkZXIgdG8gcmVhZCAoYW5kIHllcyBJIHNob3VsZG4n
dCANCmhhdmUgcmVuYW1lZCBwZW5kaW5nIHRvIHBlbmRpbmdfcmVmcyBidXQgdGhhdCBhdCBsZWFz
dCBhbHNvIGNoYW5nZWQgdGhlIA0KdHlwZSkuDQoNCg0KPiAtCWlmIChyZWZjb3VudF9kZWNfYW5k
X3Rlc3QoJnByaXYtPnBlbmRpbmdfcmVmcykpIHsNCj4gLQkJaW50IGVyciA9IGJsa19zdGF0dXNf
dG9fZXJybm8oUkVBRF9PTkNFKHByaXYtPnN0YXR1cykpOw0KPiAtDQo+ICsJaWYgKHJlZmNvdW50
X2RlY19hbmRfdGVzdCgmcHJpdi0+cGVuZGluZ19yZWFkcykpIHsNCj4gICAJCWlmIChwcml2LT51
cmluZ19jdHgpIHsNCj4gKwkJCWludCBlcnIgPSBibGtfc3RhdHVzX3RvX2Vycm5vKFJFQURfT05D
RShwcml2LT5zdGF0dXMpKTsNCg0KTWlzc2luZyBuZXdsaW5lIGFmdGVyIHRoZSBkZWNsYXJhdGlv
bi4NCg0KPiAgIAl1bnNpZ25lZCBsb25nIGkgPSAwOw0KPiAgIAlzdHJ1Y3QgYnRyZnNfYmlvICpi
YmlvOw0KPiAtCWludCByZXQ7DQoNClRoYXQgc2VlbXMgdW5yZWxhdGVkLg0KDQoNCj4gQEAgLTkx
NTUsMjUgKzkxNTksMjMgQEAgaW50IGJ0cmZzX2VuY29kZWRfcmVhZF9yZWd1bGFyX2ZpbGxfcGFn
ZXMoc3RydWN0IGJ0cmZzX2lub2RlICppbm9kZSwNCj4gICAJCWRpc2tfaW9fc2l6ZSAtPSBieXRl
czsNCj4gICAJfSB3aGlsZSAoZGlza19pb19zaXplKTsNCj4gICANCj4gLQlyZWZjb3VudF9pbmMo
JnByaXYtPnBlbmRpbmdfcmVmcyk7DQo+ICsJcmVmY291bnRfaW5jKCZwcml2LT5wZW5kaW5nX3Jl
YWRzKTsNCj4gICAJYnRyZnNfc3VibWl0X2JiaW8oYmJpbywgMCk7DQo+ICAgDQo+ICAgCWlmICh1
cmluZ19jdHgpIHsNCj4gLQkJaWYgKHJlZmNvdW50X2RlY19hbmRfdGVzdCgmcHJpdi0+cGVuZGlu
Z19yZWZzKSkgew0KPiAtCQkJcmV0ID0gYmxrX3N0YXR1c190b19lcnJubyhSRUFEX09OQ0UocHJp
di0+c3RhdHVzKSk7DQo+IC0JCQlidHJmc191cmluZ19yZWFkX2V4dGVudF9lbmRpbyh1cmluZ19j
dHgsIHJldCk7DQo+ICsJCWlmIChyZWZjb3VudF9kZWNfYW5kX3Rlc3QoJnByaXYtPnBlbmRpbmdf
cmVhZHMpKSB7DQo+ICsJCQlpbnQgZXJyID0gYmxrX3N0YXR1c190b19lcnJubyhSRUFEX09OQ0Uo
cHJpdi0+c3RhdHVzKSk7DQo+ICsJCQlidHJmc191cmluZ19yZWFkX2V4dGVudF9lbmRpbyh1cmlu
Z19jdHgsIGVycik7DQo+ICAgCQkJa2ZyZWUocHJpdik7DQoNCk1pc3NpbmcgbmV3bGluZSBhZnRl
ciB0aGUgZGVjbGFyYXRpb24sIGJ1dCBzdGlsbCB3aHkgY2FuJ3Qgd2UganVzdCBrZWVwIHJldD8N
Cg0KDQo=

