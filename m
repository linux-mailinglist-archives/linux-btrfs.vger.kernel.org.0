Return-Path: <linux-btrfs+bounces-5649-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D46903924
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 12:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED5CD1F24C45
	for <lists+linux-btrfs@lfdr.de>; Tue, 11 Jun 2024 10:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D3F17836F;
	Tue, 11 Jun 2024 10:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="lcjmKgXp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VPH7GDKi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6B21CD2A
	for <linux-btrfs@vger.kernel.org>; Tue, 11 Jun 2024 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102714; cv=fail; b=OgftTgUMUL50fynYUAJJPJuTxvirwDP09KXi42Rw2TRFs5qgjclqfLJKQYGU6n47CI5nYo8DgxJh7WNi0+P7LLMbM9+beMCgD7eOTcjkze+VDhCEYiXhlOyk2KMFqHhirvH5U1ULqvpPLDiCOL/kPWnx0JL9W6IWzHD3xmxYyD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102714; c=relaxed/simple;
	bh=GjJk1sL3eHHaSqNylsAv+gqwRbhe6OoK5xWjtG++qeA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DuWpLTVF/EQPhpdYGGBv7VPv9FfGYW0v1Ce7SS6U0D1sYqb4ckb0CBCJR9zM2ZSv0znyLkjLVriE+ZsdSBl38Hp7OiUc9GQV+Bwq0H01aTpFdk80o3KOPythT7MHiq5TZrS4Tm1e8374Gok62lUArEjDb0iyQna7cLoNGsLS2Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=lcjmKgXp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VPH7GDKi; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718102712; x=1749638712;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=GjJk1sL3eHHaSqNylsAv+gqwRbhe6OoK5xWjtG++qeA=;
  b=lcjmKgXpgv1CtjnnYmeaqnUW9S3rqYDJn9QuFg179yRqVjtlOMtRQOhv
   D9dstuY0lK6OHL98B83dnCj586kWHTXw9aApARZYFteiCN70vUCU5jPab
   Jajlg4s7PEx9wWl8jlQ1H7fi7L9yC6tYlr5xTUcFxjRzvppQUQQP1HtnB
   br/TIalJq6vKydI648/EzCxLgpsVDAQUkTTzx6uCJ1dgoUv/yztXTRqLD
   f8nonK98gYR/GwfBIg5/xvNl/QfuZGCj/WmfYrT1dBol9O2TFXf5ZfjsD
   TOauRRCoFrIYkhgfKZ9fvjCntmCPKA5tCj+nZMMNkilS2s+aQik7LJ+S0
   g==;
X-CSE-ConnectionGUID: 825H5i6wQ2eAfg6h8sGSFA==
X-CSE-MsgGUID: LwLG6crUSte3NF6XX0FA5A==
X-IronPort-AV: E=Sophos;i="6.08,229,1712592000"; 
   d="scan'208";a="18061187"
Received: from mail-mw2nam04lp2175.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.175])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2024 18:45:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjpO9tJfVKcih3KRqslS/x1sZ84L7z4C4o/FTJf4SzLfW0E8nZj5cj8JI96uPWxd8f/0ZtkfMKsbE5NTCcr69yH4bcWsCpILHi+5Ti+1CcfGoHWnj3NbC+cmBzep3nJP/uYaznw+jKVMsXn7OyDWuUvpzJOWw6+GD6akyHdjgj1XWGmWvZuGM8SaHXqplCs+iKs7TR88SPkR77B9x8bVbMrRKo1A1SZfY+Cj5P012Vqh+ihw5YT4MZjX+Tgt02AB+YwzXLUlcobbLgtUlSmQXZaiaqP/hBKM41Bh7hA39KIbYxKh3k/xVTckYiEiW7ZnpJnx9MA2CXQx7vf0viOizA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjJk1sL3eHHaSqNylsAv+gqwRbhe6OoK5xWjtG++qeA=;
 b=WaWfAAsJcvKWbJYQx/3aHgDpfJIh/KpBA2Bygkl+QEDpZ4FX4zZlJHWLMsa4UlsZKVh1uf1LZr1ta9nUVQ6KnmXB/nBcSsWRqz1BeCjBfSWIu9SFFpuPWAlqCDNJFx5tyriIAIKoj+4af7RIJcs5haQILY9qdqPI9G0PkrgjKThMvhnnkDAinL478HmbaV5IU6N+gU7jVOEtwTer6BqBeV51+PZpdXlBD4TRlO2d3Wc2CFPcCO34rFgKn3hBMkb2q/mQGsPpFXC11MP2HxiZWjtAlJyktg0WAxfZ28OQk2fo6/4gKr2vA/HrwoF6UmIqzecoV0c3RbpE0TtcvxmKQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjJk1sL3eHHaSqNylsAv+gqwRbhe6OoK5xWjtG++qeA=;
 b=VPH7GDKiL/7k5MANZg/JwRApZ0xxWL4Mg0Z90gOPDAOkETWPjdE2Tq8972IhLW7gltMMagYeUGKOOgJDdOwGmRUnHKurudCUrYV6PaU+fYdnPp0/JFzzs+FZ/wk2LF0eVRRJ7q1ooZWlycQCBNIhgYv/z9LjxK4EQOANWqZyMgk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB7105.namprd04.prod.outlook.com (2603:10b6:a03:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 10:45:09 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 10:45:09 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: zoned: fix initial free space detection
Thread-Topic: [PATCH] btrfs: zoned: fix initial free space detection
Thread-Index: AQHau9601Mv8W1LnzkqwX+RIb0/OvrHCYR6A
Date: Tue, 11 Jun 2024 10:45:09 +0000
Message-ID: <b78e0836-b654-46a9-bff8-50ececb05d6e@wdc.com>
References:
 <ec2aafb75c235d9c37aef52068992dca0d060d5f.1718096605.git.naohiro.aota@wdc.com>
In-Reply-To:
 <ec2aafb75c235d9c37aef52068992dca0d060d5f.1718096605.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB7105:EE_
x-ms-office365-filtering-correlation-id: a5537ada-e453-4e74-738c-08dc8a0390a8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?eFBZQm9DQ20zU3VsS2pGcllWN1BlSHR4d2RzejI2Z2x6eU9RRE5DVms1clNJ?=
 =?utf-8?B?OW5JRStsSWFoN2lxeTh1RHVWNlhEZzdDMzVzZ3ZlZkRtckJJZTdrRkNHbml5?=
 =?utf-8?B?OWhMa0RQVm5YOHBwZWJ3VkRVVG5HdTFDTVpHVE0ra3hBOHFBL2JVR2ExNHNU?=
 =?utf-8?B?MGJyWUxaN0diVmIxUlU0RXhiMFFFcFJydmw1c0Ezb1d6VjU3b2cxbDNrSEZT?=
 =?utf-8?B?K0RRWmFsVFp6RW9uRjhCeUZjNFJXamNUMHM4cThDUmswOUFDQXlWY3M4YjBn?=
 =?utf-8?B?eFRQdVpmSGpSUEpMSG0ra1RQS0tNOWlDR2thalVzNjV1eEJPNE1rTDV4RkFI?=
 =?utf-8?B?cXVFaS90UzNJMDgvcXE2cUZKWWkxZXJUNVNLNDdMUEJYMlY2NzB6dmNzakE4?=
 =?utf-8?B?cUxFcTF5QXpZcmRscURCYnhJQVNLREtTV0lJeFJtTGFFdDdRMC9EYVV5Q1dD?=
 =?utf-8?B?UnBuR1RvVDBUdnIxbnNGZjdUc2JneUJKaWh4djlldDZ2VzRVQTdTUi9JZEFr?=
 =?utf-8?B?a09PdlZJRTkvS0tsckltd2w3L1RVVUtkNFhkaWEwdlRpaW9Xb3pqaHFEZWN2?=
 =?utf-8?B?b1NhZjY3cWIrOU1vQ0QwVk5GYzR6by9pSHJjdXJvUTRNZzlqaStnMllMQUVX?=
 =?utf-8?B?ajhoNzJXSXdHWFQxcU54YXdQdTdYd2gwaEt5TlJXenU5QVpOcC9PZGsweWhx?=
 =?utf-8?B?MVZ3bVV0ZkRxRG84QlNkVkJGbk1UOVZCT3ljYmk1a282T1FLV2tGNDdBRHFh?=
 =?utf-8?B?NStvVkpxT0RxUy9jemtETjFJQUZCNUx3ME1aajJ2Y2lZWk54eHZiaXdqYm8r?=
 =?utf-8?B?RExyNzlXWmQxQktTWXk2VVF3Vk9Bb1BjbU1CeStDTTUwd21PSm5tcEJEMmZv?=
 =?utf-8?B?NmVJUEZQYVN4LzdVelN6MW5PRDhDblRJb2F2RFp1ZlBkUnd3Q2hFQWxISERm?=
 =?utf-8?B?eHdlajBFaXdXM0RkUHJRdUxIQUI4anFSWkpnNHcwV1pSNlhmS09Kd3hncHlC?=
 =?utf-8?B?d3FHeTIyVm5FU0xHa2ZmZU13Yml3RDhONXM2eXNYK2ZFRldYcDhzaWdnQlZy?=
 =?utf-8?B?YUZmdldyUmJNd2JDQ1lieGtBSWFGamhDWFUyT3I0R3U3ZHcramRiM0hzSGRl?=
 =?utf-8?B?VVNqQlZqWHdlejdEVi8rSUpsb1BveFU5R3Q0aFJoWXdwNUlLaEpCbFE4MUtJ?=
 =?utf-8?B?bm9KWUZ3a2h0NnJkVXIrNUxxd1lUZGFYNlhiRlAwRHloSkhHNlhRVTJKRzBV?=
 =?utf-8?B?L0RpQmRURHhWUVBtQjBYVE5yNCtPclJlRjBGcnArTEo2SlVrdElkOWZnbGhL?=
 =?utf-8?B?dzZCSTVHZ2xCdElBYlZmdmNITGZpOHpBelIyR2Qyb01IUm5YT1N4NkN0b3Rw?=
 =?utf-8?B?NmE0TU0vNkRFdFAvL2I2V09ScWNielpEWE9xUklmcVhCZ1NaNDczbitsb3BD?=
 =?utf-8?B?UEUvd3pPR1FJYnBicXJGbW9YY1dGM2xlSHQxSTRwVmk3cWJKeng3NzhqZlRw?=
 =?utf-8?B?QWNhaUJVMVRZaitzaHFDU3Exa1RBbGE1YTM5M0N0WDdQUjdEYWFkdFdvdkJ1?=
 =?utf-8?B?UTlOdnF4UGcvaXVUdFFpTitJYUV1dTJINHBYUWRDS1VPQklSS3pWM21KRTJG?=
 =?utf-8?B?TTUwZEtNWmMyajdvWC9vMGE1S1d4b2J4VzB1QlhLSE1hU3JFQnNDUy9TRjVY?=
 =?utf-8?B?cVhxa1JMbzhRaTNad0hqZ2R4MmJFaTFrbm5OaGR3NVRuenJST1dQanArQkx1?=
 =?utf-8?B?aHl4Rit5aUd5RmxONkFQZDZaT3JCbmwxRjRtYTBXbE1LbXBwMUV6R1pmY2d4?=
 =?utf-8?Q?9M/4QsMTB9N8SsvGs3lRPWYcXpF47FSP79FSE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WExNeWVyTzVwcFZ2dWpmOGRzTmpsNlZqLzdtY0gyem1CMDNQK3Q2eDhqZDB2?=
 =?utf-8?B?TFdtZWxuOWVZQmJBUEV5ZW1HbVpjNGNpNEd4dVU2amxodnVndjBVa3NiVTI5?=
 =?utf-8?B?Q29uaEZJYWUvb2g1Mkwrd2tOWVF6ZCtaTlV1TDJIWUE2dFBQd0xWZ3JDYkE1?=
 =?utf-8?B?dURXY0VUV2JGN3V2WlVIWXk0L2pVcllleDR3SU1STW1veEtMb25BTE5wQUxm?=
 =?utf-8?B?WXZXM2Y2bjdBZjNRV2xQSitvYmE3cWM0QytGbk5aRVNFamRNd21YamVPY29O?=
 =?utf-8?B?SEt5dVRuYXAweGxIWXI3VENYWCs5SlpSczJocWM2czl5NTZXei93L0ZmZkM5?=
 =?utf-8?B?MGJNbFQvMmlzYVdxRnBZMkY2VDZsMGNoVFdyaGNKY0YvU2dmMXpRTGl5TjRD?=
 =?utf-8?B?OWFvRGdsTzRGT0tZdTU3WFN3VEhCZldFYktUa3JHQTd5SnRQcTNTMS94Mmlh?=
 =?utf-8?B?dzZCYlp4bEI5d1JRcXludVFhVnlHRGtIUkVDNjVxY2dEdnBGVVo3aXhzS2o1?=
 =?utf-8?B?Q1dSWEtNQndYQ2IvUmxJSjlFeUozdGUyVFlNcXV5ZHBubHBITVgrRzlzY2FL?=
 =?utf-8?B?S0lMR0lvTmNGaEpvT2ROR0d5LzZ2RG9QeEVzbHJybmRaak9VRnUzZzd3U2pK?=
 =?utf-8?B?eVMyMmpqVG1KTXJpU2tBMUZlalJKcEdqYmFqUkErc0VEQ0pQdTZxTno4ajUx?=
 =?utf-8?B?ZHJFMWxqKzlReXpvL0ljOGdUQllhbERoNGJOMkJ5M3FnQ0oxWCt5MzlDUmxx?=
 =?utf-8?B?VWRjaHovSGh2aTZ0dGdZanRpUjBhaHpVa1JKMGR2TjdMbWNLam95QTZ2MzB6?=
 =?utf-8?B?ZW1wRkk1WmUxL2s2amttblRVZmJxd2I2TzJHaURCL0o4b0gwdFBwR0s3bHdT?=
 =?utf-8?B?bVQzMlM4MnI5WmdHY0N4cGxxWThNdTJOMjkxZXpsSkNEWDhBOGpXUUVIRndE?=
 =?utf-8?B?c3c1Q2FlQlpZMTdOVFJ6SmhaOVJMakdEVFBBNENvR3hNSmNYa2pESUNWZE9u?=
 =?utf-8?B?R2ljTVArdDNCQTdtUG9USXFqU0VtN2J4WVR0cnpDMkwzaldLSWZ5RWVBd05r?=
 =?utf-8?B?S3hhMTV6WHordzRUWHJoQ2tFUU81cWJRcHhHU0hWSVdBc1dPWXA5dm5ML1Qy?=
 =?utf-8?B?NUFqcThhcGFhSjBxSzlmRGhaTFJUWGJNTjRHYWhtU0pQRlNhRXY1T1pJTGIw?=
 =?utf-8?B?dkdwWHo3RDlReC9SNWJlUWxFczVIU2c4bUQyUHh6c0diVVBxWFpMWXErdC8v?=
 =?utf-8?B?SzAxR3VVOHBhdjBaR3FQRmJ6cXFxYU41QzZBZ1FiNk1Tc3hEUG1vaGVMZVgv?=
 =?utf-8?B?SVV2dzdUN240bEpxY2RYdlMvdTVYS3hDRm5KTFpaZC9Dd3h5MW9VT2lTWTNv?=
 =?utf-8?B?NGkrUkw4TjFOZHJhbU5aYjBYOTBzbUVOeC9hRkF0QTRReHlKdXFxYktHSG5I?=
 =?utf-8?B?VWdBTnRlempPRDBYaFBFQ2RyMkE2QXBRUWY4VmFhdDdPRjRxRThLdmlFT0hS?=
 =?utf-8?B?TVUxSXdRSGsybUhNVURVUUpZbFJxcitscUwwYUNmRlArYTZZYzh5bG1VRWJP?=
 =?utf-8?B?ck5hdGl0Z0ptbTZ4R2JPSURPa2RIbnR6TjZZbFhjbjI5bjZyQUpVRG1HSFVP?=
 =?utf-8?B?bzgwOGk2WDBUL0JQcnpLenhQVUZGTkQ4Undwd3JOYlNPcXNIc2hyeUgvZ1ZY?=
 =?utf-8?B?bTZRbGRoaG9FZVB5U21jdUM5anZXdmxCR0xrNDV3cmhieW5oNzFmNiswMVkx?=
 =?utf-8?B?b2RMOERURDA3RjVQWmlBSGlNNnhETWVjSlUxYllZMm9FRTU3aTl3eEYweXh6?=
 =?utf-8?B?VWZlandXWDJDRHFQT3BZQ0FkK1FNYkc0TXpjUU91U2RPaVcvZGt3MHdMa0Zm?=
 =?utf-8?B?ZUlPVmx6UkRVUFp0ZHhYdG03N1VsK1VUVlJ5QkpKTlNkM1lWWlYvaUV1YzEr?=
 =?utf-8?B?SU0rZDIyS2NIMWllRUNKVFJicUVRZVRRZ1QwSDZzVXYwK29vanE2R2lGajZV?=
 =?utf-8?B?VHFuU3F5VzFuQzZqbjRvNlFCdnRJWXZ4UVgvOGNQdGR1ZkF6V1lLaERLN2lD?=
 =?utf-8?B?bDQvNTdLdGhZUy84eVJNUmR6MWtvcHJBaXhUODNRMU1PdzNvV2JlSFE3Vk9J?=
 =?utf-8?B?RmRnWWdXcVhCaWpJUHRuZFRTNnk3VUFZanRPVGp5T3JXTGpMQS9vWmk1c3Js?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <18309432AC52D74491420AEEE7A68BCC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3QY81la4dUaYZ0sBlL0e8mLqSEbZ6oFO+bu1uAcAgMEpmKx+plF5brQI1n103a7cUg8sYC62uw6EgrGVnb7r92sRyaW4aBHcmZmjOdxKIwLnOTH5dsqcaI24WEUwQpE3m36Ldn/EDN2Aw7eR0WyJYgzJVN8aUPeTc1ryqKJ6ik3kl/6cnXg3VO6bOnXN/nzqArrhyRnsOb3ddYWLaG5BfKJOek10BaRFgmy6o6DaDzX+Dqp5M67ma4G69HZG/QcCdsVoexSwyei8OSMR1bRgG+YkO3gBwYurREoSx5PxrSIYgjb1wZArPuS03+q8/xOsJIf8+0CczJpLbSpdU8qfjcTjnpw0Q3sFpKo1l1jdzaHn0WLNuIVS9x+0oXKLZU8x/GYgWeKUcrY7cYN6Eo8bqXRarQyHCXWZeuJH62snjavVOQzB5/R53V8yWpWVfab59EafiREgsf03XGdAmIDsadUpUkyhsjE0X+J8GUOsLUHTmOIyaEXgFn/xETXUSvErRJ68BHRxPTWrQBSNX1zpiC6ERNjkLLT1nIgt1FBreY7kruSvgQI9bU7Atr/WcdvtPgwY2HT2g+TWruUL177oTW04GLFHY0J3OXdeCNVXpvRXCqmkvv5Fiq8lo8fVwXe4
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5537ada-e453-4e74-738c-08dc8a0390a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 10:45:09.5743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxvm4bkZSNh/UY7OQkF5g8aTX11JC8IfNTxX18qv47FVjsuqehtZWEDJVcCzUK70A5yJLykSGmm1vy+MJMiFIZ+U9W4UkIMB2Cqf+fx6rYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7105

T24gMTEuMDYuMjQgMTE6MDYsIE5hb2hpcm8gQW90YSB3cm90ZToNCj4gV2hlbiBjcmVhdGluZyBh
IG5ldyBibG9jayBncm91cCwgaXQgY2FsbHMgYnRyZnNfZmFkZF9uZXdfZnJlZV9zcGFjZSgpIHRv
DQpOaXQ6IGJ0cmZzX2FkZF9uZXdfZnJlZV9zcGFjZSgpDQoNCg0KT3RoZXJ3aXNlLA0KUmV2aWV3
ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

