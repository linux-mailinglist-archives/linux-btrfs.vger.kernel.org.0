Return-Path: <linux-btrfs+bounces-12350-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3DCA664FA
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 02:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FECF3B1A39
	for <lists+linux-btrfs@lfdr.de>; Tue, 18 Mar 2025 01:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D09146A72;
	Tue, 18 Mar 2025 01:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="dZg3mdHS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dlfXGFtD"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814385695
	for <linux-btrfs@vger.kernel.org>; Tue, 18 Mar 2025 01:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742261241; cv=fail; b=ID/PNjJjxnS2dn3gU17mFfy0PthtaN/it1+2YZKb7NFg1QN4FdRAORY1DpDsTLqVczb49MBOdWDY66UIygOh9Qc8Wsny4aLb4H9Ud7vrGTBRbSisWhrchudKDehEn+n2tsdgkGrtSd3n7Ps7l67rHXrtw/KnFgllDdE4mlk1Xlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742261241; c=relaxed/simple;
	bh=kbiVBA6rIGvrAxd+v22I3vgcSFScp0Ekp4iQ8XOdHrs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eFwyyPrjqTXiCnjnn7bEZCLFE6jOgsP4G7Ek+9tX3tFWlbwJNgi4TO3wZakDEkMieLkyc+zIM4MTTTaxqoYo2VqL7TFMMWyu2VwVn9HBmcd9rDekCeOFcDTEQsOpf3jBsshYKkDMt4pX5VYMH3jrmqVkbzV3X/6TvpkiNF0QeFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=dZg3mdHS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=dlfXGFtD; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742261239; x=1773797239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kbiVBA6rIGvrAxd+v22I3vgcSFScp0Ekp4iQ8XOdHrs=;
  b=dZg3mdHSdqQJNWJfLCY1QDQLcyQp4OTAY64QK8Ruk03E03rohDb56fiy
   OFF0epiiKOwNVi/fYfD0dBJbES6QqkIOrigT0SB1f7EbfQ5Y2faVaW3nx
   +NjSZnHWGSrvDtSXW8sLcqvY9DI0QPsoMhsdGdnLVQjFbqECYNJ7hpFyY
   a48vOy/gPfaoQNdFVvRDStjpAaU53jV4/O/Cyj8+1QC1Pcopb2o019WM4
   5CjNe+oDkjqeQ/AiDZW89GQirjsncB0X3B5Q/WUwZNpgEKscmANssSfEi
   3MExYHw49UYhmjgPU3Cvapvs8gzC2BOCu44xDorsJzh5ynfnZKf5mWpOZ
   w==;
X-CSE-ConnectionGUID: RT5qv4/xQL2UrOKceO3iMg==
X-CSE-MsgGUID: +O2EVYJcRKeJDPO4EKvHbw==
X-IronPort-AV: E=Sophos;i="6.14,255,1736784000"; 
   d="scan'208";a="51541065"
Received: from mail-westcentralusazlp17010001.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.1])
  by ob1.hgst.iphmx.com with ESMTP; 18 Mar 2025 09:27:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t3iSZ4fNpC9DIXSa4dQvET14+5tCHY89g+hvO5yvRi4UNlE4nQmD7hyGFzDx7lVOYsEfnm9bIm1fRuwsyfgsIan4PplNMxhB+IaB8EMAxhVK5/+CzC95YATloPFwtrnmZlpenXl2cepEvFuWVeYKLo2SOgHDJBTvMceZ/ksrQAZaE7yZ1XkuX5AUzZiQIj47SeC8uIag8bIDDm/UW0Qy+S1DTBsQzKJDAzSHBAo3ZK/9FDfhJT1Xn3NxUMLFBBtvV9V8t2yhT1dglvJt6xFUOT8MALwyNqQdSj8ItbkVWs3MLTLZOkX368zLy406sXW+bklphT8qUx2uyBcXCH4xuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbiVBA6rIGvrAxd+v22I3vgcSFScp0Ekp4iQ8XOdHrs=;
 b=hlZwaq9AdIjjidW28LWUDj5NAsB4AqLy4qKYokzQo5Am5HXe9ebmeeKfyfZ/0FrtM6UyeZGqagdfkiNi464GoW5vXZBV7VYFg6hN4Q3FTWcrHJ9DUdBlyrVqXVTefTgZS0kgwWlnV6KqcTP4pzhfpSkeNvIJg8TzazKKm0cX2u4eoJcd4g0KvKn+KOdMSJJ/+Mz8savPVPwdKT1qs/hS9O9+heo9J7YAphys/5XEUtqQugZiptpAlq2Yzmzlm1QaMGUPl0r1yD49L5NfsBj1vBoR5LYIcVTaaJOQ9JDOSY06pNQhN+H02G8+LOWpNO4lSArSOW7C3PVebqn3s+PGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbiVBA6rIGvrAxd+v22I3vgcSFScp0Ekp4iQ8XOdHrs=;
 b=dlfXGFtDuY6y2jhmbduDDecmj93EXMJAi3k50rpDoAHxpHPdbax7PWxKcLoGfOXzcTc6GC0JK4lXflvlQY2v+2jhGXkVYjiHE7dmJ9GjbO5rJdUc/zjPQaD2aT6k42+fAE0GEV0/IzlTVWu2QboWwY9uGYO6ajPxiqgeS09bNx8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB7168.namprd04.prod.outlook.com (2603:10b6:a03:297::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 01:27:10 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 01:27:10 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Naohiro Aota <Naohiro.Aota@wdc.com>, Damien Le Moal <dlemoal@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 0/2] btrfs: zoned: fix zone management on degraded
 filesystems
Thread-Topic: [PATCH 0/2] btrfs: zoned: fix zone management on degraded
 filesystems
Thread-Index: AQHbly9CpjU2y1g9oUmmq0hGkTvnXbN4GyiA
Date: Tue, 18 Mar 2025 01:27:09 +0000
Message-ID: <D8J01N6OQH6L.DGSU6515XFTD@wdc.com>
References: <cover.1742210138.git.jth@kernel.org>
In-Reply-To: <cover.1742210138.git.jth@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.20.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB7168:EE_
x-ms-office365-filtering-correlation-id: 153647a4-ee0b-4980-02a6-08dd65bc00e2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SCtDQS9lYVNTR3QyK1h0ZXRncFNOUEg2VzdzeDBOU2NHbTh3SnBnZDZjNzB4?=
 =?utf-8?B?djZERm9vdkdhYTFxTmhRb3YrN0krc3N1UWsrTnN1cldsNmIvS3B0R3UzaEJy?=
 =?utf-8?B?ZENIWWNBVXZCT01XaytZU3RwQTYrYnNoWENDeXl5VWpjVjZ5MHp4VHpNRzZa?=
 =?utf-8?B?cThFZ3cwMzJlUzNhSHBoWE5KcTZqNlJUR1B2WkdGN1JRaW5ubUt6OGdxL2Rp?=
 =?utf-8?B?WFVVRU9xOHEyNlZPRjNpNzgrUW5KdFVxcEdKNm9EV1ZWajRkdDl5VXd4M2lM?=
 =?utf-8?B?VGliK2tkMTVLMGJ5U1o3V1JRQ3V1aEpSUkp6VWRGb1VwUzFvdzMvNXJqdDAr?=
 =?utf-8?B?U3RVcE45VGx4elB3R3hsRnRvZWk5SDZnTkdReTJyV1d2RDlnM3d6YVNPQk16?=
 =?utf-8?B?RU9VWFQ3KzZwTDM0R1NvUHNlWFlOeFAwMWdHMGpJRHVYV3F3SHYvanJXUnY0?=
 =?utf-8?B?QnlNMEJ2MTU5U1hVOW1NUWlXdGpDbXFacG5LaGZDSDJvL2JoRVNxWUJueldZ?=
 =?utf-8?B?TWoydHVUSzRxZUxkRTh0cUF3b280a09SYWlKak5xRmRySjJqRGtueTRIK2hP?=
 =?utf-8?B?SDRlRTZsNXVqUSswQjZwSTdmYyt2ZEk2WFFpQkFxSC9Xa2U0WkZzUGNQZTJZ?=
 =?utf-8?B?Kzl6RDRLUjB2aWNUVHZxS003Vk4xcGFwd0tuaGtkRkhXaGc4WnRjVE9SaW5N?=
 =?utf-8?B?ZjB5aTBURThvdDQxYU9rQlh0a2ZCTG1zenhXZ2xKRlNWN3FIUkozT2dPaDhj?=
 =?utf-8?B?aUk2ZUNaSEVJVXBmeDJpS0Rab3RaaWZFdkdiek9BdmZOYloraUhXTXU2aXlL?=
 =?utf-8?B?djg1cWF5M0RxS21BdlpjMDBTOC9JUCt6c3JIbGNaN3JCOUVWb09kZmRXeS9D?=
 =?utf-8?B?L1VHbUNjTzJ0UW5IaEdYakd2dTNMWXl5TE4za3JhRlZnanRIMm4rZUJWbzc4?=
 =?utf-8?B?djUwSDhkeUp1OUpQY0xMamg0ZFc5MnUxc2hZMG1mUHdQeWlHbzIzU3EyWTZv?=
 =?utf-8?B?cWdXZkVPSEwvcldXd2NaSnlxcHBrYksycjVaQjVSQVRpd29xaEZpREd5UUZE?=
 =?utf-8?B?LzYvdkFJSXdXQVpSeXdPaVM2cjA3VDY3U2JLZVM1RVpVSjVHdDh0bUd0a29F?=
 =?utf-8?B?RjNVVmN3R2ZuOGRaUytyamtyK2o5NGs0MXoraitDa0JWbHRzeE85UHhNRmJ4?=
 =?utf-8?B?V3R5VDI5dWlBWkI2RUpGZUZWSEM2QnRwVVRoMlZpaDExOVNFSURKekdmV200?=
 =?utf-8?B?TDNPTEl2RXlSRUc3czhnT3gwcHFuejZtdVFzRkZPWitUTE9IV09adGwrMDFT?=
 =?utf-8?B?UWoxTG5MQ05PYjZpU1k2dmRhYnh6NXFBdmdtMHh6a09semdDeUxHam53ZVJD?=
 =?utf-8?B?ek1sL1BiQ0R3bjZ0T2l0V3BzQkNpTExNN1J2UHdCTzIxWDRyVkZwOUxnZGhv?=
 =?utf-8?B?cjVkUCtlNWc1SzNwUnp6ZTdiRlBRTTBFYnhiQWlSNGNNaHErZnMwRUZsazBn?=
 =?utf-8?B?V2V1NXVKSUsxQngxN045T0oxUWhWVmhxTjBLNW1CSHlTYzRVR2R6OENMTmM3?=
 =?utf-8?B?Q2ZrNGl1c2V1VC9KTmcwMGxKZUpHLzIrWVZHbEUzcTIwdXMvSUg2UDJXbW9S?=
 =?utf-8?B?QVV0Zkk1NTJTd0RTb0tVOEthWStLTWowMURHb0VIZFhscTJrVGlaZTJHM2NM?=
 =?utf-8?B?RW9yb2ROeXlIQk12cnp6YkRlTUYwOEkyK0g4bTJkK05nQ2hteVN5QzJPMGJp?=
 =?utf-8?B?YnRnYUhQS2NlSzZZVDNBbVBBT2lpWm1XVE5BS1htdkZiMGg1VzhVbGFDUTRx?=
 =?utf-8?B?NGoxQ0kyUkZZSFpmaCtMRWFZSVdyVmZXMlYyYnVlQi9hQjNHQTN2OWE2R1Vv?=
 =?utf-8?B?Ymxzb2FEL3dRYUd2QTYwRmdYWS9jN2txN3Nzd3ZQZDFqZ1lCdWdjbnBzVFhH?=
 =?utf-8?Q?0p7G4mi2pxFnFdbiafy2v4wUl7lr76kM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U1lLcEpicE1GdThxUVZmcVFVNnAvVy9ia042ckZ0b1BFRWhrM25aUUwvL2Ew?=
 =?utf-8?B?Tk9vUDBlbVBwUjhoVHZ2K3BtaThkcmxqTy94aERZZDZLaVR5UmMyeGxzdUJU?=
 =?utf-8?B?L3FIc3ZvVFhOayt2WmJZWVVLWDZMT0FWYWRMRWduTzg2VklRVTc1ZzR5YVpZ?=
 =?utf-8?B?bThFSnp4OTN2UDFsMGNmdjNHdnZ3YkFqRGZUWWhVL3dCWHlSdy9BUHRzSGIz?=
 =?utf-8?B?M2hpRXJmVWVWSHhzVWNxVVNFUFZOdm96dVRyR0tPb2VwdHRHRUk5emQ1eDdV?=
 =?utf-8?B?Nm5pdU5Pbm5RT2ZVakJpWmNkK2N1bThQYmRwbmYvSkF2V3hxQndxVWwwRUh3?=
 =?utf-8?B?RTRUZDlIeWpDQ3JKdTVlZjlPMVN0VzZMYnNkWDlnNnMxd2FvVWppZmtqbVpP?=
 =?utf-8?B?ZjNUUU9JdnZDbnZkdlBTSTJKT2VPMGhpeVUzOFZHVVF2Rmt5L3ltbFI5MDNZ?=
 =?utf-8?B?ZE9GeGdQakwzMDNPSUJ5U0c0eTBlVFo4dWFHS3I2aHBMcUprR0tXUXpxdkZz?=
 =?utf-8?B?SDgwcXRwbktvSVl3MVhHNHZ1dkZJY2ltMFB3N3B0enZISWI2amVOL25BK1k5?=
 =?utf-8?B?ZHVTTTR0anpvT01QNVdDWkR1THdKZVd0TVZzTUVHbGl4eC80dkUxVHQyc0NV?=
 =?utf-8?B?K1hJMlpvM3psNDRVaWNRckZUb25WT1ZWNkxGQjZvRXhUOVNEcTIrMWtWNmtH?=
 =?utf-8?B?VXZwaFE5aWNEY3NSS01GTWtaRWRDR1lRSk9ScHRmelhBekoxOXl0ci94bGJj?=
 =?utf-8?B?OExxZzRPNnRZZHNUZ2F0Uzdmb0JNdzBDbVRyKzlMbStqZ1Y1R1ZIcGhmU2d5?=
 =?utf-8?B?Q0EvcURwRWZxSTkvSjk2eFJhQ2hRU2dJd25xVUFabzJrQWRCcG1XRW14cm1r?=
 =?utf-8?B?ZGxNc2ZDWHdCTytzU0VCZjJoMWRCQ1N4N21ZRXVWYkFJVnhDM3F1bjlUbi9D?=
 =?utf-8?B?Q09VbGpTbE1kMzFTa1ZSZ21LK3BxQXdMZVF1aFBEZ1orVVZaTk5kbmhxaGND?=
 =?utf-8?B?NkwrYmswTlZjc21sSmhiUXNPdjZIL3VtYm84aVBOYlhBeWhSSTliR01rWjlD?=
 =?utf-8?B?QTM3em9FYTB4ejBWd3gxL0VxOE5qcXlHc2Y3dmhuM1pqMjVlQ09XazV2a3FH?=
 =?utf-8?B?cU9MY0ExajRpK0dCZm9JYzFFMVpZSzVGSlBDU0RzQzd4eGpiMmwyRHVrY1FH?=
 =?utf-8?B?NmFMenNwczY3U3NDUGtsT3haeHl2NjR1V2VVVmUra1pMY2Z4WkFrVWNTNFUv?=
 =?utf-8?B?eUh5NmE4MG1wVzNWeDRPa28xWDJTeWlSV1ZMQ3QvRGxyTFFibG5CSVVQbVlJ?=
 =?utf-8?B?bC9nYlQvMXRtQkZRZUtpOXlSNWRjZnhLbW1aYlhac3RnUFVEdTBCMWdpTWRm?=
 =?utf-8?B?Q0czdTN2Vk1BR21EYUNoVnZJSVIwNDV1SW0zMG9mRGxFNnRUSk51WEtOK2xk?=
 =?utf-8?B?SW1nWk5wU2FBNnJ3N2JqemQyYStiVXR3Tmo1Nk1sazBURCs2dkJDcmYwVFZn?=
 =?utf-8?B?eEx1VlhXcXF5V0tUM1VOMVIwbkt0NmkrNlJhcEROL3BNSWdEMi9WQVJaQmNR?=
 =?utf-8?B?aEV4SzNLMWZLWVkxRlF2anNhUytqdDVnQkhWNnF5dGMvazVNZ0I3UTZMa29U?=
 =?utf-8?B?TkFLMjlidXFVamhwR3VqYlNkK0Qya1c3bTErVkQ4aTNJNTBvUDk3eUp5ZXdu?=
 =?utf-8?B?bjdwZHR0YVFjdUpRM3liNDNrSkRIUEp3NFlPWHNVMjN1NTNaNllmV2FGTjRw?=
 =?utf-8?B?WWJ6OXpRTHFOZGphbDl2T0pSd2NqWk9wSCsvVjdlb2VpQStGRXNNN1JEcHNz?=
 =?utf-8?B?RitQcGNpZ2tBUXY1YkRLRDl1TGhIMzZiUU9FNzFyeGRPUVNDanFuYWJldmVN?=
 =?utf-8?B?Vm40YkNWK2N2UHVkWHVQeG9BY0lWajdxZitDOENpV2J6L05KdnBZOGRhbStD?=
 =?utf-8?B?M2piLzc0TVN2TlZ3eUp1ejVsYjY0ZllTSElUYnkxM3Y2QVF0eTJzczlVNytY?=
 =?utf-8?B?YkdGNytpdDVzd3BaZFpINzhBTUswdDEwVHNLaWtVUWx6UWNPcDA1STNkUEk0?=
 =?utf-8?B?THVPRkZTT2QwMS81aitneVdhQkJrcElkeTR5S1U2aWtPZ2hFd2lRR08vS1JW?=
 =?utf-8?B?Z0xka2xMY1hDMi9EdDJIZzJhU2Y1cXk2dnZpUlpHQnF5YmtMeHJabE9BTjAy?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D23EFDF54F93D4429B88BBA327A95DCE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H6AnlwqIrJkAWxCBv/iNyGK2bsDm+KtO1aPuJFscmKKMY+PaqMu5LvDcx87nfMtFth6iPvhDPKaM2/KSwK0ytvV6ReEQ8KCJ8El7Scc1Rqsi4bvGMdJ6KvWgm1O5BhA10jf6JSQIK1MjmddOWeZPcaTNo+MPqjFnqIJbvDnd/b2vsdWwS9QA+z8MhckngjRHNVRdazZN5y+2J4tjYMYteo0CSjeKmrDsbzwXpONKDUzLkqgUtqlhPeOBy+ePk6qffmar+yxOkH+U10oGsUXPMYiZK4WR/BwEZSuH5P4/zJUAUsxCbW3Zs5QTnCC5DwHAcK4zBc7IXW4q11YRw2ivnN9SeeEH6U9ba8eWRykui17OYLEYZGxphEGcsYJJ7kW5k1e1Trne7cTerwYQ11dISGHelIh0Xy/FDPTiFqctKFPuryBK29t7Re1+mclCD3fEypwbzRncSRqDftJLUUcK+PtvqJt5jLXjjwW+eV0zb+0CTFdbzjJ4IAzvWT3ytZWorUcqOY1vmm9Mf1ueS+i1RIdmbdGIGpOLlyRL94UUK6v8Z69QgNAN5KgHJRVQWPBXrg+tuL5X3C7M0bk+Uvu6rvBaDtd30FlK0qwk2QxciTAgcoLbD7JC+8SlMtNtjXX6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153647a4-ee0b-4980-02a6-08dd65bc00e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 01:27:09.9332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VguPTTlcxA614E/vycE6LoUqK2zAGY9gbNm39SqxEs4c186Pni3OuWU9FN6rV3FC6HSgLUWJHIP46ViEzopf6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7168

T24gTW9uIE1hciAxNywgMjAyNSBhdCA4OjI0IFBNIEpTVCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdy
b3RlOg0KPiBUd28gZml4ZXMgYXJvdW5kIFpPTkUgRklOSVNIIGFuZCBaT05FIEFDVElWQVRFIGZv
ciBtdWx0aSBkZXZpY2UgZmlsZXN5c3RlbXMgaW4NCj4gZGVncmFkZWQgbW9kZS4NCj4NCj4gQm90
aCB0aW1lcyB3ZSdyZSBkZXJlZmVyZW5jaW5nIHRoZSBidHJmc19kZXZpY2U6OnpvbmVfaW5mbyBw
b2ludGVyIHdpdGhvdXQNCj4gcHJpb3IgY2hlY2tpbmcgaWYgdGhlIGRldmljZSBpcyBwcmVzZW50
Lg0KDQpBdCBmaXJzdCwgSSB0aG91Z2h0LCB3ZSBzaG91bGQgbm90IHdyaXRlIGludG8gYSBibG9j
ayBncm91cCBjb250YWluaW5nIGENCm1pc3NpbmcgZGV2aWNlLiBCdXQsIHllYWgsIGluIHRoZSBk
ZWdyYWRlZCBtb2RlLCB3ZSBhcmUgYWxsb3dlZCB0byBtYWtlDQp1bi1zeW5jZWQgd3JpdGluZy4N
Cg0KU28sIGZvciB0aGUgc2VyaWVzDQoNClJldmlld2VkLWJ5OiBOYW9oaXJvIEFvdGEgPG5hb2hp
cm8uYW90YUB3ZGMuY29tPg0KDQo+DQo+IEpvaGFubmVzIFRodW1zaGlybiAoMik6DQo+ICAgYnRy
ZnM6IHpvbmVkOiBmaXggem9uZSBhY3RpdmF0aW9uIHdpdGggbWlzc2luZyBkZXZpY2VzDQo+ICAg
YnRyZnM6IHpvbmVkOiBmaXggem9uZSBmaW5pc2hpbmcgd2l0aCBtaXNzaW5nIGRldmljZXMNCj4N
Cj4gIGZzL2J0cmZzL3pvbmVkLmMgfCA2ICsrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5z
ZXJ0aW9ucygrKQ0K

