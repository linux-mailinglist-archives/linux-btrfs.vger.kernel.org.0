Return-Path: <linux-btrfs+bounces-6090-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2E91E0E0
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 15:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12A828118B
	for <lists+linux-btrfs@lfdr.de>; Mon,  1 Jul 2024 13:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C388215E5D2;
	Mon,  1 Jul 2024 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="X49Yurjv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZTyTAa3X"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27CC82C8E
	for <linux-btrfs@vger.kernel.org>; Mon,  1 Jul 2024 13:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840970; cv=fail; b=qzaomRKNu6j1/onUtmf4GaFgktwQkXnbnnRxJdXzIpfmzpuqE5jvtvZTBlSW1QyEhoadjNRzER8y6VWGflsjhdvaEBi3jMuSfJmMaPUI+1mGfqEsUVXXhOVGCvp6xWCWWpJbIndhIfhpUpN1MXBcj658ZDPte6WFc1NQJmOuOeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840970; c=relaxed/simple;
	bh=Qac/uI03vYpnur3A1c++N9uHgWdh8eeb1tlJ4umFVyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UQBI/1ejqSq7zZsYwdYprdmInWV96j98juvDQNargQjohT9KMFWGYHv4Qr21WxkPkGVL6YhyrBa+iXauHiHcUjWv6b9oy5rvFq4vTWc88DwEJfTH0VigoTbbvSH8qZfeqb+Jv6f0sCLdMNwt7n/OeSNv6DvxBSQJqYYzMf5C9Ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=X49Yurjv; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ZTyTAa3X; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1719840968; x=1751376968;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qac/uI03vYpnur3A1c++N9uHgWdh8eeb1tlJ4umFVyk=;
  b=X49YurjvL0d7dKPNgAzkNzVYTiVQtJTp3Vk+NXnMSHTqOxMij5YCjTVq
   vUbsf1x6yIbg7LlOfJ8QYvNOBfJ5UGbVT495YUstkq5BGhN9Dp6HvIPi2
   3ngkv5tb6mvr1uDBTthKGL+F5cMu2cjfeuuRqyBUSlHvDWd4B6a/jtMpv
   PUDXa8ua7j1u9JqSfTDu9qt7kWOGtlJOu27jcCZCSJBqBvbl04a864SUj
   0w5CE3GF+KCvEXMqiUOO3E8hUSiTzdpW/XltkoD6ywHcSnkcmbCeVLCWl
   Ooo0NVEU2MqksrM9vy2C4g1oRXTy2hFZ/jhSmrSPmXCwO3AhR7Kn7eV6E
   g==;
X-CSE-ConnectionGUID: kG4ZGTCnT+mV5joFttJ2Cw==
X-CSE-MsgGUID: cyPKwdLcSXeuhnYQQCGUMg==
X-IronPort-AV: E=Sophos;i="6.09,176,1716220800"; 
   d="scan'208";a="20605590"
Received: from mail-bn8nam11lp2174.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.174])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2024 21:36:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIIqrILjzYDVLHdI4MeCRKjQqVW7BG9RhXvHFsCZYw3AucxNHGKBr0RrtzmvjPOizlGLVhiU1swwFI53PWyFgfKPfmKzV64OpETm9+vvE4B+2tjzkUFZgeF3aKtE9BPCN+HEdRP1+f2ZcJkgExZkSIvUqr77zjJnb0B9Qrtyshvlcp941PUWD2Tik7QfQR/M5FUocIWNFyp9KeNOtHLW+LL0KnDp4qxTrrkiS4B8pgi3Nzd11qHHFG6Q8goAXLwn5PDuD7vsBqUL490pd6JMSZ7pSu4UzxKiwB6gSex88u9s6aCttx3E3yverWMPAlFhBTGPoETJT7SfAAQyenpU/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHmhz+uoEHvBn5YpNXsjLh12Ideruh5//eEvPjdcEKc=;
 b=OblHx8Flw6YMys6WwuabUCrgdg9UNPvL0BbxUd6eWgg8tbjlm0WmPcrAub/cUZr+BtEe2QkkhFRRl4vUKvQLrisMX/dr/yRkQBpzmlMslnoKjFBlPd9+BxTNC2XXTZP8sXAee6zyjd0hPvMtpA//9B8RA2sGJ9Rgd/eLwmZMt0bMEeLSapzNgE8QUhWB1yUyBa1DyE9y2Av+h+rCx9BAr15FcwLlXkeu3PT3Wc4Aw/6KC+wX2RA8ZlWvjuxFb6NVoZdjM6ww7vCInYDd7r8COHQ74A7T/UVJ0vHDY86fOnMnoXznZotWgIR0pjU+5k1VHc27G4QVf9Bzhsb0mwK3Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHmhz+uoEHvBn5YpNXsjLh12Ideruh5//eEvPjdcEKc=;
 b=ZTyTAa3XDS3swHtqVfd8nz2YPm8ZydOUb4yIHP+rRNwbn9cCaqR6Q4iTU58x/gLNDrTWCNIgwxbDQBlYk1TLwE3zLJmWoW6QulzF7ocAWAtnbsjObBnKHoAR/rSTiB7g65lUTdqARNwYcMHNBIQp5V0a8bb3xcZ9BEim7cU3t9o=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by MN2PR04MB7135.namprd04.prod.outlook.com (2603:10b6:208:1e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 13:35:56 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 13:35:56 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: David Sterba <dsterba@suse.cz>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Shinichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH] btrfs: avoid possible parallel list adding
Thread-Topic: [PATCH] btrfs: avoid possible parallel list adding
Thread-Index: AQHayRZ66O6rWExFRUmxidXXuvxvtrHh3osAgAAGeoA=
Date: Mon, 1 Jul 2024 13:35:56 +0000
Message-ID: <oqcpk2hqam7jwhnpzvzgwj5bqcjyqxia65lx6pe5otfraqxx3e@62ean7ayzwt4>
References:
 <58e8574ccd70645c613e6bc7d328e34c2f52421a.1719549099.git.naohiro.aota@wdc.com>
 <20240701131244.GB21023@twin.jikos.cz>
In-Reply-To: <20240701131244.GB21023@twin.jikos.cz>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|MN2PR04MB7135:EE_
x-ms-office365-filtering-correlation-id: 3daf8887-e8cc-402c-0d0e-08dc99d2bc94
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dDc2o4bO70qNlmG2WDYZ+p3GqLWt3UR1jHHQ298Q+09woTDac1yDpyaiOgMZ?=
 =?us-ascii?Q?N74hrMaxmwgrVUsj7K6KyfixcLVk0p+W42hgsz+oTCwUvhBuvytSeWils3Z9?=
 =?us-ascii?Q?BjgpkiHzf+EV6+AggBlU5xwx6hgvBlBXv7PN5mZJB6jnbL7Dc4620K0OB/Wl?=
 =?us-ascii?Q?sTZPBUt/wiFYwHZRvygI/aZFPE1EsNGgQ7GjWatO16AZfV6P/DqrECWYixaR?=
 =?us-ascii?Q?Dl0Dv+YxYeeOPWR0MFEksGvr2JfagdjJVKZUf/KQAiuvc/s3eNIL+SelrhGh?=
 =?us-ascii?Q?yo59WjRGk3wwMSzndQaqmvEN84ICdPB96aQj9lI4IMZheBFbtZIUNx2nDTtK?=
 =?us-ascii?Q?gvvJMRc3UiiIlOoZ62hMZbF2ngnrPbz7iN5LPwyOGLs3jS+w0Ta93k0Jpcd9?=
 =?us-ascii?Q?vl57xI6qOmeFobMGOm4p/ZvQ2bWGKXBTAcgmjoZkZy3/eJe35ZkCjqoFiq9g?=
 =?us-ascii?Q?LVjktQ4VNdWh7+jJeyOjZaGWcPq3ug9h8X0jBZjifOrslKmGI8mPC0OlCAxN?=
 =?us-ascii?Q?nqXKNXk+611PyMPxsEkyJwSr+jwjBrQ/UEmfiRAup/62g+ei6/Q7JDJYMGQS?=
 =?us-ascii?Q?54TnlJ50xeBDnHc0CljmlR56fU2o4ry6QeYGl+iYqhXhuiZJLqxxXNuVt6yh?=
 =?us-ascii?Q?N6F6zc9gSdNmrPdJTNndipwlhz4T2YpeQb8bZn7ceoaX/s9mltqmtp9MsYMw?=
 =?us-ascii?Q?VPA37FGs9t0uTMyZi7FVI9uYOpRbNBGBxs2p5TEKQTSjHAsV0MDOtGdkMP+n?=
 =?us-ascii?Q?pTMG1EqQgKIMy4jrysVyBJVmr4LKM4yvQ4Ap4FFgfUVDb+KNYErbjourYxDK?=
 =?us-ascii?Q?R9mLiSLikjaFAHfC/EOBInzDaGPIK4ufb5ke2aq0V7gT6Qg1ezDU9hN7zqQ1?=
 =?us-ascii?Q?MC4nQAbh4z7M6cKGBBezVSOL9je/kmpsXxfQgZhtM8mk9NCG+p6YeO1b+ZJg?=
 =?us-ascii?Q?rSKeeGcA6dwnSXv37xDyJ3LXE5IKlNZkvRNZ8aMQa9JOPmAfMv8wc7TSk4zQ?=
 =?us-ascii?Q?fwqYmOf2BN7bSX2O+R6xelN3aXefVlCAzIcJ4fS0YifS0phllq/sL4eA3H4Z?=
 =?us-ascii?Q?IgannDlKAjR2joOnZXfm1+95Op8zyhfdF53prB/0qEz1JvFOQagMmzSQUr1H?=
 =?us-ascii?Q?7nBMaX+HAgrzW5dm2H8k5EiZpfxifd4ncs/l4gNKX8cpG1wwurpaertYUprT?=
 =?us-ascii?Q?3I/6wEYamtBUCji4raLtOf+twbd98dMYVW1eTHqUNPOT8ZR70qD0LJfiJRyt?=
 =?us-ascii?Q?d3kIWf4J3XE9y4r5JOgYECez4UuliActSSmRZIejqYHxMcv3ky3cbdBWzp31?=
 =?us-ascii?Q?ZNgVesc6nxbdcljK+KbVAgG5pvP0VwPJ9lcrbWa+gpH1sEV7CcGy7GnFfYyz?=
 =?us-ascii?Q?pMDHZsmUTAko1flbFG8LYntb4CnfPjaq8NjkAd7G7DqBCWjDQQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TTFJgzzOz9UgE0BY4AJsgFHGxYv+QoHE+ReRO2VK2WF4irxVFF/J8objuK70?=
 =?us-ascii?Q?v53JG182Loqkz7+jgKoDOZOSxySUpNjCpsWXp0fBaZto84AF5fxL1eS49X7b?=
 =?us-ascii?Q?DvQnPtmYwBJfLxiBFTpByTRreLkKFFB96xPkZtPUoInzCDdXZOhw19rRY1M5?=
 =?us-ascii?Q?bPgvbZz/a5ftvPZKQcCxsPIOJ9V2yAvLkS3DVjJj4yNCvWkS4VdphKfVLgvs?=
 =?us-ascii?Q?qS1UfPxvOUyJSZv7AEdoAXakmlDW4xPjw0A7jMmL+RLCUxh6pVJ5KlQ2ctpA?=
 =?us-ascii?Q?JIuOumWFpPOGPSV2ClXrgQENV8CscQ2alKrPrU688io1rzSEyVKKRuYhX8Dl?=
 =?us-ascii?Q?AUUq3Z1WwnuKXHHfp4muHxDsAROCq2nYiJTu0IhOH4i6qubYovEXlbMP5gUb?=
 =?us-ascii?Q?YuPBVo0PZOtPvcuKZkCJsQJtnScnOwUlVR9YRLOEnGcfV038HdLWaNka1i2g?=
 =?us-ascii?Q?iwVSvKt7C/Hp6IKqWg61kzjr08U99DpVM2Tmkt39epD+t0FQVhZxvYXqjMuf?=
 =?us-ascii?Q?8w2mnDaU8sftTo3huCjK4pgqmqkkAo+2w7MjxcCWzuVfbr/xUY4Rb2dEiUoE?=
 =?us-ascii?Q?uChSurLr3j81aJwKZtD4uSNi9xbBLz0BHXro66UFv81nTBaZhWXv/DcNpTUe?=
 =?us-ascii?Q?cVJjdMi3rE0p1EwPeuyk7ob6dq2KG7lzohzdwk+h2eOWqNLXqByWB6c10Cdf?=
 =?us-ascii?Q?p3kK/Q+4os9v2mQhc+jhs3RH4Pr6ovPk+UGLw7Qi6eXUjBN/IP3xhs0URlaD?=
 =?us-ascii?Q?2yWWzEX2IvrfL8ON+sp+1hm6aFuhXSNOMjIXI4D4u+TUWWBZC+IasICjTJLh?=
 =?us-ascii?Q?Cm5O5rqH1aI7PDF09DeMjhV/gHjbLajB1P3aR3Zciy8+uITwvudcyfUVQm4W?=
 =?us-ascii?Q?gE1UvnKR9men/VxskRThnZj9MFrhjCJIKwknW9rlNCkgtL57cBabzZJkIzBJ?=
 =?us-ascii?Q?b9eOcYDifE0Uw2mFoVnfSwn5CxO387xI7LAjqmx7UItLjDFuVrKkxe/0yZu8?=
 =?us-ascii?Q?LmO3tZ4S/FSUB/tko0yQbCHr8i6HsQw4sY5HQiQCMT18RkuZMjpZ5sDdnWN0?=
 =?us-ascii?Q?/M7XAdIs0Uga3V2UDKCio+8nAwEFsWs1kJQX8R2qJTcgKPkWO6GrJ9PkiU6E?=
 =?us-ascii?Q?ydqRM9lGrmCb8FTkTuBRPU0rtxLWr6Cosp6NrHu85h2cMpVr5jTauE3x4h9C?=
 =?us-ascii?Q?dvNFBHqgGwrPpkWEwFeS4GRKo6FY2TP4EMkCsCqlo8RXWZ+68axlNruEfAnc?=
 =?us-ascii?Q?X8QsEEQQQinLHlAUlcuy1Yy8QrFaHsDFRTF4drTCk0+t5N4fkuX86MlWw9v5?=
 =?us-ascii?Q?Z3sEcDNt/TXHLAn5//6MdkXnZKKbN7YlI0d5cKoUVRh7JaeHXzAmK/wADlf/?=
 =?us-ascii?Q?1kbEOKGxrLATNuHdOEG8rLgrE0M7ssnJPM7uIUsBfOWV7ZHQ/G0hxjkhdMLu?=
 =?us-ascii?Q?Q8WMB7e8Lx0w7qHagXFpFeUMEmHISUyspLfwVNSQ3I438dAugcvHpxmTn074?=
 =?us-ascii?Q?6ywOStr7oTWbIq+A2cw2e0fcR4sw+LuZ/MRwVhsxoJw1ZuYTVwXXfAcum6zE?=
 =?us-ascii?Q?mGcc3bwKcEJzkTaHKHTC3csNS9xIKhG+B4C7LYWzC1xJdQ5kuUu7sjkIoc3M?=
 =?us-ascii?Q?TA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BBA21CA641C5F4F9945854D68C18B34@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n6SchYNVdtoHxeGmXqQ2FEag6DohTV0onbF2Vw2b+GaQn026IwHZFRVKZ92lpyHCdxqajiJMRf0bOvyvGtwgRLYmrvZyoClVdv9XPQeZZGdapa1RMUgkoeebDRXf31w0VkRJeqPiGoV9ewHQc4u7UexjACZIG/CNzHt3w5FUW30Z2oHaK5lIiLjLad8CQPKdvzGzcPoNd3+4hL9lodl1vB2sLc9mjLOt39mgfSyOFDUewhORZLPONMgCBs1lR4ALfPLme+qSR27N+ARRCzwsnDgEIz8Q6If3fWe9nSaGeL5fHcV47i10CaVnEEsRb2XELNsxKjSJp7nnDYs79d+35vgIl5QA+zgWTffstsdVoafrNihZ7cG+mPTFHsiCKSgU0W+cCXOZhpTE4jIlMeMwOHp5yvmLZ5h3I8YZ4LCSDuV8BoD5qZwF7icDavEEBwqfhEkoaDFVTPAHcBE0Mm6OSsfQdeXnf5DhNche0j2mQeFA6WIgUKWNfPbqtIwJ4FNXEJnf2khW38nSRQUgLP+a29YS5mRHhnIuusRICJql2LEgVZK/fafkYMU7CoPavTzS9paWu9hzVSUzWGwwDnT/A0eiRfN1VE+3JZfsCkxcxfdnQpAem9NOCUzcfQ5LciJ9
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3daf8887-e8cc-402c-0d0e-08dc99d2bc94
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 13:35:56.5370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eccoluaw7Dc5pU9rTMXcVhFCXoLWwonHm5+6FskiFmAhNxn1gJxnpyy2wsq0/NNkvX3tPjcZqnClVPnbzBWZww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7135

On Mon, Jul 01, 2024 at 03:12:44PM GMT, David Sterba wrote:
> On Fri, Jun 28, 2024 at 01:32:24PM +0900, Naohiro Aota wrote:
> > There is a potential parallel list adding for retrying in
> > btrfs_reclaim_bgs_work and adding to the unused list. Since the block
> > group is removed from the reclaim list and it is on a relocation work,
> > it can be added into the unused list in parallel. When that happens,
> > adding it to the reclaim list will corrupt the list head and trigger
> > list corruption like below.
> >=20
> > Fix it by taking fs_info->unused_bgs_lock.
> >=20
> > [27177.504101][T2585409] BTRFS error (device nullb1): error relocating =
ch=3D unk 2415919104
> > [27177.514722][T2585409] list_del corruption. next->prev should be ff11=
00=3D 0344b119c0, but was ff11000377e87c70. (next=3D3Dff110002390cd9c0)
> > [27177.529789][T2585409] ------------[ cut here ]------------
> > [27177.537690][T2585409] kernel BUG at lib/list_debug.c:65!
> > [27177.545548][T2585409] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KA=
SAN NOPTI
> > [27177.555466][T2585409] CPU: 9 PID: 2585409 Comm: kworker/u128:2 Taint=
ed: G        W          6.10.0-rc5-kts #1
> > [27177.568502][T2585409] Hardware name: Supermicro SYS-520P-WTR/X12SPW-=
TF, BIOS 1.2 02/14/2022
> > [27177.579784][T2585409] Workqueue: events_unbound btrfs_reclaim_bgs_wo=
rk[btrfs]
> > [27177.589946][T2585409] RIP: 0010:__list_del_entry_valid_or_report.col=
d+0x70/0x72
> > [27177.600088][T2585409] Code: fa ff 0f 0b 4c 89 e2 48 89 de 48 c7 c7 c=
0
> > 8c 3b 93 e8 ab 8e fa ff 0f 0b 4c 89 e1 48 89 de 48 c7 c7 00 8e 3b 93 e8
> > 97 8e fa ff <0f> 0b 48 63 d1 4c 89 f6 48 c7 c7 e0 56 67 94 89 4c 24 04
> > e8 ff f2
> > [27177.624173][T2585409] RSP: 0018:ff11000377e87a70 EFLAGS: 00010286
> > [27177.633052][T2585409] RAX: 000000000000006d RBX: ff11000344b119c0 RC=
X:0000000000000000
> > [27177.644059][T2585409] RDX: 000000000000006d RSI: 0000000000000008 RD=
I:ffe21c006efd0f40
> > [27177.655030][T2585409] RBP: ff110002e0509f78 R08: 0000000000000001 R0=
9:ffe21c006efd0f08
> > [27177.665992][T2585409] R10: ff11000377e87847 R11: 0000000000000000 R1=
2:ff110002390cd9c0
> > [27177.676964][T2585409] R13: ff11000344b119c0 R14: ff110002e0508000 R1=
5:dffffc0000000000
> > [27177.687938][T2585409] FS:  0000000000000000(0000) GS:ff11000fec88000=
0(0000) knlGS:0000000000000000
> > [27177.700006][T2585409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
> > [27177.709431][T2585409] CR2: 00007f06bc7b1978 CR3: 0000001021e86005 CR=
4:0000000000771ef0
> > [27177.720402][T2585409] DR0: 0000000000000000 DR1: 0000000000000000 DR=
2:0000000000000000
> > [27177.731337][T2585409] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR=
7:0000000000000400
> > [27177.742252][T2585409] PKRU: 55555554
> > [27177.748207][T2585409] Call Trace:
> > [27177.753850][T2585409]  <TASK>
> > [27177.759103][T2585409]  ? __die_body.cold+0x19/0x27
> > [27177.766405][T2585409]  ? die+0x2e/0x50
> > [27177.772498][T2585409]  ? do_trap+0x1ea/0x2d0
> > [27177.779139][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/=
0x72
> > [27177.788518][T2585409]  ? do_error_trap+0xa3/0x160
> > [27177.795649][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/=
0x72
> > [27177.805045][T2585409]  ? handle_invalid_op+0x2c/0x40
> > [27177.812022][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/=
0x72
> > [27177.820947][T2585409]  ? exc_invalid_op+0x2d/0x40
> > [27177.827608][T2585409]  ? asm_exc_invalid_op+0x1a/0x20
> > [27177.834637][T2585409]  ? __list_del_entry_valid_or_report.cold+0x70/=
0x72
> > [27177.843519][T2585409]  btrfs_delete_unused_bgs+0x3d9/0x14c0 [btrfs]
> >=20
> > There is a similar retry_list code in btrfs_delete_unused_bgs(), but it=
 is
> > safe, AFAIC. Since the block group was in the unused list, the used byt=
es
> > should be 0 when it was added to the unused list. Then, it checks
> > block_group->{used,resereved,pinned} are still 0 under the
> > block_group->lock. So, they should be still eligible for the unused lis=
t,
> > not the reclaim list.
> >=20
> > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Suggested-by: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
> > Fixes: 4eb4e85c4f81 ("btrfs: retry block group reclaim without infinite=
 loop")
>=20
> This commit has landed in several stable trees so we need to get this
> fixup out quickly. How hard is to hit the problem? It's caught by list
> corruption detection but this is most likely not enabled on distro
> kernels so it might go unnoticed.

It surely occurs when I run fstests generic/166 some (~5) times. I don't
think it's directly related to the workload, though. It always happens when
it fails to relocate a chunk due to near ENOSPC state. So, I believe it can
happen easily on such tight space filesystem.=

