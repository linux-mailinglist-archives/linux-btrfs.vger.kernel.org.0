Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE094BEF1E
	for <lists+linux-btrfs@lfdr.de>; Tue, 22 Feb 2022 02:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiBVBvl (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 21 Feb 2022 20:51:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiBVBvk (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 21 Feb 2022 20:51:40 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D95325586;
        Mon, 21 Feb 2022 17:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645494675; x=1677030675;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yUBLJOTNzJlU+VqCTi2YIDcIfWcMZlI+pZLnp+OdAR4=;
  b=nXQz7NrnEznYSfgUsiQRN8YLdVkXkCT9ZuaxeKa1J9VY2ueB0kTqbT0n
   MuL62Q1SuoheJdichSLB1ENOHu4jHP+82Jn9jyG8tCSKTZA3Vd99bK1FG
   msAmicIUaVix5gRHhUQmMgzz67sPq1yWQ0HtqFUBewwFSaftwpiobvYuL
   J8+ULU2mddXsH+S2B/a3IY0hT372TyIHDzydnc0kGFBE2zKPCCD0B9Zsh
   j4QgBGcO0QISdLB6EGozCqfWpDUrBuke37siqgI0BxhV7tR0wsyUMrr5u
   4dvbnyx0ZXWGq6+ZckbW7wbaEjQO/lI0wwc3MJrCZlOVMLE39BYZthm/G
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="235132273"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="235132273"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 17:51:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="532028606"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga007.jf.intel.com with ESMTP; 21 Feb 2022 17:51:14 -0800
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 21 Feb 2022 17:51:13 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 21 Feb 2022 17:51:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 21 Feb 2022 17:51:13 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 21 Feb 2022 17:51:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i+D6NtuoDAiWRR9aZigf0ZEvwvOmiwGbQfHak6n3wNj/ygibbKu1ypXq2LXz2p80sGAjuPycpGq0TRLelNJXIHEnpM8XaxaaONPRezcCD3GQKgQWOtEWBz+nQS78X6rUd/rVUJWkVPiOpJtLN4fIcgHkr2iupWgRT93fWBBAqS9/GaKjJ6Q9mM4IasoujC0+ZFRE5RXtAsYJ2GzLXcC95+xnN9bU2GXxVn0ALssrx4skjio3N5WqCqR+MbMyrqm4RAint6CIIlq4tpwbw5u7tS6mb5i9qOMANxWQh9z/ALiUZYBnmMvhh0wU7d550yE9FZGOn/7SwrqPNUpF3Y0Mxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFFuONUdev3r3RAklQqcFD3mJbS4PO4g+O2PSbBjtDI=;
 b=M7Lzq2JBkrXq7/l3qPzgdV1atfI9xt8AgtQ4XQihcfuwv+jvILWMSXM5ekdtRdzKt74eGNDOUXWAsVb2+Yf9phyRxqC+yWIPfTOcuEfVKWYgW1KvcJ/axb5jqlGX1QtnMfHhw4VgHQo3cKtq4OhvRVgp3j6p4V608ScZrfKYFSCVSjqX80Q9nrzCIc8Ot8OkfLr5pSGEfYCiD49RkuaXJmGS9zCNUQA1OKZDy3D3VfSAmmTtsngzmFaGPPui5Zp8e69v8koZ9cfIMlZd5lsCKDSrScP7TuqYUHWpT3t5gGavYY6fxPNWmEEYwx0OaS22pYVZVrRwaWz0G8+ptGfzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CY4PR1101MB2264.namprd11.prod.outlook.com (2603:10b6:910:24::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Tue, 22 Feb
 2022 01:51:12 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 01:51:12 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        syzbot <syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com>
CC:     "Mason, Chris" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] WARNING in kthread_bind_mask
Thread-Topic: [syzbot] WARNING in kthread_bind_mask
Thread-Index: AQHYJoehTUhlgvCkqEmrg5tJq/UDJqyeEEQAgAC8pWA=
Date:   Tue, 22 Feb 2022 01:51:11 +0000
Message-ID: <PH0PR11MB5880628B1A335AC389D980ACDA3B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <0000000000005ca92705d877448c@google.com>
 <20220221142358.GE12643@twin.jikos.cz>
In-Reply-To: <20220221142358.GE12643@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 639aa88a-1115-4b75-ecc4-08d9f5a5cdc8
x-ms-traffictypediagnostic: CY4PR1101MB2264:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR1101MB22642BAC7225AA3B1C5114A8DA3B9@CY4PR1101MB2264.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TBvT7TuW4ZDGpN+0WbpD6tv2WQ/GV7obebUtA6Vh7dyYpDwxUrTGpPcMgLy6HISg3R8Y6RSh/cGFT9Nv6PHNzFgJjUSukgHEEheoiKYC4BdvSu3WnSfKAMlm0pUGwEtAimTf9mDw5JlBuD1JmB+BSXfC6MpRWlNdEfWmzBdEHsdKu9i3tIQiaXaCyfW548DOop+FYGNgWNAntXNctTpSOA4ggcYCNvbqXVv7uEUmOxsCUIW2sM9r/6O+TnB6lV+/5Toqu5MS2n0tydPgiMueDBaf3zqeBD3ped32nHYG1Nvje3PYFkUjZZpokt+/9qcMjdMNPMtlstNCHf06b/qd+Ax2J78lor8lyWr8IIIf+s7qGFOuZmf4WieCTI7AqvlbmeW0qXn0hJBcREDWoZSc60No6VrB6MTnrPutEMbonzbKs6WBsaZ410f+ZVCzOeCsxPjNgS8dpsylgmvDByIUYHvax9G/WlLO7uoVrf6jELaveP7pABQURH9UHsjcHYqbfr43Nq1ZLf2T+ndWbzUdqCZZaQd/bPbzOZafH/udqoFYSF67OLhGmUX5TeiRshQWkFvwzjmUWLMh1F7bm1yDA79lCLWIYiLEW/bx1xY+GeZnJecWo5DgNeGeemYMQRluoaud3NSpCk7kugWRj/dw/EWWDMWx9uE3ozjoY04FQB2vlZASviLwVvcvXlQ9R88F+ZaNCjtwVlyV2pAmyrgaBQa6psBoQnjz8SOcqNdWLbSYBF9vB4v762RSulc4CzsD1yeEXi/XUBg9uPHEqome9bf8Jpf+mVAAn87bxy9E40CYFFnXlcjms9htuOsNRVFK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(4326008)(76116006)(66446008)(26005)(66476007)(64756008)(66556008)(66946007)(8676002)(508600001)(186003)(966005)(122000001)(9686003)(33656002)(71200400001)(38100700002)(86362001)(82960400001)(316002)(7696005)(54906003)(110136005)(52536014)(6506007)(83380400001)(2906002)(8936002)(55016003)(5660300002)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hupwrfck06JgiO8lhvDEPjR+LpFLpImIio2HEI25HjTP515gvmF13zmHK6h5?=
 =?us-ascii?Q?iTbne6ZF3MPIrZ5TNcNUZfLyHxWEArJXI0dNxybxH1gDL29ZyZmmq4cBB6U/?=
 =?us-ascii?Q?14iXM6qQ31Zv4skb5EngNE9dCawjXC995IDtJ3nADFTWJfoQQ0tX7RXn2qx0?=
 =?us-ascii?Q?kkKT9LF3M90QSWo4Ke0mruVRltTiSPpG5y7ctrxOblJpcE30jsmTZ9647fnt?=
 =?us-ascii?Q?a5kmUP6INi+ku8FFyyj3GKOMl9qApZcoOM29+BGnxafDv9u+24e9KRSX1dbj?=
 =?us-ascii?Q?/ced7JDZVOMw5wwEtpwLESrLN4ipqP/UDBcN+0XK4XC2tDQW4D08agcxGSGU?=
 =?us-ascii?Q?SQBUOZvtw0JF/mQ6BIuHckITDitit/EAUP05XkPpOaJEsRjGnwg3YC8iAUSc?=
 =?us-ascii?Q?Ap7Fhb27XkigrclTPTvXkQzRajiNLsFz1XkOFpqi3sZesBGTdGp0JVGpNliI?=
 =?us-ascii?Q?UeTh62ybtXS5om+7g1Ne7IcmBliWRSxoCVPf/Fmt/UJmhHhzChvTw96f+4o5?=
 =?us-ascii?Q?QaeK0xTUYKGEHTFWeX2QDgictz4IEThQo6pfWoX7X2jqJN0noSavautJ9mdp?=
 =?us-ascii?Q?Ct7ZKU/kZasz02q8dTGOgBLS4SymSxJ0vF+7dbZCBTrNib/1DVoXfXZZ8DI/?=
 =?us-ascii?Q?2c3O43kLufN33nUU7Le/aseMCE6BqJUhuxbhkm1PplHxsvrL9l+8+d0Gir1P?=
 =?us-ascii?Q?mcrK7LOGvH8cgxVdKk3RbDQgW79VCJpxYWJYgRtaT+3MSD7kOKuwVE5vCcYO?=
 =?us-ascii?Q?XuwDsYO27xnSq/4jQqLkWfNwAZDmh7/d1fmxkDAyKJYKHDz3GJ+ywZmNXx4U?=
 =?us-ascii?Q?XHS4es73nTUXcKs3Gan5yXK1y0Jc/PZgqmYFZZ/BN4O28ITAGPEcFrzdJEpr?=
 =?us-ascii?Q?HPP9i9l/BT2FLpUYx71rN824dpbAJbKHwJVKB7VFUz3DpF2/XHKGWFVzbURM?=
 =?us-ascii?Q?osu/4xhwdTBQJYD0rEpJHiWZfDWfO9KStcf3mYfOYDWYyQvaKwgRIg4HF9O1?=
 =?us-ascii?Q?ZAuNyzx7FaLPcrdAuqNW2rXzj8iWmJPnVgi+9rv1JKtLKvDCm0HkTCeLGukt?=
 =?us-ascii?Q?Cgl4E3ic4HWgHHBvQeblSHz4n5FVwfOqxyy6xGPIdDMq1L5uLw0qo7SMS4y9?=
 =?us-ascii?Q?hX+8IF8e3OmRqQW26utpgIl0MfHb/7iysE4FAW5AFt02Zy9x24IbEnuCcw88?=
 =?us-ascii?Q?wP7KuIk4UwbRNBgOtcqKJ0qXV9mb7/gBfTPyUA6RpJPv1odG8iLySoqrl4ww?=
 =?us-ascii?Q?AJjpcjgszSnPm0tkJSEh/Khd5pmM091phYgGHL/LbhiuTP7m/jCchM4j/H1x?=
 =?us-ascii?Q?qzzZLhj1Nre/lkuqMldI9p7R2eOn7egQcTau/oVB1I1PKkhkDfwUc0HLyA3h?=
 =?us-ascii?Q?L7CvFmtzTy1yAB3UyGVr2LwMENnqb1JtTOPkVzaIpsYrHFQQ9hEn+H78gVZq?=
 =?us-ascii?Q?z79Z1px+dqZVbf4R+kFaevKoge/emCJOHhiKR5JKu4E4+RWCd8xQLjqV6hYP?=
 =?us-ascii?Q?mmOxLgNiDgLqwIeYtDPSEbFxM3O5Ze265KyG+ops1g1SpxAJ8qR5g0huZdjO?=
 =?us-ascii?Q?TKxYTWKbrguTrB6/jtzhsdfqlrldQDR3QlzdqJ76MAC9ahS1U8DtbLlZUEQD?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639aa88a-1115-4b75-ecc4-08d9f5a5cdc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 01:51:12.0073
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p/ddnl+mHOP2pdrpBGEnVdN6wYaQGuFIRDiRCy/a5ZwbImA7mPc1fv2rCcKthswBCToeBrIQldm3wRbPztM9yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2264
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org


On Sun, Feb 20, 2022 at 10:27:23AM -0800, syzbot wrote:
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    c5d9ae265b10 Merge tag 'for-linus' of git://git.kernel.or=
g..
> git tree:       upstream
> console output:=20
> https://syzkaller.appspot.com/x/log.txt?x=3D11daf74a700000
> kernel config: =20
> https://syzkaller.appspot.com/x/.config?x=3Dda674567f7b6043d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D087b7effddeec06=
97c66
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binuti=
ls for Debian) 2.35.2
>=20
> Unfortunately, I don't have any reproducer for this issue yet.
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+087b7effddeec0697c66@syzkaller.appspotmail.com
>=20
> BTRFS info (device loop3): disk space caching is enabled BTRFS info=20
> (device loop3): has skinny extents ------------[ cut here=20
> ]------------
> WARNING: CPU: 0 PID: 10327 at kernel/kthread.c:525 __kthread_bind_mask=20
> kernel/kthread.c:525 [inline]
>
> 520 static void __kthread_bind_mask(struct task_struct *p, const struct c=
pumask *mask, unsigned int state)
> 521 {
> 522         unsigned long flags;
> 523
> 524         if (!wait_task_inactive(p, state)) {
> 525                 WARN_ON(1);
> 526                 return;
> 527         }
>

Maybe we can add some additional debugging information  to view the status =
of the process.

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 38c6dd822da8..e707e86ee64b 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -29,7 +29,7 @@
 #include <linux/numa.h>
 #include <linux/sched/isolation.h>
 #include <trace/events/sched.h>
-
+#include <linux/sched/debug.h>

 static DEFINE_SPINLOCK(kthread_create_lock);
 static LIST_HEAD(kthread_create_list);
@@ -521,8 +521,8 @@ static void __kthread_bind_mask(struct task_struct *p, =
const struct cpumask *mas
 {
        unsigned long flags;

-       if (!wait_task_inactive(p, state)) {
-               WARN_ON(1);
+       if (WARN_ON(!wait_task_inactive(p, state))) {
+               sched_show_task(p);
                return;
        }

Thanks,
Zqiang

>That seems to be some internal task state inconsistency.
