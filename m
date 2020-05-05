Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487BB1C60D4
	for <lists+linux-btrfs@lfdr.de>; Tue,  5 May 2020 21:10:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgEETK4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 5 May 2020 15:10:56 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32490 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgEETK4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 5 May 2020 15:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588705857; x=1620241857;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Cir9ISH7vI6W7eLzbWtsZYBPZaX6kh572EWcoRFCp6M=;
  b=MKidRzieq3SSX8sJFnZ8WhDq60pA6lcAi8mW1G+IW2olvkN0xnjvvPXu
   6/lxiZqyA7lLG1JgniGN+V7N8EAp9K8Zdnk5kIRmhW8nMjNLPONf3amvO
   4Ndkw60a0kdME3k9DnPGh0KJhxntBhkDDLzCB8OwnVPX0knzlEfFczi00
   i9D31fnJwAvCd3eUlOUo8t+lNvpS7Iib2itkdKD5k9VjuHhmZrRnNDNNg
   cG4E1RoG1mYOk91GhJqb1URe/0WkjGp9kOxBtjxSy7f5wJtRJlkrMHQDw
   kN4Yxv9XBX1UKMAs1wSkc/NkOKB4XmMZDtX3YWXOu9V3a7BKMXP0FWLaz
   A==;
IronPort-SDR: ilRhrFc0ffp8p9IQpdxuWvuK2A/wFclniKMXIeO7r3aVFwrXSe3kevTkE7Vcd6airfaB63aEso
 jxs4aKCT9tZT/KkHfuO1O3Ux7egWJDkuXdg9ne/TaX/E+w8pTmCZzWf3vaAsXvAz2RXAtpLbFl
 0np+3XQSxmR+oSxfbwB1VSzIN5GT2fHwaOP/y2MSBLFuQCZuXx/2MXwPpNBYkMGJH8Mw9UGSKn
 iD+iRgHvr5wSwmQDPegQ8wvndLvcvLog4oC0fEH8ZxAu+0/DbuHuBPxzK0ePBlrF+6yzYsTVqJ
 DvQ=
X-IronPort-AV: E=Sophos;i="5.73,356,1583164800"; 
   d="scan'208";a="137318534"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 06 May 2020 03:10:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1E78I9LyU78g+HdTz+U5gyXGsXMf1OGzyVhKwC+TrCeiumh/rPvGvsfER7wyDpJMK1/vlvjyEiOPZIK2DqUaD09wbat78finK7ypV46Su17wYzdxBF1ywoXQK8kS+DUIz4iR8sYMLz3erin8oltwx5U1W7CEpnIzR9Fbuk73Iy7A/t4oiixaqCgRYtTyV9zmLbZ8HHPVcCBpzIkmaF9qIf+f5o2LXEMvKgdagzdycCf3DPW8L6mrrkNvVb718cmr+KMD6/k7bbb13Vqz3Yr1xCtyK1QYvD5jwWlJRAZA7O6qocVX1G7FsCV71jOvDd49F9NFqAilOZmX+BgIyhLIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AjybYK37EKoSQJ2Mv7ZRxYWGrf7Y+T5VJAR+ACPI2c=;
 b=m5D+delkRJueofZBGkR3BsErNuICG5u7iScbSGTcMCuCY82n/CVa/RxVGNHz33DLE03tj87cTcdL1pziTnSl7hWxBu31j2GZpjijhP6Ntjc7UOJ08ttyFxLp17UO8d7/Xq4axP2Tk5rQfesQcoiAhRCJUlIacI9yAeEVFvkwOJ0mnlcQxKGVhr2oKao1Y3onn06yLz3PXbtgXfKkKpvcakCAykLgvZVdOj0ejBvVCbSLvQc5oay5X0MSsLotfTz0FYG/BvfHAGdvb93BVyzo9/F9PQ4CqARLlQL1bmOanewQXsQkJKOtA/4J9OTWijSKL49Y5ohKwh7Es/uFMBQPFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AjybYK37EKoSQJ2Mv7ZRxYWGrf7Y+T5VJAR+ACPI2c=;
 b=Idh5bWsH85EmY39cEDTMV/hzLFJEXDFGQbeo4SDPO5f0AMxnOUjpKchRCVFrs2uFfcP6SL4Km3w5LMn8iFlETfitGR65Xq/cIqAOlD9JrYNdafSoV6OU8LXY95aSso2lXEOXcIeXtwv8o+lMEQfBIvQNdDwClyWpc+qfBI/pYEI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3535.namprd04.prod.outlook.com
 (2603:10b6:803:4e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 5 May
 2020 19:10:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.027; Tue, 5 May 2020
 19:10:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v4 6/7] btrfs: Introduce new incompat feature,
 SKINNY_BG_TREE, to hugely reduce mount time
Thread-Topic: [PATCH v4 6/7] btrfs: Introduce new incompat feature,
 SKINNY_BG_TREE, to hugely reduce mount time
Thread-Index: AQHWIm/1JWl/xmJL90Ckai5KcOwwVw==
Date:   Tue, 5 May 2020 19:10:53 +0000
Message-ID: <SN4PR0401MB359872C31B77B386876AC78F9BA70@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200504235825.4199-1-wqu@suse.com>
 <20200504235825.4199-7-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eccf8b87-3c40-4999-86ed-08d7f1280822
x-ms-traffictypediagnostic: SN4PR0401MB3535:
x-microsoft-antispam-prvs: <SN4PR0401MB35355743ACF61875C0AC754A9BA70@SN4PR0401MB3535.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0394259C80
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39850400004)(346002)(376002)(136003)(366004)(33430700001)(186003)(33656002)(71200400001)(8936002)(86362001)(7696005)(110136005)(316002)(55016002)(9686003)(26005)(5660300002)(8676002)(6506007)(53546011)(478600001)(2906002)(76116006)(52536014)(33440700001)(66946007)(66476007)(91956017)(66446008)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qor2/2RE0yOaH7BLfVtCIR8gxMhh7LVcUNKggq+coQ2SfZSRcvhpAUTU4ZRtKafLcEbfKGEqtWgudW8GPj4nWqUkiMQIiyqf54zcnYGhygFdoedOhWGl7MsIoX1h7NGUgQYtqnwh4nFCWQpS9TbquLpJD4zSjpDK+8zKsmkZpW4ekcGI6olYaefY8xLTRHF27IO2UYiuLmC3PoKrvNq8HzZTTlvWb4du3WgAh00UsrIDL9AIqnH7HCKdgCutcCHiFLfql/jragOFn4PAq6+giQV/8Nt9yKNcmWBIVqy/ft9jPbitRLpj30Ql7EDabyxSmx+ZuGbtTRIeYButC660XSL8lB91ESGQx1uX39l6X8ZHe91drYtd4vyYtTQ83BCme7m6lIO8ydtij2Eq4Kc2+09PruXcEEDJK8Tb5OiTDgaSgWI7lkT4Tk1cNkAmJXQ/1aPQ94+oholAUrYgC114Wq3CwHCLrvWKMLVQ0tuo4UutVVVsBVLz2KYbhAls+6MqJBt1PFLBS5xsR2olJVbb/A==
x-ms-exchange-antispam-messagedata: 9KIHbaOED+gxuPRofe/iUHAi3DGrR260iBgzKRzqerWnCMaPL9vdmhZB8HrrzOW6T/Ows6jkuVqF7094lmTmPi9ErvPciLjv4AHuWKMCNOpNoxyWIJPGTOndF9KWv3UumY9q3vyVsXWGYFwYCCE/TWR29o/8dTTqlgyOwz0ZYBUirlZpt4rXtQh+JaM53qLJ5YD4gsVMf1sSKzfvKMJ5Ihx6LaiE9amWMGUA0aBNeamtsLK4TS473kbRulTeIZ56w/AwRi8G0yzKqwqCsq+46yrmGAX+8yMgXGbazJJkl/vh1/L22h/jQzXavcUan/2YZzOGc7qSdKTXUA9TsrZwdk73s+zRZCud09MGq+1QoeI5BH3fa3TyrKz0+TM2ssinIYRyW7DwPZV/rKOYQ3E7/w8Rf/vaGvlT3TsGUrRlA+bJwbgEJVcGvOrHDu2vQEM93LScujHJxg1/sJ2mp6wvig5xjgDMQ78KMJkKVI+gIRAJ1AzgCa6KxuPpj3CBcaZEyHuzfx6srYR/xXyvKswJN4c+RfwfFb5M2LqVb+/Ctzrq+dHdAVrlFWE/NlDqYMTjEeDNMiYbv0FVn54wQImXYoevHc6wBgiWH+Jfo6gX+BhSXivzzo6RkKx/vdyQ7MhhSuK36kfAvTIMaX6dT9kBjPs584xhxPkg1EE/SD+cIglvpuBCqnpoY4WbUQsfaaC+6GzRctLkZQxumI/ziIxSDdKONMdNwR5s/cd6VcWR+3TNbwONYOfWFbmXh3sEoQHGlWEHntcdZiSztXWljq9Wa/fJOBp8NgtLqEtggSAyMFI=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccf8b87-3c40-4999-86ed-08d7f1280822
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2020 19:10:53.1741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +IJLhKp5S6GuakJTzHGUhQ2AdGyk5HKERUvOjnzVYWkTyCjW+uCbI4bzOKWzyMzG2ubeqraW9qhYvJGQvYCx47WgQ3Y1/6/nrMUpucC+OoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3535
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 05/05/2020 01:58, Qu Wenruo wrote:=0A=
> int btrfs_read_block_groups(struct btrfs_fs_info *info)=0A=
>   {=0A=
>   	struct btrfs_path *path;=0A=
> @@ -2022,20 +2124,27 @@ int btrfs_read_block_groups(struct btrfs_fs_info =
*info)=0A=
>   	if (btrfs_test_opt(info, CLEAR_CACHE))=0A=
>   		need_clear =3D 1;=0A=
>   =0A=
> -	while (1) {=0A=
> -		ret =3D find_first_block_group(info, path, &key);=0A=
> -		if (ret > 0)=0A=
> -			break;=0A=
> -		if (ret !=3D 0)=0A=
> -			goto error;=0A=
> +	if (btrfs_fs_incompat(info, SKINNY_BG_TREE)) {=0A=
> +		path->reada =3D READA_FORWARD;=0A=
> +		ret =3D read_skinny_block_groups(info, path, need_clear);=0A=
> +	} else {=0A=
> +		while (1) {=0A=
> +			ret =3D find_first_block_group(info, path, &key);=0A=
> +			if (ret > 0)=0A=
> +				break;=0A=
> +			if (ret !=3D 0)=0A=
> +				goto error;=0A=
>   =0A=
> -		btrfs_item_key_to_cpu(path->nodes[0], &key, path->slots[0]);=0A=
> -		ret =3D read_one_block_group(info, path, &key, need_clear);=0A=
> -		if (ret < 0)=0A=
> -			goto error;=0A=
> -		key.objectid +=3D key.offset;=0A=
> -		key.offset =3D 0;=0A=
> -		btrfs_release_path(path);=0A=
> +			btrfs_item_key_to_cpu(path->nodes[0], &key,=0A=
> +						path->slots[0]);=0A=
> +			ret =3D read_one_block_group(info, path, &key,=0A=
> +						need_clear);=0A=
> +			if (ret < 0)=0A=
> +				goto error;=0A=
> +			key.objectid +=3D key.offset;=0A=
> +			key.offset =3D 0;=0A=
> +			btrfs_release_path(path);=0A=
> +		}=0A=
>   	}=0A=
>   =0A=
=0A=
It might be worth considering to move the 'else' path into a function on =
=0A=
it's own, similar what you did with read_skinny_block_groups().=0A=
