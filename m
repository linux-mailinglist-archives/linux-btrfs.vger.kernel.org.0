Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C745167BC
	for <lists+linux-btrfs@lfdr.de>; Sun,  1 May 2022 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354395AbiEAU1f (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Sun, 1 May 2022 16:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354339AbiEAU1d (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Sun, 1 May 2022 16:27:33 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178053F30C
        for <linux-btrfs@vger.kernel.org>; Sun,  1 May 2022 13:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651436646; x=1682972646;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=p0Tdz98dNbuuGv5Ur08pHgxMFg1htTSaXl0NqyC9YdxpiMsHwScZ5swO
   wRdOFE4Q/NIq0sMV35vMSKIdFoGdLCc/j4w7Lvs+kzk/sZVpKq3ClWUpo
   jYPPNnsHkeSKZHUyzMppePVk1NMwVYGxfV32pp0KBKyspRUrZK71v3PO9
   nhIuT0U8dboKE02h3VDimhZk/x1Y2HV00UUIFVSmFZf6pbOUqwQ6SfApn
   1FEYF4nMQs0hhrDmWGspcKAdan3qEz5I8cFa1NVIaPIod9mORv+3YdC/V
   RpYqNZbo3LY2VIEcTopTMBtnwRFYTP4i0j8ATtU3gmhdSJOi1fUFNSRAi
   w==;
X-IronPort-AV: E=Sophos;i="5.91,190,1647273600"; 
   d="scan'208";a="198125107"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2022 04:24:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNFQ+8349qhaobouOkI19h1Nye6Wk12WzY+iy+Zn0wmwOeJTm46QxoLgcx+N/fOn9zzp56aOW6zUso0xwi6Upm6gyW3aii150Csu7ASWmAj6X5OIbvv3tLcJSiL/j6gP6pZblAXNiWGzIX82tSmV09cGd7Fimz7WH6QarCbQ47dsevT1/8XMd6MjJiroWkM4zrhLnRMaW02f3+wofzEj01ezZNQaoKzaq55Lb5iR9CVcS5Htl7i+Utm7Jj6maogayroiSmRuGGPFIJCiL7kRYNxvpI6xYZPzIVABVpVJIv+5yybwExNQHgHvAPHACVPpI5jCxDTWf30oP4wURuTklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lod6JquJ8SBzrbI6vYNU5b1uvuDx1sEUDcDUF97YMafgtCLHzxPNrDaLgvR8mHkVNuru2wonm4cwUuApjwQwbqiJv+gAcGvEqexNp0zJ8cyT9292EI/TEgjKZlpTPhqW0EM9/Fht55nGhczovx+XX42/vv9R1fFGgrumD5tkeLjO0Gw06U7IK/Swae2mjIwrrgasFg0ZatpX6hxaSA17beKUoNaChhZQ+ZRlgRSPH+xrtLj7lUIKfiFdQXurvE8Qhyi+gPtzDAPliFScnVVbH23XvYFJyCj7fg7ZOmg0w41nCfrxQt/h2mJWOR2GwxsLYKwml/XsCm0DE4mcls+lXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=FUhRN1MkJWXZVtgItx8oS7ZUJbiaVpCgrsr4/HVyubyH4sD+JeaqqlM3QnqeUo5mdrGX+QeBPuEY7HIAtgQUn80BLTZ4PZVfgW9Ei96qz/7YsT5jV9b2Ml+I1MqeRS7adHTFmWwxinDiTWn2+4TZ/Rm6cCrfmHfbt/brpyEnmh0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6689.namprd04.prod.outlook.com (2603:10b6:a03:228::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Sun, 1 May
 2022 20:24:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5206.024; Sun, 1 May 2022
 20:24:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/9] btrfs: sink parameter is_data to
 btrfs_set_disk_extent_flags
Thread-Topic: [PATCH 1/9] btrfs: sink parameter is_data to
 btrfs_set_disk_extent_flags
Thread-Index: AQHYW/doJXsPYp5cGkKy5ndJE+j3kA==
Date:   Sun, 1 May 2022 20:24:04 +0000
Message-ID: <PH0PR04MB74167EE62B7C94337BB930DE9BFE9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1651255990.git.dsterba@suse.com>
 <1153dbbc81cafc6ab780541b93dfc0b1b37527c5.1651255990.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14603028-2760-4a5b-0c61-08da2bb0892e
x-ms-traffictypediagnostic: BY5PR04MB6689:EE_
x-microsoft-antispam-prvs: <BY5PR04MB6689E6AE3A4E5C38D530F2969BFE9@BY5PR04MB6689.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4+tjBs4q+cqOCp5sCsJ+KcqufLvVpaiifCzivY7qPwpRM0FTwcVvT41KqdTx6I2MIksRiv5D4J8pYsn4fAnA2+EgIpc+N5f9ZtU8kuiLo1Wp7WUH2Uzbisr9fUIP8bC71Y6GqVCj3lFR0qpRV1k1J/h4vY1ZmRSyn0rXhjvn10IQGHrXM1C16PdcyAVVq6MQOhOq/4Z8MigUqOB3FbbqTwzuL4Ycu9mWSzL92YQqsPPVhCQ1I1Ol3KpOL52me965zelU4HfnwaC9GQU1vsUf6k/9EXPEulDdAmSSnNYdEqS1wG3oVw+V2OVVBpXC2AgACd5b0Dxo+/GAWx4dmzT2oCxqMOy+2tnP4qMuzcljbE/yUIzDTIdWkC+MDYdEiY6fkl9OjLbvx0bBucPrHAxCNp1I0ZW/CWtPF0SSESfwupy4otI2UY3Uxj7YLOynpajY7NJfMAsXt5I+L+5Jyo2aBT7Zy2TLUp6zf42iU5tknjuSBLhX39PDNtu9wEeClaVVUdKKCJuwZJ4ZaOQeBanqNStseEs0dKqN2VVppkwU0QCZc12FXtzKL3ju2xhRihAJsZ6a/PKmXZKyZeDVHauvQLcUbQap64IA5e5j1eFL9Ola8yJc6/Ik2+8C660rs+PSTpKe+A8K5rSKY/1JjfsGUmlD87mykFBTtKBxbdBUidqVeFGpWCQoSBKLPsh3qwquMlMADabwv+m0uc42r3o84Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(26005)(110136005)(38100700002)(52536014)(38070700005)(2906002)(6506007)(122000001)(82960400001)(86362001)(4270600006)(71200400001)(186003)(9686003)(508600001)(7696005)(19618925003)(558084003)(55016003)(5660300002)(8676002)(91956017)(76116006)(8936002)(33656002)(64756008)(66476007)(66446008)(66946007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vq52ZBJzV2eVRdVOWZw010ANUsyBoHpq/WuzbklmVCsX3rVDK/tc6a6El7tY?=
 =?us-ascii?Q?myJBvW7DyycxzN7Hmv1xCK86q+iIKXI4r/TRBqqBA7UNX/0QMlhfrCxeQMBV?=
 =?us-ascii?Q?kY6HPDM6eseZpkKlt62RbpPQzHVwMJ2NOuWu93JQXG+jHsBI2lUI74gKdU4I?=
 =?us-ascii?Q?lRaNs0ZELIdIzZAtDpn/qA5OeR3pNfjE7jc4+xfVhtonAMTpT7OVi0aGBidM?=
 =?us-ascii?Q?GukS9YxzQpBvcAVgloY7lCXU3GIItOcR40q1pPpSoDouzM6RncJYijMCPeh/?=
 =?us-ascii?Q?fxi5sLvBYGzp8FUKYMsD34jpZXmPHb5q4zzAfphkz156uLrQUKerP/e3aKWk?=
 =?us-ascii?Q?Xl8mvvK4Dq8Cy+YhfbAEc32L9I/lFxCmsxf4lhdyzKwP/wsm8pUrHlUW9CXg?=
 =?us-ascii?Q?9a1Tr8LM++G4VA6Dlxunw7yCBba1J2ld2cRWqlbVW429Z4lFIkAfPg4ShQVG?=
 =?us-ascii?Q?+wIOO9BFufIhf7WU0nkwM5Oj2QYDWbEm2jtxK7yCsWZ00mj3TpzdE+C3K7XT?=
 =?us-ascii?Q?0rRc5oeFDVnh85IAQP3Z07be7JGuKjzhDlbks8xBfGRtJkKzqG7rqqAYR0gy?=
 =?us-ascii?Q?6OHeIo2osv+sAxVoy1hnANrjo973qquhOXEBk3JXLSCb+FO4LqaCBMzHNmtG?=
 =?us-ascii?Q?WUInFnhNnCupkPvf5B6SiBOrr17UwJ4YX4DwBAVebNg9MezT14o7H3q2D/KS?=
 =?us-ascii?Q?mIGyx6Vj51WMemZvD5T3H839NVDVz4yhQGunksIctRlNYqfk7fvh6IQm7aCv?=
 =?us-ascii?Q?AMnSIYrL1ez+fB9JZgtXWT9PF54S/1GqPVXb7+MxBFIFB6NkzRZ4ZgzrXhUT?=
 =?us-ascii?Q?1JTwtlNUzpnzNzgzKT8su0EqMru9biiOScoHetGUoEheiBS0jDhl5fePlal4?=
 =?us-ascii?Q?XbijSEhXSKoPRcLBXC35sNAaqqpf/scgGLNd1HmeXtzJIKf35dr5oKW9STPS?=
 =?us-ascii?Q?xqs0eqMpGSlyRRh5h6k+MK0XoMJrgKmIM/AVXpnGSYUNMwpOfVCMayLYivb+?=
 =?us-ascii?Q?nXbHQKzfixe3PcWcOIQq9vM9PMHAf5+MECn0yQC00xP6Bt8X0YuxxGpiEYiX?=
 =?us-ascii?Q?QPwKpSL7Tl0zibJ6hh1xPZJ/1NyQkC6pmTAgalt46TGEGMLh37Ci5K59cbdo?=
 =?us-ascii?Q?qi5ewMEIvj7zi1xGU9Iw2iGgFPLJoTgSvU/VdyXutqxhMtV7MVOnFEgLPKxZ?=
 =?us-ascii?Q?7bymZ6fiVV3Mu+MTU3sd57Z/FYWGmKbCq9q3VUcYr+wssSp4Ivoy+CPRDKH0?=
 =?us-ascii?Q?Ksj/WKkG5vJon7/CA/xm52aOHkme4Vs4DJvNGCnjvc/mz2BdDg69E8mVjFLO?=
 =?us-ascii?Q?iWOZunaSVGVerJTdLV6xyaQHNsC5L6yzegx0raEDw0kV2GJY7q/a3IllPLnx?=
 =?us-ascii?Q?mGOY2NI5lSY++v/WoIiF9XTtOnZGjiE6b6+GXvPSkKAU13Tld3hiUK2eV/dl?=
 =?us-ascii?Q?6VbVGrjxIhVOVnSWbKlr6/wQ5EeLOLB/XB1ieSeCdHSMOaY1BOPybOO4JywE?=
 =?us-ascii?Q?By4e0/1LksFqLOVPn62bGkCP/qyY8b1ITZcJPlluZLL7kVg2D8wmQ4VkMUk2?=
 =?us-ascii?Q?xYU+H89mR3tDu7IF/5oHNhuoCdaFZZSo4UlFFEi94puxb2RtKJTYCgWeWnGJ?=
 =?us-ascii?Q?O0FiCSkjYMi1xgb63pa3GtTyVsJf9MAWzyXfe3A7AwIYMGvr9ifl3VN6ENmO?=
 =?us-ascii?Q?zNeujd9UcTAZLufIKrvLNoDxblnN00D89PBYKDJzOkORKjnK9MbK8EVsY9u6?=
 =?us-ascii?Q?gqVEA7siv4LC2rTyj8VS96IrT1nnbCo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14603028-2760-4a5b-0c61-08da2bb0892e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2022 20:24:04.1768
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLTx3Wi6d8ZodLrp4YJ0epBHQ7VXBsWSe+JKD/cHpaqv0V1xwN6ZgXfjuKIkMG8El4WyOLWaJGvpQAWElYbge3z6B1kee2IL7JtlvjYE3QI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6689
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
