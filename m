Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281EB40A6FB
	for <lists+linux-btrfs@lfdr.de>; Tue, 14 Sep 2021 08:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhING7f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 14 Sep 2021 02:59:35 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:46262 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbhING7e (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 14 Sep 2021 02:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631602696; x=1663138696;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HN+1CBG0Ui2dpjKYcN70WlYaswrlZWZohtYNg8pc+EQ=;
  b=aIINDFw9iC6Fp1oURyOUvwU64b01Ri8J0RDTUa5oM+khiWtBqiute1he
   M+BixA4wi0iRh6b+mXZ2KmufFOmZylYi0HjN1hD0dAyaenjkaomsdiNbe
   8QWJ0kr1p+kiMjcSIaeyLUMvSdHSFWFgDBAs8rwzzvizRORcXWcbJILvi
   WLF7iiF9fBpD+VPI71RITAmKGzJo/tfMH+JVLq3EwyyFN3iZ+76EKCCli
   3jfINVBoR9uidUZUpwK2r7OBoYfh4tuCM4E+J0QJWQ4/QzBSULF9l7PMR
   isjkhs78XQ3enTFs4e3TUYuzKYDD47xOqQ/sRav3vSjG1xLIxfW9hwvpf
   Q==;
X-IronPort-AV: E=Sophos;i="5.85,292,1624291200"; 
   d="scan'208";a="179941834"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2021 14:58:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FmPkH6eANvoMlZlNC3D07o1ma7UNj6h7JGG95aFo4TPb5o8Dkr8uTQCCLBWuvud+UA1LqPRRDOxi/dMODZg2kyuBvSCr46fTXGjAMF+ULELovEjmD8tnKvolXyABm+f44RkRUrZSZYD/OrA1n/Xq+95RU8PXMlI99d9Gydsz3q1xT+IWErA2YLHqgZVCZAUcoNuD4+ECssbAiWaq9smdYpO9yf/tz1/197ZT/mvUREFm3PCbE1tPJF1Wmth84oGQ+2PCAz32RuOMPM7x3DmWrX7wltYME4gM6Aa/PTWm1RQRyqTW7xVoabSeXfWn445ixq5LWuF/7q6ZiE7npLtQ0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=HN+1CBG0Ui2dpjKYcN70WlYaswrlZWZohtYNg8pc+EQ=;
 b=ktOKC36uHT+jdOBC5E89h57Sb+Ce2BVgVB+OMKj536NDKd0rmbW9riS2Xv8LMHdSb2IwT5RDwbbGF/B3pJraKDhO275LIwJ7H75xYG1Itv768AkgMadcHDDPKzc/xxvkhQRMll/S/1HzOffj5Zue3uD5hEhp2O39/C54cAuFirVGDWs1+dqnOGiIsA72G0An08LI0mqIkIwvZKy6Mt7IJXmnp2YNwV2WWILoTKCKeK05FtSkN15qkGyGeJh+2D0/dEgeQFzcQIS+Kv3tH4MPD6qBNo6MArhk2TBPhbLXMazr8OrT6WCTXEC9ybb61yf2cG4secilOuCk09gTu1YYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HN+1CBG0Ui2dpjKYcN70WlYaswrlZWZohtYNg8pc+EQ=;
 b=gd8LrIbu2xyBFcZicBZN5ERgXkFPJ35yJrg2WL0kDzvzCiVgAdI8yk6Ntq0YOJt5okkopmeIVFfYt/4q+y+einBpyfImAUQ8WMR33bsITBxY1rwPUplrTkpTRn/7TsT4jHCgUnDHwD3/ylfOiMbwklRqblPwpP7PvEj5ajS5Q54=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7671.namprd04.prod.outlook.com (2603:10b6:510:5a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 06:58:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%4]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 06:58:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2 0/8] btrfs: zoned: unify relocation on a zoned and
 regular FS
Thread-Topic: [PATCH v2 0/8] btrfs: zoned: unify relocation on a zoned and
 regular FS
Thread-Index: AQHXpM1c/7n606eZOUKl08CIivL4BQ==
Date:   Tue, 14 Sep 2021 06:58:15 +0000
Message-ID: <PH0PR04MB7416421FD16B6C4DE322545E9BDA9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1631117101.git.johannes.thumshirn@wdc.com>
 <20210913155105.GC15306@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8006b808-6f27-4808-666e-08d9774d0681
x-ms-traffictypediagnostic: PH0PR04MB7671:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB767133167D4AD0D345D8A8EA9BDA9@PH0PR04MB7671.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4i2BzhjVe70LrKjwM9UZIeq2J7ygH1poCdjgrw/OZ+dfjR2ZdpOD3JljiMfx51cZIbuBsAz9fBqgNCk3WfEpF7adDXKeXSlc836ZXrY3rnbDUojSMgnTMzx5MYpbjqLX9F8WrZscRv5FsAzDd/R8UUG5k+DbscEN3XT8Ci4JvFKuiiNnn2l8Mj7of3oBJt32pD3+8pnjSPGXBEsQGW1HiWOMef1SlSmLvW4FpSMxzd2DAJ8aidn2jLwSX2p902GAa/EJ55EdEuBaTG36X8lefdP0WA/ZCaJkhXLO/O3U9yTl/KQk9qdS9H7DTvR3jxOe4aUxofJgLoFYX+A647oFyXxltVX9XPxw8JTbX1h5s+GSkRQHtYKNCKtWFQkrnjKYds9z5vSl4NUkYG2Nb0BEF3xay+tbeYPY2CeP8LnNRZJkJ8KQv8OaRPgp+8Yud3o2cbhejV/8lRGqI0t+4PMFn4RvA6o3UzYcjUM0sbr+lkJdpapQlxzXZt9GrDiSf+OhnrodXQxxXUwjiLmDU79RTiSu2Q5UwoAaCkjVSAq5qiBsqdlOEh9Ei30oazu3ukL4i8cewYXuCPmsRKy9dXXt126u0p1+vSultRyzlY4V1afgWDoRAZAVbyVTmwvv63yD/EKvE0XD1Dl3nkRn7EBRgj1vYOx7kJZGLa5RhjA0K1X3uuS5xs9JdHxhGtcO8EhMyivvLfHfTA/6vuwR66Pb9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(66446008)(91956017)(71200400001)(64756008)(33656002)(76116006)(66946007)(66556008)(54906003)(5660300002)(2906002)(186003)(38100700002)(66476007)(53546011)(6506007)(4326008)(38070700005)(55016002)(9686003)(122000001)(8676002)(86362001)(478600001)(6916009)(558084003)(52536014)(8936002)(7696005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dTZ91xted5qNZLoD+OwGd7xJmwHnz/6TFf+48GbbJNYgJVd64qh6xzLYpveS?=
 =?us-ascii?Q?HliE1vJD3IsUmWB4kZD+mz6mN0K5lUtvMrb3Op6F5+uNU9yLZVH2Mo0vqkqj?=
 =?us-ascii?Q?hdjd0zXBdxKSXC15CoBT04xfc/btE0RNs+bZN3IerMmWhKVU296gZ+xRUcq5?=
 =?us-ascii?Q?vvL7WfKjlMINEJkFucg/2vhW0vyYur/BOjDAssJOXyDX1voN7JbXDwkq+I65?=
 =?us-ascii?Q?RYYSvSno0roBHtLJibf95/+0FeBbWboWk6YhSVnvlNCybUeCr3w9mGJPAK+x?=
 =?us-ascii?Q?vF273v+lGFO8Z7DqTpvFJAPH/GBBOP/pXV2r5KC/B/5178C4CDIA2NeMFo69?=
 =?us-ascii?Q?cRXA8Zd/90fLdxumjgDVa3MaIuoCER7+W6JWqvZenkQoVgs+bDEG1i0uYeDg?=
 =?us-ascii?Q?bRaDV6MrVdiAMZK08JqDs++HJvA+lMDN4YriFaJr680j4GG9OfAZX+8NuGzz?=
 =?us-ascii?Q?lwBvBk3GJ7Sm2+1vrVXVcBsS+HX/1hXGeKKSsXUe7VMDvzi2ThvKsItprG1R?=
 =?us-ascii?Q?KlML0W0cimvtLTttw9QxauzJuji4lKGwgMCrRRNNJSRdv39YBj9oJL5p7m8Y?=
 =?us-ascii?Q?AdgT+W50WnnvOxuto+6k0hrB4gwIUsQWBKUA51Xx/7ALLj0z6RaGnHkjvSEA?=
 =?us-ascii?Q?ttGu2e0f5WXW7ZxqYc6igM2A71p3SgOAm3Z//XXoDHMC9XOxihLl4LTM0baz?=
 =?us-ascii?Q?4ar4U/bse0y+ibcChUGSFaC7+pf0rNCFmG1bsi8fnw/7+e1bxnZLjxoxZR7R?=
 =?us-ascii?Q?VkLq1tbY2IQpZuS3/PSbQGmj/AY/zUo6LWpBzQoT7P1pFELm7w1cgKr7/XHk?=
 =?us-ascii?Q?K3ImkuUboUispsVl4U2rhhSFcIY8b4bFAz69Hf50YF6rgBb21bw3n3a24DV8?=
 =?us-ascii?Q?Uw7oWVvpvAPAppR5gqTrAnKoNJ/hSI78ffVMVghrp72lSm4beoA5wnqa+aKw?=
 =?us-ascii?Q?9J4T4p8gqzMmhbjy1/vSyaElWjZkMAA6prLmZDuEcExwKO1c2FIHJ+xN4JsC?=
 =?us-ascii?Q?edkTGwzmnDMtWvrL9ASTQdVSeoAlX+nfs6lEY4ZoMV0++2Ghkdtsfu9wMI/I?=
 =?us-ascii?Q?WZwkYaP9r40ZUsYYWQaz2CuZh5qBZkZZkfSFKIWK4ixmViJKIkGyZJPEN8ew?=
 =?us-ascii?Q?IlxfZp8lap6paUG3DPyDSSvuZqNZrtQtVJbyG7kgdGdcXM4AqZRoe6cHMT5J?=
 =?us-ascii?Q?Rwlt4bZDaU2AB5HFsJ4n9t5OVZezqzWfmPA7MnnR8hmDTkVWEO4lAs9FdNLi?=
 =?us-ascii?Q?hKEiJ3Dmyo46TVk2jOnqA18qYtfyJCShH1O2T5nIoUMKUfYGfYen5oNdPyNB?=
 =?us-ascii?Q?V/R9iQhLXjcgN/ztsjlWjZH4anrJUhvN8xhAAzd5nnq0if1M/gQ4yI+2XsFi?=
 =?us-ascii?Q?EL4t/HOTM5SgigaIzpq0su801jmYBhIfVSW28Dx3an/92oYmRw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8006b808-6f27-4808-666e-08d9774d0681
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2021 06:58:15.3313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZkrQVl2umhZGemsi6J8QCWQEKkuQdl5uChzjkkGDDVXe72ls/mhIucBlL63ZYPRBzzPeqh9lZB4scmFwb8RTpkZFfd1+R+sM5zDXp9FQcZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7671
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/09/2021 17:51, David Sterba wrote:=0A=
> =0A=
> I did a few minor fixups, patches moved from topic branch to misc-next.=
=0A=
> Thanks.=0A=
> =0A=
=0A=
Thanks.=0A=
