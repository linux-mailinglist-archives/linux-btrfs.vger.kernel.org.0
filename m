Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C871C5115
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 10:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgEEIrX (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 04:47:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39663 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgEEIrV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 May 2020 04:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588668452; x=1620204452;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mYyjbMGVvKAkvNpeYzGwdAzPW+mk83Y8ZIeRfo1vCnM=;
  b=CB57/aLXYMtBRKwN9aNNBKc5XHcBMqJ5kr5B98oT7611Y0wsAleyw1Sq
   xquzKKy39o3nAlOIQDDBKh8HYrMl2JHXTY1ZBjHVQ03M7HoRGAe19VRfE
   pI4v+QNQcFUTdAbPwhXfqpgKM/dm0CJGmQLBpR/aIbR10FCvoSBpCuUba
   DSfW84mExERo+QlS//KpC3whaYvrHN0/3NIVRdul1iJhwIsVyP+FWx1qw
   p6tO2HirQ6Lrd/IoE4slp2Wd6Q7A2LQHdTO6vlqFipcm9YplkoN/xvweD
   6iTEhrpC0Pi45vnonOBYbcfC7h2PqiB/9rBOKfP4Qnx+MEzg4ast3AkMU
   w==;
IronPort-SDR: TiJNP4NONy8WKkN+09OHhVv3qxxQez6TgSzQBCkScOxUSCO4qZrIDFwr8dySfwNrXT7R8mlFPg
 7VatsQAtXj5fg04AYQHHYSjYneTN7/NCFW2towIPZdkDaPULvM8zj0p153rvpT0ta0DlIuOCRa
 CrbUiA0ECNwahIMIM2AaDY+uBHuvnhDwvmJDEfzJM3bcws9cN9u72GdmmaaPRWtauqMO3/1SRG
 97UP7zAnhV5Vf8UCwNHF2kma30mH99anI9pzKhuTJ3ZY2LOC7bjg/p+eMmyyulUNunsT6mG4ee
 jlY=
X-IronPort-AV: E=Sophos;i="5.73,354,1583164800"; 
   d="scan'208";a="239560785"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 05 May 2020 16:47:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UkMgRMsJC3C9wOe5v8AZB75gUL2xQCOxwES89SHomzJa9RwrzpamXIiPCdsCKpMWi6XVKnz1tjePKFh+ij0UpQHySFCKlVJAXo3vEvkUmoTmyyrlMVxAWeCgFA/1ufNzt3owqPBlsbIJn03MP+NLHWwoT53b4oO6eqVG0HtTkfOpzpH6xLQJTZ6tWikZ18GtLVJKFDht7xghrw49kWewwK1Ge5DkNYKi177+jRjHjOW44/jqxFP88g6E8gSjjyci/p+da5NcG0dT3IQD7QcwtN4gaktre6bHsueJ2+juxARBt/GBRtNqc1TmROw1TKaazGuaTdltgKn4F/MjOMIOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu0ihHaz9Ji7aXtVqTYjEZS8QOBBhnDuiNBDZqn/5R8=;
 b=darTtJUPA+EJ8JYw395CgFDG3nFv5fZjoMI5yeKxzVTo40J1F3IBepxSG37I0F/2PbaVrSwtZY6hJXtVOg6KByr4APY1oRm/vUeIqTeVJTk3fmJzrDDtcSRg50ueRlpfVp3c+kDKS+OLjOzSv+0qXv8k0ga4rtbxj0lG15c23AeBood8satfTKthIOafGpXs8P0n4me+eYnUs6/bnckqQV9X8tYrDhEU8DmJME8ZedyGjURwZzIQJbH3yXq+l6v3/fR3ZM4UR/cbd6gjPHFQfkgtnUcGrSqEj0ge5p7tVxtLQfx+c+wzk5EXgatyaOxCA6b4pW62h8q1JF9vJS1/gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pu0ihHaz9Ji7aXtVqTYjEZS8QOBBhnDuiNBDZqn/5R8=;
 b=J8B3tNuG3fizQKxlsEHNN+M8euYIoHK84QjGaernsmuFr2+DcHNblZjJn8C4ZgavRq1SkrJVksPZTA91G2SUsMy0oTdmrya9OMf5YoI9+qsZ/o/YNvONMI+AhwgpVBlh7UcCTwHeC1YI1dX7nEKGY41bayjlYFdjKOvJOxtXMck=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3600.namprd04.prod.outlook.com
 (2603:10b6:803:46::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Tue, 5 May
 2020 08:47:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Tue, 5 May 2020
 08:47:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 3/7] btrfs: block-group: Refactor how we delete one
 block group item
Thread-Topic: [PATCH v4 3/7] btrfs: block-group: Refactor how we delete one
 block group item
Thread-Index: AQHWIm/wBSuie6ZMzUeAbwU/sq/ooQ==
Date:   Tue, 5 May 2020 08:47:14 +0000
Message-ID: <SN4PR0401MB35980F5B55AB37C71E789C1D9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200504235825.4199-1-wqu@suse.com>
 <20200504235825.4199-4-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6eac70d3-6b9d-48a5-b839-08d7f0d0e8d8
x-ms-traffictypediagnostic: SN4PR0401MB3600:
x-microsoft-antispam-prvs: <SN4PR0401MB360058791D1783938C4476479BA70@SN4PR0401MB3600.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0394259C80
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: x+QMiHRB9TO1ghbrtnPFcghx4DQe8s/Y+MH8s//UDmVB+DK7hfvIb00bOJjxDCXwzRR+24nLW1q9izK9822Yxb2s2PH9m3ASjbNIddUO4tfsDiwhK20/h8uVzD445z9BW2vIwH2g7M0xB+5nL1FIZocVBHBfthCQ29ORbTRiP06w0GG9DTB6UPG6n9dYsLSZKPLdlMoUVzJRyvvyKcdWEjo32+q5bR9xJjdOZIoLgJFlLoiuuTTRM4IJDgYOkQJhz58ToSBIeqPS9q+jsIpzJYw3AY7LqYRPzpGQRRX8vs91K3JgyZabMUNQC17aGYBXykWGKmf4XvRsjDuNqgIbrsZvQrKmarhQ9Bk95MFBPAYh3bT0jNggH+vjCEQrI63ee6sjtefZ8Bnu5cwrp0jyusbkhpEnZn5xS6nwVxYHeBjoCRGUZgQXsysFJ0Nhz8jfSL91FRE5ny/9NTfA5c93QMmspauP5+aFSWetKElkESXw705ICLUANytVqn3UBvDEwl6YfuToe8JVaSxNI8UbmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(366004)(33430700001)(33440700001)(8936002)(8676002)(86362001)(55016002)(33656002)(9686003)(478600001)(7696005)(71200400001)(186003)(2906002)(53546011)(6506007)(26005)(4744005)(52536014)(5660300002)(66446008)(64756008)(66556008)(66946007)(66476007)(91956017)(76116006)(316002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8G07Rop/QqWJzj2iAdf4oOr14MkTUFbKyrbrlXSaQCEYLkkl05jsdJQ8vkZ3aGDF7waq6Ys/gVdSypVd/qHS4dFkM3QnY7XX8K02oc1FYdtUQc0FiznKhRu4Q/79n0lnRr6TBsfwwqTD9Xf+4AuzWISpyMVVO4Q5QhO97GHHAovC5x0er09pfQhLVMBtABigQnBhL3FbKb0lOUcPM/4saNabFF9CW2SgdMGSdDiz/usHj2XCr0tCxpiSUlucOy93fJfu+wsBk31MZ5WBgT6ijOlKzjeIxo7sFNtOv8wgUNj6jU/EV3Mcv1Lh9KVa791WOql9BXEOhBl6LBXftCbCpPu6aGngal6pcy7YkV1XEfbtkjOfZPmD0MuwOWnjFnGe3EOIY2SBcPpeGZIocJv6HKUb+QSwCU++MyHGtPCrVOho2cCxsnf79TQs0LOXbc9ZsaYe4bw+zV9aUsXE6pLv3981e6UWOqSQExrOfEx8Q1yoWeLMASTdBOjqsPjlLSxsvPjZQfcMnkXWhY7i6tPJ2APUesfCAbsItBa1jXih7YxiTEQuXzOrIGbnFdSTKZRDcy/0GhXlxLcSmOh/bRbFWbjNvb46O6nQkcbn/ITEiK+bjaKZIGQ/QrpQojdu5apYY653dNKXTw7sCpf83BL7n/Txlj3fmT4MDlcukMKZ4t15NPAg2Nj6hxguNDVN9+yW/FzYWmyApNw948j4lXzl2SVsRjqMncBIK+68UsJm9UGnKTziPETTPCuXNV98t3ch1oKnOLx/qqD3cc1Ty9egJTGClb4VzDowR3vxS9x2Wms=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eac70d3-6b9d-48a5-b839-08d7f0d0e8d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 08:47:14.4856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pWgjnX4N0ubhvqZ3jrigNbZ7v6tsz6HLGrHMCroYcAnosnZ5PurZ1ysetVtiWSlqPdp7WxzADR2o9DcOHPoF7kGLs2lqmruA2tzulVnW/PY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3600
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/05/2020 01:58, Qu Wenruo wrote:=0A=
> When deleting a block group item, it's pretty straight forward, just=0A=
> delete the item pointed by the key.=0A=
> =0A=
> However it will not be that straight-forward for incoming skinny block=0A=
> group item.=0A=
> =0A=
> So refactor the block group item deletion into a new function,=0A=
> remove_block_group_item(), also to make the already lengthy=0A=
> btrfs_remove_block_group() a little shorter.=0A=
=0A=
I think this patch is useful even without the skinny_bg feature.=0A=
=0A=
> +static int remove_block_group_item(struct btrfs_trans_handle *trans,=0A=
> +				   struct btrfs_path *path,=0A=
> +				   struct btrfs_block_group *block_group)=0A=
> +{=0A=
> +	struct btrfs_fs_info *fs_info =3D trans->fs_info;=0A=
> +	struct btrfs_root *root;=0A=
=0A=
Tiny nitpick, why not:=0A=
=0A=
	struct btrfs_root *root =3D fs_info->extent_root;=0A=
=0A=
Like it was in brtfs_remove_block_group()?=0A=
=0A=
Anyways looks good to me,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
