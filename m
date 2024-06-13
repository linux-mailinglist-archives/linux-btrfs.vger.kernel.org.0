Return-Path: <linux-btrfs+bounces-5686-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C0D905FA4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 02:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2F22835F4
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jun 2024 00:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE6D4A3E;
	Thu, 13 Jun 2024 00:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ZkavFb3C";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p1TKSORR"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865838BFA
	for <linux-btrfs@vger.kernel.org>; Thu, 13 Jun 2024 00:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718237903; cv=fail; b=It4HOecCIsjEXsiG06NiuXVb6KMiHdQNggYWZMl9+oulKuqgOKR74wXffI1LTRBnthSO8Z4YBg0tF0L1KVF78V51GoUCEvq1T94nhpsw/l20hqfWV5I3WnbYd9sGRRfMmtMkFGume+YVvIPWI2WMONBETysQS1HWz3op1kB2zio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718237903; c=relaxed/simple;
	bh=DE2XzK7CeFxnZhWilpUSatvDQHJ1wVr2pHLhTmhbX2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J8UP1Zi25ODe/9wPWRYPt3HBYUjYEri7v/0BRMFActG4L/EEoJkeoRJl0wWE5JWVPGpArUtnx+xLdBqseabz8im16p6dASRpqYjmTeT5Dj2lxgH50WZou/rckB+neZCVI/6rX5cvfTmT0aZQxyPpTMPOQEKY9oHggd57HxEOUjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ZkavFb3C; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=p1TKSORR; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718237901; x=1749773901;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DE2XzK7CeFxnZhWilpUSatvDQHJ1wVr2pHLhTmhbX2w=;
  b=ZkavFb3C3DCi9TEipKxA5heJckjlRvo6oS3ulPQWuY1X20x1qf31JWKl
   9wSh+g1TNfongWGKHNptwm3SmUhKdeab4hc0Xbys+2gb13JHp8z4IXvbJ
   11ayI31XAnxPQt/BTtXkGNFKlN1KViRyBtOMPFxVqBUASqGp0KM9yUpA4
   qz7BfOvBvp1oXgdmZaWZAvN50nnW0N7ko6oca0/hotorlNGk5Rx6+pNlq
   n0Ai0hg8Tt5h0FrYObnf7n5WCXZ2nvyrxnv7EJ5Prkb8zwnYVYAJId9NI
   7YV8Gijl1oDzSMYUTdZ9Oxp/0U1UDe0NGmaXjABfVoZKr/e054mxOvFD6
   Q==;
X-CSE-ConnectionGUID: AVT89WBuRFyXjLBOAajrCw==
X-CSE-MsgGUID: HU9Taya5QI+L93MVI0sFuQ==
X-IronPort-AV: E=Sophos;i="6.08,234,1712592000"; 
   d="scan'208";a="19286048"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jun 2024 08:18:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mozdgXT+js9PZpeBdp+OoTpFU+kUPtCreO6s1u9mmGwNgj5YPFjJA/abKWNbENKW57fzMm95N2PICh6cXKUDA3sElO+hiZksnxMc9eV2F/3EqMBOp1tGTnpUGGgeGijV0SG/vvGZoZo7Ka1PDzPosqdLuCka+W862uEtIIrLRnIPSG7e41LNVFjv14JoSr3H1X8HVhxGD7yonNZgEEbds3atzgKdyDhsmywhB8SvSJLG8XseOwy75vsu08ruVccr/ZIXs+r7l7AnFqiJOHIOfR01LQNmzFrZVi+gkTwIp1txsY4dDH9e1MEgC8PPD40+WzCh4DvkLBt17YylJ216KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DE2XzK7CeFxnZhWilpUSatvDQHJ1wVr2pHLhTmhbX2w=;
 b=AlnktCqrOSfQo9ge7U0uJgAGfHFESpInDzfOdAfGH0EE6K1f1dWQGVLvuCg/6NIlbSuMJkAKxE0PY1nV1Y6mO4UQUoIQy8Qo1+FJt4iwfApbyyvMgVRat2iV/R1NmYOvzIHPpusUqmKwF5yv4sxGBwsxlA49FDZG8z5fSeTAmF2C1hhYkt0xzh/Fs865MBj6+z9t+ILDoaSnZJrIlEz2RC5ylFMLiw3QCZvdezUciz/ps+VsVwKr1QuTqzrFRFWHsoQ7eJ0IIJzXTNWHNRBaSkgU5UxhbwQdylqSrhUk8gfd9NmlLw/jtT4VfZDFU0Q/WRqLbLCMYO3Gzd4+11zePA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DE2XzK7CeFxnZhWilpUSatvDQHJ1wVr2pHLhTmhbX2w=;
 b=p1TKSORRvUWRzXPQWMq/k6PAFGPGpxj0YMEjJeP0kDGjJX6hsrhzW9V1S7OSAvnX8z9KeEDvFsTTwyPc90GwSWzFjJo+8hUeOs2a/uFo64EJ3X9uty/7qGxflK1koa/5qTr8ZRa1X6QTro0EpMqfF89FczatKHRvJXLxXPNdKj8=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SJ0PR04MB8357.namprd04.prod.outlook.com (2603:10b6:a03:3d1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Thu, 13 Jun
 2024 00:18:12 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 00:18:10 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix initial free space detection
Thread-Topic: [PATCH] btrfs: zoned: fix initial free space detection
Thread-Index: AQHau96tCqk6XbWvhEuhJmWeVSCHbbHCYR6AgAJ1e4A=
Date: Thu, 13 Jun 2024 00:18:10 +0000
Message-ID: <eh4tq5w5dy52w5keraeizswy3lfr2wjbxuz2yrh5ztd3hnub5o@qg7yh3dgtkdd>
References:
 <ec2aafb75c235d9c37aef52068992dca0d060d5f.1718096605.git.naohiro.aota@wdc.com>
 <b78e0836-b654-46a9-bff8-50ececb05d6e@wdc.com>
In-Reply-To: <b78e0836-b654-46a9-bff8-50ececb05d6e@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SJ0PR04MB8357:EE_
x-ms-office365-filtering-correlation-id: 4c504c08-cb98-4488-c980-08dc8b3e4ecf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230034|376008|1800799018|366010|38070700012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?KId4GaHs3oOKmMn6AJAvppwLbV9Uj5JcCaNOgbMeslTwXp0FB6o7TbfM0kmm?=
 =?us-ascii?Q?GnZGmrLJ7dXHJKwrVnBzUgLlYH/VIR1rQWuw8xYXDau4WsKnCfnsAWAPtzNL?=
 =?us-ascii?Q?bYbdhJfxlWQCBZbQ6Z+UlntabeIDYxRxINcTMvGGl/+ZlnaAsQ8nfTf4X+mf?=
 =?us-ascii?Q?Xm7ai2yN5o7DIVHbEo6Xvk1vuXSgkCKHjPwOddPzPpX8P2W2MP5tZumyW53M?=
 =?us-ascii?Q?FKCg68LJ2f3DUif3Jt2GoabO88sA4eMDgCndfT8S6ykshqwKfopk7g9xFA4l?=
 =?us-ascii?Q?uI68RXcePfjysmCqzJ1UAa8g1E3pl/APR/I99nuBYEbo0v4ACb8e0imFANIy?=
 =?us-ascii?Q?XcUBURBUHhaebVKraW0aIOjhmp3cJvOQKwUZjYyRo6MWwn4bdtX0hLr3LiJP?=
 =?us-ascii?Q?GWqOZN7XtgWSJi758i1NlcyZQq3xm2TETB2786vcWK+LENkjqWNlbkK8WthQ?=
 =?us-ascii?Q?Xwrpk9/QZrz5DD6/e6RLzTwe9fsUMOM3BlbpAnOeyum2xUCCwj5did+bgtJF?=
 =?us-ascii?Q?BenrkQ5/2Kgb3l1RrrLfOjkqIyp+73je/vgf2GTP/uI6l5WXDsTMkyMeeWGH?=
 =?us-ascii?Q?9ZCs9qmba0PyLQkDEG+u3WS+visJP4PosHbg2ROr6cyTnAWrI+XzpBhu4wWz?=
 =?us-ascii?Q?hx7QOIfxxIeeAu0KkxoECWKb4w6OtRZtfJSMwYkwIzgPmA7g8eD7IAjndg8p?=
 =?us-ascii?Q?EgghlCZ/F2xpAZBRxMhl2icWTllKktILZk3JWbm6M5XtW1RNhE0DPYQUcX1n?=
 =?us-ascii?Q?kcxo+yjnY6SwQrcpngCF1Pr6ZMuT8W4QQi11e9D84Of+bndTLeOdOnbv395E?=
 =?us-ascii?Q?3GFDCz7zSlthyPGpTTr3awyhfI9PrByb1VdtPtnpPYauys0EZ3ZcsQPynAS1?=
 =?us-ascii?Q?9rXBy4Z/05t6SVtakJfYjblxCIdiplDFrgrgcwEx5cwdEH7SXNr1qelczLrC?=
 =?us-ascii?Q?Z8VsjWbQKglVcfCF74QWdxBIpSZtW/9BeRfCg07r7oC/K8ZPyCqU4xwNDuip?=
 =?us-ascii?Q?KkDmk9g8IjIefLFsqpwDjyZEf8cf19xR2tpyK9c7RjDT/3xxBbwjtv6Z6jRv?=
 =?us-ascii?Q?xxttvVt4mAAkdHpTm1Q67zrw6PqyEu1YtD5LMWmKhKskDtklpuSLxo0hMn4h?=
 =?us-ascii?Q?FTpN1nVUqpzFD2jNvQwNATyJnhlg/1QDvypr+d5l0cWmCKuewvm64AcQ/3W3?=
 =?us-ascii?Q?7N6SAjbhqUK+51mzwY8sdJAGb9m4lePz7Gzc/mONXNteoqYcPaYJv0wG6Ppk?=
 =?us-ascii?Q?W7fjh+XwMfxraDjiZLGpKjpRVzFihNmH9uAXT9EpaEihkGjneXeayI4xjXIW?=
 =?us-ascii?Q?sl/Ht083Z9mBt1uBI8zzy1GjCWwTvbXUtBmqDKJv+RDfrM5LnXN9BdZoPOUB?=
 =?us-ascii?Q?DG5az4c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?prAhm0ozoVb6N5TMgC6nR02v40qblihBAOJ+aNmVCPjNXMG3RKNg0Ln6ntVo?=
 =?us-ascii?Q?qiIsoK0XiHvnH/sYvJZRn49h3ChFbOb+fopV/otYa0MgBcOVIa1K6hL/Wd9i?=
 =?us-ascii?Q?EPi9XQODW4GGua7yuo1Vzw7leRPtEyYesnvdEm9Bqr9+1qaPALWS2zTghqgd?=
 =?us-ascii?Q?YizGvHsbUrsHLZpbs+zJuItgSLr5bNkXV4evXbNk1J544ouJLUdcxtfUrvqS?=
 =?us-ascii?Q?K9bCvoX8Cu1WpCC0U4c3FZOHUdj9e3yIC/vdYsa1N2u82KE5daO5JOFwB92H?=
 =?us-ascii?Q?dECcA2+RKxU2jNiBYNIxum4sCnzDXi2hAO435TGIrZrv3XXGkeLUU/URDf3d?=
 =?us-ascii?Q?ua+l3Kl07fhF1HTrz/18UqVnFwHece7lvtkhbpvjH5zmTqz58/W7EnoKcFH4?=
 =?us-ascii?Q?uYAv1mVTX4XA2IhzaCvHENm3Nh58KS/0HQ2kFM0fzQEJU3DHGo7BIlfIekpt?=
 =?us-ascii?Q?VZ6dZ58DpvC5YriUFHx5q+fjXmEJRQWjKycdsow2EOt4Ho6UuFLd1dNhPDCr?=
 =?us-ascii?Q?I5f85Ha2M1Zg7/Z+6cIBkwPiSlVlzvgYinmdVg8qgPKD/2dzCyGuG+dUCH+d?=
 =?us-ascii?Q?sS/EHT1y9ctv8L5PoyUsN/nTyAhP/g9ZjbyxQQ9bP00WunXNXO2BVHX/Y3sA?=
 =?us-ascii?Q?+441jVSMdM2KTUhkRzo9kG4n1dpiEJUQno2LuyurcpHOGzKMJ0TefijZ01ar?=
 =?us-ascii?Q?HkKPjDyJbXvzWzxts9rwBhs8EXNyAI0CFa1JULSTFvZ0HhIITMBH4oaKlTFp?=
 =?us-ascii?Q?rjFzJExdFvN0eYfPIlb+vJPSVMNGR+17u6NKqozCTVrNIkI5yy+b/MByj+LG?=
 =?us-ascii?Q?c/QWRpQZn0O9VzvQj67iRC9MFDnF5P5oZ8X8WQLRE0+jyhVlqQupA6OKrQsh?=
 =?us-ascii?Q?fbGyyTFPxOVIAYpDFYt0O4qhHE4cU0FWj3HInKVb+WCpTJ8P3ID8O3yGL2Fn?=
 =?us-ascii?Q?NrRbe1bCQt4zl7ULCErgQEWfT27G6ZnQLrVXM46FhgNxMbfd0XJAFEM/x4lO?=
 =?us-ascii?Q?VNlM9+Ez0fTCqbhlUnUA2KRUkEIm7WS/3FfTV0l80/F/L/dGlxhZ++eKeFEc?=
 =?us-ascii?Q?S3avewGRyiVs2WQo345X/io2HLYjffrT7omwphLgYNwEPUZcTbEguwB6/iqf?=
 =?us-ascii?Q?KN0IjXr7Wc0N0Ud/HLnsfyBSmmWxoA4ATAx4peF07rQzfLBXBn/+HsSDwyR7?=
 =?us-ascii?Q?voY2a63BfKFmbMCqdZ/kcmirP8t7Rib2U6qxLvNEDe/zCPyP12AE964TXjZ1?=
 =?us-ascii?Q?474BjYcTzUyuCbaH9fV2JVNixfkm+/bbKp4CVI2hAlwbsOcnujoLx/wf/eVB?=
 =?us-ascii?Q?3AqB2+VQFaa/8P4b83b7eaS5KODOa+lQW/ilnNNxQH/1x7YBV4JXd8Rvc0rj?=
 =?us-ascii?Q?x1l96bjbBKA+9KZP7dBN4HXz1njU8wkMvryY+x/ni4mxN1A5g2gENg1373HD?=
 =?us-ascii?Q?iFw4P02beLxtyIu+C5Iu+K28wy8+AtV3aaSgnaJj61Ot3BCl6LjXVpk6/jfu?=
 =?us-ascii?Q?0mvEDUWa2xK7fyosrtvBLep1RN9X82LkUQ/OgQMPhIen9gZ+4I7GcDeMLsGm?=
 =?us-ascii?Q?2qjICjTk1S1UUmvn3MKNQLmEwtCaW49gNW1ywJtm8nP2irx9Qd/A/uASJBwx?=
 =?us-ascii?Q?/Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EB31B57F08FDB41B1F1E028707647F3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/t3ehSTNtfHSFdI5cGwvQkP/oFBXhKx+sOkz0AlNq0rPOQF+EPLdkw75qwAkAYLjgYchXbh7MDjfDzoQ9pOFwWEAUEZKc0pQWf5IK9KvSdJeuAK2mJdZcWd04tTM5sL4UPopF4RhNdvtSbZy/LfaRXwAWG8TVFYHhjfsrbPJPnm3D9JWd5dtfs7ecfwoVPgiRWJMVGQ48aGTVNwDUaMXNuMWSK/IiPamnsg7f5v39UA1FG6bRxUOdm3pssBKf1f/tblX2x0ahpe1VALk3EsO9GP7XeijcKOpCCkardvrN2Ybp+N4D3pwHqiKw+1r9uY1gubB/PDejFeCZdyxU3rsEHfp1rVdv8x3WUUQQhBuekqkmbxlTA4uswqqTE3xAMidr/MgZIq0zVHWWUEBOCf1MCfurmBzOjAGliyFEMAUJuRe5YL1CpWUQ+Zv8Us+68phqEOQB6i1aXNpCNrXC2ZuDzZx/nFQQLpUfRxjKrwhqNGd1sXNzdGaVAzU7hEFn+hZdGH/YcUKrTHum6DGu7Xwb5NeTJtkAjkCiRSQYE1RQpHsOQD0sqQNYuXJ99bFOw9Ie4MhikfOimP5/QhkDVNAI9KkBlkKoKUTaIqkpjlBGbGALkOKjSrEeK5C5jQOmwv+
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c504c08-cb98-4488-c980-08dc8b3e4ecf
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 00:18:10.6099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvdsXJ2wbRjKswHjPW0LQIvetRPESsMo7+rP0i4oPxXbkT8EI7rQnQA4AaLX3OYGhWu9NMyenPMwkx1ab1dUog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8357

On Tue, Jun 11, 2024 at 10:45:09AM GMT, Johannes Thumshirn wrote:
> On 11.06.24 11:06, Naohiro Aota wrote:
> > When creating a new block group, it calls btrfs_fadd_new_free_space() t=
o
> Nit: btrfs_add_new_free_space()

oh. I'll fix that. Thanks,

>=20
>=20
> Otherwise,
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=

