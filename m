Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEE4154814
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 16:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgBFPaB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 10:30:01 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51185 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgBFPaB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 10:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581003001; x=1612539001;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UgiOY14pRCBuqRPMCWoT/HMod020mK9z/TWi5Sor8c0=;
  b=jjK2HQ5yrLRBPzbixZTs2QKT33jO5X2EkodH+DE31dvI+KtLgg/8u2gO
   Vs2/DzTf7ZQN52wrtuxwdN5OXr5RXMFa6l0HaGZCXqlUuODu8jIjkjHCN
   S/WtqJn0AT7sgz1Jpk/WA+Q3JNQ1IGe1Gx/CgfRmMiZhuH28Wrbod+cNt
   2adkge0WZbJ49WThVDVpS47Iwysn7FXiOLOXPaYOv5iFbLVJvENNIJpKx
   tpWigPb7cHTVKzdf48HiNN7BnJAzeIkdKrpkbKKdDAjP2Q1fDKjSNYh2E
   0AUdZdwJbmQZqosO/+yCubC6A50/WckuGgpY109LU4ESTW59j76qLqfmk
   Q==;
IronPort-SDR: 9caveuJr3FjlD+jdiHWxfcMdi2GEFqBWLUvQeWKqAEvPw293+6ozTD12lAIvau6h+nkJ2AJo88
 COJNpkGBuSNLQ5fNcU3RcWyCKbDBs3EDTixCrRKXhh0kWPf+mYE/vQE5TQt7VUemNF/jMuFLR5
 fTxoi3HBgKk+H9VzI2FGHN7s2DQhb2bzK72FSEOCp9baD1UsSvSycBfBr97TxjWTRgRzwGcx+d
 yM7gXnmV1thu+GpnzSnA6EYvpoy4ZneBld8bjvnbHdLMo5o9UrDS9olJQUHyE/jvMkaQX8MAkT
 qrs=
X-IronPort-AV: E=Sophos;i="5.70,410,1574092800"; 
   d="scan'208";a="237232034"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 23:29:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6jEFun5TntXzI4Xa/6E3lAldhYujJN9VDQKVVfbYI36JYcLIeOORqGHKJTiRgSWazlRqyUQihP4yW4RgPgQjVwWVWCsvEW6ozVIAoQmyrR00yjlNnZ6vm7S7GLMJIeggrNVX+HMkRG8O8Y+Q8x7Dzw/Q9JJoK2cNyCXo3zZcqAtlsG6/J03RmfG0sU83GKe19lVcvCSqU1QrCeVPSawC55sWoOYFPIfW1KSRaD79DOCD0DZz3Ck6JrbRPCdEVQQ0HMu3ofVfHd4Syq8Izk8e5QGQowMac8bwn41MaEVeMzfRilovvEpcS2Jb8jhec30I/7vWLxVXhHBUDNR3MamQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgiOY14pRCBuqRPMCWoT/HMod020mK9z/TWi5Sor8c0=;
 b=d/EZFy7i8zZFQ63M03vvSPBnIjRZ50jkTSpPFivu22Ej2Yk1wmLdrdKIeQzfqH/ln80kXQJU6b19wHq6gub8IyYqyVCeYZJBqJsHT+IVLDQev1qDUgll+OGnppcqF9deioY+/hjBrPVDPxpyUX+QZMdZLc6Vv1DmUvMrRIUuHNa5xApwiFKvQ+qHfQiA7qO50W8yL82o28dLC9z8/RRwhTTglWmdXhFT5z4IWId6EnEuhMygVrCKrHwsO1171CZ8+m6BT8mSeNtllMI+V3D/eaon7zeKDxinobc1P89rOu8UB1JNl30YKTHkKd5dlzzfuaeOCgDuMvAVop9DoD82ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UgiOY14pRCBuqRPMCWoT/HMod020mK9z/TWi5Sor8c0=;
 b=hgzBQPZmXoqIrMYD+SXmPgVP2pmKvRqFb9yOhWkJqsXov0bO/YdTRkHJP8tuVFS7SOLeykU/fFoiCEuBfS6/aAlDQ3xKPvWpZjttVKErM3MQngotLad+vdSudlQTC4DcPVrgjmhHXKPdyCgYt1y1DIUuyKqAi5jXFz3+q6osUFg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3536.namprd04.prod.outlook.com (10.167.139.157) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 15:29:57 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 15:29:57 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     David Sterba <dsterba@suse.cz>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] btrfs: use the page-cache for super block reading
Thread-Topic: [PATCH v4 1/5] btrfs: use the page-cache for super block reading
Thread-Index: AQHV3DH3mC4sQyE5G0ifuyrJtqLY6Q==
Date:   Thu, 6 Feb 2020 15:29:57 +0000
Message-ID: <SN4PR0401MB359856AB4365DC83FBE99E0A9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200205143831.13959-1-johannes.thumshirn@wdc.com>
 <20200205143831.13959-2-johannes.thumshirn@wdc.com>
 <20200205165319.GA6326@infradead.org>
 <SN4PR0401MB359854D81C504BBE28B8B2EB9B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200206145759.GA24780@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 857b3fa7-61d4-4c4f-204e-08d7ab196c37
x-ms-traffictypediagnostic: SN4PR0401MB3536:
x-microsoft-antispam-prvs: <SN4PR0401MB353638E269F853426B16162C9B1D0@SN4PR0401MB3536.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(136003)(376002)(366004)(199004)(189003)(52536014)(4326008)(55016002)(186003)(5660300002)(64756008)(2906002)(66446008)(6916009)(81166006)(81156014)(478600001)(26005)(66556008)(91956017)(76116006)(66946007)(66476007)(53546011)(54906003)(558084003)(6506007)(8676002)(7696005)(9686003)(86362001)(8936002)(71200400001)(33656002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3536;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BdD1KJ1F+LwT3viGeehZrZbq7yyfkH57Q3cWddzXQP+sadq8c3eZRs98euSAPKpwLRfwJJwdix6FaBDF8h8rpdWvQJJ093xcEkE3uoxmDCKjOZ8izWZl+4Y6IxOMnYNGJEELnaUhQNjGYDa2nAJ4AEQRob4FRvB5Hiv9sJi6ze1qMvDH1O5BYiw5YB3RraiJRL1/Qlzra6ZQqbkKfdbxYPApjQ6ywn4e2bQxjgMXqC1otJauJBfXFHc2oWrVnzSPmV+3aSy2f9ZWEwESF/POPE8Juamxoatxf8rXa0KkS5GEuWVCmb5xcorvF+lFEecZPMD8ekL3znA0diUjFsuUHst5ZPzzOHOyzQYtkV816auJfGy/kMEfGFNTVhm8LsaWpD9yIbyHqzguWIRsMCMsMrDHCT8bp7wdSjTKJIaCoS6qOLKlnRSoD2230tXc9q94
x-ms-exchange-antispam-messagedata: XSVAZpFrEjAcqPBwlhFfUn53dbKeNg9OuvDvriviTZgT6PPqH2eQ8OB/f0iHfNv4BUlsm044Y+HwwDQHMaGP3ZhY61qG4qMZXlV3q3u5iYd4ci37LmsEwALb0NBUDgKmN1MgjIVGhlJW1/uBRjvWZA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 857b3fa7-61d4-4c4f-204e-08d7ab196c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:29:57.3089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j/gsoNfMMTdumevjFnSa0CED18WU7rUeYtUAENkg59Gfraxg+vF1W4OFhao3mDyBZUAVdpsBEumRXJsslTcXbxhVETE7t0ZqLqPAThgD2FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3536
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/02/2020 15:58, Christoph Hellwig wrote:=0A=
> Also I just noticed don't even need the kmap/kunmap at all given that the=
=0A=
> block device mapping is never in highmem.=0A=
> =0A=
=0A=
This potentially touches more places, I'll cover that in a dedicated =0A=
patchset.=0A=
