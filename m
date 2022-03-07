Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137854CFF35
	for <lists+linux-btrfs@lfdr.de>; Mon,  7 Mar 2022 13:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236735AbiCGMzs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 7 Mar 2022 07:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiCGMzq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Mon, 7 Mar 2022 07:55:46 -0500
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D205C87B
        for <linux-btrfs@vger.kernel.org>; Mon,  7 Mar 2022 04:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646657692; x=1678193692;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=yozbZx9jF1K+TieU+1oBp29bFon88ElDoq5z6s/CE84=;
  b=aFHRg4bv+9nDubsomr2IXb6cXiZbD43AfdPY5pPm5RSJIkL24xBmebP+
   7fjlb2eyoG8/h4v0O2oFzmn2Et707U2HtKemCjilx6hhSkYdFH0A5HEc1
   ddBOPcMXTGEfJ4cmy7T5Ewlpk9dsKChd1mcKxfN9IOY+NKD+6vSO+iwVo
   cYCMRpypD+4VsGBo+QUIhNJAVmVAOHVbjHW/ZumjHZWTWDDmpNU5fALqQ
   5runoQCM/91SU6hfIz3lNkKy1l1grNNAkKAUsaT979vhrwk1gynV6hS94
   0E6mKbfrZqVODXK2qzXIAdMgTn5Th55QyU8HZ9QGqCvA5J5A2XOH0QNnb
   g==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643644800"; 
   d="scan'208";a="298804266"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 07 Mar 2022 20:54:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgDiRD2TW6n5zPjXPz00AhqPj5Hp0phKrya418s1XpeZRXZyRmRhXlPf1XwC04Z2yDP2WH4RrpzCpE5NbxL12HT10x8CKpaQXHMVyPGg38hVW4azBPiln3x+gZlV4KjwfE+V8PCelwVJcyy2nWLguWhNE9EMyAakYp8VVcSfjudaweDDrOrgYoJB37M9neKOQCu019Qc5ahId9Oj1I/2bzuxynwcPY+mYKW1EsPOZ8N/LBvO1/lysMoBph6qKQHpFTY4oqI4lKXJDBRg7lKtA1pypCx5Xh4czcLKL2mVikIYrHunHQv/0proWFsU2mNx5FHACRD8fvA3HixYpMYfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/XASIqaupxheFyPR/MF8SBHJ8guU32+zw1CYBgbbwM=;
 b=Sk4nB4uL633wdBzP3G1nsNMPNZ0j4X7XqOVrz+I+o3s9KCmBcq5+mzkqo1dZmxt0gZBcP36lS44zq2omGY/qlparyG8rc+Mrwmp3nv2fVo3ue4+B1zOWBv2aYAQNgcZF8o1lZDOhGTvSX39AxZEiupNTaESxyumh8SMb2Fp0eiJ3nDPDkPPe6vZlYX9yc51Gg2awrW7HUUBk5LLTcbprI1YxaomH8CRDuypwVUhkUO7EIe/a23oOYmr+ueKX+YeCf+2h3RyX2VT4o/LoRVjXVLeSGqk/iwbRVT9DKDnMM8SNDVSVLW8c76l8GsaHptiymX11aELLDPGW6+8NLvobFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/XASIqaupxheFyPR/MF8SBHJ8guU32+zw1CYBgbbwM=;
 b=gSB9jn/fJzN2CIUVP+JWqeNpzDWxlH1wR2Dn6/t2PdR0+JeD9OlsXfwiYHBdSon8Z5LbCaor2zj21A+Rm+hnq5C+37EgC84txfDGIt/Nm1cGpL7N0iTJJkvqI8oglWcAvsBazPZYfFVAJQ0h7QAmcYfjImj4xvEq93F36hhDqw0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH2PR04MB6695.namprd04.prod.outlook.com (2603:10b6:610:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 12:54:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 12:54:47 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>, David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <naohiro.aota@wwdc.com>
Subject: Re: [PATCH v2 1/2] btrfs: zoned: use rcu list in
 btrfs_can_activate_zone
Thread-Topic: [PATCH v2 1/2] btrfs: zoned: use rcu list in
 btrfs_can_activate_zone
Thread-Index: AQHYMhC7Ta6rJV0O+kqcVMBbjsuiNw==
Date:   Mon, 7 Mar 2022 12:54:47 +0000
Message-ID: <PH0PR04MB741629862E1AADAA467723569B089@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1646649873.git.johannes.thumshirn@wdc.com>
 <b1495af336d60ff11a0fac6c27f15533e9b82b31.1646649873.git.johannes.thumshirn@wdc.com>
 <57d23926-12d7-b8b8-ca76-15dd12f802a7@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a757bfd1-6fe1-41c7-e0cc-08da0039a8e2
x-ms-traffictypediagnostic: CH2PR04MB6695:EE_
x-microsoft-antispam-prvs: <CH2PR04MB66951EC2057492A393F4F1B29B089@CH2PR04MB6695.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MUeP3klxkqMB3YK0IUFdPX3r8PBgwAbmzXnIDuMdrzeXwKFwyUn7kRPAH3EIKGvkBO4sFxyP9BLIIp4/jBAMe8yXFxY/mVFSQ2/0ujSNyGT6jhr+s1nK4PfOTr/YEL0yHf38k9/EBg720DfP9d3zm9kKbfWJTkAE0Y2o7XhBPLT5DGwugHim771l1umn4YikNaCt3cNEy0XSuQfQw2WZ07p5vZ2ysRREor5zl5somPeZIhIT4RC7kfkd9u+6KHG1W5gqOxBXxA5Q7jltLfw5zYcCeNOnpbvh9/pAHD1kGGy8bNGnFj8dMNVFXTt+Q+Y8RPW1Z0Rf5Sk9FqYgTPUx5MoxoXVeKSNtwe1ZM6dFBRHRxj1rOPzh6Nvq/3lAzYMKjBIFKEuiF2W9zC1ALhqYQFNw6jjn4gAtmra7eMQOns9aqh6CPwyDm5B27BkqI3R29/bDafRzUnLA5YKf+QWTWvrB9fEcdn8CLBloQ7NyEgKW97H3yuuXePQeJscT9o6lpmgNDQLsqKMQ2wrsq/au8ndJxObbLj7KjuEwms8IhunyxxBVMUQOhEIQZtPHUOEWUmfkn8glpTNBwDr0v1vDPOT8NTqlPA4l/Xr3+4IKGcq37NsV+xfejHs9dg0Fx1PkaXmzwwOkTLuf5qoCWFCp4pt3sntjV3XyGpi6v8JPUxBMyS4gaS9j7YKPkYDLSeAb2DmsQIqhWke6Zxoa1RHhSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(55016003)(82960400001)(110136005)(38070700005)(38100700002)(54906003)(83380400001)(316002)(71200400001)(66946007)(66556008)(66446008)(86362001)(5660300002)(508600001)(6506007)(7696005)(33656002)(52536014)(8936002)(53546011)(186003)(2906002)(64756008)(66476007)(91956017)(4326008)(76116006)(8676002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0zuloZ5jxg8tSYW9lO/LYO5huGMUcX3qiuV7WTBo95K7R2i53ZhdA46M5MM7?=
 =?us-ascii?Q?98zryU1tLHaZ9mB5X+IsJUf9Gqwxkjxt7ptNZuEOTYnD0iZDEIzDrSBbQsgo?=
 =?us-ascii?Q?vidM1lvEUv07XNLpOGfis+u4UwPjy17o8Aiiu70EJ7kI9z9KhW7p5MFVhbXO?=
 =?us-ascii?Q?JiFkYCEiStrCYc49BUbE9EhWErCvOEuN+JjXQs66Q08KWE7L9b7+CzZUbtd0?=
 =?us-ascii?Q?7qSoNOBxtIGY+XBvjK7zljl+xFK5kz4UpQYHIABPyDrUcQU0CmvElAGjhyyh?=
 =?us-ascii?Q?dF+vyeTj/XGf34z/OZTtKd54xlYbTH0WoSKD2SX2VpOG7pHvJ4xubH+WIODs?=
 =?us-ascii?Q?zZEsrlQlPZjjIH6OgsODD78dQj/zSANPH2CE2+pHEvAftCJpAl0XmUTMmqJx?=
 =?us-ascii?Q?hVp26sncth+Ujm2ogcQ5viZAEA8yEJB93RoI4FO3zLwdUP+AB0p3pM03Zd7q?=
 =?us-ascii?Q?g+X4Em2tCzRcrUC3YHuGXhjIvcOH0uvjxKrDdC/TRUpufSBQl2wIgQ1HEtKh?=
 =?us-ascii?Q?mJMfOBGd0wdP9jQP6fIuJyFM9uIeTg/mweeKvbWN1kiSGW/SVkFB5DIYovGa?=
 =?us-ascii?Q?N0Nu9Oj/Rpb3CLjdMHBFxKxJL+SE+DyKTYStQJSuVsA1sUgeSn1IIOWntj3I?=
 =?us-ascii?Q?APMqOFboaal7kgIQdBUaWWowTWjczf2knUg6YmCmezvV2RzGbVLc6PXLky6c?=
 =?us-ascii?Q?5o2aAY28PIzTT7dRSOpnLzI1+dBlxw4dj61tVq3+POyWXWSKbGt/PUXhwCtk?=
 =?us-ascii?Q?iSEhKjO7m8hMKQqpGZZNIXxy326mpbH4xgoQEkQM+Dmfd4T+eyb+Z2OnpNXk?=
 =?us-ascii?Q?185mXcgfOZY1RiB144PtR2PEfNzmDTVCoIE1FBjE+xkbph/Oc+7g4cxvz/QI?=
 =?us-ascii?Q?U2k2UHZJAxlNG4g/ezA8ra2QpcKrtsbhq38FAKd8f4kuyc9nkykPROmdxjcl?=
 =?us-ascii?Q?Y0Y9CsaY2iLldSGXxpyBRJ6H/bBmHI7ywPvniOPInQ88ykgELIGWuXZNJC/q?=
 =?us-ascii?Q?hoYMLr6n6Rz5NkGvXzqgTGkmw4YwXCCW/5TNHjIVcGU8h3V9qXpYml+uotni?=
 =?us-ascii?Q?tmDQhMSQ0fzGdqrLX/SllXiACfTETPjtelD3KoW4DraNhe6ZV27wK75N+U+e?=
 =?us-ascii?Q?tLhYBP2Ie4Ravn+LONW2Ow73drdORMr6fBR3sJvHu6OVGnFrJQirrIoAatV4?=
 =?us-ascii?Q?HHKDCNghooIJ1o9Dx0sxwrM0V9ScSJe2tlJXttd1Yj06hXulK02qlgSbvH3f?=
 =?us-ascii?Q?Q+M2EgFQwLxvc3DU72E1xGHPThT6TGmLp23Ty+g+J6AiTF29+nSQbEJFrIjs?=
 =?us-ascii?Q?n7iNSnIOl0tw+J8Y/g+/9hnHSiS/CeFZSAaU1yEKWbzz0tB/GSJHS2+ENiTc?=
 =?us-ascii?Q?b0OiNOAd+o/FDPGwVF5u6gyMkJ1qrfzviEgLJ5uegPgcF3D8sWYhfdbPadXL?=
 =?us-ascii?Q?kwvo4n2buj9WamUAOPW7lFdVUqW/ZZBDBkgH+kqKZH2n3XWmKwfTQy2lH3Vc?=
 =?us-ascii?Q?/ZNdCp8X15W/bvjEFwmoWssB1V3UqpdAV2kMRYazLDRT7iN9iDnEa6dSneKS?=
 =?us-ascii?Q?3RRdc/LODTTLaWIFKK4wrd6c0rhpEH/LVH7ks5t3TgxxREF4UGI0wp9tuvDU?=
 =?us-ascii?Q?MlYcNlTk36Dl5/2z+Iwe4DkIuxr2TnoTK8Zq/Cx99y9nQT26JUGqH3Y1cVie?=
 =?us-ascii?Q?ZhgaOqVEvKoBHiLCPOTW1toSyiyvAzF0Axny2BrJOS3jL/1x/n9Em8jJqJ08?=
 =?us-ascii?Q?4/gzArTj9YEhcmpsh/Ya2P7p/pqzrIE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a757bfd1-6fe1-41c7-e0cc-08da0039a8e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 12:54:47.1204
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0xg0ErGj/pC/qkvCUEaVmLM793rBNhGDdMyePCpPOmd1ruGfNnWYkNBTVYMyDCmgAAaq9MrYcsmJpMKYLkUpEnJCExOWKmKAs0Ys1B7K9c8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6695
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/03/2022 13:34, Anand Jain wrote:=0A=
> On 07/03/2022 18:47, Johannes Thumshirn wrote:=0A=
>> btrfs_can_activate_zone() can be called with the device_list_mutex alrea=
dy=0A=
>> held, which will lead to a deadlock.=0A=
> =0A=
> Could you please state that thread? I tried to trace it back and lost it.=
=0A=
> =0A=
=0A=
=0A=
For debugging purpose I've added similar code to prepare_allocation() and =
=0A=
got a deadlock (see the lockdep splat @[1]).=0A=
=0A=
=0A=
So code inspection showed, that we're calling btrfs_can_activate_zone()=0A=
under the same circumstances from can_allocate_chunk() and thus are prone=
=0A=
to this deadlock as well. I think it should be:=0A=
=0A=
insert_dev_extents() // Takes device_list_mutex=0A=
`-> insert_dev_extent()=0A=
 `-> btrfs_insert_empty_item()=0A=
  `-> btrfs_insert_empty_items()=0A=
   `-> btrfs_search_slot()=0A=
    `-> btrfs_cow_block()=0A=
     `-> __btrfs_cow_block()=0A=
      `-> btrfs_alloc_tree_block()=0A=
       `-> btrfs_reserve_extent()=0A=
        `-> find_free_extent()=0A=
         `-> find_free_extent_update_loop()=0A=
          `-> can_allocate_chunk()=0A=
           `-> btrfs_can_activate_zone() // Takes device_list_mutex again=
=0A=
=0A=
=0A=
[1]=0A=
[   15.165897] =0A=
[   15.166062] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
[   15.166572] WARNING: possible recursive locking detected=0A=
[   15.167117] 5.17.0-rc6-dennis #79 Not tainted=0A=
[   15.167487] --------------------------------------------=0A=
[   15.167733] kworker/u8:3/146 is trying to acquire lock:=0A=
[   15.167733] ffff888102962ee0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, =
at: find_free_extent+0x15a/0x14f0 [btrfs]=0A=
[   15.167733] =0A=
[   15.167733] but task is already holding lock:=0A=
[   15.167733] ffff888102962ee0 (&fs_devs->device_list_mutex){+.+.}-{3:3}, =
at: btrfs_create_pending_block_groups+0x20a/0x560 [btrfs]=0A=
[   15.167733] =0A=
[   15.167733] other info that might help us debug this:=0A=
[   15.167733]  Possible unsafe locking scenario:=0A=
[   15.167733] =0A=
[   15.171834]        CPU0=0A=
[   15.171834]        ----=0A=
[   15.171834]   lock(&fs_devs->device_list_mutex);=0A=
[   15.171834]   lock(&fs_devs->device_list_mutex);=0A=
[   15.171834] =0A=
[   15.171834]  *** DEADLOCK ***=0A=
[   15.171834] =0A=
[   15.171834]  May be due to missing lock nesting notation=0A=
[   15.171834] =0A=
[   15.171834] 5 locks held by kworker/u8:3/146:=0A=
[   15.171834]  #0: ffff888100050938 ((wq_completion)events_unbound){+.+.}-=
{0:0}, at: process_one_work+0x1c3/0x5a0=0A=
[   15.171834]  #1: ffffc9000067be80 ((work_completion)(&fs_info->async_dat=
a_reclaim_work)){+.+.}-{0:0}, at: process_one_work+0x1c3/0x5a0=0A=
[   15.176244]  #2: ffff88810521e620 (sb_internal){.+.+}-{0:0}, at: flush_s=
pace+0x335/0x600 [btrfs]=0A=
[   15.176244]  #3: ffff888102962ee0 (&fs_devs->device_list_mutex){+.+.}-{3=
:3}, at: btrfs_create_pending_block_groups+0x20a/0x560 [btrfs]=0A=
[   15.176244]  #4: ffff8881152e4b78 (btrfs-dev-00){++++}-{3:3}, at: __btrf=
s_tree_lock+0x27/0x130 [btrfs]=0A=
[   15.179641] =0A=
[   15.179641] stack backtrace:=0A=
[   15.179641] CPU: 1 PID: 146 Comm: kworker/u8:3 Not tainted 5.17.0-rc6-de=
nnis #79=0A=
[   15.179641] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.15.0-1.fc35 04/01/2014=0A=
[   15.179641] Workqueue: events_unbound btrfs_async_reclaim_data_space [bt=
rfs]=0A=
[   15.179641] Call Trace:=0A=
[   15.179641]  <TASK>=0A=
[   15.179641]  dump_stack_lvl+0x45/0x59=0A=
[   15.179641]  __lock_acquire.cold+0x217/0x2b2=0A=
[   15.179641]  lock_acquire+0xbf/0x2b0=0A=
[   15.183838]  ? find_free_extent+0x15a/0x14f0 [btrfs]=0A=
[   15.183838]  __mutex_lock+0x8e/0x970=0A=
[   15.183838]  ? find_free_extent+0x15a/0x14f0 [btrfs]=0A=
[   15.183838]  ? find_free_extent+0x15a/0x14f0 [btrfs]=0A=
[   15.183838]  ? lock_is_held_type+0xd7/0x130=0A=
[   15.183838]  ? find_free_extent+0x15a/0x14f0 [btrfs]=0A=
[   15.183838]  find_free_extent+0x15a/0x14f0 [btrfs]=0A=
[   15.183838]  ? _raw_spin_unlock+0x24/0x40=0A=
[   15.183838]  ? btrfs_get_alloc_profile+0x106/0x230 [btrfs]=0A=
[   15.187601]  btrfs_reserve_extent+0x131/0x260 [btrfs]=0A=
[   15.187601]  btrfs_alloc_tree_block+0xb5/0x3b0 [btrfs]=0A=
[   15.187601]  __btrfs_cow_block+0x138/0x600 [btrfs]=0A=
[   15.187601]  btrfs_cow_block+0x10f/0x230 [btrfs]=0A=
[   15.187601]  btrfs_search_slot+0x55f/0xbc0 [btrfs]=0A=
[   15.187601]  ? lock_is_held_type+0xd7/0x130=0A=
[   15.187601]  btrfs_insert_empty_items+0x2d/0x60 [btrfs]=0A=
[   15.187601]  btrfs_create_pending_block_groups+0x2b3/0x560 [btrfs]=0A=
[   15.187601]  __btrfs_end_transaction+0x36/0x2a0 [btrfs]=0A=
[   15.192037]  flush_space+0x374/0x600 [btrfs]=0A=
[   15.192037]  ? find_held_lock+0x2b/0x80=0A=
[   15.192037]  ? btrfs_async_reclaim_data_space+0x49/0x180 [btrfs]=0A=
[   15.192037]  ? lock_release+0x131/0x2b0=0A=
[   15.192037]  btrfs_async_reclaim_data_space+0x70/0x180 [btrfs]=0A=
[   15.192037]  process_one_work+0x24c/0x5a0=0A=
[   15.192037]  worker_thread+0x4a/0x3d0=0A=
[   15.192037]  ? process_one_work+0x5a0/0x5a0=0A=
[   15.195630]  kthread+0xed/0x120=0A=
[   15.195630]  ? kthread_complete_and_exit+0x20/0x20=0A=
[   15.195630]  ret_from_fork+0x22/0x30=0A=
[   15.195630]  </TASK>=0A=
