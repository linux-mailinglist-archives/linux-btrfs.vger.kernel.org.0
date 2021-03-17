Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10D033F107
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 14:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhCQNT3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 09:19:29 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:43865 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbhCQNTT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 09:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615987161; x=1647523161;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1m3cEpBFGZ71F7KANLNidXPIex89j4fht8DTioLdFus=;
  b=dwFxER78U6xO4lOGAquBVmQqB5u9a4OAQ21VujN+CfdWoexctOLhW9fC
   kD3qpd6dB/cqW6/w0ZtXIbJ0v8J2gvkhVtodAULXkhezYvxMwwfrbZH+7
   QY19MfIo7UuIEvKX+Y1ESvnLDELXFTEvwrcPg4ycYV7biNoSzLw3vuN6+
   WAkTxPZ5uNaZZetLSjbxZC0x856KihPW0vQvXp3xJTS71OfsnKILujA6X
   MBk3yJxTrxR2JYHm64v9YAg3zIV/IHZXfo7L3U66yPnKR+859YmBHNY42
   AAFZ8cOuwG+vhsJuNMMw17k/25Cor6xcMYoce1Vox+M4bnEPcmnghACHg
   g==;
IronPort-SDR: DCwDYCuciTtx4sUbdJl/jhxSsaX2MC0WXd7J7xaMTg65vo/XDV0lxmK38jGTD0TInJ3P3GxrZl
 mx3f5GgiCfqKn/LK2XZn0lORLYGrlcktFssgtQhYXG8FDNj8VbgOWELtR0RhJS2CujPEwsHH/i
 zLlCJZWStIWxQUzTvr2LpvwcgXDh4hxUtCeJJdSIzLoBmLSMuFXz/B2a07Cyb1bSq6JrbU0hPm
 YptelDxz0S2NCi32KOiCmIEIbru+NywXIjSZstpV4s/gsum2DJUcdFwic8RR5b91Z6+01wqrHb
 sbc=
X-IronPort-AV: E=Sophos;i="5.81,256,1610380800"; 
   d="scan'208";a="266757614"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 21:19:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=am0UHobIWTef09l0LGelR4+2PQF7xInhxJekXmNvBR3KUxmLtfGzeCNlWDAwD6meDjbIUcIddERLZ1XwQ2hOyKNnL34SV+7hLBKUqDLWDPgLplNqd7b85+wPxJAS+LFdZh/dDLQKRgsd+zKhvw/2zGcYcQwJr2DkMl6O5vjeCo4HBdTDZVSZAFq/CETbX/YGzw3cKF9eOhwQMLCIKZub1qg3DQgDJDa3OAqIufXAQtT9xnbT3CS84qYiknU6v1AY10C7Vfhi/RuNEQDOhwujk7r3UP6WseN60H1XGKVfqXDtSnUSAuIB89GNkVr0OlGpu6XKCAw100ClJu496NFVmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m3cEpBFGZ71F7KANLNidXPIex89j4fht8DTioLdFus=;
 b=OxEmAQM5tZQNAicpDQ/HS8p+WmFbkjEBr3bZNkGgdtrSQjjiK8llXiquxn2GgCN+00+TArMVLptVo1sSYlJ3nXaeVk4X6l48MZU9qYBNMhWGJEDyB0ig8PHmnYIiBEhqMQBDSyfZbjaeAvSvZJlmGvuaGIEKK0E88vd58TWY26yBiqagVrpnMajY2DlKUbqqfN0QkzORyzsi7dIhISk7u36OxKCnaNKwcWvhro7bHX6dcL/31kHDUP3KQYQ/78nmpzkUFee0PPpaapAyQltsmNi11+BDe71rQEXm/SAdg7RTWJc5o0L5zgoOj7Z29ByBdjyLxb1xwI+IO+lwfx9iyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1m3cEpBFGZ71F7KANLNidXPIex89j4fht8DTioLdFus=;
 b=aLpMgPLyy3SV3nVL0OFmP+0O4I2g7YoUrlLTw0ht5yufLCMaQOwvzO0ZUPxAteJOqvTiwSOSV0GRgR2d5kfJ1g6jSZJYrd52WITav7YQ0GsPyd8IIkrX6d+tatQcxhVYdb5vjozHvG5Kd1opDdp/9RXeGPLmFQuABaHFD9Izgtg=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7288.namprd04.prod.outlook.com (2603:10b6:510:1f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 13:19:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 13:19:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: remove outdated WARN_ON in direct IO
Thread-Topic: [PATCH] btrfs: zoned: remove outdated WARN_ON in direct IO
Thread-Index: AQHXGwuXgKGaiXI7vEOD28gRwVSOCw==
Date:   Wed, 17 Mar 2021 13:19:15 +0000
Message-ID: <PH0PR04MB74162ADE333CCD6A943802A09B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <44b2ec9c1acbaf8c0e13ef882e2340477bac379e.1615971432.git.johannes.thumshirn@wdc.com>
 <20210317105156.GO7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:e193:b3c8:606b:24d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ba624fd5-4e14-4baa-b85c-08d8e9474383
x-ms-traffictypediagnostic: PH0PR04MB7288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7288E0B17FC35DDF5F8940E09B6A9@PH0PR04MB7288.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8vq6ZydGafpzc0vRSTJEjQ8igEQ72OMV+EzUu5Eq/w0S+UnDWg44sOtJrOxVklEGpjshzV+9ohDcadYlakWPJjyU6uhL+1tG//3Xz5VlHNmwdOc4nqToEj3U3d6a6xihxtHbwUEWi4n0AxFm3KqbtipSuC7fBALhB+l8A8EgJNJNmfhap634R6cczebWH1/hz/gaRnqOGjwEbykgc7ynK4XrOzr5jHDaJBk19W0JMaUXzLnFDRenH38VLZY2pjzgrVnTARzO0Yisqowm08641O/7bVjHKdIrCV38sK+3NrxPoNVm0+iGRfF/bEjinnQClvRSq8C1XXd+pfRZeY6aoiKMx6hWc5EtABm5VimNt1sE3ZAhurDuowJF5alfJgYC/2s83lIVWwfLDXHuyIeK35hQrPELdZ5teZi4mEffmbalUihKICmny14iEHuYZP7kL0YjM0RJZJivL0S31bv/oxzw+olJ2u5dr3MNEw5CvY+jeq46EKmBjy8G53LlhbB7y5lGBGCAo6Cdso403Y9hia2DvwY8u3UBLJDKNlb59RrLrOiQ6Di6VfoZsq47hwYY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(8676002)(7696005)(54906003)(5660300002)(6916009)(76116006)(66946007)(55016002)(9686003)(86362001)(64756008)(52536014)(8936002)(66446008)(6506007)(66476007)(71200400001)(186003)(53546011)(316002)(478600001)(33656002)(4326008)(83380400001)(2906002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KBAAtjtPtieJuxKiVtKheCYagHcFSngdNrtI1HBCM+pdGIxVq6jTsrtlttnE?=
 =?us-ascii?Q?ZYTzrokupG6fu/6r3tCDZvDzhnSVgasRboc4WPEVOALNeJxfYMWsJJ4XNWyb?=
 =?us-ascii?Q?snoss6XjCPKDKdQVZ84wtSi6Kplx8p1Ww/IBHIiM8amdxnCAqUVB9K9GIpV+?=
 =?us-ascii?Q?JAND3hnENcxR2WJCBgqu0I4Af3Enu98vsOOYz3HnvyZWeIWuKrYYiLqzeOyi?=
 =?us-ascii?Q?MNgZnVTPlSGPn6ek472eq2EDW5ljnVHD87LDrgl3hUOhXNtFTM9tY1edLjcH?=
 =?us-ascii?Q?V+oMOTRdOoUrGPRZVGhsPjACgKfTdokHgspcqR5vkTRzlRYfj+XwsBc7K+zq?=
 =?us-ascii?Q?bKEE4FBz7MJNK9XcJ9jhbbEAj4xH9umRIYX97V56ni920BC2pX5yVb9m9mC3?=
 =?us-ascii?Q?9j42ofV6GQfFi/IiOIEpZcn1dsbKhu+8fJKdqBII3zVbGTbkx2gGKSNNluRv?=
 =?us-ascii?Q?eVisDuezop/azOqQH1ZzAWsI9U+XKWHz1DfHeQuSEXrpFz2N3qmpQolD+fdC?=
 =?us-ascii?Q?i31yLg/swZPw5YfHXiNj+lkpHucE+1YhSMm5NA1Pe6A3x6G+FqilScpNeykc?=
 =?us-ascii?Q?V74rTjW9qJal8n/XkDbPGEQbZDso4fynKFOs3AnAeMyFNKWqPLikVpJU84kZ?=
 =?us-ascii?Q?P2zQR6bSrgqqVHIjtji0cf1Z7TnCL724S9jlnZYmq8w1/ouXHUqDnTJYQShL?=
 =?us-ascii?Q?nW1GJGpaI0OsqEjeRcFyz4PKLc/p04zRlX55SoEZTyImlJS2/1BikdSL4TrM?=
 =?us-ascii?Q?q81DbtleOTTMmU9ZUG11QsuBw2d3QFqZHJ6GB2xPYw7BeJB81V8M0IugfBo0?=
 =?us-ascii?Q?ITOcRnE+dPdatHr4otbns6RP0Mkiys6N2klTt3AkB82/o1SWkxhzyHyd+d/t?=
 =?us-ascii?Q?qMdwCQE1t3Dc1iMIysswuL49+ZYQy0IKs4sfsY6m8ncheRmjt8WhZWYwtgGB?=
 =?us-ascii?Q?hi3fyAqiib7bLKuEKwhAJkg9dkIxk5GPxYUtse+azaf82T4rn5wpGqhyy19G?=
 =?us-ascii?Q?aKUbMMIEyeCpm6WQfYpDV43LEuKrhNkxhNizgnSkXCja2IxUED+SK3KkoQo+?=
 =?us-ascii?Q?ResnvBjGwciN51hPJG/PKGAAez9YJTy/Rt6KzNqRjbPvfm6gk2qiP36G9WFI?=
 =?us-ascii?Q?2f/EuXSR6DSeTBL/sr6+JzknJMzLThwZCKnur8b2eVXM9PJBQpV8mzTNFIcn?=
 =?us-ascii?Q?Ro8GpdZw8WJ+bk268MgkjsibvfAjrvuF/vbh1W0xzC5+nCU3Eb6w2lz+Bgxt?=
 =?us-ascii?Q?beXJKjBMdgn2/EiG99D5NfJL0reYrq35mVZuWpTMyWPItOlb9fld0bCwjyIl?=
 =?us-ascii?Q?eNP3g76FH0l51ou0w8b3SUIeVoy/u59RYcv4G1KmVr9fMuo5rXQevPHXztWi?=
 =?us-ascii?Q?BKkRxWJtplNRFBj8/HAEEAehgAqeXxrM6AB7QoFbNRfA1+alfg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba624fd5-4e14-4baa-b85c-08d8e9474383
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 13:19:15.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqHq4XViRq8xywWDq5AYHMumuGdPY+jcw8OnWBE+vGveAzK1e5IrJzFyWH5PWDo72ABg2qgNcTP7FCGJ20bccZEcFe1WQNOZ4NeQn4lAQr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7288
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/03/2021 11:54, David Sterba wrote:=0A=
> On Wed, Mar 17, 2021 at 05:57:31PM +0900, Johannes Thumshirn wrote:=0A=
>> In btrfs_submit_direct() there's a WAN_ON_ONCE() that will trigger if=0A=
>> we're submitting a DIO write on a zoned filesystem but are not using=0A=
>> REQ_OP_ZONE_APPEND to submit the IO to the block device.=0A=
>>=0A=
>> This is a left over from a previous version where btrfs_dio_iomap_begin(=
)=0A=
>> didn't use btrfs_use_zone_append() to check for sequential write only=0A=
>> zones.=0A=
> =0A=
> I can't identify the patch where this got changed. I've landed on=0A=
> 544d24f9de73 ("btrfs: zoned: enable zone append writing for direct IO")=
=0A=
> but that adds the btrfs_use_zone_append, the append flag and also the=0A=
> warning.=0A=
> =0A=
=0A=
It is an oversight from the development phase. In v11 (I think) I've added=
=0A=
08f455593fff ("btrfs: zoned: cache if block group is on a sequential zone")=
=0A=
and forgot to remove the WARN_ON_ONCE() for 544d24f9de73 ("btrfs: zoned: =
=0A=
enable zone append writing for direct IO").=0A=
=0A=
When developing auto relocation I got hit by the WARN as a block groups=0A=
where relocated to conventional zone and the dio code calls=0A=
btrfs_use_zone_append() introduced by 08f455593fff to check if it can use=
=0A=
zone append (a.k.a. if it's a sequential zone) or not and sets the appropri=
ate=0A=
flags for iomap.=0A=
=0A=
I've never hit it in testing before, as I was relying on emulation to test=
=0A=
the conventional zones code but this one case wasn't hit, because on emulat=
ion=0A=
fs_info->max_zone_append_size is 0 and the WARN doesn't trigger either.=0A=
