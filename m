Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B1E1CB0A6
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 15:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgEHNmp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 09:42:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:60944 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHNmo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 09:42:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588945365; x=1620481365;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=jEQqRsCUcw9fkgDgAz9heX+bZ5f8gUg0czQ4k6l+TqTonDwUdshKFoV0
   2NkTNzTm9it/4prfMtDeS/8m+onpqJoBFFv/945g9EglgeEM2HEpOJCKK
   hiWfX2syf/uPa0ULCWa+0oltFNLi7uapdG7oUAI6s8bVJNOl8Fh48IyeH
   49SUqAEUdM0WftPRZ9CTCWF0fj+qMVwYNLnj14711P6GGG+D1G0uTPY3X
   kmewDHkNRmZk0+14F7k9VyU0lzOKAsmS2Qj0G+bdC8dyZ3fcPd+GyBG5Z
   ssS1uSeTSqU3FAv8AMGrzM9ETmfQQEjsgq+k7fnS1N7xHjq044ECy8eV8
   w==;
IronPort-SDR: rUG7pAQ4P/LEomhWVXi1gVAXiOhA2m/rSKhCRGI3gP55jGrE5f/ejtBBaBLm4T026e04e8RpfZ
 iamZKop3B3l0k6K6ZBwgr0pjn33x0Nvz6xcwJFc8qEmIv03z0A7XSA0BB7j6LUCVhkidoSqmmJ
 uJgleVSK/TbGX1Qvsbx4FVX8z/h1uTcpuaGD28SFbdSSGKUP5IiPjANLD2Bckrsp2nL7fALUoT
 /ywEvamqhPN2+wUWo7PAwv1VYPWl/eqV0gAdQBjXPvRSeHTOzaf9n9WemQJeaNyxMuk7dNasQd
 AY0=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="141575578"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 21:42:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIYCuGwx782mEPnK/lP9V02ofOD1M6LOE3UdTLp/lRMAgrx8RecBr4gUgT1/ae0PHHzw4t9AN6cGcocy+052AU/eSTn03YVeGUwGc6MbATSgi09sBS1765Jd2XF/3385nfv5ZhmDgmBGVLRCXhR2syvAhBLOmVNxb5CQETcgf/z8QSbfU4GPBQW8SzNgEXGJD9uATtKdV5/IUN1Jmx7/yBVJEm6EfljsYlfx+EpeNrx3BusqkMOVdqvZ4DHBGC7/h6V0jrUGFbrY1PW4/7BW0WxpnOHlRvXoGE/q+zPgg8SMvkyqkMkJEJDXEaicsiJo47DahAs0xaQyCX1wCoOgRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=AUZvvGNtK4TZ4gRHqu7AB2h9tOLdIc+aSGfHuw+2/lSdXc1RUM81omzCvLt68vXsfoAPMb/wUYlHQS2W3QEKnGAhlRmi73Qavtr/24Wjlf52VGshLHcrLkgcAiPtxK8nXBktJaAvisrMOueKNIguoIl4J0rRDQ11l6mPREvZKBaq3N2nh6K61smbwHyyBMjDO83o+soKL58fKWeeSY1RKd7cxv+G+1ZqNwTNwNSlFZNulBvByROvtZHFd1I6GKDHH44IvSlb7ySTRjLrGaEqToDn/EEs+4/dxQb5++eLZJUQrjif0WE0zAGWd5cbKM8q0rHVljA6BwvaYhfxkuz36g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=tkLJeNaX1yDr4QenL4jQmx1m9pX0Pwmay5QD/qvqJIjTFwyWOue9/y5ThDhXH98xSFCEoaOPr4f7ZoQG3CV4N2ZJtZpZCjmfevfuuzZ5ZCriQYj/+ytXfw+1O7Zfvo59fnzTU20F7yNSjrfZCxpqFu82+z/LtL08F+HX+XfI7M8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3663.namprd04.prod.outlook.com
 (2603:10b6:803:46::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Fri, 8 May
 2020 13:42:43 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 13:42:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/19] btrfs: speed up btrfs_get_##bits helpers
Thread-Topic: [PATCH 07/19] btrfs: speed up btrfs_get_##bits helpers
Thread-Index: AQHWJKz6J+uiNROLlU2Uu2o/qMwmFA==
Date:   Fri, 8 May 2020 13:42:43 +0000
Message-ID: <SN4PR0401MB3598C8261E0120D6EAE19A419BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <9834d603877a2e8f42fa3589fbc761e8e85e0234.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef4c4ecf-c9c0-47c5-6928-08d7f355af22
x-ms-traffictypediagnostic: SN4PR0401MB3663:
x-microsoft-antispam-prvs: <SN4PR0401MB3663B726ED5764934FC52B2D9BA20@SN4PR0401MB3663.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fba38Sjo24i+EQzzAZguIid+Yd8Yo4N0y/V4uGV6Sis74JtT4wiHb7EcSsGAnh93Zrs/y9/7aSXMzKuqbg6NRHBZWTZRWwkPGaEcs9iGxSakLYka94VbDTPRrU9LMVgfUk3hfBfSDFCHz9J/ic8eMvRnQTY3QAAsELIy1aVL/HCROjeu4qzLCFmgZ16gxmM/A+a/PRxVKXheX6GYHHK0eWT+VRCPZpukfTTCmgCLzVYicmuff3bv+wbUb4iFFDSP3VggOzqvnzaM/VjfXATd6pbQNaIN8TniBApES6hckLuR3txzwU/eidjCAmjGLvI0jRvUY37fS4jPBHI9NmXYKkyxbLHqUL9ADwBdKSRVVN+SuuPRZVrIrtUcogE01XLzd1AK1OeNGL3ZJ6kgo7M2jSn8HCRe3e4SXIJZr/UFkFE9eM0inUFWQJjV+5pkM1Sd281+/NWt7/hXMjOBjikc7WiIziSMuBc1NCcAnMmOlZN1wzHyJaY43K4btVRUle6ZUUEfRkr1E1ieUg16ZAmYGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(33430700001)(55016002)(19618925003)(33440700001)(110136005)(91956017)(86362001)(83300400001)(186003)(71200400001)(558084003)(9686003)(83290400001)(76116006)(8676002)(66476007)(66946007)(64756008)(66556008)(66446008)(83310400001)(83280400001)(33656002)(316002)(83320400001)(7696005)(6506007)(26005)(4270600006)(478600001)(8936002)(2906002)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +pKj6O7FL4o3pEOpiTaQGloQhz2wfjbNKdku02cYAR+cseaRa2wsgNkDk0km03buGzcAehWcHacGVR0ari9rCJu0r9AfDNInI5zmf3IrRkrWPE1DTtcLqdi+2acoWLPexrH3piQvr0prCWgoEEpv9jtUqx/d2HD6XfcRGFVsk8XSOmTacYKy4dMrbmvwO5j4iRUdWMu+kJrTFi1lz9kX8Kh3Hmwdk2OfeVPSgr6G6YLyhNTp/QeWCvzo9lHwTctV3Zdjv4Ax4mXU+FxGyVKpts+mBK/ekGdTpNBlyQ7Nw/stcNp0bp5JxY+DI7f+dsGooDvfVDfFjilpI0EazX4Xpu5+NFT9sB6EM9DmwVHhKDF/xAO9H45GRht5jmCL8oRoyCLzOT6Hze0k9f7+DltudMI4R4Mt7Zjsixia4y9v5j4AafECQMjBUm1aMu/VKuu5cPeIcDgflA6x1wfW0fs1DE1Qc2MC3Uv5RugsgM2SFf6TQWlBBaHdwGmSPgQwy++O
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4c4ecf-c9c0-47c5-6928-08d7f355af22
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 13:42:43.1122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEtuAck0Eewzjc1S9Pbz7ddcj/bj9PdB1r3LsKRly1vWk6eEpjwF1DCnlyB3KVo6VQM5znIiq3CapV0lXPZEg6H6d8DwkUZA58GpITgXvf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3663
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
