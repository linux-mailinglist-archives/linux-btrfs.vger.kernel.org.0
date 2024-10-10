Return-Path: <linux-btrfs+bounces-8776-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0754A99811A
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 10:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77CD51F25E17
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Oct 2024 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9051BE841;
	Thu, 10 Oct 2024 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f2GrkkyD";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qVpj6MA8"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9A13211
	for <linux-btrfs@vger.kernel.org>; Thu, 10 Oct 2024 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550440; cv=fail; b=W9Re807Tms/xIuWsNObbnvDDejueNZRiJH8XDIKOyw6qYxSKALxI1zXi3JGXqV3HNUHhwH+9x/dSh0l7KMVe+UY4vOr37NuOa/LyeEpDYEf9FkxxL8wCC93l0L+fj3Fnwc/J1Ty28ruwEGByH7XDrEFx9HgDs0gIgbir9zIr4RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550440; c=relaxed/simple;
	bh=4DBhxpwIl3RxNz71mlA/eJ/uuy1+cMOE8Iir4RqL8IY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kyFwj6tT5PIBrzI3eB0QB3Sb5rMErECEIlfRlUSfZKy1wTFCTRTtzAfiXb54Kl3Burvh97+4If5WH+MVI/dnqkoQ0vDZ9xeQ15htaTgWVr5NhkFm5I1srHNKOFW2jTO8wbf6uh6t6wW+negGCKtBBwcVq/7fD+dY4CHfgvzRxws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=f2GrkkyD; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=qVpj6MA8; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1728550438; x=1760086438;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4DBhxpwIl3RxNz71mlA/eJ/uuy1+cMOE8Iir4RqL8IY=;
  b=f2GrkkyD3jpenBOLHhlrD98fcy5ARPGlMCTok/M6ryrtwCE1yf3kg7u3
   nG9Xl5Ndh1rLGmkY2UPh1CyINqlfiEBwqrjr+ahfvf+vj7/QokPDcfY27
   +tPGwzivcY97aT93YoXm87JDpxEqsHQ1b/vxKARQSUfXLdZVsSuOCuo+5
   S3FGlAy1H36+WVnsB9v42QoJTSDMxsMJp2YTAfdPzOsYgYpihmmxb73yC
   OINsDX8UfviJDPNNCVauRNqs9H225+5bmA/z4Xw4EUnMxIMZjgv/JUNXb
   o7j20JgIdp9vCtD3Stu0qfmUuRmPqbnvdX6asEfjwdg4ZdUHgww9tISbC
   A==;
X-CSE-ConnectionGUID: wZlnLEf/RIqAbLftngl+0Q==
X-CSE-MsgGUID: zNK9KsNsRmeR8/4QRHn05A==
X-IronPort-AV: E=Sophos;i="6.11,192,1725292800"; 
   d="scan'208";a="28055122"
Received: from mail-northcentralusazlp17013058.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.93.20.58])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2024 16:53:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/NGhU7GXtjTgeKPkoxordeIzMHJifgWgq5Nyln9l67/hdH2T8HLxpS9hqRJg1ni0hHgjoHGQnn0ksPGLJ1Y0yGZ0yN1VCci6TALDkoKNsHJKHM2hrfTnmpQtpHbO8NoYE4HcDyzba27bngAgCfjOcQWn3xq/01b0QIsR9cPmnnI9QzQAbXNVtVwJT1Ce1AwvUOm7LuGeECRjNIkSW2RY60bvZH1lKPYPbS+8XK2cOnTP1A4iszuAMx+puszuxuOFt8kbjxlQgL2/9gXkwmt4QPAx8i371FfIgHCmsxqgY6hTx5rg8Go4IyOo1tDIY6WZp/TKr8I4y6yG/UiE2Le7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=se28FLNWPftmqzaDekrDQ9acjahtx9bOs0Hx9MnZM4Y=;
 b=nFTtrg3neNlnhwNOebDVOQ3pxCRO0i29NWeYa2BTmh5u4fAfodCWn4jAe7plR10v27auDhLWvR0xiIKCCB+xRKXsvalTJNFAqcJ5QMP2UAMoe3JMgAwA1mOecvscwvDplm+BQfBmJod6ZUDNnZJNhF3wJYS6lLlgPXjak6/UqguIFFoBwXpa/5OF2HRKNjAdAGbE2kqZWvhlgoNKwmi4Q2nZLmZjgJff1v7yyKIC6YhzAWXwa9E8WG1u6UxRutyCCJCsTCMW7csJOqBkHwhVoV+HpHeaumjObYNzS/0JWtfdkIZ/WsTt/sNfcoTEHtpSPF9kd9mWpa9A0QxGjfL6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=se28FLNWPftmqzaDekrDQ9acjahtx9bOs0Hx9MnZM4Y=;
 b=qVpj6MA8K79owEPF0HxV9VviVPVcaZETCm2/j3SvUYhCS9VCh5w7Yqjn87hVPFYrYTgwvf4tL6X6UIeGys2dvIu2HP1aOM/1naxkbWf6sBEyHRwAyxAIXYryDcm8e7FCrDGce4YEh0Dx9VSQrE3gjDsUefQ2J1n63yJYFvnKqF4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SA0PR04MB7402.namprd04.prod.outlook.com (2603:10b6:806:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 08:53:52 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%5]) with mapi id 15.20.8048.013; Thu, 10 Oct 2024
 08:53:52 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: hch <hch@lst.de>
CC: Qu Wenruo <quwenruo.btrfs@gmx.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, WenRuo Qu <wqu@suse.com>
Subject: Re: [PATCH] btrfs: fix error propagation of split bios
Thread-Topic: [PATCH] btrfs: fix error propagation of split bios
Thread-Index: AQHbGmQKc8ebTW6DfUy+t8NONhFyRLJ+8nGAgAAFbQCAABRgAIAAhMoAgAAeCoA=
Date: Thu, 10 Oct 2024 08:53:52 +0000
Message-ID: <zwr4zs6gggixecwyapy7ghay4bjp3tsekqgzj3gswxmfn5dwyq@cu757ssku4p6>
References:
 <db5c272fc27c59ddded5c691373c26458698cb1a.1728489285.git.naohiro.aota@wdc.com>
 <1865ebe2-ab9b-4db0-84bd-9f4f6309eb7a@gmx.com>
 <5c363f14-c3d3-4d5d-bc46-8b38d2bcd08e@gmx.com>
 <8f76a524-aa49-46b2-aa44-33f92fcd00a5@gmx.com> <20241010070620.GC6674@lst.de>
In-Reply-To: <20241010070620.GC6674@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SA0PR04MB7402:EE_
x-ms-office365-filtering-correlation-id: ffbde9ca-60dd-4305-22dc-08dce90910b9
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aOLOnSdobtNvkgZXQp+XZ+Qd5eV/YIsof2AgDuOE5jElaYKM8XYkNDAa+KUG?=
 =?us-ascii?Q?vukeQTMh4HRa7XQa8XTxamG0Jy9JlpA+5BID2+jvMjIwX+IdrwEQYKlAsJxg?=
 =?us-ascii?Q?SIDO0x6QvXmEuXvSJJs73MiLx0bEJ95c4F2uI/rB0iZGdIZtaAY4KX6uobtv?=
 =?us-ascii?Q?iLYWqoq2jWu6qB9ywKYaJlXOhPTAjY97EGmUQFQTwWPKtr2ae2x99A5FypxJ?=
 =?us-ascii?Q?Qm3kglEVlVIv6hxq4qk5mTqTbMtaSgjshJRea0FmJe5FEJ4R2afl7TDZvckY?=
 =?us-ascii?Q?H5QKuv5HEdMYYJ1lceVqdji0EiW3kJBuoFuR2k47E7C70+E8EH6L6/5Mf+Kd?=
 =?us-ascii?Q?ELYNdgeV7P5SyoJu4v5cv9WXjEVZsr2/yfymuiBIq/5EBw2Sxa8FrGOkRGyR?=
 =?us-ascii?Q?acV7PET07wiCeBj6B6uK0qaXp80f/nE53T5NBckWgJ3R6LjAbsLh6G5CuIXD?=
 =?us-ascii?Q?kkNtJeacR+fFA7eFMHNQlh3zSghCNlFSSlzhuv69gGCIGdcoz1bw/9ZG2egk?=
 =?us-ascii?Q?RJcN2H1u/TkOZe2sIt3k4oX2fGhC4dqwq2R8yXBr7vD1a7vntA2IDV+2j3oy?=
 =?us-ascii?Q?+1kWnkqE/jnGwdRYvjd8vbnsaridAqWAvx/YEDL0iEXc2okH+NuCSeKO2vmp?=
 =?us-ascii?Q?4J02E7URAkqVZYwfMiEhG/evIqs+q21AlkUNfkH6DgRpBrOxXJXHhB2AE+WO?=
 =?us-ascii?Q?Wnw++fyor4hMfDe39GYSK1OZCDgyv5kPYAdZcEBD2i6xYvLcCO6TVqqXhPV/?=
 =?us-ascii?Q?ePStn9EHxr2wsZ03FyCDtMhEQTDrC3ygxtCKq6jkMv8qgUzfrEPF7iCN4qgE?=
 =?us-ascii?Q?jkFECWIE0X6BymNaaHTKxZqJjiEPt48UBDkkHgtDk9xioDKaw+NPJ5Iq79om?=
 =?us-ascii?Q?ZXRGLJWhvgpwC328J4EY3rv3YqQ0vYQgRORmgVrMZPA5JfLqg6HztGoCsbLD?=
 =?us-ascii?Q?NOUE6E1PGV8mdIlcZBYet4hfYwjwhSjo0p/N7Pnkp4LwfxFxbUhtFqI0UYEz?=
 =?us-ascii?Q?hJiPT2lSp9YImvlttghRQ9IvV+z4RKrerksctTAuj+gkecYC06pplsUHk5IF?=
 =?us-ascii?Q?Ls4jgqDqkshWj2h+5P5RqyL4d1/5opJUSRTsgEIoLjHSBj/g6dWrxnR6/NFx?=
 =?us-ascii?Q?4LCz62EbTCHJDMjKvpyfCqhSQVZcCP3qOlXIe/RokveK6C2DLI5ZHbUn/1jR?=
 =?us-ascii?Q?tQSQSmkSAU1Rrx5nLyNndeGDdJUz4Vk47vtkvVKkRxsRKLNbeS54pPpjy5wO?=
 =?us-ascii?Q?mNlJ/xxmVMhX3/N086STmPKgfI+5xi2kjLYdrrKAD0rTb6sLytXeHCwdzOIs?=
 =?us-ascii?Q?33WtU4DacuzMGCeBu9JdeUwmJSsp3lgPFBl/YJGxExNNnA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?08pALOJrur2mqP5Vo2lnviemdzFF4uuMKwFs7YqjFemEYUxrwClikv84DtX9?=
 =?us-ascii?Q?9Sksmqo82WxV7Ir+hqHAW3iCKiPFKiYnA42r//rklBdGclORHdoV1/okSSsP?=
 =?us-ascii?Q?JuwwoxBYh6OPCEr6hlllQURPLqRyKcK9Ua4z62LSOJmw9DIPXOBctXKvSOMR?=
 =?us-ascii?Q?4WDtdDxnTfSy+P+RCLY34QiNeOVNNoas8RsxjWNoWFt8J8+/iAsXbUVRjQZC?=
 =?us-ascii?Q?al4lZZwg0PmrBcLxAA+VvgoRbyawyX9e/AnrSEX3oQ8c4MOtOmnSrh+Hir7R?=
 =?us-ascii?Q?AuQ0M2e1KCGFLcCsSLQYQnJKJQ9DsMQAHoQvO2WUZP+oe/c3S4cR3hzeWRhA?=
 =?us-ascii?Q?k5q2dg62wRLvEHRbkmU3g/BYSEbjTaiUlIFLnqT92YrvJzGmtL0Q5sjAfg71?=
 =?us-ascii?Q?2POXWhMANpyX8llkttnaJuwMJCxLDtZROFkTav0r+VUT1dLpkEgC2U3+4u4/?=
 =?us-ascii?Q?t6PeZb9imHN+XBzuW0PPf3d6H5YXTgBdJ+tdyZw5HbyG09fziyvYoCzXnizB?=
 =?us-ascii?Q?Hji/lUcGSAPZebCK23uzLoAIFj2s6FvEaikWC1lAhLBhIMGb30iCGFhPq1VV?=
 =?us-ascii?Q?406zlFo3cDFzVGq/cIm9DUTxz4tntY1ga/+TlSdNCQPJ6/lAOtoHT9hXdfL3?=
 =?us-ascii?Q?zSOMMKojgoHQLjLOH5sq86EHCiROXL88If5HTFIfDMSe3BT8+i0WgWKL/UD/?=
 =?us-ascii?Q?6ycdUegUlkDx+uZUX1TOYE5e+urwBWQ7i7dsceRnA2bm2br8EkjccKxjS6+T?=
 =?us-ascii?Q?iFRx6zbImPa8umNmEXfEoW3VZiTfRYTm4L6+RL3KM46p99s/xt3qvA37YEvA?=
 =?us-ascii?Q?FgJ0w2qU4R90uyRjsEEnrOB5tVvk2rfjyXwJWFQHANng+JsXKYGuSeDGs2YH?=
 =?us-ascii?Q?dMfnMcdk6GjDHZZVcOh8dpkz80ApOiExLZfTV21W+LGGzyfV4GUCwKvkNU17?=
 =?us-ascii?Q?xRn/8PEGoCTFpQngIq4CY8VeuK93n7REHMJjRU4p30+5zl2ieVQ+22T+ZdfF?=
 =?us-ascii?Q?5Bp0nfnVARGWjqOtuB6NgqByvabz68KfYmRz1OdNwUR4Mp6XwegrW3YyuOCO?=
 =?us-ascii?Q?S6bUGIMU71MMUC7Y8KydZM4UTXxyCei/lNfiWey6lV75qD5gyrtmRzQvwC86?=
 =?us-ascii?Q?2jij34DtwVDqrOn3WPPuSNhRbPFpQg0RwVSYHby0A0RxDDNDXxVGbPCmyJBz?=
 =?us-ascii?Q?FZFXEUWNgkLOwu1EMPB3SSA/Uzt5xr2rEYu7GPK1MabOKGILF3pL1Nlgw8Pz?=
 =?us-ascii?Q?+OWun4jTqF3sZsVKVTvTzjTHHMJ8XgYbP6xNaqqLSOQLpoJhJN4jxDhYspNP?=
 =?us-ascii?Q?1AqfmA/PUu0GxI/htpbjGPbxD6TM1U8Qsm/+GMZa0m3xlaeX0Ge3odQPZ734?=
 =?us-ascii?Q?iDC9JbIxsDZJnznJrZiL/S7jiE0hERc8+i4pK1/zlnD8ebBPRfBvhEU87cAH?=
 =?us-ascii?Q?p9EAOentO8luspElS8+mcvMxGUDeT2na9iYtfnBFwhujOH/0nSFLLt+rbthX?=
 =?us-ascii?Q?xann/H6jmrdRJqJVxHBEPjO2uMA2JTeTQhju9N8BBiN7l1UnUNfJxXo9nnHi?=
 =?us-ascii?Q?ybTsCkIHf4FT5iveVFB4/mG7rmy/KajoaWvhNn93TZq3nSO+V6nDmxv60sgO?=
 =?us-ascii?Q?Yg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1E74B4EB47B8F468CC764DB8E67A3A9@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T17TU2y40/T597F5mHdoP7kEvrGdoZ3Qhy2DUj2AUJt7d75eTTR4rZE/1HxhSBcvP1rXhIQqMu7PNUyblYxQRb+HtYcJFQDq1a4TTS/Op0wWhpiud7fo/l8gVzQfSYNePT44f2zI/wxqnHPn9T+C8uzWxiS9fFTUTFH2aYggfhlPTvQYS0BrWaNrbEJD7CeibTSltvSXJDAtESBaogt4IzzQ/y60F6BT0NXmIEDNrcgoMEsPVgS74qBozdCqCT+AC6jduyKG642qWLcVTamY4Lj6tYIjFbj1oZrEwLVHiB+lHiiJf4AOafwKvrtA85fjhfGHNXDmvpMmdQSZBXHh1zGhfKe74PqHEky48s4RQw+RuwwguiHC8pFxcWsxSs5emCYqBpyIZejBwgPi/56W9ZpVCdP8UoxdvUPMKmw+AzJdhMlTU8ht5Z/0LIlMpHIQIGpmGZkx9JG6lzM8jqcfWrCS0Sef1K/TKS4QB7zlZcpaHJ/6icSL7+9QIOJrjn2OXDBQntqumf1Lbl4Kzgqx68OiptpL4/Ce12HHPg/804T9r4hV4MRrAnHLi4uTkM/XSKdZufv4arpHyk92bZF51VIOjTd8v5C2TvsGMU1ri9fyjGTOr/yoH4qdFT0JjLhj
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffbde9ca-60dd-4305-22dc-08dce90910b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2024 08:53:52.3797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSjxWJYyU4MGjqX+3L+jokvbijX0h8zXQSmOK+TaTrQqlJC6Hnrba/covcObLU2BAK4t+quzDA8W70SCSbY2Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7402

On Thu, Oct 10, 2024 at 09:06:20AM GMT, Christoph Hellwig wrote:
> On Thu, Oct 10, 2024 at 09:41:04AM +1030, Qu Wenruo wrote:
> > My bad, this is not possible.
> >
> > The original bio will have 1 as __bi_remaining as the initial value.
> >
> > So even if the cloned one is finished first, the __bi_remaining will
> > only stay at 1, not reaching 0, so the original bio will not finish,
> > thus impossible to free the original bio.
> >
> > I need to dig further deeper to find out why the NULL pointer
> > dereference happens.
>=20
> Yes, that was my assumption when writing this code.  So I'd love
> to understand what is going on here, as it might indicate deeper
> problems with the btrfs_bio lifetime.
>=20

First, there are two "clone" things regarding btrfs bio submission.

One is "clone"d in btrfs_split_bio(). It splits a btrfs_bio by allocating a
btrfs_bio from "btrfs_clone_bioset". It is logical space level split. Its
count is manged by original btrfs_bio's pennding_ios.

The other is "clone"d in btrfs_submit_mirrored_bio(). It clones the each
btrfs_bio's (after split) orig_bio (=3D btrfs_bio.bio) with
btrfs_alloc_clone(). It also sets the end_io to
"btrfs_clone_write_end_io". Its count is manged by BIO_CHAIN flag and
bio->__bi_remaining.

What my patch addresses is the first one, and the above comment from Qu is
about the second one. Let's say the first one as a "split clone" bio and
the second one as a "mirror clone" bio to distinguish them.

We also have two "original" bio. One is an originally large one coming from
the upper layer, and becomes the remaining part after split. The other is
original one*s* (because they are split, we have multiple original in this
regard) being mirrored in btrfs_submit_mirrored_bio(). Let's call them
"split original" and "mirroring original".


As Qu said, when a "mirror clone" bio completes, it calls bio_endio() for
"mirroring original" bio (after split). Since we have BIO_CHAIN flag and
__bi_remaining increased, until all the "mirror clone" bio + the "mirroring
original" bio completes, the end_io function (=3D btrfs_orig_write_end_io) =
is
never called. So, it is ensured that "mirroring original" bio's private
data is properly set at that time. So, it properly calls
btrfs_orig_write_end_io() and we can safely touch "mirroring original"
bio's data.

In btrfs_orig_write_end_io(), we call btrfs_bio_end_io(). In the function,
we call btrfs_bbio_propagate_error() to propagate the current "split clone"
btrfs_bio's error to "split original" btrfs_bio. To do so,
btrfs_bbio_propagate_error() accesses "split original" btrfs_bio
(non-mirrored case) and its private data (mirrored case).

Things can screw up here. If the btrfs_bio_end_io() for a "split clone"
btrfs_bio is called fast enough (or immediately in case of dm-error), the
"split original" btrfs_bio is not yet submitted. Thus, its private data,
which is setup in btrfs_submit_mirrored_bio(), is not yet have a proper
value. So, reading orig_bbio->bio.bi_private returns NULL, and accessing
its max_errors results in NULL pointer dereference.


Qu and I discussed about another solution: using bio_list to keep bios
around and send them at once. That ensures we have proper
"orig_bbio->bio.bi_private" ("split original" btrfs_bio's private
data). But, it also adds some latency which weaken RAID0. Also, the purpose
of btrfs_bbio_propagate_error() is propagating an error to "split original"
btrfs_bio. So, touching its private data is not necessary. We can just save
the failure status in btrfs_bio itself, which is always available until all
the bios complete.

Thanks,=

