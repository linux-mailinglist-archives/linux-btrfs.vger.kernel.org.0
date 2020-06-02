Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A22F1EB7A2
	for <lists+linux-btrfs@lfdr.de>; Tue,  2 Jun 2020 10:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgFBIua (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 2 Jun 2020 04:50:30 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:14360 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgFBIu3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Tue, 2 Jun 2020 04:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591087828; x=1622623828;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=MjSd7vEAwBbLux5hiqkGWE0oRfxF3DUeZTMVe9vROEiYAGqBVhwXttV1
   3yHSS9kdXV51tcFdyXmd9f+TYmpU4LZr4vk+r3S5QvLPC/OdILdURjYF5
   DfkyMbs1rdyn5Ul4MWhPFjpGT2FmATmM9o2OO8jFVs0QFlxHDJsWSKlKP
   YzpU975zLynVhA1281SqgjOd1bZg4n2q01paq06FIwmdDP/x4RsQiLFeN
   erA+1eU3KUaDIWJu8OOKohLRTxdVCba/ig+7t5Grnc33x6VVAn8ZOEQNI
   wYjv35bvOnoHkifzg9Eo+b3Qqn3pDAgb4svhilqqnxeHLWDIaCvJKoiCE
   Q==;
IronPort-SDR: avmx/NiJjqHFUA4sD6HHKAtBnOiopI6znMl+8HV7A5sGJXsV+wid4tqRf6JNaWTe2ieoF8hVSj
 NHmtPINhXBlmWcz8fHtZie39v/XeqExFRoChgBSu3ZZYGfXz0Ah4PZ6hP0XDTsNdVgDzzZxkFY
 JJdI94OLZH6KdyALxz9+EaKkhIeHKzS77gVsXlOfOEY3pVQ4eHA/dONG3F8mlnigmaLmMGsb7P
 dwYZyxh/1UVc7wdrhL6For/C+UarW+Caxdmb8rix9iXYvMC8Ew2ZaYtIZnh+w3x1rxyQTcSiAc
 7nE=
X-IronPort-AV: E=Sophos;i="5.73,463,1583164800"; 
   d="scan'208";a="248099554"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jun 2020 16:50:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SizkohPEVmwk2cYUdHQC8iwnlLma0oqLPKBYolvg6BjI2H2DFP7eoZRrz2kJFKJOeCHnJcsO6J0GQ+k4Ki2OxFKgtWsImsKZfWEALRVqqNiW5i4LclwRkd9ILAEJ+EuJW7JbttgJx83zeB51GXLmCMJTbYPHwTVXcxeMbRHE/TwfPvD7OIFByb+c2TI7fNNKbTX72iF4eQAmNGv9r9bN8RnMBEebpmzwtmpN4OoW2yWqOMZ4KiIxV0u4KY12avSexcTDI6va33kq2rqgrmE+Jgb7w2v1a2ToQ0EvMM8Y4t32W+bbsVt5pWMKbvwDmLpk8Hv2lhw5RDLVRaKV3YAevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=XNSb1zNz5sPkFVgtbEGFJkTlDMU//MwOx41BQJ0EovgQIjzbUiwHHxzMxbNMwEXI+mfVa4josUVZyosfOrdipNZa3iP6WKUMzaI92J1pOV4FqMDEolzCeuDrXC9Ej7y7E2VZCVEGt+uYTuPbXlS0G/RTITY6q4NHXj+JX2BLeLb0GCasIzqfXcYD5iBaYHr1Si4U9CZTpu3UGdvyqNtmELAn44aNC1U5E8mIvCeXJttsH4AFALdvQkuRiZ6OfvwBHOEqVa3sz/QrT9ICb4XB8feNAkyjGl8cYwX81NUu0guxmHa+UFWDVNel6G1YorawBNXTYwJBPh6R+tNx0TgLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=aUx+ScR0vn5UQCNFMQMkGsuKXvs+LqlFd3qxpebBKJlh3jcppiRmgTXFviOS/UNvy5Ly56ZFZhZl2wNZ4ZdYSjWX6FGoG8F+Cu22v5Ui0Dgr14uaa9X7xlMN1pimqKXgIx2+KSOwSnLmfoPpV4BODljEGI6gcGu8+jFDY8+wkWc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3614.namprd04.prod.outlook.com
 (2603:10b6:803:4b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Tue, 2 Jun
 2020 08:50:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3045.022; Tue, 2 Jun 2020
 08:50:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 01/46] btrfs: Make __btrfs_add_ordered_extent take struct
 btrfs_inode
Thread-Topic: [PATCH 01/46] btrfs: Make __btrfs_add_ordered_extent take struct
 btrfs_inode
Thread-Index: AQHWOCqc6eqGI0N0IU+TG/BoPf4Opw==
Date:   Tue, 2 Jun 2020 08:50:27 +0000
Message-ID: <SN4PR0401MB3598CD8E5E011E486F7979169B8B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200601153744.31891-1-nborisov@suse.com>
 <20200601153744.31891-2-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 672d6a9e-56f4-4aa8-f016-08d806d1ff4f
x-ms-traffictypediagnostic: SN4PR0401MB3614:
x-microsoft-antispam-prvs: <SN4PR0401MB361483F916D882E80F07A23D9B8B0@SN4PR0401MB3614.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0422860ED4
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: virNW80tgS3oL46T5RDbT9IjR5QCE+8lGG/gPmDIZjD62xtRAX72AoagFWkJBPVF8XSYCZtJZpMGrIs1YYYryOxh+G525DeUiC/U4yPruUotEwIlQ5lTS3cT/vroNRNJ43bqP7ZWjJ/GIB3d3kFzNMemJoBRBRMQFYpwYhZIkJhWS4B9XcSjKRONQeNeDPHfLr78P0dnhSdaywHGFxTrC+FCwttLMVXPGK9xh1VBFLkRbtWSRgRa8kSeH94q0RR9BYJvOZr1C3RT+Ibp90Q3PxN0sdiexFM4f7u/DyhhFQJJuoxDZgYzTuIC5xdYEkW2gIk3WuFI7SPXHgj+DW3A6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(76116006)(91956017)(66946007)(4270600006)(6506007)(7696005)(478600001)(186003)(558084003)(33656002)(8676002)(19618925003)(8936002)(52536014)(71200400001)(316002)(86362001)(2906002)(5660300002)(66446008)(64756008)(26005)(66476007)(66556008)(55016002)(110136005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Yh9e8OcKtEAOohPVpKEujJRBfOaEOVJqCwrJCV1xtF2cdqhanBIcj2eUM2WyP3rslJLRyDrUVGOSJk2sTQI99/xa7v0g8e56V7DAV1sc+wKrwgcBl9qFzyeNqVWNIDLRKXUiKPBESkGNEJ1rbWUCrei+QIf3lOg8tzx1zKXUERkyR0gNLujlPPbX8vbIiXKVtG7roGkxF2VDr5plrobjejzUef/qPpxzEqTKISjBgxUCMsA6L7ZQfDkN/REpdnxWnocjCjHZn3waK0XEW+HypkQMG9AYV2GVsSrXnJiI0Em5u98LM/QPnNWTYmsD8E0HfiZ4QpDDiCSZhcg2+vT8euCkO8g4ySSXTYxspyUjYRSSDuvE8dzRLByEonJ8xZE5topSuNhEGkAdQcGmY9wgo5nT8S0KjExtM25XquMJVrEpzo/5FDeGIdUyVkoukhe4YwzrRgpCsshsnyWqLGXIW5sbNUBN9Xt9GwZ80bsVojVEloP16SGQiNR/12VBVRIG
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 672d6a9e-56f4-4aa8-f016-08d806d1ff4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2020 08:50:27.3306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmkqypXe8Ts0RIHANsX7OqxezhfzZT/akMlI7TdhmRxwJRQlrWCqQtl9kHQVsV7hiRkNZVitj1by3BFTZTDIBdpBeMtFkUKPC4q7J0PgdEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3614
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
