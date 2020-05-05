Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886DC1C4D58
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 06:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgEEEkE (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 00:40:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23434 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEEkD (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 5 May 2020 00:40:03 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0454bEIK020854;
        Mon, 4 May 2020 21:40:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=TfSfp/HN30vmyjbdVMev9jz9NBoVu6haUdVOqbPT7F8=;
 b=oALJsLndLw8xu04N44v7VRjaaNx669rziinEgtqwroegUMW1nK4kpFo9rU6SKUpy3iEi
 bNzCfNlY1E+QTPI6a1ia5Vdza6HJHTy41hkAHMVq4jlJXSNCZkJ0jy6iAQpONL9/APbi
 hZnRfmU3QFUhs47fzIWG2g0Lop3O766Pvxo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 30tfp5d7k6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 04 May 2020 21:40:01 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 4 May 2020 21:40:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W5NXSohmWV+cql47IHjWFUCPOhqmraBdeNowJPuh/9H3L+ieXeofM3o51+Xnk3YCaJqgNTG72M3sreMd0j83PN9XZHWGNIOzZPjZzNXQN4qiuEq0BkZ28Ll/MaWEvKZxYxauSfZ4WxMQwRpcmms6suE5nSZSHADjsYynaIaBRrkcFNFQCNJlBsrQMMkIErk3qVP/7Wq9qKIQ60oUoHNLWL+S18C6eDxV3gUlNFuynCPej8PHP6p9M1H7+P6glPrJzyc5SgmA9mdz5Y/kQ6r8uQ6DZ/xavpmfOtcEMzvvohm5Hu1cgH+6zA6CeeAFiYwe93smf/ehoVlvIHeovWdb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfSfp/HN30vmyjbdVMev9jz9NBoVu6haUdVOqbPT7F8=;
 b=GioFWvUbuPikmfD+8TkjSNGcp5t+o6G4gTVtKGX+cC036mZvmFjgMce5NfK/BqxkEl1a+tQK0Sk8NxLi5MRlutAUE4afcHcaaoHh6oaoFi21Hal/9vVW3FXzzLr5AnMwGO50AfyVTequXd18h7QPvqxGlvgJ3E6hQMnaOmdiD3jRuF22gNDoubZKfWiytwTO0MWhgD5SNH4PEqab8h/wThqjsstOOgvoNeX8IT1UMEXZ/if2wP0OwUBZCpww/JeOnKKvy8qTr8h0gBTtONujKkf+vmVVzxDEUJbf9egbGmS6lyucgjasO4tlAa3tWOI4E0+58qBpYwyIXDaL3dewIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfSfp/HN30vmyjbdVMev9jz9NBoVu6haUdVOqbPT7F8=;
 b=Ce7R5+soRL9CgLiLMtXJINCMHpuiEvIeWQN7f1DRmhLBYKFO0PBBUyEmwjVQm1DwPRfRPTW7iTz6/mnvA46zHi9YpQZiRYYPGTAg4S/K3eDh9JGAiv97kQwdEoFYPDXI39A7lPnaoInz/zNl15AiEWqxMr0XDsV/PpXWhWGJev0=
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by BY5PR15MB3602.namprd15.prod.outlook.com (2603:10b6:a03:1f8::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Tue, 5 May
 2020 04:39:45 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::6994:b051:86ba:84f5]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::6994:b051:86ba:84f5%5]) with mapi id 15.20.2958.030; Tue, 5 May 2020
 04:39:45 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Chris Murphy <lists@colorremedies.com>
CC:     Btrfs BTRFS <linux-btrfs@vger.kernel.org>
Subject: Re: supporting zstd fast levels on Btrfs
Thread-Topic: supporting zstd fast levels on Btrfs
Thread-Index: AQHWInz7z5rxJCDDa0eCFg6QjoeNkaiY6WyA
Date:   Tue, 5 May 2020 04:39:45 +0000
Message-ID: <BBF3FE73-8797-4E4F-9802-984897A42AF1@fb.com>
References: <CAJCQCtQSevDB5kaGTSS1TfQKen+BY5krKvHUZc4MKVPZCypiPg@mail.gmail.com>
In-Reply-To: <CAJCQCtQSevDB5kaGTSS1TfQKen+BY5krKvHUZc4MKVPZCypiPg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: colorremedies.com; dkim=none (message not signed)
 header.d=none;colorremedies.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:1e5f]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11a43d0f-43bc-4d24-6132-08d7f0ae5652
x-ms-traffictypediagnostic: BY5PR15MB3602:
x-microsoft-antispam-prvs: <BY5PR15MB36023FFE8691EF4DE773479EABA70@BY5PR15MB3602.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LqhkopxuNAh00ychpNyB2dEtaj4qkofsL+GhF4PUKUqmVcAl9ZDrQCh6oeDufFxlI0kuh6G0iILD/8OnrUKkxjGGH/r+O9LwoK4GGO+bWKdS4hC5kAteOUOu0lQo3ZMtTmjScx7H9JTgZkt5pX5dYxEtbL/LMtN3lXI3elR4Xi9a+95Yh52xv0BbSyrzRCp2Cfc1nDptJ+rvR9NQGjF+8loOdjL9Vd4gKIQpBvNh0v/P96kmnXOD3RI9+s7qYvl+9CR7diXZEpL5wEdkySsO3vYEQm1NlvuBZIEYWOB62XgOyiaTp6BkkBKaINHl1Up9g86WjHm09Wj9chLSbTM2+aHozN/gV9Glcna7W4pIDEqo3kZACXj2IEHlA5T2pyZwnCsTYpCa0qQ7i8R4btra13nH1EHraOByfFYF45yrgJuVg8Tv7YX0inx8zDnhLPJoFhYzK14wY7zLaAwOzQXpIQD2vkykaKnptH/64q3HC+2AMnBDoKSNQQ2/0FU6eIIU0tm03M69ESabnvK+aWVZao50XZTYhPsXTb+o+ySEFKdxJcaseVrplQ5+UkSNw1wz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(366004)(376002)(136003)(346002)(33430700001)(36756003)(4744005)(5660300002)(53546011)(6506007)(33656002)(186003)(76116006)(8676002)(8936002)(66446008)(33440700001)(66946007)(66476007)(86362001)(2906002)(64756008)(478600001)(66556008)(6486002)(2616005)(6512007)(6916009)(4326008)(316002)(71200400001)(17423001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tG7I4rWAtwR19EqIK/MN+eUELAfFUoOftkcGp5S1VCLoFSmd3brl6+qnsCVDSaMi7jdMVQNLkM5vNuadhuiO9XrEm9hguDoH0SVJhr4PtCCyNsmJUbolKNrD3ZBO3DsS5Hmdjlg+nVKoiG7brL5JA1W/Qpt0Ik2No3P2ujAqiIxTPGzYGRvxYoCG/PE9eSM4xRwVM3YHeWPO93voE9zSFmU/DJyD1F+qftOIl7qMJ5tc727zwhYm56gaY0pIwHG0oXcjgVosJ+BJUyr2/lt+aaWFQ7/pSLuZcPVxwf39GECTiqt7q2GY3rFSL6rIGzwtpSCQfOPb77VHwiVQc+gM5UlMETc+8Z0rEf/i2JEftQ6DAvHZyusG+JYSFZAzesk3s/sGypTe8U/+jTtW7geeS/nxsv/mO+bJ6k3qMUw/Dh+eEQ4j/klS8exiedyWA9OP3tKeh/HGR5uPKuBFoNyvzLCi7CNwBbbJpv0nQQNAOlu6lio+2kwG8Bp3ZgMhpCdC+LQR89njN+8GH+ivCQdD2loBefFV7tkzC/90XacSDh1tWCO8vLVFFiDHkgGcZbOdx6Tp91EntFYAlo+ovndHlnoUTG8qKXc7RH29ouTu1/ulNYIT9/56RiN73/4VnA/fuj6gksJfLbLTxBCIY65E4EHevM28DOCvvGT/vRvMHsfKLV/g/31LfBKcezLY/8tvoaBgb5bXojL+Pwpaj6lxyST8S60PxSlTyt1z2x62UxCAkkcJzUmt8Ini5xir91aDKMFei5f9YCeicYW9GlCB5E702NKCUv18I8/OIR61XJKNcDIhjX+udxhIO2mwqSQYmuEX7x+hZ4rPIubS77GsFQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFAE797933C1E140A0A403105B2672AD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a43d0f-43bc-4d24-6132-08d7f0ae5652
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 04:39:45.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbdSUJj2eeCPpphdJHONWZh87MKEK6AGwucHd9cSrIvVp38PXqDjhMuvKhO4SiEG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3602
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_01:2020-05-04,2020-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=702
 priorityscore=1501 suspectscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005050038
X-FB-Internal: deliver
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

PiBPbiBNYXkgNCwgMjAyMCwgYXQgNjozMSBQTSwgQ2hyaXMgTXVycGh5IDxsaXN0c0Bjb2xvcnJl
bWVkaWVzLmNvbT4gd3JvdGU6DQo+IA0KPiBMb29rcyBsaWtlIHNpbmNlIHpzdGQgdjEuMy40IHRo
ZXJlIGFyZSBmaXZlIG5lZ2F0aXZlIGxldmVscyAoYWxzbw0KPiAtLWZhc3QgbGV2ZWxzKSwgdGhh
dCBsb29rcyBsaWtlIHRoZXknZCBiZSBpbiB0aGUgYmFsbHBhcmsgb2YgY29tcGV0aW5nDQo+IHdp
dGggbHo0LiBUaGF0IG1pZ2h0IGJlIHVzZWZ1bCBldmVuIHdpdGggc29tZSBvZiB0aGUgZmFzdGVy
IE5WTWUNCj4gZHJpdmVzLCB+Mkcvcy4NCj4gDQo+IEFueSBpZGVhIGlmIGl0J3MgcG9zc2libGUg
b3IgZXZlbiBsaWtlbHk/DQoNClpzdGQgaW4gdGhlIGtlcm5lbCB3b3VsZCBoYXZlIHRvIGJlIHVw
ZGF0ZWQgdG8gYSBuZXdlciB2ZXJzaW9uIGZvciB0aGlzIHRvIGJlIHBvc3NpYmxlLg0KQXMgenN0
ZCBkZXZlbG9wbWVudCBzbG93cyBkb3duLCBJIHdhbnQgdG8gc3BlbmQgc29tZSB0aW1lIHRvIHVw
ZGF0ZSB0aGUgdmVyc2lvbiBpbg0KdGhlIGtlcm5lbC4gQnV0LCBJIGRvbuKAmXQgZXhwZWN0IHRv
IGZpbmQgdGhlIHRpbWUgdG8gZG8gdGhpcyBmb3Igc29tZSB0aW1lLg0KDQpBZnRlciB0aGF0IHRo
ZXJlIGlzIGEgbGltaXRhdGlvbiBpbiB0aGUgbnVtYmVyIG9mIGJpdHMgcmVxdWlyZWQgdG8gc3Rv
cmUgdGhlIGNvbXByZXNzaW9uDQpMZXZlbC4gTGFzdCB0aW1lIEkgbG9va2VkIHRoZXJlIHdlcmUg
MTUgcG9zc2libGUgdmFsdWVzLiBUaGVzZSBuYXR1cmFsbHkgbWFwIHRvDQpjb21wcmVzc2lvbiBs
ZXZlbHMgMS0xNS4gVGhhdCBpc27igJl0IG5lY2Vzc2FyaWx5IHNldCBpbiBzdG9uZSwgYnV0IHRo
ZSBCdHJGUyBmb2xrcyB3b3VsZA0KY291bGQgYW5zd2VyIHRoYXQgYmV0dGVyLg0KDQpCZXN0LA0K
Tmljaw==
