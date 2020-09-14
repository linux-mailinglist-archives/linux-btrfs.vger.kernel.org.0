Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60B72693CE
	for <lists+linux-btrfs@lfdr.de>; Mon, 14 Sep 2020 19:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgINMTc (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 14 Sep 2020 08:19:32 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25210 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgINMGr (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 14 Sep 2020 08:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600085206; x=1631621206;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=gqJxtw26XMcCDTm3K+n7GIo8a2BWVyQXuX7aNbmEkv0/4ste6zaHnEWe
   BinXCkrueo3EffMaIg7iYisemsIwm/gE7xZywWegCoRr9LW0n0+jbkOsm
   pQk9JfkwjxJlCFJUeaxTqAQ/p3t9Mc52b0zWdC5MwEoCy/5EQHgep0hLY
   AXYb4x+mukZGzhNYtq8DVbkCOWeb1/AeLdbFhY7EyLv2Rg9Ho5CqFqInF
   pCkXcj+Mb6kUNjcKYCReOW7lKrahdOlCbCeNJAP67CowODt+0uhPDYnLD
   ztKRg+0ftVlpYKiFpkdgSNYH4ZRa0vNSd6xjIZuPBXyIIWeOK0BwI0C69
   w==;
IronPort-SDR: Rt/vA5s7WGKEZFSZ2jylCgenUrSlWYla7E+JtXsZQxwDwIKNytqvyWCBwpRPXE3PPtH+QRmDed
 hNsjZriBBb1UQ2dDp/mQdo8+uBwc97Ck1N2RRUcgKWyS6nVrO3NyM9A8mpIza2TzBU03RyC/4y
 RU6WawTvlN0lVpc+EvnVIBbiKMCnpSG33McF5lFTP4zcp35LbZG2rUoKpHmfZ69E6hPbrCJ1kc
 B4eY8604PdtCzoUOQA0Td3F35CtEm+l+1IfnSrwbrTXs1tdqHMv9q9tyHQ+0mvXBmcsELtBWkT
 Rwo=
X-IronPort-AV: E=Sophos;i="5.76,426,1592841600"; 
   d="scan'208";a="151665831"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2020 20:06:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MXbEyhNfe6hPM+k3A3C4R6sUD91Fhhfws1U6MGSxiBtZqJsnayyeaQ1pLADirRFVHdZAQzjRlrr3kulPzkXppP/h9hc+aKcZZuUen10p88ZLanMHawyxlj2sSQD6QrJsqpgfWiiGdtAlIdCBSb2DWIBWavpTJoVba145vZCQcNEygAu+95DRcEeZbgMz7df0cm01SUiBgdgELB707KbTEvJZ/fCIcfq5cc7IvqzvR7RgqwEXuXhrTPAi/k4CIFVvefhGSDUKI3zpNzjT4WpjZwK3RV9p7DFpIpVx+F2XaDGAxNf7hxTXjtcdyhFrRmsiCUA1t36i5KDP/KTiOlnrxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=A4fpeZurOo/Iz8rQsltrCmBLZ94Ri5jRX238kiADAPF0S9XEgYQhSfbMttrs/kp3nYgmni9XQgvPvwEFmm+ee37zE5HOB2tvJdd8pBCiXnS22RpMJVQJt0Tn5fG+x+UT/bq7LICtHR+XRdcreafnGAmAM1FyOQZmuvoy+b4l9flfOk/A54tDYaQMZL/t0h1skR2igTyTWsemFZ35IYvQXFAji5jleHdmUZnTz5SN80DQt2KskbQs8N/oPfhg5sE2xLdTSTMIcfNG2fk8Re5dHVM6Aodnu8EHuMoOcBje6T0/+63AO3AGa1ekKPF+ZGAR7gICqgO+WYNzbGreWKdGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=L7JU2uM6uajjUAEiyohqEmFEhxSc8ZPgKBYpWlAFnctHYzncZ/BOZkwHH89u5J7e2FuLP3zITzKZUetwjt+J5zbTbMjhFJW+PDQfvurL0kAnC/rR4DmFSaqp48hniVjNjf22yLoOoSq4mjghMCrlVOXekrpXMDmUryETbGZ0VjE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4542.namprd04.prod.outlook.com
 (2603:10b6:805:ae::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 12:06:44 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 12:06:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "fdmanana@kernel.org" <fdmanana@kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH] btrfs: fix wrong address when faulting in pages in the
 search ioctl
Thread-Topic: [PATCH] btrfs: fix wrong address when faulting in pages in the
 search ioctl
Thread-Index: AQHWim055atHBozQlU+1AAdNBbx0bg==
Date:   Mon, 14 Sep 2020 12:06:44 +0000
Message-ID: <SN4PR0401MB35986202FAA8155A897CD5AD9B230@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <78bf853ef63f2dbd62587bb02bb723fbaa77c198.1600070418.git.fdmanana@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:142d:5701:89b7:64ae:7a10:bbdf]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4d67129e-f5ea-42a1-44bd-08d858a6a62d
x-ms-traffictypediagnostic: SN6PR04MB4542:
x-microsoft-antispam-prvs: <SN6PR04MB45429BA0D0560F35EB4F56979B230@SN6PR04MB4542.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /m//eieCtTsuPFUmoBWiEFBZP0fVdrXEG/E3WmhniXrKkqF07D+/96kEfFruUTZ1u18ciyll2jS2D+50htLXbSGpWfcjQXROyGPOaLsu7VfMEubYwWoYH1Kol2O5ch0kAUJY7UtgYm0QmloBYkijLhFho8YNmszMDKVy72vyXLkrCARzCSsAAWiPBjx5K8NNzmg4nqGFH5oVXEvRBMMTaen57r7Oyk6zg/hTpi3rxooSawin3Yud0tpB8j2dvF/tUUmrGNqDNMXloA64Q7k2pPfBwkUStE5SRHlJAKkLpuoe3bwQ2nlg+ns8zzy3IT+vjODpCVsab4J3rTQtr/YXBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(6506007)(316002)(33656002)(9686003)(55016002)(8936002)(66556008)(76116006)(66476007)(64756008)(5660300002)(2906002)(66946007)(66446008)(4270600006)(91956017)(86362001)(8676002)(186003)(508600001)(110136005)(71200400001)(558084003)(52536014)(7696005)(19618925003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CcpqQARTnHB3BMXmmQJtLaNkVVkF2r37Lp/SXUZ/g3cDlAhosyGT5VhpAW0nt/91LgiyD/Ys14wMyB7D879HTpdSpObCyuVpkzT07JAEoEou2Ay9dQhviujRKkgQO+iU1fvlZWOFPOdwPOzm1K9FwS2d5FisgbJmmcHXsO7lA+cwE5zpw85Weh4zTd9it40G6HG928EBDQ1BL5ZJfRVyxOPEZ2dwJ96G2JV12lG4ib9D/BxZFpTpQv/eFNyAMqRIpwN9gAIQH5Q3qjug9YuyMUqSbo2RYS6/QmsNcavl0XkbCOtZo5ZDye1DERb2hkp9V7dxawSU4pAzWpOUcyCk6ZL5Syj8PANYXVmhQnacXgl7RbSN8+bV/3YKJZ4y9wgeFPH/he2Q6lfrfQw9w0Lk5ZtMQPQFTnKp2PJXsohNcR1+3F96M5jl70hwhs7JJbnw5RKiAuepbICAWD2nxwr40J6Af2ANKOhruyl68hmVzp7V+qgT7Ub+zwJsObmlv8EqJN2GV08YNmUvi8a+MtmSUARbvMryDBzqafkphbqBxMnrWl4VBXs+/x2A0XG4Nw0kwu9jdx6dWCDTSpgqZ/YKckNH2ryQEOAseyljXCoOcXGxniu7xO9du9aYilRnw9oAt8zWF6aCsUFk0wnce+74YeagtGziU+MHvSL+7aITGkfu9PM0BWB8ZSuLwDP1ZFQQlY5c1dCiNqNBDxtor2jrOA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d67129e-f5ea-42a1-44bd-08d858a6a62d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 12:06:44.7415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VLq7dkHbYfy6wV+YqAy6V99HaYScYjo0skMTcn5gHkymIgOhpQS1RmE6EWh+vCuA6dDc8PV6KeHvuuUTSgrwOv0LmT4sWb/1myM+rrr9S54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4542
Sender: linux-btrfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
