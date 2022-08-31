Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEA145A7E2E
	for <lists+linux-btrfs@lfdr.de>; Wed, 31 Aug 2022 15:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiHaNBb (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 31 Aug 2022 09:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231630AbiHaNB0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 31 Aug 2022 09:01:26 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF138C164E
        for <linux-btrfs@vger.kernel.org>; Wed, 31 Aug 2022 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661950883; x=1693486883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iWOZ+F0HY3/7XT4RB1kBVEmSAIcVVZc5uuro/PNdTyA=;
  b=W7rQ+oYcqlpuKK6FXk8R04hfvGvDx7fugDAV+boRPvMhm4ueWsQgY35A
   nE3T82FBMuQl7msdpH/kOSgJ62LAx/cHxEIIopG99b+NEDcnKsravqIpp
   M/3ds6P0npAhmNjyX/35LQfpIgXcSSa93B9ySeQVV0IrUYadNWc35QttX
   Z/Y5YVAeadLep4noL60Gs4NS7zIWHyRN4MkJOpaD6w7c2m4JjRztFljGA
   Xw6m4ZF/0D9CQW1X2t15/nEnz3HqESbSNcwdOXghsda9zr7HYTtFSTFvX
   ZGs2+JXqCkx8gJRY9DZv5Zj1asifo2qbCLbs7bh3aP1wSKPN86McDx8ud
   w==;
X-IronPort-AV: E=Sophos;i="5.93,278,1654531200"; 
   d="scan'208";a="208560758"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 20:59:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SSTVVD2viYPjcnRTCwcoxxzxqirorOI9DJR6q/IhTW9/mcHGNiJgLu4ZkAGpsn5iFzOgB3SgZk3jinoe1Wqhf9jqnqUtOhlcDQv+l8BxrrmlxtvKHVzTqW0EYk+xP8qv6TpXORN7rLtNH5/R5TmNlpB8Jd8uRfmsvyDvTm5Xk2+a9qVbsjR9pPjWjc41g72TTjuYR93LSQFgpUJjRbSep+3LeeJQRp/x6iVbCo/S+8Ow/On0iHrHzaesJMZrAApQ1o3j+xNfl7EXIiNkYnLXx27VQdxsj5BdBCxJ+iS2KwPAir/iBj/74PwbWB4deq3bGps8JNekwO4aU5C4SXxUAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rklf3rNSeL2Ahi7Xk+TGQcQ7dNUkemkaHtEgVO0yPlo=;
 b=XeR8KM+tIHw3WPwMirXI+BN14b4muLr+vuHsqwJj+NmIdcnDV6vkLLxJMIVqKqOlat75pFtukrAdA3HSEC9MqLonPuD3VrZ8fSX9eZMaJwEFJfw5aEWyuwZm/DCJas3JaZgESXB7nJlKA7J8+epJ+rflpwt8Is6vJ8LoBg3VH6TH3JPISCDtNIKANm56oHrzIjT8ApMb7yVFbkdJ/eJFX6Lh5WgBFX0vNStmsJ1MqrQTAa13Ti8DngFtOyr+ySyH5McWb+HeCrqB/ANYQ48uJYeCw383rH88iA2MjFdLTVTVl3s+EzY4q6B+B2BOH6rtmGMHET55Z8bsQLYxDypuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rklf3rNSeL2Ahi7Xk+TGQcQ7dNUkemkaHtEgVO0yPlo=;
 b=hSkhOXFDGjzCOvgLsE5ZMonLOaFLaSV75j6zNL+cmGa1LA3ClliDyWsEkBtJQ09qCys6i0RxqionyLt4w2jbz9onOjKhUoYUsRTYX7JmbYsxGFh30JhpVgZrPxPzItcnGZf9G/5A9KlBBqkjt71grP5V6Yphw6LxzkW55B0jfJ4=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by CH2PR04MB6869.namprd04.prod.outlook.com (2603:10b6:610:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 12:58:20 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::7412:af67:635c:c0a9%7]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 12:58:20 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2] btrfs: zoned: set pseudo max append zone limit in zone
 emulation mode
Thread-Topic: [PATCH v2] btrfs: zoned: set pseudo max append zone limit in
 zone emulation mode
Thread-Index: AQHYuR9kYk8diXEukkG4DTr7w2VC463JAG8A
Date:   Wed, 31 Aug 2022 12:58:20 +0000
Message-ID: <20220831125818.4ndksufgy4chrg4w@naota-xeon>
References: <20220826074215.159686-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220826074215.159686-1-shinichiro.kawasaki@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92a727c7-392b-4742-c0bf-08da8b507ad9
x-ms-traffictypediagnostic: CH2PR04MB6869:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UjiYAt2Np5Q1DMORglhFLhKCDICZh/ee+isLsHHiSrpJVO+dxBzYIlQ/i/8I25JUAekXJSeHbf8vUR9bFV8h2wgEfe5noyw0G/CHVYwQ3hlM4LNvrOzBrIQ8VG3BlXDt7cD8P0YY6AyRx2GMzAgxyHEHLLZ3dCkwVXxTW781eBmdXoIIl6iGEPxPphIYj/ZOKTlBTTnSKebq2E/23Tu8lP2qikrsw0sVgeusOGJwlYVI/bLymW6YOel4f8sjewhJNJvh0JpHgxVWZdL6YNmuS5lGcyny3qmaW7AnuxTcACF4LfQOLoT+xuoHpEeZEleBe9Lvqc/uXJZAgdYmALXEp0RsfcrIFuTqnFzdikMg1KRgLDE5M/s1ed/9lvvAsGeBLERU6dPmPULlx1lOcd8JuKbY4Lp5HDi03Fopb9bRbTwGiMsPi3+tphHmEHubkPkFLRjO8iKM+pEFIAqMhgoBkt9k+3li/qrq6HyKFI3gEhHjHFDSIpmo1qTaiQ1sQ3X1tkDn/J6fVOFQ4C09K3HP33ehazPqq12wVzlWxKUAbVhhrmt3KWKRCsCY6Ku00jEjhQJm7K3fGnVjeRIW5QfSUAACepWA8Lt+eIwuuKkDHLFyLUp2vG0aqJN6qnK/mbVAUyoIZHlhJCLttd3lz2gugUYqocUrk8md4ZM0GNjg/xe5zbdb9vm8GdWRC60v1WCrZkesa1sagonmwtbBw7C8zNF3edQ9/iECq42t0KEnbhWrullSMEVkcfKSG699zeqjK/Ow/x6nuFeSOrVpVX3cAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(346002)(136003)(39860400002)(396003)(366004)(376002)(33716001)(91956017)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(76116006)(4326008)(316002)(6512007)(54906003)(6636002)(9686003)(26005)(6506007)(71200400001)(478600001)(41300700001)(6486002)(1076003)(86362001)(38070700005)(122000001)(82960400001)(38100700002)(83380400001)(5660300002)(8936002)(6862004)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?52jjZE5q4D4bfi4TRi8j8j4kJKEFTOfhS4jx/dtYawvyZrf2Qwv4HuTYhSZ7?=
 =?us-ascii?Q?2RAn78MsgPNNnCIt/ui3w735dqYtj6n7axZY9vT+BEZUXwvbd57CiCsmEx9e?=
 =?us-ascii?Q?QzLBwV7aFza+O9OA+tA+NHGpxGaqPEQRZqEo0OmlGvZYzckw9RwS39e+2xlF?=
 =?us-ascii?Q?8wUfEnXNsvxhfIsRjHfpQk4FyZUIMDUYAM8rhvCvnuUnUdQdcOQl1VcAgXWD?=
 =?us-ascii?Q?gCtql7ODktnyxlbYYtZ8qtYSHMPdJoGwGJQcaWGuB+Bwm3QPJtRujTjU+L93?=
 =?us-ascii?Q?aO5vGQ3BqCT4tKUce96jxYiz86pFs296/IkNmovpSaWq79VJoO1948xsx0Eu?=
 =?us-ascii?Q?3nAxqBJLGl/EIYOBnMQT0tCKYvmPB7ARCZ1A9GBSFrOA6NK2YlFJwf71Yw6N?=
 =?us-ascii?Q?g0jlAv8VDs//9SSNJSYqltcksM+4fr9GrWev9gwlvXWJB7ecdm+pWKE6cild?=
 =?us-ascii?Q?lyhXFuGR8LfuI+D2OSh4lMqv/SZUqDJ4pKxbsF31LoMmOFHUxppfB09itFS1?=
 =?us-ascii?Q?pSLP8NS3vLFh4dAayYHF6MrYI5KsNCbUW19FlYbB0vpsCiY34ahBLuw++IXo?=
 =?us-ascii?Q?9kmly9rSsJhOVEacsgrb10AqeiJZCZs26HTZgtlrRjUrSoLwdG122OrM8Eq2?=
 =?us-ascii?Q?1Gc1C3x6BDZh4MA8GOTCQHm+oVB7cfySSv1sqa4n3GAonPxvoDlSzrm2ODNF?=
 =?us-ascii?Q?gO3a3ivf9eQeu7pwjDjX7Km5rcFtHQ00aJeQSf6evL7qWQbTcC92K8dXcuSw?=
 =?us-ascii?Q?NVuG6JLwGllavJyZUaU5Kerya4cp7V8oTC8ZNY666crm95wbD+ch+crhE2J2?=
 =?us-ascii?Q?dmhEDcQX0uFUDxmEzSawDZhONJKdoM8Cx1Ix24/9zYyBRE3LLy2mQZXF+WAs?=
 =?us-ascii?Q?SeR+t/fDe3OtLBsWVGdH+OawCxdaUeLF4pWyjvda7ghIkg2YYN8ykiRCdf/b?=
 =?us-ascii?Q?31fsCvxbxUSFOjL8SegM7CYMjf/r61fritkeTYegDeQVsiRBant0HV/L6pcj?=
 =?us-ascii?Q?wBMr+8tWsdzuoSs2k+qf2c/Gq4V+WHylabMRo3QPvrRBSDqryrJDWW8GXWb2?=
 =?us-ascii?Q?Jhy7GiwoVItpLltG+qA7ja2sw0ZkiubdRgSxyd5AociOOCiPpEwb/TGuGRM6?=
 =?us-ascii?Q?l61Hw0oW9pStNHq6u+SF3sKqx3Mh/nspx4AdhjKQncvIWFhZ6/jy5Wx5u8tX?=
 =?us-ascii?Q?aIYixK0MNIobXKe5CCGkAdaLRjlP9kXRC2x0+5Ri1y2L1w4rhA3487uGlUb/?=
 =?us-ascii?Q?y2sz3zmCa43MtogmthB5WmAR2htZNGX8UHj2KhBB63pCxnJ9H7Bz28sh9HFH?=
 =?us-ascii?Q?8QW6WMl+VNMt3xn1q6bxiqVGqNcEHCypSCxkcRh080+kEnhQ9WX3KiDqw7FA?=
 =?us-ascii?Q?3VLSqox6P5YkzedYtN96w52xWg54IhnfKEKT9jmronnuzMZUQKUSUMIANTgb?=
 =?us-ascii?Q?5+S8tyLYxJiLe0lqRS7NsfRwdNL33ZsEkgrLaBpMfxa2BXezVhbZ8b/Lwz1z?=
 =?us-ascii?Q?X1Pqp3Hjkbm2EFhtjkkURx37f14aUtWAomqZdQuw6Q8Ix9N9kfLLVZfggi/p?=
 =?us-ascii?Q?6BBWiAMDou4AnI402nR2rvlKLTkNs/pGSyLwZhCDxIelkoaLmTRQFPg0v/cA?=
 =?us-ascii?Q?hQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43B33E94B07CD5489C9904EB128723E0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a727c7-392b-4742-c0bf-08da8b507ad9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 12:58:20.0613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3BLWMvO7GhSbHf5KVfeu8LnPSKoelhjoCaX1S74oT4vp3rqfX8/UqGRx9yzmEVAUDr9fIOgbX7CcQFBGEwf0+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6869
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Fri, Aug 26, 2022 at 04:42:15PM +0900, Shin'ichiro Kawasaki wrote:
> The commit 7d7672bc5d10 ("btrfs: convert count_max_extents() to use
> fs_info->max_extent_size") introduced a division by
> fs_info->max_extent_size. This max_extent_size is initialized with max
> zone append limit size of the device btrfs runs on. However, in zone
> emulation mode, the device is not zoned then its zone append limit is
> zero. This resulted in zero value of fs_info->max_extent_size and caused
> zero division error.
>=20
> Fix the error by setting non-zero pseudo value to max append zone limit
> in zone emulation mode. Set the pseudo value based on max_segments as
> suggested in the commit c2ae7b772ef4 ("btrfs: zoned: revive
> max_zone_append_bytes").
>=20
> Fixes: 7d7672bc5d10 ("btrfs: convert count_max_extents() to use fs_info->=
max_extent_size")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Changes from v1:
> * Improved comment description as suggested
> * Added missing type cast to u64
>=20
>  fs/btrfs/zoned.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Looks good as well.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
