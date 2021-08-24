Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25B4E3F5991
	for <lists+linux-btrfs@lfdr.de>; Tue, 24 Aug 2021 09:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235046AbhHXIAb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 24 Aug 2021 04:00:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:38469 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhHXIAZ (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 24 Aug 2021 04:00:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629791980; x=1661327980;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xkcE8+XfJhBBT00FPQ4a36+CRPvB/XukkN7C7GeN3+Q=;
  b=Fs5wtdK3XP9+ahbMoMt/1b63cQ56ceBWe22ZnXHEWHS5HD/hxovISJjV
   wtYQsFET4kqhVoJzhTDA0u2j5Rco9HO3WMRtG3m2cWzN1/+SboElL4VhG
   4iLW09fh3gN/oXhigHKdL6Av0hQ7X9IAVvQPKqTvQBE28Wqu+n6ZlegoK
   p250NTiosN37syjRAHr4yYQUf4W/vG+DNfF6Uwd1Rd4ZRaqYhV3WZtizQ
   xEpRvyLpuUd24M5jRAD6MCBG4Eh7N2Jx4Si1AxKxmbppZvQoiC89I07/2
   4siv/CHxq47MSLV2zKswznFsFopRzQDn5qxx3/LPQL69YM/Z+35rE831P
   Q==;
X-IronPort-AV: E=Sophos;i="5.84,346,1620662400"; 
   d="scan'208";a="178203923"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 24 Aug 2021 15:59:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOnaPMd5PTHqmP4hgDGQmH5nkN/tC/o8FQGHyg9kTh9K6yVfZcwLRDYA46AFhU7WxNBYN7oFA1ygZSqCWMBiiZoqG2uHB3osDLtoW8CkyKb2ctppj/WAp09MDEvLOyyKH35rnD+lYPBRvWKS/PFeQq66617MBa6IVC1tRXGzM1gBrlKXaJpjrq7nP+Mh/D1lDWr4BGmY7v+iOOiKocUEsnAckZs2U2x2U7l+TvVRt++U1v/bTF9I+ZGyvqj07vVjqbAXbpv4QC9xnDvlS95Ish0AF5Sk8N4gpGUdPRsI9KR/Or8YO9qCmrmDOVl2kQT7fuLAtE9HBlfJ3/KW8IKmlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvMtCC8VhstL6jZjA8A5/RnlEayzRZnU30oBI2aNlpU=;
 b=UUI8xa2997fVrQvhXHkbpyGAWnq1Mha4YSgXD/oZLUL7edfxhNd68qVaJHp+LEBgAB0opMSPpqbuDIZY1NL5skXUY/JMpoyiNmnBnKbhTUX9ot+7lIQE+feo11qlYYGWl/8JReqwjTvqD009n7dPikf9k1JbELiGshI/adCITB2g0VZRrqo9qODdq9HcdA6Tf16nXamt/5TDy6n1PlSPMnnt3K+atpzH/YMprK9MZHqre91dwxARicGNQ+IYXTuVzKrMOByMFgw+m9O3/krzNgYhFIFsn3O0GMrFQB5h787pLE1+fBk0JH7K9e4riFj8LGwTTDy7HNI6bb2o9MBzkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvMtCC8VhstL6jZjA8A5/RnlEayzRZnU30oBI2aNlpU=;
 b=tAdwUaj6Ks7pKsHUVCxa8T8YrOdxtZ6WCZNxiANQ8wSWl7NzDAPDIftZaDqAlqq03BWR1tUOWlpQgiwX9BfqSnClMojAuXWsdgnIrWg0sUgsSP+vNj0uEl0XM2pbbKEb0/sxIsk5+QlD3x16GAlP4OhBqOezh49YRpL4YvHgR0k=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7270.namprd04.prod.outlook.com (2603:10b6:510:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Tue, 24 Aug
 2021 07:59:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%6]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 07:59:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v2 03/17] btrfs: zoned: calculate free space from zone
 capacity
Thread-Topic: [PATCH v2 03/17] btrfs: zoned: calculate free space from zone
 capacity
Thread-Index: AQHXlPWOOZMNOgSR6Eu5+ym0uuf7zA==
Date:   Tue, 24 Aug 2021 07:59:38 +0000
Message-ID: <PH0PR04MB7416F7E5FAB3EECCBC58777D9BC59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1629349224.git.naohiro.aota@wdc.com>
 <03bf2db22301fcc6706d489dab1dc3ed6ac54a8e.1629349224.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce24d482-1544-42cd-8434-08d966d51f67
x-ms-traffictypediagnostic: PH0PR04MB7270:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB72701DD759D7FAAED4E3A4F29BC59@PH0PR04MB7270.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lb1bpLauYFNoSq+5F/0UTQ52jzqTKKM96TrgeMfNrlmdeBiLq/aBO2byhoFEzoHThv5gBN+c0+HbYNOy6XwpjXMiq0mJeIE5qMJQcJ1TNBnMbPn+Ci95LOie8aObxiDSNYUaQqijhs+0ldO0KjMyrahhRJZBvPm8aPEyq/gouvwnYzsOYU30T8YR1gb9qMKHB+LGRgyIysP0q8UacxDo4AAgAEvwBvwSZgBDwYJwI8aGkfOPvljj3F/C1s3XuGBBWVB27v0UIJTru19i/+z5kOHpcBEGLBAld3D6ksMcjljBi9OW6y8/2qbK89cHtDdd3NcBRxN0AQh+yeGrAGq4AvoBIye1kjcVIMJcx/OJ/HqhiODYjqRJo23ZzYCwLSIef+wzeAxH/HKDZLTGZg6+ZGKXEi8mA8aqAKtIOR2gs5NTkX0RqH9ftYUyWEv9BQLCOuAFFtXNmr/LcvoDuuzQZIwq4aAAg19pnet9ktxg1zKBSpURS/fllnEOWXRMyDvHG6ZHfhXnsbzYIHmZe3n7PR9dBd1bYvtBzyG+WxS2/GRZy7abzHEXRvs2opNnagq38aMxIyXab+5bf2y2+iCAERqdgPeBj3VAahA95qH70Us9w54bDRDU4KXMqzWa4NK7r4ZffZ5GWsEYZWHt+4jBr3C/EtA2n4FQE0GXT312uskt0UkBVXO7ohB5B5sEHHtnHOGU/TXj1I5uoMtWvHJ5lQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(122000001)(71200400001)(66446008)(64756008)(53546011)(9686003)(66556008)(38100700002)(66476007)(8676002)(4744005)(4326008)(186003)(55016002)(478600001)(6506007)(83380400001)(316002)(110136005)(66946007)(52536014)(2906002)(38070700005)(76116006)(86362001)(7696005)(5660300002)(33656002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hm5r6+FzhsoKrGm1tm6IR3KwnDTR0Y4A2QPhQQ3YkWeAFqeIMtc8aqNjg/xf?=
 =?us-ascii?Q?FcxkaCqQK86+2WmPAMB+WPPTxl0qX62M05WQDt7Q9znF3nW8pVmRr3eMmAy8?=
 =?us-ascii?Q?+2LHZu/ensgicLvof/TGP8aEpniENTCp3SjIxuoe1fnAaBsX8NLjYFGjEMNu?=
 =?us-ascii?Q?r8OrV5zfvsxvjo2ZMbt6mibuACZfPv+mQFHRvVaSBkwZ/n+tFZAzZojBSlT7?=
 =?us-ascii?Q?jUkV7yp/GI9AtRHSBhvgg3H0ox3DRQtZ3wWVlAvWLo0tYoMV7X7R1M9j/DqD?=
 =?us-ascii?Q?Czjk3GQ4AO305Ts0opASZjhpyhuqfPv15gPJH6sqRCte8rjLEc1SfHsJ7Exg?=
 =?us-ascii?Q?PrDwVQwuetCY3r8E5GDnqtvXnP8W74Sikxy5TWQd8xxTK/C/RJZ9aLunZsLW?=
 =?us-ascii?Q?99zH04fKvSSdKt75r+b1HcyDnjzqIDsWC7RZIcCAHW2g4he+JLs5nEpWVECi?=
 =?us-ascii?Q?x7O3BaBUI9/BTMITM3syLnSF4ktbViqc+SUblpHVQDBbPXmCcNLismEksYHZ?=
 =?us-ascii?Q?xlkjr4GtYhD+jWO6vZOxQrhJC9rgUzbUchmGqMqC5TJnsvhjSsApXCYKVfUI?=
 =?us-ascii?Q?pk2pZqokm6HQnn6BHM9Dju70tLWAOh+wz68/BS4W3Vpuk1QaVpb7A3Eo3gkb?=
 =?us-ascii?Q?Dy98UGZUVS1XaulQGUxSjKml3eBz4Se5I5J3zLz6vP4ZxIEBCKfVrkd718j6?=
 =?us-ascii?Q?Qwe4/kQUA/Wni4AQJX7JCdtWXZ3iVkqNGZkgWmkbSuGYUtxCzljKAOXpV2iG?=
 =?us-ascii?Q?5B9UQVuNpaiIeDM3+t1narhL6Q226/5QZROpGya6yBkf/KEWbCndawy+Fnyg?=
 =?us-ascii?Q?Og9qKF6z+k3OSC8tw8Y68f4mOzeWBNxkTsfI/3nHpyjeBa/eTNIgzqgD+A/1?=
 =?us-ascii?Q?5VzZAG7hJSAEtJ4n4+wJZFvMXPahT8MoD0bAkW2o74TndfFHOgfVFVPaPimV?=
 =?us-ascii?Q?zOCWRwi7z0Qh6vcuqx4I91kTedACYWxZqOiYrwXWtiaiUCK7Ocp3Xica6Ufw?=
 =?us-ascii?Q?RhaEwNLeTtkxIwr1sRsN3AXT5oJvfNquXDeU+9GZPnAd9PWUUUlKxS3TBQDf?=
 =?us-ascii?Q?LViZZqCtxQy13RQpvn8AqkauSXaO5RlW08If4m0E+sZHKbr2pOQegZ8ddWqq?=
 =?us-ascii?Q?lTSr883jvmooq17bz5BKjQH412o7D12TMTnq1N2Klc3GUGZgBPU/Bcq+HXjg?=
 =?us-ascii?Q?0DnAFz/XCnBTTqwn0/jmTP1qYKNSE0EDuIsb4YdonRabBM6T3qNzFWW0bMAZ?=
 =?us-ascii?Q?NUbsaYulshABX52vCLaDBe2xNKfKgIiV6vnGFvM+oWq80m/SClV8QZ8JVef1?=
 =?us-ascii?Q?t6RSYN/5ZGor+JaAmW7b1rzun/ZH0huOwR+nOYgYUmNOWnzeZp6IIt95HDAl?=
 =?us-ascii?Q?9ji95r5BBaWYNI1m8MQD10Yr9CyEUGxs3XrjYWebfqoP2d93TQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce24d482-1544-42cd-8434-08d966d51f67
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 07:59:38.8798
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtoTSzarYyeo3QegHjy2AZ4o9dZuSQMtXZESqe1HQSilIDzWw9EpEJtEo1sDcJmuBMGt2vhGFMx1jdvSqKsEyP2Lpo7dTwH22PV2OWBt8JQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7270
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 19/08/2021 14:27, Naohiro Aota wrote:=0A=
> diff --git a/fs/btrfs/free-space-cache.c b/fs/btrfs/free-space-cache.c=0A=
> index da0eee7c9e5f..bb2536c745cd 100644=0A=
> --- a/fs/btrfs/free-space-cache.c=0A=
> +++ b/fs/btrfs/free-space-cache.c=0A=
> @@ -2539,10 +2539,15 @@ static int __btrfs_add_free_space_zoned(struct bt=
rfs_block_group *block_group,=0A=
>  	u64 offset =3D bytenr - block_group->start;=0A=
>  	u64 to_free, to_unusable;=0A=
>  	const int bg_reclaim_threshold =3D READ_ONCE(fs_info->bg_reclaim_thresh=
old);=0A=
> +	bool initial =3D (size =3D=3D block_group->length);=0A=
> +=0A=
=0A=
Nit: Unneeded parenthesis=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
