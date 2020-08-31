Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0505257A46
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 15:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgHaNU3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 09:20:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45489 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHaNUZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 09:20:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598880025; x=1630416025;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=nYzWg/FZaFLZEhPx01jVAyxXeVEmTLaeydr8kTvh8YVXhsA2DW1xwGLm
   U1HWRKj3mk0Nlwy6umDX+R9sffIl5C6l9k2JtZVHlKg3lY1hV/sJPgho8
   JlvaqUOdph2g60EUY/XQzRkrcUu90KiOoc2Rbwtf8qmZCvbSbxWvRvmUp
   JQ9CeRVf4wR5C8U3j/5DtJq7xtRJsQzSSqUG6ut1WS8cYGoPG0O51sjk7
   EbPDbcNsvlRnjmEKVwtKLx7bomhSnANrtL3yoCTn5dWpwMq12kgT/SSeM
   AJZ7/Rb2QCj588KhRB+P+RZtsHN779oZ8KykrYDHoc4cQM36jLMvb0ycc
   g==;
IronPort-SDR: SzBQhkJS3MXmNovAmrXiAhEU3Nql6t0SasQCJfATJhrowPO0UHf6bogxcaBACiqfDODEqW72Uk
 p03y3BM//e+qZHt7HYJpu2VrGe8DDIJlOphD1V5OBpOf0QthuD0Uw6/iT1SaKxeKc9z2WzCHdD
 KvswBrF45avccHoOuhdtAOhtFmkts/pzt8JWFppHfVMmAtYcuhBJCr8rp/5w1WwUFNdtyhSJU/
 IuqAjxa2EKzaa6bDeOCUFvKBzqBlSj4hHTNp2I7zF4h76lkAaDrZy5jVybLp9/ws9207EB6vmS
 SzY=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="150562531"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 21:20:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv2zX4U5iKK5rYKS++/7bDsv7LuAIY4Omm2K7PgGSeXNYma0hIMtvxJYZsEYrHWPaCD+Upm6QfwKz5Z6Xp/4sYu1XPCSPCBYak5otE7z/1EVf7wc4FYKQKWAkC6XHniPJYITcMKxLvTLTYBxS/5+DERHNyhYKGotdDn7WqLCCPwzzMVqPVxQbSbOntvJlUJQS2KOSoy7+j4t9Ij3n3ZBNkn4S6I45SZxHtyzTqD6p7HSkw78jjC70JXhkx++YOZaT/xnP6eHkk+stTbRoDHHHTnV0HwlQY/wsxORCm1LukF/e+KKBIKuEmG9fIRt+jXCpZSwNsP/PMklOAnRXLSmTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kIz+YYoSc5HgGBrmk/Xk7UtJdf8prwKKaQYNM63nGLx9R+015xEup/7BjjMLo99IOaAHY5XR9Dq160lWJuI4UBwc3xBm/azHPWaPNXZPhncyea1A8twhiKiMFK3BDQig+DDb4nuzu6k2h81ESsBfBU/RHK5XLYqxeVVYZsqQy3f5DvJrYpu/O2jQ04ZTe+lZ5ILDRqxduc+xDBDSqWY++6dmEeiJF4Zb8OiC3Xi3XUifooNVTZPQ/NjKc9V/+1R+sudETKTcYNpzTiEo5viVACT3zQwAsIWkAplhg/mgzxJGd9cLVAZ8CLAlRlyG+ny7lrujhK1LLUJBnvoK7z2icg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZwJJjSYO40fcKHUPkXlDhOsQ12RdBzonvYcLDO3kjBP7G2vYza79QV/JcAwoc76eW9hI+AVTXUBPOHlVZIi/1U6Kc03uz6ZiVEuNKoQaS5/mjhwB902TK2tNhSjIjRYw+7k2bn1ihh9+5KrpC5hjLTiTyGNV9oWuVj602so/OAY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5117.namprd04.prod.outlook.com
 (2603:10b6:805:93::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 13:20:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 13:20:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 11/12] btrfs: Make btrfs_zero_range_check_range_boundary
 take btrfs_inode
Thread-Topic: [PATCH 11/12] btrfs: Make btrfs_zero_range_check_range_boundary
 take btrfs_inode
Thread-Index: AQHWf41tWD4JWJ0CCEu/5JgdwU8Bkw==
Date:   Mon, 31 Aug 2020 13:20:15 +0000
Message-ID: <SN4PR0401MB3598DDCB513EA83EF3E86AC09B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-12-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c51:a08a:7ebe:d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: bbbee39b-b44e-4377-815c-08d84db09955
x-ms-traffictypediagnostic: SN6PR04MB5117:
x-microsoft-antispam-prvs: <SN6PR04MB5117D5AB3F9DB95FF93AC89F9B510@SN6PR04MB5117.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1lyO6P9vXRupgN48lsimK81bWbMMMnSn+WNWSDdr2f2W1/3trkytOtQsdi/WmIRFNcOcYbRodI113ZLxIAu3Y1IlIW1/6MTS48frh8yKTpplzEW3GPLk39PqCcnpLdFliXa/g61ohtRTtV026iREjkKvi4e2quepEwVbtbVKadS4L+IEUlHdBio+T9lVoMOgBlvo99Q7oSOjypGxZSvoYuoQno6sn9tNZANafGyzfFDd2rxWP8aQPo6p/1kINcmmsbD6gVSSo4xRHWTPSLYwzpQrMagQCaDkkSavU0ieJu2H29PbSp+0ji49LQVD6cbeJDVXxD8mK32aj62vNZIcIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(66476007)(86362001)(64756008)(4270600006)(6506007)(71200400001)(8936002)(5660300002)(52536014)(91956017)(478600001)(66446008)(76116006)(186003)(8676002)(66946007)(55016002)(558084003)(66556008)(2906002)(7696005)(33656002)(316002)(19618925003)(9686003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Nh4k3Onorr+MpllcrubioMsoKSzeGgjKQY+KtDZBpYzLXH1lUKnQWKEwCeOGBoTY2hj73H2QYrJrU/5mYUXU+JfyHALv+i4P2voUl+H0moWyAtoUpl6rW7qOEOp8K3lKG23WayTUx5RBphlrbSZhKJvy0tPcWgov17cSj13FfpKJwOD0NZghcrJKfLoVCjvoN3fzoa2hIPZ2TiX3wcx/qLMMiL5RHU/L9KHUvSaUgwkhe6ikuuV64zER9WruMsEsGxWYMBDYEMEB0AQJ3qgrpIw3gkXAKWereiikG+doJbt3TWTM9rW3SxZW88yusv6j6Reh4BMzCACVP3yzKUzVr+7uNDnvAbP4132Cn40ScLC8nLGVF9vYa3558oILiChfLOWOqrjd3TQWM5nWqbVbk89zEADPdMfBKF39vR/ReXeDhoHH2IOwtOvmTDEOoL0Ht8D3PX8zR4XvCFVcQph1Rx7L+NnH9mu73Qet5yf9/fYbowi6rUV9M8+ePn9gPuPXIvsHaOllrCoSoAe7A7tb2hCO/GdQxvDm6Q40qV/g1PGL4Th2i5XkoEhT6h+Kul3nVEWPF6nvANgSxALzDbVusFEQr0+VhNciY8eK2X/iehxK+OrbDzEADbeaCiYdhoGro7MGdR/QID576w3plVUnXrOWHaGrpCBA6w68GEfJjlH99pWMM7qOFXyZ65EDwDESPj5tf5mSy8WeyYew0QwB9g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbee39b-b44e-4377-815c-08d84db09955
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 13:20:15.4096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 320NcQi07gU/JvjQO1Q5X3sDCcrSuOl4t+SuR8cadDRjH6AqH8MKRdLDeEfDqIZi3uqnjX9G49Yq3Ifg+HQ3sMEOQIrhM8hKpWJg0sQYoEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5117
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
