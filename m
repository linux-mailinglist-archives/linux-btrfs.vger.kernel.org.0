Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C216C301763
	for <lists+linux-btrfs@lfdr.de>; Sat, 23 Jan 2021 18:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbhAWRvo (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 23 Jan 2021 12:51:44 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29292 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbhAWRvm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 23 Jan 2021 12:51:42 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10NHoBoV010900;
        Sat, 23 Jan 2021 09:50:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Q7EOKKnvsazB4OfK2WsJz/BTbXci/Ju5KcFxwtQ+ifU=;
 b=PQC+FyXqnt5eu063z7kyzxpTFstLXv9zQqSW5gA+lTedrPh5Ya805XkupCOrSm2tbZFv
 P7xGKDSX5nbXlDB9SK57L44ohXDnPhElRaMaN/cbiup0Usxg8dof4e/TGv4kQb7OL9U2
 l1u9hvQV9cTfFCOhsYbxYvMXwlw/xIlnKL4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 368m028ycd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 23 Jan 2021 09:50:56 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 23 Jan 2021 09:50:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNrnPPTW5OogloAMBN4YE5KGTqBJFYKJ+sh4b2MWEL7WHjwgR761rQ1i4EVMJiGfYD6plN7wLJ0AkhElOcgP9HqNYxV4a2gqiUrJsJ3IZkww1JRF4YodXKVHRpSc7J3ciDlw6w18yYDsubQCBp+Vqp1GX7sUSEIbaYGpL/srlvruPvGcGnq3jYjy4zWuRePljicOsjhX6npFW1ywDtZ6CJnJHGpjmLjKFkiKTnFFmwx5Gm+9F1ge+koMfCm6689kuxSDpKpqpzV5gSaQgvoQ5B4Tl2u0chVlrF70D8PEBFzRO0vzffK1DM/Jj1gYeGL0ysNMye6obKddL6HHxcNVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7EOKKnvsazB4OfK2WsJz/BTbXci/Ju5KcFxwtQ+ifU=;
 b=cZK5UyiJH/C9WlDKHj3lMkdo4SLwPCntiGkMq5f7tl1MCWjbq0NT05eyaNg7mD1+PJLgmfB3JXxbKKr5rScFiVKFfv7z2ZEoNXgbsJqpmES73e3k9cQIyeOKOrdj2105qJ3kxFE1jT1QzdQyChfiJEDsvv043o7vEvwP0DgJ6fykckGwWDWLBPiDiNqhDBPE9MiubFPI9U8qt7fC8GX8ACyMUKCQw+SgY3Jrx00SMheY0QGtfbP/V+ITFBcubtLJs8fFKlAMG0HTtobvqlwhvn2K5O93SDAIZWPX2PO9edGCygU6SeoXDm4OoTy+aSYgC1s828i4YEIiR9mRq+VTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q7EOKKnvsazB4OfK2WsJz/BTbXci/Ju5KcFxwtQ+ifU=;
 b=iwhgVQYwIJzVerLX7pJNv86Y8Gc9Kh0c8owPFzN3AwyiC2DTrdwX96K/tT8RVpFHfjLw+8PKHnUm27teju0maLfR33xU4+bguDoc/BMhDZbhGJn90pQWK2YIDIiFiM73vavKX5+MAdvwSzxc5+8RyO8wmOGn6h2Yq4SdTh381oU=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by SJ0PR15MB4204.namprd15.prod.outlook.com (2603:10b6:a03:2c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Sat, 23 Jan
 2021 17:50:53 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4141:a73f:aa7a:bdcf]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::4141:a73f:aa7a:bdcf%5]) with mapi id 15.20.3784.013; Sat, 23 Jan 2021
 17:50:53 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Nikolay Borisov <nborisov@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 13/14] lib/zstd: Convert constants to defines
Thread-Topic: [PATCH v3 13/14] lib/zstd: Convert constants to defines
Thread-Index: AQHW8KayJA5XLtXcT0u9UmSEWhWFcqo1f0cA
Date:   Sat, 23 Jan 2021 17:50:52 +0000
Message-ID: <8849FEEB-48EC-4C63-9046-279C9AFF029D@fb.com>
References: <20210122095805.620458-1-nborisov@suse.com>
 <20210122095805.620458-14-nborisov@suse.com>
In-Reply-To: <20210122095805.620458-14-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [98.33.101.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7db80405-7917-4c8a-56be-08d8bfc76d8d
x-ms-traffictypediagnostic: SJ0PR15MB4204:
x-microsoft-antispam-prvs: <SJ0PR15MB4204667E6933B3DAE628EDE4ABBF9@SJ0PR15MB4204.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:131;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r4bpZpvAF42nSQjkerdRUDDvIibnRl/9QiXLY+obSAATHKL+CTckV48Yh40HCh4AHH8JU4gGq7cjQRYQA+p0Pk/iF89dbvESVKtshXUe1h68jONuK6NNUmSAlW4AdJj9KDENossPaybaaou+A3HyJNnADF4jlhzNgQHvKlOMeLLFOh8Q7KbEhIrYjYleGsW5nDnjKbU8xK2V+cqyTRgZ+AdZemO2eiZPdY8rRFNFBVAdZ4hs505wtZNP4P2BYp5H3vXYqz6QmZt6rRZMTwYOhhWmz+AwRCxXrLS8S+oC2M2G23yGDE84kSWULooErj3tJ/Er5PU03zR/vrG6paeCrEHl4c1PHe6HCzK6LrlMZ1AF9NAeL3uYvXhWI+8HBP6JtnknBQO+46UkgeexOWW9G1ykXjmlOLbZCaDUTM2Kjlf18al8xhf4yuYhkzsEXE5g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(396003)(39860400002)(366004)(6506007)(2906002)(66446008)(83380400001)(66556008)(66946007)(86362001)(8676002)(76116006)(316002)(64756008)(66476007)(26005)(186003)(53546011)(478600001)(6512007)(6486002)(5660300002)(8936002)(6916009)(33656002)(36756003)(71200400001)(2616005)(4326008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dUowSktKNGpXUlQ0YlVtMkwxVVUxcm92TzFYdUh0ZWI3djJQbG5zY3hWMGZ1?=
 =?utf-8?B?NjFCTHcxdkFVbUNpQ2wwN3lEaU1sZzl5cUZYd1dZVzFTczJHcHo3TmFBaFZI?=
 =?utf-8?B?d0Vva1RvcWVxS0dnT2tHTUpLaGVpOHQ0N0RWSFI0bnF5a1Zid0ZVYWZXbDM5?=
 =?utf-8?B?NnZYSFRQSm1MWUJGTWxuaGsvRVJNOHZ1aHAxT2R4YjVCeVUxNVc1VTNKUDN0?=
 =?utf-8?B?cE1CdE0yc2ZBcEw4a3QvMnBGN09vUXVvZ3diVWtNeWVwL2tOK1pKS0lLajFw?=
 =?utf-8?B?Q3BZdmQ2cFRuVGF0TVEyVzNxR2RleVltc1ZKSzdJaFE3ZHlPNTMzcFcxeDU3?=
 =?utf-8?B?UEV3REpnMXZCT1dRZytiRU1qb1ZmNnE0ekc3TUU1bmdUejFtak4xRXRhYUhS?=
 =?utf-8?B?V0NVQytNejNmbjNyUThiU2ZBZDlhNlVRU0dVVFlzQWZWLzA3QkpGdnNhbUVk?=
 =?utf-8?B?SmVLQ1IraFIzajJJa25jbC9uUnltYjJWRTVHc2FGVlM5MlI4blJQK1JjK2JJ?=
 =?utf-8?B?ejVrRGUzVVF0NU92LzUrMkZmSGRPYklJVC9qQ2NDSEViSGp4VVExeWVYU0pS?=
 =?utf-8?B?WUFmYk1Cb1ROZ3V5U3RlKzFZOGRwN1hwZnkwV3dJcWlhd3hGTy9NMHBiNkhZ?=
 =?utf-8?B?QlFzSXk4WlB6b0xBa1hYdEh2REtTeXo2czBISS9VVzZjRVNSTk5PM1F1Yndn?=
 =?utf-8?B?a1FDVFN3WTlyN0VOb1JXRGdXWGt0eG1UZWVUaHBRZ2JCYjVTeFk3ZkltZWx5?=
 =?utf-8?B?Q3pya1RRVFlwVm1DN1FCOG1Od0xYR2lzQnFHZU1vdi9aVml6U210ejRhQ09a?=
 =?utf-8?B?NnppMkpGdGlWeDRKQlR2TmdsSXgxdjZGV1BlODBuV1A5WUdRNlU3TXRuOWNE?=
 =?utf-8?B?NXE3Umk1d2ZnUFRsK29BMWpqVEdDcEs4emdoL0pVaExiajdjTUV6VHBPcTNI?=
 =?utf-8?B?TkVUQVRrWVRtTWZjcUQ5bzZmNGZhZkF3OW1sdlVUcUtaWlJiUi9DOG5weFVz?=
 =?utf-8?B?akM0cWlzNEZ6U3ozU0w5VjFBSlNpVWUxN1V0eXMyeFNHd2ROcTNXUzczRjlK?=
 =?utf-8?B?ZHhoMTBhME45WWJxbzUrTk1TU2hjSlJ4R0VYaUEzaXYreFRjNnRuQ216SllR?=
 =?utf-8?B?SVBOcFdmdEczKzFBNkl5VjIwY255ZW1BaFp0YjVhZ0xXbnd6bzZrOFBJWmsv?=
 =?utf-8?B?YkxFaXZub1lBMGZ3TWhTVE1wM2p4MnZBSEhoTnU5YUNDNVpJOXg1VnhnbFZm?=
 =?utf-8?B?ZmVyUGlybGpyQ09oNGZraVRwM21aM29jdTBmT3hJVlhCbk5zV3RDL1NhdHRz?=
 =?utf-8?Q?xVAzeSb9ZdCZb3xUlG6jyAIgLkVTKUzwYE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <99CFF6D0947E354E83B440D16803C3DE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7db80405-7917-4c8a-56be-08d8bfc76d8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2021 17:50:52.9132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHGS1yF1G0nqRwk2TBtqaCE1fIqlt6y2+x/4SceGjuaOjsDytRZR/5PglgzEVOqu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4204
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-23_08:2021-01-22,2021-01-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101230104
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gSmFuIDIyLCAyMDIxLCBhdCAxOjU4IEFNLCBOaWtvbGF5IEJvcmlzb3YgPG5ib3Jp
c292QHN1c2UuY29tPiB3cm90ZToNCj4gDQo+IFRob3NlIGNvbnN0YW50cyBhcmUgcmVhbGx5IHVz
ZWQgaW50ZXJuYWxseSBieSB6c3RkIGFuZCBpbmNsdWRpbmcNCj4gbGludXgvenN0ZC5oIGludG8g
dXNlcnMgcmVzdWx0cyBpbiB0aGUgZm9sbG93aW5nIHdhcm5pbmdzOg0KPiANCj4gSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIGZzL2J0cmZzL3pzdGQuYzoxOToNCj4gLi9pbmNsdWRlL2xpbnV4L3pzdGQu
aDo3OTg6MjE6IHdhcm5pbmc6IOKAmFpTVERfc2tpcHBhYmxlSGVhZGVyU2l6ZeKAmSBkZWZpbmVk
IGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQ0KPiAgNzk4IHwgc3RhdGlj
IGNvbnN0IHNpemVfdCBaU1REX3NraXBwYWJsZUhlYWRlclNpemUgPSA4Ow0KPiAgICAgIHwgICAg
ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gLi9pbmNsdWRlL2xp
bnV4L3pzdGQuaDo3OTY6MjE6IHdhcm5pbmc6IOKAmFpTVERfZnJhbWVIZWFkZXJTaXplX21heOKA
mSBkZWZpbmVkIGJ1dCBub3QgdXNlZCBbLVd1bnVzZWQtY29uc3QtdmFyaWFibGU9XQ0KPiAgNzk2
IHwgc3RhdGljIGNvbnN0IHNpemVfdCBaU1REX2ZyYW1lSGVhZGVyU2l6ZV9tYXggPSBaU1REX0ZS
QU1FSEVBREVSU0laRV9NQVg7DQo+ICAgICAgfCAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fg0KPiAuL2luY2x1ZGUvbGludXgvenN0ZC5oOjc5NToyMTogd2Fybmlu
Zzog4oCYWlNURF9mcmFtZUhlYWRlclNpemVfbWlu4oCZIGRlZmluZWQgYnV0IG5vdCB1c2VkIFst
V3VudXNlZC1jb25zdC12YXJpYWJsZT1dDQo+ICA3OTUgfCBzdGF0aWMgY29uc3Qgc2l6ZV90IFpT
VERfZnJhbWVIZWFkZXJTaXplX21pbiA9IFpTVERfRlJBTUVIRUFERVJTSVpFX01JTjsNCj4gICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+IC4vaW5j
bHVkZS9saW51eC96c3RkLmg6Nzk0OjIxOiB3YXJuaW5nOiDigJhaU1REX2ZyYW1lSGVhZGVyU2l6
ZV9wcmVmaXjigJkgZGVmaW5lZCBidXQgbm90IHVzZWQgWy1XdW51c2VkLWNvbnN0LXZhcmlhYmxl
PV0NCj4gIDc5NCB8IHN0YXRpYyBjb25zdCBzaXplX3QgWlNURF9mcmFtZUhlYWRlclNpemVfcHJl
Zml4ID0gNTsNCj4gDQo+IFNvIGZpeCB0aG9zZSB3YXJuaW5ncyBieSB0dXJuaW5nIHRoZSBjb25z
dGFudHMgaW50byBkZWZpbmVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTmlrb2xheSBCb3Jpc292
IDxuYm9yaXNvdkBzdXNlLmNvbT4NCj4gLS0tDQo+IGluY2x1ZGUvbGludXgvenN0ZC5oIHwgOCAr
KysrLS0tLQ0KPiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvenN0ZC5oIGIvaW5jbHVkZS9saW51
eC96c3RkLmgNCj4gaW5kZXggMjQ5NTc1ZTI0ODVmLi5lODdmNzhjOWIxOWMgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvbGludXgvenN0ZC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvenN0ZC5oDQo+
IEBAIC03OTEsMTEgKzc5MSwxMSBAQCBzaXplX3QgWlNURF9EU3RyZWFtT3V0U2l6ZSh2b2lkKTsN
Cj4gLyogZm9yIHN0YXRpYyBhbGxvY2F0aW9uICovDQo+ICNkZWZpbmUgWlNURF9GUkFNRUhFQURF
UlNJWkVfTUFYIDE4DQo+ICNkZWZpbmUgWlNURF9GUkFNRUhFQURFUlNJWkVfTUlOICA2DQo+IC1z
dGF0aWMgY29uc3Qgc2l6ZV90IFpTVERfZnJhbWVIZWFkZXJTaXplX3ByZWZpeCA9IDU7DQo+IC1z
dGF0aWMgY29uc3Qgc2l6ZV90IFpTVERfZnJhbWVIZWFkZXJTaXplX21pbiA9IFpTVERfRlJBTUVI
RUFERVJTSVpFX01JTjsNCj4gLXN0YXRpYyBjb25zdCBzaXplX3QgWlNURF9mcmFtZUhlYWRlclNp
emVfbWF4ID0gWlNURF9GUkFNRUhFQURFUlNJWkVfTUFYOw0KPiArI2RlZmluZSBaU1REX2ZyYW1l
SGVhZGVyU2l6ZV9wcmVmaXggNQ0KPiArI2RlZmluZSBaU1REX2ZyYW1lSGVhZGVyU2l6ZV9taW4g
WlNURF9GUkFNRUhFQURFUlNJWkVfTUlODQo+ICsjZGVmaW5lIFpTVERfZnJhbWVIZWFkZXJTaXpl
X21heCBaU1REX0ZSQU1FSEVBREVSU0laRV9NQVgNCj4gLyogbWFnaWMgbnVtYmVyICsgc2tpcHBh
YmxlIGZyYW1lIGxlbmd0aCAqLw0KPiAtc3RhdGljIGNvbnN0IHNpemVfdCBaU1REX3NraXBwYWJs
ZUhlYWRlclNpemUgPSA4Ow0KPiArI2RlZmluZSBaU1REX3NraXBwYWJsZUhlYWRlclNpemUgOA0K
PiANCj4gDQo+IC8qLSoqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioNClRoaXMg
bG9va3MgZ29vZCB0byBtZSEgV2UgcmVtb3ZlZCB0aGVzZSBjb25zdGFudHMgZnJvbSB0aGUgdXBz
dHJlYW0gaGVhZGVyIGENCndoaWxlIGFnbywgZm9yIHNpbWlsYXIgcmVhc29ucy4NCg0KWW91IGNh
biBhZGQ6DQoNClJldmlld2VkLWJ5OiBOaWNrIFRlcnJlbGwgPHRlcnJlbGxuQGZiLmNvbT4NCg0K
LU5pY2sNCg0K
