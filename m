Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C488A1528B9
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 10:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgBEJzP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 04:55:15 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:56687 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727170AbgBEJzP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 04:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580896514; x=1612432514;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=oweyt3ZH/4+A4fWoqv7HEULd+uJQN3LjBPOKLRknYhaRfWyo+lJgFrVl
   aD0b4Yi6LJbhTJA7iGGm8fIUyzfL8w27yo7fck6P2ppCRfHECQ8ymDZEX
   joWO9uwuo5vKvWukvkz8pFVElxZryJzZrxaq9QwpyUdiqdCYaaRg0tMuF
   h+CmOZDqbFFDraI9ayVomfSCRNQJx/rNg4OVAYveBny+Ous6d+tVS0K9c
   9Y02Nn+2Tg7wiljj/CA4hs1mcOQMsYFAziFA4gP0JqSECi0Go4Nj4EaHp
   VBt77I27g24YbpmqOvtj8Lh8yIN1r9AJ5Jje85JogqcETyulO/rJIhnkY
   A==;
IronPort-SDR: FNF5JrobsQpmrk9N591L0KoPQsVzhvOoQwBiP4Zs4zxcPEbD/3sxQLWw/zOIgD0joD+8ZP59Ja
 Tnrw7blnfaa/NrJZEGUW+OtIbCQPwYaxChzcpCaaBmqxOzt4uqkOMskxLtjOblFf0rLjniy58i
 t0wfStqj1/X9lDk3X3yCTZ38dKLAYiPBzALJtdsOktl1ERrbU8kuhwMpbO0t6fd+/A/Dv1+6w2
 mt2FCM0tRaNA4UwMBCuvGoIBNBHRy7jvndgNJg/1LQ9cwEUC80gSLQtSOOyMvtRjCl9hk++vZ/
 Jy8=
X-IronPort-AV: E=Sophos;i="5.70,405,1574092800"; 
   d="scan'208";a="129688862"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 17:55:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6D0f7BfsaxSBdu5Ns5funeqSEtt0o0MJ81jmnRtvZcWR5D2I6VtT1rCgX7MJXlVOirdpdO1G44NIBGZSpvk6gkcVyPtftpmbmtNDhp72bbc+01AK4YtEwImwJXZFpClCnLbZ9uU92gUwsqPfOsaFWLQK3vak4stJ1eAyTpML/iHBGQs2VhBb7kFtu2I5O/5W5BpH3lwfK3K6dDmJIj3Dm6lTE9MT2Wq1MuItSpE65LDGCECSLjjAidVobFlNm8X4xsre1x7S9phAdukm7nD7sBdniaorljwmHp/VSYYOsxk4Re+GpbYSb96GlexTsFQZ/n2Ecn+N6gb2S6F7ouRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gJCvWUmYSLUvHj1niYS1dKVqDq3G4ftXT+UwYjOH4dOlyHVVpkGUX13M2raHc4WDrmVq2l054+C6nCD0wgAu20pRY95zo7vmIl94BN9KEh7u5BIT3voMHVkg9SfEtJyWN/o3Rfoy83xeLwxWZPE4Inlo044L5CdYYHPH1n4DZjzEhq6t9Ln3naMojws6eirb6lsNXIVOXnzCzWx2zSmgcL+mRlkLvC7Miy0D66Ww+QePbf+vDB8we1vdNQHBP/AOKiSo7+AU61jGpvN00ZHkHpEmQQn2MX3g+2yw7J/GEDsGTi4wcpYXugpzPHHNo4nfvAwtXs+M6zvfwJ/Feocxog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=zlIpRKE20U0d1xMOGBYhlpsCofitM4tr0BUu1tDM3yaOpEovz6zeqMLuiqR/QqT75yggmFdSx8azqpT6Ji0hlT3MmLZVnaW72Ema52kKiMZNwbPbaO/cRKaITpWL3JPIVzs4Xx03sBBRrdPu3/X/LH+SOuKR8T4rczz8KOEJtuk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3581.namprd04.prod.outlook.com (10.167.133.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 09:55:12 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 09:55:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 23/23] btrfs: add a comment explaining the data flush
 steps
Thread-Topic: [PATCH 23/23] btrfs: add a comment explaining the data flush
 steps
Thread-Index: AQHV23cLwcvRL7WbREeoIAOm+WHgrQ==
Date:   Wed, 5 Feb 2020 09:55:12 +0000
Message-ID: <SN4PR0401MB35980B3E5A2062125C4B17E99B020@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-24-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: eaff2c1b-b852-4b4a-d020-08d7aa217e55
x-ms-traffictypediagnostic: SN4PR0401MB3581:
x-microsoft-antispam-prvs: <SN4PR0401MB358198E2B51DE7C9D935B4889B020@SN4PR0401MB3581.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(39860400002)(346002)(136003)(396003)(199004)(189003)(55016002)(8676002)(9686003)(76116006)(66946007)(81156014)(71200400001)(8936002)(558084003)(91956017)(81166006)(86362001)(186003)(4270600006)(478600001)(110136005)(26005)(6506007)(316002)(64756008)(19618925003)(66556008)(52536014)(33656002)(66476007)(66446008)(2906002)(5660300002)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3581;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Q6ttv4Mw90+wxik7n/78key+02nUz0sIM/SxK99LG4MYd7T5ddHZ6ITcsWaUNBEuknjLBOSp+RAT9F8G9V7wRx1GjxalVg/pRwybbyA/ZLoTPLUGEsTilIcdqdziNWSA7dZTwLfHN+R28TGJ1ZqlMkjp9h1qGfsvcLCzwaXQU/g7XxzdwaaVjdRAagcMVo1qL5wv3+aLBRa+I3HOTSEgjgNRiVi95VEM34XV/l2T/waDh+rbaqjaEb47zNVrxAFC3qpks7sp6nmelbwxKLgwZWINgC+z7zyUbPL6dz25xSpXUJJCuIABTLtcClpUkIQ2XYYARl40rw+4JKmiluty4y1et8se1xxD7uD8poLBnWX1kTaeMwzQt/fJytilUaTaCdOMFTpUbYLHEjMlTFxIcV1UCzjQjdlR88HLDoD/9HOe0TWIZJOZNXKtVqzXpik
x-ms-exchange-antispam-messagedata: CBDyicTH92pidOMVjTNcqhQdqYdg83nIt8zUaIdbQhwsF5tutxqv//74J6w/V12tAkMZ4RauBxUQsepVZtN77Z2hCAsoTYKzsmNLPBYeIMZuRgFrI2OrPWaybePN4sX9Dbaxw+bvueuQOomaM45TZQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaff2c1b-b852-4b4a-d020-08d7aa217e55
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 09:55:12.4951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v0AI0gux2JcPVRIsIUSF9uD9uDI9USbphvQfrEVJGpT7HuWJmmP6uS5k3OZSoVSEyuKJkG2TfXeeHFHlIMDyCZLkryuW4P3sqbg5Jj/0pCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3581
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
