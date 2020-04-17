Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA61AE41C
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 19:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgDQRyA (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 13:54:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:4221 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729980AbgDQRx7 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 13:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587146040; x=1618682040;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KG5jQxpJKmqkTW6v2K6emN/tSGGrkWOD2U4Kni1yEDE=;
  b=OC3OO85fgRY+phiqMsegZJBM3lJrGxpu5UY6tvexP1Kvzx9/o6NrgaSz
   QVFPqahcoqX72Pjd/sb/4MnDAlDvVQEbgRtmBPGxk+G9HlYs0RWl7aBDc
   qr+rm3G4fmudhw3DGmEqpu/zHqZV6wKhaeFuSKYa/y9Skwv+S8VyzsPf7
   V4fcu7vvYSGtPuLFLmGErb+WwUqvN614PL+2e/F5QLVh9fkmlz9xn7YzY
   KH354XLKLGfydnpJZW17GjN5MZC/r1AfwNgF8xVStwsnBkOGZsGmdlXA5
   dKk5QhfkiA4u0ZkLr3nixRIUaNWej7Ik5APBLPh4Gtc9mFiDsP/Ts+O2h
   w==;
IronPort-SDR: 2pawHo2x85U6F00sSzZpdzrvWPgrzyMZx96L3xcAWkHwFlOXmSQa10+QdEFcJZglEZhZGhUzxi
 o/DRBVMAegmpzhsETrx+2M49ozsYlmplJWWWbHDThVml8eAui2Y8eOCKstBNXYdsYZk8FfFC5D
 1bWeZsYFam7ssO05barzXsl8id7bL7uiNrstEkNjxqJLJBHRgyfAaxoAy9snhc03LwKV/FL6x5
 bnAaEq7PbS/8rUHSTTe0UEpfDfpmpYZJV3yfbt1sEYyy3VMOKPZfX2AeAvnyL0Ih/oCHltZMpS
 DHk=
X-IronPort-AV: E=Sophos;i="5.72,395,1580745600"; 
   d="scan'208";a="139921933"
Received: from mail-sn1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.54])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2020 01:53:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLnjLjF5AErvZIPzxwWD9tPtqibpB6CFxlhCCfI1qViX0Lw1mA5qjM+rQ3dLnqphygWQdXwLxZrtOb+QyE02e6Hlh2B7IQ+Y0fzGc1+c8vFcMStrZtSv0uvt7fK3naJ9ZHVSLJCiiOj9vwh7B9t/FlPaXIFpUni6htPTbmUxUTqtXRWTVXnxQMDVFDITl4l1sfsFIaHyLgoFB1v1p0JHX7Ou5o15kiE4fXB+CAR79VCYpIYlRKJwYWcRF94UXxNkq/RMPxdrKjrPjdZtP8n4+725gi7n0nk1f9+Mm5Np4Wh8L/nKEsS1A3QZx1jsrCjAUyVI6vQO4oF9vGhhGUMdRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUTY55nOaxelPlj6i4l/S6NL6qSyt9P8jszbuFsBUwo=;
 b=WjJe7IKOYMqWxTfDBss7+V3DGWGVzynrLt0rJ2bVAdB9cWCWdSx35Aw6kGTN9PtzT1Dtdnwju6ArgApjHsyGs59y0bMEMyKcWwoi5HRUoSZisWKeT3Py307DhFEKWFWGHw5ZYaT/Yt+aWH8iErdhJv7ddnVmU0xtTKFlFZ20U1z5In2XmURafFf5T2TO3e0rTWQh7ivNqHuCxcVLyZJqgEk4Z5FoAMQaDjeu6KC6aMlPuTIx8GaI5YON/A0flb3D66LTutWYakorqqIcLknBnclhLT5Nc6KZ/8M6noM/xpB2RnLD3UHXn6zDLyDGgmvCutK1AqKJsAbwRHUHYsWi0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUTY55nOaxelPlj6i4l/S6NL6qSyt9P8jszbuFsBUwo=;
 b=Wlf+l6OyQ4YPlDPEWcNRSMpzJBMwBO7egBOb2/JeGToAifGIjoi6qhQ+6KkBqyN8CiqwSHaR/EDDL4utRxG6Sq/6z3RkCFcbp3e0Ip2gH5Yui1Y1LHGn7Zqvm691B9T8X2LYcEFP6KwenVYTlH44FsIPvQigQ4VZIjIqbC4cuAM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3615.namprd04.prod.outlook.com
 (2603:10b6:803:47::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Fri, 17 Apr
 2020 17:53:49 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 17:53:49 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Omar Sandoval <osandov@osandov.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "kernel-team@fb.com" <kernel-team@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/15] btrfs: fix double __endio_write_update_ordered
 in direct I/O
Thread-Topic: [PATCH v2 03/15] btrfs: fix double __endio_write_update_ordered
 in direct I/O
Thread-Index: AQHWFDipOpg4ruoA906IRWAikSQDzA==
Date:   Fri, 17 Apr 2020 17:53:49 +0000
Message-ID: <SN4PR0401MB3598FE83B98A4D727852D6179BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1587072977.git.osandov@fb.com>
 <594c8cb6dd64cebdf5e01016ce823e1be00fc7ab.1587072977.git.osandov@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8ada4b57-ee8d-4c9f-19d5-08d7e2f84895
x-ms-traffictypediagnostic: SN4PR0401MB3615:
x-microsoft-antispam-prvs: <SN4PR0401MB36152C3005A29BF66F4B9DBD9BD90@SN4PR0401MB3615.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(9686003)(5660300002)(186003)(4744005)(4326008)(33656002)(8936002)(53546011)(66946007)(478600001)(2906002)(71200400001)(7696005)(81156014)(316002)(6506007)(76116006)(66476007)(26005)(91956017)(66446008)(64756008)(55016002)(110136005)(54906003)(86362001)(8676002)(66556008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pLl1yTMBV7FkV7UCKx0L8UxcXfc8afRlzC8kkYrHWGDwdO5u4Ns2STM7D+nCifPzxDBwdNkblHfjjaeg8E9ijqb9IKAAsjhxj0Rn9qXBQvuSK+x4rpuFHz+W90rksUtmRgipZ68o9v8qgU0/dYu+yA0Z0KvNgRhr4U8R2AC6HajTNa6G24uVKQfp4LAv51oqG/x+bGosD5PFlGeD6M8TkndJIIuH/KjRfE9W8Zd1epPsc1hNawvgeEfp8ZaEa/LM+I1xlkNWVXTiqdtP02mQCxFinhfzKeYUqNiKP40gda1JUEALI9mqRs/2rKYykymCjNwX6R2l9yZOIOZ+aQWwYbGVjBw3DNeOCasMwCtqOiLqui+GC3K0fLcbOiPqRRNmNcTZGDUZ68bXDN4T9C3uGXE5Y849zSSWuCNEvVzm/Td3xpuQo2HrLQHMAXt3P4X8
x-ms-exchange-antispam-messagedata: 1w1nP+1JW3Ms5De3d3+zV+dRTJg7U2Y04P0xAAtaSmAYYlnYQ9w3l4q5Esp2qbqDOqgOqOjkBShZcXfv4S3ij6uQWt08V9xK/CdbY9IQ8lgnO0WsBaDcAKi5jaAMUXUNdRi3a3NMaxeTBmQU9IliXQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ada4b57-ee8d-4c9f-19d5-08d7e2f84895
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 17:53:49.2848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: waF8PGEj+zgpak14SoWmbGzdIzQnkHeeODN5TAUjJ5Lbtz5PmaamHT3oma0fUK2G3fjt7B3WrKtRUEOYqGiJWBIU5O8zd21fYxcMT1HQxvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3615
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/04/2020 23:47, Omar Sandoval wrote:=0A=
[...]=0A=
> +static struct btrfs_dio_private *btrfs_create_dio_private(struct bio *di=
o_bio,=0A=
> +							  struct inode *inode,=0A=
> +							  loff_t file_offset)=0A=
>   {=0A=
> -	struct inode *inode =3D dip->inode;=0A=
> +	const bool write =3D (bio_op(dio_bio) =3D=3D REQ_OP_WRITE);=0A=
=0A=
Nit: I think the braces aren't needed here.=0A=
=0A=
[...]=0A=
=0A=
> +static void btrfs_submit_direct(struct bio *dio_bio, struct inode *inode=
,=0A=
> +				loff_t file_offset)=0A=
> +{=0A=
> +	const bool write =3D (bio_op(dio_bio) =3D=3D REQ_OP_WRITE);=0A=
=0A=
Same here=0A=
=0A=
Anyways:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
