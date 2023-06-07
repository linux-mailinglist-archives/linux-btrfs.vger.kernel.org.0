Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DE2726E9D
	for <lists+linux-btrfs@lfdr.de>; Wed,  7 Jun 2023 22:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbjFGUvi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 7 Jun 2023 16:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234797AbjFGUvf (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 7 Jun 2023 16:51:35 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2073.outbound.protection.outlook.com [40.107.21.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71ED2116
        for <linux-btrfs@vger.kernel.org>; Wed,  7 Jun 2023 13:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SMzs2NSzvpgnGjAWpzuVWsZrRY30wxR4uQABktaBvSh5HWbVIYHo1B4Am0nXhErSqehZycZ6T+9la/0+V8VZGszF2cyzMJU+TSsTcf867LQUiNJzOa/4SomWhNLh8/QaUKdvFqp25ocPDZ1RN1nrmo+OrDcWn8sKiTROzEgxlDS1tBH+z7GEWmcn6vbRIrxOpX4xvJXUFmEX5KApKVISQ6Hm9WYlMA1j2B2J7/8FWnCIoUCcqx6skT9J5Bbt3yqJPovEidv2xNe2NEmwoYb+0uxnglntyYGX6NjmX3yqVantXYCCS757z8jpc0JAathx3ORaAeTeaNfy6AVJG1vUuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usMowqpUju89ezY2Ty/lS1dZsmvRta8teiQKzvgAXvM=;
 b=YTKdG8fvgaACmY57R+16iEpN8Y217spsatcOY6Qm4/wAXsRGMJ3JFqXpr6xUHSzgWPLWDqMEV/FyYizQxG45P4HsIM8qOtVxwKKghBxN/IsuOcABRAIxoLTeDy0T7YI5E+wcdhfl+DsyyIb+2yQfbMhfDBDvT0M6mlupDkX9n6FSiqHrYx+eAy9/pYn50Toj29dkB4MdjI1McVXc7jaWyA08XOPR0gruNKgwjCL7uOqd5vgddPJyX4UxrOpppYrnc5V2PiDhKbNbMUyk6OmkMklGKq3nFbcNSKl265emEi/cXNiTn4bHSzKOKEgX7SZ3sYLMn3ds2IOeYwUrw8Z8TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=helmholtz-muenchen.de; dmarc=pass action=none
 header.from=helmholtz-muenchen.de; dkim=pass header.d=helmholtz-muenchen.de;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmgu.onmicrosoft.com;
 s=selector1-hmgu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usMowqpUju89ezY2Ty/lS1dZsmvRta8teiQKzvgAXvM=;
 b=eLqEPAnOu2UUPyPqHHb2uDXtmXXVn0DkrvoRnfQ42Oz+TYCh5bQau1zwF3kSP5/9K1Qe3QPBlkWXAFncgkzzPJGT6QwTnad/Dy2AAvg5S7XruuY+Mfqu0phpLnHlYr+TSWzHaOIDyLSflrJr+CAKBhgp/kRURvX9i6tIUlTYoTU=
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com (2603:10a6:102:93::18)
 by AS8PR04MB8293.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Wed, 7 Jun
 2023 20:51:16 +0000
Received: from PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb]) by PR3PR04MB7340.eurprd04.prod.outlook.com
 ([fe80::710b:a8da:eec8:dddb%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 20:51:16 +0000
From:   Bernd Lentes <bernd.lentes@helmholtz-muenchen.de>
To:     Phillip Susi <phill@thesusis.net>
CC:     Andrei Borzenkov <arvidjaar@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: RE: rollback to a snapshot
Thread-Topic: rollback to a snapshot
Thread-Index: AdmYsWN1zywqAwfcSAGb/x7tAPsy8AASEaCAAAyVbEAAE/dPgAAAwC4g
Date:   Wed, 7 Jun 2023 20:51:16 +0000
Message-ID: <PR3PR04MB7340C8A490ED5E5B5446879FD653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
References: <PR3PR04MB73400D4878EB0F8328B5D50BD652A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <26251cfd-f138-a787-f0e8-528c1c5c6778@gmail.com>
 <PR3PR04MB7340EB60FBF52F117181580ED653A@PR3PR04MB7340.eurprd04.prod.outlook.com>
 <87zg5b821z.fsf@vps.thesusis.net>
In-Reply-To: <87zg5b821z.fsf@vps.thesusis.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=helmholtz-muenchen.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PR3PR04MB7340:EE_|AS8PR04MB8293:EE_
x-ms-office365-filtering-correlation-id: 3dcb0fd7-7be9-416a-d92c-08db6798f025
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nL+6NAf2E0YQB6r+O23N5hz2mijaUBBRkwoAc/Hc2rHID/GfnQcaK4/sqCg+4Lp5ZpUa7Qa0mxwI52QG760TOHyGtDX1xbZOi3E2PuYXpP71RonuEf+8kMoQfB2nyVZmCHtCMEFwz/k4yFaSrM0tahPSmXVKrUP6T5yI7AUNYIkAPgNAwi29Aw9RtfPBaZ/04AaUkzaICuk81OUAUnwgasvzhm305P/V8Di/hI5Xb4xxZgsGILEMYmTBly7EVD7VqyNbHxF6HSmYlK2ul5EIx4tML2lg+hhFgxAwCmz58HnswrEXO3i1NimJL7LG8ip6/VbI+Y0X8ZNNbnOtYHQYZ7MyHP7Qtl00ffiXfY7L5/LEqmVPpOVda0vWmK6x+nnfb0AKmg2wSdEQk659oxtDJH2FQvVuHMHDloodoLXHgE5+EVBPwCU6DO2VCQ4rcAJ3uci9+7DXj5BtJLT6Zzz7QV9QGqloymHLmt3/hevfWNaXjiMeqc53SvnpsFg8AfGd1UyvjSzFKTiZMr/rX/RhwF5x97dRdrJXtNdFzMzy0YXHf1C03SDFNFkEui7M+KaKa8IL6UO33YmReU1/kUz+iRIDSi+qFt+8Wjn+UCeZUSld4GrZfZhWBFEU3whDeHP9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR04MB7340.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39850400004)(136003)(346002)(376002)(366004)(451199021)(83380400001)(966005)(54906003)(44832011)(33656002)(55016003)(478600001)(8676002)(8936002)(41300700001)(38070700005)(316002)(76116006)(66946007)(64756008)(66446008)(52536014)(66476007)(66556008)(122000001)(5660300002)(38100700002)(6916009)(4326008)(86362001)(7696005)(71200400001)(3480700007)(2906002)(186003)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MG11b3dnTGg1cDVMdDU3RklvQmc3eEE3RmJHeklIQUtwZUhOVHUrU09DVjA5?=
 =?utf-8?B?dlNNTFl0dDRocHVOU1I5WEpPQUdoU0JoZ05Fdlp3YkxKamp2U3hWS2l2TU5E?=
 =?utf-8?B?RjZPWDhyVFZoTFBVVXVRdWJVWHNRWmdJSVdJZkl4YU8wY3FOU1VPaXd6cm1l?=
 =?utf-8?B?QThsNW1xR1dqTzlnREVqUkFuUnByLzZBdWZLbFlWa09POGg2cThLN0QxTnlN?=
 =?utf-8?B?RzU0QXV1ekNoR2JITHNPRm9GM2NlU2greTV5NFMraTNQLzVvQ0NPOWU4aEpN?=
 =?utf-8?B?dDNEcUpzam4yMDFPdERNU2UwL0xBKy9LdVF1bWd0RW05YnFuM0hUUGFYYjVV?=
 =?utf-8?B?Qm05NmpxeThNWHdLdTRKQzVUbXpDMCt6Ynh6NlBETHV0aXlMbFIvYlFvQzht?=
 =?utf-8?B?bUVCTzZua0t1SnVDV2Z1ZVhDK29FTXZRc2JEUUFLZ2NzUUxJSG1UOXJEZFBt?=
 =?utf-8?B?M1A0MXJ3ZGR2MzBpSUtjcmdBM1FzUktZWjRkalRiOEcwYS9CcUpwcWkxSnhU?=
 =?utf-8?B?ZkplSFFoZm1xVlFsdWYwZGRjdWt4UE56TVNqVUdkSXkrZHQ2N05TMlg4Y09k?=
 =?utf-8?B?VFBLMWo0MjE2d1lHdFFJaUYyRDlxbFZibDh0YTd0akpici9ydWZFZVk4N1l4?=
 =?utf-8?B?a2hKY2hCY3YwRkVvMHBmR1RmcXhhZXdoYkFWc1BLU2grK3JoU2VLeE5mL3Bt?=
 =?utf-8?B?T1VCUEozZ3RxcllWcnJsUGloWElDd3I3eEo3TUZTbXpzaVM1L09EREUwRUlT?=
 =?utf-8?B?MlZvSUg5OW0xd0NjY2hqMHVCZ1ZudEJrUjkzZXRQVGs0UWxKZzdnczIzcTFV?=
 =?utf-8?B?MWg1aUtxSllEOGZkZkRIUURGekNTTkZEczlpRkNYV0xKaVRhKzBRWW5Ma0Z4?=
 =?utf-8?B?R3JZUC9iR0hZRkdPVzg1ODYrU0hFSGRMNU1EemhaRTdFQzRNV0EzS0g3TGVQ?=
 =?utf-8?B?a1Fud3JtZEFCQUtVSGJ0bFVkUXUzVVJDZzRNaDdLbUdZRjVFU0Vib3BGelVP?=
 =?utf-8?B?Z2o1Wm4yRkZuS2JQaXNjbUR1UzFYdzd5bkZiazAvamxUMFFtb1hHZkNkaWxX?=
 =?utf-8?B?SUE4alFPTGZSazBDbFZDb0VsNTMxQmcyakdTdzQ0UVN3eWo5ckhRRmh5d1N3?=
 =?utf-8?B?ajNmWjJPb3JTWjAzMngwdWt6OEVsTUxzKzBTM1dPZ1o0WHhRSXJYenRkOFNS?=
 =?utf-8?B?TmJFUm1YRkpYRXZGM045Qkhhb2VXR0tCZzMzRXBBM0s0R0xBRDIyOWhPeUFG?=
 =?utf-8?B?UjY3aGtLVjZqa0pqdE9Icm5wNGZYQWZtNW85SDRzY2xGZzlxUldlRnQrUFVU?=
 =?utf-8?B?UklJZDlqc3pWWjI4NVBKTVl2dnBnNERLUk9yZ0ttditRZTk5MG1ibVVuLzZq?=
 =?utf-8?B?TE9idXlKNGJGZU9sbE1rUGhHRm1tRDV4WStBMURIa3FnS3A1SGNlNHU2L3JR?=
 =?utf-8?B?UjRRZkIvM0Nyem5MRUN2RzhKVFR3NEhZQkUybEhIN1NLZm9qSk9lYVlsRUd0?=
 =?utf-8?B?bjU0U3NRdWNsTmlPdWtSUmxQRDRBeksvNWJTUk5FejJuTzJSbU14bkthWC9W?=
 =?utf-8?B?VXVmNmcyazZrdjc0OU41VVVjM3Y0anRabHo3UmYweWw5aE1oRUtFaGRjZnlP?=
 =?utf-8?B?RE15ekxKN3hLbEpuL3o3ZU5JVlUyVGdWZXZsVU1QWWoxU3ZJdzNXWitjZjFr?=
 =?utf-8?B?bDJSWkxWNkJudXRSaVJNTW9veTRkVHJ6WitqTE5EajJmWlZMNlhxTlYyK3No?=
 =?utf-8?B?VHgwWFptdC9nNW9Rb2xIdjJEN0VnMnhpWlowTVFTN0ZabTRCcnV6K3JxNGtY?=
 =?utf-8?B?OTJPZWxFQkdnU2dBdFNEUWxKZkYwb3B3RkhZRllORldFVnFNK2hKdU1wT2Fn?=
 =?utf-8?B?YUJ1N0V0WUFYYTB1ZUtRN0t4eHc3ZlpPdGFxVm0rM0xsUEI1Mzk4WUhwd0pa?=
 =?utf-8?B?bFdhUjZJdERQSlB6TUNFUVdZRERGRHRNSDVsb0c4TlBJc1pnTE5DNERVWHIz?=
 =?utf-8?B?L2ljdGk3Zk9ZSVpzUUlERjhjcXFiWGJ1Ykg0dG5uS09NazJQZFJVSm1wdnBu?=
 =?utf-8?B?RS9peksvdWJhMXBGelhYRnZDc25XcW1xbTZFRVdOOS91L2U4ZEJqa2loYXJp?=
 =?utf-8?B?cVYveUhUS3F0NWVrQi9EOC8xZ2NEVzU4cS9IanpZd0lKeFJEbjMzcU1wbnpT?=
 =?utf-8?B?VW9yc0JFNFgxUms1bHdES3VpZHFJVlJuckFqKzdPL01jRXJDcnRlN2NyMzUz?=
 =?utf-8?Q?mB/xHzOYzYWwpX7OKnGtTnRbxLyixWZZZz45N8JvcE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: helmholtz-muenchen.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PR3PR04MB7340.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcb0fd7-7be9-416a-d92c-08db6798f025
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 20:51:16.4544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e229e493-1bf2-40a7-9b84-85f6c23aeed8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /coPltgo5PaQBhC1b5z8jOt1BW/WMeEfPBl2CQuon+o4uExk0jKitSOKgjCif8SJ52WJN5Z/6pi+2w797JWCUU553A+zQ8oLm3Hjalue/O5k2YFU0EY1QXsjhyj3NAkV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8293
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBQaGlsbGlwIFN1c2kgPHBoaWxs
QHRoZXN1c2lzLm5ldD4NCj5TZW50OiBXZWRuZXNkYXksIEp1bmUgNywgMjAyMyAxMDowOSBQTQ0K
PlRvOiBCZXJuZCBMZW50ZXMgPGJlcm5kLmxlbnRlc0BoZWxtaG9sdHotbXVlbmNoZW4uZGU+DQo+
Q2M6IEFuZHJlaSBCb3J6ZW5rb3YgPGFydmlkamFhckBnbWFpbC5jb20+OyBsaW51eC1idHJmc0B2
Z2VyLmtlcm5lbC5vcmcNCj5TdWJqZWN0OiBSZTogcm9sbGJhY2sgdG8gYSBzbmFwc2hvdA0KDQo+
VGhlIGxhc3QgdGltZSBJIGluc3RhbGxlZCBVYnVudHUgb24gYnRyZnMsIHRoZSBpbnN0YWxsZXIg
YXV0b21hdGljYWxseSBjcmVhdGVkIGENCj50b3AgbGV2ZWwgc3Vidm9sdW1lIG5hbWVkIEAgYW5k
IGFjdHVhbGx5IGluc3RhbGxlZCB0aGUgc3lzdGVtIGluIHRoYXQNCj5zdWJ2b2x1bWUsIHRoZW4g
Y29uZmlndXJlZCBncnViIHRvIHRlbGwgdGhlIGtlcm5lbCB0byBtb3VudCB0aGUgcm9vdCBidHJm
cw0KPnZvbHVtZSB3aXRoIHRoZSBmbGFnIHN1YnZvbD0iQCIgc28gdGhhdCB0aGUgc3lzdGVtIHdv
dWxkIGJvb3Qgbm9ybWFsbHkuDQo+VGhlbiB5b3UganVzdCBtb3VudCB0aGUgcmVhbCByb290IG9m
IHRoZSBmaWxlc3lzdGVtIHNvbWV3aGVyZSBlbHNlIGFuZCBtYWtlDQo+YSBzbmFwc2hvdCBvZiB0
aGUgQCBzdWJ2b2x1bWUuICBXaGVuIHlvdSB3YW50IHRvIHJvbGwgYmFjaywgeW91IGp1c3QgcmVu
YW1lDQo+QCB0byBzb21ldGhpbmcgZWxzZSwgYW5kIGVpdGhlciByZW5hbWUgb3IgY3JlYXRlIGEg
bmV3IHdyaXRhYmxlIHNuYXBzaG90DQo+ZnJvbSB5b3VyIHByZXZpb3VzIHNuYXBzaG90IGFuZCBu
YW1lIGl0IEAsIHRoZW4gcmVib290Lg0KDQpEbyB5b3UgcmVtZW1iZXIgd2hpY2ggdmVyc2lvbiBp
dCB3YXMgPw0KWW91IHNheSAiIHRvcCBsZXZlbCBzdWJ2b2x1bWUgbmFtZWQgQCIuIFlvdSBtZWFu
IHN1YnZvbGlkIDUgPw0KIiBUaGVuIHlvdSBqdXN0IG1vdW50IHRoZSByZWFsIHJvb3Qgb2YgdGhl
IGZpbGVzeXN0ZW0iLiBXaGF0IGRvIHlvdSBtZWFuIGJ5ICJyZWFsIHJvb3QiID8NCkRvZXMgdGhl
IHN1YnZvbHVtZSBAIGFscmVhZHkgY29udGFpbiBmaWxlcyBvciBpcyBpdCBqdXN0IGEgY29udGFp
bmVyIGZvciBhbm90aGVyIHN1YnZvbHVtZSA/DQoieW91IGp1c3QgcmVuYW1lIEAgdG8gc29tZXRo
aW5nIGVsc2UiLiBIb3cgY2FuIGkgcmVuYW1lIGEgc3Vidm9sdW1lID8gSnVzdCByZW5hbWUgdGhl
IGNvcnJlc3BvbmRpbmcgZGlyZWN0b3J5ID8NCiIgVGhlbiB5b3UganVzdCBtb3VudCB0aGUgcmVh
bCByb290IG9mIHRoZSBmaWxlc3lzdGVtIHNvbWV3aGVyZSBlbHNlIiBXaHkgPyBXaXRoIGEgYmlu
ZCBtb3VudCA/DQoNCkJlcm5kDQoNCkhlbG1ob2x0eiBaZW50cnVtIE3DvG5jaGVuIOKAkyBEZXV0
c2NoZXMgRm9yc2NodW5nc3plbnRydW0gZsO8ciBHZXN1bmRoZWl0IHVuZCBVbXdlbHQgKEdtYkgp
DQpJbmdvbHN0w6RkdGVyIExhbmRzdHJhw59lIDEsIEQtODU3NjQgTmV1aGVyYmVyZywgaHR0cHM6
Ly93d3cuaGVsbWhvbHR6LW11bmljaC5kZQ0KR2VzY2jDpGZ0c2bDvGhydW5nOiBQcm9mLiBEci4g
bWVkLiBEci4gaC5jLiBNYXR0aGlhcyBUc2Now7ZwLCBEYW5pZWxhIFNvbW1lciAoa29tbS4pIHwg
QXVmc2ljaHRzcmF0c3ZvcnNpdHplbmRlOiBNaW5EaXLigJlpbiBQcm9mLiBEci4gVmVyb25pa2Eg
dm9uIE1lc3NsaW5nDQpSZWdpc3RlcmdlcmljaHQ6IEFtdHNnZXJpY2h0IE3DvG5jaGVuIEhSQiA2
NDY2IHwgVVN0LUlkTnIuIERFIDEyOTUyMTY3MQ0K
