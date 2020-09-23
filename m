Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32E6275310
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Sep 2020 10:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIWIRL (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 23 Sep 2020 04:17:11 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48856 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgIWIRK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 23 Sep 2020 04:17:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600849030; x=1632385030;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6maA6SBBQdJtjxHEFfXZZcTksTUAgV3aD/qk2BfchsU=;
  b=NRFSdLhjHDT+B2yNXo+drstl3VKIpGJ3NPF7OqIrkIR3+zkuoXVBNIUe
   2+K8gzVnK+d2TT6pjnc/UnZk6Aw1YkQ8j9gjQzN7tSC1RFcbCAhV0ot0f
   /fzjux+rjpKDsZxZG0eLRGCCbQAQbk9VyPHcyC3s14w2dDhhqP6I/kncl
   CDplHOu59kmWg1lJR2mSZcibA1YAN4eMr80SStv1r4nLHP66WYIVq7oqD
   C+kMU2a9xUHrjYDwGwAnhYJ+iv7XI9gWUa5PPjU8e0hzLC7rDWO+OexC/
   R7GknDdDM6NDVNa/5bD/8ItF6PvbirdMp4CFN1TgSCHjbVcePkc2hZc0j
   Q==;
IronPort-SDR: NFmEJShuX8zYq1xITdnJQ+Yv7FvHR8MNyekWDLNKSWhqhZvIb1IXiw/dlxXMogCXguvixfVCyA
 vny+Xywlt/mM1PKvcBU5NG9pbgGTVuA8VJHOaAxae88DzdNHcv3HJEpbV7tO0BA9Z9BjAZ0DOT
 Uu+oq2JHtCaBUMqMlosS621xlm+02+AC8UsKohMw7xEK5iihc3cP4b1JZ1hF2ZC3q9vnb9lPXP
 w9SxBjYj5SuM+stWPTisOx/rq8s6xoaoHxndwp/E/7WjHJIK0kuVlbJzz9xnf6VequErOqnuM3
 Wvc=
X-IronPort-AV: E=Sophos;i="5.77,293,1596470400"; 
   d="scan'208";a="257775264"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 23 Sep 2020 16:17:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpD5WzN6vUPD77SPqA6zwr2Gv87pzYid5sAhW/mCtpJrdRcXkLg4R6oJWCEEPAHG6NHpLWrXnFuAQAFXMrzjKPHwuxoipeP68LOtlW+LPx6NA5SgXhjuO/sKn8by4NXGhES4wC2GEDanr+ZlvQX0oVuSODrdQ4Y1TPSFvlhyTaMBdiTf30rSxjtJFq8ZayhZ29K8WPdRVe82afxc/ilf0c5MSwdtH5mirEERx5kZjXMxFY9c/bh1PskpgCbB9uOwsDBWFRQrZGIRnp237UGrYBNrCxO0SGJlumVBu8/N+QUMbdiJWt91vLW/q/LLFACK6W2yekkVTb4AJSd2luH+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6maA6SBBQdJtjxHEFfXZZcTksTUAgV3aD/qk2BfchsU=;
 b=mfip5aNsBGJdm/kG+abd1FVhosn6dMM8VyOHD0j294+l422qMAwDSAZ4m87V8kiHVDc/niMO8VbY/WkMrLyRv68yO4Vq/YmXOvL9Nvh5kQi90j3SYMs3HyP02I1NxmYNRj8YwG+hriHFiBdyB0E7tObBEkE0UGMnfCh/2MXivK4AvhyZ+lrzQXpc9ScoGmNpkgbQkUnxifRw6FBEA3lIMzB3s+dqkyUutIrBGlETqorbOzU+UPm7k3SJ9hEZvz/ylk3a1VEgCrWWh+H1joMeRVmeU8s1FuzN5pmtEwcONp3ePw5y1+0UiNhSR5CtA26jeOQ483J1rYh5N8inicmUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6maA6SBBQdJtjxHEFfXZZcTksTUAgV3aD/qk2BfchsU=;
 b=FNmT2Gx+xM4zptQkjidOFQKcAmy0E/uEfTrsiZ3FE9msyDDj9PJRV5Glx+UjdhtOSLwWJsBUYMP+lQuNTPDGsd1S/xvK+sXQ1imTJ3DxDZlMTASgXparH15NqL4s9BWCcK+tsOcmXZpQwAjeTUPmc1bxo/DAr8NHB3tyJ8Q3cqc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5006.namprd04.prod.outlook.com
 (2603:10b6:805:91::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 08:17:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.033; Wed, 23 Sep 2020
 08:17:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com" 
        <syzbot+582e66e5edf36a22c7b0@syzkaller.appspotmail.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?big5?B?UmU6IKZezmA6IKZezmA6IFtQQVRDSF0gYnRyZnM6IEZpeCBtaXNzaW5nIGNsb3Nl?=
 =?big5?Q?_devices?=
Thread-Topic: =?big5?B?pl7OYDogpl7OYDogW1BBVENIXSBidHJmczogRml4IG1pc3NpbmcgY2xvc2UgZGV2?=
 =?big5?Q?ices?=
Thread-Index: AQHWj/EE9ACKFguCd0uLvl8x/+Qkug==
Date:   Wed, 23 Sep 2020 08:17:07 +0000
Message-ID: <SN4PR0401MB359872451E6F7B11AF1435B09B380@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200921082637.26009-1-qiang.zhang@windriver.com>
 <SN4PR0401MB3598AD645D54CF397612EE429B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BYAPR11MB2632211F4D65A009DAF5D507FF3A0@BYAPR11MB2632.namprd11.prod.outlook.com>
 <SN4PR0401MB359820738AC6479F9F47FEE59B3A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BYAPR11MB26322BDEBDDB2D2402C1A6AFFF380@BYAPR11MB2632.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0bbe73bc-65d6-408c-8f20-08d85f991013
x-ms-traffictypediagnostic: SN6PR04MB5006:
x-microsoft-antispam-prvs: <SN6PR04MB50068F6A5345086D33CD726F9B380@SN6PR04MB5006.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:494;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ZaWn/odGWc2CNwAgBf2fdSOYmweIhUUYpTiKIo/bKwOrpRsETPnLTTc5SUhMnK3laQ4XsUfUrCAe0fp59FVaUWM8VOSrr9H/hPOSyFOj6TqWCaWb0CqLpl8imUeDPgsQ4Aljfp20Kt6SJEBEghPWSVQqphAcJoQpE0hd5CWy6jR2wV9MX868IDyWeuDuTm0Zg0AbGjuGzz+Vs7sjfiXL0nXdtCYi3/aiqvFNE7aLptTkqmbxk4pKPOvBkZM8hcU1El27Ox4100AxD3dgW6Ub9/vGF+9P1NyotZ2iO0lwvYlTyY6kXmklqSPSl/KgEL3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(55016002)(76116006)(52536014)(4744005)(9686003)(83380400001)(6506007)(54906003)(224303003)(53546011)(71200400001)(5660300002)(186003)(33656002)(8936002)(86362001)(91956017)(66946007)(2906002)(64756008)(66476007)(316002)(4326008)(478600001)(66556008)(66446008)(26005)(110136005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Pb80ZiFeo9PSJhthMbXWQHk7b/1vGH67Lf/mfZhB2ej9KPo7bJgHMXH7toQ7yqwkxXm1qjzQ9JPjb+/fLu53xF82hf4+pWAPzgKQusj2EAU2TzIlA+xzBf7d1V26Kp+2Lryw8LaxR1ivgB4UVD7XOHbkf16Zs4EsiRU0QgA4EpgcPmBZF5Ei/S3tm8SIIqj2WBaflrPO+gtZNETskUUTzLY5iSMXS7Y9ukRbnhxx13k3IjwXoMbpdL5SIldZPlds5Phtqc4MrkhSoIw+ArH/MlNUvPuDUeLM+hM5jziumFYgtofTzZ7te4Vkn16ywP+RrmLUFr/ZrlcJZPQpv925Nay1Hb5Zs8d/SotceKsNm3rXX0ixMlGwULmzAd0qeqmhoNpb01BpcPVgqRArk461WtXwZH2CXR2ElfshqiJ7+trBW9ufUBYl0w38df3dhBFhKNOFLlxltUl1L9C1Voqoubgys1aBPKe7mCJYdVVjCIab+nuiaCLkbYRweWQPqADpt1QvFbayf5G/VYGGL/W3GXsvPxYMgwu02UlTUNkLbzOvbKhiHofzVEUlgc7ZYEN0fhvBGxCZrXvdlbypO7/s/GybM8AEBO8H13qv8wo2u7pHB67eAm7OlhZAcPhcMX7/7EXMktVCwbUm8oNOtffIFg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbe73bc-65d6-408c-8f20-08d85f991013
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 08:17:07.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8c0GYx/LQFEZxBMX6Pj0xciZKDMFY1h1FyezN2hVz8znHL3dSc3cE5St7qx4QxlFPD3mVncghJQll7hXrT3xTcr14WKw5i9kuNAI8Z++tAE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5006
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

T24gMjMvMDkvMjAyMCAwODowMywgWmhhbmcsIFFpYW5nIHdyb3RlOgo+IEhlbGxvIEpvaGFubmVz
IFRodW1zaGlybgo+IAo+IHRoZSBjcmFzaCBoYXBwZW5kIGluICJzbnByaW50ZihzLT5zX2lkLCBz
aXplb2Yocy0+c19pZCksICIlcGciLCBiZGV2KSIgaW4gYnRyZnNfbW91bnRfcm9vdCBmdW5jLCAg
dGhlICAiYmRldiIgbWF5IGJlIGRlc3Ryb3llZCBpbiBidHJmc19jbG9zZV9kZXZpY2VzLgo+IEkg
dGhpbmsgYWRkICBidHJmc19jbG9zZV9kZXZpY2VzIGZ1bmMgYmVmb3JlIGRlYWN0aXZhdGVfbG9j
a2VkX3N1cGVyIGlzIHJlYXNvbmFibGUuCj4gIEknbSBub3Qgc3VyZSBpZiB0aGF0J3MgYW5vdGhl
ciBwcm9ibGVtIC4KPiAgV2hhdCdzIHlvdXIgcG9pbnQgb2YgdmlldyChSAo+IAoKSSB0aGluayB0
aGlzIGlzIGdlbmVyYWxseSB1bm5lZWRlZC4KVGhpbmsgb2YgdGhpcyBjYWxsIGNoYWluOgpkZWFj
dGl2YXRlX2xvY2tlZF9zdXBlcigpCmAtPiBmcy0+a2lsbF9zYigpCiAgICBgLT4gYnRyZnNfa2ls
bF9zdXBlcigpCiAgICAgICAgYC0+IGtpbGxfYW5vbl9zdXBlcigpCiAgICAgICAgICAgIGAtPiBn
ZW5lcmljX3NodXRkb3duX3N1cGVyKCkKICAgICAgICAgICAgICAgIGAtPiBzb3AtPnB1dF9zdXBl
cigpCiAgICAgICAgICAgICAgICAgICAgYC0+IGJ0cmZzX3B1dF9zdXBlcigpCiAgICAgICAgICAg
ICAgICAgICAgICAgIGAtPiBjbG9zZV9jdHJlZSgpCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBgLT4gYnRyZnNfY2xvc2VfZGV2aWNlcygpCgoK
