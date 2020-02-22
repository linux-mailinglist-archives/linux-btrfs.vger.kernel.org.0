Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47E66168DA5
	for <lists+linux-btrfs@lfdr.de>; Sat, 22 Feb 2020 09:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBVIkd (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sat, 22 Feb 2020 03:40:33 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:18314 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgBVIkc (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Sat, 22 Feb 2020 03:40:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582360832; x=1613896832;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ofBhn4Qlt42XpsF279C2JSi5FRworX81oOw7z/NkxfzMZN4rbdy7babR
   bLcb78eOaxJTaCDnDENXlKoxoYuyG59mUJdo0rG5NSA296dDx3XDuOoD7
   AI9gcFyNIWyC/nZSWdqbRLsDSyK/ay2sgBgJ464zYVqazxi/uhta7xwS0
   wZ3Oe7C7R++TZ641ekoHsawUrb5rzWm0uCk23EpZX6egOsz6qzW8rovqb
   CjgsZLVk9zkbvleM9yjFG0uwW7I5romhAXSLxph/PA5i/bhLma/5LJvCh
   SAOh/MwiOwvZyyy2F50pGN82uV5iNYE3aAuLR/xo4lslS4VXKnGlqBip2
   g==;
IronPort-SDR: hwBTveBbtAqh8gOlKJNsab/E8HrG15Rl4un8tT9UaiKk+k5d1y3LmBZ7tHWGzjEqXkoSJOFUPa
 NUww04BjzgURLeZ/gm8JDhXEmx3q5GcOxYxd3gZhpllhU5EZ9gQNeYoS2VuEMCMa4IbB1WwJa7
 IOoCJWScY8BLu/dv5WA8tiG+x3DKj/ZTJYyQtqQVi1MCh46GPvsUc2sJWIwJ9RlF/L+avabf2i
 yDavEIu371kQUeAHhxu/gjRk7VPfbI/Idq2lXZ0SwxndxURGx+zGIbfJCGVaS01ND411Aj3nAw
 vvo=
X-IronPort-AV: E=Sophos;i="5.70,471,1574092800"; 
   d="scan'208";a="130968028"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2020 16:40:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+Zrvn7sWTP7cyJONfnM36JQoCNcvhZLjwdPwOiN+CXcvSOfi6LbIifQntKi7+zPfTiFYCEtvow7fz4MmSmDMdf8cszjVlyPQPHhjjNgWk8ptZ6R77LWvrXC226LAWxZBpD+HYohno7O6ski5UjAy69OeCSxz6sUEYInrIwTqpsGVS1ASHFDoLll/teuuaNO88/v9XK5inHzB8F2SqBz9xuH9U9rjLNgHNMxpFynB9JkaaPQtL/ZrtR+x1J8dVGLZFk9qhVAvHgW2FgMFLo3+W2r31FFo3y8of7FxQdlGlpFRxQwC5VaiMRpPox71pOKxYTss6H7KwDL/kvocR0L7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VX3ljVejAQpcTX/cS46cFM0Dwylu3w+fSIM4fKVhLpHLvuNHxDODqrbGN76vfwnWdb9KLoexPhoI2q5Ky27d2edpJCH/bXLZ0IAajQ7rBBwkNdb4QYjZq2UvT6Y49kd1fZsLqd8dSt+bYriOc5S04g6OPfLmF9pEMbf7tEi05N5/INTSF/S3XU1Exr3Paty2GK0lfQ9LPqfELdTpc4u3BBd1jTyv4J+BHrnDhZ12eeTeUZIsyOdQCvvp8UTBVBJSesDr2a+dFRk6AOxe3NMfj0segh/5w9l16uIo69bbXjZkaZEaiFpg8HMBxWPSPcQXZQ8hn/dhuqciBTI/JjpNoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dNqInazjVe3LgVbq7xNsocujTorA5W1gKvlILNRcRaWKcNWBuKh7A8mEfwOcnMlweiCATe/8XrVObPhdmN+3SQ7s75yPBQNRcZAVXnM2xjC3D8pFjqUA/nEr9sSQuPtS6qIzd96MLexuL872WP9ASy4vrXMa5PTz71J7whyKO5Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24; Sat, 22 Feb
 2020 08:40:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2750.021; Sat, 22 Feb 2020
 08:40:28 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/11] btrfs: move mapping of block for discard to its
 caller
Thread-Topic: [PATCH 02/11] btrfs: move mapping of block for discard to its
 caller
Thread-Index: AQHV6NRfzAWadu8NtE+iAW5hFmqbHA==
Date:   Sat, 22 Feb 2020 08:40:28 +0000
Message-ID: <SN4PR0401MB35980B185EE47B4CE1AAB3879BEE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1582302545.git.dsterba@suse.com>
 <32b32a9b68f956a3bfe216b72060001811a71d01.1582302545.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.212.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e62ab4f0-0ae5-4d1e-f9f5-08d7b772de7f
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB3583D19CD725CA01BFE791979BEE0@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 03218BFD9F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(199004)(189003)(52536014)(81156014)(110136005)(7696005)(81166006)(316002)(19618925003)(186003)(4270600006)(26005)(66556008)(66446008)(91956017)(55016002)(558084003)(5660300002)(66476007)(66946007)(8676002)(64756008)(9686003)(6506007)(86362001)(76116006)(8936002)(2906002)(33656002)(478600001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3583;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rroukl3+ZHAPh5+kM921QcJGPfn1JKeCl63MDVH0lUWMLMU633xS/FWS6T7AYgW/JRzHim9YZr2pNhb1p8J6vyXrx+GFITsvj/H7P5X3/hx72njKJZsjdfE5v8O1fb0s7+UQU97M07wFtjt9hKHfVmKcSLfVHD5Honusy3qRX12H7MhRIhtoKLrNtElhryGc2ReZsBT/U1mzbfE8NcktLrVmav4jyXUov7IfYae7YOxcuA+LDjpaiAeg/QTcR80tf3/otCsSVagGKLADnh5nrBVHRS1rOr/L/LJcqfaY33q3zSd6vIhdrJaz08VcbNVoyr2P5ktIDCBkJXwsIaXzRS3/Rfok1CKev3vwrEO4eZGR9FO1y8BP1jCcOAFY7f/J9aZvYm/ZIqfPgTlz+wjYkWZ+Kw1aF89DwKY5cdzN4Dsb56hmVUfIF/md7+qVzLFR
x-ms-exchange-antispam-messagedata: ZqRoRmciMd4cY5BNc6jPgPy1/RQJveRvO5uBbQZfZeYsBPzrQhvHMw/mMGc5I76n0AxTMlXwbcCLhW4K3KlFqmp2pIxien8YzpTkuuM7tiZh+v9kI4Ri5K3L+0EWkVotyNdsxjAiXwi5nKjuldRXdQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e62ab4f0-0ae5-4d1e-f9f5-08d7b772de7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2020 08:40:28.2218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8R5IPvRwcp88G5XUuXE9xxgDwyOZdbwNM+06D1MT50hmcyvH9vd6U/c1Esho8CtTUoAqHb9TysV1SWzK5IZAi8nI1/eZyvjYa3YLP2wE6b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
