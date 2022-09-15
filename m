Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA095B9CCC
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbiIOOSq (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIOOSp (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:18:45 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BADA5A3FB
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663251524; x=1694787524;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HfO2b6cIuGxNOkOaYLCOqefh8EYEwQ/C3wJk2Evknjg=;
  b=YCLi6aaFyXir6RNkXP1TtJgvOHgX30kvJgDt5h1kGKGUJvL3Ig6hAGrm
   TbbD8lYcCM+YcqQTsDCjAUWQ6OMaljjs7a7A30YEXM6ddN/3N6I4bAOoX
   NZreQT1ascuBL3viVVlUoufqL9dekXM3nLaJIL1nywVWTfr9dsuMcX8Ho
   nEuQ+y2kuWwNGvMbLHiKehf7NVt7UnmHYZ+fM6PrWlQsDkQTHQEmOX6Fu
   hd2CacI90lV09AQbFLmfCzqwbQ+FQdHCeXaOxs+Ksj8NDocH2iDEEKqAP
   arXbhBDnjbj8UJH20xV5q0c0QN2kSqTm1ynix+YV6obITxf5t+RABicYX
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211891560"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:18:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fe58ivac33tDqyMs018KMxfAclih4Hdvunsfr/0SxMmty9M7OOoNalfomf7BlhbKGeCjNBaxdXcsPmiRyYAJuOi7LXu/DjPmcQQeQJYtiQEPk11eqh+u+TB2S+RYCM9gipVWncMJ++haqTlKC+Rw/xh2SOAEhsjxnT6c/dmHrxQQwWFkB8jMHN6QreFJNCHwu/bXBfukB9sl+fCtjKbIRJvVA6UpbNsa/qvGWJo3pqRzBfQNenJVy25sxko7pgIPUWvRZF+vSOTm0GHUZ5l/wj044bjilRcEvNWZrPO8bYTORNz2XZcqsbY8Yt/yIzHm3h3kjMcjW0SyZ9WQRbEHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti/UEKTR34r4RI+ufuRFjqcxo/bspxZtZFIOPb1DcHs=;
 b=Rsqvh1qgDbKD3M94h2Rc7qrgBmzeJlspwbDJ87oM6rxofGcRWfALKIbdncF0lLOCoj4JagjV33iVfZ2o/+BYPkEmh0CfnkPb5hUN4eiVwJ1IpOEAq3n95fOV/iXNJx69B6z0sPrmo7cgha0BpKr7pNJiu/9Z3yBC91wYeNSmaZgNSbnrtMMuqWq4gSqy/Yj/FB2UZslZX5xtwIPAbxWDLbxKknnUicrj0FlUMmzx4fk/nDZ0qQO//kjsgNaP8HQAHWmWD/OAaA6xNr3YenTMG6k6pjcDv63EVO3387O/7/30iIxJNBW2pHKxALSwY1kcqD5qHMUZaMau0EfUihUTtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti/UEKTR34r4RI+ufuRFjqcxo/bspxZtZFIOPb1DcHs=;
 b=Z6CcFPSXSfxurusRoHavpqocNUruzaPFHRPvWdwh1f8whN8zb668r0uFqT0NNGsCgsWT7Yc3Gws+E5FoXcvUv7PGlGkR7+akiBghEc1fZj7FGrbfNYgjz4ykQlTa8pc5oqaTnuejfRFjglPXYA33ytFUKUhFtpmUZ2ibjOkG8wE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4678.namprd04.prod.outlook.com (2603:10b6:a03:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:18:40 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:18:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 08/17] btrfs: move discard stat defs to free-space-cache.h
Thread-Topic: [PATCH 08/17] btrfs: move discard stat defs to
 free-space-cache.h
Thread-Index: AQHYyEu4iX+V5COV2U2tOwDhRzjWrQ==
Date:   Thu, 15 Sep 2022 14:18:40 +0000
Message-ID: <PH0PR04MB74164DAAE2A3DC28E67FA92D9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663167823.git.josef@toxicpanda.com>
 <5e7f34e068513a3a82b3bc810bc92a0eb0254863.1663167823.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4678:EE_
x-ms-office365-filtering-correlation-id: ae54f12b-ccbf-4753-ecb8-08da97253070
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Dnh2qWI9mgsGhvIX19FIr7lsrrfZb6xDRkvcfE6GVhZxfPmyLJOsAWxv/vg94oU7aWigrJ3WGrHcXWC/5B3xoU7FARdiTWDbk95F0Irvn/itTd5WrsMQdyXRP12CSH3lRYpgmFc66ZkmORJti35hl3bjAhrALrWbUolSvGLJ88Bd9cMVMkdOKXNKRPwzMDNrHeG8J06OSmLkEo7XTUIgygMDVqf7EA0zr6/BszqCjhrDZM/gA8G6sVkoo/nMNKfPLNbGdK6HeA6q9TKjJDjlG7RVdAfjkhtzp53JQjT8/1khdBFQSTkxUZuUcbPL2fGccarVrF9q0l0LNE6ioIxzQJdX80CtLyfZ6JdFdpKEfA7NFRkDrbfpuj2q7dUMNAI8+ZxUUkOUOxue7659kXbKioujUceRcaLwO4ekc0VnZahXKy0LTsB7n3miJJBxpppnsqYcjxiQL6SXtAt43cawzZzRZEGBSIfaOtFIS+AnyxcrtHoipfdqnSj+zXzVD4DGh7H24p0vbgvFFKkZ8bq2xISmMj+8YdXoDlKRQVe+IvbTjvHhasHEej9KfxyT6cul+W1ZhbfSsz9qoTW7+YrGLiMBD6tQX8KCW8brh0vOpFK6e4ZFqX023SDl3NVerrAORXIlnEyxwm+3xYD1d4BTYxxS9wJwcwjsxuEF11MTHT7CKcI2YGU8J1z/cFXdK8al4EXVONqGEZ4KAob1rwyzi6zyc5YU02eTCnY1WB4WHYpBYLM16yMwNvnG8FeWo/o+sFI/Ar2v1TzvIbnxSc7rLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(6506007)(91956017)(41300700001)(66476007)(82960400001)(55016003)(66446008)(38100700002)(86362001)(38070700005)(33656002)(66946007)(4744005)(53546011)(2906002)(7696005)(186003)(316002)(52536014)(8936002)(110136005)(9686003)(66556008)(76116006)(71200400001)(8676002)(64756008)(5660300002)(122000001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MqZd+IUXadwemPyFQcnCOwBZ5eoJcqaeb5FNzrUBBuRfiK8FzKCb9qssJHyn?=
 =?us-ascii?Q?7CeX+7iIs4deMJFpWkST6j/emBskIBPLOIVpP3z0EfbMJDis+YFmcpG92OTy?=
 =?us-ascii?Q?6WEWMIHKrMsF3aFjD8/hxQTV4keKgYaSpOeVLf3nRtrPogj9PUR4S7kOhMp9?=
 =?us-ascii?Q?gGefc4I+EHTg4E2CFNihokTaU4FnYCzm7xqjJao9B4eH8alOj9pjtU1dd4rg?=
 =?us-ascii?Q?OymmWivkC9taVkosWJC6F4DzX0A1C1BahMqPJWEnr8Nfu2nCjMIuHPbYFZ2P?=
 =?us-ascii?Q?HCTNiXTWXQ1ItvRe2pZsN3zdHCRDTpKJ56imgRKcae14PfW341GbXdyb7l3f?=
 =?us-ascii?Q?oh6Ql7O90pj4Wt0YhwbVh0tXDb1FdaAfEFJz6AMaCNWsL+AufXUn2nIXWJls?=
 =?us-ascii?Q?ZKxH+x0KhUdxxY6pwHQgQtKRkBLpWA/TvaajKvmkePNmFcZrcvQos+3SWfmf?=
 =?us-ascii?Q?oghMP0HIAu7p7Bu6trq3x4t/8/lCf8e28vnJGzkCc7sO+gFFIvtS/+HFqCMX?=
 =?us-ascii?Q?vpOPRlSGUIAiqIued6p35QjTbQMmN0Z+6dufhc/+G46JWGxdXES82g+F7yBa?=
 =?us-ascii?Q?CPra5DRR1N+6DeJakE/R/540VRcBsRgW202mrr42fYRQqUe3aP5OfCFLFMaY?=
 =?us-ascii?Q?DcHLDH1ivzg1n1s9k8NtKkM3RG+7k9Jmy8wX4gX/CAofBr/MudZgo1UZV4OX?=
 =?us-ascii?Q?C+3XopadwI69ZtFGQyzKqQ21FHnzi5rH/jp3qT9qpjHVdzDAhqHaAjMsk7wG?=
 =?us-ascii?Q?0SQA0DvcKBZsdHsfdVDFJpbMikXeHGC/Y899UgtZxch3B2f0rdP/AGXpQfNw?=
 =?us-ascii?Q?uXP8NqJ20WWedzh1f7t41rLLBHjsP4Tc9sW0PRK0MnOyxVL4HXLkXNRJQTL+?=
 =?us-ascii?Q?s/1AriaQC6qfaoL6lNU5cEAJdySfu6feOGzMJgOu/VD+txMjUjliAsft/3mT?=
 =?us-ascii?Q?OwDIeZcjpdheiuzmXzbzrRao5nRXbcctqASP8cNd8eFzw3Pb7GzMYKNIjRxG?=
 =?us-ascii?Q?iCgz6dz7nJG5Yn0NFXzvIryp4rbzOSSE47oBpUpF2HIndvVbCGqZQs22HRpZ?=
 =?us-ascii?Q?/x1EjtlLYQQOWjC8TLL+XsIbXPMQOdqUoYzJEaeTNcxFsR4hjY7NqppOuHru?=
 =?us-ascii?Q?LYtox2x0JuekP2UFQIQomBTmLRzN7dYmVPI4BTqzatwGLVoTGhJni2734TLy?=
 =?us-ascii?Q?fVWb29OZjsjbpP5N+3BdVRUcSavw1TpQwsHEbtneFBBjzXZdHCRMMtFGOmPM?=
 =?us-ascii?Q?gPnacVdoRvT6Mh08lffXtvG88k/YvpOtjLD6jLukPMXNo87QQyzaEUHfx7sA?=
 =?us-ascii?Q?HRQVS1oPUtLJK6UMVxIDswOQSnQYXRiAovVnGrbiquzLjdQZMlZIsberd/iw?=
 =?us-ascii?Q?gtgL7UcJB6N663OoRPTdQanjYmgULwNjha3IhFi5yeIyj4jKZ/xLRIxQn+K4?=
 =?us-ascii?Q?JJQbI7WDnLD6VXgHBPDWdFSL5wWyY6wq4JaMJs6KYTnc6Yok0TOxRD6Q0Ldf?=
 =?us-ascii?Q?ghGRq2zRR+KrMmXiRwSGt6X92Wn2uTRbIglqO6p3yzxqQwsUJ2Agtfmbj3bJ?=
 =?us-ascii?Q?TU0weaTH38er+/kT+MyGgVFlozh3lipH4HNPBrFKRbmaI2iPi+FdkvC6R7wQ?=
 =?us-ascii?Q?ak7MjEIz8mD+vb1/8l1Mx/K9KF9aij1irNMkiJjXgR8pnYDZ90HfCYEjMxho?=
 =?us-ascii?Q?BVgGa7jRFdWUV/wpMNOJAm4RRxE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae54f12b-ccbf-4753-ecb8-08da97253070
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:18:40.8481
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8Atr2UmqR3aC+6Uu9a1JHie/RGg+5MtLIoYwPOKgjqTPMQCfLikEZNYDAnqmVjxYXXZR69vQTGExS7PiwEdyAfap7bNw2Ks400FmHV8xJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4678
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 14.09.22 17:07, Josef Bacik wrote:=0A=
>  =0A=
> +/*=0A=
> + * Deltas are an effective way to populate global statistics.  Give macr=
o names=0A=
> + * to make it clear what we're doing.  An example is discard_extents in=
=0A=
> + * btrfs_free_space_ctl.=0A=
> + */=0A=
> +#define BTRFS_STAT_NR_ENTRIES	2=0A=
> +#define BTRFS_STAT_CURR		0=0A=
> +#define BTRFS_STAT_PREV		1=0A=
=0A=
I get this is a plain code movement patch, but can we please get=0A=
enum {=0A=
	BTRFS_STAT_CURR,=0A=
	BTRFS_STAT_PREV,=0A=
	BTRFS_STAT_NR_ENTRIES=0A=
};=0A=
=0A=
Other wise looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
