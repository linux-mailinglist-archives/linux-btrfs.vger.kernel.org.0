Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B151CAA4A
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 14:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgEHMJZ (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 08:09:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24462 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgEHMJZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 08:09:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588939764; x=1620475764;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=78eyBpNRngf1zZLuEJLKRBlM/FuYOiMyut3IVfZghDU=;
  b=HT++Enp2ZP1zLBNKJXREa/aZZESpR+bCvgZlqerPYWFtWqOR33o+DcP5
   o6OgCQ1rSSOe0E2u8NwWqhDyBIQBAZ/5wnTpfHsMDNt7j8zM0NlifHjTy
   zCKZ/7awlmbmwybi8V1aHacBZDVQ5LynSfnoY08216NdMlymZmt7c5IeI
   Xhbv5/HK1gdfmYAA+TeNGfWKF4SqGih3gyDpsvRIWe7hvt9w+JxPikLo7
   2omEtijhE4I6X85h60+Wu/RF3ZRT0da+SRcbCJnNGNhMlk2+Fl733L6ji
   aIBaLl2berwvZo76NjbqAfc0O+QH3qdKaFcwHkQoRkffvct6H/g41+oIr
   A==;
IronPort-SDR: fGXdFc0ypWnu4/8CuvKdnDB7qwXIX2LyO/ThAyf+ozqdWOJFtZysiDYY9TDTtBkVt2SBLZv77f
 VLo+0K07EgN6TBPbXqF1ByveK9jKBnNpccwS7nLF8UbEyncg+aLMJvZ2R+M8GY5LM4JhKq9LN9
 8cKd6OYiXjlD6yNU2ln/xiGzwN7C3BEC3afEF7UQCmScYYYAYhJGCp6vs53t99YNtZKAt2Nfg3
 A6w+IvVclBqG3E08OQWPcFSVBh4r9j5sx5lobitRqWhgPMVATdKxCMs+rcqotVYXXKSUBIoNlt
 BXs=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="137560562"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 20:09:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gObkuR6W0ExN0s0A9ypbafZkgZm4JIQU5w8PjTYKNLTLjxrXaUfJMnyp7pyZKPlA4mUuIFelyCCZ9keC8rcwci7M3UuR9vSvw0Z/L2h1FsBk/C3bNLQGK4V24CYmKx3cBEKMuCZwL5rLSUdnc+uu4rarL2CzyL8y9FeTzoz1M9pXTuXcDG4/CwwE8lozAV+s+aI551azXjg6R4h+k0Nt/0UYlbxJL68Z3ahIVNS2z7xwxEPbvSl+SidBSAjFC57RVdnu/QU71OPPCyS2axoi+cNPdfjBgMHEoU0hyJqAH5X4jjm01G5WRpfnGTID1kImC3pti6s3SC/TXtzGFeLt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udn5zW+hopMFqeWVnjCCUhX+SaZX3h3OYjDecTqyWpM=;
 b=fjWfrbm01KWviYAeAjGWRIVHCOCW1qbw6lFHpyghIaQ0RG9kcOuKby9Lf63ScInbGFe3RCnGZs6NLU6of1SFNUt3pzwAkg3ZmzAharnfotUMrNI4JgZYkviEig0ztVdFiugmjFRur1yGPgPz3soUAEprxooVrQixCkn4McDbOXJsnS9zQFVBSbqISRD8sCxJQnZ2lDUek+VZHRlScYAYD2631HMLRmKGwe0hMQL5+GSkBL8jusqKpZLaa6zqKvJ4UhgELMh+rYDH2sywuBHg5YpERkYEIWr1/TFVtdDvjB/wr8qcy4+erYnhCstKaEWrMhm2MWc9aXffuT9cug6AWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Udn5zW+hopMFqeWVnjCCUhX+SaZX3h3OYjDecTqyWpM=;
 b=KQ7nD3M6Zp8sZ3Ne7fsdiz3pRzp8npGNpUynh0CEA2WAtNrNIDcJStK1SArnOkW8eqoQzwTA8y/mqKQa590kuE54uktP/v5WqxZyzxGTzartZfha4CT7lDvC3Q5SCFbdsHl0hkn70Faze0elssTWVATaNQJVhygL+55oHl/AGOs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3565.namprd04.prod.outlook.com
 (2603:10b6:803:47::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Fri, 8 May
 2020 12:09:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 12:09:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 02/19] btrfs: drop eb parameter from set/get token helpers
Thread-Topic: [PATCH 02/19] btrfs: drop eb parameter from set/get token
 helpers
Thread-Index: AQHWJKz0ZuoijrluZEi3YBtV6S+Efg==
Date:   Fri, 8 May 2020 12:09:15 +0000
Message-ID: <SN4PR0401MB3598EFE7FF6F223E36404FA19BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <b8b135176911726d988ea5f686b93fbd351e47e2.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [46.244.194.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6a7181e4-7f70-47ac-4713-08d7f348a091
x-ms-traffictypediagnostic: SN4PR0401MB3565:
x-microsoft-antispam-prvs: <SN4PR0401MB35657D7D9AF61C8E5DCFF1119BA20@SN4PR0401MB3565.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hlbd0izb5etDdf8rwW9igtEHMjMnmvR9opo6qXNYJWNynylsfvmYpuhB7ix+jaOGPfRbMJPd4j8P/2ne990ydnkHaSPBIrA02Bsv/J6yDlLWyz7lv/VmbL33lH7QBQD+8vKN8PLbv2ICmmXJLZc6m9wcX05n0u1YRoFVIOukMJ0uLSU3Y2iFnzlFqI2LfWTjUtn3ISn2wU7vFcqKM3n9+AhQbKTvK9rTHYbptLHxCxRUluOueWJPWosetlPH3XM7ORaGuRJCpco1bM8C4eOLeQazBsGVL+EKq6xdJx+PxzI7w5aVJNvoxSEQzA0QO5hEUMYGNHeDfb2by2sg73ZNZqPTJ+yXXiK21LIsvNLQipo5Przr2MvctJm9V5oegWVK10UO/NrRZWkOa0kDCetzReWMqBC78dY1zZNWhLNaICWoqe09yoN82eBg29UDzk9R5q7LzB1/4ClEREN5U2DmFweVtaGUyD5Gk6nSB7qsD9A39Q97bdBSm7ZBIFhbB7Ty07ZztcZLTzHJiusKUrejwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(33430700001)(558084003)(91956017)(2906002)(110136005)(316002)(66556008)(66476007)(76116006)(83300400001)(66446008)(64756008)(33440700001)(83290400001)(8936002)(83280400001)(66946007)(83310400001)(83320400001)(52536014)(7696005)(86362001)(9686003)(71200400001)(8676002)(26005)(478600001)(6506007)(5660300002)(55016002)(53546011)(186003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: h0KG9S8LE9LpgE4zXBx5Gp6QUd2vu2Kjjcq8OlSer8/CT0FooMj7/tmuLDnJdHLNn2JLOVZnCLhPLa0XAJMg0BKoZtZs2lAsATsppR3srFYQP9D2bcdZRvE97A4coIgIl28YNVohjm+reKQfZtcUNBnsztXBNZjjfwAONdThz4PYM4t6a40QsQ3Bu5Q26eZ84mjTNXCiyGVI6q4L2GOgw3rw4FbEsLVD8mLk4vrgDk5bYq2gx5/Mporiwd8QPfl4wXVepTtRtAg6IiVU9YzYdHN6YAu7zBFYx3dkHzKsuh95d+f6Jct76W6Py53txmiLxQZqlBwqCW+Wj1s0bFDpJ22cUJ+74MckReVIQGMnTtEsBvGZ6kM1/6fCSy0JrEUVebBkzLmOCGnyIMUukS08xzVDjoNUmgfgkTBYaw2Ir26zO0HkE34bLTZrDWGBwb4UF86RiJa3hHO+p9HhIPhGV655LZBysoAtYF5emVZN0dk=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a7181e4-7f70-47ac-4713-08d7f348a091
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 12:09:15.2285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BAooYwC0DkAwD1tD9ePmBtGktQdjXdt/h2bN0XWjUp04to0sj0z7+XsasoCBnwUiIWkEZ3U9UYpIp3l4VLLai5W95IYy7Z/J54pl8VlQY18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3565
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/05/2020 22:20, David Sterba wrote:=0A=
> +		push_space =3D push_space - btrfs_token_item_size(&token, item);=0A=
=0A=
Nit: push_space -=3D btrfs_token_item_size(&token, item);=0A=
=0A=
Anayways,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
