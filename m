Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342ED2CD83A
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 14:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730670AbgLCNvy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 08:51:54 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:56260 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbgLCNvy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 08:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607003513; x=1638539513;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/QkJsxBH8aaFxbGn/flPFnuabxnjdKxm0Myng/D/9fU=;
  b=Jk8ilXWumjXfReLpphng66JxT41xL+duwDsEdzbW/zdC4CgdG+fwQ2wm
   Ljs1eW0Jwr+T7jX10acGY4x0nrNuIOglqVxO7uAHkgOReynt3W8u8UAo7
   ebPqzHkyX29pzz2r7uMPRSQLD2uqUFfn5lxgTmsK/Ir9v+z0m0mnv1TM8
   mXCUOtVwq5lIGLamtMDx5YfRa/puaJzRqJobPrDd9tc6yi+8AP/GKSZ7P
   mU6hgp/zZVdE0YDOEjCSJzkLzZ5QjqijudLaHzv7lK5lrgtk6WbiZfM22
   pvc7Iaj+GZaYQeyaB1945PtUJSi38lE1X72/0cmkyg+k/VfK6yMbUSyJ4
   g==;
IronPort-SDR: 3M/fgGCoPUoLJOAvQmFzH/iwfxBrnxsBM2MHP+nGUeY9QLmSdFqsyM9lCsBywcJ7RrkbciMWYN
 25wSFqh41Q8nGrZIyciJ8Xg3cv7V8kp2I3eeor0/5jMBQtUxzfDkTJ6Lthoh+/klT5SEPQxPSQ
 Py6lOKYnblaEaJlhAA6/eOuh+hPCr2e4wR5JYgn/7DZp6GwwDlFy4prnndWSnZo99b1GYlqsS1
 0xJOz2xt8b/vMLhgo1U+lRvL13p0UmHdUYsFP6T/qtRFSGrdA2Ar4EXriLHQPUp+Vq9Xcy+GgH
 +U0=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="264408138"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 21:50:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1IHjDeIxcb76LQS6fXsMqyXPkOHmAoM41WcU8MeBv0rW+a2jCSAshSZ5YBMecJXN/I8BVwLwmQTSktrih7QmZA/HvGSC/0KuDQ2c1Ju05rRc1tlHIu7AvQLqfpHbfg/1uhu13FLAquEBmMXaHQeORp+EC+W+saSuZ/w9jM8RZ5IQBqbmxwCkV2LvQuYVV6h5Ue24CyWxhi6vug+p8Nr0z3hDrEzNUrUfzPbbUUrGarqiNg9cwcmQMp2pYXYxPuBJ40jgJIhGiI73Z2f9YaINBB63hED2wcJ6M5dQl4+6Hk+AFv84+7aDWOUlwloa9qua7iIRpGUB164/G0/JZFpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzmiDPC+9Pcp47k61OkVneee3rPX5d1vzbWupxyqSg0=;
 b=f+A8r/49blHA+Wux2Pn1JjaE1IxcE7zY7p7pKa77lqffBGr1WNxGaiLY4GWPm6szljto/ogTd985shO8IEJEV9dZH11aJHKUv+iy0wGC9k5W/1dSn0I5dMkVXGtwqpNMvHwyVL5BGBdpq3VfIRbH/R/Z6e3zWyvnP50rosTS3xrSRnieI5CY7Pv8PC95Utf7VV47SQDtcRbx4o6n4ETTUU/IIHet/saC1SKXrlCB+YzvctJLviq6oMlUCorOYRJO8Gv16Ag1Rb2O6/QsRl7wCrg+Pe9klwAS36CwpiDlS5i+fc2Gvxd58o4ndIYo27Fx/8KnjFtXhFtrNlmtv1QSRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzmiDPC+9Pcp47k61OkVneee3rPX5d1vzbWupxyqSg0=;
 b=jGGCa63J5iycqWxiS4eFZVDOnBoaUHKllO19+znmPzs1Z2Vvvfwr3Xxl+5Op2zxPyolFTpHezs7jsus/6R4TqKAj6+1sJBY9ELXD4W8RoOX3xB/GrntteCTJoFumOTf0oEsh6XT0sg7rh13j7eopyKE3zYMEIt6yeQnHdsJgtCA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5119.namprd04.prod.outlook.com
 (2603:10b6:805:9f::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 13:50:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Thu, 3 Dec 2020
 13:50:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 12/54] btrfs: return an error from
 btrfs_record_root_in_trans
Thread-Topic: [PATCH v3 12/54] btrfs: return an error from
 btrfs_record_root_in_trans
Thread-Index: AQHWyOT37bHhKZ1LfUeLdznOhChbiA==
Date:   Thu, 3 Dec 2020 13:50:46 +0000
Message-ID: <SN4PR0401MB3598215B90ABAF54B91B0D2A9BF20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
 <a11d1c323a74b1c452da3e4544019754b95bfaf4.1606938211.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:ddc9:a3a2:6218:d6d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 34fdf92b-44c3-49ff-1745-08d897926f7a
x-ms-traffictypediagnostic: SN6PR04MB5119:
x-microsoft-antispam-prvs: <SN6PR04MB5119A03CCAACBD24987A19509BF20@SN6PR04MB5119.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eJfdwVhsqhoR9eCb+LFFBomqcl/teF+t/hsPuRRL11AQx4P9bwU3vqb7+BIWnW62P2uu8R1VkYy1CclkmmYllkFZni7SqGIxbdmPJ5ZcFxchA280m5RhzldBpIuf2dVqflP7WB+VlGmNpGpUzNLPjDMRYXc2Wx+3KOB0pg2GP6rOS1hBHvRTkoSOTt19fluIzCD0mjpTDmy+mGLJA/4P5TF9l0pMUzV/RQJMUup2oqu8lD1b7gLPkUG2hUVuXZmGPwXTPQ7IzFvFY8MsfpKOJdr3br7R4AohjyOIvhxt2DKunylAXwM3YKEYzOr4PPbDLtMet9tvx3sxglKeuwIa9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(55016002)(76116006)(110136005)(9686003)(53546011)(71200400001)(86362001)(52536014)(66446008)(91956017)(66556008)(33656002)(5660300002)(66476007)(478600001)(66946007)(64756008)(316002)(558084003)(6506007)(186003)(8936002)(2906002)(7696005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eVPC0c8vBAqTIV8NF87fA/MS9eE31qxXNtwFDB5YyMfBg6iIujhqR6ScpSan?=
 =?us-ascii?Q?61Ao5ovNTVAS69nIBRWKi+jSGnjQwbkzHLohgZSyNoQ7/HgQVbEnIxFqdIOb?=
 =?us-ascii?Q?KzOc6N22UOgy5SHW/wYazviK+MbWfMwDZPVz1lD7kOE44Aj85JuTmLtGyH02?=
 =?us-ascii?Q?X9A0OI3ZpXHjY99L8r/K8dYXvSbiwr8yoX5JOmkcN64qo8TllFrL4r7tI3tB?=
 =?us-ascii?Q?EHlAlkaEzWgIb0Rq0p3II6Jsc70VmZt5XDQDy1izMUX0eghUGtqwenaZmBfc?=
 =?us-ascii?Q?X5F3hSGvkGIj3gMikmfHtcOTBo9kxD0RjmyIkgA/O+cfWLozShYxKac0KKJP?=
 =?us-ascii?Q?tD8bJDe30w1EZ8GOgpB8XXzjIB+WfW//p3y2FNct3/ax9jGml8v3H84JlvAr?=
 =?us-ascii?Q?CugD4+X40afX2GO+gedoH7b78lmaxfix2558wYhBOMbiDpNjhJaUc3+iWtkn?=
 =?us-ascii?Q?BGEv0V0IAU37XOArFdkermXICS9fo/H7Gcj8HN7krUhxv6BPT+aH09Y1ZeF0?=
 =?us-ascii?Q?gBXPB50A82z9FmX4kkJAc+Z0Yw5WwZdLJc0uwhZS3cdyBxAJ2XskGXj8RonG?=
 =?us-ascii?Q?Hb0JQgn8/6WuD2xisqTPnZ9K9uFmgGE9OhrXq5zjRhxa4W9stSRV14Yfy+1v?=
 =?us-ascii?Q?9LMFjccZCwAu05+QpT9SPhfHpGLQ/shxCsR4un0kls6IeXYwrlU9UciphboK?=
 =?us-ascii?Q?VRtdImQda6AqIXdFratP8RQc4VL4vkUXwlR3XUGzsVZYUUngXdhfJ+iagS2L?=
 =?us-ascii?Q?lV/fzHkaO53nBbOL6D3zUVIVEp63i9syN3o07JAPjzNq2/h2IkTsnM1EncR7?=
 =?us-ascii?Q?aGutX/Wju48HaX7UEiJJXUT7Werw8fHTLRM+peYN7hDB+5EzBgOuESpf8/7j?=
 =?us-ascii?Q?pXed+qtxsNEBCYxpTHYVQOg2Cx/5xzUeoGsJkqAV6zv7aNE8B8utOEpsUx79?=
 =?us-ascii?Q?xTsF4+tldSFDbqcj8GTuQWPxIVsaTuRQkfOpuyzlmjCXez90DwcUFURm2s2e?=
 =?us-ascii?Q?1rpPqvqlBrFmAiOfE4I9MHHQQOBmrB1JUQChmH2eTBJNtFpBGZ97HsiDV5kZ?=
 =?us-ascii?Q?VSXV+tim?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34fdf92b-44c3-49ff-1745-08d897926f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 13:50:46.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZwS1z3A8VpBxU6pbBa76pNZ/haQIL+fpSStBB5GcvLLmVp+pPtf2XxIZQm57nFOKswdc5Hf2Ha8OoObhUNkXaieQyBgY7HCf79raCt3+2wg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5119
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 02/12/2020 20:54, Josef Bacik wrote:=0A=
=0A=
Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
In a separate future patch we might also want to reverse this if =0A=
statement, so we save a level of indent.=0A=
=0A=
>  	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&=0A=
>  	    root->last_trans < trans->transid) || force) {=0A=
=0A=
