Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814C628CB1F
	for <lists+linux-btrfs@lfdr.de>; Tue, 13 Oct 2020 11:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732597AbgJMJn3 (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Tue, 13 Oct 2020 05:43:29 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13726 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgJMJn2 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Tue, 13 Oct 2020 05:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602582207; x=1634118207;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SPSQoYLLxUJMxPJswqZWb7mAn3Xjt5qgb0w+vMhbTQg=;
  b=asGBHHaeKWNsqjpxtbb90tT9HODic0b89ZPcb0lMlq8bHBHbRhSFRjdt
   rb8bjIeyNbwHuYvXFDjGEKEKSS0NgQzm2fd61Kv5AWHRopL5aRvg2yhwk
   dzzuVI+ff7gpwroxSYkPnZkSRuH5oJF6k0pB+TMYocdt3UMwjrmz0jKUg
   0IcYshetuMGSVOi3oPkFmAzLvWe7er61QiwoE1d8MQwS053csoFgksCW5
   w57cqN8cqwWqOFO5QT1ckb3UpOwXh5Y6mZGJNki7LXrKOaaikxfRisK2P
   HhiRutdcbPlOBAFm/PocBM8Wer9EnTFABQ86jMZ2xGA3CoWLs8VySqeQ8
   A==;
IronPort-SDR: zLQajnmyeHWfIj51vAuQq9QF9/HzYueWDsY83ntzBvJ6N4UnJQQhEFFljgLN/OV5IwQ4r3y4TG
 aS9JN6z7HeLUtIAA06ZaLwWtLZ9LSIio7itG9mbErQ5kvWS6CZKoR2EjSgLpKGi3Tr5/BksVnm
 rbHe4tVefr9rQZH1DPjfVoZ6hwF9+bgjfXLDEsJR560ij9MchXo9DHYpVhIsWF3dWhCLjClC13
 fDamGGOWECaDH4TlsFqomezSBojxSkToRPi9nnk8gtaBE3LI8GxOgj8XMyaHfyhxR79grxuy5W
 4aU=
X-IronPort-AV: E=Sophos;i="5.77,369,1596470400"; 
   d="scan'208";a="149629404"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2020 17:43:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVtA739U9/SOzrFWrrlyknOLK8cm2c7If0fM/nlXLTjvntaRS8pWEpAr+KuMdefJbkzmdKd0K72GZan66Jw1L9nQ7vJhuPIoy6fPksLyJT/6OqwXYKGRP/anN++NlwHKpL8+OfRG+h91ov4/aDNwgma7HPZvgjV10VTANKOPtwdqJ3YfJ9F/MKKIAVZ7j+k3wCCxmSJvmZkoki62ycOaI372PkAxzo43WIav6/0hqThi0Vvq5FJSY+NXAUFpYT1Pw8hyKzW9wPLWAaCGsZ/ja+8wUZfKhyk7nj5KFu5HDdgMK89EjN3anbAQzsHRejWaoXEpX/5R/B/vo/OEe9Ywvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDDVziRVyHSBQC2jF9zgHe1acJBq7IVV+3Fq1+vy3Cs=;
 b=Mmco6Ms3Wht78XCWk609ztDg0z3fkdIMOS0oEOzQY2gHztzwJ7c90peSUdfE3kRrvZYa/zpLZalp/x4Kgp01myj10TXWpeTmTvvptNI+xtgWEUbSKPyWeFFTsMzBGdp9JxcQZmSf6+WMmJzKYLMMBl0Ch+BTmfeFWE96ZG63Fub+5IRubgTTIxYmW1prwX1VHSWVzeu5iIUyogj3WM3ME5+P6fZzU8Vwvlzp65nGinykb3SvyV8JURJ/go2uROfFBLPlz6FbOzzcGboZi1/Z3FH2bWMVeU6rqAyc4ULr/FEXwst7uYJLxxXpiid7sFLRuPgjb9vP7mCcZQzNeH1c1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDDVziRVyHSBQC2jF9zgHe1acJBq7IVV+3Fq1+vy3Cs=;
 b=DUjb0IFocNtOmXyRf8IqPEWje+gL40zA7YV+gkKV2axJumKu8eHjYTB1vmaIYNclrqeg2RJzRijbNGGv5BNk1zcHI9lYqFZY6KOpKXmq5XIJiXukmSVkLIBXDTJjHehDkyZJcgoqlQzODtmidWjKyiqWN9o9+CSoch7EOSwnQnk=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4320.namprd04.prod.outlook.com
 (2603:10b6:805:3c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Tue, 13 Oct
 2020 09:43:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3455.031; Tue, 13 Oct 2020
 09:43:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Hendrik Friedel <hendrik@friedels.name>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Raid5 Write Hole: Is it worse than in MD?
Thread-Topic: Raid5 Write Hole: Is it worse than in MD?
Thread-Index: AQHWoUQePGCR1texI0y4MiQyhLpZfg==
Date:   Tue, 13 Oct 2020 09:43:25 +0000
Message-ID: <SN4PR0401MB3598F3C8CAC47F1BB28801279B040@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <em46b9d48d-39d4-44bc-9fd7-a08d9a96fca2@ryzen>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: friedels.name; dkim=none (message not signed)
 header.d=none;friedels.name; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: edfb0d10-bb24-435d-1507-08d86f5c6e6a
x-ms-traffictypediagnostic: SN6PR04MB4320:
x-microsoft-antispam-prvs: <SN6PR04MB4320730ECAF55D605CB00ADB9B040@SN6PR04MB4320.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4qvafQ+TfGaClK4ZCfymfdCB63Q3nuH6DZiEuSYGC46nhUacXxqAhmz7bUPDXvOi+oJ00RAAA4nSRwm3VwwhDmVT9hHVHKHAe/SkMw/DG2ncHlSnS0M14V6DJP7eSVmluesNLhBHL7wAJoAcgMGCLH1s+6JHZlnbmuSNmYeHW1rOLLZAo5cFPFjUEdh32UzmKWLRS3KDjDgdY8ya6YshL0g2YufAcedM1Qe8RDIZsjRxHXLNZrs1Bfe70VOPKtmStTjjdUsWUzFlf4N17Kjt89Dvvvz5xQRpaCM3Fm/aS8Ctgr8t9v9zz5lURaRDEpK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(66446008)(64756008)(55016002)(66556008)(52536014)(33656002)(6506007)(53546011)(2906002)(91956017)(86362001)(76116006)(478600001)(66946007)(66476007)(110136005)(8936002)(7696005)(71200400001)(8676002)(4744005)(9686003)(5660300002)(26005)(316002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2L+19zJkhP+QLo+5CXZ1sRguo5KHfPY6saTu4tI70stcoW6ImV6gFa/ImZN4HENhdfI56MOCIqk+7tns0mLMkgVfeCc46LqUttHq+zxRUP6sL6rEeq0PtgtsD7jLYXYg1xEWkfX/5k76aWn0ynNQ3pPis/95+aiMuLU7pwoUmHeQsK9AW1BLkQ479nFASCXof1T4NR5JJT0ejUDK/nLD9QrGosrngkK+IMbB0IjAUvUWnKKM0y55YyaoCuh7n89aQ/mnb0iU9yqhDjugJFXQg4unlmTJc8WWww4Z1A5M7LtkpLxGnHe0YJL85PSvHpAIpvn8p/JCP/Bws42GB+Gk6AMB/vGekxKGdZ3nAdQl92fPD0sF0J/WB/hJKLm83dDzImrNMdTqfEnWpBGTNtXRYtW/4SwJdaBydvWE+BZMtS87KdTmQsKVf6hgIk1yAusapj1yYrw/1jSAjaII0d0viSZt0Q6h8APosHpBwQiNK/aTVtdUsW5UcUDVjrl8+dMz9lHmIQWlH0hfwcppneGXfVdy7oesisZZ20ns57ip75gTn/gHDeqNaXuQo7PRzhxsRSyfRTdd01cuPYHtp7Af+fLfJhlrMoN4w+4U+sZtPIRZmmYQqF6aUeIxjG+F01mED19hOAZ5IBmzkFMqNIDnEQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edfb0d10-bb24-435d-1507-08d86f5c6e6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2020 09:43:25.2036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lmpguN6As1nwov2fcoTzAzGhMUzBxFIqKP6u7SG4X0SbNquKiG4L2+w6gX+4P5v8izxVjROvyJq12ULWaBur4gSn0/ak7dzThPLkM23TxEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4320
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 13/10/2020 11:34, Hendrik Friedel wrote:=0A=
> Whilst the article is focused on the journal as a fix for the write hole =
=0A=
> (by the way: Is that possible with btrfs?), it made me wonder, if the =0A=
> write hole in btrfs is any worse than in md?=0A=
=0A=
Not a direct answer to your question, but IMHO adding a journal isn't the =
=0A=
right fix for btrfs. The correct fix for the write hole (and other problems=
=0A=
we encountered with btrfs raid5/6) would be a raid stripe tree.=0A=
=0A=
This is something I'm currently investigating.=0A=
=0A=
For the other problems of raid56, Zygo once compiled a very comprehensive l=
ist,=0A=
but I don't have the link anymore.=0A=
=0A=
Byte,=0A=
	Johannes=0A=
