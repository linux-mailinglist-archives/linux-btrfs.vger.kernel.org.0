Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D06240287
	for <lists+linux-btrfs@lfdr.de>; Mon, 10 Aug 2020 09:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbgHJHbC (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 10 Aug 2020 03:31:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:46759 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgHJHbB (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 10 Aug 2020 03:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597044660; x=1628580660;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3EytRWZJEys2JrmcMDs7LvqnggaA7Eci2T7GYu7l0Ho=;
  b=d1v5tTmAyiKoTy95WS0+ayJjhtD2SAA5jj016t+ndHSk578g+p/sIVYy
   PF7jeA3/iTr7sPBPQXMk3JZ2igz2amGZ832MuGTBx1bnLd0nlEm9JdDwc
   7M5XsxP3AafgBBupXIQWKuVj7qyxizE7Zstlxne1SPrdqvRo6p/US21kr
   i88WAV2a+co6O7wQVYZCu74m5iNYpVP7xmZHHYSnV2kh6u4/X0b8z/e6G
   zli970Xd1Aq3loxuxlQsYEDgxHmR0uIzQC7kho3Q9wJeOt+RoPiUHe5Q6
   DktqobXo6fvsRYOT0ceEJORyMjEMUcVdUBnkYW99t3Llnu55m47+nOAXP
   A==;
IronPort-SDR: TPOVf8w6T3s6LmQUiq4NdpeOrVOmRRaxd0uTJaF4yeQG/m4p7raY9UeRRpQp2mPvD0AMRKOMTG
 5vJIUgoSf9pWuA0kj4aIflKzSq/miSmmSmz11ALv0qLVu07m3NmDeXjV6S1JnyHgTkcxcoiMNe
 8Zw48qUlb06nYvpt+x0hxUPZhuuIo6drcYleqjPujOZScwpWXA7fi1hpGQ8RnTOHZVNGIAcZin
 vU/xoW6yZUyypDxNvCE+JeHi3T+1Ognx5Y0OEwV+cYzcdAsilx5AhbYA1YVIwU5yjajVvFjSVa
 R7c=
X-IronPort-AV: E=Sophos;i="5.75,456,1589212800"; 
   d="scan'208";a="145778537"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 10 Aug 2020 15:31:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aGr9CCm9FeabFVmbQblS7GAz6q8aW75BHx/aZXB/3iNHMqtI/wR9ENxCQ/E+dGDveVkQtNrfPDSmliv/srwu6c19CO63FtgEPujiTp661z0KsTvX3s/dABlM1rPQ8r1JScrKBH5uzTWMWjfuGh7HhCqsVTHLEBFiATDKQBYQzomHQeXsR9wfcl4ITAURPw2HrXR9XYVs8UKWheS9vJXS0wViezWXC1KJO8FHQL3dYY1L7OHc2u3MrT1jxmGti3AaPtJiZ8WmTiN8xbKCG0PAzVvkfs3wCRVqHJyadeurLXmWsDA8AwM60Y8dMD/x1t7LV8QDRLoWeWMzqg2UhNKuGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4kMWiNnyyT/Xq26bgSQmNJRalI873YfAk+YuSTByDw=;
 b=PLHnycGBCfh9pgfOLpxtWZbEt3VDk1kErdnreYWAmWfg0DdTWpce9oRZvVP4ikjaKj8cID0eIKvVsQadYJyyP619jvIUKn4GQhoNuetnhkY+MQaZjNOIj293w4QTW1avcC6kT3HtwTmhwYwuhKQhE75CbhKs5dF2pRKBBEPOmHusybcjzfd1Q2iuPRkGn6CWtO5wwG0CoEkNG2hase/06CzR5qSqIcUUnC05mRp4hyp+eYa5tzOI8EvZC8YItyeCA9Of/83PcuhPpAICqqXSKZJ9sjjakAtlKE6prRC6RdcT+gAk9WPlL83p7HoaoaCUYLGhn//hgxQ5ocZvnH23uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p4kMWiNnyyT/Xq26bgSQmNJRalI873YfAk+YuSTByDw=;
 b=ieFZZ5o93ftRctdpT1FHm+85x7lgH9+ryQp4ExZtS/J3Gc+z/wEP7pJFwUBAd7Qx+7vmKKdGVem4sRKFbX0rXH9Cemky5vZr5XmDQZdfEj+322cLOd/wXgPDQC9uVXLUmsyIuL3wJdQDIr8kq+661/dNrnWbin1oF34eYnv6Sso=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4687.namprd04.prod.outlook.com
 (2603:10b6:805:aa::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Mon, 10 Aug
 2020 07:30:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3261.022; Mon, 10 Aug 2020
 07:30:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs-progs: check/lowmem: add the ability to repair
 extent item generation
Thread-Topic: [PATCH 1/4] btrfs-progs: check/lowmem: add the ability to repair
 extent item generation
Thread-Index: AQHWbufFee4YDG0juUy6H1cUJX2bdw==
Date:   Mon, 10 Aug 2020 07:30:58 +0000
Message-ID: <SN4PR0401MB35989D15F1724F55E26DD13E9B440@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200810072747.64439-1-wqu@suse.com>
 <20200810072747.64439-2-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba8db449-5ebc-4e69-f50b-08d83cff5376
x-ms-traffictypediagnostic: SN6PR04MB4687:
x-microsoft-antispam-prvs: <SN6PR04MB4687765D302AED2BC576F5C79B440@SN6PR04MB4687.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e9eEUsdEqNAztz7/7n2FJ6LJk57/KEIdEwjtUulGSeahXiBAP106cFMK3f35ckENPZuW7f7mKgshTbvlMdFmk7GQG2DrS2Qh9ILZvaOgl2uT2P+92fyUScGp5o0pZbXwMlZgYyrKh7VfemDsq71YdOPG0f6rRHszMqMW78ecrhSChHT+mwA4HB/5M29nTZxxg4ENItu9BT9kl9sqffsrgX57J4RDzVbTCkM7bQJvi7BdZFmB0DsZZNAZsVNBa4YvKqNHsuCQnZEKVDoKZQje76RnlYgqHukTXOcIbZHfwbpUfbZYyrWvdAQ/PcRN8irDzR4KtoAwfhCp0ue2rQ67cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(8936002)(558084003)(7696005)(110136005)(478600001)(9686003)(66446008)(86362001)(64756008)(66556008)(66476007)(5660300002)(66946007)(76116006)(91956017)(55016002)(52536014)(8676002)(53546011)(71200400001)(26005)(6506007)(33656002)(186003)(2906002)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zkKMFkRjl+u9csfNCQAyEkl4uluh72Q44/9xe5++xhDcJYAxeGklH7UR9ogKWhyYrRmOyynGV9DF9v2cw5bTXwFVuhYu523gxGjeml/NjGpjoCzPzls3R+r+0qzCMj2Mr60Tl4bQIO0OnD0toyL2Dk47coZvmLfD1e8Ya5vsFhGJoL3pmfl0WRd7efEj4d0DUC4Q24NRnlbLO9xnop9qKzTK3DciKQfdCEVK6iE4n3xbKHkZjGmMtrwRqVYY+3L1Fl2PX5rfmxj3qcH9u4SB5nEVDgd2oGWFl6sPi9OLVIyWZQkI/n7J5johi33YTqO86JNMRKQbNNH5GLBLw9mJfQQwd07otRzF1DbaQkJaIUEsY3ruPj6JgNcbwRRjRzJy3ehX5mcQKHVbVe++Y8qH79iiFcmjkM+1UJ6m4ke9vQSvvWie39DC/jaTbQenPLeRyBcAlgg0pt70bX8ebTkaAwpILWSC7VgcpnjMUh/FGmntPbziFlOsqv+aGUoStWQLS7czv5YvHs3BYR05U27AysubAWZspJByY8fBnmotO3QfvYEDSER0BIeotottQZSCqNdc2pIgl/FzgZCJ+1hDI39S+CUPijyEEOiIirazevfdhyFCrIoW/HJfjvmaffb67S3vBECBzG9gTHKGEGgrPg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8db449-5ebc-4e69-f50b-08d83cff5376
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 07:30:58.6437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mnobyyRpkmmOk4OAmFoi0edsN9P5Q0yEczhwZd8U+eqj+wf6Xtly8wcOaxGeF36GA8L3m1u5OqJZpqjS9nHjCrCDS3wIxou+JS2MC2lWjQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4687
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/08/2020 09:27, Qu Wenruo wrote:=0A=
> +	if ((tmp_err & (INVALID_GENERATION) && repair)){=0A=
=0A=
Shouldn't this be 'if  ((tmp_err & INVALID_GENERATION) && repair) {'=0A=
