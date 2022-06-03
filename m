Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A1953C70D
	for <lists+linux-btrfs@lfdr.de>; Fri,  3 Jun 2022 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242858AbiFCIns (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 3 Jun 2022 04:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241085AbiFCInr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 3 Jun 2022 04:43:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33CF1AF08
        for <linux-btrfs@vger.kernel.org>; Fri,  3 Jun 2022 01:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654245825; x=1685781825;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4oQlcGU/i7si94hBipNp/3sILnLdIM9V+Cs8stGI6Ks=;
  b=pg+nBX1EnJDDtYsH+IqyJouWYTOLKvB+iTnduQhQSRpuh2ckpTSmJMcO
   y/EMcIc2wwEn8d6GeicMVDg9neIeFtkvcV/GCSykkccIMhiNIUwByxbHQ
   fcB7wN2k79y+V+OekNaO/qMToHUEISNFYMfmA9kFaNHf50KAdllxflU7J
   iN6IXR3HE72IFZpd3iOAx1BvPNTNTEZx7v9qvTofkTnQPff818gIOGZqs
   KlskrGqxcQveyMawrC9BMUoDNH27HV0QtjhhISRzfa/nGD+VH4ZuUCrKe
   fR3r0RReqG8S6igpWlK7LZ+IoPpH60N70qs4/lkrJAYnyHtbjDuCbRt30
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,274,1647273600"; 
   d="scan'208";a="202185005"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jun 2022 16:43:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adCnNMBIejwf+xRMrubFCdZv4a9yG8ifL5Fh1HsvV/bD8lDwa+r08VMBjoop5vWMBptQDFZuVW96XeXxIXbmSriindhC63gUztfr7+ZC6g3DG/5+QOjx9bTJ7ONDWkRuMxGInph8FHX2Ziv1/QwIF9levh9zwcMF9IYr9Nkn2wRflk7FRQP69mr9TXlVttXS4b3IJzbu1UlxikzQCWC8HcoK7X3IfSPxThffmoo/A0id7JE6S/6MoAX84IaIvt4EMZ9omFmVUqdPiRP5H4SLbP4fMNR/q34LOYFIRdEzN/6suv6gqfFAY6TedXpYZLy9Fx/ObkERxeMPSK6nIEIUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wYz1qf75nkQTW5jmdBHqFw9WdosVzz+r9u4wiwFMPY=;
 b=Q1gZzvbyX12Ltr0lIm3nBp/LAwQKtsaCka8jZ9NUNR0Eo+d6+pJSuEYuep85A0OpuH22e5U1at5r2yMBOQU8YeG2cgXaOC5M+2Ns+5mZJzSlkLY8iUoRYq3CR+W7vMvf/d/X1TQcU2MpvKuYssCoXGTTrgJHjoMjCRwJBAVkZ2DD0SU5qzercfR0ssKbY7pqH/ye2rZ8hGIWlVRojGYX6YXTYhj+XXs98/lVJqgCMakRT03sAIth3WJk4vWFUCG16ykTiFP3vUZJRwCoKFfCP/VNv167zLs9+n8Y+n3AzIotBDIKa3eLofa2y9ydPsAUy9z4DGbplUV7WFsdJuD8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wYz1qf75nkQTW5jmdBHqFw9WdosVzz+r9u4wiwFMPY=;
 b=WCBiPjquu+0APyqF6UaMbHz08IN5EMkEBwSVJodAG0hbwHdIWnxtehJiXZgbwkJ3bXdYFz42Of5UudP4AWHreVvQ36AE5HT0yq1ABRb3oyGOIplrHaRw8hh3lnL0A0GeqtOmbr7PcAu6wMonkcmwqUU2/REMgsELGd3qplNl5KM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB5954.namprd04.prod.outlook.com (2603:10b6:408:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 08:43:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::81de:9644:6159:cb38%5]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 08:43:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [RESEND PATCH 1/3] btrfs: wrap rdonly check into
 btrfs_fs_is_rdonly
Thread-Topic: [RESEND PATCH 1/3] btrfs: wrap rdonly check into
 btrfs_fs_is_rdonly
Thread-Index: AQHYdu5D1o+8BoVxXkCmw/M/kqtAAA==
Date:   Fri, 3 Jun 2022 08:43:44 +0000
Message-ID: <PH0PR04MB7416C47B4A55666510F7FDAA9BA19@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1654216941.git.anand.jain@oracle.com>
 <0bd3d3777e34a5322fb4d3ec315df4090ee43399.1654216941.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8496aea2-885b-4f69-0adc-08da453d2b2e
x-ms-traffictypediagnostic: BN8PR04MB5954:EE_
x-microsoft-antispam-prvs: <BN8PR04MB59540858550B2E10B0AD73EB9BA19@BN8PR04MB5954.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ds9MsQnKNwK9/Id5ioNxzJher9zt5hXLqVp/OAayO/P1Kpo3yQb2rI9Z6YbN5UlBF7KjFkhd0uOZ3Od+IDYmu9q0HxSs49ZJFnKC9GB98Z0mWjXbSnjPkIaGww1yKjfaKQPI8QyHu1rykrQXh20qhJpYNqYXTsiaBIxbVKVwm2MeKxZ/Hlv0oEA86cQzCpsH5PUYYvuauStHBK2E4Df3/PotapnYsHOpgMj+OZiTLP8Icefexkpd39lO65zDbOmBBmor48UTY/m1s0MrtMKxjVpZfmtLF46byWtfrej1y08Tt7fkGA7fUQx92UjHqXQRx4WMwoCMOc/QvzRjcvA0MbPiAq5wOqFh5YIh8v2M5AjEIh3a1M2ZvS6AzUh0xvE6Z/z25CzO5+fPvqbfpLR5jU6U6FhoNgb6/d/4tRMA0G9fwNH3bUDr6hVMLf0MVopW4dn9tNuBfA14nIOGEF7WmHCA+AjQ8N1lWHEYdjgYSQlDaqato9sKfyQstjMTafoeUlQmWfRgCtT9Ck7Q6bUL3OxJNoQQe2uVsjIi5KIMjcfkdcMVaUoZA537TA7TpTUwKSZW9OINCWe2bB/Q9CArMYxwKIT9gkJ1eSBSSa6Lu9HhJVKxw5FQtKVe2BucduFZ1vnl2PB2rLUnUI5tMxTnF2I86aFigRdZjcs+dorNE6Q7NMzzxANMjhyr2HmmcWoSXd1/YpAEHCt+fEkVJttWaQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(2906002)(53546011)(9686003)(110136005)(55016003)(7696005)(66446008)(52536014)(508600001)(186003)(66946007)(316002)(91956017)(71200400001)(8936002)(6506007)(66556008)(122000001)(64756008)(4744005)(38100700002)(5660300002)(86362001)(82960400001)(33656002)(38070700005)(76116006)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aU2YgDxClWXlsdlDHtK3qk8FHV/B2pznC9pdIYiXf/jxzNGRZcYzCtRQQdvO?=
 =?us-ascii?Q?Us/RzJQ2BoEJmHlNYU8siCxZviQ0i5+5TdW/Yo7M/vMSXCXgUjLZJBlj4tve?=
 =?us-ascii?Q?/NvPpiqw0blVaXERULWTTZMSkbluHsuifgz+rvQOK+qgrCtUw3J1Cu+r31fl?=
 =?us-ascii?Q?4la72WGLRSvECSPio4c4n/JOyma5r3xhGi2nEouk7AxxpM4A2aQ7pfMvrCCO?=
 =?us-ascii?Q?Xoui25qnoHfbZNrQJ8sLw8TtzhjG9Ghb219v3S3sH5HvyZAXQuiEHEk76aF/?=
 =?us-ascii?Q?R8TZc6vIqGsc3MEOI+jJe+OzhXVWwfSe+8KJpn8ajJkqmQfSUpK03++C0Vli?=
 =?us-ascii?Q?6iBZYq54I+wqc8UOZjfU8DySRlEuF4MVRJuuN2SyOGQ43RfYV8Wi35LlbLar?=
 =?us-ascii?Q?i6IUYcshmW9OSSZ7JTDiUYiKNNv+ksaUbTGtkJ44Y1cCjhpGOpZuyhyWO0zh?=
 =?us-ascii?Q?ta/WxYCtHwhcnRhJF30hSF/mubpIPacev5tfx2EiA0qnqrEziqmCx09gfR4m?=
 =?us-ascii?Q?pze7XaODZ8Vi15X7q8NSUrQizaHNX52YmD2DEhOFMoQdgTDYTucOwkUljH8b?=
 =?us-ascii?Q?bxN+KIMuIyEoxxmYR43EK+AY7rP9MdgugqMDlKic2HxwQCTlY8KjaeiKB1KX?=
 =?us-ascii?Q?DFx9PXR8wl8vAMnyQjow3BiMzceW3fLIH3YpfyhMkFcXJDpc8jq7T7dK78Wg?=
 =?us-ascii?Q?6Wg6AI5fUuwrLnUEkKAuqovg2gt960XdN9XBXMzst43lKJ2H9zPLnv3BYnoY?=
 =?us-ascii?Q?XYXqHwZQv9/g418/14E/mmcMkiUfc+Lik5Rr85ftKlpxsAS7C+BP5oFB8SZX?=
 =?us-ascii?Q?QUepOKfm6pg0XXhssvm5S2bmW0EAr0LXQmO7+5LWPmoDjSeyNpOs20oiWr3P?=
 =?us-ascii?Q?9fW9b4YnaneK/Hb56ZbGrrWPFwL7sqoSKxky4sYLFXBIX/pXhW4IhWwntXRi?=
 =?us-ascii?Q?ah3YG4mjSPlqbA4YDdqyZBJ8BndGHiw6+2FFaiC0DJCuPV51HZlkJaXa9NeT?=
 =?us-ascii?Q?5SiL7aHsZv1KESFbOVyA+eWPXZtdwJpJs6ZN0+k5LIDdO9XisWFxDBHaaPqG?=
 =?us-ascii?Q?5tM+HYwOFzw0/4qYORajqLq5Q+PfLYUK47a5tLevrE909VMc75L4J1AGp1pr?=
 =?us-ascii?Q?I3WgpBUjtlnfoNqxUf4EWR/w3Uatd+xouoMi5OMwwk09LmgdFqp1VBTp24lG?=
 =?us-ascii?Q?o+ITBhOjnId9WOERF19jV+r66blfWFhl7EDwuZpnezq/MdG7bSKlFyPVvvWt?=
 =?us-ascii?Q?6oqUoirrwhhhr5cUvewq7C+eiK8F/FPBkcqm1h18/dvSmwC9xoJGRibtw9aZ?=
 =?us-ascii?Q?G3+TwyjaIn2O86X1h+tfBpekNX0pJQ36y9DlSnweKkK+ohncVyUzi7ujHKke?=
 =?us-ascii?Q?/9t6apw9JR5TvZf0BOZrFSOq52l+jpFXh5PK6e2OYqqybYwpmf+SfdqfD+mP?=
 =?us-ascii?Q?ksSRbBTHIBRf3Mfi9XVhriCKiAMXLdPPskIMHCsbtTuguRQnC/CfnRZRXqZE?=
 =?us-ascii?Q?236SLTkn6c/0PmNjZLfH4jcYrtPMF1R3t4D0AniDFGmMjPMOi5hCDTER2zoU?=
 =?us-ascii?Q?9V+lH0+oWTWRnkpaDgCVqy0VDxibdGnWNLFL5OHetarGVvHD9GCvCC//QbvC?=
 =?us-ascii?Q?lRTm27DZLRQGp/yzYUILaAR7+Y1u3/MTB4wSvYoOmO8W1fg/+lPis8nI6zMw?=
 =?us-ascii?Q?vmdkPph3BqsgBYy8rwiE0aMNQUr7Wm2O00RF2DosmtGl692+EvdFRKlSJcZF?=
 =?us-ascii?Q?m6aMzfNDBFaxyICpQi7bc6+yCFj1wFv0rpL8QSdaqHIzNVMV3CYUEWwtxQFM?=
x-ms-exchange-antispam-messagedata-1: 3LZ6Yk3P3N3JIkuuJtTIAYjVDxkXwpkgaH6TZAC9PF9bOqeRWiGnERq1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8496aea2-885b-4f69-0adc-08da453d2b2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 08:43:44.5636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K7gGGMPffH0raTEqmGnfEV9JkRTcuR8UX1EjTxOp8sA3/pBjMLLCklE9swvV3cIm5Mh+iCMSlnr54j8XVUG8RqTz4eTXWUCqYE3Vy+P5izA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5954
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 03.06.22 04:04, Anand Jain wrote:=0A=
> +static inline bool btrfs_fs_is_rdonly(const struct btrfs_fs_info *fs_inf=
o)=0A=
> +{=0A=
> +	bool rdonly =3D sb_rdonly(fs_info->sb);=0A=
> +	bool fs_rdonly =3D test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state);=0A=
> +=0A=
> +	BUG_ON(rdonly !=3D fs_rdonly);=0A=
> +=0A=
> +	return rdonly;=0A=
> +}=0A=
=0A=
=0A=
Do we really need a BUG_ON() here or can we make it an ASSERT()?=0A=
=0A=
Apart from that=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
