Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44EF6A8459
	for <lists+linux-btrfs@lfdr.de>; Thu,  2 Mar 2023 15:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjCBOpT (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 2 Mar 2023 09:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCBOpS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 2 Mar 2023 09:45:18 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD5F3C7B3
        for <linux-btrfs@vger.kernel.org>; Thu,  2 Mar 2023 06:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677768317; x=1709304317;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IM2092L0l4P+bsbtkma+WLJ2AW+FGCz72D9W01uRYOc=;
  b=Mh/j5aX+J2xvWmrBiXFjCYnp5BHZRrKJ1rnRb3rq8dTtuEYmlDo6SkYC
   MG4O+UeeUuKc88KRxWix2wEp1ECGhks/HK8hlcGwYYXMxqk1fz2Wkl3ls
   l9pmcmls6JmJC0e0iiubHqp3nPdVHJoTjBP3Da5UtmSkl25MQwKWG56wI
   LzU/0DZdxrmnzeQVdZdvc74Ie7Z2m/maDIWOhc56E3Pz5rOdMaj0csrH8
   OU8FtzYGGedDf/jgQaOC5EsjOGowwmVIYPTrFjIuUfnzeRsl3J/1ju/aS
   z6UwCA/ZJHooQt1DPJV3d00oPOCvBeXcSz8Xlg3Ed+pPHzRXa94cuoXWd
   g==;
X-IronPort-AV: E=Sophos;i="5.98,227,1673884800"; 
   d="scan'208";a="222921283"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2023 22:45:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TX2sUUvNPNKk81BiAJ+cIMgrHR8F0eW+HMiHmKkFHhQubMb76fJ1AizJ/eNS6csU0mMX4NpWY59yliUTRke8vl3yAp7OJ0Zyv+5ZP+sGH5ZoPh/dBBcNpRPcARCiMGSrtID501tT7arRWi/Rb4l8/W83REIRC0j6n4oW0bFxvfTdM9EoIfuB2eZO3/EWx5CN/R/ILl2HFCdonIE6Nr7hzkIkgvb7841jb+0wiJBblYhoKd5cRGlPtCdRNmz/qxrjHA68PDd6q5HI6fUooDPVr1jwc8V5iJr9Io2i2Yr1uDnyu3gG9an01vjha1LJyWeK7KdbYSb8tdvMC432emxr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cJ/Jp6hQW8CqXwhjJNBew1uBS61xya77dMe362NmQA8=;
 b=GTCVjB5/9pdgkBE0lwykEPXtKDyQ2y4uP2GzHBHSpwBAXwXF0QAg3+VC7sgIc4TRtS9NmOiGvGIqGZncjeLOhQGftFsPzZiEUZ08jb3qYpTsoVyiWZY3gzImzzBqRXeWBMLdfSOagOFddxS99CNnUlaHnrNmzL1Gjb4K0ELTO8ow6oMxtTkFdX8wHt3g0QFEab3qSuvyPqQcJwthO2xMIGxVYCl+zMZyQpTR/iK/mXGBM/MQqLR1qF338UV+Zso2glYy/DTh/PiY1WMnRaXB++63nD0kdtWxZN+Wqtrz7njur1Yf01vEMxRpM712aO4D6rMNOjKgjS9G8zbe4VBXnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJ/Jp6hQW8CqXwhjJNBew1uBS61xya77dMe362NmQA8=;
 b=ARLYnREAt+v+63aa1dmPf/CpuH1DbTcQ5ecMi727x2H3P5ClVnPPGB8HOd3gPSCEUgTrhlidByfa1BRztztszGxgkBmhKWc07h7vTdP49dSlqxeHzCojHo/GXgV1h5NZoOpMGlK4KGIuEQo/hZVmSiUqQEkxHRDFDC6R4IqSvZU=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by SN6PR04MB3919.namprd04.prod.outlook.com (2603:10b6:805:4a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Thu, 2 Mar
 2023 14:45:13 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::2e44:805:e7e7:8544%5]) with mapi id 15.20.6134.030; Thu, 2 Mar 2023
 14:45:13 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/3] btrfs: handle active zone accounting properly
Thread-Topic: [PATCH 3/3] btrfs: handle active zone accounting properly
Thread-Index: AQHZTILnOL4Gy+swfUyRfKGZDQg3ua7nEH+AgACBqgA=
Date:   Thu, 2 Mar 2023 14:45:13 +0000
Message-ID: <20230302144512.cc7ofuvud5dodvxi@naota-xeon>
References: <cover.1677705092.git.josef@toxicpanda.com>
 <ed93f2d59affd91bf2d0582b70c16d93341600e4.1677705092.git.josef@toxicpanda.com>
 <20230302065600.iu4idhfddygxczkk@naota-xeon>
In-Reply-To: <20230302065600.iu4idhfddygxczkk@naota-xeon>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|SN6PR04MB3919:EE_
x-ms-office365-filtering-correlation-id: 02143043-2d9d-4b6a-23c5-08db1b2cbaf3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 12zqvDt//uciG84FplPRfpRbUqpkrXMKgmUprBPlEASPXV8JLj4TQ2914xskk0SXYHas191r7YO6Tg8GLpG7VTdphRbVaYeBTQ6BiwbVB4HgAnfbM803Fh4Vg3s3Uv8dMA1Wf39p/Um2E8p5A85uLYiI++9A1lq5cZ/5it4unjBBCdkdIBqwrJyXO4lG0wVyaGYLtsg6spdDTogAcqkmaJuBG2/ior1myUGT0IRJ3hQilCj4dQP1oylRGhhALwTEunwWWDJrS+DLdF5S4zH9YLYCv/XHrGjPbwa8QgymeKntY05Exw4rR0fYqDBltlY+jGCtzNbmx0TKr/r+JplTm+RGptDLceyp5jms4M54UyymujBsct+ITrg+7UYTA2sz7FHylrN4J9iObcOZJ3yKsA46n/hhcRvgO4pS0dMA8+LC9q1+55pfAJkGpyDyLlwLubDUdeJxKrXR5iWeTSfIe5OwQA3iVEjSyESENsTCx+Q/NPch4M6BdGc4Dqxql6UPy16tipfDCxNU8PUNjwXVSKir0Z/eUebIbDEpMqXJm7NitdpDZxpawfmYUlV54VjioVBancHnEHjiPpYyf+oh1nLxe7ePpZM9zhjg10pUdc3a7XAR3Ce/URmIUqBLJovcoRld5ruaQAya8OQsfgrqJ5Pv9+crMmGeyYe7ZMc8lREccmEV0T7OCDj0B6KkPO+RTt2kBhYbzgMpSIMyO2jsDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199018)(38100700002)(122000001)(38070700005)(86362001)(41300700001)(66946007)(66556008)(15650500001)(82960400001)(5660300002)(6916009)(4326008)(64756008)(2906002)(66446008)(8676002)(66476007)(8936002)(91956017)(33716001)(1076003)(9686003)(6506007)(6512007)(26005)(83380400001)(76116006)(186003)(316002)(71200400001)(6486002)(54906003)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uqLHfBPtpToo2H6tH+KxzmU2Uws4h6BbFMLtTMQL4FXXKOhT6NILXJVnLZrl?=
 =?us-ascii?Q?A+Fg2pwq3UNWqinc+jZ6t5ybwCgYjKytzUCWWVuAnHcocRNLuWsHaC4b3U1j?=
 =?us-ascii?Q?wksuSc/3rdSrHY46euD68O0WPte4DyajNzXwjKR976dgSBkllS7s2Vc1PtX8?=
 =?us-ascii?Q?eYlIxwyDcZn7ZCPFxKYYWJ7Lsa3CHs84E4GtHPAiTinETihM0AaOFapQXP6f?=
 =?us-ascii?Q?akj7wD4tNKq8P7p9ZYRCR8tsFnj51re/O+0cnGXVVe42hxhxIYQCzlqNtsTj?=
 =?us-ascii?Q?OB9HJB+tmLv74x8p+sjExfmz+xoLWkbZnnO1Hri8go2yKWlmMRA59wsaroAI?=
 =?us-ascii?Q?mUrATkDXOK06UPty5lm0dgO1cg4wojVlwfxSTMpsIhoEUOflPUXrh2RLTlqu?=
 =?us-ascii?Q?OBCJtFQmilAgiSbuHeb5UxtY/i3NRhJo0ipQBPHCq9FGe1iGgoXhwXHYmmfh?=
 =?us-ascii?Q?LDtTHf5U03aYbGFo5yWhInfGUrsS/2Pr7op9+LHRYnsEL32iqhKmCbkKtd6f?=
 =?us-ascii?Q?vVK/6Tjd6Y2HUTtB+8HiKThxVv2WAC2yKk9p7jWaEHwOGXfDWtg9ZStvmQ9z?=
 =?us-ascii?Q?I/v2X/Yk1k1WL6hXqyPv5GyPiubLuyvsDhUgkpk+RiPosH+Yb+MNOUNitGVo?=
 =?us-ascii?Q?dzBSIeYDsRSxUbEbYom9uEXOghOseCZO7YRc9AQu6dLOFY+O9uKnjeT031e6?=
 =?us-ascii?Q?nlmtex7x0IzjqNQVeIdzjBH3Unhgef1BH6M3kx5MLRxOGRvw5Y5tXtync1Xw?=
 =?us-ascii?Q?yL+EUd4OEg34ChtixK16F+VujqjzSkHycFIhXZ+ZAhGR4ceSfh/agYDdzs4k?=
 =?us-ascii?Q?v8RFg3vMLM0LfnrqgBXljzVgeo9Z8+ybveFBfMV7Mh4B8l3ZjNAWqlVyRcqW?=
 =?us-ascii?Q?iB2/P6ooet89CpSFlR8r8QaBpYr5INEcmkGQF+52JwDxOhc9oCu/Rev7zqGh?=
 =?us-ascii?Q?aB5KGYFVC5CKJGMJSYhGcsMpX9Pjd6zAvj0oaJUJ4XduaCpPevQpHxwz2Qiy?=
 =?us-ascii?Q?u3n4PDjZygacPyqZrSX+Q0ITzcSLdnaDn3liGgAznY7noPOk8AXiBeJqwu9w?=
 =?us-ascii?Q?wE0VN0A6eoxUej4/AsZ/NF+71WX8d5qvcxsPrEZbtaCnh5NudQaOjNaBz573?=
 =?us-ascii?Q?sZhQyfwYeZ4KDCSrod6BN40YG6BcMNMCWhHXjePin0HRQ24anF8d3EXiPcdZ?=
 =?us-ascii?Q?Wo+b6fNaz1O7cG8Pf92MTE0FOnzPCLNB6yFShisOcMHeC1LuCiL5qiDGWsC1?=
 =?us-ascii?Q?3bl/tPNhu0eE7EybBDubTaR4U4LNvnYn/C+F621N0pfjhrPnLErvSSXkVqMi?=
 =?us-ascii?Q?jM4ziD/Gr2P4ZtmBHLkuSv8pLsC73pr4BMj6wg/91o7bQ8yGhGsSCBze9ipH?=
 =?us-ascii?Q?8Dk1ovu+k/HxvyTs9i1FIrX9+1UDm5HoMKkBccaLKbvrxLOvKWHvG3TQfs7T?=
 =?us-ascii?Q?exc6+L0fjv6EWtt0jlIg+0HsL19Hel1Kmo1I3iw4YlnxOMC67QTSbst1Qm94?=
 =?us-ascii?Q?1LAegZcEhlTN7p1EwKk1GwnYqLELsHXV91LUg9MvdaRgJ9OmdPoYiY8n2Zmg?=
 =?us-ascii?Q?EokJfvFwGNJWsGr39lc3ZQMuQIXWDLNM9/WbTqrjlIcMnRHB9kvSH/6bYUfS?=
 =?us-ascii?Q?Lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E2BB382E13EF643BD31F304B4995ED6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 32dmMlkH++S9KFAFx4/vPzMMW6qiNtQrKkR0UJyPmhUuIXpiAqTCCPyeMqAVdWn2ryDV0SGX8K6R1wHY4xx7QfhXGgebLlv+7AkZ4O2iZQ7dWvt8RcdQzTi+5kSYfjcQDK/IaGblLEhKnta5LhvlIr2UPmZytAeBKAd7abbQHj8rkilJw9PiBlI/5ONRlEKcXisQINPoJ8MCCbID/hQtzThUVnh8WVaY3NAosXWsnvNj+b6BGeTikAyfI9iBJV1kipSxoakOYtHinDhn/Cj0dmEprrnwHMMhTDtYFqsEVxyHgzfaQU6Ky/c+6Ej+k2mH5/TsMw48LS/GeTuZ4v58uqY8MAE7v6RFzbjOUBpIV+kSsCCf3aqlwP2n3n5w9xPeh2DZnPaBbP8Xf9S4yv4P32awmp0rqXps/2tghcNexuPX6t4aRRRBNDvqxzza8hQrr9XreLNmk9zrvkg08DuEslh1eKyqAuIwlOOxV5edJc85Cq1iDwCKVFHSAOUW/T4IWjJtUBrTL3NNsOhcG8Pc9nJqFU4YDfIhik0I3ViK6IOWZctLwO97qwctYcl3N9s1rnLEziDMTKHd/+ui4qg+uN3sXVncGyenoFp6PtGWmp4tpS8P4vWcBkyNaQtW+U9phpolV7HtQxJW2F2zNeWWb/VfBlcC2TnQTSGGL7gdfgRSoBgNLDL+JDAO/IjX9D1H+Nj/r9xYpE0IJhk5LsBHP7Y95u1YIrcNxBu3LzPSPk+M/R4tCR2ASFPy+jXC7WFIMBx/qIBGEswWJ4NAg4qjAavL1TPoWBxam2VrRcSmENMppCQOPsnCehHgwbnrORA06A0KKSKIOJrZTjDbFXS9rA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02143043-2d9d-4b6a-23c5-08db1b2cbaf3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 14:45:13.1752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T1xq8ZjERUOtP0ofavujDVuzxf/Z8VoAL2OF+J4l/LldkaRJQ1gQFK2Im96M5L0HQqPwobl7kMum9Leh2ALK9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3919
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 02, 2023 at 04:01:07PM +0900, Naohiro Aota wrote:
> On Wed, Mar 01, 2023 at 04:14:44PM -0500, Josef Bacik wrote:
> > Running xfstests on my ZNS drives uncovered a problem where I was
> > allocating the entire device with metadata block groups.  The root caus=
e
> > of this was we would get ENOSPC on mount, and while trying to satisfy
> > tickets we'd allocate more block groups.
> >=20
> > The reason we were getting ENOSPC was because ->bytes_zone_unusable was
> > set to 40gib, but ->active_total_bytes was set to 8gib, which was the
> > maximum number of active block groups we're allowed to have at one time=
.
> > This was because we always update ->bytes_zone_unusable with the
> > unusable amount from every block group, but we only update
> > ->active_total_bytes with the active block groups.
> >
> > This is actually much worse however, because we could potentially have
> > other counters potentially well above the ->active_total_bytes, which
> > would lead to this early enospc situation.
> >=20
> > Fix this by mirroring the counters for active block groups into their
> > own counters.  This allows us to keep the full space_info counters
> > consistent, which is needed for things like sysfs and the space info
> > ioctl, and then track the actual usage for ENOSPC reasons for only the
> > active block groups.
>=20
> I think the mirroring the counters approach duplicates the code and
> variables and makes them complex. Instead, we can fix the
> "active_total_bytes" accounting maybe like this:
>=20
> diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
> index d4dd73c9a701..bf4d96d74efe 100644
> --- a/fs/btrfs/space-info.c
> +++ b/fs/btrfs/space-info.c
> @@ -319,7 +319,8 @@ void btrfs_add_bg_to_space_info(struct btrfs_fs_info =
*info,
>  	ASSERT(found);
>  	spin_lock(&found->lock);
>  	found->total_bytes +=3D block_group->length;
> -	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_fla=
gs))
> +	if (test_bit(BLOCK_GROUP_FLAG_ZONE_IS_ACTIVE, &block_group->runtime_fla=
gs) ||
> +	    btrfs_zoned_bg_is_full(block_group))
>  		found->active_total_bytes +=3D block_group->length;
>  	found->disk_total +=3D block_group->length * factor;
>  	found->bytes_used +=3D block_group->used;
>=20
> Or, we can remove "active_total_bytes" and introduce something like
> "preactivated_bytes" to count the bytes of BGs never get activated (BGs #=
1 below).

I got a new idea. How about counting all the region in a new block group as
zone_unusable? Then, region [0 .. zone_capacity] will be freed for use once
it gets activated. With this, we can drop "active_total_bytes" so the code
will become similar between the regular and the zoned mode.

We also need to care not to reclaim the fresh BGs but it's trivial
(alloc_offset =3D=3D 0).

>=20
> There are three kinds of block groups.
>=20
> 1. Block groups never activated
> 2. Block groups currently active
> 3. Block groups previously active and currently inactive (due to fully wr=
itten or zone finish)
>=20
> What we really want to exclude from "total_bytes" is the total size of BG=
s
> #1. They seem empty and allocatable but since they are not activated, we
> cannot rely on them to do the space reservation.
>=20
> And, since BGs #1 never get activated, they should have no "used",
> "reserved" and "pinned" bytes.
>=20
> OTOH, BGs #3 is OK, since they are already full we cannot allocate from t=
hem
> anyway. For them, "total_bytes =3D=3D used + reserved + pinned + zone_unu=
sable"
> should hold.
>=20
> > Additionally, when de-activating we weren't properly updating the
> > ->active_total_bytes, which could lead to other problems.  Unifying all
> > of this with the proper helpers will make sure our accounting is
> > correct.
>=20
> So, de-activating not reducing the "active_total_bytes" should be OK
> ... but I admit its name is confusing. It should be
> "active_and_finished_total_bytes" ? "once_activated_total_bytes" ? I stil=
l
> don't have a good idea.
>=20
> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> > ---
> >  fs/btrfs/block-group.c | 29 +++++++++++++--
> >  fs/btrfs/disk-io.c     |  6 +++
> >  fs/btrfs/extent-tree.c | 13 +++++++
> >  fs/btrfs/space-info.c  | 83 ++++++++++++++++++++++++++++++++++++++++--
> >  fs/btrfs/space-info.h  | 20 +++++++++-
> >  fs/btrfs/zoned.c       | 14 +++++--
> >  6 files changed, 152 insertions(+), 13 deletions(-)=
