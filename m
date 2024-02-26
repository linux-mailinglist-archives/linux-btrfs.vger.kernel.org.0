Return-Path: <linux-btrfs+bounces-2770-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E18866CC3
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 09:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E361C20B3C
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Feb 2024 08:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FF26089F;
	Mon, 26 Feb 2024 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="T+AQ3EVx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NZ9pKrFz"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1816960251;
	Mon, 26 Feb 2024 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708936102; cv=fail; b=S5zdftxCtAXp/aCS1w3o2mWrFcTqzAG6RdXEkpuTiitjmB0PSndB+RbtTbhbKy61kLd7N4ZJcWzmBWdQG1HFgV23Pd+0xNZlUuhCIKcceV4fG8KYVe0NbqJkZOm6DDT0zxqXxOsy8X6wqtBaGpdJuVySFIl3CGPkb44coTd4ebY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708936102; c=relaxed/simple;
	bh=14Q2NyuNdARWsM4LLhqOJbhWvnfZSaZH+U4MwbSVAoM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j5AY37+3kdvV+tiRG6zCcfnodfo1/g6tmQHC3JPRfOV28ebdxMJYlOmxb+BaNBfVnSFwVdlp11qM3h4kA8VnlW0VbDA5KTNs/1TYeqeTdgavNAoXocagqNfzU1/MrV9kCkkfMZXlUT/0Cm/xtQQ19wDXJLJ0EFVSH7UXO4TC95A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=T+AQ3EVx; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NZ9pKrFz; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1708936100; x=1740472100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=14Q2NyuNdARWsM4LLhqOJbhWvnfZSaZH+U4MwbSVAoM=;
  b=T+AQ3EVx+7Z3XLDtYTzR80DDDzhsEV9K/3mwHV8qBiBeJ2aZBvW64Ff+
   P8bukq53e6Uj5lRHEGhqLe7LuDoxOr5AZwiowRU1eARhiHvQPu8/qZcXJ
   /yvu3n0qifRj7Q2MCYLTEhgXn3wMbZbVa/sEweGnfhLaPhYsiNUQ4OwHQ
   /Cr2i/CgrT01UPBt2np2K0LJY1Lw2aR1c+mNpGulDJDLLaoaGrHIUL7c7
   Q/jxHjMkTmcBqVvzTCfwC7K/sP8xDXcFQAomalOQK5DQgqB1VrBie0gTP
   JOT2BOk2zpJJRpdIDS7KL5z1TJXDKigO2VYBs+G5B0IkwfHduHQKhAi+k
   A==;
X-CSE-ConnectionGUID: VLaIv59KS+6QIgv40SEjPw==
X-CSE-MsgGUID: U72BT5EYTjibZN7UCZ7KGA==
X-IronPort-AV: E=Sophos;i="6.06,185,1705334400"; 
   d="scan'208";a="9754643"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 26 Feb 2024 16:28:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgiWcYDi0cEm7lbmZsf5tfjunA6y/LAyoHslZJvyqfTpnuwYm/5Z8D9L4RHRFr+AROz1Fo3yvBWp2RQqhnAVaagnEiqvXEVRUkggWYr3wy4PS0Qa3FxvFFYk9rs0bIRfL3/Yf9+nhTKLZ/T9IhMc38ZOUfWHssmYPVQLi2v8LusGmqCZzA49/W4udl+j6SEMdBExFALfRmhxd9Se2CNQdWuP6JfRFhLyJH3VyrkRCsu/ZBlsbdcr+w5zTmgetSFcZ1ClmQwGmO+mamfHqZVCCyTIQty6oD4Fn9xRh89ixMjxYd+gvP5ytLdE8nHKWdXtzhTa0S2kLkNhlyNgISNihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=14Q2NyuNdARWsM4LLhqOJbhWvnfZSaZH+U4MwbSVAoM=;
 b=BBU6smUOVxCRSXpGITAkC54fp+BtlxQQlCNNJSKO3nZIZjUTnIdAlahB3dnjNrh7vwF6r/QVtEan69qghdWu2F26zPM4P4WMNDbpxAbY0qxfvjzRRRWxymsMLJ/lq5lFOmM3eL1koJ1iC/xm54ouPAOxiT66KOavHUnVh/P68xYN4dZVtOn8dlNTUWO8OkSOm2MG2I/mv1elwveX8BmOndUKeIYII5NOm65ds6/KCFVt6Chnmg1fbg2hByujdKfEJllQyQZqOJkb78ZaQUONOE6hZ2kN4jbeRico6Yb8SoEj9LpaK7KWTYAou+6NpBXj1pCFRYFDvJ7x0MW7PLmqgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=14Q2NyuNdARWsM4LLhqOJbhWvnfZSaZH+U4MwbSVAoM=;
 b=NZ9pKrFzoKklPCY1mtqPZVjs5RLbXEVf9fWPA4drzMWnV2hPea9wz6AkPsaN9lVZe09vaDhmmVwY0LOi4d4PnsUCXKc9vfIJvXy6pfyvaN7pUdSt1JFEyz/BUJPCidOxhhPdCRzidJP90oOTps+6NhEbQSjgEzKQsCRl1XMbDR8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SJ0PR04MB8442.namprd04.prod.outlook.com (2603:10b6:a03:4e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 08:28:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::a814:67f1:24ab:508e%6]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 08:28:11 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Chengming Zhou <chengming.zhou@linux.dev>, "clm@fb.com" <clm@fb.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "dsterba@suse.com"
	<dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vbabka@suse.cz" <vbabka@suse.cz>, "roman.gushchin@linux.dev"
	<roman.gushchin@linux.dev>, "Xiongwei.Song@windriver.com"
	<Xiongwei.Song@windriver.com>
Subject: Re: [PATCH] btrfs: remove SLAB_MEM_SPREAD flag usage
Thread-Topic: [PATCH] btrfs: remove SLAB_MEM_SPREAD flag usage
Thread-Index: AQHaZygUW9G3bFvf8UOETh43NmZ0GLEb8beAgABbbwA=
Date: Mon, 26 Feb 2024 08:28:11 +0000
Message-ID: <110ed1d2-799c-4920-a044-1761a2dda5a4@wdc.com>
References: <20240224134709.829191-1-chengming.zhou@linux.dev>
 <82a6560f-2f2e-455c-a4f3-e8678b303d56@linux.dev>
In-Reply-To: <82a6560f-2f2e-455c-a4f3-e8678b303d56@linux.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SJ0PR04MB8442:EE_
x-ms-office365-filtering-correlation-id: 271b75f2-54e8-4e99-66f2-08dc36a4de44
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LdH7zx9N2ZUIFNn63vudTw5rNpAr/Ifbcm4VZa6EdBkanNYrMvBmFHplzlSHe77fUCGzH0YqCDMLjacveJlOvVUepzNmi1Fa/YG4fCnDX0/leZY3LDorGgsQPyQKDWUofXNuzYJOMX9ro2nIZc15Or68vntR/ou9fw3kfXNPVWtSZRnIK7I9C1i0OL/yX0T7nx/7gBZkVPupI7WTjCepZLhUjOv5ZhsZvFxX5pSItkhJeSEIXL9HRsvGmwYjOVAfLfzBnJ+EjbbdDTedUiIplGooM1OyBMthNhPBcl+b59/Jf5N+5qgM3lx5ptYF6+AZDbc3p2qJoBkXKmfrmY0NbDKLslI6VVIUBIALCMb34ecZ+qbo9q7Hb/lmhrqM0iJV07YzjNaqwYnUKcRAmcCZWXcsHUz+aLXZA6Yorz9gpRmoe6cjrwOZlfIHlP5rQCnegYfxwSlQEXl6idFGgstm9Mefp2JGgcVI2NNqExfvD7m8Yat7PUlUXNz/MYSZx5LjwX8jeBeIZT/wW+I5/NVpMK/Ui1utrKR2lzeTiLZFIbFLnSuIORLrVP6hRuUMKWpspTVz8MSETm7E9FRyijSenqdgtsPXSMN95nULzgIfj+klXSr8MqCN0vBynTRFn1McCZdu3dryw8xAe6GWPlwmiTovuhRqgZ358Lkko4vDnyVC000elBgSIS6TzhRefOe9K8oAshMAAz7OQ9FuR9S0onSmiySvmhWxNerEWZTEbtw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WWZOeVd2OGVaaGJwcnlUVDgvek5wV3BOVXlhc0xoeElabjdHY0pzQ0NBbGpq?=
 =?utf-8?B?RXp0ZkN3alFIcElUQWJKbXI2TE81ZFBVSHkxTnJsNWlOYlg4ZEFkbG5iZkpK?=
 =?utf-8?B?YnBXZFVXcUJsWUIxbklKbUVNRUljSUVLdVp2Qy9BbzNsWEEvZkdrbEpaMDFU?=
 =?utf-8?B?azFCd2MzZ3VlUTdhQW9FNHhhS0taeEFvcXhlWkVCREQ2SkFSaHJzN1JFNGpr?=
 =?utf-8?B?NHpkdEtoYnIzSWJFSEloR1RUTkI0dkRTZFpxM1RMYy9KdGd1S2F4eWxmNmg2?=
 =?utf-8?B?UnBRNG1jK0pLK28zQmNmOERpQzVpQW4vZVpTSUgyOHJmM1doQzhEeERPcEMy?=
 =?utf-8?B?Q21QMkdXb2NSS2h6RHpVVUlVMmZLWS9qOURVSTNDTmViZkwyOEV6N0V4ZUdQ?=
 =?utf-8?B?bDV4QmJjNlY5RlJnOHZSUS93U2VQNFdVdlN2VEFSMEVSR0Nna3BtWDBBZjBL?=
 =?utf-8?B?RkUvZDZzZWwyQmtHWktPdXFwWXFMejdEaC9xZExHNjV3Q3FBRFROdWZVMXRr?=
 =?utf-8?B?WjdIV0NmQnQ1enMzamNzTUVTMDlWT3IrcHBUZ0FEQWtETkRVMXBJL1RGOWFq?=
 =?utf-8?B?KzcybFB0M1F6cGZoVDFXOXlBNjVKdDMzbWM5Q2tJMUZ1akJGNldWNURYeTN1?=
 =?utf-8?B?WVNWUGpXcVdsNTJFTlN3aHUrRFc3YVNlcXhLQmJ4ZkdQZmVva3Fuc09KOTkw?=
 =?utf-8?B?d3FEZUVNbTVnWXNpcklkcU1hektINGMrQStYSE92aUdqR1ZpbFhnMjNSQ1lX?=
 =?utf-8?B?RmllWkdnUjFtTHQyOEtDRXlHQkF6OHdvVE5GYlFDN2U2WmFEK09adGdZU2I3?=
 =?utf-8?B?V082ZG1rUzh1K0ZkMEliQUNaRi9Rcis2V2hWUXVXaUZqYVd5MURJY1dnVUpt?=
 =?utf-8?B?MXpZcEtvL2dRRFNhYVVXK1hUVWc3UmY5RDBGUGRMTlpHazlnM1NXN3ZHZlBL?=
 =?utf-8?B?cURiNXIyQUo3MFRGV1hISm9PVjdhNzN4OHVYbmxpTlhHSGg3SkdvMC92S2NV?=
 =?utf-8?B?aEFvUWdYYVRDamo2MUhkRkh3aFBOS09JZFAvdDY1S3p4a3RDL0piMTl2b3Yy?=
 =?utf-8?B?SnVPci9TWWZKN1BnbUNtZWZvTFRzKzBycnZKMURmTThPaytoV0Rrd29ZbHBQ?=
 =?utf-8?B?U2xZMlp5amRCOXlwYTViOHBwTjVnaGJPUjRkUXlRb1FwMEtldVYzT2RxbHNP?=
 =?utf-8?B?cTZVaXluaVMvL2RIQVpaQnZMeW1QeFdRaUl2M1ZvWlNiWU8wdUdid09IaEhY?=
 =?utf-8?B?OG0rSno4dGxLQUF2T3U5b3BlVGVhamI5RFkwVDNRSHNnSWFZcmlrOUs2WkI3?=
 =?utf-8?B?UXFSOStTNEV2U3JvWXVxUkhYVEZmOGR5ZTlCb09kdFVYWXdtWnBJQVRJcTlw?=
 =?utf-8?B?YlJac1gyT1NHTU12R0dmRVVXMXZOWkdDeGM4enY5ZEh6K01hbUIrejNLTTRO?=
 =?utf-8?B?Ymc5N0dIbGR6TVgwN2g3VzBVU2N0L2xHand2cEhqYjFpUlFUUHc1em1YazJM?=
 =?utf-8?B?LzI3b1B4eWVuTEowVzU3dDMyM2xWMUtMZHRvU1gxUDNDaFpnR2ZhV0Z0NkFv?=
 =?utf-8?B?bUxBYnM0ZE9DMlNoZVQ1QzBtQit6Sy9UZzI5UDdrSXVvMDVYTDlQeEc3Sk5I?=
 =?utf-8?B?bk5ON2xzNzVoWlUybkxiOHczZnVYUXVweEdjMTVSV2Nncy9JWllnL3JmOWlv?=
 =?utf-8?B?S2M1SElZR0wyQUpNZ0dvNFNtSnJmellxY29uYXZ2Z1hDOEh5TXl4Tk5kOFZH?=
 =?utf-8?B?UEJFTm9XN1gzbWNUSHJsQkdpd3RPN040Tmg1dTRvL0VCK0UxeFVHK0NISTlT?=
 =?utf-8?B?WFhWc01kcitNZnR3L2tqVlpBZ2h6RTQ0YXdLVjlDYjRjaDV5SWZQQ2dIL2F4?=
 =?utf-8?B?cjlRV1FoNkdkMHpaRFpDcmVmUG9rYXVzUUcvV0g2TE92UkFXRjU2RXZDc0tv?=
 =?utf-8?B?SkdyRlNsOGNXRkN4U3RMWWQyMEszVDVXSHZHRGIxVGRtbXNaMmtIcklLUjJS?=
 =?utf-8?B?MTk2NHc4L1pBQ3FHQlhTeVFPdmsrdUVXYWQwR05IMlBab0I4WFNTVFNBUFNO?=
 =?utf-8?B?dmpKcCtHUVMvWDh1dkNDZVRlZWtaK2tlNkErL2EyM09ySnBUc215dUdvNEpV?=
 =?utf-8?B?TUZPVUJmQjlNbE5iNUR5bWtQYVRMZEI0VmhzYmZBTXNudFpkR0ZldlBEL21W?=
 =?utf-8?B?dThQS2E3eHIxNS80TEJnQ1FXd0VCRXlPZFZGcDloMDI2eEJXR1FtOHJPZS9i?=
 =?utf-8?B?TFVZQ2lyU1ZqZm1TV1hiMnlzbEdRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44743B9834B1764D8E2D5BA4AF40C416@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Spy1uLOAOlqNXU15eXPbDrYykTaNEn+5UMUhmNt3XnndxJq5OskTE1qnyaxCKATaux2Fc0o3ye3u0ILNkYORvFSzM2YKm+psW6GcC0YnJ118fI44FzAXltwDzMR0px0C2nwDqXvgpaUdS6lg7G07vdzUtDDjj1nLlLeJqlMZykWKQrNyojPWSiaUZJe0UC7x3xnm+7E66p77n6Sf9YncEhbPnxrNfpdQy0H/5hFYCUmE/C8oD5cCFLgruYE2nTaORaROp4elbFCPWBOmx11fOwmoHibTz8saFhhxNWMd3SlzdkvxG0niliYVfAQ2KPXOPji+KL8hg/UPkDzdAHcjti0uuTS8yO1ghhWHYaP2pAYTBAH+Hbyqc2ZcoQ67zBoQ3lx8gx//7a890KG7526PUVPNhSG+JKssT1Ra0ACz6T8J4we+/4LqjU8rE0rBEDeJSyyMw97NttAgaLs+odz/K6yil2Da4Kj4pGEuo/Zrmm5H2XRqmch/ffTq1O2k7vm4Ox9CD7CwPaLlX4mGxZpBW1E9lxiqQJ9UQhV80LqOf2DG5SLwT9y9uzT3KKCpdGr3et9vfGvLy+xudxaPFY7+iJWFX8Qxf1K4tgfrrFbxYnB+yXciQg4UdGNF0BXpZfrL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271b75f2-54e8-4e99-66f2-08dc36a4de44
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 08:28:11.1241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Mz12L0x+lxHQ0JXHCIXgGIxEnWKiIcLf8+31VnyJFQCZU/6/bDZTZf5OqoJqyJDpLExfEttZe03cKbLwDirFY4fPgWuuJlA/ITojIyyU9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8442

V2l0aCB0aGUgdXBkYXRlZCBjaGFuZ2Vsb2csDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNo
aXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg==

