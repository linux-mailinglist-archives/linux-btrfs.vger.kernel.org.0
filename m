Return-Path: <linux-btrfs+bounces-6283-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B44592A16C
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 13:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FAC01C20FD7
	for <lists+linux-btrfs@lfdr.de>; Mon,  8 Jul 2024 11:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A327FBDA;
	Mon,  8 Jul 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ju7uGQzy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PbrEuND3"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A856B7BAE3;
	Mon,  8 Jul 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439020; cv=fail; b=gXloJuxoWZjGizp2l+hSXFBSu0MqotEdYLrjaaFxPztWN54zZLP+fmxjiX4ZLqQ5L9NKutL4M6RgGYFF8YMct/ie0VsaqckvOqu31iQT06e1xYDY6pjICRenzFMEKZLVnTcj1SylyY0VbjnTUG7YLEGkigPPtBQ3sgegzV7I6s4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439020; c=relaxed/simple;
	bh=csSTUHxk9kus29kx/20re5EjDe0H8gxK6rpAED4Di+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=unphXKDbRdIVwxM+iHJ+ya5Qdj07XxmWQcs5JSOWwY6zm80MVjISBnHJDli7lqIF/cIzK/k1QxtfrjxWLcM5sb5VdVPb7Ruu4I32vjg30uAjOnhquR34eOpJxn9Rwo93rn46GVxM9dDLFtE56KPtKjHdAhOFLWk2fCKlTGFDbSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Ju7uGQzy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=PbrEuND3; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1720439019; x=1751975019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=csSTUHxk9kus29kx/20re5EjDe0H8gxK6rpAED4Di+s=;
  b=Ju7uGQzymhqx3dDfpjqB2K3fOw36j3bwxZj8kAOU+eOVdNL3DnukXcLd
   BKGH2ilJ7Gjo/MYra3Va0sKJIVirTzGMvvL5jBkQNT70VBTbHGvRzAqSi
   K5OaKFP8aZHo3D9Ok3VG2rVRwlUBFFIirx0JSQmvn2P7OhGVIyR80cA16
   XVhwUuCzDUexyNTnO1wwJuRZweHdh2BCFaf0QcaVRduXrcVzOMHRVHdFz
   P0svw6sm6oKTOS04FAd+LMs2+UwRSXI7UUzjx8DtBjCzD3OK9jFuPZ5Cq
   TX4Vt08ND3yw4PlWOB6U8ohDXAlaUvPqhUXhw4bDLYx2acLJVcXiV+gd9
   Q==;
X-CSE-ConnectionGUID: kAM8n7r5Tae4T7789GPv0g==
X-CSE-MsgGUID: aDSf843hQZS5yjYAeOs0WA==
X-IronPort-AV: E=Sophos;i="6.09,191,1716220800"; 
   d="scan'208";a="20803781"
Received: from mail-dm3nam02lp2040.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.40])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jul 2024 19:43:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZmwUCZb4zRmepRQwcTVBo9ShYaD9dq50rkq5CiuWxeVf+PzEiVNPrLck2k2LB7GykwHV4sG9mos/cjab8XlWphvyDW8K9aCrMZcualLPPTvQEd1pqAWu85OyvWmwm3Kr9/eVVmhf6kKKXoAmTOILwPZ/jFbEiOMiLhnzJ5wmCe0+tZGEsG0XvnDvSGLd5u3CQZDrvHu2yJtfnC0yOeZa/t/4wDPs3ib55Kou4q1hZZPiWRuNUNkezI6Bu3lSpbiAox0LaRgLtcxmBd4Gvb9Wec5NVQGa9I6KqiqGEz1IAHuDhMmi/ryhe/SdhB/S8U907hgRrV6wsMo/nFeuIxTDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csSTUHxk9kus29kx/20re5EjDe0H8gxK6rpAED4Di+s=;
 b=cC/L8Nt+BVWHiDjnTl4kJvTRtqO2gn/8rOK0yPC6u94xqJUVOXiFYBDagrZvc+bUkqfPMT8wsnRivwjuGstNFzdrdSv+TSQ3kMzL+bPM0bf5VYF6TYx440G5CELI//62e/QYgoN1Onf/UQ2u9mRlqwVaKcZHREo6cmMbTunERlbJf3Y7p3pbYRHbWMObOzg8OY2zaNaVH2Dpp9hcUUktFNNZCUj6d84FF6GHJycwJp1HrpUApRpvbQ3gXZigyNPpyiNxPpDc79QWFiRqJxT9r5I4xL4S+1bDWy72Q5+Jox0dQves8ZcufuEFedU6YJWAVleRsn0/ZXp+iRrXejufxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csSTUHxk9kus29kx/20re5EjDe0H8gxK6rpAED4Di+s=;
 b=PbrEuND3cSdZFIa391HaILVQ6OTgVVikYxlJ3y9mcyqBYyx57FP4PQ1oNdHwUpuuBgyt5tvKCmeeO1GQGZDosfPhmAOsXq7HlHhXgLsLKNE5B48MYsPoCaKoMxApmSjgVe4qRwmYn/ugawRWBYJ6dBzlNpdEwLgovK5O2aHtzio=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BL3PR04MB8090.namprd04.prod.outlook.com (2603:10b6:208:349::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 11:43:28 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:43:28 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>, Johannes Thumshirn <jth@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] btrfs: replace stripe extents
Thread-Topic: [PATCH v4 1/7] btrfs: replace stripe extents
Thread-Index: AQHazu35BKhoadzCtUipxOmgzcB//7HoxbQAgAP0iQA=
Date: Mon, 8 Jul 2024 11:43:28 +0000
Message-ID: <9d7f7acf-8077-481c-926e-d29b4b90d46f@wdc.com>
References: <20240705-b4-rst-updates-v4-0-f3eed3f2cfad@kernel.org>
 <20240705-b4-rst-updates-v4-1-f3eed3f2cfad@kernel.org>
 <e51d0042-ec10-4a50-bd76-3d3d3cbc9bfc@gmx.com>
In-Reply-To: <e51d0042-ec10-4a50-bd76-3d3d3cbc9bfc@gmx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BL3PR04MB8090:EE_
x-ms-office365-filtering-correlation-id: 2f042aff-3240-4eee-bb03-08dc9f432f62
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VnQ4MFVYM0tkb2RDeWZUNWE5UmlIbUUvaitsYVZid1dJNUJvUEpNVjdoTU9D?=
 =?utf-8?B?Y0pPVXRzcllRUDhUZ0VBMjN3WnllSkNWUTRZTEVXTGFIcER3QXdCMUpGL200?=
 =?utf-8?B?bTR5aFdKVVFWUy80ZzlRMkdhOXBuSnA0VUVuTzY5UDhDOTNmQXRRM2kwOUp2?=
 =?utf-8?B?K0FKOGsrOGJHL3pNMFhGeVo5ZTN1UG9zZU54ZFZmM0R5U1BNMXRCZ2Q3RFp4?=
 =?utf-8?B?MUpMT3o5cnllSW90dXZ2dEZzNFh0blJ3MHEvVW0vc2MxcXJXQnlOSFRuYmRL?=
 =?utf-8?B?bEJUcWZONzV5a1FXWmV0a2s3S2swZDN6WGQxOTgxNUkzaFZFRUFkc1FjUmF3?=
 =?utf-8?B?ZXhWSWlpUVhwVlAvTFpZdTZPTFVzZ2FIK1AzbzlhbEV0L1pVRS9XUkNTNE55?=
 =?utf-8?B?ZzRDRHl3ZG9YN1Jaa29uQ2NNbm9qc0lvMmZ6Q3FiMHdTcVVkaDY4Uk5ITitE?=
 =?utf-8?B?MXRPOFh3aW1HT2ZmeW9OTG5xSEtWREVma1VHa3lPalJUdE10a3dWd2kzN0pk?=
 =?utf-8?B?L0ZsTHFXTmRwUmhweDdKWHB3dkcycUlaSzd6Q05qWlpPdk9mQUVoVmJZVkwz?=
 =?utf-8?B?MHdqS21rUjJ5cFIzSmtZWXo0bEt0d0gzVlFqRVlKNlJGbHVTSk1XNHNtVkVm?=
 =?utf-8?B?Y00zWFFFYlk4Q0FubjdYL2tGOFh1YkQ0aThDL1d4OHJIRkRManpEQXF6cnc3?=
 =?utf-8?B?d3kwS2MrR05KSWNhUWRKd2dZVEd5NjNPdmdFTUpINStUdFZQSEhrV0dyODBn?=
 =?utf-8?B?eXNYVFhLNEhmYmsva0tXbFQ4OXFEYWR5MWkrMEF6Z3N2WmVtbjhRWUJFSU1J?=
 =?utf-8?B?SFlTNTRxM3JrMGhJZlF5Z1hGVXRibzNqL05LOUpTekhCaCszckNwNEd5ZWJW?=
 =?utf-8?B?cTVZQXNEZzRsUVQ0R1hKUlVMZFZhKzUrQ1dnRWlJRWZNaTBoN09GdTE0NENY?=
 =?utf-8?B?aU9WdGJUNThFNUhqOTU1SXo1dFI2SklDbnNKdmxGa1VQZHIrTWsvNXAzZVFB?=
 =?utf-8?B?NlArZkk1ZTdhNmhoZEdQTFk2bXpMS2xqRzcwNnhlcnd5d21UNk16SDFCWUZY?=
 =?utf-8?B?TXJ4b1V1T0poUVRWVmNHYmdpWTBsVUxaYS9KNjdRVlA0TGQ0aVdNUXd0NkRt?=
 =?utf-8?B?KzZ4THVrMWNpVTUySFBNajRzR3pnM2dhbndFYklxUkR6ejhGZ2liSDg2d0Zp?=
 =?utf-8?B?RG4xNTJqeVlwWUZBblZ0MzVwcmJlRUhmK3FWcEhRUDFvYlN5QWRlUXdzYkJS?=
 =?utf-8?B?ZjFuSnEwL2c4dTREd1pCWm9nQ3VTVDB2c0NlU2VHTkFRRUNKWkcvOENndGc5?=
 =?utf-8?B?bkpZQjhPNUsrdEp3REd1Yk9FSi9pL1N2aWNOYlJaU1hVY1U0NHVha0tzSnlk?=
 =?utf-8?B?UDNDU3pNQUZKWWVtRWRsOUI0RVFwQTg4dlEzbEc0a2dPbytUSGtGRmZkTnVS?=
 =?utf-8?B?QlFtS3VRelRXWFkra2ZXSlQ0U2FzNWVieHFlZFJsYlFlYmNDYy9tL016NVRI?=
 =?utf-8?B?T1NqbEFnTTlMdFhCalNFZXk3K3JHc2lBNnpqdmNUd1ZHSVNYZ3JxSDJyL0RQ?=
 =?utf-8?B?TzJVZTNZczJGdksxT1FFSU5ncGx4Y3lYeWJhcVpBS0h3UkNKMndIeVAxcm4w?=
 =?utf-8?B?bTcyb3lGNVNybVdTbHFKWXhBMkZ2UlRLUnFIamRiWUh4Z0wva3FSMm9hMzRa?=
 =?utf-8?B?YVk5VFBaakNhOEppQnJwNW40TWR3Rjd1a0xCdzlIdW5ZZFZORGJMYWtPblZj?=
 =?utf-8?B?M2h5Vm9CRFhEd20yc1F5R0J4SDFGR0lVeXFDaFMrRUZWc3ZHVDVpeit4Y1Uz?=
 =?utf-8?B?L3JmTVpwVjYvZnBmdDQ3RC83MlRrV2VRRG9Fb1VaaVQwYkplWTVqTnZCQTRt?=
 =?utf-8?B?dWhVb1pWbWJDTkVrY3dRQ21GbjBKOG0xZlZOd1Z2UStDT2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmhTcVJrOVczdU4yN0w4dUIxc0dMd1hMRGxPOVJIUWtCZ1E5NVpvcXF5emly?=
 =?utf-8?B?RE9uUmVWNGJBbktyNE1PQW9zdC94Vm9EMDh4TmJCRGZIR2tZcVgremtPQUcz?=
 =?utf-8?B?K1FGVW9TWVRFTWpqWnRLbjMvbUJyOWNJRUNWV2pwRU9MdGRBbTM2Q0d6Tmo4?=
 =?utf-8?B?MGFEeWgybGh3OUw3VUFSTzRvR1ZkenhLTitqak5Lcis4bkFNNGJTL0xBZHB4?=
 =?utf-8?B?WHRQNnNqM1V3b2MyQlZSa1gzWkgwY0pYbGsyb1ltNkRQYTFNTkxqcUdaNHpG?=
 =?utf-8?B?M25DOWsrV1JlNXJCajRVVWxvWWNMU1JnNE1pY1BUaG8vVkIvcm5uckM1T25Z?=
 =?utf-8?B?cmZmS1pubFpLVE4xS0czRmc4Y0EydUNEUXFxQW5wSWNFc2sraUFpTHVuMDFN?=
 =?utf-8?B?Wk11Z1lTWFA2RGVrS21jOUlEZnZOWC91R0l6ZlhTTjkrQnJXeHg1SVJ5Q04v?=
 =?utf-8?B?U3VFR09mTUtPamxZakx5N1lXbG5iQkZjOEt3cDhDS1hDMitFZlp5OC9KSWwy?=
 =?utf-8?B?cHVrTkd5KzBDNGM2cEZESTJJc3M5QmtkbGl0bE1KV2Z2TlNkL0ZxSmdVa29v?=
 =?utf-8?B?UUxQbU1RNlRVd3U5R1BRWWpiMFpZVXVsMGJwcm1PbXlWc25NMHlmc2N1T1Jw?=
 =?utf-8?B?LzFOZHhqTXIrSnVoVTJJL3JMYkNPMUdaYjduQU1zVUxSU2daQ0FFVFV3MEdX?=
 =?utf-8?B?RENoMFJ6bDJBVk1xbTdGYWxhaXlDd29XZk1YdEZIZldJdDJnQ1Q5NDlDM0Mr?=
 =?utf-8?B?VzFaeXY3a21HU3Z5djlGQUZyY0VTU1FnMjZMUWg2REoydmJmZlkvVytTWUZF?=
 =?utf-8?B?TTNTVTgyRkU2NVNabGVhWXh6Vnl5Q3J2T2hmY0lweUlvYWxQbzEzYWpKUllI?=
 =?utf-8?B?UXQwNXJhWWtWQkV6K2k4SlN3VVdvei9ndW5hWmJjR01hbUd0UXpvem9zb1ZB?=
 =?utf-8?B?d0ZEall1ak83S3U4Y2M2UXUwS3NqQU9Sb1BqbmhYRS9XbjY4S1dsY1pUN0VR?=
 =?utf-8?B?VXNFNFh6TCtoUnZqeUFpTW1xazh6ZjJzT21tM2RpOVhJZkNxdUIyRzBGcFl4?=
 =?utf-8?B?TXRmUGNoamFsVmhkdklvNlpYcWhzcVJObGpJWmNFRk1iN2U4OFNCSVdnQ0pR?=
 =?utf-8?B?UHE1ZzVMd2NtdlhzUU03MXQ2ZHkvUnBGV284ZEpXZm8rRW85OElKM2Jwdkt1?=
 =?utf-8?B?dzl4bXNpS3R4dFZLOVNnMDNNbjZ5WVUwTUt3cnBQWVRRdTVIeG5xelp1YWg2?=
 =?utf-8?B?eVdIalN4QWV3UnV2UDd0WEVlZUpOSmppVGhiM2VMVkhJMzdvMVkrc204NEJs?=
 =?utf-8?B?Z0x4UkJkRCt1bER4UERoSWtETjBnMGdKVlR4NlAvcytVOFFKSU90RElJeDgv?=
 =?utf-8?B?OGdlcnRjSXB4b0FsbEJpV2Q1RWwreER3c0N6bnFoblpBekdPRzNkMEZTNndH?=
 =?utf-8?B?akROaWJ4STF0YjR5U2hTTW51OGtNdjdkT3lCbDkxN05qRW9ISEljQzFuNzVl?=
 =?utf-8?B?U3JMSm16bUJiNll3c2gxZlpNQXUrS1VtSEZiWGZFdFFjRHE3emhUV0hnVlQ5?=
 =?utf-8?B?a0pHejFRbk9QY2ZTZDNOY0tremoza3haWElpY2ZiclhldVBSUVlMTVVieVpZ?=
 =?utf-8?B?ckNnQ3VXb3RTS09BblZjNlZLQ0xQejkwSytoTmRrQzJJeE15YWZXUXpzSVdR?=
 =?utf-8?B?eGV3M1JLMWhZb1VZTS9KTXB5a2krVnlNbmFuYkUxNUNRbXVGUFJKRmpkbkE4?=
 =?utf-8?B?ZVBRbFQwZjJwcE1UdTFoQlg5ZlB4SHdrL0xFUTJOT2pzTjVYOUM1cnJQTzRy?=
 =?utf-8?B?UkVwOXpValljMWdqb05HemF0bkdxS1Y2ZmlXWDM2ZUxTb2kvY0lSVS96MTl4?=
 =?utf-8?B?VE5HbUduRTZ2dDFPQm5uNFR1L2RBV3REbDZ2d1l3eTRsbmVXd2FqOGpJYlp0?=
 =?utf-8?B?cHBjTUw2dlFrdk5DbExpV3FaQ09nbWt1bDJqemFxeGVtNFhPeHZ3ZERaeEdi?=
 =?utf-8?B?ZVlzdVViRU5pU1BUcjZXV1QxQmxnMXFOKzlWUTFDTXNmZlpDQ3d4dDVWUWRO?=
 =?utf-8?B?RGZSVy8xbkc4M0Rob1NNb042SW9OMk1QOWhGSzgxazdKTkRwUElxYWt0QkpQ?=
 =?utf-8?B?cUltcTRxRnpJRmQ0TW1FWWJhakY2cUpra1EvN0JmZFdTcnVraGZJSElRemxu?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46F36D6C24107A43A84F4317A0298E46@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ixYtWWVS3onosejR9ZKrwj3Gu++6NnJ4Ve4HDX0R0wp/zMoSCtWc3YfqKl3tad8yzUx7uCW1MraDy2/hkkYs8r601KieUy3i8F/slLkZDS0X4J4wTbeK7W1Yru4d6MuiqpICKcncADF05OXwi98AvLOCvezGLqQ+HGeA2iES9BZU/AEleoJK8x/7rOXiEt1Z5T1x6251wTaeC3X1Qo/eYP5mkn7FG2nxWoHUq5ZKaLcN8l2n5VbgC2v8ilYn2C5+azBRIg5r8Ug6H+hyQ2Tljm2vzf3RYHocuen20M8DZ+rcsEB563eRzEBD/n4Q26NWJZQQhO5f7Pwx7+MJjo5gzd+TTkaEFm1PJoqwX6j0qfjDx3GSSCbp560b3NKsgTPvFi0P7sXY2TmMBkdllvut3UHdi2o7sUlQQyDouacmzUjoLclxyW3SGjSPzvv7mTg7NkBZYDW3h5pPoF14nez9uUE4SdWBB+OUH3fUkV+W7lmJbkcc851o+GSS5ek+UcHllT+H0vH7E4U3MtselGTp6uSdkM6s+aUmCReeZUkUAEFTHfUX4UAiYQub16iCdfI4zXXqia2rYZ0RS7+FeFHJjEocRcIItJj03SyZHoSfhXh+qJm85grARnJbCJTQsGQg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f042aff-3240-4eee-bb03-08dc9f432f62
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 11:43:28.6008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBls8u8r+EGDt+M4CWo8s0k07+l/o0uvDK5oqXNkufCFeW67fJKxN/ucsRrZmFnr5KmJlCJl2QOxC/x7DFdVwUM7ExAdkX4uGxX67TJ7WWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8090

T24gMDYuMDcuMjQgMDE6MTksIFF1IFdlbnJ1byB3cm90ZToNCj4gDQo+IA0KPiDlnKggMjAyNC83
LzYgMDA6NDMsIEpvaGFubmVzIFRodW1zaGlybiDlhpnpgZM6DQo+PiBGcm9tOiBKb2hhbm5lcyBU
aHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0KPj4NCj4+IElmIHdlIGNhbid0
IGluc2VydCBhIHN0cmlwZSBleHRlbnQgaW4gdGhlIFJBSUQgc3RyaXBlIHRyZWUsIGJlY2F1c2UN
Cj4+IHRoZSBrZXkgdGhhdCBwb2ludHMgdG8gdGhlIHNwZWNpZmljIHBvc2l0aW9uIGluIHRoZSBz
dHJpcGUgdHJlZSBpcw0KPj4gYWxyZWFkeSBleGlzdGluZywgd2UgaGF2ZSB0byByZW1vdmUgdGhl
IGl0ZW0gYW5kIHRoZW4gcmVwbGFjZSBpdCBieSBhDQo+PiBuZXcgaXRlbS4NCj4+DQo+PiBUaGlz
IGNhbiBoYXBwZW4gZm9yIGV4YW1wbGUgb24gZGV2aWNlIHJlcGxhY2Ugb3BlcmF0aW9ucy4NCj4g
DQo+IEluIHRoYXQgY2FzZSwgY2FuIHdlIGp1c3QgbW9kaWZ5IHRoZSB0YXJnZXRlZCBkZXYgc3Ry
aXBlPw0KPiANCj4gT3IgZG8gd2UgaGF2ZSBvdGhlciBjYWxsIHNpdGVzIHRoYXQgY2FuIGxlYWQg
dG8gc3VjaCBjb25mbGljdHM/DQo+IA0KPiBBcyBJJ20gbm90IHRoYXQgY29uZmlkZW50IGlmIHN1
Y2ggcmVwbGFjZSBiZWhhdmlvciB3b3VsZCBtYXNrIHNvbWUgcmVhbA0KPiBwcm9ibGVtcy4NCg0K
SSd2ZSBqdXN0IHRlc3RlZCB0aGUgZm9sbG93aW5nIHBhdGNoIGFuZCBpdCBsb29rcyBsaWtlIGl0
J3Mgd29ya2luZzoNCg0KDQpkaWZmIC0tZ2l0IGEvZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5j
IGIvZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jDQppbmRleCBlNmY3YTIzNGI4ZjYuLjdiZmQ4
NjU0YzExMCAxMDA2NDQNCi0tLSBhL2ZzL2J0cmZzL3JhaWQtc3RyaXBlLXRyZWUuYw0KKysrIGIv
ZnMvYnRyZnMvcmFpZC1zdHJpcGUtdHJlZS5jDQpAQCAtNzMsNiArNzMsNTMgQEAgaW50IGJ0cmZz
X2RlbGV0ZV9yYWlkX2V4dGVudChzdHJ1Y3QgDQpidHJmc190cmFuc19oYW5kbGUgKnRyYW5zLCB1
NjQgc3RhcnQsIHU2NCBsZQ0KICAgICAgICAgcmV0dXJuIHJldDsNCiAgfQ0KDQorc3RhdGljIGlu
dCB1cGRhdGVfcmFpZF9leHRlbnRfaXRlbShzdHJ1Y3QgYnRyZnNfdHJhbnNfaGFuZGxlICp0cmFu
cywNCisJCQkJICAgc3RydWN0IGJ0cmZzX2tleSAqa2V5LA0KKwkJCQkgICBzdHJ1Y3QgYnRyZnNf
aW9fY29udGV4dCAqYmlvYykNCit7DQorCXN0cnVjdCBidHJmc19wYXRoICpwYXRoOw0KKwlzdHJ1
Y3QgZXh0ZW50X2J1ZmZlciAqbGVhZjsNCisJc3RydWN0IGJ0cmZzX3N0cmlwZV9leHRlbnQgKnN0
cmlwZV9leHRlbnQ7DQorCWludCBudW1fc3RyaXBlczsNCisJaW50IHJldDsNCisJaW50IHNsb3Q7
DQorDQorCXBhdGggPSBidHJmc19hbGxvY19wYXRoKCk7DQorCWlmICghcGF0aCkNCisJCXJldHVy
biAtRU5PTUVNOw0KKw0KKwlyZXQgPSBidHJmc19zZWFyY2hfc2xvdCh0cmFucywgdHJhbnMtPmZz
X2luZm8tPnN0cmlwZV9yb290LCBrZXksIHBhdGgsDQorCQkJCTAsIDEpOw0KKwlpZiAocmV0KQ0K
KwkJcmV0dXJuIHJldCA9PSAxID8gcmV0IDogLUVJTlZBTDsNCisNCisJbGVhZiA9IHBhdGgtPm5v
ZGVzWzBdOw0KKwlzbG90ID0gcGF0aC0+c2xvdHNbMF07DQorDQorCWJ0cmZzX2l0ZW1fa2V5X3Rv
X2NwdShsZWFmLCBrZXksIHNsb3QpOw0KKwludW1fc3RyaXBlcyA9IGJ0cmZzX251bV9yYWlkX3N0
cmlwZXMoYnRyZnNfaXRlbV9zaXplKGxlYWYsIHNsb3QpKTsNCisJc3RyaXBlX2V4dGVudCA9IGJ0
cmZzX2l0ZW1fcHRyKGxlYWYsIHNsb3QsIHN0cnVjdCBidHJmc19zdHJpcGVfZXh0ZW50KTsNCisN
CisJZm9yIChpbnQgaSA9IDA7IGkgPCBudW1fc3RyaXBlczsgaSsrKSB7DQorCQl1NjQgZGV2aWQg
PSBiaW9jLT5zdHJpcGVzW2ldLmRldi0+ZGV2aWQ7DQorCQl1NjQgcGh5c2ljYWwgPSBiaW9jLT5z
dHJpcGVzW2ldLnBoeXNpY2FsOw0KKwkJdTY0IGxlbmd0aCA9IGJpb2MtPnN0cmlwZXNbaV0ubGVu
Z3RoOw0KKwkJc3RydWN0IGJ0cmZzX3JhaWRfc3RyaWRlICpyYWlkX3N0cmlkZSA9DQorCQkJJnN0
cmlwZV9leHRlbnQtPnN0cmlkZXNbaV07DQorDQorCQlpZiAobGVuZ3RoID09IDApDQorCQkJbGVu
Z3RoID0gYmlvYy0+c2l6ZTsNCisNCisJCWJ0cmZzX3NldF9yYWlkX3N0cmlkZV9kZXZpZChsZWFm
LCByYWlkX3N0cmlkZSwgZGV2aWQpOw0KKwkJYnRyZnNfc2V0X3JhaWRfc3RyaWRlX3BoeXNpY2Fs
KGxlYWYsIHJhaWRfc3RyaWRlLCBwaHlzaWNhbCk7DQorCX0NCisNCisJYnRyZnNfbWFya19idWZm
ZXJfZGlydHkodHJhbnMsIGxlYWYpOw0KKwlidHJmc19mcmVlX3BhdGgocGF0aCk7DQorDQorCXJl
dHVybiByZXQ7DQorfQ0KKw0KICBzdGF0aWMgaW50IGJ0cmZzX2luc2VydF9vbmVfcmFpZF9leHRl
bnQoc3RydWN0IGJ0cmZzX3RyYW5zX2hhbmRsZSAqdHJhbnMsDQoJCQkJCXN0cnVjdCBidHJmc19p
b19jb250ZXh0ICpiaW9jKQ0KICB7DQpAQCAtMTEyLDYgKzE1OSw4IEBAIHN0YXRpYyBpbnQgYnRy
ZnNfaW5zZXJ0X29uZV9yYWlkX2V4dGVudChzdHJ1Y3QgDQpidHJmc190cmFuc19oYW5kbGUgKnRy
YW5zLA0KDQoJcmV0ID0gYnRyZnNfaW5zZXJ0X2l0ZW0odHJhbnMsIHN0cmlwZV9yb290LCAmc3Ry
aXBlX2tleSwgc3RyaXBlX2V4dGVudCwNCgkJCQlpdGVtX3NpemUpOw0KKwlpZiAocmV0ID09IC1F
RVhJU1QpDQorCQlyZXQgPSB1cGRhdGVfcmFpZF9leHRlbnRfaXRlbSh0cmFucywgJnN0cmlwZV9r
ZXksIGJpb2MpOw0KCWlmIChyZXQpDQoJCWJ0cmZzX2Fib3J0X3RyYW5zYWN0aW9uKHRyYW5zLCBy
ZXQpOw0KDQo=

