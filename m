Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441B52305B3
	for <lists+linux-btrfs@lfdr.de>; Tue, 28 Jul 2020 10:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgG1Ip5 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 28 Jul 2020 04:45:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:10345 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbgG1Ip5 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 28 Jul 2020 04:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595925956; x=1627461956;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pL4AFT14JDhl+3Giuiquieo+VPUE/dglCemwn8qoiAQ=;
  b=ivCEYbiGPPpJkbtfo00KW2D3LJiRqTIumZjVLbI/TiRXrfNWq+zCJ4PG
   1xc+HoyuOdU3OYG5G1242HhcjFquQEfCiAP+2OW1kg15Ajm83Vt+gO/wi
   3XeJOUSQeP7Sstq4yrWcLN6wbJ/qbgGkS9+M1LRqbmXpwAOp12i1Ah3CG
   DwprcovI/uGeMYiR91t9p48WndxNnUBnn+yCcb/PiwRmsRE/ojCtW405v
   TjfoaYsiXzTcqM5ZyZWN8w4wX1JK3LGLBpVmTyz7KNhM8TQCNZnJRhUZm
   OfYNP2zAOG7m6pDsNtkcBPxOg2I3rhxmpND2u6J1KjGliBoVe4M7rdz+h
   w==;
IronPort-SDR: YxjLsssHZDskFrZCp3T9Le+DJRvOKRVTrIjZBYYjXOXeG9Rb69jzs0eutgKA86zaWpXCV9S8Sx
 DihmssxPQRasz7nODKB3iK4aOSI6Zgnk2ojVwr5lR/Ds6/uwBJdqrPF4NhDj6SeQWbA5tUKi+O
 eQ46xfonZHJTsc1st73+PJtfeaSCJz5XPX62wnkfiHXa62CeasIofm2eol0U7rG8PCnNos79SD
 SO+gLuJEns7eHnbLk6UwNF27uShSQAO7+WcYGr3t4s2iAQx1zkiAFzVUr5wj8VuXswnPpf686B
 WDI=
X-IronPort-AV: E=Sophos;i="5.75,405,1589212800"; 
   d="scan'208";a="143637948"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 16:45:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah8qIuVwehNgEOWURVYDcwOCWYI6ZQswlrCsoEKTRomo5C5mZylphmnkfWtNmZWG8rQtffDM9iLSl9Jnfoq7sSZS7jcBvOgkMNadt+JEZ3OukJ45oHcIaSHgEKnVOVAw+6bXW6E9+jODPBEAWbRHn3jHTbNJzat38rQon/ycQraerzFmP2k/ormT9ToHhMEjm7UvdrrWAH+sK2NPKJlAlj7ELzh+aS7/NAs5rPJjTZQUktun1EGq6Twu7eU8uG2Rk2aXUOJlJSI0PFGgSAJ9XSsxhsTjz3OZRD67xRe8UhB3O9gFv/naTECSsTYYD08Gy53/4iqDU7/dJdKGc5Qegw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgtNLTWmbSxIqrGUrgPNBVFsZ8Srs6UYyfh63kc1CHA=;
 b=E9kiOkUctkRulbn3fpGw11XaO/YW5Qwc1Ges5nSW06YGkbKfNh7/Lm2peJLngFaTtli9xUKF/OPp+gv4XIfcKf1Rbj+22AqWp8KxB1O7p3nUOHiKEro7851Fz370CjW4Pr4DmsZdYMBqcK2M5Gxjv3uk50HTob338MXI08ZWq5IkLElepKLmmWsl/ogLeOwbf1WwefkwqC/ig8ZcEzGn06Nh+oHgEMNFtKnvIV635chpdfT1fVCgEnxO5IQNS+6rNbwrGq4u/y+7eBojexXDaVKgsrU0B+m1OU3+tk9sCpl3mCsmG3x8Dz+4BXATlMURSP7WwfpvpPWg95FB9DH2XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgtNLTWmbSxIqrGUrgPNBVFsZ8Srs6UYyfh63kc1CHA=;
 b=g9xKVVvZu5z/KxqcbuvB9ruej02wYrB62j2keFwLQnzG+gt2KV9vAeIqcP428ukX1phl6puzGJFntn2Pyg2rjooYdCDdHcYH3Y+69e37iU7oXouI/nAodWFIkU+VRlCss9R7hQu2mC2ye399tUj+W9OkiaI7KVX17HyWFiZCMXE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4320.namprd04.prod.outlook.com
 (2603:10b6:805:3c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 08:45:54 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 08:45:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/3] btrfs: enumerate the type of exclusive operation in
 progress
Thread-Topic: [PATCH 1/3] btrfs: enumerate the type of exclusive operation in
 progress
Thread-Index: AQHWZGH8UBJhr8Owb0eKbWTddG7Ofg==
Date:   Tue, 28 Jul 2020 08:45:54 +0000
Message-ID: <SN4PR0401MB3598CB5B1624A144F626E4619B730@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200727220451.30680-1-rgoldwyn@suse.de>
 <20200727220451.30680-2-rgoldwyn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 309d1b9b-2e7c-456b-fee5-08d832d2a3f3
x-ms-traffictypediagnostic: SN6PR04MB4320:
x-microsoft-antispam-prvs: <SN6PR04MB4320192EB1C273E4DD0539859B730@SN6PR04MB4320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RdLNEp/vgmTBnqRePK+M6njr/8o+YPTK0unarctxgc4Gjg4E4c7s/BDy/3vdeFmE0xLzzn6DfHDTDA5d86nLKIbDVBGqhVtY1C2AXVjOhwGnGBkYL6lCylu9DLk0a85QGbsprw0bN7tnwFyFc1wYgfBeteesPo7qH3hsvrcPjHwqNsocb1NYSfBJqKbkod22eZ9KfiIf7l+7FWKoXk200avcyi9BERYOOcyKNlZok0USDBT5QirfexRH1BQxsBLzb+gKmGGHIga8UM9Nos9TgfvRiSKkdklD0txxAdufBHl/txCQsW5uRsqzJ4CCB3VXdGus9ASEr8j7svHFwVdt4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39860400002)(53546011)(6506007)(478600001)(26005)(7696005)(4326008)(2906002)(66946007)(76116006)(91956017)(66556008)(66476007)(66446008)(64756008)(8936002)(71200400001)(52536014)(83380400001)(4744005)(86362001)(110136005)(9686003)(8676002)(316002)(55016002)(5660300002)(33656002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Mj3XLm0vxbxlpDXBcx0dqmZQViKlAO7NlofccbrmYsoLqatFfUv5mIg9BheVcuDKYckfG08XmHiBN/KreVwbUZoCiJ+L3ZMefcgmy9MqRR8iO8BFkhjV1pvftCy4j5jnZPRm1xTSErr14TuNm6JfbijOWaDtcXpQEAPfin4wylVMQLkUB+FYg/GHtlHb5IrmM5/oHJYIbAKU2rItYCUI68kBG64yHOBpnV/X9S9EwfsZtcQjw4aQEKC1yZjgeQRXz1tWFmJBlAuUoJTJZNj+0NNzuLKjIwMjdyM4FXucHjyOI3IrcyzSXvi/EcdNrJhwxDPRCb+Q8QlAS1S9JHi00y9y6/gYSTToS8WNYrS/Qq04W5BQucwE3011l8o/9VXl0oY4iZaH+VCfUz9pD2uDpAJ/K4FLt+bHASyPzLKFPEi906lYRa1ZwCUFFvmspexMgnEEdFRBvnkjvupcPPGH4x9UnlhIt094VGDSRHpjFoq4vw8sS2F2dML3KQ/+itNR
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309d1b9b-2e7c-456b-fee5-08d832d2a3f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 08:45:54.6823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iGaPMqWtH9TH/GKdgWOJdQCTBix4F1UOCLYT592e7JlLeRTKgGTaw5BrYCuPZKCosaybJ+D69uVDdSNjLBaHZC7QrALTtzD99JB88r+9cnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4320
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/07/2020 00:05, Goldwyn Rodrigues wrote:=0A=
> @@ -3668,11 +3679,11 @@ static long btrfs_ioctl_dev_replace(struct btrfs_=
fs_info *fs_info,=0A=
>  			ret =3D -EROFS;=0A=
>  			goto out;=0A=
>  		}=0A=
> -		if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {=0A=
> +		if (btrfs_exclop_start(fs_info, BTRFS_EXCLOP_DEV_REPLACE)) {=0A=
>  			ret =3D BTRFS_ERROR_DEV_EXCL_RUN_IN_PROGRESS;=0A=
>  		} else {=0A=
>  			ret =3D btrfs_dev_replace_by_ioctl(fs_info, p);=0A=
> -			clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);=0A=
> +			btrfs_exclop_finish(fs_info);=0A=
>  		}=0A=
>  		break;=0A=
>  	case BTRFS_IOCTL_DEV_REPLACE_CMD_STATUS:=0A=
> @@ -3883,7 +3894,7 @@ static long btrfs_ioctl_balance(struct file *file, =
void __user *arg)=0A=
>  		return ret;=0A=
>  =0A=
>  again:=0A=
> -	if (!test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {=0A=
> +	if (btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {=0A=
>  		mutex_lock(&fs_info->balance_mutex);=0A=
>  		need_unlock =3D true;=0A=
>  		goto locked;=0A=
=0A=
Just looking at patterns in this patch, but shouldn't these be 'if (!btrfs_=
exclop_start())' =0A=
like elsewhere in this patch?=0A=
