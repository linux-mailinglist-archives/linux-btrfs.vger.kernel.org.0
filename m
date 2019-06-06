Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9683936EF6
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Jun 2019 10:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbfFFInj (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Jun 2019 04:43:39 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:25143 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbfFFInj (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Jun 2019 04:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559810619; x=1591346619;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8Y3HhYKu9y+bwOGquxMBJqsEEZYPKqeXvFbLNLVecIc=;
  b=BVPqT/YBAlP6CYIDBUSYTH9FmhYOP59+g0ZWZtxv2pw8St4kguZ8qJBz
   t02mlJt6NxCt6uS8i+hB00cYr9RSJPChyoERGZsQDldzjv1/98pRBvZoB
   ySz/unBEOvaQjnnbV9WXZ2vQMJEbxeq8MbrYQDkBcS5OXvuO/J1SRf9bS
   +TsErQsTk1XyPPYtIXyUrIYkAC3C+o8Q5qZ+oEL2Xw/suY076ujKNmFHD
   ChVYsu6G2mK9BbaCJRY8tOPxcyYxN9X3ezBGPBCV7szmx6DXrt+rb0IYv
   /KrfYkqSqvGJNtaFzRiEZGrt4odBpUL/Qjd4yHbaVoYcr8/uGtdP+2KRm
   w==;
X-IronPort-AV: E=Sophos;i="5.63,558,1557158400"; 
   d="scan'208";a="109926546"
Received: from mail-cys01nam02lp2057.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.57])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jun 2019 16:43:37 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6puzGhIjVvy7q21Qurs3VoWhMWKTVTyYQoJ4fEBHCU=;
 b=pMv8hc4r54tJnrlHbVXfCcTdQGAlcLQNZSyQTwJTk08DVxFQ7mi8jyVRv65JsYtBN3Mu96iTCOc/5A8V51xc2/WrNNFiKddjBrn7WBV//DVTPUBTtF1iwoSK0+JBhaAoktnSKiNgmICOOYSQfOS1+qXkKwNrlQf3bMfPPwZE0D4=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB4703.namprd04.prod.outlook.com (52.135.122.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 08:43:34 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::903a:ddca:14af:4b90]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::903a:ddca:14af:4b90%7]) with mapi id 15.20.1943.023; Thu, 6 Jun 2019
 08:43:34 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Johannes Thumshirn <jthumshirn@suse.de>,
        David Sterba <dsterba@suse.com>
CC:     Nikolay Borisov <nborisov@suse.com>,
        Linux BTRFS Mailinglist <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: correctly validate compression type
Thread-Topic: [PATCH] btrfs: correctly validate compression type
Thread-Index: AQHVHD4E4zyPqs9MJk+asqdKL3A0Mw==
Date:   Thu, 6 Jun 2019 08:43:34 +0000
Message-ID: <SN6PR04MB5231CD8957F12BBEA8093A828C170@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190606080106.10640-1-jthumshirn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d850bdcb-7750-4195-8f80-08d6ea5b0fe9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4703;
x-ms-traffictypediagnostic: SN6PR04MB4703:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB47038DD4ED1EAE3A8C252F708C170@SN6PR04MB4703.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(136003)(346002)(376002)(366004)(199004)(189003)(256004)(86362001)(102836004)(6246003)(54906003)(53936002)(186003)(26005)(8676002)(7696005)(8936002)(81166006)(55016002)(316002)(6506007)(53546011)(52536014)(5660300002)(76176011)(68736007)(81156014)(99286004)(71200400001)(14444005)(66066001)(4326008)(229853002)(7736002)(64756008)(25786009)(66476007)(66946007)(72206003)(66446008)(305945005)(446003)(486006)(2906002)(6436002)(73956011)(76116006)(71190400001)(33656002)(91956017)(3846002)(476003)(110136005)(14454004)(478600001)(74316002)(66556008)(6116002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4703;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /885S+E9EBP1DlVkvmUeegvqsWnfv4lC7THGo90xe2Hsil1xuTKTqiRAo52tqQUnv6h1LRMo2tYeJHPzZS1foACG/2Li3GPzca57/PwzqutaoFFXNADvEykp/Xjk/QKilDHTlT0a6bNSi2jutUfwIMycEmhdJKfaP5AMNeP1QmCJS50xaTbZut7AO0Bs9MTGSKr1cbb5dwoPc6IAZ9l4BWiaMTDBI+EgN7apKa3waTPba8n5surkCYemrtuX+RSVivZqe4E/Dq52+dhiiLUsVeY3VsOljyRlrsFKWOJD3TpJr6apLoCGTmbhqDg6LLIlZKr0Tnv4vCRmrhRkkdsRxuCvNJJ/XnC2sDsTRln4SraoUDNb4oVCbIBDL0/tA2joG/0FKJ/28r7k+ve8TIVKSByahY/ukfPMqVDNwEzVrOc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d850bdcb-7750-4195-8f80-08d6ea5b0fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 08:43:34.8093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4703
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2019/06/06 17:01, Johannes Thumshirn wrote:=0A=
> Nikolay reported the following KASAN splat when running btrfs/048:=0A=
> =0A=
(snip)=0A=
> =0A=
> This is caused by supplying a too short compression value ('lz') in the=
=0A=
> test-case and comparing it to 'lzo' with strncmp() and a length of 3.=0A=
> strncmp() read past the 'lz' when looking for the 'o' and thus caused an=
=0A=
> out-of-bounds read.=0A=
> =0A=
> Introduce a new check 'btrfs_compress_is_valid_type()' which not only=0A=
> checks the user-supplied value against known compression types, but also=
=0A=
> employs checks for too short values.=0A=
> =0A=
> Fixes: 272e5326c783 ("btrfs: prop: fix vanished compression property afte=
r failed set")=0A=
> Reported-by: Nikolay Borisov <nborisov@suse.com>=0A=
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>=0A=
> ---=0A=
>   fs/btrfs/compression.c | 16 ++++++++++++++++=0A=
>   fs/btrfs/compression.h |  1 +=0A=
>   fs/btrfs/props.c       |  6 +-----=0A=
>   3 files changed, 18 insertions(+), 5 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c=0A=
> index 66e21a4e9ea2..d21ae92c172c 100644=0A=
> --- a/fs/btrfs/compression.c=0A=
> +++ b/fs/btrfs/compression.c=0A=
> @@ -43,6 +43,22 @@ const char* btrfs_compress_type2str(enum btrfs_compres=
sion_type type)=0A=
>   	return NULL;=0A=
>   }=0A=
>   =0A=
> +bool btrfs_compress_is_valid_type(const char *str, size_t len)=0A=
> +{=0A=
> +	int i;=0A=
> +=0A=
> +	for (i =3D 1; i < ARRAY_SIZE(btrfs_compress_types); i++) {=0A=
> +		size_t comp_len =3D strlen(btrfs_compress_types[i]);=0A=
> +=0A=
> +		if (comp_len !=3D len)=0A=
=0A=
Should this be "if (comp_len > len)"?=0A=
=0A=
a7164fa4e055 ("btrfs: prepare for extensions in compression options") =0A=
allowed compression property to have compression options. If we have the =
=0A=
options, we will have "len" larger than "comp_len".=0A=
=0A=
> +			continue;=0A=
> +=0A=
> +		if (!strncmp(btrfs_compress_types[i], str, comp_len))=0A=
> +			return true;=0A=
> +	}=0A=
> +	return false;=0A=
> +}=0A=
> +=0A=
>   static int btrfs_decompress_bio(struct compressed_bio *cb);=0A=
>   =0A=
>   static inline int compressed_bio_size(struct btrfs_fs_info *fs_info,=0A=
> diff --git a/fs/btrfs/compression.h b/fs/btrfs/compression.h=0A=
> index 191e5f4e3523..2035b8eb1290 100644=0A=
> --- a/fs/btrfs/compression.h=0A=
> +++ b/fs/btrfs/compression.h=0A=
> @@ -173,6 +173,7 @@ extern const struct btrfs_compress_op btrfs_lzo_compr=
ess;=0A=
>   extern const struct btrfs_compress_op btrfs_zstd_compress;=0A=
>   =0A=
>   const char* btrfs_compress_type2str(enum btrfs_compression_type type);=
=0A=
> +bool btrfs_compress_is_valid_type(const char *str, size_t len);=0A=
>   =0A=
>   int btrfs_compress_heuristic(struct inode *inode, u64 start, u64 end);=
=0A=
>   =0A=
> diff --git a/fs/btrfs/props.c b/fs/btrfs/props.c=0A=
> index a9e2e66152ee..af109c0ba720 100644=0A=
> --- a/fs/btrfs/props.c=0A=
> +++ b/fs/btrfs/props.c=0A=
> @@ -257,11 +257,7 @@ static int prop_compression_validate(const char *val=
ue, size_t len)=0A=
>   	if (!value)=0A=
>   		return 0;=0A=
>   =0A=
> -	if (!strncmp("lzo", value, 3))=0A=
> -		return 0;=0A=
> -	else if (!strncmp("zlib", value, 4))=0A=
> -		return 0;=0A=
> -	else if (!strncmp("zstd", value, 4))=0A=
> +	if (btrfs_compress_is_valid_type(value, len))=0A=
>   		return 0;=0A=
>   =0A=
>   	return -EINVAL;=0A=
> =0A=
=0A=
