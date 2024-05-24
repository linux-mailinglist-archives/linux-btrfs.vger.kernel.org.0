Return-Path: <linux-btrfs+bounces-5273-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E58CE267
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 10:31:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08EE11C21664
	for <lists+linux-btrfs@lfdr.de>; Fri, 24 May 2024 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0105128829;
	Fri, 24 May 2024 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oscgMDjZ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="f2fnddA9"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B67494;
	Fri, 24 May 2024 08:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716539481; cv=fail; b=F+n/GHFX1W4yBYiqahRY5O3o7Gpbmjf+mgmXJsAsz3/1UCHSsk42Io1mvIMK6Vok3X5okOqSUvFUc7uwfQNwzlNGGGIiFei7MbvAlTwJqzdJwG4/AyXzaFQGTdn2PU0Zf4y8gnqJ/oElpg8TRSHEAlSwtbnDioenDAAt9fENYqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716539481; c=relaxed/simple;
	bh=xvBZjgydUFjwmGwyOzZkcIbNGHlCSvxwG73eOuLeGvM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fxfmzQ2tlHYYGtMqqCyGvPE/90IbsatHJhDy3+b57sRyX03brBj//GLs56ofA2cRvhD28x2KaRYMeUi/hMqXmSME/B8zVffknDe6qfqPG/5EG9WUImO2eUyEz+czC1R1FcJ6OuLKmOHdehL7N35LrFCwKUDUb0JaFgdPpBN4t8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oscgMDjZ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=f2fnddA9; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1716539480; x=1748075480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xvBZjgydUFjwmGwyOzZkcIbNGHlCSvxwG73eOuLeGvM=;
  b=oscgMDjZxEaqsWhPUCyCmwyrjjHKofOt7W1mlZuK1egFc+nOaJgCfTFc
   tusjxvg6Rk8rk/aYChjFrGia8VpwpsOCSQxYAdMS9XG4VCy3zQoEc9CNo
   UGRiRNVUtCPnL77r8u95HDJw2fOE0wzvYMux+sLfogD95+6PxScDAYD/v
   halaQdIo3Ha9XEtsQwLP6cgVtyTAVmun+xQaV1ZzolPUvgwtFm6aJ864L
   m+umlyLpVmkwdTWNsibho+V5zKZFuP+egis8GKkzjD3btIe1xBy9+U//8
   ne0eQg4ghb1ia2NKv75BrLwZrmv349nm/x8yzg2eCHsvohNLO+3qZXWue
   Q==;
X-CSE-ConnectionGUID: LmcQBa2lRjCT4VSevgM3Qg==
X-CSE-MsgGUID: D7hjr2RmT926TOGxSBgohw==
X-IronPort-AV: E=Sophos;i="6.08,184,1712592000"; 
   d="scan'208";a="16887054"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 24 May 2024 16:31:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpivUoCWLe1sD1NUZ3Tv9q+phL+B64FHahOWew75rw6aF94zTwMd/VJuO5sSn5dyY3esSAabbmt/NtB16jW6ed5gdiZ0IsLCe5haRe614h0q1fYu2FzRtuBt1gUmCUJsDus5w0JgQ46xRxnddLwhTEOGQ/LH1zVectRo3XswUMeHaPu4EKHUL6+bKpe2RErG5eX4muV6GZ8hFbHXx+To63M1p56Rf8gn8Q49WxvnucpphJP7HQjCygBpghXS+VhwSukaTpIgq5WIxStWcUwY/Fvyv3kmsWHOknCmStgXLBt9ftTG0CceNFJqwF2Yl8QeouOYdMJWNXYCfCGA1UQajw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoxnnY9iWjqaxCqPKzEQnbnsASw9jLRiYzgkolzN6mA=;
 b=j2B9JwYoXN+cuUsjwjhsM7b2bx7UAo3IcAUBxsJulcfM9Sq9ojyN3U05Ufe5qX9ZAWypHSSgYluIIOm4ymQRzRMcjmF2AMxTfXKj2q4qYIcmAVMDZKu3lexWh6LcLdHy/LIfPeIaZSKOGCqG55z7IgJMePUswrtVFDepPmGW3GumfK7asHtOqJxaTKIA+v9MwvWGm7FX+zBUSeeAHy7YaaBPP9ukqk2z7eX95qjGo4MUJ8+YNXOyek0m/tAO4MtCfrW/9S3KC5jcEFWH1VTadxwrYPQ8wdFnaID9q8pCsfaUC2r7CKqHKuFFOc8ce7b/kDdtgNpqsrdF4fi3+4XmBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YoxnnY9iWjqaxCqPKzEQnbnsASw9jLRiYzgkolzN6mA=;
 b=f2fnddA9kCQ+gI45modirqPkegqvCH1orB4vMD3UPN8PtmcuHQ/DAg6FA8lZeq3wmnKGhA1HbEzeK7lHjiEy3LN1tMGRvk+GsIjebw6b2o54OozXABtUkUV4kuEBbNIpHFxgMCrQaWyHoXRSG4ezgR/I4mOwwRG4OagMsvjM8EY=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MN2PR04MB6655.namprd04.prod.outlook.com (2603:10b6:208:1eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 24 May
 2024 08:31:13 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%6]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 08:31:12 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Johannes Thumshirn <jth@kernel.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Hans Holmberg <Hans.Holmberg@wdc.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Filipe Manana
	<fdmanana@suse.com>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v4 1/2] btrfs: zoned: reserve relocation block-group on
 mount
Thread-Topic: [PATCH v4 1/2] btrfs: zoned: reserve relocation block-group on
 mount
Thread-Index: AQHarST8s0VALeEMs0+Cy/hlrfzHBrGmDyyA
Date: Fri, 24 May 2024 08:31:12 +0000
Message-ID: <z62yihzehelx5bbipfb7wjw65ygzkmzo6lagzwg2wqlcefvyaj@7vv6pc53cip4>
References: <20240523-zoned-gc-v4-0-23ed9f61afa0@kernel.org>
 <20240523-zoned-gc-v4-1-23ed9f61afa0@kernel.org>
In-Reply-To: <20240523-zoned-gc-v4-1-23ed9f61afa0@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MN2PR04MB6655:EE_
x-ms-office365-filtering-correlation-id: a715c8a9-fa01-4ffb-6d42-08dc7bcbdefa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/FmQqqvqaR64zs39bXkzCFf4tCjFLClpA4Ijho3+DqnP7o8Cf93FdQEvNwp1?=
 =?us-ascii?Q?5YOKczQF0JppJHEa/HLWPnr0ZCJv3wGecjgh4MmD0NeLtwufCdmcu0hFysMt?=
 =?us-ascii?Q?n86iOpv8/3axfxNJrNjtkcDgdJbRbdVK/4CoMIzHJK1JL5kM+R829rT0vLCX?=
 =?us-ascii?Q?WAHF9xyQiqdf9Xt0pos6h4KeErpSMUVmoTv0E2Lp0WuJ7Mx3/RSlfwyGxlDC?=
 =?us-ascii?Q?k8o4W351ZqL5SxBuCZuIBXS4pGcsMF1mZPwme/Im3NwQL+5ypyIrHrMKPNQl?=
 =?us-ascii?Q?tQTfUIQ4o2fgSwjMR55NCuW0z6av31EIcqOKLgPqIbu4VrFCMU3p1mGWuVQX?=
 =?us-ascii?Q?brRtMiAP9WFtaG6xB/oNejesy2pkEeVTh8tgLYpgzZ5Ad2lTWl3zJ1ePpSAu?=
 =?us-ascii?Q?7LFJZtf3586gsotyEzIohYnmhBav/rmT80KZ9XyPfoWCKU9fGObd2Zui+aex?=
 =?us-ascii?Q?FROfc1vLQpydmnxMwn2xkRTUqRy+6iW+zQSGaQ+fATzHnb2RYHhDlpUOIJaJ?=
 =?us-ascii?Q?WgYlfmIxqj/01XSPD9CxrMsPBt/gRWX9Dl0JWVQbi4A6Sgbadd/lbmO5z1fh?=
 =?us-ascii?Q?9us7ITYG6bUk9vpU61x5FYV3aR9rakHiPhzr2ClO4V6C0oZYastyjG6wWrez?=
 =?us-ascii?Q?0jTBcrKeuKN4IbHMlfK0HU4XFbevk/6WWnT7eJ2Qp4d3e+/WIP5G8OelNy8P?=
 =?us-ascii?Q?pU+zOO6ihwpJgan7LP9BHOJg9xIm7SRPXii1NVg7oZ7ogx3zX8KSsWYjOl+w?=
 =?us-ascii?Q?xml/HuZE949fxbTop0Wzrm5AjnL5eNq3k5yS5ALnMUc1bsbYxBlqO5IQIFr4?=
 =?us-ascii?Q?/n2FgHiXGMgj6WWevnLi/hElufYhlEmB/B3EhnqmwOoQgk1C95a8MIuXK16e?=
 =?us-ascii?Q?7eYIO3qQndYaao/fOEZXQwOWFd0nlneYAMjlZEfIj78ZlmatjFcwmYwe2Rre?=
 =?us-ascii?Q?tYHdu8CiR5NjIiKz3kYykxNhEe7KsUcnQJB6dDx0Kl2GrgUZPrrfC3fSf9z+?=
 =?us-ascii?Q?TvfkQ9Eq1nNUr2yuVAwKG6OFjl6kKUIy8w66kn0SFaXVnf4XpPGPXbA6x6WN?=
 =?us-ascii?Q?HG8uGx5oefBhwXnaGjJieduziqljnQa+lki/w/nF8zldgLylSvpIizhUGg//?=
 =?us-ascii?Q?WUjLK5W2ewSNxUVA0iaXkLxxftbPj3FxAzdOLz0+YqNoGZl5rZBcVFavQ0CG?=
 =?us-ascii?Q?XVadzWIjcmjyA2hcyZ4kWJI4szjK73hukWAlFjex0F7EFJ83BxsT+k5304oK?=
 =?us-ascii?Q?RnDaD//yljkj18WoKHKBGVhhmjNh2enrb/oJnBCSfCkESqUxslkNThr75Xjv?=
 =?us-ascii?Q?tXeFt46Kju12/2e79N0Sk6FNe2EhJ73r2fS1ZctYBs9tYQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?U5cMYuEb4NVzIoU2cLXLGCO2NWy0xE3Q2TDO0iRRx6j3zYYTq91yQoHK0hxo?=
 =?us-ascii?Q?YY0Ahq+JTwLjlkNuwcvrHyLuACzHJP5kEEFolOOIPAr72LlmjjUC4HfLOT8R?=
 =?us-ascii?Q?oW9++0CCx3at2D9cpS2wJoZhTmRgcwCOCqqtN3s3WvrG/3TPAc9eTxRYU8ac?=
 =?us-ascii?Q?cpe9D1shJcgltrN2eO5h9FxlXXAMkSNAejqhz8/U1OFE+mvWWQpsdTZ53xiz?=
 =?us-ascii?Q?kDB7jpAjsejeJVfOZZ1+zhgyv4maiwrfCRyb84Zq/quDMs3i/ZVYkC2zZfKP?=
 =?us-ascii?Q?5TBJkI3eN5GwVAH7PitndOiDgQHshBmi0uP3XvA2FsVHQ8AXirPw+kZtz7qD?=
 =?us-ascii?Q?iuzD2Uv/RIlXnniyaqSsn8sRc7dyuwXZhcnGKqI1/JKgnpSWGhzAmZbJ5/BW?=
 =?us-ascii?Q?7FTHNRsWTHYDs1lpaxY2RrpaxuQtWaM/Zs32UBcQ8E7u/rxaYA2H5XadrWoa?=
 =?us-ascii?Q?+brZJiFTrah4Ecd1094NEMasQG47LbaOAj5YknrMTxuLRJdWzpxx8RSR0ha5?=
 =?us-ascii?Q?uuIvEhuYpRQSbqegNQ/O87gPbhKK8iZ29hJTDF4d0r5yz2BNfxOkC2L1t8L0?=
 =?us-ascii?Q?0fu7oqeFqQUFU6v6v4lRtu3LzArE2r6db1VfJtKG15dqAfE68+zhgR2gGmTu?=
 =?us-ascii?Q?QytDQJXdw9mW+6USovMG3YfxTLaY/ne93WkHe+8mGd7wSjvXsURWZEPoPQNr?=
 =?us-ascii?Q?FBpeGRRwAQcUT89t7q4lN0JXenSU8fZ4i88ZYn7OK7uo6Vhp28oaGLe5ap+C?=
 =?us-ascii?Q?Ug6ZIC5sH8Gaxcr4Worsk+UIfy8Zt33TTEU2tnk7dYnZIa/ahuA6ofpdIwOJ?=
 =?us-ascii?Q?PQVMFrR/Yhu1kOSkBT+xycFd0KkkqkUAwW4qC7jSk27k5Z1FPdmNx0iubzPY?=
 =?us-ascii?Q?Dj6Nke+lGKne+bLU9XS3OlQFDdaE72DYXu3qOSYZtFN0cs8/b+EBz9CXcDoS?=
 =?us-ascii?Q?qc4iLWuRZKXFC22AYqOf5jgskxatWjMnPKkj9412hr3S9tUAqYsTG6J8iC/v?=
 =?us-ascii?Q?ZYfHSPCaTWxqaiTMc+IB5M/YZtCdjyuwaYKn3nTzU77YF3PCpP6POqCOMXYf?=
 =?us-ascii?Q?ah/cWiGDs7qt/lhrYxtZmJTziwvEXfYjGjeNXDy1xcpDnNuYqQHWYOicMd7u?=
 =?us-ascii?Q?9bFBOOMNlPuDA2YkjqVc4E0r4tsReyJBv5OQpzw0Y4GhDtnH6dLFiYJ05HU3?=
 =?us-ascii?Q?1IsMBJJHau9feK6aFvY6JlqgVbdkw9rJqeHdd/GkFSl1NN3iW3f3KuLqJH7/?=
 =?us-ascii?Q?78igZ+bGY5bLj7N26YCBksqjGjsrZ4eAbUnDZBFvemC2QMCppP18/z6mg43E?=
 =?us-ascii?Q?mexUyCybB7A55v3nLLjJkQ5qf5hsxk74Mbc7y4xnXHpXaNFEHFz4eD6zSB8H?=
 =?us-ascii?Q?PZ3almfiTCmZbXqB3PlWSTRuYbk7EK7T6rb3MdXcbo/pp7eur8fG+EUCc5h0?=
 =?us-ascii?Q?I4Tv4skuJ3DJiNKp2z2z+Q8vfOXce96FShD+lSAxO9Nq0vdqjE0VmcBYm8n/?=
 =?us-ascii?Q?mjbuhDiMi5nEN86jgVSsdjv9UUQseDF1txJB0p8hYRqVnWO2vbTIuOahjZtA?=
 =?us-ascii?Q?1+Tzm3qXVvQWf279kivQ3FVU2jVEH75j0c5p7r2n1aa73FXYrS9up6U9xr+/?=
 =?us-ascii?Q?PQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65E9267D7815F341BE026E70E129CCF6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	11xPKeddl8DQ3NzmseMLDAKUjka53hQVosEGzOUWn2FpWqQ+CSCvK3Yfi0l99MROHxHL1qVNQi9YsUmKkgPDlmid29IXMg1x1ydLvgHap18ZsO+DvVY+cdzM15R1+ly8fI3ctHdL1zKoNmqZCE+k/fsn3lwIUXQh7wbM5W9p11nS0CrgyOGGbRIUq54pHI96f4I012IbztpkFfl0dxn5xJ4sbOJ7C9JMcEQEBm4qq0GZ5JB5RUBunRjHZHOCuUHX5RBWd2pM0X1w8fxeqEEeMWMFTyHHsilMe5eO9fD+uSNnsf1xGeHDb3LoZneUh2Nqytc1T1IXNVMyxR+zMhrP0cRiNFv9t1tFuXJWhZCe1CExCBk9HYIg/WD04v52T0SAlX2EmTAGrUCiB3qq4Dm45MC7d4eUV9i4g5dyT8Uo5i9bkgY01l8tOWC9m5XBYnid0CL83RlYrRPPsR8QH6VPka1smpop7aVYgY4zQcLHjntrkYxd8hhGo41X1apxxIgwsJJyHhUwNy1vDGXkvnYfiOsGFNfFVWwJOYwWP4fzDSCWOkgP0RXCZ/J6z0jIEa+kC4ota2FSSy2TUOIPMqx2NzhitCnNoTaTvgHSdoBp3WdvtLvP357uKPcF9NvYEKpQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a715c8a9-fa01-4ffb-6d42-08dc7bcbdefa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2024 08:31:12.8750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aAKu/Q7tTm4rFE57h9AaTmIkx3l+aDL6T1ldd+gMduiZ7buVqWgGh5iQJa53aB0gUwlEmLihR18OPS3IEtDKqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6655

On Thu, May 23, 2024 at 05:21:58PM GMT, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>=20
> Reserve one zone as a data relocation target on each mount. If we already
> find one empty block group, there's no need to force a chunk allocation,
> but we can use this empty data block group as our relocation target.
>=20
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  fs/btrfs/block-group.c | 17 +++++++++++++
>  fs/btrfs/disk-io.c     |  2 ++
>  fs/btrfs/zoned.c       | 67 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/btrfs/zoned.h       |  3 +++
>  4 files changed, 89 insertions(+)
>=20
> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
> index 9910bae89966..1195f6721c90 100644
> --- a/fs/btrfs/block-group.c
> +++ b/fs/btrfs/block-group.c
> @@ -1500,6 +1500,15 @@ void btrfs_delete_unused_bgs(struct btrfs_fs_info =
*fs_info)
>  			btrfs_put_block_group(block_group);
>  			continue;
>  		}
> +
> +		spin_lock(&fs_info->relocation_bg_lock);
> +		if (block_group->start =3D=3D fs_info->data_reloc_bg) {
> +			btrfs_put_block_group(block_group);
> +			spin_unlock(&fs_info->relocation_bg_lock);
> +			continue;
> +		}
> +		spin_unlock(&fs_info->relocation_bg_lock);
> +
>  		spin_unlock(&fs_info->unused_bgs_lock);
> =20
>  		btrfs_discard_cancel_work(&fs_info->discard_ctl, block_group);
> @@ -1835,6 +1844,14 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)
>  				      bg_list);
>  		list_del_init(&bg->bg_list);
> =20
> +		spin_lock(&fs_info->relocation_bg_lock);
> +		if (bg->start =3D=3D fs_info->data_reloc_bg) {
> +			btrfs_put_block_group(bg);
> +			spin_unlock(&fs_info->relocation_bg_lock);
> +			continue;
> +		}
> +		spin_unlock(&fs_info->relocation_bg_lock);
> +
>  		space_info =3D bg->space_info;
>  		spin_unlock(&fs_info->unused_bgs_lock);
> =20
> diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
> index 78d3966232ae..16bb52bcb69e 100644
> --- a/fs/btrfs/disk-io.c
> +++ b/fs/btrfs/disk-io.c
> @@ -3547,6 +3547,8 @@ int __cold open_ctree(struct super_block *sb, struc=
t btrfs_fs_devices *fs_device
>  	}
>  	btrfs_discard_resume(fs_info);
> =20
> +	btrfs_reserve_relocation_bg(fs_info);
> +
>  	if (fs_info->uuid_root &&
>  	    (btrfs_test_opt(fs_info, RESCAN_UUID_TREE) ||
>  	     fs_info->generation !=3D btrfs_super_uuid_tree_generation(disk_sup=
er))) {
> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> index c52a0063f7db..d291cf4f565e 100644
> --- a/fs/btrfs/zoned.c
> +++ b/fs/btrfs/zoned.c
> @@ -17,6 +17,7 @@
>  #include "fs.h"
>  #include "accessors.h"
>  #include "bio.h"
> +#include "transaction.h"
> =20
>  /* Maximum number of zones to report per blkdev_report_zones() call */
>  #define BTRFS_REPORT_NR_ZONES   4096
> @@ -2637,3 +2638,69 @@ void btrfs_check_active_zone_reservation(struct bt=
rfs_fs_info *fs_info)
>  	}
>  	spin_unlock(&fs_info->zone_active_bgs_lock);
>  }
> +
> +static u64 find_empty_block_group(struct btrfs_space_info *sinfo, u64 fl=
ags)
> +{
> +	struct btrfs_block_group *bg;
> +
> +	for (int i =3D 0; i < BTRFS_NR_RAID_TYPES; i++) {
> +		list_for_each_entry(bg, &sinfo->block_groups[i], list) {
> +			if (bg->flags !=3D flags)
> +				continue;
> +			if (bg->used =3D=3D 0)
> +				return bg->start;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +void btrfs_reserve_relocation_bg(struct btrfs_fs_info *fs_info)
> +{
> +	struct btrfs_root *tree_root =3D fs_info->tree_root;
> +	struct btrfs_space_info *sinfo =3D fs_info->data_sinfo;
> +	struct btrfs_trans_handle *trans;
> +	struct btrfs_block_group *bg;
> +	u64 flags =3D btrfs_get_alloc_profile(fs_info, sinfo->flags);
> +	u64 bytenr =3D 0;
> +
> +	lockdep_assert_not_held(&fs_info->relocation_bg_lock);
> +
> +	if (!btrfs_is_zoned(fs_info))
> +		return;
> +
> +	if (fs_info->data_reloc_bg)
> +		return;
> +
> +	bytenr =3D find_empty_block_group(sinfo, flags);
> +	if (!bytenr) {
> +		int ret;
> +
> +		trans =3D btrfs_join_transaction(tree_root);
> +		if (IS_ERR(trans))
> +			return;
> +
> +		ret =3D btrfs_chunk_alloc(trans, flags, CHUNK_ALLOC_FORCE);
> +		btrfs_end_transaction(trans);
> +		if (ret)
> +			return;
> +
> +		bytenr =3D find_empty_block_group(sinfo, flags);
> +		if (!bytenr)
> +			return;
> +
> +	}
> +
> +	bg =3D btrfs_lookup_block_group(fs_info, bytenr);
> +	if (!bg)
> +		return;
> +
> +	if (!btrfs_zone_activate(bg))
> +		bytenr =3D 0;
> +
> +	btrfs_put_block_group(bg);
> +
> +	spin_lock(&fs_info->relocation_bg_lock);
> +	fs_info->data_reloc_bg =3D bytenr;

Since the above check and the chunk allocation are outside of the lock, som=
e
other thread can already set new data_reloc_bg in the meantime. So, setting
this under "if (!fs_info->data_reloc_bg)" would be safe.

With that:

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

Regards,=

