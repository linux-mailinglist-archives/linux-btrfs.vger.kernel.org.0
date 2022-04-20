Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E64508330
	for <lists+linux-btrfs@lfdr.de>; Wed, 20 Apr 2022 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376617AbiDTIQp (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 20 Apr 2022 04:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237048AbiDTIQo (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 20 Apr 2022 04:16:44 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF175B864
        for <linux-btrfs@vger.kernel.org>; Wed, 20 Apr 2022 01:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650442438; x=1681978438;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=p8jI36nkfGLIi5cVD62nirQtXK+0JEF+JYBOjI4wFkYvtuLT4PQd/0HH
   DazrQ+q/UrJD2xhOxyS8x1mYSqjclKJ7zaxOHEk3hp3ZQw/majWsWCE8F
   OlOpUWYFIkx5MmYQtfWOe53sHK4m/Tzx+1p5z0BvdrAb5c9ELCy7+SAdb
   LLa6+o6zvIIYnf8wKh9HituWWaUD6b1JnSOBsn4hNcS5B4X92tSns03h1
   SplmdX7+vWABJADBEfoz4LCyJGWRc9O6EMIF4oTGyeSPrstZc4yeMSjpr
   NBn2wtzOE+mNMUgNkOBJifxZ8S5Hu/lEsFg8aFb3Gy9I6YirBlvKGamPD
   w==;
X-IronPort-AV: E=Sophos;i="5.90,275,1643644800"; 
   d="scan'208";a="302539685"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2022 16:13:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mknd6EHKx64uCqXxlC5C9JHXcOIQrsFVc+ZL9YsfspDLQdxb/5s8AZKOrPmJFlU5RUxdWSri6a/VSG1VPHPdmcr06amxO65y92CjQCZi+mkYPtmVdkH3bAIAqBTgkx063/LC0yl+M68fImBZtNTFXLhs0+M9y0CTDSLxFbAvJGD/mlCg+e5qyw+q0cc6UIdE+ZPLPxrNtYWs5WeowvX6EGOHTc+3ffDTSZtTcXpE6UVJN/yv4pamgUx3X4VvkBU2uGbGQjBhTLgOnf+Nuvl+PZgekbgFWF8KqxbPXH9UluDFIIaidt5P8hpGF60H/rIhOJ8FJCT+sCqW3C+S8M+Vrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=P0yRt008rfVok05W0xVAhwN5cIAbxMhfbbmkH28wmMm8wIs66+Hw0TTWOMezUlB8SVYXiW/v+X0kUeFBunCHcjyCckIjB+MrWJXwdazYhHPWULbwl+nOW4Ca0ft3gexxBNn19mPI4ag7ctrPvWs71MFc2tZhWVtj+HPqV5kT/DNpGFyrzLE7WDhLrR750SrnT9cUnQiEsSRKDRZDEzbwuhjCJiq9K9FZvHd2i8gfrp/TppjPZZsXD4bNZbmSPeVmvuUKfzDt9KuFiVC91InZ7/NQ++eRIECv9LHTDfqS3NN8w5fVZ5BVVe1vAJ/c6zpcLBRaxz4zzia3MqvI7Ue/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=yUM/Qg1fEoXFhGUKJw/6FD+bmP0bNoWQRHHH6L5uMl6E16E2NXF1VlrcLU/B99BJIgZDFWZ8F3MRm9GYAgJNY4PNZfCHIyNaL8etMYYwe6nktADSi/DBABgigDyTkG8ys+E6iHHuI2PhKFhyaxl2COZYYrT2pHOSfvBF+nmLyo8=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4086.namprd04.prod.outlook.com (2603:10b6:a02:aa::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 08:13:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5186.014; Wed, 20 Apr 2022
 08:13:55 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] btrfs: move definition of btrfs_raid_types to
 volumes.h
Thread-Topic: [PATCH v3 1/2] btrfs: move definition of btrfs_raid_types to
 volumes.h
Thread-Index: AQHYVI3l1HcQMtP5a06eXXGcxL2jUA==
Date:   Wed, 20 Apr 2022 08:13:55 +0000
Message-ID: <PH0PR04MB7416B8B139758AD5AAF0A71B9BF59@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1650441750.git.wqu@suse.com>
 <5f91946ad971e6d9a3d10dbcb1c9899fb939df1b.1650441750.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41974fa5-d80c-4d04-23fe-08da22a5b6d3
x-ms-traffictypediagnostic: BYAPR04MB4086:EE_
x-microsoft-antispam-prvs: <BYAPR04MB4086CA16F0235FF4F1495F3C9BF59@BYAPR04MB4086.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +M3ufo+lkhRwEZyFfZUs1M7KiIa38hmaDNS/xuKyZ9HBKPw5hiMHnAXpAUty/WLz9VtvXvMswgxNdpOC0vH983EH0y+gix7tg5fAayFvqctXL70akLsy/R+wAXZoLex8CLZpgIRB68bk7Ttl6VBR/g0nNuUzxKzx142VK7xWXZgdHgngBV/vdL1i/7vD82S59zfhcfv5+GHnB+agNdumhyU2W4g+KS2MJC38z/a7VdkBKE0Asdswtc73lhWalhFc2J6N2BWpw7BVETN9y5/VfSErbKKowTGLsIFiLOhpoI/PbLenSgbCvj1BFP7XAe9wiFdxyiP38pwscfgvitNIUjyMctq53vtI7zhFWIdviA16MRuBzX8A8OZ9K2VKYlhg4fxdbg6UF6FFzETL0TXkBQZ3hub5LevY+EVOIzX9HFkQZ6swLt+msP7V7+o2ue84oZGwF8v2IwuK9J7wT6B/ndbb3bwJNGhEKOYFRxcZblaQ/kc+YmjKIpTKX2CipZQvILCf6spuuMui3/OlaFoCb8KT71n+SR8xUdr6dqbS7TUlp7m0XhnFx/ByPyewUqMGX4drFhXsVteBkTXlL8oIYqbpa4bQv5cCzOPVsTXiFchRexDenjhC43XD3o99USCsCOEFY4bw2aCYgOuEWsxKQ1/rGPzsgQtWx1NjyJipel7N30Hku2VrU2U8twNzDJiiyS4ZpqW5cXbiv/mQCMkeEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(82960400001)(64756008)(66556008)(38070700005)(71200400001)(8676002)(91956017)(508600001)(33656002)(8936002)(52536014)(122000001)(86362001)(66946007)(19618925003)(558084003)(76116006)(66446008)(66476007)(55016003)(38100700002)(186003)(9686003)(6506007)(7696005)(4270600006)(110136005)(5660300002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MhMnr5oA3Va0BwIKM598IynlafIwCSbNH2865ZRcIOsLLwlufpiKLnYWBbXq?=
 =?us-ascii?Q?IcHtZYaqKKq3tbEpdt5FgzNU/ZNxx3zgK9n057m1NhzECrs+58iG+sx4ICzG?=
 =?us-ascii?Q?geArDxyjMyDtmjkm8HuFFg4zs7dcbpIOIavt6Fz7DzF8rEefGfd1Y8jDtoe8?=
 =?us-ascii?Q?9E9l/vpPbqT/tVXQ6X7iU9eDptFjo2bZbsSzq82+wqiyVpQiq3FgEKACmmzP?=
 =?us-ascii?Q?NlZn74yVQQJECinyoU6DZQZm8W61LQ8tLyG3PFB0ADFXDgGzSAGhBDGrYd4X?=
 =?us-ascii?Q?xhGw7+JTCyfXA0hDlMkQEV+fZTEjCkgId2QeUSV1MoCO5Cl1iw2pcRyH5dAG?=
 =?us-ascii?Q?OkrCTWTEVAIgyyGq56b1wl1AvjyL/sDrpZ+xp5jeDCTxTvtHldIB9EVvP/CZ?=
 =?us-ascii?Q?+XQTClspC1t1qpue8lHoTkQyJJbtqh9D9xKd0WCX+uVPsVMyXjQR/bRp5yUp?=
 =?us-ascii?Q?ueAeZXZYwwoVcQgFGa8lJWsFYXLxk9WMgUOTvNUvuX7PYVsuKBeffEjjKD1R?=
 =?us-ascii?Q?Yc1bbPq/RAKEh4nJ0ii11doFqNJ5hidO70J0aacI/MbChPLu2JgpujPV8AWJ?=
 =?us-ascii?Q?4ThD9Kn1InxoC4+oXD7csL3sUenITN3e7bZXT2EviQj61AqmSqVqYccjd+Ke?=
 =?us-ascii?Q?N+dBr35u7FuRFMYfoMAnG4QTjTFqez/GRke1d38FEME5fDRLP+cNFG/ayh5m?=
 =?us-ascii?Q?sMgnRXVF5fzWvHgJ2NE2jRgi9PPO5Wklaq+3ZsoT+YFnIkrpM2oSJCBW6Q5G?=
 =?us-ascii?Q?2zHSxKcgBzjhSRcLqk7eSG9zUY+jl+jhGInCbdALUKjhQaoFMfrOEPZR/JHt?=
 =?us-ascii?Q?8BNoGNl7gOoyDBAk/TWTRqBJjdws3s8571zu57LZ0RluTdPAkZh5zrwsYS0I?=
 =?us-ascii?Q?7Po7EMBqcAf1iXdJRtmbUlIE7Tzy6pUhEkBbTaK70OHahs26oS3bwKHVFhEA?=
 =?us-ascii?Q?3n9BluMm396iMYTBYeo3RaztF/jVdnY8b2o0dPtfbnnudgVSkdrg4/Jqlnr6?=
 =?us-ascii?Q?yiEA7+VUGCkVNfvn25+fdebJmm9RewE7LCNlJ2FKN4etc6AGbOX+8khREkDK?=
 =?us-ascii?Q?5m49Y4e0+Jt5nfWzDh7gNE9zocRBnAZM7r1SJtRVE+TV2N2WFjwoLeUGhpzf?=
 =?us-ascii?Q?+7bp9JNax5dLOZabgKm/Y3xc/nCGjG0yF9LNWhaNtBNG7fcXzHRNsH9o64BA?=
 =?us-ascii?Q?h0XMjHx5GpNWchQTM+wMdgnn/LDSZWJ1llVm2HIqXM8I6J/JsBL1EzaR1Tkj?=
 =?us-ascii?Q?h+um4DhVwxO9Z3zJZQF38RZ2T5OVXoq93yuErk3N3oJIfNGvhTjY7P2+whXA?=
 =?us-ascii?Q?mFoZWmsis315JcPCVu7YHTbgixpT6yKQXqPOd0/FxbAz3jNPVQWyhdUhA+/q?=
 =?us-ascii?Q?QaSK5+fo07kEZb88zg6H4xMdB4r+zAGTuk2sPvJ5WcP3b9mAuEVZvop/rN2F?=
 =?us-ascii?Q?E1SB2wHJRPj/ZYeAu2I77FLYo8svikReriLu95Mig5lViKinFhYb/FPIYZ+9?=
 =?us-ascii?Q?MyTkijyug3vU8a54bdK59hTXBqBjSvvQICtqlW7hzaieVTt2vNBkGxd9refs?=
 =?us-ascii?Q?dA9m/oN7o+MFrOJHM7p7rux6cBEJci+HSeD+EBJlWapJGwrVTy3YHDSECnpW?=
 =?us-ascii?Q?TquYN+rBOCJ1L/LoUqe3zK51KKIKPcm60zqcNtLBqomPIhheMAV3eVyeP3TT?=
 =?us-ascii?Q?xwM9vcJuIJtQfa7FXlTlfsu1YmLWT0hXEPPiQx40V09MSDmCb+itsMv1gPzZ?=
 =?us-ascii?Q?AGmAFUVbaFQBHoTojf+yAZ4JH9FRVlabooQX6LNOYMlCxMedAyXea3cLPTEB?=
x-ms-exchange-antispam-messagedata-1: QJQHkKcRLWRdKPwGOnp5BJYAe5NLI0dYFoKpT+lDwuGGGBPBphvALsbd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41974fa5-d80c-4d04-23fe-08da22a5b6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 08:13:55.7960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxFWZkf/CuQIAyTGBcpCxbx9PaszIgUDjA/KqLp4SQTh52qUv6qBSXYzq8rNuosM+0LJXT9saanYgyCIadPhU5ILVlLTjTuPE18FJ6PrHCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4086
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
