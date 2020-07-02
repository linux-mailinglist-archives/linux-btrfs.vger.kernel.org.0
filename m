Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA49212628
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729518AbgGBOXW (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 10:23:22 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11228 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729796AbgGBOXK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 10:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593699790; x=1625235790;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PT0ly21Odrtcw2zJiDGy3Vx4Mf3C8mu7NiJZ979Shhg=;
  b=Gdlf2OM8/P+LZVAxoW7iRWviBCXR2IbO4U8LQOAvjB7OKa4U4GZTCu1A
   35bADqT8AQGP4wG9749GCjFXHIzSlUtYT7Or+Zmy4/TQYvYx0vihPctvZ
   YiU3/W6rpYOP7oGaBzM1LSgjqp2mprYAB/7WFLJn+g8q3lp9eLpTSCouF
   e+OPrSFLzw8KYIazWZ41M9GH6unIFZDf8Z+pT/fnBUMzf95eL7N5jxSf6
   6qWmsohrxOQO1FcBOM/LQxHJrFUq2gbf8r9n4PmDPGzo0n0X5zAI8Ky8W
   h6Z+9710+rbG1j7cYhJTNXvbKtetGEP78QrREqz9z4kl+n+m4ItilOT9l
   g==;
IronPort-SDR: P6uC1ZLofnmNJ1YF8LN5/ntaR2IOTxtF7HSKwGfLAUlya2KZ23vzVFLebLEV5z7brgYYY0XBHq
 jGvYUe9AKTHyGdBeCMGmyAb/nKqwSPQe9bdmzYhk9u3K4YR9bN2ESAqV0sRTqhcGXRnm7QDGvW
 qx6eKjg6NfdOaXynleBvvqiCg2KmysVqcUiiuswQAP2YMk2WEyoZ+b+7fmlMpDiUxHTUEmI3aq
 9QRgzQuyTJLwh4NJuPJGtz+UfTg1nzyw+e09IcZlqkeQjoot+gs+YZ468GqculDZOYvhCCN00T
 Wc0=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="142833352"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 22:23:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F250mPvBQybiiPkSLPBEoP7AKnCrE5T/q6NpUbWrZ4hil2pLETfkq7+BFw51brtgP8w6NPv91AuKd5Ch0oa3NcfrQ6W57IcPJKrq4GgjkFosdEXARQ+KhzZFjMjWcjTa8/Z+/E+BzA3Xj7OeZmDx484RQyRBJxqPXYMZb/8TVvIOEunESclTEz7IEcJ1qsBNC6Cnh6Pfsuk+I/cxQJ1IgdP3R5rh3PGl3/NRxpodiIUbuzqoH6t3MkkoiXtwwsfLzjlWecfkvuIMy+HvAu4FpcbhX/xcx/dSGH/YpkPB1Nr6HI1gleZh2Z5MlOHqBYpdnJCM7L+YmO3u6IlPr/IImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXfLQq1H3nOAITdB2WRQmLrBi0QR5RRY7a9SRPDnIEA=;
 b=Te/Qd8ythHRk5YyMq7BJjiivIAyEGfz/w6Ku3jTDDTSaDNza0YcJ95zTpsMmLGkWSHNJuyH1AamYJYwSNCPkN53CHwjDMIKSdga5yUWdiY7P9EbHps7p++N/WyuCgfvMq63zCDDevIxkzxSc2QckC6CdDQvhh/lEdmpiETySQ2N7mYy+Xw2dH7rlxvr4XFykiWFT2hYl/+aGS6B9dchP1M+YGnIAPBkJRWrbS0pYKapjL/wiJF8Ne5JHrIWC28oY4U0+mWqzR5VUUjiK0UWnft2wWDT3hYBjIB59z5Le+0O4I+WF6ZONtfQ5TpGk6CEThu1pLK3IUpq7kD5kCD/vVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXfLQq1H3nOAITdB2WRQmLrBi0QR5RRY7a9SRPDnIEA=;
 b=HuzUT5gSS6Ykpco+p6avisAmrMskQdk//eXNZ8+6e8ZJoH+TKCJM5edbs3hArYUqImW229UDdwQOmeRgnIwCWzWN69pton2gz90JEVG8SF1IIXHg0zh4LREp/he+GOtoOP+8I3yA4sNY9z6w1KBK6t+/9FhKl8LhpxspVlq7s3s=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 14:23:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 14:23:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/10] btrfs: Remove out label in
 btrfs_submit_compressed_read
Thread-Topic: [PATCH 10/10] btrfs: Remove out label in
 btrfs_submit_compressed_read
Thread-Index: AQHWUHdFtyzfTijPY0a3+MRFc7ifQg==
Date:   Thu, 2 Jul 2020 14:23:07 +0000
Message-ID: <SN4PR0401MB35984D9F9F6F8550D6FB01DA9B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702134650.16550-1-nborisov@suse.com>
 <20200702134650.16550-11-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b581166e-e354-4bbc-442c-08d81e9370c2
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-microsoft-antispam-prvs: <SN4PR0401MB35971F335B881E23C920ED2F9B6D0@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q4QE3p7woN3guHv7j30YtomcJPJa5tE/QsuLS5Iqve/mSOu11SzaqAN8oISpS8pBNj+pEn2Mt8wzbNYEQvQykGpvrq/qpcDEISqUt0rf+lQuTI5Ym+JQILPPiSvG8UQAnuWBY8MpIiD28EwYrByj+nDId+9DQ4Pb9mCwf/Su+dmc56D9o8UIXXMj/XLrt8lgzpqV3cR5bqzvMEca8GPZljb8qsemTuJJlubepsNf7t0RqcKy6Mci3nE3XQmLWDoJZ8t6mr90dxjsnHHtGBJSJ9KyuyDtXaQ9vLF5p+45Q770uhBirRvxlK9VUV1LsWW2CtY3V9ZntG0tTwRnxAo4nA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(76116006)(91956017)(55016002)(316002)(33656002)(7696005)(8936002)(478600001)(64756008)(66556008)(66476007)(66446008)(186003)(86362001)(6506007)(5660300002)(52536014)(9686003)(71200400001)(53546011)(8676002)(110136005)(4744005)(83380400001)(2906002)(66946007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: qjJnqkxHTU/FQRG6KC9sVzNhtoNV+XyISUi9JC+dlpmztO9YUdm1/YqYrpR9s0z28IHuUmzf4sTZsMZIyQ8HFhbjwuvpZ/yTmmWkST57tMZM8hkm31FaXzwuCygXsk7JQGrpUZxPi1nT4MYT1JAKMq/LSUFurzlOzatdFgjfZ4h2Aq6TQ+8ClTqIpDyCHoOiBa++0aBGK+9W0GTKpOiyC4LL7SaSjZCbDKa4kS/jtAiSHyQjcnsTB36HiTeK/RyxJyXo7lPxcpKT08LReHwzq+h5uMp/Rav/Js9g/XJHgjx5ZA7kDYxrEIjOxfuJiQQPqbNo8k+v9reokKQmU8K5v1gvwq+2ryagthwmqAEbuJ5LnXDkli2HSOAqhLFqBr33CqnHAb+kfyeVTF/m+7rhj6z/ibyEvxbu+EevSogh/waG6mweYULnQwRvx/kJkWfxHXTqxXiQFeUA+BluY6acQxN+A2OQP+JXv9RmO3nbzBpGBuqHgPaq+OIGl5QMYY/H
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b581166e-e354-4bbc-442c-08d81e9370c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 14:23:07.1691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KJ7lfX7bODbeHm1dgCd/zcJV2BXp9AjffOlGrNiBV5991LKbhKzVWaADQtBQ8H5j/9V4LnI3vE2KIx1dgFUvfmmefjOcOWO8lr6h+IsXZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/07/2020 15:47, Nikolay Borisov wrote:=0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
> ---=0A=
>  fs/btrfs/compression.c | 10 ++++------=0A=
>  1 file changed, 4 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c=0A=
> index c28ee9fcd15d..f9a9ec51a1ec 100644=0A=
> --- a/fs/btrfs/compression.c=0A=
> +++ b/fs/btrfs/compression.c=0A=
> @@ -678,8 +678,10 @@ blk_status_t btrfs_submit_compressed_read(struct ino=
de *inode, struct bio *bio,=0A=
>  =0A=
>  	compressed_len =3D em->block_len;=0A=
>  	cb =3D kmalloc(compressed_bio_size(fs_info, compressed_len), GFP_NOFS);=
=0A=
> -	if (!cb)=0A=
> -		goto out;=0A=
> +	if (!cb) {=0A=
> +		free_extent_map(em);=0A=
> +		return BLK_STS_RESOURCE;=0A=
> +	}=0A=
=0A=
=0A=
Agree with David here, please don't do cleanups here, keep it at the out la=
bel=0A=
