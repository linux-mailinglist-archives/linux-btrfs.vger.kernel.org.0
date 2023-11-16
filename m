Return-Path: <linux-btrfs+bounces-150-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2117EDD72
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 10:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5EC1C209A4
	for <lists+linux-btrfs@lfdr.de>; Thu, 16 Nov 2023 09:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D80F14F81;
	Thu, 16 Nov 2023 09:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="a+YIJ/87";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k1pnQqF/"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F29A4
	for <linux-btrfs@vger.kernel.org>; Thu, 16 Nov 2023 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700126160; x=1731662160;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=DIMn11DtF693ASveVijllPnZ6bW4U1rGQbJeu0NqXo8=;
  b=a+YIJ/87CRYUQ2KZdMiI+5nSHwrCa7p/h58kmjrvOuZ4jA0KgctUf7zP
   3lOk+hK8dM6glSS21RdPxmtSaI45MdKiv6W7m0cacIS9bo0REvvovWQRr
   WpD/HtQWr0YzkXe28jmF5SDR6oQlZiOGu3gE0aZhvLcng6UH4Gb2hmEXF
   xHrG6SVdFGwLhn8VW1iUMNCtj6Oy55dYDURNO7P9MAK+YwWJT42OF4eSn
   4KcVqj53YDMqbBg5Ouqq3uzqHpD66t9KqHgf5WQcdrou8V5Rgx8zZcoBX
   fXK+IT2zbvIHqarBdY1gG5tQmi0liuYOLi43IGltuYaLfgecCjndxZMpi
   g==;
X-CSE-ConnectionGUID: /73JQ4XYTLS8yizp0IArig==
X-CSE-MsgGUID: LhBwOqyjRqKfEAkCs8awfQ==
X-IronPort-AV: E=Sophos;i="6.03,307,1694707200"; 
   d="scan'208";a="2305147"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2023 17:15:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X4Rghs3KtFBBCV7bdYpEHj9/8mBDLURBW0kR/lGAz8O4wTZVSOR0rRbkhwdnorn+84jpXy2K4Is3x3lMqTytikCMC/Y2ZpjHjs+l4IzjP/f26dkrOTEO1YJebrRo+fYrx6Pj9RRwvjNy9e2cKoS94ym8N3hhPfFoCNDGb4mYY6+P2ZvoMhxoj8AKbWuKHNVbYCLsGjMrQHc28UdC7eWdNcR2zgzVCYXlbPcdoATDufgqnDq7zs+vwg5cfrB/VNqElOVVqJxvFy5mNOPDQ/nJRELBd1kzfT5a79mhv6Da1Xd49xA/4pfRDTw/BUoo0VfadLiUWJgeu0mKhF+VJew9kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIMn11DtF693ASveVijllPnZ6bW4U1rGQbJeu0NqXo8=;
 b=XMXPmYimpuSMzuIH9aEZdG9UYaXUKr3OLtFQF5whAuOYIjdfwKq3bBNFKaBdZNYunT0lHFh9DoDmLkyDTORFpZYOGAwDdrXjz2QFg4MG3QYdUgS7zLZXVCwyEI4UNxgW0TJZ4pxOJjcnH8IAThrED4RU6UxLXJ9rSPRZp9B2xUBdPtKvZ9laPzSO+9hMvj1+qQzCF8q9kxDT1wraXjLX+IL4qsbcXl+NeuC1ic8Kb5f4fNUrv4EfektDF6auA4WMvsPIg11p8uNTUxGPNUjNT+E3FJ7CuJwxAeEB04DJ2LjZ+H55zQOf7yx1ly27pzFx+U5XrDz0wlHf6YZ5R2a7pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIMn11DtF693ASveVijllPnZ6bW4U1rGQbJeu0NqXo8=;
 b=k1pnQqF/LDC1tqhUjAXgsaoGAMqW7+xO0JtNVgyJwuLvxy+yRx5XF8aB0oDYLcOuxUx5SFvAu7sxnMHF06E6x+NZW7CxYvguyX2WNcbvw0iELvxR4LhbO1Yqe/kfdP4J2hNo41jBapy+NPvzcpS85sI8iFT5Mi4tZ0bSlHjUbbI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN4PR04MB8318.namprd04.prod.outlook.com (2603:10b6:806:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 09:15:57 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ec9e:a2db:eb04:2cf9]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ec9e:a2db:eb04:2cf9%4]) with mapi id 15.20.7002.018; Thu, 16 Nov 2023
 09:15:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: David Sterba <dsterba@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: use page alloc/free wrapeprs for compression
 pages
Thread-Topic: [PATCH 1/2] btrfs: use page alloc/free wrapeprs for compression
 pages
Thread-Index: AQHaF+YljlNKm0rVyU6bjIncqfnbDbB8qzYA
Date: Thu, 16 Nov 2023 09:15:57 +0000
Message-ID: <724779b3-c542-4f9f-842c-cebc8a445843@wdc.com>
References: <cover.1700067287.git.dsterba@suse.com>
 <9f861f8b25f74779dacf17c862b947efd59634a9.1700067287.git.dsterba@suse.com>
In-Reply-To:
 <9f861f8b25f74779dacf17c862b947efd59634a9.1700067287.git.dsterba@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN4PR04MB8318:EE_
x-ms-office365-filtering-correlation-id: 440cf973-3c0e-4610-64f8-08dbe684a473
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 038PVEH0gvo1a2a8ZAVq4Aam+CVx+bnWpffaj+cQ5QJWjFAUzuhWo2Lg1hy22ljPpRpoDMI4DVeWuFg3deNHI7AEyW6NIlpjNyG9mR/39o9zkzIK1h1rFVOm8u2YbLVs9CKPqf0XDnBtN9VOQ3CYRL3NUUkAEMcp8XoB7yp2NxOecpWUmxYENK6RwkHkouzDpV5Y9vvwY6ik17cXxvSYXHLG90CK6lypr0iX0CpAaBavtQmPLQAmqeHWtuIPCuLOz0xCOCMMkQS4bN39kVdTfwn9uOBvn7/hvFmgqqMSZhNG0O+jIRLjfduFMP/pzcMLEMUdFM6TpAPHgrYF6xYL8PF3w9qt2AMKeesC+vtOKHWH9J4K6JOC1Ds6elkAgHeovc60EkwWc862JWncAvMJkyUahTUFRdcoTSy89Ipi89CHSuqqWnmF8X4kljzMtYiuSkPJQyt0yaJNfcZThbKPI/naHAvxR13/se+OpJIenXfirIBtHJT+ZBuZCINbUfmeIWKB9IfOyCu2dJr2oqn6MfN/eJsXubl5DwSzF5sPHz3IGvcvUd/TMBiIsbYhfuVQiJDy3CR7xnZChyVpfxnI2fw664BoP22zB31YtJkV33UzAgTlEThe1Y39+EPi+vgD2yh3FHd0aKkz1uwWRMRrYQZV74L+6+B0/hZCkcOwA/HI1pq6sLmhVUtNf84iq5NW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(366004)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(36756003)(38070700009)(2906002)(5660300002)(41300700001)(38100700002)(122000001)(53546011)(6506007)(316002)(31696002)(71200400001)(86362001)(558084003)(8936002)(8676002)(478600001)(6486002)(2616005)(66476007)(110136005)(6512007)(66446008)(82960400001)(66556008)(66946007)(31686004)(91956017)(64756008)(76116006)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmcwaCtPYmZDVGVrNys1cURwcUs2Sy9tYUF5UzM0Q0pMeUNHWjBHNnljb1po?=
 =?utf-8?B?cy90QUpWTFA4TlpaZ2JaYUZpTUE5ZXA2STd3MFBxOFB4WUJGMmlUTTJucUc0?=
 =?utf-8?B?TE5KNnU0bFpYaEszZTZSbFFkZHhjUm44WGQ3UlBvRUJuSnFvOGQ5THdoZ3lH?=
 =?utf-8?B?SFErSmhqWEowRDhMWi9SOXhUQkovaThQL2dyeGMzbU5VeTN5QmZJbFZhQWtx?=
 =?utf-8?B?QXllWjUyQ0oyYUJJbWNjWFhWc3ltVDl6UzFjRmtqa3ozQ1hXUHRjTVZ2Rk1N?=
 =?utf-8?B?aDYyWlpwbDFQZTFBcGFmL2FUMXZUUHAvZkYvZ2JiaU8xNFM5cWg3T0NSeFJw?=
 =?utf-8?B?SWJCekxFQ3N0K09qU291b3Evc284czRjNUZDYzQxYVoyYVdiMyt5N3Y0ejNG?=
 =?utf-8?B?T1lMUFZzN1c5ZzAwQTV0ZGJySFRuOFNBWkZKZ1puWGlxci9nSHo3ZnpTYW52?=
 =?utf-8?B?UVVITzExWUhhNWpGdHo3OTRSc3FmWnJlTUpSVjNSNlZWdFJFNmFqTjcvVHFJ?=
 =?utf-8?B?REt0Q0IzTTJFNC9QcWU1WXUyTXJVWXRyeU11ZU1UanV3QXlkODdJNHdIVnEy?=
 =?utf-8?B?SmNZVjRaeXQ2Ty9FcnY5Mk94cmwrYXJ6dENrcERmYVZQQWhId29hb0liaFVl?=
 =?utf-8?B?SjZTZXR6VlQ1N0xTaGFMQVN4RDR2b04rQ0wybjJoa1gxTjViRDdlam1PZFhS?=
 =?utf-8?B?bE0rN1cvMllIY3RFTGdpc01zRytORjBkWXBxQmRJUDZ2L05uY1lZUjVpeHV6?=
 =?utf-8?B?TDBwY3ZZZGdsRHdiNGZ4TGNWYWE2eDJBU3VVeTBaeXMyM3ZHNm1hMnJDY2Zi?=
 =?utf-8?B?YVBqcS8rNXplNzA5K3hnTWI4V1RCclA0YXdtQnFEUlVOcnk2aTVWdjM0UHUz?=
 =?utf-8?B?dVljdkdJWnQrSEhkdmRUVU44S2RaOVQ2TURHYXZkQ2EyZGErS2R5RlJHNkdU?=
 =?utf-8?B?V3RmRlBBeVJSMXJqYXp2djNXMEJzOXR6dEYyUWxyQVhtdzdoK293YWpNYVNx?=
 =?utf-8?B?bnI0cnJJYXlsbGU0YW9USjhEUnFSbVh6VkpPeUZSNEdDZHU3YjBGTHp5WTVk?=
 =?utf-8?B?ZWFUcnZadU52am1SNWJpVHIzTWhuZUhtQWNRSlAxQmdHdUcxV2ZvU0NkRzZv?=
 =?utf-8?B?SXgvb28wYkR4TitKR2ZzejF3ZHhLeGdrK2JWcVM1bm9sYThWbGU4QmEzZS9J?=
 =?utf-8?B?ZytOWWVHeWZYQ0VBOXMrMnM2VXhQTGdRY2dOdkIwOFZJUVIvUWJRaHZqMDFk?=
 =?utf-8?B?cEpENjJEV2ZhK0R1d0hMYmU5bkJqWU9qc2laS1ZWbWgxT1pCTmRkTUVLd0ZO?=
 =?utf-8?B?TFY3RzZjVDA2M3RhaG41OXBCdHlzbURQNlpjbSt0MWlOblJFOGduMWhvQjlH?=
 =?utf-8?B?V0ZYdThaU215UVhEK3ZPQktaS0ZFbVBtYzVCS2VZWTNWUjdGbDhRK3VZMHAv?=
 =?utf-8?B?VjVXdW8xVzNSRHNiTWVsRkthUU5aeVZnTVdTUU5nRHZ3dWtucWlFUm1kMEsv?=
 =?utf-8?B?dm9XQnJEMytmaXMwR1VNUGhUNlAwamtKbHJ6dkhydlRLNk9yaUNmWEw3TGdR?=
 =?utf-8?B?a2FkN2c2b0dXM0NrM2hCS2c3ak5NZkRmQThpOUJ0NERXanZWK0RHZkFmZ2xP?=
 =?utf-8?B?bHZxTmViUER4YUkrRGttT3ZqKzl1allOQWRJbFZSQi9qZC9ueEZReHF1UGxl?=
 =?utf-8?B?YUhvU3dLUGpqcy9oaG0rNzBydmkrNlRqMFpMSitKaWJhRnRKaG9KVjRzRGhP?=
 =?utf-8?B?alRLNEFPS2R5bDByNzdDTG5PbWpHaCtPVi9lVEpIcUJmei9uTTZaanpObnRr?=
 =?utf-8?B?NW5aWG5taDJEK2hjdmVDak5NNm5IRVRadFRYcW9OUjRFVExsYVJkaUg1N3JY?=
 =?utf-8?B?cEZqNEhrWEpwRnV2V3ovenIrQ01sM0xxWmF3c0Qyd2tmeWtEOFJtejBIZ3ho?=
 =?utf-8?B?YngvNXRQM2lNQXZTOGc1RmQyQVNKVk1RSjJvdWRXaDRnUmlsRng1MWhpMHhJ?=
 =?utf-8?B?bFNsamZpNG1GMmtWOEZwcGRpVVZzT0x3Snhlc09CZHhJdGMzemVoY3pDTlRO?=
 =?utf-8?B?a1FscnJldks1VjVpOFFEK1ptTVRmSXRwcFFTV3QzR0ozYWJxQTJ1SUJsUGxN?=
 =?utf-8?B?YXArQUk4QU03WDZhUTcxVVRwamJsdnNLZ3Y2a0xxYnk3MkhiRkFyaGRmQWFt?=
 =?utf-8?B?K1VVTW5Vam9meDhva3gwQWxta1N4Q1NRNXkvRDBpb3hkdldYeWE5dS9zTnNX?=
 =?utf-8?B?Rkx6c0FkM2dFTHdFZFVBd1cwMTJ3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <75A46331816E4F4B9AAC24A16D6E0658@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	InD5rA4AimRGxxbJeBtZcB+KWF5yjTRov7s7Yi4oRTWkUnOg2LcoA/SmGiSgBvEg4JERsc2c8XVqrGAMQJPVIcdSd2/QoYxTLPzneVHU0EZPIH/oisVK6oy9wKDFOPbwN2hmiNxMGEMbbPSFTy21KDAACyKKBj6xjwpba/OxIgh27k8DFODzyNu3F9wSwUbzoiimFNr7Fkjk0UFeIEbEQ8849bYWF2MDYE0KWtAm+1S+OPqXKFnJgTOVKa+abA6wXia+6Oy2dh8E9pwKTWa6+k2j9cNShDtT6z25rZdAZXzrjirl1Z4GsQeDPO/ABMhA0G+ycKqhH/3S9TLDzzc6KJqepShh0Vq+alUyHZvQK+/CZGPT9LmI0JDPZuhgYN0bfLpfCfBP26rUDPwYTtkG4H5sIH5Z3FlH5I4htnCJ0V+SiJfVJo7g1QIOz7k5Mmceh/1Qa1mK2+GBRA8czzvkFjKHdZLe5+DeLqU+pGrZTxfSsIi609EeousUUTnhChAVX+aeNtmjtBAdcnSNvmNaUDC5cd3X2X3B8iMfhqWAZD3dpvoNlOE2SzgCqD9ozNv7kWjcPuiIaCTYBrWOP5FCkhA4xipmBMuHQ6tihwd+yyJ4BjUtTCIzUMbPMK7LniHlbh3o/aqEzZh3DYo8XAclFs7G8HWmebC7MdzgEpk66cYfA2YCna8aqvn5kEJ28dolshBFAItIW5b+m2xW70KZ/OtlWvN3jxiHg2hRzw5IqryU2Kr66TwpACMxzHeB38+Er9i32zwtDvDSmSQY7mghbaluGRb9CBNdIz5aLmChjirjbWTqkC2eXTDRNydkNAGu
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 440cf973-3c0e-4610-64f8-08dbe684a473
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 09:15:57.1637
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KPLb6knKk2m607dJ2ac+Y5+VbyqlEiTuosS3IGxlUBBj8FRP+L3U/wBHn2gyzzXGo1TKPOYsfsJQ1gHOhw/mkPBLoxK3/Y14kudR5WjqJD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8318

T24gMTUuMTEuMjMgMTg6MDYsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gK3ZvaWQgYnRyZnNfZnJl
ZV9jb21wcl9wYWdlKHN0cnVjdCBwYWdlICpwYWdlKQ0KPiArew0KPiArCUFTU0VSVChwYWdlX3Jl
Zl9jb3VudChwYWdlKSA9PSAxKTsNCj4gKwlwdXRfcGFnZShwYWdlKTsNCg0KT3V0IG9mIGN1cmlv
c2l0eSwgd2h5IHRoZSBBU1NFUlQoKT8NCg0K

