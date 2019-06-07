Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4824F383B1
	for <lists+linux-btrfs@lfdr.de>; Fri,  7 Jun 2019 07:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfFGFTF (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 7 Jun 2019 01:19:05 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51835 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfFGFTF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 7 Jun 2019 01:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1559884744; x=1591420744;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZcmQ4lYU+IePZlRCOFLhOCQJuMhLSHXnGrERvI/G/u0=;
  b=V/3ttI4ppfct2tao9qf8CDKWgH1s+t6WX3hDolZoGBEUU4xZxqbGgBze
   dNpKZHRhZabwaCgyIdirPyTFY7BABoK15LlzJbipxS1AqLxlo5sa/3n1u
   ut7ZiuzEMw5TAaf5S5er2jomdmy4fOeb3Il95Wtgts7/xFWdTw184LE1u
   wKZauWCJGC7JzW4QNrzheS04VrkMSNHCrwyXUutvE+w6xdqB0145CXuA+
   lLA5zZQz6UtRGiVINrK4rvck5bHHY5dOEm2MRr69eeD5OLLvCfIRAOAog
   7tJrqN98KTfCZdCy8xO2d/8cT49nAQjFYL/WCv0ialj0cRZfHHY0a5OBm
   w==;
X-IronPort-AV: E=Sophos;i="5.63,562,1557158400"; 
   d="scan'208";a="111670861"
Received: from mail-dm3nam05lp2057.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.57])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2019 13:19:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvETnZ7DyPkHXeI7Gd4pTs1g8goXTm0J5cdseEraD7c=;
 b=bV7VGXGZhBrlMhhtFV+a1LQFzUGLf6Wch0rtS/oA5/2xJBjFQPUBnF1FzV3KURrMoe354FpLsAJG/Js3WBhr4IvrD97XreyMxEug943BNMAWDDRMazL4N5REjskmSTA2zutrj61pHnnNb59+KNoDQg4pFpurRJ49bTlQ26RHRQM=
Received: from SN6PR04MB5231.namprd04.prod.outlook.com (20.177.254.85) by
 SN6PR04MB4784.namprd04.prod.outlook.com (52.135.122.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 05:19:02 +0000
Received: from SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::903a:ddca:14af:4b90]) by SN6PR04MB5231.namprd04.prod.outlook.com
 ([fe80::903a:ddca:14af:4b90%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 05:19:02 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "fdmanana@gmail.com" <fdmanana@gmail.com>
Subject: Re: [PATCH] fstests: btrfs/163: make readahead run on the seed device
Thread-Topic: [PATCH] fstests: btrfs/163: make readahead run on the seed
 device
Thread-Index: AQHVHNmMY0dME/wzbE+1/AFmm92NdQ==
Date:   Fri, 7 Jun 2019 05:19:02 +0000
Message-ID: <SN6PR04MB52314ED3404ED19E791954CD8C100@SN6PR04MB5231.namprd04.prod.outlook.com>
References: <20190607023422.28928-1-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Naohiro.Aota@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e934747-5091-4e00-45f8-08d6eb07a76e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4784;
x-ms-traffictypediagnostic: SN6PR04MB4784:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB4784877B7301430E98F761828C100@SN6PR04MB4784.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(396003)(39860400002)(366004)(189003)(199004)(33656002)(4326008)(25786009)(6246003)(229853002)(81166006)(86362001)(91956017)(305945005)(7736002)(76116006)(8936002)(81156014)(73956011)(66946007)(66476007)(66556008)(64756008)(66446008)(8676002)(68736007)(478600001)(14454004)(72206003)(66066001)(53546011)(102836004)(14444005)(486006)(9686003)(74316002)(2501003)(110136005)(476003)(71200400001)(2906002)(71190400001)(52536014)(53936002)(6436002)(6116002)(3846002)(186003)(446003)(26005)(5660300002)(316002)(76176011)(6506007)(99286004)(55016002)(7696005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4784;H:SN6PR04MB5231.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZkvurFjkQ6skCyiEBYzHrunsbp6x/NEycbDoKCKdCCpXkXU82cyZlInrBQSTXiqU+pc1dLEJakRAbujgb5Flbm00If9ixFtb2oWOCSwxFlNG2GSSkMF+R7ErlfM6kGCTuq8nVYlu70CoKkP76jEaMq/3/lM1fGJf2JFKCqjwE4ZDScIaci+/bYWTo8YF/Qyyk1rHPDc8+87rAU7IIX75B/Xzr1Bb2HXJECkvf+H9uPq/miGaCkl9PdSEt4rUrskvnH05Qkuud8qFJUB0BbyjeFdFhRBHbuYKADqEA+QqR6IiRZkHDIbLeNfx3iZg4C2EDNvkLzvuNP8BedBR0wWzF3im/ErI3i4rLx9shhI1nPnxg1bMFtjOjnhj1430oxiAmarNJ84W7/yFNh8l1rDfglptjTT32L2Dabnem10huHU=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e934747-5091-4e00-45f8-08d6eb07a76e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 05:19:02.5014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Naohiro.Aota1@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4784
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

I forgot to update the expected output. Ignore this.=0A=
=0A=
On 2019/06/07 11:34, Naohiro Aota wrote:=0A=
> There is a long lived bug that btrfs wait for readahead to finish=0A=
> indefinitely when readahead zone is inserted into seed devices.=0A=
> =0A=
> Current write size to the file "foobar" is too small to run readahead=0A=
> before the replacing on seed device. So, increase the write size to=0A=
> reproduce the issue.=0A=
> =0A=
> Following patch fixes it:=0A=
> =0A=
> 	"btrfs: start readahead also in seed devices"=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
>   tests/btrfs/163 | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/tests/btrfs/163 b/tests/btrfs/163=0A=
> index 8c93e83b970a..24c725afb6b9 100755=0A=
> --- a/tests/btrfs/163=0A=
> +++ b/tests/btrfs/163=0A=
> @@ -50,7 +50,7 @@ create_seed()=0A=
>   {=0A=
>   	_mkfs_dev $dev_seed=0A=
>   	run_check _mount $dev_seed $SCRATCH_MNT=0A=
> -	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 256K" $SCRATCH_MNT/foobar >\=0A=
> +	$XFS_IO_PROG -f -d -c "pwrite -S 0xab 0 4M" $SCRATCH_MNT/foobar >\=0A=
>   		/dev/null=0A=
>   	echo -- gloden --=0A=
>   	od -x $SCRATCH_MNT/foobar=0A=
> =0A=
=0A=
