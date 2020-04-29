Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AA51BDAE9
	for <lists+linux-btrfs@lfdr.de>; Wed, 29 Apr 2020 13:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD2LpH (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 29 Apr 2020 07:45:07 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46744 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgD2LpH (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 29 Apr 2020 07:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588160708; x=1619696708;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=E4niU6oVJ8y2g814HlzJBeRY2OMkWgup5JuJi6HWVWc=;
  b=K1rJEeB1LVx0thN2SWarTZGAHaJ0WPKtl/MCRlj/VEF1aQYhwzl/iLcx
   OaWVA5vnDRAIejF/ylHYqibGVr9+SZ0yFdwo5krW23Bv956u3sWkkDqwp
   BzqEMtCSkBj0ua9BL+Sr3eO9Kqk4GPBDpqohNUoq9aT2azDfYW9173+B6
   lSltRIAJtlh4dNGHcmrxJqZHSclPcyFpcozrIRFIUm6VDhZYGyNhdIbf8
   XYTRyD7xKnlHoFPhEiLFZUMH6266l7UJ9chX+vtwztWCfwhjPGpocMYLR
   RhTpU0t9uw2Gg2rSq8QGFNzBvF56bYLOtp/tGhIAu2nYYQakYB5mXRa3h
   g==;
IronPort-SDR: mvcdpxXhMcFLgzn1efjUHpXY+ZoE/7y+JZ2rDLGVKUxcNn+hb5GpbTIic1YqPi62PqDw6nllnL
 xeAHoK3WUaJL8Z/gzkiyemwtgcDK5JJy8g5cxasda9fD9IjINanJd9ir0iQQwvwXati5AUavyy
 HkAuOihzg2xb870NgXh/HFBf4+aXc2mdSCgaLtr6ZOV07MCz33ew1elnprfH0mmJ9NYJIOyNVp
 VY2cUXlsze5Ys0tAttyfphKo9vxsE+IgD8Lr3srDrOlzLoQ9cqqD2p5I8zocbXu5R3NYayeDYh
 AIc=
X-IronPort-AV: E=Sophos;i="5.73,331,1583164800"; 
   d="scan'208";a="140810476"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2020 19:45:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJH0p7NFaWNqD8//lZRaygrPSLuvVP6aWbfr8/2yEvy025sfQpO0swv+m7LgekrWYmxos5IviZidTpQ/+LC74tjUq8AVArPWe1eRDWxofTO30P42I3nwM+vbMF0JaPLAXTeuVgnfgQ/lCgHY7kc3h18R801xS0CLV41EvL/aDWoPhQ8ZptsYnDBeL+TflUlMs8DCoUmFqUA26CFg0LPfCLTX0p8OvWZLxg+pTQmvDrBdo9biEzKAbiCiiO1BksHjzJvPJcUkdgwAFZ677fTztGINNiMWcv+vd9m7GHtpg40WRxgwTn1CFkRH/o3lTMS/IblxJoj84TaCsbFmYBQRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbAUDmHvuxpEsbacZ4cf7E30RGLQXLP0h9gqQzITUzY=;
 b=EPgn5ucndGXe/6MYFtQiQ0UZzWpG2SUp5M8GptKVVYxnfiJCVA2Wa1jcL/cJQCFmkTduA+Qftjgq8ikCk7QpxnhvwYU1mSUxwYgsd6li5lenIaMS5yep4BVuhAvjjrWSZS8xBHZlHkduvvDbYEO9utJ1QKwIczpDSCldxkOZwMM3lwFeEHvZ8Aeb4CFf6uv88YtTowdV9SUdkA8fdiQDlAi4buARKHqgH+1WVX6sokQQtmxi5ph+08W/KsYcBHgDpVDEwxeEToSUAGaOfhVOerr2YtEtge6d0erEG6Fg7qixa+9YOG9frZ2jkXHHVLVwVWNNwkn8lWtlY6zp8xpn4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WbAUDmHvuxpEsbacZ4cf7E30RGLQXLP0h9gqQzITUzY=;
 b=wGQ6RP3kQNOg0hiDxNLbZ4H7VKrDQ0iDwUB44a7bykXkEAb71u6Z8URF6+2kxPh/eHDGk6VrcIsj8fecm3kHvl4PF0FcWrl1Kr6Yr8uOYCfUTlW8Ff9szq3XybZhJs06wL6jFwK21IRlTCd/dW1V5rh0m/bC4i0UlrLlgiDou/Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3710.namprd04.prod.outlook.com
 (2603:10b6:803:43::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Wed, 29 Apr
 2020 11:45:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 11:45:05 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Johannes Thumshirn <jth@kernel.org>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH 3/5] btrfs-progs: Add HMAC(SHA256) support
Thread-Topic: [PATCH 3/5] btrfs-progs: Add HMAC(SHA256) support
Thread-Index: AQHWHU3J/+HF4xlHa0e1s+wXi2e4JA==
Date:   Wed, 29 Apr 2020 11:45:05 +0000
Message-ID: <SN4PR0401MB35985F6A0AF6E0FDA6BCA6C59BAD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428111109.5687-1-jth@kernel.org>
 <20200428111109.5687-4-jth@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 61be12fe-c03d-4fa1-758c-08d7ec32c28b
x-ms-traffictypediagnostic: SN4PR0401MB3710:
x-microsoft-antispam-prvs: <SN4PR0401MB371053A9AD133EBE8D370DFF9BAD0@SN4PR0401MB3710.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(9686003)(478600001)(110136005)(55016002)(316002)(54906003)(7696005)(5660300002)(52536014)(64756008)(66556008)(76116006)(91956017)(66446008)(8676002)(4326008)(66946007)(71200400001)(6506007)(53546011)(2906002)(4744005)(8936002)(86362001)(66476007)(33656002)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/E1am18sojTYNG3VzfSHWsdBSlbLx9IX2kHk91Y+/1hxfF0sB3co8pL6OmTvGcQeXlLsQAVxmTNr/mYJzMIQitkkCHYQ/0Kc66e+tTLTTO9KIvXa4cRkrQ5N/l68/JjDXovBtgRgLOzmjqU4+3gse5deDc8TKHjlj/bjdmU99FvuzZSVAnuQ5DMbZjQbtcFs6+k9XQ9j46QIe0WUxZDRegz3H8FD4m3RQeZSkc3qXmWJaJuqoIbsvbTEFRfZzuPvyS7cM1aWeld1YPvr6lnq7Gbs+4KO1n4bHGs48+gXIM/HWyyvp4XKc5PxnBEF8uS7j77D1wqnZwATGFqYQgxxwVvnoiWPOjuOtg6sVPpmlv3Rl04N0jKyfcEfUTqdidoFLzH39koV4YoeBDzMkb2cTC6YfY7lSsMTYTiy2xSNgLVmJqQVWkDiKtLm/K7/zAF
x-ms-exchange-antispam-messagedata: j8ZpUQYytksTUnvZPTRBnQISUsDIEgDJiJu56C+9461/TOgkpf/x1HJWKHP2v2Okax5/caNDCVIoedBdckitTWjNuAZBy3LfRDd6dH5J9FE5pBnGaGUOzxPd0w09sK/fOOy8RpwUOOWL3Gc4o8W9kcsNkU5xaqfGYM/v34CcWNo06/btykDqis5kFGvJQuVQwigvhCelg7pl2kzoY3pJCBjnpcjgfYY8q7aC2gZ6XiuYEJ11W5IAZHg9ZJKw1pQSp7AEhisvw4bLEDsQFSaWk2T9P8LQ3fOsTGpXxtNWStNfkeOQMlUU6yN9dh+fbUdh6OSf1Q3rbWyqXHn2KBox2UscPAsgWmq2QSHRjsCty+tTde6dACft06aceWmA2CaDnM1dqrvuibBDbxsKxaAbkU5nfFX75MiM/sw+ust2Ygr0WQUElz2UjuxGksHS+4lp5Re310SutAlUI/LU/N4SWdgOxnsC9nkmY9gEaPhEgFn5gBMmhaMn1l/tMcjfm0uWewrOuwKZxsFdhKTe9NksrJQSBc4a8+N1IJ3nldE7UvghL782fdhSpobOwpdXxghifzJd2JveEg1nyBNL5Mkf8JKm0MbxCpL6SD1A1QQIKAwou2cHQr+EJsVDkdTAh3q+lDg8XFbGri2uA7Nx4eq+noEZLUR/Y58OrTqj8NpDhL+m59oocdDNiVkRNKWc7UeqTX4r9kXfVqCF9ADsTSE3ecUK7IKqrLFO8RNJVq9tWIp4QYbP9a5wHO1RnnzHXJAIi84P4Ppo4TQRK/iWXbvJTLybmhNCjzzOp8B8Xpysbyw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61be12fe-c03d-4fa1-758c-08d7ec32c28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 11:45:05.1274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z1nzchAjczfllYCoiwNohZqNOeOcapOS6yaqOckvoGNiV6kYyGH5UBYDDL7Gz6Q4wlpl9Bjy/uPQw4vDplh3K3obLBLoLcq3rDGysl4IVH8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3710
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 28/04/2020 13:11, Johannes Thumshirn wrote:=0A=
> +int hash_hmac_sha256(struct btrfs_fs_info *fs_info, const u8 *buf,=0A=
> +		     size_t length, u8 *out)=0A=
> +{=0A=
> +	return crypto_auth_hmacsha256(out, buf, length, (u8 *)fs_info->auth_key=
);=0A=
> +}=0A=
> +=0A=
=0A=
This is not compatible with the kernel and libgcrypt version. Investigating=
.=0A=
