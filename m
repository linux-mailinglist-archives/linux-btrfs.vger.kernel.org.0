Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2BC4E4A35
	for <lists+linux-btrfs@lfdr.de>; Wed, 23 Mar 2022 01:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiCWAxu (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 22 Mar 2022 20:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbiCWAxr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 22 Mar 2022 20:53:47 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF4423BF7
        for <linux-btrfs@vger.kernel.org>; Tue, 22 Mar 2022 17:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647996738; x=1679532738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+ED76ZbB/cL7yW3cjjtc5NUNvY0ZL+eGLVrwOKNsHbA=;
  b=dSnHir0uxRjs1n0NKTf1xDBMQAKWoJdXewyhNC0ewYnPfdLChnvJS9nl
   ZgyYETiPL20jxBkbfth/9tTWNRQ+0m14UNKPNp3MF+3KeCXqw6LOGrFc9
   BaU7lYMdFSC0q+enGoSEeXMAmhtn5TtaUuyXQ8nhM/bISKwPptVOgIr6q
   e7pU8abuziua7QAZYG2baMJbSlrWBLSQ7Yt/cMxiFlinQO4INcLvwTWSS
   B9/yyxB/dx1wh2MDg/pUzg4ij9krpHXaS73VCMXERVXtBgDprQiKBWiDL
   8FwrHmEQovBAP1FlktsC+aXf+tQ8E4dDZElpkcDaV+5ZY5LXm+kB1Atz4
   w==;
X-IronPort-AV: E=Sophos;i="5.90,203,1643644800"; 
   d="scan'208";a="300161859"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2022 08:52:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZMHtOyZ3Z2IIEkfqhNe/MeDBLCxvMiDOWU6AXQdz97IMIB1VmBHQpI7GccdMeDcoY+WlwAJDTkOJkaQoxEdHykYvWKujIejbVGtv2FeSD1o83wsBJwE3xEqdJB1IM7njqcldE6TZVHoxFpmh1Zd94zO13Chwd+aWQvLtbWy0PuVGGEIHcP+ZaH6cLcEnHfA0Nu7+P75pvRBXKeRuWfmOzFyPZypQJBPJQgvVVIQJXb5sojmQxEuxhiulkOcfD6ZgYxwoKHhXASgRGmrGjtwpN2DOboRw7BTBITiLlIr/l4f79AW2f+Js8P/beYFl1qpeMSI0ZTS2Z/VtdeMwmhFEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QvDbIteWY9xMoLNp8Lr2rPZCMFE0LDmxDA/PUUvKI6o=;
 b=WBkejmJuGtdVIXAMS513NtvVmldl3DrbKfmRKACr91G3c/lVHsYRp0/u1eC4Xx8DjbgBy0Lg79J1g3BKwMVpGLUGY5nllAIHICFvMzFedVGG+qHRp42cV+rb7G9lpfqFgSeY+UgdIEzXJ2w8Jmj7ySyw7kM6L9fMqJxJF4XGZZHCas8JzmjFk9/dPZVgOw5qf2E1h5ZIxDTYN7p9to/ABAmt1mQiYYZlb0UJ+CVw/DcyM28jFnCdvqdNmi3cNNFxtXkZQatm4nZditxjs3IMykfSLt+flFEEvW95/jnNEEmxpx2kCvyqTrSS4WxZhUPJCWC0BQmbpW6nT44Mk5mQKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QvDbIteWY9xMoLNp8Lr2rPZCMFE0LDmxDA/PUUvKI6o=;
 b=s6DW2OXfRfJ/cNaVfGpsgviueQPflYs45y/0DZpfc5Lykg0M9KIxIFO9bzDWMXQIaImcVrKi1RDte2mfi5RFJeF9GD5pY7HNZNyffNyjrG84jZmNFLE+KkB4fMlifUQDySByGto89v2U725wvtjeROZCuGUFClVxtIHKP1ed+4g=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL3PR04MB8091.namprd04.prod.outlook.com (2603:10b6:208:34a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 00:52:15 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 00:52:15 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Boris Burkov <boris@bur.io>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH] btrfs: do not clear read-only when adding sprout device
Thread-Topic: [PATCH] btrfs: do not clear read-only when adding sprout device
Thread-Index: AQHYPYAIHm/MMGpi4kCI69yVOdu43azMJXqA
Date:   Wed, 23 Mar 2022 00:52:15 +0000
Message-ID: <20220323005215.22qkdgherdyrocuq@naota-xeon>
References: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
In-Reply-To: <16c05d39566858bb8bc1e03bd19947cf2b601b98.1647906815.git.boris@bur.io>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 668aca8d-d00d-4a20-3c0d-08da0c676009
x-ms-traffictypediagnostic: BL3PR04MB8091:EE_
x-microsoft-antispam-prvs: <BL3PR04MB80912D8E88EDAFD55E25D9518C189@BL3PR04MB8091.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zWEt/lu2zh5N+t6wsw/RImYwfgGBEk6IORRVOoSWeBXWAGYTk0m31N/veDMcRPj9t6e/0DXd6h2724xTaCf2bhaKCYf2Nimp7QfAsop8jxyCBEsB6oBiLwJ3iA39vIChbys3zTpGcWMBqCa2+2cYebOGLhOiPuJZddNN+PskCLAC/O6BjhD66bx2k+2JlTIEgg54o052e+BrDB/Fh9uMzXmKrYy1pefW/wLe9G5w3N/QZJ8d8g03OIYff0sIguhJXjnfDjWNCRIn0FI18OMCv7L0siL72XH3Yk9Imto4Hxp4R18LK6WGUrt6DVtRPZcnkVhF0GlU4RH6N95SZZxI4tEgH10EBnH8M6Xcn33UIVlA5agLJReIG9URbfMec0kx40j6W6k6lfiDP+WL6yx2xNf+atLnvOb9zrCiT1SnLhjAW41Du5QaoCwQ2l4Y8dvMV0fGldLvpsNM5WcZAOMuYc2CGDNLGaJThNkv12v2wA7k8/0GQqinhfOFiuBCS1YqqGvATPETisxFOPR7KN85nolHdZxc8N1MDavgOveE0zbjQX8Lk0ZvfcdBf7xwUvJ5Lb9iVAG7PoCCxGC6ByFxefZvM1PfdEaDDYGOIykQrgpT96lBAivvlkYI8YvH+feWGC87ABgh9Vb3V/jBZtAsN6QNPOWJahA2huCfYNjaZ6B8dcZOXRFm4EGGfpuqgXCcBtPmT9nnka5gaqDmRbx0DSCDarUB2Pq+IqZntl9cfJQNSTXNFkTwlh5SpXuJ3ep7wXzh0qmJVe6YP8hqR4UwCFvcLuXYUN55g8EiEFAyNiM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(2906002)(83380400001)(8936002)(1076003)(186003)(38100700002)(26005)(33716001)(122000001)(38070700005)(316002)(82960400001)(91956017)(86362001)(66946007)(8676002)(66556008)(66476007)(66446008)(64756008)(4326008)(76116006)(966005)(6486002)(6506007)(6512007)(6916009)(54906003)(9686003)(71200400001)(508600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DZ52iC8WbkUJSVxlBuoFjL0+6dmVx5B88Kq1wCiL1p/9U7Csgx0Qr2tkTtqH?=
 =?us-ascii?Q?bpQKIhxFGJXOMsJaAIbshHEMSQKE0bvSQsykKSz7OfsJIggL5XtKwkX3Poat?=
 =?us-ascii?Q?D4UOV7V50QmsNEuShhaZWqiuCJI6XhDEqk/lQVdZSNrddlMMwB8LFo6lY3DG?=
 =?us-ascii?Q?UBWTo8V3VkUEE/I8wFY8tBIiIbSzwykCBMxvF+IxgndKFNnhCLSjGRE/IsAS?=
 =?us-ascii?Q?ga8e7E9qXlE16R5JVFokU5tKYtglRNl98zsbDJRe4lWjaeRzMqD0pRa9s8FT?=
 =?us-ascii?Q?2s1O0H/KF8RrxFVBuhWipq8IYKO2bPgv70Szm2GZK7wm7QCM1cCIsCER26zE?=
 =?us-ascii?Q?d7b58ubNXSAK52b2nIhoJ6DaxO/QihfVgvANGjG9wAmtOW4iuymA9onljCf8?=
 =?us-ascii?Q?xipf0nxnSwFtrzzTaAt2tcQ0tps+27WvVmweMf8j7UR3ZghPxOaghq04YoaN?=
 =?us-ascii?Q?Hhlh/VNvhWSl5V0A/Bun1YFg0zKN5IlQs+y8jY/Hw2SM/e4nXLzqeiHLeqk7?=
 =?us-ascii?Q?MS+cNUjSpVw61CpA5EgQOVRrQZZHGfEYiZZ4pRzKMEsXxjRbXbbCpqKvtFLK?=
 =?us-ascii?Q?zQF3razj/wGAl/gq8a0dT6Js/eVZxQu8IqTZWCiDWJTl1YHAhyuy7f9kwOl6?=
 =?us-ascii?Q?KblCtd/V4jgw2CJq3TbiCq10/xJpB8q7CnUNYsHdQk2mTZz2+eRpm0St+lGd?=
 =?us-ascii?Q?nJ6NzmnHZh/yXak9iPq/aC5thLBav3VXvOKK/LWbO6R5HlDYy3iaB/e+Zo3l?=
 =?us-ascii?Q?Ij3iCxErEemyuf7GVBE9cS9sD68T9DnWTee2oULWNH7R81Upz+KiS7rW4rUT?=
 =?us-ascii?Q?Dshg5HOhusfnjimpp5yoxadoBedjY3pz2Y2hVJ7zOaBdM3+Aqkwg/xKgI6OR?=
 =?us-ascii?Q?LmDVuVK6ctQxlU5gDCBVuaCoHEMhmHz3jkgFfXtteEjaGnym7dWpH9ZGvi0r?=
 =?us-ascii?Q?VHqKKfVIKUMWXZRsB5kV7HUGG3pVSBggZQtS0AugjvsIJipmyv8E+x/qwhAC?=
 =?us-ascii?Q?SvDeRPhA644j+A+yvsOs1ixw4cXX37/mYWoE+6RDp85AZkCHRB6AYzOOPfGX?=
 =?us-ascii?Q?gzI2jH29uj/o1R4cCIvgsFtIbKEHVtQTBQYuoJa9GEgo73GA2+gWwvV4Excb?=
 =?us-ascii?Q?DLTagxhdNY/XuT/EPk0l5gIy0hBoQ4XX/tywp1pjIrjJPLg7+lNDt3/eTRB1?=
 =?us-ascii?Q?lgA/VF3CXTV1uY+QvwhjdAK7cyRxZ2eXdeDLPSb+TBjUnAJaBVOSMej1I9S8?=
 =?us-ascii?Q?nUH0ugEGlW0kzAPWpfva8H2ZMbtg2+curEqFLOzsUKOH3lJVMJzQ/nP0SILP?=
 =?us-ascii?Q?AVFuQo3rl/3rpdDnp14Jp8tUGKDvlszgmnMoeZsk3CkAPobVR+URKWR1parn?=
 =?us-ascii?Q?xOC4UGV/hQXHe5Qhli2LcQFv4TV054VsnW8yRbApzEi5tyECmbfoN5CGUjcI?=
 =?us-ascii?Q?JMuYI5ls/qMZufBA/chI/RVsoydF/a3xDF7EDRMrhhVIgu/HkEMCsw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E97F606F2F3EC4A8DF6EA07DDB63300@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668aca8d-d00d-4a20-3c0d-08da0c676009
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 00:52:15.6699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tKvveDVhWdAJUX2P1UIErt4FV/D14rx4k0hdCmnWIUuO+rWUvshp3+YkkpzwMAd9c2GvjmT+cYsfiCgh8xxACA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8091
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Mon, Mar 21, 2022 at 04:56:17PM -0700, Boris Burkov wrote:
> If you follow the seed/sprout wiki, it suggests the following workflow:
>=20
> btrfstune -S 1 seed_dev
> mount seed_dev mnt
> btrfs device add sprout_dev
> mount -o remount,rw mnt
>=20
> The first mount mounts the FS readonly, which results in not setting
> BTRFS_FS_OPEN, and setting the readonly bit on the sb. The device add
> somewhat surprisingly clears the readonly bit on the sb (though the
> mount is still practically readonly, from the users perspective...).
> Finally, the remount checks the readonly bit on the sb against the flag
> and sees no change, so it does not run the code intended to run on
> ro->rw transitions, leaving BTRFS_FS_OPEN unset.
>=20
> As a result, when the cleaner_kthread runs, it sees no BTRFS_FS_OPEN and
> does no work. This results in leaking deleted snapshots until we run out
> of space.
>=20
> I propose fixing it at the first departure from what feels reasonable:
> when we clear the readonly bit on the sb during device add. I have a
> reproducer of the issue here:
> https://raw.githubusercontent.com/boryas/scripts/main/sh/seed/mkseed.sh
> and confirm that this patch fixes it, and seems to work OK, otherwise. I
> will admit that I couldn't dig up the original rationale for clearing
> the bit here (it dates back to the original seed/sprout commit without
> explicit explanation) so it's hard to imagine all the ramifications of
> the change.
>=20
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---
>  fs/btrfs/volumes.c | 4 ----
>  1 file changed, 4 deletions(-)
>=20
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 3fd17e87815a..75d7eeb26fe6 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -2675,8 +2675,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_=
info, const char *device_path
>  	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
> =20
>  	if (seeding_dev) {
> -		btrfs_clear_sb_rdonly(sb);
> -

After this line, it updates the metadata e.g, with
init_first_rw_device() and writes them out with
btrfs_commit_transaction(). Is that OK to do so with the SB_RDONLY
flag set?

>  		/* GFP_KERNEL allocation must not be under device_list_mutex */
>  		seed_devices =3D btrfs_init_sprout(fs_info);
>  		if (IS_ERR(seed_devices)) {
> @@ -2819,8 +2817,6 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_=
info, const char *device_path
>  	mutex_unlock(&fs_info->chunk_mutex);
>  	mutex_unlock(&fs_info->fs_devices->device_list_mutex);
>  error_trans:
> -	if (seeding_dev)
> -		btrfs_set_sb_rdonly(sb);
>  	if (trans)
>  		btrfs_end_transaction(trans);
>  error_free_zone:
> --=20
> 2.30.2
> =
