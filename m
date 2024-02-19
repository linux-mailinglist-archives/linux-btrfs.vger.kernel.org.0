Return-Path: <linux-btrfs+bounces-2480-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A838859BCE
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 07:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9B9282894
	for <lists+linux-btrfs@lfdr.de>; Mon, 19 Feb 2024 06:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FACD20323;
	Mon, 19 Feb 2024 06:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="V2Ea9pqr";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="tslEsk2V"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A881E514;
	Mon, 19 Feb 2024 06:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708322633; cv=fail; b=n+8vgcV3DuySKujm16NyVc0CwK0OLmljat3jW/sJeKxwoUw+CS11FJmyfl/gaDEz8CVbYdXZq3LpjY64dAXDSFdPCNd3vMH0wjEQBMy++pZOIsk0xCTJT9bfGiDtHZ64VQV0UVKTJWbGupgxNVr+eBEVVX6L+QurTGE+ykAxPCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708322633; c=relaxed/simple;
	bh=8ehrkgoRC+LPljRDx18sxh7Rl7Oc6AnujyTcCvvsdh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EE8fO4KcKOum4qP+pIgYI1biyqHv+uTA24YWDrBXwkY/AU+k16CdVM2KOs1/5oDfp458jsvmNhcSgmWRfG52sEY7hpuesV1vqH/NO7kliGo2rPHJ63YMyXTtudVjwOw4ANpmgyC4qTQvCQnForqjbpjvBc9Lue68zK7IRp039m0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=V2Ea9pqr; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=tslEsk2V; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708322629; x=1739858629;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=8ehrkgoRC+LPljRDx18sxh7Rl7Oc6AnujyTcCvvsdh8=;
  b=V2Ea9pqrn9K6vVsQLZltgK3mvLI/3wuvpojcmHYMzAlmbVy+KL1I5bEQ
   1Z+S95CYSMjwvuQ+WGx4xeqlQ8CUGHDlTS3fp36mq9G4Fl8ZhhcFxz1/z
   4FVhbkuH8I9+HeBNh5o+91/46i4EbRquR+OCcPo1TTGGzVw7Wwt8SRYVo
   gUAUEylIiDpEBXGO/iTHWLgwAKw4cVJvfhNQqZePy94hoQZgHH5jOJRhk
   gmVHjLerBVFSNDy8ztThhHIiYt7rnAl4rlLnfU9Ab86CD499Zisk6aem9
   PTYLwC97+rSx61XwEsKHh7pxJ4NGcKZMNXbAjnSjco8YcGtl4mWDVE80T
   w==;
X-CSE-ConnectionGUID: EgwZ8JvQRueIWFCXptG+nw==
X-CSE-MsgGUID: mQqPY0U5RrCYenP850lPiw==
X-IronPort-AV: E=Sophos;i="6.06,170,1705334400"; 
   d="scan'208";a="9846706"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 19 Feb 2024 14:03:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4LLRPzus1z9PU9Cxf/FPERqMcj4DwhnMakb/xo0esQGbCs0iLq75bhyNFJSvWvzaUjF17zy6EImmPOkDJNjGLh9UDtsXP/oXhsPhNofL+vHr5JNK2Z+iY2maj7n4SBUq6QRN78kC3f507MKnjzff1dVtQQIVHB/3e6xf61FsECvbx3MdhKAyJ3fs5z4Y9r6cQRufnJFoLYyvIobBDhQZ5oQsbj+n4xq6D5og2PJD6SFlp6FQhA4EOOH0BcSJwX69iU6ZNZo8bNpV0zD0GNN+EH2VeVLJzJm39tKDxifK1UKdGTStc1/J22A3F8ILwU5dugw3QAg7wIvbH6rrWyZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ae8ynG6upghRRj5zw9s907egMQJH6MUvfGgg+TN5mrY=;
 b=liFtnLSwsrBev9KxbKhg0nV7VGXdUUBd4yArrk+ixHWfOut4HDA51ykgjrz30QNpxNTq66GeXYKcAk6o1m+SuQ62Feizr06plBybkJzll3B0slRzg7+daX+kKPDoauHTUGCq1cqkKgoMXnYSIpIXei8zkafNdKtvlLgzIjjA7BJltE2XVxeuxMFf46dTk78ofrZ0Ah+HCZuu+5v99brLvHljI+4awjulnbE/phjMMBsJOHnhqnHXKq7Kv3KSBeEf+dMLqsJmS5u7R5Q+XZt0OfdxXpJRIZmTCr9TbqeCLVoHejiEFjFpmlGqapgsirCsb/dZwhuNcAojVRBSUbvGJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ae8ynG6upghRRj5zw9s907egMQJH6MUvfGgg+TN5mrY=;
 b=tslEsk2VzIxndo6n16pFx18QYh0X7qdwb0MWW2HbIg5mlVwyaTTnhYoRTtbG6CQJ9QWWwTSIkMkE1IYApGINOZ0QzGs7ILmt4B9BdO0N30Cib6HYsg7sWKe3X67fL2Rst0bJHcsylSJRVpYdwKHf32A2HPvlpoHTVwePxEyNmx4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by PH7PR04MB8999.namprd04.prod.outlook.com (2603:10b6:510:2f2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Mon, 19 Feb
 2024 06:03:40 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::6c12:a7ce:2b9c:69bf%7]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 06:03:39 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 0/5] btrfs: zoned: remove extent_buffer redirtying
Thread-Topic: [PATCH v2 0/5] btrfs: zoned: remove extent_buffer redirtying
Thread-Index: AQHaHiRcHt5FVMa7y0ylod/KaDqAJrERtnkA
Date: Mon, 19 Feb 2024 06:03:39 +0000
Message-ID: <oadvdekkturysgfgi4qzuemd57zudeasynswurjxw3ocdfsef6@sjyufeugh63f>
References: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
In-Reply-To: <20231123-josef-generic-163-v2-0-ed1a79a8e51e@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|PH7PR04MB8999:EE_
x-ms-office365-filtering-correlation-id: 4fc10d83-7e8a-434d-5d14-08dc311084e7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7D0g5yXeobJKZzcZG/uUMwTwTjGJAeKl6nGKkRHuGVsA4rFFc8oacYiV7PloJv5IwmnNoyKtZcibl4xMfxMGjlXGr2hKIQrWWAMfkQu0cTr8I5ZloBFO/gYRiIsCdAuRczIhzNchmci7fBtU6A8kPAk1tiDCGu+RmFXYb4p55tgYRHuLglyHSeXVt83QBKBQKFVNFtPKaSaht9weWjSTpQM7HJ+X2oxnME0Pu09rvVyFM9tZi8C3PCx7ZyWTloJ31cb7tVFUwCBulUxttM9iVXjzkhenrI+OHKpO5trsz5Luof1QgY7d73B08T6myrq0qve+GUJsNcfy49/ettXhPC7c+iFVAgQfyc+WOZk8sToJG8gEHNrU65iJVCuD6FavEOTHec4wEaF8qsfDGCkrDdJbPA1goYSs5bpHdhk8SoGI9U31qtkgDDhNjMzBK5FOgquh7ad5+aVlQg+cdvEaHXMgcyfTuVV4YWaulDKr6hNZPGFvcbQ0TcVZXQVXVZhJYryOWK+S9CoroDtubehz0EzSFaTZlJT1ZCvFbEjc/4G9putyqc+9Lobu2MHDLD5vLGZUXZ1dkRxgumusJxNZ/XgPud+jCt5ouIJaPezMVds7J5Wzk8DDrKlz9asDeBb+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(82960400001)(86362001)(122000001)(6486002)(6512007)(6506007)(316002)(9686003)(6636002)(54906003)(478600001)(71200400001)(45080400002)(41300700001)(83380400001)(26005)(38070700009)(38100700002)(33716001)(4326008)(6862004)(66476007)(66446008)(64756008)(8936002)(8676002)(66556008)(30864003)(76116006)(66946007)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2L65KjopiSky2B58St+dt8BrACPsnIbIRCjZbRm2yFVRs7Zg6lBjPVVhDCEH?=
 =?us-ascii?Q?k3fK5EjPiOVU1s+PpqRiZku6/4/1u9Vxux9PlYe9teKXaI0wUb7P/7nBnGen?=
 =?us-ascii?Q?JcOvejtPYN4MzyLqE+pKnR3MB7Q1mMudmrr9afGpS74bgc8dNo1oc6i5p/Ki?=
 =?us-ascii?Q?X5rw2AA9R5HHpgACon2w2twYhxEaOmcRAnawnGz7d/S1/RiK0QdUCZkbAs4v?=
 =?us-ascii?Q?YUuqZLy0noOyZ5t4+LlGb/klQZn92Owsm9ns79HyCxiGj/PGW4EVnr8hdLXl?=
 =?us-ascii?Q?kK36Fhm5yRB7BZOPT8LdnduX/hFAAnVW2FizZO5AIyvkTmkhMIcEhgYcXVMB?=
 =?us-ascii?Q?1nOIyFvZX+HtxQkv5yeGw8Znh8+8PLSQv+U/CMDjThnEHAv+pnf3IuiZIkeI?=
 =?us-ascii?Q?kC2KYYHkKjFRyjMZiQM6P2NCwZhKo2bS1hT1YSWGLkMrv6o9qyogdZoNYHWA?=
 =?us-ascii?Q?Em/3Cx0zJV/SAA5ayRoskk/VBna5Oe8jU7eC3MyakNh+2LYI84Sq6J3ynGTd?=
 =?us-ascii?Q?h0TWuMPmoYYVh/trxpzq3xVuSO4BDOyoLg3tVc05jabsQGMrpbbZ8ja+C59f?=
 =?us-ascii?Q?ZNDKPJu9AUHeTAsLmEWy1bml/JTR3WY3JNxxTyfzIMQEImzVnNfaBn/MaG8S?=
 =?us-ascii?Q?ynuxly8Je0nv4jF7+FmCUAflcVYDadcjjv17klzse3HV+EjDQtu757Abrwk9?=
 =?us-ascii?Q?xZdmxFpF8vhCFWuETQHDaEyC0tbKBubFSyLG5XzrW5F8TDtZesyyDOOrZUrj?=
 =?us-ascii?Q?k6ecyQIJrgHYWHpEHLn1VZ6Tn2xbyyId+asQsgO0z62UqWDsMYbGkN5Oxv05?=
 =?us-ascii?Q?F3GtjSBcZmZrQsExQS3hTczohx8XFTlMpxn6A9gFZsGiDBYK0xpQR5Neb7yP?=
 =?us-ascii?Q?UYwuJdBVnGAhpNN63E2BIFaW1oX89vaTS5CKc6IWV6+Y7UzAl9tSX0Y802CG?=
 =?us-ascii?Q?f2GuvhIKJcCGIzxR9u6x5O2KnLmhscbBnXr7Sev7YiJqkj1hCRsrVe+bRj+z?=
 =?us-ascii?Q?+8VLLW+cdJqKh/XLw2IR2bLO4fAiAppCUr2y88kHNhX99b/7asWi7/6DAY3z?=
 =?us-ascii?Q?8Bpgd5FSXkUX3O9rQ66Z+ufYKXbTzH0e1BZP52K6JTCR6REwk1wap7IatCPS?=
 =?us-ascii?Q?tW9y1zpdXUUQ4CECiP7/bmJcGm1UxdTmyjD6bUY8uiXtgoI3FcdGvmBZSaly?=
 =?us-ascii?Q?g6PuwQK1EMurWZ0eqYcFjVZU6xVV7vbETv3G9pUVbQymmGLdXDwSn/HB2VJN?=
 =?us-ascii?Q?WxRclep3gGLui0IeLl+pjmevATRV8Wf4U7GLmB3FS+83JYkFZqycNIsl146+?=
 =?us-ascii?Q?kMPByhUwXCGduMJdPo5tTS1neurFAMMVRcRUuVMutijPjoIlcAp9nA7obD9s?=
 =?us-ascii?Q?Tm8Q7pnUd6e19ZMkrTKIRhADAoeKoBzGWcgmofhyhN2cvZY82aend9F3vRlB?=
 =?us-ascii?Q?GiDFQiyeyUjBByGPGIVujz84veIwkbXZ6w7mYWL3Qn6vfCNnlZaP2ao/rZvY?=
 =?us-ascii?Q?0rFp73d4KVwYSaLG+kvZAXv1Boyelmip+uHbAiK3uATkzdxdL9WQFFZ84ags?=
 =?us-ascii?Q?UC9RbpXC4WzM8nbrWBVEM930ghxH/bSr5GO0f+o26ONdkQd2tUyEJPjVETl+?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3B9AF8D2872634097F364D2CBF16540@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	d+c8F2BzkWpj8tDubIeCsSAeMmK9gkeWvnY20gRNGAGCWkCMQPsNbbxepJl1kPlihIuag174Nvfn9ZkTdMY2lO3GUu9urxw6D4J6JuhvJiZvu9Pqr5bAismWO3/8KyIy0nwSoRdPdWxx7uh+ztwW2eJkodz+2tuqK+dul0IFXMIj5pWqSywwiBDzPWaAYRBUJ8d5zQMWKfDX9EfAodEKEPSQBRf0hRRIyC9xlGR9vAWCJK7zjMEewgHosUKVWDdm6so5jJC3/t7uKxauqf9DOGePoFnjJPvZrp5Ok2VY4pLkEZKVI35sV2lmB+dELHuL0Rw3+9IuoE1vpuD7GS36yD3PZZuyZsMptqk0qEsu7nxootsh+1DJC5FwYb0iqoJOAhZ9usuvxFLdOuTAHNpHsz0tsW8x9eBEpQjfLSRSi5vP12a3J9QzZLa02g0KJI1UMI0+luUj2Mm8XadXQqoN/rQSoGVNdbhdBPFreQsUiqk54ZAeI3eQ0zDU+5x+30eo3105DPWusvaagchIuQtvearJ2S9MDr0DNKOq+7VJR25Xldas4lwNlgbqD8anZyKjC2uTTceXdB1qrSengh1+Bm/2uUd+xLQ/iWxmhhxnH+A3I4rJfV9b8lnxSYPq7PSy
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fc10d83-7e8a-434d-5d14-08dc311084e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 06:03:39.8469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZLJRwc4cfuEw9wHlPGBWKuBGIwfUNV7pCbqgFCjId5CeFngl6KIrWjrpqQpb5JAMIC9yJIAHI9cvEHwnM7L4/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8999

On Thu, Nov 23, 2023 at 07:47:14AM -0800, Johannes Thumshirn wrote:
> Since the beginning of zoned mode, I've promised Josef to get rid of the
> extent_buffer redirtying, but never actually got around to doing so.
>=20
> Then 2 weeks ago our CI has hit an ASSERT() in this area and I started to=
 look
> into it again. After some discussion with Christoph we came to the conclu=
sion
> to finally take the time and get rid of the extent_buffer redirtying once=
 and
> for all.
>=20
> Patch one renames EXTENT_BUFFER_NO_CHECK into EXTENT_BUFFER_ZONED_ZEROOUT=
,
> because this fits the new model somewhat better.
>=20
> Number two sets the cancel bit instead of clearing the dirty bit from a z=
oned
> extent_buffer.
>=20
> Number three removes the last remaining bits of btrfs_redirty_list_add().
>=20
> The last two patches in this series are just trivial cleanups I came acro=
ss
> while looking at the code.
>=20
> ---

Hello,

[SUMMARY]

With this series applied, running generic/013 200 times hits a
"__btrfs_free_extent:3251: errno=3D-117 Filesystem corrupted" error. I
investigated the issue and found a workaround patch. But, I'm still not
sure what is going on in the background. So, that patch might not address
the root cause.

[How it fails]

It fails with the following backtrace and error prints. It failed because
it cannot find a corresponding METADATA_ITEM for a delayed reference item.

It is interesting that the ref is trying to find "byte nr 66948939776
parent 66948939776 root 5 owner 0", but only finds "(66948939776 169 1)",
with the same bytenr and the same root, but different level. And, it fails
like this all the time. It sees the same bytenr but different level (1 !=3D
0).

Also, note that at this point, the extent buffer had no contents (filled
with zero).

    Feb 17 17:25:43 kernel: BTRFS info (device nvme1n2): host-managed zoned=
 block device /dev/nvme1n2, 1844 zones of 2147483648 bytes
    Feb 17 17:25:43 kernel: BTRFS info (device nvme1n2): zoned: async disca=
rd ignored and disabled for zoned mode
    Feb 17 17:25:43 kernel: BTRFS info (device nvme1n2): zoned mode enabled=
 with zone size 2147483648
    Feb 17 17:25:45 kernel: ------------[ cut here ]------------
    Feb 17 17:25:45 kernel: WARNING: CPU: 9 PID: 29834 at fs/btrfs/extent-t=
ree.c:3248 __btrfs_free_extent.isra.0+0x604/0x1330 [btrfs]
    Feb 17 17:25:45 kernel: Modules linked in: dm_flakey algif_hash af_alg =
xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_na=
t nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_=
tables br_netfilter bridge stp llc overlay sunrpc kvm_amd kvm irqbypass rap=
l acpi_cpufreq ipmi_ssif i2c_piix4 k10temp btrfs ipmi_si blake2b_generic ip=
mi_devintf xor ipmi_msghandler raid6_pq bfq loop dm_mod zram bnxt_en ccp pk=
cs8_key_parser asn1_decoder public_key oid_registry fuse msr ipv6
    Feb 17 17:25:45 kernel: CPU: 9 PID: 29834 Comm: fsstress Not tainted 6.=
8.0-rc4-BTRFS-ZNS+ #403
    Feb 17 17:25:45 kernel: Hardware name: Supermicro Super Server/H12SSL-N=
T, BIOS 2.0 02/22/2021
    Feb 17 17:25:45 kernel: RIP: 0010:__btrfs_free_extent.isra.0+0x604/0x13=
30 [btrfs]
    Feb 17 17:25:45 kernel: Code: 8b 3f e8 bf 69 00 00 48 8b 7d 60 45 8b 4f=
 40 49 89 d8 8b 54 24 40 4c 89 e9 48 c7 c6 30 64 65 a0 e8 61 fb 0d 00 e9 8f=
 fd ff ff <0f> 0b f0 48 0f ba 28 02 41 b8 00 00 00 00 0f 83 86 04 00 00 b9 =
8b
    Feb 17 17:25:45 kernel: RSP: 0018:ffffc900090cfb80 EFLAGS: 00010246
    Feb 17 17:25:45 kernel: RAX: ffff888365c719d8 RBX: 0000000f9677c000 RCX=
: 0000000000000001
    Feb 17 17:25:45 kernel: RDX: 0000000000000000 RSI: 0000000000000002 RDI=
: 0000000000000000
    Feb 17 17:25:45 kernel: RBP: ffff8889a044b220 R08: 0000000000000000 R09=
: 0000000000000004
    Feb 17 17:25:45 kernel: R10: 0000000000000000 R11: 00000000ffffffff R12=
: 0000000000000001
    Feb 17 17:25:45 kernel: R13: ffff888ad87a4c98 R14: 0000000000000005 R15=
: ffff888a0c7d2a80
    Feb 17 17:25:45 kernel: FS:  00007f823f5f7740(0000) GS:ffff889fcea40000=
(0000) knlGS:0000000000000000
    Feb 17 17:25:45 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
    Feb 17 17:25:45 kernel: CR2: 0000560ce0610b38 CR3: 0000000a907ec000 CR4=
: 0000000000350ef0
    Feb 17 17:25:45 kernel: Call Trace:
    Feb 17 17:25:45 kernel:  <TASK>
    Feb 17 17:25:46 kernel:  ? __btrfs_free_extent.isra.0+0x604/0x1330 [btr=
fs]
    Feb 17 17:25:46 kernel:  ? __warn+0x81/0x170
    Feb 17 17:25:46 kernel:  ? __btrfs_free_extent.isra.0+0x604/0x1330 [btr=
fs]
    Feb 17 17:25:46 kernel:  ? report_bug+0x18d/0x1c0
    Feb 17 17:25:46 kernel:  ? handle_bug+0x3c/0x70
    Feb 17 17:25:46 kernel:  ? exc_invalid_op+0x13/0x60
    Feb 17 17:25:46 kernel:  ? asm_exc_invalid_op+0x16/0x20
    Feb 17 17:25:46 kernel:  ? __btrfs_free_extent.isra.0+0x604/0x1330 [btr=
fs]
    Feb 17 17:25:46 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:46 kernel:  ? rcu_is_watching+0xd/0x40
    Feb 17 17:25:46 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:46 kernel:  ? lock_release+0x1e5/0x280
    Feb 17 17:25:46 kernel:  __btrfs_run_delayed_refs+0x64c/0x1380 [btrfs]
    Feb 17 17:25:46 kernel:  ? btrfs_commit_transaction+0x3e/0x12d0 [btrfs]
    Feb 17 17:25:46 kernel:  btrfs_run_delayed_refs+0x92/0x130 [btrfs]
    Feb 17 17:25:46 kernel:  btrfs_commit_transaction+0xa2/0x12d0 [btrfs]
    Feb 17 17:25:46 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:46 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:46 kernel:  ? rcu_is_watching+0xd/0x40
    Feb 17 17:25:46 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:46 kernel:  ? lock_release+0x1e5/0x280
    Feb 17 17:25:46 kernel:  btrfs_sync_file+0x532/0x660 [btrfs]
    Feb 17 17:25:46 kernel:  __x64_sys_fsync+0x37/0x60
    Feb 17 17:25:46 kernel:  do_syscall_64+0x79/0x1a0
    Feb 17 17:25:46 kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0x76
    Feb 17 17:25:46 kernel: RIP: 0033:0x7f823f6f8400
    Feb 17 17:25:46 kernel: Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d e1 d1 0d 00 00 74 17 b8 4a 00 00=
 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 =
7c
    Feb 17 17:25:46 kernel: RSP: 002b:00007ffe3c26e9f8 EFLAGS: 00000202 ORI=
G_RAX: 000000000000004a
    Feb 17 17:25:46 kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX=
: 00007f823f6f8400
    Feb 17 17:25:46 kernel: RDX: 0000000000000193 RSI: 0000560cdfcdb048 RDI=
: 0000000000000003
    Feb 17 17:25:46 kernel: RBP: 00000000000002e6 R08: 0000000000000007 R09=
: 00007ffe3c26ea0c
    Feb 17 17:25:46 kernel: R10: 0000000000000000 R11: 0000000000000202 R12=
: 00007ffe3c26ea10
    Feb 17 17:25:46 kernel: R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15=
: 0000560cdfcd7180
    Feb 17 17:25:46 kernel:  </TASK>
    Feb 17 17:25:46 kernel: irq event stamp: 0
    Feb 17 17:25:46 kernel: hardirqs last  enabled at (0): [<00000000000000=
00>] 0x0
    Feb 17 17:25:46 kernel: hardirqs last disabled at (0): [<ffffffff810e5e=
0e>] copy_process+0xb0e/0x1e00
    Feb 17 17:25:46 kernel: softirqs last  enabled at (0): [<ffffffff810e5e=
0e>] copy_process+0xb0e/0x1e00
    Feb 17 17:25:46 kernel: softirqs last disabled at (0): [<00000000000000=
00>] 0x0
    Feb 17 17:25:46 kernel: ---[ end trace 0000000000000000 ]---
    Feb 17 17:25:46 kernel: ------------[ cut here ]------------
    Feb 17 17:25:46 kernel: BTRFS: Transaction aborted (error -117)
    Feb 17 17:25:46 kernel: WARNING: CPU: 9 PID: 29834 at fs/btrfs/extent-t=
ree.c:3249 __btrfs_free_extent.isra.0+0xf8e/0x1330 [btrfs]
    Feb 17 17:25:46 kernel: Modules linked in: dm_flakey algif_hash af_alg =
xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat nf_na=
t nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 xt_addrtype iptable_filter ip_=
tables br_netfilter bridge stp llc overlay sunrpc kvm_amd kvm irqbypass rap=
l acpi_cpufreq ipmi_ssif i2c_piix4 k10temp btrfs ipmi_si blake2b_generic ip=
mi_devintf xor ipmi_msghandler raid6_pq bfq loop dm_mod zram bnxt_en ccp pk=
cs8_key_parser asn1_decoder public_key oid_registry fuse msr ipv6
    Feb 17 17:25:46 kernel: CPU: 9 PID: 29834 Comm: fsstress Tainted: G    =
    W          6.8.0-rc4-BTRFS-ZNS+ #403
    Feb 17 17:25:46 kernel: Hardware name: Supermicro Super Server/H12SSL-N=
T, BIOS 2.0 02/22/2021
    Feb 17 17:25:46 kernel: RIP: 0010:__btrfs_free_extent.isra.0+0xf8e/0x13=
30 [btrfs]
    Feb 17 17:25:46 kernel: Code: 48 c7 c6 40 5d 65 a0 e8 f0 f1 0d 00 c7 44=
 24 18 01 00 00 00 e9 ed f7 ff ff be 8b ff ff ff 48 c7 c7 68 5d 65 a0 e8 52=
 69 c1 e0 <0f> 0b e9 30 fb ff ff 48 8b 45 60 48 05 d8 19 00 00 f0 48 0f ba =
28
    Feb 17 17:25:46 kernel: RSP: 0018:ffffc900090cfb80 EFLAGS: 00010282
    Feb 17 17:25:46 kernel: RAX: 0000000000000000 RBX: 0000000f9677c000 RCX=
: 0000000000000000
    Feb 17 17:25:46 kernel: RDX: 0000000000000002 RSI: ffffffff82464302 RDI=
: 00000000ffffffff
    Feb 17 17:25:46 kernel: RBP: ffff8889a044b220 R08: 0000000000009ffb R09=
: 00000000ffffdfff
    Feb 17 17:25:46 kernel: R10: 00000000ffffdfff R11: ffffffff8264dd80 R12=
: 0000000000000001
    Feb 17 17:25:46 kernel: R13: ffff888ad87a4c98 R14: 0000000000000005 R15=
: ffff888a0c7d2a80
    Feb 17 17:25:46 kernel: FS:  00007f823f5f7740(0000) GS:ffff889fcea40000=
(0000) knlGS:0000000000000000
    Feb 17 17:25:46 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
    Feb 17 17:25:46 kernel: CR2: 0000560ce0610b38 CR3: 0000000a907ec000 CR4=
: 0000000000350ef0
    Feb 17 17:25:46 kernel: Call Trace:
    Feb 17 17:25:46 kernel:  <TASK>
    Feb 17 17:25:46 kernel:  ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btr=
fs]
    Feb 17 17:25:46 kernel:  ? __warn+0x81/0x170
    Feb 17 17:25:46 kernel:  ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btr=
fs]
    Feb 17 17:25:46 kernel:  ? report_bug+0x18d/0x1c0
    Feb 17 17:25:47 kernel:  ? tick_nohz_tick_stopped+0x12/0x30
    Feb 17 17:25:47 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:47 kernel:  ? handle_bug+0x3c/0x70
    Feb 17 17:25:47 kernel:  ? exc_invalid_op+0x13/0x60
    Feb 17 17:25:47 kernel:  ? asm_exc_invalid_op+0x16/0x20
    Feb 17 17:25:47 kernel:  ? __btrfs_free_extent.isra.0+0xf8e/0x1330 [btr=
fs]
    Feb 17 17:25:47 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:47 kernel:  ? rcu_is_watching+0xd/0x40
    Feb 17 17:25:47 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:47 kernel:  ? lock_release+0x1e5/0x280
    Feb 17 17:25:47 kernel:  __btrfs_run_delayed_refs+0x64c/0x1380 [btrfs]
    Feb 17 17:25:47 kernel:  ? btrfs_commit_transaction+0x3e/0x12d0 [btrfs]
    Feb 17 17:25:47 kernel:  btrfs_run_delayed_refs+0x92/0x130 [btrfs]
    Feb 17 17:25:47 kernel:  btrfs_commit_transaction+0xa2/0x12d0 [btrfs]
    Feb 17 17:25:47 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:47 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:47 kernel:  ? rcu_is_watching+0xd/0x40
    Feb 17 17:25:47 kernel:  ? srso_return_thunk+0x5/0x5f
    Feb 17 17:25:47 kernel:  ? lock_release+0x1e5/0x280
    Feb 17 17:25:47 kernel:  btrfs_sync_file+0x532/0x660 [btrfs]
    Feb 17 17:25:47 kernel:  __x64_sys_fsync+0x37/0x60
    Feb 17 17:25:47 kernel:  do_syscall_64+0x79/0x1a0
    Feb 17 17:25:47 kernel:  entry_SYSCALL_64_after_hwframe+0x6e/0x76
    Feb 17 17:25:47 kernel: RIP: 0033:0x7f823f6f8400
    Feb 17 17:25:47 kernel: Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f=
 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d e1 d1 0d 00 00 74 17 b8 4a 00 00=
 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 =
7c
    Feb 17 17:25:47 kernel: RSP: 002b:00007ffe3c26e9f8 EFLAGS: 00000202 ORI=
G_RAX: 000000000000004a
    Feb 17 17:25:47 kernel: RAX: ffffffffffffffda RBX: 0000000000000003 RCX=
: 00007f823f6f8400
    Feb 17 17:25:47 kernel: RDX: 0000000000000193 RSI: 0000560cdfcdb048 RDI=
: 0000000000000003
    Feb 17 17:25:47 kernel: RBP: 00000000000002e6 R08: 0000000000000007 R09=
: 00007ffe3c26ea0c
    Feb 17 17:25:47 kernel: R10: 0000000000000000 R11: 0000000000000202 R12=
: 00007ffe3c26ea10
    Feb 17 17:25:47 kernel: R13: 028f5c28f5c28f5c R14: 8f5c28f5c28f5c29 R15=
: 0000560cdfcd7180
    Feb 17 17:25:47 kernel:  </TASK>
    Feb 17 17:25:47 kernel: irq event stamp: 0
    Feb 17 17:25:47 kernel: hardirqs last  enabled at (0): [<00000000000000=
00>] 0x0
    Feb 17 17:25:47 kernel: hardirqs last disabled at (0): [<ffffffff810e5e=
0e>] copy_process+0xb0e/0x1e00
    Feb 17 17:25:47 kernel: softirqs last  enabled at (0): [<ffffffff810e5e=
0e>] copy_process+0xb0e/0x1e00
    Feb 17 17:25:47 kernel: softirqs last disabled at (0): [<00000000000000=
00>] 0x0
    Feb 17 17:25:47 kernel: ---[ end trace 0000000000000000 ]---
    Feb 17 17:25:47 kernel: BTRFS: error (device nvme1n2: state A) in __btr=
fs_free_extent:3249: errno=3D-117 Filesystem corrupted
    Feb 17 17:25:47 kernel: BTRFS info (device nvme1n2: state EA): forced r=
eadonly
    Feb 17 17:25:47 kernel: BTRFS info (device nvme1n2: state EA): leaf 669=
57836288 gen 3873 total ptrs 203 free space 1102 owner 2
    Feb 17 17:25:47 kernel: BTRFS info (device nvme1n2: state EA): refs 2 l=
ock_owner 29834 current 29834
    Feb 17 17:25:47 kernel:         item 0 key (63394947072 168 40960) item=
off 16230 itemsize 53
    Feb 17 17:25:47 kernel:                 extent refs 1 gen 3835 flags 1
    Feb 17 17:25:47 kernel:                 ref#0: extent data backref root=
 5 objectid 552 offset 1802240 count 1
(snip)...
    Feb 17 17:25:55 kernel:         item 164 key (66948923392 169 0) itemof=
f 8229 itemsize 33
    Feb 17 17:25:55 kernel:                 extent refs 1 gen 3872 flags 2
    Feb 17 17:25:55 kernel:                 ref#0: tree block backref root =
2
    Feb 17 17:25:55 kernel:         item 165 key (66948939776 169 1) itemof=
f 8196 itemsize 33
    Feb 17 17:25:55 kernel:                 extent refs 1 gen 3873 flags 2
    Feb 17 17:25:55 kernel:                 ref#0: tree block backref root =
5
    Feb 17 17:25:55 kernel:         item 166 key (68719476736 168 110592) i=
temoff 8143 itemsize 53
    Feb 17 17:25:55 kernel:                 extent refs 1 gen 3841 flags 1
    Feb 17 17:25:55 kernel:                 ref#0: extent data backref root=
 5 objectid 440 offset 3100672 count 1
(snip)...
    Feb 17 17:25:56 kernel:         item 202 key (68722249728 168 110592) i=
temoff 6177 itemsize 53
    Feb 17 17:25:56 kernel:                 extent refs 1 gen 3842 flags 1
    Feb 17 17:25:56 kernel:                 ref#0: extent data backref root=
 5 objectid 953 offset 5431296 count 1
    Feb 17 17:25:56 kernel: BTRFS critical (device nvme1n2: state EA): unab=
le to find ref byte nr 66948939776 parent 66948939776 root 5 owner 0 offset=
 0 slot 166
    Feb 17 17:25:57 kernel: BTRFS error (device nvme1n2: state EA): failed =
to run delayed ref for logical 66948939776 num_bytes 16384 type 182 action =
2 ref_mod 1: -2
    Feb 17 17:25:57 kernel: BTRFS: error (device nvme1n2: state EA) in btrf=
s_run_delayed_refs:2246: errno=3D-2 No such entry
    Feb 17 17:25:57 kernel: BTRFS warning (device nvme1n2: state EA): Skipp=
ing commit of aborted transaction.
    Feb 17 17:25:57 kernel: BTRFS: error (device nvme1n2: state EA) in clea=
nup_transaction:2006: errno=3D-2 No such entry
    Feb 17 17:26:02 kernel: BTRFS info (device nvme1n2: state EA): last unm=
ount of filesystem f33f6f52-ef71-4984-898d-ff20390559d1

[Workaround patch]

I added "level" field to struct extent_buffer to store the tree level and
checked if buf->level is the same as btrfs_header_level(buf) or not in
btrfs_free_tree_block(). It revealed buf->level !=3D btrfs_header_level(buf=
)
can happen. It is because the extent buffer is already zeroed out in
btree_csum_one_bio(). Since the header is also cleared,
btrfs_header_level(buf) returns 0 while it actually should be 1. As a
result, a faulty delayed ref, whose level =3D 0 not 1, is inserted.

A workaround fix is easy. We can leave the header intact. With this patch,
the failure goes away and generic/013 passed 300 times.

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 8ab185182c30..f43104224c92 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -278,7 +278,9 @@ blk_status_t btree_csum_one_bio(struct btrfs_bio *bbio)
 	 * ordering of I/O without unnecessarily writing out data.
 	 */
 	if (test_bit(EXTENT_BUFFER_ZONED_ZEROOUT, &eb->bflags)) {
-		memzero_extent_buffer(eb, 0, eb->len);
+		const unsigned long header_size =3D sizeof(struct btrfs_header);
+
+		memzero_extent_buffer(eb, header_size, eb->len - header_size);
 		return BLK_STS_OK;
 	}
=20
[Remaining Questions]

Timeline of the faulty referenced extent buffer should be following:

- (allocated)
- btrfs_clear_buffer_dirty: set EXTENT_BUFFER_ZONED_ZEROOUT
- btree_csum_one_bio: zero out entire buffer
- (written to device?)
- btrfs_free_tree_block: add DROP_DELAYED_REF

Q1. I previously assumed at btrfs_clear_buffer_dirty, there is no reference
left. But, the actual drop of the reference is done after
btrfs_free_tree_block. Is it too early to mark it EXTENT_BUFFER_ZONED_ZEROO=
UT and
allow it to be zero out? Maybe, if the FS crashed just after writing zeroed
buffer to a device, re-mounted FS will see zero filled node and panic?

Q2. With the "buf->level !=3D btrfs_header_level(buf)" check, I observed so=
me
level mismatch printed with no delayed ref error followed. How can it
happen? I guess it is merged with the existing delayed refs ... but it does
not care the level mismatch?

Q3. My experience on debugging this suggests this bug is highly timing
related: adding debug prints in btrfs_free_tree_block prevents the bug to
appear. What is the reason behind this?=

