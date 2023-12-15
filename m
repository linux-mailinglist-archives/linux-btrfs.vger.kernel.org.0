Return-Path: <linux-btrfs+bounces-974-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6774814A86
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 15:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D021F21512
	for <lists+linux-btrfs@lfdr.de>; Fri, 15 Dec 2023 14:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348D935884;
	Fri, 15 Dec 2023 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="JSdYb/D0";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="QzdZfbzi"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9043589D
	for <linux-btrfs@vger.kernel.org>; Fri, 15 Dec 2023 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702650677; x=1734186677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2VmSWJTwWrZYzhGW+Ulgy/wDpaQy0co78c3KV2yhbVQ=;
  b=JSdYb/D0Bfxj6LCEcTC8pDWzBIVrHPO5aQFi8Oac8uG1pIYESR8/XpNC
   yHCK442ALMpYaoh+8NoQPoHQfhTIuomHMNAU5WoyfWt2BhL7NmfFFi4eX
   AGh4DkdhNJ8KB+70lQO0WWKZzyOxc3EwOyOhozZBlUNhYeU8WPU4NNG2M
   HeAVR7yxNdqRoa7XZS9Yh+ERY5WWz79EB723JLpW6ZPuvvm78KzrCvZYA
   +NZM0sEleGrL47tlbGUvoIRDtjuLu/lLE1AKw//IsioQwGyWQWRS/HmMi
   cPdywMt1T9QZ8OTtW2xnTODhlCTVRGWhAfo/U+c+4Tdm2P1lK8phIXZri
   w==;
X-CSE-ConnectionGUID: pR/qhA1jRf22MTg37haEdg==
X-CSE-MsgGUID: enkBAC24QS+qdXXBdIH46A==
X-IronPort-AV: E=Sophos;i="6.04,278,1695657600"; 
   d="scan'208";a="4751478"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 15 Dec 2023 22:31:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOdjjaOoKmPHEkptbu1vrs4xU3sUfXOynqG1WlLpFbuWJ6ns6whmRtLFISSqeYeatNYb7mw+VYymKQnu2qxMlt08xV2L5H+Iu5SW7DK4o+IVybEbpET9F7xzl6BevpXoPqTpSuEUlp1x6/i0a4ekJwVY3DtATzfE9ivweBUQBc1URedlTruXAjQC4FQ9IZ3xR6/HMGPwRfdVie/akqUz59K6BQDtTl2yKF2ex+Np9ViKlBfsGulCTB4ow48uOkeOud+th18wJ9QvjEDSJBT6HqUtyirAS4KUXPsraXdRU6ka44y6B/qvBgN9+aXNAEJuE1R/pkenus84VG704ojOog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VmSWJTwWrZYzhGW+Ulgy/wDpaQy0co78c3KV2yhbVQ=;
 b=h8r0X5tr4d76EkwPgK7ykXup+47zL0JKPl07tAVoevwRblo6TeAHXROWZE6UuMU/91WHV1PnMNDrzV6+InSo0TNDnzgfryDMFDYNFfBs0TbEreFYcUnePaaBB5Lp+OGC+zLmCgL7jPFwLXp+8NRaQkyxVxxNU0Zitzn+uUHYwOOB//IIJ61pQoNlAaPx9a3vUOHs87gbXIF1fUmWwet8K19k0LBjqKXJN7IvsF3DB6wWy19Oz2yb1GNT9NyngXRxxadv5xARjSc6zDTXLHZCcvagRx/eYiR0ET+LpFeq7dPCMnOWC04/BK8TD+Ghs9tKndFovSj/E+Zf4l3miK1CWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2VmSWJTwWrZYzhGW+Ulgy/wDpaQy0co78c3KV2yhbVQ=;
 b=QzdZfbziR3wQnrAPGqr6xoZrf/J7ku+1lbHEX7/IU2bXpa3E2ov3XTajE6NI+DdYKgazuhSmOkujn5BCohWGZHzTLRrr9rjd6M3pawHPx4oKXdiAcS4dElfBcuIbn1FH1kTo9ixpVQH0JriHwHv9xjoG0SWPTk/+8s2eiAkS1FU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN0PR04MB8062.namprd04.prod.outlook.com (2603:10b6:408:15d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 14:31:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 14:31:13 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Qu Wenruo
	<quwenruo.btrfs@gmx.com>
CC: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] btrfs: Use a folio array throughout the defrag
 process
Thread-Topic: [PATCH v2 3/3] btrfs: Use a folio array throughout the defrag
 process
Thread-Index: AQHaLqiPUU9bI8qADEuTB4SWRxaz47CqaWIA
Date: Fri, 15 Dec 2023 14:31:13 +0000
Message-ID: <47f71d20-efb9-481a-acd5-e0d5b507bbda@wdc.com>
References: <20231214161331.2022416-1-willy@infradead.org>
 <20231214161331.2022416-4-willy@infradead.org>
In-Reply-To: <20231214161331.2022416-4-willy@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN0PR04MB8062:EE_
x-ms-office365-filtering-correlation-id: c9755c00-5939-44b6-441a-08dbfd7a7d42
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z8hJekMSPA0/CHJGx1aKkTcvuCnbFx0KXMuKdZwXNVWTMvFT/IOhK0/mDDAr/ThY9xP9zoTGZ5S6KFrfJSGzdln98Yi62MjkxP923emgpvOUlkLQ16RLvu/ThAtLcMue+erIk8UNqdTR4s25nj3ZmOgZLugRpCu42gc+fC0WWoFRRid5Ye2DMxNxU7dNI6HUwnxasTY1OMUipr7wTGYA3RjhIJYkBPaxXjiQ4ZMlP08cCD0LFvC2JSW2uOxQh53zxaWUWhxscAbz12RkRBQqpnftlGiKmbQr1TkiEhZle/J7777uiPbcH+3CI0oE2BNYBBJ8Kd0QKZbaSa2OOzdHmikDPVjII1x86KqTe2dZ8bagCS7pMMGNe4GfesjtNNUlE+046DL99mJ7iXmke7LFws7Q5iikxko4KdwWYNr22HuDi9hDeeEEdAJuF6Ws03sId16X4llHEvNHGEt18R25zIv5xXIZkZRqAwlPWeDfbbgqtNiV4Mkc5EhGB1W0ZGDQNExCaOJLHRzTYB9d4+wwse6/BUZ7/r0zxricazrK1kXK9whT9dBXO5W3MW90JRmeh2UIZDCDh8JIfTGxfVCgkKULP0wQgAmpjnyjgleOVCL34qSwvSHwlCzT//9yN8CxyMqbW4c2sKXBp8fZwnT9NZMrxcXMYzpI9uMvOxv+xK8vKjA2ge7MvPRSq+qMnpCN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(38070700009)(110136005)(76116006)(91956017)(316002)(82960400001)(36756003)(86362001)(31696002)(122000001)(38100700002)(2616005)(71200400001)(53546011)(478600001)(6486002)(2906002)(4744005)(66556008)(66476007)(66446008)(64756008)(54906003)(66946007)(6512007)(6506007)(5660300002)(8936002)(8676002)(4326008)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnRtcjhKSkx5L3BTTWVHWHc0b0d3Y0NYQ3YwSWlDdDFjdFhxeXFaR3p1WEF2?=
 =?utf-8?B?YkxRWHFlTmlqcEdpTkxiaDFCQzFEZUlpQWF1VSsxM1ArOFBMbFNSQ1ZTSTgy?=
 =?utf-8?B?dDRLazRScUNZYkVBQmZCTHBaUEsxYkxkcVQvQ05zRHhlMHk2cHBxNWYxM3dH?=
 =?utf-8?B?V3pNMFRkc09tWEJITW53YmVXRlNKMSt2NjdLTTlPNHB5czNaV3FUdm5kQ0E0?=
 =?utf-8?B?WnUxblozNHl6VjJmMXo2Z2NZdWl4NzB6ZEhvZzdpeTNyOVp2ZjQ0TE5uK01E?=
 =?utf-8?B?S05jbE12VzJzMmRpaVlvU3A0RkovTHVMblRvQU1IaklqYVA3akhKL2FhZ2U5?=
 =?utf-8?B?d28wSncrVFo0dnc5RkY3WWY4V3RqT1RaWEVVQ21FenhsSVFwYjJpR1NyMkxx?=
 =?utf-8?B?RVJMMHY1SHRJNElnRFRJZmZjREsxTGJZQm1YVTBEaWRBV2JBbWlZTGhQTmQ0?=
 =?utf-8?B?R2ozYzJMcDBTUzlYWXhQTzR2SjMvUWJQWWFlblhRQW9YVERtU1F5Q0JuUXQ5?=
 =?utf-8?B?eFJPMTNiSWZkWjNxcHR6ZW9qY2JEUjk2SnZlNExVVzk3cmZWWVh5UVoyaDYz?=
 =?utf-8?B?RVVTcnBNTnkyMkFYb0swV0YrMnk4YXJ2SFBmZHlRTTF6K3VRaEcxSzZuQkls?=
 =?utf-8?B?eEF3S0t0VkJvbjFGaTM3Mk5qd2JZTndjZmVmVUZWeWJyS0VhMkEzZUdZbEg3?=
 =?utf-8?B?VmZYOEw4K1h6M2N5MWlnSXRYaDFLSHhkb0hsQU9IL1EwNFVHRmZheXdMQmR3?=
 =?utf-8?B?R2JFdTJSQTArR3NGbUtEOG9LMVNReGFLRDZOTHRRMmc1WTNGemNNMko1UStN?=
 =?utf-8?B?MnkxdmZiWmhNTDFINVAzcklLUk5yV3NrdHlqUXZDZU9Vc3Z0aVMyTjZHZkNV?=
 =?utf-8?B?K0xpWnpFUGdTVGRNaTliVHJ3L1NRQnJPRlVtdnB0ZXg1Y2tDWXBYR2FUOENM?=
 =?utf-8?B?b01wdS9wRjZzd3dreTlaOEFmVnkzS1NCci8rUElvamFYcHRlcmN4Q3AzQW4x?=
 =?utf-8?B?S0crTnlYaitmaExJZnArZXdkU053eEErOUZFWDBtb3RVSTYrcGxXSmFjL09j?=
 =?utf-8?B?MkNPQXJsTFdWRi9rdkN1b3NSMzc3ZFYvU2xvU2tLVHlqMFI0dnU1NWdzbEFa?=
 =?utf-8?B?TzV4eGNxdWFxUCsyTUUyK3FqQXB2WHI4REUrUjBjRllPV3dNcDZmaDF3ZmtX?=
 =?utf-8?B?Mzd3aHpBSGxVaElWUUkrYkJXWHg5ZElCQWVvSTc4SktwRkhFUXRwbWc2bzJt?=
 =?utf-8?B?a0FQTDBzdzQyQmFvL3puRERKdlRyVU10UEVQelo3RDRjS3RQTDJ1bkpnWVI4?=
 =?utf-8?B?c0J6MnFSRktQb0FiQ0xGMmxNeWx6UCtvUU1EUWhJREM4Y29KdjVhcDU5ZzA2?=
 =?utf-8?B?dU9CaVhOWnpIV00wRHh5UGRyMDVWcDdJMTA3d2NubGNzSXVHTFdnZEt2VGFo?=
 =?utf-8?B?ZHlDT085Wmg4ajRuaVBPSzUwTmh6K3VDRGR3dmtUUUY5Z09PdlZ3VDBUQjFX?=
 =?utf-8?B?aDJvYWh4alZBMlQ0MDVPR2hxZTF0VVdieGRRR3BmYWV1RS9IQW4yT3FGdmht?=
 =?utf-8?B?clN0bVRpOFphdTRTVXdRTUlWdTlsSUlJMFMxTG1Pa3I3bEtZaWJBNkVCL0lG?=
 =?utf-8?B?VnRBMkFRTnJwVktuSEh6TkV4VEFtMHRMUjhhdUd0SWdHTXhGL3dJUWJZTm9G?=
 =?utf-8?B?czlsNjlWSFNWMFgyaGxZZkJ3Sm9ENGhzOURSempXcndBMkxwa1E5UWRBWGp4?=
 =?utf-8?B?RWcyQVZLSWpNbmZJZURybGVXOUw1UlB1N200bEc0UlV3eFZGN2hqSmFZckJQ?=
 =?utf-8?B?TDRDaUI0Um1QcUdWS2M2alVabFo1NzFFVE1qREFNaWpyeHdIS2ZVQTczdHlh?=
 =?utf-8?B?MFJaR09RNHIzQ3hqSXAzaHFKdUw1Nm5IbUthUVZEbHBRSFpXZVAxZjMySVJF?=
 =?utf-8?B?eTNDKzcrZ3J5UmpscjVYS2tnSW9MMmxNczV6TjhLdTR5dEVUMWlFb1dFTXBM?=
 =?utf-8?B?YWp0OTYzVUpqajZZTkdDZjAxZGxFaVlwRnEzZzBBUnJNTXYwbXBNVDF5VXlP?=
 =?utf-8?B?TCtmZW1adXhzTVIvak1VK29ML01zUkZBVXdzWHl0TGVaOXhjRzVzZG42OEVM?=
 =?utf-8?B?UzlOeEtoakpPY1k0ZTZrMXU4ei9zbUFyZ05GQmRnWS9jYU5sbFJib0RVdm1E?=
 =?utf-8?B?RWl5dWIzOFloL0cvK05pRlJVSEdmZjFSUEI5TEFnL21vZVhUeDF6ZUVIMFhs?=
 =?utf-8?B?YWtRU1hDU2pMQllFSjgreDRjZ0ZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1666D80A8DCBF4FA571E9A72DDA0BFB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fkws5IODAXHbT7IbRzmGLNz1EtWJGe0yToD372PfFFjQvdwGDUeFk9XJKHf6AM3H7k1WJmZT7v2fjo+1h5o7ESabE9SDOsql43CNB6C5s4DyDyrRRtXbKG38pFbc3WS3LVN0xdy1Qxb0/L8d5AOgCV1tsKkFNoESGlWVlgtv3oqrvhGBxFQ2UGqYJ+BQ1mRC2pNNfid7BcOfJwhL6btBpe49kIXLQ+AtA9VSpy6kHpoe9ZOTOep0TPUyvGaN9GvBD8OwqZIA1ZWZebHJ2tpTYxvkYQ2/Aqr8Vqvm8yvMwxo7Xx3eMAW0N1vuu87yDyprDevbz5SuasPcIqwPhQztOMe5t7AeS/u5OyjN0wpbk7ag5lXJA4edjW06ks+kdo1mTAZCP8906FSlYk5VtrAjqkrI61dDVn1gY1SYNMUNWnhdeFPM8BsMwTPMRrdvZHRFk9oaj9/fewB+u5eGuuLkkM1TbK4oXThIreu6ESSPJT/JqVI6Ql0ssec6IH+CbfgtG//+HSEUHc1hspjLdUb6UcJNZTM5M0gqgz+8CelMEZORIkbB85Qoe1Btimop7N/hr8T9+wSxenj1uUxYgfls7ycEjxc38pVaSjlxBTFATei+QPgdNr5JvvwGmVjoRAX6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9755c00-5939-44b6-441a-08dbfd7a7d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 14:31:13.2239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjNixuI7GXv8sj/e/Imd2453MXr8KaALiWbOrT5wyUsjo3zN1webvOR1B2J9ojJXuYZf+y6KFRNTbBZAWMYAoVhbZ5xuN2hfk6uzvKaIhLU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8062

T24gMTQuMTIuMjMgMTc6MTQsIE1hdHRoZXcgV2lsY294IChPcmFjbGUpIHdyb3RlOg0KPiBAQCAt
MTIxNywyMSArMTIxNywyMSBAQCBzdGF0aWMgaW50IGRlZnJhZ19vbmVfcmFuZ2Uoc3RydWN0IGJ0
cmZzX2lub2RlICppbm9kZSwgdTY0IHN0YXJ0LCB1MzIgbGVuLA0KPiAgIAlBU1NFUlQobnJfcGFn
ZXMgPD0gQ0xVU1RFUl9TSVpFIC8gUEFHRV9TSVpFKTsNCj4gICAJQVNTRVJUKElTX0FMSUdORUQo
c3RhcnQsIHNlY3RvcnNpemUpICYmIElTX0FMSUdORUQobGVuLCBzZWN0b3JzaXplKSk7DQo+ICAg
DQo+IC0JcGFnZXMgPSBrY2FsbG9jKG5yX3BhZ2VzLCBzaXplb2Yoc3RydWN0IHBhZ2UgKiksIEdG
UF9OT0ZTKTsNCj4gLQlpZiAoIXBhZ2VzKQ0KPiArCWZvbGlvcyA9IGtjYWxsb2MobnJfcGFnZXMs
IHNpemVvZihzdHJ1Y3QgZm9saW8gKiksIEdGUF9OT0ZTKTsNCj4gKwlpZiAoIWZvbGlvcykNCj4g
ICAJCXJldHVybiAtRU5PTUVNOw0KDQpTdHVwaWQgcXVlc3Rpb24sIHdoeSBkaWQgeW91IGtlZXAg
bnJfcGFnZXMgYW5kIG5vdCB0dXJuIGl0IGludG8gbnJfZm9saW9zPw0KDQoNCj4gICANCj4gICAJ
LyogUHJlcGFyZSBhbGwgcGFnZXMgKi8NCg0KCS8qIFByZXBhcmUgYWxsIHRoZSBmb2xpb3MgKi8g
Pz8NCg0KPiAgIAlmb3IgKGkgPSAwOyBpIDwgbnJfcGFnZXM7IGkrKykgew0KPiAtCQlwYWdlc1tp
XSA9IGRlZnJhZ19wcmVwYXJlX29uZV9wYWdlKGlub2RlLCBzdGFydF9pbmRleCArIGkpOw0KPiAt
CQlpZiAoSVNfRVJSKHBhZ2VzW2ldKSkgew0KPiAtCQkJcmV0ID0gUFRSX0VSUihwYWdlc1tpXSk7
DQo+IC0JCQlwYWdlc1tpXSA9IE5VTEw7DQo+IC0JCQlnb3RvIGZyZWVfcGFnZXM7DQo+ICsJCWZv
bGlvc1tpXSA9IGRlZnJhZ19wcmVwYXJlX29uZV9mb2xpbyhpbm9kZSwgc3RhcnRfaW5kZXggKyBp
KTsNCj4gKwkJaWYgKElTX0VSUihmb2xpb3NbaV0pKSB7DQo+ICsJCQlyZXQgPSBQVFJfRVJSKGZv
bGlvc1tpXSk7DQo+ICsJCQlucl9wYWdlcyA9IGk7DQo+ICsJCQlnb3RvIGZyZWVfZm9saW9zOw0K
Pg0K

