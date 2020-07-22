Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 413A52294A8
	for <lists+linux-btrfs@lfdr.de>; Wed, 22 Jul 2020 11:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729894AbgGVJRU (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 22 Jul 2020 05:17:20 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28523 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgGVJRT (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Wed, 22 Jul 2020 05:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595409439; x=1626945439;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=dC66SuGA1oGR+heB3bbsZQYfu7xsbTteoGYshDuX6JM=;
  b=hQVOxDKxrLk3ORpts++ZBi46xl+E8Uo3UwMPNElUqcYEU6zhuwixPBh0
   iIgVkZacKrQJ5VH1QPoQWkg6Ie8IN7g7AwtPWZ+B0oO7pIj/0WkeXzPdD
   4bLUXJ0Zl5NoAdCYlfaXsmLN1HBiwhC8M+FB9YKee6tn1Th08AIJSDONx
   ctzLWZ5nxYVgmNpuYnEM1e6tQ3uYFNMPFyg9al4AxTgYXnumaZMRMm5Hk
   4lU7JYjyw4hFS/exg8x3VFfcxRcvVcnOeRLRi1FiarJB3iAQISnF1vOHt
   c7046P6EVasy6wZcHhG0EuWewswkdRMc4QuhqoTP6KqgPgRtdcYgizJss
   w==;
IronPort-SDR: vXT3MgDLFanxYmn+Yf3gZxpDBU+XfhznnaIvR3wKoxwDQ+zzhVPbzWj32jjV7K1UPwHq4uk74t
 WpRhgHx0HFrpJTM0Z/vRtJ99wEMaCPBRLkcdlg6MZGUI6n3CO8DV16iFQycOmbVean/jYYMkvO
 KgYvmbWJ/NsHEd77llYD+g39JYWLdLKAdEV8V/AnKy3wH0iBvdTo+Q0jnyzAFAl0hCoLLcQUIg
 3137+L+OtG6+A16uSk8dPxcHhYRpVJWF/SBtcHItQ+kdpi7XxzO/CvROc78jPjTjywHkfsOGvj
 nSU=
X-IronPort-AV: E=Sophos;i="5.75,381,1589212800"; 
   d="scan'208";a="143191644"
Received: from mail-mw2nam12lp2047.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.47])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2020 17:17:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O4BAI0LtAbT3hsrN6KdA/9Llib7DRz38tA1N4k0nVeUsRkAW7eblPsTutVNUThkK60aWQwqktDZ7imbP3jbvR4fuO6TXlUZh0hEGtPJL6fnONqSbLCfkoqei3rrEGVbEe2IG8a6s56Q15C2bxezYmPG+zA06i57U/OuGsmJfukvXy/fuj+mf1yibcNrkMdCPHrKrEJCMppG8SI3Hy+KENDGgFwUcODKWwGipEGbvWafeS8svIUCTp6F5//q++/pCz2XCpo8TAP7ARQfiXFwPdWlJMDO0WUkJXnUctIWZ419XmidwAXE3OLZKwNxzeQiVPKIPTSv6V9Ni5nZIcfgWyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzh39WO/nFleer7gOpNiK1QRsIbtwGH2f0EEyLkGbJ8=;
 b=Pkf+1fGQpATRhaxhDX9abC/tKeUWP7pzyP2rBIyMYGaBc1zlKtVKh23jcl3yoNW1KNNcrHYUjcFCrpAKw7GMuz2VyD5dZE3fFamTTzkedZ73qwgXTN02FWMvD+UF7uvmB5yfvsvwmL9WkXj7FIJsJClzuRSEHwsdzdo6GOPGAabGvcwTOWh761uO18PKE2aTWN7RkLPjqpj2q6ELn2PR/jwTG7rOdBwV1rLuuJwY7zJzx/1kC9bf1X31kABg0DkoFypGOXj6XvBLY/gLB07e3g4dI0ySBqHZv+54LgqMbP4D94dIkauIG2POOPpqLz0hyjZLfLhzXrLHYmTQN42ZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzh39WO/nFleer7gOpNiK1QRsIbtwGH2f0EEyLkGbJ8=;
 b=upaL1BLJFBPBWtZnvI7I2vBhpdp0tuth1yiAJ7MqXn98uk0Zbwjia/u9PI8f5Wu2jaE31f7+VP17TFX6JLayfAbXvAFNV2LwMzebxmqOhu5vKcqteS0jZLLV3lGuPGLFkjx+Ny1sDxg+DL74XZHoi94QTUBk692NFYykoqdV2aA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3599.namprd04.prod.outlook.com
 (2603:10b6:803:4e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Wed, 22 Jul
 2020 09:17:17 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 09:17:17 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 1/4] btrfs: Use rcu when iterating devices in
 btrfs_init_new_device
Thread-Topic: [PATCH 1/4] btrfs: Use rcu when iterating devices in
 btrfs_init_new_device
Thread-Index: AQHWX/9xTLbRR89zDUKIQqG0qAcugg==
Date:   Wed, 22 Jul 2020 09:17:17 +0000
Message-ID: <SN4PR0401MB3598E3FEB988273A2709414B9B790@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200722080925.6802-1-nborisov@suse.com>
 <20200722080925.6802-2-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 409d07cd-ee11-4859-8382-08d82e20076f
x-ms-traffictypediagnostic: SN4PR0401MB3599:
x-microsoft-antispam-prvs: <SN4PR0401MB3599EC018A248AEA45A6D8C29B790@SN4PR0401MB3599.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ysjvpsimLEVW6VcYws342jTS8s+ADn5EXTcR3EEHziSV7iRxmJZ+WVfpPj+n885xgkxvV2Nqcjvu495eBRWCtnLBBnLE1C0q4al2UyIAJ1Vm9IQN7vI3XL9MfGVCIxaT6WPASW20wI318k71mmPwF7tos1+dLEI3vLzEa39HTjc7qGJ7HmXSk0MCzJGdbGRnEFmU9nb4DKTQfeNocrSbMVkU9ES7Fj1qB6iF1sPe3lHqRUDrnD04AEAMc3038I/yKcKxvnZB/cwTmL9vRCwLgW+Sl8VyFDek20GsLIb2Olh1otPluT1Tl3OjbKKLOkL5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(366004)(2906002)(186003)(91956017)(76116006)(71200400001)(83380400001)(66946007)(66556008)(66446008)(4744005)(52536014)(66476007)(33656002)(5660300002)(9686003)(64756008)(55016002)(53546011)(478600001)(6506007)(86362001)(7696005)(8676002)(8936002)(316002)(110136005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /VqkNUMaUBtQFtcs/BU9UvvBoZGd1oMoaAUWW+WrMt8qfkhIPfiIM/uKjRrd2waYvOGtrY6tMxRx7ja3XZddtT/H6Ha72tmHqm2Obl9qAAheBHepWxKyCSZ3iSG+S2O/ZgBMC0KDToNWCGtnyR9upOWnJJ6EQxvsWpaw+5+US45mPo7V8BfR3SiuBQf6t4XekQGH1JSeVd7eaH0vPZue3I9vkXmp2IcpqPODYrVtPwU4dbq/c6fiXpD39jpLsAeWEsSLEIJuICs4FBqOFVLLQly5BrSoX34IztbBqKHRLpX+mVO3FQwFmDC4Dn4zkrkD2vIdWBRVUXhX3yvVKB9sVbXONU/LIhBPIO7ushF6Syo747odED4oln7TTroWyZF5g2Mu2gXGUTqg1CBhzBuMLZxlRKDv9J8uzanmBUds4pfDEwt8NVAIkKylyfRDOgL7hycEwJMycDkEg1oRFSgKNtK4MhvseDJmNZ8ShZrXR0z221QklCjqNjzIhhyU5nt5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 409d07cd-ee11-4859-8382-08d82e20076f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 09:17:17.0285
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wJzOWdRp7anPNTd4GSgfvDk3U895tiHj+aEwSVZJR4nrP85K/HWDMUeerh1JHohaQzh2gwJnvf2kdRWf5ofYSkvHlwEsmHyLezrj6mEoGRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3599
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 22/07/2020 10:09, Nikolay Borisov wrote:=0A=
> When adding a new device there's a mandatory check to see if a device is=
=0A=
> being duplicated to the filesystem it's added to. Since this is a=0A=
> read-only operations not necessary to take device_list_mutex and can simp=
ly=0A=
> make do with an rcu-readlock. No semantics changes.=0A=
=0A=
Hmm what are the actual locking rules for the device list? For instance loo=
king=0A=
at add_missing_dev() in volumes.c addition to the list is unprotected (both=
 from=0A=
read_one_chunk() and read_one_dev()). Others (i.e. btrfs_init_new_device())=
 do=0A=
a list_add_rcu(). clone_fs_devices() takes the device_list_mutex and so on.=
=0A=
=0A=
Thanks,=0A=
	Johannes=0A=
