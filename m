Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0826426895D
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 12:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgINKft (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 06:35:49 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:3369 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgINKfs (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 06:35:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600079747; x=1631615747;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=W9rLeSYMKwZLQrQ0GImPIgJ+Sb6Od5whP6lulyRcvDI=;
  b=cFPyC13xaQrH94a3T97fcYlEOhFqzlhKuRqQ8qmkUn1PUpIsEOu+WgOh
   uKn6SbvWjiscUl6/yBrDdtlFt0RuGm+XZGrRx13eeRlpqpvqte0yZJDkG
   AmPzWtJ8DhV/5UXha60e5KXxkQ6HmcjhTZy3XgdP8+eMUMD7ygIsdqgEM
   zjmaurx0OAsMsiCVP3P4lvWtzf4SRRjwz8QDHcnncbXmSrITvpYeUnAsc
   dCh95qopQk72OXKIHDIVY/LtmngZEjUAerQcXzlGX2q2A0xgrtC7Gr987
   zznwwbZMwpHgGKxfJTxpQUKa/E18W9fny1bxP8EjQ8pJclD1QaIZenVsu
   A==;
IronPort-SDR: MKWTijqwqX34RXQGY/ltK0Nph1ySyGzYwclPjDPUqOLjXcJ2ZTWQqIoHucO03wGPjUq6kG2Aq4
 GmcSpuI1uCkt8syVTzwpEQw+XBYxOAQVhN+t2hm+dWYN2CHb5SslJTe6Dxx6cN9FocXbbQo+g8
 yESnM8+sT7xw8Qgd8rHR55kjDcLBlfG9K/7KpZAZC9sIpNF6h+1i1f2m8GJqRVJV37ojpoxdJj
 fpVZyUUptf8NqE0oaQx/B/0TS0DWh4OS8rZR2egQZhi2TkftavotIT6KmbLH6IudQtgDi+BLXE
 YCc=
X-IronPort-AV: E=Sophos;i="5.76,425,1592841600"; 
   d="scan'208";a="147220197"
Received: from mail-dm6nam10lp2102.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.102])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 18:35:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joKefBdp9+wgbWIe3vSsVI0VFeZMX0U/YyLU/nQv8mPlYybbhS2FweCv3g2+0j8VnKU6zhBCFhPmN5CE6eSP4sAWPDo05l0hjxKWnJjOGbH/GV9sHZO1k1/m8itv9mFiFumAAfE0xghi8ncxP5kuccOqBDD8lWLZTvT2RxwMPaWP/Qm5dUbN+bbq84tr1w28QGR9J+WCkUyisQiZ440vH8GpHxuVDZRc7z6ll9q0T4e+HeeIu1B6DH+/O9wh9xCF/i9taJOw/pGZwft0YL01yk38BatfMkfhq+36iTKMMQ3KDOut76yQJUfzZCy3svdErUIP9MhPFlFpXiFB1nISOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEpi3ifji2VETdMp7u57sGyRDLDRlwEPHyfhjEskzoM=;
 b=LOYaL1QtGvQGDVeycXFIEiNXmGCdAI3PVgcOAd5rj/ov2yGsa9Q95gwZF30P8QKkpRpjmP6wo2/D3N17I4N2lPbcMUOP33I9dhLiN7aynH92HULchx36UOEaknrhqhWC73g8Aq4w6kdBKkF/XsI3Od30kBfsecDILlfMppbRVUB4CFlzoMnaWrdaho1tuHicAjR8ZEttt6t5FzDmgpGBXPiwG7gd2y94TBCslVp2quubRB+GmKm6WbjddF1OmfZNIcKiH1c/jbwdU8wSHxKWofe+SuL1QhF/XCvJXrG0XVoaCkvKv2PXNOt48uWxFhDdg6y2YwRi1SwpuEqSvASOlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XEpi3ifji2VETdMp7u57sGyRDLDRlwEPHyfhjEskzoM=;
 b=uqf3Vni+vAser9FHEpgmnhY8CbSWWDiq8DzpEO4ptu5qWTj2qdLmHZHXKfO3ncNfQfJoO8aFF44ryXyG+pO5IT5orGEvX7/i4I8IWAT7TQ6wBVdrJadJwmupyxXZIs+J4IFRtc7KTeh7FGjKo0EXxRDhI3D5Er7oSDyZGQcZVrU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4926.namprd04.prod.outlook.com
 (2603:10b6:805:95::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 10:35:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 10:35:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] btrfs: Sink mirror_num argument in
 extent_read_full_page
Thread-Topic: [PATCH v2 7/9] btrfs: Sink mirror_num argument in
 extent_read_full_page
Thread-Index: AQHWinqrJTwz6lNosU+b7CM9GjQJYw==
Date:   Mon, 14 Sep 2020 10:35:45 +0000
Message-ID: <SN4PR0401MB3598F37C47433D18586FFB419B230@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200914093711.13523-1-nborisov@suse.com>
 <20200914093711.13523-8-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:89b7:64ae:7a10:bbdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1e56d3b0-183e-4061-fabd-08d85899f008
x-ms-traffictypediagnostic: SN6PR04MB4926:
x-microsoft-antispam-prvs: <SN6PR04MB492673905B7F6E25851B93BA9B230@SN6PR04MB4926.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ot9O5N4zHK84Vu8CPNPaZh7qvKjPLF5ACC4f0F0VvpRirJwYG0t+6NM8wRHi/jtd3WqllvWJIRZdIqK3aVzFAWhH+PmUldEIlAiAJBy7pEAbVo8bHqBOC+CESHM7cw4R26ZxLtig0nfnV6c2/OBv3GVD9WD5Su/YIwUzA/DQAH7WH1jgk8bYFa46ekc6t3rTZ++Uc4bIzgXdwurMCb6/x8iiYyhtb5L8MhkTGgrMnx1DG5sdbFJK/hUHrNtvUqa46z1Hm4gjVucZlr3zCHmkq112cbrOgQ5daHerxFllTbcgGLNQVvsQVOiKgLZQRKoxCsz3hPvgYyxlyvZ3nOAWMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(83380400001)(6506007)(508600001)(86362001)(33656002)(186003)(8936002)(8676002)(76116006)(4744005)(91956017)(71200400001)(110136005)(316002)(52536014)(55016002)(64756008)(2906002)(66476007)(5660300002)(53546011)(66946007)(66556008)(7696005)(9686003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: FKii31dTOmjnmNZQLnw0cZvoeU1+UG9IU6Ns7B8ZnxmIC+RxDL0BpZ7EOZYQfjc/sdIHnH8u7PfxUmR7vOdzMUvZDT+bXUl5A/Bl0oFXhmX6zf3TqaH8V407l0NJf4r7GHlChgajQxa1anrUrTviWy+pjxUXndopCq+PmPVoLkpH44wcuhOupPCXeYpwRT0tXfVmQcIpSZgnkbXd7SgQJ+lvesLWTuR5EhDSodRRJLMy0niC1cSSuIg1I0dSUUtidyHWlPlb9vx8GicQc7Ft6fp/2hffh5xyB8VIunhna1tgeHzhRXIo1iqq/Uhu1V+p5awVYldlHyRxo8QQCd2k/R/7MvDeT6eXj0AZ8fUydRo9eILVghUt7/mOItpMC+tggkJxTTwKwvevEMuLnrHwQknLPqQjZdqpbQw/ZddmpyJxtoXZEzEXSwskThlda5miR4XQER2L6HrVSLEQCetV3d1TUt54LsRXQCjWiKlZ/+SNX6XpKskBjPlzGdNNdxphd/eBzbOGq4Mfql3/iGPQuWRCs3MBADA31DsSMurT3Mer34UvMTh9JWBOBqUJvD3TCmH0SHkXxogNhCaVot3ZNGV+gWp7hSdDCN/ZBJZDw5vk8qjmjv8EpdEt+8iRzBFY82maVQ3AI7Ox1SquoeCte/WdjEsDrNvqwVrT8OuLaQuLeDLfyhSispZBLOFQL4iZn/q14HZ8OjK2NpCs6Ah8Fw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e56d3b0-183e-4061-fabd-08d85899f008
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 10:35:45.1776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B2ndry/lIpAVYY+f+45k2xTOgmKrBWGSunCLbdOChk3C67g73RwoZ6FaEgMytjLxZhHq7VohQIF9uyDDYgqz6rYmJ65UU4EcSS0uz+39nDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4926
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14/09/2020 11:37, Nikolay Borisov wrote:=0A=
> @@ -3375,8 +3375,7 @@ int extent_read_full_page(struct page *page, struct=
 bio **bio, int mirror_num,=0A=
> =0A=
>  	btrfs_lock_and_flush_ordered_range(inode, start, end, NULL);=0A=
> =0A=
> -	ret =3D __do_readpage(page, NULL, bio, mirror_num, bio_flags, read_flag=
s,=0A=
> -			    NULL);=0A=
> +	ret =3D __do_readpage(page, NULL, bio, 0, bio_flags, read_flags, NULL);=
=0A=
>  	return ret;=0A=
>  }=0A=
=0A=
	return _do_readpage(page, NULL, bio, 0, bio_flags, read_flags, NULL);=0A=
