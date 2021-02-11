Return-Path: <linux-btrfs-owner@vger.kernel.org>
X-Original-To: lists+linux-btrfs@lfdr.de
Delivered-To: lists+linux-btrfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9B20318C23
	for <lists+linux-btrfs@lfdr.de>; Thu, 11 Feb 2021 14:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhBKNdg (ORCPT <rfc822;lists+linux-btrfs@lfdr.de>);
        Thu, 11 Feb 2021 08:33:36 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:12597 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhBKNb3 (ORCPT
        <rfc822;linux-btrfs@vger.kernel.org>);
        Thu, 11 Feb 2021 08:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1613050285; x=1644586285;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=IdOg+2wtI9t6KXcLIvZwgv8lKg4mu0j1J8cgohm2LURXqqH/z+Mb+Fez
   97x6iM3nNefzpOac+3LASLVhGC4r18YA3rVZB+Vjrwrl50hW7pDMwKyG6
   49orzYquiXygjGqxlIQcpoVrm6+Bic/OSt0xtB3UeROlPYhJhok5dXx7p
   2xUwSfMdGWpNQIgclb5QfogtkJiTi0rsU1qtsGEuN/mVbaWrOz4TDlQPY
   ziTQAOBo3uOnzrOzSBVmy/q/fZhO10HW9SpORP43vznsaSi5IUG5H6yro
   +wK7M8HGNL5+zLFtUo984Q8Vwf+hEnlMQIlLk58H7852ignQ+uGDk/GO1
   w==;
IronPort-SDR: Y1AoLWEinFrGKNmcbyORNSOqlR0nRevIv7bG6N9yRU+bHRrQAeyLM+9/exiesv/e+nn/NbdpGe
 ONXGFWyC4tHD9Qqx+ySKHyyf5H58MU0lmHQo7I3kfRYPbbZqom0dZD0x2kWgr84SVftBkz6mUS
 Yzp/zBiA2QZBeEVAWFvJSwdcA0QhHF3rMiNoNs9tHSuhKoRzPfSVnncMI3D9ByKHy038tyLy0S
 da2teyr/9Ar+AdNFiOY6t3XxANgLxe1pwq3yNqzyMJULVk3xKpNYzdvwpGsu/XQutrb2sIkDny
 GAI=
X-IronPort-AV: E=Sophos;i="5.81,170,1610380800"; 
   d="scan'208";a="159744789"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 Feb 2021 21:30:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGyoNhv8W4V3v8XM+h7nryoS6s4VsjZK/x5TH84Vn9hTx4RBX996XHfM+oieL0G9JamjB6Yo/veJYusR9WdduuIa9ubORJOfgCN1Nyq7D8OJTSjKBZEKfprmmnPP/2tUhPjP4qqQEC5l+4kZNCnbuvy2Krw4o4X8cF/0kzxSpYKXVBrzVsx1818iCv4/jf9+BhwCIcFoooHwTG2/4oc4EW0vuMDVpP5iE1vuc0pfbDc5RQFNsxvBNpkZHQIg3rbXQjFJqzq1ceL9yek4nl1R6Zf44rMIcHpwaNSPxDfPxUzleq3vPIFJZSh2Z2z/AkVJJ+Gewpz06/yf1acc4Dn4aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BDesyT8edwDbEfFbHULXR4XXyfMvHvv3N9lI+mPCrfPd+0ZBiKbnthgT36t+9gYchAcQtGP1KQwNLoofkBlRFMRKn/i1KVph3Q9NQncA8dqKPeAnc3P639KJwm07hWdv90pNyPtwHLBccWNH4t6MKV7gcxwo/DgzmJQkhkFw7GXjSBkJm0dhLws1Rn8lUb6j/f6Y/g1at3Zv1vD1nxyrWBnWf6OTg04MK66wWzndKFogPy3fUIcDXuZmqQ6Q2CktY0UUYf+1j/v7ov6zZ6smqagiFNARmUtZx2C/2leZNseTg211DoadM/40W394cYoCXjBxncKuwAKM5acaOLQw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GYSqqV3wPCzZhL/yRvFoAS+ij7UzXw8+FOTbDkvcOGbDhNzE0shSTPctdlBlzdIr65sslBMJQ46x0hGC14R+btcQ1ct2cxPMPMA9Qm9PH+dClcSz7Kl9W7MCyIVxrjSplloqiiGn05LaHpkV44v5KMyW7Sgi3/cF+/ItlxcSw5Q=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4606.namprd04.prod.outlook.com
 (2603:10b6:805:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 11 Feb
 2021 13:30:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3846.029; Thu, 11 Feb 2021
 13:30:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Anand Jain <anand.jain@oracle.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
CC:     "josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [PATCH 5/5] btrfs: scrub_checksum_data() drop its function
 declaration
Thread-Topic: [PATCH 5/5] btrfs: scrub_checksum_data() drop its function
 declaration
Thread-Index: AQHXADapECxLvCaTa0eFYPDDAMlJJQ==
Date:   Thu, 11 Feb 2021 13:30:19 +0000
Message-ID: <SN4PR0401MB3598F76196EDC21FC685842A9B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <cover.1613019838.git.anand.jain@oracle.com>
 <46c9cb7e4a50fc9c40d7dea000f5285e5997124f.1613019838.git.anand.jain@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f70b67b5-7542-4d5f-42a3-08d8ce912d0c
x-ms-traffictypediagnostic: SN6PR04MB4606:
x-microsoft-antispam-prvs: <SN6PR04MB4606E6597D7D55D63E20E6DA9B8C9@SN6PR04MB4606.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KF/MEyAvbQHYHMTtfs3Y2PcIVawYQ1IMT6hOYUtXlI+mtSl/P8LCxFzoDVvIgVRnQeKVnlVso4HRdQ6sdc9YH4Tbmg1GMVt8nPpNlbVKFtcX1PBXq5GNSXRGODTTr54T+RoS0k7rQJXU1pVfIVifbzmbY38KVCxhymb1DSlpm9WZdHk6I0gx/pNBPP/GM5Z2Ys3las9VeUH9Q44L6ddLYzqnA/NwZTBPZuesplpLkdUeNpYoxQtkuKwDKizCaGYPIOeKusstN+zyuIPRLpvTnAd8HwNnmquPI120sxz+fvNzTAvEKb++3zTML86aq/CICJvUYMLa8cEIKuMN6PVXM/POvRUa5S5jMz8CWVpq6aZn1eg17A+eOU8OcGR4zUr3RSAaZTMd6aSFVyEF5R9SnsplRk/O37rWLGkGp7maZgftZkup+KWNo+x8ibDkD5g8k/tKzimuZQy7q7nqOseu9hhIOvCk/YSQsQJQFP5sOHKM7GaHxvkBBqvJ3ejR1GAP2H0bHDPoapye9ARUsd4sIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(55016002)(9686003)(6506007)(66476007)(4270600006)(91956017)(4326008)(66556008)(7696005)(19618925003)(316002)(558084003)(26005)(2906002)(110136005)(8936002)(64756008)(33656002)(86362001)(5660300002)(66946007)(8676002)(478600001)(52536014)(66446008)(186003)(71200400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1/Lb3kIges9zgcnegnsPFKriGyUBys4FR3zN8hl1Ht6wacmPcoWcwng9131p?=
 =?us-ascii?Q?sU3duGrQx4JbUBXjndX11CSFMqZiFb4Lobt+SV8LYhrRamxR3LLzzO4GTN6m?=
 =?us-ascii?Q?OasOEKbnml2kLubZuecY3nvU9WCecPL8ZVaz96jRmdLvzkthGWzGY72/nyWy?=
 =?us-ascii?Q?zri2iVy/5KQY1zG7kMdrApeqcjgwEGkJto9f2NTFe2gx7de6NsFfToBNHEu3?=
 =?us-ascii?Q?15iSOAjyCYC2MyWJnk8FHAfi1LNVsgmlINHr0SAgLlHFiwEpWoaXMG3kUUoq?=
 =?us-ascii?Q?G3TKfrA01zyQ6k3eiiEb95Eioq+qEL3x4IyGcT8v3g1IwAyX/+bgkDLJ7W4h?=
 =?us-ascii?Q?8amAIvhOsMFkpjitsuJXAE+FwiOiGOES9K8Qpm3hVzUvKsZG9yaJavrjYwjk?=
 =?us-ascii?Q?kCfHlj8gwGkViUFwJ/8NQUsSvUai6ncXOAy42VRJHVJNCYrCSwifrhx9gusR?=
 =?us-ascii?Q?pkFKtXUHtbJHrx2AwdxHB/JA1LXyrn7WvAgIOd92q+/tTP0gCj8R+IAe6hWK?=
 =?us-ascii?Q?4PTNvAcKwQ812Z60p2Rn5kF3mS6KoQ8lnjdoRrg4zW2wRDJJcMWyKDIILwD2?=
 =?us-ascii?Q?1xWI7slSj6as66+6+QMgYrw1tUDRvkH1wGpHri0Be7nqbi9UrJzfIqjiZx2h?=
 =?us-ascii?Q?esFGezDfSNAw3HB9tSGoH5R2znw7cz8OEadgUE/ybewboAlQXydkqKgc1yJD?=
 =?us-ascii?Q?B/Tv/ZmicYrwl58rwrGxgA6wu+Tm8+m/cs2n5plwt2JaQt2EV/dR8/NseO2J?=
 =?us-ascii?Q?DoKA2pRLKSt8nLePZ8s15k5x5ImF1aq4mCYV3pFhqlQHGC0Uk3y3cgGli+k9?=
 =?us-ascii?Q?2S4o8CagD0PYhyBmcEXgCbWG2urTEdkE1pIgyYW4dbuY5tWc30diRzdPiEgA?=
 =?us-ascii?Q?wkJGtSxJQ47B2NnB4MTY/5NjxyuccQgN1D/bY5EIPs7mnBngjPfR+nPTc18h?=
 =?us-ascii?Q?NEY5dis87ileXUEp1yyAKxZgFmO1SGMqPVeD+aULdaGqL6eQYIfch9EebuQm?=
 =?us-ascii?Q?4FMHt9+OMVn23Bvi/lnvjaqWWj78J+hMmoNRz+cjz6kxwnWXijMg1qkleVNY?=
 =?us-ascii?Q?+6/VqkOLxLMnj9Hsiiyv9OBsJP7wv7vg+neBcWWsj9Cb7v80LXaoWhhOkLWI?=
 =?us-ascii?Q?t1YT0g17Dz5tW/65Wq7Lg7i0j+BKal92KaWXD7nsk3Kmfg1ovO0cMWF+ttbe?=
 =?us-ascii?Q?qZctzWfpuDZUP+WGjgQgy72qlAdEaXiCIsKyx8NemQ2rorFMNERiknDOV9Co?=
 =?us-ascii?Q?2uFv4LR2TKWwWsc9OBKOEWgOEI2H5cRtg+cRhkz9KTqszzlYA7btw0pNWPWo?=
 =?us-ascii?Q?3WGZsL9hppQgbjZEvuKzZNWGgWMfHtLAMjy5FkcMhuaINg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70b67b5-7542-4d5f-42a3-08d8ce912d0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 13:30:19.3373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmlG+Rq+caW5fs6zq3WwyZqz7ckh0WOHCeHKhokGH/QJUExSlnay1GjILsI7WYHnM3tMQhXiutWw1+k3HQVnyXFFjVoKmFsh6avd1SmZD80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4606
Precedence: bulk
List-ID: <linux-btrfs.vger.kernel.org>
X-Mailing-List: linux-btrfs@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
