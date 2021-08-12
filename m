Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9575F3EA6B1
	for <lists+linux-btrfs@lfdr.de>; Thu, 12 Aug 2021 16:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbhHLOl3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 12 Aug 2021 10:41:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17679 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhHLOl2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 12 Aug 2021 10:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628779262; x=1660315262;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7akmuwHiPMcIWLjsa7yLFfueVwKn27/OjwCAYy20iKw=;
  b=XJgBWVkV8NFBCXTK2s0MBdC0cyKLU6XTt7ICUfiwdWr05Mfx0H44Ws/j
   YCYu/IRwoylJuzYliFKCibFFhhEVZH4VhCGdKsxCRdZ3bBfX9ytJYyZBc
   BtNjwRWWsw2xEr8xiF5hdmj9Jia10vxtMzEeRFfC4/OpZOvxt7YMpxX0i
   zIUvgjxlv9xEzWVJ1hRRI0gSwPyGT6hF0uvHK2xXJIsYrpPCyn+e+63UM
   FmGrl6yF5/4qR0L83FKECMeNCJzi5m35Ypl4QTkuwT9GSlQI7ebQNhweQ
   QuB8QRX6zJnhsD987g/jpG9Rea4vhyomDEQkCNvRXWG98wu67yQvL6lk/
   g==;
X-IronPort-AV: E=Sophos;i="5.84,316,1620662400"; 
   d="scan'208";a="181853650"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Aug 2021 22:41:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hDxX+KwJ+VEi9mhc+h7jA2txxutdyjqa3mVNUk3S/kYDgULQbMIx8/wqFZowPh8CD7IBSeGubL/9F2MdmL927LJGRobGZHPaRDjlAMXQ0mt3apmNc/tslPeYRBnoHL3SnnxxJ2cmsggZeAYJ4L2Wdc2NsW5XVGuJ6QYE4Wr4T6bpXbr3nV9PddNNDYmgddVSMVlckmlYUMpzmtq/GghFcV2kpHGAcTNycTrmU8U3z3BD+g7hPhkzuT2u62qsWdURnu5cotfZKJOnD8WKmUPJtQ7ovWMoJVN6xHmzvAkwjdtVm/iTQ+E3CIRLxeyEaDGT/RL7T9ONZRpA+Kg5pUSrfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7akmuwHiPMcIWLjsa7yLFfueVwKn27/OjwCAYy20iKw=;
 b=mTCeioxwMHaPmWOxgclxwdxYZRHJo8aHhT32uSwqhlbqZCwWX7/XBjKG3RQwSdIwMj1z2PxZyC/ZqVvmw4+fYJbtzaeSrdRPnQnuy+guSocyENbsKc9y5mn3jqtD8TvFfBAcTafdtAN3b6XdewhQWaQ2jXBEfLxXhhULii6Clh28KnI4CJvxPhOvIsiMdavME+ghQh7SASXE27Ee7wl+0b4r0HgEezAlwFaNa/qlRAXS0OYUXpBdfiH/gai8fdIclffCUJQOwrwqSAg67I151GG84FfGYeX4quVsuV6gGOaReywRIhPomtKSksYliUiCjfpvx0eTS6H3yRWw9jcoRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7akmuwHiPMcIWLjsa7yLFfueVwKn27/OjwCAYy20iKw=;
 b=SGoU9q40NOUVV0l0cYnmN2C8GqlXKvu7AFULml5pNoWDjhYT6sVuGS9qT3/Yh4dUt9+RoQd31xa3yZSMJ0e2jD1eAEUFhmUFppP1On1iEvb0MWB9CyD0XsvuYUg8HbXbo/1Vvnjo78SQOYLB7W7hCY3KYyfe52yc0Kk7FXuRTiE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7256.namprd04.prod.outlook.com (2603:10b6:510:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Thu, 12 Aug
 2021 14:40:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4415.016; Thu, 12 Aug 2021
 14:40:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Filipe Manana <fdmanana@suse.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] btrfs: zoned: exclude relocation and page writeback
Thread-Topic: [PATCH] btrfs: zoned: exclude relocation and page writeback
Thread-Index: AQHXj4GI9FRDQitxX0OL8mIJT/tTOA==
Date:   Thu, 12 Aug 2021 14:40:59 +0000
Message-ID: <PH0PR04MB7416785CF79EF72CCDCF931E9BF99@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <a858fb2ff980db27b3638e92f7d2d7a416b8e81e.1628776260.git.johannes.thumshirn@wdc.com>
 <20210812142558.GI5047@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fadca2cf-2770-4c41-a788-08d95d9f337b
x-ms-traffictypediagnostic: PH0PR04MB7256:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7256B59CB52B9397552F6B5E9BF99@PH0PR04MB7256.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l2CYwTuXppoKAvtmiSTq1wcQmwVZicYH8nPbL/C51gcNEdQmCTFgSoO10bTXZFtR/EQ8FphPS8/528BeOqVSYCuknJI2SwnCWzVX7jROLR37YPaqDdXSZLJUFOm9W/r/gflUUSzDMr2z0U15WHrAlpJZI3Fo2ATAongnGYTjmjo2imtPSsbGF7AT37irJNdb5SLqg+kS1hA8+FNbuSWO3eJJTnS6HsB5U0+/GywLq9vN5/Vaxz74PAuyrPBsAW8xe+AKfLlUCt8nZVPhtSoPTOK/KG+k93who9NcSlW2B9wtl/+yY7PXnNUuHnM5JX8AIOXLkhsI5E5csCWhPghSZ0f4A1DMY5A7EO903bc8jCffzQSS8OVjVrv+GYFiDm0DAMOeFkspXoTO2IWuJnizlzXXo86IBm5gxgfwoqEJ3KLwPu0//1+QD/NkJ9cFmI6tP84mdfjgfE+ZgxAGQ2+rhZYOpppb7q3YKfhGq9qjoW6Rl6WlTyzz+g21ZfolQ4snTAVM7oLvgAEqHdTEBe4TDQWUw5Ln0PmtMzTVi6QpQsHrqdu+lxXkS3GBQyE9Zs01jkEygpWUUzNSgc7hkj4YLT+xtGrIZJao2WN8S4kX0HDT1bXF+bsiSZeR/n3MuTZ8eA2Wk1fh0AwT/DzFFpieymqal9IZghxXbxaU1b1DsyTj/9ONjHj7Dgh/UmxSbBy0xsWhFXQB7hBRMYZj3CbzQQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(8936002)(76116006)(7696005)(38070700005)(54906003)(66946007)(122000001)(38100700002)(8676002)(316002)(4744005)(55016002)(83380400001)(9686003)(6916009)(53546011)(5660300002)(66556008)(66476007)(6506007)(2906002)(33656002)(86362001)(478600001)(71200400001)(4326008)(64756008)(186003)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L6Yb7dRpJnOodTwU9IgG9KegTs8yiGLlR1/4mKD101NCLXvsZnJu4N2QVnH7?=
 =?us-ascii?Q?iK9tnoW4RfrkTQp6uTJ9XGx5p4LiyVn/UzUiDwV9zgph39d6yPgckwUMmt2v?=
 =?us-ascii?Q?0r8d4wagQZfA9XEYUJ5ddkH8P9H56UZONpS+uXkThoucxMpVtG3/7TWRL6r6?=
 =?us-ascii?Q?vcC7dkM0va+pOCKweHfP5+QmgyH8rB3XuNL2GK7uOqVF7pXkNy32JLWGz9Dv?=
 =?us-ascii?Q?EJZfyiFEbcWpNnKXWB3KySB6ZcPYdT9/cKwoDr+eYVfp9sdM2gzVh/17jYqA?=
 =?us-ascii?Q?AHHgGgeI+Tf1l7YA/Kto7N8Ia6BAgzV+VNgvNRukGnZTCz03frYLlakPc+uO?=
 =?us-ascii?Q?zTtGMbhsM1YJQQ4w9N2AoMJVq+5ijEBBb+ArK22ViHcb9TTSCzWH/eeOK7M2?=
 =?us-ascii?Q?p3h5G4eICTIk0CYW04CHorQHOYGEenz+5h+WDCVrL/FAaCqdb6Tz41cKaghl?=
 =?us-ascii?Q?vZeYYMY9JFCQ19a2Uup3owla9bNzlNSg0moHv1ZmtcxPsXzihyOjVnQFhCrR?=
 =?us-ascii?Q?4/4DZfgFknotSJMuYAehzNXATR6ZWbOivGUx96+uor4uN/6BbyUeaaULK3U2?=
 =?us-ascii?Q?GQ6Hgj3OZP33uzbTHRbQ+0tOqNgS+pfye1i18u2Au1oqQr4XnAy7r/h1mn2p?=
 =?us-ascii?Q?ntzI8U9/5+sp8L6d9uHqWDAelEhh5/oKE21ajJaC4epu4pHYeHmgXjjFYDvA?=
 =?us-ascii?Q?Veu81PucSGPO6XixefNduXTHyScB7T9GWmNJbCNTcU2SFyyr6TQyXCxgp1Ps?=
 =?us-ascii?Q?Txlfelws/c4yKYTGd7+WAMa9Co6do4ux3E90hfNgUGMwU8S0IRykT4cvSVDB?=
 =?us-ascii?Q?9IOI1T+AcfYkLnLaQwPC4i17YUCJEsd/OKBcnCBL7i2YpOo4JMEVh4zzVdTv?=
 =?us-ascii?Q?5y3huBq93u4clAgP0ThU9amNkq5LceWvtLDAfU91w6Mao1UYiLK/jC0+XRG9?=
 =?us-ascii?Q?PDlTlcTXGS24g9s1rarFwf66Bv/gG2U+9JCrCYO02jZNI9ow15FLFVmDhBVN?=
 =?us-ascii?Q?b4lJ03OzrNLINre/AhH5Nwv9TUBZSchz0zSc15kjOHM4iMAYMyfVWI75RQZG?=
 =?us-ascii?Q?QnMN8qep/tm0pKq2Jq79VTYNziQNLEtuyPB4wxBSznlmE5WCsAazwMAwLLV2?=
 =?us-ascii?Q?OYW8URP+ASOAkfYY3wx6Mjpyshfk9qZqWDBq23w5/JeeK29FzcoXVKJrFNvN?=
 =?us-ascii?Q?rST5WqL46jR+cM3lT5/5qdnCGNPDZwWeApyY9UXtiK74p2K3/7QcxTceZscV?=
 =?us-ascii?Q?/bUnXOp8VWRr/TG75+Nleqnw9n+DXvV+oSZkZdqg+0R55pED4FOPTFMcyntO?=
 =?us-ascii?Q?Wa/bNyRR9zQZh9N+9gSyDdXsDKmtyO0tnmRBR30d3uXleHL3E0zJ/aJdEz5C?=
 =?us-ascii?Q?HSeWvEujDfURqnCGA9wZRHLzMtBOEu0saBIHlUKfbZvihfsYfQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fadca2cf-2770-4c41-a788-08d95d9f337b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2021 14:40:59.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MgUpTRcJOqP9YNPVT0H0HdonwsRXtv5kCe40yX7uoziGjTDZOLB6rFCgwcfp3TdmRU5Dc3JMc9h74w07203CxlyyzTF4AnKPIIorZh4uLxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7256
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 12/08/2021 16:28, David Sterba wrote:=0A=
> That's a lot of new bytes for an inode, and just for zoned mode. Is=0A=
> there another way how to synchronize that? Like some inode state bit and=
=0A=
> then waiting on it, using the generic wait queues and API like=0A=
> wait_var_event?=0A=
=0A=
I can look into that yes.=0A=
=0A=
Filipe originally suggested using the inode_lock() which would avoid the=0A=
new mutex as well. I went away from using the inode_lock() mainly for =0A=
documentation purposes but I can call btrfs_inode_lock() from =0A=
btrfs_zoned_relocation_io_lock() as well.=0A=
=0A=
I'll try implementing #1 and if that fails see if #2 is usable.=0A=
=0A=
The longer alternative that Naohiro and Damien also suggested is avoiding=
=0A=
zone append on relocation and running a block group that is a target for =
=0A=
relocation at QD=3D1 but that is way more intrusive and not a good candidat=
e=0A=
for stable IMHO.=0A=
=0A=
=0A=
