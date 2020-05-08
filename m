Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6D21CB042
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 15:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgEHN1h (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 09:27:37 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59687 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgEHN1g (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 09:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588944456; x=1620480456;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=UWwmGhl0jUtYbROxWgyYaTXB7Lq0kcAIUnidbEqybbU=;
  b=RzQFoGUEJ2ukKNS9/dag85WpF+4GltKzjAFRFmKWspFQd98LZCKHBxV7
   bPm+KyehkXwTNgjsNm5z6Q1nvd1PnQC4fRGzm2Lqg1elknbggqEHPESZh
   m0qVrIEwXKVSq3F5WW3nQcYzicn0fT4G6FBoLwwNT1dzA18/QLFOVzqsV
   fSIv+1EkKeo5iBioMl0H3iHgeje3u/T9i2eERj0OXhLtkZ8bCcWzcR6+9
   O8760tR3emeiz3IXZsI+RXDNBm6O5okoeo5RK/kpZHVAMmOyU4cASCg0a
   oiChyEeLgtRkk5mcR0bDvq2WQnNOtM5FbZ0jbXFy1vAfNW+mxt1Xdqjem
   A==;
IronPort-SDR: ZYdDQWSVMOMzdywcyF6FwDsHqdgp+317mShEVDRUpPpJSV0E7Fjnjm4Ws/y+2d3hWTqGAE4uQQ
 nwBnOEBQRPeBHEBZ28me9d9L8yXmWSq4C94q+mlPoWld+lx44G5QJI91WS7jre6UN8mlbkPxW+
 Mh0Cj1exiDFKdEFxvA4IR+wkViDE4GbzHQxlLhSBklyPMQ2YaKNuS3GezMpDMCIBzoMY1IbjLw
 2jdZ4aN6xbQOqGfxurizDRxAhmBbqiI2ORt2b8YP1KdrZLpGPoVhk84pKxINben7uVJ8Ofla/8
 9K0=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="141574552"
Received: from mail-co1nam04lp2051.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.51])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 21:27:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LjcGaZzy8oxmPG8say/fIdQDR2u7QW664EtlIuMwcQ9UsI4RX4xn1pAMsSimFAHCqyOid+CP+oreSjM8L4GnDPpfYK+SKdbH3uzUbKkcKrGj9lADX0aKURJf/Ki2sNmzhUIIazrfHYIRxF2G27c8Zzf0jddy4/co006ylY12DeZhycY0Y0fDOfyvoCKaO1dYFEhQ3vI3LkXtBP1IovAsUR0VodpfAc4Lu4DlHNTtNgQ94oHqH1g7pnk2W8ArLmCUmZPStOrohx7lt0KumJAFGxOot6wb42Gxiuv9EVhKB2h0qse7fSnOxbZkQe7ULlDEa6RwpfH6ZsbwyqTgit9gkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azBACftER8smUsclhiBxBgFGsl+DTBHrbQRaMPKsEYc=;
 b=cdTZygXNHfwZ9InTaAr/smUw58e+sKIwWjzjJTK9uRhVHTNSwzs6VXcMN5O2kcdPxC2MmwNuE+ysZyMV6peewguyRzHx5YVzVpd+Ra93QlwawRoKJGViiFy1tEXgtb0JSEw8K53xTFaIg71e4d80gHz4bEbvxQnqNA1eGY3SCi4Hf4M/Yy0YywNQWjz4du9EQV+usU2ZYjzjFBgQItYoX5eCAQgM/VY/0VcaT6HhtkFhHfBkbsXu0NjDf/94IFaDE5zhdKy8w4n/QyLmuMpzE5JpeUV0HlH6jQOB6l8iCNWX4FcN5fQLB1XZEYE6UDiaPGKuHl2hUbpnFmY1qHH6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azBACftER8smUsclhiBxBgFGsl+DTBHrbQRaMPKsEYc=;
 b=gNfCsisNKcMslPsjZ8tKwaLdUJom/fz448vu/lQtZjJQ1V6hOLnD1MRpN1kYlhd8sXiSddulTl3Msc1nunr58Ruzw9d6+Y2Q+eBMkOKRkxBsNdiiAXjA+riHZ2JvvUVqweeNs184I1RO9VoDCsAhMQEzmqk66WcMdNoIWWY2kRU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Fri, 8 May
 2020 13:27:34 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 13:27:34 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 04/19] btrfs: don't use set/get token in leaf_space_used
Thread-Topic: [PATCH 04/19] btrfs: don't use set/get token in leaf_space_used
Thread-Index: AQHWJKz2IVAKDhDy4UW1vCTO8i22iw==
Date:   Fri, 8 May 2020 13:27:34 +0000
Message-ID: <SN4PR0401MB35983A1F8C38CF17257F0BB39BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <1cc25c58e0c35e35bc01e621de48649bdca6746d.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c3d0e8d-1baa-4008-f783-08d7f3539190
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-microsoft-antispam-prvs: <SN4PR0401MB359782D09056F88DAA7C2E239BA20@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XWgxIhNdSK9YPk19zfSLeUUGIO+ROO+BkjpbVcu9JOuqKunhMlm7OkdKfiYZT6OYFjiJpkVS3WwZ+DlD6qWxXPzp+SIX3olCvAaXz8A2GCWqsUSh6FmMno6VJ+ZjMaW8NhQE+3UC9MJqL5lLqnr66YBR+EKWyoLdJFAiJw81H2r5zNVg51kvVO56Bxb87xYz2fvA90JwDa1s6Gpoqu11aeFlKjTb4dOqoAzMRX5CvIFurJr2c89wjTLvORoys7O5SNDqEq92PLaLBPY4tfPIWpPSAMhHGZMic23x5pRnJhBPxmq87DG2sI/qP0mAnFl8S1iLLOyiQD91jzRv4/DPffDWUZAKvYoP9F8Fj0rRZ4up2S0V1CCJ0QZIzadl46+CszczoBcCO6bteiMLJZ+l17lAoSqs7cmuQn62z9ZbkAdZ9Ib5xkc1IzdzLyiE1zoCQ1FaZkbm4kC6XyLcEd9VyBijrnib3ZvNWtNvT3gG/44II0vL+6iEUtEhSGc2nIngz18jl7cCsGfbuBPOV+b04A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(33430700001)(66556008)(55016002)(64756008)(9686003)(66946007)(186003)(66446008)(66476007)(52536014)(6506007)(8676002)(33656002)(86362001)(71200400001)(7696005)(558084003)(26005)(53546011)(478600001)(5660300002)(110136005)(83320400001)(83290400001)(91956017)(76116006)(316002)(83280400001)(2906002)(8936002)(83300400001)(33440700001)(83310400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +xFhsAu3WCs225DRHjGCyrDSkPopVJjNaBr85cgauSFtloluFiHmGc4uoT5k8v+skH/96vebMDe9XWnWXUflYo3a2m3tX5z1BpvSHj+XmXnlp5AE76mmYhjCdefSx8zLZhWgOaPus7+7H/C0U1vjzfeIV7tJj9ov0R/BfozZCMtIRQGyIgoi2KRehfRnYr1MeR4s8PXqB2L2ssudcyvTN+s8N7xBOXGjfbXkGx6ABzsyP8j31v/aM7E2rKjPYptmjEbp+TvM483eoCXLJrPUQH1LyUV2UdC5DYCiRQvdby7amV0FVUc0sAHGwLGJUIb9YDHjCqggLRRv+KRj2rmHYykTUj8xOK/5S1jR7oW+WVFRlAP0sw/sLO3AgQ1dHsBYXm9/2uv/hmEMHqPk5dDUbi6LXHnThNQZES+/Gqq45PHkBWk+FpFm8fkoErZddhVBuSN/GoLO/GG2GhL5cjKJdugDrH6XKjnB6KA4bPnZdZ7sywsWVi6r9JlQsSyqapwc
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3d0e8d-1baa-4008-f783-08d7f3539190
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 13:27:34.5437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Kvy0CCG6+mAkctuSUzKzrzP2x2vl9LC8RH6LbGct8uD782WYrNpK4pefWxZ7YTMlxQEjOkhmnngCMasl9k5rMXN/6WWoflksQb3xrRyAwE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/05/2020 22:20, David Sterba wrote:=0A=
> +	data_len =3D data_len - btrfs_item_offset(l, end_item);=0A=
=0A=
Nit: Could again be data_len -=3D btrfs_item_offset(l, end_item);=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
