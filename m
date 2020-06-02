Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3CF1EB7B2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbgFBIyK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 04:54:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19112 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgFBIyK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 04:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591088049; x=1622624049;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Ei5BTKW31mURaWJOQQ6gLtBTuE0YmUqM9fbi47IuUb4SntNgyUk9kqwq
   5My1KsXCiI74LvOjC7NO/i/IKm6ESYIDizKNZ5u3OgyU0XtBUsEa5CAQS
   kyKUV74B0jadmTJZ15cFivA/kGJiYb86Drv3Cb1ZvBZcKhPMUNmi0Z08/
   efpezS5K8IIdbn1UsqCbZ6T3KEfnJOLoB24edTY1gg8gGraxNV9J7HOH5
   g8xva0oxbpysxCW54xD8n+fcPxXMDYZmAWuEDiY9Ky2Nm+3aEJ3E0uHsy
   aMBMrqHCCgtOlCfZnKVLG1uKeArehrUEmLI7cIZNX+PiuiTwYbmqkjBqI
   g==;
IronPort-SDR: eXVLgd63ZZ9PtZOWwGTLmrqwiD4CDujePMlXr7pvcNUIhRR6EOtT9STmW1hrBojFDiVZiH7YY7
 HKOw2OOcgLFTLAHHOBgZ2lFBIZbo59+JOLAmo5XqK6OLD6ich8+1q/XbIHJTX5U8/NjDWGWNuU
 iv7bulo2MGxTvw0ZqZa32dZs0j7c/zwR2XdRQNeFQ1SQn9mG4RAj0aIQiBz76EXSf+Mu7RrBAp
 FIOCHzKi9hLK58Xk5JB3GntY5mAvQpqi8OkpKoruNFdgQiQONZgpt0vTScu5W0w7LM/txcFzr+
 FYA=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="140435756"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 16:54:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJtSy9/hy6559g8uU9ApxbxqGn1agdBuFFu5sNy9GHjjpFIhTuc6AlBpa6aeY2Sjhxo5E7dDiu0hJp9QfQZceRkI3I1iaHCdfeEc9y39rjMfUfa03/WKxxiDzia2Pc3DZNdw1rbeaco5bAmlcbG7/LGjAzl9k6/F1eZ6aFY5fX1TJyXvNP+tvaTRUzQAaqHWM5LVMVAtha9nJtDs9IcYseJF3tzX+hXkLgh28iTy8hptUG90eYJVai5KG34wnq7qPiSe0ezkZTa49wzpzAgF7DTxuM8147gBYB83UMbCbE7IEk8+Ax0MpkEnKLyDnhLBFgt09CfPQM160ApN3A8MAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=OomPdMVUSlpmu/dwNx0TCkAx4rfxbRgaudm0qU2tVdVtoDFV7mA4FchFnFQR8pZGyO7jH+qo2qr1Krp8INqo8rjSwAZ2CQQQvSWrAkm5dRTEHLKQc5OAll1j8z5jz++qyEsELq+r0D/8c+UrQHbdXYeqfnOF9/drzXhVUOpgKerNm8Wvki0Osc0wrNVUxGBP0bhGe7IYofolh7jEquYdHGhIGtLLrj8DNKdLldldcIKd0bG1urs/rb5k54Eeowup4VlyWo8tpiNM/GvQ1MqlvjPjKE48AyqVu4w2j77r3d9mPhts43Gz8CcQMY4cXXc/peLdNn8uYi6mG5EBXNPgOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=jCEPBE5005oVFQy/GZxrGTQvVUO0Ke6ergi6CiV9j4MwMorlH9aYYzVniUp1Q11t4u5kWHTGEViQoq09Fgxhipe34Bw+BJbhet4ZGy+uLs7i6Gt/JXWJuKhX/PiRS+bfpAwq1HlGBQKYQ9vbO4TTSyZrBGCN/Q9q5TLnaSBkEKI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3614.namprd04.prod.outlook.com
 (2603:10b6:803:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 08:54:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 08:54:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/46] btrfs: Make get_extent_allocation_hint take
 btrfs_inode
Thread-Topic: [PATCH 02/46] btrfs: Make get_extent_allocation_hint take
 btrfs_inode
Thread-Index: AQHWOCqdmp+RMBD5IUGXQNqTreLoxQ==
Date:   Tue, 2 Jun 2020 08:54:07 +0000
Message-ID: <SN4PR0401MB3598CC2A57527B918A83F2A69B8B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200601153744.31891-1-nborisov@suse.com>
 <20200601153744.31891-3-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ed7ecf20-f12e-4f3e-c13d-08d806d282cc
x-ms-traffictypediagnostic: SN4PR0401MB3614:
x-microsoft-antispam-prvs: <SN4PR0401MB3614C7491D2CC8A0C04FCD5C9B8B0@SN4PR0401MB3614.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wI3Fdve9xECrXAE8fEsWXJszRQ55/wccKtenIfUm6xFYQzgN2PuT80NWXfry/jdGv5WpebkO4R3pHUHSqoverIM7kXxJ/6dOYWVVZIc9RwA1yDv23FyHg+DRjzKfcVIN6Tzbcr4WThYHgNbkiQb471s+2VeDTtsmC4bOk4hvoS0E9yq2okNfyXMypB3cTDtpokYJpx+32gbBEBJpl1aUco5d8c+mGCcOcCACxvKpfG9v4vAswlVrJfeGPgjI3noeyEHz3fbaDvJiIUwVYMZEjd0yEcAi2OfFuWE5RVTwuA+a+MrZ9/NjkBmVfYj6nunZ4yLdQEGIXp11kOc6Zn+m9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(76116006)(91956017)(66946007)(4270600006)(6506007)(7696005)(478600001)(186003)(558084003)(33656002)(8676002)(19618925003)(8936002)(52536014)(71200400001)(316002)(86362001)(2906002)(5660300002)(66446008)(64756008)(26005)(66476007)(66556008)(55016002)(110136005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: EsJQwbdPdD2WM2MmS4jp+fAwFtnYlsPnZz71Yut/BRbUxX0KD5VV/UAWkAYOlDvn0w7Avylds+wudSN+54cQbGvYP/7PV8B8UAtmq0LQrKYV7rYDE3kZkeqv6ho9dlEQRIjraTHrU/MV0A0qcl1PqxU5Dd24OzNr9h5bUHrkch9TPOD7cFUH+nthJ6w6ac3BnBz6E+NJb775hKImnSXrgBaRiafMJpmeM9SJwN6XpESHg4ALFYqdVu2NR8kVzP9+IvyYQYiHp3xlGJZDVqm3ktWOjm7jDNJCwOau4c0c27QFMkhwRaJNXWy8SAl6OQ/Pc4UwNh+/TBoBuXkeZ+pCTX1FOFBrz2edIkzXwysPc/kbVj6xI6920SiK0kzlTRkjCrBmc+Jl4y89UbmPfeahSnt9GROCco8pja9WVv4GjPQDtHsdVr5tMv9g83py2blsqNpnLD1u6D54IZhDEzWD8buImHz63pje+HKl4SS3aCewvOtAK3BMKUUkhdsGP9lp
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7ecf20-f12e-4f3e-c13d-08d806d282cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 08:54:07.9501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sLqJw+bMLDXNMBZbGULNV80Ou7gJZTPSU+3Q9qE0g0tIRRsdeRrDIJxtHC6l1o3G/ou+QBmb0s1NHrY7a5VYH9OQp5RgedY5LttRYygA0xw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3614
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
