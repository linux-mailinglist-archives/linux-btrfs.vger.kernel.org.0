Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED2441CAB7
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Sep 2021 18:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345770AbhI2Q6F (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Sep 2021 12:58:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57304 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344242AbhI2Q6E (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Sep 2021 12:58:04 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18TADGi6012438;
        Wed, 29 Sep 2021 09:56:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=P+OLyuK1B9qzkrrXaTxKt4D3+xAlonatYi5Q0UFg0og=;
 b=dXBvTfqVwr3r8EqC/FsluVjtuwUZz0c3IVMI7GeXKiTgqjtimMV22CYUg2232JnPGMdq
 W9aCREBGnrVz1lMPJXjLnBV999nQgEIJiSZmnRr8dEnM4BS3yFes21CXuMOdnkYbIj2R
 6XwOr9OBqtoXuMJ6oWV9iixKfu6hQN/WPPs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bcbff6pjd-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 29 Sep 2021 09:56:23 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 29 Sep 2021 09:56:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B99u0af80rSBkFzU2rPrhf7yXOMTSFWymNTCofKFZJug/vDory+D4011+yGeHsOCkP0IFFjy1pnvCNG/VmUe6NzTjI0HNiZ6L9uaj5+ckAuyaG0qHfolrSDzgPncenN3zsRw4br6EwET87NBHft5LdkZA2L29z2F9gSh0moSI3fcN8PLd1mEIK1aTQ0P1I5LSAiJejszqqU9jh8r3YfRprLRSye85l+bkyQIuNpANQkScl44k8ZOyTXkpbBzegh6gTpaFG1ppKHgUBOekwmSOq+yLzmDdF2tYa5WFHnAKnqjfPNMSdGdbh8YYcREDPGE5qSOpHURTBjsaMFsFh3Txg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=P+OLyuK1B9qzkrrXaTxKt4D3+xAlonatYi5Q0UFg0og=;
 b=AfwCiZ3xaeMKvO0Pj8PC1G3fubVcRMQeqDFv+VYI3F8cCU8H1mSILSwWG5gIt2SmvueMjEYRCtHEdM90B3OWl9w/CoQm4rc8+EW6koD25jywDgey4fZ8YPhhwQ8qyaFdtiL4QBNQ4mYGOKF9RBoHKD6ytFob0pyafLrfgd3vFkAcxR5b1lizqtFkAGFO7bhYWU/i6kYGeju8bs7+rM46Wr5pV/Ey1O9pMR+2Dc7JAA09INCugfUijxmT9/2nRsT8zKpISf7pbTgjFJYGqOmarfPU79dm1GhUtpkEabpn54rXbJOg18VEPcQKN+B0zD9mbDwtixA/yl0r12/yk2vBfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BYAPR15MB2199.namprd15.prod.outlook.com (2603:10b6:a02:83::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Wed, 29 Sep
 2021 16:56:17 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::445:550f:2ac9:240c]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::445:550f:2ac9:240c%6]) with mapi id 15.20.4544.021; Wed, 29 Sep 2021
 16:56:17 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     David Sterba <dsterba@suse.cz>
CC:     "B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com" 
        <B093B859-53CC-4818-8CC3-A317F4872AD6@fb.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Thread-Topic: [GIT PULL][PATCH v11 0/4] Update to zstd-1.4.10
Thread-Index: AQHXtMgnRHahUsnwt0OoDobWrpOhequ6OZgAgACQUoCAAHJbAA==
Date:   Wed, 29 Sep 2021 16:56:17 +0000
Message-ID: <1584373E-34C9-4B0E-9E84-6C29F919EE38@fb.com>
References: <e19ebd67-949d-e43c-4090-ab1ceadcdfab@gmail.com>
 <4A374EA5-F4CC-4C41-A810-90D09CB7A5FB@fb.com>
 <20210929100659.GK9286@twin.jikos.cz>
In-Reply-To: <20210929100659.GK9286@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9351c603-6932-44ef-1e80-08d9836a0ddf
x-ms-traffictypediagnostic: BYAPR15MB2199:
x-microsoft-antispam-prvs: <BYAPR15MB2199A8E51E18616B05637CA7ABA99@BYAPR15MB2199.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eASwNmnbmFqE9zS82ubO6wYoaYMMYz85VGlo0Kyn1uI2DxLzwtv2YUk4mLy+FyqZ0RPXl38P1N+8h6bu3B+cHZRpwFybQKLI7+ZzLH/eaHsYr/Ykv1XbNpgENBOMvv2O7NU8lddY8YTzYxVZ3lkuETAr6Qn99RGX0t5hi0mvMyUxxUIsYTmIsL/zRFnYttyWHr/WhOeS1WG9ZhAlomsDM4LMiJS0BdBfIow0Th4R6InOu8OB3mI2kk+KyMeCkryymoxTBTQY1rdtqm/RohJyp0CbUmaIg55/dxUiy9/NM+mjvebXarTv5sPuTLMaof2WI/4vA43QYKriTDg76HL9Zud6vqk87wMVcmVawOMBwpQ9ic0ii3A6nAKt06e6MtZNES9QpfNwX2V1rjt348c74rEgAzY2gxGKWSZWWAQVXV9Qxi6IVTilCZkw5aysX6+n5xwWJWU8Xo/SBFD/tXDScFCdfscSkkV77KYajjP84ZunFsdm7ecznkv9NpATIZBx+t6hOzwNH8Q/uFCdlalWFMyomVwX1XsZUXOSvB0WpVG8pVu/L41MNv5Z5LGJcz65QX2IxZDC7x4LcIgxYbqEj+us9ujsQrCWt+F2yzGhJIthJ/u9txf4XzJ0IIhttawFNddPHRngD9xn/Xbz3fjE9okfZVGXfMotZ6b3BNArmy3qS4pdotuLG8YZmIs0WKDAUBMQIhtpqBXYXmOblkrXuzzNr74pInCjFlbfd2MwPGk1j5YWuy6LBKQ5JLatHBnY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(6506007)(6916009)(186003)(33656002)(6512007)(71200400001)(83380400001)(26005)(36756003)(8936002)(66446008)(4326008)(6486002)(86362001)(316002)(76116006)(2906002)(64756008)(5660300002)(38070700005)(38100700002)(66946007)(508600001)(2616005)(8676002)(66556008)(54906003)(66476007)(15650500001)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjhpdDFwTDA3WG5xY1hmS1h0bUozVWFTbkk2QVpjQXlHTjRDZ3JuaDQzalNU?=
 =?utf-8?B?a0N1S1h6d3JPQlNjOEhXZEhnK3U2UlpZRlpIZENnd2xVOUdTdkh6RkI4dGlL?=
 =?utf-8?B?d29rVWFGbnJpM3RwbHV1TGpINUxKYnFOMFBhV0t1VUxtb2tFOVJUZDJkUDhz?=
 =?utf-8?B?VkgyTzJhOTdMTDkrWDJjamx0em8wMld1OTJiOG5CMFhnanFVeitHTkM4VHN3?=
 =?utf-8?B?K2tTdFl4aGp0WnBNUUMvb3R5QnR0T3dobjBjc05LR2NBdjhJRzVXVjNSbDVq?=
 =?utf-8?B?Tm4yTm1kalRZZVVjSjFZQmJVcEVjUU51LzYyczBGZlR6eVA2MldKRHZRZ2x2?=
 =?utf-8?B?SjBqMjk3dVNKcE1TS0R0aUVVR0JJN3Ywa3FaOG5nZnhRYy91ZnNaMWJrZGlt?=
 =?utf-8?B?THBhdFRDUGxMM1RYS0lJd1JSOGhrN0NKQ3BBQm4wKy9SdU5uZlI2SWtyTnl1?=
 =?utf-8?B?N2hKY3MvZVNUUFJ5NFlOMmYwODIzYlQ5eUlkbEJ4ZDB0WVpDK3JwMmU0OVg2?=
 =?utf-8?B?NGRGZjZ0RklLaXJ5aDlEamNEbzhwbDU3MXlHMnQraXIyN2hDRnZMelhqZ3BM?=
 =?utf-8?B?WmZtWTUrK0cyeWJ2ZmdoWFI4M1BGdk03QVhwZmlpKzJJMzBrOTIrU2lpNGls?=
 =?utf-8?B?K1pHVGtWZ1hmaTZqNGNlV090MWkxcWFuMlh3eGtnLzNnTFBTcUx2N0l4ME1K?=
 =?utf-8?B?L3pjejlnTkEwUktWTm95bHdudW51UjZ4QXdzZytyVHRSdGpFM3psaURmbSt1?=
 =?utf-8?B?UGR0aFlzdTBralVjMTFTZzNSeDA0VldtblBvVTFNUk45ZmxQbkFIOEJ3UkU4?=
 =?utf-8?B?Q3RUdnhwOStWY21PUnNQYkpZQ1VLaEF4Mk51SXdjand2QWR1cFQrRjF6dkY0?=
 =?utf-8?B?RUFhSit1RXNadExVdHNnQXY5dFBjLzRhYmUvb1NSQnl2bkQvYmFKQWQwMXZn?=
 =?utf-8?B?WDN3WTQrZW1RRVNUS09hbjV3UFRaaHU1eTBuQm90Y01YQVRFNk1RcitrMzdS?=
 =?utf-8?B?ZldMMThSeE5VZDQ3SXdWVDN1MlpmekxrcW1NOTNGYUx5eTJPdXpJeUk5dDJh?=
 =?utf-8?B?TGZjaXV6clVjQ2E0c1pvTk5IV0swUm5YODFpQVJzbFRvendBWm1LRExsV1RT?=
 =?utf-8?B?YmY1bzd5NnlDZlpzNGR5ODI0N0svY2VEaFdJbjRkOG5jL3IwR0I3VTZ2MnZS?=
 =?utf-8?B?dHM1VXFTckQzdlBnMUVxYjM3dEZqSWhiM0dXQUpmYWxhc0RLb2lCTmpKU0lF?=
 =?utf-8?B?am8vbG1XaGhUMVYxM3hOUmFXaHpvTEx2QWtEVVlwQjh0WTFIbzVhMGNGLzh5?=
 =?utf-8?B?dmp5eGMwZ3ZKbmNvUFJsWXNOcGVTV3czbnR1T2VZSGpHWlFBcXJqVGl2S2o5?=
 =?utf-8?B?RFQxclM2UWJibjBzdnppL0N1VWZWMzhWck53UitudUFKWXk0dTArTkF1cExW?=
 =?utf-8?B?RFBURzhMaVJHN29lZlhFeDV6dkNqMVUrdkVoeUYybXpMenptN3NEN3g0dFV1?=
 =?utf-8?B?SE9ZQTA2RkNveHV1UGluUnRWRkdXN01jQnpnVFlpcnkxODZnRmVhT2lpTzdr?=
 =?utf-8?B?amt6RTFQYkpERllZTGtuWFI5dko0SGxWcXVhMGJ3dnZkaGVGTnVTMjVsVFlC?=
 =?utf-8?B?dkFOUDBXUVJ0OGY5bG15UTlHNFJ0TzVtdzVRN0ovQmI3enNFaUZRSTlzRUxT?=
 =?utf-8?B?RUx1cWFlc1ZrRk1lZDlrdTIvSDNlc3NuYjNlKzJ4SkRBSURuRmpPY2pZTzJr?=
 =?utf-8?Q?ZzudZVvW+al0VB0iwpmLFIlxCGYL7R0SMhPTe6h?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8B0F9F6E0FDA44FA49B845105836DC1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9351c603-6932-44ef-1e80-08d9836a0ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2021 16:56:17.1354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5glXogCfQNV/NFuxiVte4mfvKJBK26Zp1/4ncvqa2aOi5k3MLcCCNWlpVQ5aVDh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2199
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: -XI1W8pF-8ezAusfqpiG79CntrhzJupY
X-Proofpoint-GUID: -XI1W8pF-8ezAusfqpiG79CntrhzJupY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-29_07,2021-09-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109290098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

DQoNCj4gT24gU2VwIDI5LCAyMDIxLCBhdCAzOjA2IEFNLCBEYXZpZCBTdGVyYmEgPGRzdGVyYmFA
c3VzZS5jej4gd3JvdGU6DQo+IA0KPiBPbiBXZWQsIFNlcCAyOSwgMjAyMSBhdCAwMTozMDoyNkFN
ICswMDAwLCBOaWNrIFRlcnJlbGwgd3JvdGU6DQo+Pj4gT24gU2VwIDI4LCAyMDIxLCBhdCA1OjIy
IFBNLCBUb20gU2Vld2FsZCA8dHNlZXdhbGRAZ21haWwuY29tPiB3cm90ZToNCj4+PiBIYXMgdGhp
cyBiZWVuIGFiYW5kb25lZCBvciB3aWxsIHRoZXJlIGJlIGZ1dHVyZSBhdHRlbXB0cyBhdCBzeW5j
aW5nIHRoZQ0KPj4+IGluLWtlcm5lbCB6c3RkIHdpdGggdGhlIHVwc3RyZWFtIHByb2plY3Q/DQo+
PiANCj4+IFNvcnJ5IGZvciB0aGUgbGFjayBvZiBhY3Rpb24sIGJ1dCB0aGlzIGhhcyBub3QgYmVl
biBhYmFuZG9uZWQuIEnigJl2ZSBqdXN0IGJlZW4NCj4+IHByZXBhcmluZyBhIHJlYmFzZWQgcGF0
Y2gtc2V0IGxhc3Qgd2Vlaywgc28gZXhwZWN0IHRvIHNlZSBzb21lIGFjdGlvbiBzb29uLg0KPj4g
U2luY2Ugd2XigJlyZSBub3QgaW4gYSBtZXJnZSB3aW5kb3csIEnigJltIHVuc3VyZSBpZiBpdCBp
cyBiZXN0IHRvIHNlbmQgb3V0IHRoZQ0KPj4gdXBkYXRlZCBwYXRjaGVzIG5vdywgb3Igd2FpdCB1
bnRpbCB0aGUgbWVyZ2Ugd2luZG93IGlzIG9wZW4sIGJ1dCBJ4oCZbSBhYm91dCB0bw0KPj4gcG9z
ZSB0aGF0IHF1ZXN0aW9uIHRvIHRoZSBMS01MLg0KPiANCj4gSWYgeW91IHNlbmQgaXQgb25jZSBt
ZXJnZSB3aW5kb3cgaXMgb3BlbiBpdCdzIHVubGlrZWx5IHRvIGJlIG1lcmdlZC4gVGhlDQo+IGNv
ZGUgbXVzdCBiZSByZWFkeSBiZWZvcmUgaXQgb3BlbnMgYW5kIHBhcnQgb2YgbGludXgtbmV4dCBm
b3IgYSB3ZWVrIGF0DQo+IGxlYXN0IGlmIG5vdCBtb3JlLg0KPiANCj4+IFRoaXMgd29yayBoYXMg
YmVlbiBvbiBteSBiYWNrIGJ1cm5lciwgYmVjYXVzZSBJ4oCZdmUgYmVlbiBidXN5IHdpdGggd29y
ayBvbg0KPj4gWnN0ZCBhbmQgb3RoZXIgcHJvamVjdHMsIGFuZCBoYXZlIGhhZCBhIGhhcmQgdGlt
ZSBqdXN0aWZ5aW5nIHRvIG15c2VsZiBzcGVuZGluZw0KPj4gdG9vIG11Y2ggdGltZSBvbiB0aGlz
LCBzaW5jZSBwcm9ncmVzcyBoYXMgYmVlbiBzbyBzbG93Lg0KPiANCj4gV2hhdCBuZWVkcyB0byBi
ZSBkb25lIGZyb20gbXkgUE9WOg0KPiANCj4gLSByZWZyZXNoIHRoZSBwYXRjaGVzIG9uIHRvcCBv
ZiBjdXJyZW50IG1haW5saW5lLCBlZy4gdjUuMTUtcmMzDQo+IA0KPiAtIG1ha2Ugc3VyZSBpdCBj
b21waWxlcyBhbmQgd29ya3Mgd2l0aCBjdXJyZW50IGluLWtlcm5lbCB1c2VycyBvZiB6c3RkLA0K
PiAgaWUuIHdpdGggYnRyZnMgaW4gcGFydGljdWxhciwgSSBjYW4gZG8gc29tZSB0ZXN0cyB0b28N
Cj4gDQo+IC0gcHVzaCB0aGUgcGF0Y2hlcyB0byBhIHB1YmxpYyBicmFuY2ggZWcuIG9uIGsub3Jn
IG9yIGdpdGh1Yg0KPiANCj4gLSBhc2sgZm9yIGFkZGluZyB0aGUgYnJhbmNoIHRvIGxpbnV4LW5l
eHQNCj4gDQo+IC0gdHJ5IHRvIGdldCBzb21lIGZlZWRiYWNrIGZyb20gcGVvcGxlIHRoYXQgd2Vy
ZSBvYmplY3RpbmcgaW4gdGhlIHBhc3QsDQo+ICBhbmQgb2YgY291cnNlIGdhdGhlciBhY2tzIG9y
IHN1cHBvcnRpdmUgZmVlZGJhY2sNCj4gDQo+IC0gb25jZSBtZXJnZSB3aW5kb3cgb3BlbnMsIHNl
bmQgYSBwdWxsIHJlcXVlc3QgdG8gTGludXMsIHdyaXRlIHRoZQ0KPiAgcmF0aW9uYWxlIHdoeSB3
ZSB3YW50IHRoaXMgY2hhbmdlIGFuZCBzdW1tYXJpemUgdGhlIGV2b2x1dGlvbiBvZiB0aGUNCj4g
IHBhdGNoc2V0IGFuZCB3aHkgdGhlIGZ1bGwgdmVyc2lvbiB1cGRhdGUgaXMgcGVyaGFwcyB0aGUg
d2F5IGZvcndhcmQNCg0KVGhhbmtzIGZvciB0aGUgY2xlYXIgZXhwbGFuYXRpb24sIHRoYXQgd2Fz
IHZlcnkgaGVscGZ1bCEgSeKAmXZlIGFscmVhZHkgcmViYXNlZA0KYW5kIHJlLXRlc3RlZCBteXNl
bGYuIEnigJlsbCBzZW5kIG91dCBhIHJlcXVlc3QgYXNraW5nIGl0IHRvIGJlIGFkZGVkIHRvIGxp
bnV4LW5leHQsDQphbmQgdHJ5IHRvIGdhdGhlciBmZWVkYmFjay9hY2tzIG9uIHRoYXQgdGhyZWFk
LiBJ4oCZbGwgcHJlcGFyZSB0aGUgcmF0aW9uYWxlIGZvciB0aGUNCmxpbnV4LW5leHQgcmVxdWVz
dCwgc28geW91IGFsbCBjYW4gZ2V0IGEgY2hhbmNlIHRvIHJlYWQgaXQuDQoNClRoYW5rcywNCk5p
Y2sNCg0K
