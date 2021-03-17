Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE55B33F398
	for <lists+linux-btrfs@lfdr.de>; Wed, 17 Mar 2021 15:44:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhCQOoK (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 17 Mar 2021 10:44:10 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:64219 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbhCQOny (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 17 Mar 2021 10:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615992234; x=1647528234;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6ED8miA9d8gEN9gUkVnq3kzLHA33PWTETqk9XHz3NmQ=;
  b=qICWuLPZPZeCF0f7IiUY2YlmZqnOBtdMGdcO5zbOCbS6JMU/4p/zB/j/
   nAiy3dbww5e7VX3d0QM5QGQb7Gm+RDC5MXYSNRk7q0s/E2ffA8Prs1YDO
   Mawge/VdrTMDcGP7RHMJoOr2Shk9bH40w7p+H9S1iqUnvM3WTMN/Q0mI8
   TSKNQIdXM0WuenDlESPVM9hAqfOfOSSORWsbJ71r9oElpAoAnqZ8f6T6X
   0jAGueajg2vZKzoT1WGyl+Ox6/aWpYsAcb4YEwBwOUCCM8HHiP60OAlZM
   iCgSHMudlPh4ZSKqW36euY+VncIIxqnDDVUZMd0LblfHw04pchHBkCR+K
   Q==;
IronPort-SDR: AdIKC+wCFkcZ9TH5mw49s831hGEBtLT3XchKwhMno9zWGvbj2m20C+Ml+urpnj8zyKY1htRCgS
 GxvQN3Ktj6EujnulkzDBSJ5gJn5vY33WR2xIG8YoFV5xRXHio32AdZDbywU1fm6wO4fFGRo9wF
 vVIalFk4gBN29/5t1l+yF9HCCLDblff+m3spIisK1LQd/sTZcCiS+2iFcef5lHMBADxFAQUDpP
 cyEMvakR5zQBu8pFibtbuyv1HI2aX3GdLyt/ao49/e+U4LLRjHJgi2lRdV7q6bzQ5o8KpJPgc5
 HEY=
X-IronPort-AV: E=Sophos;i="5.81,256,1610380800"; 
   d="scan'208";a="162376614"
Received: from mail-dm6nam08lp2040.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.40])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2021 22:43:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lhZ0Mbug0x10PvoOh9ZHF2tLYyhbBC237edlt5F40HEGiRZZ7xXAo27e9ao23hGNLadDgYDBr3DyuPdkHcmlDJC36CKlZ4dg5aHoa3iWl6jZ+ylOK/Gozm90YBYdoJoeplInNEq7Ic4NlM+SCJ4GeeDhIAmui9MMJQyVh8iwW1xa92k+QgGkE96Ztr+gHxOQ4X0jlcgn6mKF6szhsMRWgq9VbN6RM63jVawk5cxeEExhHoeJr5vFrKunh96G07ZmQEaBcIAle0KLp/y2nfq9GMKNYjnzKTH8XyxxONGXVxhDHzcC8lMMV7TW5W/SyMvdnVs1psKbTMbASRPftjiVOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ED8miA9d8gEN9gUkVnq3kzLHA33PWTETqk9XHz3NmQ=;
 b=OFp9IA2s1G7bW7TCOO43WDuZHZC4Ck/8vkGs/x/Cz+rC27DrDJDaae97NlxMSSEZVv9IyYx1nky/Ldf0o5Pkuzwu1XAZ5LTliSQ+iN+vXLfVCT+kd0nMIhyilWRxZ9WpRNC+NiSluWGxzWW739/elBZOUauYSVKyN2MYDlGd1pXWoT4s018CgAX1wt5a6SQskHnej4pAi4XMtcTKy1Y0ju4CcDnHRuU+xWNyEtzDsl1j8GJHxrl4cT0GhxvM24opWkVenyg6RjgIWXaqEXlFfSOBoyzRLO+rkZp2maqwtqbuzZusIS3u86s3JXDU98IbEFIt2tvv4HGPPjgpOwocaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ED8miA9d8gEN9gUkVnq3kzLHA33PWTETqk9XHz3NmQ=;
 b=lGGVSP5+Kb0xic3WenvmRC2LzYiLRrXUuiLa+0lD3MKHHZ6s+C0OZJ+AAk7vdtkGawlvZzLnfJJYr59axjZlxx2eL6bTB0C0+U59FqoYFS2i285FH3SwEmnerjkJXcjRu3xd6v4IPoLkivG2mPZK31DMMP2x0uLZqSt3kT3H5aw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (20.181.248.145) by
 PH0PR04MB7205.namprd04.prod.outlook.com (20.181.248.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.32; Wed, 17 Mar 2021 14:43:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.018; Wed, 17 Mar 2021
 14:43:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>
CC:     David Sterba <dsterba@suse.com>,
        "linux-btrfs @ vger . kernel . org" <linux-btrfs@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] btrfs: zoned: automatically reclaim zones
Thread-Topic: [PATCH] btrfs: zoned: automatically reclaim zones
Thread-Index: AQHXGxmmktl56lD0m0W5npGqcGwiOQ==
Date:   Wed, 17 Mar 2021 14:43:51 +0000
Message-ID: <PH0PR04MB7416828DC40BFEF7EF7D3A549B6A9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <321e2ff322469047563dfce030814d58a8632a60.1615977471.git.johannes.thumshirn@wdc.com>
 <20210317143144.GT7604@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:e193:b3c8:606b:24d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 506a0816-b0a3-43c3-aaed-08d8e95314e4
x-ms-traffictypediagnostic: PH0PR04MB7205:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7205E0CCA4D6FF6DBABDCA919B6A9@PH0PR04MB7205.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lv+EcL4LU1nb9EWK8qY+z6Z3WBwJRXG/Bb5VsevUYheuK71FI/1DE1D2/SA6ZZQgc/jznFcYPqu64h4eLABQSzA+8qOadSFI9x8Mw+djB0cBhTKXDL5yiNtmBPyyqN2WDsIHAXmOmEjviRpYV0cBwIOhE1GIP72X53c1Y/4oHZB5l+Ik9ZufZdWi3ML1K71mkRZEfYXZpKXDSH86rqdmoffwLC9szTkcbn2labd4VNwAACIqgAAWvQKU8klOAlHSDKFCmSYuOY6V5cOgF/mADzuUQeqJmWPv6qlbWa+G7lOtXgPk1ZNLqcMSG3/Xek4gneLAJxKGc1lDoHSaDeONbs+g30fZLBGh8/O/EKeCAYKcG68Fv+CEkXDw2uNuVk4QRAMUpkFV7rsWfBmCYsZSTEC94Md63FbqUnbBdcpkmHkEFpaWQbkPHv1zXacUffPB6Vl+1d3G/as9CdK144FZtyyRs0qGHWmIDUBKKaA/ue0b4l0HNzsCoJUhWbmWIkWt3M5c+hYujwl3O+tNXrWMtWaE8OpAjygYN3370fyd+hwvCBrBuSMbLNI02YbrMOga
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(55016002)(2906002)(66556008)(9686003)(4326008)(186003)(71200400001)(53546011)(316002)(54906003)(8936002)(66946007)(478600001)(52536014)(76116006)(6916009)(5660300002)(8676002)(86362001)(7696005)(64756008)(83380400001)(33656002)(66446008)(66476007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?KoWZSXmMPRzp4YUR5f1tQVGx3zwUZzqV2lEuR28XbZpkobkRnKJMXi2zPVRu?=
 =?us-ascii?Q?7/F2v1mMeV5c6AxIIOyy5AZFKjkEJRBqG1m+RE6mvpW1OKz0HdVtJIH/5x2G?=
 =?us-ascii?Q?vOlwU5gAiNV6PdQw1mYxUrJJYu2JfZczSu16DKIHwpG06AoZ6gfveRlyL0RN?=
 =?us-ascii?Q?0mOlPc03iQHItwB0ppttjDPvzMf+f27R9tg+VjfbqXCso7qGCvyojmMn5fXr?=
 =?us-ascii?Q?3wqnq6QbCAmE/PRUbi5CXEIBZ1A4GfjES1dNI3tKu8sDo8TjwehVpDwziadp?=
 =?us-ascii?Q?Jg/dAARpd3ypgkadvPXcQBBZAOl5WGnbjrnyWxOhJtDdVuBvrXRZk7yz2SeP?=
 =?us-ascii?Q?tUu8O17Z8npNZqBPxUrwjeEQHmK0GYzs5SMpikyJn5N4b0Ar9ya4CUQmdBdZ?=
 =?us-ascii?Q?1g1HmjxddNY1sQnXAZHRF9NOx9Uj0mRi6QdZkB+pvSmkgVXGlocGj+79h43K?=
 =?us-ascii?Q?pnnrWVuWhc0CcXJZE8FRH0POQNypP9C9vyh+YIC2Cafy6J6XWSHIg2I0SFtm?=
 =?us-ascii?Q?Abn+28xdVoIIVTWApVLVKlthAXdJEzWekWaLndaaO+z16udzM+P6LC6PDY8m?=
 =?us-ascii?Q?+IYqJBoLnOi1jfKTMidlZEdKONgYPO6UwWkyuwOfHmE0YAGwbJbe0JnF/4+Q?=
 =?us-ascii?Q?G4khA6Lu5vDeQuE98nqRAj3nF5/ImMuix0hKa1Z3ceBNYYWdj0RBJPI7Mzeu?=
 =?us-ascii?Q?i9mIjVAMd5GDNc6stL0qSsXxSU/53z0MespRVJ3woCFJBZ5NHi2Wcz9pEBm2?=
 =?us-ascii?Q?3Ap7ej0OMH1V82Ma7bWXm4rwe1FfZfSAzk1Loe5hA02uH/5c1hQAJlW5aO4B?=
 =?us-ascii?Q?qRst6ybQBElcNIkWK0ReABFVVJaQm90v+7gIxgTqyN4YE1IT/Yn8mXTf1t8e?=
 =?us-ascii?Q?2lPDlbwGvqyzu7zLUPu5KINw+YwYSttZW4xso5B8ZxF/9DBaYq8Z6YlpKEI3?=
 =?us-ascii?Q?+PJt9+nWR0jef334tNVt1kO51FWh28Gu6ptrbaSP0yxbEIssDWEiuKnaGlv5?=
 =?us-ascii?Q?7olh02lA2Sghei9An5mdq8cAM5NR7J7Ic5v6mkahoTbHHNm6cheDNVPhXwpB?=
 =?us-ascii?Q?wKy+VZ4YPLQRiY3eAoO/JZ1xjJ/cba13wIgcDE9Llj/4MAlrdXE5EejPr973?=
 =?us-ascii?Q?mYxk16tJ3D/6hYueqogD6p9hBuHz3+rEW7z0NnTytTS3XJemNmRVvme1cPfR?=
 =?us-ascii?Q?eQbwV4qoCwo3AvGDmFPxTRu7DaeSEV62hwCTSwI0McleIef6y4FB8qoSGX03?=
 =?us-ascii?Q?IFGix5WnU0hw5W/zUb4Y42RVMw8CDPBMWJDz3ocQnSMjno3N7qtEE2lsDslg?=
 =?us-ascii?Q?bn4edLS9s6MaR5imjNWWRwZHyQkSYt34wiCc7HkXXXEy53E4cfveovj3w29a?=
 =?us-ascii?Q?EvR+2apVrnAizg8dkx5XJblW+xOUm7qpnAR/lL4yTH7+Khaexw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506a0816-b0a3-43c3-aaed-08d8e95314e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2021 14:43:51.3041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ycEZuhR6pATDxVf+e2vK+e+LJJyp9a+RGLvRexP88RKkHD5GqgmM5YJ1VWybBqCOS7LuCNBI9TG1T+heuJ1j2FchDK6xeDIgWSOO3qC37c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7205
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 17/03/2021 15:33, David Sterba wrote:=0A=
> On Wed, Mar 17, 2021 at 07:38:11PM +0900, Johannes Thumshirn wrote:=0A=
>> When a file gets deleted on a zoned file system, the space freed is no=
=0A=
>> returned back into the block group's free space, but is migrated to=0A=
>> zone_unusable.=0A=
>>=0A=
>> As this zone_unusable space is behind the current write pointer it is no=
t=0A=
>> possible to use it for new allocations. In the current implementation a=
=0A=
>> zone is reset once all of the block group's space is accounted as zone=
=0A=
>> unusable.=0A=
>>=0A=
>> This behaviour can lead to premature ENOSPC errors on a busy file system=
.=0A=
>>=0A=
>> Instead of only reclaiming the zone once it is completely unusable,=0A=
>> kick off a reclaim job once the amount of unusable bytes exceeds a user=
=0A=
>> configurable threshold between 51% and 100%.=0A=
>>=0A=
>> Similar to reclaiming unused block groups, these dirty block groups are=
=0A=
>> added to a to_reclaim list and then on a transaction commit, the reclaim=
=0A=
>> process is triggered but after we deleted unused block groups, which wil=
l=0A=
>> free space for the relocation process.=0A=
>>=0A=
>> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> =0A=
> I'll add it as topic branch to for-next but I haven't reviewed it and=0A=
> first thing I see missing is lack of mentioning the sysfs tunable in the=
=0A=
> changelog.=0A=
> =0A=
=0A=
Thanks, will add the sysfs tunable (and fixed the type in line 1 of the =0A=
commit msg as well).=0A=
=0A=
Can we also kick off a discussion whether this is generally useful for btrf=
s=0A=
and not just a zoned FS? While we're not having a low hanging fruit like =
=0A=
zone_unusable as indicator when to balance, I think we can work against =0A=
fragmentation this way.=0A=
