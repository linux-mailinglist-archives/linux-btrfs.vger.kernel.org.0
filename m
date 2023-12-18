Return-Path: <linux-btrfs+bounces-1022-lists+linux-btrfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85921816DC5
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 13:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75031F234B4
	for <lists+linux-btrfs@lfdr.de>; Mon, 18 Dec 2023 12:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D84EB2B;
	Mon, 18 Dec 2023 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ifqRFkEx";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="q+0sll9e"
X-Original-To: linux-btrfs@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9354B142
	for <linux-btrfs@vger.kernel.org>; Mon, 18 Dec 2023 12:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1702901684; x=1734437684;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6IKBixoEMLBYnMLp+ZOAXKOyD7tdcNU0p2PizKohXMs=;
  b=ifqRFkExeY8G5YipXgNdbccP5C0dOxzs6CNq/MDFB6GdOEkyztNu7MoQ
   kME6QYr1Y+yQy8Mj3LxlUBoxkiHKPc7oSjqclT1ELrE5qvHh7Y5Zq+mbn
   GqRe/sIh4yKljQ8zF3KuZAtXP87dHpplDsCb1BLbcx3jCMb8Lwl1+QATv
   cKOOP90fHMxdPzl0ZKGNrFHzbp/jRP9AvzfiKF5tB33njT+OtE4VS3FiA
   eVC4Y9M6KY0ZqeqAusSTojH5BmbDDF0bKynpV8HR9mmabRJGDPGrajfFx
   6ImZUWoSfNcuZkbAyszjfCF4r3VpLiKND/sZP3QYKIlW3n1ioHJKnX3Ft
   g==;
X-CSE-ConnectionGUID: ySnDhXONSUSgOM2YcxQ9Jg==
X-CSE-MsgGUID: A8Rde2o1TSm2yRZleruDBg==
X-IronPort-AV: E=Sophos;i="6.04,285,1695657600"; 
   d="scan'208";a="5106456"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 Dec 2023 20:14:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeur5zhxrGpOYrutF4HUJtIltDu368rr4tChaBkCt3Qcif8ZKIPsbcLMAmN48HEspOiA5EHDgnYpWlVIPycPEVxIgEMS7xen4QZLg6OiTa6bKFM/BqidSxQds93kbLvI/QrzCk4uONIpo9jwq47vMDyenwfHXYD/WCmULAjrGhDnKgjT9uGtODF0D9O/ModcC2NTUV/9cFotb7VDCm4BtI+YfY5vcXPKBG7xG+4N07wwA1cFdOb+xcEmFUOSnarEiOnRjqPJcVmtd+F1d+1dzYwaYiDhEi2HhsBhQTjW9ETIDRONCeLcM3i3IthCLncOHiaI+nkf/MOutngKKhbADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IKBixoEMLBYnMLp+ZOAXKOyD7tdcNU0p2PizKohXMs=;
 b=Un6Z50HVk4mClc3LWBS1AqAqseOjS6Cyf/z2LPO0MV0CwLMqgGhx0j1UJzT1yIB4Hqgfm98ywjAjvu5vx81Rg5ELohS6D9tEbSwoGT/HYasIUri4OqTnILIGXGgw/PIqqYJcdQe5061+ODE0YzaAXq+oVq/JnnPj5SleYH26PNy1topgx8auD5FyUNFNKGoKUpf4W5GRQhs6e4KspTgcCLMHDs2SUY/PENDXyzlOb2Jwyw+ugF9r7RR9OBEttzloyjRls7TYW6HyVU+qFuoLDF+ywgzDkXG3l+Cki0lASVBkNXHzdT6DIGwx+KRfke0WmiktA/wDHfBP49cIIl8zeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IKBixoEMLBYnMLp+ZOAXKOyD7tdcNU0p2PizKohXMs=;
 b=q+0sll9eKtbNmctZKeM0anpMnrZZ/VTSn7sdV2aSf4WdDYQSNHuBbGGS7aKMJLsR5tRLDNsU0JSf3vqZXyp4vjQRlDlyQDVgZdDL7pGYqyBXppNEqLgnHty36lY0A9IO9/HAjpauT1oy1q2grDiGQbmo/HG7FvW2Ed5u5lr7/tI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH7PR04MB8684.namprd04.prod.outlook.com (2603:10b6:510:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 12:14:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ea3:9333:a633:c161%7]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 12:14:35 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Josef Bacik
	<josef@toxicpanda.com>, David Sterba <dsterba@suse.com>
CC: "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 5/5] btrfs: use the super_block as holder when mounting
 file systems
Thread-Topic: [PATCH 5/5] btrfs: use the super_block as holder when mounting
 file systems
Thread-Index: AQHaMW2xnDAD1pa0zkuIcX7jlufKwbCu9KoA
Date: Mon, 18 Dec 2023 12:14:35 +0000
Message-ID: <04e599b9-5d6d-4ac0-bf74-da9bedfb585f@wdc.com>
References: <20231218044933.706042-1-hch@lst.de>
 <20231218044933.706042-6-hch@lst.de>
In-Reply-To: <20231218044933.706042-6-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH7PR04MB8684:EE_
x-ms-office365-filtering-correlation-id: 40c3cf53-310b-4877-31fd-08dbffc2e66b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G9vPyHwSys1BSPb2uhUHdRJxu/6hx/ytGW895QCmA3OU2fsP5iqI2cqhKxIQhRzMWaKCM2A0ggLTR+X9G5e7oTNhDv3ZrM1c0z8RoPoz0Pv9i0oseq6fTCgpLCdVk7GYe5CdYR4sZD+H6RYigP1kcpo3lvFB3slC+aHW4VemBu97I+vSi17bH1grK6LsUDMvxTX0vm/Pd0fxX2uev0yFiuHJhKGNjLz84h0N5iCWUb3yYhBDc0bDYSYfTdBP9bpESkvio6S4y0wPEsqMbibFOIP0fmOyl2W01DYfzMKe1Vu05cPDOPpbNqyZnq5q0mzgay9ggSJNF82RCMYCB8MpQIqa46wxWux0bALT8OmL+iGW48+DoL0IzLBOT3OiB1mHUCIdYMZgm/xXAy+2Hqc34zI3fYt+u0NJtvqITF3OhDUOyyB1Et92CxJNts7AsxWkpZ3u7CsNTHFplaJ0iHh01rRljmo1T5HmjTAPJOMrGgVV6rvl7Rs2+dBmh9+fVFJ3GtHg9KFZbQHqyodhQ8FA5tAe8wWOtWDU5TYEPAmE+sIwTdcGxfPZcT8lYY8LhoOmFhEaG0mSmnA3ODezqWAfKzDcK9frHLUoCfISUIZ+EEXDMHQyhXkzwbMa0o5sw0jKhO8pgf7mUf6DGftaf7JSGxKCsDKe0zt8BmZ834b/4zM5Af90BuPg1yetcICU/DFg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(31686004)(2616005)(71200400001)(82960400001)(38100700002)(122000001)(36756003)(31696002)(86362001)(38070700009)(83380400001)(5660300002)(6512007)(53546011)(6506007)(8936002)(8676002)(4326008)(66946007)(54906003)(91956017)(66556008)(76116006)(316002)(6486002)(66446008)(110136005)(64756008)(66476007)(2906002)(4744005)(41300700001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M0hsYmJpMUNRSkdLemRtbjRlbVZoUnI3SDJaUVoxY1RDZkRoQ1JnWmpVU2g3?=
 =?utf-8?B?WWFIY3ZacXByWWE4dG5ydUxlQ2lFYXZFV0htSlFQM0htSFNoNDl6NTAxa0hK?=
 =?utf-8?B?SVBIV2tOem1UQS9OSDFRNVk0Nk1Sc1VKcHhWL1B1SDQvU2VWVmtua1hKeEM5?=
 =?utf-8?B?b0VjMG5lK3ZEa05HMW5WZGE3YllxRXBFMTBSdzc5UWwvRGZOWFRJSGlDRkxN?=
 =?utf-8?B?VE9wOU1lSnp6VzVaVTFSeFVjeDdlcURTRTcya0lzeG0ydEpnRU41TS9xSVNH?=
 =?utf-8?B?alhwZDFSaW50dXpsU3J6SkovSHZVMG5WK09HMlJsQlBOdEVjTVcvajRSdG9K?=
 =?utf-8?B?ZjVQS1JLZ0FKN0NCRS96QVM1M016SDZUeGcrUzdJNkhwWUh2WWhCbjlpeEFW?=
 =?utf-8?B?a2ozNm11aWZ5ajlyWWk4OStKelQvU2tXbXFUa3lXNmVPejZNcy84alNla1ph?=
 =?utf-8?B?WE9ialJCdytJbTFCRjJlSjB6QnFOV2pmT0JFTmJOTCsvcUIyYkcybktOMnpX?=
 =?utf-8?B?Mmo5WU45VmU4cDBUelBYazExQnNGVnFTMzRjVXNtTlVEeVRXdit6aVVFTCsw?=
 =?utf-8?B?REFmVVRTRkk1Yjh0YTR3b2R0ZkVjSEYzVnlZc01BRVYyU3lwR2I2RzFVMDF3?=
 =?utf-8?B?QnBxTGFOQkcwaWhaZUdzMm14aVhaNVNaRit6N3lCVVNrQlkyeUNzaGFnbGpG?=
 =?utf-8?B?Ky9YQ1J6VnladjRZbHRURGxmd0xPV3dYdzZ1ZUR5bll6ZTFLbFRyWTdUcGVD?=
 =?utf-8?B?NXZWMXFuSkpNS01INndZOHBlYWRZNytXOVd2cm1IcVFRNXd3b3EzVHVqdGxo?=
 =?utf-8?B?WFd1YXh4T0ZiSE1WL0daclBySXVzVFE5UE5NQ1BrZHpML2hQMkpGMmoyODdl?=
 =?utf-8?B?cTJRelQ3V1pwclFGY2FXYVV3d0phOENSL0k3VFV5S0ZCbUJzNjRFTjVuRkZv?=
 =?utf-8?B?TXRHaWFBeGRXK2xGVTJndzBVL1NJOFZiQWxwNHM3Y1l1UlVYYTRBa3o1bHk0?=
 =?utf-8?B?NnpCektRamZIWlprbkN3bXJjMFAxeHZBVUhHNFIrMmhtM2M0dXBjRk9HRzhL?=
 =?utf-8?B?bTBiU1FEVU9hc1NiS25EQ3hGdjZzU1EzRStaQVdKeTRabU9Gdm5RWHlXVDVD?=
 =?utf-8?B?dC9KTDlsMHpKMVpxeFFvUW96UmtyVk95dytlVlZqczlqUjQ1bW4rQTlSeGxj?=
 =?utf-8?B?R0xwRm1kWWtjZXp3UUFHaXM4WnZHN21ZTVIxUkZQVkVTeHpxRGJySDdBSDlM?=
 =?utf-8?B?amh5Vis2dVl6bkk4Z1RORStTZkRSelJYZmhEWWdOYXN6K2w2VHR2SUgxMzFQ?=
 =?utf-8?B?VkYydE51TzVQTldsOXFleEVLaHc5YTB2YndYanNxVWg5OTVDRnFGRDNidXVk?=
 =?utf-8?B?T1ZoOUN2VnVIeCtVTnVDU1lTMG92Y1p2RlNGaXdQUnpUNjM2OUZMdlN6ZGFF?=
 =?utf-8?B?bllzbUN4L09ZamVjZjJVMC9CM202KzYrSzB0VEJ6Nzc3Q2Z0eDF0VlpBMXRv?=
 =?utf-8?B?UFh3YWN2eHVETmFOKzZkcnlKNm9yZXlkT1diRG81RW5zZDlGdGprUEtleUFj?=
 =?utf-8?B?VjVjc05kT1F2T2ErWVRhSzBKNU1uWW01N3BFMDNzNEtSbUZuS2Q1WVp1UHJw?=
 =?utf-8?B?VnI1a3o0Q2U4dlJZaUxiOE1WSmdLM0JvTzkxNHBvc0J1Rlh3Yk9IK3ZVTStS?=
 =?utf-8?B?T0tWemdIRGdrYmwxWWE1WlkzQ3pDbGpDa0RuSUJZV1NoVFhYT1ZrbXBRaVdm?=
 =?utf-8?B?N1ZDamhROUdXTUVwanorNHNoU25XdWtQTGdiektMNS9wd3B2czBoWTZVRUZ3?=
 =?utf-8?B?V1hyTUoyOEhJblU3bEJ5WThhRGFaZ3ZNS2g2T3NWaTBZUHd0ZXpldlN5blFn?=
 =?utf-8?B?S1ZlbFgrTlljYk5qT2VhaHBoNlhHT2tlL1pRYVVwV0VrN282RFFsbmVwWlpi?=
 =?utf-8?B?SVR0TGxPamhxSFRGTnFNUGFJTjFVTFFzMDhEOHR6T0pqTzhSdlVNVDFpZDdl?=
 =?utf-8?B?bmZTUDNPeGRid1pPWWpodVlRU1UreFZPR3M3VFgyZFZJRWpEbi9iR0ROUlR4?=
 =?utf-8?B?V1FzTXdVa3hzWm9KUStReldxanZpNnlPR0pENlZjRnhOQmVCRHFlRUluOGR2?=
 =?utf-8?B?eGhic0RTRHdrMjZMa1JKQzJBVmY4RFB5QlZOV2M4OTN4MTNhYTk1RVVJQVI0?=
 =?utf-8?B?Z3ZHNFMwaHhKbmhGWEUrUm5MUnFyV25aZ2NzYVBKYlBjVER6NGVhRUovbEh4?=
 =?utf-8?B?SDEvUU8rVWEwSmtRQ3BtWGFIYUhRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B60E18FAF6264B4297FC27455EBBD041@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-btrfs@vger.kernel.org
List-Id: <linux-btrfs.vger.kernel.org>
List-Subscribe: <mailto:linux-btrfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-btrfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	14f30I4gmG2fyKl2FUP0SjQ6zoyg8TLmkuAbJSvhNkCNwCTWrdWUq4HlBY8lTgqROlO2IJRPL2w+LT0/n/wbEkpFSBn5gcy5AYwdRffnHnckOnLbopqqqdBnMBdyorANvEdurZJlyJGCNBdRNLqh1SidoyCbUBeGE1/15L7FQTXIp7DEe+IOqXsqwN88wGhV++fHavPOjo+DBpaEbaLEStTjqK2FU2uof1UQfe7FpyQoZaihiiS1bZhbrYBVHEIx7za4kWsEQztjzD08OkOGNLcTNh/Qb44E2oex8qsBSbN+fSdWMo7uWyv75dwuGgSZlOuJCmN6PCgkkCN9HLcSHc7ppvrWbM/G1BMWWcYp3NLJFcLx6+khIIkL4Ckok2ryGIkLGwIZ27m8cQ+KD7V3n89qnKcYWW+pvQmF5QpPgwo95Q+hbb7as2/I6TXN0MdIkCpyW+7mKgeWO9CgG9WEvhQcut1ukIP4DS/l6CkEXYbQGCzZi2MwL3r7uU+n5gR2e6SY8erVEQ+vzKyP8PjsvKZeFxtpx2sQd+SBGqUbtGY4TxEDYUG1yTU+gQzADbFqEGjqYMaA9nfMHJ4YcxTJUaGV5uHnlMigwBuKzZolCvfzWLDUoe5FeWGvDPTA9yIJ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c3cf53-310b-4877-31fd-08dbffc2e66b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2023 12:14:35.7060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tE/k/Ie7yGGl64f5RQss1Hwh+qPO15RC0l7zgXewgnFPhfbo4psao6MVX8cyB7WhIQMxmPAPTQDvjYVNewFKnQH3knBQjdPZNsBfYi58CcU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8684

T24gMTguMTIuMjMgMDU6NTAsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBUaGUgZmlsZSBz
eXN0ZW0gdHlwZSBpcyBub3QgYSB2ZXJ5IHVzZWZ1bCBob2xkZXIgYXMgaXQgZG9lc24ndCBhbGxv
dyB1cw0KPiB0byBnbyBiYWNrIHRvIHRoZSBhY3R1YWwgZmlsZSBzeXN0ZW0gaW5zdGFuY2UuICBQ
YXNzIHRoZSBzdXBlcl9ibG9jaw0KPiBpbnN0ZWFkIHdoaWNoIGlzIHVzZWZ1bCB3aGVuIHBhc3Nl
ZCBiYWNrIHRvIHRoZSBmaWxlIHN5c3RlbSBkcml2ZXIuDQo+IA0KPiBUaGlzIG1hdGNoZXMgd2hh
dCBpcyBkb25lIGZvciBhbGwgb3RoZXIgYmxvY2sgZGV2aWNlIGJhc2VkIGZpbGUgc3lzdGVtcy4N
Cj4NCg0KU21hbGwgTml0Og0KZXh0NCwgZjJmcyBhbmQgeGZzIHVzZSB0aGUgc3VwZXJfYmxvY2ss
IGVyb2ZzIHVzZXMgJ3NiLT5zX3R5cGUnIGFzIHdlbGwgDQpoZXJlLiBSZWlzZXIgdXNlcyB0aGUg
am91cm5hbCBhbmQgc28gZG9lcyBqZnMuIFNvIHdoaWxlIHRoZXNlIHR3byBtaWdodCANCm5vdCBi
ZSB0aGUgYmVzdCBleGFtcGxlcyBpbiB0aGUgd29ybGQsIGFsbCBvdGhlciBpcyBhbiBleGFnZ2Vy
YXRpb24uDQoNCkknZCBqdXN0IGtpbGwgdGhlIGxhc3Qgc2VudGVuY2UuDQo=

