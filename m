Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52F361544F1
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 14:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgBFNdc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 08:33:32 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:21892 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBFNdc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 08:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580996011; x=1612532011;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=dEhjXNBl+Kai9uwhSIP023MAEWKzKnS9+grwjBtlT/lUpHzWexcePyl9
   qGyJLKqJWqL+Pvqtjk/nIImZwS7xO03UHb4NUyYLZRoSAcfLpbZjGne9D
   tOq8IzW3fTce0Yy6bOdjr1PaUi0l3oOMKo4Kfa5/hjyYc07quJXNARVSn
   Ktc2V0TuMCFCksy6ihf38COEEROKWsmvxBgNeU10to/ERgJM9VeY2FbY4
   578XvK0KRoHASLcq2TVdQC7HVDp0hG6wF0cbk41OcWMrUxYQpj7jOLqaE
   KBZTpSpaeaeM85tTASSBKJAjFOiQcXspJDV/1Ck2ILP0OcoIo7dvkcgEw
   w==;
IronPort-SDR: Lxce4hrmbo+3jNJeYbsBYyJlJYLrxz7Rp64O/msjnf4+KM2maPPtVBHl/79FmwPrPveWKGwDSb
 rWO6hJ/q9D9sdKyLU4D+wDjrlp9/1vUekYfDeQgYvGbOoxe1c3b4yWrEezw1DRlzwaCkgXU77p
 5seRQc4DVoNh0Lg450NgIrqiPzuTP/7k9beXx0I/ocK5PNgQVIyFV4UNeM7UtbQfVOGHIg8lJt
 XpdHMSndhf2F/bpspYyi3Ea1zIFAEj5YXsHk6mDxI4tsz8VnlX4CKbxpsRMy85xeSRIkz1IWaN
 QY0=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="129251988"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 21:33:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBSSn1WeB6T7lQfvCdMP07+ENAd4vpuyq8EPp/x7YnpzbjM5jIdWzc/0lG+yr9ai2vZmOrsvWg/0VLKb2BvKhqnVX2Dl0m9wuv/xuAQgMyAGinHYMSoPro+eVS3ECg9qSEAqTl1Fd+g4O+N8zXS7/NhguP62O0lXCwzHeN4X4iemoQoYS68SQC8fJj3jI178tZLcUSblxa0O2ycHu28s9IqXzidqOnasY/jKfWvW0GIUVsQwFMyIX4E/Nh6ZvoGTm6U7QcBo6wcb8WX9qyNP/VifyDYrKAmpJfz6PeeF4fxcpC70XqRbqNsOP6+thLQYgeQAwotz+hLStiCW3CXoxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jOraxx3dYcZw7/6Loo6gk2TszLfHAlmRyc0SD2Ys9g+z7YCExxBIVqukGFjdsBBIDjcTKwCLUKUsFVp66jDovN9WxuX90NNDp6riPh1ZSpJjDVLO14Axc9apo0KixktDSf0R5Pz3xJGkJrTn5xqME9ZPdrGhUavUr4nxtAFzKkWGiV17MoofbbezOId9jyMz6fgBsVdnnNazGge/CnFYgQ+dawvZfjMLseejqfzPvRX+wneRZyo/LZdsRmk21dpyKa8xkr9sd+/qSI5pqr5nyP7Dzcx5WngvaxYz83MCh0rlJ0iq5e707/YTZgoFYOAt3wooRO+5SMNpgwJsgwJgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=KLjBfQoDzkMC6PpQOI8qarOBeJEr50ZFCHgK7hk3LNXRJai2aSTjjKjwsmaDuaYSAFAAevBSzBiP8GM5vEZxDERMdGSIojzJ3AIlrHlMLJ2aF9QnmWqnuaQFA4gzN9r/GWuYHrBNosD06g233pnhfZts8pRYbw0RuX16CCiSvfQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3693.namprd04.prod.outlook.com (10.167.139.159) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.30; Thu, 6 Feb 2020 13:33:29 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 13:33:29 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 2/8] btrfs: drop argument tree from submit_extent_page
Thread-Topic: [PATCH 2/8] btrfs: drop argument tree from submit_extent_page
Thread-Index: AQHV3E91Bqm5kbS7WkCTxqqmOp3g3A==
Date:   Thu, 6 Feb 2020 13:33:29 +0000
Message-ID: <SN4PR0401MB359863B26ECD31DA5199DCD79B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1580925977.git.dsterba@suse.com>
 <a54487df38bbbd4f6149b2a7bbe86247fe5c532e.1580925977.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3611952b-3f28-4e48-a4dd-08d7ab092749
x-ms-traffictypediagnostic: SN4PR0401MB3693:
x-microsoft-antispam-prvs: <SN4PR0401MB36936D5319D439F7E5ACF55B9B1D0@SN4PR0401MB3693.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(199004)(189003)(86362001)(52536014)(110136005)(76116006)(91956017)(66946007)(316002)(33656002)(64756008)(66556008)(66446008)(66476007)(558084003)(478600001)(55016002)(5660300002)(9686003)(7696005)(186003)(8936002)(81166006)(8676002)(2906002)(81156014)(26005)(4270600006)(19618925003)(6506007)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3693;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hJ8FD053y5Q6X2SS1f2nDRzt+Oe4ojfZnwl8n4Mn4w0vcpoepk1WHNBNfwpXssb7Lqv4PlwBHiWP3lEa4HfgDy2qRCd2ATio7l9FQiWge6tlb9Q66Rca40JKBoQHx7LR3qL8httJlp3R/flz86/sQ0ysrAJS1G+FZBWfb+dgTOzChleuUrSaWuC2q26hgtD1pSw5QjUyorJr01Jz5Btq6jD8rMzueMK0nMk5WmgN7CPAZEd8ZyrtOPOl2RZ+tulOof1Wyo2J4NzBCJrVf5zMjempljiCVZGyHgkSMeCm5/uNU3PEsWidNuFnRsfsnELXHrsk+y/h+GuNsL4XPT93XnRAxdZ1Yx15+HsbASIz0AyWuP5kg80e/lZCE08x+I5g8BI83qz3JBc47uuzohltw9xC/FniKnqddSznZTk3aRifnjG20jKc89IisNMNbfce
x-ms-exchange-antispam-messagedata: 1YEovko4/KUzyiRqI6XaQ/1oWxnLXX7Pd4JGn/BOyE8/eiVtfPTNFcB/zDdcnh/5d39/BxiihddCAI2LVwk5XZPw0X9jRW3TsH42V4atXzWavlT1T/T3PCx1fRJu4taJzwAk/nuDqi5j+oCtGmfNkQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3611952b-3f28-4e48-a4dd-08d7ab092749
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:33:29.7518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VJBBk/i0vUuN1AFOvzXiOyfMp4G6k4IpeOkeOKR30R8itInrbAnIlvfV6OsFQl7xwLh6+uDn6KfGK5qQTsQO0gRaHRRYwtS3nnG8dXtGm1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3693
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
