Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E50F4D29A6
	for <lists+linux-btrfs@lfdr.de>; Wed,  9 Mar 2022 08:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiCIHpP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 9 Mar 2022 02:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiCIHpO (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 9 Mar 2022 02:45:14 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846C213D935
        for <linux-btrfs@vger.kernel.org>; Tue,  8 Mar 2022 23:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646811854; x=1678347854;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=gpOV0Bn4Pbs+P1YWf5Wg+jGKVO8PIr52baoSr8a2H6k=;
  b=k1zCuFRlkttdJN95V+3eTC8aGn3aUOAKWW0XpRtprcmuE2diSOFqBsXK
   dcFck9fl6xavkhCIQ4udtwGnr25BQ/nnEwcLZWCB8tj91sbPtRdsxRwaA
   jSvOPlb3KxgsY8KfT0+MKR/b8j0Wl445bTHcD4w0cdlOctjQ1pznkMG6l
   IKjphal6Po7u6Q0rKlimsiXMyHTgAVzdBHhuiE1UikpTQuXco6/Vqgy2M
   LF9ECZ8BDpAL16M4g2rdTZFMYgCxfI/ZCWKkvbzDnlEMkXqZ2aPjuWyDd
   oCOLyXf8JBwudrmqZq7Trt3QX2qslgmO10aN89aqG2mNn6YoWNmmhbJKD
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,167,1643644800"; 
   d="scan'208";a="298979287"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 09 Mar 2022 15:44:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=csn4WtWAVO7t0ACmK+oeD0qYgsrejGfrpFr2NMvzG+9Vmb2b//DGmn3DnM4l0dmldAXe+8ZzvkI5q0xbsgKtLWJ3yOKNt/rSMa5KBxXNnrKUo91JYYOMfCAleou5v62M/BaEI+8rRXi2VbVOP57mE56HaAb9+mqt/SF06fo8SGdsMMhT0pQwOkrGiaro+31LxycKkpHJbnANZORq0wmD1t96/KBexUdGFJlw+M5crYZsAhukwvyyqBxk/eBIxYjs3vUyYB9SACr2x7fRXH7qnMMLmfk8iwsDlTyzQyXTNK74srDMzoe1LiwQyQjhMGS585u5IrMlHwFNlAcC3OGocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kQLcpJgGwuueh+l6UGYNCVcoumE7SrEer0Rci+FBj8=;
 b=Enfmo7rsl8/7UOIfrTa7y2yLUyO6S+DcLn55zNx6bYESlw21MasgKmZJIcaoTD+Ldpf+6BNbiwZCkz9wO3g4NAXbQqLwYL5jsyF0SrHOYuftoEQMqMnDJueMW2Bu8ALtKOtEqjy61ALJmVx07Un+m7i2zk3tRxAqAnTwhCK7QNHKpII1jbJlKQpCkuuhZMieawj7beb05gXrjzc2VK65Y31M/QuGbXYssXyDaKBgkeoeF6Z8AWWGl/xQmJoQUyJ3HyIXHQgW/pjR/1vfDB7x5TNBMxiGPrAusc37VOPQ9arY321Cx2MsrgIuaH6G79guOltbcqeJo6GjVtVbdgx02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kQLcpJgGwuueh+l6UGYNCVcoumE7SrEer0Rci+FBj8=;
 b=0A6aGK8OqSUeSrfzKPJnW01xO4hmuU6gRMbE7nBATY1xfrRsRGmeTyS+q8nr++8FtUkHZTpxEj4C3misOrBwvQ1IwAhxr1N+PBo8T8sqyuwT73Js9YGSUHDpRdwkAuYRMC9JMATcWZsZVEnp8NoZzHKBHrSf6cgN0BDKkkyd27I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB5411.namprd04.prod.outlook.com (2603:10b6:408:3e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Wed, 9 Mar
 2022 07:44:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 07:44:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wwdc.com>
Subject: Re: [PATCH v2 1/2] btrfs: zoned: use rcu list in
 btrfs_can_activate_zone
Thread-Topic: [PATCH v2 1/2] btrfs: zoned: use rcu list in
 btrfs_can_activate_zone
Thread-Index: AQHYMhC7Ta6rJV0O+kqcVMBbjsuiNw==
Date:   Wed, 9 Mar 2022 07:44:11 +0000
Message-ID: <PH0PR04MB7416D08232CABEC1A92028DE9B0A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1646649873.git.johannes.thumshirn@wdc.com>
 <b1495af336d60ff11a0fac6c27f15533e9b82b31.1646649873.git.johannes.thumshirn@wdc.com>
 <5990aa9e-9082-613c-4ef1-27568d36329b@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8bdbf02d-1b4a-4b9f-964f-08da01a099e2
x-ms-traffictypediagnostic: BN7PR04MB5411:EE_
x-microsoft-antispam-prvs: <BN7PR04MB5411A8AACC308F31E51B055F9B0A9@BN7PR04MB5411.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDvRdYrTb1sVZ2gz5UrqVFhHR2b9P0oHq7Q1X3Zh+n+ZLzZhTpxAooZLYfv2d7VxRLZhqsVhlonINZsIWfNywRBmtJM3GWzveeNgPTTKtK/kWhD1CD5XFcVVb0vE1hXwakUkUL72qN6apiCWTzQmny4gfU7XHm2817f0ov2PZjQmLmoeWZ8i085RGya8nvvpWNfRVt4jw4CNCFZOaLX5sCMKWXdsZYuDX/ZlrWnlRIYICUDV3q3jjiP//QvCbybTY8S0/lQk4C35QBtkzV40/C27dm7K1u+ClxqylZI9W9gE/fXhgcZFAtHdifbcJkn0ND4lc2K3cvoD4ottuol3Tm8wO0YqAzKOk0TnjGbTahn0wx3HnHx5oKnblJLhV3xBVRPjcHvBw759wEno+EJz8dDzf3d1eLMCkTFQd7GnQehRvbeZXjWGhVzjMyCY/GtCAsPUxshgLsA9kBCODraKiKsAI/IoXJfe4+kRNs5pruRvgnpH5phny+QSoFBNqWFGUc3Ba8Hs6f0XBDiWUHP6TRophhT3XF1Wy82/0PhTqFjr7x901pTtG/YFZ8oIgmbcQARwubuPSOuf76oh3VJ9kWfiy1XwkMNMQ8lMcUl89C9c+rpifAJu4G4euVpUF9rKt1DxVYoBY0cw/8CC+r6F5037AsI/igyXbX/E8A1DZunppIJnbi26Fi2S8xAbIsq4yEH2B7hNG/IwkdZgV86IYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(83380400001)(2906002)(9686003)(186003)(7696005)(6506007)(33656002)(53546011)(122000001)(110136005)(86362001)(508600001)(71200400001)(4326008)(82960400001)(66556008)(66476007)(66446008)(5660300002)(91956017)(66946007)(52536014)(8936002)(38100700002)(76116006)(64756008)(54906003)(8676002)(55016003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wlxOmNE2zaq1Sj8/+zil9gZhmmCEpV7ueN7PBfzqDWCqBPfmuD3RlAkeNpG+?=
 =?us-ascii?Q?fxYynX8W8IiZA0clK/v184DeyRxsCDsw18SXIIVwaAD37/VG4hcbSgWYkRHN?=
 =?us-ascii?Q?XpIVRDIDi5nDoQJjEwje1tQuezR4gwZB7HNayfMCekf895N+EPe/+pZH7uWq?=
 =?us-ascii?Q?bCjORIAlJuxV2lZLMsFkopxQJQHL3YoWvkNdMp953ZyegqBLybAT98OZfawb?=
 =?us-ascii?Q?LrdYWMTmVNyPtT+Kfom0OAQrmrdqpedXpitSdIRhI7xaNXOqDuGFPYm0EH3l?=
 =?us-ascii?Q?PC1DRp4SZj6WZl1equD/fV2AtDT2+SdL511720DHf2hKvyDp6wbrSL3nLZ+J?=
 =?us-ascii?Q?B3aZ1BNkvorN4HCxGcISBGl++i6p2e/DMOGZH/1oBCXKocgaBstb59O57AWN?=
 =?us-ascii?Q?1JBGAVuxl9fKdyj5DDkoCN9NkE6BvwgEvADcY0QhnnDTPirJQBO+wBJrMv+S?=
 =?us-ascii?Q?B0kqPWJ4loGX/y+UJKnbMGuJr15yQCYWU63XCjbd7dxz7VO5OavrRJAE91/C?=
 =?us-ascii?Q?9GdxfBG5JdqzeXIBM8747OqmoxFlGvcN3xTgiH/FuLabzuRmGKaUZxG+WKgU?=
 =?us-ascii?Q?2YRsPTIDH3hlEzZZKJRZn5ax3f5Xd8oVfeGxb6xJs1hR42Tub6d/npy5zETX?=
 =?us-ascii?Q?jsX9j6Op1UzPtE6Ylm2+91C8HgN5wIISX0jPUp16TU1eHyIZEl5iLXTzAqK8?=
 =?us-ascii?Q?7+L0qnXyr2BFDy4mjpsrag9+YK/UP+l5H7TzbCp1P6SvxYtBPOUwXRlryk/N?=
 =?us-ascii?Q?cUSnCjm6UCWXZF2Z90s1JvolOwx2iIjw0Bj6Iqj7dnEgPNAy5BT/oaqj3MxG?=
 =?us-ascii?Q?mB8O0EZa9+JYJ+L6T3FqqAM4h9Qtjxg77Xccl12OYCkqBr1RFFNDjpCAiKUq?=
 =?us-ascii?Q?LRsLJ/WXxWG5iFTcnEgJGr29Oc1J7T0eOvPrzAPXudXAqpcEQqmUkoYR3QG6?=
 =?us-ascii?Q?BdYdndCPKyEqddNPC3rFj2X8zQSbVcCLiwroruhu9daItBpdFNeNoDOt9wgu?=
 =?us-ascii?Q?HfgiihguvFz+dbj+VMkIPmXkRaV1HGTgPlYj+4xu3hZWmmpGw8UmfB2fbLJT?=
 =?us-ascii?Q?fAV5yjpm9gkLssZuGAK/E3cozr7sinPWixZUosZIsJvY5oHhulZmZ+wNa6Ct?=
 =?us-ascii?Q?R1hREMyqAzzzfsvC8FSO1BKSyiimD7fCxS5mm6X/ZS23jThnwLpafHjhN4O8?=
 =?us-ascii?Q?uPXy4Hp+AOaoS30eTQ981zcYgPeGI3Y3UUmpjIQfVP+fz4dCNab6dlfR4w/5?=
 =?us-ascii?Q?zHDKlNjWbQcKcIWhv83CVzLxtZXfV8KnVZE/DxohOp5O2E6xWo5NtQBEAaj+?=
 =?us-ascii?Q?dKnzhopPtcoT0cLB137RvzNq2GrhLW5Jhja3yyB8YZRDVIe07oprLQqbtBfs?=
 =?us-ascii?Q?VajcS7l5yWu9Wcxy/1sFVnGuqZI869ZHtVolr1X/bCmGfKYL1zo6yI5oxDHZ?=
 =?us-ascii?Q?YMw6lSTYga52MCroR82YV20aNVEHTyi9nLvJsRgmkyGRUXHVNepshbTkm4UE?=
 =?us-ascii?Q?p2az4hXuMWEeePhKB9mhH+iuhQI81DHHj00znaT4Gscas2FHMgV3JwdmmHGn?=
 =?us-ascii?Q?M3ybWu21zxgm+ufYh8p5jq7KkQ3JAuVuqZM/qiKH5SdvZEub5RcjeBK5naYI?=
 =?us-ascii?Q?+Z6bKI5ictVgTLITrUDpLEyhmu5N+mwwrLAS79RApvnDav6bqpiA9U+ETBXB?=
 =?us-ascii?Q?z9jiUBqipuMQ65Ci+NEn8wmrR3tRxPTiVsWd6BvyPD/45Y0x4Qk82QYmRUGq?=
 =?us-ascii?Q?T3hOm8xobRzkvf6dKkncxK8jxVnpklY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdbf02d-1b4a-4b9f-964f-08da01a099e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 07:44:11.3099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOcQlZ5xqXV31GsLoqdbvfkPbNrnWvUKbxEMwIMTvl42pFXTe7qjrBZeDXuNqn3aPubxFoxcEGm/Mtom72xhqphbo5F70G65BXZd/HGDJyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB5411
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 09/03/2022 08:37, Anand Jain wrote:=0A=
> On 07/03/2022 18:47, Johannes Thumshirn wrote:=0A=
>> btrfs_can_activate_zone() can be called with the device_list_mutex alrea=
dy=0A=
>> held, which will lead to a deadlock.=0A=
>>=0A=
>> As we're only traversing the list for reads we can switch from the=0A=
>> device_list_mutex to an rcu traversal of the list.=0A=
>>=0A=
>> Fixes: a85f05e59bc1 ("btrfs: zoned: avoid chunk allocation if active blo=
ck group has enough space")=0A=
>> Cc: Naohiro Aota <naohiro.aota@wwdc.com>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> ---=0A=
>>   fs/btrfs/zoned.c | 6 +++---=0A=
>>   1 file changed, 3 insertions(+), 3 deletions(-)=0A=
>>=0A=
>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c=0A=
>> index b7b5fac1c779..cf6341d45689 100644=0A=
>> --- a/fs/btrfs/zoned.c=0A=
>> +++ b/fs/btrfs/zoned.c=0A=
>> @@ -1986,8 +1986,8 @@ bool btrfs_can_activate_zone(struct btrfs_fs_devic=
es *fs_devices, u64 flags)=0A=
>>   	ASSERT((flags & BTRFS_BLOCK_GROUP_PROFILE_MASK) =3D=3D 0);=0A=
>>   =0A=
>>   	/* Check if there is a device with active zones left */=0A=
>> -	mutex_lock(&fs_devices->device_list_mutex);=0A=
>> -	list_for_each_entry(device, &fs_devices->devices, dev_list) {=0A=
>> +	rcu_read_lock();=0A=
>> +	list_for_each_entry_rcu(device, &fs_devices->devices, dev_list) {=0A=
> =0A=
> =0A=
>   Sorry for the late comment.=0A=
>   Why not use dev_alloc_list and, chunk_mutex here?=0A=
> =0A=
=0A=
That's a good question indeed. Let me try it :)=0A=
