Return-Path: <linux-btrfs+bounces-906-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0B7810D10
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 10:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0977B20C75
	for <lists+linux-btrfs@lfdr.de>; Wed, 13 Dec 2023 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5161EB58;
	Wed, 13 Dec 2023 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FFXgvW9C";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="kPJd62hY"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2DFAB;
	Wed, 13 Dec 2023 01:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702458590; x=1733994590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OQA1u8HbNmvXE1OgTCru5XKII5wQvrCRt/K1tJIon8c=;
  b=FFXgvW9CWkKMI8Vby6i4ltTD2Wtwf9bAGUQlpc+z6WAVi2MNBJVfjsj7
   ixUQD/sSYYSQjQZPij9J6ky8OmC6SMWYxzMBdEuv6R/bNX6yuHn7Z8Wya
   ZP8I5q+hhkv+k/57OzAP2gWYMjKORbk1qB6JQQqkscZ/OHk07+yPlsssL
   ycFfwcakLw8GL1woJumWqk8ZPPTHWBLzkYFM74VKwJBHEzBqrSo27qWnJ
   ELaadA5hHYWQjgqzOM3atZ501BdTk4R2/XevBKZpskQb7RHT8rWYXeIpS
   WGb1dxIGiX9n/ONcFdPfBLC4u5sCzk8KvScp8D4/7t3oKYL4EoJ3vsqBU
   Q==;
X-CSE-ConnectionGUID: 3q6HGDdQQP+pwBVnDLLOyw==
X-CSE-MsgGUID: 8ZSl62ceT2+zoSplA1a4Ag==
X-IronPort-AV: E=Sophos;i="6.04,272,1695657600"; 
   d="scan'208";a="4561433"
Received: from mail-bn8nam04lp2040.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.40])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2023 17:09:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX8CxWY5IXEn8me5KktU4iZftcMiGtitz1WTo078yEHqtS25ATy3xRZEXRA7hpZfL8ChjBzmjNpKT4nFKjbucReTS9xev4Gg/US7EGuVYwThSNpeg9cgej2yGQbouXGwHnH6MH6MnGounXjZEfndF3A9nzg/8zKNsr/Y/ppx6gOOh5ioEzkdPa7jCS6NyC7GlnC5dKETtqne4Go7ff2dseA+pTSL1J7ooKozn4r5pe90W7y/iEtmDJAoBlDgV8sgb4xqNFgoPDucPNJVrvq3ZY/npZodyl1yfv5QGg1vo7WJuxjxhyXI+m9JnGAN6zAazgh+PYQ/HELVb9hcuJdVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQA1u8HbNmvXE1OgTCru5XKII5wQvrCRt/K1tJIon8c=;
 b=oS4jZIrpJZZIzPFOn4Jzea0F/2GGhSx9/9NNMrHvyT29O6XFL9uSuvzoTgXUUG84mLfMlErS661yQZkIkOmKmd6Fkv9g4yX8EbW+oqy7/M+jagJkU344pfybkhKR4rcExcIi72kJzpz/+H1N8p+sA/W/2z63Qwx7y0UhlYvEoNk7grF9Y8RL11bNAVKwycdHqwTXzZNGv3kxlPX2kmDKGh3kmmYgXHIaj2thw2KDVuizV2qQV2Vi0N5///NSWyItKXxF9EuZ92YN9N2G/VCukwQ5KdZ+5U6Nlc6xyj3FFTaTJmyLX5n7dyBe8/GBtE9EQ+2FuQiPxaOD6Dpx9FdL8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQA1u8HbNmvXE1OgTCru5XKII5wQvrCRt/K1tJIon8c=;
 b=kPJd62hYnpO6NMQk8JcfppEliUKCjSHfIJ3X8ttWTlxnprCpSnpCK9rgr4OLEQM+vT6kgJ28wSFttgOoxDunF614g2D/M/cYVpegRH/VbakI4TAU1L8ebndF9QEZITTkT3Q9TlcB78xDNNzZKRHXZ3wRqN4tu2lo7yndu1Vw21A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB7998.namprd04.prod.outlook.com (2603:10b6:408:159::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 09:09:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 09:09:47 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "hch@infradead.org" <hch@infradead.org>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/13] btrfs: open code set_io_stripe for RAID56
Thread-Topic: [PATCH 11/13] btrfs: open code set_io_stripe for RAID56
Thread-Index: AQHaLPgdK+jg9mbUFESmBC+cO90CU7Cm6y8AgAADHYA=
Date: Wed, 13 Dec 2023 09:09:47 +0000
Message-ID: <f1cc59fa-9260-4a42-b346-17862d0f8385@wdc.com>
References: <20231212-btrfs_map_block-cleanup-v1-0-b2d954d9a55b@wdc.com>
 <20231212-btrfs_map_block-cleanup-v1-11-b2d954d9a55b@wdc.com>
 <ZXlyPqtXO+j90vJb@infradead.org>
In-Reply-To: <ZXlyPqtXO+j90vJb@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB7998:EE_
x-ms-office365-filtering-correlation-id: 9c189f2c-303b-4d3c-a64c-08dbfbbb415b
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0AefnTFGeleGTPvrYWfb98YmKlyqyH6R/WTPlQtOWFE5coX919OLCP5EW9C28JKnhYHcSy613f3EX2dduosVErU5V/MZcEKddqO24bfEit9S07wromW3pxY36hsCs5fruWJ37LnP1nqQiClGH32VQoJeCJB/AxqMYB+5Ow9wLutyE9LoJVXvQeu125LPUwaG+n3KoNmnV6cxndEDX7FwgYWYUa/abkUmb1v2JKwecMVAtv4b0F0ko8Ltj6D5ubxiQDoiyL9TaoQcKUWaBvHWqbVB1Esj2GSkDcGSRDdbserDSCfmH7/KhHkJf1qcpT4ulrkSGkbcWyhMo92DfvNgiL/7CfCZL46ipBUjIWUVo/LwNrAz4STv/BQGtcm8u6aGMPqoy+1wMbXQMvH7nbsWjzaLSPHixUh+efvzVRDjGPgM5SZud4mNoE5IvYnToD/e+FEX79Rc0ykSoUwYnkWHQEp8f6KJ4iDPOhUqGXWhd6b0BJCvfAhj52mHbscWX58aol7L4Hxjk3xWPmS1vJ0JfDn3WFKwlp7N0S76MRWQmAo3fsKHOwwR2rUH1Ci/f9ieyYb+DhmsL9Pt2fAWwp2nmnv5b2/QTi6QVAoYvgj2slc6NEe5Jkw1IBOmMaZh1Ke+U/HVxD1BHuzZx+a5yy/slIM3IYO3EP2SUvtU1PrnDy15meWEvhKBdkTFffdQUl7h
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(91956017)(64756008)(66446008)(54906003)(66476007)(76116006)(66946007)(66556008)(53546011)(41300700001)(6506007)(2616005)(71200400001)(38070700009)(6512007)(36756003)(122000001)(31696002)(86362001)(38100700002)(82960400001)(478600001)(6486002)(4744005)(8936002)(8676002)(2906002)(31686004)(4326008)(5660300002)(6916009)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SkI3MTM5NmFsTlczRTRCR3J4U3R2T2FhTVB6RTlOdTczV25FenJjdlNMcmU5?=
 =?utf-8?B?MXFya3ZjOExPWWFPM0tFbnRjaGdvUnZJTFlSQ3pJeTBUZUN4UElmQVFlNXp1?=
 =?utf-8?B?MmRsZFJkRFFtb1RDbUkyZGtad1UxZ1JPdWFpb1ptaS9LQjFnYVpnbDJmNkxi?=
 =?utf-8?B?dXYweStUcjJXUXFaQlFEaURLTDduVDVwN050WmE4azdOM3BEckJkSGlsdlBR?=
 =?utf-8?B?M1UxZEVmdDgrVFFCYUtSYStRd2sxN29GK0ZYdm9lR0xpQW0reWxDQ0lHNWFS?=
 =?utf-8?B?V0JtSCsyaFZ1UW5oWUdyaWJBMkwyZHI0Y01MNzhlNHBqVHR3bG5ZVHVkdXZE?=
 =?utf-8?B?S3JSQ0tPckszRmxUempZMkxhVnFqWDI3cEd0KzZ2ODZiMlVCN2w3OEc2M0d0?=
 =?utf-8?B?aGNSZUhKOS9GUmlWMG5GaTA3Q2NBb0pqY1ZRazBnbTFWZXZMakN5WGZjd0lk?=
 =?utf-8?B?L05Tajh2SFVUTnJ6YzJQNVFHOUxNL2NkY216dkFPcDBGUVJsR2dxbVZ6VFhE?=
 =?utf-8?B?dXJiKzV2ZVFoU1dPcmVhQnlVZjF2T0lkL2gwWVN2anpic0dQK1ZBbEpiS0xa?=
 =?utf-8?B?QlhlcXFKMGhVcEZnSmFmQTlDNElGbUc2SDVqVFNKeE1aY0tidDVxeW9VdWVX?=
 =?utf-8?B?UGpZUHFtT2RLS1NCdlJvdnFDZWhSU2szNC9UWmYyWGdRL3ZGV3krdlEvcWZn?=
 =?utf-8?B?bHl4RHZjUzZ5ZG1DbEVOQ2JDUURlTnlSUXc4S0xTek03NFd4S3Y4T3gwTGxP?=
 =?utf-8?B?UkNQR3ludk5mcWpYNU5TYVlBNzhiTWdYUGFIdHRxS1hDVTB3R3diNlQxYUht?=
 =?utf-8?B?RFBZdVJncEs0Wk9xaUtHRWdhUExjS29HUHhmdXRLRDFxbzZpc0xpSncweWx6?=
 =?utf-8?B?bU81b0dHamc1Mk1pK29Ja2NPRWh4N2hlZ3dxbGVBaXdLckRDMkFjSEZHTnhi?=
 =?utf-8?B?NDBuZXpMMnZndWNUc1hXbkhRdlRwcUJ3Qi95SmdCVXZZSHBMQ09qaFE1UDlJ?=
 =?utf-8?B?Y2hJWkU3QU5paXRZSC9qbWFUMnJHVlhkUDhXM0N3MnlCKzF1THZGZFhPVGEy?=
 =?utf-8?B?ZkFkUkdiY2x6VmRIbVpVLzFuYk9xR0VKa3dlL3RPTXVKcWxWQkhKZzdIOGtR?=
 =?utf-8?B?Wjl4RG9oZm1zOFJYSU45RzkxYVc4TnNVTVFOVFRRdk9LTVVUanVGYnBXeWtI?=
 =?utf-8?B?WU00a09STUVXdHVCeGVJcm1ZWWYvc2gwL09qckpieVovWUgvdzR1U1dENFZD?=
 =?utf-8?B?bEM1QXlSUFpoT3U5RXpsWVhnbVQ5aUF0Z0Z5aTF3TXM1eWg4U1hIMHlJWmNS?=
 =?utf-8?B?QTFHSGdCMUl0QzF5ajVFeEE0b0FqZ1dLaDFzSHJpOVBKUlNjYks2RmV3RHBl?=
 =?utf-8?B?ZzBUOWZSVWQ5by9WOTZkZVBNV3JQQ2N5M1Bxb2RFanhHd2VvaVZhd2crMlFY?=
 =?utf-8?B?THJBVHJOaU1ZQmEvSzlGRGV5d2U0ZHBITlE5eU8xN3lvclJaYm4xTlZLOTJZ?=
 =?utf-8?B?OWdUNEdqZWQ5dFhaQmtwNSt4ZmgvVlFiYW13NXBnUzNuWnBtbllrcitEblc0?=
 =?utf-8?B?djdDbVlLMEtBb0xmVW8wa3FITVZPVlhjVjF1eXBTWit3NVo2N0ptVFNBR0wz?=
 =?utf-8?B?N1ppWlZnMmVySzBic3B6ZUdPNUNqWnF3eDNjdVg1TitkVUZHYXU0VXBCYnJP?=
 =?utf-8?B?dDlFdkJ3NER2amNPU1BMWnhwcXEvTjFIWWJPbnVOQ3BxQ0tZSmN3U3BhR3pj?=
 =?utf-8?B?T21TS2pOOFV5UGloSVBxNDQvdzhBUlM3Zzg0SHZrbmdrQmhMTWx5ZkxaTnhB?=
 =?utf-8?B?Y2pGTEhLb1Y5MFA3aGxtS1N3K1ZJU0R1azEwV0VkZjNzK3BEL050SG5ydURS?=
 =?utf-8?B?SW9wZHY3Si9kL2JHeG9RQ2laaC9KdHk5MUVaQytBemM1MkZZOGZlT0dmclll?=
 =?utf-8?B?aHRMRjliTkt6ZjdIelFlbFVZOHp6UEhHbXBTUzhzeFE0c0NWQlM1OE9KbmNs?=
 =?utf-8?B?Wkt5YWVlRUxGQ09rRW83L0R4QlNacU9NMG9FQmI5Ny9OR1ArNnAzeVJheHBO?=
 =?utf-8?B?VW10eVdObWJxbWNQMGpzUGN1VWx1bURhWTNNL3NnRjNkUmEyd1ZYVWFwRWFh?=
 =?utf-8?B?a1VNTGdGQWJ6cWRPZjFoMXhHMzlrajZrR0xFcUZHVHF3dEpHS3FsK3FDOVBL?=
 =?utf-8?B?RGFxbmNscitQUlJPcFVzTFJTRTcySmJrdkw2Vk9Kc3lOZTVZLzY0MnQ5YWxz?=
 =?utf-8?B?d1l0d1FLSTgrVFpJNHgxYTZLUGFRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACD0B474CA028E4A8F14C5B6CEF7FB56@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WWKvkdeh4k7iEG/FESomMMPm5wiv7Ol/yKFut+XmxqbGnD8ZAYpdgG4fA2xBenLzaW0HSWXOH0+jQHwtvfBwmQ2mw7yTzsZoz3jn/pY23t97CzdHmmbVcBgIMRsIupzu5lWQU/qM0lVaz49J0hqSJ3na68l6J+sWFmMKyWrZI1KxHhbtNPovklBQps8G17MSCIjCx3O3XIYJPczHEJjyHYZ6fraUum/z+iiRLC9iD6OHwDSuKbrZbcZyNSeyBbhV4F0hGEGDi5KxplfrxpzuZh6fs9kLmeLnVGDWg4SlaGRdSBiPrdCiQFgkle4Gu9XwOHpEsi9diHQh5FsBHYn0pDIwk+jwTp0SAbbF7KE4km+NOQhkIHQXcP+Ij6P3LE2MR6UYkDbeYN28fybdkPMI6Nx3VL8VUadsE/g7xwTEyjo2+9PMgF/mnzND02XNXjB/XEW4xfK/as31cb/svEj8xOA1lyRHvfFMLxriNw7QtPAw2UcqS5HwN6taTaBp6sA2m1AlVhQb9gDPMOpCjbx6Ft0MUC1sEFBfr99VM3An1o2LQfOPnddKjwKcBB0vWQ1tM0bA5qHfpVjZrj7sDxU4AIdo2atnl2Iozk6TlSr6zoZBVGxDfJ56rPJo9YcxBxXf
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c189f2c-303b-4d3c-a64c-08dbfbbb415b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2023 09:09:47.6574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niFCVT47pSapRj5R7G6cwS+AmuM9hqMhEZMyZbogFW7QrSULBDMPYgbqyEI2HiOd3Q65Oylgj/u7Jm1J2P/T8/cJUOmnqe8/GAX3YQDV5Hg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB7998

T24gMTMuMTIuMjMgMDk6NTgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUsIERl
YyAxMiwgMjAyMyBhdCAwNDozODowOUFNIC0wODAwLCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6
DQo+PiBPcGVuIGNvZGUgc2V0X2lvX3N0cmlwZSgpIGZvciBSQUlENTYsIGFzIGl0IGEpIHVzZXMg
YSBkaWZmZXJlbnQgbWV0aG9kIHRvDQo+PiBjYWxjdWxhdGUgdGhlIHN0cmlwZV9pbmRleCBhbmQg
YikgZG9lc24ndCBuZWVkIHRvIGdvIHRocm91Z2ggcmFpZC1zdHJpcGUtdHJlZQ0KPj4gbWFwcGlu
ZyBjb2RlLg0KPiANCj4gTG9va3MgZ29vZDoNCj4gDQo+IFJldmlld2VkLWJ5OiBDaHJpc3RvcGgg
SGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gDQo+IEkgdGhpbmsgcmFpZCBzdHJpcGUgdHJlZSBoYW5k
bGluZyBhbHNvIHJlYWxseSBzaG91bGQgbW92ZSBvdXQgb2YNCj4gc2V0X2lvX3N0cmlwZS4gIEJl
bG93IGlzIHRoZSBsYXRlc3QgSSBoYXZlLCBhbHRob3VnaCBpdCBwcm9iYWJseSB3b24ndA0KPiBh
cHBseSB0byB5b3VyIHRyZWU6DQo+IA0KDQpUaGF0IHdvdWxkIHdvcmsgYXMgd2VsbCBhbmQgcmVw
bGFjZSBwYXRjaCAxIHRoZW4uIExldCBtZSB0aGluayBhYm91dCBpdC4NCg0K

