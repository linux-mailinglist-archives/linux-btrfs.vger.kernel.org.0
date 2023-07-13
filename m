Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F7B752C1C
	for <lists+linux-btrfs@lfdr.de>; Thu, 13 Jul 2023 23:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjGMVak (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 13 Jul 2023 17:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjGMVag (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 13 Jul 2023 17:30:36 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2055.outbound.protection.outlook.com [40.107.241.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1852D57
        for <linux-btrfs@vger.kernel.org>; Thu, 13 Jul 2023 14:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l3tkAoMkaldGv/cC7LWf6PSvtSIS8OCyM/yGVpeiO+lqfe5BEVP5gl1rbFvc7Hba6n+/sx1VgYb4RPJK+Y2WQkMbconJBIRTHTwoCqWpbinI9EFj4icGDOl9kdFqtgwkZ8XfBL/YN7833HNp5oJSHrWBvG78BE9+gLB+dW7JLj9BCuDVPuFeYM7vEFQKlqaq5rfp6opya2rm4xVyT4N583+ug9zkihlEn8Av6cGC9LhroomTuzWZTgCKj29qGEvgSL6xLxW2r6WYdMjQtOUUGoimG3IRljdsxK0eKQ+c2ZUdUusKlVfYhq/ink2l+OXQDYm5XPieKRtMAuQaWXMAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29dWHbtUiMwJLSXiRr/Xa1K6cqEArNDfdNyVrX7A5hM=;
 b=oNlWuiSXJ3Q8Qcjiq3s3jSRj3xZBYyyXoWi73tVR5lIXkYpvGVCLNQp/vIaY7ntZLm92ZoQ7++49uuAtLxbunVIzOW3Ou9JFiTaftCTCQ2dGUbPaZTr3RfMhoqK9t1ACZzq5JdDmnqoYHeRE6pOeatk0wzOD9Z3mNbs6z3ihH8T0PdCKcC12Nq58oRqcf9OBnJ380ImuGeExBGa3VsQVt/loarz/2dQ5waTvIoMoNuDFjvg6/F9gY3GgseYoTON4511XguSycxMeH3uAVDwdWiQcrka9wm6vml8Z24nIBDyfF/0Gme0KBXwqKlQUAYrw2u4VVwNGLi1TM579e74/3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29dWHbtUiMwJLSXiRr/Xa1K6cqEArNDfdNyVrX7A5hM=;
 b=w82qXzDQtbqKnw7j0SocVDBvpGRgIMtn53caQLfqQ7+/k09igDEFZ33ZN3BFov18aaMZhBqTZuTHGlH+ieo91lRwbzoi/m+J3654higLTHZrLUtiDSJ0rvoGf1JjkwgjEZyAgp2rFYaRYlFSeHeuDAHbar9CEx/vGdxo+orx2h0=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by PAWPR04MB9933.eurprd04.prod.outlook.com (2603:10a6:102:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 21:30:28 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::4ca2:f40c:78b7:9d7]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::4ca2:f40c:78b7:9d7%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 21:30:28 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: how do i restore a single file from a snapshot ?
Thread-Topic: how do i restore a single file from a snapshot ?
Thread-Index: Adm1xpuMnusFXcUsRrOk6E9PcZ1TnA==
Date:   Thu, 13 Jul 2023 21:30:28 +0000
Message-ID: <PR3PR04MB7340EB61443EC55A38734D35D637A@PR3PR04MB7340.eurprd04.prod.outlook.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|PAWPR04MB9933:EE_
x-ms-office365-filtering-correlation-id: 77558e43-0d83-47ce-d50f-08db83e860ce
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5uDTw94DHgVHBXAi4GpCYnr0i9kG0FBEIkHYv+0YORcgdcuml1lPUS0298UFJdxiLrMkrfhyLircH1gU8wrtLWVochgecgGzwiqyYlFvM+Y2oxp1/Nw4ULNxdCiW7MKREMRcULDChPZxCswdxdU6FOlU9jzXeCWRXp5VB9pDVRleDrGczyvuLVZt9x7/63Di2Dr1OabF1vuGNx7s6QYkdKBdfFRcHoR62XxqD7HYB6OCiwnVMfDdFMui07ShHwXbaonYkIQ1AeMl4fRWsWF7/qDz3c2Imlp9fuigJ8Vl9EhFYGgKGn7cy3KzENq+aClLJLK4yGlwHRNuOJLpY415SXMY8zQVXb6hTvn1oknZHw9e7fF5aQoecmz6l/TMkvDl6dxDob8WnttV1jTfynrjTuBnCQA8CGH5wE5SrgoA9tC2D/nqf7gbYZpGJUeXbFlph/KWGkzUyMGOl9Mp+IJIl0qJ/QF4FYiPVLewW4WRTXxbB4CYGRgxhr4JQDLZLtqysKTRw3aBOBPb8kvqeMQ3m3CslVc3WhqrIldRQ3oISo7wWgymRL59ddv2JwQGAPaOHQ2199y37ttOQHUxtxULLPJRMZTxVPxup26lIb+zG6A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39850400004)(366004)(396003)(136003)(451199021)(76116006)(478600001)(66946007)(6916009)(44832011)(2906002)(55016003)(5660300002)(52536014)(316002)(66446008)(8676002)(41300700001)(8936002)(66556008)(64756008)(66476007)(71200400001)(7696005)(966005)(26005)(9686003)(6506007)(33656002)(38100700002)(186003)(66574015)(83380400001)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmkzUjY4cC9sNU1JSWZLU1ZVSUhJZnZERnRJMUtRMFZ2S21BWGVaMVJoUEVR?=
 =?utf-8?B?bStZa2djS3g0MlFIY3BQNFk1V0wxZ3ZzemkvMWdVTnNMTnVwbFVPdVYveVpi?=
 =?utf-8?B?WE1LK2R6Q1QyV3pVaEU2Vm9palBWWDR5ZlFwRExsTDZWUGplLzhiRHBwSTdy?=
 =?utf-8?B?NlhhcHVTYkladjNBbW5pN2xzVzRTWk4vZS9GSUh4Zm1FVXE5V2FOeHh6Z0Rm?=
 =?utf-8?B?OFVBQ1p5QXlMOEVpMXNyY05lS09SSDVNenhoSEo2aTgxVWNpTm9LM3gwR2Yw?=
 =?utf-8?B?QUhCb1ovSE9tVHFEYU1Lbi9NTjFKSkVzS0owMDNPZ3B0MFJRQTFFbHVLY3Rr?=
 =?utf-8?B?Y1JMUUtaWlowUVBxaHdNUGdhRWFld2JNaDBVbFVnQ2F4cnZlaTRyZVNGUkxt?=
 =?utf-8?B?YU1WejRneTVCdE5KRCt1Mi9RdVlHcXNJVVZwQ1llRmUyb1JkMFJIeHJOOEdw?=
 =?utf-8?B?OTh1Q0RRNGFpZ0ZIYWpycUFFRmJ0V0VMYW9oOFJXd3VuU3dWeXRVdHJkUTE5?=
 =?utf-8?B?Szh3MXE4RFhZakJxcHVncU9pb2JvNC9rWmFnQ3hYeE9YYzVtNVdWTmFhcWdY?=
 =?utf-8?B?TmlhTVk1TzdMaDZxOGxmSUMzWnN1Yjl1L0hWTDdnVWRqZ0VLaEN3QndDaXJK?=
 =?utf-8?B?M0JYeVJYRUxNZVRNcEZKbklDMlJCL1plZi9nV3FITDBZckhiRjZVTENTWUts?=
 =?utf-8?B?VDRTT1VlTTRRZ3dGQmJQbkRTSWNMQjB4OSswQnROWi91SHVvY1c5RkdpUTcz?=
 =?utf-8?B?VldiVWhkWG5YWEdmUFphWjhkRGVyNW9tOTNBWkhYdERUNVBYODQwZ20wU3I2?=
 =?utf-8?B?akF4NncvdEEyMHVER256NVFITGxqc3lHb3UvckIzQkcwSm5UejZKWG5YOVdT?=
 =?utf-8?B?QnZHN1VOSkR5L3ZPZ0RjaTFyK2RqZEk3bFpkeENwOWdlY2NOOEJiWE5qbzJn?=
 =?utf-8?B?dW1QZWlqUUZCWVdaQ1YreDh0VzNRRWR4eVd3dy9pNWViRlJieVlJTnJncnow?=
 =?utf-8?B?VXhSTUp4eXd6TjAvMkdVcUplQ3R2Mlh3U1RwcXdyWHc2dThuK1VHTWtJU1lv?=
 =?utf-8?B?M2MrWkpLVUFBR3JDNVpsQkd2b0NTRWwrcC8yUDlCMHNRZ1YrUXJDeXRzU2xo?=
 =?utf-8?B?U1V3WVRjMTR2MmFaVHZWVmxCQjhKWjRId3VtU3VVaEZwMWEwUEUzeExrUDlP?=
 =?utf-8?B?SnFpbXYzK043VVdGT3FacExtRGc1NTJXWW03RlJycytuM0NwM2g5TUpDTHl0?=
 =?utf-8?B?R3lINzE4dEZNNU9FYTlXdGZ1aUZZZGZEMm1DanQ0SmljK2FFbjNiR1RnRk1x?=
 =?utf-8?B?T3diZDE1cGFYSTB3K0hndGlKb0Zvem5BSXZCaTNXSHNpV1U3aEJZWlJicFU2?=
 =?utf-8?B?Y0h4OCtDZ2pkOVh1bnB4dThrSzg4QWxML1dtMW5weERZdG5ISzlyc3dONEFp?=
 =?utf-8?B?UHBlUG5lQWFiYm5GeTVGeEp6VncyZXRPY084QnQxTElyTTl1cWdjbzh3bjlH?=
 =?utf-8?B?S3dmaUVzclNGTlV5ckxnNVBMblgxMy9Pcmw0VWlkcnBTV0ljRlU1VzUxVWRW?=
 =?utf-8?B?ZHNia21PSTYvRlF5WlU0bWFteSs2WWFYUXBxRkJua2d0cE9OamVrMDdnWVMr?=
 =?utf-8?B?cEVSTUZGbG5VZFZKdFR0bDUycG93bzFwTWZSR2tFL0pOYytMeEhMNzlxTTJt?=
 =?utf-8?B?SXBLZlRXMExIVU9ITXoyUDJkeXJ5WWtlZ0w0alFVZDJHVkdReFIrZXp5cW9w?=
 =?utf-8?B?bWJDR3ljNmEvanFlKzM2bmMrNkxmeXhVdW5GdVJ6OFdMUXl5cy9CTkgxbG5a?=
 =?utf-8?B?UjZPU3ZiN1puRjZFcUNONlF5SUtZbFBTVHJiR0pNYjExRi9jNGxvR0pLNnBi?=
 =?utf-8?B?eGRjSHdTbmlkcXpvK0ZqY1MwRytBTWlBYmVpWFBsdnlIWWsvSGcvOERTU2h0?=
 =?utf-8?B?ZExGRXVRbWtSMk5nQVR5MTFLVUtWWDNNem1rUmhRT01XVkNDVllINXl6Vk1S?=
 =?utf-8?B?U3FGcWdIUWlNQ2VtV0lSQi9TSHpVSmNWdjNiVUJWTGpWandtNDVnbWV4RlVR?=
 =?utf-8?B?TVlxTjhaRk01eklzYmZiNlIydHYrRmNGQW1XZlBuQnFXOERPRDJ0N3ZDRFpV?=
 =?utf-8?B?Zk5aVDVHb3VITFBjSzlZTldaVnpOZ0dPODMyek5tSzFVNUtGVDd5bjJLSlo4?=
 =?utf-8?B?YXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77558e43-0d83-47ce-d50f-08db83e860ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 21:30:28.2618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QMu/0XHdh2hTq97OjyS9umgM77WIk8cc/Bs/ckCvnvOfiB3yWLzQDiukRqvtl054+XKrV4SHKLfrVU+kfFQmRcF7+nNE8rlrbXc217IjZ7jT62moyHqMMqQF4sAnBLhp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9933
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGksDQoNCmkgaGF2ZSB0aGUgZm9sbG93aW5nIHNldHVwOg0KL21udC9kb21haW5zOiBCVFJGUyB2
b2x1bWUgd2l0aCBpbWFnZXMgb2YgdmlydHVhbCBkb21haW5zDQovbW50L2RvbWFpbnMvLnNuYXBz
aG90cy8xMzA3MjAyMw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIDEyMDcyMDIzDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgMTEwNzIwMjM6IGRhaWx5IHNuYXBzaG90cw0KDQpMZXQncyBhc3N1bWUgaSBuZWVk
IHRvIHJlc3RvcmUgYSBmaWxlIGZyb20gMTIwNzIwMjMuIEhvdyBjYW4gaSBhY2hpZXZlIHRoYXQg
Pw0KSnVzdCBjcCB0aGUgZmlsZSBmcm9tIHRoZSBzbmFwc2hvdCBvdmVyIHRoZSBvcmlnaW5hbCA/
IGNwIHdpdGggLS1yZWZsaW5rID8NCkRlbGV0ZSBvciByZW5hbWUgdGhlIG9yaWdpbmFsIGJlZm9y
ZSA/IE1vdW50IHRoZSBzbmFwc2hvdCBiZWZvcmUgY3AgPw0KDQpUaGFua3MuDQoNCkJlcm5kDQoN
Ci0tDQpCZXJuZCBMZW50ZXMNClN5c3RlbSBBZG1pbmlzdHJhdG9yDQpJbnN0aXR1dGUgZm9yIE1l
dGFib2xpc20gYW5kIENlbGwgRGVhdGggKE1DRCkNCkJ1aWxkaW5nIDI1IC0gb2ZmaWNlIDEyMg0K
SGVsbWhvbHR6WmVudHJ1bSBNw7xuY2hlbg0KYmVybmQubGVudGVzQGhlbG1ob2x0ei1tdWVuY2hl
bi5kZQ0KcGhvbmU6ICs0OSA4OSAzMTg3IDEyNDENCiAgICAgICArNDkgODkgMzE4NyA0OTEyMw0K
ZmF4OiAgICs0OSA4OSAzMTg3IDIyOTQNCmh0dHBzOi8vd3d3LmhlbG1ob2x0ei1tdW5pY2guZGUv
ZW4vbWNkDQoNCg0KSGVsbWhvbHR6IFplbnRydW0gTcO8bmNoZW4g4oCTIERldXRzY2hlcyBGb3Jz
Y2h1bmdzemVudHJ1bSBmw7xyIEdlc3VuZGhlaXQgdW5kIFVtd2VsdCAoR21iSCkNCkluZ29sc3TD
pGR0ZXIgTGFuZHN0cmHDn2UgMSwgRC04NTc2NCBOZXVoZXJiZXJnLCBodHRwczovL3d3dy5oZWxt
aG9sdHotbXVuaWNoLmRlDQpHZXNjaMOkZnRzZsO8aHJ1bmc6IFByb2YuIERyLiBtZWQuIERyLiBo
LmMuIE1hdHRoaWFzIFRzY2jDtnAsIERhbmllbGEgU29tbWVyIChrb21tLikgfCBBdWZzaWNodHNy
YXRzdm9yc2l0emVuZGU6IE1pbkRpcuKAmWluIFByb2YuIERyLiBWZXJvbmlrYSB2b24gTWVzc2xp
bmcNClJlZ2lzdGVyZ2VyaWNodDogQW10c2dlcmljaHQgTcO8bmNoZW4gSFJCIDY0NjYgfCBVU3Qt
SWROci4gREUgMTI5NTIxNjcxDQo=
