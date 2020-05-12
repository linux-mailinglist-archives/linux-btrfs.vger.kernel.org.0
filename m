Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1386C1CEEC6
	for <lists+linux-btrfs@lfdr.de>; Tue, 12 May 2020 10:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbgELIF4 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 12 May 2020 04:05:56 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:38988 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgELIF4 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 12 May 2020 04:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589270755; x=1620806755;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=o58M8Glt24wc0cswjJr/8Q9Cm3h1rZOxckOvesUl6VbKAvXK34Nok+3b
   NEKC0nfT/PiLg26n83fG48XfkPUKHOCR0J++j01tAFa9pP31ZHcI75s/2
   WjfYGCkt18egnoxLAESaPuG19DDUyWuwH7risx3ld+yQJG+yicHuEvOGn
   miy82ii4If6DDpWc4rUdyuVoQG2Kx3vPPJ6YUOC0Cri7qPZrVmMuVHl4L
   U5qgh0wHFTHufxZbUj+v6jxtvoiUsoC90AtD4UQB5zcULwyoooBKVNnHh
   0c5us/NTf+MzDIPBbSBYxgJZctmUCEL2IcbcdbF9ibGqeut+LdnG7FMCE
   w==;
IronPort-SDR: D3Hz8JXiRSSox84xouLQ9G62WfrrSgo0BnML4I3l/wZNi0WR1OIgpD2zDSSEzJQIw81jA4/k16
 dZFnU9XTj1yfHACnijQPSv0Bg9U8Ftbpy8G0YmOo4GNYCt+XhHdwJCTQF/VtSrLjAzgO5XZHkW
 hAcMKtj1amcfNUwePhwkhJeShEbdL9hiN53olDa3WW/x0Us6mIZBMNo26JuBjMAViG30gPfzOQ
 pagQuXJdXSItn3gZBweA83BNJrh8hsbB8M/eZIt+a9WhtWJ3eNZ+pu+IPLOJFq09k2LESYedZb
 K6Q=
X-IronPort-AV: E=Sophos;i="5.73,383,1583164800"; 
   d="scan'208";a="137474606"
Received: from mail-mw2nam10lp2103.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.103])
  by ob1.hgst.iphmx.com with ESMTP; 12 May 2020 16:05:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNHKsD/Frm9hI8CEo0upUVmoRAsMZtF1gteSKkjM/RPfV8HqdFFZmVgbopxCT3hCgDWQhSEchJuXW+SY5Bhe20rzvtQB+MbkuANtZ6BesXOyHSGfzoAuDCWL/JiVU+GOvKNJL9NZ8lN/CneAkntTewzPfG1setE8D0hR1tSrhmLrU3UaRzAozVO0vV8c2Jp9rnaEplR8FTpfXG2zxCWdl2aWDB5cuHISzAn4Z9CJra0K6T/2u5TpesxZPX4Teutq5Q6yB3W4NsRez8+dvvhet3c38aaa39/VK97/vLuzBYElaARTfSGzaAPQovWNUy+6ZK3sNlOW7rwwyaUCP8vgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=JwPuXcAanmJSJGdJH8SmOEZxqzCOZy69Uwb9B9PhuHvhZR6/dANZTvxo2Qp7sxCUuAmJYCJxlBbmmhCqRizzNH0ACbqQBKZltR/U4qDWQ4WBpVUMU1ejyZuRZa2Y5nA5LGYvdpVlCiQtOm57SstriAqrSoukAxh9Um6Ns9z5QeSmvn6wKxaOwlY811xooaBuG52gr2/DSm0JkUAxhcL00PKoa7wGC+0SA2GvDRqNI/edR/8yKYH8faTp6mMmuQFgg+ppOq4d1Tzbei0COlOjrgtEMUi4MMUoOmkI/My+OfVq8gCz2sDOWAtbu5esWGaftxJTrwWjiw98cInj3oV3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YvtjjG/JARPNRV+3kCaRGd6oRKHSZXCEc5p8E7X0Iip8G7hb162Jo0xZzwfm6JlC7trXrKLgZxEkyR1Li5eXcs+MW/wWciROwmSpakC2k/XNX5UgxdwJ0p9sjKl8W7JX9MjY09hSs5W1mcl3l6pFnNaZvrffTvN7Hcy58cFTuro=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3680.namprd04.prod.outlook.com
 (2603:10b6:803:4e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.35; Tue, 12 May
 2020 08:05:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 08:05:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] btrfs: Remove duplicated include in block-group.c
Thread-Topic: [PATCH] btrfs: Remove duplicated include in block-group.c
Thread-Index: AQHWKBEvN1G+j4KaqUe0qFznd+ePsQ==
Date:   Tue, 12 May 2020 08:05:53 +0000
Message-ID: <SN4PR0401MB35982F8EB5807CA37E64B5A59BBE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <1589255703-7193-1-git-send-email-yangtiezhu@loongson.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: loongson.cn; dkim=none (message not signed)
 header.d=none;loongson.cn; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 559dfa2e-ea20-4fa0-7005-08d7f64b4a9f
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-microsoft-antispam-prvs: <SN4PR0401MB36808D8B2B4B794F172937FD9BBE0@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JQTtjesDmubHZMICccHhOYfQ8/4apIFrkEl7QYrVhixd8hKQauwpvPA9aH4TRaFbQ5VSmZ1z9UO2J+edYwx4DoHTWuT/XOVUbUtLhwKySXcZ/DrnHl9jAP4iUKzs83y8dqtTnCiYUXgVpmZwO4MDP0GZE2r+tPePF+IXyCujvq1W2BiERGI/wEGGurpgnMOWJz6BaF3ogtySBvUD49iIIOC+Yp0Bp3DhVqvenGUPPjvDrn9XHC2L+/mbHnpJjxgbY0gxoq0Fgw7lEuMVI1oHAjty/iglTRoFxLysFchN0FJxr95EIE/+bB89nWk9fnCF4wtOphW62cuaTXRMv+1TUK6eh3H75a29F7zScmoErCvyarCarAg/aqWoV92Jrh5GNcSg7+sK7wSL9dqw1UtK+G3jvFBZFZ10IBcneZQAoqeT9ES0k+TsUf5TFAuOKAYv3BTXJeN8DQhJ2FLUdyW2BPqATgtNumRLRTewFNTjV9p3+MhICuUs/5RSF4RYQ3ovU++tDu/AdG1jCT1PVAvQMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(33430700001)(64756008)(66446008)(4326008)(478600001)(66556008)(8936002)(110136005)(66946007)(52536014)(33656002)(86362001)(8676002)(2906002)(4270600006)(19618925003)(5660300002)(26005)(6506007)(558084003)(91956017)(54906003)(55016002)(76116006)(71200400001)(7696005)(186003)(66476007)(33440700001)(9686003)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AwzKCq0dIge2hx2dOUOnAEpQA2kX+SOgETkG0WnCxsJLf96nVX5xHJKFUCy2kv672cwW1yUyrZuduScZEQgNm2UseSgSrU9nOlG5EqKUE/FDjTggjyXrbeBGwBRUORoX7oyAq1EQwLQdyw6kZFlLca1nZwT7vrTKcCLjSgN/i/gk6nxbVQSFvAxjSn0M1cH0iDG7A7wswX0aLRjW4NApH9vGVwfNRUewIDw3+nAwWCIUQyGcze4AnbYpyhXqfuLspq4ud42EscwluN1A6rWO1Efxxj2J+ed4NsBClXbOAZYNG8E5oPdvWvDzfUJkA+E2U73FXe1oTAU01bCcN2a3ABCSwHUF+dy7qAOEc+siiG3Vmxd5W9iR1ENXvs5gzCYvyxFTCYr8jq/Zm7DU5fhg2eoH/V4UysIg6mRpChWsQjow1qLixYWtoIyMC3rJ3ww7hHPtoF+olVaKy9qAxgSfxR6pnZgXS5gnwgs9YF+O6wLh3tyjC0tsP4eEJkjPrCjz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559dfa2e-ea20-4fa0-7005-08d7f64b4a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 08:05:53.0407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Cl0vytp7HRghcL5uIPYjp7TF01DYSdxQmlXllZLobLRTTD1e5fDdyI7GFu48tngHvXM3BGMgLxAOt0ZDPf8KoyakSI+L8eDNCQalpXuJPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
