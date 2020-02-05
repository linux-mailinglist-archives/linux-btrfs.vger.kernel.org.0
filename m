Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14FD152798
	for <lists+linux-btrfs@lfdr.de>; Wed,  5 Feb 2020 09:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgBEIeP (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Wed, 5 Feb 2020 03:34:15 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59928 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgBEIeP (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Wed, 5 Feb 2020 03:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580891654; x=1612427654;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=oEc3A56iGJsPYBGMCrB8UfzrJwwVdwo9B7QYofBJTP9e0921nnwwEYyn
   xVf3lpfbSCLJ/Oe3s7+aoXvOJf8dtmvyfsSWDUxdZUqG/2aZeHi+z1L0b
   dNN/zJv62xebLwmb6sO4UKWmaOua33AkxbsimH8xXptitNj7V+rZLrzD3
   pfXnl9Q758QWCn6Yv4s9SeSjXVoM+Ezxj2405RMA0Lr6llsZ1zC0U0/H8
   OiNnWxgctt6QNtWbkEoStdkaGARcxxhPaKtE0iSWLt7VTJOytSAlaqJVl
   CXePjliYZ/nu3pXqudKJZFWJG2yV7OSCdG1ICXW2qLlVp/JS+EjH0Hch9
   Q==;
IronPort-SDR: XFNveosUXB3fQ6+7K1oufOKMETcBb+Ogo19vWonEn4zTzyDBSYiekFUuY7yrTND9YPvcErB76f
 TaLSrTZc+cfONRLRkTYM2fEjRQGDhz5r2xiSma1ZucIFnzp4nOEvADo3Z2ABmhLQLAelnESepm
 0pQ/VQmiDjkw9A5bBJTugzjdLJ8GSdeO4JJbPHJWehlq1Cbm31rLLGMIzJC3onfxRO5sW6/VZ5
 dF7Rdc9ItpAqxigNzGFxHkgECJ3tLbGKZ4x6mDyx3w9Hwbpjl+ZLsJDIyMmX+f3ay4Or2aocat
 DSA=
X-IronPort-AV: E=Sophos;i="5.70,405,1574092800"; 
   d="scan'208";a="237100114"
Received: from mail-bl2nam02lp2058.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.58])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2020 16:34:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSvJQRazrOJjBIAocrDMUnny7FqQBz/03c9dcGy5FcHo3OZ5zLoPErbz48jhsbThb8WFLSsaSwIY9aWW/1DfF5w3k+7Tf0TSyTVVyZ8dIfbzYZfD+TgKqk+4oIZdzs+GygTJqeX4z8xHhU1WEzIdG8P2TDAPDCpaQxh2UklV5kFJ/zrTsMxi+2b4rQAwT2e73o48doqkQhE/h/SVQx0RmFVIS82fd4q1Wo+Nop0rnPBlyyRF7xtjz8aHxh8heDk+h7L8si5VspU2VSvbFv/pgYQ0X0b45nI89E1OZZEBub6gNxzVbxIsXbRGd8gMNmBBIgOkxGXMMjCD+cRSThVWMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=d31jFJNfq/MiUH9XGsRnIl01iRmnQfS3J4ZP9c7a7iBc+aU9SU84keKeQmFnxFjHj1knzdjPXtbkS6bMDBdN9edshynXz4Y7Ldlj4iBrCtYNHM8mvi4/KfCVhbvTZUD968LCkUshFVwnWx0QJFI13MDL1+MkjAXI8791H21FL9y0fFobCm5RjA/48RHA/FoRSrcHmM/1wIjeOzn7mG/Vqwqji+aeQQqnBxcUe20obCybZzK4ytkeih+dHwD6QdLF/QMzJG9qGWVVMkXpUe0NqqD7JJjS/8CA/rFhNMSfbV3Dlduvzsign5vcuciFzfnmGgDjWY8GBrY6IME/UCIoww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=znMd4Oe+Sit3A/rPhfu4DdtONj+NQ3yWAwNJex1LZD02hjCr33sIoj05B59Xfy49Nk8KjlIObKkyIJ/Qo9KtdbHE75PBkAQuDQYPSRP3OGz7Gn6ulcs7MT4gxhF2rYG2e8P0N0KCESnpMj6ni98VqZvKllrYRWMJm7U5rr3yFHE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3616.namprd04.prod.outlook.com (10.167.140.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Wed, 5 Feb 2020 08:34:12 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 08:34:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
CC:     Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH 21/23] btrfs: flush delayed refs when trying to reserve
 data space
Thread-Topic: [PATCH 21/23] btrfs: flush delayed refs when trying to reserve
 data space
Thread-Index: AQHV23cKE4a3wzU7JU+19+j3JOcZRA==
Date:   Wed, 5 Feb 2020 08:34:12 +0000
Message-ID: <SN4PR0401MB3598C94605F08BFD823E0CB89B020@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200204161951.764935-1-josef@toxicpanda.com>
 <20200204161951.764935-22-josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02e1be53-5d34-494b-7b51-08d7aa162d6f
x-ms-traffictypediagnostic: SN4PR0401MB3616:
x-microsoft-antispam-prvs: <SN4PR0401MB3616F2094DAE3030ECDA75859B020@SN4PR0401MB3616.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(199004)(189003)(26005)(6506007)(8676002)(86362001)(186003)(81156014)(81166006)(7696005)(8936002)(52536014)(5660300002)(71200400001)(19618925003)(110136005)(2906002)(33656002)(316002)(4326008)(66946007)(66556008)(66476007)(64756008)(558084003)(66446008)(76116006)(91956017)(9686003)(478600001)(4270600006)(55016002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3616;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bs78qy+yKfzIrSyN1Lymc3Nq1z5IL/wv9ZPWlT4bofCArfKQgxYgY86cO5LstYJ/cHjJLfcYdj56fZzlXq7omkDPxhmeJVUXWgYpAxk4bkXT7vjD5iuUt14DI68bY5EHDBxKPYcZmvpP1IoQA2oa4RR7trVCYoh/s06vnfxyuMjuSQdWusqbWVoGR1seP2ERcOLO/k6RGmUcbayDbAbmYzIo34dD2jMyA8Hj/0WPllehEqdqXJGPFN4OYfVG5A/R9cEArvZzmfGcaPnR3RwpQRdcKP1JJak0ukyDuV3TNDDwvsvaH460ap2LW6eYQpapDCwxsmlou28r9PrzLh323gE0fboL7LXw4++jpjjTR40/6VXVOH0BLgTo68iBhciVWzWARntMych4c7TWLveADbTsAMvXAXBm0NbwzsYHeQ205tYvi7eFbsQ0iujVxCC4
x-ms-exchange-antispam-messagedata: ey2/K783/1zsJZvLAXOl0M2OyTqtu7CFnB1bd8hP/tzRlbHIsVpSgJKxLlzvwUB9xGUuuJUW9SNDPbWEtkVtefaEUAWu10LeKHaSqM6lsLwrePejmuKK4KQtOkpTyS5yk1xfxAi3YPuCkJsdGgYg1A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e1be53-5d34-494b-7b51-08d7aa162d6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 08:34:12.2898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jabtMzRdgBuKx+sglNGceDQwhswnTYBxkqyohOx7mApZzkxUJWEzrrab7Q6Z0MPgVXsc/vpn0zjbkB8tC50fxzlCUQt0lKLY7jFkNW+35mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3616
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
