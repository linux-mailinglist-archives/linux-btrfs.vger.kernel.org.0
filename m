Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED69E4E96EC
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Mar 2022 14:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242619AbiC1Mry (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Mar 2022 08:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241379AbiC1Mrw (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Mar 2022 08:47:52 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698764D9D6
        for <linux-btrfs@vger.kernel.org>; Mon, 28 Mar 2022 05:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1648471570; x=1680007570;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RrxZzBAP5gjrNUGs/UMZSAdeTRcCJaiMCOVnUMLqPz4=;
  b=Hx8+JoDy+3yFo8WCIUcNvZt7uO53GvypkIcA5/jwH6v5bJeQHHiWq59J
   RGRU38APyf12PcLRMQu0P+owOdY2OmEpU5FHFfSLQutJgmJ1oXmccckSU
   mGlSsgmBHFdDMCJkr/W61VwrnCnuo0601O0lN6O3sW8U9ZeKyDdVA9POg
   NBVZnns2whRQquNlCdCURxJNW8w6JHHx2CZlpBSYGOfxksjm/TpLo9saV
   5tRkhJRGO4eAi4HJR09kx9cx+8CETni1FpmWqNOArzT9mrEGdvj0uqvKH
   mPnQ6QZpYnPQPU4bILSd9LGHrWpanhUytTlGTN/4ACCw/K2ywqWgvZz+i
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,217,1643644800"; 
   d="scan'208";a="300590519"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2022 20:46:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d+XDPsGZ2LgkzqSqqURcA8UB4TzFLwv7Rqv1WNL5/UJR4XY18yC6HZExdH5+zxpQFlx4CsIeE/W5oD11WfU6ffk2mQqdYgO6pErT3wUlOZXAp9LHPbqzfBGJXQPohfG0drJHRY+YXSWZijW6gW3o2jfcvC1vP5UPWtpG1jjSjqiCq8oagquBASWcjiNIFK047lUXhNICQAOO3lGI0IPPP1PHoKCkDTYxIr9yT7EPvvGep/BlQ5VSlU5sbB/qPJ41q0byVhShgUDfoCBu48fzPdfCDuzwdN+/6DwqKgngUAVQAbr9L8F1bskXQTL0raa/NU6oajb2IXwnbL8nACm98A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAEBfES0P78QsGhmKYAkLey2XlpBdw6ZjS1ytEEqu/8=;
 b=B3MM4NLv1dl/ipfD83jbHaB1o0a2OKg6zrANOdqKi9heVfgbWGkjGwvTOgb4tKp2lETf89eAQTLdHEjD5RVtRIVz7ge5ZVE0n10kKWjRvR42+fY2w+IqYnkS9qO81Gq+guiOko/1/QMJOOejB/BgGl2Guwudli9IPHr18yNmQfhWYH+glrnm2jXIQNQgVyt7NC7KhSgNVlG+65lLJJdndPWvyVhYRoRlxI0RCXU48WVdd1XiR/NuddHPTr93L3AyKH1hZVtazQ+g99+ln6QFCu6pShwfzwevlpx8WFHgBvrECEuKbq3E9qx3R8gAyYSXkVNvjyBbONKlDPnn70NAdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAEBfES0P78QsGhmKYAkLey2XlpBdw6ZjS1ytEEqu/8=;
 b=hHYMKG+D20aMFKazI2XJgrKf5h9WXj+ytlQk9j88C39zXdv4JUs2EipdqX5Suf+8Zh750rGUT99InX2Ql+F7KqsPLJDI4GANNuEa69iNJQJh+OHEBmW+G8YxpGtwsd1Iy81uwHBZcUh0soWHzWAaE/WAUnD/lQ/0qZHtTgfwdqE=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by BL3PR04MB8108.namprd04.prod.outlook.com (2603:10b6:208:34b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Mon, 28 Mar
 2022 12:46:09 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::8d96:4526:8820:de4f%5]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 12:46:08 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/2] btrfs: remove the zoned/zone_size union in struct
 btrfs_fs_info
Thread-Topic: [PATCH 1/2] btrfs: remove the zoned/zone_size union in struct
 btrfs_fs_info
Thread-Index: AQHYP5+IscVKRpCKBUC5B3PTWvbv2KzUxFgA
Date:   Mon, 28 Mar 2022 12:46:08 +0000
Message-ID: <20220328124608.l2xva3jjgaetzk4u@naota-xeon>
References: <20220324165210.1586851-1-hch@lst.de>
 <20220324165210.1586851-2-hch@lst.de>
In-Reply-To: <20220324165210.1586851-2-hch@lst.de>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee4e0c88-7b6a-4f5a-c30a-08da10b8ee92
x-ms-traffictypediagnostic: BL3PR04MB8108:EE_
x-microsoft-antispam-prvs: <BL3PR04MB81088F698AF8EB1AC486508D8C1D9@BL3PR04MB8108.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GdvhrgCkYbGQrtzwhh0J2TfAoLJ3cHzDAcih0cBabvk6HXUWWT+pW4+d9ZAeqBWrgx6g/C1kmU8DvG0U1sA4C2Vc/ZWStN09bArcqHQIqh2FlnSP2HqCaA5LSrD4QcvhxQA2ohzGzkESOiR7m7XjtAUbKKkrVdZIe9PNJlIoeAECwemKDvnMiBlRaRemphiX93Es7cTa0iGyP8CxO1C7jbIMre9RJ0OLV+FUZGE9B2M7sinEnsKnI+TF/jMGc8dtMzdIoapc7/AavnxwHGO7RMVvgxf96JicnKl/pkpVUQoFm//T4GYbEaUEddQeAdRZgJcEceKX0Ig4YgBF+GgObjn3moNaRr8Pof/VOuxnSbqrmL+f8UW8Bpmeuktvz1s1iOtrC1NYhxiAPK/6cjV5ODFdwRL1Rmzf45YspJfVNF5BTPRYO+UCmpMFi5Ot2sjHwPRFXClFlf720VzCcYpp6bUUs6gXwSbsfOlMTM3wwVsV6xyeTOA0XFTaxSX9N2h80jKdzIkNfl+wXw3CPM21GPeuQ4+XQhOd54GBDF6AdzB/Hg/B/WGCkCjO7zYWYw/yXVHPXcZW27fcmJLqwTbQVZzylr4WJTj8lNqCJETGMT0UaHwDQeAr2CxwjSWgvqgd3gfDx6B6zIKCF0dWtRS214s+UW4FVoCzfVj4vGBRFZxoWSVvk5sB+WxhvKSxQcRUfWNUIMEscF3rNSG8F3Gr3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(8676002)(64756008)(66476007)(122000001)(66446008)(33716001)(54906003)(66946007)(38070700005)(4744005)(86362001)(71200400001)(8936002)(4326008)(82960400001)(91956017)(66556008)(6916009)(316002)(76116006)(38100700002)(5660300002)(186003)(9686003)(26005)(508600001)(6512007)(2906002)(6486002)(6506007)(1076003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OkWMcFLEWjNwk+gPGYFKuMzuuc1+EtwaEw7WPY9l1YBDSbhSuRag/ki0NP1r?=
 =?us-ascii?Q?oQbh4XJ5HsdODbcnl2q6efB5HI+pZ2hPrOf0M0mNzRFPFoOqVvIaqb/QEKa/?=
 =?us-ascii?Q?r7t9Mou0U7LW3pebek05nysMWSi2R2Ist1DnjF9JAENKjV1PKPIVd/Cctk5H?=
 =?us-ascii?Q?mCTssdaOE8/p+Yyrkvk1bCDqGbxPbO3OCeP+ocLr82I4pNjHIJSdFnJrhaJd?=
 =?us-ascii?Q?FEgViL3YaeQUKJ0Ai1EwI0sgBx3MrBkCxjihLq2yY3L7yBq3g57IRKEnGKaU?=
 =?us-ascii?Q?J47UVHtr6OaVvaECsp21Sm4FT273WlB/zVR90nYQ83JSWeJLH+XyiwQI/614?=
 =?us-ascii?Q?jvrp9nJSUZ8IBbRHu9Z5pWWzXYrLQg1LH2xH8W0QaV0cuh6Cu1DNYFa3519C?=
 =?us-ascii?Q?VEG+iUj5w1CP8sEQcy11/1jt/Oj4Wwg45ECpM5x1Bb5rg2OZaFnsTrnAK4Ux?=
 =?us-ascii?Q?AgJ3cWN9nx9mxCmzO984kwCwor10j4U7VK3sltLidjSoDsbuyjefgOVLFKxI?=
 =?us-ascii?Q?ukS/EdPPhLH8Nc2DTzS8r1AA8O6WCBM8R988WuoQjejriC8tQQATDdSmoB+f?=
 =?us-ascii?Q?Cfwz2wdfyc2XaWKbUkDvMAWf4p74DrqHw+EZq1oAp75WprY7an6s4+SHezLd?=
 =?us-ascii?Q?yp9m1gpYlu4Sdd/Z+YU8Z39At9rj5DF3XhvPFiphmRNYjVmvOrwhbFQq5gpF?=
 =?us-ascii?Q?Y5gSXYOJ6o4zQsIvDbYOgMIp4ogIzr1DKyouIs16ynCByxHyDbdUhEGY86jm?=
 =?us-ascii?Q?iRjOrhq0UwcLwdKJzSjiGSB8SE7KwAE7YhYn7EYk2eF6X7lKJ4CNz2F5HBqQ?=
 =?us-ascii?Q?q5FvK3xLvSUeZR8g+0aM37KnLIH/cQUc2Q6GJa101YIf1NURk7lWh6QC27NH?=
 =?us-ascii?Q?zM48IrCoWIXI9hbTR+nJ4OkQAwL1KHzH2niYEdRwhuobm65QtEi0l30W+2Yf?=
 =?us-ascii?Q?b8d67wnxGUPOBpDbZ11jUb94/BDVXpPRzyfMs1Yq26FqVgzCV0+cZ8M1Yx8J?=
 =?us-ascii?Q?PknAxi/o7PCdwMIhnZnYaP7Dp0l0EV3tUAhuKeXuG7VQYA1XTQQkZDkbJftQ?=
 =?us-ascii?Q?NxEwIr65GR6DdJDHqGDtxMGwcR0mEKZ6+5Za9zPxVYkhlDLNfnimaFI67lsk?=
 =?us-ascii?Q?CFYiZaiOpEKzlu/dV1zUtnr9nd5RhfVXidW5fBS0pcaiXmMZBbcT2CdFaiLu?=
 =?us-ascii?Q?QjD/DmvV5PePIOTEU6fl/nB19WCGtE3gIrRTwctXjhrBCTETPnrAi4ehiR7v?=
 =?us-ascii?Q?bt47YMWbpIv+IMZDAOrIpo3vwOl1XFAqW9fUfA0+5wbHJqYIp0Uy8YnXWKyH?=
 =?us-ascii?Q?ldYEAgYspy1/UxtjctGCMuEw7u22ymN/+py7BG42M88RTe+8PlcXozL49NNT?=
 =?us-ascii?Q?HI+85kBbXyvPfRD4nbl/MBSXu0H2Hpz9FRuB4B9wIPA/k9S5Q9UY1hFvrDEN?=
 =?us-ascii?Q?/A2sJjLhhDVAyoM3H15/EQaTlmcpUvk53uF1PrFmhT0Qh07VYVuvUFbPcaK4?=
 =?us-ascii?Q?NEKDswdLGR/weW78mxJS3efSK11KHph+ufhPtfgZShQWysMHLn1p8vhTNHeB?=
 =?us-ascii?Q?jxOM3Sh3jz3LaWUDAg0BF32DoKK2Uf2DevwoxMOHoOr7cIP5Nfa07/+57Q7l?=
 =?us-ascii?Q?2S2YWK1zcoxrVPZovl+6e9JWemKDMYRAOp2tCg/uFzjPj9qLop85U0/nxrdW?=
 =?us-ascii?Q?Vru0kHa+AWuAOQuEn0PJ+2POTNAj7qVvgN0XIhnfYzY4mTXFGjv5MhEyJyQp?=
 =?us-ascii?Q?2cWOfPTT7G5fBV8Y98s280kQhZmK9uI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <640BAD3BF7FD78479A14DA871568E1B4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4e0c88-7b6a-4f5a-c30a-08da10b8ee92
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 12:46:08.8031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tq4prKX3CEeeMz8VYLy0tAhRr/JkfjtJTrjPp3VcsenPlPbSgPYq290bfFAtWu3zRWf04Hd0pBLcGib9n0wCpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8108
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On Thu, Mar 24, 2022 at 05:52:09PM +0100, Christoph Hellwig wrote:
> Reading a value from a different member of a union is not just a great
> way to obsfucate code, but also creates an aliasing violation.  Switch
> btrfs_is_zoned to look at ->zone_size and remove the union.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Also, fine for me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>=
