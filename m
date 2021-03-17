Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2FD33F2A1
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 15:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbhCQOab (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 10:30:31 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:59425 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbhCQOaV (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 10:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615991420; x=1647527420;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=CfFOi1BlEGZrHWzoL77hTGP1nOugRfmPPOVBkKqup28=;
  b=TxrLqW0R4CLLRK5Z4S5Mr/xAJG5H+G3DNIiUGgHjIHsUEabkpwnIW8C2
   H9/geIuZa4EKdxBJ63PvXuTL6h9PP/2NCjMBZLEcIn+pxOpu1pOnBLLyi
   hbGcXM4eJK25Mt5ym/m68cLdc6KZHa2EpNOFLr9IN4NOypRb+s4w6XyI0
   sc2TK3mCNPeJW0UGpeXI2qpx8zjql9/YUPC4Q6cGkKSsFBD3FWgsP/Gqz
   YMrd+Fi8HinHlBkojaCS4KWSRGD4rlhkq4KnDF3OVQV9m76OgoFFU/+q+
   6ynl6PISAh+/DJmUT54R/PnUT9qhaek03bM79dovHNdbWkNUqgLOrGKoM
   Q==;
IronPort-SDR: rRoGw0RbZ8Xr4xDho830SEawP/FPi26iS6XLLtQMvoErPbdBN1WVoDbHUNG5KVvVRbAsCCqiig
 Kr/xr8udRNArMynDqEUGtXQIy2UFXmc/H7erPjbvTpTIwQnIpI91joj9JDJ6BJsIHV+0xxFtBe
 S1KDVTVN7YqCgDQA67Ib7DW1EsycxTOau4uG1zKMnaiBz+BB4znx4eLAoRdErQiVh2bWZql+ia
 VTkQdj2XN+IWxRjfQkDZpW9HpqbIYMUKxgNK61FkSaonozbr2Y1RqfsG9LzOt3q38z05yDxEYW
 wws=
X-IronPort-AV: E=Sophos;i="5.81,256,1610380800"; 
   d="scan'208";a="166855898"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 22:30:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LakxNXNr/whoiM26jngqM1x/a8K3TEy8MdIbH/wdJs24bs/mYJgEGcTMdbTQ80Cwbs7hFYcK9Mnyj1m0TGGrGjA3jNwH76QWsLWQ4IDhoscTkasoOLcSJKFsp1jGI31doA/64DOnzkkU8SrZ7VMY6Qr/YAJ9CzqvSDTIMSPcZJJhbxCNOTlyhteePbmOvH5phSlkf5fjuffWVcAB39ooqkQktuLQfldBir4wtHS8KHpZzeDNM4fwp7sbc4IDTqfwpr64zT0ih0k7mh9ga48ySe7Z+uUBXTVx6A80naUnyzU8du/97ieN81if+QuFBB5Rzcfsg4KDA75m7hflRiZ4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfFOi1BlEGZrHWzoL77hTGP1nOugRfmPPOVBkKqup28=;
 b=W/wCCngZ8wHj4wrvor0Z92Sz2WoYpxXVGqZfOmxyAr5a+kXJhLoEk2346Wu627lsIXcVE4NCowatFSyGNyKgAsDzYHHs/vDCYM/TQzXPaxnu6w/puEnKmGLC0W1PkkLp5lAJ4rtcPSoRwmfk7WJsXOrlhUe8yPbW6e8T559FYD0rs1+mVjZXcAngykqV7YyDiGDbcxXqKBwCRGb6X8h1S/O6LOYk/A+RwZd6z5IbP+KtmXvpXnVpWOgTgbJ4ve1aW6mCXHuLF5qN6pznK6FFP4r2RPP1mW0W3r3MNIzcH02VWn1UvMxxiU9rAYDhWoOyFKEsvcd/rInvtu2u7hfRyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CfFOi1BlEGZrHWzoL77hTGP1nOugRfmPPOVBkKqup28=;
 b=uucxMcExHcyA6gFKpaDnjbXVqSZHENmgKOLTD1FTjEl9htpoWPeLmRGOKrS21R2ojRRQZ6ZSmC80SmYBHGardYhwvgj48kgFox8Qx+lxTfIWUKACkY3OLwfz5kBbJOeOHBKMcqOPM2eea9Ep8vVpA26dObrt8htI8+Pf7wgBGy0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7446.namprd04.prod.outlook.com (2603:10b6:510:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 17 Mar
 2021 14:30:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 14:30:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: remove outdated WARN_ON in direct IO
Thread-Topic: [PATCH] btrfs: zoned: remove outdated WARN_ON in direct IO
Thread-Index: AQHXGwuXgKGaiXI7vEOD28gRwVSOCw==
Date:   Wed, 17 Mar 2021 14:30:19 +0000
Message-ID: <PH0PR04MB741623816235150E51EC8C889B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <44b2ec9c1acbaf8c0e13ef882e2340477bac379e.1615971432.git.johannes.thumshirn@wdc.com>
 <20210317105156.GO7604@twin.jikos.cz>
 <PH0PR04MB74162ADE333CCD6A943802A09B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB7416C9EB06CEE0A47D66FE7E9B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210317142745.GS7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:e193:b3c8:606b:24d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4e336d33-4856-4a68-8fbe-08d8e95130b8
x-ms-traffictypediagnostic: PH0PR04MB7446:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7446962AB077B3B1B22979709B6A9@PH0PR04MB7446.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: njDSnkiU1VaRWRIPOuKrnYXv5henqW0BlnvLJeLmdw4WduNXEbLG07LwBVQO1uEye7Nz1NNyjYnBGzmMq7QYfyzsg7Jby9DwJu95UDtsfkxpD6Zuv+IxS8TvtfHMmqYZs8sM60gr//L7ncCs/jo+YMlvYvTUz0r8i/eAKdNNQL2WM0s+ked7rFGoDS3CHZ437u0hqroLlexH+6tcjCwp1qN1VpShRpQsE2I1c+JBh3PkkUfs+yDSdtJUz0/bh1Q4Mmb6epmpIzVCA4LdRZnfvCoAM9aVTvRVZmwlg5/ee6FBtTjlgOyQOqbhjy0Jbmgp7TyGGhNGhYOWnjiteJAmVSjaMfzaA4UT73c8YAjDEbYVFgw45qFGFgtHvz7mwq15Vkbuo1JNrp8zY0rJNnX3hJJhO3oHwuJHtagvGmruHF/zDxmsdmGP3bzvSitIeFysy2cDUqbvTzzo7aXEefZgO9BZzy3zu5bNRzqC60AwNGLYofFb+A3fxPGEXSBWEMI9WdXrYPVsiCO7oBTvmTLWPIjXD4WVo6pgOJ6/Ce0kaaGnmstXG3bwYrJbDXztTFRB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(86362001)(6916009)(186003)(478600001)(71200400001)(4326008)(52536014)(55016002)(9686003)(53546011)(76116006)(54906003)(66446008)(6506007)(64756008)(66556008)(66476007)(5660300002)(66946007)(8936002)(7696005)(8676002)(33656002)(2906002)(83380400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RavxmzZPNk+eDmv5qVt8CMTKrUzwKBn6ZyPwaeP/CUzjarXk/oPDOm7xvFfd?=
 =?us-ascii?Q?dLg4mLI0xr5OURKzIQAE/omXreDrIriUGjOkCn2fcdER7iNTqj/x4fsef8JZ?=
 =?us-ascii?Q?dQbBgs5rGdeVrm7RNe8QTFA0mklD6dgUVeAcDWTMtHYEdfVsaOd34kU0wLza?=
 =?us-ascii?Q?99JoyEqZz/2cS3XuNU4XIMf+9BBg2L6OkyR504MUARtMeHCujadcBFClIxid?=
 =?us-ascii?Q?p3dxYDxbQjqA0GfMNoXY7/3iFEi26gopcXvjvCZ3HFILjBoWJQIfmNNUf5NE?=
 =?us-ascii?Q?DEfAyFxczdhiHlIB+MpC9dmeKHGIbK7Se+XKtzS7mSjvUyR34IrbQjEbXqjl?=
 =?us-ascii?Q?LJizwzoWEJrwtJNLkjRqt6cjoppCxrBdp1N6VvkOCe2GcxEQvhy1DcrUQz/X?=
 =?us-ascii?Q?M0CftKpkGv4KE7lN/OTSVVTbJC/cmCRlOizxuyWj3M7Qq4gfB2Z3CEHvd7Zq?=
 =?us-ascii?Q?H+OzkL3nIYUh2PKogaJWVpOKBH1Nn9SyvZIeUKLCyuTZhqgV5rQpmfNJY489?=
 =?us-ascii?Q?JrcRMQkyNMEnVrXBrAbajrmpaA+lig3S+/0RAfftDdnGYfRixSEHQFfqRchd?=
 =?us-ascii?Q?l9wTSM5McVrkKKUtJFb2PKC+KfEna1uJdJJfvFxwdeTTzp0+6Futso3oIzOL?=
 =?us-ascii?Q?OH/YX1krrRO1M1tFsYub3TRRyGqWzMSNPffHwamGH6oBQe2xGRVmqVjQfE1u?=
 =?us-ascii?Q?/EM1aGpixb7xkrD57jBlYgng1QQ46bIG0Idp960aczfBWz8aEiBZHMV8SJdB?=
 =?us-ascii?Q?ZhnZR9tq+4wzN7zQp8ekUEXtcJGKlQYga/mBBS8FQtFictWVducM1Yseb+WC?=
 =?us-ascii?Q?fugrjEP/uhEr+rniwiIoqWwbN9YTra42eVYEoLSFk4hOdgHcmuSZF8hNEjE1?=
 =?us-ascii?Q?fzSRUcevdCetx5zIrMuPM9PxqMwOGQlgomGKxlcRCh5NeUoxA7aO9ohANBZa?=
 =?us-ascii?Q?i1l7L99akB6eAdddni+RfH282ebDSkRT8FtOCEp9cOkyFOmH8u/FTx0Cwt/I?=
 =?us-ascii?Q?Lb9/Ytnl4EXQ+snMUOTBo0RQtvJJoE2U37+scDZbb2EaRbD/b0Q1CZ7pMa/N?=
 =?us-ascii?Q?S/rm4JSdFtSm9KdPEFxxdVsIWsV58sg8nsboq0zcUGXsATuZHR9Fi5iiT7Ru?=
 =?us-ascii?Q?9YzOWuFP/rh3SttpS3YnFAUWZV+L+cthgiJI16WVtVqjV3d/qv/yg4QmLOVE?=
 =?us-ascii?Q?htU9lmscIZdbGU9nKy+8mASEyJ0Mljo+xr4e8n42xgc7Be9+PvKAtz8C0/rM?=
 =?us-ascii?Q?UMRSLuQa66vONKIJdLcaIAKv+tKAWaoewmIADBTxHzhMc7Deqr/EqpEJGa+T?=
 =?us-ascii?Q?bApGMMNzsJEPV1mbu/BOTcryef00Mil/V0uTbkrH//SB+aE8bP8HPBCq5XS0?=
 =?us-ascii?Q?F9MSfSeN+8V+kSFGAmeEfa8Ybl/NQ+Sydz2XcvKwjTJN8x9sCA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e336d33-4856-4a68-8fbe-08d8e95130b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 14:30:19.0257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYgk7wGMHm8Hy/o7HQ15bMcMqrKvcpMdNK2e1tGfxODOXqTFs9w5eIjiDzoYN+2yFniT2h0VOZ1P13Q7BPnwFUrvl5FVJyRevUr4xwVdH04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7446
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/03/2021 15:29, David Sterba wrote:=0A=
> On Wed, Mar 17, 2021 at 01:22:11PM +0000, Johannes Thumshirn wrote:=0A=
>> On 17/03/2021 14:20, Johannes Thumshirn wrote:=0A=
>>> On 17/03/2021 11:54, David Sterba wrote:=0A=
>>>> On Wed, Mar 17, 2021 at 05:57:31PM +0900, Johannes Thumshirn wrote:=0A=
>>>>> In btrfs_submit_direct() there's a WAN_ON_ONCE() that will trigger if=
=0A=
>>>>> we're submitting a DIO write on a zoned filesystem but are not using=
=0A=
>>>>> REQ_OP_ZONE_APPEND to submit the IO to the block device.=0A=
>>>>>=0A=
>>>>> This is a left over from a previous version where btrfs_dio_iomap_beg=
in()=0A=
>>>>> didn't use btrfs_use_zone_append() to check for sequential write only=
=0A=
>>>>> zones.=0A=
>>>>=0A=
>>>> I can't identify the patch where this got changed. I've landed on=0A=
>>>> 544d24f9de73 ("btrfs: zoned: enable zone append writing for direct IO"=
)=0A=
>>>> but that adds the btrfs_use_zone_append, the append flag and also the=
=0A=
>>>> warning.=0A=
>>>>=0A=
>>>=0A=
>>> It is an oversight from the development phase. In v11 (I think) I've ad=
ded=0A=
>>> 08f455593fff ("btrfs: zoned: cache if block group is on a sequential zo=
ne")=0A=
>>> and forgot to remove the WARN_ON_ONCE() for 544d24f9de73 ("btrfs: zoned=
: =0A=
>>> enable zone append writing for direct IO").=0A=
>>>=0A=
>>> When developing auto relocation I got hit by the WARN as a block groups=
=0A=
>>> where relocated to conventional zone and the dio code calls=0A=
>>> btrfs_use_zone_append() introduced by 08f455593fff to check if it can u=
se=0A=
>>> zone append (a.k.a. if it's a sequential zone) or not and sets the appr=
opriate=0A=
>>> flags for iomap.=0A=
>>>=0A=
>>> I've never hit it in testing before, as I was relying on emulation to t=
est=0A=
>>> the conventional zones code but this one case wasn't hit, because on em=
ulation=0A=
>>> fs_info->max_zone_append_size is 0 and the WARN doesn't trigger either.=
=0A=
>>=0A=
>> I just realized that explanation should have gone into the commit messag=
e, do you=0A=
>> want me to resend with a more elaborate commit message?=0A=
> =0A=
> I'll append the explanation above to the changelog, no need to resend=0A=
> unless you want to add/adjust something. Thanks.=0A=
> =0A=
=0A=
Thanks=0A=
