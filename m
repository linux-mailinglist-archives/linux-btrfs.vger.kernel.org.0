Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC30528CAD0
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 11:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403976AbgJMJNy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 05:13:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29458 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403911AbgJMJNx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 05:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602580433; x=1634116433;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Yt0fx6kFGboKifB1fEEfJHxGMZVHATXmURh7rkDr99wM0wDvGiCfeOIN
   J45ftLT2xWZp7Pm4fQB4DUyWOR6jEFssQx45hjXglMOFntHWWrsXmSe6t
   Ca9ks6wM0dmEEH0UtQZWayGAxfb5ooKblXBOvlWskKemDWdIjZqhqb2sZ
   L1rBSKHonp4a7O1gy+OuOgnwY+tIjtE9KL7dWVCJEQuEsduE1a/inGOKT
   B1Vacb5jIrLgXkw63gP5UHqBanmqa/VKnqUDfl3ln/a3AXLS4DCxl4Szc
   ez/CWEilMw0RZkEFLxp1gVPdEx9PQAxPFFbReUX9a9f3c5jaRcsaubx3M
   A==;
IronPort-SDR: bZ2lLgMs0yZWRQYypOvlJo4KJXZ3/IVEMVeOXbAoU+1Y2+VaC/CUMrPzXjRibJINL7swZhzgtJ
 146bMc3HlKa7H1pjowWhlpUyLwRYpyLLKz3URXO8ZT4nZP7OUz7RRXZ6LchGNYUHzmBDS7DHZ4
 9sLyIii2X0+QSaaYIRcnFEIsqnMUJjd9OEKi5tfmgaTsEhw7w6zTQxDFtiQ6kI3ubMN4yBlRh1
 SuVw+zj7+YDp7wY2KqlKHZ+go2PylkehN5msoxEwp4LaP38TKLmQ7ALz9RXQk/dDSp5kLQjFhX
 q0g=
X-IronPort-AV: E=Sophos;i="5.77,369,1596470400"; 
   d="scan'208";a="154130780"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2020 17:13:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEK69era6tJbulIXiak7zdiLC+CxSwawUBnnwAZg/rldeIF8t0Nlr279x1jWvvNUdhaw1FMBBcoZZecR4BUk0ofds23HR2JceZTdmmPE/Kno0U6NNUUMGONRPBQ9WssE+1Qvg4ecri1RNQNEpuhYHvQQAtGiMW0LQV+CUJjf3uMSxXFo0FWym/qtIMRuMjBhifsX8gTTTj1dGI1bNgj4NOS2Mw5Ryuig+0640YjJj1H4LN/x9kvwI8QtTEmMsYVKF7N1QNdy4agKfU2VuR8tx3r3Z2jDSOd6stzlfcbXelY9rp8J7Oi8CqSJ7DvzlVzYRbB117ye2MXSxc05hIzRkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Giub+QoHVpoZeE54/qA0OyAUXbyr77xO6m/fbDjYI6gVgCWhEAu6/JhoOsWlMdKlHd4G+FbWzHSX87Rcz+CwrycENrmHwo28dsLjkgTvl7Te0/1xwb3ZCdhIVPcvORHfNC6IBrnrwdDL0cXQr+qYf/M6OUC4HaIVechKPjZeK6yULxxo6Xs3fpBuZfu7zgsCGPgMy5qlreYhB5friwvQrdnBxoXefmntMOsxucI/nBxxsyyDV5BeYCQMEnxfOP00m+7n+nVFkSeyg4H/LuqyBerUwPJo4PJh9ldsaYFbsMIqkEUJGLVR19gJRl6UseDuAfZ6nsaIJUpAlij/CTzx3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=DxciipBVUoilWDC3o0Kkg+7+x1O0Xl23LcurLyiot9NwPwLTb24u+lVfRl8EQJw7IERHfcHLcnRBZ4nxakp7JHsNerbNQ6mibhQQm8lz+5/LSnyefN+O+BNQh0g/wPLvl/i2i32Zo9xsZrNlbNABc2TKmZ5R7aTq/EMiDUaV2z4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4048.namprd04.prod.outlook.com
 (2603:10b6:805:40::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23; Tue, 13 Oct
 2020 09:13:50 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 09:13:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: do not start readahead for csum tree when
 scrubbing non-data block groups
Thread-Topic: [PATCH 4/4] btrfs: do not start readahead for csum tree when
 scrubbing non-data block groups
Thread-Index: AQHWoIZBnGhdkeMEQ0OqlUc7EB1exg==
Date:   Tue, 13 Oct 2020 09:13:50 +0000
Message-ID: <SN4PR0401MB35985BB280BFC647DDAECE149B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602499587.git.fdmanana@suse.com>
 <fdde80f42dc3e822ab990d28d584175eb0ca222f.1602499588.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f3724a7f-7452-465c-916f-08d86f584c5e
x-ms-traffictypediagnostic: SN6PR04MB4048:
x-microsoft-antispam-prvs: <SN6PR04MB404813C9CB7A7816FB9075E59B040@SN6PR04MB4048.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zNGY1MJBWXFsLk6LNPQ9zABhRsDp2dp7n0GrXNdVzSIVRNAvSr9lVabKN2DdEWlKji1GJUkxIMNSP5pflu4Lf2X4Z3/DHpoiaR2tW0lb1aejvoCXkYd+0AQw2k/PyhQRjedkj1zJhVY73ay0RuPmjfEz1/WuzK/2MVlKYQIJhTt9UamVN92tfHand41Xfl+pF1TOkEesDALb2eAzlhnDnCeMqj27nkdLYwy3uHmBRIxEbM8QMWhJo2nqF/ex1pefCKVtj0Bjy/gaQz9QaaBlJ7+kupSD31IJlgOdh6mlzXvXrLfkKOxkOykVi3VAmpMxBwwLhCTVac5WjsbanQBB4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(26005)(110136005)(186003)(86362001)(558084003)(64756008)(71200400001)(66446008)(478600001)(316002)(66476007)(5660300002)(9686003)(2906002)(66946007)(33656002)(66556008)(76116006)(52536014)(91956017)(8676002)(19618925003)(4270600006)(7696005)(6506007)(8936002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ldm13OT2Wx+HwNXhb1ZCkT1+HHnC7WBQ3D62krbZgeqOlOSHd8V+y0v7Hqqf18MQnOqgAj/Ro1JkQzVv2nA85cZLu9ZnKTRMsRYDUo7oLa5np3yK/ETwR+TiiKPauAt6XEscNJZdkCgyHEhOM45Enf/rUTaxObOH+nlBlXLcekoolJAT5wT6RuLP5n3AK3cBjLi+ehCcE8DPadsjTzJsc2XgsQnVS5ZYxXa45h3vEuaOj/n7LUv8X2hoWhg3kxOG7M9tVOYTJI8j7koJFzEZTxHFsZzgG5FaNfIQng4t4PDOkD4TeiHVTCBR7+5ZI9Fpj97+idc8wmcI0D2oF6mYfIVisBFcWeHPIklFAhGZnYzr7DHZTGtQxg2pPNKMWwYWI5HFLFDc+VRQBC6LrLMxDf+kYEbVmtSV7EQw67CfJ41FwLv/iI6ffjp3NeNCYFRwpVnDe70Nv78CZQhWf5ZUsN4RPWjWpnBcWwyhUlRDjUIcHgM592EzdJypQY4A4Pge61uoCwDJvNmTPNo1TLYehdlojNUhn3Lb+HNcX2bfGfg3AcPkSpOCM/b33bclpR4/fayhN51A9NFwwZ36xOqq3oOd4jKpuvK8Gpa7pn/LVLAObqiOEcGzROvvaPvtq77N5paMOMIyaBPklXBnebBCIw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3724a7f-7452-465c-916f-08d86f584c5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 09:13:50.0577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Mm9LN+aN5Aa95sOPj3S7gbgZ3zxyw9ChMGMan6yZFdgpuajuuyPQzxSvkOKHdtx7u+MA8VzaOpwDtibARAPthEBd/8x9IJNPxDJPprr91k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4048
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
