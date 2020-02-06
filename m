Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3348F15452B
	for <lists+linux-btrfs@lfdr.de>; Thu,  6 Feb 2020 14:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgBFNnS (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 6 Feb 2020 08:43:18 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:22797 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgBFNnS (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Thu, 6 Feb 2020 08:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580996597; x=1612532597;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=nMFZIJRWhsu+H08lbrps2VA544/7OnU4KTAepJ+RvvrQ5XjzDtjugHDg
   xrF8v7qRNTyDE4Ok0bAlWkVb3Fmx+vaX4ZRMM8uyTmJt0Z704yqEc1kmk
   PgEgek2RPodVxof5OsO9t/CICu9rRO+RGLnGXHM64lhAdU3ZHJJTWzVwG
   53woXMt42FR1HIyODVBivuBEhcJtrDSUBWdIiC0WWwlhUB6azuJ1ZtQT6
   bkowfxKuLTMRel/vS74tOeScbY1EpCr4GSTAFwI18huN2HZjEw6nFUj18
   pV9CpvOmxfDpdy8ea4ntzFBeiZE/eGTdnvNtyoWDKegCmbXIpyR/48MmF
   Q==;
IronPort-SDR: ysTzjjffCEizz5Tmy2GwgTNNh2iBzHX/GVfN+t6E2VykYdmcWVkU9g0zD6DE0oQc329x3SZxRz
 Eia61iU4RbE/Wn6MKSubHK1NcQg4sfH5/xWqHQ10nfQIk2K4eFQON9ps3h2wz0BYs0ULWL/nJG
 Pc2bGjUYHCDKLc577mdZ+FzXyL6zC0DGA+N3tgOjM3ERYu/fxE915RRrltD/to/PNowaB2zZxD
 +afkwheGMEBbQbPRF5scCchBJGtqerJBLDpSmjuXNXwNx1SKiZxH4+I2MML31nLMlmBTWyWEce
 lJs=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="129252478"
Received: from mail-bn8nam12lp2175.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.175])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 21:43:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LD14UxxvqzLNGSki+pQtiwXQN8yOQdsE8TGoDks38lscgPWyPVNUjnzrnkDTABVeS3yBnGs4aAk/NCWiOXsSxZMhKCCktvIAfOQe1+D4ZScdVhqY4GuZzVv2owI068e4agPKr/qXizZ1p9IZxQBd3VydoGsOZgoxutt5TAF/MSc7LLwEP18r9HFXTW7ll4ZjCguUjen8ZJstPih4NxZvCL0FaAXVHKmmMEHuYRxOodUeDXLRPwQPMaIGvXAoF1KVV2uHbGMF+h2W6EoudMtTTVH/f1kmw9ETdgqhY+dHDH3KzvPWcpLfmUYbD4a7mGGgRlPi8p8ap2lxrr+Ave0t5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZAREOjbEPyL0VXN4ONDHnsh0ocdzX+uiuSnsEJhJ6SRBHRhP486Cy9mcXYyojdpkJoqvZ0QDql3RLFSetvY2EeT11fKrk1XFpQWbSXmYi/Jv69O8KXhspP02mW3onYnglJ6bWXjLsVaZRU1OA9afUwMADcAmyXRIYkINURbh24ryarbVEygqWrWWkAtpbz9HQyRu/jHm6sxo5wwrvg2dNJfH7xAQByuBB5SvyV4c+Qu8/V8bKerHKWZ5A/uxRqNIooUyudCdg6AwQZ5QMPVtx+1xWOwJ7fwbaQhUAFHCJ3Gb9NkTi8RfE52gE/0c+Q3AFf+3/ClmxFIwNagt0G0kZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ubtednzdnJWugnuygUfrJxEgqkFyMRHDbNY/mOclpQ5zfqR+BAANG21cASdfGi/QaMeobvssR2BI78Fy9zRM0r0QK2HC3YL/NrLUvI7LeAVjtYIxCOGSFHIt/K6s8lqxhlhyogmjIfeU6gy787F5+uJh4qYDKH5YOb3bFewmluY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3566.namprd04.prod.outlook.com (10.167.129.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Thu, 6 Feb 2020 13:43:15 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 13:43:15 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 8/8] btrfs: sink argument tree to __do_readpage
Thread-Topic: [PATCH 8/8] btrfs: sink argument tree to __do_readpage
Thread-Index: AQHV3E999GeRtDXGKUmlGHSJ74TnZg==
Date:   Thu, 6 Feb 2020 13:43:15 +0000
Message-ID: <SN4PR0401MB3598D8C937690A569A66CFC19B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1580925977.git.dsterba@suse.com>
 <e53dfb989393f4561efbb1ae84e407ecfdbfd6f8.1580925977.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d8f3142a-a9f1-4583-396b-08d7ab0a8496
x-ms-traffictypediagnostic: SN4PR0401MB3566:
x-microsoft-antispam-prvs: <SN4PR0401MB356634DFDE7B50DD5E6A04149B1D0@SN4PR0401MB3566.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(189003)(199004)(19618925003)(7696005)(71200400001)(2906002)(9686003)(478600001)(55016002)(558084003)(186003)(26005)(4270600006)(81156014)(6506007)(8936002)(8676002)(86362001)(110136005)(64756008)(316002)(66556008)(76116006)(81166006)(66946007)(91956017)(66476007)(66446008)(52536014)(5660300002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3566;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G1vflfqMG/OnhEuwi50U9FiyUQe6ZxsKpK8Ujimt3VcZTMRzixbcQs0oBghkwG3kICwW7WKQqCe1Tg0YL3vUD+ZtC1SF5Xpz92NA62kmB+HgZKgHoFn/2biwT5z3yDLO1BXxc6jxDeeLKhS+lhd5daeQph+LOeYzQcTiBV+fhelKAK/GRzr1EETeyusp+L2sCSFSIkPdHLtwOmQIhrVps02q/oG2Z9PMqlQLkvNr3TBjNhT40y6qASAFn8oruznCc9XHVDub+tabNNvX394+zttHAuyAq4xgGzCNBJPtsZQ6NW42HjLJWvM9Xd3c9TrSZ7MklwytPJOZ43X27muApcRv6jGJqvoGz3VTBFw45ibGAElnjWYopCprfcgi9tsJ71Vc78wTbT6mClCpNIbvKdpkZyYzTrB7ByrhYZXY0kGWv8qbeSCzLtgle9QCDMvX
x-ms-exchange-antispam-messagedata: LIpncc42yqrOUOu8k28Dl13zxKs189+dUbLf7pTMs8QROk3YfMOAgxeRjsPLLeGez3R/UhxDgqbA9MS0KqhHddMT5oICT+y8YBRoyerYT82H6qQCmG6G7hxNhKuanIjXCRmyZWlnYLkBXehT2NeM4w==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8f3142a-a9f1-4583-396b-08d7ab0a8496
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:43:15.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfUW13HLi7yDPV0+FYXWEpsDUAcllznQe82/ZXBlFkrwEC3rB4RsGIJoxZ9Y23eGlkz2E8ai4x4wF+jlJm9vL3qh8WZ5p9YSR2Qt50R2/MQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3566
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
