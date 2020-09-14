Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C83B268A72
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 13:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgINL7a (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 07:59:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:23366 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgINLpN (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 07:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600083913; x=1631619913;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=rpxmflP6m4Fkf8yRy5fxk4tvlyRcYVv+vnmkGcGFy7j4CV0gDQqxBCwr
   9Le3kgkeZScZk2nf79loN6sOvP3a7LArEql5JgfJq55XqKa1Li8Wj/oLS
   EuXHLjkSFhQo9pef7RAZaDwNTT3CluZkl7KDan5oa+MmKmeyZc18uOyQv
   u1XxZHav5OLqySDIh31qBUMrLR7fQCwkqqpgfI57qmwVoRd33SBWtER7q
   Zci9P1pPTgd5/pTEN1mLedn04uL2YBFLFQc8ENCJq8+TJx9uY9RQAeWhm
   lve1KqsIlUqqflZHnuPzax5UWTKL64ARSvskYRk6V319EVi7mkU6EjQxy
   A==;
IronPort-SDR: Y9QqsPUkjO3C8CcwZw+6hWvjbWoJendAklD2lvguanbyg3gJ8BQsuGY3PHen8HcHqFIlWbA+jb
 GcSKYieSLlAwnDVFTkkixb0AsqpmQCqKyZRNZTyAF8JEHCjoArdEJ8fvmU0mZAu6Uwvr3JRcx+
 2MYEUT1/sbQITDX44a65yn8yByog+tVPeonf1Ttx+6aMRW67kQS1w7NGlIE0/1N7agFQ9rzhLg
 XM5+nEW1P08IDipLNzIhCwvUL+k51WMF+CBzsX8lg41uyOYFHYyuzZTLVpsB7NDLFbmlVRjnul
 gbA=
X-IronPort-AV: E=Sophos;i="5.76,425,1592841600"; 
   d="scan'208";a="151664802"
Received: from mail-dm6nam08lp2049.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.49])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 19:45:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MriOdZXjsForTtZrEE52VRg0TqNU6DMiAnFwSFe8XwcapTvmSEaIvlWBATEzHUqG4kt6mGVPLXBL7v91/7S82WK/E7CLhi5nzgN3aMiMg+4pEZXnWJubl/MrFUKQ16IJGP7XOwTaaxq/2nhLYFBNv5ZkZKS0fz7Pdc/fKMTEXXcIuCLtbhAhK4RbdU3MWUc/ShSdErHbhFbk0Gv7MZjobyiCX5FB6aY/YU4DFUQ9CusVV9y5FjJuV3anvhNVvqT2XgPvvPX+JZg2zZG1qu1LC1jMBwJ4u5ZYb5vTK/G4zv3rO/CIVu7iAZuUKaEFiumm3qR8obD8VxsrEiRJw2fZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=U6C0z0stTGxXFTJZsO1z+FIWE1fhrSk2Grko8+jR7xGhUkcZwZX7YE3rsRBlFglSTwda2Y+5MCyaEZ+KG5YOI/WyQX1saWWR75n3HQSqwZp+7WHV9ZuQkDDmItDge4JTh2tFTzubNyZ+a5d77kDzNT8DkIL73B8ttlGxwYROF44iQSbEBerijADC4YgQOlkPlI3MtH+3VdZ5A8clMiINfkPwKNqRQTYSfohqBILW7JyadNOfd7s/qvbsbIzWuDlSIdm+es1vE8vNalLnfuRtEHCtAXrSi+7+JWR4xDTJM0nj5SsSDdzpCBWjGM8+iOPRp983xVkuF5nPwh2cPp15dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PiB230boSZMu+bwzjioN2JLjN9z+5+/fn/TnxAUWm7YhxjCLQk8YvQDym7vjkd6TrGuUodepQaym9u9fgxHDPBDOMwd9eqZeIIV/e4DCSwMqC5DTCPcMZbesK3/I99qW0p51X+XciRF17jkMPXnMt9EL1B8t8NDonncipRCXkEU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3520.namprd04.prod.outlook.com
 (2603:10b6:803:4e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Mon, 14 Sep
 2020 11:45:08 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 11:45:07 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Nikolay Borisov <nborisov@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: Opencode extent_read_full_page to its sole caller
Thread-Topic: [PATCH] btrfs: Opencode extent_read_full_page to its sole caller
Thread-Index: AQHWiovXtdq4r7x0lEimhh34z3b4hQ==
Date:   Mon, 14 Sep 2020 11:45:07 +0000
Message-ID: <SN4PR0401MB3598E8F75DAC7E478513F5449B230@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200914093711.13523-1-nborisov@suse.com>
 <20200914113916.29852-1-nborisov@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:89b7:64ae:7a10:bbdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 38323475-aa43-4663-079b-08d858a3a12d
x-ms-traffictypediagnostic: SN4PR0401MB3520:
x-microsoft-antispam-prvs: <SN4PR0401MB352072E64E29D98404A94E499B230@SN4PR0401MB3520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /QzcKSh06VmEBW2+IlASdhwkeqqBEts7jv1dNWgtYVE+LRs1n0j0VGx9R9OCQHdzyeGb0m72ewjiiAuGIz8Cgtty2Z5DtdZupieQwWjJriOD2e3crCs1da9SLo6YOak8mMpFFYWpPr9y2wDxT+B3Q0LROdU4Ah/F0lwwtWQGY77iQM7pKZyUTVlZpTl5dd0N37qm2PPymPh6DvhKY+S8fvdOQnCNj75hi5p+sjzU0kCdpnJGMaQrEBqOimIiNCKzwo3piHuJpXRaIGV164zYDYCaSpqNJX52bqJSypiOYsCUltMdeEWtaiKLLANjf5xFh1pDM8wKaoycmLatEbVYqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(4270600006)(7696005)(6506007)(186003)(508600001)(9686003)(55016002)(52536014)(5660300002)(8676002)(66946007)(66476007)(33656002)(66556008)(64756008)(86362001)(66446008)(76116006)(316002)(91956017)(71200400001)(110136005)(558084003)(2906002)(8936002)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: muRGfWEIWF6uJ1G8Djj2H01fnH0eecTT3jzx6nogxoRukacq4/PMihVqk8A2kXLhszi+dT2k8kptIQYq+db7zxgstlVgCNp0xYX2ZYWC9IhuNFOVzvWMxF1QGX3x4W9CvLJfKNigq4WwdP5gc1w4cX8grnTjubysagkjPy8sCVzlS99MqgHBzpKeWlJhq60vZ9NjZJtf7TQtKgyUZSlPqZcNhV896qoaRQalNMCfbZh5LL7tfniLdW6CjtN2ilUhmyvdhJVl61qWyuYnN2V4wLAhCwy/7t8ZUV5XKAwjUB5azKHdDUd1vOlEEHRs9KA9819V/zb1LOhr/ledIKmF089s1fsNHUIasKPSlxybOtKru6dz/5v41EzVCRni0StGWqXRRTSZ/2TuePdDLaBTRp3fv1mroEUojq0/+HvhO0SPrShWcEMMv80fsZUQ7T/DLAQnsv65n6eorZMYt6m7vF+dePxHTIp9pZDzkWlSkxcavXFWsgX27ILIl/jNZDKIICyrA0D8cTzYMXyupspGo6THRx0DsLImTfdMCNY8YNyB3ZAToyJeTYogRIMGuH4fLQnLUe/7Iu/i4F4i9FAZkIRikgKjItg6DAEh+fn82HqFuY1jA1+0ef+6t+FuH2nny/o7yHhiXijktOcnW/aiKYWBC39ek0/z9YhRDPOTQLOYcX3RuYe+5kpt9u1LSPXY3Ir8kV6KgzUxz3IX4APYfw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38323475-aa43-4663-079b-08d858a3a12d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 11:45:07.8162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lWWPCeMr6Ue9222AxqmuFXHOB+KuAz1S6WGjC9Cf1gnRtQfbfGEDJ3RI8kFNqaRNJsEbXTP13E+d8f3zWWxWBkZ0FnrV3ceCwkZ/+I43vQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3520
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
