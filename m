Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF712CD1F2
	for <lists+linux-btrfs@lfdr.de>; Thu,  3 Dec 2020 10:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388330AbgLCI7S (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 3 Dec 2020 03:59:18 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:6896 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728037AbgLCI7P (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 3 Dec 2020 03:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606985954; x=1638521954;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=D085+TUhJoRj7VBsQ6O3CkWFI5O+5N+YEaIh1odxewCYb1lEsKJUh+tl
   iIec6zOTYCgHIgUAN3dlwM+dSWT63xvxr88rOmmqO2LiJFvLyjOSkgRYZ
   QllrRUEXS/kwkkNu7+hfkXoyib+xGT8PDWp32Cyf8xtAUCmiDKRx7KrVa
   gdLc1PWjuH3lHBD25Nb/OdKSMugw4Blz45BIW7JV6x03MhBOllUfG3Dit
   bq7z8pvJN1VaGpn64yyZ+bpgfpaTgsnZiRJLiJrBjr55JvzIXQ7H60TlZ
   aWpPNiNeVPc/CW8ntGoATq1tbUFpoAaBDhKAxywiWlxsS0pQ11XTkLxC7
   Q==;
IronPort-SDR: KlTLVQIIoP5OuKiocUgsLd5hZ2iG0qdGga+foO6uIT01uag6B+g66wW4wLEDlienKwdq9DPy+s
 Jl+yqU69jYXdUkTRfbEqdX5+hcc4VPgI11bbPCV+BscFfTDt5BL8974ejfRDt5d3fDOM0eyaig
 kjFz9GPPr0NXQtJfVvn7DO1Rc9xixSTF8kWzCnAQGCpAIMTNoGVbmwZZ5Aong3PzLFVI3JnFe+
 dux7hMfENoiLmBOAoX0emF+EuDkYzl50ddVVzg37RsrYvJnzwlUOGYar7/h6n8DbVoi6ZiSOkY
 ea4=
X-IronPort-AV: E=Sophos;i="5.78,389,1599494400"; 
   d="scan'208";a="158712164"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2020 16:58:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPYvSRWCJODKanVAAZjNHtR+IeJ9b4Ohm5b9bZNJFqE3paRBt+KSAgZ/vdQ7jj98pv4pz08ftgmjO6aUaOz3RiZfflW/oPNwkcY1+E8Z8NTE2h0UkAyhCahX6Fa1Kio7FoWXeCocTkt7u3vCDVk/PF4jQ0SAiGtvYmzehVjthFrmmi9P/pTCSYBH9ghmtbXrvRbHzxrucZZwzxWVRrZ235Ekmn8RVOK2WSaxeFxAfLQs2zgpTSOxgBfnQNNj06ZRM7RmBp/sPli22zfMoYKDshju+9jYRJ7a19fdLAXl6hYG/2E42D6bfCjDazT4ebGyTxl8+8XJ0DA5dgUDkqxylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=T5VwORi/0X4UdZ7oLrZqFo0EyNnFGTI+ydhqvVG7rOA0l4vsxPx87ApZYgMP2qYfcf++gJLTTRBpF0ym5i17cpRCds/5iOxEJynq8pvETbjYovnbpmGk/Nk7h/LnwVZCL3wvtcBohlLmx2F5vn+Fx0ShF/5b0VrL8mEK6SpmLJHXc/x+ae+H7bnKl5PRhp652YUe/BQ72cUSIGA+t9KLSozlTJQI0ahOzSnZOBGAz/5QXL2C72lSwGkuVM8r8DYgKSrXrz9m0+bD79xd7uFnn8lDNjAsQ9WOoYhw4qMlWjFh2ytpqwa9t4V0KBPI237FslhG+7Wll0yYjPJv5fGH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=MM+px/DIsoMRHGclsougfZRxUFMHvFEHv2n1YsiB3rJLRrGbzABofbroyAEqjPOA8wA9Sf3+RxgdSappPrQgpgWqYdz7dykBZHzVWrmHTeafZ/QMQkYB76P6reHHHMDfHJQKDHRI4diN2VX+369RfVP1vUWb3BUQh9zEO5mGib4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4925.namprd04.prod.outlook.com
 (2603:10b6:805:91::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Thu, 3 Dec
 2020 08:58:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%7]) with mapi id 15.20.3589.030; Thu, 3 Dec 2020
 08:58:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 09/54] btrfs: don't clear ret in
 btrfs_start_dirty_block_groups
Thread-Topic: [PATCH v3 09/54] btrfs: don't clear ret in
 btrfs_start_dirty_block_groups
Thread-Index: AQHWyOT2LKHRQQlT/UybDZi+pA8AAg==
Date:   Thu, 3 Dec 2020 08:58:07 +0000
Message-ID: <SN4PR0401MB359834B4A60B23D9A366061F9BF20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1606938211.git.josef@toxicpanda.com>
 <89d8fc9f58723113f0f6685d67480541044839d3.1606938211.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:155d:1001:ddc9:a3a2:6218:d6d7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 20d864a8-5d18-4f7f-327a-08d897698de4
x-ms-traffictypediagnostic: SN6PR04MB4925:
x-microsoft-antispam-prvs: <SN6PR04MB49253AF65F60FA35EA0A713E9BF20@SN6PR04MB4925.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pOdPvoeszp/+QHKhTJ5C8ENkVOAKV7Tmi4QAraSVwo9i0SmbJn12kGciGsDmnvu9w72Abxp+I92ZfBn8IqkW2S9gGhUoRiFZUI7XI6XyM3FJ9/wNUhpx6WndoAWfIl4IX6V5L47iklNKFeBbFtPePh1nzxgWD4ajwO4ojo+MhpgMOekbE21+a6Ck0OjGNVkKYjA/ekjEUkKwUldnRAc+e61Z4z7aPkuWF9pTMwYETSrAoSKs4dnl9wU4Bii6OO5ENcsawZvjn8TPmrGZJV/qjD6el00+uXrxrz40NU/KJgEqCoLvkI2TW10KCI/juR1Wwq3ExOo0rOZW7HERdpT422sr4SG3d0UgNhFLkC62ec0OIbbEwvaCuxHVv6xAxjyX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(66476007)(7696005)(86362001)(66446008)(19618925003)(52536014)(558084003)(6506007)(71200400001)(33656002)(5660300002)(66556008)(4270600006)(91956017)(186003)(66946007)(55016002)(110136005)(9686003)(76116006)(2906002)(8676002)(64756008)(316002)(478600001)(8936002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IVjXqD+scOZ8X61bRZ9odXYtVOUj+GevRGUAIV8/E5pFsPvmvr0mthZrSS4S?=
 =?us-ascii?Q?WaCHf+TbgweoD6V2E8xJ1JhusGzW+pzz86MJWG0ODHcbNzteg53faw+EEl6j?=
 =?us-ascii?Q?FgHinZLmOc027GXw1PIYe7+KCeKOGPm1/qpBQlGYcZUd7DbP9sji1hSWoURk?=
 =?us-ascii?Q?4MHb8wzj+d8BGVeAcA/O2Dr1iHkwT4ooYKEJI6EbtX4QhL7UwxHNmPTCoDil?=
 =?us-ascii?Q?yNfJ35Dm4LQAhcSChSmWggoz3eDmUT0twNN0GvlT8jXMBQ4QS4NWbJIIky9v?=
 =?us-ascii?Q?pxIJVG4BLELPoIMMMLN5gFgAG383FPOKbrwq747Li0E0rz1D79lIY5VfRseS?=
 =?us-ascii?Q?fQto55VH2m1c9PDuueuysrTaa5W4c8b+qTZI8xAYJvOhKv+346sRP+CkRlPL?=
 =?us-ascii?Q?yPgG66oSx+osRGOX7KpGZ3s/lRYThKwG36XVypRqAeypQK1atZ5IcsK5Ce9g?=
 =?us-ascii?Q?ojDLGRNmMuypvIvQ4+1SDc8vndPvuCrxSeWNL3vVljhFDvuY2QmijPXfmVaC?=
 =?us-ascii?Q?eqWdju7jcmX8NtdFGuiEhOLLLPaIjK3m8580dpXvkFUT0n5r9rGy44M+t8Rv?=
 =?us-ascii?Q?iSLvlOh7z3sN1pJSSsZey5Xck/Whe5dWgCY1xLi0/qaVeUbE/M0dP7Ov9lip?=
 =?us-ascii?Q?G4y6TvjipWkYhrS14KIKh0GlclFVHN8t3cpJYVOTV0Z0oeh66MjVg3tFh8zS?=
 =?us-ascii?Q?8XSKW8vmnVL2wk2ztPQUD8E8hCNHdSyaNtEHW4rFuyaDU7ykKgoD9R4hn5be?=
 =?us-ascii?Q?eeIBdK+y3pq0gIi0TnSCI3P/Q6fmzjjoX+bwJjdLCzyb9Aug0TWkBge6QdRa?=
 =?us-ascii?Q?pJ9uHtEiE0MI1m0AmwIoVLRLZyQww7oKz0Pbgv+4C26i3wFb99nTpUdOnmb+?=
 =?us-ascii?Q?jdC5UILovaUE9CmvAY/2yPXkjt4V68ZFs52i+d73QFkZP6aWB/zd4WXsLiTY?=
 =?us-ascii?Q?tsF4E+AN77EmT+Zi3h/kuy1T5h+wvKqPnaUHB5vNVWqtbVmheMIhjFjbanuv?=
 =?us-ascii?Q?HZcWdsWvGI29FrtcebHvCZILqWohZI0H4YSF1ZQwIGJZcIY0OnK29ghq7atc?=
 =?us-ascii?Q?kfi1oo+n?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d864a8-5d18-4f7f-327a-08d897698de4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2020 08:58:07.9498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJXNx9IhxIpgSAYgXqygjNa5jYTRHM56jmmkcHw/WsC1NR3XtG6dm3NnFDRn9xu2g0G3Jg1GT151GnHeoJXEevf5czOd4V5TDMFEK8Vfpk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4925
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
