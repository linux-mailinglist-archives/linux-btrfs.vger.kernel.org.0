Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B81AD940
	for <lists+linux-btrfs@lfdr.de>; Fri, 17 Apr 2020 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgDQI4q (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 17 Apr 2020 04:56:46 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19232 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729889AbgDQI4o (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 17 Apr 2020 04:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587113804; x=1618649804;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Uhcerzg1yvaTtX+mLgoRb4mPlLSQ1TYhhkuf98A6oGHu3Ku9iBBUkh/K
   zXJyai0qzxZOykG3ZUdfeBZf8J3bZy9xAS5m9xhkjTpsIkBVRHWgVd8v4
   ey59FLwlojs7x4Or88/TJNS6dZHs/6xQ9uX0Xofd73j8+S9HBBK46ON0u
   d9u7bnrtRfYUjKmIcCdh3bAQ174cMk5xI9l/ArX8HMIjfpq6K3gJKmBwE
   5XZK69oWAqdXhXPnDAfhA3QZ0x00osFR9+hs/0/0jHMkgUk5VJPOHenV1
   QpYY54WzJZuSU0nw+7XhdncHQ1PprRdrqRzFxCgtmkRzHti3s+r2NTwl6
   Q==;
IronPort-SDR: aJT24fd/5Ao/Yx7++Ypa1QG7ZJdbnNjzABmQJpzhVcYcZvrve7hGhvoF6o+McZs0OHo2PZqrt8
 g8/RbLQv7gD0YyRaWSzmywYxSyeX7tw9DclmEnfQlfvPKVwkC3t28tyKnwgE8CWiUOBwfkWmAV
 VOKDhXb1f/aLG4s8nocOpnwtc8aRUmaEiUeHzQ+UUsxptIaGn+fsLaeYLRdi80dnJZKX2UozGI
 JC362Is8IeO3wVwYwT0oLxYQ8GfWkXRwsj1WZNVNzJWclAyMBdWw4lFtq+G2kRMCWiGclbKzVn
 exA=
X-IronPort-AV: E=Sophos;i="5.72,394,1580745600"; 
   d="scan'208";a="136980855"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2020 16:56:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bfLzqr7N0XIWGGcG18zIvFRqtWrxEumdn9YnGwXVaLLfROFVfnZcBU6xrwfZQM3S1hcztquvzs1eUaNzK97v6VP0URIlmj/FUz4yCFfmv9yfr8TqExwiv4GqlMj5tzRWZ5xImmAO7+AsJl5zRIwFtfQYCA486IizGQCI9IRqo2mzNFw4QPYhTx0ITeKu7dqXEWBCR5/VKxfJW70EFWlYEgCEGi5/iIWp6cTcWkliDO5N2eVw56xp6HLqDb2+XJwY2Xf9qgsXjBbJzblQiiFhUKyg2pQPLfsfCqKePGrP1XpxGlBpkAuLZ5H1H4mF8oNIC4m4RfjnQNgs2oZ1T/MerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FKowA1MaCgQXfpxrMvLfnYsLvf5baJP+CdZMiTuonD02yAILgd7luF/cMuV+e+jcK1C258IDyPWwCZH6zcCZzC1GlWKYfN1NUxe63l9Bi8HykuPpXKFX4E6qGYkM9Nq9sbjr8Lt0DnyNL6hFL1ZGlYrSAgsPkIpqTB5FTLXh/x8d2USAki8WEwZHxjg/JNXfuLjhKpA8e3j2YkP729yMh6kjbQH/V6cIe7jrRFT+v8pdFRJaGpjVFVvZHQjObPN+0e4Z2Vl9/OpoBkMFMucgCSYSOMabbA2bokT9FMFV41xfahExVPsn2YJAIHPdZOuKgJ5nxVbDViIv8gQ2jSk1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=fTbpedwFvQeSGFK6UH1EjIHMpk+UGGB70isT/8gFWg/R+FnJfYWg6z5zExjScNX/VFe38zVkwPuwmtfEm4lcxzFOPquAc+XX3TAKXjiPoGB7qwVBAsouoCI75GkCg85m9qc/bTjMRTmkaKiIinX6gDazkcAxBVqeX6+a0WAEdT4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3551.namprd04.prod.outlook.com
 (2603:10b6:803:45::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.24; Fri, 17 Apr
 2020 08:56:42 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 08:56:42 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Marek Behun <marek.behun@nic.cz>
Subject: Re: [PATCH] btrfs-progs: Remove the duplicated @level parameter for
 btrfs_bin_search()
Thread-Topic: [PATCH] btrfs-progs: Remove the duplicated @level parameter for
 btrfs_bin_search()
Thread-Index: AQHWFIdWnWEuRuZLD0qiuZGVk5CkvQ==
Date:   Fri, 17 Apr 2020 08:56:42 +0000
Message-ID: <SN4PR0401MB3598EC74DDAFAE58926D0BA39BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200417071029.66979-1-wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6784395d-5001-4007-bfb0-08d7e2ad3fd3
x-ms-traffictypediagnostic: SN4PR0401MB3551:
x-microsoft-antispam-prvs: <SN4PR0401MB35513FEB0A38E064F5D378DD9BD90@SN4PR0401MB3551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0376ECF4DD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(186003)(5660300002)(558084003)(6506007)(71200400001)(26005)(55016002)(9686003)(52536014)(33656002)(86362001)(7696005)(81156014)(4270600006)(8676002)(2906002)(8936002)(66946007)(76116006)(316002)(66476007)(66556008)(64756008)(66446008)(91956017)(19618925003)(110136005)(478600001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K1iwlvDfDTRc9qVIP3tzAnFFxbBGAMQlVgjMJAcZNpeMrQfy0u5beSvQ7jGE0EuE39KF/YO5m02lwftc1324nY+QSpSxiq69wfD+6W64D3fb0HWDEeOyjA7+8F0L0ovR5efXCm4b87yLJIuLMIEjpI3ggwQfsdonPEMsF0+93Guy6r7tdC/h/rR7lXjSub9LRSUUgqrRE3c0A0C3tkvy3O9dH7W8K8txieBWMvs/bDjwDcn3mwjjdNjhYsOCT+j3+yKdwu+D0qnGI+TwCRY5PGr9ERqcj21XXBDPIYYywckKR+HF9IFJ7mlxo7nCj86rXO9ZUXqBykXeJ1625qEskmwlBBTS66jTO3x0nI0u2kOM7IPjtfBbrBK7y6aYT0GIWMUHTl+XAwkP1WiH9seZ8cwmV66aPwkSMr2GmWg3JzY+SWncNt/vtjEfNIBv50Ge
x-ms-exchange-antispam-messagedata: vZLiwluSrRApy0lNW5comUh8HzFIbhz3w3q5B+IwAc0RNP2dEc2zI/vMyJuEkJRKGTDwTOi0lINv4Wr9vLYBjIK8Whc2JARGDO8ZvecPXQytwrW0SW9llGN0iOyG8gnI4A/at3BrmmZchZrSh6ynww==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6784395d-5001-4007-bfb0-08d7e2ad3fd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2020 08:56:42.3347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IG9wybYmeBO6dseuwoDOZ6xwFI/UinWxFaj+PxO3niw7ETzLyeHRJW0VJO/FDmV2vD718gNehvsnJ8Ep1F5vxgLFMuM4AwAQJjagt54bctw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3551
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
