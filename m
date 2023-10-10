Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C0E7BF228
	for <lists+linux-btrfs@lfdr.de>; Tue, 10 Oct 2023 07:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376502AbjJJFWs (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 10 Oct 2023 01:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjJJFWq (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 10 Oct 2023 01:22:46 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED5A9
        for <linux-btrfs@vger.kernel.org>; Mon,  9 Oct 2023 22:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696915365; x=1728451365;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=dkUZIYz7c/aY62mcvUN5I7hCx/6a0ef9N0YLo1p0+NY=;
  b=c/iDX9oRc4OvSzU4p18Q2VFuffNL8Ok63BVCsjQrO1PszAFDH3u3wrly
   0xjiPaDteqmivJ5TAh4WxceiqbTDBUF3jNsaSw84Oe5MyQ/0eRB0xfjZD
   Sb9E71A8i+AZLtHR4tkoxMebnChLsvgsYN33jqnSCm1w4e5svlcBXumxx
   cefFDara4Ot7iQBfEnF0Oggg+oSa4lQmbRzxgWx65I3Z70q+jcRh7avWU
   SdV+wnWGhb2/sxhDAGBmHTsFuKVw/jCYZGgbiQs0o2MWbMXSXve7tmRI3
   Ol1AcUbIEn17A6y423J0hB8Mq4fMw8GtMcHXAZjoae8FHB8yBeiL88Sqb
   A==;
X-CSE-ConnectionGUID: O5NZfuLhRq2GJ9WUDs9CaQ==
X-CSE-MsgGUID: 13pPfqBBQuuwSDhWz40ZDQ==
X-IronPort-AV: E=Sophos;i="6.03,211,1694707200"; 
   d="scan'208";a="358232861"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Oct 2023 13:22:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSWQ0Tkch2bTGssGx5IKwQxL9lAM/JVizRVqM8B1IjyVyCfsGuJyP10aVF7xsKmmG1h5UW4VJqcOd2pnvRUA+ZyUzwFVZ3mJOCGbj+RjYCgZiO0ymttdGLDrHNjcA5K1pxoYGeY6FYpIzANQV+PscQMdceRWz1a4qL6IhFv/SUPHab7VtGmEqffaqSnfq14inmyyjVOjB7kxUY6rVEDKAKIoJ2XMeV9VWR1rbNR8iSAzD/C6ZIPPGF2+afgPGqHTjsfH7aNpmkE9h7mkKaibDKiJakVyJyPhnQzj0uOXPK7ArtsLJ8CMf2H1XwcnnUfEqZxhx9NEPOJfi7gG4rQtFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZjDREjzr5QHqgBdkQGb5jdxw0onrn2CEBrWNTsHDNQ=;
 b=NlsD1aj2+O2ghNZdifgWCuVjE28yf9/Ed0H+NYLSGOy7d4E4V8CJ1Pzr3lggTv1t4H4FdmOCrPFmWUIZ9zK66oTZgc41xFq5Qkk8ouheMhgUtEelVC5Pg5Jyl35y+dHkO9VoAaNSHNhXpJqvbQcdrh5kaUg/neQnm01DcEEcedYVnpUcpuhadxOdR4aLRsxcytN+sew1w8QkvyqVYh+qL2VrD4z7ihGfJKocBo429TbZCUk4Y1dKWDXu3ZV3HaZJ3icpzIAziDtpNGi0z/Ro/ffQdYrTkFlbkW2O2OQ5fXE0MdUgs4PMnSo84Nol4Je/24VfovBtN6+DoDVtJMM19g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZjDREjzr5QHqgBdkQGb5jdxw0onrn2CEBrWNTsHDNQ=;
 b=m1hzXJJItLZjn9um+x/X53xmodFBeGka4vHALODpljXq0nXpQofYIzBfVbNAM8YY83GGBJmWksDosVVsxLY+uS9LpKEz1SLyO2TPWSih/SVgq5cgOoIqAtxLf3c+3k+N4rQjDYlTmRQ8oBAHqzy3mcg+8w6P1bVTJR0gpMVA6Bo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7222.namprd04.prod.outlook.com (2603:10b6:510:1b::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.29; Tue, 10 Oct 2023 05:22:42 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2256:4ad2:cd2b:dc9e%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 05:22:42 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     Qu Wenruo <wqu@suse.com>
Subject: [bug report] btrfs mount failure with SELinux context option on
 kernel v6.6-rc5
Thread-Topic: [bug report] btrfs mount failure with SELinux context option on
 kernel v6.6-rc5
Thread-Index: AQHZ+znLRCvK1Pzp206FvwzbT+4JNw==
Date:   Tue, 10 Oct 2023 05:22:42 +0000
Message-ID: <yq5o7y5cptazpevhohy5e2ddfjdzsi35pbpijjnzjzejtx233p@phog4jcu4mtr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7222:EE_
x-ms-office365-filtering-correlation-id: 709ef3d5-f1b2-428b-6c6a-08dbc950ed9e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9gk1s79rH6TLpCgVCtfJ0/ecywsUk4k1OYcTsyXgstPqHKNjiV6fql0gWQOvPd4jkJDyzGddO5piiKKbgyVzh+UXZhS9DuHD7ldsv+hTdUf/UnITm0M7RXxDbCiBwyeoLrqQE48L9Tlk4FUj+K/SEGRbQ864rity9F8C0LP+EuZ0Sh/Ty0WqRbY02d8czyHnZV1s/Mt3ZVQF1dYV0Rcr+4Me8GGyPkSG1T1u3ZlSGBHQb2Y8pSEWCL9XAUJH+G7JocARclL00/h1DqdmfAYXz07Jo0qu431JJRaa+kAJ3CpHcOyP/vr6lp5yEHgXBquS9x+jwPYtwPY1Hk4aY5slKGANIzeyvAiqQ4gMeDxw6IuA71mCyOrw8ko8919w8RUkS/j8ZZZox8FrEMTn8HlDw8WZ79tRqz2KXEsTLXxdh97NwA1x6VMSctdJrfVH0cBsy42eDFwzyBTtEVy7/WecOcd9jiP0wFl5mAt86y35ObnZe4KtGGgiqdzT3eUZ2JUSizVDGI+bjAcPNNgDk/bpN7sOFH1Yc+C4AqaY9PhG67cP1EU1TykjtpPSGWiXJRDojJ4lgiIH3gYYT42ku/ha3DhQYKKvURcP4t0LywzuEFFCprok/I0QXD05sCnGRa9i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(83380400001)(76116006)(66946007)(26005)(91956017)(66556008)(66476007)(66446008)(316002)(6916009)(64756008)(8936002)(4326008)(8676002)(5660300002)(41300700001)(44832011)(6486002)(6506007)(71200400001)(6512007)(9686003)(2906002)(82960400001)(478600001)(38100700002)(38070700005)(122000001)(86362001)(33716001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7s9EsDtBhwMbcb/STIq2/t5Iej4TYNTLmtzddKOBmNEjPNML/E/o664B22g3?=
 =?us-ascii?Q?RhM3Imtgqy9HwZwEyV8Cii9McvbaJZgD7Bwj6hOCKeARX9TP+0NgxRdjJdTv?=
 =?us-ascii?Q?I2/a1Iy4pUAhTAMAeA74J8ITxKFKaHsEuzPer46cUu2P3LuUhR6fNxt2zZk4?=
 =?us-ascii?Q?3ivkRfZdmHLq/0UTgUBLUfabaCoZdmELNgU7AI8FBrhIKNx5VaYEESp/0+3u?=
 =?us-ascii?Q?is/5Onj20Hfg/gRbofrj90tieR6crKmqOkWQ3dj2fHK7MN49CZHubkdO/U7/?=
 =?us-ascii?Q?7om39jmiNjJYm6m40256YlnoOz/XEjUs8frsAho940hApq1cY6qXSQLbOFza?=
 =?us-ascii?Q?lcjkSZaTuOzrIWyAKOHnYEaDA9w3iphRN0s6yNG3trUYTALwcIEQAYB/+ith?=
 =?us-ascii?Q?UMigns/XjFh0EDdceCmmwaQd3q8XtmgJrpPuFm0ssroUxMvo4XqwpyoFKYbe?=
 =?us-ascii?Q?ZNWN6v4v7PDBLape54b6V7dY2BbUC7A6gtHqfGv3g3auV4uolF7pOaWboQxT?=
 =?us-ascii?Q?MKBaUTgwDLO7BnnVON2o/cFGtRBlqb2y2qNUH7a9/f5ZFgoGX3iHOrQUs1v7?=
 =?us-ascii?Q?jltThLHJQQbMVwzIJybIfQBMrawTOpVbcTgA8eV/k0xAxaJRO8h/h/fp2pj5?=
 =?us-ascii?Q?Eyxsu4cNXxe+xTiTt6h76CN1gC8WY6ppwUg0x1mLe14zof1JMIzdmeZ3j59z?=
 =?us-ascii?Q?PKlUBONAOoHhv9kAUPfNotnFumUlW3gq26bthWwnxa5DcupwiaBLGQomd80b?=
 =?us-ascii?Q?+Hcyp4Bb9ZtQQmK9hTRxTbRSL0QM0fsVvuTqId2HX1Kq0gNib9J9k0hEjgbQ?=
 =?us-ascii?Q?Avnkb2K2eSc1Aw5RYj1t80ia/HkEIAajM9S72yP/Q6rD9oQ7HKZZlxwcQN5r?=
 =?us-ascii?Q?U/oBxLpm6X1Jhd52KoYIh2zFxYUnT7diFYdobuFBmcABmboT33YvHPyRnPF0?=
 =?us-ascii?Q?3noEMYcWld4/NFPsMpQX77n6PJw1t6x6cInl3PUnb+KMz3XD0ZxUlj0/UrGP?=
 =?us-ascii?Q?9+RtCeSmR0Ye/8JZzBjGDW1M0LcgzV9aeYps6dpuZLrEmv1f+dxvRX0NCFXp?=
 =?us-ascii?Q?UI45sSNSHubaQHTx4vj31XseB6eKPzxMcAw1vWRgOSIaHNRuTsP2rPSpdp4e?=
 =?us-ascii?Q?r2fr3rSUW2tHLlCL4QiOIpfGBnVvRgD2jCOTfOVuh2eU4lH2N1m0xsqgX2QV?=
 =?us-ascii?Q?UDShiHaGy1o6l20uMFl1rt/fS/F+zQxW4tqlOveu7tN4Uk5uQJyQZQ+QQgSB?=
 =?us-ascii?Q?7vIQYMDZnMtY+WSv3PZUgQovvcJGDNKRmOg0VstZAQoDWe0pc+puQoQ6B6Xo?=
 =?us-ascii?Q?dq79mYhd3U+QXfGbEsWsJH4maDPfw1BeRYscPD/ZqwQG7zy6XSp4asnEtvnP?=
 =?us-ascii?Q?XFw/FVfq9wp/oG3aiDsJR7UxbuOkH4oHOUaAPSMkHxmn70teNBvRcEVkwreb?=
 =?us-ascii?Q?8mmI9GJAn39x9+KDo3hRc017wN1XCBhaFvyeaK2dY7ogpMTYE2n7KeZy8l5B?=
 =?us-ascii?Q?KbqsHFBV9jNsORr62mi0PSzzzPPbdDyF9EMiNss/0rMy87q3zmSQbfRUEo1W?=
 =?us-ascii?Q?7bvmPjX9PMy8oABV9lIwT4Pb39h9NFEH7OUHlIClpAYntDy0UJdqh7KWkRwe?=
 =?us-ascii?Q?SznZDru/4YK5KBvvdkpz2Tw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <480FEF187188A34A8595CDED5B9F19FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: AFlgYFL0hlK4q1UI5hNOqboZARThS8zdHsucUhIPsSAmx3lsfDyA/2fXHEj4aJ/MqQZ6pdC56JK+lFzBK82ZSYOYZ/vnVxgFUu1dPvFQ4iadfcVwLH8sxyw43RCc8pUzPw+JraLbmoayuaTMlgTLza82As699lo6oR6doMPuB76ng7gPr96VzAqb2uO5TgstDkyPpJpfw0AFMtpwJfkJ2+395n6SbNRYnY6stWcBk2oWyCXY9PB/8mIP6j7TD6YbXDpU4RvOTa2ApCud464BOPwhstXkbpuFyCLuu5TafjeQD/S/yHDfucRnoMn4X8/mFlt+If6fnh0y+nYyaX14jpkw+ogHhvUDh25td22/nR2SNmwUlQHw/YYtAXFXQtUxD23GZzbca6fOllIwDNptz6BOSlZG3dSD4PGbp3vRV6y0qFpbBXmTYrzDWuU+xagmksWgXps8v3VkzmyFpSM8+h1CY0uCgbnhhH+MWWmU9SCJ92PkAEpsztbb0uyicHXzso8ibufQAJiexkUR5pFBWJoVzsLCHENai2vJfu+f1XwjYvMy4K8HbqIX8RzdaQP8K3Lj00HXbNy/Lf3tUdgkU3MNB4gK2ncHc3YPW2pGRYl5mVV/AvQi1xV+bP29EcjzXUnZTQVSpCN7436MhPyvGfD49iTmDqswPICmYf+mIRIsIFvifv/wtf6rJZ9ayGyuqE4mnoRqo01jaRzmB8gFP0ntDnWjpj+5XSJnMOgM/VmZbmi4Oqakrx102jLaXuNnDJ1D8ILbFU1s3GPX1AF5PnkgZD2z9zWopNX/VWFf21a237Hh7CZGO0ZU8TNL5hB3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 709ef3d5-f1b2-428b-6c6a-08dbc950ed9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 05:22:42.4085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /MSgGwT6cw8kMXsEcJlTnbYrTeaFhL6A0tbxEeM4R5xMria7tYNq/pVblH13rzJszQhYLPnZLZkegbiipvu1kUwsXXzQ6BhQ0ac/FiK0YOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7222
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Hi all,

I found fstests runs for btrfs on my test systems fail with the kernel v6.6=
-rc5.
Mount commands for btrfs fail with this message:

  mount: /mnt: wrong fs type, bad option, bad superblock on /dev/sdc, missi=
ng codepage or helper program, or other error.
       dmesg(1) may have more information after failed mount system call.

And kernel reported:

  BTRFS error: unrecognized mount option 'context=3D"system_u:object_r:root=
_t:s0"

My test system has Fedora which enables SELinux. Fstests adds SELinux secur=
ity
context of the system to the mount command option list. Mount commands with=
 the
added option fail:

  $ sudo mount -o context=3Dsystem_u:object_r:root_t:s0 /dev/sdX /mnt

With the kernel v6.6-rc4, the mount command succeeded. I bisected between r=
c4
and rc5 then found the trigger commit is 5f521494cc73 ("btrfs: reject unkno=
wn
mount options early"). When I revert the commit from v6.6-rc5, the mount co=
mmand
succeeds.

Since the trigger is in the kernel, I guess a fix is required on the kernel=
 side
rather than fstests or mount command. Actions for fix will be appreciated.=
