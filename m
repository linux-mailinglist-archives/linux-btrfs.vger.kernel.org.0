Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 432421CB0F5
	for <lists+linux-btrfs@lfdr.de>; Fri,  8 May 2020 15:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgEHNuy (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Fri, 8 May 2020 09:50:54 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:43225 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726904AbgEHNuy (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>); Fri, 8 May 2020 09:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588945853; x=1620481853;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G6auOH/Twffrbi6W/kE9Xo0SK1/FL+U7FpdhTYoJ3R8=;
  b=MMoFNLo1tcN1GUfCHtMAOaKGA8o3ZHDSdagHG0hTfyyJOTDfuUkildBp
   5DPcgaPN6sI7sFbJ5JD6WjddKGRlEdHXggjqXHuOmRYM07YM0dBUKJNAa
   3M1waD/4MCGJFanIB7SkCffwRn3lF3uChsh39I2uk7VHRNHiSdWQSgLgQ
   Wh76Cx4A7mX364hsg7Fz9lre+ESuF33OGQBjprdnliRERV154qBc0i2SX
   mHI51NIRabuxeQ/XSxxfnvC+0v6MeTAJwYAeBQReBukleS2xBpjOId5Ka
   kJxLDRnPd2rJuIkxgMxBFMBEPsYaZnxLYVAKYk67XnQKbuSarsD3yEKN6
   g==;
IronPort-SDR: 2G9g4k2Ft4mI0Lsa9r1EherQwkBlocDQMuNig/g0HfMViwFv0xWRZ/km348ie1womdL8VhEAsJ
 fMLn/YDOnkzrtBsumhz6xQxS5lLvBsx9tLZApBy96Qny3igWICoN9DPJWlVYrZBebG1N5izm9z
 zOm+mYGmGzayPUAmTz20W4ZitQE2qPSlAVRJqWCu+yK9+y1qCJJX5wqfjZ9Dn0IP6rWhfEIsDN
 RxCyvhQl7J/kxHjer9RVJVS1M1H/LemWYW1mePYvDvAme2sO5MFCO736gVejRWdyVb40hRahmw
 pXU=
X-IronPort-AV: E=Sophos;i="5.73,367,1583164800"; 
   d="scan'208";a="138659172"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 08 May 2020 21:50:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3Kio53/xL9HyVJvooN4JbiDm4pJpEEasozHP5lr/DUd6d7sTNrah5drCBZkPCdNv/MrPpFGbGggsMOoDV0YNi0CRiK6+lZnXZOJevEh5ww9ddWeuOsARFJbAagEk1jdAMBH+EfrLEiia1nMk9hgzFsfWAluLcLQaJjaBuaqB6u0rTtCZmIk0saE3EYXYYQ9Onva8adKGBEZlmlhbSBPBP9GUmCrnfqXNI2yxsP7m3wTfMSnuqVfuleIZBEBfGrOTIXR/EIQjef95EMWSvC3OQh03tkCwh/2+XZ1tQ1Xitf4TTA6s/loRUtezWiM5dftMCDA4B38A0sFR1uV5A2/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6auOH/Twffrbi6W/kE9Xo0SK1/FL+U7FpdhTYoJ3R8=;
 b=iHuiejFSpgkssjTfDF8Zu20dC1vznMMCx7/rj6jxnmKpVbhLurgx1Ok/xFi+gec0AoHratZexA5yWw6FRgWckLafnfxmjs8wOjWzEhbesbrYZFRy0ULJV0wf5lXpm8xYv6DI1MOPq9rcBf4QJMZuLC1p2N6woKIO7Ap8glLgFTz6o6qABI8Ah0Ds2sh9lQp78lih412AgXxKZmYs0qFoToC6E8EYIm1ZBjFXVWg7YC9rHfyXYKtdPxnoIyhaA60RacI07nAGV/y7TKMBPiAWqcuoVkUS1LxBfwcDE4elW3Tha97jPL4wCUejg71CnsNqPw+7MbsAmftlnFnB265MCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6auOH/Twffrbi6W/kE9Xo0SK1/FL+U7FpdhTYoJ3R8=;
 b=qe5xFLCuGiO6oB99S1tdW0yPWBrmySFqSsGiNZD2RyVWFIntLp04o1ecx7kKa4xFa3fS2trjeiRGNYo8HvGiK/9FWNiDPx+GBCIN8gbYT7Iv73PTgAJ4ZLe6B8Ux6a4oIs2xf9e7jnNaRw82cMWvrR1Mp7Wb5o5NcODbQvj+DSw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.21; Fri, 8 May
 2020 13:50:52 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.028; Fri, 8 May 2020
 13:50:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     David Sterba <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 10/19] btrfs: speed up btrfs_set_token_##bits helpers
Thread-Topic: [PATCH 10/19] btrfs: speed up btrfs_set_token_##bits helpers
Thread-Index: AQHWJK0MBzIYNsnT/kqSqfGLn8InRw==
Date:   Fri, 8 May 2020 13:50:52 +0000
Message-ID: <SN4PR0401MB3598C61E83CACAB99C7C44D69BA20@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1588853772.git.dsterba@suse.com>
 <fafa95a12439369c9e6b323f3c46bbfad9efac1c.1588853772.git.dsterba@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5d0ef786-4e2f-4914-f9b5-08d7f356d29d
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-microsoft-antispam-prvs: <SN4PR0401MB36772C90FF0F5929F62626E99BA20@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 039735BC4E
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L9Ax+YBA3FhrGtgfZhVl92yOmtcG/j4xJ6TfNYWYMVFvzffZFMJMETCvG1TEPcLGaPu5mKsP6ANqXOJVzVPyQrDEHv/hVCEjS2UWBk9YnSm6QAuUMuOyGMTsl4ByFCCCXGf+2WI5OgDqurwcFrOVXMGk4+LB/C6nh3TLNqA+J6J487DEOt/+lsmdziqUYALnEqqsMSQ8v1aEVVl+KYRfk4C+Mk3DimfKSD70irg13xOw4Jhf/b+51MgZXPt6jfaKXqhyfkWe2wjIuCLM2rGcutLGpTNJT2K0PUbgZuiZc01UKBwpYvVr+RxSXkNjKsyKL/JKr7eQl91ocOalZ+t/Uo9mwj+HBwwvSzFBCiVhGT3+OCXJi5LbCtt1GKRfto/x9RutBx6+iO2athRbuvin2Qppi/9PvlrVcDbeYJZadEP0Ux7+5WyJUgQuvAKRKi8GLYus42cQ/mNgv9mlZQgScHIo5FEw59gN0qgKQsTp0Da9kXdIGZgICJkKlkJrgNF7Ekm0IcaRcSFJiDq1RZ/H+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(33430700001)(26005)(8676002)(5660300002)(53546011)(6506007)(33656002)(55016002)(9686003)(110136005)(7696005)(86362001)(558084003)(478600001)(52536014)(66946007)(71200400001)(76116006)(91956017)(83290400001)(33440700001)(2906002)(83300400001)(83280400001)(83310400001)(83320400001)(316002)(186003)(66446008)(66556008)(64756008)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: z46Y5Z+90aRA1CL80hJjIYfxwi+XgR90aYnXiwcaRMoVIjVq7ZaCZ2sQUUVelBV2qVrDeQl9hKUZHlxSky9xjdVLYsv/XulFHV0RhgTCAq3FGw0vu6cKaTuQQG+m/2ZakEFfndy0RDcvNalBmoZHj/hdfv7C2T1tMujfQbhpobc+N1/J4kSPW/xixH1OliKyR/oL2IazKyVcw8thi7zN95rOlXFg+qGH+gH5jJRxHRAWNDccAUX5qyCEcgfaY0iR0rCPLTzGbn9LTbaZFEtaLyeW6eNJ1kQIuC2Dyj3D0TwsfdCuoOzFV9g7/MHiRbuFOEf3fVGgvG2MR2rO8YjDb5cNVbRfAm8yjpdoTiMAKuYGPnLpwPf3Y032bZ5BH3D8rEzKrxE9jJhUNSyrUmiUKISc+SMTjPbXFT5ebZCFW34pNa6C9GxXp6ThUnNiWe0q+x66+xyMFRj/Qk12d2OqAt8cxv7Y5BSZorawi+U3mqZutKAta1OJtVz2PzaM67YP
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0ef786-4e2f-4914-f9b5-08d7f356d29d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2020 13:50:52.1650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 663+oiBclVElG4D6PUDP26tpOSTSZrJxOyw8vXRATj6Q4C2E+UWAgfaUpsd63tWhG2V/v7ht9S8q5OoaIJVw4S4+TivsTv0CrDXcPD7X+n8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

On 07/05/2020 22:21, David Sterba wrote:=0A=
> This is all wasteful. We know the number of bytes to read, 1/2/4/8 and=0A=
=0A=
Same question, s/read/write/?=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
