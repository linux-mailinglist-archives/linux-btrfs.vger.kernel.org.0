Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFA02235EB
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Jul 2020 09:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgGQHbY (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Jul 2020 03:31:24 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:17084 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgGQHbY (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Jul 2020 03:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594971084; x=1626507084;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Cw9FxjM4475wEGhbTZ7YWELMZdqOZ/tXsrcsR7MnP64=;
  b=qp8fYzGW5CJTmxMF+l4wuzWHeT1iYuZ8O3qIy1M5AdoYs98yMnXuzowh
   j/oVN6GxSWscZ7xlWQNOnwwl54bfzRzjJam2Jni+XtUPvfTqIFVXsEB5I
   VPH5waySwqFn3bzPAbRSOGrF9bOYt/JKRaIczDfzL7NJw0SIFzDHXipo3
   gh31UDW6FIkwklu4x1p5hiQ/3tqzFbz5CzQ3jfTq0pLISahY3DgVaLLcV
   Aj/iP8pXZ6EoaivCUSZgX9Hkg6bWfnkJtHj43lDnNRYKtvV8+MVgiKs22
   eomzQ6RZ2TWaM+pUsc9eZJHX/PEnXbUuhDBbdmOU1xoSvDRGzk/E3Upr1
   w==;
IronPort-SDR: RQZ2edwq93UxZsvpHfLDqOohwK0/3aad5N308HXh+C6+LOEob0Nx+gQh1D7QTRYu7iRH/7yVv5
 04fLCH7Hk+ChWEV/gJFDmIY596CD6TBifzcGx2IZUP6fSPSSd/a3Db6zcDR0SvvSyEmI4DoXDn
 jQN1oR5/VX0Vi/hAomhxDApfxhLkSZlO344D8my297R+iI8Rpewwb/UrDuWIxAuoO8k0EpOpDc
 0VjlkjMlPrYIzAKv8ahDeeGE2GSKDFAIFtI5e+eldS7qaNY21jg7Rq9b8c7UB7sCStSaMI4vPT
 iOo=
X-IronPort-AV: E=Sophos;i="5.75,362,1589212800"; 
   d="scan'208";a="143984310"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 15:31:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMwhSjZUVGWbCjgSuXwj71SMc6pn0lOKMIUB6O46ZUqdLMSpFsiqxuFo21/lyGOd1WtwTrqHmFcssJXUcy7TzPTC0ZRq9ADYbok34eBSjeDfdQxIpvYjmg0VVajezJIqgCvWm/5/ICrj1JF9NxB5VdrXJbLev2Xhw3ql1c365n0/gmnrnKIS7BOb5jAkn9FmIB8vNgkxed23qyZR4YCOwUfyMTE1qVwrmPuz4wxZjTMZ/ceB0J+zngsI4MQPnZiJCvgBtEnQq3rG4MC/fqehjdXqhXsUHlJiORjt7TigB7qblC/jMpUwSDFXnpxKd2mfzxmtuCwUl/d7F6N3J2LyCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvIx7e3sBsTzgxC5/3CXqo4mjzD2NTHfYJvEUAggzj8=;
 b=lonxKQXDUD9bYZbRynqzwlk+XVRsyr79SBR0NcuyOqQkdKVl2G06gxM0lRiOzt6RAQJdV1aVODoMgkFcR4W9SBmeSkE97JqsZCLFqLeWFDbEaokXyuglVUI+UHDduUCWKV2tjm4vDlkeoq+Tqyp4jG4mEaNwsA9JY1pmrWNIrrQ+Nwh+NYwGJaqvjJVM+9dEBMN9SGHrnWfMZV2Gb5G+S4QouS+NIz7fA0mVTTfp45Es2DLGXywtE+RT5k639txjzamrD/kzrwaPlZvs79pWFaFb/hehr6Vz0ztFQUHlv8PJpqQYBo74P7vf/K6S1b2ymrsEnO1eRb0OIroIuT8gAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvIx7e3sBsTzgxC5/3CXqo4mjzD2NTHfYJvEUAggzj8=;
 b=Kt0Rs3zk9dvdcrnVO3q06ACIE+5Jhkw+1CjAgVByV6B2N1q1bFMDrj/yCnsEllx7+kQMnO16dTa6zHDeWT0NJzNid9PTGQfpbbm4t5I0EsL6i7/rk6LLkgQn3iWsBOSGa/MGnAFyXSMRIgjll6D76zl+y9fTogwVYJf+zlQB7Cs=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4781.namprd04.prod.outlook.com
 (2603:10b6:805:b2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Fri, 17 Jul
 2020 07:31:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3174.026; Fri, 17 Jul 2020
 07:31:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Remove done label in writepage_delalloc
Thread-Topic: [PATCH] btrfs: Remove done label in writepage_delalloc
Thread-Index: AQHWW4Q7fgdJPkqFzEGl0IJ4cBQI4Q==
Date:   Fri, 17 Jul 2020 07:31:22 +0000
Message-ID: <SN4PR0401MB3598754B32E2FAF5092C8EB09B7C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200716151719.3967-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 666448a0-3815-48d2-30fb-08d82a23679e
x-ms-traffictypediagnostic: SN6PR04MB4781:
x-microsoft-antispam-prvs: <SN6PR04MB478140087F2DFC46B9BD29199B7C0@SN6PR04MB4781.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PM5DO3JQwM/dSvRB5FLM57DI+CsSZnL9JTQYv8K0wBh603v73JU6noSCsFPi1Hcewq33hpm3M0L1N28mr54f9k99KFG7YJXo7bvzgEfx8/Kl4DLRj/3XAwDEBfADTvfgyYJmBp2HWp+/DVkspFxfQ6epCXuH7T3Ta+GRsJCJ4V3jAiAEMtuWs9YtFHmXZslM9mvrgtDOVVZ4Ysf4UtSeyoLgVMgZuSAXItom9h0SGhFhD8h1djmj/leOI65oaV1u6uBARluTwF9Y9E5XAz7rSk5gYD0HRkRIv2NaOEyotMSlWXdhsJ8o6wnlPs7IskwugEJQkAy4ZvmFe8Ey5HYf8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(26005)(9686003)(83380400001)(6506007)(52536014)(5660300002)(66556008)(64756008)(53546011)(66446008)(66476007)(66946007)(2906002)(55016002)(316002)(8676002)(110136005)(478600001)(71200400001)(33656002)(7696005)(91956017)(76116006)(8936002)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: JyS/KOHjNWiqjx6LmpzCxOYGhmRkmiyhVZ/vk8CzRzbPwocfxOOlBkxeSy30izCtwselbMPeiZM17vvVpI2UrqnyaBZjGQ+Mgx395ZTxJQonYERtWip8roOZ7pc9sgISyyS2THVTd/jBrT6LIisXJ+5bVXmDtHGHtDw7VmaHlXXQlWOO9FgJ3tgIaNFdBRXIfMc+LawD8HLnpX6rwz9EI34w7Nf4IoA5pm4ey09cYg3qrp1cekufSkYe21R2SHEYDVwYZGpul4f1E8rMEsqSqeO6p8l+qbM5e4T9inQEFuP4mbOEwg3q62Ca3Sfka+CWQAcyEeOZBkTYlWfKb5AT0tBinXiwwf6xiGeDx4EfvtoHrK1APR9RvoAb4E8HsZaTr2kQcgeHC4onTz7S+LqZYFoUuR+H/rLFsJ/X62qv4J3rfL2Arm+wM5vG6H61t8C7jhVdoSPQD6hZP7/v/x2rGwU0D+wGJ2/3xdCmKKFwD7+CfM9oJN7loJKnZX2RsGSZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666448a0-3815-48d2-30fb-08d82a23679e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 07:31:22.2058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb0I1x2GUaxKPzShW+gaQ9wxo1CEE2XcKoOulTXgPVciBeN/LVeudnSkBOGuCQe9N3LMssfGFE8rWx4el7EgRDLtmYsvUcsrAjkj9uNBRNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4781
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 16/07/2020 17:17, Nikolay Borisov wrote:=0A=
> Since there is not common cleanup run after the label it makes it somewha=
t=0A=
> redundant.=0A=
> =0A=
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>=0A=
> ---=0A=
>  fs/btrfs/extent_io.c | 8 ++------=0A=
>  1 file changed, 2 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c=0A=
> index a76b7da91aa6..e6d1d46ae384 100644=0A=
> --- a/fs/btrfs/extent_io.c=0A=
> +++ b/fs/btrfs/extent_io.c=0A=
> @@ -3445,8 +3445,7 @@ static noinline_for_stack int writepage_delalloc(st=
ruct btrfs_inode *inode,=0A=
>  			 * started, so we don't want to return > 0 unless=0A=
>  			 * things are going well.=0A=
>  			 */=0A=
> -			ret =3D ret < 0 ? ret : -EIO;=0A=
> -			goto done;=0A=
> +			return ret < 0 ? ret : -EIO;=0A=
>  		}=0A=
>  		/*=0A=
>  		 * delalloc_end is already one less than the total length, so=0A=
> @@ -3478,10 +3477,7 @@ static noinline_for_stack int writepage_delalloc(s=
truct btrfs_inode *inode,=0A=
>  		return 1;=0A=
>  	}=0A=
> =0A=
> -	ret =3D 0;=0A=
> -=0A=
> -done:=0A=
> -	return ret;=0A=
> +	return 0;=0A=
>  }=0A=
=0A=
I thought David doesn't like direct returns in loops?=0A=
=0A=
/me thinks this is easier to understand though=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com> =0A=
