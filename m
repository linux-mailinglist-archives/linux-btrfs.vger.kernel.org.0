Return-Path: <linux-btrfs+bounces-1572-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CAF832C5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 16:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97192B22D5F
	for <lists+linux-btrfs@lfdr.de>; Fri, 19 Jan 2024 15:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AFB54BC1;
	Fri, 19 Jan 2024 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ojch7Rw+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VqRjmN/0"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75951C4B
	for <linux-btrfs@vger.kernel.org>; Fri, 19 Jan 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705678242; cv=fail; b=Vdv2hqXd/l0Dwo03U+SJKB6NvbI9VYHDkueMAiz+w2phoXnMpgL/XePut8aCaQgd4cBYJY7U8YEc+snK8hUw65zj3x4VwpcvWimB9Qk3WSRURa6c0YKyPI5avZEE+iox3iq6oKNzAq2v1xeP5Y4KRzyZPaGiYfpZpkTMLJ4qN5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705678242; c=relaxed/simple;
	bh=6BzjrFkVUF3WqnGGHAUJaObrEQptjUeXiHp+BL0eU/k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TbgYUc/IctfFgJL+n07F7dkE3KyAnPydmu/UKx025obP8GCRaB7wr4aQ1IbYPQTk0VuRskigk9RsSfdcntj0LiPLAtyxFje0qvb/jndK5+6mIBEuIRxNmM4F6X+usAOYQVB2VXhuDdkBLB+cwj+GwWUBaMIzwnDTO0dGIZnsVEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ojch7Rw+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VqRjmN/0; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705678240; x=1737214240;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6BzjrFkVUF3WqnGGHAUJaObrEQptjUeXiHp+BL0eU/k=;
  b=ojch7Rw+4FVWzrG7rTIaeHqqTAAaLAi+fYJFyxHVyn/DFZbq0wguOc45
   RpelVc1GNl+f5S3CLmclamW2Zx/XKQ2p0pCPdHf+RRH+ODW1MYPhOJW51
   9sadapgyWrOCazPADc8HwOaSdQJEvue5YaiZOPAgU+o8jpHhYs7Q/hjA/
   C33USl1xDiMQ8BP5WC+/m2gmQhlvucgp7jJVysQqt08wL+IwcxinK4t/L
   Rf9/10w0eem9RMNesu9xE5CVJnGTwip4ZUAzXBiU7NS+CrsKrcTVXVO6J
   U99MfmXLkADoKQOQUWriV83HtP3jjNkBgXI1fneiZNhZiB/joUmhroX7d
   g==;
X-CSE-ConnectionGUID: iOWdj3vLRVyqkRl7hRXlzA==
X-CSE-MsgGUID: EAMYPvesSomY5qNMlPXzaw==
X-IronPort-AV: E=Sophos;i="6.05,204,1701100800"; 
   d="scan'208";a="7285906"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2024 23:30:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hKB/WYFPyc6Ch0VDBa4KjTuJEyJETzMtL9MLdcthoemnqt+Av47IXgFFuJr0izDn5At4SUnEDigaQbOG8faThgLHqrAt2BCO1tMrMxECj2UyqU0xgvmrT2k/1ML83zlOrilCqcFjd2Lzg31jxWYEM0YStpVcObgSIZlyqS2AyKl8I4M3CIVVAUfBeyGSCAuYBysKW0qWvZKrQW3KtaB8JLvGcFcUcqHv2ELCyp6DGZD3VeUcXymXo3lzG405khng+X9+MouAZgpH72q78EUryLpt+0mdOo5taUQ+PC08tLkuvEoszd+4817UIm8UXthRtHNt5isO1WNsyC7CEq2h4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6BzjrFkVUF3WqnGGHAUJaObrEQptjUeXiHp+BL0eU/k=;
 b=S+dfqgCqvkmp+n5ynAPNqVrCcUw5LaMX5pgk1Ll0WtlynhG/hGdqhDA/6o5L53EeNUcF1CympSC/Bh+0AYvuZGxDqV7c2JFOQ3c7enO7h7TepoP9knX0TmXWz6FDK9XiWr0iM1hk4MMqGorZ3RXFHkVJwIJ8jprIM05ujI6hZH9j4UU9XkSwVKbuWLL19PNVoOu+uo7hf4YTqsqPkH7AUljzrTifS2hhflGQBu+nzegocYtYuZxsS4Cndlb8LP/CEn2rSCQYAftYY82g+YmINUruyQpUCL+8USwEvgRyP6kFgBcBfPvBOIibrnrAiDAZvN4HMafjo0zgGpezRtgSFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6BzjrFkVUF3WqnGGHAUJaObrEQptjUeXiHp+BL0eU/k=;
 b=VqRjmN/0bvgn7bP1ncxRdRO0RSKc3WRQKG2JgxXRM/cj8GmU7SOz12u9WSt3GEi7vVL/XOatVKVJ9mptyrKUJLS9lEIVNcE6tnfA6k8r4CN5FCAE9mH8azjsSnqtwnqemu1vxWk3ltS+XkwNz0zJrrcW304KzOLl/VqElxRUxts=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB7938.namprd04.prod.outlook.com (2603:10b6:610:eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 15:30:30 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::cdf7:c55d:9a25:7d35%3]) with mapi id 15.20.7202.026; Fri, 19 Jan 2024
 15:30:30 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Naohiro Aota <Naohiro.Aota@wdc.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "wangyugui@e16-tech.com" <wangyugui@e16-tech.com>
Subject: Re: [PATCH 0/2] btrfs: disable inline checksum for multi-dev striped
 FS
Thread-Topic: [PATCH 0/2] btrfs: disable inline checksum for multi-dev striped
 FS
Thread-Index: AQHaSewg5kvWF9hFMUyRvuv4Jks3JLDhRQWA
Date: Fri, 19 Jan 2024 15:30:29 +0000
Message-ID: <c491e957-411e-4b02-9f88-cbd8475e203f@wdc.com>
References: <cover.1705568050.git.naohiro.aota@wdc.com>
In-Reply-To: <cover.1705568050.git.naohiro.aota@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB7938:EE_
x-ms-office365-filtering-correlation-id: b59b49d6-4a6c-4671-552d-08dc190391bf
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MtQf4/m+DeqtDKqPltEMsCOwwJFw0ZKcAQfUIdtsPh0wnEtriCIExKadRfzUCq4wt5rbPSwwPApbmjSt+ZkI/8Ugw/CEtoeGMudw5whzXwujNLGQATogXfAzWT3Y7AdZBx7n75TjqePEhaGVxBBL55Yaud7unkDrRFmeOfE0WOgFLZpXq9bEjV2LH1H8kgcShioQ7dadm4EZ9MRiN0OXjoCIqtzP0NWFjHuuig3Lo9PDxBGIWRgiuhyPeRwicGyfZxhgdgyy3A1W+mCrV3niLKo92NuiQwwxmF2Oo/XpgtbazF0s3bLdg7wyIA1NERnQ+SE9VY6em7Gh+pKWm2R0Fm2bZu/w1ji6WWda5AzCgvnYeZkT1PlTRG/QRNcEJTvmh+yFXdmEkgaHwS/EzePu7HGsCG4t8Aesw9OarJ/PEpR4XhSFRR+UeFQ6cotui74o79roBaLy4Xqu4eo9NFfHj2CO+Eg6SI6b3RyWzx+4T01mZ5UYcOCAXLUrjtP384DHmtUuOPs3FWPhS8AmQZ3szE2KWMhSA369EpcZ9D3RqVsHUm66e0mFHE5iRaieDQzgq9On3v9cXNxel7yErxVkrJlgW3SciqmzaDsI8uaHUt/pF9rCNwMttEAoRNGI+AX9UQIRgbIAohVkq3ijkgLkTaS9AvPEdg9RvG8K0OJnp+/AEbzBuVcFKqvOdY5gdoKp
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(122000001)(38100700002)(66556008)(66476007)(76116006)(66446008)(110136005)(91956017)(31696002)(64756008)(66946007)(316002)(71200400001)(86362001)(478600001)(6506007)(6486002)(2906002)(8676002)(36756003)(8936002)(5660300002)(558084003)(4326008)(31686004)(26005)(2616005)(6512007)(41300700001)(38070700009)(82960400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T0x4b2E4Z0tRajdWSDQrblNEQ0RyWDBNeXc3VzNMNkFnNldYcEpQSmdCNWhx?=
 =?utf-8?B?RXRYeUJienZIMnlpS3A1VjFZZGJ0dVlJYUNPbjZqVFl4d2NGc3IzclpxSmM3?=
 =?utf-8?B?OVNVYm5pR05HQkFKL0NKb1ZKVGNaVkw1U01MTUNBUDh1S3dzQWZNRlVPTmxv?=
 =?utf-8?B?blVvYllrNFd1Rmh0K2dtWWRWOS9rZnk1d0xqVUJBcmR2SU96aDFlSHU5ODAw?=
 =?utf-8?B?RkdZRDUrZkdHT3pmd2tnSGNTTU5SNGZXc2hma055VmZTdnVNMm5KVzlYamJJ?=
 =?utf-8?B?KzNNcE5XUHVUQXRRRlBuejU3eDRnd2RMUVN4Vkh4YXVDMzJoNHlTcVJLTVQ1?=
 =?utf-8?B?K1F5NmJ0VHpLWFgyVmNTaW9XUUJVRUV5dUtPQXdaMFdEYlFCVUtidFljWlBK?=
 =?utf-8?B?Q0RPanNkOHdLQUxuU3BSMmQ0RTJVY1dXd003K01oWndZZ2lwcWxCNzNVWU9Z?=
 =?utf-8?B?cHFkT0lqNUNzSlh2YXdEMk5IcXZwSS8vUG9xUEpxS1ZsQ3FJbTNjVEt1RzZh?=
 =?utf-8?B?WHpCa1gwaTBZaGl6RDR6cjRzUXVZRldHbkZIMUw3cFpKL2hnQlVvVk5lTVU4?=
 =?utf-8?B?NVd0czVhZmxjK2tMdFBUOEt3b1NhdHhicWUzLzYrSVJiKzJHYW5FU1lxU3Nw?=
 =?utf-8?B?aUpyYm1CeC9OS1NlVzBuOUJrUFpXc0ZBTDVNVVpQTGtuOXZoeGllNFpreFpM?=
 =?utf-8?B?YzE2T0hpMm9mTFNPNDlnZno1YXplamc2S0swY0o5VVZBVnB3RkV3Y3JvZjE1?=
 =?utf-8?B?dkUrSTRJYnEyNW9HdlhTMmVWNUdTVTNoT21HRlNNQmV0VkZrSDk0WnRjeE5h?=
 =?utf-8?B?K1piSzlJcTBrMlJzZWZ4dUlTUDhSVnZ4Z2ZTcURBdHNST3hqMkNZWEJaYXg2?=
 =?utf-8?B?cW8ra01vbXVyamxGV1pIYVF6VXAzZ2ZRT3l0aUpJYThvM2tNdHhxN0hPNnhx?=
 =?utf-8?B?dkZCUlJSR0FDSGRneWJjM0wzQmtzVVFUNjlZR0FsS2IvSk5Ha1FjZFJpbXFO?=
 =?utf-8?B?a1U1SWlMZ0JmTzlWZGhaVm1lOEpOUGc0SEo0b2kyTE9JUlg4OFNzWG1uYmFD?=
 =?utf-8?B?dmRXQUFNRk1VQ1d6dHZiSXVOc1FNK0J3QnhlT09iR2NxUkhZOHpQYnlJUjRo?=
 =?utf-8?B?R3dScFFTZzA0ZkJVbEE4aVZCOFRPUENGaG5Oa2RXcnJjb0JxeHFyTE5HYzhV?=
 =?utf-8?B?aSt1SmF3QW9NL3o2NHVzUVpkU1lpaUdscnNvYjFENk80SW1pU0N2c3lQaWt4?=
 =?utf-8?B?VFpaYWJwekhYVFBxeU15YjZDZGVhZEZpcVU3QjhYYTJyYmltY1F3RFZucDBv?=
 =?utf-8?B?dFBoVU9XN2N5QVFhaGdaZUFhYW8xQWdKU0hjMjh0K2JONDJQOCtROFRHajFH?=
 =?utf-8?B?ekJTVkJTaDlPbG92NjhBTk92N3pjcG5kOG10c2JFbDUwVzhaQ0E2NjhiSERM?=
 =?utf-8?B?VTBvWVRoNmxFZzg5T1NiZG1aSGY5S2w0UDVlSWRlR3BmMWpwcTJma1ZqL0hp?=
 =?utf-8?B?eEV4eWhaRUVwNVZ0ZXY2RGpNclRSK0wwaDVUV3ppWkNNQy9CUDU5aFhUTHBJ?=
 =?utf-8?B?WUF3bVpqcHZ3ZS9KWDV4KzNqY2ZSV0lCRS9qWkdZVUJIZFg3T0JLUCt0dU9z?=
 =?utf-8?B?L2gxUVNLcDB1bzEwUENpQ0tGeWxkT0tscS8wZEZUNUd0bCtsbW5Mek1BRjV4?=
 =?utf-8?B?Vk9kRjRURnRpOU9QekNmTkhDb0UrZDN2VjJIZWVPUWc4bkUyUWlFUXVmRGJk?=
 =?utf-8?B?VGVQdnlvZVd5NzlFWks0OWNxSGpERlZ2R0hwaXd2V3JJRkFMMWlOVTdSM3Ni?=
 =?utf-8?B?c3doQlB1NXF1bDZqM0Y4bmFvK3pTR3hVODFoczNZcjhOMTJTZ1o5RzJSemRr?=
 =?utf-8?B?VzV3WTNhSmJwTGcvRDc1bHMyL3hwYzdaM1Jzb1llVFJrSiszNmlNT0MzNUVn?=
 =?utf-8?B?SzZOdUljaHFYbm1KaHpQRWkxODE4bHBVZmM0VUFPQ3FXU0cvQTBnWGdDVEZE?=
 =?utf-8?B?VmZLSGF3dzRFTGpReEdVamVWUVg2L3N2bVdlOVJYaGRueUZQOTh6UmVIWnlT?=
 =?utf-8?B?bHd3YUJzbFNDbXFtRW1RdTFQQi95SGtZZU51Z0VxOTNUeForblBxYWlFdGxs?=
 =?utf-8?B?TzZUTFMrckJzV2ZJdWh3dFA0U1Z3Y3U0bUVVQUpPVTVoZHRlZTFld210SGYv?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0C3B62C2B64C9441B6D33FBFB6256E03@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Dqi3ZOj4uqu4LL0p8r6yzR7+3FlTtZh+SkIPmaCzchX8llLVQla+hNvxDcID/6zJOb81X9WYqgbm6z+xSQ7Wfr26n98etTgbYaJigxDkhRMgBAij5afX/Q77e0kDqf31dIDCHOqYOaMzLqeGPDPfbRdyVC0YH/UHCWDF7dAgjiSAjaBJlTRXFD8O2liDx0rJkxa2c/U4Av9j2lC216YAhcj4FvMwDRvHVQ4GGV6akooy5jsJ3x9euKEiu1+fhBETbKj/YJSN41Tworxv/kBK78RlaGLvj3z9YuN6w5yChJLHInb1lUcQfdjDzGGZVeKxwz+31aaSaN52NKO4UzymVbZEn/auOCZ9pq7gPfJTJ81dDLYo8gaUdR3zfCWszJ2YM2GKiSAIKKK7ZxW3ZcBfpW5Gfqg3pVqUO7hv3VRXRGsJZef74ta+OQrXWVwrGsiS8HTA9EINjx/YASKnK/OQdAmtSiGYcff3WsYiTomp5mnSfIetSi6kIvfhmCTJo/PSljiHt1LR1H1TdDIFuQ1Qwe91f3STgNrzyH/OMfSZWODOtThAYjJsmywKD/DtYWgmMDnYAXbYsOs/btdduKIcfdJizH42UlMibIUHVEZ51XgpZZfip/gP0er83r7W6252
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b59b49d6-4a6c-4671-552d-08dc190391bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 15:30:29.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 55NJmMAofXwIWfu/TlGHLMw/j8tPO8acH/rwMlz9oKuZUz1nF9W0pIKU9ji1CEpVKSLcQGlYY248HGzztRKswD/BVkBq7u2RakHSi0htGjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB7938

QXBhcnQgZnJvbSB0aGUgc3R5bGUgbml0IGluIDIvMjoNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBU
aHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

