Return-Path: <linux-btrfs+bounces-1448-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8468E82D8BC
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 13:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E03028203C
	for <lists+linux-btrfs@lfdr.de>; Mon, 15 Jan 2024 12:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188292C69D;
	Mon, 15 Jan 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Gp7nPGfH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TPZb04ox"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BB72C696
	for <linux-btrfs@vger.kernel.org>; Mon, 15 Jan 2024 12:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1705320584; x=1736856584;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ca9DiSP+U1a81jOoziZ+UmtbiQRUeHHi2kTXstxPHFo=;
  b=Gp7nPGfHzbCUJk44bDeUYJ2v7K5z8A/b0sA+hC0JM6MYriJBqxT+m9LL
   025B7ASNR6dFnpZ02SYLPdHPbtnRUoNwmFljTKnyjZG23frwAa/RIatbP
   oWrLTtnjOW+OEKyqF1zieZDIw0rKgmrCpfF9/n0bVm+YPlge2Cv0cB+qu
   B1QA1qf0lgReGCu+3QywYiQcVW/bJX5cCTczxGdOJ6hFXxUUN2inYSgyj
   1d3AZ0vkWcE5ydDxFqCGMUBslZI9HBPSTSV6Uto/1PSyFHr+kJqp6LNQ1
   vGhGaZdhhKcGRmFP/CRikaWVhIxnH0UlIJzRods8wIkQOhppRFy6rw+7o
   A==;
X-CSE-ConnectionGUID: 69QXxUhPS1eHSOOPt0Z88g==
X-CSE-MsgGUID: zuyfZT4CTTqrE+U0HO+MvA==
X-IronPort-AV: E=Sophos;i="6.04,196,1695657600"; 
   d="scan'208";a="7129544"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2024 20:09:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePtv4XN8KURoqweVq1jpQo7YVMybmFHxu1HwUhU4aW/1d1z1V5gAOEyvZY7s/D8krWZrbAxMUNNFUlCpZ8HXVR1GlC0OQLpXds0zS2mz6zFiWvPl0Z8meZhHyr0Fa1L1u96jk6rf9p/TAA7NWjtTiv6+1tkEGYMaz7Pw8JDsF6kPL4nvZKSOTkY9i6bOMI0BERtjKnFYwrbtkstes5AMG0hiaYoJJ1H0Ck/Svsm8JEusZOs+kTlODaUmw3QdbBhYfCvzQxjqCeP9lQt4h4TsyHwpec+/nGqHt7v/fB85YJDjz+AMyyd2m+bYLFUf2B/lbtBcUgRJMTM2QO154xlepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ca9DiSP+U1a81jOoziZ+UmtbiQRUeHHi2kTXstxPHFo=;
 b=UOYyEFXEXeavHksVymyx5Av7oUqhc0gAELcbsQywuwn4e75xmSK+EmrgMj9a3JOw0WrlLAxwbWsJDkUfk6/hxMdpiiA33FBaRe8ZQxm1bohsnhDystlndq630y0l0SQS2nJGcpZAzwaMj8GwwRP6/4+1vse6Tlf1fK2HcIPo8ib7ZjNqTf9ov1nag8JAnWIbdIgXwJ/x4359jv+Iy2MVVqfneGBFMUnP4eBrV2mCrcuz9LAkw482R4T6swAhfzhWjnbNRgPTfgtjdCexiw69FWEKJO/LpAX86BARLzUd8aCwK2pn6Ids7ceKARKsitTWBF9ZPTbfC5+vhveDOlMGDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ca9DiSP+U1a81jOoziZ+UmtbiQRUeHHi2kTXstxPHFo=;
 b=TPZb04oxMPBphxWKOxAJy8ZFg+OlHIdW2Lb+j1ELP6sAHGl+Sx6d3gZMJMJK4MbxFeQcDyE2BqdvQQRZZmRahAvy79UcRc0fiADwmnc1sYBPFPyvwrwAzZjp/YC2W4WGbTp4sg5SFqQuAW23Aj0grIbaYsGayFM3/CrSG4L5QSc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY1PR04MB8727.namprd04.prod.outlook.com (2603:10b6:a03:52e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Mon, 15 Jan
 2024 12:09:36 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::317:8642:7264:95df%4]) with mapi id 15.20.7181.020; Mon, 15 Jan 2024
 12:09:36 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Qu Wenruo <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: Rongrong <i@rong.moe>
Subject: Re: [PATCH] btrfs: scrub: avoid use-after-free when chunk end is not
 64K aligned
Thread-Topic: [PATCH] btrfs: scrub: avoid use-after-free when chunk end is not
 64K aligned
Thread-Index: AQHaR5xfWV1K+XSwSEKyVR0cti3yabDayC4A
Date: Mon, 15 Jan 2024 12:09:35 +0000
Message-ID: <12744dd0-a56e-487e-b27d-4ad66498d7e5@wdc.com>
References:
 <8531c41848973ac60ca4e23e2c7a2a47c4b94881.1705313879.git.wqu@suse.com>
In-Reply-To:
 <8531c41848973ac60ca4e23e2c7a2a47c4b94881.1705313879.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY1PR04MB8727:EE_
x-ms-office365-filtering-correlation-id: 509a2a6b-5ec7-4a58-2cd6-08dc15c2d747
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fGMESCe9wyhXu3WL4LOo2qEW17TuVl+PEUX9bjf0FEZOpsn5S8bIUlmIcRCKHNphMyuIvYXpJVF5ThJiq+GRtMcoboACayC7xtC9B8kzZnikKCtf95QKWHkdGTppqlaNx7Ek84qduq5K461O4taGtL3gADP6yunwBO3GZ6YI0ibLmpo/kORwQXa58tlNMvM3+vhIKvLIUfe7W+Wksg3GyTQadxVnuLu8epYH75DJyO6js8ovfugcBhH0IH/lMCIRcR3sjsN1ZeWmw9Pa8QrG3sATBqK0WmwZvnNrjtFWEceOheiB+0zWzOwckkRDxWW6hEOrtiSTmP5BUILGSmpztM6xWpFzN6Ebf07rHuZ8DHwhWtmTNbLk+IPuNbFmG/BG8J91KdM5QruLCfDbTmnBAF55gEgbwnT6GVumvEf2dd2endjDv7r7cCKzxDk8ulU1rzSYIr9of7uUF+MCj7Sm/eo3ooxzrhPk+oMpLn8/JizzUjl8faJF6qFaUeAAzvrHfZzMmymCpkWGu+DxEKQvQWIoOfks3gH+0I/NgGIpp3/NWrQqpj7hyzK83vpFOi2Vrz3y5+V6NVtdZya7dxUWJFcZ5xeRskstakbvCG9FKQzBxMqneXfxzEIK74dTcOAlkSTXzJ9Y+lKKHT39WL1eA8+My7k7oCA9q84vyZT52MkdKhFOcqA9yxIzmBHv1hFS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(5660300002)(2906002)(82960400001)(86362001)(31696002)(122000001)(38100700002)(6512007)(6486002)(83380400001)(6506007)(36756003)(2616005)(53546011)(26005)(38070700009)(478600001)(71200400001)(66556008)(8936002)(316002)(8676002)(64756008)(66446008)(4326008)(76116006)(66946007)(91956017)(41300700001)(66476007)(110136005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2E0bkFqcFAyVWNYVERTMEtvODF3eWZ6TE95Ykx2dGZTcElleithd1BhUjNJ?=
 =?utf-8?B?OFRYbmtuRUw5QTlDQVp4cTdTeTFEaVE2Q1NtV3JIU0VVWm9IOVhvVkVaWlRq?=
 =?utf-8?B?bE43TmF5ZHJzTFBBZkZmalF4VjdmM2Ztd2k3VjQ5bVZsK2FxUVg1SGNaN1Yx?=
 =?utf-8?B?eVNhU1hjQ21icTA1SUM2bGJ2Vzl2eis5b3RHOW1SRnIvOFNKaHlSc2tveThl?=
 =?utf-8?B?VytVMkcydkR3QitweDFONXlDMVRVNnIxUVBnWWdNYTdHV1NES2x3NkI2Vmx4?=
 =?utf-8?B?V01DMFlKMzM3aXVvU2ZWQ3pFZjRDWkNrQVZXMU5QeEZqQnBQb0Q3MEVob3ZB?=
 =?utf-8?B?UUVpVWVvbUxnSHUyRU56QU9MNS8wUHhEY2R6WEwzZ21nUnNYOENWd3R6aGVU?=
 =?utf-8?B?MytUbHFwYjU2R1plQlg5Z2RSak51cGFOVGFZdmpPbFRhNTRMaXoxMXN0OGRG?=
 =?utf-8?B?RHRmRDNlM3hIUkRTWGlqajd2cXR6T0liVVlUdW1pS1RZOUhxdUxzVU9JM245?=
 =?utf-8?B?TEZJaFNYRWUxUlM4NUlzWVBaaWRNMHhWTCtrQ3FibE1nVW8wNEpKNS9QUEk5?=
 =?utf-8?B?VFo2MWN0djdFMjUrV1gvWHhYU2tQcEs3ZFoxSU00U2l2S0R6Y3VPenhOTFRR?=
 =?utf-8?B?WFVwcVo2ZDBLM2luUGJMR1ZqT2E4UEIxK1QwdnphLzMyN1FCZXBJTWw1eWpR?=
 =?utf-8?B?TDRhWGtHUFc2cFB5S2oyR0NiU0pKaFVpOUNvT095cXhYM0hqai8vS3BoUko0?=
 =?utf-8?B?VHkrOUJmTE51U2tqOHdxaGJtQzBDeFM3V3JQWlZqZFd2RkIxd1FkWDQvVk4r?=
 =?utf-8?B?L0loYzBiQ01tRzRDMHVIVTZacDhQb3RsVVlpaUpaL296dk9ISWEyQXFRdXl3?=
 =?utf-8?B?a0RuSnU1NVNCY3JXZFcyc2E4K0c0TDZTemxSUGcyZERYOVA3WktzSE5HaWsz?=
 =?utf-8?B?RDEwRm5YRkM5aHhaeWVSTlNWUzV3VXJSR2ljK09wanViYUlBNDJnMUxwekdm?=
 =?utf-8?B?azBUVlZFZlhHTFNoNjkvQ1BIYmRPUlpUcVVQR0gzM3h3SjhrSTgxMWRjdXV2?=
 =?utf-8?B?SHNqQ0pBT2JRbGZKZXFVd1hwY290YXBUMUMvcnUwdmRoLzRSVWFRZWRMVk5B?=
 =?utf-8?B?TjRYa29GZllxR1MzMjFtbWdnb24xYk9UeEdFclJKOGdhOEJOUmR2emJudjFy?=
 =?utf-8?B?T0xVelE3dTJDaU1wdVNScnhRc1Z5T1AwM1RoTU9UWklCT3hEV01zdnNNUWJP?=
 =?utf-8?B?NmQ1WlJKY1MzdExINENDTS8xaWNzVnpVVUNNRUl2eGZscjhqc09xUnNUckRQ?=
 =?utf-8?B?eU9yRm1JNW01TnRFTTdjUEp3WVVma2lPbHB0S2FlNUNZYmtVU05xVFlqd2Vy?=
 =?utf-8?B?Qk1CY0tURkR2TDVYN0Y0ano2YW42Tm5Pb0RubmpBalhFRWIrbGw5VUMwSDJQ?=
 =?utf-8?B?U3NPRjU0Rjc3SkQwL0FxWUVJcHU1Mk93MytrOVZjTUFuek82NVZOb2ltQzhN?=
 =?utf-8?B?WWRaQU1wamhyU2RVMERkTjZwQ2tGTHRUa1JENzJLeDZOMjdLQ01tK1FuK3ZU?=
 =?utf-8?B?N2xUM3EydWprdGVZMlZKcEJkNE00engxbW0reHpqMmhHZXh0RjNuYjJIWG1n?=
 =?utf-8?B?RzM1Qk9NQk9mcUMwYkg1NjhsQitPU21UWjY3cnFQV3RlVmJTOERzRk5DYitR?=
 =?utf-8?B?dkdXOWJ0OFU1S1ZRVG5uUkRBRU5IcU4rNFJEd2tXQXQwRmJ0QzVKVDhNc25D?=
 =?utf-8?B?dUhKcjRjZ1U1R3JpY2pjaDZMT01qSlM4TGl3T1lZSGJDUXFhU1FLUGF0VC9N?=
 =?utf-8?B?WW45VHNHV0w4dFBxVHpyWXh1UG9RN3Z1NXNURXI2bDVwbHFsWkVqQlpCN2Q2?=
 =?utf-8?B?c1dRejBNNzczYUJRRi91Vm43V2F1cTBJbVlFaVdVOTU0R2hUQ3pYUks1cUVT?=
 =?utf-8?B?ZzhFeEZub29DQ1RnTFgzNUVCRUxEem02d3A2dVJQVXpnbW94Q2M4QnNFWExx?=
 =?utf-8?B?S2xya1JrNEVKbDNMaW5CVDBrS2lGK2htZWZBdytPVDhlcVp4T3piVngwQ3pw?=
 =?utf-8?B?NVp4Zi9SK2Y0aGJad0o3RzluNHhyN1Foek5VU1VxVGl4QU1qa0xNYm56MHI4?=
 =?utf-8?B?SkpQOG4xdHpvVm51ZllBc2wvLzVFQ3IxTGJBZ3dJOSs2ZE5zTDRFTnVkVHcx?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3373421E49EB94691DFA506AD1B6EE6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	btF9kp374L7glyYeM9Y7LCnZDeKeipZO7PdKwcyRZLynGanQsPZYbrWsSoi06e6+4taBSkoWSk/qtpqXP4Frc4FNIRzR906QRK4ZzJhW+14PmNZFZIOXloYuBjRm9/8yA7NhG9WZkp41dTSMzN+hUp2DslnFXsEFbHYu7RbzZuN3OZOlO30AzeOlP/nNpB61OFv+YZipw/uO+Bie1yGY8JxVshQD0cTKfMW2x5aYwWwGBSsiSw9uloGR1zGC8bg59uDJWuf1/mQdtFANgknzKZoycoLPThyU4HGjP6GuzSnKvj8tQBs1Wrybc0+tyh0spoHxwUtTl646x/eART6Tzjdyd6IieS7kVnORrgQpPhZk5CoPtkwsidUTO+Mspv4MgP4uKXjMdpRgjg+bD55SomQjeibr7jlfOUezNUQNzeMZ+sLvbzADzusot/tOLsCshZznPtI2s/Aymn1lXjTn3kAMT/04D0cjVRhJEhF9bqJCiOQHThBI+MnOSVDs6L1TfW7Z/uZJs1k+1nyLmjgZoe20fierNjdEGDg0oy93PSxiNzXifqgWwS6BrLcX7kNOHL0O4Sl63wQWr9fmdOFlGucYP1WA+8QfGGiIZc/BBjL9z4RPg43WwQEeAU2T2kj6
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 509a2a6b-5ec7-4a58-2cd6-08dc15c2d747
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 12:09:35.9309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XHS8lesYFJTwUMNRKJBKM5uOqhtB6yG4SUrINyNHORFt3Hh7imKgU0kJA+mzJScXfyVIBJpzxUOthkkPM5dvKH37b4p+oiigrQXBQgszTEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8727

T24gMTUuMDEuMjQgMTE6MTksIFF1IFdlbnJ1byB3cm90ZToNCj4gVGhpcyBtZWFucyBidHJmc19z
dWJtaXRfYmlvKCkgd291bGQgc3BsaXQgdGhlIGJpbywgYW5kIHRyaWdnZXIgZW5kaW8NCj4gZnVu
Y3Rpb24gZm9yIGJvdGggb2YgdGhlIHR3byBoYWx2ZXMuDQo+IA0KPiBIb3dldmVyIHNjcnViX3N1
Ym1pdF9pbml0aWFsX3JlYWQoKSB3b3VsZCBvbmx5IGV4cGVjdCB0aGUgZW5kaW8gZnVuY3Rpb24N
Cj4gdG8gYmUgY2FsbGVkIG9uY2UsIG5vdCBhbnkgbW9yZS4NCj4gVGhpcyBtZWFucyB0aGUgZmly
c3QgZW5kaW8gZnVuY3Rpb24gd291bGQgYWxyZWFkeSBmcmVlIHRoZSBiYmlvOjpiaW8sDQo+IGxl
YXZpbmcgdGhlIGJ2ZWMgZnJlZWQsIHRodXMgdGhlIDJuZCBlbmRpbyBjYWxsIHdvdWxkIGxlYWQg
dG8NCj4gdXNlLWFmdGVyLWZyZWUuDQoNClRoaXMgaXMgYSBwcm9ibGVtIEkgYWxzbyBlbmNvdW50
ZXJlZCB3aGVuIGRvaW5nIHRoZSBSU1QgY2FzZSBmb3Igc2N1Yi4NCg0KPiANCj4gW0ZJWF0NCj4g
LSBNYWtlIHN1cmUgc2NydWJfcmVhZF9lbmRpbygpIG9ubHkgdXBkYXRlcyBiaXRzIGluIGl0cyBy
YW5nZQ0KPiAgICBUaGlzIGlzIG5vdCBvbmx5IGZvciB0aGUgZml4LCBidXQgYWxzbyBmb3IgdGhl
IGV4aXN0aW5nIGNvZGUNCj4gICAgb2YgUlNUIHNjcnViLg0KPiAgICBTaW5jZSBSU1Qgc2NydWIg
Y2FuIG9ubHkgc3VibWl0IHBhcnQgb2YgdGhlIHN0cmlwZSwgd2UgY2FuIG5vIGxvbmdlcg0KPiAg
ICBhc3N1bWUgdGhlIGluaXRpYWwgcmVhZCBiYmlvIGlzIGFsd2F5cyB0aGUgZnVsbCA2NEsuDQoN
Ck91dGNoIGluZGVlZCB0aGF0IGZpeCBpcyBuZWVkZWQgZm9yIFJTVC4gVGhhbmtzIQ0KDQo+IC0g
TWFrZSBzdXJlIHNjcnViX3N1Ym1pdF9pbml0aWFsX3JlYWQoKSBvbmx5IHRvIHJlYWQgdGhlIGNo
dW5rIHJhbmdlDQo+ICAgIFRoaXMgaXMgZG9uZSBieSBjYWxjdWxhdGluZyB0aGUgcmVhbCBudW1i
ZXIgb2Ygc2VjdG9ycyB3ZSBuZWVkIHRvDQo+ICAgIHJlYWQsIGFuZCBhZGQgc2VjdG9yLWJ5LXNl
Y3RvciB0byB0aGUgYmlvLg0KDQpXaHkgY2FuJ3QgeW91IGRvIGl0IHRoZSBzYW1lIHdheSB0aGUg
UlNUIHZlcnNpb24gZG9lcyBpdCBieSBjaGVja2luZyB0aGUgDQpleHRlbnRfc2VjdG9yX2JpdG1h
cCBhbmQgdGhlbiBhZGQgc2VjdG9yLWJ5LXNlY3RvciBmcm9tIGl0Pw0KDQo+IC0gTWFrZSBzdXJl
IHNjcnViX3N1Ym1pdF9leHRlbnRfc2VjdG9yX3JlYWQoKSB3b24ndCByZWFkIGJleW9uZCBjaHVu
aw0KPiAgICBOb3JtYWxseSB0aGlzIGZ1bmN0aW9uIHdvbid0IHJlYWQgYmV5b25kIGNodW5rIGFz
IGl0IHdvdWxkIG9ubHkNCj4gICAgcmVhZCByYW5nZXMgY292ZXJlZCBieSBhbiBleHRlbnQuDQo+
ICAgIEJ1dCBpbiB0aGUgY2FzZSBvZiBjb3JydXB0ZWQgZXh0ZW50IHRyZWUsIHdoZXJlIGFuIGV4
dGVudCBjYW4gZXhpc3QNCj4gICAgYmV5b25kIGNodW5rIGJvdW5kYXJ5LCB3ZSBjYW4gc3RpbGwg
cmVhZCBiZXlvbmQgY2h1bmsuDQo+ICAgIEluIHRoaXMgY2FzZSwgYWRkIGV4dHJhIGNoZWNrcyB0
byBwcmV2ZW50IHN1Y2ggcmVhZCBiZXlvbmQgY2h1bmsuDQo+IA0KPiBUaGFua2Z1bGx5IHRoZSBv
dGhlciBzY3J1YiByZWFkIHBhdGggd29uJ3QgbmVlZCBleHRyYSBmaXhlczoNCj4gDQo+IC0gc2Ny
dWJfc3RyaXBlX3N1Ym1pdF9yZXBhaXJfcmVhZCgpDQo+ICAgIFdpdGggYWJvdmUgZml4ZXMsIHdl
IHdvbid0IHVwZGF0ZSBlcnJvciBiaXQgZm9yIHJhbmdlIGJleW9uZCBjaHVuaywNCj4gICAgdGh1
cyBzY3J1Yl9zdHJpcGVfc3VibWl0X3JlcGFpcl9yZWFkKCkgc2hvdWxkIG5ldmVyIHN1Ym1pdCBh
bnkgcmVhZA0KPiAgICBiZXlvbmQgdGhlIGNodW5rLg0KPiANCj4gUmVwb3J0ZWQtYnk6IFJvbmdy
b25nIDxpQHJvbmcubW9lPg0KPiBGaXhlczogZTAyZWU4OWJhYTY2ICgiYnRyZnM6IHNjcnViOiBz
d2l0Y2ggc2NydWJfc2ltcGxlX21pcnJvcigpIHRvIHNjcnViX3N0cmlwZSBpbmZyYXN0cnVjdHVy
ZSIpDQo+IFRlc3RlZC1ieTogUm9uZ3JvbmcgPGlAcm9uZy5tb2U+DQo+IFNpZ25lZC1vZmYtYnk6
IFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPg0KPiAtLS0NCj4gICBmcy9idHJmcy9zY3J1Yi5jIHwg
MzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMjggaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9m
cy9idHJmcy9zY3J1Yi5jIGIvZnMvYnRyZnMvc2NydWIuYw0KPiBpbmRleCBhMDE4MDdjYmQ0ZDQu
LjAxZGQxNDZmMDUwZCAxMDA2NDQNCj4gLS0tIGEvZnMvYnRyZnMvc2NydWIuYw0KPiArKysgYi9m
cy9idHJmcy9zY3J1Yi5jDQo+IEBAIC0xMDk4LDEyICsxMDk4LDIyIEBAIHN0YXRpYyB2b2lkIHNj
cnViX3N0cmlwZV9yZWFkX3JlcGFpcl93b3JrZXIoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0K
PiAgIHN0YXRpYyB2b2lkIHNjcnViX3JlYWRfZW5kaW8oc3RydWN0IGJ0cmZzX2JpbyAqYmJpbykN
Cj4gICB7DQo+ICAgCXN0cnVjdCBzY3J1Yl9zdHJpcGUgKnN0cmlwZSA9IGJiaW8tPnByaXZhdGU7
DQo+ICsJc3RydWN0IGJpb192ZWMgKmJ2ZWM7DQo+ICsJaW50IHNlY3Rvcl9uciA9IGNhbGNfc2Vj
dG9yX251bWJlcihzdHJpcGUsIGJpb19maXJzdF9idmVjX2FsbCgmYmJpby0+YmlvKSk7DQo+ICsJ
aW50IG51bV9zZWN0b3JzOw0KPiArCXUzMiBiaW9fc2l6ZSA9IDA7DQo+ICsJaW50IGk7DQo+ICsN
Cj4gKwlBU1NFUlQoc2VjdG9yX25yIDwgc3RyaXBlLT5ucl9zZWN0b3JzKTsNCj4gKwliaW9fZm9y
X2VhY2hfYnZlY19hbGwoYnZlYywgJmJiaW8tPmJpbywgaSkNCj4gKwkJYmlvX3NpemUgKz0gYnZl
Yy0+YnZfbGVuOw0KPiArCW51bV9zZWN0b3JzID0gYmlvX3NpemUgPj4gc3RyaXBlLT5iZy0+ZnNf
aW5mby0+c2VjdG9yc2l6ZV9iaXRzOw0KPiAgIA0KPiAgIAlpZiAoYmJpby0+YmlvLmJpX3N0YXR1
cykgew0KPiAtCQliaXRtYXBfc2V0KCZzdHJpcGUtPmlvX2Vycm9yX2JpdG1hcCwgMCwgc3RyaXBl
LT5ucl9zZWN0b3JzKTsNCj4gLQkJYml0bWFwX3NldCgmc3RyaXBlLT5lcnJvcl9iaXRtYXAsIDAs
IHN0cmlwZS0+bnJfc2VjdG9ycyk7DQo+ICsJCWJpdG1hcF9zZXQoJnN0cmlwZS0+aW9fZXJyb3Jf
Yml0bWFwLCBzZWN0b3JfbnIsIG51bV9zZWN0b3JzKTsNCj4gKwkJYml0bWFwX3NldCgmc3RyaXBl
LT5lcnJvcl9iaXRtYXAsIHNlY3Rvcl9uciwgbnVtX3NlY3RvcnMpOw0KPiAgIAl9IGVsc2Ugew0K
PiAtCQliaXRtYXBfY2xlYXIoJnN0cmlwZS0+aW9fZXJyb3JfYml0bWFwLCAwLCBzdHJpcGUtPm5y
X3NlY3RvcnMpOw0KPiArCQliaXRtYXBfY2xlYXIoJnN0cmlwZS0+aW9fZXJyb3JfYml0bWFwLCBz
ZWN0b3JfbnIsIG51bV9zZWN0b3JzKTsNCj4gICAJfQ0KPiAgIAliaW9fcHV0KCZiYmlvLT5iaW8p
Ow0KPiAgIAlpZiAoYXRvbWljX2RlY19hbmRfdGVzdCgmc3RyaXBlLT5wZW5kaW5nX2lvKSkgew0K
PiBAQCAtMTYzNiw2ICsxNjQ2LDkgQEAgc3RhdGljIHZvaWQgc2NydWJfc3VibWl0X2V4dGVudF9z
ZWN0b3JfcmVhZChzdHJ1Y3Qgc2NydWJfY3R4ICpzY3R4LA0KPiAgIHsNCj4gICAJc3RydWN0IGJ0
cmZzX2ZzX2luZm8gKmZzX2luZm8gPSBzdHJpcGUtPmJnLT5mc19pbmZvOw0KPiAgIAlzdHJ1Y3Qg
YnRyZnNfYmlvICpiYmlvID0gTlVMTDsNCj4gKwl1bnNpZ25lZCBpbnQgbnJfc2VjdG9ycyA9IG1p
bihCVFJGU19TVFJJUEVfTEVOLCBzdHJpcGUtPmJnLT5zdGFydCArDQo+ICsJCQkJICAgICAgc3Ry
aXBlLT5iZy0+bGVuZ3RoIC0gc3RyaXBlLT5sb2dpY2FsKSA+Pg0KPiArCQkJCSAgZnNfaW5mby0+
c2VjdG9yc2l6ZV9iaXRzOw0KPiAgIAl1NjQgc3RyaXBlX2xlbiA9IEJUUkZTX1NUUklQRV9MRU47
DQo+ICAgCWludCBtaXJyb3IgPSBzdHJpcGUtPm1pcnJvcl9udW07DQo+ICAgCWludCBpOw0KPiBA
QCAtMTY0Niw2ICsxNjU5LDkgQEAgc3RhdGljIHZvaWQgc2NydWJfc3VibWl0X2V4dGVudF9zZWN0
b3JfcmVhZChzdHJ1Y3Qgc2NydWJfY3R4ICpzY3R4LA0KPiAgIAkJc3RydWN0IHBhZ2UgKnBhZ2Ug
PSBzY3J1Yl9zdHJpcGVfZ2V0X3BhZ2Uoc3RyaXBlLCBpKTsNCj4gICAJCXVuc2lnbmVkIGludCBw
Z29mZiA9IHNjcnViX3N0cmlwZV9nZXRfcGFnZV9vZmZzZXQoc3RyaXBlLCBpKTsNCj4gICANCj4g
KwkJaWYgKGkgPj0gbnJfc2VjdG9ycykNCj4gKwkJCWJyZWFrOw0KPiArDQo+ICAgCQkvKiBUaGUg
Y3VycmVudCBzZWN0b3IgY2Fubm90IGJlIG1lcmdlZCwgc3VibWl0IHRoZSBiaW8uICovDQo+ICAg
CQlpZiAoYmJpbyAmJg0KPiAgIAkJICAgICgoaSA+IDAgJiYNCj4gQEAgLTE3MDEsNiArMTcxNyw5
IEBAIHN0YXRpYyB2b2lkIHNjcnViX3N1Ym1pdF9pbml0aWFsX3JlYWQoc3RydWN0IHNjcnViX2N0
eCAqc2N0eCwNCj4gICB7DQo+ICAgCXN0cnVjdCBidHJmc19mc19pbmZvICpmc19pbmZvID0gc2N0
eC0+ZnNfaW5mbzsNCj4gICAJc3RydWN0IGJ0cmZzX2JpbyAqYmJpbzsNCj4gKwl1bnNpZ25lZCBp
bnQgbnJfc2VjdG9ycyA9IG1pbihCVFJGU19TVFJJUEVfTEVOLCBzdHJpcGUtPmJnLT5zdGFydCAr
DQo+ICsJCQkJICAgICAgc3RyaXBlLT5iZy0+bGVuZ3RoIC0gc3RyaXBlLT5sb2dpY2FsKSA+Pg0K
PiArCQkJCSAgZnNfaW5mby0+c2VjdG9yc2l6ZV9iaXRzOw0KPiAgIAlpbnQgbWlycm9yID0gc3Ry
aXBlLT5taXJyb3JfbnVtOw0KPiAgIA0KPiAgIAlBU1NFUlQoc3RyaXBlLT5iZyk7DQo+IEBAIC0x
NzE1LDE0ICsxNzM0LDE2IEBAIHN0YXRpYyB2b2lkIHNjcnViX3N1Ym1pdF9pbml0aWFsX3JlYWQo
c3RydWN0IHNjcnViX2N0eCAqc2N0eCwNCj4gICAJYmJpbyA9IGJ0cmZzX2Jpb19hbGxvYyhTQ1JV
Ql9TVFJJUEVfUEFHRVMsIFJFUV9PUF9SRUFELCBmc19pbmZvLA0KPiAgIAkJCSAgICAgICBzY3J1
Yl9yZWFkX2VuZGlvLCBzdHJpcGUpOw0KPiAgIA0KPiAtCS8qIFJlYWQgdGhlIHdob2xlIHN0cmlw
ZS4gKi8NCj4gICAJYmJpby0+YmlvLmJpX2l0ZXIuYmlfc2VjdG9yID0gc3RyaXBlLT5sb2dpY2Fs
ID4+IFNFQ1RPUl9TSElGVDsNCj4gLQlmb3IgKGludCBpID0gMDsgaSA8IEJUUkZTX1NUUklQRV9M
RU4gPj4gUEFHRV9TSElGVDsgaSsrKSB7DQo+ICsJLyogUmVhZCB0aGUgd2hvbGUgcmFuZ2UgaW5z
aWRlIHRoZSBjaHVuayBib3VuZGFyeS4gKi8NCj4gKwlmb3IgKHVuc2lnbmVkIGludCBjdXIgPSAw
OyBjdXIgPCBucl9zZWN0b3JzOyBjdXIrKykgew0KPiArCQlzdHJ1Y3QgcGFnZSAqcGFnZSA9IHNj
cnViX3N0cmlwZV9nZXRfcGFnZShzdHJpcGUsIGN1cik7DQo+ICsJCXVuc2lnbmVkIGludCBwZ29m
ZiA9IHNjcnViX3N0cmlwZV9nZXRfcGFnZV9vZmZzZXQoc3RyaXBlLCBjdXIpOw0KPiAgIAkJaW50
IHJldDsNCj4gICANCj4gLQkJcmV0ID0gYmlvX2FkZF9wYWdlKCZiYmlvLT5iaW8sIHN0cmlwZS0+
cGFnZXNbaV0sIFBBR0VfU0laRSwgMCk7DQo+ICsJCXJldCA9IGJpb19hZGRfcGFnZSgmYmJpby0+
YmlvLCBwYWdlLCBmc19pbmZvLT5zZWN0b3JzaXplLCBwZ29mZik7DQo+ICAgCQkvKiBXZSBzaG91
bGQgaGF2ZSBhbGxvY2F0ZWQgZW5vdWdoIGJpbyB2ZWN0b3JzLiAqLw0KPiAtCQlBU1NFUlQocmV0
ID09IFBBR0VfU0laRSk7DQo+ICsJCUFTU0VSVChyZXQgPT0gZnNfaW5mby0+c2VjdG9yc2l6ZSk7
DQo+ICAgCX0NCj4gICAJYXRvbWljX2luYygmc3RyaXBlLT5wZW5kaW5nX2lvKTsNCj4gICANCg0K

