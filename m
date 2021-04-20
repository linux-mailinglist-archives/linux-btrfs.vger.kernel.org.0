Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C26636625E
	for <lists+linux-btrfs@lfdr.de>; Wed, 21 Apr 2021 01:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234280AbhDTXKT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 20 Apr 2021 19:10:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44973 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTXKS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 20 Apr 2021 19:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618960189; x=1650496189;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2g8JveUJ5ipTD+y2tDV8BxaMXGhGX/F7HpliekmQjs4=;
  b=BhO4XlEdGP5sFYEammv0x2yJ5D1e21j0yn+tKL4E4dyJSmQIktRHSuil
   DBmbA/rrzqsWztOqflv7if3uhVYnbov88HVHT0+xQMhMPVlly+A4JIIhW
   NPTGlvZVOYm+HBVjsQdqda/27xPw1iFgtLgwMa3msTC/MwLX9nUW8SX82
   uAjiEE9kdwacWm8NiYhtYetqGUFlEN+1aXmUNwnWFOKWHjWbLI3T7A1Ec
   DEbTkCE+4p2N8okhDHMlT+gt1GPLPqVqZRt4llkkR6G7X7rys9W3ZYHp2
   Mkepugd0B4bTVoyW3HZvQ82SkWZ4lfpfqku09sxuw/cpw6PqlXFQ33Hq1
   g==;
IronPort-SDR: gk60YVWJzvXU4JrDqi+8NzSBI6XBz62cuB6UyaPnyJc5z5v2d+uyzAaeGsZvp+8tXEAj3fS5qQ
 /dUAeMcFhJREgNFXkcJbCHD1XTU1HeAQysVXUYbZtbdWGIFPUtpodfrvc3NAmowzPH/1ykM/4a
 4URbcG4F4UxFIux35y9eWS8vfhRZTyGRozAqwSiqwEo8w4jkkl9O511cy4ACnv5Jvua+vJ8MnA
 uS4D6bW2eDcOQJKgMuK4ig8BffZRUSkgQjjFuE9FJs9IVnrmsrvdDVJn9URhjY/wxBbpn83r0a
 vIs=
X-IronPort-AV: E=Sophos;i="5.82,238,1613404800"; 
   d="scan'208";a="269541833"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2021 07:09:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX7nk+m5twDhGbvZb87ocXZHY7pmnA8ufPmyLZZf4+yj98W+lxZtgYTi0QcpTmAYhgU6zwnzwnPiAajfITRRSUB/RzBP/6lQjjHbo4h3TtgE4EB38s2ET8f+sAHzFTxCQsmeZ37vTdxTj9nj7k+r4ttWCpdOBbKb+X+5QWnvP3j2rj/jRNFzDiIGTrYksWfCZ2/OeMdwQFKt47fy3g8q6Dnw9cuADSnhUqTc6IobT9rQxgmfh8yWCHHN5wvlo1JO6vbCnQsvKsAKT1B9I7bLGQRKxs62n7bF0/C7N5pHS+ZSGP2HVhkTAf4tjNZywagSSco1tAHjRosLFoN7JXRHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g8JveUJ5ipTD+y2tDV8BxaMXGhGX/F7HpliekmQjs4=;
 b=YPQEKzg2em2JVYBSVlf6FMfrD9lBuFngS5Z9Q7W5Was+Bg9CgWpAytYchuANhl13w9hk95o8RmFtuxeHo7KMHXQXI7+TNPiRfu83z2W3msQ/YvwDn8xp2wi8gOT4spFB1Lh3BjUMSQ1Odq/ZSYtn7uPd0Wyzh8pjRovxp16vLOW/EpZ4KqI9dgxTSm8CW/WhBtABaW67+Tj3FZUplg9ty+I5tvTp5X3cxqs5vD0yC5+8yy4BnIwAJ8eg58FAVcHTfTjcAN5c6xaNZIvHHHxw5MrdAiUZYO4BIHjhlvx3DhLBxzkk9t/kGDQELY8lUo7OjNpGwnUJBpeHM9rcAJ/I6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g8JveUJ5ipTD+y2tDV8BxaMXGhGX/F7HpliekmQjs4=;
 b=DYUGS0pjl+bvVvsT4MHIa9JFz1ATnrq5Wj2e6tIurDvuwl3+CIZOscQjn/wgAPkZ9TKI1G/27a7zyRtz4+In9xgPaAyxenhXsnJpyMYjfUggZGdtfdYlh+C+Fukp7WJiIa7/JYYRV3tRCUCRCITXM+W7HEZsYQ437Jbrc9wfr9U=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6349.namprd04.prod.outlook.com (2603:10b6:208:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 20 Apr
 2021 23:09:43 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 23:09:43 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Neal Gompa <ngompa13@gmail.com>
CC:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Robbie Ko <robbieko@synology.com>,
        Zygo Blaxell <ce3g8jdj@umail.furryterror.org>
Subject: Re: About the state of Btrfs RAID 5/6
Thread-Topic: About the state of Btrfs RAID 5/6
Thread-Index: AQHWgTtjpPLWJX7Ul0m6FtDMpVpYhQ==
Date:   Tue, 20 Apr 2021 23:09:43 +0000
Message-ID: <BL0PR04MB65144CAE288491C3FC6B0757E7489@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <CAEg-Je8OsZjWU_ZyLJHrbOJb=_C56MOmJ5w8UUbzz3JNuAi5Ow@mail.gmail.com>
 <b9ceb790-e376-69b8-0648-56c9a026b40c@toxicpanda.com>
 <SN4PR0401MB3598C82C1186CA04215145489B2C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <CY4PR04MB375160CD68787A04EBB29ABCE72C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <CAEg-Je-YxacuE4OweeAixCBV-RAGvWzNaKXcBoEyK_P2QcG6qQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3436f29b-8349-48cc-c0be-08d904516259
x-ms-traffictypediagnostic: MN2PR04MB6349:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB6349995A11F5A6590C02179EE7489@MN2PR04MB6349.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ezi9QRd3161v0hSvRjeh3VZkdo68ieJ02p8q+DnbhIchJdS/TVDCaymBDQTNlXjimTzNWq89Q9wCSMZOTt+V7k7HK88eGagb4fgggk+ImleEkM8UBOFvwVcE1LJjU3tmVZc1v1G+fGXYuQEq6SLdGexynBS6wU+lqHi2+4Nl+Ig9UQOZgdD93e1BkVQGmEB0njlFfIMx/n8S8fbWbobKzqU4A5fiwjLv/VAGF8m5QkHN2OXqO5oq2u/hQnJ8LOAx76yt0WXENhTekvg4XGKnECrJmyT+Xp+6vvNayqCxZJeUzJiNAyPCfhq7rlbKInEucK834uLs7755AzRopx7Ug2NIkOQpDEEIb/SdwmRfy1h3eLgx1yodUijSqeIlMSyAtYkytcrgjRsu897Av/xM3k4OY/viXOPcnqVpI/4Ll5zUwUf/sA3q/Gne0p7jsK/8XfpNv8oAi88T7FuNZgvrsC/cR4WZRcwzVAYkaT2SvrSM/T8kfpgHkaon65IwgVpT2svYMZI/OdwUbobgJfBUbID5+3gZsrWSOUxXhVO7u6xiMbT0Txd7bcNebO0SLnRiHyZBxM5QYfs3is4/IKb9pa9m2r7OF6SnLP6n0DMtxIc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(39860400002)(396003)(2906002)(316002)(26005)(54906003)(122000001)(4744005)(8936002)(5660300002)(53546011)(6506007)(52536014)(186003)(55016002)(9686003)(66946007)(38100700002)(66556008)(66476007)(64756008)(66446008)(4326008)(76116006)(91956017)(33656002)(7696005)(86362001)(71200400001)(8676002)(83380400001)(478600001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WiXSf27yo5q+UM3qvI9JltuV00ggVxf8ot2CJwDJqduNEbKx1LPlBtuTtX55?=
 =?us-ascii?Q?fItI+6FyiFJXAjgTRc8JCJrYHAtuIBUG4vSpEMH1efHUGbxTPbotujDpKB3f?=
 =?us-ascii?Q?zccl/kNMrszGKefXOlCtwxOu1xvV2HEukcT9KT4A4XbLtCR8cPSdglF8jdYx?=
 =?us-ascii?Q?cl5627KIarJ9Voz80B7Kt9shbW58SrvhnRuihpnT7IaUZE4Mp1ikqKDqwi/5?=
 =?us-ascii?Q?pSoCxn469NUatPqeNcPWrumy2ZEj3pso348CZkCSs4jLWLWgVfNmtwAZaV2e?=
 =?us-ascii?Q?abpNMsieru0eHjg1Cui94PsYP9zuUrXDVH1In57LpIRPtE7t3xAdWiW9iBS4?=
 =?us-ascii?Q?9aPy/+pHSHzRGBjhp3jCF3DN14saywOba58Cg9vE1boRaVmDCNHX1VD/L/kF?=
 =?us-ascii?Q?uepq2vQr4aP4nJLrmyJ4cnPyX2sqTMIXQ80DkXCWxXTgzmOedcX+B+3aV4IH?=
 =?us-ascii?Q?ZId/FHlljam8Dkksnqghsu5xhaMqZBcS3zcCRpGxbdfjeBOfomQWWVpwTYhG?=
 =?us-ascii?Q?qdZ7ezvUm7exGZHALXtaVnaVrXOb3oOqOv0oDisLJG8Goode5UbdNV0+RziQ?=
 =?us-ascii?Q?GddU+p/BkOVH2m8KK+IqfSQebwb2YTZf+RdVntjubibCTm3ZiLFAsQ9Lsq/1?=
 =?us-ascii?Q?YPGKUpMbejyEBG0WwpFkqG7/bQC3OeqODov6E4vIISwzuyL7tmorI6yq+MTa?=
 =?us-ascii?Q?qiXES3Brl6cxcVJhDQcvnMRuHIycU+2f69JlXG/QyaJazBih/8rFWGcin33I?=
 =?us-ascii?Q?voETLFPsmPoZPS5hOHi+BWb2hBpTm3JvMm2sw2Vcsh1eDsIzpiJsrDFTE6rS?=
 =?us-ascii?Q?X/1Ioena5Kd0y4KA+29jvT0EjpVZruFxeoXUAzQCvTf7pVPvRg1HLaQOtboq?=
 =?us-ascii?Q?yKKrVFcelKMuZRA2SquiDi58ZhMJ670FFJ/3wsXtGVnnBiEJiavv6JRknAsl?=
 =?us-ascii?Q?OE7odbivKGI/jXVuVVu+MMB4Bg/AqOhU67LBCoV7ilM7LfAgJSRMjmJbwXYa?=
 =?us-ascii?Q?iAN9npwgDiecAOimilTPyCPu0WZv8oo5LE4TLYO2ZoCWT9KHIBZ902YR3sCl?=
 =?us-ascii?Q?Kt1cvHDEag062T9Ha2H+dBD73saVBTKE0kc7HNYLkm2l3TnN3+u3rWw2HWsr?=
 =?us-ascii?Q?bVQ4FU6dg1yE8MhfXTCiRh/Is7gpxQ7pNOV35EP+MyYw9RhGhQ5bxTndLOyw?=
 =?us-ascii?Q?ObMaLDRcIMK3kiJFpumXRVWC3pFRZ2/oR3JwBnIx/N1ztM+F2kMKpNxRMUZk?=
 =?us-ascii?Q?DAYFYaxfxCW1xUKVB69IkpPIhKVYZw4D9FYM0kc9Jt34FElr/QNRxsh24cW3?=
 =?us-ascii?Q?svG4JhK0Tr/Qu2qFB8frmaaXRb2MYXPcuewzLB+Mi/WfsQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3436f29b-8349-48cc-c0be-08d904516259
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2021 23:09:43.5759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5+6iKAFjke++x5NdQ3tta8wfrfXLXg5f+NCx7dE46RRJ7HrTnTuL82N66Ah+JGEXGu8TzvJhhfEvaViu1BBcWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6349
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 2021/04/21 7:33, Neal Gompa wrote:=0A=
> On Thu, Sep 3, 2020 at 4:50 AM Damien Le Moal <Damien.LeMoal@wdc.com> wro=
te:=0A=
>>=0A=
>> On 2020/09/03 16:34, Johannes Thumshirn wrote:=0A=
>>> On 02/09/2020 19:37, Josef Bacik wrote:=0A=
>>>> I know Johannes is working on something magical,=0A=
>>>> but IDK what it is or how far out it is.=0A=
>>>=0A=
>>> That something is still slide-ware. I hopefully get back=0A=
>>> to really working on it soonish.=0A=
>>>=0A=
>>> So please don't expect patches within the next say 12 months.=0A=
>>=0A=
>> Come on... You can do better than that :)=0A=
>>=0A=
>> Joke aside, once we are past the zoned block device support (new version=
 coming=0A=
>> this week), we will accelerate that work.=0A=
>>=0A=
> =0A=
> Now that we've got ZBD support landing with Linux 5.12 for Btrfs, any=0A=
> chance this might be looked at anytime soon?=0A=
=0A=
Working on it. But this is not a small change so it will take a while for a=
=0A=
patch series to be posted.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
