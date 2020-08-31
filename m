Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8B425791B
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 14:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHaMXi (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 08:23:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54500 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaMXh (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 08:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598876616; x=1630412616;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=nkxBB/QltcZNMsOAs/InhxT3g3ZMjNt7oK78L9ybU/JLqrXGFX2WWygu
   10KCh8mwZ1O2+pAIhUE/nKFZA2juSNNTh0HeDFe7hZDti5gGWv+hbzQbh
   wQRYuk1ENMe30D8S9uu+kgafVa67uwhztt7Wt9O0fGjd5ECd2dwRuc+Sg
   m4VNJoDkPobeWhEt+aLpwRwj2Z9yfEwdzzazhYCV7SSNsB4oThP0uRuHT
   /o0AoJbf4U1b6texAJtuIJ7I2BO9vxuFKhyIqotIqnSKYIVCUAW9MmPZg
   dubZZ1Q2cz/zoIPbJfurIbVgWolADDR9weqsIuqrCI9hgpv3NFSUVXSDk
   A==;
IronPort-SDR: DcMg6q0Tx6j42/9+I/l14ZSSJRcFC/OZIysaDhF2FQWf1JrpKuDHd3b7N1YExGjicCg0pquYBC
 IOcvpz8w7GdGLo6quM5AtSo91lUko+XihXB9AUhQ0MYjN2evlUFtNai6l0nwGtm4Yy3PvSYJXv
 J/K1cw/zHQbfFJ3Lm5lDK8SLydwlsc2wGHcz8uFuRk4ckWPDfbMa60ehkAKwzk7nd2t50rq5Cu
 mVDb/oPnsmwU5yEYiwR8x5WLRWGZ0I9Spr4oa6qa79hyqatdxGTeqdf8QW3K2syng9IkP6U9FI
 WcE=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="146216383"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 20:23:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuBU8Ti9xKSro+s3fhbGEH/yEHZey1bJCIvXA4r32pCBu6m3d7055WPvvUYGTUiDNFZTKk7qBZRQlmqpKSOzZexAE4o3+Sp7R/B1CSMuLGK8yjNRhEXiAiUQZDNfZX04wVAc5ESAsSIw6ukhnX129Eqfx0pYvgZLT13sI2Vn7tJnDzWtiphReN/rqvOwdMTEyQvdTPSSNSUiBJDbgMHcuhz581kkIYkyX0iTbbF5ofDqgp0FELlc9adH8GHxOSmUvu76eIHESRfw1Tq/+LTgcICV/TklE5a0blIRPnfsuJI4SUt+d+41kZV2jSbJbr9wrDXAQmylMm5nlXLFFaNLtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=WbPhV7/gQiwKM4HmXenDI1doUS5aISW9AgltP7BFIqCj7LIyuGVI94GWH8ydRtnXFGECUsbc6cLyPxOIeDMJ9zkE6IyENB7UpGELor4/l2BI/YS9uzSQ1c9PEu7NoHfK4dLf77xNaY3YtvwaOL4Vlr2xmGrjmAITNzlpG9kE9HZ3+aZ+EA3fdw2MbjmF/6zAsvZaxN7bzLgh3LKddO5d8n4DPqh0VIiNDNn4UfNWUnYT2bWlyDp27o6s6DiaO0CX9KuODTKeat9kV6Gho4Pr1GPyrpq6SxClrmufhjG+TZ7R7fmauC9QjYtVJQOcEp1BJyNjJ0QZ9wsDzTFemjxBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=p3NQeEL61Frlw7rhc38HNrAkq1UckX4mkrvUW0ueXDcPJ9oB0zzCX9f7k83J9b6fL123sW++VaSUhqX7Djky+88hK4TM7Yt90YQmVsAMK7/lDiJAEJqIrHmTXfBy/41BHNfexizfoBLlOhF9zGgsIS4PkeTly+B6iHX3ka3A88M=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN2PR04MB2142.namprd04.prod.outlook.com
 (2603:10b6:804:16::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Mon, 31 Aug
 2020 12:23:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 12:23:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 07/12] btrfs: Make btrfs_writepage_endio_finish_ordered
 btrfs_inode-centric
Thread-Topic: [PATCH 07/12] btrfs: Make btrfs_writepage_endio_finish_ordered
 btrfs_inode-centric
Thread-Index: AQHWf42DtWyvNUpL4UOAbznhJPPOTA==
Date:   Mon, 31 Aug 2020 12:23:33 +0000
Message-ID: <SN4PR0401MB359862143185EFC9CF929D9F9B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-8-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c51:a08a:7ebe:d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 81d7cb97-582f-47fd-7a0a-08d84da8ada1
x-ms-traffictypediagnostic: SN2PR04MB2142:
x-microsoft-antispam-prvs: <SN2PR04MB21425094C2E259F2861697BD9B510@SN2PR04MB2142.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gN6gxl+cGyJ2cRss/yEzS2nEbb+CwIKVgRylEN19z776h2PAeUtB9O0FwGsxDrr8FwLBR/b1oQF0ayjwzvcobrhDNK690FrIK5+ZW2xmVtNmQA8p6WgxZFIQmusj/lOZn0m5WF+l/wImDRNuMLX2tlFB/4Iv243AALnnJAS5Xuy6Nu6eKBg+7+odnNF/xr1yQvU9UTMeNUrHIDxW7BH/bAvg6EQpCeiJiK0WGQbmo2v7nRMKKcSq7HKDgIWamDHm07F7vFAikEYEovWvYeJYi3t94gWrWZtKnKW1zTB/LmvIjIKBcpAq2wEP9SrwlW/NEy7LnySoR8pp0WO+T/Js4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(76116006)(91956017)(186003)(7696005)(19618925003)(8936002)(8676002)(5660300002)(52536014)(6506007)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(110136005)(55016002)(558084003)(71200400001)(33656002)(478600001)(86362001)(2906002)(4270600006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hkPSaNXyBoBJ49Mk1DIHPsbJ3bfjuLA2LH42rYHXUh6DT53KE+00lxSVNr33BuQdzw+aigihWQrvBNzh1I79ayyG9bMHXOigB6u8+4LEYPS4NmDkjgHhr0EqmnPUqVhAnahlmNrtjuZmnMlOVeaLhn8Au8CPi0R3pfYIGUY44Caq8s8Vbp3CSIV1osm9iP27SKG+isVCR0JFLEYZixZaNAb0hXnhUuwQE6HYBAFc7jl7D5+DecMA3kGp37xYO3i/q/BqudXFKuDHXd9HWzoz0dAbhDIGFQrN6IGHB9HMxmYh4oLyyM2Tzn/EImubRF8o6wUOh6/FClMYjx6mXE4v6qa4ngP9LCF2XxSqpd+0qc09Zha3gFgnRKFVZY9Qy+dKkaSXs3ABJeXDv3+J7Vfr9nspxbFtt30RD/9iaCgUpxQ1aPK8l89cPXnufxcXIoy6qZ9meSddxtdkHq0XmL9EYE1obcQ6k4K+gmNBpzDD+giVVsjbip3RP6jR9ln5h+HnfNIZ2mPDTZnbdSiV2Nl8g4hYDcrqZNA20eNBiwRLAogIg8Yp+FGrkx0Og7B0Ru+gse9e1fc2YuGd0450LilWzhoAdLfs/DiJOUlsThWNoYjGFCsnyMJn26LNYgFJtp1kawEyyHBuxSWkSAck5Layt75WGrtQl2FidLaQoTfq1PDuwahT2Qd4Q8jW68+ZA/uEEly172mQzqu5uKxQUUr0/A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d7cb97-582f-47fd-7a0a-08d84da8ada1
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 12:23:33.4961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 45DZZtQGPg/X3NP+Zd7dWYzoAm49sMaAC6i83Mam7dX8aEx2YzFMqMS/RJUdqAJqxnyhtu68PitgdwXUXjo/LBS2lcJ8ep+tzaEJ2EBUN7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR04MB2142
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
