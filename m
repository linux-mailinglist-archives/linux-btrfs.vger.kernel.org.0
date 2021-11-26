Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D880D45F005
	for <lists+linux-btrfs@lfdr.de>; Fri, 26 Nov 2021 15:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377802AbhKZOlt (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 26 Nov 2021 09:41:49 -0500
Received: from mail-eopbgr50095.outbound.protection.outlook.com ([40.107.5.95]:28341
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1352782AbhKZOjr (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 26 Nov 2021 09:39:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXQcnt93dVHnwB4kzNhcLOk8R/r4GSBGKgMWzOkljUKkJgko2Wlr1FTM7kbNG9yhNz+ijVPQwIfiN0NnmaSjVW5/6RYacP/D8fec7uoN8xhXoYT7goewSaIKuTJyiBBMNAp1uoQqC4ZmyDmMA8+7AmFNntcb1Cn/xjIq2TDVS4MAzNS61OP4NRysM0oR6kqNz/LfLjDmMz7aAm+kTp2pCJg8P8XkcV3JyETo7/qGTje3lmGrKaJE9oJBYRtC9KIIrE8Ao/rCcnZoMuttC6r7UrINU1+vmuuKbAQtsNjbdUEeRK/SO+SisKbMsYqfslWUJOK3WVOITo3pwGLG9Vwddw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aP9PHmmGQktPeKi76jE9fa4QV0Iv1aQvaCvBBMFQExc=;
 b=X6KxlpJHZ9CdSE35FaQSf1t4a/3fbIy/3cn3N/v5CMzmOb2C6lPMIMEGMiOHD6+cxfRtswp9sL75c1ZLuXACSPA6tcu2J7XNl8GP0sg6jJ1wK3J+BIFcL/JOBAkSPEd4yOXQi4UQIfJqLSuwAGE4ZUZCocvca+idwATEpIQ1HNzBBF81qh07788pZtSqNpLOoQBrZ9p1RIlJaVOkdR2L8RR7lNbNPw/Pxhm6eyBeBT0Ot1hBx9yykMkdF8zzTG05J9E1mh+fEckGYgFLYw5m5HVc9Y0l6yv19D5Uf/vxPhQv5PLXRow50Clib8owDJeQg46k3gmMkJqVxHtDZrB7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bcom.cz; dmarc=pass action=none header.from=bcom.cz; dkim=pass
 header.d=bcom.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcom.cz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aP9PHmmGQktPeKi76jE9fa4QV0Iv1aQvaCvBBMFQExc=;
 b=Wi8k5rPEihRKPolZ/won8f2keKWECp7bgQf8Xkw4iosIEgCp8s7dPKScSQJ58+gX537QGvPD2ckA1PmDOIPl01TxiKNB5b/2++CsTHjn86RPseytsdpe1r9+2oDNYQMEyERiKOZTlZCOIaiuNzfOQcSp4usp5UxvqjhvMciZhdk=
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23)
 by PAXPR03MB8098.eurprd03.prod.outlook.com (2603:10a6:102:231::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Fri, 26 Nov
 2021 14:36:31 +0000
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::2003:9a4d:cc:c96a]) by PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::2003:9a4d:cc:c96a%8]) with mapi id 15.20.4713.026; Fri, 26 Nov 2021
 14:36:30 +0000
From:   =?utf-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Btrfs lockups on ubuntu with bees
Thread-Topic: Btrfs lockups on ubuntu with bees
Thread-Index: AQHX4tMAp1surAV4LE6J53J71m075g==
Date:   Fri, 26 Nov 2021 14:36:30 +0000
Message-ID: <c9f1640177563f545ef70eb6ec1560faa1bb1bd7.camel@bcom.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bcom.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bcb4ce1c-cc83-4b54-4f65-08d9b0ea2337
x-ms-traffictypediagnostic: PAXPR03MB8098:
x-microsoft-antispam-prvs: <PAXPR03MB809873F26155C2927174F0028A639@PAXPR03MB8098.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gPXBXpHpItxmJWan9hMcCFiAAuOo5CC/cxPj37aDTxBxXanT2I7JaUnN/oX6BwoimAOQNvSWddXfA9BvDYjLvDv7rS8UJF98fYnCEPDu5CLy6thjBRvXCMH+QU8o96T2xdsQ3Z411QAODi+F1B3x1RBRHQzkEBl9D3De6j+Dhv4BvKOosPsMVVP4+PV4I1e6uuRfLmR3KvrvhdPO004O6r/cIKUwXylCA9l4hP35MEmuGTDSIApkedzHgK242qwpOdZzPFd1YWW9JeS9hkqFlZ1Gz7eTFnvQHWPA59mJA4runQYfsy3ZzufSQS7yU+NmKEV8jT2burlWuTlwuwCF4lAbOD9M3QSSIp41XP7xZEVmAAc8INW+2yZOYgiXO9CmjZkd60qTKnhUbFh0WvF/kys7+F00rh8IobV22mgIsyWg+e+XtqNKH5L7nXT62RcTzn9WG5b9chE12jx60o1TQdBQYyeNLws0Zkucpyf8fSYLmkPPNYVG70lLSpadnbJy6JuH/uSFmGQ7uJFRWOIZfWTW+AmKW2iihmfyE88q7jfRAvzEU1dA9+rsXb5/83g/jCviwzaQG9fgoH7xBaGY9o+NBSB+Z2Ot8+0cyqRfmnnEDmDRl2hKKQfFLkZx7MCCUZpn5egymWDi54yiIqWXptpniIDYHpQr7q3nx4RZYdTr0e3gO426lVPxyliCmVMFH+Ir+XJnKQsgHCKxvPhkxkz172eY8fhCOY8skWKZ5QfwaZFFWO/Mr6ck1f40mlf59x+9HoLLQvYNeRqSjExuMbna3DPZTgU5uwxwXf8oUAY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39840400004)(366004)(346002)(376002)(136003)(396003)(6916009)(8936002)(6506007)(5660300002)(38070700005)(38100700002)(71200400001)(508600001)(83380400001)(966005)(8676002)(66476007)(66946007)(66446008)(76116006)(316002)(91956017)(186003)(2616005)(36756003)(6512007)(26005)(6486002)(64756008)(66556008)(122000001)(85182001)(86362001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFJpM0dSSHJmSmF1UFlJNzQ3V2hJZWV2dUVjY2YzWnVZN1ZWYlB1bW8wZG9P?=
 =?utf-8?B?OVhMdDVpUVRkOE9xQkgvL2ovem9aN1l5SFE4VWo5Uzg0eFFDaUxGalJRODFM?=
 =?utf-8?B?NWk4K3RPNVM4STBIQWZDRnVmMXpxMXl6Tmk3NnRVK0RaVHp2SXUrRy95djY1?=
 =?utf-8?B?d3pOM1kzTDlkemd5c0EyWnp3L0FnZVVBZUFMS3NXVXlLL1VOVGVsbjdtdWp2?=
 =?utf-8?B?KzRGVkdMQ2NTL3ZXWnRYVldvOG9oRnBsY3lpRkU1c21aOEg1V1RkSnAxNUw0?=
 =?utf-8?B?aklwVWliQnZzTXdCUDN3alJabnh3a0ZKeVBiRjBmaEZsRnZBV25jSEpmNEhl?=
 =?utf-8?B?K3BtM1kxSk9MM0FGOTg4dTlSSTdLTWNRYWZhQzcybTczY3Y0YjJRZDVrVzF0?=
 =?utf-8?B?ZCsrcEdWM1RHTFNveUI2elJSek5NZndkcCtGRUltV2ovSVAwUlU3UkRyUHVs?=
 =?utf-8?B?VTIvQW00cTZFMFRUVU1NWnZGejNYcHV2b3F4NWJBY3BsNVB0d2NxcUpRQkxO?=
 =?utf-8?B?MVdYbENuemJoUHJSTlE0TDhuVUVQTDg2aUdQSTV1ZTFmOUhBUm1ObGNnYk53?=
 =?utf-8?B?YVVadXUwanUveGFLUmMvbzhoazh2MzgyeEtSNGR3QU9TaDY4bDg1aUJySXFL?=
 =?utf-8?B?TUw5c1h5OC93SldVa3FJa1JMTWxuMW1VZmFKZEtiazV4Y203dzA4TUFUTUJr?=
 =?utf-8?B?T2FxU2NSUnRlS3N0c0x0WHh6bVZQem9YdkdjL2JEb3JmUjRJZUErbS9peitQ?=
 =?utf-8?B?aHRreGZGYnhnaVYxY0pCOWk2N1dZUFpJTmJ3TGtYZkltQk15VHZiS29ESVVV?=
 =?utf-8?B?cmxpSUVUQmJPSDdrVm5WUjJ5RURYMS9qYzFQSWFzV2J6b0tBOGlDTzFGYzRv?=
 =?utf-8?B?T21CSHVuTWJUaXlIdmpFYjBEdkRiT0lYT2tJNmwwWHpEU3k5cXplTXU0eDFI?=
 =?utf-8?B?UHk0aTB6STJHc2kyd2h4NUZHRi96Tnk3NzBjRkhsUTdOYVlWRWgzMlhIb216?=
 =?utf-8?B?T3BMUVlBZVdYSWhjd1FoTnRHUlVKTkhISllkaXZYNDVHSzJpbDBsclJIb0R4?=
 =?utf-8?B?c04rRlRBVlVIMWF0ODV6b0NscFdnQ2JlM3hZUEsxcWR1d0ZjZmVmcitYQmZw?=
 =?utf-8?B?MUJzaGdEeHBuUExzNlV2T0o4Zi9XTG5RZmdobUd3ckZUK1RRNmFpdExYQXFR?=
 =?utf-8?B?dW5xTVVtV3RoVEtDdVBwaXRVVGNwOGVuOU9YQ0Y2SlB1Vy96TVlHQ3RhQmgw?=
 =?utf-8?B?TndpTG83SDAvU2VpRjk4R2E4Q1FibnBpSHlxK3k2bUdFM2RJbGlsNkNMYXNR?=
 =?utf-8?B?cnB3dEhqbnhRMGdHK3RtTFNIMEdkMUViY2d3VlgzVGNEQzJ3TjNWT2lIVEpY?=
 =?utf-8?B?eXN0anQxTGdKby8vTUNwYlFQLzBER0VnK2gva2hTUXpZRHdldWY5R2pNMGFO?=
 =?utf-8?B?QXgvZ1l3N1hqRTgvUjRYMUZOTXljaXNPLzIvR0xIT2ZFVDRFOVUzUjN1eTZt?=
 =?utf-8?B?dEpVaFVXVnlheG53K0k0R3d3ZGtrcWtxYUxsNFZoRklsMit5bXlvcmJuOS96?=
 =?utf-8?B?dmgwOVlBYzhLaHQ0eUFBenNleERUZU12SUY3eUVZcVB1QXp1aDlJVnAxNTIr?=
 =?utf-8?B?K053TTR6MTVSamtYdHV1V05LdHdDMlJPR2p5SnNYZGtubnZCNWY3bk92YUcy?=
 =?utf-8?B?ekU0VmFjNVp3ZjVtbHVqbTBTSXpSKzV5WllPT05XZ1pZUElDNk1ETWVvbW9q?=
 =?utf-8?B?RGpGRER6a2JZaHFLR1cwcGNpY0dKeGNRUFlXVVlkWDhnM1BUV1FZckZGUGpr?=
 =?utf-8?B?MlNBbHpkNllPWjdoU1lWUTNGYkd1WXFWY3p6U1JhU0dxSyt1U1QvcHFpZS9l?=
 =?utf-8?B?VlkvSFRaMG1GNWFPVVdmWDlIdnRRcFZKMXNTVzVPVVlSTE85RTltdGtKalBk?=
 =?utf-8?B?Z2pnLzVrYSttalAwYWkzQXVFL3hudStWaGgyV2xMR1FDeTV3Y21WQ2JkSHYx?=
 =?utf-8?B?a0dZRkVpOVNHY0Y2N1JQTDBLbUFUbDFqSVNFSE55MkZ5VWVuekNVdVFnWmpn?=
 =?utf-8?B?NXU3eTlZd1NhQUxTcVJqN2RPUFU2SkdRQkUzRDBFcEhYdG1iWFQwNXdycmNw?=
 =?utf-8?B?VGF1Wlc4UjloK2FZdGpLMDNoYXpqK1c5T3htTzJUYmRxeWs5NzNleEhGcWlr?=
 =?utf-8?Q?wjus/vftwNV3M2gCTUNKlWU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FDE0B698D2A33F498AD7CF66DA56A409@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bcom.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcb4ce1c-cc83-4b54-4f65-08d9b0ea2337
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2021 14:36:30.7915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86024d20-efe6-4f7c-a3f3-90e802ed8ce7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PlnLLUU+sN0gETZbztWG2VUPfZk3ZnlehRnyuHBxGhbJdy7tgTCq1tmnMcR81jBsUAZbqBVC+be/9Pig1QkmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB8098
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGksDQp3ZSBhcmUgdHJ5aW5nIHRvIHVzZSBidHJmcyB3aXRoIGNvbXByZXNzaW9uIGFuZCBkZWR1
cGxpY2F0aW9uIHVzaW5nDQpiZWVzIHRvIGhvc3QgZmlsZXN5c3RlbSBmb3IgbmFraXZvIHJlcG9z
aXRvcnkuDQpOYWtpdm8gcmVwb3NpdG9yeSBpcyBpbiAiaW5jcmVtZW50YWwgd2l0aCBmdWxsIGJh
Y2t1cHMiIGZvcm1hdCAtIGllLg0Kb25lIGZpbGUgcGVyIFZNIHNuYXBzaG90IHRyYW5zZmVycmVk
IGZyb20gdm13YXJlLCBmdWxsIGJhY2t1cCBldmVyeSB4DQpkYXlzLCBubyBpbnRlcm5hbCBkZWR1
cGxpY2F0aW9uLiANCldlIGhhdmUgYWxzbyBkaXNhYmxlZCBpbnRlcm5hbCBjb21wcmVzc2lvbiBp
biBuYWtpdm8gcmVwb3NpdG9yeSBhbmQgcHV0DQpjb21wcmVzc2lvbi1mb3JjZT16c3RkOjEzIG9u
IGZpbGVzeXN0ZW0uDQoNCkl0J3MgYSBWTSBvbiB2bXdhcmXCoDYuNy4wIFVwZGF0ZSAzIChCdWls
ZCAxNzcwMDUyMynCoG9uIERlbGwgUjU0MC4NCkl0IGhhcyA2dkNQVSwgMTZHQiBvZiByYW0uDQoN
CkJlZXMgaXMgcnVuIHdpdGggdGhpcyBwYXJhbWV0ZXJzDQpPUFRJT05TPSItLXN0cmlwLXBhdGhz
IC0tbm8tdGltZXN0YW1wcyAtLXZlcmJvc2UgNSAtLWxvYWRhdmctdGFyZ2V0IDXCoA0KLS10aHJl
YWQtbWluIDEiDQpEQl9TSVpFPSQoKDgqMTAyNCoxMDI0KjEwMjQpKSAjIDhHIGluIGJ5dGVzDQoN
Cg0KDQpVbnRpbCB0b2RheSBpdCB3YXMgcnVubmluZyB1YnVudHUgcHJvdmlkZWQga2VybmVsIDUu
MTEuMC00MC40NH4yMC4wNC4yDQoobm90IHN1cmUgYWJvdXQgZXhhY3QgdXBzdHJlYW0gdmVyc2lv
biksDQp0b2RheSB3ZSBzd2l0Y2hlZCB0byA1LjEzLjAtMjEuMjF+MjAuMDQuMSBhZnRlciBmaXJz
dCBjcmFzaC4NCg0KSXQgd2FzIHdvcmtpbmcgb2sgZm9yIDcrZGF5cywgYWxsIGRhdGEgd2VyZSBp
biAoYXJvdW5kIDEwVEIpLCBzbyBpDQpzdGFydGVkIGJlZXMuwqANCkl0IG5vdyBsb2NrcyB0aGUg
RlMsIGJlZXMgcnVucyBvbiAxMDAlIENQVSwgaSBjYW5ub3QgZW50ZXIgZGlyZWN0b3J5DQp3aXRo
IGJ0cmZzDQoNCiMgYnRyZnMgZmlsZXN5c3RlbSB1c2FnZSAvbW50L2J0cmZzL3JlcG8wMi8NCk92
ZXJhbGw6DQogICAgRGV2aWNlIHNpemU6ICAgICAgICAgICAgICAgICAgMjAuMDBUaUINCiAgICBE
ZXZpY2UgYWxsb2NhdGVkOiAgICAgICAgICAgICAxMC44OFRpQg0KICAgIERldmljZSB1bmFsbG9j
YXRlZDogICAgICAgICAgICA5LjEyVGlCDQogICAgRGV2aWNlIG1pc3Npbmc6ICAgICAgICAgICAg
ICAgICAgMC4wMEINCiAgICBVc2VkOiAgICAgICAgICAgICAgICAgICAgICAgICAxMC44N1RpQg0K
ICAgIEZyZWUgKGVzdGltYXRlZCk6ICAgICAgICAgICAgICA5LjEzVGlCICAgICAgKG1pbjogNC41
N1RpQikNCiAgICBEYXRhIHJhdGlvOiAgICAgICAgICAgICAgICAgICAgICAgMS4wMA0KICAgIE1l
dGFkYXRhIHJhdGlvOiAgICAgICAgICAgICAgICAgICAxLjAwDQogICAgR2xvYmFsIHJlc2VydmU6
ICAgICAgICAgICAgICA1MTIuMDBNaUIgICAgICAodXNlZDogMC4wMEIpDQoNCkRhdGEsc2luZ2xl
OiBTaXplOjEwLjg1VGlCLCBVc2VkOjEwLjgzVGlCICg5OS45MSUpDQogICAvZGV2L3NkZCAgICAg
ICAxMC44NVRpQg0KDQpNZXRhZGF0YSxzaW5nbGU6IFNpemU6MzUuMDBHaUIsIFVzZWQ6MzQuNzFH
aUIgKDk5LjE3JSkNCiAgIC9kZXYvc2RkICAgICAgIDM1LjAwR2lCDQoNClN5c3RlbSxEVVA6IFNp
emU6MzIuMDBNaUIsIFVzZWQ6MS4xNE1pQiAoMy41NiUpDQogICAvZGV2L3NkZCAgICAgICA2NC4w
ME1pQg0KDQpVbmFsbG9jYXRlZDoNCiAgIC9kZXYvc2RkICAgICAgICA5LjEyVGlCDQoNClRoaXMg
aGFwcGVuZWQgeWVzdGVyZGF5IG9uIGtlcm5lbCA1LjExDQpodHRwczovL2Rvd25sb2FkLmJjb20u
Y3ovYnRyZnMvdHJhY2UxLnR4dA0KDQpUaGlzIGlzIHRvZGF5LCBvbiA1LjEzDQpodHRwczovL2Rv
d25sb2FkLmJjb20uY3ovYnRyZnMvdHJhY2UyLnR4dA0KDQp0aGlzIGlzIHRyYWNlIGZyb20gc3lz
cnEgbGF0ZXIsIHdoZW4gaSBub3RpY2VkIGl0IGhhcHBlbmVkIGFnYWluDQpodHRwczovL2Rvd25s
b2FkLmJjb20uY3ovYnRyZnMvdHJhY2UzLnR4dA0KDQoNCkFueSBjbHVlIHdoYXQgY2FuIGJlIGRv
bmU/DQpXZSB3b3VsZCByZWFsbHkgbGlrZSB0byB1c2UgYnRyZnMgZm9yIHRoaXMgdXNlIGNhc2Us
IGJlY2F1c2UgbmFraXZvLA0Kd2l0aCB0aGlzIHR5cGUgb2YgcmVwb3NpdG9yeSBmb3JtYXQsIG5l
ZWRzIHRvIGJlIHNlIHRvIGRvIGZ1bGwgYmFja3VwDQpldmVyeSB4IGRheXMgYW5kIGRvZXMgbm90
IGRvIGRlZHVwbGljYXRpb24gb24gaXRzIG93bi4NCg0KDQpXaXRoIHJlZ2FyZHMsDQpMaWJvcg0K
DQo=
