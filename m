Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37D233F43B
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 16:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbhCQPso (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 11:48:44 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:60732 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbhCQPsK (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615996090; x=1647532090;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=XdHnY+LI5KH3U0MdcyTZH9CA3oCcjYyla0y7H6HogRg=;
  b=YsP/x6s+yAGEegjWWp4z0HLr6J0PyFkerzYO0IgtoaHUXgqNzE/GxTk0
   qHYYfxcM/ScgyXk+e58pWSAabmpdgcsTjf252nCWSQfU4GjH3rQt5S58n
   MLY9YhLXH0wER4vHrqKCJo/cwuQqKWhABSCt+RFENro65WRKeN6XA6nsH
   YKBCD6AJH+VtmfWL+94ovQGHmzJgbZndtTq26QOWnmiLXm+hiiSKEIcZo
   PQ1Hwi2wMd/G725AeRWBISQPeXSoDfD0xeroFtIi+T9f1WI7oV57+UV9M
   YipHLTFcrRhJUz+iLUoyhLmPPFHBQVsyq8vZiEyhTIPm3zLbh0CuTQf20
   A==;
IronPort-SDR: uIdqbo4YAZ3CQ+u+1bU9jI26H0p10FzIxCoo5TZW4SLeJFP78wgXuwSkIZLAaMmtyH/4QPR2mr
 +YaWJCnORJgZY863FGCz5F4LCvDgYSwVDXO0X+XWgvmMK4jOhkomXIV+M4YWpDIuxAEOH9cgOk
 y6CQrlr1tEWjFDF5MKtiXUOQLBHHncm9QfKvn73M057j36zaz+2uEDcXaQVSwPr82kxajyRObf
 dYao3gk2qYdiURpJPoz8i40Rf2ciJrXOnO71mVsF9u9PpBaZjoBsSuqozMaEOy/FGLKFzCGk4C
 Hyk=
X-IronPort-AV: E=Sophos;i="5.81,256,1610380800"; 
   d="scan'208";a="273100514"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 23:31:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=an3BwDVKVJpxxQp5aGycCvhE8fjxH4rSqNaOd7caFY21aIeXRdw+AS0koRXDnV2IjWCibFZVWmcN1nTQOHeETAFbC4JN0l6DsU1s4GM/DcEepLizA8odAbnHlwXSPLmBV54WUzLGP9AvcKbmvSrX5VMxjR4ZsqbmZQ3VJuoLCjqEfR7F8Cuv8t/YtXWVd3KVOaS3LeMNIBYMiZ4c/yobl+GKOSqwXb4n+FgtVkzFn5Zr21iS66a7djG2dg9HtDWDq6uNSoTRW4ZgCjDNhBL2qSaj2g175iSxwjJrgOkdPITbPC2K0OzGCxY7Wc04yNZMxiki0Axml1z6NegKLNNQ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CYgghSJNSzwvAjLw2WHemK91zTbSimDU/z419fA3us=;
 b=fKRBZVon/gWAMMOw2I0joyNMqkcWbIz5FxCFJ5IMkooTL4lQ3SeBZlM0F+XwVxiiwngYl9d44V50zSyBki2vdlW8hhGK2Vc9z2h/vv9XXsw7Dt/iBZmrYU/m0ulYDWG+vIbMBNv0HfAtx2fjvk13nALSTmrlIapr2y0rEjYckL4MEKPJfiIokYHezGLZSDHCuWhHmVrN11O3LXUPSGvuu1KkeMrU/tyLjXQazZA/uBuYT2FWRMeL6E6hIuGb56o3shfcT3sZWFDLNlbRz/YTF8HvFI92BBknAvzIDYNTf5xNYTSIgU/k8/pyzDac7NzUZ1WtWtMkkZ/jKOMBABOFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3CYgghSJNSzwvAjLw2WHemK91zTbSimDU/z419fA3us=;
 b=IFxb5Sb97Lfv/qVdi+CTMSzy84+sb3tpUiq2FxubmsScnloFyCMTPA3TJvBZcbyiEQbb4mxdrZdyMNBcZOwOosxYNuJS5uyNbhErsPAbjHxknledurbLMjhLKKXEdpTzD96F2zop/NpIPvPnYWP9Kp7gLFvewbvmYlJVUh5rWYE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7352.namprd04.prod.outlook.com (2603:10b6:510:1a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 15:31:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 15:31:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@gmail.com" <fdmanana@gmail.com>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: zoned: automatically reclaim zones
Thread-Topic: [PATCH] btrfs: zoned: automatically reclaim zones
Thread-Index: AQHXGxmmktl56lD0m0W5npGqcGwiOQ==
Date:   Wed, 17 Mar 2021 15:31:24 +0000
Message-ID: <PH0PR04MB7416DB1D352F9F2BB0BAA6DD9B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <321e2ff322469047563dfce030814d58a8632a60.1615977471.git.johannes.thumshirn@wdc.com>
 <CAL3q7H6rqxFu8TUcKNbr-h73Xa66xi3tgyT5A0Vyw5z3kYhq-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:e193:b3c8:606b:24d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3786e909-36e3-4e74-976f-08d8e959b968
x-ms-traffictypediagnostic: PH0PR04MB7352:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB735249B155A5C392432A95009B6A9@PH0PR04MB7352.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3EpItbKQkpl+fK8Jy032jhSpkXBgK2h/UM7atoky2kshyE+l8WXpClA1tWnXvbYDsh+ARaYYLt9QqPLOJBUyhBUnd3170SQTtZdTHkg+X9ONOzrYzpeZsxsb3T2OV5j4BCe3qqUuGc9jVPiq3yL4opxDx7d5tjrbap2bQsim52ytgd6m5dTYnnEHUu9x9Gr7aRV5mq/W4FRsCc3UAu4YTTvNPmWGNscpbXY3KdZnVXpFgO3s390cEfJp1xEmLKCsldo/L11zxYK/lTBDJLJ9arR9aUl/gIj1+XQ9lBzAVRqIywyAqGrRFmosBKFVw05HbvyOlLJlw5jIz5fvvt9kNgkkuNq7H0F2Qm2KfF0ayAjuJV+DM10Zhr3Nrs/f8GVqfsAN1xnxZBHsxneKUYZK9HpfnYg+78H5B3xe4XZGWRbSUq61rZ1Pyososc4wGTF57rMlARW5Ygz2w9OHVqfUvfMHeiHWliSjnLQlvr/A6IxmdwDBmzq1UwOaTnp8rVNUSrMay3g0sNtkyO1GUuO9YFtN4IwdBs8lWWFZ1fZy01FPvG170pNoFiTQDjYCjix4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(71200400001)(316002)(55016002)(9686003)(33656002)(478600001)(66946007)(8676002)(5660300002)(186003)(6506007)(4326008)(8936002)(66476007)(6916009)(76116006)(53546011)(83380400001)(66446008)(66556008)(52536014)(2906002)(64756008)(7696005)(86362001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+U+dMH2MVvRpCYiTbFwxF2xiRSjGaQkLDDgoQ1Ok69NeEYFxIjfkBwa0jZjs?=
 =?us-ascii?Q?KOsgr9+LfQzbFG/bm5etWXVJzLJZaSfnZxJhSnbV2DmKuqbz7yy7ay49ZCfs?=
 =?us-ascii?Q?e/dwlXncJ/5DaqllslF5rOQLQ/seRjIH73VBAhAd6qohJVXbEINT9a2Bkdo0?=
 =?us-ascii?Q?mYxCDDcUfgf17AUXjhuh7trf9xufLNsb08a13Ym7dUW01rr/rWvrTPlGMM7d?=
 =?us-ascii?Q?V6D+2kJyy3hI1WshOgnbz2B96iZwidAnb9l0mr2Tk8+6VN6iRst1c0vUGQC1?=
 =?us-ascii?Q?eSAkVUeMjYo57ZWAyQYNNmLJgq1LLQKwKdMH0ZfZYMIKd29/lsNuHKC6t6nH?=
 =?us-ascii?Q?ritO9ckAgWjhLdc/kgZyBAL6RLBIGEjHp05fPKn2uY72cgx4SPOTnAUA5U3h?=
 =?us-ascii?Q?Y4y9KYOPCCr0seH2eaytyx/V1eZV67DyCAcEXExS551997Nw26T4nRm8OfSV?=
 =?us-ascii?Q?1SHedwN70wymzOEJimee+LK2WYKAjOQBBwCFMpk32oqsjXMo2JlHOv1ZDc4z?=
 =?us-ascii?Q?tYmMa99g3+eSr7coN6TmbhWQuSQK9ZNWFvDSDtXJ7z9kWI0l2VTOs5TKWQUB?=
 =?us-ascii?Q?UEgQtkOKPtnIa3V2PAaCnS7kNN7cKXvyNEX8dBtwvY8IDUE87Nq+MWg04WT4?=
 =?us-ascii?Q?24TzMvJ8ziNq0R6W2L9YOFJ31fP15GHZOx/poSUAQv5hFuf+3RN6+dp6GV/V?=
 =?us-ascii?Q?7WRl2LR5iQsDk7l8HpeuKavPBYJ9Ox7nCB9Cektpgqlc2Unr7FGoZ5zNt/KI?=
 =?us-ascii?Q?wQApigtpwi/L2d5MMG80Z0TGTCKmgOqSNWMemBoF5U2b8J4hT7BXhu+8JFK6?=
 =?us-ascii?Q?HoL5CAF9v2X2XyauXuH5jC4Kvw60NTRa8AowM6f774r+98XWS229EnV8Cmim?=
 =?us-ascii?Q?wZFU5CCkcPUbpKqumpCk0MehU9r2JTGwkZRkUswTjZDHwRvgBM8cTP6ReY8H?=
 =?us-ascii?Q?EicdRhjrJqXj4qNWGx3R2Y/WnNBtA3pR/iRbwKc+rYEIecWq4pFtfFQ3kGu/?=
 =?us-ascii?Q?ACeZl5Oj50qmXOy65ACWHMSXvQEBJCdy9Xt/ZLnMgRuEPSlqt1BHJfA239u4?=
 =?us-ascii?Q?YpsHwgYIchQC2Wl86qQcRLZ7CYH6Tm5N6VAAdHRvn0NbiyIfcrafvL5L+qdo?=
 =?us-ascii?Q?hMCb8GWZmAqTtDKa9TAOEKLx5DUnZBd2XgFaw7nmiePY1IKpMHM0LptEgvGB?=
 =?us-ascii?Q?gLy/P7CEgo/sZVC8CTvTiTjA1Z1qrmSYLNYVfKafORVubtTP1ZE0nNKnMv+z?=
 =?us-ascii?Q?pKsGKryoh6QrJdDF3K+0rX9T6oc1JhPAkFc9S2D8FrGTkUFu23QTRMxOFeDA?=
 =?us-ascii?Q?qaDU/qS+QoZ3H6qOpNjsrCg2zi7/8DhhpUWzZSoefrZkoOjgqRjLlo9kKYI6?=
 =?us-ascii?Q?p0mME5HL61E9L/6iCLZXwagQgrWsTBQWwURvNwcTY6oRlUQiAA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3786e909-36e3-4e74-976f-08d8e959b968
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 15:31:24.3263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eycnDQLr6If3UCnAX2dhiegbC76WsVjEllN+eTzxPyTXtNinCKpKOjpivR7h/w3TYQcsjPFqV775tUMka/CN054q3urqTWmfpgUqfYPH/jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7352
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/03/2021 16:26, Filipe Manana wrote:=0A=
>> +void btrfs_reclaim_bgs(struct btrfs_fs_info *fs_info)=0A=
>> +{=0A=
>> +       struct btrfs_block_group *bg;=0A=
>> +       struct btrfs_space_info *space_info;=0A=
>> +       int ret =3D 0;=0A=
>> +=0A=
>> +       if (!test_bit(BTRFS_FS_OPEN, &fs_info->flags))=0A=
>> +               return;=0A=
>> +=0A=
>> +       if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE))=0A=
>> +               return;=0A=
>> +=0A=
>> +       mutex_lock(&fs_info->delete_unused_bgs_mutex);=0A=
>> +       mutex_lock(&fs_info->reclaim_bgs_lock);=0A=
> =0A=
> Could we just use delete_unused_bgs_mutex? I think you are using it=0A=
> only because btrfs_relocate_chunk() asserts it's being held.=0A=
> =0A=
> Just renaming delete_unused_bgs_mutex to a more generic name like=0A=
> reclaim_bgs_lock, and just use that should work.=0A=
=0A=
Do I understand you correctly, that btrfs_delete_unused_bgs and btrfs_recla=
im_bgs=0A=
should use the same mutex? I was thinking about that but then didn't want t=
o=0A=
have one mutex protecting two lists.=0A=
=0A=
> =0A=
>> +       while (!list_empty(&fs_info->reclaim_bgs)) {=0A=
>> +               bg =3D list_first_entry(&fs_info->reclaim_bgs,=0A=
>> +                                     struct btrfs_block_group,=0A=
>> +                                     bg_list);=0A=
>> +               list_del_init(&bg->bg_list);=0A=
>> +=0A=
>> +               space_info =3D bg->space_info;=0A=
>> +               mutex_unlock(&fs_info->reclaim_bgs_lock);=0A=
>> +=0A=
>> +               down_write(&space_info->groups_sem);=0A=
> =0A=
> Having a comment on why we lock groups_sem would be good to have, just=0A=
> like at btrfs_delete_unused_bgs().=0A=
> =0A=
=0A=
OK=0A=
=0A=
>> +=0A=
>> +               spin_lock(&bg->lock);=0A=
>> +               if (bg->reserved || bg->pinned || bg->ro ||=0A=
>> +                   list_is_singular(&bg->list)) {=0A=
>> +                       /*=0A=
>> +                        * We want to bail if we made new allocations or=
 have=0A=
>> +                        * outstanding allocations in this block group. =
 We do=0A=
>> +                        * the ro check in case balance is currently act=
ing on=0A=
>> +                        * this block group.=0A=
> =0A=
> Why is the list_is_singular() check there?=0A=
> =0A=
> This was copied from the empty block group removal case -=0A=
> btrfs_delete_unused_bgs(), but here I don't see why it's needed, since=0A=
> we relocate rather than remove block groups.=0A=
> The list_is_singular() from btrfs_delete_unused_bgs() is there to=0A=
> prevent losing the raid profile for data when the last data block=0A=
> group is removed (which implies not using space cache v1).=0A=
> =0A=
> Other than that, overall it looks good.=0A=
=0A=
Ah OK, yes this was a copy.=0A=
=0A=
=0A=
>> +               /*=0A=
>> +                * Reclaim block groups in the reclaim_bgs list after we=
 deleted=0A=
>> +                * all unused block_groups. This possibly gives us some =
more free=0A=
>> +                * space.=0A=
>> +                */=0A=
>> +               btrfs_reclaim_bgs(fs_info);=0A=
> =0A=
> Now with the cleaner kthread doing relocation, which can be a very=0A=
> slow operation, we end up delaying iputs and other work delegated to=0A=
> it for a very long time.=0A=
> Not saying it needs to be fixed right away, perhaps it's not that bad,=0A=
> I'm just not sure at the moment. We already do subvolume deletion in=0A=
> this kthread, which is also a slow operation.=0A=
=0A=
Noted.=0A=
