Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8CD1AE434
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 20:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730271AbgDQSCs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 14:02:48 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:28914 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730236AbgDQSCr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 14:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587146567; x=1618682567;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=efYopvws9OdvydDIb/6FF9T7Oi14DpRyiXoG+bTGQvdZ6TCwGj6E2OEQ
   8EF21c0bbcc5yCp0hqlG672Yy1oZJCXf69dh189M52tHVuEmRFslV6c0g
   Ycv0xqc7NUNYvVKfeMAHe7D4qLks18Y3whI112nVjgb95+OEqq1V75xHJ
   EUSJSR9vL2HNBoROlB6QSmtOrztfC6Nle0EZz6rR6RbOJznUhqIPB/gLM
   8fnWtuUCSY4CWqU01mwPFWybODspSXCYR7yPvj1gQV9dmhHMS0yk6mwjI
   mZ9B5Sw4xRvgw+MiBZgLg7eYyjJjW4dA7liquHHejt+isHrgIOod792Cf
   Q==;
IronPort-SDR: jfnUILyO2l1wBa5Qxd8M38PT3ocopMc48ZTAGwImxVBjyT27aTdwD+TOkcgGWV9MUlMmahLnah
 APjlgYSB9uuS5ShikXp51edoRdfq4E/zgGZE5OkIaS2GzAcc5SgLdLse2KAEX5nGouKpYgVftr
 wNifCmc1s5g3MaeINLaxru0XUXrVbGQKACJpo0Fum9hmfmmgDOaR80RuI4Q/EVg2BHEvwxqM/g
 q96Buis+WOk2j84r50l5C0xxugfU7OEinNpWe7SX8Ja6M+cbu43jPMcsXdFZBGywga9TVIezMY
 pYk=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; 
   d="scan'208";a="137008114"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2020 02:02:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy8ycZ0nZQDe6ltyslbUjEy5iVLT3WjDzutpiY6eHJ0s3HvQgrWkCRhXBTmxarjkPCHFDjZD94WTTWp8l3be/ohsS6EelSL5rO8og+h5z0b2UWYMBXffXcEUcHwxcgCYt0CPqB/PIpLGJGa6+iFs2W4xWMxkHs4jpcuT1Zdmq54gFrFNBs4UQWdxpA/6iEesMqehDgpVkXk/HQi13Od8mecLnh8XWvNoLzZ1O/1FrCHYGohNAuppwnILfIVL1llR0AA7FvOhXeQjgTp8fdDrl/gbxZ/inzA39CYwR+IvaJExKClGOhagG2h3ZiryJTe7tX5Coz55TRi9zC70hLpfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gpGfkhkgW/O1HwAAJvaa/ginQU7K8MKG+9H+9gB0Ykl11MLb1VGVR8ibnYzvK6MupYVMEAusUka4hoAdr7LcreHgj84/4gHrCscGDMBNx/Ntx4OrmUV20fPTEiahDyorIIiOpMb33O+sL3+b/blaVOC9fg0NSmcQAZ11/jqI6Jy+OHGh0Pw883DgkBsn+9sQwH/kTyFOjgTtdff4Gr4mAh4IlcKhFCwYPHR+TF2/oORzwUedtvAj9FC0m8yuvt+1oieTVrqA7JAk5/nUwPQcQL8LKDy7o6Km5dUPjz4OGAl2K+W/5NjPwPZzrRHy0NJzW9X0SOlDujUVBA8+alhb7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IYzww1GGwwtZfyFaWv9lqd1b+lhoKLl7B5VMEOCG+9cik92b6xuWQNJzs7vjbDUMW1Lxek4Oftv0kpkviYjAOtxVpqIuL8hHa85oTqXUzJq2IG2dHbhlikWutbK7ozG6X297pqJ/inJQT7Q6bEm3WCzVLXSH59tKKSFrlgPuUVg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3630.namprd04.prod.outlook.com
 (2603:10b6:803:47::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 18:02:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 18:02:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 09/15] btrfs: kill btrfs_dio_private->private
Thread-Topic: [PATCH v2 09/15] btrfs: kill btrfs_dio_private->private
Thread-Index: AQHWFDis0e9eJtwxWE6pHTo/U7xRng==
Date:   Fri, 17 Apr 2020 18:02:45 +0000
Message-ID: <SN4PR0401MB35986DB99191AE7F26D8DBC49BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1587072977.git.osandov@fb.com>
 <2b1b2a0790cad01da9887392c25e4f9b6bbf1b5c.1587072977.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 835833ca-2b9a-4e02-771d-08d7e2f987f1
x-ms-traffictypediagnostic: SN4PR0401MB3630:
x-microsoft-antispam-prvs: <SN4PR0401MB363046979E363BF30F39A3CD9BD90@SN4PR0401MB3630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(4326008)(478600001)(26005)(5660300002)(66556008)(66946007)(64756008)(66476007)(316002)(7696005)(8936002)(8676002)(558084003)(186003)(52536014)(76116006)(4270600006)(33656002)(66446008)(6506007)(91956017)(54906003)(55016002)(2906002)(86362001)(9686003)(110136005)(19618925003)(71200400001)(81156014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zliMONFlQ2p4CCNxCUPJK/ERe1bspfTbBz9uS+nsmdRDpqQCqyLcq4k6FRfGfzlrtAduXN1CUNCfHUoUE6kvJAddC1QG/uVJ7Zbja8eIHnpo5X9C/8honVR00IXOhmO6ll+RoB/s8duNPILnzftwVpd/UaVYw+Pbd7MaUGK0h03CR+V0y+4DMmjCHE/LPSWsYv6uWifhphK/aFBphK0E3Rw6csiC4Wui18ZlEy5iM99Q3Kw6uzYdQ25jXP1fzHrn4u5RKB6/pYF+2HXfLWJa38paIucSdMo+mEVLJeFBGohRWf9fOyqSnKKULXSuYI0ktVSOiFHaITaKXTSFGmoXeVjG0AmCn+unG1ZmFg27s1bXTR/nyY8o9QRw4bqiGoZbNoFm9pV1abBBppKJ/dOBVpLnYPiEOnxGGNfehwLj4S1qj4H9SHbfm+tOsQIj+Fee
x-ms-exchange-antispam-messagedata: 4TUO+Cww1bFV97pTZG6dj2VkH71uWUwI0gUMrEn3eUj9bXE6OqwsA8CAfQfsdELYVirNLUWZgp5tSaouMsmdsGTjlbvdOWU0gGfzp4/k/S2DsPBEihRb5QW5uojXRBxrZXtDimFvDSPuOjWf8ncJHA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 835833ca-2b9a-4e02-771d-08d7e2f987f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 18:02:45.0429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i8FoLLmOZahcuEUKIMXagwrV3SBFd2LJ0Osc8SE98NP2gZ6Gn/fE1L42WTqvM0nOiag2RMpfKjmmjO7TOxc/Z/UQKVtdtJlCS7vezGxe2/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3630
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
