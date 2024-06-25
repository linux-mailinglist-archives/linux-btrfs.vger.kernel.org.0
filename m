Return-Path: <linux-btrfs+bounces-5957-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC1916927
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ED111C24F04
	for <lists+linux-btrfs@lfdr.de>; Tue, 25 Jun 2024 13:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794A158A00;
	Tue, 25 Jun 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iFPket6s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xJNJemS5"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A315F41D
	for <linux-btrfs@vger.kernel.org>; Tue, 25 Jun 2024 13:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322818; cv=fail; b=lhj4c4Ox8hq4koIphlXNM+DMwcpV8HMKO40qrx608Y62m7jG0hnCU070cfKOwGW8RjC6gT+NgfhiHCzyzBLSOAsQaLM+hIYYyO9NSq7mbS73x6+Nn53/D94OqtQlM7vh/+/MGptjKsJhPK1h1z4FCm9lictEnMKNvOyBpfajjPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322818; c=relaxed/simple;
	bh=FqtlQabhVwYQcu22JBHCLAC9mjCilZnNbYY6YMUkWpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mV6soWThm7Oasjjj/lkUOY5H0mHMdCdV8cp2L8BHcLJ6PfF94dggMW1F25Sut6fpf89iNsNe4kfPjtXD4vDnw9WL10dt08az/nDWmqwh7LvmmBOMfTWVfTHqNiKZfaKQdSi5IJQ1JyB9cbdOTg2f6v1dUN5CDRtAioB9Qjg7Mhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=iFPket6s; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=xJNJemS5; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719322816; x=1750858816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=FqtlQabhVwYQcu22JBHCLAC9mjCilZnNbYY6YMUkWpQ=;
  b=iFPket6sfqglaxFOUZEz8FjHmmund6Ev4QOOtwvjYA5esMy9fDCuw/EF
   RXQCUV5T7NPDya7bN08Ej9l2VG7c9sTilqxBIWuZQOIAXrM1tR/0PUsx8
   /QPaTqyPVzE5JMy1YK+DehZyOm5dVUKMXkDHyvHUFYbxJErxVw5toSSkZ
   q3PPGzKfS89EQjdNmF0LeCqX0xdmIHSX0lnxLI9oSagiEXnaWfN+b4mNA
   AJW+R2u0uN0YqEEOeXPbVk+bqjrZiuvpCov2ZCZxek566pQGaZGNsRKRA
   Zuz6S7UIgC3IdN2gTnDAljGKx09ycNyY9KVtnxfTQlkjtwqqW75ROL8Bj
   g==;
X-CSE-ConnectionGUID: hUZp0OfnSVq154p15nBaNA==
X-CSE-MsgGUID: 3mutOzL5QBiPSlvhn6hLtQ==
X-IronPort-AV: E=Sophos;i="6.08,264,1712592000"; 
   d="scan'208";a="20337045"
Received: from mail-bn8nam12lp2176.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.176])
  by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2024 21:40:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YJyittdwesRwgvSBWivjmhUWtaziW5eAtH7gABBMrLJRLN83pmL/7g1yA/CxJ2MU7w+2bxJ6eNDyeXmzhqe96KqjqWwp37DjjNIJ22umGszNy6GLcox2CqHDDPZLEz+8LkxWxChZpe3yDK8wV+9cv+SWCxWfgGTx10eGy3YTYmKpU5pNlSbyURAHa5o3czSdZm4TfMs8bZRPWaVDZmz+a+3bcn6fpA+7Vb8zKOg9kw5zzbxH8oq60w+h5qhMIPfj1K9UvuZhwDTKzk6G6m2bLwOJIM+wCfE/cI778iOeeo7c18ep32dIuoFy59rF1kDHSEWnuGWrCQ/rcS0wVIIA/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1UmzZA/SmRi1lwPEj67QIu43gQXt12Gs2NXFCMESs8=;
 b=TCNv+u5h/y9Y/xzzWG31mKLHNZQVoI7JMXONdfGiVATs5MjHGV2OiASYxqGClt9QioCxQUcalfRLrWtouh14f9NK7p9+/9rAlAUGsLtWwkLVVMdiHwTX196omtCFE/R4uR1UdLRqOIHQ/yzrOWDasB+UU/kovSdERyG8+2w3uUIKSpW3bH+jTRzRnZZXr7TZug74ZdiqagmQw+ExnioSS9KGAeMvcBmNcc21FC/8P9iZIl3mAMBizIuuo6/VtxGunnW3znPFTyxqVvyHr2Hq61excW1ZWrtfCQWVJpqWguOWcaHXcAcdGMAw0bcxt8dqTDb1xfRhBw1/5QMhQKeSFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1UmzZA/SmRi1lwPEj67QIu43gQXt12Gs2NXFCMESs8=;
 b=xJNJemS5xM08v3KWJ0ISVaHjH2E8o8EuBcTx+EWnya4QU58shyTcKMIFyJUh1a6Zugifq9SC0SY+QhbEp9TTk/tl0jyyfiaO3rsAO7KnOtHQ0JgjnJjNNW47lMesxkZXQsZANfkmm2aS7RpV+FHZSosizpqlXfsfbF3lc3fWbwc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB7003.namprd04.prod.outlook.com (2603:10b6:5:1::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.29; Tue, 25 Jun 2024 13:40:06 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 13:40:06 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Boris Burkov <boris@bur.io>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 3/6] btrfs: dynamic block_group reclaim threshold
Thread-Topic: [PATCH v2 3/6] btrfs: dynamic block_group reclaim threshold
Thread-Index: AQHawQvK4K48ma+XHk6AE3ha9hSZpbHYiEeA
Date: Tue, 25 Jun 2024 13:40:06 +0000
Message-ID: <avjakfevy3gtwcgxugnzwsfkld35tfgktd5ywpz3kac6gfraxh@uic6zl3jmgbl>
References: <cover.1718665689.git.boris@bur.io>
 <13ee8fb749036b3aafb331417199625c5bd12b25.1718665689.git.boris@bur.io>
In-Reply-To:
 <13ee8fb749036b3aafb331417199625c5bd12b25.1718665689.git.boris@bur.io>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB7003:EE_
x-ms-office365-filtering-correlation-id: 26f51e36-521b-4f45-9c4e-08dc951c5325
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0m837G82hUNRyO1953zj8Ux9peK34shigp9Uzd1aLaFgvcagzeHat+6g6njr?=
 =?us-ascii?Q?dlD/53Hq397DM1pvjFSubEVsTInkWKCvJ2Z1j5koL2ICi1kA9zvEHUC7bAP8?=
 =?us-ascii?Q?u+3kvKe7GKE9O9ZQ2cWZwzIT80CV5yfF7UPMWDjF00m/e91cGL9LwFjwqJlw?=
 =?us-ascii?Q?oTMI5IUC3BcgA6D9+vC/p1caj96C9tl1imdtgqPzCgNc68miuHIAm5C3rlQn?=
 =?us-ascii?Q?gHYHkMuh0PYenKXlWwGWh6RyL5COo1Uk5xbWjrHwMC6ZHAw0xckJwSmBzwaI?=
 =?us-ascii?Q?8b89TZ/LDEWpdmkdxoGfpD2iNqkfBtzF4r6SsIsvmrX6QI3Pb+h2J0gH/cAE?=
 =?us-ascii?Q?W+Eo85Q32xTLWMYZX7ywZJ2k+8n/zfPZEDS82IcXA7de+FA6dywcxj5U4OKv?=
 =?us-ascii?Q?oyol6irFQd0iruIAKwcERTbG/nRhDYID3OhX4YAB1or0h2+ztx9EmoBv5sBz?=
 =?us-ascii?Q?do27jta9P6wTFVe2am1WybpTiSGx2bKPfPLwjtyldYm4dbbhmbNo9O2xespv?=
 =?us-ascii?Q?QBOIruFK+IBSuRqI4ThsKjHXCmss+EhqogFfr3mW1YgAfUIZOHNForKgzowq?=
 =?us-ascii?Q?uUfd06qvkl53qQy9nQjH2cUr7DU3B0Z4tgf25ZcgvrQu3fz+KB/7qSvl1yYT?=
 =?us-ascii?Q?i3TtMxYIS2yak33JGWb0p5Q1XjmkpU2fXW1eZBoEg2DC/teGWTpaYIxSWSMK?=
 =?us-ascii?Q?ylqHkFYYmwWS3Jo8HP3yMK1usj/YwJ8VvI4RjS7drfLhm3+L/BeDxaxukVej?=
 =?us-ascii?Q?KE16ILXtQ5j+qJ0AyBcEw5sHSc9QTwLgnfKLO3k9XYqSe0mEPxqRSJnI3WuX?=
 =?us-ascii?Q?Mqh/bga64R91/NWvCS5d7jtN07RsHjpWQvXl3bFS279QBHtO58FLRz1ZpE5+?=
 =?us-ascii?Q?S/Ds7aTT9TyARMAz/jz/4hsc5EqlIp7uzxzZsWCCBo4S1oMwULg9RIxDXIf8?=
 =?us-ascii?Q?6BdaFyWyL2xRSEIlCOrXsU2mAiF/fis5DkuxxkemcWRwmgvtZOxI/C+hCNj6?=
 =?us-ascii?Q?eIU6I4wyqTKi7AoFeNGO35KWOtVF156aUCA2qp05XbQr/TI8G3GW0sCFVECv?=
 =?us-ascii?Q?QRLEYwe0C/JTUZw0etXqJbFj+SDIz2IFxqccaxyPrte2tqqEFryQUH237+PW?=
 =?us-ascii?Q?wUfGAasDUMYog3LbemyErLtHPDlDKTYL2kUzcZSI7hd2NWuMU09QoqPW0uB8?=
 =?us-ascii?Q?x0vHCYyFz+fegcTBUaCoq6DB9wVddSrdCi8evLmBErqzobwRln42gisnsRpi?=
 =?us-ascii?Q?jZdtGD7xbAXX0/ueBBUr67OkTF7+b/yDMm0pqQ6LzYUmWtO02SqS5hyj64Rr?=
 =?us-ascii?Q?97rjM9yuHGKpJADi6vB8waCeqFFFJtzk14JWqWBIHKIujCBIooexY5FEAQbb?=
 =?us-ascii?Q?8MAwXQs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0PROjmHkmVXZMgHZQUKbAl1p3GMG27D5J6XFZw4VK69B4/V6kC5jrzgqdFRQ?=
 =?us-ascii?Q?HCZDGnc5NZ6X0hsXkS1z28vmqPzWQXSBMZW4yO3OgGsAJIGor7oPgnX7/IIS?=
 =?us-ascii?Q?TGYUYUKSp4tr4SJv1iIVVVyc2szo6KW30XlTt91CnGzXOoAd43JWuL6he+no?=
 =?us-ascii?Q?Oy0VmRCrVCKdsk5xjYgy7hXLebeg7aivUHt9V/zfiWQMrGi3XL0ZQbE9z6XS?=
 =?us-ascii?Q?6d6yBJ6aAz7VMPxd9QzfdjEv+ZQ8OmF9GBBWm6VeuDBm1XIQsK1Gb1XGOVIh?=
 =?us-ascii?Q?MF8D/8jzvXUd4HEVqNgf+qEdGKa4tHJk+ep2LOiJ6sGmDQjdQBTRpdOZHOJM?=
 =?us-ascii?Q?HPf8srx1pmS+akqE258n4emAqaffJ93o0+wo5febpclFSwWoXkaGzJ1L3Vbu?=
 =?us-ascii?Q?3SKSLkn0dFlGhmINFmndVOVh08+PY91ulqXOwoYoD86Ug5yfmTGnpcuDH4UP?=
 =?us-ascii?Q?LkpWX+Jrv1Q3ZsEoJJxkYt18bB25+l94o9H3kd9q7QVD3a+nxWyjPtJrC2qU?=
 =?us-ascii?Q?+74U8JoPI9S0qQWpiCA6RYRaVuyvIyUHYVqBnZsEpjuLSpps4kO8j3T5bsAw?=
 =?us-ascii?Q?P6CLJPsMh1v7kQBeKGvEXe5tEwQtH42o03Ib4+qCWeqT9kqSBsmVUc8jw0JH?=
 =?us-ascii?Q?6OavpaSXBRUJEF9WuOigp/wA8TepogzGYyiuXv7jz5sGUxQc0cZ7EcumImQE?=
 =?us-ascii?Q?uvXTCmGFbxkKO+z3CspVYhM+y2kzqLBZAmzfTLLVedGWveBTWCwMS46DDPbf?=
 =?us-ascii?Q?4cyafqeJwcD+3PP8+WfBjAqbnZ68KZL+qiQprjAeGJry3zGNoULEvx7lyNHG?=
 =?us-ascii?Q?/ER1BvTsQSPSxd8+z5VGPt5LNUUh+taP9jeYiRyTWj6r5P6RhCnPlBPfPri8?=
 =?us-ascii?Q?DNvr2bgRbREz2IABEQCw6LEtKGpevaHxOWWRJNyU1D3OEwfDGQMog4AuWQO0?=
 =?us-ascii?Q?DpqegFvPQirErUMNsm4G0saFgE4jFuaUYPzcbdy76f1H23R3MigjBxvzcAfr?=
 =?us-ascii?Q?u5xwAU9t1LwwTIMKFH3mKof1//d+y6ogFWnsQUj0Rkb/la6nSRWDOZ4aP4cT?=
 =?us-ascii?Q?tQKhptxzl8JQMoTQuN71IDD9ghjNEg6psg4HJRpOmIuhePO/tN136//rXtZl?=
 =?us-ascii?Q?jY0dYWulKo0wlKQzMkpA7elW/4Foup6TseG5fw3c2VrMx+VJeXLIDXY+UZSv?=
 =?us-ascii?Q?97FKK1NRqM7d1HBKwy3pdJgz4ZJUrO9tpvD3iLyqKtW4JfNwlG/+IxtKPuSC?=
 =?us-ascii?Q?jKFHV5Gn0Ktc9sxEyuAu13eOHFPJLHTWHgUI6Rgrr4wV33+8ThH/ELWIP594?=
 =?us-ascii?Q?7PhD1HqF+5RICxfq1asnZIb5hRpWcduTuyv75kuf83d6NZ7Z2lzpx+9tLhMX?=
 =?us-ascii?Q?1ujEPYiMzkUwqIXb1Ghkp3m1a3JkchuQXE7ucknCQdaAz7NeH2zvgSgSAMgn?=
 =?us-ascii?Q?4aNER+e7vJgmCfJBtNspEDueR92FNjnoQFkBPODw28J3WF2aOuHe58oIwm7I?=
 =?us-ascii?Q?EhisplP6//FRBfwIcP6zL+ShqAdbifddbEe5ehUiBmayArzQs10crjuk11dI?=
 =?us-ascii?Q?k2Ldg9nlosnG8NTO8y4nUxtS5aAixWTrrrNiJwUmRRaTozxW7gENS64j/BfK?=
 =?us-ascii?Q?Ug=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <90AE2019A6210F4CAD7D7A0DE2DD9AAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xUwtBoFQ6zQ45LQo11zSr/ffV3HMkdB5zFX/t5Ki6glatMJDWF4neBI1gJ8wpWVHMfq9YOSlq9MOTmuRVb/KVHzBibLCo49wRgebd8EKn1jTq9Bict+WNg3Oq/d6i9XNXJTnSMEroweVIzdrb7X3NCZSG5RpljBJiDFnfj4VsWbW0Tkd1Qf+G26ut4e27CTfzW4VtUWUu0+XYAlNoEZuzQn60uoVGYCcG7YpRXPzgUCH/2WgSmyCDPeUYYT84YKfsBdMU/QCp425spNmWc9Xmyb3YjHJF18G0aAxHrutkNmnE1GVA0X/2V4Hu+2XI1CRdnVPwhH/lzZ6Za7fvP6ykPAY7ZpMqLyCyQod2BEoguC8Z/iJrQff08E/5OXoW5UlQ1CNktp6Tr7IKv+2W/6UmIf0e4Jqf2n1vbXYEqfKGPoxAl1gMgfKPd8/BdU8am7Idi2Kovru6T7olVVpF4Bvc/qp7GshXgS7PbG56Fw0IzhXHL34D3Wmh6k4TOqarvuwjRVaz/9D3pK6Q45hNpYODkRSPhZrE6Falj0diwPJKv2rJnO38PPP82utETb3jcjNowBhOCOva/VeTXE5nbZzqepgE8qYYrvkx2RjfhkC2E4Kyo+mpIXTTRBFv3cjw7lf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f51e36-521b-4f45-9c4e-08dc951c5325
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 13:40:06.5843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hWbB5VfUb/gv2Xmlay86ZBvVsogtIx6X4Zxwu4ssbYv8dfHZCvKUCQcNRrLX/OX1vA6Q92/FLlA/OlTg/9Qjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7003

On Mon, Jun 17, 2024 at 04:11:15PM GMT, Boris Burkov wrote:
> We can currently recover allocated block_groups by:
> - explicitly starting balance operations
> - "auto reclaim" via bg_reclaim_threshold
>=20
> The latter works by checking against a fixed threshold on frees. If we
> pass from above the threshold to below, relocation triggers and the
> block group will get reclaimed by the cleaner thread (assuming it is
> still eligible)
>=20
> Picking a threshold is challenging. Too high, and you end up trying to
> reclaim very full block_groups which is quite costly, and you don't do
> reclaim on block_groups that don't get quite THAT full, but could still
> be quite fragmented and stranding a lot of space. Too low, and you
> similarly miss out on reclaim even if you badly need it to avoid running
> out of unallocated space, if you have heavily fragmented block groups
> living above the threshold.
>=20
> No matter the threshold, it suffers from a workload that happens to
> bounce around that threshold, which can introduce arbitrary amounts of
> reclaim waste.
>=20
> To improve this situation, introduce a dynamic threshold. The basic idea
> behind this threshold is that it should be very lax when there is plenty
> of unallocated space, and increasingly aggressive as we approach zero
> unallocated space. To that end, it sets a target for unallocated space
> (10 chunks) and then linearly increases the threshold as the amount of
> space short of the target we are increases. The formula is:
> (target - unalloc) / target
>=20
> I tested this by running it on three interesting workloads:
> 1. bounce allocations around X% full.
> 2. fill up all the way and introduce full fragmentation.
> 3. write in a fragmented way until the filesystem is just about full.
>=20
> 1. and 2. attack the weaknesses of a fixed threshold; fixed either works
> perfectly or fully falls apart, depending on the threshold. Dynamic
> always handles these cases well.
>=20
> 3. attacks dynamic by checking whether it is too zealous to reclaim in
> conditions with low unallocated and low unused. It tends to claw back
> 1GiB of unallocated fairly aggressively, but not much more. Early
> versions of dynamic threshold struggled on this test.
>=20
> Additional work could be done to intelligently ratchet up the urgency of
> reclaim in very low unallocated conditions. Existing mechanisms are
> already useless in that case anyway.
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/block-group.c |  18 ++++---
>  fs/btrfs/space-info.c  | 115 +++++++++++++++++++++++++++++++++++++----
>  fs/btrfs/space-info.h  |   8 +++
>  fs/btrfs/sysfs.c       |  43 ++++++++++++++-
>  4 files changed, 164 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 824fd229d129..c3313697475f 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1764,24 +1764,21 @@ static inline bool btrfs_should_reclaim(struct bt=
rfs_fs_info *fs_info)
> =20
>  static bool should_reclaim_block_group(struct btrfs_block_group *bg, u64=
 bytes_freed)
>  {
> -	const struct btrfs_space_info *space_info =3D bg->space_info;
> -	const int reclaim_thresh =3D READ_ONCE(space_info->bg_reclaim_threshold=
);
> +	const int thresh_pct =3D btrfs_calc_reclaim_threshold(bg->space_info);
> +	u64 thresh_bytes =3D mult_perc(bg->length, thresh_pct);
>  	const u64 new_val =3D bg->used;
>  	const u64 old_val =3D new_val + bytes_freed;
> -	u64 thresh;
> =20
> -	if (reclaim_thresh =3D=3D 0)
> +	if (thresh_bytes =3D=3D 0)
>  		return false;
> =20
> -	thresh =3D mult_perc(bg->length, reclaim_thresh);
> -
>  	/*
>  	 * If we were below the threshold before don't reclaim, we are likely a
>  	 * brand new block group and we don't want to relocate new block groups=
.
>  	 */
> -	if (old_val < thresh)
> +	if (old_val < thresh_bytes)
>  		return false;
> -	if (new_val >=3D thresh)
> +	if (new_val >=3D thresh_bytes)
>  		return false;
>  	return true;
>  }
> @@ -1843,6 +1840,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *wor=
k)
>  		/* Don't race with allocators so take the groups_sem */
>  		down_write(&space_info->groups_sem);
> =20
> +		spin_lock(&space_info->lock);
>  		spin_lock(&bg->lock);
>  		if (bg->reserved || bg->pinned || bg->ro) {
>  			/*
> @@ -1852,6 +1850,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *wor=
k)
>  			 * this block group.
>  			 */
>  			spin_unlock(&bg->lock);
> +			spin_unlock(&space_info->lock);
>  			up_write(&space_info->groups_sem);
>  			goto next;
>  		}
> @@ -1870,6 +1869,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *wor=
k)
>  			if (!btrfs_test_opt(fs_info, DISCARD_ASYNC))
>  				btrfs_mark_bg_unused(bg);
>  			spin_unlock(&bg->lock);
> +			spin_unlock(&space_info->lock);
>  			up_write(&space_info->groups_sem);
>  			goto next;
> =20
> @@ -1886,10 +1886,12 @@ void btrfs_reclaim_bgs_work(struct work_struct *w=
ork)
>  		 */
>  		if (!should_reclaim_block_group(bg, bg->length)) {
>  			spin_unlock(&bg->lock);
> +			spin_unlock(&space_info->lock);
>  			up_write(&space_info->groups_sem);
>  			goto next;
>  		}
>  		spin_unlock(&bg->lock);
> +		spin_unlock(&space_info->lock);
> =20
>  		/*
>  		 * Get out fast, in case we're read-only or unmounting the
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index 7384286c5058..0d13282dac05 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> +#include <linux/minmax.h>
>  #include "misc.h"
>  #include "ctree.h"
>  #include "space-info.h"
> @@ -190,6 +191,8 @@ void btrfs_clear_space_info_full(struct btrfs_fs_info=
 *info)
>   */
>  #define BTRFS_DEFAULT_ZONED_RECLAIM_THRESH			(75)
> =20
> +#define BTRFS_UNALLOC_BLOCK_GROUP_TARGET			(10ULL)
> +
>  /*
>   * Calculate chunk size depending on volume type (regular or zoned).
>   */
> @@ -341,11 +344,27 @@ struct btrfs_space_info *btrfs_find_space_info(stru=
ct btrfs_fs_info *info,
>  	return NULL;
>  }
> =20
> +static u64 calc_effective_data_chunk_size(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_space_info *data_sinfo;
> +	u64 data_chunk_size;
> +	/*
> +	 * Calculate the data_chunk_size, space_info->chunk_size is the
> +	 * "optimal" chunk size based on the fs size.  However when we actually
> +	 * allocate the chunk we will strip this down further, making it no mor=
e
> +	 * than 10% of the disk or 1G, whichever is smaller.
> +	 */
> +	data_sinfo =3D btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_DATA);
> +	data_chunk_size =3D min(data_sinfo->chunk_size,
> +			      mult_perc(fs_info->fs_devices->total_rw_bytes, 10));
> +	return min_t(u64, data_chunk_size, SZ_1G);
> +
> +}

I know this is copied from the previous code. But, the logic is wrong on
zoned mode. We always use data_sinfo->chunk_size which is zone_size.

I was working on a fix in the old code, and a patch is almost ready. Since
the fix should be backported, it would be easier if I could put my fix patc=
h
before this series in the for-next branch.

