Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A701525E6D
	for <lists+linux-btrfs@lfdr.de>; Fri, 13 May 2022 11:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378720AbiEMJPq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 13 May 2022 05:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244743AbiEMJPp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 13 May 2022 05:15:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD4F38A5
        for <linux-btrfs@vger.kernel.org>; Fri, 13 May 2022 02:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652433343; x=1683969343;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=os06HDTXP/ngrdiKawzJzwWINi3qCodLwBz5fGHdqKM=;
  b=TnbyBM40KXkhUYgZHh4wodNybUcwXDWhp9ZbETn5RBqoc7vXwaQ3W9Uy
   wHqyinPb11MmEhh8j2eEzztM65S0bhwbjFKDbR5+4P18JnGEh2XO0m01b
   BulRdihJkPRQGQAoJNh4ggikR++zWwNgZLdZI6sV8yvvGFGQgsJ798Mj6
   GxuO7O+e1D7+YfHwiZ74kOzs1btMpJjwp4IS6fqqNaZmHi73Z5N9O5Rn9
   Jh+mdUd4711I1YOnU181FyMCISkU9D6O+p+FBCweMzMd272bBChnO/m8Y
   R2+KwD4gj7VYyU4wUhh7NtWIQCB3vqHWa9A4PSJl1Sgd/fSuQlk/HCgp5
   w==;
X-IronPort-AV: E=Sophos;i="5.91,221,1647273600"; 
   d="scan'208";a="304472128"
Received: from mail-mw2nam12lp2049.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.49])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2022 17:15:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyZOXdKrIcSc8RLpLsIVogKhHsw6xWOawlSfRKvvo2lpAYIB6dNohuWlbyxqa4ciyt9AKI6qqXJxbG5tIXvGdLNDyyz9Z8F10afuimQAAUuE6V+n9pqH2jpjyT57Hk8e0kWQzT6IzqZK1MzsdKemLwGwZJnK5cCMVhSMHDLlIQtGkL9tbFUy0KwuLgwSpOkgnXf0at1Ap9McpudFH4xnbtWWnbne7q3SSfDonVvOkKd30nFM2kNQi8aXYpZkhFDroMQ8w7lEJH6eElWA/qgmjk6TWoMmq8Mi1uyJwBGz0nS2W2wL7IRdt1KcbrqK7qxtwTS33vEZdEn8m2r3j1hGPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fy/9OCRC4kMlxCHGI/0yv0/FvSbmdZoHHFyqBuFRi5Q=;
 b=SzUB6/oOR6AAwkrJyJGW8twMwqVy4ZeKRRnYYD6Hc5FluM5PaNQ4KkyxldTdMpDiZ0liH8S1yTWO8EWaeR9uMZ/Afwft4wN6TNo+m5dEI/oykAwvjYxVrFhmp/XnU9Iqc/Ni2XvpMxLoM8Lkh/2TFNYp8r0m47XB23Mc4WJVicrXTrMXnpIT+w8IjcchqhH2SxftT2rXRC/evU5IYuS8FZkT5qzwvhQBLVUXemHX8WIX3h1vUc8i6TkEcll+diwoid+keB5TkkN8gItUj5F7RmIEUIYXmmbA5Za50STg37quLtXw2guIWAmcNpEM/GkLllA2Me5J+zEPKTE0oB6W5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fy/9OCRC4kMlxCHGI/0yv0/FvSbmdZoHHFyqBuFRi5Q=;
 b=HZxnQ8rg05Su5ekfbh9tJpdQnyuUWKpZ9KZW3fnBWgv43WM9vr+wE8cHQyqIgDAAvlKStB+wwpcmRfVrlGV3fgaud2CcH0Ed8pI3wQSs2ob9KzpkpdVvhWjqrteP6T9sXY8V/PnqTD16Am3Ij3PQIfayxWD7YOy9Yyko3z2d/kU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN2PR04MB2240.namprd04.prod.outlook.com (2603:10b6:804:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.15; Fri, 13 May
 2022 09:15:39 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5250.015; Fri, 13 May 2022
 09:15:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Qu Wenruo <wqu@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 4/4] btrfs: use btrfs_raid_array[].ncopies in
 btrfs_num_copies()
Thread-Topic: [PATCH 4/4] btrfs: use btrfs_raid_array[].ncopies in
 btrfs_num_copies()
Thread-Index: AQHYZqRPMtqV3WP2mUKwGY03tL2znw==
Date:   Fri, 13 May 2022 09:15:39 +0000
Message-ID: <PH0PR04MB7416E0CEDDA84965B0FDD2919BCA9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1652428644.git.wqu@suse.com>
 <a51939d1e568f36135c8f0383a4f34da5bda0f4b.1652428644.git.wqu@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 900f5e21-a889-4b97-5ec4-08da34c125c6
x-ms-traffictypediagnostic: SN2PR04MB2240:EE_
x-microsoft-antispam-prvs: <SN2PR04MB22407609119AC9343AA8BABE9BCA9@SN2PR04MB2240.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61iqlcaTMjv3O3H1qdZiSfgi6j3Wof75SqSeWD+Tk0O/ELB3sI0IvX+25mXfaxH4cPshUoKBX6P6GT/1XzMb5ei945L6eV6IKjS+q9+jvl7+vGpLXzEIJ31XRCiXHeyMPrlynBDdSCVZVXTZi3K5+PPrM1lmc1yBn6hZ6tFMrfUs+9Ty+KUeWs8CpxSRbTsU5ot+i0BNtU5FZllYG9/pW4/dYzWmqy2HgnimZ8mmLgqvFPlGUE5PUi6GfSZcIKD6uOksNG0UNTgEk46al5yCD/Xy8oA49K9wpDrtdAp47m48LHUbnzjJgEMw8sbarpRda0NLIKaQqCNET3NsIA9dtSoUu3j4uwgptIFJxA2T3MQE6zVhZ3y8Mn4mUWQcSSV7WszPhIP/WXvKBFVpS7uMcebKsIWvlSII3+SSameOzl5RmeLA9yYKFYELoEzpquj8QB7j0z9Cr8Zu5q6ZGm2VL3ml80YqnOGtRnRlwkB6zmiAjJoIZSjR7DhBQJfm9hRerX2YScOYorfdFfg/y7kz7uQl6TowMxCnc+Hm0LBUVWpsf0RrxAzuz5wVLFCQdM1on2KaT1OrCj4ab+uktDBaxjzKZqLiRMBGAwFnTYWb/ZJkjcVjNln/0/7m3lOXkK+8Yzep9qgEhBp1HilkSSx2bWEuU4eiQ09LYjZifqaVl+A1ilolA3A00uUTOqqLNuhOcA5xAd6AKS1o8aeBSdavJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(82960400001)(8936002)(186003)(110136005)(4744005)(2906002)(316002)(508600001)(5660300002)(86362001)(71200400001)(122000001)(52536014)(26005)(53546011)(9686003)(6506007)(66556008)(64756008)(66446008)(66476007)(66946007)(7696005)(38100700002)(38070700005)(76116006)(83380400001)(55016003)(8676002)(33656002)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?82yDXRZXNkGZPkhjkw8Pjp93fPn3SalzZ1Kb6ERixRFOmAQYHrzugx+zZKq6?=
 =?us-ascii?Q?T3OOanYY/Romu9Vs2UTLz7GNiVcpeg7HB0XO0r/DDvDik6aePJFrbZqz4NUA?=
 =?us-ascii?Q?ZWMzM+7sdPik3AqFV6eWU8fDPCHLzIj4Lcg/eIpDPBsnSnDXkZxouJubCwhX?=
 =?us-ascii?Q?tYZbTsQLuZSeiXT54bq9dCd+EdxIVMGIGFz+ilVyBGLM25bIkQpMis9ZDC8G?=
 =?us-ascii?Q?3SU3YSUjF9udOVYa9K3xg37rAVEvQbGbyZSS1kh4cwQikF9/no/LNmdD+nqm?=
 =?us-ascii?Q?5RNKsNb7DMXAvLtrP7FfqJ2JxBWsAJZ0jy7oNU3HvHEtDpx+W0BY+1RDKJhd?=
 =?us-ascii?Q?RZ3rWoHBoigrJCyWC0eMRL50j4Q3d1DrHSxW5wBK5Myp5k+UXr9zUfWXWe8H?=
 =?us-ascii?Q?AcXK27W9UApsz6pHC29nwbVLuMvVk0flJ5fewqXqJLYitWD3MU/NHywWrwEq?=
 =?us-ascii?Q?yCXUs6Vhntt3PSpG+GT9XmBnpGwALlqbkU7oQ6psgHla6E+kXvdh6JSRlY8Q?=
 =?us-ascii?Q?hnsZ2VhzP6xb6agT3wjT9abIULzyNaa/JJaRM9dfe0qmI2AvNzbj2xxlUqBy?=
 =?us-ascii?Q?YJSI33yHfXtkBivyB7YNYGf2cD2M1vLVN29s2ypy1CngXeZSm0NVyXDy1mL7?=
 =?us-ascii?Q?gcW9BpRONNlYInpoa7B78XXqlOFMCI8wOKT9o91Lrakgoip6L+CN+d4Oo54j?=
 =?us-ascii?Q?vA+rc5c2GKZJORh07q3LPIiuLVjeZ5EYQmwf8ZWT4/dVw4mV/puMcRIimaCy?=
 =?us-ascii?Q?ajrNJusCi07N8R3qvZTNY71516tJf7TVae7zoWuQ5xhLYX3WhXprndbWEAYU?=
 =?us-ascii?Q?1Pj/sUr7eYmmxEV33FMliTN7KJ3vmjs0+3DMATo0DMbsJVo1J2sVf+wGCykY?=
 =?us-ascii?Q?JZixqz50mdipFIgKgrhNB1mehVUzm7XTXl771TrAPARhcB5YKixO/XdCVY8q?=
 =?us-ascii?Q?h/xEtqMUmD/U61WkLEA1O/YHt7kSSIvpZ0vAr6NYACI0VBXO/dCN6+qM/pWx?=
 =?us-ascii?Q?9/0YSqxlI4N3y5zCMG6z0+Cuy5I590+W3t126cty8WpTfA1n4v5s0l56rAni?=
 =?us-ascii?Q?L76dYPZdkjGzBu+eMuevGKMbsgO8iPampqXGHUtTVupOa73ToNa41i9IsHDa?=
 =?us-ascii?Q?roZHirmMC3uF/5cupeYJfBf6eNyDaJMdJP3++7vHojg/7C9kXWAZExsBci6K?=
 =?us-ascii?Q?Ra1YmQGRIcl/GbOet6FYc7khmnR7iuDn6W1OGxJ/zHSLa90/ccAkLmF2K4zo?=
 =?us-ascii?Q?a0DYnqrZyFLnUSLa3ACiwVDPu9YGrlPTKk91+C0D6n2okVRMVRuurbtAp1hf?=
 =?us-ascii?Q?BodzH4awJT4HT5r1JncAIOnbGQtr3bWQ1SZ/IeP5EaSJPYzBzwD/3nwlwV4G?=
 =?us-ascii?Q?g2l8v6zBsX8xOnJEzigLsM+hRuTpWe+Yr6ILfBvk2bStgS7Ay8nIuKKU5Txs?=
 =?us-ascii?Q?WOPyAGA4Z0oy1Ip9BfgNfXOFowgBtXpgkmyGC45M/wkHKFNAsdUbhbKp2QYV?=
 =?us-ascii?Q?kiRrMGxJztMh0fd2RV6+rrxoJkfO58J1XsV1O37bwa8MeJUWtxH33f5BAiiX?=
 =?us-ascii?Q?Dz/quH09ydTEsoymW/w9bTKAf2ORycWDa8LD19we0UnfjGuIVHq/nk3AHXVs?=
 =?us-ascii?Q?7UH+9VopeSD9YfXZOM/+RRQk4TcLqXjhOCExQlOgO1WbS8253MzkMJZZtZRR?=
 =?us-ascii?Q?FYfGRSl3x42wuSocBlsCZngzTBjZUuzOQvmD2uB7v91V1cJU9q5yFDljy34r?=
 =?us-ascii?Q?B2LVWm9/bdJpCisTj5akRtM5J+eQZNM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 900f5e21-a889-4b97-5ec4-08da34c125c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 09:15:39.3123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cw+bDFUaQWwdhSVJUKRqwWJmBhps7vlkFpGFM3dMRH7uXAnOOqjonZdUeumXTMmhIEY2hZKi8mNhySHFrQfNLWn022h8XnJPrkJ+sq8P6dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2240
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/05/2022 10:34, Qu Wenruo wrote:=0A=
>  	map =3D em->map_lookup;=0A=
> -	if (map->type & (BTRFS_BLOCK_GROUP_DUP | BTRFS_BLOCK_GROUP_RAID1_MASK))=
=0A=
> -		ret =3D map->num_stripes;=0A=
> -	else if (map->type & BTRFS_BLOCK_GROUP_RAID10)=0A=
> -		ret =3D map->sub_stripes;=0A=
> +	index =3D btrfs_bg_flags_to_raid_index(map->type);=0A=
> +=0A=
> +	if (!(map->type & BTRFS_BLOCK_GROUP_RAID56_MASK))=0A=
> +		/* Non-raid56, use their ncopies from btrfs_raid_array[]. */=0A=
> +		ret =3D btrfs_raid_array[index].ncopies;=0A=
>  	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)=0A=
>  		ret =3D 2;=0A=
>  	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)=0A=
=0A=
Here I'm not 100% sure. RAID10 used sub_stripes and now it's using ncopies.=
=0A=
The code still produces the same result, as for RAID10 ncopies =3D=3D sub_s=
tripes,=0A=
but semantically it's different (I think).=0A=
