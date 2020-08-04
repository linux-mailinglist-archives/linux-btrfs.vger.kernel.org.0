Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2930623BACC
	for <lists+linux-btrfs@lfdr.de>; Tue,  4 Aug 2020 14:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHDM6Q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 4 Aug 2020 08:58:16 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7889 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgHDM6O (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 4 Aug 2020 08:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596545915; x=1628081915;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=U67yIigMF2xlo1wXI/g9AN0drvWFnBbAbjWNgno9az8=;
  b=YfBdoDIsZk8RLEzWYhpMYvXligaKp6fv8p6GRLhPiE8DYgVKck/2Z1Rs
   CtBHOrai14phZUs8WMS9MK33xlM1a5u/hNEWvKyuc3BX6fiPxLoNM6XB8
   Wm4FUdior6dMdrC5b4SZA15rs6pXl7aeNXuL/K3TZSuvoNsmq4/nQHYaH
   26Ne0I7cMmvZAneJ7SAat6IjrbReaF+iR0vAEafMVKW4sHY6z4mR7hu7S
   QD84x1Cs8gNqfnLmjBo6edYI2A9wLS22oSP3TNrkBIBKwyWXAy+xqFflZ
   1QeDdO2vwYX6hq/PqKbkarAyRUK0WRvMxBqMGGmb/82UxiSFyddV2pt7Q
   g==;
IronPort-SDR: 4W8Yr8sxXbqKO7iWodNck4talBP7o6UcR+K9tgnVExcvXfB1eVtun5UI97KSm7zD4xw81jQePP
 Y0X/lvlTzin7F4KmH7+PMMcaweStqxBgi4fjNM3ZPmC6MpCR+Wh/Fgma8MoVSqfxBw0+h3Vf6W
 40Yiv0nS55dczMzJXp7uGkfk0VHUGPR3WlyFIcXUM4Rqifz+jNqfcLc2GSujLtiig2qH4cBXbO
 1Y7aaOzR6Feb7L8WiVeoC2vksjzbHcPOnCiyKMFXoB7UGvs9mkf7bJRbP/dJd/PENuPUy9oZ++
 hbU=
X-IronPort-AV: E=Sophos;i="5.75,434,1589212800"; 
   d="scan'208";a="247209161"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 04 Aug 2020 20:58:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNYKf+bnTZ2s3i3Eyrg2B+8uNpH6rmBw6WAqdkwomRrhxta+SEk4nta2prqVMM2Utl7UibXO4q0dc90sNpHPHpT+HhHZ+T2Sx/wIt870t16XbSmh5MygDisIjZJk5aRx3frACfJCwuGB3E6rplI3toQT8uxr/6tOaGRnXPBm/GYwJLfCIBZjuOFzfEZJ26T8oQKYX7QDM0N8PPH4JaBkhjY6Ixwy/E0R7H2qbTba5QUY4N2pxrdmdel28CgSqe90jiFV6fldDJAquQG/0Q3zihv2L/OuB8xsYUoUExFTjDa+OmxeeDdB+f6QxUL+XNEp2iBcxZOWnjW/4h/DGvKcBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+69u8RFdsbaw1dRhDCDHIAtFIt1Gc3BybPPjZWjHXs=;
 b=b7Ucn76p6Sc2m+TVYN3ltqQGq9PuwyuvcYK9eklB7har+wEQNH9vBzmUewPwnFFwwdAJsbDbjpAJAqluHpWpodNjENL3Cyl4NOKG7QiySWw5t9mwnmrNu0DdpMaMxaOuBHmhdeoLNLPvfRJ2G+DqPBeD69ROIM8SsHRadG8Dzjf1efJWpdvDAQ46NXeaDHqFhUu4yjnpnNgY/Foxn9hvYvNlGJ5FXHD2OsmuSFaeiRJFJV94dOkv5mCMta8KFue1OuhZRNiQw3q2aCVcuuES3sxJnnpTXID2IQLb972VSsFOeVYeTD+T/NMbqkr0SmN+UHgU/XQL2OKdtO8uk1+nrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+69u8RFdsbaw1dRhDCDHIAtFIt1Gc3BybPPjZWjHXs=;
 b=XgwVUkk/3SW1O6KX3IKXl26aHl0d8PAjMoRPm0ruSVXuTHGpmOhyaXOmvrQTOmHTuy2itEY7OF6lsNv2aC2uvFauLSptXfNow2Y7qGdW5PMGr5jTAkEo23MS9EVgUAKaaIKr3KP7/0rrzwARt7pKYuhm+ZfDJ42d946vSl7JBDQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3807.namprd04.prod.outlook.com
 (2603:10b6:805:43::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Tue, 4 Aug
 2020 12:58:10 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3239.021; Tue, 4 Aug 2020
 12:58:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Rework error detection in init_tree_roots
Thread-Topic: [PATCH] btrfs: Rework error detection in init_tree_roots
Thread-Index: AQHWajFw13NbiizPok6hrYkWnsewsQ==
Date:   Tue, 4 Aug 2020 12:58:10 +0000
Message-ID: <SN4PR0401MB35982C96F01F6CD1AFB31C679B4A0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200804073236.6677-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 85557f81-f29c-451d-ecd5-08d838760aa5
x-ms-traffictypediagnostic: SN6PR04MB3807:
x-microsoft-antispam-prvs: <SN6PR04MB38077A069F42C3CD221E02D69B4A0@SN6PR04MB3807.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JIBz87VPxP4k5JH1/0gWvJn3NM75LTYDT7yfkG0Jx9O4Ie5jY5RAxqIrTbcdzRFPSC4nUZ52BBpSXmLk7FhFEYZJFHffK24haIC6Dpyx05KTLaxOZ07WSBnI+8Zhxch8TVIwlf4czWpTNsMKrUoFIl0SLav4u6l31OL6Bb82oIBPf860kLjLnZylqxYuWF+ra9Y/vYe4MDvz0Uk6JFg9+YUR4HENfEANzEUnr0FxITvEtxMNBJRon+EaN7Wkb/W5Mp6LF9v8engDOVlopb5Uxuxr22euXTjQj0MQwQ9oet4JS+vC10ycG3RgcpqPX12aewDNBKs8GPf1YuJL42FZKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(86362001)(2906002)(52536014)(71200400001)(5660300002)(4744005)(110136005)(55016002)(9686003)(66446008)(66946007)(498600001)(76116006)(64756008)(66476007)(66556008)(8936002)(8676002)(7696005)(186003)(91956017)(26005)(83380400001)(33656002)(53546011)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jIjw+9p3v3T9rcq4GiVg1J9NO1sMuGFymMeJUgpWUOP7qFKqkiG64Dt0+18HorDqyUnqPROIeIyrdRC+H5WjkInHa9uVumUKGOcoXH7+jhcNfcVYXb+HNIzcUtbOkRRWsU7Z4lfYPmizhPF6rNr2ganMR+A+fg9Z8DwF6phwKZgVFMhknX0EjACA1NDCTLDUcXmYanVRmCTzh/Ikc6f3VZs4qQRXOuRbSBu9rt0jaVGN6mIcZqbA9q60Ev4ZMBZfdatJsYYqk2TeiH4N7ChWbTz23B4ym0cQB7W2lvxAKaRCX/A6qKHlidF7/opgqshIclfAcP2ea47B87otnIMv9MO0+oXB+0IcjmOTTNE6CHnMM8eY3+C13WVdJviAcHABEw03gsGfYbD/evBTgROl8zuDIYfYYNPsiO/w9Ra4oCf4/rD44b92SP8gQUVXUWaPR15GE11YQX7+WG+dSKtwOrTO5kWddlCAgwjm6THxxIkxZleP2uRmqRS8+XGCu9pIXumZkdWEtrnCiXk0zD89Jvm2tyqUtaDRFY7qx5z+xxRpHG6YakFVITmCnrCuRh6fpIZ+5VPL3eeKiG8psE2g9+d8j1R1VOkFaZbzIxzhGIY3DaA+/UL6ZScEBG6TdgNp0F7thbL7llnTUynw1ZWMAA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85557f81-f29c-451d-ecd5-08d838760aa5
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 12:58:10.7988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgjEWMeN2nRJzqnO+UK/a78PdX4JO6e28x5iZAiUFos0Y26/S8CjrEM/ypFOtpgSl4bNkzPqvDf/YZg6rffYrv1EtvRYplhzqq8qFSW3dfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3807
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 04/08/2020 09:32, Nikolay Borisov wrote:=0A=
> @@ -2645,17 +2645,16 @@ static int __cold init_tree_roots(struct btrfs_fs=
_info *fs_info)=0A=
>  		level =3D btrfs_super_root_level(sb);=0A=
>  		tree_root->node =3D read_tree_block(fs_info, btrfs_super_root(sb),=0A=
>  						  generation, level, NULL);=0A=
> -		if (IS_ERR(tree_root->node) ||=0A=
> -		    !extent_buffer_uptodate(tree_root->node)) {=0A=
> +		if (IS_ERR(tree_root->node)) {=0A=
>  			handle_error =3D true;=0A=
> +			ret =3D PTR_ERR(tree_root->node);=0A=
> +			tree_root->node =3D NULL;=0A=
> +			btrfs_warn(fs_info, "failed to read tree root");=0A=
> +			continue;=0A=
=0A=
[...]=0A=
=0A=
>  			btrfs_warn(fs_info, "failed to read tree root");=0A=
>  			continue;=0A=
>  		}=0A=
=0A=
Now we're duplicating the warning message. I think it's better to have two =
=0A=
distinct messages so we can differentiate which of the two failure cases ha=
ppened.=0A=
=0A=
The 2nd one could be something like "tree root eb not uptodate".=0A=
=0A=
Otherwise looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com> =0A=
