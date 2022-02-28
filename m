Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E714C70F8
	for <lists+linux-btrfs@lfdr.de>; Mon, 28 Feb 2022 16:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237391AbiB1Pw1 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 28 Feb 2022 10:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiB1Pw0 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 28 Feb 2022 10:52:26 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2FD7A9BF;
        Mon, 28 Feb 2022 07:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646063507; x=1677599507;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Wth/EYYo3P9m2asvsPuv3QxYWWCfS8QH2PyoOpuo/tA=;
  b=B+z3p9Euss87CTUW6DquUHXzd5nXgLhEjFv/elSxqK/cgoByTRH9VSmZ
   Jj6xH07slkPl1+iReJ6XMslpHUuVA+HrwaNl7izQdJQGOPJU5m1S2YIAX
   /FS+mClggmvTnnR+I9OiT/0XiR5Ue5440roTdjRu3OPvUYOLACDjcjV/n
   fT73i0Y3lnocleBTVRc0C2nEjM1YH0VBDhVkt8HnKk4lJhzQLodTROEPe
   YRNRiG7lIkaScNI6yTDLpUKrB/krcY599OltING3sHEO7tVht9TUhOWKK
   gt8vUp9n1ZlRj7BKQ8NBSqx3LD7zjHiPyqg5sCFejfGMR7k7mwjCKy1iX
   w==;
X-IronPort-AV: E=Sophos;i="5.90,142,1643644800"; 
   d="scan'208";a="193043581"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 28 Feb 2022 23:51:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b09niV99/NfJBNJxXFt95N95WPKrJgm23hxRe1uZvLweLFUb1gs09VjVjpqnMoLfNtJd97t41z7vbEkMCdOgPSOFk8J22xrBZhTt6ViAE5LllhXYZsjDPi2KbtVAp9jQ4PEtJD4hL+Uad9ZDL5l6ybdKotaXeJlxnc4T5HwOlyDJMefmoW3b4EJuAUrQTugAlqK30sha1++UJclvMX4/Tax0XdRLZZROmktTpN/wGUU29jOaVqXfOAq901o0LSB2hMoj1FDWYMIXSOeo8+cthFxgqiJDgq5Gnop5pYwseD6WTlDfXiVMwCrcmFYKOBxBPWMBjDjpxdu1Q/UxekXrEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wth/EYYo3P9m2asvsPuv3QxYWWCfS8QH2PyoOpuo/tA=;
 b=Da+ozvwW6d7gytw7qLZXGcqCglzgHpMmPOEIYjHBL15zfrIzavIUFdORJ2sNvRt67Uf7mGa+tICL4JTAEA8qksEOCOBS/kg9KmRUu8iLxuLW6rtWgY90ELM088kf5oojPX938xB7H5m3YDahxH8HYspx9k9sFU+sIBlX6arfdH4eLHFHiIQiX5MbRRzji4PnBXpSrwLTvz/PEHzaz4oeGo08ZBgmqFPDovfD/xl2sFmVibbXUO+XEGqHeh00aER23Cg9XWucKV9OVEwv2PIZeRdH3iSK9QPUPEylXdEFGeY/xy9a0O/0RdfT+3QIgBL+65wuuCrQ+dzYYn1UxkR5mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wth/EYYo3P9m2asvsPuv3QxYWWCfS8QH2PyoOpuo/tA=;
 b=WMieal8ZKUO7XeZKUWhODooavVieCDItutqocIHPl2BSInM8tkqTjWpoES4R5kSJXhh8CC0bpBHBA9xbJB80lqSuGvFkujoY2MYBPqjCiEopKkj0ctFmor7rkt0AGFU/jCrQa79RobbxerVQTxjNhWYpW2Rt7yAdotkquT+OdVk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB7022.namprd04.prod.outlook.com (2603:10b6:208:1eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Mon, 28 Feb
 2022 15:51:43 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%5]) with mapi id 15.20.5017.027; Mon, 28 Feb 2022
 15:51:43 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Niels Dossche <dossche.niels@gmail.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "clm@fb.com" <clm@fb.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        Niels Dossche <niels.dossche@ugent.be>
Subject: Re: [PATCH] btrfs: extend locking to all space_info members accesses
Thread-Topic: [PATCH] btrfs: extend locking to all space_info members accesses
Thread-Index: AQHYKo2Y7wkAR6Luq0yqa+9Ld8G4Qg==
Date:   Mon, 28 Feb 2022 15:51:43 +0000
Message-ID: <PH0PR04MB741656BC63FF14D8995B46529B019@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220225212028.75021-1-niels.dossche@ugent.be>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a84e7fc-5d15-49bd-f0bd-08d9fad237bb
x-ms-traffictypediagnostic: MN2PR04MB7022:EE_
x-microsoft-antispam-prvs: <MN2PR04MB7022CB2490861F890BB1682E9B019@MN2PR04MB7022.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Px9yRkMUl4QtSYRgcrRu1vNwV0QDO51KZs1AyR4dMHDq5CxZdw8L9X37C+CCBylmTsSAgL6OB1Pj1bsZZSR3CWDYvWIHEcJ/J9lP12XUpcG/75Kb8tVq5Rg8hnzYZFEAxcarLzTnUNQj+is1dFFBcFeBwF07s5jfTX/kKuWWZahw9jBu3277C5//ZGdHBehfTcsxPh/vcte1KxgC92wyPIxP9Q2jjC79GB+/FhZzpgZjwYn6YW4NWvxyetKgWjePbJJnXXXkoxPfZL9KXG2XIJ7QKqTh5/olqXffgWuF+TQhKVbR07/R0X3R7nbOoZAHIVa/JnhVMaU7UgqYCnB69e56OGWxxweBr7abSDf5eGO1JSkssi/jjc6k66BYY/OsBnABEwun9A9q+c+R4gKhT/2o3VAsB2v94ok14Fg8Sns0JPwHfB2v8+Ek7HgG/UqUyOC4HfvyYagR6ri2GNnfwweQ/5LvJ+vxCeV9KEXFnBG5D9cZbQu4r8nUhVTssVbY9Hi9N0C3BxQaNziZHs5AGccq+bJBaTU7a8r7D8yhwXnNIs4DDMOsGAdFYcEdZncLGIiwUJ+V0XFABFCvaCkcV9ZPrnae/XWyuEQ8MlsCfg/CoZBIK6mkuNVEXlJkcam3IMFOy1KQ5xqaEBFzXjf2c3t16zO1OYFQXdZBQbK2yGw2c44obXSyQUAFFYRztbyPF3IvLFwWaYCu5A9gvN+lA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(316002)(33656002)(110136005)(54906003)(83380400001)(4744005)(86362001)(91956017)(8676002)(66476007)(66946007)(76116006)(66446008)(66556008)(64756008)(4326008)(55016003)(2906002)(8936002)(38100700002)(186003)(5660300002)(7696005)(6506007)(53546011)(122000001)(9686003)(508600001)(52536014)(82960400001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Sk7TS0lGOyCNLXOHQcPuEiWvM4UjJcmDeRohqt6tqG5mRXDGIBahOUjKbyt?=
 =?us-ascii?Q?oTY+MTmh6I5eV6gGrrykb0XOKf5cUkiZZwBVorpqCnG/fYKlfejLA87iRXAd?=
 =?us-ascii?Q?ijCOysuxrfxVRnI8Ysan8YBQbZlMfSzhbQtKEX3UrSkr7yhAEJw8cqxv9Q+c?=
 =?us-ascii?Q?Xoly4HqWJPAx52+9p9MBuw5maVlmTTnuWNNWa3iZLIbViHi/h3bXgIrnZiiQ?=
 =?us-ascii?Q?jp59EYzS4aOUsXmoPOak3Dvfy2i2+rD2EoM3TCK3o8WzEnze1RbFO6iq0oGP?=
 =?us-ascii?Q?KZMT98BQYVaHD9b2qw8iT7vlKK1cv5+dxTIU4XR2Yp/0MlBl71qkhVzFcrEJ?=
 =?us-ascii?Q?zXAaVbfFV4cZm15E2AKgQ8Q1altZnX8dNHN+BCLCl8EqXYnIrGvgeWSRo6gq?=
 =?us-ascii?Q?tcH0bumeGWUwXUsf7NMDxfixXvOhFnkrG918pGAnrdVqWO9nKVz7JNZV6K/J?=
 =?us-ascii?Q?8weLqrPraj493fZlpem0BUSMDIKVpERQMgPliDzFR1INGFEkwYL8psXy3PNF?=
 =?us-ascii?Q?pzR4laCstNbdl71tQ4q72Hg3j0tJ2ZL4+aLmqbKJ6uvMNqJBG4BvTkskXpO+?=
 =?us-ascii?Q?edTVHr6GkgRXTuZdzOx3SIBF0U39/1LOnlYKqHfK4T7HAPEBtJWd3FK5o/1Z?=
 =?us-ascii?Q?U+3bf4Sr/A4ilzSeu2bdoWKYtJzGd4GXuAfKjFoAhhOQXN0j/9YcrnaUqmeM?=
 =?us-ascii?Q?ue19GQDgc10/FhKmm+WD+70tHcfFmUu/gBzdy/NDFA/52RtPZUFVLmoYOHoy?=
 =?us-ascii?Q?l85igwYV7AetDCR8wv9fNCuOgVofj1fNwxMsYCNMdhfVFZO1n6jhLJ8J8uvL?=
 =?us-ascii?Q?QrqIw6D08yHP9SfmdT3KtukYyrWn5tyAby8a1FFJpm3hzI2SMQ1JUyf6xIAX?=
 =?us-ascii?Q?pTdMTtnJ2dD/+m2WBlQ+w62ESXWLCe3LC/4J/K4MGGGpabmL7L1fQFLjpiGx?=
 =?us-ascii?Q?CBRLgw0n22nQGIL6MZOsfzrx6qT7m/Gp5E/fH4hTVYX0/5xq/NhuLJyRlCIy?=
 =?us-ascii?Q?zDT9GNn2inV6mLJw/9fTtXQkcmggev9dJs+6mkdblKv1qia4hDsGoFDu6KJx?=
 =?us-ascii?Q?+ttOA7rtOgFNwzTCAkYJEMQRBT8Lks8s59kLgrFOEHScXrXPbFa6zy3AbEaL?=
 =?us-ascii?Q?UztXMYy7jQ4toH0QDgdYqhbvxvsZ+pqrxwvs+ygNG/nSplqTd8gG1VKgYYD5?=
 =?us-ascii?Q?tjzw7A2pJ7OZCRkM1nX4IZSz9gZEkJyGPQw+c6Si9J1kmoF0Csj58oSnYVDQ?=
 =?us-ascii?Q?C9GgPP17/pCx6o0Ngb2lRepvPQZkuwh15RbVDSr3STtiCCB5gL6AnpqSdTND?=
 =?us-ascii?Q?MaUQ3PdHaDPho4xkS/7BfZOPJRXomp7sPHlZA2akqG4kBqBZiFscFLyeeB98?=
 =?us-ascii?Q?YGXsNpEVvyddR4cbYlIAP2tI9IXHGRMNR4agJ4sQ0+cV0Kf2AHwKj9VmaVvI?=
 =?us-ascii?Q?217rvoIaZMmyFKRX2xDJ7HHRCvsyXQoKkN/I6zCB50CwNcQdCXv0OKiCzmtL?=
 =?us-ascii?Q?4SMpR0SyLwe0LXOOHv6hLSeooU36rNMHasC4hXC2yjmYid8OYjwlESqGeyb1?=
 =?us-ascii?Q?D5JBptZlPV6xOACTa2FDoUebAIudUNDAPh5rduS9xZKQ2BalS/V0fvOKxg+R?=
 =?us-ascii?Q?DL5JD0rR6+n5DneX8GA+bTV2B0QHmayNJdhKoogsO2SpUzD3OHEAF8jfnoO1?=
 =?us-ascii?Q?ft19nGH/qxn+yFPLMB4SXbCK0DHdSu6MC4jCPWVPumv67NhtRhYljnCxWL0l?=
 =?us-ascii?Q?3APjKUAie1i3dsnauBkYweBdA5S3ZkI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a84e7fc-5d15-49bd-f0bd-08d9fad237bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2022 15:51:43.3577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xpie4+/8UkiS9FAYcFkyts7+MGPdXBGMLZ4LYQbzLVvI99MZh7i1J8Nrc0xk1u6QvAd0QWjrj+RZSEksDNfCJ+zCgw4AY6zO5CRhL7SjJlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7022
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 25/02/2022 22:21, Niels Dossche wrote:=0A=
> bytes_pinned is always accessed under space_info->lock, except in=0A=
> btrfs_preempt_reclaim_metadata_space, however the other members are=0A=
> accessed under that lock. The reserved member of the rsv's are also=0A=
> partially accessed under a lock and partially not. Move all these=0A=
> accesses into the same lock to ensure consistency.=0A=
=0A=
Maybe also add a lockdep_assert_held() call to need_preemptive_reclaim().=
=0A=
=0A=
As of now, it has only two callsites which both hold the lock before=0A=
accessing bytes_pinned et al, but better safe then sorry.=0A=
=0A=
Anyways,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
