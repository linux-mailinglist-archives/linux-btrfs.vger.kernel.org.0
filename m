Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D755F21D1D9
	for <lists+linux-btrfs@lfdr.de>; Mon, 13 Jul 2020 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgGMIgF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 13 Jul 2020 04:36:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53664 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgGMIgF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 13 Jul 2020 04:36:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594629364; x=1626165364;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=U7Tu0k/zR4tlb17sLIre+4zztZAn/oINRPg5OopNEOo=;
  b=OmE/s1k7IFU2odv/ZUC7Ypr7rVv36VSrVMu48UqQD+WGTsJqtyAx5mhF
   oV0LzG0KwyKqdx9LIq/iNyFuHZZLgQiRuTvUuDLbRybVFG+5gX+BksVeO
   7X0xe1EwNz/HAyY7XKWi6n4elEDLHQdFOaoFCSl7ba1sxyX6PTK1LEdxw
   7Vwpxy9AZkhl4nB2UOtXEi6XxarcgNEzf1O5r77kGyZIixsnRzbYLvoyP
   BMrLVmMulawG72OJsr3z+/8sSacNCI2QmPP9sfVT/X9QC6JWg3opHRQeb
   q4LPSgfA/PuCiJA6aporX08jwfyoND/wQ/obulPkfYspj1EL0xtnuiYvr
   w==;
IronPort-SDR: SHN5wDfHtQ8jz84lLOkCFSUWVh7NzkDIG1HoARr2bQK3YBiA3te4SEOK1aWfzkwmgUNOOX111e
 YkL785R+3TSIFz82aVncfgsayZI6hZSEIMC5uL2oH6oRgSISoonZbP8o3KsyOeEgHEAldUdxyd
 chGIw9+/z1qCe4pr+o+fz5XslUwwCImh2eijW9YwNy6u5fY37BfS/xxj9XXbyJzWpnFJy0jhdn
 9nfNMsplyivGWJUged+B4VwymSG8wD2DUcyFWFWfoSdsA3rHkirRvLdw4mRsmCLlP5KR7PnzpI
 2eI=
X-IronPort-AV: E=Sophos;i="5.75,346,1589212800"; 
   d="scan'208";a="251557835"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jul 2020 16:35:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yec9RcZCyEsS48lATWhLVMY+0HzLPMijwsnNJTB2s9y8cJLUIo1YcCR4TvtPDK5rbnrEaT3Y8TeBN2+26l986+iOMYCVeGqNZhxSapu+WuxGOoWdEwPqAr40YEt95r3zS6rnIew3yLqoKo6mjm2MdSRQVZjHnI+TZNpA0M/Lfp8s1jajAVeTK75QMflAm0OROf3k5zdwmG3lLvVUi6RZDIO8IJ0aq/kBeVvrgYvF8O/emUxKYO3buPYSqwtJIMMaXo7lYj0CBp+szWNxe2T9Ay0oSRY98k5CBvwIlq8+xHPIZgEpNft2uJxIUFin5Agyc/5qX+HGOTnlQ6zMtYeExg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHIjp/UTqJ7mwAV/fCXbcyk1ELVewb12btLnRhKMa3U=;
 b=EIPXR+RSLmOOCBlT7GrVQipuC3yZI2GrqHz7KN/IZRSkxGfk+dlNOO6HTxMNKxcc3kFDxsy1ZlI59Fb35pEpSrX6/364b6VI4wDE20UMX2qGylMgcfsxsnUKRqBjohxCvU7z3QAGmH46XcGvfFhszGWm8hfCoBhS8PCfqg3MmZKU/khgjGwICb3RebouLG1/Hphw5wFhoq80/JJ0M5f25+5AqCNFnZp2lzJmJkildqvkgIW+gQhaHz/V47QFE2RMtnqcSMyjT8rWItm5HOIZ13Gqb8szK2AR0IFn8wP58hgPbrzZprJoei0SdjtwMQdEUh70SO+sNXzTzmG4iepyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHIjp/UTqJ7mwAV/fCXbcyk1ELVewb12btLnRhKMa3U=;
 b=vXzOsKBTO1bfb+GfDwSaCOpTlc7KEn06gyEc3k6QnYe8Dc1dNWtRK41phJQbIXoOWrCXtYhKh6j8zIKz2DUJVgnwjKEflbMnOn/9HHwFlqOnyYMTUI+Fs31oZ5GQXXt3WgXjuBAeTvq7hmOIgS669ZZajegZNDWd7xetp3cKG+0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4607.namprd04.prod.outlook.com
 (2603:10b6:805:a9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Mon, 13 Jul
 2020 08:35:47 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3174.024; Mon, 13 Jul 2020
 08:35:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.cz>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: add filesystem generation to fsinfo ioctl
Thread-Topic: [PATCH 1/3] btrfs: add filesystem generation to fsinfo ioctl
Thread-Index: AQHWVsMoDlwog9NMkE6lIoGR4dEhPA==
Date:   Mon, 13 Jul 2020 08:35:47 +0000
Message-ID: <SN4PR0401MB35980E2787D94E9E82A52EC49B600@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200710140511.30343-1-johannes.thumshirn@wdc.com>
 <20200710140511.30343-2-johannes.thumshirn@wdc.com>
 <3f60141d-027a-c9e2-aa69-680668edcebc@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:3d54:75d5:bb74:f595]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 65e083c2-b5cc-4090-48e2-08d82707bda6
x-ms-traffictypediagnostic: SN6PR04MB4607:
x-microsoft-antispam-prvs: <SN6PR04MB4607602D38C9617C5D56EF899B600@SN6PR04MB4607.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dat3A2vLR+lnkmCGiB0hEJlDDHZgmyX6NHO3RwXWiXuqec1lbJgzGCuy1Pm3Rorr9D8fd2bnAxvKDZlODJJx7gTXsS0fGfRmR/Ub5rlOAXNwGzXToXQ6uvvT4hkMYochfbPEloU4R49oUCXlZ1cLiTwNhHzi35+UlcueeSuauIJXJJFn94kd5IsmLoEzNPHGVbUmF1C3lVIbT+eZJ8mvaKGjhIBtVB4uHaZv89xQ/kqxWrdwXP7rHNkqpcoWKmn2vYm5UaNqIx0NGJdeKFPXzkCKRpPr8TRo91gWsh5ZAA+MbTXl3JflPBXRyKFrL0duIXz9GgX7GDLPWxiyYeEn7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(8676002)(76116006)(66476007)(66946007)(86362001)(9686003)(71200400001)(4326008)(66556008)(91956017)(66446008)(64756008)(186003)(5660300002)(53546011)(478600001)(8936002)(52536014)(55016002)(6506007)(7696005)(316002)(558084003)(33656002)(110136005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: K7zzqGmmGtkFP5DnxtyGbEb+r8ExpmzGSwXagtIkcpCuVx23IMWkxH86BmBIpfoikXEhkCDGKU4RKLz2LYjzqimoOCfP8NfKOneA48soxTQK1HrnX+HPG2botSKX4Z45IQ4uIPhTI6cOT0E+6qz4hQUJA8ieF0DBCrlZVNEVPJcS3A8ZwtrQBJdY/5LcT6LdZTsEjpoVQmdnrZSaDUrWqWSEV4bDvOykCNF9NrC7p1gD/H/V0B/M1RmUOSyp122fWDebby1FKPccapD6W24cmxsbaKu2XlGcJ/2drebtHGKSYwRL0RqYRvQDZajjPK84QF5kIU9yPhrdVli1wHRiPy+nLRmuRob2uMzU9BWqFKI9gbngFrWThzyr1pEt3GuxeVcPS3fXxbCwMlGDCmXkctYXix4eKdUQZYYitft6eH6nZMQLNiNBI0931y4ey69rRB3fh0FTW4mSsyEi2AtwaCOmbZvRbgS5GTeCsj8zfQbKorJlvthwmstA4tlLQ6xfzm9ZPNgOGn8ezaKCuZbT2ukVioE5YQNKPZkGH3O5u2wPyMwGQ2aE1S4GmaZhr4fv
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e083c2-b5cc-4090-48e2-08d82707bda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 08:35:47.1461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uA9CVQ7xvS/p0smgv/UBWbe2u8FtfwTKzkjO8uKmQittgXKCqm7KdYtCkto/zM5faK6/IhmC8qBr8HziW4ghi44w8Y3VBhypYX1HkKPhkzc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4607
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 10/07/2020 16:32, Anand Jain wrote:=0A=
> On 10/7/20 10:05 pm, Johannes Thumshirn wrote:=0A=
>> +	__u32 generation;			/* out */=0A=
> =0A=
> Generation is defined as u64 in fs_info.=0A=
> =0A=
> struct btrfs_fs_info {=0A=
> =0A=
>          u64 generation;=0A=
=0A=
*doh*=0A=
=0A=
Thanks for spotting=0A=
