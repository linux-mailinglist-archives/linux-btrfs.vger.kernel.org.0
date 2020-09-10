Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F50A263FBD
	for <lists+linux-btrfs@lfdr.de>; Thu, 10 Sep 2020 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729135AbgIJI3B (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 10 Sep 2020 04:29:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:64702 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730375AbgIJI16 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 10 Sep 2020 04:27:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599726477; x=1631262477;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=PGu7s7HlxPhC9eGdlHaVcnlRYfaVHGqnURqR5/8+uUMDdN9grSIVsZlu
   jcHg3uyVL5exl80Thpj/HHosVNy611DyrfXcxForLJ8zOy0LPakSiyweI
   W2SS10QCFHYtRXVBSC/rtoM4GQ5Xq5RSQpHHn1CFFWe0b3ukJRw6Fep/N
   0ZTBzB09nSgxVHvoffWuout28AzjL67pGLmiilWvk6iu/VCsZydDLPUHQ
   BZKAoEYiCN2Zg60f4rsRtxJW+rhe2Q1soxm5gxi7I6OoiDeP4cIPAi/Yd
   pjqgq+wpvDJSM88TYJ67g1wGWbjRfShyrI0D/53QZvmmhO/tyN2hMi9jp
   w==;
IronPort-SDR: wdbqx+I+h4Rwe8fNvKmszzcuso4ofR0DdEsQThoE4CXip6nixitmwetmnuPwX8BFpOWEvPPwJN
 hI9a1NlROyap87+q416sN69HQRIvHvYTruDtt9Kp3AJ6py93tKheNT0Mreq6chXA6v/YhOrNZ+
 9J5LTTIYoriXn4kOQEz/cbY+y4KS62Aw9pU9RGLICMPFeFG/d6wbX4YjTXIiVria0O9oNan2td
 qrWI7MXe72vqlsaYhNJpVS+sFHRKd5zen9xPJHDqjEFJBbf5PpTpBLr8dbsryiPDYQkFislrQM
 e0I=
X-IronPort-AV: E=Sophos;i="5.76,412,1592841600"; 
   d="scan'208";a="148235271"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2020 16:27:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiic58NV6PJmFg2NsOowv0hyizNHb1Cb+aDqX80iQV2MNDJo1K5ltSk6fcJ5QGD4bbpbRSdULsEx7jg/xk01pDjkkhNAZhhK8VheMMMb/PR8zOl+QiS8LY9uKYZzOPMYOS3DlKZ0I7QbqjucS6t60aNwcqVNjjJ0HtighM26TwKUr0FnpBrmPz525NHD17wFHmfAqtY05NHBMO3UehiT3B7mh+NMKPN+KFxpErH2O3zxDeR6+1IszsOcZeFChvbSlehGaDyKydh088F7/Jgu7NWQ9LBwCOA/DL3U/eHqAaepYmeB1d+LHWwlT37B+YTBPiVEw1VjQCJps1gQ3bnlPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=g7yYpwFewuUljJnkX03SNhIue/VIJCX95F9EHOllSmlMEYgTQiJwrfT5Qse30nrMaOfECVEQSWE794+hvFDMbPgN53eibHOdG28zn4D2rBqDwuS0gBOSv3TgpM/l/MhoV2wtjvUIoKsL17RdFBnvtxO0cq8X7IOzl7w+sGE1oT7xqgBKHjC7F3fG/FApRB37IKAemu3WxsbKpCBuWEfADdZ9RjUXq0h6HsTS3ie5F79bgVTuabU+s5YgCyS/gVNLmDltbMNwfgSsIg1wJ4QDUk+HogNDE08AtbI4DgkOUHISEo4fsgrqy2nZXrDBHqGHmK6krnHJz0i39Gd7jQJmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PXUC++uQAyEU/x/w5gzNFRER7WHocPLTrFWXZesRlhi0PYyP/OlV3GdZX3uwTrZC3fnzhIKwDI2TG2o9lSWW/Y88db3HONexKfmHEw7RQLjD7mSP/CrIcjmhCqmeZDv16aedxxWRaMyhPx7sySU8d50Am99pEVl80eNjH+38GQY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4045.namprd04.prod.outlook.com
 (2603:10b6:805:47::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 10 Sep
 2020 08:27:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 08:27:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     YueHaibing <yuehaibing@huawei.com>, "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "nborisov@suse.com" <nborisov@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] btrfs: Remove unused function
 calc_global_rsv_need_space()
Thread-Topic: [PATCH -next] btrfs: Remove unused function
 calc_global_rsv_need_space()
Thread-Index: AQHWhsDhxv21KuizVE6Qrv0Uy/DrGQ==
Date:   Thu, 10 Sep 2020 08:27:53 +0000
Message-ID: <SN4PR0401MB3598643129987ED456C0B63A9B270@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200909135142.27352-1-yuehaibing@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:2cf6:d0e8:5d46:4118]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc9ecfeb-9ff3-4c48-654f-08d855636982
x-ms-traffictypediagnostic: SN6PR04MB4045:
x-microsoft-antispam-prvs: <SN6PR04MB4045362D3B9E5DDED92154F59B270@SN6PR04MB4045.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SMQ7tHbE58uNlJLLgBFeOBsLx4BJ7dbGRAhGBBVoVAocyUhA4PP7hZkzBxeZw0RfZiXSAqbl+yQP2oPCu70pfTWzRhBuSeYH4hSQx+YdNpf+0NR5Gv4UBc10H3z9OGq9Cm9Rsoc32HUKKRMtaS2vg+Ym06sL1pSi/bzXKkxvEUYyEQFYBPq6CYkBdlDVSIC+FZvVJvdpP++1v0lMVE1oTYb9K7NwWJZ19h6PoOYq1EHS1fsxfDH1KuqvLICeUcP+09Ie9Bg/+pRP+q4/y34HCc20XjBBGVffZkGVaj4nVm84yGetX06/V84QrBom6aBbEYHSzFsjlpcVqob+KPd1bg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(366004)(396003)(8936002)(316002)(110136005)(54906003)(2906002)(8676002)(55016002)(19618925003)(186003)(66476007)(64756008)(7696005)(71200400001)(4326008)(4270600006)(9686003)(478600001)(558084003)(5660300002)(76116006)(33656002)(66446008)(6506007)(91956017)(86362001)(66556008)(66946007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: krQ3ctV7dDiJkhf9SV09p15ueHSrrFiGNVWKWgF/d9ZmdVnlhXSvRp684whiY57jp7ZXMY5VFgggYzfh9/3GExfe0wGG/O0+dF21/8oj88QTTPb9LywRmiCbxtrXESnWOfExbVHqXf57yV/wuh5pnyKyFYmEQdvti9cUGjByKI/tDGYk7ob0kLDeUbz3yQQZh1AANCH5tnL1b43Euit2l1ZiK7J2SN/0wQk0K93Bpb+4gx62xdC2pj65gdricALkMtJNBnGRFA4wkRbjd0LWrYRvTfOhd7hnOa0nKe9HlgoqI0VTiqJxs/TAsdNJMq+Rr/i/8ehgDuDtXo6ZO+0YCuc3WVqrvfsLsYsnmD8eNqY+BP6Y1irNNfLgjVwLIV2AlO65rdn7DkvcoLe2EYrr41UaWKMhJFL7/p8VNAWgbIPYAmQ+7VPbjdyRQMFO5ueX8FHjZ4iF7VNE42HL40BBtTH4ThxSuXVKdfxa/Gz3OC3lhpXHVgGT0VemriSd9zokbBkNPBLMWQS0eNJ2ZCm0rEEdCb74GfapzpMVo/3nP0rWBKefBh5W1NjgIGXVTLNPz3xutyGTVxM40J4NhanHFb1XNfyhmGSAOS8Xvh7M62rTd7M+wBYFhTPXgFPzyM8emjEVjBIjVo+CrR9lOSvycEiVv3qrDRyGnsMPVGYJieh2SJhd+4Q/huO7xQRgK4g5gCtQPMoyG0cEczzyPGP0+Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9ecfeb-9ff3-4c48-654f-08d855636982
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 08:27:53.2312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2okw9WZ4o1T46KXpd9diLw55xy8w0zWaTtYjlnjMag/wGq35EDk0N71VxLRa35JcA0UC1P/8xjXptt3y6sTYVGgs9qNGR2a7zMdJJm3V7VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4045
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
