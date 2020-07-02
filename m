Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A63212477
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Jul 2020 15:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgGBNVy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Jul 2020 09:21:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46735 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGBNVx (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Jul 2020 09:21:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593696112; x=1625232112;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=9KL08DCvWLEdIO9ouTYu2WTbczyQ6BgAIdbMTkcOce4=;
  b=De+qWQLhiBj3vtU5OXWWTwDkuWOdth41h2Qe5EbWJI9WoRAR3UKDtDL2
   K6GYn2pslRcPVCwv86GPzImM46OBmTXHnGZ7VBZaXffOfBcHEC6Rawjup
   WQpeYBI1ZeAcfRs7BncXXpoYIpK7xAZsdblQP0iBjIArJ7WYXmMMkWVLP
   NylM061cOhJC9rDkSb9RLkDHnSKLGfTuxiiGws8olh2kFTnhe2TE8xrRc
   w77IyCqvrmOD1X7opsis8ua+xO0Zl2jVMi6iv9hqwjWbWQRil+QkRGjFD
   0I1uPxeiwPqS1rM1FHQutbqSynV3rSxtj08zcYpSUr9Zqk8u1qK86PUg7
   A==;
IronPort-SDR: NB1Yo4bD7NkX21VMPwkgieU1fi9MOCrT73mEOU7K3+INakN7DorlTn0/GjwwmiUL33zLManzzY
 cehSEzNYeM9b3Kn389MpxWVB05CnfelYQMQcKHCUT2jtYIfK/vptCm4DZ0NgtSQ6xmDa6PoCA2
 eUJy19sehcwieQdvDlAHhPxbwGWEgmT/v1PiWnroVB2DQrhAQqMkKpLYywuxRZYTVpYlyJsDcU
 yVGCnoVisIMAR0rfWH3F5Rt5NauNsukyej7UxkkqLoQkgEMrVOvSF9qvMxItTXdcbpeVLLAgir
 v2A=
X-IronPort-AV: E=Sophos;i="5.75,304,1589212800"; 
   d="scan'208";a="145809778"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 21:21:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4HuDA/pVC7TOAQ5WsYySKPzCa8Ryjer6yZTPZD/6mcZJVbrOppqEVq6y1ob8MC/AQoH7MsHQEYQx0+XWxO9Gmlg90qOu/qzMB4gPvUyqSi045sSAraP7USkX+191oL6JeotlpNIx6qOk4kMB6o6SDr9epoy0JX+R4/aZzNFy3PEldaJnsMb521y+kypm4doNPLL8t8somB17eAL40TQ3eizpyA6K6UJBJok0GtA0Eodmb59SN/30kOm3QAhATaavF6sV/LwPsaXz11N2uGF8lgiJSxbDhgyx/9N4V+4t2ECzdZn9Kwvzc5cFu+KQDs0iELy8AoSyRWl5kPdt7pplA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS3F0q2nI/vQ76qulRt6a+Y1FpGgX6xAUVPqTBB0/1k=;
 b=IPhjSS8S818FnbR+glAqckBH61qcjedjYaYpyqvmdmBKq0ujBZK9riP3kNqUkTPf2EldByjj+Vm/bQkgil89o/7jx5Jpb3zpEyLUHL/A8rgp+ygrF3VSUjdCeUJFcq10Eu6+Z2RW2xOYK0eOrm+mKJHsQfOnC9BLQyYz5yUvVEv/x/Xti/Vcw9+u5aBaGiYDc8iz6qKejOkzjM+uigT0y8y1NPBltdEfywyNO44RBkIcsa6HyIMc604tAkfrbO6krhPFY8HdEO+t9roOcgKI956koOkYEfmIi/qpVCBPsTrxXXHYSiZ/4Jazd425ssLDQ5C4CvUT5ybPZ5LM4BC50g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS3F0q2nI/vQ76qulRt6a+Y1FpGgX6xAUVPqTBB0/1k=;
 b=sG818n4P5PbB+ufHrlPyPCUyLIcxKo68NwP25ylFlHeLd7FQ+H5J0cpOdeEGejNZCQV7bkJis18w8UhRWUlfdY2aQkENn1ajFJKEF3jdG1jGyzDXHm2otPaLorjXv2c59RDtSCidTd2iVw3jd+T11NZkMoZBgWkL5u0l7mzsves=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3808.namprd04.prod.outlook.com
 (2603:10b6:805:48::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20; Thu, 2 Jul
 2020 13:21:50 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.036; Thu, 2 Jul 2020
 13:21:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 5/8] btrfs: Increment device corruption error in case of
 checksum error
Thread-Topic: [PATCH 5/8] btrfs: Increment device corruption error in case of
 checksum error
Thread-Index: AQHWUG4tjVHYAJzmOUCdqeWYyix1Uw==
Date:   Thu, 2 Jul 2020 13:21:50 +0000
Message-ID: <SN4PR0401MB3598A71152884496C7A20A289B6D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200702122335.9117-1-nborisov@suse.com>
 <20200702122335.9117-6-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a64e81e-4bf3-434b-4855-08d81e8ae169
x-ms-traffictypediagnostic: SN6PR04MB3808:
x-microsoft-antispam-prvs: <SN6PR04MB380881F2FCBAB14932A9B97D9B6D0@SN6PR04MB3808.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27g0pG685FCcyUnKjkEa4N02M/WBr9CUv63HNn3oe5yloABXG4Ddhhp9ahb+hPv+BokcIiunYdqV2vAqDdpin10Fw0Jrz6KdxK8eezm3LHS6FpPAXEzwxt/vdUgsFwmg25xeK2ddpBPxmefe6moVCIDNbSJGk/utsyEr9WWm/Ir3CjcJyZk6YwdMrrP1oB0lx9LCYiFSaETALboo0nnF06c2CBpbbSkpenZvACu1Uls0kDEwzDEsBusgJGt48F33OdGfu9c8p/fEV2hFMAXZcnvEEg6IS7Slh9erCdzlOketM1co7bwBSojC01z8z9yx5sxMQxmrslDfknWR4ESVhtpxtI3TXtdw4mgzX7MEm4FBUXWHZHgZXVWiqMmRJmOpILAQSy2eLiC/q5ddt61VKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(66476007)(110136005)(316002)(66946007)(2906002)(33656002)(8936002)(71200400001)(478600001)(66446008)(91956017)(76116006)(83380400001)(52536014)(55016002)(966005)(64756008)(8676002)(9686003)(66556008)(5660300002)(86362001)(7696005)(6506007)(186003)(26005)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5GeBo66AB+rWlH7+dDPTjt2jJ/wdlrzvlF1QuzIkyXinErASAv+d4X9qDh5NdPbx0kbBDo1+sLDt+2xqvRFYgqC9VKXh+CU02BOjZKPTdGZozYnaPZMbLgduDllK+cWvg9087Z+rUQf0qs4slYCsZh9duVIuTOZGBQ2lwNPvkiOe5Cqkz2hCgPjqVPSAOdi/QG0Iq/+U+iCiPSm2ON/qiibnKffIe7VEk8uxx1zOE1i9k3/M5RXdrQObfkC7kTYXdk1aEHmDEa1OSwFX0KlF462X2jJNsczlWTyKkjb1MezfDXRvNJ/ogettM4Hgr90tdsKIsFmBonve+sU4KvVwNYjlKqIDx5xXsLI/F9g2RtVTJV1koc5PtB1xeuPxMRbwpBLuCWMzoSJloFyxIA0N7vZYP4Uoat2BcKzaR2nEdlUsYrtF9120TXOXqwXsrKLsG1K+9QUzbTL7J84F0kWYKj2aVBQFT1MeT/aOV2vQRajcyN9DBu/cJMg8kD0dUEKM
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a64e81e-4bf3-434b-4855-08d81e8ae169
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 13:21:50.7939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4xmUv22v5dUA5RCKDwTXeRS+Yu9RTOoRu/UN9FxU8PO+JdsxX4amD6hE0Jp09cv1uG+uxH2MIEYNEwAKIL2ObAU9JIJ+y+Tgg9siMRTdRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3808
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/07/2020 14:41, Nikolay Borisov wrote:=0A=
> Now that btrfs_io_bio have access to btrfs_device we can safely=0A=
> increment the device corruption counter on error. There is one notable=0A=
> exception - repair bios for raid. Since those don't go through the=0A=
> normal submit_stripe_bio callpath but through raid56_parity_recover thus=
=0A=
> repair bios won't have their device set.=0A=
> =0A=
> Link: https://lore.kernel.org/linux-btrfs/4857863.FCrPRfMyHP@liv/=0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
> ---=0A=
>  fs/btrfs/inode.c | 3 +++=0A=
>  1 file changed, 3 insertions(+)=0A=
> =0A=
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c=0A=
> index e7600b0fd9b5..c6824d0ce59d 100644=0A=
> --- a/fs/btrfs/inode.c=0A=
> +++ b/fs/btrfs/inode.c=0A=
> @@ -2822,6 +2822,9 @@ static int check_data_csum(struct inode *inode, str=
uct btrfs_io_bio *io_bio,=0A=
>  zeroit:=0A=
>  	btrfs_print_data_csum_error(BTRFS_I(inode), start, csum, csum_expected,=
=0A=
>  				    io_bio->mirror_num);=0A=
> +	if (io_bio->dev)=0A=
> +		btrfs_dev_stat_inc_and_print(io_bio->dev,=0A=
> +					     BTRFS_DEV_STAT_CORRUPTION_ERRS);=0A=
>  	memset(kaddr + pgoff, 1, len);=0A=
>  	flush_dcache_page(page);=0A=
>  	kunmap_atomic(kaddr);=0A=
=0A=
Any chance you could do a follow up merging that weird zeroit label =0A=
into the memset() block?=0A=
=0A=
It kind of disturbs the reading flow of that function and in fact it =0A=
doesn't even zero the data=0A=
