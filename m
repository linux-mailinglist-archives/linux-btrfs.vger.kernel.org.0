Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0C358791F
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Aug 2022 10:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236403AbiHBIgs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Aug 2022 04:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiHBIgr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Aug 2022 04:36:47 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A552FBF43
        for <linux-btrfs@vger.kernel.org>; Tue,  2 Aug 2022 01:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1659429406; x=1690965406;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XZtOgkJ6PdfD3C4p4/BMDtE2Aa5r/S2Ii2kI6YNrifM=;
  b=J5CfTZfkdvCLGE3gZU8ew7XbvsBzJ1m2ZkYmikTFnj+nIpWIQXSvGcb5
   54JV4/CN87iAXwztfdJ1tz4h4qNPalwluMCO2mSnsd8rHsBd+Afyjf4cz
   QVS/xrA8g8S977imBRc/57Oec78nNCIRrXodpHUG5C2jTxLmvz4x/EU2n
   fRzT28kkyTq8+WqU/F2gN5LI+OJYm8P+zTDBmlfqqwyywOorcULOsr+t0
   WDPBxS9GbYawgtS3QZv0XBbHWdJRBgteAUSP2oKIuCeCz3fsXG23X0fam
   Y5nhP42TY87B6m5LtNqTmK641mPu265ZVbfhh4IqdnWRhqdKTMkZcxkpj
   A==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654531200"; 
   d="scan'208";a="208146926"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2022 16:36:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MprmJsTkbPRANIEy871bIbyNvK007ePN7FH70HFqYjVNXmlGbDkGjRvYq4ywuBFCdiUBSGtzVCo2kyuCKKHQIwWF8aTTcsUY+upZYrjxCGzbMH3YOQrnkEdmyuYfguk2+FuOyBJfzizhZDk5KlA6HbWhO3+XJ0SqiOiVwE1Zc6h2i3H1395ZVA6Lie5/Xa7gnYiZIyJVONmvjmEWvxpQwZZ74MoPoTRVqXCZmFCyba0PgjwHu2xve8Gw2JHQDkLN7cgw9qKSSEX0jsAKU684J/ylbyZxXbNA/z/TEK6YRvFOfji4GhyvqFyWyU/WWJcfANVWBYQCugCJ3mCNUoFdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZtOgkJ6PdfD3C4p4/BMDtE2Aa5r/S2Ii2kI6YNrifM=;
 b=RGviFLNcfmdu/5/wMPSsbKowraURKsLssDs9MeZDuRl82llgng3sDcTicL3bGRwxrV350e554cwlaFUoclscd+VtAP39dNZZbqEGKNhXetOSM4XRchwPlCFaNqjzx0nXi2VyRYQ5s5kR4E5vyW7t2+zLSonMpBkTKlZZKfuNiAP4Vas97zaCJ9IqPHhPNAqDY5cXXqr2IV2y2atGORKB0amoJSQrtMKHd5raQeA0uJ9mNj9bv/E1GimvdXL3kL3gk/a5Y5A7DNeEMVLJgFFEbKAtxSqyllYBEcizEdwEkJ9UTPs5J6nyi3Wqsq9NYbkBTJdJE3s8+feUhQZkgd3kig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZtOgkJ6PdfD3C4p4/BMDtE2Aa5r/S2Ii2kI6YNrifM=;
 b=Kq+xwxt7WeM+gbnXxwJs0KTdbRAPfv3gvvT+7M4GRSdS0L8G9INBaGi6tnh6cozYFIvv0jRnnFEm5ihgIiJvoA3BZqF0iwSzuobdUd2fPQhKUHAy+FKqUVmJsjdTn3vjOEuVgwVTZyn2/bMULJsi7UDWYxhQQPkIdRH+3ql0UE4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MW4PR04MB7266.namprd04.prod.outlook.com (2603:10b6:303:70::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.11; Tue, 2 Aug 2022 08:36:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 08:36:37 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs-progs: avoid repeated data write for metadata
Thread-Topic: [PATCH] btrfs-progs: avoid repeated data write for metadata
Thread-Index: AQHYpkHiEQZVlnUTMkmHfpZbbdOkY62bP+qAgAAAz4CAAAi4gA==
Date:   Tue, 2 Aug 2022 08:36:37 +0000
Message-ID: <20220802083637.lu7xorlgcvrwrh7w@shindev>
References: <cdfef9acd4b34751791cafc49612a35328847847.1659425462.git.wqu@suse.com>
 <20220802080231.kzrywmuduunmhsn4@shindev>
 <de9629df-3203-23b0-86bc-4d6ecf017417@gmx.com>
In-Reply-To: <de9629df-3203-23b0-86bc-4d6ecf017417@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a86ba304-6d08-4e36-4eb7-08da74621d79
x-ms-traffictypediagnostic: MW4PR04MB7266:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EO77OwbH5yrb0lPUcowlL02h+PyH4aVYW1XSi0Uevpmk405nQGDqdXwRggayAzQHEMSZJRh3JuSTDbeSBOXkdXP6YdW8BDNRhbr6EzNBX04RjXZENE8fRwIalcoCtyAlF61G5wtbVnWgUhj5c4Tv7QjeYfJWihRd9rpuqIOGvDC8ARfrkuUR2ZvONRD+8L1VvmHRCpNAHwq2wZdsNOuLZSy9/LKYM+FTQU6wusFbyeKyr7LP6kqXnN/WB3e6r8vBYWLIx0GcULTb0v9dB0O4jxStIhpyzSxZL5zU8nmk++tvPlWyGqeBzUTldAEBJgEvRrvc2ZrhSIyp+e2pINtMQGDAGxx7Ge4jbudtsJtTKR+S5nyAPkTQWbkf02jqtq4Qh+n0NhzfM0Q7R7kBfmTZD3uAW8O1reJRexWc6mCeiSUI9ZdFri8JK5Ym1eL+cBwbNcQowEie9mOprV8DXpzv0cDBiHP7z9YfawhPt6OZh/X3WH3UwvcE0v1aSGhj/uNwwOtpJVNAISp/wF6zFG6xUiLKPlHj6FC10nCCfHv41sAS06KTjQwo7T1S6teaMRnyURDEqqpiHhjiGWaOUmOvca6pdMlUO0MFGNzTFKvYpUCQ8tVZUkatQP/JOMnutXagCAf/mfpa5xWhhF9bS5wCGzhv7UcdSb6B2C+jxBvee7l8yv4gT1olfLDOiggt6/xm9roLFNRbSlJkdZr8wRu9PA6nRrGlV/bgI7ucJMzecmyBfjPuA5uzQCGBSut2GwVn2zFCp9s4tfm1VdscvGzuotmUYV60Ts2EZ3rS/CkQbhCztiyIYbRNNF3sS2ItbOzG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(39860400002)(136003)(346002)(396003)(376002)(41300700001)(478600001)(5660300002)(82960400001)(2906002)(54906003)(6916009)(6486002)(33716001)(316002)(122000001)(8936002)(38070700005)(44832011)(38100700002)(71200400001)(66946007)(66556008)(66476007)(66446008)(64756008)(86362001)(91956017)(76116006)(53546011)(1076003)(186003)(8676002)(26005)(6512007)(4326008)(9686003)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iF+M0Bhwix8sysP8IlqNERDBpPcD+dTTk7MQwLWd+RRy3FXfo6ybZm1AM0ax?=
 =?us-ascii?Q?cU9uDNjo6TulZTQaPFmZY7nQELdQD68zChFBlgH5mJ+GAtyeo23LZ46gzhO8?=
 =?us-ascii?Q?2ZbJ0d7WZ7fm3B/9KRfsXomhqofS9wr5o2vldcA4cbeyaQzcFLR65Dp0wjG6?=
 =?us-ascii?Q?Lz5b3BUVjG2MhDgZui5w55BO7XneNhZaqTek3xcL+DXAbcy6mSMv71AjNCpn?=
 =?us-ascii?Q?ejadvvQoL8uRnM20aCR+7kOogHiGT9LXVE2en+bmoz8WDm5MSpZhfDgg2aki?=
 =?us-ascii?Q?q5aKyY3SS58Oq+xzKuazmlHQtoDFrX70KTasoUtUJe6GuAAZKYvY2woLDf5B?=
 =?us-ascii?Q?U88CURrYnAXkNwKilaKTkS63jswFaIyNdq9KjwXofkZIhG0dtiUxXzZnKQK+?=
 =?us-ascii?Q?kyA7MJTfJ2qKl0Ar21MvDtdtwlkc16X7O3+Pz0ek1PzgJk4J4dFhkq0vi8xE?=
 =?us-ascii?Q?E0HQaucHJp4CB/t7gCcAWpKBkviOLC4It1zUtZAWKFbV2YaCtBSFlstasKxP?=
 =?us-ascii?Q?haG2k4c9jmVVnKFyvoyofb2xCNTfwpJ2PUz4S3350hv7YmjZaJK6IM/y4yPa?=
 =?us-ascii?Q?nrItkbeK7+xGRwGGjboNslQDjBTYXnKuuvBfLLxqqLJc9b8/C7w9lP8IhvDa?=
 =?us-ascii?Q?AxfyVuLbONYcAXmCL4N9SFsb5UIwuQtodcowD9XC646bBhc9Ur5x3hdHfpcV?=
 =?us-ascii?Q?eW+aLgCGId34IJ+n1Wa6onAoBmkvbHnlvI3K52HpXfVF3q7Wd2GCI4rY373T?=
 =?us-ascii?Q?h8RevrALQS6+NjF7PaM2f4VVmHkxC9z2M8m5IaZykYKwcnidpNxOo3VSZ2mR?=
 =?us-ascii?Q?R9IFYDxr2uVy8ro8ETOLOsLWtTRTXrg+BrhzkWYnNVxZpcrOG3NmL2Kn/69Z?=
 =?us-ascii?Q?OjX/Sps3CK6mmNECIzxVC9bdZEQRDjTtYNRJgApxPMGGBdQ+FJs3mwMqt0zt?=
 =?us-ascii?Q?83PWoJQKcVg9lvZksoimmvkwq9JXSrukHjLlRv59mzX+oRAqmXJjY67sZ0JP?=
 =?us-ascii?Q?nNwQfRYsKjGBGBy77HkYcxRmZfS/1Jh8iFfWVwDSh4ieYSDRiS2aEbiqhkHl?=
 =?us-ascii?Q?s6lW1oo2yS9qLsNwoz0W5X8zuE4mZU0R985f7i6oCY6tTp1oyPAR4l2rm6Db?=
 =?us-ascii?Q?bAw9XXPdLb671EM3Ro8NLpm2rO9cIPdfzOMbMOEgbyx+rnryC/5vc428gLzU?=
 =?us-ascii?Q?pzUHkAK34itpyiGQX8nBfjvAqfhYzAoHfswumzIiuRM7gL8cDc/s4XH6iUVq?=
 =?us-ascii?Q?k/K5fauYqyUly5eSKbWZC39YUYyxIPnko7UJnmP7DNtFzDfvJMO74yHTo3bW?=
 =?us-ascii?Q?FSojUytwIUBUuNyvlP6bh3BiAskXnzGVhX+dvqY7V8Wc5EgGoqS9TQneTnKt?=
 =?us-ascii?Q?vqnmvpT3pee+74LDPoZxHe1ogxrgFCJRVGIj1U9yoiO7rbk3a7LKBcFoBpFM?=
 =?us-ascii?Q?0JMmUbMU9upEZpZ71Zdvsvb7iZef2RVA+nIvu8hGz56A3yhO0vU0kM6Gih97?=
 =?us-ascii?Q?L/KeiJBafNSp5U3ok7JUhzaqxKm8ejr0Yl3zrEtgSwFPt9tv9dqtMyCl76II?=
 =?us-ascii?Q?p1PJjC119mb8vjWI8hplCFPZJrfXRPADraazRQsqMh1Rix/YaGhN8/GHa+OD?=
 =?us-ascii?Q?TIZaR+82NaN2q5m0xkegJ6c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79B30DA82693E847B2D8AA0962DFC12E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a86ba304-6d08-4e36-4eb7-08da74621d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 08:36:37.6140
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JETiyzS8e3wTcJmYBPy3pGA0OV0CF14IiUYzOiy9qJXmg6zq9mXQOt0OHKsqMbvMjNF5MK5i4zq0Zu/pomfS7E/BTnZLLORihmTB/bqIvEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR04MB7266
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Aug 02, 2022 / 16:05, Qu Wenruo wrote:
>=20
>=20
> On 2022/8/2 16:02, Shinichiro Kawasaki wrote:
> > On Aug 02, 2022 / 15:31, Qu Wenruo wrote:
> > > [BUG]
> > > Shinichiro reported that "mkfs.btrfs -m DUP" is doing repeated write
> > > into the device.
> > > For non-zoned device this is not a big deal, but for zoned device thi=
s
> > > is critical, as zoned device doesn't support overwrite at all.
> > >=20
> > > [CAUSE]
> > > The problem is related to write_and_map_eb() call, since commit
> > > 2a93728391a1 ("btrfs-progs: use write_data_to_disk() to replace
> > > write_extent_to_disk()"), we call write_data_to_disk() for metadata
> > > write back.
> > >=20
> > > But the problem is, write_data_to_disk() will call btrfs_map_block()
> > > with rw =3D WRITE.
> > >=20
> > > By that btrfs_map_block() will always return all stripes, while in
> > > write_data_to_disk() we also iterate through each mirror of the range=
.
> > >=20
> > > This results above repeated writeback.
> > >=20
> > > [FIX]
> > > To avoid any further confusion, completely remove the @mirror arugume=
nt
> > > of write_data_to_disk().
> > >=20
> > > Furthermore, since write_data_to_disk() will properly handle RAID56 a=
ll
> > > by itself, no need to handle RAID56 differently in write_and_map_eb()=
,
> > > just call write_data_to_disk() to handle everything.
> > >=20
> > > Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > Fixes: 2a93728391a1 ("btrfs-progs: use write_data_to_disk() to replac=
e write_extent_to_disk()")
> > > Signed-off-by: Qu Wenruo <wqu@suse.com>
> >=20
> > Thanks for this swift fix. I confirmed it avoids the mkfs.btrfs failure=
 with
> > zoned block devices. Also I confirmed that the duplicated write is avoi=
ded on
> > non-zoned image file [1]. Thanks!
>=20
> Sorry, I have already updated to version 2, as this version will cause
> problem for RAID56 mkfs (caused by an outdated BUG_ON() condition).
>=20
> But the main idea and code should stay the same.

No problem. I've reconfirmed the v2 series is also good to fix the mkfs.btr=
fs
command failure.

--=20
Shin'ichiro Kawasaki=
