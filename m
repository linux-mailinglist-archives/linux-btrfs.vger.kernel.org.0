Return-Path: <linux-btrfs+bounces-10523-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8689F5D53
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 04:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EB7188C354
	for <lists+linux-btrfs@lfdr.de>; Wed, 18 Dec 2024 03:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BBD13AD3F;
	Wed, 18 Dec 2024 03:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NWMLX8ee";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rrSRlAqJ"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574881E487
	for <linux-btrfs@vger.kernel.org>; Wed, 18 Dec 2024 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491829; cv=fail; b=ZRMY2h0CoYw+OJi+5mLn7c4LR6rDeDUsyjz8eUVOqZAQ6E78sP7A38cK66Fg8eqtkQ/hb/K+723cQFXU2umCYerLMNY4oyC5V2UuZW5F/NF7BAHfnwxsmnzPKV4HFOFRr513xOs7jmf3QMCy18HkVSUciu4dMzUkzE7yEGdJLDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491829; c=relaxed/simple;
	bh=LlLYfkCfjw+FZqB0+CciswBjgJ4vi6dYPsTvAYuyjHs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JvY/zR/0Y/Bad61MWZ8j+bHAXw8s2CsKF9nSaEhmKL+BeW2OsSkfeTFe3yOIh7z649euVnYJhswTqHjG7DgjzYP7RIXaiNXPdAO6buswptYVRUBav+2NXZ3vVJ3Cp8ZAFjPIQO+WrW0j27GNpklMGE2Sm2SO/ZKfU8RamNvuHmQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=NWMLX8ee; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rrSRlAqJ; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1734491827; x=1766027827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LlLYfkCfjw+FZqB0+CciswBjgJ4vi6dYPsTvAYuyjHs=;
  b=NWMLX8eeTyyiQWob8V6ln9fKPNvrTtVR5Mj+tazX2qSTqorC1RR7D7CV
   G6PsSuHv8Y7BaZ+2KLPcV8N1NMSU+5qMS8zNIozdmwrxC52n+BlGRl8Ps
   l3rz16vTW09gHgi6o9WBBAtPrpA2eC8PaLybFIKkfxR2jyIwzJZihAs/A
   uSuD4MPD2PePkDGFSIPQ/vrCiOhJ2gPxSwoJ2HeRAf76CWjE6IU8ojL2u
   hWLf763xUohYBje22JBqSRYsijt80MS+lGvx8MH8nWcue17oFLoFFpFOT
   3J9xvIshWkMemRj7c4p2n36dggY3KWXw61eG6YyYWk0QlIfle8a4ULjMP
   w==;
X-CSE-ConnectionGUID: 74h1p3auQsC7mJ64Nw7hPw==
X-CSE-MsgGUID: 0JhhM/frQzSFprikEvl61w==
X-IronPort-AV: E=Sophos;i="6.12,243,1728921600"; 
   d="scan'208";a="33938891"
Received: from mail-dm6nam10lp2048.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.48])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2024 11:17:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jQkMnKpEmwrNH0+5NsA812bXlMeyuFfFoTPN8LOqkFG9lPGo3GbKsOuM9RJkGU6ATb12flvh/rB+1V0fkiNvSE2KtNeiM3yaUDeX3b9Y5LeiMCSBCWdUgOW5wdYqnxXaLK+1GVyL8v6LmHKRre14XMBgA7UMkpKXEFe+6vtAOI6ipxDf2UNG+3pruNnfIfL86YzLPXxAEh+ABtZTVlZR5pBgCOsUelHA9Lp6KdrY1AX8yLHB9E9ZH/3vhjuK3nnpC7yMI21vYoZ1yNu7CrXFRB4hZdUxCGwZl6bUqYDKiCMPUVTuBlIxYOOu0L5Z+HyZ7pLj/u7rNaXg8oJ+y66aQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7o1FSI5qjm2i1+nhGC+V/jg5+5FlRkVJSCKmHpm5Ds=;
 b=c5/7cw7lmnA/UJXuhxn1/Wk0RYPD/iCel7SeL/dUWzGC+UWJTdzW5PZ1vX8mDaByJ1tiOl3aqr4esYAxRqhl2fx4OhP1MgmixDa5sroGR6OKp68AVwjYyJeiK5WnX4tN/YWUwa1YdDq9km1gMjX9Fb7KiukgdobASUsr4Tp2Vqyu21bI+Iq2g6G/fKPw9F+B7fWj7/f5hovMOciUeZLqiBP7FCj79/cDCGGOLFp4iRdDJd040GHjafoGXfl83SkVP/Gp/64957ASB4MHnPAX1W/fVfOyiUmyQO5jI5rUcsH/rV8Wj6V55/BlyLXK7zA6nJE3rtktGc1NkuvXbpMuCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7o1FSI5qjm2i1+nhGC+V/jg5+5FlRkVJSCKmHpm5Ds=;
 b=rrSRlAqJe4EKgbYAl6R2uriNlvLJN0Ni9U/hYLyFoFrxpt2Q39q/9J1yvCDsunemCB1EC97aH8pn4S1RWxRgA+VPQQ14rdJ9TVd5pok6ZiaLuZnyuFNb4efHy/96b55ovCZeD+UJk8oLriRwbs8geG8HUJ4+yruRXuF4QLZC1Sc=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BY1PR04MB8751.namprd04.prod.outlook.com (2603:10b6:a03:535::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Wed, 18 Dec
 2024 03:17:04 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::5266:472:a4e5:a9c2%7]) with mapi id 15.20.8251.015; Wed, 18 Dec 2024
 03:17:04 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: Anand Jain <anand.jain@oracle.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"dsterba@suse.com" <dsterba@suse.com>, WenRuo Qu <wqu@suse.com>,
	"hrx@bupt.moe" <hrx@bupt.moe>, "waxhead@dirtcellar.net"
	<waxhead@dirtcellar.net>
Subject: Re: [PATCH v4 3/9] btrfs: add btrfs_read_policy_to_enum helper and
 refactor read policy store
Thread-Topic: [PATCH v4 3/9] btrfs: add btrfs_read_policy_to_enum helper and
 refactor read policy store
Thread-Index: AQHbT+ccnoFyNHKnB0qUdXMnx0UYpLLrVs+A
Date: Wed, 18 Dec 2024 03:17:03 +0000
Message-ID: <n4wm5d2p4ghpmxs2okidq3iz6obrtrke4ia42zws3dk6j3suvq@gbit366pij6s>
References: <cover.1734370092.git.anand.jain@oracle.com>
 <9fcc9f01bdab846db231b427f98fbb3e9df7c7a5.1734370092.git.anand.jain@oracle.com>
In-Reply-To:
 <9fcc9f01bdab846db231b427f98fbb3e9df7c7a5.1734370092.git.anand.jain@oracle.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|BY1PR04MB8751:EE_
x-ms-office365-filtering-correlation-id: eb58609f-8e1d-443c-8042-08dd1f127210
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pua561+e4MAotncT8l3l/SXQ+7ozi26cgUyAKHeNN0mNFem6hDt4JqHKLMP9?=
 =?us-ascii?Q?VGPcHqV+lUMDBuvA0AHuvbsCUQCu3KLlmhHqN2lyiCRJdifrnseJUmmF2rxj?=
 =?us-ascii?Q?YhkcaCpWlDJKcnd5hO3l/dqdQAhNnGK7V+OKMJb5gt7kmoGgByquEh2qgyVb?=
 =?us-ascii?Q?kf3G+pQaYsW5SlpmixstGo2TeseWR8pOLtCLvGSSezpOwI+cMbYht9bOZFOQ?=
 =?us-ascii?Q?JG9rihrCKBnxE+QOPyxDO26eQWINHf0jG1JYaV+AdgAx7o8UD3ztPpn+1m9V?=
 =?us-ascii?Q?oMJhKi5aZm2pvFO6ByF+dkCwIK+xpUA6kl+xmkRVnQO7DrFRrZwYP4BZGx6i?=
 =?us-ascii?Q?2HHg5sv30sApQtNL2aYGKsXAeyJpKk6PoI1J0fcZso7doRdKYBEEeele9tQ0?=
 =?us-ascii?Q?75m4HYubSzib08XFeieFm0tOQ1wBUJpUHLYLeprgUE24XCRuKACjvW9GDIG4?=
 =?us-ascii?Q?+NF7f7JVZH1nceGIxX+WtQVkV9XzpVOJOvARziWJETpw9LzlW6794FsfElc0?=
 =?us-ascii?Q?ls0zD6eezYbLL86TZk8g3RsPJryV4QxaKggXgIjTT8A/r7NFsKLkKdS9pY2Q?=
 =?us-ascii?Q?ylyC8ykqvSqnCG1XYthtozMoY7H+60dtHQiS9ntSapkBg/463VoPXeGoH4zZ?=
 =?us-ascii?Q?VoUr2Bhfyxs//GcdmqQRC4Ie0ffvqs6fBbQerynPOi8YIcBQAAGW9flNeIZH?=
 =?us-ascii?Q?mPG2GAYekhaD2W1Xyz6HjmupSX5S0lzQMQFEeL4Ti0wdTjnpWeC9bXxp5Kxb?=
 =?us-ascii?Q?KPWu1mmeggGTPB9eAQf2cGwft4dTl3QGFIRHuFrOKqpIHqAKX7B2uGTvK30b?=
 =?us-ascii?Q?M4YG/LJOg0sc1rCQtgPLMEoT/ifB9LsWgk2Fs7bAGYgq54hoJkZ/Zm5Z2Li7?=
 =?us-ascii?Q?d8GeaVaM3YHT8WzlZLdb2WvoIR0LreOiF2JXHYzgNLAqPfzrwzgko6YdHAB+?=
 =?us-ascii?Q?aWd3N4mS4cDF56/BnSDo9efamMugrjZxHVi3pJQzDzawvAP7+TprDqhm3FTb?=
 =?us-ascii?Q?mMx7Ld+byMQp7pV/rcNVzyuaNcm+fqprnis3QcPgxd8dhxQIzuJxsQ/FlyDz?=
 =?us-ascii?Q?CZXDeecjUrfAwUSiEGdWp/eBu3zwYXyz0kukB7RvoP1xH9zuNBgQr0lAPbBy?=
 =?us-ascii?Q?j3uEK6QpgDaWV3WNeQyEMkOEAebaEp5c5rwPbRN8G46gs3u4oRjw2jdWfSvS?=
 =?us-ascii?Q?5+u926rCXFH2tarhEsyUR64FkJ62XehfNDRT6vwCC3WbpcPe4vub+0r7TbJi?=
 =?us-ascii?Q?zovvyuheAdbtPc+haLqBh4tegTFrg+cPokavIR+lcHq58pRa7QDozqNuWo8/?=
 =?us-ascii?Q?xoGbLZIU/E8JXMGKghS+cmn1cuYS3YFYliOoHLhUndV8EMxHclaj4qZbcb3R?=
 =?us-ascii?Q?uZ/WJDeFC1BAJn7oyyt99jKVH9D04xt3044IyT2aDtKASsQ0FSV5P23zNFsS?=
 =?us-ascii?Q?rLvkLyKq6iectt5+u8lWI5uLn8e+BnSv?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3PQIff2rBc2INkcH664hJMJ28OqXaZcjx1RLg1m3dZKsUdAXedEZRs1E5e3H?=
 =?us-ascii?Q?YIYcP4HUPjcYapHxC+hjbEyV3AcWouTQMSdiQ3vewUY7eJjOmNyvebsgryhH?=
 =?us-ascii?Q?fbSlivpn5r5iew5YbDp9wX4FP1Bf8pd8T80IxVAqL92ulFNZp7eT7ifRgBqR?=
 =?us-ascii?Q?L/NHOJGJgM+GYgTGZER0K6e/PZVWGe2Ite/VmTETt+h43abR+8rRhDCff0XF?=
 =?us-ascii?Q?ZafaK1uxDE3D/ZWozK7Lz5hKyU8sGfthLkbTEYSHW3dOlmvX8wtbQELDQ/ou?=
 =?us-ascii?Q?kTCC1CbS+RTrOnO7Bn8mUDUABAREjRS/CqLIQNdbOCvC8wbuTR4VMDGLVvj3?=
 =?us-ascii?Q?ha9rYQLQLIiJEKS1O4LCWp+sv+DJ0AQ6i3LdG5wHQgkk4JTUMRAJNLuIhEkt?=
 =?us-ascii?Q?n5D2lA+NjHKKwK6LNKCKZhhnXsyOky5ZtJb+Q+EZXCW5ZduY5gSAjItEjIoK?=
 =?us-ascii?Q?ZvCwa5wSaf+QMYkCpoI1yVaXDPALfBpdBta9NTPSenmhVMTQlV9soG7cDtrp?=
 =?us-ascii?Q?8McfIpAcJgCSgAmVpPyZ6bBcTJ8K2NnNBpdBgnPctsEKH1h7JbMl32Lqi/KT?=
 =?us-ascii?Q?04pqFFH7YaIQWQsg9s+3vkRNmMuiizAag7S0Zth/fF8+RTdYDGNRNOUBHfJw?=
 =?us-ascii?Q?pV23YDTnKeTNp1LybVAvdKQP5d6wr4bTcOYCZFvFhn6je6+yxVFRODA7OMuE?=
 =?us-ascii?Q?8wWoTTnDJE4A3VmQAI6E5VOkedxWMtX+P4Ya4Him/Ut0K/VSslII0m4OM51v?=
 =?us-ascii?Q?+s539ScgPdBAw4Zx3/sXrizwD1slBwdCt1kov6pfpCa3hqWOPdv+Pqh34Fy1?=
 =?us-ascii?Q?IQfIrUPHxgGrYqhqQOvxtjq0OoC9Sjji/4KYc3DG70b8q9W0jeLclwPVefyE?=
 =?us-ascii?Q?YTt/2JPQknJvd/fsGzlynoyQyWShiOH1bneBMDGuSQ6fCP50xeUQ6Ro226YM?=
 =?us-ascii?Q?1KbDMb1ePawJoDW/a7T2r2P2A3K34nMvxATL5RfD611QcRMNm3lOzEa4eXMV?=
 =?us-ascii?Q?qOqgXOqTW4+IRje5jupRHSGZ+bP6n1lTJIV6nBJbhFZobtdLEp5tPObox6QJ?=
 =?us-ascii?Q?aV+Byutb2LAO4aPB4dIK1XvaYi4zpN832PwR6JExotW5MgsznM/9reS2Kuec?=
 =?us-ascii?Q?kutrZdgbLOXQDwSBKFF1V3WNBnvp11YwFd4YqZf5sYDNXaRPsvst51jxiyXU?=
 =?us-ascii?Q?nMQFtwKTqcvRi8/Z9KlTiRMurnooK/7hNmkob/XG7z9pIn/eO6b8YgLsXcn+?=
 =?us-ascii?Q?5qBuFEtof83LIY1EBHsAF/PAvD8oohSCUVOap1VJS657R+aUoIpQapFqTGg1?=
 =?us-ascii?Q?LqWai5EDHcSsco7y4mCFcL+xvthuYq2BzrfFaK9xXc3MDCdJLG2L8fBCSi4k?=
 =?us-ascii?Q?NY9hv9RdKFgJ20l2VHlLNAUGd0CHkubU0v4WVa0qwZ4vvDg6XrVuL0RC+E3p?=
 =?us-ascii?Q?RCY4EBJkLEDsBDBoWdyzBJb0KCEea2L7zB8LuiKILF1/POqW59rCb/3cFAoz?=
 =?us-ascii?Q?MzyLzIZMgrwpmyo3+f4pEmKcfyKA3gD1u1lIOjqZlf9gnmzshhCqxDW5S/Sj?=
 =?us-ascii?Q?4i4AxzLoQLRbG88+fh1vvLeZKH2/zqEGg5I+rLhX4Yv5Ik+u6suxFwwWaVVN?=
 =?us-ascii?Q?bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC89D733FDA0B74682204E1E425A5EC5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YzjcPjGUHj/ivJdHRpp0aE61I/L9dPfGlEZtDujXfnWpKEvB4cZ3+W4Dyyne8MU2DC97BvRQjK3SKyiPsyZlD022BhGAxsi64MakVm488KUjp/xCx2CCDRneRqL1ADY/1kjxz4aPeKcVjTQgwHb5VcKbYXLByRxStGq0XsdSoE7DNY5OXx3BOq2ss0XSRUscgJ9IJ99Y0fw6FV8ax3EdN2vI6gVIEI78yE/KceyZ1QNH/55HNdWB3Ep0jX0ZbQmLHMIwCyCtePBK9sJE7nRL0GvBwZqalYDEBY9GFL/1S1xGJs05vZLgKcNI2kwUHjl+GN1O6JyAuC7JpiombvOTSXoNUlX0DvMZPugH3DrHRKUJGamriphizrPFC13ZnDJd9hxs7Dk+Od7a64yozrv2Lw5MNHowkz1j9xa9pdVPvcmMjOX+bXvFkKYK8qW3n3eAeRtiW6mB7QSfYMnsRJHyuyVujhC1Xi3Nj5UluBjPS6N9/2gzi8xKXAQATX7nB1ccTSc2j8qGqmevI/u6/5D2tHtojGn+CM0lBi7wiM5nXE4E+VSxw9SYqCV74Vzu3UgkqgLQ89Xa+at+Wpnh4LT3U8h3NTAQ/22Djp0vzAWMCNyah22XpwaYtmK11rS7cyF7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb58609f-8e1d-443c-8042-08dd1f127210
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 03:17:03.9687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmC1ROKC31XDkWrCEvnOWHHTnLxK/0V8Ti+xQ4FFRgO2mKrZXlbdBiko4i+lRKK2exmuxr5EjWmLrEdBCbVwMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8751

On Tue, Dec 17, 2024 at 02:13:11AM +0800, Anand Jain wrote:
> Introduce the `btrfs_read_policy_to_enum` helper function to simplify the
> conversion of a string read policy to its corresponding enum value. This
> reduces duplication and improves code clarity in `btrfs_read_policy_store=
`.
> The `btrfs_read_policy_store` function has been refactored to use the new
> helper.
>=20
> The parameter is copied locally to allow modification, enabling the
> separation of the method and its value. This prepares for the addition of
> more functionality in subsequent patches.
>=20
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  fs/btrfs/sysfs.c | 46 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 34 insertions(+), 12 deletions(-)
>=20
> diff --git a/fs/btrfs/sysfs.c b/fs/btrfs/sysfs.c
> index fd3c49c6c3c5..34903e5bf8d0 100644
> --- a/fs/btrfs/sysfs.c
> +++ b/fs/btrfs/sysfs.c
> @@ -1307,6 +1307,30 @@ BTRFS_ATTR(, temp_fsid, btrfs_temp_fsid_show);
> =20
>  static const char * const btrfs_read_policy_name[] =3D { "pid" };
> =20
> +static int btrfs_read_policy_to_enum(const char *str)
> +{
> +	char param[32] =3D {'\0'};
> +	int index;
> +	bool found =3D false;
> +
> +	if (!str || strlen(str) =3D=3D 0)
> +		return 0;
> +
> +	strcpy(param, str);

I think "str" is originated from user input. So, using strcpy can cause a
buffer overflow.

> +
> +	for (index =3D 0; index < BTRFS_NR_READ_POLICY; index++) {
> +		if (sysfs_streq(param, btrfs_read_policy_name[index])) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (found)
> +		return index;
> +
> +	return -EINVAL;

We can replace the logic with sysfs_match_string().

> +}
> +
>  static ssize_t btrfs_read_policy_show(struct kobject *kobj,
>  				      struct kobj_attribute *a, char *buf)
>  {
> @@ -1338,21 +1362,19 @@ static ssize_t btrfs_read_policy_store(struct kob=
ject *kobj,
>  				       const char *buf, size_t len)
>  {
>  	struct btrfs_fs_devices *fs_devices =3D to_fs_devs(kobj);
> -	int i;
> +	int index;
> =20
> -	for (i =3D 0; i < BTRFS_NR_READ_POLICY; i++) {
> -		if (sysfs_streq(buf, btrfs_read_policy_name[i])) {
> -			if (i !=3D READ_ONCE(fs_devices->read_policy)) {
> -				WRITE_ONCE(fs_devices->read_policy, i);
> -				btrfs_info(fs_devices->fs_info,
> -					   "read policy set to '%s'",
> -					   btrfs_read_policy_name[i]);
> -			}
> -			return len;
> -		}
> +	index =3D btrfs_read_policy_to_enum(buf);
> +	if (index =3D=3D -EINVAL)
> +		return -EINVAL;
> +
> +	if (index !=3D READ_ONCE(fs_devices->read_policy)) {
> +		WRITE_ONCE(fs_devices->read_policy, index);
> +		btrfs_info(fs_devices->fs_info, "read policy set to '%s'",
> +			   btrfs_read_policy_name[index]);
>  	}
> =20
> -	return -EINVAL;
> +	return len;
>  }
>  BTRFS_ATTR_RW(, read_policy, btrfs_read_policy_show, btrfs_read_policy_s=
tore);
> =20
> --=20
> 2.47.0
> =

