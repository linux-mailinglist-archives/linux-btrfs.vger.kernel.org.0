Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF6E1D9303
	for <lists+linux-btrfs@lfdr.de>; Tue, 19 May 2020 11:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgESJOB (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 19 May 2020 05:14:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:30452 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgESJOA (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 19 May 2020 05:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589879639; x=1621415639;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oqX01XeC9YWCL6AwiYG/XFEkQtPWeXKa3C1nw2s1Jm0=;
  b=Bmli8WGjlc+poT7pAqlXaODa7vsX/q8Aoqe6Kb5PIQcp6Cnr4dTvOeXj
   VOXhGugUIfdwDZvAZgyOc5HrQQQhSBKxv1QFN8C7fvt+Wj7QYDZX1IO3F
   5jv3Frtvv9BhNSPrOzsIVKofJfXwJTn2YrqBGrcSoInGKSbzsND2VOa7r
   CMplKeTuhrIu0YWSJ7hqw0EW+UetC9xB68iI+wwb1Mlq2JvmBo/KvFY4G
   Og4BIXfDu34Kmvh10FoI4VUW7kzsUwiq1/7sDcZApDe413DwgN650MxVH
   d0Ycn9USwFWA4d7bJa+RrohZMSJtXqtoPLsDEUcHNU0i3nit4PF99vwtl
   w==;
IronPort-SDR: 5EY4xUVVAxkn/yTAME2zRhB5BYzt22qsoIIaWsDy98b6i6KBQ2kqgSisgjrfrSSQKu0OVlPwLP
 RbZC4G5vpIaczaZUJ6jBDUd1mQ3Qu3314oPtyj9LhMcawTQd8sVtJdKQ9KVoZOvRmjQgZX+i8X
 7clqfil9yAcuxUCPXw5yiCnGtvPvjIPaZAbnppNSM0/HkGQEm27WD4TTcnZACSbi9Nhp9ZTtwE
 eYUYEwSt3m9yNJ0RYgibybuEMDQGk2hz1X9ITvq+u3s/lLcANC6TWPF5+lGgBFHUhsGciqHyjR
 2hY=
X-IronPort-AV: E=Sophos;i="5.73,409,1583164800"; 
   d="scan'208";a="139460016"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2020 17:13:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBoyBeDArpelIJYxCbqBm7PE4Yxyx0V5iVufUh2XDRj4JF5PQYTqeC3+a/xQCsxRdo8olOiZcoEG8ms+IqVTMmsdWXL9NrqEGogpM6Czoi9/MrB9h1RMQ+8l+f0jn7No+7se2UrgcjphDNbX16li6kokDlgM8Y0xRYCb7gOcMGy3Zpggj8390JoP5kKBB3Kt/pEA+YouSN1cQPbYNSKK9N3d3ve23G9frL4DwoH8h3raaya/0pehRlcNLTB9fs1yFKhOzlCeVA0/G8qAfW3Ohi7PlpKn0y/b896ZhBOrMvdUBUxw0MMFexshWelIrqOEIYQV2ffN/Eeni17ma5h5/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqX01XeC9YWCL6AwiYG/XFEkQtPWeXKa3C1nw2s1Jm0=;
 b=dbpZqExdeYCdYrBb4j363bnlFXlFMEdRPMYNtiFxefiB3bmqLPpY7YNBXVFwWSO8vxYUQ5OJyOWDwFf1kgHbs0cmAMp7XiIXj6tH/4QTH9tuYe8ISZ8tbs5sCO2NDPUN+iU/+CdOAHF/OskOqb7kYCdOYMI2HDOVfpY2ROmM94z8U64vDyzIqQxx5u65qJXqHcP7JjURnVKmnF4gvG5WZw+JaNZ2sxpO65dWWMywgGnhERqTtLlNxcXhmVeU0e9bNF8NH2CKPsZck7e+OfavIiJkuAOs7nPb01kwfL6SUtxfgzA7drWSfB//G600jjg2tlTBrS/VMJj8faMeJu6KJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqX01XeC9YWCL6AwiYG/XFEkQtPWeXKa3C1nw2s1Jm0=;
 b=aeICQ/YeQgJNuNTb90FKhjBlS+xym+jhmqd2PHQaCMTYYlNVkyQRe4AtMRcJ03FGpkzpVxNSnkDk2dcqdJtCjSIvkXp9LYhumrSfvoRA7IZsKBt3cxWihBx6mlz+WERL26rRe+wfYWI9gw0jdBu115XS8YEy7hcXdsPZcgvKW/A=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM5PR0401MB3637.namprd04.prod.outlook.com (2603:10b6:4:7a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.33; Tue, 19 May
 2020 09:13:56 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::45a8:cc6e:ff12:4d67%3]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 09:13:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: relocation: Fix reloc root leakage and the NULL
 pointer reference caused by the leakage
Thread-Topic: [PATCH] btrfs: relocation: Fix reloc root leakage and the NULL
 pointer reference caused by the leakage
Thread-Index: AQHWLYMj/GrPSkE3PEyq5H9C5SKY5g==
Date:   Tue, 19 May 2020 09:13:56 +0000
Message-ID: <DM5PR0401MB35916FD77B6718518261A0779BB90@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200519021320.13979-1-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 21d7ce4b-6a31-4d0c-6085-08d7fbd4f586
x-ms-traffictypediagnostic: DM5PR0401MB3637:
x-microsoft-antispam-prvs: <DM5PR0401MB36379F797C4FD438373025F79BB90@DM5PR0401MB3637.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lceKq6B3rc7BP5xpIqbGGSaPKiWskErPGJrWH4l3sT4y2Da/Ugqd2gmzhOysCf5vGgo6lDivHPFPYkgGrw60TX5MZuq2T7xVji001NyTVhokyKm2ds/j2TrpJwDJAHiOcEq7CdgM/PpZxq0qXATTuQUEB4pvLtXTgmx9KNbQJNu0nK8gu3rKJovV+xK/8nZeJkzv/Kz2zE1hnxWhDA6up+HdjPmPE8u+vW+oc8vjJcKTt14sYTlQsn5FmO/58W59FZGT9uapK5mysG13BoulY++pGo1atAgqOZSCwDHSXhKB6d1y0CDkikVSLMS3J/NoAqKwb14iD+5ZQWr0A3h7v3zhn4jnyELEUWBLREpIuKPTgh93ZlCSPD7QmFHXpMn+CA3yxGulNpoR14Rxcpp46dXV/W4vgOXorG15iMc4/EVqZB2yTrOMZsOY8SGVeLVE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(9686003)(5660300002)(7696005)(8936002)(55016002)(2906002)(86362001)(8676002)(52536014)(110136005)(26005)(6506007)(33656002)(64756008)(66556008)(66476007)(91956017)(76116006)(186003)(478600001)(316002)(558084003)(71200400001)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ER8PtQD9soG/jbwgbRD7tvGyH9CBNo2dTT2x3CE2C5my8b8EtXU5DXGqCMzM/NF6+7+b7fk0WUvJj9L8rTQK+XiRgN+H592SAvbMdLFpI4d4L11mNY9eDBQMqgFveyPm5AUMDDSVBXMwqRVPttj6UOJ6A+Yu5Ckw54bcio0jWojGSU96kQKHQ+AMM2TWa8t9RHKbMo+9tOj4NR1FrpgTdAicMORpmZOOOgAItf9zcTRnfoWIu5psS/t/yxXDMHZQjAqwntP5ycssBJ1BxsdHOLN5zs1ryGdFzDBcxnAejhW0hiuP7TJP9iahg2D7rdhf2Z6ez+KVdrzTXmVZ/+q2nJK4H9da57b9ZovAqshuYlOdnM2YPG1GzKYgP6vK5kEUQ9mbRnXCVlB9S1JUf2BZa9zpSw9PAK8jRSAZs1nuUpQkSZ+HhVTMHZuuBwKA8aRwYpW1Ob5EebFZKGqI1OjlNDBWr0rPZnNWZkUhHgYYTIklfuCnNGwCRC6srEyqXdvC
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d7ce4b-6a31-4d0c-6085-08d7fbd4f586
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 09:13:56.5808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: frHEDqy7HUNimhAc8/KmKbkrmnn6olNU+Y4Je32JyRuzLreFqi1M5dCFG93G9U1fTfJQgwLcmhJbupMpw8atjfvJcOOLGUgSQZnxIUai2aA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0401MB3637
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

This fixes the kmemleak and root leak detector complaints I =0A=
was experiencing with btrfs/028. I did not run a full fstests=0A=
though.=0A=
=0A=
Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
