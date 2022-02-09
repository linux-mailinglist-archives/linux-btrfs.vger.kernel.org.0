Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87A484AF160
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Feb 2022 13:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiBIMWq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Feb 2022 07:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbiBIMWo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Feb 2022 07:22:44 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2120.outbound.protection.outlook.com [40.107.22.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B8C05CB97
        for <linux-btrfs@vger.kernel.org>; Wed,  9 Feb 2022 04:22:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eZGpvJ44qKLwYbYlLucbZq8z3qFsuIHlP8BO74WkloqUFCSgeKiwp4lWLT/j/FP5mvbbXxLlhhXBPgJkSplTqV3yTXrd1/Cm65oFHfUQ0HRLjwzgY1S1AfuKlFiihVDJRnNlsKU6wZt88rqwykkIoO9YPZHdCQVCLWsFArTJswKin7ViZnIgp87FSaolcrbsgpGVU3hFdL+3I/jFykPdqUegxsL8lF1jr+3PDY1juLbqp+K1/S/VAWY6n/uw/T/5omOfCQKyTnRSSp4z5J6ntniYxiSvrG7hzYBCKb6oeeYF8jR9YEZVB9HNGU5RvHjggm6AogYhJu3JbLAZ8IRfTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVt2MVUnzZmiz7qmF1ZsBe0ztkQYsB6VfuJ0D+xVN/g=;
 b=YreOll046duFl28+3x8Lg2Oh9J9B148fSOjmOud4IlHCeP0giTlmXeEjCRc1lnEn+VuCNLI+iyKirVyxAJ46zRuJfAgQZrXjOdTQDK2E9y7s3Tcx5/g10g7Z8y8SzjEDv0OdYJ2Ih/vEI3m/O9ouEbpCDeZXC7LCoki4jjX4na3u0+5DKAqMpTHn+cS+/Oe4RqjIMn8MZjyJVHRcyocSgDz2IR5pCA0XYO99+96ziJTcRN+XRH4i50h+dJTiSBDqOtC1KFznpfLKASloKz3G2+A/hx44SFQWw9wh3Usvt7RSbpn9xb7y7IltFphYCNcO91tGpQipXSyOxzDDdfAedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bcom.cz; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVt2MVUnzZmiz7qmF1ZsBe0ztkQYsB6VfuJ0D+xVN/g=;
 b=XBaIrg0rp6NEVfQTCb9A9a4heOYw5QBz8PRCLymQwFbTiIEpk963duA3qdv2/IW0qzpEy3dbN/PSq4w3lQDblmO5zTmBbACvXpAUCnBL7Z62I44GELjluGaT59eNLMP6zykjizujXEhM8rAkdv5F40KTwgVqsv2kQRq1AtHUT4o=
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com (2603:10a6:102:213::23)
 by VE1PR03MB6031.eurprd03.prod.outlook.com (2603:10a6:803:109::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Wed, 9 Feb
 2022 12:22:39 +0000
Received: from PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::cc02:71e1:f5f6:9db0]) by PAXPR03MB7856.eurprd03.prod.outlook.com
 ([fe80::cc02:71e1:f5f6:9db0%4]) with mapi id 15.20.4951.018; Wed, 9 Feb 2022
 12:22:39 +0000
From:   =?utf-8?B?TGlib3IgS2xlcMOhxI0=?= <libor.klepac@bcom.cz>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: bisected: btrfs dedupe regression in v5.11-rc1
Thread-Topic: bisected: btrfs dedupe regression in v5.11-rc1
Thread-Index: AQHYA/TH12IDQclFxUCEciwCHh6TUKxsBVKAgACuOYCAHqP+AA==
Date:   Wed, 9 Feb 2022 12:22:39 +0000
Message-ID: <83f169f86c229fc63c55727a0a4e12a110a5b5e5.camel@bcom.cz>
References: <YbfTYFQVGCU0Whce@hungrycats.org>
         <fc395aed-2cbd-f6e5-d167-632c14a07188@suse.com>
         <Ybj1jVYu3MrUzVTD@hungrycats.org>
         <c6125582-a1dc-1114-8211-48437dbf4976@suse.com>
         <YbrPkZVC/MazdQdc@hungrycats.org>
         <ab295d78-d250-fe8f-33a5-09cc90d5e406@suse.com>
         <Ybu4tuzqpaiast5H@localhost.localdomain> <Ybz4JI+Kl2J7Py3z@hungrycats.org>
         <YdiG6xYbY0tZ21j9@hungrycats.org>
         <bc677ef0-ea1c-5f8f-f225-4d3f4f3d3459@leemhuis.info>
         <Yen+CTCm+wbdJnJk@hungrycats.org>
In-Reply-To: <Yen+CTCm+wbdJnJk@hungrycats.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.42.3-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bcom.cz;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a977ebd-196f-4820-256b-08d9ebc6dd0f
x-ms-traffictypediagnostic: VE1PR03MB6031:EE_
x-microsoft-antispam-prvs: <VE1PR03MB603173EA5843F765701673E18A2E9@VE1PR03MB6031.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vwZoItlTQ+tk7wN2gZKooEoPJS7DlWQRh7i/QaxaaZiZwW0hCAFAVHmjF3hubABu6OhtQQ5uOJHptYnOouT9r7e2BOLQSc0J2Gr7AgJfWnmkDb/gMS7lEK9kIdwD5kp7ta/TNqwjTdvo3boLDmq5kwTpMLxMKPP4rHr+C0Ds+IJFZTAZeZFzITcmNNrK01s1wONg/v/+CTtc1H8+7MPqyzlQgLHGi5+yz3K17rAQcolqXbLekRkTOOO0DnK6wiECLyiOplep34Ks1Oy4Tz+DdxoKTC6Zz1wV1e/nZviIPJZZDmza2AXU5iLiAf8QVhsRK7YiSBDpOxPMBvxbie6MgE5AUH/4h+GKd2lY4oaHSn4ymbCrE29VPxpbzogCpVfQRS+rzRsrdKllN6YiACDNVdgSFM8YKGVxx01dc/+UnaSJY4f/zhHAsFOIbF2vDNY7T/DJTx6niDa95iGPVMLTQ4svb0RdPpZO/aJ+zbfqqnf3iTeX0VklX751z3GOHcCoBX5Dyqoa2MjhPoXfZ9rKzmIHI2GM37ryolGdxjZnfRfM10FIWUVBndg+sFya6xRyG43nL7NYuCY6GKtt3annG7PwzTfcWf2cIHFRmJAvEDQpnXgfMtfIOKdpYHMlfa/0VF+/Y0z6y7UsofNdovizX53md+q4ckD24jEshQVUJWuRe5pjiS7re7Oq4euKURteLR5OmHN/Kf9j3tjn6FWybA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR03MB7856.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(376002)(39840400004)(366004)(136003)(396003)(346002)(6486002)(2616005)(38070700005)(5660300002)(38100700002)(8936002)(26005)(2906002)(6506007)(6512007)(86362001)(64756008)(186003)(66946007)(66446008)(85182001)(76116006)(6916009)(316002)(558084003)(36756003)(91956017)(8676002)(66556008)(66476007)(122000001)(508600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkdrR2d5S2xsUktwcy9OdnVZSVVCTXloL0lvdHU0L1pYMFhockljRmMvTDNr?=
 =?utf-8?B?R1RPWVRQYWtscExhdk5VNml0S0l1UE8vd0QvSlgvTXFKb0liR3FGTHVwSitl?=
 =?utf-8?B?SHVydWtqSGlaK09kTzkrQzhvTllsSE1oSjBNMEdZa1p1alR0Yy81NlBDM1pi?=
 =?utf-8?B?WnJxVzlFT0VUV3BpMVlFekRSMVNmTWxNVFVCTVdCdnYvMVhEdnoraHRzT3JI?=
 =?utf-8?B?WElwN1RnY3FCc0FBQ29Gbk55OVZOMlBselRzcHFCNGc2MENvdy9jK0FjdFlD?=
 =?utf-8?B?NDkwK1ZXTUJ2Ylh3dytHd3EzUWhCSVhPK25jWFRmbW81OGhud3pndWtJREs2?=
 =?utf-8?B?M2lycFFDaEZkSkQvU1JhZG5BU29WM2tqQ2JpQko4cjdNbC9WZDEydlg2RklR?=
 =?utf-8?B?RUh4ZDgzMGNsZHJGMWhQNFowQUt5UzRTNHVSSzc0M1FlTitrS29MWFhwbGZt?=
 =?utf-8?B?Nkx1WTU2UmFLOElSbjFwaFZTOENHK2JlUnAxcDFuaGt1K3VTVVp6UkdITnFh?=
 =?utf-8?B?SUVoNUFWajFUZTBjZG1UdCtUQXVNdEowejBndzhtZFpGOG53NzM1MmxpWjV5?=
 =?utf-8?B?Y1Z2WWJuRkZON3FzWTNWeUVJYmdxaWdUNGtGbFVWQ0RFWHBoSlhXeWV6SG1v?=
 =?utf-8?B?ektUWlBVaGJOY3FhVUZGWmRvVWo0UEw4WTFQTjlmSmJIaU0rQU9QRjZKOU5I?=
 =?utf-8?B?Y0JvcjhkVXNjcHlnZFhldHlqQ3JIbHIyVnA3MzVKdm5CYWxRL3ZHZGRKTU5u?=
 =?utf-8?B?ZlE1MTZpUC9KeDVDbGk0clAxSUo4MTJpVEtWcFowdDFQNXNPaXpHSFVMb3FM?=
 =?utf-8?B?dWdrVUZjd0R1MFI1bEVud2VqRTVTZFoyT2tZQXZqNDhIemdYWHR4UGhLQnBS?=
 =?utf-8?B?aGlreGRJaERxek5wYzN4bjJOZzRJeTBDa0loWUNvMFk4U01KekNwc1gvSW1E?=
 =?utf-8?B?bTlYTmdhbXpxMi9CZzlDWUlCYnR5NFB5ZTlUVkRIMm1Ucml4NWpPUzZUVk1I?=
 =?utf-8?B?QzFhZDRSUzZOcURJZG1BN3lIRVdKbThVTUFQZUdXNDFhaDE0aWJqdmcxT0hv?=
 =?utf-8?B?QlNacWQ4dXZpLzlFRkdKOFBGbENNV0laQmxVRW01dEVqaUVhbE5mY0EzdThY?=
 =?utf-8?B?NU9OdFBucVFldVJaekRteUd0Rms2bnFWWDN2M2hhUGpRRmNzU0tkK2J5UW83?=
 =?utf-8?B?LzhKa1kwUXZRMW1sRExFMFd6dU1ORGdyMHZUL1NaMkxscDdTTmJMZmtuRVlt?=
 =?utf-8?B?YjNSUFlUK3Z6ZHdhbFJKc09OK2xVMi9EMmM0cDk4RE1wWWRHN0tkRnlDZmdo?=
 =?utf-8?B?cGVRd3pSSVBlaUFLRlVqWFFoa05hQmdUcVBzRUMraG1BWmJLWGNVMTJhckRL?=
 =?utf-8?B?Q0hPNHp2UzNZNzAzcDMrb2FFbW1uMVpsVks2RVRRWU9xdkVZeTdqWWJnWFJ5?=
 =?utf-8?B?bW1GVmRVSG53SDE3T0M1MWZ1Z0ZRRFVtNHBodlhQUXRLK0FBdkcwTVhaV3lu?=
 =?utf-8?B?VjU0bXhOYTUwWkxlMWlvYVAyRCtOL2NObmkyKzlnTmxlVmgvTGdoSlpHQ3JI?=
 =?utf-8?B?UEFvcHdiRVA5QTJLeDR6VzhsYzhHTEtYM3JXY1NPMWZlUU9DNUJBdmdBMzho?=
 =?utf-8?B?NG9uUTFjSlpWUXFvUGZXU0oveXlXYWhEbk1OdUJsTTQ3TElhdGI4QnNpYUxP?=
 =?utf-8?B?MDhwZVkrU2Y3alM3aEVnOVN5eUo3ZThuQTY2QW83ZjgxVW9ycWlRS1Q5UXM1?=
 =?utf-8?B?LzRsUk5BVlYwQ09hb0V2UnZRV2QzSGR1TUVyazl2WE5Ha3ZrUms0SU9aQ2V6?=
 =?utf-8?B?UmNqL1JqNURlUEE0bmlJUFJxdXhsWVMvT0U4MVRpcTRuOVM2SnAxRkdTMTJE?=
 =?utf-8?B?QjNscmk5Vy8vYUVDQ3hDZTI0cUVkd2IzeWdXaWlVcWhscWxaUlF1RVQ1Z3hl?=
 =?utf-8?B?TmRoTkpWWFpPS01hQm1jaC9vdDh6SGJIZStsamZDaXUveENuMjZBV2VKOG01?=
 =?utf-8?B?Ylpob1RyZHYvZjAzOGhUYVVTV09pem1TNnhJVmxsYklNRHJZcFNxQm5FWHJm?=
 =?utf-8?B?dlpsNVJFZGQxYi9DaGNvTkFvUC9oMGVBZVl0SThhM2I0akw1b3dtcFFxbklT?=
 =?utf-8?B?Sy9Za2M0cktBUVUySXVVZ05wMFRad1ZqeE9ZQklJQ1V0OCs4cGc1OWh4UHgz?=
 =?utf-8?Q?QXD35ED7El57Q9nV0Cu1CF0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FC20042346CEB4082715F6BA2277072@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bcom.cz
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR03MB7856.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a977ebd-196f-4820-256b-08d9ebc6dd0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 12:22:39.3664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 86024d20-efe6-4f7c-a3f3-90e802ed8ce7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PjwCjqiHLpyA7NPTCs9f/erClaBaYMEK6I8cY0m65GnUsvszKjjdHPxoM2uue0cqr8EDXRSmhxIi5QlKdu2ViA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR03MB6031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

SGksDQppcyB0aGVyZSBhbnkgcHJvZ3Jlc3Mgb24gdGhpcz8NCkNhbiB3ZSB0ZXN0IHNvbWV0aGlu
ZyAoaW4gbm9uIGRlc3RydWN0aXZlIHdheSA6KQ0KDQpUaGFua3MgZm9yIGluZm8sDQpMaWJvcg0K
DQoNCj4gPiANCg==
