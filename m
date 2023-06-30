Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 382B17438CF
	for <lists+linux-btrfs@lfdr.de>; Fri, 30 Jun 2023 12:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjF3J76 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 30 Jun 2023 05:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbjF3J75 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 30 Jun 2023 05:59:57 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2051.outbound.protection.outlook.com [40.107.14.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E183A90
        for <linux-btrfs@vger.kernel.org>; Fri, 30 Jun 2023 02:59:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RGNNP+uSwLAqlbLDEvSHnyfQLyPYTADVOyNiMTAGn3xZJ4W2wuZfGzJjZdpk4Fws5Drak7EjckG2OMcoyIBUOUJ8XW+ff7NrILOTGofmy61Bs4gtnxWShGOEsdTgUpRFu7Z23AjaHbgm7p0NTkNC2kf42WtnMaTTF6vggieFFtNzZ4Lgg/dDLkq0RC6B+pwO1UZCoHJ18MdvymtiQHF0aHzSD5yNhAiYVscRwjeMB4HoZ1BKk3PYp0g3jPRqVl/0t+8ycNd/OLZiFbhGvDZMEPhRvCRrcFA7qe2M4wnakmFjmg12N4tE0ODZ6OV0DJGLZbKK8Mynh116F4nuk27TiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BZl0Sl7mtk6NXIbjUP3wW2Jcfazu4+u5HFIyGEuKpE=;
 b=CCUhcWaJ/Ku7Fpc8gPhC61j6qGM09SqaJdx+9KQ8jwkxEzF8QIAzTNogM9cJvoO0dQjjcuEU/pX5Uipb3jWWvTC6ydGFJdfcL5fbFhGAWKljzvZyYf6zT5UsN22OljiPwCeWzKjoqI1Kjv91gR/8LHgEKDY7DYm2O6jlcpg3k8i9/SDFzpifTh/DC8R2M/zYQIUDHJ8D6ELDCn5KLVW9S/52OqVyuQYMpGfv06+zVG1Hu5QyVUURKCsxwhr0/J+MwFN8WuT6CnVQ/FbbhK5oA86+uShRnoo25LoLl1nShsFs9dhvdCjN2bq9dKA6hMvYNVmNdxyaNA+vB3Ir0uPoMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BZl0Sl7mtk6NXIbjUP3wW2Jcfazu4+u5HFIyGEuKpE=;
 b=fc7dRF690H7WRFU0PyCdQ2sjRJAn07aJrK0nsuhfgYsFFZovdm2Blx9G4FQtWHwevXPFHxz/vsx9374mk6wWz5tN69aLHXKqg+MLh2BLyOXD27y6xdLct60uGIOoAyxAwkmirNFGUiq4RKzl9HBx1lKL6QC7DncbSW4UN7yqlR8=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by AM8PR04MB8019.eurprd04.prod.outlook.com (2603:10a6:20b:24b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Fri, 30 Jun
 2023 09:59:47 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::12db:4e1b:18a4:b778%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 09:59:46 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>,
        linux-btrfs <linux-btrfs@vger.kernel.org>
Subject: RE: question to btrfs scrub
Thread-Topic: question to btrfs scrub
Thread-Index: AdmqYWxcqzByINPHTMyzVF+8SQB2BgAB8fyAAA4C3wA=
Date:   Fri, 30 Jun 2023 09:59:46 +0000
Message-ID: <PR3PR04MB7340BD6CD63180053CCA023ED62AA@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB734055F52AB54D94193FA79CD625A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
In-Reply-To: <8a3d7ad6-0ddb-3160-eece-8d6228b9c0a6@gmx.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|AM8PR04MB8019:EE_
x-ms-office365-filtering-correlation-id: 6c120717-9543-45d5-934a-08db7950bc5e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lH/PZ9CAimC8ON+6a6r5hlqJ9YcdmELxHU80kncJ7vE4zQuOHPWisWV7H0iS1TS/iAO+V5tuZhSPgK2Hve73AqQSM69e+H2u3QH0t067lnBRTMce+5KWYGCwWzRpjBSUsYenibVkBAGyYWZe7DSeSeECP/Mz09QGAiE1408otU4VsfTh5DpZkuTx2+yXRD7me/rWYxqo2x4wAaSoZ/dQq6m355mJxX5R5Bo7iJoG1AoPtBD7eXfSJ/SXccElsxCDYwDREsJzvJ6BPNIMUeKeD/dTpnQOW88bD1IV4RasUFCWI7VEQesNbamEjdI41/GnutVZox+i4VJDSWJfSchGvfUU2gUWovw19r1fYSkc4ejepmsMPvGXrU3+XF5eK3aE/aV6Reu41VCXQP5BMIJx5kFGBHLruCNvr3Ie20JEwbigoItIWcFTtpBlhbqfXFsHCFymujfCg9VVR1ir9ONQKvil1Dbyb3862h36jbVS4zWCg5hZqtBZKMcO4HFRaP38QSR6n8zxtt470gd0PQPOnzTJuRB8mitjGQPtVK1YyUARcasbHwTOkYIocC9tqrqTfvR+7FGYd3b+Og8QPw2ybybkADrSgftIlTe9QHJrtW4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(451199021)(38070700005)(86362001)(478600001)(55016003)(110136005)(66556008)(66446008)(66946007)(76116006)(66476007)(71200400001)(83380400001)(64756008)(316002)(7696005)(2906002)(966005)(41300700001)(38100700002)(15974865002)(33656002)(3480700007)(186003)(122000001)(8936002)(8676002)(52536014)(9686003)(26005)(53546011)(6506007)(5660300002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjUyU1VUUGJqZjZxUVA5QngvNytEUm5ldjh4WmgyRnZjMHdod2dNTWNqLzJq?=
 =?utf-8?B?MWRITW9pM0NzeVhOQkJiM0p6UXQ2Sm9HeGtlSkpkV3Y0UXZEM3J1em1ocVV5?=
 =?utf-8?B?c0tQV1ZIM0xCdXVzdmYzVEUwRkI0di9TbzNzdmlNNEsxNUVvbHVtKzFTRjJn?=
 =?utf-8?B?MkdWSHdjaktaS09IdG0vSmZUTWpCMXVVUDVjc0lTZUJkZk5xbkxmc3RDRys5?=
 =?utf-8?B?dm9FWFcvR1NvS0V1dGh6RCtTdkZTZzNrYVBSZFg4UllEUjJLc1l1QVk4M0t1?=
 =?utf-8?B?bVNTazY5R2JNS3hHanpIU1hOWUFUU2dPOWJucGJqT0MvUXRWUUpaOGhGQkd5?=
 =?utf-8?B?Z29JUnlEdVFkZk1PRlRqeDc4dW8wYlBHams4eHlDaTVmWW5xT0t6b2JoRVN2?=
 =?utf-8?B?UmRYUll5dEZsS1lnNjdzOElLaGZDWWJRQ3BoNTg5RG9VY0cvWDB6L0FtRktR?=
 =?utf-8?B?RUhqMHZFQTh0Y1VuK0RkUGdIUG0rc2ZZU3IvWW9pK0xkK21iY0xSUHBVTWlu?=
 =?utf-8?B?OVNkcTNKWXViQkU4NHNsa2x4MkZLSm1oQ20wbVB2SWl2ODNIT0E1NGc5NWdZ?=
 =?utf-8?B?S243NzFYdUU1VXp2TGMrZFpGZDk0NDViUE05eEp0N3d0R2JXeEMyaUxBQjN4?=
 =?utf-8?B?MTlvVjk2cWx0SkIwUlZKL0x5U01SY1ZQSkllZG5oUEQ4RkZQWlpYQXh0U2lu?=
 =?utf-8?B?Y2xNMjdTb3BxQ3V6SDhvNlJqY2N3ZmIxbnl0ZUhnWERJZkc5NmwzeVduYzJ3?=
 =?utf-8?B?M1kyRHVhMUttdHA3OGI4ZXROMnB1a1E4Mmd2bmFUeENUN21UclJ5UmZZSXUz?=
 =?utf-8?B?eis2d3AvTkw4UHp0aFpxYmYwa0s1ZUZqNUpjMHdTRUU1a1l3K0wraWUrbFdI?=
 =?utf-8?B?Q3VtR2R6WFNFRE9tekV1d3JPNDY0OXlUcWo0TnZMdDFFOXNMbXg0NXp6WUNn?=
 =?utf-8?B?WkZYU29iR0k0S1ZyejBTRUQwenRrQm9GbGE1aHlNckV1SEdCK29oTG1uVFhP?=
 =?utf-8?B?T2xpaU9TaStxbCtjdk9TQ1JJbm53Zm5meDlNNXVWODVQYk9VRVpWYkE0V1pr?=
 =?utf-8?B?T0dNRkJ3TTlCSjVLaDVkbnN6Q2FORzJ2RFF1Wmp1M0xmcjkyL0NjNkdROUNK?=
 =?utf-8?B?ajBBUGx5S2U1ZW45Uk5sQ2N1SkhJVjgwWkJoNzBpZks1WmUzK3puelN0WmVX?=
 =?utf-8?B?REJRWWNxa2MreWpIbzdJbDNRL2lvYlVZMG9aVkJoeGJKTE0zS2E0b05kSG1X?=
 =?utf-8?B?MHNnc3kvQWlwZVlkY2ExcldNZForUWo4eURwb3JGT09xenFpTCthOWpMWWNP?=
 =?utf-8?B?WVBkUzlWUnZ6cjc4bXVEdFJYZFdQRnlZcjZVVFE5Z21GOXRkL2xRbW8wa3dV?=
 =?utf-8?B?djdSeUZiQU9JNmdldjJwK3hIdFFOYUNxOWExVlpNVnpacXJVc3BJQmJuSkpH?=
 =?utf-8?B?UnRXMkVTckxhQnZuc0k2OGh1TWVqUFpONjQzZUQvOTg1SkFTbWlCT2R0QlJW?=
 =?utf-8?B?OXlHNFVkb1lnd0ZraXJjaEJWYVZPajM0cHpLWllmRVZzUTFaRE1BQWd3ZFZt?=
 =?utf-8?B?ODBheGhiY2tsVjZwUlgwZmZQRjUyd1lDNXlyWjM5K1pId0l4dVIyRUx6VmJM?=
 =?utf-8?B?c3pLRzAvL2hsamprOWNOTEdGbUp1MHJKbktaenU4bVhyZ3ZGUStEM0MvT2RT?=
 =?utf-8?B?YkZXZ3Azd29vdnZXbk83bHR3eHo1UmJuWWozN3JVMmJZWURwd2JuZFJFRXJ4?=
 =?utf-8?B?VDdMaVU0Si91NlYxVnJhRmMra1pEcmVxdXJKTDhaaUxueHpQSXFKRkRERFBt?=
 =?utf-8?B?UzRCYlZkWC9NNlNGVHVieWJGcXJMWGtnbGo0MDBySFVOMVVyck1OYWVSbTNK?=
 =?utf-8?B?bUc1cGcybGlFZ2hSMmZOYnBja0NmaVZseUFnSGRJOWdBNjhVY3JTQnp2NUlv?=
 =?utf-8?B?TkR0N0ZYd1NTaEdzYTArMGoxYnVnYTVkTHJseTZ2N3J4bi8vKzJ5cmVta1RO?=
 =?utf-8?B?TUVUMndIbkc2QVNSNExvUHdJSWl6ZkxQdnBDWEM5NURYcW5jN25VTTZSYXd5?=
 =?utf-8?B?RzBDemN0MDEyQlpVQ0hrck9WeVJ0R25LSVhWNzNweHdwc0ZjN3hKVkJtZUM3?=
 =?utf-8?B?aS9PbVdZa09QMU5vdUxoanJqTm1WSU9UNFBiVUg2ZWlUdEQ0K25nckJ1djl3?=
 =?utf-8?B?TEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c120717-9543-45d5-934a-08db7950bc5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 09:59:46.7434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvII5QbvldKCfO4xjC94PnMP4JLrzWblZAgZzFjxzVCoQHIdQFGiYjOSZSlEqkWRAxGw36rVimMpbwAOWp5kIEscy62P33T/eCTRTi7+LvTe4Yb6CN0PT2sQmFJLC1DD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8019
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFF1IFdlbnJ1byA8cXV3ZW5y
dW8uYnRyZnNAZ214LmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEp1bmUgMjksIDIwMjMgMTE6MDgg
QU0NCj4gVG86IEJlcm5kIExlbnRlcyA8YmVybmQubGVudGVzQGhlbG1ob2x0ei1tdWVuY2hlbi5k
ZT47IGxpbnV4LWJ0cmZzIDxsaW51eC0NCj4gYnRyZnNAdmdlci5rZXJuZWwub3JnPg0KPiBTdWJq
ZWN0OiBSZTogcXVlc3Rpb24gdG8gYnRyZnMgc2NydWINCg0KPiAtIEtlcm5lbCB2ZXJzaW9uDQo1
LjE0LjIxLTE1MDQwMC4yNC42My1kZWZhdWx0DQoNCj4gLSBTTUFSVCBpbmZvDQpoYS1pZGctMTov
bW50L3NkYzEvaGEtaWRnLTEvaW1hZ2UgIyBzbWFydGN0bCAtVCB2ZXJ5cGVybWlzc2l2ZSAtYSAv
ZGV2L3NkYw0Kc21hcnRjdGwgNy4yIDIwMjEtMDktMTQgcjUyMzcgW3g4Nl82NC1saW51eC01LjE0
LjIxLTE1MDQwMC4yNC42My1kZWZhdWx0XSAoU1VTRSBSUE0pDQpDb3B5cmlnaHQgKEMpIDIwMDIt
MjAsIEJydWNlIEFsbGVuLCBDaHJpc3RpYW4gRnJhbmtlLCB3d3cuc21hcnRtb250b29scy5vcmcN
Cg0KUmVhZCBEZXZpY2UgSWRlbnRpdHkgZmFpbGVkOiBzY3NpIGVycm9yIHVuc3VwcG9ydGVkIGZp
ZWxkIGluIHNjc2kgY29tbWFuZA0KDQo9PT0gU1RBUlQgT0YgSU5GT1JNQVRJT04gU0VDVElPTiA9
PT0NCkRldmljZSBNb2RlbDogICAgIFtObyBJbmZvcm1hdGlvbiBGb3VuZF0NClNlcmlhbCBOdW1i
ZXI6ICAgIFtObyBJbmZvcm1hdGlvbiBGb3VuZF0NCkZpcm13YXJlIFZlcnNpb246IFtObyBJbmZv
cm1hdGlvbiBGb3VuZF0NCkRldmljZSBpczogICAgICAgIE5vdCBpbiBzbWFydGN0bCBkYXRhYmFz
ZSBbZm9yIGRldGFpbHMgdXNlOiAtUCBzaG93YWxsXQ0KQVRBIFZlcnNpb24gaXM6ICAgW05vIElu
Zm9ybWF0aW9uIEZvdW5kXQ0KTG9jYWwgVGltZSBpczogICAgRnJpIEp1biAzMCAxMTo1MjoyNiAy
MDIzIENFU1QNClNNQVJUIHN1cHBvcnQgaXM6IEFtYmlndW91cyAtIEFUQSBJREVOVElGWSBERVZJ
Q0Ugd29yZHMgODItODMgZG9uJ3Qgc2hvdyBpZiBTTUFSVCBzdXBwb3J0ZWQuDQpTTUFSVCBzdXBw
b3J0IGlzOiBBbWJpZ3VvdXMgLSBBVEEgSURFTlRJRlkgREVWSUNFIHdvcmRzIDg1LTg3IGRvbid0
IHNob3cgaWYgU01BUlQgaXMgZW5hYmxlZC4NCiAgICAgICAgICAgICAgICAgIENoZWNraW5nIHRv
IGJlIHN1cmUgYnkgdHJ5aW5nIFNNQVJUIFJFVFVSTiBTVEFUVVMgY29tbWFuZC4NClNNQVJUIHN1
cHBvcnQgaXM6IFVua25vd24gLSBUcnkgb3B0aW9uIC1zIHdpdGggYXJndW1lbnQgJ29uJyB0byBl
bmFibGUgaXQuDQpSZWFkIFNNQVJUIERhdGEgZmFpbGVkOiBzY3NpIGVycm9yIHVuc3VwcG9ydGVk
IGZpZWxkIGluIHNjc2kgY29tbWFuZA0KDQo9PT0gU1RBUlQgT0YgUkVBRCBTTUFSVCBEQVRBIFNF
Q1RJT04gPT09DQpTTUFSVCBTdGF0dXMgY29tbWFuZCBmYWlsZWQ6IHNjc2kgZXJyb3IgdW5zdXBw
b3J0ZWQgZmllbGQgaW4gc2NzaSBjb21tYW5kDQpTTUFSVCBvdmVyYWxsLWhlYWx0aCBzZWxmLWFz
c2Vzc21lbnQgdGVzdCByZXN1bHQ6IFVOS05PV04hDQpTTUFSVCBTdGF0dXMsIEF0dHJpYnV0ZXMg
YW5kIFRocmVzaG9sZHMgY2Fubm90IGJlIHJlYWQuDQoNClJlYWQgU01BUlQgRXJyb3IgTG9nIGZh
aWxlZDogc2NzaSBlcnJvciB1bnN1cHBvcnRlZCBmaWVsZCBpbiBzY3NpIGNvbW1hbmQNCg0KUmVh
ZCBTTUFSVCBTZWxmLXRlc3QgTG9nIGZhaWxlZDogc2NzaSBlcnJvciB1bnN1cHBvcnRlZCBmaWVs
ZCBpbiBzY3NpIGNvbW1hbmQNCg0KU2VsZWN0aXZlIFNlbGYtdGVzdHMvTG9nZ2luZyBub3Qgc3Vw
cG9ydGVkDQoNCmhhLWlkZy0xOi9tbnQvc2RjMS9oYS1pZGctMS9pbWFnZSAjDQpoYS1pZGctMTov
bW50L3NkYzEvaGEtaWRnLTEvaW1hZ2UgIyBzbWFydGN0bCAtVCB2ZXJ5cGVybWlzc2l2ZSAtcyBv
biAvZGV2L3NkYw0Kc21hcnRjdGwgNy4yIDIwMjEtMDktMTQgcjUyMzcgW3g4Nl82NC1saW51eC01
LjE0LjIxLTE1MDQwMC4yNC42My1kZWZhdWx0XSAoU1VTRSBSUE0pDQpDb3B5cmlnaHQgKEMpIDIw
MDItMjAsIEJydWNlIEFsbGVuLCBDaHJpc3RpYW4gRnJhbmtlLCB3d3cuc21hcnRtb250b29scy5v
cmcNCg0KUmVhZCBEZXZpY2UgSWRlbnRpdHkgZmFpbGVkOiBzY3NpIGVycm9yIHVuc3VwcG9ydGVk
IGZpZWxkIGluIHNjc2kgY29tbWFuZA0KDQpTTUFSVCBzdXBwb3J0IGlzOiBBbWJpZ3VvdXMgLSBB
VEEgSURFTlRJRlkgREVWSUNFIHdvcmRzIDgyLTgzIGRvbid0IHNob3cgaWYgU01BUlQgc3VwcG9y
dGVkLg0KU01BUlQgc3VwcG9ydCBpczogQW1iaWd1b3VzIC0gQVRBIElERU5USUZZIERFVklDRSB3
b3JkcyA4NS04NyBkb24ndCBzaG93IGlmIFNNQVJUIGlzIGVuYWJsZWQuDQogICAgICAgICAgICAg
ICAgICBDaGVja2luZyB0byBiZSBzdXJlIGJ5IHRyeWluZyBTTUFSVCBSRVRVUk4gU1RBVFVTIGNv
bW1hbmQuDQpTTUFSVCBzdXBwb3J0IGlzOiBVbmtub3duIC0gVHJ5IG9wdGlvbiAtcyB3aXRoIGFy
Z3VtZW50ICdvbicgdG8gZW5hYmxlIGl0Lj09PSBTVEFSVCBPRiBFTkFCTEUvRElTQUJMRSBDT01N
QU5EUyBTRUNUSU9OID09PQ0KU01BUlQgRW5hYmxlIGZhaWxlZDogc2NzaSBlcnJvciB1bnN1cHBv
cnRlZCBmaWVsZCBpbiBzY3NpIGNvbW1hbmQNCg0KU01BUlQgbm90IGF2YWlsYWJsZSA/DQoNCj4g
LSBIREQgbW9kZWwNCmV4dGVybmFsIFVTQiBTZWFnYXRlDQoNCj4gSUlSQyB0aGVyZSB1c2VkIHRv
IGJlIHNvbWUgYnVnIGNhdXNpbmcgY3N1bSBtaXNtYXRjaCwgaWYgaXQncyBhbGwgaW4gb25lIGZp
bGUsDQo+IHlvdSBjYW4gYmFja3VwIGFuZCByZW1vdmUgdGhlIGZpbGUsIHRoZW4gc2V0IG5vZGF0
YWNvdyBmb3IgdGhhdCBmaWxlLg0KYnVncyBjYXVzaW5nIGNzdW0gbWlzbWF0Y2ggLSBVYWFyZ2gg
IQ0KSG93IGRvIGkgc2V0IG5vZGF0YWNvdyA/DQoNCkJlcm5kDQoNCkhlbG1ob2x0eiBaZW50cnVt
IE3DvG5jaGVuIOKAkyBEZXV0c2NoZXMgRm9yc2NodW5nc3plbnRydW0gZsO8ciBHZXN1bmRoZWl0
IHVuZCBVbXdlbHQgKEdtYkgpDQpJbmdvbHN0w6RkdGVyIExhbmRzdHJhw59lIDEsIEQtODU3NjQg
TmV1aGVyYmVyZywgaHR0cHM6Ly93d3cuaGVsbWhvbHR6LW11bmljaC5kZQ0KR2VzY2jDpGZ0c2bD
vGhydW5nOiBQcm9mLiBEci4gbWVkLiBEci4gaC5jLiBNYXR0aGlhcyBUc2Now7ZwLCBEYW5pZWxh
IFNvbW1lciAoa29tbS4pIHwgQXVmc2ljaHRzcmF0c3ZvcnNpdHplbmRlOiBNaW5EaXLigJlpbiBQ
cm9mLiBEci4gVmVyb25pa2Egdm9uIE1lc3NsaW5nDQpSZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJp
Y2h0IE3DvG5jaGVuIEhSQiA2NDY2IHwgVVN0LUlkTnIuIERFIDEyOTUyMTY3MQ0K
