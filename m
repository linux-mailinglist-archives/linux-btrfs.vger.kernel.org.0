Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C6047555A
	for <lists+linux-btrfs@lfdr.de>; Wed, 15 Dec 2021 10:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241250AbhLOJma (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 15 Dec 2021 04:42:30 -0500
Received: from mail-db8eur05on2124.outbound.protection.outlook.com ([40.107.20.124]:29420
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235889AbhLOJm3 (ORCPT <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 15 Dec 2021 04:42:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PbRRSOOzfwTg0cRBxKDmfUAB/XNbsfE+IUVKih6a8B6b/A4JxZVxs5xKnJBoATocWYwnbP2+J3KwhIhHthri+KylBPC8RaBP1URRjyZ8bjD7jafOCdRPTZyBj3+UYHLLGybmwJLbdAsqppNwCuO2Z2vEfQmjH6eVSHA2tn5NUbNlNTsl82cWgK2oHmKoAsFyALjdGtSYJZRpYWjWmo2eyzdmMJ0a0VVtXLDoRkDFIIJzYfxeTSZBt4zDRRhK6hJvBQHxHF8XzirV0qmqKFohtlxQiNtUF5rKueVKBiB/CrLAFHvMFmK/1w8yvfkohUS+Ef3GYe7dqCfNUrrAH8T6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufPn/PpY/zBctncMxN3aJYbGaG6/bewXC2kHNHPBf3I=;
 b=nvoNEGMF6Mn5afFsGQWkGpZ7gdUTmVsgnjVjZlnG3W9u9THrzXcBr1QrWjdWuXiBaM9EHdHJZl3o4hmN4+zcmkWloCSP+gG+OL9DrY+nsREHj4+J92OHRuE5o4n/Jq1FlIs94z4PfpB9EBlrGcJHmHheUyv+h0z+20HNnduw5iSvXHzEUP/Xa43wTeokj1we0rGR66w8N1JJr9EznjzI7hOdVhffRiB7wm+BPgfJ8RanMSGB0FzFntGYZq4dA/s89hJbMmdQjnQpUm3/pb3+72K5cPkelFEo2ZX7wxJbtD2zVSDGG9igL/l0JttaHBFO2TsS3yyRmjcm7WEjvUQ1Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bcom.cz; dmarc=pass action=none header.from=bcom.cz; dkim=pass
 header.d=bcom.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcom.cz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufPn/PpY/zBctncMxN3aJYbGaG6/bewXC2kHNHPBf3I=;
 b=I2LRwBbsytAryX8ZJCXoflHhQjnyOHGcTFdneJ8FR31fv5ZKWth6opUdFHcZj/QMY4Lz4r7Kwlvw9e5ZrMBy5GB6jE/q5J+8MIrm/hvgCBDWSf449mku+XqRJh6k+JgvgNeTEPzu0wwkc3my1DpGn87dsPutQRyWM9xf+GJAtDY=
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23)
 by PAXPR03MB7982.eurprd03.prod.outlook.com (2603:10a6:102:21c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Wed, 15 Dec
 2021 09:42:25 +0000
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::f4ac:e73c:4b3e:a321]) by PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::f4ac:e73c:4b3e:a321%5]) with mapi id 15.20.4778.018; Wed, 15 Dec 2021
 09:42:24 +0000
From:   =?utf-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Btrfs lockups on ubuntu with bees
Thread-Topic: Btrfs lockups on ubuntu with bees
Thread-Index: AQHX4tMAp1surAV4LE6J53J71m075qwpqUsAgABOBACAByrgAIACSC4A
Date:   Wed, 15 Dec 2021 09:42:24 +0000
Message-ID: <340ab9b906fd1b1e4fe2f0329c6be85a9958e661.camel@bcom.cz>
References: <c9f1640177563f545ef70eb6ec1560faa1bb1bd7.camel@bcom.cz>
         <20211209044438.GO17148@hungrycats.org>
         <6b1f34700075ef5256800edfe2c486fee36902d6.camel@bcom.cz>
         <YbfOXO3ZPEXLB397@hungrycats.org>
In-Reply-To: <YbfOXO3ZPEXLB397@hungrycats.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bcom.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 819d5bd2-05b2-49ab-c262-08d9bfaf3340
x-ms-traffictypediagnostic: PAXPR03MB7982:EE_
x-microsoft-antispam-prvs: <PAXPR03MB7982589DAF4379BEC92E05BA8A769@PAXPR03MB7982.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uyO1EgNbdIxdvdBnKZ3DvNyfG/jGVTbnwI2j0eIuaNSlBcAtOwDriy9JZCNaIVtjhn9MlxLTptQvS3I7PhvMJayqYkU4yzM10KMyifUTEtRFjzg8QzK0RxnkXnQxMhxgd37ZfTNu1HAXXTCnmQYqbHBK0XPOVaQATrR7QR1d515sMGfWF6DY9K5DdG869bvcrsQLke653A3pyRXZsnVhK9PgZtSdqJ8/wDAujtU+h/IXs+SsrheN5bitZ7uZmZcKzxugsEg03I0MPHjuqCZndbtDGn67gc1LOpJEWKq/9NYrflK224nPcKRPKZdxpY5giZtkr1oNpLGQdCQOeaUySUc0GsZOS1mLrF5zNdQV0s4mEMoTp9AgWuxXWi4JF/IzSslJaZ2Obko7mZizMwGWMBHMJlfqazONIwUmVu1/yi8Q7ZEH9EfkaynR3UZvm2krKuJBfMJkmMFjuFe2rLSkL7n3EwVHsCHJSSqZTh6t1A5W1wxDOp5OBIw4pSkAljSNUhcNAY5PTgrawMHEaP/oW0IQaev2a0TY3/j1SmoLRDv+ixSI+DJKB9PXti2bRWEraHtg/sztfrgIbX92L3GNAMS6fIOMDxwHrdya4k8FDLAangh86EZW/1/exwFqORu6WVF3sERLU+NO9vqSauuXkg1oknRxaxI6kmiAtkSv0UineKvjOolcZOfJK+m3vuKnDWIdKaWYj1+oFDHJkCFCJaS/LF7GdWZS7VS8q5AoBXtkMlvg8duPSize/gxltpJOJy2BCor+JJT3Zy45X05+4VDQxtNXPkNKnp8plRs7FFs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(186003)(66556008)(64756008)(76116006)(966005)(66446008)(508600001)(66476007)(6506007)(71200400001)(316002)(66946007)(26005)(2906002)(6916009)(8936002)(8676002)(6486002)(4001150100001)(86362001)(85182001)(36756003)(122000001)(6512007)(38100700002)(2616005)(5660300002)(38070700005)(4744005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MmRWYjRJOEhRclNxM005Ly95N3NsY0FFRkRGMW5CMnRtRU9JRWhxc2hrYWx0?=
 =?utf-8?B?c2gxMy96N3dqQ3o0UE42ZlVoeEVTL05KZldiV1B2S0xtZ0RpRlI0cm8wbTc2?=
 =?utf-8?B?ZmNQK3JSUEJFL05XdzMzbGpxbnNXUkpwS3VRRUtSRkpsczZ5RWxMS004VjVE?=
 =?utf-8?B?QnF2ZlFEbjEwNUcwaE9USjU1NkZNY1l4L0c3bWlDOEFnbWF1MHNFdUpEVjR2?=
 =?utf-8?B?Rm5sUEpLTGFSbzd5dTZCQ3B5VERVQVJENjFFNGZaMDZRamNnZFhZcm9WYjZ2?=
 =?utf-8?B?bmJKRndzNGV5VkxQTHdRSERDV3VYNDBMNjhoUU9oM0s1VTA2SFZyTU80czh3?=
 =?utf-8?B?YlhUTmg4L2ViVnVpTHY0M3BSMWZmODVVMWhuclh6dDg0aUF6VHpEOFpQZXJk?=
 =?utf-8?B?NlFOSFgyN3JSd0xqZTBiRDFERXhsWjZ1M0o0czh5S2EzNEc5ZXhpWjMwQk1v?=
 =?utf-8?B?QUtQTmJWMEkxM05iQzVKNzdEQVdBQ202Qkd3SmFZWnJ3R08zYUxHR0s1OXpx?=
 =?utf-8?B?dUJzSE52OGhUckJNaDNMODdSSHNtWkZMVTdVUENyZGlrcEViK2VJVkpjMndC?=
 =?utf-8?B?SXdCdVlHTE5kRnVLZXBJSmtxeE5haDhudTdCTkxDajB3cWNIeHhOZVJEK1BK?=
 =?utf-8?B?SURXMDJpTWloSFpEeTBtRWt2NS9xRnJrSUMzZnA3cjZRTE0xL3RHUlBZTklR?=
 =?utf-8?B?K1EvRHovdWtZN1R0YTVhYzN1anhBMjQrRENwRWRZSE5IVVRRMis1RzZGZUk5?=
 =?utf-8?B?UVNmdFlWdFZuSmM2cWxNa0dyc25RbzJpSXExT0YvTEt0N2JrWDRWak5pTyta?=
 =?utf-8?B?Sk5GK0RxOXhhWGRDSEUzWDNKdWs4dlBPVjBHTE9KQTFBRGl1Wkh5bzU2d1hC?=
 =?utf-8?B?QTErTENKTTYzMktMemZVbjJTb1BYS2RhYkYyakl1bCtJeXREYmNTYlFUZjJm?=
 =?utf-8?B?dzBJQVhhQTZCVVZkZDREWTIrUkZ2L1pvNXZXR0QrY1dtL1pxUFAxMFBDODZC?=
 =?utf-8?B?RWpiVy8vaXFicXNYUHphci85MnhMOUc1Y3l2b1liMjU4dTlNSUZBd1hPYkVG?=
 =?utf-8?B?d0dqYmVlV2c1eGFsN2tJOWhpMTJzWFhPelE2alpsWjRoYW9WRk1VeVhwRm5G?=
 =?utf-8?B?S3pTUjlBU3lIL2NpdGNlS1I0N1RJSU9YT0Zkd2wvcDI2emJ0bUhsdVUrYlJt?=
 =?utf-8?B?dUZGTVlxNDh3U1kwNzZYRHZFZzhNS2pMc05mTlg2WDhMMjBrTnI2YXBZa2dW?=
 =?utf-8?B?c0NFZFpCSEJLdnFvZUFCOTE5SmY4eDI0VHllZFFRMUNYVWJ0RW5wVVZmRzky?=
 =?utf-8?B?Q2RybjZ4MTUyUFRHZkhMVmRyTFN4UVlyQlVUbGJ6Qk84Q3BjMis0VlAzcTRF?=
 =?utf-8?B?b3lMZkxYSjhFUjdoMFpTU2F2Q3pNbVBEbU93blNPT1FsV2YxbC83ZUxNUWtU?=
 =?utf-8?B?Z2QxNTFuWnNFaDRYenExNDMzWit5UURyVzJDV1cxQ2pTbnNyQ1BFSy9xK1Z3?=
 =?utf-8?B?c1lKNVVhNXdwYjQvRGMyRGlseFZIZDZpSkRNdWZ6RXVJQWFNalFUam5HMGtz?=
 =?utf-8?B?UWM0SDJldVByajA1dC95NHNsS0M1VnpNREE3N09sQ2MyS1hURmoxMlZwd3lQ?=
 =?utf-8?B?Kzh1VnBudXVyZWNmdHVqMWVNdE1NY1l5c2ZOc0w3dExQa1ZoYnlPSWsyY1pn?=
 =?utf-8?B?OTlDWTlyTmEyUW43alB3dUI3YURRbnFUM01RYy8zYXIyd3NaOTBxNk10QzNr?=
 =?utf-8?B?TVNMV01LdG5IbnpJRTFlMTk5Z1Ewb3VmLzRneGU5Ylp5bGF0anRSQmFvUnFP?=
 =?utf-8?B?QU41Q1E2V0NrUHUrenhKc2ltMDM2cDU0UWVQTFVRNzV0d3V6OXo4dHVud2FW?=
 =?utf-8?B?VjBKUDV1SkNCdmVVN2RzdE1NSkd0Z1BQM3N1RmgzVHJxUmMwNkp0Qmw5Y1hF?=
 =?utf-8?B?cStkbkZ6bGp6ejZ3VmNUdVZPNUU0QTdTUEVlaHRsM1Q5SDNBNW5QOFBwYUsz?=
 =?utf-8?B?d2tFRHN4VlJKZU5VZ3MyeEo1VkowZDF6eUU2Z0RPclpXTVF1WXRWNDF2eW5J?=
 =?utf-8?B?ellYdmlQcjJKblA4MnUxL2E0bVJRRXRaRlZQdjRVcnl2cEEzZVdRQjEwbGJG?=
 =?utf-8?B?RDFCcy9kd2FVdUo4ZjV1L285cHRQclpWWThmNEZtMmxuS0cxMVNYdmlHQ2sr?=
 =?utf-8?Q?0pV7iaBUZkuz6HH45a5xqag=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1A7D9150C1398744AF59DE37BF3E7B8F@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bcom.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819d5bd2-05b2-49ab-c262-08d9bfaf3340
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2021 09:42:24.8918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86024d20-efe6-4f7c-a3f3-90e802ed8ce7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ocOiQTgifmmhxZGuKNVubDb+bywIG1Jx67q+qq+c4YF2jsvmpu6sFGZfvykOC6JcOETaEKbY19UZl6ULzweunw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7982
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQpPbiBQbywgMjAyMS0xMi0xMyBhdCAxNzo1MSAtMDUwMCwgWnlnbyBCbGF4ZWxsIHdyb3RlOg0K
PiBPbiBUaHUsIERlYyAwOSwgMjAyMSBhdCAwOToyMzo1M0FNICswMDAwLCBMaWJvciBLbGVww6HE
jSB3cm90ZToNCj4gPiBIaSwNCj4gPiB0aGFua3MgZm9yIGxvb2tpbmcgaW50byBpdC4NCj4gPiBN
b3JlIGJlbGxvdw0KPiA+ICAuLi4uLi4NCj4gPiBMb2NrdXAgaGFwcGVuZWQgYWxzbyBhdCBzZWNv
bmQgY3VzdG9tZXIsIHdoZXJlIHdlIHRyaWVkIHRvIHVzZSB0aGlzDQo+ID4gc29sdXRpb24uDQo+
ID4gR29vZCBuZXdzIGlzLCB0aGF0IHdoZW4gd2Ugc3RvcCBiZWVzLCBpdCBkb2VzIG5vdCBoYXBw
ZW4gYWdhaW4gYW5kDQo+ID4gYnRyZnMgc2NydWIgc2F5cywgdGhhdCBhbGwgZGF0YSBhcmUgb2su
DQo+ID4gQmFkIG5ld3MgaXMsIHdlIHdpbGwgcnVuIG91dCBvZiBkaXNrIHNwYWNlIHNvb24gOykN
Cj4gDQo+IERvd25ncmFkaW5nIHRvIDUuMTAuODIgc2VlbXMgdG8gd29yayBhcm91bmQgdGhlIGlz
c3VlIChwcm9iYWJseSBhbHNvDQo+IC44MyBhbmQgLjg0IHRvbywgYnV0IHdlIGhhdmUgbW9yZSB0
ZXN0aW5nIGhvdXJzIG9uIC44MikuDQo+IA0KT2ssIHRoYW5rcyBmb3IgaW5mby4gSSB3aWxsIHRy
eSwgaWYgd2UgY2FuIHJ1biB0aGlzIG1hY2hpbmUgd2l0aCBkZWJpYW4NCmtlcm5lbCBmcm9tIHN0
YWJsZSAtIDUuMTAueA0KDQo+ID4gQXJlIHlvdSBpbnRlcmVzdGVkIGluIHRyYWNlIGZyb20ga2Vy
bmVsPyBJIHNhdmVkIGl0LCBidXQgaSBkb24ndA0KPiA+IGtub3csDQo+ID4gaWYgaXQncyB0aGUg
c2FtZSBhcyBiZWZvcmUuDQo+IA0KPiBTdXJlLg0KDQpIZXJlIGl0IGlzIA0KaHR0cHM6Ly9kb3du
bG9hZC5iY29tLmN6L2J0cmZzL3RyYWNlNS50eHQNCg0KPiANCj4gPiBUaGFua3MsDQo+ID4gTGli
b3INCj4gPiANCj4gPiANCj4gPiA+ID4gDQo=
