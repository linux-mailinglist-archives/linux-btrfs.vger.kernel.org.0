Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1997C257A47
	for <lists+linux-btrfs@lfdr.de>; Mon, 31 Aug 2020 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHaNVw (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 31 Aug 2020 09:21:52 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:49943 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaNVt (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 31 Aug 2020 09:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598880108; x=1630416108;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MaTymyaA0zeGOiiHjDZZO26uomv8oX0Ob/4VoXeSkSc=;
  b=PqGEHduryx8myYmRoUnrAdzLZsewpIpHPGawNK63cr0LfliO3TdcQp/T
   TrnC9qf1ZePylihZuRaThsiX3PZ3rQTRWmCzm3scaPgUIe1zqBkKiliHv
   ESbStOBb326wSM/7xu2OyBlcBg9fP0JJFE8Yt1ieuf9Vk4V9Mf8BwsJSI
   er/kK2A2zmPAuVQcPbbMtX0lUVGlc1qupANbKEsa5/Z96WNCErt/9zGx/
   Ei8M6TUO72tsavzIKr1A5GSjRU7INexzciOiCYbxZK4Gzx8s161fOqo7Q
   4ztsPvniaXipQwFlJxEJWzvsg/SLAQ50q9yyXdRX0JQPlkLqnBGIGT2zV
   Q==;
IronPort-SDR: 0vqlNHW7opc2RCkg7Wy7M+QsvmkI5IxpjFx+U6ngu6ok+wgRVJPtkZ/QRH1s22xHoujnFJDnvu
 hrXbdfC60bc1/smSGnVCJo60PQCvOdCV/Z1PgDUF8zzKefZPTSIfYYIrgwdeZouNRz2GBfQ6Rh
 yGLDaeSgbgcqmD9R1kEzH9HdWzYpowRh/1ILl+OrbHywK7nAzjqpefLzCDC2Coqe36rNOp7HFQ
 1OEjCjeBraKV0Ehwst8xihimoiUx1ZpAiJz+/LpelYho/BCR051YlMUlN/xslFmNMGZ+3FDxpv
 Rw8=
X-IronPort-AV: E=Sophos;i="5.76,375,1592841600"; 
   d="scan'208";a="255747035"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2020 21:21:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGbolu7z8biF52bnZn1/xqVzFYHwATBs0s3NHCgvnuhIIUHjqku5gUQAi+REEW5BE3xFRSjJis+C432M54iJOzujYSr3LNONkhmjOgiyOwf8eqsEq8GDW9k80RyRbp/V8M3mgtU+fQCYEn1H8mO9W+dAFTBCXqkANI4MQK0WjIDBpgAZPsEXZqAMP3d3brIxjZotVIx63hz84WBYUjl/OTM3BlM5/aYYMMf+iFbXkTARw+z+SRO3yR2zdtwKb9KF2rQPw/la90mSqDzwmEHIiMYpfB3+fVpVboTqMMGPQ0rEYR0rkcj2QLoF8MgcHThidnnS6hbFBwxok4+fz5WPQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaTymyaA0zeGOiiHjDZZO26uomv8oX0Ob/4VoXeSkSc=;
 b=T7cQNzc0cqBOIdpAUJ6uP+RlPOKwBN1ivuUacH5mLV0DgM5oGPDNsfYbyFx97umZGOuKWm8py6P3NWr1lsD0Rk2aMWK9kDzDgpVmrEIRkqQyHzm4CZFnYmkjl3c2bZ2aqigigiJte9AS7p+7rIQfWg5KvN9O0kd06X6HnDysMVNTqycT16zW8WSQt8DemDktplJtcN9lSGyoYV/8d308fGz/HM8tRHvrLdflz6btJqmukEumfFgJtBwH5+ZjOfDInER306KGflyzkUwc4AgpA7IkeTJzERdRnqkHWDyNyJEkonDRE3lY4tPQ++eGPliuh3G7m0x9MzPCL4aQE8VdwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MaTymyaA0zeGOiiHjDZZO26uomv8oX0Ob/4VoXeSkSc=;
 b=oDlNnaaK/HMIqZK74PUOKtWq88Qx9qmo9pureXDOZlBVAeuaC4LFSTKD/PVPFd8uNuJlmeRuZ2QYrIAx7LUAJWLxsMNs/4ih/S8911g3tvgod6C58/PDAnKKbi4yvz5QxOKI3RlLg32zHKwCqMo8AwXStqfoqWom7w6y8gTL05A=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5117.namprd04.prod.outlook.com
 (2603:10b6:805:93::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.25; Mon, 31 Aug
 2020 13:21:46 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Mon, 31 Aug 2020
 13:21:46 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 12/12] btrfs: Make extent_fiemap take btrfs_iode
Thread-Topic: [PATCH 12/12] btrfs: Make extent_fiemap take btrfs_iode
Thread-Index: AQHWf41ywKSUuAaRbUW7V/MVG+lvww==
Date:   Mon, 31 Aug 2020 13:21:46 +0000
Message-ID: <SN4PR0401MB3598518F378E50B562C436ED9B510@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200831114249.8360-1-nborisov@suse.com>
 <20200831114249.8360-13-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:c51:a08a:7ebe:d4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fc57805-7da7-4d6f-231d-08d84db0cfb8
x-ms-traffictypediagnostic: SN6PR04MB5117:
x-microsoft-antispam-prvs: <SN6PR04MB51173D1E682D2825B698B1ED9B510@SN6PR04MB5117.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xsab6J6QEebi4PnqERHYI9e5ZnSNEURFv1zhxkyu5Swlg5A29LBceOOaubX2V7mI1z4MhCje28n+LoiXxGgTxS/8e5OuchhDkEPvimhUykOL8Otpk89znjq0XmXQEFeTBW+ZmODcnfPFUBkMeyW/PRCtwsCw2AbGk35NBhOP3+3ZFoC/84f0jmHepCfr+et3VLHCHxxqDdBgUXokk0MOlVrBQgu02gLOfv1DBhLYukDwGXtOPspVHvsgCQeu3fXBExd7L6v/AhRCC3T6fppyk5SZ6nUX2kiwAxMeQmt6/Z60EWHooL73xB5a4MNHk++0rn4dBYNSsXqLHpoZaDYplQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(66476007)(86362001)(64756008)(6506007)(71200400001)(8936002)(5660300002)(52536014)(91956017)(478600001)(66446008)(76116006)(186003)(8676002)(66946007)(55016002)(558084003)(66556008)(2906002)(7696005)(33656002)(316002)(9686003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: xJkc3ZOlXvcxUiBA/hjpYp+D9pnyVshwMKYtGZz9SP8mkjge4uBjYYr2CRF8eZgIyBDxdKxAvkIxT+cuCcPYBKuOTpcip+BbBCNn/x6uRXGTJRBJ/xxtXbBpIW1u6lWjPqXhYd2AT0sybnPaSRp7U461evNNty+6WGp/P37Sp6ohkPiX3J4KxxQeC7XCsg9TzrdKiR02bTjnhdg/ETtodjyb5X/QSD/94FLOlN0qLwHjlAw26yPHEdkQX1zaj0zLCbnasWQ0F7eVhfYxXGvesYqUESZR9C0IFrATJbAcl5ipXMd8d+OestcP8aU4q5r5DatphQLx8Ec/++qja6dMou3BPjDU8J84PxlNR7boR6TDtJKTbJqNKHIH2WGonxs7d8HumQ8OGRqNDx1wSejZHzwmloN91eaL70Xu0dBdlabNKU5ttHK88Tv3PDLG2R2l0gYoQWLB7CdcA9RSWK7LB9YfRQGhhoI3Qopw7Q7vc2OeGxbBBAJsYpB2ndNwQ8U3lKVhHVWSjXGr7ZA+cPt8BR7aqicNMfR6lE3ZIUa0sXxacmcY8JKAe7+U4B/+oxdDSLSsIaH2tWs38MBS6+Q6E8139evqIAmYROrsUwbamCy/Hzn2dc2vbFjwZ8HSlTE+b5AAfZVfJ1xDl/bSkD2Zvz/iXs1JkHhoYYElKaO45fnhcFyQYrwM4fDpNwC0b/OLViZbqdmgxebbukuQv/m1iw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fc57805-7da7-4d6f-231d-08d84db0cfb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2020 13:21:46.6349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vq931px47E7GyXFbjNccZa+ctX1spMltctHddlAAsD9EtXGENP0//KVnZfkIFxdleDwehkt1GW4MQtuTzOh0QFJui3cTmYmBw9IDe523O+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5117
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

s/btrfs_iode/btrfs_inode/ in $SUBJECT=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
