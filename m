Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14F9D5B9DB8
	for <lists+linux-btrfs@lfdr.de>; Thu, 15 Sep 2022 16:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiIOOun (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 15 Sep 2022 10:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiIOOum (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 15 Sep 2022 10:50:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423583F335
        for <linux-btrfs@vger.kernel.org>; Thu, 15 Sep 2022 07:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663253440; x=1694789440;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=afU/mHp+qo3JzCMd97yK1koNB7ai2bG/zfSi/quznqa1EaX1Y6hU9rW+
   isFuKBhr+d5t1oiO0hQ7+MVVRvs+1LkSca9z20yk47UzogwgjbYtG0HLs
   ckjvvlrLr6Qwl1Sg61wDZ+8AkB+2vZSJ30WTPCcY0YyQSzkN0OzWS3Y+w
   orsALq3D05O4iju6Rc3RDc0wAo1jPLaG5eEE/u/EGGS9AvWBWO9ALpUse
   C4j1ZpEri2lc/ovzE6JdVWnDFeNJZ+Ee+14IZ5cOPjkMl+/XWJqpx48f0
   GotEVVFSGjqs4p2yYYMqYvQO1jnq8H2KdzxUTgRmNb/2wAnbitO3Ophbl
   w==;
X-IronPort-AV: E=Sophos;i="5.93,318,1654531200"; 
   d="scan'208";a="211441628"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2022 22:50:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SkSxQFptjyZZfKao6rK1rcTUWtVE849cVVCOXxJUUA3zluGYmXKzbd2jBZAA+/VPD9xHWlQ6XeHM0CfFqg4/sqcwnCj8zUX0NWZYYepKc/F7NALCX973pbYhmVPdjPA2gfs4MYMV/5UlvZuHKky8boXqTXTBLDPBfCziFq7oyU7LxaPzHhp8SSbFO6vNMA1cEKhEExAmDg7KItBN+zwJzV0Rl+RvtvMTsY8DUjkrL3vH7GkCfEpr6hf732tetmwcizNn2dhuR3UOQcIdgrplQCvc79LPrDYOcgWn1sb7eqJcWx3K0YcaDXBrKy5KftwoQhio7KardDHwUMi9WxqnKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iVJrx52Tcrj9wqBnkoI9BJitEByIsU6LP/bxsq9Og00IHcNupVwqCssvj5EB7KtwI4PGKjInS7Gd4QOrZ5WtDF26nni0qxxiekL2Mp7SGXQtIULh2qa5naXz5gyWIasOYfQjwP580k90H0F+DAp9mpI+tE4a4SMU9F7Y/iWG+QPO7dEXytPCIKfU9t1A0+2s86wF2rxP5ZJf4NYax4Qej9GVLZHalzLuor8xv1fjoaknzKvgqPdNiOgPedr77RaljgHKVPqy8VjPqn+q8anI3bLuGMpmHCeYokh6n7josKP77Gk3j9dR7gYi1QoasdqwHFdy7heP0AVX/MiUjkS/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=chQMNmJ+k51O7XBQ0Tx8D76U4cgpu3UVeeq/eJV5bZGflp2iC7xFzVz5n30AF24xi037v/BoYRKDgu64e6E0m3JnpuRTnJ9uuAkeLPhfx8Ko9lZUF/XzKV61ee69+SAW1ivj9N61I7esNN6UxIS730/Hv8ZwBJPPzVBXcTPpZrc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4142.namprd04.prod.outlook.com (2603:10b6:805:36::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Thu, 15 Sep
 2022 14:50:38 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5612.022; Thu, 15 Sep 2022
 14:50:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 11/15] btrfs: move btrfs_ordered_sum_size into file-item.c
Thread-Topic: [PATCH 11/15] btrfs: move btrfs_ordered_sum_size into
 file-item.c
Thread-Index: AQHYyI5+mCDxnXk4ykqKwxvgdJE+ng==
Date:   Thu, 15 Sep 2022 14:50:37 +0000
Message-ID: <PH0PR04MB7416CE899E948E776AFE5CBF9B499@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1663196541.git.josef@toxicpanda.com>
 <7d20c1fad6d774c24413fd43af0c204b53adb814.1663196541.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SN6PR04MB4142:EE_
x-ms-office365-filtering-correlation-id: 9e5c3247-6aac-4998-1dee-08da9729a71c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ANwiA5QLJySqoQNE/SejQ7Ux3gpKvnOhOIPOJBmnlvGTK2c6CubJqgBjieyhvxbD6lf15kFEEeQOTpPxYYJvLJN9VgOHOAsIqwcKbXR+ImH1EJ00VbIap9yUwWk4Yg/pm6K9X1feye3ICcuGjEbLf+zJo3GQOkPnI1jhTXK/IGua7T69hyUkCOQBQyyH9N3RfGVHGbWmMl4+WzVQlXA5whVKUAIoXglk+3hR7h0+ztgtewbhi7otXxb/feqWByRAaesPEmwpVFGkepH/TFrukRZS/0iDOec8dmDV1ona5HJJQKhQHZkk7DifVcLVMNN7+ae0cUXCsizl0W3ZmUW6qwYORLNzcAQWpCUsgCZV8JTLTQG1YdkhyEmm2vlOxY3YrBu97C3jLH1pYGuq7GVocO+9Yg4RE/lWDobIT/yI6yYavIjyPx6uObFQUDSUQAHPO5fV+AqtMu/DM/QjWIibbTSa3J+jhg/mRUmv5t+Nl2se4A7knHqN/SjlXFesqJ8rhFbaaMHvUTGaXFF7RV3g+d9WNeFcfrGNLlQksCjXa1lnACqbz7R7H/v9TG934f7nf9oshX2tbZ9ZLc5jaMvYG3CNobxFGysxiAtJCroAs9r5h8uuWD68YEkjx+Sjph7pifmbIciYxVNib9mn/bK2+SiTAhIl8ZY4PtlGWk9OUuOlJDAwb4I3Q2bkUQyR29DqjtWJrMV1l8x3f5PSKm1EKlOEazDBMqgaN0+G9s76BuIVUn92bc5k6N8rO8LCa0EaWj+0AJesWNkHIcAUg6x1rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199015)(8936002)(66446008)(122000001)(5660300002)(8676002)(76116006)(41300700001)(66476007)(7696005)(64756008)(6506007)(9686003)(478600001)(186003)(71200400001)(110136005)(38100700002)(38070700005)(33656002)(55016003)(4270600006)(82960400001)(558084003)(52536014)(2906002)(91956017)(66556008)(66946007)(86362001)(19618925003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Nur57v+ydZP9b+q0jHx9AcziB5wcDmxpevbhA2K33w4sFY6wb4HzQRZxGeRq?=
 =?us-ascii?Q?avvDE3j/m3K00br6tdM5imfaXOCmHqN3i7AvMekMqmEWMRegZ7gQSj3x/BCj?=
 =?us-ascii?Q?Pe3E4dzDA523mtmoCL4EnocaAy4vO7IsZuzys9SBOy9Q8pRFZhdKq/+qJi4/?=
 =?us-ascii?Q?O3oeBXfAg7+xFZPqZHoywV9ChoRKJD9YHi03mavGUR2F4i4hsuL0ECAihiiz?=
 =?us-ascii?Q?qKlCwyXVFj6vgvbPXGplO8jDujv9PEgkYUnhrI59p8De/64y1qNhhfdTebqt?=
 =?us-ascii?Q?Qs4NQuRlf4BGWykjo+XLWo9MbmrV2l9Q6IPolS7yvm3czrSC6E1bKz6yarAS?=
 =?us-ascii?Q?miZ4ylhdIrt6QAMRF7Sm8WFhbcnr85VrIHEOK20qsZ9mYfxSxsEHtBgI+jei?=
 =?us-ascii?Q?Fhqrak2Ni7eCWQCUeSTzIuLog/UxhzzJulT9vfqyevTSpuRnRw2JoMM64euM?=
 =?us-ascii?Q?CkiVg+aOAhk70kSzDzdhDDWzHb6NWc+KbHkwjdLcpBJG6/kc0xXj/4WgRkmE?=
 =?us-ascii?Q?psF1po02MMNO/OjcB8/HbtLFQqXdi5ot6doVjLu/WUoISWfyEKPb5KwLlIqN?=
 =?us-ascii?Q?vcpgEb+kqEaohcD2NaGzSTgU+bH/TJ3g3lcAEYbWVmQYz7xzl8LKWWaXMWDj?=
 =?us-ascii?Q?BW0lIgbTU/SGFmgmUtDkuspHRLM5r5zEkUDF+UBpUNWXsiFsAihXeBYVFnr0?=
 =?us-ascii?Q?BLXke1WZpu848XkOkEBCBZd/DIjezZdyzL3m63NqbNurnYzGIje2v2pNdSk3?=
 =?us-ascii?Q?ChWeA0SKo+PYTmCON8PUvUk2SqqlG4AXWMkthgg01lXX8iXHnnKsf3OB4U8p?=
 =?us-ascii?Q?u9he5f7ZwDirw/IUB9tdaJv77/pf9EGuZ5qAl4kJ0JcE2ybjLv3WjKcW9O/6?=
 =?us-ascii?Q?7mIjWhR6Y+s1p5A3CK+FssWs2KUk7mkAXN6kWgpT2Srdlpv7hTz1zDdU/Sd6?=
 =?us-ascii?Q?8pwFprx5qd6EVJEGjrZBsSN9iv5qBjo0+tSwEwTXROqlmyVNzVTxylHP6mYv?=
 =?us-ascii?Q?q9wjNLPW954Hu2FqdNntxMZBBi5VwINlvctGP3v93ffnsY2q62eCBus3SlW/?=
 =?us-ascii?Q?zJczbFoyTyT/r4qBxM1vWpTAVO4ypeIT8Ub4H9FD9sFxL+cUcjRmuABGI9hm?=
 =?us-ascii?Q?UtFPMWp2nQeqkqAs4KXeT0ENSFUhh7GmOw4vonGZRohiVZpOM5lsRzXm9dd8?=
 =?us-ascii?Q?Xwb+a/7QYnZCmcoWsy6ANnUdinopIzs1u+JTj1Dhcy/ydEuGfy6fjZxax20o?=
 =?us-ascii?Q?uQzO1dtSkIAnuGiKxnvHd/YP4ptZ4ASmJS9LSH400jyUDeLFLdfKRPb9mp0c?=
 =?us-ascii?Q?MUPCbaN76FfNr2u/+d6ttChhrmb5SqsXl7f7gsoPZcuo0E4F6yyv+EB39dTS?=
 =?us-ascii?Q?A13SskLOEDsyTkicF3KUvTDD3qWbt+db9YRCGI3MgBwXh8Kzfi5wu/jTliKS?=
 =?us-ascii?Q?aD5h2m4fHm4Ms9IOOT+fJHDUzkABPCYB6ryk/fnBXMsOfVEiyj9ic6rqFG4n?=
 =?us-ascii?Q?+Ujq/9DmEnjE/hoxZ3eJsKp4RuNnIZ6LcNbpxr8KVFEa9G1quJ43nbzqMcsZ?=
 =?us-ascii?Q?dnvQsgs3G+anHq/BPW0IrXsNZL42Gy9PoNp4OaUgXz7cALJDR8EcOeKO5Q4Y?=
 =?us-ascii?Q?pugorAyQoAfEaXJFdeOYV/QOH+SgUNP9MchqydzAFzjgsi0YSRtHJCAjfGIz?=
 =?us-ascii?Q?giFoflgYaQx2ja5SMtahSjxGVZY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e5c3247-6aac-4998-1dee-08da9729a71c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2022 14:50:37.9125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v2cfCtTcG5PaXoQu7+FsbsrCbsNkM5xEOHld0wGLHtdjL7WSu8VR97BPd2AEund1LhohhG0JbTZXw9X/8KAmgIgIzyjAsab9kxJNuZE/05I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4142
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
