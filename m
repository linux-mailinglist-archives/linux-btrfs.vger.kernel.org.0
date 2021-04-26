Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A35C536AEF7
	for <lists+linux-btrfs@lfdr.de>; Mon, 26 Apr 2021 09:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhDZHuR (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Mon, 26 Apr 2021 03:50:17 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23383 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234120AbhDZHto (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Mon, 26 Apr 2021 03:49:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619423343; x=1650959343;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=AFJBBQnCHJ38GvymuOYt+AkNM+Cml2mkGYy0dwBTU7ntv7QXTksBwITr
   Mtmryf9kSKouFI/lz8d7msSt+xmgFF5A8H7zQgYf9+Wj1g5vPdf3mXX+d
   oqxiP1lO1OBuH8/yfny6y9CP15cxsMyCPVZrmZ5mnZBeRdt9q8D819HoW
   hoR2YGYBapF8YkpGIRv7Q1BX2B/pv0/O4t7Xr7lzUGmYQ+97+ykCkTwOW
   ZkCrdqfDHwYhok/6k7rOsdMeQCzTfxwN7w3r5mQWyj2E+zgGZqcC6J+GL
   hrpPpPQEHe7s2F8TWhEN13NTp1Fa4BwxzzHuCFy1od1zyitvWNu7CjyLA
   g==;
IronPort-SDR: /5S03ghAzKG40OUZaCuyvX33e2ITwOZ2tIX6RkJ/RjI1sgKjPQdXYF93pnpuIJqLo6o7c5LGaY
 EnOoSWk8LZcbUpVoP6nvliLvDO4wnZXY3kxXC3poAfUve6oKo/LGbVbqz4Rck2ga3IIDPx474T
 Vushs3+DsrXHf484d3HLS7AwQE7Byy30igoxggBEwYemI64rl+CDgMVyH7N6Crx95pH11JV2SG
 4u+lICaFaWiyoPmKq3gyjrE09j57BMcA3enw1oBWnNM3DHuEN90ZVQRKh4d0biz3KRfxJCriId
 BrU=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="166799222"
Received: from mail-mw2nam12lp2048.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.48])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 15:49:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNj5PHlZGN2iKst8lSg4B5UbxqXJP2yEjNO9y3/9kqs25F2xmmmk/91x6p0j2/cjxCcC25x6YfckX8jJtFhhNcgJ0Ss+LAuFhdj8qncxI2DB1jcVBs2g4CK6cBf+wcFPXv70oru0HmJ69atxsIYuOvU7jrsYFvL49m25WYzDRwHIcBpSgDpz54qvpvy+7MEgCkYOOa3atTcdK4PZk5za0hzNXkScFyLvZ9WuniTZ3r1WFgHzVmzY/XbHqPkoZilGTNGOyofambj66BcizUKTxAp5h5hqVEqHSFXOvkPZl1Pse3Wom7CFenQIvKIGLTCYX0TFAbcOeS68BYXUQhEupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Kq4Ug6pcWF6ZMPbv0pzIQsQCYOlaKPQ2wei9rrwbodu5QXK0SPWrv1ko5vY+72zLCr032mROQUq0CQxO/y9nPEvXWL9dpBB06rmwjha34YN7zUxtHpu2VcRQRcibCWdIZDiDJn5edncYw6TfWMo8sRX+hsVSdtg78TTzZ+AsMAii49YRUgjr7lnOndwK1bWe2FuJIdZHm7kC7VA5qwn7t1MHiaRREEOboBVk3s4Vg6IYTKtbSVgpLPqGPqlsqHXTrmaeuFflXo8Wyv4q+yn9W+NB/9gthoKCvEqC/qYZOoX/LlDK5aq7+qzL5DmZ506bhJ4dAkvLuaxMcCmKjZRiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=qU73c6JXgRlxVcpyKhqae5ztZQwIAoPz00pCQXoKjE1F3VbSKX7V3VrbPmceHjbxIwXcV/738enuShWQ96iTHH5Pkmr58vqlw6ps15sG7tWMLKW6PhrGF+i9eYOcxeCGF20xZntINTxzOso8E1PETnh9OqezN8qr8YFZpECyh/Q=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7382.namprd04.prod.outlook.com (2603:10b6:510:1e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Mon, 26 Apr
 2021 07:49:00 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 07:49:00 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        David Sterba <dsterba@suse.com>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 06/26] btrfs-progs: zoned: check and enable ZONED mode
Thread-Topic: [PATCH 06/26] btrfs-progs: zoned: check and enable ZONED mode
Thread-Index: AQHXOmVqUBu0C1YLXEa6Sxmn8jjEYQ==
Date:   Mon, 26 Apr 2021 07:48:59 +0000
Message-ID: <PH0PR04MB74169425B8CAAC44C2821ACA9B429@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <cover.1619416549.git.naohiro.aota@wdc.com>
 <ce43d7316c67d11e136cb511f2328aac521e8e64.1619416549.git.naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a95228f-d207-410d-a50a-08d90887c104
x-ms-traffictypediagnostic: PH0PR04MB7382:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB738283247B81EFD4579810A09B429@PH0PR04MB7382.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORfqdQNYIwp4UNjxFakgA8qI/kjJKD7Fs1lI/Oi0ADiMel7siz1pmefevesgqlmfC/Le6JCWyDasSy9SsaE4RRcEIgf60fyAYfH+pj7Kb28bYzUOfNP6RM0QVPqbWd+Qq444Uo58Hk4683+asakWMS4dO19RWP5N7mpU6jF0nkon28pv+XSj/C66EsTNSDACv7uNpkEpi1zkXXs474On08kBkx3uyafuJnshXD3urYUiwD022COF3AWGvWzCDNZrqpvxY+ZqDbLDLgH+iPCRwk8ss8BFBMwg6tYO2YsITiR4TSKJFqJrxiu+jcMUT0C/VElPT6BRb/A3Co8pakp3MDDErU7pttIPIcGcK4h9iUztho+2uKaRddkr+fdBrL8IQsLFfHh639PIrlhQS+I0zF+C645aJowx+hOYjgBI1EmVflQ3BkKiVcVIdWJC9kb0IEUXZy0PkHhP7Im+Q/GU+wfNAlIBpFk8toWp10jroLOnDYgoPlYQjdVxeLzb+Os80+q4d2RZD/ol9kFV5nWlWe8ws/hBSIw0xLsqMkg4GxBpdDbkWYtkzMxwPWrBD6d9Z4RAV+cXcT/bmHTG0BcPTpFFBlPTtGYEfyu+K5XWRIg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(76116006)(86362001)(26005)(19618925003)(558084003)(52536014)(122000001)(66556008)(5660300002)(8676002)(66476007)(2906002)(4270600006)(38100700002)(64756008)(66446008)(186003)(55016002)(7696005)(6506007)(478600001)(71200400001)(33656002)(316002)(8936002)(9686003)(110136005)(66946007)(4326008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?14MlzEENbBUOdEx9sQtGZb9Zocqt4CynyZ8BklzW1EbMHqoRKqjT3XQTLR2P?=
 =?us-ascii?Q?sTaBNIrOrs/ouQIH4bsDpLkGArOdrjnHxwWu9fxY8HHDZ/So2B6IZY56vZ9L?=
 =?us-ascii?Q?mPnnZ0FHM9sYpDi4MGyezH/ZK2mhxk7Y3Lvcy9Ck37bRw6cQqMxELkmEkK6O?=
 =?us-ascii?Q?pTKgmV+sX0l8KlRt6ZPRmmPawCdVX8cgHeKfg5YkC7xnkUHB/tXAeo8QjXkj?=
 =?us-ascii?Q?FNtJbsvbbs8FpeC30c8LEOPVB23CDYHvxJZ0Il+0TtkWqRYlpaLbDEbAFycr?=
 =?us-ascii?Q?ph4p4lEgWk14EZ1NZjf+NdjVnIY9JbNUXXma8FB8mGiyMXW9P+AJpuF8jENu?=
 =?us-ascii?Q?4E0JAX/9FsBxNStTo4CIJaHwo7BBNcJbfQafG9mCuyC92Yd87ogw360HO31z?=
 =?us-ascii?Q?KA1a3uCFwWCjnxt5SYum9sjLi48c9MWwHSHlIBLUCe8inlSkHsaTjDZQH25o?=
 =?us-ascii?Q?U9HQZYYGUUpw+U3TZQtUqlcY/8OgMYL6A5UyuW954AjBenNQjcet+OmaGGIW?=
 =?us-ascii?Q?J1Yxq31i8392hNBaasT9FC0bkDwNvgpttkzdcNFS67Lb4UTPNbqEvl45pFNS?=
 =?us-ascii?Q?YyyyhnIJpw3vdfP9iOCQempTX7oyQjJa5EpT1DcDWh0zNXkVzHJgZUGzY90H?=
 =?us-ascii?Q?N4jF1q/v8wL386XQKIWuWNnkcFwmjUtRRO/khRLt+Fwc/NlPV7dPuq6GMAXA?=
 =?us-ascii?Q?dRsoyirTaBiDzzG/qXXNMnvG9jupv6kCQPAXVHyNTHR5N2+J2DVIZAd0Vlgj?=
 =?us-ascii?Q?dSGmeNnyER/6xsDsKnLTzs2pkMrD0umQSN7D54/V57cCRwYML48YGh3t8nWP?=
 =?us-ascii?Q?tQrwgfmsYArN3OYI0+NqBXxqhhehu7XUKfjiG+cd/0dj0C0QbANn24rloSTB?=
 =?us-ascii?Q?m8AYTIqopePmxMMtbk8+eXdbRtacO1nCSkgHUxCRLRe48Le4sWjkDbPf/Cjg?=
 =?us-ascii?Q?HQ5himNs+EVhVI7KRS4+YvkBV9OSWR6gt5pKkvjhbNmVXnVZk0Md0JT4clHZ?=
 =?us-ascii?Q?0g162LuhhvgfMgihNOld8k5gqv+KOwRKE7GMSMHrwWO010oIKdFZ2Hc/Hkol?=
 =?us-ascii?Q?krE3IGKPiKXSy/OXYGmPlY2W2mcU4o0J5uxQHR2/b8rkxnCsqfYzlRZ2qeeD?=
 =?us-ascii?Q?JHjGHuhT6JufkzdEFvLHWJuCipDYIRiMLJqhTKtxHnl4icu6LhWoAvuAlsiQ?=
 =?us-ascii?Q?CxsrrmkaS46Nl1Jgjnwwm8d8zTI0pKdAO1fUG9NElUxVhlg/Db81CkdP6VyP?=
 =?us-ascii?Q?Uql+huZ61jry1phEqFF1PdJsmaHNqyC4dznroAlUAjVeRdauRBP/QhlHwQ2y?=
 =?us-ascii?Q?UE2/3yml0e9n8uTDOlD6AzUHMH2TclWM2PPEtlHs4C6Grw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a95228f-d207-410d-a50a-08d90887c104
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 07:48:59.9658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WK4q2dCp6GSFwkHw92PQaMRtBKcGbDVUr2AZfuwYpossj1xNq6NuhsqNX5J+S5iwaQsSjRBLJD/YACnywadtYUgCH46+01kx8OkRRPhSsh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7382
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
