Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797EC28B31D
	for <lists+linux-btrfs@lfdr.de>; Mon, 12 Oct 2020 12:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbgJLK5l (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 12 Oct 2020 06:57:41 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:33784 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387573AbgJLK5l (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 12 Oct 2020 06:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602500260; x=1634036260;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=r0pia3hhCdbB+oDhcW7sjRztu8YhGK1VaU2DMOnC+qsdLvCzVuWsBTgJ
   sDND3lPkTdssETy7yG6X+guHzxHuOD+3EHoigCbxWS7vcy92uV/egu7Ls
   byg0CpG74B76tECZSgoUxuYeHBZtwKYR5KkVcie2lfIUVddCivKdDfY+O
   XLFh9oS/6aUZvX8kWKR8HGCEhwOCXx+QP/nYi4TnEvNl2WxrhMaJzuKz7
   ZFKnhdjJPy4typms4y511UwHiQ+4i/5dutRauErsJ38nf1MwnR81UNGrB
   62tfLss0HpVhIFKs0+ZGChMCLiYOR3PCPqVTLnPWQkMw1e2yAKaxLgpEl
   g==;
IronPort-SDR: XvZmmQ86sjNzG7XCZPp9lRgMdR2sSh+V5FgZe21oIfYROZHSHc6YwBobdn9gO7S6N5iR7/st9j
 mQ/lWUd+kxytPRpvvHUxdMrY+J01IkSSSO8eCFJZlcht7IDlY7W0J9YXKHx/foDuohe7fGA2KH
 GprwBbw22Kjmw6w1h073iowD8++0XA+5OKE9PFqixUuEZFhaN5+VYccFIeYNqK7kh1qcxQL6KS
 zjNbxjPPSFEtOPAfxZQoqVEwai/cEy0dO2a9zyYXKcc8Jhgtck+CiFaAPZ61Ef+rEY9gDk8wF0
 MSc=
X-IronPort-AV: E=Sophos;i="5.77,366,1596470400"; 
   d="scan'208";a="149536670"
Received: from mail-co1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.52])
  by ob1.hgst.iphmx.com with ESMTP; 12 Oct 2020 18:57:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+hEG3BjaNsi2P9UjwR30BCGp5R6lot0X+TZB7i2YIrvGxkhCoblxic9FxLT7lwA3/DA1UiCmRY3hm9MJQFNfvssVYSljdb9p/bK7J3nzbwddoMigJrETalndbuVWH9xtiijPI1G7Xukuzobbcr54DG+uzg+/8SsHF+DHPf/nHNTCVH+7LPStGXxuE6Ha6z+1CLEZ5DUHZyNJKzupLeWuHCZj4GmLmih0lrHWwxLSAgRTwQdy00vkW0Am1/4TceyPZzTJJ3Y6j7/ysBxyZWZXRRVRGYR2Ao8e8KVbs23PyirbMDlOos5pXOLemZa/f3LVC9DAHcPCFpK9NbHlvWvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=gkRHVBfyBsQ2ii+lLjcne/Nh241EYWowt2djSx2XfCizolUpHLFCOprHvW6Oc6/jlouxuYeKTpZf+MXmJdFIPzemmrWA2XmayoYWYv9Qc1CqzCBdC7XbwQ1ainYGf7u19sVFzQEGY1kCOzX6INMGQEqDKLccWj+XJdLsIcyb8P1HgUKp2GtsqThv3X6dN606VyLnHDq1k6ZcmjWEGXyg2i9WMsC90NQ6iqI14ZFHEdtLyl0zAeOsW69wh9wou5scOv237sBi1MXJNwZ0ZKZ1cHnNp4V5KU+UKtlHctr7NundvZY+EpPNIHRAxIYwXXFQHTws4JxWj0UpX+6ZxLwnlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ov0lkbaq/wiI6YJIxfgliKsyJrxlgoiymIt7B/VhntvlFicz/55ZUc9KltxzBoyElUTVsCLZyQdrjxpTBPmGBKUvy+IbXAa1upvsoCpcE3WPieN4dyI9G8WSVlEppGo9fQbbw2hCvQA3NsBB5JuL/YCy1Hl9uhBI2SfGV7Jo7u8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5168.namprd04.prod.outlook.com
 (2603:10b6:805:9f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 10:57:39 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 10:57:39 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v3 3/8] btrfs: add a supported_rescue_options file to
 sysfs
Thread-Topic: [PATCH v3 3/8] btrfs: add a supported_rescue_options file to
 sysfs
Thread-Index: AQHWnngrdBeZjzEitk+qKWsvILLYow==
Date:   Mon, 12 Oct 2020 10:57:39 +0000
Message-ID: <SN4PR0401MB35987FD7CFF3FDCB94B0F54F9B070@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1602273837.git.josef@toxicpanda.com>
 <8ac207c64e2917d7980570e6c9f696e234baf070.1602273837.git.josef@toxicpanda.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: toxicpanda.com; dkim=none (message not signed)
 header.d=none;toxicpanda.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6e37499f-27f4-4462-ed92-08d86e9da30e
x-ms-traffictypediagnostic: SN6PR04MB5168:
x-microsoft-antispam-prvs: <SN6PR04MB5168E22760E52266DBA59CD89B070@SN6PR04MB5168.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EN+nSOuVrRKclcyHnYAD6SxPGKxLciNxB3q3Crr2bSV2GT3WZ5wIoxTzUAyVLl/5/+PZYViZ+NbHV992JfFEEBD4XfQRspy+7kpL9I+4HjBwB5opaZwccVO2MlJXwf6pJGl98SNjT6R5ODC9T5xF98Axn+qMx4uTBod0jrRtLYLWMZflJ6TRKGa+Cj0non9FClmVFqpIv46/kJi/3wZXYNWDGl8ku/zV0YsWJvd9H7xqwFCmCItexaPi8RR0R63tTH8xvo7jlA+B5c3leUS5L0FwqjTOJJfvDpWpN87IX3mrUeMjoZ5Z8qgVR8R7JQdjTa8oHZ56xxoI5NzwrzPktA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(26005)(2906002)(33656002)(86362001)(8936002)(66946007)(52536014)(5660300002)(6506007)(8676002)(186003)(66476007)(478600001)(558084003)(64756008)(66446008)(66556008)(55016002)(316002)(76116006)(4270600006)(19618925003)(71200400001)(110136005)(91956017)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Eu3WJevWM97jpbLFtEC2tB94DzR1MWIvmrBzNmrnUiFxXG0P8gAGWl2KntufxBMjC2fixLgUeU7yN1LNRXKo68MSt/MP2ledXCatLoKc8tjUvulGukbhu32FJxvegKt3wLaF8vrtBHQXSpf8uzjIBIAcN/3biC0/jelx22ScDmMtEUN5OqN/qe85JboAa6DNFOS/KbBJrA2G8GuDVGyzIHiB8xjsufgpQ33Ldlj0rt1vHd/VL3jrnUnpQ22oAzoTFjKpX83xzwwA32mT73lk6978j22AEFHgZFdaY3GTbtPCzlJQy5DntB8nfbuKrjcTuybW6UCIoFqapa+Ba/4cB1oSWY/WnO446nUkL2Tt4DMIVMOZadnw/5p+whf5TmkHyOZ2ot0Y8MPvwSwYGk18qQb1vd9wc/XvsizCUyV9/Oebff6QBZsnn0x4Zm+adLGO9MR+R3iRTCMUBzltHinZJIGAvSqo6DrtWc7BtZuRo52GN1jX5mJq5O+gWJdYLBSnMHVMkwyDY44qijjSPipWAnftz9SjWxm2g73h2USnUq7omd6MGdy/j3NTG6DI8uHppdDJ4X241YUBPk/DFQjyJIN5ro4JQgRLmRJ77NClW+3z8NfU+Ot1cJ1rrdwJO0DrfJGLO3yMho28FP1mktvgMQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e37499f-27f4-4462-ed92-08d86e9da30e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2020 10:57:39.5701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pqFvh4eKYYEzWMWU6zAtywCNVRC2J1u7sjXQOlSunQPewtMomxKppk32S348l11v9r8NcUKscXMmi1RsOBA7+2y1Gq/Kck9WdQWIkd4PRU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5168
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
