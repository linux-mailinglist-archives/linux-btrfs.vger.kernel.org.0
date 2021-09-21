Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7297412F80
	for <lists+linux-btrfs@lfdr.de>; Tue, 21 Sep 2021 09:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbhIUHdI (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 21 Sep 2021 03:33:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:33411 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhIUHdF (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 21 Sep 2021 03:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632209497; x=1663745497;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+K44tVWDnboS+maTm2gNPrWjFIvzwEJJFZYCsGSW0vc=;
  b=Q960yd+9CDnEtPhJUJyu5sZyXYDCXJtErWaw6ysjmFDcMnGrsihHFS9N
   mYjnAudvSTE7wn+z7MfTws407mtGAbejR9uTHkZ+kv+2eFkveBoVnnuHU
   qS4KaMuYHj7LdBgrwKzL+srzK1EykHcjA/XFVffpoXPlhIRqb1mSelhrk
   IL7E+9nOzF4ERB4PFzcKT/MvQ8W0vr0NIrH8WwEANoRbgJ8f1g2O4pAAk
   NWlZ8xDiOBiCcGNJNugrpqsvyu/I0NQzsgmGTluy38GhMYPpZ+trcooO0
   Lt85nwIqhMJXUTOD/2ZI6XcaR0KULj1zy97TC210M88k4Vi8w2Vr0L/6Q
   A==;
X-IronPort-AV: E=Sophos;i="5.85,310,1624291200"; 
   d="scan'208";a="185310517"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2021 15:31:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBrciP7Tdf0t3y+hb4EfmltodfD8bE7tY0XCBR+CQ7+nmKi165kVBype/4UrXrt/gynVKz2R1Ki6MsGBS5uxs/uZyJ00aOdPsPkXmfhaHgZh3B1ZuKvb/VFiEMGEt1vRA1VrRVye9dD94H2LOyF8QF4pS38nof+h9ihVTiu5PLkU5SOoU6UOTQDlx0taCK2hA7tB/5BpOEWJPeNGLUVJZanvpvFDPFZ/+21FZDm96dKKXxLURtjhVAcZdZjXmWLpzrmCKF34ruG68lTB2FOMF4KIV1CtxWDEVpMAPcG4q5ktXQOYna4zqY88lh+cov0yIgkP2HWqtP+EGqG0VjwpNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=jPqt4IEblQKNdHFDqgqQ2HuajnRpzwl4lwzyQEt5Q3w=;
 b=aw0h9XfkkRMcNHjiFDPLf1g7fNiq5gFOGzcpaxht/eR8RPk4nMJyf1d+U8cm1pGfaVVCtEwe8zJp+pkoF7hGPgzpd7o5YhHSt58USdx81Bhz5OGHYbVgcxqu9pkc4C9UVHcvRg99IWGQ4exq/Z592f0SRtWU878B6mQlojmPMlM4o/X1mAkgy18r5FqFnyDCUCaqLyuF5wD48Em3RduajRQKsaQVL7U0j6Y3MbqeKEki3QNwSrhbEAuvAwHdnl0CeVVrfBn575mOx+USIk+fRtzS1IndqaIdNHlURSneBnqK/t+ggXfFc7DFaQ0sbd+QEWPROgq2fMmRjfRB0IOUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPqt4IEblQKNdHFDqgqQ2HuajnRpzwl4lwzyQEt5Q3w=;
 b=HmJuCOF7NWRmN+EAC0N8awItBisGwxw5iKilDdsa58ZHV6lSQ90IyCz863ZiegookvVIMqTmndPMU0DsF3ueFQodrizfUbHRZrvTPL8eP2CQ6J2do4cCP3OHcNMXJnYeBxnKj4RX0is9ChPPawN/dKHEqaosYiLfAmOmYNqUqnE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7653.namprd04.prod.outlook.com (2603:10b6:510:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 07:31:35 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%5]) with mapi id 15.20.4544.013; Tue, 21 Sep 2021
 07:31:35 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [RFC PATCH] btrfs: zoned: auto reclaim low mostly full
 block-groups first
Thread-Topic: [RFC PATCH] btrfs: zoned: auto reclaim low mostly full
 block-groups first
Thread-Index: AQHXrjHCA645GLQHmk6i34YBTydQ9Q==
Date:   Tue, 21 Sep 2021 07:31:35 +0000
Message-ID: <PH0PR04MB74161B892063626C4B7B32289BA19@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <a5b7e730eeeeebd701d807f7aa950dc1f52caade.1632150570.git.johannes.thumshirn@wdc.com>
 <20210920155006.GN9286@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e107c0d-959a-4389-914b-08d97cd1d75b
x-ms-traffictypediagnostic: PH0PR04MB7653:
x-microsoft-antispam-prvs: <PH0PR04MB7653C54AC12D3D1DD5BDA96E9BA19@PH0PR04MB7653.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9JxqIKa5yB9zg72wUT7+kdkLggLDdBpjBAVRvDvd5yHx00o9u60YZQda6/YvrlP4oSDvQIkPfl/WDnjobRUN/eeKchbxLgcTEs538IP17EXEbUggDu9dKTiotKJIXupTKzXRDaLspB8fCWxdtnu3/5PMT3LDw6Kt94QThdxp4UNcq7hPwFYKWttSfd3IoMkwPFi2V1/C56IRkcFzhGEx0JOQ1ezdqGaIgchyWFhHyzDTnw+d7zBZ5OiJSElF+88PmalyOdHjUFl1HPN+INGDjeudCuGwKAjjtpgT0xFuECOv1rjS2uqu7Rbg+2m6K8OpWDsY+94HQ85w51jVx4YtR4cHxbB0t01iSiibYVX7ht8q/Snm/twNsAIGCzw0exLliXm/qbJD+3UEFpjXVBs8dTyWNjEJhVn1giKunMzfREvZO+oVoXXgWimHtR0n6IvZBoQ0FOYZ6eRZJ3bWXQPnVdHfFAXY0UmAV+pn3aDC/Eg5QIJS753tYlxrDT+K6BGgSFi6IgJHmx+lK1CikF6KEamiTgC/iNeDVNx4LccZk4vx3H4SJ62bzDsPmQ8NWjRRT/xV7Tl0VZa/LdffdIFtQGEiBMRy/Ojg2gi/2qdNhcQNQw6i+WeGP5usNMNX6O2t1Vb8E0exBrK6lm6MuApbCYXcWRSNVk136rQkQQZOiIEImeQbHmBcWriYkyPhIv++eKfVS5C2Gu+40WK5D9/yAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(52536014)(38100700002)(55016002)(54906003)(186003)(86362001)(316002)(8936002)(5660300002)(4326008)(6506007)(6916009)(122000001)(2906002)(33656002)(7696005)(66446008)(66556008)(64756008)(91956017)(508600001)(53546011)(66476007)(8676002)(76116006)(83380400001)(66946007)(9686003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kQW7EuvQ2BYlsuy62R4RmGj/BqhuPW3C14FqGLLwoHLpY5CBI8X3Gb39R+mb?=
 =?us-ascii?Q?EJ5AZmWui8Rurgf0z7aCmvKj7pHf5PjQloW5MRngQI/trEYLjCw723CJop8s?=
 =?us-ascii?Q?I9G/qSpqyEo7z+M/b6Sd2vKk1yrCfBii96Sak0ITrBECp90onQ6/JmeUHO4G?=
 =?us-ascii?Q?yyGdNjGwcy3rK2mGS7bgakBzqiZILN2YfCXJdHqVRQt+330YocThUu8nIOwe?=
 =?us-ascii?Q?wjRdUwfhHZGUeilTNDMA+d92/O2fOPb/wdKr7velFb3c2+yn+9Idktssphbe?=
 =?us-ascii?Q?4w8oEBox/Yp9QmnjAzI0T/chY1AYp5RaPAPiBhuY0wV2E4j4fiNC+GEBqHJd?=
 =?us-ascii?Q?29Al0Hr2NL7ehzoX2+IPpyt5JUswaHHSbbG7P6GoWhAv4sGYyy/yNaVqJp7s?=
 =?us-ascii?Q?NbFmg16KylsFrYoXeMWwvOS5uMP27WSLtuMYWksvl4m1s+1m4+m3pZOuI+WS?=
 =?us-ascii?Q?frHleWhh0Bqj/xUFsAaX3KdHfCgA804W/EE+0JL3Pt6vp3mHEvswYfkGgo5A?=
 =?us-ascii?Q?L6VuUwvBwBgNTD/stJjStxWJbMctB64Md9eA7SFQD5IIZ19uGf9VKM0Lk7uw?=
 =?us-ascii?Q?hUmZFF0tPeQLPstv3H4iVXVhQBZY+vRAspYNLDp5rnMCPxmHUBmDQ5zHRGn7?=
 =?us-ascii?Q?dbd/j0AUPrFbpgCNDzQLUG7nXkMkBI/vs42RbE9sQVlfjZaP8gR+7l7HiJuF?=
 =?us-ascii?Q?E3bDS1pUsYm7lsFAiBHlG5D/Ogj5IwmZcYP/gPEwC7ylQNBJJmro5Ek4C+xA?=
 =?us-ascii?Q?1rt45fZMa3aKTkBU4iiSyNT39wDEbtM0kfy5PiODCE+Ol5imfdwbM448y/4r?=
 =?us-ascii?Q?V49LohhWaDEwcMa7g3+GWkWWIs1tY8Se3MeIJkcNXYL1kNdgB01DqyRKN9ot?=
 =?us-ascii?Q?XwKei7w5JI7DpqYFl+QVBCyFXdnG7bii+8zJLKjinBSveWFlvQZ5y8+0gg9K?=
 =?us-ascii?Q?XNzsKHKqKluoBtEVDVXa17gXMtwEpaxdc8dOmJuVUFoGps8CmC5sLTebavnh?=
 =?us-ascii?Q?g6ilieGrROajUKV9OKhmUXwXAxRhmcmxOSpWcJog0bJUUwym4+1ZyHmexQvJ?=
 =?us-ascii?Q?eGgzhkziR6sg+C0/nfGnoykl/t0OkoXMnO/s3EGVRKL6Kt2QMxwt5c4PJxgd?=
 =?us-ascii?Q?Wj+mUFenlc+3enCr3Uk8wohmBvaidEOFl9guYmQ37+Kn0ecKIPhBZT901OfL?=
 =?us-ascii?Q?MwcH9b0j7CTfezsdF9dltql4Uek/OGDqma3EyGWIjL0BE3N+7EL4vpb8w17q?=
 =?us-ascii?Q?UpkzYzYEDcdrlEjvoEmWnXCpOZqhl7sFfid9OXFZn6CynUKJlylsnpnoFhIS?=
 =?us-ascii?Q?QmmRbSyuhK/djoiVgz6ZQKrtl2bRb5DycimepO18YL8RYTlux81KyiU8SeXO?=
 =?us-ascii?Q?BPvcGuUJ0tQqJmC8REtIzD2IPVlljI9lnAUESI8sShMixKB2qg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e107c0d-959a-4389-914b-08d97cd1d75b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 07:31:35.1542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E4GvuGnmPD2gHfbIjsybwo7e++araJdx5+wH/yq1QBrs+fmIAD1q6d4S4hymdtRzveh8/NnjKJqS+rWygYoJwYdGzolVQN430KgaNccjWgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7653
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 20/09/2021 17:50, David Sterba wrote:=0A=
> On Tue, Sep 21, 2021 at 12:11:01AM +0900, Johannes Thumshirn wrote:=0A=
>> Currently auto reclaim of unusable zones reclaims the block-groups in th=
e=0A=
>> order they have been added to the reclaim list.=0A=
>>=0A=
>> Sort the list so  we have the block-groups with the least amount of byte=
s=0A=
>> to preserve at the beginning before starting the garbage collection loop=
.=0A=
> =0A=
> Makes sense as an optimization.=0A=
> =0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>  fs/btrfs/block-group.c | 18 ++++++++++++++++++=0A=
>>  1 file changed, 18 insertions(+)=0A=
>>=0A=
>> diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c=0A=
>> index 46fdef7bbe20..d90297fb99e1 100644=0A=
>> --- a/fs/btrfs/block-group.c=0A=
>> +++ b/fs/btrfs/block-group.c=0A=
>> @@ -1,5 +1,7 @@=0A=
>>  // SPDX-License-Identifier: GPL-2.0=0A=
>>  =0A=
>> +#include <linux/list_sort.h>=0A=
>> +=0A=
>>  #include "misc.h"=0A=
>>  #include "ctree.h"=0A=
>>  #include "block-group.h"=0A=
>> @@ -1486,6 +1488,21 @@ void btrfs_mark_bg_unused(struct btrfs_block_grou=
p *bg)=0A=
>>  	spin_unlock(&fs_info->unused_bgs_lock);=0A=
>>  }=0A=
>>  =0A=
>> +/*=0A=
>> + * We want block groups with a low number of used bytes to be in the be=
ginning=0A=
>> + * of the list, so they will get reclaimed first.=0A=
>> + */=0A=
>> +static int reclaim_bgs_cmp(void *unused, const struct list_head *a,=0A=
>> +			   const struct list_head *b)=0A=
>> +{=0A=
>> +	const struct btrfs_block_group *bg1, *bg2;=0A=
>> +=0A=
>> +	bg1 =3D list_entry(a, struct btrfs_block_group, bg_list);=0A=
>> +	bg2 =3D list_entry(b, struct btrfs_block_group, bg_list);=0A=
>> +=0A=
>> +	return bg1->used - bg2->used;=0A=
>> +}=0A=
>> +=0A=
>>  void btrfs_reclaim_bgs_work(struct work_struct *work)=0A=
>>  {=0A=
>>  	struct btrfs_fs_info *fs_info =3D=0A=
>> @@ -1510,6 +1527,7 @@ void btrfs_reclaim_bgs_work(struct work_struct *wo=
rk)=0A=
>>  	}=0A=
>>  =0A=
>>  	spin_lock(&fs_info->unused_bgs_lock);=0A=
>> +	list_sort(NULL, &fs_info->reclaim_bgs, reclaim_bgs_cmp);=0A=
> =0A=
> The sort is under a spinlock, though it's probably not a highly=0A=
> contended lock, I think we should try to move it outside. Something like=
=0A=
> =0A=
>   lock()=0A=
>   list_splice_init(&splice, &reclaim_bgs)=0A=
>   unlock()=0A=
> =0A=
>   list_sort(&splice);=0A=
> =0A=
>   while (!list_empty(splice)) {=0A=
>   }=0A=
> =0A=
> We already use splice in the again_list so it could build on top of it.=
=0A=
> =0A=
> OTOH, it may not be absolutelly necessary to do the sort outside of the=
=0A=
> lock but rather because as a matter of good programming hygiene to not=0A=
> introduce unnecessary delays due to contended lock here and there that=0A=
> could potentially cascade further.=0A=
> =0A=
=0A=
I'm expecting the number of entries in the list to be in the single or two=
=0A=
digit range, so the sort should be rather quick. =0A=
=0A=
But I agree using a spliced list looks more future proof.=0A=
