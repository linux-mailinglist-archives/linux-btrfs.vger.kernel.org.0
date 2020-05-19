Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EEB1D940F
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 12:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgESKHm (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 06:07:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:27871 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgESKHm (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 06:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589882861; x=1621418861;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5SsLcmwU/rdYb0WjeV2ejTxlFzV8du0V5okl1c9oMVo=;
  b=cLwjE4YJeRenVd32x1JwBBIF/N2M9fJE/ZaW82bu7+N5x2OLC8ytcUbP
   Fr07Ptl0wDsGcnzOMm4walVpkSjP2SWIdaKzCXqSyNAVNb1Ep8UODijLv
   DFUaPB6SjEso84WHBeP3YuB2TiFCUsEBNd5BYe6LGdp92Ng8nopAfaF3v
   5JCaLqzmt+Y0oKQdOWXA/mRvjyjYbhiw+jBpSRi4lb3dvGdYqbqIvo9Sj
   UTjNcF8ze+GOnmAG8F1bsoicpAqMHtCrx1rtblMsO9rYVeECiA35sJfvf
   kqjeEG3O5YXI9qrn7p3g1JbcLzsMJed0S32m2E1tqg9wY4F5SHCyARJIR
   g==;
IronPort-SDR: R/LrxqvY+bg5HAY7NgPVeyLMgSNiBXX60Q7y1TqDJ3jO6lP5JLi2jmMF4h9sVpgXP4Re7lOPqO
 aSfWMcUDTHQyzrQEwpzY+C/8+0uBML6dvyWdrGG4BtpKiUSdFyNlvNx2Rl+2w28sqtlDWDnJos
 MQPLcycK/kju0qJQTcwiJQfSAo+L+g2tBNbubDfug2ysSfUmz5S6QJ8GCL/5zgtPO4ZRmgxN0U
 QEh3A+T/gm5eVG2o6mcIzkHQOxlq0IbCuYfUmjh177HVEWdcarUdLsfrzzo60+VYyEYEPlLuOS
 ARg=
X-IronPort-AV: E=Sophos;i="5.73,409,1583164800"; 
   d="scan'208";a="247016068"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 18:07:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcS5k8DwOaeQtmNkrVxuJxBlb6TKNZZHk/fJVqTx9MHcTaDsRU5dfnCEznQ2h7hz+q5hKB6N/3KpkGh4jV8o3ztMPb7VTtJnO5Logi/9uNZTHTbzdK5VDnVMv8mP79+UQt7gB/K0lXWlRSrkP2MQOxJT1VpAAkGwa/sDoHFLMfTD/7xab50TmHUdZci7dVAVz7HSXmdBnB4Cl9UXfA7QgNSv/B7NGNsy7xBu18qsObN7ic1HZ5ZyVBeyFfycLWIi5KhcTpgUSAy1zYwwa0D7l6eHBYzSrkKRXSgUf3pTjDb7brDvSghDKrMD6e8wzkUrQR9yFfVa4IBAd7B9yXAwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItCmSmSA2gTHqi5mi94ja1LheTFKEEWbvCyZYv5FA9M=;
 b=JM8B6GtMhTe2ZmE0/7gx1j40Jt5DTLe6lk1ww17IG7uSzWDU9GnnGKDOvQ9nTRlxbo9N2cvyWVDCK11zbxYOmUmBpTJNulA6SEGh7oHPiPDAOCUnLSRgSYTxNZPiSTC7p0oQXLDXS9l9+xdGgYWc+SlZZz2zsVsuZOT8+MECRz39Q1RoaFxPejAf5Bzn71OkNRtKrwpqt98/mF06VZVVDyKkJbCRYrHfe3Go1drH51iVSpBfq5wVP7TUXj4PoySU3kPij0AzduaXaAkj7VXJlH21wvHuqFnZvEIvsR2yonqDDp8Eo/5kQ8F3w8K0xJOISKcqDEKP5PNeEeou5nDC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItCmSmSA2gTHqi5mi94ja1LheTFKEEWbvCyZYv5FA9M=;
 b=knHRdSlSAiFQs//Cy5kcZtTH2xYFxjzXUDFWBaVJgyC0cGpyjsOPOQSQKw4Sp6Jdtln0Y0u5uUolgxRe45MsUwHkhKSeLgn+0EX5Dezw/hTtN/trGqInXCtifn/3LJViu2Q5YDjrs/us2sjARB+y6Wv86CcdnLMEfZxQdrVI5bw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3695.namprd04.prod.outlook.com
 (2603:10b6:803:4b::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Tue, 19 May
 2020 10:07:39 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 10:07:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] btrfs: create read policy sysfs attribute, pid
Thread-Topic: [PATCH v7 3/5] btrfs: create read policy sysfs attribute, pid
Thread-Index: AQHWDAm9RRt60gKr002jl39/MkmF7g==
Date:   Tue, 19 May 2020 10:07:39 +0000
Message-ID: <SN4PR0401MB3598EF0DF22C63F087969E8D9BB90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <1586173871-5559-1-git-send-email-anand.jain@oracle.com>
 <1586173871-5559-4-git-send-email-anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 069c7c91-97b2-4277-f256-08d7fbdc763f
x-ms-traffictypediagnostic: SN4PR0401MB3695:
x-microsoft-antispam-prvs: <SN4PR0401MB36959867E1204F2D16D071869BB90@SN4PR0401MB3695.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ImoWqUKAIasbHr1xjQTpx+Wk58+tEU0pK65B0pR9V4HujKMj6ngdvO+GlRKwJfsjTarlfRmnQ6GGi36pzNv3RmhOQuDmppHB3RK1u+0ONfBnb1/Ns/fukCjlxMLYgqj9dMHQwTCjGK7plnkGG+bY/sQJzhMEDMSFSUCwAsSKD57oIwCUp1s+Tbj7GnigljxQcjxpcX4t+2by4aUzf1U6ExPd72kmoPzMFmOrA37UipGUfRU5OIUxHYMNdLBbutdoEJR9c3KfHICA+MTAMhM3LlgcV1zQJpQD1B5qx95IzNvI1kCLOdKmagamLM5/fAc32CCifFj1RpVHXlwHNl0OvDbsd1/D0Q5DIlGOzklrIKufmK5wUQxU+fKnvE4af8B4S6WIjETae3G9BqvFmKME/V2O2DXDLE/ZlLyA1pkn/acAjISl+htYA98EPiCBjixF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(8936002)(186003)(8676002)(5660300002)(52536014)(2906002)(86362001)(91956017)(76116006)(66946007)(9686003)(66446008)(55016002)(66476007)(66556008)(64756008)(6506007)(53546011)(110136005)(316002)(478600001)(4744005)(71200400001)(7696005)(33656002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AMrkk7voS59omVlL4r2SW8jex/1dPGYsf8DKCAng+Y0llQWPWs5pkl1iwqTNIE9d2qTVMxojj5+Y4bR5Gbpmzswv2fJHwScf+GcPqmCpu0R/OSDeBBD+qvythNe5d9L9YyVi3nw7NSy44an2SXvIO3TZbzLgiHzmMcpR3r7ZbaWuS+rlf7Kq7XjhC6MB1r+L74G/7zzvYgQVP4KskSKZ9cLJbL4y0QZhEdYnmFy08qMdJPBGSXY8Ux1ZZVEV8zhnhQ1M4/GqU6kuZHkDbPRXy+A4t2CxEXfHFYAhk2UPVJuAqNfR4hGlbwg7KjV7IYnA771HUejp/SwjlhpQ08ZSq2pmNsA8CtUzkxmPR1PbCiy35WdLv2M1/TtMh9hjakeoTozLtiP3PgXt5PSS23+VBng6793v6/AZLWCTC2/W2e1ZEFv3pblQQViuub/0oKBAIta+h7nhxyMYeoDoaedgmOarps3Z2k3HBpV12j2pGEqfHoAk6bjZsQEPRAqDhrbj
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 069c7c91-97b2-4277-f256-08d7fbdc763f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 10:07:39.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cHekhd+zgrCLxkwtSBn7/ixelYPzt3+1AMJ24HpZLnTPZO0erbYw9ZfKFTIQ8xvBow7XH3Hzzqi0hA+/iRPyF1jnGRsawCwv1Hb9vHdrZjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3695
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 06/04/2020 13:51, Anand Jain wrote:=0A=
> +static ssize_t btrfs_read_policy_store(struct kobject *kobj,=0A=
> +				       struct kobj_attribute *a,=0A=
> +				       const char *buf, size_t len)=0A=
> +{=0A=
> +	int i;=0A=
> +	struct btrfs_fs_devices *fs_devices =3D to_fs_devs(kobj);=0A=
> +=0A=
> +	for (i =3D 0; i < BTRFS_NR_READ_POLICY; i++) {=0A=
> +		if (btrfs_strmatch(buf, btrfs_read_policy_name[i]) =3D=3D 0) {=0A=
> +			if (i !=3D fs_devices->read_policy) {=0A=
> +				fs_devices->read_policy =3D i;=0A=
> +				btrfs_info(fs_devices->fs_info,=0A=
> +					   "read policy set to '%s'",=0A=
> +					   btrfs_read_policy_name[i]);=0A=
> +			}=0A=
> +			return len;=0A=
> +		}=0A=
> +	}=0A=
=0A=
Naive question, what's the advantage over sysfs_match_string()?=0A=
