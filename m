Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE093F268F
	for <lists+linux-btrfs@lfdr.de>; Fri, 20 Aug 2021 07:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhHTFqO (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 20 Aug 2021 01:46:14 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:44484 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231949AbhHTFqM (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Fri, 20 Aug 2021 01:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629438334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vov5cLNvQD03P7Xdh28piMo89+RSjN/xVLyeGJvrt+E=;
        b=Z7GQejiBjEzmjAlP6bXxVSggg5/qb3Qe4XQ+G5ahvmL7KH1cOY+CREMQvzbh/e+f+h08yE
        XaPnCsNmCr6Wj8WWHcedssYfZhg9QKdAFu6wkQ906TUbMs7MhiDaOe/ejEHbh3LpknMV6r
        JJ7WvYCm7l8QJaMHGm/I1Ll0GRUgsMg=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2059.outbound.protection.outlook.com [104.47.4.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-39-ttoQ7Jg9OLWhRnliNTGNOw-1; Fri, 20 Aug 2021 07:45:33 +0200
X-MC-Unique: ttoQ7Jg9OLWhRnliNTGNOw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5BCjd3aiSZiSDXpM2Xf29jt0b2tRFDZMW40uac+QSXAHXgbeJlN4/jVYxLzR4VYXBCcr1CbVykAi/LNGxik9iw6EfmCyXlgL/wvWx9m/Gp1vGODC0+cjoADxcPjBZ2QeHBLFeYCar0M2X/AAQSUsqyYHBzwxOZ1wYhRxpqxQoxDKyc3TYpbifghu4pWA57mwW1gE9bTHRtE1CSYnQxl61mT8YeTWNGeXGf0XXc6BBPfxMuEYrKDbzBKCtn8PwDlNbKxMkNFMJc/YTzC/1rjnTNBnc9UQlKGxPJTedut4jQD5jENFhGZm2qGQPDMoiPW6QHHm/dzNTTfN6OLpa9vjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytfICVG642cSAyyq3h51BX51RJLUXZm0zhHwsu2Zc+M=;
 b=XXLdxRyaHhXARj/sbeAQUx4SjOEuKjbHs6Rk107OTM65Z1H9QBCf8hxOwqcUXMAfUJ5SLNNG0BAMkRtfnU1u3Lm1Alk1h003mWZC3sksvO6+rIYz4GvxStK1CbUDlShm0OF2A/pXH5o8WeVlXuBpXDXz3Qiu/TyUtfhSYVHgFsMyEAgB+imYoiYYNWUe3mYxsDhNzMLi9C3iJ2uOsfUFRzhyjiMur4pxkNTB5+iVUfeUrWIZXf11ugMZsEey4ub5g8HuTvULekrURKiIiMdxXxqzGXeOI3jAMmzCvAB8i+ia6FN3v+1SiYz1Wi5MlFoWjYBMDiWFqakNcyBVGlpb2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AS8PR04MB7494.eurprd04.prod.outlook.com (2603:10a6:20b:23f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 05:45:33 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::3510:ed3f:66d7:cf48]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::3510:ed3f:66d7:cf48%7]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 05:45:32 +0000
Subject: Re: [PATCH 0/3] btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove
 ghost subvolume
From:   Qu Wenruo <wqu@suse.com>
To:     linux-btrfs@vger.kernel.org
References: <20210628101637.349718-1-wqu@suse.com>
Message-ID: <85072f74-863b-5509-9041-d3c7745d9257@suse.com>
Date:   Fri, 20 Aug 2021 13:45:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20210628101637.349718-1-wqu@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:40::30) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by BYAPR04CA0017.namprd04.prod.outlook.com (2603:10b6:a03:40::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.18 via Frontend Transport; Fri, 20 Aug 2021 05:45:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57915f1e-1e6a-4cb4-f2e4-08d9639db917
X-MS-TrafficTypeDiagnostic: AS8PR04MB7494:
X-Microsoft-Antispam-PRVS: <AS8PR04MB749442F700763819FDDFF5CAD6C19@AS8PR04MB7494.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBCvd7sKjcwWbwBowlXDfVvJTXw4USAhKB7Qfa4k9VueOVxOyvY0ilzEZuIWtgC4iLFqypLZ91HKI2FJPqfBbjQI5euSuVTLC+kwJzLCmF/0V4jaD4F0MJ4E4Zd8zFLB7BYO/71atl58mlQc7G7dh5nMcACxMjZdADe1Utl8q4TcSlK3O0tIJy8+g53GDm1DAWxbz2WP9Eh8/FDPktsAPlDSB0JCsnNxux9ScHjcPkkwfsA5h6VCeJBVIUsgQMeEK+Y9Gxtc/GvpoyyySLa6eRI0RweKxG2PYQnLkfjnUNeKRPMQeREMglId98mSENiTHrvP9fkvUYevc93yZZ9V4UHBbSdBDxxdMK+ldcPW6uPOPlmQYOwzzQVdBhcfJgJxQUNHhQQZhJEn4Tcqz50LhlpnoJNDdp1ckJVEOaFNS/uzD7eUvBNVhCo6CPRe+z7S9bdujpVgpO7F4Pz8UQ4Wv2xwhZF+GwawTafCZ7AZNLsoOjE3AL+ir35CyW65dinH6mULOFQLw9hzBwiQE/3AQb+0cs8uEVvs0ZERFQUZn8/ZkNFFbqZAwgGDUYFZ7NpqmfU2ps3Tu5H4rdgtKXmcuPDnHrZ4pApnM1WoVE/Bj6DoP813Stj2SHfb8LQ60dBoLoAIpad9ie/5z3eMkrCQNrK/WRUwN0KR3tTdDxFAH/HLCL4RgdBpOzHWfB8D6XjWzOYndE+XugR25EIAnZdhfG7qx2nrWsGSRO7XKOjG+IpZw+zib+P1n0fckQ4jvIvURtBa3qyURwsgSpudnFDsOa80834nRMTiuELI03jY4/X3e+uO3T9632LaBE/o6+47MhnV6u/ga2i8pEL1qAWejQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39850400004)(346002)(396003)(136003)(366004)(956004)(2616005)(5660300002)(186003)(38100700002)(6916009)(6486002)(478600001)(26005)(316002)(83380400001)(6666004)(66556008)(2906002)(66946007)(966005)(31696002)(66476007)(86362001)(8936002)(36756003)(6706004)(8676002)(16576012)(31686004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1mQBZ1uRQbHvZ1VgAxly8UYbUBjIULPBPA+/U4fV3WdsWHgkKr5XF8YfXRNZ?=
 =?us-ascii?Q?x5mR50VXX8qzJ48MbkR81M+jtKE71ZnCebpwiiRxH5OyVklfygzJlHkpaunI?=
 =?us-ascii?Q?7C+2SC9NREQtcD8WKqFbEKWtHP3Gqpl+FSiYRtllywCR+T+jNERg93SruAQp?=
 =?us-ascii?Q?uTne0TEXqfOHFr1fU07LjS1ZZhwvkJ9veL5HUn+GXBtMumH2dk4AIZ4vOEjD?=
 =?us-ascii?Q?qRNvPBPkMYKhnxgKk6++uUGDjhCIY7RZ3arG9P/dU5qVfmwK/jZUgvq5iKxW?=
 =?us-ascii?Q?rB4uFSBFuJeQpnacrbUE/9D2aBaoBAIjaf6swP6IzKmGTD1GldWhyi7p71xX?=
 =?us-ascii?Q?X8xHFusiP1D3ISV4l3zAaPKLz6nsJL+P6X+kfLpfhI+KdpMgAHi+s2k498LH?=
 =?us-ascii?Q?fSB7Vhn/8Ec5wkZ9lFsxv4i2ejTEK5ZN5hfWIrv1FtRZnooxvIOiC6Dv7Ho4?=
 =?us-ascii?Q?Cf6n3dVxCbmmQAipD4dH5C4PgQ3BwjGSEMbnj0QLbY9+TsgYFz5R0tIJZnIO?=
 =?us-ascii?Q?Ae+0Ira6oKqTeQGmS81gre5RrShta01+Ohx/ELka2mH01gwYevKb59zInxIv?=
 =?us-ascii?Q?Cxm8Oj+/da7SZKosK0YoR6Ug/KuB1wgIkl5T4fOaPA2ONc3MgpgqTtSKSjIJ?=
 =?us-ascii?Q?B6mQbUYLt6fz7W1V6rCjpwRrqullXQRYKAGjd4AwkDam4zJYZBX3CjsB/TNH?=
 =?us-ascii?Q?E5eP4TAPxN2ZLeCBuqCCdvfkkW6sQB0WtCM+knqYR0asUE4oqnX464GpLjho?=
 =?us-ascii?Q?zn+DvmTsnReh8VOGbPcjzHB/K6YajJqTF0ti/pN6m1Y9kGC3hnJEU8h71apS?=
 =?us-ascii?Q?PD0nE8Tb9X7xqLr+InUcBYHCJ4pvKzzmh2JhlWOujEux3k7DiBLJvKddTH9W?=
 =?us-ascii?Q?edg7I+XV2tP1YKKvouF0kEfRhtln/vwwTnRp4mu//KD7bz/hDP0TEN2bwTJ1?=
 =?us-ascii?Q?Be2fFOJJkQVjD4TWF+Uilf6zeXlyBTTw8Dqgpg1EFBU4pRXoeKZ6u6magM2o?=
 =?us-ascii?Q?gzKBG98/N5M9PKn60e3oUoi4n9D6alpcOQarj82rRnGfOjeqC3L87O+8k9dx?=
 =?us-ascii?Q?15ODGASHgI3WY489U3yq15tLkjUJ4Q6Tvq5bEJUqLt4ZqwIGVqc6ybbXsyZl?=
 =?us-ascii?Q?GW14Fd63DD40VEkieH27HBfaxXULC2wURFRS6LFnXrHNyG0PjjyVW3lAuRu9?=
 =?us-ascii?Q?+eiysSr6Gc9u2MljZU6JxlwYGw7Cyybl/jLrih0kQLE5dbO34QrQeN4emyTL?=
 =?us-ascii?Q?DVgamg6gMzpcC+tXPcYUP3z41UhrQ7e+RauVFMq5FdD13dPOL+uLAOVeV/25?=
 =?us-ascii?Q?DjUZM7ngclIKqzjzt0GKLJq0?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57915f1e-1e6a-4cb4-f2e4-08d9639db917
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 05:45:32.5354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDMzlpbVwUrowkuulEzs50ZxWhnV9cDlnZ0S2cJ3ihSYKB93XGW5cA/anmV/DY+Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7494
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Gentle ping?

Or we don't need this feature and just let btrfs-check to repair such=20
problem?

Thanks,
Qu

On 2021/6/28 =E4=B8=8B=E5=8D=886:16, Qu Wenruo wrote:
> Since we're busting ghost subvolumes, the branch is now called
> ghost_busters:
> https://github.com/adam900710/linux/tree/ghost_busters
>=20
> The first two patches are just cleanup found during the development.
>=20
> The first is a missing check for subvolid range, the missing check
> itself won't cause any harm, just returning -ENOENT from dentry lookup,
> other than the expected -EINVAL.
>=20
> The 2nd is a super old dead comment from the early age of btrfs.
>=20
> The final patch is the real work to allow patched "btrfs subvolume delete=
 -i"
> to delete ghost subvolume.
> Tested with the image dump of previous submitted btrfs-progs patchset.
>=20
> Qu Wenruo (3):
>    btrfs: return -EINVAL if some user wants to remove uuid/data_reloc
>      tree
>    btrfs: remove dead comment on btrfs_add_dead_root()
>    btrfs: allow BTRFS_IOC_SNAP_DESTROY_V2 to remove ghost subvolume
>=20
>   fs/btrfs/ioctl.c       | 81 +++++++++++++++++++++++++++++++++++++++++-
>   fs/btrfs/transaction.c |  7 ++--
>   2 files changed, 84 insertions(+), 4 deletions(-)
>=20

